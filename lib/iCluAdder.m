disp('========================================');
disp(' CLU Adder  ');
disp('augments a set of clusters by adding a new');
disp('set of genes');
disp('=========================================');

inputGeneFile = input('enter name of gdf input file (new genes): ','s');
inputClusterFile = input('enter name of clu input file (orig clusters): ','s');
outputFile = input('enter name of clu output file (updated clusters): ','s');

threshDist = str2num(input('enter value to use as minimum distance threshold for clustering (in bp) [20000]: ','s'));
if(isempty(threshDist))
    threshDist = 20000;
end


disp('=================================');
disp('loading genes from gdf file');
disp('=================================');

genes = loadGenesFromGdfFile(inputGeneFile);

disp('=================================');
disp('loading clusters from clu file');
disp('=================================');

origClusters = loadClustersFromCluFile(inputClusterFile);

disp('==============================================');
disp('run clustering and save to clu file');
disp('==============================================');

clusters= computeClusters(origClusters, genes,threshDist,outputFile);

clear clusters origClusters genes threshDist outputFile inputClusterFile inputGeneFile;