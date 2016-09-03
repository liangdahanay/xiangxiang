function genes = extractGenesFromClusters(clusters)

genes = {};
count = 1;
for i=1:numel(clusters)
    cl = clusters{i};
    gs = cl.genes;
    for j=1:numel(gs)
        genes{count} = gs{j};
        count = count +1;
    end
end

