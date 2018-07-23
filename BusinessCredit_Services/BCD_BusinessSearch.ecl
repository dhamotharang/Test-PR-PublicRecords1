
/*--SOAP--
<message name="BCD_BusinessSearch">
	
	<!-- COMPLIANCE/USER SETTINGS -->
	<part name="GLBPurpose" type="xsd:byte"/>
	<part name="DPPAPurpose" type="xsd:byte"/> 
	<part name="DataRestrictionMask" type="xsd:string"/>
  <part name="DataPermissionMask" type="xsd:string"/>
  <part name="SSNMask" type="xsd:string"/>

	<!-- SEARCH FIELDS -->
  <part name="Acctno" type="xsd:string"/>
	<part name="CompanyName" type="xsd:string"/>
	<part name="TIN" type="xsd:string"/>
	
	<part name="Addr" type="xsd:string"/>
	<part name="City" type="xsd:string"/>
	<part name="State" type="xsd:string"/>
	<part name="Zip" type="xsd:string"/>
	<part name="Radius" type="xsd:string"/>

	<part name="PhoneNumber" type="xsd:string"/>
	<part name="URL" type="xsd:string"/>
	<part name="Email" type="xsd:string"/>
	<part name="SSN" type="xsd:string"/>
	<part name="LastName" type="xsd:string"/>
	<part name="FirstName" type="xsd:string"/>
	<part name="MiddleName" type="xsd:string"/>

	<part name="SIC" type="xsd:string"/>
  <part name="SeleID" type="xsd:string"/>
	
	<!-- ADDITIONAL OPTIONS -->
  <part name="Allow7DigitMatch" type="xsd:boolean"/>
  <part name="HSort" type="xsd:boolean"/>
  <part name="LnBranded" type="xsd:boolean"/>
  <part name="IncludeBusinessCredit" type="xsd:boolean"/>
 
  <!-- left in here for now may use later to override DRM -->

	<!-- MARSHALLING OPTIONS -->
	<part name="ReturnCount" type="xsd:unsigned"/>
	<part name="StartingRecord" type="xsd:unsigned"/>
	
	<!-- XML REQUEST -->
	<part name="BcdBusinessSearchRequest" type="tns:XmlDataSet" cols="80" rows="30"/>
	
</message>
*/
/*--INFO-- This service produces a business search results list for 
           Capital One's Business Credit Disclosure (BCD) service.*/


IMPORT BIPV2,BusinessCredit_Services,IESP,STD,TopBusiness_Services;

// This service was created for Capital One who has requested a new service they 
// will have the ability to specialize to their specific needs. At the time of creating the 
// service it was a replica of the TopBusiness_Services.BusinessSearch, with only
// the top level records created for the new service. Subject to change depending upon the 
// changes requested by Capital One.
// Capital One has committed to 60,000 transactions per month by 2019. 
// For performance and the ability to quickly make unforeseeable major changes this new service
// shares all underlying code.

