/*--SOAP--
<message name="InfoTrace Collection Scores">
	<part name="tribcode" type="xsd:string"/>
	<part name="account" type="xsd:string"/>
	<part name="first" type="xsd:string"/>
	<part name="last" type="xsd:string"/>
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
	<part name="debttype" type="xsd:string"/>
	<part name="chargeoffdate" type="xsd:string"/>
	<part name="opendate" type="xsd:string"/>
	<part name="lastpymt" type="xsd:string"/>
	<part name="chargeoffamt" type="xsd:string"/>
	<part name="balance" type="xsd:string"/>
	<part name="internaluse" type="xsd:string"/>
	<part name="DPPAPurpose" type="xsd:byte"/>
	<part name="GLBPurpose" type="xsd:byte"/>
	<part name="HistoryDateYYYYMM" type="xsd:integer"/>
	<part name="DataRestrictionMask" type="xsd:string"/>
	<part name="DataPermissionMask" type="xsd:string"/>
	<part name="ApplicationType" type="xsd:string"/>
	<part name="runSeed" type="xsd:boolean"/>
	<part name="gateways" type="tns:XmlDataSet" cols="70" rows="25"/>
	<part name="OutcomeTrackingOptOut" type="xsd:boolean"/>
 </message>
*/
/*--INFO-- Migrating it21, it37, it51, it60, it61, it70, it90, i200, at00, bkd0, and wst4 to boca.  */

import address, risk_indicators, Models, autoStandardI, seed_files, gateway;

export RiskWiseMainIT1O := macro

// Can't have duplicate definitions of Stored with different default values, 
// so add the default to #stored to eliminate the assignment of a default value.
#stored('GLBPurpose',RiskWise.permittedUse.fraudGLBA);
#stored('DataRestrictionMask',risk_indicators.iid_constants.default_DataRestriction);
#stored('DataPermissionMask',Risk_Indicators.iid_constants.default_DataPermission);

/* Force layout of WsECL page */
#WEBSERVICE(FIELDS(
	'tribcode',
	'account',
	'first',
	'last',
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
	'debttype',
	'chargeoffdate',
	'opendate',
	'lastpymt',
	'chargeoffamt',
	'balance',
	'internaluse',
	'DPPAPurpose',
	'GLBPurpose',
	'HistoryDateYYYYMM',
	'DataRestrictionMask',
	'DataPermissionMask',
	'ApplicationType',
	'runSeed',
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
	string6 ssnmask             := 'NONE' : STORED('SSNMask');
	string10 dobmask            := '' : STORED('DOBMask');
	string1 dlmask              := '' : STORED('DLMask');
	string5 DeliveryMethod      := '' : STORED('_DeliveryMethod');
	string5 DeathMasterPurpose  := '' : STORED('__deathmasterpurpose');
	string1 ExcludeDMVPII       := '' : STORED('ExcludeDMVPII');
	BOOLEAN DisableOutcomeTracking := FALSE : STORED('OutcomeTrackingOptOut');
	string1 ArchiveOptIn        := '' : STORED('instantidarchivingoptin');

	//Look up the industry by the company ID.
	Industry_Search := Inquiry_AccLogs.Key_Inquiry_industry_use_vertical_login(FALSE)(s_company_id = CompanyID and s_product_id = (String)Risk_Reporting.ProductID.RiskWise__RiskWiseMainIT1O);
/* ************* End Scout Fields **************/

string4 tribCode_value := '' : stored('tribcode');
string30 account_value := '' : stored('account');
string15 first_value := '' : stored('first');
string20 last_value := '' : stored('last');
string50 addr_value := '' : stored('addr');
string30 city_value := '' : stored('city');
string2 state_value := '' : stored('state');
string5 zip_value := '' : stored('zip');
string9 socs_value := '' : stored('socs');
string8 dob_value := '' : stored('dob');
string10 hphone_value := '' : stored('hphone');
string10 wphone_value := '' : stored('wphone');
string20 drlc_value := '' : stored('drlc');
string2 drlcstate_value := '' : stored('drlcstate');
string2 debttype_value := '02' : stored('debttype');
string8 chargeoffdate_value := '' : stored('chargeoffdate');
string8 opendate_value := '' : stored('opendate');
string8 lastpymt_value := '' : stored('lastpymt');
string6 chargeoffamt_value := '' : stored('chargeoffamt');
string6 balance_value := '' : stored('balance');
string4 internaluse_value := '' : stored('internaluse');
string DataRestriction := risk_indicators.iid_constants.default_DataRestriction : stored('DataRestrictionMask');
string DataPermission  := Risk_Indicators.iid_constants.default_DataPermission : stored('DataPermissionMask');
unsigned1 DPPA_Purpose := RiskWise.permittedUse.fraudDPPA : stored('DPPAPurpose');
unsigned1 GLB_Purpose := RiskWise.permittedUse.fraudGLBA : stored('GLBPurpose');
unsigned3 history_date := 999999 : stored('HistoryDateYYYYMM');
boolean   runSeed_value := false : stored('runSeed');
gateways_in := Gateway.Configuration.Get();
appType := AutoStandardI.InterfaceTranslator.application_type_val.val(project(AutoStandardI.GlobalModule(),AutoStandardI.InterfaceTranslator.application_type_val.params));

