%%%Testing
function predicted_class = offline_prediction(input,Mdl)
testee = processing_test_signal(input);
sample_size = length(testee);
stepSize = 50;
test_features = [];

windowSize = 400;
featID = {'tmabs','twl','tzc','tslpch2','tcard','twamp'}';
sF = 2000;

j=1;
 while sample_size>windowSize
     
         
        startsample = 1+(j-1)*stepSize;             % Start sample of window
        endsample = (j-1)*stepSize +  windowSize; 
     
    
     Features = GetSigFeatures(testee(startsample:endsample,:), sF, 'None', featID);
     test_features = [test_features; Features.tmabs, Features.twl, Features.tzc, Features.tslpch2, Features.tcard, Features.twamp];
                
     sample_size = sample_size-50;
     j=j+1;
     
 end
 
predicted_class= mode(predict(Mdl, test_features));



end



function signal = processing_test_signal(channelled_EMG)
a = [1,1];
order =20;
frame = 21;
start = floor((length(channelled_EMG)-10000)/2);
final = (start + 10000)-1;
signal = channelled_EMG(start:final,:);
signal = signal - repmat(mean(signal),a);
end


