import BIPV2, BIPV2_Files,BIPV2_Tools;

ds_in := project(BIPV2_Tools.idIntegrity().blank_above_lgid3(BIPV2.CommonBase.DS_STATIC),transform(BIPV2.CommonBase.Layout,self := left,self := []));
// ds_in := BIPV2_Tools.idIntegrity().blank_above_lgid3(BIPV2.CommonBase.DS_BASE);
// ds_in := BIPV2_Files.files_proxid().DS_PROXID_BASE;

ds_clean := BIPV2_Files.tools_dotid().reclean(ds_in);
EXPORT In_BASE := ds_clean : PERSIST('~thor_data400::persist::BIPV2_Ingest::In_BASE'); 