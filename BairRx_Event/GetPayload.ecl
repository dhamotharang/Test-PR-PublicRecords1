import BairRx_Common, BairRx_Event;

EXPORT GetPayload := 
MODULE

	SHARED MAC_AppendMOUDF(dRecs, dRecsUDF, dRecsOut, isUDFMOFID) := MACRO
		dRecsOut := 
			JOIN(dRecs, dRecsUDF, LEFT.eid = RIGHT.eid AND LEFT.mostamp = RIGHT.stamp,
				TRANSFORM(recordof(dRecs),
					SELF.MoUDF1 := RIGHT.MoUDF1, 
					SELF.MoUDF2 := RIGHT.MoUDF2, 
					SELF.MoUDF3 := RIGHT.MoUDF3, 
					SELF.MoUDF4 := RIGHT.MoUDF4, 
					SELF.MoUDF5 := RIGHT.MoUDF5, 
					SELF.MoUDF6 := RIGHT.MoUDF6, 
					SELF.MoUDF7 := RIGHT.MoUDF7, 
					SELF.MoUDF8 := RIGHT.MoUDF8, 		
					SELF.sort_type := IF(isUDFMOFID, RIGHT.sort_type, LEFT.sort_type),
					SELF.sort_str  := IF(isUDFMOFID, RIGHT.sort_str, LEFT.sort_str),
					SELF.sort_num	 := IF(isUDFMOFID, RIGHT.sort_num, LEFT.sort_num),
					SELF := LEFT
				), LEFT OUTER, KEEP(1), LIMIT(0));
	ENDMACRO;

	SHARED MAC_AppendVehicle(dRecsIn, dRecsVeh, dRecsOut, matchStamp, isVehicleFID, pickFID, sortType) := MACRO
		dRecsOut := 
			JOIN(dRecsIn, dRecsVeh, LEFT.eid = RIGHT.eid AND (~matchStamp OR LEFT.mostamp = RIGHT.vehiclestamp),
				TRANSFORM(recordof(dRecsIn),
						SELF.vehiclestamp := RIGHT.vehiclestamp,
						SELF.make := RIGHT.make,
						SELF.model := RIGHT.model,
						SELF.style := RIGHT.style,
						SELF.color := RIGHT.color,
						SELF.year := RIGHT.year,
						SELf.plate := RIGHT.plate,
						SELF.type := RIGHT.type,
						SELF.vehicle_status := RIGHT.vehicle_status,
						SELF.vehicle_address := RIGHT.vehicle_address,
						SELF.plate_state := RIGHT.plate_state,
						SELF.vehicle_x_coordinate := RIGHT.vehicle_x_coordinate,
						SELF.vehicle_y_coordinate := RIGHT.vehicle_y_coordinate,
						SELF.vehicle_x_projected := RIGHT.vehicle_x_projected,
						SELF.vehicle_y_projected := RIGHT.vehicle_y_projected,
						SELF.vehicle_accuracy := RIGHT.vehicle_accuracy,
						SELF.vehicle_geocoded := RIGHT.vehicle_geocoded,
						SELF.vehicle_edit_date := RIGHT.vehicle_edit_date,
						SELF.sort_type := IF(isVehicleFID,sortType, LEFT.sort_type),
						SELF.sort_str := IF(isVehicleFID,BairRx_Event.Sorting.svalueVE(pickFID, RIGHT), LEFT.sort_str),
						SELF.sort_num	:= IF(isVehicleFID,BairRx_Event.Sorting.nvalueVE(pickFID, RIGHT), LEFT.sort_num),
						SELF := LEFT
					), LEFT OUTER, LIMIT(BairRx_Common.Constants.MAX_JOIN_LIMIT));
	ENDMACRO;
	
	SHARED MAC_AppendUDFPerson(dRecs, dRecsUDF, dRecsOut, isUDFPEFID) := MACRO
		dRecsOut := 
			JOIN(dRecs, dRecsUDF, LEFT.eid = RIGHT.eid AND LEFT.personstamp = RIGHT.stamp,
				TRANSFORM(recordof(dRecs),
					SELF.PersonUDF1 := RIGHT.PersonUDF1, 
					SELF.PersonUDF2 := RIGHT.PersonUDF2, 
					SELF.PersonUDF3 := RIGHT.PersonUDF3, 
					SELF.PersonUDF4 := RIGHT.PersonUDF4, 
					SELF.sort_type 	:= IF(isUDFPEFID, RIGHT.sort_type, LEFT.sort_type),
					SELF.sort_str  	:= IF(isUDFPEFID, RIGHT.sort_str, LEFT.sort_str),
					SELF.sort_num	 	:= IF(isUDFPEFID, RIGHT.sort_num, LEFT.sort_num),
					SELF := LEFT
				), LEFT OUTER, KEEP(1), LIMIT(0));
	ENDMACRO;	
	
	SHARED MAC_AppendPerson(dRecsIn, dRecsPer, dRecsOut, matchStamp, isPersonFID, isUDFPEFID, pickFID, sortType) := MACRO
		dRecsOut := 
			JOIN(dRecsIn, dRecsPer, LEFT.eid = RIGHT.eid AND (~matchStamp OR LEFT.mostamp = RIGHT.personstamp),
				TRANSFORM(recordof(dRecsIn),
					SELF.personstamp := RIGHT.personstamp,
					SELF.name_type   := RIGHT.name_type,
					SELF.first_name  := RIGHT.first_name,
					SELF.middle_name := RIGHT.middle_name,
					SELF.last_name := RIGHT.last_name,
					SELF.moniker := RIGHT.moniker,
					SELF.persons_address := RIGHT.persons_address,
					SELF.dob := RIGHT.dob,
					SELF.race := RIGHT.race,
					SELF.sex := RIGHT.sex,
					SELF.hair := RIGHT.hair,
					SELF.hair_length := RIGHT.hair_length,
					SELF.eyes := RIGHT.eyes,
					SELF.hand_use := RIGHT.hand_use,
					SELF.speech := RIGHT.speech,
					SELF.teeth := RIGHT.teeth,
					SELF.physical_condition := RIGHT.physical_condition,
					SELF.build := RIGHT.build,
					SELF.complexion := RIGHT.complexion,
					SELF.facial_hair := RIGHT.facial_hair,
					SELF.hat := RIGHT.hat,
					SELF.mask := RIGHT.mask,
					SELF.glasses := RIGHT.glasses,
					SELF.appearance := RIGHT.appearance,
					SELF.shirt := RIGHT.shirt,
					SELF.pants := RIGHT.pants,
					SELF.shoes := RIGHT.shoes,
					SELF.jacket := RIGHT.jacket,
					SELF.soundex := RIGHT.soundex,
					SELF.weight_1 := RIGHT.weight_1,
					SELF.weight_2 := RIGHT.weight_2,
					SELF.height_1 := RIGHT.height_1,
					SELF.height_2 := RIGHT.height_2,
					SELF.age_1 := RIGHT.age_1,
					SELF.age_2 := RIGHT.age_2,
					SELF.persons_sid := RIGHT.persons_sid,
					SELF.facial_recognition := RIGHT.facial_recognition,
					SELF.PersonUDF1 := RIGHT.PersonUDF1, 
					SELF.PersonUDF2 := RIGHT.PersonUDF2, 
					SELF.PersonUDF3 := RIGHT.PersonUDF3, 
					SELF.PersonUDF4 := RIGHT.PersonUDF4,
					SELF.persons_x_coordinate := RIGHT.persons_x_coordinate,
					SELF.persons_y_coordinate := RIGHT.persons_y_coordinate,
					SELF.persons_x_projected := RIGHT.persons_x_projected,
					SELF.persons_y_projected := RIGHT.persons_y_projected,
					SELF.persons_accuracy := RIGHT.persons_accuracy,
					SELF.persons_geocoded := RIGHT.persons_geocoded,
					SELF.persons_edit_date := RIGHT.persons_edit_date,
					SELF.sort_type := IF(isPersonFID, sortType, IF(isUDFPEFID, RIGHT.sort_type, LEFT.sort_type)), 
					SELF.sort_str := IF(isPersonFID, BairRx_Event.Sorting.svaluePE(pickFID, RIGHT), IF(isUDFPEFID, RIGHT.sort_str, LEFT.sort_str)),
					SELF.sort_num	:= IF(isPersonFID, BairRx_Event.Sorting.nvaluePE(pickFID, RIGHT), IF(isUDFPEFID, RIGHT.sort_num, LEFT.sort_num)),
					SELF := LEFT
					), LEFT OUTER, LIMIT(BairRx_Common.Constants.MAX_JOIN_LIMIT));
	ENDMACRO;

	EXPORT SearchView(DATASET(BairRx_Common.Layouts.SearchRec) dIDs, unsigned1 data_relation, unsigned sort_field_id, unsigned4 DPID, boolean delta = false) := FUNCTION
	
		/*
			The returned dataset varies depending on the type of view (data_relation) the user is selecting.

			Primary View
			Match only against primary records (mo stamp=0). Append vehicle and person with a matching stamp (mo stamp = vehicle stamp = person stamp = 0)

			Secondary View
			Match against the entire case (all MO stamps), but only return a single MO record.
			Note: In case of multiple matches for a single case (i.e. multiple EIDs with different stamps), we want to pick the match with the lowest stamp. 
				
			Relational View
			Match against entire case (all MO stamps), return all MOs. Append ALL vehicles and ALL person to each MO record.

			All view
			Match against entire case, return all matching MOs. Only append vehicle and/or persons with a matching stamp (mo stamp = vehicle stamp = person stamp)
		*/			
		dSortIDs := SORT(dIDs(etype=BairRx_Common.EID.Type.EVE), eid, stamp);
		ddIDs := DEDUP(dSortIDs, eid, stamp); // same EID may have multiple stamps, depending on data relation
		dEIDs := DEDUP(dSortIDs, eid); 
	
		isPrimaryView := BairRx_Common.DataRelation.IsPrimaryView(data_relation);
		isSecondaryView := BairRx_Common.DataRelation.IsSecondaryView(data_relation);		
		isRelationalView := BairRx_Common.DataRelation.IsRelationalView(data_relation);	
		isAllView := BairRx_Common.DataRelation.IsAllView(data_relation);	
	
		// Below I'm trying to fetch only the records really needed, based on the view selected.
		// Might be a good idea to revisit this code at some point and make it more straightforward.
		
		// These are the calls needed to fetch MO records
		// dMos 	:= BairRx_Event.Raw.GetMOs(dEIDs, false, delta);	// primary - single eid, stamp 0
		// dMos 	:= BairRx_Event.Raw.GetMOs(dEIDs, false, delta);	// secondary - single eid, any stamp
		// dMos 	:= BairRx_Event.Raw.GetMOs(dEIDs, true, delta);		// relational - all MOs associated with the EID
		// dMos 	:= BairRx_Event.Raw.GetMOs(ddIDs, false, delta);	// all view - any eid, any stamp		
		// And this is the combination of the 4 calls above using a different set of ids and fetch flags, depending on the view.
		dMOIDs := IF(isAllView, ddIDs, dEIDs); 		
		dMos 	:= BairRx_Event.Raw.GetMOs(dMOIDs, isRelationalView, delta);
				
		dVehicles := BairRx_Event.Raw.GetVehicles(dMOIDs, isRelationalView, delta);		
		dPersons 	:= BairRx_Event.Raw.GetPersons(dMOIDs, isRelationalView, delta);			
		
		isMOFID 		:= BairRx_Event.Sorting.IsMOFID(sort_field_id);	
		isPEFID 		:= BairRx_Event.Sorting.IsPersonFID(sort_field_id);	
		isVEFID 		:= BairRx_Event.Sorting.IsVehicleFID(sort_field_id);			
		isUDFMOFID 	:= BairRx_Event.Sorting.IsUDFMOFID(sort_field_id);	
		isUDFPEFID 	:= BairRx_Event.Sorting.IsUDFPersonFID(sort_field_id);	
		pickSortFID := sort_field_id+1; 
		sortType		:= BairRx_Event.Sorting.tvalue(pickSortFID);				
		
		dMOUDFs := BairRx_Event.Raw.GetMOUDFs(dMos, DPID, delta, isUDFMOFID, pickSortFID);		
		dPersonUDFs := BairRx_Event.Raw.GetPersonUDFs(dPersons, DPID, delta, isUDFPEFID, pickSortFID);
		
		dRecs_MO := JOIN(dEIDs, dMos, LEFT.eid = RIGHT.eid,
			TRANSFORM(BairRx_Event.Layouts.SearchPayload,
				SELF.slim_sort 	:= LEFT.slim_sort,
				SELF.distance 	:= LEFT.distance,
				SELF.date 			:= LEFT.date,
				SELF.sort_type 	:= IF(isMOFID, sortType, 0),
				SELF.sort_str  	:= IF(isMOFID, BairRx_Event.Sorting.svalueMO(pickSortFID, RIGHT), ''),
				SELF.sort_num	 	:= IF(isMOFID, BairRx_Event.Sorting.nvalueMO(pickSortFID, RIGHT, LEFT.distance), 0),
				SELF := RIGHT,
				SELF := []
				), LIMIT(0));
				
		MAC_AppendMOUDF(dRecs_MO, dMOUDFs, dRecs_MO_UDF, isUDFMOFID);
		MAC_AppendVehicle(dRecs_MO_UDF, dVehicles, dRecs_MO_Vehicle, isAllView, isVEFID, pickSortFID, sortType);
		MAC_AppendUDFPerson(dPersons, dPersonUDFs, dRecs_Person_UDF, isUDFPEFID);
		MAC_AppendPerson(dRecs_MO_Vehicle, dRecs_Person_UDF, dRecs_MO_Vehicle_Person, isAllView, isPEFID, isUDFPEFID, pickSortFID, sortType);
		
		RETURN dRecs_MO_Vehicle_Person;		
	END;
	
	
	EXPORT SlimSearchView(DATASET(BairRx_Common.Layouts.SearchRec) dIDs, unsigned sort_field_id, boolean delta = false) := FUNCTION
	
		dEIDs := DEDUP(SORT(dIDs(etype=BairRx_Common.EID.Type.EVE), eid, stamp), eid); 			
		dMos := BairRx_Event.Raw.GetMOs(dEIDs, FALSE, delta);
		isMOFID := BairRx_Event.Sorting.IsMOFID(sort_field_id);	
		pickSortFID := sort_field_id+1; 
		sortType := BairRx_Event.Sorting.tvalue(pickSortFID);			

		dRecs_MO := JOIN(dEIDs, dMos, 
			LEFT.eid = RIGHT.eid,
			TRANSFORM(BairRx_Event.Layouts.SlimSearchPayload,
				SELF.slim_sort 	:= LEFT.slim_sort,
				SELF.distance 	:= LEFT.distance,
				SELF.date 			:= LEFT.date,
				SELF.sort_type 	:= IF(isMOFID, sortType, 0),
				SELF.sort_str  	:= IF(isMOFID, BairRx_Event.Sorting.svalueMO(pickSortFID, RIGHT), ''),
				SELF.sort_num	 	:= IF(isMOFID, BairRx_Event.Sorting.nvalueMO(pickSortFID, RIGHT, LEFT.distance),0),
				SELF.raids_ok		:= RIGHT.raids = '1' AND RIGHT.le_only = '0', // raids restriction based on same 2 flags used when setting 'raids' flag in geohash key
				SELF := RIGHT,
				SELF := []
				), LIMIT(0));
				
		RETURN dRecs_MO;		
	END;
	
	EXPORT ReportView(DATASET(BairRx_Common.Layouts.SearchRec) dIDs, boolean include_notes, unsigned4 DPID, boolean fetch_delta) := FUNCTION
	
		dMos 			:= BairRx_Event.Raw.GetMOs(dIDs,TRUE, fetch_delta);		
		dMOUDFs 	:= BairRx_Event.Raw.GetMOUDFs(dMos, DPID, fetch_delta);			
		dVehicles := BairRx_Event.Raw.GetVehicles(dIDs, TRUE, fetch_delta);		
		dPersons 	:= BairRx_Event.Raw.GetPersons(dIDs, TRUE, fetch_delta);				
		dPersonUDFs := BairRx_Event.Raw.GetPersonUDFs(dPersons, DPID, fetch_delta);
		dNotes 		:= IF(include_notes, BairRx_Event.Raw.GetNotes(dIDs), DATASET([], BairRx_Common.Layouts.PayloadNotes));			
		
		MAC_AppendMOUDF(dMos, dMOUDFs, dMO_UDF, FALSE);		
		MAC_AppendUDFPerson(dPersons, dPersonUDFs, dPerson_UDF, FALSE);	
		
		dMO_UDF_Notes := JOIN(dMO_UDF, dNotes(note_type=BairRx_Common.Constants.NoteType.EventSynopsis), 
			LEFT.eid = right.eid AND LEFT.mostamp = RIGHT.referid,
			TRANSFORM(BairRx_Event.Layouts.PayloadMOWithNotes, SELF.Notes := RIGHT.Notes, SELF := LEFT),
			LEFT OUTER, KEEP(1), LIMIT(0));
		
		dMO_UDF_Notes_Sort := SORT(dMO_UDF_Notes,eid,mostamp);
		
		dPerson_UDF_Notes := JOIN(dPerson_UDF, dNotes(note_type=BairRx_Common.Constants.NoteType.Persons), 
			LEFT.eid = right.eid AND LEFT.personstamp = RIGHT.referid,
			TRANSFORM(BairRx_Event.Layouts.PayloadPersonWithNotes, SELF.Notes := RIGHT.Notes, SELF := LEFT),
			LEFT OUTER, KEEP(1), LIMIT(0));
		
		dVehicle_Notes := JOIN(dVehicles, dNotes(note_type=BairRx_Common.Constants.NoteType.Vehicles), 
			LEFT.eid = right.eid AND LEFT.vehiclestamp = RIGHT.referid,
			TRANSFORM(BairRx_Event.Layouts.PayloadVehicleWithNotes, SELF.Notes := RIGHT.Notes, SELF := LEFT),
			LEFT OUTER, KEEP(1), LIMIT(0));
		
		dPayloadRecs := JOIN(dIDs, dMos, LEFT.eid = RIGHT.eid,
			TRANSFORM(BairRx_Event.Layouts.ReportPayload,
				SELF.data_provider_ori := RIGHT.data_provider_ori,
				SELF.eid			:= LEFT.eid,
				SELF.mos 			:= dMO_UDF_Notes_Sort(eid=LEFT.eid),
				SELF.persons 	:= dPerson_UDF_Notes(eid=LEFT.eid),
				SELF.vehicles := dVehicle_Notes(eid=LEFT.eid)
			), KEEP(1), LIMIT(0));
				
		RETURN dPayloadRecs;		
	END;
	
	EXPORT MapView(DATASET(BairRx_Common.Layouts.SearchRec) dIDs, unsigned1 data_relation, unsigned sort_field_id, unsigned4 DPID, boolean delta, boolean isRaids = false, boolean inc_details = false) := FUNCTION
	
		pickSortFID := sort_field_id+1; 
		sortType		:= BairRx_Event.Sorting.tvalue(pickSortFID);		
		isMOFID 		:= BairRx_Event.Sorting.IsMOFID(sort_field_id);	
		isPEFID 		:= BairRx_Event.Sorting.IsPersonFID(sort_field_id);	
		isVEFID 		:= BairRx_Event.Sorting.IsVehicleFID(sort_field_id);		
		isUDFMOFID 	:= BairRx_Event.Sorting.IsUDFMOFID(sort_field_id);	
		isUDFPEFID 	:= BairRx_Event.Sorting.IsUDFPersonFID(sort_field_id);	
		
		MapPayloadEvent := RECORD(BairRx_Common.Layouts.MapPayloadBase)
			BairRx_Common.Layouts.LayoutEventMO event_MO;
		END;			
		
		dLimitIDs := LIMIT(dIDs(etype=BairRx_Common.EID.Type.EVE), BairRx_Common.Constants.MAX_PAYLOAD);		
		
		dMORecs := JOIN(dLimitIDs, BairRx_Common.Keys.PayloadMOKey(delta), 
				KEYED(left.eid = right.eid) AND (LEFT.stamp = (integer)RIGHT.mostamp),
				TRANSFORM(MapPayloadEvent, 
					SELF.eid					:= LEFT.eid,
					SELF.gh12					:= LEFT.gh12,
					SELF.date					:= LEFT.date,
					SELF.distance 		:= LEFT.distance,
					SELF.latitude			:= (STRING) IF(isRaids, RIGHT.y_coordinate + RIGHT.y_offset,RIGHT.y_coordinate),
					SELF.longitude		:= (STRING) IF(isRaids, RIGHT.x_coordinate + RIGHT.x_offset,RIGHT.x_coordinate),
					SELF.referenceID 	:= RIGHT.IR_Number,
					SELF.address 			:= IF(isRaids,RIGHT.public_address,RIGHT.address_of_crime),
					SELF.agency				:= RIGHT.data_provider_name,
					SELF.class_code 	:= RIGHT.ucr_group,
					SELF.class 				:= (STRING) RIGHT.ucr_group,
					SELF.ori					:= RIGHT.data_provider_ori,	
					SELF.etype				:= BairRx_Common.Constants.SearchType.Event,
					SELF.stamp				:= BairRx_Common.EID.GetStamp(RIGHT.eid),
					SELF.sort_type 		:= IF(isMOFID, sortType, 0),
					SELF.sort_str  		:= IF(isMOFID, BairRx_Event.Sorting.svalueMO(pickSortFID, RIGHT),''),
					SELF.sort_num	 		:= IF(isMOFID, BairRx_Event.Sorting.nvalueMO(pickSortFID, RIGHT, LEFT.distance),0),
					SELF.accuracy 		:= RIGHT.accuracy_code,
					SELF.event_MO			:= IF(inc_details, ROW(RIGHT, BairRx_Common.Layouts.LayoutEventMO)),
					SELF 							:= []
					), KEEP(1), LIMIT(0));				
				
		// pick up sorting field value from mo udf key if needed.		
		dRecsMOUDF := IF(~isUDFMOFID, dMORecs,
				JOIN(dMORecs, BairRx_Common.Keys.PayloadMOUDFKey(delta),
				KEYED(DPID>0 AND LEFT.eid = RIGHT.eid AND RIGHT.data_provider_id = DPID AND LEFT.stamp = RIGHT.stamp),
				TRANSFORM(MapPayloadEvent,
					udf_type := BairRx_Event.Sorting.tvalueMOUDF(pickSortFID, RIGHT);
					SELF.sort_type 		:= udf_type,
					SELF.sort_str  		:= BairRx_Event.Sorting.svalueMOUDF(pickSortFID, udf_type, RIGHT),
					SELF.sort_num	 		:= BairRx_Event.Sorting.nvalueMOUDF(pickSortFID, udf_type, RIGHT),
					SELF							:= LEFT),
				LEFT OUTER, KEEP(1), LIMIT(0))
				);	
		
		// pick up sorting field value from person key if needed.
		dRecsPE := IF(~isPEFID, dRecsMOUDF,
				JOIN(dMORecs,BairRx_Common.Keys.PayloadPersonKey(delta), 
				KEYED(LEFT.eid = RIGHT.EID) AND LEFT.stamp = (integer) RIGHT.personstamp,
				TRANSFORM(MapPayloadEvent, 
						SELF.sort_type 		:= IF(isPEFID, sortType, LEFT.sort_type),
						SELF.sort_str  		:= IF(isPEFID, BairRx_Event.Sorting.svaluePE(pickSortFID, RIGHT), LEFT.sort_str),
						SELF.sort_num	 		:= IF(isPEFID, BairRx_Event.Sorting.nvaluePE(pickSortFID, RIGHT), LEFT.sort_num),
						SELF := LEFT),
				LEFT OUTER, KEEP(1), LIMIT(0))
				);		
		
		// pick up sorting field value from person udf key if needed.		
		dRecsPEUDF := IF(~isUDFMOFID, dRecsPE,
				JOIN(dMORecs, BairRx_Common.Keys.PayloadPersonUDFKey(delta),
				KEYED(DPID>0 AND LEFT.eid = RIGHT.eid AND RIGHT.data_provider_id = DPID AND LEFT.stamp = RIGHT.stamp),
				TRANSFORM(MapPayloadEvent, 
					udf_type := BairRx_Event.Sorting.tvaluePersonUDF(pickSortFID, RIGHT);
					SELF.sort_type 		:= udf_type,
					SELF.sort_str  		:= BairRx_Event.Sorting.svaluePersonUDF(pickSortFID, udf_type, RIGHT),
					SELF.sort_num	 		:= BairRx_Event.Sorting.nvaluePersonUDF(pickSortFID, udf_type, RIGHT),
					SELF							:= LEFT),
				LEFT OUTER, KEEP(1), LIMIT(0))
				);					
		
		// pick up sorting field value from vehicle key if needed.
		dMORecsV := IF(~isVEFID, dRecsPEUDF,
				JOIN(dMORecs, BairRx_Common.Keys.PayloadVehicleKey(delta), 
				KEYED(LEFT.eid = RIGHT.EID) AND LEFT.stamp = (integer) RIGHT.vehiclestamp,
				TRANSFORM(MapPayloadEvent, 
						SELF.sort_type 		:= IF(isVEFID, sortType, LEFT.sort_type),
						SELF.sort_str  		:= IF(isVEFID, BairRx_Event.Sorting.svalueVE(pickSortFID, RIGHT), LEFT.sort_str),
						SELF.sort_num	 		:= IF(isVEFID, BairRx_Event.Sorting.nvalueVE(pickSortFID, RIGHT), LEFT.sort_num),
						SELF := LEFT),
				LEFT OUTER, KEEP(1), LIMIT(0))
				);
		
		return dMORecsV;
	END;

END;