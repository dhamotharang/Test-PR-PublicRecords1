import ut, codes, address, business_risk, Risk_Indicators, Risk_Reporting, models, gateway;

export BC1O_Function(DATASET(Layout_BC1I) indata, dataset(Gateway.Layouts.Config) gateways, 
					unsigned1 glb, unsigned1 dppa, boolean isUtility=false, boolean ln_branded=false, string4 tribcode='',
					string50 DataRestriction=risk_indicators.iid_constants.default_DataRestriction,
					string50 DataPermission=risk_indicators.iid_constants.default_DataPermission) := function
	
// populate the input values to business instant id with the original input values
business_risk.Layout_Input into_bus_input(indata le) := transform

	clean_cmpy_addr := risk_indicators.MOD_AddressClean.clean_addr(le.cmpyaddr, le.cmpycity, le.cmpyState, le.cmpyZip ) ;														
	clean_addr := risk_indicators.MOD_AddressClean.clean_addr(le.addr, le.City, le.State, le.Zip ) ;														
		
	ssn_val := cleanSSN( le.socs );
	hphone_val := cleanPhone( le.hphone );
	wphone_val := cleanPhone( le.cmpyphone );
	dob_val := cleanDOB(le.dob);
	dl_num_clean := cleanDL_num( le.drlc );
	fein_val := cleanFEIN( le.fin );	

	self.seq := le.seq;
	self.historydate := le.historydate;
	self.Account := le.account; 
	self.bdid	:= 0;  
	self.score := 0;  
	self.company_name := stringlib.stringtouppercase(le.cmpy);
	self.alt_company_name := '';
	self.prim_range := clean_cmpy_addr[1..10];
	self.predir := clean_cmpy_addr[11..12];
	self.prim_name := clean_cmpy_addr[13..40];
	self.addr_suffix := clean_cmpy_addr[41..44];
	self.postdir := clean_cmpy_addr[45..46];
	self.unit_desig := clean_cmpy_addr[47..56];
	self.sec_range := clean_cmpy_addr[57..64];
	self.p_city_name := clean_cmpy_addr[90..114];
	self.v_city_name := clean_cmpy_addr[65..89];
	self.st := clean_cmpy_addr[115..116];
	self.z5 := clean_cmpy_addr[117..121];
	self.zip4 := clean_cmpy_addr[122..125];
	self.orig_z5 := le.cmpyzip;
	self.lat := clean_cmpy_addr[146..155];
	self.long := clean_cmpy_addr[156..166];
	
		// for Chase, override the address type, otherwise simply use the result from the address cleaner
	self.addr_type := if(tribcode in ['bnk4','cbbl'],
		risk_indicators.iid_constants.override_addr_type(le.cmpyaddr, clean_cmpy_addr[139],clean_cmpy_addr[126..129]),
		clean_cmpy_addr[139]);
		
	self.addr_status := clean_cmpy_addr[179..182];	
	self.county := clean_cmpy_addr[143..145];
	self.geo_blk := clean_cmpy_addr[171..177];
	self.fein		 := fein_val;
	self.phone10    := wphone_val;
	self.ip_addr	 := le.ipaddr;
	self.rep_fname	 := stringlib.stringtouppercase(le.first);
	self.rep_mname  := ''; // don't have one on input
	self.rep_lname  := stringlib.stringtouppercase(le.last);
	self.rep_name_suffix := ''; // don't have one on input
	self.rep_alt_Lname := ''; // don't have one on input
	self.rep_prim_range := clean_addr[1..10];
	self.rep_predir := clean_addr[11..12];
	self.rep_prim_name := clean_addr[13..40];
	self.rep_addr_suffix := clean_addr[41..44];
	self.rep_postdir := clean_addr[45..46];
	self.rep_unit_desig := clean_addr[47..56];
	self.rep_sec_range := clean_addr[57..64];
	self.rep_p_city_name := clean_addr[90..114];
	self.rep_st := clean_addr[115..116];
	self.rep_z5 := clean_addr[117..121];
	self.rep_zip4 := clean_addr[122..125];
	self.rep_lat := clean_addr[146..155];
	self.rep_long := clean_addr[156..166];
	
	// for Chase, override the address type, otherwise simply use the result from the address cleaner
	self.rep_addr_type := if(tribcode in ['bnk4','cbbl'],
		risk_indicators.iid_constants.override_addr_type(le.addr, clean_addr[139],clean_addr[126..129]),
		clean_addr[139]);
		
	self.rep_addr_status := clean_addr[179..182];
	self.rep_county := clean_addr[143..145];
	self.rep_geo_blk := clean_addr[171..177];
	self.rep_orig_city := stringlib.stringtouppercase(le.city);
	self.rep_orig_st := stringlib.stringtouppercase(le.state);
	self.rep_orig_z5 := le.zip[1..5];
	self.rep_ssn		:= ssn_val;	// blank out social if it is all 0's
	self.rep_dob		:= dob_val;
	self.rep_phone		:= hphone_val;
	self.rep_age 		:= if((integer)dob_val != 0, (STRING3)(ut.GetAgeI((integer)dob_val)), '');
	self.rep_dl_num := stringlib.stringtouppercase(dl_num_clean);
	self.rep_dl_state := stringlib.stringtouppercase(le.drlcstate);
	self.rep_email		:= stringlib.stringtouppercase(le.EMAILADDR);
