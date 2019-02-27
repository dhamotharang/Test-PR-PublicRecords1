import ut, Risk_Indicators, Risk_Reporting, Models, gateway, riskwise;

export PRIO_Function(DATASET(Layout_PRII) indata, dataset(Gateway.Layouts.Config) gateways, unsigned1 glb, unsigned1 dppa, 
	string4 tribCode, string50 DataRestriction=risk_indicators.iid_constants.default_DataRestriction,
	string50 DataPermission=risk_indicators.iid_constants.default_DataPermission) := FUNCTION

risk_indicators.layout_input into(indata le) := TRANSFORM

	clean_a := risk_indicators.MOD_AddressClean.clean_addr(le.addr, le.city, le.state, le.zip) ;
	
	ssn_val := cleanSSN( le.socs );
	hphone_val := cleanPhone( le.hphone );
	wphone_val := cleanPhone( le.wphone );
	dob_val := cleanDOB(le.dob);
	dl_num_clean := cleanDL_num( le.drlc );

	self.seq := le.seq;
	self.historydate := le.historydate;
	self.ssn := ssn_val;
	self.dob := dob_val;
	self.phone10 := hphone_val;	
	self.wphone10 := wphone_val;
	self.fname := stringlib.stringtouppercase(le.first);
	self.mname := stringlib.stringtouppercase(le.middleini);
	self.lname := stringlib.stringtouppercase(le.last);
	self.in_streetAddress := stringlib.stringtouppercase(le.addr);
	self.in_city := stringlib.stringtouppercase(le.city);
	self.in_state := stringlib.stringtouppercase(le.state);
	self.in_zipCode := le.zip;
	self.prim_range := clean_a[1..10];
	self.predir := clean_a[11..12];
	self.prim_name := clean_a[13..40];
	self.addr_suffix := clean_a[41..44];
	self.postdir := clean_a[45..46];
	self.unit_desig := clean_a[47..56];
	self.sec_range := clean_a[57..64];
	self.p_city_name := clean_a[90..114];
	self.st := clean_a[115..116];
	self.z5 := if(clean_a[117..121]<>'',clean_a[117..121],le.zip[1..5]);		// use the input zip if cass zip is empty
	self.zip4 := if(clean_a[122..125]<>'', clean_a[122..125], le.zip[6..9]);	// use the input zip if cass zip is empty
	self.lat := clean_a[146..155];
	self.long := clean_a[156..166];
	
	// for Chase, override the address type, otherwise simply use the result from the address cleaner
	self.addr_type := if(tribcode='pi02',
		risk_indicators.iid_constants.override_addr_type(le.addr, clean_a[139],clean_a[126..129]),
		clean_a[139]);
	
	self.addr_status := clean_a[179..182];
	self.county := clean_a[143..145];
	self.geo_blk := clean_a[171..177];
	self.dl_number := stringlib.stringtouppercase(dl_num_clean);
	self.dl_state := stringlib.stringtouppercase(le.drlcstate);
	self.age := if ((integer)dob_val != 0, (string3)ut.GetAgeI((integer)dob_val), '');
	self.email_address := le.email;
	self.employer_name := stringlib.stringtouppercase(le.cmpy);
	self.lname_prev := stringlib.stringtouppercase(le.formerlast);
	self.country := le.countrycode;
	
	self := [];
END;
prep := PROJECT(indata,into(LEFT));

bs_version := if(tribcode='pi02', 2, 1);																					
ret := Risk_Indicators.InstantID_Function(prep, gateways, dppa, glb, false, false, true, true, false, 
	in_BSversion := bs_version,in_DataRestriction := DataRestriction,in_DataPermission := DataPermission);

// intermediate results
working_layout := RECORD
	RiskWise.Layout_PRIO;
	unsigned4 seq;
	Layout_for_Royalties;
END;


string2 getSocsLevel(unsigned1 level) := map(level in [0,2,3,5,8] => '0',
									level = 1 => '1',
									level = 4 => '2',
									level = 6 => '3',
									level = 7 => '4',
									(string)(level-4));	// 9,10,11,12 results in 5,6,7,8
									


