IMPORT BairRx_Common;

EXPORT GetPayload := MODULE
	
	EXPORT SearchView(DATASET(BairRx_Common.Layouts.SearchRec) dIDS, unsigned sort_field_id, boolean delta) := FUNCTION
		pickSortFID := sort_field_id+1;
		dLIDs := LIMIT(dIDS, BairRx_Common.Constants.MAX_PAYLOAD);
		dFetchRecs := 
			JOIN(dLIDs, BairRx_Common.Keys.PayloadLprKey(delta), 
				KEYED(left.eid = right.eid), 
				TRANSFORM(BairRx_LPR.Layouts.SearchPayload, 					
					SELF.slim_sort 	:= LEFT.slim_sort,
					SELF.distance 	:= LEFT.distance,
					SELF.date 			:= LEFT.date,
					SELF.sort_type 	:= BairRx_LPR.Sorting.tvalue(pickSortFID),
					SELF.sort_str  	:= BairRx_LPR.Sorting.svalue(pickSortFID, RIGHT),
					SELF.sort_num	 	:= BairRx_LPR.Sorting.nvalue(pickSortFID, RIGHT, LEFT.distance),
					SELF := RIGHT,
					SELF := []
				), keep(1), LIMIT(0));	
		dRecs := BairRx_Common.FetchLimit(dFetchRecs, BairRx_Common.Constants.MAX_PAYLOAD);		
		RETURN dRecs;
	END;		
	
	EXPORT MapView(DATASET(BairRx_Common.Layouts.SearchRec) dIDs, unsigned1 data_relation, unsigned sort_field_id, boolean delta, boolean inc_details = false) := FUNCTION
		
		MapPayloadLPR := RECORD(BairRx_Common.Layouts.MapPayloadBase)
			BairRx_Common.Layouts.LayoutLPR lpr;
		END;
		
		pickSortFID := sort_field_id+1;
		dLIDs := LIMIT(dIDS(etype=BairRx_Common.EID.Type.LPR), BairRx_Common.Constants.MAX_PAYLOAD);
		dFetchRecs := JOIN(dLIDs, BairRx_Common.Keys.PayloadLprKey(delta), KEYED(left.eid = right.eid), 
				TRANSFORM(MapPayloadLPR, 
					SELF.eid					:= LEFT.eid,
					SELF.gh12					:= LEFT.gh12,
					SELF.date					:= LEFT.date,
					SELF.distance 		:= LEFT.distance,
					SELF.latitude			:= (STRING) RIGHT.y_coordinate,
					SELF.longitude		:= (STRING) RIGHT.x_coordinate,			
					SELF.referenceID 	:= RIGHT.licenseplaterecordguid,
					SELF.address 			:= '',
					SELF.class_code 	:= BairRx_Common.ClassificationCode.MapClassCodeOut(BairRx_Common.EID.Type.LPR, BairRx_Common.Constants.LPR_CLASS),
					SELF.class 				:= BairRx_Common.Constants.LPR_CLASS,
					SELF.agency				:= RIGHT.data_provider_name,
					SELF.ori					:= RIGHT.data_provider_ori,		
					SELF.etype				:= BairRx_Common.Constants.SearchType.LPR,
					SELF.stamp				:= BairRx_Common.EID.GetStamp(RIGHT.eid),
					SELF.sort_type 		:= BairRx_LPR.Sorting.tvalue(pickSortFID),
					SELF.sort_str  		:= BairRx_LPR.Sorting.svalue(pickSortFID, RIGHT),
					SELF.sort_num	 		:= BairRx_LPR.Sorting.nvalue(pickSortFID, RIGHT, LEFT.distance),
					SELF.accuracy 		:= BairRx_Common.Constants.ACCURACY_ADDRESS_CODE,
					SELF.lpr					:= IF(inc_details, ROW(RIGHT, BairRx_Common.Layouts.LayoutLPR)),
					SELF 							:= []
				), KEEP(1), LIMIT(0));  // no data relation, keep(1) is fine		
				
		dRecs := BairRx_Common.FetchLimit(dFetchRecs, BairRx_Common.Constants.MAX_PAYLOAD);
		
		RETURN dRecs;
	END;
	
END;