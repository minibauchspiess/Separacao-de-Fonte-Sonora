function [fileNames] = GetFileNames(folder)
%GetFileNames retorna um vetor célula contendo todos os nomes de arquivos
%presentes em uma pasta especificada

    %Recupera os arquivos da pasta
    files = dir(folder);
    
    %Percorre todos os arquivos, utilizando apenas seus nomes para
    %preencher o vetor, e ignorando os 2 primeiros valores ('.' e '..')
    sz = size(files, 1);
    fileNames = cell(1, sz-2);
    for i=3:sz
        fileNames{i-2} = files(i).name;
    end
    
end

