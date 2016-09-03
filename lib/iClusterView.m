disp('========================================');
disp(' Cluster View  ');
disp('visualize a cluster in a figure');
disp('=========================================');

inputClusterFile = input('enter name of the cluster file (clu) containing the cluster: ','s');
inputClusterIndex = str2num(input('enter index of cluster to display: ','s'));

expShowMode = input('enter expression visualization mode (circles, or diamonds): ','s');

magCoeff = str2num(input('enter magnification coefficient for drawing expressions: ','s'));


disp('=================================');
disp('loading clusters from clu file');
disp('=================================');

origClusters = loadClustersFromCluFile(inputClusterFile);

disp('==============================================');
disp('visualizing cluster...');
disp('==============================================');

figure;

plotCluster(origClusters,inputClusterIndex, expShowMode, magCoeff);


clear origClusters inputClusterFile inputClusterIndex;
