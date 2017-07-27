IMPORT ut, riskwise, american_student_list, models, easi, fcra_opt_out;

EXPORT getAllBocaShellData_ExperianFCRA (
  GROUPED DATASET (layout_bocashell_neutral) ids_wide, //if IsFCRA ids_wide also contains corr. flags
  GROUPED DATASET (Layout_Boca_Shell) p
) := FUNCTION
	
	bsversion := 3;  // experian is using rv attributes version 3
	
	// myGetDate := iid_constants.myGetDate(history_date);	// full history date
	checkDays(string8 d1, string8 d2, unsigned2 days) := ut.DaysApart(d1,d2) <= days and d1>d2;

  // =============== Get Property Info ===============
  layout_PropertyRecord get_addresses(p le, integer c) := TRANSFORM
    SELF.fname := le.Shell_Input.fname;
    SELF.lname := le.Shell_Input.lname;

    SELF.prim_range := CHOOSE(c,le.Address_Verification.Input_Address_Information.prim_range,
																le.Address_Verification.Address_History_1.prim_range,
																le.Address_Verification.Address_History_2.prim_range);
    SELF.prim_name := CHOOSE (c,le.Address_Verification.Input_Address_Information.prim_name,
																le.Address_Verification.Address_History_1.prim_name,
																le.Address_Verification.Address_History_2.prim_name);
    SELF.st := CHOOSE(c,le.Address_Verification.Input_Address_Information.st,
												le.Address_Verification.Address_History_1.st,
												le.Address_Verification.Address_History_2.st);
		SELF.city_name := CHOOSE(c,le.Address_Verification.Input_Address_Information.city_name,
												le.Address_Verification.Address_History_1.city_name,
												le.Address_Verification.Address_History_2.city_name);
	  SELF.zip5 := CHOOSE(c,le.Address_Verification.Input_Address_Information.zip5,
													le.Address_Verification.Address_History_1.zip5,
													le.Address_Verification.Address_History_2.zip5);
  	SELF.predir := CHOOSE(c,le.Address_Verification.Input_Address_Information.predir,
														le.Address_Verification.Address_History_1.predir,
														le.Address_Verification.Address_History_2.predir);
	  SELF.postdir := CHOOSE(c,le.Address_Verification.Input_Address_Information.postdir,
														 le.Address_Verification.Address_History_1.postdir,
														 le.Address_Verification.Address_History_2.postdir);
	  SELF.addr_suffix := CHOOSE(c,le.Address_Verification.Input_Address_Information.addr_suffix,
																 le.Address_Verification.Address_History_1.addr_suffix,
																 le.Address_Verification.Address_History_2.addr_suffix);
	  SELF.sec_range := CHOOSE(c,le.Address_Verification.Input_Address_Information.sec_range,
															 le.Address_Verification.Address_History_1.sec_range,
															 le.Address_Verification.Address_History_2.sec_range);
	  SELF.county := CHOOSE(c,le.Address_Verification.Input_Address_Information.county,
														le.Address_Verification.Address_History_1.county,
														le.Address_Verification.Address_History_2.county);
	  SELF.geo_blk := CHOOSE(c,le.Address_Verification.Input_Address_Information.geo_blk,
														 le.Address_Verification.Address_History_1.geo_blk,
														 le.Address_Verification.Address_History_2.geo_blk);
	  SELF.hr_address := CHOOSE(c,le.Address_Verification.Input_Address_Information.hr_address,
																le.Address_Verification.Address_History_1.hr_address,
																le.Address_Verification.Address_History_2.hr_address);// was not being passed through
    SELF.did := le.did;
    SELF.seq := le.seq;
		self.historydate := le.historydate;
    SELF := [];
  END;
  p_address := NORMALIZE(p,3,get_addresses (LEFT,COUNTER))(prim_name != '', zip5 != '');

  ids_full := project (ids_wide, transform (Layout_BocaShell_neutral_ids, self := left));
	pre_ids_only := dedup(sort(ids_wide, seq, did), seq, did);
  ids_only := project(pre_ids_only, transform(layout_boca_shell_ids, self := left));
	
	ids_only_derogs := project(pre_ids_only, 
						transform(layouts.layout_derogs_input, 
						self.did := left.shell_input.did; 
						self.insurance_bk_filter := false; // hard coding for Experian Batch feed version
						self := left));
	
  // without history date
  single_property := Risk_Indicators.Boca_Shell_Property_FCRA (p_address, ids_only) ;
 
  // Generate the totals
  Per_Property_Rolled := Risk_Indicators.Roll_Applicant_Property(Single_Property(property_status_applicant<>' '));

	// Apply the address specific information
	Layout_Boca_Shell check_best(Layout_Boca_Shell le, Single_Property ri) :=
	TRANSFORM
		Input_match := LE.Address_Verification.Input_Address_Information.prim_range=RI.prim_range AND
					LE.Address_Verification.Input_Address_Information.prim_name=RI.prim_name AND
					LE.Address_Verification.Input_Address_Information.zip5=RI.zip5 AND
					LE.Address_Verification.Input_Address_Information.sec_range=RI.sec_range;
		Hist1_Match := LE.Address_Verification.Address_History_1.prim_range=RI.prim_range AND
					LE.Address_Verification.Address_History_1.prim_name=RI.prim_name AND
					LE.Address_Verification.Address_History_1.zip5=RI.zip5 AND
					LE.Address_Verification.Address_History_1.sec_range=RI.sec_range;
		Hist2_Match := LE.Address_Verification.Address_History_2.prim_range=RI.prim_range AND
					LE.Address_Verification.Address_History_2.prim_name=RI.prim_name AND
					LE.Address_Verification.Address_History_2.zip5=RI.zip5 AND
					LE.Address_Verification.Address_History_2.sec_range=RI.sec_range;
	  
	
		SELF.Address_Verification.Input_Address_Information.applicant_owned := if (input_match, ri.applicant_owned, le.Address_Verification.Input_Address_Information.applicant_owned);
		SELF.Address_Verification.Input_Address_Information.family_owned := if (input_match, ri.family_owned, LE.Address_Verification.Input_Address_Information.family_owned);
		SELF.Address_Verification.Input_Address_Information.family_sold := if (input_match, ri.family_sold, LE.Address_Verification.Input_Address_Information.family_sold);
		SELF.Address_Verification.Input_Address_Information.applicant_sold := if (input_match, ri.applicant_sold, LE.Address_Verification.Input_Address_Information.applicant_sold);
		SELF.Address_Verification.Input_Address_Information.family_buy_found := if (input_match, ri.family_buy_found, LE.Address_Verification.Input_Address_Information.family_buy_found);
		SELF.Address_Verification.Input_Address_Information.applicant_buy_found := if (input_match, ri.applicant_buy_found, LE.Address_Verification.Input_Address_Information.applicant_buy_found);
		SELF.Address_Verification.Input_Address_Information.family_sale_found := if (input_match, ri.family_sale_found, LE.Address_Verification.Input_Address_Information.family_sale_found);
		SELF.Address_Verification.Input_Address_Information.applicant_sale_found := if (input_match, ri.applicant_sale_found, LE.Address_Verification.Input_Address_Information.applicant_sale_found);
		SELF.Address_Verification.Input_Address_Information.occupant_owned := if (input_match, ri.occupant_owned, LE.Address_Verification.Input_Address_Information.occupant_owned);
		SELF.Address_Verification.Input_Address_Information.purchase_date := if (input_match, ri.purchase_date, LE.Address_Verification.Input_Address_Information.purchase_date);
		SELF.Address_Verification.Input_Address_Information.built_date := if (input_match, ri.built_date, LE.Address_Verification.Input_Address_Information.built_date);
		SELF.Address_Verification.Input_Address_Information.purchase_amount := if (input_match, ri.purchase_amount, LE.Address_Verification.Input_Address_Information.purchase_amount);
		SELF.Address_Verification.Input_Address_Information.mortgage_amount := if (input_match, ri.mortgage_amount, LE.Address_Verification.Input_Address_Information.mortgage_amount);
		SELF.Address_Verification.Input_Address_Information.mortgage_date := if (input_match, ri.mortgage_date, LE.Address_Verification.Input_Address_Information.mortgage_date);
		SELF.Address_Verification.Input_Address_Information.mortgage_type := if( input_match, ri.mortgage_type, LE.Address_Verification.Input_Address_Information.mortgage_type);
		SELF.Address_Verification.Input_Address_Information.type_financing := if( input_match, ri.type_financing, LE.Address_Verification.Input_Address_Information.type_financing);
		SELF.Address_Verification.Input_Address_Information.first_td_due_date := if( input_match, ri.first_td_due_date, LE.Address_Verification.Input_Address_Information.first_td_due_date);
		SELF.Address_Verification.Input_Address_Information.assessed_amount := if (input_match, ri.assessed_amount, LE.Address_Verification.Input_Address_Information.assessed_amount);
		SELF.Address_Verification.Input_Address_Information.assessed_total_value := if (input_match, ri.assessed_total_value, LE.Address_Verification.Input_Address_Information.assessed_total_value);
		SELF.Address_Verification.Input_Address_Information.naprop := if (input_match, ri.naprop, LE.Address_Verification.Input_Address_Information.naprop);
		SELF.Address_Verification.Input_Address_Information.HR_Address := if (input_match, ri.HR_Address, LE.Address_Verification.Input_Address_Information.HR_Address);
		self.Address_Verification.Input_Address_Information.standardized_land_use_code := if (input_match, ri.standardized_land_use_code, LE.Address_Verification.Input_Address_Information.standardized_land_use_code);
		self.Address_Verification.Input_Address_Information.building_area := if (input_match, ri.building_area, LE.Address_Verification.Input_Address_Information.building_area);
		self.Address_Verification.Input_Address_Information.no_of_buildings := if (input_match, ri.no_of_buildings, LE.Address_Verification.Input_Address_Information.no_of_buildings);
		self.Address_Verification.Input_Address_Information.no_of_stories := if (input_match, ri.no_of_stories, LE.Address_Verification.Input_Address_Information.no_of_stories);
		self.Address_Verification.Input_Address_Information.assessed_value_year := if (input_match, ri.assessed_value_year, LE.Address_Verification.Input_Address_Information.assessed_value_year);
		self.Address_Verification.Input_Address_Information.no_of_rooms := if (input_match, ri.no_of_rooms, LE.Address_Verification.Input_Address_Information.no_of_rooms);
		self.Address_Verification.Input_Address_Information.no_of_bedrooms := if (input_match, ri.no_of_bedrooms, LE.Address_Verification.Input_Address_Information.no_of_bedrooms);
		self.Address_Verification.Input_Address_Information.no_of_baths := if (input_match, ri.no_of_baths, LE.Address_Verification.Input_Address_Information.no_of_baths);
		self.Address_Verification.Input_Address_Information.no_of_partial_baths := if (input_match, ri.no_of_partial_baths, LE.Address_Verification.Input_Address_Information.no_of_partial_baths);
		self.Address_Verification.Input_Address_Information.garage_type_code := if (input_match, ri.garage_type_code, LE.Address_Verification.Input_Address_Information.garage_type_code);
		self.Address_Verification.Input_Address_Information.parking_no_of_cars := if (input_match, ri.parking_no_of_cars, LE.Address_Verification.Input_Address_Information.parking_no_of_cars);
		self.Address_Verification.Input_Address_Information.style_code := if (input_match, ri.style_code, LE.Address_Verification.Input_Address_Information.style_code);
		
		SELF.Address_Verification.Address_History_1.applicant_owned := if (hist1_match, ri.applicant_owned, LE.Address_Verification.Address_History_1.applicant_owned);
		SELF.Address_Verification.Address_History_1.family_owned := if (hist1_match, ri.family_owned, LE.Address_Verification.Address_History_1.family_owned);
		SELF.Address_Verification.Address_History_1.family_sold := if (hist1_match, ri.family_sold, LE.Address_Verification.Address_History_1.family_sold);
		SELF.Address_Verification.Address_History_1.applicant_sold := if (hist1_match, ri.applicant_sold, LE.Address_Verification.Address_History_1.applicant_sold);
		SELF.Address_Verification.Address_History_1.family_buy_found := if (hist1_match, ri.family_buy_found, LE.Address_Verification.Address_History_1.family_buy_found);
		SELF.Address_Verification.Address_History_1.applicant_buy_found := if (hist1_match, ri.applicant_buy_found, LE.Address_Verification.Address_History_1.applicant_buy_found);
		SELF.Address_Verification.Address_History_1.family_sale_found := if (hist1_match, ri.family_sale_found, LE.Address_Verification.Address_History_1.family_sale_found);
		SELF.Address_Verification.Address_History_1.applicant_sale_found := if (hist1_match, ri.applicant_sale_found, LE.Address_Verification.Address_History_1.applicant_sale_found);
		SELF.Address_Verification.Address_History_1.occupant_owned := if (hist1_match, ri.occupant_owned, LE.Address_Verification.Address_History_1.occupant_owned);	// check whether this works
		SELF.Address_Verification.Address_History_1.purchase_date := if (hist1_match, ri.purchase_date, LE.Address_Verification.Address_History_1.purchase_date);
		SELF.Address_Verification.Address_History_1.built_date := if (hist1_match, ri.built_date, LE.Address_Verification.Address_History_1.built_date);
		SELF.Address_Verification.Address_History_1.purchase_amount := if (hist1_match, ri.purchase_amount, LE.Address_Verification.Address_History_1.purchase_amount);
		SELF.Address_Verification.Address_History_1.mortgage_amount := if (hist1_match, ri.mortgage_amount, LE.Address_Verification.Address_History_1.mortgage_amount);
		SELF.Address_Verification.Address_History_1.mortgage_date := if (hist1_match, ri.mortgage_date, LE.Address_Verification.Address_History_1.mortgage_date);
		SELF.Address_Verification.Address_History_1.mortgage_type := if (hist1_match, ri.mortgage_type, LE.Address_Verification.Address_History_1.mortgage_type);
		SELF.Address_Verification.Address_History_1.type_financing := if (hist1_match, ri.type_financing, LE.Address_Verification.Address_History_1.type_financing);
		SELF.Address_Verification.Address_History_1.first_td_due_date := if (hist1_match, ri.first_td_due_date, LE.Address_Verification.Address_History_1.first_td_due_date);
		SELF.Address_Verification.Address_History_1.assessed_amount := if (hist1_match, ri.assessed_amount, LE.Address_Verification.Address_History_1.assessed_amount);
		SELF.Address_Verification.Address_History_1.assessed_total_value := if (hist1_match, ri.assessed_total_value, LE.Address_Verification.Address_History_1.assessed_total_value);
		SELF.Address_Verification.Address_History_1.naprop := if (hist1_match, ri.naprop, LE.Address_Verification.Address_History_1.naprop);
		SELF.Address_Verification.Address_History_1.HR_Address := if (hist1_match, ri.HR_Address, LE.Address_Verification.Address_History_1.HR_Address);
		self.Address_Verification.Address_History_1.standardized_land_use_code := if (hist1_match, ri.standardized_land_use_code, LE.Address_Verification.Address_History_1.standardized_land_use_code);
		self.Address_Verification.Address_History_1.building_area := if (hist1_match, ri.building_area, LE.Address_Verification.Address_History_1.building_area);
		self.Address_Verification.Address_History_1.no_of_buildings := if (hist1_match, ri.no_of_buildings, LE.Address_Verification.Address_History_1.no_of_buildings);
		self.Address_Verification.Address_History_1.no_of_stories := if (hist1_match, ri.no_of_stories, LE.Address_Verification.Address_History_1.no_of_stories);
		self.Address_Verification.Address_History_1.assessed_value_year := if (hist1_match, ri.assessed_value_year, LE.Address_Verification.Address_History_1.assessed_value_year);
		self.Address_Verification.Address_History_1.no_of_rooms := if (hist1_match, ri.no_of_rooms, LE.Address_Verification.Address_History_1.no_of_rooms);
		self.Address_Verification.Address_History_1.no_of_bedrooms := if (hist1_match, ri.no_of_bedrooms, LE.Address_Verification.Address_History_1.no_of_bedrooms);
		self.Address_Verification.Address_History_1.no_of_baths := if (hist1_match, ri.no_of_baths, LE.Address_Verification.Address_History_1.no_of_baths);
		self.Address_Verification.Address_History_1.no_of_partial_baths := if (hist1_match, ri.no_of_partial_baths, LE.Address_Verification.Address_History_1.no_of_partial_baths);
		self.Address_Verification.Address_History_1.garage_type_code := if (hist1_match, ri.garage_type_code, LE.Address_Verification.Address_History_1.garage_type_code);
		self.Address_Verification.Address_History_1.parking_no_of_cars := if (hist1_match, ri.parking_no_of_cars, LE.Address_Verification.Address_History_1.parking_no_of_cars);
		self.Address_Verification.Address_History_1.style_code := if (hist1_match, ri.style_code, LE.Address_Verification.Address_History_1.style_code);

		SELF.Address_Verification.Address_History_2.applicant_owned := if (hist2_match, ri.applicant_owned, LE.Address_Verification.Address_History_2.applicant_owned);
		SELF.Address_Verification.Address_History_2.family_owned := if (hist2_match, ri.family_owned, LE.Address_Verification.Address_History_2.family_owned);
		SELF.Address_Verification.Address_History_2.family_sold := if (hist2_match, ri.family_sold, LE.Address_Verification.Address_History_2.family_sold);
		SELF.Address_Verification.Address_History_2.applicant_sold := if (hist2_match, ri.applicant_sold, LE.Address_Verification.Address_History_2.applicant_sold);
		SELF.Address_Verification.Address_History_2.family_buy_found := if (hist2_match, ri.family_buy_found, LE.Address_Verification.Address_History_2.family_buy_found);
		SELF.Address_Verification.Address_History_2.applicant_buy_found := if (hist2_match, ri.applicant_buy_found, LE.Address_Verification.Address_History_2.applicant_buy_found);
		SELF.Address_Verification.Address_History_2.family_sale_found := if (hist2_match, ri.family_sale_found, LE.Address_Verification.Address_History_2.family_sale_found);
		SELF.Address_Verification.Address_History_2.applicant_sale_found := if (hist2_match, ri.applicant_sale_found, LE.Address_Verification.Address_History_2.applicant_sale_found);
		SELF.Address_Verification.Address_History_2.occupant_owned := if (hist2_match, ri.occupant_owned, LE.Address_Verification.Address_History_2.occupant_owned);	// check whether this works
		SELF.Address_Verification.Address_History_2.purchase_date := if (hist2_match, ri.purchase_date, LE.Address_Verification.Address_History_2.purchase_date);
		SELF.Address_Verification.Address_History_2.built_date := if (hist2_match, ri.built_date, LE.Address_Verification.Address_History_2.built_date);
		SELF.Address_Verification.Address_History_2.purchase_amount := if (hist2_match, ri.purchase_amount, LE.Address_Verification.Address_History_2.purchase_amount);
		SELF.Address_Verification.Address_History_2.mortgage_amount := if (hist2_match, ri.mortgage_amount, LE.Address_Verification.Address_History_2.mortgage_amount);
		SELF.Address_Verification.Address_History_2.mortgage_date := if (hist2_match, ri.mortgage_date, LE.Address_Verification.Address_History_2.mortgage_date);
		SELF.Address_Verification.Address_History_2.mortgage_type := if (hist2_match, ri.mortgage_type, LE.Address_Verification.Address_History_2.mortgage_type);
		SELF.Address_Verification.Address_History_2.type_financing := if (hist2_match, ri.type_financing, LE.Address_Verification.Address_History_2.type_financing);
		SELF.Address_Verification.Address_History_2.first_td_due_date := if (hist2_match, ri.first_td_due_date, LE.Address_Verification.Address_History_2.first_td_due_date);
		SELF.Address_Verification.Address_History_2.assessed_amount := if (hist2_match, ri.assessed_amount, LE.Address_Verification.Address_History_2.assessed_amount);
		SELF.Address_Verification.Address_History_2.assessed_total_value := if (hist2_match, ri.assessed_total_value, LE.Address_Verification.Address_History_2.assessed_total_value);
		SELF.Address_Verification.Address_History_2.naprop := if (hist2_match, ri.naprop, LE.Address_Verification.Address_History_2.naprop);
		SELF.Address_Verification.Address_History_2.HR_Address := if (hist2_match, ri.HR_Address, LE.Address_Verification.Address_History_2.HR_Address);
		// edina shell will not get these but populate internally for consistency with other 2 addresses
		self.Address_Verification.Address_History_2.standardized_land_use_code := if (hist2_match, ri.standardized_land_use_code, LE.Address_Verification.Address_History_2.standardized_land_use_code);
		self.Address_Verification.Address_History_2.building_area := if (hist2_match, ri.building_area, LE.Address_Verification.Address_History_2.building_area);
		self.Address_Verification.Address_History_2.no_of_buildings := if (hist2_match, ri.no_of_buildings, LE.Address_Verification.Address_History_2.no_of_buildings);
		self.Address_Verification.Address_History_2.no_of_stories := if (hist2_match, ri.no_of_stories, LE.Address_Verification.Address_History_2.no_of_stories);
		self.Address_Verification.Address_History_2.assessed_value_year := if (hist2_match, ri.assessed_value_year, LE.Address_Verification.Address_History_2.assessed_value_year);
		self.Address_Verification.Address_History_2.no_of_rooms := if (hist2_match, ri.no_of_rooms, LE.Address_Verification.Address_History_2.no_of_rooms);
		self.Address_Verification.Address_History_2.no_of_bedrooms := if (hist2_match, ri.no_of_bedrooms, LE.Address_Verification.Address_History_2.no_of_bedrooms);
		self.Address_Verification.Address_History_2.no_of_baths := if (hist2_match, ri.no_of_baths, LE.Address_Verification.Address_History_2.no_of_baths);
		self.Address_Verification.Address_History_2.no_of_partial_baths := if (hist2_match, ri.no_of_partial_baths, LE.Address_Verification.Address_History_2.no_of_partial_baths);
		self.Address_Verification.Address_History_2.garage_type_code := if (hist2_match, ri.garage_type_code, LE.Address_Verification.Address_History_2.garage_type_code);
		self.Address_Verification.Address_History_2.parking_no_of_cars := if (hist2_match, ri.parking_no_of_cars, LE.Address_Verification.Address_History_2.parking_no_of_cars);
		self.Address_Verification.Address_History_2.style_code := if (hist2_match, ri.style_code, LE.Address_Verification.Address_History_2.style_code);
		
		
		// for NON-FCRA, make sure the input DID matches the DID on the single property record before selecting the dates
		isApplicant := le.did=ri.did;
		dt_first_purchased := if( (le.other_address_info.date_first_purchase!=0 and le.other_address_info.date_first_purchase <= ri.purchase_date_by_did) or ri.purchase_date_by_did=0, 
																											le.other_address_info.date_first_purchase, ri.purchase_date_by_did);
		self.other_address_info.date_first_purchase := if(isApplicant, dt_first_purchased, le.other_address_info.date_first_purchase);
		dt_most_recent_purchase := ut.max2(le.other_address_info.date_most_recent_purchase,ri.purchase_date_by_did);
		self.other_address_info.date_most_recent_purchase := if(isApplicant, dt_most_recent_purchase, le.other_address_info.date_most_recent_purchase);
		
		myGetDate := iid_constants.myGetDate(le.historydate);
		
		// use the purchase date by did field to match the date most recent purchase field (using this field should imply that the purchase date is for the DID, so no additional checking should need to be done)
		self.other_address_info.num_purchase30 := le.other_address_info.num_purchase30 + if(isApplicant and checkDays(myGetDate,(string)ri.purchase_date_by_did,30), 1, 0);
		self.other_address_info.num_purchase90 := le.other_address_info.num_purchase90 + if(isApplicant and checkDays(myGetDate,(string)ri.purchase_date_by_did,90), 1, 0);
		self.other_address_info.num_purchase180 := le.other_address_info.num_purchase180 + if(isApplicant and checkDays(myGetDate,(string)ri.purchase_date_by_did,180), 1, 0);
		self.other_address_info.num_purchase12 := le.other_address_info.num_purchase12 + if(isApplicant and checkDays(myGetDate,(string)ri.purchase_date_by_did,ut.DaysInNYears(1)), 1, 0);
		self.other_address_info.num_purchase24 := le.other_address_info.num_purchase24 + if(isApplicant and checkDays(myGetDate,(string)ri.purchase_date_by_did,ut.DaysInNYears(2)), 1, 0);
		self.other_address_info.num_purchase36 := le.other_address_info.num_purchase36 + if(isApplicant and checkDays(myGetDate,(string)ri.purchase_date_by_did,ut.DaysInNYears(3)), 1, 0);
		self.other_address_info.num_purchase60 := le.other_address_info.num_purchase60 + if(isApplicant and checkDays(myGetDate,(string)ri.purchase_date_by_did,ut.DaysInNYears(5)), 1, 0);
		
		dt_first_sale := if(le.other_address_info.date_first_sale=0 or le.other_address_info.date_first_sale > ri.sale_date_by_did, ri.sale_date_by_did, le.other_address_info.date_first_sale);
		self.other_address_info.date_first_sale := if(isApplicant, dt_first_sale, le.other_address_info.date_first_sale);

		dt_most_recent_sale := ut.max2(le.other_address_info.date_most_recent_sale,ri.sale_date_by_did);
		self.other_address_info.date_most_recent_sale := if(isApplicant, dt_most_recent_sale, le.other_address_info.date_most_recent_sale);
		
		// use the sale date by did field to amtch the date most recent sale field (using this field should imply that the sale date is for the DID, so no additonal checking should need to be done)
		self.other_address_info.num_sold30 := le.other_address_info.num_sold30 + if(isApplicant and checkDays(myGetDate,(string)ri.sale_date_by_did,30), 1, 0);
		self.other_address_info.num_sold90 := le.other_address_info.num_sold90 + if(isApplicant and checkDays(myGetDate,(string)ri.sale_date_by_did,90), 1, 0);
		self.other_address_info.num_sold180 := le.other_address_info.num_sold180 + if(isApplicant and checkDays(myGetDate,(string)ri.sale_date_by_did,180), 1, 0);
		self.other_address_info.num_sold12 := le.other_address_info.num_sold12 + if(isApplicant and checkDays(myGetDate,(string)ri.sale_date_by_did,ut.DaysInNYears(1)), 1, 0);
		self.other_address_info.num_sold24 := le.other_address_info.num_sold24 + if(isApplicant and checkDays(myGetDate,(string)ri.sale_date_by_did,ut.DaysInNYears(2)), 1, 0);
		self.other_address_info.num_sold36 := le.other_address_info.num_sold36 + if(isApplicant and checkDays(myGetDate,(string)ri.sale_date_by_did,ut.DaysInNYears(3)), 1, 0);
		self.other_address_info.num_sold60 := le.other_address_info.num_sold60 + if(isApplicant and checkDays(myGetDate,(string)ri.sale_date_by_did,ut.DaysInNYears(5)), 1, 0);
		
		
		// distressed sale output from bocashell 3.0
		self.address_verification.recent_property_sales.sale_price1 := if(isApplicant, ri.sale_price1, le.address_verification.recent_property_sales.sale_price1);
		self.address_verification.recent_property_sales.sale_date1 := if(isApplicant, ri.sale_date1, le.address_verification.recent_property_sales.sale_date1);
		self.address_verification.recent_property_sales.prev_purch_price1 := if(isApplicant, ri.prev_purch_price1, le.address_verification.recent_property_sales.prev_purch_price1);
		self.address_verification.recent_property_sales.prev_purch_date1 := if(isApplicant, ri.prev_purch_date1, le.address_verification.recent_property_sales.prev_purch_date1);
		self.address_verification.recent_property_sales.sale_price2 := if(isApplicant, ri.sale_price2, le.address_verification.recent_property_sales.sale_price2);
		self.address_verification.recent_property_sales.sale_date2 := if(isApplicant, ri.sale_date2, le.address_verification.recent_property_sales.sale_date2);
		self.address_verification.recent_property_sales.prev_purch_price2 := if(isApplicant, ri.prev_purch_price2, le.address_verification.recent_property_sales.prev_purch_price2);
		self.address_verification.recent_property_sales.prev_purch_date2 := if(isApplicant, ri.prev_purch_date2, le.address_verification.recent_property_sales.prev_purch_date2);
		
		SELF := le;
	END;
	
	p2 := p(iid.pullidflag = '');
	pullid_recs := p(iid.pullidflag = '1');

	History_2_Property_Added_a := 
		group (sort (denormalize (p2, single_property,	left.seq = right.seq, check_best (LEFT,RIGHT)),
								 seq), seq);			 
			 
	History_2_Property_added := History_2_Property_Added_a + group(sort(pullid_recs, seq),seq);

 
  // =============== Derogs ===============

  doc_rolled := Risk_Indicators.Boca_Shell_Derogs_FCRA (ids_only_derogs, bsversion);
	

	// =============== Student File ===============
	student_rolled := Risk_Indicators.Boca_Shell_Student_FCRA (ids_only(~isrelat), bsversion);
												

	// =============== Aircraft ===============
	aircraft_rolled := Risk_Indicators.Boca_Shell_aircraft_FCRA (ids_only(~isrelat));
	
	
	// =============== AVM ===============
	avm_rolled := Risk_Indicators.Boca_Shell_AVM_FCRA (ids_wide(~isrelat));
								
								
	//=========== Gong ============
	gong_rolled := Risk_Indicators.Boca_Shell_Gong_FCRA (ids_wide(~isrelat));
																								
		// ============ Infutor =============
	infutor_rolled := Risk_Indicators.Boca_Shell_Infutor_FCRA (ids_wide(~isrelat));
																								
	// =========== Impulse ==============
	impulse_rolled := Risk_Indicators.Boca_Shell_Impulse_FCRA (ids_wide(~isrelat), bsversion);
													
