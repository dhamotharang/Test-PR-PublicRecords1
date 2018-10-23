/*--SOAP--
<message name="St. Cloud Main Service WF2O">
	<part name="tribcode" type="xsd:string"/>
	<part name="account" type="xsd:string"/>
	<part name="apptype" type="xsd:string"/>
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
	<part name="grade" type="xsd:string"/>
	<part name="score" type="xsd:string"/>
	<part name="DPPAPurpose" type="xsd:byte"/>
	<part name="GLBPurpose" type="xsd:byte"/>
	<part name="DataRestrictionMask" type="xsd:string"/>
	<part name="DataPermissionMask" type="xsd:string"/>
	<part name="HistoryDateYYYYMM" type="xsd:integer"/>
	<part name="runSeed" type="xsd:boolean"/>
	<part name="gateways" type="tns:XmlDataSet" cols="70" rows="25"/>
	<part name="OutcomeTrackingOptOut" type="xsd:boolean"/>
 </message>
*/
/*--INFO-- 'wfs2', 'wfs3', 'wfs4' */
    
import address, Risk_Indicators, Models, gateway, Royalty, MDR;

    
export RiskWiseMainWF2O := MACRO

	/* ************************************************************************
	 *                      Force the order on the WsECL page                 *
	 ************************************************************************ */
	#WEBSERVICE(FIELDS(
		'tribcode',		 		
		'account',		 		
		'apptype',
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
		'grade',
		'score',
		'DPPAPurpose',
		'GLBPurpose',
		'DataRestrictionMask',
		'DataPermissionMask',
		'HistoryDateYYYYMM',
		'runSeed',
		'gateways',
		'OutcomeTrackingOptOut'
	));

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
	Industry_Search := Inquiry_AccLogs.Key_Inquiry_industry_use_vertical_login(FALSE)(s_company_id = CompanyID and s_product_id = (String)Risk_Reporting.ProductID.RiskWise__RiskWiseMainWF2O);
/* ************* End Scout Fields **************/

// Can't have duplicate definitions of Stored with different default values, 
// so add the default to #stored to eliminate the assignment of a default value.
#stored('GLBPurpose',RiskWise.permittedUse.fraudGLBA);
#stored('DataRestrictionMask',risk_indicators.iid_constants.default_DataRestriction);

string4  tribCode_value := ''	 		: stored('tribcode');
string30 account_value := '' 			: stored('account');
string1  apptype_value := ''			: stored('apptype');
string15 first_value := ''     		: stored('first');
string20 last_value := ''     		: stored('last');
string30 cmpy_value := ''   			: stored('cmpy');
string50 addr_value := ''    			: stored('addr');
string30 city_value := ''      		: stored('city');
string2  state_value := ''      	: stored('state');
string5  zip_value := ''      		: stored('zip');
string9  socs_value := ''      		: stored('socs');
string8  dob_value := ''      		: stored('dob');
string10 hphone_value := ''   		: stored('hphone');
string10 wphone_value := ''  			: stored('wphone');
string20 drlc_value := ''     		: stored('drlc');
string2  drlcstate_value := ''    : stored('drlcstate');
string6  income_value := ''				: stored('income');
string50 prevaddr_value := ''			: stored('prevaddr');
string30 prevcity_value := ''			: stored('prevcity');
string2  prevstate_value := ''		: stored('prevstate');
string5  prevzip_value := ''			: stored('prevzip');
string10 prevphone_value := ''		: stored('prevphone');
string1  internetcommflag_value := ''	: stored('internetcommflag');
string50 email_value := ''  			: stored('Email');
string50 emailheader_value := ''	: stored('emailheader');
string45 ipaddr_value := ''      	: stored('ipaddr');	
string2  numphones_value := ''		: stored('numphones');
string2  prodcat_value := ''			: stored('prodcat');
string8  appdate_value := ''			: stored('appdate');
string6  apptime_value := ''			: stored('apptime');
string11 checkaba_value := ''			: stored('checkaba');
string9  checkacct_value := ''		: stored('checkacct');
string7  checknum_value := ''			: stored('checknum');
string40 bankname_value := ''			: stored('bankname');
string2  pymtmethod_value := ''		: stored('pymtmethod');
string1  cctype_value := ''				: stored('cctype');
string16 ccnum_value := ''				: stored('ccnum');
string8  ccexpdate_value := ''		: stored('ccexpdate');
string5  grade_value := ''				: stored('grade');
string3  score_value := ''				: stored('score');
boolean  runSeed_value := false 	: stored('runSeed');

grade_val := Stringlib.stringtouppercase(grade_value);

