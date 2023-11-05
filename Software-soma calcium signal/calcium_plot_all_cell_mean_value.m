% only for 1002 !!!!!!!!!!!!!!!!!!!!!!!!!
function calcium_plot_all_cell_mean_value(pathname,results_directory,cell_trigger_ind,neworder)

txt_files = dir([pathname '/*.txt']);
newfile=[results_directory '\pcolor'];
mkdir(newfile)
figures_directory=fullfile(results_directory,pathname(end));
     if exist(figures_directory,'dir')~=7
        mkdir(figures_directory);
        figures_visibility='on'; % either 'on' or 'off' (in any case figures are saved)
     end
    figures_visibility='on'; 

data_filenames = cell(0);
stimulate_filenames = cell(0);
ci = 0;
for ii = 1:length(txt_files)
    filename = txt_files(ii).name;
    if length(filename)==7 
        ci = ci+1;
        data_filenames{ci} = filename;
        stimulate_filenames{ci} = [filename(1:end-4) '_s.txt'];
    end        
end

Fs_cal = 1/0.1002;    %????????                            
Fs_cal_stim=10000;% ??????????

threshold = 5;
calclium_transient_extract_all = cell([length(data_filenames) 1]);
for ii = 1:length(data_filenames)
    a = importdata([pathname '/' data_filenames{ii}]);
       if isstruct(a)
        CalciumData = a.data;
    else
        CalciumData = a;
    end
    CalciumTime = (0:size(CalciumData,1)-1)/Fs_cal;
    
    b = importdata([pathname '/' stimulate_filenames{ii}]);
    if isstruct(b)
        StimulusData=b.data(:,2);
     else
        StimulusData=b(:,2);
    end
    
    Time_before_baseline=0;  %round(Fs_cal);% ???5??????
    Time_after_stimu=round(1*Fs_cal);% ???20???????
    Time_before=round(0.2*Fs_cal); %  before select 1 seconds for caculating the baseline
    Time_after=round(1*Fs_cal);  %  after select 2 seconds for caculating the signal 
  
        calclium_stimu_Time=(0:length(StimulusData)-1)/Fs_cal_stim;
        PosAbove=find(StimulusData>threshold);  
        PosAboveDiff=diff(PosAbove); 
        PosAboveDoubleDiff=diff(PosAboveDiff);
        FirstPointOfPos=find(PosAboveDoubleDiff>1*Fs_cal)+2;
        TriggerPositions=PosAbove([1 FirstPointOfPos'])-1;
        TriggerTime_cal=calclium_stimu_Time(TriggerPositions(TriggerPositions>0));
        TriggerTime_cal=TriggerTime_cal(TriggerTime_cal>0.1); 

    calclium_transient_extract_one_cell_one_txt = [];
   for cellNum=1:size(CalciumData,2)    %%%%%% group C ???????
        calclium_transient = CalciumData(:,cellNum);
       for ind = 1:length(TriggerTime_cal)
        %  for ind = cell_trigger_ind    %%%%%%%%%%%%%%%%想画出的刺激
            calclium_transient_extract = [];
            temp1_cal = TriggerTime_cal(ind);
            temp2=CalciumTime-temp1_cal;
            [stimui,ind2] = min(temp2(temp2>0));
            ind3 = ind2+length(temp2)-length(temp2(temp2>0)); 
            calclium_transient_extract = calclium_transient(max(1,ind3-Time_before):min(length(calclium_transient),ind3+Time_after-1));%the original signal
            %
            data_baseline = prctile(calclium_transient_extract(Time_before_baseline+1:Time_before),10);      
            data_peak=prctile(calclium_transient_extract(Time_before+1:Time_before+Time_after_stimu),90); 
            data_deltaFf(cellNum,ind)=data_peak-data_baseline;
            calclium_transient_extract_one_cell_one_txt = [calclium_transient_extract_one_cell_one_txt calclium_transient_extract];
        end
   end     
    calclium_transient_extract_all{ii} = calclium_transient_extract_one_cell_one_txt;   
end
close all;
cell_num = size(CalciumData,2);
%cell_num =length(cell_trigger_ind);

frea_all = zeros([cell_num,size(calclium_transient_extract_all{1},2)/cell_num]);
calcium_dff=zeros([cell_num,size(calclium_transient_extract_all{1},2)/cell_num]);
for frea_ii = 1:length(calclium_transient_extract_all)
    data_freq = calclium_transient_extract_all{frea_ii}; %each frequecy
     ind = size(data_freq,2)/cell_num;
     for cii = 1:cell_num  %%%%%%%%%%%%%画全部细胞
         
           data_temp = data_freq(:,(cii-1)*ind+1:cii*ind);
           data_temp=data_temp(:,cell_trigger_ind);
           data_temp_mean = mean(data_temp,2);    
           data_temp_baseline = mean(data_temp(1:Time_before,:));
           data_temp_stimulate = data_temp(Time_before+1:end,:);    %later add detection !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
           
           data_temp_stimulate = bsxfun(@minus,data_temp_stimulate,data_temp_baseline);
           
           data_integera_temp  = mean(trapz(data_temp_stimulate)); 
           % data_temp_baseline = data_temp(1:);
           data_baseline = prctile(data_temp_mean(Time_before_baseline+1:Time_before),10);      
           data_peak=prctile(data_temp_mean(Time_before+1:Time_before+Time_after_stimu),90); 
           calcium_dff(cii,frea_ii)=data_peak-data_baseline;
           
           frea_all(cii,frea_ii) = data_integera_temp;
                
%         h = figure(1);
%         set(h,'Visible','off');
%         cla;
%         hold on;
%         plot((0:size(data_temp,1)-1)/Fs_cal , data_temp,'color',[220 220 220]/255);
%         line([1 1],[min(data_temp(:)) max(data_temp(:))],'LineStyle','--','LineWidth',0.5,'color',[156 156 156]/255);     
%         plot((0:size(data_temp,1)-1)/Fs_cal ,data_temp_mean,'color','k');
%         set(gca,'ylim',[0 1]); %%%%%%%%%%%%%%%%%%% y轴        
        data_temp=[data_temp,data_temp_mean];
        
        
%         saveas(h,fullfile(figures_directory,['calcium transient_cellNum_' num2str(cii) '_frequency_' num2str(frea_ii)]),'png') ;
%         saveas(h,fullfile(figures_directory,['calcium transient_cellNum_' num2str(cii) '_frequency_' num2str(frea_ii)]),'epsc') ;
%        save([figures_directory '\' 'calcium transient_cellNum_' num2str(cii) '_frequency_' num2str(frea_ii) '.txt'],'-ascii','data_temp');
     end
    
end
[~,ind_order]=sort(neworder,'ascend');
data_deltaFf=data_deltaFf(:,ind_order);
save([figures_directory '\' filename(1)  '_calcium_deltaFF_all.txt'],'-ascii','data_deltaFf');
save([figures_directory '\' filename(1)  '_calcium_deltaFF_all.mat'],'data_deltaFf');
save([newfile '\' filename(1)  '_calcium_deltaFF_all.mat'],'data_deltaFf');



