figure
load('iso_1%_nonhb.mat');
total_cell=size(data_line_eachcell,1);
G=[ones(total_cell,1);ones(total_cell,1)*2;ones(total_cell,1)*3];%
X=[data_line_eachcell(:,1);data_line_eachcell(:,2);data_line_eachcell(:,3)];%
%   vs = violinplot(X, G);
h=boxplot(X,G,'sym',' ', 'color',[0 0 0]/255);
hold on

% a1=-0.1;b1=0.1;
% ind=a1 + (b1-a1).*rand([length(G) 1]);       
% plot(G+ind,X,'ko-','MarkerSize',5,'MarkerEdgeColor','none','MarkerFaceColor','k');

for ii=1:size(data_line_eachcell,1)
    plot([1 2 3],[data_line_eachcell(ii,1);data_line_eachcell(ii,2);data_line_eachcell(ii,3)],'.:','color','(0.8,0.8,0.8)','MarkerSize',3)%
    hold on
end
%box off
ylim([0 6])
print('-depsc2','-painters','iso_1%_nonhb.eps')
% 
% 
% p1=signrank(data_line_eachcell(:,1),data_line_eachcell(:,2));
% p2=signrank(data_line_eachcell(:,2),data_line_eachcell(:,3))