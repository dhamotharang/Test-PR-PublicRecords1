/*--SOAP--
<message name="Phone Identification">
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
	<part name="cmpy" type="xsd:string"/>
	<part name="DPPAPurpose" type="xsd:byte"/>
	<part name="GLBPurpose" type="xsd:byte"/> 
	<part name="HistoryDateYYYYMM" type="xsd:integer"/>
	<part name="DataRestrictionMask" type="xsd:string"/>
	<part name="DataPermissionMask" type="xsd:string"/>
	<part name="gateways" type="tns:XmlDataSet" cols="70" rows="25"/>
 </message>
*/
/*--INFO-- Migrating pil2 and trg1 to boca */

import risk_indicators, gateway, Riskwise, STD, risk_indicators;

export RiskWiseMainPI2O := MACRO

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
	'cmpy',
	'DPPAPurpose',
	'GLBPurpose', 
	'HistoryDateYYYYMM',
	'DataRestrictionMask',
	'DataPermissionMask',
	'gateways',
    'LexIdSourceOptout',
    '_TransactionId',
    '_BatchUID',
    '_GCID'));

string4  tribCode_value := ''  	: stored('tribcode');	// not used in prii
string30 account_value := ''  	: stored('account');
string20 first_value := ''   		: stored('first');
string1  middleini_value := ''    	: stored('middleini');
string20 last_value := ''     	: stored('last');
string50 addr_value := ''     	: stored('addr');
string25 city_value := ''     	: stored('city');
string2  state_value := ''     	: stored('state');
string5  zip_value := ''       	: stored('zip');
string20 hphone_value := ''    	: stored('hphone');
string20 cmpy_value := ''    		: stored('cmpy');
string DataRestriction := risk_indicators.iid_constants.default_DataRestriction : stored('DataRestrictionMask');
string50 DataPermission  := Risk_Indicators.iid_constants.default_DataPermission : stored('DataPermissionMask');
unsigned1 DPPA_Purpose := RiskWise.permittedUse.fraudDPPA : stored('DPPAPurpose');
unsigned1 GLB_Purpose := RiskWise.permittedUse.fraudGLBA : stored('GLBPurpose');
unsigned3 history_date := 999999 : stored('HistoryDateYYYYMM');
boolean isUtility := false;
boolean ln_branded := false;
boolean ofac_only := true;
boolean suppressNearDups := true;
boolean require2Ele := false;

gateways_in := Gateway.Configuration.Get();

//CCPA fields
unsigned1 LexIdSourceOptout := 1 : STORED('LexIdSourceOptout');
string TransactionID := '' : STORED('_TransactionId');
string BatchUID := '' : STORED('_BatchUID');
unsigned6 GlobalCompanyId := 0 : STORED('_GCID');

tribcode := STD.Str.ToLowerCase(tribCode_value);

Gateway.Layouts.Config gw_switch(gateways_in le) := transform
	self.servicename := le.servicename;
	self.url := map(tribcode='pil2' and le.servicename = 'targus' => le.url,
				 ''); // default to no gateway call			
	self := le;			 
end;

gateways := project(gateways_in, gw_switch(left));

r := record
	unsigned4 seq;
end;
d := dataset([{0}], r);
risk_indicators.layout_input into_input(d le, integer C) := transform
	clean_a := Risk_Indicators.MOD_AddressClean.clean_addr(addr_value, city_value, state_value, zip_value);
	
	hphone_val := RiskWise.cleanPhone( hphone_value );
	
	self.seq := c;
	self.historydate := history_date;
	self.fname := STD.Str.touppercase(first_value);
	self.lname := STD.Str.touppercase(last_value);
	self.in_streetAddress := STD.Str.touppercase(addr_value);
	self.in_city := STD.Str.touppercase(city_value);
	self.in_state := STD.Str.touppercase(state_value);
	self.in_zipCode := zip_value;
	self.prim_range := clean_a[1..10];
	self.predir := clean_a[11..12];
	self.prim_name := clean_a[13..40];
	self.addr_suffix := clean_a[41..44];
	self.postdir := clean_a[45..46];
	self.unit_desig := clean_a[47..56];
	self.sec_range := clean_a[57..64];
	self.p_city_name := clean_a[90..114];
	self.st := clean_a[115..116];
	self.z5 := clean_a[117..121];
	self.zip4 := clean_a[122..125];
	self.lat := clean_a[146..155];
	self.long := clean_a[156..166];
	self.addr_type := clean_a[139];
	self.addr_status := clean_a[179..182];
	self.county := clean_a[143..145];
	self.geo_blk := clean_a[171..177];
	self.phone10 := hphone_val;
	self.employer_name := STD.Str.touppercase(cmpy_value);	
	self := [];
