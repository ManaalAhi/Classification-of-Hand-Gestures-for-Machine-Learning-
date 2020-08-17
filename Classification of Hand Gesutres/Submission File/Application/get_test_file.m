function [gesture] = get_test_file(recSession, gesture)

a = [1,1];
if gesture ==0
    signal_open = recSession.tdata(:,:,1);
    signal_open = signal_open - repmat(mean(signal_open),a);
    gesture = signal_open(19001:23000,:);
elseif gesture ==1
    signal_open = recSession.tdata(:,:,1);
    signal_open = signal_open - repmat(mean(signal_open),a);
    gesture = signal_open(25001:29000,:);

elseif gesture ==2
    signal_close = recSession.tdata(:,:,2);
    signal_close = signal_close - repmat(mean(signal_close),a);
    gesture =signal_close(25001:29000,:);

elseif gesture ==3
    signal_flex = recSession.tdata(:,:,3);
    signal_flex = signal_flex - repmat(mean(signal_flex),a);
    gesture =signal_flex(25001:29000,:);

elseif gesture ==4
    signal_extend = recSession.tdata(:,:,4);
    signal_extend = signal_extend - repmat(mean(signal_extend),a);
    gesture =signal_extend(25001:29000,:);

elseif gesture ==5
    signal_supernation = recSession.tdata(:,:,5);
    signal_supernation = signal_supernation - repmat(mean(signal_supernation),a);
    gesture =signal_supernation(25001:29000,:);

elseif gesture ==6
    signal_pronation = recSession.tdata(:,:,6);
    signal_pronation = signal_pronation - repmat(mean(signal_pronation),a);
    gesture =signal_pronation(25001:29000,:);

elseif gesture ==7
    signal_side_grip = recSession.tdata(:,:,7);
    signal_side_grip = signal_side_grip - repmat(mean(signal_side_grip),a);
    gesture =signal_side_grip(25001:29000,:);

elseif gesture ==8
    signal_fine_grip = recSession.tdata(:,:,8);
    signal_fine_grip = signal_fine_grip - repmat(mean(signal_fine_grip),a);
    gesture =signal_fine_grip(25001:29000,:);

elseif gesture ==9
    signal_agree = recSession.tdata(:,:,9);
    signal_agree = signal_agree - repmat(mean(signal_agree),a);
    gesture =signal_agree(25001:29000,:);
elseif gesture ==10
    signal_pointer = recSession.tdata(:,:,10);
    signal_pointer = signal_pointer - repmat(mean(signal_pointer),a);
   gesture = signal_pointer(25001:29000,:);

end

end
















 
 