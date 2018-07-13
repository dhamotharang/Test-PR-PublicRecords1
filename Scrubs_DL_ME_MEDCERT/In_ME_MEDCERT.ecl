IMPORT DriversV2;
EXPORT In_ME_MEDCERT(string filedate) := DATASET(DriversV2.Constants.cluster + 'in::dl2::me_medcert_update::'+filedate+'::cleaned',Scrubs_DL_ME_MEDCERT.Layout_In_ME_MEDCERT, THOR);

