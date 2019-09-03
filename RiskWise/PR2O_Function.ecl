import ut, Risk_Indicators, Models, gateway, STD, Riskwise;

export PR2O_Function(dataset(Layout_SD1I) indata, dataset(Gateway.Layouts.Config) gateways, unsigned1 glb, unsigned1 dppa, 
string4 tribCode, string50 DataRestriction=risk_indicators.iid_constants.default_DataRestriction,
string50 DataPermission=risk_indicators.iid_constants.default_DataPermission,
unsigned1 LexIdSourceOptout = 1,
string TransactionID = '',
string BatchUID = '',
unsigned6 GlobalCompanyId = 0) := FUNCTION

Risk_Indicators.Layout_CIID_BtSt_In into_btst_in(indata le) := TRANSFORM
	// Clean BillTo
	clean_a := risk_indicators.MOD_AddressClean.clean_addr(le.addr, le.city, le.state, le.zip) ;

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
	self.Bill_To_In.age := if ((integer)dob_val != 0, (string3)ut.Age((integer)dob_val), '');
	self.Bill_To_In.dl_number := STD.Str.touppercase(dl_num_clean);
	self.Bill_To_In.dl_state := STD.Str.touppercase(le.drlcstate);
	self.Bill_To_In.email_address	:= le.email;
	self.Bill_To_In.phone10 := hphone_val;
	self.Bill_To_In.wphone10 := wphone_val;
	self.Bill_To_In.employer_name := STD.Str.touppercase(le.cmpy);	
	
	// Clean ShipTo
	clean_a2 := risk_indicators.MOD_AddressClean.clean_addr(le.addr2, le.city2, le.state2, le.zip2) ;	
	
	ssn_val2 := cleanSSN( le.socs2 );
	hphone_val2 := cleanPhone( le.hphone2 );
	wphone_val2 := cleanPhone( le.wphone2 );
	dob_val2 := cleanDOB( le.dob2 );
	dl_num_clean2 := cleanDL_num( le.drlc2 );
	
	
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
	self.Ship_To_In.age := if((integer)dob_val2 != 0, (string)ut.Age((integer)dob_val2), '');
	self.Ship_To_In.dl_number := STD.Str.touppercase(dl_num_clean2);
	self.Ship_To_In.dl_state := STD.Str.touppercase(le.drlcstate2);
	self.Ship_To_In.email_address	:= le.email2;
	self.Ship_To_In.phone10 := hphone_val2;
	self.Ship_To_In.wphone10 := wphone_val2;
	self.Ship_To_In.employer_name := STD.Str.touppercase(le.cmpy2);	
	self := [];
end;
prep := project(indata,into_btst_in(LEFT));

iid_results := risk_indicators.InstantId_BtSt_Function(prep, gateways, dppa, glb, false, false, true, true, true,dataRestriction:=DataRestriction,dataPermission:=DataPermission,
                                                                                           LexIdSourceOptout := LexIdSourceOptout, 
                                                                                           TransactionID := TransactionID, 
                                                                                           BatchUID := BatchUID, 
                                                                                           GlobalCompanyID := GlobalCompanyID);



// intermediate results
working_layout := RECORD
	RiskWise.Layout_PR2O;
	unsigned4 seq;
	Layout_for_Royalties;
END;


unsigned2 getSocsLevel(unsigned1 level) := map(level in [0,2,3,5,8] => 0,
									  level = 1 => 1,
									  level = 4 => 2,
									  level = 6 => 3,
									  level = 7 => 4,
									  level-4);	// 9,10,11,12 results in 5,6,7,8


