import doxie, data_services;

df := header_slimsort.RawFile_Name_Zip_Age_Ssn4;

export key_fuzzy_did := index(df,{unsigned6 d := df.did},{df},data_services.data_location.prefix() + 'thor_data400::key::hss_fz_did_' + doxie.Version_SuperKey);