string DataRestriction := risk_indicators.iid_constants.default_DataRestriction : stored('DataRestrictionMask');
string50 DataPermission  := Risk_Indicators.iid_constants.default_DataPermission : stored('DataPermissionMask');
unsigned1 DPPA_Purpose := RiskWise.permittedUse.fraudDPPA 		: stored('DPPAPurpose');
unsigned1 GLB_Purpose := RiskWise.permittedUse.fraudGLBA  		: stored('GLBPurpose');
unsigned3 history_date := 999999  							: stored('HistoryDateYYYYMM');
gateways_in := Gateway.Configuration.Get();

tribCode := StringLib.StringToLowerCase(tribCode_value);
boolean Log_trib := tribCode in ['wfs3', 'wfs4'];

productSet := ['wfs2','wfs3', 'wfs4'];
testseedSet := ['wfs3', 'wfs4'];
targusGatewaySet := ['wfs2','wfs3', 'wfs4'];

Gateway.Layouts.Config gw_switch(gateways_in le) := TRANSFORM
	self.servicename := le.servicename;
	self.url := if(tribcode in targusGatewaySet and le.servicename = 'targus', le.url, ''); // default to no gateway call			 
	self := le;
END;
gateways := project(gateways_in, gw_switch(left));

rec := RECORD
	unsigned4 seq;
END;
d := dataset([{(unsigned)account_value}],rec);


risk_indicators.layout_input into(rec l) := TRANSFORM
	clean_a2 := Risk_Indicators.MOD_AddressClean.clean_addr(addr_value, city_value, state_value, zip_value);
	
	ssn_val := RiskWise.cleanSSN( socs_value );
	hphone_val := RiskWise.cleanPhone( hphone_value );
	wphone_val := RiskWise.cleanPhone( wphone_value );
	dob_val := RiskWise.cleanDOB( dob_value);
	dl_num_clean := RiskWise.cleanDL_num( drlc_value );

	self.seq := l.seq;
	self.historydate := history_date;
	self.ssn := ssn_val;
	self.dob := dob_val;
	
	self.phone10 := hphone_val;	
	self.wphone10 := wphone_val;	
	
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
	
	self.employer_name := stringlib.stringtouppercase(cmpy_value);
	
	self := [];
END;
prep := PROJECT(d,into(LEFT));

BSversion := if(tribcode in ['wfs3', 'wfs4'], 2, 1);

ret := risk_indicators.InstantID_Function(prep, gateways, DPPA_Purpose, GLB_Purpose, false, false, true, true, true, in_bsversion := bsversion, in_DataRestriction:=datarestriction, in_DataPermission:=dataPermission);

dRoyalties :=if(runSeed_value and tribcode in testseedSet, dataset([], Royalty.Layouts.Royalty),
								Royalty.RoyaltyTargus.GetOnlineRoyalties(UNGROUP(ret), src, TargusType, TRUE, FALSE, FALSE, TRUE));												
			 
string2 getSocsLevel(unsigned1 level) := map(level in [0,2,3,5,8] => '0',
									level = 1 => '1',
									level = 4 => '2',
									level = 6 => '3',
									level = 7 => '4',
									(string)(level-4));	// 9,10,11,12 results in 5,6,7,8

