i=1;
j=1;
while i<=10
    fprintf("Estou na iteracao " + num2str(i)+"\n");
    in = input("Repetir? ", 's');
    if in == 's'
        fprintf("Repetindo entao\n");
        i = i-1;
        notAccepted(j) = "nao aceito em " + i;
        j = j+1;
    end
    i=i+1;
end