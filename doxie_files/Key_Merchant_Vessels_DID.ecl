import doxie;
df := File_KeyBase_MerchantVessels;

export Key_Merchant_Vessels_DID := index(df,{unsigned6 sdid := df.did},{df},'~thor_data400::key::merchant_vessel_did_' + doxie.version_superkey);