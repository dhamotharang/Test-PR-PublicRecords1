import doxie, dx_header;

CN := PhilipMorris.Constants;
LT := PhilipMorris.Layouts;
FN := PhilipMorris.Functions;
TF := PhilipMorris.Transforms;

export fn_getSearchPassRobustCandidates(DATASET(LT.Clean.FullRecordNorm) SearchData, UNSIGNED2 minAgeValue, UNSIGNED1 DPPA_Purpose, UNSIGNED1 GLB_Purpose, boolean SkipRestrictionsCall, boolean AllowProbationSources) := FUNCTION

	//NOTE: first initial added to query since LN robust matching always includes an FI match
	searchpassnumeric := CN.SortSearchPassEnum.MISS_DERIVE_FUZZY;

	searchDataLocal := SearchData(SearchAddress.z5Numeric != 0 and
																SearchAddress.Prim_Name != '' and
																SearchName.PhoneticLname <> '' and
																SearchName.lname != '' and
																(SearchName.pfname	!= '' or SearchName.pfname2	!= ''));

	searchpass_candidates_dids := join(
			 searchDataLocal,
			 dx_header.key_address(), //prim_name, prim_range, st, city_code, zip, sec_Range, dph_lname, lname, pfname, fname
				keyed(doxie.StripOrdinal(left.SearchAddress.Prim_Name) = right.prim_name) and	//note that previous index did not use doxie.StripOrdinal in the build.  key_address does.
				keyed(left.SearchAddress.Prim_Range = right.prim_range) and
				keyed(left.SearchAddress.st = right.st or left.SearchAddress.st = '') and
				wild(right.city_code) and
				keyed(left.SearchAddress.zip5 = right.zip) and
				(left.SearchName.pfname[1] = RIGHT.fname[1] or
				 left.SearchName.fname[1] = RIGHT.fname[1] or
				 left.SearchName.pfname2[1] = RIGHT.fname[1]),
				TRANSFORM (LT.Search.FullRecordNormWithHeaderData,
									SELF.did := RIGHT.DID;
									SELF := LEFT;
									SELF := []; //blank out all the other header fields.. the only necessary field at the moment is the did
								),
				LIMIT(CN.MAX_NUM_RECORDS_TO_KEEP_PM_ADDR_ONLY*10, SKIP)
			);

	searchpass_candidates_dids_sorted  := sort(searchpass_candidates_dids, InternalSeqNo, SearchAddress.ADDRESSID, did);
	searchpass_candidates_dids_deduped := dedup(searchpass_candidates_dids_sorted, InternalSeqNo, SearchAddress.ADDRESSID, did);
	dirty_header_records	:= join (searchpass_candidates_dids_deduped, dx_header.key_header(),
														keyed(LEFT.did = RIGHT.s_did) and
														left.SearchAddress.Prim_Name	!= '' and
														// conditions from did search also apply here.. don't need the extra records
														//left.SearchAddress.Prim_Range = right.prim_range and
														//left.SearchAddress.Prim_Name = right.prim_name and
														//left.SearchAddress.z5[1..5] = right.zip[1..5] and
														//(left.SearchName.pfname[1] = RIGHT.fname[1]  or left.SearchName.fname[1] = RIGHT.fname[1] )AND
														// \\
														IF (left.SearchAddress.IsRRType, left.SearchAddress.Sec_Range=right.sec_range, true), //and
														//STRIPPING THIS CONDITION BECAUSE THIS MIGHT FORCE MANY RECORDS
														//TO BE SCROLLED THROUGH TO REACH THE LIMIT
														//Left.DOB_Numeric div 10000 = right.dob div 10000),
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
																								TF.xfm_process_hdr_records (Left, searchpassnumeric, minAgeValue, false, false, AllowProbationSources));

		final_output := searchpass_candidates_with_data(IsValidCandidate);
		// output(CN.MAX_NUM_RECORDS_TO_KEEP_PM_ADDR_ONLY*1.5);
		// output(searchDataLocal, named('searchDataLocal_robust'), extend);
		// output(searchpass_candidates_dids_deduped, named('scdd_robust'), extend);
		RETURN final_output;

END;