// =============== put it together ===============

	
layout_boca_shell add_back_derogs(Layout_Boca_Shell le, doc_rolled ri) := TRANSFORM
	SELF.BJL := ri.BJL;
	self.liens := ri.liens;
	self.total_number_derogs := ri.bjl.criminal_count+ri.bjl.filing_count+ri.bjl.liens_historical_unreleased_count+ri.bjl.liens_recent_unreleased_count;
											
	// override the bansflag if needed here for isFCRA
	self.iid.bansflag := map(ri.BJL.filing_count > 0 => '1', 
													 le.iid.bansflag='1' and ri.BJL.filing_count < 1 => '0',
													 le.iid.bansflag);
													
	SELF := le;
END;
derogs_added_back := JOIN(History_2_Property_added, doc_rolled, LEFT.seq=RIGHT.seq, add_back_derogs(LEFT,RIGHT), LEFT OUTER, MANY LOOKUP);


Layout_Boca_Shell add_per_prop(Layout_Boca_Shell le, Per_Property_Rolled ri) := TRANSFORM
	SELF.Address_Verification.owned := ri.owned;
	SELF.Address_Verification.sold := ri.sold;
	SELF.Address_Verification.ambiguous := ri.ambiguous;
	SELF := le;
END;
property_added_back := JOIN(derogs_added_back, Per_Property_Rolled, LEFT.seq=RIGHT.seq, add_per_prop(LEFT,RIGHT), LEFT OUTER, MANY LOOKUP);