export BCD_BusinessSearch() := MACRO

	// Get XML input

	rec_in := iesp.bcdbusinesssearch.t_BcdBusinessSearchRequest;
  ds_in := DATASET([],rec_in) : STORED('BcdBusinessSearchRequest',FEW);
	first_row := ds_in[1] : INDEPENDENT;
	
	// Set some base options
	iesp.ECL2ESP.SetInputBaseRequest (first_row);
	
	// Set DPPA, GLBA, DRM, etc.
	iesp.ECL2ESP.SetInputUser (first_row.User);
	
	// Store main search criteria
	search_by := GLOBAL(first_row.SearchBy);
	options_by := GLOBAL(first_row.Options);
	user_options := GLOBAL(first_row.User);
  
		/* **********************************************
			 *  Fields needed for improved Scout Logging  *
			 **********************************************/
			STRING32 _LoginID               := ''	: STORED('_LoginID');
			outofbandCompanyID							:= '' : STORED('_CompanyID');
			STRING20 CompanyID              := IF(user_options.CompanyId != '', user_options.CompanyId, outofbandCompanyID);
			STRING20 FunctionName           := '' : STORED('_LogFunctionName');
			STRING50 ESPMethod              := '' : STORED('_ESPMethodName');
			STRING10 InterfaceVersion       := '' : STORED('_ESPClientInterfaceVersion');
			STRING5 DeliveryMethod          := '' : STORED('_DeliveryMethod');
			STRING5 DeathMasterPurpose      := '' : STORED('__deathmasterpurpose');
			outofbandssnmask                := '' : STORED('SSNMask');
			STRING10 SSN_Mask               := IF(user_options.SSNMask != '', user_options.SSNMask, outofbandssnmask);
			outofbanddobmask                := '' : STORED('DOBMask');
			STRING10 DOB_Mask               := IF(user_options.DOBMask != '', user_options.DOBMask, outofbanddobmask);
			BOOLEAN DL_Mask                 := user_options.DLMask;
			BOOLEAN ExcludeDMVPII           := user_options.ExcludeDMVPII;
			BOOLEAN ArchiveOptIn            := FALSE : STORED('instantidarchivingoptin');
			BOOLEAN DisableIntermediateShellLoggingOutOfBand := FALSE    : STORED('OutcomeTrackingOptOut');
			DisableOutcomeTracking  := DisableIntermediateShellLoggingOutOfBand OR user_options.OutcomeTrackingOptOut;

			//Look up the industry by the company ID.
			Industry_Search := Inquiry_AccLogs.Key_Inquiry_industry_use_vertical_login(FALSE)(s_company_id = CompanyID AND s_product_id = (STRING)Risk_Reporting.ProductID.BusinessCredit_Services__BCD_BusinessSearch);
		/* ************* End Scout Fields **************/


	#STORED('CompanyName',search_by.CompanyName);
	#STORED('TIN',search_by.TIN);
	
	iesp.ECL2ESP.SetInputAddress(search_by.Address);  // this sets #stored for prim_name, prim_range
	                                                 // city, state, zip5
	#STORED('Radius',search_by.Radius);
	#STORED('PhoneNumber',search_by.Phone10);
	#STORED('URL',search_by.URL);
	#STORED('Email',search_by.Email);
	iesp.ECL2ESP.SetInputName(search_by.Name);
	#STORED('SIC',search_by.SIC);
	#STORED('SeleID',search_by.SeleID);
	#STORED('SSN',Search_by.SSN);
	#STORED('Allow7DigitMatch',options_by.Allow7DigitMatch);
	#STORED('HSort',options_by.HSort);
	
	// Store search options
	iesp.ECL2ESP.Marshall.Mac_Set(options_by);
	
	#STORED('LnBranded',user_options.LnBranded);
  #STORED('IncludeBusinessCredit', options_by.IncludeBusinessCredit);
  
	INTEGER ReturnCnt := 0 : STORED('ReturnCount');

  //The following macro defines the field sequence on WsECL page of query.
	WSInput.MAC_BusinessCredit_Services_BCD_BusinessSearch();
                      
	// Get back the DPPA, GLBA, DRM, etc
	UNSIGNED1 stored_dppa_purpose := 0 : STORED('DPPAPurpose');
	UNSIGNED1 stored_glb_purpose := 0 : STORED('GLBPurpose');
	STRING32 stored_App_type := '' : STORED('ApplicationType');
	STRING stored_datarestrictionmask := '' : STORED('DataRestrictionMask');
	UNSIGNED4 maxResults := 0; // removed the ability to set this via stored.
	                           // per request from above. 0 set here turns into 50
														 // later on downstream within salt.
	// Get back the search criteria
	STRING stored_companyname := '' : STORED('CompanyName');
	STRING stored_tin := '' : STORED('TIN');
	
  // stored_addr is set from the call to iesp.ECL2ESP.SetInputAddress above
	STRING stored_addr       := '' : STORED('Addr'); 
	///////////////////////////////////////////////////////////
	STRING stored_city       := '' : STORED('City');
	STRING stored_state      := '' : STORED('State');
	STRING stored_zip        := '' : STORED('Zip');
	STRING stored_sec_range  := '' : STORED('sec_range');
	UNSIGNED stored_radius   := 0  : STORED('Radius');
	STRING stored_phone10    := '' : STORED('PhoneNumber');
	STRING stored_url        := '' : STORED('URL');
	STRING stored_email      := '' : STORED('Email');
	STRING stored_lastname   := '' : STORED('LastName');
	STRING stored_firstname  := '' : STORED('FirstName');
	STRING stored_middlename := '' : STORED('MiddleName');
	// SIC will be not passed into external linking but will be used as a post filter.
	STRING stored_sic                    := '' : STORED('SIC');
	STRING stored_seleid                 := '' : STORED('SeleID');
	STRING stored_ssn                    := '' : STORED('SSN');
	BOOLEAN stored_allow7DigitMatch      := FALSE : STORED('Allow7DigitMatch');
	BOOLEAN stored_HSort                 := TRUE : STORED('HSort');
	BOOLEAN stored_lnbranded             := FALSE : STORED('LnBranded');
	BOOLEAN stored_IncludeBusinessCredit := FALSE: STORED('IncludeBusinessCredit');
  
	derived_city  :=   std.Str.ToUpperCase(stored_city);
	derived_state :=   std.Str.ToUpperCase(stored_state);
	derived_zip   :=   std.Str.ToUpperCase(stored_zip);
	
		addr2 := Address.Addr2FromComponents(derived_city, derived_state, derived_zip);
		
    // determine if data passed via <streetAddress1> or in individual fields i.e. parsed or unparsed use accordingly.
		
		UNSIGNED1 region := address.Components.Country.US; // default
		
		clean_addr := Address.GetCleanAddress(stored_addr, addr2, region).results;
		
	  BIPV2.IDFunctions.rec_SearchInput
	                               setInputSearchRec() := TRANSFORM																									 
		SELF.zip_radius_miles := stored_radius;
	  SELF.company_name := TRIM(std.Str.ToUpperCase(stored_companyname), LEFT, RIGHT); // cleaned by linking inside function call.
	  SELF.prim_range :=  TRIM(std.Str.ToUpperCase(clean_addr.prim_range), LEFT, RIGHT);
	  SELF.prim_name :=  TRIM(std.Str.ToUpperCase(clean_addr.prim_name), LEFT, RIGHT);
	
	  SELF.zip5 := IF (stored_zip <> '', stored_zip, clean_addr.zip);
	  SELF.sec_range := clean_addr.sec_range;
	  SELF.city := IF (clean_addr.v_city <> '',
		                  clean_addr.v_city,		                  
		                   TRIM(std.Str.ToUpperCase(stored_city), LEFT, RIGHT)
											  );
	  SELF.state := IF (TRIM(std.Str.ToUpperCase(stored_state), LEFT, RIGHT) <> '',
		                   TRIM(std.Str.ToUpperCase(stored_state), LEFT, RIGHT),
											 clean_addr.state);
	  SELF.phone10 := std.Str.Filter(stored_phone10,'0123456789');
	  SELF.fein := std.Str.Filter(stored_tin,'0123456789'),
	  SELF.URL := TRIM(std.Str.ToUpperCase(stored_url), LEFT, RIGHT); // more work done here for validation.
	  SELF.Email := TRIM(std.Str.ToUpperCase(stored_email), LEFT, RIGHT);
	  SELF.Contact_fname := TRIM(std.Str.ToUpperCase(stored_firstname), LEFT, RIGHT);
	  SELF.Contact_mname := TRIM(std.Str.TOUpperCase(stored_middlename), LEFT, RIGHT);
	  SELF.Contact_lname := TRIM(std.Str.ToUpperCase(stored_lastname), LEFT, RIGHT);
		SELF.Sic_Code := stored_sic;
		SELF.Results_limit := MaxResults;
		SELF.contact_SSN := stored_ssn;
		SELF.inSeleID := std.Str.Filter(stored_seleid,'0123456789'),
		SELF.allow7DigitMatch := stored_allow7DigitMatch;
		SELF.HSort := stored_HSort;
    SELF.acctno := '';
		SELF := [];
	END;
	
	DS_search_input := DATASET([setInputSearchRec()]);
	
	tempmod := MODULE(AutoStandardI.DataRestrictionI.params)  
		EXPORT BOOLEAN AllowAll := FALSE;
		EXPORT BOOLEAN AllowDPPA := FALSE;
		EXPORT BOOLEAN AllowGLB := FALSE;
		EXPORT STRING DataRestrictionMask := stored_datarestrictionmask;
		EXPORT UNSIGNED1 DPPAPurpose := stored_dppa_purpose;
		EXPORT UNSIGNED1 GLBPurpose := stored_glb_purpose;
		EXPORT BOOLEAN ignoreFares := FALSE;
		EXPORT BOOLEAN ignoreFidelity := FALSE;
		EXPORT BOOLEAN includeMinors := FALSE;
	end;

