%Faz load de vecCb e vecFl
load ../../Samples/TrainSamples/12VecCb/Cb-Ord-mf-1c-E4-12vec.mat
load ../../Samples/TrainSamples/12VecFl/Fl-Ord-mf-E4-12vec.mat


%Pega as amostras
[cb, fs] = audioread("../../Samples/TrainSamples/12VecCb/Cb-Ord-mf-1c-E4-68608-80895.wav");
[fl, ~] = audioread("../../Samples/TrainSamples/12VecFl/Fl-Ord-mf-E4-137216-149503.wav");


fs = 44100;
T = 12*1024/fs;
t = 0:1/fs:T-1/fs;

trFreq = 100;
sqFreq = 100;

tr = sawtooth(2*pi*trFreq*t, 0.5);
sq = square(2*pi*sqFreq*t);


%Cria a rede
net_elman = NetParams_Elman();

%Treina a rede
[trained_net_elman, tr_elman, elTimeElman] = Train_Elman(net_elman, tr, sq);
fprintf("Elman treinada em " + num2str(elTimeElman) + " tempo\n");

