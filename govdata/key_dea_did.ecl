import doxie, data_services;

export key_dea_did := index(govdata.File_DEA_Doxie,{did,__fpos},data_services.data_location.prefix() + 'thor_data400::key::dea_did_key' + doxie.version_Keys);