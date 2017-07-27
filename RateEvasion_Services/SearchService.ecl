/*--SOAP--
<message name="SearchService">

	<!-- COMPLIANCE SETTINGS -->
	<part name="GLBPurpose"          type="xsd:byte"/>
	<part name="DPPAPurpose"         type="xsd:byte"/>
	<part name="DataRestrictionMask" type="xsd:string"/>
	<part name="ApplicationType"     type="xsd:string"/>
	
	<!-- SEARCH FIELDS -->
  <part name="UnParsedFullName"    type="xsd:string"/>
	<part name="LastName"            type="xsd:string"/>
	<part name="FirstName"           type="xsd:string"/>
	<part name="MiddleName"          type="xsd:string"/>
	<part name="NameSuffix"				   type="xsd:string"/>
  <part name="prim_range"          type="xsd:string"/>
  <part name="predir"              type="xsd:string"/>
  <part name="prim_name"           type="xsd:string"/>
  <part name="suffix"              type="xsd:string"/>
  <part name="postdir"             type="xsd:string"/>
  <part name="sec_range"           type="xsd:string"/>
  <part name="Addr"                type="xsd:string"/>
  <part name="City"                type="xsd:string"/>
  <part name="State"               type="xsd:string"/>
  <part name="Zip"                 type="xsd:string"/>
	<part name="phone"               type="xsd:string"/>
  <part name="DOB"                 type="xsd:string"/>
	<part name="SSN" 							   type="xsd:string"/>

	<!-- INPUT ONLY (NON-SEARCH) FIELDS -->
  <part name="AgentNumber"          type="xsd:string"/>
  <part name="ClaimNumber"          type="xsd:string"/>
  <part name="PolicyInceptionDate"  type="xsd:string"/>
  <part name="PolicyNumber"         type="xsd:string"/>
  <part name="DateOfLoss"           type="xsd:string"/>
  <part name="ExaminerAdjusterCode" type="xsd:string"/>

	<!-- commented out the line below since couldn't get it to work in conjunction with taking
	     the VINs from the xml input, but left it there in case it can be made to work in the future.
	 part name="VINs"                 type="tns:EspStringArray"/ 
	 -->

  <!-- Search Options -->
  <part name="IncludeScore"                      type="xsd:boolean"/>
  <part name="IncludePreviousAddresses"          type="xsd:boolean"/>
	<part name="IncludeReversePhoneLookup"         type="xsd:boolean"/>
  <part name="IncludeDriverLicense"              type="xsd:boolean"/>
  <part name="IncludeMotorVehicles"              type="xsd:boolean"/>
  <part name="IncludeAdditionalDrivers"          type="xsd:boolean"/>
	<part name="IncludePotentialAdditionalDrivers" type="xsd:boolean"/>

  <!-- New options/fields -->
  <part name="AllowNickNames"      type="xsd:boolean"/>
  <part name="PhoneticMatch"       type="xsd:boolean"/>
  <part name="StrictMatch"         type="xsd:boolean"/>
	<part name="SSNMask" 						 type="xsd:string"/>
  <part name="did"                 type="xsd:string"/>
  <part name="MaxWaitSeconds"      type="xsd:integer"/>

  <!-- Scoring related fields -->
	<part name="CompanyId" 					 type="xsd:string"/>
	<part name="ScoringInfo" 		     type="xsd:string"/>

  <part name="RateEvasionSearchRequest" type="tns:XmlDataSet" cols="80" rows="30" />

</message>
*/
/*--INFO-- Search and return Rate Evasion information.*/

import iesp;

