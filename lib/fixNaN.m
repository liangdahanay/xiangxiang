function newdata = fixNaN(data,repVal,outfile)

newdata = {};

for i=1:numel(data)
    
    gd = data{i};
    for j=1:numel(gd.exp)
        if(isnan(gd.exp(j)))
            gd.exp(j)=repVal;
        end
    end
    newdata{i} = gd;
end

saveGenesToGdfFile(newdata,outfile);

    