// ================ Add Back Student ================																		
Layout_Boca_Shell add_back_student(Layout_Boca_Shell le, student_rolled ri) := TRANSFORM
	SELF.student := PROJECT(ri,TRANSFORM(Riskwise.Layouts.Layout_American_Student, SELF := LEFT.student));	
	SELF := le;
END;
student_added_back := JOIN(property_added_back, student_rolled, 
													 LEFT.seq=RIGHT.seq, 
													 add_back_student(LEFT,RIGHT), LEFT OUTER, MANY LOOKUP, PARALLEL);
																			
// ================ Add Back Aircraft ================															 
Layout_Boca_Shell add_back_aircraft(Layout_Boca_Shell le, aircraft_rolled ri) := TRANSFORM
	SELF.aircraft := PROJECT(ri,TRANSFORM(Riskwise.Layouts.Layout_Aircraft, SELF := LEFT));	
	SELF := le;
END;
aircraft_added_back := JOIN(student_added_back, aircraft_rolled, 
														LEFT.seq=RIGHT.seq, 
														add_back_aircraft(LEFT,RIGHT), LEFT OUTER, MANY LOOKUP, PARALLEL);

// ================ Add Back AVM ================															 
Layout_Boca_Shell add_back_avm(Layout_Boca_Shell le, avm_rolled ri) := TRANSFORM
	SELF.AVM := PROJECT(ri,TRANSFORM(Riskwise.Layouts.Layout_AVM, SELF := LEFT));	
	SELF := le;
