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
import Doxie_Raw, Header, doxie_cbrs;

export Business_Report_Source_Service := macro
#constant('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.LEGACY);
#CONSTANT('usePropMarshall',true);

//string8 in_date := '' : stored('RecordByDate');
//unsigned4 dateVal := (unsigned)(in_date);
unsigned1 DPPA_Purpose := 0 : stored('DPPAPurpose');
unsigned1 GLB_Purpose := 8 : stored('GLBPurpose');

input := dataset([], Doxie_Raw.Layout_input) : stored('header_src_in',few);

string bdid := if(input[1].idtype = 'BDID' or input[1].idtype = 'bdid', input[1].id, '');
string bdl := if(input[1].idtype = 'BDL' or input[1].idtype = 'bdl', input[1].id, '');
#stored('BDID', bdid);
#stored('BDL', bdl);

//Assume one row.
// - Can't send multiple GIDs
// - Can't ask for multiple sections
// 	- Blank section is for all sources
sect := input[1].section;

bsect(string sect_name, string sect_in) := sect_name = stringlib.stringtouppercase(sect_in);

bsect_name := (sect[1..2] = 'N0' or sect[1..2] = 'n0');
bsect_name_id := if(bsect_name,sect[3..],'');
bsect_addr := (sect[1..2] = 'A0' or sect[1..2] = 'a0');
bsect_addr_id := if(bsect_addr,sect[3..],'');
bsect_phone := (sect[1..2] = 'P0' or sect[1..2] = 'p0');
bsect_phone_id := if(bsect_phone,sect[3..],'');
bsect_fein := (sect[1..2] = 'F0' or sect[1..2] = 'f0');
bsect_fein_id := if(bsect_fein,sect[3..],'');
bsect_val := global(NOT (sect = '' OR stringlib.stringtouppercase(sect) = stringlib.stringtouppercase('all_sources')));
#stored('SelectIndividually', bsect_val);


// Strictly Section Names
#stored('IncludeNameVariations', bsect('NAME_VARIATIONS',sect) or bsect_name);
#stored('IncludeAddressVariations', bsect('ADDRESS_VARIATIONS',sect) or bsect_addr);	
#stored('IncludePhoneVariations', bsect('PHONE_VARIATIONS',sect) or bsect_phone);
#stored('IncludeFeinVariations', bsect('FEIN_VARIATIONS',sect) or bsect_fein);
#stored('IncludeParentCompany', bsect('PARENT_COMPANY',sect));
#stored('IncludeSales', bsect('SALES',sect));
#stored('IncludeIndustryInformation', bsect('INDUSTRY_INFORMATION',sect));
#stored('IncludeCompanyIDnumbers', bsect('ID_NUMBERS',sect));
#stored('IncludeCompanyIDnumbersV2', bsect('ID_NUMBERS_V2',sect));
#stored('IncludeLiensJudgmentsUCC', bsect('LIENS_JUDGMENTS_UCCS',sect)); 
#stored('IncludeLiensJudgmentsUCCV2', bsect('LIENS_JUDGMENTS_UCCS_V2',sect));
#stored('IncludeCompanyProfile', bsect('PROFILE_INFORMATION',sect));
#stored('IncludeCompanyProfileV2', bsect('PROFILE_INFORMATION_V2',sect));
#stored('IncludeRegisteredAgents', bsect('REGISTERED_AGENTS',sect)); 
#stored('IncludeExecutives', bsect('EXECUTIVES',sect)); 
#stored('IncludeBusinessAssociates', bsect('BUSINESS_ASSOCIATES',sect)); 

// Strictly Sources or Both
#stored('IncludeFinder', bsect('FINDER',sect)); 
#stored('IncludeDCA', bsect('DCA',sect));
#stored('IncludeDunBradstreetRecords', bsect('DNB',sect)); 
#stored('IncludeCorporationFilings', bsect('CORPORATE_FILINGS',sect)); 
#stored('IncludeCorporationFilingsV2', bsect('CORPORATE_FILINGS_V2',sect)); 
#stored('IncludeBankruptcies', bsect('BANKRUPTCY',sect));
#stored('IncludeBankruptciesV2', bsect('BANKRUPTCY_V2',sect));
#stored('IncludeUCCFilings', bsect('UCCS',sect) or bsect('LIENS_JUDGMENTS_UCCS',sect)); 
#stored('IncludeUCCFilingsV2', bsect('UCCS_V2',sect) or bsect('LIENS_JUDGMENTS_UCCS_V2',sect)); 
#stored('IncludeLiensJudgments', bsect('LIENS_JUDGMENTS',sect) or bsect('LIENS_JUDGMENTS_UCCS',sect)); 
#stored('IncludeLiensJudgmentsV2', bsect('LIENS_JUDGMENTS_V2',sect) or bsect('LIENS_JUDGMENTS_UCCS_V2',sect)); 
#stored('IncludeAssociatedPeople', bsect('CONTACTS',sect));
#stored('IncludeProperties', bsect('PROPERTY',sect)); 
#stored('IncludePropertiesV2', bsect('PROPERTY_V2',sect)); 
#stored('IncludeMotorVehicles', bsect('MOTOR_VEHICLES',sect));
#stored('IncludeMotorVehiclesV2', bsect('MOTOR_VEHICLES_V2',sect));
#stored('IncludeWatercrafts', bsect('WATERCRAFTS',sect));
#stored('IncludeAircrafts', bsect('AIRCRAFTS',sect));
#stored('IncludeExperianBusinessReports', bsect('EBR',sect));
#stored('IncludeBusinessRegistrations', bsect('BUSINESS_REGISTRATIONS',sect));
#stored('IncludeIRS5500', bsect('IRS',sect) or bsect('IRSALL',sect));
#stored('IncludeIRSNonP', bsect('IRSNONP',sect) or bsect('IRSALL',sect));
#stored('IncludeFDIC', bsect('FDIC',sect));
#stored('IncludeBBBMember', bsect('BBBMEM',sect) or bsect('BBB',sect));
#stored('IncludeBBBNonMember', bsect('BBBNONMEM',sect) or bsect('BBB',sect));
#stored('IncludeCASalesTax', bsect('CASALES',sect) or bsect('SALESTAX',sect));
#stored('IncludeIASalesTax', bsect('IASALES',sect) or bsect('SALESTAX',sect));
#stored('IncludeMSWorkComp', bsect('MSWORK',sect) or bsect('WORKCOMP',sect));
#stored('IncludeORWorkComp', bsect('ORWORK',sect) or bsect('WORKCOMP',sect));
#stored('IncludeInternetDomains', bsect('INTERNET',sect));
#stored('IncludeProfessionalLicenses', bsect('PROFESSIONAL_LICENSES',sect));
#stored('IncludeSuperiorLiens', bsect('SUPERIOR_LIENS',sect));
#stored('IncludeForeclosures', bsect('FORECLOSURES',sect));
#stored('IncludeNoticeOfDefaults', bsect('NOTICE_OF_DEFAULTS',sect));

// Name, Address or Phone Source IDs
#stored('SourceIdName', bsect_name_id);
#stored('SourceIdAddr', bsect_addr_id);
#stored('SourceIdPhone', bsect_phone_id);
#stored('SourceIdFein', bsect_fein_id);


doxie_cbrs.Business_Report_Service_Raw();

ENDMACRO;
