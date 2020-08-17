function varargout = GUI_Classification(varargin)
% GUI_CLASSIFICATION MATLAB code for GUI_Classification.fig
%      GUI_CLASSIFICATION, by itself, creates a new GUI_CLASSIFICATION or raises the existing
%      singleton*.
%
%      H = GUI_CLASSIFICATION returns the handle to a new GUI_CLASSIFICATION or the handle to
%      the existing singleton*.
%
%      GUI_CLASSIFICATION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_CLASSIFICATION.M with the given input arguments.
%
%      GUI_CLASSIFICATION('Property','Value',...) creates a new GUI_CLASSIFICATION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_Classification_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_Classification_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI_Classification

% Last Modified by GUIDE v2.5 24-Jan-2019 11:05:15

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_Classification_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_Classification_OutputFcn, ...
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


% --- Executes just before GUI_Classification is made visible.
function GUI_Classification_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI_Classification (see VARARGIN)

% Choose default command line output for GUI_Classification
handles.output = hObject;
set_fitts_axis(handles);
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUI_Classification wait for user response (see UIRESUME)
% uiwait(handles.figure1);
function set_fitts_axis(handles)
axes(handles.fitts_axis);
    text(120,20,'Extend Hand','rotation',270)
    text(-120,-15,'Flex Hand','rotation',90)
    text(-20,120,'Open Hand','rotation',0)
    text(-20,-120,'Closed Hand','rotation',0)

axis([-110 110 -110 110]) % xmin xmax ymin ymax
% Display Axis Lines Through Origin
ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';
grid on

% --- Outputs from this function are returned to the command line.
function varargout = GUI_Classification_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in load_subject_button.
function load_subject_button_Callback(hObject, eventdata, handles)
% hObject    handle to load_subject_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[file, path] = uigetfile('*.mat', 'Select a MATLAB code file');
[PATHSTR,NAME,EXT] = fileparts(file);
global mdl;
calibration_file = importdata(fullfile(path,file));
mdl = calibration_file.MDL;
set(handles.text12, 'String',NAME);


function subject_identifier_Callback(hObject, eventdata, handles)
% hObject    handle to subject_identifier (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of subject_identifier as text
%        str2double(get(hObject,'String')) returns contents of subject_identifier as a double


% --- Executes during object creation, after setting all properties.
function subject_identifier_CreateFcn(hObject, eventdata, handles)
% hObject    handle to subject_identifier (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in start_classifier_button.
function start_classifier_button_Callback(hObject, eventdata, handles)
% hObject    handle to start_classifier_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global mdl;
real_time_classification_function(mdl);
