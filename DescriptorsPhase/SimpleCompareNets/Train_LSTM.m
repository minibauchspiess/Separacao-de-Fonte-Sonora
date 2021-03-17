function [trained_net_lstm, tr_lstm, elTimeLSTM] = Train_LSTM(layer_lstm, opt_lstm, vecCb, vecFl)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

%Transforma entradas em sequências e no formato aceito para treino
XTrain = {vecCb(:,1:4); vecCb(:,5:8); vecCb(:,9:12); vecFl(:,1:4); vecFl(:,5:8); vecFl(:,9:12)};
YTrain = categorical( [0;0;0; 1;1;1] );

%Treina a rede
tic;
[trained_net_lstm, tr_lstm] = trainNetwork(XTrain,YTrain,layer_lstm,opt_lstm);
elTimeLSTM = toc;

end

