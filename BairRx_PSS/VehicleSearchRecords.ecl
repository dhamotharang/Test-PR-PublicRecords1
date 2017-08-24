import Address,iesp,Bair_ExternalLinkKeys,ut;
import BairRx_Common,BairRx_PSS;

/* --------------------------------------------------
	o All regular (non-wildcard) searches are done directly through SALT (external linking keys).
	o Each matching incident may have multiple records associated with it. 
	o We split those records into incident, vehicle and person records in order to 'construct' the final results.	
	o We return only one record per incident; the ones with better score at the top.
	o Each returned record may have the following (except LPR which has just one record for both vehicle and incident):
		o	Main vehicle (always)
		o Main vehicle parties
		o Other Vehicles
			o Other vehicle parties
	o The main vehicle is simply the vehicle record with the highest score within a given incident.
		o Alternatively, a main vehicle may simply be the vehicle associated with the person record having the highest score.
	o The association between a party and a vehicle is dictated by vehicle ids.
		o In general, crash incidents will have an association between its vehicle and person records. 
			o However, there are crash incidents where a person may not be associated to any vehicle. 
			o Those 'orphan' parties will always be returned under main vehicle. 
			o The lack of a vehicle id in the final response can be used as a way to distinguish those parties as not belonging to any vehicle.
		o In the case of events, there is no vehicle <-> person association. All incident parties are returned under main vehicle parties.		
   --------------------------------------------------	
	o Wildcard searches are not primarily based on SALT. Instead, we use a stand-alone wild key to scan for matching incidents (see GetWildcardRecords).
	o That set of matching incidents is then joined against the SALT payload keys to produce a dataset 'similar' to the one produced by SALT.
	o From that point on, the same logic used to 'construct' the final results apply.
		--------------------------------------------------	

-- PSRR-620  Adding LPR data to Vehicle search results, In order to ensure LPR data does not overwhelm other restuls, we will handle LPR results separately
		(right from starting SALT Call ) and add it to Event,Crash data at the bottom. We will still be getting combined results out of SALT. Ideal solution would be to SALT handle by mode
*/

