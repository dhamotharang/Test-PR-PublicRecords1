IMPORT Scrubs_DL_NC, DriversV2, ut;

// EXPORT In_NC := dataset(DriversV2.Constants.cluster + 'in::dl2::NC_Clean_updates::Superfile',
                        // Scrubs_DL_NC.Layout_In_NC,thor);

EXPORT In_NC(string filedate) := DATASET(DriversV2.Constants.cluster + 'in::dl2::NC_update::'+filedate+'::cleaned', 
                                         Scrubs_DL_NC.Layout_In_NC, THOR);
                                                                          