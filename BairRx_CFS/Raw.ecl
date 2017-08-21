IMPORT BairRx_Common;

EXPORT Raw := MODULE
	
	EXPORT GetCalls(DATASET(BairRx_Common.Layouts.SearchRec) dIDS, BOOLEAN delta) := FUNCTION
		dFetchRecs := JOIN(dIDS(etype=BairRx_Common.EID.Type.CFS), BairRx_Common.Keys.PayloadCFSKey(delta), 
				KEYED(left.eid = right.eid), 
				TRANSFORM(BairRx_CFS.Layouts.PayloadCFS, 
				  SELF.distance := LEFT.distance,
					SELF          := RIGHT
				), KEEP(1), LIMIT(0));
		dRecs := BairRx_Common.FetchLimit(dFetchRecs, BairRx_Common.Constants.MAX_JOIN_LIMIT);			
		RETURN dRecs;
	END;	
	
	EXPORT GetOfficers(DATASET(BairRx_Common.Layouts.SearchRec) dIDs, UNSIGNED1 data_relation, BOOLEAN delta) := FUNCTION
		isPrimaryView := BairRx_Common.DataRelation.IsPrimaryView(data_relation);
		dFetchRecs := JOIN(dIDS(etype=BairRx_Common.EID.Type.CFS), BairRx_Common.Keys.PayloadCFSKey_Officer(delta), 
				KEYED(LEFT.eid = RIGHT.eid) AND (~isPrimaryView OR RIGHT.primary_officer_indicator), 
				TRANSFORM(BairRx_CFS.Layouts.PayloadOfficer, 
					SELF := RIGHT
				), LIMIT(0));
			dRecs := BairRx_Common.FetchLimit(dFetchRecs, BairRx_Common.Constants.MAX_JOIN_LIMIT);			
			RETURN dRecs;
	END;				
END;