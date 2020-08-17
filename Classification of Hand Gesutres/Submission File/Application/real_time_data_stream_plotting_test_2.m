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

global handles;
handles = GUI_handles;
set(handles.text5, 'String', 'Prepare for Recording...');


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
commObject = tcpip(HOST_IP,50040);

%Timer object for drawing plots.
global t;
t = timer('Period', 1, 'ExecutionMode', 'fixedSpacing', 'TimerFcn', {@updatePlots, plotHandlesEMG});
t.StopFcn = @(~,~)stop_recording(commObject, interfaceObjectEMG,handles);
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

    stop_recording(commObject, interfaceObjectEMG,handles);
    errordlg('CONNECTION ERROR: Please start the Delsys Trigno Control Application and try again');
    
end


fprintf(commObject, sprintf(['START\r\n\r']));


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
global t;
global handles;
disp('call update');
for i = 1:size(plotHandlesEMG, 1) 
    data_ch = data_arrayEMG(i:16:end);   
   
end

EMG_for_buffer =  [data_arrayEMG(1:16:end), data_arrayEMG(2:16:end), data_arrayEMG(3:16:end), data_arrayEMG(4:16:end);];
size(channelled_EMG);

if((size(EMG_for_buffer,2)==4)&&(size(channelled_EMG,1)<10000))
    set(handles.text5, 'String', 'Conduct Gesture...');
    channelled_EMG=channelled_EMG(any(channelled_EMG ~= 0,2),:);
    channelled_EMG=[channelled_EMG;EMG_for_buffer];
elseif((size(EMG_for_buffer,2)==4)&&(size(channelled_EMG,1)>10000))
       stop(t); 
end

drawnow
    
function stop_recording(commObject, interfaceObject1,handles)
global channelled_EMG;
global t;



save('recorded_gesture.mat', 'channelled_EMG');
fprintf(commObject, sprintf(['STOP\r\n\r']));
disp('stopped');
set(handles.text5, 'String', 'Recording Complete');



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


