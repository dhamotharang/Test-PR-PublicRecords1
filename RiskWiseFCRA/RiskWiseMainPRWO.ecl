/*--SOAP--
<message name="St. Cloud Main Service PRWO FCRA">
	<part name="tribcode" type="xsd:string"/>
	<part name="account" type="xsd:string"/>
	<part name="first" type="xsd:string"/>
	<part name="last" type="xsd:string"/>
	<part name="cmpy" type="xsd:string"/>
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
	<part name="income" type="xsd:string"/>
	<part name='numyears' type="xsd:string"/>
	<part name='nummonths' type="xsd:string"/>
	<part name="prevaddr" type="xsd:string"/>
	<part name="prevcity" type="xsd:string"/>
	<part name="prevstate" type="xsd:string"/>
	<part name="prevzip" type="xsd:string"/>
	<part name="prevphone" type="xsd:string"/>
	<part name="internetcommflag" type="xsd:string"/>
	<part name="email" type="xsd:string"/>
	<part name="emailheader" type="xsd:string"/>
	<part name="ipaddr" type="xsd:string"/>
	<part name="numphones" type="xsd:string"/>
	<part name="prodcat" type="xsd:string"/>
	<part name="appdate" type="xsd:string"/>
	<part name="apptime" type="xsd:string"/>
	<part name="checkaba" type="xsd:string"/>
	<part name="checkacct" type="xsd:string"/>
	<part name="checknum" type="xsd:string"/>
	<part name="bankname" type="xsd:string"/>
	<part name="pymtmethod" type="xsd:string"/>
	<part name="cctype" type="xsd:string"/>
	<part name="ccnum" type="xsd:string"/>
	<part name="ccexpdate" type="xsd:string"/>
	<part name="DPPAPurpose" type="xsd:byte"/>
	<part name="GLBPurpose" type="xsd:byte"/>
	<part name="HistoryDateYYYYMM" type="xsd:integer"/>
	<part name="DataRestrictionMask" type="xsd:string"/>
	<part name="DataPermissionMask" type="xsd:string"/>
	<part name="runSeed" type="xsd:boolean"/>
	<part name="gateways" type="tns:XmlDataSet" cols="70" rows="25"/>
	<part name="FFDOptionsMask"	type="xsd:string"/>	
 </message>
*/
/*--INFO-- 'pw10','pw13','pw14','pw15','pw19','pw22','pw34','pw51','pw52' */

import address, Risk_Indicators, Models, RiskWise,gateway;


export RiskWiseMainPRWO := MACRO

/* Force layout of WsECL page */
#WEBSERVICE(FIELDS(
	'tribcode',
	'account',
	'first',
	'last',
	'cmpy',
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
	'income',
	'numyears',
	'nummonths',
	'prevaddr',
	'prevcity',
	'prevstate',
	'prevzip',
	'prevphone',
	'internetcommflag',
	'email',
	'emailheader',
	'ipaddr',
	'numphones',
	'prodcat',
	'appdate',
	'apptime',
	'checkaba',
	'checkacct',
	'checknum',
	'bankname',
	'pymtmethod',
	'cctype',
	'ccnum',
	'ccexpdate',
	'DPPAPurpose',
	'GLBPurpose',
	'HistoryDateYYYYMM',
	'DataRestrictionMask',
	'DataPermissionMask',
	'runSeed',
	'gateways',
	'FFDOptionsMask'));

// Can't have duplicate definitions of Stored with different default values, 
// so add the default to #stored to eliminate the assignment of a default value.
#stored('GLBPurpose',RiskWise.permittedUse.GLBA);
#stored('DataRestrictionMask',risk_indicators.iid_constants.default_DataRestriction);

