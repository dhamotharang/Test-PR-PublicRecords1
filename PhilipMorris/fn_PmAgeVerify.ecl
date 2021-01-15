CN := PhilipMorris.Constants;
LT := PhilipMorris.Layouts;
FN := PhilipMorris.Functions;
TF := PhilipMorris.Transforms;

fn_getNextSearchData (DATASET(LT.Clean.FullRecordNorm) existingSearchData,
											DATASET(LT.OutputRecord.CandidateRecord) hits) := FUNCTION

	distinct_hit_seqnos := DEDUP(hits, InternalSeqNo, ALL);

  //limit should not be necessary here since this is a left only join
	//and we are trying to maintain only the records that are NOT found in the right dataset
	return
	JOIN(existingSearchData, distinct_hit_seqnos,
			LEFT.InternalSeqNo = RIGHT.InternalSeqNo,
			TRANSFORM(LT.Clean.FullRecordNorm,
								SELF := LEFT;), LEFT ONLY);

END;

fn_getDerivedSSNSearchData (DATASET(LT.Clean.FullRecordNorm) SearchData,
														DATASET(LT.OutputRecord.CandidateRecord) CandidateRecords  ) := function

		deduped_derived_ssns := DEDUP(CandidateRecords(IsSearchableSSN AND
																									AgeVerified = false), InternalSeqNo, SSN, ALL);

		return
			join(	SearchData, deduped_derived_ssns,
				 RIGHT.InternalSeqNo = LEFT.InternalSeqNo and
				 left.SearchSSN <> Right.SSN and
				 left.SearchName.PhoneticLname <> '' and
				 left.SearchName.lname != '' and
				 left.SearchName.pfname	!= '',
				 TRANSFORM (LT.Clean.FullRecordNorm,
										SELF.SEARCHSSN := RIGHT.SSN;
										SELF.IsSearchableSSN := RIGHT.IsSearchableSSN;
										SELF := LEFT;
										SELF := RIGHT;
									 ), INNER,
									 LIMIT(CN.MAX_NUM_OF_DERIVED_SSNS_PER_INPUT, SKIP));
END;

