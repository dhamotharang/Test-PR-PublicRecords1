import doxie, Gong_v2;

r := risk_indicators.Phone_Table_gongv2 (TRUE); //fcra=true
export key_phone_table_filtered_gongv2 := 
  index (r, {phone10}, {r}, Gong_v2.thor_cluster+'key::phone_table_filtered_gongv2_'+doxie.Version_SuperKey);
