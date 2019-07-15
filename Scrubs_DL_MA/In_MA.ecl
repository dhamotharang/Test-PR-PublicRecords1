IMPORT Scrubs_DL_MA, DriversV2;

//Uncomment this code to run Scrubs on all of the input files not just the current raw file.
// EXPORT In_MA := dataset(DriversV2.Constants.cluster + 'in::dl2::ma_clean_updates::superfile',	Scrubs_DL_MA.Layout_In_MA,thor);

EXPORT In_MA(string filedate) := DATASET(DriversV2.Constants.cluster + 'in::dl2::MA_update::'+filedate+'::cleaned', 
                                         Scrubs_DL_MA.Layout_In_MA, THOR);
