clc;
clear all;

pfo = PCAFileOperations;

Fbar = GetFbar();
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
k = 100;
Sigma = 1/(length(fileNames)-1) .* D_matrix' * D_matrix;
save('Sigma.mat','Sigma');
[U,S,V] = svd(Sigma);
Phi = V(:,1:k);
save('Phi.mat','Phi');
PCAspace = D_matrix*Phi;
save('PCAspace.mat','PCAspace');
