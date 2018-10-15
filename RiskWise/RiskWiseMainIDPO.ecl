/*--SOAP--
<message name="St. Cloud Main Service IDPO">
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
	<part name="drlc" type="xsd:string"/>
	<part name="drlcstate" type="xsd:string"/>
	<part name="DPPAPurpose" type="xsd:byte"/>
	<part name="GLBPurpose" type="xsd:byte"/>
	<part name="HistoryDateYYYYMM" type="xsd:integer"/>
	<part name="DataRestrictionMask" type="xsd:string"/>
	<part name="DataPermissionMask" type="xsd:string"/>
	<part name="runSeed" type="xsd:boolean"/>
	<part name="OFACversion" type="xsd:unsignedInt"/>
	<part name="gateways" type="tns:XmlDataSet" cols="70" rows="25"/>
	<part name="OutcomeTrackingOptOut" type="xsd:boolean"/>
 </message>
*/
/*--INFO-- Migration to Warmer Climates (IDPO) */

import address, Risk_Indicators, seed_files, models, gateway;

export RiskWiseMainIDPO := MACRO

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
	'drlc',
	'drlcstate',
	'DPPAPurpose',
	'GLBPurpose',
	'HistoryDateYYYYMM',
	'DataRestrictionMask',
	'DataPermissionMask',
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
	Industry_Search := Inquiry_AccLogs.Key_Inquiry_industry_use_vertical_login(FALSE)(s_company_id = CompanyID and s_product_id = (String)Risk_Reporting.ProductID.RiskWise__RiskWiseMainIDPO);
/* ************* End Scout Fields **************/

string4  tribCode_value := '' 	: stored('tribcode');
string30 account_value := '' 		: stored('account');
string15 first_value := ''     	: stored('first');
string1  middleini_value := ''  : stored('middleini');
string20 last_value := ''     	: stored('last');
string50 addr_value := ''    		: stored('addr');
string30 city_value := ''      	: stored('city');
string2  state_value := ''      : stored('state');
string9  zip_value := ''      	: stored('zip');
string9  socs_value := ''      	: stored('socs');
string8  dob_value := ''      	: stored('dob');
STRING20 drlc_value := ''     	: stored('drlc');
STRING2  drlcstate_value := ''  : stored('drlcstate');
string10 hphone_value := ''   	: stored('hphone');
STRING10 wphone_value := ''  		: stored('wphone');

unsigned1 DPPA_Purpose := RiskWise.permittedUse.fraudDPPA : stored('DPPAPurpose');
unsigned1 GLB_Purpose := RiskWise.permittedUse.fraudGLBA : stored('GLBPurpose');
unsigned3 history_date := 999999  	: stored('HistoryDateYYYYMM');
boolean runSeed_value := false : stored('runSeed');
string DataRestriction := risk_indicators.iid_constants.default_DataRestriction : stored('DataRestrictionMask');
string10 DataPermission := Risk_Indicators.iid_constants.default_DataPermission : stored('DataPermissionMask');
unsigned1 ofac_version_       := 1        : stored('OFACVersion');
gateways_in := Gateway.Configuration.Get();

tribCode := StringLib.StringToLowerCase(tribCode_value);
boolean Log_trib := tribcode in ['idp1'];

targusGatewaySet := ['idp1','idp3'];
attusSet := [];

Gateway.Layouts.Config gw_switch(gateways_in le) := transform
	self.servicename := le.servicename;
	self.url := map(tribcode in attusSet and le.servicename = 'attus' => le.url,  // attus gateway
				 tribcode in targusGatewaySet and le.servicename = 'targus' => le.url,  // targus gateway
         tribcode in ['idp1'] and le.servicename = 'bridgerwlc' => le.url, // included bridger gateway to be able to hit OFAC v4
				 ''); // default to no gateway call			 
	self := le;
end;
gateways := project(gateways_in, gw_switch(left));


rec := record
	unsigned4 seq;
end;
d := dataset([{0}],rec);


