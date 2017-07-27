/*--SOAP--
<message name="BusinessSearch">
	
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
	<part name="TopBusinessSearchRequest" type="tns:XmlDataSet" cols="80" rows="30"/>
	
</message>
*/
/*--INFO-- This service produces a business search results list.*/


IMPORT BIPV2, BusinessCredit_Services, iesp, TopBusiness_Services;
export BusinessSearch() := macro

	// Get XML input
	

	rec_in := iesp.TopBusinessSearch.t_TopBusinessSearchRequest;
	ds_in := dataset([],rec_in) : stored('TopBusinessSearchRequest',few);
	first_row := ds_in[1] : independent;
	
	// Set some base options
	iesp.ECL2ESP.SetInputBaseRequest (first_row);
	
	// Set DPPA, GLBA, DRM, etc.
	iesp.ECL2ESP.SetInputUser (first_row.User);
	
	// Store main search criteria
	search_by := global(first_row.SearchBy);
	options_by := global(first_row.Options);
	user_options := global(first_row.User);
	#stored('CompanyName',search_by.CompanyName);
	#stored('TIN',search_by.TIN);
	
	iesp.ECL2ESP.SetInputAddress(search_by.Address);  // this sets #stored for prim_name, prim_range
	                                                 // city, state, zip5
	#stored('Radius',search_by.Radius);
	#stored('PhoneNumber',search_by.Phone10);
	#stored('URL',search_by.URL);
	#stored('Email',search_by.Email);
	iesp.ECL2ESP.SetInputName(search_by.Name);
	#stored('SIC',search_by.SIC);
	#stored('SeleID',search_by.SeleID);
	#stored('SSN',Search_by.SSN);
	#stored('Allow7DigitMatch',options_by.Allow7DigitMatch);
	#stored('HSort',options_by.HSort);
	
	// Store search options
	iesp.ECL2ESP.Marshall.Mac_Set(options_by);
	
	#stored('LnBranded',user_options.LnBranded);
  #stored('IncludeBusinessCredit', options_by.IncludeBusinessCredit);
  
	integer ReturnCnt := 0 : stored('ReturnCount');

	#WEBSERVICE(FIELDS('DPPAPurpose',
											'GLBPurpose',
											'ApplicationType',
											'DataPermissionMask',
											'DataRestrictionMask',
											'SELEID',
											'CompanyName',
											'TIN',
											'ADDR',
											'CITY',
											'STATE',
											'ZIP',
											'sec_range',
											'Radius',
											'PhoneNumber',
											'URL',
											'Email',
											'FirstName',
											'MiddleName',
											'LastName',
											'SIC',
											'SSN',
											'SSNMask',
											'Hsort',
											'LnBranded',
                      'IncludeBusinessCredit',
											'StartingRecord',
											'ReturnCount',
                      'TopBusinessSearchRequest'));
                      
                      
	// Get back the DPPA, GLBA, DRM, etc
	unsigned1 stored_dppa_purpose := 0 : stored('DPPAPurpose');
	unsigned1 stored_glb_purpose := 0 : stored('GLBPurpose');
	string32 stored_App_type := '' : stored('ApplicationType');
	string stored_datarestrictionmask := '' : stored('DataRestrictionMask');
	unsigned4 maxResults := 0; // removed the ability to set this via stored.
	                           // per request from above. 0 set here turns into 50
														 // later on downstream within salt.
	// Get back the search criteria
	string stored_companyname := '' : stored('CompanyName');
	string stored_tin := '' : stored('TIN');
	
  // stored_addr is set from the call to iesp.ECL2ESP.SetInputAddress above
	string stored_addr       := '' : stored('Addr'); 
	///////////////////////////////////////////////////////////
	string stored_city       := '' : stored('City');
	string stored_state      := '' : stored('State');
	string stored_zip        := '' : stored('Zip');
	string stored_sec_range  := '' : stored('sec_range');
	unsigned stored_radius   := 0  : stored('Radius');
	string stored_phone10    := '' : stored('PhoneNumber');
	string stored_url        := '' : stored('URL');
	string stored_email      := '' : stored('Email');
	string stored_lastname   := '' : stored('LastName');
	string stored_firstname  := '' : stored('FirstName');
	string stored_middlename := '' : stored('MiddleName');
	// SIC will be not passed into external linking but will be used as a post filter.
	string stored_sic                    := '' : stored('SIC');
	string stored_seleid                 := '' : stored('SeleID');
	string stored_ssn                    := '' : stored('SSN');
	boolean stored_allow7DigitMatch      := false : stored('Allow7DigitMatch');
	boolean stored_HSort                 := true : stored('HSort');
	boolean stored_lnbranded             := false : stored('LnBranded');
	boolean stored_IncludeBusinessCredit := false: stored('IncludeBusinessCredit');
  
	derived_city  :=   stringlib.StringToUpperCase(stored_city);
	derived_state :=   stringlib.StringToUpperCase(stored_state);
	derived_zip   :=   stringlib.StringToUpperCase(stored_zip);
	
		addr2 := Address.Addr2FromComponents(derived_city, derived_state, derived_zip);
		
    // determine if data passed via <streetAddress1> or in individual fields i.e. parsed or unparsed use accordingly.
		
		UNSIGNED1 region := address.Components.Country.US; // default
		
		clean_addr := Address.GetCleanAddress(stored_addr, addr2, region).results;
		
	  BIPV2.IDFunctions.rec_SearchInput
	                               setInputSearchRec() := transform																									 
		self.zip_radius_miles := stored_radius;
	  self.company_name := trim(stringlib.StringToUpperCase(stored_companyname), left, right); // cleaned by linking inside function call.
	  self.prim_range :=  trim(stringlib.StringToUpperCase(clean_addr.prim_range), left, right);
	  self.prim_name :=  trim(stringlib.StringToUpperCase(clean_addr.prim_name), left, right);
	
	  self.zip5 := if (stored_zip <> '', stored_zip, clean_addr.zip);
	  self.sec_range := clean_addr.sec_range;
	  self.city := if (clean_addr.v_city <> '',
		                  clean_addr.v_city,		                  
		                   trim(stringlib.StringToUpperCase(stored_city), left, right)
											  );
	  self.state := if (trim(stringlib.StringToUpperCase(stored_state), left, right) <> '',
		                   trim(stringlib.StringToUpperCase(stored_state), left, right),
											 clean_addr.state);
	  self.phone10 := stringlib.StringFilter(stored_phone10,'0123456789');
	  self.fein := stringlib.StringFilter(stored_tin,'0123456789'),
	  self.URL := trim(stringlib.StringToUpperCase(stored_url), left, right); // more work done here for validation.
	  self.Email := trim(stringlib.StringToUpperCase(stored_email), left, right);
	  self.Contact_fname := trim(stringlib.StringToUpperCase(stored_firstname), left, right);
	  self.Contact_mname := trim(stringlib.STringTOUpperCase(stored_middlename), left, right);
	  self.Contact_lname := trim(stringlib.StringToUpperCase(stored_lastname), left, right);
		self.Sic_Code := stored_sic;
		self.Results_limit := MaxResults;
		self.contact_SSN := stored_ssn;
		self.inSeleID := stringlib.StringFilter(stored_seleid,'0123456789'),
		self.allow7DigitMatch := stored_allow7DigitMatch;
		self.HSort := stored_HSort;
    self.acctno := '';
		self := [];
	end;
	
	DS_search_input := dataset([setInputSearchRec()]);
	
	tempmod := module(AutoStandardI.DataRestrictionI.params)  
		export boolean AllowAll := false;
		export boolean AllowDPPA := false;
		export boolean AllowGLB := false;
		export string DataRestrictionMask := stored_datarestrictionmask;
		export unsigned1 DPPAPurpose := stored_dppa_purpose;
		export unsigned1 GLBPurpose := stored_glb_purpose;
		export boolean ignoreFares := false;
		export boolean ignoreFidelity := false;
		export boolean includeMinors := false;
	end;