string4  tribCode_value := '' 		: stored('tribcode');
string30 account_value := '' 			: stored('account');
string15 first_value := ''    		: stored('first');
string20 last_value := ''     		: stored('last');
string30 cmpy_value := ''   			: stored('cmpy');
string50 addr_value := ''    			: stored('addr');
string30 city_value := ''      		: stored('city');
string2  state_value := ''      		: stored('state');
string5  zip_value := ''      		: stored('zip');
string9  socs_value := ''      		: stored('socs');
string8  dob_value := ''      		: stored('dob');
string10 hphone_value := ''   		: stored('hphone');
string10 wphone_value := ''  			: stored('wphone');
string20 drlc_value := ''     		: stored('drlc');
string2  drlcstate_value := ''     	: stored('drlcstate');
string6  income_value := ''			: stored('income');
string50 prevaddr_value := ''			: stored('prevaddr');
string30 prevcity_value := ''			: stored('prevcity');
string2  prevstate_value := ''		: stored('prevstate');
string5  prevzip_value := ''			: stored('prevzip');
string10 prevphone_value := ''		: stored('prevphone');
string1  internetcommflag_value := ''	: stored('internetcommflag');
string50 email_value := ''  			: stored('Email');
string50 emailheader_value := ''		: stored('emailheader');
string45 ipaddr_value := ''      		: stored('ipaddr');	
string2  numphones_value := ''		: stored('numphones');
string2  prodcat_value := ''			: stored('prodcat');
string8  appdate_value := ''			: stored('appdate');
string6  apptime_value := ''			: stored('apptime');
string11 checkaba_value := ''			: stored('checkaba');
string9  checkacct_value := ''		: stored('checkacct');
string7  checknum_value := ''			: stored('checknum');
string40 bankname_value := ''			: stored('bankname');
string2  pymtmethod_value := ''		: stored('pymtmethod');
string1  cctype_value := ''			: stored('cctype');
string16 ccnum_value := ''			: stored('ccnum');
string8  ccexpdate_value := ''		: stored('ccexpdate');

unsigned1 DPPA_Purpose := 0  			: stored('DPPAPurpose');
unsigned1 GLB_Purpose := RiskWise.permittedUse.GLBA : stored('GLBPurpose');
unsigned3 history_date := 999999  		: stored('HistoryDateYYYYMM');
boolean runSeed_value := false 		: stored('runSeed');

string2 employment_years := ''		: stored('numyears');
string2 employment_months := ''		: stored('nummonths');
string DataRestriction := risk_indicators.iid_constants.default_DataRestriction : stored('DataRestrictionMask');
string50 DataPermission  := Risk_Indicators.iid_constants.default_DataPermission : stored('DataPermissionMask');
gateways_in := Gateway.Configuration.Get();
STRING  strFFDOptionsMask_in	 :=  '0' : STORED('FFDOptionsMask');
boolean UsePersonContext := strFFDOptionsMask_in[1] = '1';	

tribCode := StringLib.StringToLowerCase(tribCode_value);

productSet := ['pw10','pw13','pw14','pw15','pw19','pw22', 'pw51', 'pw52', 'pw34'];

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


Risk_Indicators.Layout_Input into(rec l, integer C) := TRANSFORM
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
	
	self.phone10 := if(hphone_val = '', wphone_val, hphone_val);	// swap the wphone and homephone if homephone empty
	self.wphone10 := if(hphone_val = '', '', wphone_val);
	
	self.fname := stringlib.stringtouppercase(first_value);
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
	self.z5 := if(clean_a2[117..121]<>'', clean_a2[117..121], zip_value[1..5]);	// use the input zip if cass zip is empty
	self.zip4 := clean_a2[122..125];
	self.lat := clean_a2[146..155];
	self.long := clean_a2[156..166];
	self.addr_type := clean_a2[139];
	self.addr_status := clean_a2[179..182];
	self.county := clean_a2[143..145];
	self.geo_blk := clean_a2[171..177];
			
	self.dl_number := stringlib.stringtouppercase(dl_num_clean);
	self.dl_state := stringlib.stringtouppercase(drlcstate_value);
	
	self.email_address := email_value;
	self.ip_address := ipaddr_value;
	
	self.employer_name := if(tribcode='pw15', '', stringlib.stringtouppercase(cmpy_value));
	
	self := [];
END;
prep := PROJECT(d,into(left,counter));


alt_DPPA := if( tribcode in ['pw51', 'pw52'], 3, DPPA_Purpose );
alt_GLB  := if( tribcode in ['pw51', 'pw52'], 5, GLB_Purpose );

gwthresh := 0.84; // global watchlist threshold of 0.84 for all products

IN_BSversion := if(tribcode='pw34', 2, 1);  // use BS2 for pw34
Require2Ele := if(tribcode='pw34', false, true);


clam := Risk_Indicators.Boca_Shell_Function_FCRA(prep,
		gateways,
		alt_DPPA,
		alt_GLB,
		false,	// isUtility
		false,	// isLN
		Require2Ele,	// require2ele
		false,	// includeRelativeInfo
		false,	// includeDLInfo
		tribCode='pw51',	// includeVehInfo
		true,	// includeDerogInfo
		true,	// default IN_OFAC_Only value
		false,	// default IN_SuppressNearDups value
		false,	// default IN_From_BIID value
		false,	// default IN_ExcludeWatchlists value
		false,	// default IN_From_IT1O value
		1,		// default IN_OFAC_version value
		false,	// default IN_Include_OFAC value
		false,	// default IN_Include_additional_watchlists value
		gwthresh,
		IN_BSversion,
		datarestriction:=datarestriction,
		datapermission:=datapermission
);

	 
string2 getSocsLevel(unsigned1 level) := map(level in [0,2,3,5,8] => '0',
									level = 1 => '1',
									level = 4 => '2',
									level = 6 => '3',
									level = 7 => '4',
									(string)(level-4));	// 9,10,11,12 results in 5,6,7,8
									
									
