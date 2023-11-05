%% �����N1_pool�Ļ����ϣ�����������Ĳ���Ŷ������������
% N7 calcium mean (single)
% cell_num = 9; %%%%%%%%%%%%%%%%%%%%%%%%%%�Լ�������Ҫ����cell
% stimuli_order=[6 3 11 7 10 5 9 2 4 1 8]; %%%%%%%%%%%%%%%%%%
% pathname = '.\All\a';%'W:\guanjiangheng\zhao\zhao/a/';
% %newfile=['.\Single' num2str(cell_num) 'analysis2'];
% results_directory=['.\single' num2str(cell_num)]; %%%%%%%%%%%%%%%%%%%%%%��һ��
% newfile=results_directory;
% calcium_plot_single_cell_mean_trace_in_line(results_directory,pathname,newfile,cell_num,stimuli_order)

% N8 ������ϸ����һ�� (һ��focusһ��focus�Ļ�)
% focus_name={'a','b','c','d','e','f','g'}';
% focus_name={'a','b','c','d','e','f'}';
focus_name={'a','b','c','d','e'}';
cell_num=1;
stimuli_order=1:11;%[6 3 7 5 9 2 4 1 8 10 11]; %%%%%%%%%%%%%%%%%%���
%x_label={'2k','2.7k','3.6k','4.9k','6.6k','8.9k','12.1k','16.3k','21.9k','29.6k','40k'}; %��Ӧ�Ĵ̼�Ƶ��
calcium_dff_allfocus={};
fig_y=0;%1����ͼ %0������
a=importdata('.\online analysis.txt'); %%%%%%%%%%%%%%%%% ���ļ��н���
time=a.data(:,2)/1000;
Fs_cal=20;
for i=1:size(focus_name,1)  
    pathname = ['.\All\' focus_name{i}];%'W:\guanjiangheng\zhao\zhao/a/'; 
    focus_name_now=focus_name{i};
    results_directory=['.\ALL cell\']; %%%%%%%%%%%%%%%%%%%%%%��һ��      
    [calcium_dff,calcium_dff_std,data_new_mean_all_trials_cell,data_new_trials_value]=...
        calcium_plot_all_cell_mean_trace_in_line(results_directory,pathname,cell_num,stimuli_order,focus_name_now,fig_y,Fs_cal,time);   

    calcium_dff_allfocus{i,1}=calcium_dff;
    calcium_dff_allfocus{i,2}=calcium_dff_std;
    calcium_dff_allfocus{i,4}=focus_name_now;
    calcium_dff_allfocus{i,3}=data_new_mean_all_trials_cell;
end
save([results_directory 'calcium_dff_allfocus'],'calcium_dff_allfocus')

% N8 ������ϸ����һ�� (һ��cellһ��cell�Ļ�)
CalValue_directory='.\ALL cell\'; % ��һ���Ѿ���õ�
results_directory=['.\ALL cell with 7 focus\'];
% focus_name={'a','b','c','d','e','f','g'}';
% focus_name={'a','b','c','d','e','f'}';
focus_name={'a','b','c','d','e'}';
x_label={'2k','2.7k','3.6k','4.9k','6.6k','8.9k','12.1k','16.3k','21.9k','29.6k','40k'};
fig_y=1;%1����ͼ %0������
Fs_cal=20;
calcium_plot_all_cell_focustogether(results_directory,CalValue_directory,fig_y,focus_name,x_label,Fs_cal)



% N9 ����ĳ��ϸ���ĸ���Ƶ�ʵ�mean+stdͼ,�������ֵ��
cell_num=10;
CalValue_directory='.\ALL cell\'; % ��һ���Ѿ���õ�
results_directory=['.\signel calcium value\'];
x_label={'2k','2.7k','3.6k','4.9k','6.6k','8.9k','12.1k','16.3k','21.9k','29.6k','40k'};
cellnum=2;
calcium_11freq_curve_plot(CalValue_directory,results_directory,x_label,cellnum)

% N10 ����ÿ��ϸ��topͼ����Ӧ��ǿ��Ƶ�� �Լ� pcolorͼ
CalValue_directory='.\ALL cell\'; % ��һ���Ѿ���õ�
results_directory=['.\Top_freq\'];
results_directory_polor=['.\pcolor'];
% focus_name={'a','b','c','d','e','f','g'}';
% focus_name={'a','b','c','d','e','f'}';
focus_name={'a','b','c','d','e'}';
threshold=0.5;
position_center=ROI_coodinate_compute();
calcium_freqpeak_topplot(CalValue_directory,results_directory,results_directory_polor,position_center,focus_name,threshold)


% ��ϸ������
results_directory='.\All pcolor new order';
% focus_name={'a','b','c','d','e','f','g'}';
% focus_name={'a','b','c','d','e','f'}';
focus_name={'a','b','c','d','e'}';
fig_y=0;
a=importdata('.\online analysis.txt');
time=a.data(:,2)/1000;
for i=1:size(focus_name,1)    
    pathname=['.\All cell\' focus_name{i,1}];    
    pcolor_newseris(pathname,results_directory)
end



