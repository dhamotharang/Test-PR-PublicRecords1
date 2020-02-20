import Risk_Indicators, Models, Business_Risk, gateway, STD, Riskwise;

export CDxO_Function(DATASET(Layout_CD2I) indata, 
										 dataset(Gateway.Layouts.Config) gateways, 
										 unsigned1 glb, 
										 unsigned1 dppa,  
										 string4 tribcode,
                     unsigned1 ofac_version = 1,
                     boolean include_ofac = false,
                     real global_watchlist_threshold = 0.84,
										 string50 DataRestriction=risk_indicators.iid_constants.default_DataRestriction,
										 string50 DataPermission=risk_indicators.iid_constants.default_DataPermission,
                     unsigned1 LexIdSourceOptout = 1,
                     string TransactionID = '',
                     string BatchUID = '',
                     unsigned6 GlobalCompanyId = 0) := 

FUNCTION

// ONLY FOR TRIBCODES nd03,nd04,nd05 and nd10 with ordtype <> 0 (nd10 calls the business version), and nd11 mirrored off nd10 with a different model.

Risk_Indicators.Layout_CIID_BtSt_In into_btst_in(indata le) := TRANSFORM
	// Clean BillTo
  clean_a := Risk_Indicators.MOD_AddressClean.clean_addr(le.addr, le.city, le.state, le.zip);	
	
	hphone_val := RiskWise.cleanPhone( le.hphone );
	wphone_val := RiskWise.cleanPhone( le.wphone );
	dl_num_clean := RiskWise.cleanDL_num( le.drlc );
	
	
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
	self.Bill_To_In.zip4 := clean_a[122..125];	// use the input zip if cass zip is empty
	self.Bill_To_In.lat := clean_a[146..155];
	self.Bill_To_In.long := clean_a[156..166];
	self.Bill_To_In.addr_type := clean_a[139];
	self.Bill_To_In.addr_status := clean_a[179..182];
	self.Bill_To_In.county := clean_a[143..145];
	self.Bill_To_In.geo_blk := clean_a[171..177];
	self.Bill_To_In.dl_number := STD.Str.touppercase(dl_num_clean);
	self.Bill_To_In.dl_state := STD.Str.touppercase(le.drlcstate);
	self.Bill_To_In.email_address	:= le.email;
	self.Bill_To_In.phone10 := hphone_val;
	self.Bill_To_In.wphone10 := wphone_val;
	self.Bill_To_In.employer_name := STD.Str.touppercase(le.cmpy);
	self.bill_to_in.ip_address := le.ipaddr;
	
	// Clean ShipTo
  clean_a2 := Risk_Indicators.MOD_AddressClean.clean_addr(le.addr2, le.city2, le.state2, le.zip2);	
	
	hphone_val2 := RiskWise.cleanPhone( le.hphone2 );
	
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
	self.Ship_To_In.z5 := if(clean_a2[117..121]<>'', clean_a2[117..121], le.zip2[1..5]);		// use the input zip if cass zip is empty
	self.Ship_To_In.zip4 := clean_a2[122..125];	// use the input zip if cass zip is empty
	self.Ship_To_In.lat := clean_a2[146..155];
	self.Ship_To_In.long := clean_a2[156..166];
	self.Ship_To_In.addr_type := clean_a2[139];
	self.Ship_To_In.addr_status := clean_a2[179..182];
	self.Ship_To_In.county := clean_a2[143..145];
	self.Ship_To_In.geo_blk := clean_a2[171..177];
	self.Ship_To_In.phone10 := hphone_val2;
	self.Ship_To_In.employer_name := STD.Str.touppercase(le.cmpy2);	
	self := [];
END;
prep := project(indata,into_btst_in(LEFT));

BS3_tribs						:= ['nd05','nd06', 'nd10'];
BSversion           := map(tribcode='nd11' => 51,
													 tribcode in BS3_tribs => 2,
													 1);
                          
iid_results := risk_indicators.InstantId_BtSt_Function(prep, gateways, dppa, glb, false, false, true, true, true, ofac_version := ofac_version, include_ofac := include_ofac, 
                                                       global_watchlist_threshold := global_watchlist_threshold, bsversion:=bsversion,DataRestriction := DataRestriction,
                                                       DataPermission := DataPermission,
                                                       LexIdSourceOptout := LexIdSourceOptout, 
                                                       TransactionID := TransactionID, 
                                                       BatchUID := BatchUID, 
                                                       GlobalCompanyID := GlobalCompanyID);

// intermediate results
working_layout := RECORD
	Layout_CD2I input;
	Layout_CDxO;
	unsigned4 seq;
