/*--SOAP--
<message name="Call Trace">
	<part name="tribcode" type="xsd:string"/>
	<part name="account" type="xsd:string"/>
	<part name="phone" type="xsd:string"/>
	<part name="runSeed" type="xsd:boolean"/>
	<part name="DPPAPurpose" type="xsd:byte"/>
	<part name="GLBPurpose" type="xsd:byte"/> 
	<part name="ApplicationType" type="xsd:string"/>
	<part name="DataRestrictionMask" type="xsd:string"/>
	<part name="HistoryDateYYYYMM" type="xsd:integer"/>
	<part name="gateways" type="tns:XmlDataSet" cols="70" rows="25"/>
	<part name="OutcomeTrackingOptOut" type="xsd:boolean"/>
 </message>
*/
/*--INFO-- Migrating ct02, ct03 and ct50 to boca */

import risk_indicators,AutoStandardI,seed_files,gateway, Royalty;

export RiskWiseMainCT1O := MACRO

// Can't have duplicate definitions of Stored with different default values, 
// so add the default to #stored to eliminate the assignment of a default value.
#stored('GLBPurpose',RiskWise.permittedUse.fraudGLBA);
#stored('DataRestrictionMask',risk_indicators.iid_constants.default_DataRestriction);

/* Force layout of WsECL page */
#WEBSERVICE(FIELDS(
	'tribcode',
	'account',
	'phone',
	'runSeed',
	'DPPAPurpose',
	'GLBPurpose', 
	'ApplicationType',
	'DataRestrictionMask',
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
	Industry_Search := Inquiry_AccLogs.Key_Inquiry_industry_use_vertical(FALSE)(s_company_id = CompanyID and s_product_id = (String)Risk_Reporting.ProductID.RiskWise__RiskWiseMainCT1O);
/* ************* End Scout Fields **************/

string4 tribCode_value := '' : stored('tribcode');	// not used in prii
string30 account_value := '' : stored('account');
string10 phone_value := ''   : stored('phone');
boolean runSeed_value := false : stored('runSeed');
gateways_in := Gateway.Configuration.Get();

unsigned1 DPPA_Purpose := RiskWise.permittedUse.fraudDPPA : stored('DPPAPurpose');
unsigned1 GLB_Purpose := RiskWise.permittedUse.fraudGLBA : stored('GLBPurpose');
unsigned3 history_date := 999999 : stored('HistoryDateYYYYMM');
boolean isUtility := false;
boolean ln_branded := false;
boolean ofac_only := true;
boolean suppressNearDups := true;
boolean require2Ele := true;
string DataRestriction := risk_indicators.iid_constants.default_DataRestriction : stored('DataRestrictionMask');
appType := AutoStandardI.InterfaceTranslator.application_type_val.val(project(AutoStandardI.GlobalModule(),AutoStandardI.InterfaceTranslator.application_type_val.params));


tribcode := StringLib.StringToLowerCase(tribCode_value);
boolean Log_trib := tribCode in ['ct02'];

Gateway.Layouts.Config gw_switch(gateways_in le) := transform
	self.servicename := le.servicename;
	self.url := map(tribcode in ['ct02', 'ct03', 'ct50'] and le.servicename in ['targus'] => le.url,  // use targus gateway if needed
				 ''); // default to no gateway call			 
	self := le;
end;

gateways := project(gateways_in, gw_switch(left));

riskwise.Layout_CT1I prep(riskwise.Layout_CT1O_BatchIn le, integer C) := transform
	self.tribcode := tribcode;
	self.seq := C;
	self.acctno := '';
	self.account := account_value;
	self.phoneno := RiskWise.cleanPhone( phone_value );
	self.historydate := history_date;
end;

indata := project(dataset([{''}], riskwise.Layout_CT1O_BatchIn), prep(left, counter));


almost_final := riskwise.CT1O_Function(indata, gateways, dppa_purpose, glb_purpose, isUtility, ln_branded, DataRestriction, appType);

//don't track royalties for testseeds
dRoyalties := if(runSeed_value, dataset([], Royalty.Layouts.Royalty),
	Royalty.RoyaltyTargus.GetOnlineRoyalties(UNGROUP(almost_final), src, TargusType, TRUE, FALSE, FALSE, TRUE));

final := project(almost_final, riskwise.Layout_CT1O);

seed_files.mac_query_seedfiles(phone_value, 'ct1o', 'phni', '002', seed_out);

RiskWise.Layout_CT1O format_seed(seed_out le) := transform
	self.account := account_value;
	self.first := le.fname;
	self.last := le.lname;
	self.Billing := dataset([], risk_indicators.Layout_Billing);
	self := le;
end;
final_seed := if(runSeed_value, project(seed_out, format_seed(left)), dataset([], riskwise.Layout_CT1O));
		
emptyset := dataset([], riskwise.Layout_CT1O);
ret := map(	tribcode='ct02' and count(final_seed)>0 and runSeed_value => final_seed,
			tribcode in ['ct02', 'ct03', 'ct50'] => ungroup(final),
			emptyset);

//Log to Deltabase
Deltabase_Logging_prep := project(ret, transform(Risk_Reporting.Layouts.LOG_Deltabase_Layout_Record,
																								 self.company_id := (Integer)CompanyID,
																								 self.login_id := _LoginID,
																								 self.product_id := Risk_Reporting.ProductID.RiskWise__RiskWiseMainCT1O,
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
																								 self.data_restriction_mask := DataRestriction,
																								 self.industry := Industry_Search[1].Industry,
																								 self.o_lexid := (Integer)left.riskwiseid,  //did
																								 self := left,
																								 self := [] ));
Deltabase_Logging := DATASET([{Deltabase_Logging_prep}], Risk_Reporting.Layouts.LOG_Deltabase_Layout);
// #stored('Deltabase_Log', Deltabase_Logging);

//Improved Scout Logging
IF(~DisableOutcomeTracking and Log_trib, OUTPUT(Deltabase_Logging, NAMED('LOG_log__mbs_transaction__log__scout')));

output(ret, named('Results'));

output(dRoyalties, named('RoyaltySet'));

ENDMACRO;
// RiskWiseMainCT1O();