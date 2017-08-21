import BairRx_Common,BairRx_Spotter;

EXPORT GetPayload := MODULE

	EXPORT SearchView(DATASET(BairRx_Common.Layouts.SearchRec) dIDS, unsigned sort_field_id) := FUNCTION

		pickSortFID := sort_field_id+1;
		dDeltaRecs := JOIN(dIDS(etype=BairRx_Common.EID.Type.SHO), BairRx_Common.Keys.PayloadSSKey(TRUE), keyed(left.eid = right.eid), 
			TRANSFORM(BairRx_Spotter.Layouts.SearchPayload,
				SELF.slim_sort 	:= LEFT.slim_sort,
				SELF.distance 	:= LEFT.distance,
				SELF.date 			:= LEFT.date,
				SELF.sort_type 	:= BairRx_Spotter.Sorting.tvalue(pickSortFID),
				SELF.sort_str  	:= BairRx_Spotter.Sorting.svalue(pickSortFID, RIGHT),
				SELF.sort_num	 	:= BairRx_Spotter.Sorting.nvalue(pickSortFID, RIGHT, LEFT.distance),
				SELF := RIGHT
			), keep(1), LIMIT(BairRx_Common.Constants.MAX_PAYLOAD));	
		dIDSmain 		:= JOIN(dIDS, dDeltaRecs, LEFT.eid = RIGHT.eid, TRANSFORM(BairRx_Common.Layouts.SearchRec,SELF := LEFT),LEFT ONLY);	
		dMainRecs := JOIN(dIDSmain(etype=BairRx_Common.EID.Type.SHO), BairRx_Common.Keys.PayloadSSKey(FALSE), keyed(left.eid = right.eid), 
			TRANSFORM(BairRx_Spotter.Layouts.SearchPayload,
				SELF.slim_sort 	:= LEFT.slim_sort,
				SELF.distance 	:= LEFT.distance,
				SELF.date 			:= LEFT.date,
				SELF.sort_type 	:= BairRx_Spotter.Sorting.tvalue(pickSortFID),
				SELF.sort_str  	:= BairRx_Spotter.Sorting.svalue(pickSortFID, RIGHT),
				SELF.sort_num	 	:= BairRx_Spotter.Sorting.nvalue(pickSortFID, RIGHT, LEFT.distance),
				SELF := RIGHT
			), keep(1), LIMIT(BairRx_Common.Constants.MAX_PAYLOAD));	
		
		dRecs := dDeltaRecs + dMainRecs;
		RETURN dRecs;	
	END;		

	EXPORT MapView(DATASET(BairRx_Common.Layouts.SearchRec) dIDs, unsigned sort_field_id, boolean delta, boolean inc_details = false) := FUNCTION
	
		MapPayloadSpotter := RECORD(BairRx_Common.Layouts.MapPayloadBase)
			BairRx_Common.Layouts.LayoutShotSpotter shot_spotter;
		END;		
	
		pickSortFID := sort_field_id+1;
		dLIDs := LIMIT(dIDS(etype=BairRx_Common.EID.Type.SHO), BairRx_Common.Constants.MAX_PAYLOAD);
		dFetchRecs := JOIN(dLIDs, BairRx_Common.Keys.PayloadSSKey(delta), KEYED(left.eid = right.eid), 
				TRANSFORM(MapPayloadSpotter, 
					SELF.eid					:= LEFT.eid,
					SELF.gh12					:= LEFT.gh12,
					SELF.date					:= LEFT.date,
					SELF.distance 		:= LEFT.distance,
					SELF.latitude			:= (STRING) RIGHT.y_coordinate,
					SELF.longitude		:= (STRING) RIGHT.x_coordinate,			
					SELF.referenceID 	:= (STRING) RIGHT.raids_record_id,
					SELF.address 			:= RIGHT.address,
					SELF.class_code 	:= BairRx_Common.ClassificationCode.MapClassCodeOut(BairRx_Common.EID.Type.SHO, (string) RIGHT.shot_incident_type),
					SELF.class 				:= IF(RIGHT.shot_incident_type in [1,2], '0', '')+(STRING)RIGHT.shot_incident_type,
					SELF.agency				:= RIGHT.data_provider_name,
					SELF.ori					:= RIGHT.data_provider_ori,		
					SELF.etype				:= BairRx_Common.Constants.SearchType.ShotSpotter,
					SELF.stamp				:= BairRx_Common.EID.GetStamp(RIGHT.eid),
					SELF.sort_type 		:= BairRx_Spotter.Sorting.tvalue(pickSortFID),
					SELF.sort_str  		:= BairRx_Spotter.Sorting.svalue(pickSortFID, RIGHT),
					SELF.sort_num	 		:= BairRx_Spotter.Sorting.nvalue(pickSortFID, RIGHT, LEFT.distance),	
					SELF.Accuracy 		:= BairRx_Common.Constants.ACCURACY_ADDRESS_CODE,
					SELF.shot_spotter	:= IF(inc_details, ROW(RIGHT, BairRx_Common.Layouts.LayoutShotSpotter)),
					SELF 							:= []
				), keep(1), LIMIT(0));	// no data relation, keep(1) is ok	
		dRecs := BairRx_Common.FetchLimit(dFetchRecs, BairRx_Common.Constants.MAX_PAYLOAD);			
		
		return dRecs;
	END;
	
END;