risk_indicators.layout_input into(rec l, INTEGER C) := transform
	clean_a2 := Risk_Indicators.MOD_AddressClean.clean_addr(addr_value, city_value, state_value, zip_value);

	ssn_val := RiskWise.cleanSSN( socs_value );
	hphone_val := RiskWise.cleanPhone( hphone_value );
	wphone_val := RiskWise.cleanPhone( wphone_value );
	dob_val := RiskWise.cleanDOB( dob_value );
	dl_num_clean := RiskWise.cleanDL_num( drlc_value );

	
	self.seq := C;
	self.historydate := history_date;
	self.ssn := ssn_val;
	self.dob := dob_val;
	self.phone10 := hphone_val;	
	self.wphone10 := wphone_val;
	
	self.fname := stringlib.stringtouppercase(first_value);
	self.mname := stringlib.stringtouppercase(middleini_value);
	self.lname := stringlib.stringtouppercase(last_value);
	
	SELF.in_streetAddress := addr_value;
	SELF.in_city := city_value;
	SELF.in_state := state_value;
	SELF.in_zipCode := zip_value;
	
	self.prim_range := clean_a2[1..10];
	self.predir := clean_a2[11..12];
	self.prim_name := clean_a2[13..40];
	self.addr_suffix := clean_a2[41..44];
	self.postdir := clean_a2[45..46];
	self.unit_desig := clean_a2[47..56];
	self.sec_range := clean_a2[57..64];
	self.p_city_name := clean_a2[90..114];
	self.st := clean_a2[115..116];
	self.z5 := IF(clean_a2[117..121]<>'', clean_a2[117..121], zip_value[1..5]);	// use the input zip if cass zip is empty
	self.zip4 := IF(clean_a2[122..125]<>'', clean_a2[122..125], zip_value[6..9]);	// use the input zip if cass zip is empty
	self.lat := clean_a2[146..155];
	self.long := clean_a2[156..166];
	self.addr_type := clean_a2[139];
	self.addr_status := clean_a2[179..182];
	self.county := clean_a2[143..145];
	self.geo_blk := clean_a2[171..177];
		
	SELF.dl_number := stringlib.stringtouppercase(dl_num_clean);
	SELF.dl_state := stringlib.stringtouppercase(drlcstate_value);
	
	self := [];
END;
prep := PROJECT(d,into(LEFT,COUNTER));


isUtility := false;
ln_branded := false;
ofac_only := true;
suppressNearDups := true;
require2Ele := false;
from_BIID := false;
isFCRA := false;
ExcludeWatchLists := false;
from_IT1O := false;
ofac_version := ofac_version_;
include_ofac := if(ofac_version = 1, false, true);
include_additional_watchlists := false;
global_watchlist_threshold := if(ofac_version in [1, 2, 3], 0.84, 0.85);
dob_radius := -1;
BSversion := 1;
runSSNCodes := true;
runBestAddrCheck := true;
runChronoPhoneLookup := true;
runAreaCodeSplitSearch := true;
allowCellPhones := true;

if( ofac_version = 4 and not exists(gateways(servicename = 'bridgerwlc')) , fail(Risk_Indicators.iid_constants.OFAC4_NoGateway));

ret := risk_indicators.InstantID_Function(prep, gateways, DPPA_Purpose, GLB_Purpose, isUtility, ln_branded, ofac_only, suppressNearDups, require2Ele,
																					from_BIID, isFCRA, ExcludeWatchLists, from_IT1O, ofac_version, include_ofac, include_additional_watchlists, global_watchlist_threshold,
																					dob_radius, BSversion, runSSNCodes, runBestAddrCheck, runChronoPhoneLookup,	runAreaCodeSplitSearch, allowCellphones,
																					in_DataRestriction := DataRestriction, in_DataPermission := DataPermission);

//don't track royalties for testseeds
dRoyalties := if(runSeed_value, dataset([], Royalty.Layouts.Royalty),
	Royalty.RoyaltyTargus.GetOnlineRoyalties(UNGROUP(ret), src, TargusType, TRUE, FALSE, FALSE, TRUE));

seed_files.mac_query_seedfiles(socs_value, 'idpo', 'idpi', '001', seed_out);

RiskWise.Layout_IDPO format_seed(seed_out le) := transform
	self.account := account_value;
	self.ri := [];
	self.billing := dataset([],risk_indicators.Layout_Billing);
	self := le;
end;
final_seed := if(runSeed_value, project(seed_out, format_seed(left)), dataset([], riskwise.Layout_IDPO));


clam := risk_indicators.Boca_Shell_Function(group(sort(ret,seq),seq), gateways, dppa_purpose, glb_purpose, isUtility, ln_branded,  
									false, false, false, false, DataRestriction := DataRestriction, DataPermission := DataPermission);



model := case( tribcode,
	'idp3' => ungroup(models.CEN509_0_0(clam)), // this to be changed when the proper idp3 model comes in
	dataset( [], models.Layout_ModelOut )
);


