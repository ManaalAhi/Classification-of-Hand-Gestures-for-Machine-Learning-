function [class, accuracy] = get_classification(gesture_ID,test_array,Mdl,rest)

testee = test_array;

 windowSize = 400;
 stepSize = 50;
 sF = 2000;
 FeatureData = [];
 featID = {'tmabs','twl','tzc','tslpch2','tcard','twamp'}';
 label = [];
 
MEAN_ABSOLUTE_THRESHOLD = mean(mean(abs(rest)));
% used for cardinality
RMS_THRESHOLD = mean(rms(rest));
sample_size = length(testee);
Number_of_windows = floor((sample_size - windowSize) / stepSize + 1);
j=1; 
test_features = [];
test_label = [];

test_sample_size = length(testee);


feature_accuracy_array = [];

    j = 1;
     while test_sample_size>windowSize
         
        startsample = 1+(j-1)*stepSize;             % Start sample of window
        endsample = (j-1)*stepSize +  windowSize; 

         Features = GetSigFeatures(testee(startsample:endsample,:), 2000, 'None', featID);
         test_features = [test_features; Features.tmabs, Features.twl, Features.tzc, Features.tslpch2, Features.tcard, Features.twamp];
         test_label = [test_label; gesture_ID];
        j = j+1;
        test_sample_size = test_sample_size-50;
     end
     

       predicted_class= predict(Mdl, test_features);
       class_ID = mode(predicted_class);
   
       
       count = 0;
       for i = 1:1:length(test_label)
           if(test_label(i)==predicted_class(i))
               count = count+1;
           end
       end
       
       accuracy = (count/length(test_label))*100;
       
       if class_ID==0
           class='Rest';
       elseif class_ID==1
           class='Open';
       elseif class_ID==2
           class='Close';
       elseif class_ID==3
           class='Flex';
       elseif class_ID==4
           class='Extend';
       elseif class_ID==5
           class='Supination';
       elseif class_ID==6
           class='Pronation';
       elseif class_ID==7
           class='Side Grip';
       elseif class_ID==8
           class='Fine Grip';
       elseif class_ID==9
           class='Agree';
       elseif class_ID==10
           class='Pointer';
       end
           
    
end
           
           
           
           