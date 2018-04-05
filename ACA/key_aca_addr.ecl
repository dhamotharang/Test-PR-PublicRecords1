Import doxie;

//*** Modified code to remove the ACA records due to contractual obligations and replace with 
//*** the new internal ACA file as per Jira DL-20295
df := File_ACA_Clean_New(pPersistname := '~thor_data400::persist::aca::file_aca_clean_new::hri');

export key_aca_addr := index(df,{prim_name, prim_range, zip, sec_range}, {df}, '~thor_Data400::key::aca_institutions_addr_' + doxie.Version_SuperKey);
