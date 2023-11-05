
% 每个细胞前中后的boxplot�?
% c =  [0.45, 0.80, 0.69;...
%       0.98, 0.40, 0.35;...
%       0.55, 0.60, 0.79;...
%       0.90, 0.70, 0.30];  
c =  [0, 0, 0;...
      0, 0, 0;...
      0, 0, 0;...
      0, 0, 0];  
figure
%subplot(3,3,1)

group1=[ones(1,16) 2*ones(1,23)];
condition_names={'Day1' 'Day2' 'Day3' 'Day4' 'Day5' 'Day6'};
group_names1={'Low' 'High'};
h = daboxplot(Data1,'groups',group1,'outliers',0,'outsymbol','k+',...
    'xtlabels',group_names1,'color',c,...
    'fill',0,'whiskers',1,'scatter',1,'jitter',0,'scattersize',13,'linkline',1);

for ii=1:16
   plot([0.852 1.852 2.8519 3.8519 4.8519 5.8519],[Data1(ii,1);Data1(ii,2);Data1(ii,3);Data1(ii,4);Data1(ii,5);Data1(ii,6)],'^:','color','(0.8,0.8,0.8)','MarkerSize',3)
   hold on
end
for ii=17:39
   plot([1.148 2.148 3.148 4.148 5.148 6.148],[Data1(ii,1);Data1(ii,2);Data1(ii,3);Data1(ii,4);Data1(ii,5);Data1(ii,6)],'v:','color','(0.8,0.8,0.8)','MarkerSize',3)
   hold on
end
print('-depsc2','-painters',['Emerged HB amplitude.eps']);
%% 
c =  [0, 0, 0;...
      0, 0, 0;...
      0, 0, 0;...
      0, 0, 0];  
figure
%subplot(3,3,1)

group1=[ones(1,6) 2*ones(1,17)];
condition_names={'Day1' 'Day2' 'Day3' 'Day4' 'Day5' 'Day6'};
group_names1={'Low' 'High'};
h = daboxplot(Data2,'groups',group1,'outliers',0,'outsymbol','k+',...
    'xtlabels',group_names1,'color',c,...
    'fill',0,'whiskers',1,'scatter',1,'jitter',0,'scattersize',13,'linkline',1);

for ii=1:6
   plot([0.852 1.852 2.8519 3.8519 4.8519 5.8519],[Data2(ii,1);Data2(ii,2);Data2(ii,3);Data2(ii,4);Data2(ii,5);Data2(ii,6)],'^:','color','(0.8,0.8,0.8)','MarkerSize',3)
   hold on
end
for ii=7:23
   plot([1.148 2.148 3.148 4.148 5.148 6.148],[Data2(ii,1);Data2(ii,2);Data2(ii,3);Data2(ii,4);Data2(ii,5);Data2(ii,6)],'v:','color','(0.8,0.8,0.8)','MarkerSize',3)
   hold on
end
ylim([0 5])
print('-depsc2','-painters',['Submerged HB amplitude.eps']);

%% 
c =  [0, 0, 0;...
      0, 0, 0;...
      0, 0, 0;...
      0, 0, 0];  
figure
%subplot(3,3,1)

group1=[ones(1,8) 2*ones(1,12)];
condition_names={'Day1' 'Day2' 'Day3' 'Day4' 'Day5' 'Day6'};
group_names1={'Low' 'High'};
h = daboxplot(Data3,'groups',group1,'outliers',0,'outsymbol','k+',...
    'xtlabels',group_names1,'color',c,...
    'fill',0,'whiskers',1,'scatter',1,'jitter',0,'scattersize',13,'linkline',1);

for ii=1:8
   plot([0.852 1.852 2.8519 3.8519 4.8519 5.8519],[Data3(ii,1);Data3(ii,2);Data3(ii,3);Data3(ii,4);Data3(ii,5);Data3(ii,6)],'^:','color','(0.8,0.8,0.8)','MarkerSize',3)
   hold on
end
for ii=9:12
   plot([1.148 2.148 3.148 4.148 5.148 6.148],[Data3(ii,1);Data3(ii,2);Data3(ii,3);Data3(ii,4);Data3(ii,5);Data3(ii,6)],'v:','color','(0.8,0.8,0.8)','MarkerSize',3)
   hold on
end
ylim([0 0.05])
print('-depsc2','-painters',['Percentage of HB.eps']);
% %% 
%% %% 
c =  [0, 0, 0;...
      0, 0, 0;...
      0, 0, 0;...
      0, 0, 0];  
figure
%subplot(3,3,1)

group1=[ones(1,12) 2*ones(1,12)];
condition_names={'Day1' 'Day2' 'Day3' 'Day4' 'Day5' 'Day6' 'Day7' 'Day8' 'Day9' 'Day10' 'Day11' 'Day12' 'Day13'};
group_names1={'Low' 'High'};
h = daboxplot(Behavior,'groups',group1,'outliers',0,'outsymbol','k+',...
    'xtlabels',group_names1,'color',c,...
    'fill',0,'whiskers',1,'scatter',1,'jitter',0,'scattersize',13,'linkline',1);

