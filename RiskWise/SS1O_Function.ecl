IMPORT ut, business_risk, Risk_Indicators, Models, gateway, STD;

export SS1O_Function(DATASET(Layout_SS1I) indata, dataset(Gateway.Layouts.Config) gateways, unsigned1 glb, unsigned1 dppa, 
boolean isUtility=false, boolean ln_branded=false,
string50 DataRestriction=risk_indicators.iid_constants.default_DataRestriction,
string50 DataPermission=risk_indicators.iid_constants.default_DataPermission,
unsigned1 ofac_version = 1,
boolean include_ofac = false,
real global_watchlist_threshold = 0.84,
unsigned1 LexIdSourceOptout = 1,
string TransactionID = '',
string BatchUID = '',
unsigned6 GlobalCompanyId = 0
) := function

	tribCode := indata[1].tribcode;

risk_indicators.Layout_CIID_BtSt_In into_btst_in(indata le) := transform
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
	self.Bill_To_In.z5 := clean_a[117..121];
	self.Bill_To_In.zip4 := clean_a[122..125];
	self.Bill_To_In.lat := clean_a[146..155];
	self.Bill_To_In.long := clean_a[156..166];
	self.Bill_To_In.addr_type := clean_a[139];
	self.Bill_To_In.addr_status := clean_a[179..182];
	self.Bill_To_In.county := clean_a[143..145];
	self.Bill_To_In.geo_blk := clean_a[171..177];
	self.Bill_To_In.ssn		:= ssn_val;
	self.Bill_To_In.dob		:= dob_val;
	self.Bill_To_In.age 		:= if ((integer)dob_val != 0, (STRING3)ut.Age((integer)dob_val), '');
	self.Bill_To_In.dl_number := STD.Str.touppercase(dl_num_clean);
	self.Bill_To_In.dl_state := STD.Str.touppercase(le.drlcstate);
	self.Bill_To_In.email_address	:= le.emailaddr;
	self.Bill_To_In.phone10 := hphone_val;
	self.Bill_To_In.wphone10 := wphone_val;
	self.Bill_To_In.employer_name := STD.Str.touppercase(le.cmpy);	
	
	clean_a2 := Risk_Indicators.MOD_AddressClean.clean_addr(le.addr2, le.city2, le.state2, le.zip2);
	

	hphone_val2 := cleanPhone( le.phone2 );


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
	self.Ship_To_In.z5 := clean_a2[117..121];
	self.Ship_To_In.zip4 := clean_a2[122..125];
	self.Ship_To_In.lat := clean_a2[146..155];
	self.Ship_To_In.long := clean_a2[156..166];
	self.Ship_To_In.addr_type := clean_a2[139];
	self.Ship_To_In.addr_status := clean_a2[179..182];
	self.Ship_To_In.county := clean_a2[143..145];
	self.Ship_To_In.geo_blk := clean_a2[171..177];
	self.Ship_To_In.ssn		:= '';
	self.Ship_To_In.dob		:= '';
	self.Ship_To_In.age 		:= '';
	self.Ship_To_In.dl_number := '';
	self.Ship_To_In.dl_state := '';
	self.Ship_To_In.email_address	:= '';
	self.Ship_To_In.phone10 := hphone_val2;
	self.Ship_To_In.wphone10 := '';
	self.Ship_To_In.employer_name := STD.Str.touppercase(le.cmpy2);	
	self := [];
end;

prep := project(indata,into_btst_in(LEFT));

iid_results := risk_indicators.InstantId_BtSt_Function(prep,gateways,dppa,glb,isUtility,ln_branded, true, true, true, ofac_version := ofac_version, include_ofac := include_ofac, 
                                                       global_watchlist_threshold := global_watchlist_threshold,datarestriction:=datarestriction, datapermission:=datapermission,
                                                       LexIdSourceOptout := LexIdSourceOptout, 
                                                       TransactionID := TransactionID, 
                                                       BatchUID := BatchUID, 
                                                       GlobalCompanyID := GlobalCompanyID);

xlayout := record
	RiskWise.Layout_SS1O;
	dataset(Risk_Indicators.Layout_Desc) ris;
	unsigned4 seq;
	string4 tribcode := '';
	STRING10 addr1lat := '';
	STRING11 addr1long := '';
	STRING10 addr2lat := '';
	STRING11 addr2long := '';
end;

