import Address;
EXPORT layout_SexOffenderCPS_Batch_out := RECORD

	STRING20  acctno              := '';
	STRING16 	seisint_primary_key := '';
	
	STRING30  last_name           := '';
	STRING30  first_name          := '';
	STRING20  middle_name         := '';
	STRING20  name_suffix         := '';
	STRING125 address_1           := '';
	STRING45  address_2           := '';
	STRING35  address_3           := '';
	STRING8   date_last_seen      := '';
	STRING9   ssn                 := '';
	STRING10  sex                 := '';
	STRING8   dob                 := '';
	STRING40  hair_color          := '';
	STRING40  eye_color           := '';
	STRING200 scars               := '';
	STRING3   height              := '';
	STRING3   weight              := '';
	STRING30  race                := '';
	STRING30  offender_id         := '';
	STRING2   state_of_origin     := '';
			
	string340 offense_1           := '';
	string110 conviction_place_1  := '';
	string8   conviction_date_1   := '';
	string1   victim_minor_1      := '';
	string80 	conviction_jurisdiction_1 := '';
	string25 	court_case_number_1 := '';
	string8  	offense_date_1 := '';
	
	string340 offense_2           := '';
	string110 conviction_place_2  := '';
	string8   conviction_date_2   := '';
	string1   victim_minor_2      := '';	
	string80 	conviction_jurisdiction_2 := '';
	string25 	court_case_number_2 := '';
	string8  	offense_date_2 := '';
	
	string340 offense_3           := '';
	string110 conviction_place_3  := '';
	string8   conviction_date_3   := '';
	string1   victim_minor_3      := '';	
	string80 	conviction_jurisdiction_3 := '';
	string25 	court_case_number_3 := '';
	string8  	offense_date_3 := '';
	
	string340 offense_4           := '';
	string110 conviction_place_4  := '';
	string8   conviction_date_4   := '';
	string1   victim_minor_4      := '';	
	string80 	conviction_jurisdiction_4 := '';
	string25 	court_case_number_4 := '';
	string8  	offense_date_4 := '';
	
	string340 offense_5           := '';
	string110 conviction_place_5  := '';
	string8   conviction_date_5   := '';
	string1   victim_minor_5      := '';	
	string80 	conviction_jurisdiction_5 := '';
	string25 	court_case_number_5 := '';
	string8  	offense_date_5 := '';
	
	string340 offense_6           := '';
	string110 conviction_place_6  := '';
	string8   conviction_date_6   := '';
	string1   victim_minor_6      := '';	
	string80 	conviction_jurisdiction_6 := '';
	string25 	court_case_number_6 := '';
	string8  	offense_date_6 := '';
	
	string340 offense_7           := '';
	string110 conviction_place_7  := '';
	string8   conviction_date_7   := '';
	string1   victim_minor_7      := '';	
	string80 	conviction_jurisdiction_7 := '';
	string25 	court_case_number_7 := '';
	string8  	offense_date_7 := '';
	
	string340 offense_8           := '';
	string110 conviction_place_8  := '';
	string8   conviction_date_8   := '';
	string1   victim_minor_8      := '';	
	string80 	conviction_jurisdiction_8 := '';
	string25 	court_case_number_8 := '';
	string8  	offense_date_8 := '';
	
	string340 offense_9           := '';
	string110 conviction_place_9  := '';
	string8   conviction_date_9   := '';
	string1   victim_minor_9      := '';
	string80 	conviction_jurisdiction_9 := '';
	string25 	court_case_number_9 := '';
	string8  	offense_date_9 := '';
	
	string340 offense_10          := '';
	string110 conviction_place_10 := '';
	string8   conviction_date_10  := '';
	string1   victim_minor_10     := '';
	string80 	conviction_jurisdiction_10 := '';
	string25 	court_case_number_10 := '';
	string8  	offense_date_10 := '';
	
  string1   curr_incar_flag := '';
  string1   curr_parole_flag := '';
  string1   curr_probation_flag := '';
  string30 	doc_number := '';
	Address.Layout_Address_Clean_Components.prim_range;
	Address.Layout_Address_Clean_Components.predir;
	Address.Layout_Address_Clean_Components.prim_name;
	Address.Layout_Address_Clean_Components.addr_suffix;
	Address.Layout_Address_Clean_Components.postdir;
	Address.Layout_Address_Clean_Components.unit_desig;
	Address.Layout_Address_Clean_Components.sec_range;
	Address.Layout_Address_Clean_Components.p_city_name;
	Address.Layout_Address_Clean_Components.v_city_name;
	Address.Layout_Address_Clean_Components.st;
	Address.Layout_Address_Clean_Components.zip5;
	Address.Layout_Address_Clean_Components.zip4;
	Address.Layout_Address_Clean_Components.clean_errors;
  string35 	registration_county := '';

end;


