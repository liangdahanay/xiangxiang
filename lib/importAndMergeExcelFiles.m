function importAndMergeExcelFiles(origin, exprFile, posFile, resultsFile,duplicatesFile)

txt = sprintf('imported genes will be tagged as belonging to: %s',origin);
disp(txt);


%===============================
%import first excel file
%===============================
txt = sprintf('importing excel expression file: %s',exprFile);
disp(txt);

%format for the expression file
%
%nomegene expr1 expr2 expr3 expr4 .....
%nomegene expr1 expr2 expr3 expr4 .....
%.......


[numTab1, txtTab1, rawTab1] = xlsread(exprFile);


[nGenes, nExpr] = size(numTab1);


geneIDs = txtTab1(:,1);  %col 1 contains the gene ID
expr = numTab1; %


%================================
%import second excel file 
%================================
txt = sprintf('importing excel position file: %s',posFile);
disp(txt);

[numTab2,txtTab2,rawTab2] = xlsread(posFile); 


%format required for the second file
%
%genename chrom  start end strand
%genename chrom  start end strand
% ...

temp_geneIDs = txtTab2(:,1);
temp_chroms = txtTab2(:,2);
temp_geneStarts = numTab2(:,1);
temp_geneStops = numTab2(:,2);
temp_strands = numTab2(:,3);

%================================
%create new data by merging the datasets and remove duplicates
%(only the first encountered instance of any replicated gene is kept)
%================================
disp('merging imported data...');

fgeneIDs = {};
fchroms = {};
fstrands = [];
fstart = [];
fstop = [];
fexpr = {};
duplicates = {};

count = 0;
dupcount = 0;
for(i=1:numel(geneIDs))
    geneid = geneIDs{i};
    found = 0;
    for j=1:numel(fgeneIDs)
        if(strcmp(fgeneIDs{j},geneid)==1)
            txt = sprintf('found duplicate gene: %s',geneid);
            disp(txt);
            found = 1;
            dupcount = dupcount + 1;
            duplicates{dupcount} = geneid;
            break
        end
    end
    if(found==0)
        count = count + 1;
        fgeneIDs{count}=geneid;
        fexpr{count}= expr(i,:);
        
        for(k=1:numel(temp_geneIDs))
            found2 = 0;
            if(strcmp(temp_geneIDs{k},geneid))
                found2 = k;
                break
            end
        end
        if(found2==0)
            txt = sprintf('gene %s not found in second excel file',geneid);
            disp(txt);
            fstrands(count)=NaN;
        else
            fchroms{count} = temp_chroms{found2};
            fstrands(count)=temp_strands(found2);
            fstart(count) = temp_geneStarts(found2);
            fstop(count) = temp_geneStops(found2);
            
        end
    end
end

nFinalRows = count;

fgeneIDs = fgeneIDs';
fchroms = fchroms';
fstrands = fstrands';
fstart = fstart';
fstop = fstop';
fexpr = fexpr';


%takes all the imported genes and reorders them based on their starting
%positions (bp) in their respective chromosomes

disp('reoder genes on position');

[sfstart,IX] = sort(fstart);
sfgeneIDs = fgeneIDs(IX);
sfchroms = fchroms(IX);
sfstop = fstop(IX);
sfstrands = fstrands(IX);
sfexpr = fexpr(IX,:);

fgeneIDs = sfgeneIDs;
fchroms = sfchroms;
fstop = sfstop;
fstart = sfstart;
fstrands = sfstrands;
fexpr = sfexpr;

%create the gene data structure

gd.origin = '';
gd.geneID = '';
gd.chrom = '';
gd.strand = 0;
gd.start = 0;
gd.stop = 0;
gd.exp = {};

gdata = {};
for i=1:nFinalRows
    
    gd.origin = origin;
    gd.geneID = fgeneIDs{i};
    gd.chrom = fchroms{i};
    gd.strand = fstrands(i);
    gd.start = fstart(i);
    gd.stop = fstop(i);
    gd.exp = fexpr{i};
    
    gdata{i} = gd;
end

txt = sprintf('saving merged gene data to: %s',resultsFile);
disp(txt);

saveGenesToGdfFile(gdata,resultsFile);



txt = sprintf('saving duplicate genes to: %s',duplicatesFile);
disp(txt);

fid = fopen(duplicatesFile,'wt');
frm = '%s \n';
[nx,ndup] = size(duplicates);
disp(ndup);
for i=1:ndup
    disp(i);
    fprintf(fid, frm,duplicates{i});
end
fclose(fid);

disp('done');
