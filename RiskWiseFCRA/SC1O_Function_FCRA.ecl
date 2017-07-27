import ut, address, Risk_Indicators, Models, RiskWise, gateway;

export SC1O_Function_FCRA(dataset(RiskWise.Layout_SD1I) indata, dataset(Gateway.Layouts.Config) gateways, 
unsigned1 glb, unsigned1 dppa, string4 tribCode,
string50 DataRestriction=risk_indicators.iid_constants.default_DataRestriction,
string50 DataPermission=risk_indicators.iid_constants.default_DataPermission, 
boolean UsePersonContext) := FUNCTION
VALIDATING := FALSE;

Risk_Indicators.Layout_BocaShell_BtSt_In into_btst_in(indata le) := TRANSFORM
	// Clean BillTo
	clean_a := Risk_Indicators.MOD_AddressClean.clean_addr(le.addr, le.city, le.state, le.zip);
	
	ssn_val := RiskWise.cleanSSN( le.socs );
	hphone_val := RiskWise.cleanPhone( le.hphone );
	wphone_val := RiskWise.cleanPhone( le.wphone );
	dob_val := riskwise.cleanDOB(le.dob);
	dl_num_clean := RiskWise.cleanDL_num( le.drlc );
	
	self.seq := le.seq;
	self.Bill_To_In.historydate := le.historydate;
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
	hphone_val2 := RiskWise.cleanPhone( le.hphone2 );
	wphone_val2 := RiskWise.cleanPhone( le.wphone2 );
	dob_val2 := riskwise.cleanDOB( le.dob2 );
	dl_num_clean2 := RiskWise.cleanDL_num( le.drlc2 );

	self.Ship_To_In.seq := le.seq;
	self.Ship_To_In.historydate := le.historydate;
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

include_relatives := false;
include_derogs := tribcode != 'ex31'; // don't include derogs for ex31 (for efficiency)

bsVersion := map(
	tribcode in ['2x70','2x71','2x66'] => 3,
	tribcode in ['2x12','2x59','2x67','2x68','2x69'] => 2,
	1
);
Req2elements := (tribcode not in ['2x67','2x69','2x70','2x71']);
excludewatchlists := (tribcode in ['2x71']);

check2x := trim(tribcode)[1..2] = '2x';	// set reason code 36 in position 2 for these potentially

clamBTST := Risk_Indicators.BocaShell_BtSt_Function_FCRA(prep, gateways, dppa, glb, false, false, Req2elements, include_relatives, false, false, include_derogs, BSVersion,DataRestriction:=DataRestriction, excludewatchlists:=excludewatchlists,DataPermission:=DataPermission);


Risk_Indicators.Layout_Boca_Shell into_modelinput(clamBTST le, integer i) := TRANSFORM
	self := if(i=1, le.bill_to_out, le.ship_to_out);
END;
clam := project(clamBTST, into_modelinput(left,1));
clam2 := project(clamBTST, into_modelinput(left,2));



#IF (VALIDATING)
final := models.RVA1008_2_0(ungroup(clam),false);
#ELSE

// intermediate results
working_layout := RECORD
	RiskWise.Layout_SC1O;
	unsigned4 seq;
	boolean inCalif := false;
	boolean inCalif2 := false;
	boolean doOutput := false;
	boolean doOutput2 := false; 
END;



working_layout fill_output(clamBTST le, indata ri) := TRANSFORM
	self.doOutput := if(ri.first='' and ri.last='' and ri.addr='' and ri.socs='' and ri.dob='' and ri.hphone='' and ri.wphone='', false, true);
	self.doOutput2 := if(ri.first2='' and ri.last2='' and ri.addr2='' and ri.socs2='' and ri.dob2='' and ri.hphone2='' and ri.wphone2='', false, true);
						
	self.inCalif := ri.apptypeflag='4' and ((integer)(boolean)le.bill_to_out.iid.combo_firstcount+(integer)(boolean)le.bill_to_out.iid.combo_lastcount+
									(integer)(boolean)le.bill_to_out.iid.combo_addrcount+(integer)(boolean)le.bill_to_out.iid.combo_hphonecount+
									(integer)(boolean)le.bill_to_out.iid.combo_ssncount+(integer)(boolean)le.bill_to_out.iid.combo_dobcount)<3;
	
	self.seq := le.bill_to_out.seq;
	self.account := ri.account;
	self.acctno := ri.acctno;
	self.riskwiseid := (string)le.bill_to_out.did;
	
	self.score2 := if(self.inCalif and tribcode not in ['ex31','2x66'], '000', '');
	self.reason12 := if(tribcode IN ['ex26'] and self.inCalif, '35', '');

