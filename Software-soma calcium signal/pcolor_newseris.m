function pcolor_newseris(pathname,results_directory)

mkdir(results_directory)

load([pathname '_calcium_deltaFF_all.mat'])

data_neworder={};
for stimuNum=1:size(calcium_dff,2)
    %排序
    data_value=calcium_dff(:,stimuNum);%刺激后1s的均值
    [~,order]=sort(data_value,'descend');
    data_neworder{stimuNum,1}=order;
end
save([results_directory '\data_neworder'],'data_neworder')

%%

 
data_temp_mean_all=data_new_mean_all_cell;
figure
for stimuNum=1:size(calcium_dff,2)
    data=[];
    for cellnum=1:size(data_temp_mean_all,1)
        data=[data;data_temp_mean_all{cellnum,1}(:,stimuNum)'];
    end
    
    subplot(3,4,stimuNum)
    data1=data(data_neworder{stimuNum,1},:);
    imagesc(data1)  
    colormap jet
    set(gca,'clim',[0 1])
end
saveas(gcf,[results_directory '\' pathname(end) '_calcium_mean_trace_neworder'],'fig')
save([results_directory '\' pathname(end) '_data_neworder'],'data_neworder')


