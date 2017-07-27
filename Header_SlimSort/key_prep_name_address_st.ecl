df := dataset('~thor_Data400::base::hss_name_address_BUILDING',header_slimsort.Layout_Name_Address,flat);

export key_prep_name_address_st := index(df,{prim_name,lname,st,prim_range,sec_range,
	 fname,mname,zip,near_name,name_suffix,dt_last_seen,
     fl_st_count,
	 fl_nosec_count,
	 fl_pz_count,
	 fl_sec_count,
	 fmls_nosec_count,
	 fmls_sec_count,did},'~thor_data400::key::file_name_address_st_' + thorlib.wuid());