working_layout := RECORD
	RiskWise.Layout_PRWO;
	boolean inCalif;
END;



working_layout format_out(clam le) := TRANSFORM
	self.inCalif := Stringlib.StringToUpperCase(state_value) = 'CA' and ((integer)(boolean)le.iid.combo_firstcount+(integer)(boolean)le.iid.combo_lastcount+
														    (integer)(boolean)le.iid.combo_addrcount+(integer)(boolean)le.iid.combo_hphonecount+
														    (integer)(boolean)le.iid.combo_ssncount+(integer)(boolean)le.iid.combo_dobcount)<3;

		
	self.seq := le.seq;
	self.account := account_value;
	self.riskwiseid := (string)le.did;
	
	self.firstcount := if(le.shell_input.fname <> '', RiskWise.flattenCount(le.iid.combo_firstcount,2,1), '');
	self.lastcount := if(le.shell_input.lname <> '', RiskWise.flattenCount(le.iid.combo_lastcount,2,1), '');
	self.addrcount := if(le.shell_input.in_streetAddress <> '', RiskWise.flattenCount(le.iid.combo_addrcount,2,1), '');
	self.hphonecount := if(le.shell_input.phone10 <> '', RiskWise.flattenCount(le.iid.combo_hphonecount,2,1), '');
	self.socscount := if(le.shell_input.ssn <> '', RiskWise.flattenCount(le.iid.combo_ssncount,2,1), '');
	self.socsverlevel := getSocsLevel(le.iid.nas_summary);
	self.dobcount := if(le.shell_input.dob <> '', RiskWise.flattenCount(le.iid.combo_dobcount,2,1), '');
	self.drlccount := if(le.shell_input.dl_number <> '' and le.shell_input.dl_number <> '', '0', '');
	self.cmpycount := if(le.shell_input.employer_name <> ''/* and le.iid.combo_cmpyscore>0*/, RiskWise.flattenCount(le.iid.combo_cmpycount,2,1), '');
	
	self.verfirst := le.iid.combo_first;
	self.verlast := le.iid.combo_last;
	self.vercmpy := le.iid.combo_cmpy;
	self.veraddr := Risk_Indicators.MOD_AddressClean.street_address('',le.iid.combo_prim_range,le.iid.combo_predir,le.iid.combo_prim_name,le.iid.combo_suffix,le.iid.combo_postdir,le.iid.combo_unit_desig,le.iid.combo_sec_range);
	self.vercity := le.iid.combo_city;
	self.verstate := le.iid.combo_state;
	self.verzip := le.iid.combo_zip;
	self.verhphone := le.iid.combo_hphone;
	self.versocs := if(le.iid.combo_ssncount > 0, le.iid.combo_ssn, '');
	self.verdob := le.iid.combo_dob;
	
	self.numelever := (string)((integer)(boolean)(integer)self.firstcount+(integer)(boolean)(integer)self.lastcount+(integer)(boolean)(integer)self.addrcount+(integer)(boolean)(integer)self.hphonecount
							+(integer)(boolean)(integer)self.socscount+(integer)(boolean)(integer)self.dobcount+(integer)(boolean)(integer)self.cmpycount);
	self.numsource := (string)((integer)self.firstcount+(integer)self.lastcount+(integer)self.cmpycount+(integer)self.addrcount+(integer)self.hphonecount+
						  (integer)self.socscount+(integer)self.dobcount);
	
	self.firstscore := if(le.shell_input.fname <> '', if(le.iid.combo_firstscore = 255, '0', (string)le.iid.combo_firstscore), '');
	self.lastscore := if(le.shell_input.lname <> '', if(le.iid.combo_lastscore = 255, '0', (string)le.iid.combo_lastscore), '');
	self.cmpyscore := if(le.shell_input.employer_name <> ''/* and le.iid.combo_cmpyscore>0*/, if(le.iid.combo_cmpyscore=255, '0', (string)le.iid.combo_cmpyscore), '');
	self.addrscore := if(le.shell_input.in_streetAddress <> '', if(le.iid.combo_addrscore = 255, '0', (string)le.iid.combo_addrscore), '');
	self.hphonescore := if(le.shell_input.phone10 <> '', if(le.iid.combo_hphonescore = 255, '0', (string)le.iid.combo_hphonescore), '');
	self.socsscore := if(le.shell_input.ssn <> '', if(le.iid.combo_ssnscore = 255, '0', (string)le.iid.combo_ssnscore), '');
	self.dobscore := if(le.shell_input.dob <> '', if(le.iid.combo_dobscore = 255, '0', (string)le.iid.combo_dobscore), '');
	self.drlcscore := if(le.shell_input.dl_number <> '', '0', '');
	
	self.wphonename := le.iid.wphonename;
	self.wphoneaddr := le.iid.wphoneaddr;
	self.wphonecity := le.iid.wphonecity;
	self.wphonestate := le.iid.wphonestate;
	self.wphonezip := le.iid.wphonezip;
	
	self.socsmiskeyflag := (string)(integer)le.iid.socsmiskeyflag;
	self.hphonemiskeyflag := (string)(integer)le.iid.hphonemiskeyflag;
	self.addrmiskeyflag := (string)(integer)le.iid.addrmiskeyflag;
		
	self.wphonetypeflag := le.iid.wphonetypeflag;
	self.wphonevalflag := le.iid.wphonevalflag;
	self.hphonetypeflag := le.iid.hphonetypeflag;
	self.hphonevalflag := le.iid.hphonevalflag;
	self.phonezipflag := le.iid.PWphonezipflag;
	self.phonedissflag := (string)(integer)le.iid.phonedissflag;
	self.addrvalflag := le.iid.addrvalflag;
	self.dwelltypeflag := le.iid.dwelltype;
	self.ziptypeflag := le.iid.ziptypeflag;
	self.socsvalflag := le.iid.PWsocsvalflag;
	self.decsflag := le.iid.decsflag;
	self.socsdobflag := le.iid.PWsocsdobflag;
	self.areacodesplitflag := map(le.shell_input.phone10 = '' => '2',
							le.iid.areacodesplitflag = 'Y' => '1',
							'0');
	self.altareacode := if(le.iid.areacodesplitflag = 'Y', le.iid.altareacode, '');
	self.bansflag := if(le.iid.bansflag = '3', '0', le.iid.bansflag);
	self.drlcvalflag := le.iid.drlcvalflag;
	self.drlcsoundx := le.iid.drlcsoundx;
	self.drlcfirst := le.iid.drlcfirst;
	self.drlclast := le.iid.drlclast;
	self.drlcmiddle := le.iid.drlcmiddle;
	self.drlcsocs := le.iid.drlcsocs;
	self.drlcdob := le.iid.drlcdob;
	self.drlcgender := le.iid.drlcgender;
	
	self.disthphonewphone := if(le.iid.disthphonewphone <> 9999, (string)le.iid.disthphonewphone, '');
	self.distwphoneaddr := if(le.iid.distwphoneaddr <> 9999, (string)le.iid.distwphoneaddr, '');
	
	self.statezipflag := le.iid.statezipflag;
	self.cityzipflag := le.iid.cityzipflag;
	self.hphonestateflag := '0';
		
	self.cassaddr := Risk_Indicators.MOD_AddressClean.street_address('',le.shell_input.prim_range,le.shell_input.predir,le.shell_input.prim_name,le.shell_input.addr_suffix,
										le.shell_input.postdir,le.shell_input.unit_desig,le.shell_input.sec_range);
	self.casscity := le.shell_input.p_city_name;
	self.cassstate := le.shell_input.st;
	self.casszip := le.shell_input.z5+le.shell_input.zip4;
	
	self.addrcommflag := le.iid.addrcommflag;
	
	self.coaalertflag := '';
	self.aptscanflag := '';
	
	self.numfraud := RiskWise.getNumFraud(self.coaalertflag,self.aptscanflag,self.addrvalflag,self.decsflag,self.bansflag,self.drlcvalflag).PRWO(self.wphonetypeflag,
								   self.wphonevalflag,self.hphonetypeflag,self.hphonevalflag,self.phonezipflag,self.phonedissflag,self.socsvalflag,
								   self.socsdobflag,self.statezipflag,self.cityzipflag,self.hphonestateflag,self.addrcommflag);
	
	self.airwavesscore := if(self.inCalif, '000', '');
	
	// Per Bug 58288 - EQ99 logging in no longer necessary, removing.
	self.billing := dataset([],risk_indicators.Layout_Billing);
	
	self := [];
