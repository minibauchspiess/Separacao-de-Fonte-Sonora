function [X, T] = BuildKGroups(inpMats, targMats, divisions)
%BuildKGroups Retorna dois vetores de células, cada elemento sendo um grupo
%utilizado para o K-fold
%   X contém os descritores

    szOut = divisions*size(inpMats{1}, 2);    %Quantas amostras serão criadas
    szSamples = size(inpMats{1}{1}, 2)/divisions;   %Quantas colunas cada amostra irá possuir
    
    X = cell(1,szOut);
    T = cell(1,szOut);
    
    for i=1:size(inpMats, 2)
        curXMat1 = inpMats{
        
        for j=1:divisions
            %Fórmulas dos índices recuperados das matrizes
            outIndex = (i-1)*divisions + j; %Índice do vetor de células de saída
           
            iStart = (j-1)*szSamples + 1;   %Primeira e última coluna adquirida de uma das matrizes,
            iEnd = j*szSamples;             %separando as amostras dentro de cada matriz
            
            %Monta as matrizes
            X{outIndex} = catsamples(inpMats{1}{i}(:,iStart:iEnd), inpMats{2}{i}(:,iStart:iEnd), 'pad');
            T{outIndex} = catsamples(targMats{1}{i}(:,iStart:iEnd), targMats{2}{i}(:,iStart:iEnd), 'pad');
        end
    end
    

end

