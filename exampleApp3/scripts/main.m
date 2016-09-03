clear

addpath(genpath('../../lib'));


%===================================================
% import excel files and generate original GDF file
%==================================================
expressionFile = '../data/expressions.xls';
positionFile = '../data/positions.xls';
allGenesFile = '../results/allGenes.gdf';
duplicatesFile = '../results/duplicates.txt';
importAndMergeExcelFiles('ea3',expressionFile,positionFile,allGenesFile,duplicatesFile);

disp('loading complete gene set');
allGenes = loadGenesFromGdfFile(allGenesFile);

%============================================
% fix NaN values
%=============================================
disp('fixing NaN values');
replacementVal = 0;
allGenes = fixNaN(allGenes,replacementVal,'../results/fixedAllGenes.gdf');

%============================================
% extract multiple gene data sets for males, females, adults, pupae and
% larvae, using filters on expression values
%==============================================
disp('extracting adult male genes');
expIndices = [5];
expThresh = 0.8;
keepAbove = 1;
outFile = '../results/adultMaleGenes.gdf';
adultMaleGenes = filterGenesOnExpressionValue(allGenes,expIndices, expThresh, keepAbove,outFile);

disp('extracting adult female genes');
expIndices = [5];
expThresh = -0.8;
keepAbove = 0;
outFile = '../results/adultFemaleGenes.gdf';
adultFemaleGenes = filterGenesOnExpressionValue(allGenes,expIndices, expThresh, keepAbove,outFile);

disp('merging adult genes');
outFile = '../results/adultGenes.gdf';
adultGenes = mergeGenes(adultMaleGenes,adultFemaleGenes,outFile);

disp('extracting pupae male genes');
expIndices = [4];
expThresh = 0.8;
keepAbove = 1;
outFile = '../results/pupaeMaleGenes.gdf';
pupaeMaleGenes = filterGenesOnExpressionValue(allGenes,expIndices, expThresh, keepAbove,outFile);

disp('extracting pupae female genes');
expIndices = [4];
expThresh = -0.8;
keepAbove = 0;
outFile = '../results/pupaeFemaleGenes.gdf';
pupaeFemaleGenes = filterGenesOnExpressionValue(allGenes,expIndices, expThresh, keepAbove,outFile);

disp('merging pupae genes');
outFile = '../results/pupaeGenes.gdf';
pupaeGenes = mergeGenes(pupaeMaleGenes,pupaeFemaleGenes,outFile);

disp('extracting larvae male genes');
expIndices = [1,2,3];
expThresh = 0.8;
keepAbove = 1;
outFile = '../results/larvaeMaleGenes.gdf';
larvaeMaleGenes = filterGenesOnExpressionValue(allGenes,expIndices, expThresh, keepAbove,outFile);

disp('extracting larvae female genes');
expIndices = [1,2,3];
expThresh = -0.8;
keepAbove = 0;
outFile = '../results/larvaeFemaleGenes.gdf';
larvaeFemaleGenes = filterGenesOnExpressionValue(allGenes,expIndices, expThresh, keepAbove,outFile);

disp('merging larvae genes');
outFile = '../results/larvaeGenes.gdf';
larvaeGenes = mergeGenes(larvaeMaleGenes,larvaeFemaleGenes,outFile);

%==============================================================
% run positional clustering analysis on all extracted gene sets
%==============================================================
currClusters = {};
threshDist =20000;

outFile = '../results/adultMaleClusters.clu';
adultMaleClusters = computeClusters(currClusters, adultMaleGenes,threshDist,outFile);
outFile = '../results/adultMaleClusters-analysis.txt';
analyzeAllClusters(adultMaleClusters, outFile);

outFile = '../results/adultFemaleClusters.clu';
adultFemaleClusters = computeClusters(currClusters, adultFemaleGenes,threshDist,outFile);
outFile = '../results/adultFemaleClusters-analysis.txt';
analyzeAllClusters(adultFemaleClusters, outFile);

outFile = '../results/pupaeMaleClusters.clu';
pupaeMaleClusters = computeClusters(currClusters, pupaeMaleGenes,threshDist,outFile);
outFile = '../results/pupaeMaleClusters-analysis.txt';
analyzeAllClusters(pupaeMaleClusters, outFile);

outFile = '../results/pupaeFemaleClusters.clu';
pupaeFemaleClusters = computeClusters(currClusters, pupaeFemaleGenes,threshDist,outFile);
outFile = '../results/pupaeFemaleClusters-analysis.txt';
analyzeAllClusters(pupaeFemaleClusters, outFile);

outFile = '../results/larvaeMaleClusters.clu';
larvaeMaleClusters = computeClusters(currClusters, larvaeMaleGenes,threshDist,outFile);
outFile = '../results/larvaeMaleClusters-analysis.txt';
analyzeAllClusters(larvaeMaleClusters, outFile);

outFile = '../results/larvaeFemaleClusters.clu';
larvaeFemaleClusters = computeClusters(currClusters, larvaeFemaleGenes,threshDist,outFile);
outFile = '../results/larvaeFemaleClusters-analysis.txt';
analyzeAllClusters(larvaeFemaleClusters, outFile);

%==================================================
% generate random clustering results for statistical
% assessment of clustering significance
%==================================================

nRuns = 20;


disp('loading gene set for randomized selection');
genesForRndFile = '../data/genesForRnd.gdf';

genesForRnd = loadGenesFromGdfFile(genesForRndFile);

nGenes = numel(adultMaleGenes);
outFile = '../results/adultRndClusters_forMales.txt';
rndCluCreator(genesForRnd, nRuns, nGenes, threshDist, outFile)

nGenes = numel(adultFemaleGenes);
outFile = '../results/adultRndClusters_forFemales.txt';
rndCluCreator(genesForRnd, nRuns, nGenes, threshDist, outFile)

nGenes = numel(pupaeMaleGenes);
outFile = '../results/pupaeRndClusters_forMales.txt';
rndCluCreator(genesForRnd, nRuns, nGenes, threshDist, outFile)

nGenes = numel(pupaeFemaleGenes);
outFile = '../results/pupaeRndClusters_forFemales.txt';
rndCluCreator(genesForRnd, nRuns, nGenes, threshDist, outFile)

nGenes = numel(larvaeMaleGenes);
outFile = '../results/larvaeRndClusters_forMales.txt';
rndCluCreator(genesForRnd, nRuns, nGenes, threshDist, outFile)

nGenes = numel(larvaeFemaleGenes);
outFile = '../results/larvaeRndClusters_forFemales.txt';
rndCluCreator(genesForRnd, nRuns, nGenes, threshDist, outFile)

%==========================================
% visualize all clusters from adult males
% and the contents of two specific clusters
%=========================================
figure
hold on
showLabels = 1;
plotAllClusters(adultMaleClusters, showLabels);

figure
hold on
clusterIndex = 8;
plotCluster(adultMaleClusters, clusterIndex)

figure
hold on
clusterIndex = 45;
plotCluster(adultMaleClusters, clusterIndex)




