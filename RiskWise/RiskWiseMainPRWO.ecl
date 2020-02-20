/*--SOAP--
<message name="St. Cloud Main Service PRWO">
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
	<part name="DataRestrictionMask" type="xsd:string"/>
	<part name="DataPermissionMask" type="xsd:string"/>
	<part name="HistoryDateYYYYMM" type="xsd:integer"/>
	<part name="runSeed" type="xsd:boolean"/>
	<part name="gateways" type="tns:XmlDataSet" cols="70" rows="25"/>
 </message>
*/
/*--INFO-- 'pw01','pw03','pw06','pw07','pw50' */

import Risk_Indicators, Models, seed_files, gateway, Royalty, Riskwise, STD;


export RiskWiseMainPRWO := MACRO

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
	'DataRestrictionMask',
	'DataPermissionMask',
	'HistoryDateYYYYMM',
	'runSeed',
	'gateways',
    'LexIdSourceOptout',
    '_TransactionId',
    '_BatchUID',
    '_GCID'));

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
string DataRestriction := risk_indicators.iid_constants.default_DataRestriction : stored('DataRestrictionMask');
string50 DataPermission := Risk_Indicators.iid_constants.default_DataPermission : stored('DataPermissionMask');
tribCode := STD.Str.ToLowerCase(tribCode_value);
unsigned1 DPPA_Purpose := RiskWise.permittedUse.fraudDPPA 	: stored('DPPAPurpose');
unsigned1 GLB_Purpose := RiskWise.permittedUse.fraudGLBA : stored('GLBPurpose');

unsigned3 history_date := 999999  						: stored('HistoryDateYYYYMM');
boolean runSeed_value := false 						: stored('runSeed');
gateways_in := Gateway.Configuration.Get();

//CCPA fields
unsigned1 LexIdSourceOptout := 1 : STORED('LexIdSourceOptout');
string TransactionID := '' : STORED('_TransactionId');
string BatchUID := '' : STORED('_BatchUID');
unsigned6 GlobalCompanyId := 0 : STORED('_GCID');

productSet := ['pw01','pw03','pw06','pw07','pw50'];

targusGatewaySet := ['pw03','pw06','pw07','pw50'];

Gateway.Layouts.Config gw_switch(gateways_in le) := TRANSFORM
	self.servicename := le.servicename;
	self.url := if(tribcode in targusGatewaySet and le.servicename = 'targus', le.url, SKIP); // default to no gateway call			 
	self := le;
END;
gateways := project(gateways_in, gw_switch(left));



rec := RECORD
	unsigned4 seq;
END;
d := dataset([{0}],rec);


risk_indicators.layout_input into(rec l, integer C) := TRANSFORM
	clean_a2 := Risk_Indicators.MOD_AddressClean.clean_addr(addr_value, city_value, state_value, zip_value);
	
	ssn_val := RiskWise.cleanSSN( socs_value );
	hphone_val := RiskWise.cleanPhone( hphone_value );
	wphone_val := RiskWise.cleanPhone( wphone_value);
	dob_val := RiskWise.cleanDOB( dob_value );
	dl_num_clean := RiskWise.cleanDL_num( drlc_value );


	self.seq := C;
	self.historydate := history_date;
	self.ssn := ssn_val;
	self.dob := dob_val;
	
	self.phone10 := if(tribCode in ['pw01'], hphone_val, if(hphone_val = '', wphone_val, hphone_val));	// swap the wphone and homephone if homephone empty
	self.wphone10 := if(tribCode in ['pw01'], wphone_val, if(hphone_val = '', '', wphone_val));
	
	self.fname := STD.Str.touppercase(first_value);
	self.lname := STD.Str.touppercase(last_value);	
	
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
			
	self.dl_number := STD.Str.touppercase(dl_num_clean);
	self.dl_state := STD.Str.touppercase(drlcstate_value);
	
	self.email_address := email_value;
	self.ip_address := ipaddr_value;
	
	self.employer_name := STD.Str.touppercase(cmpy_value);
	
	self := [];
END;
prep := PROJECT(d,into(left,counter));


