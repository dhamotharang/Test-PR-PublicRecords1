Import Data_Services, doxie;

//df := file_aca_clean(pPersistname := Data_Services.Data_location.Prefix('NONAMEGIVEN')+'thor_data400::persist::aca::file_aca_clean::hri');

//*** Modified code to remove the ACA records due to contractual obligations ad per Jira DL-20439
df := dataset([],aca.Layout_ACA_Clean);

//df := File_ACA_Clean_New(pPersistname := Data_Services.Data_location.Prefix('NONAMEGIVEN')+'thor_data400::persist::aca::file_aca_clean_new::hri');

export key_aca_addr := index(df,{prim_name, prim_range, zip, sec_range}, {df}, '~thor_Data400::key::aca_institutions_addr_' + doxie.Version_SuperKey);
