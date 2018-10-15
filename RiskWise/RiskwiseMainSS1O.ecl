/*--SOAP--
<message name="SureSale">
	<part name="tribcode" type="xsd:string"/>
	<part name="account" type="xsd:string"/>
	<part name="first" type="xsd:string"/>
	<part name="last" type="xsd:string"/>
	<part name="cmpy" type="xsd:string"/>
	<part name="addr" type="xsd:string"/>
	<part name="city" type="xsd:string"/>
	<part name="state" type="xsd:string"/>
	<part name="zip" type="xsd:string"/>
	<part name="socs" type="xsd:string"/>
	<part name="dob" type="xsd:string"/>
	<part name="hphone" type="xsd:string"/>
	<part name="wphone" type="xsd:string"/>
	<part name="drlc" type="xsd:string"/>
	<part name="drlcstate" type="xsd:string"/>
	<part name="first2" type="xsd:string"/>
	<part name="last2" type="xsd:string"/>
	<part name="cmpy2" type="xsd:string"/>
	<part name="addr2" type="xsd:string"/>
	<part name="city2" type="xsd:string"/>
	<part name="state2" type="xsd:string"/>
	<part name="zip2" type="xsd:string"/>
	<part name="phone2" type="xsd:string"/>
	<part name="internetcommflag" type="xsd:string"/>
	<part name="emailaddr" type="xsd:string"/>
	<part name="emailheader" type="xsd:string"/>
	<part name="ipaddr" type="xsd:string"/>
	<part name="purchamt" type="xsd:string"/>
	<part name="purchitems" type="xsd:string"/>
	<part name="prodcat" type="xsd:string"/>
	<part name="purchdate" type="xsd:string"/>
	<part name="purchtime" type="xsd:string"/>
	<part name="checkaba" type="xsd:string"/>
	<part name="checkacct" type="xsd:string"/>
	<part name="checknum" type="xsd:string"/>
	<part name="bankname" type="xsd:string"/>
	<part name="pymtmethod" type="xsd:string"/>
	<part name="cctype" type="xsd:string"/>
	<part name="ccnum" type="xsd:string"/>
	<part name="ccexpdate" type="xsd:string"/>
	<part name="buysellid" type="xsd:string"/>
	<part name="DPPAPurpose" type="xsd:byte"/>
	<part name="GLBPurpose" type="xsd:byte"/>
	<part name="OFACversion" type="xsd:unsignedInt"/>
	<part name="gateways" type="tns:XmlDataSet" cols="70" rows="25"/> 
	<part name="DataRestrictionMask" type="xsd:string"/>
	<part name="DataPermissionMask" type="xsd:string"/>
	<part name="HistoryDateYYYYMM" type="xsd:integer"/>
	<part name="OutcomeTrackingOptOut" type="xsd:boolean"/>
 </message>
*/
/*--INFO-- Migrating ss02, fds7, and fdsl to boca.  */
import gateway;

export RiskwiseMainSS1O := macro

// Can't have duplicate definitions of Stored with different default values, 
// so add the default to #stored to eliminate the assignment of a default value.
#stored('GLBPurpose',RiskWise.permittedUse.fraudGLBA);
#stored('DataRestrictionMask',risk_indicators.iid_constants.default_DataRestriction);

/* Force layout of WsECL page */
#WEBSERVICE(FIELDS(
	'tribcode',
	'account',
	'first',
	'last',
	'cmpy',
	'addr',
	'city',
	'state',
	'zip',
	'socs',
	'dob',
	'hphone',
	'wphone',
	'drlc',
	'drlcstate',
	'first2',
	'last2',
	'cmpy2',
	'addr2',
	'city2',
	'state2',
	'zip2',
	'phone2',
	'internetcommflag',
	'emailaddr',
	'emailheader',
	'ipaddr',
	'purchamt',
	'purchitems',
	'prodcat',
	'purchdate',
	'purchtime',
	'checkaba',
	'checkacct',
	'checknum',
	'bankname',
	'pymtmethod',
	'cctype',
	'ccnum',
	'ccexpdate',
	'buysellid',
	'DPPAPurpose',
	'GLBPurpose', 
  'OFACversion',
  'gateways',
	'DataRestrictionMask',
	'DataPermissionMask',
	'HistoryDateYYYYMM',
	'OutcomeTrackingOptOut'));

