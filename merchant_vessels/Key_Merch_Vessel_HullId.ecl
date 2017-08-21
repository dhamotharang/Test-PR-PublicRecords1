import doxie;

df := merchant_vessels.file_merchant_vessel_Keybuilding(hull_number != '');

export Key_Merch_Vessel_HullId := index(df,{hull_number},{vessel_id},'~thor_data400::key::merchant_vessel_hullnum_' + doxie.Version_SuperKey);
