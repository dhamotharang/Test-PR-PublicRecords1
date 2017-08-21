import doxie;

df := merchant_vessels.file_merchant_vessel_Keybuilding;

export Key_Merch_Vessel_ViD := index(df,{vessel_id},{df},'~thor_data400::key::merchant_vessel_ViD_' + doxie.Version_SuperKey);
