function [finalNet, tr_lstm, elTimeLSTM, epochCount] = Train_LSTM(layer_lstm, opt_lstm, cb, fl, op)
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
aux = trained_net_lstm;

minMeanLoss = mean(tr_lstm.TrainingLoss);
epochCount = 0;
count = 1;
finalNet = trained_net_lstm;
while  count<3
    
    if mean(tr_lstm.TrainingLoss) > minMeanLoss
        count = count+1;
        fprintf("\nCount "+num2str(count)+"\n");
    else
        minMeanLoss = mean(tr_lstm.TrainingLoss);
        count = 1;
        finalNet = aux;
    end
    
    epochCount = epochCount + opt_lstm.MaxEpochs;
    trained_net_lstm = aux;
    
    fprintf(num2str(epochCount)+" ");
    
    [aux, tr_lstm] = trainNetwork(XTrain,YTrain,trained_net_lstm.Layers,opt_lstm);
    %{
    if mod(epochCount, 10*opt_lstm.MaxEpochs) == 0
        fprintf("\n"+num2str(epochCount)+" epocas treinadas\n");
    end
    %}
end

elTimeLSTM = toc;

end

