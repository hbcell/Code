% N4 calcium computed,����All analysis2�ļ���
ImageSize=600;
pool_label=1;% 1 һ��roiȫ������ȫ������  % 2,һ��trialһ��roi���Լ����
if pool_label==1
    filter_label=2;% 1����filt
    
    fs_low=2;% low-pass filter
    calcium_dff_computed_pool(ImageSize,filter_label,fs_low)
else
    directory_raw='.\';
    calcium_dff_computed_pool_each(directory_raw,ImageSize)
end


% N5 covert
pathname_data = '.\All analysis2'; %df/f
pathname_s = '.\'; % stimulation
pathname_des = '.\All'; %destination 
convert_copy(pathname_data,pathname_s,pathname_des)

% N6 dff and stimulus
% focus_name={'a','b','c','d','e','f','g'}';
% focus_name={'a','b','c','d','e','f'}';
focus_name={'a'}';
Fs_cal=40;%%%%%% 1//0.1002;
results_directory='.\All plot';
x_label={'8.9K','3.6K','12.1K','6.6K','21.9K','2.7K','4.9K','2K','16.3K','29.6K','40K'}; %�ʹ̼���Ӧ���Լ��޸�
a=importdata('.\online analysis.txt'); %%%%%%%%%%%%%%%%% ���ļ��н���
time=a.data(:,2)/1000;
for i=1:size(focus_name,1)    
    pathname=['.\All\' focus_name{i,1}];    
    calcium_raw_trace_all(results_directory,pathname,x_label,Fs_cal,time)
end









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







