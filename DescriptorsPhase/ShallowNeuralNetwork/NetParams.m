function [net] = NetParams()

    numIn = 1;              %Apenas um input, sendo este um vetor
    numLay = 2;             %Duas camadas, sendo uma intermediária e outra de output
    biasCon = [1; 1];       %Todas camadas com bias
    inCon = [1; 0];         %Input se conecta apenas à camada intermediaria
    layCon = [0 0; 1 0];    %Layer intermediaria não recebe entrada de si mesma e da última
                            %Ultima layer recebe entrada da intermediária e não recebe de si mesma
    outCon = [0 1];         %Apenas última camada é conectada ao output

    net = network(numIn, numLay, biasCon, inCon, layCon, outCon);   %Arquitetura da rede criada



    %***Parametros para treinamento da rede***

    net.adaptFcn = 'adaptwb';
    net.divideFcn = 'dividerand'; %Divide-se o conjunto de treinamento aleatoriamente
    net.divideParam.trainRatio = 0.8;   %Divisão dos conjuntos de treinamento, validação e teste
    net.divideParam.valRatio = 0.2;
    net.divideParam.testRatio = 0;  %O conjunto de teste é separado e testado manualmente, com o método de k-fold

    net.performFcn = 'mse';     %Mean Square Error, medida de performance da rede
    net.trainFcn = 'trainlm';   %Função de treino segue o modelo de Levenberg-Marquardt backpropagation
    net.trainParam.epochs = 10000;  
    net.trainParam.min_grad = 1e-15;
    net.trainParam.max_fail = 2500;
    net.trainParam.mu_max = 1e99;

    net.plotFcns = {'plotperform','plotconfusion'};



    %***Arquitetura das camadas da rede***

    %Layer 1
    net.layers{1}.name = 'Layer 1';
    net.layers{1}.dimensions = 14;  %14 neurônios na camada intermediária
    net.layers{1}.initFcn = 'initnw';
    net.layers{1}.transferFcn = 'tansig';

    %set Layer2
    net.layers{2}.name = 'Layer 2';
    net.layers{2}.dimensions = 2;   %2 neurônios na camada de saída (cada um indica a um dos instrumentos)
    net.layers{2}.initFcn = 'initnw';
    net.layers{2}.transferFcn = 'softmax';

end

