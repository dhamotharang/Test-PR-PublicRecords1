IMPORT can_ph, doxie, Address,ut;

	doxie.MAC_Header_Field_Declare();
	
	// get the raw records
	raw_recs := GetRawRecords(false);

   // transform to calculate penalty 
	can_ph.layout_cwp_out add_penalty(raw_recs r) := transform
		  ListingType := r.listing_type;
			/* The listing_type field in the payload key is the indicator if the data record is Bussiness (B) or Individual/Residential (R). 
			   It was decided that Business results should not be penalised for Name & Residential/Individual records should not be penalised 
         for "Company Name".
      */
			
				
			self.penalt := if(ListingType = 'R', doxie.FN_Tra_Penalty_Name (r.firstname, r.middlename, r.lastname, FALSE),0 )+ //wildcard not allowed
											doxie.Fn_Tra_Penalty_Phone (r.phonenumber) +
											CAN_PH.FN_Tra_Penalty_Addr (R.directional, R.housenumber, R.streetname, R.streetsuffix,
																								 R.suitenumber, R.city, R.province, R.postalcode) +
										 if(ListingType = 'B', doxie.FN_Tra_Penalty_CName(r.company_name),0);
										 
										 
		// self.penalt := if(ListingType = 'R', doxie.FN_Tra_Penalty_Name (r.firstname, r.middlename, r.lastname, FALSE),0 )+ //wildcard not allowed
											// doxie.Fn_Tra_Penalty_Phone (r.phonenumber) +
											// CAN_PH.FN_Tra_Penalty_Addr (R.predir, R.prim_range, R.prim_name, R.addr_suffix,
																								 // R.sec_range, R.p_city_name, R.state, R.postalcode) +
										 // if(ListingType = 'B', doxie.FN_Tra_Penalty_CName(r.company_name),0);
			self := r;
		end;
		
    // fill the penalty field 
		f_raw := project (raw_recs, add_penalty(left));
		string city := if(city_value <> '', city_value, city_val);
		string10 phoneValue := phone_value;
		unsigned1 PhoneSize := length(trim(phoneValue, all));

		phoneOnlySearch := if (phoneValue != '' 
                       and fname_value = '' and lname_value  = '' and mname_value  = ''  
                       and city  = ''  and state_value  = '' and can_poscode_value = '',
                       true, false);

		//filter by penalty and phone
		boolean IsPhoneMatched := 
			(PhoneSize=7 AND phoneValue=f_raw.phonenumber[4..10]) OR
			(PhoneSize=10 AND phoneValue=f_raw.phonenumber) OR
			(~phoneOnlySearch AND (phoneValue='' or f_raw.phonenumber='' or
														 phoneValue[4..10] = f_raw.phonenumber or phoneValue[4..10] = f_raw.phonenumber[4..10]));

		f_flt := f_raw ((penalt<score_threshold_value) AND IsPhoneMatched);

		//dedup
		f_srt := sort(f_flt, phonenumber, lastname, firstname, middlename, housenumber, streetname, postalcode, penalt, -date_last_reported);				
		f_dep := dedup(f_srt, phonenumber, lastname, firstname, middlename, housenumber, streetname, postalcode);

		//format for output 

		f_ready := sort(f_dep, penalt, phonenumber, firstname, middlename, lastname, city, postalcode);
		
    // =============================   DEBUG  =============================		
		// output(raw_recs, named('raw_recs'));
		// output(f_raw, named('f_raw'));
		// output(phoneValue, named('phoneValue'));
		// output(PhoneSize, named('PhoneSize'));
		// output(phoneOnlySearch, named('phoneOnlySearch'));
		// output(f_flt, named('f_flt'));
		// output(f_srt, named('f_srt'));
		// output(f_dep, named('f_dep'));
		// output(f_ready, named('f_ready'));
		// =============================  END DEBUG ===========================	
		

EXPORT CanadianPhoneSearch_records := f_ready;