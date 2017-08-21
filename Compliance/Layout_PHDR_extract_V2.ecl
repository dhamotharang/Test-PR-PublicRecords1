
			rec_PHDR_slim_V2 :=
				RECORD
					unsigned6 did := 0;
					unsigned6 rid;
					unsigned8 persistent_record_ID := 0;
					unsigned8 rawaid;
					string2		src;
					unsigned3 dt_first_seen;
					unsigned3 dt_last_seen;
					unsigned3 dt_vendor_last_reported;
					unsigned3 dt_vendor_first_reported;
					unsigned3 dt_nonglb_last_seen;
					
					string1      rec_type;		//for DL sources this will identify current/expired/other license status
					qstring18    vendor_id;		//for DL sources this will contain the DL Number
					
					string1     tnt := '';	//See Header.layout_header_v2 (D = Dead)
					string1 		valid_ssn;
					string1 		valid_dob := '';

					qstring9 	ssn;
					integer4 	dob;
					qstring20 fname;
					qstring20 mname;
					qstring20 lname;
					qstring5 	name_suffix;
					qstring10 prim_range;
					string2 	predir;
					qstring28 prim_name;
					qstring4 	suffix;
					string2 	postdir;
					qstring10 unit_desig;
					qstring8 	sec_range;
					qstring25 city_name;
					string2 	st;
					qstring5 	zip;
					qstring4 	zip4;
					string		DID_segment := '';
					
					string8 DOD_from_LNDMF := '';	//August 2016
					string2 src_from_LNDMF := '';	//August 2016
					string  rec_src_from_LNDMF := '';	//August 2016
				END;

EXPORT Layout_PHDR_extract_V2 := rec_PHDR_slim_V2;