import ut, Risk_Indicators, Models, Business_Risk, easi, gateway, Royalty, STD;

export SD1O_Function(dataset(Layout_SD1I) indata, dataset(Gateway.Layouts.Config) gateways, unsigned1 glb, unsigned1 dppa,  
																					string4 tribCode, 
                                          unsigned1 ofac_version = 1,
                                          boolean include_ofac = false,
                                          boolean include_additional_watchlists = false,
                                          real global_watchlist_threshold = 0.84, 
                                          string50 DataRestriction=risk_indicators.iid_constants.default_DataRestriction,
                                          string50 DataPermission=risk_indicators.iid_constants.default_DataPermission,
                                          unsigned1 LexIdSourceOptout = 1,
                                          string TransactionID = '',
                                          string BatchUID = '',
                                          unsigned6 GlobalCompanyId = 0
                                          ) := FUNCTION

Risk_Indicators.Layout_CIID_BtSt_In into_btst_in(indata le) := TRANSFORM
	// Clean BillTo
	clean_a := risk_indicators.MOD_AddressClean.clean_addr(le.addr, le.city, le.state, le.zip) ;	

	ssn_val := cleanSSN( le.socs );
	hphone_val := cleanPhone( le.hphone );
	wphone_val := cleanPhone( le.wphone );
	dob_val := cleanDOB(le.dob);
	dl_num_clean := cleanDL_num( le.drlc );

	
	self.Bill_To_In.seq := le.seq;
	self.Bill_To_In.historydate:= le.historydate;
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
	dob_val2 := cleanDOB(le.dob2);
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
END;
prep := project(indata,into_btst_in(LEFT));

iid_results := risk_indicators.InstantId_BtSt_Function(prep, gateways, dppa, glb, false, false, true, false, true, false, 
																											 false, false, false, ofac_version, include_ofac, include_additional_watchlists, 
                                                       global_watchlist_threshold, 1, 1, DataRestriction, false, DataPermission,
                                                       LexIdSourceOptout := LexIdSourceOptout, 
                                                       TransactionID := TransactionID, 
                                                       BatchUID := BatchUID, 
                                                       GlobalCompanyID := GlobalCompanyID);

risk_indicators.layout_output mkOutput( risk_indicators.layout_ciid_btst_Output le, UNSIGNED bt ) := TRANSFORM
	self := if( bt = 1, le.Bill_To_Output, le.Ship_To_Output );
END;

easi_census_bt := ungroup(join( project( iid_results, mkOutput(left, 1) ), Easi.Key_Easi_Census,
		keyed(right.geolink=left.st+left.county+left.geo_blk) /*and tribcode='it60'*/,
		transform(easi.layout_census, 
					self.state:= left.st,
					self.county:=left.county,
					self.tract:=left.geo_blk[1..6],
					self.blkgrp:=left.geo_blk[7],
					self.geo_blk:=left.geo_blk,
					self := right)));

easi_census_st := ungroup(join( project( iid_results, mkOutput(left, 2) ), Easi.Key_Easi_Census,
		keyed(right.geolink=left.st+left.county+left.geo_blk) /*and tribcode='it60'*/,
		transform(easi.layout_census, 
					self.state:= left.st,
					self.county:=left.county,
					self.tract:=left.geo_blk[1..6],
					self.blkgrp:=left.geo_blk[7],
					self.geo_blk:=left.geo_blk,
					self := right)));


// intermediate results
working_layout := RECORD
	RiskWise.Layout_SD1O;
	dataset(Risk_Indicators.Layout_Desc) ri;
	dataset(Risk_Indicators.Layout_Desc) ri2;
	dataset(Risk_Indicators.Layout_Desc) ri4;
	unsigned4 seq;
	boolean doOutput;
	boolean doOutput2; 
	string in_phone10 := '';
	string in_state := '';
	string telco_zip5 := '';
	boolean phone_state_mismatch := false;
	boolean shipto_score97 := false;
	boolean shipto_score99 := false;
	string apptypeflag := '';
	string apptypeflag2 := '';
	RiskWise.Layout_for_Royalties;
END;



HRCUTOFF := map(tribCode = 'ex06' => 10,
			 tribCode = 'ex07' => 20,
			 tribCode = 'ex08' => 30,
			 tribCode = 'ex09' => 40,
			 tribcode = '2x08' => 50,
			 tribcode = '2x10' => 90,
			 50);
			 
unsigned2 getSocsLevel(unsigned1 level) := map(level in [0,2,3,5,8] => 0,
									  level = 1 => 1,
									  level = 4 => 2,
									  level = 6 => 3,
									  level = 7 => 4,
									  level-4);	// 9,10,11,12 results in 5,6,7,8


