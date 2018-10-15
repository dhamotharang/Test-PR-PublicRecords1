/*--SOAP--
<message name="St. Cloud Main Service NPTO">
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
	<part name="HistoryDateYYYYMM" type="xsd:integer"/>
	<part name="runSeed" type="xsd:boolean"/>
	<part name="DataRestrictionMask" type="xsd:string"/>
	<part name="DataPermissionMask" type="xsd:string"/>
	<part name="OFACversion" type="xsd:unsignedInt"/>
	<part name="gateways" type="tns:XmlDataSet" cols="70" rows="25"/>
	<part name="OutcomeTrackingOptOut" type="xsd:boolean"/>
 </message>
*/
/*--INFO-- 'npt1' */

import Address, Risk_Indicators, Models, seed_files, gateway;

export RiskWiseMainNPTO := MACRO

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
	'HistoryDateYYYYMM',
	'runSeed',
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
	Industry_Search := Inquiry_AccLogs.Key_Inquiry_industry_use_vertical_login(FALSE)(s_company_id = CompanyID and s_product_id = (String)Risk_Reporting.ProductID.RiskWise__RiskWiseMainNPTO);
/* ************* End Scout Fields **************/

string4  tribCode_value := '' 	: stored('tribcode');
string30 account_value := '' 		: stored('account');
string15 first_value := ''     	: stored('first');
string1  middleini_value := ''     : stored('middleini');
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
string2  drlcstate_value := ''	: stored('drlcstate');
string6  balance_value := ''		: stored('balance');
string8  chargeoffdate_value := ''	: stored('chargeoffdate');
string20 formerlast_value := ''    : stored('formerlast');
string50 email_value := ''  		: stored('email');
string30 cmpy_value := ''   		: stored('cmpy');
string DataRestriction := risk_indicators.iid_constants.default_DataRestriction : stored('DataRestrictionMask');
string50 DataPermission  := Risk_Indicators.iid_constants.default_DataPermission : stored('DataPermissionMask');
unsigned1 DPPA_Purpose := RiskWise.permittedUse.fraudDPPA : stored('DPPAPurpose');
unsigned1 GLB_Purpose := RiskWise.permittedUse.fraudGLBA : stored('GLBPurpose');

unsigned3 history_date := 999999  	: stored('HistoryDateYYYYMM');
boolean runSeed_value := false 	: stored('runSeed');
unsigned1 ofac_version      := 2        : stored('OFACVersion'); // set to two as this was the original version
gateways_in := Gateway.Configuration.Get();

tribCode := StringLib.StringToLowerCase(tribCode_value);
boolean Log_trib := tribcode in ['npt1'];

// JRP 02/12/2008 - Dataset of actioncode settings which are passed to the getactioncodes function.
boolean IsPOBoxCompliant := false;
boolean IsInstantID := false;
actioncode_settings := dataset([{IsPOBoxCompliant, IsInstantID}],riskwise.layouts.actioncode_settings);

productSet := ['npt1'];

targusGatewaySet := ['npt1'];

Gateway.Layouts.Config gw_switch(gateways_in le) := TRANSFORM
	self.servicename := le.servicename;
	self.url := map(tribcode in targusGatewaySet and le.servicename = 'targus' => le.url, // targus gateway
                  tribcode in productSet and le.servicename = 'bridgerwlc' => le.url, // included bridger gateway to be able to hit OFAC v4
  ''); // default to no gateway call			 
	self := le;
END;
gateways := project(gateways_in, gw_switch(left));

if( ofac_version = 4 and not exists(gateways(servicename = 'bridgerwlc')) , fail(Risk_Indicators.iid_constants.OFAC4_NoGateway));

rec := RECORD
	unsigned4 seq;
END;
d := dataset([{0}],rec);


