%%RealTime Data Streaming with Delsys SDK

% Copyright (C) 2011 Delsys, Inc.
% 
% Permission is hereby granted, free of charge, to any person obtaining a 
% copy of this software and associated documentation files (the "Software"), 
% to deal in the Software without restriction, including without limitation 
% the rights to use, copy, modify, merge, publish, and distribute the 
% Software, and to permit persons to whom the Software is furnished to do so, 
% subject to the following conditions:
% 
% The above copyright notice and this permission notice shall be included in 
% all copies or substantial portions of the Software.
% 
% THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR 
% IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, 
% FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE 
% AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER 
% LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING 
% FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER 
% DEALINGS IN THE SOFTWARE.

function real_time_data_stream_plotting_test(GUI_handles)


% CHANGE THIS TO THE IP OF THE COMPUTER RUNNING THE TRIGNO CONTROL UTILITY
HOST_IP = '10.101.29.135';
%%
%This example program communicates with the Delsys SDK to stream 16
%channels of EMG data and 48 channels of ACC data.
global all_EMG;
all_EMG = [];
global channelled_EMG;
channelled_EMG=[];
global counter;
counter =0;
global handles;
handles = GUI_handles;
set(handles.text6, 'String', 'Prepare for calibration');


%% Create the required objects

%Define number of sensors
NUM_SENSORS = 4;

%handles to all plots
global plotHandlesEMG;
plotHandlesEMG = zeros(NUM_SENSORS,1);
global rateAdjustedEmgBytesToRead;

%TCPIP Connection to stream EMG Data
interfaceObjectEMG = tcpip(HOST_IP,50041);
interfaceObjectEMG.InputBufferSize = 6400;

%TCPIP Connection to communicate with SDK, send/receive commands
global commObject;
commObject = tcpip(HOST_IP,50040);

%Timer object for drawing plots.
global t;
t = timer('Period', 1, 'ExecutionMode', 'fixedSpacing', 'TimerFcn', {@updatePlots, plotHandlesEMG});
t.StopFcn = @(~,~)stop_recording(interfaceObjectEMG,handles);
global data_arrayEMG
data_arrayEMG = [];


%%Open the COM interface, determine RATE

try
fopen(commObject);
catch

 errordlg('CONNECTION ERROR: Please start the Delsys Trigno Control Application and try again');
return;
end


pause(2);
fread(commObject,commObject.BytesAvailable);
fprintf(commObject, sprintf(['RATE 2000\r\n\r']));
pause(1);
fread(commObject,commObject.BytesAvailable);
fprintf(commObject, sprintf(['RATE?\r\n\r']));
pause(1);
data = fread(commObject,commObject.BytesAvailable);

