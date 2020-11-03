function [] = CompareAudios(origFile,cutFile)
    %CompareAudios compara dois sinais de audio, sendo o primeiro o sinal
    %original, e o segundo o sinal obtido pelo corte de pedaços do sinal
    %original
    
    %Obtendo o sinal original e o sinal cortado
    [yOrig, ~] = audioread(origFile);
    [yCut, ~] = audioread(cutFile);
    
    %Obtendo informações do começo e fim do sinal cortado
    cutInfo = audioinfo(cutFile);
    delim = str2num(cutInfo.Comment);   %As informações de começo e fim do corte estão inseridas no atributo Comment das informações do audio
    xInit = delim(1);
    xEnd = delim(2);
    
    %Plot dos dois sinais juntos (para comparação)
    plot(yOrig);    
    title('Original x Corte')
    hold on

    plot(xInit:xEnd,yCut)
    hold off
    
end