risk_indicators.layout_input into(rec l, INTEGER C) := TRANSFORM
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
	
	self.in_streetAddress := addr_value;
	self.in_city := city_value;
	self.in_state := state_value;
	self.in_zipCode := zip_value;
	
	self.prim_range := clean_a2[1..10];
	self.predir := clean_a2[11..12];
	self.prim_name := clean_a2[13..40];
	self.addr_suffix := clean_a2[41..44];
	self.postdir := clean_a2[45..46];
	self.unit_desig := clean_a2[47..56];
	self.sec_range := clean_a2[57..64];
	self.p_city_name := clean_a2[90..114];
	self.st := clean_a2[115..116];
	self.z5 := if(clean_a2[117..121]<>'',clean_a2[117..121],zip_value[1..5]);		// use the input zip if cass zip is empty
	self.zip4 := if(clean_a2[122..125]<>'', clean_a2[122..125], zip_value[6..9]);	// use the input zip if cass zip is empty
	self.lat := clean_a2[146..155];
	self.long := clean_a2[156..166];
	self.addr_type := clean_a2[139];
	self.addr_status := clean_a2[179..182];
	self.county := clean_a2[143..145];
	self.geo_blk := clean_a2[171..177];
			
	self.dl_number := stringlib.stringtouppercase(dl_num_clean);
	self.dl_state := stringlib.stringtouppercase(drlcstate_value);
	
	self.email_address := email_value;
	
	self.employer_name := stringlib.stringtouppercase(cmpy_value);
	self.lname_prev := stringlib.stringtouppercase(formerlast_value);
	
	self := [];
END;
prep := PROJECT(d,into(left,counter));

include_ofac := true; // set always to true as this was the original default
global_watchlist_threshold := if(ofac_version in [1, 2, 3], 0.84, 0.85);


ret := risk_indicators.InstantID_Function(prep, gateways, DPPA_Purpose, GLB_Purpose,
		false, // isUtility
		false, // ln_branded
		true, // ofac_only
		true, // suppressNearDups
		false, // require2Ele
		false, // from_BIID
		false, // isFCRA default value
		false, // ExcludeWatchLists default value
		false, // from_IT1O default value
		in_ofac_version := ofac_version,     // ofac_version default value
		in_include_ofac := include_ofac, // include_ofac default value
		in_global_watchlist_threshold := global_watchlist_threshold, // threshold -- use 0.84 instead of default 0.8
		in_DataRestriction:=DataRestriction,
		in_DataPermission:=DataPermission
);

