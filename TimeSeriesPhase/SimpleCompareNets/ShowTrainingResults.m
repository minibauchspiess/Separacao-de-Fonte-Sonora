
%Apresenta os tempos de treino
%plot(2:50, cell2mat(timeMixed), 2:50, cell2mat(timePures), 2:50, cell2mat(timeAll))
%legend('Sinal mixado apenas', 'Sinais puros apenas', 'Sinais mixados e puros');
%title('Tempo de treinamento pelo número de neurônios');

%Monta vetores de training loss e os apresenta
for i=2:50
    lossMixed{i} = trMixed{i}.TrainingLoss(end);
    lossPures{i} = trPures{i}.TrainingLoss(end);
    lossAll{i} = trAll{i}.TrainingLoss(end);
end
%plot(2:50, cell2mat(lossMixed), 2:50, cell2mat(lossPures), 2:50, cell2mat(lossAll))
%legend('Sinal mixado apenas', 'Sinais puros apenas', 'Sinais mixados e puros');
%title('Loss de treino pelo número de neurônios');
%xlabel('Neurônios');
%ylabel('Loss');



%Monta vetores de training RMSE e os apresenta
for i=2:50
    rmseMixed{i} = trMixed{i}.TrainingRMSE(end);
    rmsePures{i} = trPures{i}.TrainingRMSE(end);
    rmseAll{i} = trAll{i}.TrainingRMSE(end);
end
plot(2:50, cell2mat(rmseMixed), 2:50, cell2mat(rmsePures), 2:50, cell2mat(rmseAll))
legend('Sinal mixado apenas', 'Sinais puros apenas', 'Sinais mixados e puros');
title('RMSE de treino pelo número de neurônios');
xlabel('Neurônios');
ylabel('RMS');

%Insere a entrada na rede novamente e recupera o RMSE para este caso



