function [minpos,maxpos] = minmaxPosOfGenes(genes)
%
%genes are assumed as belonging to the same chromosome.

minpos = -1;
maxpos = -1;

if(numel(genes)==0) 
    return;
end

minpos = genes{1}.start;
maxpos = genes{1}.start;

for i=1:numel(genes)
    g = genes{i};
    if(g.start<minpos) 
        minpos = g.start;
    end
    if(g.start>maxpos)
        maxpos = g.start;
    end
end


       
    
