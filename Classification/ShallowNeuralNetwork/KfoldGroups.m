function [group, target] = KfoldGroups(cbIn, cbTarg, flIn, flTarg, k)
%KfoldGroups recebe a matriz de entrada e organiza k grupos (k
%especificado nos parametros) de matrizes de entrada, sendo estes de
%tamanho igual e com quantidade balanceada das matrizes de entrada. Esses
%grupos são utilizados para utilização do método k-fold de validação de
%redes neurais





%Separa as k partes das matrizes mescladas
gpSz = floor(size(cbIn,1)/k)*2;   %tamanho de cada parte

group = cell(k,1);
target = cell(k,1);
for i = 1:k
    %Prealocacao para agilidade do codigo
    group{i} = zeros(gpSz, 5);
    target{i} = zeros(gpSz, 2);
    
    %Montando a parte i
    for j = 1:(gpSz/2)
        group{i}( (2*(j-1)+1), : ) = cbIn( ((i-1)*(gpSz/2)+j) , : );
        group{i}((2*j),:) = flIn(((i-1)*(gpSz/2)+j),:);
        
        
        target{i}( (2*(j-1)+1), : ) = cbTarg;%( ((i-1)*(ptSz/2)+j) , : );
        target{i}((2*j),:) = flTarg;%(((i-1)*(ptSz/2)+j),:);
    end
end

    
%{
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
%}



%{
%Mistura novamente as matrizes, para que as matrizes utilizadas fiquem
%mistruradas entre si
for j=1:k
    index = randperm(size(group{j},1));
    group{j} = group{j}(index, :);
    target{j} = target{j}(index,:);
end
%}


end

