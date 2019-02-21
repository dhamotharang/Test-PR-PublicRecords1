/*--SOAP--
<message name="BocaShellFCRA" wuTimeout="300000">
	<part name="AccountNumber" type="xsd:string"/>
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
	<part name="IndustryClass" type="xsd:string"/>
	<part name="HistoryDateYYYYMM" type="xsd:integer"/>
	<part name="historyDateTimeStamp" type="xsd:string"/>
	<part name="neutral_gateway" type="xsd:string"/>
	<part name="Require2" type="xsd:boolean"/>
	<part name="BSVersion" type = 'xsd:integer'/>
	<part name="PreScreen" type = 'xsd:boolean'/>
	<part name="IncludeScore" type = 'xsd:boolean'/>
	<part name="ADL_Based_Shell" type="xsd:boolean"/>
	<part name="DataRestrictionMask" type="xsd:string"/>
	<part name="DataPermissionMask" type="xsd:string"/>
	<part name="InsuranceMode" type="xsd:boolean"/>
	<part name="Include_nonFCRA_Collections_Inquiries" type="xsd:boolean"/>
	<part name="RetainInputDID" type="xsd:boolean"/>
	<part name="DID" type="xsd:string"/>
	<part name="IncludeLnJ" type="xsd:boolean"/>
	<part name="IncludeRecordsWithSSN" type="xsd:boolean"/>
	<part name="IncludeBureauRecs" type="xsd:boolean"/>
 <part name="ReportingPeriod" type="xsd:integer"/>
	<part name="ExcludeCityTaxLiens" type="xsd:boolean"/>
	<part name="ExcludeCountyTaxLiens" type="xsd:boolean"/>
	<part name="ExcludeStateTaxWarrants" type="xsd:boolean"/>
	<part name="ExcludeStateTaxLiens" type="xsd:boolean"/>
	<part name="ExcludeFederalTaxLiens" type="xsd:boolean"/>
	<part name="ExcludeOtherLiens" type="xsd:boolean"/>
	<part name="ExcludeJudgments" type="xsd:boolean"/>
	<part name="ExcludeEvictions" type="xsd:boolean"/>
<!--	<part name="Gateways" type = 'tns:XmlDataSet' cols = '70' rows = '10'/>-->
 </message>
*/ 
import gateway, risk_indicators;
export Boca_Shell_FCRA := MACRO

/* Force layout of WsECL page */
#WEBSERVICE(FIELDS(
	'AccountNumber',
	'FirstName',
	'MiddleName',
	'LastName',
	'NameSuffix',
	'StreetAddress',
	'City',
	'State',
	'Zip',
	'Country',
	'SSN',
	'DateOfBirth',
	'Age',
	'DLNumber',
	'DLState',
	'Email',
	'IPAddress',
	'HomePhone',
	'WorkPhone',
	'EmployerName',
	'FormerName',
	'IndustryClass',
	'HistoryDateYYYYMM',
	'historyDateTimeStamp',
	'neutral_gateway',
	'Require2',
	'BSVersion',
	'PreScreen',
	'IncludeScore',
	'ADL_Based_Shell',
	'DataRestrictionMask',
	'DataPermissionMask',
	'InsuranceMode',
	'Include_nonFCRA_Collections_Inquiries',
	'RetainInputDID',
	'DID',
	'IncludeLnJ',
  'IncludeRecordsWithSSN',
  'IncludeBureauRecs', 
  'ReportingPeriod', 
  'ExcludeCityTaxLiens',
  'ExcludeCountyTaxLiens',
  'ExcludeStateTaxWarrants',
  'ExcludeStateTaxLiens',
  'ExcludeFederalTaxLiens',
  'ExcludeOtherLiens',
  'ExcludeJudgments',
  'ExcludeEvictions'
	));
	

string30 account_value := '' : stored('AccountNumber');
string30 fname_val := ''     : stored('FirstName');
string30 mname_val := ''     : stored('MiddleName');
string30 lname_val := ''     : stored('LastName');
string5 suffix_val := ''     : stored('NameSuffix');
string120 addr1_val := ''    : stored('StreetAddress');
string25 city_val := ''      : stored('City');
string2 state_val := ''      : stored('State');
string5 zip_value := ''      : stored('Zip');
string25 country_value := '' : stored('Country');

string9 ssn_value := ''      : stored('ssn');
string8 dob_value := ''      : stored('DateOfBirth');
unsigned1 age_value := 0      : stored('Age');

STRING20 dl_number_value := ''     : stored('DLNumber');
STRING2 dl_state_value := ''       : stored('DLState');

string100 email_value := ''  : stored('Email');
STRING45 ip_value := ''      : stored('IPAddress');

string10 phone_value := ''   : stored('HomePhone');
STRING10 wphone_value := ''  : stored('WorkPhone');

