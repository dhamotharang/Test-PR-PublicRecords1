/*--SOAP--
<message name="InViewReportService" wuTimeout="300000">
  <part name="CompanyName" type="xsd:string"/>
  <part name="Addr" type="xsd:string"/>
  <part name="City" type="xsd:string"/>
  <part name="State" type="xsd:string"/>
  <part name="Zip" type="xsd:string"/>
	<part name="MileRadius" type="xsd:unsignedInt"/>
  <part name="Phone" type="xsd:string"/>
  <part name="SSN" type="xsd:string"/>
  <part name="UnParsedFullName" type="xsd:string"/>
  <part name="FirstName" type="xsd:string"/>
  <part name="AllowNickNames" type="xsd:boolean"/>
  <part name="LastName" type="xsd:string"/>
  <part name="PhoneticMatch" type="xsd:boolean"/>
  <part name="MiddleName" type="xsd:string"/>
  <part name="FEIN" type="xsd:string"/>
  <part name="BDID" type="xsd:string"/>
	<part name="CompanyThreshold" type="xsd:unsignedInt"/>
	<part name="AddressThreshold" type="xsd:unsignedInt"/>
  <part name="DPPAPurpose" type="xsd:byte"/>
  <part name="GLBPurpose" type="xsd:byte"/>
	
	<part name="IncludeMVAWFAHeaders" type="xsd:boolean"/>
	<part name="Include_Bus_DPPA" type="xsd:boolean"/>
	<part name="DataRestrictionMask" type="xsd:string"/>
	<part name="DataPermissionMask" type="xsd:string"/>

	<part name="SelectIndividually" type="xsd:boolean"/>
	<part name="IncludeNameVariations" type="xsd:boolean"/>
	<part name="IncludeAddressVariations" type="xsd:boolean"/>
	<part name="IncludePhoneVariations" type="xsd:boolean"/>
	<part name="IncludeDunBradstreetRecords" type="xsd:boolean"/>
	<part name="IncludeExperianBusinessReports" type="xsd:boolean"/>
	<part name="IncludeIRS5500" type="xsd:boolean"/>
	<part name="IncludeDCA" type="xsd:boolean"/>
	<part name="IncludeSales" type="xsd:boolean"/>
	<part name="IncludeIndustryInformation" type="xsd:boolean"/>
	<part name="IncludeLiensJudgments" type="xsd:boolean"/> 
	<part name="IncludeLiensJudgmentsV2" type="xsd:boolean"/> 
  <part name="IncludeUCCFilings" type="xsd:boolean"/>
	<part name="IncludeUCCFilingsV2" type="xsd:boolean"/>
	<part name="IncludeAssociatedPeople" type="xsd:boolean"/>
	<part name="IncludeInternetDomains" type="xsd:boolean"/>
	<part name="IncludeBankruptcies" type="xsd:boolean"/>
	<part name="IncludeBankruptciesV2" type="xsd:boolean"/>
	<part name="IncludeBusinessRegistrations" type="xsd:boolean"/>
	<part name="IncludeProperties" type="xsd:boolean"/>
	<part name="IncludePropertiesV2" type="xsd:boolean"/>
	<part name="IncludeMotorVehicles" type="xsd:boolean"/>
	<part name="IncludeMotorVehiclesV2" type="xsd:boolean"/>
	<part name="IncludeWatercrafts" type="xsd:boolean"/>
	<part name="IncludeAircrafts" type="xsd:boolean"/>
	<part name="IncludeProfessionalLicenses" type="xsd:boolean"/>
	<part name="IncludeCompanyIDnumbers" type="xsd:boolean"/>
	<part name="IncludeCompanyIDnumbersV2" type="xsd:boolean"/>
	<part name="IncludeCompanyProfile" type="xsd:boolean"/>
	<part name="IncludeCompanyProfileV2" type="xsd:boolean"/>
	<part name="IncludeRegisteredAgents" type="xsd:boolean"/>
	<part name="IncludeExecutives" type="xsd:boolean"/>
	<part name="IncludeBusinessAssociates" type="xsd:boolean"/>
	<part name="IncludeDiversityCert" type="xsd:boolean"/>
	<part name="IncludeRiskMetrics" type="xsd:boolean"/>
	<part name="IncludeLaborActWHD" type="xsd:boolean"/>
	<part name="IncludeNatDisReady" type="xsd:boolean"/>
	<part name="IncludeLNCA" type="xsd:boolean"/>
	<part name="Include_BusinessCreditRisk" type="xsd:boolean"/>
	<part name="Include_BusinessFailureRiskLevel" type="xsd:boolean"/>
	<part name="Include_CustomBCIR" type="xsd:boolean"/>
	<part name="IncludeSourceCounts" type="xsd:boolean"/>
	<part name="IncludeSourceFlags" type="xsd:boolean"/>
	<part name="gateways" type="tns:XmlDataSet" cols="110" rows="10"/>
 </message>
*/
/*--INFO-- InView Business Report */	
	
export InViewReportService := MACRO
#constant('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.LEGACY);
#onwarning(4207, ignore);

#option ('globalAutoHoist', false);
#option ('spotCSE', false);
#stored('useSupergroup',true);
#stored('useLevels',true);
#stored('isDayBR',true); 
#stored('IncludeMultipleSecured',true);
#stored('ReturnRolledDebtors',true);
#constant('ExcludeBlankAddresses', true);
#constant('IncludeParentCompany', false);
#constant('SSNMask', 'ALL');
// #constant('UseGIDnotBDID', true);
#stored('LnBranded', true);   // needed in some attrs?

// only need v2 content 
#constant('BankruptcyVersion',2);
#constant('JudgmentLienVersion',2);
#constant('VehicleVersion',2);
#constant('PropertyVersion',2);
#constant('UccVersion',2);

doxie_cbrs.mac_Selection_Declare();

rpt := InView_Services.InViewReport_records;

dnb_table := normalize(rpt, left.dnb,transform(right));
dnb_royalties := Royalty.RoyaltyDNB.GetOnlineRoyalties(dnb_table);

// dataset(iesp.gateway_inviewreport.t_InviewReportResponse) rpt.EquifaxBusinessReport
efx_table := normalize(rpt, left.EquifaxBusinessReport, transform(right));
inv_royalties := Royalty.RoyaltyInview.GetOnlineRoyalties(efx_table, Include_BusinessCreditRisk,  Include_BusinessFailureRiskLevel, Include_CustomBCIR);

royalties := dataset([], Royalty.Layouts.Royalty) +
	IF(Include_EquifaxBus_val, inv_royalties) +
	IF(Include_DunBradstreetRecords_val, dnb_royalties);

output(rpt, named('InViewReport'));
output(royalties, named('RoyaltySet'));

ENDMACRO;
