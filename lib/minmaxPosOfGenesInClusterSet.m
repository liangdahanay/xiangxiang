function [minpos,maxpos] = minmaxPosOfGenesInClusterSet(clusters)
%
%finds the min and max start positions of the genes in a set of cluster
%(which are supposed belonging to the same chromosome)

minpos = 0;
maxpos = 0;

[minpos,maxpos] = minmaxPosOfGenesInCluster(clusters{1});

for c=2:numel(clusters)
    cl = clusters{c};
    [minp,maxp] = minmaxPosOfGenesInCluster(cl);
    if(minp<minpos)
        minpos = minp;
    end
    if(maxp>maxpos)
        maxpos = maxp;
    end
end


