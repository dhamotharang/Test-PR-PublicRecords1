import ut, Risk_Indicators, Models, gateway, riskwise, STD;

export DLLO_Function(DATASET(Layout_DLLI) indata, dataset(Gateway.Layouts.Config) gateways, unsigned1 glb, unsigned1 dppa, 
string50 DataRestriction=risk_indicators.iid_constants.default_DataRestriction,
string50 DataPermission=risk_indicators.iid_constants.default_DataPermission,
unsigned1 LexIdSourceOptout = 1,
string TransactionID = '',
string BatchUID = '',
unsigned6 GlobalCompanyId = 0) := function


risk_indicators.Layout_CIID_BtSt_In into_btst_in(indata le) := transform
	// Clean BillTo
	clean_a := Risk_Indicators.MOD_AddressClean.clean_addr(le.addr, le.city, le.state, le.zip);
	
	ssn_val := cleanSSN( le.socs );
	hphone_val := cleanPhone( le.hphone );
	wphone_val := cleanPhone( le.wphone );
	dob_val := cleanDOB(le.dob);
	dl_num_clean := cleanDL_num( le.drlc );
	
	self.Bill_To_In.seq := le.seq;
	self.Bill_To_In.historydate := le.historydate;
	self.Bill_To_In.fname := STD.Str.touppercase(le.first);
	self.Bill_To_In.lname := STD.Str.touppercase(le.last);
	self.Bill_To_In.in_streetAddress := STD.Str.touppercase(le.addr);
	self.Bill_To_In.in_city := STD.Str.touppercase(le.city);
	self.Bill_To_In.in_state := STD.Str.touppercase(le.state);
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
	self.Bill_To_In.z5 := IF(clean_a[117..121]<>'', clean_a[117..121], le.zip[1..5]);	// use the input zip if cass zip is empty
	self.Bill_To_In.zip4 := IF(clean_a[122..125]<>'', clean_a[122..125], le.zip[6..9]);	// use the input zip if cass zip is empty
	self.Bill_To_In.lat := clean_a[146..155];
	self.Bill_To_In.long := clean_a[156..166];
	self.Bill_To_In.addr_type := clean_a[139];
	self.Bill_To_In.addr_status := clean_a[179..182];
	self.Bill_To_In.county := clean_a[143..145];
	self.Bill_To_In.geo_blk := clean_a[171..177];
	self.Bill_To_In.ssn	:= ssn_val;
	self.Bill_To_In.dob	:= dob_val;
	self.Bill_To_In.age := if ((integer)dob_val != 0, (STRING3)ut.Age((integer)dob_val), '');
	self.Bill_To_In.dl_number := STD.Str.touppercase(dl_num_clean);
	self.Bill_To_In.dl_state := STD.Str.touppercase(le.drlcstate);
	self.Bill_To_In.email_address	:= le.email;
	self.Bill_To_In.phone10 := hphone_val;
	self.Bill_To_In.wphone10 := wphone_val;
	self.Bill_To_In.employer_name := STD.Str.touppercase(le.cmpy);
	
	clean_a2 := Risk_Indicators.MOD_AddressClean.clean_addr(le.addr2, le.city2, le.state2, le.zip2);

	ssn_val2 := cleanFEIN( le.fin );
	hphone_val2 := cleanPhone( le.hphone2 );

	wphone_val2 := ''; 	
	dob_val2 := '';
	dl_num2 := '';
	dl_num_clean2 := '';
	
	self.Ship_To_In.seq := le.seq;
	self.Ship_To_In.historydate := le.historydate;
	self.Ship_To_In.fname := STD.Str.touppercase(le.first2);
	self.Ship_To_In.lname := STD.Str.touppercase(le.last2);
	self.Ship_To_In.in_streetAddress := STD.Str.touppercase(le.addr2);
	self.Ship_To_In.in_city := STD.Str.touppercase(le.city2);
	self.Ship_To_In.in_state := STD.Str.touppercase(le.state2);
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
	self.Ship_To_In.age := if((integer)dob_val2 != 0, (STRING)ut.Age((integer)dob_val2), '');
	self.Ship_To_In.dl_number := STD.Str.touppercase(dl_num_clean2);
	self.Ship_To_In.dl_state := '';
	self.Ship_To_In.email_address	:= '';
	self.Ship_To_In.phone10 := hphone_val2;
	self.Ship_To_In.wphone10 := wphone_val2;
	self.Ship_To_In.employer_name := STD.Str.touppercase(le.cmpy2);	
	
	self := [];
