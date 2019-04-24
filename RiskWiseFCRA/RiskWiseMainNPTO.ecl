/*--SOAP--
<message name="St. Cloud Main Service NPTO FCRA">
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
	<part name="gateways" type="tns:XmlDataSet" cols="70" rows="25"/>
	<part name="FFDOptionsMask"	type="xsd:string"/>	
 </message>
*/
/*--INFO-- 'npt3','npt4','npt5' */


import Address, Risk_Indicators, Models, RiskWise, gateway;

export RiskWiseMainNPTO := MACRO

// Can't have duplicate definitions of Stored with different default values, 
// so add the default to #stored to eliminate the assignment of a default value.
#stored('GLBPurpose',RiskWise.permittedUse.GLBA);
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
	'gateways',
	'FFDOptionsMask'
	));

string4  tribCode_value := '' 	: stored('tribcode');
string30 account_value := '' 		: stored('account');
string15 first_value := ''     	: stored('first');
string1  middleini_value := ''     : stored('middleini');
string20 last_value := ''     	: stored('last');
string50 addr_value := ''    		: stored('addr');
string30 city_value := ''      	: stored('city');
string2  state_value := ''      	 : stored('state');
string9  zip_value := ''      	: stored('zip');
string10 hphone_value := ''   	: stored('hphone');
string9  socs_value := ''      	: stored('socs');
string8  dob_value := ''      	: stored('dob');
string10 wphone_value := ''  		: stored('wphone');
string6  income_value := ''		: stored('income');
string20 drlc_value := ''     	: stored('drlc');
string2  drlcstate_value := ''	: stored('drlcstate');
string6  balance_value := ''		: stored('balance');
string8  chargeoffdate_value := '' : stored('chargeoffdate');
string20 formerlast_value := ''    : stored('formerlast');
string50 email_value := ''  		: stored('email');
string30 cmpy_value := ''   		: stored('cmpy');

unsigned1 DPPA_Purpose := 0  		: stored('DPPAPurpose');
unsigned1 GLB_Purpose := RiskWise.permittedUse.GLBA		: stored('GLBPurpose');
unsigned3 history_date := 999999   : stored('HistoryDateYYYYMM');
boolean   runSeed_value := false 	 : stored('runSeed');
string DataRestriction := risk_indicators.iid_constants.default_DataRestriction  : stored('DataRestrictionMask');
string50 DataPermission  := Risk_Indicators.iid_constants.default_DataPermission : stored('DataPermissionMask');
gateways_in := Gateway.Configuration.Get();
STRING  strFFDOptionsMask_in	 :=  '0' : STORED('FFDOptionsMask');
boolean UsePersonContext := strFFDOptionsMask_in[1] = '1';			

tribCode := StringLib.StringToLowerCase(tribCode_value);

// JRP 02/12/2008 - Dataset of actioncode settings which are passed to the getactioncodes function.
boolean IsPOBoxCompliant := false;
boolean IsInstantID := false;
actioncode_settings := dataset([{IsPOBoxCompliant, IsInstantID}],riskwise.layouts.actioncode_settings);

productSet := ['npt3','npt4', 'npt5'];

Gateway.Layouts.Config gw_switch(gateways_in le) := TRANSFORM
	self.servicename := le.servicename;
	self.url := IF(le.servicename IN riskwisefcra.Neutral_Service_Name, le.url, '');
	self := le;
END;
gateways := project(gateways_in, gw_switch(left));


rec := RECORD
	unsigned4 seq;
END;
d := dataset([{0}],rec);


Risk_Indicators.Layout_Input into(rec l, INTEGER C) := TRANSFORM
	clean_a2 := Risk_Indicators.MOD_AddressClean.clean_addr(addr_value, city_value, state_value, zip_value);
	
	
	ssn_val := RiskWise.cleanSSN( socs_value );
	hphone_val := RiskWise.cleanPhone( hphone_value );
	wphone_val := RiskWise.cleanPhone( wphone_value );
	dob_val := riskwise.cleanDOB( dob_value );
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


require2Ele := (tribCode in ['npt4','npt5']);

// modify boca_shell_function_fcra to take extra params
clam := Risk_Indicators.Boca_Shell_Function_FCRA(prep, gateways, DPPA_Purpose, GLB_Purpose, false, false, require2Ele,
			false,	// include relative info
			false,	// include DL info
			false,	// include vehicle info
			true,	// include derogs
			// values added:
			TRUE,	// OFAC Only
			FALSE,	// SuppressNearDups
			FALSE,	// From BIID
			FALSE,	// ExcludeWatchLists
			FALSE,	// From IT1O
			2,		// OFAC Version
			(tribcode not in ['npt4','npt5']),	// Include OFAC
			FALSE,	// Include additional watchlists
			0.84,		// Global watchlist threshold
			datarestriction:=datarestriction,
			datapermission:=datapermission
);


