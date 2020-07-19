function [group, target] = KfoldGroups(matIn, tIn, k)
%KfoldGroups recebe as matrizes de entrada e organiza k grupos (k
%especificado nos parametros) de matrizes de entrada, sendo estes de
%tamanho igual e com quantidade balanceada das matrizes de entrada. Esses
%grupos são utilizados para utilização do método k-fold de validação de
%redes neurais




%Randomiza ordem das linhas das matrizes de entrada
szIn = size(matIn,2);
for i=1:szIn
    index = randperm(size(matIn{1},1));
    randMatIn{i} = matIn{i}(index, :);
    randTIn{i} = tIn{i}(index,:);
end




%Monta k grupos das linhas aleatorias
szInMat = size(matIn{1},1);
gpSz = floor(szInMat/k);   %Caso não seja divisão inteira, últimas amostras são desconsideradas

for j=1:k
    group{j} = [];
    target{j} = [];
    for i=1:szIn
        firstInd = 1 + ((j-1) * gpSz);
        lastInd = j * gpSz;
        group{j} = [group{j} ; randMatIn{i}(firstInd : lastInd,:)];   %group e target são montados combinando trechos iguais
        target{j} = [target{j} ; randTIn{i}(firstInd : lastInd,:)];   %das matrizes aleatorias criadas
    end
end





%Mistura novamente as matrizes, para que as matrizes utilizadas fiquem
%mistruradas entre si
for j=1:k
    index = randperm(size(group{j},1));
    group{j} = group{j}(index, :);
    target{j} = target{j}(index,:);
end



end