end;
prep := project(indata,into_btst_in(LEFT));

iid_results := risk_indicators.InstantId_BtSt_Function(prep, gateways, dppa, glb, false, false, true, true, true, DataRestriction:=DataRestriction, DataPermission:=DataPermission,
                                                                                            LexIdSourceOptout := LexIdSourceOptout, 
                                                                                            TransactionID := TransactionID, 
                                                                                            BatchUID := BatchUID, 
                                                                                            GlobalCompanyID := GlobalCompanyID);



// intermediate results
working_layout := record
	Layout_DLLO;
	unsigned4 seq;
	Layout_for_Royalties;
end;



STRING2 getSocsLevel(UNSIGNED1 level) := MAP(level in [0,2,3,5,8] => '0',
									level = 1 => '1',
									level = 4 => '2',
									level = 6 => '3',
									level = 7 => '4',
									intformat((level-4),1,1));	// 9,10,11,12 results in 5,6,7,8

tscore(UNSIGNED1 i) := IF(i=255,'0',(string)i);


working_layout fill_output(iid_results le, indata ri) := transform
	SELF.seq := ri.seq;
	SELF.account := ri.account;
	SELF.riskwiseid := (STRING)le.bill_to_output.did;
	
	SELF.hriskphoneflag := le.bill_to_output.hriskphoneflag;
	SELF.phonevalflag := IF(le.bill_to_output.hriskphoneflag='5', '3', le.bill_to_output.phonevalflag);
	SELF.phonezipmismatchflag := le.bill_to_output.phonezipflag;
	SELF.hriskaddrflag := le.bill_to_output.hriskaddrflag;
	SELF.decsflag := le.bill_to_output.decsflag;
	SELF.socsdobmismatchflag := le.bill_to_output.socsdobflag;
	SELF.socsvalflag := le.bill_to_output.socsvalflag;
	SELF.drlcvalflag := le.bill_to_output.drlcvalflag;
	SELF.areacodesplitflag := MAP(ri.hphone = '' => '2',
							le.bill_to_output.areacodesplitflag = 'Y' => '1',
							'');
	SELF.altareacode := IF(le.bill_to_output.areacodesplitflag = 'Y', le.bill_to_output.altareacode, '');
	SELF.areacodesplitdate := IF(le.bill_to_output.areacodesplitflag='Y', le.bill_to_output.areacodesplitdate, '');
	
	SELF.addrvalflag := le.bill_to_output.addrvalflag;
	SELF.dwelltypeflag := le.bill_to_output.dwelltype;
	
	SELF.cassaddr := Risk_Indicators.MOD_AddressClean.street_address('',le.bill_to_output.prim_range,le.bill_to_output.predir,le.bill_to_output.prim_name,le.bill_to_output.addr_suffix,
										le.bill_to_output.postdir,le.bill_to_output.unit_desig,le.bill_to_output.sec_range);
	SELF.casscity := le.bill_to_output.p_city_name;
	SELF.cassstate := le.bill_to_output.st;
	SELF.casszip := le.bill_to_output.z5 + le.bill_to_output.zip4;
	
	SELF.bansflag := le.bill_to_output.bansflag;
	
	SELF.coaalertflag := IF(le.bill_to_output.coaalertflag, (STRING)(integer)le.bill_to_output.coaalertflag, '');
	SELF.coafirst := le.bill_to_output.coafirst;
	SELF.coalast := le.bill_to_output.coalast;
	SELF.coaaddr := Risk_Indicators.MOD_AddressClean.street_address('',le.bill_to_output.coaprim_range, le.bill_to_output.coapredir, le.bill_to_output.coaprim_name, le.bill_to_output.coasuffix, 
									    le.bill_to_output.coapostdir, le.bill_to_output.coaunit_desig, le.bill_to_output.coasec_range);
	SELF.coacity := le.bill_to_output.coacity;
	SELF.coastate := le.bill_to_output.coastate;
	SELF.coazip := le.bill_to_output.coazip;
	
	SELF.idtheftalertflag := le.bill_to_output.idtheftflag;
		
	SELF.firstcount := IF(ri.first <> '', RiskWise.flattenCount(le.bill_to_output.combo_firstcount,2,1), '');
	SELF.lastcount := IF(ri.last <> '', RiskWise.flattenCount(le.bill_to_output.combo_lastcount,2,1), '');
	SELF.cmpycount := IF(ri.cmpy <> '', RiskWise.flattenCount(le.bill_to_output.combo_cmpycount,2,1), '');
	SELF.addrcount := IF(ri.addr <> '', RiskWise.flattenCount(le.bill_to_output.combo_addrcount,2,1), '');
	SELF.socscount := IF(ri.socs <> '', RiskWise.flattenCount(le.bill_to_output.combo_ssncount,2,1), '');
	SELF.phonecount := IF(ri.hphone <> '', RiskWise.flattenCount(le.bill_to_output.combo_hphonecount,2,1), '');
	SELF.wphonecount := IF(ri.wphone <> '' and le.bill_to_output.combo_wphonescore<>255, RiskWise.flattenCount(le.bill_to_output.combo_wphonecount,2,1), '');
	SELF.dobcount := IF(ri.dob <> '', RiskWise.flattenCount(le.bill_to_output.combo_dobcount,2,1), '');
	
	SELF.socsverlevel := getSocsLevel(le.bill_to_output.socsverlevel);
	
	SELF.numelever :=intformat(le.bill_to_output.numelever,1,1); 
	SELF.numsource := RiskWise.flattenCount((INTEGER)self.firstcount+(INTEGER)self.lastcount+(INTEGER)self.cmpycount+(INTEGER)self.addrcount+(INTEGER)self.phonecount+
									(INTEGER)self.wphonecount+(INTEGER)self.socscount+(INTEGER)self.dobcount,9,1);
	
	SELF.verfirst := le.bill_to_output.combo_first;
	SELF.verlast := le.bill_to_output.combo_last;
	SELF.vercmpy := le.bill_to_output.combo_cmpy;
	SELF.veraddr := Risk_Indicators.MOD_AddressClean.street_address('',le.bill_to_output.combo_prim_range,le.bill_to_output.combo_predir,le.bill_to_output.combo_prim_name,le.bill_to_output.combo_suffix,
									    le.bill_to_output.combo_postdir,le.bill_to_output.combo_unit_desig,le.bill_to_output.combo_sec_range);
	SELF.vercity := le.bill_to_output.combo_city;
	SELF.verstate := le.bill_to_output.combo_state;
	SElF.verzip := le.bill_to_output.combo_zip;
	SELF.versocs := IF(le.bill_to_output.combo_ssncount>0, le.bill_to_output.combo_ssn, '');
	SELF.verdob := le.bill_to_output.combo_dob;
	SELF.verphone := le.bill_to_output.combo_hphone;
	SELF.verwphone := le.bill_to_output.combo_wphone;
	
	SELF.firstmatchscore := IF(ri.first <> '', tscore(le.bill_to_output.combo_firstscore), '');
	SELF.lastmatchscore := IF(ri.last <> '', tscore(le.bill_to_output.combo_lastscore), '');
	SELF.cmpymatchscore := IF(ri.cmpy <> '', tscore(le.bill_to_output.combo_cmpyscore), '');
	SELF.addrmatchscore := IF(ri.addr <> '', tscore(le.bill_to_output.combo_addrscore), '');
	SELF.phonematchscore := IF(ri.hphone <> '', tscore(le.bill_to_output.combo_hphonescore), '');
	SELF.wphonematchscore := IF(ri.wphone <> '', tscore(le.bill_to_output.combo_wphonescore), '');
	SELF.socsmatchscore := IF(ri.socs <> '', tscore(le.bill_to_output.combo_ssnscore), '');
	SELF.dobmatchscore := IF(ri.dob <> '', tscore(le.bill_to_output.combo_dobscore), '');
		
	SELF.socsmiskeyflag := (STRING)(integer)le.bill_to_output.socsmiskeyflag;
	SELF.phonemiskeyflag := (STRING)(integer)le.bill_to_output.hphonemiskeyflag;
	SELF.addrmiskeyflag := (STRING)(integer)le.bill_to_output.addrmiskeyflag;
	
	SELF.hriskcmpy := MAP(le.bill_to_output.hriskaddrflag = '4' => le.bill_to_output.hriskcmpy,
					  le.bill_to_output.hriskphoneflag = '6' => le.bill_to_output.hriskcmpyphone,
					  '');
	SELF.hrisksic := MAP(le.bill_to_output.hriskaddrflag = '4' => RiskWise.convertSIC(le.bill_to_output.hrisksic),
					 le.bill_to_output.hriskphoneflag = '6' => RiskWise.convertSIC(le.bill_to_output.hrisksicphone),
					 '');
	SELF.hriskphone := MAP(le.bill_to_output.hriskaddrflag = '4' => le.bill_to_output.hriskphone,
					   le.bill_to_output.hriskphoneflag = '6' => le.bill_to_output.hriskphonephone,
					   '');
	SELF.hriskaddr := MAP(le.bill_to_output.hriskaddrflag = '4' => le.bill_to_output.hriskaddr,
					  le.bill_to_output.hriskphoneflag = '6' => le.bill_to_output.hriskaddrphone,
					  '');
	SELF.hriskcity := MAP(le.bill_to_output.hriskaddrflag = '4' => le.bill_to_output.hriskcity,
					  le.bill_to_output.hriskphoneflag = '6' => le.bill_to_output.hriskcityphone,
					  '');
	SELF.hriskstate := MAP(le.bill_to_output.hriskaddrflag = '4' => le.bill_to_output.hriskstate,
					   le.bill_to_output.hriskphoneflag = '6' => le.bill_to_output.hriskstatephone,
					   '');
	SELF.hriskzip := MAP(le.bill_to_output.hriskaddrflag = '4' => le.bill_to_output.hriskzip,
					 le.bill_to_output.hriskphoneflag = '6' => le.bill_to_output.hriskzipphone,
					 '');
					  
	SELF.distphoneaddr := IF(le.bill_to_output.disthphoneaddr IN [0,9999], '', (STRING)le.bill_to_output.disthphoneaddr);
	SELF.distphonewphone := IF(le.bill_to_output.disthphonewphone IN [0,9999], '', (STRING)le.bill_to_output.disthphonewphone);
	SELF.distwphoneaddr := IF(le.bill_to_output.distwphoneaddr IN [0,9999], '', (STRING)le.bill_to_output.distwphoneaddr);
	
	
	SELF.areacodesplitflag2 := MAP(ri.hphone2 = '' => '2',
							 le.ship_to_output.areacodesplitflag = 'Y' => '1',
							 '');
	SELF.altareacode2 := IF(le.ship_to_output.areacodesplitflag = 'Y', le.ship_to_output.altareacode, '');
	SELF.areacodesplitdate2 := IF(le.ship_to_output.areacodesplitflag='Y', le.ship_to_output.areacodesplitdate, '');
	
	SELF.hriskphoneflag2 := le.ship_to_output.hriskphoneflag;
	SELF.phonevalflag2 := IF(le.ship_to_output.hriskphoneflag='5', '3', le.ship_to_output.phonevalflag);
	SELF.phonezipmismatchflag2 := le.ship_to_output.phonezipflag;
	SELF.hriskaddrflag2 := le.ship_to_output.hriskaddrflag;
	SELF.addrvalflag2 := le.ship_to_output.addrvalflag;
	SELF.dwelltypeflag2 := le.ship_to_output.dwelltype;
	SELF.bansfinflag := le.ship_to_output.bansflag;
	
	SELF.firstcount2 := IF(ri.first2 <> '', RiskWise.flattenCount(le.ship_to_output.combo_firstcount,2,1), '');
	SELF.lastcount2 := IF(ri.last2 <> '', RiskWise.flattenCount(le.ship_to_output.combo_lastcount,2,1), '');
	SELF.cmpycount2 := IF(ri.cmpy2 <> '', RiskWise.flattenCount(le.ship_to_output.combo_cmpycount,2,1), '');
	SELF.addrcount2 := IF(ri.addr2 <> '', RiskWise.flattenCount(le.ship_to_output.combo_addrcount,2,1), '');
	SELF.phonecount2 := IF(ri.hphone2 <> '', RiskWise.flattenCount(le.ship_to_output.combo_hphonecount,2,1), '');
	SELF.fincount := IF(ri.fin <> '', RiskWise.flattenCount(le.ship_to_output.combo_ssncount,2,1), '');	
	SELF.numelever2 := intformat(le.ship_to_output.numelever,1,1);
	SELF.numsource2 := RiskWise.flattenCount((INTEGER)self.firstcount2+(INTEGER)self.lastcount2+(INTEGER)self.cmpycount2+(INTEGER)self.addrcount2+(INTEGER)self.phonecount2+
									 (INTEGER)self.fincount,9,1);
	
	SELF.verfirst2 := le.ship_to_output.combo_first;
	SELF.verlast2 := le.ship_to_output.combo_last;
	SELF.vercmpy2 := le.ship_to_output.combo_cmpy;
	SELF.veraddr2 := Risk_Indicators.MOD_AddressClean.street_address('',le.ship_to_output.combo_prim_range,le.ship_to_output.combo_predir,le.ship_to_output.combo_prim_name,le.ship_to_output.combo_suffix,
										le.ship_to_output.combo_postdir,le.ship_to_output.combo_unit_desig,le.ship_to_output.combo_sec_range);
	SELF.vercity2 := le.ship_to_output.combo_city;
	SELF.verstate2 := le.ship_to_output.combo_state;
	SElF.verzip2 := le.ship_to_output.combo_zip;
	SELF.verhphone2 := le.ship_to_output.combo_hphone;
	SELF.verfin := IF(le.ship_to_output.combo_ssncount > 0, le.ship_to_output.combo_ssn, '');
	
	SELF.firstmatchscore2 := IF(ri.first2 <> '', tscore(le.ship_to_output.combo_firstscore), '');
	SELF.lastmatchscore2 := IF(ri.last2 <> '', tscore(le.ship_to_output.combo_lastscore), '');
	SELF.cmpymatchscore2 := IF(ri.cmpy2 <> '', tscore(le.ship_to_output.combo_cmpyscore), '');
	SELF.addrmatchscore2 := IF(ri.addr2 <> '', tscore(le.ship_to_output.combo_addrscore), '');
	SELF.phonematchscore2 := IF(ri.hphone2 <> '', tscore(le.ship_to_output.combo_hphonescore), '');
	SELF.finmatchscore := IF(ri.fin <> '', tscore(le.ship_to_output.combo_ssnscore), '');
		
	SELF.hriskcmpy2 := MAP(le.ship_to_output.hriskaddrflag='4' => le.ship_to_output.hriskcmpy,
					   le.ship_to_output.hriskphoneflag='6' => le.ship_to_output.hriskcmpyphone,
					   '');
	SELF.hrisksic2 := MAP(le.ship_to_output.hriskaddrflag='4' => RiskWise.convertSIC(le.ship_to_output.hrisksic),
					  le.ship_to_output.hriskphoneflag='6' => RiskWise.convertSIC(le.ship_to_output.hrisksicphone),
					  '');
	SELF.hriskphone2 := MAP(le.ship_to_output.hriskaddrflag='4' => le.ship_to_output.hriskphone,
					    le.ship_to_output.hriskphoneflag='6' => le.ship_to_output.hriskphonephone,
					    '');
	SELF.hriskaddr2 := MAP(le.ship_to_output.hriskaddrflag='4' => le.ship_to_output.hriskaddr,
					   le.ship_to_output.hriskphoneflag='6' => le.ship_to_output.hriskaddrphone,
					   '');
	SELF.hriskcity2 := MAP(le.ship_to_output.hriskaddrflag='4' => le.ship_to_output.hriskcity,
					   le.ship_to_output.hriskphoneflag='6' => le.ship_to_output.hriskcityphone,
					   '');
	SELF.hriskstate2 := MAP(le.ship_to_output.hriskaddrflag='4' => le.ship_to_output.hriskstate,
					    le.ship_to_output.hriskphoneflag='6' => le.ship_to_output.hriskstatephone,
					    '');
	SELF.hriskzip2 := MAP(le.ship_to_output.hriskaddrflag='4' => le.ship_to_output.hriskzip,
					  le.ship_to_output.hriskphoneflag='6' => le.ship_to_output.hriskzipphone,
					  '');
	
	SELF.distphoneaddr2 := IF(le.ship_to_output.disthphoneaddr <> 9999, (STRING)le.ship_to_output.disthphoneaddr, '0');
	self.targusType := if(le.Bill_To_Output.TargusType <> '', le.Bill_To_Output.TargusType, le.Ship_To_Output.TargusType);
	self.src := if(le.Bill_To_Output.src <> '', le.Bill_To_Output.src, le.Ship_To_Output.src);
	self.TargusGatewayUsed := if(le.Bill_To_Output.TargusGatewayUsed, le.Bill_To_Output.TargusGatewayUsed, le.Ship_To_Output.TargusGatewayUsed);
	
	SELF := [];