emgRate = strtrim(char(data'));
if(strcmp(emgRate, '1925.926'))
    rateAdjustedEmgBytesToRead=1664;
else 
    rateAdjustedEmgBytesToRead=1728;
end


%% Setup interface object to read chunks of data
% Define a callback function to be executed when desired number of bytes
% are available in the input buffer
 bytesToReadEMG = rateAdjustedEmgBytesToRead;
 interfaceObjectEMG.BytesAvailableFcn = {@localReadAndPlotMultiplexedEMG,plotHandlesEMG,bytesToReadEMG};
 interfaceObjectEMG.BytesAvailableFcnMode = 'byte';
 interfaceObjectEMG.BytesAvailableFcnCount = bytesToReadEMG;
 
start(t);


%% 
% Open the interface object
try
    fopen(interfaceObjectEMG);
catch
stop_recording(interfaceObjectEMG,handles);
 errordlg('CONNECTION ERROR: Please start the Delsys Trigno Control Application and try again');
end


fprintf(commObject, sprintf(['START\r\n\r']));
update_GUI(handles,'Visuals\IMG_Resting_Hand.png');


function localReadAndPlotMultiplexedEMG(interfaceObjectEMG, ~,~,~, ~)
global rateAdjustedEmgBytesToRead;
bytesReady = interfaceObjectEMG.BytesAvailable;
bytesReady = bytesReady - mod(bytesReady, rateAdjustedEmgBytesToRead);%%1664

if (bytesReady == 0)
    return
end
global data_arrayEMG
data = cast(fread(interfaceObjectEMG,bytesReady), 'uint8');
data = typecast(data, 'single');



if(size(data_arrayEMG, 1) < rateAdjustedEmgBytesToRead*19)
    data_arrayEMG = [data_arrayEMG; data];
else
    data_arrayEMG = [data_arrayEMG(size(data,1) + 1:size(data_arrayEMG, 1));data];
end




%% Update the plots
%This timer callback function is called on every tick of the timer t.  It
%demuxes the dataArray buffers and assigns that channel to its respective
%plot.
function updatePlots(obj, Event,  tmp)
global data_arrayEMG
global plotHandlesEMG
global channelled_EMG;
global handles;

disp('call update');
for i = 1:size(plotHandlesEMG, 1) 
    data_ch = data_arrayEMG(i:16:end);   
    EMG_for_buffer =  [data_arrayEMG(1:16:end), data_arrayEMG(2:16:end), data_arrayEMG(3:16:end), data_arrayEMG(4:16:end);];
end
size(channelled_EMG);

if((size(EMG_for_buffer,2)==4)&&(size(channelled_EMG,1)<30000))
    set(handles.text6, 'String', 'Conduct Gesture...');
    channelled_EMG=channelled_EMG(any(channelled_EMG ~= 0,2),:);
    channelled_EMG=[channelled_EMG;EMG_for_buffer];
elseif((size(EMG_for_buffer,2)==4)&&(size(channelled_EMG,1)>30000))
      stop_gesture; 
     
end

drawnow

function stop_gesture
   global counter;
   global channelled_EMG;
   global handles;
   global t;
   
   if counter==0
        save('Training_Data\training_rest.mat','channelled_EMG');
        disp('saved rest');
        set(handles.checkbox1,'value',1)
        channelled_EMG=[];
        counter = counter+1;
        update_GUI(handles,'Visuals\IMG_Open_Hand.png')
        
   elseif counter == 1 
       save('Training_Data\training_open.mat','channelled_EMG');
        disp('saved open');
        set(handles.checkbox2,'value',1)
        channelled_EMG=[];
        counter = counter+1;
        update_GUI(handles,'Visuals\IMG_Closed_Fist.png')
   elseif counter ==2
        save('Training_Data\training_close.mat','channelled_EMG');
        disp('saved close');
        set(handles.checkbox3,'value',1)
        channelled_EMG=[];
        counter = counter+1;
        update_GUI(handles,'Visuals\IMG_Flex_Wrist.png')
      elseif counter ==3
        save('Training_Data\training_flex.mat','channelled_EMG');   
        disp('saved flex');
        set(handles.checkbox4,'value',1)
        channelled_EMG=[];
        counter = counter+1;
        update_GUI(handles,'Visuals\IMG_Extend_Wrist.png')
      elseif counter ==4
        save('Training_Data\training_extend.mat','channelled_EMG');
        disp('saved extend');
        set(handles.checkbox5,'value',1)
        set(handles.text6, 'String', 'Recording Complete');
        channelled_EMG=[];
        counter = counter+1;
        stop(t);
          
   end
   
    

    
function update_GUI(handles, image)

myImage = imread(image);
imshow(myImage,'Parent',handles.axes1);

disp('showiming image');
set(handles.axes1,'Units','normalized');

set(handles.text6, 'String', 'Recording In Next... 3');
pause(1)
set(handles.text6, 'String', 'Recording In Next ...2');
pause(1)
set(handles.text6, 'String', 'Recording In Next...1');
pause(1)
set(handles.text6, 'String', 'Conduct Gesture');

function stop_recording(interfaceObject1,handles)
global channelled_EMG;
global t;
global commObject;

fprintf(commObject, sprintf(['STOP\r\n\r']));
disp('stopped');


if isvalid(interfaceObject1)
    fclose(interfaceObject1);
    delete(interfaceObject1);
    clear interfaceObject1;
end


if isvalid(t)
   delete(t);
end

if isvalid(commObject)
    fclose(commObject);
    delete(commObject);
    clear commObject;
end

disp('everything cleared');


