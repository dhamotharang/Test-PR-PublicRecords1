Import DriversV2;
EXPORT In_WY_MEDCERT(string filedate) := DATASET(driversv2.constants.cluster + 'in::dl2::wy_medcert_update::'+filedate+'::cleaned', 
   																							 scrubs_dl_wy_medcert.layout_in_wy_medcert, thor);