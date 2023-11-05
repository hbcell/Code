function [] = calcium_dff_computed_pool(ImageSize,filter_label,fs_low)

% 制作一个矩阵
for i=1:ImageSize
    for j=1:ImageSize
        x(i,j)=i;
    end
end
for i=1:ImageSize
    for j=1:ImageSize
        y(i,j)=j;
    end
end
% 先读取roi文件
xy_pos={};position_all={};
[filename, pathname] = uigetfile('*.txt', 'Select an ROI.txt file');
fileID = fopen([pathname filename]);
ii_all = 0;  %record the number of cells
temp = cell(0);
A = [];
while ~feof(fileID)
    A = fgetl(fileID);
    ii_all = ii_all+1;
    temp{ii_all} = str2num(A);
   % A
end
fclose(fileID);
ii_all
%temp=textread('RegisteredRoi.txt');
%[m,n]=size(temp);
% cell_select = [];
for i=1:ii_all
    if temp{i}(3)==4
        a0=(temp{i}(4)+temp{i}(6))/2;
        b0=(temp{i}(5)+temp{i}(7))/2;
        a1=(temp{i}(6)-temp{i}(4))/2;
        b1=(temp{i}(7)-temp{i}(5))/2;
        g1=a0-a1/2;
        h1=b0;
        [c,d,z]=ellipsoid(a0,b0,0,b1,a1,0);
        c1=round(c(11,:));
        d1=round(d(11,:));
% %         hold on
% %         plot(c1,d1,'w','linewidth',1.0);
        [x0,y0] = centroid(c1,d1); 
        xy_pos{i,1}=[x0 y0];
        
        position_all{i,1}=[c1;d1];
% %         text(g1,h1,num2str(i-1),'color','w','Fontname','Times New Roman','FontSize',10,'Fontweight','bold');
    else if temp{i}(3)==6||temp{i}(3)==5
            num=3;
            clear a;
            clear b;
%             for k=4:length(temp{i})
%                 if temp{i}(k)~=0
%                     num=num+1;
%                 end
%             end
            for j=4:length(temp{i})
                if mod(j-3,2)~=0
                    a((j-2)/2)=temp{i}(j);
                else
                    b((j-3)/2)=temp{i}(j);
                end
            end
            g1=max(a);
            g2=min(a);
            h1=max(b);
            h2=min(b);
            a0=(g1+g2)/2;
            b0=(h1+h2)/2;
            a1=(g1-g2)/2;
            b1=(h1-h2)/2;
            g1=a0-a1/2;
            h1=b0+b1/3;
% %             hold on
% %             plot(a,b,':w','linewidth',1);
            [x0,y0] = centroid(a,b);             
            xv=a';yv=b';
            xv = [xv ; xv(1)]; yv = [yv ; yv(1)];%在原来数组基础上加上开始点，从而实现了首尾相连的多边形。
            in = inpolygon(x,y,xv,yv);            
            xy_pos{i,1}=[x0 y0];
            position_all{i,1}=[x(in)';y(in)'];
            % plot(x(in),y(in),'r+');
% %             text(g1,h1,num2str(i-1),'color','w','Fontname','Times New Roman','FontSize',10,'Fontweight','bold');
        end
    end
end

% 导入视频文件，批量计算
FolderNameSt=uigetdir('','please choose the *.avi folders');

FolderOffset=2;
listing=dir(FolderNameSt); 
if isempty(FolderNameSt)
    return
end

results_directory=FolderNameSt; 
figures_directory=fullfile(results_directory,'All analysis2');
 if exist(figures_directory,'dir')~=7
    mkdir(figures_directory);
    figures_visibility='on'; % either 'on' or 'off' (in any case figures are saved)
 end
figures_visibility='on'; 


gap=2;
data_deltaFf_cellNum_all={};
for folder_cnt=1:length(listing)-FolderOffset      
     if listing(folder_cnt+FolderOffset,1).isdir
         FileName=listing(folder_cnt+FolderOffset,1).name;
         FolderNameFull=[FolderNameSt '\' FileName]; 
         listing1=dir(FolderNameFull); 
         n=1;
        for folder_cnt_0=1:length(listing1)-FolderOffset    
            if ~listing1(folder_cnt_0+FolderOffset,1).isdir
                 FileName_0=listing1(folder_cnt_0+FolderOffset,1).name;
                 FolderNameFull_0=[FolderNameFull '\' FileName_0];                  
                if length(FileName_0)>3 && strcmp(FileName_0(end-3:end),'.avi')
                    % 读视频文件
                    xyloObj = VideoReader(FolderNameFull_0);
                    nFrames = xyloObj.NumberOfFrames;
                    vidHeight = xyloObj.Height;
                    vidWidth = xyloObj.Width;
                    Frequency=round(xyloObj.FrameRate);
                    
                    % 建立文件夹名为a01 a02等
                    figures_directory2=fullfile(figures_directory,FileName);
                     if exist(figures_directory2,'dir')~=7
                        mkdir(figures_directory2);
                        figures_visibility='on'; % either 'on' or 'off' (in any case figures are saved)
                     end
                    figures_visibility='on'; 

                    % 把data写到一块
                    mov_data_temp=read(xyloObj,1);
                    if length(size(mov_data_temp))==2
                        for movi=1:nFrames
                            mov_data_temp=read(xyloObj,movi);
                            mov_data(:,:,movi)=mov_data_temp;%(width+1:end-20,:);
                        end
                    else
                       for movi=1:nFrames                                
                            mov_data_temp=rgb2gray(read(xyloObj,movi));
                            mov_data(:,:,movi)=mov_data_temp;
                       end
                    end
                    
                   % 计算dff trace
                    Interval = 1;                    
                    Pixels=position_all;
                    nFrames=size(mov_data,3);
                    Cellnum=size(Pixels,1);
                    F=zeros([nFrames Cellnum]);
                    vidHeight = xyloObj.Height;
                    vidWidth = xyloObj.Width;
                    for fi=1:nFrames
                        mov_cdata=mov_data(:,:,fi);
                        for ci=1:Cellnum
                            xi = Pixels{ci}(1,:);
                            xi(xi==0)=1;      
                            yi = Pixels{ci}(2,:);
                            yi(yi==0)=1; 
                            %inpolygon函数
% %                             xv=xi';yv=yi';
% %                             xv = [xv ; xv(1)]; yv = [yv ; yv(1)];%在原来数组基础上加上开始点，从而实现了首尾相连的多边形。
% %                             in = inpolygon(x,y,xv,yv);
                            % plot(x(in),y(in),'r+')                          
% %                           ind=sub2ind([vidHeight vidWidth],y(in),x(in));
                            ind=sub2ind([vidHeight vidWidth],yi,xi);
                            F(fi,ci)=mean(mov_cdata(ind));
                        end
                    end
                    F_ave=mean(F);
                    dF_data=zeros(size(F));
                    dF_data_raw=zeros(size(F));
                    for ii=1:Cellnum
                        F_temp=(F(:,ii)-F_ave(ii))/F_ave(ii);                        
%                         %做filter   
                        if filter_label==1
                            Wn=[fs_low/(Frequency/2)]; % fs_low
                            [fb,fa] = butter(2,Wn,'low');
                            F_temp_filter  = filtfilt(fb,fa,F_temp);                        
                            dF_data_raw(:,ii)=F_temp_filter;
                        else                        
                            dF_data_raw(:,ii)=F_temp;  
                        end
                    end                      
                    save([figures_directory2 '\' FileName 'df_f.txt'],'dF_data_raw','-ascii')                      
                end
            end
        end
     end
end
