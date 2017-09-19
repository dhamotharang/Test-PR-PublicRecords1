IMPORT Address,iesp,ut;
IMPORT BairRx_PSS,BairRx_Common;

EXPORT PersonSearchRecords(dataset(BairRx_PSS.IParam.PersonSearchParam) in_params) := FUNCTION
	
	dXLinkRecs := BairRx_PSS.SALTSearch.GetCleanRecs(in_params);

	//
	// Age filter if needed
	AgeMatch := in_params[1].AgeLow = 0 OR 
	            in_params[1].AgeHigh = 0 OR 
							dXLinkRecs.dob <> 0 AND (in_params[1].AgeLow <= ut.Age(dXLinkRecs.dob) AND in_params[1].AgeHigh >= ut.Age(dXLinkRecs.dob));
	// dMatchRecs := if (in_params[1].AgeLow <> 0 AND in_params[1].AgeHigh <> 0, dXLinkRecs(match, AgeMatch), dXLinkRecs(match));
	dMatchRecs := dXLinkRecs(match, AgeMatch);

	dIncidentRecs := DEDUP(SORT(dXLinkRecs(BairRx_PSS.Constants.IsIncidentRecord(prepped_rec_type)), eid, -weight, -record_score), eid);
	dEIDs	:= DEDUP(SORT(PROJECT(dXLinkRecs, TRANSFORM(BairRx_Common.Layouts.EID, SELF := LEFT)), eid), eid);	
	
	dMatchPersonRecs := dMatchRecs(person_match);
	dMatchRecsWithDID := DEDUP(SORT(dMatchPersonRecs(lexid>0),lexid,eid),lexid,eid);
	dMatchRecsWithNoDIDs := dMatchPersonRecs(lexid=0);	
	
	dUniqueRecsWithDID := DEDUP(SORT(dMatchRecsWithDID,lexid),lexid);					
	dUniqueRecsNoDIDs := DEDUP(SORT(dMatchRecsWithNoDIDs, eid, -weight, -record_score), eid);

	// ------- NAMES 					----------------------------
	dNames0 := SORT(PROJECT(dMatchRecsWithDID, TRANSFORM(BairRx_PSS.Layouts.LayoutNameRec, SELF := LEFT)), lexid);
	
	BairRx_PSS.Layouts.LayoutNameGroup xtGroupName(BairRx_PSS.Layouts.LayoutNameRec L, DATASET(BairRx_PSS.Layouts.LayoutNameRec) allNames) := TRANSFORM
		SELF.lexid := L.lexid;
		SELF.names := DEDUP(SORT(PROJECT(allNames, TRANSFORM(BairRx_PSS.Layouts.LayoutName, SELF := LEFT)), lname, fname, mname, title,name_suffix),lname, fname, mname, title,name_suffix);
	END;
	dNamesRecs := ROLLUP(GROUP(dNames0, lexid), GROUP, xtGroupName(LEFT, ROWS(LEFT)));
	
	// ------- ADDRESSES 			----------------------------
	dAddr0 := SORT(PROJECT(dMatchRecsWithDID(BairRx_PSS.Constants.IsPersonalRecord(prepped_rec_type),prim_name<>'' or prim_range<>'' or p_city_name<>'' or st<>'' or zip<>''), TRANSFORM(BairRx_PSS.Layouts.LayoutAddrRec, SELF := LEFT)), lexid);
	
	BairRx_PSS.Layouts.LayoutAddrGroup xtGroupAddr(BairRx_PSS.Layouts.LayoutAddrRec L, DATASET(BairRx_PSS.Layouts.LayoutAddrRec) allAddrs) := TRANSFORM
		SELF.lexid := L.lexid;
		SELF.addrs := DEDUP(SORT(PROJECT(allAddrs, TRANSFORM(BairRx_PSS.Layouts.LayoutAddrExt, SELF := LEFT)), prim_name, prim_range, addr_suffix, postdir, sec_range, p_city_name, st, zip, zip4), prim_name, prim_range, addr_suffix, postdir, sec_range, p_city_name, st, zip, zip4);
	END;
	dAddrRecs := ROLLUP(GROUP(dAddr0, lexid), GROUP, xtGroupAddr(LEFT, ROWS(LEFT)));
	
	// ------- DOBs ----		
	dDOB0 := SORT(PROJECT(dMatchRecsWithDID(dob<>0), TRANSFORM(BairRx_PSS.Layouts.LayoutDOBRec, SELF := LEFT)), lexid);
	
	BairRx_PSS.Layouts.LayoutDOBGroup xtGroupDOB(BairRx_PSS.Layouts.LayoutDOBRec L, DATASET(BairRx_PSS.Layouts.LayoutDOBRec) allDOBs) := TRANSFORM
		SELF.lexid := L.lexid;
		SELF.dobs := DEDUP(SORT(PROJECT(allDOBs, TRANSFORM(BairRx_PSS.Layouts.LayoutDOB, SELF := LEFT)), dob), dob);
	END;
	dDOBRecs := ROLLUP(GROUP(dDOB0, lexid), GROUP, xtGroupDOB(LEFT, ROWS(LEFT)));
	
	// ------- POSSIBLE SSNs ------------------------------
	
	ssn0 := SORT(PROJECT(dMatchRecsWithDID(possible_ssn <> ''), TRANSFORM(BairRx_PSS.Layouts.LayoutSSNRecByDID, SELF.possible_ssn := LEFT.possible_ssn, self := left)), lexid);
	BairRx_PSS.Layouts.LayoutSSNGroupByDID xtGroupSSNByDID(BairRx_PSS.Layouts.LayoutSSNRecByDID L, DATASET(BairRx_PSS.Layouts.LayoutSSNRecByDID) allSSNs) := TRANSFORM
		SELF.lexid := L.lexid;
		SELF.ssns := DEDUP(SORT(allSSNs, possible_ssn), possible_ssn);
	END;
	ssnRecsByDID := ROLLUP(GROUP(ssn0, lexid), GROUP, xtGroupSSNByDID(LEFT, ROWS(LEFT)));
	
	// ------- EIDs 					----------------------------	
	dNormedEIDs := SORT(BairRx_PSS.Functions.GetNormalizedScoresByEID(dMatchRecsWithDID), lexid, eid);	
			
	BairRx_PSS.Layouts.LayoutEIDGroup xtGroupEID(BairRx_PSS.Layouts.LayoutEIDScoreGroup L, DATASET(BairRx_PSS.Layouts.LayoutEIDScoreGroup) allEIDs) := TRANSFORM
		SELF.lexid := L.lexid;
		SELF.eids := DEDUP(SORT(PROJECT(allEIDs, TRANSFORM(BairRx_PSS.Layouts.LayoutEIDScore, SELF := LEFT)), eid), eid);
	END;
	dEIDRecs := ROLLUP(GROUP(dNormedEIDs, lexid), GROUP, xtGroupEID(LEFT, ROWS(LEFT)));
	
	// ------- EVENTS 				----------------------------		
	dEventRawRecs := BairRx_PSS.Raw.GetEvents(dEIDs(BairRx_Common.EID.IsEvent(eid)));		
	dEventRawRecsWithCleanAddr := JOIN(dEventRawRecs, dIncidentRecs, LEFT.eid = RIGHT.eid, TRANSFORM(BairRx_PSS.Layouts.LayoutMORec, SELF := LEFT, SELF := RIGHT), KEEP(1), LIMIT(0));	// Assign from dEventRawRecs first since it has primary records with mostamp = 0
	dEventRecsWithDID := JOIN(dMatchRecsWithDID, dEventRawRecsWithCleanAddr, LEFT.eid = RIGHT.eid, TRANSFORM(BairRx_PSS.Layouts.LayoutMORec, SELF.lexid := LEFT.lexid, SELF.name_type := LEFT.name_type, SELF := RIGHT));
	
	BairRx_PSS.Layouts.LayoutMOGroup xtGroupMO(BairRx_PSS.Layouts.LayoutMORec L, DATASET(BairRx_PSS.Layouts.LayoutMORec) allMOs) := TRANSFORM
		SELF.lexid := L.lexid;
		SELF.Events := DEDUP(SORT(allMOs, eid), eid);
	END;
	
	dEventRecsByDID := ROLLUP(GROUP(SORT(dEventRecsWithDID,lexid, eid), lexid), GROUP, xtGroupMO(LEFT, ROWS(LEFT)));

	// ------- CFS 						----------------------------	
	dCFSRawRecs := BairRx_PSS.Raw.GetCFS(dEIDs(BairRx_Common.EID.IsCFS(eid)));	
	dCFSRawRecsWithCleanAddr := JOIN(dCFSRawRecs, dIncidentRecs, LEFT.eid = RIGHT.eid, TRANSFORM(BairRx_PSS.Layouts.LayoutCFSRec, SELF := RIGHT, SELF := LEFT), KEEP(1), LIMIT(0));	;	
	dCFSRecsWithDID := JOIN(dMatchRecsWithDID, dCFSRawRecsWithCleanAddr, LEFT.eid = RIGHT.eid, TRANSFORM(BairRx_PSS.Layouts.LayoutCFSRec, SELF.lexid := LEFT.lexid, SELF := RIGHT));
		
	BairRx_PSS.Layouts.LayoutCFSGroup xtGroupCFS(BairRx_PSS.Layouts.LayoutCFSRec L, DATASET(BairRx_PSS.Layouts.LayoutCFSRec) allCFSs) := TRANSFORM
		SELF.lexid := L.lexid;
		SELF.CFS := DEDUP(SORT(allCFSs, eid), eid);
	END;
	
	dCFSRecsByDID := ROLLUP(GROUP(SORT(dCFSRecsWithDID, lexid, eid), lexid), GROUP, xtGroupCFS(LEFT, ROWS(LEFT)));
	
	// ------- CRASH 				----------------------------	
	dCrashRawRecs := BairRx_PSS.Raw.GetCrash(dEIDs(BairRx_Common.EID.IsCrash(eid)));	
	dCrashRawRecsWithCleanAddr := JOIN(dCrashRawRecs, dIncidentRecs, LEFT.eid = RIGHT.eid, TRANSFORM(BairRx_PSS.Layouts.LayoutCrashRec, SELF := RIGHT, SELF := LEFT), KEEP(1), LIMIT(0));	;	
	dCrashRecsWithDID := JOIN(dMatchRecsWithDID, dCrashRawRecsWithCleanAddr, LEFT.eid = RIGHT.eid, TRANSFORM(BairRx_PSS.Layouts.LayoutCrashRec, SELF.lexid := LEFT.lexid, SELF := RIGHT));
		
	BairRx_PSS.Layouts.LayoutCrashGroup xtGroupCrash(BairRx_PSS.Layouts.LayoutCrashRec L, DATASET(BairRx_PSS.Layouts.LayoutCrashRec) allCrash) := TRANSFORM
		SELF.lexid := L.lexid;
		SELF.Crash := DEDUP(SORT(allCrash, eid), eid);
	END;
	
	dCrashRecsByDID := ROLLUP(GROUP(SORT(dCrashRecsWithDID, lexid, eid), lexid), GROUP, xtGroupCrash(LEFT, ROWS(LEFT)));	
	
	// ------- LPR 						----------------------------	
	dLPRRawRecs := BairRx_PSS.Raw.GetLPR(dEIDs(BairRx_Common.EID.IsLPR(eid)));	
	dLPRRawRecsWithCleanAddr := JOIN(dLPRRawRecs, dIncidentRecs, LEFT.eid = RIGHT.eid, TRANSFORM(BairRx_PSS.Layouts.LayoutLPRRec, SELF := RIGHT, SELF := LEFT), KEEP(1), LIMIT(0));	;	
	dLPRRecsWithDID := JOIN(dMatchRecsWithDID, dLPRRawRecsWithCleanAddr, LEFT.eid = RIGHT.eid, TRANSFORM(BairRx_PSS.Layouts.LayoutLPRRec, SELF.lexid := LEFT.lexid, SELF := RIGHT));
		
	BairRx_PSS.Layouts.LayoutLPRGroup xtGroupLPR(BairRx_PSS.Layouts.LayoutLPRRec L, DATASET(BairRx_PSS.Layouts.LayoutLPRRec) allLPRs) := TRANSFORM
		SELF.lexid := L.lexid;
		SELF.LPR := DEDUP(SORT(allLPRs, eid), eid);
	END;
	
	dLPRRecsByDID := ROLLUP(GROUP(SORT(dLPRRecsWithDID,lexid, eid), lexid), GROUP, xtGroupLPR(LEFT, ROWS(LEFT)));

	// ------- OFFENDER				----------------------------	
	dOffenderRawRecs := BairRx_PSS.Raw.GetOffenders(dEIDs(BairRx_Common.EID.IsOffender(eid)));	
	dOffenderRawRecsWithCleanAddr := JOIN(dOffenderRawRecs, dIncidentRecs, LEFT.eid = RIGHT.eid, TRANSFORM(BairRx_PSS.Layouts.LayoutOffenderRec, SELF := RIGHT, SELF := LEFT), KEEP(1), LIMIT(0));	;	
	dOffenderRecsWithDID := JOIN(dMatchRecsWithDID, dOffenderRawRecsWithCleanAddr, LEFT.eid = RIGHT.eid, TRANSFORM(BairRx_PSS.Layouts.LayoutOffenderRec, SELF.lexid := LEFT.lexid, SELF := RIGHT));
		
	BairRx_PSS.Layouts.LayoutOffenderGroup xtGroupOffender(BairRx_PSS.Layouts.LayoutOffenderRec L, DATASET(BairRx_PSS.Layouts.LayoutOffenderRec) allOFFs) := TRANSFORM
		SELF.lexid := L.lexid;
		SELF.Offenders := DEDUP(SORT(allOFFs, eid), eid);
	END;
	
	dOffenderRecsByDID := ROLLUP(GROUP(SORT(dOffenderRecsWithDID, lexid, eid), lexid), GROUP, xtGroupOffender(LEFT, ROWS(LEFT)));	
	
	// ------- APPEND SECTIONS ----------------------------	
	
	// Append Names
	dRecsOut_NAMES := JOIN(dUniqueRecsWithDID, dNamesRecs, LEFT.lexid = RIGHT.lexid, 
		TRANSFORM(BairRx_PSS.Layouts.LayoutPersonPresentation,			
			SELF.Names := choosen(PROJECT(RIGHT.names, TRANSFORM(iesp.share.t_Name,SELF.Full:=LEFT.prepped_name,SELF.First:=LEFT.fname,SELF.Middle:=LEFT.mname,SELF.Last:=LEFT.lname,SELF.Suffix := LEFT.name_suffix,SELF.Prefix:=LEFT.title)), iesp.bair_constants.MAX_NAME_RECS);			
			SELF.Gender := LEFT.Clean_gender,
			SELF.Score := LEFT.record_score,
			SELF := LEFT,
			SELF := []
		), LEFT OUTER, KEEP(1), LIMIT(0));
	
	// Append Addresses
	dRecsOut_ADDR := JOIN(dRecsOut_NAMES, dAddrRecs, LEFT.lexid = RIGHT.lexid, 
		TRANSFORM(BairRx_PSS.Layouts.LayoutPersonPresentation,
			SELF.Addresses := choosen(PROJECT(RIGHT.addrs, 
				TRANSFORM(iesp.bair_person.t_BAIRPersonSearchAddress,
						SELF.Latitude := LEFT.latitude,
						SELF.Longitude := LEFT.longitude,
						SELF.AddressType := BairRx_PSS.Constants.RecordTypeLabel(LEFT.prepped_rec_type),
						SELF.StreetAddress1:=LEFT.prepped_addr1,
						SELF.StreetAddress2:=LEFT.prepped_addr2,						
						SELF.StreetNumber:=LEFT.prim_range,
						SELF.StreetName:=LEFT.prim_name,
						SELF.StreetSuffix:=LEFT.addr_suffix,
						SELF.StreetPreDirection:=LEFT.predir,
						SELF.StreetPostDirection:=LEFT.postdir,
						SELF.UnitDesignation:=LEFT.unit_desig,
						SELF.UnitNumber:=LEFT.sec_range,						
						SELF.City:=LEFT.p_city_name,
						SELF.State:=LEFT.st,
						SELF.Zip5:=LEFT.zip,							
						SELF.Zip4:=LEFT.zip4,							
						SELF.County:=LEFT.county,									
						SELF := [])), iesp.bair_constants.MAX_ADDRESS_RECS),
				SELF.eid := '', // blank eid here because records have been rolled up by lexid
				SELF := LEFT,
				SELF := []
		), LEFT OUTER, KEEP(1), LIMIT(0));
	
	// Append DOBs
	dRecsOut_DOBs := JOIN(dRecsOut_ADDR, dDOBRecs, LEFT.lexid = RIGHT.lexid, 
		TRANSFORM(BairRx_PSS.Layouts.LayoutPersonPresentation,
			SELF.DOBs := choosen(PROJECT(RIGHT.dobs, TRANSFORM(iesp.bair_person.t_BAIRPersonSearchDOB,
					_dob := iesp.ECL2ESP.toDate(LEFT.dob);
					SELF.Year := _dob.Year;	
					SELF.Month := _dob.Month;	
					SELF.Day := _dob.Day;	
					SELF.Age := ut.GetAgeI(LEFT.dob))
				), iesp.bair_constants.MAX_DOB_RECS),
			SELF := LEFT,
			SELF := []
		), LEFT OUTER, KEEP(1), LIMIT(0));

	// Append EIDs
	dRecsOut_EIDs := JOIN(dRecsOut_DOBs, dEIDRecs, LEFT.lexid = RIGHT.lexid, 
		TRANSFORM(BairRx_PSS.Layouts.LayoutPersonPresentation,
			SELF.EIDRecords := choosen(PROJECT(RIGHT.eids, TRANSFORM(iesp.bair_share.t_BAIREIDRecord,					
					SELF.EID := LEFT.eid,
					SELF._Type := LEFT.eid_type,
					SELF.Weight := if(in_params[1].ReturnMatchScores,(STRING)LEFT.Weight,''),
					SELF.Score := if(in_params[1].ReturnMatchScores,(STRING)LEFT.record_score,''),
					SELF.Scores := if(in_params[1].ReturnMatchScores,PROJECT(LEFT.scores,TRANSFORM(iesp.bair_share.t_BAIRFieldScore,SELF.Name:= LEFT.Field,SELF.Score:= (STRING)LEFT.Score,SELF:=[])),
															DATASET([],iesp.bair_share.t_BAIRFieldScore)),
					)), iesp.bair_constants.MAX_EID_RECS),
			SELF := LEFT,
			SELF := []
		), LEFT OUTER, KEEP(1), LIMIT(0));
		
	// Append event records with DID
	dRecsOut_Events := JOIN(dRecsOut_EIDs, dEventRecsByDID, LEFT.lexid = RIGHT.lexid, 
		TRANSFORM(BairRx_PSS.Layouts.LayoutPersonPresentation,
			SELF.EventRecords := choosen(SORT(PROJECT(RIGHT.Events,TRANSFORM(iesp.bair_person.t_BAIRPersonSearchEventRecord,
				SELF.EID := LEFT.eid,
				SELF.Latitude := (STRING) LEFT.y_coordinate,
				SELF.Longitude := (STRING) LEFT.x_coordinate,
				SELF.IRNumber := LEFT.ir_number,
				SELF.ClassCode := (string) LEFT.ucr_group,
				SELF.Class := BairRx_Common.ClassificationCode.GetClassification(LEFT.ucr_group),
				SELF.Crime := LEFT.Crime,
				// SELF.Address.StreetAddress1 := LEFT.address_of_crime,
				_addr_of_crime := Address.Addr1FromComponents(LEFT.prim_range, LEFT.predir, LEFT.prim_name, LEFT.addr_suffix, LEFT.postdir, LEFT.unit_desig, LEFT.sec_range);
				SELF.Address.StreetAddress1:=IF(_addr_of_crime='', LEFT.address_of_crime, _addr_of_crime),
				SELF.Address.StreetAddress2:=Address.Addr2FromComponents(LEFT.p_city_name, LEFT.st, LEFT.zip),						
				SELF.Address.StreetNumber:=LEFT.prim_range,
				SELF.Address.StreetName:=LEFT.prim_name,
				SELF.Address.StreetSuffix:=LEFT.addr_suffix,
				SELF.Address.StreetPreDirection:=LEFT.predir,
				SELF.Address.StreetPostDirection:=LEFT.postdir,
				SELF.Address.UnitDesignation:=LEFT.unit_desig,
				SELF.Address.UnitNumber:=LEFT.sec_range,						
				SELF.Address.City:=LEFT.p_city_name,
				SELF.Address.State:=LEFT.st,
				SELF.Address.Zip5:=LEFT.zip,							
				SELF.Address.Zip4:=LEFT.zip4,							
				SELF.Address.County:=LEFT.county,								
				SELF.Address := [],
				SELF.FirstDate := iesp.ECL2ESP.toDatestring8(REGEXREPLACE('[^0-9]',LEFT.first_date,'')[1..8]),
				SELF.Beat := LEFT.beat,
				SELF.District := LEFT.rd,
				SELF.SubjectRelation := DATASET([{LEFT.name_type}], iesp.bair_person.t_BAIRPersonRelation),
				SELF.Agency := LEFT.agency)), -FirstDate, EID), iesp.bair_constants.MAX_RECS_PER_MODE),
			SELF := LEFT,
			SELF := []
		), LEFT OUTER, KEEP(1), LIMIT(0));
		
	// Append CFS Records
	dRecsOut_CFS := JOIN(dRecsOut_Events, dCFSRecsByDID, LEFT.lexid = RIGHT.lexid, 
		TRANSFORM(BairRx_PSS.Layouts.LayoutPersonPresentation,
			SELF.CFSRecords := choosen(SORT(PROJECT(RIGHT.CFS,TRANSFORM(iesp.bair_person.t_BAIRPersonSearchCFSRecord,
			SELF.EID := LEFT.eid,
			SELF.ClassCode := (STRING) LEFT.final_ucr_group,
			SELF.Class := BairRx_Common.ClassificationCode.GetClassification(LEFT.final_ucr_group),
			SELF.Latitude := (STRING) LEFT.y_coordinate,
			SELF.Longitude := (STRING) LEFT.x_coordinate,
			SELF.EventNumber := LEFT.event_number,
			SELF.InitialType := (string) LEFT.initial_type,
			SELF.Address.StreetAddress1:=Address.Addr1FromComponents(LEFT.prim_range, LEFT.predir, LEFT.prim_name, LEFT.addr_suffix, LEFT.postdir, LEFT.unit_desig, LEFT.sec_range),
			SELF.Address.StreetAddress2:=Address.Addr2FromComponents(LEFT.p_city_name, LEFT.st, LEFT.zip),						
			SELF.Address.StreetNumber:=LEFT.prim_range,
			SELF.Address.StreetName:=LEFT.prim_name,
			SELF.Address.StreetSuffix:=LEFT.addr_suffix,
			SELF.Address.StreetPreDirection:=LEFT.predir,
			SELF.Address.StreetPostDirection:=LEFT.postdir,
			SELF.Address.UnitDesignation:=LEFT.unit_desig,
			SELF.Address.UnitNumber:=LEFT.sec_range,						
			SELF.Address.City:=LEFT.p_city_name,
			SELF.Address.State:=LEFT.st,
			SELF.Address.Zip5:=LEFT.zip,							
			SELF.Address.Zip4:=LEFT.zip4,							
			SELF.Address.County:=LEFT.county,								
			SELF.Address := [],
			SELF.DateReceived := iesp.ECL2ESP.toDatestring8(REGEXREPLACE('[^0-9]',LEFT.date_time_received,'')[1..8]),		
			SELF.Beat := LEFT.beat,
			SELF.District := LEFT.district,
			SELF.Agency := LEFT.data_provider_name)), -DateReceived, EID), iesp.bair_constants.MAX_RECS_PER_MODE),
			SELF := LEFT,
			SELF := []
		), LEFT OUTER, KEEP(1), LIMIT(0));
	
	// Append Offender records
	dRecsOut_OFF := JOIN(dRecsOut_CFS, dOffenderRecsByDID, LEFT.lexid = RIGHT.lexid, 
		TRANSFORM(BairRx_PSS.Layouts.LayoutPersonPresentation,
			SELF.OffenderRecords := choosen(PROJECT(RIGHT.Offenders,TRANSFORM(iesp.bair_person.t_BAIRPersonSearchOffenderRecord,
				SELF.EID := LEFT.eid,
				SELF.Latitude := (STRING) LEFT.y_coordinate,
				SELF.Longitude := (STRING) LEFT.x_coordinate,
				SELF.Class := LEFT.classification,
				SELF.ClassCode := LEFT.classification,
				SELF.OffenderID := LEFT.agency_offender_id,
				SELF.Address.StreetAddress1:=Address.Addr1FromComponents(LEFT.prim_range, LEFT.predir, LEFT.prim_name, LEFT.addr_suffix, LEFT.postdir, LEFT.unit_desig, LEFT.sec_range),
				SELF.Address.StreetAddress2:=Address.Addr2FromComponents(LEFT.p_city_name, LEFT.st, LEFT.zip),						
				SELF.Address.StreetNumber:=LEFT.prim_range,
				SELF.Address.StreetName:=LEFT.prim_name,
				SELF.Address.StreetSuffix:=LEFT.addr_suffix,
				SELF.Address.StreetPreDirection:=LEFT.predir,
				SELF.Address.StreetPostDirection:=LEFT.postdir,
				SELF.Address.UnitDesignation:=LEFT.unit_desig,
				SELF.Address.UnitNumber:=LEFT.sec_range,						
				SELF.Address.City:=LEFT.p_city_name,
				SELF.Address.State:=LEFT.st,
				SELF.Address.Zip5:=LEFT.zip,							
				SELF.Address.Zip4:=LEFT.zip4,							
				SELF.Address.County:=LEFT.county,								
				SELF.Address := [],
				SELF.FirstName := LEFT.first_name,
				SELF.MiddleName := LEFT.middle_name,
				SELF.LastName := LEFT.last_name,
				SELF.ExpirationDate := iesp.ECL2ESP.toDatestring8(REGEXREPLACE('[^0-9]',LEFT.expiration_date,'')[1..8]),
				SELF.ChargeOffense := LEFT.charge_offense,
				SELF.Agency := LEFT.data_provider_name,
				SELF.ImageAvailable := LEFT.has_Image,
				)), iesp.bair_constants.MAX_RECS_PER_MODE),
			SELF := LEFT,
			SELF := []
		), LEFT OUTER, KEEP(1), LIMIT(0));
		
						
	// Append LPR records
	dRecsOut_LPR := JOIN(dRecsOut_OFF, dLPRRecsByDID, LEFT.lexid = RIGHT.lexid, 
		TRANSFORM(BairRx_PSS.Layouts.LayoutPersonPresentation,
			SELF.LPRRecords := choosen(PROJECT(RIGHT.LPR,TRANSFORM(iesp.bair_person.t_BAIRPersonSearchLPRRecord,
					SELF.EID := LEFT.eid,
					SELF.Latitude := (STRING) LEFT.y_coordinate,
					SELF.Longitude := (STRING) LEFT.x_coordinate,
					SELF.ClassCode := (STRING) BairRx_Common.Constants.LPR_CLASS_CODE,
					SELF.Class := BairRx_Common.ClassificationCode.GetClassification(BairRx_Common.Constants.LPR_CLASS_CODE),
					SELF.EventNumber :=  LEFT.eventnumber,
					SELF.PlateNumber := LEFT.plate,
					SELF.CaptureDate := iesp.ECL2ESP.toDatestring8(REGEXREPLACE('[^0-9]',LEFT.capturedatetime,'')[1..8]),		
					SELF.Agency := LEFT.data_provider_name)), iesp.bair_constants.MAX_RECS_PER_MODE),
			SELF := LEFT,
			SELF := []
		), LEFT OUTER, KEEP(1), LIMIT(0));	
	
	// Append Crash records
	dRecsOut_Crash := JOIN(dRecsOut_LPR, dCrashRecsByDID, LEFT.lexid = RIGHT.lexid, 
		TRANSFORM(BairRx_PSS.Layouts.LayoutPersonPresentation,
			SELF.CrashRecords := choosen(PROJECT(RIGHT.Crash,TRANSFORM(iesp.bair_person.t_BAIRPersonSearchCrashRecord,
					SELF.EID := LEFT.eid,
					SELF.Latitude := (STRING) LEFT.y,
					SELF.Longitude := (STRING) LEFT.x,
					SELF.Class := LEFT.crashtype,
					SELF.ClassCode := (STRING)BairRx_Common.ClassificationCode.MapClassCodeOut(BairRx_Common.EID.Type.CRA, LEFT.crashType),
					SELF.CaseNumber :=  LEFT.case_number,
					SELF.Address.StreetAddress1:=Address.Addr1FromComponents(LEFT.prim_range, LEFT.predir, LEFT.prim_name, LEFT.addr_suffix, LEFT.postdir, LEFT.unit_desig, LEFT.sec_range),
					SELF.Address.StreetAddress2:=Address.Addr2FromComponents(LEFT.p_city_name, LEFT.st, LEFT.zip),						
					SELF.Address.StreetNumber:=LEFT.prim_range,
					SELF.Address.StreetName:=LEFT.prim_name,
					SELF.Address.StreetSuffix:=LEFT.addr_suffix,
					SELF.Address.StreetPreDirection:=LEFT.predir,
					SELF.Address.StreetPostDirection:=LEFT.postdir,
					SELF.Address.UnitDesignation:=LEFT.unit_desig,
					SELF.Address.UnitNumber:=LEFT.sec_range,						
					SELF.Address.City:=LEFT.p_city_name,
					SELF.Address.State:=LEFT.st,
					SELF.Address.Zip5:=LEFT.zip,							
					SELF.Address.Zip4:=LEFT.zip4,							
					SELF.Address.County:=LEFT.county,								
					SELF.Address := [],
					SELF.ReportDate := iesp.ECL2ESP.toDatestring8(REGEXREPLACE('[^0-9]',LEFT.report_date,'')[1..8]),			
					SELF.Agency := LEFT.data_provider_name)), iesp.bair_constants.MAX_RECS_PER_MODE),
			SELF := LEFT,
			SELF := []
		), LEFT OUTER, KEEP(1), LIMIT(0));
		

	// Append SSNs
	dRecsOut_SSN := JOIN(dRecsOut_Crash, ssnRecsByDID, LEFT.lexid = RIGHT.lexid, 
		TRANSFORM(BairRx_PSS.Layouts.LayoutPersonPresentation,
			SELF.PossibleSSNs := choosen(project(RIGHT.ssns, transform(iesp.bair_person.t_BAIRPersonSearchSSN, self.ssn := left.possible_ssn)), iesp.bair_constants.MAX_SSN_RECS),
			SELF := LEFT,
			SELF := []
		), LEFT OUTER, KEEP(1), LIMIT(0));

		
	dRecsOutByDID := dRecsOut_SSN;		
	
	// -------------------------------------
	// NO DIDs section
	// -------------------------------------
	
	// Events - NO DIDs
	dEventNoDIDRecs := JOIN(dUniqueRecsNoDIDs, dEventRawRecsWithCleanAddr, LEFT.eid = RIGHT.eid, 
		TRANSFORM(BairRx_PSS.Layouts.LayoutPersonPresentation,
				SELF.EventRecords := PROJECT(RIGHT,TRANSFORM(iesp.bair_person.t_BAIRPersonSearchEventRecord,
				SELF.EID := RIGHT.eid,
				SELF.Latitude := (STRING) LEFT.y_coordinate,
				SELF.Longitude := (STRING) LEFT.x_coordinate,
				SELF.IRNumber := LEFT.ir_number,
				SELF.ClassCode := (string) LEFT.ucr_group,
				SELF.Class := BairRx_Common.ClassificationCode.GetClassification(LEFT.ucr_group),
				SELF.Crime := LEFT.Crime,
				SELF.Address.StreetAddress1:=Address.Addr1FromComponents(LEFT.prim_range, LEFT.predir, LEFT.prim_name, LEFT.addr_suffix, LEFT.postdir, LEFT.unit_desig, LEFT.sec_range),
				SELF.Address.StreetAddress2:=Address.Addr2FromComponents(LEFT.p_city_name, LEFT.st, LEFT.zip),						
				SELF.Address.StreetNumber:=LEFT.prim_range,
				SELF.Address.StreetName:=LEFT.prim_name,
				SELF.Address.StreetSuffix:=LEFT.addr_suffix,
				SELF.Address.StreetPreDirection:=LEFT.predir,
				SELF.Address.StreetPostDirection:=LEFT.postdir,
				SELF.Address.UnitDesignation:=LEFT.unit_desig,
				SELF.Address.UnitNumber:=LEFT.sec_range,						
				SELF.Address.City:=LEFT.p_city_name,
				SELF.Address.State:=LEFT.st,
				SELF.Address.Zip5:=LEFT.zip,							
				SELF.Address.Zip4:=LEFT.zip4,							
				SELF.Address.County:=LEFT.county,								
				SELF.Address := [],
				SELF.FirstDate := iesp.ECL2ESP.toDatestring8(REGEXREPLACE('[^0-9]',RIGHT.first_date,'')[1..8]),
				SELF.Beat := LEFT.beat,
				SELF.District := LEFT.rd,
				SELF.SubjectRelation :=  DATASET([{LEFT.name_type}], iesp.bair_person.t_BAIRPersonRelation),
				SELF.Agency := LEFT.agency)),
			SELF.Score := LEFT.record_score,
			SELF := LEFT,
			SELF := []
		), KEEP(1),LIMIT(0));
		
	// CFS - NO DIDs
	dCFSNoDIDRecs := JOIN(dUniqueRecsNoDIDs, dCFSRawRecsWithCleanAddr, LEFT.eid = RIGHT.eid AND RIGHT.lexid = 0, 
		TRANSFORM(BairRx_PSS.Layouts.LayoutPersonPresentation,
			SELF.CFSRecords := PROJECT(RIGHT,TRANSFORM(iesp.bair_person.t_BAIRPersonSearchCFSRecord,
					SELF.EID := RIGHT.eid,
					SELF.Latitude := (STRING) LEFT.y_coordinate,
					SELF.Longitude := (STRING) LEFT.x_coordinate,
					SELF.EventNumber := RIGHT.event_number,
					SELF.ClassCode := (string) LEFT.final_ucr_group,
					SELF.Class := BairRx_Common.ClassificationCode.GetClassification(LEFT.final_ucr_group),
					SELF.InitialType := (string) RIGHT.initial_type,
					SELF.Address.StreetAddress1:=Address.Addr1FromComponents(LEFT.prim_range, LEFT.predir, LEFT.prim_name, LEFT.addr_suffix, LEFT.postdir, LEFT.unit_desig, LEFT.sec_range),
					SELF.Address.StreetAddress2:=Address.Addr2FromComponents(LEFT.p_city_name, LEFT.st, LEFT.zip),						
					SELF.Address.StreetNumber:=LEFT.prim_range,
					SELF.Address.StreetName:=LEFT.prim_name,
					SELF.Address.StreetSuffix:=LEFT.addr_suffix,
					SELF.Address.StreetPreDirection:=LEFT.predir,
					SELF.Address.StreetPostDirection:=LEFT.postdir,
					SELF.Address.UnitDesignation:=LEFT.unit_desig,
					SELF.Address.UnitNumber:=LEFT.sec_range,						
					SELF.Address.City:=LEFT.p_city_name,
					SELF.Address.State:=LEFT.st,
					SELF.Address.Zip5:=LEFT.zip,							
					SELF.Address.Zip4:=LEFT.zip4,							
					SELF.Address.County:=LEFT.county,								
					SELF.Address := [],
					SELF.DateReceived := iesp.ECL2ESP.toDatestring8(REGEXREPLACE('[^0-9]',RIGHT.date_time_received,'')[1..8]),										
					SELF.Beat := RIGHT.beat,
					SELF.District := RIGHT.district,
					SELF.Agency := RIGHT.data_provider_name)),
			SELF := LEFT,
			SELF := []
		), KEEP(BairRx_Common.Constants.MAX_JOIN_LIMIT+1), LIMIT(0));
		
	// Offenders - NO DIDs
	dOffenderNoDIDRecs := JOIN(dUniqueRecsNoDIDs, dOffenderRawRecsWithCleanAddr, LEFT.eid = RIGHT.eid, // AND RIGHT.lexid = 0, 
		TRANSFORM(BairRx_PSS.Layouts.LayoutPersonPresentation,
			L := LEFT;
			SELF.OffenderRecords := PROJECT(RIGHT,TRANSFORM(iesp.bair_person.t_BAIRPersonSearchOffenderRecord,
					SELF.EID := RIGHT.eid,
					SELF.Latitude := (STRING) LEFT.y_coordinate,
					SELF.Longitude := (STRING) LEFT.x_coordinate,
					SELF.Class := RIGHT.classification,
					SELF.ClassCode := RIGHT.classification,
					SELF.OffenderID := RIGHT.agency_offender_id,
					SELF.Address.StreetAddress1:=Address.Addr1FromComponents(L.prim_range, L.predir, L.prim_name, L.addr_suffix, L.postdir, L.unit_desig, L.sec_range),
					SELF.Address.StreetAddress2:=Address.Addr2FromComponents(L.p_city_name, L.st, L.zip),						
					SELF.Address.StreetNumber:=L.prim_range,
					SELF.Address.StreetName:=L.prim_name,
					SELF.Address.StreetSuffix:=L.addr_suffix,
					SELF.Address.StreetPreDirection:=L.predir,
					SELF.Address.StreetPostDirection:=L.postdir,
					SELF.Address.UnitDesignation:=L.unit_desig,
					SELF.Address.UnitNumber:=L.sec_range,						
					SELF.Address.City:=L.p_city_name,
					SELF.Address.State:=L.st,
					SELF.Address.Zip5:=L.zip,							
					SELF.Address.Zip4:=L.zip4,							
					SELF.Address.County:=L.county,								
					SELF.Address := [],
					SELF.FirstName := RIGHT.first_name,
					SELF.MiddleName := RIGHT.middle_name,
					SELF.LastName := RIGHT.last_name,
					SELF.ChargeOffense := LEFT.charge_offense,
					SELF.ExpirationDate := iesp.ECL2ESP.toDatestring8(REGEXREPLACE('[^0-9]',LEFT.expiration_date,'')[1..8]),
					SELF.Agency := RIGHT.data_provider_name,
					SELF.ImageAvailable := LEFT.has_Image)),
			SELF := LEFT,
			SELF := []
		), KEEP(BairRx_Common.Constants.MAX_JOIN_LIMIT+1), LIMIT(0));
		
	//LPR - NO DIDs
	dLPRNoDIDRecs := JOIN(dUniqueRecsNoDIDs, dLPRRawRecsWithCleanAddr, LEFT.eid = RIGHT.eid, // AND RIGHT.lexid = 0,
		TRANSFORM(BairRx_PSS.Layouts.LayoutPersonPresentation,
			SELF.LPRRecords := PROJECT(RIGHT,TRANSFORM(iesp.bair_person.t_BAIRPersonSearchLPRRecord,
					SELF.EID := RIGHT.eid,
					SELF.Latitude := (STRING) LEFT.y_coordinate,
					SELF.Longitude := (STRING) LEFT.x_coordinate,
					SELF.ClassCode := (STRING) BairRx_Common.Constants.LPR_CLASS_CODE,
					SELF.Class := BairRx_Common.ClassificationCode.GetClassification(BairRx_Common.Constants.LPR_CLASS_CODE),
					SELF.EventNumber :=  RIGHT.eventnumber,
					SELF.PlateNumber := RIGHT.plate,
					SELF.CaptureDate := iesp.ECL2ESP.toDatestring8(REGEXREPLACE('[^0-9]',RIGHT.capturedatetime,'')[1..8]),			
					SELF.Agency := RIGHT.data_provider_name)),
			SELF := LEFT,
			SELF := []
		), KEEP(BairRx_Common.Constants.MAX_JOIN_LIMIT+1), LIMIT(0));
		
	// Crash - NO DIDs
	dCrashNoDIDRecs := JOIN(dUniqueRecsNoDIDs, dCrashRawRecsWithCleanAddr, LEFT.eid = RIGHT.eid, // AND RIGHT.lexid = 0,
		TRANSFORM(BairRx_PSS.Layouts.LayoutPersonPresentation,
			SELF.CrashRecords := PROJECT(RIGHT,TRANSFORM(iesp.bair_person.t_BAIRPersonSearchCrashRecord,
					SELF.EID := RIGHT.eid,
					SELF.Latitude := (STRING) LEFT.y,
					SELF.Longitude := (STRING) LEFT.x,
					SELF.Class := RIGHT.crashtype,
					SELF.ClassCode := (STRING)BairRx_Common.ClassificationCode.MapClassCodeOut(BairRx_Common.EID.Type.CRA, LEFT.crashType),
					SELF.CaseNumber :=  RIGHT.case_number,					
					SELF.Address.StreetAddress1:=Address.Addr1FromComponents(LEFT.prim_range, LEFT.predir, LEFT.prim_name, LEFT.addr_suffix, LEFT.postdir, LEFT.unit_desig, LEFT.sec_range),
					SELF.Address.StreetAddress2:=Address.Addr2FromComponents(LEFT.p_city_name, LEFT.st, LEFT.zip),						
					SELF.Address.StreetNumber:=LEFT.prim_range,
					SELF.Address.StreetName:=LEFT.prim_name,
					SELF.Address.StreetSuffix:=LEFT.addr_suffix,
					SELF.Address.StreetPreDirection:=LEFT.predir,
					SELF.Address.StreetPostDirection:=LEFT.postdir,
					SELF.Address.UnitDesignation:=LEFT.unit_desig,
					SELF.Address.UnitNumber:=LEFT.sec_range,						
					SELF.Address.City:=LEFT.p_city_name,
					SELF.Address.State:=LEFT.st,
					SELF.Address.Zip5:=LEFT.zip,							
					SELF.Address.Zip4:=LEFT.zip4,							
					SELF.Address.County:=LEFT.county,								
					SELF.Address := [],
					SELF.ReportDate := iesp.ECL2ESP.toDatestring8(REGEXREPLACE('[^0-9]',RIGHT.report_date,'')[1..8]),			
					SELF.Agency := RIGHT.data_provider_name)),
			SELF := LEFT,
			SELF := []
		), KEEP(BairRx_Common.Constants.MAX_JOIN_LIMIT+1),  LIMIT(0));
				
	NoDIDRecs:= dEventNoDIDRecs + dCFSNoDIDRecs + dOffenderNoDIDRecs + dLPRNoDIDRecs + dCrashNoDIDRecs;

	// Append Name, Address, DOB to Non DID recs		
	NoDID_OutRecs := JOIN(dUniqueRecsNoDIDs,NoDIDRecs,LEFT.eid = RIGHT.eid,
		TRANSFORM(BairRx_PSS.Layouts.LayoutPersonPresentation,
			SELF.Names := PROJECT(LEFT, TRANSFORM(iesp.share.t_Name,SELF.Full:=LEFT.prepped_name,SELF.First:=LEFT.fname,SELF.Middle:=LEFT.mname,SELF.Last:=LEFT.lname,SELF.Suffix := LEFT.name_suffix,SELF.Prefix:=LEFT.title));
			SELF.Addresses := PROJECT(LEFT, 
				TRANSFORM(iesp.bair_person.t_BAIRPersonSearchAddress,
						SELF.Latitude := LEFT.latitude,
						SELF.Longitude := LEFT.longitude,
						SELF.AddressType := BairRx_PSS.Constants.RecordTypeLabel(LEFT.prepped_rec_type),
						SELF.StreetAddress1:=LEFT.prepped_addr1,
						SELF.StreetAddress2:=LEFT.prepped_addr2,
						SELF.StreetNumber:=LEFT.prim_range,
						SELF.StreetName:=LEFT.prim_name,
						SELF.StreetSuffix:=LEFT.addr_suffix,
						SELF.StreetPostDirection:=LEFT.postdir,
						SELF.UnitDesignation:=LEFT.unit_desig,
						SELF.UnitNumber:=LEFT.sec_range,						
						SELF.City:=LEFT.p_city_name,
						SELF.State:=LEFT.st,
						SELF.Zip5:=LEFT.zip,						
						SELF.Zip4:=LEFT.zip4,						
						SELF.County:=LEFT.county,									
						SELF := [])),	
			SELF.DOBs := PROJECT(LEFT, TRANSFORM(iesp.bair_person.t_BAIRPersonSearchDOB,
					_dob := iesp.ECL2ESP.toDate(LEFT.dob);
					SELF.Year := _dob.Year;	
					SELF.Month := _dob.Month;	
					SELF.Day := _dob.Day;	
					SELF.Age := ut.GetAgeI(LEFT.dob))
				), 
			SELF.EIDRecords := PROJECT(LEFT, TRANSFORM(iesp.bair_share.t_BAIREIDRecord,					
					SELF.EID := LEFT.eid,
					SELF._Type := LEFT.eid[1..3],
					SELF := []
				)),
			SELF.PossibleSSNS := dataset([{LEFT.possible_ssn}], iesp.bair_person.t_BAIRPersonSearchSSN),
			SELF:=RIGHT;
			),KEEP(BairRx_Common.Constants.MAX_JOIN_LIMIT+1),  LIMIT(0));
			
	
	// EID with no DID		
	dNormedNoDIDScores := BairRx_PSS.Functions.GetNormalizedScoresByEID(dUniqueRecsNoDIDs(eid<>''));					
	dRecsOutNoDID := JOIN(NoDID_OutRecs,dNormedNoDIDScores, LEFT.eid = RIGHT.eid,
										TRANSFORM(BairRx_PSS.Layouts.LayoutPersonPresentation,
											SELF.EIDRecords := PROJECT(RIGHT, TRANSFORM(iesp.bair_share.t_BAIREIDRecord,					
																					SELF.EID := LEFT.eid,
																					SELF._Type := LEFT.eid_type,
																					SELF.Weight := if(in_params[1].ReturnMatchScores,(STRING)LEFT.Weight,''),
																					SELF.Score := if(in_params[1].ReturnMatchScores,(STRING)LEFT.record_score,''),
																					SELF.Scores := if(in_params[1].ReturnMatchScores,PROJECT(LEFT.scores,TRANSFORM(iesp.bair_share.t_BAIRFieldScore,SELF.Name:= LEFT.Field,SELF.Score:= (STRING)LEFT.Score,SELF:=[])),
																														DATASET([],iesp.bair_share.t_BAIRFieldScore)),
											)),
											SELF := LEFT), 
										LEFT OUTER, KEEP(1), LIMIT(0));

	dRecsOut := SORT(dRecsOutByDID + if(in_params[1].IncludeNoDIDRecs, dRecsOutNoDID), -weight, -score, IF(lexid>0, 0, 1), eid_hash);	

	IF(BairRx_Common.Debug.IsMin(), output(in_params, named('in_params')));
	IF(BairRx_Common.Debug.IsMin(), output(choosen(dXLinkRecs, 1000), named('dXLinkRecs')));	
	IF(BairRx_Common.Debug.IsMin(), output(choosen(dMatchPersonRecs, 100), named('dMatchPersonRecs')));	
	IF(BairRx_Common.Debug.IsMin(), output(choosen(dMatchRecsWithNoDIDs, 100), named('dMatchRecsWithNoDIDs')));	
	IF(BairRx_Common.Debug.IsMin(), output(choosen(dUniqueRecsWithDID, 100), named('dUniqueRecsWithDID')));	
	IF(BairRx_Common.Debug.IsMin(), output(choosen(dRecsOut_NAMES, 100), named('dRecsOut_NAMES')));	
	IF(BairRx_Common.Debug.IsMin(), output(choosen(dAddrRecs, 100), named('dAddrRecs')));	
	IF(BairRx_Common.Debug.IsMin(), output(choosen(dRecsOut_ADDR, 100), named('dRecsOut_ADDR')));	
	// IF(BairRx_Common.Debug.IsMin(), output(choosen(dMatchRecs, 50), named('dMatchRecs')));	
	IF(BairRx_Common.Debug.IsMin(), output(choosen(dIncidentRecs, 500), named('dIncidentRecs')));	
	IF(BairRx_Common.Debug.IsMed(), output(choosen(dEventRawRecs, 100), named('dEventRawRecs')));	
	IF(BairRx_Common.Debug.IsMed(), output(choosen(dEventRawRecsWithCleanAddr, 100), named('dEventRawRecsWithCleanAddr')));	
	// IF(BairRx_Common.Debug.IsMed(), output(choosen(dCFSRawRecsWithCleanAddr, 50), named('dCFSRawRecs')));	
	// IF(BairRx_Common.Debug.IsMed(), output(choosen(dCrashRawRecsWithCleanAddr, 50), named('dCrashRawRecs')));	
	// IF(BairRx_Common.Debug.IsMed(), output(choosen(dOffenderRawRecsWithCleanAddr, 50), named('dOffenderRawRecs')));	
	
	RETURN PROJECT(dRecsOut,TRANSFORM(iesp.bair_person.t_BAIRPersonSearchRecord, self.LexID := (string)left.LexID, SELF := LEFT));
	
END;