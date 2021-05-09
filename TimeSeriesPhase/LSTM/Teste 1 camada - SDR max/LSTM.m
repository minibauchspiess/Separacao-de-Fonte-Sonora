%Carrega arquivos de hp e fh
[hp, fs] = audioread("../../../Samples/TrainSamples/Harp-Fh/Hp-A#1-ff.wav");
[fh, ~] = audioread("../../../Samples/TrainSamples/Harp-Fh/Fh-G4-pp.wav");
hp=hp(1:2*fs)';fh=fh(1:2*fs)';


%Faz os treinamentos
addpath("../../SSS_Eval");
warning("off","MATLAB:nearlySingularMatrix");
numNeurons = 70;
maxEpochs = 5;
maxCount = 500;

fprintf("Iniciando treino com "+num2str(numNeurons)+" neuronios\n");
[layer, opt] = NetParams_LSTM(numNeurons, 5);
[net, tr, time, sdrEvol] = Train_LSTM(layer, opt, hp, fh, maxCount, fs);

[~, outMixed] = predictAndUpdateState(net, (hp+fh)/3);
audiowrite("Resultados/ondas/"+num2str(numNeurons)+"neurons_outHpSDR.wav", outMixed(1,:), fs);
audiowrite("Resultados/ondas/"+num2str(numNeurons)+"neurons_outFhSDR.wav", outMixed(2,:), fs);

[SDR, SIR, SAR, perm] = bss_eval_sources(outMixed, [hp;fh]/2);

save("Resultados/vars_SDR_"+num2str(numNeurons)+".mat")

