function [layers, options] = NetParams_LSTM(maxEpochs)

inputSize = 1;
numClasses = 2;

layers = [ ...
    sequenceInputLayer(inputSize, 'Name', 'input')
    lstmLayer(8,'OutputMode','sequence', 'Name', 'LSTM1')
    lstmLayer(20,'OutputMode','sequence', 'Name', 'LSTM2')
    %lstmLayer(numClasses,'OutputMode','sequence', 'Name', 'LSTM_out')
    fullyConnectedLayer(numClasses, 'Name', 'output')
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

