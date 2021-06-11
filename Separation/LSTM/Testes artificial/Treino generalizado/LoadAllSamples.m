function [sources, fs] = LoadAllSamples(sinFolder, sqFolder, triFolder)

    
    sourcesNames{1} = fullfile(sinFolder,GetFileNames(sinFolder));
    sourcesNames{2} = fullfile(sqFolder,GetFileNames(sqFolder));
    sourcesNames{3} = fullfile(triFolder,GetFileNames(triFolder));
    
    for s = 1:3
        for samp = 1:size(sourcesNames{s}, 2)
            [sources(s,samp,:), fs] = audioread(sourcesNames{s}{samp});
        end
    end
end

