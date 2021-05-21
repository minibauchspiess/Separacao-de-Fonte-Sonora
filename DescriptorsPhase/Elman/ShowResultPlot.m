%Selecao da rede a ser testada
load("Resultados/CLASS4.mat", 'trainedNet');    %Carrega as redes
net = trainedNet{1}{10};    %Seleciona a rede de teste
clear trainedNet;   %Apaga o que foi carregado (limpeza do workspace)

%Carrega as amostras
[cb, fs] = audioread("../../Samples/Preprocessed/filtZhang/Cb-ord/Cb-ord-pp-1c- A4.wav");
fl = audioread("../../Samples/Preprocessed/filtZhang/Fl-ord/Fl-ord-C4-pp.wav");
tcb = 0:size(cb,1)-1; tcb=tcb/fs;
tfl = 0:size(fl,1)-1; tfl=tfl/fs; tfl=tfl+tcb(end)+1/fs;

%plot(tcb, cb, tfl, fl)
%clear;clc

%Gera os descritores da combinacao
xwave = [cb;fl];
xtime = [tcb tfl];
[c, sp, sl, dec, rol] = GetDescriptors(xwave, fs, 1024);
xdesc = [c,sp,sl,dec,rol]'; xdesc = con2seq(xdesc);

%Agrupa em sequencias de 4, aplica na entrada e recupera as saidas
out = [];
for i=1:floor(size(xdesc,2)/4)-1
    for j=1:4
        seq{1,j} = xdesc{1,4*i+j};
    end
    y = net(seq);
    out = [out cell2mat(y)];
end

%Faz o plot da entrada com as predicoes
yyaxis left
plot(tcb, cb, 'Color', 'b');hold on;
plot(tfl, fl, '-','Color', 'c');hold off;
axis([0 tfl(end)*1.1 -0.2 0.2]);
xlabel("Tempo (s)");
ylabel("Amplitude");
title("Classificação instrumental");
subtitle("0 - contrabaixo; 1 - flauta");

yyaxis right
tout = 0:size(out,2)-1; tout = tout*1024/fs;
plot(tout, out(1,:));
ylabel("Predição");
axis([0 tfl(end)*1.1 -0.1 1.1]);
legend({"Contrabaixo", "Flauta", "Predição"}, 'Location', 'southeast');




