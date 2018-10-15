/*--SOAP--
<message name="St. Cloud Main Service SC1O">
	<part name="tribcode" type="xsd:string"/>
	<part name="account" type="xsd:string"/>
	<part name="apptypeflag" type="xsd:string"/>
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
	<part name="email" type="xsd:string"/>
	<part name="apptypeflag2" type="xsd:string"/>
	<part name="first2" type="xsd:string"/>
	<part name="last2" type="xsd:string"/>
	<part name="cmpy2" type="xsd:string"/>
	<part name="addr2" type="xsd:string"/>
	<part name="city2" type="xsd:string"/>
	<part name="state2" type="xsd:string"/>
	<part name="zip2" type="xsd:string"/>
	<part name="socs2" type="xsd:string"/>
	<part name="dob2" type="xsd:string"/>
	<part name="hphone2" type="xsd:string"/>
	<part name="wphone2" type="xsd:string"/>
	<part name="drlc2" type="xsd:string"/>
	<part name="drlcstate2" type="xsd:string"/>
	<part name="email2" type="xsd:string"/>
	<part name="saleamt" type="xsd:string"/>
	<part name="purchdate" type="xsd:string"/>
	<part name="purchtime" type="xsd:string"/>
	<part name="checkaba" type="xsd:string"/>
	<part name="checkacct" type="xsd:string"/>
	<part name="checknum" type="xsd:string"/>
	<part name="bankname" type="xsd:string"/>
	<part name="pymtmethod" type="xsd:string"/>
	<part name="cctype" type="xsd:string"/>
	<part name="avscode" type="xsd:string"/>
	<part name="inquiries" type="xsd:string"/>
	<part name="trades" type="xsd:string"/>
	<part name="balance" type="xsd:string"/>
	<part name="bankbalance" type="xsd:string"/>
	<part name="highcredit" type="xsd:string"/>
	<part name="delinquent90plus" type="xsd:string"/>
	<part name="numrevolvingtrades" type="xsd:string"/>
	<part name="autotrades" type="xsd:string"/>
	<part name="autotradesopen" type="xsd:string"/>
	<part name="income" type="xsd:string"/>
	<part name="income2" type="xsd:string"/>
	<part name="ipaddr" type="xsd:string"/>
	<part name="ccnum" type="xsd:string"/>
	<part name="ccexpdate" type="xsd:string"/>
	<part name="reserved" type="xsd:string"/>
	<part name="DPPAPurpose" type="xsd:byte"/>
	<part name="GLBPurpose" type="xsd:byte"/>
	<part name="DataRestrictionMask" type="xsd:string"/>
	<part name="DataPermissionMask" type="xsd:string"/>
	<part name="HistoryDateYYYYMM" type="xsd:integer"/>
	<part name="runSeed" type="xsd:boolean"/>
	<part name="OFACversion" type="xsd:unsignedInt"/>
	<part name="gateways" type="tns:XmlDataSet" cols="70" rows="25"/>
	<part name="OutcomeTrackingOptOut" type="xsd:boolean"/>
 </message>
*/
/*--INFO-- 'ex01','ex04','ex05','ex11','ex12','ex39','ex40','ex90','ex91','ex94','ex95','sc51','2x01' */

import Risk_Indicators, gateway, Inquiry_AccLogs, Risk_Reporting, STD;

export RiskWiseMainSC1O := MACRO

// Can't have duplicate definitions of Stored with different default values, 
// so add the default to #stored to eliminate the assignment of a default value.
#stored('GLBPurpose',RiskWise.permittedUse.fraudGLBA);
#stored('DataRestrictionMask',risk_indicators.iid_constants.default_DataRestriction);

