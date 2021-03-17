function [trained_net_elman, tr_elman, elTimeElman] = Train_Elman(net_elman, vecCb, vecFl)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here


%Monta as sequencias da rede de Elman
seqs = {vecCb(:,1), vecCb(:,2), vecCb(:,3), vecCb(:,4)};
seqs = catsamples(seqs, {vecCb(:,5), vecCb(:,6), vecCb(:,7), vecCb(:,8)});
seqs = catsamples(seqs, {vecCb(:,9), vecCb(:,10), vecCb(:,11), vecCb(:,12)});
seqs = catsamples(seqs, {vecFl(:,1), vecFl(:,2), vecFl(:,3), vecFl(:,4)});
seqs = catsamples(seqs, {vecFl(:,5), vecFl(:,6), vecFl(:,7), vecFl(:,8)});
seqs = catsamples(seqs, {vecFl(:,9), vecFl(:,10), vecFl(:,11), vecFl(:,12)});

targSeqs = {[0;1], [0;1], [0;1], [0;1]};
targSeqs = catsamples(targSeqs, {[0;1], [0;1], [0;1], [0;1]});
targSeqs = catsamples(targSeqs, {[0;1], [0;1], [0;1], [0;1]});
targSeqs = catsamples(targSeqs, {[1;0], [1;0], [1;0], [1;0]});
targSeqs = catsamples(targSeqs, {[1;0], [1;0], [1;0], [1;0]});
targSeqs = catsamples(targSeqs, {[1;0], [1;0], [1;0], [1;0]});



%Treina a rede de Elman
net_elman = init(net_elman);
tic;
[trained_net_elman, tr_elman] = train(net_elman,seqs,targSeqs);
elTimeElman = toc;
end

