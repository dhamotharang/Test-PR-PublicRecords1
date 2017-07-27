/*
	This is the DLN Search for CompID service. 
	
	It invokes get_did_from_snum a raw function from DriversV2_Services.DLRaw module to 
	search DID's associated with DLN and state. Once DID is available it uses MOD_Common
	to generate Comp-Id result. 
	
	Based on Todd's cross tab report, there are 99.12% DLNs are map to a single DID. (4/16/2009)
*/

IMPORT CompId_Services, Address, AutoHeaderI, AutoStandardI, Doxie, WatchDog, DriversV2_Services;

EXPORT Search_DLN := MODULE
  
	// Modules
	shared common 		:= CompId_Services.Mod_Common;
	shared dlnRaw 		:= DriversV2_Services.DLRaw;

	// Layouts
	shared layoutCompIdResult					:= CompId_Services.Layouts.Layout_CompId_Result;	
	shared layoutDLN									:= DriversV2_Services.layouts.snum;
	
	// Doxie Reference
	shared layout_Doxie_Reference			:= Doxie.Layout_References;
	shared layout_Doxie_Reference_HH	:= Doxie.Layout_References_hh;
	
	
	/* Builds Name, Current and Prior Addresses by calling module-specific functions */
	DATASET(layoutCompIdResult) getNameAndAddress(dataset(layout_Doxie_Reference_HH) DIDs) := FUNCTION

		// Get the BestRecords
		BestRecords := common.getBestRecords(DIDs);
		// Get Address History Record
		HistoryRecs := common.getAddressHistory(DIDs);
		formattedHistoryRecs := common.formatHistory(HistoryRecs);
		
		// Combine Best with History and Ignore Deceased
		AllRecords := (BestRecords + formattedHistoryRecs) (~Address.isDeathRecord(addr));
		
		// Filter out duplicate addresses and build Result's Name and Address
		result := common.filterAndBuildResult(AllRecords);
		
		// Debug
		// OUTPUT(DIDs, NAMED('DIDs'));
		// OUTPUT(BestRecords, NAMED('BestRecords'));
		// OUTPUT(HistoryRecs, NAMED('HistoryRecs'));
		// OUTPUT(AllRecords, NAMED('AllRecords'));
		// OUTPUT(Result, NAMED('Result'));
		
		RETURN result;
	END;
	
	/* Returns name, address and driver information */
	DATASET(layoutCompIdResult) getNameAddressAndDriver(DATASET(layout_Doxie_Reference_HH) DIDs, UNSIGNED4 Seq_Value) := FUNCTION

		// Get the best name, current address and three prior addresses
		ResultWithNameAndAddress := getNameAndAddress(DIDs);

		// Get the DL info
		ResultWithDriver := common.getDriverLicence(DIDs, ResultWithNameAndAddress);

		layoutCompIdResult AddSeq (ResultWithDriver L) := TRANSFORM
			SELF.Seq := Seq_Value;
			SELF.Score := 100;			// Score is hard coded because DLN search does not return score.
			SELF := L;
		END;
		
		RETURN PROJECT(ResultWithDriver, AddSeq(LEFT));
	END;
	
	/* Get Matching DIDs for DLN from DriversV2_Services and then get name, address info */
	EXPORT DATASET(layoutCompIdResult) getResultForDLNInquiry(String dln, String state, UNSIGNED4 Seq_Value = 0) := FUNCTION

		// Create DLN struct for search using DriverService
    dlnRec := Dataset([{dln,state}], DriversV2_Services.layouts.snum); 																
	
		// Query driver module to find all DIDs associated with DLN/State
		DIDs:= project(dlnRaw.get_did_from_snum(dlnRec), transform(layout_Doxie_Reference_HH, self.did := left.did));
		
		// Get matching candidates for the SSN
		matchResult := getNameAddressAndDriver(DIDs, Seq_Value);

		// emptyResult
		emptyResult := PROJECT (dlnRec, TRANSFORM(layoutCompIdResult, 
																		SELF.currentDL.dl_number := left.dl_number, SELF.currentDL.dlState := left.orig_state,
																		SELF.seq := Seq_Value, SELF := []));
		
		// OUTPUT(matchResult, NAMED('matchResult'));
		// OUTPUT(emptyResult, NAMED('EmptyResult'));
		
		result := if (count(DIDs) = 1, matchResult, emptyResult);
		
		RETURN Result;
	END;
	
END;
