/*--SOAP--
<message name="Business InstantID Premium">
	<part name="tribcode" type="xsd:string"/>
	<part name="account" type="xsd:string"/>
	<part name="cmpy" type="xsd:string"/>
	<part name="dbaname" type="xsd:string"/>
	<part name="cmpyaddr" type="xsd:string"/>
	<part name="cmpycity" type="xsd:string"/>
	<part name="cmpystate" type="xsd:string"/>
	<part name="cmpyzip" type="xsd:string"/>
	<part name="cmpytype" type="xsd:string"/>
	<part name="fein" type="xsd:string"/>
	<part name="cmpyphone1" type="xsd:string"/>
	<part name="cmpyphone2" type="xsd:string"/>
	<part name="cmpyphone3" type="xsd:string"/>
	<part name="website" type="xsd:string"/>
	<part name="first" type="xsd:string"/>
	<part name="last" type="xsd:string"/>
	<part name="authreptitle" type="xsd:string"/>
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
	<part name="runSeed" type="xsd:boolean"/>
	<part name = 'GLBPurpose'  type = 'xsd:byte'/>
	<part name = 'DPPAPurpose' type = 'xsd:byte'/>
	<part name="HistoryDateYYYYMM" type="xsd:integer"/>
	<part name="DataRestrictionMask" type="xsd:string"/>
	<part name="DataPermissionMask" type="xsd:string"/>
	<part name="OFACversion" type="xsd:unsignedInt"/>
	<part name="gateways" type="tns:XmlDataSet" cols="70" rows="25"/>
	<part name="OutcomeTrackingOptOut" type="xsd:boolean"/>
 </message>
*/
/*--INFO-- Migrating pb01 and pb02 to boca.  */

import Gateway, Risk_Indicators, Risk_Reporting, Riskwise, Royalty, Seed_Files;

export RiskwiseMainPB1O := MACRO

// Can't have duplicate definitions of Stored with different default values, 
// so add the default to #stored to eliminate the assignment of a default value.
#stored('GLBPurpose',RiskWise.permittedUse.fraudGLBA);
#stored('DataRestrictionMask',risk_indicators.iid_constants.default_DataRestriction);

/* Force layout of WsECL page */
#WEBSERVICE(FIELDS(
	'tribcode',
	'account',
	'cmpy',
	'dbaname',
	'cmpyaddr',
	'cmpycity',
	'cmpystate',
	'cmpyzip',
	'cmpytype',
	'fein',
	'cmpyphone1',
	'cmpyphone2',
	'cmpyphone3',
	'website',
	'first',
	'last',
	'authreptitle',
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
	'runSeed',
	'GLBPurpose',
	'DPPAPurpose',
	'HistoryDateYYYYMM',
	'DataRestrictionMask',
	'DataPermissionMask',
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
	Industry_Search := Inquiry_AccLogs.Key_Inquiry_industry_use_vertical_login(FALSE)(s_company_id = CompanyID and s_product_id = (String)Risk_Reporting.ProductID.RiskWise__RiskWiseMainPB1O);
/* ************* End Scout Fields **************/

string4  tribCode_value := '' 	: stored('tribcode');	
string30 account_value := '' 		: stored('account');
STRING30 cmpyname_value := ''   	: stored('cmpy');
string30 dbaname_value := ''  	: stored('dbaname');
string50 cmpyaddr_value := ''    	: stored('cmpyaddr');
string30 cmpycity_value := ''      : stored('cmpycity');
string2  cmpystate_value := ''     : stored('cmpystate');
string9  cmpyzip_value := ''      	: stored('cmpyzip');
string1  cmpytype_value := ''      : stored('cmpytype');
string9  fein_value := ''      	: stored('fein');
string10 cmpyphone1_value := ''   	: stored('cmpyphone1');
STRING10 cmpyphone2_value := ''  	: stored('cmpyphone2');
STRING10 cmpyphone3_value := ''  	: stored('cmpyphone3');
string50 website_value := ''  	: stored('website');
string15 fname_value := ''     	: stored('first');
string20 lname_value := ''     	: stored('last');
STRING15 authreptitle_value := ''  : stored('authreptitle');
string50 addr_value := ''    		: stored('addr');
string30 city_value := ''      	: stored('city');
string2  state_value := ''      	: stored('state');
string9  zip_value := ''      	: stored('zip');
string9  socs_value := ''      	: stored('socs');
string8  dob_value := ''      	: stored('dob');
string10 hphone_value := ''   	: stored('hphone');
STRING10 wphone_value := ''  		: stored('wphone');
STRING20 dl_number_value := ''     : stored('drlc');
STRING2  dl_state_value := ''      : stored('drlcstate');
string20 email_value := ''  	: stored('email');
unsigned1 DPPA_Purpose := RiskWise.permittedUse.fraudDPPA : stored('DPPAPurpose');
unsigned1 GLB_Purpose := RiskWise.permittedUse.fraudGLBA : stored('GLBPurpose');
unsigned3 history_date := 999999 	: stored('HistoryDateYYYYMM');
boolean  runSeed_value := false 	: stored('runSeed');
string DataRestriction := risk_indicators.iid_constants.default_DataRestriction : stored('DataRestrictionMask');

string50 DataPermission := Risk_Indicators.iid_constants.default_DataPermission : stored('DataPermissionMask');
unsigned1 OFACversion      := 1        : stored('OFACVersion');
gateways_in := Gateway.Configuration.Get();

tribcode := StringLib.StringToLowerCase(tribCode_value);
boolean Log_trib := tribcode in ['pb01'];

