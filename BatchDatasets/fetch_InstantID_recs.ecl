
IMPORT BatchShare, address, iesp, risk_indicators, riskwise, ut, gateway;

EXPORT fetch_InstantID_recs( DATASET(BatchDatasets.Layouts.layout_batch_in_waddr_status) ds_batch_in, BatchShare.IParam.BatchParams in_mod ) :=
	FUNCTION	
		// Constants to run CIID process
		boolean Ofac_Only                 := false;
		boolean isPOBoxCompliant          := false;
		unsigned3 history_date            := 999999;
		boolean ExclWatchLists            := false;
		integer ofac_version              := 2;
		boolean incl_addl_watchlists      := false;
		boolean incl_ofac                 := false;
		real Global_WatchList_Threshold   := .84;
		integer2 dob_radius_use           := -1; 
		boolean ln_branded_value          := false;
		boolean suppressNearDups          := false;
		boolean require2ele               := false;
		boolean fromBiid                  := false;
		boolean isFCRA                    := false;
		boolean in_from_IT1O              := false;
		boolean runSSNCodes               := true;
		boolean runBestAddrCheck          := true;
		boolean runChronoPhoneLookup      := true;
		boolean runAreaCodeSplitSearch    := true;
		integer bsversion                 := 2;       // always use shell version 2 now
		boolean allowCellPhones           := false;
		string10 ExactMatchLevel          := '00000000';
		string CustomDataFilter           := '';      // this only for Phillip Morris in Identifier2
		unsigned2 EverOccupant_PastMonths := 0;	      // for identifier2
		unsigned4 EverOccupant_StartDate  := 99999999;	// for identifier2
		unsigned1 AppendBest              := 1;		    // search best file
		boolean IncludeDLverification     := false;
			// DOB options
		string15  DOBMatchType            := 'FuzzyCCYYMMDD';
		unsigned1 DOBMatchYearRadius      := 0;
		DOBMatchOptions                   := dataset([{DOBMatchType, DOBMatchYearRadius}], risk_indicators.layouts.Layout_DOB_Match_Options);
		watchlists_request                := dataset([], iesp.share.t_StringArrayItem);
		
		// Per product requirements, no gateways.
		gateways_in := Gateway.Constants.void_gateway;

		risk_indicators.Layout_Input into(Layouts.layout_batch_in_waddr_status le) := 
			transform
				dob_val        := riskwise.cleandob(le.dob);
				street_address := address.Addr1FromComponents(le.prim_range, le.predir, le.prim_name, le.addr_suffix, le.postdir, le.unit_desig, le.sec_range);	

				self.seq              := (unsigned4)le.acctno;
				self.historydate      := history_date;
				self.title            := '';        
				self.fname            := le.name_first;
				self.lname            := le.name_last;
				self.mname            := le.name_middle;
				self.suffix           := le.name_suffix;	   
				self.in_streetAddress := street_address;
				self.in_city          := le.p_city_name;
				self.in_state         := le.st;
				self.in_zipCode       := le.z5; 
				self.addr_type        := risk_indicators.iid_constants.override_addr_type(street_address, '', '');
				self.ssn              := if( le.ssn = '000000000', '', le.ssn ); // blank out social if it is all 0's
				self.dob              := dob_val;
				self.age              := if ( (integer)dob_val != 0, (string3)ut.Age((integer)dob_val), '' );       
				self.dl_number        := '';
				self.dl_state         := '';
				self.ip_address       := '';
				self.phone10          := '';
				self.wphone10         := '';       
				self                  := le;
				self                  := [];
			end;

		prep := PROJECT(ds_batch_in,into(LEFT));
		
		ciid_recs := 
				risk_indicators.InstantID_Function(prep, gateways_in, in_mod.DPPAPurpose, in_mod.GLBPurpose, 
				in_mod.industryclass='UTILI', ln_branded_value, ofac_only, suppressNearDups, require2ele, 
				fromBiid, isFCRA, ExclWatchLists, in_from_IT1O, ofac_version, incl_ofac, incl_addl_watchlists, 
				Global_WatchList_Threshold, dob_radius_use, bsversion, runSSNCodes, runBestAddrCheck, 
				runChronoPhoneLookup, runAreaCodeSplitSearch, allowCellPhones, ExactMatchLevel, 
				in_mod.DataRestrictionMask, CustomDataFilter, IncludeDLverification, watchlists_request, 
				DOBMatchOptions, EverOccupant_PastMonths, EverOccupant_StartDate, AppendBest);
		
		RETURN ciid_recs;
	END;