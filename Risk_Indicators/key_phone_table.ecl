import doxie;

r := risk_indicators.Phone_Table();

export key_phone_table := index(r,{phone10},{r},'~thor_data400::key::phone_table_'+doxie.Version_SuperKey);