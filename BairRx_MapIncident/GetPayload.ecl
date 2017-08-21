import BairRx_Common;

EXPORT GetPayload(DATASET(BairRx_Common.Layouts.SearchRec) dIDS) := FUNCTION
	
	//dRecs_CFS := BairRx_Common.GetPayloadCFS.Get(dIDs);
	//dRecs_CRA := BairRx_Common.GetPayloadCrash.Get(dIDs);
	//dRecs_OFF := BairRx_Common.GetPayloadOffender.Get(dIDs);
	//dRecs_LPR := BairRx_Common.GetPayloadLpr.Get(dIDs);	
	
	// TODO: Must check for filter/sorting clause in which case may need to fetch full payload.
	dRecs_EVE := BairRX_MapIncident.Raw.GetEventPayloadSlim(dIDs);
	dRecs_CFS := BairRX_MapIncident.Raw.GetCfsPayloadSlim(dIDs);
	dRecs_CRA := BairRX_MapIncident.Raw.GetCrashPayloadSlim(dIDs);
	dRecs_OFF := BairRX_MapIncident.Raw.GetOffenderPayloadSlim(dIDs);
	dRecs_LPR := BairRX_MapIncident.Raw.GetLPRPayloadSlim(dIDs);
	dRecs 		:= dRecs_EVE+dRecs_CFS+dRecs_CRA+dRecs_OFF+dRecs_LPR;
	
	RETURN dRecs;
	
END;