END;
avm_added_back := JOIN(aircraft_added_back, avm_rolled, 
											LEFT.seq=RIGHT.seq, 
											add_back_avm(LEFT,RIGHT), LEFT OUTER, MANY LOOKUP, PARALLEL);
																																						
// ============== Add Back Gong ================
Layout_Boca_Shell add_back_gong(Layout_Boca_Shell le, gong_rolled ri) := TRANSFORM
	SELF.phone_verification.gong_did := PROJECT(ri,TRANSFORM(Risk_Indicators.Layouts.Layout_Gong_DID, SELF := LEFT.gong_did));
	SELF := le;
END;
gong_added_back := JOIN(avm_added_back, gong_rolled,
																						LEFT.seq=RIGHT.seq,
																						add_back_gong(LEFT,RIGHT), LEFT OUTER, LOOKUP, PARALLEL);
																																								
// =========== Add Back Infutor ================
Layout_Boca_Shell add_back_infutor(Layout_Boca_Shell le, infutor_rolled ri) := TRANSFORM
	SELF.Infutor := PROJECT(ri,TRANSFORM(Risk_Indicators.Layouts.Layout_Infutor, SELF := LEFT));
	SELF := le;
END;
infutor_added_back := JOIN(gong_added_back, infutor_rolled,
																							LEFT.seq=RIGHT.seq,
																							add_back_infutor(LEFT,RIGHT), LEFT OUTER, LOOKUP, PARALLEL);
																			
