clc;
clear all;
pfo = PCAFileOperations;
fileNames = pfo.getTrainingSetImageNameList();
Fbar = GetFbar();

% Test_image = imread('Chinmay_5.JPG');
Test_image = imread('Ran_1.JPG');
F_test_img = [47 151;
118 146;
69 188;
55 231;
121 229];

Index_Distance_Table = FaceRecognization(Test_image,F_test_img,Fbar);
Img1 = pfo.getTrainingImageByName(fileNames{Index_Distance_Table(1,1)});
Img2 = pfo.getTrainingImageByName(fileNames{Index_Distance_Table(2,1)});
Img3 = pfo.getTrainingImageByName(fileNames{Index_Distance_Table(3,1)});
figure(1);
subplot(1,4,1),imshow(Test_image);
subplot(1,4,2),imshow(Img1);
subplot(1,4,3),imshow(Img2);
subplot(1,4,4),imshow(Img3);