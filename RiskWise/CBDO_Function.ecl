import ut, Risk_Indicators, Models, gateway, STD;

export CBDO_Function(DATASET(Layout_CBDI) indata, dataset(Gateway.Layouts.Config) gateways, unsigned1 glb, unsigned1 dppa, 
			string50 DataRestriction=risk_indicators.iid_constants.default_DataRestriction,
			string50 DataPermission=risk_indicators.iid_constants.default_DataPermission,
            unsigned1 LexIdSourceOptout = 1,
            string TransactionID = '',
            string BatchUID = '',
            unsigned6 GlobalCompanyId = 0) := function


risk_indicators.Layout_CIID_BtSt_In into_btst_in(indata le) := transform
	// Clean BillTo					
	clean_a := risk_indicators.MOD_AddressClean.clean_addr(le.addr, le.City, le.State, le.Zip ) ;
	
	ssn_val := cleanSSN( le.socs );
	hphone_val := cleanPhone( le.hphone );
	wphone_val := cleanPhone( le.wphone );
	dob_val := cleanDOB(le.dob);
	
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
	self.Bill_To_In.email_address	:= le.email;
	self.Bill_To_In.phone10 := hphone_val;
	self.Bill_To_In.wphone10 := wphone_val;
	self.Bill_To_In.employer_name := STD.Str.touppercase(le.cmpy);
	
	// Clean ShipTo
	clean_a2 := risk_indicators.MOD_AddressClean.clean_addr(le.addr2, le.city2, le.State2, le.Zip2 ) ;	

	ssn_val2 := cleanSSN( le.socs2 );
	hphone_val2 := cleanPhone( le.hphone2 );
	wphone_val2 := cleanPhone( le.wphone2 );
	
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
	self.Ship_To_In.zip4 := if(clean_a2[122..125]<>'', clean_a2[122..125], le.zip2[6..9]);	// use the input zip if cass zip is empty
	self.Ship_To_In.lat := clean_a2[146..155];
	self.Ship_To_In.long := clean_a2[156..166];
	self.Ship_To_In.addr_type := clean_a2[139];
	self.Ship_To_In.addr_status := clean_a2[179..182];
	self.Ship_To_In.county := clean_a2[143..145];
	self.Ship_To_In.geo_blk := clean_a2[171..177];
	self.Ship_To_In.ssn	:= ssn_val2;
	self.Ship_To_In.phone10 := hphone_val2;
	self.Ship_To_In.wphone10 := wphone_val2;
	self.Ship_To_In.employer_name := STD.Str.touppercase(le.cmpy2);	
	
	self := [];
end;
prep := project(indata,into_btst_in(LEFT));

iid_results := risk_indicators.InstantId_BtSt_Function(prep,gateways,dppa,glb,false,false, true, true, true,dataRestriction:=DataRestriction, dataPermission:=DataPermission,
                                                                                            LexIdSourceOptout := LexIdSourceOptout, 
                                                                                            TransactionID := TransactionID, 
                                                                                            BatchUID := BatchUID, 
                                                                                            GlobalCompanyID := GlobalCompanyID);

													// turned off the dl and vehicle searching, not used in this model
getBS := Risk_Indicators.BocaShell_BtSt_Function(iid_results, gateways, dppa, glb, false, false, true, false, false, true,dataRestriction:=DataRestriction, dataPermission:=DataPermission,
                                                                                          LexIdSourceOptout := LexIdSourceOptout, 
                                                                                          TransactionID := TransactionID, 
                                                                                          BatchUID := BatchUID, 
                                                                                          GlobalCompanyID := GlobalCompanyID);	


getScore := Models.CDN604_2_0(getBS, true);	


Layout_CBDO addBTmodel(getScore le, indata ri) := transform
	self.account := ri.account;
	self.acctno := ri.acctno;
	self.riskwiseid := '';
	self.frdriskscore := le.score;
	self.reason1 := le.ri[1].hri;
	self.reason2 := le.ri[2].hri;
	self.reason3 := le.ri[3].hri;
	self.reason4 := le.ri[4].hri;
	self.reason5 := le.ri[5].hri;
	self.reason6 := le.ri[6].hri;
end;
final := JOIN(getScore, indata, left.seq = (right.seq*2), addBTmodel(left, right), left outer);

return final;

END;