end;
mapped_results := JOIN(iid_results, indata, left.bill_to_output.seq = (right.seq * 2), fill_output(left,right), left outer);

// turned off vehicle and dl searching, not used in these models
getBS := Risk_Indicators.BocaShell_BtSt_Function(iid_results, gateways, dppa, glb, false, false, true, false, false, true, DataRestriction:=DataRestriction, DataPermission:=DataPermission,
                                                                                          LexIdSourceOptout := LexIdSourceOptout, 
                                                                                          TransactionID := TransactionID, 
                                                                                          BatchUID := BatchUID, 
                                                                                          GlobalCompanyID := GlobalCompanyID);	

clam := PROJECT(getBS, TRANSFORM(Risk_Indicators.Layout_Boca_Shell, SELF := LEFT.Bill_To_Out));
getFRDR := ungroup(Models.TBN509_0_0(clam, true));

working_layout addFRDR(mapped_results le, getFRDR ri) := transform
	self.frdriskscore := ri.score;
	self := le;
end;
withFRDR := JOIN(mapped_results, getFRDR, (left.seq*2) = right.seq, addFRDR(left, right), left outer);



getScore2 := Models.CDN604_3_0(getBS, true);

working_layout addModel(withFRDR le, getScore2 ri) := transform
	self.estincome := ri.score;
	SELF := le;
end;
withModel := JOIN(withFRDR, getScore2, (left.seq*2) = right.seq, addModel(left, right), left outer);


getWW := Models.WWN604_1_0(clam, true);

Layout_DLLO_4_royalties := RECORD
	Layout_DLLO;
	Layout_for_Royalties;
END;

Layout_DLLO_4_royalties addWW(withModel le, getWW ri) := transform
	self.versum := ri.score;
	self := le;
end;
final := JOIN(withModel, getWW, (left.seq*2) = right.seq, addWW(left,right), left outer);

return final;

end;