function [out1, out2] = chooseCertain(file1,file2,lineNum)
    [status, sheetlist1]=xlsfinfo(file1);
    sheet1=sheetlist1{1};
    
    [status, sheetlist2]=xlsfinfo(file2);
    sheet2=sheetlist2{1};
    
    [num, txt, origin1]=xlsread(file1, sheet1);
    [num, txt, origin2]=xlsread(file2, sheet2);
    
    totalLine1=size(origin1,1);
    totalLine2=size(origin2,1);
    count=0;
    out1=strcat(file1, '_', num2Str(lineNum), '.csv');
    out2=strcat(file2, '_', num2Str(lineNum), '.csv');
    fid1=fopen(out1, 'w');
    fid2=fopen(out2, 'w');
    for i=1:totalLine1
        curGene=origin1(i,1);
        curGene=curGene{1};
        for j=1:totalLine2
            findGene=origin2(j,1);
            findGene=findGene{1};
            if curGene == findGene
                count=count+1;
                added = origin1(i,:);
                fprintf(fid1, '%s,%d,%d\n', added{1,:});
                added=origin2(j:);
            end
        end
    end
end