working_layout fill_output(iid_results le, indata ri) := TRANSFORM
	self.doOutput := if(ri.first='' and ri.last='' and ri.addr='' and ri.socs='' and ri.dob='' and ri.hphone='' and ri.wphone='', if(tribcode in ['cb61','cb62'], true, false), true);
	self.doOutput2 := if(ri.first2='' and ri.last2='' and ri.addr2='' and ri.socs2='' and ri.dob2='' and ri.hphone2='' and ri.wphone2='', if(tribcode in ['cb61','cb62'], true, false), true);
							
	self.seq := ri.seq;
	self.account := ri.account;
	self.acctno := ri.acctno;
	self.riskwiseid := (string)le.bill_to_output.did;
	
	veraddr := Risk_Indicators.MOD_AddressClean.street_address('',le.bill_to_output.combo_prim_range,le.bill_to_output.combo_predir,le.bill_to_output.combo_prim_name,le.bill_to_output.combo_suffix,
								    le.bill_to_output.combo_postdir,le.bill_to_output.combo_unit_desig,le.bill_to_output.combo_sec_range);
	
	
	self.score := if(tribCode = 'ex70', Risk_Indicators.cviScore(le.bill_to_output.phoneverlevel,le.bill_to_output.socsverlevel,le.bill_to_output,'',veraddr,le.bill_to_output.combo_last,true), '');
	
	numByte := if(tribCode = 'sd01', 1, 2);	// sd01 formats the count to 1 byte, the others are 2 bytes
	self.firstcount := if(ri.first <> '' and tribCode in ['sd01','ex02','ex03','ex22','ex70','cb61','cb62'], RiskWise.flattenCount(le.bill_to_output.combo_firstcount,2,numByte), '');
	self.lastcount := if(ri.last <> '' and tribCode in ['sd01','ex02','ex03','ex22','ex70','cb61','cb62'], RiskWise.flattenCount(le.bill_to_output.combo_lastcount,2,numByte), '');
	self.cmpycount := if(ri.cmpy <> ''  and tribCode in ['sd01','ex02','ex03','ex22','cb61','cb62'], RiskWise.flattenCount(le.bill_to_output.combo_cmpycount,2,numByte), '');
	self.addrcount := if(ri.addr <> '' and tribCode in ['sd01','ex02','ex03','ex22','ex70','cb61','cb62'], RiskWise.flattenCount(le.bill_to_output.combo_addrcount,2,numByte), '');
	self.socscount := if(ri.socs <> '' and tribCode in ['sd01','ex03','ex22','ex70'], RiskWise.flattenCount(le.bill_to_output.combo_ssncount,2,numByte), '');
	self.hphonecount := if(ri.hphone <> '' and tribCode in ['sd01','ex02','ex03','ex22','ex70','cb61','cb62'], RiskWise.flattenCount(le.bill_to_output.combo_hphonecount,2,numByte), '');
	self.wphonecount := if(ri.wphone <> '' and tribCode in ['sd01','ex02','ex03','ex22'], RiskWise.flattenCount(le.bill_to_output.combo_wphonecount,2,numByte), '');
	self.dobcount := if(ri.dob <> '' and tribCode in ['sd01','ex02','ex03','ex22','ex70'], RiskWise.flattenCount(le.bill_to_output.combo_dobcount,2,numByte), '');
	
	
	self.socsverlvl := if(tribCode in ['sd01','ex03','ex22','ex70'], intformat(getSocsLevel(le.bill_to_output.socsverlevel),numByte,1), '');
	
	self.numelever := map(tribCode in ['sd01','ex03','ex22','ex70'] => intformat(le.bill_to_output.numelever,numByte,1),
					  tribCode in ['ex02'] => intformat((le.bill_to_output.numelever - (integer)(boolean)le.bill_to_output.combo_ssncount),2,1),
					  tribCode in ['cb61','cb62'] => intformat( ((integer)(boolean)le.bill_to_output.combo_firstcount)+((integer)(boolean)le.bill_to_output.combo_lastcount)+
														((integer)(boolean)le.bill_to_output.combo_cmpycount)+((integer)(boolean)le.bill_to_output.combo_addrcount)+
														((integer)(boolean)le.bill_to_output.combo_hphonecount),2,1),
					  '');
	self.numsource := map(tribCode = 'sd01' => RiskWise.flattenCount((integer)self.firstcount+(integer)self.lastcount+(integer)self.cmpycount+(integer)self.addrcount+
														(integer)self.hphonecount+(integer)self.wphonecount+(integer)self.socscount+(integer)self.dobcount,9,1),
					  tribCode in ['ex03','ex22','ex70'] => intformat((integer)self.firstcount+(integer)self.lastcount+(integer)self.cmpycount+(integer)self.addrcount+
															(integer)self.hphonecount+(integer)self.wphonecount+(integer)self.socscount+(integer)self.dobcount,numByte,1),
				       tribCode in ['ex02'] => intformat((integer)self.firstcount+(integer)self.lastcount+(integer)self.cmpycount+(integer)self.addrcount+
					    						      (integer)self.hphonecount+(integer)self.wphonecount+(integer)self.dobcount,numByte,1),
					  tribCode in ['cb61','cb62'] => intformat((integer)self.firstcount+(integer)self.lastcount+(integer)self.cmpycount+(integer)self.addrcount+
													   (integer)self.hphonecount,numByte,1),
				       '');
	
	self.verfirst := if(tribCode in ['sd01','ex02','ex03','ex22','ex70','cb61','cb62'], le.bill_to_output.combo_first, '');
	self.verlast := if(tribCode in ['sd01','ex02','ex03','ex22','ex70','cb61','cb62'], le.bill_to_output.combo_last, '');
	self.vercmpy := if(tribCode in ['sd01','ex02','ex03','ex22','cb61','cb62'], le.bill_to_output.combo_cmpy, '');
	self.veraddr := if(tribCode in ['sd01','ex02','ex03','ex22','ex70','cb61','cb62'], Risk_Indicators.MOD_AddressClean.street_address('',le.bill_to_output.combo_prim_range,le.bill_to_output.combo_predir,
																					le.bill_to_output.combo_prim_name,le.bill_to_output.combo_suffix,
																					le.bill_to_output.combo_postdir,le.bill_to_output.combo_unit_desig,
																					le.bill_to_output.combo_sec_range), '');
	self.vercity := if(tribCode in ['sd01','ex02','ex03','ex22','ex70','cb61','cb62'], le.bill_to_output.combo_city, '');
	self.verstate := if(tribCode in ['sd01','ex02','ex03','ex22','ex70','cb61','cb62'], le.bill_to_output.combo_state, '');
	SElF.verzip := if(tribCode in ['sd01','ex02','ex03','ex22','ex70','cb61','cb62'], le.bill_to_output.combo_zip, '');
	self.versocs := if(le.bill_to_output.combo_ssncount > 0, if(tribCode in ['sd01','ex03','ex22','ex70'], le.bill_to_output.combo_ssn, ''), '');
	self.verdob := if(tribCode in ['sd01','ex02','ex03','ex22','ex70'], le.bill_to_output.combo_dob, '');
	self.verhphone := if(tribCode in ['sd01','ex02','ex03','ex22','ex70','cb61','cb62'], le.bill_to_output.combo_hphone, '');
	self.verwphone := if(tribCode in ['sd01','ex02','ex03','ex22'], le.bill_to_output.combo_wphone, '');

	// SPECIAL CASE FOR EX22
	//self.score3 := if(tribCode = 'ex22' and self.inCalif, '000','');	need to put back in if ex22 is going to be migrated
	
	
	// Second Input data
	self.firstcount2 := if(ri.first2 <> '' and tribCode in ['sd01','ex02','ex03','cb61','cb62'], RiskWise.flattenCount(le.ship_to_output.combo_firstcount,2,numByte), '');
	self.lastcount2 := if(ri.last2 <> '' and tribCode in ['sd01','ex02','ex03','cb61','cb62'], RiskWise.flattenCount(le.ship_to_output.combo_lastcount,2,numByte), '');
	self.cmpycount2 := if(ri.cmpy2 <> '' and tribCode in ['sd01','ex02','ex03','cb61','cb62'], RiskWise.flattenCount(le.ship_to_output.combo_cmpycount,2,numByte), '');
	self.addrcount2 := if(ri.addr2 <> '' and tribCode in ['sd01','ex02','ex03','cb61','cb62'], RiskWise.flattenCount(le.ship_to_output.combo_addrcount,2,numByte), '');
	self.socscount2 := if(ri.socs2 <> '' and tribCode in ['sd01','ex03'], RiskWise.flattenCount(le.ship_to_output.combo_ssncount,2,numByte), '');
	self.hphonecount2 := if(ri.hphone2 <> '' and tribCode in ['sd01','ex02','ex03','cb61','cb62'], RiskWise.flattenCount(le.ship_to_output.combo_hphonecount,2,numByte), '');
	self.wphonecount2 := if(ri.wphone2 <> '' and tribCode in ['sd01','ex02','ex03'], RiskWise.flattenCount(le.ship_to_output.combo_wphonecount,2,numByte), '');
	self.dobcount2 := if(ri.dob2 <> '' and tribCode in ['sd01','ex02','ex03'], RiskWise.flattenCount(le.ship_to_output.combo_dobcount,2,numByte), '');
		
	self.socsverlvl2 := if(tribCode in ['sd01','ex03'], intformat(getSocsLevel(le.ship_to_output.socsverlevel),numByte,1), '');
	
	self.numelever2 := map(tribCode in ['sd01','ex03'] => intformat(le.ship_to_output.numelever,numByte,1),
					   tribCode in ['ex02'] => intformat((le.ship_to_output.numelever - (integer)(boolean)le.ship_to_output.combo_ssncount),2,1),
					   tribCode in ['cb61','cb62'] => intformat(((integer)(boolean)le.ship_to_output.combo_firstcount)+((integer)(boolean)le.ship_to_output.combo_lastcount)+
														((integer)(boolean)le.ship_to_output.combo_cmpycount)+((integer)(boolean)le.ship_to_output.combo_addrcount)+
														((integer)(boolean)le.ship_to_output.combo_hphonecount),2,1),
					   '');
	self.numsource2 := map(tribCode = 'sd01' => RiskWise.flattenCount((integer)self.firstcount2+(integer)self.lastcount2+(integer)self.cmpycount2+(integer)self.addrcount2+
														 (integer)self.hphonecount2+(integer)self.wphonecount2+(integer)self.socscount2+(integer)self.dobcount2,9,1),
					   tribCode in ['ex03'] => intformat((integer)self.firstcount2+(integer)self.lastcount2+(integer)self.cmpycount2+(integer)self.addrcount2+
												  (integer)self.hphonecount2+(integer)self.wphonecount2+(integer)self.socscount2+(integer)self.dobcount2,2,1),
					   tribCode in ['ex02'] => intformat((integer)self.firstcount2+(integer)self.lastcount2+(integer)self.cmpycount2+(integer)self.addrcount2+
											       (integer)self.hphonecount2+(integer)self.wphonecount2+(integer)self.dobcount2,numByte,1),
					   tribCode in ['cb61','cb62'] => intformat((integer)self.firstcount2+(integer)self.lastcount2+(integer)self.cmpycount2+(integer)self.addrcount2+
													    (integer)self.hphonecount2,numByte,1),
					   '');
	
	self.verfirst2 := if(tribCode in ['sd01','ex02','ex03','cb61','cb62'], le.ship_to_output.combo_first, '');
	self.verlast2 := if(tribCode in ['sd01','ex02','ex03','cb61','cb62'], le.ship_to_output.combo_last, '');
	self.vercmpy2 := if(tribCode in ['sd01','ex02','ex03','cb61','cb62'], le.ship_to_output.combo_cmpy, '');
	self.veraddr2 := if(tribCode in ['sd01','ex02','ex03','cb61','cb62'], Risk_Indicators.MOD_AddressClean.street_address('',le.ship_to_output.combo_prim_range,le.ship_to_output.combo_predir,le.ship_to_output.combo_prim_name,
																		le.ship_to_output.combo_suffix,le.ship_to_output.combo_postdir,le.ship_to_output.combo_unit_desig,
																		le.ship_to_output.combo_sec_range), '');
	self.vercity2 := if(tribCode in ['sd01','ex02','ex03','cb61','cb62'], le.ship_to_output.combo_city, '');
	self.verstate2 := if(tribCode in ['sd01','ex02','ex03','cb61','cb62'], le.ship_to_output.combo_state, '');
	SElF.verzip2 := if(tribCode in ['sd01','ex02','ex03','cb61','cb62'], le.ship_to_output.combo_zip, '');
	self.versocs2 := if(le.ship_to_output.combo_ssncount > 0 and tribCode in ['sd01','ex03'], le.ship_to_output.combo_ssn, '');
	self.verdob2 := if(tribCode in ['sd01','ex02','ex03'], le.ship_to_output.combo_dob, '');
	self.verhphone2 := if(tribCode in ['sd01','ex02','ex03','cb61','cb62'], le.ship_to_output.combo_hphone, '');
	self.verwphone2 := if(tribCode in ['sd01','ex02','ex03'], le.ship_to_output.combo_wphone, '');
	
	self.in_phone10 := ri.hphone;
	self.in_state := ri.state;
	
	
	// check for PO box, Rural Route, HC, etc.
	ucAddr := trim( STD.Str.ToUpperCase( ri.addr2 ), LEFT );
	
	self.shipto_score97 := REGEXFIND( '^(P[\\s\\.]*O[\\.\\s]*)?B(OX)?[\\s\\d\\.#]*', ucAddr )  // po boxes (abbreviated)
		OR REGEXFIND( '^POST[\\s\\.]*OFFICE[\\.\\s]*BOX[\\s\\d\\.#]*', ucAddr )                // po boxes (spelled out)
		OR REGEXFIND( '^R[\\s\\.]*R[\\.\\s#\\d]*(PO)?\\s*BOX[\\s*\\d#]+', ucAddr )             // rural routes (abbreviated)
		OR REGEXFIND( '^RURAL[\\s\\.]*ROUTE[\\.\\s#\\d]*(PO)?\\s*BOX[\\s*\\d#]+', ucAddr )     // rural routes (spelled out)
		OR REGEXFIND( '^H[\\s\\.]*C[\\.\\s#\\d]*BOX[\\s\\d#]+', ucAddr )                       // hcs
		OR REGEXFIND( '^P[\\s\\.]*M[\\s\\.]*B[\\.\\s]*[\\s\\d\\.#]*', ucAddr )                 // private mail boxes
	;

	self.shipto_score99 := (ri.last2='' and ri.cmpy2='' and ri.addr2='') or (ri.last=ri.last2 and ri.cmpy=ri.cmpy2 and ri.addr=ri.addr2);
	self.apptypeflag := ri.apptypeflag;
	self.apptypeflag2 := ri.apptypeflag2;
	self.targusType := if(le.Bill_To_Output.TargusType <> '', le.Bill_To_Output.TargusType, le.Ship_To_Output.TargusType);
	self.src := if(le.Bill_To_Output.src <> '', le.Bill_To_Output.src, le.Ship_To_Output.src);
	self.TargusGatewayUsed := if(le.Bill_To_Output.TargusGatewayUsed, le.Bill_To_Output.TargusGatewayUsed, le.Ship_To_Output.TargusGatewayUsed);
	
	self := [];
