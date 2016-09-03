disp('========================================');
disp(' GDF NaN Fixer  ');
disp('fixes gdf files with NaN expressions');
disp('=========================================');

inputFile = input('enter name of gdf input file: ','s');
outputFile = input('enter name of gdf output file: ','s');

replacement = str2num(input('enter value to replace NaN: ','s'));



disp('=================================');
disp('loading genes from gdf file');
disp('=================================');

data = loadGenesFromGdfFile(inputFile);

disp('==============================================');
disp('fix NaN values');
disp('==============================================');

data = fixNaN(data,replacement, outputFile);

clear data replacement outputFile inputFile;
