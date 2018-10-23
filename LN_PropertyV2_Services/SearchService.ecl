/*--SOAP--
<message name="SearchService">

	<!-- Autokey search fields -->
  <part name="SSN" 								type="xsd:string"/>
	<part name="UnParsedFullName" 	type="xsd:string"/>
  <part name="FirstName"   				type="xsd:string"/>
  <part name="MiddleName"  				type="xsd:string"/>
  <part name="LastName"   	 			type="xsd:string"/>
  <part name="Addr"	    	   			type="xsd:string"/>
  <part name="City"   	     			type="xsd:string"/>
  <part name="State"	       			type="xsd:string"/>
  <part name="Zip" 	        			type="xsd:string"/>
  <part name="County"             type="xsd:string"/>
  <part name="CompanyName" 				type="xsd:string"/>
	
	<!-- Autokey Tuning -->
	<part name="AllowNickNames" 		type="xsd:boolean"/>
	<part name="PhoneticMatch"  		type="xsd:boolean"/>
	<part name="ExactOnly"   				type="xsd:boolean"/>
	<part name="NoDeepDive" 				type="xsd:boolean"/>
	<part name="ZipRadius"  				type="xsd:unsignedInt"/>

	<!-- Property Keys -->
  <part name="DID"								type="xsd:string"/>
  <part name="BDID"								type="xsd:string"/>
	<part name="FaresID"						type="xsd:string"/>
	<part name="ParcelID"						type="xsd:string"/>
	
	<!-- Property Tuning -->
	<part name="PenaltThreshold"		type="xsd:unsignedInt"/>
	<part name="StrictMatch"				type="xsd:boolean"/>
	<part name="LookupType"					type="xsd:string"/>
	<part name="PartyType"					type="xsd:string"/>
	<part name="IncludeDetails"			type="xsd:boolean"/>
	<part name="PropAddressSearch"	type="xsd:boolean"/>
	<part name="xadl2_weight_threshold"	type="xsd:unsignedInt"/>

	<!-- Data Restrictions -->
	<part name="CurrentOnly"				type="xsd:boolean"/>
	<part name="GroupByFidTypeOnly"		type="xsd:boolean"/>
	<part name="CurrentByVendor"		type="xsd:boolean"/>
	<part name="RobustnessScoreSorting" type="xsd:boolean"/>
	<part name="LnBranded"					type="xsd:boolean"/>
	<part name="DataRestrictionMask" type="xsd:string" default="0"/> 
	<part name="ApplicationType"     	type="xsd:string"/>
	<part name="DataPermissionMask" type="xsd:string"/>
	<part name="AllowAll"						type="xsd:boolean"/>
		
	<!-- Privacy -->
  <part name="SSNMask"						type="xsd:string"/>
	
	<!-- Record management -->
	<part name="MaxResults"					type="xsd:unsignedInt"/>
	<part name="MaxResultsThisTime"	type="xsd:unsignedInt"/>
	<part name="SkipRecords"				type="xsd:unsignedInt"/>
  <part name="ReturnHashes"				type="xsd:boolean"/>
  <part name="srch_hashvals"			type="tns:XmlDataSet" cols="70" rows="3"/>	

  <!-- Enhancement/Bug: 64514 -->
  <part name="MatchByBuyerAddresses"    type="xsd:boolean"/> 
  <part name="MatchByMailingAddresses"  type="xsd:boolean"/> 
  <part name="MatchByOwnerAddresses"    type="xsd:boolean"/> 
  <part name="MatchByPropertyAddresses" type="xsd:boolean"/> 
  <part name="MatchBySellerAddresses"   type="xsd:boolean"/> 

  <!-- Include Foreclosures and/or Notices of Default -->
  <part name="IncludeForeclosures"     type="xsd:boolean"/>
  <part name="IncludeNoticesOfDefault" type="xsd:boolean"/>
  
  <part name="UltID" type="xsd:unsignedInt"/>
	<part name="OrgID" type="xsd:unsignedInt"/>
  <part name="SeleID" type="xsd:unsignedInt"/>
	<part name="ProxID" type="xsd:unsignedInt"/>  
	<part name="PowID" type="xsd:unsignedInt"/>
	<part name="EmpID" type="xsd:unsignedInt"/>
	<part name="DotID" type="xsd:unsignedInt"/>
	<part name="BusinessIdFetchLevel" type="xsd:string"/>
  
	<!-- Legal stuff -->
  <part name="DPPAPurpose" type="xsd:byte" default="1"/>
  <part name="GLBPurpose" type="xsd:byte" default="1"/> 
</message>
*/

/*--INFO-- Search for Property Records via simple keys and autokeys. It also searches 
  the Forclosures file and/or the Notice of Default file. (ESP-compliant output)
*/

export SearchService() := macro
 #CONSTANT ('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.SALT);
 	INTEGER Max_Results := iesp.constants.MAX_COUNT_SEARCH_RESPONSE_RECORDS;
	#STORED('ReturnCount',Max_Results); // For iesp.ECL2ESP.Marshall

	// 1. Property Search	
	
	// compute results
	#CONSTANT('usePropMarshall', true);
	#CONSTANT('DisplayMatchedParty', true);

	raw := project(LN_PropertyV2_Services.SearchService_records().Records,
									 LN_PropertyV2_Services.layouts.combined.narrow);

	// standard record counts & limits
	doxie.MAC_Header_Field_Declare()

	Alerts.mac_ProcessAlerts(raw,LN_PropertyV2_services.alert,raw_final);

  // create External Key field
  Text_Search.MAC_Append_ExternalKey(raw_final, raw_final2, l.ln_fares_id);
	
	// doxie.MAC_Marshall_Results(raw_final2,cooked)
	LN_PropertyV2_Services.Marshall.MAC_Marshall_Results(raw_final2, cooked);


  // 2. Foreclosure and/or Notice of Default search
  input_params := AutoStandardI.GlobalModule();
	tempmod := module(project(input_params,Foreclosure_Services.Records.params,opt))  
    export string70 foreclosure_id  := '';
		Export string32 applicationType	:= AutoStandardI.InterfaceTranslator.application_type_val.val(project(input_params,AutoStandardI.InterfaceTranslator.application_type_val.params));
  end;

	// Unlike in Foreclosure_Services.SearchService, including Forclosures must be set to FALSE by default.
  boolean IncludeForeclosures      := false : STORED ('IncludeForeclosures');
  boolean IncludeNoticesOfDefault  := false : STORED ('IncludeNoticesOfDefault');

	// Foreclosure_Services.Records will return either Foeclosures or Notices of Default, but not both. 
	// So, two calls to the same function, each with a different parameter value.	
  for := if( IncludeForeclosures, Foreclosure_Services.Records.val(tempmod,false));
  nod := if( IncludeNoticesOfDefault, Foreclosure_Services.Records.val(tempmod,true));
  tmp := sort( for + nod , if(AlsoFound,1,0), _penalty, -recordingdate, record );

  iesp.ECL2ESP.Marshall.MAC_Marshall_Results (tmp, foreclosureResults, iesp.foreclosure.t_ForeclosureSearchResponse);

	// display Property results
	output(cooked, named('Results'));


  // display Foreclosure / Notice of Default results
  if( IncludeForeclosures OR IncludeNoticesOfDefault, output(foreclosureResults, named('ForeclosureResults')));

endmacro;