/* Force layout of WsECL page */
#WEBSERVICE(FIELDS(
	'tribcode',
	'account',
	'apptypeflag',
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
	'email',
	'apptypeflag2',
	'first2',
	'last2',
	'cmpy2',
	'addr2',
	'city2',
	'state2',
	'zip2',
	'socs2',
	'dob2',
	'hphone2',
	'wphone2',
	'drlc2',
	'drlcstate2',
	'email2',
	'saleamt',
	'purchdate',
	'purchtime',
	'checkaba',
	'checkacct',
	'checknum',
	'bankname',
	'pymtmethod',
	'cctype',
	'avscode',
	'inquiries',
	'trades',
	'balance',
	'bankbalance',
	'highcredit',
	'delinquent90plus',
	'numrevolvingtrades',
	'autotrades',
	'autotradesopen',
	'income',
	'income2',
	'ipaddr',
	'ccnum',
	'ccexpdate',
	'reserved',
	'DPPAPurpose',
	'GLBPurpose',
	'DataRestrictionMask',
	'DataPermissionMask',
	'HistoryDateYYYYMM',
	'runSeed',
	'OFACversion',
	'gateways',
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
	Industry_Search := Inquiry_AccLogs.Key_Inquiry_industry_use_vertical_login(FALSE)(s_company_id = CompanyID and s_product_id = (String)Risk_Reporting.ProductID.RiskWise__RiskWiseMainSC1O);
/* ************* End Scout Fields **************/

string4   tribCode_value := '' 			: stored('tribcode');
string30  account_value := ''  			: stored('account');
string1   apptypeflag_value := ''			: stored('apptypeflag');
string15  first_value := ''    			: stored('first');
string20  last_value := ''     			: stored('last');
string30  cmpy_value := ''     			: stored('cmpy');
string50  addr_value := ''     			: stored('addr');
string30  city_value := ''     			: stored('city');
string2   state_value := ''    			: stored('state');
string9   zip_value := ''      			: stored('zip');
string9   socs_value := ''     			: stored('socs');
string8   dob_value := ''      			: stored('dob');
string10  hphone_value := ''   			: stored('hphone');
string10  wphone_value := ''   			: stored('wphone');
string20  drlc_value := ''     			: stored('drlc');
string2   drlcstate_value := ''			: stored('drlcstate');
string50  email_value := ''    			: stored('email');

// SECOND INPUT
string1   apptypeflag2_value := ''			: stored('apptypeflag2');
string15  first2_value := ''     			: stored('first2');
string20  last2_value := ''     			: stored('last2');
string30  cmpy2_value := ''   			: stored('cmpy2');
string50  addr2_value := ''    			: stored('addr2');
string30  city2_value := ''      			: stored('city2');
string2   state2_value := ''      			: stored('state2');
string9   zip2_value := ''      			: stored('zip2');
string9   socs2_value := ''      			: stored('socs2');
string8   dob2_value := ''      			: stored('dob2');
string10  hphone2_value := ''   			: stored('hphone2');
string10  wphone2_value := ''  			: stored('wphone2');
string20  drlc2_value := ''     			: stored('drlc2');
string2   drlcstate2_value := ''   		: stored('drlcstate2');
string50  email2_value := ''  			: stored('email2');

