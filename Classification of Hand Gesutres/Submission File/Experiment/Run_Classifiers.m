%% SCRIPT TO RUN CLASSIFIERS
% 

clear;
load 'BioPatRecData/1.mat';
[total_average, feature_accuracy_array]= Classification_Model(recSession);
display (total_average, feature_accuracy_array, 1);


% clear;
% load 'BioPatRecData/2.mat';
% [total_average, feature_accuracy_array]= Classification_Model(recSession);
% display (total_average, feature_accuracy_array,2);
% 
% clear;
% load 'BioPatRecData/3.mat';
% [total_average, feature_accuracy_array]= Classification_Model(recSession);
% display (total_average, feature_accuracy_array,3);
% 
% clear;
% load 'BioPatRecData/4.mat';
% [total_average, feature_accuracy_array]= Classification_Model(recSession);
% display (total_average, feature_accuracy_array,4);
% 
% 
% clear;
% load 'BioPatRecData/5.mat';
% [total_average, feature_accuracy_array]= Classification_Model(recSession);
% display (total_average, feature_accuracy_array,5);
% 
% clear;
% load 'BioPatRecData/6.mat';
% [total_average, feature_accuracy_array]= Classification_Model(recSession);
% display (total_average, feature_accuracy_array,6);
% 
% 
% clear;
% load 'BioPatRecData/7.mat';
% [total_average, feature_accuracy_array]= Classification_Model(recSession);
% display (total_average, feature_accuracy_array,7);
% 
% clear;
% load 'BioPatRecData/8.mat';
% [total_average, feature_accuracy_array]= Classification_Model(recSession);
% display (total_average, feature_accuracy_array,8);
% 
% clear;
% load 'BioPatRecData/9.mat';
% [total_average, feature_accuracy_array]= Classification_Model(recSession);
% display (total_average, feature_accuracy_array,9);
% 
% 
% clear;
% load 'BioPatRecData/10.mat';
% [total_average, feature_accuracy_array]= Classification_Model(recSession);
% display (total_average, feature_accuracy_array,10);
% 
% clear;
% load 'BioPatRecData/11.mat';
% [total_average, feature_accuracy_array]= Classification_Model(recSession);
% display (total_average, feature_accuracy_array,11);
% 
% clear;
% load 'BioPatRecData/12.mat';
% [total_average, feature_accuracy_array]= Classification_Model(recSession);
% display (total_average, feature_accuracy_array,12);
% 
% 
% clear;
% load 'BioPatRecData/13.mat';
% [total_average, feature_accuracy_array]= Classification_Model(recSession);
% display (total_average, feature_accuracy_array,13);
% 
% clear;
% load 'BioPatRecData/14.mat';
% [total_average, feature_accuracy_array]= Classification_Model(recSession);
% display (total_average, feature_accuracy_array,14);
% 
% clear;
% load 'BioPatRecData/15.mat';
% [total_average, feature_accuracy_array]= Classification_Model(recSession);
% display (total_average, feature_accuracy_array,15);
% 
% clear;
% load 'BioPatRecData/16.mat';
% [total_average, feature_accuracy_array]= Classification_Model(recSession);
% display (total_average, feature_accuracy_array,16);
% 
% 
% clear;
% load 'BioPatRecData/17.mat';
% [total_average, feature_accuracy_array]= Classification_Model(recSession);
% display (total_average, feature_accuracy_array,17);
% 
% 
% clear;
% load 'BioPatRecData/18.mat';
% [total_average, feature_accuracy_array]= Classification_Model(recSession);
% display (total_average, feature_accuracy_array,18);
% 
% 
% clear;
% load 'BioPatRecData/19.mat';
% [total_average, feature_accuracy_array]= Classification_Model(recSession);
% display (total_average, feature_accuracy_array,19);
% 
% 
% clear;
% load 'BioPatRecData/20.mat';
% [total_average, feature_accuracy_array]= Classification_Model(recSession);
% display (total_average, feature_accuracy_array,20);






function display(total_average, feature_accuracy_array, subject_number)
disp(subject_number);
disp('Mean accuracy per subject:');
disp(total_average);
disp('Accuracy for each guesture:');
disp(feature_accuracy_array);
save('results.csv', 'feature_accuracy_array');
end

