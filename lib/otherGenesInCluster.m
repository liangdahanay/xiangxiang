function genes = otherGenesInCluster(clusters, geneID)

%first, find the index of the cluster containing the gene identified by
%geneID

cluIndex = findGeneInClusters(clusters,geneID);
if(cluIndex==-1)
    genes ={};
    return;
end

clu = clusters{cluIndex};

genes = {};
for(i=1:numel(clu.genes))
	if(strcmp(clu.genes{i}.geneID,geneID))
        continue;
	end
	genes{end+1} = clu.genes{i};
end


