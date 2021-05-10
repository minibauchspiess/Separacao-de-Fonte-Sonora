function [finalNet, finalTr, elTimeLSTM, sdrEvol] = Train_LSTM(layer_lstm, opt_lstm, hp, fh, maxCount, fs)


%Transforma entradas em sequências e no formato aceito para treino
%Possiveis entradas
trainMix = (hp+fh)/2;

%Possiveis saidas
trainYMix=[hp;fh]/2;


%Entrada e saida da rede, treinamento
XTrain = trainMix;
YTrain = trainYMix;


%Treina a rede
tic;
c = clock;
fprintf("Inicio do treino: dia "+num2str(c(3))+", "+num2str(c(4))+"h"+num2str(c(5))+"min\n");
[net, tr] = trainNetwork(XTrain,YTrain,layer_lstm,opt_lstm);
finalTr = tr;
finalNet = net;

%minLoss = tr.TrainingLoss(end);
[~, outMixed] = predictAndUpdateState(finalNet, (hp+fh)/2);
maxMeanSDR = bss_eval_sources(outMixed, YTrain);
maxMeanSDR = mean(maxMeanSDR);


sdrTitleTxtLen = fprintf("SDR medio maximo: ");
sdrTxtLen = fprintf(num2str(maxMeanSDR));
estTxtLen = fprintf("\nEpocas\tSDR\t\tTempo");
countTxtLen = 0;

epochCount = opt_lstm.MaxEpochs;
count = 0;
sdrEvol = [epochCount maxMeanSDR];

reportTxtLen = fprintf("\n"+num2str(epochCount)+"\t\t"+num2str(maxMeanSDR)+"\t"+num2str(floor(toc/3600))+"h"+num2str(mod(floor(toc/60), 60))+"m\t");

while  count<maxCount
    %Faz o treinamento de mais epocas, atualiza quantas epocas ja foram
    [net, tr] = trainNetwork(XTrain,YTrain,net.Layers,opt_lstm);
    epochCount = epochCount + opt_lstm.MaxEpochs;
    
    %Faz a predicao para encontrar o valor de SDR com a nova rede treinada
    [~, outMixed] = predictAndUpdateState(net, (hp+fh)/2);
    meanSDR = bss_eval_sources(outMixed, YTrain);
    meanSDR = mean(meanSDR);
    
    %Atualiza para grafico de SDRxEpocas
    sdrEvol = [sdrEvol; epochCount meanSDR];
    
    %Atualiza o report
    fprintf(repmat('\b',1,reportTxtLen + (count>0)*countTxtLen));
    reportTxtLen = fprintf("\n"+num2str(epochCount)+"\t\t"+num2str(meanSDR)+"\t"+num2str(floor(toc/3600))+"h"+num2str(mod(floor(toc/60), 60))+"m\t");
    %Caso evolução da rede e leve para NaN
    if isnan(meanSDR)
        net = finalNet;
        tr = finalTr;
        count = count+1;
        
        fprintf(repmat('\b',1,reportTxtLen));
        fprintf(repmat('\b',1,estTxtLen));
        fprintf(repmat('\b',1,sdrTxtLen));
        fprintf(repmat('\b',1,sdrTitleTxtLen));
        
        fprintf("Ocorrencia de SDR = NaN\n");
        fprintf("SDR medio maximo: ");
        sdrTxtLen = fprintf(num2str(maxMeanSDR));
        estTxtLen = fprintf("\nEpocas\tSDR\t\tTempo");
        reportTxtLen = fprintf("\n"+num2str(epochCount)+"\t\t"+num2str(meanSDR)+"\t"+num2str(floor(toc/3600))+"h"+num2str(mod(floor(toc/60), 60))+"m\t");
            countTxtLen = fprintf("Count "+num2str(count));
    else
        if meanSDR < maxMeanSDR
            count = count+1;
            countTxtLen = fprintf("Count "+num2str(count));
        else
            maxMeanSDR = meanSDR;
            count = 0;
            finalNet = net;
            finalTr = tr;

            %Atualiza o report do melhor SDR
            fprintf(repmat('\b',1,reportTxtLen));
            fprintf(repmat('\b',1,estTxtLen));
            fprintf(repmat('\b',1,sdrTxtLen));

            sdrTxtLen = fprintf(num2str(maxMeanSDR));
            estTxtLen = fprintf("\nEpocas\tSDR\t\tTempo");
            reportTxtLen = fprintf("\n"+num2str(epochCount)+"\t\t"+num2str(meanSDR)+"\t"+num2str(floor(toc/3600))+"h"+num2str(mod(floor(toc/60), 60))+"m\t");

        end
    end
    
    %A cada momento em que um novo melhor eh encontrado, salva os arquivos de audio para conferir durante treinamento
    if count == 1
        [~, outMixed] = predictAndUpdateState(finalNet, (hp+fh)/2);
        
        audiowrite("Resultados/temp/mix_1.wav", outMixed(1,:), fs);
        audiowrite("Resultados/temp/mix_2.wav", outMixed(2,:), fs);
        save Resultados/temp/variaveis
    end
    
end
fprintf("\n");

elTimeLSTM = toc;

end
