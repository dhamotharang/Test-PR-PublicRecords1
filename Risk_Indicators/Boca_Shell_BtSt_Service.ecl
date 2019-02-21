//add changes to output order type


/*--SOAP--
<message name="BocaShell Bill-To Ship-To Service" wuTimeout="300000">
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
	<part name="FirstName2" type="xsd:string"/>
	<part name="MiddleName2" type="xsd:string"/>
	<part name="LastName2" type="xsd:string"/>
	<part name="NameSuffix2" type="xsd:string"/>
	<part name="StreetAddress2" type="xsd:string"/>
	<part name="City2" type="xsd:string"/>
	<part name="State2" type="xsd:string"/>
	<part name="Zip2" type="xsd:string"/>
	<part name="Country2" type="xsd:string"/>
	<part name="SSN2" type="xsd:string"/>
	<part name="DateOfBirth2" type="xsd:string"/>
	<part name="Age2" type="xsd:unsignedInt"/>
	<part name="DLNumber2" type="xsd:string"/>
	<part name="DLState2" type="xsd:string"/>
	<part name="Email2" type="xsd:string"/>
	<part name="IPAddress2" type="xsd:string"/>
	<part name="HomePhone2" type="xsd:string"/>
	<part name="WorkPhone2" type="xsd:string"/>
	<part name="EmployerName2" type="xsd:string"/>
	<part name="FormerName2" type="xsd:string"/>
	<part name="DPPAPurpose" type="xsd:byte"/>
	<part name="GLBPurpose" type="xsd:byte"/> 
	<part name="DataRestrictionMask" type="xsd:string"/>
	<part name="DataPermissionMask" type="xsd:string"/>
	<part name="BSVersion" type = 'xsd:integer'/>
	<part name="IndustryClass" type="xsd:string"/>
	<part name="HistoryDateYYYYMM" type="xsd:integer"/>
	<part name="HistoryDateTimeStamp" type="xsd:string"/>
	<part name="IncludeScore" type="xsd:boolean"/>
	<part name="RetainInputDID" type="xsd:boolean"/>
	<part name="GlobalWatchlistThreshold" type="xsd:real"/>
	<part name="OFACversion" type="xsd:unsignedInt"/>
	<part name="IncludeOfac" type="xsd:boolean"/>
	<part name="IncludeAdditionalWatchLists" type="xsd:boolean"/>
	<part name="gateways" type="tns:XmlDataSet" cols="70" rows="25"/>
	<part name="DeviceProvider1" type="xsd:string"/> //KountScore
	<part name="DeviceProvider2" type="xsd:string"/> //TmxScore
	<part name="DeviceProvider3" type="xsd:string"/> //lovationScore
	<part name="DeviceProvider4" type="xsd:string"/> //Para41Score
	<part name="TypeOfOrder" type="xsd:string"/>
 </message>
*/

import AutoStandardI, risk_indicators;

export Boca_Shell_BtSt_Service := macro

// Can't have duplicate definitions of Stored with different default values, 
// so add the default to #stored to eliminate the assignment of a default value.
#stored('DataRestrictionMask',risk_indicators.iid_constants.default_DataRestriction);

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
	'FirstName2',
	'MiddleName2',
	'LastName2',
	'NameSuffix2',
	'StreetAddress2',
	'City2',
	'State2',
	'Zip2',
	'Country2',
	'SSN2',
	'DateOfBirth2',
	'Age2',
	'DLNumber2',
	'DLState2',
	'Email2',
	'IPAddress2',
	'HomePhone2',
	'WorkPhone2',
	'EmployerName2',
	'FormerName2',
	'DPPAPurpose',
	'GLBPurpose', 
	'DataRestrictionMask',
	'DataPermissionMask',
	'BSVersion',
	'IndustryClass',
	'HistoryDateYYYYMM',
	'HistoryDateTimeStamp',
	'IncludeScore',
	'RetainInputDID',
	'OFACversion',
	'IncludeOfac',
	'IncludeAdditionalWatchLists',
	'GlobalWatchlistThreshold',
	'gateways',
	'DeviceProvider1',
	'DeviceProvider2',
	'DeviceProvider3',
	'DeviceProvider4',
	'TypeOfOrder'
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

