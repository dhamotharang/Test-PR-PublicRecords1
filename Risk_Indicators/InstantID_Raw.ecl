/*--SOAP--
<message name="InstantID RAW">
	<part name="AccountNumber" type="xsd:string"/>
	<part name="UnParsedFullName" type="xsd:string"/>
	<part name="FirstName" type="xsd:string"/>
	<part name="MiddleName" type="xsd:string"/>
	<part name="LastName" type="xsd:string"/>
	<part name="NameSuffix" type="xsd:string"/>
	<part name="StreetAddress" type="xsd:string"/>
	<part name="City" type="xsd:string"/>
	<part name="State" type="xsd:string"/>
	<part name="Zip" type="xsd:string"/>
	<part name="Country" type="xsd:string"/>
	<part name="SSN" type="xsd:string"/>
	<part name="DateOfBirth" type="xsd:string"/>
	<part name="Age" type="xsd:unsignedInt"/>
	<part name="DLNumber" type="xsd:string"/>
	<part name="DLState" type="xsd:string"/>
	<part name="Email" type="xsd:string"/>
	<part name="IPAddress" type="xsd:string"/>
	<part name="HomePhone" type="xsd:string"/>
	<part name="WorkPhone" type="xsd:string"/>
	<part name="EmployerName" type="xsd:string"/>
	<part name="FormerName" type="xsd:string"/>
	<part name="DPPAPurpose" type="xsd:byte"/>
	<part name="GLBPurpose" type="xsd:byte"/> 
	<part name="IndustryClass" type="xsd:string"/>
	<part name="HistoryDateYYYYMM" type="xsd:integer"/>
	<part name="PoBoxCompliance" type="xsd:boolean"/>
	<part name="OfacOnly" type="xsd:boolean"/>
	<part name="ExcludeWatchLists" type="xsd:boolean"/>
	<part name="OFACversion" type="xsd:unsignedInt"/>
	<part name="IncludeOfac" type="xsd:boolean"/>
	<part name="GlobalWatchlistThreshold" type="xsd:real"/>  
	<part name="IncludeAdditionalWatchLists" type="xsd:boolean"/>
	<part name="UseDOBFilter" type="xsd:boolean"/>
	<part name="DOBRadius" type="xsd:unsignedInt"/>	
	<part name="TestDataEnabled" type="xsd:boolean"/>
	<part name="TestDataTableName" type="xsd:string"/>
	<part name="FromIIDModel" type="xsd:boolean"/>
	<part name="RedFlag_version" type="xsd:unsignedInt"/>
	<part name="SSNMask" type="xsd:string"/>
	<part name="DLMask"	type="xsd:string"/>
  <part name="DOBMask" type="xsd:string"/>
	<part name="IncludeTargusE3220" type="xsd:boolean"/>
	<part name="scores" type="tns:XmlDataSet" cols="110" rows="10"/>
	<part name="gateways" type="tns:XmlDataSet" cols="110" rows="10"/>
	<part name="ExactFirstNameMatch" type="xsd:boolean"/>
	<part name="ExactLastNameMatch" type="xsd:boolean"/>
	<part name="ExactAddrMatch" type="xsd:boolean"/>
	<part name="ExactPhoneMatch" type="xsd:boolean"/>
	<part name="ExactSSNMatch" type="xsd:boolean"/>
	<part name="ExactDOBMatch" type="xsd:boolean"/>
	<part name="DataRestrictionMask" type="xsd:string"/>
	<part name="DataPermissionMask" type="xsd:string"/>
	<part name="IncludeMSoverride" type="xsd:boolean"/>
	<part name="IncludeDLVerification" type="xsd:boolean"/>
	<part name="WatchList" type="tns:XmlDataSet" cols="90" rows="10"/>
	<part name="PassportUpperLine" type="xsd:string"/>
	<part name="PassportLowerLine" type="xsd:string"/>
	<part name="Gender" type="xsd:string"/>	
	<part name="DOBMatchOptions" type="tns:XmlDataSet" cols="110" rows="10"/>
 </message>
*/

