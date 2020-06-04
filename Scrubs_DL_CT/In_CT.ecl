IMPORT DriversV2;

EXPORT In_CT(string filedate):= DATASET(DriversV2.Constants.cluster + 'in::dl2::CT_update::'+filedate+'::cleaned', 
                                        Scrubs_DL_CT.Layout_In_CT, THOR);