// do second dataset
	self.inCalif2 := ri.apptypeflag2 = '4' and ((integer)(boolean)le.ship_to_out.iid.combo_firstcount+(integer)(boolean)le.ship_to_out.iid.combo_lastcount+
									    (integer)(boolean)le.ship_to_out.iid.combo_addrcount+(integer)(boolean)le.ship_to_out.iid.combo_hphonecount+
									    (integer)(boolean)le.ship_to_out.iid.combo_ssncount+(integer)(boolean)le.ship_to_out.iid.combo_dobcount)<3;

	self.score4 := if(self.inCalif2 and tribcode not in ['2x66'], '000', '');
	self.reason14 := if(tribcode IN ['ex26'] and self.inCalif2, '35', '');
				    
	// Per Bug 58288 - EQ99 logging in no longer necessary, removing.
	self.billing := dataset([],risk_indicators.Layout_Billing);   
	    
	self := [];
END;
mapped_results := join(clamBTST, indata, left.bill_to_out.seq = (right.seq*2), fill_output(left,right), left outer);



// soapcall the non-fcra model service
gateway := gateways(servicename IN riskwisefcra.Neutral_Service_Name)[1].url;

inrec := RECORD
	dataset(Risk_Indicators.Layout_CIID_BtSt_In) batch_in;
	string tribCode := '';
END;

Risk_Indicators.Layout_CIID_BtSt_In intoCIID(prep le) := TRANSFORM
	self.bill_to_in := le.bill_to_in;
	self.ship_to_in := le.ship_to_in;
END;
prep2 := project(prep, intoCIID(left));

prep3 := dataset([{prep2, tribCode}], inrec);

errx := RECORD
	string errorcode := '';
	Models.Layout_ModelOut;
END;
errx err_out(prep3 le) := TRANSFORM
	self.errorcode := FAILCODE + FAILMESSAGE;
	self.seq := le.batch_in[1].bill_to_in.seq;
	self := [];
END;

// this soapcall runs clam/clam2 through fd5603.1.0 (ex73, ex80), fd9510.0.0 (various 2x products), or fd5067.1.0 (everything else)
FD5607 := soapcall (prep3, gateway, 'Models.FD_NonFCRA_Service',
					 {prep3}, dataset(errx), onfail(err_out(LEFT)),
					 timeout(1), retry(1));					 

Models.Layout_ModelOut intoEach(FD5607 le, integer i) := TRANSFORM
	self.seq := if(i = 1, le.seq, SKIP);
	self := le;
END;
FD5607a := project(FD5607, intoEach(left,1));

Models.Layout_ModelOut intoEach2(FD5607 le, integer i) := TRANSFORM
	self.seq := if(i = 2, le.seq, SKIP);
	self := le;
END;
FD5607b := project(FD5607, intoEach2(left,2));




getScore := map(tribCode in ['ex17','ex18','ex19','ex73','ex80','2x17','2x18','2x19','2x20'] => FD5607a,
				tribCode = 'ex31' => Models.FD5609_1_0(clam, true, mapped_results[1].inCalif),
				dataset([],Models.Layout_ModelOut));
			 
		

working_layout addBTmodel(mapped_results le, getScore ri) := TRANSFORM
	self.score := ri.score;
	self.reason11 := if(tribCode = 'ex31' and Risk_Indicators.rcSet.isCode36(ri.ri[1].hri), '36', ri.ri[1].hri);
	self.reason21 := ri.ri[2].hri;
	self.reason31 := ri.ri[3].hri;
	self.reason41 := ri.ri[4].hri;
	
	self := le;
