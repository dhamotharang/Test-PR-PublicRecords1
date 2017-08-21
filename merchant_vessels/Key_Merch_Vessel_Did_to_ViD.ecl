import doxie;

df := merchant_vessels.file_merchant_vessel_Keybuilding(did != 0);

export Key_Merch_Vessel_Did_to_ViD := index(df,{did},{vessel_id},'~thor_Data400::key::merchant_vessel_did2vid_' + doxie.Version_SuperKey);
