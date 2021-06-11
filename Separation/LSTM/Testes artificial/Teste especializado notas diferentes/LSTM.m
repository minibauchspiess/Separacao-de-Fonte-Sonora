%Carrega as ondas que serao utilizadas
[s, fs] = audioread("../Ondas de entrada/Senoides/sin200.wav");
[sq, ~] = audioread("../Ondas de entrada/Quadradas/sq300.wav");
[tri, ~] = audioread("../Ondas de entrada/Triangulares/tri500.wav");
s=s';sq=sq';tri=tri';

addpath("../../../SSS_Eval");
numNeurons = [40 70 100 130 160];

for i=1:size(numNeurons,2)
    fprintf("Iniciando treino com "+num2str(numNeurons(i))+" neuronios\n");
    [layer, opt] = NetParams_LSTM(numNeurons(i), 5);
    [net{i}, tr{i}, time(i), sdrEvol{i}] = Train_LSTM(layer, opt, s, sq, tri, "MixedOnly", fs);

    [~, outMixed{i}] = predictAndUpdateState(net{i}, (s+sq+tri)/3);
    audiowrite("Resultados/ondas/"+num2str(numNeurons(i))+"neurons_outSin.wav", repmat(outMixed{i}(1,:), [1 100]), fs);
    audiowrite("Resultados/ondas/"+num2str(numNeurons(i))+"neurons_outSquare.wav", repmat(outMixed{i}(2,:), [1 100]), fs);
    audiowrite("Resultados/ondas/"+num2str(numNeurons(i))+"neurons_outTri.wav", repmat(outMixed{i}(3,:), [1 100]), fs);
        
   [SDR{i}, SIR{i}, SAR{i}, perm{i}] = bss_eval_sources(outMixed{i}, [s/3;sq/3;tri/3]);
end
save Resultados/vars2.mat


