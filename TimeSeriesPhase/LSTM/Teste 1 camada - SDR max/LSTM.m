%Carrega arquivos de hp e fh
[hp, fs] = audioread("../../../Samples/TrainSamples/Harp-Fh/Hp-A#1-ff.wav");hp=hp';
[fh, ~] = audioread("../../../Samples/TrainSamples/Harp-Fh/Fh-G4-pp.wav");fh=fh';

duracaoDaNota = 3;          %Quantos segundos da nota sao usados pro treino

%Para treinar com a nota inteira, descomente a linha seguinte
%duracaoDaNota = size(hp,1);

hpCut=hp(1:duracaoDaNota*fs);fhCut=fh(1:duracaoDaNota*fs);


%Faz os treinamentos
addpath("../../SSS_Eval");
%warning("off","MATLAB:nearlySingularMatrix");   %O calculo de SDR mostra muito esse warning
warning("off");     %Suprime o warning acima e o avisando da GPU, pro log ficar limpo
numNeurons = 60;   %Qtd de neuronios na camada LSTM
maxEpochs = 5;      %De quantas em quantas epocas a rede eh treinada
maxCount = 1000;     %Quantos treinamentos sem melhoria da rede sao feitos antes de aceitar a rede como a melhor

fprintf("Iniciando treino com "+num2str(numNeurons)+" neuronios\n");
[layer, opt] = NetParams_LSTM(numNeurons, maxEpochs);
[net, tr, time, sdrEvol] = Train_LSTM(layer, opt, hpCut, fhCut, maxCount, fs);

[~, outMixed] = predictAndUpdateState(net, (hpCut+fhCut)/2);
audiowrite("Resultados/ondas/"+num2str(numNeurons)+"neurons_outHpSDR.wav", outMixed(1,:), fs);
audiowrite("Resultados/ondas/"+num2str(numNeurons)+"neurons_outFhSDR.wav", outMixed(2,:), fs);

[SDR, SIR, SAR, perm] = bss_eval_sources(outMixed, [hpCut;fhCut]/2);

save("Resultados/vars_SDR_"+num2str(numNeurons)+".mat")

warning("on");  %Reativa os warnings, caso o usuario precise

