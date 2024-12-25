function xlsx2com3(inputName, outputName)
    if nargin < 2
        outputName = 'input.dat';
    end
    data_table = readtable(inputName);
    data = table2cell(data_table);
    
    
    data = cellfun(@(x) {num2str(x)}, data);
    alignRight = @(str) sprintf('%10s', str);
    data = cellfun(@(x) {alignRight(x)}, data);
    joinedData = cellfun(@(v)join(v,''),num2cell(data,2));
    
    writecell(joinedData, outputName, QuoteStrings='none')
    disp('--- file conversion is finished ---')
end

