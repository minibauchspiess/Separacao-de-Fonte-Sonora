%Script utilizado para editar as opções relacionadas às amostras utilizadas
%pelo programa principal (localização, valor de target...)

outCb = [0; 1];  %Saída da rede correspondente a um contrabaixo
outFl = [1; 0];  %Saída da rede correspondente a uma flauta
folder = '../Samples-SC/';  %Pasta onde estao armazenadas as amostras sonoras
cbFolder = 'ppCbFiles';
flFolder = 'ppFlFiles'; 

winSize = 1024;     %Qual o tamanho de cada amostra extraído do sinal
winPerAudio = 100;  %Quantas amostras serão extraídas de cada áudio
numDivisions = 25;  %Em quantas vezes o sinal de áudio é dividido para compor uma entrada
