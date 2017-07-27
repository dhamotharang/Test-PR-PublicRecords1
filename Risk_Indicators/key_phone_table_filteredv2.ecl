import Gong_v2,doxie;

r := risk_indicators.Phone_Tablev2 (TRUE); //fcra=true 
export key_phone_table_filteredv2 := 
  index (r, {phone10}, {r} ,Gong_v2.thor_cluster+'key::phone_table_filteredv2_'+doxie.Version_SuperKey);
