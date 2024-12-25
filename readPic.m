function data = readPic(inputFileName)
%READPIC Summary of this function goes here
% この関数はCOM3で生成されるピックファイル(.pic)を読み込む関数です
% inputFileNameのデフォルト値


%   Detailed explanation goes here

    if nargin < 1
        inputFileName = 'input-MECH.pic';
    end

    data = readtable(inputFileName,"FileType","text");
    firstLine = table2cell(data(1, :));
    idxStr = cellfun(@ischar,firstLine);
    dataContent = firstLine(idxStr);
    dataContent = cellfun(@(x) textscan(x, '%f%c-%c%c%c'),  dataContent, 'UniformOutput',false); 
    

    nodeNum = cellfun(@(x) num2str(x{1}), dataContent, 'UniformOutput', false);
    nodeDir = cellfun(@(x) x{2}, dataContent, 'UniformOutput', false);
    
    % displacement value check
    dispIO = logical(cell2mat(cellfun(@(x) str2num(x{3}), dataContent, 'UniformOutput', false)));
    nodeDisp = cell(1, length(nodeNum));
    nodeDisp(dispIO) = strcat(((nodeNum(dispIO))), repmat({'-disp'}, 1, sum(dispIO)));
    
    % reaction value check
    reacIO = logical(cell2mat(cellfun(@(x) str2num(x{4}), dataContent, 'UniformOutput', false)));
    nodeReac = cell(1, length(nodeNum));
    nodeReac(reacIO) = strcat(((nodeNum(reacIO))), repmat({'-reac'}, 1, sum(reacIO)));
    
    % acceralation value check
    acceIO = logical(cell2mat(cellfun(@(x) str2num(x{5}), dataContent, 'UniformOutput', false)));
    nodeAcce = cell(1, length(nodeNum));
    nodeAcce(acceIO) = strcat(((nodeNum(acceIO))), repmat({'-acce'}, 1, sum(acceIO)));
    
    % setting VariableNames
    total_array = [nodeNum; nodeDisp; nodeReac; nodeAcce];
    total_array = reshape(total_array, [], 1);
    varNames = ['time'; total_array(~cellfun('isempty', total_array)); 'T-REAC'; 'X'; 'Y'; 'Z'];
    
    data.Properties.VariableNames = varNames;
end

