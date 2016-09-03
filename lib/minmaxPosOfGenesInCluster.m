function [minpos,maxpos] = minmaxPosOfGenesInCluster(cluster)
%
%finds the min and max start positions of the genes in a cluster

genes = cluster.genes;

[minpos,maxpos] = minmaxPosOfGenes(genes);


