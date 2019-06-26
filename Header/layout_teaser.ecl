// layout for teaser base file
export layout_teaser := RECORD

		Layout_Header.title;
		Layout_Header.fname;
		Layout_Header.mname;
		Layout_Header.lname;
		Layout_Header.name_suffix;
		Layout_Header.dt_first_seen;
		Layout_Header.dt_last_seen;
		Layout_Header.dt_vendor_last_reported;
		Layout_Header.dt_vendor_first_reported;
		Layout_Header.prim_range;		
		Layout_Header.prim_name;		
		Layout_Header.sec_range;		
		Layout_Header.city_name;
		Layout_Header.st;
		Layout_Header.zip;
		Layout_Header.zip4;
		Layout_Header.dob;
		integer4 dod := 0;
		Layout_Header.did;
		boolean bestAddr := false;
		boolean isCurrent := false;
		unsigned2 totalRecords := 0;
		unsigned1 nameOrder := 0;
		//CCPA-101 add 2 CCPA new fields
		UNSIGNED4			global_sid := 0;
		UNSIGNED8			record_sid := 0;

END;