disp('========================================');
disp(' geneFind  ');
disp('finds the cluster that contains a given gene');
disp('=========================================');

inputGeneName = input('enter name of the gene you are looking for: ','s');
inputClusterFile = input('enter name of the cluster file (clu) where the gene may be located: ','s');

disp('=================================');
disp('loading clusters from clu file');
disp('=================================');

origClusters = loadClustersFromCluFile(inputClusterFile);

disp('==============================================');
disp('searching for gene...');
disp('==============================================');

index = findGeneInClusters(origClusters, inputGeneName);

if(index==-1)
    disp(sprintf('the gene %s was NOT found in the clusters',inputGeneName));
else
    disp(sprintf('the gene %s is in cluster n.%d',inputGeneName, index));
end
    
clear index inputGeneName origClusters inputClusterFile
