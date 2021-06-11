%Rede para treinar o dataset de Fisher Iris
%Base obtida em: https://stackoverflow.com/questions/35074646/how-to-create-a-multi-layer-perceptron-in-matlab-for-a-multi-class-dataset


net = network(1, 2, [1; 1], [1;0], [0 0; 1 0], [0 1]);

net.adaptFcn = 'adaptwb';
net.divideFcn = 'dividerand'; %Set the divide function to dividerand (divide training data randomly).
net.divideParam.trainRatio = 1;
net.divideParam.valRatio = 0;
net.divideParam.testRatio = 0;


net.performFcn = 'mse';
net.trainFcn = 'trainlm'; % set training function to trainlm (Levenberg-Marquardt backpropagation) 

net.plotFcns = {'plotperform', 'plottrainstate', 'ploterrhist', 'plotconfusion', 'plotroc'};

%set Layer1
net.layers{1}.name = 'Layer 1';
net.layers{1}.dimensions = 7;
net.layers{1}.initFcn = 'initnw';
net.layers{1}.transferFcn = 'tansig';

%set Layer2
net.layers{2}.name = 'Layer 2';
net.layers{2}.dimensions = 3;
net.layers{2}.initFcn = 'initnw';
net.layers{2}.transferFcn = 'tansig';

[x,t] = iris_dataset; %load of the iris data set
net = train(net,x, t); %training

y = net(x); %prediction

%view(net2);