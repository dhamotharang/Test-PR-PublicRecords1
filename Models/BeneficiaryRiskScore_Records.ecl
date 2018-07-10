
IMPORT Address, Gateway, Risk_Indicators, RiskProcessing, RiskWise, ut, doxie, gateway;
                                     
EXPORT BeneficiaryRiskScore_Records( DATASET(Models.BeneficiaryRiskScore_Layouts.SearchSubject) ds_input,
																		 DATASET(Gateway.Layouts.Config) gateways,
																		 Models.BeneficiaryRiskScore_Interfaces.IInputOptions_BocaShell bsSvcOptions,
																		 Models.BeneficiaryRiskScore_Interfaces.IInputOptions_PostBeneficiaryFraud pbfSvcOptions,
																		 Models.BeneficiaryRiskScore_Interfaces.IRestrictionParams restrictions, 
                                     unsigned1 ofac_version_ = 1,
                                     boolean include_ofac_ = false,
                                     real global_watchlist_threshold_ = 0.84) := 
	MODULE		
		// Add seq and cleaned fields to input.
		SHARED ds_input_plus :=
				PROJECT( ds_input, Models.BeneficiaryRiskScore_Functions.xfm_add_cleaned_fields(LEFT,COUNTER) );
		
		// Build datasets to run (1) against boca shell...
		SHARED iid_prep := 
				PROJECT( ds_input_plus, Models.BeneficiaryRiskScore_Functions.xfm_to_input_IID(LEFT) );
		
		// ... and (2) against post beneficiary fraud.
		SHARED pbf_prep := 
				PROJECT( ds_input_plus, Models.BeneficiaryRiskScore_Functions.xfm_to_input_PBF(LEFT) );

		// ---------------[ 1. Get Boca Shell results ]---------------
		
		// Define configuration necessary to run boca shell. These are hard-coded values e.g. see
		// Risk_Indicators.Boca_Shell and Models.PostBeneficiaryFraud_Batch_Service.
		SHARED iidConfig := 
				Models.BeneficiaryRiskScore_Interfaces.modInstantIDConfigDefault(restrictions, ofac_version_, include_ofac_, global_watchlist_threshold_);
		
		// NOTE: the following code is copied from Risk_Indicators.Boca_Shell and modified slightly.
		SHARED prep := risk_indicators.InstantID_Function(iid_prep, 
																				gateways, 
																				restrictions.DPPAPurpose, 
																				restrictions.GLBPurpose, 
																				iidConfig.isUtility, 
																				iidConfig.ln_branded, 
																				iidConfig.ofac_only,
																				iidConfig.suppressNearDups,
																				iidConfig.require2ele,
																				iidConfig.isFCRA,
																				iidConfig.from_biid,
																				iidConfig.ExcludeWatchLists,
																				iidConfig.from_IT1O,
																				iidConfig.ofac_version,
																				iidConfig.include_ofac,
																				iidConfig.include_additional_watchlists,
																				iidConfig.watchlist_threshold,
																				iidConfig.dob_radius,
																				bsSvcOptions.bsversion, 
																				in_runDLverification := bsSvcOptions.IncludeDLverification,
																				in_dataRestriction   := restrictions.DataRestrictionMask,
																				in_append_best       := bsSvcOptions.append_best,
																				in_BSOptions         := bsSvcOptions.bsOptions,
																				in_LastSeenThreshold := bsSvcOptions.LastSeenThreshold,
																				in_DataPermission    := restrictions.DataPermissionMask);

		// NOTE: The following code is copied from risk_indicators.Boca_Shell_Function( )--called 
		// from within Risk_Indicators.Boca_Shell and adapted slightly.
		SHARED iid_deduped := dedup(sort(ungroup(prep), 
			historydate, fname, mname, lname, suffix, ssn, dob, phone10, wphone10, in_streetAddress, in_city, in_state, in_zipcode, dl_number, dl_state, email_address, did, seq),
			historydate, fname, mname, lname, suffix, ssn, dob, phone10, wphone10, in_streetAddress, in_city, in_state, in_zipcode, dl_number, dl_state, email_address, did);

		SHARED seq_map := join( 
			iid_prep, iid_deduped,
			left.historydate = right.historydate
				and left.fname = right.fname
				and left.mname = right.mname
				and left.lname = right.lname
				and left.suffix = right.suffix
				and left.ssn = right.ssn
				and left.dob = right.dob
				and left.phone10 = right.phone10
				and left.wphone10 = right.wphone10
				and left.in_streetAddress = right.in_streetAddress
				and left.in_city = right.in_city
				and left.in_state = right.in_state
				and left.in_zipcode = right.in_zipcode
				and left.dl_number = right.dl_number
				and left.dl_state = right.dl_state
				and left.email_address = right.email_address
				and left.did = right.did,
			transform( {unsigned input_seq, unsigned deduped_seq}, 
				self.input_seq := left.seq, 
				self.deduped_seq := right.seq 
			), 
			keep(1), ALL
		);
			
		SHARED iid := GROUP(iid_deduped, seq);

		SHARED ids_wide := Risk_Indicators.boca_shell_FCRA_Neutral_Function(iid, 
																				restrictions.DPPAPurpose, 
																				restrictions.GLBPurpose,  
																				iidConfig.isUtility, 
																				iidConfig.ln_branded, 
																				iidConfig.includeRelativeInfo, 
																				false, 
																				bsSvcOptions.bsversion, 
																				nugen           := iidConfig.nugen, 
																				DataRestriction := restrictions.DataRestrictionMask,
																				BSOptions       := bsSvcOptions.bsOptions);
		
		SHARED p := DEDUP(GROUP(SORT(PROJECT(ids_wide(NOT isrelat), Risk_Indicators.Layout_Boca_Shell), seq), seq), seq);
		
		SHARED shell_results := Risk_Indicators.getAllBocaShellData (iid, 
																				ids_wide, 
																				p,
																				FALSE, 
																				iidConfig.ln_branded, 
																				restrictions.DPPAPurpose, 
																				restrictions.dppa_ok, 
																				iidConfig.includeRelativeInfo, 
																				iidConfig.includeDLInfo, 
																				iidConfig.includeVehInfo, 
																				iidConfig.includeDerogInfo, 
																				bsSvcOptions.bsversion, 
																				FALSE, 
																				bsSvcOptions.Include_Score, 
																				bsSvcOptions.Remove_Fares, 
																				restrictions.DataRestrictionMask, 
																				bsSvcOptions.bsOptions, 
																				restrictions.GLBPurpose, 
																				gateways,
																				restrictions.DataPermissionMask);
		
		// Join the results back to the original input so that every record on input has a response populated.
		SHARED full_response := 
			join( 
				seq_map, shell_results, 
				left.deduped_seq = right.seq, 
				transform( Risk_Indicators.Layout_Boca_Shell, 
					self.seq             := left.input_seq, 
					self.shell_input.seq := left.input_seq, 
					self                 := right 
				), 
				keep(1) 
			);

		SHARED ret := GROUP(full_response, seq);	

		// NOTE: end of code copied from risk_indicators.Boca_Shell_Function( ).

		SHARED adl_based_ret := risk_indicators.ADL_Based_Modeling_Function(iid_prep,
																				gateways, 
																				restrictions.DPPAPurpose, 
																				restrictions.GLBPurpose, 
																				iidConfig.isFCRA,
																				bsSvcOptions.bsversion, 
																				iidConfig.isUtility,
																				iidConfig.ln_branded,
																				iidConfig.ofac_only,
																				iidConfig.suppressNearDups,
																				iidConfig.require2ele,
																				iidConfig.from_biid,
																				iidConfig.excludeWatchLists,
																				iidConfig.from_IT1O,
																				iidConfig.ofac_version,
																				iidConfig.include_ofac,
																				iidConfig.include_additional_watchlists,
																				iidConfig.watchlist_threshold,
																				iidConfig.dob_radius,
																				iidConfig.includeRelativeInfo,
																				iidConfig.includeDLInfo,
																				iidConfig.includeVehInfo, 
																				iidConfig.includeDerogInfo, 
																				bsSvcOptions.Include_Score, 
																				iidConfig.nugen,
																				DataRestriction := restrictions.DataRestrictionMask,
																				DataPermission  := restrictions.DataPermissionMask);
																				
		SHARED final_results_bocashell := if(bsSvcOptions.ADL_Based_Shell, adl_based_ret, ret);

		// NOTE: end of code copied from Risk_Indicators.Boca_Shell.

		// Transform Boca Shell results into Risk_Indicators.Layout_Boca_Shell_Edina_v50.
		SHARED ToEdina_v50_pre := 
			PROJECT(
				UNGROUP(final_results_bocashell),
				TRANSFORM( riskprocessing.layouts.layout_internal_shell_noDatasets,
					SELF.time_ms       := 0,
					SELF.AccountNumber := '', // ---------->>>->>->~ NOTE!
					SELF.errorcode     := '',
					SELF               := LEFT,
					SELF 							 :=[]
				)
			);
		
		SHARED final_results_bocashell_Edina_v50 := 
				Risk_Indicators.ToEdina_v50(ToEdina_v50_pre, iidConfig.isFCRA, restrictions.DataRestrictionMask);
						
		// ---------------[ 2. Get PostBeneficiaryFraud results... ]---------------
		
		SHARED Models.Layout_PostBeneficiaryFraud.Combined_Attributes results_PostBeneficiaryFraud := 
			Models.get_PostBeneficiaryFraud_Attributes(shell_results, 
																				ids_wide, 
																				p, 
																				pbf_prep, 
																				iid_prep, 
																				gateways,
																				restrictions.GLBPurpose, 
																				restrictions.DPPAPurpose, 
																				pbfSvcOptions.Date_Cutoff,
																				pbfSvcOptions.Current_Only,
																				pbfSvcOptions.RelativeDepthLevel,
																				pbfSvcOptions.Include_Relative_And_Associates,
																				pbfSvcOptions.Include_Drivers_License, 
																				pbfSvcOptions.Include_Property,
																				pbfSvcOptions.Include_In_House_Motor_Vehicle,  
																				pbfSvcOptions.Include_Real_Time_Motor_Vehicle, 
																				pbfSvcOptions.Include_Watercraft_And_Aircraft,
																				pbfSvcOptions.Include_Professional_License,
																				pbfSvcOptions.Include_Business_Affiliations,
																				pbfSvcOptions.Include_People_At_Work,
																				pbfSvcOptions.Include_Bankruptcy_Liens_Judgements,
																				pbfSvcOptions.Include_Criminal_SOFR,
																				pbfSvcOptions.Include_UCC_Filings);

		SHARED transformed_results_PostBeneficiaryFraud := 
				Models.BeneficiaryRiskScore_Functions.transform_postbeneficiaryfraud_results(pbf_prep, results_PostBeneficiaryFraud, pbfSvcOptions);

		SHARED results_PostBeneficiaryFraud_with_codes := // Models.Layout_PostBeneficiaryFraud.Final_Plus 
				Models.PostBeneficiaryFraud_Functions.fn_get_reason_codes(transformed_results_PostBeneficiaryFraud);

		// ---------------[ ...and now add the Vehicle records ]---------------		
		
		// Get Vehicle records...
		SHARED Models.BeneficiaryRiskScore_Layouts.vehicles_rolled mvr_records := 
				Models.BeneficiaryRiskScore_Functions.fn_getMVRInfo(prep, pbfSvcOptions);

		// ...and calculate derived data...
		SHARED vehicles_rolled_plus_number_of_mvr := RECORD
			Models.BeneficiaryRiskScore_Layouts.vehicles_rolled;
			UNSIGNED number_of_mvr; // Preserve this field from BatchInput_With_Seq.
		END;
		
		SHARED vehicles_rolled_plus_number_of_mvr 
				xfm_add_derived_values(Models.Layout_PostBeneficiaryFraud.BatchInput_With_Seq le, Models.BeneficiaryRiskScore_Layouts.vehicles_rolled ri) :=
					TRANSFORM
						hist_date := (STRING6)ri.historydate;
						reg_count := COUNT(ri.vehicles);
						
						SELF.value_greater_than_threshold_count := 
							COUNT( ri.vehicles( (UNSIGNED)base_price > (UNSIGNED)le.mvr_vehicle_threshold ) );
						SELF.registrations_less_than_20yrs_count := 
							COUNT( ri.vehicles( ut.MonthsApart(hist_date, ((STRING)earliest_registration_date)[1..6]) <= 240));
						SELF.registration_count := reg_count;
						SELF.commercial_registration_count := COUNT(ri.vehicles(is_commercial));
						SELF.registration_count_difference := reg_count - le.number_of_mvr;			
						SELF.number_of_mvr := le.number_of_mvr;
						SELF := ri;
						SELF := le;
						SELF := [];
					END;
		
		SHARED mvr_records_with_derived_values :=
			JOIN(
				pbf_prep, mvr_records,
				LEFT.seq = RIGHT.seq,
				xfm_add_derived_values(LEFT,RIGHT),
				INNER,
				KEEP(1)
			);
			
		// Display MVR / Vehicle data.
		SHARED Models.BeneficiaryRiskScore_Layouts.PostBeneficiaryFraud_plus 
			xfm_add_MVRs(Models.Layout_PostBeneficiaryFraud.Final_Plus le, vehicles_rolled_plus_number_of_mvr ri) :=
				TRANSFORM
					cap_min := 0;
					cap_max := 255;
					currentYear := ((STRING)ri.historydate)[1..4];
					
					SELF.acctno    := le.acctno;
					SELF.NumMVR    := (STRING3)(COUNT(ri.vehicles));
					SELF.NumLuxuryMVR := 
							(STRING3)(COUNT(ri.vehicles(Risk_Indicators.isLuxuryVehicle(make, model, year_make, currentYear))));
					SELF.MVR1Make  := (STRING36)ri.vehicles[1].make;
					SELF.MVR1Year  := (STRING4)ri.vehicles[1].year_make;
					SELF.MVR1Model := (STRING36)ri.vehicles[1].model;
					SELF.MVR2Make  := (STRING36)ri.vehicles[2].make;
					SELF.MVR2Year  := (STRING4)ri.vehicles[2].year_make;
					SELF.MVR2Model := (STRING36)ri.vehicles[2].model;
					SELF.MVR3Make  := (STRING36)ri.vehicles[3].make;
					SELF.MVR3Year  := (STRING4)ri.vehicles[3].year_make;
					SELF.MVR3Model := (STRING36)ri.vehicles[3].model;
					SELF.MVR4Make  := (STRING36)ri.vehicles[4].make;
					SELF.MVR4Year  := (STRING4)ri.vehicles[4].year_make;
					SELF.MVR4Model := (STRING36)ri.vehicles[4].model;
					SELF.MVR5Make  := (STRING36)ri.vehicles[5].make;
					SELF.MVR5Year  := (STRING4)ri.vehicles[5].year_make;
					SELF.MVR5Model := (STRING36)ri.vehicles[5].model; 
					SELF.MVRvaluegreaterthanthreshold := 
						MAP(
							~(pbfSvcOptions.INCLUDE_IN_HOUSE_MOTOR_VEHICLE2 OR pbfSvcOptions.INCLUDE_REAL_TIME_MOTOR_VEHICLE2) => '',
							ri.registration_count = 0 => '-1',
							(UNSIGNED)ri.value_greater_than_threshold_count > 0 => '1',
							'0');
					SELF.MVRreglessthan20yrs := 
						MAP(
							~(pbfSvcOptions.INCLUDE_IN_HOUSE_MOTOR_VEHICLE2 OR pbfSvcOptions.INCLUDE_REAL_TIME_MOTOR_VEHICLE2) => '',
							ri.registration_count = 0 => '-1',
							(UNSIGNED)ri.registrations_less_than_20yrs_count > 0 => '1',
							'0');		
					SELF.NumUnreportedMVR :=
						MAP(
							~(pbfSvcOptions.INCLUDE_IN_HOUSE_MOTOR_VEHICLE2 OR pbfSvcOptions.INCLUDE_REAL_TIME_MOTOR_VEHICLE2) => '',
							ri.number_of_mvr = 0 => '0',
							(STRING)Models.BeneficiaryRiskScore_Functions.capU(IF(ri.registration_count_difference < 0,
															0,
															ri.registration_count_difference),
													 cap_min,
													 cap_max));		
					SELF.MVRCommercial := 
						MAP(
							~(pbfSvcOptions.INCLUDE_IN_HOUSE_MOTOR_VEHICLE2 OR pbfSvcOptions.INCLUDE_REAL_TIME_MOTOR_VEHICLE2) => '',
							ri.commercial_registration_count > 0 => '1',
							'0');		
					SELF.NumMVRCommercial := 
						IF(pbfSvcOptions.INCLUDE_IN_HOUSE_MOTOR_VEHICLE2 OR pbfSvcOptions.INCLUDE_REAL_TIME_MOTOR_VEHICLE2,
							 (STRING)Models.BeneficiaryRiskScore_Functions.capU(ri.commercial_registration_count, cap_min, cap_max),
							 '');	
					SELF := le;
				END;
			
		SHARED final_results_PostBeneficiaryFraud_pre := 
			JOIN(
				results_PostBeneficiaryFraud_with_codes, mvr_records_with_derived_values,
				LEFT.seq = RIGHT.seq AND
				LEFT.link_id = RIGHT.did,
				xfm_add_MVRs(LEFT,RIGHT),
				LEFT OUTER
			);

		// Add RealPropertyCombinedValue from the boca shell results. 
		SHARED final_results_PostBeneficiaryFraud := 
			JOIN(
				final_results_PostBeneficiaryFraud_pre, shell_results,
				LEFT.seq = RIGHT.seq,
				TRANSFORM( Models.BeneficiaryRiskScore_Layouts.PostBeneficiaryFraud_plus,
					SELF.RealPropertyCombinedValue := 
						IF(pbfSvcOptions.INCLUDE_PROPERTY,
							(STRING)RIGHT.address_verification.owned.Property_Owned_Assessed_Total,
							''),
					SELF := LEFT
				),
				INNER,
				KEEP(1)
			);
			
		// ---------------[ 3. Join Boca Shell results to Post Beneficary Fraud results. ]---------------
		
		SHARED final_results_BSv50_and_PBF :=
			JOIN(
				final_results_bocashell_Edina_v50, final_results_PostBeneficiaryFraud,
				LEFT.seq = RIGHT.seq,
				TRANSFORM( Models.BeneficiaryRiskScore_Layouts.Search_Final,
					SELF.AccountNumber := RIGHT.acctno,
					SELF := RIGHT,
					SELF := LEFT,
					SELF := [];
				),
				LEFT OUTER				
			);
			
		// ---------------[ 4. Public/Exportable attributes ]---------------
		
		EXPORT bocashell_Edina_v50_results  := final_results_bocashell_Edina_v50;
		EXPORT postbeneficiaryfraud_results := final_results_PostBeneficiaryFraud;
		EXPORT final_results                := final_results_BSv50_and_PBF;

	END;