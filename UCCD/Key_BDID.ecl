import doxie,data_services;

df := uccd.Joined_For_Key_BDID;

export Key_BDID := index(df,{bdid},{df},data_services.data_location.prefix() + 'thor_data400::key::ucc_bdid_' + doxie.Version_SuperKey);
