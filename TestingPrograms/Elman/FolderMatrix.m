function [Xs, Ts] = FolderMatrix(folder, target, windowSize)
%FolderMatrix Recebe uma pasta contendo amostras sonoras, e gera um vetor
%célula com cada elemento sendo uma matriz gerada por um dos arquivos de
%áudio
    
    %Recupera o nome de cada arquivo que deve gerar uma matriz
    files = GetFileNames(folder);
    
    %Percorre cada arquivo, gerando sua matriz e a inserindo em outMat
    Xs = cell(1,size(files, 2));
    Ts = cell(1,size(files, 2));
    for i = 1:size(files, 2)
        %Monta o caminho
        filePath = fullfile(folder, files{i});
        
        %Monta uma matriz
        [Xs{i}, Ts{i}] = BuildDescMatrix(filePath, target, windowSize);
    end

end

