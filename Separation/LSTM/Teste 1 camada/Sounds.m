
for i=1:size(qtdNeurons,2)
    
    [~, saida] = predictAndUpdateState(netTrainedMixed{i}, (hp'+fh')/2);
    fprintf("Mixed com "+num2str(qtdNeurons(i))+" neuronios, entrando mix\n");
    
    sound(saida(1,:), fs);
    pause(size(saida, 2)/fs);
    sound(saida(2,:),fs);
    pause(size(saida, 2)/fs);
    
    again = input("Tocar novamente? (s ou n)\n", 's');
    while(again == 's')
        sound(saida(1,:), fs);
        pause(size(saida, 2)/fs);
        sound(saida(2,:),fs);
        pause(size(saida, 2)/fs);
        again = input("Tocar novamente? (s ou n)\n", 's');
    end
    
    %------
    [~, saida] = predictAndUpdateState(netTrainedMixed{i}, (hp')/2);
    fprintf("Mixed com "+num2str(qtdNeurons(i))+" neuronios, entrando hp\n");
    
    sound(saida(1,:), fs);
    pause(size(saida, 2)/fs);
    sound(saida(2,:),fs);
    pause(size(saida, 2)/fs);
    
    again = input("Tocar novamente? (s ou n)\n", 's');
    while(again == 's')
        sound(saida(1,:), fs);
        pause(size(saida, 2)/fs);
        sound(saida(2,:),fs);
        pause(size(saida, 2)/fs);
        again = input("Tocar novamente? (s ou n)\n", 's');
    end
    
    %------
    [~, saida] = predictAndUpdateState(netTrainedMixed{i}, (fh')/2);
    fprintf("Mixed com "+num2str(qtdNeurons(i))+" neuronios, entrando fh\n");
    
    sound(saida(1,:), fs);
    pause(size(saida, 2)/fs);
    sound(saida(2,:),fs);
    pause(size(saida, 2)/fs);
    
    again = input("Tocar novamente? (s ou n)\n", 's');
    while(again == 's')
        sound(saida(1,:), fs);
        pause(size(saida, 2)/fs);
        sound(saida(2,:),fs);
        pause(size(saida, 2)/fs);
        again = input("Tocar novamente? (s ou n)\n", 's');
    end
    
    %-------------------------------------------------------------
    [~, saida] = predictAndUpdateState(netTrainedPures{i}, (hp'+fh')/2);
    fprintf("Pures com "+num2str(qtdNeurons(i))+" neuronios, entrando mix\n");
    
    sound(saida(1,:), fs);
    pause(size(saida, 2)/fs);
    sound(saida(2,:),fs);
    pause(size(saida, 2)/fs);
    
    again = input("Tocar novamente? (s ou n)\n", 's');
    while(again == 's')
        sound(saida(1,:), fs);
        pause(size(saida, 2)/fs);
        sound(saida(2,:),fs);
        pause(size(saida, 2)/fs);
        again = input("Tocar novamente? (s ou n)\n", 's');
    end
    
    %------
    [~, saida] = predictAndUpdateState(netTrainedPures{i}, (hp')/2);
    fprintf("Pures com "+num2str(qtdNeurons(i))+" neuronios, entrando hp\n");
    
    sound(saida(1,:), fs);
    pause(size(saida, 2)/fs);
    sound(saida(2,:),fs);
    pause(size(saida, 2)/fs);
    
    again = input("Tocar novamente? (s ou n)\n", 's');
    while(again == 's')
        sound(saida(1,:), fs);
        pause(size(saida, 2)/fs);
        sound(saida(2,:),fs);
        pause(size(saida, 2)/fs);
        again = input("Tocar novamente? (s ou n)\n", 's');
    end
    
    %------
    [~, saida] = predictAndUpdateState(netTrainedPures{i}, (fh')/2);
    fprintf("Pures com "+num2str(qtdNeurons(i))+" neuronios, entrando fh\n");
    
    sound(saida(1,:), fs);
    pause(size(saida, 2)/fs);
    sound(saida(2,:),fs);
    pause(size(saida, 2)/fs);
    
    again = input("Tocar novamente? (s ou n)\n", 's');
    while(again == 's')
        sound(saida(1,:), fs);
        pause(size(saida, 2)/fs);
        sound(saida(2,:),fs);
        pause(size(saida, 2)/fs);
        again = input("Tocar novamente? (s ou n)\n", 's');
    end
    
    
    %-------------------------------------------------------------
    [~, saida] = predictAndUpdateState(netTrainedAll{i}, (hp'+fh')/2);
    fprintf("All com "+num2str(qtdNeurons(i))+" neuronios, entrando mix\n");
    
    sound(saida(1,:), fs);
    pause(size(saida, 2)/fs);
    sound(saida(2,:),fs);
    pause(size(saida, 2)/fs);
    
    again = input("Tocar novamente? (s ou n)\n", 's');
    while(again == 's')
        sound(saida(1,:), fs);
        pause(size(saida, 2)/fs);
        sound(saida(2,:),fs);
        pause(size(saida, 2)/fs);
        again = input("Tocar novamente? (s ou n)\n", 's');
    end
    
    %------
    [~, saida] = predictAndUpdateState(netTrainedAll{i}, (hp')/2);
    fprintf("All com "+num2str(qtdNeurons(i))+" neuronios, entrando hp\n");
    
    sound(saida(1,:), fs);
    pause(size(saida, 2)/fs);
    sound(saida(2,:),fs);
    pause(size(saida, 2)/fs);
    
    again = input("Tocar novamente? (s ou n)\n", 's');
    while(again == 's')
        sound(saida(1,:), fs);
        pause(size(saida, 2)/fs);
        sound(saida(2,:),fs);
        pause(size(saida, 2)/fs);
        again = input("Tocar novamente? (s ou n)\n", 's');
    end
    
    %------
    [~, saida] = predictAndUpdateState(netTrainedAll{i}, (fh')/2);
    fprintf("All com "+num2str(qtdNeurons(i))+" neuronios, entrando fh\n");
    
    sound(saida(1,:), fs);
    pause(size(saida, 2)/fs);
    sound(saida(2,:),fs);
    pause(size(saida, 2)/fs);
    
    again = input("Tocar novamente? (s ou n)\n", 's');
    while(again == 's')
        sound(saida(1,:), fs);
        pause(size(saida, 2)/fs);
        sound(saida(2,:),fs);
        pause(size(saida, 2)/fs);
        again = input("Tocar novamente? (s ou n)\n", 's');
    end
    
    
end