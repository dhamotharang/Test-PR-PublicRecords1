/*--SOAP--
<message name="Custom Business Application Screening">
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
	<part name="drlc" type="xsd:string"/>
	<part name="drlcstate" type="xsd:string"/>
	<part name="income" type="xsd:string"/>
	<part name="cmpy" type="xsd:string"/>
	<part name="cmpyaddr" type="xsd:string"/>
	<part name="cmpycity" type="xsd:string"/>
	<part name="cmpystate" type="xsd:string"/>
	<part name="cmpyzip" type="xsd:string"/>
	<part name="cmpyphone" type="xsd:string"/>
	<part name="fin" type="xsd:string"/>
	<part name="internetcommflag" type="xsd:string"/>
	<part name="emailaddr" type="xsd:string"/>
	<part name="emailheadr" type="xsd:string"/>
	<part name="ipaddr" type="xsd:string"/>
	<part name="appdate" type="xsd:string"/>
	<part name="apptime" type="xsd:string"/>
	<part name="DPPAPurpose" type="xsd:byte"/>
	<part name="GLBPurpose" type="xsd:byte"/> 
	<part name="DataRestrictionMask" type="xsd:string"/>
	<part name="DataPermissionMask" type="xsd:string"/>
	<part name="HistoryDateYYYYMM" type="xsd:integer"/>
	<part name="runSeed" type="xsd:boolean"/>	
  <part name="OutcomeTrackingOptOut" type="xsd:boolean"/>
 </message>
*/
/*--INFO-- bnk4 and cbbl */
//	<part name="gateways" type="tns:XmlDataSet" cols="70" rows="25"/>

IMPORT  Risk_Reporting, gateway, risk_indicators, Inquiry_AccLogs, STD;
export RiskwiseMainBC1O := MACRO
#onwarning(4207, ignore);
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
	'addr',
	'city',
	'state',
	'zip',
	'socs',
	'dob',
	'hphone',
	'drlc',
	'drlcstate',
	'income',
	'cmpy',
	'cmpyaddr',
	'cmpycity',
	'cmpystate',
	'cmpyzip',
	'cmpyphone',
	'fin',
	'internetcommflag',
	'emailaddr',
	'emailheadr',
	'ipaddr',
	'appdate',
	'apptime',
	'DPPAPurpose',
	'GLBPurpose', 
	'DataRestrictionMask',
	'DataPermissionMask',
	'HistoryDateYYYYMM',
	'runSeed',
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
	Industry_Search := Inquiry_AccLogs.Key_Inquiry_industry_use_vertical_login(FALSE)(s_company_id = CompanyID and s_product_id = (String)Risk_Reporting.ProductID.RiskWise__RiskWiseMainBC1O);
/* ************* End Scout Fields **************/
	
string4  tribCode_value := '' 		: stored('tribcode');	
string30 account_value := '' 			: stored('account');
string15 fname_value := ''     		: stored('first');
string20 lname_value := ''     		: stored('last');
string50 addr_value := ''    			: stored('addr');
string30 city_value := ''      		: stored('city');
string2  state_value := ''      	: stored('state');
string9  zip_value := ''      		: stored('zip');
string9  socs_value := ''      		: stored('socs');
string8  dob_value := ''      		: stored('dob');
string10 hphone_value := ''   		: stored('hphone');
STRING20 dl_number_value := ''    : stored('drlc');
STRING2  dl_state_value := ''     : stored('drlcstate');
STRING6  income_value := ''  			: stored('income');
STRING30 cmpyname_value := ''   	: stored('cmpy');
string50 cmpyaddr_value := ''    	: stored('cmpyaddr');
string30 cmpycity_value := ''     : stored('cmpycity');
string2  cmpystate_value := ''    : stored('cmpystate');
string9  cmpyzip_value := ''      : stored('cmpyzip');
string10 cmpyphone_value := ''   	: stored('cmpyphone');
string20 fin_value := ''      		: stored('fin');
STRING1  internetcommflag_value := '' : stored('internetcommflag');
string50 emailaddr_value := ''  	: stored('emailaddr');
string50 emailheadr_value := ''  	: stored('emailheadr');
STRING45 ipaddr_value := ''  			: stored('ipaddr');
string8  appdate_value := ''  		: stored('appdate');
string6  apptime_value := ''     	: stored('apptime');

unsigned1 DPPA_Purpose := RiskWise.permittedUse.fraudDPPA : stored('DPPAPurpose');
unsigned1 GLB_Purpose := RiskWise.permittedUse.fraudGLBA  : stored('GLBPurpose');
unsigned3 history_date := 999999 : stored('HistoryDateYYYYMM');
boolean runSeed_value := false   : stored('runSeed');
string DataRestriction := risk_indicators.iid_constants.default_DataRestriction  : stored('DataRestrictionMask');
string50 DataPermission  := Risk_Indicators.iid_constants.default_DataPermission : stored('DataPermissionMask');
#stored('DisableBocaShellLogging', DisableOutcomeTracking);

// gateways_in := dataset([],risk_indicators.Layout_Gateways_In) : STORED('gateways',few);

tribCode := StringLib.StringToLowerCase(tribCode_value);
boolean Log_trib := tribCode in ['bnk4', 'cbbl'];