import ut, codes, address, models, riskwise, suppress, AutoStandardI, iesp, IntlIID, gateway;
export InstantID_Raw := MACRO

Risk_indicators.MAC_unparsedfullname(title_val,fname_val,mname_val,lname_val,suffix_val,'FirstName','MiddleName','LastName','NameSuffix')

string30 account_value := '' : stored('AccountNumber');
string120 addr1_val := ''    : stored('StreetAddress');
string25 city_val := ''      : stored('City');
string2 state_val := ''      : stored('State');
// string5 zip_value := ''      : stored('Zip');
string5 zip_value := AutoStandardI.GlobalModule().zip;
string25 country_value := '' : stored('Country');

// string9 ssn_value := ''      : stored('ssn');
string9 ssn_value := AutoStandardI.GlobalModule().ssn;

string8 dob_value := ''      : stored('DateOfBirth');
unsigned1 age_value := 0     : stored('Age');

STRING20 dl_number_value := ''     : stored('DLNumber');
STRING2 dl_state_value := ''       : stored('DLState');

string100 email_value := ''  : stored('Email');
STRING20 ip_value := ''      : stored('IPAddress');

string10 phone_value := ''   : stored('HomePhone');
STRING10 wphone_value := ''  : stored('WorkPhone');

STRING100 employe_name_value := ''   	: stored('EmployerName');
STRING30 prev_lname_value := ''      	: stored('FormerName');

boolean Test_Data_Enabled := FALSE   	: stored('TestDataEnabled');
string20 Test_Data_Table_Name := ''  	: stored('TestDataTableName');

unsigned1 DPPA_Purpose := 0 					: stored('DPPAPurpose');
unsigned1 GLB_Purpose := 8 						: stored('GLBPurpose');
STRING5 industry_class_val := '' 			: stored('IndustryClass');
	isUtility := Doxie.Compliance.isUtilityRestricted(STD.Str.ToUpperCase(industry_class_val));
unsigned3 history_date := 999999 			: stored('HistoryDateYYYYMM');
boolean IsPOBoxCompliant := false 		: stored('PoBoxCompliance');
boolean ofac_only := true 						: stored('OfacOnly');
boolean ExcludeWatchLists := false 		: stored('ExcludeWatchLists');
unsigned1 OFAC_version :=1 						: stored('OFACversion');
boolean Include_Additional_watchlists := FALSE	: stored('IncludeAdditionalWatchlists');
boolean Include_Ofac := FALSE										: stored('IncludeOfac');
real global_watchlist_threshold := .84 					: stored('GlobalWatchlistThreshold');
boolean use_dob_filter := FALSE 								: stored('UseDobFilter');
integer2 dob_radius := 2 												: stored('DobRadius');
boolean FromIIDModel := false 									: stored('FromIIDModel');
unsigned1 RedFlag_version := 0 	: stored('RedFlag_version');
string6 ssnmask := 'NONE' 			: stored('SSNMask');
string6 dobmask	:= 'NONE'		: stored('DOBMask');
unsigned1 dlmask := 0			: stored('DLMask');

boolean IncludeAllRC := false : stored('IncludeAllRiskCodes');
unsigned1 NumReturnCodes := if(IncludeAllRC, 255, risk_indicators.iid_constants.DefaultNumCodes);

boolean IncludeTargus3220 := false		: stored('IncludeTargusE3220');

boolean ExactFirstNameMatch := false : stored('ExactFirstNameMatch');
boolean ExactLastNameMatch := false : stored('ExactLastNameMatch');
boolean ExactAddrMatch := false : stored('ExactAddrMatch');
boolean ExactPhoneMatch := false : stored('ExactPhoneMatch');
boolean ExactSSNMatch := false : stored('ExactSSNMatch');
boolean ExactDOBMatch := false : stored('ExactDOBMatch');
boolean ExactDriverLicenseMatch := false 	: stored('ExactDriverLicenseMatch');
boolean ExactFirstNameMatchAllowNicknames := false : stored('ExactFirstNameMatchAllowNicknames');
string10 CustomDataFilter := '' : stored('CustomDataFilter');