END;
mapped_results := join(iid_results, indata, left.bill_to_output.seq = (right.seq * 2), fill_output(left,right), left outer);
iidRoyalties :=Royalty.RoyaltyTargus.GetOnlineRoyalties(mapped_results, src, TargusType, TRUE, FALSE, FALSE, TRUE);


// add reason codes
rcBTinput := PROJECT(iid_results, TRANSFORM(Risk_Indicators.Layout_Output, self := left.Bill_To_Output));


working_layout addRC(mapped_results le, rcBTinput ri) := TRANSFORM
	self.ri := if(tribCode = 'ex70', RiskWise.patriotReasonCodes(ri, 4, true), dataset([],Risk_Indicators.Layout_Desc));
	self.reason11 := if(tribCode = 'ex70', self.ri[1].hri, le.reason11);
	self.reason21 := if(tribCode = 'ex70', self.ri[2].hri, le.reason21);
	self.reason31 := if(tribCode = 'ex70', self.ri[3].hri, le.reason31);
	self.reason41 := if(tribCode = 'ex70', self.ri[4].hri, le.reason41);
					 
	self := le;
END;
withRC := join(mapped_results, rcBTinput, (left.seq*2) = right.seq, addRC(left, right), left outer);


working_layout addRC2(withRC le, rcBTinput ri) := TRANSFORM
	self.ri2 := map(tribCode in ['ex02'] => RiskWise.rawReasonCodes(ri, 4, true, false),	// no social population
			      tribCode in ['ex03','ex22'] => RiskWise.rawReasonCodes(ri, 4, true, true),	// social population
			      dataset([],Risk_Indicators.Layout_Desc));
	self.reason12 := if(tribCode in ['ex02','ex03','ex22'], self.ri2[1].hri, le.reason12);
	self.reason22 := if(tribCode in ['ex02','ex03','ex22'], self.ri2[2].hri, le.reason22);
	self.reason32 := if(tribCode in ['ex02','ex03','ex22'], self.ri2[3].hri, le.reason32);
	self.reason42 := if(tribCode in ['ex02','ex03','ex22'], self.ri2[4].hri, le.reason42);
	
	self := le;