RiskWise.Layout_IDPO format_out(Risk_Indicators.Layout_Output le, model rt) := TRANSFORM
	SELF.account := account_value;
	SELF.riskwiseid := (STRING)le.did;	// outputting the did here, doug should not use this

	SELF.socsverlevel := (STRING)le.socsverlevel;
	SELF.phoneverlevel := (STRING)le.phoneverlevel;
	
	SELF.correctdob := le.correctdob;
	SELF.correcthphone := le.correcthphone;
	SELF.correctsocs := le.correctssn;
	SELF.correctaddr := le.correctaddr;
	
	SELF.dirsfirst := le.dirsfirst;
	SELF.dirslast := le.dirslast;
	SELF.dirsaddr := Risk_Indicators.MOD_AddressClean.street_address('',le.dirs_prim_range,le.dirs_predir,le.dirs_prim_name,
										le.dirs_suffix,le.dirs_postdir,le.dirs_unit_desig,le.dirs_sec_range);
	SELF.dirscity := le.dirscity;
	SELF.dirsstate := le.dirsstate;
	SELF.dirszip := le.dirszip;
	
	SELF.nameaddrphone := MAP(le.phonever_type='U' => le.utiliphone,
						 le.phonever_type='A' => le.dirsaddr_phone,  
						 le.phoneaddr_phonecount >= le.utiliaddr_phonecount => le.dirsaddr_phone,
						 le.utiliphone);
						 
	SELF.altlast := if(le.socsverlevel IN [4,7,9,10,11,12], le.altlast, '');
	SELF.altlast2 := if(le.socsverlevel IN [4,7,9,10,11,12], le.altlast2, '');
	SELF.correctlast := le.correctlast;
	
	verlast := IF(le.socsverlevel in [2,5,7,8,9,11,12] OR le.phoneverlevel in [2,5,7,8,9,11,12], le.combo_last, '');
	veraddr := IF(le.socsverlevel in [3,5,6,8,10,11,12] OR le.phoneverlevel in [3,5,6,8,10,11,12], 
														Risk_Indicators.MOD_AddressClean.street_address('',le.combo_prim_range,
														le.combo_predir,le.combo_prim_name,le.combo_suffix,le.combo_postdir,le.combo_unit_desig,le.combo_sec_range),'');


	self.score := case( tribcode,
		'idp3' => (string)(integer)rt.score,
		Risk_Indicators.cviScore(le.phoneverlevel,le.socsverlevel,le,SELF.correctsocs,self.correctaddr,self.correcthphone,'',veraddr,verlast,true)
	);
	
	self.ri    := case( tribcode,
		'idp3' => rt.ri,
		RiskWise.patriotReasonCodes( le, 6, true )
	);
	
	SELF.reason1 := self.ri[1].hri;
	SELF.reason2 := self.ri[2].hri;
	SELF.reason3 := self.ri[3].hri;
	SELF.reason4 := self.ri[4].hri;
	SELF.reason5 := self.ri[5].hri;
	SELF.reason6 := self.ri[6].hri;

		
	//SELF.billing := IF(StringLib.StringFind(le.sources,'EQ',1) <> 0, dataset([{'equifax',1}], risk_indicators.Layout_Billing), dataset([],risk_indicators.Layout_Billing));
	SELF := [];
END;
finalOutput := join(ret, model, left.seq=right.seq, format_out(left,right), left outer);

final := if(tribcode in ['idp1','idp3'], 
		  if(count(final_seed)>0 and runSeed_value, final_seed, ungroup(finalOutput)), 
			dataset([], RiskWise.Layout_IDPO));

//Log to Deltabase
Deltabase_Logging_prep := project(final, transform(Risk_Reporting.Layouts.LOG_Deltabase_Layout_Record,
																								 self.company_id := (Integer)CompanyID,
																								 self.login_id := _LoginID,
																								 self.product_id := Risk_Reporting.ProductID.RiskWise__RiskWiseMainIDPO,
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
																								 self.o_score_1    := left.score,
																								 self.o_reason_1_1 := left.reason1,
																								 self.o_reason_1_2 := left.reason2,
																								 self.o_reason_1_3 := left.reason3,
																								 self.o_reason_1_4 := left.reason4,
																								 self.o_reason_1_5 := left.reason5,
																								 self.o_reason_1_6 := left.reason6,
																								 self.o_lexid := (Integer)left.riskwiseid,  //did
																								 self := left,
																								 self := [] ));
Deltabase_Logging := DATASET([{Deltabase_Logging_prep}], Risk_Reporting.Layouts.LOG_Deltabase_Layout);
// #stored('Deltabase_Log', Deltabase_Logging);

//Improved Scout Logging
IF(~DisableOutcomeTracking and Log_trib and ~runSeed_value, OUTPUT(Deltabase_Logging, NAMED('LOG_log__mbs_transaction__log__scout')));

output(final, named('Results'));
output(dRoyalties, named('RoyaltySet'));

ENDMACRO;
// RiskWise.RiskWiseMainIDPO()