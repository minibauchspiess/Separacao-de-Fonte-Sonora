%Carrega as ondas que serao utilizadas
[sources, fs] = LoadAllSamples("../Ondas de entrada/Senoides","../Ondas de entrada/Quadradas", "../Ondas de entrada/Triangulares");

%Quantos neuronios estarao na camada LSTM
numNeurons = 70;

%Caminho para funcao de avaliacao da separacao
addpath("../../../SSS_Eval");
warning("off", 'MATLAB:nearlySingularMatrix');

%Parametros e divisao das amostras para o K-Fold
k = 5;
[mix, targs] = TrainAndTargets(sources);
[mg, tg] = KGroups(mix, targs, k);

%Para cada conjunto do K-Fold, realiza um treinamento
[layer, opt] = NetParams_LSTM(numNeurons, 5);
for i = 1:k
    fprintf("Iniciando treino do conjunto "+num2str(i)+", com "+num2str(numNeurons)+" neuronios\n");
    
    %Separa conjunto de treino e de teste dos grupos de K-Fold
    [trainSamp, trainTarg, testSamp, testTarg] = TrainTestInTarg(mg, tg, i);
    
    %Treina o conjunto
    [net{i}, tr{i}, time(i), sdrEvol{i}] = Train_LSTM(layer, opt, trainSamp, trainTarg, fs);
    
    %Testa o conjunto
    SDR{i}=[];SIR{i}=[];SAR{i}=[];perm{i}=[];
    for j = 1:size(testSamp, 1)
        [~, outMixed{i,j}] = predictAndUpdateState(net{i}, testSamp{j});
        [sdr, sir, sar, p] = bss_eval_sources(outMixed{i,j}, testTarg{j});
        SDR{i}(:,end+1) = sdr;
        SIR{i}(:,end+1) = sir;
        SAR{i}(:,end+1) = sar;
        perm{i}(:,end+1) = p;
    end
    
    %SDR medio do treino i
    meanSDR{i} = mean(SDR{i}, 2);
    
end

fprintf("Treino com "+num2str(numNeurons)+" neuronios finalizado, SDR medio: "+num2str(mean(cell2mat(meanSDR), 2))+"\n");

save("Resultados/varsSDR1_"+num2str(numNeurons)+"n.mat");


