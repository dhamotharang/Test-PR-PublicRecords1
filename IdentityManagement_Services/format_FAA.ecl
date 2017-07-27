/***
 ** Function to filter/transform FAA Aircraft Services dataset into desired format.
 ***/
 
IMPORT FaaV2_Services, iesp, doxie, codes;

/******* set these for stand-alone testing (also need to remove 'export' for function) *******
#Stored('GLBPurpose', 2);
#Stored('DLPurpose', 1);
#stored('DataRestrictionMask','00000000000000000000');
#stored('DataPermissionMask','1111111111');
/*******/

// define short-cut for a longer layout name
out_rec := iesp.identitymanagementreport.t_IdmAirCraftRecord; // aircraft output record

EXPORT out_rec format_FAA(Dataset (FaaV2_Services.Layouts.aircraft_full) in_recs) := 
FUNCTION

	// more record layout shortcuts
	full_rec         := FaaV2_Services.Layouts.aircraft_full;
	                    // Current, N_Number, Seen-Dates, Certification, Registration-info, others
	registration_rec := iesp.identitymanagementreport.t_IdmAirCraftRegistration;
	
	// sort according to manufacturer and model name
	// serial number is not reliable, and there's no interest in that field,
	// but it should still be usable to distinguish two otherwise identical aircraft
	planes_full_sorted := Sort(in_recs, aircraft.aircraft_mfr_name, aircraft.model_name, aircraft.serial_number);

	// group it for rollup
	planes_full_grouped := Group(planes_full_sorted, aircraft.aircraft_mfr_name, aircraft.model_name, aircraft.serial_number);

	// load the multiple registrations portion of an aircraft
	registration_rec getRegistrations(full_rec L) := Transform
		Self.Current := Case(StringLib.StringToUpperCase(L.aircraft.current_flag), 'H'=>'Historical', 'A'=>'Active', '');
		Self.NNumber := L.aircraft.n_number;
		Self.DateFirstSeen := iesp.ECL2ESP.toDate((Unsigned4)L.aircraft.date_first_seen);
		Self.DateLastSeen := iesp.ECL2ESP.toDate((Unsigned4)L.aircraft.date_last_seen);
		Self.LastAction := iesp.ECL2ESP.toDate((Unsigned4)L.aircraft.last_action_date);
		Self.CertificationIssue := iesp.ECL2ESP.toDate((Unsigned4)L.aircraft.cert_issue_date);
		Self.Certification := L.aircraft.certification;
		Self.Registrant.Name := L.aircraft.name;
		Self.Registrant.Street := L.aircraft.street;
		Self.Registrant.Street2 := L.aircraft.street2;
		Self.Registrant.City := L.aircraft.city;
		Self.Registrant.State := L.aircraft.state;
		Self.Registrant.ZipCode := L.aircraft.zip_code;
		Self.Registrant.Region := L.aircraft.region;
		Self.Registrant.CountyName := L.county_name;
		Self.Registrant.Country := L.aircraft.country;
		Self.Registrant.CompanyName := L.aircraft.compname;
	End;

	// get the important identifying info about an aircraft
	out_rec toOut(full_rec L, Dataset(full_rec) R) := Transform
		Self.ManufacturerName := L.detail.aircraft_mfr_name;
		Self.ModelName := L.detail.model_name;
		Self.TypeAircraft := codes.FAA_AIRCRAFT_REF.TYPE_AIRCRAFT(L.detail.type_aircraft);
		Self.Category := codes.FAA_AIRCRAFT_REF.AIRCRAFT_CATEGORY_CODE(L.detail.aircraft_category_code);
		Self.NumberOfSeats := (String3)(Unsigned2)L.detail.number_of_seats;
		Self.TypeEngine := codes.FAA_AIRCRAFT_REF.TYPE_ENGINE(L.detail.type_engine);
		// when speed is unknown, data shows zero. we will show an empty field instead
		Self.CruisingSpeed := if((Integer2)L.detail.aircraft_cruising_speed > 0,
																				(String4)(Unsigned2)L.detail.aircraft_cruising_speed, '');
		// sort registrations most recent first
		Self.Registrations := ChooseN(Project(Sort(R, -aircraft.date_last_seen, -aircraft.last_action_date),
		                                      getRegistrations(Left)),
		                              iesp.Constants.IDM.MaxAircraftRegistrations);
	End;

	// rollup the aircraft for our many-to-one of registrations to aircraft, then do one
	// last sort so that the most recently certified aircraft display first
	plane_recs := Sort(Rollup(planes_full_grouped, Group, toOut(Left, Rows(Left))),
											-registrations[1].CertificationIssue.year,
											-registrations[1].CertificationIssue.month,
											-registrations[1].CertificationIssue.day);

/*******
	// DEBUG
	Output(planes_by_did,      Named('Planes_by_Did'));
	Output(planes_deduped,     Named('Planes_Deduped'));
	Output(planes_full,        Named('Planes_Full'));
	Output(planes_full_sorted, Named('Planes_Full_Sorted'));
	Output(plane_recs,         Named('Plane_Wrecks'));
/*******/

	// final records returned to caller
	Return plane_recs;
END;

/******* Function Standalone Test Section *******

doxie.layout_references dids := dataset([{'860533176'}], doxie.layout_references); // E Wayne Fredericks
// doxie.layout_references dids := dataset([{'559782406'}], doxie.layout_references); // Christopher M Cywinski, Glider
// doxie.layout_references dids := dataset([{'2266496575'}], doxie.layout_references); // Frank R Schelling, WWI Jenny
// doxie.layout_references dids := dataset([{'2414879780'}], doxie.layout_references); // Hal M Staniloff, Cessna, Raytheon, Beechcraft

Output(format_FAA(dids),Named('RESULT'));
/*******/