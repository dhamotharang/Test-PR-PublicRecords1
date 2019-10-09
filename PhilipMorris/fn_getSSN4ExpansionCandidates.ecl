import dx_Header;

CN := PhilipMorris.Constants;
LT := PhilipMorris.Layouts;
FN := PhilipMorris.Functions;
TF := PhilipMorris.Transforms;

export fn_getSSN4ExpansionCandidates(DATASET(LT.Clean.FullRecordNorm) SearchData, UNSIGNED2 minAgeValue, UNSIGNED1 DPPA_Purpose, UNSIGNED1 GLB_Purpose) := FUNCTION

	searchpassnumeric := CN.SortSearchPassEnum.SSN4EXPANSION;
	
	searchDataLocal := SearchData(IsSearchableSSN4 AND
																SearchName.lname != '' and 
																(SearchName.pfname	!= '' or SearchName.pfname2 != ''));
	
	searchpass_candidates_dids := join(			 
			 searchDataLocal, dx_Header.key_SSN4_V2(),
			 keyed(left.ssn4=right.ssn4) and
			 keyed(left.SearchName.PhoneticLname[1..6] = right.dph_lname) and
			 keyed(left.SearchName.lname = right.lname) and
			 keyed(left.SearchName.pfname = right.pfname or left.SearchName.pfname2 = right.pfname),			
			 TRANSFORM (LT.Search.FullRecordNormWithHeaderData, 
									SELF.did := RIGHT.DID;
									SELF := LEFT;
									SELF := []; //blank out all the other header fields.. the only necessary field at the moment is the did									
								),
				LIMIT(CN.MAX_NUM_RECORDS_TO_KEEP_PM, SKIP)
		);						 

	searchpass_candidates_dids_sorted  := sort(searchpass_candidates_dids, SearchAddress.ADDRESSID, did);
	searchpass_candidates_dids_deduped := dedup(searchpass_candidates_dids_sorted, SearchAddress.ADDRESSID, did);
													
	dirty_header_records	:= join (searchpass_candidates_dids_deduped, dx_Header.key_header(),
														keyed(LEFT.did = RIGHT.s_did) and
														left.ssn4=RIGHT.SSN[FN.fn_getLen(RIGHT.SSN)-3..] and
														left.SearchName.lname = right.lname and
														right.valid_ssn <> 'M',														
														//first name validation can be better done by applying logic
														//once the records have been pulled
														TRANSFORM (LT.Search.FullRecordNormWithHeaderData, 
																				SELF.DOB := IF (RIGHT.valid_dob <> 'M', RIGHT.DOB, 0);
																				//valid_dob being maintained in the geo_blk field for debug info as the geo_blk field is not used
																				SELF.geo_blk := RIGHT.valid_dob;
																				Self := RIGHT;
																				Self := LEFT;),
														LIMIT(CN.MAX_NUM_RECORDS_PER_DID, SKIP)
														);

		clean_header_records := FN.fn_ApplyRestrictions (DPPA_Purpose, GLB_Purpose, dirty_header_records);

		searchpass_candidates_with_data := project (clean_header_records,
																								TF.xfm_process_hdr_records (LEFT, searchpassnumeric, minAgeValue, false, false, false));														
														
		final_output := searchpass_candidates_with_data(IsValidCandidate);		
		
/*output( searchpass_candidates_dids, named('searchpass_candidates_dids' + (string)searchpassnumeric));
output(	searchpass_candidates_dids_deduped, named('searchpass_candidates_dids_deduped' + (string)searchpassnumeric));														*/
//output(	dirty_header_records, named('dirty_header_records' + (string)searchpassnumeric));													
/*output(	clean_header_records, named('clean_header_records' + (string)searchpassnumeric));														
output( searchpass_candidates_with_data, named('searchpass_candidates_with_data' + (String)searchpassnumeric));
output( final_output, named('final_output' + (String)searchpassnumeric));*/

		RETURN final_output;

END;