/* **********************************************
   *  Fields needed for improved Scout Logging  *
   **********************************************/
	string32 _LoginID           := ''	: STORED('_LoginID');
	string20 CompanyID          := '' : STORED('_CompanyID');
	string20 FunctionName       := '' : STORED('_LogFunctionName');
	string50 ESPMethod          := '' : STORED('_ESPMethodName');
	string10 InterfaceVersion   := '' : STORED('_ESPClientInterfaceVersion');
	string10 ssnmask            := '' : STORED('SSNMask');
	string10 dobmask            := '' : STORED('DOBMask');
	string1 dlmask              := '' : STORED('DLMask');
	string5 DeliveryMethod      := '' : STORED('_DeliveryMethod');
	string5 DeathMasterPurpose  := '' : STORED('__deathmasterpurpose');
	string1 ExcludeDMVPII       := '' : STORED('ExcludeDMVPII');
	BOOLEAN DisableOutcomeTracking := FALSE : STORED('OutcomeTrackingOptOut');
	string1 ArchiveOptIn        := '' : STORED('instantidarchivingoptin');

	//Look up the industry by the company ID.
	Industry_Search := Inquiry_AccLogs.Key_Inquiry_industry_use_vertical_login(FALSE)(s_company_id = CompanyID and s_product_id = (String)Risk_Reporting.ProductID.RiskWise__RiskWiseMainSS1O);
/* ************* End Scout Fields **************/

string4  tribCode_value := '' 		: stored('tribcode');	
string30 account_value := '' 			: stored('account');
string15 first_value := '' 			: stored('first');
string20 last_value := '' 			: stored('last');
string30 cmpy_value := '' 			: stored('cmpy');
string50 addr_value := '' 			: stored('addr');
string30 city_value := '' 			: stored('city');
string2  state_value := '' 			: stored('state');
string5  zip_value := '' 			: stored('zip');
string9  socs_value := '' 			: stored('socs');
string8  dob_value := '' 			: stored('dob');
string10 hphone_value := '' 			: stored('hphone');
string10 wphone_value := '' 			: stored('wphone');
string20 drlc_value := '' 			: stored('drlc');
string2  drlcstate_value := '' 		: stored('drlcstate');
string15 first2_value := '' 			: stored('first2');
string20 last2_value := '' 			: stored('last2');
string30 cmpy2_value := '' 			: stored('cmpy2');
string50 addr2_value := '' 			: stored('addr2');
string30 city2_value := '' 			: stored('city2');
string2  state2_value := '' 			: stored('state2');
string5  zip2_value := '' 			: stored('zip2');
string10 phone2_value := '' 			: stored('phone2');
string1  internetcommflag_value := '' 	: stored('internetcommflag');
string50 emailaddr_value := '' 		: stored('emailaddr');
string50 emailheader_value := '' 		: stored('emailheader');
string45 ipaddr_value := '' 			: stored('ipaddr');
string6  purchamt_value := '' 		: stored('purchamt');
string4  purchitems_value := '' 		: stored('purchitems');
string2  prodcat_value := '' 			: stored('prodcat');
string8  purchdate_value := '' 		: stored('purchdate');
string6  purchtime_value := '' 		: stored('purchtime');
string11 checkaba_value := '' 		: stored('checkaba');
string9  checkacct_value := '' 		: stored('checkacct');
string7  checknum_value := '' 		: stored('checknum');
string40 bankname_value := '' 		: stored('bankname');
string2  pymtmethod_value := '' 		: stored('pymtmethod');
string1  cctype_value := '' 			: stored('cctype');
string16 ccnum_value := '' 			: stored('ccnum');
string8  ccexpdate_value := '' 		: stored('ccexpdate');
string1  buysellid_value := '' 		: stored('buysellid');
string DataRestriction := risk_indicators.iid_constants.default_DataRestriction : stored('DataRestrictionMask');
string50 DataPermission := Risk_Indicators.iid_constants.default_DataPermission : stored('DataPermissionMask');
unsigned1 DPPA_Purpose := RiskWise.permittedUse.fraudDPPA : stored('DPPAPurpose');
unsigned1 GLB_Purpose := RiskWise.permittedUse.fraudGLBA : stored('GLBPurpose');
unsigned3 history_date := 999999 : stored('HistoryDateYYYYMM');
boolean isUtility := false;
boolean ln_branded := false;
boolean ofac_only := true;
unsigned1 ofac_version      := 1        : stored('OFACVersion');
boolean suppressNearDups := true;
boolean require2Ele := true;
gateways_in := Gateway.Configuration.Get();

tribcode := StringLib.StringToLowerCase(tribCode_value);
boolean Log_trib := tribCode in ['ss02'];

Gateway.Layouts.Config gw_switch(gateways_in le) := transform
	self.servicename := if(ofac_version = 4 and tribcode = 'fds7' and le.servicename = 'bridgerwlc', le.servicename, '');
	self.url := if(ofac_version = 4 and tribcode = 'fds7' and le.servicename = 'bridgerwlc', le.url, ''); 		
	self := le;
end;
gateways := project(gateways_in, gw_switch(left));

if(ofac_version = 4 and not exists(gateways(servicename = 'bridgerwlc')) , fail(Risk_Indicators.iid_constants.OFAC4_NoGateway));

include_ofac := if(ofac_version = 1, false, true);
global_watchlist_threshold := if(ofac_version in [1, 2, 3], 0.84, 0.85);

d := dataset([{0}],RiskWise.Layout_SS1I);

