%% 画出散点
%load('E:\from LiRuijie\cell attached (all data)\condition(burst)\cell_attched_data_analysis_version1.mat')
%load('E:\from LiRuijie\cell attached (all data)\condition(burst)\cell_attched_data_analysis_version1_allcondition.mat')

% % figure
% % hold on
% % color_ind=1;nn=1;totaltrial=0;spike_latency=[];spike_duration_all={};spike_duration_all_matrix=[];spike_interval=[];
% % spike_number_neuron_50ms=[];spike_number_matrix_50ms=[];spike_number_neuron_500ms=[];spike_number_matrix_500ms=[];
% % [~,ind3]=sort(temp_MinAll,'descend');
% % % 把nan的跳过
% % spike_duration_all_matrix_dataraw_all={};
% % ind2=ind3(length(temp_MinAll(isnan(temp_MinAll)))+1:end);
% % %ind2=ind2([4 18 16 8 15 11 13 19 21]);
% % %ind2=[ind2(1);ind2(3);ind2(5);ind2(13);ind2(15);ind2([2 4 6:12 15:16]);ind2(14)];
% % for j=1:length(ind2)
% %     spike_duration_all_matrix_dataraw={};       
% %         temp_1=[];
% %         if mod(color_ind,2)==0
% %              color_value=[0 0 0]; 
% %              color_fill=[0.9 0.9 0.9];
% %         else
% %              color_value=[0 0 0]/255;
% %              color_fill=[1 1 1];
% %         end    
% %         temp_1=spike_time_temp_all{ind2(j),4};
% %         if length(temp_1)>3
% %             ind_trial=[];
% % % %             if length(temp_1)>15
% % %                 aa=randperm(length(temp_1));
% % %                 ind_trial=aa(1:15);
% % % %                 ind_trial=1:15;
% % % %             else
% %                 ind_trial=1:length(temp_1);
% % % %             end
% % 
% %             if color_fill(1) < 1
% %             x=[-99 500 500 -99];
% %             y=[totaltrial+0.5 totaltrial+0.5 totaltrial+length(temp_1(ind_trial)) totaltrial+length(temp_1(ind_trial))];
% %             %H_F3=fill(x,y,color_fill,'edgecolor','none','facealpha',0.5);
% %             H_F3=patch(x,y,color_fill);
% %             set(H_F3,{'LineStyle'},{'none'})
% %             end
% % 
% % 
% %     %         [~,ind]=sort(temp_1,'descend');
% %             ind=1:length(temp_1);
% %             temp_2=spike_time_temp_all{ind2(j),1};
% %             spike_duration={};spike_number_50ms=[];spike_number_500ms=[];
% %             spike_number_afterstmuli=[];
% %             for serisNum=ind_trial
% %                 spike_time_temp_2=temp_2{ind(serisNum),1};
% %                 for dotNum=1:length(spike_time_temp_2)
% %                     plot(spike_time_temp_2(dotNum),nn,'o','color',color_value,'MarkerSize',2,'MarkerFaceColor',color_value);   
% %                     hold on
% %                 end
% %                nn=nn+1;
% %               totaltrial=totaltrial+1;
% %               
% %               % 调入spikenum.mat，则表示前后500ms内
% %               spike_time_temp_20=spike_time_temp_2(spike_time_temp_2<=0);%挑选小于0的散点
% %               spike_time_temp_21=spike_time_temp_2(spike_time_temp_2>0); %挑选大于0的散点
% % 
% %               
% %               if length(spike_time_temp_21)==1
% %                  spike_interval=spike_interval; 
% %               else
% %                  spike_interval=[spike_interval;spike_time_temp_21(2:end,1)-spike_time_temp_21(1:end-1,1)]; % spike interval计算的是刺激以后的散点的spike interval的均值。
% %               end    
% %               spike_number_500ms=[spike_number_500ms;2*(length(spike_time_temp_21)-length(spike_time_temp_20))];
% %               spike_number_matrix_500ms=[spike_number_matrix_500ms;2*(length(spike_time_temp_21)-length(spike_time_temp_20))];
% %               
% %               spike_number_50ms=[spike_number_50ms;2*(length(spike_time_temp_21(spike_time_temp_21<50))-length(spike_time_temp_20(spike_time_temp_20>-50)))];  %50ms 内
% %               spike_number_matrix_50ms=[spike_number_matrix_50ms;2*(length(spike_time_temp_21(spike_time_temp_21<50))-length(spike_time_temp_20(spike_time_temp_20>-50)))];
% %               spike_number_afterstmuli=[spike_number_afterstmuli;length(spike_time_temp_21)];
% %               
% %               spike_latency=[spike_latency;min(spike_time_temp_2(spike_time_temp_2>0))];
% %               spike_duration=[spike_duration;spike_time_temp_2];
% %               spike_duration_all_matrix=[spike_duration_all_matrix;spike_time_temp_2];
% %               spike_duration_all_matrix_dataraw=[spike_duration_all_matrix_dataraw;spike_time_temp_all{ind2(j),5}{serisNum,1}];
% %             end   
% %             
% %             
% % % %             %画某个neuron的统计曲线
% % % %             h=figure;
% % % %             subplot(1,2,2)
% % % %             hist(spike_duration,-95:10:195); 
% % % %             set(gca,'ylim',[0 20])
% % % %             set(gca,'xlim',[-100 200])
% % % %             hold on
% % % %             yt=0:1:10;
% % % %             xt=0*ones(length(yt));
% % % %             plot(xt,yt,'r--','LineWidth',2);
% % % %             saveas(h,[spike_time_temp_all{ind2(j),2} 'cell attached trace'],'png')
% % % %             close(h)
% % 
% % 
% %             spike_duration_all{color_ind,1}=spike_duration;
% %             
% %             spike_duration_all{color_ind,2}=spike_time_temp_all{ind2(j),2};
% %             spike_duration_all{color_ind,3}=ind_trial;
% %             spike_duration_all{color_ind,4}=spike_time_temp_all{ind2(j),5};
% %             spike_duration_all{color_ind,5}=mean(spike_number_50ms);
% %             spike_duration_all{color_ind,6}=mean(spike_number_500ms);
% %             spike_duration_all{color_ind,7}=mean(spike_number_afterstmuli);
% %             
% %             spike_number_neuron_500ms(color_ind,1)=mean(spike_number_500ms);
% %             spike_number_neuron_50ms(color_ind,1)=mean(spike_number_50ms);
% % 
% %              text(550,nn,spike_time_temp_all{ind2(j),2},'color',color_value);
% %              color_ind=color_ind+1;
% % 
% %              %rectangle('Position',[0,500,nn-1,nn-1],'LineWidth',2,'LineStyle','-');
% % 
% %         end
% %             spike_duration_all_matrix_dataraw_all{color_ind,1}=spike_duration_all_matrix_dataraw;
% %             spike_duration_all_matrix_dataraw_all{color_ind,2}=spike_time_temp_all{ind2(j),2};
% % 
% % % %     end
% % 
% % end
% % 
% % set(gca,'Xlim',[-100 500])
% % set(gca,'FontSize',15);
% % xlabel('Time (ms)'); 
% % ylabel('Trials');
% % 
% % %trigger
% % %yt=0:10:500;
% % yt=0:10:totaltrial;
% % xt=0*ones(length(yt));
% % plot(xt,yt,'r--','LineWidth',2);
% % 
% % %trigger
% % %yt=0:10:500;
% % yt=0:10:totaltrial;
% % xt=50*ones(length(yt));
% % plot(xt,yt,'r--','LineWidth',2);
% % 
% % timenow=datestr(now,29);
% % %filename=['(' timenow ')'  ' cell attached sandian black(naive) '];  
% % filename=['(' timenow ')'  ' cell attached in condition mice'];  
% % %filename=['(' timenow ')'  ' cell attached sandian black(nonburst)'];  
% % title(filename)
% % save('spike_duration_all_final_20180710.mat','spike_duration_all','spike_duration_all_matrix','spike_latency','spike_duration_all_matrix_dataraw_all')
% %  save('spike_duration_all_final_20180710_allcondition.mat','spike_duration_all','spike_duration_all_matrix','spike_latency','spike_duration_all_matrix_dataraw_all','spike_interval')
% %  save('spike_duration_all_final_20180717_condition_spikenum_500ms50ms.mat','spike_duration_all','spike_duration_all_matrix','spike_latency','spike_duration_all_matrix_dataraw_all','spike_interval','spike_number_neuron_50ms','spike_number_matrix_50ms'...
% %  ,'spike_number_neuron_500ms','spike_number_matrix_500ms')
% % save('spike_duration_all_final_20180717_nonburst_spikenum_500ms50ms.mat','spike_duration_all','spike_duration_all_matrix','spike_latency','spike_duration_all_matrix_dataraw_all','spike_interval','spike_number_neuron_50ms','spike_number_matrix_50ms'...
% %       ,'spike_number_neuron_500ms','spike_number_matrix_500ms')
% %   save('spike_duration_all_final_20180717_naive_spikenum_500ms50ms.mat','spike_duration_all','spike_duration_all_matrix','spike_latency','spike_duration_all_matrix_dataraw_all','spike_interval','spike_number_neuron_50ms','spike_number_matrix_50ms'...
% %       ,'spike_number_neuron_500ms','spike_number_matrix_500ms')
% % save('spike_duration_all_final_20200727_condition.mat','spike_duration_all','spike_duration_all_matrix','spike_latency','spike_duration_all_matrix_dataraw_all','spike_interval','spike_number_neuron_50ms','spike_number_matrix_50ms'...
% %       ,'spike_number_neuron_500ms','spike_number_matrix_500ms')
% % save('spike_duration_all_final_20200326_naive.mat','spike_duration_all','spike_duration_all_matrix','spike_latency','spike_duration_all_matrix_dataraw_all','spike_interval','spike_number_neuron_50ms','spike_number_matrix_50ms'...
% %       ,'spike_number_neuron_500ms','spike_number_matrix_500ms')
% %   
% % saveas(gcf,filename,'png')
% % saveas(gcf,filename,'fig')
% % print('-depsc2','-painters',[filename '.eps']);

