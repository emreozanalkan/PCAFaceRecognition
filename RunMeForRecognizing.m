clc;
clear all;

test_image = 'Klemen_1';

[Test_image, Img1, Img2, Img3, Name1, Name2, Name3, Accuracy] = RecognizingSystem(test_image);

figure(1);
subplot(1,4,1), imshow(Test_image), xlabel(test_image);
subplot(1,4,2), imshow(Img1), xlabel(Name1);
subplot(1,4,3), imshow(Img2), xlabel(Name2);
subplot(1,4,4), imshow(Img3), xlabel(Name3);
title(['Accuracy: ',num2str(Accuracy), '%']);