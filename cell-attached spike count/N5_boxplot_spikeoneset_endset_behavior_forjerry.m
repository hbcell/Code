load('spike_duration_all_final_20200727_condition.mat')
%load('behavior_latency.mat')

figure;
% 有行为数据运行这个
% spike_onset=spike_latency;
% spike_endset=last_spike;
% a1=spike_onset';
% a2=behavior_latency';
% a3=spike_endset';
% X=[a1,a2,a3]';
% G=[ones(length(a1),1);2*ones(length(a2),1);3*ones(length(a3),1)];
%set(gca,'xticklabel',{'Burst start','Lick onset','Burst end'});

%没有行为数据运行这个
spike_onset=spike_latency;
spike_endset=last_spike;
a1=spike_onset';
a3=spike_endset';
X=[a1,a3]';
G=[ones(length(a1),1);2*ones(length(a3),1)];
set(gca,'xticklabel',{'Burst start','Burst end'});


subplot(231)
h=boxplot(X,G,'symbol','','colors','k');
set(gca,'FontSize',12)
set(h(7,:),'Visible','off')
hold on
plot(G,X,'ko')
box off;
set(gca,'ylim',[-100 600]);
set(gca,'xtick',1:3);
set(gca,'ytick',-100:100:600);
set(gca,'TickDir','out');
ylabel('Success rate(%)')
title('psychometric curve')

saveas(gcf,'psychometric curve','png')
saveas(gcf,'psychometric curve','fig')
print('-depsc2','-painters',['psychometric curve.eps']);