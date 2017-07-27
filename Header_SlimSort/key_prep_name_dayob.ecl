import ut;
df := dataset('~thor_Data400::base::hss_name_dayob_BUILDING',header_slimsort.layout_name_dob_dayob,flat);

export key_prep_name_dayob := index(df(~near_name),{mob,
	 dayob,
	 string2 alphinit := ut.alphinit2(fname[1],lname[1]),
	 fname,lname,mname,zip,
     dob_fnname_dids,dob_fnmname_dids,
     dob_fnname_zip_dids,dob_fnname_dob_dids,did},'~thor_data400::key::file_name_dayob_' + thorlib.wuid());