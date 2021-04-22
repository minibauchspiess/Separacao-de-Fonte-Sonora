%Frequencia de amostragem, instantes de amostragem e frequencias da onda
fs = 44100;
t = 0:1/fs:1;
freqS = 440;
freqSq = 440;
freqTri = 440;

%Criacao das ondas senoidal, quadrada e triangular
s = sin(2*pi*freqS*t);
sq = square(2*pi*freqSq*t);
tri = sawtooth(2*pi*freqTri*t, 0.5);


%Cria a rede
net_elman = NetParams_Elman();

%Treina a rede
[trained_net_elman, tr_elman, elTimeElman] = Train_Elman(net_elman, s, sq, tri);
fprintf("Elman treinada em " + num2str(floor(elTimeElman/60)) + "m"+num2str(mod(elTimeElman, 60))+"\n");

outMixed = trained_net_elman((s+sq+tri)/3);


audiowrite("Resultados/outSen1.wav", outMixed(1,:), fs);
audiowrite("Resultados/outSq1.wav", outMixed(2,:), fs);
audiowrite("Resultados/outTri1.wav", outMixed(3,:), fs);

save Resultados/vars1.mat

