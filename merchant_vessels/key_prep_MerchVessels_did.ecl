
df := file_merchant_vessel_Keybuilding;

export key_prep_MerchVessels_did := index(df(did != 0),{unsigned6 sdid := df.did},{df},'~thor_data400::key::merchant_vessel_did_' + thorlib.wuid());
