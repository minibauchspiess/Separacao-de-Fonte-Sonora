function [finalNet, tr, elTimeLSTM, sdrEvol] = Train_LSTM(layer_lstm, opt_lstm, trainSamp, trainTarg, fs)

%Treina a rede
tic;
c = clock;
fprintf("Inicio do treino: dia "+num2str(c(3))+", "+num2str(c(4))+"h"+num2str(c(5))+"min\n");
[net, tr] = trainNetwork(trainSamp,trainTarg,layer_lstm,opt_lstm);
finalNet = net;

%minLoss = tr.TrainingLoss(end);
maxMeanSDR = GetMeanSDR(net, trainSamp, trainTarg, floor(0.1*size(trainSamp,1)));
%[~, outMixed] = predictAndUpdateState(finalNet, (s+sq+tri)/3);
%maxMeanSDR = bss_eval_sources(outMixed, YTrain);
%maxMeanSDR = mean(maxMeanSDR);


fprintf("SDR medio maximo: ");
sdrTxtLen = fprintf(num2str(maxMeanSDR));
estTxtLen = fprintf("\nEpocas\tSDR\t\tTempo");
countTxtLen = 0;

epochCount = opt_lstm.MaxEpochs;
count = 0;
sdrEvol = [epochCount maxMeanSDR];

reportTxtLen = fprintf("\n"+num2str(epochCount)+"\t\t"+num2str(maxMeanSDR)+"\t"+num2str(floor(toc/3600))+"h"+num2str(mod(floor(toc/60), 60))+"m\t");

while  count<30
    %Faz o treinamento de mais epocas, atualiza quantas epocas ja foram
    [net, tr] = trainNetwork(trainSamp,trainTarg,layer_lstm,opt_lstm);
    epochCount = epochCount + opt_lstm.MaxEpochs;
    
    %Faz a predicao para encontrar o valor de SDR com a nova rede treinada
    meanSDR = GetMeanSDR(net, trainSamp, trainTarg, floor(0.3*size(trainSamp,1)));
    %[~, outMixed] = predictAndUpdateState(net, (s+sq+tri)/3);
    %meanSDR = bss_eval_sources(outMixed, YTrain);
    %meanSDR = mean(meanSDR);
    
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
    
    
end
fprintf("\n");

elTimeLSTM = toc;

end

