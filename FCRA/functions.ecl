IMPORT ln_propertyv2, risk_indicators, ut, SexOffender, SexOffender_Services;

EXPORT functions := MODULE


  // Returns a dataset "derived" from search, assessments and deeds overrides.
  // The content is almost identical to 
  //   ln_propertyV2.key_prop_ownership_FCRA_V4 and 
  //   ln_propertyV2.key_prop_ownership_V4
  // -- at some point we must combine all three of them consistency sake.
  export GetPropertyOwnershipOverrideFile (
    dataset (ln_propertyv2.layout_search_building) in_search,
    dataset (ln_propertyv2.layout_property_common_model_base) in_assessments,
    dataset (ln_propertyv2.layout_deed_mortgage_common_model_base) in_deeds) := function

    unsigned2 MAX_FARES := 100;

    layout_fares := RECORD
      string12 ln_fare_id;
    END;

    proprec := RECORD
      risk_indicators.Layout_Boca_Shell_ids;
      risk_indicators.Layouts.Layout_Address_Informationv3;
      string12 	own_fares_id;
      STRING1 	AD;
      string6	process_date;
      DATASET (layout_fares) fares {MAXCOUNT (MAX_FARES)};
      unsigned2 fairs_count;  // to limit child fares-dataset in rollup
      unsigned4 purchase_date_by_did;
      unsigned4 sale_date_by_did;
      Risk_Indicators.Layouts.Layout_Recent_Property_Sales;	
      unsigned4 iter_seq := 1;
    END;

    pfile := in_search;//dataset('~thor::persist::override::search',FCRA.Layout_Override_Property_Search_Out,thor,__COMPRESSED__);

    // project to slimmer record, deduping "same" properties
    prec := record
      pfile.did;
      pfile.ln_fares_id;
      pfile.fname;
      pfile.mname;
      pfile.lname;
      pfile.source_code;
      pfile.prim_range;
      pfile.predir;
      pfile.prim_name;
      pfile.suffix;
      pfile.postdir;
      pfile.unit_desig;
      pfile.sec_range;
      pfile.v_city_name;
      pfile.st;
      pfile.zip;
      pfile.county;
      pfile.geo_blk;
      pfile.process_date;
    end;
    // overrides are small; hence, no distribution
    pslim := dedup (table(pfile, prec), did, ln_fares_id, source_code, prim_range, prim_name, sec_range, zip, ALL);

    // project to main layout, also sequencing
    proprec into_prop(pslim L, integer C) := transform
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

      self.fares := DATASET ([{L.ln_fares_id}], layout_fares);
      SELF.fairs_count := 1;
      self := [];
    end;

    df3 := project(pslim, into_prop(LEFT, COUNTER));


    assessment_overrides := in_assessments;//dataset('~thor::persist::override::assessment',FCRA.Layout_Override_Assessment,thor,__COMPRESSED__);
        
    //Add assessments
    proprec add_assess(proprec le, assessment_overrides ri) := TRANSFORM
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
      // SELF.mortgage_date := (INTEGER)ri.mortgage_date; TODO: what happened to this?
      
      SELF.assessed_amount := (INTEGER)ri.market_total_value;
      SELF.assessed_total_value := (INTEGER)ri.assessed_total_value;
      
      // try adding property attributes here
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
      
      // distressed sale fields
      self.sale_price1 := if(le.applicant_sold, (unsigned)ri.sales_price, 0);	
      self.prev_purch_price1 := if(le.applicant_owned, (unsigned)ri.sales_price, 0);	
      
      SELF := le;
    END;

    pre_Assessments_added := JOIN (df3,	assessment_overrides,
                (LEFT.own_fares_id[2] = 'A') AND
                (LEFT.own_fares_id = RIGHT.ln_fares_id),
                add_assess(LEFT,RIGHT), LEFT OUTER);

    // roll to figure out latest-earliest, etc.
    proprec roll_prop_searched(proprec le, proprec ri, boolean addFares = FALSE) := TRANSFORM
      SELF.own_fares_id := IF (addFares, ri.own_fares_id, le.own_fares_id); // changed only in final roll-up! 

      SELF.NAPROP := max(le.naprop,ri.naprop);
      SELF.AD := IF(le.AD<>ri.AD, 'M', le.AD);
      self.occupant_owned := Le.occupant_owned or Ri.occupant_owned;
      self.applicant_owned := le.applicant_owned or Ri.applicant_owned;
      self.applicant_sold := le.applicant_sold or Ri.applicant_sold;

      // store unique fares_id in final roll-up (used outside for corrections/overrides)
      boolean addNewFair := addFares AND (le.own_fares_id <> ri.own_fares_id);
      SELF.fares := IF (addNewFair, le.fares + ri.fares, le.fares);
      SELF.fairs_count := IF (addNewFair, le.fairs_count + 1, le.fairs_count);
      
      // get the most recent purchase info, rather than the highest purchase info
      purchasePicker := map(le.purchase_date = ri.purchase_date => 1, // both the same, use either one
                            ri.purchase_date > le.purchase_date => 2, // use the right one
                            3);	// use the left one
                            
      self.purchase_date := choose(purchasePicker, 	Le.purchase_date,
                                                    ri.purchase_date,
                                                    le.purchase_date);
      self.purchase_amount := choose(purchasePicker, 	max(Le.purchase_amount, Ri.purchase_amount),
                                                      ri.purchase_amount,
                                                      le.purchase_amount);


    // get most recent sale info, rather than highest sale info
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
                                                  
                                                  
      
      // get most recent mortgage info, rather than highest mortgage info
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
      
      // pick the most recent assessed record we have and keep it consistent with all data
      assessPicker := map((integer)le.assessed_value_year = (integer)ri.assessed_value_year => 1,	// both the same, use either one
                          (integer)ri.assessed_value_year > (integer)le.assessed_value_year => 2,	// use the right
                          3);	// use the left
                                             
      self.built_date := choose(assessPicker, ut.Min2(le.built_date, ri.built_date),
                                              ri.built_date,
                                              le.built_date);
      
      // new property attributes stuff
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
                                                    
      SELF := le;
    END;
    assessments_added := rollup
     (sort (pre_assessments_added, own_fares_id, seq, prim_name, prim_range, zip5, sec_range, own_fares_id),
      roll_prop_searched (Left, Right), own_fares_id, seq, prim_name, prim_range, zip5, sec_range);


    deed_overrides := in_deeds;//dataset('~thor::persist::override::deed',FCRA.Layout_Override_Deed,thor);

    //Add deeds
    proprec add_deeds(proprec le, deed_overrides ri) := TRANSFORM
      SELF.AD := IF(ri.ln_fares_id<>'',if (Le.AD = 'A', 'M', 'D'),le.AD);
      SELF.occupant_owned := ri.mailing_street=ri.property_full_street_address or le.occupant_owned;
      
      // get the most recent purchase info, rather than the highest purchase info
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
      
      
      // needed a sale date per DID rather than the last address sale date, use recording date if contract date is blank
      SELF.sale_date_by_did := if(le.applicant_sold,		
                                      choose(purchasePicker, 	le.sale_date_by_did,		// purchasePicker should be the same as a salePicker here
                                                              deedPurchaseDate,
                                                              le.sale_date_by_did),
                                      le.sale_date_by_did);
      SELF.sale_date1 := if(le.applicant_sold,		
                                    choose(purchasePicker, 	le.sale_date1,
                                                            deedPurchaseDate,
                                                            le.sale_date1),
                                    le.sale_date1);
                                  
      // pick the newest mortgage info, we are assuming the recording/sale date from assessment is the mortgage date as that is the best we can go on
      deedMortgageDate := IF(ri.ln_fares_id[2]='M', 
                                IF(ri.contract_date='', 
                                  (INTEGER) ri.recording_date,
                                  (INTEGER) ri.contract_date)
                                  ,0);
                                  
      mortgagePicker := map(le.purchase_date = deedMortgageDate => 1,	// both the same, use either one
                            deedMortgageDate > le.purchase_date => 2, // use the right one
                            3);	// use the left one												
      
      SELF.mortgage_date := choose(mortgagePicker, 	max(deedMortgageDate, le.purchase_date),	// choosing between recording/sale date from assessment and recording/contract date from deed.... taking the most recent
                                                    deedMortgageDate,
                                                    le.purchase_date);		
      
      
      SELF.mortgage_amount := choose(mortgagePicker, 	max(le.mortgage_amount,(INTEGER)ri.first_td_loan_amount),
                                                      (INTEGER)ri.first_td_loan_amount,
                                                      le.mortgage_amount);
                                                      
      // remap the mortgage type field per heather and brent-------- FCRA should not have fares data in it
      mt := trim(stringlib.stringtouppercase(ri.first_td_loan_type_code));
      fares := le.own_fares_id[1] = 'R';	// R means Fares
      fidelity := le.own_fares_id[1] in ['O','D'];
      
      deedMortgageType := risk_indicators.iid_constants.mortgage_type(fidelity, fares, mt);	
      
      nonblank(string a, string b) := if(b='', a, b);	// return the populated one, or if both populated then the right one
                              
      self.mortgage_type := choose(mortgagePicker, 	nonblank(le.mortgage_type, deedMortgageType),
                                                    deedMortgageType,
                                                    le.mortgage_type);
      
      // remap the finance type per heather and brent ----- 
      ft := trim(stringlib.stringtouppercase(ri.type_financing));
      self.type_financing := risk_indicators.iid_constants.type_financing(fidelity, fares, ft);
      
      self.first_td_due_date := ri.first_td_due_date;	
      
      // distressed sale fields
      self.sale_price1 := if(le.applicant_sold, choose(purchasePicker, 	max(le.sale_price1,(unsigned)ri.sales_price),
                                                                        (unsigned)ri.sales_price,
                                                                        le.sale_price1),
                                                le.sale_price1);	// if Seller Property
      self.prev_purch_price1 := if(le.applicant_owned, choose(purchasePicker, max(le.prev_purch_price1,(unsigned)ri.sales_price),
                                                                              (unsigned)ri.sales_price,
                                                                              le.prev_purch_price1),
                                                        le.prev_purch_price1);
                  
                  
      SELF := le;
    END;

    pre_Deeds_added := JOIN (assessments_added, deed_overrides,
                             LEFT.own_fares_id[2] IN ['D','M'] and
                             LEFT.own_fares_id=RIGHT.ln_fares_id,
                             add_deeds(LEFT,RIGHT), LEFT OUTER);

    deeds_added := rollup (sort(pre_Deeds_added, did, prim_range, prim_name, zip5, sec_range),
            roll_prop_searched(LEFT,RIGHT, TRUE), did, prim_range, prim_name, zip5, sec_range);
                        
    // distressed sale sorting and picking 2 most recent
    dd := distribute(deeds_added(applicant_sold), hash(did));
    sd := sort(dd, did, -sale_date1, -prev_purch_date1, local);

    proprec iter( proprec le, proprec ri ) := TRANSFORM
      self.iter_seq := if( le.did=ri.did, le.iter_seq+1, 1 );
      self := ri;
    END;
    itera := iterate( sd, iter(left,right), local );	// add a seq number to each record of a DID, will keep only records 1 and 2



    proprec into2sales(proprec le, proprec ri) := transform
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
    distressed := rollup(itera(iter_seq<3), left.did=right.did, into2sales(left,right), local);		// already have 2 records per did and applicant sold recs

    //join so we have 3 records with all info

    proprec fillall(deeds_added le, distressed ri) := transform
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
    wDistressed := join(distribute(deeds_added, hash(did)), distribute(distressed, hash(did)), left.did=right.did, fillall(left,right), left outer, local);

            

    layout_key_out := record
      risk_indicators.Layouts.Layout_Relat_Prop_Plusv4;
      string20	fname;
      string20	lname;
      DATASET (layout_fares) fares;	
    end;

    layout_key_out to_relat_prop(wDistressed le) := TRANSFORM
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

			assessed_value := map(le.assessed_amount<>0 => le.assessed_amount,
											le.assessed_total_value<>0 => le.assessed_total_value,
											le.assessed_amount);
			
      SELF.property_owned_assessed_total := if(assessed_value < 1000, 0, assessed_value);
      SELF.property_owned_assessed_count := (INTEGER)(assessed_value >= 1000);
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

    Prop := project(wDistressed, to_relat_prop(LEFT));
		
    return Prop;
  end;
	



	export getSexOffendersIDs (unsigned6 did, 
														 dataset(fcra.Layout_override_flag) PUIDS) := function
		PUIDS_set := set(PUIDS, record_id);
		raw_spk := SexOffender.Key_SexOffender_DID(true)(keyed(did = ^.did));
		ids := dedup(sort(join(raw_spk, SexOffender.Key_SexOffender_SPK(true),
													keyed(left.seisint_primary_key = right.sspk) and (string)right.offender_persistent_id in PUIDS_set,
													atmost(SexOffender_Services.Constants.MAX_RECS_PERDID)),
											sspk),
								 sspk);
		ids_set := set(ids, sspk);
		return if(exists(PUIDS), ids_set, []);
	end;

  EXPORT checkCaseNumMinInput(STRING CaseNumber, STRING fname, 
                              STRING lname, STRING9 ssn, STRING2 state, UNSIGNED6 did) :=
    IF ((CaseNumber != '') AND 
        (DID = 0) AND 
        (fname = '' OR lname = '' OR state = '') AND 
        (LENGTH(TRIM(ssn,LEFT,RIGHT)) != 9),
        ut.constants_MessageCodes.FCRA_CASE_NUMBER_MIN_INPUT_NOT_MET,
        0 /* no error code */
       );

END;