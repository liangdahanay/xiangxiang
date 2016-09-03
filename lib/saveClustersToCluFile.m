function saveClustersToCluFile(clusters, filename)

txt = sprintf('saving clusters to: %s',filename);
disp(txt);

fid = fopen(filename,'wt');
nClusters = numel(clusters);

fprintf(fid,'%s %d\n','nClusters',nClusters);

for i=1:nClusters
    cluster= clusters{i};
    fprintf(fid,'%d\n',i);
    txt = clusterToString(cluster);
    fprintf(fid,'%s \n',txt);
end
fclose(fid);
