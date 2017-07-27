IMPORT NAC_Services,NAC_V2_Services;
EXPORT Records (DATASET(NAC_V2_Services.Layouts.process_layout) in_recs,
								NAC_V2_Services.IParams.CommonParams in_mod):= FUNCTION
  // Get nac recs and apply penalty
	nac_penalt_recs  := NAC_V2_Services.Functions(in_mod).getNacRecs(in_recs(error_code=0));

	// Normalize nac2 records to nac1 layout to be processed by the nac1 logic
	normed_Nac1_recs := NAC_Services.Functions.norm_Nac2_to_Nac1(nac_penalt_recs);

	// Sort and dedup or rollup by case_identifier, client_identifier and case_benefit_type
	nac_sorted_recs  := SORT(normed_Nac1_recs,acctno,case_identifier,client_identifier,
	                         case_state_abbreviation,case_benefit_type, 
	                         //if the benefit_month is provided and a match we want to favor that
													 //month in the dedup; otherwise we want to keep the oldest month
													 -isBenefitMonthMatch,-benefit_month, 
													 //if benefit_type is provided we want that type to be favored in the dedup
													 -isBenefitTypeMatch,
													 //if eligible status is provided we want that status to be favored in the dedup
													 -isEligibleStatusMatch);													
	nac_duped_recs 	 := DEDUP(nac_sorted_recs,acctno,case_identifier,client_identifier,
	                          case_state_abbreviation,case_benefit_type);

	nac_hist_recs 	 := NAC_Services.Functions.concatenateTwelveMonthString(normed_Nac1_recs);

	// If 12 month history requested concatenate the string
	// Also filter on BenefitMonth, BenefitType and EligibleStatusIndicator where appropriate
	nac_cond_recs 	 := IF(in_mod.IncludeEligibilityHistory,
	                       nac_hist_recs,
									       nac_duped_recs)(isBenefitMonthMatch AND isBenefitTypeMatch AND isEligibleStatusMatch);

	// Do not return search results for acctno with more than 30 records
  NAC_V2_Services.Functions().MAC_handleTooManySubjects(nac_cond_recs,nac_filtered,
	                                                    acctno_set,NAC_Services.Constants.MAX_RECORDS_PER_ACCTNO);	

	nac_w_matchcodes := NAC_V2_Services.Functions().MatchCodeLogic(in_recs,nac_filtered,in_mod);

	// Final join to original input dataset to add error codes
  nac_final_recs   := NAC_V2_Services.Functions().populateErrors(in_recs,nac_w_matchcodes,acctno_set);

	// Debug
	#IF(NAC_Services.Constants.Debug)	
		OUTPUT(nac_sorted_recs, NAMED('nac_sorted_recs'));
		OUTPUT(nac_duped_recs,  NAMED('nac_duped_recs'));
		OUTPUT(nac_hist_recs,   NAMED('nac_hist_recs'));
		OUTPUT(nac_cond_recs,   NAMED('nac_cond_recs'));
		OUTPUT(nac_filtered,    NAMED('nac_filtered'));
		OUTPUT(nac_w_matchcodes,NAMED('nac_w_matchcodes'));
		OUTPUT(nac_final_recs,  NAMED('nac_final_recs'));
	#END
	RETURN nac_final_recs;
END;