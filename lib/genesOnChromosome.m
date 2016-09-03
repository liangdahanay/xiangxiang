function genes = genesOnChromosome(origGenes, chromosome)
%
%extracts only the genes belonging to a specific chromosome

genes = {};
count = 1;

for i=1:numel(origGenes)
    g = origGenes{i};
    if(strcmp(g.chrom,chromosome)==1)
        genes{count} = g;
        count = count + 1;
    end
end

        