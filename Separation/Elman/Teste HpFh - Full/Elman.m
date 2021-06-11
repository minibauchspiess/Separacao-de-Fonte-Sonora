%Faz load de cb e fl
[hp, fs] = audioread("../../../Samples/TrainSamples/Harp-Fh/Hp-A#1-ff.wav");
hp = hp';

[fh, ~] = audioread("../../../Samples/TrainSamples/Harp-Fh/Fh-G4-pp.wav");
fh = fh';


%Cria a rede
net_elman = NetParams_Elman();

%Treina a rede
[trained_net_elman, tr_elman, elTimeElman] = Train_Elman(net_elman, hp, fh);
fprintf("Elman treinada em " + num2str(floor(elTimeElman/60)) + "m"+num2str(mod(elTimeElman, 60))+"\n");

outMixed = trained_net_elman((hp+fh)/2);


audiowrite("Resultados/outCb1.wav", outMixed(1,:), fs);
audiowrite("Resultados/outFl1.wav", outMixed(2,:), fs);

save Resultados/vars1.mat

