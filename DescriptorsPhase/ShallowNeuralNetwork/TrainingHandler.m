%Script responsavel pela etapa de treinamento da rede com os dados de
%entrada e targets


discartedNetCount = 0; %Contador para as redes não convergidas e descartadas
xTrain = cell(k,1);
xTarget = cell(k,1);
xTest = cell(k,1);
xTestTarget = cell(k,1);
for i = 1:k
    fprintf("Treinamento " + num2str(i) + "\n");
    %Separa os k grupos de treino
    xTrain{i} = [];
    xTarget{i} = [];
    for j = 1:k
        if i ~= j
            xTrain{i} = [xTrain{i}; groups{j}];
            xTarget{i} = [xTarget{i}; targets{j}];
        end
    end
    
    %Separa o grupo de testes
    xTest{i} = groups{i};
    xTestTarget{i} = targets{i};
    
    %Reinicia a rede
    net{n} = init(net{n});
    
    %Treina a rede, utilizando o grupo em questão
    [trainedNet{n}{i}, tr{n}{i}] = train(net{n}, xTrain{i}', xTarget{i}');
    
    %Caso a rede não tenha convergido, descarta resultado e treina outra
    while tr{n}{i}.perf(end) > 0.15
        discartedNetCount = discartedNetCount + 1;
        
        net = init(net);
        [trainedNet{n}{i}, tr{n}{i}] = train(net{n}, xTrain{i}', xTarget{i}');
    end
    
    
    %Utilizando o vetor de teste, para testar a acurácia da rede
    y{n}{i} = trainedNet{n}{i}(xTest{i}');
    
    %Gera matriz de confusao para este teste
    [conf{n}{i}, confMat{n}{i}] = confusion(xTestTarget{i}', y{n}{i});
end

%Calcula acuracia media das redes treinadas
meanAccuracy{n} = mean(1 - cell2mat(conf{n}))
varAccuracy{n} = var(1 - cell2mat(conf{n}))