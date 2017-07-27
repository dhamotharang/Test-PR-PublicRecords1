import ut, address, Risk_Indicators, Models, RiskWise, gateway;

export SD1O_Function_FCRA(dataset(RiskWise.Layout_SD1I) indata, dataset(Gateway.Layouts.Config) gateways, 
unsigned1 glb, unsigned1 dppa, string4 tribCode,
string50 DataRestriction=risk_indicators.iid_constants.default_DataRestriction,
string50 DataPermission=risk_indicators.iid_constants.default_DataPermission,
boolean UsePersonContext) := 

FUNCTION

Risk_Indicators.Layout_BocaShell_BtSt_In into_btst_in(indata le) := TRANSFORM
	// Clean BillTo
	clean_a := Risk_Indicators.MOD_AddressClean.clean_addr(le.addr, le.city, le.state, le.zip);
	
	ssn_val := RiskWise.cleanSSN( le.socs );
	hphone_val := RiskWise.cleanPhone( le.hphone );
	wphone_val := RiskWise.cleanPhone( le.wphone );
	dob_val := riskwise.cleanDOB(le.dob);
	dl_num_clean := RiskWise.cleanDL_num( le.drlc );
	
	self.seq := le.seq;
	
	self.bill_to_in.historydate := le.historydate;
	self.Bill_To_In.seq := le.seq;
	self.Bill_To_In.fname := stringlib.stringtouppercase(le.first);
	self.Bill_To_In.lname := stringlib.stringtouppercase(le.last);
	self.Bill_To_In.in_streetAddress := stringlib.stringtouppercase(le.addr);
	self.Bill_To_In.in_city := stringlib.stringtouppercase(le.city);
	self.Bill_To_In.in_state := stringlib.stringtouppercase(le.state);
	self.Bill_To_In.in_zipCode := le.zip;
	self.Bill_To_In.prim_range := clean_a[1..10];
	self.Bill_To_In.predir := clean_a[11..12];
	self.Bill_To_In.prim_name := clean_a[13..40];
	self.Bill_To_In.addr_suffix := clean_a[41..44];
	self.Bill_To_In.postdir := clean_a[45..46];
	self.Bill_To_In.unit_desig := clean_a[47..56];
	self.Bill_To_In.sec_range := clean_a[57..64];
	self.Bill_To_In.p_city_name := clean_a[90..114];
	self.Bill_To_In.st := clean_a[115..116];
	self.Bill_To_In.z5 := if(clean_a[117..121]<>'', clean_a[117..121], le.zip[1..5]);	// use the input zip if cass zip is empty
	self.Bill_To_In.zip4 := if(clean_a[122..125]<>'', clean_a[122..125], le.zip[6..9]);	// use the input zip if cass zip is empty
	self.Bill_To_In.lat := clean_a[146..155];
	self.Bill_To_In.long := clean_a[156..166];
	self.Bill_To_In.addr_type := clean_a[139];
	self.Bill_To_In.addr_status := clean_a[179..182];
	self.Bill_To_In.county := clean_a[143..145];
	self.Bill_To_In.geo_blk := clean_a[171..177];
	self.Bill_To_In.ssn	:= ssn_val;
	self.Bill_To_In.dob	:= dob_val;
	self.Bill_To_In.age := if ((integer)dob_val != 0, (string3)ut.GetAgeI((integer)dob_val), '');
	self.Bill_To_In.dl_number := stringlib.stringtouppercase(dl_num_clean);
	self.Bill_To_In.dl_state := stringlib.stringtouppercase(le.drlcstate);
	self.Bill_To_In.email_address	:= le.email;
	self.Bill_To_In.phone10 := hphone_val;
	self.Bill_To_In.wphone10 := wphone_val;
	self.Bill_To_In.employer_name := stringlib.stringtouppercase(le.cmpy);	
	
	// Clean ShipTo
	clean_a2 := Risk_Indicators.MOD_AddressClean.clean_addr(le.addr2, le.city2, le.state2, le.zip2);
	
	ssn_val2 := RiskWise.cleanSSN( le.socs2 );
	hphone_val2 := RiskWise.cleanSSN( le.hphone2 );
	wphone_val2 := RiskWise.cleanSSN( le.wphone2 );
	dob_val2 := riskwise.cleanDOB(le.dob2);
	dl_num_clean2 := RiskWise.cleanDL_num( le.drlc2 );
	
	self.ship_to_in.historydate := le.historydate;
	self.Ship_To_In.seq := le.seq;
	self.Ship_To_In.fname := stringlib.stringtouppercase(le.first2);
	self.Ship_To_In.lname := stringlib.stringtouppercase(le.last2);
	self.Ship_To_In.in_streetAddress := stringlib.stringtouppercase(le.addr2);
	self.Ship_To_In.in_city := stringlib.stringtouppercase(le.city2);
	self.Ship_To_In.in_state := stringlib.stringtouppercase(le.state2);
	self.Ship_To_In.in_zipCode := le.zip2;
	self.Ship_To_In.prim_range := clean_a2[1..10];
	self.Ship_To_In.predir := clean_a2[11..12];
	self.Ship_To_In.prim_name := clean_a2[13..40];
	self.Ship_To_In.addr_suffix := clean_a2[41..44];
	self.Ship_To_In.postdir := clean_a2[45..46];
	self.Ship_To_In.unit_desig := clean_a2[47..56];
	self.Ship_To_In.sec_range := clean_a2[57..64];
	self.Ship_To_In.p_city_name := clean_a2[90..114];
	self.Ship_To_In.st := clean_a2[115..116];
	self.Ship_To_In.z5 := if(clean_a2[117..121]<>'', clean_a2[117..121], le.zip2[1..5]);	// use the input zip if cass zip is empty
	self.Ship_To_In.zip4 := if(clean_a2[122..125]<>'', clean_a2[122..125], le.zip2[6..9]);	// use the input zip if cass zip is empty
	self.Ship_To_In.lat := clean_a2[146..155];
	self.Ship_To_In.long := clean_a2[156..166];
	self.Ship_To_In.addr_type := clean_a2[139];
	self.Ship_To_In.addr_status := clean_a2[179..182];
	self.Ship_To_In.county := clean_a2[143..145];
	self.Ship_To_In.geo_blk := clean_a2[171..177];
	self.Ship_To_In.ssn	:= ssn_val2;
	self.Ship_To_In.dob	:= dob_val2;
	self.Ship_To_In.age := if((integer)dob_val2 != 0, (string)ut.GetAgeI((integer)dob_val2), '');
	self.Ship_To_In.dl_number := stringlib.stringtouppercase(dl_num_clean2);
	self.Ship_To_In.dl_state := stringlib.stringtouppercase(le.drlcstate2);
	self.Ship_To_In.email_address	:= le.email2;
	self.Ship_To_In.phone10 := hphone_val2;
	self.Ship_To_In.wphone10 := wphone_val2;
	self.Ship_To_In.employer_name := stringlib.stringtouppercase(le.cmpy2);	
	self := [];
