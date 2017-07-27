/*--SOAP--
<message name="FCCSearchService" wuTimeout="300000">
  <part name="FCCID" type="xsd:unsignedInt"/>
  <part name="DID"   type="xsd:string"/>
  <part name="BDID"  type="xsd:string"/>

  <!-- person/business info input -->
	<part name="FirstName"  type="xsd:string" />
	<part name="MiddleName" type="xsd:string" />
	<part name="LastName"   type = "xsd:string" />
<!--	<part name="AllowNicknames" type='xsd:boolean" /><part name="PhoneticMatch" type='xsd:boolean' /> -->
  <part name="CompanyName" type="xsd:string"/>

  <!-- person/business address -->
	<part name = "Addr"  type="xsd:string" />
	<part name = "City"  type="xsd:string" />
	<part name = "State" type="xsd:string" />
	<part name = "Zip"   type="xsd:string" />
  <part name="County"  type="xsd:string"/>
  <part name = "Phone" type="xsd:string" />

  <!-- common input -->
<!--
	<part name = "GLBPurpose"  type="xsd:byte"/>
	<part name = "DPPAPurpose" type="xsd:byte"/>
-->
	<part name="ApplicationType"     	type="xsd:string"/>
  <part name = "PenaltThreshold" 		type="xsd:unsignedInt" />
	<part name = "MaxResults"         type="xsd:unsignedInt" />
	<part name = "MaxResultsThisTime" type="xsd:unsignedInt" />
	<part name = "SkipRecords"        type="xsd:unsignedInt" />
<!--  <part name = "NoDeepDive"       type="xsd:boolean"/> -->
</message>
*/
/*--INFO-- FCC search.*/

EXPORT FCCSearchService := MACRO

#constant('SearchIgnoresAddressOnly',true)
#stored('PenaltThreshold',10)
rpen := FCC_Services.FCCSearchService_records;
Text_Search.MAC_Append_ExternalKey(rpen, rpen2, INTFORMAT(l.fcc_seq,15,1));
output(rpen2, named('Results'));

ENDMACRO;

