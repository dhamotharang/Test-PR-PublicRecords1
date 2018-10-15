/*--SOAP--
<message name="SearchService">
  <part name="DID" type="xsd:string" />
  <part name="BDID" type="xsd:string" />
  <part name="RegistrationNumber" type="xsd:string"/>
  <separator/>
  <part name="CompanyName" type = "xsd:string"/>
  <part name="SSN" type="xsd:string"/>
	<part name="SSNMask" type="xsd:string"/>
  <part name="FirstName" type="xsd:string"/>
  <part name="AllowNickNames" type="xsd:boolean"/>
  <part name="LastName" type="xsd:string"/>
  <part name="PhoneticMatch" type="xsd:boolean"/>
  <part name="MiddleName" type="xsd:string"/>
  <part name="UnparsedFullName" type="xsd:string"/>  
  <separator/>
  <part name="Addr" type="xsd:string"/>
  <part name="City" type="xsd:string"/>
  <part name="State" type="xsd:string"/>
  <part name="Zip" type="xsd:string"/>
  <separator/>
  <part name="MaxResults" type="xsd:unsignedInt"/>
  <part name="MaxResultsThisTime" type="xsd:unsignedInt"/>
  <part name="SkipRecords" type="xsd:unsignedInt"/>
  <part name="DPPAPurpose" type="xsd:byte" default="1"/>
  <part name="GLBPurpose" type="xsd:byte" default="1"/> 
  <part name="NoDeepDive" type="xsd:boolean" default="1"/> 
  <part name="PenaltThreshold" type="xsd:unsignedInt" default="100"/>
  <part name="StrictMatch" type="xsd:boolean"/>
 	<part name="ApplicationType" type="xsd:string"/>

  <part name="DEASearchRequest" type="tns:XmlDataSet" cols="80" rows="30" />
</message>
*/
/*--INFO-- DEA controlled substances (ESP-compliant output)*/


IMPORT iesp, AutoStandardI, doxie;

EXPORT SearchService := MACRO
  #CONSTANT ('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.SALT);
  #constant('SearchGoodSSNOnly',TRUE);
  #constant('SearchIgnoresAddressOnly',TRUE);
  #constant('getBdidsbyExecutive',FALSE);

  ds_in := DATASET ([], iesp.controlledsubstance.t_DEASearchRequest) : STORED ('DEASearchRequest', FEW);
  first_row := ds_in[1] : independent;

  //set options
  iesp.ECL2ESP.SetInputBaseRequest (first_row);
  iesp.ECL2ESP.Marshall.Mac_Set (first_row.options);

  //set main search criteria:
  search_by := global (first_row.SearchBy);
  iesp.ECL2ESP.SetInputName (search_by.Name);
  iesp.ECL2ESP.SetInputAddress (search_by.Address);
  iesp.ECL2ESP.SetInputSearchOptions (first_row.options);

  //process input specific for this service:
  #stored ('RegistrationNumber', search_by.DEARegistrationNumber);
  #stored ('SSN', search_by.SSN);
  #stored ('CompanyName', search_by.CompanyName);
  #stored ('DID',search_by.UniqueId);
  input_params := AutoStandardI.GlobalModule();
			
	tempmod := module(project(input_params,DEA_Services.Records.params,opt))  
			EXPORT string9 dea_registration_number := '' : stored ('RegistrationNumber');
			EXPORT STRING32 ApplicationType := AutoStandardI.InterfaceTranslator.application_type_val.val(project(input_params, AutoStandardI.InterfaceTranslator.application_type_val.params));
			EXPORT STRING6 SSNMASK 			:= 'NONE' : stored('SSNMask');
 end;
  
 	tmp := DEA_Services.Records.val(tempmod);

	 iesp.ECL2ESP.Marshall.MAC_Marshall_Results (tmp, results, iesp.controlledsubstance.t_DEASearchResponse);
	
  output(results, named('Results'));
ENDMACRO;
// SearchService ();

/*
<DEASearchRequest>
<row>
<User>
  <ReferenceCode></ReferenceCode>
  <BillingCode></BillingCode>
  <QueryId></QueryId>
  <GLBPurpose>1</GLBPurpose>
  <DLPurpose>1</DLPurpose>
  <EndUser/>
</User>
<Options>
  <ReturnCount>10</ReturnCount>
  <StartingRecord>1</StartingRecord>
  <UseNicknames>1</UseNicknames>
  <IncludeAlsoFound>0</IncludeAlsoFound>
  <UsePhonetics>0</UsePhonetics>
  <StrictMatch>0</StrictMatch>
</Options>
<SearchBy>
  <DEARegistrationNumber></DEARegistrationNumber>
  <SSN></SSN>
  <CompanyName></CompanyName>
  <Name>
    <Full></Full>
    <First></First>
    <Middle></Middle>
    <Last></Last>
  </Name>
  <Address>
    <StreetName></StreetName>
    <StreetNumber></StreetNumber>
    <StreetSuffix></StreetSuffix>
    <UnitNumber></UnitNumber>
    <State></State>
    <City></City>
    <Zip5></Zip5>
  </Address>
</SearchBy>
</row>
</DEASearchRequest>
*/
