Import Data_Services, ut, doxie, risk_indicators,LN_PropertyV2;

EXPORT File_Prop_Ownership_FCRA_V4 := FUNCTION

	unsigned2 MAX_FARES := 100;

	pfile := Files.ln_propertyv2_search (ln_fares_id[1] != 'R', did != 0, source_code[2] = 'P', prim_name != '', zip != '');

	pslim := dedup (project(pfile, Layouts.prec), 
				 did, ln_fares_id, source_code, prim_range, prim_name, sec_range, zip, ALL);
	Layouts.proprec_fcra into_prop(pslim L, integer C) := transform
		self.own_fares_id := L.ln_fares_id;
		self.isrelat := false;
		self.did := L.did;
		self.seq := C;
		self.fname := L.fname;
		self.lname := L.lname;
		self.zip5	:= L.zip;
		self.city_name := L.v_city_name;
		self := L;
		self.applicant_owned := L.source_code[1] = 'O';
		self.applicant_sold := L.source_code[1] = 'S';
		self.fares := DATASET ([{L.ln_fares_id}], Layouts.layout_fares);
		SELF.fairs_count := 1;
		self := [];
	end;
	df3 := project(pslim, into_prop(LEFT, COUNTER));  
	//Add assessments
	Layouts.proprec_fcra add_assess(Layouts.proprec_fcra le, Files.ln_propertyv2_tax ri) := TRANSFORM
		SELF.AD := IF(ri.ln_fares_id<>'','A',le.AD);
		SELF.occupant_owned := if (ri.ln_fares_id = '', le.occupant_owned, ri.mailing_full_street_address=ri.property_full_street_address or le.occupant_owned);
		SELF.purchase_date := if((integer)ri.sale_date=0,(integer)ri.recording_date, (integer)ri.sale_date);
		SELF.purchase_date_by_did := if(le.applicant_owned,		
						if((integer)ri.sale_date=0,(integer)ri.recording_date, (integer)ri.sale_date),
								0);
		SELF.prev_purch_date1 := if(le.applicant_owned,		
								if((integer)ri.sale_date=0,(integer)ri.recording_date, (integer)ri.sale_date),
									0);
		SELF.sale_date_by_did := if(le.applicant_sold, 		
								if((integer)ri.sale_date=0,(integer)ri.recording_date, (integer)ri.sale_date),
																0);
		SELF.sale_date1 := if(le.applicant_sold, 		
							if((integer)ri.sale_date=0,(integer)ri.recording_date, (integer)ri.sale_date),
																0);
		SELF.built_date := (INTEGER)ri.year_built;
		SELF.purchase_amount := (INTEGER)ri.sales_price;
		SELF.mortgage_amount := (INTEGER)ri.mortgage_loan_amount;
		mt := trim(stringlib.stringtouppercase(ri.mortgage_loan_type_code));
		fares := le.own_fares_id[1] = 'R';	// R means Fares
		fidelity := le.own_fares_id[1] in ['O','D'];
		self.mortgage_type := risk_indicators.iid_constants.mortgage_type(fidelity, fares, mt);
		SELF.assessed_amount := (INTEGER)ri.market_total_value;
		SELF.assessed_total_value := (INTEGER)ri.assessed_total_value;
		self.standardized_land_use_code := ri.standardized_land_use_code;
		self.building_area := (INTEGER)ri.building_area;
		self.no_of_buildings := (INTEGER)ri.no_of_buildings;
		self.no_of_stories := (INTEGER)ri.no_of_stories;
		self.no_of_rooms := (INTEGER)ri.no_of_rooms;
		self.no_of_bedrooms := (INTEGER)ri.no_of_bedrooms;
		self.no_of_baths := (INTEGER)ri.no_of_baths;
		self.no_of_partial_baths := (INTEGER)ri.no_of_partial_baths;
		self.garage_type_code := ri.garage_type_code;
		self.parking_no_of_cars := (INTEGER)ri.parking_no_of_cars;
		self.style_code := ri.style_code;
		self.assessed_value_year := ri.assessed_value_year;
		self.sale_price1 := if(le.applicant_sold, (unsigned)ri.sales_price, 0);	
		self.prev_purch_price1 := if(le.applicant_owned, (unsigned)ri.sales_price, 0);	
		SELF := le;
	END;

	pre_Assessments_added := JOIN(df3,
							Files.ln_propertyv2_tax (ln_fares_id[1] != 'R'),
							LEFT.own_fares_id[2]='A' AND
							LEFT.own_fares_id=RIGHT.ln_fares_id,
							add_assess(LEFT,RIGHT), 
							LEFT OUTER);

	Layouts.proprec_fcra roll_prop_searched(Layouts.proprec_fcra le, Layouts.proprec_fcra ri, boolean addFares = FALSE) := TRANSFORM
		SELF.own_fares_id := IF (addFares, ri.own_fares_id, le.own_fares_id); // changed only in final roll-up! 
		SELF.NAPROP := max(le.naprop,ri.naprop);
		SELF.AD := IF(le.AD<>ri.AD, 'M', le.AD);
		self.occupant_owned := Le.occupant_owned or Ri.occupant_owned;
		self.applicant_owned := le.applicant_owned or Ri.applicant_owned;
		self.applicant_sold := le.applicant_sold or Ri.applicant_sold;
		purchasePicker := map(le.purchase_date = ri.purchase_date => 1, // both the same, use either one
						ri.purchase_date > le.purchase_date => 2, // use the right one
						3);	// use the left one				
		self.purchase_date := choose(purchasePicker, 	Le.purchase_date,
						ri.purchase_date,
						le.purchase_date);
		self.purchase_amount := choose(purchasePicker, 	max(Le.purchase_amount, Ri.purchase_amount),
						ri.purchase_amount,
						le.purchase_amount);
		sale1Picker := map(le.sale_date_by_did = ri.sale_date_by_did => 1,	// both the same, use either one
											 ri.sale_date_by_did > le.sale_date_by_did => 2, // use the right one
											 3);	// use the left one
		SELF.sale_date_by_did := choose(sale1Picker, max(le.sale_date_by_did,ri.sale_date_by_did),
						 ri.sale_date_by_did,
						 le.sale_date_by_did);
		SELF.sale_date1 := choose(sale1Picker, max(le.sale_date1,ri.sale_date1),
						 ri.sale_date1,
						 le.sale_date1);
		self.sale_price1 := choose(sale1Picker, max(le.sale_price1,ri.sale_price1),
						ri.sale_price1,
						le.sale_price1);
		prevPicker := map(le.purchase_date_by_did = ri.purchase_date_by_did => 1,	// both the same, use either one
											 ri.purchase_date_by_did > le.purchase_date_by_did => 2, // use the right one
											 3);	// use the left one
		SELF.purchase_date_by_did := choose(prevPicker, max(le.purchase_date_by_did,ri.purchase_date_by_did),
						ri.purchase_date_by_did,
						le.purchase_date_by_did);
		SELF.prev_purch_date1 := choose(prevPicker, max(le.prev_purch_date1,ri.prev_purch_date1),
						ri.prev_purch_date1,
						le.prev_purch_date1);		 
		self.prev_purch_price1 := choose(prevPicker, max(le.prev_purch_price1,ri.prev_purch_price1),
						 ri.prev_purch_price1,
						 le.prev_purch_price1);
		mortgagePicker := map(le.mortgage_date = ri.mortgage_date => 1,	// both the same, use either one
													ri.mortgage_date > le.mortgage_date => 2, // use the right one
													3);	// use the left one												
		nonblank(string a, string b) := if(b='', a, b);	// return the populated one, or if both populated then the right one		
		SELF.mortgage_amount := choose(mortgagePicker, max(le.mortgage_amount,ri.mortgage_amount),
						ri.mortgage_amount,
						le.mortgage_amount);
		SELF.mortgage_date := choose(mortgagePicker, le.mortgage_date,
						ri.mortgage_date,
						le.mortgage_date);
		SELF.mortgage_type := choose(mortgagePicker, nonblank(le.mortgage_type,ri.mortgage_type),		
						ri.mortgage_type,
						le.mortgage_type);	
		self.type_financing := choose(mortgagePicker, nonblank(le.type_financing,ri.type_financing),
						ri.type_financing,
						le.type_financing);
		self.first_td_due_date := choose(mortgagePicker, nonblank(le.first_td_due_date,ri.first_td_due_date),
						ri.first_td_due_date,
						le.first_td_due_date);																										
		SELF.did := ut.Min2(le.did,ri.did);
		assessPicker := map((integer)le.assessed_value_year = (integer)ri.assessed_value_year => 1,	// both the same, use either one
						(integer)ri.assessed_value_year > (integer)le.assessed_value_year => 2,	// use the right
						3);	// use the left												 
		self.built_date := choose(assessPicker, ut.Min2(le.built_date, ri.built_date),
						ri.built_date,
						le.built_date);
		self.standardized_land_use_code := choose(assessPicker, nonblank(le.standardized_land_use_code, ri.standardized_land_use_code),
						ri.standardized_land_use_code,
						le.standardized_land_use_code);
		self.building_area := choose(assessPicker, 	max(le.building_area, ri.building_area),
						ri.building_area,
						le.building_area);
		self.no_of_buildings := choose(assessPicker, 	max(le.no_of_buildings, ri.no_of_buildings),
						ri.no_of_buildings,
						le.no_of_buildings);
		self.no_of_stories := choose(assessPicker, 	max(le.no_of_stories, ri.no_of_stories),
						ri.no_of_stories,
						le.no_of_stories);
		self.no_of_rooms := choose(assessPicker, 	max(le.no_of_rooms, ri.no_of_rooms),
						ri.no_of_rooms,
						le.no_of_rooms);
		self.no_of_bedrooms := choose(assessPicker, max(le.no_of_bedrooms, ri.no_of_bedrooms),
						ri.no_of_bedrooms,
						le.no_of_bedrooms);
		self.no_of_baths := choose(assessPicker, 	max(le.no_of_baths, ri.no_of_baths),
						ri.no_of_baths,
						le.no_of_baths);
		self.no_of_partial_baths := choose(assessPicker, 	max(le.no_of_partial_baths, ri.no_of_partial_baths),
						ri.no_of_partial_baths,
						le.no_of_partial_baths);
		self.garage_type_code := choose(assessPicker, nonblank(le.garage_type_code, ri.garage_type_code),
						ri.garage_type_code,
						le.garage_type_code);
		self.parking_no_of_cars := choose(assessPicker, max(le.parking_no_of_cars, ri.parking_no_of_cars),
						ri.parking_no_of_cars,
						le.parking_no_of_cars);
		self.style_code := choose(assessPicker, nonblank(le.style_code, ri.style_code),
						ri.style_code,
						le.style_code);
		self.assessed_value_year := choose(assessPicker, 	le.assessed_value_year,
						ri.assessed_value_year,
						le.assessed_value_year);	
		self.assessed_amount := choose(assessPicker, 	max(le.assessed_amount,ri.assessed_amount),
						ri.assessed_amount,
						le.assessed_amount);
		self.assessed_total_value := choose(assessPicker, 	max(le.assessed_total_value,ri.assessed_total_value),
							ri.assessed_total_value,
							le.assessed_total_value);
		boolean addNewFair := addFares AND (le.own_fares_id <> ri.own_fares_id);
		tempMaxAdd := MAX_FARES-count(le.fares);
		SELF.fares := IF(addNewFair,le.fares+choosen(ri.fares,tempMaxAdd), le.fares);
		SELF.fairs_count := IF(addNewFair,le.fairs_count + ri.fairs_count, le.fairs_count);
		SELF := le;
	END;

	assessments_added := rollup
					 (sort (pre_assessments_added, own_fares_id, seq, prim_name, prim_range, zip5, sec_range),
						roll_prop_searched (LEFT,RIGHT), own_fares_id, seq, prim_name, prim_range, zip5, sec_range) ;

	Layouts.proprec_fcra add_deeds(Layouts.proprec_fcra le, Files.ln_propertyv2_deed Ri) := TRANSFORM
		SELF.AD := IF(ri.ln_fares_id<>'',if (Le.AD = 'A', 'M', 'D'),le.AD);
		SELF.occupant_owned := if (ri.ln_fares_id = '', le.occupant_owned, ri.mailing_street=ri.property_full_street_address or le.occupant_owned);
		deedPurchaseDate := if((integer)ri.contract_date=0,(integer)ri.recording_date, (integer)ri.contract_date);
		purchasePicker := map(le.purchase_date = deedPurchaseDate => 1, // both the same, use either one
			deedPurchaseDate > le.purchase_date => 2, // use the right one
			3);	// use the left one											
		self.purchase_date := choose(purchasePicker, 	le.purchase_date,
					deedPurchaseDate,
					le.purchase_date);
		self.purchase_amount := choose(purchasePicker, 	max(le.purchase_amount, (unsigned)ri.sales_price),
					(unsigned)ri.sales_price,
					le.purchase_amount);
		SELF.purchase_date_by_did := if(le.applicant_owned,		 
				choose(purchasePicker, 	le.purchase_date_by_did, 
					deedPurchaseDate,
					le.purchase_date_by_did),
					le.purchase_date_by_did);
		SELF.prev_purch_date1 := if(le.applicant_owned,		 
										choose(purchasePicker, 	le.prev_purch_date1,
										deedPurchaseDate,
										le.prev_purch_date1),
											le.prev_purch_date1);
		SELF.sale_date_by_did := if(le.applicant_sold,		
							choose(purchasePicker, 	le.sale_date_by_did,	
									deedPurchaseDate,
									le.sale_date_by_did),
									le.sale_date_by_did);
		SELF.sale_date1 := if(le.applicant_sold,		
								choose(purchasePicker, 	le.sale_date1,
											deedPurchaseDate,
											le.sale_date1),
											le.sale_date1);																
		deedMortgageDate := IF(ri.ln_fares_id[2]='M', 
				IF(ri.contract_date='', 
					(INTEGER) ri.recording_date,
					(INTEGER) ri.contract_date)
					,0);															
		mortgagePicker := map(le.purchase_date = deedMortgageDate => 1,	// both the same, use either one
													deedMortgageDate > le.purchase_date => 2, // use the right one
													3);	// use the left one												
		
		SELF.mortgage_date := choose(mortgagePicker, 	max(deedMortgageDate, le.purchase_date),	
							deedMortgageDate,
							le.purchase_date);				
		SELF.mortgage_amount := choose(mortgagePicker, 	max(le.mortgage_amount,(INTEGER)ri.first_td_loan_amount),
						(INTEGER)ri.first_td_loan_amount,
						le.mortgage_amount);
		mt := trim(stringlib.stringtouppercase(ri.first_td_loan_type_code));
		fares := le.own_fares_id[1] = 'R';	// R means Fares
		fidelity := le.own_fares_id[1] in ['O','D'];
		
		deedMortgageType := risk_indicators.iid_constants.mortgage_type(fidelity, fares, mt);
		
		nonblank(string a, string b) := if(b='', a, b);	// return the populated one, or if both populated then the right one
														
		self.mortgage_type := choose(mortgagePicker, 	nonblank(le.mortgage_type, deedMortgageType),
					deedMortgageType,
					le.mortgage_type);
		ft := trim(stringlib.stringtouppercase(ri.type_financing));
		self.type_financing := risk_indicators.iid_constants.type_financing(fidelity, fares, ft);
		self.first_td_due_date := ri.first_td_due_date;	
		self.sale_price1 := if(le.applicant_sold, choose(purchasePicker, 	max(le.sale_price1,(unsigned)ri.sales_price),
					(unsigned)ri.sales_price,
					le.sale_price1),
					le.sale_price1);	
		self.prev_purch_price1 := if(le.applicant_owned, choose(purchasePicker, max(le.prev_purch_price1,(unsigned)ri.sales_price),
			(unsigned)ri.sales_price,
			le.prev_purch_price1),
			le.prev_purch_price1);
		SELF := le;
	END;

	pre_Deeds_added := JOIN (assessments_added,
						Files.ln_propertyv2_deed(ln_fares_id[1] != 'R', ln_fares_id != ''),
						Left.own_fares_id[2] IN ['D','M'] and
						Left.own_fares_id = Right.ln_fares_id,
						add_deeds (Left, Right), LEFT OUTER);
	deeds_added := ROLLUP (
					SORT (pre_deeds_added, did, prim_range, prim_name, zip5, sec_range, own_fares_id),
					roll_prop_searched(LEFT,RIGHT, TRUE),
					did,
					prim_range,
					prim_name,
					zip5,
					sec_range,
					fairs_count < MAX_FARES
				);
				
	sd := sort(deeds_added(applicant_sold), did, -sale_date1, -prev_purch_date1);
	Layouts.proprec_fcra iter( Layouts.proprec_fcra le, Layouts.proprec_fcra ri ) := TRANSFORM
		self.iter_seq := if( le.did=ri.did, le.iter_seq+1, 1 );
		self := ri;
	END;
	itera := iterate( sd, iter(left,right) );	// add a seq number to each record of a DID, will keep only records 1 and 2

	Layouts.proprec_fcra into2sales(Layouts.proprec_fcra le, Layouts.proprec_fcra ri) := transform
		self.sale_price1 := le.sale_price1;
		self.sale_date1 := le.sale_date1;
		self.prev_purch_price1 := le.prev_purch_price1;
		self.prev_purch_date1 := le.prev_purch_date1;
		
		self.sale_price2 := ri.sale_price1;
		self.sale_date2 := ri.sale_date1;
		self.prev_purch_price2 := ri.prev_purch_price1;
		self.prev_purch_date2 := ri.prev_purch_date1;																
		self := le;
	end;	 
	distressed := rollup(SORT(itera(iter_seq<3),did), left.did=right.did, into2sales(left,right));		// already have 2 records per did and applicant sold recs
	Layouts.proprec_fcra fillall(deeds_added le, distressed ri) := transform
		self.sale_price1 := ri.sale_price1;
		self.sale_date1 := ri.sale_date1;
		self.prev_purch_price1 := ri.prev_purch_price1;
		self.prev_purch_date1 := ri.prev_purch_date1;	
		self.sale_price2 := ri.sale_price2;
		self.sale_date2 := ri.sale_date2;
		self.prev_purch_price2 := ri.prev_purch_price2;
		self.prev_purch_date2 := ri.prev_purch_date2;
		self := le;
	end;
	wDistressed := join(deeds_added, distressed, left.did=right.did, fillall(left,right), left outer);

	Layouts.layout_key_out_fcra to_relat_prop(wDistressed le) := TRANSFORM
		SELF.isrelat := le.isrelat;
		SELF.seq := le.seq;
		SELF.did := le.did;
		self.lname := le.lname;
		self.fname := Le.fname;
		SELF.property_status_applicant := ' ';
		SELF.property_status_family := ' ';
		SELF.property_count := 1;
		SELF.property_total := 1;
		SELF.property_owned_purchase_total := IF(le.purchase_amount < 1000, 0,
										le.purchase_amount);
		SELF.property_owned_purchase_count := (INTEGER)(le.purchase_amount >= 1000);
		SELF.property_owned_assessed_total := IF(le.assessed_amount < 1000, 0,
										le.assessed_amount);
		SELF.property_owned_assessed_count := (INTEGER)(le.assessed_amount >= 1000);
		SELF.prim_name := le.prim_name;
		SELF.prim_range := le.prim_range;
		SELF.sec_range := le.sec_range;
		SELF.zip5 := le.zip5;
		SELF.st := le.st;
		SELF.county := le.county;
		SELF.geo_blk := le.geo_blk;
		SELF.census_loose := true;
		SELF := le;
		self.datasrce := '9';
	END;

	return project(wDistressed, to_relat_prop(LEFT));

																
END;