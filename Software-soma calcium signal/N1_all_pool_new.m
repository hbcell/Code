% N4 calcium computed,����All analysis2�ļ���
ImageSize=900;
pool_label=2;% 1 һ��roiȫ������ȫ������  % 2,һ��trialһ��roi���Լ����
register=1;%registerΪ1�������ȡ��У�����avi
if pool_label==1
    filter_label=2;% 1����filt    
    fs_low=2;% low-pass filter
    calcium_dff_computed_pool(ImageSize,filter_label,fs_low)
else
    directory_raw='.\';
    calcium_dff_computed_pool_each(directory_raw,ImageSize,register)  % û��filter
end
%% 
% N5 covert
% pathname_data = '.\All analysis2'; %df/f �Զ��������ȡ·��
 pathname_data ='P:\Li Ruijie\data\wide-field\0529'; % �Լ��ܵ���ȡ·��V:\Li Ruijie\data\Chords\130\1022
%pathname_data =''; % �Լ��ܵ���ȡ·��
pathname_s = '.\'; % stimulation
pathname_des = '.\All'; %destination 
convert_copy(pathname_data,pathname_s,pathname_des)

% N6 dff and stimulus
%focus_name={'a','g'}';
%focus_name={'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T'}';
focus_name={'A','B','C','D','E','F','G'}';
Fs_cal=40;%%%%%% 1//0.1002;
results_directory='.\All plot';
x_label=[];%,'3.6K','12.1K','6.6K','21.9K','2.7K','4.9K','2K','16.3K','29.6K','40K'}; %�ʹ̼���Ӧ���Լ��޸�
a=importdata('.\online analysis.txt'); %%%%%%%%%%%%%%%%% ���ļ��н���
time=a.data(:,2)/1000;
fig_eps=0; %fig_eps=1����Ҫ��Ϊeps��0������.  
for i=1:size(focus_name,1) 
    pathname=['.\All\' focus_name{i,1}]; 
    %calcium_raw_trace_all(results_directory,pathname,x_label,Fs_cal,time) %����ϸ�������trial��һ��
    calcium_raw_trace_all_cell(results_directory,pathname,x_label,Fs_cal,time,fig_eps) %һ��focus��ȫ��ϸ����һ��
end

% %cell_id=[10 12 20 26 2 10]; %%%%%%��ϸ�����
% %for i=1:size(focus_name,1)    
% %    pathname=['.\All\' focus_name{i,1}];  
% %    calcium_raw_trace_single_cell(results_directory,pathname,x_label,Fs_cal,time,fig_eps,cell_id)
% %end

% % % N8 calcium all cell
% % focus_name={'a','b','c','d','e'}';
% % results_directory='.\for polt mean value 2'; %%%%%%%%%%%%%%%%%%%%%%��һ��
% % cell_trigger_ind=1:3;   %%%%%%%%%%%%%%%%%%%%%%��һ�£�
% % neworder=[6 3 11 7 10 5 9 2 4 1 8];
% % for i=1:size(focus_name,1)    
% %     pathname=['.\All\' focus_name{i,1}]; 
% %     calcium_plot_all_cell_mean_value(pathname,results_directory,cell_trigger_ind,neworder)
% % end
% 







