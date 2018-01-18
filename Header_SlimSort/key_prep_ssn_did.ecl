import data_services;

#stored('production',false);

df := dataset('~thor_Data400::base::hss_name_ssn_BUILT',header_slimsort.Layout_Name_SSN,flat);


export key_prep_ssn_did := index(df,{unsigned6 d := df.did},{df},data_services.data_location.prefix() + 'thor_data400::key::hss_ns_did' + thorlib.wuid());