END;
withRC2 := join(withRC, rcBTinput, (left.seq*2) = right.seq, addRC2(left, right), left outer);



// add reason codes ST
rcSTinput := PROJECT(iid_results, TRANSFORM(Risk_Indicators.Layout_Output, self := left.Ship_To_Output));


working_layout addRC4(withRC2 le, rcSTinput ri) := TRANSFORM
	self.ri4 := map(tribCode in ['ex02'] => RiskWise.rawReasonCodes(ri, 4, true, false),	// no social population
			      tribCode in ['ex03'] => RiskWise.rawReasonCodes(ri, 4, true, true),	// social population
			      dataset([],Risk_Indicators.Layout_Desc));
	self.reason14 := if(tribCode in ['ex02','ex03'], self.ri4[1].hri, le.reason14);
	self.reason24 := if(tribCode in ['ex02','ex03'], self.ri4[2].hri, le.reason24);
	self.reason34 := if(tribCode in ['ex02','ex03'], self.ri4[3].hri, le.reason34);
	self.reason44 := if(tribCode in ['ex02','ex03'], self.ri4[4].hri, le.reason44);
	
	self := le;
END;
withRC4 := join(withRC2, rcSTinput, (left.seq*2)+1 = right.seq, addRC4(left, right), left outer);
BSOptions := 0;
include_relatives := NOT tribcode IN ['cb61','cb62']; // don't include relatives for cb61/cb62
clamtest := if(tribCode in ['sd01','ex06','ex07','ex08','ex09','ex10','ex22','sd50','cb61','cb62','2x08','2x10'],
									Risk_Indicators.BocaShell_BtSt_Function(iid_results, gateways, dppa, glb, false, false, include_relatives, false, false, true,
																													1, false, false, DataRestriction, BSOptions, DataPermission,
                                                                                                            LexIdSourceOptout := LexIdSourceOptout, 
                                                                                                            TransactionID := TransactionID, 
                                                                                                            BatchUID := BatchUID, 
                                                                                                            GlobalCompanyID := GlobalCompanyID),
									group(dataset([],Risk_Indicators.Layout_BocaShell_BtSt_Out),bill_to_out.seq));
									
risk_indicators.layout_boca_shell into_modelinput(clamtest le, integer i) := TRANSFORM
	self := if(i=1, le.bill_to_out, le.ship_to_out);
END;
clam := project(clamtest, into_modelinput(left,1));
clam2 := project(clamtest, into_modelinput(left,2));


Business_Risk.Layout_BIID_BtSt into_btst_in2(indata le) := transform
	clean_a := Risk_Indicators.MOD_AddressClean.clean_addr(le.addr, le.city, le.state, le.zip);
	
	
	ssn_val := cleanSSN( le.socs );
	hphone_val := cleanPhone( le.hphone );
	wphone_val := cleanPhone( le.wphone );
	
	self.Bill_to_Input.seq := le.seq;
	self.Bill_to_Input.historydate := le.historydate;
	self.Bill_to_Input.Account := le.account;
	self.Bill_to_Input.bdid	:= 0;
	self.Bill_to_Input.score := 0;
	self.Bill_to_Input.company_name := STD.Str.touppercase(le.cmpy);
	self.Bill_to_Input.alt_company_name := '';
	self.Bill_to_Input.prim_range := clean_a[1..10];
	self.Bill_to_Input.predir	 := clean_a[11..12];
	self.Bill_to_Input.prim_name	 := clean_a[13..40];
	self.Bill_to_Input.addr_suffix := clean_a[41..44];
	self.Bill_to_Input.postdir	 := clean_a[45..46];
	self.Bill_to_Input.unit_desig := clean_a[47..56];
	self.Bill_to_Input.sec_range  := clean_a[57..64];
	self.Bill_to_Input.p_city_name := if (clean_a[65..89] = '', le.city, clean_a[65..89]);
	self.Bill_to_Input.v_city_name := clean_a[90..114];
	self.Bill_to_Input.st		 := if (clean_a[115..116] = '', le.state, clean_a[115..116]);
	self.Bill_to_Input.z5		 := if (clean_a[117..121] = '', le.zip, clean_a[117..121]);
	self.Bill_to_Input.zip4		 := clean_a[122..125];
	self.Bill_to_Input.orig_z5 	 := le.zip;
	self.Bill_to_Input.lat		 := clean_a[146..155];
	self.Bill_to_Input.long		 := clean_a[156..166];
	self.Bill_to_Input.addr_type  := clean_a[139];
	self.Bill_to_Input.addr_status := clean_a[179..182];
	self.Bill_to_Input.fein		 := ssn_val;
	self.Bill_to_Input.phone10    := hphone_val;
	self.Bill_to_Input.ip_addr	 := le.ipaddr;
	
	clean_a2 := Risk_Indicators.MOD_AddressClean.clean_addr(le.addr2, le.city2, le.state2, le.zip2);


	ssn_val2 := cleanSSN( le.socs2 );
	hphone_val2 := cleanPhone( le.hphone2 );
	wphone_val2 := cleanPhone( le.wphone2 );
	
	
	self.Ship_to_Input.seq := le.seq;
	self.Ship_to_Input.historydate := le.historydate;
	self.Ship_to_Input.Account := le.account;
	self.Ship_to_Input.bdid	:= 0;
	self.Ship_to_Input.score := 0;
	self.Ship_to_Input.company_name := STD.Str.touppercase(le.cmpy2);
	self.Ship_to_Input.alt_company_name := '';
	self.Ship_to_Input.prim_range := clean_a2[1..10];
	self.Ship_to_Input.predir	 := clean_a2[11..12];
	self.Ship_to_Input.prim_name	 := clean_a2[13..40];
	self.Ship_to_Input.addr_suffix := clean_a2[41..44];
	self.Ship_to_Input.postdir	 := clean_a2[45..46];
	self.Ship_to_Input.unit_desig := clean_a2[47..56];
	self.Ship_to_Input.sec_range  := clean_a2[57..64];
	self.Ship_to_Input.p_city_name := if (clean_a2[65..89] = '', le.city2, clean_a2[65..89]);
	self.Ship_to_Input.v_city_name := clean_a2[90..114];
	self.Ship_to_Input.st		 := if (clean_a2[115..116] = '', le.state2, clean_a2[115..116]);
	self.Ship_to_Input.z5		 := if (clean_a2[117..121] = '', le.zip2, clean_a2[117..121]);
	self.Ship_to_Input.zip4		 := clean_a2[122..125];
	self.Ship_to_Input.orig_z5 	 := le.zip2;
	self.Ship_to_Input.lat		 := clean_a2[146..155];
	self.Ship_to_Input.long		 := clean_a2[156..166];
	self.Ship_to_Input.addr_type  := clean_a2[139];
	self.Ship_to_Input.addr_status := clean_a2[179..182];
	self.Ship_to_Input.fein		 := ssn_val2;
	self.Ship_to_Input.phone10    := hphone_val2;
	self.Ship_to_Input.ip_addr	 := '';
	
end;
biid_prep := project(indata,into_btst_in2(LEFT));

biid := if(tribCode in ['cb61','cb62'], 
			business_risk.InstantId_Function_BtSt(biid_prep, gateways, false, DPPA, GLB, false, false, '', ofac_version, include_ofac, include_additional_watchlists, 
                                            global_watchlist_threshold, DataRestriction, DataPermission,
                                            LexIdSourceOptout := LexIdSourceOptout, 
                                            TransactionID := TransactionID, 
                                            BatchUID := BatchUID, 
                                            GlobalCompanyID := GlobalCompanyID), 
			dataset([],Business_Risk.Layout_BIID_BtSt_Output));

