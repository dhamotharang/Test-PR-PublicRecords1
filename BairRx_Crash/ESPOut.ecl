import BairRx_Common,iesp;

EXPORT ESPOut := MODULE


	EXPORT iesp.bair_crash.t_BAIRCrashSearchRecord SearchView(BairRx_Crash.Layouts.SearchPayload L) := TRANSFORM
		SELF.EntityID := L.eid,
		SELF.UCRGroup := (STRING)BairRx_Common.ClassificationCode.MapClassCodeOut(BairRx_Common.EID.Type.CRA, L.crashType),
		SELF.Class := L.crashtype,
		SELF.CaseNumber := L.case_number,
		SELF.ReportNumber := L.reportnumber,
		SELF.ReportDateTime := L.report_date,
		SELF.Agency := (string) L.data_provider_name, 
		SELF.ORI := (string) L.data_provider_id, 
		SELF.Address := L.address,
		SELF.County := L.county,
		SELF.City := L.crash_city,
		SELF.State := L.crash_state,
		SELF.HitAndRun := L.hitandrun,
		SELF.IntersectionRelated := L.intersectionrelated,
		SELF.OfficerName := L.officername,
		SELF.CrashType := L.crashtype,
		SELF.LocationType := L.locationtype,
		SELF.XCoordinate := (string) L.x,
		SELF.YCoordinate := (string) L.y,
		SELF.AccidentClass := L.accidentclass,		
		SELF.SpecialCircumstance1 := L.specialcircumstance1,
		SELF.SpecialCircumstance2 := L.specialcircumstance2,
		SELF.SpecialCircumstance3 := L.specialcircumstance3,
		SELF.LightCondition := L.lightcondition,
		SELF.WeatherCondition := L.weathercondition,
		SELF.SurfaceType := L.surfacetype,
		SELF.RoadSpecialFeature1 := L.roadspecialfeature1,
		SELF.RoadSpecialFeature2 := L.roadspecialfeature2,
		SELF.RoadSpecialFeature3 := L.roadspecialfeature3,
		SELF.SurfaceCondition := L.surfacecondition,
		SELF.TrafficControlPresent := L.trafficcontrolpresent,
		SELF.VehicleID := (string) L.vehicleid,
		SELF.VehicleVIN := L.vin,
		SELF.VehiclePlate := L.plate,
		SELF.VehiclePlateState := L.platestate,
		SELF.VehicleYear := L.year,
		SELF.VehicleMake := L.make,
		SELF.VehicleModel := L.model,
		SELF.VehicleTowed := L.towed,
		SELF.VehicleType := L.vehicle_type,
		SELF.VehicleDamage := L.damage,
		SELF.VehicleActions := L.action,
		SELF.VehicleSequence := L.sequence,		
		SELF.DriverImpairment := L.driverimpairment,
		SELF.DriverFirstName := L.first_name,
		SELF.DriverLastName := L.last_name,
		SELF.PersonsVehicleID := (string) L.personvehicleid,
		SELF.DriversActions := L.driveractions,
		SELF.DriverLicenseNumber := L.licensenumber,
		SELF.DriverLicenseState := L.licensestate,
		SELF.DriverAirbag := L.airbag,
		SELF.DriverRace := L.race,
		SELF.DriverSex := L.sex,
		SELF.DriverAge := (string) L.age,
		SELF.DriverSeatBelt := L.seatbelt,
		SELF.DriverCity := L.city,
		SELF.DriverState := L.state,	
		SELF.Accuracy := BairRx_Common.Constants.AccuracyLabel(6), // hard coding to address
		SELF := []
	END;
	
	SHARED iesp.bair_crash.t_BAIRCrashIncidentReportRecord xtRptIncident(BairRx_Crash.Layouts.PayloadIncident L) := TRANSFORM
		SELF.ORI := (STRING) L.data_provider_id, 
		SELF.CaseNumber := L.case_number,
		SELF.ReportDateTime := L.report_date,
		SELF.Address := L.address,
		SELF.County := L.county,
		SELF.City := L.crash_city,
		SELF.State := L.crash_state,
		SELF.IntersectionRelated := L.intersectionrelated,
		SELF.OfficerName := L.officername,
		SELF.CrashType := L.crashtype,
		SELF.LocationType := L.locationtype,
		SELF.XCoordinate := (string) L.x,
		SELF.YCoordinate := (string) L.y,
		SELF.AccidentClass := L.accidentclass,
		SELF.LightCondition := L.lightcondition,
		SELF.WeatherCondition := L.weathercondition,
		SELF.SurfaceType := L.surfacetype,
		SELF.SurfaceCondition := L.surfacecondition,
		SELF.Agency := L.data_provider_name,
		SELF.ReportNumber := L.reportnumber,
		SELF.HitAndRun := L.hitandrun,
		SELF.SpecialCircumstance1 := L.specialcircumstance1,
		SELF.SpecialCircumstance2 := L.specialcircumstance2,
		SELF.SpecialCircumstance3 := L.specialcircumstance3,
		SELF.RoadSpecialFeature1 := L.roadspecialfeature1,
		SELF.RoadSpecialFeature2 := L.roadspecialfeature2,
		SELF.RoadSpecialFeature3 := L.roadspecialfeature3,
		SELF.TrafficControlPresent := L.trafficcontrolpresent
	END;
	
	SHARED iesp.bair_crash.t_BAIRCrashVehicleReportRecord xtRptVehicle(BairRx_Crash.Layouts.PayloadVehicle L) := TRANSFORM
		SELF.ORI := (STRING) L.data_provider_id, 
		SELF.VehicleID := (string) L.vehicleid,
		SELF.VIN := L.vin,
		SELF.Plate := L.plate,
		SELF.PlateState := l.platestate;
		SELF.Year := L.year,
		SELF.Make := L.make,
		SELF.Model := L.model,
		SELF.Towed := L.towed,
		SELF._Type := L.vehicle_type,
		SELF.Damage := L.damage,
		SELF.Actions := L.action,
		SELF.Sequence := L.sequence,		
		SELF.DriverImpairment := L.driverimpairment
	END;
	
	SHARED iesp.bair_crash.t_BAIRCrashDriverReportRecord xtRptDriver(BairRx_Crash.Layouts.PayloadPerson L) := TRANSFORM			
		SELF.ORI := (STRING) L.data_provider_id, 
		SELF.LexID := (string)L.lexid,
		SELF.FirstName := L.first_name,
		SELF.LastName := L.last_name,
		SELF.PersonsVehicleID := (string) L.personvehicleid,
		SELF.Actions := L.driveractions,
		SELF.LicenseNumber := L.licensenumber,
		SELF.LicenseState := L.licensestate,
		SELF.Airbag := L.airbag,
		SELF.Race := L.race,
		SELF.Sex := L.sex,
		SELF.Age := (string) L.age,
		SELF.SeatBelt := L.seatbelt,
		SELF.City := L.city,
		SELF.State := L.state			
	END;
	
	iesp.bair_share.t_BAIRNote xtReportNotes(BairRx_Common.Layouts.PayloadNotes L) := TRANSFORM
		SELF.NoteType := BairRx_Common.Constants.NoteTypeLabel(L.note_type),
		SELF.NoteText := L.notes;
	END;	
	
	EXPORT iesp.bair_crash.t_BAIRCrashReportRecord ReportView(BairRx_Crash.Layouts.PayloadReport L) := TRANSFORM
		SELF.EntityID := L.eid,
		SELF.UCRGroup := (STRING)BairRx_Common.ClassificationCode.MapClassCodeOut(BairRx_Common.EID.Type.CRA, L.crashType),
		SELF.Class := L.crashtype,
		SELF.CaseNumber := L.case_number,
		SELF.ReportDateTime := L.report_date,
		SELF.Address := L.address,
		SELF.County := L.county,
		SELF.City := L.crash_city,
		SELF.State := L.crash_state,
		SELF.AccidentClass := L.accidentclass,
		SELF.Agency := L.data_provider_name,
		SELF.ORI := (STRING) L.data_provider_id, 
		SELF.Incidents := PROJECT(L.Incidents, xtRptIncident(LEFT));
		SELF.Vehicles := PROJECT(L.Vehicles, xtRptVehicle(LEFT));
		SELF.Drivers := PROJECT(L.Persons, xtRptDriver(LEFT));
		SELF.Notes 	:= PROJECT(L.Notes, xtReportNotes(LEFT)),
		SELF := []
	END;
	
END;	