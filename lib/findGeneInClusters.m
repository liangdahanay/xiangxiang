function index = findGeneInClusters(clusters, gname)
%
index = -1;
for i=1:numel(clusters)
    cl = clusters{i};
    for j=1:numel(cl.genes)
        g = cl.genes{j};
        if(strcmp(gname,g.geneID)==1)
            index = i;
            break;
        end
    end
    if(not(index==-1))
        break;
    end
end

