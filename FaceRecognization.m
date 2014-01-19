function [Index_Distance] = FaceRecognization(Test_image,F_test_img,Fbar)
    Phi = importdata('Phi.mat');
    PCAspace = importdata('PCAspace.mat');
    img = ImageNormalization(Test_image,F_test_img,Fbar);
    Xj = reshape(img,1,4096);
    oslash_j = double(Xj) * double(Phi);
    [m,n] = size(PCAspace);
    Index_Distance = zeros(m,2);
    for i = 1:m
        Index_Distance(i,1) = i;
        Index_Distance(i,2) = sqrt(sum((PCAspace(i,:) - oslash_j).^2));
    end
    Index_Distance = sortrows(Index_Distance,2);
end