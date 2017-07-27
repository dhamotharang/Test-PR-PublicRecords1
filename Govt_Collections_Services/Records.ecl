IMPORT AutoStandardI, Govt_Collections_Services, STD, ut;

EXPORT Records := MODULE
	
	EXPORT BatchView( DATASET(Govt_Collections_Services.Layouts.batch_in) ds_batch_in_cleaned = DATASET([],Layouts.batch_in),
	                  DATASET(Govt_Collections_Services.Layouts.batch_in) ds_batch_in_parsed = DATASET([],Layouts.batch_in),
	                  Govt_Collections_Services.IParams.BatchParams in_mod ) := FUNCTION

		// 1. Mark any records whose address caused the Address Cleaner to throw an exception.
		// Per the product requirements, even though an address may not be cleanable, we'll continue 
		// to process that record.
		ds_batch_in := 
			PROJECT(
				ds_batch_in_cleaned,
				TRANSFORM(Govt_Collections_Services.Layouts.batch_working,
					SELF.record_err_msg := IF( LEFT.err_addr[1] = 'E', 'UNMATCHABLE DATA (ADDRESS UNCLEANABLE)', '' ),
					SELF.is_rejected_rec := FALSE,
					SELF := LEFT,
					SELF := []
				)
			);
		
		// 2. Process good input records. See Req. 4.1.2 in _documentation:
		// '...several processes [must] be run to produce the output...'. So, a waterfall process:

		//   2.a. (Req. 4.1.9) Get Best Address. 
		ds_best_address_recs := Govt_Collections_Services.fn_getBestAddressRecs(ds_batch_in, in_mod);
		
		//   2.b. (Req. 4.1.10) Add Expanded SSN. 
		ds_expanded_ssn_recs := Govt_Collections_Services.fn_getExpandedSSNRecs(ds_best_address_recs, in_mod);
		
		//   2.c. (Req. 4.1.11) Add ADL_Best. 
		ds_ADL_best_recs := Govt_Collections_Services.fn_getBestADLRecs(ds_expanded_ssn_recs, in_mod);
		
		//   2.d. (Req. 4.1.12) Add Drivers License data. 
		ds_drivers_license_recs := Govt_Collections_Services.fn_getDriversLicenseRecs(ds_ADL_best_recs, in_mod);

		ds_ranked_ssn_recs := Govt_Collections_Services.fn_getRankedSSNRecs(ds_drivers_license_recs, in_mod);
		
		//   2.f. (Req. 4.1.14) Add AKAs. 
		ds_AKA_recs := Govt_Collections_Services.fn_getAKARecs(ds_ranked_ssn_recs, in_mod);
			
		//   2.g. (Req. 4.1.15) Add Deceased...
		ds_deceased_recs := Govt_Collections_Services.fn_getDeceasedRecs(ds_AKA_recs, in_mod);

		  // 2.h. (Req. 4.1.16) ...and add Phones.  
		ds_phone_recs := IF(in_mod.MaxPhoneCount > 0, fn_getPhoneRecs(ds_deceased_recs, in_mod),ds_deceased_recs);

		//    (new version Req. 4.1.11) ...and process through relatives check. 
		ds_relatives_recs := Govt_Collections_Services.fn_checkRelativesRecs(ds_phone_recs, in_mod);

		ds_property_recs := Govt_Collections_Services.fn_getPropertyRecs(ds_relatives_recs, in_mod);
		
		//    (new version Req. 4.1.12) ...and finally check InstantID.  
		ds_processed_recs := Govt_Collections_Services.fn_checkInstantIDRecs(ds_property_recs, in_mod);

		today := ut.GetDate;
		dayToAdd := IF(ut.LeapYear((INTEGER2)today[3..4]), 1, 0);
				
		// 3. Calculate and assign Confidence Scores. Display Best address data only if it's
		// different from the input address. 
		//
		// Note that we're joining the results of the service back to the input parsed data,
		// since per the requirements we want to generate the confidence score 
		// by comparing the Best address data back to the original parsed input data.
		
		Govt_Collections_Services.Layouts.batch_working xfm_add_conf_scores(
																	Govt_Collections_Services.Layouts.batch_in le, 
																	Govt_Collections_Services.Layouts.batch_working ri) := TRANSFORM
				confidence_score 		 := Govt_Collections_Services.Functions.fn_get_conf_scores(le,ri);
				SELF.conf_score      := confidence_score;
				SELF.conf_score_desc := Govt_Collections_Services.Functions.fn_get_conf_score_desc(confidence_score);
				SELF.best_addr1      := IF(~in_mod.AppendBestData AND ri.input_is_best_addr, '', ri.best_addr1 );
				SELF.best_city       := IF(~in_mod.AppendBestData AND ri.input_is_best_addr, '', ri.best_city );
				SELF.best_state      := IF(~in_mod.AppendBestData AND ri.input_is_best_addr, '', ri.best_state );
				SELF.best_zip        := IF(~in_mod.AppendBestData AND ri.input_is_best_addr, '', ri.best_zip );
				SELF.best_fname 		 := IF(~in_mod.AppendBestData AND ri.is_fuzzy_full_name_match, '', ri.best_fname);
				SELF.best_lname			 := IF(~in_mod.AppendBestData AND ri.is_fuzzy_full_name_match, '', ri.best_lname);
				SELF.best_ssn        := IF(~in_mod.AppendBestData AND (ri.input_is_best_ssn OR 
																	 ri.best_SSN_is_poss_shared OR 
																	 ri.best_SSN_is_rel_linked), '',ri.best_ssn);
				SELF.SSN_match			 := IF(ri.input_is_best_ssn, 'Y', 'N');
				SELF.FN_LN_match     := IF(ri.is_fuzzy_full_name_match, 'Y', 'N');
				SELF.Address_match	 := IF(ri.input_is_best_addr, 'Y', 'N');
				
				isNCOA := ut.DaysApart(today, le.MatchMoveEffDate) < 365 + dayToAdd;
	
				NCOA_addr := IF(le.NCOA_addr1 <> '', STD.Str.CleanSpaces(le.NCOA_addr1 + ' ' + le.NCOA_addr2), 
																						 STD.Str.CleanSpaces(le.NCOA_prim_range + ' ' + 
																						 le.NCOA_predir + ' ' + le.NCOA_prim_name + ' ' + 
																						 le.NCOA_addr_suffix + ' ' + le.NCOA_postdir + ' ' + 
																						 le.NCOA_unit_desig + ' ' + le.NCOA_sec_range));
																					
				SELF.NCOA_addr1 			:= IF(isNCOA, NCOA_addr, '');
				SELF.NCOA_city 				:= IF(isNCOA, le.NCOA_city, '');
				SELF.NCOA_state 			:= IF(isNCOA, le.NCOA_state, '');
				SELF.NCOA_zip 				:= IF(isNCOA, le.NCOA_zip, '');
				SELF.MatchMoveEffDate := IF(isNCOA, le.MatchMoveEffDate, '');

				SELF := ri;
			END;
		
		ds_results_with_conf_scores := 
			JOIN(
				ds_batch_in_parsed, ds_processed_recs, 
				LEFT.acctno = RIGHT.acctno,
				xfm_add_conf_scores(LEFT,RIGHT),
				KEEP(1)
			);
   
	 	// OUTPUT( ds_best_address_recs, NAMED('ds_best_address_recs') );
		// OUTPUT( ds_expanded_ssn_recs, NAMED('ds_expanded_ssn_recs') );
		// OUTPUT( ds_ADL_best_recs, NAMED('ds_ADL_best_recs') );
		// OUTPUT( ds_drivers_license_recs, NAMED('ds_drivers_license_recs') );
		// OUTPUT( ds_batch_in_parsed, NAMED('ds_batch_in_parsed') ) ;
	 		IF( in_mod.ViewDebugs, 
		   OUTPUT( ds_processed_recs, NAMED('ds_batchview_working') ) );
			 
		// 4. Return.		
		RETURN ds_results_with_conf_scores;
	END;


	// Placeholders for possible future work:
	
	// EXPORT SearchView() := FUNCTION 
	// 
	// END;
	
	// EXPORT ReportView() := FUNCTION 
	// 
	// END;
END;