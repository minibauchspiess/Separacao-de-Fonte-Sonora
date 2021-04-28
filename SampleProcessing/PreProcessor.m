%Script responsavel por preprocessar (cortar os trechos com pouca presenca
%do sinal)todas as amostras de umas pasta e inserir o arquivo preprocessado
%na pasta destino. Cada corte eh apresentado em plot e perguntado se o
%corte esta aceitavel (caso contrario, o arquivo nao eh salvo)

origFolder = "../Samples/Original/harpa-ordinario";  %Pasta de arquivos originais
destFolder = "../Samples/Preprocessed/filtZhang/Harp-ord";  %Pasta para salvar arquivos de saida
files = dir(origFolder);    %Arquivos da pasta

%Percorre todos os arquivos, preprocessando um a um
j=1; %Contador de cortes nao aceitos
i=3; %Exclui '.','..'
while i <= size(files,1)
    %Monta o caminho ao arquivo, e o preprocessa
    filePath = fullfile(origFolder, files(i).name);
    [finalSound, origSound, fs, soundBegin] = ZhangFilter(filePath);
    
    %Com confirmacao de usuario, salva o arquivo final, ou o separa como
    %falha
    in = input("Arquivo conforme? ('s' ou 'n')\n", 's');
    if in == 's'
        %Determinando o nome e caminho para salvar o arquivo preprocessado
        [~, nameNoExt, ~] = fileparts(filePath); %Nome original sem extensao
        ppFileName = nameNoExt + ".wav"; %Adiciona extensao .wav
        ppFilePath = fullfile(destFolder, ppFileName);
        
        %Salva arquivo, com informacao do comeco em relacao ao original
        audiowrite(ppFilePath, finalSound, fs, 'Comment', num2str(soundBegin));
    elseif in == 'n'
       notAccepted(j) = ppFilePath;
       j = j+1;
       fprintf("Arquivo " + ppFileName + " nao aceito\n");
    %Avisa se tiver sido uma opcao invalida, e tenta novamente
    else
        fprintf("Insira uma alternativa valida\n");
        i=i-1;
    end
    
    i = i+1;    %Incrementa o indice do while
end

