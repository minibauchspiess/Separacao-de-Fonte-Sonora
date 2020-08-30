

%***Parâmetros para pegar os dados das amostras***

outCb = [-1; 1];  %Saída da rede correspondente a um contrabaixo
outFl = [1; -1];  %Saída da rede correspondente a uma flauta
folder = '../Samples-SC/';  %Pasta onde estao armazenadas as amostras sonoras
cbFiles = {'Cb-ord-pp-1c- B4.aif'};    %Arquivos de contra-baixo
flFiles = {'Fl-ord-B4-pp.aif'};    %Arquivos de flauta
targets = {outCb outFl};    %Qual a saída desejada da rede, considerando a ordem dos arquivos em "files"

%Sequência a ser utilizada na entrada. 
%Cada vetor na chave é uma entrada, seguindo o padrão:
%   -['inst', instNum, piece]:
%       - 'inst' é o 
xSeq = {['cb',1,1], ['fl',1,1], ['cb',1,2], ['cb',1,2]}; 


winPerAudio = 180;  %Quantas amostras serão extraídas de cada áudio
winSize = 1024;     %Qual o tamanho de cada amostra extraído do sinal



%***Parâmetros da rede***

net = elmannet(1, 14);      %Um delay na entrada, 14 neurônios na camada escondida
net.divideFcn = '';         %Todos os valores de entrada são para treino
net.layers{2}.transferFcn = 'softmax';      %Soma das entradas sempre igual a 1
net.trainFcn = 'trainlm';   %Treino com Levenberg-Marquardt
net.outputs{2}.processFcns = {'removeconstantrows'};    %Retira o default 'mapinmax' (necessario para 'softmax' funcionar'



%***Geração e tratamento das amostras***


flPath = fullfile(folder,flFiles{1});
cbPath = fullfile(folder,cbFiles{1});

[cbX, cbT] = BuildDescInputCells(cbPath, outCb, winSize, winPerAudio);  %Gera entrada de contra-baixo
[flX, flT] = BuildDescInputCells(flPath, outFl, winSize, winPerAudio);  %Gera entrada de flauta




%Montando uma entrada
X = {cbX{1,1:60} flX{1,1:60} cbX{1,61:120} flX{1,61:120}};
T = {cbT{1,1:60} flT{1,1:60} cbT{1,61:120} flT{1,61:120}};


%Prepara as amostras de treino
[Xs,Xi,Ai,Ts] = preparets(net,X,T);

%Treina a rede
%Sem tratamento dos dados de entrada
net = init(net);
net1 = train(net, X, T);
%Com tratamento dos dados de entrada
net = init(net);
net2 = train(net,Xs,Ts,Xi,Ai);

%Testa a rede
Xtest = {cbX{1,121:end} flX{1,121:end}};
Ttest = {cbT{1,121:end} flT{1,121:end}};

%net1:
Y1 = net1(Xtest);
perf1 = perform(net1, Ttest, Y1)

%net2
[XsTest,XiTest,AiTest,TsTest] = preparets(net,Xtest,Ttest);
Y2 = net2(XsTest,XiTest,AiTest);
perf2 = perform(net2, TsTest, Y2)
