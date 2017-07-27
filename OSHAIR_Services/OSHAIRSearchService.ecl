/*--SOAP--
<message name="OSHAIRSearchService">
  <part name="ActivityNumber"  type="xsd:unsignedInt"/>
  <part name="BDID"        type="xsd:string"/>
  <part name="CompanyName" type="xsd:string"/>
  <part name="ActivityStartDate" type="xsd:string"  description=" (YYYYMMDD)" default=""/>
  <part name="ActivityEndDate" type="xsd:string"  description=" (YYYYMMDD)" default=""/>

  <!-- business/facility address/phone -->
  <part name="Addr"   type="xsd:string"/>
  <part name="City"   type="xsd:string"/>
  <part name="State"  type="xsd:string"/>
  <part name="Zip"    type="xsd:string"/>
  <part name="County" type="xsd:string"/>

  <part name="NoDeepDive"         type="xsd:boolean"/>
  <part name="SkipRecords"        type="xsd:unsignedInt"/>
  <part name="ScoreThreshold"     type="xsd:unsignedInt"/>
  <part name="PenaltThreshold"    type="xsd:unsignedInt"/>
  <part name="MaxResults"         type="xsd:unsignedInt"/>
  <part name="MaxResultsThisTime" type="xsd:unsignedInt"/>
</message>
*/
/*--INFO-- This service searches OSHAIR data files.*/


EXPORT OSHAIRSearchService := MACRO
#constant('SearchIgnoresAddressOnly',false);
#stored('ScoreThreshold', 10);
#stored('PenaltThreshold', 10); //this is redundant (same value default is used later), but more clear

rpen := OSHAIR_Services.search_records;
Text_Search.MAC_Append_ExternalKey(rpen, rpen2, INTFORMAT((unsigned)l.activity_number,15,1));
OUTPUT (rpen2, named('Results'));

ENDMACRO;