working_layout := RECORD
	RiskWise.Layout_NPTO;
	boolean inCalif;
END;


working_layout format_out(clam le) := TRANSFORM
	self.inCalif := Stringlib.stringtouppercase(state_value) = 'CA' and 
						((integer)(boolean)le.iid.combo_firstcount+(integer)(boolean)le.iid.combo_lastcount+(integer)(boolean)le.iid.combo_addrcount+
						(integer)(boolean)le.iid.combo_hphonecount+(integer)(boolean)le.iid.combo_ssncount+(integer)(boolean)le.iid.combo_dobcount)<3;

	self.seq := le.seq;
	self.account := account_value;
	self.riskwiseid := (string)le.did;

	self.socsverlevel := if(tribCode in ['npt4','npt5'], '', (string)le.iid.nas_summary);
	self.phoneverlevel := if(tribCode in ['npt4','npt5'], '', (string)le.iid.nap_summary);
	
	self.score2 := if(self.inCalif, '000', '');
	
	self.correctdob := if(tribCode in ['npt4','npt5'], '', le.iid.correctdob);
	self.correcthphone := if(tribCode in ['npt4','npt5'], '', le.iid.correcthphone);
	self.correctsocs := if(tribCode in ['npt4','npt5'], '', le.iid.correctssn);
	
	self.altareacode := if(tribCode in ['npt4','npt5'], '', if(le.iid.areacodesplitflag = 'Y', le.iid.altareacode, ''));	
	self.splitdate := if(tribCode in ['npt4','npt5'], '', if(le.iid.areacodesplitflag = 'Y', le.iid.areacodesplitdate, ''));
		
	self.dirsfirst := if(tribCode in ['npt4','npt5'], '', le.iid.dirsfirst);
	self.dirslast := if(tribCode in ['npt4','npt5'], '', le.iid.dirslast);
	self.dirsaddr := if(tribCode in ['npt4','npt5'], '', Risk_Indicators.MOD_AddressClean.street_address('',le.iid.dirs_prim_range,le.iid.dirs_predir,le.iid.dirs_prim_name,
															 le.iid.dirs_suffix,le.iid.dirs_postdir,le.iid.dirs_unit_desig,le.iid.dirs_sec_range));
	self.dirscity := if(tribCode in ['npt4','npt5'], '', le.iid.dirscity);
	self.dirsstate := if(tribCode in ['npt4','npt5'], '', le.iid.dirsstate);
	self.dirszip := if(tribCode in ['npt4','npt5'], '', le.iid.dirszip);
	
	self.nameaddrphone := if(tribCode in ['npt4','npt5'], '', map(le.iid.phonever_type='U' => le.iid.utiliphone,
											  le.iid.phonever_type='A' => le.iid.dirsaddr_phone,  
											  le.iid.phoneaddr_phonecount >= le.iid.utiliaddr_phonecount => le.iid.dirsaddr_phone,
											  le.iid.utiliphone));
	self.socllowissue := if(tribCode in ['npt4','npt5'], '', le.iid.socllowissue);
	self.soclhighissue := if(tribCode in ['npt4','npt5'], '', le.iid.soclhighissue);
	self.soclstate := if(tribCode in ['npt4','npt5'], '', le.iid.soclstate);	
	
	self.eqfsfirst := if(tribCode in ['npt4','npt5'], '', le.iid.verfirst);
	self.eqfslast := if(tribCode in ['npt4','npt5'], '', le.iid.verlast);
	self.eqfsaddr := if(tribCode in ['npt4','npt5'], '', Risk_Indicators.MOD_AddressClean.street_address('',le.iid.chronoprim_range, le.iid.chronopredir, 
															 le.iid.chronoprim_name, le.iid.chronosuffix,
															 le.iid.chronopostdir, le.iid.chronounit_desig, le.iid.chronosec_range));
	self.eqfscity := if(tribCode in ['npt4','npt5'], '', le.iid.chronocity);
	self.eqfsstate := if(tribCode in ['npt4','npt5'], '', le.iid.chronostate);
	self.eqfszip := if(tribCode in ['npt4','npt5'], '', le.iid.chronozip);
	self.eqfsphone := if(tribCode in ['npt4','npt5'], '', le.iid.chronophone);
	self.eqfsaddr2 := if(tribCode in ['npt4','npt5'], '', Risk_Indicators.MOD_AddressClean.street_address('',le.iid.chronoprim_range2, le.iid.chronopredir2, 
															  le.iid.chronoprim_name2, le.iid.chronosuffix2,
															  le.iid.chronopostdir2, le.iid.chronounit_desig2, le.iid.chronosec_range2));
	self.eqfscity2 := if(tribCode in ['npt4','npt5'], '', le.iid.chronocity2);
	self.eqfsstate2 := if(tribCode in ['npt4','npt5'], '', le.iid.chronostate2);
	self.eqfszip2 := if(tribCode in ['npt4','npt5'], '', le.iid.chronozip2);
	self.eqfsphone2 := if(tribCode in ['npt4','npt5'], '', le.iid.chronophone2);
	self.eqfsaddr3 := if(tribCode in ['npt4','npt5'], '', Risk_Indicators.MOD_AddressClean.street_address('',le.iid.chronoprim_range3, le.iid.chronopredir3, 
															  le.iid.chronoprim_name3, le.iid.chronosuffix3,
															  le.iid.chronopostdir3, le.iid.chronounit_desig3, le.iid.chronosec_range3));
	self.eqfscity3 := if(tribCode in ['npt4','npt5'], '', le.iid.chronocity3);
	self.eqfsstate3 := if(tribCode in ['npt4','npt5'], '', le.iid.chronostate3);
	self.eqfszip3 := if(tribCode in ['npt4','npt5'], '', le.iid.chronozip3);
	self.eqfsphone3 := if(tribCode in ['npt4','npt5'], '', le.iid.chronophone3);	
	
	self.altlast := if(tribCode in ['npt4','npt5'], '', if(le.iid.socsverlevel IN [4,7,9,10,11,12], le.iid.altlast, ''));						
	self.altlast2 := if(tribCode in ['npt4','npt5'], '', if(le.iid.socsverlevel IN [4,7,9,10,11,12], le.iid.altlast2, ''));
	self.altlast3 := if(tribCode in ['npt4','npt5'], '', le.iid.correctlast);
									
	self.hriskalerttable := if(tribCode = 'npt3', if(le.iid.watchlist_table <> '', 'OFC', ''), '');
	self.hriskalertnum := if(tribCode = 'npt3' and le.iid.watchlist_table <> '' , le.iid.Watchlist_Record_Number[5..10], '');
	self.alertfirst := if(tribCode = 'npt3', (string)le.iid.Watchlist_fname, '');
	self.alertlast := if(tribCode = 'npt3', (string)le.iid.Watchlist_lname, '');
	self.alertaddr := if(tribCode = 'npt3', le.iid.Watchlist_address, '');
	self.alertcity := if(tribCode = 'npt3', le.iid.Watchlist_city, '');
	self.alertstate := if(tribCode = 'npt3', le.iid.Watchlist_state, '');
	self.alertzip := if(tribCode = 'npt3', le.iid.Watchlist_zip, '');
	self.alertentity := if(tribCode = 'npt3', (string)le.iid.Watchlist_Entity_Name, '');
	
	self.score := if(tribCode in ['npt4','npt5'], '', intformat(le.iid.cvi,2,1)); // should we include cvi for npt5?
	
	// Per Bug 58288 - EQ99 logging in no longer necessary, removing.
	self.billing := dataset([],risk_indicators.Layout_Billing);
	
	self := [];
