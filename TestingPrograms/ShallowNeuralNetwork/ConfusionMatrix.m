function [confMat] = ConfusionMatrix(y, target)
%ConfusionMatrix: Essa função recebe duas matrizes (saída da rede com uma
%entrada teste e seu respectivo target), e monta a matriz de confusão com a
%comparação de ambas


%ATENCAO, PROBLEMA ENCONTRADO. TODOS OS POSSIVEIS TARGETS DEVEM SER
%INSERIDOS NA MATRIZ ANTES DE Y SER TESTADO


confMat = {};

%Percorre todas as amostras, realizando as contagens
for i = 1:size(y,1)
    %Confere a posicao do target lido na matriz de confusão
    col = 0;
    for aux = 2:size(confMat,2)
        if isequal(target(i,:), confMat{1,aux})
            col = aux;
        end
    end
    
    %Se target não foi encontrado na matriz, cria nova linha e coluna para
    %o mesmo
    if col == 0
        sz = size(confMat, 2);
        confMat{1, sz+1} = target(i,:);
        confMat{sz+1, 1} = target(i,:);
        
        sz = sz+1;
        %Adiciona contadores zerados nas posições criadas
        for aux = 2:sz
            confMat{aux, sz} = 0;
            confMat{sz, aux} = 0;
        end
    
    
    %Se já existir, busca a linha
    else

    end
end
    
end

end

