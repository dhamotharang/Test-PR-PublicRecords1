
df := dataset('~thor_Data400::base::hss_name_address_BUILT',header_slimsort.Layout_Name_Address,flat);

export Key_prep_address_Did := index(df,{unsigned6 d := df.did},{df},'~thor_data400::key::hss_na_did' + thorlib.wuid());