ret := risk_indicators.InstantID_Function(prep, gateways, DPPA_Purpose, GLB_Purpose, false, false, true, true, true,in_DataRestriction := DataRestriction,in_DataPermission := DataPermission,
                                                                     LexIdSourceOptout := LexIdSourceOptout, 
                                                                     TransactionID := TransactionID, 
                                                                     BatchUID := BatchUID, 
                                                                     GlobalCompanyID := GlobalCompanyID);

//don't track royalties for testseeds
dRoyalties := if(runSeed_value, dataset([], Royalty.Layouts.Royalty),
	Royalty.RoyaltyTargus.GetOnlineRoyalties(UNGROUP(ret), src, TargusType, TRUE, FALSE, FALSE, TRUE));

string2 getSocsLevel(unsigned1 level) := map(level in [0,2,3,5,8] => '0',
									level = 1 => '1',
									level = 4 => '2',
									level = 6 => '3',
									level = 7 => '4',
									(string)(level-4));	// 9,10,11,12 results in 5,6,7,8



RiskWise.Layout_PRWO format_out(Risk_Indicators.Layout_Output le) := TRANSFORM		
	self.seq := le.seq;
	self.account := account_value;
	self.riskwiseid := (string)le.did;
	
	self.firstcount := if(le.fname <> '' and tribCode in ['pw03','pw06','pw07','pw50'], RiskWise.flattenCount(le.combo_firstcount,2,1), '');
	self.lastcount := if(le.lname <> '' and tribCode in ['pw03','pw06','pw07','pw50'], RiskWise.flattenCount(le.combo_lastcount,2,1), '');
	self.addrcount := if(le.in_streetAddress <> '' and tribCode in ['pw03','pw06','pw07','pw50'], RiskWise.flattenCount(le.combo_addrcount,2,1), '');
	self.hphonecount := if(le.phone10 <> '' and tribCode in ['pw03','pw06','pw07','pw50'], RiskWise.flattenCount(le.combo_hphonecount,2,1), '');
	self.socscount := if(le.ssn <> '' and tribCode in ['pw03','pw06','pw07','pw50'], RiskWise.flattenCount(le.combo_ssncount,2,1), '');
	self.socsverlevel := if(tribCode in ['pw03','pw06','pw07','pw50'], getSocsLevel(le.socsverlevel), '');
	self.dobcount := if(le.dob <> '' and tribCode in ['pw03','pw06','pw07','pw50'], RiskWise.flattenCount(le.combo_dobcount,2,1), '');
	self.drlccount := if(le.dl_number <> '' and tribCode in ['pw03','pw06','pw07','pw50'] and le.dl_number <> '', '0', '');
	self.cmpycount := if(le.employer_name <> '' and tribCode in ['pw03','pw06','pw07','pw50']/* and le.combo_cmpyscore>0*/,RiskWise.flattenCount(le.combo_cmpycount,2,1),'');
	
	self.verfirst := if(tribCode in ['pw03','pw06','pw07','pw50'], le.combo_first, '');
	self.verlast := if(tribCode in ['pw03','pw06','pw07','pw50'], le.combo_last, '');
	self.vercmpy := if(tribCode in ['pw03','pw06','pw07','pw50'], le.combo_cmpy, '');
	self.veraddr := if(tribCode in ['pw03','pw06','pw07','pw50'], Risk_Indicators.MOD_AddressClean.street_address('',le.combo_prim_range,le.combo_predir,le.combo_prim_name,le.combo_suffix,
																			le.combo_postdir,le.combo_unit_desig,le.combo_sec_range), '');
	self.vercity := if(tribCode in ['pw03','pw06','pw07','pw50'], le.combo_city, '');
	self.verstate := if(tribCode in ['pw03','pw06','pw07','pw50'], le.combo_state, '');
	self.verzip := if(tribCode in ['pw03','pw06','pw07','pw50'], le.combo_zip, '');
	self.verhphone := if(tribCode in ['pw03','pw06','pw07','pw50'], le.combo_hphone, '');
	self.versocs := if(tribCode in ['pw03','pw06','pw07','pw50'] and le.combo_ssncount > 0, le.combo_ssn, '');
	self.verdrlc := '';
	self.verdob := if(tribCode in ['pw03','pw06','pw07','pw50'], le.combo_dob, '');
	
	self.numelever := if(tribCode in ['pw03','pw06','pw07','pw50'], (string)((integer)(boolean)(integer)self.firstcount+(integer)(boolean)(integer)self.lastcount+(integer)(boolean)(integer)self.addrcount
																+(integer)(boolean)(integer)self.hphonecount+(integer)(boolean)(integer)self.socscount+(integer)(boolean)(integer)self.dobcount
																+(integer)(boolean)(integer)self.cmpycount), '');
	self.numsource := if(tribCode in ['pw03','pw06','pw07','pw50'], (string)((integer)self.firstcount+(integer)self.lastcount+(integer)self.cmpycount+(integer)self.addrcount
															   +(integer)self.hphonecount+(integer)self.socscount+(integer)self.dobcount), '');
	
	self.firstscore := if(le.fname <> '' and tribCode in ['pw03','pw06','pw07','pw50'], if(le.combo_firstscore=255, '0', (string)le.combo_firstscore), '');
	self.lastscore := if(le.lname <> '' and tribCode in ['pw03','pw06','pw07','pw50'], if(le.combo_lastscore=255, '0', (string)le.combo_lastscore), '');
	self.cmpyscore := if(le.employer_name <> '' and tribCode in ['pw03','pw06','pw07','pw50']/* and le.combo_cmpyscore>0*/, if(le.combo_cmpyscore=255, '0', (string)le.combo_cmpyscore), '');
	self.addrscore := if(le.in_streetAddress <> '' and tribCode in ['pw03','pw06','pw07','pw50'], if(le.combo_addrscore=255, '0', (string)le.combo_addrscore), '');
	self.hphonescore := if(le.phone10 <> '' and tribCode in ['pw03','pw06','pw07','pw50'], if(le.combo_hphonescore=255, '0', (string)le.combo_hphonescore), '');
	self.socsscore := if(le.ssn <> '' and tribCode in ['pw03','pw06','pw07','pw50'], if(le.combo_ssnscore=255, '0', (string)le.combo_ssnscore), '');
	self.dobscore := if(le.dob <> '' and tribCode in ['pw03','pw06','pw07','pw50'], if(le.combo_dobscore=255, '0', (string)le.combo_dobscore), '');
	self.drlcscore := if(le.dl_number <> '' and tribCode in ['pw03','pw06','pw07','pw50'], '0', '');
	
	self.wphonename := if(tribCode in ['pw03','pw06','pw07','pw50'], le.wphonename, '');
	self.wphoneaddr := if(tribCode in ['pw03','pw06','pw07','pw50'], le.wphoneaddr, '');
	self.wphonecity := if(tribCode in ['pw03','pw06','pw07','pw50'], le.wphonecity, '');
	self.wphonestate := if(tribCode in ['pw03','pw06','pw07','pw50'], le.wphonestate, '');
	self.wphonezip := if(tribCode in ['pw03','pw06','pw07','pw50'], le.wphonezip, '');
	
	self.socsmiskeyflag := if(tribCode in ['pw03','pw06','pw07','pw50'], (string)(integer)le.socsmiskeyflag, '');
	self.hphonemiskeyflag := if(tribCode in ['pw03','pw06','pw07','pw50'], (string)(integer)le.hphonemiskeyflag, '');
	self.addrmiskeyflag := if(tribCode in ['pw03','pw06','pw07','pw50'], (string)(integer)le.addrmiskeyflag, '');
	
	self.idtheftflag := if(tribCode in ['pw07','pw50'], le.idtheftflag, '');
	
	self.wphonetypeflag := if(tribCode in ['pw01','pw03','pw06','pw50'], le.wphonetypeflag, '');
	self.wphonevalflag := if(tribCode in ['pw01','pw03','pw06','pw50'], le.wphonevalflag, '');
	self.hphonetypeflag := if(tribCode in ['pw01','pw03','pw06','pw50'], le.hphonetypeflag, '');
	self.hphonevalflag := if(tribCode in ['pw01','pw03','pw06','pw50'], le.hphonevalflag, '');
	self.phonezipflag := if(tribCode in ['pw01','pw03','pw06','pw50'], le.PWphonezipflag, '');
	self.phonedissflag := if(tribCode in ['pw01','pw03','pw06','pw50'], (string)(integer)le.phonedissflag, '');
	self.addrvalflag := if(tribCode in ['pw01','pw03','pw06','pw50'], le.addrvalflag, '');
	self.dwelltypeflag := if(tribCode in ['pw01','pw03','pw06','pw50'], le.dwelltype, '');
	self.ziptypeflag := if(tribCode in ['pw01','pw03','pw06','pw50'], le.ziptypeflag, '');
	self.socsvalflag := if(tribCode in ['pw01','pw03','pw06','pw50'], le.PWsocsvalflag, '');
	self.decsflag := if(tribCode in ['pw01','pw03','pw06','pw50'], le.decsflag, '');
	self.socsdobflag := if(tribCode in ['pw01','pw03','pw06','pw50'], le.PWsocsdobflag, '');
	self.areacodesplitflag := if(tribCode in ['pw01','pw03','pw06','pw50'], map(le.phone10 = '' => '2',
																 le.areacodesplitflag = 'Y' => '1',
																 '0'), '');
	self.altareacode := if(tribCode in ['pw01','pw03','pw06','pw50'] and le.areacodesplitflag = 'Y', le.altareacode, '');
	self.bansflag := if(tribCode in ['pw01','pw03','pw06','pw50'], if(le.bansflag = '3', '0', le.bansflag), '');
	self.drlcvalflag := if(tribCode in ['pw01','pw03','pw06','pw50'], le.drlcvalflag, '');
	self.drlcsoundx := if(tribCode in ['pw01','pw03','pw06','pw50'], le.drlcsoundx, '');
	self.drlcfirst := if(tribCode in ['pw01','pw03','pw06','pw50'], le.drlcfirst, '');
	self.drlclast := if(tribCode in ['pw01','pw03','pw06','pw50'], le.drlclast, '');
	self.drlcmiddle := if(tribCode in ['pw01','pw03','pw06','pw50'], le.drlcmiddle, '');
	self.drlcsocs := if(tribCode in ['pw01','pw03','pw06','pw50'], le.drlcsocs, '');
	self.drlcdob := if(tribCode in ['pw01','pw03','pw06','pw50'], le.drlcdob, '');
	self.drlcgender := if(tribCode in ['pw01','pw03','pw06','pw50'], le.drlcgender, '');
	
	self.disthphonewphone := if(tribCode in ['pw01','pw03','pw06','pw50'] and le.disthphonewphone <> 9999, (string)le.disthphonewphone, '');
	self.distwphoneaddr := if(tribCode in ['pw01','pw03','pw06','pw50'] and le.distwphoneaddr <> 9999, (string)le.distwphoneaddr, '');
	
	self.statezipflag := if(tribCode in ['pw01','pw03','pw06','pw50'], le.statezipflag, '');
	self.cityzipflag := if(tribCode in ['pw01','pw03','pw06','pw50'], le.cityzipflag, '');
	self.hphonestateflag := if(tribCode not in ['pw07'], '0', '');
	
	self.checkacctflag := if(tribCode in ['pw50'],if(le.watchlist_table <> '', '1', '0'), '');
	
	self.cassaddr := if(tribCode in ['pw01','pw03','pw06','pw07','pw50'], Risk_Indicators.MOD_AddressClean.street_address('',le.prim_range,le.predir,le.prim_name,le.addr_suffix,le.postdir,le.unit_desig,le.sec_range), '');
	self.casscity := if(tribCode in ['pw01','pw03','pw06','pw07','pw50'], le.p_city_name, '');
	self.cassstate := if(tribCode in ['pw01','pw03','pw06','pw07','pw50'], le.st, '');
	self.casszip := if(tribCode in ['pw01','pw03','pw06','pw07','pw50'], le.z5+le.zip4, '');
	
	self.addrcommflag := if(tribCode in ['pw01','pw03','pw06','pw50'], le.addrcommflag, '');
	

	self.nonresname := map(tribCode in ['pw01','pw03','pw06','pw50'] and le.addrcommflag='1' => le.hriskcmpyphone,
					   tribCode in ['pw01','pw03','pw06','pw50'] and le.addrcommflag='2' => le.hriskcmpy,
					   '');
	self.nonressic := map(tribCode in ['pw01','pw03','pw06','pw50'] and le.addrcommflag='1' => RiskWise.convertSIC(le.hrisksicphone),
					  tribCode in ['pw01','pw03','pw06','pw50'] and le.addrcommflag='2' => RiskWise.convertSIC(le.hrisksic),
					  '');
	self.nonresphone := map(tribCode in ['pw01','pw03','pw06','pw50'] and le.addrcommflag='1' => le.hriskphonephone,
					    tribCode in ['pw01','pw03','pw06','pw50'] and le.addrcommflag='2' => le.hriskphone,
					    '');
	self.nonresaddr := map(tribCode in ['pw01','pw03','pw06','pw50'] and le.addrcommflag='1' => le.hriskaddrphone,
					   tribCode in ['pw01','pw03','pw06','pw50'] and le.addrcommflag='2' => le.hriskaddr,
					   '');
	self.nonrescity := map(tribCode in ['pw01','pw03','pw06','pw50'] and le.addrcommflag='1' => le.hriskcityphone,
					   tribCode in ['pw01','pw03','pw06','pw50'] and le.addrcommflag='2' => le.hriskcity,
					   '');
	self.nonresstate := map(tribCode in ['pw01','pw03','pw06','pw50'] and le.addrcommflag='1' => le.hriskstatephone,
					    tribCode in ['pw01','pw03','pw06','pw50'] and le.addrcommflag='2' => le.hriskstate,
					    '');
	self.nonreszip := map(tribCode in ['pw01','pw03','pw06','pw50'] and le.addrcommflag='1' => le.hriskzipphone,
					  tribCode in ['pw01','pw03','pw06','pw50'] and le.addrcommflag='2' => le.hriskzip,
					  '');
					  
	self.coaalertflag := '';
	self.aptscanflag := '';
	
	self.numfraud := if(tribCode in ['pw01','pw03','pw06','pw50'],
									RiskWise.getNumFraud(self.coaalertflag,self.aptscanflag,self.addrvalflag,self.decsflag,self.bansflag,self.drlcvalflag).PRWO(self.wphonetypeflag,
													 self.wphonevalflag,self.hphonetypeflag,self.hphonevalflag,self.phonezipflag,self.phonedissflag,self.socsvalflag,
													 self.socsdobflag,self.statezipflag,self.cityzipflag,self.hphonestateflag,self.addrcommflag), '');
	
		
	self := [];