end;

prep := project(indata,into_bus_input(LEFT));
biid_results := business_risk.InstantID_Function(prep,gateways,false,dppa,glb,isUtility,ln_branded,tribcode, 
	DataRestriction := DataRestriction, DataPermission := DataPermission);

xlayout := record
  unsigned6 RepDID;
	riskwise.Layout_BC1O;
	unsigned4 seq;
end;

// risk_indicators instant_id function returns 0-12, but this needs to get mapped to 0-8.  this conversion works for both nap and nas
UNSIGNED1 convertInstIDLevel(unsigned1 level) := MAP(level = 1 => 1,
									level = 4 => 2,
									level = 6 => 3,
									level = 7 => 4,
									level = 9 => 5,
									level = 10 => 6,
									level = 11 => 7,
									level = 12 => 8,
									0);	// 0,2,3,5,8 all translate into 0 on the 0-8 scale


layout_pt := record
	risk_indicators.Key_Telcordia_tpm_slim;
	string1 phonetype;
	string2 servicetype;
end;

r00 := '00';  // for concatenating reason codes together, make any that are blank equal to '00'

xlayout filloutput(biid_results le, indata rt) := transform
  self.RepDID := le.RepDid;
	self.seq := rt.seq;
	self.acctno := rt.acctno;
	self.account := rt.account;
	self.riskwiseid := (string)le.bdid; // for testing
	self.firstcount := if(rt.first='', '', flattencount(le.rep_firstcount, 2));
	self.lastcount := if(rt.last='', '', flattencount(le.rep_lastcount, 2));
	self.addrcount := if(rt.addr='', '', flattencount(le.rep_addrcount, 2));
	self.phonecount := if(rt.hphone='', '', flattencount(le.rep_hphonecount, 2));
	self.socscount := if(le.rep_ssn='', '', flattencount(le.rep_ssncount, 2));
	self.socsverlevel := (string)convertInstIDLevel((integer)le.RepNAS_Score);
	self.dobcount := if(rt.dob='', '', flattencount(le.rep_dobcount, 2));
	self.drlccount := '';
	self.cmpycount := if(rt.cmpy='', '', flattencount(le.cmpycount, 2));
	self.cmpyaddrcount := if(rt.cmpyaddr='', '', if(le.addr_type = 'P', '', flattencount(le.addrcount, 2)));
	self.cmpyphonecount := if(rt.cmpyphone='', '', flattencount(le.wphonecount, 2));
	self.fincount := IF(rt.fin = '', '', flattencount(le.feincount, 2));
	self.emailcount := '';	
	self.verfirst := le.RepFNameVerify;
	self.verlast := le.RepLNameVerify;
	self.veraddr := le.RepAddrVerify;
	self.vercity := le.RepCityVerify;
	self.verstate := le.RepStateVerify;
	self.verzip := le.RepZipVerify + le.RepZip4Verify;
	self.verhphone := le.RepPhoneVerify;
	self.versocs := if(le.rep_ssncount>0, le.RepSsnVerify, '');  // this is the same as checking the score to see if the socs can be returned
	self.verdrlc := ''; // always blank
	self.verdob := if((integer)le.RepDOBVerify=0,'',le.RepDOBVerify);
	self.vercmpy := le.vercmpy;
	self.vercmpyaddr := if(le.addr_type = 'P', '', le.veraddr);
	self.vercmpycity := if(le.addr_type = 'P', '', le.vercity);
	self.vercmpystate := if(le.addr_type = 'P', '', le.verstate);
	self.vercmpyzip := if(le.addr_type = 'P', '', le.verzip + le.verzip4);
	self.vercmpyphone := le.verphone;
	self.verfin := ''; // always blank
	self.numelever := (string)(if(self.firstcount>'0',1,0)+if(self.lastcount>'0',1,0)+if(self.addrcount>'0',1,0)+if(self.socscount>'0',1,0)+if(self.phonecount>'0',1,0)+if(self.dobcount>'0',1,0));			
	self.numsource := (string)((integer)self.firstcount+(integer)self.lastcount+(integer)self.addrcount+(integer)self.socscount+(integer)self.phonecount+(integer)self.dobcount);
	self.numcmpyelever := (string)(if(self.cmpycount>'0',1,0)+if(self.cmpyaddrcount>'0',1,0)+if(self.cmpyphonecount>'0',1,0));
	self.numcmpysource := (string)((integer)self.cmpycount+(integer)self.cmpyaddrcount+(integer)self.cmpyphonecount);
	self.firstscore := if(tribcode='cbbl', le.RepNas_score, if(rt.first='', '', (string)le.rep_firstscore));
	self.lastscore := if(tribcode='cbbl', le.RepNap_score, if(rt.last='', '', (string)le.rep_lastscore));
	self.cmpyscore := if(tribcode='cbbl',le.BNAS_Indicator, '');  // this one will always be empty, cmpyscore2 is populated
	self.addrscore := if(tribcode='cbbl',le.bnap_indicator, if(rt.addr='', '', (string)le.rep_addrscore) );
	self.phonescore := if(tribcode='cbbl',le.bnat_indicator, if(rt.hphone='', '', (string)le.rep_phonescore));
	self.socscore := if(le.rep_ssn='', '', (string)le.rep_socsscore);
	self.dobscore := if(rt.dob='', '', (string)le.rep_dobscore);
	self.cmpyscore2 := if(rt.cmpy='', '', (string)le.cnamescore);
	self.cmpyaddrscore := if(rt.cmpyaddr='', '', if(le.addr_type = 'P','0',(string)le.addrscore));
	self.cmpyphonescore := if(rt.cmpyphone='', '', (string)le.phonescore);
	self.drlcscore := '';// always blank
	self.finscore := '';// always blank
	self.emailscore := '';// always blank
	self.wphonename := le.PhoneMatchCompany;
	self.wphoneaddr := le.phoneMatchAddr;
	self.wphonecity := le.PhoneMatchCity;
	self.wphonestate := le.phoneMatchState;
	self.wphonezip := le.phoneMatchZip + le.phoneMatchZip4;
	self.socsmiskeyflag := if(le.rep_socsmiskeyflag,'1','0');
	self.phonemiskeyflag := if(le.rep_phonemiskeyflag, '1','0');
	self.addrmiskeyflag := if(le.rep_addrmiskeyflag, '1','0');	
	self.idtheftflag := '';// always blank
	hphonetelco := if(rt.hphone!='', riskwise.telcoPhoneType(rt.hphone), dataset([], layout_pt));
	
	self.hphonetypeflag := if(rt.hphone='' or hphonetelco[1].phonetype='', '5', hphonetelco[1].phonetype);  // if empty input or miss on telcordia, set to 5
	self.hphonesrvc := (string)if(rt.hphone='' or hphonetelco[1].servicetype='', 0, (integer)hphonetelco[1].servicetype); // if emtpy input or miss on telcordia, set to 0
	self.hphone2addrtypeflag := '';// always blank
	self.hphone2typeflag := '';// always blank
	wphonetelco := if(rt.cmpyphone!='', riskwise.telcoPhoneType(rt.cmpyphone), dataset([], layout_pt));
	
	self.wphonetypeflag := if(rt.cmpyphone='' or wphonetelco[1].phonetype='', '5', wphonetelco[1].phonetype);  // if empty input or miss on telcordia, set to 5
	self.wphonesrvc := (string)if(rt.cmpyphone='' or wphonetelco[1].servicetype='', 0, (integer)wphonetelco[1].servicetype); // if emtpy input or miss on telcordia, set to 0
	self.areacodesplitflag := map(le.rep_areacodesplitflag='Y' => '1',
							le.rep_reverse_areacodesplitflag='Y' => '2',
							'');
	self.altareacode := if(le.rep_areacodesplitflag='Y' or le.rep_reverse_areacodesplitflag='Y', le.rep_altareacode, '');
	self.phonezipflag := if(le.rep_phonezipmismatch in ['1','2'], '1', '0'); // always 1 or 0, never blank
	self.socsdob := le.rep_inputsocscode;
	self.hhriskphoneflag := if(le.rep_hriskphoneflag='0', '', le.rep_hriskphoneflag);
	self.hriskcmpy := le.rep_hriskcmpy;
	self.sic := le.rep_hrisksic;
	clean_addr := Risk_Indicators.MOD_AddressClean.clean_addr(rt.addr, rt.city, rt.state, rt.zip);
	
	self.zipclassflag := IF(le.zipclass in ['P','U','M'], le.zipclass,'');
	bnk4_zipname := IF(le.zipclass in ['P','U','M'], le.zipcity,'');
	
	pri1 := if(le.pri1='', r00, le.pri1[1..2]);
	pri2 := if(le.pri2='', r00, le.pri2[1..2]);
	pri3 := if(le.pri3='', r00, le.pri3[1..2]);
	pri4 := if(le.pri4='', r00, le.pri4[1..2]);
	pri5 := if(le.pri5='', r00, le.pri5[1..2]);
	pri6 := if(le.pri6='', r00, le.pri6[1..2]);
	bvi_reasons :=  pri1 + pri2 + pri3 + pri4 + pri5 + pri6;
	
	rpri1 := if(le.rep_pri1='', r00, le.rep_pri1[1..2]);
	rpri2 := if(le.rep_pri2='', r00, le.rep_pri2[1..2]);
	rpri3 := if(le.rep_pri3='', r00, le.rep_pri3[1..2]);
	rpri4 := if(le.rep_pri4='', r00, le.rep_pri4[1..2]);
	rpri5 := if(le.rep_pri5='', r00, le.rep_pri5[1..2]);
	rpri6 := if(le.rep_pri6='', r00, le.rep_pri6[1..2]);
	cvi_reasons := rpri1 + rpri2 + rpri3 + rpri4 + rpri5 + rpri6;
	
	bvi_cvi_reasons := bvi_reasons + cvi_reasons;

	self.zipname := if(tribcode='cbbl', bvi_cvi_reasons, bnk4_zipname);
	
	cens := riskwise.getCensus(clean_addr[115..116], clean_addr[143..145], clean_addr[171..177]);
	self.medincome :=  cens[1].income;
	self.addrriskflag := '';// leave blank, don't migrate
	self.bansflag := if(le.rep_bansflag in ['1', '2'], le.rep_bansflag, '0'); 
	self.bansdatefiled := le.rep_bansdatefiled;
	self.addrvalflag := le.rep_addrvalflag;
	acecode 		:=clean_addr[179..182];
	predir  		:=clean_addr[11..12];
	prim_name 	:=clean_addr[13..40];
	addr_suffix 	:=clean_addr[41..44];
	postdir 		:=clean_addr[45..46];
	st			:=clean_addr[115..116];
	self.addrreason := riskwise.certErr(acecode, predir, prim_name, addr_suffix,postdir, st);
	self.lowissue := le.RepSSNEarlyDate;
	self.dwelltypeflag := le.rep_dwelltype;
	self.phonedissflag := if(le.rep_phonedissflag, '1', '');  // blank or 1
	self.ecovariables := '';  // get this from the business defender model
	
	self.tcifull := le.bvi;    
	self.tcilast := le.ar2bi;  
	self.tciaddr := le.repcvi; 
	
