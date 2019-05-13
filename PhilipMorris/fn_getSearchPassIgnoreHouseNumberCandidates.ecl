import dx_header, ut;

CN := PhilipMorris.Constants;
LT := PhilipMorris.Layouts;
FN := PhilipMorris.Functions;
TF := PhilipMorris.Transforms;

export fn_getSearchPassIgnoreHouseNumberCandidates(DATASET(LT.Clean.FullRecordNorm) SearchData, UNSIGNED2 minAgeValue, UNSIGNED1 DPPA_Purpose, UNSIGNED1 GLB_Purpose, boolean SkipRestrictionsCall, boolean AllowProbationSources) := FUNCTION

	searchpassnumeric := CN.SortSearchPassEnum.IGNOREHOUSENUMBER;
	
	searchDataLocal := SearchData(SearchAddress.z5Numeric != 0 and 
															 SearchName.PhoneticLname <> '' and 
															 SearchName.lname != '' and 
															 (SearchName.pfname	!= '' or SearchName.pfname2  !='') and
															 SearchAddress.Prim_Name	!= '');
																
	searchpass_candidates_dids := join(			 
			 searchDataLocal, dx_header.key_piz(),			  
			 keyed(ut.PizTools.reverseZip(trim(left.SearchAddress.zip5)) = right.piz) and
			 keyed(left.SearchName.PhoneticLname[1..6] = right.dph_lname) and
			 keyed(left.SearchName.lname = right.lname) and
				(left.SearchName.pfname = right.pfname or 
				left.SearchName.FName = right.fname or
				left.SearchName.pfname = right.fname or
				left.SearchName.FName = right.pfname or 
				left.SearchName.pfname2 = right.pfname or 
				left.SearchName.pfname2 = right.fname),
			 TRANSFORM (LT.Search.FullRecordNormWithHeaderData, 
									SELF.did := RIGHT.DID;
									SELF := LEFT;
									SELF := []; //blank out all the other header fields.. the only necessary field at the moment is the did
									),
				LIMIT(CN.MAX_NUM_RECORDS_TO_KEEP_PM, SKIP)
				);
						 
	searchpass_candidates_dids_sorted  := sort(searchpass_candidates_dids, InternalSeqNo, SearchAddress.ADDRESSID, did);
	searchpass_candidates_dids_deduped := dedup(searchpass_candidates_dids_sorted, InternalSeqNo, SearchAddress.ADDRESSID, did);

	dirty_header_records	:= join (searchpass_candidates_dids_deduped, dx_header.key_header(),
														keyed(LEFT.did = RIGHT.s_did) and
														left.SearchAddress.Prim_Name	!= '' and		
														// conditions from did search also apply here.. don't need the extra records
														left.SearchAddress.zip5 = right.zip AND
														left.SearchName.lname = right.lname AND
														//first name validation can be better done by applying logic
														//once the records have been pulled
														// \\
														//(Left.DOB_Numeric div 10000 = right.dob div 10000) and
														 MAP(left.SearchAddress.PrimNameLen < 4 => left.SearchAddress.Prim_Name = RIGHT.prim_name,
																left.SearchAddress.PrimNameLen >= 4 => left.SearchAddress.Prim_Name[1..4] = RIGHT.prim_name[1..4],
																false),
															TRANSFORM (LT.Search.FullRecordNormWithHeaderData, 
																			  SELF.SSN := IF (RIGHT.valid_ssn <> 'M', RIGHT.SSN, '');
																				SELF.DOB := IF (RIGHT.valid_dob <> 'M', RIGHT.DOB, 0);
																				//valid_dob being maintained in the geo_blk field for debug info as the geo_blk field is not used
																				SELF.geo_blk := RIGHT.valid_dob;
																				Self := RIGHT;
																				Self := LEFT;),
														LIMIT(CN.MAX_NUM_RECORDS_PER_DID, SKIP)
														);
														
		dob_tu_records := FN.getHeaderSourceDob(dirty_header_records);
											
		clean_header_records := FN.fn_ApplyRestrictions (DPPA_Purpose, GLB_Purpose, dob_tu_records, SkipRestrictionsCall, AllowProbationSources);

		searchpass_candidates_with_data := project (clean_header_records,
																								TF.xfm_process_hdr_records (LEFT, searchpassnumeric, minAgeValue, false, false, AllowProbationSources));

		final_output := searchpass_candidates_with_data(IsValidCandidate);
	
		return final_output;

END;