RiskWise.Layout_SS1I addseq(d l, integer C) := transform
	self.seq := C;
	self.tribcode := StringLib.StringToLowerCase(tribCode_value);
	self.account := account_value;
	self.first := first_value;
	self.last := last_value;
	self.cmpy := cmpy_value;
	self.addr := addr_value;
	self.city := city_value;
	self.state := state_value;
	self.zip := zip_value;
	self.socs := socs_value;
	self.dob := dob_value;
	self.hphone := hphone_value;
	self.wphone := wphone_value;
	self.drlc := drlc_value;
	self.drlcstate := drlcstate_value;
	self.first2 := first2_value;
	self.last2 := last2_value;
	self.cmpy2 := cmpy2_value;
	self.addr2 := addr2_value;
	self.city2 := city2_value;
	self.state2 := state2_value;
	self.zip2 := zip2_value;
	self.phone2 := phone2_value;
	self.internetcommflag := internetcommflag_value;
	self.emailaddr := emailaddr_value;
	self.emailheader := emailheader_value;
	self.ipaddr := ipaddr_value;
	self.purchamt := purchamt_value;
	self.purchitems := purchitems_value;
	self.prodcat := prodcat_value;
	self.purchdate := purchdate_value;
	self.purchtime := purchtime_value;
	self.checkaba := checkaba_value;
	self.checkacct := checkacct_value;
	self.checknum := checknum_value;
	self.bankname := bankname_value;
	self.pymtmethod := pymtmethod_value;
	self.cctype := cctype_value;
	self.ccnum := ccnum_value;
	self.ccexpdate := ccexpdate_value;
	self.buysellid := buysellid_value;
	self.historydate := history_date;
end;
f := project(d, addseq(LEFT,COUNTER));

ret := if(tribcode in ['ss02', 'fdsl', 'fds7'], 
RiskWise.SS1O_Function(f, gateways, GLB_Purpose, DPPA_Purpose,DataRestriction:=datarestriction,DataPermission:=DataPermission, ofac_version := ofac_version, include_ofac := include_ofac, 
                       global_watchlist_threshold := global_watchlist_threshold), 
																   dataset([{account_value}], riskwise.Layout_SS1O));

//Log to Deltabase
Deltabase_Logging_prep := project(ret, transform(Risk_Reporting.Layouts.LOG_Deltabase_Layout_Record,
																								 self.company_id := (Integer)CompanyID,
																								 self.login_id := _LoginID,
																								 self.product_id := Risk_Reporting.ProductID.RiskWise__RiskWiseMainSS1O,
																								 self.function_name := FunctionName,
																								 self.esp_method := ESPMethod,
																								 self.interface_version := InterfaceVersion,
																								 self.delivery_method := DeliveryMethod,
																								 self.date_added := (STRING8)Std.Date.Today(),
																								 self.death_master_purpose := DeathMasterPurpose,
																								 self.ssn_mask := ssnmask,
																								 self.dob_mask := dobmask,
																								 self.dl_mask := dlmask,
																								 self.exclude_dmv_pii := ExcludeDMVPII,
																								 self.scout_opt_out := (String)(Integer)DisableOutcomeTracking,
																								 self.archive_opt_in := ArchiveOptIn,
                                                 self.glb := GLB_Purpose,
                                                 self.dppa := DPPA_Purpose,
																								 self.data_restriction_mask := DataRestriction,
																								 self.data_permission_mask := DataPermission,
																								 self.industry := Industry_Search[1].Industry,
																								 self.i_ssn := socs_value,
                                                 self.i_dob := dob_value,
																								 self.i_name_first := first_value,
																								 self.i_name_last := last_value,
																								 self.i_address := addr_value,
																								 self.i_city := city_value,
																								 self.i_state := state_value,
																								 self.i_zip := zip_value,
																								 self.i_dl := drlc_value,
																								 self.i_dl_state := drlcstate_value,
                                                 self.i_home_phone := hphone_value,
                                                 self.i_work_phone := wphone_value,
																								 self.i_name_first_2 := first2_value,
																								 self.i_name_last_2 := last2_value,
																								 self.i_bus_name := cmpy_value,
																								 self.o_score_1    := left.score,
																								 self.o_reason_1_1 := left.reason,
																								 self.o_reason_1_2 := left.reason2,
																								 self.o_reason_1_3 := left.reason3,
																								 self.o_reason_1_4 := left.reason4,
																								 self.o_score_2    := left.score2,
																								 self.o_lexid := (Integer)left.riskwiseid,  //did
																								 self := left,
																								 self := [] ));
Deltabase_Logging := DATASET([{Deltabase_Logging_prep}], Risk_Reporting.Layouts.LOG_Deltabase_Layout);
// #stored('Deltabase_Log', Deltabase_Logging);

//Improved Scout Logging
IF(~DisableOutcomeTracking and Log_trib, OUTPUT(Deltabase_Logging, NAMED('LOG_log__mbs_transaction__log__scout')));

output(ret, named('Results'));

ENDMACRO;