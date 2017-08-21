export layout_best_address_out := record
	unsigned6    did;
	unsigned6    rid;
	string2      src;
	integer4      dt_first_seen;
	integer4      dt_last_seen;
	integer4      dt_vendor_last_reported;
	integer4      dt_vendor_first_reported;
	integer4      dt_nonglb_last_seen;
	string1      rec_type;
	qstring10     prim_range; // ?5 bytes
	string2      predir; // int1 lookup
	qstring28     prim_name;
	string4      suffix; // int1 lookup
	string2      postdir; // int1
	qstring10     unit_desig; // int1 lookup
	qstring8      sec_range; // ?
	qstring25     city_name; // ?int4 lookup?
	string2      st; // int1 lookup
	qstring5      zip; // udecimal5
	qstring4      zip4; // unsigned2
	string1      tnt := ' ';
	qstring20    fname;
	qstring20    mname;
	qstring20    lname;
	qstring5     name_suffix;
	qstring9     ssn;
	integer4     dob;
	unsigned1    best_address_number;
	unsigned1    best_address_count := 0;
end;