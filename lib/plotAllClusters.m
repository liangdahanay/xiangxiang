function plotAllClusters(clusters, showLabels)

%============================
% find all the chromosomes
%============================

%extract all genes form the clusters
allgenes = extractGenesFromClusters(clusters);
%find all the chromosomes represented in the genes
chromosomes = {};
count = 1;
for i=1:numel(allgenes)
    g = allgenes{i};
    found = 0;
    for h=1:numel(chromosomes)
        if(strcmp(chromosomes{h},g.chrom)==1)
            found = 1;
            break;
        end
    end
    if(found==0)
        chromosomes{count} = g.chrom;
        count = count + 1;
    end
end


disp('chromosome names:');
disp(chromosomes);
disp('rendering in progress....');
%======================================
% find chromosome lenghts
% (bounded by gene positions)
%======================================

chGenes = {}; %genes belonging to each chromosome
allChGenes = {}; %collector for chGenes

count = 1;
for i=1:numel(chromosomes)
    chGenes = genesOnChromosome(allgenes,chromosomes{i});
    allChGenes{count} = chGenes;
    if(numel(chGenes)==0)
        disp('error - no genes on chromosome where clustering was ok!')
        pause;
    end
    count = count +1;
end

minPos = [];
maxPos = [];
count = 1;
for(ch=1:numel(chromosomes))
    genes = allChGenes{ch};
    %disp(sprintf('ch: %s contains %d genes',chromosomes{ch},numel(genes)));
    [minp, maxp] = minmaxPosOfGenes(genes);
    if((minp==-1)||(maxp==-1))
        disp('error in computing boundaries of genes on chromosome');
        pause;
    end
    minPos(count) = minp;
    maxPos(count) = maxp;
    count = count + 1;
end

disp('regions covered by clustered genes on each chromosome:');
for i=1:numel(chromosomes)
    txt= sprintf('%s: %d - %d (length: %d)',chromosomes{i},minPos(i),maxPos(i),maxPos(i)-minPos(i));
    disp(txt);
end
%pause;
maxXLen = max(maxPos)-min(minPos);
xMargin = maxXLen/10.0;
%the vertical distance between two stages will be a fraction of line length
deltaY = (maxXLen)/40.0;
yStart= 0.0;
yEnd = deltaY * (numel(chromosomes)-1);
yMargin = deltaY*(numel(chromosomes)-1)/10.0;


%======================================
% draw chromosomes
%======================================


for h=1:numel(chromosomes)
    xStart = 0.0;
    chLen = maxPos(h)-minPos(h);
    xStop = xStart+chLen;
    yPos = yStart + deltaY*(h-1);
    line([xStart-xMargin,xStop+xMargin],[yPos, yPos]);
    text([xStart-2*xMargin],[yPos],chromosomes{h}, 'Rotation', -90);
end

        
%=====================================
% draw clusters
%=====================================
for i=1:numel(clusters)
    c = clusters{i};
    %disp(sprintf('cluster: %s',clusterToString(c)));
 
    ch = c.genes{1}.chrom;
    %disp(sprintf('target chrom: %s',ch));
    %pause;
    %find chromosome index
    chix = 10;
    for j=1:numel(chromosomes)
        if(strcmp(ch,chromosomes{j})==1)
            chix = j;
            break;
        end
    end
    %disp(chromosomes);
    %disp(sprintf('chrom index: %d',chix));
    %pause;

    y = yStart + deltaY*(chix-1);
    [xmin,xmax]= minmaxPosOfGenesInCluster(c);
    %disp(sprintf('cluster to draw: \n %s',clusterToString(c)));
    %disp(sprintf('xmin: %d',xmin));
    x = xmin - minPos(chix); %cause the line plot was shifted to zero..
    %disp(sprintf('normalized xmin: %d',x));
    %pause;
	if(showLabels==1)
		cname = num2str(i);
		text([x],[y+yMargin/5.0],cname, 'Rotation', -90, 'HorizontalAlignment','Right');
		cpos = num2str(xmin/1000);
		text([x],[y-yMargin/5.0],cpos, 'Rotation', -90,'HorizontalAlignment', 'Left');
	end
    line([x x],[y-yMargin/5.0 y+yMargin/5.0],'Color',[0.5,0.5,0.5]);
    hold on;
    plot([x],[y],'-o','MarkerSize',2*numel(c.genes),'MarkerFaceColor',[0.7,0.3,0.0],'MarkerEdgeColor',[0.0,0.0,0.0]);
    
    
end
%======================================
% draw axes
%======================================

axis([0.0-3*xMargin (max(maxPos)-min(minPos))+3*xMargin yStart-2*yMargin yEnd + 2*yMargin]);
% %axis equal;
% %do now draw axes tickmarks
set(gca,'YTickLabel',{}) 
set(gca,'XTickLabel',{}) 
set(get(gca,'XLabel'),'String','position on chromosome (kbp)')
set(get(gca,'YLabel'),'String','chromosomes')




txt = sprintf('all clusters');
title(txt);


