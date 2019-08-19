IMPORT Gateway, Risk_Indicators, STD;

EXPORT FraudAdvisor_BtSt_Function( DATASET(Risk_Indicators.layout_input) indata1,
			DATASET(Risk_Indicators.layout_input) indata2,
			DATASET(Gateway.Layouts.Config) gateways,
			unsigned1 dppa, 
			unsigned1 glb, 
			boolean isUtility = false, 
			boolean ln_branded = false, 
			boolean ofac_only = true,
			BOOLEAN suppressNearDups=false, 
			boolean require2Ele = false,
			boolean from_BIID = false, 
			boolean isFCRA = false, 
			boolean ExcludeWatchLists = false, 
			boolean from_IT1O = false, 
			unsigned1 ofac_version = 1,
			boolean include_ofac = FALSE, 
			boolean include_additional_watchlists = false, 
			real global_watchlist_threshold = .84,
			integer2 dob_radius = -1, 
			unsigned1 BSversion = 1,
			string50 DataRestriction = risk_indicators.iid_constants.default_DataRestriction,
			boolean runDLverification = false,
			string50 DataPermission = risk_indicators.iid_constants.default_DataPermission,
			boolean includeRelativeInfo = true, 
			boolean includeDLInfo = true, 
			boolean includeVehInfo = true,
			boolean includeDerogInfo = true, 
			boolean doScore = false, 
			boolean nugen = false,
			unsigned8 BSOptions = 0,
            unsigned1 LexIdSourceOptout = 1,
            string TransactionID = '',
            string BatchUID = '',
            unsigned6 GlobalCompanyId = 0
	) := FUNCTION

	Risk_Indicators.Layout_CIID_BtSt_In into_btst_in(Risk_Indicators.layout_input le, Risk_Indicators.layout_input ri) := 
		TRANSFORM
			// BillTo is already cleaned in FraudAdvisor_Service.
			self.Bill_To_In.historydate   := le.historydate;
			self.Bill_To_In.seq           := le.seq;
			self.Bill_To_In.fname         := le.fname;
			self.Bill_To_In.mname         := le.mname;
			self.Bill_To_In.lname         := le.lname;
			self.Bill_To_In.suffix        := le.suffix;
			self.Bill_To_In.in_streetAddress := STD.Str.touppercase(le.in_streetAddress);
			self.Bill_To_In.in_city       := STD.Str.touppercase(le.in_city);
			self.Bill_To_In.in_state      := STD.Str.touppercase(le.in_state);
			self.Bill_To_In.in_zipCode    := le.in_zipCode;
			self.Bill_To_In.prim_range    := le.prim_range;
			self.Bill_To_In.predir        := le.predir;
			self.Bill_To_In.prim_name     := le.prim_name;
			self.Bill_To_In.addr_suffix   := le.addr_suffix;
			self.Bill_To_In.postdir       := le.postdir;
			self.Bill_To_In.unit_desig    := le.unit_desig;
			self.Bill_To_In.sec_range     := le.sec_range;
			self.Bill_To_In.p_city_name   := le.p_city_name;
			self.Bill_To_In.st            := le.st;
			self.Bill_To_In.z5            := le.z5;
			self.Bill_To_In.zip4          := le.zip4;
			self.Bill_To_In.lat           := le.lat;
			self.Bill_To_In.long          := le.long;
			self.Bill_To_In.addr_type     := le.addr_type;
			self.Bill_To_In.addr_status   := le.addr_status;
			self.Bill_To_In.county        := le.county;
			self.Bill_To_In.geo_blk       := le.geo_blk;
			self.Bill_To_In.dl_number     := le.dl_number;
			self.Bill_To_In.dl_state      := le.dl_state;
			self.Bill_To_In.email_address	:= le.email_address;
			self.Bill_To_In.phone10       := le.phone10;
			self.Bill_To_In.ssn           := le.ssn; 
			self.Bill_To_In.dob   				:= le.dob; 
			self.bill_to_in.ip_address    := le.ip_address;
			
			// Clean ShipTo data, however.
			clean_a2 := Risk_Indicators.MOD_AddressClean.clean_addr(ri.in_streetAddress, ri.in_city, ri.in_state, ri.in_zipCode);			
					
			self.Ship_To_In.seq         := ri.seq;
			self.Ship_To_In.historydate := ri.historydate;
			self.Ship_To_In.fname       := STD.Str.touppercase(ri.fname);
			self.Ship_To_In.mname       := STD.Str.touppercase(ri.mname);
			self.Ship_To_In.lname       := STD.Str.touppercase(ri.lname);
			self.Ship_To_In.suffix      := STD.Str.touppercase(ri.suffix);
			self.Ship_To_In.in_streetAddress := STD.Str.touppercase(ri.in_streetAddress);
			self.Ship_To_In.in_city     := STD.Str.touppercase(ri.in_city);
			self.Ship_To_In.in_state    := STD.Str.touppercase(ri.in_state);
			self.Ship_To_In.in_zipCode  := ri.in_zipCode;
			self.Ship_To_In.prim_range  := clean_a2[1..10];
			self.Ship_To_In.predir      := clean_a2[11..12];
			self.Ship_To_In.prim_name   := clean_a2[13..40];
			self.Ship_To_In.addr_suffix := clean_a2[41..44];
			self.Ship_To_In.postdir     := clean_a2[45..46];
			self.Ship_To_In.unit_desig  := clean_a2[47..56];
			self.Ship_To_In.sec_range   := clean_a2[57..64];
			self.Ship_To_In.p_city_name := clean_a2[90..114];
			self.Ship_To_In.st          := clean_a2[115..116];
			self.Ship_To_In.z5          := if(clean_a2[117..121]<>'', clean_a2[117..121], ri.z5[1..5]);		// use the input zip if cass zip is empty
			self.Ship_To_In.zip4        := clean_a2[122..125];	// use the input zip if cass zip is empty
			self.Ship_To_In.lat         := clean_a2[146..155];
			self.Ship_To_In.long        := clean_a2[156..166];
			self.Ship_To_In.addr_type   := clean_a2[139];
			self.Ship_To_In.addr_status := clean_a2[179..182];
			self.Ship_To_In.county      := clean_a2[143..145];
			self.Ship_To_In.geo_blk     := clean_a2[171..177];
			self.Ship_To_In.phone10     := ri.phone10;
			self.Ship_To_In.ssn   			:= ri.ssn; 
			self.Ship_To_In.dob   			:= ri.dob; 
			self := [];
		END;
	
	prep_btst := 
		JOIN(
			indata1, indata2, 
			LEFT.seq = RIGHT.seq,
			into_btst_in(LEFT, RIGHT),
			LEFT OUTER,
			KEEP(1)
		);
	
	iid_results_btst := risk_indicators.InstantId_BtSt_Function(
		prep_btst,
		gateways,
		dppa,
		glb,
		isUtility,
		ln_branded,
		ofac_only,
		suppressNeardups,
		require2Ele,
		bsversion := BSversion,
		dataRestriction := DataRestriction,
		dataPermission := DataPermission,
        LexIdSourceOptout := LexIdSourceOptout, 
        TransactionID := TransactionID, 
        BatchUID := BatchUID, 
        GlobalCompanyID := GlobalCompanyID
	);
	
	clam_btst := Risk_Indicators.BocaShell_BtSt_Function(
		iid_results_btst,
		gateways,
		dppa,
		glb,
		isUtility,
		ln_branded,
		includeRelativeInfo,
		includeDLInfo,
		includeVehInfo,
		includeDerogInfo,
		BSversion,
		doScore, // do score
		nugen, // nugen
		DataRestriction,
		BSOptions,
		DataPermission,
        LexIdSourceOptout := LexIdSourceOptout, 
        TransactionID := TransactionID, 
        BatchUID := BatchUID, 
        GlobalCompanyID := GlobalCompanyID
	);
	
	return clam_btst;
		
END;
