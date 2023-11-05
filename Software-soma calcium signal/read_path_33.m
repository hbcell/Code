function  [fileID]=read_path_33(directory_raw)
    
    folders = dir(directory_raw);
    for ii = 3:length(folders)
        pathname_s_temp = [directory_raw '/' folders(ii).name];
        if isdir(pathname_s_temp)
            files = dir([pathname_s_temp '/*.txt']);
            name_pre =folders(ii).name;
            for jj = 1:length(files)
                if strcmp(files(jj).name,'data_real-time imaging_convertedRoi.txt')
                    fileID = fopen([pathname_s_temp '/' files(jj).name]);
                end
            end
        end
    end
end