dbus_Royalties := DATASET([], Royalty.Layouts.Royalty) : STORED('Bus_Royalties');
dRoyalties := Royalty.MAC_RoyaltyCombine(iidRoyalties, dbus_Royalties);

working_layout cb61_transform(working_layout le, biid rt) := transform
	// billto
	self.firstcount := (string)(integer)le.firstcount;
	self.lastcount := (string)(integer)le.lastcount;
	self.verfirst := le.verfirst;
	self.verlast := le.verlast;
	self.cmpycount := if(le.apptypeflag='2', if(rt.bill_to_output.company_name='', '', (string)(integer)RiskWise.flattenCount(rt.bill_to_output.cmpycount,2,2)), (string)(integer)le.cmpycount);
	self.addrcount := if(le.apptypeflag='2', if(rt.bill_to_output.prim_name='', '', (string)(integer)RiskWise.flattenCount(rt.bill_to_output.addrcount,2,2)), (string)(integer)le.addrcount);
	self.hphonecount := if(le.apptypeflag='2', if(rt.bill_to_output.phone10='', '', (string)(integer)RiskWise.flattenCount(rt.bill_to_output.wphonecount,2,2)), (string)(integer)le.hphonecount);
	self.numelever := if(le.apptypeflag='2',intformat( ((integer)(boolean)rt.bill_to_output.cmpycount)+((integer)(boolean)rt.bill_to_output.addrcount)+
									((integer)(boolean)rt.bill_to_output.wphonecount)+ ((integer)(boolean)le.firstcount) + ((integer)(boolean)le.lastcount),2,1),le.numelever);
	self.numsource := if(le.apptypeflag='2',intformat((integer)le.firstcount+(integer)le.lastcount+(integer)self.cmpycount+(integer)self.addrcount+
					    						      (integer)self.hphonecount,2,1), le.numsource);

	self.vercmpy := if(le.apptypeflag='2', rt.bill_to_output.vercmpy, le.vercmpy);
	self.veraddr := if(le.apptypeflag='2', rt.bill_to_output.veraddr, le.veraddr);
	self.vercity := if(le.apptypeflag='2', rt.bill_to_output.vercity, le.vercity);
	self.verstate := if(le.apptypeflag='2', rt.bill_to_output.verstate, le.verstate);
	self.verzip := if(le.apptypeflag='2', rt.bill_to_output.verzip, le.verzip);
	self.verhphone := if(le.apptypeflag='2', rt.bill_to_output.verphone, le.verhphone);
	

	// shipto
	self.firstcount2 := (string)(integer)le.firstcount2;
	self.lastcount2 := (string)(integer)le.lastcount2;
	self.verfirst2 := le.verfirst2;
	self.verlast2 := le.verlast2;
	self.cmpycount2 := if(le.apptypeflag2='2', if(rt.ship_to_output.company_name='', '', (string)(integer)RiskWise.flattenCount(rt.ship_to_output.cmpycount,2,2)), (string)(integer)le.cmpycount2);
	self.addrcount2 := if(le.apptypeflag2='2', if(rt.ship_to_output.prim_name='', '', (string)(integer)RiskWise.flattenCount(rt.ship_to_output.addrcount,2,2)), (string)(integer)le.addrcount2);
	self.hphonecount2 := if(le.apptypeflag2='2', if(rt.ship_to_output.phone10='', '', (string)(integer)RiskWise.flattenCount(rt.ship_to_output.wphonecount,2,2)), (string)(integer)le.hphonecount2);
	self.numelever2 := if(le.apptypeflag2='2',intformat( ((integer)(boolean)rt.ship_to_output.cmpycount)+((integer)(boolean)rt.ship_to_output.addrcount)+
									((integer)(boolean)rt.ship_to_output.wphonecount) + ((integer)(boolean)le.firstcount2) + ((integer)(boolean)le.lastcount2),2,1),le.numelever2);
	self.numsource2 := if(le.apptypeflag2='2',intformat((integer)le.firstcount2+(integer)le.lastcount2+(integer)self.cmpycount2+(integer)self.addrcount2+
					    						      (integer)self.hphonecount2,2,1), le.numsource2);
	self.vercmpy2 := if(le.apptypeflag2='2', rt.ship_to_output.vercmpy, le.vercmpy2);
	self.veraddr2 := if(le.apptypeflag2='2', rt.ship_to_output.veraddr, le.veraddr2);
	self.vercity2 := if(le.apptypeflag2='2', rt.ship_to_output.vercity, le.vercity2);
	self.verstate2 := if(le.apptypeflag2='2', rt.ship_to_output.verstate, le.verstate2);
	self.verzip2 := if(le.apptypeflag2='2', rt.ship_to_output.verzip, le.verzip2);
	self.verhphone2 := if(le.apptypeflag2='2', rt.ship_to_output.verphone, le.verhphone2);
		
	self := le;
end;

// only do the join to overwrite some vdata and counts for the business half if the tribcode is cb61 or cb62
after_cb61 := if(tribcode in ['cb61','cb62'],  join(withRC4, biid, (left.seq*2)=right.bill_to_output.seq, cb61_transform(left,right),left outer), withRC4); 

getScore := map(tribCode = 'sd01' => Models.TBN509_0_0(clam, true),
			 tribCode in ['ex06','ex07','ex08','ex09','ex10','ex22','sd50'] => Models.FD5603_2_0(clam, true), 
			 tribCode in ['2x08','2x10'] => Models.FD9606_0_0(clam, easi_census_bt, true, false /*fcra*/),
			 tribCode in ['cb61','cb62'] => Models.CDN604_1_0(clamtest, biid),
			 dataset([],Models.Layout_ModelOut));


// for cb61 overrides to score, search telcordia with the input phone to get a zipcode for that phone, 
// then search citystatezip with that zip to see if the state matches input zip.  If the phone doesn't match the state, set the score to 98		 
working_layout addzipcode(working_layout le, risk_indicators.Key_Telcordia_tpm_Slim rt) := transform
	self.telco_zip5 := rt.zipcodes[1].zip;
	self := le;
end;

wTelcoZip := join(after_cb61, risk_indicators.Key_Telcordia_tpm_Slim, 
				keyed(LEFT.in_phone10[1..3]=(RIGHT.npa)) and 
				keyed(left.in_phone10[4..6]=RIGHT.nxx) and
				KEYED(RIGHT.tb IN [LEFT.in_phone10[7],'A']),
				addzipcode(left,right), left outer,
				ATMOST(
					keyed(LEFT.in_phone10[1..3]=(RIGHT.npa)) and 
					keyed(left.in_phone10[4..6]=RIGHT.nxx) and
					KEYED(RIGHT.tb IN [LEFT.in_phone10[7],'A']),
					RiskWise.max_atmost),
				keep(1));
				
working_layout check_citystatezip(working_layout le, riskwise.Key_CityStZip rt) := transform
	self.phone_state_mismatch := IF(rt.state <> '' and STD.Str.ToUpperCase(le.in_state) <> rt.state, true, false);
	self := le;
end;

withStateZip := join(wTelcoZip, riskwise.Key_CityStZip,
				keyed(right.zip5=left.telco_zip5) and left.telco_zip5!='',
				check_citystatezip(left, right), left outer, ATMOST(keyed(right.zip5=left.telco_zip5),RiskWise.max_atmost), keep(1));


