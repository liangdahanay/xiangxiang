disp('========================================');
disp('Random cluster Creator  ');
disp('creates clusters from random genes selected from a GDF file')
disp('It does it N times, and in the end it stores only selected');
disp('information to a txt file');

disp('=========================================');

inputFile = input('enter name of gdf input file: ','s');
outputFile = input('enter name of output file [rndClustResults.txt]: ','s');
if(strcmp(outputFile,''))
    outputFile = 'rndClustResults.txt';
end

threshDist = str2num(input('enter value to use as minimum distance threshold for clustering (in bp) [20000]: ','s'));
if(isempty(threshDist))
    threshDist = 20000;
end

nGenes = str2num(input('how many genes to extract random from GDF file at each run? [100]: ','s'));
if(isempty(nGenes))
    nGenes = 100;
end

nRuns = str2num(input('how many times you want random clustering to be run? [9999]: ','s'));
if(isempty(nRuns))
    nRuns = 9999;
end

fid = fopen(outputFile,'wt');

fprintf(fid,'%s\t%s\t%s \t%s\n', 'run', 'n.clusts', 'n.tot.clust genes', 'n.genes per cluster');

for i=1:nRuns
    runTxt = sprintf('run: %d - ',i);
    
    %txt = sprintf('sel %d rnd genes',nGenes);
    %disp(strcat(runTxt, txt));
    allgenes = loadGenesFromGdfFile(inputFile);
    genes = extractRndGenes(allgenes,nGenes);
    
    %disp(strcat(runTxt,'computing clusters'));
    currClusters = {};
    clusters = computeClusters(currClusters, genes,threshDist,'');
 
    txt = sprintf('generated %d clusters',numel(clusters));
    disp(strcat(runTxt, txt));
    
    fprintf(fid,'%d\t%d\t\t',i,numel(clusters));
    
    %write the total number of clustered genes
    nTotCluGenes = 0;
    for j=1:numel(clusters)
        nTotCluGenes = nTotCluGenes + numel(clusters{j}.genes);
    end
    fprintf(fid,'%d\t',nTotCluGenes);
   
    %write to file the number of genes contained in each cluster
    for j=1:numel(clusters)
        fprintf(fid,'%d ', numel(clusters{j}.genes));
        nTotCluGenes = nTotCluGenes + numel(clusters{j}.genes);
    end

    
    fprintf(fid,'\n');
end

fclose(fid);

clear fid runTxt txt nRuns nGenes currClusters clusters genes threshDist outputFile inputFile;

