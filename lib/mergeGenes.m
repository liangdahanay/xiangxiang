function genes = mergeGenes(gdata1,gdata2,filename)
%

genes = gdata1;

ng = numel(gdata2);

for i=1:ng
    g = gdata2{i};
    found = 0;
    for k=1:numel(genes)
        if(strcmp(genes{k}.geneID,g.geneID))
            found = 1;
            break;
        end
    end
    if(found==1)
        continue;
    end
    genes = [genes,g];
end


txt = sprintf('%d genes after merging',numel(genes));
disp(txt);
saveGenesToGdfFile(genes,filename);

    


