import ut, Risk_Indicators, Models, easi, gateway, STD;

export SC1O_Function(dataset(Layout_SD1I) indata, dataset(Gateway.Layouts.Config) gateways, unsigned1 glb, unsigned1 dppa, 
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
              unsigned6 GlobalCompanyId = 0) := 

FUNCTION

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

isbridgerservicename := count( gateways(ServiceName = 'bridgerwlc') ) > 0;

includeOFAC := (tribcode in ['ex95']) or (isbridgerservicename and include_ofac);

BSVersion := Map(tribCode in ['ex01','ex11','ex12','ex39','ex40','ex90','ex91','ex94','sc51','2x01'] => 1,
								tribCode in ['ex95'] => 2,
								1);

iid_results := risk_indicators.InstantId_BtSt_Function(prep, gateways, dppa, glb, false, false, true, true, true,
																											 false, false, false, false, ofac_version, includeOFAC, include_additional_watchlists, 
                                                       global_watchlist_threshold, -1, BSVersion, DataRestriction:=DataRestriction, DataPermission:=DataPermission,
                                                       LexIdSourceOptout := LexIdSourceOptout, 
                                                       TransactionID := TransactionID, 
                                                       BatchUID := BatchUID, 
                                                       GlobalCompanyID := GlobalCompanyID);


// intermediate results
working_layout := RECORD
	RiskWise.Layout_SC1O;
	dataset(Risk_Indicators.Layout_Desc) ri;
	dataset(Risk_Indicators.Layout_Desc) ri2;
	dataset(Risk_Indicators.Layout_Desc) ri4;
	unsigned4 seq;
	boolean doOutput := false;
	boolean doOutput2 := false;
	RiskWise.Layout_for_Royalties;
END;



working_layout fill_output(iid_results le, indata ri) := TRANSFORM
	self.doOutput := if(ri.first='' and ri.last='' and ri.addr='' and ri.socs='' and ri.dob='' and ri.hphone='' and ri.wphone='', false, true);
	self.doOutput2 := if(ri.first2='' and ri.last2='' and ri.addr2='' and ri.socs2='' and ri.dob2='' and ri.hphone2='' and ri.wphone2='', false, true);
						
	self.seq := ri.seq;
	self.account := ri.account;
	self.acctno := ri.acctno;
	self.riskwiseid := (string)le.bill_to_output.did;
	
	self.score2 := map(tribcode in ['ex04','ex11'] and le.bill_to_output.combo_lastcount>0 and le.bill_to_output.combo_addrcount>0 and le.bill_to_output.combo_hphonecount>0 => '001',
				    tribcode in ['ex05','ex12','ex39'] and le.bill_to_output.combo_lastcount>0 and le.bill_to_output.combo_addrcount>0 and le.bill_to_output.combo_hphonecount>0 and 
												   le.bill_to_output.combo_ssncount>0 => '001',
				    tribcode in ['ex04','ex05','ex11','ex12','ex39'] => '000',
				    '');
	

// do second dataset
	self.score4 := map(tribcode in ['ex04','ex11'] and le.ship_to_output.combo_lastcount>0 and le.ship_to_output.combo_addrcount>0 and le.ship_to_output.combo_hphonecount>0 => '001',
				    tribcode in ['ex05','ex12','ex39'] and le.ship_to_output.combo_lastcount>0 and le.ship_to_output.combo_addrcount>0 and le.ship_to_output.combo_hphonecount>0 and 
												   le.ship_to_output.combo_ssncount>0 => '001',
				    tribcode in ['ex04','ex05','ex11','ex12','ex39'] => '000',
				    '');		  
	self.targusType := if(le.Bill_To_Output.TargusType <> '', le.Bill_To_Output.TargusType, le.Ship_To_Output.TargusType);
	self.src := if(le.Bill_To_Output.src <> '', le.Bill_To_Output.src, le.Ship_To_Output.src);
	self.TargusGatewayUsed := if(le.Bill_To_Output.TargusGatewayUsed, le.Bill_To_Output.TargusGatewayUsed, le.Ship_To_Output.TargusGatewayUsed);
						
	self := [];
END;
mapped_results := join(iid_results, indata, left.bill_to_output.seq = (right.seq * 2), fill_output(left,right), left outer);

// add reason codes
rcBTinput := PROJECT(iid_results, TRANSFORM(Risk_Indicators.Layout_Output, self := left.Bill_To_Output));


