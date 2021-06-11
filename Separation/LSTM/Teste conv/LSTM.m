
[hp, fs] = audioread("../../../Samples/TrainSamples/Harp-Fh/Hp-A#1-ff.wav");
[fh, ~] = audioread("../../../Samples/TrainSamples/Harp-Fh/Fh-G4-pp.wav");



[layer, opt] = NetParams_LSTM(4, 5);

[net, tr, time, epochs] = Train_LSTM(layer, opt, hp', fh', "All");

[~, outMixed] = predictAndUpdateState(net, (hp'+fh')/2);
[~, outS1] = predictAndUpdateState(net, hp'/2);
[~, outS2] = predictAndUpdateState(net, fh'/2);

save Resultados/vars.mat


