%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%This function is to find the Fbar by iteration
%Note:  Need the extra function to read Fi where Fi is the feature of No.i
%       image. example: Fi = readF(index)
%Fpre is defined on the paper
%input: threshold of error, MaxIterations for limit the interations
%output: Fbar for normalization
%Last modify time: 1/18/2014
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [Fbar] = GetFbar(threshold,MaxIterations)

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %check the input
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
    if (nargin == 2)
        label = ['threshold = ',int2str(threshold)];
        disp(label);
        label = ['MaxIterations = ',int2str(MaxIterations)];
        disp(label);
    end

    if (nargin == 1)
        MaxIterations = 30;
        label = ['threshold = ',int2str(threshold)];
        disp(label);
        disp('MaxIterations = 30');
    end
    
    if (nargin == 0)%if input is wrong
        MaxIterations = 30;
        threshold = 1;
        disp('threshold = 1');
        disp('MaxIterations = 30');
    end
    
    pfo = PCAFileOperations; % PCA File Operations
    
    Fpre = pfo.getPredefinedFeatureLocations();
    
    [trainingFeatureFiles, trainingFeatureFileCount] = pfo.getTrainingFeatures();
    
    [allFeatureFiles, allFeatureFileCount] = pfo.getAllFeatures();
    
    NumberOfTrainFeature = trainingFeatureFileCount;
    
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %Step 1: 
    %initialize Fbar = F1
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    F1 = pfo.getFeatureMatrixByIndex(trainingFeatureFiles, 1);
    Fbar = F1;
    
    IterationCounter = 0;
    Error = 30;
    Prve_Error = Error;
    while(IterationCounter < MaxIterations)
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %Step 2:
        %Get A and b from Fpre = A*Fbar + b
        %Get Fbar = A*Fbar + b
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        IterationCounter = IterationCounter + 1;
        [A,b] = GetAB(Fbar, Fpre);
        Fbar = FeatureTransformation(A, b, Fbar);
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %Step 3:
        %Find Fi_dash of all Fi
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        Fsum = zeros(5,2);
        for i = 1:NumberOfTrainFeature
            Fi = pfo.getFeatureMatrixByIndex(trainingFeatureFiles, i);
            [A,b] = GetAB(Fi, Fbar);
            Fi_dash = FeatureTransformation(A, b, Fi);
            Fsum = Fsum + Fi_dash;
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %Step 4:
        %Update new Fbar by averaging Fi_dash
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        Fbar_t = Fsum / NumberOfTrainFeature;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %Step 5:
        %error between Fbar_t and Fbar_(t-1)
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        Error = sum(sqrt(sum(((Fbar_t' - Fbar').^2))));
        if(Error < threshold)
            disp('Fbar Found...');
            break;
        end
        %check if it is necessary to continue iteration
        if(Prve_Error <= Error) 
            label = ['Minimum Error at iterations = ',int2str(IterationCounter-1),'...Iteration stoped...'];
            disp(label);
            break;
        else
            label = ['Iterations = ',int2str(IterationCounter),' Error = ',num2str(Error)];
            disp(label);
            Fbar = Fbar_t;
        end
        Prve_Error = Error;
    end
end