END;
prep := project(indata, into_btst_in(LEFT));


clamtest := Risk_Indicators.BocaShell_BtSt_Function_FCRA(prep, gateways, dppa, glb, false, false, false, false, false, false, true,datarestriction:=datarestriction,datapermission:=datapermission);
									
risk_indicators.layout_boca_shell into_modelinput(clamtest le, integer i) := TRANSFORM
	self := if(i=1, le.bill_to_out, le.ship_to_out);
END;
clam := project(clamtest, into_modelinput(left,1));
clam2 := project(clamtest, into_modelinput(left,2));



// intermediate results
working_layout := RECORD
	RiskWise.Layout_SD1O;
	unsigned4 seq;
	boolean inCalif;
	boolean inCalif2;
	boolean doOutput;
	boolean doOutput2; 
END;


			 
working_layout fill_output(clamtest le, indata ri) := TRANSFORM
	self.doOutput := if(ri.first='' and ri.last='' and ri.addr='' and ri.socs='' and ri.dob='' and ri.hphone='' and ri.wphone='', false, true);
	self.doOutput2 := if(ri.first2='' and ri.last2='' and ri.addr2='' and ri.socs2='' and ri.dob2='' and ri.hphone2='' and ri.wphone2='', false, true);
						
	self.inCalif := ri.apptypeflag = '4' and ((integer)(boolean)le.bill_to_out.iid.combo_firstcount+(integer)(boolean)le.bill_to_out.iid.combo_lastcount+
									  (integer)(boolean)le.bill_to_out.iid.combo_addrcount+(integer)(boolean)le.bill_to_out.iid.combo_hphonecount+
									  (integer)(boolean)le.bill_to_out.iid.combo_ssncount+(integer)(boolean)le.bill_to_out.iid.combo_dobcount)<3;
		
	self.seq := ri.seq;
	self.account := ri.account;
	self.acctno := ri.acctno;
	self.riskwiseid := (string)le.bill_to_out.did;
	
	self.score2 := if(self.inCalif, '000', '');
	
	boolean isSameHouseP := le.bill_to_out.iid.dirs_prim_name <> '';//le.bill_to_out.shell_input.prim_range <> '' and le.bill_to_out.iid.dirs_prim_range <> '' and trim(le.bill_to_out.shell_input.prim_range) = trim(le.bill_to_out.iid.dirs_prim_range);
	unsigned1 addrNum := map(le.bill_to_out.shell_input.prim_name <> '' and le.bill_to_out.iid.chronoprim_range <> '' and trim(le.bill_to_out.shell_input.prim_name) = trim(le.bill_to_out.iid.chronoprim_range) => 1,
						le.bill_to_out.shell_input.prim_name <> '' and le.bill_to_out.iid.chronoprim_range2 <> '' and trim(le.bill_to_out.shell_input.prim_name) = trim(le.bill_to_out.iid.chronoprim_range2) => 2,
						0);
	
	self.verfirst := map(isSameHouseP => le.bill_to_out.iid.dirsfirst,
					 addrNum = 1 or addrNum = 2 => le.bill_to_out.iid.verfirst,
					 '');
	self.verlast := map(isSameHouseP => le.bill_to_out.iid.dirslast,
					addrNum = 1 or addrNum = 2 => le.bill_to_out.iid.verlast,
					'');
	self.vercmpy := if(isSameHouseP, le.bill_to_out.iid.dirscmpy, '');
	self.veraddr := map(isSameHouseP => Risk_Indicators.MOD_AddressClean.street_address('',le.bill_to_out.iid.dirs_prim_range,le.bill_to_out.iid.dirs_predir,le.bill_to_out.iid.dirs_prim_name,
													    le.bill_to_out.iid.dirs_suffix,le.bill_to_out.iid.dirs_postdir,le.bill_to_out.iid.dirs_unit_desig,le.bill_to_out.iid.dirs_sec_range),
					addrNum = 1 => Risk_Indicators.MOD_AddressClean.street_address('',le.bill_to_out.iid.chronoprim_range, le.bill_to_out.iid.chronopredir,le.bill_to_out.iid.chronoprim_name, le.bill_to_out.iid.chronosuffix,
													   le.bill_to_out.iid.chronopostdir, le.bill_to_out.iid.chronounit_desig, le.bill_to_out.iid.chronosec_range),
					addrNum = 2 => Risk_Indicators.MOD_AddressClean.street_address('',le.bill_to_out.iid.chronoprim_range2, le.bill_to_out.iid.chronopredir2,le.bill_to_out.iid.chronoprim_name2, le.bill_to_out.iid.chronosuffix2,
													   le.bill_to_out.iid.chronopostdir2, le.bill_to_out.iid.chronounit_desig2, le.bill_to_out.iid.chronosec_range2),
					'');
	self.vercity := map(isSameHouseP => le.bill_to_out.iid.dirscity,
				     addrNum = 1 => le.bill_to_out.iid.chronocity,
				     addrNum = 2 => le.bill_to_out.iid.chronocity2,
				     '');
	self.verstate := map(isSameHouseP => le.bill_to_out.iid.dirsstate,
				     addrNum = 1 => le.bill_to_out.iid.chronostate,
				     addrNum = 2 => le.bill_to_out.iid.chronostate2,
				     '');
	SElF.verzip := map(isSameHouseP => le.bill_to_out.iid.dirszip,
				    addrNum = 1 => le.bill_to_out.iid.chronozip,
				    addrNum = 2 => le.bill_to_out.iid.chronozip2,
				    '');
	self.versocs := if(~isSameHouseP, if(addrNum = 1 or addrNum = 2, le.bill_to_out.iid.combo_ssn, ''), '');
	self.verhphone := if(isSameHouseP, ri.hphone/*le.bill_to_out.iid.dirsphone*/, '');


	// Second Input data	
	self.inCalif2 := ri.apptypeflag2 = '4' and ((integer)(boolean)le.ship_to_out.iid.combo_firstcount+(integer)(boolean)le.ship_to_out.iid.combo_lastcount+
									    (integer)(boolean)le.ship_to_out.iid.combo_addrcount+(integer)(boolean)le.ship_to_out.iid.combo_hphonecount+
									    (integer)(boolean)le.ship_to_out.iid.combo_ssncount+(integer)(boolean)le.ship_to_out.iid.combo_dobcount)<3;
									    
	boolean isSameHouseP2 := le.ship_to_out.iid.dirs_prim_name <> '';//le.ship_to_out.shell_input.prim_range <> '' and le.ship_to_out.iid.dirs_prim_range <> '' and trim(le.ship_to_out.shell_input.prim_range) = trim(le.ship_to_out.iid.dirs_prim_range);
	unsigned1 addrNum2 := map(le.ship_to_out.shell_input.prim_name <> '' and le.ship_to_out.iid.chronoprim_range <> '' and trim(le.ship_to_out.shell_input.prim_name) = trim(le.ship_to_out.iid.chronoprim_range) => 1,
						le.ship_to_out.shell_input.prim_name <> '' and le.ship_to_out.iid.chronoprim_range2 <> '' and trim(le.ship_to_out.shell_input.prim_name) = trim(le.ship_to_out.iid.chronoprim_range2) => 2,
						0);
	
	self.score4 := if(self.inCalif2, '000', '');
	
	self.verfirst2 := map(isSameHouseP2 => le.ship_to_out.iid.dirsfirst,
					  addrNum2 = 1 or addrNum2 = 2 => le.ship_to_out.iid.verfirst,
					  '');
	self.verlast2 := map(isSameHouseP2 => le.ship_to_out.iid.dirslast,
					 addrNum2 = 1 or addrNum2 = 2 => le.ship_to_out.iid.verlast,
					 '');
	self.vercmpy2 := if(isSameHouseP2, le.ship_to_out.iid.dirscmpy, '');
	self.veraddr2 := map(isSameHouseP2 => Risk_Indicators.MOD_AddressClean.street_address('',le.ship_to_out.iid.dirs_prim_range,le.ship_to_out.iid.dirs_predir,le.ship_to_out.iid.dirs_prim_name,
													      le.ship_to_out.iid.dirs_suffix,le.ship_to_out.iid.dirs_postdir,le.ship_to_out.iid.dirs_unit_desig,le.ship_to_out.iid.dirs_sec_range),
					 addrNum2 = 1 => Risk_Indicators.MOD_AddressClean.street_address('',le.ship_to_out.iid.chronoprim_range, le.ship_to_out.iid.chronopredir,le.ship_to_out.iid.chronoprim_name, le.ship_to_out.iid.chronosuffix,
													     le.ship_to_out.iid.chronopostdir, le.ship_to_out.iid.chronounit_desig, le.ship_to_out.iid.chronosec_range),
					 addrNum2 = 2 => Risk_Indicators.MOD_AddressClean.street_address('',le.ship_to_out.iid.chronoprim_range2, le.ship_to_out.iid.chronopredir2,le.ship_to_out.iid.chronoprim_name2, le.ship_to_out.iid.chronosuffix2,
													     le.ship_to_out.iid.chronopostdir2, le.ship_to_out.iid.chronounit_desig2, le.ship_to_out.iid.chronosec_range2),
					 '');
	self.vercity2 := map(isSameHouseP2 => le.ship_to_out.iid.dirscity,
				      addrNum2 = 1 => le.ship_to_out.iid.chronocity,
				      addrNum2 = 2 => le.ship_to_out.iid.chronocity2,
				      '');
	self.verstate2 := map(isSameHouseP2 => le.ship_to_out.iid.dirsstate,
					  addrNum2 = 1 => le.ship_to_out.iid.chronostate,
				       addrNum2 = 2 => le.ship_to_out.iid.chronostate2,
				       '');
	SElF.verzip2 := map(isSameHouseP2 => le.ship_to_out.iid.dirszip,
				     addrNum2 = 1 => le.ship_to_out.iid.chronozip,
				     addrNum2 = 2 => le.ship_to_out.iid.chronozip2,
				     '');
	self.versocs2 := if(~isSameHouseP2, if(addrNum2 = 1 or addrNum2 = 2, le.ship_to_out.iid.combo_ssn, ''), '');
	self.verhphone2 := if(isSameHouseP2, ri.hphone2/*le.ship_to_out.iid.dirsphone*/, '');
	
	// Per Bug 58288 - EQ99 logging in no longer necessary, removing.
	self.billing := dataset([],risk_indicators.Layout_Billing);

	self := [];
