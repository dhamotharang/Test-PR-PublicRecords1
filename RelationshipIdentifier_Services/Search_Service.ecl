﻿import AutoStandardI,doxie,iesp,RelationshipIdentifier_Services;
EXPORT Search_Service() := 
MACRO
// calls Search_records
//
// gets results
// returns to user

// set a flag if all results resolve to single entity
// that way GUI side can directly call RelationshipIdentifier_Services.Report_Service
// if NeedsToBeResolved value in all rows is false.
//
//
// Sample XML input structure is below at bottom of attribute
// Note:
// this service much different than standard 1 entry of search criteria
// since this service has up to 8 different possible entities as search criteria
// either person or business
// so no calls to standard iesp.ecl2esp.set* for setting stored e.g. addr fields
// all that done in various logic within RelationshipIdentifier_Services.Search_Records
	// Get XML input
	
	rec_in := iesp.RelationshipIdentifierSearch.t_RelationshipIdentifierSearchRequest;
	ds_Search_in := dataset([],rec_in) : stored('RelationshipIdentifierSearchRequest',few);
	first_row := ds_search_in[1] : Independent;
	
	
	Num_Searches := Count(first_row.SearchBy);	
	
	num_searchesLimit := Choosen(first_row.searchBy, iesp.constants.RelationshipIdentifier.MAX_COUNT_SEARCH_MATCH_RECORDS);
	search_row := PROJECT(num_searchesLimit,TRANSFORM(
										RelationshipIdentifier_Services.Layouts.Local_tRelationshipIdentifierSearch,	         
					        self.SearchBy := LEFT));								
  
	 options_row := PROJECT(first_row.options, TRANSFORM( 
	         iesp.RelationshipIdentifierSearch.t_RelationshipIdentifierSearchOption,
					        SELF.includeNeighbors := LEFT.includeNeighbors;
									SELF.AsOfDate := LEFT.AsOfDate;
									//self.PDF := LEFT.PDF;
					        SELF := LEFT));					
									  								
	// Set some base options
	iesp.ECL2ESP.SetInputBaseRequest (first_row);

	user_options := global(first_row.User);
	
	AsofDateString8 := iesp.ecl2esp.t_DateToString8(options_row.AsOfDate);
	
	#stored('LnBranded',user_options.LnBranded);
	#stored('IncludeNeighbors',options_row.IncludeNeighbors);	
  #stored('AsOfDate',AsOfDateString8);
	
	integer ReturnCnt := 0 : stored('ReturnCount');
		
	unsigned4 maxResults := 0; // removed the ability to set this via stored.
	                          // per request from above. 0 set here turns into 50
														 //later on downstream within salt for business Searching.

	boolean stored_IncludeNeighbors := TRUE : stored('IncludeNeighbors');	 // default to true as per requirements
	boolean stored_lnbranded := FALSE : stored('LnBranded');
	string8 stored_asOfDate := '' : stored('AsOfDate');

  batchParams := RelationshipIdentifier_Services.iParam.getBatchParams();

	dppa_ok := batchParams.isValidDppa();
	glb_ok :=  batchParams.isValidGlb();
	
	// ***************************************
	//4 lines coded per requirement 3.30 Relationship identifier Project.
	//
	PermissionsFlagdppa := batchParams.dppa = 0;
	PermissionsFlagGLB  := batchParams.glb = 0;
	
  // END REl ident requirement
	
	RelationshipIdentifier_Services.Layouts.OptionsLayout search_options() := TRANSFORM	
	  self.lnbranded := stored_lnbranded;				
		self.IncludeNeighbors:= stored_IncludeNeighbors;
		self.AsOfDate := stored_asOfDate;
		//self.pdf := options_row.PDF;
	end;
	
	 options := row(search_options());  
										 
// set params so that function can be called and batchParams passed along.
	 ds_empty_batch := dataset([],RelationshipIdentifier_Services.Layouts.Batch.Input_Processed);
   
	 SearchRecs := relationshipIdentifier_services.Search_Records(Search_Row,options,
                                                                ds_empty_batch,batchParams).ds_results; 
   				
	 iesp.RelationshipIdentifierSearch.t_RelationshipIdentifierSearchResponse
		 Format_out() := TRANSFORM
			 self._Header := iesp.ECL2ESP.getHeaderRow();
		   self.records := SearchRecs;
			 self.RecordCount := count(SearchRecs);			
			 // pls note this particular XML tag <SearchBy> is an echo of the input searches
			 // and ESP automatically renames this tag to be <InputEcho> so that it compplies with standard
			 // naming configuration on XML API functions for this service.
			 SELF.SearchBy := PROJECT(Search_Row.SearchBy,
			                           TRANSFORM(iesp.relationshipidentifiersearch.t_RelationshipIdentifierSearchBy,
																   SELF := LEFT));
																 // needed here to echo the input on the output
			                                     // also options IncludeNeighbor, AsOfDate within this structure
																					 // so that GUI can call report service ESP with these options.
																					 // if everything resolves 1st time without user interaction
																					 // 
      self.optionsEcho := PROJECT(options,
			 TRANSFORM(iesp.RelationshipIdentifierSearch.t_RelationshipIdentifierSearchOption, 
			          self.asOfdate := iesp.ecl2esp.toDatestring8(LEFT.asOfDate);
								SELF := LEFT;
								self := []));
		  END;			 
			Results := dataset( [format_out()]);
			// ^^^^^ this line is the final results of the search service.
			
			
			// output(PermissionsFlagGLB, named('PermissionsFlagGLB'));
		// output(PermissionsFlagdppa , named('PermissionsFlagdppa'));
		// output(dppa_ok, named('dppa_ok'));
		// output(glb_ok, named('glb_ok'));
    	
	 Map(
			 Num_searches <= RelationshipIdentifier_Services.Constants.ONE  OR 
		   Num_searches >  iesp.constants.RelationshipIdentifier.MAX_COUNT_SEARCH_MATCH_RECORDS 
			                        => FAIL(301,doxie.ErrorCodes(301)),
					PermissionsFlagDPPA => FAIL(100, 'DPPA permissible purpose is required'),
					PermissionsFlagGlb  => FAIL(100, 'GLB permissible purpose is required.'),
					(~(dppa_ok))        => FAIL(2, 'Invalid DPPA permissible purpose'),
					(~(glb_ok))         => FAIL(2, 'Invalid GLB permissible purpose'),
					 output(Results, named('Results'))
			);																																																															
ENDMACRO;