end;

prep := project(d,into_input(LEFT, counter));
  
iid_results := risk_indicators.InstantID_Function(prep,gateways,dppa_purpose,glb_purpose,isUtility,ln_branded, 
			ofac_only, suppressneardups, require2Ele,in_DataRestriction := DataRestriction,in_DataPermission := DataPermission,
            LexIdSourceOptout := LexIdSourceOptout, 
            TransactionID := TransactionID, 
            BatchUID := BatchUID, 
            GlobalCompanyID := GlobalCompanyID);
//output(iid_results);
dRoyalties :=Royalty.RoyaltyTargus.GetOnlineRoyalties(UNGROUP(iid_results), src, TargusType, TRUE, FALSE, FALSE, TRUE);

STRING2 getSocsLevel(UNSIGNED1 level) := MAP(level in [0,2,3,5,8] => '00',
									level = 1 => '01',
									level = 4 => '02',
									level = 6 => '03',
									level = 7 => '04',
									intformat((level-4),2,1));	// 9,10,11,12 results in 5,6,7,8

RiskWise.Layout_PI2O format_out(iid_results le) := TRANSFORM
	
	samephone := MAP(le.phonever_type = 'P' => true,
				  le.phonever_type = 'A' => IF(le.phone10[1..6] = le.dirsaddr_phone[1..6], true, false),
				  false);
				  
	comp_bnap(unsigned2 local_phonecmpycount, unsigned2 local_phoneaddrcount, unsigned2 local_phonephonecount, boolean local_samephone) := 
					 MAP(local_phonecmpycount >0 and local_phoneaddrcount >0 and local_phonephonecount >0 =>	'08',
						local_phonecmpycount >0 and local_phoneaddrcount >0 and local_samephone =>			'07',
						local_phonecmpycount >0 and local_phonephonecount >0 =>						'06',
						local_phoneaddrcount >0 and local_phonephonecount >0 =>						'05',
						local_phonecmpycount >0 and local_phoneaddrcount >0 => 						'04',
						local_phonecmpycount=0 and local_samephone => 								'03',
						local_phoneaddrcount=0 and local_samephone => 								'02',
						'01');
						
	dophone := comp_bnap(le.phonecmpycount, le.phoneaddrcount, le.phonephonecount, samephone);
	doaddr := comp_bnap(le.phoneaddr_cmpycount, le.phoneaddr_addrcount, le.phoneaddr_phonecount, samephone);

	dirs_firstmatch := Risk_Indicators.g(le.dirs_firstscore);
	dirs_lastmatch := Risk_Indicators.g(le.dirs_lastscore);
	dirs_addrmatch := Risk_Indicators.ga(le.dirs_addrscore);	
	dirsaddr_firstmatch := Risk_Indicators.g(le.dirsaddr_firstscore);
	dirsaddr_lastmatch := Risk_Indicators.g(le.dirsaddr_lastscore);
	dirsaddr_addrmatch := Risk_Indicators.ga(le.dirsaddr_addrscore);
	utili_firstmatch := Risk_Indicators.g(le.utili_firstscore);
	utili_lastmatch := Risk_Indicators.g(le.utili_lastscore);
	utili_addrmatch := Risk_Indicators.ga(le.utili_addrscore);
					
	SELF.account := account_value;
	SELF.riskwiseid := (STRING)le.did;									// outputting the did here, doug should not use this
     SELF.hriskphoneflag := le.hriskphoneflag;
     SELF.phonevalflag := le.phonevalflag;
     SELF.phonezipflag := le.phonezipflag;
	
	SELF.areacodesplitflag := MAP(le.areacodesplitflag = 'Y' => '1',
							le.phone10 = '' => '2',
							'');
     SELF.altareacode := IF(le.areacodesplitflag = 'Y', le.altareacode, '');
     SELF.splitdate := IF(le.areacodesplitflag = 'Y', le.areacodesplitdate, '');
     SELF.phoneverlevel := getSocsLevel(le.phoneverlevel);

	self.cmpyphoneverlevel := if(tribcode='trg1', CASE(le.phonever_type,	'P'	=>	IF(le.dirscmpy!='', dophone, '00'),
															'A' 	=> 	IF(le.dirsaddr_cmpy!='', doaddr, '00'),
																	'00'), '');

     SELF.nameaddrverlevel := if(tribcode='trg1',MAP(SELF.phoneverlevel = '8' => '04',
						    SELF.phoneverlevel = '7' => '03',
						    le.phonever_type = 'P' => MAP(dirs_firstmatch AND dirs_lastmatch AND dirs_addrmatch => '04',
												    dirs_lastmatch AND dirs_addrmatch => '03',
												    dirs_firstmatch AND dirs_addrmatch => '02',
												    dirs_addrmatch AND le.prim_range = le.dirs_prim_range => '01',
												    '00'),
						    le.phonever_type = 'A' => MAP(dirsaddr_firstmatch AND dirsaddr_lastmatch AND dirsaddr_addrmatch => '04',
												    dirsaddr_lastmatch AND dirsaddr_addrmatch => '03',
												    dirsaddr_firstmatch AND dirsaddr_addrmatch => '02',
												    dirsaddr_addrmatch AND le.prim_range = le.dirsaddr_prim_range => '01',
												    '00'),
						    le.phonever_type = 'U' => MAP(utili_firstmatch AND utili_lastmatch AND utili_addrmatch => '04',
												    utili_lastmatch AND utili_addrmatch => '03',
												    utili_firstmatch AND utili_addrmatch => '02',
												    utili_addrmatch AND le.prim_range = le.utili_prim_range => '01',
												    '00'),
						    '00'), '');
     SELF.bldgnumverlevel := if(tribcode='trg1',MAP(le.phonever_type = 'P' => MAP(le.prim_range = le.dirs_prim_range AND le.dirs_prim_range <> '' AND SELF.nameaddrverlevel <> '01' AND SELF.nameaddrverlevel <> '02' => '02',
												   le.prim_range <> le.dirs_prim_range AND le.dirs_prim_range <> '' AND SELF.nameaddrverlevel <> '01' AND SELF.nameaddrverlevel <> '02' => '01',
												   '00'),
						   le.phonever_type = 'A' => MAP(le.prim_range = le.dirsaddr_prim_range AND le.dirsaddr_prim_range <> '' AND SELF.nameaddrverlevel <> '01' AND SELF.nameaddrverlevel <> '02' => '02',
												   le.prim_range <> le.dirsaddr_prim_range AND le.dirsaddr_prim_range <> '' AND SELF.nameaddrverlevel <> '01' AND SELF.nameaddrverlevel <> '02' => '01',
												   '00'),
						   le.phonever_type = 'U' => MAP(le.prim_range = le.utili_prim_range AND le.utili_prim_range <> '' AND SELF.nameaddrverlevel <> '01' AND SELF.nameaddrverlevel <> '02' => '02',
												   le.prim_range <> le.utili_prim_range AND le.utili_prim_range <> '' AND SELF.nameaddrverlevel <> '01' AND SELF.nameaddrverlevel <> '02' => '01',
												   '00'),
						   '00'), '');	

	
	SELF.first := if(tribcode='trg1', MAP(le.phonever_type = 'P' => le.dirsfirst,
				   le.phonever_type = 'A' => le.dirsaddr_first,
				   le.phonever_type = 'U' => le.utilifirst,
				   ''), '');
     SELF.last := if(tribcode='trg1', MAP(le.phonever_type = 'P' => le.dirslast,
				  le.phonever_type = 'A' => le.dirsaddr_last,
				  le.phonever_type = 'U' => le.utililast,
				  ''), '');
     SELF.addr := if(tribcode='trg1', MAP(le.phonever_type = 'P' => Risk_Indicators.MOD_AddressClean.street_address('',le.dirs_prim_range,le.dirs_predir,le.dirs_prim_name,le.dirs_suffix,le.dirs_postdir,'',le.dirs_sec_range),
			       le.phonever_type = 'A' => Risk_Indicators.MOD_AddressClean.street_address('',le.dirsaddr_prim_range,le.dirsaddr_predir,le.dirsaddr_prim_name,le.dirsaddr_suffix,le.dirsaddr_postdir,'',le.dirsaddr_sec_range),
				  le.phonever_type = 'U' => Risk_Indicators.MOD_AddressClean.street_address('',le.utili_prim_range,le.utili_predir,le.utili_prim_name,le.utili_suffix,le.utili_postdir,'',le.utili_sec_range),
				  ''), '');
	SELF.city := if(tribcode='trg1', MAP(le.phonever_type = 'P' => le.dirscity,
				  le.phonever_type = 'A' => le.dirsaddr_city,
				  le.phonever_type = 'U' => le.utilicity,
				  ''), '');
     SELF.state := if(tribcode='trg1', MAP(le.phonever_type = 'P' => le.dirsstate,
				   le.phonever_type = 'A' => le.dirsaddr_state,
				   le.phonever_type = 'U' => le.utilistate,
				   ''), '');
     SELF.zip := if(tribcode='trg1', MAP(le.phonever_type = 'P' => le.dirszip,
				 le.phonever_type = 'A' => le.dirsaddr_zip,
				 le.phonever_type = 'U' => le.utilizip,
				 ''), '');
     SELF.cmpy := if(tribcode='trg1', MAP(le.phonever_type = 'P' => le.dirscmpy,
				 le.phonever_type = 'A' => le.dirsaddr_cmpy,
				 ''), '');
     SELF.hphone := if(tribcode='trg1', MAP(le.phonever_type = 'P' => le.phone10,
				    le.phonever_type = 'A' => le.dirsaddr_phone,
				    le.phonever_type = 'U' => le.utiliphone,
				 ''), '');
     SELF.privflag := if(tribcode='trg1', if(le.dirs_prim_name = '' AND le.dirsaddr_prim_name = '', '', /*'P'*/ ''), '');  
	// todo: add logic here to check for non-pub hit and set this privacy flag to P if the phone data came from targus gateway
		
     SELF.internalcode := '';
     SELF.internalcode2 := '';
     SELF.first2 := if(tribcode='pil2', MAP(le.phonever_type = 'P' => le.dirsfirst,
				   le.phonever_type = 'A' => le.dirsaddr_first,
				   le.phonever_type = 'U' => le.utilifirst,
				   ''), '');
     SELF.last2 := if(tribcode='pil2', MAP(le.phonever_type = 'P' => le.dirslast,
				  le.phonever_type = 'A' => le.dirsaddr_last,
				  le.phonever_type = 'U' => le.utililast,
				  ''), '');
     SELF.addr2 := if(tribcode='pil2', MAP(le.phonever_type = 'P' => Risk_Indicators.MOD_AddressClean.street_address('',le.dirs_prim_range,le.dirs_predir,le.dirs_prim_name,le.dirs_suffix,le.dirs_postdir,'',le.dirs_sec_range),
			       le.phonever_type = 'A' => Risk_Indicators.MOD_AddressClean.street_address('',le.dirsaddr_prim_range,le.dirsaddr_predir,le.dirsaddr_prim_name,le.dirsaddr_suffix,le.dirsaddr_postdir,'',le.dirsaddr_sec_range),
				  le.phonever_type = 'U' => Risk_Indicators.MOD_AddressClean.street_address('',le.utili_prim_range,le.utili_predir,le.utili_prim_name,le.utili_suffix,le.utili_postdir,'',le.utili_sec_range),
				  ''), '');
	SELF.city2 := if(tribcode='pil2', MAP(le.phonever_type = 'P' => le.dirscity,
				  le.phonever_type = 'A' => le.dirsaddr_city,
				  le.phonever_type = 'U' => le.utilicity,
				  ''), '');
     SELF.state2 := if(tribcode='pil2', MAP(le.phonever_type = 'P' => le.dirsstate,
				   le.phonever_type = 'A' => le.dirsaddr_state,
				   le.phonever_type = 'U' => le.utilistate,
				   ''), '');
     SELF.zip2 := if(tribcode='pil2', MAP(le.phonever_type = 'P' => le.dirszip,
				 le.phonever_type = 'A' => le.dirsaddr_zip,
				 le.phonever_type = 'U' => le.utilizip,
				 ''), '');						
END;

ret := PROJECT(iid_results, format_out(LEFT));

output(ret, named('Results'));
output(dRoyalties, named('RoyaltySet'));

ENDMACRO;
// RiskWise.RiskWiseMainPI2O()