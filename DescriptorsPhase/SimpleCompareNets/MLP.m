%Faz load de vecCb e vecFl
load ../../Samples/TrainSamples/12VecCb/Cb-Ord-mf-1c-E4-12vec.mat
load ../../Samples/TrainSamples/12VecFl/Fl-Ord-mf-E4-12vec.mat

%Cria a rede
net_mlp = NetParams_MLP();

%Treina a redes
[trained_net_mlp, tr_mlp, elTimeMLP] = Train_MLP(net_mlp, vecCb, vecFl);
fprintf("MLP treinada em " + num2str(elTimeMLP) + " tempo\n");