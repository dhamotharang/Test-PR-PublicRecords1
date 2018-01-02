import doxie, data_services;

df := govdata.File_Gov_Phones_Base(bdid != 0);

export key_gov_phones_bdid := index(df,{bdid},{df},data_services.data_location.prefix() + 'thor_data400::key::gov_phones_bdid_' + doxie.Version_SuperKey);
