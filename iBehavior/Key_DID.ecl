Import Data_Services, ut, doxie;

df := iBehavior.File_consumer_searchfile(did<>0);

export Key_DID := index(df,{did},{df},
													// Data_Services.Data_location.Prefix('NONAMEGIVEN')+
													'~thor_data400::key::iBehavior_consumer::' + doxie.Version_SuperKey + '::did');