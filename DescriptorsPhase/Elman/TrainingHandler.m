%Treina as k redes, com os grupos de teste e treino definidos
for i=1:k
    fprintf("Treinamento " + num2str(i) + "\n");
    %Monta as entradas de treino e teste
    [Xtrain{i},Ttrain{i},Xtest{i},Ttest{i}] = TrainTestKGroups(X,T,i);
    
    %Inicializa a rede e a treina
    net{n} = init(net{n});
    [trainedNet{n}{i}, tr{n}{i}] = train(net{n},Xtrain{i},Ttrain{i});
    
    %Testa a rede recém treinada, adquirindo sua performance e erro ao
    %longo do tempo
    Y{n}{i} = trainedNet{n}{i}(Xtest{i});
    [conf{n}{i}, confMat{n}{i}] = confusion(cell2mat(Ttest{i}), cell2mat(Y{n}{i}));
end


%Calcula acuracia media das redes treinadas
meanAccuracy{n} = mean(1 - cell2mat(conf{n}))
varAccuracy{n} = var(1 - cell2mat(conf{n}))