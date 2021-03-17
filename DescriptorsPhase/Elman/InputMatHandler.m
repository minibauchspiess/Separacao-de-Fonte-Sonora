function [X, T] = InputMatHandler(samplesFolder, cbFolder, outCb, flFolder, outFl, winSize, seqSize, k)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
[CbMats, cbTargets] = FolderMatrix(fullfile(samplesFolder,cbFolder), outCb, winSize);
[FlMats, flTargets] = FolderMatrix(fullfile(samplesFolder,flFolder), outFl, winSize);

[X, T] = BuildKGroups({CbMats,FlMats}, {cbTargets,flTargets}, k, seqSize);
end

