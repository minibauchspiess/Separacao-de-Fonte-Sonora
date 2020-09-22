function [X, T, fs] = BuildDescInputCells(file, target, windowSize, windowCount, part, parts)
%BuildInputCells: Função para ler o arquivo de áudio recebido e formar o
%array de células sequencial dos descritores

%Le o arquivo
[y, fs] = audioread(file);

%Adquire os descritores
[cent, spread, slope, dec, rol] = GetDescriptors(y, fs,  windowSize, windowCount);

%Forma o array de células
X = con2seq([cent'; spread'; slope'; dec'; rol']);

%Forma o array de células target de acordo com o tamanho do array de input
T = con2seq( repmat(target,[1 size(X,2)]) );

%Divide o trecho em partes iguais, e recupera a parte pedida
sz = size(X, 2) / parts;
X = X( 1+(part-1)*sz : part*sz );
T = T( 1+(part-1)*sz : part*sz );

end