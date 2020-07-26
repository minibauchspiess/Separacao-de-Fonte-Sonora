%SourceClassifier - Classificador de fonte

%O programa abaixo aborda o problema da identificação do instrumento 
%musical em dois sinais de áudio distintos. Para tanto, cada sinal de áudio
%é separado em amostras de tamanhos iguais, e de cada amostra são extraídos
%5 descritores do som (spectral centroid, spread, slope, decrease e
%rolloff). Esses descritores serão utilizados para se determinar qual o
%instrumento tocado, utilizando-os como entrada numa rede neural rasa.
%A fim de analisar o desempenho da rede de forma mais aceita
%estatisticamente, será utilizado o método do k-fold, buscando qual a
%acurácia média das k redes treinadas. Redes que não convergiram não são
%consideradas para este propósito.




%***Parâmetros para pegar os dados das amostras***

outCb = [0 1];  %Saída da rede correspondente a um contrabaixo
outFl = [1 0];  %Saída da rede correspondente a uma flauta
folder = 'AmostrasSonoras/Samples-SC';  %Pasta onde estao armazenadas as amostras sonoras
files = {'Cb-ord-pp-1c- B4.aif' 'Fl-ord-B4-pp.aif'};    %Arquivos a serem utilizados na entrada da rede
targets = {outCb outFl};    %Qual a saída desejada da rede, considerando a ordem dos arquivos em "files"

winPerAudio = 180;  %Quantas amostras serão extraídas de cada áudio
winSize = 1024;     %Qual o tamanho de cada amostra extraído do sinal

k = 10;     %Quantidades de grupos do k-fold



%***Parametros da rede***

numIn = 1;              %Apenas um input, sendo este um vetor
numLay = 2;             %Duas camadas, sendo uma intermediária e outra de output
biasCon = [1; 1];       %Todas camadas com bias
inCon = [1; 0];         %Input se conecta apenas à camada intermediaria
layCon = [0 0; 1 0];    %Layer intermediaria não recebe entrada de si mesma e da última
                        %Ultima layer recebe entrada da intermediária e não recebe de si mesma
outCon = [0 1];         %Apenas última camada é conectada ao output

net = network(numIn, numLay, biasCon, inCon, layCon, outCon);   %Arquitetura da rede criada



%***Parametros para treinamento da rede***

net.adaptFcn = 'adaptwb';
net.divideFcn = 'dividerand'; %Divide-se o conjunto de treinamento aleatoriamente
net.divideParam.trainRatio = 0.8;   %Divisão dos conjuntos de treinamento, validação e teste
net.divideParam.valRatio = 0.2;
net.divideParam.testRatio = 0;  %O conjunto de teste é separado e testado manualmente, com o método de k-fold

net.performFcn = 'mse';     %Mean Square Error, medida de performance da rede
net.trainFcn = 'trainlm';   %Função de treino segue o modelo de Levenberg-Marquardt backpropagation
net.trainParam.epochs = 10000;  
net.trainParam.min_grad = 1e-15;
net.trainParam.max_fail = 2500;
net.trainParam.mu_max = 1e99;

net.plotFcns = {'plotperform','plotconfusion'};



%***Arquitetura das camadas da rede***

%Layer 1
net.layers{1}.name = 'Layer 1';
net.layers{1}.dimensions = 14;  %14 neurônios na camada intermediária
net.layers{1}.initFcn = 'initnw';
net.layers{1}.transferFcn = 'tansig';

%set Layer2
net.layers{2}.name = 'Layer 2';
net.layers{2}.dimensions = 2;   %2 neurônios na camada de saída (cada um indica a um dos instrumentos)
net.layers{2}.initFcn = 'initnw';
net.layers{2}.transferFcn = 'softmax';



%***Preparação das amostras por k-fold***

for i=1:size(files,2)
    %Extraindo os descritores de um sinal de áudio e inserindo-os em uma
    %matriz de entrada
    path = fullfile(folder, files{i});
    [X{i}, T{i}, fs] = BuildSampleMatrix(path, targets{i}, winSize, winPerAudio);
end

%Gerando grupos para k-fold
[kX, kT] = KfoldGroups(X, T, k);


%***Treinamento dos k grupos de amostras***

discartedNetCount = 0; %Contador para as redes não convergidas e descartadas
for i = 1:k
    %Separa os k grupos de treino
    xTrain{i} = [];
    xTarget{i} = [];
    for j = 1:k
        if i ~= j
            xTrain{i} = [xTrain{i}; kX{j}];
            xTarget{i} = [xTarget{i}; kT{j}];
        end
    end
    
    %Separa o grupo de testes
    xTest{i} = kX{i};
    xTestTarget{i} = kT{i};
    
    %Reinicia a rede
    net = init(net);
    
    %Treina a rede, utilizando o grupo em questão
    [trainedNet{i}, tr{i}] = train(net, xTrain{i}', xTarget{i}');
    
    %Caso a rede não tenha convergido, descarta resultado e treina outra
    while tr{i}.perf(end) > 0.15
        discartedNetCount = discartedNetCount + 1;
        
        net = init(net);
        [trainedNet{i}, tr{i}] = train(net, xTrain{i}', xTarget{i}');
    end
    
    
    %Utilizando o vetor de teste, para testar a acurácia da rede
    y{i} = trainedNet{i}(xTest{i}');
    
    %Gera matriz de confusao para este teste
    [conf{i}, confMat{i}] = confusion(xTestTarget{i}', y{i});
end

%Calcula acuracia media das redes treinadas
meanAccuracy = mean(1 - cell2mat(conf))
varAccuracy = var(1 - cell2mat(conf))