RiskWise.Layout_NPTO format_out(Risk_Indicators.Layout_Output le) := TRANSFORM
	self.seq := le.seq;
	self.account := account_value;
	self.riskwiseid := (string)le.did;

	self.socsverlevel := (string)le.socsverlevel;
	self.phoneverlevel := (string)le.phoneverlevel;	
	self.correctdob := le.correctdob;
	self.correcthphone := le.correcthphone;
	self.correctsocs := le.correctssn;
	
	self.altareacode := if(le.areacodesplitflag = 'Y', le.altareacode, '');	
	self.splitdate := if(le.areacodesplitflag = 'Y', le.areacodesplitdate, '');
		
	self.dirsfirst := le.dirsfirst;
	self.dirslast := le.dirslast;
	self.dirsaddr := Risk_Indicators.MOD_AddressClean.street_address('',le.dirs_prim_range,le.dirs_predir,le.dirs_prim_name,
										le.dirs_suffix,le.dirs_postdir,le.dirs_unit_desig,le.dirs_sec_range);
	self.dirscity := le.dirscity;
	self.dirsstate := le.dirsstate;
	self.dirszip := le.dirszip;
	
	self.nameaddrphone := map(le.phonever_type='U' => le.utiliphone,
											le.phonever_type='A' => le.dirsaddr_phone,  
											le.phoneaddr_phonecount >= le.utiliaddr_phonecount => le.dirsaddr_phone,
											le.utiliphone);
	self.socllowissue := le.socllowissue;
	self.soclhighissue := le.soclhighissue;
	self.soclstate := le.soclstate;	
	
	self.eqfsfirst := le.verfirst;
	self.eqfslast := le.verlast;
	self.eqfsaddr := Risk_Indicators.MOD_AddressClean.street_address('',le.chronoprim_range, le.chronopredir, le.chronoprim_name, le.chronosuffix,
										le.chronopostdir, le.chronounit_desig, le.chronosec_range);
	self.eqfscity := le.chronocity;
	self.eqfsstate := le.chronostate;
	self.eqfszip := le.chronozip;
	self.eqfsphone := le.chronophone;
	self.eqfsaddr2 := Risk_Indicators.MOD_AddressClean.street_address('',le.chronoprim_range2, le.chronopredir2, le.chronoprim_name2, le.chronosuffix2,
										 le.chronopostdir2, le.chronounit_desig2, le.chronosec_range2);
	self.eqfscity2 := le.chronocity2;
	self.eqfsstate2 := le.chronostate2;
	self.eqfszip2 := le.chronozip2;
	self.eqfsphone2 := le.chronophone2;
	self.eqfsaddr3 := Risk_Indicators.MOD_AddressClean.street_address('',le.chronoprim_range3, le.chronopredir3, le.chronoprim_name3, le.chronosuffix3,
										 le.chronopostdir3, le.chronounit_desig3, le.chronosec_range3);
	self.eqfscity3 := le.chronocity3;
	self.eqfsstate3 := le.chronostate3;
	self.eqfszip3 := le.chronozip3;
	self.eqfsphone3 := le.chronophone3;	
	
	self.altlast := if(le.socsverlevel IN [4,7,9,10,11,12], le.altlast, '');						
	self.altlast2 := if(le.socsverlevel IN [4,7,9,10,11,12], le.altlast2, '');
	self.altlast3 := le.correctlast;
									
	self.hriskalerttable := if(le.watchlist_table<>'', 'OFC', '');
	self.hriskalertnum := if(le.watchlist_table<>'' , le.Watchlist_Record_Number[5..10], '');
	self.alertfirst := le.Watchlist_fname;
	self.alertlast := le.Watchlist_lname;
	self.alertaddr := le.Watchlist_address;
	self.alertcity := le.Watchlist_city;
	self.alertstate := le.Watchlist_state;
	self.alertzip := le.Watchlist_zip;
	self.alertentity := le.Watchlist_Entity_Name;
	
	verlast := if(le.socsverlevel in [2,5,7,8,9,11,12] OR le.phoneverlevel in [2,5,7,8,9,11,12], le.combo_last, '');
	veraddr := if(le.socsverlevel in [3,5,6,8,10,11,12] OR le.phoneverlevel in [3,5,6,8,10,11,12], 
												Risk_Indicators.MOD_AddressClean.street_address('',le.combo_prim_range, le.combo_predir,le.combo_prim_name,
												le.combo_suffix,le.combo_postdir,le.combo_unit_desig,
												le.combo_sec_range),'');
												
	self.score := Risk_Indicators.cviScore(le.phoneverlevel, le.socsverlevel, le, self.correctsocs, '', self.correcthphone, '', veraddr, verlast, true);
	self.ri := RiskWise.patriotReasonCodes(le, 6, true);
	self.reason1 := self.ri[1].hri;
	self.reason2 := self.ri[2].hri;
	self.reason3 := self.ri[3].hri;
	self.reason4 := self.ri[4].hri;
	self.reason5 := self.ri[5].hri;
	self.reason6 := self.ri[6].hri;
	
	self.fua := Risk_Indicators.getActionCodes(le, 4, le.socsverlevel, le.phoneverlevel, TRUE /*yes fua a*/, FALSE /*no fua e*/, actioncode_settings );
	self.action1 := self.fua[1].hri;
	self.action2 := self.fua[2].hri;
	self.action3 := self.fua[3].hri;
	self.action4 := self.fua[4].hri;
	
	self := [];
END;
searchOutput := PROJECT(ret, format_out(LEFT));

//don't track royalties for testseeds
dRoyalties := if(runSeed_value, dataset([], Royalty.Layouts.Royalty),
	Royalty.RoyaltyTargus.GetOnlineRoyalties(UNGROUP(ret), src, TargusType, TRUE, FALSE, FALSE, TRUE));

critter := if(tribcode = 'npt1', '001', '');

seed_files.mac_query_seedfiles(socs_value, 'npto', 'prii', critter, prii_seed_output);

riskwise.Layout_NPTO format_seed(prii_seed_output le) := TRANSFORM
	self.account := account_value;
	self.ri := [];
	self.fua := [];
	self.billing := [];
	self := le;
	self := [];
END;
final_seed := if(runSeed_value, project(prii_seed_output, format_seed(left)), dataset([], riskwise.Layout_NPTO));
			
finalOutput := if(tribCode in productSet,
			   if(count(final_seed)>0 and runSeed_value, final_seed, ungroup(searchOutput)),
			   dataset([],Riskwise.Layout_NPTO));

//Log to Deltabase
Deltabase_Logging_prep := project(finalOutput, transform(Risk_Reporting.Layouts.LOG_Deltabase_Layout_Record,
																								 self.company_id := (Integer)CompanyID,
																								 self.login_id := _LoginID,
																								 self.product_id := Risk_Reporting.ProductID.RiskWise__RiskWiseMainNPTO,
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

output(finalOutput, named('Results'));
output(dRoyalties, named('RoyaltySet'));

ENDMACRO;
// RiskWise.RiskWiseMainNPTO()