#stored('production',false);

df := dataset('~thor_Data400::base::hss_name_dayob_BUILT',header_slimsort.Layout_Name_dob_dayob,flat);

export key_prep_DOB_DID := index(df,{unsigned6 d := df.did},{df},'~thor_data400::key::hss_nd_did' + thorlib.wuid());