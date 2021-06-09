%Carrega a rede classificadora
load("../Elman/Resultados/flvnamb.mat", 'trainedNet')
net = trainedNet{1}{2};
clear trainedNet

%Parametros
fs = 44100;
nbits = 16;
chan = 1;

%Inicia gravacao
r = audiorecorder(fs, nbits, chan);
record(r);
pause(2);   %Precisa dar um tempo pra garantir que vai ter audio gravado ja
tic
last = toc;
while toc<60
    if toc-last > 0.01
        y = getaudiodata(r);
        
        %Monta a sequencia de entrada com os descritores
        [c, sp, sl, dec, rol] = GetDescriptors(y(end-4*1024:end), fs, 1024);
        desc = [c,sp,sl,dec,rol]';
        x{1} = desc(1:5,1);
        x{2} = desc(1:5,2);
        x{3} = desc(1:5,3);
        x{4} = desc(1:5,4);
        
        %Apresenta a saida da rede
        out = net(x);
        out = out{end};
        clc
        [~,ind] = max(out);
        if ind==1
            fprintf("\n\n\t\t\tFlauta");
        elseif ind==2
            fprintf("\n\n\t\t\tViolino");
        else
            fprintf("\n\n\t\t\tNada");
        end
        %fprintf(num2str(out{4}(1))+"\t"+num2str(out{4}(2))+"\t"+num2str(out{4}(3)))
        %mat = cell2mat(out);
        %clc
        %fprintf(num2str(mat(1,end)));
        
    else
        fprintf("deu tempo");
    end
    %y = getaudiodata(r);
    %clc
    %size(y)
    %plot(y(end-1024:end));
    %pause(0.01)
end
stop(r)