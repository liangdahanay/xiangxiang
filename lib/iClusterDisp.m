disp('========================================');
disp(' Cluster Disp  ');
disp('displays a cluster on screen as txt');
disp('=========================================');

inputClusterFile = input('enter name of the cluster file (clu) containing the cluster: ','s');
inputClusterIndex = str2num(input('enter index of cluster to display: ','s'));

disp('=================================');
disp('loading clusters from clu file');
disp('=================================');

origClusters = loadClustersFromCluFile(inputClusterFile);

disp('==============================================');
disp('displaying cluster...');
disp('==============================================');

clu = origClusters{inputClusterIndex};

disp(clusterToString(clu));

clear origClusters inputClusterFile inputClusterIndex clu;
