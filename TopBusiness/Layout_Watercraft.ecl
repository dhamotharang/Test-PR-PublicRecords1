export Layout_Watercraft := module

 export main := module
	
	export Unlinked := record
		string2  source;
		string50 source_docid;  // watercraft_key
		// v--- vessel/registration info output in the biz rpt
	  string2	 st_registration;
	  string30 hull_number;
	  string4	 model_year;
		string30 watercraft_make_description;
	  string20 propulsion_description;
	  string5	 watercraft_length;
	  string20 use_description;
	  string50 name_of_vessel;
	  string40 registration_status_description;
	  string20 registration_number;
	  string8  registration_date;
	  string8  registration_expiration_date;
    // v--- not in biz rpt, but needed when key is built
		string1  history_flag; // contents indicate current (blank) or prior (non-blank)
	end;

	export Linked := record
		unsigned6 bid;
		string10 source_party; // name_type_code + hash of company_name.
		Unlinked;
	end;

 end; // end of main module

	export party := record
    // v--- used for party key building/linking
		string30 hull_number;
		string8  registration_date;
		string1	 history_flag;
    // v--- party type/name/address info output in the biz rpt
		string1  orig_name_type_code;
		string20 orig_name_type_description;
    string60 company_name;
    string5  title;
    string20 fname;
	  string20 mname;
	  string20 lname;
	  string5  name_suffix;
	  string10 prim_range;
	  string2  predir;
	  string28 prim_name;
	  string4  suffix;
	  string2  postdir;
	  string10 unit_desig;
	  string8  sec_range;
	  string25 city_name;
	  string2  st;
	  string5  zip5;
	  string4  zip4;
	end;

end;
