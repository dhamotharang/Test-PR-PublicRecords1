/*--SOAP--
<message name="USABIZSearchService">
  <part name="ABI"  type="xsd:string"/>
  <part name="BDID"        type="xsd:string"/>
  <part name="CompanyName" type="xsd:string"/>
<!--  <part name="ExactOnly"   			type="xsd:boolean"/>-->

  <!-- contact person -->
  <part name="FirstName"  type="xsd:string"/>
  <part name="MiddleName" type="xsd:string"/>
  <part name="LastName"   type="xsd:string"/>
  <part name="UnParsedFullName" type="xsd:string"/>
  <part name="AllowNickNames"   type="xsd:boolean"/>
  <part name="PhoneticMatch"    type="xsd:boolean"/>

  <!-- company/person address/phone -->
  <part name="Addr"   type="xsd:string"/>
  <part name="City"   type="xsd:string"/>
  <part name="State"  type="xsd:string"/>
  <part name="Zip"    type="xsd:string"/>
  <part name="County" type="xsd:string"/>
  <part name="Phone"  type="xsd:string"/>

  <part name="NoDeepDive"         type="xsd:boolean"/>
  <part name="SkipRecords"        type="xsd:unsignedInt"/>
  <part name="DPPAPurpose"        type="xsd:byte"/>
  <part name="GLBPurpose"         type="xsd:byte"/>
  <part name="ScoreThreshold"     type="xsd:unsignedInt"/>
  <part name="PenaltThreshold"    type="xsd:unsignedInt"/>
  <part name="MaxResults"         type="xsd:unsignedInt"/>
  <part name="MaxResultsThisTime" type="xsd:unsignedInt"/>
</message>
*/
/*--INFO-- This service searches USABIZ companies (InfoUSA) datafiles.*/


EXPORT USABIZSearchService := MACRO
#constant('SearchIgnoresAddressOnly',false)
#stored('ScoreThreshold', 10)
#stored('PenaltThreshold', 10) //this is redundant (same value default is used later), but more clear

rpen := USAbizV2_Services.search_records;
Text_Search.MAC_Append_ExternalKey(rpen, rpen2, l.abi_number);

OUTPUT (rpen2, named('Results'));

ENDMACRO;
