import data_services;

#stored('production',false);

df := dataset('~thor_data400::BASE::HSS_Name_Zip_Age_Ssn4_BUILT',
		header_slimsort.Layout_Name_Age_Zip_SSN4, flat);


export key_prep_fuzzy_did := index(df,{unsigned6 d := df.did},{df},data_services.data_location.prefix() + 'thor_data400::key::hss_fz_did' + thorlib.wuid());