// risk_indicators.Layout_Gateways_In gw_switch(gateways_in le) := transform
	// self.servicename := ''; 
	// self.url := '';	 
// end;

gateways := Gateway.Constants.void_gateway;

d := dataset([{0}],RiskWise.Layout_BC1I);

RiskWise.Layout_BC1I addseq(d l, integer C) := transform
	 self.seq := C;
	 self.tribcode := tribCode;
	 self.acctno := '';
	 self.ACCOUNT := account_value;
	 self.FIRST := fname_value;
	 self.LAST := lname_value;
	 self.ADDR := addr_value;
	 self.CITY := city_value;
	 self.STATE := state_value;
	 self.ZIP := zip_value;
	 self.SOCS := socs_value;
	 self.DOB := dob_value;
	 self.HPHONE := hphone_value;
	 self.DRLC := dl_number_value;
	 self.DRLCSTATE := dl_state_value;
	 self.income := income_value;
	 self.CMPY := cmpyname_value;
	 self.CMPYADDR := cmpyaddr_value;
	 self.CMPYCITY := cmpycity_value;
	 self.CMPYSTATE := cmpystate_value;
	 self.CMPYZIP := cmpyzip_value;
	 self.CMPYPHONE := cmpyphone_value;
	 self.FIN := fin_value;
	 self.internetcommflag := internetcommflag_value;
	 self.emailaddr := emailaddr_value;
	 self.emailheadr := emailheadr_value;
	 self.ipaddr := ipaddr_value;
	 self.appdate := appdate_value;
	 self.apptime := apptime_value;
	 self.historydate := history_date;
end;
f := project(d, addseq(LEFT,COUNTER));

critter := map(tribcode = 'bnk4' => '001',
								tribcode = 'cbbl' => '003',
							 '');

seed_files.mac_query_seedfiles(fin_value, 'bc1o', 'bc1i', critter, bcii_seed_output);

seed_files.Layout_BC1O format_seed(bcii_seed_output le) := transform
	self.account := account_value;
	self := le;
	self := [];
end;
final_seed := if(runSeed_value, project(bcii_seed_output, format_seed(left)), dataset([],seed_files.Layout_BC1O) );

pre_ret := RiskWise.BC1O_Function(f, gateways, GLB_Purpose, DPPA_Purpose, false, false, tribCode, DataRestriction:=DataRestriction, DataPermission:=DataPermission);

ret := if(tribCode in ['bnk4', 'cbbl'], 
					if(count(final_seed)>0 and runSeed_value, final_seed, 
									project(pre_ret, transform(riskwise.Layout_BC1O, Self := left))), 
													  dataset([{account_value}], riskwise.Layout_BC1O));
																										
intermediateLog := DATASET([], Risk_Reporting.Layouts.LOG_Boca_Shell) : STORED('Intermediate_Log');

// Note: All intermediate logs must have the following name schema:
// Starts with 'LOG_' (Upper case is important!!)
// Middle part is the database name, in this case: 'log__mbs'
// Must end with '_intermediate__log'
IF(~DisableOutcomeTracking and Log_trib and ~runSeed_value, OUTPUT(intermediateLog, NAMED('LOG_log__mbs_intermediate__log')) );

	//Log to Deltabase
	Deltabase_Logging_prep := project(pre_ret, transform(Risk_Reporting.Layouts.LOG_Deltabase_Layout_Record,
																									 self.company_id := (Integer)CompanyID,
																									 self.login_id := _LoginID,
																									 self.product_id := Risk_Reporting.ProductID.RiskWise__RiskWiseMainBC1O,
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
																									 self.i_name_first := fname_value,
																									 self.i_name_last := lname_value,
																									 self.i_address := addr_value,
																									 self.i_city := city_value,
																									 self.i_state := state_value,
																									 self.i_zip := zip_value,
																									 self.i_dl := dl_number_value,
																									 self.i_dl_state := dl_state_value,
                                                   self.i_home_phone := hphone_value,
																									 self.i_tin := fin_value,
																									 self.i_bus_name := cmpyname_value,
																									 self.i_bus_address := cmpyaddr_value,
																									 self.i_bus_city := cmpycity_value,
																									 self.i_bus_state := cmpystate_value,
																									 self.i_bus_zip := cmpyzip_value,
                                                   self.i_bus_phone := cmpyphone_value,
																									 self.o_score_1 := left.ecovariables,
																									 self.o_score_2 := if(tribcode = 'cbbl', left.cmpyaddrscore, ''),
																									 self.o_bdid    := left.riskwiseid, //bdid
																									 self.o_lexid   := left.RepDid,     //repdid
																									 self := left,
																									 self := [] ));
Deltabase_Logging := DATASET([{Deltabase_Logging_prep}], Risk_Reporting.Layouts.LOG_Deltabase_Layout);
// #stored('Deltabase_Log', Deltabase_Logging);

//Improved Scout Logging
IF(~DisableOutcomeTracking and Log_trib and ~runSeed_value, OUTPUT(Deltabase_Logging, NAMED('LOG_log__mbs_transaction__log__scout')));
	
output(ret, named('Results'));

ENDMACRO;
