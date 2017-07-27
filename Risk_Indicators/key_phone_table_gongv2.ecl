
import doxie,gong_v2;

r := risk_indicators.Phone_Table_gongv2();

export key_phone_table_gongv2 := index(r,{phone10},{r},gong_v2.thor_cluster+'key::phone_table_gongv2_'+doxie.Version_SuperKey);