//regular expressions
poAddress_expression := '((P[\\s\\.]*O[\\.\\s]*)|(POST[\\s]*OFFICE[\\s]*))+BOX';  //find reference to po box or post office box
onlyContains_express := '^(([\\s]*CO[\\.]?)|([\\s]*ASSOCIATES))$';
endingInc_expression := '(INC[.]*)$';
endsWith_expression := '([\\s]*ASSOC|[\\s]*ASSOCIATES|(AND)?[\\s\\&]*COMPANY|((\\.CO)|(CO\\.)|(\\sCO)|(\\&CO)|(\\&\\sCO\\.)|(\\&\\sCO)|(\\&CO\\.))|[\\s]*ACCT|[\\s\\&]*LLP[\\.]?|[\\s\\&]*LLC[\\.]?)$';
lastEndsWith_expression := '([\\s]*DDS[\\.]?)$';
contains_expression := '(ACCOUNT|BUSINESS|\\&)';


working_layout format_out(ret le, indata ri) := TRANSFORM
	self.seq := ri.seq;
	self.account := ri.account;
	self.acctno := ri.acctno;
	self.riskwiseid := (string)le.did;
	
	self.hriskphoneflag := if(tribCode in ['pi01','pi02','pi04','pi05','pi07','pi09','pi14','allv','pi60','hdx1','flfn','bnk2','bnk3'], le.hriskphoneflag, '');
	self.phonevalflag := if(tribCode in ['pi01','pi02','pi04','pi05','pi07','pi09','pi14','allv','pi60','hdx1','flfn','bnk2','bnk3'], if(le.hriskphoneflag = '5', '3', le.phonevalflag), '');
	self.phonezipflag := if(tribCode in ['pi01','pi02','pi04','pi05','pi07','pi09','pi14','allv','pi60','hdx1','flfn','bnk2','bnk3'], le.phonezipflag, '');
	self.hriskaddrflag := if(tribCode in ['pi01','pi02','pi04','pi05','pi07','pi09','pi14','allv','pi60','hdx1','flfn','bnk2','bnk3'],
													if(tribcode = 'pi02' AND le.addr_status = 'E600', '6', le.hriskaddrflag), '');
	self.decsflag := if(tribCode in ['pi01','pi02','pi04','pi05','pi07','pi09','pi14','allv','pi60','hdx1','flfn','bnk2','bnk3'], le.decsflag, '');
	self.socsdobflag := if(tribCode in ['pi01','pi02','pi04','pi05','pi07','pi09','pi14','allv','pi60','hdx1','flfn','bnk2','bnk3'], le.socsdobflag, '');
	self.socsvalflag := if(tribCode in ['pi01','pi02','pi04','pi05','pi07','pi09','pi14','allv','pi60','hdx1','flfn','bnk2','bnk3'], le.socsvalflag, '');
	self.drlcvalflag := if(tribCode in ['pi01','pi02','pi04','pi05','pi07','pi09','pi14','allv','pi60','hdx1','flfn','bnk2','bnk3'], if(le.drlcvalflag = '3', '1', le.drlcvalflag), '');
		
	self.areacodesplitflag := if(tribCode in ['pi01','pi02','pi04','pi05','pi07','pi09','pi14','allv','pi60','hdx1','flfn','bnk2','bnk3'], map(le.phone10 = '' => '2',
																												    le.areacodesplitflag = 'Y' => '1',
																												    ''), '');
	self.altareacode := if(tribCode in ['pi01','pi02','pi04','pi05','pi07','pi09','pi14','allv','pi60','hdx1','flfn','bnk2','bnk3'] and le.areacodesplitflag = 'Y', le.altareacode, '');
	self.splitdate := if(tribCode in ['pi01','pi02','pi04','pi05','pi07','pi09','pi14','allv','pi60','hdx1','flfn','bnk2','bnk3'] and le.areacodesplitflag = 'Y', le.areacodesplitdate, '');
	
	self.addrvalflag := if(tribCode in ['pi01','pi02','pi04','pi05','pi07','pi09','pi14','allv','pi60','hdx1','flfn','bnk2','bnk3'], le.addrvalflag, '');
	self.dwelltypeflag := map(tribCode in ['pi01','pi02','pi04','pi05','pi07','pi09','pi14','allv','pi60','hdx1','flfn','bnk2'] => le.dwelltype,
						 tribCode = 'bnk3' and le.dwelltype = '' and le.addrvalflag = 'N' and le.combo_addrcount > 1 and le.prim_range = le.combo_prim_range => 'U',
						 tribCode = 'bnk3' => le.dwelltype,
						 '');
	
	self.cassaddr := if(tribCode in ['pi01','pi02','pi04','pi05','pi07','pi09','pi14','allv','pi60','hdx1','flfn','bnk2','bnk3'], Risk_Indicators.MOD_AddressClean.street_address('',le.prim_range,le.predir,le.prim_name,
																															    le.addr_suffix,le.postdir,le.unit_desig,
																															    le.sec_range), '');
	self.casscity := if(tribCode in ['pi01','pi02','pi04','pi05','pi07','pi09','pi14','allv','pi60','hdx1','flfn','bnk2','bnk3'], le.p_city_name, '');
	self.cassstate := if(tribCode in ['pi01','pi02','pi04','pi05','pi07','pi09','pi14','allv','pi60','hdx1','flfn','bnk2','bnk3'], le.st, '');
	self.casszip := if(tribCode in ['pi01','pi02','pi04','pi05','pi07','pi09','pi14','allv','pi60','hdx1','flfn','bnk2','bnk3'], le.z5+le.zip4, '');
	
	self.bansflag := if(tribCode in ['pi01','pi02','pi04','pi05','pi07','pi14','allv','pi60','hdx1','flfn','bnk2','bnk3'], le.bansflag, '');
	
	self.coaalertflag := map(tribCode in ['pi04','pi60','hdx1'] => if(le.coaalertflag, (string)(integer)le.coaalertflag, ''), '');
	self.coafirst := if(tribCode in ['pi04','pi60','hdx1'], le.coafirst, '');
	self.coalast := if(tribCode in ['pi04','pi60','hdx1'], le.coalast, '');
	self.coaaddr := if(tribCode in ['pi04','pi60','hdx1'], Risk_Indicators.MOD_AddressClean.street_address('',le.coaprim_range, le.coapredir, le.coaprim_name, 
																	   le.coasuffix, le.coapostdir, le.coaunit_desig, le.coasec_range), '');
	self.coacity := if(tribCode in ['pi04','pi60','hdx1'], le.coacity, '');
	self.coastate := if(tribCode in ['pi04','pi60','hdx1'], le.coastate, '');
	self.coazip := if(tribCode in ['pi04','pi60','hdx1'], le.coazip, '');
	
	self.idtheftflag := if(tribCode in ['pi02','pi04','pi05','pi07','pi09','pi14','allv','pi60','hdx1','flfn','bnk2','bnk3'], le.idtheftflag, '');
	self.aptscanflag := if(tribCode in ['pi02','pi04','pi60','hdx1','bnk2','bnk3'], (string)(integer)le.aptscamflag, '');
	self.addrhistoryflag := map(tribCode in ['pi02','pi04','hdx1','bnk2','bnk3'] => '0',
						   tribCode = 'pi60' => if(le.watchlist_table <> '', '1', '0'),
						   '');
	
	f := if(tribCode in ['pi04','pi60'], 9, 2);
	
	isFirstExpressionFound := if(tribCode = 'pi02', if(regexfind(onlyContains_express + '|' + contains_expression + '|' + endsWith_expression, TRIM(ri.first), NOCASE), TRUE, FALSE), FALSE);
	isLastExpressionFound  := if(tribCode = 'pi02', if(regexfind(onlyContains_express + '|' + contains_expression + '|' + endsWith_expression + '|' + lastEndsWith_expression + '|' + endingInc_expression, TRIM(ri.last), NOCASE), TRUE, FALSE), FALSE);
	isPoBoxExpressionFound := if(tribCode = 'pi02', if(regexfind(poAddress_expression, TRIM(ri.addr), NOCASE), TRUE, FALSE), FALSE);	
	
	
	self.firstcount := if(ri.first <> '' and tribCode in ['pi01','pi02','pi04','pi05','pi07','pi09','pi14','allv','pi60','hdx1','flfn','bnk2','bnk3'], 
																		map(tribCode = 'pi02' AND isFirstExpressionFound => '0',
																				flattenCount(le.combo_firstcount,f,1)), 
																		'');
																			
	self.lastcount := if(ri.last <> '' and tribCode in ['pi01','pi02','pi04','pi05','pi07','pi09','pi14','allv','pi60','hdx1','flfn','bnk2','bnk3'],
																		map(tribCode = 'pi02' AND isLastExpressionFound => '0',
																				flattenCount(le.combo_lastcount,f,1)),
																		'');
																		
	self.formerlastcount := if(ri.cmpy <> '' and tribCode in ['pi04','pi05','pi07','allv','pi60','hdx1','flfn'], flattenCount(le.combo_cmpycount,f,1), '');
	self.addrcount := if(ri.addr <> '' and tribCode in ['pi01','pi02','pi04','pi05','pi07','pi09','pi14','allv','pi60','hdx1','flfn','bnk2','bnk3'], 
																	map(tribCode = 'pi02' AND isPoBoxExpressionFound => '0',
																			tribCode ='bnk3' AND le.addr_type = 'P' => '0',
																			flattenCount(le.combo_addrcount,f,1)),
																	'');
												
	// add code here to see if hphone or wphone score higher and only populate that one, do this for score also
	self.hphonecount := map(ri.hphone <> '' and tribCode in ['pi01','pi02','pi04','pi05','pi07','pi09','pi14','pi60','hdx1','flfn','bnk2','bnk3'] or (tribCode = 'allv' and 
																				le.combo_addrcount > 0 and le.phone10 <> '') => flattenCount(le.combo_hphonecount,f,1),
					    le.combo_addrcount = 0 and tribCode = 'allv' => '0',
					    '');
	self.wphonecount := if(ri.wphone <> '' and tribCode in ['pi01','pi02','pi04','pi05','pi07','pi09','pi14','allv','pi60','hdx1','flfn','bnk2','bnk3'] and le.combo_wphonescore <> 255, 
																															flattenCount(le.combo_wphonecount,f,1), '');
	self.socscount := if(ri.socs <> '' and tribCode in ['pi01','pi02','pi04','pi05','pi07','pi09','pi14','allv','pi60','hdx1','flfn','bnk2','bnk3'], flattenCount(le.combo_ssncount,f,1), '');
	
	self.socsverlevel := if(tribCode in ['pi01','pi02','pi04','pi05','pi09','pi14','allv','pi60','hdx1','flfn','bnk2','bnk3'], getSocsLevel(le.socsverlevel), '');
	
	self.dobcount := if(ri.dob <> '' and tribCode in ['pi01','pi02','pi04','pi05','pi07','pi09','pi14','allv','pi60','hdx1','flfn','bnk2','bnk3'], flattenCount(le.combo_dobcount,f,1), '');
	
	self.numelever := if(tribCode in ['pi01','pi02','pi04','pi05','pi07','pi09','pi14','allv','pi60','hdx1','flfn','bnk2','bnk3'],
													if(tribcode IN ['bnk3'] AND le.addr_type = 'P',(string)(le.numelever-1),(string)le.numelever), '');
													
	self.numsource := if(tribCode in ['pi01','pi02','pi04','pi05','pi07','pi09','pi14','allv','pi60','hdx1','flfn','bnk2','bnk3'],
							(string)((integer)self.firstcount+(integer)self.lastcount+(integer)self.addrcount+(integer)self.hphonecount+(integer)self.wphonecount+
								    (integer)self.socscount+(integer)self.dobcount), '');
	
	self.verfirst := if(tribCode in ['pi01','pi02','pi04','pi05','pi09','pi14','allv','pi60','hdx1','flfn','bnk2','bnk3'],
														map(tribCode = 'pi02' AND isFirstExpressionFound => '',
																le.combo_first),
														'');

	self.verlast := if(tribCode in ['pi01','pi02','pi04','pi05','pi09','pi14','allv','pi60','hdx1','flfn','bnk2','bnk3'],
														map(tribCode = 'pi02' AND isLastExpressionFound => '',
																le.combo_last),
														'');
														
	self.vercmpy := if(tribCode in ['pi01','pi02','pi04','pi05','pi09','pi14','allv','pi60','hdx1','flfn','bnk2','bnk3'], le.combo_cmpy, '');
	self.veraddr := if(tribCode in ['pi01','pi02','pi04','pi05','pi09','pi14','allv','pi60','hdx1','flfn','bnk2','bnk3'],
														map(tribCode = 'pi02' AND isPoBoxExpressionFound => '',
																tribCode = 'bnk3' AND le.addr_type = 'P' => '',
																Risk_Indicators.MOD_AddressClean.street_address('',le.combo_prim_range,le.combo_predir,
																														le.combo_prim_name,le.combo_suffix,
																														le.combo_postdir,le.combo_unit_desig,
																														le.combo_sec_range)),
														'');
																														
	self.vercity := if(tribCode in ['pi01','pi02','pi04','pi05','pi09','pi14','allv','pi60','hdx1','flfn','bnk2','bnk3'], 
											if(tribcode IN ['bnk3'] AND le.addr_type = 'P', '', le.combo_city), '');
											
	self.verstate := if(tribCode in ['pi01','pi02','pi04','pi05','pi09','pi14','allv','pi60','hdx1','flfn','bnk2','bnk3'], 
											if(tribcode IN ['bnk3'] AND le.addr_type = 'P', '', le.combo_state), '');
											
	self.verzip := if(tribCode in ['pi01','pi02','pi04','pi05','pi09','pi14','allv','pi60','hdx1','flfn','bnk2','bnk3'], 
											if(tribcode IN ['bnk3'] AND le.addr_type = 'P', '', le.combo_zip), '');
											
	self.verhphone := map(tribCode in ['pi01','pi02','pi04','pi05','pi09','pi14','allv','pi60','flfn','bnk2','bnk3'] or (tribCode = 'hdx1' and le.combo_hphonecount > 0) => le.combo_hphone,
					  tribCode = 'hdx1' and le.dirsaddr_phone<>'' and le.phoneaddr_lastcount>0 and le.phoneaddr_addrcount>0 => le.dirsaddr_phone,	//  just a guess here
					  '');
	self.verwphone := if(tribCode in ['pi01','pi02','pi04','pi05','pi09','pi14','allv','pi60','hdx1','flfn','bnk2','bnk3'], le.combo_wphone, ''); 
	self.versocs := map(tribCode in ['pi01','pi02','pi04','pi05','pi09','pi14','allv','pi60','hdx1','flfn','bnk2','bnk3'] and le.combo_ssncount > 0 => le.combo_ssn,
					tribCode = 'hdx1' and ri.socs = '' => le.versocs,	// just a guess here, use the header social if no input social
					'');
	self.verdob := if(tribCode in ['pi01','pi02','pi04','pi05','pi09','pi14','allv','pi60','hdx1','flfn','bnk2','bnk3'], le.combo_dob, '');
	
	self.firstscore := if(ri.first <> '' and tribCode in ['pi01','pi02','pi04','pi05','pi09','pi14','allv','pi60','hdx1','flfn','bnk2','bnk3'],
															map(tribCode = 'pi02' AND isFirstExpressionFound => '0',
																	if(le.combo_firstscore = 255, '0', (string)le.combo_firstscore)),
															'');
																																																												
	self.lastscore := if(ri.last <> '' and tribCode in ['pi01','pi02','pi04','pi05','pi09','pi14','allv','pi60','hdx1','flfn','bnk2','bnk3'],
															map(tribCode = 'pi02' AND isLastExpressionFound => '0',
																	if(le.combo_lastscore = 255, '0', (string)le.combo_lastscore)),
															'');
															
	self.cmpyscore := if(ri.cmpy <> '' and tribCode in ['pi01','pi02','pi04','pi05','pi09','pi14','allv','pi60','hdx1','flfn','bnk2','bnk3'], 
																									if(le.combo_cmpyscore = 255, '0', (string)le.combo_cmpyscore), '');
	self.addrscore := if(ri.addr <> '' and tribCode in ['pi01','pi02','pi04','pi05','pi09','pi14','allv','pi60','hdx1','flfn','bnk2','bnk3'],
															map(tribCode = 'pi02' AND isPoBoxExpressionFound => '0',
																	tribCode = 'bnk3' AND le.addr_type = 'P' => '0',
																	if(le.combo_addrscore = 255, '0', (string)le.combo_addrscore)),
															'');
																									
	self.hphonescore := if(ri.hphone <> '' and tribCode in ['pi01','pi02','pi04','pi05','pi09','pi14','allv','pi60','hdx1','flfn','bnk2','bnk3'], 
																									if(le.combo_hphonescore = 255, '0', (string)le.combo_hphonescore), '');
	self.wphonescore := if(ri.wphone <> '' and tribCode in ['pi01','pi02','pi04','pi05','pi09','pi14','allv','pi60','hdx1','flfn','bnk2','bnk3'] and le.combo_wphonescore <> 255, 
																									(string)le.combo_wphonescore, '');
	self.socsscore := if(ri.socs <> '' and tribCode in ['pi01','pi02','pi04','pi05','pi09','pi14','allv','pi60','hdx1','flfn','bnk2','bnk3'], 
																									if(le.combo_ssnscore = 255, '0', (string)le.combo_ssnscore), '');
	self.dobscore := if(ri.dob <> '' and tribCode in ['pi01','pi02','pi04','pi05','pi09','pi14','allv','pi60','hdx1','flfn','bnk2','bnk3'], 
																									if(le.combo_dobscore = 255, '0', (string)le.combo_dobscore), '');
	
	self.socsmiskeyflag := if(tribCode in ['pi01','pi02','pi04','pi05','pi07','pi09','pi14','allv','pi60','hdx1','flfn','bnk2','bnk3'], (string)(integer)le.socsmiskeyflag, '');
	self.hphonemiskeyflag := if(tribCode in ['pi01','pi02','pi04','pi05','pi07','pi09','pi14','allv','pi60','hdx1','flfn','bnk2','bnk3'], (string)(integer)le.hphonemiskeyflag, '');
	self.addrmiskeyflag := if(tribCode in ['pi01','pi02','pi04','pi05','pi07','pi09','pi14','allv','pi60','hdx1','flfn','bnk2','bnk3'], (string)(integer)le.addrmiskeyflag, '');
	
	self.hriskcmpy := map(tribCode in ['pi01','pi02','pi04','pi05','pi07','pi09','pi14','allv','pi60','hdx1','flfn','bnk2','bnk3'] and le.hriskaddrflag = '4' => le.hriskcmpy,
					  tribCode in ['pi01','pi02','pi04','pi05','pi07','pi09','pi14','allv','pi60','hdx1','flfn','bnk2','bnk3'] and le.hriskphoneflag = '6' => le.hriskcmpyphone,
					  '');
	self.hrisksic := map(tribCode in ['pi01','pi02','pi04','pi05','pi07','pi09','pi14','allv','pi60','hdx1','flfn','bnk2','bnk3'] and le.hriskaddrflag = '4' => convertSIC(le.hrisksic),
					 tribCode in ['pi01','pi02','pi04','pi05','pi07','pi09','pi14','allv','pi60','hdx1','flfn','bnk2','bnk3'] and le.hriskphoneflag = '6' => convertSIC(le.hrisksicphone),
					 '');
	self.hriskphone := map(tribCode in ['pi01','pi02','pi04','pi05','pi07','pi09','pi14','allv','pi60','hdx1','flfn','bnk2','bnk3'] and le.hriskaddrflag = '4' => le.hriskphone,
					   tribCode in ['pi01','pi02','pi04','pi05','pi07','pi09','pi14','allv','pi60','hdx1','flfn','bnk2','bnk3'] and le.hriskphoneflag = '6' => le.hriskphonephone,
					   '');
	self.hriskaddr := map(tribCode in ['pi01','pi02','pi04','pi05','pi07','pi09','pi14','allv','pi60','hdx1','flfn','bnk2','bnk3'] and le.hriskaddrflag = '4' => le.hriskaddr,
					  tribCode in ['pi01','pi02','pi04','pi05','pi07','pi09','pi14','allv','pi60','hdx1','flfn','bnk2','bnk3'] and le.hriskphoneflag = '6' => le.hriskaddrphone,
					  '');
	self.hriskcity := map(tribCode in ['pi01','pi02','pi04','pi05','pi07','pi09','pi14','allv','pi60','hdx1','flfn','bnk2','bnk3'] and le.hriskaddrflag = '4' => le.hriskcity,
					  tribCode in ['pi01','pi02','pi04','pi05','pi07','pi09','pi14','allv','pi60','hdx1','flfn','bnk2','bnk3'] and le.hriskphoneflag = '6' => le.hriskcityphone,
					  '');
	self.hriskstate := map(tribCode in ['pi01','pi02','pi04','pi05','pi07','pi09','pi14','allv','pi60','hdx1','flfn','bnk2','bnk3'] and le.hriskaddrflag = '4' => le.hriskstate,
					   tribCode in ['pi01','pi02','pi04','pi05','pi07','pi09','pi14','allv','pi60','hdx1','flfn','bnk2','bnk3'] and le.hriskphoneflag = '6' => le.hriskstatephone,
					   '');
	self.hriskzip := map(tribCode in ['pi01','pi02','pi04','pi05','pi07','pi09','pi14','allv','pi60','hdx1','flfn','bnk2','bnk3'] and le.hriskaddrflag = '4' => le.hriskzip,
					 tribCode in ['pi01','pi02','pi04','pi05','pi07','pi09','pi14','allv','pi60','hdx1','flfn','bnk2','bnk3'] and le.hriskphoneflag = '6' => le.hriskzipphone,
					 '');
	
	self.disthphoneaddr := map(tribCode in ['pi04','pi05','pi07','pi09','pi14','allv','pi60','hdx1','flfn'] => if(le.disthphoneaddr <> 9999, (string)le.disthphoneaddr, ''),
						  tribCode in ['pi01','pi02','bnk2','bnk3'] => if(le.disthphoneaddr <> 9999, (string)le.disthphoneaddr, '0'),
						  '');
	self.disthphonewphone := map(tribCode in ['pi04','pi05','pi07','pi09','pi14','allv','pi60','hdx1','flfn'] => if(le.disthphonewphone <> 9999, (string)le.disthphonewphone, ''),
						  tribCode in ['pi01','pi02','bnk2','bnk3'] => if(le.disthphonewphone <> 9999, (string)le.disthphonewphone, '0'),
						  '');
	self.distwphoneaddr := map(tribCode in ['pi04','pi05','pi07','pi09','pi14','allv','pi60','hdx1','flfn'] => if(le.distwphoneaddr <> 9999, (string)le.distwphoneaddr, ''),
						  tribCode in ['pi01','pi02','bnk2','bnk3'] => if(le.distwphoneaddr <> 9999, (string)le.distwphoneaddr, '0'),
						  '');
	
	self.numfraud := if(tribCode in ['pi01','pi02','pi04','pi05','pi07','pi09','pi14','allv','pi60','hdx1','flfn','bnk2','bnk3'],
											getNumFraud(self.coaalertflag,self.aptscanflag,self.addrvalflag,self.decsflag,self.bansflag,self.drlcvalflag).PRIO(self.hriskphoneflag,
													  self.phonevalflag,self.phonezipflag,self.hriskaddrflag,self.socsdobflag,self.socsvalflag,self.idtheftflag), '');
	
	self.first := map(tribCode = 'hdx1' and le.chronoaddrscore < 80 => le.chronofirst, // these names may be incorrect
				   tribCode = 'hdx1' => le.chronofirst2,
				   '');	
	self.last := map(tribCode = 'hdx1' and le.chronoaddrscore < 80 => le.chronolast,
				  tribCode = 'hdx1' => le.chronolast2,
				  '');
	self.addr := map(tribCode = 'hdx1' and le.chronoaddrscore < 80 => Risk_Indicators.MOD_AddressClean.street_address('',le.chronoprim_range, le.chronopredir, 
																			    le.chronoprim_name, le.chronosuffix,
																			    le.chronopostdir, le.chronounit_desig, le.chronosec_range),
				  tribCode = 'hdx1' => Risk_Indicators.MOD_AddressClean.street_address('',le.chronoprim_range2, le.chronopredir2, 
														 le.chronoprim_name2, le.chronosuffix2,
														 le.chronopostdir2, le.chronounit_desig2, le.chronosec_range2),
				  '');
	self.city := map(tribCode = 'hdx1' and le.chronoaddrscore < 80 => le.chronocity,
				  tribCode = 'hdx1' => le.chronocity2,
				  '');
	self.state := map(tribCode = 'hdx1' and le.chronoaddrscore < 80 => le.chronostate,
				   tribCode = 'hdx1' => le.chronostate2,
				   '');
	self.zip := map(tribCode = 'hdx1' and le.chronoaddrscore < 80 => le.chronozip,
				 tribCode = 'hdx1' => le.chronozip2,
				 '');
				
				
	self.first2 := map(tribCode = 'hdx1' and le.chronoaddrscore < 80 => le.chronofirst2, // these names may be incorrect
				    tribCode = 'hdx1' => le.chronofirst3,
				    '');	
	self.last2 := map(tribCode = 'hdx1' and le.chronoaddrscore < 80 => le.chronolast2,
				   tribCode = 'hdx1' => le.chronolast3,
				   '');
	self.addr2 := map(tribCode = 'hdx1' and le.chronoaddrscore < 80 => Risk_Indicators.MOD_AddressClean.street_address('',le.chronoprim_range3, le.chronopredir3, 
																			     le.chronoprim_name3, le.chronosuffix3,
																			     le.chronopostdir3, le.chronounit_desig3, le.chronosec_range3),
				   tribCode = 'hdx1' => Risk_Indicators.MOD_AddressClean.street_address('',le.chronoprim_range2, le.chronopredir2, 
														  le.chronoprim_name2, le.chronosuffix2,
														  le.chronopostdir2, le.chronounit_desig2, le.chronosec_range2),
				   '');
	self.city2 := map(tribCode = 'hdx1' and le.chronoaddrscore < 80 => le.chronocity3,
				   tribCode = 'hdx1' => le.chronocity2,
				   '');
	self.state2 := map(tribCode = 'hdx1' and le.chronoaddrscore < 80 => le.chronostate3,
				    tribCode = 'hdx1' => le.chronostate2,
				    '');
	self.zip2 := map(tribCode = 'hdx1' and le.chronoaddrscore < 80 => le.chronozip3,
				  tribCode = 'hdx1' => le.chronozip2,
				  '');
	self.TargusGatewayUsed := le.TargusGatewayUsed;
	self.src := le.src;
	self.TargusType := le.TargusType;			 
	self := [];
