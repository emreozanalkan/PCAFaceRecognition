classdef PCAFileOperations
    %PCAFILEOPERATIONS PCA Project File Operations
    %   All File I/O Operations encapsulated with this class
    
    % Private Properties
    properties (Constant = true, Hidden = true)
      predefinedFeatureLocations = 'predefinedFeatures.txt'; % Predefined feature locations in txt
      dataFolderPath = 'data'; % represents our data folder, consist of all .txt and .jpg files
      testSetFolderPath = [PCAFileOperations.dataFolderPath filesep 'test_set']; % path for test set
      traningSetFolderPath = [PCAFileOperations.dataFolderPath filesep 'training_set']; % path for train set
      normalizedSetFolderPath = [PCAFileOperations.dataFolderPath filesep 'normalized_set']; % path for normalized images
      
      normalizedFbarPath = [PCAFileOperations.normalizedSetFolderPath filesep 'Fbar.txt'];
      DMatrixPath = [PCAFileOperations.normalizedSetFolderPath filesep 'DMatrix.txt'];
    end
    
   % Public Properties
    properties
        a = 1;
    end
    
    % Private Methods
    methods (Access = private, Static = true)
        % Read the feature file to 5x2 matrix
        function file = ReadFeatureFile(path)
            f = fopen(path); 
            file = textscan(f, '%n');
            file = reshape(file{1}, 2, 5)';
            fclose(f);
        end
    end
    
    % Public Methods
    methods (Static = true)
        
        function dataFolderPath = getDataFolderPath()
            dataFolderPath = PCAFileOperations.dataFolderPath;
        end
        
        function testSetFolderPath = getTestSetFolderPath()
            testSetFolderPath = PCAFileOperations.testSetFolderPath;
        end
        
        function traningSetFolderPath = getTrainingSetFolderPath()
            traningSetFolderPath = PCAFileOperations.traningSetFolderPath;
        end
        
        function normalizedSetFolderPath = getNormalizedSetFolderPath()
            normalizedSetFolderPath = PCAFileOperations.normalizedSetFolderPath;
        end
        
        % Read our predefined feature locations to matrix and returns
        function predefinedFeatures = getPredefinedFeatureLocations()
            if exist('predefinedFeatures.txt', 'file') ~= 2
                error('Predefined Features file is not found :(');
            end
            
            predefinedFeatures = PCAFileOperations.ReadFeatureFile(PCAFileOperations.predefinedFeatureLocations);
        end
        
        % Read all future file names, and returns the list and count
        function [allFeatures, count] = getAllFeatures()
            if isdir(PCAFileOperations.dataFolderPath) == 0
                error('Data Folder does not exist :(');
            end
            
            allFeatures = dir([PCAFileOperations.dataFolderPath filesep '*.' 'txt']);
            
            count = size(allFeatures, 1);
            
            if count <= 0
                error(['No feature file found in path: ' PCAFileOperations.dataFolderPath]);
            end
        end
        
        % Returns the feature file name by index
        function [feature] = getFeatureByIndex(index)
            if isdir(PCAFileOperations.dataFolderPath) == 0
                error('Data Folder does not exist :(');
            end
            
            allFeatures = dir([PCAFileOperations.dataFolderPath filesep '*.' 'txt']);

            count = size(allFeatures, 1);
            
            if count <= 0
                error(['No feature file found in path: ' PCAFileOperations.dataFolderPath]);
            elseif count > index
                error(['Index overflow in ' mfilename('class')]);
            end
            
            feature = allFeatures(1);
        end
        
        % Read all training feature files and returns list of it with count
        function [trainingFeatures, count] = getTrainingFeatures()
            if isdir(PCAFileOperations.traningSetFolderPath) == 0
                error('Training Feature path is not found :(');
            end
            
            trainingFeatures = dir([PCAFileOperations.traningSetFolderPath filesep '*.' 'txt']);
            
            count = size(trainingFeatures, 1);
            
            if count <= 0
                error(['No feature file found in path: ' PCAFileOperations.traningSetFolderPath]);
            end
        end
        
        % Read all test feature files and returns list of it with count
        function [testFeatures, count] = getTestFeatures()
            if isdir(PCAFileOperations.testSetFolderPath) == 0
                error('Test Feature path is not found :(');
            end
            
            testFeatures = dir([PCAFileOperations.testSetFolderPath filesep '*.' 'txt']);
            
            count = size(testFeatures, 1);
            
            PCAFileOperations.a = 5;
            
            if count <= 0
                error(['No feature file found in path: ' PCAFileOperations.testSetFolderPath]);
            end
        end
        
        % Reads the given name of the feature file and returns the matrix
        % of values
        function [feature] = getFeatureMatrix(filePath)
            fullPath = [PCAFileOperations.dataFolderPath filesep filePath.name];
            feature = PCAFileOperations.ReadFeatureFile(fullPath);
        end
        
        % Returns the feautre matrix of feature file in list by given
        % index
        function [feature] = getFeatureMatrixByIndex(featureList, index)
            fullPath = [PCAFileOperations.dataFolderPath filesep featureList(index).name];
            feature = PCAFileOperations.ReadFeatureFile(fullPath);
        end
        
        function [image] = getOriginalImageByName(fileName)
            fullPath = [PCAFileOperations.dataFolderPath filesep fileName];
            image = imread(fullPath);
        end
        
        function [image] = getGrayOriginalImageByName(fileName)
            fullPath = [PCAFileOperations.dataFolderPath filesep fileName];
            image = rgb2gray(imread(fullPath));
        end
        
        function [image] = getTrainingImageByName(fileName)
            fullPath = [PCAFileOperations.traningSetFolderPath filesep fileName];
            image = imread(fullPath);
        end
        
        function [image] = getGrayTrainingImageByName(fileName)
            fullPath = [PCAFileOperations.traningSetFolderPath filesep fileName];
            image = rgb2gray(imread(fullPath));
        end
        
        function [] = saveNormalizedImage(image, fileName)
           imwrite(image, [PCAFileOperations.normalizedSetFolderPath filesep fileName]); 
        end
        
        function [fileNameList] = getTrainingSetImageNameList()
            imageFileList = dir([PCAFileOperations.traningSetFolderPath filesep '*.jpg']);
            fileNameList = {imageFileList.name}';
        end
        
        
        function [] = saveFbar(Fbar)
            if isunix
                dlmwrite(PCAFileOperations.normalizedFbarResult, Fbar, 'delimiter', ' ', 'newline', 'unix');
            else
                dlmwrite(PCAFileOperations.normalizedFbarResult, Fbar, 'delimiter', ' ', 'newline', 'pc');
            end
        end
        
        function [] = saveDMatrix(DMatrix)
            if isunix
                dlmwrite(PCAFileOperations.DMatrixPath, DMatrix, 'delimiter', ' ', 'newline', 'unix');
            else
                dlmwrite(PCAFileOperations.DMatrixPath, DMatrix, 'delimiter', ' ', 'newline', 'pc');
            end
        end
        
    end
    
    methods
        
    end
    
end

