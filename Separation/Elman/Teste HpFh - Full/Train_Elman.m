function [trained_net_elman, tr_elman, elTimeElman] = Train_Elman(net_elman, hp, fh)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here


%Sequencias de treinamento
trainPureHp = hp/2;
trainPureFh = fh/2;
trainMix = (hp+fh)/2;


%Sequencias de saida
nada = zeros(1, size(hp, 2));
trainYPureHp = [trainPureHp; nada];
trainYPureFh = [nada; trainPureFh/2];
trainYMix = [trainPureHp; trainPureFh];



%Treina a rede de Elman
net_elman = init(net_elman);
tic;
[trained_net_elman, tr_elman] = train(net_elman,trainMix,trainYMix);
elTimeElman = toc;
end

