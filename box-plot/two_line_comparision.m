%% 
c =  [0, 0, 0;...
      0, 0, 0;...
      0, 0, 0;...
      0, 0, 0];  
figure
%subplot(3,3,1)

group1=[ones(1,6) 2*ones(1,9)];
condition_names={'Day1' 'Day2'};
group_names1={'Low' 'High'};
h = daboxplot(day1,'groups',group1,'outliers',0,'outsymbol','k+',...
    'xtlabels',group_names1,'color',c,...
    'fill',0,'whiskers',1,'scatter',1,'jitter',0,'scattersize',13,'linkline',1);

for ii=1:8
   plot([0.852 1.852],[day1(ii,1);day1(ii,2)],'^:','color','(0.8,0.8,0.8)','MarkerSize',3)
   hold on
end
for ii=7:15
   plot([1.148 2.148],[day1(ii,1);day1(ii,2)],'v:','color','(0.8,0.8,0.8)','MarkerSize',3)
   hold on
end
ylim([0 4])
print('-depsc2','-painters',['day1 HB.eps']);
%% %% 
c =  [0, 0, 0;...
      0, 0, 0;...
      0, 0, 0;...
      0, 0, 0];  
figure
%subplot(3,3,1)

group1=[ones(1,13) 2*ones(1,20)];
condition_names={'day6' 'Day2'};
group_names1={'Low' 'High'};
h = daboxplot(day6,'groups',group1,'outliers',0,'outsymbol','k+',...
    'xtlabels',group_names1,'color',c,...
    'fill',0,'whiskers',1,'scatter',1,'jitter',0,'scattersize',13,'linkline',1);

for ii=1:13
   plot([0.852 1.852],[day6(ii,1);day6(ii,2)],'^:','color','(0.8,0.8,0.8)','MarkerSize',3)
   hold on
end
for ii=14:33
   plot([1.148 2.148],[day6(ii,1);day6(ii,2)],'v:','color','(0.8,0.8,0.8)','MarkerSize',3)
   hold on
end
ylim([0 4])
print('-depsc2','-painters',['day6 HB.eps']);