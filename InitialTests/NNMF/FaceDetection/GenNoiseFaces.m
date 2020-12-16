%Programa que, a partir das imagens em grayscale da pasta "GrayOriginals",
%gera gera 10 imagens com ruído para cada imagem original, e as salva na
%pasta "GrayNoised"

%Cria a pasta "GrayNoised", caso ainda não tenha sido criada
if ~exist('GrayNoised', 'dir')
    mkdir GrayNoised
end



for i=1:10;
    %Le uma das imagens da pasta GrayOriginals
    fileOrig = strcat(num2str(i-1), '.jpg');
    img = imread(fullfile('GrayOriginals', fileOrig));
    
    for j=1:10;
        %Gera a imagem com ruído
        noisedResult = imnoise(img, 'gaussian', 0, 0.0002);
        
        %Nome que será salvo
        fileName = strcat(num2str(i-1), '_', num2str(j-1), '.jpg');
        fileName = fullfile('GrayNoised', fileName);
        
        %Salva imagem gerada na pasta 'GrayNoised'
        imwrite(noisedResult, fileName);
        
    end
end


