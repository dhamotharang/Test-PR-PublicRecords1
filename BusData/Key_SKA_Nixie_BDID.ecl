import doxie, data_services;

df := busdata.File_SKA_Nixie_Base(bdid != 0);

export Key_SKA_Nixie_BDID := index(df,{bdid},{df},data_services.data_location.prefix('bus') + 'thor_data400::key::ska_nixie_bdid_' + doxie.Version_SuperKey);
