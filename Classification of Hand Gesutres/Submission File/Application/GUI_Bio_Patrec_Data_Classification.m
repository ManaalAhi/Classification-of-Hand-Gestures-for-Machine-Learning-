function varargout = GUI_Bio_Patrec_Data_Classification(varargin)
% GUI_BIO_PATREC_DATA_CLASSIFICATION MATLAB code for GUI_Bio_Patrec_Data_Classification.fig
%      GUI_BIO_PATREC_DATA_CLASSIFICATION, by itself, creates a new GUI_BIO_PATREC_DATA_CLASSIFICATION or raises the existing
%      singleton*.
%
%      H = GUI_BIO_PATREC_DATA_CLASSIFICATION returns the handle to a new GUI_BIO_PATREC_DATA_CLASSIFICATION or the handle to
%      the existing singleton*.
%
%      GUI_BIO_PATREC_DATA_CLASSIFICATION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_BIO_PATREC_DATA_CLASSIFICATION.M with the given input arguments.
%
%      GUI_BIO_PATREC_DATA_CLASSIFICATION('Property','Value',...) creates a new GUI_BIO_PATREC_DATA_CLASSIFICATION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_Bio_Patrec_Data_Classification_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_Bio_Patrec_Data_Classification_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI_Bio_Patrec_Data_Classification

% Last Modified by GUIDE v2.5 05-Apr-2019 18:16:46

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_Bio_Patrec_Data_Classification_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_Bio_Patrec_Data_Classification_OutputFcn, ...
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


% --- Executes just before GUI_Bio_Patrec_Data_Classification is made visible.
function GUI_Bio_Patrec_Data_Classification_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI_Bio_Patrec_Data_Classification (see VARARGIN)

% Choose default command line output for GUI_Bio_Patrec_Data_Classification
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
imshow('IMG_emg_signal.png');

% UIWAIT makes GUI_Bio_Patrec_Data_Classification wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_Bio_Patrec_Data_Classification_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in load_subject_data.
function load_subject_data_Callback(hObject, eventdata, handles)
% hObject    handle to load_subject_data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global flag;
floag =0;
[file, path] = uigetfile('*.mat', 'Select a MATLAB code file');
[PATHSTR,NAME,EXT] = fileparts(file);
global user;
user = importdata(fullfile(path,file));
set(handles.subject_file_name, 'String',NAME);
flag = 1;
set(handles.calibration_status,'String', 'Please Select Calibrate','ForegroundColor',[0, 0.4470, 0.7410]);



% --- Executes on button press in calibrate_button.
function calibrate_button_Callback(hObject, eventdata, handles)
% hObject    handle to calibrate_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


global flag;
global user;
global KNN;
global LDA;
global QDA;
global ENS;
global SVM;
global Tree;
global NB;
global rest;


if flag ==1
    
    
    
    [a, b, c, d, e,f,g,h] = calibarate_models(user);
    
    rest = h;
    KNN = a;
    LDA=b;
    QDA=c;
    ENS = d
    SVM=e;
    Tree=f;
    NB=g;
        
    set(handles.calibration_status,'String', 'Models Calibrated, Please Select Gesture and Classifer','ForegroundColor',[0, 0.4470, 0.7410]);
    

elseif flag==0
    
    set(handles.subject_file_name, 'String','Error: Subject File not selected','ForegroundColor',[0, 0.4470, 0.7410]);

end

