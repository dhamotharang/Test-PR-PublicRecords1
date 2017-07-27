import iesp;
export Layout_Aircraft := module

	export Main := module

		export Unlinked := record
			string2  source;
			string50 source_docid;
			string8  aircraft_number; // may or may not need this depending if data team builds a new key
												 // using serial_number -- or n_number.
			string30  serial_number;
			string1  current_prior_flag;  // either A - active H - historical for faa source		
			string8  date_last_seen; // more populated than cert_issue_date and varies more
															 // than last_action_date
			string8  model_year; //  string8 	year_mfr; in data
			string20 model; // string20 model_name in data
			string8  registration_date;  // cert_issue_date in data
			string8  registration_number; // n_number					      	
			string25 	aircraft_type;
			integer   engines;
			string30 	manufacturer;  //aircraft_mfr_name;
			iesp.share.t_Address registration_address;	
			// doxie_crs/layout_Faa_Aircraft_records -current_flag -n_number -serial_number -date_last_seen
																						// -type_aircraft -prim_name - predir - addr_suffix
																						// -postdir -unit_desig -sec_range -p_city_name -v_city_name -st -zip;
		end;
		
		export Linked := record
			unsigned6 bid;
			string10 source_party;
			Unlinked;
		end;
	
	end;
	
	export Party := record
		string8  aircraft_number;
		string30 serial_number;
		string8 registration_date;
		string1 current_prior_flag;
		string8  date_last_seen; // more populated than cert_issue_date and varies more
														 // than last_action_date
		string120 company_name;
		string20 name_last;
		string20 name_first;
		string20 name_middle;
		string5 name_suffix;
		string5 name_title;
		iesp.share.t_Address address;
	end;
	
end;