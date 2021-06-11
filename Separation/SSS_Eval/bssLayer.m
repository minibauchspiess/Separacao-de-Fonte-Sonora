classdef bssLayer < nnet.layer.RegressionLayer
    %bssLayer is an output layer designed for source separation problems,
    %using the SDR (Source to Distortion Ratio) measure to calculate the
    %loss function. Since a higher SDR means a higher accuracy, the loss
    %will be given by 1/SDR

    methods

        function loss = forwardLoss(layer, Y, T)
            % Return the loss between the predictions Y and the training 
            % targets T.
            %
            % Inputs:
            %         layer - Output layer
            %         Y     – Predictions made by network
            %         T     – Training targets
            %
            % Output:
            %         loss  - Loss between Y and T

            [SDR, ~, ~, ~] = bss_eval_sources(double(permute(extractdata(Y), [1 3 2])), double(permute(T, [1 3 2])));
            loss = 1/mean(SDR);
            loss = repmat(loss, [1 size(T, 3)]);
            loss = dlarray(loss);
        end
    end
end