import data_services;

df := dataset('~thor_data400::base::hss_name_Ssn_BUILDING',header_slimsort.Layout_Name_SSN,flat);

export key_prep_name_ssn := index(df,{ssn,fname,lname,mname,near_name,
                            name_suffix,
						    ssn_dids,ssn_fname_dids,
                            ssn_fname_suffix_dids,ssn_fullname_dids,
						    did },data_services.data_location.prefix() + 'thor_data400::key::file_name_ssn_' + thorlib.wuid());