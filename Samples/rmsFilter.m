function [somFinal, somOrig, fs, pointBegin] = rmsFilter(audioFile)
winSize = 1024;
thresh = -40;

[somOrig, fs] = audioread(audioFile);
winQtd = floor(size(somOrig, 1)/winSize);

%windows = {};
soundBegin = 1;
soundEnd = 1;
for i = 1:winQtd
    buffer = somOrig((winSize*(i-1)+1):winSize*i);
    windows(i) = 20*log10(rms(buffer));
    %windows(i) = rms(buffer);
end

%m = mean(windows);  %Media dos rms
%sd = std(windows);  %Desvio padrao dos rms
%thresh = m - 0.1*sd;  %Limiar para considerar som ou ruido

for i = 1:winQtd
    if((windows(i) > thresh)&&(soundBegin == 0))
        soundBegin = i;
    end
    if((soundBegin ~= 0) && (windows(i) > thresh))
        soundEnd = i;
    end
end


pointBegin = ((soundBegin-1)*winSize+1);

somFinal = somOrig(pointBegin:soundEnd*winSize);

%tiledlayout(2,1)

%nexttile
plot(somOrig)
hold on
plot(((soundBegin-1)*winSize+1):soundEnd*winSize, somFinal);
hold off

%nexttile
%plot(cell2mat(windows));
end
