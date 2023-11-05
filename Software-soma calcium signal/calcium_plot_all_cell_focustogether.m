function calcium_plot_all_cell_focustogether(results_directory,CalValue_directory,fig_y,focus_name,x_label,Fs_cal)

 mkdir(results_directory)
 load([CalValue_directory 'calcium_dff_allfocus'])

 if fig_y==1     
 for cellnum=1:size(calcium_dff_allfocus{1,1},1)
      h=figure;
      hold on
      set(h,'Visible','off');%≤ªµØ≥ˆ¿¥
         for stimuli=1:11
             for focusnum=1:size(calcium_dff_allfocus,1)         
                data_new=calcium_dff_allfocus{focusnum,3}{cellnum,1}{stimuli,1};             
                data_new_mean=mean(data_new,2);         
                subplot(6,11,(focusnum-1)*11+stimuli)   
%                 subplot(1,11,(focusnum-1)*11+stimuli)        
                for kk=1:size(data_new,2)          
                    plot((0:size(data_new,1)-1)/Fs_cal , data_new(:,kk),'color',[220 220 220]/255);
                    hold on
                    line([1 1],[-0.5 2.5],'LineStyle','--','LineWidth',1,'color',[0 0 0]/255);             
                    set(gca,'ylim',[-0.5 2.5]); %%%%%%%%%%%%%%%%%%% y÷·
                    set(gca,'xlim',[0 3]);
                    box off
                    axis off
                end    

                plot((0:size(data_new,1)-1)/Fs_cal ,data_new_mean,'color','r','LineWidth',2);
                if stimuli==1
                    title([focus_name{focusnum} ' cell#' num2str(cellnum)]) 
                elseif focusnum==1                
                    title(x_label(stimuli))
                end
              %  line([1 1],[min(data_new(:)) max(data_new(:))],'LineStyle','--','LineWidth',1,'color',[0 0 0]/255);   
                line([1 1],[-0.5 2.5],'LineStyle','--','LineWidth',1,'color',[0 0 0]/255); 
                set(gca,'ylim',[-0.5 2.5]); %%%%%%%%%%%%%%%%%%% y÷·
                set(gca,'xlim',[0 3]);                
                box off
                axis off
             end
         end            
            set(h,'outerposition',get(0,'screensize')); 
            saveas(h,fullfile(results_directory,['calcium transient_all_frequency_cellnum=' num2str(cellnum)]),'png') ;
            set(gcf,'PaperPositionMode','auto');
            print('-depsc2','-painters',fullfile(results_directory,['calcium transient_all_frequency_cellnum=' num2str(cellnum) '.eps']));
            %saveas(h,fullfile(results_directory,['calcium transient_all_frequency_cellnum=' num2str(cellnum)]),'epsc') ;
            close            
         end 
     end
 end

