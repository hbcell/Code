% only for 1002 !!!!!!!!!!!!!!!!!!!!!!!!!
function [calcium_dff,calcium_dff_std,data_new_mean_all_trials_cell,data_new_trials_value]=calcium_plot_all_cell_mean_trace_in_line(results_directory,pathname,cell_num,stimuli_order,focus_name_now,fig_y,Fs_cal,time)

txt_files = dir([pathname '/*.txt']);
figures_directory=results_directory;
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
                     
Fs_cal_stim=12000;% ??????????
  
threshold = 2;
cell_trigger_ind=1:11;   %%%%%%%%%%%%%%%%%%%%%%改一下，

calclium_transient_extract_all = cell([length(data_filenames) 1]);
for ii = 1:length(data_filenames)
    a = importdata([pathname '/' data_filenames{ii}]);
    if isstruct(a)
        CalciumData = a.data;
    else
        CalciumData = a;
    end
    CalciumTime = time;
    
    b = importdata([pathname '/' stimulate_filenames{ii}]);
    if isstruct(b)
        StimulusData=b.data(:,2);
     else
        StimulusData=b(:,2);
    end
    
%     
%     if strcmp(data_filenames{ii},'b01.txt') ||  strcmp(data_filenames{ii},'b08.txt')%a04 b01
%        threshold=5.5;
%     end

    Time_before_baseline=0;  %round(Fs_cal);% ???5??????
    Time_after_stimu=round(1*Fs_cal);% ???20???????
    Time_before=round(1*Fs_cal); %  before select 1 seconds for caculating the baseline
    Time_after=round(2*Fs_cal);  %  after select 2 seconds for caculating the signal 
  
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
            a_before=zeros(abs(min(0,ind3-Time_before-1)),1);
            calclium_transient_extract = [a_before;calclium_transient(max(1,ind3-Time_before):min(length(calclium_transient),ind3+Time_after-1))];%the original signal
            %
            data_baseline = mean(calclium_transient_extract(Time_before_baseline+1:Time_before)); 
     
            data_peak=max(calclium_transient_extract(Time_before+1:Time_before+Time_after_stimu)); 
            data_deltaFf(cellNum,ind)=data_peak-data_baseline;
            real_length=length(calclium_transient_extract);
            calclium_transient_extract_one_cell_one_txt = [calclium_transient_extract_one_cell_one_txt [calclium_transient_extract;zeros(Time_before+Time_after-real_length,1)]];
        end
    end
     
    calclium_transient_extract_all{ii} = calclium_transient_extract_one_cell_one_txt;
    
end
close all;

%cell_num =length(cell_trigger_ind);
%frea_all = zeros([cell_num,size(calclium_transient_extract_all{1},2)/cell_num]);
frea_all = zeros([length(cell_num),size(calclium_transient_extract_all{1},2)]);
% 横排

 frea_all_raw={};  
for frea_ii = 1:length(calclium_transient_extract_all)
    data_freq = calclium_transient_extract_all{frea_ii}; %each frequecy
     ind =length(TriggerTime_cal) ;   %size(data_freq,2)/cell_num;  代表trial

     for cii =cell_num  %%%%%%%%%%%%%画全部细胞
         cii;
           data_temp = data_freq(:,round((cii-1)*ind+1):cii*ind);
           data_temp=data_temp(:,cell_trigger_ind);
           data_temp_mean = mean(data_temp,2);    
           data_temp_baseline = mean(data_temp(1:Time_before,:));
           data_temp_stimulate = data_temp(Time_before+1:end,:);    %later add detection !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
           
           data_temp_stimulate = bsxfun(@minus,data_temp_stimulate,data_temp_baseline);
           
           data_integera_temp  = mean(trapz(data_temp_stimulate)); 
           % data_temp_baseline = data_temp(1:);
           frea_all(cii,frea_ii) = data_integera_temp;        
           frea_all_raw{cii,frea_ii}=data_temp;  
     end    
end


