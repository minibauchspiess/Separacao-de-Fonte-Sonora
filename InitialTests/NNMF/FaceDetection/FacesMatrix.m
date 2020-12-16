function [ V, sm ] = FacesMatrix( folder, imgSize )
    %Essa função carrega todas as imagens (.jpg) da pasta especificada
    %(folder) em uma matriz (V), sendo que cada imagem é um vetor linha
    %nessa matriz, e cada pixel, um elemento neste vetor. imgSize indica as
    %dimensões desejadas das imagens

    
    %Lista todos os arquivos com extensão .jpg dentro da pasta
    %especificada, 
    imgNames = dir(fullfile(folder,'*.jpg'));
    imgNames = {imgNames.name};

    %Carrega cada imagem da pasta, transforma-a em um vetor linha, e a
    %adiciona à matriz final. sm é um vetor de célular para debug, com as
    %imagens adicionadas à matriz
    sz = size(imgNames);
    V = [];
    for i = 1:sz(2)
        %Se imagem estiver colorida e fora do tamanho requerido, faz as
        %transformações necessarias ao vetor
        channels = size(imgNames(i));
        channels = size(channels);
        if channels == 3;
            [v,sm{i}] = LoadImg2Vector(fullfile(folder, char(imgNames(i)) ), imgSize);
            V = [V ; v];
        else
            sm{i} = imread(fullfile(folder, char(imgNames(i))) );
            v = reshape(sm{i}, 1, []);
            V = [V ; v];
        end
    end
    
    %Como nnmf não aceita valores inteiros, valores aqui são transformados
    %para double, e divididos por 255 para manter a escala de 0 a 1 (em vez
    %de 0 a 255)
    V = double(V)/255;

end

