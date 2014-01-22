function varargout = PCAGUI(varargin)
% PCAGUI MATLAB code for PCAGUI.fig
%      PCAGUI, by itself, creates a new PCAGUI or raises the existing
%      singleton*.
%
%      H = PCAGUI returns the handle to a new PCAGUI or the handle to
%      the existing singleton*.
%
%      PCAGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PCAGUI.M with the given input arguments.
%
%      PCAGUI('Property','Value',...) creates a new PCAGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before PCAGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to PCAGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help PCAGUI

% Last Modified by GUIDE v2.5 21-Jan-2014 20:49:32

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @PCAGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @PCAGUI_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before PCAGUI is made visible.
function PCAGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to PCAGUI (see VARARGIN)

% Choose default command line output for PCAGUI
handles.output = hObject;


problem1 = imread('problem1.png');

axes(handles.axesSelectedImage);
imshow(problem1);

axes(handles.axesRelatedImage1);
imshow(problem1);

axes(handles.axesRelatedImage2);
imshow(problem1);

axes(handles.axesRelatedImage3);
imshow(problem1);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes PCAGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = PCAGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in listboxTestImageList.
function listboxTestImageList_Callback(hObject, eventdata, handles)
% hObject    handle to listboxTestImageList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listboxTestImageList contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listboxTestImageList

% display('listbox hello!');
% index_selected = get(handles.listboxTestImageList,'Value');
% file_list = get(handles.listboxTestImageList,'String');
% 
% display(strcat('Index selected: ', num2str(index_selected)));
% display(strcat('String Value: ', file_list(index_selected)));

set(handles.listboxTestImageList, 'Enable', 'inactive');

index_selected = get(handles.listboxTestImageList,'Value');
file_list = get(handles.listboxTestImageList,'String');
selectedFile = file_list(index_selected);

selectedFile = cellstr(selectedFile);
selectedFile = selectedFile{1};

s = strsplit(selectedFile, '.');
selectedFileName = s{1};

if isempty(selectedFileName)
    return;
end

[Test_image, Img1, Img2, Img3, Name1, Name2, Name3, Error] = RecognizingSystem(selectedFileName);

n = strsplit(selectedFileName, '_');
testImageName = n{1};

axes(handles.axesSelectedImage);
imshow(Test_image);
set(handles.textSelectedImageName, 'String', testImageName);

axes(handles.axesRelatedImage1);
imshow(Img1);
set(handles.textRelatedImage1Name, 'String', Name1);

axes(handles.axesRelatedImage2);
imshow(Img2);
set(handles.textRelatedImage2Name, 'String', Name2);

axes(handles.axesRelatedImage3);
imshow(Img3);
set(handles.textRelatedImage3Name, 'String', Name3);

set(handles.listboxTestImageList, 'Enable', 'on');



% --- Executes during object creation, after setting all properties.
function listboxTestImageList_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listboxTestImageList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in buttonTrain.
function buttonTrain_Callback(hObject, eventdata, handles)
% hObject    handle to buttonTrain (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Construct a questdlg with three options

if  exist('D_matrix.mat', 'file') && ...
    exist('Fbar.mat', 'file') && ...
    exist('PCAspace.mat', 'file') && ...
    exist('Phi.mat', 'file') && ...
    exist('Sigma.mat', 'file')

choice = questdlg('Would you like to use old training data ?', ...
	'Yes', 'No');
% Handle response
switch choice
    case 'Yes'
        q = questdlg('This may take a minute. Please be patient.', '!! PCA Training !!', 'OK', 'OK');
        DMatrixVars = whos('-file','D_matrix.mat');
        if ~ismember('D_matrix', {DMatrixVars.name})
            D_matrix = importdata('D_matrix.mat');
        end
        FbarVars = whos('-file','Fbar.mat');
        if ~ismember('Fbar', {FbarVars.name})
            Fbar = importdata('Fbar.mat');
        end
        PCASpaceVars = whos('-file','PCAspace.mat');
        if ~ismember('PCAspace', {PCASpaceVars.name})
            PCAspace = importdata('PCAspace.mat');
        end
        PhiVars = whos('-file','Phi.mat');
        if ~ismember('Phi', {PhiVars.name})
            Phi = importdata('Phi.mat');
        end
        SigmaVars = whos('-file','Sigma.mat');
        if ~ismember('Sigma', {SigmaVars.name})
            Sigma = importdata('Sigma.mat');
        end
        
        accuracy = FindAccuracy();
    case 'No'
        q = questdlg('This may take several minutes. Please be patient.', '!! PCA Training !!', 'OK', 'OK');
        set(handles.buttonTrain, 'Enable', 'off');
        set(handles.textTrainingMessage, 'Visible', 'on');
        RunMeForTraining;
        set(handles.buttonTrain, 'Enable', 'on');
        set(handles.textTrainingMessage, 'Visible', 'off');
    case 'Cancel'
        return;
    otherwise
        return;
end

end

        q = questdlg('This may take several minutes. Please be patient.', '!! PCA Training !!', 'OK', 'OK');
        set(handles.buttonTrain, 'Enable', 'off');
        set(handles.textTrainingMessage, 'Visible', 'on');
        RunMeForTraining;
        set(handles.buttonTrain, 'Enable', 'on');
        set(handles.textTrainingMessage, 'Visible', 'off');

set(handles.textAverageTrainSetAccuracy, 'String', ['Training Set Average Accuracy: ', num2str(accuracy, 4)]);

pfo = PCAFileOperations;
trainingImageList = pfo.getTestSetImageNameList();

set(handles.listboxTestImageList, 'String', trainingImageList,...
	'Value', 1);    
