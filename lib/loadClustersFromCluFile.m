function clusters = loadClustersFromCluFile(filename)

txt = sprintf('opening clu file: %s',filename);
disp(txt);

[fid, message] = fopen(filename, 'rt');

i=0;
found = 0;

%disp('parsing file')

%first line must contain the number of clusters

line = fgets(fid);
%disp(sprintf('processing line: %s',line));

if line==-1 
    error('unespected end of file');
    return
end

[token1,remainder] = strtok(line);
token2 = strtok(remainder);

nC = str2num(token2);

%txt = sprintf('the file contains %d clusters',nC);
%disp(txt);

clusters = {};
cluster.genes = {};
for i=1:nC
    %read the cluster number
    aline = fgets(fid);
   % disp(sprintf('processing line: %s',aline));
    if aline==-1 
        error('unexpected end of file while searching for the %d th cluster',i);
        return;
    end    
    %read the begin statement
    aline = fgets(fid);
    %disp(sprintf('processing line: %s',aline));
    if aline==-1 
        error('unexpected end of file while searching for the %d th cluster',i);
        return;
    end
    
    [token,remainder] = strtok(aline);
    if(strcmp(token,'beginCluster')==0)
        txt = sprintf('beginCluster statement not found while reading cluster n. %d',i);
        disp(txt);
        return;
    end
    doneCluster = 0;
    cluster.genes ={};
    count = 1;
    while(1)
        aline = fgets(fid);
        %disp(sprintf('processing line: %s',aline));
        if aline==-1 
            error('unespected end of file while processing the %d th cluster',i);
            return;
        end
        [token,remainder] = strtok(aline);
        if(strcmp(token,'endCluster')==1)
            doneCluster = 1;
            break
        end
        gene = geneFromString(aline);
        cluster.genes{count} = gene;
        count = count +1;  
    end
    %disp(sprintf('loaded cluster %d',i));
    %disp(clusterToString(cluster));
    %pause;
    clusters{i} = cluster;
end