[~,ind_order]=sort(stimuli_order,'ascend');
calcium_dff=[];
calcium_dff_std=[];
cellnum=cell_num;%%%%%%%%%%%%%%%%
if fig_y==1
    h=figure;
    set(h,'Visible','off');%不弹出来
    cla
end
nn=1;
data_new_mean_all_trials_cell={};
data_new_trials_value={};
for j=cellnum    
    data_cal_all=[];
    n=1;data_new_mean_all=[];  
    data_new_mean_all_trials={};
    for i=ind_order
        data_new=[];data_cal=[];
        for trials=1:size(frea_all_raw,2)
            temp=frea_all_raw{j,trials}(:,i);
            data_new=[data_new,temp];
            % 每条分别算出来，再去求std和mean
            data_baseline = prctile(temp(Time_before_baseline+1:Time_before),10);      
            data_peak=prctile(temp(Time_before+1:Time_before+Time_after_stimu),90);             
            data_cal(trials)=data_peak-data_baseline; 
        end
        data_cal_all=[data_cal_all;data_cal];
        calcium_dff(j,n) = mean(data_cal);   
        calcium_dff_std(j,n) = std(data_cal);          
        data_new_mean=mean(data_new,2);
        
        % 用平均线算cal信号值            
%         data_baseline = prctile(data_new_mean(Time_before_baseline+1:Time_before),10);      
%         data_peak=prctile(data_new_mean(Time_before+1:Time_before+Time_after_stimu),90);     
%         calcium_dff(j,n) = data_peak-data_baseline; 
% 暂时未用，这个是画每个focus，所有细胞
% %         if fig_y==1
% %     subplot(7,11,nn)        
% %     for kk=1:size(data_new,2)          
% %         plot((0:size(data_new,1)-1)/Fs_cal , data_new(:,kk),'color',[220 220 220]/255);
% %         hold on
% %         line([1 1],[min(data_new(:)) max(data_new(:))],'LineStyle','--','LineWidth',1,'color',[0 0 0]/255);             
% %         set(gca,'ylim',[-1 2]); %%%%%%%%%%%%%%%%%%% y轴
% %         set(gca,'xlim',[0 3]);
% %         box off
% %         axis off
% %     end     
% %     plot((0:size(data_new,1)-1)/Fs_cal ,data_new_mean,'color','r','LineWidth',2);
% % 
% %     if i==ind_order(1)
% %         title(['cell #' num2str(j)])
% %     end
% %     line([1 1],[min(data_new(:)) max(data_new(:))],'LineStyle','--','LineWidth',1,'color',[0 0 0]/255); 
% %     set(gca,'ylim',[-0.2 1]); %%%%%%%%%%%%%%%%%%% y轴
% %     set(gca,'xlim',[0 3]);
% %     box off
% %     axis off
% % 
% %     if nn==77 || (j==cellnum(end) && i==ind_order(end))
% %         set(h,'outerposition',get(0,'screensize')); 
% %         saveas(h,fullfile(figures_directory,['calcium transient_all_frequency_cellnum=' num2str(j) '_' focus_name_now]),'png') ;
% %         saveas(h,fullfile(figures_directory,['calcium transient_all_frequency_cellnum=' num2str(j) '_' focus_name_now]),'epsc') ;
% %         close
% %         h=figure;
% %         set(h,'Visible','off');%不弹出来
% %         nn=1;            
% %     else
% %         nn=nn+1;            
% %     end
% % end
              
         data_new_mean_all=[data_new_mean_all,data_new_mean];    
         data_new_mean_all_trials{n,1}=data_new; 
         n=n+1; 
    end
    data_new_trials_value{j,1}=data_cal_all';    
    data_new_mean_all_cell{j,1}=data_new_mean_all;  
    data_new_mean_all_trials_cell{j,1}=data_new_mean_all_trials;
end
save([results_directory '\' filename(1)  '_calcium_deltaFF_all.mat'],'calcium_dff','data_new_mean_all_cell','data_new_mean_all_trials_cell');