END;
withBTmodel := join(mapped_results, getScore, left.seq=right.seq, addBTmodel(left,right), left outer);


getScore2 := map(
	tribcode in ['ex13','ex63','ex64','ex73'] => Models.TBD605_0_0(clam,  true, mapped_results[1].inCalif),
	tribcode = 'ex14' => Models.AWD606_1_0(clam,  true, mapped_results[1].inCalif, ex14 := true),  
	tribcode = 'ex44' => Models.AWD710_1_0(clam,  true, mapped_results[1].inCalif),  
	tribcode = 'ex15' => Models.AID607_2_0(clam,  true, mapped_results[1].inCalif),
	tribcode in ['ex17','ex47'] => Models.TRD609_1_0(clam,  true, mapped_results[1].inCalif),
	tribcode = 'ex18' => Models.AWD606_2_0(clam,  true, mapped_results[1].inCalif),
	tribcode in ['ex19','ex30'] => Models.AID606_0_0(clam,  true, mapped_results[1].inCalif),
	tribcode = 'ex23' => Models.AWD606_3_0(clam,  true, mapped_results[1].inCalif),
	tribcode = 'ex25' => Models.AID607_1_0(clam,  true, mapped_results[1].inCalif),
	tribcode in ['ex80','ex89'] => Models.TRD605_0_0(clam,  true, mapped_results[1].inCalif),
	tribcode = 'ex26' => Models.AWD606_10_0(clam,  true, false),	// do not consider this inCalif
	tribcode = 'sc63' => Models.TBD609_2_0(clam,  false, mapped_results[1].inCalif),
	tribcode = 'sc64' => Models.AID606_1_0(clam,  true, mapped_results[1].inCalif),
	tribcode in ['2x13','2x17'] => ungroup(Models.RVB609_0_0(clam,  mapped_results[1].inCalif)),
	tribcode in ['2x14','2x18'] => ungroup(Models.RVT612_0(clam,  mapped_results[1].inCalif)),
	tribcode in ['2x15','2x19'] => ungroup(Models.RVA611_0_0(clam,  mapped_results[1].inCalif)),
	tribcode in ['2x16','2x20'] => ungroup(Models.RVR611_0_0(clam,  mapped_results[1].inCalif)),
	tribcode = '2x59' => ungroup(Models.RVA709_1_0(clam,  mapped_results[1].inCalif)),
	tribcode = '2x66' => ungroup(Models.RVA1008_2_0(ungroup(clam), mapped_results[1].inCalif)),
	tribcode = '2x12' => ungroup(Models.RVA707_0_0(clam,  mapped_results[1].inCalif )),
	tribcode = '2x67' => ungroup(Models.RVR711_0_0(clam,  mapped_results[1].inCalif, true)),
	tribcode = '2x68' => ungroup(Models.RVT803_1_0(clam,  mapped_results[1].inCalif)),
	tribcode = '2x69' => ungroup(Models.RVT809_1_0(clam,  mapped_results[1].inCalif, true)),
	tribcode = '2x70' => ungroup(Models.RVT1006_1_0(clam, mapped_results[1].inCalif, false)),
	tribcode = '2x71' => ungroup(Models.RVR1003_0_0(clam, mapped_results[1].inCalif, useRVReasons1:=true)),
	dataset([],Models.Layout_ModelOut)
);



