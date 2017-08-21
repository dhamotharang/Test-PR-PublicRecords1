import watchdog, business_header, address;
export Layouts :=
module
	export Vendor :=
	record
		string   indiv_id;
		string   listing_id;
		string   version_id;
		string   last_name;
		string   first_name;
		string   suffix;
		string   year_born;
		string   year_admitted;
		string   building;
		string   street;
		string   po_box;
		string   city;
		string   state;
		string   zip;
		string   born_text;
		string   lf;
	end;
	
	export Standardized :=
	RECORD
		unsigned integer6 did;
		unsigned integer1 did_score;
		Vendor rawfields;
		Address.Layout_Clean_Name;
		string8 dob;
		address.Layout_Clean182_fips	
	END;

	export DID :=
	RECORD
		unsigned integer6 did;
		unsigned integer1 did_score;
		Vendor rawfields;
		Address.Layout_Clean_Name;
		string8 dob;
		address.Layout_Clean182_fips;	
	END;

	export Out_allfields :=
	RECORD
		unsigned integer6 did;
		unsigned integer1 did_score;
		Vendor rawfields;
		Address.Layout_Clean_Name;
		string8 dob;
		address.Layout_Clean182_fips;
		watchdog.Layout_best_flags best_person_info;
		business_header.layout_bh_best best_business_info;
	END;

	watchdog_selected_fields :=
	record
		qstring10    phone := '';
		integer4     dob := 0;
		qstring10    prim_range := '';
		string2      predir := '';
		qstring28    prim_name := '';
		qstring4     suffix := '';
		string2      postdir := '';
		qstring10    unit_desig := '';
		qstring8     sec_range := '';
		qstring25    city_name := '';
		string2      st := '';
		qstring5     zip := '';
		qstring4     zip4 := '';
		unsigned3    addr_dt_last_seen := 0;
		qstring8	 	DOD := '';
	end;

	bhbest_selected_fields :=
	record
		unsigned4 dt_last_seen := 0;
		qstring120 company_name := '';
		qstring10 prim_range := '';
		string2   predir := '';
		qstring28 prim_name := '';
		qstring4  addr_suffix := '';
		string2   postdir := '';
		qstring5  unit_desig := '';
		qstring8  sec_range := '';
		qstring25 city := '';
		string2   state := '';
		unsigned3 zip := 0;
		unsigned2 zip4 := 0;
		unsigned6 phone := 0;
	end;
	
	export Out :=
	RECORD
		unsigned integer6 did;
		unsigned integer1 did_score;
		Vendor rawfields;
		Address.Layout_Clean_Name;
		string8 dob;
		address.Layout_Clean182_fips;
		watchdog_selected_fields	best_person_info;
		bhbest_selected_fields 		best_business_info;
	END;


end;