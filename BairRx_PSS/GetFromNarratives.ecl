IMPORT BairRx_PSS,BairRx_Common,Bair_composite;

EXPORT GetFromNarratives := MODULE
	
	EXPORT ByPhone(STRING inPhone, DATASET(BairRx_Common.Layouts.EID) dEIDs, STRING inAgencyORI, INTEGER MaxPhonesPerInc = 5) := FUNCTION	
		
		dDeltaMatchEIDs := JOIN(DEDUP(SORT(dEIDs, eid),eid), BairRx_Common.Keys.PayloadKey_MO_EID(TRUE), 
			KEYED(LEFT.eid = RIGHT.eid),
			TRANSFORM(BairRx_PSS.Layouts.LayoutParsedPhone, SELF.eid_hash := Bair_composite.fn_scale_eid(LEFT.eid), SELF := RIGHT),
			KEEP(MaxPhonesPerInc), LIMIT(0));

		dMainEIDs := JOIN(DEDUP(SORT(dEIDs, eid),eid),dDeltaMatchEIDs, LEFT.eid = RIGHT.eid, TRANSFORM(BairRx_Common.Layouts.EID, SELF := LEFT),LEFT ONLY);
			
		dMainMatchEIDs := JOIN(DEDUP(SORT(dMainEIDs, eid),eid), BairRx_Common.Keys.PayloadKey_MO_EID(FALSE), 
			KEYED(LEFT.eid = RIGHT.eid),
			TRANSFORM(BairRx_PSS.Layouts.LayoutParsedPhone, SELF.eid_hash := Bair_composite.fn_scale_eid(LEFT.eid), SELF := RIGHT),
			KEEP(MaxPhonesPerInc), LIMIT(0));
			
		dMatchEIDS := dDeltaMatchEIDs + dMainMatchEIDs;

		dPhoneRecs := PROJECT(BairRx_PSS.Raw.GetEIDsByPhone(inPhone), TRANSFORM(BairRx_PSS.Layouts.LayoutParsedPhone, 
			SELF.eid_hash := Bair_composite.fn_scale_eid(LEFT.eid), SELF.match_by_phone := TRUE, SELF := LEFT));						

		dParsedPhoneRecs := DEDUP(SORT(dMatchEIDs + dPhoneRecs, eid, phone), eid, phone);

		dIncidentRecs := JOIN(dParsedPhoneRecs, BairRx_Common.Keys.PayloadKey_EID_hash(), 
				KEYED(LEFT.eid_hash = RIGHT.eid_hash), 
				TRANSFORM(BairRx_PSS.Layouts.LayoutPhoneSearchRec, 
					SELF.narrative_phone 	:= LEFT.phone, 
					SELF.match_phone 			:= IF(LEFT.match_by_phone, 2, 0), // +2?
					SELF.record_score 		:= IF(LEFT.match_by_phone, 2, 0), // +2?
					SELF.weight						:= IF(LEFT.match_by_phone, 10, 0), // +10?
					SELF 									:= RIGHT, 
					SELF 									:= LEFT, 
					SELF 									:= []), 
			KEEP(1), LIMIT(0));
			
		dIncidentRecsClean := BairRx_Common.GroupAccessControl.Clean(dIncidentRecs, inAgencyORI, data_provider_ori);
		
		RETURN dIncidentRecsClean;		
	END;	
END;