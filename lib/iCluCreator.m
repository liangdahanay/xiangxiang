disp('========================================');
disp(' CLU Creator  ');
disp('creates a clu file (cluster file) ');
disp('from a given gdf file');
disp('=========================================');

inputFile = input('enter name of gdf input file: ','s');
outputFile = input('enter name of clu output file: ','s');

threshDist = str2num(input('enter value to use as minimum distance threshold for clustering (in bp) [20000]: ','s'));
if(isempty(threshDist))
    threshDist = 20000;
end


disp('=================================');
disp('loading genes from gdf file');
disp('=================================');

genes = loadGenesFromGdfFile(inputFile);

disp('==============================================');
disp('run clustering and save to clu file');
disp('==============================================');

currClusters = {};
clusters= computeClusters(currClusters, genes,threshDist,outputFile);

clear currClusters clusters genes threshDist outputFile inputFile;
