/*--SOAP--
<message name="Business_Report_Source_Service" wuTimeout="300000">
  <part name="header_src_in" type="tns:XmlDataSet" cols="70" rows="25"/>
  <part name="DPPAPurpose" type="xsd:byte"/>
  <part name="GLBPurpose" type="xsd:byte"/>
  <part name="DataRestrictionMask" type="xsd:string"/>
  <part name="Include_Bus_DPPA" type="xsd:boolean"/>
  <part name="UccVersion" type="xsd:byte"/>
  <part name="JudgmentLienVersion" type="xsd:byte"/>
  <part name="BankruptcyVersion" type="xsd:byte"/>
  <part name="VehicleVersion" type="xsd:byte"/>
  <part name="PropertyVersion" type="xsd:byte"/>
  <part name="IncludeOccurrences" type="xsd:boolean"/>
  <part name="ExcludeSources" type="xsd:boolean"/>
</message>
*/
/*--INFO-- Dayton Smartlynx Business Source Interface.*/
IMPORT Doxie_Raw, Header, doxie_cbrs, STD;

EXPORT Business_Report_Source_Service := MACRO
#CONSTANT('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.SALT);
#CONSTANT('usePropMarshall',TRUE);

//string8 in_date := '' : stored('RecordByDate');
//unsigned4 dateVal := (unsigned)(in_date);
UNSIGNED1 DPPA_Purpose := 0 : STORED('DPPAPurpose');
UNSIGNED1 GLB_Purpose := 8 : STORED('GLBPurpose');

input := DATASET([], Doxie_Raw.Layout_input) : STORED('header_src_in',few);

STRING bdid := IF(input[1].idtype = 'BDID' OR input[1].idtype = 'bdid', input[1].id, '');
STRING bdl := IF(input[1].idtype = 'BDL' OR input[1].idtype = 'bdl', input[1].id, '');
#STORED('BDID', bdid);
#STORED('BDL', bdl);

//Assume one row.
// - Can't send multiple GIDs
// - Can't ask for multiple sections
// - Blank section is for all sources
sect := input[1].section;

bsect(STRING sect_name, STRING sect_in) := sect_name = STD.STR.ToUpperCase(sect_in);

bsect_name := (sect[1..2] = 'N0' OR sect[1..2] = 'n0');
bsect_name_id := IF(bsect_name,sect[3..],'');
bsect_addr := (sect[1..2] = 'A0' OR sect[1..2] = 'a0');
bsect_addr_id := IF(bsect_addr,sect[3..],'');
bsect_phone := (sect[1..2] = 'P0' OR sect[1..2] = 'p0');
bsect_phone_id := IF(bsect_phone,sect[3..],'');
bsect_fein := (sect[1..2] = 'F0' OR sect[1..2] = 'f0');
bsect_fein_id := IF(bsect_fein,sect[3..],'');
bsect_val := GLOBAL(NOT (sect = '' OR STD.STR.ToUpperCase(sect) = STD.STR.ToUpperCase('all_sources')));
#STORED('SelectIndividually', bsect_val);


// Strictly Section Names
#STORED('IncludeNameVariations', bsect('NAME_VARIATIONS',sect) OR bsect_name);
#STORED('IncludeAddressVariations', bsect('ADDRESS_VARIATIONS',sect) OR bsect_addr);
#STORED('IncludePhoneVariations', bsect('PHONE_VARIATIONS',sect) OR bsect_phone);
#STORED('IncludeFeinVariations', bsect('FEIN_VARIATIONS',sect) OR bsect_fein);
#STORED('IncludeParentCompany', bsect('PARENT_COMPANY',sect));
#STORED('IncludeSales', bsect('SALES',sect));
#STORED('IncludeIndustryInformation', bsect('INDUSTRY_INFORMATION',sect));
#STORED('IncludeCompanyIDnumbers', bsect('ID_NUMBERS',sect));
#STORED('IncludeCompanyIDnumbersV2', bsect('ID_NUMBERS_V2',sect));
#STORED('IncludeLiensJudgmentsUCC', bsect('LIENS_JUDGMENTS_UCCS',sect));
#STORED('IncludeLiensJudgmentsUCCV2', bsect('LIENS_JUDGMENTS_UCCS_V2',sect));
#STORED('IncludeCompanyProfile', bsect('PROFILE_INFORMATION',sect));
#STORED('IncludeCompanyProfileV2', bsect('PROFILE_INFORMATION_V2',sect));
#STORED('IncludeRegisteredAgents', bsect('REGISTERED_AGENTS',sect));
#STORED('IncludeExecutives', bsect('EXECUTIVES',sect));
#STORED('IncludeBusinessAssociates', bsect('BUSINESS_ASSOCIATES',sect));