for ii=1:12
   plot([0.852 1.852 2.8519 3.8519 4.8519 5.8519 6.8519 7.8519 8.8519 9.8519 10.8519],[Behavior(ii,1);Behavior(ii,2);Behavior(ii,3);Behavior(ii,4);Behavior(ii,5);Behavior(ii,6);Behavior(ii,7);Behavior(ii,8);Behavior(ii,9);Behavior(ii,10);Behavior(ii,11)],'^:','color','(0.8,0.8,0.8)','MarkerSize',3)
   hold on
end
for ii=13:24
   plot([1.148 2.148 3.148 4.148 5.148 6.148 7.148 8.148 9.148 10.148 11.148],[Behavior(ii,1);Behavior(ii,2);Behavior(ii,3);Behavior(ii,4);Behavior(ii,5);Behavior(ii,6);Behavior(ii,7);Behavior(ii,8);Behavior(ii,9);Behavior(ii,10);Behavior(ii,11)],'v:','color','(0.8,0.8,0.8)','MarkerSize',3)
   hold on
end
%ylim([0 1])
print('-depsc2','-painters',['Behavior.eps']);
%% 
c =  [0, 0, 0;...
      0, 0, 0;...
      0, 0, 0;...
      0, 0, 0];  
figure
%subplot(3,3,1)

group1=[ones(1,10) 2*ones(1,2)];
condition_names={'Day1' 'Day2' 'Day3' 'Day4' 'Day5' 'Day6' 'Day7' 'Day8' 'Day9' 'Day10' 'Day11' 'Day12' 'Day13'};
group_names1={'Low' 'High'};
h = daboxplot(BBN_behavior,'groups',group1,'outliers',0,'outsymbol','k+',...
    'xtlabels',group_names1,'color',c,...
    'fill',0,'whiskers',1,'scatter',1,'jitter',0,'scattersize',13,'linkline',1);

for ii=1:10
   plot([0.852 1.852 2.8519 3.8519 4.8519 5.8519 6.8519 7.8519 8.8519 9.8519 10.8519 11.8519 12.8519],[BBN_behavior(ii,1);BBN_behavior(ii,2);BBN_behavior(ii,3);BBN_behavior(ii,4);BBN_behavior(ii,5);BBN_behavior(ii,6);BBN_behavior(ii,7);BBN_behavior(ii,8);BBN_behavior(ii,9);BBN_behavior(ii,10);BBN_behavior(ii,11);BBN_behavior(ii,12);BBN_behavior(ii,13)],'.:','color','(0.8,0.8,0.8)','MarkerSize',3)
   hold on
end

%ylim([0 1])
print('-depsc2','-painters',['BBN_perentage.eps']);
%% 
total_cell=size(data_line_eachcell,1);
G=[ones(total_cell,1);ones(total_cell,1)*2;ones(total_cell,1)*3;ones(total_cell,1)*4;ones(total_cell,1)*5;ones(total_cell,1)*6;ones(total_cell,1)*7;ones(total_cell,1)*8;ones(total_cell,1)*9;ones(total_cell,1)*10;ones(total_cell,1)*11;ones(total_cell,1)*12;ones(total_cell,1)*13];
X=[data_line_eachcell(:,1);data_line_eachcell(:,2);data_line_eachcell(:,3);data_line_eachcell(:,4);data_line_eachcell(:,5);data_line_eachcell(:,6);data_line_eachcell(:,7);data_line_eachcell(:,8);data_line_eachcell(:,9);data_line_eachcell(:,10);data_line_eachcell(:,11);data_line_eachcell(:,12);data_line_eachcell(:,13)];
%   vs = violinplot(X, G);
h=boxplot(X,G,'sym',' ', 'color','k');
hold on

a1=-0.1;b1=0.1;
ind=a1 + (b1-a1).*rand([length(G) 1]);       
plot(G+ind,X,'ko-','MarkerSize',5,'MarkerEdgeColor','none','MarkerFaceColor','k');

for ii=1:size(data_line_eachcell,1)
    plot([1 2 3 4 5 6 7 8 9 10 11 12 13],[data_line_eachcell(ii,1);data_line_eachcell(ii,2);data_line_eachcell(ii,3);data_line_eachcell(ii,4);data_line_eachcell(ii,5);data_line_eachcell(ii,6);data_line_eachcell(ii,7);data_line_eachcell(ii,8);data_line_eachcell(ii,9);data_line_eachcell(ii,10);data_line_eachcell(ii,11);data_line_eachcell(ii,12);data_line_eachcell(ii,13)],'o:','color','(0.8,0.8,0.8)','MarkerSize',3)
    hold on
end
box off
ylim([0 1])
print('-depsc2','-painters','BBN_behavior.eps')
% 
% 
% p1=signrank(data_line_eachcell(:,1),data_line_eachcell(:,2));
% p2=signrank(data_line_eachcell(:,2),data_line_eachcell(:,3))