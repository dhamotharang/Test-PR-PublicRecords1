import doxie;

df := merchant_vessels.File_Merchant_Vessel_keybuilding(bdid != 0);

export Key_Merchant_Vessel_BDID := index(df,{bdid},{vessel_id},'~thor_data400::key::merchant_vessel_bdid_' + doxie.Version_SuperKey);
