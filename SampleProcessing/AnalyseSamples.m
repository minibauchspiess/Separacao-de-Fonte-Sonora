SamplesFolder = '../Samples/flute-ordinario';
files = dir(SamplesFolder);

for i=4:size(files, 1)
    %Monta o caminho
    path = fullfile(SamplesFolder, files(i).name);
    
    %Le um arquivo
    [s, fs] = audioread(path);
    
    %Toca o arquivo
    %sound(s, fs);
    
    %Recupera um descritor, apenas para saber o tamanho máximo obtido
    centroid = spectralCentroid(s, fs, 'Window', hamming(1024), 'OverlapLength', 0, 'FFTLength', 1024);
    szFl(i-3) = size(centroid,1);
    %pause(5);
end