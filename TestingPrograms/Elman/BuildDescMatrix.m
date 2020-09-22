function [X, T, fs] = BuildDescMatrix(file, target, windowSize, windowCount)
%BuildDescMatrix: Função para montar a matriz de descritores de um único
%sinal de áudio passado

%Le o arquivo
[y, fs] = audioread(file);

%Adquire os descritores
[cent, spread, slope, dec, rol] = GetDescriptors(y, fs,  windowSize, windowCount);

%Forma o array de células
X = [cent'; spread'; slope'; dec'; rol'];

%Forma o array de células target de acordo com o tamanho do array de input
T = repmat(target,[1 size(X,2)]);
%{
%Divide o trecho em partes iguais, e recupera a parte pedida
sz = size(X, 2) / parts;
X = X( 1+(part-1)*sz : part*sz );
T = T( 1+(part-1)*sz : part*sz );
%}
end