END;
finalOutput := PROJECT(ret, format_out(left));


// get boca shell results for the models
clam := if(tribCode in ['pw03','pw06','pw07','pw50'], 
						risk_indicators.Boca_Shell_Function(ret, gateways, DPPA_Purpose, GLB_Purpose, false, false, true, false, false, true,DataRestriction := DataRestriction,DataPermission := DataPermission,
                                                                                        LexIdSourceOptout := LexIdSourceOptout, 
                                                                                        TransactionID := TransactionID, 
                                                                                        BatchUID := BatchUID, 
                                                                                        GlobalCompanyID := GlobalCompanyID),
						group(dataset([],Risk_Indicators.Layout_Boca_Shell),seq));	



getAir := if(tribCode in ['pw50'], Models.AIN602_1_0(clam, true), dataset([],Models.Layout_ModelOut));
		    
RiskWise.Layout_PRWO addModel(finalOutput le, getAir ri) := TRANSFORM
	self.airwavesscore := ri.score;
	self.nonreszip := le.nonreszip;
	self := le;
END;
withModel := join(finalOutput, getAir, left.seq=right.seq, addModel(left,right), left outer);


getScore2 := map(tribCode = 'pw07' => Models.FD9604_1_0(clam, true),
			  tribCode = 'pw06' => Models.FD9603_3_0(clam, true),
			  tribCode = 'pw03' => Models.FD9603_2_0(clam, true),
			  dataset([],Models.Layout_ModelOut));
			  
RiskWise.Layout_PRWO addModel2(withModel le, getScore2 ri) := TRANSFORM
	self.score2 := ri.score;
	self := le;
END;
final := join(withModel, getScore2, left.seq=right.seq, addModel2(left,right), left outer);			  


		   
critter := map(tribcode = 'pw01' => '001',
			tribcode = 'pw03' => '003',
			tribcode = 'pw06' => '006',
			tribcode = 'pw07' => '007',
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
output(dRoyalties, named('RoyaltySet'));

ENDMACRO;

// RiskWise.RiskWiseMainPRWO()