		/*2015-10-22T15:34:41Z (khuls)
	C:\Users\hulske01\AppData\Roaming\HPCC Systems\eclide\khuls\New_Dataland\VerificationOfOccupancy\Search_Function\2015-10-22T15_34_41Z.ecl
	*/
	import doxie, dx_header, doxie_files, drivers, header, header_quick, Inquiry_AccLogs, LN_PropertyV2,suppress, mdr, 
	Riskwise, Risk_Indicators, ut, Gateway, VerificationOfOccupancy,address, Relationship, Std;

	EXPORT Search_Function(DATASET(VerificationOfOccupancy.Layouts.Layout_VOOIn) VOO_In, 
													string50 DataRestrictionMask, 
													integer glba,  
													integer dppa,
													boolean isUtility,
													string9 AttributesVersion,
													boolean IncludeModel,
													string50 DataPermissionMask,
													boolean IncludeReport = FALSE, 
													boolean PAR_request = FALSE,
													unsigned1 LexIdSourceOptout = 1,
													string TransactionID = '',
													string BatchUID = '',
													unsigned6 GlobalCompanyId = 0) := MODULE
		
		SHARED MOD_Access := MODULE(Doxie.IDataAccess)
			EXPORT glb := glba;
			EXPORT dppa := ^.dppa;
			EXPORT unsigned1 lexid_source_optout := LexIdSourceOptout;
			EXPORT string transaction_id := TransactionID; // esp transaction id or batch uid
			EXPORT unsigned6 global_company_id := GlobalCompanyId; // mbs gcid
		END;
																							

		SHARED isFCRA 		 := false;
		SHARED glb_ok 		 := Risk_Indicators.iid_constants.glb_ok(GLBA, isFCRA);
		SHARED dppa_ok 		 := Risk_Indicators.iid_constants.dppa_ok(DPPA, isFCRA);
		SHARED fares_ok 	 := Risk_Indicators.iid_constants.fares_ok(DataRestrictionMask, isFCRA);
		SHARED BSOptions 	 := 0;
		SHARED append_best := 0;	
		SHARED gateways    := dataset([],Gateway.Layouts.Config);
		SHARED todaysdate	 := (STRING8)Std.Date.Today();
	  SHARED VerificationOfOccupancy_CCPA := RECORD
	  VerificationOfOccupancy.Layouts.Layout_VOOShell;
	  Unsigned4 Global_sid;
	  end;

	// ********************************************************************
	// Transform VOO input to Layout_Input so we can call iid_getDID_prepOutput
	// ********************************************************************

		 SHARED Risk_Indicators.Layout_Input into(VOO_In l) := TRANSFORM
			self.did := (integer)l.LexId;
		
			self.seq := l.seq;
			
			validdate := Doxie.DOBTools((integer)l.AsOf).IsValidDOB;
			AsOfMM 		:= (integer)l.AsOf[5..6] + 1; //round to next month 
			AsOfMMrd	:= if(AsOfMM > 12, 01, AsOfMM);
			AsOfYYYY 	:= if(AsOfMM > 12, (integer)l.AsOf[1..4] + 1, (integer)l.AsOf[1..4]);
			
			self.historydate := if(not validdate, (integer)todaysdate[1..6], (AsOfYYYY * 100) + AsOfMMrd); 

			self.ssn := l.ssn;
			dob_val := riskwise.cleandob(l.dob);
			dob :=    dob_val;
			self.dob := if((unsigned)dob=0, '', dob);

			fname  :=  l.Name_First ;
			mname  :=  l.Name_Middle;
			lname  :=  l.Name_Last ;

			self.fname  := STD.Str.touppercase(fname);
			self.mname  := STD.Str.touppercase(mname);
			self.lname  := STD.Str.touppercase(lname);
			
			addr_value := trim(l.street_addr);
			
			clean_a2 := Risk_Indicators.MOD_AddressClean.clean_addr(addr_value, l.City_name, l.st, l.z5);

			self.in_streetAddress:= addr_value;
			self.in_city         := l.City_name;
			self.in_state        := l.st;
			self.in_zipCode      := l.z5;	
			self.prim_range      := Address.CleanFields(clean_a2).prim_range;
			self.predir          := Address.CleanFields(clean_a2).predir;
			self.prim_name       := Address.CleanFields(clean_a2).prim_name;
			self.addr_suffix     := Address.CleanFields(clean_a2).addr_suffix;
			self.postdir         := Address.CleanFields(clean_a2).postdir;
			self.unit_desig      := Address.CleanFields(clean_a2).unit_desig;
			self.sec_range       := Address.CleanFields(clean_a2).sec_range;
			self.p_city_name     := Address.CleanFields(clean_a2).p_city_name;
			self.st              := Address.CleanFields(clean_a2).st;
			self.z5              := Address.CleanFields(clean_a2).zip;
			self.zip4            := Address.CleanFields(clean_a2).zip4;
			self.lat             := Address.CleanFields(clean_a2).geo_lat;
			self.long            := Address.CleanFields(clean_a2).geo_long;
			self.addr_type 			 := risk_indicators.iid_constants.override_addr_type(l.street_addr, Address.CleanFields(clean_a2).rec_type[1],Address.CleanFields(clean_a2).cart);
			self.addr_status     := Address.CleanFields(clean_a2).err_stat;
			county          		 := Address.CleanFields(clean_a2).county;
			self.county          := county[3..5]; //bytes 1-2 are state code, 3-5 are county number
			self.geo_blk         := Address.CleanFields(clean_a2).geo_blk;
			self.Phone10				 := STD.Str.Filter(l.Phone10, '0123456789');
			self := [];
		END;
		SHARED iid_prep := PROJECT(VOO_In, into(left));	

	// ********************************************************************
	// Get the DID and Append the Input Account Number
	// ********************************************************************
		SHARED with_DID := JOIN(VOO_In, 
										ungroup(risk_indicators.iid_getDID_prepOutput(iid_prep, DPPA, GLBA, isFCRA, 50, DataRestrictionMask, append_best, gateways, BSOptions, mod_access)), 
										LEFT.seq = RIGHT.seq, TRANSFORM(Risk_Indicators.Layout_Output, SELF.Account := LEFT.AcctNo; SELF := RIGHT));;
		
	// ********************************************************************
	// Get all header records by DID
	// ********************************************************************

		SHARED dk := choosen(dx_header.key_max_dt_last_seen(), 1);
		SHARED hdrBuildDate01 := ((string)dk[1].max_date_last_seen)[1..6];
		
		
	// ********************************************************************************************************************************
	// This join will include header records outside of the history date so that first/last seen dates can be calculated regardless of
	// the input date (history date)
	// ********************************************************************************************************************************
		SHARED key_header := dx_header.key_header();
		SHARED VerificationOfOccupancy_CCPA getHeaderDates(Risk_Indicators.Layout_Output l, key_header r) := transform
        SELF.Global_Sid := r.Global_Sid;		
		addrmatch							:= trim(l.z5) = trim(r.zip) and
															 trim(l.prim_range) = trim(r.prim_range) and
															 ut.NNEQ(trim(l.sec_range), trim(r.sec_range)) and
															 trim(l.prim_name) = trim(r.prim_name) and
															 trim(l.addr_suffix) = trim(r.suffix) and
															 trim(l.predir) = trim(r.predir) and
															 trim(l.postdir) = trim(r.postdir);
			current 							:= trim((string)r.dt_last_seen) >= hdrBuildDate01 OR r.dt_last_seen >= l.historydate; // Need to make sure our "current" calculation still works in history mode
			self.target_addr			:= map(addrmatch and current					=> 2,		//address is target address and is currently updating
																	 addrmatch and not current			=> 1,		//address is target address but not currently updating
																																		 0);	//not target address (other address)
			self.h								:= r;
			self.AcctNo						:= l.Account;
			self.other_prox_distance  := 9999999; //initialize to 9's. This will be over-written later if subject does own other properties.
			self									:= l;
			self									:= [];
		end;
		
		SHARED VerificationOfOccupancy_CCPA getQHeaderDates(Risk_Indicators.Layout_Output l, header_quick.key_DID r) := transform
		SELF.Global_Sid := r.Global_Sid;	
		addrmatch							:= trim(l.z5) = trim(r.zip) and
															 trim(l.prim_range) = trim(r.prim_range) and
															 ut.NNEQ(trim(l.sec_range), trim(r.sec_range)) and
															 trim(l.prim_name) = trim(r.prim_name) and
															 trim(l.addr_suffix) = trim(r.suffix) and
															 trim(l.predir) = trim(r.predir) and
															 trim(l.postdir) = trim(r.postdir);
			current 							:= trim((string)r.dt_last_seen) >= hdrBuildDate01 OR r.dt_last_seen >= l.historydate; // Need to make sure our "current" calculation still works in history mode
			self.target_addr			:= map(addrmatch and current					=> 2,		//address is target address and is currently updating
																	 addrmatch and not current			=> 1,		//address is target address but not currently updating
																																		 0);	//not target address (other address)
			self.h								:= r;
			self.AcctNo						:= l.Account;
			self.other_prox_distance  := 9999999; //initialize to 9's. This will be over-written later if subject does own other properties.
			self									:= l;
			self									:= [];
		end;
		
		SHARED with_HeaderDates_unsuppressed := join(with_DID, key_header,
		
										LEFT.DID <> 0 AND
										keyed(left.DID = right.s_DID) and
										// trim((string)right.dt_last_seen) >= hdrBuildDate01 and
										right.src not in risk_indicators.iid_constants.masked_header_sources_all(DataRestrictionMask, isFCRA) AND
										glb_ok AND
										(RIGHT.dt_first_seen <> 0) AND 
										(~mdr.Source_is_Utility(RIGHT.src) OR ~isUtility)	AND
										(	~mdr.Source_is_DPPA(RIGHT.src) OR 
											(dppa_ok AND drivers.state_dppa_ok(header.translateSource(RIGHT.src),DPPA,RIGHT.src))), 
										getHeaderDates(left, right), left outer, keep(200), ATMOST(RiskWise.max_atmost));
                    
        with_HeaderDates_flagged := Suppress.MAC_FlagSuppressedSource(with_HeaderDates_unsuppressed, mod_access);

        SHARED with_HeaderDates := PROJECT(with_HeaderDates_flagged, TRANSFORM( VerificationOfOccupancy.Layouts.Layout_VOOShell, 
			self.target_addr			:= IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.target_addr);
			self.h							:= IF(~left.is_suppressed, left.h);
            self := LEFT;
		));

		SHARED with_QHeaderDates_unsuppressed := join(with_DID, header_quick.key_DID,		
										LEFT.DID <> 0 AND
										keyed(left.DID = right.DID) and
										// trim((string)right.dt_last_seen) >= hdrBuildDate01 and
										right.src not in risk_indicators.iid_constants.masked_header_sources_all(DataRestrictionMask, isFCRA) + 
										// If we have an Equifax data restriction, restrict the QH and WH sources (This isn't caught in the masked_header_source)
										IF(DataRestrictionMask[Risk_Indicators.iid_constants.posEquifaxRestriction] = '1', [MDR.sourceTools.src_Equifax_Quick, MDR.sourceTools.src_Equifax_Weekly], []) AND
										glb_ok AND
										(RIGHT.dt_first_seen <> 0) AND 
										(~mdr.Source_is_Utility(RIGHT.src) OR ~isUtility)	AND
										(	~mdr.Source_is_DPPA(RIGHT.src) OR 
											(dppa_ok AND drivers.state_dppa_ok(header.translateSource(RIGHT.src),DPPA,RIGHT.src))), 
										getQHeaderDates(left, right), keep(200), ATMOST(RiskWise.max_atmost));
		with_QHeaderDates_flagged := Suppress.MAC_FlagSuppressedSource(with_QHeaderDates_unsuppressed, mod_access);

        SHARED with_QHeaderDates := PROJECT(with_QHeaderDates_flagged, TRANSFORM( VerificationOfOccupancy.Layouts.Layout_VOOShell, 
			self.target_addr			:= IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.target_addr);
			self.h								:= IF(~left.is_suppressed, left.h);
            self := LEFT;
		));
    
		SHARED with_allHeaderDates := with_HeaderDates + with_QHeaderDates;
		
		SHARED sort_allHeaderDates := sort(with_allHeaderDates, seq, -target_addr);  //put recs that matched target first so rollup works later 

	// *****************************************************************************************************************************
	// Rollup all header records to calculate the min/max dates to be returned in AddressDateFirstSeen and AddressDateLastSeen
	// *****************************************************************************************************************************
	  SHARED VerificationOfOccupancy.Layouts.Layout_VOOShell rollHeaderDates(VerificationOfOccupancy.Layouts.Layout_VOOShell l, VerificationOfOccupancy.Layouts.Layout_VOOShell r) := transform
			self.h.dt_first_seen 	:= if(l.target_addr > 0, //if the header matches the target address, save the earliest first seen date
																	map(r.target_addr < 1																									=> l.h.dt_first_seen,
																			l.h.dt_first_seen = 0 																						=> r.h.dt_first_seen,	//if left date is 0, move right
																			r.h.dt_first_seen <> 0 and r.h.dt_first_seen < l.h.dt_first_seen	=> r.h.dt_first_seen,	
																																																					 l.h.dt_first_seen), 
																	0);
			self.h.dt_last_seen 	:= if(l.target_addr > 0, //if header matches the target address, save most recent last seen date
																	map(r.target_addr < 1																									=> l.h.dt_last_seen,
																			r.h.dt_last_seen > l.h.dt_last_seen																=> r.h.dt_last_seen, 
																																																					 l.h.dt_last_seen),
																	0);  //we sorted so records that match are first, so if left rec target_addr is 0, keep it as 0
			self									:= l;
		end;
		
	  SHARED roll_allHeaderDates := rollup(sort_allHeaderDates, rollHeaderDates(left,right), seq);
	//end new join


		// Initialize the full header and quick header transforms
		SHARED VerificationOfOccupancy_CCPA getHeader(Risk_Indicators.Layout_Output l, key_header r) := transform
			SELF.Global_Sid := r.Global_Sid;
		addrmatch							:= trim(l.z5) = trim(r.zip) and
															 trim(l.prim_range) = trim(r.prim_range) and
															 ut.NNEQ(trim(l.sec_range), trim(r.sec_range)) and
															 trim(l.prim_name) = trim(r.prim_name) and
															 trim(l.addr_suffix) = trim(r.suffix) and
															 trim(l.predir) = trim(r.predir) and
															 trim(l.postdir) = trim(r.postdir);
			srcPub 								:= MDR.sourceTools.SourceIsWC(r.src) or  //if source is any of these, set as public source
															 MDR.sourceTools.SourceIsDL(r.src) or
															 MDR.sourceTools.SourceIsVehicle(r.src) or
															 MDR.sourceTools.SourceIsFAA(r.src) or
															 MDR.sourceTools.SourceIsVoters_v2(r.src) or
															 MDR.sourceTools.SourceIsBankruptcy(r.src) or
															 MDR.sourceTools.SourceIsLiens(r.src);
			srcTU									:= MDR.sourceTools.SourceIsTransUnion(r.src);
			srcEQ									:= MDR.sourceTools.SourceIsEquifax(r.src);
			srcEN									:= MDR.sourceTools.SourceIsExperian_Credit_Header(r.src);
			current 							:= trim((string)r.dt_last_seen) >= hdrBuildDate01 OR r.dt_last_seen >= l.historydate; // Need to make sure our "current" calculation still works in history mode
			self.target_addr			:= map(addrmatch and current					=> 2,		//address is target address and is currently updating
																	 addrmatch and not current			=> 1,		//address is target address but not currently updating
																																		 0);	//not target address (other address)
			self.other_addr 			:= map(not addrmatch and current and r.prim_name[1..6] <> 'PO BOX'		=> 2,		//another address (non PO box) exists for this did and is current on the hdr 
																	 not addrmatch and not current and r.prim_name[1..6] <> 'PO BOX'=> 1,		//another address (non PO box) exists but is not currently updating
																																																		 0);
			self.Transunion_seen 	:= if(srcTU and addrmatch, 1, 0); 	//set if addrs matches and src is Transunion
			self.Equifax_seen 		:= if(srcEQ and addrmatch, 1, 0); 	//set if addrs matches and src is Equifax 
			self.Experian_seen 		:= if(srcEN and addrmatch, 1, 0); 	//set if addrs matches and src is Experian 
			self.pub_src_seen 		:= if(srcPub and addrmatch, 1, 0);	//set if addrs matches and src is any public record

			// Translate the Quick Header Equifax sources to just a normal 'EQ' record
			self.h.src						:= IF(r.src IN [MDR.sourceTools.src_Equifax_Quick, MDR.sourceTools.src_Equifax_Weekly], MDR.sourceTools.src_Equifax, r.src);
			self.src_group				:= map( srcTU		=> 'TU',
																		srcEQ		=> 'EQ',
																		srcEN		=> 'EN',
																		srcPub	=> r.src,
																						   '');
			inputAddr							:= PROJECT(Risk_Indicators.iid_constants.ds_Record, TRANSFORM(VerificationOfOccupancy.Layouts.Subject_Addresses,
																					SELF.prim_range := TRIM(l.prim_range, LEFT, RIGHT);
																					SELF.predir := TRIM(l.predir, LEFT, RIGHT);
																					SELF.prim_name := TRIM(l.prim_name, LEFT, RIGHT);
																					SELF.addr_suffix := TRIM(l.addr_suffix, LEFT, RIGHT);
																					SELF.postdir := TRIM(l.postdir, LEFT, RIGHT);
																					SELF.unit_desig := TRIM(l.unit_desig, LEFT, RIGHT);
																					SELF.sec_range := TRIM(l.sec_range, LEFT, RIGHT);
																					SELF.city_name := TRIM(l.p_city_name, LEFT, RIGHT);
																					SELF.county := TRIM(l.county, LEFT, RIGHT);
																					SELF.st := TRIM(l.st, LEFT, RIGHT);
																					SELF.z5 := TRIM(l.z5, ALL);
																					SELF.Lat := TRIM(l.lat, LEFT, RIGHT);
																					SELF.Long := TRIM(l.long, LEFT, RIGHT);
																					SELF.AddressStatus := '';
																					SELF.DistanceFromTarget := 0;
																					SELF.DwellingType := TRIM(l.addr_type, LEFT, RIGHT);
																					SELF.AddrCleanerStatus := TRIM(l.addr_status, LEFT, RIGHT);
																					SELF := []));
			addr									:= PROJECT(Risk_Indicators.iid_constants.ds_Record, TRANSFORM(VerificationOfOccupancy.Layouts.Subject_Addresses,
																					SELF.prim_range := TRIM(r.prim_range, LEFT, RIGHT);
																					SELF.predir := TRIM(r.predir, LEFT, RIGHT);
																					SELF.prim_name := TRIM(r.prim_name, LEFT, RIGHT);
																					SELF.addr_suffix := TRIM(r.suffix, LEFT, RIGHT);
																					SELF.postdir := TRIM(r.postdir, LEFT, RIGHT);
																					SELF.unit_desig := TRIM(r.unit_desig, LEFT, RIGHT);
																					SELF.sec_range := TRIM(r.sec_range, LEFT, RIGHT);
																					SELF.city_name := TRIM(r.city_name, LEFT, RIGHT);
																					SELF.county := TRIM(r.county, LEFT, RIGHT);
																					SELF.st := TRIM(r.st, LEFT, RIGHT);
																					SELF.z5 := TRIM(r.zip[1..5], ALL);
																					SELF.AddressStatus := '';
																					SELF := []));
			addrSet								:= PROJECT(inputAddr, TRANSFORM(VerificationOfOccupancy.Layouts.Subject_Addresses, SELF.AddressStatus := 'TARGET'; SELF := LEFT)) + // Always add in the TARGET input property for the LEFT OUTER cases where there is no hit on header
															 IF(current, PROJECT(addr, TRANSFORM(VerificationOfOccupancy.Layouts.Subject_Addresses, SELF.AddressStatus := 'CURRENT'; SELF := LEFT))) +
															 IF(not addrmatch and not current, PROJECT(addr, TRANSFORM(VerificationOfOccupancy.Layouts.Subject_Addresses, SELF.AddressStatus := 'OTHER'; SELF := LEFT)));
			self.SubjectAddresses := addrSet;
			self.h								:= r;
			self.AcctNo						:= l.Account;
			self									:= l;
			self									:= [];
		end;

		SHARED VerificationOfOccupancy_CCPA getQHeader(Risk_Indicators.Layout_Output l, header_quick.key_DID r) := transform
			SELF.Global_Sid := r.Global_Sid;
		addrmatch							:= trim(l.z5) = trim(r.zip) and
															 trim(l.prim_range) = trim(r.prim_range) and
															 ut.NNEQ(trim(l.sec_range), trim(r.sec_range)) and
															 trim(l.prim_name) = trim(r.prim_name) and
															 trim(l.addr_suffix) = trim(r.suffix) and
															 trim(l.predir) = trim(r.predir) and
															 trim(l.postdir) = trim(r.postdir);
			srcPub 								:= MDR.sourceTools.SourceIsWC(r.src) or  //if source is any of these, set as public source
															 MDR.sourceTools.SourceIsDL(r.src) or
															 MDR.sourceTools.SourceIsVehicle(r.src) or
															 MDR.sourceTools.SourceIsFAA(r.src) or
															 MDR.sourceTools.SourceIsVoters_v2(r.src) or
															 MDR.sourceTools.SourceIsBankruptcy(r.src) or
															 MDR.sourceTools.SourceIsLiens(r.src);
			srcTU									:= MDR.sourceTools.SourceIsTransUnion(r.src);
			srcEQ									:= MDR.sourceTools.SourceIsEquifax(r.src);
			srcEN									:= MDR.sourceTools.SourceIsExperian_Credit_Header(r.src);
			current 							:= trim((string)r.dt_last_seen) >= hdrBuildDate01 OR r.dt_last_seen >= l.historydate; // Need to make sure our "current" calculation still works in history mode
			self.target_addr			:= map(addrmatch and current					=> 2,		//address is target address and is currently updating
																	 addrmatch and not current			=> 1,		//address is target address but not currently updating
																																		 0);	//not target address (other address)
			self.other_addr 			:= map(not addrmatch and current and r.prim_name[1..6] <> 'PO BOX'		=> 2,		//another address (non PO box) exists for this did and is current on the hdr 
																	 not addrmatch and not current and r.prim_name[1..6] <> 'PO BOX'=> 1,		//another address (non PO box) exists but is not currently updating
																																																		 0);
			self.Transunion_seen 	:= if(srcTU and addrmatch, 1, 0); 	//set if addrs matches and src is Transunion
			self.Equifax_seen 		:= if(srcEQ and addrmatch, 1, 0); 	//set if addrs matches and src is Equifax 
			self.Experian_seen 		:= if(srcEN and addrmatch, 1, 0); 	//set if addrs matches and src is Experian 
			self.pub_src_seen 		:= if(srcPub and addrmatch, 1, 0);	//set if addrs matches and src is any public record

			// Translate the Quick Header Equifax sources to just a normal 'EQ' record
			self.h.src						:= IF(r.src IN [MDR.sourceTools.src_Equifax_Quick, MDR.sourceTools.src_Equifax_Weekly], MDR.sourceTools.src_Equifax, r.src);
			self.src_group				:= map( srcTU		=> 'TU',
																		srcEQ		=> 'EQ',
																		srcEN		=> 'EN',
																		srcPub	=> r.src,
																						   '');
			inputAddr							:= PROJECT(Risk_Indicators.iid_constants.ds_Record, TRANSFORM(VerificationOfOccupancy.Layouts.Subject_Addresses,
																					SELF.prim_range := TRIM(l.prim_range, LEFT, RIGHT);
																					SELF.predir := TRIM(l.predir, LEFT, RIGHT);
																					SELF.prim_name := TRIM(l.prim_name, LEFT, RIGHT);
																					SELF.addr_suffix := TRIM(l.addr_suffix, LEFT, RIGHT);
																					SELF.postdir := TRIM(l.postdir, LEFT, RIGHT);
																					SELF.unit_desig := TRIM(l.unit_desig, LEFT, RIGHT);
																					SELF.sec_range := TRIM(l.sec_range, LEFT, RIGHT);
																					SELF.city_name := TRIM(l.p_city_name, LEFT, RIGHT);
																					SELF.county := TRIM(l.county, LEFT, RIGHT);
																					SELF.st := TRIM(l.st, LEFT, RIGHT);
																					SELF.z5 := TRIM(l.z5, ALL);
																					SELF.Lat := TRIM(l.lat, LEFT, RIGHT);
																					SELF.Long := TRIM(l.long, LEFT, RIGHT);
																					SELF.AddressStatus := '';
																					SELF.DistanceFromTarget := 0;
																					SELF.DwellingType := TRIM(l.addr_type, LEFT, RIGHT);
																					SELF.AddrCleanerStatus := TRIM(l.addr_status, LEFT, RIGHT);
																					SELF := []));
			addr									:= PROJECT(Risk_Indicators.iid_constants.ds_Record, TRANSFORM(VerificationOfOccupancy.Layouts.Subject_Addresses,
																					SELF.prim_range := TRIM(r.prim_range, LEFT, RIGHT);
																					SELF.predir := TRIM(r.predir, LEFT, RIGHT);
																					SELF.prim_name := TRIM(r.prim_name, LEFT, RIGHT);
																					SELF.addr_suffix := TRIM(r.suffix, LEFT, RIGHT);
																					SELF.postdir := TRIM(r.postdir, LEFT, RIGHT);
																					SELF.unit_desig := TRIM(r.unit_desig, LEFT, RIGHT);
																					SELF.sec_range := TRIM(r.sec_range, LEFT, RIGHT);
																					SELF.city_name := TRIM(r.city_name, LEFT, RIGHT);
																					SELF.county := TRIM(r.county, LEFT, RIGHT);
																					SELF.st := TRIM(r.st, LEFT, RIGHT);
																					SELF.z5 := TRIM(r.zip[1..5], ALL);
																					SELF.AddressStatus := '';
																					SELF := []));
			addrSet								:= PROJECT(inputAddr, TRANSFORM(VerificationOfOccupancy.Layouts.Subject_Addresses, SELF.AddressStatus := 'TARGET'; SELF := LEFT)) + // Always add in the TARGET input property for the LEFT OUTER cases where there is no hit on header
															 IF(current, PROJECT(addr, TRANSFORM(VerificationOfOccupancy.Layouts.Subject_Addresses, SELF.AddressStatus := 'CURRENT'; SELF := LEFT))) +
															 IF(not addrmatch and not current, PROJECT(addr, TRANSFORM(VerificationOfOccupancy.Layouts.Subject_Addresses, SELF.AddressStatus := 'OTHER'; SELF := LEFT)));
			self.SubjectAddresses := addrSet;
			self.h								:= r;
			self.AcctNo						:= l.Account;
			self									:= l;
			self									:= [];
		end;

		SHARED with_Header_unsuppressed := join(with_DID, key_header,	
										LEFT.DID <> 0 AND
										keyed(left.DID = right.s_DID) and
										// trim((string)right.dt_last_seen) >= hdrBuildDate01 and
										right.src not in risk_indicators.iid_constants.masked_header_sources_all(DataRestrictionMask, isFCRA) AND
										(RIGHT.dt_first_seen <> 0 AND RIGHT.dt_first_seen <= LEFT.historydate) and // Check the history date
										glb_ok AND
										(~mdr.Source_is_Utility(RIGHT.src) OR ~isUtility)	AND
										(	~mdr.Source_is_DPPA(RIGHT.src) OR 
											(dppa_ok AND drivers.state_dppa_ok(header.translateSource(RIGHT.src),DPPA,RIGHT.src))), 
										getHeader(left, right), left outer, keep(200), ATMOST(RiskWise.max_atmost));
		with_Header_flagged := Suppress.MAC_FlagSuppressedSource(with_Header_unsuppressed, mod_access);

        SHARED with_Header := PROJECT(with_Header_flagged, TRANSFORM( VerificationOfOccupancy.Layouts.Layout_VOOShell, 
			self.target_addr			:= IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.target_addr);
			self.other_addr 			:= IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.other_addr);
			self.Transunion_seen 	:= IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.Transunion_seen);
			self.Equifax_seen 		:= IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.Equifax_seen);
			self.Experian_seen 		:= IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.Experian_seen);
			self.pub_src_seen 		:= IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.pub_src_seen);
			self.src_group				:= IF(left.is_suppressed, Suppress.OptOutMessage('STRING'), left.src_group);
			self.SubjectAddresses := IF(~left.is_suppressed, left.SubjectAddresses);
			self.h								:= IF(~left.is_suppressed, left.h);
            self := LEFT;
		));

		SHARED with_QHeader_unsuppressed := join(with_DID, header_quick.key_DID,		
										LEFT.DID <> 0 AND
										keyed(left.DID = right.DID) and
										// trim((string)right.dt_last_seen) >= hdrBuildDate01 and
										right.src not in risk_indicators.iid_constants.masked_header_sources_all(DataRestrictionMask, isFCRA) + 
										// If we have an Equifax data restriction, restrict the QH and WH sources (This isn't caught in the masked_header_source)
										IF(DataRestrictionMask[Risk_Indicators.iid_constants.posEquifaxRestriction] = '1', [MDR.sourceTools.src_Equifax_Quick, MDR.sourceTools.src_Equifax_Weekly], []) AND
										(RIGHT.dt_first_seen <> 0 AND RIGHT.dt_first_seen <= LEFT.historydate) and // Check the history date
										glb_ok AND
										(~mdr.Source_is_Utility(RIGHT.src) OR ~isUtility)	AND
										(	~mdr.Source_is_DPPA(RIGHT.src) OR 
											(dppa_ok AND drivers.state_dppa_ok(header.translateSource(RIGHT.src),DPPA,RIGHT.src))), 
										getQHeader(left, right), keep(200), ATMOST(RiskWise.max_atmost));
                    
	   with_QHeader_flagged := Suppress.MAC_FlagSuppressedSource(with_QHeader_unsuppressed, mod_access);

        SHARED with_QHeader := PROJECT(with_QHeader_flagged, TRANSFORM( VerificationOfOccupancy.Layouts.Layout_VOOShell, 
			self.target_addr			:= IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.target_addr);
			self.other_addr 			:= IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.other_addr);
			self.Transunion_seen 	:= IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.Transunion_seen);
			self.Equifax_seen 		:= IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.Equifax_seen);
			self.Experian_seen 		:= IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.Experian_seen);
			self.pub_src_seen 		:= IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.pub_src_seen);
			self.src_group				:= IF(left.is_suppressed, Suppress.OptOutMessage('STRING'), left.src_group);
			self.SubjectAddresses := IF(~left.is_suppressed, left.SubjectAddresses);
			self.h								:= IF(~left.is_suppressed, left.h);
            self := LEFT;
		));      

		SHARED with_allHeader := with_Header + with_QHeader;
		
		SHARED sort_allHeader := sort(with_allHeader, seq, -target_addr);  //put recs that matched target first so rollup works later 

	// *******************************************************************************************************************
	// Join to Criminal by DID and format fields in the header portion of the VOOshell so we can treat like a header record
	// *******************************************************************************************************************

		SHARED VerificationOfOccupancy.Layouts.Layout_VOOShell getCrim(with_DID l, doxie_files.key_offenders_risk r) := transform
			addrmatch							:= trim(l.z5) = trim(r.zip5) and
															 trim(l.prim_range) = trim(r.prim_range) and
															 ut.NNEQ(trim(l.sec_range), trim(r.sec_range)) and
															 trim(l.prim_name) = trim(r.prim_name) and
															 trim(l.addr_suffix) = trim(r.addr_suffix) and
															 trim(l.predir) = trim(r.predir) and
															 trim(l.postdir) = trim(r.postdir);
			current 							:= trim((string)r.earliest_offense_date[1..6]) >= hdrBuildDate01 OR trim((string)r.earliest_offense_date[1..6]) >= (string)l.historydate; // Need to make sure our "current" calculation still works in history mode
			self.target_addr			:= map(addrmatch and current					=> 2,		//address is target address and is currently updating
																	 addrmatch and not current			=> 1,		//address is target address but not currently updating
																																		 0);	//not target address (other address)
			self.other_addr 			:= map(not addrmatch and current			=> 2,		//another address exists for this did and is current on the hdr
																	 not addrmatch and not current	=> 1,		//another address exists but is not currently updating
																																		 0);
			self.h.src 						:= 'ZZ';
			self.src_group				:= 'ZZ';
			self.h.dt_first_seen 	:= (integer)r.earliest_offense_date[1..6];
			self.h.dt_last_seen 	:= (integer)r.earliest_offense_date[1..6];
			self.pub_src_seen			:= if(addrmatch, 1, 0);
			self.h.did						:= (unsigned6)r.did;
			self.h.dob						:= (integer4)r.dob;
			self.h 								:= r;
			self.AcctNo						:= l.Account;
			self 									:= l;
			self 									:= [];
		end;
										
		SHARED with_Crim := join(with_DID, doxie_files.key_offenders_risk,
										left.DID <> 0 and
										keyed(left.DID = right.sdid) and
									  (unsigned3)(RIGHT.earliest_offense_date[1..6]) <= left.historydate, 
										getCrim(left, right), keep(200), ATMOST(RiskWise.max_atmost));

		// Need to check the hdrBuildDate01 for realtime transactions and the historydate for historical transactions
	  SHARED with_allSources := sort_allHeader(trim((string)h.dt_last_seen) >= hdrBuildDate01 OR h.dt_last_seen >= historydate or did = 0) + with_Crim; 

		SHARED dedup_allSources := dedup(sort(with_allSources(src_group <> ''), seq, src_group, -h.dt_last_seen, -target_addr), seq, src_group);  //keep only most recent rec per source group
		
	// *******************************************************************************************************************
	// Rollup to indicate if any bureaus or public sources have our target address as most recent
	// *******************************************************************************************************************

	  SHARED VerificationOfOccupancy.Layouts.Layout_VOOShell rollSources(VerificationOfOccupancy.Layouts.Layout_VOOShell l, VerificationOfOccupancy.Layouts.Layout_VOOShell r) := transform
			self.Transunion_seen	:= if(r.Transunion_seen > l.Transunion_seen, r.Transunion_seen, l.Transunion_seen);
			self.Equifax_seen			:= if(r.Equifax_seen > l.Equifax_seen, r.Equifax_seen, l.Equifax_seen);
			self.Experian_seen		:= if(r.Experian_seen > l.Experian_seen, r.Experian_seen, l.Experian_seen);
			self.pub_src_seen			:= if(r.pub_src_seen > l.pub_src_seen, r.pub_src_seen, l.pub_src_seen);
			self									:= l;
		end;
		
	  SHARED roll_allSources := rollup(dedup_allSources, rollSources(left,right), seq);

	// *******************************************************************************************************************
	// Rollup all header records to surmize if they matched the input (target) address and/or if other addresses are also present 
	// *******************************************************************************************************************

	  SHARED VerificationOfOccupancy.Layouts.Layout_VOOShell rollHeader(VerificationOfOccupancy.Layouts.Layout_VOOShell l, VerificationOfOccupancy.Layouts.Layout_VOOShell r) := transform
			self.h.dt_first_seen 	:= if(l.target_addr > 0, //if the header matches the target address, save the earliest first seen date
																	map(r.target_addr < 1																									=> l.h.dt_first_seen,
																			r.h.dt_first_seen <> 0 and r.h.dt_first_seen < l.h.dt_first_seen	=> r.h.dt_first_seen,	
																																																					 l.h.dt_first_seen), 
																	0);
			self.h.dt_last_seen 	:= if(l.target_addr > 0, //if header matches the target address, save most recent last seen date
																	map(r.target_addr < 1																									=> l.h.dt_last_seen,
																			r.h.dt_last_seen > l.h.dt_last_seen																=> r.h.dt_last_seen, 
																																																					 l.h.dt_last_seen),
																	0);  //we sorted so records that match are first, so if left rec target_addr is 0, keep it as 0
			self.target_addr 			:= if(r.target_addr > l.target_addr, r.target_addr, l.target_addr);
			self.other_addr 			:= if(r.other_addr > l.other_addr, r.other_addr, l.other_addr);
			// Keep the header addresses for use in the Report
			SELF.SubjectAddresses := DEDUP(SORT(UNGROUP(l.SubjectAddresses + r.SubjectAddresses), Prim_Range, Prim_Name, Z5, AddressStatus),  Prim_Range, Prim_Name, Z5, AddressStatus);
			self									:= l;
		end;
		
	  SHARED roll_allHeader := rollup(sort_allHeader, rollHeader(left,right), seq);

	// *******************************************************************************************************************
	// Join to append the "source seen" fields to the VOO shell layout
	// *******************************************************************************************************************

		SHARED VerificationOfOccupancy.Layouts.Layout_VOOShell getSrcSeen(roll_allHeader le, roll_allSources ri) := TRANSFORM
				 self.Transunion_seen	:= ri.Transunion_seen;
				 self.Equifax_seen		:= ri.Equifax_seen;
				 self.Experian_seen		:= ri.Experian_seen;
				 self.pub_src_seen		:= ri.pub_src_seen;
				 self 								:= le;
		END;	

		SHARED with_srcSeen := join(roll_allHeader, roll_allSources, 
					left.seq = right.seq,
					getSrcSeen(left,right),left outer);  
					
	// *******************************************************************************************************************
	// Begin AddressSearchHistoryIndex - Join DID to inquiries and keep inquiries within 1 year of the input date
	// *******************************************************************************************************************

		SHARED layout_inq := record
			unsigned4 seq;
			unsigned6 s_did;
			inquiry_acclogs.Layout.common_indexes;
		end;
		SHARED layout_inq_CCPA := RECORD
	  layout_inq;
	  Unsigned4 Global_sid;
	  Unsigned6 Did;
	  end;
		SHARED layout_inq_CCPA get_inquiry(with_srcSeen le, Inquiry_AccLogs.Key_Inquiry_DID ri) := TRANSFORM
			SELF.Global_Sid := ri.CCPA.Global_Sid;
		  Self.did := ri.s_did;
		self.seq 	:= le.seq;
			self 			:= ri;
		END;	

		SHARED inquiry_Recs := join(with_srcSeen, Inquiry_AccLogs.Key_Inquiry_DID, 
							left.did<>0 and keyed(left.did=right.s_did) and
							right.search_info.datetime <> '' and
							(unsigned)right.search_info.datetime[1..6] <= left.historydate and
							(unsigned)right.search_info.datetime[1..6] >= left.historydate - 100 and  //keep inquiries within 1 year of input date
							trim(right.bus_intel.use) = '' and  
							trim(right.search_info.product_code) in Inquiry_AccLogs.shell_constants.valid_product_codes and   
							trim(right.search_info.function_description) in Inquiry_AccLogs.shell_constants.VOO_search_functions and
							//filter out 'collections' to coincide with Shell 5 (mimic Risk_Indicators.Boca_Shell_Inquiries.isCollection)
							trim(STD.Str.ToUpperCase(right.bus_intel.vertical)) not IN Inquiry_AccLogs.shell_constants.collections_vertical_set and 
							trim(STD.Str.ToUpperCase(right.bus_intel.industry)) not IN Inquiry_AccLogs.shell_constants.collection_industry and
							STD.Str.Find(STD.Str.ToUpperCase(trim(STD.Str.ToUpperCase(right.bus_intel.sub_market))),'FIRST PARTY', 1) < 1 and 
							//filter out 'highriskcredit' to coincide with Shell 5 (mimic Risk_Indicators.Boca_Shell_Inquiries.isHighRiskCredit)
							trim(STD.Str.ToUpperCase(right.bus_intel.industry)) not IN Inquiry_AccLogs.shell_constants.HighRiskCredit_industry5,
							get_inquiry(left, right),
							inner, atmost(riskwise.max_atmost * 5));	
				inquiry_Recs_suppressed := Suppress.Mac_SuppressSource(inquiry_Recs, mod_access);	

		SHARED inquiry_Recs_VerificationOfOccupancy_CCPA := PROJECT(inquiry_Recs_suppressed, TRANSFORM(layout_inq,
													  SELF := LEFT));

		SHARED layout_inq_CCPA get_inquiry_update(with_srcSeen le, Inquiry_AccLogs.Key_Inquiry_DID_Update ri) := TRANSFORM
			SELF.Global_Sid := ri.CCPA.Global_Sid;
		  Self.did := ri.s_did;
		self.seq 	:= le.seq;
			self 			:= ri;
		END;
							
		SHARED inquiry_update_Recs := join(with_srcSeen, Inquiry_AccLogs.Key_Inquiry_DID_Update, 
							left.did<>0 and keyed(left.did=right.s_did) and
							right.search_info.datetime <> '' and
							(unsigned)right.search_info.datetime[1..6] <= left.historydate and
							(unsigned)right.search_info.datetime[1..6] >= left.historydate - 100 and  //keep inquiries within 1 year of input date
							trim(right.bus_intel.use) = '' and  
							trim(right.search_info.product_code) in Inquiry_AccLogs.shell_constants.valid_product_codes and   
							trim(right.search_info.function_description) in Inquiry_AccLogs.shell_constants.VOO_search_functions and
							// filter out 'collections' to coincide with Shell 5 (mimic Risk_Indicators.Boca_Shell_Inquiries.isCollection)
							trim(STD.Str.ToUpperCase(right.bus_intel.vertical)) <> 'COLLECTIONS' and 
							trim(STD.Str.ToUpperCase(right.bus_intel.vertical)) <> 'RECEIVABLES MANAGEMENT' and 
							trim(STD.Str.ToUpperCase(right.bus_intel.industry)) not IN Inquiry_AccLogs.shell_constants.collection_industry and
							STD.Str.Find(STD.Str.ToUpperCase(trim(STD.Str.ToUpperCase(right.bus_intel.sub_market))),'FIRST PARTY', 1) < 1 and 
							// filter out 'highriskcredit' to coincide with Shell 5 (mimic Risk_Indicators.Boca_Shell_Inquiries.isHighRiskCredit)
							trim(STD.Str.ToUpperCase(right.bus_intel.industry)) not IN Inquiry_AccLogs.shell_constants.HighRiskCredit_industry5,
							get_inquiry_update(left, right),
							inner, atmost(riskwise.max_atmost * 5));
				inquiry_Update_Recs_suppressed := Suppress.Mac_SuppressSource(inquiry_Update_Recs, mod_access);	

		SHARED inquiry_Update_Recs_VerificationOfOccupancy_CCPA := PROJECT(inquiry_Update_Recs_suppressed, TRANSFORM(layout_inq,
													  SELF := LEFT));

	//keep only one inquiry record per unique address
		SHARED dedup_inquiries := dedup(sort(ungroup(inquiry_Recs_VerificationOfOccupancy_CCPA) & ungroup(inquiry_Update_Recs_VerificationOfOccupancy_CCPA), seq, s_did, person_q.zip5, person_q.prim_range, person_q.sec_range, person_q.prim_name, person_q.addr_suffix, person_q.predir, person_q.postdir), 
																								seq, s_did, person_q.zip5, person_q.prim_range, person_q.sec_range, person_q.prim_name, person_q.addr_suffix, person_q.predir, person_q.postdir
														 ); 

		SHARED VerificationOfOccupancy.Layouts.Layout_VOOShell get_inq_hdr(dedup_inquiries l, sort_allHeader r) := transform
			addrmatch							:= if(trim(l.person_q.zip5) = trim(r.h.zip) and
																	trim(l.person_q.prim_range) = trim(r.h.prim_range) and
																	ut.NNEQ(trim(l.person_q.sec_range), trim(r.h.sec_range)) and
																	trim(l.person_q.prim_name) = trim(r.h.prim_name) and
																	trim(l.person_q.addr_suffix) = trim(r.h.suffix) and
																	trim(l.person_q.predir) = trim(r.h.predir) and
																	trim(l.person_q.postdir) = trim(r.h.postdir), true, false);
			within_3mos						:= if(ut.DaysApart((string)r.historydate + '01', l.search_info.datetime[1..8]) < 90, true, false);
			self.srchconfaddr3mos	:= if(r.target_addr > 0 and addrmatch and within_3mos, 1, 0);		
			self.srchconfaddr1yr	:= if(r.target_addr > 0 and addrmatch, 1, 0);		
			self.srchprevaddr3mos	:= if(r.other_addr > 0 and addrmatch and within_3mos, 1, 0);		
			self.srchprevaddr1yr	:= if(r.other_addr > 0 and addrmatch, 1, 0);
			self.srchdiffaddr3mos	:= if(not addrmatch and within_3mos, 1, 0);		
			self.srchdiffaddr1yr	:= if(not addrmatch, 1, 0);	
			self									:= r;
		end;	

		SHARED inq_hdr_recs := join(dedup_inquiries, sort_allHeader, 
							left.seq = right.seq, 
							get_inq_hdr(left, right),
							left outer, atmost(riskwise.max_atmost * 5));

	// Rollup header/inquiry records to set fields indicating inquiries per address (target address, previous address, address not on header)
	  SHARED VerificationOfOccupancy.Layouts.Layout_VOOShell roll_inqHdr(inq_hdr_recs l, inq_hdr_recs r) := transform
			self.srchconfaddr3mos := max(r.srchconfaddr3mos, l.srchconfaddr3mos);
			self.srchconfaddr1yr 	:= max(r.srchconfaddr1yr, l.srchconfaddr1yr);
			self.srchprevaddr3mos := max(r.srchprevaddr3mos, l.srchprevaddr3mos);
			self.srchprevaddr1yr 	:= max(r.srchprevaddr1yr, l.srchprevaddr1yr);
			self.srchdiffaddr3mos := max(r.srchdiffaddr3mos, l.srchdiffaddr3mos);
			self.srchdiffaddr1yr 	:= max(r.srchdiffaddr1yr, l.srchdiffaddr1yr);
			self									:= l;
		end;
		
	  SHARED rolled_inqHdr := rollup(inq_hdr_recs, roll_inqHdr(left,right), seq);

	// Join to append the inquiry address fields

		SHARED VerificationOfOccupancy.Layouts.Layout_VOOShell getInqFields(with_srcSeen le, rolled_inqHdr ri) := TRANSFORM
				 self.srchconfaddr3mos	:= ri.srchconfaddr3mos;
				 self.srchconfaddr1yr		:= ri.srchconfaddr1yr;
				 self.srchprevaddr3mos	:= ri.srchprevaddr3mos;
				 self.srchprevaddr1yr		:= ri.srchprevaddr1yr;
				 self.srchdiffaddr3mos	:= ri.srchdiffaddr3mos;
				 self.srchdiffaddr1yr		:= ri.srchdiffaddr1yr;
				 self := le;
		END;	

		SHARED with_inqFields := join(with_srcSeen, rolled_inqHdr, 
					left.seq = right.seq,
					getInqFields(left,right),left outer);

	// Go get utility data and append to VOO shell
						
		SHARED utility_data := VerificationOfOccupancy.getUtility(roll_allHeader, glba, isUtility,MOD_Access);

		SHARED VerificationOfOccupancy.Layouts.Layout_VOOShell getUtility(with_inqFields le, utility_data ri) := TRANSFORM
					self.util_target_addr	:= ri.util_target_addr;	
					self.util_other_addr 	:= ri.util_other_addr;	
					self.util_disconnect	:= ri.util_disconnect; 
					self := le;
		END;	

		SHARED with_utility := join(with_inqFields, utility_data, 
					left.seq = right.seq,
					getUtility(left,right),left outer);

	// Go get target property's mailing address data and append to VOO shell
		SHARED mailing_data := VerificationOfOccupancy.getMailingAddr(roll_allHeader, sort_allHeader, fares_ok);

		SHARED VerificationOfOccupancy.Layouts.Layout_VOOShell getMailingAddr(with_utility le, mailing_data ri) := TRANSFORM
			SELF.Fares_mail_prim_range := ri.Fares_mail_prim_range; 	
			SELF.Fares_mail_predir := ri.Fares_mail_predir;		
			SELF.Fares_mail_prim_name := ri.Fares_mail_prim_name;	
			SELF.Fares_mail_suffix := ri.Fares_mail_suffix;  
			SELF.Fares_mail_postdir := ri.Fares_mail_postdir;		
			SELF.Fares_mail_unit_desig := ri.Fares_mail_unit_desig;	
			SELF.Fares_mail_sec_range := ri.Fares_mail_sec_range;	
			SELF.Fares_mail_city := ri.Fares_mail_city;	
			SELF.Fares_mail_st := ri.Fares_mail_st;	
			SELF.Fares_mail_zip := ri.Fares_mail_zip;
			SELF.Fares_mail_addr_flag := ri.Fares_mail_addr_flag; 
			SELF := le;
		END;	

		SHARED with_mailingAddr := join(with_utility, mailing_data, 
					left.seq = right.seq,
					getMailingAddr(left,right),left outer);

	// Go get prior resident data and append to VOO shell
		SHARED priorRes_data := VerificationOfOccupancy.getPriorResident(roll_allHeader, DataRestrictionMask, glb_ok, dppa, isUtility, dppa_ok, fares_ok,Mod_access);

		SHARED VerificationOfOccupancy.Layouts.Layout_VOOShell getPriorRes(with_mailingAddr le, priorRes_data ri) := TRANSFORM
			SELF.prior_res_DID 							:= ri.prior_res_DID;
			SELF.prior_res_dt_first_seen 		:= ri.prior_res_dt_first_seen;
			SELF.prior_res_dt_last_seen 		:= ri.prior_res_dt_last_seen;
			SELF.prior_res_target_addrmatch := ri.prior_res_target_addrmatch;
			SELF.prior_res_owned_target 		:= ri.prior_res_owned_target;
			SELF.prior_res_sold_target 			:= ri.prior_res_sold_target;
			SELF.prior_res_owned_other 			:= ri.prior_res_owned_other;
			SELF.prior_res_sold_other 			:= ri.prior_res_sold_other;
			SELF.prior_res_owned_newer 			:= ri.prior_res_Fares_target_dt_first_seen <> 0 and ri.prior_res_Fares_other_dt_first_seen > ri.prior_res_Fares_target_dt_first_seen; //set to 'true' if the subject owned another property after they owned the target 
			SELF.prior_res_new_addr 				:= ri.prior_res_new_addr;
			SELF.prior_res_acct_open 				:= ri.prior_res_acct_open;
			SELF.prior_res_prim_range 			:= ri.prior_res_prim_range;
			SELF.prior_res_predir 					:= ri.prior_res_predir;
			SELF.prior_res_prim_name 				:= ri.prior_res_prim_name;
			SELF.prior_res_addr_suffix 			:= ri.prior_res_addr_suffix;
			SELF.prior_res_postdir 					:= ri.prior_res_postdir;
			SELF.prior_res_unit_desig 			:= ri.prior_res_unit_desig;
			SELF.prior_res_sec_range 				:= ri.prior_res_sec_range;
			SELF.prior_res_city 						:= ri.prior_res_city;
			SELF.prior_res_st 							:= ri.prior_res_st;
			SELF.prior_res_zip 							:= ri.prior_res_zip;
			SELF.prior_res_Fares_ID 				:= ri.prior_res_Fares_ID;
			SELF.prior_res_Fares_target_dt_first_seen 				:= ri.prior_res_Fares_target_dt_first_seen;
			SELF.prior_res_Fares_other_dt_first_seen 				:= ri.prior_res_Fares_other_dt_first_seen;
			SELF 															:= le;
		END;	

		SHARED with_PriorRes := join(with_mailingAddr, priorRes_data, 
					left.seq = right.seq,
					getPriorRes(left,right),left outer);

	// Go get necessary data for determining the 'PriorAddressMoveIndex' attribute and append to VOOShell
		SHARED priorAddr_data := VerificationOfOccupancy.getPriorAddress(roll_allHeader, sort_allHeader, DataRestrictionMask, glb_ok, dppa, isUtility, dppa_ok, fares_ok,Mod_Access);

		SHARED VerificationOfOccupancy.Layouts.Layout_VOOShell getPriorAddr(with_Priorres le, priorAddr_data ri) := TRANSFORM
			SELF.prior_addr_address_history_seq 		:= ri.prior_addr_address_history_seq;
			SELF.prior_addr_address_history_reseq 	:= ri.prior_addr_address_history_reseq;
			SELF.prior_addr_owned 									:= ri.prior_addr_owned;
			SELF.prior_addr_sold 										:= ri.prior_addr_sold;
			SELF.prior_addr_rpting_subject 					:= ri.prior_addr_rpting_subject;
			SELF.prior_addr_rpting_newID 						:= ri.prior_addr_rpting_newID;
			SELF 																		:= le;
		END;	

		SHARED with_priorAddr := join(with_PriorRes, priorAddr_data, 
					left.seq = right.seq,
					getPriorAddr(left,right),left outer);

	// Go get necessary data for determining 'OtherOwnedPropertyProximity' attribute and append to VOOShell
		SHARED otherProximity_data := VerificationOfOccupancy.getOtherProximity(roll_allHeader, fares_ok); 

		SHARED VerificationOfOccupancy.Layouts.Layout_VOOShell getOtherProximity(with_PriorAddr le, otherProximity_data ri) := TRANSFORM
			SELF.other_prox_prim_range	:= ri.other_prox_prim_range; 	
			SELF.other_prox_predir			:= ri.other_prox_predir;		
			SELF.other_prox_prim_name		:= ri.other_prox_prim_name;	
			SELF.other_prox_suffix			:= ri.other_prox_suffix;  
			SELF.other_prox_postdir			:= ri.other_prox_postdir;		
			SELF.other_prox_sec_range		:= ri.other_prox_sec_range;	
			SELF.other_prox_city				:= ri.other_prox_city;	
			SELF.other_prox_st					:= ri.other_prox_st;	
			SELF.other_prox_zip					:= ri.other_prox_zip;	
			SELF.other_prox_lat  				:= ri.other_prox_lat;	
			SELF.other_prox_long  			:= ri.other_prox_long;	
			SELF.other_prox_fares_ID  	:= ri.other_prox_fares_ID;	
			SELF.other_prox_owned  			:= ri.other_prox_owned;	
			SELF.other_prox_sold  			:= ri.other_prox_sold;	
			SELF.target_addr_owned 			:= ri.target_addr_owned;	
			SELF.target_addr_sold  			:= ri.target_addr_sold;	
			SELF.other_prox_distance  	:= if(ri.other_prox_owned <> '1', 9999999, ri.other_prox_distance);	
			SELF 												:= le;
		END;	

		SHARED with_otherProximity := join(with_PriorAddr, otherProximity_data, 
					left.seq = right.seq,
					getOtherProximity(left,right),left outer);
					
	// *******************************************************************************************************************
	// Join to Death Master by DID to pick up most current deceased date (DOD on header can be weeks/months old)
	// *******************************************************************************************************************

		SHARED VerificationOfOccupancy_CCPA getDOD(with_otherProximity l, Doxie.key_death_masterv2_ssa_DID r) := transform
			SELF.Global_Sid := r.Global_Sid;
		SELF.DIDdeceased := r.l_did<>0;
			SELF.DIDdeceasedDate := (UNSIGNED)r.dod8;
			SELF.DIDdeceasedDOB := (UNSIGNED)r.dob8;
			SELF.DIDdeceasedfirst := r.fname;
			SELF.DIDdeceasedlast := r.lname;
			SELF.DIDdeceasedsrc := r.death_rec_src;
			self 			:= l;
		end;

		SHARED with_DOD_unsuppressed := join(with_otherProximity, Doxie.key_death_masterV2_ssa_DID,
										left.DID <> 0 and
										keyed(left.DID = right.l_did) and
										(right.src <> MDR.sourceTools.src_Death_Restricted or Risk_Indicators.iid_constants.deathSSA_ok(DataPermissionMask)),
										getDOD(left, right), left outer, keep(200), ATMOST(RiskWise.max_atmost));
	 with_DOD_flagged := Suppress.MAC_FlagSuppressedSource(with_DOD_unsuppressed, mod_access);

	with_DOD := PROJECT(with_DOD_flagged, TRANSFORM(VerificationOfOccupancy.Layouts.Layout_VOOShell, 
            SELF.DIDdeceased := IF(left.is_suppressed, (BOOLEAN)Suppress.OptOutMessage('BOOLEAN'), left.DIDdeceased);
			SELF.DIDdeceasedDate := IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.DIDdeceasedDate);
			SELF.DIDdeceasedDOB := IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.DIDdeceasedDOB);
			SELF.DIDdeceasedfirst := IF(left.is_suppressed, Suppress.OptOutMessage('STRING'), left.DIDdeceasedfirst);
			SELF.DIDdeceasedlast := IF(left.is_suppressed, Suppress.OptOutMessage('STRING'), left.DIDdeceasedlast);
			SELF.DIDdeceasedsrc := IF(left.is_suppressed, Suppress.OptOutMessage('STRING'), left.DIDdeceasedsrc);
			SELF := LEFT;
	)); 

		SHARED dedup_DOD := dedup(SORT(with_DOD, seq, -DIDdeceasedfirst,-DIDdeceasedlast,-DIDdeceasedDate,-DIDdeceasedDOB, -DIDdeceasedsrc), seq);        

	// *******************************************************************************************************************
	// Go determine if the person has been incarcerated
	// *******************************************************************************************************************

		SHARED incarcerated_data := VerificationOfOccupancy.getIncarceration(roll_allHeader);

		SHARED VerificationOfOccupancy.Layouts.Layout_VOOShell getIncarc(dedup_DOD le, utility_data ri) := TRANSFORM
					self.incarc_Offenders		 := ri.incarc_Offenders;	
					self.incarc_Offenses		 := ri.incarc_Offenses;	
					self.incarc_Punishments	 := ri.incarc_Punishments;	
					self.incarc_Offender_key := ri.incarc_Offender_key;	
					self := le;
		END;	

		SHARED with_incarc := if(~PAR_request,
											join(dedup_DOD, incarcerated_data, 
													 left.seq = right.seq,
													 getIncarc(left,right),left outer), 
											dedup_DOD);

	// *******************************************************************************************************************
	// Call to Boca_Shell_ADVO to get 'Seasonal Address' indicator
	// *******************************************************************************************************************

		SHARED Risk_Indicators.Layout_BocaShell_Neutral tf_ADVO(with_incarc l) := transform
			self.Address_Verification.Input_Address_Information.zip5 				:= l.z5;
			self.Address_Verification.Input_Address_Information.prim_range 	:= l.prim_range;
			self.Address_Verification.Input_Address_Information.prim_name 	:= l.prim_name;
			self.Address_Verification.Input_Address_Information.addr_suffix := l.addr_suffix;
			self.Address_Verification.Input_Address_Information.predir 			:= l.predir;
			self.Address_Verification.Input_Address_Information.postdir 		:= l.postdir;
			self.Address_Verification.Input_Address_Information.sec_range 	:= l.sec_range;
			self.Address_Verification.Input_Address_Information.city_name		:= l.p_city_name;
			self.Address_Verification.Input_Address_Information.st 					:= l.st;
			self.historydate	:= l.historydate;
			self.age					:= (integer)l.age;
			self							:= l;
			self 							:= [];
		end;
										
		SHARED pre_ADVO := group(project(with_incarc, tf_ADVO(left)), seq);

		SHARED isPreScreen := false;
		SHARED BSversion := 41;
		
		SHARED advo_hits := Risk_Indicators.boca_shell_advo(pre_ADVO, isFCRA, DataRestrictionMask, isPreScreen, BSversion);  

		SHARED VerificationOfOccupancy.Layouts.Layout_VOOShell getADVO(with_incarc l, advo_hits r) := transform
			self.ADVO := r.advo_input_addr;
			self 			:= l;
		end;
										
		SHARED with_ADVO := join(with_incarc, advo_hits,
										left.seq = right.seq,
										getADVO(left, right), left outer);

	// *******************************************************************************************************************
	// Join to pick up SIC code for determining if address is a correctional facility
	// *******************************************************************************************************************

	SHARED VerificationOfOccupancy.Layouts.Layout_VOOShell getSICCode(with_ADVO le, risk_indicators.key_HRI_Address_To_SIC ri) := TRANSFORM
		 self.sic_code := ri.sic_code;
			 self.addr_type := if(ri.sic_code = '2265', 'P', le.addr_type);  //If Post Office address, set addr type to PO Box 
			 self := le;
	END;

	SHARED with_SIC := join(with_ADVO, risk_indicators.key_HRI_Address_To_SIC,
					left.z5!='' and left.prim_name != '' and
					keyed(left.z5=right.z5) and keyed(left.prim_name=right.prim_name) and keyed(left.addr_suffix=right.suffix) and 
					keyed(left.predir=right.predir) and keyed(left.postdir=right.postdir) and keyed(left.prim_range=right.prim_range) and 
					keyed(left.sec_range=right.sec_range),
					getSICCode(left,right),left outer,
					ATMOST(keyed(left.z5=right.z5) and keyed(left.prim_name=right.prim_name) and keyed(left.addr_suffix=right.suffix) and
						  keyed(left.predir=right.predir) and keyed(left.postdir=right.postdir) and keyed(left.prim_range=right.prim_range) and
						  keyed(left.sec_range=right.sec_range), RiskWise.max_atmost), keep(1));	

	// *******************************************************************************************************************
	// Get relative information, including DID and title such as SPOUSE/HUSBAND/WIFE
	// *******************************************************************************************************************

		SHARED	rolledHdr_dedp := dedup(sort(roll_allHeader(did<>0),did), did);
		SHARED	rolledHdr_dids := PROJECT(rolledHdr_dedp, 
			TRANSFORM(Relationship.Layout_GetRelationship.DIDs_layout, SELF.DID := LEFT.DID));
		SHARED max_relatives := 500;
		SHARED	rolledHdrdids := Relationship.proc_GetRelationshipNeutral(rolledHdr_dids,TopNCount:=max_relatives,
				RelativeFlag :=TRUE,AssociateFlag:=TRUE,doAtmost:=TRUE,MaxCount:=max_relatives).result; 
				
		SHARED VerificationOfOccupancy.Layouts.Layout_VOOShell getRelatives(roll_allHeader le, rolledHdrdids ri) := TRANSFORM
			self.relativeTitle	:= STD.Str.ToUpperCase(TRIM(Header.relative_titles.fn_get_str_title(ri.title)));
			SELF.relativeDID		:= ri.did2; // Keep the relatives DID
			self 								:= le;
		END;

		SHARED allRelatives :=  join(roll_allHeader (DID <> 0), rolledHdrdids, left.DID = right.did1,
												getRelatives(left, right));  //inner join so we save only those who have relatives

		// Initialize the full header and quick header transforms
		SHARED VerificationOfOccupancy_CCPA getHeaderRel(VerificationOfOccupancy.Layouts.Layout_VOOShell l, key_header r) := transform
			SELF.Global_Sid := r.Global_Sid;
		addrmatch							:= trim(l.z5) = trim(r.zip) and
															 trim(l.prim_range) = trim(r.prim_range) and
															 ut.NNEQ(trim(l.sec_range), trim(r.sec_range)) and
															 trim(l.prim_name) = trim(r.prim_name) and
															 trim(l.addr_suffix) = trim(r.suffix) and
															 trim(l.predir) = trim(r.predir) and
															 trim(l.postdir) = trim(r.postdir);
			srcPub 								:= MDR.sourceTools.SourceIsWC(r.src) or  //if source is any of these, set as public source
															 MDR.sourceTools.SourceIsDL(r.src) or
															 MDR.sourceTools.SourceIsVehicle(r.src) or
															 MDR.sourceTools.SourceIsFAA(r.src) or
															 MDR.sourceTools.SourceIsVoters_v2(r.src) or
															 MDR.sourceTools.SourceIsBankruptcy(r.src) or
															 MDR.sourceTools.SourceIsLiens(r.src);
			srcTU									:= MDR.sourceTools.SourceIsTransUnion(r.src);
			srcEQ									:= MDR.sourceTools.SourceIsEquifax(r.src);
			srcEN									:= MDR.sourceTools.SourceIsExperian_Credit_Header(r.src);
			current 							:= trim((string)r.dt_last_seen) >= hdrBuildDate01 OR r.dt_last_seen >= l.historydate; // Need to make sure our "current" calculation still works in history mode
			self.target_addr			:= map(addrmatch and current					=> 2,		//address is target address and is currently updating
																	 addrmatch and not current			=> 1,		//address is target address but not currently updating
																																		 0);	//not target address (other address)
			self.other_addr 			:= map(not addrmatch and current and r.prim_name[1..6] <> 'PO BOX'		=> 2,		//another address (non PO box) exists for this did and is current on the hdr 
																	 not addrmatch and not current and r.prim_name[1..6] <> 'PO BOX'=> 1,		//another address (non PO box) exists but is not currently updating
																																																		 0);
			self.Transunion_seen 	:= if(srcTU and addrmatch, 1, 0); 	//set if addrs matches and src is Transunion
			self.Equifax_seen 		:= if(srcEQ and addrmatch, 1, 0); 	//set if addrs matches and src is Equifax 
			self.Experian_seen 		:= if(srcEN and addrmatch, 1, 0); 	//set if addrs matches and src is Experian 
			self.pub_src_seen 		:= if(srcPub and addrmatch, 1, 0);	//set if addrs matches and src is any public record

			// Translate the Quick Header Equifax sources to just a normal 'EQ' record
			self.h.src						:= IF(r.src IN [MDR.sourceTools.src_Equifax_Quick, MDR.sourceTools.src_Equifax_Weekly], MDR.sourceTools.src_Equifax, r.src);
			self.src_group				:= map( srcTU		=> 'TU',
																		srcEQ		=> 'EQ',
																		srcEN		=> 'EN',
																		srcPub	=> r.src,
																						   '');
			self.h								:= r;
			self									:= l;
		end;

		SHARED VerificationOfOccupancy_CCPA getQHeaderRel(VerificationOfOccupancy.Layouts.Layout_VOOShell l, header_quick.key_DID r) := transform
			SELF.Global_Sid := r.Global_Sid;
		addrmatch							:= trim(l.z5) = trim(r.zip) and
															 trim(l.prim_range) = trim(r.prim_range) and
															 ut.NNEQ(trim(l.sec_range), trim(r.sec_range)) and
															 trim(l.prim_name) = trim(r.prim_name) and
															 trim(l.addr_suffix) = trim(r.suffix) and
															 trim(l.predir) = trim(r.predir) and
															 trim(l.postdir) = trim(r.postdir);
			srcPub 								:= MDR.sourceTools.SourceIsWC(r.src) or  //if source is any of these, set as public source
															 MDR.sourceTools.SourceIsDL(r.src) or
															 MDR.sourceTools.SourceIsVehicle(r.src) or
															 MDR.sourceTools.SourceIsFAA(r.src) or
															 MDR.sourceTools.SourceIsVoters_v2(r.src) or
															 MDR.sourceTools.SourceIsBankruptcy(r.src) or
															 MDR.sourceTools.SourceIsLiens(r.src);
			srcTU									:= MDR.sourceTools.SourceIsTransUnion(r.src);
			srcEQ									:= MDR.sourceTools.SourceIsEquifax(r.src);
			srcEN									:= MDR.sourceTools.SourceIsExperian_Credit_Header(r.src);
			current 							:= trim((string)r.dt_last_seen) >= hdrBuildDate01 OR r.dt_last_seen >= l.historydate; // Need to make sure our "current" calculation still works in history mode
			self.target_addr			:= map(addrmatch and current					=> 2,		//address is target address and is currently updating
																	 addrmatch and not current			=> 1,		//address is target address but not currently updating
																																		 0);	//not target address (other address)
			self.other_addr 			:= map(not addrmatch and current and r.prim_name[1..6] <> 'PO BOX'		=> 2,		//another address (non PO box) exists for this did and is current on the hdr 
																	 not addrmatch and not current and r.prim_name[1..6] <> 'PO BOX'=> 1,		//another address (non PO box) exists but is not currently updating
																																																		 0);
			self.Transunion_seen 	:= if(srcTU and addrmatch, 1, 0); 	//set if addrs matches and src is Transunion
			self.Equifax_seen 		:= if(srcEQ and addrmatch, 1, 0); 	//set if addrs matches and src is Equifax 
			self.Experian_seen 		:= if(srcEN and addrmatch, 1, 0); 	//set if addrs matches and src is Experian 
			self.pub_src_seen 		:= if(srcPub and addrmatch, 1, 0);	//set if addrs matches and src is any public record

			// Translate the Quick Header Equifax sources to just a normal 'EQ' record
			self.h.src						:= IF(r.src IN [MDR.sourceTools.src_Equifax_Quick, MDR.sourceTools.src_Equifax_Weekly], MDR.sourceTools.src_Equifax, r.src);
			self.src_group				:= map( srcTU		=> 'TU',
																		srcEQ		=> 'EQ',
																		srcEN		=> 'EN',
																		srcPub	=> r.src,
																						   '');
			self.h								:= r;
			self									:= l;
		end;

	SHARED with_Header_Relatives_unsuppressed := join(allRelatives, key_header,	
										LEFT.DID <> 0 AND
										keyed(left.relativeDID = right.s_DID) and
										// trim((string)right.dt_last_seen) >= hdrBuildDate01 and
										right.src not in risk_indicators.iid_constants.masked_header_sources_all(DataRestrictionMask, isFCRA) AND
										(RIGHT.dt_first_seen <> 0 AND RIGHT.dt_first_seen <= LEFT.historydate) and // Check the history date
										glb_ok AND
										(	~mdr.Source_is_DPPA(RIGHT.src) OR 
											(dppa_ok AND drivers.state_dppa_ok(header.translateSource(RIGHT.src),DPPA,RIGHT.src))), 
										getHeaderRel(left, right), left outer, keep(200), ATMOST(RiskWise.max_atmost));
                    
    with_Header_Relatives_flagged := Suppress.MAC_FlagSuppressedSource(with_Header_Relatives_unsuppressed, mod_access);

    SHARED with_Header_Relatives := PROJECT(with_Header_Relatives_flagged, TRANSFORM( VerificationOfOccupancy.Layouts.Layout_VOOShell, 
			self.target_addr			:= IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.target_addr);
			self.other_addr 			:= IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.other_addr);
			self.Transunion_seen 	:= IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.Transunion_seen);
			self.Equifax_seen 		:= IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.Equifax_seen);
			self.Experian_seen 		:= IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.Experian_seen);
			self.pub_src_seen 		:= IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.pub_src_seen);
			self.src_group				:= IF(left.is_suppressed, Suppress.OptOutMessage('STRING'), left.src_group);
			self.SubjectAddresses := IF(~left.is_suppressed, left.SubjectAddresses);
			self.h								:= IF(~left.is_suppressed, left.h);
            self := LEFT;
		));
    
	SHARED with_QHeader_Relatives_unsuppressed := join(allRelatives, header_quick.key_DID,			
										LEFT.DID <> 0 AND
										keyed(left.relativeDID = right.DID) and
										// trim((string)right.dt_last_seen) >= hdrBuildDate01 and
										right.src not in risk_indicators.iid_constants.masked_header_sources_all(DataRestrictionMask, isFCRA) + 
										// If we have an Equifax data restriction, restrict the QH and WH sources (This isn't caught in the masked_header_source)
										IF(DataRestrictionMask[Risk_Indicators.iid_constants.posEquifaxRestriction] = '1', [MDR.sourceTools.src_Equifax_Quick, MDR.sourceTools.src_Equifax_Weekly], []) AND
										(RIGHT.dt_first_seen <> 0 AND RIGHT.dt_first_seen <= LEFT.historydate) and // Check the history date
										glb_ok AND
										(	~mdr.Source_is_DPPA(RIGHT.src) OR 
											(dppa_ok AND drivers.state_dppa_ok(header.translateSource(RIGHT.src),DPPA,RIGHT.src))), 
										getQHeaderRel(left, right), keep(200), ATMOST(RiskWise.max_atmost));
                    
	with_QHeader_Relatives_flagged := Suppress.MAC_FlagSuppressedSource(with_QHeader_Relatives_unsuppressed, mod_access);

    SHARED with_QHeader_Relatives := PROJECT(with_QHeader_Relatives_flagged, TRANSFORM( VerificationOfOccupancy.Layouts.Layout_VOOShell, 
			self.target_addr			:= IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.target_addr);
			self.other_addr 			:= IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.other_addr);
			self.Transunion_seen 	:= IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.Transunion_seen);
			self.Equifax_seen 		:= IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.Equifax_seen);
			self.Experian_seen 		:= IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.Experian_seen);
			self.pub_src_seen 		:= IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.pub_src_seen);
			self.src_group				:= IF(left.is_suppressed, Suppress.OptOutMessage('STRING'), left.src_group);
			self.SubjectAddresses := IF(~left.is_suppressed, left.SubjectAddresses);
			self.h								:= IF(~left.is_suppressed, left.h);
            self := LEFT;
		));

	SHARED with_allHeader_Relatives := with_Header_Relatives + with_QHeader_Relatives;
		
	SHARED sort_allHeader_Relatives := sort(with_allHeader_Relatives, seq, relativeDID);

	SHARED with_allSources_Relatives := sort_allHeader_Relatives(trim((string)h.dt_last_seen) >= hdrBuildDate01 OR h.dt_last_seen >= historydate); 

	SHARED dedup_allSources_Relatives := dedup(sort(with_allSources_Relatives, seq, relativeDID, h.src, -h.dt_last_seen), seq, relativeDID, h.src);  //keep only most recent rec per source

	SHARED roll_allSources_Relatives := rollup(dedup_allSources_Relatives, rollSources(left,right), seq);
		
	SHARED roll_allHeader_Relatives := rollup(sort_allHeader_Relatives, rollHeader(left,right), seq);

	SHARED with_srcSeen_Relatives := join(roll_allHeader_Relatives, roll_allSources_Relatives, 
					left.seq = right.seq,
					getSrcSeen(left,right),left outer);  
					
	SHARED VerificationOfOccupancy.Layouts.Layout_VOOShell get_Relatives(VerificationOfOccupancy.Layouts.Layout_VOOShell le, VerificationOfOccupancy.Layouts.Layout_VOOShell ri) := TRANSFORM
			 relativesExist := ri.seq = le.seq;
			  // If we don't have any relatives, set the relative counts to -1/0
			 SELF.target_addr_relatives := IF(relativesExist, ri.target_addr, -1);
			 SELF.other_addr_relatives := IF(relativesExist, ri.other_addr, -1);
			 SELF.Transunion_seen_relatives := IF(relativesExist, ri.Transunion_seen, 0);
			 SELF.Equifax_seen_relatives := IF(relativesExist, ri.Equifax_seen, 0);
			 SELF.Experian_seen_relatives := IF(relativesExist, ri.Experian_seen, 0);
			 SELF.pub_src_seen_relatives := IF(relativesExist, ri.pub_src_seen, 0);
			 SELF.relativeDID := ri.relativeDID;
			 SELF.relativeTitle := ri.relativeTitle;
			 SELF := le;
	END;

	SHARED with_Relatives := JOIN(with_SIC, with_srcSeen_Relatives, LEFT.seq = RIGHT.seq, get_Relatives(LEFT, RIGHT), LEFT OUTER, KEEP(1), ATMOST(RiskWise.max_atmost));

	// *******************************************************************************************************************
	// If subject doesn't own the target address, get spouse property records to see if they do
	// *******************************************************************************************************************

	SHARED VerificationOfOccupancy.Layouts.Layout_VOOShell getSpouseDID(roll_allHeader le, allRelatives ri) := TRANSFORM
		SELF.relativeDID := ri.relativeDID; //move the spouse's DID before calling the property function
		SELF := le;
	END;

	SHARED withSpouse := JOIN(roll_allHeader, allRelatives (TRIM(relativeTitle) IN ['HUSBAND', 'WIFE', 'SPOUSE']), LEFT.seq = RIGHT.seq, getSpouseDID(LEFT, RIGHT), LEFT OUTER, KEEP(1), ATMOST(RiskWise.max_atmost));

	//go get spouse's owned properties - need to move the spouse's DID to the input DID before calling the property ownership function
	SHARED withSpouseProject := project(withSpouse, transform( VerificationOfOccupancy.Layouts.Layout_VOOShell, 
				self.DID 		:= left.relativeDID, 
				self 				:= left));

	SHARED propsOwned	:= VerificationOfOccupancy.getPropOwnership(withSpouseProject, fares_ok); 

	//join spouse's property info back to VOOShell
	SHARED VerificationOfOccupancy.Layouts.Layout_VOOShell getOwnedProps(roll_allHeader le, propsOwned ri) := TRANSFORM
		SELF.target_owned_spouse				:= map(ri.property_match and ri.property_sold = '1'			=> '2',
																					 ri.property_match and ri.property_owned = '1'		=> '1',
																																															 '0');
		SELF.other_owned_spouse					:= map(~ri.property_match and ri.property_sold = '1'		=> '2',
																					 ~ri.property_match and ri.property_owned = '1'		=> '1',
																																															 '0');
		SELF 														:= le;
	END;	

	SHARED with_Owned := join(with_Relatives, propsOwned, 
				left.seq = right.seq,
				getOwnedProps(left,right),left outer);

	SHARED sortProperty := sort(with_Owned, seq);

	//rollup by seq to set the owned/sold flags for the target address and other address owned by the spouse 
	SHARED VerificationOfOccupancy.Layouts.Layout_VOOShell rollProperty(VerificationOfOccupancy.Layouts.Layout_VOOShell l, VerificationOfOccupancy.Layouts.Layout_VOOShell r) := transform
		self.target_owned_spouse 	:= max(l.target_owned_spouse, r.target_owned_spouse);
		//if a property other than target comes back as being currently owned by the spouse, retain status of '1' to indicate they own other property
		self.other_owned_spouse 	:= if(l.other_owned_spouse='1' or r.other_owned_spouse='1', '1', max(l.other_owned_spouse, r.other_owned_spouse));
		self														:= l;
	end;
		
	SHARED rolled_Property := rollup(sortProperty, rollProperty(left,right), seq);				

	SHARED propKey := LN_PropertyV2.key_prop_address_v4;
	SHARED propDIDKey := LN_PropertyV2.key_property_did(isFCRA := FALSE);
	SHARED searchKey := LN_PropertyV2.key_search_fid(isFCRA := FALSE);

	SHARED faresRec := RECORD
		Risk_Indicators.Layout_Output;
		DATASET({STRING12 ln_fare_id}) fares; // For use with the address based propKey
		STRING12 ln_fares_id := ''; // For use with the DID based propDIDKey
	END;

	//Search property by address to determine if someone other than the input subject owns the target address
	SHARED faresRec getFares(withSpouse le, propKey ri) := TRANSFORM
		SELF.fares := ri.fares;
		SELF.riskwiseID := (string)le.relativeDID;
		SELF := le;
		SELF := [];
	END;

	SHARED propFares := JOIN(withSpouse, propKey, TRIM(LEFT.Prim_Range) <> '' AND TRIM(LEFT.Prim_Name) <> '' AND TRIM(LEFT.z5) <> '' AND
																															KEYED(LEFT.Prim_Range = RIGHT.Prim_Range AND LEFT.Prim_Name = RIGHT.Prim_Name AND LEFT.Sec_Range = RIGHT.Sec_Range AND LEFT.Z5 = RIGHT.ZIP AND
																																		LEFT.Addr_Suffix = RIGHT.Suffix AND LEFT.PreDir = RIGHT.PreDir AND LEFT.PostDir = RIGHT.PostDir),
																													getFares(LEFT, RIGHT), LEFT OUTER, KEEP(200), ATMOST(RiskWise.max_atmost));

	SHARED VerificationOfOccupancy.Layouts.Layout_VOOShell getFaresAddress(faresRec le, searchKey ri) := TRANSFORM
		SELF.Seq := le.seq; 
		SELF.DID := le.DID; // Subject DID
		SELF.relativeDID := (UNSIGNED)le.riskwiseID; // Spouse DID 

		purchaseAge := (INTEGER)UT.DaysApart((STRING)Risk_Indicators.iid_constants.myGetDate((UNSIGNED)IF((UNSIGNED)((string)ri.dt_first_seen)[5..6] = 0, 
																																																		 ((string)ri.dt_first_seen)[1..4] + '01', 
																																																		 ((string)ri.dt_first_seen)[1..6])), 
																				 (STRING)Risk_Indicators.iid_constants.myGetDate((UNSIGNED)le.historydate));
		
		// 1 indicates property was purchased > 1 year ago, 2 indicates <= 1 year
		SELF.SubjectPropertyIndicator := MAP(COUNT(le.fares) = 0																	=> -1,
																					purchaseAge > Risk_Indicators.iid_constants.oneyear => 1, 
																					purchaseAge <= Risk_Indicators.iid_constants.oneyear=> 2,
																																																 -1);
		fname_match := Risk_Indicators.g(Risk_Indicators.FnameScore(le.fname,ri.fname));
		lname_match := Risk_Indicators.g(Risk_Indicators.LnameScore(le.lname,ri.lname));
		
		//if DIDs (subject and spouse) do not match and names are different, we've identified a different owner of the target property	
		SELF.target_addr_other := MAP(COUNT(le.fares) = 0																																													=> 0,
																	ri.DID <> 0 AND ri.DID <> le.DID AND ri.DID <> (UNSIGNED)le.riskwiseID AND (~fname_match OR ~lname_match)		=> 1, 
																																																																								 0);
		SELF := le;
		SELF := [];
	END;

	SHARED faresByAddress := JOIN(propFares, searchKey, (fares_ok or right.ln_fares_id[1]<>'R') and 
																							  KEYED(RIGHT.ln_fares_id IN SET(LEFT.fares, ln_fare_id)) AND
																							  wild(right.which_orig) and
																							  keyed(RIGHT.source_code_2='P') AND
																							  keyed(RIGHT.source_code_1 in ['O']) AND
																							  RIGHT.prim_name <> '' and RIGHT.zip <> '' AND
																							 (RIGHT.dt_first_seen <> 0 AND RIGHT.dt_first_seen <= LEFT.historydate), 
																							getFaresAddress(LEFT, RIGHT), LEFT OUTER, KEEP(1000), ATMOST(RiskWise.max_atmost));

	SHARED sortFaresByAddress := sort(faresByAddress, seq);
																													
	SHARED rolledFaresAddress := ROLLUP(sortFaresByAddress, LEFT.seq = RIGHT.seq, TRANSFORM(VerificationOfOccupancy.Layouts.Layout_VOOShell, 
																										SELF.SubjectPropertyIndicator := IF(RIGHT.SubjectPropertyIndicator > LEFT.SubjectPropertyIndicator, RIGHT.SubjectPropertyIndicator, LEFT.SubjectPropertyIndicator);
																										SELF.target_addr_other := IF(RIGHT.target_addr_other > LEFT.target_addr_other, RIGHT.target_addr_other, LEFT.target_addr_other);
																										SELF := LEFT));

	//append info from address match to main VOO shell
	SHARED VerificationOfOccupancy.Layouts.Layout_VOOShell getAddrInfo(with_Relatives le, rolledFaresAddress ri) := TRANSFORM
		SELF.target_addr_other 				:= ri.target_addr_other;
		SELF.SubjectPropertyIndicator := ri.SubjectPropertyIndicator;
		SELF 													:= le;
	END;	

	SHARED with_AddrInfo := join(rolled_Property, rolledFaresAddress, 
				left.seq = right.seq,
				getAddrInfo(left,right),left outer);

	// **************************************************************************************************************************
	// Append the first/last seen dates calculated earlier that are based off of all header activity (regardless of history date) 
	// **************************************************************************************************************************
	SHARED VerificationOfOccupancy.Layouts.Layout_VOOShell getFirstLastDates(with_AddrInfo le, roll_allHeaderDates ri) := TRANSFORM
		self.h.dt_first_seen 	:= ri.h.dt_first_seen;
		self.h.dt_last_seen 	:= ri.h.dt_last_seen;
		SELF 									:= le;
	END;	

	SHARED final_VOO_Shell := join(with_AddrInfo, roll_allHeaderDates, 
				left.seq = right.seq,
				getFirstLastDates(left,right),left outer);

		SHARED VerificationOfOccupancy.Layouts.Layout_VOOBatchOut tfEmpty(VOO_In le) := transform
			self.seq																									:= le.seq;
			SELF.AcctNo																								:= le.AcctNo;
			self 																											:= [];
		end;

		SHARED emptyAttr := project(VOO_In, tfEmpty(left));
				
	// *******************************************************************************************************************
	// Now that we have all necessary data in the VOOShell, pass it to the attributes function to produce the attributes
	// *******************************************************************************************************************
	  SHARED attributes := if(STD.Str.ToUpperCase(AttributesVersion) in ['VOOATTRV1', 'PARATTRV1'] and glb_ok, //if valid attributes version requested, go get attributes
										 VerificationOfOccupancy.getAttributes(final_VOO_Shell, DataRestrictionMask, glb_ok, dppa_ok),
										 emptyAttr);  

		SHARED wScore := if(STD.Str.ToUpperCase(AttributesVersion) in ['VOOATTRV1', 'PARATTRV1'] and IncludeModel and glb_ok,		//if score is requested, go append it and the Inferred Ownership attribute, else just return attributes
								 VerificationOfOccupancy.getscore(attributes, final_VOO_Shell, DataRestrictionMask, glb_ok, dppa, isUtility, dppa_ok,mod_access), 
								 attributes);
								 
		SHARED wVOOReport := if(IncludeReport,
									VerificationOfOccupancy.getReport(final_VOO_Shell, wScore, DataRestrictionMask, glba, dppa, isUtility, IncludeReport, fares_ok,Mod_Access),
									PROJECT(wScore, TRANSFORM(VerificationOfOccupancy.Layouts.Layout_VOOBatchOutReport, SELF := LEFT; SELF := []))); // Project the Score into the same Report layout so we can do this IF statement
		
		SHARED wPARReport := if(IncludeReport,
									VerificationOfOccupancy.getReportPAR(final_VOO_Shell, wScore, DataRestrictionMask, glba, dppa, isUtility, IncludeReport, fares_ok,mod_Access),
									PROJECT(wScore, TRANSFORM(VerificationOfOccupancy.Layouts.Layout_PARBatchOutReport, SELF := LEFT; SELF := []))); // Project the Score into the same Report layout so we can do this IF statement
									
	/* ********************
	 *  Debugging Section *
	 **********************/
		// output(iid_prep, named('iid_prep'));
	  // output(with_DID, named('with_DID'));
	  // output(with_Header, named('with_Header'));
	  // output(with_QHeader, named('with_QHeader'));
	  // output(with_allHeader, named('with_allHeader'));
	  // output(with_HeaderDates, named('with_HeaderDates'));
	  // output(with_QHeaderDates, named('with_QHeaderDates'));
	  // output(with_allHeaderDates, named('with_allHeaderDates'));
	  // output(sort_allHeaderDates, named('sort_allHeaderDates'));
	  // output(roll_allHeaderDates, named('roll_allHeaderDates'));
	  // output(sort_allHeader, named('sort_allHeader'));
	  // output(with_Crim, named('with_Crim'));
	  // output(with_allSources, named('with_allSources'));
	  // output(dedup_allSources, named('dedup_allSources'));
	  // output(roll_allSources, named('roll_allSources'));
	  // output(sort_allHeader, named('sort_allHeader'));
	  // output(roll_allHeader, named('roll_allHeader'));
	  // output(with_srcSeen, named('with_srcSeen'));
	  // output(inquiry_Recs, named('inquiry_Recs'));
	  // output(dedup_inquiries, named('dedup_inquiries'));
	  // output(inq_hdr_recs, named('inq_hdr_recs'));
	  // output(rolled_inqHdr, named('rolled_inqHdr'));
	  // output(with_inqFields, named('with_inqFields'));
	  // output(with_mailingAddr, named('with_mailingAddr'));
	  // output(with_PriorRes, named('with_PriorRes'));
	  // output(with_PriorAddr, named('with_PriorAddr'));
	  // output(with_inferOwner, named('with_inferOwner'));
	  // output(with_DOD, named('with_DOD'));
	  // output(dedup_DOD, named('dedup_DOD'));
		// output(incarcerated_data, named('incarcerated_data'));
	  // output(with_incarc, named('with_incarc'));
	  // output(pre_ADVO, named('pre_ADVO'));
	  // output(advo_hits, named('advo_hits'));
	  // output(with_ADVO, named('with_ADVO'));
	  // output(with_SIC, named('with_SIC'));
	  // output(prepRelativeAppend, named('prepRelativeAppend'));
	  // output(withRelativeAppend, named('withRelativeAppend'));
	  // output(relativeAppendSorted, named('relativeAppendSorted'));
	  // output(withRelativeTitle, named('withRelativeTitle'));
	  // output(withRelatives, named('withRelatives'));
	  // output(with_DID_Relatives, named('with_DID_Relatives'));
	  // output(allRelatives, named('allRelatives'));
	  // output(with_Header_Relatives, named('with_Header_Relatives'));
	  // output(with_QHeader_Relatives, named('with_QHeader_Relatives'));
	  // output(with_allHeader_Relatives, named('with_allHeader_Relatives'));
	  // output(sort_allHeader_Relatives, named('sort_allHeader_Relatives'));
	  // output(with_allSources_Relatives, named('with_allSources_Relatives'));
	  // output(dedup_allSources_Relatives, named('dedup_allSources_Relatives'));
	  // output(roll_allSources_Relatives, named('roll_allSources_Relatives'));
	  // output(roll_allHeader_Relatives, named('roll_allHeader_Relatives'));
	  // output(with_srcSeen_Relatives, named('with_srcSeen_Relatives'));
	  // output(with_Relatives, named('with_Relatives'));
	  // output(withSpouse, named('withSpouse'));
	  // output(withSpouseProject, named('withSpouseProject'));
	  // output(propsOwned, named('propsOwned2'));
	  // output(with_Owned, named('with_Owned2'));
	  // output(sortProperty, named('sortProperty2'));
	  // output(rolled_Property, named('rolled_Property2'));
	  // output(propFares, named('propFares'));
	  // output(faresByAddress, named('faresByAddress'));
	  // output(rolledFaresAddress, named('rolledFaresAddress'));
	  // output(with_AddrInfo, named('with_AddrInfo'));
	  // output(propDIDFaresTemp, named('propDIDFaresTemp'));
	  // output(propDIDFares, named('propDIDFares'));
	  // output(faresByDID, named('faresByDID'));
	  // output(sortfaresByDID, named('sortfaresByDID'));
	  // output(rolled_faresByDID, named('rolled_faresByDID'));
	  // output(with_AddrSpouse, named('with_AddrSpouse'));
	  // output(sortOtherAddr, named('sortOtherAddr'));
	  // output(rolled_OtherAddr, named('rolled_OtherAddr'));
	  // output(rolled_OtherAddrSeq, named('rolled_OtherAddrSeq'));
	  // output(with_OtherAddr, named('with_OtherAddr'));
	  // output(with_AddrInfo, named('with_AddrInfo'));
	  // output(final_VOO_Shell, named('final_VOO_Shell'));
	  // output(attributes, named('attributes'));
	/* ********************/
	/* ********************/

		EXPORT VOOReport := wVOOReport;	
		EXPORT PARReport := wPARReport;	
		
	END;