working_layout fill_output(iid_results le, indata ri) := TRANSFORM
	self.seq := ri.seq;
	self.account := ri.account;
	self.acctno := ri.acctno;
	self.riskwiseid := (string)le.bill_to_output.did;
	
	self.hriskphoneflag := if(tribCode in ['cap1','bnk1'], le.bill_to_output.hriskphoneflag, '');
	self.phonevalflag := if(tribCode in ['cap1','bnk1'],if(le.bill_to_output.hriskphoneflag='5', '3', le.bill_to_output.phonevalflag), '');
	self.phonezipflag := if(tribCode in ['cap1','bnk1'], le.bill_to_output.phonezipflag, '');
	self.hriskaddrflag := if(tribCode in ['cap1','bnk1'], le.bill_to_output.hriskaddrflag, '');
	self.decsflag := if(tribCode in ['cap1','bnk1'], le.bill_to_output.decsflag, '');
	self.socsdobflag := if(tribCode in ['cap1','bnk1'], le.bill_to_output.socsdobflag, '');
	self.socsvalflag := if(tribCode in ['cap1','bnk1'], le.bill_to_output.socsvalflag, '');
	self.drlcvalflag := if(tribCode in ['cap1','bnk1'],if(le.bill_to_output.drlcvalflag = '3', '1', le.bill_to_output.drlcvalflag), '');
	
	self.areacodesplitflag := if(tribCode in ['cap1','bnk1'],map(le.bill_to_output.phone10='' => '2',
													 le.bill_to_output.areacodesplitflag = 'Y' => '1',
													 ''),'');
	self.altareacode := if(tribCode in ['cap1','bnk1'] and le.bill_to_output.areacodesplitflag = 'Y', le.bill_to_output.altareacode, '');
	self.splitdate := if(tribCode in ['cap1','bnk1'] and le.bill_to_output.areacodesplitflag = 'Y', le.bill_to_output.areacodesplitdate, '');
		
	self.addrvalflag := if(tribCode in ['cap1','bnk1'], le.bill_to_output.addrvalflag, '');
	self.dwelltypeflag := if(tribCode in ['cap1','bnk1'], le.bill_to_output.dwelltype, '');
	
	self.cassaddr := if(tribCode in ['cap1','bnk1'], Risk_Indicators.MOD_AddressClean.street_address('',le.bill_to_output.prim_range,le.bill_to_output.predir,le.bill_to_output.prim_name,le.bill_to_output.addr_suffix,
																  le.bill_to_output.postdir,le.bill_to_output.unit_desig,le.bill_to_output.sec_range), '');
	self.casscity := if(tribCode in ['cap1','bnk1'], le.bill_to_output.p_city_name, '');
	self.cassstate := if(tribCode in ['cap1','bnk1'], le.bill_to_output.st, '');
	self.casszip := if(tribCode in ['cap1','bnk1'], le.bill_to_output.z5+le.bill_to_output.zip4, '');
	
	self.bansflag := if(tribCode in ['cap1','bnk1'], le.bill_to_output.bansflag, '');
	
	self.idtheftflag := if(tribCode in ['cap1','bnk1'], le.bill_to_output.idtheftflag, '');
	self.aptscanflag := if(tribCode in ['cap1','bnk1'], (string)(integer)le.bill_to_output.aptscamflag, '');
	self.addrhistoryflag := if(tribCode in ['cap1','bnk1'], '0', '');
	
	numByte := if(tribCode = 'fds4', 2, 1);	// fds4 formats the count to 2 bytes, the others are 1 byte
	self.firstcount := if(ri.first <> '' and tribCode in ['cap1','bnk1','fds4'], RiskWise.flattenCount(le.bill_to_output.combo_firstcount,2,numByte), '');
	self.lastcount := if(ri.last <> '' and tribCode in ['cap1','bnk1','fds4'], RiskWise.flattenCount(le.bill_to_output.combo_lastcount,2,numByte), '');
	self.formerlastcount := if(ri.cmpy <> '' and tribCode in ['fds4'], RiskWise.flattenCount(le.bill_to_output.combo_cmpycount,2,numByte), '');
	self.addrcount := if(ri.addr <> '' and tribCode in ['cap1','bnk1','fds4'], 
												if(tribcode = 'bnk1' AND le.bill_to_output.addr_type = 'P','0',RiskWise.flattenCount(le.bill_to_output.combo_addrcount,2,numByte)), '');
												
	self.hphonecount := if(ri.hphone <> '' and tribCode in ['cap1','bnk1','fds4'], RiskWise.flattenCount(le.bill_to_output.combo_hphonecount,2,numByte), '');
	self.wphonecount := if(ri.wphone <> '' and tribCode in ['cap1','bnk1','fds4'] and le.bill_to_output.combo_wphonescore<>255, RiskWise.flattenCount(le.bill_to_output.combo_wphonecount,2,numByte), '');
	self.socscount := if(ri.socs <> '' and tribCode in ['cap1','bnk1','fds4'], RiskWise.flattenCount(le.bill_to_output.combo_ssncount,2,numByte),'');
	self.socsverlevel := if(tribCode in ['cap1','bnk1','fds4'], (string)getSocsLevel(le.bill_to_output.socsverlevel),'');
	self.dobcount := if(ri.dob <> '' and tribCode in ['cap1','bnk1','fds4'], RiskWise.flattenCount(le.bill_to_output.combo_dobcount,2,numByte), '');
	
	self.numelever := if(tribCode in ['cap1','bnk1','fds4'], 
												if(tribcode = 'bnk1' AND le.bill_to_output.addr_type = 'P',intformat(le.bill_to_output.numelever-1,1,1),
														intformat(le.bill_to_output.numelever,1,1)), '');
														
	self.numsource := if(tribCode in ['cap1','bnk1','fds4'], if(((integer)self.firstcount+(integer)self.lastcount+(integer)self.addrcount+(integer)self.hphonecount+
														  (integer)self.wphonecount+(integer)self.socscount+(integer)self.dobcount) > 9,
																intformat((integer)self.firstcount+(integer)self.lastcount+(integer)self.addrcount+(integer)self.hphonecount+
																		(integer)self.wphonecount+(integer)self.socscount+(integer)self.dobcount,2,1),
																intformat((integer)self.firstcount+(integer)self.lastcount+(integer)self.addrcount+(integer)self.hphonecount+
																		(integer)self.wphonecount+(integer)self.socscount+(integer)self.dobcount,numByte,1)), '');
	
	// fds4 has special logic to populate these with wphone search results if all empty from progressive
	useWphoneFields := if(tribCode = 'fds4' and le.bill_to_output.wphonewphonecount>0 and le.bill_to_output.combo_first='' and le.bill_to_output.combo_last='' and 
					  le.bill_to_output.combo_prim_range='' and le.bill_to_output.combo_prim_name='' and le.bill_to_output.combo_hphone='', true, false);
	self.verfirst := map(useWphoneFields => '',
					 tribCode in ['cap1','bnk1','fds4'] => le.bill_to_output.combo_first,
					 '');
	self.verlast := map(useWphoneFields => '',
				     tribCode in ['cap1','bnk1','fds4'] => le.bill_to_output.combo_last,  
				     '');
	self.vercmpy := map(tribCode = 'fds4' and le.bill_to_output.wphonewphonecount > 0 and le.bill_to_output.combo_cmpy = '' => le.bill_to_output.wphonename,
					tribCode in ['cap1','bnk1','fds4'] => le.bill_to_output.combo_cmpy,
					'');
	self.veraddr := map(tribcode = 'bnk1' AND le.bill_to_output.addr_type = 'P' => '',
						 useWphoneFields => le.bill_to_output.wphoneaddr,
				     tribCode in ['cap1','bnk1','fds4'] => Risk_Indicators.MOD_AddressClean.street_address('',le.bill_to_output.combo_prim_range,le.bill_to_output.combo_predir,le.bill_to_output.combo_prim_name,le.bill_to_output.combo_suffix,le.bill_to_output.combo_postdir,
																		 le.bill_to_output.combo_unit_desig,le.bill_to_output.combo_sec_range),
				     '');
	self.vercity := map(tribcode = 'bnk1' AND le.bill_to_output.addr_type = 'P' => '',
					useWphoneFields => le.bill_to_output.wphonecity,
					tribCode in ['cap1','bnk1','fds4'] => le.bill_to_output.combo_city,
					'');
	self.verstate := map(tribcode = 'bnk1' AND le.bill_to_output.addr_type = 'P' => '',
					 useWphoneFields => le.bill_to_output.wphonestate,
					 tribCode in ['cap1','bnk1','fds4'] => le.bill_to_output.combo_state,
					 '');
	self.verzip := map(tribcode = 'bnk1' AND le.bill_to_output.addr_type = 'P' => '',
						useWphoneFields => le.bill_to_output.wphonezip,
				    tribCode in ['cap1','bnk1','fds4'] => le.bill_to_output.combo_zip,
				    '');
	self.verhphone := map(useWphoneFields => le.bill_to_output.wphone10,
					  tribCode in ['cap1','bnk1','fds4'] => le.bill_to_output.combo_hphone,
					  '');
	self.verwphone := if(tribCode in ['cap1','bnk1','fds4'], le.bill_to_output.combo_wphone, '');
	self.versocs := if(tribCode in ['cap1','bnk1','fds4'] and le.bill_to_output.combo_ssncount > 0, le.bill_to_output.combo_ssn, '');
	self.verdob := if(tribCode in ['cap1','bnk1','fds4'], le.bill_to_output.combo_dob, '');
	
	self.firstscore := if(ri.first <> '' and tribCode in ['cap1','bnk1'], if(le.bill_to_output.combo_firstscore=255, '0', (string)le.bill_to_output.combo_firstscore), '');
	self.lastscore := if(ri.last <> '' and tribCode in ['cap1','bnk1'], if(le.bill_to_output.combo_lastscore=255, '0', (string)le.bill_to_output.combo_lastscore), '');
	self.cmpyscore := if(ri.cmpy <> '' and tribCode in ['cap1','bnk1'], if(le.bill_to_output.combo_cmpyscore=255, '0', (string)le.bill_to_output.combo_cmpyscore), '');
	self.addrscore := if(ri.addr <> '' and tribCode in ['cap1','bnk1'], 
													if(tribcode = 'bnk1' AND le.bill_to_output.addr_type = 'P','0',if(le.bill_to_output.combo_addrscore=255, '0', (string)le.bill_to_output.combo_addrscore)), '');
	
	self.hphonescore := if(ri.hphone <> '' and tribCode in ['cap1','bnk1'], if(le.bill_to_output.combo_hphonescore=255, '0', (string)le.bill_to_output.combo_hphonescore), '');
	self.wphonescore := if(ri.wphone <> '' and tribCode in ['cap1','bnk1'] and le.bill_to_output.combo_wphonescore<>255, (string)le.bill_to_output.combo_wphonescore, '');
	self.socsscore := if((ri.socs <> '' or self.versocs<>'') and tribCode in ['cap1','bnk1'], if(le.bill_to_output.combo_ssnscore=255, '0', (string)le.bill_to_output.combo_ssnscore), '');
	self.dobscore := if(ri.dob <> '' and tribCode in ['cap1','bnk1'], if(le.bill_to_output.combo_dobscore=255, '0', (string)le.bill_to_output.combo_dobscore), '');
	
	self.socsmiskeyflag := if(tribCode in ['cap1','bnk1','fds4'], (string)(integer)le.bill_to_output.socsmiskeyflag, '');
	self.hphonemiskeyflag := if(tribCode in ['cap1','bnk1','fds4'], (string)(integer)le.bill_to_output.hphonemiskeyflag, '');
	self.addrmiskeyflag := if(tribCode in ['cap1','bnk1','fds4'], (string)(integer)le.bill_to_output.addrmiskeyflag, '');
	
	self.hriskcmpy := map(tribCode in ['cap1','bnk1'] and le.bill_to_output.hriskaddrflag='4' => le.bill_to_output.hriskcmpy,
					  tribCode in ['cap1','bnk1'] and le.bill_to_output.hriskphoneflag='6' => le.bill_to_output.hriskcmpyphone,
					  '');
	self.hrisksic := map(tribCode in ['cap1','bnk1'] and le.bill_to_output.hriskaddrflag='4' => RiskWise.convertSIC(le.bill_to_output.hrisksic),
					 tribCode in ['cap1','bnk1'] and le.bill_to_output.hriskphoneflag='6' => RiskWise.convertSIC(le.bill_to_output.hrisksicphone),
					 '');
	self.hriskphone := map(tribCode in ['cap1','bnk1'] and le.bill_to_output.hriskaddrflag='4' => le.bill_to_output.hriskphone,
					   tribCode in ['cap1','bnk1'] and le.bill_to_output.hriskphoneflag='6' => le.bill_to_output.hriskphonephone,
					   '');
	self.hriskaddr := map(tribCode in ['cap1','bnk1'] and le.bill_to_output.hriskaddrflag='4' => le.bill_to_output.hriskaddr,
					  tribCode in ['cap1','bnk1'] and le.bill_to_output.hriskphoneflag='6' => le.bill_to_output.hriskaddrphone,
					  '');
	self.hriskcity := map(tribCode in ['cap1','bnk1'] and le.bill_to_output.hriskaddrflag='4' => le.bill_to_output.hriskcity,
					  tribCode in ['cap1','bnk1'] and le.bill_to_output.hriskphoneflag='6' => le.bill_to_output.hriskcityphone,
					  '');
	self.hriskstate := map(tribCode in ['cap1','bnk1'] and le.bill_to_output.hriskaddrflag='4' => le.bill_to_output.hriskstate,
					   tribCode in ['cap1','bnk1'] and le.bill_to_output.hriskphoneflag='6' => le.bill_to_output.hriskstatephone,
					   '');
	self.hriskzip := map(tribCode in ['cap1','bnk1'] and le.bill_to_output.hriskaddrflag='4' => le.bill_to_output.hriskzip,
					 tribCode in ['cap1','bnk1'] and le.bill_to_output.hriskphoneflag='6' => le.bill_to_output.hriskzipphone,
					 '');
					  
	self.disthphoneaddr := if(tribCode in ['cap1','bnk1'] and le.bill_to_output.disthphoneaddr<>9999, (string)le.bill_to_output.disthphoneaddr,if(tribCode in ['fds3','fds4','fd23'], '', '0'));
	self.disthphonewphone := if(tribCode in ['cap1','bnk1'] and le.bill_to_output.disthphonewphone<>9999, (string)le.bill_to_output.disthphonewphone,if(tribCode in ['fds3','fds4','fd23'], '', '0'));
	self.distwphoneaddr := if(tribCode in ['cap1','bnk1'] and le.bill_to_output.distwphoneaddr<>9999, (string)le.bill_to_output.distwphoneaddr,if(tribCode in ['fds3','fds4','fd23'], '', '0'));

	self.numfraud := if(tribCode in ['cap1','bnk1'], RiskWise.getNumFraud('0',self.aptscanflag,self.addrvalflag,self.decsflag,self.bansflag,self.drlcvalflag).PRIO(self.hriskphoneflag,
															self.phonevalflag,self.phonezipflag,self.hriskaddrflag,self.socsdobflag,self.socsvalflag,self.idtheftflag),'');													
	self.targusType := if(le.Bill_To_Output.TargusType <> '', le.Bill_To_Output.TargusType, le.Ship_To_Output.TargusType);
	self.src := if(le.Bill_To_Output.src <> '', le.Bill_To_Output.src, le.Ship_To_Output.src);
	self.TargusGatewayUsed := if(le.Bill_To_Output.TargusGatewayUsed, le.Bill_To_Output.TargusGatewayUsed, le.Ship_To_Output.TargusGatewayUsed);
												
	self := [];
