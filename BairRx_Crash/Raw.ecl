IMPORT BairRx_Common, BairRx_Crash;

EXPORT Raw := MODULE

	EXPORT GetIncidents(DATASET(BairRx_Common.Layouts.SearchRec) dIDs, boolean delta) := FUNCTION
		dFetchRecs := JOIN(dIDS(etype=BairRx_Common.EID.Type.CRA), BairRx_Common.Keys.PayloadCrashKey(delta), 
			KEYED(LEFT.eid = RIGHT.eid), 
			TRANSFORM(BairRx_Crash.Layouts.PayloadIncident, 
				SELF := RIGHT
			), KEEP(1), LIMIT(0)); // only 1 incident per eid
		dRecs := BairRx_Common.FetchLimit(dFetchRecs, BairRx_Common.Constants.MAX_JOIN_LIMIT);		
		RETURN dRecs;
	END;
	
	EXPORT GetPersons(DATASET(BairRx_Common.Layouts.SearchRec) dIDs, boolean delta) := FUNCTION
		dFetchRecs := JOIN(dIDS(etype=BairRx_Common.EID.Type.CRA), BairRx_Common.Keys.PayloadCrashPersonKey(delta), 
			KEYED(LEFT.eid = RIGHT.eid),
			TRANSFORM(BairRx_Crash.Layouts.PayloadPerson, 
				SELF := RIGHT
			), LIMIT(0)); 
		dRecs := BairRx_Common.FetchLimit(dFetchRecs, BairRx_Common.Constants.MAX_JOIN_LIMIT);		
		RETURN dRecs;
	END;
	
	EXPORT GetPersonsPrimary(DATASET(BairRx_Common.Layouts.SearchRec) dIDs, boolean delta) := FUNCTION
		dFetchRecs := JOIN(dIDS(etype=BairRx_Common.EID.Type.CRA), BairRx_Common.Keys.PayloadCrashPersonKey(delta), 
			KEYED(LEFT.eid = RIGHT.eid),
			TRANSFORM(BairRx_Crash.Layouts.PayloadPerson, 
				SELF := RIGHT
			), KEEP(1),LIMIT(0)); 
		dRecs := BairRx_Common.FetchLimit(dFetchRecs, BairRx_Common.Constants.MAX_JOIN_LIMIT);		
		RETURN dRecs;
	END;
	
	EXPORT GetVehicles(DATASET(BairRx_Common.Layouts.SearchRec) dIDs, boolean delta) := FUNCTION
		dFetchRecs := JOIN(dIDS(etype=BairRx_Common.EID.Type.CRA), BairRx_Common.Keys.PayloadCrashVehicleKey(delta), 
			KEYED(LEFT.eid = RIGHT.eid), 
			TRANSFORM(BairRx_Crash.Layouts.PayloadVehicle, 
				SELF := RIGHT
			), LIMIT(0)); 
		dRecs := BairRx_Common.FetchLimit(dFetchRecs, BairRx_Common.Constants.MAX_JOIN_LIMIT);		
		RETURN dRecs;
	END;
	
	EXPORT GetVehiclesPrimary(DATASET(BairRx_Common.Layouts.SearchRec) dIDs, boolean delta) := FUNCTION
		dFetchRecs := JOIN(dIDS(etype=BairRx_Common.EID.Type.CRA), BairRx_Common.Keys.PayloadCrashVehicleKey(delta), 
			KEYED(LEFT.eid = RIGHT.eid), 
			TRANSFORM(BairRx_Crash.Layouts.PayloadVehicle, 
				SELF := RIGHT
			), KEEP(1), LIMIT(0)); 
		dRecs := BairRx_Common.FetchLimit(dFetchRecs, BairRx_Common.Constants.MAX_JOIN_LIMIT);		
		RETURN dRecs;
	END;
		
	
END;