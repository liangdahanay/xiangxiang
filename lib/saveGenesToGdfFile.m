function saveGenesToGdfFile(gdata,filename)
%
txt = sprintf('saving gene data to: %s',filename);
disp(txt);

fid = fopen(filename,'wt');
nGenes = numel(gdata);

nExpr = numel(gdata{1}.exp);

fprintf(fid,'%s %d\n','nGenes',nGenes);
fprintf(fid,'%s %d\n','nExpressions',nExpr);

frm = '%s \t';
fprintf(fid,frm,'origin');
frm = '%s \t';
fprintf(fid, frm,'geneID');
frm = '%s \t';
fprintf(fid, frm,'chrom');
frm = '%s \t';
fprintf(fid, frm,'strand');
frm = '%s \t';
fprintf(fid, frm,'start');
frm = '%s \t';
fprintf(fid, frm,'end');
frm = '%s%d \t';
for(h=1:nExpr)
    fprintf(fid, frm,'exp',h);
end
fprintf(fid, '%s \n',' ');
% 
% 
% 
for i=1:nGenes
    line = geneToString(gdata{i});
    fprintf(fid, '%s\n',line);
    
    
end
fclose(fid);