string30 fname_val2 := ''     : stored('FirstName2');
string30 mname_val2 := ''     : stored('MiddleName2');
string30 lname_val2 := ''     : stored('LastName2');
string5 suffix_val2 := ''     : stored('NameSuffix2');
string120 addr1_val2 := ''    : stored('StreetAddress2');
string25 city_val2 := ''      : stored('City2');
string2 state_val2 := ''      : stored('State2');
string5 zip_value2 := ''      : stored('Zip2');
string25 country_value2 := '' : stored('Country2');
string9 ssn_value2 := ''      : stored('ssn2');
string8 dob_value2 := ''      : stored('DateOfBirth2');
unsigned1 age_value2 := 0      : stored('Age2');
STRING20 dl_number_value2 := ''     : stored('DLNumber2');
STRING2 dl_state_value2 := ''       : stored('DLState2');
string100 email_value2 := ''  : stored('Email2');
STRING45 ip_value2 := ''      : stored('IPAddress2');
string10 phone_value2 := ''   : stored('HomePhone2');
STRING10 wphone_value2 := ''  : stored('WorkPhone2');
STRING100 employe_name_value2 := ''   : stored('EmployerName2');
STRING30 prev_lname_value2 := ''      : stored('FormerName2');
unsigned1 DPPA_Purpose := 0 			: stored('DPPAPurpose');
unsigned1 GLB_Purpose := AutoStandardI.Constants.GLBPurpose_default 						: stored('GLBPurpose');
string DataRestriction := risk_indicators.iid_constants.default_DataRestriction : stored('DataRestrictionMask');
string DataPermission := Risk_Indicators.iid_constants.default_DataPermission 	: stored('DataPermissionMask');
unsigned1 version := 255					: stored('BSVersion');	// version 1 is the original, 2 would add BS 2 fields and 3 will add BS 3 fields
STRING5   industry_class_val := '': STORED('IndustryClass');
unsigned3 history_date := 999999	: stored('HistoryDateYYYYMM');
string20	historyDateTimeStamp := '' : stored('historyDateTimeStamp');  // new for shell 5.0
boolean   doScore := false				: stored('IncludeScore');	// allow user to turn on RV and FD scores for realtime runs
boolean   RetainInputDID := false				: stored('RetainInputDID');	
real global_watchlist_threshold := 0.84 			: stored('GlobalWatchlistThreshold');
unsigned1 ofac_version      := 1        : stored('OFACVersion');
boolean   include_ofac       := false    : stored('IncludeOfac');
boolean   include_additional_watchlists  := false    : stored('IncludeAdditionalWatchLists');
/* Gateways */
string20 DeviceProvider1_value := ''			          : stored('DeviceProvider1');
string20  DeviceProvider2_value := ''       				  : stored('DeviceProvider2');
string20  DeviceProvider3_value := ''          	: stored('DeviceProvider3');
string20 DeviceProvider4_value := ''       	: stored('DeviceProvider4');	
string TypeOfOrder_value := risk_indicators.iid_constants.PhysicalOrder : stored('TypeOfOrder');


boolean   isUtility := StringLib.StringToUpperCase(industry_class_val) = 'UTILI';
gateways_in := Gateway.Configuration.Get();

Gateway.Layouts.Config gw_switch(gateways_in le) := transform
	self.servicename := le.servicename;
	self.url := map(Gateway.Configuration.IsNetAcuity(le.servicename) or le.servicename='veris' => le.url,
                  version >= 50 and stringlib.StringToLowerCase(trim(le.servicename)) in [Gateway.Constants.ServiceName.DeltaInquiry] => le.url, //netacuity will be the only gateway we use in the bocashell processing, default to no gateway call
                  le.servicename = 'bridgerwlc' => le.url, // included bridger gateway to be able to hit OFAC v4
                  '');
	self := le;
end;

gateways := project(gateways_in, gw_switch(left));

rec := record
  unsigned4 seq;
  end;
d := dataset([{(unsigned)account_value}],rec);

