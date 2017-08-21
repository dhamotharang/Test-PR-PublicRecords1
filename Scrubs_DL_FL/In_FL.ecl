IMPORT Scrubs_DL_FL, DriversV2, ut;

// Uncomment this code to run scrubs on all of the input files rather than just the raw new file
// EXPORT In_FL := dataset(DriversV2.Constants.cluster + 'in::dl2::FL_clean_updates::superfile',	Scrubs_DL_FL.Layout_In_FL,thor);

EXPORT In_FL(string filedate) := DATASET(DriversV2.Constants.cluster + 'in::dl2::FL_update::'+filedate+'::cleaned', 
                                         Scrubs_DL_FL.Layout_In_FL, THOR);