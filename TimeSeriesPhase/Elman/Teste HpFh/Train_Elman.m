function [trained_net_elman, tr_elman, elTimeElman] = Train_Elman(net_elman, hp, fh)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here


%Sequencias de treinamento
trainHp1 = hp(1:(4*1024));
trainHp2 = hp((4*1024)+1:(8*1024));
trainHp3 = hp((8*1024)+1:(12*1024));
trainFh1 = fh(1:(4*1024));
trainFh2 = fh((4*1024)+1:(8*1024));
trainFh3 = fh((8*1024)+1:(12*1024));

%Possiveis entradas de treino
trainPureHp = catsamples(trainHp1/2, trainHp2/2, trainHp3/2);
trainPureFh = catsamples(trainFh1/2, trainFh2/2, trainFh3/2);
trainMix = catsamples( (trainHp1+trainFh1)/2, (trainHp2+trainFh2)/2, (trainHp3+trainFh3)/2 );



%Sequencias de saida
nada = zeros(1, 4*1024);
trainYPureHp = catsamples( [trainHp1/2; nada], [trainHp2/2; nada], [trainHp3/2; nada]);
trainYPureFh = catsamples( [nada; trainFh1/2], [nada; trainFh2/2], [nada; trainFh3/2]);
trainYMix = catsamples( [trainHp1/2; trainFh1/2], [trainHp2/2; trainFh2/2], [trainHp3/2; trainFh3/2]);



%Treina a rede de Elman
net_elman = init(net_elman);
tic;
[trained_net_elman, tr_elman] = train(net_elman,trainMix,trainYMix);
elTimeElman = toc;
end

