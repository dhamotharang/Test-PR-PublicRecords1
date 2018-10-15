/*--SOAP--
<message name="St. Cloud Main Service CDxO">
	<part name="tribCode" type="xsd:string"/>
	<part name="account" type="xsd:string"/>
	<part name="ordertype" type="xsd:string"/>
	<part name="cmpy" type="xsd:string"/>
	<part name="cmpytype" type="xsd:string"/>
	<part name="first" type="xsd:string"/>
	<part name="last" type="xsd:string"/>
	<part name="addr" type="xsd:string"/>
	<part name="city" type="xsd:string"/>
	<part name="state" type="xsd:string"/>
	<part name="zip" type="xsd:string"/>
	<part name="hphone" type="xsd:string"/>
	<part name="wphone" type="xsd:string"/>
	<part name="socs" type="xsd:string"/>
	<part name="formerlast" type="xsd:string"/>
	<part name="email" type="xsd:string"/>
	<part name="drlc" type="xsd:string"/>
	<part name="drlcstate" type="xsd:string"/>
	<part name="ipaddr" type="xsd:string"/>
	<part name="avscode" type="xsd:string"/>
	<part name="channel" type="xsd:string"/>
	<part name="first2" type="xsd:string"/>
	<part name="last2" type="xsd:string"/>
	<part name="cmpy2" type="xsd:string"/>
	<part name="addr2" type="xsd:string"/> 
	<part name="city2" type="xsd:string"/>
	<part name="state2" type="xsd:string"/>
	<part name="zip2" type="xsd:string"/>
	<part name="hphone2" type="xsd:string"/>
	<part name="channel2" type="xsd:string"/>
	<part name="orderamt" type="xsd:string"/>
	<part name="numitems" type="xsd:string"/>
	<part name="orderdate" type="xsd:string"/>
	<part name="cidcode" type="xsd:string"/>
	<part name="shipmode" type="xsd:string"/>
	<part name="pymtmethod" type="xsd:string"/>
	<part name="productcode" type="xsd:string"/>
	<part name="addrstatusflag" type="xsd:string"/>
	<part name="addrstatusflag2" type="xsd:string"/>
	<part name="hphone3" type="xsd:string"/>
	<part name="email2" type="xsd:string"/>
	<part name="score" type="xsd:string"/>
	<part name="score2" type="xsd:string"/>
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
/*--INFO-- Migration product (CDxO)
'nd03','nd04','nd05', 'nd06','nd10', 'nd11' */


import address, Risk_Indicators, seed_files, gateway, royalty, Inquiry_AccLogs, Risk_Reporting, STD;   


export RiskWiseMainCDxO := MACRO

// Can't have duplicate definitions of Stored with different default values, 
// so add the default to #stored to eliminate the assignment of a default value.
#stored('GLBPurpose',RiskWise.permittedUse.fraudGLBA);
#stored('DataRestrictionMask',risk_indicators.iid_constants.default_DataRestriction);

/* Force layout of WsECL page */
#WEBSERVICE(FIELDS(
	'tribCode',
	'account',
	'ordertype',
	'cmpy',
	'cmpytype',
	'first',
	'last',
	'addr',
	'city',
	'state',
	'zip',
	'hphone',
	'wphone',
	'socs',
	'formerlast',
	'email',
	'drlc',
	'drlcstate',
	'ipaddr',
	'avscode',
	'channel',
	'first2',
	'last2',
	'cmpy2',
	'addr2', 
	'city2',
	'state2',
	'zip2',
	'hphone2',
	'channel2',
	'orderamt',
	'numitems',
	'orderdate',
	'cidcode',
	'shipmode',
	'pymtmethod',
	'productcode',
	'addrstatusflag',
	'addrstatusflag2',
	'hphone3',
	'email2',
	'score',
	'score2',
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
	Industry_Search := Inquiry_AccLogs.Key_Inquiry_industry_use_vertical_login(FALSE)(s_company_id = CompanyID and s_product_id = (String)Risk_Reporting.ProductID.RiskWise__RiskWiseMainCDxO);
/* ************* End Scout Fields **************/