end;

biid_ret := join(biid_results, indata, left.seq = right.seq, filloutput(left,right));

risk_indicators.layout_input into_iid(biid_results le) := transform
	self.seq := le.seq;
	self.fname := le.rep_fname;
	self.mname := le.rep_mname;
	self.lname := le.rep_lname;
	self.suffix := le.rep_name_suffix;
	addr1 := Risk_Indicators.MOD_AddressClean.street_address('',le.rep_prim_range, le.rep_predir, le.rep_prim_name,
							le.rep_addr_suffix, le.rep_postdir, le.rep_unit_desig, le.rep_sec_range);
	self.in_streetAddress := addr1;
	self.in_city := le.rep_orig_city;
	self.in_state := le.rep_orig_st;
	self.in_zipcode := le.rep_orig_z5;
	self.in_country := le.rep_country;
  ca := Risk_Indicators.MOD_AddressClean.clean_addr(addr1, le.rep_orig_city, le.rep_orig_st, le.rep_orig_z5);	
	self.prim_range := ca[1..10];
	self.predir := ca[11..12];
	self.prim_name := ca[13..40];
	self.addr_suffix := ca[41..44];
	self.postdir := ca[45..46];
	self.unit_desig := ca[47..56];
	self.sec_range := ca[57..64];
	self.p_city_name := ca[90..114];
	self.st := ca[115..116];
	self.z5 := ca[117..121];
	self.zip4 := ca[122..125];
	self.lat := ca[146..155];
	self.long := ca[156..166];
		// for Chase, override the address type, otherwise simply use the result from the address cleaner
	self.addr_type := if(tribcode in ['bnk4','cbbl'],
		risk_indicators.iid_constants.override_addr_type(addr1, ca[139],ca[126..129]),
		ca[139]);
	// self.addr_type := ca[139];
	self.addr_status := ca[179..182];
	self.county := ca[143..145];
	self.geo_blk := ca[171..177];
	self.country := le.rep_country;
	self.ssn := le.rep_ssn;
	self.dob := le.rep_dob;
	self.age := le.rep_age;
	self.phone10 := le.rep_phone;
	self.wphone10 := le.phone10;
	self.dl_number := le.rep_dl_num;
	self.dl_state := le.rep_dl_state;
	self.email_address := le.rep_email;
	self.ip_address := le.ip_addr;
	self.employer_name := le.company_name;
	self.lname_prev := le.rep_alt_lname;
	//self := [];
