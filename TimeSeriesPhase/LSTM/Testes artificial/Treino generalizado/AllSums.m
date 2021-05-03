function [comb, combInd] = AllSums(vec1,vec2)
%AllSums Recebe dois vetores de tamanho nsig x nsamp e realiza todas as
%combinacoes de somas possiveis entre eles, retornando em comb
%   Realiza a operacao vec1(i,:)+vec2(j,:), para todas os valores possiveis
%   de i e j, e armazena em comb, resultando em um vetor i*j x nsmp

    sz1 = size(vec1,1);
    sz2 = size(vec2,1);
    nsamp = size(vec1,2);
    
    comb = zeros(sz1*sz2, nsamp);
    
    for i = 1:sz1
        for j = 1:sz2
            comb(((i-1)*sz2+j),:) = vec1(i,:) + vec2(j,:);
            combInd(((i-1)*sz2+j),:) = [i,j];
        end
    end 

end

