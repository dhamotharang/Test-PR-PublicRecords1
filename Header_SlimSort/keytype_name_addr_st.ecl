h := header_slimsort.rawfile_name_address;

export keytype_name_addr_st := 
	{h.prim_name,h.lname,h.st,h.prim_range,h.sec_range,
	 h.fname,h.mname,h.zip,h.near_name,h.name_suffix,h.dt_last_seen,
     h.fl_st_count,
	 h.fl_nosec_count,
	 h.fl_pz_count,
	 h.fl_sec_count,
	 h.fmls_nosec_count,
	 h.fmls_sec_count,h.did};