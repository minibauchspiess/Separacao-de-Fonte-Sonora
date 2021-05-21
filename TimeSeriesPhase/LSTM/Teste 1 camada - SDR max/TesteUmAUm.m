netAux = net;
sz = size(hp,2);
tic
for i = 1:sz/100
    inicio = (i-1)*100+1;
    fim = i*100;
    [netAux, out(:,inicio:fim)] = predictAndUpdateState(netAux, (hp(inicio:fim)+fh(inicio:fim))/2);
end
toc