STRING100 employe_name_value := ''   : stored('EmployerName');
STRING30 prev_lname_value := ''      : stored('FormerName');

unsigned1 DPPA_Purpose := 0;
unsigned1 GLB_Purpose := 8;
STRING5 industry_class_val := '' : STORED('IndustryClass');
industry_class_value := StringLib.StringToUpperCase(industry_class_val);
unsigned3 history_date := 999999 : stored('HistoryDateYYYYMM');
string20	historyDateTimeStamp := '' : stored('historyDateTimeStamp');  // new for shell 5.0
boolean	includeRelativeInfo := false;
boolean require2Ele := false : stored ('Require2');
unsigned1 version := 255		: stored('BSVersion');	// boca shell version, defaulting to 255 to ensure we get all the fields for testing
boolean isPreScreen := false	: stored('PreScreen');
boolean doScore := false			: stored('IncludeScore');// allow outputting of RV or FD score for modelers

string neutral_ip := '' : stored('neutral_gateway');
boolean ADL_Based_Shell := false	: stored('ADL_Based_Shell');
string50 DataRestriction := risk_indicators.iid_constants.default_DataRestriction : stored('DataRestrictionMask');
string50 DataPermission  := Risk_Indicators.iid_constants.default_DataPermission : stored('DataPermissionMask');
boolean InsuranceMode := false				: stored('InsuranceMode');  // when true, this will set different filtering rules for BK
boolean RetainInputDID := false				: stored('RetainInputDID');  // to be used by modelers in R&D mode
string did_value := ''	: stored('DID');
boolean IncludeLnJ := false 					: stored('IncludeLnJ');
boolean FilterLiens := DataRestriction[risk_indicators.iid_constants.posLiensJudgRestriction]='1' ;
// when true, this will run an additional soapcall over to neutral roxie to Risk_Indicators.Boca_Shell_Collections_Inquiry_Service
boolean Include_nonFCRA_Collections_Inquiries := false				: stored('Include_nonFCRA_Collections_Inquiries'); 
boolean IncludeRecordsWithSSN := false 					: stored('IncludeRecordsWithSSN');
boolean IncludeBureauRecs := false 					: stored('IncludeBureauRecs'); 
integer2 ReportingPeriod := 84      : stored('ReportingPeriod'); 
boolean ExcludeCityTaxLiens := false 					: stored('ExcludeCityTaxLiens');
boolean ExcludeCountyTaxLiens := false 					: stored('ExcludeCountyTaxLiens');
boolean ExcludeStateTaxWarrants := false 					: stored('ExcludeStateTaxWarrants');
boolean ExcludeStateTaxLiens := false 					: stored('ExcludeStateTaxLiens');
boolean ExcludeFederalTaxLiens := false 					: stored('ExcludeFederalTaxLiens');
boolean ExcludeOtherLiens := false 					: stored('ExcludeOtherLiens');
boolean ExcludeJudgments := false 					: stored('ExcludeJudgments');
boolean ExcludeEvictions := false 					: stored('ExcludeEvictions');
string tmpFilterLienTypes := Risk_Indicators.iid_constants.LnJDefault; 

tmpCityFltr := if(ExcludeCityTaxLiens, '0', tmpFilterLienTypes[1..1]);
	tmpCountyFltr := if(ExcludeCountyTaxLiens, '0', tmpFilterLienTypes[2..2]);
	tmpStateWarrantFltr := if(ExcludeStateTaxWarrants, '0', tmpFilterLienTypes[3..3]);
	tmpStateFltr :=  if(ExcludeStateTaxLiens, '0', tmpFilterLienTypes[4..4]);
	tmpFedFltr := if(ExcludeFederalTaxLiens, '0', tmpFilterLienTypes[5..5]);
	tmpLiensFltr := if(ExcludeOtherLiens,'0', tmpFilterLienTypes[6..6]);
	tmpJdgmtsFltr := if(ExcludeJudgments, '0', tmpFilterLienTypes[7..7]);
	tmpEvictionsFltr := if(ExcludeEvictions, '0', tmpFilterLienTypes[8..8]);
		//We now have boolean options for each of these filters. We built the code to use a bit (string)
		//saying which ones they want and which ones they want to filter. I take the boolean flags and 
		//turn them into the string the code is expecting. FlagLiensOptions in constants will convert to 
		//the BS options in the search_function.
	FilterLienTypes := tmpCityFltr + 
		tmpCountyFltr +
		tmpStateWarrantFltr +
		tmpStateFltr + 
		tmpFedFltr +
		tmpLiensFltr +
		tmpJdgmtsFltr +
		tmpEvictionsFltr;

gateways := DATASET ([{'neutralroxie', neutral_ip}], Gateway.Layouts.Config);

