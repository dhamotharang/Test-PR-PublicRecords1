import doxie;

r := risk_indicators.Phone_Tablev2 (TRUE); //fcra=true
export key_phone_table_filteredv2 := 
  index (r, {phoneno}, {r}, '~thor_data400::key::phone_table_filteredv2_'+doxie.Version_SuperKey);
