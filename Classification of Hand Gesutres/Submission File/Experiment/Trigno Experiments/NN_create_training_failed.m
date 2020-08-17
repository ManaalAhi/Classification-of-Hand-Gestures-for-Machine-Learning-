clear;
a = [1,1];
order =20;
frame = 21;
%Rest
load 1_Rest.mat;
signal_rest = Data';
signal_rest = signal_rest - repmat(mean(signal_rest),a);
signal_rest = sgolayfilt(signal_rest,order,frame);
rest_train= signal_rest(1:13604,:);

load 3_Rest.mat
signal_rest = Data';
signal_rest = signal_rest - repmat(mean(signal_rest),a);
signal_rest = sgolayfilt(signal_rest,order,frame);
rest_test = signal_rest(14604:19406,:);


%Open
load 1_Open.mat;
signal_open = Data';
signal_open = signal_open - repmat(mean(signal_open),a);
signal_open = sgolayfilt(signal_open,order,frame);
open_train= signal_open(1:13604,:);
open_test = signal_open(14604:19406,:);

load 3_open.mat
signal_open = Data';
signal_open = signal_open - repmat(mean(signal_open),a);
signal_open = sgolayfilt(signal_open,order,frame);
open_test = signal_open(14604:19406,:);


%Close
load 1_Close.mat;
signal_close = Data';
signal_close = signal_close - repmat(mean(signal_close),a);
signal_close = sgolayfilt(signal_close,order,frame);
close_train= signal_close(1:13604,:);

load 3_Close.mat
signal_close = Data';
signal_close = signal_close - repmat(mean(signal_close),a);
signal_close = sgolayfilt(signal_close,order,frame);
close_test = signal_close(14604:19406,:);


%Flex
load 1_Flex.mat;
signal_flex = Data';
signal_flex = signal_flex - repmat(mean(signal_flex),a);
signal_flex = sgolayfilt(signal_flex,order,frame);
flex_train= signal_flex(1:13604,:);


load 3_flex.mat
signal_flex = Data';
signal_flex = signal_flex - repmat(mean(signal_flex),a);
signal_flex = sgolayfilt(signal_flex,order,frame);
flex_test = signal_flex(14604:19406,:);




%Extend
load 1_Extend.mat;
signal_extend = Data';
signal_extend = signal_extend - repmat(mean(signal_extend),a);
signal_extend = sgolayfilt(signal_extend,order,frame);
extend_train= signal_extend(1:13604,:);


load 3_Extend.mat
signal_extend = Data';
signal_extend = signal_extend - repmat(mean(signal_extend),a);
signal_extend = sgolayfilt(signal_extend,order,frame);
extend_test = signal_extend(14604:19406,:);


%Pronation
load 1_Pronation.mat;
signal_pronation = Data';
signal_pronation = signal_pronation - repmat(mean(signal_pronation),a);
signal_pronation = sgolayfilt(signal_pronation,order,frame);
prontation_train= signal_pronation(1:13604,:);


load 3_Pronation.mat
signal_pronation = Data';
signal_pronation = signal_pronation - repmat(mean(signal_pronation),a);
signal_pronation = sgolayfilt(signal_pronation,order,frame);
pronation_test = signal_pronation(14604:19406,:);


%Supernation
load 1_Supernation.mat;
signal_supernation= Data';
signal_supernation = signal_supernation - repmat(mean(signal_supernation),a);
signal_supernation = sgolayfilt(signal_supernation,order,frame);
supernation_train= signal_supernation(1:13604,:);



load 3_Supernation.mat
signal_supernation = Data';
signal_supernation = signal_supernation - repmat(mean(signal_supernation),a);
signal_supernation = sgolayfilt(signal_supernation,order,frame);
supernation_test = signal_supernation(14604:19406,:);




%Side grip
load 1_Side_Grip.mat;
signal_side_grip = Data';
signal_side_grip = signal_side_grip - repmat(mean(signal_side_grip),a);
signal_side_grip = sgolayfilt(signal_side_grip,order,frame);
side_grip_train= signal_side_grip(1:13604,:);


load 3_Side_Grip.mat
signal_side_grip = Data';
signal_side_grip = signal_side_grip - repmat(mean(signal_side_grip),a);
signal_side_grip = sgolayfilt(signal_side_grip,order,frame);
side_grip_test = signal_side_grip(14604:19406,:);

%Fine grip
load 1_Fine_Grip.mat;
signal_fine_grip = Data';
signal_fine_grip = signal_fine_grip - repmat(mean(signal_fine_grip),a);
signal_fine_grip = sgolayfilt(signal_fine_grip,order,frame);
fine_grip_train= signal_fine_grip(1:13604,:);


load 3_Fine_Grip.mat
signal_fine_grip = Data';
signal_fine_grip = signal_fine_grip - repmat(mean(signal_fine_grip),a);
signal_fine_grip = sgolayfilt(signal_fine_grip,order,frame);
fine_grip_test = signal_fine_grip(14604:19406,:);



%Agree grip
load 1_Agree.mat;
signal_agree = Data';
signal_agree = signal_agree - repmat(mean(signal_agree),a);
signal_agree = sgolayfilt(signal_agree,order,frame);
agree_train= signal_agree(1:13604,:);