export fn_PmAgeVerify( DATASET(LT.InRecord.Dirty.FullRecord)InputData,
											 boolean runBatchMode,
											 UNSIGNED1 DPPA_Purpose,
											 UNSIGNED1 GLB_Purpose,
											 boolean SkipRestrictionsCall,
											 boolean AllowProbationSources,
											 boolean runFailureReport ) := FUNCTION

	//add seqno, clean, and normalize
	inputDataAndSequence := PROJECT(InputData, TF.xfm_append_seqno(LEFT, COUNTER));
	searchDataInput := PROJECT(inputDataAndSequence, TF.xfm_set_clean_data(LEFT));
	searchdataInputNorm := NORMALIZE(searchDataInput,3,TF.xfm_normalize_search_data(LEFT, COUNTER));

	//the approach is to keep recreating/limiting the search dataset to only
	//the records that have not already been deemed a hit

	searchData01 := searchdataInputNorm;
	searchPass01Candidates  := IF ( ~runBatchMode,
																PhilipMorris.fn_getSearchPassSSNCandidates(searchData01(SearchAddress.AddressID=CN.AddressTypeEnum.GIID),	CN.DEFAULT_UNDERAGE_VALUE, CN.SortSearchPassEnum.INPUT_SSN, false, DPPA_Purpose, GLB_Purpose, SkipRestrictionsCall, AllowProbationSources));
	searchPass01Hits := searchPass01Candidates(AgeVerified = true);

	searchData10 :=	fn_getNextSearchData(searchData01, searchPass01Hits);
	searchPass10Candidates := PhilipMorris.fn_getSearchPassMainCandidates(searchData10, CN.DEFAULT_UNDERAGE_VALUE, CN.SortSearchPassEnum.PRIMARY, false, DPPA_Purpose, GLB_Purpose, SkipRestrictionsCall, AllowProbationSources);
	searchPass10Hits := searchPass10Candidates(AgeVerified = true);
	searchData20 := fn_getNextSearchData(searchData10 , searchPass10Hits);

	searchData20DerivedSSNs := IF (runBatchMode,
																fn_getDerivedSSNSearchData(searchData20(SearchAddress.AddressID=CN.AddressTypeEnum.GIID), searchPass10Candidates));
	searchPass20Candidates := IF (runBatchMode,
															PhilipMorris.fn_getSearchPassSSNCandidates(searchData20DerivedSSNs,	CN.DEFAULT_UNDERAGE_VALUE, CN.SortSearchPassEnum.DERIVED, true, DPPA_Purpose, GLB_Purpose, SkipRestrictionsCall, AllowProbationSources));
	searchPass20Hits := searchPass20Candidates(AgeVerified = true);

	searchData30 := fn_getNextSearchData(searchData20, searchPass20Hits);
	searchData30ReversedNames := project(searchData30, TF.xfm_reversenames(left));
	searchPass30Candidates := PhilipMorris.fn_getSearchPassMainCandidates(searchData30ReversedNames, CN.DEFAULT_UNDERAGE_VALUE, CN.SortSearchPassEnum.NAMEFLIP_PRIMARY, false, DPPA_Purpose, GLB_Purpose, SkipRestrictionsCall, AllowProbationSources);
	searchPass30Hits := searchPass30Candidates(AgeVerified = true);

	searchData40 := fn_getNextSearchData(searchData30, searchPass30Hits);
	searchData40ReversedNames := project(searchData40, TF.xfm_reversenames(left));
	searchData40DerivedSSNs := IF (runBatchMode,
																 fn_getDerivedSSNSearchData(searchData40ReversedNames(SearchAddress.AddressID=CN.AddressTypeEnum.GIID), searchPass30Candidates));

	searchPass40Candidates := IF (runBatchMode,
																PhilipMorris.fn_getSearchPassSSNCandidates(searchData40DerivedSSNs,	CN.DEFAULT_UNDERAGE_VALUE, CN.SortSearchPassEnum.NAMEFLIP_DERIVED, true, DPPA_Purpose, GLB_Purpose, SkipRestrictionsCall, AllowProbationSources));
  searchPass40Hits := searchPass40Candidates(AgeVerified = true);

	searchData50 := fn_getNextSearchData(searchData40, searchPass40Hits);
	searchPass50Candidates := PhilipMorris.fn_getSearchPassMainCandidates(searchData50, CN.DEFAULT_UNDERAGE_VALUE, CN.SortSearchPassEnum.FIRSTINITIAL, true, DPPA_Purpose, GLB_Purpose, SkipRestrictionsCall, AllowProbationSources);
	searchPass50Hits := searchPass50Candidates(AgeVerified = true);

	searchData60 := fn_getNextSearchData(searchData50, searchPass50Hits);
	searchPass60sCandidates := PhilipMorris.fn_getSearchPassRobustCandidates(searchData60, CN.DEFAULT_UNDERAGE_VALUE, DPPA_Purpose, GLB_Purpose, SkipRestrictionsCall, AllowProbationSources);
	searchPass60sHits := searchPass60sCandidates(AgeVerified = true);

	searchData70 := fn_getNextSearchData(searchData60, searchPass60sHits);
	searchPass70Candidates := PhilipMorris.fn_getSearchPassIgnoreHouseNumberCandidates(searchData70, CN.DEFAULT_UNDERAGE_VALUE, DPPA_Purpose, GLB_Purpose, SkipRestrictionsCall, AllowProbationSources);
	searchPass70Hits := searchPass70Candidates(AgeVerified = true);

	searchData71 := fn_getNextSearchData(searchData70, searchPass70Hits);
	searchPass71Candidates := IF ( ~runBatchMode,
																PhilipMorris.fn_getSearchPassSSNIgnoreLastNameCandidates(searchData71(SearchAddress.AddressID=CN.AddressTypeEnum.GIID),	CN.DEFAULT_UNDERAGE_VALUE, CN.SortSearchPassEnum.INPUT_SSN_IGNORE_LAST, false, DPPA_Purpose, GLB_Purpose, SkipRestrictionsCall, AllowProbationSources));
	searchPass71Hits := searchPass71Candidates(AgeVerified = true);

	searchData72 := fn_getNextSearchData(searchData71, searchPass71Hits);
	searchData72DerivedSSNs := IF (runBatchMode,
														fn_getDerivedSSNSearchData(searchData72(SearchAddress.AddressID=CN.AddressTypeEnum.GIID), searchPass10Candidates));
	searchPass72Candidates := IF (runBatchMode,
																PhilipMorris.fn_getSearchPassSSNIgnoreLastNameCandidates(searchData72DerivedSSNs, CN.DEFAULT_UNDERAGE_VALUE, CN.SortSearchPassEnum.DERIVED_IGNORE_LAST, true, DPPA_Purpose, GLB_Purpose, SkipRestrictionsCall, AllowProbationSources));
	searchPass72Hits := searchPass72Candidates(AgeVerified = true);

	allHits := 	searchpass01hits+searchPass10Hits+searchPass71Hits+
							searchPass20Hits+searchPass30Hits+searchPass40Hits+
							searchPass50Hits+searchPass60sHits+searchPass70Hits+
							searchPass72Hits;

	/*
	All of the records here are actually ageverified so the sort by ageverified field
	could be removed.  Additionally sorting by searchpass is also not necessary as every seqno should have only
	hits from one searchpass.
	However, in the interest of being safe in case the above code is changed, the two will be left in
	as they should not be of significant impact
	This operation leaves only the 'top/best' hit for every seqno
	*/
	allHitsSortedDeduped := dedup (SORT( allHits, InternalSeqNo, -AgeVerified, SearchAddressIDHit,  SearchPass, -SourceNameSort, -AgeMatchType ),
																			InternalSeqNo);

	//join search (clean) and output data
	//(original input data is not available here) so it is left blank to be joined later
	//both are a single row
	tmpOutNoFailureCode := JOIN(searchDataInput, allHitsSortedDeduped,
								LEFT.InternalSeqNo = RIGHT.InternalSeqNo,
								TRANSFORM(LT.TransactionData,
													isHit := (RIGHT.InternalSeqNo <> 0 AND RIGHT.DID <> 0);
													self.SearchData := LEFT;
													self.OutputData.InternalSeqNo := 	IF (isHit, RIGHT.InternalSeqNo, LEFT.InternalSeqNo);
													SELF.OutputData.DID  := 	IF (isHit, RIGHT.InternalSeqNo, 0);
													SELF.OutputData.DateProcessed_YYYYMMDD  := 	IF (isHit, RIGHT.DateProcessed_YYYYMMDD, LEFT.TodayYYYYMMDD);
													SELF.OutputData.AgeVerified		:= 	IF (isHit, RIGHT.AgeVerified, false);
													SELF.OutputData.UnderAge			:= 	IF (isHit, RIGHT.UnderAge, CN.DISPLAY_UNDEFINED_OR_BLANK);
													SELF.OutputData.AgeMatchType	:= 	IF (isHit, RIGHT.AgeMatchType, CN.SortAgeMatchTypeEnum.NONE);
													SELF.OutputData.AgeMatchTypeDisplay	:= 	IF (isHit, RIGHT.AgeMatchTypeDisplay,  CN.DISPLAY_UNDEFINED_OR_BLANK);
													SELF.OutputData.SourceNameSort := 	IF (isHit, RIGHT.SourceNameSort, CN.SortSourceEnum.UNK);
													SELF.OutputData.SourceName := 	IF (isHit, RIGHT.SourceName, CN.DISPLAY_SOURCENAME_BLANK);
													SELF.OutputData.SourceType := 	IF (isHit, RIGHT.SourceType, CN.SOURCETYPE_NAME_UNKNOWN);
													SELF.OutputData.SearchPass := 	IF (isHit, RIGHT.SearchPass, CN.SortSearchPassEnum.MISS);
													SELF.OutputData.SearchAddressIDHit := 	IF (isHit, RIGHT.SearchAddressIDHit, Constants.AddressTypeEnum.UNK);
													SELF.OutputData.InputMatchCode := 	IF (isHit, RIGHT.InputMatchCode, Constants.DISPLAY_INPUTMATCHCODE_ADDRESS_MISS);
													self.OutputData := RIGHT;
													self.FailureCode := MAP (SELF.OutputData.AgeVerified and SELF.OutputData.UnderAge = CN.DISPLAY_NO => CN.NOMATCHFAILURECODE.FAILURECODE_HIT,
																									 SELF.OutputData.AgeVerified and SELF.OutputData.UnderAge = CN.DISPLAY_YES => CN.NOMATCHFAILURECODE.FAILURECODE_FAILUNDERAGE,
																									 CN.NOMATCHFAILURECODE.FAILURECODE_UNK);
													self := LEFT;
													self.InputData := [];),
													LEFT OUTER, keep(1));

	//failure codes -> only run on address 1
	searchDataFailureCodes := fn_getNextSearchData(searchData72(SearchAddress.AddressID=CN.AddressTypeEnum.GIID), searchPass72Hits);
	failureCodes := PhilipMorris.fn_assignFailureCode(searchDataFailureCodes, CN.DEFAULT_UNDERAGE_VALUE, DPPA_Purpose, GLB_Purpose, SkipRestrictionsCall, AllowProbationSources);

	//join search+outputdata with failure codes to assign a failure code to misses
	//both are a single row
	tmpOutWithFailureCode :=
		JOIN(tmpOutNoFailureCode, failureCodes,
							LEFT.OutputData.InternalSeqNo = RIGHT.InternalSeqNo,
							TRANSFORM(LT.TransactionData,
												SELF.InputData  := [];
												self.SearchData := LEFT.SearchData;
												self.OutputData := LEFT.OutputData;
												self.FailureCode := IF (LEFT.FailureCode = CN.NOMATCHFAILURECODE.FAILURECODE_UNK, RIGHT.FailureCode, LEFT.FailureCode)),
												LEFT OUTER, keep(1));

	tmpOut := if (runFailureReport, tmpOutWithFailureCode, tmpOutNoFailureCode);

	//and finally join the original input data with (search+outputdata (with or without failure codes))
	finalOutput :=
		JOIN(inputDataAndSequence, tmpOut,
							LEFT.InternalSeqNo = RIGHT.OutputData.InternalSeqNo,
							TRANSFORM(LT.TransactionData,
												SELF.InputData  := LEFT;
												self.SearchData := RIGHT.SearchData;
												self.OutputData := RIGHT.OutputData;
												self.FailureCode := RIGHT.FailureCode),
												LEFT OUTER, keep(1));

	return finalOutput;
end;
