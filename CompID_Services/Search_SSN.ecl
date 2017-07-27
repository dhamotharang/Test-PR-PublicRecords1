IMPORT CompId_Services, Address, AutoHeaderI, AutoStandardI, Doxie, WatchDog, DriversV2_Services;

EXPORT Search_SSN := MODULE

	// Modules
	shared common 		:= CompId_Services.Mod_Common;

	// Layouts
	shared layoutCompIdResult					:= CompId_Services.Layouts.Layout_CompId_Result;	
	shared layoutDLN									:= DriversV2_Services.layouts.snum;
	
	// Doxie Reference
	shared layout_Doxie_Presentation	:= Doxie.Layout_Presentation;
	shared layout_Doxie_Reference			:= Doxie.Layout_References;
	shared layout_Doxie_Reference_HH	:= Doxie.Layout_References_hh;

	
	/* Filter the Address History */
	DATASET(layout_Doxie_Reference) getValidDIDsForSSN(DATASET(layout_Doxie_Presentation) HistoryRecs, STRING11 Inquiry_SSN) := FUNCTION
		
		// Filter records matching inquiry ssn
		HistoryWithInputSSN := HistoryRecs(SSN = Inquiry_SSN);
		
		// Filter records with Good SSN (best SSN for this DID)
		HistoryWithGoodSSN := HistoryWithInputSSN(valid_ssn = 'G');
		
		// TODO: If distinct count of DIDs is more than one, then return empty history
		RETURN PROJECT(HistoryWithGoodSSN, TRANSFORM(layout_Doxie_Reference, SELF.DID:=LEFT.DID, SELF:=[]));
	END;
	
	
	/* Builds Name, Current and Prior Addresses by calling module-specific functions */
	DATASET(layoutCompIdResult) getNameAndAddress(dataset(layout_Doxie_Reference_HH) DIDs, STRING11 Inquiry_SSN) := FUNCTION

		// Get the BestRecords and Address History
		BestRecords := common.getBestRecords(DIDs);
		HistoryRecs := common.getAddressHistory(DIDs);
		
		// In case of multiple returning DIDs, get the valid DID for input SSN
		ValidDIDs := IF (COUNT(DIDs) > 1, 
										 getValidDIDsForSSN(HistoryRecs, Inquiry_SSN), 
										 PROJECT(DIDs, TRANSFORM(layout_Doxie_Reference, SELF.DID:=LEFT.DID, SELF:=[])));
		
		// Filter best and history records based on valid dids
		FilteredBestRecs := BestRecords (DID IN SET(ValidDIDs, DID));
		FilteredHistoryRecs := common.formatHistory(HistoryRecs (DID IN SET(ValidDIDs, DID)));

		// Combine Best with History and Ignore Deceased
		AllRecords := (FilteredBestRecs + FilteredHistoryRecs) (~Address.isDeathRecord(addr));
		
		// Filter out duplicate addresses and build Result's Name and Address
		result := common.filterAndBuildResult(AllRecords);
		
		
		// Debug
		// OUTPUT(DIDs, NAMED('DIDs'));
		// OUTPUT(BestRecords, NAMED('BestRecords'));
		// OUTPUT(HistoryRecs, NAMED('HistoryRecs'));
		// OUTPUT(ValidDIDs, NAMED('ValidDIDs'));
		// OUTPUT(FilteredHistoryRecs, NAMED('FilteredHistoryRecs'));
		// OUTPUT(FilteredBestRecs, NAMED('FilteredBestRecs'));
		// OUTPUT(AllRecords, NAMED('AllRecords'));
		// OUTPUT(Result, NAMED('Result'));
		
		RETURN result;
	END;
	
	/* Returns name, address and driver information */
	DATASET(layoutCompIdResult) getNameAddressAndDriver(DATASET(layout_Doxie_Reference_HH) DIDs, STRING11 Inquiry_SSN, UNSIGNED4 Seq_Value) := FUNCTION

		// Get the best name, current address and three prior addresses
		ResultWithNameAndAddress := getNameAndAddress(DIDs, Inquiry_SSN);

		// Get the DL info
		ResultWithDriver := common.getDriverLicence(DIDs, ResultWithNameAndAddress);

		layoutCompIdResult AddSeq (ResultWithDriver L) := TRANSFORM
			SELF.Seq := Seq_Value;
			SELF.Score := 100;			// Score is hard coded because SSN search does not return score.
			SELF := L;
		END;
		
		RETURN PROJECT(ResultWithDriver, AddSeq(LEFT));
	END;
	
	/* Get Matching DIDs for SSN from AutoHeaderI and then get name, address info */
	EXPORT DATASET(layoutCompIdResult) getResultForSSN(STRING11 Inquiry_SSN, UNSIGNED4 Seq_Value = 1) := FUNCTION
		// Organize the input params into a module
		InputMod := AutoStandardI.GlobalModule();

		// Get the DIDs by matching the input params
		TempMod := MODULE (PROJECT (InputMod, AutoHeaderI.LIBIN.FetchI_Hdr_Indv.full, opt))
							 END;
		DIDs := AutoHeaderI.LIBCALL_FetchI_Hdr_Indv.do_hhid(TempMod);
		
		// Get matching candidates for the SSN
		Result := getNameAddressAndDriver(DIDs, Inquiry_SSN, Seq_Value);

		RETURN Result;
		
	END;
	
	/* Returns true if the Inquiry SSN is Valid, false otherwise */
	EXPORT BOOLEAN isValidSSN(STRING11 Inquiry_SSN) := FUNCTION
	
		// Check if the Inquiry SSN is in the known Bad SSNs (SSNs like '111111111')
		BOOLEAN bValid := (INTEGER)Inquiry_SSN NOT IN Doxie.Bad_SSN_List;
		
		// In addition, you could get 'smarter' and check for how many DIDs are using this SSN
		// Suppress.Key_SSN_Bad -- check out Doxie.base_presentation
		
		RETURN bValid;

	END;

	EXPORT DATASET(layoutCompIdResult) getResultForSSNInquiry(STRING11 Inquiry_SSN, UNSIGNED4 Seq_Value = 1) := FUNCTION

		// Create an Empty Record
		TempRec := RECORD UNSIGNED1 seq; END;
		TempData := DATASET([{1}], TempRec);
		DummyResult := PROJECT (TempData, TRANSFORM(CompId_Services.Layouts.Layout_CompId_Result, 
																								SELF.SSN := Inquiry_SSN, SELF.Seq := Seq_Value, SELF := []));

		// If the SSN is valid then execute the query, otherwise return empty
		Result := IF (isValidSSN(Inquiry_SSN),
									getResultForSSN(Inquiry_SSN, Seq_Value),
									DummyResult);

		// Return empty result if the query returned none
		FinalResult := IF (COUNT(Result) = 0,
									DummyResult, 
									Result);
		
		RETURN FinalResult;
	END;

END;
