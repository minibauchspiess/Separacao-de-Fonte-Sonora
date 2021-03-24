
%Apresenta os tempos de treino
%plot(2:50, cell2mat(timeMixed), 2:50, cell2mat(timePures), 2:50, cell2mat(timeAll))
%legend('Sinal mixado apenas', 'Sinais puros apenas', 'Sinais mixados e puros');
%title('Tempo de treinamento pelo número de neurônios');



%Loss x neuronios, epocas constante
epochs = 20;
epochsI = ((epochs - 20)/100)+1;
for i=2:10:52
    lossMixed{i} = trMixed{epochsI}{i}.TrainingLoss(end);
    lossPures{i} = trPures{epochsI}{i}.TrainingLoss(end);
    lossAll{i} = trAll{epochsI}{i}.TrainingLoss(end);
end
plot(2:10:52, cell2mat(lossMixed), 2:10:52, cell2mat(lossPures), 2:10:52, cell2mat(lossAll))
legend('Sinal mixado apenas', 'Sinais puros apenas', 'Sinais mixados e puros');
title("Loss de treino pelo número de neurônios, "+num2str(epochs)+" épocas");
xlabel('Neurônios');
ylabel('Loss');


%Loss x epocas, neuronios constantes
neuronios = 2;
for i=20:100:1020
    lossMixed{i} = trMixed{i}{neuronios}.TrainingLoss(end);
    lossPures{i} = trPures{i}{neuronios}.TrainingLoss(end);
    lossAll{i} = trAll{i}{neuronios}.TrainingLoss(end);
end
plot(2:10:52, cell2mat(lossMixed), 2:10:52, cell2mat(lossPures), 2:10:52, cell2mat(lossAll))
legend('Sinal mixado apenas', 'Sinais puros apenas', 'Sinais mixados e puros');
title("Loss de treino pelo número de épocas, "+num2str(neuronios)+" neuronios");
xlabel('MaxEpochs');
ylabel('Loss');



%Monta vetores de training RMSE e os apresenta
%for i=2:10:52
%    rmseMixed{i} = trMixed{i}.TrainingRMSE(end);
%    rmsePures{i} = trPures{i}.TrainingRMSE(end);
%    rmseAll{i} = trAll{i}.TrainingRMSE(end);
%end
%plot(2:50, cell2mat(rmseMixed), 2:50, cell2mat(rmsePures), 2:50, cell2mat(rmseAll))
%legend('Sinal mixado apenas', 'Sinais puros apenas', 'Sinais mixados e puros');
%title('RMSE de treino pelo número de neurônios');
%xlabel('Neurônios');
%ylabel('RMS');

%Insere a entrada na rede novamente e recupera o RMSE para este caso



