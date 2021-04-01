%Carrega arquivos de cb e fl
%[cb, fs] = audioread("../../Samples/TrainSamples/12VecCb/Cb-Ord-mf-1c-E4-68608-80895.wav");
[cb, fs] = audioread("../../Samples/Preprocessed/filtro2-ord-CbFiles/Cb-ord-mf-1c- E4.wav");
%[fl, ~] = audioread("../../Samples/TrainSamples/12VecFl/Fl-Ord-mf-E4-137216-149503.wav");
[fl, ~] = audioread("../../Samples/Preprocessed/filtro2-ord-FlFiles/Fl-ord-E4-mf.wav");
fl = fl(1:size(cb,1));

%{
fprintf("Treinos com 5 neuronios:\n");
neuronios = 5;
maxEpochs = 5;
[layer_lstm, opt_lstm] = NetParams_LSTM(neuronios, maxEpochs);

[netTrainedMixed_5n, trMixed_5n, timeMixed_5n, epochsMixed_5n] = Train_LSTM(layer_lstm, opt_lstm, cb', fl', "MixedOnly");
fprintf("Treino mixed encerrado em "+num2str(floor(timeMixed_5n/60))+" min "+num2str(mod(timeMixed_5n, 60))+" s, com "+num2str(epochsMixed_5n)+" epocas\n");

[netTrainedPures_5n, trPures_5n, timePures_5n, epochsPures_5n] = Train_LSTM(layer_lstm, opt_lstm, cb', fl', "PuresOnly");
fprintf("Treino pures encerrado em "+num2str(floor(timePures_5n/60))+" min "+num2str(mod(timePures_5n, 60))+" s, com "+num2str(epochsPures_5n)+" epocas\n");

[netTrainedAll_5n, trAll_5n, timeAll_5n, epochsAll_5n] = Train_LSTM(layer_lstm, opt_lstm, cb', fl', "All");
fprintf("Treino all encerrado em "+num2str(floor(timeAll_5n/60))+" min "+num2str(mod(timeAll_5n, 60))+" s, com "+num2str(epochsAll_5n)+" epocas\n");

%--------------------------------------------
fprintf("Treinos com 100 neuronios:\n");
neuronios = 100;
[layer_lstm, opt_lstm] = NetParams_LSTM(neuronios, maxEpochs);

[netTrainedMixed_100n, trMixed_100n, timeMixed_100n, epochsMixed_100n] = Train_LSTM(layer_lstm, opt_lstm, cb', fl', "MixedOnly");
fprintf("Treino mixed encerrado em "+num2str(floor(timeMixed_100n/60))+" min "+num2str(mod(timeMixed_100n, 60))+" s, com "+num2str(epochsMixed_100n)+" epocas\n");

[netTrainedPures_100n, trPures_100n, timePures_100n, epochsPures_100n] = Train_LSTM(layer_lstm, opt_lstm, cb', fl', "PuresOnly");
fprintf("Treino pures encerrado em "+num2str(floor(timePures_100n/60))+" min "+num2str(mod(timePures_100n, 60))+" s, com "+num2str(epochsPures_100n)+" epocas\n");

[netTrainedAll_100n, trAll_100n, timeAll_100n, epochsAll_100n] = Train_LSTM(layer_lstm, opt_lstm, cb', fl', "All");
fprintf("Treino all encerrado em "+num2str(floor(timeAll_100n/60))+" min "+num2str(mod(timeAll_100n, 60))+" s, com "+num2str(epochsAll_100n)+" epocas\n");

%---------------------------------------------------
fprintf("Treinos com 500 neuronios:\n");
neuronios = 500;
[layer_lstm, opt_lstm] = NetParams_LSTM(neuronios, maxEpochs);

[netTrainedMixed_500n, trMixed_500n, timeMixed_500n, epochsMixed_500n] = Train_LSTM(layer_lstm, opt_lstm, cb', fl', "MixedOnly");
fprintf("Treino mixed encerrado em "+num2str(floor(timeMixed_500n/60))+" min "+num2str(mod(timeMixed_500n, 60))+" s, com "+num2str(epochsMixed_500n)+" epocas\n");

[netTrainedPures_500n, trPures_500n, timePures_500n, epochsPures_500n] = Train_LSTM(layer_lstm, opt_lstm, cb', fl', "PuresOnly");
fprintf("Treino pures encerrado em "+num2str(floor(timePures_500n/60))+" min "+num2str(mod(timePures_500n, 60))+" s, com "+num2str(epochsPures_500n)+" epocas\n");

[netTrainedAll_500n, trAll_500n, timeAll_500n, epochsAll_500n] = Train_LSTM(layer_lstm, opt_lstm, cb', fl', "All");
fprintf("Treino all encerrado em "+num2str(floor(timeAll_500n/60))+" min "+num2str(mod(timeAll_500n, 60))+" s, com "+num2str(epochsAll_500n)+" epocas\n");
%}

qtdNeurons = [20 30 40];
maxEpochs = 5;

for i=1:size(qtdNeurons,2)
    neuronios = qtdNeurons(i);
    
    fprintf("Treino com "+num2str(qtdNeurons(i))+" neuronios\n");
    [layer_lstm, opt_lstm] = NetParams_LSTM(neuronios, maxEpochs);
   
    [netTrainedMixed{i}, trMixed{i}, timeMixed{i}, epochsMixed{i}] = Train_LSTM(layer_lstm, opt_lstm, cb', fl', "MixedOnly");
    fprintf("\nTreino mixed encerrado em "+num2str(floor(timeMixed{i}/60))+" min "+num2str(mod(timeMixed{i}, 60))+" s, com "+num2str(epochsMixed{i})+" epocas\n");
    
    [netTrainedPures{i}, trPures{i}, timePures{i}, epochsPures{i}] = Train_LSTM(layer_lstm, opt_lstm, cb', fl', "PuresOnly");
    fprintf("\nTreino pures encerrado em "+num2str(floor(timePures{i}/60))+" min "+num2str(mod(timePures{i}, 60))+" s, com "+num2str(epochsPures{i})+" epocas\n");
    
    [netTrainedAll{i}, trAll{i}, timeAll{i}, epochsAll{i}] = Train_LSTM(layer_lstm, opt_lstm, cb', fl', "All");
    fprintf("\nTreino all encerrado em "+num2str(floor(timeAll{i}/60))+" min "+num2str(mod(timeAll{i}, 60))+" s, com "+num2str(epochsAll{i})+" epocas\n");
    
end



%{
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
%}