working_layout addBTmodel(withStateZip le, getScore ri) := TRANSFORM
	self.score := if(tribCode = 'ex70', le.score, if(tribCode = 'cb61', if(le.phone_state_mismatch, '98', ri.score[1..2]), if(tribCode = 'cb62', ri.score[1..2], ri.score)));
	self.score2 := if(tribCode = 'cb61',
		map(
			le.shipto_score97  => '97',
			le.shipto_score99  => '99',
			ri.score[3..4]
		),
		if(tribCode = 'cb62', ri.score[3..4], le.score2));
	self.reason11 := map(tribCode in ['ex06','ex07','ex08','ex09','ex10','ex22','sd50','2x08','2x10'] => ri.ri[1].hri,
					 tribCode = 'sd01' => if(Risk_Indicators.rcSet.isCode36(ri.ri[1].hri), '36', if(ri.ri[1].hri='00', '', if((integer)ri.ri[1].hri<10, ri.ri[1].hri[2], ri.ri[1].hri))),
					 le.reason11);
	self.reason21 := map(tribCode in ['sd01'] and ri.ri[2].hri<>'00' =>  if((integer)ri.ri[2].hri<10, ri.ri[2].hri[2], ri.ri[2].hri),
				      tribCode in ['ex06','ex07','ex08','ex09','ex10','ex22','sd50','2x08','2x10'] => ri.ri[2].hri,
				      le.reason21);
	self.reason31 := map(tribCode in ['sd01'] and ri.ri[3].hri<>'00' => if((integer)ri.ri[3].hri<10, ri.ri[3].hri[2], ri.ri[3].hri),
				      tribCode in ['ex06','ex07','ex08','ex09','ex10','ex22','sd50','2x08','2x10'] => ri.ri[3].hri,
				      le.reason31);
	self.reason41 := map(tribCode in ['sd01'] and ri.ri[4].hri<>'00' => if((integer)ri.ri[4].hri<10, ri.ri[4].hri[2], ri.ri[4].hri),
				      tribCode in ['ex06','ex07','ex08','ex09','ex10','ex22','sd50','2x08','2x10'] => ri.ri[4].hri,
				      le.reason41);
	
	self := le;
END;
withBTmodel := join(withStateZip, getScore, (left.seq*2) = right.seq, addBTmodel(left, right), left outer);


working_layout addBTrcb(withBTmodel le, iid_results ri) := TRANSFORM
	boolean belowCutoff := (integer)le.score <= HRCUTOFF;

	self.ri2 := if(tribCode in ['ex06','ex07','ex08','ex09','ex10','sd50','2x08','2x10'] and belowCutoff, RiskWise.rawReasonCodes(ri.bill_to_output, 4, true, true),	// social population
																		   dataset([],Risk_Indicators.Layout_Desc));
	self.reason12 := if(tribCode in ['ex06','ex07','ex08','ex09','ex10','sd50','2x08','2x10'] and belowCutoff, self.ri2[1].hri, le.reason12);
	self.reason22 := if(tribCode in ['ex06','ex07','ex08','ex09','ex10','sd50','2x08','2x10'] and belowCutoff, self.ri2[2].hri, le.reason22);
	self.reason32 := if(tribCode in ['ex06','ex07','ex08','ex09','ex10','sd50','2x08','2x10'] and belowCutoff, self.ri2[3].hri, le.reason32);
	self.reason42 := if(tribCode in ['ex06','ex07','ex08','ex09','ex10','sd50','2x08','2x10'] and belowCutoff, self.ri2[4].hri, le.reason42);
	
	// output vdata fields if below cutoff
	numByte := if(tribCode = 'sd01', 1, 2);	// sd01 formats the count to 1 byte, the others are 2 bytes
	self.firstcount := if(ri.bill_to_output.fname <> '' and tribCode in ['ex06','ex07','ex08','ex09','ex10','sd50','2x08','2x10'] and belowCutoff, 
							RiskWise.flattenCount(ri.bill_to_output.combo_firstcount,2,numByte), le.firstcount);
	self.lastcount := if(ri.bill_to_output.lname <> '' and tribCode in ['ex06','ex07','ex08','ex09','ex10','sd50','2x08','2x10'] and belowCutoff, 
							RiskWise.flattenCount(ri.bill_to_output.combo_lastcount,2,numByte), le.lastcount);
	self.cmpycount := if(ri.bill_to_output.employer_name <> '' and tribCode in ['ex06','ex07','ex08','ex09','ex10','sd50','2x08','2x10'] and belowCutoff, 
							RiskWise.flattenCount(ri.bill_to_output.combo_cmpycount,2,numByte), le.cmpycount);
	self.addrcount := if(ri.bill_to_output.in_StreetAddress <> '' and tribCode in ['ex06','ex07','ex08','ex09','ex10','sd50','2x08','2x10'] and belowCutoff, 
							RiskWise.flattenCount(ri.bill_to_output.combo_addrcount,2,numByte), le.addrcount);
	self.socscount := if(ri.bill_to_output.ssn <> '' and tribCode in ['ex06','ex07','ex08','ex09','ex10','sd50','2x08','2x10'] and belowCutoff, 
							RiskWise.flattenCount(ri.bill_to_output.combo_ssncount,2,numByte), le.socscount);
	self.hphonecount := if(ri.bill_to_output.phone10 <> '' and tribCode in ['ex06','ex07','ex08','ex09','ex10','sd50','2x08','2x10'] and belowCutoff, 
							RiskWise.flattenCount(ri.bill_to_output.combo_hphonecount,2,numByte), le.hphonecount);
	self.wphonecount := if(ri.bill_to_output.wphone10 <> '' and tribCode in ['ex06','ex07','ex08','ex09','ex10','sd50','2x08','2x10'] and belowCutoff, 
							RiskWise.flattenCount(ri.bill_to_output.combo_wphonecount,2,numByte), le.wphonecount);
	self.dobcount := if(ri.bill_to_output.dob <> '' and tribCode in ['ex06','ex07','ex08','ex09','ex10','sd50','2x08','2x10'] and belowCutoff, 
							RiskWise.flattenCount(ri.bill_to_output.combo_dobcount,2,numByte), le.dobcount);
	
	self.socsverlvl := if(tribCode in ['ex06','ex07','ex08','ex09','ex10','sd50','2x08','2x10'] and belowCutoff, intformat(getSocsLevel(ri.bill_to_output.socsverlevel),numByte,1), le.socsverlvl);
	
	self.numelever := if(tribCode in ['ex06','ex07','ex08','ex09','ex10','sd50','2x08','2x10'] and belowCutoff, intformat(ri.bill_to_output.numelever,numByte,1), le.numelever);
	self.numsource := if(tribCode in ['ex06','ex07','ex08','ex09','ex10','sd50','2x08','2x10'] and belowCutoff, intformat((integer)self.firstcount+(integer)self.lastcount+(integer)self.cmpycount+
																					    (integer)self.addrcount+(integer)self.hphonecount+(integer)self.wphonecount+
																					    (integer)self.socscount+(integer)self.dobcount,numByte,1),
																			    le.numsource);
	
	self.verfirst := if(tribCode in ['ex06','ex07','ex08','ex09','ex10','sd50','2x08','2x10'] and belowCutoff, ri.bill_to_output.combo_first, le.verfirst);
	self.verlast := if(tribCode in ['ex06','ex07','ex08','ex09','ex10','sd50','2x08','2x10'] and belowCutoff, ri.bill_to_output.combo_last, le.verlast);
	self.vercmpy := if(tribCode in ['ex06','ex07','ex08','ex09','ex10','sd50','2x08','2x10'] and belowCutoff, ri.bill_to_output.combo_cmpy, le.vercmpy);
	self.veraddr := if(tribCode in ['ex06','ex07','ex08','ex09','ex10','sd50','2x08','2x10'] and belowCutoff, Risk_Indicators.MOD_AddressClean.street_address('',ri.bill_to_output.combo_prim_range,
																									ri.bill_to_output.combo_predir,ri.bill_to_output.combo_prim_name,
																									ri.bill_to_output.combo_suffix,ri.bill_to_output.combo_postdir,
																									ri.bill_to_output.combo_unit_desig,ri.bill_to_output.combo_sec_range),
																			  le.veraddr);
	self.vercity := if(tribCode in ['ex06','ex07','ex08','ex09','ex10','sd50','2x08','2x10'] and belowCutoff, ri.bill_to_output.combo_city, le.vercity);
	self.verstate := if(tribCode in ['ex06','ex07','ex08','ex09','ex10','sd50','2x08','2x10'] and belowCutoff, ri.bill_to_output.combo_state, le.verstate);
	SElF.verzip := if(tribCode in ['ex06','ex07','ex08','ex09','ex10','sd50','2x08','2x10'] and belowCutoff, ri.bill_to_output.combo_zip, le.verzip);
	self.versocs := if(ri.bill_to_output.combo_ssncount > 0, if(tribCode in ['ex06','ex07','ex08','ex09','ex10','sd50','2x08','2x10'] and belowCutoff, ri.bill_to_output.combo_ssn, le.versocs),
												  '');
	self.verdob := if(tribCode in ['ex06','ex07','ex08','ex09','ex10','sd50','2x08','2x10'] and belowCutoff, ri.bill_to_output.combo_dob, le.verdob);
	self.verhphone := if(tribCode in ['ex06','ex07','ex08','ex09','ex10','sd50','2x08','2x10'] and belowCutoff, ri.bill_to_output.combo_hphone, le.verhphone);
	self.verwphone := if(tribCode in ['ex06','ex07','ex08','ex09','ex10','sd50','2x08','2x10'] and belowCutoff, ri.bill_to_output.combo_wphone, le.verwphone);
	
	self := le;