end;
mapped_results := join(iid_results, indata, left.bill_to_output.seq = (right.seq * 2), fill_output(left,right), left outer);


// get boca shell results for the models
btstclam := if(tribCode in ['cap1','fds3','fds4','fd23','bnk1','fd23'], 
			Risk_Indicators.BocaShell_BtSt_Function(iid_results, gateways, dppa, glb, false, false, true, false, false, true,dataRestriction:=DataRestriction,dataPermission:=dataPermission,
                                                                                     LexIdSourceOptout := LexIdSourceOptout, 
                                                                                     TransactionID := TransactionID, 
                                                                                     BatchUID := BatchUID, 
                                                                                     GlobalCompanyID := GlobalCompanyID),
			group(dataset([],Risk_Indicators.Layout_BocaShell_BtSt_Out),Bill_To_Out.seq));
		
clam := project(btstclam, transform(risk_indicators.Layout_Boca_Shell, self:=left.bill_to_out));
clam2 := project(btstclam, transform(risk_indicators.Layout_Boca_Shell, self:=left.ship_to_out));

getScore := map(tribCode in ['cap1','fds3','fds4','fd23'] => Models.FD5609_2_0(clam, true),
			 tribCode in ['bnk1'] => Models.TBN509_0_0(clam, true),
			 dataset([],Models.Layout_ModelOut));


