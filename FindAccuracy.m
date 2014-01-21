function [ accuracy ] = FindAccuracy()
%FINDACCURACY Summary of this function goes here
%   Detailed explanation goes here

display('Calculating average accuracy. This may take a minute. Please wait...');

pfo = PCAFileOperations;

testFileNames = pfo.getTestSetImageNameList();

totalError = 0;

for i=1:length(testFileNames)
    
    s = strsplit(testFileNames{i}, '.');
    imageName = s{1};
    [Test_image, Img1, Img2, Img3, Name1, Name2, Name3, Error] = RecognizingSystem(imageName);
%     display('Error:');
%     display(Error);
    
    totalError = totalError + Error;
    
%     Fimg = pfo.getFeatureMatrixByIndex(trainingFeatureFiles, i);
%     Img = pfo.getTrainingImageByName(fileNames{i});
%     normImg = ImageNormalization(Img, Fimg, Fbar);
%     pfo.saveNormalizedImage(normImg, fileNames{i});
%     D_matrix(i, :) = reshape(normImg, 1, 4096);
end

% display('Total Error:');
% display(totalError);
% 
% display('Total Test Files:');
% asd = length(testFileNames);
% display(asd);


accuracy = (1 - (totalError / length(testFileNames))) * 100;

display('Calculating average is finished.');

end

