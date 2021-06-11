function [meanSDR] = GetMeanSDR(net, samples, targets, n)
%meanSDR retorna o sdr medio testando a net com n vetores aleatorios de
%samples e targets
%   Inputs:
%       - net: rede recorrente treinada a ser testada
%       - samples: entradas da rede. Apenas n amostras serao selecionadas
%       - targets: saidas esperadas da rede. Apenas n serao selecionadas,
%           referentes ao seu sample
%   Outputs:
%       - mSDR: valor medio de SDR

    %Decide aleatoriamente os indices de samples e targets que serao
    %testados
    ind = randperm(size(samples,1))';
    ind = ind(1:n);
    %ind = round(size(samples,1)*rand(n,1));
    
    %Avisa se tiver tido teste com numeros repetidos
    if size(ind,1) ~= size(unique(ind),1)
        fprintf("\nSDR medio calculado com mesma amostra "+num2str(size(ind,1) - size(unique(ind),1))+"\n");
    end
    
    %Testa n vezes, armazenando os valores de sdr
    SDR = [];
    for i = 1:n
        [~, out] = predictAndUpdateState(net, samples{ind(i)});
        sdr = bss_eval_sources(out, targets{ind(i)});
        SDR = [SDR,sdr];
    end
    meanSDR = mean(mean(SDR));

end

