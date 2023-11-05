%position_center=ROI_coodinate_compute();
cell_xy=position_center';

colorcodes=colormap(jet(50));
close;
colorbar_max=1.2;%color map的色带幅值
data_intensity=linspace(0,colorbar_max,50);  
      

%
figure;
%subplot(2,3,1)
j=1;
set(gca,'FontSize',10);
hold on;   
DataPeakValuePoolMean_2=CalciumDataPoolMean_3(j,:); 


%for k=1:size(cell_xy,1)                      
    ParametersOutput.xy_all=cell_xy;    
    for i=1:length(DataPeakValuePoolMean_2)              
        ang=0:0.1:2*pi;  %ang=0:0.01:2*pi; 
        if  DataPeakValuePoolMean_2(i)>=0.8 %细胞的幅值
            r=16;                        
        else
            r=8;
        end 
        xp=r*cos(ang);yp=r*sin(ang);            
        [~,Position]=min(abs(DataPeakValuePoolMean_2(i)-data_intensity));
        colorcodes_amp=colorcodes(Position,:);
        x0=ParametersOutput.xy_all(1,i);
        y0=ParametersOutput.xy_all(2,i);
        pb=patch(x0+xp,y0+yp,colorcodes_amp,'LineStyle','none');    
%         viscircles([x0,y0],r,'Color',colorcodes_amp)
%         plot(x0,y0,'markersize',2,'Color',colorcodes_amp)
%         fill(x0,y0,colorcodes_amp)
        %alpha(pb,0.5);            
    end
%end
set(gca,'clim',[0 colorbar_max]);
axis image;
axis ij;
set(gca,'xlim',[0 600]);
set(gca,'ylim',[0 600]);
%colorbar
set(gcf,'PaperPositionMode','auto');     
axis ij;

filename='focus_';
saveas(gcf,filename,'png') ;
%saveas(gcf,filename,'eps') ;
%print mypic.eps -depsc2 -r600；
%saveas(gcf,filename,'png')
saveas(gcf,filename,'fig')
print('-depsc','-r0','-painters',[filename '.eps']);

