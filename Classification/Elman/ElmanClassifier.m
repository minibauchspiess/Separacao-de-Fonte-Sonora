
%***Carrega os parametros utilizados para obter as amostras***
SampleParams;

%***Parametros de da rede***
numNeurons = [10 20 30 40];

%Geracao das amostras, com K groups
[X, T] = InputMatHandler(samplesFolder, cbFolder, outCb, flFolder, outFl, winSize, seqSize, k);

for n = 1:size(numNeurons,2)
    %***Cria a rede a ser utilizada***
    net{n} = NetParams(numNeurons(n));

    %***Treinamento da rede***
    tic;    %Contagem de tempo
    TrainingHandler;
    
    elTime(n) = toc;
    fprintf("Treino com "+numNeurons(n)+" neuronios finalizado em "+floor(elTime(n)/60)+"m"+floor(mod(elTime(n),60))+"s\n");
end

save Resultados/cbfl_6files_ABCDFG4pp