end;
ciid_prep := project(biid_results, into_iid(left));

	suppressNearDups := true;
	// was set to true to get the scores to match exactly to what BusinessAdvisor was returning, set back to true to be consistent with behavior of the rest of the query
	require2Ele      := false;  
	from_biid        := true;
	isFCRA           := false;
	ofac_only := true;
	bsversion := 2;
	
iid := risk_indicators.InstantID_Function(ciid_prep, gateways, dppa, glb, isUtility, ln_branded, 
		ofac_only, suppressNearDups, require2Ele, from_biid, isFCRA, in_bsversion := bsversion, 
		in_DataRestriction := DataRestriction, in_DataPermission := DataPermission);
			
clam := risk_indicators.Boca_Shell_Function(group(sort(iid,seq),seq), gateways, dppa, glb, isUtility, ln_branded, 
	true, false, false, true, bsversion := bsversion, DataRestriction := DataRestriction, DataPermission := DataPermission);

// from Models.BusinessAdvisor_Service with few changes:
riskwise.Layout_BusReasons_Input into_orig_input(biid_results le, indata ri) := transform
	addr           := ri.cmpyaddr;
	city           := ri.cmpycity;
	state          := ri.cmpystate;
	zip            := ri.cmpyzip;
	company_name   := ri.cmpy;
	busphone_value := ri.cmpyphone;
	fein           := ri.fin;


	self.seq := le.seq;
	self.orig_addr := stringlib.stringtouppercase(addr);
	self.orig_city := stringlib.stringtouppercase(city);
	self.orig_state := stringlib.stringtouppercase(state);
	self.orig_zip := zip;
	self.orig_fax := '';
	self.orig_cmpy := stringlib.stringtouppercase(company_name);
	self.orig_wphone := busphone_value;
	self.telcoPhoneType := le.TelcordiaPhoneType;
	
	bans_current := if(((integer)(ut.GetDate[1..6]) - (integer)(le.RecentBkDate[1..6])) < 1000, true, false);  // make sure the bans is within the last 10 years
	lien_current := if(((integer)(ut.GetDate[1..6]) - (integer)(le.RecentLienDate[1..6])) < 1000, true, false);  // make sure the bans is within the last 10 years
	self.cmpy_bans :=  map(fein='' or (company_name='' and addr='') => '3',
											  le.bkbdidflag and le.lienbdidflag and bans_current and lien_current => '5',
										       le.bkbdidflag and bans_current => '2', 
											  le.lienbdidflag and lien_current => '4',
						   					   '0');								   