string4  tribCode_value := '' 		: stored('tribcode');
string30 account_value := '' 			: stored('account');
string1  ordertype_value := ''		: stored('ordertype');
string30 cmpy_value := ''   			: stored('cmpy');
string1  cmpytype_value := ''			: stored('cmpytype');
string15 first_value := ''     		: stored('first');
string20 last_value := ''     		: stored('last');
string50 addr_value := ''    			: stored('addr');
string30 city_value := ''      		: stored('city');
string2  state_value := ''      		: stored('state');
string5  zip_value := ''      		: stored('zip');
string10 hphone_value := ''   		: stored('hphone');
string10 wphone_value := ''  			: stored('wphone');
string9  socs_value := ''      		/*: stored('socs')*/;	// no social on input
string20 formerlast_value := ''   		: stored('formerlast');
string50 email_value := ''  			: stored('email');
string20 drlc_value := ''     		: stored('drlc');
string2  drlcstate_value := ''    		: stored('drlcstate');
string45 ipaddr_value := ''      		: stored('ipaddr');	
string1  avscode_value := ''			: stored('avscode');
string2  channel_value := ''			: stored('channel');

// SECOND INPUT
string15 first2_value := ''     		: stored('first2');
string20 last2_value := ''     		: stored('last2');
string30 cmpy2_value := ''   			: stored('cmpy2');
string50 addr2_value := ''    		: stored('addr2');
string30 city2_value := ''      		: stored('city2');
string2  state2_value := ''      		: stored('state2');
string5  zip2_value := ''      		: stored('zip2');
string10 hphone2_value := ''   		: stored('hphone2');
string2  channel2_value := ''			: stored('channel2');
string6  orderamt_value := ''			: stored('orderamt');
string3  numitems_value := ''			: stored('numitems');
string8  orderdate_value := ''		: stored('orderdate');
string4  cidcode_value := ''			: stored('cidcode');
string2  shipmode_value := ''			: stored('shipmode');
string2  pymtmethod_value := ''		: stored('pymtmethod');
string2  productcode_value := ''		: stored('productcode');
string4  score1_value := ''			: stored('score1');
string4  score2_value := ''			: stored('score2');

// nd05 fields -- nothing is done with these as of now -- AES, 04Jun08
string addrstatusflag_value  := '' : stored('addrstatusflag');
string addrstatusflag2_value := '' : stored('addrstatusflag2');
string hphone3_value         := '' : stored('hphone3');
string email2_value          := '' : stored('email2');


unsigned1 DPPA_Purpose := RiskWise.permittedUse.fraudDPPA : stored('DPPAPurpose');
unsigned1 GLB_Purpose := RiskWise.permittedUse.fraudGLBA : stored('GLBPurpose');

unsigned3 history_date := 999999  		: stored('HistoryDateYYYYMM');
boolean   runSeed_value := false 		: stored('runSeed');

string DataRestriction := risk_indicators.iid_constants.default_DataRestriction : stored('DataRestrictionMask');
string DataPermission  := Risk_Indicators.iid_constants.default_DataPermission : stored('DataPermissionMask');
gateways_in := Gateway.Configuration.Get();

unsigned1 ofac_version      := 1        : stored('OFACVersion');
include_ofac := if(ofac_version = 1, false, true);
global_watchlist_threshold := if(ofac_version in [1, 2, 3], 0.84, 0.85);

tribCode := StringLib.StringToLowerCase(tribCode_value);
boolean Log_trib := tribCode in ['nd05', 'nd11'];

netAcuitySet := ['nd03', 'nd04', 'nd05', 'nd06', 'nd10', 'nd11'];

Gateway.Layouts.Config gw_switch(gateways_in le) := TRANSFORM
	self.servicename := le.servicename;
	self.url := map(tribcode in netAcuitySet and Gateway.Configuration.IsNetAcuity(le.servicename) => le.url, 
                  tribcode in ['nd11'] and le.servicename = 'bridgerwlc' => le.url, // included bridger gateway to be able to hit OFAC v4
                  ''); // default to no gateway call			 
	self := le;
END;
gateways := project(gateways_in, gw_switch(left));

if( ofac_version = 4 and not exists(gateways(servicename = 'bridgerwlc')) , fail(Risk_Indicators.iid_constants.OFAC4_NoGateway));

productSet := ['nd03','nd04','nd05', 'nd06','nd10', 'nd11'];

d := dataset([{0}],RiskWise.Layout_SD1I);

