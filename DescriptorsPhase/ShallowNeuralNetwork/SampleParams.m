
samplesFolder = '../../Samples/TrainSamples';  %Caminho até as amostras
cbFolder = "CbFiles";   %Pasta com as amostras de contrabaixo
flFolder = "FlFiles";   %Pasta com as amostras de flauta
outCb = [0 1];  %Saída da rede correspondente a um contrabaixo
outFl = [1 0];  %Saída da rede correspondente a uma flauta

winSize = 1024;     %Qual o tamanho de cada amostra extraído do sinal

k = 10;     %Quantidades de grupos do k-fold