working_layout addBTmodel(mapped_results le, getScore ri) := TRANSFORM
	self.score := ri.score;
	self.reason11 := map(tribCode in ['cap1','fds3','fds4','fd23'] => ri.ri[1].hri,
					 tribCode = 'bnk1' => if(Risk_Indicators.rcSet.isCode36(ri.ri[1].hri), '36', ri.ri[1].hri),
					 '');
	self.reason21 := if(tribCode in ['cap1','bnk1','fds3','fds4','fd23'],ri.ri[2].hri,'');
	self.reason31 := if(tribCode in ['cap1','bnk1','fds3','fds4','fd23'],ri.ri[3].hri,'');
	self.reason41 := if(tribCode in ['cap1','bnk1','fds3','fds4','fd23'],ri.ri[4].hri,'');	
	self := le;
END;
withBTmodel := join(mapped_results, getScore, (left.seq*2) = right.seq, addBTmodel(left, right), left outer);


getScore2 := if(tribCode = 'cap1', ungroup(Models.TBN509_0_0(clam, true)), dataset([],Models.Layout_ModelOut));
			  
working_layout addModel2(withBTmodel le, getScore2 ri) := TRANSFORM
	self.score2 := ri.score;
	self.reason12 := if(Risk_Indicators.rcSet.isCode36(ri.ri[1].hri), '36', ri.ri[1].hri);
	self.reason22 := ri.ri[2].hri;
	self.reason32 := ri.ri[3].hri;
	self.reason42 := ri.ri[4].hri;
	
	self := le;
