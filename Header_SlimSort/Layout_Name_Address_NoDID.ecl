import header,ut;
h := header.file_headers;
export Layout_Name_Address_NoDID := record
	qstring20        fname := datalib.preferredfirstNew(h.fname, Header_Slimsort.Constants.UsePFNew);
	qstring20        mname := datalib.preferredfirstNew(h.mname, Header_Slimsort.Constants.UsePFNew);
	h.lname;
	qstring5         name_suffix := ut.Translate_Suffix(h.name_suffix);
	h.prim_range;
	h.prim_name;
	h.sec_range;
	h.zip;
	h.st;
	h.dt_last_seen;
	unsigned2		apt_cnt := 1;
	unsigned2       fl_nosec_count:=0;
    unsigned2       fl_sec_count:=0;
	unsigned2		fl_st_count:=0;
	unsigned2		fl_pz_count := 0;
	unsigned2		fo_small_count := 0;
    unsigned2       fmls_nosec_count:=0;
    unsigned2       fmls_sec_count:=0;
    unsigned1 		near_name := 0; // 0 = safe, 1 = bldg match, 2 = apt match
	//boolean			near_name := false;
	//boolean 		safe_name_zip := false;
	unsigned1		safe_name_zip := 0;// 0 = unsafe, 1 = only 1 in country, 2 = only one in 100-mile-radius

end;