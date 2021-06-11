function [groups, targets] = InputMatHandler(samplesFolder, cbFolder, cbTarget, flFolder, flTarget, windowSize, k)
%InputMatHandler: funcao responsavel por montar a matriz de entrada da rede
%neural a partir dos arquivos de audio correspondentes

%Recupera os nomes dos arquivos utilizados
cbPath = fullfile(samplesFolder, cbFolder);
cbFiles = dir(cbPath);

flPath = fullfile(samplesFolder, flFolder);
flFiles = dir(flPath);


%Recupera as matrizes dos audios de contrabaixo e as concatena
cbMat = [];
cbTarg = [];
for i = 3:size(cbFiles, 1)  %Desconsidera '.' e '..'
    %Monta o caminho ao arquivo
    filePath = fullfile(cbPath, cbFiles(i).name);
    
    %Monta as matrizes do arquivo i
    [auxMat, auxTarg, ~] = BuildSampleMatrix(filePath, cbTarget, windowSize);
    
    
    %Concatena com as anteriores
    cbMat = [cbMat;auxMat];
    cbTarg = [cbTarg;auxTarg];
end

%Recupera as matrizes dos audios de flauta e as concatena com as de
%contrabaixo
flMat = [];
flTarg = [];
for i = 3:size(flFiles, 1)  %Desconsidera '.' e '..'
    %Monta o caminho ao arquivo
    filePath = fullfile(flPath, flFiles(i).name);
    
    %Monta as matrizes do arquivo i
    [auxMat, auxTarg, ~] = BuildSampleMatrix(filePath, flTarget, windowSize);
    
    
    %Concatena com as anteriores
    flMat = [flMat;auxMat];
    flTarg = [flTarg;auxTarg];
end

%Balanceando as matrizes
%Ponto de corte para a matriz maior
cutPoint = min(size(cbMat,1), size(flMat,1));

%Embaralha ambas as matrizes (sem preferencia de quais linhas serao
%mantidas
cbMat = cbMat(randperm(size(cbMat,1)), :);
flMat = flMat(randperm(size(flMat,1)), :);

%Corta as matrizes
cbMat = cbMat(1:cutPoint, :);
%cbTarg = cbTarg(1:cutPoint, :);
flMat = flMat(1:cutPoint, :);
%flTarg = flTarg(1:cutPoint, :);

%Gera os grupos para K-Fold
[groups, targets] = KfoldGroups(cbMat, cbTarget, flMat, flTarget, k);

end