%% trained 按照反应强度从大到小，图上从上到下排序20180727
% 先运行前面段程序，知道每个neuron的ap平均发放数，然后再画图
%load('E:\from LiRuijie\cell attached (all
%data)\condition(burst)\spikenum_20180727')  这个不晓得从哪里来得，还没有找到，先不排序了
%load('V:\Li Ruijie\data\cell-attach\analysis\cell_attched_data_analysis_version3.mat')

load('cell_attched_data_analysis_version3.mat')
figure
hold on
color_ind=1;nn=1;totaltrial=0;spike_latency=[];spike_duration_all={};spike_duration_all_matrix=[];spike_interval=[];
last_spike=[];
spike_number_neuron_50ms=[];spike_number_matrix_50ms=[];spike_number_neuron_500ms=[];spike_number_matrix_500ms=[];spike_number_neuron_250ms=[];spike_number_matrix_250ms=[];
spike_duration_all_matrix_dataraw_all={};
% 按照spikenum的顺序画出来
for num=1:size(spike_time_temp_all,1)
%for num=[7 9 10 12:15 18 16]  % 单独画选定的9个细胞
    file_temp=spike_time_temp_all{num,2};  %本来是spikenum_mean
    for j=1:length(spike_time_temp_all) 
        if strcmp(file_temp,spike_time_temp_all{j,2})
            spike_duration_all_matrix_dataraw={};       
            temp_1=[];
            if mod(color_ind,2)==0
                 color_value=[0 0 0]; 
                 color_fill=[0.9 0.9 0.9];
            else
                 color_value=[0 0 0]/255;
                 color_fill=[1 1 1];
            end    
            temp_1=spike_time_temp_all{j,4};
            if length(temp_1)>3
                
                ind_trial=1:length(temp_1);

                if color_fill(1) < 1
                x=[-99 500 500 -99];
                y=[totaltrial+0.5 totaltrial+0.5 totaltrial+length(temp_1(ind_trial)) totaltrial+length(temp_1(ind_trial))];
                %H_F3=fill(x,y,color_fill,'edgecolor','none','facealpha',0.5);
                H_F3=patch(x,y,color_fill);
                set(H_F3,{'LineStyle'},{'none'})
                end

                ind=1:length(temp_1);
                temp_2=spike_time_temp_all{j,1};
                spike_duration={};spike_number_50ms=[];spike_number_500ms=[]; spike_number_250ms=[];
                spike_number_afterstmuli=[];
                for serisNum=ind_trial
                    spike_time_temp_2=temp_2{ind(serisNum),1};
                    for dotNum=1:length(spike_time_temp_2)
                        plot(spike_time_temp_2(dotNum),nn,'o','color',color_value,'MarkerSize',1.5,'MarkerFaceColor',color_value);   
                        hold on
                    end
                   nn=nn+1;
                  totaltrial=totaltrial+1;

                  % 调入spikenum.mat，则表示前后500ms内
                  spike_time_temp_20=spike_time_temp_2(spike_time_temp_2<=0);%挑选小于0的散点
                  spike_time_temp_21=spike_time_temp_2(spike_time_temp_2>0); %挑选大于0的散点

                  if length(spike_time_temp_21)==1
                     spike_interval=spike_interval; 
                  else
                     spike_interval=[spike_interval;spike_time_temp_21(2:end,1)-spike_time_temp_21(1:end-1,1)]; % spike interval计算的是刺激以后的散点的spike interval的均值。
                  end    
                  spike_number_500ms=[spike_number_500ms;2*(length(spike_time_temp_21)-length(spike_time_temp_20))];
                  spike_number_matrix_500ms=[spike_number_matrix_500ms;2*(length(spike_time_temp_21)-length(spike_time_temp_20))];

                  spike_number_50ms=[spike_number_50ms;2*(length(spike_time_temp_21(spike_time_temp_21<50))-length(spike_time_temp_20(spike_time_temp_20>-50)))];  %50ms 内
                  spike_number_matrix_50ms=[spike_number_matrix_50ms;2*(length(spike_time_temp_21(spike_time_temp_21<50))-length(spike_time_temp_20(spike_time_temp_20>-50)))];
                  spike_number_250ms=[spike_number_250ms;2*(length(spike_time_temp_21(spike_time_temp_21<250))-length(spike_time_temp_20(spike_time_temp_20>-250)))];  %50ms 内
                  spike_number_matrix_250ms=[spike_number_matrix_250ms;2*(length(spike_time_temp_21(spike_time_temp_21<250))-length(spike_time_temp_20(spike_time_temp_20>-250)))];
                  
                  
                  spike_number_afterstmuli=[spike_number_afterstmuli;length(spike_time_temp_21)];

                  spike_latency=[spike_latency;min(spike_time_temp_2(spike_time_temp_2>0))];                  
                  last_spike=[last_spike;max(spike_time_temp_2(spike_time_temp_2<500))]; %%%%改成500ms内的最大
                  spike_duration=[spike_duration;spike_time_temp_2];
                  spike_duration_all_matrix=[spike_duration_all_matrix;spike_time_temp_2];
                  spike_duration_all_matrix_dataraw=[spike_duration_all_matrix_dataraw;spike_time_temp_all{j,5}{serisNum,1}];
                end  
                
                spike_duration_all{color_ind,1}=spike_duration;
                spike_duration_all{color_ind,2}=spike_time_temp_all{j,2};
                spike_duration_all{color_ind,3}=ind_trial;
                spike_duration_all{color_ind,4}=spike_time_temp_all{j,5};
                spike_duration_all{color_ind,5}=mean(spike_number_50ms);
                spike_duration_all{color_ind,8}=mean(spike_number_250ms);
                spike_duration_all{color_ind,6}=mean(spike_number_500ms);
                spike_duration_all{color_ind,7}=mean(spike_number_afterstmuli);

                spike_number_neuron_500ms(color_ind,1)=mean(spike_number_500ms);
                spike_number_neuron_50ms(color_ind,1)=mean(spike_number_50ms);
                spike_number_neuron_250ms(color_ind,1)=mean(spike_number_250ms);

                 text(550,nn,spike_time_temp_all{j,2},'color',color_value);
                 color_ind=color_ind+1;

            end
                spike_duration_all_matrix_dataraw_all{color_ind,1}=spike_duration_all_matrix_dataraw;
                spike_duration_all_matrix_dataraw_all{color_ind,2}=spike_time_temp_all{j,2};

   end

    end
