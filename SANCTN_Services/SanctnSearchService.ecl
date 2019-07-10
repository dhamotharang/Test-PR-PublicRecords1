/*--SOAP--
<message name="SanctnSearchService" wuTimeout="300000">
  <part name="BatchNumber"    type="xsd:string"/>
  <part name="IncidentNumber" type="xsd:string"/>
  <separator />

  <part name="CaseNumber"   type="xsd:string"/>
  <part name="IncidentDate" type="xsd:string" description=" (YYYYMMDD)"/>
  <part name="IncidentStartDate" type="xsd:string" description=" (YYYYMMDD)" default=""/>
  <part name="IncidentEndDate" type="xsd:string" description=" (YYYYMMDD)" default=""/>
  <separator />

  <!-- party input (person/business) -->
	<part name="FirstName"  type="xsd:string" />
	<part name="MiddleName" type="xsd:string" />
	<part name="LastName"   type = "xsd:string" />
	<part name="AllowNicknames" type="xsd:boolean" />
	<part name="PhoneticMatch" type="xsd:boolean" />
  <part name="CompanyName" type="xsd:string"/>
  <separator />

  <!-- party address -->
	<part name = "Addr"  type="xsd:string" />
	<part name = "City"  type="xsd:string" />
	<part name = "State" type="xsd:string" description=" abbreviated: 2-char"/>
	<part name = "Zip"   type="xsd:string" description=" 5-digit"/>
  <part name = "County" type="xsd:string"/>
<!--  <part name = "ZipRadius" type="xsd:unsignedInt"/> -->
  <separator />

  <!-- common input -->
<!--
	<part name = "GLBPurpose"  type="xsd:byte"/>
	<part name = "DPPAPurpose" type="xsd:byte"/>
-->
	<part name="ApplicationType" type="xsd:string"/>
  <part name = "PenaltThreshold" 		type="xsd:unsignedInt" default="20"/>
	<part name = "MaxResults"         type="xsd:unsignedInt" default="100"/>
	<part name = "MaxResultsThisTime" type="xsd:unsignedInt" />
	<part name = "SkipRecords"        type="xsd:unsignedInt" />
<!--  <part name = "NoDeepDive"       type="xsd:boolean"/> -->

  <part name="SSNMask" type="xsd:string" default="LAST4"/>
</message>
*/
/*--INFO-- SANCTIONs combined search / report.*/
IMPORT doxie, Sanctn_Services, Text_Search;

EXPORT SanctnSearchService := MACRO

#constant('SearchIgnoresAddressOnly',true);
#stored('PenaltThreshold',10);

mod_access := doxie.compliance.GetGlobalDataAccessModuleTranslated(AutoStandardI.GlobalModule());
rpen := Sanctn_Services.SanctnSearchService_records(mod_access);
Text_Search.MAC_Append_ExternalKey(rpen, rpen2, l.BATCH_NUMBER+l.INCIDENT_NUMBER);
output(rpen2, named('Results'));

ENDMACRO;
