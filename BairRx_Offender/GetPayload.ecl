import BairRx_Common,BairRx_Offender;

EXPORT GetPayload := MODULE

	EXPORT SearchView(DATASET(BairRx_Common.Layouts.SearchRec) dIDS, unsigned sort_field_id, boolean is_raids = FALSE) := FUNCTION

		pickSortFID := sort_field_id+1;
		dLimitIDs := LIMIT(dIDS(etype=BairRx_Common.EID.Type.OFF), BairRx_Common.Constants.MAX_PAYLOAD);
		dFetchDeltaRecs := JOIN(dLimitIDs, BairRx_Common.Keys.PayloadOffenderKey(TRUE), 
			keyed(left.eid = right.eid) AND (LEFT.class='' OR LEFT.class[4..6] = RIGHT.classification[1..3]) /* urgh... this will need to be cleaned up later. */, 
			TRANSFORM(BairRx_Offender.Layouts.SearchPayload, 
				SELF.eid				:= LEFT.eid,
				SELF.slim_sort 	:= LEFT.slim_sort,
				SELF.distance 	:= LEFT.distance,
				SELF.date 			:= LEFT.date,
				SELF.sort_type 	:= BairRx_Offender.Sorting.tvalue(pickSortFID),
				SELF.sort_str  	:= BairRx_Offender.Sorting.svalue(pickSortFID, RIGHT),
				SELF.sort_num	 	:= BairRx_Offender.Sorting.nvalue(pickSortFID, RIGHT, LEFT.distance),
				SELF.accuracy 	:= BairRx_Common.Constants.ACCURACY_STREET_CODE, // hard code, same as ATACRaids.
				SELF.class_code := BairRx_Common.ClassificationCode.MapClassCodeOut(BairRx_Common.EID.Type.OFF, RIGHT.classification_code),
				is_raids_ok := RIGHT.classification in ['SEX', 'sex']; // we could be just checking the class code, but I'm keeping the same check used in Bair.Build_GeoHash instead.
				SELF.raids_ok		:= IF(is_raids AND ~is_raids_ok, SKIP, is_raids_ok);
				SELF := RIGHT
			), KEEP(1), LIMIT(0));	
		dIDSmain 		:= JOIN(dIDS, dFetchDeltaRecs, LEFT.eid = RIGHT.eid, TRANSFORM(BairRx_Common.Layouts.SearchRec,SELF := LEFT),LEFT ONLY);	
		dFetchMainRecs := JOIN(dIDSmain, BairRx_Common.Keys.PayloadOffenderKey(FALSE), 
			keyed(left.eid = right.eid) AND (LEFT.class='' OR LEFT.class[4..6] = RIGHT.classification[1..3]) /* urgh... this will need to be cleaned up later. */, 
			TRANSFORM(BairRx_Offender.Layouts.SearchPayload, 
				SELF.eid				:= LEFT.eid,
				SELF.slim_sort 	:= LEFT.slim_sort,
				SELF.distance 	:= LEFT.distance,
				SELF.date 			:= LEFT.date,
				SELF.sort_type 	:= BairRx_Offender.Sorting.tvalue(pickSortFID),
				SELF.sort_str  	:= BairRx_Offender.Sorting.svalue(pickSortFID, RIGHT),
				SELF.sort_num	 	:= BairRx_Offender.Sorting.nvalue(pickSortFID, RIGHT, LEFT.distance),
				SELF.accuracy 	:= BairRx_Common.Constants.ACCURACY_STREET_CODE, // hard code, same as ATACRaids.
				SELF.class_code := BairRx_Common.ClassificationCode.MapClassCodeOut(BairRx_Common.EID.Type.OFF, RIGHT.classification_code),
				is_raids_ok := RIGHT.classification in ['SEX', 'sex'];
				SELF.raids_ok		:= IF(is_raids AND ~is_raids_ok, SKIP, is_raids_ok);
				SELF := RIGHT
			), KEEP(1), LIMIT(0));	
				
		dRecs := BairRx_Common.FetchLimit(dFetchDeltaRecs + dFetchMainRecs, BairRx_Common.Constants.MAX_PAYLOAD);		
		RETURN dRecs;	
	END;		
	
	EXPORT MapView(DATASET(BairRx_Common.Layouts.SearchRec) dIDs, unsigned sort_field_id, boolean delta, boolean inc_details = false) := FUNCTION
	
		MapPayloadOffender := RECORD(BairRx_Common.Layouts.MapPayloadBase)
			BairRx_Common.Layouts.LayoutOffender offender;
		END;
	
		OFFK := BairRx_Common.Keys.PayloadOffenderKey(delta);
		
		BairRx_Common.Layouts.LayoutOffender xtOffender(RECORDOF(OFFK) R, unsigned ccode) := TRANSFORM
			SELF.class_code := ccode,
			SELF := R
		END;
		
		pickSortFID := sort_field_id+1;
		dLIDs := LIMIT(dIDS(etype=BairRx_Common.EID.Type.OFF), BairRx_Common.Constants.MAX_PAYLOAD);
		dFetchRecs := 
			JOIN(dLIDs, OFFK, KEYED(left.eid = right.eid), 
				TRANSFORM(MapPayloadOffender, 
					ccode 						:= BairRx_Common.ClassificationCode.MapClassCodeOut(BairRx_Common.EID.Type.OFF, RIGHT.classification_code);
					SELF.eid					:= LEFT.eid,
					SELF.gh12					:= LEFT.gh12,
					SELF.date					:= LEFT.date,
					SELF.distance 		:= LEFT.distance,
					SELF.latitude			:= (STRING) RIGHT.y_coordinate,
					SELF.longitude		:= (STRING) RIGHT.x_coordinate,			
					SELF.referenceID 	:= RIGHT.agency_offender_id,
					SELF.address 			:= RIGHT.address,
					SELF.class_code 	:= ccode,
					SELF.class 				:= RIGHT.classification,
					SELF.agency				:= RIGHT.data_provider_name,
					SELF.ori					:= RIGHT.data_provider_ori,		
					SELF.etype				:= BairRx_Common.Constants.SearchType.Offender,
					SELF.stamp				:= BairRx_Common.EID.GetStamp(RIGHT.eid),
					SELF.sort_type 		:= BairRx_Offender.Sorting.tvalue(pickSortFID),
					SELF.sort_str  		:= BairRx_Offender.Sorting.svalue(pickSortFID, RIGHT),
					SELF.sort_num	 		:= BairRx_Offender.Sorting.nvalue(pickSortFID, RIGHT, LEFT.distance),		
					SELF.accuracy 		:= BairRx_Common.Constants.ACCURACY_STREET_CODE, // hard code, same as ATACRaids.
					SELF.offender			:= IF(inc_details, ROW(xtOffender(RIGHT, ccode))),
					SELF 							:= []
				), keep(1), LIMIT(0)); // no data relation, keep(1) is fine		
		dRecs := BairRx_Common.FetchLimit(dFetchRecs, BairRx_Common.Constants.MAX_PAYLOAD);		
		
		return dRecs;
	END;

	
END;