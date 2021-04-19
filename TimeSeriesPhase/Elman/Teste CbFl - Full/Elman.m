%Faz load de cb e fl
[cb, fs] = audioread("../../../Samples/Preprocessed/filtZhang/Cb-ord/Cb-ord-mf-1c- E4.wav");
cb = cb';

[fl, ~] = audioread("../../../Samples/Preprocessed/filtZhang/Fl-ord/Fl-ord-E4-mf.wav");
fl = fl';flCut = fl(1:size(cb,2));


%Cria a rede
net_elman = NetParams_Elman();

%Treina a rede
[trained_net_elman, tr_elman, elTimeElman] = Train_Elman(net_elman, cb, flCut);
fprintf("Elman treinada em " + num2str(floor(elTimeElman/60)) + "m"+num2str(mod(elTimeElman, 60))+"\n");

outMixed = trained_net_elman((cb+flCut)/2);


audiowrite("Resultados/outCb.wav", outMixed(1,:), fs);
audiowrite("Resultados/outFl.wav", outMixed(2,:), fs);

save Resultados/vars.mat

