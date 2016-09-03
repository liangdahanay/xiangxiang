function clusters = clustersOnChromosome(origClusters, chromosome)
%
%extracts only the clusters belonging to a specific chromosome

clusters = {};
count = 1;

for i=1:numel(origClusters)
    cl = origClusters{i};
    for j=1:numel(cl.genes)
        g = cl.genes{j};
        if(strcmp(g.chrom,chromosome)==1)
            clusters{count} = cl;
            count = count + 1;
            break;
        else
            break;
        end
    end
end

        