RiskWise.Layout_WF2O format_out(Risk_Indicators.Layout_Output le) := TRANSFORM
	self.seq := le.seq;
	self.account := account_value;
	self.riskwiseid := (string)le.did;
	
	self.inputPresent := if(le.fname='' and le.lname='' and le.in_streetAddress='' and le.ssn='' and le.dob='' and le.phone10='' and le.wphone10='', false, true);

	self.firstcount := if(le.fname<>'',RiskWise.flattenCount(le.combo_firstcount,1,1),'');
	self.lastcount := if(le.lname<>'',RiskWise.flattenCount(le.combo_lastcount,1,1),'');
	self.addrcount := if(le.in_streetAddress<>'',RiskWise.flattenCount(le.combo_addrcount,1,1),'');
	self.hphonecount := if(le.phone10<>'',RiskWise.flattenCount(le.combo_hphonecount,1,1),'');
	self.socscount := if(le.ssn<>'',RiskWise.flattenCount(le.combo_ssncount,1,1),'');
	self.socsverlevel := getSocsLevel(le.socsverlevel);
	self.dobcount := if(le.dob<>'',RiskWise.flattenCount(le.combo_dobcount,1,1),'');
	self.drlccount := if(le.dl_number<>'' and le.dl_number<>'','0','');
	self.cmpycount := if(le.employer_name<>'' and le.combo_cmpyscore<>255,RiskWise.flattenCount(le.combo_cmpycount,1,1),'');
	
	self.verfirst := le.combo_first;
	self.verlast := le.combo_last;
	self.vercmpy := le.combo_cmpy;
	self.veraddr := Risk_Indicators.MOD_AddressClean.street_address('',le.combo_prim_range,le.combo_predir,le.combo_prim_name,le.combo_suffix,le.combo_postdir,le.combo_unit_desig,le.combo_sec_range);
	self.vercity := le.combo_city;
	self.verstate := le.combo_state;
	self.verzip := le.combo_zip;
	self.verhphone := le.combo_hphone;
	self.versocs := if(le.combo_ssncount>0,le.combo_ssn,'');
	self.verdob := le.combo_dob;
	
	self.numelever := (string)le.numelever;
	self.numsource := (string)((integer)self.firstcount+(integer)self.lastcount+(integer)self.cmpycount+(integer)self.addrcount+(integer)self.hphonecount+
						  (integer)self.socscount+(integer)self.dobcount);
	
	self.firstscore := if(le.fname<>'',if(le.combo_firstscore=255, '0',(string)le.combo_firstscore),'');
	self.lastscore := if(le.lname<>'',if(le.combo_lastscore=255, '0',(string)le.combo_lastscore),'');
	self.cmpyscore := if(le.employer_name<>''and le.combo_cmpyscore<>255,if(le.combo_cmpyscore=255, '0',(string)le.combo_cmpyscore),'');
	self.addrscore := if(le.in_streetAddress<>'',if(le.combo_addrscore=255, '0',(string)le.combo_addrscore),'');
	self.hphonescore := if(le.phone10<>'',if(le.combo_hphonescore=255, '0',(string)le.combo_hphonescore),'');
	self.socsscore := if(le.ssn<>'',if(le.combo_ssnscore=255, '0',(string)le.combo_ssnscore),'');
	self.dobscore := if(le.dob<>'',if(le.combo_dobscore=255, '0',(string)le.combo_dobscore),'');
	self.drlcscore := if(le.dl_number<>'','0','');
	
	self.wphonename := le.wphonename;
	self.wphoneaddr := le.wphoneaddr;
	self.wphonecity := le.wphonecity;
	self.wphonestate := le.wphonestate;
	self.wphonezip := le.wphonezip;
	
	self.socsmiskeyflag := (string)(integer)le.socsmiskeyflag;
	self.hphonemiskeyflag := (string)(integer)le.hphonemiskeyflag;
	self.addrmiskeyflag := (string)(integer)le.addrmiskeyflag;
	
	self.idtheftflag := le.idtheftflag;
	
	self.wphonetypeflag := le.wphonetypeflag;
	self.wphonevalflag := le.wphonevalflag;
	self.hphonetypeflag := le.hphonetypeflag;
	self.hphonevalflag := le.hphonevalflag;
	self.phonezipflag := le.PWphonezipflag;
	self.phonedissflag := (string)(integer)le.phonedissflag;
	self.addrvalflag := le.addrvalflag;
	self.dwelltypeflag := le.dwelltype;
	self.ziptypeflag := le.ziptypeflag;
	self.socsvalflag := le.PWsocsvalflag;
	self.decsflag := le.decsflag;
	self.socsdobflag := le.PWsocsdobflag;
	self.areacodesplitflag := map(le.phone10='' => '2',									  
							le.areacodesplitflag = 'Y' => '1',
							'0');	
	self.altareacode := if(le.areacodesplitflag='Y',le.altareacode,'');
	self.bansflag := if(le.bansflag = '3','0',le.bansflag);
	self.drlcvalflag := le.drlcvalflag;
	self.drlcsoundx := le.drlcsoundx;
	self.drlcfirst := le.drlcfirst;
	self.drlclast := le.drlclast;
	self.drlcmiddle := le.drlcmiddle;
	self.drlcsocs := le.drlcsocs;
	self.drlcdob := le.drlcdob;
	self.drlcgender := le.drlcgender;
	
	self.disthphonewphone := if(le.disthphonewphone<>9999,(string)le.disthphonewphone,'');
	self.distwphoneaddr := if(le.distwphoneaddr<>9999,(string)le.distwphoneaddr,'');
	
	self.statezipflag := le.statezipflag;
	self.cityzipflag := le.cityzipflag;
	self.hphonestateflag :=  '0';
	
	self.checkacctflag := if(le.watchlist_table<>'','1','0');
	
	self.cassaddr := Risk_Indicators.MOD_AddressClean.street_address('',le.prim_range,le.predir,le.prim_name,le.addr_suffix,le.postdir,le.unit_desig,le.sec_range);
	self.casscity := le.p_city_name;
	self.cassstate := le.st;
	self.casszip := le.z5+le.zip4;
	
	self.addrcommflag := le.addrcommflag;
	
	
	self.nonresname := map(le.addrcommflag='1' => le.hriskcmpyphone,
					   le.addrcommflag='2' => le.hriskcmpy,
					   '');
	self.nonressic := map(le.addrcommflag='1' => RiskWise.convertSIC(le.hrisksicphone),
					  le.addrcommflag='2' => RiskWise.convertSIC(le.hrisksic),
					  '');
	self.nonresphone := map(le.addrcommflag='1' => le.hriskphonephone,
					    le.addrcommflag='2' => le.hriskphone,
					    '');
	self.nonresaddr := map(le.addrcommflag='1' => le.hriskaddrphone,
					   le.addrcommflag='2' => le.hriskaddr,
					   '');
	self.nonrescity := map(le.addrcommflag='1' => le.hriskcityphone,
					   le.addrcommflag='2' => le.hriskcity,
					   '');
	self.nonresstate := map(le.addrcommflag='1' => le.hriskstatephone,
					    le.addrcommflag='2' => le.hriskstate,
					    '');
	self.nonreszip := map(le.addrcommflag='1' => le.hriskzipphone,
					  le.addrcommflag='2' => le.hriskzip,
					  '');	
	
	self.numfraud := RiskWise.getNumFraud('0','0',self.addrvalflag,self.decsflag,self.bansflag,self.drlcvalflag).PRWO(self.wphonetypeflag,
													self.wphonevalflag,self.hphonetypeflag,self.hphonevalflag,self.phonezipflag,self.phonedissflag,self.socsvalflag,
													self.socsdobflag,self.statezipflag,self.cityzipflag,self.hphonestateflag,self.addrcommflag);
	
	verfied_residence := [8, 12];
	socialsource_verified_residence := le.socsverlevel in verfied_residence;
	phonelisting_verified_residence := le.phoneverlevel in verfied_residence;
	high_risk_address := le.hriskaddrflag<>'0';
	address_not_most_recent := le.inputAddrNotMostRecent;
	
	disconnected_or_no_phonelisting := map(le.phoneaddr_firstcount > 0 and 
								le.phoneaddr_lastcount > 0 and 
								le.phoneaddr_addrcount > 0 => le.phoneaddr_disconnected, 
								le.phonefirstcount > 0 and
								le.phonelastcount > 0 and
								le.phoneaddrcount > 0 => le.phone_disconnected,
								// if it got this far, and all we have left is utility that may be verifying first/last/addr
								// set disconnect = true because we have no idea if utility listing is recent
								true);
									
	wachovia_POR_flag := if( (socialsource_verified_residence or 
												(phonelisting_verified_residence and ~disconnected_or_no_phonelisting)) 
												and high_risk_address=false
												and address_not_most_recent=false, '1', '0');
												
	original_tciaddrflag := if(le.combo_firstcount>0 and le.combo_lastcount>0 and le.combo_addrcount>0, '1','0');

	// wachovia uses 3 and 4, leave 2 alone because American Express uses that one
	self.tciaddrflag := if(tribcode in ['wfs3','wfs4'], wachovia_POR_flag, original_tciaddrflag);
		
	self := [];
