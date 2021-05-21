function [finalNet, finalTr, elTimeLSTM, sdrEvol] = Train_LSTM(layer_lstm, opt_lstm, hp, fh, maxCount, fs)

%Caso nao sejam fornecidos argumentos, o treinamento sera uma continuacao
%do ultimo salvo em Resultados/temp/variaveis.mat
if nargin == 1
    tic;
    addpath("../../SSS_Eval");
    %warning("off","MATLAB:nearlySingularMatrix");   %O calculo de SDR mostra muito esse warning
    warning("off");     %Suprime o warning acima e o avisando da GPU, pro log ficar limpo
    numNeurons = layer_lstm; %Caso tenha somente um argumento, este sera o numero de neuronios na camada ao inves das camadas
    clear layer_lstm    %Apaga a "layer" com numero de neuronios, para garantir que nao havera conflito dos nomes aplicados para tipos diferentes
    load("Resultados/temp/variaveis"+numNeurons+".mat")
    
    if exist('elTimeLSTM', 'var')==0
        elTimeLSTM = 0;
    end
    tocOffset = elTimeLSTM;
    sdrTitleTxtLen = fprintf("SDR medio maximo: ");
    sdrTxtLen = fprintf(num2str(maxMeanSDR));
    estTxtLen = fprintf("\nEpocas\tSDR\t\tTempo");
    reportTxtLen = fprintf("\n"+num2str(epochCount)+"\t\t"+num2str(maxMeanSDR)+"\t"+num2str(floor(elTimeLSTM/3600))+"h"+num2str(mod(floor(elTimeLSTM/60), 60))+"m\t");
    if count>0
        countTxtLen = fprintf("Count "+num2str(count));
    end
else

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
    tocOffset = 0;  %Parametro para caso a rede comece a treinar de um checkpoint
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

    elTimeLSTM = toc;
    reportTxtLen = fprintf("\n"+num2str(epochCount)+"\t\t"+num2str(maxMeanSDR)+"\t"+num2str(floor((elTimeLSTM+tocOffset)/3600))+"h"+num2str(mod(floor((elTimeLSTM+tocOffset)/60), 60))+"m\t");

end
 
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
    elTimeLSTM = toc;
    reportTxtLen = fprintf("\n"+num2str(epochCount)+"\t\t"+num2str(meanSDR)+"\t"+num2str(floor((elTimeLSTM+tocOffset)/3600))+"h"+num2str(mod(floor((elTimeLSTM+tocOffset)/60), 60))+"m\t");
    
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
        elTimeLSTM = toc;
        reportTxtLen = fprintf("\n"+num2str(epochCount)+"\t\t"+num2str(meanSDR)+"\t"+num2str(floor((elTimeLSTM+tocOffset)/3600))+"h"+num2str(mod(floor((elTimeLSTM+tocOffset)/60), 60))+"m\t");
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
            elTimeLSTM = toc;
            reportTxtLen = fprintf("\n"+num2str(epochCount)+"\t\t"+num2str(meanSDR)+"\t"+num2str(floor((elTimeLSTM+tocOffset)/3600))+"h"+num2str(mod(floor((elTimeLSTM+tocOffset)/60), 60))+"m\t");

        end
    end
    
    %A cada momento em que um novo melhor eh encontrado, salva os arquivos de audio para conferir durante treinamento
    if count == 1
        [~, outMixed] = predictAndUpdateState(finalNet, (hp+fh)/2);
        
        audiowrite("Resultados/temp/mix_1.wav", outMixed(1,:), fs);
        audiowrite("Resultados/temp/mix_2.wav", outMixed(2,:), fs);
    end
    save("Resultados/temp/variaveis"+layer_lstm(2).NumHiddenUnits+".mat");
    
end
fprintf("\n");

elTimeLSTM = toc;

end
