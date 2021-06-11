function [trainSamples, trainTargets] = TrainAndTargets(sources)
%TrainAndTargets Retorna o conjunto de treino e seus respectivos targets
%   inputs: 
%       - "sources" eh uma matriz nsrc x nsig x nsmp, sendo:
%           nsrc: numero de fontes
%           nsig: quantos sinais de audio foram utilizados para a fonte
%           nsmp: quantas amostras existem em cada sinal de audio
%
%   outputs:
%       - "trainSamples" eh
%       - "trainTargets" fornece as saidas esperadas para cada o 
%       respectivo "trainSamples"
    


    %Tamanho do vetor fornecido
    nsrc = size(sources, 1);
    nsig = size(sources, 2);
    nsmp = size(sources, 3);

    %Todas as possiveis combinacoes sao feitas para gerar a saida
    
    sources = sources/nsrc;
    
    sums(:,:) = sources(1,:,:);
    vec2(:,:) = sources(2, :, :);
    [sums, ind] = AllSums(sums, vec2);
    for src = 3:nsrc
        vec2(:,:) = sources(src, :, :);
        [sums, indAux] = AllSums(sums, vec2);
        
        newInd = [];
        for i = 1:size(indAux, 1)
            newInd(end+1, :) = [ind(indAux(i,1),:), indAux(i,2)];
        end
        ind = newInd;
    end
    
    
    %Criacao de trainSamples e trainTargets a partir das combinacoes
    for i = 1:size(sums, 1)
        trainSamples{i,:} = sums(i,:);
        for j = 1:nsrc
            t(:,:) = sources(j,ind(i,j),:);
            %t = t';
            targs(j,:) = t';
        end
        trainTargets{i,:} = targs;
    end
end

