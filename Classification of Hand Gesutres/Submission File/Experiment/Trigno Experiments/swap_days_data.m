clear;

a = [1,1];
order =20;
frame = 21;
%Rest
load 2_Rest.mat;
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
load 2_Open.mat;
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
load 2_Close.mat;
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
load 2_Flex.mat;
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
load 2_Extend.mat;
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
load 2_Pronation.mat;
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
load 2_Supernation.mat;
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
load 2_Side_Grip.mat;
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
load 2_Fine_Grip.mat;
signal_fine_grip = Data';
signal_fine_grip = signal_fine_grip - repmat(mean(signal_fine_grip),a);
signal_fine_grip = sgolayfilt(signal_fine_grip,order,frame);
fine_grip_train= signal_fine_grip(1:13604,:);


load 3_Side_Grip.mat
signal_fine_grip = Data';
signal_fine_grip = signal_fine_grip - repmat(mean(signal_fine_grip),a);
signal_fine_grip = sgolayfilt(signal_fine_grip,order,frame);
fine_grip_test = signal_fine_grip(14604:19406,:);



%Agree grip
load 2_Agree.mat;
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
load 2_Pointer.mat;
signal_pointer = Data';
signal_pointer = signal_pointer - repmat(mean(signal_pointer),a);
signal_pointer = sgolayfilt(signal_pointer,order,frame);
pointer_train= signal_pointer(1:13604,:);


load 3_Pointer.mat
signal_pointer = Data';
signal_pointer = signal_pointer - repmat(mean(signal_pointer),a);
signal_pointer = sgolayfilt(signal_pointer,order,frame);
pointer_test = signal_pointer(14604:19406,:);


