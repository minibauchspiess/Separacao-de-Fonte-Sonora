

%***Parâmetros para pegar os dados das amostras***
K = 10; %Valor K de treinamento (se não houverem grupos suficientes para a quantia requerida, será alterado para o maior valor possível)

outCb = [0; 1];  %Saída da rede correspondente a um contrabaixo
outFl = [1; 0];  %Saída da rede correspondente a uma flauta
folder = '../Samples-SC/';  %Pasta onde estao armazenadas as amostras sonoras
%cbFiles = {'Cb-ord-pp-1c- B4.aif', 'Cb-ord-mf-1c- B4.aif', 'Cb-ord-ff-1c- B4.aif'};    %Arquivos de contra-baixo
%flFiles = {'Fl-ord-B4-pp.aif', 'Fl-ord-B4-mf.aif', 'Fl-ord-B4-ff.aif'};    %Arquivos de flauta
cbFolder = 'CbFiles';
flFolder = 'FlFiles'; 


winSize = 1024;     %Qual o tamanho de cada amostra extraído do sinal
winPerAudio = 120;  %Quantas amostras serão extraídas de cada áudio
numDivisions = 3;   %Em quantas vezes o sinal de áudio é dividido para compor uma entrada

%Sequência a ser utilizada na entrada. 
%Cada vetor na chave é uma entrada, seguindo o padrão:
%   - [instFiles(elem), piece]:
%    
%       - "instFiles" é o conjunto de arquivos de um instrumento
%       - "elem" é o elemento dentro do conjunto de arquivos
%       - "piece" é qual pedaço do arquivo a ser utilizado (depende de
%         quantas vezes o arquivo é particionado)
inSeq = {{cbFiles{1},1}, {cbFiles{1},2}, {cbFiles{1},3}, {cbFiles{2},1}, {cbFiles{2},2}, {cbFiles{2},3}, {cbFiles{3},1}, {cbFiles{3},2}, {flFiles{1},1}, {flFiles{1},2}, {flFiles{1},3}, {flFiles{2},1}, {flFiles{2},2}, {flFiles{2},3}, {flFiles{3},1}, {flFiles{3},2}};

%Targets, seguindo a sequência apresentada acima
inSeqTargets = {outCb, outCb, outCb, outCb, outCb, outCb, outCb, outCb, outFl, outFl, outFl, outFl, outFl, outFl, outFl, outFl, outFl, outFl, outFl, outFl, outFl, outFl, outFl, outFl};


%Entradas de teste:
testCb = {{cbFiles{3},3}};
testCbTargets = {outCb};


testFl = {{flFiles{3},3}};
testFlTargets = {outFl};


%***Parâmetros da rede***

net = elmannet(1, 14);      %Um delay na camada escondida, 14 neurônios na camada escondida
net.divideFcn = '';         %Todos os valores de entrada são para treino
net.layers{2}.transferFcn = 'softmax';      %Soma das entradas sempre igual a 1
net.trainFcn = 'trainlm';   %Treino com Levenberg-Marquardt
net.outputs{2}.processFcns = {'removeconstantrows'};    %Retira o default 'mapminmax' (necessario para 'softmax' funcionar'
net.trainParam.min_grad = 1e-30;



%***Geração e tratamento das amostras***
[X, T] = BuildRequestedInput(folder, inSeq, inSeqTargets, numDivisions, winSize, winPerAudio);
[XtestCb, TtestCb] = BuildRequestedInput(folder, testCb, testCbTargets, numDivisions, winSize, winPerAudio);
[XtestFl, TtestFl] = BuildRequestedInput(folder, testFl, testFlTargets, numDivisions, winSize, winPerAudio);


net = init(net);
trainedNet = train(net, X, T);

Yfl = trainedNet(XtestFl);
yfl = cell2mat(Yfl);

Ycb = trainedNet(XtestCb);
ycb = cell2mat(Ycb);

tfl = cell2mat(TtestFl);
tcb = cell2mat(TtestCb);
%{

%***Treinamento***

%Prepara as amostras de treino e teste
[Xs,Xi,Ai,Ts] = preparets(net,X,T);
[XsTest,XiTest,AiTest,TsTest] = preparets(net,Xtest,Ttest);

%Treina numTraining redes, e calculAa a acurácia média delas
for i=1:K
    %Inicializa a rede, e a treina
    net = init(net);
    trainedNet{i} = train(net,Xs,Ts,Xi,Ai);
    
    %Testa a rede recém treinada, adquirindo sua performance e erro ao
    %longo do tempo
    Y{i} = trainedNet{i}(Xtest);%sTest, XiTest, AiTest);
    [conf{i}, confMat{i}] = confusion(cell2mat(Ttest), cell2mat(Y{i}));
end

%***Validação da rede***
meanAccuracy = mean(1 - cell2mat(conf))
varAccuracy = var(1 - cell2mat(conf))
%}