string6   saleamt_value := ''    			: stored('saleamt');
string8   purchdate_value := ''   			: stored('purchdate');
string6   purchtime_value := ''    		: stored('purchtime');
string11  checkaba_value := ''    			: stored('checkaba');
string9   checkacct_value := ''    		: stored('checkacct');
string7   checknum_value := ''    			: stored('checknum');
string40  bankname_value := ''    			: stored('bankname');
string2   pymtmethod_value := ''   		: stored('pymtmethod');
string1   cctype_value := ''    			: stored('cctype');
string2   avscode_value := ''    			: stored('avscode');
string2   inquiries_value := ''    		: stored('inquiries');
string3   trades_value := ''    			: stored('trades');
string6   balance_value := ''    			: stored('balance');
string6   bankbalance_value := ''  		: stored('bankbalance');
string6   highcredit_value := ''   		: stored('highcredit');
string3   delinquent90plus_value := ''    	: stored('delinquent90plus');
string2   numrevolvingtrades_value := ''  	: stored('numrevolvingtrades');
string2   autotrades_value := ''   		: stored('autotrades');
string2   autotradesopen_value := ''      	: stored('autotradesopen');
string6   income_value := ''    			: stored('income');
string6   income2_value := ''    			: stored('income2');
string45  ipaddr_value := ''    			: stored('ipaddr');
string16  ccnum_value := ''    			: stored('ccnum');
string8   ccexpdate_value := ''    		: stored('ccedpdate');
string53  reserved_value := ''    			: stored('reserved');
string DataRestriction := risk_indicators.iid_constants.default_DataRestriction : stored('DataRestrictionMask');
string DataPermission  := Risk_Indicators.iid_constants.default_DataPermission : stored('DataPermissionMask');
unsigned1 DPPA_Purpose := RiskWise.permittedUse.fraudDPPA : stored('DPPAPurpose');
unsigned1 GLB_Purpose := RiskWise.permittedUse.fraudGLBA : stored('GLBPurpose');
unsigned3 history_date := 999999  			: stored('HistoryDateYYYYMM');
boolean   runSeed_value := false 			: stored('runSeed');
unsigned1 ofac_version_      := 1        : stored('OFACVersion');
gateways_in := Gateway.Configuration.Get();

productSet := ['ex01','ex04','ex05','ex11','ex12','ex39','ex40','ex90','ex91','ex94','ex95','sc51','2x01'];
			
tribCode := StringLib.StringToLowerCase(tribCode_value);
boolean Log_trib := tribCode in ['2x01', 'ex01', 'ex11', 'ex12', 'ex90', 'sc63'];

targusGatewaySet := ['ex05'];

ofac_version := ofac_version_;
include_ofac := if(ofac_version = 1, false, true);
include_additional_watchlists := false;
global_watchlist_threshold := if(ofac_version in [1, 2, 3], 0.84, 0.85);

Gateway.Layouts.Config gw_switch(gateways_in le) := TRANSFORM
	self.servicename := le.servicename;
	self.url := map(tribcode in targusGatewaySet and le.servicename = 'targus' => le.url, // targus gateway
  	              tribcode in ['ex01','ex04','ex05','ex11','ex12','ex39','ex40','ex90','ex91','ex94','ex95','2x01'] and le.servicename = 'bridgerwlc' => le.url, // included bridger gateway to be able to hit OFAC v4
                  ''); // default to no gateway call
	self := le;
END;
gateways := project(gateways_in, gw_switch(left));

if( ofac_version = 4 and not exists(gateways(servicename = 'bridgerwlc')) , fail(Risk_Indicators.iid_constants.OFAC4_NoGateway));

d := dataset([{0}],RiskWise.Layout_SD1I);

RiskWise.Layout_SD1I addseq(d le, INTEGER C) := TRANSFORM
	self.seq := C;
	self.tribcode := tribCode;
	self.account := account_value;
	self.apptypeflag := apptypeflag_value;
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
	self.email := email_value;
	self.apptypeflag2 := apptypeflag2_value;
	self.first2 := first2_value;
	self.last2 := last2_value;
	self.cmpy2 := cmpy2_value;
	self.addr2 := addr2_value;
	self.city2 := city2_value;
	self.state2 := state2_value;
	self.zip2 := zip2_value;
	self.socs2 := socs2_value;
	self.dob2 := dob2_value;
	self.hphone2 := hphone2_value;
	self.wphone2 := wphone2_value;
	self.drlc2 := drlc2_value;
	self.drlcstate2 := drlcstate2_value;
	self.email2 := email2_value;
	self.saleamt := saleamt_value;
	self.purchdate := purchdate_value;
	self.purchtime := purchtime_value;
	self.checkaba := checkaba_value;
	self.checkacct := checkacct_value;
	self.checknum := checknum_value;
	self.bankname := bankname_value;
	self.pymtmethod := pymtmethod_value;
	self.cctype := cctype_value;
	self.avscode := avscode_value;
	self.inquiries := inquiries_value;
	self.trades := trades_value;
	self.balance := balance_value;
	self.bankbalance := bankbalance_value;
	self.highcredit := highcredit_value;
	self.delinquent90plus := delinquent90plus_value;
	self.numrevolvingtrades := numrevolvingtrades_value;
	self.autotrades := autotrades_value;
	self.autotradesopen := autotradesopen_value;
	self.income := income_value;
	self.income2 := income2_value;
	self.ipaddr := ipaddr_value;
	self.ccnum := ccnum_value;
	self.ccexpdate := ccexpdate_value;
	self.reserved := reserved_value;
	self.historydate := history_date;
