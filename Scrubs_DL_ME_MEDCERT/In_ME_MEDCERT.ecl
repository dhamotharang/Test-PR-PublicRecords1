IMPORT DriversV2,data_services;
EXPORT In_ME_MEDCERT(string filedate) := DATASET(data_services.foreign_prod+'thor_200::in::dl2::me_medcert_update::'+filedate+'::cleaned',Scrubs_DL_ME_MEDCERT.Layout_In_ME_MEDCERT, THOR);

