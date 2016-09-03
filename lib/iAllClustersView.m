disp('========================================');
disp(' All Clusters View  ');
disp('visualize all the clusters in a figure');
disp('=========================================');

inputClusterFile = input('enter name of the cluster file (clu) containing the clusters: ','s');

disp('=================================');
disp('loading clusters from clu file');
disp('=================================');

origClusters = loadClustersFromCluFile(inputClusterFile);



showLabels = input('enter 1 to display labels in the plot, 0 otherwise: ');


disp('==============================================');
disp('visualizing clusters...');
disp('==============================================');




figure;

plotAllClusters(origClusters,showLabels);


clear origClusters inputClusterFile;
