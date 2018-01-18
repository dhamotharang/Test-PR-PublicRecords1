import doxie, data_services;

df := busdata.File_SKA_Verified_Base(bdid != 0);

export Key_SKA_Verified_BDID := index(df,{bdid},{df},data_services.data_location.prefix('bus') + 'thor_data400::key::ska_verified_bdid_' + doxie.Version_SuperKey);
