function plot_cells_total(pathname,results_directory,fig_y)
%%
txt_files = dir([pathname '/*.txt']);
fig_y=0; %1 画图，0代表不画
figures_directory=results_directory;
     if exist(figures_directory,'dir')~=7
        mkdir(figures_directory);
        figures_visibility='on'; % either 'on' or 'off' (in any case figures are saved)
     end
figures_visibility='on'; 

data_filenames = cell(0);
stimulate_filenames = cell(0);
ci = 0;
for ii = 1:length(txt_files)
    filename = txt_files(ii).name;
    if length(filename)==7 
        ci = ci+1;
        data_filenames{ci} = filename;
        stimulate_filenames{ci} = [ filename(1:end-4) '_s'  '.txt'];
    end    
end

Fs_cal =40;       % ????????                              
Fs_cal_stim=12000; % ??????????

threshold = 5;
calclium_transient_extract_all = cell([length(data_filenames) 1]);

stimulate_all = cell(0);
data_all = cell(0);

for ii = 1:length(data_filenames)
    a = importdata([pathname '/' data_filenames{ii}]);
    if isstruct(a)
        CalciumData = a.data;
    else
        CalciumData=a;
    end
    
    b = importdata([pathname '/' stimulate_filenames{ii}]);
    if isstruct(b)
        StimulusData = b.data(:,2);
     else
        StimulusData = b(:,2);
    end

    thresholdx= 0.4*(max(StimulusData)-mean(StimulusData))+mean(mean(StimulusData)); % light_data????
    % Fs_cal=1;
    calclium_stimu_Time=(1:length(StimulusData))/Fs_cal_stim;
    position_above = find(StimulusData>thresholdx);
    pos_diff = position_above(2:end) - position_above(1:end-1);
    ind_above = [position_above(1) ;position_above(find(pos_diff>2)+1)];
    TriggerTime_cal = (ind_above-1)/Fs_cal_stim;% calclium_stimu_Time(ind_above);


    stimulate_all{ii} = TriggerTime_cal;
    data_all{ii} = CalciumData;
end
%%
stimulate_dt = [];
for ii = 1:length(stimulate_all)
    stimulate_dt =  [stimulate_dt ; -stimulate_all{ii}(1) + stimulate_all{1}(1)];
end

%%
time = (0:size(CalciumData,1)-1)/Fs_cal;
for ii = 1:size(CalciumData,2)
    if fig_y==1
       h = figure(1);
       set(h,'Visible','off');
    end
   for jj =1:length(data_filenames)
         data_all_cells_temp = data_all{jj};
        if  fig_y==1
             hold on;
             plot(time+stimulate_dt(jj),data_all_cells_temp(:,ii)+jj); % *0.5指的是两条trace之间的间隔
        end
%          for li = 1:length(stimulate_all{jj})
%              line([stimulate_all{jj}(li)+stimulate_dt(jj) stimulate_all{jj}(li)+stimulate_dt(jj)],[min(data_all_cells_temp(:,ii)+jj) max(data_all_cells_temp(:,ii)+jj)],'LineStyle','--','color','k','LineWidth',2);
%          end
         %line(stimulate_all{ii},[min(data_all_cells_temp(:,ii)+jj) max(data_all_cells_temp(:,ii)+jj)],'LineStyle','--','color','k');
   end
   
   if fig_y==1
          for li = 1:length(stimulate_all{1})
            line([stimulate_all{1}(li) stimulate_all{1}(li)],[0.5 1+jj],'LineStyle','--','color','k','LineWidth',2);% 0.5 yu
          end
           title(['cell:',num2str(ii)]);
           saveas(h,['calcium transient_cellNum_' num2str(ii)],'tif') ;
           saveas(h,['calcium transient_cellNum_' num2str(ii)],'fig') ;
           close all;
   end
    
end

save ([results_directory '\data_all'],'data_all')



















