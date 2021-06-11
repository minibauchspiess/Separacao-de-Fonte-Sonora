function [trained_net_elman, tr_elman, elTimeElman] = Train_Elman(net_elman, s, sq, tri)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here


%Sequencias de treinamento
trainPureS = s/3;
trainPureSq = sq/3;
trainPureTr = tri/3;
trainMix = (s+sq+tri)/3;


%Sequencias de saida
nada = zeros(1, size(s, 2));
trainYPureS     =   [s/3    ;nada   ;nada];
trainYPureSq    =   [nada   ;sq/3   ;nada];
trainYPureTr    =   [nada   ;nada   ;tri/3];
trainYMix       =   [s/3    ;sq/3   ;tri/3];



%Treina a rede de Elman
net_elman = init(net_elman);
tic;
[trained_net_elman, tr_elman] = train(net_elman,trainMix,trainYMix);
elTimeElman = toc;
end

