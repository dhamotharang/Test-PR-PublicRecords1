import doxie;

r := risk_indicators.Phone_Table (TRUE); //fcra=true
export key_phone_table_filtered := 
  index (r, {phone10}, {r}, '~thor_data400::key::phone_table_filtered_'+doxie.Version_SuperKey);
