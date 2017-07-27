Import Data_Services, ut, doxie;


df := iBehavior.file_behavior_searchfile(IB_Individual_ID <> '');

export key_purchase_behavior := index(df,{IB_Individual_ID},{df},
																// Data_Services.Data_location.Prefix('NONAMEGIVEN')+
																'~thor_data400::key::iBehavior_behavior::' + doxie.Version_SuperKey + '::purchase_behavior');
																