EXPORT VehicleSearchRecords(dataset(BairRx_PSS.IParam.VehicleSearchParam) in_params, BairRx_PSS.WParam.VehicleWildcardSearchParam wc_params) := FUNCTION

	LPR_params := PROJECT(in_params,TRANSFORM(BairRx_PSS.IParam.VehicleSearchParam, // Search only by plate and LPR mode, blank out rest of the search fields
									SELF.PLATE := LEFT.PLATE,
									SELF.IncludeLPR := TRUE,
									SELF.IncludeEvents := FALSE,
									SELF.IncludeCFS := FALSE,
									SELF.IncludeCrash := FALSE,
									SELF.IncludeOffenders := FALSE,
									SELF.NAME_SUFFIX := [], 
									SELF.FNAME := [],
									SELF.MNAME := [],
									SELF.LNAME := [],
									SELF.FULLNAME := [], 
									SELF.SEARCH_ADDR1 := [],
									SELF.SEARCH_ADDR2 := [],
									SELF.PRIM_RANGE := [],
									SELF.PRIM_NAME := [],
									SELF.SEC_RANGE := [],
									SELF.P_CITY_NAME := [], 
									SELF.ST := [], 
									SELF.ZIP := [], 
									SELF.DOB := [], 
									SELF.PHONE := [], 
									SELF.DL_ST := [], 
									SELF.DL := [], 
									SELF.LEXID := [], 
									SELF.POSSIBLE_SSN := [], 
									SELF.VIN := [],
									SELF := LEFT));
		
	doWildcardSearch := wc_params.doWildSearch;
	dXLinkCleanRecs_in := BairRx_PSS.SALTSearch.GetCleanRecs(in_params);			
	
	dXLinkCleanRecs_inLPR := IF(in_params[1].plate<>'',BairRx_PSS.SALTSearch.GetCleanRecs(LPR_params));
	
	//
	// Wildcard testing
	dXLinkCleanRecs_wild := BairRx_PSS.GetWildcardRecords(in_params[1], wc_params);
	dXLinkCleanRecs := iff(doWildcardSearch, dXLinkCleanRecs_wild, dXLinkCleanRecs_in);
	dXLinkRecs      := PROJECT(dXLinkCleanRecs,TRANSFORM(BairRx_PSS.Layouts.LayoutInternal, SELF := LEFT));
	dXLinkRecsLPR      := PROJECT(dXLinkCleanRecs_inLPR,TRANSFORM(BairRx_PSS.Layouts.LayoutInternal, SELF := LEFT));

	dMatchRecs 		:= dXLinkRecs(match); 	
	dVehicleRecs 	:= dXLinkRecs(BairRx_PSS.Constants.IsVehicleRecord(prepped_rec_type), VIN<>'' OR Plate<>'' OR Make<>'' OR Model<>'');
	dPersonRecs 	:= PROJECT(dXLinkRecs(BairRx_PSS.Constants.IsPersonalRecord(prepped_rec_type), (lexid<>0 OR fname<>'' OR lname<>'' OR clean_company_name <> '')),
			TRANSFORM(BairRx_PSS.Layouts.LayoutInternal,
				// blanking out address for all crash records as all those addresses are incident, not personal addresses.
				isCrashRecord := BairRx_Common.EID.IsCrash(LEFT.eid);
				SELF.latitude := IF(isCrashRecord, '', LEFT.latitude),
				SELF.longitude := IF(isCrashRecord, '', LEFT.longitude),
				SELF.prepped_rec_type := IF(isCrashRecord, 0, LEFT.prepped_rec_type),
				SELF.prepped_addr1 := IF(isCrashRecord, '', LEFT.prepped_addr1),
				SELF.prepped_addr2 := IF(isCrashRecord, '', LEFT.prepped_addr2),
				SELF.prim_range := IF(isCrashRecord, '', LEFT.prim_range),
				SELF.predir := IF(isCrashRecord, '', LEFT.predir),
				SELF.prim_name := IF(isCrashRecord, '', LEFT.prim_name),
				SELF.addr_suffix := IF(isCrashRecord, '', LEFT.addr_suffix),
				SELF.postdir := IF(isCrashRecord, '', LEFT.postdir),
				SELF.unit_desig := IF(isCrashRecord, '', LEFT.unit_desig),
				SELF.sec_range := IF(isCrashRecord, '', LEFT.sec_range),
				SELF.p_city_name := IF(isCrashRecord, '', LEFT.p_city_name),
				SELF.st := IF(isCrashRecord, '', LEFT.st),
				SELF.zip := IF(isCrashRecord, '', LEFT.zip),
				SELF.zip4 := IF(isCrashRecord, '', LEFT.zip4),
				SELF.county := IF(isCrashRecord, '', LEFT.county),	
				SELF := LEFT));
		
	dIncidentAllRecs := DEDUP(SORT(dXLinkRecs(BairRx_PSS.Constants.IsIncidentRecord(prepped_rec_type)), eid, -weight, -record_score), eid); 
	// only care about incidents where we have a matching record (person or vehicle record)
	dIncidentMatchRecs := JOIN(dIncidentAllRecs, dMatchRecs, LEFT.eid = RIGHT.eid, TRANSFORM(LEFT), KEEP(1), LIMIT(0));
	// only care about incidents where we have at least one vehicle
	dIncidentRecs := JOIN(dIncidentMatchRecs, DEDUP(SORT(dVehicleRecs,eid),eid), LEFT.eid = RIGHT.eid, TRANSFORM(LEFT), KEEP(1), LIMIT(0));		
	dEIDs	:= PROJECT(dIncidentRecs, TRANSFORM(BairRx_Common.Layouts.EID, SELF := LEFT)); // 1 record per eid
	dEIDsLPR	:= PROJECT(dXLinkRecsLPR, TRANSFORM(BairRx_Common.Layouts.EID, SELF := LEFT)); // 1 record per eid
	
	// ------- VEHICLES -------	
	
	dVehicles := PROJECT(dVehicleRecs, TRANSFORM(BairRx_PSS.Layouts.LayoutVehicle, SELF := LEFT));
	
	dAllEventVehicles := dVehicles(BairRx_Common.EID.IsEvent(eid));
	dMainEventVehicles := DEDUP(SORT(dAllEventVehicles, eid, -weight, -vehicle_match, -record_score), eid); // main event vehicles are the top scores per eid (since no vehicle_id)
	dOtherEventVehicles := dAllEventVehicles - dMainEventVehicles;
	
	dAllCrashVehicles 		:= dVehicles(BairRx_Common.EID.IsCrash(eid));
	dMainCrashVehicleIds 	:= DEDUP(SORT(dXLinkRecs(BairRx_Common.EID.IsCrash(eid) AND vehicleid !=0), eid, -weight, -vehicle_match, -record_score), eid); // Get main vehicle id for each incident no matter if it is present in vehicle or person or incident record
	dMainCrashVehicles 		:= JOIN(dAllCrashVehicles, dMainCrashVehicleIds, LEFT.eid = RIGHT.eid AND LEFT.vehicleid = RIGHT.vehicleid, TRANSFORM(LEFT), KEEP(1), LIMIT(0));
	dOtherCrashVehicles 	:= JOIN(dAllCrashVehicles, dMainCrashVehicles, left.eid = right.eid and left.vehicleid = right.vehicleid, TRANSFORM(LEFT), LEFT ONLY);
	
	dLPRVehicles  	:= 	dXLinkRecsLPR;		// LPR incident only has one vehicle, so considering it to be main vehicle

	dMainVehicles 	:= PROJECT(dMainEventVehicles + dMainCrashVehicles , TRANSFORM(BairRx_PSS.Layouts.LayoutVehicle, SELF.main_vehicle := TRUE,SELF := LEFT));
	dOtherVehicles 	:= dOtherEventVehicles + dOtherCrashVehicles;
	
	// ------- PARTIES -------
	dParties	 := PROJECT(dPersonRecs,TRANSFORM(BairRx_PSS.Layouts.LayoutVehicleParty,SELF := LEFT));	
	dPartyRecs := JOIN(dParties, dMainVehicles, LEFT.eid = RIGHT.eid, TRANSFORM(BairRx_PSS.Layouts.LayoutVehicleParty, 
		SELF.main_vehicle := LEFT.vehicleid = 0 OR LEFT.vehicleid = RIGHT.vehicleid, // parties with no vehicles always under main vehicle
		SELF := LEFT), KEEP(1), LIMIT(0));
		
	BairRx_PSS.Layouts.LayoutVehiclePartyGroup xtGroupParty(BairRx_PSS.Layouts.LayoutVehicleParty L, DATASET(BairRx_PSS.Layouts.LayoutVehicleParty) allParties) := TRANSFORM
		SELF.eid := L.eid,
		SELF.weight := MAX(allParties, weight),
		SELF.score := MAX(allParties, score),
		SELF.record_score := MAX(allParties, record_score),
		SELF.vehicleid := L.vehicleid,
		SELF.main_vehicle := L.main_vehicle,
		SELF.parties := SORT(DEDUP(SORT(allParties, RECORD), except name_type), -weight, -record_score, lname, fname, prim_range, prim_name, p_city_name, zip);
	END;

	dMainPartyGroupRecs := ROLLUP(GROUP(SORT(dPartyRecs(main_vehicle), eid), eid), GROUP, xtGroupParty(LEFT, ROWS(LEFT)));		
	dOtherPartyGroupRecs := ROLLUP(GROUP(SORT(dPartyRecs(~main_vehicle), eid, vehicleid), eid, vehicleid), GROUP, xtGroupParty(LEFT, ROWS(LEFT)));		

	// ------- OTHER VEHICLES --------	
	dOtherVehiclesWithParties := JOIN(dOtherVehicles, dOtherPartyGroupRecs, LEFT.eid = RIGHT.eid AND LEFT.vehicleid = RIGHT.vehicleid ,
		TRANSFORM(BairRx_PSS.Layouts.LayoutOtherVehicle,	
				SELF.eid := LEFT.eid,
				SELF.weight := MAX(LEFT.weight, RIGHT.weight);
				SELF.score := MAX(LEFT.score, RIGHT.score);
				SELF.record_score := MAX(LEFT.record_score, RIGHT.record_score);
				SELF.parties := RIGHT.parties,
				SELF := LEFT,
			), KEEP(1), LIMIT(0), LEFT OUTER);

	BairRx_PSS.Layouts.LayoutOtherVehicleGroup xtGroupOtherVehicles(BairRx_PSS.Layouts.LayoutOtherVehicle L, DATASET(BairRx_PSS.Layouts.LayoutOtherVehicle) allOtherVehicles) := TRANSFORM
		SELF.eid := L.eid;
		SELF.weight := MAX(allOtherVehicles, weight);
		SELF.score := MAX(allOtherVehicles, score);
		SELF.record_score := MAX(allOtherVehicles, record_score);
		SELF.other_vehicles := SORT(allOtherVehicles, -weight, -score, -record_score, vin, make, model, year, plate, plate_st);
	END;
	dOtherVehicleGroupRecs := ROLLUP(GROUP(SORT(dOtherVehiclesWithParties, eid), eid), GROUP, xtGroupOtherVehicles(LEFT, ROWS(LEFT)));	
	
			
	// ------- APPEND SECTIONS -------
	
	// ------- INCIDENTS + MAIN VEHICLES  -------
	dRecsWithMainVehicles := JOIN(dIncidentRecs, dMainVehicles, LEFT.eid = RIGHT.eid,
		TRANSFORM(BairRx_PSS.Layouts.LayoutVehiclePresentation, 
			SELF.weight := MAX(LEFT.weight, RIGHT.weight);
			SELF.score := MAX(LEFT.score, RIGHT.score);
			SELF.VehicleID := RIGHT.vehicleID,
			SELF.VehicleInfo.VIN := RIGHT.vin,
			SELF.VehicleInfo.Plate := RIGHT.plate,
			SELF.VehicleInfo.PlateState := RIGHT.plate_st,
			SELF.VehicleInfo.Year := RIGHT.year,
			SELF.VehicleInfo.Make := RIGHT.make,
			SELF.VehicleInfo.Model := RIGHT.model,
			SELF.VehicleInfo.Color := RIGHT.color,			
			SELF.VehicleInfo.Style := RIGHT.style,
			SELF.VehicleInfo.VehicleID := (STRING) RIGHT.vehicleid,
			SELF.EIDInfo.EID := LEFT.eid, 
			// SELF.EIDInfo := LEFT.weight, 
			// SELF.EIDInfo := LEFT.record_score, 
			SELF := LEFT,
			SELF := []),
			KEEP(1), LIMIT(0));	
			
	dLPRRecsWithMainVehicles := JOIN(dXLinkRecsLPR, dLPRVehicles, LEFT.eid = RIGHT.eid,
		TRANSFORM(BairRx_PSS.Layouts.LayoutVehiclePresentation, 
			SELF.weight := MAX(LEFT.weight, RIGHT.weight);
			SELF.score := MAX(LEFT.score, RIGHT.score);
			SELF.VehicleID := RIGHT.vehicleID,
			SELF.VehicleInfo.Plate := RIGHT.plate,
			SELF.VehicleInfo.VehicleID := (STRING) RIGHT.vehicleid,
			SELF.EIDInfo.EID := LEFT.eid, 
			SELF := LEFT,
			SELF := []),
			KEEP(1), LIMIT(0));		
	
	// ------- INCIDENTS + MAIN VEHICLES + MAIN PARTIES -------
	
	iesp.bair_vehiclesearch.t_BAIRVehicleParty xtPartyOut(BairRx_PSS.Layouts.LayoutVehicleParty L) := TRANSFORM
		SELF.LexID := (STRING) L.lexid,
		SELF.MatchedParty := IF(L.person_match,'Y','N'),
		SELF.Name.Full := L.prepped_name,
		SELF.Name.First:=L.fname,
		SELF.Name.Middle:=L.mname,
		SELF.Name.Last:=L.lname,
		SELF.Name.Suffix := L.name_suffix,
		SELF.Name.Prefix:=L.title,
		SELF.Gender := L.clean_gender,
		_dob := iesp.ECL2ESP.toDate(L.dob);
		SELF.DOB.Year := _dob.Year,
		SELF.DOB.Month := _dob.Month,
		SELF.DOB.Day := _dob.Day,
		SELF.PossibleSSN := L.possible_ssn;
		SELF.Age := (STRING) ut.Age(L.dob),
		SELF.SubjectRelation := L.name_type,
		SELF.Address.Latitude := L.latitude,
		SELF.Address.Longitude := L.longitude,
		SELF.Address.AddressType := BairRx_PSS.Constants.RecordTypeLabel(L.prepped_rec_type),
		SELF.Address.StreetAddress1:=L.prepped_addr1,
		SELF.Address.StreetAddress2:=L.prepped_addr2,						
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
		SELF.LicenseNumber:=L.dl,
		SELF.LicenseState:=L.dl_st,
		SELF.VehicleID := (STRING) L.vehicleid,
		SELF.CompanyName := L.clean_company_name,
		SELF := []
	END;
	
	dRecsWithMainParties := JOIN(dRecsWithMainVehicles, dMainPartyGroupRecs, LEFT.eid = RIGHT.eid, // no vehicleid for events, so essentially all parties are returned as main
			TRANSFORM(BairRx_PSS.Layouts.LayoutVehiclePresentation, 
				SELF.weight := MAX(LEFT.weight, RIGHT.weight),
				SELF.score := MAX(LEFT.score, RIGHT.score),
				SELF.VehicleParties := PROJECT(CHOOSEN(RIGHT.parties, in_params[1].maxVehicleParties), xtPartyOut(LEFT)),
				SELF := LEFT
				), KEEP(1), LIMIT(0), LEFT OUTER);	

	// ------- INCIDENTS + MAIN VEHICLES + MAIN PARTIES + OTHER VEHICLES -------

	dOtherVehicleGroupOutRecs := PROJECT(dOtherVehicleGroupRecs, TRANSFORM(BairRx_PSS.Layouts.LayoutOtherVehicleOut,
		SELF.eid := LEFT.eid,
		SELF.OtherVehicles := PROJECT(CHOOSEN(LEFT.other_vehicles, in_params[1].maxVehicles), TRANSFORM(iesp.bair_vehiclesearch.t_BAIROtherVehicle,						
			SELF.VehicleInfo.VIN := LEFT.vin,
			SELF.VehicleInfo.Plate := LEFT.plate,
			SELF.VehicleInfo.PlateState := LEFT.plate_st,
			SELF.VehicleInfo.Year := LEFT.year,
			SELF.VehicleInfo.Make := LEFT.make,
			SELF.VehicleInfo.Model := LEFT.model,
			SELF.VehicleInfo.Color := LEFT.color,			
			SELF.VehicleInfo.Style := LEFT.style,
			SELF.VehicleInfo.VehicleID := (STRING) LEFT.vehicleid,
			SELF.VehicleParties := PROJECT(CHOOSEN(LEFT.parties, in_params[1].maxVehicleParties), xtPartyOut(LEFT)),
			))));
	
	dRecsWithOtherParties := JOIN(dRecsWithMainParties, dOtherVehicleGroupOutRecs, left.eid = right.eid,
		TRANSFORM(BairRx_PSS.Layouts.LayoutVehiclePresentation,
			SELF.OtherVehicles := CHOOSEN(RIGHT.OtherVehicles, in_params[1].maxVehicles),
			SELF := LEFT
			), KEEP(1), LEFT OUTER);

	// -------- INCIDENTS: EVENTS ------
	dEventRawRecs := BairRx_PSS.Raw.GetEvents(dEIDs(BairRx_Common.EID.IsEvent(eid)));		
	dEventRawRecsWithCleanAddr := JOIN(dEventRawRecs, dIncidentRecs, LEFT.eid = RIGHT.eid, TRANSFORM(BairRx_PSS.Layouts.LayoutMORec, SELF := RIGHT, SELF := LEFT), KEEP(1), LIMIT(0));	
	
	iesp.bair_share.t_BAIREventRecord xtEventRecord(BairRx_PSS.Layouts.LayoutMORec L) := TRANSFORM
		SELF.EID := L.eid,
		SELF.ClassCode := (string) L.ucr_group,
		SELF.Class := BairRx_Common.ClassificationCode.GetClassification(L.ucr_group),
		SELF.Latitude := (STRING) L.y_coordinate,
		SELF.Longitude := (STRING) L.x_coordinate,
		SELF.IRNumber := L.ir_number,			
		SELF.Crime := L.Crime,
		_addr_of_crime := Address.Addr1FromComponents(L.prim_range, L.predir, L.prim_name, L.addr_suffix, L.postdir, L.unit_desig, L.sec_range);
		SELF.Address.StreetAddress1:=IF(_addr_of_crime='', L.address_of_crime, _addr_of_crime),
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
		SELF.FirstDate := iesp.ECL2ESP.toDatestring8(REGEXREPLACE('[^0-9]',L.first_date,'')[1..8]),
		SELF.Beat := L.beat,
		SELF.District := L.rd,			
		SELF.Agency := L.agency,
	END;
	
	dRecsWithEvents := JOIN(dRecsWithOtherParties, dEventRawRecsWithCleanAddr, LEFT.eid = RIGHT.eid,
			TRANSFORM(BairRx_PSS.Layouts.LayoutVehiclePresentation, 
				SELF.EventRecords := IF(BairRx_Common.EID.IsEvent(LEFT.eid), DATASET([xtEventRecord(RIGHT)]), DATASET([], iesp.bair_share.t_BAIREventRecord)),
				SELF := LEFT
				), KEEP(1), LIMIT(0), LEFT OUTER);
	
	// -------- INCIDENTS: CRASH ------
	
	dCrashRawRecs := BairRx_PSS.Raw.GetCrash(dEIDs(BairRx_Common.EID.IsCrash(eid)));		
	dCrashRawRecsWithCleanAddr := JOIN(dCrashRawRecs, dIncidentRecs, LEFT.eid = RIGHT.eid, TRANSFORM(BairRx_PSS.Layouts.LayoutCrashRec, SELF := RIGHT, SELF := LEFT), KEEP(1), LIMIT(0));	
	
	iesp.bair_share.t_BAIRCrashRecord xtCrashRecord(BairRx_PSS.Layouts.LayoutCrashRec L) := TRANSFORM
		SELF.EID := L.eid,
		SELF.ClassCode := (STRING)BairRx_Common.ClassificationCode.MapClassCodeOut(BairRx_Common.EID.Type.CRA, L.crashType),
		SELF.Class := L.crashtype,
		SELF.Latitude := (STRING) L.y,
		SELF.Longitude := (STRING) L.x,
		SELF.CaseNumber := L.case_number,								
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
		SELF.ReportDate := iesp.ECL2ESP.toDatestring8(REGEXREPLACE('[^0-9]',L.report_date,'')[1..8]),
		SELF.Agency := L.data_provider_name,
	END;
	
	dRecsWithCrash := JOIN(dRecsWithEvents, dCrashRawRecsWithCleanAddr, LEFT.eid = RIGHT.eid,
			TRANSFORM(BairRx_PSS.Layouts.LayoutVehiclePresentation, 
				SELF.CrashRecords := IF(BairRx_Common.EID.IsCrash(LEFT.eid), DATASET([xtCrashRecord(RIGHT)]), DATASET([],iesp.bair_share.t_BAIRCrashRecord));
				SELF := LEFT
				), KEEP(1), LIMIT(0), LEFT OUTER);
				
	
	// -------- INCIDENTS: LPR ------
	
	dLPRRawRecs := BairRx_PSS.Raw.GetLPR(dEIDsLPR);	
	dLPRRawRecsWithCleanAddr := JOIN(dLPRRawRecs, dXLinkRecsLPR, LEFT.eid = RIGHT.eid, TRANSFORM(BairRx_PSS.Layouts.LayoutLPRRec, SELF := RIGHT, SELF := LEFT), KEEP(1), LIMIT(0));	;	
	
	iesp.bair_share.t_BAIRLPRRecord xtLPRRecord(BairRx_PSS.Layouts.LayoutLPRRec L) := TRANSFORM
		SELF.EID := L.eid,
		SELF.Latitude := (STRING) L.y_coordinate,
		SELF.Longitude := (STRING) L.x_coordinate,
		SELF.ClassCode := (STRING) BairRx_Common.Constants.LPR_CLASS_CODE,
		SELF.Class := BairRx_Common.ClassificationCode.GetClassification(BairRx_Common.Constants.LPR_CLASS_CODE),
		SELF.EventNumber :=  L.eventnumber,
		SELF.PlateNumber := L.plate,
		SELF.CaptureDate := iesp.ECL2ESP.toDatestring8(REGEXREPLACE('[^0-9]',L.capturedatetime,'')[1..8]),		
		SELF.Agency := L.data_provider_name,
	END;
		
	dRecsWithLPR := JOIN(dLPRRecsWithMainVehicles, dLPRRawRecsWithCleanAddr, LEFT.eid = RIGHT.eid,
		TRANSFORM(BairRx_PSS.Layouts.LayoutVehiclePresentation, 
			SELF.LPRRecords := IF(BairRx_Common.EID.IsLPR(LEFT.eid), DATASET([xtLPRRecord(RIGHT)]), DATASET([],iesp.bair_share.t_BAIRLPRRecord));
			SELF := LEFT
			), KEEP(1), LIMIT(0), LEFT OUTER);
		
	dRecsOut := SORT(dRecsWithCrash, -weight, -score,IF(lexid>0, 0, 1), eid_hash) + dRecsWithLPR;		
	

	IF(BairRx_Common.Debug.IsMin(), output(in_params, named('in_params')));			
	IF(BairRx_Common.Debug.IsMin(), output(wc_params, named('wc_params')));			
	IF(BairRx_Common.Debug.IsMin(), output(LPR_params, named('LPR_params')));			
	IF(BairRx_Common.Debug.IsMax(), output(choosen(dXLinkCleanRecs, 20), named('dXLinkCleanRecs')));	
	IF(BairRx_Common.Debug.IsMax(), output(choosen(dXLinkRecs, 20), named('dXLinkRecs')));	
	IF(BairRx_Common.Debug.IsMed(), output(choosen(dEIDs,20), named('dEIDs')));	
	IF(BairRx_Common.Debug.IsMed(), output(choosen(dEIDsLPR,20), named('dEIDsLPR')));	
	IF(BairRx_Common.Debug.IsMin(), output(choosen(dMatchRecs,20), named('dMatchRecs')));		
	IF(BairRx_Common.Debug.IsMin(), output(choosen(dIncidentAllRecs,20), named('dIncidentAllRecs')));		
	IF(BairRx_Common.Debug.IsMed(), output(choosen(dIncidentRecs,20), named('dIncidentRecs')));		
	IF(BairRx_Common.Debug.IsMed(), output(choosen(dIncidentMatchRecs,20), named('dIncidentMatchRecs')));		
	IF(BairRx_Common.Debug.IsMax(), output(choosen(dVehicleRecs,20), named('dVehicleRecs')));	
	IF(BairRx_Common.Debug.IsMax(), output(choosen(dPersonRecs,20), named('dPersonRecs')));	
	IF(BairRx_Common.Debug.IsMed(), output(choosen(dMainEventVehicles,20), named('dMainEventVehicles')));	
	IF(BairRx_Common.Debug.IsMed(), output(choosen(dMainVehicles,20), named('dMainVehicles')));	
	IF(BairRx_Common.Debug.IsMed(), output(choosen(dLPRVehicles,20), named('dLPRVehicles')));	
	IF(BairRx_Common.Debug.IsMed(), output(choosen(dOtherVehicles,20), named('dOtherVehicles')));	
	IF(BairRx_Common.Debug.IsMed(), output(choosen(dPartyRecs,20), named('dPartyRecs')));	
	IF(BairRx_Common.Debug.IsMed(), output(choosen(dMainPartyGroupRecs,20), named('dMainPartyGroupRecs')));	
	IF(BairRx_Common.Debug.IsMed(), output(choosen(dOtherPartyGroupRecs,20), named('dOtherPartyGroupRecs')));	
	IF(BairRx_Common.Debug.IsMax(), output(choosen(dOtherVehiclesWithParties,20), named('dOtherVehiclesWithParties')));	
	IF(BairRx_Common.Debug.IsMax(), output(choosen(dOtherVehicleGroupRecs,20), named('dOtherVehicleGroupRecs')));	
	IF(BairRx_Common.Debug.IsMax(), output(choosen(dRecsWithMainVehicles,20), named('dRecsWithMainVehicles')));	
	IF(BairRx_Common.Debug.IsMax(), output(choosen(dRecsWithMainParties,20), named('dRecsWithMainParties')));	
	IF(BairRx_Common.Debug.IsMax(), output(choosen(dOtherVehicleGroupOutRecs,20), named('dOtherVehicleGroupOutRecs')));		
	IF(BairRx_Common.Debug.IsMax(), output(choosen(dRecsWithEvents,20), named('dRecsWithEvents')));		
	IF(BairRx_Common.Debug.IsMax(), output(choosen(dRecsWithCrash,20), named('dRecsWithCrash')));		
	IF(BairRx_Common.Debug.IsMax(), output(choosen(dRecsWithLPR,20), named('dRecsWithLPR')));		

	RETURN PROJECT(dRecsOut,TRANSFORM(iesp.bair_vehiclesearch.t_BAIRVehicleSearchRecord, SELF := LEFT, SELF := []));
END;