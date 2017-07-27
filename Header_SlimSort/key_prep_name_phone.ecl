df := dataset('~thor_Data400::base::hss_name_phone_BUILDING',header_slimsort.Layout_Name_Phone,flat);

export key_prep_name_phone := index(df,{phone, fname, lname, mname, name_suffix,
	 phone_dids, phone_fname_dids,
	 phone_fname_suffix_dids, phone_fullname_dids,
	 did},'~thor_data400::key::file_name_phone_' + thorlib.wuid());