END;

/* New transform designed for pw51 originally, which outputs only score & rc. Keep the billing data but blank all else out */
working_layout format_out__billing_only(clam le) := TRANSFORM
	self.seq := le.seq;
	self.account := account_value;
	self.inCalif := Stringlib.StringToUpperCase(state_value) = 'CA' and ((integer)(boolean)le.iid.combo_firstcount+(integer)(boolean)le.iid.combo_lastcount+
													    (integer)(boolean)le.iid.combo_addrcount+(integer)(boolean)le.iid.combo_hphonecount+
													    (integer)(boolean)le.iid.combo_ssncount+(integer)(boolean)le.iid.combo_dobcount)<3;

	self := [];
END;

mapped_results := if( tribCode in ['pw51', 'pw52'], PROJECT(clam, format_out__billing_only(LEFT)), PROJECT(clam, format_out(LEFT)));



getAir := map(tribcode = 'pw10' => Models.AWD605_2_0(clam, true, mapped_results[1].inCalif),
		    tribcode = 'pw13' => Models.AWD606_6_0(clam, true, mapped_results[1].inCalif),
		    tribcode = 'pw14' => Models.AWD606_7_0(clam, true, mapped_results[1].inCalif),
		    tribcode = 'pw15' => Models.AWD606_8_0(clam, true, mapped_results[1].inCalif),
		    tribcode = 'pw19' => Models.AWD606_9_0(clam, true, mapped_results[1].inCalif),
		    tribcode = 'pw22' => Models.AWD606_11_0(clam, true, mapped_results[1].inCalif),
		    tribcode = 'pw51' => Models.AID605_1_0(clam, false, mapped_results[1].inCalif, (real)employment_years, (real)employment_months, (real)income_value),
				tribcode = 'pw52' => Models.AID607_0_0(clam, false, mapped_results[1].inCalif ),
				tribcode = 'pw34' => ungroup(Models.RVT711_1_0(clam, Stringlib.StringToUpperCase(state_value) = 'CA')),
		    dataset([],Models.Layout_ModelOut));
	    
