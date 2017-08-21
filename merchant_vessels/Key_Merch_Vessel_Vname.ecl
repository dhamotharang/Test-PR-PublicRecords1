import doxie;

df := merchant_vessels.file_merchant_vessel_Keybuilding(name_of_vessel != '');

export Key_Merch_Vessel_Vname := index(df,{name_of_vessel},{vessel_id},'~thor_Data400::key::merchant_vessel_vname_' + doxie.Version_superkey);
