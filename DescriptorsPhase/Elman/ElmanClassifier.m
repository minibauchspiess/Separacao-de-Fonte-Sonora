
%***Carrega os parametros utilizados para obter as amostras***
SampleParams;

%***Cria a rede a ser utilizada***
net = NetParams();


%Geracao das amostras, com K groups
[X, T] = InputMatHandler(samplesFolder, cbFolder, outCb, flFolder, outFl, winSize, seqSize, k);


%***Treinamento da rede***
TrainingHandler;
