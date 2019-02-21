/*--SOAP--
<message name="BocaShell" wuTimeout="300000">
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
	<part name="DPPAPurpose" type="xsd:byte"/>
	<part name="GLBPurpose" type="xsd:byte"/> 
	<part name="DataRestrictionMask" type="xsd:string"/>
	<part name="DataPermissionMask" type="xsd:string"/>
	<part name="IndustryClass" type="xsd:string"/>
	<part name="HistoryDateYYYYMM" type="xsd:integer"/>
	<part name="historyDateTimeStamp" type="xsd:string"/>
	<part name="ExcludeRelatives" type = 'xsd:boolean'/>
	<part name="BSVersion" type = 'xsd:integer'/>
	<part name="IncludeScore" type = "xsd:boolean"/>
	<part name="ADL_Based_Shell" type="xsd:boolean"/>
	<part name="RemoveFares" type="xsd:boolean"/>
	<part name="LeadIntegrityMode" type="xsd:boolean"/>
	<part name="DID" type="xsd:string"/>
	<part name="LastSeenThreshold" type="xsd:string"/>
	<part name="RetainInputDID" type="xsd:boolean"/>
	<part name="GlobalWatchlistThreshold" type="xsd:real"/>
	<part name="OFACversion" type="xsd:unsignedInt"/>
	<part name="IncludeOfac" type="xsd:boolean"/>
	<part name="IncludeAdditionalWatchLists" type="xsd:boolean"/> 
	<part name="gateways" type="tns:XmlDataSet" cols="110" rows="10"/>
 </message>
*/

import ut, riskwise, risk_indicators, AutoStandardI;

export Boca_Shell := MACRO

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
	'DPPAPurpose',
	'GLBPurpose', 
	'DataRestrictionMask',
	'DataPermissionMask',
	'IndustryClass',
	'HistoryDateYYYYMM',
	'historyDateTimeStamp',
	'ExcludeRelatives',
	'BSVersion',
	'IncludeScore',
	'ADL_Based_Shell',
	'RemoveFares',
	'LeadIntegrityMode',
	'DID',
	'LastSeenThreshold',
	'RetainInputDID',
	'OFACversion',
	'IncludeOfac',
	'IncludeAdditionalWatchLists',
	'GlobalWatchlistThreshold',
	'gateways'));

string30 account_value := '' 		: stored('AccountNumber');
string30 fname_val := ''     		: stored('FirstName');
string30 mname_val := ''     		: stored('MiddleName');
string30 lname_val := ''     		: stored('LastName');
string5 suffix_val := ''     		: stored('NameSuffix');
string120 addr1_val := ''    		: stored('StreetAddress');
string25 city_val := ''      		: stored('City');
string2 state_val := ''      		: stored('State');
string5 zip_value := ''      		: stored('Zip');
string25 country_value := '' 		: stored('Country');

string9 ssn_value := ''      		: stored('ssn');
string8 dob_value := ''      		: stored('DateOfBirth');
unsigned1 age_value := 0      	: stored('Age');

STRING20 dl_number_value := ''     : stored('DLNumber');
STRING2 dl_state_value := ''       : stored('DLState');

string100 email_value := ''  		: stored('Email');
STRING45 ip_value := ''      		: stored('IPAddress');

string10 phone_value := ''   		: stored('HomePhone');
STRING10 wphone_value := ''  		: stored('WorkPhone');

STRING100 employe_name_value := '' : stored('EmployerName');
STRING30 prev_lname_value := ''    : stored('FormerName');

unsigned1 DPPA_Purpose := 0 		: stored('DPPAPurpose');
unsigned1 GLB_Purpose := 8 		: stored('GLBPurpose');
STRING5 industry_class_val := '' 	: STORED('IndustryClass');
industry_class_value := StringLib.StringToUpperCase(industry_class_val);
unsigned3 history_date := 999999 	: stored('HistoryDateYYYYMM');
string20	historyDateTimeStamp := '' : stored('historyDateTimeStamp');  // new for shell 5.0
boolean	no_rel := false 		: stored('ExcludeRelatives');
unsigned1 bsversion := 255			: stored('BSVersion');	// version 1 is the original, 2 would add BS 2 fields and 3 will add BS 3 fields
boolean doScore := false			: stored('IncludeScore');// allows the output of RV or FD score on realtime runs for modeling team
boolean ADL_Based_Shell := false				: stored('ADL_Based_Shell');
boolean RemoveFares := false				: stored('RemoveFares');
boolean LeadIntegrityMode := false : stored('LeadIntegrityMode');
FraudPointMode := if(bsversion>=41, true, false);	// hardcode this to true so that fraud attributes are run correctly
unsigned1 append_best := if(LeadIntegrityMode, 2, 1);	// 2 indicates to append best SSN to input, 1 indicates to get the best ssn but not append to input

string did_value := ''	: stored('DID');

string50 DataRestriction := AutoStandardI.GlobalModule().DataRestrictionMask;
string50 DataPermission  := Risk_Indicators.iid_constants.default_DataPermission : stored('DataPermissionMask');
unsigned3 LastSeenThresholdIn := 0 : stored('LastSeenThreshold');
boolean RetainInputDID := false : stored('RetainInputDID');  // to be used by modeling team for R&D purpose

real watchlist_threshold := 0.84 			: stored('GlobalWatchlistThreshold');
unsigned1 ofac_version      := 1        : stored('OFACVersion');
boolean   include_ofac       := false    : stored('IncludeOfac');
boolean   include_additional_watchlists  := false    : stored('IncludeAdditionalWatchLists');

