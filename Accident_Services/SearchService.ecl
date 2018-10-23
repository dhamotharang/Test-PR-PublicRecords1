/*--SOAP--
<message name="SearchService">

	<!-- COMPLIANCE SETTINGS -->
	<part name="GLBPurpose"          type="xsd:byte"/>
	<part name="DPPAPurpose"         type="xsd:byte"/>
	<part name="MaxWaitSeconds"      type="xsd:integer"/>
	<part name="ApplicationType"     type="xsd:string"/>

	<!-- SEARCH FIELDS -->
	<part name="UnParsedFullName"    type="xsd:string"/>
	<part name="FirstName"           type="xsd:string"/>
	<part name="MiddleName"          type="xsd:string"/>
	<part name="LastName"            type="xsd:string"/>
	<part name="NameSuffix"          type="xsd:string"/>

	<part name="allowNicknames"      type="xsd:boolean"/>
	<part name="PhoneticMatch"       type="xsd:boolean"/>

	<part name="CompanyName"         type="xsd:string"/>

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

	<part name="AccidentNumber"      type="xsd:string"/>
	<part name="AccidentState"       type="xsd:string"/>
	<part name='AccidentDate'				 type='xsd:unsignedInt'/>
	<part name="DriverLicenseNumber" type="xsd:string"/>
	<part name="VIN"                 type="xsd:string"/>
	<part name="TagNumber"           type="xsd:string"/>

	<!-- New fields/options -->
	<part name="DeepDive"            type="xsd:boolean"/>
	<part name="PenaltThreshold"     type="xsd:unsignedInt" default="0"/>
	<part name="DID"                 type="xsd:string"/>
	<part name="BDID"                type="xsd:string"/>

	<!-- Existing options -->
	<part name="ReturnCount"         type="xsd:unsignedInt"/>
	<part name="StartingRecord"      type="xsd:unsignedInt"/>
	<part name="StrictMatch"         type="xsd:boolean"/>
	<part name="EnableNationalAccidents" type="xsd:boolean"/>
	<part name="EnableExtraAccidents"   type="xsd:boolean"/>

	<part name="AccidentSearchRequest" type="tns:XmlDataSet" cols="80" rows="30" />

</message>
*/
/*--INFO-- 
    Search and Return Accident Information.<br/>
    Use EnableNationalAccidents [x] else Florida Accidents Only.
*/

IMPORT AutoStandardI,iesp, Accident_services, WSInput;

EXPORT SearchService := MACRO

 #CONSTANT ('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.SALT);
 //The following macro defines the field sequence on WsECL page of query.
  WSInput.MAC_Accident_Services_SearchService();

	#CONSTANT ('PenaltThreshold',10);

	// Get XML input 
	rec_in := iesp.accident.t_AccidentSearchRequest;
	ds_in := DATASET([],rec_in) : STORED('AccidentSearchRequest',FEW);
	first_row := ds_in[1] : INDEPENDENT;

	//set options
	iesp.ECL2ESP.SetInputBaseRequest(first_row);
	iesp.ECL2ESP.Marshall.Mac_Set(first_row.options);
	user := GLOBAL(first_row.User);
	
	//set main search criteria:
	search_by := GLOBAL(first_row.SearchBy);
	iesp.ECL2ESP.SetInputName (search_by.Name);
	#STORED('CompanyName',search_by.CompanyName);
	iesp.ECL2ESP.SetInputAddress (search_by.Address);
	//Store fields unique to Accidents into soap names to be used below
	#STORED('DID',search_by.UniqueId);
	#STORED('VIN',search_by.VIN);
	#STORED('AccidentNumber',search_by.AccidentNumber);
	#STORED('AccidentState',search_by.AccidentState);
	#STORED('AccidentDate',(UNSIGNED4)iesp.ECL2ESP.t_DateToString8(search_by.AccidentDate));
	#STORED('DriverLicenseNumber',search_by.DriverLicenseNumber);
	#STORED('TagNumber',search_by.TagNumber);

	options := GLOBAL(first_row.options);
	iesp.ECL2ESP.SetInputSearchOptions (options);
	#STORED('EnableNationalAccidents',options.EnableNationalAccidents);
	#STORED('EnableExtraAccidents',options.EnableExtraAccidents);

	#STORED('deepDive',options.IncludeAlsoFound);
	BOOLEAN deepDive := FALSE : STORED('deepDive');

	input_params := AutoStandardI.GlobalModule();
	tempmod := MODULE(PROJECT(input_params,Accident_Services.IParam.searchRecords,opt));
		EXPORT STRING40 Accident_Number := '' : STORED('AccidentNumber');
		EXPORT STRING2  Accident_State := '' : STORED('AccidentState');
		EXPORT UNSIGNED4 AccidentDate := 0 : STORED('AccidentDate');
		EXPORT STRING30 Vin := '' : STORED('VIN');
		EXPORT STRING24 DriverLicenseNumber := '' : STORED('DriverLicenseNumber');
		EXPORT STRING8  Tag_Number := '' : STORED('TagNumber');
		EXPORT BOOLEAN  EnableNationalAccidents := FALSE : STORED('EnableNationalAccidents');
		EXPORT BOOLEAN  EnableExtraAccidents := FALSE : STORED('EnableExtraAccidents');
		EXPORT BOOLEAN  isDeepDive := deepDive : STORED('IncludeAlsoFound');
		Export string32 applicationType := AutoStandardI.InterfaceTranslator.application_type_val.val(project(input_params,AutoStandardI.InterfaceTranslator.application_type_val.params));
	end;

	tempresults := Accident_services.Search_Records(tempmod);

	iesp.ECL2ESP.Marshall.MAC_Marshall_Results(tempresults,Results,
		iesp.accident.t_AccidentSearchResponse,Records,FALSE);

	OUTPUT(Results,NAMED('Results'));

ENDMACRO;
// Accident_Services.SearchService();
/*
<AccidentSearchRequest>
<row>
<User>
  <GLBPurpose></GLBPurpose>
  <DLPurpose></DLPurpose>
  <MaxWaitSeconds></MaxWaitSeconds>
  <ApplicationType></ApplicationType>
</User>
<SearchBy>
  <Name>
    <Full></Full>
    <First></First>
    <Middle></Middle>
    <Last></Last>
    <Suffix></Suffix>
    <Prefix></Prefix>
  </Name>
  <CompanyName></CompanyName>
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
  </Address>
  <AccidentNumber></AccidentNumber>
  <AccidentState></AccidentState>
  <AccidentDate>
    <Year></Year>
    <Month></Month>
    <Day></Day>
  </AccidentDate>
  <DriverLicenseNumber></DriverLicenseNumber>
  <VIN></VIN>
  <TagNumber></TagNumber>
</SearchBy>
<Options>
  <UseNicknames>false</UseNicknames>
  <IncludeAlsoFound>false</IncludeAlsoFound>
  <UsePhonetics>false</UsePhonetics>
  <PenaltyThreshold>0</PenaltyThreshold>
  <ReturnCount>10</ReturnCount>
  <StartingRecord>1</StartingRecord>
  <StrictMatch>0</StrictMatch>
  <EnableNationalAccidents></EnableNationalAccidents>
  <EnableExtraAccidents></EnableExtraAccidents>
</Options>
</row>
</AccidentSearchRequest>
*/
