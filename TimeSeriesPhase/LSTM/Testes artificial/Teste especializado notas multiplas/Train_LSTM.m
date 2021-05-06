function [finalNet, tr, elTimeLSTM, sdrEvol] = Train_LSTM(layer_lstm, opt_lstm, s, sq, tri, op, fs)


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
[net, tr] = trainNetwork(XTrain,YTrain,layer_lstm,opt_lstm);
finalNet = net;

%minLoss = tr.TrainingLoss(end);
[~, outMixed] = predictAndUpdateState(finalNet, (s+sq+tri)/3);
maxMeanSDR = bss_eval_sources(outMixed, YTrain);
maxMeanSDR = mean(maxMeanSDR);


fprintf("SDR medio maximo: ");
sdrTxtLen = fprintf(num2str(maxMeanSDR));
estTxtLen = fprintf("\nEpocas\tSDR\t\tTempo");
countTxtLen = 0;

epochCount = opt_lstm.MaxEpochs;
count = 0;
sdrEvol = [epochCount maxMeanSDR];

reportTxtLen = fprintf("\n"+num2str(epochCount)+"\t\t"+num2str(maxMeanSDR)+"\t"+num2str(floor(toc/3600))+"h"+num2str(mod(floor(toc/60), 60))+"m\t");

while  count<1500
    %Faz o treinamento de mais epocas, atualiza quantas epocas ja foram
    [net, tr] = trainNetwork(XTrain,YTrain,net.Layers,opt_lstm);
    epochCount = epochCount + opt_lstm.MaxEpochs;
    
    %Faz a predicao para encontrar o valor de SDR com a nova rede treinada
    [~, outMixed] = predictAndUpdateState(net, (s+sq+tri)/3);
    meanSDR = bss_eval_sources(outMixed, YTrain);
    meanSDR = mean(meanSDR);
    
    %Atualiza para grafico de SDRxEpocas
    sdrEvol = [sdrEvol; epochCount meanSDR];
    
    %Atualiza o report
    fprintf(repmat('\b',1,reportTxtLen + (count>0)*countTxtLen));
    reportTxtLen = fprintf("\n"+num2str(epochCount)+"\t\t"+num2str(meanSDR)+"\t"+num2str(floor(toc/3600))+"h"+num2str(mod(floor(toc/60), 60))+"m\t");
    
    if meanSDR < maxMeanSDR
        count = count+1;
        countTxtLen = fprintf("Count "+num2str(count));
    else
        maxMeanSDR = meanSDR;
        count = 0;
        finalNet = net;
        
        %Atualiza o report do melhor SDR
        fprintf(repmat('\b',1,reportTxtLen));
        fprintf(repmat('\b',1,estTxtLen));
        fprintf(repmat('\b',1,sdrTxtLen));
        
        sdrTxtLen = fprintf(num2str(maxMeanSDR));
        estTxtLen = fprintf("\nEpocas\tSDR\t\tTempo");
        reportTxtLen = fprintf("\n"+num2str(epochCount)+"\t\t"+num2str(meanSDR)+"\t"+num2str(floor(toc/3600))+"h"+num2str(mod(floor(toc/60), 60))+"m\t");
   
    end
    
    %A cada momento em que um novo melhor eh encontrado, salva os arquivos de audio para conferir durante treinamento
    if count == 1
        [~, outMixed] = predictAndUpdateState(finalNet, (s+sq+tri)/3);
        
        audiowrite("Resultados/temp/mix_1.wav", outMixed(1,:), fs);
        audiowrite("Resultados/temp/mix_2.wav", outMixed(2,:), fs);
        audiowrite("Resultados/temp/mix_3.wav", outMixed(3,:), fs);
    end
end
fprintf("\n");

elTimeLSTM = toc;

end

