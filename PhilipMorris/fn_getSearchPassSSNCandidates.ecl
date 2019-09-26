import dx_Header;

CN := PhilipMorris.Constants;
LT := PhilipMorris.Layouts;
FN := PhilipMorris.Functions;
TF := PhilipMorris.Transforms;

export fn_getSearchPassSSNCandidates(DATASET(LT.Clean.FullRecordNorm) SearchData, UNSIGNED2 minAgeValue, CN.SortSearchPassEnum searchpasslog, boolean isDerived, UNSIGNED1 DPPA_Purpose, UNSIGNED1 GLB_Purpose, boolean SkipRestrictionsCall, boolean AllowProbationSources) := FUNCTION

	searchpassnumeric := searchpasslog;
	
	searchDataLocal := SearchData(IsSearchableSSN AND
																SearchName.lname != '' and 
																(SearchName.pfname	!= '' or SearchName.pfname2	!= ''));
	 
	searchpass_candidates_dids := join(			 
			 searchDataLocal, 
			 dx_Header.key_SSN(),//s1-s9, dph_lname, pfname, did
			 keyed(
				left.SearchSSN[1] = right.s1 and
    		left.SearchSSN[2] = right.s2 and
    		left.SearchSSN[3] = right.s3 and
    		left.SearchSSN[4] = right.s4 and
    		left.SearchSSN[5] = right.s5 and
    		left.SearchSSN[6] = right.s6 and
    		left.SearchSSN[7] = right.s7 and
    		left.SearchSSN[8] = right.s8 and
    		left.SearchSSN[9] = right.s9
			)
			and keyed(left.SearchName.PhoneticLname = right.dph_lname)
			and keyed(left.SearchName.pfname = right.pfname or left.SearchName.FName = right.pfname or left.SearchName.pfname2 = right.pfname),
			 
			 TRANSFORM (LT.Search.FullRecordNormWithHeaderData, 
									SELF.did := RIGHT.DID;
									SELF := LEFT;
									SELF := []; //blank out all the other header fields.. the only necessary field at the moment is the did									
								 ),
				LIMIT(CN.MAX_NUM_RECORDS_TO_KEEP_PM, SKIP)
				);
						 
	searchpass_candidates_dids_sorted  := sort(searchpass_candidates_dids, InternalSeqNo, SearchAddress.ADDRESSID, did);
	searchpass_candidates_dids_deduped := dedup(searchpass_candidates_dids_sorted, InternalSeqNo, SearchAddress.ADDRESSID, did);
	
	dirty_header_records	:= join (searchpass_candidates_dids_deduped, dx_Header.key_header(),
														keyed(LEFT.did = RIGHT.s_did) and 
														//(Left.DOB_Numeric div 10000 = right.dob div 10000) AND
														left.SearchSSN=right.ssn and
														left.SearchName.lname = right.lname and
														right.valid_ssn <> 'M',
														// conditions from did search also apply here.. don't need the extra records 
														//first name validation can be better done by applying logic
														//once the records have been pulled
														// \\
														TRANSFORM (LT.Search.FullRecordNormWithHeaderData, 
																				SELF.DOB := IF (RIGHT.valid_dob <> 'M', RIGHT.DOB, 0);
																				/* bugzilla 56745 */
																				SELF.InternalOnlyOutputSSN := IF (RIGHT.valid_ssn <> 'M', RIGHT.SSN, '');
																				//valid_dob being maintained in the geo_blk field for debug info as the geo_blk field is not used
																				SELF.geo_blk := RIGHT.valid_dob;
																				Self := RIGHT;
																				Self := LEFT;),
														LIMIT(CN.MAX_NUM_RECORDS_PER_DID, SKIP)
														);
														
		dob_tu_records := FN.getHeaderSourceDob(dirty_header_records);
											
	clean_header_records := FN.fn_ApplyRestrictions (DPPA_Purpose, GLB_Purpose, dob_tu_records, SkipRestrictionsCall, AllowProbationSources);

	searchpass_candidates_with_data := project (clean_header_records,
																							TF.xfm_process_hdr_records (LEFT, searchpassnumeric, minAgeValue, isDerived, false, AllowProbationSources));														

	final_output := searchpass_candidates_with_data(IsValidCandidate);
	// output(searchpass_candidates_dids_deduped, named('scdd_ssn'), extend);
	return final_output;
		
END;
