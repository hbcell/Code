% N4 calcium computed,����All analysis2�ļ���
ImageSize=600;
calcium_dff_computed_pool(ImageSize)  % һ��roiȫ������

directory_raw='.\';
calcium_dff_computed_pool_each(directory_raw,ImageSize) %һ��trialһ��roi���Լ����

% N5 covert
pathname_data = '.\All analysis2'; %df/f
pathname_s = '.\'; % stimulation
pathname_des = '.\All'; %destination 
convert_copy(pathname_data,pathname_s,pathname_des)

% N6 dff and stimulus
focus_name={'a','b','c','d','e','f','g'}';
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







