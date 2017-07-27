Import Data_Services, ut, doxie;


df := iBehavior.File_consumer_searchfile(did<>0);

export Key_DID_FCRA := index(df,{did},{df},
															// Data_Services.Data_location.Prefix('NONAMEGIVEN')+
															'~thor_data400::key::fcra::iBehavior_consumer::' + doxie.Version_SuperKey + '::did');