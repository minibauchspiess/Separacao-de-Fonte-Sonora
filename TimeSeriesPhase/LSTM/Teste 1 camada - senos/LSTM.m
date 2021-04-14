fs = 44100;
t = 0:1/fs:1;

s1 = sin(t*2*pi*440);
s2 = sin(t*2*pi*160);

[layer, opt] = NetParams_LSTM(150, 5);
[net, tr, time, epochs] = Train_LSTM(layer, opt, s1, s2, "All");
[~, outMixed] = predictAndUpdateState(net, (s1+s2)/2);
[~, outS1] = predictAndUpdateState(net, s1/2);
[~, outS2] = predictAndUpdateState(net, s2/2);

save Resultados/vars.mat


