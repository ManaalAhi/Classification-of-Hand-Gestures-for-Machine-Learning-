%Feature Extraction
function [tree, knn, ensemble, features, labels] = train_classifier


disp('in function');
load 'Training_Data\training_rest';
train_rest = processing_training_signal(channelled_EMG);

load 'Training_Data\training_open';
train_open = processing_training_signal(channelled_EMG);

load 'Training_Data\training_close';
train_close = processing_training_signal(channelled_EMG);

load 'Training_Data\training_flex';
train_flex = processing_training_signal(channelled_EMG);

load 'Training_Data\training_extend';
train_extend = processing_training_signal(channelled_EMG);

disp('files loaded, extracting features');

 windowSize = 400;
 stepSize = 50;
 sF = 2000;
 FeatureData = [];
 featID = {'tmabs','twl','tzc','tslpch2','tcard','twamp'}';
 label = [];

 d1 = 'None';
  
 MEAN_ABSOLUTE_THRESHOLD = mean(mean(abs(train_rest)));
% used for cardinality
RMS_THRESHOLD = mean(rms(train_rest));
sample_size = length(train_rest);
Number_of_windows = floor((sample_size - windowSize) / stepSize + 1);
j=1;
 while sample_size>windowSize;
     
    startsample = 1+(j-1)*stepSize;             % Start sample of window
    endsample = (j-1)*stepSize +  windowSize; 
   
    
     Features = GetSigFeatures(train_rest(startsample:endsample,:), sF, d1, featID);
     FeatureData = [FeatureData; Features.tmabs, Features.twl, Features.tzc, Features.tslpch2, Features.tcard, Features.twamp];
     label = [label; 0];
            
     Features = GetSigFeatures(train_open(startsample:endsample,:), sF, d1, featID);
     FeatureData = [FeatureData; Features.tmabs, Features.twl, Features.tzc, Features.tslpch2, Features.tcard, Features.twamp];
     label = [label; 1];
        
                
     Features = GetSigFeatures(train_close(startsample:endsample,:), sF, d1, featID);
     FeatureData = [FeatureData; Features.tmabs, Features.twl, Features.tzc, Features.tslpch2, Features.tcard, Features.twamp];
     label = [label; 2];
     
     Features = GetSigFeatures(train_flex(startsample:endsample,:), sF, d1, featID);
     FeatureData = [FeatureData; Features.tmabs, Features.twl, Features.tzc, Features.tslpch2, Features.tcard, Features.twamp];
     label = [label; 3];
     
     Features = GetSigFeatures(train_extend(startsample:endsample,:), sF, d1, featID);
     FeatureData = [FeatureData; Features.tmabs, Features.twl, Features.tzc, Features.tslpch2, Features.tcard, Features.twamp];
     label = [label; 4];
     
     sample_size = sample_size-50;
     j=j+1;
     
 end
 features = FeatureData;
 labels = label;
 disp('training model');
  tree = fitctree(FeatureData,label);
  knn = fitcknn(FeatureData,label,'Distance','euclidean','NumNeighbors',20);
  ensemble = fitcensemble(FeatureData,label);
  disp('models created');
  
end

function signal = processing_training_signal(channelled_EMG)
a = [1,1];
order =20;
frame = 21;
start = floor((length(channelled_EMG)-30000)/2);
final = (start + 30000)-1;
signal = channelled_EMG(start:final,:);
signal = signal - repmat(mean(signal),a);
end


