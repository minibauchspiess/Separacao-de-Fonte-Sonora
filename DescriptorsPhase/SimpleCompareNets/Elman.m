%Faz load de vecCb e vecFl
load ../../Samples/TrainSamples/12VecCb/Cb-Ord-mf-1c-E4-12vec.mat
load ../../Samples/TrainSamples/12VecFl/Fl-Ord-mf-E4-12vec.mat

%Cria a rede
net_elman = NetParams_Elman();

%Treina a rede
[trained_net_elman, tr_elman, elTimeElman] = Train_Elman(net_elman, vecCb, vecFl);
fprintf("Elman treinada em " + num2str(elTimeElman) + " tempo\n");

