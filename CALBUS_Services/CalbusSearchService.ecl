/*--SOAP--
<message name="CalbusSearchService">
  <part name="AccountNumber"  type="xsd:string"/>
  <part name="BDID"        type="xsd:string"/>
  <part name="CompanyName" type="xsd:string"/>
<!--  <part name="ExactOnly"   			type="xsd:boolean"/>-->

  <!-- person -->
  <part name="FirstName"  type="xsd:string"/>
  <part name="MiddleName" type="xsd:string"/>
  <part name="LastName"   type="xsd:string"/>
  <part name="UnParsedFullName" type="xsd:string"/>
<!--
  <part name="AllowNickNames"   type="xsd:boolean"/>
  <part name="PhoneticMatch"    type="xsd:boolean"/>
-->

  <!-- person/company address -->
  <part name="Addr"   type="xsd:string"/>
  <part name="City"   type="xsd:string"/>
  <part name="State"  type="xsd:string"/>
  <part name="Zip"    type="xsd:string"/>

  <part name="NoDeepDive"         type="xsd:boolean"/>
  <part name="SkipRecords"        type="xsd:unsignedInt"/>
  <part name="ScoreThreshold"     type="xsd:unsignedInt"/>
  <part name="PenaltThreshold"    type="xsd:unsignedInt"/>
  <part name="MaxResults"         type="xsd:unsignedInt"/>
  <part name="MaxResultsThisTime" type="xsd:unsignedInt"/>
  <part name="SkipRecords"        type="xsd:unsignedInt"/>
</message>
*/
/*--INFO-- This service searches CALBUS datafiles.*/


EXPORT CalbusSearchService := MACRO
	#constant('SearchIgnoresAddressOnly',false);
	#stored('ScoreThreshold', 10);
	#stored('PenaltThreshold', 10); //this is redundant (same value default is used later), but more clear

	// OUTPUT (CALBUS_Services.search_records, named('Results'));

	recs := CALBUS_Services.search_records;
	
	Text_Search.MAC_Append_ExternalKey(recs, recs2, l.account_number);

	doxie.MAC_Header_Field_Declare()
	doxie.MAC_Marshall_Results(recs2, recs_marshalled);

	OUTPUT(recs_marshalled, NAMED('Results'));

ENDMACRO;
