import doxie, data_services;

df := file_irs5500_base(bdid != 0);

export key_irs5500_BDID := index(df,{bdid},{df},data_services.data_location.prefix() + 'thor_data400::key::irs5500_bdid_' + doxie.Version_SuperKey);
