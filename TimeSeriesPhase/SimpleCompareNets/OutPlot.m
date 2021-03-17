function [y1, y2] = OutPlot(saidas)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

mat = cell2mat(saidas);
y1 = mat(1,:);
y2 = mat(2,:);

plot(y1);
hold on
plot(y2);
hold off
end

