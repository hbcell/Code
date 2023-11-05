clear
close all
FolderNameSt=uigetdir('','V:\Li Ruijie\data\cell-attach\analysis');

FolderOffset=2;
listing1=dir(FolderNameSt); 
if isempty(FolderNameSt)
    return
end

DurationBefore=0.5; % second
DurationAfter=2; % second


spike_time_temp_all={};
n=1;data_raw={};temp_MinAll=[];

gap=2;
for folder_cnt=1:length(listing1)-FolderOffset      
   if listing1(folder_cnt+FolderOffset,1).isdir
     FileName_0=listing1(folder_cnt+FolderOffset,1).name;
     FolderNameFull_0=[FolderNameSt '\' FileName_0]; 
     listing0=dir(FolderNameFull_0); 
     StimulusData_all={}; CalciumData_all={};  
     m=1; a=[];mm=1;b=[];c=[];
     for folder_cnt_1=1:length(listing0)-FolderOffset 
        if ~listing0(folder_cnt_1+FolderOffset,1).isdir
             FileName_1=listing0(folder_cnt_1+FolderOffset,1).name;
             FolderNameFull_1=[FolderNameFull_0 '\' FileName_1]; 
             % 导入dat
            if strcmp(FileName_1(end-3:end),'.dat')  
               a=ImportPatchMasterData(FolderNameFull_1);  
            end
               
            %导入trigger
            StimulusData=[];
             if length(FileName_1)<8 && strcmp(FileName_1(end-3:end),'.txt') 
                b=importdata(FolderNameFull_1);
                StimulusData=b.data(:,2);
                % 得出刺激点
                TriggerPositions=[];
                
                Fs_cal_stim=12014; %calcium trigger
                fs2=10000;%dian 
              
                threshold=2;
                calclium_stimu_Time=(1:length(StimulusData))/Fs_cal_stim;
                PosAbove=find(StimulusData>threshold);  %提取出音频中大于6的时间点
                PosAboveDiff=diff(PosAbove); %求一介导数
                PosAboveDoubleDiff=diff(PosAboveDiff);%求二阶导数
                FirstPointOfPos=find(PosAboveDoubleDiff>1*Fs_cal_stim)+2;
%                 if ~isempty(FirstPointOfPos)
                    TriggerPositions=PosAbove([1 FirstPointOfPos'])-1; %得出刺激位置
                    TriggerPositions=TriggerPositions(TriggerPositions>0);
                    TriggerTime_cal=calclium_stimu_Time(TriggerPositions(TriggerPositions>0)); %得出刺激发出的时间            
%                 end
                
                StimulusData_all{m,1}=StimulusData;
                StimulusData_all{m,2}=TriggerPositions;
                StimulusData_all{m,3}=FileName_1(1:end-4);
                m=m+1;
             end   
             
             % 把钙信号导进来
             if length(FileName_1)>8 && strcmp(FileName_1(end-4:end),'c.txt') 
                c=importdata(FolderNameFull_1);
                CalciumData=c.data;
                CalciumData_all{mm,1}=CalciumData; 
                CalciumData_all{mm,2}=FileName_1(1:end-4); 
                mm=mm+1;
             end 
             if length(FileName_1)>8 && strcmp(FileName_1,'新建文本文档.txt') 
                 d=importdata(FolderNameFull_1);
                 trigger_interval=d.data;
             end
        end
     end
     
     
     if ~isempty(a) && ~isempty(StimulusData_all) && ~isempty(CalciumData_all)            
        spike_position_time={}; kk=1;temp_1=[]; spike_time_temp_need={};data_raw_need={}; temp_2=[];
        for i=1:size(a,2)
            data=a{1,i}; 
            % 画trigger
            TriggerPositions=[];
            spike_position_temp=[];
            for j=1:size(StimulusData_all,1)
                trigger_file=StimulusData_all{j,3}(end-1:end);                 
                if str2double(trigger_file)==i    
                    % 把电信号的刺激点识别出来  
                    %threshold_data=min(data)*0.45;
                    data(1:trigger_interval(j)*fs2)=[];
                    data_cal=CalciumData_all{j,1};
                    data_trend=binomial_filter(data,200);  
                    data_corrected=data-data_trend; 
                    if ~isempty(abs(data_corrected)>7*1e-10) %把异常的信号归为mean值
                        data_corrected(abs(data_corrected)>7*1e-10)=mean(data_corrected);
                    end  
                    switch FileName_0  %%%%%%%%%%%改阈值
                        case {'40b'} 
                            threshold_data=min(data_corrected)*0.1; 
                        case {'57'} 
                            threshold_data=min(data_corrected)*0.1; 
                        case {'68a','87','163'}
                            threshold_data=min(data_corrected)*0.35; 
                        otherwise
                            threshold_data=min(data_corrected)*0.05;
                    end
                    temp_file=[FileName_0 ' ' StimulusData_all{j,3}];
                    switch  temp_file
                        case {'68 a05','87 a05','87 a06','57 e04','57 e08'}
                         threshold_data=min(data_corrected)*0.6;    
                        case {'57 e01','57 e03','57 e07','57 e09'}
                         threshold_data=min(data_corrected)*0.2;    
                        case {'87 a04','126a a01','126d e10'}
                         threshold_data=min(data_corrected)*0.3; 
                        case {'68b b03'}
                         threshold_data=min(data_corrected)*100; 

                         
                    end
                    spike_position_temp1=[];
                    PosAbove_local=find(data_corrected<threshold_data);  %提取出音频中大于6的时间点
                    if isempty(PosAbove_local)
                         spike_position{i}=[];
                        continue;
                    end
                PosAboveDiff_local=diff(PosAbove_local);            
                FirstPointOfPos_local=find(PosAboveDiff_local>2)+1;
                SpikePositions_local=PosAbove_local([1;FirstPointOfPos_local]);
                locs=SpikePositions_local; 
%                for j=1:length(SpikePositions_local)
%                     if SpikePositions_local(j)+PeakWindow<=length(data_corrected)
%                         [~,peaks]=min(data_corrected(SpikePositions_local(j):SpikePositions_local(j)+PeakWindow));
%                     else
%                         [~,peaks]=min(data_corrected(SpikePositions_local(j):end));
%                     end
%                    locs(j)=peaks+SpikePositions_local(j)-1;
%                end               
                    spike_position{i}=locs;  % 电信号的spike
                    TriggerPositions=StimulusData_all{j,2};%-trigger_interval(j)*Fs_cal_stim; %因为电信号整体向前罗
                    
                    spike_position_temp=spike_position{1,i};
                    fs1=1000/49.940;
                    % fs1=1000/50.208;  
                    % fs1=1000/100.2;

                    % 计算有trigger和spike position的对应时间
                    for triggerNum=1:length(TriggerPositions)
                        trigger_before=TriggerPositions(triggerNum)-Fs_cal_stim*DurationBefore; % second;
                        trigger_after=TriggerPositions(triggerNum)+Fs_cal_stim*DurationAfter;
                        trigger_before_cal=round((TriggerPositions(triggerNum))/Fs_cal_stim*fs1-fs1*DurationBefore); % second;
                        trigger_after_cal=round((TriggerPositions(triggerNum))/Fs_cal_stim*fs1+fs1*DurationAfter);
                        spike_position_need=spike_position_temp((spike_position_temp>trigger_before/Fs_cal_stim*fs2) & (spike_position_temp<trigger_after/Fs_cal_stim*fs2));
                        % 计算时间
                        if ~isempty(spike_position_need)
                            spike_time_temp=(spike_position_need/fs2-TriggerPositions(triggerNum)/Fs_cal_stim)*1000;%转成ms
                            %spike_time_temp=(spike_position_need/fs2-TriggerPositions(triggerNum)/fs2);%s
                            spike_position_time{i}{1,triggerNum}=spike_time_temp;  
                            
                            threshold_stimu=100; %第一个spike点，在刺激后100ms必须出现

                             if min(spike_time_temp(spike_time_temp>0))>0
                                 if min(spike_time_temp(spike_time_temp>0))<threshold_stimu && min(spike_time_temp(spike_time_temp>0))>0 %2017.11.22
                                    temp_1=[temp_1;min(spike_time_temp(spike_time_temp>0))]; 
                                    temp_2=[temp_2;length(intersect(find(spike_time_temp>0),find(spike_time_temp<500)))];
                                    spike_time_temp_need{kk,1}=spike_time_temp; 
                                    if trigger_before<0 || trigger_before_cal<0
                                        data_raw_need{kk,1}=[zeros(abs(trigger_before),1);data(max(1,trigger_before+1):min(trigger_after,length(data)))];
                                        data_raw_need{kk,2}=[zeros(abs(trigger_before_cal),1);data_cal(max(trigger_before_cal+1,1):min(length(data_cal),trigger_after_cal))];
                                    else
                                        data_raw_need{kk,1}=data(max(1,trigger_before+1):min(trigger_after,length(data)));
                                        data_raw_need{kk,2}=data_cal(trigger_before_cal+1:min(length(data_cal),trigger_after_cal));
                                    end
                                   kk=kk+1;
                                 end
                             end
                            
                        end                        
                    end    
  
                   %刺激和data都有的
                   figure                   
                   plot((1:length(data_corrected))/fs2,data_corrected*1e10,'r')
                   hold on
                   plot((1:length(data_cal))/fs1,data_cal+1,'b')
                   plot(spike_position_temp/fs2,data_corrected(spike_position_temp)*1e10,'b+')
                    for k=1:length(TriggerPositions)
                        yt=min(data_cal)-1:1:max(data_cal)+1;
                        xt=TriggerPositions(k)*ones(1,length(yt))/Fs_cal_stim;
                        plot(xt,yt,'k--','LineWidth',2);
                        hold on;
                    end
                    
                    title([FileName_0 '_' StimulusData_all{j,3}])
                    set(gcf,'Position',get(0,'ScreenSize'))
                    saveas(gcf,[FileName_0 '_' StimulusData_all{j,3}],'tif')
                    saveas(gcf,[FileName_0 '_' StimulusData_all{j,3}],'fig')
                    close 

                end   
                
            end 
        end   
     if  ~isempty(spike_time_temp_need)   
         spike_time_temp_all{n,1}=spike_time_temp_need;
         spike_time_temp_all{n,5}=data_raw_need;
         spike_time_temp_all{n,2}=FileName_0;
         spike_time_temp_all{n,3}=min(temp_1);
         spike_time_temp_all{n,4}=temp_1;
         spike_time_temp_all{n,6}=mean(temp_2);
         if ~isempty(temp_1)
           temp_MinAll(n,1)=min(temp_1);
         else
           temp_MinAll(n,1)=nan;  
         end

         data_raw{n,2}=StimulusData_all;
         data_raw{n,1}=a;
         data_raw{n,3}=FileName_0;
         n=n+1; 
      end   
     end
   end
end

save('cell_attched_data_analysis_version3.mat','data_raw','temp_MinAll','spike_time_temp_all')
%% 进行画散点，会得到spike_duration_all_final_20180710_allcondition.mat
%  用代码：N2_cellattached_sandian_plot_forjerry.m 
%% spike count 统计: N3_spikecount_line.m
%% spike latency，做成histogram：N4_spike_latency_histogram.m 
