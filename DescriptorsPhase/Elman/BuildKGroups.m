function [X, T] = BuildKGroups(inpMats, targMats, k, seqSize)
%BuildKGroups Retorna dois vetores de células, cada elemento sendo um grupo
%utilizado para o K-fold
%   X contém os descritores, T contém os targets
    
    groupIndex = 1; %Índice utilizado para determinar em qual grupo a sequência será inserida
    X = cell(1,k);
    T = cell(1,k);
    flag = 1;   %Flag indicando que é a primeira passagem
    
    %Para cada conjunto de matrizes (instrumentos diferentes), realiza as
    %operações abaixo
    for inst = 1:size(inpMats,2)
    
    
        %Percorre as matrizes de amostras do primeiro instrumento, associando
        %cada sequencia de vetor de descritores a um dos grupos
        for mat = 1:size(inpMats{inst},2)
            for seqNum = 1:floor(size(inpMats{inst}{mat},2) / seqSize)
                
                %Recupera a sequencia desejada a partir da matriz
                seqX = {};
                seqT = {};
                for i = 1:seqSize
                    seqX{i} = inpMats{inst}{mat}{(seqNum-1)*seqSize + i};
                    seqT{i} = targMats{inst}{mat}{(seqNum-1)*seqSize + i};
                end
                
                %Associa a sequencia ao grupo especifico
                if flag
                    X{groupIndex} = seqX;
                    T{groupIndex} = seqT;
                    if groupIndex == k
                        flag = 0;
                    end
                else
                    X{groupIndex} = catsamples(X{groupIndex}, seqX, 'pad');
                    T{groupIndex} = catsamples(T{groupIndex}, seqT, 'pad');
                end
                
                %Atualiza groupIndex
                groupIndex = rem(groupIndex, k) + 1;  %Loop de 1 até k
                
            end

        end

    end



    

%{
    szOut = seqSize*size(inpMats{1}, 2);    %Quantas amostras serão criadas
    szSamples = size(inpMats{1}{1}, 2)/seqSize;   %Quantas colunas cada amostra irá possuir
    
    X = cell(1,szOut);
    T = cell(1,szOut);
    
    
    for i=1:size(inpMats{1}, 2)
        
        for j=1:seqSize
            %Fórmulas dos índices recuperados das matrizes
            outIndex = (i-1)*seqSize + j; %Índice do vetor de células de saída
           
            iStart = (j-1)*szSamples + 1;   %Primeira e última coluna adquirida de uma das matrizes,
            iEnd = j*szSamples;             %separando as amostras dentro de cada matriz
            
            %Monta as matrizes
            X{outIndex} = catsamples(inpMats{1}{i}(:,iStart:iEnd), inpMats{2}{i}(:,iStart:iEnd), 'pad');
            T{outIndex} = catsamples(targMats{1}{i}(:,iStart:iEnd), targMats{2}{i}(:,iStart:iEnd), 'pad');
        end
    end
   %} 

end