END;
withModel2 := join(withBTmodel, getScore2, (left.seq*2) = right.seq, addModel2(left,right), left outer);


getScore3 := if(tribCode = 'fd23', ungroup(Models.FD5510_0_0(clam2, true)), dataset([],Models.Layout_ModelOut));

working_layout addModel3(withModel2 le, getScore3 ri) := TRANSFORM
	self.score2 := if(tribCode = 'fd23', ri.Score, le.score2);
	self.reason12 := if(tribCode = 'fd23', ri.ri[1].hri, le.reason12);
	self.reason22 := if(tribCode = 'fd23', ri.ri[2].hri, le.reason22);
	self.reason32 := if(tribCode = 'fd23', ri.ri[3].hri, le.reason32);
	self.reason42 := if(tribCode = 'fd23', ri.ri[4].hri, le.reason42);
	
	self := le;
END;
withModel3 := join(withModel2, getScore3, (left.seq*2)+1 = right.seq, addModel3(left,right), left outer);

Layout_PR20_4_royalties := RECORD
	RiskWise.Layout_PR2O;
	Layout_for_Royalties;
end;

Layout_PR20_4_royalties format_output(withModel3 le) := TRANSFORM
	self.account := le.account;
	self.acctno := le.acctno;
	self.riskwiseid := le.riskwiseid;
	self.hriskphoneflag := le.hriskphoneflag;
	self.phonevalflag := le.phonevalflag;
	self.phonezipflag := le.phonezipflag;
	self.hriskaddrflag := le.hriskaddrflag;
	self.decsflag := le.decsflag;
	self.socsdobflag := le.socsdobflag;
	self.socsvalflag := le.socsvalflag;
	self.drlcvalflag := le.drlcvalflag;
	self.frdriskscore := le.frdriskscore;
	self.areacodesplitflag := le.areacodesplitflag;
	self.altareacode := le.altareacode;
	self.splitdate := le.splitdate;
	self.addrvalflag := le.addrvalflag;
	self.dwelltypeflag := le.dwelltypeflag;	
	self.cassaddr := le.cassaddr;
	self.casscity := le.casscity;
	self.cassstate := le.cassstate;
	self.casszip := le.casszip;
	self.bansflag := le.bansflag;	
	self.coaalertflag := le.coaalertflag;
	self.coafirst := le.coafirst;
	self.coalast := le.coalast;
	self.coaaddr := le.coaaddr;
	self.coacity := le.coacity;
	self.coastate := le.coastate;
	self.coazip := le.coazip;
	self.idtheftflag := le.idtheftflag;
	self.aptscanflag := le.aptscanflag;
	self.addrhistoryflag := le.addrhistoryflag;	
	self.firstcount := le.firstcount;
	self.lastcount := le.lastcount;
	self.formerlastcount := le.formerlastcount;
	self.addrcount := le.addrcount;
	self.hphonecount := le.hphonecount;
	self.wphonecount := le.wphonecount;
	self.socscount := le.socscount;
	self.socsverlevel := le.socsverlevel;
	self.dobcount := le.dobcount;
	self.drlccount := le.drlccount;
	self.emailcount := le.emailcount;	
	self.numelever := le.numelever;
	self.numsource := le.numsource;	
	self.verfirst := le.verfirst;
	self.verlast := le.verlast;
	self.vercmpy := le.vercmpy;
	self.veraddr := le.veraddr;
	self.vercity := le.vercity;
	self.verstate := le.verstate;
	self.verzip := le.verzip;
	self.verhphone := le.verhphone;
	self.verwphone := le.verwphone;
	self.versocs := le.versocs;
	self.verdob := le.verdob;
	self.verdrlc := le.verdrlc;
	self.veremail := le.veremail;	
	self.firstscore := le.firstscore;
	self.lastscore := le.lastscore;
	self.cmpyscore := le.cmpyscore;
	self.addrscore := le.addrscore;
	self.hphonescore := le.hphonescore;
	self.wphonescore := le.wphonescore;
	self.socsscore := le.socsscore;
	self.dobscore := le.dobscore;
	self.drlcscore := le.drlcscore;
	self.emailscore := le.emailscore;	
	self.socsmiskeyflag := le.socsmiskeyflag;
	self.hphonemiskeyflag := le.hphonemiskeyflag;
	self.addrmiskeyflag := le.addrmiskeyflag;	
	self.hriskcmpy := le.hriskcmpy;
	self.hrisksic := le.hrisksic;
	self.hriskphone := le.hriskphone;
	self.hriskaddr := le.hriskaddr;
	self.hriskcity := le.hriskcity;
	self.hriskstate := le.hriskstate;
	self.hriskzip := le.hriskzip;					  
	self.disthphoneaddr := le.disthphoneaddr;
	self.disthphonewphone := le.disthphonewphone;
	self.distwphoneaddr := le.distwphoneaddr;
	self.estincome := le.estincome;	
	self.numfraud := le.numfraud;	
	self.score := le.score;						 
	self.reason11 := le.reason11;
	self.reason21 := le.reason21;
	self.reason31 := le.reason31;
	self.reason41 := le.reason41;	
	self.score2 := le.score2;	
	self.reason12 := le.reason12;
	self.reason22 := le.reason22;
	self.reason32 := le.reason32;
	self.reason42 := le.reason42;
	self.billing := le.billing;
	self.TargusType := le.TargusType;
	self.src := le.src;
	self.TargusGatewayUsed := le.TargusGatewayUsed;
END;
final := project(withModel3, format_output(left));

RETURN final;

END;