Gateway.Layouts.Config gw_switch(gateways_in le) := transform
	self.servicename := le.servicename;
	self.url := map(tribcode='pb01' and le.servicename in ['targus'] => le.url,  // use targus gateway if needed
                  tribcode in ['pb01', 'pb02'] and le.servicename = 'bridgerwlc' => le.url, // bridger gateway
                                                                          ''); // default to no gateway call			 
	self := le;
end;

gateways := project(gateways_in, gw_switch(left));

if( OFACversion = 4 and not exists(gateways(servicename = 'bridgerwlc')) , fail(Risk_Indicators.iid_constants.OFAC4_NoGateway));

d := dataset([{0}],RiskWise.Layout_PB1I);
RiskWise.Layout_PB1I addseq(d l, integer C) := transform
	self.seq := C;
	self.tribcode := tribcode;
	self.ACCOUNT := account_value;
     self.CMPY := cmpyname_value;
     self.DBANAME := dbaname_value;
     self.CMPYADDR := cmpyaddr_value;
     self.CMPYCITY := cmpycity_value;
     self.CMPYSTATE := cmpystate_value;
     self.CMPYZIP := cmpyzip_value;
     self.CMPYTYPE := cmpytype_value;
     self.FEIN := fein_value;
     self.CMPYPHONE1 := cmpyphone1_value;
     self.CMPYPHONE2 := cmpyphone2_value;
     self.CMPYPHONE3 := cmpyphone3_value;
     self.WEBSITE := website_value;
     self.FIRST := fname_value;
     self.LAST := lname_value;
     self.AUTHREPTITLE := authreptitle_value;
     self.ADDR := addr_value;
     self.CITY := city_value;
     self.STATE := state_value;
     self.ZIP := zip_value;
     self.SOCS := socs_value;
     self.DOB := dob_value;
     self.HPHONE := hphone_value;
     self.WPHONE := wphone_value;
     self.DRLC := dl_number_value;
     self.DRLCSTATE := dl_state_value;
     self.EMAIL := email_value;
		 self.historydate := history_date;
end;
f := project(d, addseq(LEFT,COUNTER));

critter := if(tribcode='pb02', '002', '001');
seed_files.mac_query_seedfiles(fein_value, 'pb1o', 'pb1i', critter, seed_out);

RiskWise.Layout_PB1O format_seed(seed_out le) := transform
	self.account := account_value;
	self := le;
end;
final_seed := if(runSeed_value, project(seed_out, format_seed(left)), dataset([], riskwise.Layout_PB1O));

ret_pre := RiskWise.PB1O_Function(f, gateways, GLB_Purpose, DPPA_Purpose, DataRestriction := DataRestriction, DataPermission := DataPermission, OFACversion := OFACversion);

ret := if(tribcode in ['pb01', 'pb02'], 
		if(count(final_seed)>0 and runSeed_value, final_seed, PROJECT( ret_pre, TRANSFORM( riskwise.layout_pb1o, SELF := LEFT, SELF := [] ) )), 
		dataset([{'',account_value}], riskwise.Layout_PB1O));
    
dRoyalties := 
  PROJECT(
    ret_pre,
    TRANSFORM( Royalty.Layouts.Royalty,
      SELF.royalty_type_code := LEFT.royalty_type_code_targus;
      SELF.royalty_type      := LEFT.royalty_type_targus;
      SELF.royalty_count     := LEFT.royalty_count_targus;
      SELF.non_royalty_count := LEFT.non_royalty_count_targus;
      SELF.count_entity      := LEFT.count_entity_targus;
    )
  );

//Log to Deltabase
Deltabase_Logging_prep := project(ret, transform(Risk_Reporting.Layouts.LOG_Deltabase_Layout_Record,
																								 self.company_id := (Integer)CompanyID,
																								 self.login_id := _LoginID,
																								 self.product_id := Risk_Reporting.ProductID.RiskWise__RiskWiseMainPB1O,
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
                                                 self.i_work_phone := wphone_value,
																								 self.i_tin := fein_value,
																								 self.i_bus_name := cmpyname_value,
																								 self.i_bus_address := cmpyaddr_value,
																								 self.i_bus_city := cmpycity_value,
																								 self.i_bus_state := cmpystate_value,
																								 self.i_bus_zip := cmpyzip_value, 
                                                 self.i_bus_phone := cmpyphone1_value,
																								 self.o_score_1    := left.score, //bvi
																								 self.o_reason_1_1 := left.reason1,
																								 self.o_reason_1_2 := left.reason2,
																								 self.o_reason_1_3 := left.reason3,
																								 self.o_reason_1_4 := left.reason4,
																								 self.o_reason_1_5 := left.reason5,
																								 self.o_reason_1_6 := left.reason6,
																								 self.o_score_2    := left.score4, //cvi
																								 self.o_reason_2_1 := left.reason9,
																								 self.o_reason_2_2 := left.reason10,
																								 self.o_reason_2_3 := left.reason11,
																								 self.o_reason_2_4 := left.reason12,
																								 self.o_reason_2_5 := left.reason13,
																								 self.o_reason_2_6 := left.reason14,
																								 self.o_lexid := (Integer)left.riskwiseid,  //bdid
																								 self := left,
																								 self := [] ));
Deltabase_Logging := DATASET([{Deltabase_Logging_prep}], Risk_Reporting.Layouts.LOG_Deltabase_Layout);
// #stored('Deltabase_Log', Deltabase_Logging);

//Improved Scout Logging
IF(~DisableOutcomeTracking and Log_trib and ~runSeed_value, OUTPUT(Deltabase_Logging, NAMED('LOG_log__mbs_transaction__log__scout')));

output(ret, named('Results'));
output(if(runSeed_value, DATASET([], Royalty.Layouts.Royalty), dRoyalties), named('RoyaltySet'));

ENDMACRO;
