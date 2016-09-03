function analyzeAllClusters(clu, outputFile)
%
%
% c = clu{i}   :ith cluster (struct)
%
% cg = c.genes  : array of genes in the cluster
%
% cg1 = c.genes(1)   : 1st gene in the array of genes in the cluster
%                     : the gens is a struct (origin, geneID, chrom, etc.)
                     
%=================
% analyze cluster numerosity
%=================

binValues = [];  %this will contain the number of genes
binNumerosities = []; %this will contain how many clusters 
                      %have that number of genes



for cix=1:numel(clu)
    c = clu{cix}; %current cluster
    ngenes = numel(c.genes);
    
    %find the bin assigned to ngenes, or create a new one
    binIX = -1;
    for k=1:numel(binValues)
        if(binValues(k)==ngenes)
            binIX=k;
            break;
        end
    end
    if(binIX<0)
        binIX = numel(binValues)+1;
        binValues(binIX) = ngenes;
        binNumerosities(binIX) = 0;
    end

    %create the cluster count for that bin
    binNumerosities(binIX) = binNumerosities(binIX) + 1;
end

%write results to a txt file

fid = fopen(outputFile,'wt');

fprintf(fid,'%s\t%s\n', 'n.genes', 'n.clusters');

for i=1:numel(binValues)
    fprintf(fid,'%d\t%d\n',binValues(i),binNumerosities(i));
end
fclose(fid);



    
    
    
    

