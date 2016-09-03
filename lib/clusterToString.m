function string = clusterToString(cluster)
%
%a cluster is simply an array of genes,each defined by a gene data
%structure

string = sprintf('%s','beginCluster');

for(i=1:numel(cluster.genes))
    txt = geneToString(cluster.genes{i});
    string = sprintf('%s\n%s',string, txt);
end

string = sprintf('%s\n%s', string, 'endCluster');