END;
withBTrcb := join(withBTmodel, iid_results, (left.seq*2) = right.bill_to_output.seq, addBTrcb(left, right), left outer);


getScore3a := if(tribCode = 'ex22', Models.TBN509_0_0(clam, true), dataset([],Models.Layout_ModelOut));

working_layout addBTmodel3a(withBTrcb le, getScore3a ri) := TRANSFORM
	self.score3 := if(le.score3 <> '000' and tribCode = 'ex22', ri.score, le.score3);
	self.reason13 := if(tribCode = 'ex22', if(Risk_Indicators.rcSet.isCode36(ri.ri[1].hri), '36', ri.ri[1].hri), le.reason13);
	self.reason23 := if(tribCode = 'ex22', ri.ri[2].hri, le.reason23);
	self.reason33 := if(tribCode = 'ex22', ri.ri[3].hri, le.reason33);
	self.reason43 := if(tribCode = 'ex22', ri.ri[4].hri, le.reason43);
	
	self := le;
END;
withBT3a := join(withBTrcb, getScore3a, (left.seq*2) = right.seq, addBTmodel3a(left, right), left outer);
	


getScore3b := map(
	tribCode in ['ex06','ex07','ex08','ex09','ex10','sd50'] => Models.FD5603_2_0(clam2, true),
	tribCode in ['2x08','2x10'] => Models.FD9606_0_0(clam2, easi_census_st, true),

	dataset([],Models.Layout_ModelOut)
);
			 

working_layout addSTmodel(withBT3a le, getScore3b ri) := TRANSFORM
	self.score3 := if(tribCode in ['ex06','ex07','ex08','ex09','ex10','sd50','2x08','2x10'], ri.score, le.score3);
	self.reason13 := if(tribCode in ['ex06','ex07','ex08','ex09','ex10','sd50','2x08','2x10'], ri.ri[1].hri, le.reason13);
	self.reason23 := if(tribCode in ['ex06','ex07','ex08','ex09','ex10','sd50','2x08','2x10'], ri.ri[2].hri, le.reason23);
	self.reason33 := if(tribCode in ['ex06','ex07','ex08','ex09','ex10','sd50','2x08','2x10'], ri.ri[3].hri, le.reason33);
	self.reason43 := if(tribCode in ['ex06','ex07','ex08','ex09','ex10','sd50','2x08','2x10'], ri.ri[4].hri, le.reason43);
								   
	self := le;
END;
withSTmodel := join(withBT3a, getScore3b, (left.seq*2)+1 = right.seq, addSTmodel(left, right), left outer);


