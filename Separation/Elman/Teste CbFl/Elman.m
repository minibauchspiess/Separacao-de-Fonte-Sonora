%Faz load de cb e fl
[cb, fs] = audioread("../../../Samples/TrainSamples/12VecCb/Cb-Ord-mf-1c-E4-68608-80895.wav");
[cbFull, ~] = audioread("../../../Samples/Preprocessed/filtZhang/Cb-ord/Cb-ord-mf-1c- E4.wav");
cb = cb'; cbFull = cbFull';

[fl, ~] = audioread("../../../Samples/TrainSamples/12VecFl/Fl-Ord-mf-E4-137216-149503.wav");
[flFull, ~] = audioread("../../../Samples/Preprocessed/filtZhang/Fl-ord/Fl-ord-E4-mf.wav");
fl = fl'; flFull = flFull';
flFullCut = flFull(1:size(cbFull,2));

%Cria a rede
net_elman = NetParams_Elman();

%Treina a rede
[trained_net_elman, tr_elman, elTimeElman] = Train_Elman(net_elman, cb, fl);
fprintf("Elman treinada em " + num2str(floor(elTimeElman/60) + "m"+num2str(mod(elTimeElman, 60))+"\n");

outMixed = trained_net_elman((cb+fl)/2);
outMixedFull = trained_net_elman((cbFull+flFullCut)/2);


audiowrite("Resultados/outCb.wav", outMixed(1,:), fs);
audiowrite("Resultados/outFl.wav", outMixed(2,:), fs);
audiowrite("Resultados/outCbFull.wav", outMixedFull(1,:), fs);
audiowrite("Resultados/outFlFull.wav", outMixedFull(2,:), fs);

save Resultados/vars.mat

