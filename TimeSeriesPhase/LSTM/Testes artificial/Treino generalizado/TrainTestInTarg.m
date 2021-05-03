function [trainX, trainT, testX, testT] = TrainTestInTarg(inGroups, targGroups, ind)
%TrainTestInTarg Separa os grupos de K-Fold em conjuntos de treino e teste
%   Inputs:
%       - inGroups: celula k x 1 com cada um dos conjuntos de entrada da
%           rede, sendo k o valor do k-fold
%       - targGroups: celula k x 1 com cada um dos conjuntos de target,
%          referentes ao respectivo inGroups
%       - ind: indice de valor entre 1 e k, referente ao grupo a ser
%           separado para teste. Os demais sao de treino
%   Outputs:
%       - trainX: celula com as sequencias usadas para treinamento
%       - trainT: celula com as sequencias de saidas referentes as entradas
%           de trainX
%       - testX: celula com as sequencias usadas para teste
%       - testT: celula com as sequencias de saidas referentes as entradas
%           de testX
    
    %Quantos grupos existem
    k = size(inGroups,1);
    
    %Separa o conjunto de teste
    testX = inGroups{ind};
    testT = targGroups{ind};
    
    %Recupera o conjunto de treino
    trainX = {};
    trainT = {};
    for i = 1:k
        if i~=ind
            trainX = [trainX;inGroups{i}];
            trainT = [trainT;targGroups{i}];
        end
    end
    

end

