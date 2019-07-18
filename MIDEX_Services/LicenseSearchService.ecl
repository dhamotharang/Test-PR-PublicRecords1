/*--SOAP--
<message name="LicenseSearchService">

	<!-- COMPLIANCE/USER SETTINGS -->
	<part name="GLBPurpose"          type="xsd:byte"/>
	<part name="DPPAPurpose"         type="xsd:byte"/>
	<part name="DataPermissionMask" type="xsd:string"/>
	<part name="SSNMask" 					   type="xsd:string"/>
	<part name="ApplicationType"   	 type="xsd:string"/>
  <part name="MaxWaitSeconds"      type="xsd:integer"/>
	
	<!-- SEARCH FIELDS/OPTIONS, order matches WEB/GUI search form -->
  <part name="SSN"          			 type="xsd:string"/> 
	<part name="SSNLast4"      			 type="xsd:string"/>
	<part name="UnParsedFullName"    type="xsd:string"/>
	<part name="LastName"            type="xsd:string"/>
	<part name="FirstName"           type="xsd:string"/>
	<part name="MiddleName"          type="xsd:string"/>
  <part name="allowNicknames"      type="xsd:boolean"/>
  <part name="PhoneticMatch"       type="xsd:boolean"/>
	<part name="DOB"                 type="xsd:unsignedInt"/>
  <part name="Tin"          			 type="xsd:string"/>
  <part name="CompanyName"         type="xsd:string"/>
  <part name="Addr"                type="xsd:string"/>
  <part name="City"                type="xsd:string"/>
  <part name="State"               type="xsd:string"/>
  <part name="Zip"                 type="xsd:string"/>
	<part name="Phone"               type="xsd:string"/> 
  <part name="LicenseNumber"       type="xsd:string"/>
	<part name="LicenseState"        type="xsd:string"/>
	<part name="NmlsID"              type="xsd:string"/>

	<!-- INTERNAL TESTING FIELDS/OPTIONS -->
  <part name="NoDeepDive"          type="xsd:boolean"     default="true"/>  //???
  <part name="did"                 type="xsd:string"/>

	<part name="ReturnCount"			   type="xsd:unsignedInt"/>
	<part name="StartingRecord"		   type="xsd:unsignedInt"/>
			
  <part name="MIDEXLicenseSearchRequest" type="tns:XmlDataSet" cols="80" rows="30" />

</message>
*/
/*--INFO-- Search and return Midex License information.*/
import AutoStandardI,doxie,iesp,MIDEX_Services;

