import risk_indicators, riskwise, gateway, STD, Models;

export ChargebackDefender_Function(
	DATASET(Models.Layout_Chargeback_In) indata,
	dataset(Gateway.Layouts.Config) gateways,
	unsigned1 glb,
	unsigned1 dppa,
	boolean ipid_only,
	string50 DataRestriction = risk_indicators.iid_constants.default_DataRestriction,
	boolean ofac_only,
	boolean suppressneardups,
	boolean require2Ele,
	unsigned1 bsVersion, 
	string50 DataPermission = risk_indicators.iid_constants.default_DataPermission,
	unsigned8 BSOptions = 0,
    unsigned1 LexIdSourceOptout = 1,
    string TransactionID = '',
    string BatchUID = '',
    unsigned6 GlobalCompanyId = 0
) := FUNCTION	


	Risk_Indicators.Layout_CIID_BtSt_In into_btst_in(indata le) := TRANSFORM
		// Clean BillTo
	  clean_a := Risk_Indicators.MOD_AddressClean.clean_addr(le.addr, le.city, le.state, le.zip);			
		
		dl_num_clean := RiskWise.cleanDL_num( le.drlc );
		self.Bill_To_In.historydate := le.historydate;
		self.Bill_To_In.historyDateTimeStamp := le.historydateTimeStamp;
	
		self.Bill_To_In.seq := le.seq;
		self.Bill_To_In.fname := STD.Str.toUpperCase(le.first);
		self.Bill_To_In.mname := STD.Str.toUpperCase(le.middle);
		self.Bill_To_In.lname := STD.Str.toUpperCase(le.last);
		self.Bill_To_In.suffix := STD.Str.toUpperCase(le.suffix);
		self.Bill_To_In.in_streetAddress := STD.Str.toUpperCase(le.addr);
		self.Bill_To_In.in_city := STD.Str.toUpperCase(le.city);
		self.Bill_To_In.in_state := STD.Str.toUpperCase(le.state);
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
		self.Bill_To_In.dl_number := STD.Str.toUpperCase(dl_num_clean);
		self.Bill_To_In.dl_state := STD.Str.toUpperCase(le.drlcstate);
		self.Bill_To_In.email_address	:= STD.Str.toUpperCase(le.email);
		self.Bill_To_In.phone10 := le.hphone;
		self.Bill_To_In.ssn := le.socs; 
		// self.Bill_To_In.employer_name := STD.Str.toUpperCase(le.cmpy);
		self.bill_to_in.ip_address := le.ipaddr;
		self.bill_to_in.dob := le.dob;	
		self.bill_to_in.TypeOfOrder := le.TypeOfOrder;
		// Clean ShipTo
	  clean_a2 := Risk_Indicators.MOD_AddressClean.clean_addr(le.addr2, le.city2, le.state2, le.zip2);			
				
		self.Ship_To_In.seq := le.seq;
		self.Ship_To_In.historydate := le.historydate;
		self.Ship_To_In.historyDateTimeStamp := le.historydateTimeStamp;
	
		self.Ship_To_In.fname := STD.Str.toUpperCase(le.first2);
		self.Ship_To_In.mname := STD.Str.toUpperCase(le.middle2);
		self.Ship_To_In.lname := STD.Str.toUpperCase(le.last2);
		self.Ship_To_In.suffix := STD.Str.toUpperCase(le.suffix2);
		self.Ship_To_In.in_streetAddress := STD.Str.toUpperCase(le.addr2);
		self.Ship_To_In.in_city := STD.Str.toUpperCase(le.city2);
		self.Ship_To_In.in_state := STD.Str.toUpperCase(le.state2);
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
		self.Ship_To_In.phone10 := le.hphone2;
		self.Ship_To_In.ssn := le.socs2; 
		// self.Ship_To_In.employer_name := STD.Str.toUpperCase(le.cmpy2);	
		//CBD5.0
		dl_num_clean2 := RiskWise.cleanDL_num( le.drlc2 );	
		self.Ship_To_In.dl_number := STD.Str.toUpperCase(dl_num_clean2);
		self.Ship_To_In.dl_state := STD.Str.toUpperCase(le.drlcstate2);
		self.Ship_To_In.dob := le.dob2;
		self.Ship_To_In.email_address	:= STD.Str.toUpperCase(le.email2);
		self := [];
	END;
	prep := project(indata,into_btst_in(LEFT));

	isUtility        := false;
	ln_branded       := false;
		
	
	iid_results := risk_indicators.InstantId_BtSt_Function(
		prep, 
		gateways,
		dppa,
		glb,
		isUtility,
		ln_branded,
		ofac_only,
		suppressNeardups,
		require2Ele,
		bsversion:=bsversion,
		dataRestriction:=DataRestriction,
		dataPermission:=DataPermission,
        LexIdSourceOptout := LexIdSourceOptout, 
        TransactionID := TransactionID, 
        BatchUID := BatchUID, 
        GlobalCompanyID := GlobalCompanyID
	);
	// output(prep_info, named('prep_info'));
	 //output(iid_results, named('iid_results'));

	return iid_results;

END;
