IMPORT Scrubs_DL_CT, DriversV2, ut;

// EXPORT In_CT := dataset(DriversV2.Constants.cluster + 'in::dl2::CT_Clean_updates::Superfile',
                        // Scrubs_DL_CT.Layout_In_CT,thor);

// filedate := '20160906';
EXPORT In_CT(string filedate) := DATASET(DriversV2.Constants.cluster + 'in::dl2::CT_update::'+filedate+'::cleaned', 
                                         Scrubs_DL_CT.Layout_In_CT, THOR);