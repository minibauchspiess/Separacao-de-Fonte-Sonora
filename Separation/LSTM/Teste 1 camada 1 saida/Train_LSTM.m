function [finalNet, tr_lstm, elTimeLSTM, epochCount] = Train_LSTM(layer_lstm, opt_lstm, hp, fh, op)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

%Transforma entradas em sequências e no formato aceito para treino
%Possiveis entradas
trainPureHp = hp/2;
trainPureFh = fh/2;
trainMix = (hp+fh)/2;

%Possiveis saidas
trainYPureHp    =   [hp/2                   ; zeros(1, size(hp,2))  ];
trainYPureFh    =   [zeros(1, size(fh,2))   ; fh/2                  ];
trainYMix       =   [hp/2                   ; fh/2                  ];


%Entrada e saida da rede, treinamento
if op == "MixedOnly"
    XTrain = trainMix;
    YTrain = fh/2;
elseif op == "PuresOnly"
    XTrain = {trainPureHp; trainPureFh};
    YTrain = {zeros(1, size(hp,2)); fh/2};
elseif op == "All"
    XTrain = {trainMix; trainPureHp; trainPureFh};
    YTrain = {fh/2; zeros(1, size(hp,2)); fh/2};
else
    fprintf("Conjunto de treino desconhecido")
    return
end

%Treina a rede
tic;
fprintf("Epocas treinadas: 0 ");
[trained_net_lstm, tr_lstm] = trainNetwork(XTrain,YTrain,layer_lstm,opt_lstm);
aux = trained_net_lstm;

minMeanLoss = mean(tr_lstm.TrainingLoss);
epochCount = 0;
count = 0;
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