end
set(gca,'Xlim',[-100 500])
set(gca,'FontSize',15);
xlabel('Time (ms)'); 
ylabel('Trials');

%trigger
yt=0:10:totaltrial+10;
xt=0*ones(length(yt));
plot(xt,yt,'r--','LineWidth',2);

%trigger
yt=0:10:totaltrial+10;
xt=50*ones(length(yt));
plot(xt,yt,'r--','LineWidth',2);

% 水出来的时间
yt=0:10:totaltrial+10;
xt=150*ones(length(yt));
plot(xt,yt,'r--','LineWidth',2);

yt=0:10:totaltrial+10;
xt=170*ones(length(yt));
plot(xt,yt,'r--','LineWidth',2);

timenow=datestr(now,29);
filename=['(' timenow ')'  ' cell attached sandian black(condition)'];  
title(filename)

save('spike_duration_all_final_20220930_condition.mat','spike_duration_all','spike_duration_all_matrix','spike_latency','spike_duration_all_matrix_dataraw_all','spike_interval','spike_number_neuron_50ms','spike_number_matrix_50ms'...
      ,'spike_number_neuron_500ms','spike_number_matrix_500ms','spike_number_neuron_250ms','spike_number_matrix_250ms','last_spike')
  % 
saveas(gcf,filename,'png')
saveas(gcf,filename,'fig')
print('-depsc2','-painters',[filename '.eps']);
%%
num=5; 
data=nan(size(spike_duration_all{num,1},1),50);

for i=1:size(spike_duration_all{num,1},1)
    for j=1:size(spike_duration_all{num,1}{i,1},1)
        data(i,j)=spike_duration_all{num,1}{i,1}(j,1);        
    end
end