END;
searchOutput := PROJECT(clam, format_out(LEFT));


iid := PROJECT(clam, TRANSFORM(Risk_Indicators.Layout_Output, 
	self.nxx_type := left.phone_verification.telcordia_type,
	self.did := left.did, 
	self := left.shell_input, 
	self := left.iid,
	self := []));

RiskWise.Layout_NPTO addCVI(searchOutput le, iid ri) := TRANSFORM
	self.ri := if(tribCode = 'npt3', RiskWise.patriotReasonCodes(ri, 6, true), dataset([],Risk_Indicators.Layout_Desc));
	
	FUA_A := ( tribcode = 'npt3' ); // only allow FUA A (OFAC) for npt3
	FUA_E := false; // don't allow FUA E (non-OFAC watchlists) at all
	self.fua := if(tribCode in ['npt4','npt5'], dataset([],Risk_Indicators.Layout_Desc), Risk_Indicators.getActionCodes(ri, 4, ri.socsverlevel, ri.phoneverlevel, FUA_A, FUA_E, actioncode_settings));
	self.action1 := self.fua[1].hri;
	self.action2 := self.fua[2].hri;
	self.action3 := self.fua[3].hri;
	self.action4 := self.fua[4].hri;
	
	self := le;
END;
getScore := join(searchOutput, iid, left.seq=right.seq, addCVI(left,right), left outer);
	


