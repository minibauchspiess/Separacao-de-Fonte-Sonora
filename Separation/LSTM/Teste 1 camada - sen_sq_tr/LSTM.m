%Frequencia de amostragem, instantes de amostragem e frequencias da onda
fs = 44100;
t = 0:1/fs:1;
freqS = 200;
freqSq = 300;
freqTri = 500;

%Criacao das ondas senoidal, quadrada e triangular
s = sin(2*pi*freqS*t);
sq = square(2*pi*freqSq*t);
tri = sawtooth(2*pi*freqTri*t, 0.5);

%Criacao das envoltorias aplicadas a cada

numNeurons = 40;
[layer, opt] = NetParams_LSTM(numNeurons, 5);
[net, tr, time, epochs] = Train_LSTM(layer, opt, s, sq, tri, "All", fs);

[~, outMixed] = predictAndUpdateState(net, (s+sq+tri)/3);

save Resultados/vars2.mat


