function [X, T] = BuildRequestedInput(folder, inputsFiles, targets, numDivisions, winSize, winPerAudio)
%BuildRequestedInput: Função para gerar os vetores de entrada e de target
%para treino da rede.
%   Em inputsFiles está contida a informação dos pedaços de áudio a serem
%   utilizados como entrada. Essa função lê os arquivos, retira os
%   descritores inseridos neles, divide as amostras em tamanhos iguais e
%   monta as amostras de acordo com a sequência pedida, junto com seus
%   targets

    %Inicializa o vetor de amostras com a primeira amostra
    path = fullfile(folder, inputsFiles{1}{1});
    [X, T] = BuildDescInputCells(path, targets{1}, winSize, winPerAudio, inputsFiles{1}{2}, numDivisions);
    %Utiliza a funcao catsamples para unir os vetores da forma correta
    %X = catsamples(X, 'pad');
    %T = catsamples(T, 'pad');
    %Percorre o resto do vetor de amostras, utilizando catsamples para
    %uni-las
    for i=2:size(inputsFiles,2)
        %Recupera os descritores
        path = fullfile(folder, inputsFiles{i}{1});
        [xPart, tPart] = BuildDescInputCells(path, targets{i}, winSize, winPerAudio, inputsFiles{i}{2}, numDivisions);

        %Utiliza a funcao catsamples para unir os vetores da forma correta
        X = catsamples(X, xPart, 'pad');
        T = catsamples(T, tPart, 'pad');
    end
end