// populate SSIO fields with results from search 1, leave ship-to output fields empty
xlayout fill_output(iid_results le, indata rt) := transform
	self.seq := rt.seq;
	self.account := rt.account;
	self.tribcode := rt.tribcode;
	self.riskwiseid := (string)le.bill_to_output.did;  // for testing
	self.phonevalflag := if(le.bill_to_output.phonevalflag in ['1', '2', '3'], '', '1');  //1, 2 and 3 are valid phones
	self.phonezipflag := if(le.bill_to_output.phonezipflag = '1', '1', ''); 
	self.addrvalflag := if(le.bill_to_output.addrvalflag = 'N', '1', '');
	self.socsvalflag := if(le.bill_to_output.socsvalflag = '1', '1', ''); 
	self.socsdobflag := if(le.bill_to_output.socsdobflag = '1', '1', '');
	self.drlcvalflag := if(le.bill_to_output.drlcvalflag in ['1','3'], '1', '');
	self.areacodesplitflag := map(le.bill_to_output.areacodesplitflag='Y' => '1',
							le.bill_to_output.reverse_areacodesplitflag='Y' => '2',
							'');
	self.altareacode := if(le.bill_to_output.areacodesplitflag='Y' or le.bill_to_output.reverse_areacodesplitflag='Y', le.bill_to_output.altareacode, '');
	self.phonemiskeyflag := if(le.bill_to_output.hphonemiskeyflag, '1', '');
	self.socsmiskeyflag := if(le.bill_to_output.socsmiskeyflag, '1', '');
	self.lastcount := if(le.bill_to_output.combo_lastcount>0, '1', '');
	self.phonecount := if(le.bill_to_output.combo_hphonecount>0, '1', '');
	self.addrcount := if(le.bill_to_output.combo_addrcount>0, '1', '');
	self.socscount := if(le.bill_to_output.combo_ssncount>0, '1', '');
	self.dobcount := if(le.bill_to_output.combo_dobcount>0, '1', '');
	self.phonetypeflag := if(le.bill_to_output.phonever_type in ['1','2','3','5','9','A'] and rt.hphone != '', '1', '');
	self.hriskaddrflag := if(le.bill_to_output.hriskaddrflag = '4', '1', '');
	self.ziptypeflag := if(le.bill_to_output.zipclass in ['P','M','U'], '1', '');
	self.decsflag := if(le.bill_to_output.decsflag = '1', '1', '');
	self.phonedissflag := if(le.bill_to_output.phonedissflag, '1','');
	self.coaalertflag := if(le.bill_to_output.coaalertflag, '1', '');
	self.bansflag := map(le.bill_to_output.bansflag='1' => '1',
					 le.bill_to_output.bansflag='2' => '2',
					 '');
     self.dwelltypeflag := le.bill_to_output.dwelltype;
	self.numelever := (string)(if(self.lastcount>'0',1,0)+if(self.addrcount>'0',1,0)+if(self.socscount>'0',1,0)+if(self.phonecount>'0',1,0)+if(self.dobcount>'0',1,0));	
	self.ris := if(rt.tribcode in ['fdsl', 'fds7'], (riskwise.fdReasonCodes(le.bill_to_output, 4, true)), (DATASET([],risk_indicators.Layout_Desc)));  // get reaoncodes for only fdsl and fds7
	self.reason := if(self.ris[1].hri='00', '', (string)(integer)self.ris[1].hri); 
	self.reason2 := if(self.ris[2].hri='00', '', (string)(integer)self.ris[2].hri);
	self.reason3 := if(self.ris[3].hri='00', '', (string)(integer)self.ris[3].hri);
	self.reason4 := if(self.ris[4].hri='00', '', (string)(integer)self.ris[4].hri);
	
	self.verphone := IF(le.bill_to_output.combo_hphonecount>0 and le.bill_to_output.combo_hphone != rt.hphone, le.bill_to_output.combo_hphone, '');
	self.versocs := IF(le.bill_to_output.combo_ssncount>0 and le.bill_to_output.combo_ssnscore between 90 and 99, le.bill_to_output.combo_ssn,'');
	self.veraddr := IF(le.bill_to_output.combo_addrcount>0, Risk_Indicators.MOD_AddressClean.street_address('',le.bill_to_output.combo_prim_range,
										le.bill_to_output.combo_predir,le.bill_to_output.combo_prim_name,le.bill_to_output.combo_suffix,le.bill_to_output.combo_postdir,le.bill_to_output.combo_unit_desig,le.bill_to_output.combo_sec_range),'');
	self.vercity := IF(le.bill_to_output.combo_addrcount>0, le.bill_to_output.combo_city, '');
	self.verstate := IF(le.bill_to_output.combo_addrcount>0, le.bill_to_output.combo_state, '');
	self.verzip := IF(le.bill_to_output.combo_addrcount>0, le.bill_to_output.combo_zip, '');	
	self.coaaddr := Risk_Indicators.MOD_AddressClean.street_address('',le.bill_to_output.coaprim_range,le.bill_to_output.coapredir,le.bill_to_output.coaprim_name,le.bill_to_output.coasuffix,le.bill_to_output.coapostdir,le.bill_to_output.coaunit_desig,le.bill_to_output.coasec_range);
	self.coacity := le.bill_to_output.coacity;
	self.coastate := le.bill_to_output.coastate;
	self.coazip := le.bill_to_output.coazip;
	self.addr1lat := le.bill_to_output.lat;
	self.addr1long := le.bill_to_output.long;
	self.hriskcmpy := le.bill_to_output.hriskcmpy;
	self.hrisksic := le.bill_to_output.hrisksic;
	self.bansdatefiled := le.bill_to_output.bansdatefiled;
	self.disthphonewphone := if(le.bill_to_output.disthphonewphone=9999, '',(string)le.bill_to_output.disthphonewphone);
	
	self.phonevalflag2 := if(le.ship_to_output.phonevalflag in ['1', '2', '3'], '', '1');  //1, 2 and 3 are valid phones
     self.phonezipflag2 := if(le.ship_to_output.phonezipflag = '1', '1', '');
     self.addrvalflag2 := if(le.ship_to_output.addrvalflag = 'N', '1', '');
	self.areacodesplitflag2 := map(le.ship_to_output.areacodesplitflag='Y' => '1',
							le.ship_to_output.reverse_areacodesplitflag='Y' => '2',
							'');
	self.altareacode2 := if(le.ship_to_output.areacodesplitflag='Y' or le.ship_to_output.reverse_areacodesplitflag='Y', le.ship_to_output.altareacode, '');
     self.phonemiskeyflag2 := if(le.ship_to_output.hphonemiskeyflag, '1', '');
	self.lastcount2 := if(le.ship_to_output.combo_lastcount>0, '1', '');
     self.phonecount2 := if(le.ship_to_output.combo_hphonecount>0, '1', '');
     self.addrcount2 := if(le.ship_to_output.combo_addrcount>0, '1', '');
	self.phonetypeflag2 := if(le.ship_to_output.phonever_type in ['1','2','3','5','9','A'] and rt.phone2 != '', '1', '');
     self.hriskaddrflag2 := if(le.ship_to_output.hriskaddrflag = '4', '1', '');
     self.ziptypeflag2 := if(le.ship_to_output.zipclass in ['P','M','U'], '1', '');
     self.phonedissflag2 := if(le.ship_to_output.phonedissflag, '1','');
     self.coaalertflag2 := if(le.ship_to_output.coaalertflag, '1', '');
     self.dwelltypeflag2 := le.ship_to_output.dwelltype;
	self.numelever2 := (string)(if(self.lastcount2>'0',1,0)+if(self.addrcount2>'0',1,0)+if(self.phonecount2>'0',1,0));
	self.verphone2 := IF(le.ship_to_output.combo_hphonecount>0 and le.ship_to_output.combo_hphone != rt.phone2, le.ship_to_output.combo_hphone, '');
	self.veraddr2 := IF(le.ship_to_output.combo_addrcount>0, Risk_Indicators.MOD_AddressClean.street_address('',le.ship_to_output.combo_prim_range,
										le.ship_to_output.combo_predir,le.ship_to_output.combo_prim_name,le.ship_to_output.combo_suffix,le.ship_to_output.combo_postdir,le.ship_to_output.combo_unit_desig,le.ship_to_output.combo_sec_range),'');
	self.vercity2 := IF(le.ship_to_output.combo_addrcount>0, le.ship_to_output.combo_city, '');
	self.verstate2 := IF(le.ship_to_output.combo_addrcount>0, le.ship_to_output.combo_state, '');
	self.verzip2 := IF(le.ship_to_output.combo_addrcount>0, le.ship_to_output.combo_zip, '');
	self.coaaddr2 := Risk_Indicators.MOD_AddressClean.street_address('',le.ship_to_output.coaprim_range,le.ship_to_output.coapredir,le.ship_to_output.coaprim_name,le.ship_to_output.coasuffix,le.ship_to_output.coapostdir,le.ship_to_output.coaunit_desig,le.ship_to_output.coasec_range);
	self.coacity2 := le.ship_to_output.coacity;
	self.coastate2 := le.ship_to_output.coastate;
	self.coazip2 := le.ship_to_output.coazip;
	self.addr2lat := le.ship_to_output.lat;
	self.addr2long := le.ship_to_output.long;
	self.hriskcmpy2 := le.ship_to_output.hriskcmpy;
	self.hrisksic2 := le.ship_to_output.hrisksic;	
	self := [];
