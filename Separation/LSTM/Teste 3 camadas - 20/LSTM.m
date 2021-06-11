%Carrega arquivos de hp e fh
[hp, fs] = audioread("../../../Samples/TrainSamples/Harp-Fh/Hp-A#1-ff.wav");
[fh, ~] = audioread("../../../Samples/TrainSamples/Harp-Fh/Fh-G4-pp.wav");


%Faz os treinamentos
lstmNeurons = [10 15 20 25 30 35 40 45 50];
layer1Neurons = [5 10 15 20];
maxEpochs = 5;

for j=1:size(layer1Neurons,2)
    for i=1:size(lstmNeurons,2)
        lstmN = lstmNeurons(i);
        layer1N = layer1Neurons(j);
        
        index = (j-1)*size(lstmNeurons,2)+i;

        fprintf("Comecando treino com "+num2str(lstmNeurons(i))+" neuronios na camada lstm e "+num2str(layer1Neurons(j))+" na segunda camada\n");
        [layer_lstm, opt_lstm] = NetParams_LSTM(lstmN, layer1N, maxEpochs);

        [netTrainedMixed{index}, trMixed{index}, timeMixed{index}, epochsMixed{index}] = Train_LSTM(layer_lstm, opt_lstm, hp', fh', "MixedOnly");
        fprintf("\nTreino mixed encerrado em "+num2str(floor(timeMixed{index}/60))+" min "+num2str(mod(timeMixed{index}, 60))+" s, com "+num2str(epochsMixed{index})+" epocas\n");

        [netTrainedPures{index}, trPures{index}, timePures{index}, epochsPures{index}] = Train_LSTM(layer_lstm, opt_lstm, hp', fh', "PuresOnly");
        fprintf("\nTreino pures encerrado em "+num2str(floor(timePures{index}/60))+" min "+num2str(mod(timePures{index}, 60))+" s, com "+num2str(epochsPures{index})+" epocas\n");

        [netTrainedAll{index}, trAll{index}, timeAll{index}, epochsAll{index}] = Train_LSTM(layer_lstm, opt_lstm, hp', fh', "All");
        fprintf("\nTreino all encerrado em "+num2str(floor(timeAll{index}/60))+" min "+num2str(mod(timeAll{index}, 60))+" s, com "+num2str(epochsAll{index})+" epocas\n");

    end
end

%Seleciona a rede com menor Loss e obtem a saida dela
nets = [netTrainedMixed, netTrainedPures, netTrainedAll];
for i=1:(size(lstmNeurons,2)*size(layer1Neurons,2))
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


