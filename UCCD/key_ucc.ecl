import doxie,data_services;

df := uccd.Joined_For_Key_UCCKey;

export key_ucc := index(df,{ucc_key},{df},data_services.data_location.prefix() + 'thor_data400::key::ucc_key_' + doxie.Version_SuperKey);