END;
mapped_results := join(clamtest, indata, left.bill_to_out.seq = (right.seq*2), fill_output(left,right), left outer);




getScore2 := Models.TBD605_0_0(clam, true, mapped_results[1].inCalif);


working_layout addBTmodel(mapped_results le, getScore2 ri) := TRANSFORM
	self.score2 := if(le.score2 <> '000' or ri.score in ['101','102','103','104','105'], ri.score, le.score2);
	self.reason12 := if(Risk_Indicators.rcSet.isCode36(ri.ri[1].hri), '36', ri.ri[1].hri);
	self.reason22 := ri.ri[2].hri;
	self.reason32 := ri.ri[3].hri;
	self.reason42 := ri.ri[4].hri;
	
	isFreeze := ri.score = '101';
	
	self.verfirst := if(isFreeze, '', le.verfirst);
	self.verlast := if(isFreeze, '', le.verlast);
	self.vercmpy := if(isFreeze, '', le.vercmpy);
	self.veraddr := if(isFreeze, '', le.veraddr);
	self.vercity := if(isFreeze, '', le.vercity);
	self.verstate := if(isFreeze, '', le.verstate);
	SElF.verzip := if(isFreeze, '', le.verzip);
	self.versocs := if(isFreeze, '', le.versocs);
	self.verhphone := if(isFreeze, '', le.verhphone);
	
	self := le;
