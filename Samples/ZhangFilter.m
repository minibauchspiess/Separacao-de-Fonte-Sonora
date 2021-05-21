function [somFinal, somOrig, fs, pointBegin] = ZhangFilter(audioFile)

winSize = 1024;

[somOrig, fs] = audioread(audioFile);
winQtd = floor(size(somOrig, 1)/winSize);

%Computa as amplitudes de cada frame
A(1)=0;
A(2)=0;
A(winQtd+3)=0;
A(winQtd+4)=0;
for i = 3:winQtd+2
    buffer = somOrig((winSize*(i-3)+1):winSize*(i-2));  %Pega uma janela do audio
    A(i) = max(abs(buffer))*2;                          %Computa a amplitude maxima da janela
end

%Calcula o limiar baseado nas amplitudes
if mean(A) > 0.075*max(A)
    thresh = 0.015*max(A);
else
    thresh = 0.05*max(A);
end

%Determina se um frame eh sinal ou silencio
for i = 1:winQtd+4
    if A(i) >= thresh
        f(i) = 1;
        
    else
        f(i) = 0;
    end
end

%Determina comeco e fim do sinal
cStart=0;
cEnd=0;
for i = 3:(winQtd+2)
    if f(i) == 1
       if (f(i-1)==0) && (f(i-2)==0) && (cStart==0)
            cStart = i;
        elseif (f(i+1)==0) && (f(i+2)==0) && (cEnd==0)
            cEnd = i;
       end
    end
end


pointBegin = ((cStart-3)*winSize+1);
somFinal = somOrig(pointBegin:(cEnd-2)*winSize);

plot(0:1/fs:size(somOrig,1)/fs-1/fs,somOrig);
hold on
plot(((cStart-3)*winSize+1)/fs-1/fs:1/fs:(cEnd-2)*winSize/fs-1/fs, somFinal);
hold off


end

