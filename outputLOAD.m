function [output] = outputLOAD(Nz_kgf, filename_coords)
%OUPUTLOAD Summary of this function goes here
%   Detailed explanation goes here
height_load = height(Nz_kgf);
coords = readtable(filename_coords);
node = cellfun(@(x) sprintf('%-5s', x), repmat({'LOAD'}, height_load, 1), UniformOutput=false);
nodes = arrayfun(@(x) sprintf('%5d', x), coords{:, 1}, UniformOutput=false);
zeross = arrayfun(@(x) sprintf('%10.2f', x), zeros(height_load, 1), UniformOutput=false);
loads = arrayfun(@(x) sprintf('%10.2f', x), Nz_kgf(:), UniformOutput=false);
output = join(horzcat(node, nodes, zeross, zeross, loads), '');
end

