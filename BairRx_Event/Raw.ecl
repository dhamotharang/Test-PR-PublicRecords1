import BairRx_Common;

EXPORT Raw := MODULE


	EXPORT GetMOs(DATASET(BairRx_Common.Layouts.SearchRec) dIDs, boolean fetchAll, boolean delta) := FUNCTION
		dLimitIDs := LIMIT(dIDS(etype=BairRx_Common.EID.Type.EVE), BairRx_Common.Constants.MAX_JOIN_LIMIT);
		dFetchRecs := JOIN(dLimitIDs, BairRx_Common.Keys.PayloadMOKey(delta),
				 KEYED(LEFT.eid = RIGHT.eid) AND (fetchAll OR LEFT.stamp = (integer)RIGHT.mostamp),
				 TRANSFORM(BairRx_Event.Layouts.PayloadMO,						
				 		SELF := RIGHT,
						SELF := [] 
				 ),LIMIT(0),KEEP(BairRx_Common.Constants.MAX_JOIN_LIMIT+1));		
		dRecs := BairRx_Common.FetchLimit(dFetchRecs, BairRx_Common.Constants.MAX_JOIN_LIMIT);			
		return dRecs;
	END;
		
	EXPORT GetMOUDFs(DATASET(BairRx_Event.Layouts.PayloadMO) dMos, unsigned4 DPID, boolean delta, boolean isUDFMOFID = false, unsigned2 sortFID = 0) := FUNCTION
		dFetchRecs := JOIN(dMos, BairRx_Common.Keys.PayloadMOUDFKey(delta),
			KEYED(DPID>0 AND LEFT.eid = RIGHT.eid AND RIGHT.data_provider_id = DPID AND LEFT.mostamp = RIGHT.stamp),
			TRANSFORM(BairRx_Event.Layouts.PayloadMOUDF,
				udf_type := IF(isUDFMOFID, BairRx_Event.Sorting.tvalueMOUDF(sortFID, RIGHT), 0);
				SELF.sort_type := IF(isUDFMOFID, udf_type, LEFT.sort_type), // MO udf type is not static, must check at record level.
				SELF.sort_str  := IF(isUDFMOFID, BairRx_Event.Sorting.svalueMOUDF(sortFID, udf_type, RIGHT), LEFT.sort_str),
				SELF.sort_num	 := IF(isUDFMOFID, BairRx_Event.Sorting.nvalueMOUDF(sortFID, udf_type, RIGHT), left.sort_num),
				SELF := RIGHT, // moudf1 .. moudf8
				SELF := LEFT
			), KEEP(1), LIMIT(0));				
		dRecs := BairRx_Common.FetchLimit(dFetchRecs, BairRx_Common.Constants.MAX_JOIN_LIMIT);					
		return dRecs;			 
	END;

	EXPORT GetVehicles(DATASET(BairRx_Common.Layouts.SearchRec) dIDs, boolean fetchAll, boolean delta) := FUNCTION
		dLimitIDs := LIMIT(dIDS(etype=BairRx_Common.EID.Type.EVE), BairRx_Common.Constants.MAX_JOIN_LIMIT);
		dFetchRecs := JOIN(dLimitIDs, BairRx_Common.Keys.PayloadVehicleKey(delta), 
				 KEYED(LEFT.eid = RIGHT.eid) AND (fetchAll OR LEFT.stamp = (integer)RIGHT.vehiclestamp),
					 TRANSFORM(BairRx_Event.Layouts.PayloadVehicle,
						SELF.vehicle_edit_date := RIGHT.edit_date,
						SELF := RIGHT
					 ), LIMIT(0), KEEP(BairRx_Common.Constants.MAX_JOIN_LIMIT+1));
		dRecs := BairRx_Common.FetchLimit(dFetchRecs, BairRx_Common.Constants.MAX_JOIN_LIMIT);			
		return dRecs;			 
	END;
		
	EXPORT GetPersons(DATASET(BairRx_Common.Layouts.SearchRec) dIDs, boolean fetchAll, boolean delta) := FUNCTION 
		dLimitIDs := LIMIT(dIDS(etype=BairRx_Common.EID.Type.EVE), BairRx_Common.Constants.MAX_JOIN_LIMIT);
		dFetchRecs := JOIN(dLimitIDs, BairRx_Common.Keys.PayloadPersonKey(delta), 
			KEYED(LEFT.eid = RIGHT.eid) AND (fetchAll OR LEFT.stamp = (integer)RIGHT.personstamp),
					 TRANSFORM(BairRx_Event.Layouts.PayloadPerson,
						SELF.persons_edit_date := RIGHT.edit_date,
						SELF := RIGHT,
						SELF := [] // udf fields
					 ), LIMIT(0),KEEP(BairRx_Common.Constants.MAX_JOIN_LIMIT+1));	
		dRecs := BairRx_Common.FetchLimit(dFetchRecs, BairRx_Common.Constants.MAX_JOIN_LIMIT);			
		return dRecs;	
	END;
	
	EXPORT GetPersonUDFs(DATASET(BairRx_Event.Layouts.PayloadPerson) dPersons, unsigned4 DPID, boolean delta, boolean isUDFPersonFID = false, unsigned2 sortFID = 0) := FUNCTION 
		dFetchRecs := JOIN(dPersons, BairRx_Common.Keys.PayloadPersonUDFKey(delta), 
			KEYED(DPID>0 AND LEFT.eid = RIGHT.eid AND RIGHT.data_provider_id = DPID AND LEFT.personstamp = RIGHT.stamp),
			 TRANSFORM(BairRx_Event.Layouts.PayloadPersonUDF,
				udf_type := IF(isUDFPersonFID, BairRx_Event.Sorting.tvaluePersonUDF(sortFID, RIGHT), 0);
				SELF.sort_type := IF(isUDFPersonFID, udf_type, LEFT.sort_type), // person udf type is not static, must check at record level.
				SELF.sort_str  := IF(isUDFPersonFID, BairRx_Event.Sorting.svaluePersonUDF(sortFID, udf_type, RIGHT), LEFT.sort_str),
				SELF.sort_num	 := IF(isUDFPersonFID, BairRx_Event.Sorting.nvaluePersonUDF(sortFID, udf_type, RIGHT), LEFT.sort_num),
				SELF := RIGHT, // personudf1 .. personudf4
				SELF := LEFT
			 ), KEEP(1), LIMIT(0));
			
		dRecs := BairRx_Common.FetchLimit(dFetchRecs, BairRx_Common.Constants.MAX_JOIN_LIMIT);					
		return dRecs;	
	END;
	
	EXPORT GetNotes(DATASET(BairRx_Common.Layouts.SearchRec) dIDs) := FUNCTION

		ddIDs 						:= DEDUP(SORT(dIDs, eid), eid);		
		dFetchDeltaRecs 	:= JOIN(ddIDs, BairRx_Common.Keys.NotesKey(TRUE).IDX, KEYED(left.eid = right.eid), TRANSFORM(RIGHT), KEEP(10), LIMIT(0));	
		dIDSmain 					:= JOIN(dIDS, dFetchDeltaRecs, LEFT.eid = RIGHT.eid, TRANSFORM(BairRx_Common.Layouts.SearchRec,SELF := LEFT),LEFT ONLY);
		dFetchMainRecs 		:= JOIN(dIDSmain, BairRx_Common.Keys.NotesKey(FALSE).IDX, KEYED(left.eid = right.eid), TRANSFORM(RIGHT), KEEP(10), LIMIT(0));	
		ddFetchDeltaRecs 	:= DEDUP(SORT(dFetchDeltaRecs, eid, note_type, referid), eid, note_type, referid);
		ddFetchMainRecs 	:= DEDUP(SORT(dFetchMainRecs, eid, note_type, referid), eid, note_type, referid);
					
		dDeltaNotes := FETCH(BairRx_Common.Keys.NotesKey(TRUE).FILE, ddFetchDeltaRecs, RIGHT.__filepos, 
			TRANSFORM(BairRx_Common.Layouts.PayloadNotes, SELF.notes := LEFT.notes, SELF := RIGHT));
		dMainNotes := FETCH(BairRx_Common.Keys.NotesKey(FALSE).FILE, ddFetchMainRecs, RIGHT.__filepos, 
			TRANSFORM(BairRx_Common.Layouts.PayloadNotes, SELF.notes := LEFT.notes, SELF := RIGHT));	
		dNotes	:= 	dDeltaNotes + dMainNotes;
		
		return dNotes;						 
END;
					 
END;