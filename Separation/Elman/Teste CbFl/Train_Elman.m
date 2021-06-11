function [trained_net_elman, tr_elman, elTimeElman] = Train_Elman(net_elman, cb, fl)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here


%Sequencias de treinamento
trainCb1 = cb(1:(4*1024));
trainCb2 = cb((4*1024)+1:(8*1024));
trainCb3 = cb((8*1024)+1:(12*1024));
trainFl1 = fl(1:(4*1024));
trainFl2 = fl((4*1024)+1:(8*1024));
trainFl3 = fl((8*1024)+1:(12*1024));

%Possiveis entradas de treino
trainPureCb = catsamples(trainCb1/2, trainCb2/2, trainCb3/2);
trainPureFl = catsamples(trainFl1/2, trainFl2/2, trainFl3/2);
trainMix = catsamples( (trainCb1+trainFl1)/2, (trainCb2+trainFl2)/2, (trainCb3+trainFl3)/2 );


%Sequencias de saida
nada = zeros(1, 4*1024);
trainYPureCb = catsamples( [trainCb1/2; nada], [trainCb2/2; nada], [trainCb3/2; nada]);
trainYPureFl = catsamples( [nada; trainFl1/2], [nada; trainFl2/2], [nada; trainFl3/2]);
trainYMix = catsamples( [trainCb1/2; trainFl1/2], [trainCb2/2; trainFl2/2], [trainCb3/2; trainFl3/2]);



%Treina a rede de Elman
net_elman = init(net_elman);
tic;
[trained_net_elman, tr_elman] = train(net_elman,trainMix,trainYMix);
elTimeElman = toc;
end