working_layout addRC12(mapped_results le, rcBTinput ri) := TRANSFORM
	self.ri := if(tribCode = 'sc51', RiskWise.mmReasonCodes(ri, 4, true, false), dataset([],Risk_Indicators.Layout_Desc));
	self.reason11 := if(tribCode = 'sc51', if(Risk_Indicators.rcSet.isCode36(self.ri[1].hri), '36', self.ri[1].hri), le.reason11);
	self.reason21 := if(tribCode = 'sc51', self.ri[2].hri, le.reason21);
	self.reason31 := if(tribCode = 'sc51', self.ri[3].hri, le.reason31);
	self.reason41 := if(tribCode = 'sc51', self.ri[4].hri, le.reason41);
	
	self.ri2 := map(tribcode in ['ex04','ex11'] => RiskWise.verReasonCodes(ri, 4, true, false),	// no social population
				 tribcode in ['ex05','ex12','ex39'] => RiskWise.verReasonCodes(ri, 4, true, true),	// social population
				 dataset([],Risk_Indicators.Layout_Desc));
	self.reason12 := if(tribcode in ['ex04','ex05','ex11','ex12','ex39'], self.ri2[1].hri, le.reason12);
	self.reason22 := if(tribcode in ['ex04','ex05','ex11','ex12','ex39'], self.ri2[2].hri, le.reason22);
	self.reason32 := if(tribcode in ['ex04','ex05','ex11','ex12','ex39'], self.ri2[3].hri, le.reason32);
	self.reason42 := if(tribcode in ['ex04','ex05','ex11','ex12','ex39'], self.ri2[4].hri, le.reason42);
	self := le;
END;
withRC12 := join(mapped_results, rcBTinput, (left.seq*2) = right.seq, addRC12(left, right), left outer);

// add reason codes ST
rcSTinput := PROJECT(iid_results, TRANSFORM(Risk_Indicators.Layout_Output, self := left.Ship_To_Output));


working_layout addRC4(withRC12 le, rcSTinput ri) := TRANSFORM
	self.ri4 := map(tribcode in ['ex04','ex11'] => RiskWise.verReasonCodes(ri, 4, true, false),	// no social population
			      tribcode in ['ex05','ex12','ex39'] => RiskWise.verReasonCodes(ri, 4, true, true),	// social population
			      dataset([],Risk_Indicators.Layout_Desc));
	
	self.reason14 := if(tribcode in ['ex04','ex05','ex11','ex12','ex39'], self.ri4[1].hri, le.reason14);
	self.reason24 := if(tribcode in ['ex04','ex05','ex11','ex12','ex39'], self.ri4[2].hri, le.reason24);
	self.reason34 := if(tribcode in ['ex04','ex05','ex11','ex12','ex39'], self.ri4[3].hri, le.reason34);
	self.reason44 := if(tribcode in ['ex04','ex05','ex11','ex12','ex39'], self.ri4[4].hri, le.reason44);
	self := le;
END;
withRC4 := join(withRC12, rcSTinput, (left.seq*2)+1 = right.seq, addRC4(left, right), left outer);

