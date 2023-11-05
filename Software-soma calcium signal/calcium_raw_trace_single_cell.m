function calcium_raw_trace_single_cell(results_directory,pathname,x_label,Fs_cal,time,fig_eps,cell_id)
% only for 1002 !!!!!!!!!!!!!!!!!!!!!!!!!
% new lotos ananlysis

% 刺激的文件
txt_files = dir([pathname '/*.txt']);
figure_directory=fullfile(results_directory,'');
     if exist(figure_directory,'dir')~=7
        mkdir(figure_directory);
        figure_visibility='off'; % either 'on' or 'off' (in any case figures are saved)
     end
    figure_visibility='off'; 

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


%Fs_cal = 1/0.1002;    %????????                            
Fs_cal_stim=12000;% ??????????

calclium_transient_extract_all = cell([length(data_filenames) 1]);
data_peaks_all_files = cell([length(data_filenames) 1]);


TriggerTime_cal_all = [];
for ii = 1:length(data_filenames)
    a = importdata([pathname '/' data_filenames{ii}]);
    CalciumData=[];
    if isstruct(a)
        CalciumData = a.data;
    else
        CalciumData = a;
    end
    CalciumTime =time;
    b = importdata([pathname '\' stimulate_filenames{ii}]);
    if isstruct(b)
        StimulusData=b.data(:,2);
     else
        StimulusData=b(:,2);
    end
    t_0 = 0.15 * Fs_cal_stim;
% 

    StimulusData(1:t_0) = 0;
    Time_before_baseline=0;  %round(Fs_cal);% ???5??????
    Time_after_stimu=round(1*Fs_cal);% ???20???????
    Time_before=round(1*Fs_cal); %  before select 1 seconds for caculating the baseline
    Time_after=round(2*Fs_cal);  %  after select 2 seconds for caculating the signal 
  
        calclium_stimu_Time=(0:length(StimulusData)-1)/Fs_cal_stim;
        threshold = 0.2;%(max(StimulusData) - mean(StimulusData))*0.5+mean(StimulusData);
        PosAbove=find(StimulusData>threshold);  
        diff_stimu = PosAbove(2:end) - PosAbove(1:end-1);
        
        if PosAbove(1)>=2
           ind_find = [PosAbove(1); PosAbove(find(diff_stimu>1*Fs_cal_stim)+1)];
        end
            
        TriggerTime_cal = calclium_stimu_Time(ind_find)-0.15;   %%%%%%%% 0.15可以删去
        
        
        %if length(TriggerTime_cal)<19
         %   for i=length(TriggerTime_cal)+1:19
          %  TriggerTime_cal=[TriggerTime_cal,TriggerTime_cal(end)+3];
           % end
        %end
        %  %  TriggerTime_cal_all = [TriggerTime_cal_all TriggerTime_cal'];
    calclium_transient_extract_one_cell_one_txt = [];
    
    data_deltaFf = []; %for record the max-begin
    for cellNum=1:size(CalciumData,2)    %%%%%% group C ???????
        calclium_transient = CalciumData(:,cellNum);
        for ind = 1:length(TriggerTime_cal)
            calclium_transient_extract = [];
            temp1_cal = TriggerTime_cal(ind);
            temp2=CalciumTime-temp1_cal;
            [stimui,ind2] = min(temp2(temp2>0));
            ind3 = ind2+length(temp2)-length(temp2(temp2>0)); 
            calclium_transient_extract = calclium_transient(max(1,ind3-Time_before):min(length(calclium_transient),ind3+Time_after-1));%the original signal
            %
% %             data_baseline = mean(calclium_transient_extract(Time_before_baseline+1:Time_before)); 
            data_peak = max(calclium_transient(ind3:min(length(calclium_transient),ind3+Time_after-1))) - calclium_transient(ind3); 
% %             data_deltaFf(cellNum,ind) = data_peak ; %- data_baseline;
            %
            %calclium_transient_extract_one_cell_one_txt = [calclium_transient_extract_one_cell_one_txt calclium_transient_extract];
        end
    end
% %     data_peaks_all_files{ii} = mean(data_deltaFf,2);
    %calclium_transient_extract_all{ii} = calclium_transient_extract_one_cell_one_txt; % 提取出来的信号
    
    % 画出所有的trace+刺激+细胞
    h = figure;
    set(h,'Visible','off');%不弹出来
    cla;
    hold on;
    time=(0:size(CalciumData,1)-1)/Fs_cal;
    gap=2;
    k=1;
    for cellid=cell_id%1:size(CalciumData,2)        
        plot(time,CalciumData(:,cellid)+gap*(k-1)+2,'k')
        hold on
        k=k+1;
    end
    hold on;
    for trigger_num=1:length(TriggerTime_cal)
        line([TriggerTime_cal(trigger_num) TriggerTime_cal(trigger_num)],[-0.5 size(CalciumData,2)*(gap)+1],'LineStyle','--','color','r'); 
    end
    
    set(gca, 'YTick', 0:10:gap*k, 'YTickLabel', 0:5:k,'FontSize',10); 
    set(gca,'ylim',[0 gap*(k+2)])
    ylabel('Cell No.#')
    xlabel('Time(s)')
    title(data_filenames{ii}(1:end-4))
    
    saveas(h,fullfile(figure_directory,['calcium transient_allcell_frequency_' data_filenames{ii}(1:end-4) '_single']) ,'png');
    if fig_eps==1
        print('-depsc2','-painters',fullfile(figure_directory,['calcium transient_allcell_frequency_' data_filenames{ii}(1:end-4) '_single' '.eps']));
    end
    close 
end

% % cell_num = size(CalciumData,2);
% % 
% % % % for frea_ii = 1:length(calclium_transient_extract_all)
% % % %      data_freq = calclium_transient_extract_all{frea_ii}; %each frequecy
% % % %      ind = size(data_freq,2)/cell_num;
% % % %      %data_cal = ;
% % % %      for cii = 1:cell_num
% % % %          cii;
% % % %            data_temp = [data_freq(:,(cii-1)*ind+1:cii*ind)];
% % % %            data_temp_mean = mean(data_temp,2);    
% % % %            data_temp_baseline = mean(data_temp(1:Time_before,:));
% % % %            data_temp_stimulate = data_temp(Time_before+1:end,:);    %later add detection !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! 
% % % %            data_temp_stimulate = bsxfun(@minus,data_temp_stimulate,data_temp_baseline);
% % % % 
% % % %         h = figure;
% % % %         set(h,'Visible','off');
% % % %         cla;
% % % %         hold on;
% % % %         plot((0:size(data_temp,1)-1)/Fs_cal , data_temp,'color',[220 220 220]/255);
% % % %         line([1 1],[min(data_temp(:)) max(data_temp(:))],'LineStyle','--','color','k'); 
% % % %         plot((0:size(data_temp,1)-1)/Fs_cal ,data_temp_mean,'color',[255 0 0]/255);  
% % % %         saveas(h,['calcium transient_cellNum_' num2str(cii) '_frequency_' num2str(frea_ii)],'tif') ;
% % % %        % saveas(h,['calcium transient_cellNum_' num2str(cii) '_frequency_' num2str(frea_ii)],'epsc') ;
% % % %      end
% % % % end
% % 
% % 
% % %%
% % % 转换每个frequecny的值，从cell到array
% % fre_num = length(data_peaks_all_files);
% % cell_num = size(data_peaks_all_files{1},1);
% % fre_all = zeros(fre_num,cell_num);
% % for ii = 1:cell_num
% %     for jj = 1:fre_num
% %         fre_all(jj,ii) = data_peaks_all_files{jj}(ii);
% %     end
% % end
% % %%
% % % 单个细胞重新画在一起
% % gap=2;
% % for ci = 1:cell_num
% %     h = figure;
% %     set(h,'Visible','off');%不弹出来
% %     cla;
% %     hold on;
% %     data_temp_selected=[];
% %     for ii = 1:length(data_filenames)
% %         a   = importdata([pathname '/' data_filenames{ii}]);
% %         if isstruct(a)
% %             CalciumData = a.data;
% %         else
% %             CalciumData = a;
% %         end
% %         CalciumTime = time;
% %         data_temp = CalciumData(:,ci);        
% %         plot(CalciumTime,data_temp+ii*gap,'r');
% %         TriggerTime_cal = TriggerTime_cal_all(:,ii);
% %         onset=round((TriggerTime_cal(1)-min(TriggerTime_cal_all(:))+0.1)*Fs_cal);
% %         endset=onset+345*Fs_cal/10;
% %         data_temp_selected=[data_temp_selected;[data_temp(onset:min(endset,length(data_temp)))',zeros(endset-length(data_temp),1)']];
% %        
% %         for si = 1:length(TriggerTime_cal)
% %             line([TriggerTime_cal(si) TriggerTime_cal(si)],[min(data_temp+ii*gap) max(data_temp+ii*gap)],'LineStyle','--','color','k','LineWidth',0.5);
% %         end
% %     end
% %      % 画mean值线
% %      data_temp_mean=mean(data_temp_selected);
% %      plot((1:length(data_temp_selected))/Fs_cal,data_temp_mean,'b'); 
% %      TriggerTime_ok=min(TriggerTime_cal_all(:))+0.1:3:33;
% %      for si = 1:length(TriggerTime_ok)
% %          line([TriggerTime_ok(si) TriggerTime_ok(si)],[min(data_temp_mean) max(data_temp_mean)],'LineStyle','--','color','k','LineWidth',0.5);
% %      end     
% %     set(gca, 'XTick', TriggerTime_ok, 'XTickLabel', x_label);     
% %     set(gca,'ylim',[-2 size(data_filenames,2)*gap+4])  %%%%%%%% y轴在11的频率的基础上加2
% %     title(['cell:',num2str(ci)]);    
% %     saveas(h,fullfile(figure_directory,['calcium transient_cellNum_' num2str(ci) pathname(end)]),'png') ;
% %     %saveas(h,fullfile(figure_directory,['calcium transient_cellNum_' num2str(ci) pathname(end)]),'epsc') ;
% %            %saveas(h,fullfile(figure_directory,['calcium transient_cellNum_' num2str(ci) pathname(end)]),'epsc') ;
% % end