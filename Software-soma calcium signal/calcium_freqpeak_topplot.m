function calcium_freqpeak_topplot(CalValue_directory,results_directory,results_directory_polor,position_center,focus_name,threshold)
    
    mkdir(results_directory)
    mkdir(results_directory_polor)
    load([CalValue_directory 'calcium_dff_allfocus'])
    
    r=5;
    ang=0:0.01:2*pi; 
    xp=r*cos(ang);yp=r*sin(ang);
    colorcodes=[colormap(jet(11)) ; 0.8 0.8 0.8];
    colorbar_max=11; 
    
    h=figure;   
    freq_peak=[]; 
    freq_peak_value={};
    for focusnum=1:size(calcium_dff_allfocus)
        subplot(2,5,focusnum)
        hold on   
        temp1=[];
        for cellnum=1:size(calcium_dff_allfocus{focusnum,1},1)
            temp=calcium_dff_allfocus{focusnum,1}(cellnum,:);
            [value,ind]=max(temp);
            temp(temp<=threshold)=0;
            temp1=[temp1;temp];
            if value>threshold
                freq_peak(cellnum,focusnum)=ind;                
            else
                freq_peak(cellnum,focusnum)=12;                
            end
            colorcodes_amp=colorcodes(freq_peak(cellnum,focusnum),:);
            x0=position_center(cellnum,1)*0.4;%转成200*200um
            y0=position_center(cellnum,2)*0.4;
            pb=patch(x0+xp,y0+yp,colorcodes_amp,'edgecolor',colorcodes_amp);
            
            %alpha(pb,0.5);
        end
        %colormap jet
        colormap(colorcodes)
        freq_peak_value{focusnum,1}=temp1;        
        %set(gca,'clim',[0 colorbar_max]);
        colorbar
        axis image;
        axis ij;
        set(gca,'xlim',[0 200]);
        set(gca,'ylim',[0 200]);        
        title(focus_name{focusnum})
    end

    set(h,'outerposition',get(0,'screensize')); 
    saveas(h,fullfile(results_directory,['calcium_11freq_top']),'png') ;
    print('-depsc2','-painters',[results_directory 'calcium_11freq_top.eps']);
    close
    
    %% 画pcolor图,所有细胞
    h=figure; 
    hold on
    %set(h,'Visible','off');%不弹出来
    nn=1;
    pcolor_value_all={};
for cellnum=1:size(freq_peak_value{1,1},1)
    subplot(4,6,nn)
    pcolor_value=[];
    for focusnum=1:size(freq_peak_value)        
        pcolor_value=[pcolor_value;freq_peak_value{focusnum,1}(cellnum,:)];       
    end   
    %pcolor(pcolor_value)
    imagesc(pcolor_value)
    ylim([0.5 6.5]) 
    colormap jet  
    set(gca,'clim',[0.5 1]) 
    colorbar    
    title(['cell #' num2str(cellnum)])
   pcolor_value_all{cellnum,1}=pcolor_value;
    
    if nn==24 || cellnum==size(freq_peak_value{1,1},1)
        set(h,'outerposition',get(0,'screensize'));         
        saveas(h,fullfile(results_directory_polor,['calcium pcolor_cellnum=' num2str(cellnum)]),'png') ;
        saveas(h,fullfile(results_directory_polor,['calcium pcolor_cellnum=' num2str(cellnum)]),'epsc') ;
        close
        h=figure;
        set(h,'Visible','off');%不弹出来
        nn=1;            
    else
        nn=nn+1;            
    end
    
end
save([results_directory_polor '\pcolor.mat'],'pcolor_value_all')