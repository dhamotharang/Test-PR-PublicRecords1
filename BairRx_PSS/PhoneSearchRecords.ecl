IMPORT Address, iesp, Bair_ExternalLinkKeys;
IMPORT BairRx_PSS, BairRx_Common;

EXPORT PhoneSearchRecords(DATASET(BairRx_PSS.IParam.PhoneSearchParam) in_params) := FUNCTION
	
	// Referencing some input parameters just for convenience
	inPhone 						:= in_params[1].Phone;
	inReturnScores 			:= in_params[1].ReturnMatchScores;
	inSearchNarratives 	:= in_params[1].SearchNarratives;
	incEvents 					:= in_params[1].IncludeEvents;
	inAgencyORI					:= in_params[1].AgencyORI;
	
	// Run a SALT search with the provided input to begin with. 
	dXLinkCleanRecs := PROJECT(BairRx_PSS.SALTSearch.GetCleanRecs(in_params), TRANSFORM(BairRx_PSS.Layouts.LayoutPhoneSearchRec, SELF := LEFT, SELF := []));			
	dAllMatchRecs := dXLinkCleanRecs(Record_Score>0); // cfs type 3 - incident address contains personal info? name,lexid,address....
	
	// In addition, try to find a match against phone numbers parsed from incident narratives.	
	dMatchEIDs := PROJECT(dAllMatchRecs(BairRx_Common.EID.IsEvent(eid)), TRANSFORM(BairRx_Common.Layouts.EID, SELF := LEFT));		
	dNarrativeIncidentRecs := IF(inSearchNarratives AND incEvents, BairRx_PSS.GetFromNarratives.ByPhone(inPhone, dMatchEIDs, inAgencyORI));
			
	// Append narrative phones to SALT matching records so we can follow a linear process to append the remaining data, regardless of where the phone number is coming from.
	dAllMatchRecsWithParsedPhones := JOIN(dAllMatchRecs, dNarrativeIncidentRecs, LEFT.eid = RIGHT.eid, 
		TRANSFORM(BairRx_PSS.Layouts.LayoutPhoneSearchRec, 
			SELF.weight 					:= LEFT.weight + RIGHT.weight, 
			SELF.match_phone 			:= MAX(LEFT.match_phone, RIGHT.match_phone), // max of 2
			SELF.record_score 		:= LEFT.record_score + RIGHT.record_score, 
			SELF.narrative_phone 	:= RIGHT.narrative_phone,				
			SELF 									:= LEFT
			), LEFT OUTER);
	
	// We're only interested in matching records from incidents with phone information.
	dAllMatchRecsWithPhones := dAllMatchRecsWithParsedPhones(phone<>'' OR narrative_phone<>''); 		

	// Dedup to take only the best match per incident -- which also implies a single matching subject per incident.
	// Note: This dedup is also necessary because in the case of events, we may also have multiple records for the same subject with different name types (e.g. EVE8400365979879839206). 
	dMatchRecs := DEDUP(SORT(dAllMatchRecsWithPhones, eid, -weight, -record_score, IF(lexid<>0, 0, 1)), eid);		

	// And we'll need to keep track of the actual incident records returned by SALT.
	dIncidentRecs := DEDUP(SORT(dXLinkCleanRecs(BairRx_PSS.Constants.IsIncidentRecord(prepped_rec_type)), eid), eid);	
	dIncidentRecsWithPhones := JOIN(dIncidentRecs, dAllMatchRecsWithPhones, LEFT.eid = RIGHT.eid, 
		TRANSFORM(BairRx_PSS.Layouts.LayoutPhoneSearchRec, SELF.narrative_phone := RIGHT.narrative_phone,	SELF := LEFT),
		KEEP(1), LIMIT(0));	
		
	// ------- ADDRESSES ------------------------------------------
	
	dAddr0 := SORT(PROJECT(dAllMatchRecsWithPhones(BairRx_PSS.Constants.IsPersonalRecord(prepped_rec_type), prim_name<>'' or prim_range<>'' or p_city_name<>'' or st<>'' or zip<>''), TRANSFORM(BairRx_PSS.Layouts.LayoutPhoneAddrRec, SELF := LEFT)), eid);
	
	BairRx_PSS.Layouts.LayoutPhoneAddrGroup xtGroupAddr(BairRx_PSS.Layouts.LayoutPhoneAddrRec L, DATASET(BairRx_PSS.Layouts.LayoutPhoneAddrRec) allAddrs) := TRANSFORM
		SELF.eid := L.eid;
		SELF.addrs := DEDUP(SORT(PROJECT(allAddrs, TRANSFORM(BairRx_PSS.Layouts.LayoutAddrExt, SELF := LEFT)),prepped_rec_type, prim_name, prim_range, addr_suffix, postdir, sec_range, p_city_name, st, zip, zip4),prepped_rec_type, prim_name, prim_range, addr_suffix, postdir, sec_range, p_city_name, st, zip, zip4);
	END;	
	dAddressRecs := ROLLUP(GROUP(dAddr0, eid), GROUP, xtGroupAddr(LEFT, ROWS(LEFT))); // I suspect this rollup might be incorrect in cases where we may have multiple matching subjects within the same incident.
		
	// ------- EVENTS ---------------------------------------------
	
	dEventRecsWithPhones := dIncidentRecsWithPhones(BairRx_Common.EID.IsEvent(eid)) + dNarrativeIncidentRecs;
	dEVEIDs := DEDUP(SORT(PROJECT(dEventRecsWithPhones, TRANSFORM(BairRx_Common.Layouts.EID, SELF := LEFT)), eid), eid); 		
	dEventRawRecs := BairRx_PSS.Raw.GetEvents(dEVEIDs);
	dEventRawRecsWithCleanAddr := JOIN(dEventRawRecs, dEventRecsWithPhones, LEFT.eid = RIGHT.eid, TRANSFORM(BairRx_PSS.Layouts.LayoutPhoneMORec, SELF := RIGHT, SELF := LEFT), KEEP(1), LIMIT(0));		

	// ------- CFS ------------------------------------------------
	
	dCFSIDs 		:= PROJECT(dIncidentRecsWithPhones(BairRx_Common.EID.IsCFS(eid)), TRANSFORM(BairRx_Common.Layouts.EID, SELF := LEFT));
	dCFSRawRecs := BairRx_PSS.Raw.GetCFS(dCFSIDs);
	dCFSRawRecsWithCleanAddr := JOIN(dCFSRawRecs, dIncidentRecsWithPhones(BairRx_Common.EID.IsCFS(eid)), LEFT.eid = RIGHT.eid, TRANSFORM(BairRx_PSS.Layouts.LayoutCFSRec, SELF := RIGHT, SELF := LEFT), KEEP(1), LIMIT(0));	;	
				
	// ------- APPEND SECTIONS ------------------------------------	
	
	// ------- Start with matching records ------------------------	

	iesp.bair_share.t_BAIRAddressExt xtAddr(BairRx_PSS.Layouts.LayoutAddrExt L) := TRANSFORM
		SELF.Latitude := L.latitude,
		SELF.Longitude := L.longitude,
		SELF.AddressType := BairRx_PSS.Constants.RecordTypeLabel(L.prepped_rec_type),
		SELF.StreetAddress1:=L.prepped_addr1,
		SELF.StreetAddress2:=L.prepped_addr2,
		SELF.StreetNumber:=L.prim_range,
		SELF.StreetName:=L.prim_name,
		SELF.StreetSuffix:=L.addr_suffix,
		SELF.StreetPreDirection:=L.predir,
		SELF.StreetPostDirection:=L.postdir,
		SELF.UnitDesignation:=L.unit_desig,
		SELF.UnitNumber:=L.sec_range,						
		SELF.City:=L.p_city_name,
		SELF.State:=L.st,
		SELF.Zip5:=L.zip,						
		SELF.Zip4:=L.zip4,						
		SELF.County:=L.county,
		SELF := [] 
	END;
		
	dMatchRecsWithNames:= PROJECT(dMatchRecs,
		TRANSFORM(BairRx_PSS.Layouts.LayoutPhonePresentation,
			SELF.Name := PROJECT(LEFT, TRANSFORM(iesp.share.t_Name,SELF.Full:=LEFT.prepped_name,SELF.First:=LEFT.fname,SELF.Middle:=LEFT.mname,SELF.Last:=LEFT.lname,SELF.Suffix := LEFT.name_suffix,SELF.Prefix:=LEFT.title)),			
			SELF.Phone := IF(LEFT.narrative_phone<>'', LEFT.narrative_phone, LEFT.phone),
			SELF.Source := IF(LEFT.narrative_phone<>'', BairRx_PSS.Constants.PhoneSource.NARRATIVE, BairRx_PSS.Constants.PhoneSource.INCIDENT), 
			SELF := LEFT,
			SELF := []));
			
	// ------- Append addresses -----------------------------------	
	
	dMatchRecsWithAddress := JOIN(dMatchRecsWithNames, dAddressRecs, LEFT.eid = RIGHT.eid,
								TRANSFORM(BairRx_PSS.Layouts.LayoutPhonePresentation,
									SELF.Addresses := CHOOSEN(PROJECT(RIGHT.addrs,xtAddr(LEFT)), iesp.bair_constants.MAX_ADDR_PER_PHONE),		
									SELF:=LEFT,
									),KEEP(1),  LIMIT(0),LEFT OUTER);		

	// ------- Append Events --------------------------------------	
	
	iesp.bair_share.t_BAIREventRecord xtAppendEvent(BairRx_PSS.Layouts.LayoutPhoneMORec L) := TRANSFORM
		SELF.EID := L.eid,
		SELF.Latitude := (STRING) L.y_coordinate,
		SELF.Longitude := (STRING) L.x_coordinate,
		SELF.IRNumber := L.ir_number,
		SELF.ClassCode := (string) L.ucr_group,
		SELF.Class := BairRx_Common.ClassificationCode.GetClassification(L.ucr_group),
		SELF.Crime := L.Crime,
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
		SELF.FirstDate := iesp.ECL2ESP.toDatestring8(REGEXREPLACE('[^0-9]',L.first_date,'')[1..8]),
		SELF.Beat := L.beat,
		SELF.District := L.rd,
		SELF.Agency := L.agency
	END;
	
	dMatchRecsWithEvents := JOIN(dMatchRecsWithAddress, dEventRawRecsWithCleanAddr, LEFT.eid = RIGHT.eid,		
		TRANSFORM(BairRx_PSS.Layouts.LayoutPhonePresentation,			
			_date := REGEXREPLACE('[^0-9]',RIGHT.first_date,'')[1..8];
			SELF.dt_first_seen := (UNSIGNED) _date, // need to parse it from raw record, used for sorting later on.
			SELF.Date := iesp.ECL2ESP.toDatestring8(_date),
			SELF.EventRecords := ROW(xtAppendEvent(RIGHT)),
			SELF.Score := LEFT.record_score,
			SELF := LEFT,
			SELF := []
		), KEEP(1),LIMIT(0));

	// Narrative events with a matching record already accounted for in dMatchRecsWithEvents. Hence, a left only join to pick only the incidents where all we found was a phone in the narratives.
	dMatchRecsNarrativeOnly := JOIN(dEventRawRecsWithCleanAddr, dMatchRecsWithEvents, LEFT.eid = RIGHT.eid, TRANSFORM(LEFT), LEFT ONLY);
	dMatchRecsFromNarratives := PROJECT(dMatchRecsNarrativeOnly, TRANSFORM(BairRx_PSS.Layouts.LayoutPhonePresentation,	
			_date := REGEXREPLACE('[^0-9]',LEFT.first_date,'')[1..8]; 
			SELF.dt_first_seen := (UNSIGNED) _date, // need to parse it from raw record, used for sorting later on.
			SELF.Date := iesp.ECL2ESP.toDatestring8(_date),
			SELF.Phone := LEFT.narrative_phone,
			SELF.Source := BairRx_PSS.Constants.PhoneSource.NARRATIVE,		
			SELF.EventRecords := ROW(xtAppendEvent(LEFT)),
			SELF := LEFT,
			SELF := []));			

	// ------- Append CFS -----------------------------------------
	
	dMatchRecsWithCFS := JOIN(dMatchRecsWithAddress, dCFSRawRecsWithCleanAddr, LEFT.eid = RIGHT.eid , 
		TRANSFORM(BairRx_PSS.Layouts.LayoutPhonePresentation,
			_date := REGEXREPLACE('[^0-9]',RIGHT.date_time_received,'')[1..8];
			SELF.dt_first_seen := (UNSIGNED) _date, // need to parse it from raw record, used for sorting later on.
			SELF.Date := iesp.ECL2ESP.toDatestring8(_date),
			// There are cases where we have nothing but phone number and incident address for CFS records (e.g. 2012046428). Should we be assigning at least one address to SELF.Addresses (?)
			SELF.CFSRecords := PROJECT(RIGHT,TRANSFORM(iesp.bair_share.t_BAIRCFSRecord,
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
				SELF.Score := LEFT.record_score,
				SELF := LEFT,
			SELF := []
		), KEEP(1), LIMIT(0));
				
	dMatchRecsWithIncident := dMatchRecsWithEvents + dMatchRecsFromNarratives + dMatchRecsWithCFS;
	
	// ------- Append scores --------------------------------------

	// to return all scores, also need to account for incidents matching against narrative phone only, which are not in dMatchRecs.
	dMatchEIDRecs := dMatchRecs + JOIN(dNarrativeIncidentRecs, dMatchRecs, left.eid = right.eid, TRANSFORM(LEFT), LEFT ONLY);  
	dEIDScores 		:= BairRx_PSS.Functions.GetNormalizedScoresByEID(dMatchEIDRecs);
		
	dMatchRecsWithScores:= 
		JOIN(dMatchRecsWithIncident, dEIDScores, LEFT.eid = RIGHT.eid,
				TRANSFORM(BairRx_PSS.Layouts.LayoutPhonePresentation,
					SELF.EIDInfo := 
						PROJECT(RIGHT, TRANSFORM(iesp.bair_share.t_BAIREIDRecord,					
							SELF.EID := LEFT.eid,
							SELF._Type := LEFT.eid[1..3],
							SELF.Weight := (STRING) LEFT.weight,
							SELF.Score := (STRING) LEFT.record_score,
							SELF.Scores := PROJECT(LEFT.scores, TRANSFORM(iesp.bair_share.t_BAIRFieldScore,SELF.Name:= LEFT.Field,SELF.Score:= (STRING)LEFT.Score,SELF:=[]))
					)),
					SELF := LEFT,
					SELF := []
				), KEEP(1), LIMIT(0), LEFT OUTER);	

	dMatchRecsOut := IF(inReturnScores, dMatchRecsWithScores, dMatchRecsWithIncident);
	
	dRecsOut := SORT(dMatchRecsOut, -weight, -score, IF(lexid>0, 0, 1), -dt_first_seen, eid_hash);

	IF(BairRx_Common.Debug.IsMin(), output(choosen(in_params, 50), named('in_params')));	
	IF(BairRx_Common.Debug.IsMax(), output(choosen(dXLinkCleanRecs, 5), named('dXLinkCleanRecs')));		
	IF(BairRx_Common.Debug.IsMed(), output(choosen(dAllMatchRecs, 50), named('dAllMatchRecs')));	
	IF(BairRx_Common.Debug.IsMin(), output(choosen(dMatchRecs, 50), named('dMatchRecs')));	
	IF(BairRx_Common.Debug.IsMed(), output(choosen(dMatchRecsWithNames, 50), named('dMatchRecsWithNames')));	
	IF(BairRx_Common.Debug.IsMed(), output(choosen(dMatchRecsWithEvents, 50), named('dMatchRecsWithEvents')));
	IF(BairRx_Common.Debug.IsMed(), output(choosen(dMatchRecsWithCFS, 50), named('dMatchRecsWithCFS')));	
	IF(BairRx_Common.Debug.IsMin(), output(choosen(dIncidentRecsWithPhones, 50), named('dIncidentRecsWithPhones')));
	IF(BairRx_Common.Debug.IsMin(), output(choosen(dNarrativeIncidentRecs, 50), named('dNarrativeIncidentRecs')));
	IF(BairRx_Common.Debug.IsMax(), output(choosen(dEventRawRecs, 50), named('dEventRawRecs')));
	IF(BairRx_Common.Debug.IsMax(), output(choosen(dEventRawRecsWithCleanAddr, 50), named('dEventRawRecsWithCleanAddr')));
	IF(BairRx_Common.Debug.IsMax(), output(choosen(dCFSRawRecsWithCleanAddr, 50), named('dCFSRawRecsWithCleanAddr')));
	IF(BairRx_Common.Debug.IsMed(), output(choosen(dAllMatchRecsWithParsedPhones, 50), named('dAllMatchRecsWithParsedPhones')));
	IF(BairRx_Common.Debug.IsMed(), output(choosen(dMatchRecsFromNarratives, 50), named('dMatchRecsFromNarratives')));	
	IF(BairRx_Common.Debug.IsMed(), output(choosen(dAddressRecs, 50), named('dAddressRecs')));
	IF(BairRx_Common.Debug.IsMax(), output(choosen(dEVEIDs, 50), named('dEVEIDs')));
	IF(BairRx_Common.Debug.IsMax(), output(choosen(dMatchEIDRecs, 50), named('dMatchEIDRecs')));	
	IF(BairRx_Common.Debug.IsMax(), output(choosen(dEIDScores, 50), named('dEIDScores')));	
		
	RETURN PROJECT(dRecsOut,TRANSFORM(iesp.bair_phonesearch.t_BAIRPhoneSearchRecord, SELF.LexID := IF(LEFT.LexID>0, (STRING) LEFT.LexID, ''), SELF := LEFT, SELF := []));

END;