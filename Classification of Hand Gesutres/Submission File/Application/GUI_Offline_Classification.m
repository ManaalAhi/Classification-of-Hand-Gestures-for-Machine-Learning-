function varargout = GUI_Offline_Classification(varargin)
% GUI_OFFLINE_CLASSIFICATION MATLAB code for GUI_Offline_Classification.fig
%      GUI_OFFLINE_CLASSIFICATION, by itself, creates a new GUI_OFFLINE_CLASSIFICATION or raises the existing
%      singleton*.
%
%      H = GUI_OFFLINE_CLASSIFICATION returns the handle to a new GUI_OFFLINE_CLASSIFICATION or the handle to
%      the existing singleton*.
%
%      GUI_OFFLINE_CLASSIFICATION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_OFFLINE_CLASSIFICATION.M with the given input arguments.
%
%      GUI_OFFLINE_CLASSIFICATION('Property','Value',...) creates a new GUI_OFFLINE_CLASSIFICATION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_Offline_Classification_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_Offline_Classification_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI_Offline_Classification

% Last Modified by GUIDE v2.5 05-Apr-2019 11:43:14

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_Offline_Classification_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_Offline_Classification_OutputFcn, ...
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


% --- Executes just before GUI_Offline_Classification is made visible.
function GUI_Offline_Classification_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI_Offline_Classification (see VARARGIN)
% Choose default command line output for GUI_Offline_Classification
handles.output = hObject;

% Update handles structure
imshow('Visuals\IMG_emg_signal.png');
guidata(hObject, handles);
global load_file;
load_file = 1;

% UIWAIT makes GUI_Offline_Classification wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_Offline_Classification_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Load_Calibration_Button.
function Load_Calibration_Button_Callback(hObject, eventdata, handles)
% hObject    handle to Load_Calibration_Button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[file, path] = uigetfile('*.mat', 'Select a MATLAB code file');
[PATHSTR,NAME,EXT] = fileparts(file);
global subject;
subject = importdata(fullfile(path,file));

set(handles.text3, 'String',NAME);



%x = recSession.tdata;



% --- Executes on button press in Record_Gesture_Button.
function Record_Gesture_Button_Callback(hObject, eventdata, handles)
% hObject    handle to Record_Gesture_Button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
real_time_data_stream_plotting_test_2(handles)



% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox1
%KNN


% --- Executes on button press in checkbox2.
function checkbox2_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox2
%LDA


% --- Executes on button press in checkbox3.
function checkbox3_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox3
%QDA


% --- Executes on button press in load_gesture.
function load_gesture_Callback(hObject, eventdata, handles)
% hObject    handle to load_gesture (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global load_file;

[file, path] = uigetfile('*.mat', 'Select a MATLAB code file');
[PATHSTR,NAME,EXT] = fileparts(file);
global test_file;
test_file = importdata(fullfile(path,file));

set(handles.text13, 'String',NAME);
set(handles.text5, 'String','File loaded');
load_file = 0;

% --- Executes on button press in classify_push_button.
function classify_push_button_Callback(hObject, eventdata, handles)
% hObject    handle to classify_push_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global user;
global Mdl;
global test_file;
global load_file;

%Remove this, it should load test file after recording
if load_file==1
    load 'recorded_gesture.mat';
    test_file = channelled_EMG;
else
    set(handles.text6, 'String', 'A file has been loaded');
end


go_ahead = 0;

checkbox_KNN = get(handles.checkbox1,'Value');
checkbox_ENS = get(handles.checkbox2,'Value');
checkbox_TRE = get(handles.checkbox3,'Value');



if (checkbox_KNN + checkbox_ENS + checkbox_TRE>1)
    set(handles.text6, 'String', 'Select only one Classifier');
elseif (checkbox_KNN + checkbox_ENS + checkbox_TRE <1)
    set(handles.text6, 'String', 'You have not selected a classfier');
    
elseif(checkbox_KNN + checkbox_ENS + checkbox_TRE ==1)
    go_ahead =1;
end

if checkbox_KNN ==1
    disp('KNN slected');
    Mdl = user.knn;
elseif checkbox_ENS ==1
    disp('ENS slected');
    Mdl = user.ensemble;
elseif checkbox_TRE==1
    disp('TRE slected');
    Mdl = user.tree;

end

if (go_ahead ==1)
predicted_class = offline_prediction(test_file,Mdl)

 if (predicted_class ==0)
        disp('in secon if statement');
        set(handles.text9, 'String', 'Rest');
        imshow('Visuals\IMG_Resting_Hand.png');

    elseif (predicted_class == 1)
        set(handles.text9, 'String', 'Open');
        imshow('Visuals\IMG_Open_Hand.png');

    elseif (predicted_class == 2)
        set(handles.text9, 'String', 'Close');
        imshow('Visuals\IMG_Closed_Fist.png');

    elseif (predicted_class == 3)
        set(handles.text9, 'String', 'Flex');
        imshow('Visuals\IMG_Flex_Wrist.png');

    elseif (predicted_class == 4)
        set(handles.text9, 'String', 'Extend');
        imshow('Visuals\IMG_Extend_Wrist.png');

    elseif (predicted_class == 5)
        set(handles.text9, 'String', 'Supernation');
        imshow('Visuals\IMG_Supernation.png');

    elseif (predicted_class == 6)
        set(handles.text9, 'String', 'Pronation');
        imshow('Visuals\IMG_Pronation.png');

    elseif (predicted_class == 7)
        set(handles.text9, 'String', 'Side Grip');
        imshow('Visuals\IMG_Side_Grip.png');

    elseif (predicted_class == 8)
        set(handles.text9, 'String', 'Fine Grip');
        imshow('Visuals\IMG_Fine_Grip.png');

    elseif (predicted_class == 9)
        set(handles.text9, 'String', 'Agree');
        imshow('Visuals\IMG_Thumbs_Up.png');

    elseif (predicted_class == 10)
        set(handles.text9, 'String', 'Pointer');
        imshow('Visuals\IMG_Pointer.png');

    else
        set(handles.text9, 'String', 'Unclassifed');

 end
    
else
    set(handles.text9, 'String', 'You have inccorectly selected your classification type');
    
end


% --- Executes on button press in checkbox4.
function checkbox4_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox4




% --- Executes on button press in checkbox6.
function checkbox6_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox6


% --- Executes on button press in save_recording.
function save_recording_Callback(hObject, eventdata, handles)
% hObject    handle to save_recording (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global test_file;
    [file,path] = uiputfile('*.mat','Save file name');
    if file~=0
        save(fullfile(path,file), 'test_file');
    end
    
