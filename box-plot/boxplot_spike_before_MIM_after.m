
% 每个细胞前中后的boxplot�?
figure
subplot(3,8,1)
total_cell=size(data_line_eachcell,1);
G=[ones(total_cell,1);ones(total_cell,1)*2;];
X=[data_line_eachcell(:,1);data_line_eachcell(:,2);];
%   vs = violinplot(X, G);
h=boxplot(X,G,'sym',' ', 'colors',[202 72 81]/255);
hold on

% a1=-0.1;b1=0.1;
% ind=a1 + (b1-a1).*rand([length(G) 1]);       
% plot(G+ind,X,'ko-','MarkerSize',5,'MarkerEdgeColor','none','MarkerFaceColor',[180 180 180]/255)

for ii=1:size(data_line_eachcell,1)
    plot([1 2],[data_line_eachcell(ii,1) data_line_eachcell(ii,2)],'o-','color',[180 180 180]/255,'MarkerSize',5)
    hold on
end
box off
ylim([0 12])
print('-depsc2','-painters','13cell_spike_beforeONafter_20210209.eps')


p1=signrank(data_line_eachcell(:,1),data_line_eachcell(:,2));
% p2=signrank(data_line_eachcell(:,2),data_line_eachcell(:,3))