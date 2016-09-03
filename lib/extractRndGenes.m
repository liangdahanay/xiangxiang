function newgdata = extractRndGenes(gdata,nGenes);

indices = randperm(numel(gdata));

newgdata = {};

%disp('rnd indices:');
%disp(indices);
count = 1;
for i=1:nGenes
    gd = gdata{indices(i)};
    newgdata{count} = gd;
    count = count +1;
end
%txt = sprintf('%d genes extracted',count-1);
%disp(txt);
    