END;
mapped_results := join(ret, indata, left.seq = right.seq, format_out(left,right), left outer);


// get boca shell results for the models
// these three tribcodes use FP3710_0_0, FD9603_3_0 and TBN509_0_0, none of which reference vehicles
include_vehicles := NOT tribcode IN ['pi02','pi05','flfn'];
clam := if(tribCode in ['pi02','pi04','pi05','pi09','pi14','pi60','flfn','bnk2'], 
Risk_Indicators.Boca_Shell_Function(ret, gateways, dppa, glb, false, false, true, false, include_vehicles, true, 
BSversion:=bs_version, DataRestriction := DataRestriction, DataPermission := DataPermission),
		 group(dataset([],Risk_Indicators.Layout_Boca_Shell),seq));	
		 
bs_with_ip := record
	risk_indicators.Layout_Boca_Shell bs;
	riskwise.Layout_IP2O ip;
end;

clam_ip := project( clam, transform( bs_with_ip, self.bs := left, self.ip := [] ) );



// Get first score
fraudScore := map(tribCode in ['pi04','pi60'] => Models.AWN603_1_0(clam, true),
			   tribCode in ['pi05','flfn','pi14'] => Models.TBN509_0_0(clam, true),
			   tribCode = 'pi09' => Models.TBN604_1_0(clam, true),
			   dataset([],Models.layout_ModelOut));					
						
						
