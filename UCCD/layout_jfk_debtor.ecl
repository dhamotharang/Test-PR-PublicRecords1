export layout_jfk_debtor := record
	string20	      debtor_event_key;
	string20 				debtor_fname;
	string20 				debtor_mname;
	string20 				debtor_lname;
	string5 				debtor_name_suffix;

	string60 				debtor_status_desc := '';
	string60 				debtor_name := '';
	string10        debtor_prim_range := '';
	string2         debtor_predir := '';
	string28        debtor_prim_name := '';
	string4         debtor_addr_suffix := '';
	string2         debtor_postdir := '';
	string10        debtor_unit_desig := '';
	string8         debtor_sec_range := '';
	string25        debtor_city_name := '';
	STRING18 			  debtor_county_name := '';
	string2         debtor_st := '';
	string5         debtor_zip := '';
	string4         debtor_zip4 := '';
end;