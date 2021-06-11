function [Xtrain,Ttrain,Xtest,Ttest] = TrainTestKGroups(X,T,part)
%TrainTestKGroup separa grupos de treino e teste 
%   A partir do índice (part) de X e T especificado, separa o grupo do
%   índice como teste, e o resto como treino

    %Grupo de teste
    Xtest = X{part};
    Ttest = T{part};
    
    %Insere o primeiro grupo no treino, para inicializar a variavel
    if part~=1
        Xtrain = X{1};
        Ttrain = T{1};
        initI = 2;
    else
        if size(X,2) > 1
            Xtrain = X{2};
            Ttrain = T{2};
            initI = 3;
        end
    end
    
    %Grupo de treino 
    for i=initI:size(X,2)
        %Insere no grupo de treino apenas se nao for parte do grupo de
        %testes
        if i~=part
            Xtrain = catsamples(Xtrain,X{i},'pad');
            Ttrain = catsamples(Ttrain,T{i},'pad');
        end
    end
end

