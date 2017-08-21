IMPORT Scrubs_DL_TX, DriversV2, ut;

// EXPORT In_TX := dataset(DriversV2.Constants.cluster + 'in::dl2::TX_Clean_updates::Superfile',
                        // Scrubs_DL_TX.Layout_In_TX,thor);

// filedate := '20160824';
EXPORT In_TX(string filedate) := DATASET(DriversV2.Constants.cluster + 'in::dl2::TX_update::'+filedate+'::cleaned', 
                                         Scrubs_DL_TX.Layout_In_TX, THOR);