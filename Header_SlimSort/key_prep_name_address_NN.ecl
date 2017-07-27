df := dataset('~thor_Data400::base::hss_name_address_BUILDING',header_slimsort.Layout_Name_Address,flat);

export key_prep_name_address_NN := index(df,{prim_range,prim_name,zip,sec_range,fname,
	 near_name,apt_cnt,
	 st,lname,
     mname,name_suffix,dt_last_seen,
     fl_st_count,
	 fo_small_count,
	 fl_nosec_count,
	 fl_sec_count,
	 fmls_nosec_count,
	 fmls_sec_count,did},'~thor_data400::key::file_name_addr_NN_' + thorlib.wuid());