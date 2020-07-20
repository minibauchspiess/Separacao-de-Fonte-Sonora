function [targetNamed,testNamed, error] = OutNames(target, test, outCb, outFl, error)
%OutNames: funcao com unico objetivo de transformar a matriz de saída no
%formato de vetor em um vetor de nomes. Facilita uso da funcao de matriz de
%confusao, que aceita apenas vetor como entrada, e, utilizando nomes, fica
%mais facil de analisar os resultados. A saida 'error' serve para avisar
%caso tenha ocorrido algum erro ao comparar um vetor

%roundedTest = round(test);
%Para cada vetor de saída, o maior equivale a 1, e o menor, a 0
for i = 1:size(test, 1)
    if test(i, 1) == max(test(i,:))
        test(i,1) = 1;
        test(i, 2) = 0;
    else
        test(i,1) = 0;
        test(i,2) = 1;
    end
end

for i = 1:size(target, 1)
    if isequal(target(i,:), outCb)
        targetNamed{i} = 'ContraBaixo';
    else
        targetNamed{i} = 'Flauta';
    end
    
    if isequal(test(i,:), outCb)
        testNamed{i} = 'ContraBaixo';
    elseif isequal(test(i,:), outFl)
        testNamed{i} = 'Flauta';
    else
        %Se nao tiver caido em nenhuma das opcoes anteriores, a saida nao
        %pode ser comparada a nenhum target, e isto deve ser informado
        testNamed{i} = 'Flauta';
        error = [error; strcat("saida de teste invalida na linha ", num2str(i))];
        
end

end

