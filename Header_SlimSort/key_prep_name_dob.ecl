df := dataset('~thor_Data400::base::hss_name_dayob_BUILDING',header_slimsort.layout_name_dob_dayob,flat);

export key_prep_name_dob := index(df,{mob,fname,lname,
							dayob,	
						    mname,zip,
                            dob_fnname_dids,dob_fnmname_dids,
                            dob_fnname_zip_dids,dob_fnname_dob_dids,
							did},'~thor_data400::key::file_name_dob_' + thorlib.wuid());