%Script utilizado para editar as opções relacionadas às amostras utilizadas
%pelo programa principal (localização, valor de target...)

outCb = [0; 1];  %Saída da rede correspondente a um contrabaixo
outFl = [1; 0];  %Saída da rede correspondente a uma flauta
samplesFolder = '../../Samples/TrainSamples/';  %Pasta onde estao armazenadas as amostras sonoras
cbFolder = 'CbFiles';
flFolder = 'FlFiles'; 

winSize = 1024;     %Qual o tamanho de cada amostra extraído do sinal
seqSize = 4;  %Tamanho da sequencia de vetores

k = 10;     %Valor de K, para K-fold
