%Treina as k redes, com os grupos de teste e treino definidos
for i=1:k
    fprintf("Treinamento " + num2str(i) + "\n");
    %Monta as entradas de treino e teste
    [Xtrain{i},Ttrain{i},Xtest{i},Ttest{i}] = TrainTestKGroups(X,T,i);
    
    %Inicializa a rede e a treina
    net = init(net);
    [trainedNet{i}, tr{i}] = train(net,Xtrain{i},Ttrain{i});
    
    %Testa a rede recém treinada, adquirindo sua performance e erro ao
    %longo do tempo
    Y{i} = trainedNet{i}(Xtest{i});
    [conf{i}, confMat{i}] = confusion(cell2mat(Ttest{i}), cell2mat(Y{i}));
end


%Calcula acuracia media das redes treinadas
meanAccuracy = mean(1 - cell2mat(conf))
varAccuracy = var(1 - cell2mat(conf))