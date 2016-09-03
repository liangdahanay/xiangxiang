function groups = groupsInCluster(cluster)
%
groups = {};
count = 1;
for(i=1:numel(cluster.genes))
    grp = cluster.genes{i}.origin;
    found = 0;
    for(j=1:numel(groups))
        if(strcmp(grp,groups{j})==1)
            found = 1;
            break;
        end
    end
    if(found==0)
        groups{count} = grp;
        count = count+1;
    end
end