END;



working_layout fill_output(iid_results le, indata ri) := TRANSFORM
	self.seq := ri.seq;
	self.account := ri.account;
	self.riskwiseid := (string)le.bill_to_output.did;
	
	// first input (bill to)
	self.verfirst := le.bill_to_output.combo_first;
	self.verlast := le.bill_to_output.combo_last;
	self.veraddr := Risk_Indicators.MOD_AddressClean.street_address('',le.bill_to_output.combo_prim_range,le.bill_to_output.combo_predir,
									    le.bill_to_output.combo_prim_name,le.bill_to_output.combo_suffix,
									    le.bill_to_output.combo_postdir,le.bill_to_output.combo_unit_desig,
									    le.bill_to_output.combo_sec_range);
	self.vercity := le.bill_to_output.combo_city;
	self.verstate := le.bill_to_output.combo_state;
	self.verszip := le.bill_to_output.combo_zip;
	self.nameaddrphone := le.bill_to_output.name_addr_phone;
	
	self.phoneverlevel := (string)le.bill_to_output.phoneverlevel;
	
	self.correctlast := le.bill_to_output.correctlast;
	self.correcthphone := le.bill_to_output.correcthphone;
	self.correctaddr := le.bill_to_output.correctaddr;
		
	self.altareacode := if(tribcode in ['nd03','nd04','nd05','nd06'] and le.bill_to_output.areacodesplitflag = 'Y', le.bill_to_output.altareacode, '');
	self.areacodesplitdate := if(tribcode in ['nd03','nd04','nd05','nd06'] and le.bill_to_output.areacodesplitflag = 'Y', le.bill_to_output.areacodesplitdate, '');
	
	self.hphonetypeflag := if(tribcode in ['nd03','nd04','nd05','nd06'] and ri.hphone = '', 'B', le.bill_to_output.hphonetypeflag);
	self.wphonetypeflag := if(tribcode in ['nd03','nd04','nd05','nd06'] and ri.wphone = '', 'B', le.bill_to_output.wphonetypeflag);
	self.dwelltypeflag := le.bill_to_output.dwelltype;
		
	// second input (ship to)
	self.verfirst2 := le.ship_to_output.combo_first;
	self.verlast2 := le.ship_to_output.combo_last;
	self.veraddr2 := Risk_Indicators.MOD_AddressClean.street_address('',le.ship_to_output.combo_prim_range,le.ship_to_output.combo_predir,
										le.ship_to_output.combo_prim_name,le.ship_to_output.combo_suffix,
										le.ship_to_output.combo_postdir,le.ship_to_output.combo_unit_desig,
										le.ship_to_output.combo_sec_range);
	self.vercity2 := le.ship_to_output.combo_city;
	self.verstate2 := le.ship_to_output.combo_state;
	self.verszip2 := le.ship_to_output.combo_zip;
	self.nameaddrphone2 := le.ship_to_output.name_addr_phone;
	
	self.phoneverlevel2 := (string)le.ship_to_output.phoneverlevel;
	
	self.correctlast2 := le.ship_to_output.correctlast;
	self.correchphone2 := le.ship_to_output.correcthphone;
	self.correctaddr2 := le.ship_to_output.correctaddr;
		
	self.altareacode2 := if(tribcode in ['nd03','nd04','nd05','nd06'] and le.ship_to_output.areacodesplitflag = 'Y', le.ship_to_output.altareacode, '');
	self.areacodesplitdate2 := if(tribcode in ['nd03','nd04','nd05','nd06'] and le.ship_to_output.areacodesplitflag = 'Y', le.ship_to_output.areacodesplitdate, '');
	
	self.hphonetypeflag2 := if(tribcode in ['nd03','nd04','nd05','nd06'] and ri.hphone2 = '', 'B', le.ship_to_output.hphonetypeflag);
	self.wphonetypeflag2 := if(tribcode in ['nd03','nd04','nd05','nd06'], 'B', '');
	self.dwelltypeflag2 := le.ship_to_output.dwelltype;
	ip := trim(ri.ipaddr);
	self.billing := if(STD.Str.FilterOut(ip[1],'0123456789')='' and ip<>'' and tribcode in ['nd10','nd11'], 
					dataset([{'na99',1}], risk_indicators.Layout_Billing),
					dataset([],risk_indicators.Layout_Billing));
	self.input := ri;
	
	self := [];
END;
mapped_results := JOIN(iid_results, indata, left.bill_to_output.seq = (right.seq * 2), fill_output(left,right), left outer);

											// turned off dl, vehicle and derogs because cdn606_1_0 doesn't use that data