export LicenseSearchService := macro
	
	// Get XML input 
  rec_in := iesp.midexlicensesearch.t_MIDEXLicenseSearchRequest;
  ds_in := DATASET ([], rec_in) : STORED ('MIDEXLicenseSearchRequest', FEW);
	first_row := ds_in[1] : independent;

  // Set input options
	iesp.ECL2ESP.SetInputBaseRequest (first_row);
  iesp.ECL2ESP.Marshall.Mac_Set (first_row.options);

  // Store main search criteria:
	search_by := global (first_row.SearchBy);
	alert_Input := global(first_row.AlertInput);
	
	// Store search options
	options_by := global(first_row.Options);
	
  // Store common person & company ssn/ssn4/tin/name/address/phone/license Number xml inputs
	#stored ('ssn', search_by.SSN);
  #STORED ('SSNLast4', search_by.SSNLast4);

	iesp.ECL2ESP.SetInputName (search_by.Name);
  #stored ('CompanyName', search_by.CompanyName);

  iesp.ECL2ESP.SetInputAddress (search_by.Address);
	#stored ('Phone', search_by.Phone); 
	#stored ('did', search_by.UniqueID);

  // Store product specific license number xml input
	#stored ('LicenseNumber', search_by.LicenseNumber);
	#stored ('LicenseState', search_by.LicenseState);
	#stored ('Tin', search_by.Tin);
	#stored ('NmlsID', search_by.NmlsID);
				
  // *** Start of processing
  input_params := AutoStandardI.GlobalModule();
	
	// Get alert input
	ds_Search_hashes := PROJECT(alert_Input.Hashes,TRANSFORM(MIDEX_Services.Layouts.hash_layout,
																																		SELF.all_hash := (Integer)LEFT.HashValue,
																																		SELF := []));				
  
  unsigned1 vAlertVersion := IF(alert_input.AlertVersion = Midex_Services.Constants.AlertVersion.None,
                                Midex_Services.Constants.AlertVersion.Current,
                                alert_input.AlertVersion);
  
	tempmod := module(project(input_params,Midex_Services.Iparam.searchrecords,opt));
    // SearchBy fields not handled by AutoStandardI.GlobalModule
		EXPORT STRING4   ssn_last4        := '' : STORED('SSNLast4');
    export dataset   searchHashes     := ds_Search_Hashes;
	  export string20  license_number   := '' : stored('LicenseNumber');
		export string20  license_state    := '' : stored('LicenseState');
		export string40  tin              := '' : stored('Tin');
		export string40  nmls_id          := '' : stored('NmlsID');
		export unsigned8 dob_filter       := iesp.ECL2ESP.DateToInteger(search_by.DOB);     
		export boolean   EnableAlert      := alert_Input.EnableAlert;
    // ReturnAllRecords option not being used any more. Just kept it if ESP or portal needs this option in the future
		export boolean   ReturnAllRecords := alert_Input.ReturnAllRecords : stored('ReturnAllRecords');
		export unsigned1 AlertVersion     := IF(alert_input.EnableAlert,
                                            vAlertVersion,
                                            Midex_Services.Constants.AlertVersion.None);
	end;

  mod_access := doxie.compliance.GetGlobalDataAccessModuleTranslated(input_params);
  ds_results := Midex_Services.LicenseSearch_Records(tempmod, mod_access);
  
  // Output the search results
  output(ds_results, named('Results'));
	

endmacro;

/*
For testing/debugging: 
1. In the "LicenseSearchRequest" xml text area, use the sample xml input below 
   filling in:
   a. the appropriate input/search data fields,
   b. the appropriate common input/search options, (DPA, GLB, DRM, etc.) 
   c. the product search specific ??? option (if needed/desired)

<LicenseSearchRequest>
<row>
 <User>
  <GLBPurpose></GLBPurpose>
  <DLPurpose></DLPurpose>
  <DataRestrictionMask>000000000000000</DataRestrictionMask>
  <SSNMask></SSNMask>
  <ApplicationType></ApplicationType>
 </User>
 <SearchBy>
  <SSN></SSN>
  <FEIN></FEIN>
  <Name>
   <Full></Full>
   <First></First>
   <Middle></Middle>
   <Last></Last>
   <Suffix></Suffix>
   <Prefix></Prefix>
  </Name>
  <CompanyName></CompanyName>
  <DOB>
    <Year></Year>
    <Month></Month>
    <Day></Day>
  </DOB>
  <Address>
   <StreetAddress1></StreetAddress1>
   <State></State>
   <City></City>
   <Zip5></Zip5>
   <Zip4></Zip4>
  </Address>
  <Phone10></Phone10>
  <LicenseNumber></LicenseNumber>
  <UniqueID></UniqueID>
  <BDID></BDID>
 </SearchBy>
 <alertInput>
	<EnableAlert>true</EnableAlert>
	<Hashes>
		<Hash><Version>1</Version><HashValue>434234354235</HashValue></Hash>
		<Hash><Version>1</Version><HashValue>671208640055</HashValue></Hash>
	</Hashes>
 </alertInput>
 <Options>
  <UseNicknames>false</UseNicknames>
  <UsePhonetics>false</UsePhonetics>
  <ReturnCount>2000</ReturnCount>
  <StartingRecord></StartingRecord>
  </Options>
</row>
</LicenseSearchRequest>
*/