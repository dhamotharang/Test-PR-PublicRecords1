IMPORT ADDRESS_CLEAN, DOXIE, DATA_SERVICES, LIB_THORLIB, UT;

//Automatic Environment Switch
SHARED prefix := ut.foreign_dataland; 
//SHARED prefix := IF(lib_thorlib.thorlib.daliservers() IN ['10.239.227.24:7070','10.241.100.151:7070'], '~', ut.foreign_dataland); 

EXPORT key_clean := INDEX(file_RawACE,{Line1, LineLast},{file_RawACE},
										prefix+'thor_data400::key::Address_Clean::clean_'+doxie.Version_SuperKey);
