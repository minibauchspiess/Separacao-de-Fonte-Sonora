function [ vector, smallGray ] = LoadImg2Vector( imgName, newSize )
    %Esta função carrega imagem especificada por imgName, transforma-a para
    %grayscale, altera seu tamanho para o especificado em newSize, e
    %transforma a imagem resultante em um vetor linha. Esse vetor linha é
    %um retorno, junto com a imagem menor em grayscale (apenas para debug).
    
    img = imread(imgName);                  %Carrega imagem para img
    gray = rgb2gray(img);                   %Transforma img para tons de cinza
    smallGray = imresize(gray, newSize);    %Altera tamanho para o especificado em newSize
    vector = reshape(smallGray, 1,[]);      %Transforma imagem resultante em um vetor linha
end

