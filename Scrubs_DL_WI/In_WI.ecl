IMPORT Scrubs_DL_WI, DriversV2, ut;

// EXPORT In_WI := dataset(DriversV2.Constants.cluster + 'in::dl2::WI_Clean_updates::Superfile',
                        // Scrubs_DL_WI.Layout_In_WI,thor);

// filedate := '20160817';
EXPORT In_WI(string filedate) := DATASET(DriversV2.Constants.cluster + 'in::dl2::WI_update::'+filedate+'::cleaned', 
                                         Scrubs_DL_WI.Layout_In_WI, THOR);