working_layout addModel(mapped_results le, fraudScore ri) := TRANSFORM
	self.frdriskscore := ri.Score;
	self := le;
END;
withModel := join(mapped_results, fraudScore, left.seq = right.seq, addModel(left,right),left outer);


// Get second score
estIncomeScore := map(tribCode = 'pi14' => Models.FD9603_4_0(clam, true),
				  tribCode = 'flfn' => Models.FD9603_3_0(clam, true),
				  tribCode = 'bnk2' => Models.IDN605_1_0(clam, true),
				  tribCode = 'pi02' => Models.FP3710_0_0(ungroup(clam_ip), 0),
				  dataset([],Models.layout_ModelOut));

Layout_PRIO_4_royalties := RECORD
	RiskWise.Layout_PRIO;
	Layout_for_Royalties;
END;
				  
				  
Layout_PRIO_4_royalties addModel2(withModel le, estIncomeScore ri) := TRANSFORM
	self.estincome := if(tribCode='flfn', '0' + ri.score, ri.score);
	self := le;
END;
model2 := join(withModel, estIncomeScore, left.seq=right.seq, addModel2(left,right), left outer);

/* *************************************
 *   Boca Shell Logging Functionality  *
 * NOTE: Because of the #stored below  *
 * this MUST go at the end of this     *
 * function in order to compile.       *
 ***************************************/
productID := Risk_Reporting.ProductID.RiskWise__RiskWiseMainPRIO;
	
intermediate_Log := Risk_Reporting.To_LOG_Boca_Shell(clam, productID, bs_Version);
#stored('Intermediate_Log', intermediate_log);
/* ************ End Logging ************/

RETURN model2;

END;