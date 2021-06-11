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
[net, tr] = trainNetwork(XTrain,YTrain,layer_lstm,opt_lstm);
finalNet = net;

minLoss = tr.TrainingLoss(end);
epochCount = opt_lstm.MaxEpochs;
count = 0;

fprintf("\n"+num2str(epochCount)+"\t\t"+num2str(tr.TrainingLoss(end))+"\t"+num2str(floor(toc/3600))+"h"+num2str(mod(floor(toc/60), 60))+"m\t");

while  count<100
    [net, tr] = trainNetwork(XTrain,YTrain,net.Layers,opt_lstm);
    epochCount = epochCount + opt_lstm.MaxEpochs;
    
    fprintf("\n"+num2str(epochCount)+"\t\t"+num2str(tr.TrainingLoss(end))+"\t"+num2str(floor(toc/3600))+"h"+num2str(mod(floor(toc/60), 60))+"m\t");
    
    if tr.TrainingLoss(end) > minLoss
        count = count+1;
        fprintf("Count "+num2str(count));
    else
        minLoss = tr.TrainingLoss(end);
        count = 0;
        finalNet = net;
    end
    
    %A cada momento em que um novo melhor eh encontrado, salva os arquivos de audio para conferir durante treinamento
    if count == 1
        [~, outMixed] = predictAndUpdateState(finalNet, (s1+s2)/2);
        %[~, outS1] = predictAndUpdateState(finalNet, s1/2);
        %[~, outS2] = predictAndUpdateState(finalNet, s2/2);
        
        audiowrite("Resultados/temp/mix_1.wav", outMixed(1,:), fs);
        audiowrite("Resultados/temp/mix_2.wav", outMixed(2,:), fs);
        %audiowrite("Resultados/temp/s1_1.wav", outS1(1,:), fs);
        %audiowrite("Resultados/temp/s1_2.wav", outS1(2,:), fs);
        %audiowrite("Resultados/temp/s2_1.wav", outS2(1,:), fs);
        %audiowrite("Resultados/temp/s2_2.wav", outS2(2,:), fs);
    end
end

elTimeLSTM = toc;

end

