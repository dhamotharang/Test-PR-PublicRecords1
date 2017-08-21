

df := dataset('~thor_Data400::base::hss_name_ssn_BUILT',header_slimsort.Layout_Name_SSN,flat);


export key_prep_ssn_did := index(df,{unsigned6 d := df.did},{df},'~thor_data400::key::hss_ns_did' + thorlib.wuid());