import doxie,data_services;

r := risk_indicators.Phone_Table();

export key_phone_table := index(r,{phone10},{r},data_services.data_location.prefix() + 'thor_data400::key::phone_table_'+doxie.Version_SuperKey);