working_layout addSTrc4(withSTmodel le, iid_results ri) := TRANSFORM
	boolean belowCutoff := (integer)le.score3 <= HRCUTOFF;

	self.ri4 := if(tribCode in ['ex06','ex07','ex08','ex09','ex10','sd50','2x08','2x10'] and belowCutoff, RiskWise.rawReasonCodes(ri.ship_to_output, 4, true, true),	// social population
				dataset([],Risk_Indicators.Layout_Desc));
	self.reason14 := if(tribCode in ['ex06','ex07','ex08','ex09','ex10','sd50','2x08','2x10'] and belowCutoff, self.ri4[1].hri, le.reason14);
	self.reason24 := if(tribCode in ['ex06','ex07','ex08','ex09','ex10','sd50','2x08','2x10'] and belowCutoff, self.ri4[2].hri, le.reason24);
	self.reason34 := if(tribCode in ['ex06','ex07','ex08','ex09','ex10','sd50','2x08','2x10'] and belowCutoff, self.ri4[3].hri, le.reason34);
	self.reason44 := if(tribCode in ['ex06','ex07','ex08','ex09','ex10','sd50','2x08','2x10'] and belowCutoff, self.ri4[4].hri, le.reason44);
	
	// output data reliant on score3
	numByte := if(tribCode = 'sd01', 1, 2);	// sd01 formats the count to 1 byte, the others are 2 bytes
	self.firstcount2 := if(ri.ship_to_output.fname <> '' and tribCode in ['ex06','ex07','ex08','ex09','ex10','sd50','2x08','2x10'] and belowCutoff, 
							RiskWise.flattenCount(ri.ship_to_output.combo_firstcount,2,numByte), le.firstcount2);
	self.lastcount2 := if(ri.ship_to_output.lname <> '' and tribCode in ['ex06','ex07','ex08','ex09','ex10','sd50','2x08','2x10'] and belowCutoff, 
							RiskWise.flattenCount(ri.ship_to_output.combo_lastcount,2,numByte), le.lastcount2);
	self.cmpycount2 := if(ri.ship_to_output.employer_name <> '' and tribCode in ['ex06','ex07','ex08','ex09','ex10','sd50','2x08','2x10'] and belowCutoff, 
							RiskWise.flattenCount(ri.ship_to_output.combo_cmpycount,2,numByte), le.cmpycount2);
	self.addrcount2 := if(ri.ship_to_output.in_streetAddress <> '' and tribCode in ['ex06','ex07','ex08','ex09','ex10','sd50','2x08','2x10'] and belowCutoff, 
							RiskWise.flattenCount(ri.ship_to_output.combo_addrcount,2,numByte), le.addrcount2);
	self.socscount2 := if(ri.ship_to_output.ssn <> '' and tribCode in ['ex06','ex07','ex08','ex09','ex10','sd50','2x08','2x10'] and belowCutoff, 
							RiskWise.flattenCount(ri.ship_to_output.combo_ssncount,2,numByte), le.socscount2);
	self.hphonecount2 := if(ri.ship_to_output.phone10 <> '' and tribCode in ['ex06','ex07','ex08','ex09','ex10','sd50','2x08','2x10'] and belowCutoff, 
							RiskWise.flattenCount(ri.ship_to_output.combo_hphonecount,2,numByte), le.hphonecount2);
	self.wphonecount2 := if(ri.ship_to_output.wphone10 <> '' and tribCode in ['ex06','ex07','ex08','ex09','ex10','sd50','2x08','2x10'] and belowCutoff, 
							RiskWise.flattenCount(ri.ship_to_output.combo_wphonecount,2,numByte), le.wphonecount2);
	self.dobcount2 := if(ri.ship_to_output.dob <> '' and tribCode in ['ex06','ex07','ex08','ex09','ex10','sd50','2x08','2x10'] and belowCutoff, 
							RiskWise.flattenCount(ri.ship_to_output.combo_dobcount,2,numByte), le.dobcount2);
		
	self.socsverlvl2 := if(tribCode in ['ex06','ex07','ex08','ex09','ex10','sd50','2x08','2x10'] and belowCutoff, intformat(getSocsLevel(ri.ship_to_output.socsverlevel),numByte,1), le.socsverlvl2);
	
	self.numelever2 := if(tribCode in ['ex06','ex07','ex08','ex09','ex10','sd50','2x08','2x10'] and belowCutoff, intformat(ri.ship_to_output.numelever,numByte,1), le.numelever2);
	self.numsource2 := if(tribCode in ['ex06','ex07','ex08','ex09','ex10','sd50','2x08','2x10'] and belowCutoff, intformat((integer)self.firstcount2+(integer)self.lastcount2+(integer)self.cmpycount2+
																						(integer)self.addrcount2+(integer)self.hphonecount2+(integer)self.wphonecount2+
																						(integer)self.socscount2+(integer)self.dobcount2,2,1),
																				le.numsource2);
	
	self.verfirst2 := if(tribCode in ['ex06','ex07','ex08','ex09','ex10','sd50','2x08','2x10'] and belowCutoff, ri.ship_to_output.combo_first, le.verfirst2);
	self.verlast2 := if(tribCode in ['ex06','ex07','ex08','ex09','ex10','sd50','2x08','2x10'] and belowCutoff, ri.ship_to_output.combo_last, le.verlast2);
	self.vercmpy2 := if(tribCode in ['ex06','ex07','ex08','ex09','ex10','sd50','2x08','2x10'] and belowCutoff, ri.ship_to_output.combo_cmpy, le.vercmpy2);
	self.veraddr2 := if(tribCode in ['ex06','ex07','ex08','ex09','ex10','sd50','2x08','2x10'] and belowCutoff, Risk_Indicators.MOD_AddressClean.street_address('',ri.ship_to_output.combo_prim_range,
																									 ri.ship_to_output.combo_predir,ri.ship_to_output.combo_prim_name,
																									 ri.ship_to_output.combo_suffix,ri.ship_to_output.combo_postdir,
																									 ri.ship_to_output.combo_unit_desig,ri.ship_to_output.combo_sec_range),
																			   le.veraddr2);
	self.vercity2 := if(tribCode in ['ex06','ex07','ex08','ex09','ex10','sd50','2x08','2x10'] and belowCutoff,ri.ship_to_output.combo_city, le.vercity2);
	self.verstate2 := if(tribCode in ['ex06','ex07','ex08','ex09','ex10','sd50','2x08','2x10'] and belowCutoff,ri.ship_to_output.combo_state, le.verstate2);
	SElF.verzip2 := if(tribCode in ['ex06','ex07','ex08','ex09','ex10','sd50','2x08','2x10'] and belowCutoff,ri.ship_to_output.combo_zip, le.verzip2);
	self.versocs2 := if(ri.ship_to_output.combo_ssncount > 0, if(tribCode in ['ex06','ex07','ex08','ex09','ex10','sd50','2x08','2x10'] and belowCutoff, ri.ship_to_output.combo_ssn, le.versocs2), '');
	self.verdob2 := if(tribCode in ['ex06','ex07','ex08','ex09','ex10','sd50','2x08','2x10'] and belowCutoff, ri.ship_to_output.combo_dob, le.verdob2);
	self.verhphone2 := if(tribCode in ['ex06','ex07','ex08','ex09','ex10','sd50','2x08','2x10'] and belowCutoff, ri.ship_to_output.combo_hphone, le.verhphone2);
	self.verwphone2 := if(tribCode in ['ex06','ex07','ex08','ex09','ex10','sd50','2x08','2x10'] and belowCutoff, ri.ship_to_output.combo_wphone, le.verwphone2);

	self := le;
END;
withSTrc4 := join(withSTmodel, iid_results, (left.seq*2) = right.bill_to_output.seq, addSTrc4(left, right), left outer);
	
RiskWise.Layout_SD1O format_output(withSTrc4 le) := TRANSFORM
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
	self.socsverlvl := if(le.doOutput or tribCode = 'sd01', le.socsverlvl, '');
	self.numelever := if(le.doOutput or tribCode = 'sd01', le.numelever, '');
	self.numsource := if(le.doOutput or tribCode = 'sd01', le.numsource, '');
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
	self.socsverlvl2 := if(le.doOutput2 or tribCode = 'sd01', le.socsverlvl2, '');
	self.numelever2 := if(le.doOutput2 or tribCode = 'sd01', le.numelever2, '');
	self.numsource2 := if(le.doOutput2 or tribCode = 'sd01', le.numsource2, '');
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
	self.score3   := if((tribCode = 'ex22' and le.doOutput) or (tribCode <> 'ex22' and le.doOutput2), le.score3, '');
	self.reason13 := if((tribCode = 'ex22' and le.doOutput) or (tribCode <> 'ex22' and le.doOutput2), le.reason13, '');
	self.reason23 := if((tribCode = 'ex22' and le.doOutput) or (tribCode <> 'ex22' and le.doOutput2), le.reason23, '');
	self.reason33 := if((tribCode = 'ex22' and le.doOutput) or (tribCode <> 'ex22' and le.doOutput2), le.reason33, '');
	self.reason43 := if((tribCode = 'ex22' and le.doOutput) or (tribCode <> 'ex22' and le.doOutput2), le.reason43, '');
	self.score4 := if(le.doOutput2, le.score4, '');
	self.reason14 := if(le.doOutput2, le.reason14, '');
	self.reason24 := if(le.doOutput2, le.reason24, '');
	self.reason34 := if(le.doOutput2, le.reason34, '');
	self.reason44 := if(le.doOutput2, le.reason44, '');
	self.reserved := if(le.doOutput, le.reserved, '');
	self.billing := if(le.doOutput, le.billing, dataset([],Risk_Indicators.Layout_Billing));
END;
final := project(withSTrc4, format_output(left));

dooutputs_rec := record
   boolean doOutput;
   boolean doOutput2;
end;
dooutputs_rec makedooutputs( withstrc4 le ) := transform
   self := le;
end;
dooutputs := project( withstrc4, makedooutputs( left ) );
#STORED('Royalties', dRoyalties);

return final;

END;