// =========== Add Back Impulse ================
Layout_Boca_Shell add_back_impulse(Layout_Boca_Shell le, impulse_rolled ri) := TRANSFORM
	SELF.Impulse := PROJECT(ri,TRANSFORM(Risk_Indicators.Layouts.Layout_Impulse, SELF := LEFT));
	SELF := le;
END;
impulse_added_back := JOIN(infutor_added_back, impulse_rolled,
																							LEFT.seq=RIGHT.seq,
																							add_back_impulse(LEFT,RIGHT), LEFT OUTER, LOOKUP, PARALLEL);

wealth := Models.WIN704_0_0(impulse_added_back, dataset([],Easi.layout_census), isFCRA := true);

withWealth := join(impulse_added_back, wealth,
				left.seq=right.seq,
				transform(Layout_Boca_Shell, self.wealth_indicator := (string)right.wealth_indicator, self := left),
				left outer, many lookup);

bsdata_pre_optout := withWealth;

ps_opt_outs := fcra_opt_out.identify_opt_outs(ungroup(project(bsdata_pre_optout, transform(risk_indicators.Layout_Input, self := left.shell_input))) );

risk_indicators.Layout_Boca_Shell setPreScreenFlag( risk_indicators.Layout_Boca_Shell le, ps_opt_outs ri ) := TRANSFORM
	flagBit := iid_constants.SetFlag( iid_constants.IIDFlag.IsPreScreen, ri.opt_out_hit );
	self.iid.iid_flags := le.iid.iid_flags | flagBit;
	self := le;
END;
with_optout := join( bsdata_pre_optout, ps_opt_outs, left.seq=right.seq, setPreScreenFlag(left,right), keep(1), LEFT OUTER );

RETURN with_optout;

END;