// Strictly Sources or Both
#STORED('IncludeFinder', bsect('FINDER',sect));
#STORED('IncludeDCA', bsect('DCA',sect));
#STORED('IncludeDunBradstreetRecords', bsect('DNB',sect));
#STORED('IncludeCorporationFilings', bsect('CORPORATE_FILINGS',sect));
#STORED('IncludeCorporationFilingsV2', bsect('CORPORATE_FILINGS_V2',sect));
#STORED('IncludeBankruptcies', bsect('BANKRUPTCY',sect));
#STORED('IncludeBankruptciesV2', bsect('BANKRUPTCY_V2',sect));
#STORED('IncludeUCCFilings', bsect('UCCS',sect) OR bsect('LIENS_JUDGMENTS_UCCS',sect));
#STORED('IncludeUCCFilingsV2', bsect('UCCS_V2',sect) OR bsect('LIENS_JUDGMENTS_UCCS_V2',sect));
#STORED('IncludeLiensJudgments', bsect('LIENS_JUDGMENTS',sect) OR bsect('LIENS_JUDGMENTS_UCCS',sect));
#STORED('IncludeLiensJudgmentsV2', bsect('LIENS_JUDGMENTS_V2',sect) OR bsect('LIENS_JUDGMENTS_UCCS_V2',sect));
#STORED('IncludeAssociatedPeople', bsect('CONTACTS',sect));
#STORED('IncludeProperties', bsect('PROPERTY',sect));
#STORED('IncludePropertiesV2', bsect('PROPERTY_V2',sect));
#STORED('IncludeMotorVehicles', bsect('MOTOR_VEHICLES',sect));
#STORED('IncludeMotorVehiclesV2', bsect('MOTOR_VEHICLES_V2',sect));
#STORED('IncludeWatercrafts', bsect('WATERCRAFTS',sect));
#STORED('IncludeAircrafts', bsect('AIRCRAFTS',sect));
#STORED('IncludeExperianBusinessReports', bsect('EBR',sect));
#STORED('IncludeBusinessRegistrations', bsect('BUSINESS_REGISTRATIONS',sect));
#STORED('IncludeIRS5500', bsect('IRS',sect) OR bsect('IRSALL',sect));
#STORED('IncludeIRSNonP', bsect('IRSNONP',sect) OR bsect('IRSALL',sect));
#STORED('IncludeFDIC', bsect('FDIC',sect));
#STORED('IncludeBBBMember', bsect('BBBMEM',sect) OR bsect('BBB',sect));
#STORED('IncludeBBBNonMember', bsect('BBBNONMEM',sect) OR bsect('BBB',sect));
#STORED('IncludeCASalesTax', bsect('CASALES',sect) OR bsect('SALESTAX',sect));
#STORED('IncludeIASalesTax', bsect('IASALES',sect) OR bsect('SALESTAX',sect));
#STORED('IncludeMSWorkComp', bsect('MSWORK',sect) OR bsect('WORKCOMP',sect));
#STORED('IncludeORWorkComp', bsect('ORWORK',sect) OR bsect('WORKCOMP',sect));
#STORED('IncludeInternetDomains', bsect('INTERNET',sect));
#STORED('IncludeProfessionalLicenses', bsect('PROFESSIONAL_LICENSES',sect));
#STORED('IncludeSuperiorLiens', bsect('SUPERIOR_LIENS',sect));
#STORED('IncludeForeclosures', bsect('FORECLOSURES',sect));
#STORED('IncludeNoticeOfDefaults', bsect('NOTICE_OF_DEFAULTS',sect));

// Name, Address or Phone Source IDs
#STORED('SourceIdName', bsect_name_id);
#STORED('SourceIdAddr', bsect_addr_id);
#STORED('SourceIdPhone', bsect_phone_id);
#STORED('SourceIdFein', bsect_fein_id);


doxie_cbrs.Business_Report_Service_Raw();

ENDMACRO;
