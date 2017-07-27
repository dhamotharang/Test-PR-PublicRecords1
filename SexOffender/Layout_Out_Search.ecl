import address;

export Layout_Out_Search := record
   string16 	seisint_primary_key := '';
   string8 		dt_last_reported := '';
   string2 		vendor_code := '';
   string20 	source_file := '';
   string2 		orig_state := '';
   string50 	name_orig := '';
   string1 		name_type := '';
   string9 		ssn := '';
   string8 		dob := '';
   string8 		dob_aka := '';
   string125 	registration_address_1 := '';
   string45 	registration_address_2 := '';
   string35 	registration_address_3 := '';
   string35 	registration_address_4 := '';
   string35 	registration_address_5 := '';
   string10		registration_home_phone := '';	//new field added
   string10		registration_cell_phone := '';	//new field added
   string73 	pname := '';
   string5		title := '';
   string20		fname := '';
   string20		mname := '';
   string20		lname := '';
   string5		name_suffix := '';
   SexOffender.Layout_Address_Clean_Components_Altered;
   unsigned8 	rawaid := 0;
   string12		did := '';
   string3		did_score := '';
   string9		ssn_appended := '';
   unsigned1	ssn_perms := 0;
end;