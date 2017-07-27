/*--SOAP--
<message name="IP Validation Process (ipv1)">
	<part name="tribcode" type="xsd:string"/>
	<part name="account" type="xsd:string"/>
	<part name="ipaddr" type="xsd:string"/>
	<part name="DPPAPurpose" type="xsd:byte"/>
	<part name="GLBPurpose" type="xsd:byte"/> 
	<part name="gateways" type="tns:XmlDataSet" cols="70" rows="25"/>
	<part name="OutcomeTrackingOptOut" type="xsd:boolean"/>
 </message>
*/
/*--INFO-- This process calls the netacuity gateway for IP info  */
    
import risk_indicators, gateway, royalty;

export RiskwiseMainIPVO := MACRO

// Can't have duplicate definitions of Stored with different default values, 
// so add the default to #stored to eliminate the assignment of a default value.
#stored('GLBPurpose',RiskWise.permittedUse.fraudGLBA);

/* Force layout of WsECL page */
#WEBSERVICE(FIELDS(
	'tribcode',
	'account',
	'ipaddr',
	'DPPAPurpose',
	'GLBPurpose', 
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
	Industry_Search := Inquiry_AccLogs.Key_Inquiry_industry_use_vertical(FALSE)(s_company_id = CompanyID and s_product_id = (String)Risk_Reporting.ProductID.RiskWise__RiskWiseMainIPVO);
/* ************* End Scout Fields **************/

string4 tribcode_value := '' 							: stored('tribcode');
string30 account_value := ''	 						: stored('account');
string45 ip_value := '' 								: stored('ipaddr');
unsigned1 DPPA_Purpose := RiskWise.permittedUse.fraudDPPA 	: stored('DPPAPurpose');
unsigned1 GLB_Purpose := RiskWise.permittedUse.fraudGLBA : stored('GLBPurpose');
gateways_in := Gateway.Configuration.Get();

tribCode := StringLib.StringToLowerCase(tribCode_value);
boolean Log_trib := tribcode in ['ipv1'];

Gateway.Layouts.Config gw_switch(gateways_in le) := transform
	self.servicename := le.servicename;
	self.url := if(le.servicename='netacuity', le.url, '');
	self := le;
end;
gateways := project(gateways_in, gw_switch(left));

d := dataset([{(unsigned)account_value}], riskwise.Layout_IPAI);

riskwise.layout_IPAI t_f(d le) := transform
	self.seq := le.seq;
	self.ipaddr := ip_value;
end;

indata := project(d, t_f(left));

gateway_check := gateways(servicename='netacuity')[1].url;
gateway_url := IF(gateway_check='' or tribcode!='ipv1',ERROR(301,doxie.ErrorCodes(301)),gateway_check);

ret := risk_indicators.getNetAcuity(indata, gateways, dppa_purpose, glb_purpose);
//output(ret, named('ip2o_results'));
riskwise.Layout_IPVO final_format(ret le) := transform
	self.account := account_value;
	self.riskwiseid := '';
	self.ipcontinent := le.continent;
     self.ipcountry := StringLib.StringToUpperCase(le.countrycode);
	self.iproutingtype := if(Stringlib.StringFilterOut(le.ipaddr[1],'0123456789') = '', le.iproutingmethod, '');
	//self.ipstate := if(StringLib.StringToUpperCase(le.countrycode[1..2]) = 'US', StringLib.StringToUpperCase(le.state), '');
	region := StringLib.StringToUpperCase(le.ipregion);
	self.ipstate := if(region in ['?','NO REGION'], '', region);
	self.topleveldomain := StringLib.StringToUpperCase(le.topleveldomain);
     self.secondleveldomain := StringLib.StringToUpperCase(le.secondleveldomain);
	self.ipcity := StringLib.StringToUpperCase(le.ipcity);
     self.ipregiondesc := StringLib.StringToUpperCase(le.ipregion_description);
	self.latitude := le.latitude;
     self.longitude := le.longitude;
end;

final := project(ret, final_format(left));

//Log to Deltabase
Deltabase_Logging_prep := project(final, transform(Risk_Reporting.Layouts.LOG_Deltabase_Layout_Record,
																								 self.company_id := (Integer)CompanyID,
																								 self.login_id := _LoginID,
																								 self.product_id := Risk_Reporting.ProductID.RiskWise__RiskWiseMainIPVO,
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
																								 self.industry := Industry_Search[1].Industry,
																								 self.o_lexid := (Integer)left.riskwiseid,  //did
																								 self := left,
																								 self := [] ));
Deltabase_Logging := DATASET([{Deltabase_Logging_prep}], Risk_Reporting.Layouts.LOG_Deltabase_Layout);
// #stored('Deltabase_Log', Deltabase_Logging);

//Improved Scout Logging
IF(~DisableOutcomeTracking and Log_trib, OUTPUT(Deltabase_Logging, NAMED('LOG_log__mbs_transaction__log__scout')));

output(final, named('Results'));

royalties := Royalty.RoyaltyNetAcuity.GetOnlineRoyalties(gateways, indata, ret);
output(royalties,NAMED('RoyaltySet'));


endmacro;