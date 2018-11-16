import doxie, data_services;

f := Business_Risk.FEIN_Table;

export key_fein_table := index(f,{fein},{f},data_services.data_location.prefix() + 'thor_data400::key::fein_table_'+doxie.Version_SuperKey);