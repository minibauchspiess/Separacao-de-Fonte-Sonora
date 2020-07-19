function [ ] = ShowResults( V, WH, Basis, lines )
    %Função criada para mostrar cada uma das imagens da matriz de amostras,
    %da composição W*H e da matriz de base. lines é a quantidade de linhas
    %que cada imagem possui (para transformação entre vetor linha para
    %matriz da imagem)
    
    %Valor utilizado para controlar quantidade de imagens que são
    %apresentadas
    maxImgs = 20;
    
    %Recupera tamanho de V e de Basis, para informação de quantas imagens
    %recriar
    sz1 = size(V);
    sz2 = size(Basis);
    numCol = sz1(2)/lines;
    
    %Cria imagens a serem apresentadas com seus respectivos tamanhos (mas
    %ainda sem seus elementos corretos)
    %VImg = reshape(V, lines,[]);
    %WHImg = VImg;
    %BasisImg = reshape(Basis, lines,[]);
    
    VImg = [];
    WHImg = [];
    BasisImg = [];
    
    %Recria cada vetor linha como uma imagem da quantidade de linhas
    %especificada
    for i=1:min(sz1(1), maxImgs)
       %Intervalo reservado para a imagem
       %range = 1+(i-1)*(sz1(2)/lines) : i*(sz1(2)/lines);
       
       %Etapas de normalização para matriz W*H
       minWH = min(min(WH(i,:)));
       maxWH = max(max(WH(i,:) - minWH));
       normWH = (WH(i,:) - minWH) / maxWH;
       
       VImg = [VImg reshape(V(i,:), lines,[])];
       WHImg = [WHImg reshape(normWH, lines,[])];
    end
    for i=1:min(sz2(1), maxImgs)
       %Intervalo reservado para a imagem
       %range = 1+(i-1)*(sz2(2)/lines) : i*(sz2(2)/lines);
       
       %Etapas de normalização para matriz Basis
       minBasis = min(min(Basis(i,:)));
       maxBasis = max(max(Basis(i,:) - minBasis));
       normBasis = (Basis(i,:) - minBasis) / maxBasis;
       
       BasisImg = [BasisImg reshape(normBasis, lines,[])];
    end
    
    %Apresentando as imagens resultantes, tudo em uma só janela
    subplot(3,1,1),imshow(VImg(:,1:numCol * min(sz1(1), maxImgs) )),title('Amostras'); hold on
    subplot(3,1,2),imshow(WHImg(:,1:numCol * min(sz1(1), maxImgs) )),title('W*H'); hold on
    subplot(3,1,3),imshow(BasisImg(:,1:numCol * min(sz2(1), maxImgs) )),title('Base'); hold on
    
end