end;

mapped_results := join(iid_results, indata, left.bill_to_output.seq = (right.seq * 2), fill_output(left,right), left outer);
												// turned off dl and vehicle searching since that data isn't used in these models
getBS := Risk_Indicators.BocaShell_BtSt_Function(iid_results, gateways, dppa, glb, false, false, true, false, false, true,datarestriction:=datarestriction,datapermission:=datapermission,
                                                                                         LexIdSourceOptout := LexIdSourceOptout, 
                                                                                         TransactionID := TransactionID, 
                                                                                         BatchUID := BatchUID, 
                                                                                         GlobalCompanyID := GlobalCompanyID);	

withScore := MAP(tribCode = 'fds7' => Models.CDN605_1_0(getBS, false, true),
			  tribCode = 'fdsl' => Models.CDN605_1_0(getBS, false, false),
			  tribCode = 'ss02' => Models.CDN604_4_0(getBS, false),
			  dataset([],Models.Layout_ModelOut));
			  
		  
			  
RiskWise.Layout_SS1O format_output(mapped_results le, withScore ri) := transform
	self.account := le.account;
	self.riskwiseid := le.riskwiseid;
	self.phonevalflag := if(le.tribcode='ss02', le.phonevalflag, '');
	self.phonezipflag := if(le.tribcode='ss02', le.phonezipflag, '');	
	self.addrvalflag := if(le.tribcode='ss02', le.addrvalflag, '');	
	self.socsvalflag := if(le.tribcode='ss02', le.socsvalflag, '');	
	self.socsdobflag := if(le.tribcode='ss02', le.socsdobflag, '');	
	self.drlcvalflag := if(le.tribcode='ss02', le.drlcvalflag, '');	
	self.phonevalflag2 := if(le.tribcode='ss02', le.phonevalflag2, '');
     self.phonezipflag2 := if(le.tribcode='ss02', le.phonezipflag2, '');
     self.addrvalflag2 := if(le.tribcode='ss02', le.addrvalflag2, '');
	self.areacodesplitflag := if(le.tribcode='ss02', le.areacodesplitflag, '');	
	self.phonemiskeyflag := if(le.tribcode='ss02', le.phonemiskeyflag, '');	
	self.socsmiskeyflag := if(le.tribcode='ss02', le.socsmiskeyflag, '');
	self.areacodesplitflag2 := if(le.tribcode='ss02', le.areacodesplitflag2, '');
     self.phonemiskeyflag2 := if(le.tribcode='ss02', le.phonemiskeyflag2, '');
	self.lastcount := if(le.tribcode='ss02', le.lastcount, '');		
	self.phonecount := if(le.tribcode='ss02', le.phonecount ,'');	
	self.addrcount := if(le.tribcode='ss02', le.addrcount ,'');	
	self.socscount := if(le.tribcode='ss02', le.socscount ,'');	
	self.dobcount := if(le.tribcode='ss02', le.dobcount ,'');	
	self.lastcount2 := if(le.tribcode='ss02', le.lastcount2, '');
     self.phonecount2 := if(le.tribcode='ss02', le.phonecount2, '');
     self.addrcount2 := if(le.tribcode='ss02', le.addrcount2, '');
	self.phonetypeflag := if(le.tribcode='ss02', le.phonetypeflag ,'');			
	self.hriskaddrflag := if(le.tribcode='ss02', le.hriskaddrflag ,'');	
	self.ziptypeflag := if(le.tribcode='ss02', le.ziptypeflag ,'');		
	self.decsflag := if(le.tribcode='ss02', le.decsflag ,'');		
	self.phonedissflag := if(le.tribcode='ss02', le.phonedissflag ,'');	
	self.coaalertflag := if(le.tribcode='ss02', le.coaalertflag ,'');		
	self.bansflag := if(le.tribcode='ss02', le.bansflag ,'');		
	self.phonetypeflag2 := if(le.tribcode='ss02', le.phonetypeflag2, '');
     self.hriskaddrflag2 := if(le.tribcode='ss02', le.hriskaddrflag2, '');
     self.ziptypeflag2 := if(le.tribcode='ss02', le.ziptypeflag2, '');
     self.phonedissflag2 := if(le.tribcode='ss02', le.phonedissflag2, '');
     self.coaalertflag2 := if(le.tribcode='ss02', le.coaalertflag2, '');
     self.dwelltypeflag := if(le.tribcode='ss02', le.dwelltypeflag ,''); 	
	self.dwelltypeflag2 := if(le.tribcode='ss02', le.dwelltypeflag2, '');
	self.numelever := if(le.tribcode='ss02', le.numelever ,'');	
	self.numelever2 := if(le.tribcode='ss02', le.numelever2, '');
	self.altareacode := if(le.tribcode='ss02', le.altareacode ,'');	
	self.verphone := if(le.tribcode='ss02', le.verphone ,'');	
	self.versocs := if(le.tribcode='ss02', le.versocs ,'');		
	self.veraddr := if(le.tribcode='ss02', le.veraddr ,'');		
	self.vercity := if(le.tribcode='ss02', le.vercity ,'');		
	self.verstate := if(le.tribcode='ss02', le.verstate ,'');	
	self.verzip := if(le.tribcode='ss02', le.verzip ,'');		
	self.coaaddr := if(le.tribcode='ss02', le.coaaddr ,'');		
	self.coacity := if(le.tribcode='ss02', le.coacity ,'');		
	self.coastate := if(le.tribcode='ss02', le.coastate ,'');	
	self.coazip := if(le.tribcode='ss02', le.coazip ,'');		
	self.altareacode2 := if(le.tribcode='ss02', le.altareacode2, '');
	self.verphone2 := if(le.tribcode='ss02', le.verphone2, '');
	self.veraddr2 := if(le.tribcode='ss02', le.veraddr2, '');
	self.vercity2 := if(le.tribcode='ss02', le.vercity2, '');
	self.verstate2 := if(le.tribcode='ss02', le.verstate2, '');
	self.verzip2 := if(le.tribcode='ss02', le.verzip2, '');
	self.coaaddr2 := if(le.tribcode='ss02', le.coaaddr2, '');
	self.coacity2 := if(le.tribcode='ss02', le.coacity2, '');
	self.coastate2 := if(le.tribcode='ss02', le.coastate2, '');
	self.coazip2 := if(le.tribcode='ss02', le.coazip2, '');
	self.hriskcmpy := if(le.tribcode='ss02', le.hriskcmpy ,'');		
	self.hrisksic := if(le.tribcode='ss02', le.hrisksic ,'');		
	self.bansdatefiled := if(le.tribcode='ss02', le.bansdatefiled ,'');	
	self.hriskcmpy2 := if(le.tribcode='ss02', le.hriskcmpy2, '');
	self.hrisksic2 := if(le.tribcode='ss02', le.hrisksic2, '');		
	self.disthphonewphone := if(le.tribcode='ss02', if((integer)le.disthphonewphone=0, '', le.disthphonewphone),''); 	
	
	// fields calculated on results from both of the datasets
	billToFraudCount := if(le.phonevalflag='',0,1)+if(le.phonezipflag='',0,1)+if(le.addrvalflag='',0,1)+if(le.socsvalflag='',0,1)+if(le.socsdobflag='',0,1)+if(le.drlcvalflag='',0,1)
				+if(le.phonetypeflag='',0,1)+if(le.hriskaddrflag='',0,1)+if(le.ziptypeflag='',0,1)+if(le.decsflag='',0,1)+if(le.phonedissflag='',0,1)+if(le.coaalertflag='',0,1)+if(le.bansflag='',0,1);
	shipToFraudCount := if(le.phonevalflag2='',0,1)+if(le.phonezipflag2='',0,1)+if(le.addrvalflag2='',0,1)+if(le.phonetypeflag2='',0,1)
					+if(le.hriskaddrflag2='',0,1)+if(le.ziptypeflag2='',0,1)+if(le.phonedissflag2='',0,1)+if(le.coaalertflag2='',0,1);					
	self.numfraud := if(le.tribcode='ss02', (string)(billToFraudCount+shipToFraudCount), '');	
	self.distaddraddr2 := if ((le.addr1lat!='' and le.addr2lat!='') and le.tribcode='ss02', (string)round(ut.ll_dist((REAL)le.addr1Lat,(REAL)le.addr1Long,(REAL)le.addr2Lat,(REAL)le.addr2Long)), '');

	self.score := if(le.tribcode='ss02', ri.score, '');  
	self.score2 := if(le.tribcode in ['fdsl', 'fds7'], ri.score[2..3] , '');		
	self.reason := if(le.tribcode in ['fdsl', 'fds7'], le.reason , ''); 		
	self.reason2 := if(le.tribcode in ['fdsl', 'fds7'], le.reason2 , '');		
	self.reason3 := if(le.tribcode in ['fdsl', 'fds7'], le.reason3 , '');		
	self.reason4 := if(le.tribcode in ['fdsl', 'fds7'], le.reason4 , '');
		
	self := [];
end;

final := join(mapped_results, withScore, (left.seq*2) = right.seq, format_output(left, right), left outer);

return final;

end;