working_layout addBTmodel2(withBTmodel le, getScore2 ri) := TRANSFORM
	override_set := ['101','102','103','104','105'];
	
	btset := ['ex13','ex14','ex44','ex15','ex17','ex18','ex19','ex23','ex25','ex26','ex30','ex47','ex63','ex64','ex73','ex80','ex89','sc63','sc64','2x12','2x13','2x14','2x15','2x16','2x17','2x18','2x19','2x20','2x59','2x66','2x67','2x68','2x69','2x70','2x71'];
				
	self.score2 := if(tribcode in btset and (le.score2 = '' or ri.score in override_set ), 
						if(tribcode = 'ex64' and ri.score not in override_set, (string)((integer)ri.score + 20), ri.score),
						le.score2
					);
	
	self.reason12 := map(tribcode = 'ex26' and le.reason12 = '35' => '35',
					 tribcode in btset => if(Risk_Indicators.rcSet.isCode36(ri.ri[1].hri), '36', ri.ri[1].hri), 
					 le.reason12);
	self.reason22 := map(tribcode = 'ex26' and le.reason12 = '35' => if(Risk_Indicators.rcSet.isCode36(ri.ri[1].hri), '36', ri.ri[1].hri),
							check2x => if(Risk_Indicators.rcset.isCode36(ri.ri[2].hri) and not risk_indicators.rcSet.isCode36(ri.ri[1].hri),'36', ri.ri[2].hri ),
				      tribcode in btset => ri.ri[2].hri,
							le.reason22);
	self.reason32 := map(tribcode = 'ex26' and le.reason12 = '35' => if(self.reason22 = '36', ri.ri[1].hri, ri.ri[2].hri),
					 tribcode in btset => ri.ri[3].hri,    
				      le.reason32);
	self.reason42 := map(tribcode = 'ex26' and le.reason12 = '35' => if(self.reason22 = '36', ri.ri[2].hri, ri.ri[3].hri),
					 tribcode in btset => ri.ri[4].hri,  
				      le.reason42);
					 
	self := le;
END;
withBTmodel2 := join(withBTmodel, getScore2, left.seq=right.seq, addBTmodel2(left,right), left outer);



								
getScore3 := map(
				tribCode in ['ex17','ex18','ex19','ex73','ex80','2x17','2x18','2x19','2x20'] => FD5607b,
				tribCode = 'ex31' => Models.FD5609_1_0(clam2,  true, mapped_results[1].inCalif2),
				dataset([],Models.Layout_ModelOut));




working_layout addSTmodel(withBTmodel2 le, getScore3 ri) := TRANSFORM
	self.score3 := ri.score;
	self.reason13 := if(tribCode = 'ex31' and Risk_Indicators.rcSet.isCode36(ri.ri[1].hri), '36', ri.ri[1].hri);
	self.reason23 := ri.ri[2].hri;
	self.reason33 := ri.ri[3].hri;
	self.reason43 := ri.ri[4].hri;
								   
	self := le;
END;
withSTmodel := join(withBTmodel2, getScore3, (left.seq+1) = right.seq, addSTmodel(left,right), left outer);


