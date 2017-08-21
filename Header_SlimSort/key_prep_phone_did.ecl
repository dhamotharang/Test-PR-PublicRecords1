

df := dataset('~thor_Data400::base::hss_name_phone_BUILT',header_slimsort.Layout_Name_phone,flat);

export key_prep_phone_did := index(df,{unsigned6 d := df.did},{df},'~thor_data400::key::hss_np_did' + thorlib.wuid());