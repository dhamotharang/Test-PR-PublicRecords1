//=================================================================================
// ======  RETURNS AIRCRAFT DATA FOR A GIVEN N_NUMBER IN ESP-COMPLIANT WAY.  ======
// ================================================================================
//
IMPORT iesp, Faa, FaaV2_Services, BIPV2, ut, codes;

EXPORT AircraftSource_Records(
  dataset(Layouts.rec_input_ids_wSrc) in_docids,
	SourceService_Layouts.OptionsLayout inoptions,
  boolean IsFCRA = false
) := MODULE

	SHARED air_layout_wLinkIds := RECORD
		Layouts.rec_input_ids_wSrc;
		FaaV2_Services.Layouts.aircraft_full and not BIPV2.IDlayouts.l_header_ids;
	END;

	// For in_docids records that don't have IdValues retrieve them from linkid file
	shared in_docs_linkonly := PROJECT(in_docids(IdValue = ''),TRANSFORM(BIPV2.IDlayouts.l_xlink_ids,
																																		SELF := LEFT,
																																		SELF := []));
	
	// *** Key fetch to get incorporation filing data
  shared ds_airkeys := PROJECT(faa.key_aircraft_linkids.KeyFetch(in_docs_linkonly,inoptions.fetch_level),
																TRANSFORM(Layouts.rec_input_ids_wSrc,
																					SELF.IdValue := LEFT.n_number,
																					SELF.nameInfo.CompanyName := LEFT.name,
																					SELF := LEFT,
																					SELF := []));
	
	// Blank out the keys based on the fetch level.
	ds_airkeys_level := Functions_Source.setLinkidFetchLev(ds_airkeys,recordof(ds_airkeys),inoptions.fetch_level);
	in_docids_level := Functions_Source.setLinkidFetchLev(in_docids,recordof(in_docids),inoptions.fetch_level);
	
	// If no name was passed with the source record of LinkIDs only, then keep all of the company names for the 
	// linkids keys, otherwise use the passed in name and overwrite the company name.
	ds_airkeys_name := JOIN(ds_airkeys_level,in_docids_level,
																		BIPV2.IDmacros.mac_JoinAllLinkids(),
																		TRANSFORM(Layouts.rec_input_ids_wSrc,
																				SELF.nameInfo.CompanyName := IF(TRIM(RIGHT.nameInfo.CompanyName) != '',
																											RIGHT.nameInfo.CompanyName,LEFT.nameInfo.CompanyName),
																				SELF := LEFT,
																				SELF := []));
																																				
	
	air_keys_comb := DEDUP(in_docids+ds_airkeys_name,ALL);
	
	air_numbers := PROJECT(air_keys_comb(IdValue != ''),TRANSFORM(FaaV2_Services.Layouts.aircraftNumberPlus,SELF.n_number := LEFT.IdValue,SELF := []));
  
	// Get aircraft_ids via the aircraft_numbers.  
	air_keys := FaaV2_Services.Raw.byAircraftNumber(air_numbers);

	air_keys_dedup := DEDUP(air_keys,ALL);
	
	// Get report via n_number
	air_sourceview := FaaV2_Services.Raw.getFullAircraft(project(air_keys_dedup,FaaV2_Services.Layouts.search_id) ,inoptions.app_type,IsFCRA);
	
	// To cut down on many of the repetive aircraft source docs, sort and dedup on the pertinant info.
	air_sourceview_dedup := DEDUP(SORT(air_sourceview,aircraft.serial_number,aircraft.n_number,aircraft.type_aircraft,
												aircraft.aircraft_mfr_name,aircraft.model_name,aircraft.name),
												aircraft.serial_number,aircraft.n_number,aircraft.type_aircraft,aircraft.aircraft_mfr_name,
												aircraft.model_name,aircraft.name);
	
	//Join against keys, and only keep records that match on names or keep all if the passed name is blank.
	SHARED air_sourceview_wLinkIds := JOIN(air_sourceview_dedup,air_keys_comb,
																		LEFT.aircraft.n_number = RIGHT.IdValue AND
																		(TRIM(LEFT.aircraft.name) = TRIM(RIGHT.nameinfo.companyName) OR
																		RIGHT.nameinfo.companyName = ''),
																		TRANSFORM(air_layout_wLinkIds,
																							SELF := RIGHT,
																							SELF := LEFT),
																		KEEP(1));   // For cases in which a idvalue has multiple linkids

	// iesp Aircraft Report Record out main transform
  SHARED iesp.faaaircraft.t_AircraftReportRecord toOut (air_layout_wLinkIds L) := transform
		IDmacros.mac_IespTransferLinkids()
	  self.Status                 := map(l.aircraft.current_flag = 'H' => 'Historical',
																			 l.aircraft.current_flag = 'A' => 'Active',
																			 ''),	;
    self.AircraftNumber         := L.aircraft.n_number;
    self.DateFirstSeen          := iesp.ECL2ESP.toDate ((integer4) L.aircraft.date_first_seen);
    self.DateLastSeen           := iesp.ECL2ESP.toDate ((integer4) L.aircraft.date_last_seen);
	  self.LastActionDate         := iesp.ECL2ESP.toDate ((integer4) L.aircraft.last_action_date);
	  self.CertificationDate      := iesp.ECL2ESP.toDate ((integer4) L.aircraft.cert_issue_date);
		self.Registrant._Type       := L.aircraft.type_registrant;
	  self.Registrant.CompanyName := L.aircraft.compname;
		self.Registrant.Name.Full   := L.aircraft.name;
		self.Registrant.Name.First  := L.aircraft.fname;
		self.Registrant.Name.Middle := L.aircraft.mname;
		self.Registrant.Name.Last   := L.aircraft.lname;
		self.Registrant.Name.Suffix := L.aircraft.name_suffix;
		self.Registrant.Name.Prefix := L.aircraft.title;
		self.Registrant.Address.StreetNumber        := L.aircraft.prim_range;
	  self.Registrant.Address.StreetPreDirection  := L.aircraft.predir;
	  self.Registrant.Address.StreetName          := L.aircraft.prim_name;
	  self.Registrant.Address.StreetSuffix        := L.aircraft.addr_suffix;
	  self.Registrant.Address.StreetPostDirection := L.aircraft.postdir;
	  self.Registrant.Address.UnitDesignation     := L.aircraft.unit_desig;
	  self.Registrant.Address.UnitNumber          := L.aircraft.sec_range;
	  self.Registrant.Address.StreetAddress1      := L.aircraft.street;
	  self.Registrant.Address.StreetAddress2      := L.aircraft.street2;
	  self.Registrant.Address.City                := L.aircraft.p_city_name;
	  self.Registrant.Address.State               := L.aircraft.st;
	  self.Registrant.Address.Zip5                := L.aircraft.zip;
	  self.Registrant.Address.Zip4                := L.aircraft.z4;
	  self.Registrant.Address.County              := l.county_name;
	  self.Registrant.Address.PostalCode          := '';
	  self.Registrant.Address.StateCityZip        := '';
		self.Registrant.UniqueId										:= L.aircraft.did_out;
		self.Registrant.BusinessId									:= L.aircraft.bdid_out;
		
		// Aircraft Info
		self.AircraftInfo.ManufacturerName  := L.detail.aircraft_mfr_name;
		self.AircraftInfo.ModelName         := L.detail.model_name;
	  self.AircraftInfo.ModelCode         := L.detail.aircraft_mfr_model_code;
		self.AircraftInfo.SerialNumber      := L.aircraft.serial_number;
	  self.AircraftInfo.ManufactureYear   := (Integer) L.aircraft.year_mfr;
	  self.AircraftInfo.AircraftType      := codes.FAA_AIRCRAFT_REF.TYPE_AIRCRAFT(l.detail.type_aircraft);
	  self.AircraftInfo.EngineType        := codes.FAA_AIRCRAFT_REF.TYPE_ENGINE(l.detail.type_engine);
		self.AircraftInfo.Engines        		:= (Integer) L.detail.number_of_engines;
		self.AircraftInfo.Seats             := (Integer) L.detail.number_of_seats;
		self.AircraftInfo.Category          := codes.FAA_AIRCRAFT_REF.AIRCRAFT_CATEGORY_CODE(l.detail.aircraft_category_code);
		self.AircraftInfo.Certification     := codes.FAA_AIRCRAFT_REF.AMATEUR_CERTIFICATION_CODE(l.detail.amateur_certification_code);
	  self.AircraftInfo.Weight            := Codes.KeyCodes('FAA_AIRCRAFT_REF','AIRCRAFT_WEIGHT',,l.detail.aircraft_weight);
		self.AircraftInfo.CruisingSpeed     := if ((Integer) l.detail.aircraft_cruising_speed = 0, '', (string4) (integer) l.detail.aircraft_cruising_speed);
		// self.AircraftInfo.AmateurCertification := L.detail.amateur_certification_code;
	
		// Engine Info
		self.EngineInfo.ManufacturerName 		:= L.engine.engine_mfr_name;
	  self.EngineInfo.ModelName        		:= L.engine.model_name;
	  self.EngineInfo.Horsepower       		:= if ((integer)l.engine.engine_hp_or_thrust = 0, '', (string4) (integer) l.engine.engine_hp_or_thrust);
	  self.EngineInfo.FuelConsumption  		:= if ((Integer) l.engine.fuel_consumed = 0, '', (string4) (integer) l.engine.fuel_consumed);
		self := [];
  end;
	
	SHARED SourceCount_Layouts.SourceDetailsLayout xform_Details(air_layout_wLinkIds L) := TRANSFORM
			self.src			:= 'AIRC';
			self.src_desc := 'FAA Aircraft Registrations';
			self.hasName 	:= (L.aircraft.name <>'');
			self.hasSSN  	:= (L.aircraft.best_ssn <>'');
			self.hasDOB  	:= false;
		  self.hasFEIN 	:= false;		
			self.hasAddr 	:= (L.aircraft.st <>'' or L.aircraft.zip <>'');
		  self.hasPhone := false;
			self.dt_first_seen := ut.NormDate((unsigned)L.aircraft.date_first_seen);
			self.dt_last_seen := ut.NormDate((unsigned)L.aircraft.date_last_seen);
			self := [];
	END;

	EXPORT SourceDetailInfo := project(air_sourceview_wLinkIds,xform_Details(LEFT));
	EXPORT SourceView_Recs := project(air_sourceview_wLinkIds, toOut(left));
  EXPORT SourceView_RecCount := COUNT(air_sourceview_wLinkIds);
	
END;