end;

// orig_input := project(biid_results, into_orig_input(left));
orig_input := join(biid_results, indata, left.seq=right.seq, into_orig_input(left,right));
// end from Models.BusinessAdvisor_Service


model := group(Models.BD3605_0_0( clam, biid_results, orig_input, OFAC:=false, nugen:=true ),seq);



xlayout add_model(biid_ret le, model rt) := transform
	self.ecovariables := rt.score;
	self.socscore := if(tribcode='cbbl', rt.ri[1].hri[1..2], le.socscore);
	self.dobscore := if(tribcode='cbbl', rt.ri[2].hri[1..2], le.dobscore);
	self.drlcscore := if(tribcode='cbbl', rt.ri[3].hri[1..2], le.drlcscore);
	self.cmpyscore2 := if(tribcode='cbbl', rt.ri[4].hri[1..2], le.cmpyscore2);
	self := le;
end;

withBusinessModel := join(biid_ret, model, left.seq=right.seq, add_model(left,right));

bs_with_ip := record
	risk_indicators.Layout_Boca_Shell bs;
	riskwise.Layout_IP2O ip;
end;

fp_input := ungroup(project(clam, transform(bs_with_ip, self.bs := left, self.ip := [])));


// cbbl needs 4 reason codes 
num_reason := 4;
fp_model := models.FP3710_0_0(fp_input, 4);

