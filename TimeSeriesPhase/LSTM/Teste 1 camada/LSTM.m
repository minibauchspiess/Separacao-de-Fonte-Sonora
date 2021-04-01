%Carrega arquivos de hp e fh
[hp, fs] = audioread("../../../Samples/TrainSamples/Harp-Fh/Hp-A#1-ff.wav");
[fh, ~] = audioread("../../../Samples/TrainSamples/Harp-Fh/Fh-G4-pp.wav");


%Faz os treinamentos
qtdNeurons = [10 15 20 25 30 35 40 45 50];
maxEpochs = 5;

for i=1:size(qtdNeurons,2)
    neuronios = qtdNeurons(i);
    
    fprintf("Treino com "+num2str(qtdNeurons(i))+" neuronios comecado\n");
    [layer_lstm, opt_lstm] = NetParams_LSTM(neuronios, maxEpochs);
   
    [netTrainedMixed{i}, trMixed{i}, timeMixed{i}, epochsMixed{i}] = Train_LSTM(layer_lstm, opt_lstm, hp', fh', "MixedOnly");
    fprintf("\nTreino mixed encerrado em "+num2str(floor(timeMixed{i}/60))+" min "+num2str(mod(timeMixed{i}, 60))+" s, com "+num2str(epochsMixed{i})+" epocas\n");
    
    [netTrainedPures{i}, trPures{i}, timePures{i}, epochsPures{i}] = Train_LSTM(layer_lstm, opt_lstm, hp', fh', "PuresOnly");
    fprintf("\nTreino pures encerrado em "+num2str(floor(timePures{i}/60))+" min "+num2str(mod(timePures{i}, 60))+" s, com "+num2str(epochsPures{i})+" epocas\n");
    
    [netTrainedAll{i}, trAll{i}, timeAll{i}, epochsAll{i}] = Train_LSTM(layer_lstm, opt_lstm, hp', fh', "All");
    fprintf("\nTreino all encerrado em "+num2str(floor(timeAll{i}/60))+" min "+num2str(mod(timeAll{i}, 60))+" s, com "+num2str(epochsAll{i})+" epocas\n");
    
end

%Seleciona a rede com menor Loss e obtem a saida dela
nets = [netTrainedMixed, netTrainedPures, netTrainedAll];
for i=1:size(qtdNeurons,2)
    lossMixed(i) = trMixed{i}.TrainingLoss(end);
    lossPures(i) = trPures{i}.TrainingLoss(end);
    lossAll(i) = trAll{i}.TrainingLoss(end);
end
[minimo, ind] = min( [lossMixed lossPures lossAll] );
bestNet = nets{ind};
[~, saida] = predictAndUpdateState(bestNet, (hp'+fh')/2);

%Salva os dois arquivos de audio da saida e a workspace
audiowrite("Resultados/hpSaida.wav", saida(1,:), fs);
audiowrite("Resultados/fhSaida.wav", saida(2,:), fs);
save Resultados/variaveis.mat


