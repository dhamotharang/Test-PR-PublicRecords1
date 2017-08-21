//This is the original new layout without the medical certification fields
MO_Update        := DATASET(DriversV2.Constants.cluster+'in::dl2::mo_clean_updates::superfile',DriversV2.Layouts_DL_MO_New_In.Layout_MO_with_Clean,thor);
MO_Update2 := PROJECT(MO_Update,TRANSFORM(DriversV2.Layouts_DL_MO_New_In.Layout_MO_with_Clean_MedCert,SELF:=LEFT));
//This is the new layout with the medical certification fields
MO_MedCert_Update:= DATASET(DriversV2.Constants.cluster+'in::dl2::mo_medcert_clean_updates::superfile',DriversV2.Layouts_DL_MO_New_In.Layout_MO_with_Clean_MedCert,thor);

EXPORT File_DL_MO_Update := DEDUP(SORT(MO_Update2 + MO_MedCert_Update,RECORD),RECORD);