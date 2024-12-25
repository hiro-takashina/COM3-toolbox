function modifyC(inputName, outputName)
%MODIFYC Summary of this function goes here
% this function is used to modify input file used in COM3. When there is
% rebar in designated direction, tension softening factor is automatically
% modified as 0.4

%   Detailed explanation goes here
    if nargin < 2
        outputName = 'modified.dat';
    elseif nargin < 1
        inputName = 'input.dat';
    end
    data = readlines(inputName);
    idx_elem = find(startsWith(data, 'ELEM'));
    idx_elem_dif = idx_elem(2:end) - idx_elem(1:end-1);
    
    % elem con
    idx_con = idx_elem(idx_elem_dif == 5);

    formatSpec_elem3 = '%10f%10f%10f%10f%10f%10f%10f%10f%10f%10f%10f%10f%10f';
    
    cell_elem3_1 = arrayfun(@(x) textscan(x, formatSpec_elem3), data(idx_con + 2), 'UniformOutput', false);
    cell_elem3_2 = arrayfun(@(x) textscan(x, formatSpec_elem3), data(idx_con + 3), 'UniformOutput', false);
    cell_elem3_3 = arrayfun(@(x) textscan(x, formatSpec_elem3), data(idx_con + 4), 'UniformOutput', false);
    
    % 更新したデータを計算
    result1 = vertcat(cellfun(@(x) cell2mat(x), cell_elem3_1, 'UniformOutput', false));
    result1 = vertcat(result1{:});
    result2 = vertcat(cellfun(@(x) cell2mat(x), cell_elem3_2, 'UniformOutput', false));
    result2 = vertcat(result2{:});
    result3 = vertcat(cellfun(@(x) cell2mat(x), cell_elem3_3, 'UniformOutput', false));
    result3 = vertcat(result3{:});
    
    % 条件に基づいて値を修正
    idx_elem1_r = result1(:, 6) ~= 0;
    result1(idx_elem1_r, 8) = 0.4;
    
    idx_elem2_r = result2(:, 6) ~= 0;
    result2(idx_elem2_r, 8) = 0.4;
    
    idx_elem3_r = result3(:, 6) ~= 0;
    result3(idx_elem3_r, 8) = 0.4;
    
    % 結果を元のデータに戻す

    formatSpec_elem3_updated = '%10.1f%10.1f%10.1f%10.1f%10.1f%10.3f%10.3f%10.3f%10.3f%10.3f%10.3f%10.1f%10.3f';
    data(idx_con + 2) = cellfun(@(x) sprintf(formatSpec_elem3_updated, x), num2cell(result1, 2), 'UniformOutput', false);
    data(idx_con + 3) = cellfun(@(x) sprintf(formatSpec_elem3_updated, x), num2cell(result2, 2), 'UniformOutput', false);
    data(idx_con + 4) = cellfun(@(x) sprintf(formatSpec_elem3_updated, x), num2cell(result3, 2), 'UniformOutput', false);
    
    % バッチでファイルに書き込む
    tic
    fid = fopen(outputName, 'wt');
    fprintf(fid, '%s\n', data{:});  % 一度に全てを書き込む
    fclose(fid);
    toc
    
    disp('--- tension softening factor is successfully modified ---')
end

