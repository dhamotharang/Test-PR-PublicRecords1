/*--SOAP--
<message name="TaxproSearchService">
  <part name="tmsid" type="xsd:string"/>

  <part name="BDID" type="xsd:string"/>
  <part name="CompanyName" type="xsd:string"/>
<!-- <part name="ExactOnly" type="xsd:boolean"/>-->

  <!-- person -->
  <part name="FirstName" type="xsd:string"/>
  <part name="MiddleName" type="xsd:string"/>
  <part name="LastName" type="xsd:string"/>
  <part name="UnParsedFullName" type="xsd:string"/>

<!--
  <part name="AllowNickNames" type="xsd:boolean"/>
  <part name="PhoneticMatch" type="xsd:boolean"/>
-->

  <!-- person/company address -->
  <part name="Addr" type="xsd:string"/>
  <part name="City" type="xsd:string"/>
  <part name="State" type="xsd:string"/>
  <part name="Zip" type="xsd:string"/>
  <part name="County" type="xsd:string"/>
  <part name="Country" type="xsd:string"/>

  <part name="NoDeepDive" type="xsd:boolean"/>
  <part name="SkipRecords" type="xsd:unsignedInt"/>
  <part name="ScoreThreshold" type="xsd:unsignedInt"/>
  <part name="PenaltThreshold" type="xsd:unsignedInt"/>
  <part name="MaxResults" type="xsd:unsignedInt"/>
  <part name="MaxResultsThisTime" type="xsd:unsignedInt"/>
</message>
*/
/*--INFO-- This service searches TAXPRO datafiles.*/


EXPORT TaxproSearchService := MACRO
#CONSTANT('SearchIgnoresAddressOnly',FALSE)
#STORED('ScoreThreshold', 10)
#STORED('PenaltThreshold', 10) //this is redundant (same value default is used later), but more clear

rpen := TAXPRO_Services.search_records;
Text_Search.MAC_Append_ExternalKey(rpen, rpen2, l.tmsid);
OUTPUT (rpen2, NAMED('Results'));

ENDMACRO;
