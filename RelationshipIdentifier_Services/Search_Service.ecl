import AutoStandardI,doxie,iesp,RelationshipIdentifier_Services;
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
	mod_access := doxie.compliance.GetGlobalDataAccessModuleTranslated(AutoStandardI.GlobalModule());

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
	
	dppa_ok := mod_access.isValidDppa();
	glb_ok :=  mod_access.isValidGlb();
	
	// ***************************************
	//4 lines coded per requirement 3.30 Relationship identifier Project.
	//
	PermissionsFlagdppa := mod_access.dppa = 0;
	PermissionsFlagGLB  := mod_access.glb = 0;
	
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
	 batchParams := RelationshipIdentifier_Services.iParam.getBatchParams();
   
	 SearchRecs := relationshipIdentifier_services.Search_Records(Search_Row,mod_access,options,
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
// this below is input XML that can be pasted into roxie wsecl service 
 // once its filled out with search criteria
// for person or for business.  Can have up to 8 <Item> XML blocks but need to have
//  at least 2 at minimum.
// notes : asOfDate defaults to the current date if not filled out
// and asOfDate is doing filter on header recs based on search results in order
// to determine ifa particular did or linkids (bip data) exists (i.e. dt_first_seen) at that point in time
//
/*
<relationshipidentifier_services.search_serviceRequest>

 <relationshipidentifiersearchrequest>
<row>
<User>
    <ReferenceCode/>
    <BillingCode/>
    <QueryId/>
    <CompanyId/>
    <GLBPurpose></GLBPurpose> // this field needs to be filled in 1-7 are valid values
    <DLPurpose></DLPurpose>   // this field needs to be filled in 1-7 are valid values.
    <LoginHistoryId/>
    <DebitUnits/>
    <IP/>
    <IndustryClass/>
    <ResultFormat/>
    <LogAsFunction/>
    <SSNMask/>
    <DOBMask/>
    <ExcludeDMVPII>0</ExcludeDMVPII>
    <DLMask>0</DLMask>
    <DataRestrictionMask>0000000000000000000</DataRestrictionMask>
    <DataPermissionMask>000000000000</DataPermissionMask>
    <SourceCode/>
    <ApplicationType/>
    <SSNMaskingOn>0</SSNMaskingOn>
    <DLMaskingOn>0</DLMaskingOn>
    <LnBranded>1</LnBranded>
    <EndUser>
     <CompanyName/>
     <StreetAddress1/>
     <City/>
     <State/>
     <Zip5/>
     <Phone/>
    </EndUser>
    <MaxWaitSeconds/>
    <RelatedTransactionId/>
    <AccountNumber/>
    <TestDataEnabled>0</TestDataEnabled>
    <TestDataTableName/>
    <OutcomeTrackingOptOut>0</OutcomeTrackingOptOut>
    <NonSubjectSuppression/>
   </User>   
<Options>
      <IncludeNeighbors>1</IncludeNeighbors>
      <AsOfDate>
       <Year>2016</Year>
       <Month>02</Month>
       <Day>20</Day>
      </AsOfDate>
     </Options>
      <SearchBy>
    <Item>
       <UniqueId/>
       <InSeleID/>
       <Role>Role 1</Role> // text in this XML tag is just placeholder can be anything (string50 size).     
       <IndividualOrBusiness>I</IndividualOrBusiness> // THIS IS single letter char EITHER A 'I' OR A 'B'
       <Address>                                        // for business or individual (person).
        <StreetNumber/>
        <StreetPreDirection/>
        <StreetName/>
        <StreetSuffix/>
        <StreetPostDirection/>
        <UnitDesignation/>
        <UnitNumber/>
        <StreetAddress1/>
        <StreetAddress2/>
        <City></City>
        <State></State>
        <Zip5/>
        <Zip4/>
        <County/>
        <PostalCode/>
        <StateCityZip/>
       </Address>
       <Name>
        <Full/>
        <First></First>
        <Middle/>
        <Last></Last>
        <Suffix/>
        <Prefix/>
       </Name>
       <CompanyName/>
       <TIN/>
       <SSN></SSN>
       <Phone10/>
       <DOB>
        <Year/>
        <Month/>
        <Day/>
       </DOB>
      </Item>
      <Item>
           <UniqueId/>
           <InSeleID/>
           <Role>Role 2</Role>      
          <IndividualOrBusiness></IndividualOrBusiness>
           <Address>
            <StreetNumber></StreetNumber>
            <StreetPreDirection/>
            <StreetName></StreetName>
            <StreetSuffix></StreetSuffix>
            <StreetPostDirection/>
            <UnitDesignation/>
            <UnitNumber/>
            <StreetAddress1/>
            <StreetAddress2/>
            <City></City>
            <State></State>
            <Zip5></Zip5>
            <Zip4/>
            <County/>
            <PostalCode/>
            <StateCityZip/>
           </Address>
           <Name>
            <Full/>
            <First></First>
            <Middle/>
            <Last/>
            <Suffix/>
            <Prefix/>
           </Name>
           <CompanyName/>
           <TIN/>
           <SSN/>
           <Phone10/>
           <DOB>
            <Year/>
            <Month/>
            <Day/>
           </DOB>
        </Item>
				<Item>
           <UniqueId/>
           <InSeleID/>
           <Role>Role 3</Role>
          <IndividualOrBusiness></IndividualOrBusiness>
           <Address>
            <StreetNumber></StreetNumber>
            <StreetPreDirection/>
            <StreetName></StreetName>
            <StreetSuffix></StreetSuffix>
            <StreetPostDirection/>
            <UnitDesignation/>
            <UnitNumber/>
            <StreetAddress1/>
            <StreetAddress2/>
            <City></City>
            <State></State>
            <Zip5></Zip5>
            <Zip4/>
            <County/>
            <PostalCode/>
            <StateCityZip/>
           </Address>
           <Name>
            <Full/>
            <First></First>
            <Middle/>
            <Last/>
            <Suffix/>
            <Prefix/>
           </Name>
           <CompanyName/>
           <TIN/>
           <SSN/>
           <Phone10/>
           <DOB>
            <Year/>
            <Month/>
            <Day/>
           </DOB>
           </Item>
       </SearchBy>
    </row>
     </relationshipidentifiersearchrequest>
</relationshipidentifier_services.search_serviceRequest>
*/