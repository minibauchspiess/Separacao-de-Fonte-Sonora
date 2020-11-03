function [X, T, fs] = BuildDescMatrix(file, target, windowSize)
%BuildDescMatrix: Função para montar a matriz de descritores de um único
%sinal de áudio passado

%Le o arquivo
[y, fs] = audioread(file);

%Adquire os descritores
[cent, spread, slope, dec, rol] = GetDescriptors(y, fs,  windowSize);

%Forma o array de células
X = [cent'; spread'; slope'; dec'; rol'];

%Forma o array de células target de acordo com o tamanho do array de input
T = repmat(target,[1 size(X,2)]);

%Formata as matrizes para que cada vetor coluna seja uma celula
X = con2seq(X);
T = con2seq(T);

end