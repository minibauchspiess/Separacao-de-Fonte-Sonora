%Faz load de vecCb e vecFl
load ../../Samples/TrainSamples/12VecCb/Cb-Ord-mf-1c-E4-12vec.mat
load ../../Samples/TrainSamples/12VecFl/Fl-Ord-mf-E4-12vec.mat

%Cria a layer
[layer_lstm, opt_lstm] = NetParams_LSTM();

%Treina a rede
[trained_net_lstm, tr_lstm, elTimeLSTM] = Train_LSTM(layer_lstm, opt_lstm, vecCb, vecFl);
fprintf("LSTM treinada em " + num2str(elTimeLSTM) + " tempo\n");