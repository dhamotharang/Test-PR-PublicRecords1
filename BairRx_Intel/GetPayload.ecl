IMPORT BairRx_Common,BairRx_Intel;

EXPORT GetPayload := MODULE
			
	EXPORT SearchView(DATASET(BairRx_Common.Layouts.SearchRec) dIDS, unsigned sort_field_id, boolean delta) := FUNCTION
	
		pickSortFID := sort_field_id + 1;
		dLimitIDs := LIMIT(dIDS(etype=BairRx_Common.EID.Type.INT), BairRx_Common.Constants.MAX_JOIN_LIMIT);
		dFetchRecs := 
			JOIN(dLimitIDs, BairRx_Common.Keys.PayloadIntelKey(delta), keyed(left.eid = right.eid), 
				TRANSFORM(BairRx_Intel.Layouts.SearchPayload, 						
					SELF.slim_sort 		:= LEFT.slim_sort,
					SELF.distance 		:= LEFT.distance,
					SELF.date					:= LEFT.date,
					SELF.sort_type 		:= BairRx_Intel.Sorting.tvalue(pickSortFID),
					SELF.sort_str  		:= BairRx_Intel.Sorting.svalue(pickSortFID, RIGHT),
					SELF.sort_num	 		:= BairRx_Intel.Sorting.nvalue(pickSortFID, RIGHT, LEFT.distance),
					SELF.vehicle_year := IF(RIGHT.vehicle_year > 0, RIGHT.vehicle_year,0);
					SELF := RIGHT,
					SELF := []
				), keep(1), LIMIT(0));
				
		dRecs := BairRx_Common.FetchLimit(dFetchRecs, BairRx_Common.Constants.MAX_JOIN_LIMIT);		
		RETURN dRecs;
	END;		
		
	EXPORT ReportView(DATASET(BairRx_Common.Layouts.SearchRec) dIDS, boolean include_notes, boolean delta) := FUNCTION
		dRaw := JOIN(dIDS(etype=BairRx_Common.EID.Type.INT), BairRx_Common.Keys.PayloadIntelKey(delta), keyed(left.eid = right.eid), 
			TRANSFORM(RIGHT), LIMIT(BairRx_Common.Constants.MAX_JOIN_LIMIT));
		
		dIncidents := DEDUP(SORT(PROJECT(dRaw, TRANSFORM(BairRx_Intel.Layouts.PayloadIncident, SELF := LEFT)), eid), eid);
		dEntities := PROJECT(dRaw(incident_id>0), TRANSFORM(BairRx_Intel.Layouts.PayloadEntity, SELF := LEFT));
		dNotes := BairRx_Common.GetNotes(dIDs);
		
		dRecs := PROJECT(dIncidents, TRANSFORM(BairRx_Intel.Layouts.ReportPayload, 
			SELF.incidents := dIncidents(eid=LEFT.eid),
			SELF.entities := dEntities(eid=LEFT.eid),
			SELF.notes := IF(include_notes, dNotes(eid=LEFT.eid, note_type=BairRx_Common.Constants.NoteType.IntelIncident), 
				DATASET([], BairRx_Common.Layouts.PayloadNotes)),
			SELF := LEFT, 
			SELF := []));
		
		return dRecs;
	END;				
	
	EXPORT MapView(DATASET(BairRx_Common.Layouts.SearchRec) dIDs, unsigned1 data_relation, unsigned sort_field_id, boolean inc_details = false) := FUNCTION
	
		pickSortFID := sort_field_id+1;
		dFetchRecs := 
			JOIN(dIDS(etype=BairRx_Common.EID.Type.INT), BairRx_Common.Keys.PayloadIntelKey(), 
				keyed(left.eid = right.eid), 
				TRANSFORM(BairRx_Common.Layouts.MapPayloadBase, 
					SELF.eid					:= LEFT.eid,
					SELF.gh12					:= LEFT.gh12,
					SELF.date					:= LEFT.date,
					SELF.distance 		:= LEFT.distance,
					SELF.latitude			:= (STRING) RIGHT.y,
					SELF.longitude		:= (STRING) RIGHT.x,			
					SELF.referenceID 	:= (STRING) RIGHT.id,
					SELF.address 			:= stringlib.stringcleanspaces(RIGHT.incident_address+' '+RIGHT.incident_city+' '+RIGHT.incident_state),					
					SELF.class_code		:= BairRx_Common.ClassificationCode.MapClassCodeOut(BairRx_Common.EID.Type.INT, RIGHT.incident_type),
					SELF.class 				:= RIGHT.incident_type,
					SELF.agency				:= RIGHT.data_provider_name,
					SELF.ori					:= RIGHT.data_provider_ori,		
					SELF.etype				:= BairRx_Common.Constants.SearchType.Intel,
					SELF.stamp				:= BairRx_Common.EID.GetStamp(RIGHT.eid),
					SELF.sort_type 		:= BairRx_Intel.Sorting.tvalue(pickSortFID),
					SELF.sort_str  		:= BairRx_Intel.Sorting.svalue(pickSortFID, RIGHT),
					SELF.sort_num	 		:= BairRx_Intel.Sorting.nvalue(pickSortFID, RIGHT, LEFT.distance),
					SELF.accuracy 		:= BairRx_Common.Constants.ACCURACY_ADDRESS_CODE,
					SELF 							:= []
				), KEEP(1), LIMIT(0));
		
		dRecs 	:= BairRx_Common.FetchLimit(dFetchRecs, BairRx_Common.Constants.MAX_PAYLOAD);	
		
		return dRecs;
	END;	
		
END;