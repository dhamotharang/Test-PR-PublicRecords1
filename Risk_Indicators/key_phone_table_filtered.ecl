import doxie,data_services;

r := risk_indicators.Phone_Table (TRUE); //fcra=true
export key_phone_table_filtered := 
  index (r, {phone10}, {r}, data_services.data_location.prefix() + 'thor_data400::key::phone_table_filtered_'+doxie.Version_SuperKey);
