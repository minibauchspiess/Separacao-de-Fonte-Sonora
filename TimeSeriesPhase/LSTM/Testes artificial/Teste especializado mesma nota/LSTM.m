%Carrega as ondas que serao utilizadas
[s, fs] = audioread("../Ondas de entrada/Senoides/sin400.wav");
[sq, ~] = audioread("../Ondas de entrada/Quadradas/sq400.wav");
[tri, ~] = audioread("../Ondas de entrada/Triangulares/tri400.wav");
s=s';sq=sq';tri=tri';

%Criacao das envoltorias aplicadas a cada

numNeurons = [40 70 100 130 160];

for i=1:size(numNeurons,2)
    fprintf("Iniciando treino com "+num2str(numNeurons(i))+" neuronios\n");
    [layer, opt] = NetParams_LSTM(numNeurons(i), 1);
    [net{i}, tr{i}, time(i), epochs(i)] = Train_LSTM(layer, opt, s, sq, tri, "All", fs);

    [~, outMixed{i}] = predictAndUpdateState(net{i}, repmat((s+sq+tri)/3,[1 100]));
    audiowrite("Resultados/ondas/"+num2str(numNeurons(i))+"neurons_outSin.wav", outMixed{i}(1,:), fs);
    audiowrite("Resultados/ondas/"+num2str(numNeurons(i))+"neurons_outSquare.wav", outMixed{i}(2,:), fs);
    audiowrite("Resultados/ondas/"+num2str(numNeurons(i))+"neurons_outTri.wav", outMixed{i}(2,:), fs);
end
save Resultados/vars2.mat