rec := record
  unsigned4 seq;
  end;
d := dataset([{(unsigned)account_value}],rec);


clean_a2 := Risk_Indicators.MOD_AddressClean.clean_addr(addr1_val, city_val, state_val, zip_value);


risk_indicators.layout_input into(rec l) := transform
	self.seq := l.seq;
	self.historydate := if(historyDateTimeStamp<>'',(unsigned)historyDateTimeStamp[1..6], history_date);
	self.historyDateTimeStamp := risk_indicators.iid_constants.mygetdateTimeStamp(historydateTimeStamp, history_date);
	self.DID := (unsigned)did_value; 
	self.score := if(self.did<>0, 100, 0);
		
	SELF.in_streetAddress := addr1_val;
	SELF.in_city := city_val;
	SELF.in_state := state_val;
	SELF.in_zipCode := zip_value;
	SELF.in_country := country_value;
	
	self.ssn := ssn_value;
	self.dob := dob_value;
				temp_age :=  if (age_value = 0 and (integer)dob_value != 0, 
														(STRING)ut.GetAgeI_asOf((unsigned)dob_value, (unsigned)risk_indicators.iid_constants.myGetDate(history_date)), 
														(STRING)age_value);
	self.age := if((integer)temp_age > 99, '99',temp_age);
	
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
	self := [];	// layout_overrides
end;
iid_prep := PROJECT(d,into(LEFT));

gateways_in := Gateway.Configuration.Get();

Gateway.Layouts.Config gw_switch(gateways_in le) := transform
	self.servicename := le.servicename;
	self.url := map(bsversion >= 50 and stringlib.StringToLowerCase(trim(le.servicename))in[Gateway.Constants.ServiceName.InsurancePhoneHeader, Gateway.Constants.ServiceName.DeltaInquiry] => le.url, // insurance phones gateway allowed if shell version 50 or higher
                 le.servicename = 'bridgerwlc' => le.url, // included bridger gateway to be able to hit OFAC v4
                  '');
          
self := le;
end;

gateways := project(gateways_in, gw_switch(left));

LastSeenThreshold_default := if(bsversion>=50, risk_indicators.iid_constants.max_unsigned3, risk_indicators.iid_constants.oneyear);
unsigned3 LastSeenThreshold := if(LastSeenThresholdIn=0, lastSeenThreshold_default, LastSeenThresholdIn);

isFCRA := false;
ln_branded := false;
isUtility := industry_class_value = 'UTILI';
ofac_only := true;
suppressNearDups := false;
require2ele := false;
from_biid := false;
excludeWatchlists := false;
from_IT1O := false;
//ofac_version := 1;
//include_ofac := false;
//include_additional_watchlists := false;
//watchlist_threshold := 0.84;
dob_radius := -1;
includeRelativeInfo := true;
includeDLInfo := true;
includeVehInfo := true;
includeDerogInfo :=true;
nugen := true;


IncludeDLverification := if(FraudPointMode, true, false);
unsigned8 BSOptions := 
	if(FraudPointMode, risk_indicators.iid_constants.BSOptions.IncludeDoNotMail +
										 risk_indicators.iid_constants.BSOptions.IncludeFraudVelocity,
											0) +
	if(RetainInputDID, Risk_Indicators.iid_constants.BSOptions.RetainInputDID, 0 ) +
	if(bsVersion >= 50, risk_indicators.iid_constants.BSOptions.IncludeHHIDSummary, 0);


prep := risk_indicators.InstantID_Function(iid_prep, 
																						gateways, 
																						dppa_purpose, 
																						glb_purpose, 
																						isUtility, 
																						ln_branded, 
																						ofac_only,
																						suppressNearDups,
																						require2ele,
																						isFCRA,
																						from_biid,
																						ExcludeWatchLists,
																						from_IT1O,
																						ofac_version,
																						include_ofac,
																						include_additional_watchlists,
																						watchlist_threshold,
																						dob_radius,
																						bsversion, 
																						in_runDLverification:=IncludeDLverification,
																						in_dataRestriction:=DataRestriction,
																						in_append_best := append_best,
																						in_BSOptions := bsOptions,
																						in_LastSeenThreshold := LastSeenThreshold,
																						in_dataPermission:=DataPermission);
													
ret := risk_indicators.Boca_Shell_Function(prep, gateways, DPPA_Purpose, GLB_Purpose, industry_class_value='UTILI',false, ~no_rel, true, true, true, bsversion, doScore, 
										nugen := nugen, filter_out_fares := RemoveFares, DataRestriction:=DataRestriction,BSOptions := BSOptions, DataPermission:=DataPermission);

adl_based_ret := risk_indicators.ADL_Based_Modeling_Function(iid_prep,
																		gateways, 
																		dppa_purpose, 
																		glb_purpose, 
																		isFCRA,
																		bsversion, 
																		isUtility,
																		ln_branded,
																		ofac_only,
																		suppressNearDups,
																		require2ele,
																		from_biid,
																		excludeWatchLists,
																		from_IT1O,
																		ofac_version,
																		include_ofac,
																		include_additional_watchlists,
																		watchlist_threshold,
																		dob_radius,
																		includeRelativeInfo,
																		includeDLInfo,
																		includeVehInfo, 
																		includeDerogInfo, 
																		doScore, 
																		nugen,
																		DataRestriction:=DataRestriction, 
																		DataPermission:=DataPermission);
																		

final := if(ADL_Based_Shell, adl_based_ret, ret);

output(final,NAMED('Results'))


ENDMACRO;

// risk_indicators.Boca_Shell();

