/*--SOAP--
<message name="St. Cloud Main Service DLLO">
	<part name="tribcode" type="xsd:string"/>
	<part name="account" type="xsd:string"/>
	<part name="first" type="xsd:string"/>
	<part name="middleini" type="xsd:string"/>
	<part name="last" type="xsd:string"/>	
	<part name="addr" type="xsd:string"/>
	<part name="city" type="xsd:string"/>
	<part name="state" type="xsd:string"/>
	<part name="zip" type="xsd:string"/>
	<part name="hphone" type="xsd:string"/>
	<part name="socs" type="xsd:string"/>
	<part name="dob" type="xsd:string"/>
	<part name="wphone" type="xsd:string"/>
	<part name="income" type="xsd:string"/>
	<part name="drlc" type="xsd:string"/>
	<part name="drlcstate" type="xsd:string"/>
	<part name="balance" type="xsd:string"/>
	<part name="chargeoffdate" type="xsd:string"/>
	<part name="formerlast" type="xsd:string"/>
	<part name="email" type="xsd:string"/>
	<part name="cmpy" type="xsd:string"/>
	<part name="first2" type="xsd:string"/>
	<part name="middleini2" type="xsd:string"/>
	<part name="last2" type="xsd:string"/>
	<part name="addr2" type="xsd:string"/>
	<part name="city2" type="xsd:string"/>
	<part name="state2" type="xsd:string"/>
	<part name="zip2" type="xsd:string"/>
	<part name="hphone2" type="xsd:string"/>
	<part name="fin" type="xsd:string"/>
	<part name="cmpy2" type="xsd:string"/>
	<part name="score" type="xsd:string"/>
	<part name="score2" type="xsd:string"/>
	<part name="apptype" type="xsd:string"/>
	<part name="channel" type="xsd:string"/>
	<part name="orderamt" type="xsd:string"/>
	<part name="numitems" type="xsd:string"/>
	<part name="orderdate" type="xsd:string"/>
	<part name="shipmode" type="xsd:string"/>
	<part name="pymtmethod" type="xsd:string"/>
	<part name="avscode" type="xsd:string"/>
	<part name="DPPAPurpose" type="xsd:byte"/>
	<part name="GLBPurpose" type="xsd:byte"/>
	<part name="DataRestrictionMask" type="xsd:string"/>
	<part name="DataPermissionMask" type="xsd:string"/>
	<part name="HistoryDateYYYYMM" type="xsd:integer"/>
	<part name="gateways" type="tns:XmlDataSet" cols="70" rows="25"/>
	<part name="OutcomeTrackingOptOut" type="xsd:boolean"/>
 </message>
*/
/*--INFO-- 'dl01' */

      
import Risk_Indicators, Gateway;
      
	 
export RiskWiseMainDLLO := MACRO

// Can't have duplicate definitions of Stored with different default values, 
// so add the default to #stored to eliminate the assignment of a default value.
#stored('GLBPurpose',RiskWise.permittedUse.fraudGLBA);
#stored('DataRestrictionMask',risk_indicators.iid_constants.default_DataRestriction);

/* Force layout of WsECL page */
#WEBSERVICE(FIELDS(
	'tribcode',
	'account',
	'first',
	'middleini',
	'last',	
	'addr',
	'city',
	'state',
	'zip',
	'hphone',
	'socs',
	'dob',
	'wphone',
	'income',
	'drlc',
	'drlcstate',
	'balance',
	'chargeoffdate',
	'formerlast',
	'email',
	'cmpy',
	'first2',
	'middleini2',
	'last2',
	'addr2',
	'city2',
	'state2',
	'zip2',
	'hphone2',
	'fin',
	'cmpy2',
	'score',
	'score2',
	'apptype',
	'channel',
	'orderamt',
	'numitems',
	'orderdate',
	'shipmode',
	'pymtmethod',
	'avscode',
	'DPPAPurpose',
	'GLBPurpose',
	'DataRestrictionMask',
	'DataPermissionMask',
	'HistoryDateYYYYMM',
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
	Industry_Search := Inquiry_AccLogs.Key_Inquiry_industry_use_vertical_login(FALSE)(s_company_id = CompanyID and s_product_id = (String)Risk_Reporting.ProductID.RiskWise__RiskWiseMainDLLO);
/* ************* End Scout Fields **************/

string4  tribCode_value := '' 	: stored('tribcode');
string30 account_value := '' 		: stored('account');
string15 first_value := ''     	: stored('first');
string1  middleini_value := ''	: stored('middleini');
string20 last_value := ''     	: stored('last');
string50 addr_value := ''    		: stored('addr');
string30 city_value := ''      	: stored('city');
string2  state_value := ''      	: stored('state');
string9  zip_value := ''      	: stored('zip');
string10 hphone_value := ''   	: stored('hphone');
string9  socs_value := ''      	: stored('socs');	
string8  dob_value := ''      	: stored('dob');	
string10 wphone_value := ''  		: stored('wphone');
string6  income_value := ''		: stored('income');
string20 drlc_value := ''     	: stored('drlc');
string2  drlcstate_value := ''     : stored('drlcstate');
string6  balance_value := ''      	: stored('balance');	
string8  chargeoffdate_value := ''	: stored('chargeoffdate');
string20 formerlast_value := ''	: stored('formerlast');
string50 email_value := ''		: stored('email');
string30 cmpy_value := ''		: stored('cmpy');
string15 first2_value := ''     	: stored('first2');
string1  middleini2_value := ''	: stored('middleini2');
string20 last2_value := ''     	: stored('last2');
string50 addr2_value := ''    	: stored('addr2');
string30 city2_value := ''      	: stored('city2');
string2  state2_value := ''      	: stored('state2');
string9  zip2_value := ''      	: stored('zip2');
string10 hphone2_value := ''   	: stored('hphone2');
string9  fin_value := ''			: stored('fin');
string30 cmpy2_value := ''   		: stored('cmpy2');
string4  score_value := ''		: stored('score');
string4  score2_value := ''		: stored('score2');
string2  apptype_value := ''		: stored('apptype');
string2  channel_value := ''		: stored('channel');
string6  orderamt_value := ''		: stored('orderamt');
string3  numitems_value := ''		: stored('numitems');
string8  orderdate_value := ''	: stored('orderdate');
string2  shipmode_value := ''		: stored('shipmode');
string2  pymtmethod_value := ''	: stored('pymtmethod');
string1  avscode_value := ''		: stored('avscode');

