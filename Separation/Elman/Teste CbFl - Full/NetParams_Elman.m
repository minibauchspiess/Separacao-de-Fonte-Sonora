function [net] = NetParams_Elman()
%NetParams Função para inserir os parâmetros desejados da rede e retornar a
%rede resultante
%   Função criada apenas para deixar o script principal mais "limpo"
    
    net = elmannet(1, 14);      %Um delay na camada escondida, 14 neurônios na camada escondida
    net.divideFcn = '';         %Todos os valores de entrada são para treino
    net.layers{2}.transferFcn = 'purelin';      %Saida direto da rede, para pegar a sequencia
    net.trainFcn = 'trainlm';   %Treino com Levenberg-Marquardt
    %net.outputs{2}.processFcns = {'removeconstantrows'};    %Retira o default 'mapminmax' (necessario para 'softmax' funcionar'
    net.trainParam.min_grad = 1e-20;
    
end

