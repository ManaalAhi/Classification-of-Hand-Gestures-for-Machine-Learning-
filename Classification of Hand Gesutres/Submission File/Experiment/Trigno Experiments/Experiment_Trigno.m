function [total_average, feature_accuracy_array]=  Experiment_Trigno(signal_rest,signal_open,signal_close,signal_flex,signal_extend,signal_pronation,signal_supernation,signal_side_grip,signal_fine_grip,signal_agree,signal_pointer)



a = [1,1];
order = 20;
frame = 21;
%Rest
signal_rest = signal_rest - repmat(mean(signal_rest),a);
signal_rest = sgolayfilt(signal_rest,order,frame);
rest_train= signal_rest(1:13604,:);
rest_test = signal_rest(14604:19406,:);


%Open
signal_open = signal_open - repmat(mean(signal_open),a);
signal_open = sgolayfilt(signal_open,order,frame);
open_train= signal_open(1:13604,:);
open_test = signal_open(14604:19406,:);


%Close
signal_close = signal_close - repmat(mean(signal_close),a);
signal_close = sgolayfilt(signal_close,order,frame);
close_train= signal_close(1:13604,:);
close_test = signal_close(14604:19406,:);



%Flex
signal_flex = signal_flex - repmat(mean(signal_flex),a);
signal_flex = sgolayfilt(signal_flex,order,frame);
flex_train= signal_flex(1:13604,:);
flex_test = signal_flex(14604:19406,:);



%Extend
signal_extend = signal_extend - repmat(mean(signal_extend),a);
signal_extend = sgolayfilt(signal_extend,order,frame);
extend_train= signal_extend(1:13604,:);
extend_test = signal_extend(14604:19406,:);



%Pronation
signal_pronation = signal_pronation - repmat(mean(signal_pronation),a);
signal_pronation = sgolayfilt(signal_pronation,order,frame);
prontation_train= signal_pronation(1:13604,:);
pronation_test = signal_pronation(14604:19406,:);


%Supernation
signal_supernation = signal_supernation - repmat(mean(signal_supernation),a);
signal_supernation = sgolayfilt(signal_supernation,order,frame);
supernation_train= signal_supernation(1:13604,:);
supernation_test = signal_supernation(14604:19406,:);

%Side grip
signal_side_grip = signal_side_grip - repmat(mean(signal_side_grip),a);
signal_side_grip = sgolayfilt(signal_side_grip,order,frame);
side_grip_train= signal_side_grip(1:13604,:);
side_grip_test = signal_side_grip(14604:19406,:);


%Fine grip
signal_fine_grip = signal_fine_grip - repmat(mean(signal_fine_grip),a);
signal_fine_grip = sgolayfilt(signal_fine_grip,order,frame);
fine_grip_train= signal_fine_grip(1:13604,:);
fine_grip_test = signal_fine_grip(14604:19406,:);


%Agree grip
signal_agree = signal_agree - repmat(mean(signal_agree),a);
signal_agree = sgolayfilt(signal_agree,order,frame);
agree_train= signal_agree(1:13604,:);
agree_test = signal_agree(14604:19406,:);


%Pointer grip
signal_pointer = signal_pointer - repmat(mean(signal_pointer),a);
signal_pointer = sgolayfilt(signal_pointer,order,frame);
pointer_train= signal_pointer(1:13604,:);
pointer_test = signal_pointer(14604:19406,:);




%%
%Feature Extraction

 windowSize = 400;
 stepSize = 50;
 sF = 2148.15;
 FeatureData = [];
 featID = {'tmabs','twl','tzc','tslpch2','tcard','twamp'}';
 label = [];
% d1 = designfilt('highpassiir', 'FilterOrder', 8, ...
%              'PassbandFrequency', 4, 'PassbandRipple', 0.2,...
%              'SampleRate', 2000);
%d1 = butter(4,[(4*2)/2000 (500*2)/2000], 'stop');
d1 = 'None';

 MEAN_ABSOLUTE_THRESHOLD = mean(mean(abs(rest_train)));