string DataRestriction := AutoStandardI.GlobalModule().DataRestrictionMask; 
string10 DataPermission := Risk_Indicators.iid_constants.default_DataPermission : stored('DataPermissionMask');

// they want this customizable, so instead of doing an incremental ranking, use 1 or 0 for each element
// everything defaulted to off would be '00000000'  
// making this a string10 in case they decide to make it even more granular
string10 ExactMatchLevel := 	if(ExactFirstNameMatch, risk_indicators.iid_constants.sTrue, risk_indicators.iid_constants.sFalse) + 
										if(ExactLastNameMatch, risk_indicators.iid_constants.sTrue, risk_indicators.iid_constants.sFalse) + 
										if(ExactAddrMatch, risk_indicators.iid_constants.sTrue, risk_indicators.iid_constants.sFalse) + 
										if(ExactPhoneMatch, risk_indicators.iid_constants.sTrue, risk_indicators.iid_constants.sFalse) + 
										if(ExactSSNMatch, risk_indicators.iid_constants.sTrue, risk_indicators.iid_constants.sFalse) + 
										if(ExactDOBMatch, risk_indicators.iid_constants.sTrue, risk_indicators.iid_constants.sFalse) +
										if(ExactFirstNameMatchAllowNicknames, risk_indicators.iid_constants.sTrue, risk_indicators.iid_constants.sFalse) +
										if(ExactDriverLicenseMatch, risk_indicators.iid_constants.sTrue, risk_indicators.iid_constants.sFalse);

dob_radius_use := if(use_dob_filter,dob_radius,-1);
boolean suppressNearDups := false;
boolean require2ele := false;
boolean fromBiid := false;
boolean isFCRA := false;
boolean ln_branded := false;
boolean fromIT1O := false;

temp := record
		dataset(iesp.share.t_StringArrayItem) WatchList {xpath('WatchList/Name'), MAXCOUNT(iesp.Constants.MaxCountWatchLists)};
end;

watchlist_options := dataset([],temp) :stored('WatchList', few);
watchlists_request := watchlist_options[1].WatchList;
boolean IncludeDLverification := false : stored('IncludeDLverification');
string44 PassportUpperLine := '' : stored('PassportUpperLine');
string44 PassportLowerLine := '' : stored('PassportLowerLine');
string6 Gender := '' : stored('Gender');
boolean IncludeMSoverride := false : stored('IncludeMSoverride');

// DOB options
DOBMatchOptions_in := dataset([], risk_indicators.layouts.Layout_DOB_Match_Options) : STORED('DOBMatchOptions',few);


model_url := dataset([],Models.Layout_Score_Chooser) : STORED('scores',few);
gateways_in := Gateway.Configuration.Get();

Gateway.Layouts.Config gw_switch(gateways_in le) := transform
	self.servicename := map(IncludeTargus3220 and le.servicename = 'targus' => 'targuse3220',	// if E3220 requested, change servicename for later use
													le.servicename);
	self.url := map(IncludeTargus3220 and le.servicename = 'targus' => le.url + '?ver_=1.39',	// need version 1.39 for E3220,
									le.url); 
	self := le;
end;
gateways := project(gateways_in, gw_switch(left));

rec := record
  unsigned4 seq;
  end;
d := dataset([{(unsigned)account_value}],rec);


// JRP 02/12/2008 - Dataset of actioncode and reasoncode settings which are passed to the getactioncodes and reasoncodes functions.
boolean IsInstantID := true;
reasoncode_settings := dataset([{IsInstantID}],riskwise.layouts.reasoncode_settings);
actioncode_settings := dataset([{IsPOBoxCompliant, IsInstantID}],riskwise.layouts.actioncode_settings);

// Check to see if Red Flags or Fraud Advisor Requested
RedFlagsReq := redflag_version > 0;
FraudDefenderReq := EXISTS(model_url(name='Models.FraudAdvisor_Service'));

