function [InMat, TargetMat, fs] = BuildSampleMatrix(file, target, windowSize)
%BuildSamplesMatrix: Essa funcao monta a matriz de vetores de descritores e
%targets a partir

%Le o arquivo
[y, fs] = audioread(file);

%Adquire os descritores
[cent, spread, slope, dec, rol] = GetDescriptors(y, fs,  windowSize);

%Os envia a uma matriz
InMat = [cent spread slope dec rol];

%Cria matriz target do tamanho da matriz InMat
TargetMat = repmat(target, [size(InMat,1) 1] );

end

