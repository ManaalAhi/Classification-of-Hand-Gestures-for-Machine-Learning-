function [KNN, LDA, QDA, ENS, SVM,TREE,NB,rest] = calibarate_models(recSession)

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



data_open = [signal_open(1001:5000,:); signal_open(13001:17000,:)];
data_close= [signal_close(1001:5000,:);signal_close(13001:17000,:);];
data_flex = [signal_flex(1001:5000,:);signal_flex(13001:17000,:);];
data_extend=[signal_extend(1001:5000,:);signal_extend(3001:17000,:);];
data_supernation=[signal_supernation(1001:5000,:);signal_supernation(13001:17000,:);];
data_pronation=[signal_pronation(1001:5000,:);signal_pronation(13001:17000,:);];
data_side_grip=[signal_side_grip(1001:5000,:);signal_side_grip(13001:17000,:);];
data_fine_grip=[signal_fine_grip(1001:5000,:);signal_fine_grip(13001:17000,:);];
data_agree=[signal_agree(1001:5000,:);signal_agree(13001:17000,:);];
data_pointer=[signal_pointer(1001:5000,:);signal_pointer(13001:17000,:);];


rest = [signal_open(7001:11000,:);signal_open(31001:35000,:);...
    signal_close(7001:11000,:);signal_close(19001:23000,:);signal_close(31001:35000,:);...
    signal_flex(7001:11000,:);signal_flex(19001:23000,:);signal_flex(31001:35000,:);...
    signal_extend(7001:11000,:);signal_extend(19001:23000,:);signal_extend(31001:35000,:)];



%%
%Feature Extraction

 windowSize = 400;
 stepSize = 50;
 sF = 2000;
 FeatureData = [];
 featID = {'tmabs','twl','tzc','tslpch2','tcard','twamp'}';
 label = [];
 
 MEAN_ABSOLUTE_THRESHOLD = mean(mean(abs(rest)));
% used for cardinality
RMS_THRESHOLD = mean(rms(rest));
sample_size = length(data_open);
Number_of_windows = floor((sample_size - windowSize) / stepSize + 1);
j=1;
 while sample_size>windowSize;
     
    startsample = 1+(j-1)*stepSize;             % Start sample of window
    endsample = (j-1)*stepSize +  windowSize; 
   
    
     Features = GetSigFeatures(rest(startsample:endsample,:), 2000, 'None', featID);
     FeatureData = [FeatureData; Features.tmabs, Features.twl, Features.tzc, Features.tslpch2, Features.tcard, Features.twamp];
     label = [label; 0];
            
     Features = GetSigFeatures(data_open(startsample:endsample,:), sF, 'None', featID);
     FeatureData = [FeatureData; Features.tmabs, Features.twl, Features.tzc, Features.tslpch2, Features.tcard, Features.twamp];
     label = [label; 1];
        
                
     Features = GetSigFeatures(data_close(startsample:endsample,:), sF, 'None', featID);
     FeatureData = [FeatureData; Features.tmabs, Features.twl, Features.tzc, Features.tslpch2, Features.tcard, Features.twamp];
     label = [label; 2];
     
     Features = GetSigFeatures(data_flex(startsample:endsample,:), sF, 'None', featID);
     FeatureData = [FeatureData; Features.tmabs, Features.twl, Features.tzc, Features.tslpch2, Features.tcard, Features.twamp];
     label = [label; 3];
     
     Features = GetSigFeatures(data_extend(startsample:endsample,:), sF, 'None', featID);
     FeatureData = [FeatureData; Features.tmabs, Features.twl, Features.tzc, Features.tslpch2, Features.tcard, Features.twamp];
     label = [label; 4];
     
     Features = GetSigFeatures(data_supernation(startsample:endsample,:), sF, 'None', featID);
     FeatureData = [FeatureData; Features.tmabs, Features.twl, Features.tzc, Features.tslpch2, Features.tcard, Features.twamp];
     label = [label; 5];
     
     Features = GetSigFeatures(data_pronation(startsample:endsample,:), sF, 'None', featID);
     FeatureData = [FeatureData; Features.tmabs, Features.twl, Features.tzc, Features.tslpch2, Features.tcard, Features.twamp];
     label = [label; 6];
     
     
     Features = GetSigFeatures(data_side_grip(startsample:endsample,:), sF, 'None', featID);
     FeatureData = [FeatureData; Features.tmabs, Features.twl, Features.tzc, Features.tslpch2, Features.tcard, Features.twamp];
     label = [label; 7];

     Features = GetSigFeatures(data_fine_grip(startsample:endsample,:), sF, 'None', featID);
     FeatureData = [FeatureData; Features.tmabs, Features.twl, Features.tzc, Features.tslpch2, Features.tcard, Features.twamp];
     label = [label; 8];
     
     
     Features = GetSigFeatures(data_agree(startsample:endsample,:), sF, 'None', featID);
     FeatureData = [FeatureData; Features.tmabs, Features.twl, Features.tzc, Features.tslpch2, Features.tcard, Features.twamp];
     label = [label; 9];
     
     
     Features = GetSigFeatures(data_pointer(startsample:endsample,:), sF, 'None', featID);
     FeatureData = [FeatureData; Features.tmabs, Features.twl, Features.tzc, Features.tslpch2, Features.tcard, Features.twamp];
     label = [label; 10];

     sample_size = sample_size-50;
     j=j+1;
     
 end
 
 
 %Creating_Models
 KNN = fitcknn(FeatureData,label,'Distance','euclidean','NumNeighbors',20); 
 LDA= fitcdiscr(FeatureData,label,'DiscrimType','linear');
 QDA=fitcdiscr(FeatureData,label,'DiscrimType','quadratic');
 ENS = fitcensemble(FeatureData,label);
 SVM=fitcecoc(FeatureData,label);
 TREE= fitctree(FeatureData,label);
 NB = fitcnb(FeatureData,label);
 
  model.KNN = KNN;
 model.LDA = LDA;
 model.QDA = QDA;
 model.ENS = ENS;
 model.SVM = SVM;
 model.TREE = TREE;
 model.NB = NB;

 disp('models are calibrated');
 
