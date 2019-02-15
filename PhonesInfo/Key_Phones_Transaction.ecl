IMPORT data_services, doxie;

inFile 	:= PhonesInfo.File_Phones_Transaction.Main;
	
EXPORT Key_Phones_Transaction := index(inFile
																			,{phone}
																			,{inFile}
																			,Data_Services.Data_location.Prefix('NONAMEGIVEN')+'thor_data400::key::phones_transaction_'+doxie.Version_SuperKey);

