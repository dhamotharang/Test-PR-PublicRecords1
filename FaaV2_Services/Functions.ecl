import Census_Data, codes, iesp, FaaV2_Services;
export Functions := module

	export FaaV2_Services.Layouts.t_AircraftRecordWithPenalty fnFaaSearchVal(dataset(Faav2_services.Layouts.rawrec) in_recs) := function
		
		FaaV2_Services.Layouts.t_AircraftRecordWithPenalty xform(faav2_services.Layouts.rawrec l)
																   := TRANSFORM
																															
		  self.currentFlag :=  map(l.current_flag = 'H' => 'Historical',
			                         l.current_flag = 'A' => 'Active',
													     ''),
			self.registrantType := l.type_registrant,
			self.CompanyName := l.compname,			
      Self.Name :=  if (l.compname = '', iesp.ECL2ESP.setName(l.fname, l.mname, l.lname, l.name_suffix, l.title, l.name), 																	
														iesp.ECL2ESP.setName('', '','','','','')),																	
			Self.Address := iesp.ECL2ESP.setAddress(l.prim_name, l.prim_range, l.predir, l.postdir, l.addr_suffix,
			                              l.unit_desig, l.sec_range, l.v_city_name, 
																		l.st, l.zip, l.z4, l.county_name),
			self.uniqueId := l.did_out;
			self.businessId := l.bdid_out;
			self.DateFirstSeen := iesp.ECL2ESP.toDate ((integer4) l.date_first_seen),													 
			self.DateLastSeen := iesp.ECL2ESP.toDate ((integer4) l.date_last_seen),
			self.Aircraft.AircraftNumber := l.n_number,
			self.Aircraft.SerialNumber := l.serial_number,
			self.Aircraft.ManufacturerModelCode := l.mfr_mdl_code,
			self.Aircraft.ManufacturerEngineModel := l.eng_mfr_mdl,
			self.Aircraft.ManufactureYear :=  if ((Integer) l.year_mfr = 0, 0, (Integer) l.year_mfr),
			self.Aircraft.AircraftType := codes.FAA_AIRCRAFT_REF.TYPE_AIRCRAFT(l.type_aircraft),
			self.Aircraft.ManufacturerName := l.aircraft_mfr_name,
			self.Aircraft.ModelName := l.model_name,
			self.aircraft_id := l.aircraft_id,
	    self._penalty  := l.penalt;
	    self.AlsoFound := l.isDeepDive;
			self.statementids := l.statementids,
			self.isDisputed   := l.isDisputed
	  END;
		
			// temp_filter_search := join (in_recs, Census_Data.Key_Fips2County,
                           // (left.state = right.state_code) and
                           // (left.county = right.county_fips), 
																			// xform(left, right),LEFT OUTER, limit(faav2_services.constants.max_recs_on_join , skip));
			temp_filter_search := project (in_recs,xform(left));
			
		
			filter := dedup(sort(temp_filter_search,record), record);
	    return(filter);         
	end;
	
	
 	export iesp.faaaircraft_Fcra.t_FcraAircraftReportRecord fnfaaReportval(dataset(FaaV2_Services.Layouts.aircraft_full) in_recs ):= function
   										 
      iesp.faaaircraft_Fcra.t_FcraAircraftReportRecord xform(FaaV2_Services.Layouts.aircraft_full l) := TRANSFORM																								 
   		  self.status := map(l.aircraft.current_flag = 'H' => 'Historical',
   			                    l.aircraft.current_flag = 'A' => 'Active',
   													''),													
   			self.AircraftNumber := l.aircraft.n_number,
   			self.DateFirstSeen := iesp.ECL2ESP.toDate ((integer4) l.aircraft.date_first_seen),
   			self.DateLastSeen := iesp.ECL2ESP.toDate ((integer4) l.aircraft.date_last_seen),
   			self.LastActionDate := iesp.ECL2ESP.toDate ((integer4) l.aircraft.last_action_date),
   			self.CertificationDate := iesp.ECL2ESP.toDate ((integer4) l.aircraft.cert_issue_date),
   			self.Registrant._type := l.aircraft.type_registrant,
   			self.Registrant.Companyname := l.aircraft.compname,			
   			self.Registrant.uniqueid := l.aircraft.did_out,			
   			self.Registrant.businessid := l.aircraft.bdid_out,			
   			self.Registrant.Name := if (l.aircraft.compname = '',iesp.ECL2ESP.setName(l.aircraft.fname, l.aircraft.mname, l.aircraft.lname, l.aircraft.name_suffix, l.aircraft.title, l.aircraft.name),
   																			iesp.ECL2ESP.setName('', '','','','','')),
   			Self.Registrant.Address := iesp.ECL2ESP.setAddress(l.aircraft.prim_name, l.aircraft.prim_range, l.aircraft.predir, l.aircraft.postdir, l.aircraft.addr_suffix,
   			                              l.aircraft.unit_desig, l.aircraft.sec_range, l.aircraft.v_city_name,
   																		l.aircraft.st, l.aircraft.zip, l.aircraft.z4, l.county_name),
   			self.AircraftInfo.ManufacturerName := l.aircraft.aircraft_mfr_name,
   			self.AircraftInfo.ModelName := l.aircraft.model_name,
   			self.AircraftInfo.SerialNumber := l.aircraft.serial_number,
   			self.AircraftInfo.ManufactureYear := (integer) l.aircraft.year_mfr,
  		  self.AircraftInfo.ModelCode := l.detail.aircraft_mfr_model_code,
   			self.AircraftInfo.AircraftType := codes.FAA_AIRCRAFT_REF.TYPE_AIRCRAFT(l.detail.type_aircraft),
   			self.AircraftInfo.EngineType := codes.FAA_AIRCRAFT_REF.TYPE_ENGINE(l.detail.type_engine),
   			self.AircraftInfo.Engines := (Integer ) l.detail.number_of_engines,
   			self.AircraftInfo.Seats := (Integer ) l.detail.number_of_seats, 
   			self.AircraftInfo.Category := codes.FAA_AIRCRAFT_REF.AIRCRAFT_CATEGORY_CODE(l.detail.aircraft_category_code), 
   			self.AircraftInfo.Certification := codes.FAA_AIRCRAFT_REF.AMATEUR_CERTIFICATION_CODE(l.detail.amateur_certification_code), 
   			self.AircraftInfo.Weight := Codes.KeyCodes('FAA_AIRCRAFT_REF','AIRCRAFT_WEIGHT',,l.detail.aircraft_weight), 
   			self.AircraftInfo.CruisingSpeed := if ((Integer) l.detail.aircraft_cruising_speed = 0, '', (string4) (integer) l.detail.aircraft_cruising_speed),
   		  self.EngineInfo.ManufacturerName := l.engine.engine_mfr_name,
   			self.EngineInfo.ModelName :=  l.engine.model_name,
   			self.EngineInfo.HorsePower := if ((integer)l.engine.engine_hp_or_thrust = 0, '', (string4) (integer) l.engine.engine_hp_or_thrust),
   			self.EngineInfo.FuelConsumption := if ((Integer) l.engine.fuel_consumed = 0, '', (string4) (integer) l.engine.fuel_consumed),
				self.BusinessIDs.proxid := l.proxid,
				self.businessIDs.ultid := l.ultid,
				self.businessIDs.orgid := l.orgid,
				self.businessIDs.seleid := l.seleid,
				self.businessIDs.dotid := l.dotid,
				self.BusinessIDs.empid := l.empid,
				self.BusinessIDs.powid := l.powid,
				self.statementids := l.statementids + l.detail.statementids +l.engine.statementids ,
				self.isDisputed   := l.isDisputed or l.detail.isDisputed or l.engine.isDisputed,
				self := [];
			END;
   			
  			temp_filter_report := project(in_recs, xform(LEFT));
   														    
  	
   			// sort and dedup on temp_filter.
   			filter_report := dedup(sort(temp_filter_report,record), record);
   	    return(filter_report);         
   	end;
	
end;