END;
withBTmodel := join(mapped_results, getScore2, (left.seq*2) = right.seq, addBTmodel(left, right), left outer);



getScore3 := Models.TBD605_0_0(clam2, true, mapped_results[1].inCalif2);

working_layout addSTmodel(withBTmodel le, getScore3 ri) := TRANSFORM
	self.score4 := if(le.score4 <> '000' or ri.score in ['101','102','103','104','105'], ri.score, le.score4);
	self.reason14 := if(Risk_Indicators.rcSet.isCode36(ri.ri[1].hri), '36', ri.ri[1].hri);
	self.reason24 := ri.ri[2].hri;
	self.reason34 := ri.ri[3].hri;
	self.reason44 := ri.ri[4].hri;
	
	isFreeze := ri.score = '101';
	
	self.verfirst2 := if(isFreeze, '', le.verfirst2);
	self.verlast2 := if(isFreeze, '', le.verlast2);
	self.vercmpy2 := if(isFreeze, '', le.vercmpy2);
	self.veraddr2 := if(isFreeze, '', le.veraddr2);
	self.vercity2 := if(isFreeze, '', le.vercity2);
	self.verstate2 := if(isFreeze, '', le.verstate2);
	SElF.verzip2 := if(isFreeze, '', le.verzip2);
	self.versocs2 := if(isFreeze, '', le.versocs2);
	self.verhphone2 := if(isFreeze, '', le.verhphone2);
	
	self := le;
