function [Test_image, Img1, Img2, Img3, Name1, Name2, Name3, Error] = RecognizingSystem(test_image)
    pfo = PCAFileOperations;
    fileNames = pfo.getTrainingSetImageNameList();
    Fbar = importdata('Fbar.mat');
    testImagePath = strcat(test_image, '.JPG');
    Test_image = pfo.getOriginalImageByName(testImagePath);
    F_test_img = pfo.getFeatureMatrixByName(test_image);

    Index_Distance_Table = FaceRecognization(Test_image,F_test_img,Fbar);
    Name_1 = fileNames{Index_Distance_Table(1,1)};
    Img1 = pfo.getTrainingImageByName(Name_1);
    Name_2 = fileNames{Index_Distance_Table(2,1)};
    Img2 = pfo.getTrainingImageByName(Name_2);
    Name_3 = fileNames{Index_Distance_Table(3,1)};
    Img3 = pfo.getTrainingImageByName(Name_3);
    
    C = strsplit(test_image,'_');
    TestImageName = C(1);
    C = strsplit(Name_1,'_');
    Name1 = C(1);
    C = strsplit(Name_2,'_');
    Name2 = C(1);
    C = strsplit(Name_3,'_');
    Name3 = C(1);
    
%     in = 0;
%     if(~strcmp(Name1,TestImageName))
%         in = in + 1;
%     end
%     if(~strcmp(Name2,TestImageName))
%         in = in + 1;
%     end
%     if(~strcmp(Name3,TestImageName))
%         in = in + 1;
%     end
% 
%     Accuracy = (1 - in/3)*100;



    if(~strcmp(Name1, TestImageName))
        Error = 1;
    else
        Error = 0;
    end
    
end