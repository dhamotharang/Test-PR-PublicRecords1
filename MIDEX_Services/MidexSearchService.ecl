/*--SOAP--
<message name="MidexSearchService">

	<!-- COMPLIANCE/USER SETTINGS -->
	<part name="GLBPurpose"               type="xsd:byte"/>
	<part name="DPPAPurpose"              type="xsd:byte"/>
	<part name="DataPermissionMask"       type="xsd:STRING"/>
  
	<part name="Full"                     type="xsd:string"/>
  <part name="FirstName"                type="xsd:string"/>
  <part name="MiddleName"               type="xsd:string"/>
  <part name="LastName"                 type="xsd:string"/>
	<part name="SSN"          			      type="xsd:string"/>       //l/c ssn in AutoStandardI.GlobalModule???
	<part name="SSNLast4"      			      type="xsd:string"/>
  <part name="DOB"                      type="xsd:string"/> 
  
	<part name="companyName"              type="xsd:string"/>
	<part name="TIN"                      type="xsd:string"/>
  <part name="NMLSId"                   type="xsd:string"/>

	<part name="DID"                      type="xsd:string"/>     // (LexId)
  
  <part name="Addr"                     type="xsd:string"/>
  <part name="City"                     type="xsd:string"/>
  <part name="State"                    type="xsd:string"/>
  <part name="Zip"                      type="xsd:string"/>
	<part name="Phone"                    type="xsd:string"/> 

  <part name="LicenseNumber"            type="xsd:string"/>
  <part name="LicenseState"             type="xsd:string"/>

  <part name="StartLoadDate"            type="xsd:string"/>

  <part name="MidexReportNumber"        type="xsd:string"/>
  
	<!-- INTERNAL TESTING FIELDS/OPTIONS -->
  <part name="NoDeepDive"               type="xsd:boolean"     default="true"/>  //???
	<part name="PenaltThreshold"	        type="xsd:unsignedInt" default="0"/>     //or 10 ???

	<part name="ReturnCount"			        type="xsd:unsignedInt"/>
	<part name="StartingRecord"		        type="xsd:unsignedInt"/>

	<part name="ReturnAllRecords"         type="xsd:boolean"/>

  <part name="MIDEXRecordSearchRequest" type="tns:XmlDataSet" cols="80" rows="30" />

</message>
*/
/*--INFO-- Search and return Midex information.*/
// <message name="Midex DataPermissionMask: Position 8=1: Nonpublic included, 9=1: Freddie Mac included">
  
IMPORT AutoStandardI, iesp;

EXPORT MidexSearchService := 
  MACRO


    #CONSTANT('AllowNickNames',TRUE); // used to find the best subject for the input data
    #CONSTANT('PhoneticMatch', TRUE);  // used to find the best subject for the input data

    // Get XML input 
    rec_in    := iesp.midexrecordsearch.t_MIDEXRecordSearchRequest;
    ds_in     := DATASET ([], rec_in) : STORED ('MIDEXRecordSearchRequest', FEW);
    first_row := ds_in[1] : INDEPENDENT;

    // Set global options
    iesp.ECL2ESP.SetInputBaseRequest(first_row);  //dppa, glba, data restriction mask & ssn mask
    // Set/store common input RecordCount & StartingRecord options   //???
    iesp.ECL2ESP.Marshall.Mac_Set (first_row.options);

    // Store main search criteria:
    search_by   := GLOBAL(first_row.SearchBy);
    options     := GLOBAL(first_row.Options);
		alert_Input := GLOBAL(first_row.AlertInput);

    // Store common person & company ssn/fein/name/address/dob/phone xml inputs
    #STORED('ssn',                     search_by.SSN);
    #STORED('SSNLast4',                search_by.SSNLast4);
    #STORED('LicenseNumber',           search_by.LicenseNumber);
    #STORED('LicenseState',            search_by.LicenseState);
    #STORED('Phone',                   search_by.Phone10);
    #STORED('DID',                     search_by.UniqueId); 
    #STORED('MIDEXReportNumber',       search_by.MIDEXReportNumber);
    #STORED('TIN',                     search_by.TIN);
    #STORED('companyName',             search_by.companyName);
		#STORED('NMLSId',                  search_by.NMLSId);
	  #STORED('StartLoadDate',           iesp.ECL2ESP.t_DateToString8(search_by.StartLoadDate));
    // #STORED('StartLoadDate',           iesp.ECL2ESP.DateToString(search_by.StartLoadDate));
    #STORED('EnableAlert',             alert_Input.EnableAlert);
    
    iesp.ECL2ESP.SetInputName    (search_by.Name);
    iesp.ECL2ESP.SetInputAddress (search_by.Address);
  
    // *** Start of processing
    input_params := AutoStandardI.GlobalModule();
    
		// Get alert input
		ds_Search_hashes := PROJECT(alert_Input.Hashes,TRANSFORM(MIDEX_Services.Layouts.hash_layout,
																																		SELF.all_hash := (Integer)LEFT.HashValue,
																																		SELF := []));
    
    unsigned1 vAlertVersion := IF(alert_input.AlertVersion = Midex_Services.Constants.AlertVersion.None,
                                  Midex_Services.Constants.AlertVersion.Current,
                                  alert_input.AlertVersion);
    
    tempmod := MODULE(PROJECT(input_params,MIDEX_Services.Iparam.searchrecords,OPT));
      // SearchBy fields not handled by AutoStandardI.GlobalModule
      EXPORT STRING4   ssn_last4               := ''    : STORED('SSNLast4');
      EXPORT STRING20  license_number          := ''    : STORED('LicenseNumber'); 
      EXPORT STRING20  license_state           := ''    : STORED('LicenseState');
      EXPORT STRING26  midex_rpt_num           := ''    : STORED('MIDEXReportNumber');
      EXPORT STRING40  TIN                     := ''    : STORED('TIN');
      EXPORT STRING50  NMLSId                  := ''    : STORED('NMLSId');
      EXPORT DATASET   searchHashes 		       := ds_Search_Hashes;
			EXPORT UNSIGNED8 dob_filter 			       := iesp.ECL2ESP.DateToInteger(search_by.DOB);
      EXPORT STRING8   StartLoadDate           := ''    : STORED('StartLoadDate');
			EXPORT BOOLEAN   EnableAlert 			       := FALSE	: STORED('EnableAlert');
			EXPORT UNSIGNED1 AlertVersion            := IF(alert_Input.EnableAlert,
                                                      vAlertVersion,
                                                      Midex_Services.Constants.AlertVersion.None);
			EXPORT BOOLEAN   ReturnAllRecords        := alert_Input.ReturnAllRecords	: STORED('ReturnAllRecords');
    END;

    ds_results := Midex_Services.MidexSearch_Records(tempmod);

    OUTPUT(ds_results, NAMED('Results'));

  ENDMACRO;

/*
For testing/debugging: 
1. In the "MidexSearchRequest" xml text area, use the sample xml input below 
   filling in:
   a. the appropriate input/search data fields,
   b. the appropriate common input/search options, (DPA, GLB, DRM, etc.) 
   c. the product search specific ??? option (if needed/desired)

<MidexSearchRequest>
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
  <IncludeNonPublic></IncludeNonPublic>
  <IncludeFreddieMac></IncludeFreddieMac>
  </Options>
</row>
</MidexSearchRequest>
*/
