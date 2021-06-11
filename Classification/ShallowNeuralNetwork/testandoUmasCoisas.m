%{
error = [];

outCb = [0 1];
outFl = [1 0];
target = [1 0; 0 1; 1 0];
test = [0.3 0.9; 0.88 0; 1 0.45];


%for i=1:size(target, 1)
    if isequal(target(1,:), outCb)
        name
    end
%end
%}
total = conf{1};
for i = 2:10
    total = total + conf{i};
end
