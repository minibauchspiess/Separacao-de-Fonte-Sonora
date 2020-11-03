function [centroid, spread, slope, decrease, rolloff] = GetDescriptors(y, Fs, windowSize)

%GetDescriptors: essa funcao divide um sinal de áudio recebido em uma
%quantidade específica, e pra cara pedaço do sinal, extrai seus descritores
%(centroid, spread, slope, decrease e rolloff)
 

%Pega os descritores
centroid = spectralCentroid(y, Fs, 'Window', hamming(windowSize), 'OverlapLength', 0, 'FFTLength', windowSize);
spread = spectralSpread(y, Fs, 'Window', hamming(windowSize), 'OverlapLength', 0, 'FFTLength', windowSize);
slope = spectralSlope(y, Fs, 'Window', hamming(windowSize), 'OverlapLength', 0, 'FFTLength', windowSize);
decrease = spectralDecrease(y, Fs, 'Window', hamming(windowSize), 'OverlapLength', 0, 'FFTLength', windowSize);
rolloff = spectralRolloffPoint(y, Fs, 'Window', hamming(windowSize), 'OverlapLength', 0, 'FFTLength', windowSize);



end