product_set := ['it21','it37','it51','it60','it70','it90','i200','at00','bkd0','wst4','it61'];

d := dataset([{0}],RiskWise.Layout_IT1I);
tribcode := StringLib.StringToLowerCase(tribCode_value);
boolean Log_trib := tribcode in ['at00', 'it61', 'it70'];

Gateway.Layouts.Config gw_switch(gateways_in le) := transform
	self.servicename := le.servicename;
	self.url := if(trim(StringLib.StringToLowerCase(le.servicename)) = 'veris', le.url, ''); // default to no gateway call			 
	self := le;
end;
gateways := project(gateways_in, gw_switch(left));

RiskWise.Layout_IT1I addseq(d l) := transform
	self.seq := l.seq;
	self.tribcode := tribcode;
	self.acctno := '';  // for batch only
	self.account := account_value;
	self.first := first_value;
	self.last := last_value;
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
	self.debttype := debttype_value;
	self.chargeoffdate := chargeoffdate_value;
	self.opendate := opendate_value;
	self.lastpymt := lastpymt_value;
	self.chargeoffamt := chargeoffamt_value;
	self.balance := balance_value;
	self.internaluse := internaluse_value;
	self.historydate := history_date;
end;
indata := project(d, addseq(LEFT));


critter := case(tribcode,
	'at00' => '050',
	''
);

seed_files.mac_query_seedfiles(socs_value, 'it1o', 'it1i', critter, it1i_seed_output);

riskwise.Layout_IT4O format_seed(it1i_seed_output le) := transform
	self.account := account_value;

	// adjust for collisions between input and output names
	self.first := le.first_out;
	self.last  := le.last_out;
	self.addr  := le.addr_out;
	self.city  := le.city_out;
	self.state := le.state_out;
	self.zip   := le.zip_out;

	self := le;
	self := [];
end;
final_seed := if(runSeed_value, project(it1i_seed_output, format_seed(left)), dataset([],RiskWise.Layout_IT4O) );

final := map(
	tribcode not in product_set             => dataset( [], RiskWise.Layout_IT4O ),
	count(final_seed) > 0 and runSeed_Value => final_seed,
	riskwise.IT1O_Function(indata, gateways, dppa_purpose, glb_purpose, DataRestriction:=DataRestriction,appType:=appType, DataPermission:=DataPermission)
);

map_score1 := map(tribcode in ['it51','it60','it61','it70', 'i200'] => 1,
									tribcode in ['it21']                              => 2,
									tribcode in ['it37','it90','at00']                => 3,
									                                                     0);
map_score2 := map(tribcode in ['it60','it70'] => 2,
									tribcode in ['it61']        => 3,
									                               0);

//Log to Deltabase
Deltabase_Logging_prep := project(final, transform(Risk_Reporting.Layouts.LOG_Deltabase_Layout_Record,
																								 self.company_id := (Integer)CompanyID,
																								 self.login_id := _LoginID,
																								 self.product_id := Risk_Reporting.ProductID.RiskWise__RiskWiseMainIT1O,
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
																								 self.o_score_1    := map(map_score1 = 1 => left.score,
																																					map_score1 = 2 => left.score2,
																																					map_score1 = 3 => left.score3,
																																														''),
																								 self.o_score_2    := map(map_score2 = 2 => left.score2,
																																					map_score2 = 3 => left.score3,
																																														''),
																								 self.o_lexid := (Integer)left.riskwiseid,  //did
																								 self := left,
																								 self := [] ));
Deltabase_Logging := DATASET([{Deltabase_Logging_prep}], Risk_Reporting.Layouts.LOG_Deltabase_Layout);
// #stored('Deltabase_Log', Deltabase_Logging);

//Improved Scout Logging
IF(~DisableOutcomeTracking and Log_trib and ~runSeed_value, OUTPUT(Deltabase_Logging, NAMED('LOG_log__mbs_transaction__log__scout')));

output(final, named('Results'));

ENDMACRO;
// RiskWiseMainIT1O();