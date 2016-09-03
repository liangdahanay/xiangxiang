function clusters = computeClusters(currClusters, genes,threshDist,outfile)
%
% computes positional clusters given an array of genes
% if currClusters is not empty, will add new genes to current ones and
% create new ones as well

disp('now clustering genes');

clusters = currClusters;

%for each gene: search in created clusters to find those belonging to 
%the same chromosome 
%amongst such clusters, choose the one with the closest gene, 
%if close enough, move there..

disp('running...');
for i=1:numel(genes)
   
    %disp(sprintf('%d',i));
    g = genes{i};
    
    %make sure the gene is not already in the clusters
    dupFound = 0;
    for w=1:numel(clusters)
        for ww=1:numel(clusters{w}.genes)
            if(strcmp(g.geneID,clusters{w}.genes{ww}.geneID)==1)
                disp(sprintf('duplicate copy of gene: %s not added to cluster',g.geneID));
                dupFound= 1;
                break;
            end
        end
        if(dupFound==1)
            break;
        end
    end
    if(dupFound==1)
        continue;
    end

    %disp('found a new gene');
    ch = g.chrom;
    
    %disp(sprintf('considering gene: %s',geneToString(g)));
    %pause;
    
    candidateClusters = []; %indices of clusters that may be ok
    candidateCount = 1;
    for c=1:numel(clusters)
        cl = clusters{c};
        if(strcmp(ch, cl.genes{1}.chrom)==1)
            %found a cluster that contains genes of the same chromosome
            candidateClusters(candidateCount) = c;
            candidateCount = candidateCount +1;
        end
    end
    %disp(sprintf('there are %d clusters on the same chromosome: %s',candidateCount-1,ch));
    %pause;
    
    %now I know that clusters may be ok for my gene, let's see what is the
    %closest to the gene
    
    if(numel(candidateClusters)==0)
        %create a new cluster, since none refers to the current chromosome
        %disp('no clusters on the chromosome, creating a new one');
        cluster = {};
        cluster.genes = {};
        cluster.genes{1} = g;
        clusters{numel(clusters)+1} = cluster;
        
        %disp(clusterToString(cluster));
        %pause;
        continue;
    end

    %if here, it means that there are clusters belonging to the same
    %chromosome
    
    %disp('here are the clusters:');
    %for f=1:numel(candidateClusters)
    %    disp(clusterToString(clusters{candidateClusters(f)}));
    %end
    %pause;

    %start by getting the first distance you can
    cl = clusters{candidateClusters(1)};
    tgene = cl.genes{1};
    dist = abs(g.start-tgene.start);
    %will memorize the indices of the closest gene, and the cluster it
    %belongs to
    bestClusterIX = candidateClusters(1);
    bestGeneIX = 1;
    
    %disp(sprintf('current best distance: %d',dist));
    
    for h=1:numel(candidateClusters)
        cl = clusters{candidateClusters(h)};
        %disp(sprintf('checking against cluster\n %s',clusterToString(cl)));
        %pause;
        for j=1:numel(cl.genes)
            tgene = cl.genes{j};
            tdist = abs(g.start - tgene.start);
            %disp(sprintf('distance of gene %d: %d',j,tdist));
            %pause;
            if(tdist<dist)
                bestClusterIX = candidateClusters(h);
                baseGeneIX = j;
                dist = tdist;
                %disp(sprintf('current best distance: %d',dist));
                %pause;
            end      
        end
    end
    %now we know what is the closest gene and what cluster it belongs too
    if(dist<=threshDist)
        %disp('the current best distance is below the threshold');
        %disp(sprintf('and belongs to cluster %d, gene %d',bestClusterIX,bestGeneIX));
        %pause;
        %distance less than threshold, add to identified cluster
        nGenes = numel(clusters{bestClusterIX}.genes);
        clusters{bestClusterIX}.genes{nGenes+1} = g;
        %disp(sprintf('updated cluster:\n %s',clusterToString(clusters{bestClusterIX})));
        %pause;
        continue;
    else
        %build a new cluster with the gene
        %disp('the current best distance is above the threshold');
        %disp('generating a new cluster');
        cluster = {};
        cluster.genes = {};
        cluster.genes{1} = g;
        clusters{numel(clusters)+1} = cluster;
        %disp(clusterToString(clusters{numel(clusters)}));
        %pause;
        
    end
end

%now I should eliminate clusters made of just one gene....
    
newClusters = {};
count = 1;
for i=1:numel(clusters)
    cl = clusters{i};
    if(numel(cl.genes)>1)
        newClusters{count} = clusters{i};
        count = count + 1;
    end
end

clusters = newClusters;

disp(sprintf('created %d clusters',numel(clusters)));

if(not(strcmp(outfile,'')))
    saveClustersToCluFile(clusters,outfile);
end