getScore2 := map(
	tribcode = 'npt5' => Models.RVB703_1_0(clam, false /* no ofac */, searchOutput[1].inCalif),
	Models.TBD605_0_0(clam, true, searchOutput[1].inCalif)
);
		
		
		
RiskWise.Layout_NPTO addModel(getScore le, getScore2 ri) := TRANSFORM
	self.score2 := if(le.score2 = '' or ri.score in ['101','102','103','104','105'], ri.score, le.score2);
	self.reason1 := if(Risk_Indicators.rcSet.isCode36(ri.ri[1].hri), '36', ri.ri[1].hri);
	self.reason2 := ri.ri[2].hri;
	self.reason3 := ri.ri[3].hri;
	self.reason4 := ri.ri[4].hri;
	self.reason5 := if(tribCode='npt3',map(le.ri[1].hri not in [self.reason1,self.reason2,self.reason3,self.reason4] => le.ri[1].hri,
								    le.ri[2].hri not in [self.reason1,self.reason2,self.reason3,self.reason4] => le.ri[2].hri,
								    le.ri[3].hri not in [self.reason1,self.reason2,self.reason3,self.reason4] => le.ri[3].hri,
								    le.ri[4].hri not in [self.reason1,self.reason2,self.reason3,self.reason4] => le.ri[4].hri,
								    le.ri[5].hri not in [self.reason1,self.reason2,self.reason3,self.reason4] => le.ri[5].hri,
								    le.ri[6].hri not in [self.reason1,self.reason2,self.reason3,self.reason4] => le.ri[6].hri,
								    '00'),le.reason5);
	self.reason6 := if(tribCode='npt3',map(le.ri[2].hri not in [self.reason1,self.reason2,self.reason3,self.reason4,self.reason5] => le.ri[2].hri,
								    le.ri[3].hri not in [self.reason1,self.reason2,self.reason3,self.reason4,self.reason5] => le.ri[3].hri,
								    le.ri[4].hri not in [self.reason1,self.reason2,self.reason3,self.reason4,self.reason5] => le.ri[4].hri,
								    le.ri[5].hri not in [self.reason1,self.reason2,self.reason3,self.reason4,self.reason5] => le.ri[5].hri,
								    le.ri[6].hri not in [self.reason1,self.reason2,self.reason3,self.reason4,self.reason5] => le.ri[6].hri,
								    '00'),le.reason6);
	self := le;
END;
withModel := join(getScore, getScore2, left.seq=right.seq, addModel(left,right), left outer);


RiskWise.Layout_NPTO createEmpty(withModel le) := TRANSFORM
	self.seq := le.seq;
	self := [];
END;
emptyset := project(withModel, createEmpty(left));

RiskWise.Layout_NPTO checkFreeze(withModel le, emptySet ri) := TRANSFORM
	freeze := le.score2 = '101';	// if security freeze, blank out the data
	
	self.account := le.account;
	self.riskwiseid := le.riskwiseid;
	self.score2 := le.score2;
	self.reason1 := le.reason1;
	self.reason2 := le.reason2;
	self.reason3 := le.reason3;
	self.reason4 := le.reason4;
	
	self := if(freeze, ri, le);
END;
withFreeze := join(withModel, emptyset, left.seq=right.seq, checkFreeze(LEFT,RIGHT), left outer);





critter := map(tribcode = 'npt3' => '003',
			tribcode = 'npt4' => '004',
			tribcode = 'npt5' => '005',
			'');

seed_files.mac_query_seedfiles(socs_value, 'npto', 'prii', critter, prii_seed_output);

RiskWise.Layout_NPTO format_seed(prii_seed_output le) := TRANSFORM
	self.account := account_value;
	self.ri := [];
	self.fua := [];
	self.billing := [];
	self := le;
	self := [];
END;
final_seed := if(runSeed_value, project(prii_seed_output, format_seed(left)), dataset([], RiskWise.Layout_NPTO));
			
finalOutput := if(tribCode in productSet,
			   if(count(final_seed)>0 and runSeed_value, final_seed, withFreeze),
			   dataset([],Riskwise.Layout_NPTO));

output(finalOutput, named('Results'));

ENDMACRO;