function geneData = loadGenesFromGdfFile(filename)
%
%load gene data from a file created by the function: importAndMergeExcelFiles
%

%geneID 	chrom 	band 	strand 	start 	end 	exp1 	exp2 	exp3 	exp4 	exp5 
geneData= {};

gd.origin = '';
gd.geneID = '';
gd.chrom = '';
gd.strand = 0;
gd.start = 0;
gd.stop = 0;
gd.exp =[];


txt = sprintf('opening file: %s',filename);
disp(txt);

[fid, message] = fopen(filename, 'rt');

i=0;
found = 0;

%disp('parsing file')

%first line must contain the number of genes

line = fgets(fid);
if line==-1 
    error('unespected end of file');
    return
end

[token1,remainder] = strtok(line);
token2 = strtok(remainder);

nGenes = str2num(token2);

txt = sprintf('the file contains %d genes',nGenes);
disp(txt);

line = fgets(fid);
[token1,remainder] = strtok(line);
token2 = strtok(remainder);

nExpr = str2num(token2);

%txt = sprintf('each gene has %d expressions',nExpr);
%disp(txt);

%third line contains the headers, skip it
line = fgets(fid);

%origin geneID 	chrom 	band 	strand 	start 	end 	exp1 	exp2 ...

for h=1:nGenes

    line = fgets(fid);
    if line==-1 
	    error('unespected end of file');
        return
    end

    %txt = sprintf('line: %s',line);
    %disp(txt);
    %disp(line)
    gd = geneFromString(line);
    

    geneData{h} = gd;
    
end