includeRelativeInfo := (tribcode not in ['nd05','nd06']);
includeDLInfo       := false;
includeVehInfo      := false;
includeDerogInfo    := if(tribcode='nd11', true, false);

getBS := Risk_Indicators.BocaShell_BtSt_Function(iid_results, gateways, dppa, glb, false, false, includeRelativeInfo, includeDLInfo, includeVehInfo, includeDerogInfo, bsversion,
                                                                                          DataRestriction := DataRestriction,DataPermission := DataPermission,
                                                                                          LexIdSourceOptout := LexIdSourceOptout, 
                                                                                          TransactionID := TransactionID, 
                                                                                          BatchUID := BatchUID, 
                                                                                          GlobalCompanyID := GlobalCompanyID);	


working_layout addIP(mapped_results le, getBS ri) := TRANSFORM
	override := map(( (integer)ri.eddo.firstscore between 80 and 100 ) and ( (integer)ri.eddo.lastscore between 80 and 100 ) and (integer)ri.eddo.addrscore < 80 and STD.Str.ToUpperCase(le.input.pymtmethod) <> 'B' and 
					STD.Str.ToUpperCase(le.input.shipmode) <> 'R' and le.input.shipmode <> '' and STD.Str.ToUpperCase(le.input.avscode) = 'Y' and 
					(real)le.input.orderamt > 95 and ri.bill_to_out.iid.combo_addrcount = 0 and le.phoneverlevel2 in ['1','2','3','4','5','8','12'] and 
					STD.Str.ToUpperCase(ri.ip2o.countrycode[1..2]) = 'US' and tribcode in ['nd03','nd04','nd05','nd06'] => '01',
				 STD.Str.ToUpperCase(ri.ip2o.countrycode[1..2]) = 'US'
				     and ri.Bill_To_Out.shell_input.fname <> ri.Ship_To_Out.shell_input.fname
				     and ri.Bill_To_Out.shell_input.lname <> ri.Ship_To_Out.shell_input.lname
				     and ( (integer)ri.eddo.addrscore between 80 and 100 )
				     and STD.Str.ToUpperCase(le.input.pymtmethod) <> 'B' and
					STD.Str.ToUpperCase(le.input.shipmode) <> 'R' and le.input.shipmode <> '' and tribcode in ['nd03','nd04','nd05','nd06'] => '02',
				 STD.Str.ToUpperCase(ri.ip2o.countrycode[1..2]) = 'US' // US IP
					and le.input.shipmode = '' // instore pickup order
					and le.input.channel = '01' // internet order
					and ri.ip2o.state != '' // IP state not missing
					and STD.Str.ToUpperCase(ri.ip2o.state) != 'AOL' // ip state not AOL
					and STD.Str.ToUpperCase(ri.ip2o.state) != 'NO REGION' // ip state not 'NO REGION'
					and trim(ri.Bill_to_Out.shell_input.in_state) != '' // billing state not missing
					and STD.Str.ToUpperCase(trim(ri.Bill_to_Out.shell_input.in_state)) != STD.Str.ToUpperCase(trim(ri.ip2o.state)) // billing state differs from IP state
					and tribcode in ['nd03','nd04','nd05','nd06'] => '03',
				 '');				 

	self.ipcontinent := ri.ip2o.continent;
	self.ipcountry := if(override <> '', override, STD.Str.ToUpperCase(ri.ip2o.countrycode));
	self.iproutingtype := if(STD.Str.FilterOut(ri.ip2o.ipaddr[1],'0123456789') = '', ri.ip2o.iproutingmethod, '');
	self.ipstate := if(STD.Str.ToUpperCase(ri.ip2o.countrycode[1..2]) = 'US', STD.Str.ToUpperCase(ri.ip2o.state), '');
	self.ipzip:= if(STD.Str.ToUpperCase(ri.ip2o.countrycode[1..2]) = 'US' and tribcode in ['nd03','nd04','nd05','nd06'], ri.ip2o.zip, '');
	self.ipareacode := if(tribcode in ['nd03','nd04','nd05','nd06'] and ri.ip2o.areacode <> '0', ri.ip2o.areacode, '');	
	self.topleveldomain := if(tribcode in ['nd10','nd11'], STD.Str.ToUpperCase(ri.ip2o.topleveldomain), '');
     self.secondleveldomain := if(tribcode in ['nd10','nd11'], STD.Str.ToUpperCase(ri.ip2o.secondleveldomain), '');
	
	self := le;
