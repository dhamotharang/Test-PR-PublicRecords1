IMPORT EditsV2, iesp, CompId_Services, Address, DidVille, Doxie, ut, header_slimsort, doxie, patriot, watchdog, header, DriversV2_Services;

EXPORT Search_Common := MODULE

	// Layouts
	SHARED Layout_Order 			 		:= EditsV2.Layouts_Order.Order;
	SHARED Layout_StrArrayItem 		:= iesp.share.t_StringArrayItem;
	SHARED Layout_CompIdResult 		:= CompId_Services.Layouts.Layout_CompId_Result;
	SHARED Layout_CompIdResult_ADD:= CompId_Services.Layouts.Layout_Add_Result;
	SHARED Layout_CompId_Order 		:= EditsV2.Layouts_Services.CompId_Order;
	SHARED Constants					 		:= EditsV2.Constants;
	SHARED Layout_Response 				:= EditsV2.Layouts_Response.response;
	
	/*--------------------------------------------------------------------------*/	
	export DATASET(Layout_CompIdResult) getDLResult(Layout_Order order, Layout_CompId_Order CompId_Order) := FUNCTION
		
		// Validate input parameter 
		isDLNExist := (trim(CompId_Order.LicNum) <> '') AND (trim(CompId_Order.DLStateCode) <> '');	
		isRIExist  := count(order.RI01_Recs) > 0;
		
		// Retrieve DL and State
		DL_No := CompId_Order.LicNum;
		State := CompId_Order.DLStateCode;
		
		// Call DL Search
		DATASET(Layout_CompIdResult) DLResult := CompID_Services.Search_DLN.getResultForDLNInquiry(DL_No, State);
		result := if(isDLNExist AND isRIExist, DLResult);
		RETURN result;
	END;

	/*--------------------------------------------------------------------------*/	
	export DATASET(Layout_CompIdResult) getSSNResult(Layout_Order order, Layout_CompId_Order CompId_Order) := FUNCTION
	
		// Validate input parameter 
		isSSNExist := (trim(CompId_Order.SsnNum) <> '');	
		isRIExist  := count(order.RI01_Recs) > 0;
	
		// Retrieve SSN
		ssnValue := CompId_Order.SsnNum;
		
		// Set SSN Global var
		#stored('ssn', ssnValue);

		// Call SSN Search
		DATASET(Layout_CompIdResult) SSNResult := CompID_Services.Search_SSN.getResultForSSNInquiry(ssnValue);
		result := if(isSSNExist AND isRIExist, SSNResult);
		RETURN result;
	END;
	
	/*--------------------------------------------------------------------------*/	
	export DATASET(Layout_CompIdResult) getGenResult(Layout_Order order, Layout_CompId_Order CompId_Order, boolean UseNoEQBest) := FUNCTION
	
		unsigned4 seq_value := 0;
		string120 name_value	:= ''; 
		unsigned  min_score := 75; 
		unsigned4 maxrecordstoreturn := 0;
		
		// Validate input parameter
		isValidParameter := (trim(CompId_Order.FirstName) <> '') AND (trim(CompId_Order.LastName) <> '');		
		isRIExist  := count(order.RI01_Recs) > 0;
		
		// Run TNT search
		tntResult := CompID_Services.Search_TNT.getGenResult(seq_value, CompId_Order.SsnNum,  CompId_Order.BirthDate,  CompId_Order.StrName,  '',  
																													CompId_Order.FirstName,	CompId_Order.LastName, CompId_Order.MidName,  CompId_Order.SufName, 
																													CompId_Order.StateCode,  CompId_Order.CityName,  CompId_Order.ZipNum,
																													'', CompId_Order.DLStateCode,  CompId_Order.LicNum,  
																													CompId_Order.HouseNum,  CompId_Order.AptNum,	'', 
																													name_value, min_score, maxrecordstoreturn, UseNoEQBest);
    result := if(isValidParameter AND isRIExist, tntResult);																														
		RETURN result;
	END;
	
	/*--------------------------------------------------------------------------*/	
	export DATASET(Layout_CompIdResult_ADD) getAddressMatchResult(Layout_Order order, Layout_CompId_Order CompId_Order) := FUNCTION
	
		// Retrieve Address
		seqValue 						:= 1;
		streetNumber 				:= compId_order.houseNum;
		unitNumber 					:= compId_order.aptNum;
		streetName					:= compId_order.strName;
		city								:= compId_order.cityName;
		state								:= compId_order.stateCode;
		zip									:= compId_order.zipNum;
		zip4								:= compId_order.zipSufNum;
		maxRecordsToReturn	:= CompID_Services.Constants.MAX_CANDIDATES_ON_ADDRESS;
		
		// Validate input parameter
		isValidAMParameter := (trim(compId_order.strName) <> '') AND (trim(compId_order.cityName) <> '') AND (trim(compId_order.zipNum) <> '');		
		isRIExist  := count(order.RI01_Recs) > 0;
		
		// Call Address Search
		amResult := CompID_Services.Search_Address.getResultForAddress (seqValue, streetNumber, unitNumber, streetName,
																																city, state, zip, zip4, maxRecordsToReturn);
    result := if(isValidAMParameter AND isRIExist, amResult);		
		RETURN result;
	END;
	
	/*--------------------------------------------------------------------------*/	
	export DATASET(Layout_CompIdResult) callCompIdFeature(DATASET(Layout_Order) Orders, 
																								 DATASET(Layout_CompId_Order) CompId_Orders) := FUNCTION
		// Consider only the first CompId Order (... hack)
		Layout_CompId_Order CompId_Order := CompId_Orders[1];
		Layout_Order order := Orders[1];
		
		// Get ReportUseCode to call the desired search feature
		Result := MAP(
								CompId_Order.ReportUseCode = Constants.DL_SEARCH OR
								CompId_Order.ReportUseCode = Constants.LM_SEARCH  => getDLResult(order, CompId_Order),
								CompId_Order.ReportUseCode = Constants.SSN_SEARCH => getSSNResult(order, CompId_Order),
																																		 getGenResult(order, CompId_Order, true));
		
		// Roxie is not able to output a row (as opposed to a dataset with a single row in it).
		// output(CHOOSEN(CompId_Orders, 1), NAMED('CompId_Order'));
		RETURN Result;
		
	END;
	
	/*--------------------------------------------------------------------------*/	
	export DATASET(Layout_CompIdResult_ADD) callADDFeature(DATASET(Layout_Order) Orders, 
																									DATASET(Layout_CompId_Order) CompId_Orders) := FUNCTION
		// Consider only the first CompId Order (... hack)
		Layout_CompId_Order CompId_Order := CompId_Orders[1];
		Layout_Order order := Orders[1];
		
		// Get ReportUseCode to call the desired search feature
		Result := getAddressMatchResult(order, CompId_Order);
		
		// Roxie is not able to output a row (as opposed to a dataset with a single row in it).
		// output(CHOOSEN(CompId_Orders, 1), NAMED('CompId_Order_ADD'));
		RETURN Result;
		
	END;
	
	
	/*--------------------------------------------------------------------------*/	
	/* Get results by calling appropriate function for the edits inquiry */
	EXPORT /*DATASET(Layout_CompIdResult)*/ getResultForEdits(DATASET(Layout_StrArrayItem) EditsOrder) := FUNCTION

		// Parse edits records into a convenient layout
		DATASET(Layout_Order) Orders := EditsV2.Mod_Parser.ParseEditsOrder(EditsOrder);
		DATASET(Layout_CompId_Order) CompId_Orders := EditsV2.Mod_Common.getCompIdOrdersFromGeneric(Orders);
		
		// Get result by calling appropriate CompId function
		SearchCompIdResult 	:= callCompIdFeature (Orders, CompId_Orders);
		compIdResult				:= EditsV2.Mod_Format.FormatResponse(Orders, SearchCompIdResult);
		compIdEditResult		:= EditsV2.Mod_Format.FormatEditResponse(compIdResult);
		
		// Get result by calling appropriate ADD function
		SearchADDResult 		:= callADDFeature (Orders, CompId_Orders);
		addResult						:= EditsV2.Mod_Format_ADD.FormatADDResponse(Orders, SearchADDResult);
		addEditResult				:= EditsV2.Mod_Format_ADD.FormatADDEditResponse(addResult);
		
		// Generate edit result
		editResult := if (CompId_Orders[1].ReportUseCode = Constants.AM_SEARCH, addEditResult, compIdEditResult);
		
		// Return Edits response
		// output(SearchCompIdResult, named('compIdResult'));		
		// output(SearchADDResult, named('compIdResult_ADD'));		
		// output(addResult, named('addResult_ADD'));		
		// output(editResult, named('editResult'));		
		RETURN editResult;
	END;
	
END;
