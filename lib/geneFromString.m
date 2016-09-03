function gene = geneFromString(string)

[token,remainder] = strtok(string);    
gene.origin = token;
[token,remainder] = strtok(remainder);    
gene.geneID = token;
[token,remainder] = strtok(remainder);
gene.chrom = token;
[token,remainder] = strtok(remainder);
gene.strand = str2num(token);
[token,remainder] = strtok(remainder);
gene.start = str2num(token);
[token,remainder] = strtok(remainder);
gene.stop = str2num(token);
gene.exp = [];
count = 1;
while(1)
    [token,remainder] = strtok(remainder);
    if(strcmp(token,'')==true) 
        break
    end
    gene.exp(count) = str2num(token);
    count = count +1;
end

