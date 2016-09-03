
disp('===============================');
disp(' GDF CREATOR  ');
disp('creates gdf files from excel files');
disp('==================================');

origin = input('enter name of data set (with no blanks): ','s');

exprFilename = input('enter name of excel file containing expressions: ','s');
posFilename = input('enter name of excel file containing gene attributes: ','s');


resultsFile = input('enter name of output gdf file: ','s');
duplicatesFile = input('enter name of duplicates file [duplicates.txt]','s');
if isempty(duplicatesFile)
    duplicatesFile = 'duplicates.txt';
end



disp('=================================================');
disp('importing and merging excel files -> creating gdf');
disp('=================================================');

importAndMergeExcelFiles(origin, exprFilename,posFilename,resultsFile,duplicatesFile);

clear origin exprFilename posFilename resultsFile duplicatesFile;