function [trained_net_elman, tr_elman, elTimeElman] = Train_Elman(net_elman, cb, fl)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here


%Sequencias de treinamento
trainPureCb = cb/2;
trainPureFl = fl/2;
trainMix = (cb+fl)/2;


%Sequencias de saida
nada = zeros(1, size(cb, 2));
trainYPureCb = [trainPureCb; nada];
trainYPureFl = [nada; trainPureFl/2];
trainYMix = [trainPureCb; trainPureFl];



%Treina a rede de Elman
net_elman = init(net_elman);
tic;
[trained_net_elman, tr_elman] = train(net_elman,trainMix,trainYMix);
elTimeElman = toc;
end

