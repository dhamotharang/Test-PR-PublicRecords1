EXPORT NonRegisteredVehicles_BatchService_Layouts := MODULE

  // This is the final layout of the batch service
  EXPORT final := RECORD
    // Echo input fields here
    string20  acctno         := '';
    string20  in_name_first  := '';
    string20  in_name_middle := '';
    string20  in_name_last   := '';
    string5   in_name_suffix := '';
    string10  in_prim_range  := '';
    string2   in_predir      := '';
    string28  in_prim_name   := '';
    string4   in_addr_suffix := '';
    string2   in_postdir     := '';
    string10  in_unit_desig  := '';
    string8   in_sec_range   := '';
    string25  in_city_name   := ''; // NOTE: same as "p_city_name" on standard batch_in
    string2   in_st          := '';
    string5   in_z5          := '';
    string4   in_zip4        := '';
    string12  in_ssn         := '';
		string8   in_dob         := '';

    // *** Main output fields for each person/vehicle
    unsigned1 person_id      := 0; // 0, 1, 2, 3, etc.
    unsigned1 vehicle_id     := 0; // 0, 1, 2, 3, etc.
    string7  hit_flag        := ''; // values per reqs = NO, REJ, NON-REG or REG
    string1  current_address := ''; // Y or N; input address=best address for the person?
    string20 occupant_fname  := '';
    string20 occupant_mname  := '';
    string20 occupant_lname  := '';
    string5  occupant_suffix := '';
    string9  occupant_ssn    := ''; 
		string12 did             := '';
    string2  months_at_addr  := ''; //number of months person had been at input address
    string6  inaddr_date_first_seen := '';
    string6  inaddr_date_last_seen  := '';
		// vehicle info
		string2  registration_source  := ''; // IH=in-house MVR data; RT=Real Time MVR data
		string8	 registration_date    := '';
		string8	 expiration_Date      := '';
    string25 vin                  := '';
		string4	 vehicle_year         := '';
		string36 make                 := '';
		string30 model                := '';
		string15 color                := '';
    string10 plate                := '';
		string2  reg_state            := '';
    // Best address info for the person
		string70 best_address         := '';
		string25 best_city            := '';
    string2  best_state           := '';
    string10 best_zip             := '';
    string8  best_date_first_seen := '';
    string8  best_date_last_seen  := '';
  END;

   // This an interim layout used throughout the batch service with extra fields for joining
  EXPORT final_wextra := RECORD
    final;
   	string10 best_prim_range := '';
	  string28 best_prim_name  := '';
		string8  best_sec_range  := '';
		string30 Vehicle_Key     := '';
    // previous fields
 		string70 prev_address     := '';
    string25 prev_city_name   := ''; 
    string2  prev_st          := '';
    string5  prev_z5          := '';
	END;

END; // END of the MODULE
