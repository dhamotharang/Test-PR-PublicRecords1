/*--SOAP--
<message name="MDSearchService">

	<!-- MD Keys -->
	<part name="IndustryCLASS"					type="xsd:string"/>
	<part name="ApplicationType"     	type="xsd:string"/>
	<part name="RecordID"					type="xsd:string"/>
	<part name="DID"							type="xsd:string"/>
	
	<part name="FilingNumber"			type="xsd:string"/>
	<part name="FilingType"				type="xsd:string"/>
	<part name="FilingSubType"		type="xsd:string"/>
	<part name="FilingJurisdiction"	type="xsd:string"/>
	<part name="County"						type="xsd:string"/>
  <part name="FilingDateBegin"	type='xsd:string'/>
  <part name="FilingDateEnd"		type='xsd:string'/>

	<!-- Autokey search fields -->
	<part name="UnParsedFullName" type="xsd:string"/>
  <part name="FirstName"   			type="xsd:string"/>
  <part name="MiddleName"  			type="xsd:string"/>
  <part name="LastName"    			type="xsd:string"/>
  <part name="Addr"	       			type="xsd:string"/>
  <part name="City"        			type="xsd:string"/>
  <part name="State"       			type="xsd:string"/>
  <part name="Zip"         			type="xsd:string"/>
	<part name="DOB" 							type="xsd:unsignedInt"/>
	<part name="LookupType"				type="xsd:string"/>

	<!-- Autokey Tuning -->
	<part name="AllowNickNames" 	type="xsd:boolean"/>
	<part name="PhoneticMatch"  	type="xsd:boolean"/>
	<part name="ExactOnly"   			type="xsd:boolean"/>
	<part name="NoDeepDive" 			type="xsd:boolean"/>
	<part name="ZipRadius"  			type="xsd:unsignedInt"/>

	<!-- MD Tuning -->
	<part name="PenaltThreshold"	type="xsd:unsignedInt"/>

  <!-- 2nd Party Search Criteria -->
	<part name="Entity2_DID" 								type="xsd:string"/>
	<part name="Entity2_UnParsedFullName" 	type="xsd:string"/>
	<part name="Entity2_FirstName"   				type="xsd:string"/>
	<part name="Entity2_MiddleName"  				type="xsd:string"/>
	<part name="Entity2_LastName"    				type="xsd:string"/>
	<part name="Entity2_Addr"	       				type="xsd:string"/>
	<part name="Entity2_City"        				type="xsd:string"/>
	<part name="Entity2_State"       				type="xsd:string"/>
	<part name="Entity2_Zip"         				type="xsd:string"/>
	<part name="Entity2_SSN"								type="xsd:string"/>
  <part name="Entity2_DOB"		            type="xsd:unsignedInt"/>
	<part name="Entity2_AllowNickNames" 		type="xsd:boolean"/>
	<part name="Entity2_PhoneticMatch"  		type="xsd:boolean"/>
	<part name="Entity2_ExactOnly"   	      type="xsd:boolean"/>
	<part name="Entity2_NoDeepDive" 	      type="xsd:boolean"/>
	<part name="Entity2_ZipRadius"  				type="xsd:unsignedInt"/>
	
	<!-- Marshalling -->
	<part name="MaxResults"					type="xsd:unsignedInt"/>
	<part name="MaxResultsThisTime"	type="xsd:unsignedInt"/>
	<part name="SkipRecords"				type="xsd:unsignedInt"/>
    
</message>
*/
/*--INFO-- Search for Marriage & Divorce Records via simple keys or autokeys. */
import text_search, doxie;  
export MDSearchService() := macro

#constant('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.SALT);
 
	// Generate the full report
	pre_raw := marriage_divorce_v2_Services.MDSearchService_Records();
	raw := pre_raw.Records;
  Text_Search.MAC_Append_ExternalKey(raw, raw2, INTFORMAT(l.record_id,15,1));
	// And chop it up as necessary
	doxie.MAC_Header_Field_Declare();
	doxie.MAC_Marshall_Results(raw2, cooked);
	
	// We're outta here
	output(cooked, named('Results'));

endmacro;