risk_indicators.Layout_Input into(rec l) := transform
	
	street_address := risk_indicators.MOD_AddressClean.street_address(addr1_val);
	clean_a2 := risk_indicators.MOD_AddressClean.clean_addr( street_address, city_val, state_val, zip_value ) ;		
	
	dob_val := riskwise.cleandob(dob_value);
	dl_num_clean := riskwise.cleanDL_num(dl_number_value);
	
	self.seq := l.seq;
		
	self.ssn := IF(ssn_value='000000000','',ssn_value);	// blank out social if it is all 0's
	self.dob := dob_val;
	self.age := if (age_value = 0 and (integer)dob_val != 0, (STRING3)ut.GetAgeI((integer)dob_val), (string3)age_value);
	
	self.phone10 := phone_value;
	self.wphone10 := wphone_value;
	
	self.title := stringlib.stringtouppercase(title_val);
	self.fname := stringlib.stringtouppercase(fname_val);
	self.mname := stringlib.stringtouppercase(mname_val);
	self.lname := stringlib.stringtouppercase(lname_val);
	self.suffix := stringlib.stringtouppercase(suffix_val);
	
	SELF.in_streetAddress := addr1_val;
	SELF.in_city := city_val;
	SELF.in_state := state_val;
	SELF.in_zipCode := zip_value;
	SELF.in_country := country_value;
	
	self.prim_range := clean_a2[1..10];
	self.predir := clean_a2[11..12];
	self.prim_name := clean_a2[13..40];
	self.addr_suffix := clean_a2[41..44];
	self.postdir := clean_a2[45..46];
	self.unit_desig := clean_a2[47..56];
	self.sec_range := clean_a2[57..64];
	self.p_city_name := clean_a2[90..114];
	self.st := clean_a2[115..116];
	self.z5 := clean_a2[117..121];
	self.zip4 := clean_a2[122..125];
	self.lat := clean_a2[146..155];
	self.long := clean_a2[156..166];
	
	self.addr_type := risk_indicators.iid_constants.override_addr_type(addr1_val, clean_a2[139],clean_a2[126..129]);
	self.addr_status := clean_a2[179..182];
	self.county := clean_a2[143..145];
	self.geo_blk := clean_a2[171..177];
		
	self.country := country_value;
	
	SELF.dl_number := stringlib.stringtouppercase(dl_num_clean);
	SELF.dl_state := stringlib.stringtouppercase(dl_state_value);
	
	SELF.email_address := email_value;
	SELF.ip_address := ip_value;
	
	SELF.employer_name := stringlib.stringtouppercase(employe_name_value);
	SELF.lname_prev := stringlib.stringtouppercase(prev_lname_value);
	self.historydate := history_date;
end;
prep := PROJECT(d,into(LEFT));


// Changed to default to version 2 in order to get back ADL info used in Red Flags.
unsigned1 BSversion := 2 : stored('BSVersion');
boolean runSSNCodes := true;
boolean runBestAddr := true;
boolean runChronoPhone := true;
boolean runAreaCodeSplit := true;
// boolean allowCellPhones := gateways(servicename='targuse3220').url <> '';	// if targuse3220 gateway is available then allow cell phone searching, NOTE: idp1/idp3 mean something a little different
boolean allowCellPhones := false;

ret := risk_indicators.InstantID_Function(prep, gateways, DPPA_Purpose, GLB_Purpose, isUtility, ln_branded,  
																					ofac_only, suppressNearDups, require2ele, fromBiid, isFCRA, ExcludeWatchLists,
																					fromIT1O,ofac_version,include_ofac,include_additional_watchlists,
																					global_watchlist_threshold,dob_radius_use,BSversion,runSSNCodes,runBestAddr,
																					runChronoPhone,runAreaCodeSplit,allowCellPhones,
																					ExactMatchLevel, DataRestriction, CustomDataFilter, IncludeDLverification, watchlists_request, 
																					DOBMatchOptions_in, in_DataPermission := DataPermission);

output( ret, named( 'Results' ) );

ENDMACRO;
// Risk_Indicators.InstantID_Raw()