RiskWise.Layout_CD2I addseq(d l, INTEGER C) := TRANSFORM
	self.seq := C;
	self.account := account_value;
	self.ordertype := ordertype_value;
	self.cmpy := cmpy_value;
	self.cmpytype := cmpytype_value;
	self.first := first_value;
	self.last := last_value;
	self.addr := addr_value;
	self.city := city_value;
	self.state := state_value;
	self.zip := zip_value;
	self.hphone := hphone_value;
	self.wphone := wphone_value;
	self.socs := socs_value;
	self.formerlast := formerlast_value;
	self.email := email_value;
	self.drlc := drlc_value;
	self.drlcstate := drlcstate_value;
	self.ipaddr := ipaddr_value;
	self.avscode := avscode_value;
	self.channel := channel_value;
	self.first2 := first2_value;  
	self.last2 := last2_value;
	self.cmpy2 := cmpy2_value;
	self.addr2 := addr2_value;
	self.city2 := city2_value;
	self.state2 := state2_value;
	self.zip2 := zip2_value;
	self.hphone2 := hphone2_value;
	self.channel2 := channel2_value;
	self.orderamt := orderamt_value;
	self.numitems := numitems_value;
	self.orderdate := orderdate_value;
	self.cidcode := cidcode_value;
	self.shipmode := shipmode_value;
	self.pymtmethod := pymtmethod_value;
	self.prodcode := productcode_value;
	self.score1 := score1_value;
	self.score2 := score2_value;
	self.historydate := history_date;
	// TODO: add nd05 fields
END;
f := PROJECT(d, addseq(LEFT,COUNTER));


seed_files.mac_query_seedfiles(socs_value, 'cd1o', 'cd2i', '003', seed_out);

RiskWise.Layout_CDxO format_seed(seed_out le) := transform
	self.account := account_value;
	self := le;
	self := [];
end;
final_seed := if(runSeed_value, project(seed_out, format_seed(left)), dataset([], riskwise.Layout_CDxO));


/* VALIDATION */
		/* output(DataRestriction, named('DataRestriction'));  /* *****  Extra Output for debugging  ***** */
		/* output(DataPermission, named('DataPermission'));  /* *****  Extra Output for debugging  ***** */
// finalAnswer := RiskWise.CDxO_Function(f, gateways, GLB_Purpose, DPPA_Purpose, tribCode, DataRestriction, DataPermission);	   
// output(finalAnswer, named('Results'));


/* PRODUCTION */
finalAnswer := if(tribCode in productSet,
			   if(count(final_seed)>0 and runSeed_value, final_seed, if(tribCode in ['nd03','nd04','nd05','nd06'] or (tribCode in ['nd10','nd11'] and ordertype_value<>'0'), 
															RiskWise.CDxO_Function(f, gateways, GLB_Purpose, DPPA_Purpose, tribCode, ofac_version, include_ofac, global_watchlist_threshold, DataRestriction, DataPermission),
															RiskWise.CDxO_Business_Function(f, gateways, GLB_Purpose, DPPA_Purpose, tribCode, ofac_version, include_ofac, global_watchlist_threshold, DataRestriction, DataPermission))),
			   dataset([], riskwise.Layout_CDxO));				 
				 
output(finalAnswer, named('Results'));

dIPOut := project(finalAnswer, TRANSFORM(Royalty.RoyaltyNetAcuity.IPData, 
						SELF.Royalty_NAG := LEFT.billing(stringlib.stringtouppercase(name)='NA99')[1].callcount; 
						SELF := [];));
royalties := IF(tribCode in productSet, Royalty.RoyaltyNetAcuity.GetOnlineRoyalties(gateways, f, dIPOut, TRUE));
output(royalties,NAMED('RoyaltySet'));

//Log to Deltabase
Deltabase_Logging_prep := project(finalAnswer, transform(Risk_Reporting.Layouts.LOG_Deltabase_Layout_Record,
																								 self.company_id := (Integer)CompanyID,
																								 self.login_id := _LoginID,
																								 self.product_id := Risk_Reporting.ProductID.RiskWise__RiskWiseMainCDxO,
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
																								 self.i_ssn := socs_value, //social intentionally blanked out
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
																								 self.o_reason_1_5 := left.reason5,
																								 self.o_reason_1_6 := left.reason6,
																								 self.o_score_2    := left.score3,
																								 self.o_reason_2_1 := left.reason7,
																								 self.o_reason_2_2 := left.reason8,
																								 self.o_reason_2_3 := left.reason9,
																								 self.o_reason_2_4 := left.reason10,
																								 self.o_reason_2_5 := left.reason11,
																								 self.o_reason_2_6 := left.reason12,
																								 self.o_lexid := (Integer)left.riskwiseid,  //did
																								 self := left,
																								 self := [] ));
Deltabase_Logging := DATASET([{Deltabase_Logging_prep}], Risk_Reporting.Layouts.LOG_Deltabase_Layout);
// #stored('Deltabase_Log', Deltabase_Logging);

//Improved Scout Logging
IF(~DisableOutcomeTracking and Log_trib and ~runSeed_value, OUTPUT(Deltabase_Logging, NAMED('LOG_log__mbs_transaction__log__scout')));

ENDMACRO;
