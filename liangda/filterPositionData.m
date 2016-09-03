function [file_name] = filterPositionData(origin_file_path, sheet)
    [status, sheetlist]=xlsfinfo(origin_file_path);
    display(sheetlist);
    [num, txt, origin]=xlsread(origin_file_path, sheet);

    file_name=strcat('position_',sheet,'.csv');
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
        
        if strcmp(gene,'-') || (value1==0 && value2==0)
            continue;
        end
        
        locus=row(4);
        locus=locus{1};
        disp(locus);
        
        splitedCellArray=strsplit(locus, ':');
        
        chrom=splitedCellArray(1);
        chrom=chrom{1};
        
        remainCellArray=splitedCellArray(2);
        remainStr=remainCellArray{1};
        
        splitedCellArray=strsplit(remainStr,'-');

        startTag=splitedCellArray(1);
        endTag=splitedCellArray(2);
        
        startTag=startTag{1};
        endTag=endTag{1};
        
        added={gene, chrom, startTag, endTag, 1};
        disp(added);
        
        fprintf(fid, '%s,%s,%s,%s,%d\n', added{1,:});
    end
    fclose(fid);
end