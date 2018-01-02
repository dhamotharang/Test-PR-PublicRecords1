import doxie, data_services;

df := file_aca_clean(pPersistname := '~thor_data400::persist::aca::file_aca_clean::hri');

export key_aca_addr := index(df,{prim_name, prim_range, zip, sec_range}, {df}, data_services.data_location.prefix() + 'thor_Data400::key::aca_institutions_addr_' + doxie.Version_SuperKey);
