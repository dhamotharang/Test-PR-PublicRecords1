import doxie;

r := risk_indicators.Phone_Table_v2();

export Key_Phone_Table_v2 := index(r,{phone10},{r},'~thor_data400::key::phone_table_v2_'+doxie.Version_SuperKey);
