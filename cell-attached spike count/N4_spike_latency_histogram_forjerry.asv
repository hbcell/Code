%% spike latency，做成histogram
load('spike_duration_all_final_20220930_condition.mat')
data{1,1}=spike_latency;data{1,2}='spike latency';
data{2,1}=spike_interval;data{2,2}='spike interval';
data{3,1}=spike_duration_all_matrix;data{3,2}='spike duration';
%load('spike_duration_all_final_20200727_condition','')
data{4,1}=spike_number_matrix_250ms;data{4,2}='spike_number_matrix_500ms';

figure
for type=1:size(data,1)
    X=data{type,1};name=data{type,2};
    subplot(2,2,type)
    interval_bar=[];
    interval_percent_bar2=[];
    if strcmp(data{type,2},'spike duration')
        interval=(0:25:500)';  
    elseif strcmp(data{type,2},'spike_number_matrix_500ms')
        interval=(0:2:40)'; 
    else
        interval=(0:20:500)';   
    end
    for i=2:length(interval) 
        high=interval(i);
        low=interval(i-1);
        ind1=find((X<=high) & (X>low));   %0 alone%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        temp1=length(ind1);
        interval_percent=temp1; % 统计个数
        interval_percent_bar2(i-1,1)=interval_percent;

        X_median=median(X);
        X_mean=mean(X);
        X_axis=interval(2:end);
    end
    if strcmp(data{type,2},'spike_number_matrix_500ms')
        bar(X_axis,interval_percent_bar2/length(X))
    else
        bar(X_axis,interval_percent_bar2/length(X))
    end
    hold on
    %gaussian_level1(X_axis,interval_percent_bar2/length(X))

    %bar(X_axis,interval_percent_bar2)
    %  plot(X_axis,interval_percent_bar2,'k','LineWidth',2)
    set(gca,'FontSize',15);
    %  X_axis2=-100:50:600;
    %  set(gca,'xticklabel',X_axis2); 
    xlabel('Time(ms)');
    ylabel('count');

    timenow=datestr(now,29);
    switch name
        case 'spike latency'
            set(gca,'Ylim',[0 0.3]);
            set(gca,'Xlim',[0 102]);
            filename=['(' timenow ') ' name ' —histogram']; %
        case 'spike interval'
            set(gca,'Xlim',[0 402]);
            X_axis=0:40:402;
            set(gca,'Ylim',[0 0.3]);
            filename=['(' timenow ') ' name ' —histogram']; %
         case 'spike duration'
            set(gca,'Xlim',[0 502]);
            set(gca,'Ylim',[0 0.2]);
            filename=['(' timenow ') ' name ' —histogram']; %
         case 'spike_number_matrix_500ms'
            set(gca,'Xlim',[0 40]);
            set(gca,'Ylim',[0 0.3]);
            filename=['(' timenow ') ' name ' —histogram']; %
            ylabel('trials');
            xlabel('spike number')            
    end
    box off
    title(filename)
end
saveas(gcf,filename,'png')
saveas(gcf,filename,'fig')
print('-depsc2','-painters',[filename '.eps']);