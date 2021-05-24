IMPORT  DriversV2;

// EXPORT In_MI := DATASET(DriversV2.Constants.cluster + 'in::dl2::mi_clean_updates::superfile', Scrubs_DL_MI.Layout_In_MI, THOR);

EXPORT In_MI(string filedate) := DATASET(DriversV2.Constants.cluster + 'in::dl2::MI_update::'+filedate+'::cleaned', 
                                         Scrubs_DL_MI.Layout_In_MI, THOR);
                                         