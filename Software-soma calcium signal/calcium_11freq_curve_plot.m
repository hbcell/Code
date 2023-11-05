function calcium_11freq_curve_plot(CalValue_directory,results_directory,x_label,cellnum)

load([CalValue_directory 'calcium_dff_allfocus'])
%colorcode=[1 0 0;0 1 0; 0 0 1; 0 0 0; 0.5 0.5 0.5];
colorcode=jet(5);
h=figure;
subplot(2,2,1)
hold on
temp_mean_focus=[];
temp_std_focus=[];
for focusnum=1:size(calcium_dff_allfocus)
    temp_mean=calcium_dff_allfocus{focusnum,1}(cellnum,:);
    temp_std=calcium_dff_allfocus{focusnum,2}(cellnum,:);    
    errorbar(temp_mean,temp_std,'color',colorcode(focusnum,:))
    set(gca,'FontSize',15)
    xlim([0.8 11.2])
    ylim([-0.1 1]) 
    set(gca, 'XTick', 1:11, 'XTickLabel', x_label);  
    temp_mean_focus=[temp_mean_focus,temp_mean];
    temp_std_focus=[temp_std_focus,temp_std];
end
set(h,'outerposition',get(0,'screensize')); 
saveas(h,fullfile(results_directory,['calcium_11freq_cellnum=' num2str(cellnum)]),'png') ;
saveas(h,fullfile(results_directory,['calcium_11freq_cellnum=' num2str(cellnum)]),'epsc') ;
save([results_directory 'calcium_11freq' num2str(cellnum)],'temp_mean_focus','temp_std_focus')
close