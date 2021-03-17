function [trained_net_mlp, tr_mlp, elTimeMLP] = Train_MLP(net_mlp, vecCb, vecFl)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

%Targets
cbTarg = repmat([0;1], [1 12]);
flTarg = repmat([1;0], [1 12]);


%Treina a rede MLP
net_mlp = init(net_mlp);
tic;
[trained_net_mlp, tr_mlp] = train(net_mlp, [vecCb vecFl], [cbTarg flTarg]);
elTimeMLP = toc;

end

