/*--SOAP--
<message name="St. Cloud Main Service PRIO">
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
	<part name="DPPAPurpose" type="xsd:byte"/>
	<part name="GLBPurpose" type="xsd:byte"/>
	<part name="DataRestrictionMask" type="xsd:string"/>
	<part name="DataPermissionMask" type="xsd:string"/>
	<part name="HistoryDateYYYYMM" type="xsd:integer"/>
	<part name="runSeed" type="xsd:boolean"/>
  <part name="OutcomeTrackingOptOut" type="xsd:boolean"/>
	<part name="gateways" type="tns:XmlDataSet" cols="70" rows="25"/>
 </message>
*/
/*--INFO-- 'pi01','pi02','pi04','pi05','pi07','pi09','pi14','pi60','allv','hdx1','flfn','bnk2','bnk3' */

import Risk_Reporting, Risk_Indicators,gateway;

export RiskWiseMainPRIO := MACRO

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
	'DPPAPurpose',
	'GLBPurpose',
	'DataRestrictionMask',
	'DataPermissionMask',
	'HistoryDateYYYYMM',
	'runSeed',
	'OutcomeTrackingOptOut',
	'gateways'));
	
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
	Industry_Search := Inquiry_AccLogs.Key_Inquiry_industry_use_vertical_login(FALSE)(s_company_id = CompanyID and s_product_id = (String)Risk_Reporting.ProductID.RiskWise__RiskWiseMainPRIO);
/* ************* End Scout Fields **************/

string4  tribCode_value := ''      : stored('tribcode');
string30 account_value := ''       : stored('account');
string15 first_value := ''         : stored('first');
string1  middleini_value := ''     : stored('middleini');
string20 last_value := ''          : stored('last');
string50 addr_value := ''          : stored('addr');
string30 city_value := ''          : stored('city');
string2  state_value := ''         : stored('state');
string9  zip_value := ''           : stored('zip');
string10 hphone_value := ''        : stored('hphone');
string9  socs_value := ''          : stored('socs');
string8  dob_value := ''           : stored('dob');
string10 wphone_value := ''        : stored('wphone');
string6  income_value := ''        : stored('income');
string20 drlc_value := ''          : stored('drlc');
string2  drlcstate_value := ''     : stored('drlcstate');
string6  balance_value := ''       : stored('balance');
string8  chargeoffdate_value := '' : stored('chargeoffdate');
string20 formerlast_value := ''    : stored('formerlast');
string50 email_value := ''         : stored('email');
string30 cmpy_value := ''          : stored('cmpy');
string DataRestriction := risk_indicators.iid_constants.default_DataRestriction : stored('DataRestrictionMask');
string50 DataPermission  := Risk_Indicators.iid_constants.default_DataPermission : stored('DataPermissionMask');

tribCode := StringLib.StringToLowerCase(tribCode_value);
boolean Log_trib := tribcode in ['allv', 'flfn', 'pi02', 'pi07', 'pi60'];

unsigned1 DPPA_Purpose := RiskWise.permittedUse.fraudDPPA 	: stored('DPPAPurpose');
unsigned1 GLB_Purpose := RiskWise.permittedUse.fraudGLBA : stored('GLBPurpose');
unsigned3 history_date := 999999  						: stored('HistoryDateYYYYMM');
boolean runSeed_value := false 						: stored('runSeed');
gateways_in := Gateway.Configuration.Get();

#stored('DisableBocaShellLogging', DisableOutcomeTracking);

productSet := ['pi01','pi02','pi04','pi05','pi07','pi09','pi14','pi60','allv','hdx1','flfn','bnk2','bnk3'];

targusGatewaySet := ['pi02','pi04','pi05','pi07','pi09','pi14','allv','pi60','hdx1','flfn','bnk3'];

Gateway.Layouts.Config gw_switch(gateways_in le) := transform
	self.servicename := le.servicename;
	self.url := if(tribcode in targusGatewaySet and le.servicename = 'targus', le.url, ''); // default to no gateway call			 
	self := le;
end;
gateways := project(gateways_in, gw_switch(left));


d := dataset([{0}],RiskWise.Layout_PRII);

Riskwise.Layout_PRII addseq(d le, INTEGER C) := TRANSFORM
	self.seq := C;
	self.tribcode := tribCode;
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
	self.countrycode := '';
	self.historydate := history_date;
end;
f := project(d, addseq(LEFT,COUNTER));


critter := map(tribcode = 'pi02' => '002',
			tribcode = 'pi07' => '007',
			tribcode = 'pi09' => '009',
			tribcode = 'pi14' => '014',
			tribcode = 'allv' => '020',
			tribcode = 'hdx1' => '102',
			tribcode = 'bnk2' => '045',
			'');

seed_files.mac_query_seedfiles(socs_value, 'prio', 'prii', critter, prii_seed_output);

riskwise.Layout_PRIO format_seed(prii_seed_output le) := transform
	self.account := account_value;
	self := le;
	self := [];
end;
final_seed := if(runSeed_value, project(prii_seed_output, format_seed(left)), dataset([],RiskWise.Layout_PRIO) );


almost_final := RiskWise.PRIO_Function(f, gateways, GLB_Purpose, DPPA_Purpose, tribCode,DataRestriction, DataPermission);

//don't track royalties for testseeds
dRoyalties := if(runSeed_value, dataset([], Royalty.Layouts.Royalty),
	Royalty.RoyaltyTargus.GetOnlineRoyalties(almost_final, src, TargusType, TRUE, FALSE, FALSE, TRUE));

final := project(almost_final, Riskwise.Layout_PRIO);

finalAnswer := if(tribCode in productSet,
			   if(count(final_seed)>0 and runSeed_value, final_seed, final),
			      dataset([],Riskwise.Layout_PRIO));
						
intermediateLog := DATASET([], Risk_Reporting.Layouts.LOG_Boca_Shell) : STORED('Intermediate_Log');

// Note: All intermediate logs must have the following name schema:
// Starts with 'LOG_' (Upper case is important!!)
// Middle part is the database name, in this case: 'log__mbs'
// Must end with '_intermediate__log'
IF(~DisableOutcomeTracking and Log_trib and ~runSeed_value, OUTPUT(intermediateLog, NAMED('LOG_log__mbs_intermediate__log')) );

//Log to Deltabase
Deltabase_Logging_prep := project(finalAnswer, transform(Risk_Reporting.Layouts.LOG_Deltabase_Layout_Record,
																								 self.company_id := (Integer)CompanyID,
																								 self.login_id := _LoginID,
																								 self.product_id := Risk_Reporting.ProductID.RiskWise__RiskWiseMainPRIO,
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
																								 self.i_bus_name := cmpy_value,
																								 self.o_score_1  := left.frdriskscore,
																								 self.o_score_2  := left.estincome,
																								 self.o_lexid    := (Integer)left.riskwiseid,  //did
																								 self := left,
																								 self := [] ));
Deltabase_Logging := DATASET([{Deltabase_Logging_prep}], Risk_Reporting.Layouts.LOG_Deltabase_Layout);
// #stored('Deltabase_Log', Deltabase_Logging);

//Improved Scout Logging
IF(~DisableOutcomeTracking and Log_trib and ~runSeed_value, OUTPUT(Deltabase_Logging, NAMED('LOG_log__mbs_transaction__log__scout')));

output(finalAnswer,NAMED('Results'));

output(dRoyalties, named('RoyaltySet'));

ENDMACRO;