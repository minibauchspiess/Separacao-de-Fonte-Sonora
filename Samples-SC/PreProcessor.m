%Script para auxiliar no pré-processamento das amostras sonoras

file = "CbFiles/Cb-ord-ff-1c- B4.aif";  %Arquivo original, que sera preprocessado

[y, fs] = audioread(file);  %Leitura do arquivo

%Corte
xInit = 12500;
xEnd = 60000;

%Comparação entre nota original e o corte
plot(y);    
title('Original x Corte')
hold on

plot(xInit:xEnd,y(xInit:xEnd))
hold off

sound(y(xInit:xEnd), fs);   %Toca o sinal de audio, para confirmar que esta tudo certo

write = 1;  %Quando permitido, vai salvar o arquivo do tamanho e nome desejados

outFile = "ppCbFiles/Cb-ord-B4-ff-1c.wav";
if write
    audiowrite(outFile, y(xInit:xEnd),fs, 'Comment', num2str(xInit) + " " + num2str(xEnd));
end