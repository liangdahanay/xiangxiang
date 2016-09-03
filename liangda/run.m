clear
addpath(genpath('../lib'));

expressionFile = 'data/expr_cm_em.xlsx';
positionFile = 'data/position_cm_em.xls';
allGenesFile = 'result/allGenes.gdf';
duplicatesFile = 'result/duplicates.txt';
importAndMergeExcelFiles('ea3',expressionFile,positionFile,allGenesFile,duplicatesFile);

disp('loading complete gene set');
allGenes = loadGenesFromGdfFile(allGenesFile);

disp('fixing NaN values');
replacementVal = 0;
allGenes = fixNaN(allGenes,replacementVal,'result/fixedAllGenes.gdf');

% filter genes
disp('extracting exp1');
expIndices = [1];
expThresh = -10;
keepAbove = 1;
outFile = 'result/Exp1Genes.gdf';
exp1Genes = filterGenesOnExpressionValue(allGenes,expIndices, expThresh, keepAbove,outFile);

disp('extracting exp2');
expIndices = [2];
expThresh = -10;
keepAbove = 1;
outFile = 'result/Exp2Genes.gdf';
exp2Genes = filterGenesOnExpressionValue(allGenes,expIndices, expThresh, keepAbove,outFile);

% run positional clustering analysis on all extracted gene sets
currClusters = {};
threshDist =20000;

outFile = 'result/exp1Clusters.clu';
exp1Clusters = computeClusters(currClusters, exp1Genes,threshDist,outFile);
outFile = 'result/exp1Clusters-analysis.txt';
analyzeAllClusters(exp1Clusters, outFile);

outFile = 'result/exp2Clusters.clu';
exp2Clusters = computeClusters(currClusters, exp2Genes,threshDist,outFile);
outFile = 'result/exp2Clusters-analysis.txt';
analyzeAllClusters(exp2Clusters, outFile);

% figure
figure
hold on
showLabels = 1;
plotAllClusters(exp1Clusters, showLabels);

figure
hold on
clusterIndex = 8;
plotCluster(exp1Clusters, clusterIndex)

figure
hold on
clusterIndex = 45;
plotCluster(exp1Clusters, clusterIndex)