TopBusiness_Services.BusinessSearch_Layouts.OptionsLayout search_options() := TRANSFORM		
	  SELF.lnbranded := stored_lnbranded;		
		SELF.internal_testing := FALSE; //stored_internal_testing;	
    SELF.IncludeBusinessCredit := stored_IncludeBusinessCredit;
	END;
	
	options := ROW(search_options());  
		
  possibleResults := TopBusiness_Services.BusinessSearch_Records.Search(DS_search_input,
	                 options,
	                 tempmod).recs;
				
  tmpRecs := PROJECT(possibleResults.records, 
           TRANSFORM(iesp.bcdbusinesssearch.t_BcdTopBusinessSearchRecord, 
                                     SELF := LEFT;
                                       SELF := []));	
                                
  iesp.ECL2ESP.Marshall.MAC_Marshall_Results(tmpRecs, results, iesp.bcdbusinesssearch.t_BcdBusinessSearchResponse);
 
  BizCredRecsOnlyCount       := COUNT(tmpRecs( BusinessCreditIndicator = BusinessCredit_Services.Constants.BUSINESS_CREDIT_INDICATOR.BUSINESS_CREDIT_ONLY));
  ds_BizCredCountRoyalLayout := DATASET([{BizCredRecsOnlyCount}], {INTEGER SBFEAccountCount});
  ds_BizCredRecsRoyalties    := Royalty.RoyaltySBFE.GetOnlineRoyalties( ds_BizCredCountRoyalLayout );       
  ds_Royalties               := DATASET([], Royalty.Layouts.Royalty) + 
                                IF(stored_IncludeBusinessCredit, ds_BizCredRecsRoyalties);


		//Log to Deltabase
		Deltabase_Logging_prep := PROJECT(results, TRANSFORM(Risk_Reporting.Layouts.LOG_Deltabase_Layout_Record,
																										 SELF.company_id := (INTEGER)CompanyID,
																										 SELF.login_id := _LoginID,
																										 SELF.product_id := Risk_Reporting.ProductID.BusinessCredit_Services__BCD_BusinessSearch,
																										 SELF.function_name := FunctionName,
																										 SELF.esp_method := ESPMethod,
																										 SELF.interface_version := InterfaceVersion,
																										 SELF.delivery_method := DeliveryMethod,
																										 SELF.date_added := (STRING8)Std.Date.Today(),
																										 SELF.death_master_purpose := DeathMasterPurpose,
																										 SELF.ssn_mask := SSN_Mask,
																										 SELF.dob_mask := DOB_Mask,
																										 SELF.dl_mask := (STRING)(INTEGER)DL_Mask,
																										 SELF.exclude_dmv_pii := (STRING)(INTEGER)ExcludeDMVPII,
																										 SELF.scout_opt_out := (STRING)(INTEGER)DisableOutcomeTracking,
																										 SELF.archive_opt_in := (STRING)(INTEGER)ArchiveOptIn,
                                                     SELF.glb := tempmod.GLBPurpose,
                                                     SELF.dppa := tempmod.DPPAPurpose,
																										 SELF.data_restriction_mask := tempmod.DataRestrictionMask,
																										 SELF.data_permission_mask := user_options.DataPermissionMask,
																										 SELF.industry := Industry_Search[1].Industry,
																										 SELF.i_ssn := search_by.SSN,
																										 SELF.i_name_first := TRIM(std.Str.ToUpperCase(stored_firstname)),
																										 SELF.i_name_last := TRIM(std.Str.ToUpperCase(stored_lastname)),
																										 SELF.i_bus_name := search_by.CompanyName,
																										 SELF.i_bus_address := IF(TRIM(search_by.address.streetaddress1)!='', search_by.address.streetaddress1,
																																				 Address.Addr1FromComponents(search_by.address.streetnumber,
																																				 search_by.address.streetpredirection, search_by.address.streetname,
																																				 search_by.address.streetsuffix, search_by.address.streetpostdirection,
																																				 search_by.address.unitdesignation, search_by.address.unitnumber)),
																										 SELF.i_bus_city := search_by.address.City,
																										 SELF.i_bus_state := search_by.address.State,
																										 SELF.i_bus_zip := search_by.address.Zip5,
                                                     SELF.i_bus_phone := search_by.Phone10,
																										 SELF.i_tin := search_by.TIN,
                                                     SELF := LEFT,
																										 SELF := [] ));
		Deltabase_Logging := DATASET([{Deltabase_Logging_prep}], Risk_Reporting.Layouts.LOG_Deltabase_Layout);
		// #stored('Deltabase_Log', Deltabase_Logging);

		//Improved Scout Logging
		IF(~DisableOutcomeTracking, OUTPUT(Deltabase_Logging, NAMED('LOG_log__mbs_transaction__log__scout')));

      
		IF ( 
  (COUNT(possibleResults.records) = 1)
		      AND (
				  possibleResults.Records[1].IsLAFN),
				  FAIL(203,doxie.ErrorCodes(203)),					
				 OUTPUT(Results,named('Results'))
					);
    
  IF( stored_IncludeBusinessCredit, OUTPUT(ds_Royalties, NAMED('RoyaltySet')));
				 				
		// output(DS_search_input, named('DS_Search_input'));
	//output(RecsToSearch, named('search_input_recs_post_CLEANED'));
	// output(DS_search_input, Named('Input_search_values'));
	
	// output(options, named('options'));
	//output(ReturnCnt, named('ReturnCnt'));
	// output(clean_addr, named('clean_addr'));
	// output(stored_addr, named('stored_addr'));
	// output(clean_addr.prim_range, named('prim_range'));
	// output(clean_addr.prim_name, named('prim_name'));
	// output(clean_addr.sec_range, named('sec_range'));
	// output(clean_addr.v_city, named('city'));
	// output(clean_addr.zip, named('zip'));
	// output(clean_addr.state, named('state'));
	 // output(clean_addr182, named('clean_addr182'));
	// output(Results,named('Results'));
																
ENDMACRO;	