export SearchService := macro
 
 // Line below is used in doxie.header_records to return all records for a did regardless of penalty
  #constant('DialRecordMatch', 5);

  // Get XML input 
  rec_in := iesp.rateevasion.t_RateEvasionSearchRequest;
  ds_in := DATASET ([], rec_in) : STORED ('RateEvasionSearchRequest', FEW);
	first_row := ds_in[1] : independent;

  //set options
	iesp.ECL2ESP.SetInputBaseRequest (first_row);
	// Can't use iesp.ECL2ESP.Marshall.Mac_Set as is normally done, because it sets 
	// ReturnCount which iesp.rateevasion does not have.
  unsigned StartingRecord := global(first_row.options).StartingRecord;
  #stored ('StartingRecord', StartingRecord);

  //set main search criteria:
	search_by := global (first_row.SearchBy);
	
  // Store "search by" search criteria input in xml tags into global attribute names 
	// directly or through the use of iesp.ECL2ESP common functions.
	iesp.ECL2ESP.SetInputName (search_by.Name);  // stores name parts
  iesp.ECL2ESP.SetInputAddress (search_by.Address); // stores address parts
  #stored ('SSN', search_by.SSN);
	iesp.ECL2ESP.SetInputDate (search_by.DOB, 'DOB'); // stores dob date parts yyyymmdd
	#stored ('phone', search_by.Phone10);

  // Save the VINs that come in via xml input.
	// NOTE: could not get it to work to also store them into the soap 'VINs' name, 
	// but that is Ok since the soap field is only needed for internal testing.
  set of string30 xml_in_VINs := set(search_by.VINs, value);
  
	// NOTE: The iesp.rateevasion.t_RateEvasionSearchBy record layout has 4
	// additional fields, 1 for AKA, 1 for Previous Address, 1 for DriverLicenseNumber and 
	// 1 for DriverLicenseState.
	// According to the new Rate Evasion Evaluation Product Specifications dated May 4, 2009; 
	// those 4 are no longer needed.  So they are not included here even though
	// they still exist as fields in the iesp.rateevasion structures.

	// Store standard search options
  iesp.ECL2ESP.SetInputSearchOptions (first_row.Options);
	search_options := global (first_row.Options);

	// Special RateEvasion search options (see iesp.rateevasion.t_RateEvasionSearchOption)
	// NOTE: The iesp.rateevasion.t_RateEvasionSearchOption record layout has 2
	// additional "Include*" fields; 1 for IncludeIdentity and 1 for IncludeBrandedTitles.
	// According to the new Rate Evasion Evaluation Product Specifications dated May 4, 2009; 
	// those 2 options are no longer needed.  So they are not included here even though
	// they still exist as fields in the iesp.rateevasion structures.
  #stored ('IncludeScore', search_options.IncludeScore);
  #stored ('IncludePreviousAddresses', search_options.IncludePreviousAddresses);
	#stored ('IncludeReversePhoneLookup', search_options.IncludeReversePhoneLookup);
  #stored ('IncludeDriverLicense', search_options.IncludeDriverLicense);
  #stored ('IncludeMotorVehicles', search_options.IncludeMotorVehicles);
  #stored ('IncludeAdditionalDrivers', search_options.IncludeAdditionalDrivers);
	#stored ('IncludePotentialAdditionalDrivers', search_options.IncludePotentialAdditionalDrivers);

  handle_xml_date (iesp.share.t_Date xml_in) := FUNCTION
    integer2 Year  := global(xml_in).Year; 
    integer2 Month := global(xml_in).Month; 
    integer2 Day   := global(xml_in).Day;
    unsigned8 date := Year*10000 + Month*100 + Day;
     
	  return date; 
	END;
	
  // Special RateEvasion input insurance related fields 
	// Stored so they can be echoed back in the results
	insurance_info := global (first_row.InsuranceInfo);
  #stored ('AgentNumber', insurance_info.AgentNumber);
  #stored ('ClaimNumber', insurance_info.ClaimNumber);
  #stored ('PolicyInceptionDate', handle_xml_date(insurance_info.PolicyInceptionDate));
	#stored ('PolicyNumber', insurance_info.PolicyNumber);
  #stored ('DateOfLoss', handle_xml_date(insurance_info.DateOfLoss));
  #stored ('ExaminerAdjusterCode', insurance_info.ExaminerAdjusterCode);

	// Save off input CompanyId (which is the customer#) to be used in calculating a score
	// in case no "scoring" information is passed in from ESP.
  #stored ('CompanyId', first_row.User.CompanyId);
  // Store special RateEvasion "Scoring" information, which comes in as an xml encoded 
	// string within the input xml <ScoringInfo> tag.
	#stored ('ScoringInfo', first_row.ScoringInfo);


	input_params := AutoStandardI.GlobalModule();
	tempmod := module(project(input_params,RateEvasion_Services.Search_Records.params,opt));

	  // Store soap/xml input fields unique to Rate Evasion into unique attribute names 
		// to be passed into RateEvasion_Services.Search_Records and then on to Functions.
	  export string20 agent_number  := '' : stored('AgentNumber');
	  export string20 claim_number  := '' : stored('ClaimNumber');
	  export unsigned8 polinc_date  := 0  : stored('PolicyInceptionDate');
	  export string20 policy_number := '' : stored('PolicyNumber');
	  export unsigned8 date_loss    := 0  : stored('DateOfLoss');
	  export string20 exam_adj_code := '' : stored('ExaminerAdjusterCode');
		
	  export boolean include_score              := false : stored('IncludeScore');
	  export boolean include_previousaddresses  := false : stored('IncludePreviousAddresses');
		export boolean include_reversephonelookup := false : stored('IncludeReversePhoneLookup');
	  export boolean include_driverlicense      := false : stored('IncludeDriverLicense');
	  export boolean include_motorvehicles      := false : stored('IncludeMotorVehicles');	
	  export boolean include_additionaldrivers  := false : stored('IncludeAdditionalDrivers');
	  export boolean include_potentialadditionaldrivers := false 
		                                                   : stored('IncludePotentialAdditionalDrivers');

    // Only use the vins that come in from xml input.
		// NOTE: could not get it to work to also store them into the soap 'VINs' name above and
		// then use ... : stored('VINs'); here. 
	  // However that is Ok since the soap field is only needed for internal testing.
    export set of string30 input_vins := xml_in_VINs;

    // 2 lines below added for scoring info changes (Bug 44338)
	  export string20 company_id      := '' : stored('CompanyId');
		export string40000 scoring_info := '' : stored('ScoringInfo');
		export string32 applicationType	:= AutoStandardI.InterfaceTranslator.application_type_val.val(project(input_params,AutoStandardI.InterfaceTranslator.application_type_val.params));

	end;

	temp_results := RateEvasion_Services.Search_Records.val(tempmod);

  // NOTE: Can't use iesp.ECL2ESP.Marshall.MAC_Marshall_Results as done in most other
	// moxie-to-roxie migrated services because iesp.rateevasion.t_RateEvasionSearchResponse
	// doesn't have RecordCount in it's layout nor the appropriate response record structure
	// expected by iesp.ECL2ESP.Marshall.MAC_Marshall_Results.
	results := choosen(temp_results, iesp.ECL2ESP.Marshall.max_return, 
	                                 iesp.ECL2ESP.Marshall.starting_record);


  // Uncomment line below for debugging
	//output(xml_in_VINs,named('ss_xml_in_VINs'));
	//output(tempmod.input_VINs,named('ss_input_VINs'));
	//output(temp_results,named('ss_temp_results'));
	
  output(results,named('Results'));

