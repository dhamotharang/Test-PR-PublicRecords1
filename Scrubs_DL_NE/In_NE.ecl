IMPORT Scrubs_DL_NE, DriversV2, ut;

// EXPORT In_NE := dataset(DriversV2.Constants.cluster + 'in::dl2::NE_Clean_updates::Superfile',
                        // Scrubs_DL_NE.Layout_In_NE,thor);

EXPORT In_NE(string filedate) := DATASET(DriversV2.Constants.cluster + 'in::dl2::NE_update::'+filedate+'::cleaned', 
                                         Scrubs_DL_NE.Layout_In_NE, THOR);
                                                                          