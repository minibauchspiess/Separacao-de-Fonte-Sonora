function [InMat, TargetMat, fs] = BuildSampleMatrix(file, target, windowSize, windowCount)
%BuildSamplesMatrix: Essa funcao monta a matriz de amostra e alvo a
%partir do nome do arquivo de audio passado

%Le o arquivo
[y, fs] = audioread(file);

%Adquire os descritores
[cent, spread, slope, dec, rol] = GetDescriptors(y, fs,  windowSize, windowCount);

%Os envia a uma matriz
InMat = [cent spread slope dec rol];

%Cria matriz target do tamanho da matriz InMat
[szl,szc] = size(InMat);
TargetMat = repmat(target, [szl 1] );
%TargetMat2= zeros(szl,2);
%TargetMat2(:)=target;

end

