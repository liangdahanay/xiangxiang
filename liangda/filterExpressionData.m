function [file_name] = filterExpressionData(origin_file_path,sheet)
    [status, sheetlist]=xlsfinfo(origin_file_path);
    display(sheetlist);

    [num, txt, origin]=xlsread(origin_file_path, sheet);
    
    file_name=strcat('expr_',sheet,'.csv');
    delete(file_name);
    
    fid=fopen(file_name, 'w');
    for row_index = 2:size(origin, 1)
    
        row=origin(row_index,:);
        
        gene=row(3);
        gene=gene{1};
        gene=num2str(gene);
        gene=strrep(gene,',','_'); 
        
        value1=cell2mat(row(8));
        value2=cell2mat(row(9));
        
        if strcmp(gene,'-') || isempty(gene) || (value1==0 || value2==0)
            continue;
        end
       
        value1=log2(value1);
        value2=log2(value2);
        
        added = {gene, value1, value2};
        fprintf(fid, '%s,%d,%d\n', added{1,:});
    end
    fclose(fid);
end