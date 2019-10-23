IMPORT data_services, doxie;

//DF-24394: Removing a misplaced tilde from Phone Type Key attribute

inFile 	:= PhonesInfo.File_Phones_Type.Main;
	
EXPORT Key_Phones_Type := index(inFile
																,{phone}
																,{inFile}
																,Data_Services.Data_location.Prefix('NONAMEGIVEN')+'thor_data400::key::phones_type_'+doxie.Version_SuperKey);