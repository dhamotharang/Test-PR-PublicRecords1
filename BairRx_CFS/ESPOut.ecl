import BairRx_Common, iesp;

EXPORT ESPOut := MODULE

	EXPORT iesp.bair_cfs.t_BAIRCfsSearchRecord SearchView(BairRx_CFS.Layouts.SearchPayload L) := TRANSFORM
		SELF.EntityID := L.eid,
		SELF.UCRGroup := (string) L.final_ucr_group,
		SELF.Class := (string) L.final_ucr_group,
		SELF.InitialUCR := (string) L.initial_ucr_group,
		SELF.FinalUCR := (string) L.final_ucr_group,
		SELF.EventNumber := L.event_number,
		SELF.InitialType := L.initial_type,
		SELF.FinalType := L.final_type,
		SELF.LocationType := L.location_type,
		SELF.PlaceName := L.place_name,
		SELF.HowReceived := L.how_received,
		SELF.DateTimeReceived := (string) L.date_time_received,
		SELF.TotalMinutesOnCall := (string) L.total_minutes_on_call,
		SELF.CallerAddress := L.caller_address,
		SELF.EventAddress := L.address,
		SELF.Accuracy := L.accuracy,
		SELF.Agency :=  L.data_provider_name,
		SELF.ORI :=  (STRING) L.data_provider_ori,
		SELF.District := L.district,
		SELF.Beat := L.beat,
		SELF.ReportingDistrict := L.rd, 
		SELF.DateTimeArchived := L.date_time_archived,
		SELF.IncidentCode := L.incident_code,
		SELF.IncidentProgress := L.incident_progress,
		SELF.City := L.city,
		SELF.CallTaker := L.call_taker,
		SELF.ContactingOfficer := L.contacting_officer,
		SELF.Complainant := L.complainant,
		SELF.CurrentPhone := L.current_phone,
		SELF.ComplainantAddress := L.complainant_address,
		SELF.Status := L.status,
		SELF.ApartmentNumber := L.apartment_number,
		SELF.ComplainantXCoordinate := (string) L.complainant_x_coordinate,
		SELF.ComplainantYCoordinate := (string) L.complainant_y_coordinate,
		SELF.Unit := L.unit,
		SELF.OfficerName := L.officer_name,
		SELF.PrimaryOfficer := L.primary_officer,
		SELF.DateTimeDispatched := (string) L.date_time_dispatched,
		SELF.DateTimeEnroute := (string) L.date_time_enroute,
		SELF.DateTimeArrival := (string) L.date_time_arrived,
		SELF.DateTimeCleared := (string) L.date_time_cleared,
		SELF.MinutesOnCall := (string) L.minutes_on_call,
		SELF.MinutesResponse := (string) L.minutes_response,
		SELF.XCoordinate := (string) L.x_coordinate,
		SELF.YCoordinate := (string) L.y_coordinate,
		SELF.GeoCoded := L.geocoded,
		SELF.Disposition := L.disposition,
		SELF.Priority := L.priority1,
		SELF.ReportNumber := L.report_number,
		self.ComplainantAddressClean:=[],
		self.CallerAddressClean:=[],
		self.eventAddressClean:=[]
	END;
	
	SHARED iesp.bair_cfs.t_BAIRCfsCallReportRecord xtCFSCall(BairRx_CFS.Layouts.PayloadCFS L) := TRANSFORM	
		SELF.InitialUCR := (string) L.initial_ucr_group,
		SELF.FinalUCR := (string) L.final_ucr_group,
		SELF.EventNumber := L.event_number,
		SELF.InitialType := L.initial_type,
		SELF.FinalType := L.final_type,
		SELF.HowReceived := L.how_received,
		SELF.DateTimeReceived := L.date_time_received,
		SELF.TotalMinutesOnCall := (string) L.total_minutes_on_call,
		SELF.EventAddress := L.address,		
		SELF.Accuracy := L.accuracy,
		SELF.Agency := L.data_provider_name,
		SELF.District := L.district,
		SELF.Beat := L.beat,
		SELF.ReportingDistrict := L.rd,
		SELF.XCoordinate := (string) L.x_coordinate,
		SELF.YCoordinate := (string) L.y_coordinate,
		SELF.DateTimeArchived := L.date_time_archived,
		SELF.City := L.city,
		SELF.CallTaker := L.call_taker,
		SELF.ContactingOfficer := L.contacting_officer,
		SELF.Status := L.status,
		SELF.ApartmentNumber := L.apartment_number,
		SELF.PlaceName := L.place_name,
		SELF.IncidentCode := L.incident_code,
		SELF.IncidentProgress := L.incident_progress,
		SELF.Complainant := L.complainant,
		SELF.ComplainantAddress := L.complainant_address,
		SELF.ReportNumber := L.report_number,
		SELF.ComplainantXCoordinate := (string) L.complainant_x_coordinate,
		SELF.ComplainantYCoordinate := (string) L.complainant_y_coordinate,
		SELF.GeoCoded := L.geocoded,
		SELF.calleraddress := L.caller_address,
		SELF.CurrentPhone	:=	L.current_phone,
		SELF.disposition	:=	L.disposition,
		SELF.priority	:=	L.priority1,
		SELF.ORI	:=	(STRING) L.data_provider_ori,  
		SELF.LocationType := L.location_type,
		self.ComplainantAddressClean:=[],
		self.CallerAddressClean:=[],
		self.eventAddressClean:=[]
	END;
	
	SHARED iesp.bair_cfs.t_BAIRCfsOfficerRecord xtCFSOfficer(BairRx_CFS.Layouts.PayloadOfficerWithNotes L) := TRANSFORM	
		SELF.Unit := L.unit,
		SELF.OfficerName := L.officer_name,
		SELF.PrimaryOfficer := L.primary_officer,
		SELF.DateTimeDispatched := L.date_time_dispatched,
		SELF.DateTimeEnroute := L.date_time_enroute,
		SELF.DateTimeArrival := L.date_time_arrived,
		SELF.DateTimeCleared := L.date_time_cleared,
		SELF.MinutesOnCall := (string) L.minutes_on_call,
		SELF.MinutesResponse := (string) L.minutes_response,
		SELF.ORI := (string)L.data_provider_id,
		SELF.Notes := PROJECT(L.notes, TRANSFORM(iesp.bair_share.t_BAIRNote, SELF.NoteType := BairRx_Common.Constants.NoteTypeLabel(LEFT.note_type),SELF.NoteText := LEFT.notes));
	END;
	
	iesp.bair_share.t_BAIRNote xtReportNotes(BairRx_Common.Layouts.PayloadNotes L) := TRANSFORM
		SELF.NoteType := BairRx_Common.Constants.NoteTypeLabel(L.note_type),
		SELF.NoteText := L.notes;
	END;
	
	EXPORT iesp.bair_cfs.t_BAIRCfsReportRecord ReportView(BairRx_CFS.Layouts.PayloadReport L) := TRANSFORM	
		_call := L.calls[1];
		SELF.ORI := (string) _call.data_provider_ori,
		SELF.EntityID := L.eid,
		SELF.EventNumber := _call.event_number,
		SELF.UCRGroup := (string) _call.final_ucr_group,
		SELF.Class := (string) _call.final_ucr_group,
		SELF.InitialType := _call.initial_type,
		SELF.LocationType := _call.location_type,
		SELF.DateTimeReceived := _call.date_time_received,
		SELF.EventAddress := _call.address,
		SELF.Agency :=  _call.data_provider_name,
		SELF.Accuracy := _call.accuracy,
		SELF.Calls := PROJECT(L.calls, xtCFSCall(LEFT));
		SELF.Officers := PROJECT(L.officers, xtCFSOfficer(LEFT));
		SELF.Notes 	:= PROJECT(L.Notes, xtReportNotes(LEFT)),
		self.eventAddressClean:=[]
	END;
	
END;	