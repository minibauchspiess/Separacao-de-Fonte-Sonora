function [layers, options] = NetParams_LSTM(numHiddenUnits, maxEpochs)

inputSize = [1 1 1];
numClasses = 2;

layers = [ ...
    sequenceInputLayer(inputSize, 'Name', 'input')
    sequenceFoldingLayer('Name', 'fold')
    convolution2dLayer([1 256], 8, 'stride', [1 2])
    convolution2dLayer([1 256], 16, 'stride', [1 2])
    convolution2dLayer([1 128], 32, 'stride', [1 2])
    convolution2dLayer([1 64], 16, 'stride', [1 2])
    convolution2dLayer([1 64], 8, 'stride', [1 2])
    convolution2dLayer([1 32], 2, 'stride', [1 2])
    lstmLayer(4,'OutputMode','sequence', 'Name', 'LSTM')
    lstmLayer(2,'OutputMode','sequence', 'Name', 'LSTM')
    regressionLayer('Name', 'regression')];

miniBatchSize = 1;

options = trainingOptions('adam', ...
    'ExecutionEnvironment','gpu', ...
    'GradientThreshold',1, ...
    'MaxEpochs',maxEpochs, ...
    'MiniBatchSize',miniBatchSize, ...
    'SequenceLength','longest', ...
    'Shuffle','never', ...
    'Verbose',0);
end

