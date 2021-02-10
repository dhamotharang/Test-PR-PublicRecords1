CN := PhilipMorris.Constants;
LT := PhilipMorris.Layouts;
FN := PhilipMorris.Functions;
TF := PhilipMorris.Transforms;

export fn_PmExpandSSN( DATASET(LT.InRecord.Dirty.SSN4FullRecord)InputData,
											 UNSIGNED1 DPPA_Purpose,
											 UNSIGNED1 GLB_Purpose,
											 BOOLEAN include_NameDobZipMatch = FALSE,
											 BOOLEAN runBatchMode = FALSE,
											 BOOLEAN runFailureReport = FALSE ) := FUNCTION

	//add seqno, clean, and normalize
	inputDataAndSequence := PROJECT(InputData, TF.xfm_append_seqno_ssn4(LEFT, COUNTER));
	searchDataInput := PROJECT(inputDataAndSequence, TF.xfm_set_clean_data_ssn4(LEFT));
	searchdataInputNorm := NORMALIZE(searchDataInput,3,TF.xfm_normalize_search_data(LEFT, COUNTER));
	ssnExpansionCandidates := PhilipMorris.fn_getSSN4ExpansionCandidates(searchdataInputNorm, CN.DEFAULT_UNDERAGE_VALUE, DPPA_Purpose, GLB_Purpose);

	// IMPORTANT NOTE:
	// fn_findSSNByNameAddress and fnfn_findSSNByNameDOB are designed to return
	// 1 row if only 1 was found, otherwise they return an empty result.
	// The below searches are in a specific order and are designed to waterfall down a set of matching rules.

	// Search by first address with house number and no DOBYear match
	ssnByNameAddress := fn_findSSNByNameAddress(ssnExpansionCandidates, CN.AddressTypeEnum.GIID, false, false);

	// Search by first address without house number and no DOBYear match
	ssnByNameAddress1NoHouse := IF (COUNT(ssnByNameAddress) = 0,
			fn_findSSNByNameAddress(ssnExpansionCandidates, CN.AddressTypeEnum.GIID, true, false),
			ssnByNameAddress);

	  // Search by first address without house number and include a DOBYEAR match
	ssnByNameAddress1NoHouseDob := IF (COUNT(ssnByNameAddress1NoHouse) = 0,
			fn_findSSNByNameAddress(ssnExpansionCandidates, CN.AddressTypeEnum.GIID, true, true),
			ssnByNameAddress1NoHouse);

		// Search by second address with house number and no DOBYear match
	ssnByNameAddress2 := IF (COUNT(ssnByNameAddress1NoHouseDob) <> 1 ,
		fn_findSSNByNameAddress(ssnExpansionCandidates, CN.AddressTypeEnum.CURRENT, false, false),
		ssnByNameAddress1NoHouseDob);

	// Search by second address without house number and no DOBYear match
	ssnByNameAddress2NoHouse := IF (COUNT(ssnByNameAddress2) = 0 ,
		fn_findSSNByNameAddress(ssnExpansionCandidates, CN.AddressTypeEnum.CURRENT, true, false),
		ssnByNameAddress2);

	  // Search by first address without house number and include a DOBYEAR match
	ssnByNameAddress2NoHouseDob := IF (COUNT(ssnByNameAddress2NoHouse) = 0,
			fn_findSSNByNameAddress(ssnExpansionCandidates, CN.AddressTypeEnum.CURRENT, true, true),
			ssnByNameAddress2NoHouse);

	// if the input request asked for the search without address being required then perform it on both zipcodes
	// Search By first zipcode and full DOB
	ssnByNameZip1Dob := IF (COUNT(ssnByNameAddress2NoHouseDob) = 0 and include_NameDobZipMatch,
	   PhilipMorris.fn_findSSNByNameDOB(ssnExpansionCandidates,CN.AddressTypeEnum.GIID),
		 ssnByNameAddress2NoHouseDob);

	// Search By second zipcode and full DOB
	ssnByNameZip2Dob := IF (COUNT(ssnByNameZip1Dob) = 0 and include_NameDobZipMatch,
	    PhilipMorris.fn_findSSNByNameDOB(ssnExpansionCandidates,CN.AddressTypeEnum.CURRENT),
			ssnByNameZip1Dob);

	tmpOut := PROJECT(ssnByNameZip2Dob,
								TRANSFORM(LT.Ssn4TransactionData,
													self.SearchData := searchDataInput[1]; //input has atmost one record!
													self.OutputData.InternalSeqNo := 	IF ( (left.InternalSeqNo <> 0 AND left.DID <> 0), left.InternalSeqNo, LEFT.InternalSeqNo);
													SELF.OutputData.DID  := 	IF ((left.InternalSeqNo <> 0 AND left.DID <> 0), left.InternalSeqNo, 0);
													SELF.OutputData.DateProcessed_YYYYMMDD  := 	IF ((left.InternalSeqNo <> 0 AND left.DID <> 0), left.DateProcessed_YYYYMMDD, searchDataInput[1].TodayYYYYMMDD);
													SELF.OutputData.SourceNameSort := 	IF ((left.InternalSeqNo <> 0 AND left.DID <> 0), left.SourceNameSort, CN.SortSourceEnum.UNK);
													SELF.OutputData.SourceName := 	IF ((left.InternalSeqNo <> 0 AND left.DID <> 0), left.SourceName, CN.DISPLAY_SOURCENAME_BLANK);
													SELF.OutputData.SourceType := 	IF ((left.InternalSeqNo <> 0 AND left.DID <> 0), left.SourceType, CN.SOURCETYPE_NAME_UNKNOWN);
													SELF.OutputData.SearchPass := 	IF ((left.InternalSeqNo <> 0 AND left.DID <> 0), left.SearchPass, CN.SortSearchPassEnum.MISS);
													SELF.OutputData.SearchAddressIDHit := 	IF ((left.InternalSeqNo <> 0 AND left.DID <> 0), left.SearchAddressIDHit, Constants.AddressTypeEnum.UNK);
													SELF.OutputData.InputMatchCode := 	IF ((left.InternalSeqNo <> 0 AND left.DID <> 0), left.InputMatchCode, Constants.DISPLAY_INPUTMATCHCODE_ADDRESS_MISS);
													self.OutputData := left;
													self.FailureCode := CN.NOMATCHFAILURECODE.FAILURECODE_UNK;
													self.InputData := []));

	finalOutput :=
		JOIN(inputDataAndSequence, tmpOut,
							LEFT.InternalSeqNo = RIGHT.OutputData.InternalSeqNo,
							TRANSFORM(LT.Ssn4TransactionData,
												SELF.InputData.InputEcho.ssnLast4 := LEFT.SSN;
												SELF.InputData  := LEFT;
												self.SearchData := RIGHT.SearchData;
												self.OutputData := RIGHT.OutputData;
												self.FailureCode := RIGHT.FailureCode),
												LEFT OUTER, keep(1));

	 // output(ssnExpansionCandidates, named('ssnExpansionCandidates'));
 	 // output(ssnByNameAddress, named('ssnByNameAddress'));
 	 // OUTPUT(ssnByNameAddress1NoHouse, named('ssnByNameAddress1NoHouse'));
	 // output(ssnByNameAddress1NoHouseDob, named('ssnByNameAddress1NoHouseDob'));
	// OUTPUT(ssnByNameAddress2 , named('ssnByNameAddress2'));
	// OUTPUT(ssnByNameAddress2NoHouse, named('ssnByNameAddress2NoHouse'));
	// output(ssnByNameAddress2NoHouseDob, named('ssnByNameAddress2NoHouseDob'));
	// output(ssnByNameZip1Dob, named('ssnByNameZip1Dob'));
	// output(ssnByNameZip2Dob, named('ssnByNameZip2Dob'));
	// output(tmpout, named('tmpout'));
	// OUTPUT(finalOutput, named('finalOut'));



	return finalOutput;
end;
