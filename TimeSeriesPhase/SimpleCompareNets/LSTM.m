%Faz load de vecCb e vecFl
load ../../Samples/TrainSamples/12VecCb/Cb-Ord-mf-1c-E4-12vec.mat
load ../../Samples/TrainSamples/12VecFl/Fl-Ord-mf-E4-12vec.mat

%Carrega arquivos de cb e fl
[cb, fs] = audioread("../../Samples/TrainSamples/12VecCb/Cb-Ord-mf-1c-E4-68608-80895.wav");
[fl, ~] = audioread("../../Samples/TrainSamples/12VecFl/Fl-Ord-mf-E4-137216-149503.wav");


fs = 44100;
T = 12*1024/fs;
t = 0:1/fs:T-1/fs;

trFreq = 100;
sqFreq = 100;

tr = sawtooth(2*pi*trFreq*t, 0.5);
sq = square(2*pi*sqFreq*t);



for neuronios = 2:50
    fprintf(num2str(neuronios)+" neuronios\n");
    
    %Cria a layer
    [layer_lstm, opt_lstm] = NetParams_LSTM(neuronios);

    %Treina a rede com sinais mixados apenas
    [netTrainedMixed{neuronios}, trMixed{neuronios}, timeMixed{neuronios}] = Train_LSTM(layer_lstm, opt_lstm, cb', fl', "MixedOnly");
    
    %Treina a rede com sinais puros apenas
    [netTrainedPures{neuronios}, trPures{neuronios}, timePures{neuronios}] = Train_LSTM(layer_lstm, opt_lstm, cb', fl', "PuresOnly");
    
    %Treina a rede com sinais puros e o mixado
    [netTrainedAll{neuronios}, trAll{neuronios}, timeAll{neuronios}] = Train_LSTM(layer_lstm, opt_lstm, cb', fl', "All");
    
    %Fecha as janelas abertas, para evitar o excesso das mesmas abertas
    delete(findall(0));
end

