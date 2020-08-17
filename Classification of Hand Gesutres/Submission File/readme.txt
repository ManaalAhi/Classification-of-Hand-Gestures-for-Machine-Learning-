This file contains two subfolders.

-> Experiments: 

BioPatRec: 
In order to run the experiment code, you first need to download the subject files from the BioPatRec data repository from the following link: 

https://github.com/biopatrec/biopatrec/tree/Data_Repository/10mov4chForearmUntargeted

You will then need to paste the files into the BioPatRecData subfolder. 
Once you have done so, you can open the 'Run_Classifies.m' file in MATLAB and uncomment line 10 to 111.
 This will generate the results for a select Classification Model. (Ensure that you are in the 'Experiment's File.'
In order to change Model load the file 'Classification Model.m' and go to line 150. 
You can comment that out and uncomment any single model that you would like to test. 

Trigno: 
To reproduce the Trigno results, open the 'Trigno Experiments folder in MATLAB'.
 And run the 'Run_Classifiers_tringo_data.m' file. To test a different Model, load the 'Experiment_Trigno.m' File and go to line 172. comment out the current model and uncomment the model that you would like to use. 

Application: 
The file needed to exectute the code is GUI_Trigno_Classification_System.m file will need to be run in MATLAB on a windows computer.  
First, plug the hardware into the mains, and using the Delsys Control Utility, connect four channels. 
Then open the 'application' subfolder into MATLAB in the following files:
->real_time_data_stream_plotting.m
->real_time_data_stream_plotting_test_2.m
->real_time_data_stream_plotting_test_caibration.m
change line number 27 to match the IPV4 address of your computer. This will enable you to establish a connection with the Delsys Hardware. 

Then in MATLAB run the GUI_Trigno_Classifcation_System.m file, once you have connted four sensors to the computer using the Delsys Trigno Utility
 you will be able to access the full functionality of the system. 

For offline classification, user calibration has been provided in the 'User_calibration' Subfolder, slelct one of the calibrations, 
And some sample test files have been provided under the 'Test Data' folder'. 

To Test the BioPatRec Section: Please laod the data providied in the experimental file. 






