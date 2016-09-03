function plotCluster(clusters, clusterIndex, expShowMode, magCoeff)
%
% expShowMode = 'circles', or 'diamonds'. Show mode for expression values
% 
% magCoeff = magnification coefficient for constrolling the size of 
% circles/diamonds based on expression level.


if(nargin<2)
    error('plotCluster needs at least two arguments');
end

if(nargin<3)
    expShowMode = 'circles';
    magCoeff = 250;
end

if(nargin<4)
    magCoeff = 250;
end

K = magCoeff;


cluster = clusters{clusterIndex};

if(numel(cluster.genes)<2)
    disp('cannot visualize a cluster with less than 2 genes');
    disp(clusterToString(cluster));
    return;
end

%see how many groups are represented in the cluster
groups = groupsInCluster(cluster);

%cols = autumn(numel(groups));
cols = zeros(8,3);
cols(1,:) = [1.0 1.0 0.0];
cols(2,:) = [1.0 0.0 0.0];
cols(3,:) = [1.0 0.0 1.0];
cols(4,:) = [0.0 1.0 1.0];
cols(5,:) = [1.0 1.0 1.0];
cols(6,:) = [1.0 0.5 0.0];
cols(7,:) = [1.0 0.5 0.7];
cols(8,:) = [0.0 0.0 0.5];

genes = cluster.genes;
g = genes{1};

chName = g.chrom;
%should make sure all genes have the same number of expressions...
nExpr = numel(g.exp);

[minPos,maxPos] = minmaxPosOfGenesInCluster(cluster);



%draw horizonal lines, one for each stage
%with length a little larger than minPos-maxPos

xMargin = (maxPos-minPos)/5.0;

lineXStart = minPos - xMargin;
lineXEnd = maxPos + xMargin;

%the vertical distance between two stages will be a fraction of line length
deltaY = (lineXEnd-lineXStart)/10.0;

lineYStart= 0.0;

for h=1:nExpr
    yPos = lineYStart + deltaY*(h-1);
    line([lineXStart,lineXEnd],[yPos, yPos]);
    stageTxt = sprintf('stage %d',h);
    text([lineXStart-xMargin],[yPos],stageTxt,'VerticalAlignment','Baseline');
end

%draw the genes according to expression and position
yLength = deltaY*(nExpr-1);
if(yLength==0.0)
    yLength=1.0;
end

yMargin = yLength/5.0;

for i=1:numel(genes)
    g = genes{i};
    %find out what group the gene belongs to
    grpIndex = 1;
    for t=1:numel(groups)
        if(strcmp(g.origin,groups{t})==1)
            grpIndex = t;
        end
    end
    %invert the index as I want the colors backwards
    grpIndex = numel(groups)-grpIndex+1;
    %plot gene line and name
    gName = g.geneID;
    xPos = g.start;
    yStart = lineYStart-yMargin;
    yEnd = lineYStart+yLength+yMargin;
    line([xPos,xPos],[yStart,yEnd],'LineStyle','--','Color','g','LineWidth',0.5);
    text([xPos],[yEnd+yMargin],gName,'Rotation',-90,'HorizontalAlignment','Left','VerticalAlignment','Baseline'); %,'Color',cols(grpIndex,:));
    %plot gene start point
    startText = num2str(xPos/1000);
    text([xPos],[yStart-yMargin],startText,'Rotation',-90,'HorizontalAlignment','Center','VerticalAlignment','Baseline');
    %plot expressions
    for j=1:numel(g.exp)
        expr = g.exp(j);
        exprTxt = num2str(expr);        
        xPos = g.start; % + xMargin/10.0;
        yPos = lineYStart+deltaY*(j-1); % + yMargin/20.0;
        if(expr==0.0)
            expr=0.0001;
        end
        if(isnan(expr))
            expr = 0.0001;
        end
        if(expr<0.0)
            disp('warning: negative expressions are visualized as positive (abs values)');
            expr = abs(expr);
        end
        hold on;
        
        if(strcmp(expShowMode,'circles'))
            %===========================
            % VARIANT 1: PLOT AS CIRCLES
            %===========================
            %the following line plots the marker as a circle with diameter
            %dependent on expression (K*expr)
            rectangle('Position',[xPos-K*expr,yPos-K*expr, 2*K*expr, 2*K*expr],'Curvature',[1,1],'FaceColor',cols(grpIndex,:));
            %plot([xPos],[yPos],'-or','MarkerSize',K*expr,'MarkerFaceColor',cols(grpIndex,:));
        else
            if(strcmp(expShowMode,'diamonds'))
                %============================
                % VARIANT 2: PLOT AS DIAMONDS
                %============================
                %             y+2.5*exp
                %                +
                %              /   \
                % x-2.5*exp   +  +  +  x+2.5*exp
                %              \   /
                %                +
                %             y-2.5*exp
                
                patch([xPos-K*expr, xPos, xPos+K*expr, xPos],[yPos,yPos+K*expr,yPos,yPos-K*expr], cols(grpIndex,:));
            else
                error('expShowMode value not recognized');
            end
        end
        
        
        text([xPos+xMargin/10.0],[yPos+yMargin/10.0],exprTxt,'VerticalAlignment','Baseline'); %,'Color',cols(grpIndex,:));
        
    end
        
end
 
axis([lineXStart-2*xMargin lineXEnd+2*xMargin yStart-2*yMargin yEnd + 2*yMargin]);
%axis equal;
%do now draw axes tickmarks
set(gca,'YTickLabel',{}) 
set(gca,'XTickLabel',{}) 
set(get(gca,'XLabel'),'String','Position on chromosome (kbp)')
set(get(gca,'YLabel'),'String','stage')

txt = sprintf('cluster %d on chromosome %s',clusterIndex,chName);
title(txt);


