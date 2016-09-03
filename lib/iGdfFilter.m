disp('========================================');
disp(' GDF FILTER  ');
disp('filter gdf files upon specified criteria');
disp('=========================================');

inputFile = input('enter name of gdf input file: ','s');
outputFile = input('enter name of gdf output file: ','s');
txt = 'enter number of expressions that\nwill be considered when filtering (1,2,...n).\nIf you plan to use all expressions\n enter 1 at this stage\nand -1 at the next prompt: ';

nExpIndices = str2num(input(txt,'s'));
expIndices = [];
for i=1:nExpIndices
    expIndex = str2num(input('enter index of expression to be considered for filtering (-1 to consider all of them): ','s'));
    expIndices = [expIndices,expIndex];
end

expThreshValue = str2num(input('enter expression threshold value: ','s'));

yn = input('keep values above the threshold (y/n)? [y]','s');
if isempty(yn)
    keepAboveThresh = 1;
end
if(yn=='n')
    keepAboveThresh = 0;
else
    keepAboveThresh = 1;
end


% %=====================================
% % USER EDITS HERE
% %=====================================
% 
% inputFile = 'family1_allgenes.gdf';
% outputFile ='family1_genes_filtered.gdf';
% 
% keepAboveThresh = true;
% expThreshValue = 1.7;
% expIndices = [1,2,3];
% 
% %=====================================
% % END USER EDITS
% %=====================================
% 

disp('=================================');
disp('loading genes from gdf file');
disp('=================================');

data = loadGenesFromGdfFile(inputFile);

disp('==============================================');
disp('filter gene data based on expression value');
disp('and save to gdf file');
disp('==============================================');

datas = filterGenesOnExpressionValue(data,expIndices,expThreshValue, keepAboveThresh, outputFile);

clear data datas inputFile outputFile expIndex expIndices i txt expThreshValue yn keepAboveThresh;