//Since RiskView only runs ADL shell for Prescreen, enforce that here as well
if(ADL_Based_Shell and ~isPreScreen, FAIL('Request for ADL shell must also request Prescreen'));
if(ReportingPeriod <= 0 or ReportingPeriod > 84, FAIL('Input Value for ReportingPeriod must be 1 - 84 months.'));

clean_a2 := Risk_Indicators.MOD_AddressClean.clean_addr(addr1_val, city_val, state_val, zip_value);


risk_indicators.Layout_Input into() := transform
	self.seq := (unsigned)account_value;
	
	self.DID := (unsigned)did_value; 
	self.score := if(self.did<>0, 100, 0);
		
	SELF.in_streetAddress := addr1_val;
	SELF.in_city := city_val;
	SELF.in_state := state_val;
	SELF.in_zipCode := zip_value;
	SELF.in_country := country_value;
	
	self.ssn := ssn_value;
	self.dob := dob_value;
			Temp_age := if (age_value = 0 and (integer)dob_value != 0, 
														(STRING)ut.GetAgeI_asOf((unsigned)dob_value, (unsigned)risk_indicators.iid_constants.myGetDate(history_date)), 
														(STRING)age_value);
	self.age := if((integer)Temp_age > 99, '99',Temp_age);

	self.phone10 := phone_value;
	self.wphone10 := wphone_value;
	
	self.fname := stringlib.stringtouppercase(fname_val);
	self.mname := stringlib.stringtouppercase(mname_val);
	self.lname := stringlib.stringtouppercase(lname_val);
	self.suffix := stringlib.stringtouppercase(suffix_val);

	self.prim_range := clean_a2[1..10];
	self.predir := clean_a2[11..12];
	self.prim_name := clean_a2[13..40];
	self.addr_suffix := clean_a2[41..44];
	self.postdir := clean_a2[45..46];
	self.unit_desig := clean_a2[47..56];
	self.sec_range := clean_a2[57..65];
	self.p_city_name := clean_a2[90..114];
	self.st := clean_a2[115..116];
	self.z5 := clean_a2[117..121];
	self.zip4 := clean_a2[122..125];
	self.lat := clean_a2[146..155];
	self.long := clean_a2[156..166];
	self.addr_type := clean_a2[139];
	self.addr_status := clean_a2[179..182];
	self.county := clean_a2[143..145];
	self.geo_blk := clean_a2[171..177];

	self.country := country_value;
	
	dl_num_clean := riskwise.cleanDL_num(dl_number_value);
	
	SELF.dl_number := stringlib.stringtouppercase(dl_num_clean);
	SELF.dl_state := stringlib.stringtouppercase(dl_state_value);
	
	SELF.email_address := email_value;
	SELF.ip_address := ip_value;
	
	SELF.employer_name := stringlib.stringtouppercase(employe_name_value);
	SELF.lname_prev := stringlib.stringtouppercase(prev_lname_value);
	self.historydate := if(historyDateTimeStamp<>'',(unsigned)historyDateTimeStamp[1..6], history_date);
	self.historyDateTimeStamp := risk_indicators.iid_constants.mygetdateTimeStamp(historydateTimeStamp, history_date);
end;
iid_prep := PROJECT(DATASET ([{0}], {integer int}), into());

nugen := true;
AppendBest := 1;
BSOptions := if( InsuranceMode, Risk_Indicators.iid_constants.BSOptions.InsuranceMode, 0 ) +
if(RetainInputDID, Risk_Indicators.iid_constants.BSOptions.RetainInputDID, 0 ) +
if(Include_nonFCRA_Collections_Inquiries, Risk_Indicators.iid_constants.BSOptions.Include_nonFCRA_Collections_Inquiries, 0) +
if(FilterLiens, Risk_Indicators.iid_constants.BSOptions.FilterLiens, 0) +
if(isPreScreen, risk_indicators.iid_constants.BSOptions.IncludePreScreen, 0) +
Risk_Indicators.iid_constants.FlagLiensOptions(FilterLienTypes) + //sets the individual Lien/Judgment Filters
if( IncludeRecordsWithSSN, risk_indicators.iid_constants.BSOptions.SSNLienFtlr, 0 ) + 
if( IncludeBureauRecs, risk_indicators.iid_constants.BSOptions.BCBLienFtlr, 0 ) 
;

ret := risk_indicators.Boca_Shell_Function_FCRA
   (iid_prep, gateways, DPPA_Purpose, GLB_purpose, industry_class_value='UTILI',
    false, require2Ele, includeRelativeInfo, true, false, true, TRUE, FALSE, FALSE, 
    FALSE, FALSE, 1, FALSE, FALSE, 0.84, version, isPreScreen, doScore, nugen, 
		ADL_Based_Shell,dataRestriction, AppendBest, BSOptions,
		DataPermission, false, IncludeLnJ, ReportingPeriod);

output (ret, NAMED('Results'))

ENDMACRO;
// Risk_Indicators.Boca_Shell_FCRA()