xlayout append_fraudpoint(withBusinessModel le, fp_model rt) := transform
	self.cmpyaddrscore := if(tribcode='cbbl', rt.score, le.cmpyaddrscore);
	self.sic := if(tribcode='cbbl', rt.ri[1].hri[1..2] + rt.ri[2].hri[1..2] + rt.ri[3].hri[1..2], le.sic);  // first 3 reason codes from fraudpoint mapped into sic field for cbbl
	
	bvi_cvi_reasons := le.zipname[1..24] ;
	// position 1..2 is the 4th fraudpoint reason code, the next 3..14 are bvi reason codes, and 15..26 are cvi reason codes
	self.zipname := if(tribcode='cbbl', rt.ri[4].hri[1..2] + bvi_cvi_reasons, le.zipname);
	
	self := le;
end;

// output(biid_results, named('biid_results'));
// output(biid_ret, named('biid_ret'));
// output(model, named('business_model'));
// output(withBusinessModel, named('withBusinessModel'));

final := join(withBusinessModel, fp_model, left.seq=right.seq, append_fraudpoint(left,right) );

/* *************************************
 *   Boca Shell Logging Functionality  *
 * NOTE: Because of the #stored below  *
 * this MUST go at the end of this     *
 * function in order to compile.       *
 ***************************************/
productID := Risk_Reporting.ProductID.RiskWise__RiskWiseMainBC1O;
	
intermediate_Log := Risk_Reporting.To_LOG_Boca_Shell(clam, productID, bsVersion);
#stored('Intermediate_Log', intermediate_log);
/* ************ End Logging ************/

return final;

end;
