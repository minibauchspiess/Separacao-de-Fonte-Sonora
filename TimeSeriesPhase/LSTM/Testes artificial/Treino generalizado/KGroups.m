function [mixGroups, targetGroups] = KGroups(X, T, K)
%KGroups Recebe as possiveis entradas com respectivos targets, e retorna
%uma celula de K linhas com cada um dos grupos
%   Inputs:
%       - X: entradas mixadas. Eh uma celula nseq x 1, sendo:
%           - nseq eh o numero de sequencias. Cada sequencia eh um vetor
%               1 x nsmp, sendo nsmp quantas amostras estao na sequencia
%       - T: targets referentes a cada X. Eh uma celula nseq x nsrc, sendo:
%           - nsrc eh o numero de fontes que geraram o mix X correspondente
%       - K: parametro de K-Fold, em quantos grupos K eh dividido
%   
%   Outputs:
%       - mixGroups: celula K x 1 contendo pedacos de X
%       - targetGroups: celula K x 1 contendo pedacos de T

    nseq = size(X, 1);
    i = 1;

    mixGroups = cell(K, 1);
    targetGroups = cell(K, 1);

    while i <= nseq
        mixGroups{mod(i-1,K)+1}{end+1,:} = X{i};
        targetGroups{mod(i-1,K)+1}{end+1,:} = T{i};

        i = i+1;
    end

end

