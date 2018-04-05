IMPORT AutoStandardI, Govt_Collections_Services, STD, ut, iesp, Address;

EXPORT Records := MODULE
	
  //----------------------------------------------------------------------------------------------------------
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

// KJEFOO - DEBUG   
// OUTPUT( ds_best_address_recs, NAMED('GCBatchV_Records_ds_best_address_recs') );
// OUTPUT( ds_expanded_ssn_recs, NAMED('GCBatchV_ds_expanded_ssn_recs') );
// OUTPUT( ds_ADL_best_recs, NAMED('GCBatchV_ds_ADL_best_recs') );
// OUTPUT( ds_drivers_license_recs, NAMED('GCBatchV_ds_drivers_license_recs') );
// OUTPUT( ds_batch_in_parsed, NAMED('GCBatchV_ds_batch_in_parsed') ) ;

	 		IF( in_mod.ViewDebugs, 
		   OUTPUT( ds_processed_recs, NAMED('ds_batchview_working') ) );
			 
		// 4. Return.		
		RETURN ds_results_with_conf_scores;
    
	END;


  //----------------------------------------------------------------------------------------------------------
	// Placeholders for possible future work:
	// EXPORT SearchView() := FUNCTION 
	// 
	// END;


  //----------------------------------------------------------------------------------------------------------
	EXPORT ReportView( DATASET(Govt_Collections_Services.Layouts.batch_out) ds_batch_out ) := FUNCTION 

    // -------------------------------------------------------------------------------------------------------
    // Convert the resulting batch output into the record layout for our ICR Report output.
    // -------------------------------------------------------------------------------------------------------
    iesp.identity_contact_resolution.t_ICRReportRecord transform_Batch_to_ICRReportResponse 
    (Govt_Collections_Services.Layouts.batch_out L) := TRANSFORM

        // Get constituent address components for the BEST Address, if available.
        is_Best_Address_Input := IF(L.best_addr1 <> '', TRUE, FALSE);

        Clean_Best_Address := IF(is_Best_Address_Input, 
                                   Address.CleanAddress182(TRIM(L.best_addr1),
                                   L.best_city + ' ' +
                                   L.best_state + ' ' +
                                   L.best_zip), '');  
                                           
        Formatted_Best_Address := Address.CleanAddressFieldsFips(Clean_Best_Address).addressrecord;


        // Get constituent address components for the Drivers License Address, if available.
        is_DL_Address_Input := IF(L.dl_addr1 <> '', TRUE, FALSE);

        Clean_DL_Address := IF(is_DL_Address_Input, 
                                   Address.CleanAddress182(TRIM(L.dl_addr1),
                                   L.dl_city + ' ' +
                                   L.dl_st + ' ' +
                                   L.dl_zip), '');  
                                           
        Formatted_DL_Address := Address.CleanAddressFieldsFips(Clean_DL_Address).addressrecord;


        // Normalize AKA's
        iesp.share.t_StringArrayItem Transform_AKAS_to_Dataset(Govt_Collections_Services.Layouts.batch_out L, integer C) := TRANSFORM
          SELF.value := CHOOSE(C, L.aka_1, L.aka_2, L.aka_3);
        END;

        ds_AKA_names := NORMALIZE(DATASET(L), 
                                  iesp.Constants.IdentityContactResolution.MaxReportAKAs, 
                                  Transform_AKAS_to_Dataset(L, COUNTER));


        // Normalize Phone Numbers.
        iesp.share.t_StringArrayItem Transform_phones_to_Dataset(Govt_Collections_Services.Layouts.batch_out L, integer C) := TRANSFORM
          SELF.value := CHOOSE(C, L.phone_number_1, L.phone_number_2, L.phone_number_3);
        END;

        ds_phones := NORMALIZE(DATASET(L), 
                               iesp.Constants.IdentityContactResolution.MaxReportPhones, 
                               Transform_phones_to_Dataset(L, COUNTER));


        // Normalize Debtors and their Phone Numbers.
        // ... the debtor phones
        iesp.share.t_StringArrayItem Transform_Debtor_Phones_to_Dataset(Govt_Collections_Services.Layouts.batch_out L, 
                                                                        integer Debtor_Sequence, 
                                                                        integer Phone_Sequence) := TRANSFORM
            SELF.value := CHOOSE(Debtor_Sequence, 
                                 CHOOSE(Phone_Sequence, 
                                        L.Property_Debtor_2_Phone_number_1, 
                                        L.Property_Debtor_2_Phone_number_2, 
                                        L.Property_Debtor_2_Phone_number_3),
                                 CHOOSE(Phone_Sequence, 
                                        L.Property_Debtor_3_Phone_number_1, 
                                        L.Property_Debtor_3_Phone_number_2, 
                                        L.Property_Debtor_3_Phone_number_3),
                                 CHOOSE(Phone_Sequence, 
                                        L.Property_Debtor_4_Phone_number_1, 
                                        L.Property_Debtor_4_Phone_number_2, 
                                        L.Property_Debtor_4_Phone_number_3));

        END;

        // ... the debtor addresses
        iesp.identity_contact_resolution.t_ICRDebtor Transform_Debtors_to_Dataset(Govt_Collections_Services.Layouts.batch_out L, 
                                                                                  integer C) := TRANSFORM
                                                                                  
          SELF.name.First := CHOOSE(C, L.Property_Debtor_2_Best_fname, L.Property_Debtor_3_Best_fname, L.Property_Debtor_4_Best_fname);
          SELF.name.Last := CHOOSE(C, L.Property_Debtor_2_Best_lname, L.Property_Debtor_3_Best_lname, L.Property_Debtor_4_Best_lname);
          
          SELF.address.StreetAddress1 := CHOOSE(C, L.Property_Debtor_2_Best_addr1, L.Property_Debtor_3_Best_addr1, L.Property_Debtor_4_Best_addr1);
          SELF.address.City := CHOOSE(C, L.Property_Debtor_2_Best_city, L.Property_Debtor_3_Best_city, L.Property_Debtor_4_Best_city);
          SELF.address.State := CHOOSE(C, L.Property_Debtor_2_Best_state, L.Property_Debtor_3_Best_state, L.Property_Debtor_4_Best_state);
          SELF.address.Zip5 := CHOOSE(C, L.Property_Debtor_2_Best_zip, L.Property_Debtor_3_Best_zip, L.Property_Debtor_4_Best_zip);
          
          SELF.phones := NORMALIZE(DATASET(L), 
                               iesp.Constants.IdentityContactResolution.MaxDebtorPhones, 
                               Transform_Debtor_Phones_to_Dataset(L, C, COUNTER));
                               
          SELF := []; // to null out any unassigned fields
          
        END;

        // ... build the debtor dataset and its elements within
        ds_debtors := NORMALIZE(DATASET(L), 
                                iesp.Constants.IdentityContactResolution.MaxReportPhones, 
                                Transform_Debtors_to_Dataset(L, COUNTER));

        SELF.uniqueid := L.lex_id; 
        SELF.ssn := L.ssn;
        SELF.dob := iesp.ECL2ESP.toDatestring8(L.dob);
        SELF.name.Full := '';
        SELF.name.First := L.name_first;
        SELF.name.Middle := L.name_middle;
        SELF.name.Last := L.name_last;
        SELF.name.Suffix := L.name_suffix;
        SELF.name.Prefix := '';

        SELF.address.StreetNumber := L.prim_range;
        SELF.address.StreetPreDirection := L.predir;
        SELF.address.StreetName := L.prim_name;
        SELF.address.StreetSuffix := L.addr_suffix;
        SELF.address.StreetPostDirection := L.postdir;
        SELF.address.UnitDesignation := L.unit_desig;
        SELF.address.UnitNumber := L.sec_range;
        SELF.address.StreetAddress1 := '';
        SELF.address.StreetAddress2 := '';
        SELF.address.City := L.p_city_name;
        SELF.address.State := L.st;
        SELF.address.Zip5 := L.z5;
        SELF.address.Zip4 := L.zip4;
        SELF.address.County := '';
        SELF.address.PostalCode := '';
        SELF.address.StateCityZip := '';

        SELF.conf_score := L.conf_score;
        SELF.conf_score_desc := L.conf_score_desc;

        SELF.best_name.Full := '';
        SELF.best_name.First := L.best_fname;
        SELF.best_name.Middle := '';
        SELF.best_name.Last := L.best_lname;
        SELF.best_name.Suffix := '';
        SELF.best_name.Prefix := '';

        SELF.best_ssn := L.best_ssn;

        SELF.best_address.StreetNumber := Formatted_Best_Address.prim_range;
        SELF.best_address.StreetPreDirection := Formatted_Best_Address.predir;
        SELF.best_address.StreetName := Formatted_Best_Address.prim_name;
        SELF.best_address.StreetSuffix := Formatted_Best_Address.addr_suffix;
        SELF.best_address.StreetPostDirection := Formatted_Best_Address.postdir;
        SELF.best_address.UnitDesignation := Formatted_Best_Address.unit_desig;
        SELF.best_address.UnitNumber := Formatted_Best_Address.sec_range;
        SELF.best_address.StreetAddress1 := '';
        SELF.best_address.StreetAddress2 := '';
        SELF.best_address.City := L.best_city;
        SELF.best_address.State := L.best_state;
        SELF.best_address.Zip5 := L.best_zip;
        SELF.best_address.Zip4 := '';
        SELF.best_address.County := '';
        SELF.best_address.PostalCode := '';
        SELF.best_address.StateCityZip := '';

        // dataset(iesp.share.t_StringArrayItem) aka_names {xpath('AKAs/AKA60'), MAXCOUNT(iesp.Constants.IdentityContactResolution.MaxReportAKAs)};
        SELF.aka_names := ds_AKA_names;

        SELF.poss_shared_ssn := L.poss_shared_ssn;
        SELF.ssn_match := L.ssn_match;
        SELF.expanded_ssn := L.expanded_ssn;
        SELF.fn_ln_match := L.fn_ln_match;
        SELF.address_match := L.address_match;
        SELF.hri_code := L.hri_code;
        SELF.hri_desc := L.hri_desc;
        SELF.date_last_seen := iesp.ECL2ESP.toDatestring8(L.date_last_seen);
        SELF.input_addr_date := iesp.ECL2ESP.toDatestring8(L.input_addr_date);
        SELF.addr_in_out_of_home_state := L.addr_in_out_of_home_state;

        // dataset(iesp.share.t_StringArrayItem) phones {xpath('Phones/Phone10'), MAXCOUNT(iesp.Constants.IdentityContactResolution.MaxReportPhones)};
        SELF.phones := ds_phones;

        SELF.deceased_indicator := L.deceased_indicator;
        SELF.dod := iesp.ECL2ESP.toDatestring8(L.dod);
        SELF.deceased_matchcode := L.deceased_matchcode;

        SELF.dl_address.StreetNumber := Formatted_DL_Address.prim_range;
        SELF.dl_address.StreetPreDirection := Formatted_DL_Address.predir;
        SELF.dl_address.StreetName := Formatted_DL_Address.prim_name;
        SELF.dl_address.StreetSuffix := Formatted_DL_Address.addr_suffix;
        SELF.dl_address.StreetPostDirection := Formatted_DL_Address.postdir;
        SELF.dl_address.UnitDesignation := Formatted_DL_Address.unit_desig;
        SELF.dl_address.UnitNumber := Formatted_DL_Address.sec_range;
        SELF.dl_address.StreetAddress1 := '';
        SELF.dl_address.StreetAddress2 := '';
        SELF.dl_address.City := L.dl_city;
        SELF.dl_address.State := L.dl_st;
        SELF.dl_address.Zip5 := L.dl_zip;
        SELF.dl_address.Zip4 := '';
        SELF.dl_address.County := '';
        SELF.dl_address.PostalCode := '';
        SELF.dl_address.StateCityZip := '';
        SELF.dl_exp_date := iesp.ECL2ESP.toDatestring8(L.dl_exp_date);

        // dataset(t_ICRDebtor) debtors {xpath('Debtors/Debtor'), MAXCOUNT(iesp.Constants.IdentityContactResolution.MaxReportDebtors)};
        SELF.debtors := ds_debtors;

        SELF.record_err_msg := L.record_err_msg;
        SELF.is_rejected_rec := L.is_rejected_rec;
        SELF.err_addr := L.err_addr;
        SELF.err_search := L.err_search;
        SELF.error_code := L.error_code;

        SELF := []; // to null out any unassigned fields

    END;

    results_ICR_Report_Records := PROJECT( ds_batch_out, transform_Batch_to_ICRReportResponse(LEFT) );

		RETURN results_ICR_Report_Records;
    
	END;
  
END;