%Rede para classificar entre flauta e baixo


%Debug
error = [];

%Parametros para pegar os dados das amostras
outCb = [0 1];
outFl = [1 0];
folder = 'AmostrasSonoras/Samples-SC';
files = {'Cb-ord-pp-1c- B4.aif' 'Fl-ord-B4-pp.aif'};
targets = {outCb outFl};

winPerAudio = 180;
winSize = 1024;

k = 10;



%Parametros da rede
numIn = 1;              %Apenas um input, sendo este um vetor
numLay = 2;             %Duas camadas, sendo uma intermediária e outra de output
biasCon = [1; 1];       %Todas camadas com bias
inCon = [1; 0];         %Input se conecta apenas à camada intermediaria
layCon = [0 0; 1 0];    %Layer intermediaria não recebe entrada de si mesma e da última
                        %Última layer recebe entrada da intermediária e não recebe de si mesma
outCon = [0 1];         %Apenas última camada é conectada ao output



net = network(1, 2, [1; 1], [1;0], [0 0; 1 0], [0 1]);

net.adaptFcn = 'adaptwb';
net.divideFcn = 'dividerand'; %Set the divide function to dividerand (divide training data randomly).
net.divideParam.trainRatio = 0.8;
net.divideParam.valRatio = 0.2;
net.divideParam.testRatio = 0;

net.performFcn = 'mse';
net.trainFcn = 'trainlm'; % set training function to trainlm (Levenberg-Marquardt backpropagation) 
net.trainParam.epochs = 5000;
net.trainParam.min_grad = 1e-15;
net.trainParam.max_fail = 5000;
net.trainParam.mu_max = 1e12;

net.plotFcns = {'plotperform', 'plottrainstate', 'ploterrhist', 'plotconfusion', 'plotroc'};

%set Layer1
net.layers{1}.name = 'Layer 1';
net.layers{1}.dimensions = 7;
net.layers{1}.initFcn = 'initnw';
net.layers{1}.transferFcn = 'tansig';

%set Layer2
net.layers{2}.name = 'Layer 2';
net.layers{2}.dimensions = 2;
net.layers{2}.initFcn = 'initnw';
net.layers{2}.transferFcn = 'tansig';




%Gerando as amostras
for i=1:size(files,2)
    path = fullfile(folder, files{i});
    [X{i}, T{i}, fs] = BuildSampleMatrix(path, targets{i}, winSize, winPerAudio);
end

%Gerando grupos para k-fold
[kX, kT] = KfoldGroups(X, T, k);




%Faz 10 treinos, com 10 combinações diferentes
for i = 1:k
    %Separa o grupo de treino
    xTrain{i} = [];
    xTarget{i} = [];
    for j = 1:k
        if i ~= j
            xTrain{i} = [xTrain{i}; kX{j}];
            xTarget{i} = [xTarget{i}; kT{j}];
        end
    end
    
    %Separa o grupo de testes
    xTest{i} = kX{i};
    xTestTarget{i} = kT{i};
    
    %Reinicia a rede
    net = init(net);
    
    %Treina a rede, utilizando o grupo em questão
    trainedNet{i} = train(net, xTrain{i}', xTarget{i}');
    
    %Utilizando o vetor de teste, para testar a acurácia da rede
    y{i} = trainedNet{i}(xTest{i}');
    
    %Transforma as saidas em forma de vetor em celula de strings (para uso
    %na matriz de confusao)
    [testTargetNamed{i}, yNamed{i}, error] = OutNames(xTestTarget{i}, y{i}', outCb, outFl, error);
    
    %Gera matriz de confusao para este teste
    conf{i} = confusionmat(testTargetNamed{i}, yNamed{i}, 'Order', {'Flauta', 'ContraBaixo'});
    
end

%{
%Retira um grupo, mistura o restante
xTrain{1} = [kX{1}; kX{2}; kX{3}; kX{4}; kX{5}; kX{6}; kX{7}; kX{8}; kX{9}];
xTarget{1} = [kT{1}; kT{2}; kT{3}; kT{4}; kT{5}; kT{6}; kT{7}; kT{8}; kT{9}];
xTest{1} = kX{10};
xTestTarget{1} = kT{10};
%index = randperm(size(xTrain{1},1));
%xTrain{1} = xTrain{1}(index, :);

%Treina a rede
net = init(net);
trainedNet{1} = train(net, xTrain{1}', xTarget{1}');


y = trainedNet{1}(xTest{1}');


%net = train(net,x, t); %training

%y = net(x); %prediction

%view(net2);
%}
