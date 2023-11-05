
function plot_02(pathname,results_directory,time,fig_y)
% only for 1006 !!!!!!!!!!!!!!!!!!!!!!!!!
%
%FolderNameSt = uigetdir('.\a\');
txt_files = dir([pathname '/*.txt']);

data_filenames = cell(0);
stimulate_filenames = cell(0);
ci = 0;
for ii = 1:length(txt_files)
    filename = txt_files(ii).name;
    if length(filename)==7  
        
        ci = ci+1;
        data_filenames{ci} = filename;
        stimulate_filenames{ci} = [ filename(1:end-4) '_s'  '.txt'];
         %stimulate_filenames{ci} = ['data_user input_' filename(1:end-4) '.txt'];
        %%根据data user input名称二选一
    end
end


Fs_cal = 40;    %????????                            
Fs_cal_stim=12000;% ??????????

%threshold = 5;
calclium_transient_extract_all = cell([length(data_filenames) 1]);
for ii = 1:length(data_filenames)
    a = importdata([pathname '/' data_filenames{ii}]);
    if isstruct(a)
        CalciumData = a.data;
    else
        CalciumData=a;
    end
    CalciumTime = time;
    
    b = importdata([pathname '/' stimulate_filenames{ii}]);
    if isstruct(b)
        StimulusData=b.data(:,2);
     else
        StimulusData=b(:,2);
    end
    
    
    Time_before_baseline=0;  %round(Fs_cal);% ???5??????
    Time_after_stimu=round(1*Fs_cal);% ???20???????
    Time_before=round(1*Fs_cal); %  before select 1 seconds for caculating the baseline
    Time_after=round(3*Fs_cal);  %  after select 1 seconds for caculating the signal 
  
        calclium_stimu_Time=(1:length(StimulusData))/Fs_cal_stim;
%         PosAbove=find(StimulusData>threshold);  
%         PosAboveDiff=diff(PosAbove); 
%         PosAboveDoubleDiff=diff(PosAboveDiff);
%         FirstPointOfPos=find(PosAboveDoubleDiff>1*Fs_cal)+2;
%         TriggerPositions=PosAbove([1 FirstPointOfPos'])-1;
%         TriggerTime_cal=calclium_stimu_Time(TriggerPositions(TriggerPositions>0));
%         TriggerTime_cal=TriggerTime_cal(TriggerTime_cal>0.1); 
       
       
       
threshold= 0.4*(max(StimulusData)-mean(StimulusData))+mean(mean(StimulusData)); % light_data????
% Fs_cal=1;
calclium_stimu_Time=(1:length(StimulusData))/Fs_cal_stim;
position_above = find(StimulusData>threshold);
pos_diff = position_above(2:end) - position_above(1:end-1);
ind_above = [position_above(1) ;position_above(find(pos_diff>2)+1)];
TriggerTime_cal = (ind_above-1)/Fs_cal_stim;% calclium_stimu_Time(ind_above);

    calclium_transient_extract_one_cell_one_txt = [];
    for cellNum=1:size(CalciumData,2)    %%%%%% group C ???????
        calclium_transient = CalciumData(:,cellNum);
        for ind = 1:length(TriggerTime_cal)
            calclium_transient_extract = [];
            temp1_cal = TriggerTime_cal(ind);
            temp2=CalciumTime-temp1_cal;
            [stimui,ind2] = min(temp2(temp2>0));
            ind3 = ind2+length(temp2)-length(temp2(temp2>0)); 
            calclium_transient_extract = smooth(calclium_transient(max(1,ind3-Time_before):min(length(calclium_transient),ind3+Time_after-1)),5); % the original signal
            %
            %data_baseline = mean(calclium_transient_extract(Time_before_baseline+1:Time_before)); 
     
            %data_peak=max(calclium_transient_extract(Time_before+1:Time_before+Time_after_stimu)); 
            %data_deltaFf(cellNum,ind)=data_peak-data_baseline;
            calclium_transient_extract_one_cell_one_txt = [calclium_transient_extract_one_cell_one_txt calclium_transient_extract];
        end
    end
     
    calclium_transient_extract_all{ii} = calclium_transient_extract_one_cell_one_txt;
    
end

cell_num = size(CalciumData,2);
%%
frea_all =zeros([cell_num,length(calclium_transient_extract_all)]); %zeros([cell_num,size(calclium_transient_extract_all{1},2)/cell_num]);
data_temp_mean_all=cell(length(calclium_transient_extract_all),1); %%%%%%%%%%%%%%%%%%改次数 11/12/5
for cii = 1:cell_num
         cii;
    for frea_ii = 1:length(calclium_transient_extract_all)
        data_freq = calclium_transient_extract_all{frea_ii}(:,:); %each frequecy
         ind = size(data_freq,2)/cell_num;

    %          if cii == 20 & frea_ii==4
    %             pause;
    %          end
               data_temp = [data_freq(:,(cii-1)*ind+1:cii*ind)];
               % jian baseline
               data_temp=data_temp-mean(data_temp(1:Time_before,:));
               
               data_temp_mean = mean(data_temp,2);    
               data_temp_baseline = mean(data_temp(1:Time_before,:));
               data_temp_stimulate = data_temp(Time_before+1:end,:);    %later add detection !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

               data_temp_stimulate = bsxfun(@minus,data_temp_stimulate,data_temp_baseline);
               %bsxfun(@minus,data_temp(Time_before+1:end,:),data_temp_baseline)
               std_num = 3; %da yu biao zhun cha
               %std(data_temp(1:Time_before,:))
               data_temp_stimulate2 = bsxfun(@minus,data_temp_stimulate, mean(data_temp(1:Time_before,:))+std_num * std(data_temp(1:Time_before,:)));


               data_integera_temp  = mean(trapz(data_temp_stimulate)); 
               % data_temp_baseline = data_temp(1:);
                length(find(max(data_temp_stimulate2)>0));
               if length(find(max(data_temp_stimulate2)>0)) >= 3 %fan ying ci shu  
                  frea_all(cii,frea_ii) = max(data_integera_temp,0);
               end
           if fig_y==1
                h = figure(1);
                %subplot(frea_ii,cii,1)
                set(h,'Visible','off');
                cla;
                hold on;
                plot((1:size(data_temp,1))/Fs_cal , data_temp,'color',[220 220 220]/255);
                line([1 1],[min(data_temp(:)) max(data_temp(:))],'LineStyle','--','color','k');
                plot((1:size(data_temp,1))/Fs_cal ,data_temp_mean,'color',[255 0 0]/255);                
                saveas(h,['calcium transient_cellNum_' num2str(cii) '_frequency_' num2str(frea_ii)],'tif') ;
                saveas(h,['calcium transient_cellNum_' num2str(cii) '_frequency_' num2str(frea_ii)],'epsc') ;
                close
           end
           data_temp_mean_all{frea_ii,1}=[data_temp_mean_all{frea_ii,1},data_temp_mean];
    end
end
save([results_directory '\data_temp_mean_all'],'data_temp_mean_all')
%%
figure
data_neworder={};
for stimuNum=1:size(data_temp_mean_all,1)
    data=data_temp_mean_all{stimuNum,1};
    %排序
    data_value=mean(data(Fs_cal+1:Fs_cal*2,:),1);%刺激后1s的均值
    [~,order]=sort(data_value,'descend');
    data_neworder{stimuNum,1}=order;
end
save([results_directory '\data_neworder'],'data_neworder')

%%
 %load([results_directory '\data_neworder'])
 load([results_directory '\data_all.mat']) 
 %load([results_directory '\data_temp_mean_all'])
 
figure

for stimuNum=1:size(data_temp_mean_all,1)
    data=data_temp_mean_all{stimuNum,1};
    subplot(3,4,stimuNum)
    data1=data(:,data_neworder{stimuNum,1})';
    imagesc(data1)  
    colormap jet
    set(gca,'clim',[0 1])
end
saveas(gcf,[results_directory '\calcium_mean_trace_neworder'],'fig')
save([results_directory 'data_neworder'],'data_neworder')


figure 
for stimuNum=1:size(data_all,2)
    data=data_all{1,stimuNum};
    data_new=data(:,data_neworder{stimuNum,1});
    subplot(3,4,stimuNum)
    imagesc(data_new')
    colormap jet
    set(gca,'clim',[0 3])    
end
saveas(gcf,[results_directory 'calcium_alltrial_trace_neworder'],'fig')