END;
withIP := JOIN(mapped_results, getBS, (left.seq*2) = right.bill_to_out.seq, addIP(left,right), left outer);


getScore := map(
	tribcode in ['nd03','nd04'] => Models.CDN707_1_0(getBS, indata, true, false),
	tribcode  =  'nd05'					=> Models.CDN806_1_0(getBS, indata, true, false),
	tribcode  =  'nd06'					=> Models.CDN908_1_0(getBS, indata, true, false),
	tribcode  =  'nd11'				  => Models.CDN1508_1_0(getBS, indata, /* is not business */ false, dataset([],business_risk.layout_biid_btst_output)),
	tribcode  =  'nd10'				  => Models.CDN810_1_0(getBS, indata, true, /* is not business */ false, dataset([],business_risk.layout_biid_btst_output), iid_results, 1), // ND10 uses v1 reason codes
	Models.CDN606_2_0(getBs, indata, true, /* is not business */ false, dataset([],business_risk.layout_biid_btst_output) )
);

/* VALIDATION MODE - 'cdn1508' */
// validation_layout := RECORD 
	// recordOf(getScore);
	// string account;
// end;

	// /* output(getscore,named('getscore')); */
	// /* output(indata,named('indata')); */
// getScore_wCounter := join(getScore, indata, left.seq = right.seq, Transform(validation_layout, 
																															// self.account := right.account,
																															// self := left));

// return getScore_wCounter; // validation


/* PRODUCTION MODE */ 		
Layout_CDxO addBTmodel(withIP le, getScore ri) := TRANSFORM
	self.score := if(tribcode in ['nd10','nd11'], ri.score[1..3], ri.score);
	self.score2 := if(tribcode in ['nd10','nd11'], ri.score[4..6], '');
	self.score3 := if(tribcode in ['nd10','nd11'], ri.score[7..9], '');
	
	// special checks for nd10 and nd11
	outRC := tribcode='nd11' or (tribcode in ['nd10'] and ((integer)ri.score[1..3] <= 780 or (integer)ri.score[4..6] <= 750)) or tribcode in ['nd03','nd04','nd05','nd06'];
	self.reason := if(outRC, ri.ri[1].hri, '');
	self.reason2 := if(outRC, ri.ri[2].hri, '');
	self.reason3 := if(outRC, ri.ri[3].hri, '');
	self.reason4 := if(outRC, ri.ri[4].hri, '');
	self.reason5 := if(outRC, ri.ri[5].hri, '');
	self.reason6 := if(outRC, ri.ri[6].hri, '');
	
	outVdata := tribcode='nd11' or (tribcode in ['nd10'] and ((integer)ri.score[1..3] <= 750 or (integer)ri.score[4..6] <= 750)) or tribcode in ['nd03','nd04','nd05','nd06'];
	self.verfirst := if(outVdata, le.verfirst, '');
	self.verlast := if(outVdata, le.verlast, '');
	self.veraddr := if(outVdata, le.veraddr, '');
	self.vercity := if(outVdata, le.vercity, '');
	self.verstate := if(outVdata, le.verstate, '');
	self.verszip := if(outVdata, le.verszip, '');
	self.nameaddrphone := if(outVdata, le.nameaddrphone, '');
	
	outVdata2 := tribcode='nd11' or (tribcode in ['nd10'] and ((integer)ri.score[1..3] <= 780 or (integer)ri.score[7..9] <= 750)) or tribcode in ['nd03','nd04','nd05','nd06'];
	self.verfirst2 := if(outVdata2, le.verfirst2, '');
	self.verlast2 := if(outVdata2, le.verlast2, '');
	self.veraddr2 := if(outVdata2, le.veraddr2, '');
	self.vercity2 := if(outVdata2, le.vercity2, '');
	self.verstate2 := if(outVdata2, le.verstate2, '');
	self.verszip2 := if(outVdata2, le.verszip2, '');
	self.nameaddrphone2 := if(outVdata2, le.nameaddrphone2, '');
	self.reason7 := if(outVdata2, ri.ri[7].hri, '');
	self.reason8 := if(outVdata2, ri.ri[8].hri, '');
	self.reason9 := if(outVdata2, ri.ri[9].hri, '');
	self.reason10 := if(outVdata2, ri.ri[10].hri, '');
	self.reason11 := if(outVdata2, ri.ri[11].hri, '');
	self.reason12 := if(outVdata2, ri.ri[12].hri, '');
	
	self := le;
END;
withModel := JOIN(withIP, getScore, (left.seq*2) = right.seq, addBTmodel(left,right), left outer);

RETURN withModel;

END;