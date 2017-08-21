IMPORT Scrubs_DL_NV, DriversV2, ut;

// EXPORT In_NV := dataset(DriversV2.Constants.cluster + 'in::dl2::NV_Clean_updates::Superfile',
                        // Scrubs_DL_NV.Layout_In_NV,thor);

// filedate := '20160628';
EXPORT In_NV(string filedate) := DATASET(DriversV2.Constants.cluster + 'in::dl2::NV_update::'+filedate+'::cleaned', 
                                         Scrubs_DL_NV.Layout_In_NV, THOR);
                                                                          