IMPORT Address, AutoHeaderI, AutoStandardI, Doxie, WatchDog, Doxie, DriversV2_Services, CompId_Services, CompId, DidVille, ut;

EXPORT Mod_Common := MODULE
  
	// Doxie Reference
	shared layout_Doxie_Reference			:= Doxie.Layout_References;
	shared layout_Doxie_Reference_HH	:= Doxie.Layout_References_hh;
	shared layout_Doxie_Presentation 	:= Doxie.Layout_Presentation;

	shared layoutHistory 				 			:= CompId_Services.Layouts.Layout_History;
	shared layoutCompIdResult					:= CompId_Services.Layouts.Layout_CompId_Result;	

	/* Retrieve Name and Current Address from MAC_Best_Records*/
	export DATASET(layoutHistory) getBestRecords_v1(DATASET(layout_Doxie_Reference_HH) DIDs) := FUNCTION
		
		// Get Best Records
		Is_DPPA := true; 
		Is_GLB := ut.glb_ok(AutoStandardI.GlobalModule().GLBPurpose); 
		ValidSSN := true; 
		UseNonBlankFields := true;
		Doxie.MAC_Best_Records(DIDs, Did, BestRecords, Is_DPPA, Is_GLB, UseNonBlankFields, doxie.DataRestriction.fixed_DRM);
		
		// Convert BestRecords to layoutHistory format
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
	export getBestRecords(DATASET(layout_Doxie_Reference_HH) DIDs) := FUNCTION
		
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

		RETURN JOIN(DIDs, CompID.Key_Best_CompID_DID, LEFT.did = RIGHT.did, XformBestRecords(RIGHT));
	END;
	
	/* Returns Address History */
	export DATASET(layout_Doxie_Presentation) getAddressHistory(DATASET(layout_Doxie_Reference_HH) DIDs) := FUNCTION
		// DPPA = 6 (sources), GLB = 0 (PreGLB)
		Is_DPPA := 6; Is_GLB := 0;
		
		bothMod := Doxie.Mod_Header_Records( 
				true,					
				true,					
				true,					
				0,						
				Is_DPPA,  
				Is_GLB,		
				false,  			
				true,					
				false);
		
		HeaderRecs := bothMod.Results(DIDs);
		
		// tMod := Doxie.Mod_Header_Records( 
				// true,					
				// true,					
				// true,					
				// 0,						
				// 1,  
				// 1,		
				// false,  			
				// true,					
				// false);
		
		// OldHeaderRecs := bothMod.Results(DIDs);
		// OUTPUT(HeaderRecs, NAMED('HeaderRecs'));
		// OUTPUT(OldHeaderRecs, NAMED('OldHeaderRecs'));
		
		// Ignore records with prim name=''
		RETURN HeaderRecs (prim_name <> '');
	END;
	
	/* Transform Address History to layoutHistory */
	export DATASET(layoutHistory) formatHistory(DATASET(layout_Doxie_Presentation) HistoryRecs) := FUNCTION
	
		// Mop History into layoutHistory
		layoutHistory XformHistoryRecords(layout_Doxie_Presentation R) := TRANSFORM
			SELF.prim_range 	:= R.prim_range;
			SELF.city 				:= R.city_name;
			SELF.state 				:= R.st;
			SELF.zip 					:= R.zip;
			SELF.zip4 				:= R.zip4;
			SELF.dob					:= ut.Date_MMDDYYYY_I2((STRING)R.dob);
			SELF.dt_last_seen := MAP( R.dt_last_seen <> 0 => R.dt_last_seen, 0); 
			SELF.gender				:= '';
			SELF.score 				:= 0;
			SELF.dod					:= 0;
			SELF.addr 				:= Address.Addr1FromComponents('', R.predir, R.prim_name, R.suffix, R.postdir, '', '');
			SELF.dt_max_seen	:= R.dt_last_seen;	
			SELF              := R;
		END;
		
		RETURN PROJECT(HistoryRecs, XformHistoryRecords(LEFT));
	END;
	
	/* Filter out Duplicate Addresses */
	export DATASET(layoutHistory) filterDuplicates(DATASET(layoutHistory) AllRecords) := FUNCTION
		// Sort AllRecords
		SortedRecs := SORT(AllRecords, prim_range, prim_name, -sec_range, -predir, if(suffix<>'',0,1), -zip4, 
											 bestRec, -dt_last_seen, dt_first_seen, -fname, -mname, -lname);
		
		// Remove Duplicate Records
		layoutHistory removeDuplicates(layoutHistory L, layoutHistory R) := TRANSFORM
			SELF.dt_first_seen := if (R.dt_first_seen = 0 or (L.dt_first_seen < R.dt_first_seen and L.dt_first_seen>0),
																	L.dt_first_seen,
																	R.dt_first_seen);

			SELF.dt_max_seen := if (L.dt_max_seen > R.dt_max_seen, 
																L.dt_max_seen, 
																R.dt_max_seen );

			SELF.tnt := if (Doxie.tnt_score(R.tnt) > 0 and Doxie.tnt_score(R.tnt) < Doxie.tnt_score(L.tnt), 
												R.tnt, 
												L.tnt);

			SELF := MAP (L.bestRec = true => L,
										 R.bestRec = true => R,
										 L);
		END;
		
		FilteredRecs := ROLLUP (SortedRecs, LEFT.prim_range=RIGHT.prim_range AND
																				(LEFT.prim_name=RIGHT.prim_name OR RIGHT.zip4='' AND 
																					(ut.StringSimilar(LEFT.prim_name, RIGHT.prim_name) < 3 OR
																						LENGTH(TRIM(LEFT.prim_range))>2 ))
																				AND ut.nneq(LEFT.predir, RIGHT.predir) 
																				AND ut.Sec_Range_Eq(LEFT.sec_range,RIGHT.sec_range)<10, 
																				removeDuplicates(LEFT,RIGHT));

		finalOutput := SORT(FilteredRecs, -bestRec, -dt_last_seen, dt_first_seen);
		
		return finalOutput;
	END;
	
	/* Build Result with Name and Current Address Details using BestRecord */
	export DATASET(layoutCompIdResult) buildResultFromBest(DATASET(layoutHistory) FilteredRecs) := FUNCTION
	
		layoutCompIdResult XformBestRecord (FilteredRecs L) := TRANSFORM
			SELF.DID 													:= L.DID;
			SELF.seq 													:= L.seq;
			SELF.name_first 									:= L.fname;
			SELF.name_middle 									:= L.mname;
			SELF.name_last 										:= L.lname;
			SELF.name_suffix 									:= L.name_suffix;
			SELF.ssn 													:= L.ssn;
			SELF.gender 											:= L.gender;
			SELF.dob 													:= L.dob;
			SELF.DOD 													:= L.dod;
			SELF.score												:= L.score;
			SELF.currentAddress.prim_range		:= L.prim_range;
			SELF.currentAddress.addr 					:= L.addr;
			SELF.currentAddress.unit 					:= L.sec_range;
			SELF.currentAddress.city 					:= L.city;
			SELF.currentAddress.state 				:= L.state;
			SELF.currentAddress.zip 					:= L.zip;
			SELF.currentAddress.zip4 					:= L.zip4;
			SELF.resType						 					:= ' ';
			SELF.currentAddress.dt_first_seen := L.dt_first_seen;
			SELF.currentAddress.dt_max_seen 	:= L.dt_last_seen;
			SELF := [];
		END;
		
		RETURN PROJECT (FilteredRecs(bestRec=true), XformBestRecord(LEFT));

	END;
	
	/* Using AddressHistory records, build the Result's Prior address */
	export DATASET(layoutCompIdResult) buildResultFromHist(DATASET(layoutCompIdResult) ResultFromBest, DATASET(layoutHistory) FilteredRecs) := FUNCTION
	
		layoutCompIdResult XformHistory (ResultFromBest L, FilteredRecs R, INTEGER C) := TRANSFORM
			SELF.DID := L.DID;
			
			SELF.priorAddress1.prim_range 		:= IF (C = 1, R.prim_range, L.priorAddress1.prim_range);
			SELF.priorAddress1.addr 					:= IF (C = 1, R.addr, L.priorAddress1.addr);
			SELF.priorAddress1.unit 					:= IF (C = 1, R.sec_range, L.priorAddress1.unit);
			SELF.priorAddress1.city 					:= IF (C = 1, R.city, L.priorAddress1.city);
			SELF.priorAddress1.state 					:= IF (C = 1, R.state, L.priorAddress1.state);
			SELF.priorAddress1.zip 						:= IF (C = 1, R.zip, L.priorAddress1.zip);
			SELF.priorAddress1.zip4 					:= IF (C = 1, R.zip4, L.priorAddress1.zip4);
			SELF.priorAddress1.dt_max_seen 		:= 0; //IF (C = 1, R.dt_max_seen, L.priorAddress1.dt_max_seen);
			SELF.priorAddress1.dt_first_seen 	:= 0; //IF (C = 1, R.dt_first_seen, L.priorAddress1.dt_first_seen);

			SELF.priorAddress2.prim_range 		:= IF (C = 2, R.prim_range, L.priorAddress2.prim_range);
			SELF.priorAddress2.addr 					:= IF (C = 2, R.addr, L.priorAddress2.addr);
			SELF.priorAddress2.unit 					:= IF (C = 2, R.sec_range, L.priorAddress2.unit);
			SELF.priorAddress2.city 					:= IF (C = 2, R.city, L.priorAddress2.city);
			SELF.priorAddress2.state 					:= IF (C = 2, R.state, L.priorAddress2.state);
			SELF.priorAddress2.zip 						:= IF (C = 2, R.zip, L.priorAddress2.zip);
			SELF.priorAddress2.zip4 					:= IF (C = 2, R.zip4, L.priorAddress2.zip4);
			SELF.priorAddress2.dt_max_seen 		:= 0;
			SELF.priorAddress2.dt_first_seen 	:= 0;

			SELF.priorAddress3.prim_range 		:= IF (C = 3, R.prim_range, L.priorAddress3.prim_range);
			SELF.priorAddress3.addr 					:= IF (C = 3, R.addr, L.priorAddress3.addr);
			SELF.priorAddress3.unit 					:= IF (C = 3, R.sec_range, L.priorAddress3.unit);
			SELF.priorAddress3.city 					:= IF (C = 3, R.city, L.priorAddress3.city);
			SELF.priorAddress3.state 					:= IF (C = 3, R.state, L.priorAddress3.state);
			SELF.priorAddress3.zip 						:= IF (C = 3, R.zip, L.priorAddress3.zip);
			SELF.priorAddress3.zip4 					:= IF (C = 3, R.zip4, L.priorAddress3.zip4);
			SELF.priorAddress3.dt_max_seen 		:= 0;
			SELF.priorAddress3.dt_first_seen 	:= 0;

			SELF := L;
		END;

		RETURN DENORMALIZE (ResultFromBest, FilteredRecs(bestRec=false), 
												LEFT.DID = RIGHT.DID,
												XformHistory(LEFT, RIGHT, COUNTER));

	END;
	
	/* Add remarks */
	export DATASET(layoutCompIdResult) addRemarks(DATASET(layoutCompIdResult) ResultFromHist, DATASET(layoutHistory) AllRecords) := FUNCTION
	
		layoutCompIdResult BuildRemarks (ResultFromHist L) := TRANSFORM
			SELF.remarks := (STRING)L.DID;
			// SELF.remarks := (STRING)L.DID + ' SSNCount ' + COUNT(DEDUP(SORT(AllRecords(SSN != ''), SSN), SSN)) + 
																			// ' DOBCount ' + COUNT(DEDUP(SORT(AllRecords(DOB != 0), DOB), dob));
			SELF := L;
		END;

		RETURN PROJECT (ResultFromHist, BuildRemarks(LEFT));

	END;
	
	/* Eliminate duplicates and build result */
	export DATASET(layoutCompIdResult) filterAndBuildResult(DATASET(layoutHistory) AllRecords) := FUNCTION
		// Filter out duplicate addresses
		FilteredRecs := filterDuplicates(AllRecords);
		
		// Build Result's Name and Current Address
		ResultFromBest := buildResultFromBest(FilteredRecs);
		
		// Build Result's Prior Addresses
		ResultFromHist := buildResultFromHist(ResultFromBest, FilteredRecs);
		
		// Add Remarks
		ResultWithRemarks := addRemarks(ResultFromHist, AllRecords);
		
		// OUTPUT(FilteredRecs, NAMED('FilteredRecs'));
		// OUTPUT(ResultFromBest, NAMED('ResultFromBest'));
		// OUTPUT(ResultFromHist, NAMED('ResultFromHist'));
		// OUTPUT(ResultWithRemarks, NAMED('ResultWithRemarks'));
		return ResultWithRemarks;
	END;
	
	/* Get Driver Licence Information */
	EXPORT DATASET(layoutCompIdResult) getDriverLicence(DATASET(layout_Doxie_Reference_HH) DIDs, DATASET(layoutCompIdResult) ResultWithRemarks) := FUNCTION
		
		// Get all Driver records for the matching DIDs
		pDIDs := UNGROUP(PROJECT(DIDs, Doxie.Layout_References));
		DLRecs := DriversV2_Services.DLRaw.narrow_view.by_did(pDIDs);
		
		// Get only 'Current' information
		FilteredDLRec := TOPN(DLRecs(History_Name='Current'), 1, -Expiration_Date);
		
		// Mash it into Resultant address record
		layoutCompIdResult XformDriver (ResultWithRemarks L, FilteredDLRec R) := TRANSFORM
			SELF.DID 												:= L.DID;
			SELF.currentDL.dlState 					:= r.orig_state;
			SELF.currentDL.dl_number 				:= r.dl_number;
			SELF.currentDL.lic_issue_date 	:= ut.Date_MMDDYYYY_I2((STRING)r.lic_issue_date);
			SELF.currentDL.expiration_date  := ut.Date_MMDDYYYY_I2((STRING)r.expiration_date);
			SELF.currentDL.restrictions 		:= r.restrictions_delimited;
			SELF.currentDL.license_class  	:= r.license_class;
			SELF.currentDL.license_type 		:= r.license_type;
			SELF.gender 										:= r.sex_flag;
			
			SELF := L;
		END;
		
		RETURN JOIN (ResultWithRemarks, FilteredDLRec, 
									LEFT.DID = RIGHT.DID,
									XformDriver(LEFT, RIGHT), LEFT OUTER);

	END;
	
END;
