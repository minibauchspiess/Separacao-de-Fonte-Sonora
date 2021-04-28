function [finalNet, tr, elTimeLSTM, epochCount] = Train_LSTM(layer_lstm, opt_lstm, s1, s2, op, fs)


%Transforma entradas em sequências e no formato aceito para treino
%Possiveis entradas
trainPureS1 = s1/2;
trainPureS2 = s2/2;
trainMix = (s1+s2)/2;

%Possiveis saidas
trainYPureS1    =   [s1/2                   ; zeros(1, size(s1,2))  ];
trainYPureS2    =   [zeros(1, size(s2,2))   ; s2/2                  ];
trainYMix       =   [s1/2                   ; s2/2                  ];


%Entrada e saida da rede, treinamento
if op == "MixedOnly"
    XTrain = trainMix;
    YTrain = trainYMix;
elseif op == "PuresOnly"
    XTrain = {trainPureS1; trainPureS2};
    YTrain = {trainYPureS1; trainYPureS2};
elseif op == "All"
    XTrain = {trainMix; trainPureS1; trainPureS2};
    YTrain = {trainYMix; trainYPureS1; trainYPureS2};
else
    fprintf("Conjunto de treino desconhecido")
    return
end

%Treina a rede
tic;
fprintf("Epocas\tLoss\t\tTempo");
[net, info] = trainNetwork(XTrain,YTrain,layer_lstm,opt_lstm);
finalNet = net;

loss = info.TrainingLoss(end);
epochCount = opt_lstm.MaxEpochs;
e = 0.00001;
t = 10000;

i = 0;

fprintf("\n"+num2str(epochCount)+"\t\t"+num2str(info.TrainingLoss(end))+"\t"+num2str(floor(toc/3600))+"h"+num2str(mod(floor(toc/60), 60))+"m\t");

while (e < loss) or (i > t)
    [net, info] = trainNetwork(XTrain,YTrain,net.Layers,opt_lstm);
    epochCount = epochCount + opt_lstm.MaxEpochs;
    
    fprintf("\n"+num2str(epochCount)+"\t\t"+num2str(info.TrainingLoss(end))+"\t"+num2str(floor(toc/3600))+"h"+num2str(mod(floor(toc/60), 60))+"m\t");
    
    %A cada momento em que um novo melhor eh encontrado, salva os arquivos de audio para conferir durante treinamento
    if info.TrainingLoss(end) < loss
        loss = info.TrainingLoss(end);
        [~, outMixed] = predictAndUpdateState(net, (s1+s2)/2);
        %[~, outS1] = predictAndUpdateState(net, s1/2);
        %[~, outS2] = predictAndUpdateState(net, s2/2);
        
        audiowrite("Resultados/temp/mix_1.wav", outMixed(1,:), fs);
        audiowrite("Resultados/temp/mix_2.wav", outMixed(2,:), fs);
        %audiowrite("Resultados/temp/s1_1.wav", outS1(1,:), fs);
        %audiowrite("Resultados/temp/s1_2.wav", outS1(2,:), fs);
        %audiowrite("Resultados/temp/s2_1.wav", outS2(1,:), fs);
        %audiowrite("Resultados/temp/s2_2.wav", outS2(2,:), fs);
    end

    i = i + 1;
end

elTimeLSTM = toc;

end

