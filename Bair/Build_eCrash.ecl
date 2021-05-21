import ut,FLAccidents_Ecrash, _control, std;

EXPORT Build_eCrash(string version) := module
	
  BaseFile0 := FLAccidents_Ecrash.BaseFile;
  ecrashDS := BaseFile0(Report_code in ['EA','TF','TM'] and work_type_id in ['0','1'] and geo_long <> '' and geo_lat <> '' );
                
  dagency := distributed(FLAccidents_Ecrash.Files_MBSAgency.DS_BASE_AGENCY, hash32(Agency_ID));
  agency := dedup(sort(dagency, Agency_ID, local), Agency_ID, local);
													 
	shared crash_from_directagency_only := join(ecrashDS, agency, left.agency_id = right.agency_id, transform({ecrashDS, string src_id}, self.src_id := right.source_id; self := left;), lookup)(src_id in ['E','I', 'C']);
	// shared crash_from_agency_only := join(ecrashDS, agency, left.agency_id = right.agency_id, transform({ecrashDS, string src_id}, self.src_id := right.source_id; self := left;), lookup)(src_id in ['E','I']);
	
	BairCrashlayout := record
		string100 agency_name;
		string100 agency_ori;
		UNSIGNED4	dataProviderId;
		string30 injury_status;
		string7 fatality_involved;
		string3		vehicleId;
		string3		Id;
		Bair.layouts.crash_dbo_crash_In - [id, crash_import_id, ori];
		Bair.layouts.crash_dbo_person_In - [per_id, per_crashId, vehicleId, agency_person_id, per_crash_import_id, ori, case_number];
		Bair.layouts.crash_dbo_vehicle_In - [veh_id, veh_crashId, agency_vehicle_id, veh_crash_import_id, ori, case_number];
	end;

	BairCrashlayout xFormToCrash(crash_from_directagency_only L) := transform
	
		self.agency_name := L.agency_name;
		self.agency_ori := L.agency_ori;
		// self.id := 0;
		self.dataProviderId := (unsigned4)L.agency_id;
		self.injury_status := L.injury_status;
		self.fatality_involved := L.fatality_involved;
		self.case_number := trim(L.Case_Identifier, left, right);
		self.reportNumber := trim(L.report_id, left, right);
		self.report_date := trim(L.crash_date, left, right) + trim(L.crash_time, left, right);
		self.address := trim(L.Address_Number, left, right) + trim(L.Loss_Street, left, right);
		self.county := trim(L.Crash_County, left, right);
		self.crash_city := trim(L.Crash_City, left, right);
		self.crash_state := trim(L.Loss_State_Abbr, left, right);
		self.coordinate := ''; //calculate
		self.x := (real8)L.geo_long;
		self.y := (real8)L.geo_lat;
		self.hitAndRun := trim(L.Incident_Hit_and_Run, left, right);
		self.intersectionRelated := if(regexfind('Intersection|intersection', L.Intersection_Type) = true, '1', '0');
		self.officerName := trim(L.Investigating_Officer_Name, left, right);
		self.crashType := trim(L.Report_Injury_Status, left, right);
		v_Location_Type := trim(L.Location_Type, left, right);
		self.locationType := trim(L.Relation_to_Junction, left, right) + if( v_Location_Type <> '', '; ' + v_Location_Type, '');
		self.accidentClass := trim(L.Driver_Actions_at_Time_of_Crash1, left, right);
		self.specialCircumstance1 := trim(L.Contributing_Circumstances_Environmental1, left, right);
		self.specialCircumstance2 := trim(L.Contributing_Circumstances_Environmental2, left, right);
		self.specialCircumstance3 := trim(L.Contributing_Circumstances_Environmental3, left, right);
		v_Light_Condition2 := trim(L.Light_Condition2, left, right);
		self.lightCondition := trim(L.Light_Condition1, left, right) + if(v_Light_Condition2 <> '', '; ' + v_Light_Condition2, '');
		v_Weather_Condition2 := trim(L.Weather_Condition2, left, right);
		self.weatherCondition := trim(L.Weather_Condition1, left, right) + if(v_Weather_Condition2 <> '', '; ' + v_Weather_Condition2, '');
		self.surfaceType := trim(L.Road_Surface, left, right);
		self.roadSpecialFeature1 := trim(L.Contributing_Circumstances_Road1, left, right);//L.Roadyway_alignment + L.Contributing_Circumstances_Road1;
		self.roadSpecialFeature2 := trim(L.Contributing_Circumstances_Road2, left, right);
		self.roadSpecialFeature3 := trim(L.Contributing_Circumstances_Road3, left, right);
		self.surfaceCondition := trim(L.Road_Surface_condition, left, right);
		v_traffic_control_type_at_intersection2 := trim(L.traffic_control_type_at_intersection2, left, right);
		self.trafficControlPresent := trim(L.traffic_control_type_at_intersection1, left, right) + if(v_traffic_control_type_at_intersection2 <> '', '; ' + v_traffic_control_type_at_intersection2, '');
		v_Narrative_Continuance := trim(L.Narrative_Continuance, left, right);
		self.narrative := regexreplace('~', trim(L.Narrative, left, right) + if(v_Narrative_Continuance <> '', '; ' + v_Narrative_Continuance, ''), '"');
		self.quarantined := '0';
		
		self.vehicleId := L.Unit_number;
		self.driver := if(regexfind('[|]DRIVER|DRIVER[|]', STD.Str.ToUpperCase(trim(L.person_type, left, right))) = true
										,skip
										,if(regexfind('^DRIVER$', STD.Str.ToUpperCase(trim(L.person_type, left, right))) = true
											,'1'
											,'0'));
		self.first_name := trim(L.first_name, left, right);
		self.last_name := trim(L.last_name, left, right);
		self.licenseNumber := trim(L.Drivers_License_Number, left, right);
		self.licenseState := trim(L.Drivers_License_Jurisdiction, left, right);
		self.race := trim(L.race, left, right);
		self.sex := trim(L.sex, left, right);
		self.per_city := trim(L.city, left, right);
		self.per_state := trim(L.state, left, right);
		self.age := (UNSIGNED2)L.age;
		v_Driver_Actions_at_Time_of_Crash2 := trim(L.Driver_Actions_at_Time_of_Crash2, left, right);
		v_Driver_Actions_at_Time_of_Crash3 := trim(L.Driver_Actions_at_Time_of_Crash3, left, right);
		v_Driver_Actions_at_Time_of_Crash4 := trim(L.Driver_Actions_at_Time_of_Crash4, left, right);
		self.driverActions := trim(L.Driver_Actions_at_Time_of_Crash1, left, right) + if(v_Driver_Actions_at_Time_of_Crash2 <> '', '; ' + v_Driver_Actions_at_Time_of_Crash2, '') + if(v_Driver_Actions_at_Time_of_Crash3 <> '', '; ' + v_Driver_Actions_at_Time_of_Crash3, '') + if(v_Driver_Actions_at_Time_of_Crash4 <> '', '; ' + v_Driver_Actions_at_Time_of_Crash4, '');
		self.airbag := trim(L.air_bag_deployed, left, right);
		v_Safety_equipment_restraint2 := trim(L.Safety_equipment_restraint2, left, right);
		self.seatbelt := trim(L.Safety_equipment_restraint1, left, right) + if(v_Safety_equipment_restraint2 <> '', '; ' + v_Safety_equipment_restraint2, '');
		
		self.id := L.Vehicle_unit_number;//vehicleId;
		self.vin := L.vin;
		self.plate := trim(L.License_Plate, left, right);
		self.plateState := trim(L.Registration_State, left, right);
		self.year := trim(L.Model_Year, left, right);
		self.make := trim(L.make, left, right);
		self.model := trim(L.model, left, right);
		self.towed := trim(L.tow_away, left, right);
		v_Body_Type_category := trim(L.Body_Type_category, left, right);
		self.vehicle_type := trim(L.Vehicle_type, left, right) + if(v_Body_Type_category <> '', '; ' + v_Body_Type_category, '');
		v_Impact_Area2 := trim(L.Impact_Area2, left, right);
		self.damage := trim(L.Impact_Area1, left, right) + if(v_Impact_Area2 <> '', '; ' + v_Impact_Area2, ''); //L.damage_areas_derived1 + 
		v_Contributing_Circumstances_p2 := trim(L.Contributing_Circumstances_p2, left, right);
		v_Contributing_Circumstances_p3 := trim(L.Contributing_Circumstances_p3, left, right);
		v_Contributing_Circumstances_p4 := trim(L.Contributing_Circumstances_p4, left, right);
		self.action := trim(L.Contributing_Circumstances_p1, left, right) + if(v_Contributing_Circumstances_p2 <> '', '; ' + v_Contributing_Circumstances_p2, '') + if(v_Contributing_Circumstances_p3 <> '', '; ' + v_Contributing_Circumstances_p3, '') + if(v_Contributing_Circumstances_p4 <> '', '; ' + v_Contributing_Circumstances_p4, '');
		v_second_harmful_event := trim(L.second_harmful_event, left, right);
		self.sequence := trim(L.most_harmful_event, left, right) + if(v_second_harmful_event <> '', '; ' + v_second_harmful_event, '');
		v_Condition_at_time_of_crash2 := trim(L.Condition_at_time_of_crash2, left, right);
		self.driverImpairment := trim(L.Condition_at_time_of_crash1, left, right) + if(v_Condition_at_time_of_crash2 <> '', '; ' + v_Condition_at_time_of_crash2, '');
		
	end;
	
	EXPORT crashRecs := project(crash_from_directagency_only, xFormToCrash(left));	
	
	path 			:= '/data/bair/outgoing/';
	pServerIP	:= Bair._Constant.bair_batchlz;
	
  Unspray(string logicalname, string filename, string subdir = '') :=
			STD.File.Despray(logicalname,
				pServerIP,
				path + if(subdir <> '', subdir + '/', '') + filename,
				allowoverwrite := true);
				
	eCrashLFN := '~thor_data400::out::bair::eCrash::' + version;	
	eCrashFN 	:= 'eCrash_' + version + '.txt';
		
	EXPORT create_all := sequential(	
		OUTPUT(crashRecs,,eCrashLFN,CSV(SEPARATOR(['~|~']),QUOTE(''),TERMINATOR(['~<EOL>~'])),OVERWRITE, COMPRESSED),
		Unspray(eCrashLFN, eCrashFN, ''),
	);

END;