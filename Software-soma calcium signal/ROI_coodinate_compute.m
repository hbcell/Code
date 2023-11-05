function position_center=ROI_coodinate_compute()

% 制作一个矩阵
for i=1:500
    for j=1:500
        x(i,j)=i;
    end
end
for i=1:500
    for j=1:500
        y(i,j)=j;
    end
end
% 先读取roi文件
xy_pos={};position_all={};
position_center=[];
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
        position_center=[position_center;[x0,y0]];
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
            position_center=[position_center;[x0,y0]];
            % plot(x(in),y(in),'r+');
% %             text(g1,h1,num2str(i-1),'color','w','Fontname','Times New Roman','FontSize',10,'Fontweight','bold');
        end
    end
end