load 3_Agree.mat
signal_agree = Data';
signal_agree = signal_agree - repmat(mean(signal_agree),a);
signal_agree = sgolayfilt(signal_agree,order,frame);
agree_test = signal_agree(14604:19406,:);


%Pointer grip
load 1_Pointer.mat;
signal_pointer = Data';
signal_pointer = signal_pointer - repmat(mean(signal_pointer),a);
signal_pointer = sgolayfilt(signal_pointer,order,frame);
pointer_train= signal_pointer(1:13604,:);


load 3_Pointer.mat
signal_pointer = Data';
signal_pointer = signal_pointer - repmat(mean(signal_pointer),a);
signal_pointer = sgolayfilt(signal_pointer,order,frame);
pointer_test = signal_pointer(14604:19406,:);




%%
%Feature Extraction

 windowSize = 400;
 stepSize = 50;
 sF = 2148.15;
 FeatureData = [];
 featID = {'tmabs','twl','tzc','tslpch2','tcard','twamp'}';
 label = [];

 d1 = 'None';
 
 
 MEAN_ABSOLUTE_THRESHOLD = mean(mean(abs(rest_train)));
% used for cardinality
RMS_THRESHOLD = mean(rms(rest_train));
sample_size = length(signal_pointer);
Number_of_windows = floor((sample_size - windowSize) / stepSize + 1);
j=1;
 while sample_size>windowSize;
     
    startsample = 1+(j-1)*stepSize;             % Start sample of window
    endsample = (j-1)*stepSize +  windowSize; 
   
    
     Features = GetSigFeatures(signal_rest(startsample:endsample,:), sF, d1, featID);
     FeatureData = [FeatureData; Features.tmabs, Features.twl, Features.tzc, Features.tslpch2, Features.tcard, Features.twamp];
     label = [label; 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
            
     Features = GetSigFeatures(signal_open(startsample:endsample,:), sF, d1, featID);
     FeatureData = [FeatureData; Features.tmabs, Features.twl, Features.tzc, Features.tslpch2, Features.tcard, Features.twamp];
     label = [label; 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0];
        
                
     Features = GetSigFeatures(signal_close(startsample:endsample,:), sF, d1, featID);
     FeatureData = [FeatureData; Features.tmabs, Features.twl, Features.tzc, Features.tslpch2, Features.tcard, Features.twamp];
     label = [label; 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0];
     
     Features = GetSigFeatures(signal_flex(startsample:endsample,:), sF, d1, featID);
     FeatureData = [FeatureData; Features.tmabs, Features.twl, Features.tzc, Features.tslpch2, Features.tcard, Features.twamp];
     label = [label; 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0];
     
     Features = GetSigFeatures(signal_extend(startsample:endsample,:), sF, d1, featID);
     FeatureData = [FeatureData; Features.tmabs, Features.twl, Features.tzc, Features.tslpch2, Features.tcard, Features.twamp];
     label = [label; 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0];
     
     Features = GetSigFeatures(signal_supernation(startsample:endsample,:), sF, d1, featID);
     FeatureData = [FeatureData; Features.tmabs, Features.twl, Features.tzc, Features.tslpch2, Features.tcard, Features.twamp];
     label = [label; 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0];
     
     Features = GetSigFeatures(signal_pronation(startsample:endsample,:), sF, d1, featID);
     FeatureData = [FeatureData; Features.tmabs, Features.twl, Features.tzc, Features.tslpch2, Features.tcard, Features.twamp];
     label = [label; 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0];
     
     
     Features = GetSigFeatures(signal_side_grip(startsample:endsample,:), sF, d1, featID);
     FeatureData = [FeatureData; Features.tmabs, Features.twl, Features.tzc, Features.tslpch2, Features.tcard, Features.twamp];
     label = [label; 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0];

     Features = GetSigFeatures(signal_fine_grip(startsample:endsample,:), sF, d1, featID);
     FeatureData = [FeatureData; Features.tmabs, Features.twl, Features.tzc, Features.tslpch2, Features.tcard, Features.twamp];
     label = [label; 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0];
     
     
     Features = GetSigFeatures(signal_agree(startsample:endsample,:), sF, d1, featID);
     FeatureData = [FeatureData; Features.tmabs, Features.twl, Features.tzc, Features.tslpch2, Features.tcard, Features.twamp];
     label = [label; 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0];
     
     
     Features = GetSigFeatures(signal_pointer(startsample:endsample,:), sF, d1, featID);
     FeatureData = [FeatureData; Features.tmabs, Features.twl, Features.tzc, Features.tslpch2, Features.tcard, Features.twamp];
     label = [label; 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1];

     sample_size = sample_size-50;
     j=j+1;
     
 end
 FeatureData = FeatureData.';
 label = label.';
 
 numClasses = 11;
sizeTrain = size(FeatureData,2); 
targets = eye(numClasses);
hiddenLayerSize = 25;   
net = patternnet(hiddenLayerSize);

 %% set net parameters
net.divideParam.trainRatio = 0.666; % training set [%]
net.divideParam.testRatio = 0.334; % training set [%]
%net.trainParam.showWindow = 0;
[net,~,~,~] = train(net,FeatureData,label);