risk_indicators.Layout_CIID_BtSt_In into_btst_in(d le) := transform
  clean_a := Risk_Indicators.MOD_AddressClean.clean_addr(addr1_val, city_val, state_val, zip_value);	
	dl_num_clean := riskwise.cleanDL_num(dl_number_value);
	
	self.Bill_To_In.seq := le.seq;
	
	self.Bill_To_In.historydate := if(historyDateTimeStamp<>'',(unsigned)historyDateTimeStamp[1..6], history_date);
	self.Bill_To_In.historyDateTimeStamp := risk_indicators.iid_constants.mygetdateTimeStamp(historydateTimeStamp, history_date);
	
	self.Bill_To_In.fname := stringlib.stringtouppercase(fname_val);
	self.Bill_To_In.mname := stringlib.stringtouppercase(mname_val);
	self.Bill_To_In.lname := stringlib.stringtouppercase(lname_val);
	self.Bill_To_In.suffix := stringlib.stringtouppercase(suffix_val);
	self.Bill_To_In.in_streetAddress := stringlib.stringtouppercase(addr1_val);
	self.Bill_To_In.in_city := stringlib.stringtouppercase(city_val);
	self.Bill_To_In.in_state := stringlib.stringtouppercase(state_val);
	self.Bill_To_In.in_zipCode := zip_value;
	self.Bill_To_In.prim_range := clean_a[1..10];
	self.Bill_To_In.predir := clean_a[11..12];
	self.Bill_To_In.prim_name := clean_a[13..40];
	self.Bill_To_In.addr_suffix := clean_a[41..44];
	self.Bill_To_In.postdir := clean_a[45..46];
	self.Bill_To_In.unit_desig := clean_a[47..56];
	self.Bill_To_In.sec_range := clean_a[57..65];
	self.Bill_To_In.p_city_name := clean_a[90..114];
	self.Bill_To_In.st := clean_a[115..116];
	self.Bill_To_In.z5 := clean_a[117..121];
	self.Bill_To_In.zip4 := clean_a[122..125];
	self.Bill_To_In.lat := clean_a[146..155];
	self.Bill_To_In.long := clean_a[156..166];
	self.Bill_To_In.addr_type := clean_a[139];
	self.Bill_To_In.addr_status := clean_a[179..182];
	self.Bill_To_In.county := clean_a[143..145];
	self.Bill_To_In.geo_blk := clean_a[171..177];
	self.Bill_To_In.ssn		:= ssn_value;
	self.Bill_To_In.dob		:= dob_value;
				Temp_age := if (age_value = 0 and (integer)dob_value != 0, 
														(STRING)ut.GetAgeI_asOf((unsigned)dob_value, (unsigned)risk_indicators.iid_constants.myGetDate(history_date)), 
														(STRING)age_value);
	self.Bill_To_In.age := if((integer)temp_age > 99, '99',temp_age);
	self.Bill_To_In.dl_number := stringlib.stringtouppercase(dl_num_clean);
	self.Bill_To_In.dl_state := stringlib.stringtouppercase(dl_state_value);
	self.Bill_To_In.email_address	:= stringlib.stringtouppercase(email_value);
	SELF.Bill_To_In.ip_address := ip_value;
	self.Bill_To_In.phone10 := phone_value;
	self.Bill_To_In.wphone10 := wphone_value;
	self.Bill_To_In.employer_name := stringlib.stringtouppercase(employe_name_value);		
	SELF.Bill_To_In.lname_prev := stringlib.stringtouppercase(prev_lname_value);
	self.bill_to_in.TypeOfOrder := stringlib.stringtouppercase(TypeOfOrder_value);	

  clean_a2 := Risk_Indicators.MOD_AddressClean.clean_addr(addr1_val2, city_val2, state_val2, zip_value2);	
	dl_num_clean2 := riskwise.cleanDL_num(dl_number_value2);
	
	self.Ship_To_In.seq := le.seq;
	
	self.Ship_To_In.historydate := if(historyDateTimeStamp<>'',(unsigned)historyDateTimeStamp[1..6], history_date);
	self.Ship_To_In.historyDateTimeStamp := risk_indicators.iid_constants.mygetdateTimeStamp(historydateTimeStamp, history_date);
	
	self.Ship_To_In.fname := stringlib.stringtouppercase(fname_val2);
	self.Ship_To_In.mname := stringlib.stringtouppercase(mname_val2);
	self.Ship_To_In.lname := stringlib.stringtouppercase(lname_val2);
	self.Ship_To_In.suffix := stringlib.stringtouppercase(suffix_val2);
	self.Ship_To_In.in_streetAddress := stringlib.stringtouppercase(addr1_val2);
	self.Ship_To_In.in_city := stringlib.stringtouppercase(city_val2);
	self.Ship_To_In.in_state := stringlib.stringtouppercase(state_val2);
	self.Ship_To_In.in_zipCode := zip_value2;
	self.Ship_To_In.prim_range := clean_a2[1..10];
	self.Ship_To_In.predir := clean_a2[11..12];
	self.Ship_To_In.prim_name := clean_a2[13..40];
	self.Ship_To_In.addr_suffix := clean_a2[41..44];
	self.Ship_To_In.postdir := clean_a2[45..46];
	self.Ship_To_In.unit_desig := clean_a2[47..56];
	self.Ship_To_In.sec_range := clean_a2[57..65];
	self.Ship_To_In.p_city_name := clean_a2[90..114];
	self.Ship_To_In.st := clean_a2[115..116];
	self.Ship_To_In.z5 := clean_a2[117..121];
	self.Ship_To_In.zip4 := clean_a2[122..125];
	self.Ship_To_In.lat := clean_a2[146..155];
	self.Ship_To_In.long := clean_a2[156..166];
	self.Ship_To_In.addr_type := clean_a2[139];
	self.Ship_To_In.addr_status := clean_a2[179..182];
	self.Ship_To_In.county := clean_a2[143..145];
	self.Ship_To_In.geo_blk := clean_a2[171..177];
	self.Ship_To_In.ssn		:= ssn_value2;
	self.Ship_To_In.dob		:= dob_value2;
	
	Temp_age2 :=  if (age_value2 = 0 and (integer)dob_value2 != 0, 
														(STRING)ut.GetAgeI_asOf((unsigned)dob_value2, (unsigned)risk_indicators.iid_constants.myGetDate(history_date)), 
														(STRING)age_value2);
						
	self.Ship_To_In.age := if((integer)temp_age2 > 99, '99',temp_age2);
	self.Ship_To_In.dl_number := stringlib.stringtouppercase(dl_num_clean2);
	self.Ship_To_In.dl_state := stringlib.stringtouppercase(dl_state_value2);
	self.Ship_To_In.email_address	:= stringlib.stringtouppercase(email_value2);
	self.Ship_To_In.ip_address := ip_value2;
	self.Ship_To_In.phone10 := phone_value2;
	self.Ship_To_In.wphone10 := wphone_value2;
	self.Ship_To_In.employer_name := stringlib.stringtouppercase(employe_name_value2);		
	self.Ship_To_In.lname_prev := stringlib.stringtouppercase(prev_lname_value2);
	
	self := [];
