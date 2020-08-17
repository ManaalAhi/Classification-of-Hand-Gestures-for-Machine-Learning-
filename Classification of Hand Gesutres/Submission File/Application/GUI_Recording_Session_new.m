function varargout = GUI_Recording_Session_new(varargin)
%GUI_RECORDING_SESSION_NEW MATLAB code file for GUI_Recording_Session_new.fig
%      GUI_RECORDING_SESSION_NEW, by itself, creates a new GUI_RECORDING_SESSION_NEW or raises the existing
%      singleton*.
%
%      H = GUI_RECORDING_SESSION_NEW returns the handle to a new GUI_RECORDING_SESSION_NEW or the handle to
%      the existing singleton*.
%
%      GUI_RECORDING_SESSION_NEW('Property','Value',...) creates a new GUI_RECORDING_SESSION_NEW using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to GUI_Recording_Session_new_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      GUI_RECORDING_SESSION_NEW('CALLBACK') and GUI_RECORDING_SESSION_NEW('CALLBACK',hObject,...) call the
%      local function named CALLBACK in GUI_RECORDING_SESSION_NEW.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI_Recording_Session_new

% Last Modified by GUIDE v2.5 03-Apr-2019 17:11:08

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_Recording_Session_new_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_Recording_Session_new_OutputFcn, ...
                   'gui_LayoutFcn',  [], ...
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


% --- Executes just before GUI_Recording_Session_new is made visible.
function GUI_Recording_Session_new_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)

% Choose default command line output for GUI_Recording_Session_new
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
imshow('Visuals/Intro_Image.png');

% UIWAIT makes GUI_Recording_Session_new wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_Recording_Session_new_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in start_recording_button.
function start_recording_button_Callback(hObject, eventdata, handles)
% hObject    handle to start_recording_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global goahead;
goahead = 1;
s = get(handles.edit1,'String');
y = get(handles.edit2,'String');
if isempty(s) && isempty(y)
  goahead = 0;
  set(handles.text6, 'String', 'Please enter Subject and Sesssion ID'); 
elseif isempty(s)
    goahead = 0;
  set(handles.text6, 'String', 'Please enter Subject ID');
elseif isempty(y)
    set(handles.text6, 'String', 'Please enter Session ID'); 
end

if goahead ==1
    try
real_time_data_stream_plotting_test_calibration(handles)
    catch
        set(handles.text6, 'String', 'Please enter Session ID'); 
    end
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



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in calibrate_classifier_button.
function calibrate_classifier_button_Callback(hObject, eventdata, handles)
% hObject    handle to calibrate_classifier_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global goahead;
goahead=1;
if goahead == 1
    set(handles.text7, 'String', 'Calibrating... please wait');
    ID=  get(handles.edit1,'String');
    ID = str2num(ID);

    global user;
    user(ID).subject_Id = ID;
    user(ID).session_Id = get(handles.edit2,'String');
    [tree, knn, ensemble, features,labels] = train_classifier;
    user(ID).tree = tree;
    user(ID).knn = knn;
    user(ID).ensemble = ensemble;
    user(ID).features = features;
    user(ID).labels = labels;


    disp('caibration complete');
    
else
    disp('cannot go ahead');
end
set(handles.text7, 'String', 'Saving.');
global user;
[file,path] = uiputfile('*.mat','Save file name');
if file~=0
save(fullfile(path,file), 'user');

set(handles.text7, 'String', 'Calibration and saved.');
end


% --- Executes on button press in save_recording.
function save_recording_Callback(hObject, eventdata, handles)
% hObject    handle to save_recording (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.text7, 'String', 'Saving Session');
global user;
[file,path] = uiputfile('*.mat','Save file name');
if file~=0
save(fullfile(path,file), 'user');
end

set(handles.text7, 'String', 'Session saved');


% --- Executes on button press in checkbox4.
function checkbox2_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox4


% --- Executes on button press in checkbox2.
function checkbox4_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox2


% --- Executes on button press in checkbox2.
function checkbox5_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox2


% --- Executes on button press in checkbox4.
function checkbox3_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox4


% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox1


% --- Executes on button press in continue_offline.
function continue_offline_Callback(hObject, eventdata, handles)
% hObject    handle to continue_offline (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
GUI_Offline_Classification
