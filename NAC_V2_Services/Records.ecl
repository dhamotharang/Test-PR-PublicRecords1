IMPORT NAC_V2_Services;
EXPORT Records(DATASET(NAC_V2_Services.Layouts.process_layout) in_recs,
									     NAC_V2_Services.IParams.CommonParams in_mod) := FUNCTION						 
  // Get nac recs and apply penalty
	nac_penalt_recs   := NAC_V2_Services.Functions(in_mod).getNacRecs(in_recs(error_code=0));
	// We can filter investigative records by range at this point for investigative
	// Searches because there is no nested history portion in nac2 investigative searches
	nac_inves_sorted  := SORT(nac_penalt_recs(isHit),acctno,nac_groupid,case_program_state,
	                          case_program_code,client_identifier,-eligibility_period_end_raw);
	// Both parent and nested child history records have the same sort order in match searches
	nac_match_sorted  := SORT(nac_penalt_recs,acctno,client_identifier,case_program_state,
		                        nac_groupid,case_program_code,-isHit,-eligibility_period_end_raw);
	nac_cond_recs     := IF(in_mod.InvestigativePurpose,
	                        nac_inves_sorted,
												  nac_match_sorted);
	// This dedup will remove duplicate address records once their different cleaned
	// addresses have been used in the above penalty logic
	nac_address_duped := DEDUP(nac_cond_recs,acctno,case_identifier,client_identifier,nac_groupid,
	                           case_program_state,case_program_code,eligibility_status_indicator,
														 eligibility_period_start_raw,eligibility_period_end_raw);
	// Debug
	#IF(NAC_V2_Services.Constants.Debug)
		output(nac_inves_sorted, named('nac_inves_sorted'));
		output(nac_match_sorted, named('nac_match_sorted'));
		output(nac_address_duped,named('nac_address_duped'));
	#END
	RETURN nac_address_duped;
END;