TopBusiness_Services.BusinessSearch_Layouts.OptionsLayout search_options() := transform		
	  self.lnbranded := stored_lnbranded;		
		self.internal_testing := false; //stored_internal_testing;	
    self.IncludeBusinessCredit := stored_IncludeBusinessCredit;
	end;
	
	options := row(search_options());  
		
  possibleResults := TopBusiness_Services.BusinessSearch_Records.Search(DS_search_input,
	                 options,
	                 tempmod).recs;
				
  tmpRecs := project(possibleResults.records, 
           transform(iesp.TopBusinessSearch.t_TopBusinessSearchRecord, 
                                     self := left;
                                       self := []));	
                                
  iesp.ECL2ESP.Marshall.MAC_Marshall_Results(tmpRecs, results, iesp.TopBusinessSearch.t_TopBusinessSearchResponse);
 
  BizCredRecsOnlyCount       := COUNT(tmpRecs( BusinessCreditIndicator = BusinessCredit_Services.Constants.BUSINESS_CREDIT_INDICATOR.BUSINESS_CREDIT_ONLY));
  ds_BizCredCountRoyalLayout := DATASET([{BizCredRecsOnlyCount}], {INTEGER SBFEAccountCount});
  ds_BizCredRecsRoyalties    := Royalty.RoyaltySBFE.GetOnlineRoyalties( ds_BizCredCountRoyalLayout );       
  ds_Royalties               := DATASET([], Royalty.Layouts.Royalty) + 
                                IF(stored_IncludeBusinessCredit, ds_BizCredRecsRoyalties);
      
		if ( 
  (count(possibleResults.records) = 1)
		      and (
				  possibleResults.Records[1].IsLAFN),
				  fail(203,doxie.ErrorCodes(203)),					
				 output(Results,named('Results'))
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

			

