function [trained_net_lstm, tr_lstm, elTimeLSTM] = Train_LSTM(layer_lstm, opt_lstm, cb, fl, op)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

%Transforma entradas em sequências e no formato aceito para treino
%Possiveis entradas
trainPureCb = cb/2;
trainPureFl = fl/2;
trainMix = (cb+fl)/2;

%Possiveis saidas
trainYPureCb    =   [cb/2                   ; zeros(1, size(cb,2))  ];
trainYPureFl    =   [zeros(1, size(fl,2))   ; fl/2                  ];
trainYMix       =   [cb/2                   ; fl/2                  ];

%trainYPureCb = trainYPureCb;
%trainYPureFl = trainYPureFl;
%trainYMix = trainYMix;

%Entrada e saida da rede, treinamento
if op == "MixedOnly"
    XTrain = trainMix;
    YTrain = trainYMix;
elseif op == "PuresOnly"
    XTrain = {trainPureCb; trainPureFl};
    YTrain = {trainYPureCb; trainYPureFl};
elseif op == "All"
    XTrain = {trainMix; trainPureCb; trainPureFl};
    YTrain = {trainYMix; trainYPureCb; trainYPureFl};
else
    fprintf("Conjunto de treino desconhecido")
    return
end

%Treina a rede
tic;
[trained_net_lstm, tr_lstm] = trainNetwork(XTrain,YTrain,layer_lstm,opt_lstm);
elTimeLSTM = toc;

end

