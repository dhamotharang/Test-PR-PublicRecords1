IMPORT header;
h := header.File_Headers;
hh := header.File_HHID;

EXPORT Layout_household := RECORD
	h.lname;
	h.prim_range;
	h.prim_name;
	h.sec_range;
	h.zip;
	h.st;
	hh.hhid_relat;
	UNSIGNED4 hhid_cnt := 0;
	UNSIGNED4 hhid_nosec_cnt := 0;
END;