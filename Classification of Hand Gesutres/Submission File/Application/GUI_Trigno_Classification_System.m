function varargout = GUI_Trigno_Classification_System(varargin)
% GUI_TRIGNO_CLASSIFICATION_SYSTEM MATLAB code for GUI_Trigno_Classification_System.fig
%      GUI_TRIGNO_CLASSIFICATION_SYSTEM, by itself, creates a new GUI_TRIGNO_CLASSIFICATION_SYSTEM or raises the existing
%      singleton*.
%
%      H = GUI_TRIGNO_CLASSIFICATION_SYSTEM returns the handle to a new GUI_TRIGNO_CLASSIFICATION_SYSTEM or the handle to
%      the existing singleton*.
%
%      GUI_TRIGNO_CLASSIFICATION_SYSTEM('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_TRIGNO_CLASSIFICATION_SYSTEM.M with the given input arguments.
%
%      GUI_TRIGNO_CLASSIFICATION_SYSTEM('Property','Value',...) creates a new GUI_TRIGNO_CLASSIFICATION_SYSTEM or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_Trigno_Classification_System_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_Trigno_Classification_System_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI_Trigno_Classification_System

% Last Modified by GUIDE v2.5 05-Apr-2019 17:34:00

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_Trigno_Classification_System_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_Trigno_Classification_System_OutputFcn, ...
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


% --- Executes just before GUI_Trigno_Classification_System is made visible.
function GUI_Trigno_Classification_System_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI_Trigno_Classification_System (see VARARGIN)

% Choose default command line output for GUI_Trigno_Classification_System
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUI_Trigno_Classification_System wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_Trigno_Classification_System_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in recording_Session_button.
function recording_Session_button_Callback(hObject, eventdata, handles)
 GUI_Recording_Session_new
% hObject    handle to recording_Session_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in raw_data_button.
function raw_data_button_Callback(hObject, eventdata, handles)
   real_time_data_stream_plotting

% hObject    handle to raw_data_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% --- Executes on button press in offline_classification.
function offline_classification_Callback(hObject, eventdata, handles)
GUI_Offline_Classification
% hObject    handle to offline_classification (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
GUI_Bio_Patrec_Data_Classification


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
GUI_Bio_Patrec_Data_Classification

% --- Executes on button press in online_classification.
function online_classification_Callback(hObject, eventdata, handles)
% hObject    handle to online_classification (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
GUI_Real_Time_Classification