END;
final := PROJECT(ret, format_out(LEFT));
														
includeRelativeInfo := true;
includeDLInfo := false;
includeVehInfo := false;
includeDerogInfo := true;
														
// get boca shell results for the models
clam := if(tribCode in ['wfs2','wfs3','wfs4'], 
				risk_indicators.Boca_Shell_Function(ret, gateways, DPPA_Purpose, GLB_Purpose, 
																		false, false, 
																		includeRelativeInfo, includeDLInfo, includeVehInfo, includeDerogInfo, 
																		BSversion,datarestriction:=datarestriction,datapermission:=datapermission),
				group(dataset([],Risk_Indicators.Layout_Boca_Shell),seq));

getAir := map(tribCode = 'wfs2' => Models.AIN605_2_0(clam, true, grade_val), 
							tribCode in ['wfs3', 'wfs4'] => Models.AIN801_1_0(clam, true, grade_val),
							Models.AIN605_3_0(clam, true) );

RiskWise.Layout_WF2O addModel(final le, getAir ri) := TRANSFORM
	self.airwavesscore := ri.Score;
	self.reason1 := if(Risk_Indicators.rcSet.isCode36(ri.ri[1].hri), '36', ri.ri[1].hri);
	self.reason2 := ri.ri[2].hri;
	self.reason3 := ri.ri[3].hri;
	self.reason4 := ri.ri[4].hri;
	
	
	wfs2_doOutput := tribCode='wfs2' and 
														( (grade_val not in ['C1','B3','B1','A2','A1','A0'] or 
														(grade_val='C1' and (integer)ri.score<=570) or
														(grade_val='B3' and (integer)ri.score<=560) or 
														(grade_val in ['B1','A2','A1','A0'] and (integer)ri.score<=528)) );
	wfs4_doOutput := tribCode='wfs4' and 
														( (grade_val in ['A0', 'A1','A2', 'B1'] and (integer)ri.score<=580 ) or
															(grade_val in ['B3','C1','C2'] and (integer)ri.score<=590 ) );
	
	// Becki confirmed with customer that they still want wfs3 to output the way it was instead of matching wfs4 vdata output rules
	doOutput := if(le.inputPresent and (tribCode='wfs3' or wfs2_doOutput or wfs4_doOutput ), true, false);	
	
	self.doOutput := doOutput;
	self.datareturn := if(doOutput, 'Y', 'N');
	self := le;
