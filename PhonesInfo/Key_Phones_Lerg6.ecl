IMPORT Data_Services, Doxie;

//DF-23660: Lerg6 Build Process
//DF-24140: Lerg6 Layout Change

inFile 	:= PhonesInfo.File_Lerg.Lerg6Main;
	
EXPORT Key_Phones_Lerg6 := index(inFile
																	,{npa, nxx, block_id}
																	,{inFile}
																	,Data_Services.Data_location.Prefix('NONAMEGIVEN')+'thor_data400::key::phones_lerg6_'+doxie.Version_SuperKey);

