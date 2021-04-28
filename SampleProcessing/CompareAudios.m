function [] = CompareAudios(origFile,cutFile)
    %CompareAudios compara dois sinais de audio, sendo o primeiro o sinal
    %original, e o segundo o sinal obtido pelo corte de pedaços do sinal
    %original
    
    %Obtendo o sinal original e o sinal cortado
    [yOrig, fs] = audioread(origFile);
    [yCut, fs] = audioread(cutFile);
    
    %Obtendo informações do começo e fim do sinal cortado, inseridas como
    %comentario na hora de salvar o arquivo
    cutInfo = audioinfo(cutFile);
    xInit = str2num(cutInfo.Comment) - 1;   %Para considerar sinal comecando em 0, nao em 1
    %xInit = delim(1);
    xEnd = xInit + size(yCut,1)-1;
    
    step = 1/fs;
    xInit = xInit * step;
    xEnd = xEnd * step;
    sigEnd = (size(yOrig, 1)-1)*step;
    
    %Plot dos dois sinais juntos (para comparação)
    plot(0:step:sigEnd,yOrig);    
    title('Original x Corte')
    hold on

    plot(xInit:step:xEnd,yCut)
    hold off
    
end

