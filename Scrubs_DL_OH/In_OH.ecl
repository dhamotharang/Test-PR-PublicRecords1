IMPORT Scrubs_DL_OH, DriversV2, ut;

// EXPORT In_OH := dataset(DriversV2.Constants.cluster + 'in::dl2::OH_Clean_updates::Superfile',
                        // Scrubs_DL_OH.Layout_In_OH,thor);

// filedate := '20160706';
EXPORT In_OH(string filedate) := DATASET(DriversV2.Constants.cluster + 'in::dl2::OH_update::'+filedate+'::cleaned', 
                                         Scrubs_DL_OH.Layout_In_OH, THOR);