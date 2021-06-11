%Faz load de vecCb e vecFl
load ../../Samples/TrainSamples/12VecCb/Cb-Ord-mf-1c-E4-12vec.mat
load ../../Samples/TrainSamples/12VecFl/Fl-Ord-mf-E4-12vec.mat


%Cria as redes
net_mlp = NetParams_MLP();
net_elman = NetParams_Elman();
[layer_lstm, opt_lstm] = NetParams_LSTM();


%Treina as redes
%[trained_net_mlp, tr_mlp, elTimeMLP] = Train_MLP(net_mlp, vecCb, vecFl);
%fprintf("MLP treinada em " + num2str(elTimeMLP) + " tempo\n");

%[trained_net_elman, tr_elman, elTimeElman] = Train_Elman(net_elman, vecCb, vecFl);
%fprintf("Elman treinada em " + num2str(elTimeElman) + " tempo\n");

[trained_net_lstm, tr_lstm, elTimeLSTM] = Train_LSTM(layer_lstm, opt_lstm, vecCb, vecFl);
fprintf("LSTM treinada em " + num2str(elTimeLSTM) + " tempo\n");








