function [finalNet, tr, elTimeLSTM, epochCount] = Train_LSTM(layer_lstm, opt_lstm, s, sq, tri, op, fs)


%Transforma entradas em sequências e no formato aceito para treino
%Possiveis entradas
trainPureS = s/3;
trainPureSq = sq/3;
trainPureTr = tri/3;
trainMix = (s+sq+tri)/3;

nada = zeros(1, size(s,2));

%Possiveis saidas
trainYPureS     =   [s/3    ;nada   ;nada];
trainYPureSq    =   [nada   ;sq/3   ;nada];
trainYPureTr    =   [nada   ;nada   ;tri/3];
trainYMix       =   [s/3    ;sq/3   ;tri/3];


%Entrada e saida da rede, treinamento
if op == "MixedOnly"
    XTrain = trainMix;
    YTrain = trainYMix;
elseif op == "PuresOnly"
    XTrain = {trainPureS; trainPureSq};
    YTrain = {trainYPureS; trainYPureSq};
elseif op == "All"
    XTrain = {trainMix; trainPureS; trainPureSq};
    YTrain = {trainYMix; trainYPureS; trainYPureSq};
else
    fprintf("Conjunto de treino desconhecido")
    return
end

%Treina a rede
tic;
c = clock;
fprintf("Inicio do treino: dia "+num2str(c(3))+", "+num2str(c(4))+"h"+num2str(c(5))+"min\n");
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
    
    if (tr.TrainingLoss(end) > minLoss)||(isnan(tr.TrainingLoss(end)))
        count = count+1;
        fprintf("Count "+num2str(count));
    else
        minLoss = tr.TrainingLoss(end);
        count = 0;
        finalNet = net;
    end
    
    %A cada momento em que um novo melhor eh encontrado, salva os arquivos de audio para conferir durante treinamento
    if count == 1
        [~, outMixed] = predictAndUpdateState(finalNet, (s+sq)/2);
        
        audiowrite("Resultados/temp/mix_1.wav", outMixed(1,:), fs);
        audiowrite("Resultados/temp/mix_2.wav", outMixed(2,:), fs);
        audiowrite("Resultados/temp/mix_3.wav", outMixed(3,:), fs);
    end
end

elTimeLSTM = toc;

end

