%SourceClassifier - Classificador de fonte

%O programa abaixo aborda o problema da identificação do instrumento 
%musical em dois sinais de áudio distintos. Para tanto, cada sinal de áudio
%é separado em amostras de tamanhos iguais, e de cada amostra são extraídos
%5 descritores do som (spectral centroid, spread (espalhamento), slope, decrease e
%rolloff). Esses descritores serão utilizados para se determinar qual o
%instrumento tocado, utilizando-os como entrada numa rede neural rasa.
%A fim de analisar o desempenho da rede de forma mais aceita
%estatisticamente, será utilizado o método do k-fold, buscando qual a
%acurácia média das k redes treinadas. Redes que não convergiram não são
%consideradas para este propósito.



%***Parâmetros para pegar os dados das amostras***
SampleParams;


%***Parametros da rede***
net = NetParams();


%***Preparação das amostras por k-fold***
[groups, targets] = InputMatHandler(samplesFolder, cbFolder, outCb, flFolder, outFl, winSize, k);


%***Treinamento da rede***
TrainingHandler;
