import dx_header, ut;

CN := PhilipMorris.Constants;
LT := PhilipMorris.Layouts;
FN := PhilipMorris.Functions;
TF := PhilipMorris.Transforms;

export fn_assignFailureCode(DATASET(LT.Clean.FullRecordNorm) SearchData, UNSIGNED2 minAgeValue, UNSIGNED1 DPPA_Purpose, UNSIGNED1 GLB_Purpose, boolean SkipRestrictionsCall, boolean AllowProbationSources) := FUNCTION

	TmpRec := RECORD
		LT.Clean.FullRecordNorm;
		boolean  FoundFirstLast := false;
		boolean  FoundStateFirstLast := false;
		boolean  FoundZipLastFirst := false;
		boolean  FoundAddressLastFirst := false;
		boolean  FoundAddressLastFirstWithAnyDobs := false;
		boolean  FoundAddressLastFirstWithMatchingDob := false;
	END;
	
	TmpRec2 := RECORD
		UNSIGNED4		InternalSeqNo;
		UNSIGNED2		FailureCode;
	END;
		
	one := join(			 
	 SearchData, dx_header.key_name(),	 
	 keyed(left.SearchName.PhoneticLname[1..6] = right.dph_lname) and
	 keyed(left.SearchName.lname = right.lname) and
	 keyed(left.SearchName.pfname = right.pfname or
	       left.SearchName.pfname2 = right.pfname or  
				 left.SearchName.FName = right.pfname),				
				TRANSFORM (TmpRec,
									SELF.InternalSeqNo := LEFT.InternalSeqNo;	
									SELF.FoundFirstLast := IF(RIGHT.DID <> 0, true, false);
									self := left;
								),
				LEFT OUTER,
				KEEP(1), LIMIT(0, SKIP)
	 );	
	 
	 two := join(			 
	 one, dx_header.key_StFnameLname(),	
	 left.FoundFirstLast = true and
	 keyed(left.SearchAddress.st = right.st) and
	 keyed(left.SearchName.PhoneticLname[1..6] = right.dph_lname) and
	 keyed(left.SearchName.lname = right.lname) and
	 keyed(left.SearchName.pfname = right.pfname or 
	       left.SearchName.pfname2 = right.pfname or
				 left.SearchName.FName = right.pfname),				
				TRANSFORM (TmpRec,
									SELF.InternalSeqNo := LEFT.InternalSeqNo;	
									SELF.FoundStateFirstLast := IF(RIGHT.DID <> 0, true, false);
									self := left;
								),
				LEFT OUTER,
				KEEP(1), LIMIT(0, SKIP)
	 );	

	 three := join(			 
			 two, dx_header.key_piz(),
			 left.FoundStateFirstLast = true and
			 keyed(ut.PizTools.reverseZip(trim(left.SearchAddress.zip5)) = right.piz) and
			 keyed(left.SearchName.PhoneticLname[1..6] = right.dph_lname) and
			 keyed(left.SearchName.lname = right.lname) and
						 (left.SearchName.pfname = right.pfname or 
							left.SearchName.FName = right.fname or
							left.SearchName.pfname = right.fname or
							left.SearchName.FName = right.pfname or 
							left.SearchName.pfname2 = right.fname or
							left.SearchName.pfname2 = right.pfname),
			 TRANSFORM (TmpRec,
									SELF.InternalSeqNo := LEFT.InternalSeqNo;	
									SELF.FoundZipLastFirst := IF(RIGHT.DID <> 0, true, false);
									self := left;
								),
				LEFT OUTER,
				KEEP(1), LIMIT(0, SKIP)
	 );		

	//the remainder of this is very similar to searchpass primary with the exception that
	//records are allowed to not have a ssn nor dob
	searchpassnumeric := CN.SortSearchPassEnum.PRIMARY;
	//first initial not allowed in failure mode
	runfirstInitial := false;
	
	//take only the records already found by name/zip
	foundByZipLastFirst := three(FoundZipLastFirst);
																									
  //limit should not be necessary here since this is a internal join only 
	//and we are trying to maintain only the records that are NOT found in the right dataset
	searchDataFoundByNameZip := 
	JOIN(SearchData, foundByZipLastFirst, 
			LEFT.InternalSeqNo = RIGHT.InternalSeqNo,
			TRANSFORM(LT.Clean.FullRecordNorm,
								SELF := LEFT;));	
	
	searchDataLocal := searchDataFoundByNameZip(SearchAddress.z5Numeric != 0 and 
																							SearchName.PhoneticLname <> '' and 
																							SearchName.lname != '' and 
																							(SearchName.pfname	!= '' or SearchName.pfname2	!= '')and
																							SearchAddress.Prim_Name	!= '');
	
	searchpass_candidates_dids := join(			 
			 searchDataLocal, dx_header.key_piz(),
			 keyed((integer4)stringlib.stringreverse(trim(left.SearchAddress.zip5))= right.piz) and
			 keyed(left.SearchName.PhoneticLname[1..6] = right.dph_lname) and
			 keyed(left.SearchName.lname = right.lname) and
			 IF(runfirstInitial and PhilipMorris.Functions.fn_getLen(left.SearchName.FName) = 1, left.SearchName.FName[1] = right.fname[1],
						 (left.SearchName.pfname = right.pfname or 
							left.SearchName.FName = right.fname or
							left.SearchName.pfname = right.fname or
							left.SearchName.FName = right.pfname or
							left.SearchName.pfname2 = right.fname or
							left.SearchName.pfname2 = right.pfname)),
			 TRANSFORM (LT.Search.FullRecordNormWithHeaderData, 
									SELF.did := RIGHT.DID;
									SELF := LEFT;	
									SELF := []; //blank out all the other header fields.. the only necessary field at the moment is the did
								),
				KEEP(CN.MAX_NUM_RECORDS_TO_KEEP_PM), LIMIT(CN.MAX_NUM_RECORDS_TO_KEEP_PM, SKIP)
		);						 

	searchpass_candidates_dids_sorted  := sort(searchpass_candidates_dids, InternalSeqNo, SearchAddress.ADDRESSID, did);
	searchpass_candidates_dids_deduped := dedup(searchpass_candidates_dids_sorted, InternalSeqNo, SearchAddress.ADDRESSID, did);

	dirty_header_records	:= join (searchpass_candidates_dids_deduped, dx_header.key_header(),
														keyed(LEFT.did = RIGHT.s_did) and
														left.SearchAddress.Prim_Name	!= '' and		
														// conditions from did search also apply here.. don't need the extra records 
														left.SearchAddress.zip5[1..5] = right.zip[1..5] and													  
													  left.SearchName.lname = right.lname and
													  //first name validation can be better done by applying logic
														//once the records have been pulled
														// \\
														 MAP(left.SearchAddress.PrimNameLen < 4 and left.SearchAddress.PrimRangeLen < 3 => left.SearchAddress.Prim_Name = RIGHT.prim_name and left.SearchAddress.Prim_Range = RIGHT.prim_range,
																	left.SearchAddress.PrimNameLen < 4 and left.SearchAddress.PrimRangeLen >= 3 => left.SearchAddress.Prim_Name = RIGHT.prim_name and left.SearchAddress.Prim_Range[1..3] = RIGHT.prim_range[1..3],
																	left.SearchAddress.PrimNameLen < 4 and left.SearchAddress.PrimRangeLen = 0 => left.SearchAddress.Prim_Name = RIGHT.prim_name,
																	left.SearchAddress.PrimNameLen >= 4 and left.SearchAddress.PrimRangeLen < 3 => left.SearchAddress.Prim_Name[1..4] = RIGHT.prim_name[1..4] and left.SearchAddress.Prim_Range = RIGHT.prim_range,
																	left.SearchAddress.PrimNameLen >= 4 and left.SearchAddress.PrimRangeLen >= 3 => left.SearchAddress.Prim_Name[1..4] = RIGHT.prim_name[1..4] and left.SearchAddress.Prim_Range[1..3] = RIGHT.prim_range[1..3],
																	left.SearchAddress.PrimNameLen >= 4 and left.SearchAddress.PrimRangeLen = 0 => left.SearchAddress.Prim_Name[1..4] = RIGHT.prim_name[1..4],
																	false),
															TRANSFORM (LT.Search.FullRecordNormWithHeaderData, 
																			  SELF.SSN := IF (RIGHT.valid_ssn <> 'M', RIGHT.SSN, '');
																			  SELF.DOB := IF (RIGHT.valid_dob <> 'M', RIGHT.DOB, 0);
																				SELF.geo_blk := RIGHT.valid_dob;
																				Self := RIGHT;
																				Self := LEFT;),
														LIMIT(CN.MAX_NUM_RECORDS_PER_DID, SKIP)
														);

		clean_header_records := FN.fn_ApplyRestrictions (DPPA_Purpose, GLB_Purpose, dirty_header_records, SkipRestrictionsCall, AllowProbationSources);

		searchpass_candidates_with_data := project (clean_header_records,
																								TF.xfm_process_hdr_records (Left, searchpassnumeric, minAgeValue, false, runfirstInitial, AllowProbationSources));


		valid_records_sorted := sort(searchpass_candidates_with_data(IsValidCandidate), InternalSeqNo, -AgeVerified, SearchAddressIDHit,  SearchPass, -SourceNameSort, -AgeMatchType );
		valid_records_with_dobs_sorted := valid_records_sorted(DOB_Numeric <> 0 and FN.fn_getLen(DOB_YYYYMMDD) = 8 and DOB_YYYYMMDD <> '' and DOB_YYYYMMDD <> '00000000' );
		
		four := 
		join (
		three, valid_records_sorted,	
		 left.FoundZipLastFirst =true and
		 left.InternalSeqNo = right.InternalSeqNo,				
					TRANSFORM (TmpRec,
										SELF.InternalSeqNo := LEFT.InternalSeqNo;	
										SELF.FoundAddressLastFirst := IF(RIGHT.DID <> 0 and right.InternalSeqNo <> 0, true, false);
										self := left;
									),
					LEFT OUTER,
					KEEP(1), LIMIT(0)
		 );	
		 
		 five := 
		 join (
		 four, valid_records_with_dobs_sorted,	
		 left.FoundAddressLastFirst= true and
		 left.InternalSeqNo = right.InternalSeqNo,				
					TRANSFORM (TmpRec,
										SELF.InternalSeqNo := LEFT.InternalSeqNo;	
										SELF.FoundAddressLastFirstWithAnyDobs := IF(RIGHT.DID <> 0 and right.InternalSeqNo <> 0, true, false);
										self := left;
									),
					LEFT OUTER,
					KEEP(1), LIMIT(0)
		 );	
		 
		 six := 
		 join (
		 five, valid_records_with_dobs_sorted,	
		 left.FoundAddressLastFirstWithAnyDobs = true and right.MatchesYOB and
		 left.InternalSeqNo = right.InternalSeqNo,				
					TRANSFORM (TmpRec,
										SELF.InternalSeqNo := LEFT.InternalSeqNo;	
										SELF.FoundAddressLastFirstWithMatchingDob := IF(RIGHT.DID <> 0 and right.InternalSeqNo <> 0, true, false);
										self := left;
									),
					LEFT OUTER,
					KEEP(1), LIMIT(0)
		 );	
	
		//now let's set the final values
		TmpRec2 xfm_set_failure_codes (TmpRec l) := TRANSFORM
			self.InternalSeqNo := l.InternalSeqNo;
			self.FailureCode := MAP(~L.FoundFirstLast=>CN.NOMATCHFAILURECODE.FAILURECODE_FIRSTLASTNOTFOUND,
															~L.FoundStateFirstLast=>CN.NOMATCHFAILURECODE.FAILURECODE_FIRSTLASTSTATENOTFOUND,
															~L.FoundZipLastFirst=>CN.NOMATCHFAILURECODE.FAILURECODE_FIRSTLASTZIPNOTFOUND,
															~L.FoundAddressLastFirst=>CN.NOMATCHFAILURECODE.FAILURECODE_NOADDRFULLNAME,
															~L.FoundAddressLastFirstWithAnyDobs=>CN.NOMATCHFAILURECODE.FAILURECODE_NODOBWITHADDRFULLNAME,
															L.FoundAddressLastFirstWithAnyDobs and ~L.FoundAddressLastFirstWithMatchingDob=>CN.NOMATCHFAILURECODE.FAILURECODE_DIFFERENTDOBWITHADDRFULLNAME,
															L.FoundAddressLastFirstWithAnyDobs and L.FoundAddressLastFirstWithMatchingDob=>CN.NOMATCHFAILURECODE.FAILURECODE_PREVIOUSFAILNOWHIT,
															CN.NOMATCHFAILURECODE.FAILURECODE_UNK);
		END;
		
		allRecordsWithFailureCodes := PROJECT(six, xfm_set_failure_codes(LEFT));

		RETURN allRecordsWithFailureCodes;

END;
