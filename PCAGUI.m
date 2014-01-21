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

% Last Modified by GUIDE v2.5 21-Jan-2014 15:28:37

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
