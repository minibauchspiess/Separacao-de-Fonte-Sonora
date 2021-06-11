function [centroid, spread, slope, decrease, rolloff] = GetDescriptors(y, Fs, windowSize)
%GetDescriptors: funcao que retorna os descritores de um sinal de audio
%todos de uma so vez (cada coluna de um vetor de saida corresponte ao
%descritor de uma janela de tamanho windowsSize)


centroid = spectralCentroid(y, Fs, 'Window', hamming(windowSize), 'OverlapLength', 0, 'FFTLength', windowSize);
spread = spectralSpread(y, Fs, 'Window', hamming(windowSize), 'OverlapLength', 0, 'FFTLength', windowSize);
slope = spectralSlope(y, Fs, 'Window', hamming(windowSize), 'OverlapLength', 0, 'FFTLength', windowSize);
decrease = spectralDecrease(y, Fs, 'Window', hamming(windowSize), 'OverlapLength', 0, 'FFTLength', windowSize);
rolloff = spectralRolloffPoint(y, Fs, 'Window', hamming(windowSize), 'OverlapLength', 0, 'FFTLength', windowSize);

end