endmacro;

// For testing/debugging in a web form xml text area
//SearchService ();

/*
<RateEvasionSearchRequest>
<row>
<User>
  <ReferenceCode></ReferenceCode>
  <BillingCode></BillingCode>
  <QueryId></QueryId>
	<CompanyId></CompanyId>
  <GLBPurpose></GLBPurpose>
  <DLPurpose></DLPurpose>
  <SSNMask></SSNMask>
  <EndUser>
    <CompanyName></CompanyName>
    <StreetAddress1></StreetAddress1>
    <City></City>
    <State></State>
    <Zip5></Zip5>
  </EndUser>
  <MaxWaitSeconds></MaxWaitSeconds>
</User>
<CarFaxUniqueId></CarFaxUniqueId>
<TargetCompanyId></TargetCompanyId>
<ScoringInfo>
&lt;scoring&gt;
        &lt;version&gt;1.4&lt;/version&gt;
        &lt;author&gt;Scott Schneck&lt;/author&gt;
        &lt;target-company&gt;1031131 (Maryland Automobile Insurance Fund)&lt;/target-company&gt;
        &lt;date-updated&gt;09/06/2005&lt;/date-updated&gt;
        &lt;time-updated&gt;17:22&lt;/time-updated&gt;
        &lt;source-file&gt;batch04:/batch04_v/bps/utils/perlscripts/MAIFIndex.csv&lt;/source-file&gt;
        &lt;company-id&gt;1024634&lt;/company-id&gt;
        &lt;company-name&gt;Accurint for Insurance&lt;/company-name&gt;
        &lt;element-scores&gt;
                &lt;first-name&gt;
                        &lt;match&gt;5&lt;/match&gt;
                        &lt;no-match&gt;0&lt;/no-match&gt;
                        &lt;output-missing&gt;0&lt;/output-missing&gt;
                &lt;/first-name&gt;
                &lt;last-name&gt;
                        &lt;match&gt;15&lt;/match&gt;
                        &lt;no-match&gt;0&lt;/no-match&gt;
                        &lt;output-missing&gt;0&lt;/output-missing&gt;
                &lt;/last-name&gt;
                &lt;address&gt;
                        &lt;match&gt;20&lt;/match&gt;
                        &lt;no-match&gt;0&lt;/no-match&gt;
                        &lt;output-missing&gt;0&lt;/output-missing&gt;
                &lt;/address&gt;
                &lt;city&gt;
                        &lt;match&gt;0&lt;/match&gt;
                        &lt;no-match&gt;0&lt;/no-match&gt;
                        &lt;output-missing&gt;0&lt;/output-missing&gt;
                &lt;/city&gt;
                &lt;state&gt;
                        &lt;match&gt;25&lt;/match&gt;
                        &lt;no-match&gt;0&lt;/no-match&gt;
                        &lt;output-missing&gt;0&lt;/output-missing&gt;
                &lt;/state&gt;
                &lt;zip&gt;
                        &lt;match&gt;25&lt;/match&gt;
                        &lt;no-match&gt;0&lt;/no-match&gt;
                        &lt;output-missing&gt;0&lt;/output-missing&gt;
                &lt;/zip&gt;
                &lt;ssn&gt;
                        &lt;match&gt;0&lt;/match&gt;
                        &lt;no-match&gt;5&lt;/no-match&gt;
                        &lt;output-missing&gt;5&lt;/output-missing&gt;
                &lt;/ssn&gt;
                &lt;dob&gt;
                        &lt;match&gt;3&lt;/match&gt;
                        &lt;no-match&gt;5&lt;/no-match&gt;
                        &lt;output-missing&gt;5&lt;/output-missing&gt;
                &lt;/dob&gt;
                &lt;phone&gt;
                        &lt;match&gt;7&lt;/match&gt;
                        &lt;no-match&gt;5&lt;/no-match&gt;
                        &lt;output-missing&gt;5&lt;/output-missing&gt;
                &lt;/phone&gt;
        &lt;/element-scores&gt;
        &lt;combi-elements&gt;
        &lt;/combi-elements&gt;
        &lt;risk-indicators&gt;
        &lt;/risk-indicators&gt;
&lt;/scoring&gt;
</ScoringInfo>
<Options>
  <StrictMatch>false</StrictMatch>
  <UseNicknames>false</UseNicknames>
  <IncludeAlsoFound>false</IncludeAlsoFound>
  <UsePhonetics>false</UsePhonetics>
  <PenaltyThreshold>20</PenaltyThreshold>
  <StartingRecord>1</StartingRecord>
  <IncludeScore>false</IncludeScore>
  <IncludePreviousAddresses>false</IncludePreviousAddresses>
  <IncludeReversePhoneLookup>false</IncludeReversePhoneLookup>
  <IncludeDriverLicense>false</IncludeDriverLicense>
  <IncludeMotorVehicles>false</IncludeMotorVehicles>
  <IncludeAdditionalDrivers>false</IncludeAdditionalDrivers>
  <IncludePotentialAdditionalDrivers>false</IncludePotentialAdditionalDrivers>
</Options>
<SearchBy>
  <Name>
    <Full></Full>
    <First></First>
    <Middle></Middle>
    <Last></Last>
    <Suffix></Suffix>
    <Prefix></Prefix>
  </Name>
  <Address>
    <StreetName></StreetName>
    <StreetNumber></StreetNumber>
    <StreetPreDirection></StreetPreDirection>
    <StreetPostDirection></StreetPostDirection>
    <StreetSuffix></StreetSuffix>
    <UnitDesignation></UnitDesignation>
    <UnitNumber></UnitNumber>
    <StreetAddress1></StreetAddress1>
    <StreetAddress2></StreetAddress2>
    <State></State>
    <City></City>
    <Zip5></Zip5>
    <Zip4></Zip4>
    <County></County>
    <PostalCode></PostalCode>
    <StateCityZip></StateCityZip>
  </Address>
  <SSN></SSN>
  <DOB>
    <Year></Year>
    <Month></Month>
    <Day></Day>
  </DOB>
  <Phone10></Phone10>
  <VINs>
    <VIN></VIN>
    <VIN></VIN>
    <VIN></VIN>
    <VIN></VIN>
    <VIN></VIN>
    <VIN></VIN>
    <VIN></VIN>
    <VIN></VIN>
  </VINs>
</SearchBy>
<InsuranceInfo>
  <AgentNumber></AgentNumber>
  <ClaimNumber></ClaimNumber>
  <PolicyInceptionDate>
    <Year></Year>
    <Month></Month>
    <Day></Day>
  </PolicyInceptionDate>
  <PolicyNumber></PolicyNumber>
  <DateOfLoss>
    <Year></Year>
    <Month></Month>
    <Day></Day>
  </DateOfLoss>
  <ExaminerAdjusterCode></ExaminerAdjusterCode>
</InsuranceInfo>
</row>
</RateEvasionSearchRequest>
*/
