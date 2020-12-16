function [centroid, spread, slope, decrease, rolloff] = GetDescriptors(y, Fs, windowSize, windowCount)

%GetDescriptors: essa funcao divide um sinal de áudio recebido em uma
%quantidade específica, e pra cara pedaço do sinal, extrai seus descritores
%(centroid, spread, slope, decrease e rolloff)


%Dividindo o sinal em pedaços do tamanho de batchSize, para eliminar
%trechos não necessarios, pegando apenas o centro do sinal

sizeY = size(y);

%Se for pedido uma quantidade de batchs maior que o sinal, reduz a
%quantidade de batchs utilizados
if windowSize * windowCount > sizeY(1) 
    windowCount = floor(sizeY(1)/windowSize);
end

%Pega apenas o centro do sinal
dif = sizeY(1) - windowSize * windowCount;
yCenter = y(round(dif/2) : round(dif/2) + windowSize * windowCount - 1);
%size(yCenter)

%Pega os descritores
centroid = spectralCentroid(yCenter, Fs, 'Window', hamming(windowSize), 'OverlapLength', 0, 'FFTLength', windowSize);
spread = spectralSpread(yCenter, Fs, 'Window', hamming(windowSize), 'OverlapLength', 0, 'FFTLength', windowSize);
slope = spectralSlope(yCenter, Fs, 'Window', hamming(windowSize), 'OverlapLength', 0, 'FFTLength', windowSize);
decrease = spectralDecrease(yCenter, Fs, 'Window', hamming(windowSize), 'OverlapLength', 0, 'FFTLength', windowSize);
rolloff = spectralRolloffPoint(yCenter, Fs, 'Window', hamming(windowSize), 'OverlapLength', 0, 'FFTLength', windowSize);



end

