load 1_Rest.mat;
signal_rest = Data';

load 1_Open.mat;
signal_open = Data';

load 1_Close.mat;
signal_close = Data';

load 1_Flex.mat;
signal_flex = Data';

load 1_Extend.mat;
signal_extend = Data';

load 1_Pronation.mat;
signal_pronation = Data';

load 1_Supernation.mat;
signal_supernation = Data';

load 1_Side_Grip.mat;
signal_side_grip = Data';

load 1_Fine_Grip.mat;
signal_fine_grip = Data';

load 1_Agree.mat;
signal_agree = Data';

load 1_Pointer.mat;
signal_pointer = Data';

[total_average, feature_accuracy_array]= Experiment_Trigno(signal_rest,signal_open,signal_close,signal_flex,signal_extend,signal_pronation,signal_supernation,signal_side_grip,signal_fine_grip,signal_agree,signal_pointer)


function display(total_average, feature_accuracy_array, subject_number)
%disp(subject_number);
%disp('Mean accuracy per subject:');
%disp(total_average);
%disp('Accuracy for each guesture:');
disp(feature_accuracy_array);
save('results.csv', 'feature_accuracy_array');
end

