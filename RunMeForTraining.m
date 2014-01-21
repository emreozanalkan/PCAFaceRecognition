clc;
clear all;

pfo = PCAFileOperations;

Fbar = GetFbar();
save('Fbar.mat','Fbar');
pfo.saveFbar(Fbar);
    
[trainingFeatureFiles, trainingFeatureFileCount] = pfo.getTrainingFeatures();

traningSetFolder = pfo.getTrainingSetFolderPath();

%normalizedSetFolder = pfo.getNormalizedSetFolderPath();

%dirOutput = dir(fullfile(traningSetFolder, '*.jpg'));

%fileNames={dirOutput.name}';

fileNames = pfo.getTrainingSetImageNameList();

D_matrix = zeros(length(fileNames),4096);

for i=1:length(fileNames)
    Fimg = pfo.getFeatureMatrixByIndex(trainingFeatureFiles, i);
    Img = pfo.getTrainingImageByName(fileNames{i});
    normImg = ImageNormalization(Img, Fimg, Fbar);
    pfo.saveNormalizedImage(normImg, fileNames{i});
    D_matrix(i, :) = reshape(normImg, 1, 4096);
end



pfo.saveDMatrix(D_matrix);
save('D_matrix.mat','D_matrix');
k = 50;
display('Calculating Sigma...');
Sigma = 1/(length(fileNames)-1) .* D_matrix' * D_matrix;
save('Sigma.mat','Sigma');
display('Starting SVD process. This may take several minutes. Please wait...');
tic;
[U,S,V] = svd(Sigma);
display('Total time for SVD: ');
toc;
Phi = V(:,1:k);
save('Phi.mat','Phi');
PCAspace = D_matrix*Phi;
save('PCAspace.mat','PCAspace');


testFileNames = pfo.getTestSetImageNameList();

totalError = 0;

for i=1:length(testFileNames)
    
    s = strsplit(testFileNames{i}, '.')
    imageName = s{1};
    [Test_image, Img1, Img2, Img3, Name1, Name2, Name3, Error] = RecognizingSystem(imageName);
    display('Error:');
    display(Error);
    
    totalError = totalError + Error;
    
%     Fimg = pfo.getFeatureMatrixByIndex(trainingFeatureFiles, i);
%     Img = pfo.getTrainingImageByName(fileNames{i});
%     normImg = ImageNormalization(Img, Fimg, Fbar);
%     pfo.saveNormalizedImage(normImg, fileNames{i});
%     D_matrix(i, :) = reshape(normImg, 1, 4096);
end

display('Total Error:');
display(totalError);

display('Total Test Files:');
asd = length(testFileNames);
display(asd);


accuracy = (1 - (totalError / length(testFileNames))) * 100;

display('Avera Accuracy:');
disp(accuracy);


