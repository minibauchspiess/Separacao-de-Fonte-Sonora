function [trained_net_elman, tr_elman, elTimeElman] = Train_Elman(net_elman, cb, fl)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

%Possiveis entradas
trainPureCb = num2cell(cb/2);
trainPureFl = num2cell(fl/2);
trainMix = num2cell((cb+fl)/2);

%Possiveis saidas
trainYPureCb    =   [cb/2                   ; zeros(1, size(cb,2))  ];
trainYPureFl    =   [ zeros(1, size(fl,2))  ; fl/2                  ];
trainYMix       =   [ cb/2                  ; fl/2                  ];

trainYPureCb = mat2cell( trainYPureCb, [2], repmat([1], [1 size(cb,2)]) );
trainYPureFl = mat2cell( trainYPureFl, [2], repmat([1], [1 size(fl,2)]) );
trainYMix = mat2cell( trainYMix, [2], repmat([1], [1 size(fl,2)]) );

%Entrada e saida da rede, treinamento
XTrain = catsamples(trainMix, trainPureCb, trainPureFl);
YTrain = catsamples(trainYMix, trainYPureCb, trainYPureFl);


%Treina a rede de Elman
net_elman = init(net_elman);
tic;
[trained_net_elman, tr_elman] = train(net_elman,XTrain,YTrain);
elTimeElman = toc;
end