include_derogs := tribcode != '2x01'; // don't include derogs for 2x01
clamtest := if(tribCode in ['ex01','ex11','ex12','ex39','ex40','ex90','ex91','ex94','ex95','sc51','2x01'],
									Risk_Indicators.BocaShell_BtSt_Function(iid_results, gateways, dppa, glb, false, false, true, false, 
																													false, include_derogs,BSVersion,DataRestriction:=DataRestriction,
																													DataPermission:=DataPermission,
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


// build easi_census data
	easi_census_bt := join( clam, Easi.Key_Easi_Census,
			keyed(right.geolink=left.Address_Verification.Input_Address_Information.st+left.Address_Verification.Input_Address_Information.county+left.Address_Verification.Input_Address_Information.geo_blk),
			transform(easi.layout_census, 
						self.state:= left.Address_Verification.Input_Address_Information.st,
						self.county:=left.Address_Verification.Input_Address_Information.county,
						self.tract:=left.Address_Verification.Input_Address_Information.geo_blk[1..6],
						self.blkgrp:=left.Address_Verification.Input_Address_Information.geo_blk[7],
						self.geo_blk:=left.Address_Verification.Input_Address_Information.geo_blk,
						self := right));

	easi_census_st := join( clam2, Easi.Key_Easi_Census,
			keyed(right.geolink=left.Address_Verification.Input_Address_Information.st+left.Address_Verification.Input_Address_Information.county+left.Address_Verification.Input_Address_Information.geo_blk),
			transform(easi.layout_census, 
						self.state:= left.Address_Verification.Input_Address_Information.st,
						self.county:=left.Address_Verification.Input_Address_Information.county,
						self.tract:=left.Address_Verification.Input_Address_Information.geo_blk[1..6],
						self.blkgrp:=left.Address_Verification.Input_Address_Information.geo_blk[7],
						self.geo_blk:=left.Address_Verification.Input_Address_Information.geo_blk,
						self := right));


getScore := map(tribCode in ['ex01','ex11','ex12','ex39'] => Models.FD5603_2_0(clam, true),
			 tribCode = 'ex40' => Models.FD5603_3_0(clam, true),
			 tribCode = 'ex90' => Models.FD5603_1_0(clam, true),
			 tribCode in ['ex91','ex94'] => Models.FD9603_1_0(clam, true),
			 tribCode in ['ex95'] => Models.FP5812_1_0(clam, 4, true),			 
			 tribCode = 'sc51' => Models.CDN605_1_0(clamtest, true, false),
			 tribcode = '2x01' => Models.FD9606_0_0(clam, ungroup(easi_census_bt), true ),
			 dataset([],Models.Layout_ModelOut));


working_layout addBTmodel(withRC4 le, getScore ri) := TRANSFORM
	self.score := if(tribCode in ['ex40','ex91','ex94','ex95'], '0' + ri.score, ri.score);
	self.reason11 := if(tribCode = 'sc51', le.reason11, ri.ri[1].hri);
	self.reason21 := if(tribCode = 'sc51', le.reason21, ri.ri[2].hri);
	self.reason31 := if(tribCode = 'sc51', le.reason31, ri.ri[3].hri);
	self.reason41 := if(tribCode = 'sc51', le.reason41, ri.ri[4].hri);
	
	self.score2 := if(tribCode = 'ex39' and (integer)ri.score <= 40, '', le.score2);
	self.reason12 := if(tribCode = 'ex39' and (integer)ri.score <= 40, '', le.reason12); 
	self.reason22 := if(tribCode = 'ex39' and (integer)ri.score <= 40, '', le.reason22);
	self.reason32 := if(tribCode = 'ex39' and (integer)ri.score <= 40, '', le.reason32);
	self.reason42 := if(tribCode = 'ex39' and (integer)ri.score <= 40, '', le.reason42);
	
	self := le;
END;
withBTmodel := join(withRC4, getScore, (left.seq*2) = right.seq, addBTmodel(left, right), left outer);

	


getScore3 := map(tribCode in ['ex01','ex11','ex12','ex39'] => Models.FD5603_2_0(clam2, true),
			  tribCode = 'ex40' => Models.FD5603_3_0(clam2, true),
			  tribCode = 'ex90' => Models.FD5603_1_0(clam2, true),
			  tribCode in ['ex91','ex94'] => Models.FD9603_1_0(clam2, true),
				tribCode in ['ex95'] => Models.FP5812_1_0(clam2, 4, true),
			  tribcode = '2x01' => Models.FD9606_0_0(clam2, ungroup(easi_census_st), true),
			  dataset([],Models.Layout_ModelOut));


working_layout addSTmodel(withBTmodel le, getScore3 ri) := TRANSFORM
	self.score3 := if(tribCode in ['ex40','ex91','ex94','ex95'], '0' + ri.score, ri.score);
	self.reason13 := ri.ri[1].hri;
	self.reason23 := ri.ri[2].hri;
	self.reason33 := ri.ri[3].hri;
	self.reason43 := ri.ri[4].hri;
	
	self.score4 := if(tribCode = 'ex39' and (integer)ri.score <= 40, '', le.score4);
	self.reason14 := if(tribCode = 'ex39' and (integer)ri.score <= 40, '', le.reason14); 
	self.reason24 := if(tribCode = 'ex39' and (integer)ri.score <= 40, '', le.reason24);
	self.reason34 := if(tribCode = 'ex39' and (integer)ri.score <= 40, '', le.reason34);
	self.reason44 := if(tribCode = 'ex39' and (integer)ri.score <= 40, '', le.reason44);
								   
	self := le;
END;
withSTmodel := join(withBTmodel, getScore3, (left.seq*2)+1 = right.seq, addSTmodel(left, right), left outer);

Layout_SC1O_4_royalties := RECORD
	RiskWise.Layout_SC1O;
	Layout_for_Royalties;
END;
	
Layout_SC1O_4_royalties format_output(withSTmodel le) := TRANSFORM
	self.account := le.account;
	self.acctno := le.acctno;
	self.riskwiseid := le.riskwiseid;
	self.score := if(le.doOutput,le.score,'');
	self.reason11 := if(le.doOutput,le.reason11, '');
	self.reason21 := if(le.doOutput,le.reason21, '');
	self.reason31 := if(le.doOutput,le.reason31, '');
	self.reason41 := if(le.doOutput,le.reason41, '');
	self.score2 := if(le.doOutput,le.score2, '');
	self.reason12 := if(le.doOutput,le.reason12, '');
	self.reason22 := if(le.doOutput,le.reason22, '');
	self.reason32 := if(le.doOutput,le.reason32, '');
	self.reason42 := if(le.doOutput,le.reason42, '');
	self.score3 := if(le.doOutput2,le.score3, '');
	self.reason13 := if(le.doOutput2,le.reason13, '');
	self.reason23 := if(le.doOutput2,le.reason23, '');
	self.reason33 := if(le.doOutput2,le.reason33, '');
	self.reason43 := if(le.doOutput2,le.reason43, '');
	self.score4 := if(le.doOutput2,le.score4, '');
	self.reason14 := if(le.doOutput2,le.reason14, '');
	self.reason24 := if(le.doOutput2,le.reason24, '');
	self.reason34 := if(le.doOutput2,le.reason34, '');
	self.reason44 := if(le.doOutput2,le.reason44, '');
	self.reserved := if(le.doOutput,le.reserved, '');
	self.billing := if(le.doOutput,le.billing, dataset([],Risk_Indicators.Layout_Billing));
	self.TargusType := le.TargusType;
	self.src := le.src;
	self.TargusGatewayUsed := le.TargusGatewayUsed;
END;
final := project(withSTmodel, format_output(left));

return final;

END;