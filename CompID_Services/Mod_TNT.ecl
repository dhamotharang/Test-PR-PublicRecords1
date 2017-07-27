IMPORT Address, AutoStandardI, CompId, DidVille, Drivers, DriversV2_Services, Doxie, Header, MDR, WatchDog, ut;

EXPORT Mod_TNT := MODULE

	// Modules
	shared common 		:= CompId_Services.Mod_Common;
	
	// Layouts
	shared layoutHistory 				 			:= CompId_Services.Layouts.Layout_History;
	shared layoutCompIdResult					:= CompId_Services.Layouts.Layout_CompId_Result;	
	
	/* Retrieve Name and Current Address from MAC_Best_Records */
	getBestRecords_v1(GROUPED DATASET(DidVille.Layout_Did_OutBatch) DID_Stream, 
																				 BOOLEAN ValidSSN,
																				 BOOLEAN UseNonBlankFields) := FUNCTION
		
		// Get Best Records
		Is_DPPA := true; 
		Is_GLB := ut.glb_ok(AutoStandardI.GlobalModule().GLBPurpose);
		Doxie.MAC_Best_Records(DID_Stream, Did, BestRecords, Is_DPPA, Is_GLB, UseNonBlankFields, doxie.DataRestriction.fixed_DRM);
		DIDs := UNGROUP(PROJECT (BestRecords, Doxie.Layout_References));
		
		// Convert BestRecords to Layout_History format
		layoutHistory XformBestRecords(BestRecords R) := TRANSFORM
			SELF.dt_max_seen	:= R.addr_dt_last_seen;	
			SELF.dt_last_seen	:= R.addr_dt_last_seen;	
			SELF.score				:= 0;
			SELF.seq         	:= 0;
			SELF.gender				:= '';
			SELF.dod					:= ut.Date_MMDDYYYY_I2(R.dod);
			SELF.dob					:= ut.Date_MMDDYYYY_I2((STRING)R.dob);
			SELF.city					:= R.city_name;
			SELF.state				:= R.st;
			SELF.src					:= '';
			SELF.bestRec			:= TRUE;
			SELF.addr 				:= Address.Addr1FromComponents('', r.predir, r.prim_name, r.suffix, r.postdir, '', '');
			SELF              := r;
		END;
		
		RETURN PROJECT(BestRecords, XformBestRecords(LEFT));
	END;
	
	/* Get BestRecords by calling the macro that has Equifax header data filtered out */
	getBestRecords(GROUPED DATASET(DidVille.Layout_Did_OutBatch) DID_Stream) := FUNCTION
		
		// Convert BestRecords to layoutHistory format
		layoutHistory XformBestRecords(CompID.Key_Best_CompID_DID R) := TRANSFORM
			SELF.dt_max_seen	:= R.addr_dt_last_seen;	
			SELF.dt_last_seen	:= R.addr_dt_last_seen;	
			SELF.score				:= 0;
			SELF.seq         	:= 0;
			SELF.gender				:= '';
			SELF.dod					:= ut.Date_MMDDYYYY_I2(R.dod);
			SELF.dob					:= ut.Date_MMDDYYYY_I2((STRING)R.dob);
			SELF.city					:= R.city_name;
			SELF.state				:= R.st;
			SELF.src					:= '';
			SELF.bestRec			:= TRUE;
			SELF.addr 				:= Address.Addr1FromComponents('', r.predir, r.prim_name, r.suffix, r.postdir, '', '');
			SELF              := r;
		END;

		RETURN JOIN(DID_Stream, CompID.Key_Best_CompID_DID, LEFT.did = RIGHT.did, XformBestRecords(RIGHT));
		//RETURN JOIN(DID_Stream, CompID.Key_Best_CompID_DID, LEFT.did = RIGHT.did, TRANSFORM(layoutHistory, SELF.DOD:=0, SELF.city:=RIGHT.city_name, SELF.addr := Address.Addr1FromComponents('', r.predir, r.prim_name, r.suffix, r.postdir, '', ''), SELF:=RIGHT, SELF:=[]));
	END;
	
	/* Assign score */
	DATASET(layoutHistory) getBestRecsWithScore(GROUPED DATASET(layoutHistory) BestRecords,
																							 GROUPED DATASET(DidVille.Layout_Did_OutBatch) DID_Stream) := FUNCTION
		
		// Convert AHist to layoutHistory format
		layoutHistory XformScore(layoutHistory L, DID_Stream R) := TRANSFORM
			SELF.score := R.score;
			SELF.seq 	 := R.seq;
			SELF 			 := L;
		END;
		
		RETURN JOIN(BestRecords, DID_Stream, LEFT.DID = RIGHT.DID, XformScore(LEFT, RIGHT));
	END;
	
	EXPORT getMSNameAndAddress(GROUPED DATASET(DidVille.Layout_Did_OutBatch) DID_Stream, 
														 GROUPED DATASET(layoutHistory) AddressHist, 
														 BOOLEAN ValidSSN = false, 
														 BOOLEAN UseNonBlankFields = false,
														 BOOLEAN UseNoEQBest = false) := FUNCTION

		ps(STRING i) := IF (i='','',TRIM(i)+' ');

		// Get the BestRecords & Assign Score
		BestRecords := IF (UseNoEQBest = false,
											 getBestRecords_v1(DID_Stream, ValidSSN, UseNonBlankFields),
											 getBestRecords(DID_Stream));
		BestRecsWithScore := getBestRecsWithScore(BestRecords, DID_Stream);
		
		// Combine Best with History and Ignore Deceased
		AllRecords := (BestRecsWithScore + AddressHist) (~Address.isDeathRecord(addr));

		// Filter out duplicate addresses
		FilteredRecs := common.filterDuplicates(AllRecords);
		
		// Build Result's Name and Current Address
		ResultFromBest := common.buildResultFromBest(FilteredRecs);
		
		// Build Result's Prior Addresses
		ResultFromHist := common.buildResultFromHist(ResultFromBest, FilteredRecs);
		
		// Add Remarks
		ResultWithRemarks := common.addRemarks(ResultFromHist, AllRecords);
		
		// Debug Statements
		// OUTPUT(BestRecords, NAMED('BestRecords'));
		// OUTPUT(AddressHist, NAMED('AddressHist'));
		// OUTPUT(BestRecsWithScore, NAMED('BestRecsWithScore'));
		// OUTPUT(AllRecords, NAMED('AllRecords'));
		// OUTPUT(FilteredRecs, NAMED('FilteredRecs'));
		// OUTPUT(ResultFromBest, NAMED('ResultFromBest'));
		// OUTPUT(ResultFromHist, NAMED('ResultFromHist'));
		// OUTPUT(ResultWithRemarks, NAMED('ResultWithRemarks'));
		
		RETURN ResultWithRemarks;

	END;
	
	/* Filter out DIDs based on Score and Validity */
	EXPORT GROUPED DATASET(DidVille.Layout_Did_Outbatch) cleanupDIDs(GROUPED DATASET(DidVille.Layout_Did_Outbatch) DID_Hits, STRING appends, UNSIGNED3 MinScore) := FUNCTION
		DidVille.MAC_HHid_Append(DID_Hits, appends, DID_HH_Hits);

		DID_HH0_Hits := if (StringLib.StringFind(appends,'HHID_',1)=0, DID_Hits, DID_HH_Hits);
		DID_Valid_Hits   := DID_HH0_Hits(did <> 0);

		// Ignore any records that does not meet Cutoff limits
		CutoffScore	:= if (MinScore > 0, MinScore, Constants.Qualify_Score);

		// OUTPUT (DID_HH_Hits, NAMED('DID_HH_Hits'));
		// OUTPUT (DID_HH0_Hits, NAMED('DID_HH0_Hits'));
		// OUTPUT (DID_Valid_Hits, NAMED('DID_Valid_Hits'));
		
		RETURN DID_Valid_Hits(score >= CutoffScore);
	END;

	/* Returns Address History */
	EXPORT GROUPED DATASET(layoutHistory) getAddressHistory(GROUPED DATASET(DidVille.Layout_Did_Outbatch) DID_Hits_With_Score, BOOLEAN GLBin) := FUNCTION
		doxie.MAC_Header_Field_Declare()
		// Retrieve History records into new new record layout
		layoutHistory_ext := record
			layoutHistory;
			unsigned rid;
			string1 pflag3 := '';
			unsigned3    dt_nonglb_last_seen := 0;
			string1	   valid_SSN := '';
		end;
		
		layoutHistory_ext XformHistoryRecords(DID_Hits_With_Score L, Doxie.Key_Header R) := TRANSFORM
			SELF.prim_range 	:= R.prim_range;
			SELF.city 				:= R.city_name;
			SELF.state 				:= R.st;
			SELF.zip 					:= R.zip;
			SELF.zip4 				:= R.zip4;
			SELF.dob					:= ut.Date_MMDDYYYY_I2((STRING)R.dob);
			SELF.dt_last_seen := MAP( ~GLBin => R.dt_nonglb_last_seen, R.dt_last_seen <> 0 => R.dt_last_seen, 0); 
			SELF.seq          := L.seq;
			SELF.gender				:= '';
			SELF.score 				:= L.score;
			SELF.dod					:= ut.Date_MMDDYYYY_I2(L.best_dod);
			SELF.addr 				:= Address.Addr1FromComponents('', R.predir, R.prim_name, R.suffix, R.postdir, '', '');
			SELF.dt_max_seen  := R.dt_last_seen;

			SELF              := R;
		END;
		
		// Convert History records into layoutHistory format
		HistoryRecs := JOIN(DID_Hits_With_Score, Doxie.Key_Header,
										KEYED(LEFT.did = RIGHT.s_did) AND
										~MDR.Source_is_on_Probation(RIGHT.src) AND (RIGHT.src<>'EQ' OR Header.isPreGLB(RIGHT)) AND
										(~doxie.DataRestriction.ECH OR ~MDR.sourceTools.SourceIsExperian_Credit_Header(RIGHT.src)) AND
										ut.PermissionTools.dppa.state_ok(Header.translateSource(RIGHT.src), 6, RIGHT.src),
										XformHistoryRecords(left, right));
		Header.Mac_GLBClean_Header(HistoryRecs, HistoryRecsCleaned);
		/*
		//Not used...
		// Convert History records into layoutHistory format
		OldHistoryRecs := JOIN(DID_Hits_With_Score, Doxie.Key_Header,
										KEYED(LEFT.did = RIGHT.s_did) AND
										(~doxie.DataRestriction.ECH OR ~MDR.sourceTools.SourceIsExperian_Credit_Header(RIGHT.src)),
										XformHistoryRecords(left, right));*/ 
		
		// FilteredHistRecs := HistoryRecs (MDR.Source_is_on_Probation(src) AND (src<>'EQ' OR Header.isPreGLB(DPPA_Six(src='EQ'))));
		
		// OUTPUT(OldHistoryRecs, NAMED('OldHistoryRecs'));
		// OUTPUT(HistoryRecs, NAMED('HistoryRecs'));
		// OUTPUT(HeaderRecs, NAMED('HeaderRecs'));
		// OUTPUT(FilteredHeaderRecs, NAMED('FilteredHeaderRecs'));
		RETURN project(HistoryRecsCleaned, LayoutHistory);
	END;

	/* Get Driver Licence Information */
	EXPORT DATASET(layoutCompIdResult) getDriverLicence(DATASET(layoutCompIdResult) ResultWithNameAndAddress) := FUNCTION
		
		// Get all Driver records for the matching DIDs
		pDIDs := UNGROUP(PROJECT(ResultWithNameAndAddress, Doxie.Layout_References));
		DLRecs := DriversV2_Services.DLRaw.narrow_view.by_did(pDIDs);
		
		// Get only 'Current' information
		FilteredDLRec := TOPN(DLRecs(History_Name='Current'), 1, -Expiration_Date);
		
		// Mash it into Resultant address record
		layoutCompIdResult XformDriver (ResultWithNameAndAddress L, FilteredDLRec R) := TRANSFORM
			SELF.DID 												:= L.DID;
			SELF.currentDL.dlState 					:= R.orig_state;
			SELF.currentDL.dl_number 				:= R.dl_number;
			SELF.currentDL.lic_issue_date 	:= ut.Date_MMDDYYYY_I2((STRING)R.lic_issue_date);
			SELF.currentDL.expiration_date  := ut.Date_MMDDYYYY_I2((STRING)R.expiration_date);
			SELF.currentDL.restrictions 		:= R.restrictions_delimited;
			SELF.currentDL.license_class  	:= R.license_class;
			SELF.currentDL.license_type 		:= R.license_type;
			SELF.gender 										:= R.sex_flag;
			
			SELF := L;
		END;
		
		RETURN JOIN (ResultWithNameAndAddress, FilteredDLRec, 
									LEFT.DID = RIGHT.DID,
									XformDriver(LEFT, RIGHT), LEFT OUTER);

	END;

END;