END;
withModel := join(final, getAir, left.seq=right.seq, addModel(left,right), left outer);


riskwise.Layout_WF2O createEmpty(withModel le) := TRANSFORM
	self.seq := le.seq;
  self.riskwiseid := le.riskwiseid;
	self.account := account_value;
	self.airwavesscore := if(le.inputPresent, le.airwavesscore, '');
	self.tciaddrflag := le.tciaddrflag;
	self.reason1 := if(le.inputPresent, le.reason1, '');
	self.reason2 := if(le.inputPresent, le.reason2, '');
	self.reason3 := if(le.inputPresent, le.reason3, '');
	self.reason4 := if(le.inputPresent, le.reason4, '');
	self.datareturn := 'N';
	self := [];
END;
emptyset := project(withModel, createEmpty(left));


riskwise.Layout_WF2O filter_final(withModel le, emptyset rt) := TRANSFORM
	self := if(le.doOutput, le, rt);
END;
final2 := join(withModel, emptySet, left.seq=right.seq, filter_final(left,right));


tribCheck := if(tribCode in ['wfs2','wfs3','wfs4'], ungroup(final2), dataset([],RiskWise.Layout_WF2O));

critter := map(tribcode = 'wfs3' => '003',
							 tribcode = 'wfs4' => '004',
																		'');

seed_files.mac_query_seedfiles(socs_value, 'wf2o', 'prii', critter, prii_seed_output);

riskwise.Layout_WF2O format_seed(prii_seed_output le) := TRANSFORM
	self.account := account_value;
	self.billing := [];
	self := le;
	self := [];
END;

final_seed := if(runSeed_value, project(prii_seed_output, format_seed(left)), dataset([], riskwise.Layout_WF2O));

finalOutput := if(tribCode in productSet,
			   if(count(final_seed)>0 and runSeed_value and tribCode in testseedSet, final_seed, tribCheck),
			      dataset([],RiskWise.Layout_WF2O));

//Log to Deltabase
Deltabase_Logging_prep := project(finalOutput, transform(Risk_Reporting.Layouts.LOG_Deltabase_Layout_Record,
																								 self.company_id := (Integer)CompanyID,
																								 self.login_id := _LoginID,
																								 self.product_id := Risk_Reporting.ProductID.RiskWise__RiskWiseMainWF2O,
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
																								 self.o_score_1    := left.airwavesscore,
																								 self.o_reason_1_1 := left.reason1,
																								 self.o_reason_1_2 := left.reason2,
																								 self.o_reason_1_3 := left.reason3,
																								 self.o_reason_1_4 := left.reason4,
																								 self.o_score_2    := left.score2;
																								 self.o_lexid := (Integer)left.riskwiseid,  //did
																								 self := left,
																								 self := [] ));
Deltabase_Logging := DATASET([{Deltabase_Logging_prep}], Risk_Reporting.Layouts.LOG_Deltabase_Layout);
// #stored('Deltabase_Log', Deltabase_Logging);

//Improved Scout Logging
IF(~DisableOutcomeTracking and Log_trib and ~runSeed_value, OUTPUT(Deltabase_Logging, NAMED('LOG_log__mbs_transaction__log__scout')));

output(finalOutput, NAMED('Results'));
output(dRoyalties, named('RoyaltySet'));

ENDMACRO;
// RiskWise.RiskWiseMainWF2O()