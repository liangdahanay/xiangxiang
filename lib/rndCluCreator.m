function rndCluCreator(allgenes, nRuns, nGenes, threshDist, outputFile)


fid = fopen(outputFile,'wt');

fprintf(fid,'%s\t%s\t%s \t%s\n', 'run', 'n.clusts', 'n.tot.clust genes', 'n.genes per cluster');

for i=1:nRuns
    runTxt = sprintf('run: %d - ',i);
    
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


