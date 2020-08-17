function generating_stimulation(recSession, Mdl)


a = [1,1];
signal_open = recSession.tdata(:,:,1);
signal_open = signal_open - repmat(mean(signal_open),a);
signal_close = recSession.tdata(:,:,2);
signal_close = signal_close - repmat(mean(signal_close),a);
signal_flex = recSession.tdata(:,:,3);
signal_flex = signal_flex - repmat(mean(signal_flex),a);
signal_extend = recSession.tdata(:,:,4);
signal_extend = signal_extend - repmat(mean(signal_extend),a);
signal_supernation = recSession.tdata(:,:,5);
signal_supernation = signal_supernation - repmat(mean(signal_supernation),a);
signal_pronation = recSession.tdata(:,:,6);
signal_pronation = signal_pronation - repmat(mean(signal_pronation),a);
signal_side_grip = recSession.tdata(:,:,7);
signal_side_grip = signal_side_grip - repmat(mean(signal_side_grip),a);
signal_fine_grip = recSession.tdata(:,:,8);
signal_fine_grip = signal_fine_grip - repmat(mean(signal_fine_grip),a);
signal_agree = recSession.tdata(:,:,9);
signal_agree = signal_agree - repmat(mean(signal_agree),a);
signal_pointer = recSession.tdata(:,:,10);
signal_pointer = signal_pointer - repmat(mean(signal_pointer),a);



 
 %%
 %Creating Test data
 
 test_open = signal_open(25001:29000,:);
 test_close = signal_close(25001:29000,:);
 test_flex = signal_flex(25001:29000,:);
 test_extend = signal_extend(25001:29000,:);
 test_supernation = signal_supernation(25001:29000,:);
 test_pronation = signal_pronation(25001:29000,:);
 test_side_grip = signal_side_grip(25001:29000,:);
 test_fine_grip = signal_fine_grip(25001:29000,:);
 test_agree = signal_agree(25001:29000,:);
 test_pointer = signal_pointer(25001:29000,:);
 test_rest = signal_open(19001:23000,:);
 

 test_array = [test_rest,test_open,test_close,test_flex,test_extend,test_supernation,...
     test_pronation,test_side_grip,test_fine_grip,test_agree,test_pointer];

 
 label_array = ["Rest","Open","Close","Flex","Extend","Supernation","Pronation","Side Grip","Fine Grip","Agree","Pointer"];

 
 
  windowSize = 400;
 stepSize = 50;
 sF = 2000;

 featID = {'tmabs','twl','tzc','tslpch2','tcard','twamp'}';

 
 MEAN_ABSOLUTE_THRESHOLD = mean(mean(abs(test_rest)));
% used for cardinality
RMS_THRESHOLD = mean(rms(test_rest));
sample_size = length(test_array);
Number_of_windows = floor((sample_size - windowSize) / stepSize + 1);
j=1;
 
 

feature_accuracy_array = [];

 for m = 1:11
     
     x = 1+((m-1)*4);
    testee  = test_array(:,x:x+3);
    test_sample_size= length(testee);
    
    test_features = [];
    test_label = [];
    previous_class = 0;

    j = 1;
     while test_sample_size>windowSize
         
        startsample = 1+(j-1)*stepSize;             % Start sample of window
        endsample = (j-1)*stepSize +  windowSize; 

         Features = GetSigFeatures(testee(startsample:endsample,:), sF, 'None', featID);
         test_features = [test_features; Features.tmabs, Features.twl, Features.tzc, Features.tslpch2, Features.tcard, Features.twamp];
         test_label = [test_label; label_array(m);];
        j = j+1;
        test_sample_size = test_sample_size-50;
        predicted_class= mode(predict(Mdl, test_features));
        
        if predicted_class==0
            name = 'Rest';
        elseif predicted_class==1
            name = 'Open';
        elseif predicted_class==2
            name = 'Close';
        elseif predicted_class==3
            name = 'Flex';  
        elseif predicted_class==4
            name = 'Extend';   
        elseif predicted_class==5
            name = 'Supination';   
        elseif predicted_class==6
            name = 'Pronation';  
        elseif predicted_class==7
            name = 'Side Grip';  
        elseif predicted_class==8
            name = 'Fine Grip';     
        elseif predicted_class==9
            name = 'Agree';  
        elseif predicted_class==10
            name = 'Pointer';              
            
        end
        
    if mod(j,10)==0
        

        s1 = 'Predicted Class:   ';
        z = 'Actual class: ';
        v= label_array(m);
        d = strcat(z,v);


          s = strcat(s1,name);

        if predicted_class ~= previous_class

            previous_class = predicted_class;
        end

            pause(0.1);
            figure(1);plot(testee(startsample:endsample,:));title({s;d}); 



    end


     
     end
       
       

 end


end