% used for cardinality
RMS_THRESHOLD = mean(rms(rest_train));
sample_size = length(pointer_train);
Number_of_windows = floor((sample_size - windowSize) / stepSize + 1);
j=1;
 while sample_size>windowSize;
     
    startsample = 1+(j-1)*stepSize;             % Start sample of window
    endsample = (j-1)*stepSize +  windowSize; 
   
    
     Features = GetSigFeatures(rest_train(startsample:endsample,:), sF, d1, featID);
     FeatureData = [FeatureData; Features.tmabs, Features.twl, Features.tzc, Features.tslpch2, Features.tcard, Features.twamp];
     label = [label; 0];
            
     Features = GetSigFeatures(open_train(startsample:endsample,:), sF, d1, featID);
     FeatureData = [FeatureData; Features.tmabs, Features.twl, Features.tzc, Features.tslpch2, Features.tcard, Features.twamp];
     label = [label; 1];
        
                
     Features = GetSigFeatures(close_train(startsample:endsample,:), sF, d1, featID);
     FeatureData = [FeatureData; Features.tmabs, Features.twl, Features.tzc, Features.tslpch2, Features.tcard, Features.twamp];
     label = [label; 2];
     
     Features = GetSigFeatures(flex_train(startsample:endsample,:), sF, d1, featID);
     FeatureData = [FeatureData; Features.tmabs, Features.twl, Features.tzc, Features.tslpch2, Features.tcard, Features.twamp];
     label = [label; 3];
     
     Features = GetSigFeatures(extend_train(startsample:endsample,:), sF, d1, featID);
     FeatureData = [FeatureData; Features.tmabs, Features.twl, Features.tzc, Features.tslpch2, Features.tcard, Features.twamp];
     label = [label; 4];
     
     Features = GetSigFeatures(supernation_train(startsample:endsample,:), sF, d1, featID);
     FeatureData = [FeatureData; Features.tmabs, Features.twl, Features.tzc, Features.tslpch2, Features.tcard, Features.twamp];
     label = [label; 5];
     
     Features = GetSigFeatures(prontation_train(startsample:endsample,:), sF, d1, featID);
     FeatureData = [FeatureData; Features.tmabs, Features.twl, Features.tzc, Features.tslpch2, Features.tcard, Features.twamp];
     label = [label; 6];
     
     
     Features = GetSigFeatures(side_grip_train(startsample:endsample,:), sF, d1, featID);
     FeatureData = [FeatureData; Features.tmabs, Features.twl, Features.tzc, Features.tslpch2, Features.tcard, Features.twamp];
     label = [label; 7];

     Features = GetSigFeatures(fine_grip_train(startsample:endsample,:), sF, d1, featID);
     FeatureData = [FeatureData; Features.tmabs, Features.twl, Features.tzc, Features.tslpch2, Features.tcard, Features.twamp];
     label = [label; 8];
     
     
     Features = GetSigFeatures(agree_train(startsample:endsample,:), sF, d1, featID);
     FeatureData = [FeatureData; Features.tmabs, Features.twl, Features.tzc, Features.tslpch2, Features.tcard, Features.twamp];
     label = [label; 9];
     
     
     Features = GetSigFeatures(pointer_train(startsample:endsample,:), sF, d1, featID);
     FeatureData = [FeatureData; Features.tmabs, Features.twl, Features.tzc, Features.tslpch2, Features.tcard, Features.twamp];
     label = [label; 10];

     sample_size = sample_size-50;
     j=j+1;
     
 end
 FeatureData = FeatureData;
 label = label;


Mdl = fitcknn(FeatureData,label,'Distance','euclidean','NumNeighbors',20); 
%  Mdl= fitcdiscr(FeatureData,label,'DiscrimType','linear');
%  Mdl=fitcdiscr(FeatureData,label,'DiscrimType','quadratic');
%  Mdl = fitcensemble(FeatureData,label);
%  Mdl=fitcecoc(FeatureData,label);
%  Mdl= fitctree(FeatureData,label);
%  Mdl = fitcnb(FeatureData,label);
 

%%
%Prediciting Test data

 
 test_array = [rest_test,open_test,close_test,flex_test,extend_test,supernation_test,...
     pronation_test,side_grip_test,fine_grip_test,agree_test,pointer_test];
 
 label_array = [0,1,2,3,4,5,6,7,8,9,10];


feature_accuracy_array = [];


 for m = 1:11
     
     x = 1+((m-1)*4);
    testee  = test_array(:,x:x+3);
    test_sample_size= length(testee);
    
    test_features = [];
    test_label = [];
    
    j = 1;
     while test_sample_size>windowSize
         
        startsample = 1+(j-1)*stepSize;             % Start sample of window
        endsample = (j-1)*stepSize +  windowSize; 

         Features = GetSigFeatures(testee(startsample:endsample,:), 2000, d1, featID);
         test_features = [test_features; Features.tmabs, Features.twl, Features.tzc, Features.tslpch2, Features.tcard, Features.twamp];
         test_label = [test_label; label_array(m);];
        j = j+1;
        test_sample_size = test_sample_size-50;
     end
     

      % predicted_class= classify(test_features,FeatureData, label', 'quadratic');
       predicted_class= predict(Mdl, test_features);
       
       correct = 0;
       for n = 1:length(predicted_class)
           if (predicted_class(n)==test_label(m))
               correct = correct +1;
           end
       end
       
       feature_accuracy_rate = (correct/length(predicted_class))*100;
       feature_accuracy_array = [feature_accuracy_array,feature_accuracy_rate ];

 end

 
 
 total_average = mean(feature_accuracy_array);



 