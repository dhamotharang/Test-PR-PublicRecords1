IMPORT BairRx_Common;

EXPORT Raw := MODULE

	SHARED MAC_GetRawRecs(dIDsIn, dRecsOut, KeyName, LayoutOut) := MACRO
		#uniquename(dDeltaRecs)
		#uniquename(dMainIDs)			 
		#uniquename(dMainRecs)			 		
		%dDeltaRecs% 	:= JOIN(dIDsIn, KeyName(TRUE), KEYED(LEFT.eid = RIGHT.eid), TRANSFORM(LayoutOut,	SELF := RIGHT,SELF := []),LIMIT(0),KEEP(1));		
		%dMainIDs% 		:= JOIN(dIDsIn,%dDeltaRecs%, LEFT.eid = RIGHT.eid, TRANSFORM(LEFT), LEFT ONLY);
		%dMainRecs% 	:= JOIN(%dMainIDs%, KeyName(FALSE), KEYED(LEFT.eid = RIGHT.eid), TRANSFORM(LayoutOut,	SELF := RIGHT, SELF := []),LIMIT(0),KEEP(1));
		dRecsOut := %dMainRecs% + %dDeltaRecs%;	
	ENDMACRO;

	EXPORT GetEvents(DATASET(BairRx_Common.Layouts.EID) dIDs) := FUNCTION
		MAC_GetRawRecs(dIDs, dRecs, BairRx_Common.Keys.PayloadMOKey, BairRx_PSS.Layouts.LayoutMO);
		RETURN dRecs;
	END;
	
	EXPORT GetCFS(DATASET(BairRx_Common.Layouts.EID) dIDs) := FUNCTION	
		MAC_GetRawRecs(dIDs, dRecs, BairRx_Common.Keys.PayloadCFSKey, BairRx_PSS.Layouts.LayoutCFS);
		RETURN dRecs;
	END;
	
	EXPORT GetCrash(DATASET(BairRx_Common.Layouts.EID) dIDs) := FUNCTION	
		MAC_GetRawRecs(dIDs, dRecs, BairRx_Common.Keys.PayloadCrashKey, BairRx_PSS.Layouts.LayoutCrash);		
		RETURN dRecs;	
	END;
	
	EXPORT GetLPR(DATASET(BairRx_Common.Layouts.EID) dIDs) := FUNCTION	
		MAC_GetRawRecs(dIDs, dRecs, BairRx_Common.Keys.PayloadLPRKey, BairRx_PSS.Layouts.LayoutLPR);		
		RETURN dRecs;	
	END;
	
	EXPORT GetOffenders(DATASET(BairRx_Common.Layouts.EID) dIDs) := FUNCTION	
		MAC_GetRawRecs(dIDs, dRecs, BairRx_Common.Keys.PayloadOffenderKey, BairRx_PSS.Layouts.LayoutOffender);		
		RETURN dRecs;	
	END;
	
	EXPORT GetEIDsByPhone(STRING10 inPhone) := FUNCTION
	
		// Get EIDs from both Delta and Main keys		
		EIDsDelta := LIMIT(BairRx_Common.Keys.PayloadKey_MO_PHONE(TRUE)(KEYED(Phone = inPhone)), BairRx_Common.Constants.MAX_JOIN_LIMIT);
		EIDsMain := LIMIT(BairRx_Common.Keys.PayloadKey_MO_PHONE(FALSE)(KEYED(Phone = inPhone)), BairRx_Common.Constants.MAX_JOIN_LIMIT);
		
		// Eliminate EIDs from Main Key that are also found in Delta Key
		EIDsMainOnly := JOIN(EIDsMain,EIDsDelta, LEFT.EID = RIGHT.EID,TRANSFORM(LEFT),LEFT ONLY );
				
		// Combine delta and main records while filtering for only Current records(filtering out invalid stale records)
		EIDs := EIDsDelta(Iscurrent) + EIDsMainOnly(Iscurrent);
		
		Return EIDs;
	END;
	
	

END;