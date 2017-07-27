import ut, doxie, data_services;

base_file := custombanktransaction.files.base;

base_has_DID := base_file(did > 0);

file_prefix :=  
Data_Services.Data_location.Prefix('NONAMEGIVEN') + 
'thor_data400::key::chase::did_';

EXPORT key_did := index(base_has_DID,{did},{base_has_DID}, file_prefix + doxie.Version_SuperKey);