END;
withST := join(withBTmodel, getScore3, (left.seq*2)+1 = right.seq, addSTmodel(left, right), left outer);
	

	
RiskWise.Layout_SD1O format_output(withST le) := TRANSFORM
	self.account:= le.account;	
	self.acctno := le.acctno;
	self.riskwiseid := le.riskwiseid;
	self.firstcount := if(le.doOutput, le.firstcount, '');
	self.lastcount := if(le.doOutput, le.lastcount, '');
	self.cmpycount := if(le.doOutput, le.cmpycount, '');
	self.addrcount := if(le.doOutput, le.addrcount, '');
	self.socscount := if(le.doOutput, le.socscount, '');
	self.hphonecount := if(le.doOutput, le.hphonecount, '');
	self.wphonecount := if(le.doOutput, le.wphonecount, '');
	self.dobcount := if(le.doOutput, le.dobcount, '');
	self.drlccount := if(le.doOutput, le.drlccount, '');
	self.emailcount := if(le.doOutput, le.emailcount, '');
	self.socsverlvl := if(le.doOutput, le.socsverlvl, '');
	self.numelever := if(le.doOutput, le.numelever, '');
	self.numsource := if(le.doOutput, le.numsource, '');
	self.verfirst := if(le.doOutput, le.verfirst, '');
	self.verlast := if(le.doOutput, le.verlast, '');
	self.vercmpy := if(le.doOutput, le.vercmpy, '');
	self.veraddr := if(le.doOutput, le.veraddr, '');
	self.vercity := if(le.doOutput, le.vercity, '');
	self.verstate := if(le.doOutput, le.verstate, '');
	self.verzip := if(le.doOutput, le.verzip, '');
	self.versocs := if(le.doOutput, le.versocs, '');
	self.verdob := if(le.doOutput, le.verdob, '');
	self.verhphone := if(le.doOutput, le.verhphone, '');
	self.verwphone := if(le.doOutput, le.verwphone, '');
	self.verdrlc := if(le.doOutput, le.verdrlc, '');
	self.veremail := if(le.doOutput, le.veremail, '');
	self.firstcount2 := if(le.doOutput2, le.firstcount2, '');
	self.lastcount2 := if(le.doOutput2, le.lastcount2, '');
	self.cmpycount2 := if(le.doOutput2, le.cmpycount2, '');
	self.addrcount2 := if(le.doOutput2, le.addrcount2, '');
	self.socscount2 := if(le.doOutput2, le.socscount2, '');
	self.hphonecount2 := if(le.doOutput2, le.hphonecount2, '');
	self.wphonecount2 := if(le.doOutput2, le.wphonecount2, '');
	self.dobcount2 := if(le.doOutput2, le.dobcount2, '');
	self.drlccount2 := if(le.doOutput2, le.drlccount2, '');
	self.emailcount2 := if(le.doOutput2, le.emailcount2, '');
	self.socsverlvl2 := if(le.doOutput2, le.socsverlvl2, '');
	self.numelever2 := if(le.doOutput2, le.numelever2, '');
	self.numsource2 := if(le.doOutput2, le.numsource2, '');
	self.verfirst2 := if(le.doOutput2, le.verfirst2, '');
	self.verlast2 := if(le.doOutput2, le.verlast2, '');
	self.vercmpy2 := if(le.doOutput2, le.vercmpy2, '');
	self.veraddr2 := if(le.doOutput2, le.veraddr2, '');
	self.vercity2 := if(le.doOutput2, le.vercity2, '');
	self.verstate2 := if(le.doOutput2, le.verstate2, '');
	self.verzip2 := if(le.doOutput2, le.verzip2, '');
	self.versocs2 := if(le.doOutput2, le.versocs2, '');
	self.verdob2 := if(le.doOutput2, le.verdob2, '');
	self.verhphone2 := if(le.doOutput2, le.verhphone2, '');
	self.verwphone2 := if(le.doOutput2, le.verwphone2, '');
	self.verdrlc2 := if(le.doOutput2, le.verdrlc2, '');
	self.veremail2 := if(le.doOutput2, le.veremail2, '');
	self.versummary := if(le.doOutput, le.versummary, '');
	self.score := if(le.doOutput, le.score, '');
	self.reason11 := if(le.doOutput, le.reason11, '');
	self.reason21 := if(le.doOutput, le.reason21, '');
	self.reason31 := if(le.doOutput, le.reason31, '');
	self.reason41 := if(le.doOutput, le.reason41, '');
	self.score2 := if(le.doOutput, le.score2, '');
	self.reason12 := if(le.doOutput, le.reason12, '');
	self.reason22 := if(le.doOutput, le.reason22, '');
	self.reason32 := if(le.doOutput, le.reason32, '');
	self.reason42 := if(le.doOutput, le.reason42, '');
	self.score3 := if(le.doOutput2, le.score3, '');
	self.reason13 := if(le.doOutput2, le.reason13, '');
	self.reason23 := if(le.doOutput2, le.reason23, '');
	self.reason33 := if(le.doOutput2, le.reason33, '');
	self.reason43 := if(le.doOutput2, le.reason43, '');
	self.score4 := if(le.doOutput2, le.score4, '');
	self.reason14 := if(le.doOutput2, le.reason14, '');
	self.reason24 := if(le.doOutput2, le.reason24, '');
	self.reason34 := if(le.doOutput2, le.reason34, '');
	self.reason44 := if(le.doOutput2, le.reason44, '');
	self.reserved := if(le.doOutput, le.reserved, '');
	self.billing := if(le.doOutput, le.billing, dataset([],Risk_Indicators.Layout_Billing));
END;
final := project(withST, format_output(left));

RETURN final;

END;