getScore4 := map(
	tribcode in ['ex13','ex63','ex64','ex73'] => Models.TBD605_0_0(clam2,  true, mapped_results[1].inCalif2),
	tribcode = 'ex14' => Models.AWD606_1_0(clam2,  true, mapped_results[1].inCalif2),  
	tribcode = 'ex44' => Models.AWD710_1_0(clam2,  true, mapped_results[1].inCalif2),  
	tribcode = 'ex15' => Models.AID607_2_0(clam2,  true, mapped_results[1].inCalif2),
	tribcode in ['ex17','ex47'] => Models.TRD609_1_0(clam2,  true, mapped_results[1].inCalif2),
	tribcode = 'ex18' => Models.AWD606_2_0(clam2,  true, mapped_results[1].inCalif2),
	tribcode in ['ex19','ex30'] => Models.AID606_0_0(clam2,  true, mapped_results[1].inCalif2),
	tribcode = 'ex23' => Models.AWD606_3_0(clam2,  true, mapped_results[1].inCalif2),
	tribcode = 'ex25' => Models.AID607_1_0(clam2,  true, mapped_results[1].inCalif2),
	tribcode in ['ex80','ex89'] => Models.TRD605_0_0(clam2,  true, mapped_results[1].inCalif2),
	tribcode = 'ex26' => Models.AWD606_10_0(clam2,  true, false),	// do not consider this inCalif
	tribcode = 'sc63' => Models.TBD609_2_0(clam2,  false, mapped_results[1].inCalif2),
	tribcode = 'sc64' => Models.AID606_1_0(clam2,  true, mapped_results[1].inCalif2),
	tribcode in ['2x13','2x17'] => ungroup(Models.RVB609_0_0(clam2,  mapped_results[1].inCalif2)),
	tribcode in ['2x14','2x18'] => ungroup(Models.RVT612_0(clam2,  mapped_results[1].inCalif2)),
	tribcode in ['2x15','2x19'] => ungroup(Models.RVA611_0_0(clam2,  mapped_results[1].inCalif2)),
	tribcode in ['2x16','2x20'] => ungroup(Models.RVR611_0_0(clam2,  mapped_results[1].inCalif2)),
	tribcode = '2x59' => ungroup(Models.RVA709_1_0(clam2,  mapped_results[1].inCalif2)),
	tribcode = '2x66' => ungroup(Models.RVA1008_2_0(ungroup(clam2),  mapped_results[1].inCalif2)),
	tribcode = '2x12' => ungroup(Models.RVA707_0_0(clam2,  mapped_results[1].inCalif2)),
	tribcode = '2x67' => ungroup(Models.RVR711_0_0(clam2,  mapped_results[1].inCalif2, true)),
	tribcode = '2x68' => ungroup(Models.RVT803_1_0(clam2,  mapped_results[1].inCalif2)),
	tribcode = '2x69' => ungroup(Models.RVT809_1_0(clam2,  mapped_results[1].inCalif2, true)),
	tribcode = '2x70' => ungroup(Models.RVT1006_1_0(clam2, mapped_results[1].inCalif2, false)),
	tribcode = '2x71' => ungroup(Models.RVR1003_0_0(clam2, mapped_results[1].inCalif2, useRVReasons1:=true)),

	dataset([],Models.Layout_ModelOut)
);




working_layout addSTmodel2(withSTmodel le, getScore4 ri) := TRANSFORM
	override_set := ['101','102','103','104','105'];
	
	stset := ['ex13','ex14','ex44','ex15','ex17','ex18','ex19','ex25','ex26','ex30','ex47','ex63','ex64','ex73','ex80','ex89','sc63','sc64','2x12','2x13','2x14','2x15','2x16','2x17','2x18','2x19','2x20','2x59','2x66','2x67','2x68','2x69','2x70','2x71'];

	self.score4 := if(tribcode in stset and (le.score4 = '' or ri.score in override_set), 
						if(tribcode = 'ex64' and ri.score not in override_set, (string)((integer)ri.score + 20), ri.score),
						le.score4
					);
	
	self.reason14 := map(tribcode = 'ex26' and le.reason14 = '35' => '35',
					 tribcode in stset => if(Risk_Indicators.rcSet.isCode36(ri.ri[1].hri), '36', ri.ri[1].hri),				 
					 le.reason14);
	self.reason24 := map(tribcode = 'ex26' and le.reason14 = '35' => if(Risk_Indicators.rcSet.isCode36(ri.ri[1].hri), '36', ri.ri[1].hri),
					 check2x => if(Risk_Indicators.rcset.isCode36(ri.ri[2].hri) and not risk_indicators.rcSet.isCode36(ri.ri[1].hri), '36', ri.ri[2].hri ),
					 tribcode in stset => ri.ri[2].hri,    
					 le.reason24);
	self.reason34 := map(tribcode = 'ex26' and le.reason14 = '35' => if(self.reason24 = '36', ri.ri[1].hri, ri.ri[2].hri),
					 tribcode in stset => ri.ri[3].hri,			      
				      le.reason34);
	self.reason44 := map(tribcode = 'ex26' and le.reason14 = '35' => if(self.reason24 = '36', ri.ri[2].hri, ri.ri[3].hri),
					 tribcode in stset => ri.ri[4].hri,				      
				      le.reason44);

					 
	self := le;
END;
withSTmodel2 := join(withSTmodel, getScore4, (left.seq+1) = right.seq, addSTmodel2(left,right), left outer);

	
RiskWise.Layout_SC1O format_output(withSTmodel2 le) := TRANSFORM
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
END;
final := project(withSTmodel2, format_output(left));
#end;
return final;

END;