end;

prep := project(d,into_btst_in(LEFT));

// added as part of bsversion 4.1 (fraudpointmode)
FraudPointMode := if(version>=41, true, false);	// hardcode this to true so that fraud attributes are run correctly
doScore_again := if(version>=51, true, doScore); //want to run so get FDN fields back for CBDd 5.0
useNetAcuity_v4:= True;

IncludeDLverification := if(FraudPointMode, true, false);
unsigned8 BSOptions := 
if(FraudPointMode, 
	risk_indicators.iid_constants.BSOptions.IncludeDoNotMail +
	risk_indicators.iid_constants.BSOptions.IncludeFraudVelocity,
	0) +
if(RetainInputDID, risk_indicators.iid_constants.BSOptions.RetainInputDID, 0) +
if(version >= 50, risk_indicators.iid_constants.BSOptions.IncludeHHIDSummary, 0);

ln_branded := false;
ofac_only := true;
suppressNearDups := true;
require2elements := false;
from_BIID := false;
isFCRA := false;
excludeWatchlists := false;
from_IT1O := false;
//ofac_version := 1;
//include_ofac := false;
//include_additional_watchlists := false;
//global_watchlist_threshold := .84;
dob_radius := -1;

includeRelativeInfo := true;
includeDLInfo := true;
includeVehicleInfo := true;
includeDerogInfo := true;

iid_results := risk_indicators.InstantId_BtSt_Function(prep, gateways, DPPA_Purpose, GLB_Purpose, 
											isUtility, ln_branded, ofac_only, suppressNearDups, require2elements, 
											from_BIID, isFCRA,	excludeWatchlists, from_IT1O, ofac_version, include_ofac, include_additional_watchlists, 
											global_watchlist_threshold, dob_radius, version, DataRestriction := DataRestriction, 
                      runDLverification:=IncludeDLverification, DataPermission := DataPermission,
                      BSOptions:=BSOptions
                      );
//defaulting to emtpy on this dataset as it's only used in CBD models
ScoresInput := project(prep, transform(Risk_Indicators.Layout_BocaShell_BtSt.input_Scores,
	self.DeviceProvider1_value := DeviceProvider1_value;
	self.DeviceProvider2_value := DeviceProvider2_value;
	self.DeviceProvider3_value := DeviceProvider3_value;
	self.DeviceProvider4_value := DeviceProvider4_value;
	self.btst_order_type := stringlib.stringtouppercase(TypeOfOrder_value);
	self.seq := left.bill_to_in.seq));

ret := risk_indicators.BocaShell_BtSt_Function(iid_results, gateways, DPPA_Purpose, GLB_Purpose, isUtility,
											ln_branded, includeRelativeInfo, includeDLInfo, includeVehicleInfo, includeDerogInfo, version, 
											doScore_again, nugen := true, DataRestriction := DataRestriction, inBSOptions:=BSOptions, 
											DataPermission := DataPermission, input_Scores := ScoresInput, NetAcuity_v4 := useNetAcuity_v4);
											
output(ret,NAMED('Results'));

dIPIn := PROJECT(prep,TRANSFORM(Royalty.RoyaltyNetAcuity.IPData,SELF.IPAddr:=LEFT.Bill_To_In.ip_address;));
dIPOut := PROJECT(ret, TRANSFORM(Royalty.RoyaltyNetAcuity.IPData, SELF.IPAddr := LEFT.ip2o.ipaddr; SELF.IPType := LEFT.ip2o.iptype; SELF := [];));
royalties := Royalty.RoyaltyNetAcuity.GetOnlineRoyalties(gateways, dIPIn, dIPOut);
output(royalties,NAMED('RoyaltySet'));

ENDMACRO;
