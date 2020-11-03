
%***Carrega os parametros utilizados para obter as amostras***
SampleParams;

%***Cria a rede a ser utilizada***
net = NetParams();


%Geracao das amostras, com K groups
[CbMats, cbTargets] = FolderMatrix(fullfile(folder,cbFolder), outCb, winSize, winPerAudio);
[FlMats, flTargets] = FolderMatrix(fullfile(folder,flFolder), outFl, winSize, winPerAudio);

[X, T] = BuildKGroups({CbMats,FlMats}, {cbTargets,flTargets}, numDivisions);

%Apresenta na tela o valor de K que esta sendo utilizado
k = size(X,2);
fprintf("O valor de K é %d\n", k);


%Treina as k redes, com os grupos de teste e treino definidos
for i=1:k
    %Monta as entradas de treino e teste
    [Xtrain{i},Ttrain{i},Xtest{i},Ttest{i}] = TrainTestKGroups(X,T,i);
    
    %Inicializa a rede e a treina
    net = init(net);
    trainedNet{i} = train(net,Xtrain{i},Ttrain{i});
    
    %Testa a rede recém treinada, adquirindo sua performance e erro ao
    %longo do tempo
    Y{i} = trainedNet{i}(Xtest{i});
    [conf{i}, confMat{i}] = confusion(cell2mat(Ttest{i}), cell2mat(Y{i}));
end