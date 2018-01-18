import doxie,data_services;

r := risk_indicators.Phone_Table_v2 (TRUE); //fcra=true

export Key_Phone_Table_FCRA_v2 := index(r, {phone10}, {r}, data_services.data_location.prefix() + 'thor_data400::key::phone_table_filtered_v2_'+doxie.Version_SuperKey);