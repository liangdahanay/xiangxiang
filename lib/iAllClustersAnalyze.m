disp('========================================');
disp(' All Clusters Analyze  ');
disp('computes simple analyses on a set of clusters');
disp('=========================================');

inputClusterFile = input('enter name of the cluster file (clu) containing the clusters: ','s');

disp('=================================');
disp('loading clusters from clu file');
disp('=================================');

origClusters = loadClustersFromCluFile(inputClusterFile);

outputAnalysisFile = input('enter name of the file containing analysis results (txt): ','s');

disp('==============================================');
disp('analyzing and writing results to file ...');
disp('==============================================');


analyzeAllClusters(origClusters,outputAnalysisFile);


clear origClusters inputClusterFile outputAnalysisFile;
