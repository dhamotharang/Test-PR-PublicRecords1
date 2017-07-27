/*--SOAP--
<message name="DLSearchService">

	<!-- Autokey search fields -->
  <part name='SSN'							type='xsd:string'/>
	<part name="UnParsedFullName" type="xsd:string"/>
  <part name="FirstName"   			type="xsd:string"/>
  <part name="MiddleName"  			type="xsd:string"/>
  <part name="LastName"    			type="xsd:string"/>
  <part name="Addr"	       			type="xsd:string"/>
  <part name="City"        			type="xsd:string"/>
  <part name="State"       			type="xsd:string"/>
  <part name="Zip"         			type="xsd:string"/>
  <part name="County"           type="xsd:string"/>
	<part name="DOB" 							type="xsd:unsignedInt"/>

	<!-- Autokey Tuning -->
	<part name="AllowNickNames" 	type="xsd:boolean"/>
	<part name="PhoneticMatch"  	type="xsd:boolean"/>
	<part name="ExactOnly"   			type="xsd:boolean"/>
	<part name="NoDeepDive" 			type="xsd:boolean"/>
	<part name="ZipRadius"  			type="xsd:unsignedInt"/>

	<!-- DL Keys -->
  <part name="DLSeq"						type="xsd:string"/>
  <part name="DID"							type="xsd:string"/>
  <part name="DriversLicense"		type="xsd:string"/>
  <part name="IncludeHistory"		type="xsd:string"/>
  <part name="DLState"					type="xsd:string"/>
	
	<!-- DL Tuning -->
	<part name="PenaltThreshold"	type="xsd:unsignedInt"/>
  <part name="StrictMatch"			type="xsd:boolean"/>	
	<part name="FuzzySecRange"		type="xsd:integer"/>

	<!-- Privacy -->
  <part name="DPPAPurpose"			type="xsd:byte"/>
  <part name="GLBPurpose"				type="xsd:byte"/>
  <part name="SSNMask"					type="xsd:string"/>
  <part name="DLMask"						type="xsd:string"/>
  <part name="DOBMask"					type="xsd:string"/>
	<part name="ApplicationType"  type="xsd:string"/>
  
	<!-- Breadth -->
	<part name="IncludeNonDMVSources"		type="xsd:boolean"/>
	
	<!-- Record management -->
	<part name="MaxResults"					type="xsd:unsignedInt"/>
	<part name="MaxResultsThisTime"	type="xsd:unsignedInt"/>
	<part name="SkipRecords"				type="xsd:unsignedInt"/>
</message>
*/
/*--INFO-- Lookup DL Records via simple keys and autokeys, then display in narrow_view. */
IMPORT doxie, text_search, WSInput;
EXPORT DLSearchService() := MACRO

	//The following macro defines the field sequence on WsECL page of query. 
	WSInput.MAC_DriversVTSA_Services_DLSearchService();
	#constant('NoDeepDive',true)

	// compute results
  raw := DriversvTSA_Services.DLSearchService_records;
	Text_Search.MAC_Append_ExternalKey(raw, raw2, INTFORMAT(l.dl_seq,15,1));
	
  doxie.MAC_Header_Field_Declare()	
	doxie.MAC_Marshall_Results(raw2,cooked)

	// display results (if permitted)
	map(
		~dppa_ok
		=> fail(2, doxie.ErrorCodes(2)),
		
		output(cooked, NAMED('Results'))
	)

ENDMACRO;
