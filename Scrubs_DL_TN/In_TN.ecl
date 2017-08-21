IMPORT Scrubs_DL_TN, DriversV2, ut;

// EXPORT In_TN := dataset(DriversV2.Constants.cluster + 'in::dl2::TN_Clean_updates::Superfile',
                        // Scrubs_DL_TN.Layout_In_TN,thor);

// filedate := '20160711';
EXPORT In_TN(string filedate) := DATASET(DriversV2.Constants.cluster + 'in::dl2::TN_update::'+filedate+'::cleaned', 
                                         Scrubs_DL_TN.Layout_In_TN, THOR);