% --- Executes on button press in classify.
function classify_Callback(hObject, eventdata, handles)
% hObject    handle to classify (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global model_array;
global user;
global KNN;
global LDA;
global QDA;
global ENS;
global SVM;
global Tree;
global NB;
global rest;
global passed;
global gesture;
global Mdl;

CB0 = get(handles.checkbox0,'Value');
CB1 = get(handles.checkbox1,'Value');
CB2 = get(handles.checkbox2,'Value');
CB3 = get(handles.checkbox3,'Value');
CB4 = get(handles.checkbox4,'Value');
CB5 = get(handles.checkbox5,'Value');
CB6 = get(handles.checkbox6,'Value');
CB7 = get(handles.checkbox7,'Value');
CB8 = get(handles.checkbox8,'Value');
CB9 = get(handles.checkbox9,'Value');
CB10 = get(handles.checkbox10,'Value');

CBKNN = get(handles.checkboxKNN,'Value');
CBTree = get(handles.checkboxTree,'Value');
CBLDA = get(handles.checkboxLDA,'Value');
CBENSEMBLE = get(handles.checkboxENS,'Value');
CBQDA = get(handles.checkboxQDA,'Value');
CBSVM = get(handles.checkboxSVM,'Value');
CBNB = get(handles.checkboxNB,'Value');




no_gestures = CB0+CB1+CB2+CB3+CB4+CB5+CB6+CB7+CB8+CB9+CB10;
no_classifier = CBKNN+CBTree+CBLDA+CBENSEMBLE+CBQDA+CBSVM+CBNB;

if ((no_gestures==1)&&(no_classifier==1))
    
    set(handles.calibration_status,'String', 'Classifiying Gesture','ForegroundColor',[0, 0.4470, 0.7410]);
    
    if CB0 == 1
        gesture = 0;   
    elseif CB1 ==1
        gesture=1;
     elseif CB2 ==1
         gesture=2; 
    elseif CB3 ==1
         gesture = 3;
    elseif CB4 ==1
         gesture =4;
    elseif CB5 ==1
         gesture=5;
    elseif CB6==1
         gesture=6;
    elseif CB7==1
         gesture=7;
    elseif CB8 ==1
         gesture=8;
    elseif CB9 ==1
         gesture=9;
    elseif CB10==1
         gesture=10;
         
    end
    
       
    test_file = get_test_file(user, gesture);
     axes(handles.axes1);
     plot(test_file);


    if CBKNN ==1
        Mdl = KNN;
    elseif CBTree==1
        Mdl = Tree;
    elseif CBLDA==1
         Mdl = LDA;
        
    elseif CBENSEMBLE==1
        Mdl = ENS;
        
    elseif CBQDA==1
        Mdl = QDA;
        
    elseif CBSVM==1
        Mdl = SVM;
   
    elseif CBNB==1
        
        Mdl = NB;
        
    end
    
     [class, accuracy] = get_classification(gesture,test_file,Mdl,rest);
      set(handles.text17,'String',class);
      set(handles.text9,'String',accuracy);


passed = test_file;
     
elseif ((no_gestures==1)&&(no_classifier>1))
    
    set(handles.calibration_status,'String', 'Please select only one classifer','ForegroundColor',[0.6350, 0.0780, 0.1840]);

elseif ((no_gestures>1)&&(no_classifier==1))
    
    set(handles.calibration_status,'String', 'Please select only a single gesture','ForegroundColor',[0.6350, 0.0780, 0.1840]);
    
else
     set(handles.calibration_status,'String', 'Please correctly select one of each option','ForegroundColor',[0.6350, 0.0780, 0.1840]);
    
end


% --- Executes on button press in real_time_stimulation.
function real_time_stimulation_Callback(hObject, eventdata, handles)
% hObject    handle to real_time_stimulation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global user;
global Mdl;
generating_stimulation(user,Mdl);



% --- Executes on button press in checkboxNB.
function checkboxNB_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxNB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkboxNB


% --- Executes on button press in checkboxSVM.
function checkboxSVM_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxSVM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkboxSVM


% --- Executes on button press in checkboxQDA.
function checkboxQDA_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxQDA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkboxQDA


% --- Executes on button press in checkboxKNN.
function checkboxKNN_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxKNN (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkboxKNN


% --- Executes on button press in checkboxENS.
function checkboxENS_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxENS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkboxENS


% --- Executes on button press in checkboxTree.
function checkboxTree_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxTree (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkboxTree


% --- Executes on button press in checkboxLDA.
function checkboxLDA_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxLDA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkboxLDA


% --- Executes on button press in checkbox2.
function checkbox2_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox2


% --- Executes on button press in checkbox3.
function checkbox3_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox3


% --- Executes on button press in checkbox4.
function checkbox4_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox4


% --- Executes on button press in checkbox5.
function checkbox5_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox5


% --- Executes on button press in checkbox6.
function checkbox6_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox6


% --- Executes on button press in checkbox7.
function checkbox7_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox7


% --- Executes on button press in checkbox8.
function checkbox8_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox8


% --- Executes on button press in checkbox9.
function checkbox9_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox9


% --- Executes on button press in checkbox10.
function checkbox10_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox10


% --- Executes on button press in checkbox11.
function checkbox11_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox11


% --- Executes on button press in checkbox12.
function checkbox12_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox12


% --- Executes on button press in checkbox8.
function checkbox13_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox8


% --- Executes on button press in checkbox4.
function checkbox14_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox4


% --- Executes on button press in checkbox2.
function checkbox15_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox2


% --- Executes on button press in checkbox3.
function checkbox16_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox3


% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox1


% --- Executes on button press in checkbox5.
function checkbox18_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox5


% --- Executes on button press in checkbox6.
function checkbox19_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox6


% --- Executes on button press in checkbox9.
function checkbox20_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox9


% --- Executes on button press in checkbox10.
function checkbox21_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox10


% --- Executes on button press in checkbox7.
function checkbox22_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox7


% --- Executes on button press in checkbox0.
function checkbox0_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox0
