disp('========================================');
disp(' CLU to GDF  ');
disp('extracts genes from clu clusters and saves');
disp('them to a single gdf file');
disp('=========================================');

inputClusterFile = input('enter name of clu input file (clusters): ','s');
outputFile = input('enter name of gdf output file (genes): ','s');




disp('=================================');
disp('loading clusters from clu file');
disp('=================================');

clus = loadClustersFromCluFile(inputClusterFile);

disp('==============================================');
disp('extracting genes and saving to gdf file');
disp('==============================================');

genes = extractGenesFromClusters(clus);

saveGenesToGdfFile(genes, outputFile);

clear clus genes outputFile inputClusterFile;