unsigned1 DPPA_Purpose := RiskWise.permittedUse.fraudDPPA : stored('DPPAPurpose');
unsigned1 GLB_Purpose := RiskWise.permittedUse.fraudGLBA : stored('GLBPurpose');
unsigned3 history_date := 999999  	: stored('HistoryDateYYYYMM');
string DataRestriction := risk_indicators.iid_constants.default_DataRestriction : stored('DataRestrictionMask');
string50 DataPermission := Risk_Indicators.iid_constants.default_DataPermission : stored('DataPermissionMask');
gateways_in := Gateway.Configuration.Get();

tribCode := StringLib.StringToLowerCase(tribCode_value);
boolean Log_trib := tribCode in ['dl01'];

targusGatewaySet := ['dl01'];
Gateway.Layouts.Config gw_switch(gateways_in le) := transform
	self.servicename := le.servicename;
	self.url := if(tribcode in targusGatewaySet and le.servicename = 'targus', le.url, ''); // default to no gateway call			 
	self := le;
end;
gateways := project(gateways_in, gw_switch(left));


productSet := ['dl01'];


d := dataset([{0}],RiskWise.Layout_DLLI);


RiskWise.Layout_DLLI into(d le, INTEGER C) := TRANSFORM
	self.seq := C;
	self.account := account_value;
	self.first := first_value;
	self.middleini := middleini_value;
	self.last := last_value;
	self.addr := addr_value;
	self.city := city_value;
	self.state := state_value;
	self.zip := zip_value;
	self.hphone := hphone_value;
	self.socs := socs_value;	
	self.dob := dob_value;	
	self.wphone := wphone_value;
	self.income := income_value;
	self.drlc := drlc_value;
	self.drlcstate := drlcstate_value;
	self.balance := balance_value;	
	self.chargeoffdate := chargeoffdate_value;
	self.formerlast := formerlast_value;
	self.email := email_value;
	self.cmpy := cmpy_value;
	self.first2 := first2_value;
	self.middleini2 := middleini2_value;
	self.last2 := last2_value;
	self.addr2 := addr2_value;
	self.city2 := city2_value;
	self.state2 := state2_value;
	self.zip2 := zip2_value;
	self.hphone2 := hphone2_value;
	self.fin := fin_value;
	self.cmpy2 := cmpy2_value;
	self.score := score_value;
	self.score2 := score2_value;
	self.apptype := apptype_value;
	self.channel := channel_value;
	self.orderamt := orderamt_value;
	self.numitems := numitems_value;
	self.orderdate := orderdate_value;
	self.shipmode := shipmode_value;
	self.pymtmethod := pymtmethod_value;
	self.avscode := avscode_value;
	self.historydate := history_date;
END;
prep := PROJECT(d,into(LEFT,COUNTER));

DLLO_Royalties := RiskWise.DLLO_Function(prep, gateways, GLB_Purpose, DPPA_Purpose, DataRestriction, DataPermission);
dRoyalties :=Royalty.RoyaltyTargus.GetOnlineRoyalties(DLLO_Royalties, src, TargusType, TRUE, FALSE, FALSE, TRUE);

DLLO_final := PROJECT(dllo_Royalties, RiskWise.Layout_DLLO);

tribCheck := IF(tribCode in productSet, DLLO_final, dataset([],RiskWise.Layout_DLLO));

//Log to Deltabase
Deltabase_Logging_prep := project(tribCheck, transform(Risk_Reporting.Layouts.LOG_Deltabase_Layout_Record,
																								 self.company_id := (Integer)CompanyID,
																								 self.login_id := _LoginID,
																								 self.product_id := Risk_Reporting.ProductID.RiskWise__RiskWiseMainDLLO,
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
																								 self.o_score_1    := left.frdriskscore,
																								 self.o_lexid := (Integer)left.riskwiseid,  //did
																								 self := left,
																								 self := [] ));
Deltabase_Logging := DATASET([{Deltabase_Logging_prep}], Risk_Reporting.Layouts.LOG_Deltabase_Layout);
// #stored('Deltabase_Log', Deltabase_Logging);

//Improved Scout Logging
IF(~DisableOutcomeTracking and Log_trib, OUTPUT(Deltabase_Logging, NAMED('LOG_log__mbs_transaction__log__scout')));

output(tribCheck,NAMED('Results'));
output(dRoyalties, named('RoyaltySet'));

ENDMACRO;