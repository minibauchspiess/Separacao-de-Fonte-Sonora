%Carrega arquivos de cb e fl
[cb, fs] = audioread("../../Samples/TrainSamples/12VecCb/Cb-Ord-mf-1c-E4-68608-80895.wav");
[fl, ~] = audioread("../../Samples/TrainSamples/12VecFl/Fl-Ord-mf-E4-137216-149503.wav");


for maxEpochs = 20:100:1020
    for neuronios = 2:10:52
        fprintf("Treino com "+num2str(maxEpochs)+" epocas e "+num2str(neuronios)+" neuronios\n");

        %Cria a layer
        [layer_lstm, opt_lstm] = NetParams_LSTM(neuronios, maxEpochs);

        %Treina a rede com sinais mixados apenas
        [netTrainedMixed{((maxEpochs-20)/100)+1}{neuronios}, trMixed{((maxEpochs-20)/100)+1}{neuronios}, timeMixed{((maxEpochs-20)/100)+1}{neuronios}] = Train_LSTM(layer_lstm, opt_lstm, cb', fl', "MixedOnly");
        fprintf("Treino mixed terminado em "+num2str(floor(timeMixed{((maxEpochs-20)/100)+1}{neuronios}/60))+"min e "+num2str(mod(timeMixed{((maxEpochs-20)/100)+1}{neuronios},50))+" segundos\n");
        
        %Treina a rede com sinais puros apenas
        [netTrainedPures{((maxEpochs-20)/100)+1}{neuronios}, trPures{((maxEpochs-20)/100)+1}{neuronios}, timePures{((maxEpochs-20)/100)+1}{neuronios}] = Train_LSTM(layer_lstm, opt_lstm, cb', fl', "PuresOnly");
        fprintf("Treino pures terminado em "+num2str(floor(timePures{((maxEpochs-20)/100)+1}{neuronios}/60))+"min e "+num2str(mod(timePures{((maxEpochs-20)/100)+1}{neuronios},50))+" segundos\n");
        
        %Treina a rede com sinais puros e o mixado
        [netTrainedAll{((maxEpochs-20)/100)+1}{neuronios}, trAll{((maxEpochs-20)/100)+1}{neuronios}, timeAll{((maxEpochs-20)/100)+1}{neuronios}] = Train_LSTM(layer_lstm, opt_lstm, cb', fl', "All");
        fprintf("Treino all terminado em "+num2str(floor(timeAll{((maxEpochs-20)/100)+1}{neuronios}/60))+"min e "+num2str(mod(timeAll{((maxEpochs-20)/100)+1}{neuronios},50))+" segundos\n");
        
        %Fecha as janelas abertas, para evitar o excesso das mesmas abertas
        %delete(findall(0));
    end
end