RiskWise.Layout_PRWO addModel(mapped_results le, getAir ri) := TRANSFORM
	self.airwavesscore := if(le.airwavesscore <> '000' or ri.score in ['101','102','103','104','105'], ri.score, le.airwavesscore);
	self.nonreszip := if(ri.ri[1].hri <> '00', ri.ri[1].hri[1..2], '36') + if(ri.ri[2].hri <> '00', ri.ri[2].hri[1..2], '')+
				   if(ri.ri[3].hri <> '00', ri.ri[3].hri[1..2], '') + if(ri.ri[4].hri <> '00', ri.ri[4].hri[1..2], '');
					 
					 
	self := le;
END;
withModel := join(mapped_results, getAir, left.seq=right.seq, addModel(left,right), left outer);


RiskWise.Layout_PRWO createEmpty(withModel le) := TRANSFORM
	self.seq := le.seq;
	self := [];
END;
emptyset := project(withModel, createEmpty(left));

RiskWise.Layout_PRWO checkFreeze(withModel le, emptySet ri) := TRANSFORM
	freeze := le.airwavesscore = '101';	// if security freeze, blank out the data
	
	self.account := le.account;
	self.riskwiseid := le.riskwiseid;
	self.airwavesscore := le.airwavesscore;
	self.nonreszip := le.nonreszip;
	
	self := if(freeze, ri, le);
END;
withFreeze := join(withModel, emptyset, left.seq=right.seq, checkFreeze(LEFT,RIGHT), left outer);

acct_only := PROJECT(withFreeze, TRANSFORM(RiskWise.Layout_PRWO, self.account := left.account, self := []));
final := if(Stringlib.StringToUpperCase(state_value) = 'VT' and tribCode = 'pw13', acct_only, withFreeze);

critter := map(tribcode = 'pw10' => '010',
			tribcode = 'pw13' => '013',
			tribcode = 'pw14' => '014',
			tribcode = 'pw15' => '015',
			tribcode = 'pw19' => '019',
			tribcode = 'pw22' => '022',
			tribcode = 'pw51' => '051',
			tribcode = 'pw34' => '034',
			'');

seed_files.mac_query_seedfiles(socs_value, 'prwo', 'prwi', critter, prwi_seed_output);

riskwise.Layout_PRWO format_seed(prwi_seed_output le) := TRANSFORM
	self.account := account_value;
	self.billing := [];
	self := le;
END;
final_seed := if(runSeed_value, project(prwi_seed_output, format_seed(left)), dataset([],RiskWise.Layout_PRWO) );

finalAnswer := if(tribCode in productSet,
			   if(count(final_seed)>0 and runSeed_value, final_seed, final),
			      dataset([],RiskWise.Layout_PRWO));

output(finalAnswer,NAMED('Results'));

ENDMACRO;
