IMPORT BairRx_Common,BairRx_Crash;

EXPORT GetPayload := MODULE

	SHARED AppendIncidents(dRecsIn, dRecsInc, isIncidentFID, pickFID) := FUNCTIONMACRO
		dRecs := JOIN(dRecsIn, dRecsInc, left.eid = right.eid, 
			TRANSFORM(BairRx_Crash.Layouts.SearchPayload, 
				SELF.slim_sort 	:= LEFT.slim_sort,
				SELF.distance 	:= LEFT.distance,
				SELF.date 			:= LEFT.date,
				SELF.sort_type 	:= BairRx_Crash.Sorting.tvalue(pickFID),
				SELF.sort_str  	:= IF(isIncidentFID, BairRx_Crash.Sorting.svalueCRA(pickFID, RIGHT), ''),
				SELF.sort_num	 	:= IF(isIncidentFID, BairRx_Crash.Sorting.nvalueCRA(pickFID, RIGHT, LEFT.distance), 0),
				SELF := RIGHT,
				SELF := LEFT,
				SELF := []
			), KEEP(1), LIMIT(0));
		RETURN dRecs;
	ENDMACRO;

	SHARED AppendVehicles(dRecsIn, dRecsVeh, isVehicleFID, pickFID) := FUNCTIONMACRO
		dRecs := 
			JOIN(dRecsIn, dRecsVeh, LEFT.eid = RIGHT.eid,
				TRANSFORM(BairRx_Crash.Layouts.SearchPayload,
						SELF.vehicleid := RIGHT.vehicleid,
						SELF.vin := RIGHT.vin,
						SELF.plate := RIGHT.plate,
						SELF.platestate := RIGHT.platestate,
						SELF.year := RIGHT.year,
						SELf.make := RIGHT.make,
						SELF.vehicle_type := RIGHT.vehicle_type,
						SELF.model := RIGHT.model,
						SELF.towed := RIGHT.towed,
						SELF.damage := RIGHT.damage,
						SELF.sequence := RIGHT.sequence,
						SELF.action := RIGHT.action,
						SELF.driverimpairment := RIGHT.driverimpairment,
						SELF.sort_type 	:= IF(isVehicleFID, BairRx_Crash.Sorting.tvalue(pickFID), LEFT.sort_type),
						SELF.sort_str  	:= IF(isVehicleFID, BairRx_Crash.Sorting.svalueVE(pickFID, RIGHT), LEFT.sort_str),
						SELF.sort_num	 	:= IF(isVehicleFID, BairRx_Crash.Sorting.nvalueVE(pickFID, RIGHT), LEFT.sort_num),
						SELF := LEFT
					), LEFT OUTER, LIMIT(0));
		RETURN dRecs;
	ENDMACRO;
	
	SHARED AppendPersons(dRecsIn, dRecsPer, isPersonFID, pickFID, data_relation) := FUNCTIONMACRO
	  dRecs := 
		  // Modified join condition to include person records with a vehicle id of 0 for the primary view.
			// This is being done to match the SQL atacraids.
			JOIN(dRecsIn, dRecsPer, LEFT.eid = RIGHT.eid AND 
															(LEFT.vehicleid = RIGHT.personvehicleid OR 
															(RIGHT.personvehicleid = 0 AND BairRx_Common.DataRelation.IsPrimaryView(data_relation))),
				TRANSFORM(BairRx_Crash.Layouts.SearchPayload,
						SELF.driver := RIGHT.driver,
						SELF.first_name := RIGHT.first_name,
						SELF.last_name := RIGHT.last_name,
						SELF.personvehicleid := RIGHT.personvehicleid,
						SELF.licensenumber := RIGHT.licensenumber,
						SELF.licensestate := RIGHT.licensestate,
						SELF.race := RIGHT.race,
						SELF.sex := RIGHT.sex,
						SELF.city := RIGHT.city,
						SELF.state := RIGHT.state,
						SELF.age := RIGHT.age,
						SELF.driveractions := RIGHT.driveractions,
						SELF.airbag := RIGHT.airbag,
						SELF.seatbelt := RIGHT.seatbelt,
						SELF.personid := RIGHT.personid,
						SELF.sort_type 	:= IF(isPersonFID, BairRx_Crash.Sorting.tvalue(pickFID), LEFT.sort_type),
						SELF.sort_str  	:= IF(isPersonFID, BairRx_Crash.Sorting.svaluePE(pickFID, RIGHT), LEFT.sort_str),
						SELF.sort_num	 	:= IF(isPersonFID, BairRx_Crash.Sorting.nvaluePE(pickFID, RIGHT), LEFT.sort_num),
						SELF := LEFT
					), LEFT OUTER, LIMIT(0));
		RETURN dRecs;
	ENDMACRO;

	EXPORT SearchView(DATASET(BairRx_Common.Layouts.SearchRec) dIDs, unsigned1 data_relation = BairRx_Common.DataRelation.View.None, unsigned sort_field_id = 0, boolean delta = false) := FUNCTION

		pickSortFID 	:= sort_field_id+1;		
		isIncidentFID := BairRx_Crash.Sorting.IsIncidentFID(sort_field_id);
		isVehicleFID 	:= BairRx_Crash.Sorting.IsVehicleFID(sort_field_id);
		isPersonFID 	:= BairRx_Crash.Sorting.IsPersonFID(sort_field_id);
				
		dRaw				:= BairRx_Crash.Raw.GetIncidents(dIDs, delta);
		dIncidents 	:= DEDUP(SORT(dRaw, eid), eid);
		dVehicles 	:= BairRx_Crash.Raw.GetVehicles(dIDs, delta);
		dPersons 		:= BairRx_Crash.Raw.GetPersons(dIDs, delta);
		dVehiclesPrimary 	:= BairRx_Crash.Raw.GetVehiclesPrimary(dIDs, delta);
		dPersonsPrimary 	:= BairRx_Crash.Raw.GetPersonsPrimary(dIDs, delta);
	
		dVehicleRecs := IF(BairRx_Common.DataRelation.IsPrimaryView(data_relation), dVehiclesPrimary, dVehicles);
		dPersonRecs := IF(BairRx_Common.DataRelation.IsPrimaryView(data_relation), dPersonsPrimary, dPersons);

		dRecs_I		:= AppendIncidents(dIDs, dIncidents, isIncidentFID, pickSortFID);
		dRecs_IV 	:= AppendVehicles(dRecs_I, dVehicleRecs, isVehicleFID, pickSortFID);
		dRecs_IVP := AppendPersons(dRecs_IV, dPersonRecs, isPersonFID, pickSortFID, data_relation);

		return dRecs_IVP;		
			
	END;		
	
	EXPORT ReportView(DATASET(BairRx_Common.Layouts.SearchRec) dIDS, boolean include_notes, boolean delta) := FUNCTION
		
		dRawRecs				:= BairRx_Crash.Raw.GetIncidents(dIDs, delta);
		dIncidentRecs 	:= DEDUP(SORT(dRawRecs, eid), eid);
		dVehiclesRecs 	:= BairRx_Crash.Raw.GetVehicles(dIDs, delta);
		dPersonsRecs 		:= BairRx_Crash.Raw.GetPersons(dIDs, delta);
		dNotes 					:= IF(include_notes, BairRx_Common.GetNotes(dIDs), DATASET([], BairRx_Common.Layouts.PayloadNotes));			
		
		dIncidents 	:= PROJECT(dIncidentRecs, TRANSFORM(BairRx_Crash.Layouts.PayloadIncident, SELF := LEFT, SELF := []));
		dVehicles 	:= PROJECT(dVehiclesRecs, TRANSFORM(BairRx_Crash.Layouts.PayloadVehicle, SELF := LEFT, SELF := []));
		dPersons 		:= PROJECT(dPersonsRecs, TRANSFORM(BairRx_Crash.Layouts.PayloadPerson, SELF := LEFT, SELF := []));
		
		dRptRecs := PROJECT(dIncidentRecs, TRANSFORM(BairRx_Crash.Layouts.PayloadReport,
									SELF.Incidents := dIncidents(eid = LEFT.eid),
									SELF.Vehicles := dVehicles(eid = LEFT.eid),
									SELF.Persons := dPersons(eid = LEFT.eid),
									SELF.Notes := dNotes(eid=LEFT.eid),			
									SELF := LEFT));
		
		RETURN dRptRecs;
	END;			
	
	EXPORT MapView(DATASET(BairRx_Common.Layouts.SearchRec) dIDs, unsigned1 data_relation, unsigned sort_field_id, boolean delta, boolean inc_details = FALSE) := FUNCTION
	
		MapPayloadCrash := RECORD(BairRx_Common.Layouts.MapPayloadBase)
			BairRx_Common.Layouts.LayoutCrashIncident crash_incident;
		END;			
	
		pickSortFID := sort_field_id+1;
		sortType		:= BairRx_Crash.Sorting.tvalue(pickSortFID);
		isIncidentFID := BairRx_Crash.Sorting.IsIncidentFID(sort_field_id);
		isVehicleFID 	:= BairRx_Crash.Sorting.IsVehicleFID(sort_field_id);
		isPersonFID 	:= BairRx_Crash.Sorting.IsPersonFID(sort_field_id);
		
		dRecsCRA := JOIN(dIDS(etype=BairRx_Common.EID.Type.CRA), BairRx_Common.Keys.PayloadCrashKey(delta), 
			keyed(left.eid = right.eid), 
			TRANSFORM(MapPayloadCrash, 
				SELF.eid					:= LEFT.eid,
				SELF.gh12					:= LEFT.gh12,
				SELF.date					:= LEFT.date,
				SELF.distance 		:= LEFT.distance,
				SELF.latitude			:= (STRING) RIGHT.y,
				SELF.longitude		:= (STRING) RIGHT.x,			
				SELF.referenceID 	:= RIGHT.case_number,
				SELF.address 			:= stringlib.stringcleanspaces(RIGHT.address+' '+RIGHT.crash_city+' '+RIGHT.crash_state),
				SELF.class_code 	:= BairRx_Common.ClassificationCode.MapClassCodeOut(BairRx_Common.EID.Type.CRA, RIGHT.crashType),
				SELF.class 				:= RIGHT.crashType,
				SELF.agency				:= RIGHT.data_provider_name,
				SELF.ori					:= RIGHT.data_provider_ori,		
				SELF.etype				:= BairRx_Common.Constants.SearchType.Crash,
				SELF.stamp				:= BairRx_Common.EID.GetStamp(RIGHT.eid),
				SELF.sort_type 		:= sortType,
				SELF.sort_str  		:= IF(IsIncidentFID,BairRx_Crash.Sorting.svalueCRA(pickSortFID, RIGHT),''),
				SELF.sort_num	 		:= IF(IsIncidentFID,BairRx_Crash.Sorting.nvalueCRA(pickSortFID, RIGHT, LEFT.distance),0),
				SELF.accuracy 		:= BairRx_Common.Constants.ACCURACY_ADDRESS_CODE; // hard coded to address for all crash records (same as in ATACRaids)
				SELF.crash_incident	:= IF(inc_details, ROW(RIGHT, BairRx_Common.Layouts.LayoutCrashIncident)),
				SELF 							:= []
			), KEEP(1), LIMIT(0));
	
		// pick up sorting field value from person key if needed.
		dRecsPE := IF(~isPersonFID, dRecsCRA,
				JOIN(dRecsCRA,BairRx_Common.Keys.PayloadCrashPersonKey(delta), 
				KEYED(LEFT.eid = RIGHT.EID),
				TRANSFORM(MapPayloadCrash, 
						SELF.sort_type 		:= IF(isPersonFID, sortType, LEFT.sort_type),
						SELF.sort_str  		:= IF(isPersonFID, BairRx_Crash.Sorting.svaluePE(pickSortFID, RIGHT), LEFT.sort_str),
						SELF.sort_num	 		:= IF(isPersonFID, BairRx_Crash.Sorting.nvaluePE(pickSortFID, RIGHT), LEFT.sort_num),
						SELF := LEFT),
				LEFT OUTER, KEEP(1), LIMIT(0))
				);	
		
			// pick up sorting field value from vehicle key if needed.
		dRecsVE := IF(~isVehicleFID, dRecsPE,
				JOIN(dRecsPE, BairRx_Common.Keys.PayloadCrashVehicleKey(delta), 
				KEYED(LEFT.eid = RIGHT.EID),
				TRANSFORM(MapPayloadCrash, 
						SELF.sort_type 		:= IF(isVehicleFID, sortType, LEFT.sort_type),
						SELF.sort_str  		:= IF(isVehicleFID, BairRx_Crash.Sorting.svalueVE(pickSortFID, RIGHT), LEFT.sort_str),
						SELF.sort_num	 		:= IF(isVehicleFID, BairRx_Crash.Sorting.nvalueVE(pickSortFID, RIGHT), LEFT.sort_num),
						SELF := LEFT),
				LEFT OUTER, KEEP(1), LIMIT(0))
				);
		dRecs := BairRx_Common.FetchLimit(dRecsVE, BairRx_Common.Constants.MAX_PAYLOAD);	
		RETURN dRecs;
			
	END;
		
		
END;	
	