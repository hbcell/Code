%%

function convert_copy(pathname_data,pathname_s,pathname_des)
       read_path(pathname_s, pathname_des );
       move_data(pathname_data,pathname_des);    
end

function  read_path(pathname_s, pathanme_des )
    
    folders = dir(pathname_s);
    for ii = 3:length(folders)
        pathname_s_temp = [pathname_s '/' folders(ii).name];
        if isdir(pathname_s_temp)
            files = dir([pathname_s_temp '/*.txt']);
            name_pre =folders(ii).name;
            for jj = 1:length(files)
                if strcmp(files(jj).name,'data_user input.txt')
                    if ~exist([pathanme_des '/' name_pre(10:end-2) ])
                        mkdir([pathanme_des '/' name_pre(10:end-2) ]);
                    end
                    copyfile([pathname_s_temp '/' files(jj).name],[pathanme_des '/' name_pre(10:end-2) '/' [name_pre(10:end) '_s.txt']]);
                end
            end
        end
    end
end
%%
function move_data(pathname_data,pathname_des)
 
    
    folders = dir(pathname_data);
    
    for ii = 3:length(folders)
        pathname_data_temp = ([pathname_data '/' folders(ii).name]);
        
        if  isdir(pathname_data_temp )
            files = dir([pathname_data_temp '/*.txt']);
            name_pre =folders(ii).name;
            
            for jj= 1:length(files)
                name_temp = files(jj).name;
                if ~isempty(regexp(name_temp,'\D\d\d.txt')) | ~isempty(regexp(name_temp,'\D\d\ddf_f.txt')) | endsWith(name_temp,'df_f.txt')
                     
                     if ~exist([pathname_des '/' name_pre(10) ])
                        mkdir([pathname_des '/' name_pre(10:end-2)]);
                     end
                     copyfile([pathname_data_temp '/' files(jj).name], [pathname_des '/' name_pre(10:end-2) '/' [name_pre(10:end) '.txt']]);
                 
                end
               
            end
        end
        
    end
    

end

