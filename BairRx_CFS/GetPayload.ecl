import BairRx_CFS, BairRx_Common;

EXPORT GetPayload := MODULE
	
	EXPORT SearchView(dataset(BairRx_Common.Layouts.SearchRec) dIDS, unsigned1 data_relation, unsigned sort_field_id, boolean delta) := FUNCTION

		isPrimaryView := BairRx_Common.DataRelation.IsPrimaryView(data_relation);
		pickSortFID := sort_field_id+1; 
		sortType := BairRx_CFS.Sorting.tvalue(pickSortFID);
		
		dLimitIDs := LIMIT(dIDS(etype=BairRx_Common.EID.Type.CFS), BairRx_Common.Constants.MAX_JOIN_LIMIT);
		isCFSFid := BairRx_CFS.Sorting.isCFSFID(sort_field_id);
		isOfficerFid := BairRx_CFS.Sorting.isOfficerFID(sort_field_id);
		
		dCFSRecs := JOIN(dLimitIDs, BairRx_Common.Keys.PayloadCFSKey(delta), 
			KEYED(left.eid = right.eid),
			TRANSFORM(BairRx_CFS.Layouts.SearchPayload, 
				SELF.slim_sort 	:= LEFT.slim_sort,
				SELF.distance 	:= LEFT.distance,
				SELF.date 			:= LEFT.date,
				SELF.sort_type  := sortType,
				SELF.sort_str   := if(isCFSFid, BairRx_CFS.Sorting.svalueCFS(pickSortFID, RIGHT), ''),
				SELF.sort_num   := if(isCFSFid, BairRx_CFS.Sorting.nvalueCFS(pickSortFID, RIGHT, LEFT.distance), 0),
				SELF := RIGHT,
				SELF := LEFT,
				SELF := []
			), KEEP(1), LIMIT(0));

		dRecsOfficers := JOIN(dCFSRecs, BairRx_Common.Keys.PayloadCFSKey_Officer(delta), 
			KEYED(LEFT.eid = RIGHT.eid) AND (~isPrimaryView OR RIGHT.primary_officer_indicator),
		  TRANSFORM(BairRx_CFS.Layouts.SearchPayload, 
				SELF.sort_str := IF(isOfficerFid, BairRx_CFS.Sorting.svalueOfficer(pickSortFID, RIGHT), LEFT.sort_str),
				SELF.sort_num := IF(isOfficerFid, BairRx_CFS.Sorting.nvalueOfficer(pickSortFID, RIGHT), LEFT.sort_num),
				SELF          := RIGHT,
				SELF          := LEFT
			), LEFT OUTER, KEEP(100), LIMIT(BairRx_Common.Constants.MAX_PAYLOAD));		
			
			
		dRecs := BairRx_Common.FetchLimit(dRecsOfficers, BairRx_Common.Constants.MAX_PAYLOAD);					
		return dRecs;	
	END;			
	
	
	EXPORT ReportView(dataset(BairRx_Common.Layouts.SearchRec) dIDS, boolean include_notes, boolean delta) := FUNCTION
	
		dCalls := BairRx_CFS.Raw.GetCalls(dIDs, delta);
		dOfficers := BairRx_CFS.Raw.GetOfficers(dIDs, BairRx_Common.DataRelation.View.None, delta);
		dNotes := BairRx_Common.GetNotes(dIDs);			
				
		dRecsOfficers := PROJECT(dOfficers,
			TRANSFORM(BairRx_CFS.Layouts.PayloadOfficerWithNotes, 
				SELF.notes := IF(include_notes, dNotes(eid=LEFT.eid, referid=LEFT.cfs_officers_id, note_type=BairRx_Common.Constants.NoteType.CfsSynopsis), 
					DATASET([],BairRx_Common.Layouts.PayloadNotes)), 
				SELF := LEFT));	
				
		BairRx_CFS.Layouts.PayloadCFS xtCall(BairRx_CFS.Layouts.PayloadCFS L) := TRANSFORM
			SELF := L
		END;

		dRecs := PROJECT(dCalls,	
			TRANSFORM(BairRx_CFS.Layouts.PayloadReport,								
								SELF.data_provider_ori	:= LEFT.data_provider_ori,
								SELF.eid			:= IF(EXISTS(dCalls), LEFT.eid, SKIP),
								SELF.calls 		:= DATASET([xtCall(LEFT)]),
								SELF.officers := SORT(dRecsOfficers(eid=LEFT.eid), if(primary_officer_indicator, 0, 1)),
								SELF.notes 		:= IF(include_notes, dNotes(eid=LEFT.eid, note_type=BairRx_Common.Constants.NoteType.Dispatcher), DATASET([],BairRx_Common.Layouts.PayloadNotes)) 
								));
		
		RETURN dRecs;
	END;	
	
	
	EXPORT MapView(DATASET(BairRx_Common.Layouts.SearchRec) dIDs, unsigned1 data_relation, unsigned sort_field_id, boolean delta, boolean inc_details = false) := FUNCTION
		
		MapPayloadCFS := RECORD(BairRx_Common.Layouts.MapPayloadBase)
			BairRx_Common.Layouts.LayoutCFSCall cfs_call;
		END;
		
		pickSortFID := sort_field_id+1; 
		dLimitIDs := limit(dIDS(etype=BairRx_Common.EID.Type.CFS), BairRx_Common.Constants.MAX_PAYLOAD);
		isCFSFid := BairRx_CFS.Sorting.isCFSFID(sort_field_id);
		isOfficerFid := BairRx_CFS.Sorting.isOfficerFID(sort_field_id);

		dCFSRecs := JOIN(dLimitIDs, BairRx_Common.Keys.PayloadCFSKey(delta), 
				KEYED(left.eid = right.eid),
				TRANSFORM(MapPayloadCFS, 
					SELF.eid					:= LEFT.eid,
					SELF.gh12					:= LEFT.gh12,
					SELF.date					:= LEFT.date,
					SELF.distance 		:= LEFT.distance,
					SELF.latitude			:= (STRING) RIGHT.y_coordinate,
					SELF.longitude		:= (STRING) RIGHT.x_coordinate,			
					SELF.referenceID 	:= RIGHT.event_number,
					SELF.address 			:= stringlib.stringcleanspaces(RIGHT.address+' '+RIGHT.city),
					SELF.agency				:= RIGHT.data_provider_name,
					SELF.class_code 	:= RIGHT.initial_ucr_group,
					SELF.class 				:= (STRING) RIGHT.initial_ucr_group,
					SELF.ori					:= RIGHT.data_provider_ori,
					SELF.etype				:= BairRx_Common.Constants.SearchType.CFS,	
					SELF.stamp				:= BairRx_Common.EID.GetStamp(RIGHT.eid),
					SELF.sort_type    := BairRx_CFS.Sorting.tvalue(pickSortFID),
					SELF.sort_num     := IF(isCFSFid, BairRx_CFS.Sorting.nvalueCFS(pickSortFID, RIGHT, LEFT.distance), 0),
					SELF.sort_str     := IF(isCFSFid, BairRx_CFS.Sorting.svalueCFS(pickSortFID, RIGHT), ''),
					SELF.accuracy 		:= RIGHT.accuracy_code,
					SELF.cfs_call			:= IF(inc_details, ROW(RIGHT, BairRx_Common.Layouts.LayoutCFSCall)),
					SELF 							:= []
				), KEEP(1), LIMIT(0));					

		dCFSOfficerRecs := JOIN(dCFSRecs, BairRx_Common.Keys.PayloadCFSKey_Officer(delta), 
				KEYED(LEFT.eid = RIGHT.eid),
		    TRANSFORM(MapPayloadCFS, 
					SELF.sort_num := if(isOfficerFid, BairRx_CFS.Sorting.nvalueOfficer(pickSortFID, RIGHT), LEFT.sort_num),
					SELF.sort_str := if(isOfficerFid, BairRx_CFS.Sorting.svalueOfficer(pickSortFID, RIGHT), LEFT.sort_str),
					SELF          := LEFT
				), KEEP(1), LIMIT(BairRx_Common.Constants.MAX_JOIN_LIMIT));
														
		dMapRecs := IF(isOfficerFid, dCFSOfficerRecs, dCFSRecs);
		dRecs := BairRx_Common.FetchLimit(dMapRecs, BairRx_Common.Constants.MAX_PAYLOAD);	
		return dRecs;
	END;
	
END;	