END;
f := project(d, addseq(left,counter));


critter := map(tribcode = 'ex01' => '001',
			tribcode = 'ex04' => '004',
			tribcode = 'ex05' => '005',
			tribcode = 'ex11' => '011',
			tribcode = 'ex12' => '012',
			tribcode = 'ex40' => '040',
			tribcode = 'ex90' => '100',
			tribcode = 'ex91' => '101',
			tribcode = 'ex95' => '095',			
			tribcode = '2x01' => '201',
			'');

seed_files.mac_query_seedfiles(socs_value, 'sc1o', 'sd1i', critter, seed_out);

RiskWise.Layout_SC1O format_seed(seed_out le) := TRANSFORM
	self.account := account_value;
	self := le;
	self := [];
END;
final_seed := if(runSeed_value, project(seed_out, format_seed(left)), dataset([], RiskWise.Layout_SC1O));

almost_final := RiskWise.SC1O_Function(f, gateways, GLB_Purpose, DPPA_Purpose, tribCode, ofac_version, include_ofac, include_additional_watchlists, 
                                       global_watchlist_threshold, DataRestriction,DataPermission);
//don't track royalties for testseeds
dRoyalties := if(runSeed_value, dataset([], Royalty.Layouts.Royalty),
	Royalty.RoyaltyTargus.GetOnlineRoyalties(almost_final, src, TargusType, TRUE, FALSE, FALSE, TRUE));

final := project(almost_final, RiskWise.Layout_SC1O);

finalAnswer := if(tribCode in productSet,
			   if(count(final_seed)>0 and runSeed_value, final_seed, final), 
			   dataset([], riskwise.Layout_SC1O));
				 
//Log to Deltabase
Deltabase_Logging_prep := project(finalAnswer, transform(Risk_Reporting.Layouts.LOG_Deltabase_Layout_Record,
																								 self.company_id := (Integer)CompanyID,
																								 self.login_id := _LoginID,
																								 self.product_id := Risk_Reporting.ProductID.RiskWise__RiskWiseMainSC1O,
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
																								 self.o_reason_1_1 := left.reason11,
																								 self.o_reason_1_2 := left.reason21,
																								 self.o_reason_1_3 := left.reason31,
																								 self.o_reason_1_4 := left.reason41,
																								 self.o_score_2    := left.score3,
																								 self.o_reason_2_1 := left.reason13,
																								 self.o_reason_2_2 := left.reason23,
																								 self.o_reason_2_3 := left.reason33,
																								 self.o_reason_2_4 := left.reason43,
																								 self.o_lexid := (Integer)left.riskwiseid,  //did
																								 self := left,
																								 self := [] ));
Deltabase_Logging := DATASET([{Deltabase_Logging_prep}], Risk_Reporting.Layouts.LOG_Deltabase_Layout);
// #stored('Deltabase_Log', Deltabase_Logging);

//Improved Scout Logging
IF(~DisableOutcomeTracking and Log_trib and ~runSeed_value, OUTPUT(Deltabase_Logging, NAMED('LOG_log__mbs_transaction__log__scout')));
																   
output(finalAnswer, named('Results'));
output(dRoyalties, named('RoyaltySet'));

ENDMACRO;