IMPORT Address,FLAccidents_eCrash,Codes,iesp,Suppress,Accident_services;

EXPORT Transforms := MODULE

  // Key_eCrash0 (Accident Location/DOT Info)
  EXPORT Accident_services.Layouts.accRptRecWithAccNbr reportRecord(Accident_services.Layouts.report L,FLAccidents_eCrash.Key_eCrash0 R) := TRANSFORM
    SELF.accident_nbr := L.accident_nbr;
    SELF.AccidentDate := iesp.ECL2ESP.toDatestring8 ((String8)TRIM(R.accident_date,LEFT,RIGHT));
    SELF.DhsmvVehicleCrash := R.dhsmv_veh_crash_ind;
    SELF.FormType := R.form_type;
    SELF.UpdateNumber := R.update_nbr;
    SELF.AccidentState := L.vehicle_incident_st;

    SELF.AccidentLocation.StateRoadAccident := R.st_road_accident;
    SELF.AccidentLocation.County := codes.KeyCodes('FLCRASH0_TIME_LOCATION','COUNTY_NBR','',R.city_nbr[1..2]);
    SELF.AccidentLocation.City := codes.keyCodes('FLCRASH0_TIME_LOCATION','CITY_NBR','',R.city_nbr);
    SELF.AccidentLocation.FootCityTown := (INTEGER)R.ft_city_town;
    SELF.AccidentLocation.MilesCityTown := (INTEGER)R.miles_city_town;
    SELF.AccidentLocation.DirectionCityTown := R.direction_city_town;
    SELF.AccidentLocation.CityTownName := R.city_town_name;
    SELF.AccidentLocation.AtNodeNumber := R.at_node_nbr;
    SELF.AccidentLocation.FootMilesNode := R.ft_miles_node;
    SELF.AccidentLocation.FootMiles1 := '';
    SELF.AccidentLocation.FromNodeNumber := R.from_node_nbr;
    SELF.AccidentLocation.NextNodeRoadway := R.next_node_rdwy;
    SELF.AccidentLocation.StateRoadHighwayName := R.st_road_hhwy_name;
    SELF.AccidentLocation.AtIntersectOf := R.at_intersect_of;
    SELF.AccidentLocation.FootMilesFromIntersect := R.ft_miles_from_intersect;
    SELF.AccidentLocation.FootMiles2 := '';
    SELF.AccidentLocation.IntersectDirectionOf := R.intersect_dir_of;
    SELF.AccidentLocation.OfIntersectOf := R.of_intersect_of;
    SELF.AccidentLocation.IsCodeable := IF(R.codeable_noncodeable='0',TRUE,FALSE);
    SELF.AccidentLocation.TypeFRCase := codes.KeyCodes('FLCRASH0_TIME_LOCATION','TYPE_FR_CASE','',R.type_fr_case);
    SELF.AccidentLocation.Action := codes.KeyCodes('FLCRASH0_TIME_LOCATION','ACTION_CODE','',R.action_code);

    SELF.DotInfo.TypeFacility := R.dot_type_facility;
    SELF.DotInfo.RoadType := R.dot_road_type;
    SELF.DotInfo.NumberOfLanes := (INTEGER)R.dot_nbr_lanes;
    SELF.DotInfo.SiteLocation := R.dot_site_loc;
    SELF.DotInfo.DistrictIndex := R.dot_district_ind;
    SELF.DotInfo.County := R.dot_county;
    SELF.DotInfo.SectionNumber := (INTEGER)R.dot_section_nbr;
    SELF.DotInfo.SkidResistance := R.dot_skid_resistance;
    SELF.DotInfo.FrictionCoarse := R.dot_friction_coarse;
    SELF.DotInfo.AverageDailyTraffic := R.dot_avg_daily_traffic;
    SELF.DotInfo.NodeNumber := (INTEGER)R.dot_node_nbr;
    SELF.DotInfo.DistanceFromNode := R.dot_distance_node;
    SELF.DotInfo.DirectionFromNode := R.dot_dir_from_node;
    SELF.DotInfo.StateRoadNumber := (INTEGER)R.dot_st_road_nbr;
    SELF.DotInfo.USRoadNumber := (INTEGER)R.dot_us_road_nbr;
    SELF.DotInfo.Milepost := R.dot_milepost;
    SELF.DotInfo.HighwayLocation := R.dot_hhwy_loc;
    SELF.DotInfo.Subsection := R.dot_subsection;
    SELF.DotInfo.SystemType := R.dot_system_type;
    SELF.DotInfo.Travelway := R.dot_travelway;
    SELF.DotInfo.NodeType := R.dot_node_type;
    SELF.DotInfo.FixtureType := R.dot_fixture_type;
    SELF.DotInfo.SideOfRoad := R.dot_side_of_road;
    SELF.DotInfo.AccidentSeverity := R.dot_accident_severity;
    SELF.DotInfo.LaneId := (INTEGER)R.dot_lane_id;

    SELF := [];
  END;

  // Key_eCrash1 (Accident Time/Conditions/Investigation/Statistics)
  EXPORT Accident_services.Layouts.accRptRecWithAccNbr addTimeCondInvestStats(Accident_services.Layouts.accRptRecWithAccNbr L,FLAccidents_eCrash.Key_eCrash1 R) := TRANSFORM
    SELF.AccidentTime.DayOfWeek := IF(R.day_week!='',codes.KeyCodes('FLCRASH1_ACCIDENT_CHAR','DAY_WEEK','',R.day_week),R.day_week_desc);
    SELF.AccidentTime.HourOfAccident := (INTEGER1)R.hr_accident;
    SELF.AccidentTime.MinuteOfAccident := (INTEGER1)R.min_accident;
    SELF.AccidentTime.HourOffNotified := (INTEGER1)R.hr_off_notified;
    SELF.AccidentTime.MinuteOffNotified := (INTEGER1)R.min_off_notified;
    SELF.AccidentTime.HourOffArrived := (INTEGER1)R.hr_off_arrived;
    SELF.AccidentTime.MinuteOffArrived := (INTEGER1)R.min_off_arrived;

    SELF.Conditions.LocationType := IF(R.location_type!='',codes.KeyCodes('FLCRASH1_ACCIDENT_CHAR','LOCATION_TYPE','',R.location_type),R.location_type_desc);
    SELF.Conditions.Population := R.pop_code;
    SELF.Conditions.RuralUrban := codes.KeyCodes('FLCRASH1_ACCIDENT_CHAR','RURAL_URBAN_CODE','',R.rural_urban_code);
    SELF.Conditions.SiteLocation := codes.KeyCodes('FLCRASH1_ACCIDENT_CHAR','SITE_LOC','',R.site_loc);
    SELF.Conditions.FirstHarmfulEvent := IF(R.first_harmful_event!='',codes.KeyCodes('FLCRASH1_ACCIDENT_CHAR','FIRST_HARMFUL_EVENT','',R.first_harmful_event),R.first_harmful_event_desc);
    SELF.Conditions.SecondHarmfulEvent := codes.KeyCodes('FLCRASH1_ACCIDENT_CHAR','SUBS_HARMFUL_EVENT','',R.subs_harmful_event);
    SELF.Conditions.OnOffRoadway := codes.KeyCodes('FLCRASH1_ACCIDENT_CHAR','ON_OFF_ROADWAY','',R.on_off_roadway);
    SELF.Conditions.LightCondition := IF(R.light_condition!='',codes.KeyCodes('FLCRASH1_ACCIDENT_CHAR','LIGHT_CONDITION','',R.light_condition),R.light_condition_desc);
    SELF.Conditions.Weather := IF(R.weather!='',codes.KeyCodes('FLCRASH1_ACCIDENT_CHAR','WEATHER','',R.weather),R.weather_desc);
    SELF.Conditions.RoadSurfaceType := IF(R.rd_surface_type!='',codes.KeyCodes('FLCRASH1_ACCIDENT_CHAR','RD_SURFACE_TYPE','',R.rd_surface_type),R.rd_surface_type_desc);
    SELF.Conditions.ShoulderType := IF(R.type_shoulder!='',codes.KeyCodes('FLCRASH1_ACCIDENT_CHAR','TYPE_SHOULDER','',R.type_shoulder),R.type_shoulder_desc);
    SELF.Conditions.RoadSurfaceCondition := IF(R.rd_surface_condition!='',codes.KeyCodes('FLCRASH1_ACCIDENT_CHAR','RD_SURFACE_CONDITION','',R.rd_surface_condition),R.rd_surface_condition_desc);
    SELF.Conditions.FirstContributingCause := IF(R.first_contrib_cause!='',codes.KeyCodes('FLCRASH1_ACCIDENT_CHAR','FIRST_CONTRIB_CAUSE','',R.first_contrib_cause),R.first_contrib_cause_desc);
    SELF.Conditions.SecondContributingCause := IF(R.second_contrib_cause!='',codes.KeyCodes('FLCRASH1_ACCIDENT_CHAR','SECOND_CONTRIB_CAUSE','',R.second_contrib_cause),R.second_contrib_cause_desc);
    SELF.Conditions.FirstContributingEnvirionment := IF(R.first_contrib_envir!='',codes.KeyCodes('FLCRASH1_ACCIDENT_CHAR','FIRST_CONTRIB_ENVIR','',R.first_contrib_envir),R.first_contrib_envir_desc);
    SELF.Conditions.SecondContributingEnvirionment := IF(R.second_contrib_envir!='',codes.KeyCodes('FLCRASH1_ACCIDENT_CHAR','SECOND_CONTRIB_ENVIR','',R.second_contrib_envir),R.second_contrib_envir_desc);
    SELF.Conditions.FirstTrafficControl := IF(R.first_traffic_control!='',codes.KeyCodes('FLCRASH1_ACCIDENT_CHAR','FIRST_TRAFFIC_CONTROL','',R.first_traffic_control),R.first_traffic_control_desc);
    SELF.Conditions.SecondTrafficControl := IF(R.second_traffic_control!='',codes.KeyCodes('FLCRASH1_ACCIDENT_CHAR','SECOND_TRAFFIC_CONTROL','',R.second_traffic_control),R.second_traffic_control_desc);
    SELF.Conditions.TrafficwayChar := codes.KeyCodes('FLCRASH1_ACCIDENT_CHAR','TRAFFICWAY_CHAR','',R.trafficway_char);
    SELF.Conditions.NumberOfLanes := R.nbr_lanes;
    SELF.Conditions.DividedUndivided := codes.KeyCodes('FLCRASH1_ACCIDENT_CHAR','DIVIDED_UNDIVIDED','',R.divided_undivided);
    SELF.Conditions.RoadSystemId := codes.KeyCodes('FLCRASH1_ACCIDENT_CHAR','RD_SYS_ID','',R.rd_sys_id);
    SELF.Conditions.InvestigationAgent := IF(R.invest_agency!='',codes.KeyCodes('FLCRASH1_ACCIDENT_CHAR','INVEST_AGENCY','',R.invest_agency),R.invest_agency_desc);
    SELF.Conditions.InjurySeverity := codes.KeyCodes('FLCRASH1_ACCIDENT_CHAR','ACCIDENT_INJURY_SEVERITY','',R.accident_injury_severity);
    SELF.Conditions.DamageSeverity := IF(R.accident_damage_severity!='',codes.KeyCodes('FLCRASH1_ACCIDENT_CHAR','ACCIDENT_DAMAGE_SEVERITY','',R.accident_damage_severity),R.accident_damage_severity_desc);
    SELF.Conditions.Insurance := '';
    SELF.Conditions.AccidentFault := IF(R.accident_fault_code!='',codes.KeyCodes('FLCRASH1_ACCIDENT_CHAR','ACCIDENT_FAULT_CODE','',R.accident_fault_code),R.accident_fault_code_desc);
    SELF.Conditions.AlcoholDrug := IF(R.alcohol_drug!='',codes.KeyCodes('FLCRASH1_ACCIDENT_CHAR','ALCOHOL_DRUG','',R.alcohol_drug),R.alcohol_drug_desc);

    SELF.Investigation.InvestigationAgent.AgentReportNumber := R.invest_agy_rpt_nbr;
    SELF.Investigation.InvestigationAgent.AgentName := R.invest_name;
    SELF.Investigation.InvestigationAgent.AgentRank := R.invest_rank;
    SELF.Investigation.InvestigationAgent.AgentIdBadgeNumber := R.invest_id_badge_nbr;
    SELF.Investigation.InvestigationAgent.AgentDepartmentName := R.dept_name;
    SELF.Investigation.InvestMaede := codes.KeyCodes('FLCRASH1_ACCIDENT_CHAR','INVEST_MAEDE','',R.invest_maede);
    SELF.Investigation.InvestComplete := codes.KeyCodes('FLCRASH1_ACCIDENT_CHAR','INVEST_COMPLETE','',R.invest_complete);
    SELF.Investigation.SearchDate := iesp.ECL2ESP.toDatestring8 ((String8)TRIM(R.report_date,LEFT,RIGHT));
    SELF.Investigation.PhotosTaken := codes.KeyCodes('FLCRASH1_ACCIDENT_CHAR','PHOTOS_TAKEN','',R.photos_taken);
    SELF.Investigation.PhotosTakenWhom := codes.KeyCodes('FLCRASH1_ACCIDENT_CHAR','PHOTOS_TAKEN_WHOM','',R.photos_taken_whom);
    SELF.Investigation.FirstAidName := R.first_aid_name;
    SELF.Investigation.FirstAidPersonType := IF(R.first_aid_person_type!='',codes.keyCodes('FLCRASH1_ACCIDENT_CHAR','FIRST_AID_PERSON_TYPE','',R.first_aid_person_type),R.first_aid_person_type_desc);
    SELF.Investigation.InjuredTakenTo := IF(R.injured_taken_to!='',R.injured_taken_to,codes.KeyCodes('FLCRASH1_ACCIDENT_CHAR','INJURED_TAKEN_TO_CODE','',R.injured_taken_to_code));
    SELF.Investigation.InjuredTakenBy := R.injured_taken_by;
    SELF.Investigation.TypeDriverAccident := codes.KeyCodes('FLCRASH1_ACCIDENT_CHAR','TYPE_DRIVER_ACCIDENT','',R.type_driver_accident);
    SELF.Investigation.HourOfEMSNotified := R.hr_ems_notified;
    SELF.Investigation.MinuteOfEMSNotified := R.min_ems_notified;
    SELF.Investigation.HourOfEMSArrived := R.hr_ems_arrived;
    SELF.Investigation.MinuteOfEMSArrived := R.min_ems_arrived;

    SELF.Statistics.TotalTarDamage := R.total_tar_damage;
    SELF.Statistics.TotalvehicleDamage := R.total_vehicle_damage;
    SELF.Statistics.TotalPropertyDamage := R.total_prop_damage_amt;
    SELF.Statistics.TotalNumberOfPersons := (INTEGER)R.total_nbr_persons;
    SELF.Statistics.TotalNumberOfDrivers := (INTEGER)R.total_nbr_drivers;
    SELF.Statistics.TotalNumberOfVehicles := (INTEGER)R.total_nbr_vehicles;
    SELF.Statistics.TotalNumberOfFatalities := (INTEGER)R.total_nbr_fatalities;
    SELF.Statistics.TotalNumberOfNonTrafficFatal := (INTEGER)R.total_nbr_non_traffic_fatal;
    SELF.Statistics.TotalNumberOfInjuries := (INTEGER)R.total_nbr_injuries;
    SELF.Statistics.TotalNumberOfPedestrians := (INTEGER)R.total_nbr_pedestrian;
    SELF.Statistics.TotalNumberOfPedalcyclists := (INTEGER)R.total_nbr_pedalcyclist;

    SELF := L;
  END;

  // Key_eCrash2v (Vehicle/Owner)
  EXPORT Accident_services.Layouts.accVehRecWithAccNbr vehicleOwner(Accident_services.Layouts.report L,FLAccidents_eCrash.Key_eCrash2v R,BOOLEAN mask_dl=FALSE) := TRANSFORM
    SELF.accident_nbr := L.accident_nbr;
    SELF.Vehicle := R.section_nbr;
    SELF.OwnerDriver := codes.KeyCodes('FLCRASH2_VEHICLE','VEHICLE_OWNER_DRIVER_CODE','',R.vehicle_owner_driver_code);
    SELF.DriverAction := codes.KeyCodes('FLCRASH2_VEHICLE','VEHICLE_DRIVER_ACTION','',R.vehicle_driver_action);
    SELF.Year := (INTEGER)R.vehicle_year;
    SELF.Make := IF(R.make_description!='' AND R.make_description!=R.model_description,R.make_description,
      codes.KeyCodes('FLCRASH2_VEHICLE','MAKE_DESCRIPTION','',R.vehicle_make));
    SELF._Type := IF(R.vehicle_type!='',codes.KeyCodes('FLCRASH2_VEHICLE','VEHICLE_TYPE','',R.vehicle_type),R.vehicle_type_desc);
    SELF.TagNumber := R.vehicle_tag_nbr;
    SELF.RegisterState := R.vehicle_reg_state;
    SELF.IDNumber := R.vehicle_id_nbr;
    SELF.TravelOn := R.vehicle_travel_on;
    SELF.TravelDirection := IF(R.direction_travel!='',codes.KeyCodes('FLCRASH2_VEHICLE','DIRECTION_TRAVEL','',R.direction_travel),R.direction_travel_desc);
    SELF.EstimatedSpeed := R.est_vehicle_speed;
    SELF.PostedSpeed := R.posted_speed;
    SELF.EstimatedDamage := R.est_vehicle_damage;
    SELF.DamageType := codes.KeyCodes('FLCRASH2_VEHICLE','DAMAGE_TYPE','',R.damage_type);
    SELF.InsuranceCompany := R.ins_company_name;
    SELF.InsurancePolicyNumber := R.ins_policy_nbr;
    SELF.RemovedBy := R.vehicle_removed_by;
    SELF.HowRemoved := codes.KeyCodes('FLCRASH2_VEHICLE','HOW_REMOVED_CODE','',R.how_removed_code);
    SELF.PointOfImpact := IF(R.point_of_impact!='',codes.KeyCodes('FLCRASH2_VEHICLE','POINT_OF_IMPACT','',R.point_of_impact),R.point_of_impact_desc);
    SELF.Movement := codes.KeyCodes('FLCRASH2_VEHICLE','VEHICLE_MOVEMENT','',R.vehicle_movement);
    SELF._Function := codes.KeyCodes('FLCRASH2_VEHICLE','VEHICLE_FUNCTION','',R.vehicle_function);
    SELF.VehicleFirstDefect := codes.KeyCodes('FLCRASH2_VEHICLE','VEHS_FIRST_DEFECT','',R.vehs_first_defect);
    SELF.VehicleSecondDefect := codes.KeyCodes('FLCRASH2_VEHICLE','VEHS_SECOND_DEFECT','',R.vehs_second_defect);
    SELF.Modified := R.vehicle_modified;
    SELF.RoadwayLocation := codes.KeyCodes('FLCRASH2_VEHICLE','VEHICLE_ROADWAY_LOC','',R.vehicle_roadway_loc);
    SELF.HazardMaterialTransport := codes.KeyCodes('FLCRASH2_VEHICLE','HAZARD_MATERIAL_TRANSPORT','',R.hazard_material_transport);
    SELF.TotalOccupants := R.total_occu_vehicle;
    SELF.TotalSaftyEquipments := R.total_occu_saf_equip;
    SELF.MovingViolation := codes.KeyCodes('FLCRASH2_VEHICLE','MOVING_VIOLATION','',R.moving_violation);
    SELF.Insurance := '';
    SELF.Fault := codes.KeyCodes('FLCRASH2_VEHICLE','VEHICLE_FAULT_CODE','',R.vehicle_fault_code);
    SELF.Cap := R.vehicle_cap_code;
    SELF.FR := codes.KeyCodes('FLCRASH2_VEHICLE','VEHICLE_FR_CODE','',R.vehicle_fr_code);
    SELF.Use := IF(R.vehicle_use!='',codes.KeyCodes('FLCRASH2_VEHICLE','VEHICLE_USE','',R.vehicle_use),R.vehicle_use_desc);
    SELF.Placarded := codes.KeyCodes('FLCRASH2_VEHICLE','PLACARDED','',R.placarded);
    SELF.DhsmvInd := R.dhsmv_vehicle_ind;
    SELF.Model := R.model_description,
    SELF.Series := R.series_description;

    SELF.Owner.UniqueId := R.did;
    SELF.Owner.Name := iesp.ECL2ESP.SetName(R.fname,R.mname,R.lname,R.suffix,R.title);
    SELF.Owner.CompanyName := R.cname;
    SELF.Owner.DriverLicenseNumber := IF(mask_dl AND R.vehicle_owner_dl_nbr != '', suppress.dl_mask (R.vehicle_owner_dl_nbr), R.vehicle_owner_dl_nbr);
    SELF.Owner.DOB := iesp.ECL2ESP.toDatestring8 ((String8)TRIM(R.vehicle_owner_dob,LEFT,RIGHT));
    SELF.Owner.Sex := codes.KeyCodes('FLCRASH2_VEHICLE','VEHICLE_OWNER_SEX','',R.vehicle_owner_sex);
    SELF.Owner.Race := codes.KeyCodes('FLCRASH2_VEHICLE','VEHICLE_OWNER_RACE','',R.vehicle_owner_race);
    SELF.Owner.ForgeAsterisk := R.vehicle_owner_forge_asterisk;
    CountyName := IF(R.st!='' AND R.county!='', Accident_services.Functions.get_county_name(R.st, R.county),'');
    SELF.Owner.Address := iesp.ECL2ESP.SetAddress(R.prim_name,R.prim_range,R.predir,R.postdir,
        R.addr_suffix,R.unit_desig,R.sec_range,R.v_city_name,R.st,R.zip,R.zip4,countyname);

    SELF.report_code := R.report_code; //['A','FA'] Accident,FloridaAccident
    SELF.vehicle_incident_st := R.vehicle_incident_st;// Accident State

    SELF := [];
  END;

  // Key_eCrash3v (Towed Trailer)
  EXPORT Accident_services.Layouts.accVehRecWithAccNbr addTowedTrailerInfo(Accident_services.Layouts.accVehRecWithAccNbr L,FLAccidents_eCrash.Key_eCrash3v R) := TRANSFORM
    SELF.TowedTrailer.Year := (INTEGER)R.towed_trlr_veh_yr;
    SELF.TowedTrailer.Make := R.towed_trlr_make;
    SELF.TowedTrailer._Type := codes.KeyCodes('FLCRASH3_TOWED_TRAILER_VEH','TOWED_TRAILER_TYPE','',R.towed_trailer_type);
    SELF.TowedTrailer.TagNumber := R.towed_trlr_veh_tag_nbr;
    SELF.TowedTrailer.State := R.towed_trlr_veh_state;
    SELF.TowedTrailer.IDNumber := R.towed_trlr_veh_id_nbr;
    SELF.TowedTrailer.EstimatedDamage := R.towed_trlr_veh_est_damage;
    SELF.TowedTrailer.OwnerName := R.towed_trlr_veh_owner_name;
    SELF.TowedTrailer.OwnerNameSuffix := R.towed_trlr_veh_owner_name_suffix;
    SELF.TowedTrailer.OwnerCity := R.towed_trlr_veh_owner_st_city;
    SELF.TowedTrailer.OwnerState := R.towed_trlr_veh_owner_st;
    SELF.TowedTrailer.OwnerZip5 := R.towed_trlr_veh_owner_zip[1..5];
    SELF.TowedTrailer.FRCap := R.towed_trlr_fr_cap_code;
    SELF := L;
  END;

  // Key_eCrash4 (Driver)
  EXPORT Accident_services.Layouts.accVehRecWithAccNbr addDriverInfo(Accident_services.Layouts.accVehRecWithAccNbr L, FLAccidents_eCrash.Key_eCrash4 R,BOOLEAN mask_dl=FALSE) := TRANSFORM
    SELF.Driver.ResidentState := R.driver_resident_state;
    SELF.Driver.FirstSafety := codes.KeyCodes('FLCRASH4_DRIVER','FIRST_DRIVER_SAFETY','',R.first_driver_safety);
    SELF.Driver.SecondSafety := codes.KeyCodes('FLCRASH4_DRIVER','SECOND_DRIVER_SAFETY','',R.second_driver_safety);
    SELF.Driver.Eject := codes.KeyCodes('FLCRASH4_DRIVER','DRIVER_EJECT_CODE','',R.driver_eject_code);
    SELF.Driver.RecommandReExam := codes.KeyCodes('FLCRASH4_DRIVER','RECOMMAND_REEXAM','',R.recommand_reexam);
    SELF.Driver.PhoneNumber := R.driver_phone_nbr;
    SELF.Driver.DriverLicenseNumberGoodBad := codes.KeyCodes('FLCRASH4_DRIVER','DL_NBR_GOOD_BAD','',R.dl_nbr_good_bad);
    SELF.Driver.ReqEndorsement := codes.KeyCodes('FLCRASH4_DRIVER','REQ_ENDORSEMENT','',R.req_endorsement);
    SELF.Driver.OosDriverLicenseNumber := R.oos_dl_nbr;
    SELF.Driver.DriverLicense.LicenseNumber := IF(mask_dl AND R.driver_dl_nbr != '', suppress.dl_mask (R.driver_dl_nbr), R.driver_dl_nbr);
    SELF.Driver.DriverLicense.ForceAsterisk := R.driver_dl_force_asterisk;
    SELF.Driver.DriverLicense.LicenseState := R.driver_lic_st;
    SELF.Driver.DriverLicense.LicenseType := codes.KeyCodes('FLCRASH4_DRIVER','DRIVER_LIC_TYPE','',R.driver_lic_type);
    SELF.Driver.Individual.UniqueId := R.did;
    SELF.Driver.Individual.Name := iesp.ECL2ESP.SetName(R.fname,R.mname,R.lname,R.suffix,R.title);
    SELF.Driver.Individual.DOB := iesp.ECL2ESP.toDatestring8 ((String8)TRIM(R.driver_dob,LEFT,RIGHT));
    CountyName := IF(R.st!='' AND R.county!='', Functions.get_county_name(R.st, R.county),'');
    SELF.Driver.Individual.Address := iesp.ECL2ESP.SetAddress(R.prim_name,R.prim_range,R.predir,R.postdir,
        R.addr_suffix,R.unit_desig,R.sec_range,R.v_city_name,R.st,R.zip,R.zip4,countyname);
    SELF.Driver.Individual.Sex := IF(R.driver_sex!='',codes.KeyCodes('FLCRASH4_DRIVER','DRIVER_SEX','',R.driver_sex),R.driver_sex_desc);
    SELF.Driver.Individual.Race := IF(R.driver_race!='',codes.KeyCodes('FLCRASH4_DRIVER','DRIVER_RACE','',R.driver_race),R.driver_race_desc);
    SELF.Driver.Individual.FRInjuryCap := R.driver_fr_injury_cap_code;
    SELF.Driver.Individual.BACTestType := codes.KeyCodes('FLCRASH4_DRIVER','DRIVER_BAC_TEST_TYPE','',R.driver_bac_test_type);
    SELF.Driver.Individual.BACForce := R.driver_bac_force_code;
    SELF.Driver.Individual.BACTestResults := R.driver_bac_test_results;
    SELF.Driver.Individual.AlcoholDrug := codes.KeyCodes('FLCRASH4_DRIVER','DRIVER_ALCO_DRUG_CODE','',R.driver_alco_drug_code);
    SELF.Driver.Individual.PhysicalDefect := codes.KeyCodes('FLCRASH4_DRIVER','DRIVER_PHYSICAL_DEFECTS','',R.driver_physical_defects);
    SELF.Driver.Individual.Residence := IF(R.driver_residence!='',codes.KeyCodes('FLCRASH4_DRIVER','DRIVER_RESIDENCE','',R.driver_residence),R.driver_residence_desc);
    SELF.Driver.Individual.InjurySeverity := codes.KeyCodes('FLCRASH4_DRIVER','DRIVER_INJURY_SEVERITY','',R.driver_injury_severity);
    SELF.Driver.Individual.FirstContributeCause := codes.KeyCodes('FLCRASH4_DRIVER','FIRST_CONTRIB_CAUSE','',R.first_contrib_cause);
    SELF.Driver.Individual.SecondContributeCause := codes.KeyCodes('FLCRASH4_DRIVER','SECOND_CONTRIB_CAUSE','',R.second_contrib_cause);
    SELF.Driver.Individual.ThirdContributeCause := codes.KeyCodes('FLCRASH4_DRIVER','THIRD_CONTRIB_CAUSE','',R.third_contrib_cause);
    ChargedOffenses := DATASET([{R.first_offense_charged},{R.second_offense_charged},{R.third_offense_charged},{R.fourth_offense_charged},
      {R.fifth_offense_charged},{R.sixth_offense_charged},{R.seveth_offense_charged},{R.eighth_offense_charged}],iesp.share.t_StringArrayItem);
    SELF.Driver.Individual.ChargedOffenses := PROJECT(DEDUP(SORT(ChargedOffenses(value!=''),value),value),iesp.share.t_StringArrayItem);
    FRDLCharges := DATASET([{R.first_frdl_sys_charge_code},{R.second_frdl_sys_charge_code},{R.third_frdl_sys_charge_code},{R.fourth_frdl_sys_charge_code},
      {R.fifth_frdl_sys_charge_code},{R.sixth_frdl_sys_charge_code},{R.seveth_frdl_sys_charge_code},{R.eighth_frdl_sys_charge_code}],iesp.share.t_StringArrayItem);
    SELF.Driver.Individual.FRDLCharges := PROJECT(DEDUP(SORT(FRDLCharges(value!=''),value),value),iesp.share.t_StringArrayItem);
    Citations := DATASET([{R.first_citation_nbr},{R.second_citation_nbr},{R.third_citation_nbr},{R.fourth_citation_nbr},
      {R.fifth_citation_nbr},{R.sixth_citation_nbr},{R.seventh_citation_nbr},{R.eighth_citation_nbr}],iesp.share.t_StringArrayItem);
    SELF.Driver.Individual.Citations := PROJECT(DEDUP(SORT(Citations(value!=''),value),value),iesp.share.t_StringArrayItem);
    SELF.Driver.InsuranceCompany := R.ins_company_name;
    SELF.Driver.InsurancePolicyNumber := R.ins_policy_nbr;
    SELF := L;
  END;

  // Key_eCrash5 (Passengers)
  EXPORT iesp.accident.t_AccidentReportPassenger passengers(FLAccidents_eCrash.Key_eCrash5 L) := TRANSFORM
    SELF.Number := (INTEGER)L.passenger_nbr;
    SELF.Name := iesp.ECL2ESP.SetName(L.fname,L.mname,L.lname,L.suffix,L.title);
    SELF.Gender := '';
    CountyName := IF(L.st!='' AND L.county!='', Functions.get_county_name(L.st, L.county),'');
    SELF.Address := iesp.ECL2ESP.SetAddress(L.prim_name,L.prim_range,L.predir,L.postdir,
        L.addr_suffix,L.unit_desig,L.sec_range,L.v_city_name,L.st,L.zip,L.zip4,countyname);
    SELF.Age := (INTEGER)L.passenger_age;
    SELF.Location := codes.KeyCodes('FLCrash5_PASSENGER','PASSENGER_LOCATION','',L.passenger_location);
    SELF.InjurySeverity := codes.KeyCodes('FLCrash5_PASSENGER','PASSENGER_INJURY_SEV','',L.passenger_injury_sev);
    SELF.FirstPassengerSafe := codes.KeyCodes('FLCrash5_PASSENGER','FIRST_PASSENGER_SAFE','',L.first_passenger_safe);
    SELF.SecondPassengerSafe := codes.KeyCodes('FLCrash5_PASSENGER','SECOND_PASSENGER_SAFE','',L.second_passenger_safe);
    SELF.Eject := codes.KeyCodes('FLCrash5_PASSENGER','PASSENGER_EJECT_CODE','',L.passenger_eject_code);
    SELF.FRInjuryCap := L.passenger_fr_cap_code;
  END;

  // Key_eCrash6 (Pedestrians)
  EXPORT iesp.accident.t_AccidentReportPedestrian pedestrians(FLAccidents_eCrash.Key_eCrash6 L,BOOLEAN mask_dl=FALSE) := TRANSFORM
    SELF.Action := codes.KeyCodes('FLCRASH6_PEDESTRIAN','PED_ACTION','',L.ped_action);
    SELF.DriverlicenseNumber := IF(mask_dl AND L.ped_dl_nbr != '',suppress.dl_mask(L.ped_dl_nbr),L.ped_dl_nbr);
    SELF.Individual.UniqueId := L.did;
    SELF.Individual.Name := iesp.ECL2ESP.SetName(L.fname,L.mname,L.lname,L.suffix,L.title);
    SELF.Individual.DOB := iesp.ECL2ESP.toDatestring8 ((String8)TRIM(L.ded_dob,LEFT,RIGHT));
    CountyName := IF(L.st!='' AND L.county!='', Functions.get_county_name(L.st, L.county),'');
    SELF.Individual.Address := iesp.ECL2ESP.SetAddress(L.prim_name,L.prim_range,L.predir,L.postdir,
        L.addr_suffix,L.unit_desig,L.sec_range,L.v_city_name,L.st,L.zip,L.zip4,countyname);
    SELF.Individual.sex := IF(L.ped_sex!='',codes.KeyCodes('FLCRASH6_PEDESTRIAN','PED_SEX','',L.ped_sex),L.ped_sex_desc);
    SELF.Individual.race := IF(L.ped_race!='',codes.KeyCodes('FLCRASH6_PEDESTRIAN','PED_RACE','',L.ped_race),L.ped_race_desc);
    SELF.Individual.FRInjuryCap := L.ped_fr_injury_cap;
    SELF.Individual.BACtestType := codes.KeyCodes('FLCRASH6_PEDESTRIAN','PED_BAC_TEST_TYPE','',L.ped_bac_test_type);
    SELF.Individual.BACForce := L.ped_bac_force_code;
    SELF.Individual.BACTestResults := L.ped_bac_results;
    SELF.Individual.AlcoholDrug := codes.KeyCodes('FLCRASH6_PEDESTRIAN','PED_ALCO_DRUGS','',L.ped_alco_drugs);
    SELF.Individual.PhysicalDefect := codes.KeyCodes('FLCRASH6_PEDESTRIAN','PED_PHYSICAL_DEFECT','',L.ped_physical_defect);
    SELF.Individual.Residence := codes.KeyCodes('FLCRASH6_PEDESTRIAN','PD_RESIDENCE','',L.ped_residence);
    SELF.Individual.InjurySeverity := codes.KeyCodes('FLCRASH6_PEDESTRIAN','PED_INJURY_SEV','',L.ped_injury_sev);
    SELF.Individual.FirstContributeCause := codes.KeyCodes('FLCRASH6_PEDESTRIAN','PED_FIRST_CONTRIB_CAUSE','',L.ped_first_contrib_cause);
    SELF.Individual.SecondContributeCause := codes.KeyCodes('FLCRASH6_PEDESTRIAN','PED_SECOND_CONTRIB_CAUSE','',L.ped_second_contrib_cause);
    SELF.Individual.ThirdContributeCause := codes.KeyCodes('FLCRASH6_PEDESTRIAN','PED_THIRD_CONTRIB_CAUSE','',L.ped_third_contrib_cause);
    ChargedOffenses := DATASET([{L.first_offense_charged},{L.second_offense_charged},{L.third_offense_charged},{L.fourth_offense_charged},
      {L.fifth_offense_charged},{L.sixth_offense_charged},{L.seventh_offense_charged},{L.eighth_offense_charged}],iesp.share.t_StringArrayItem);
    SELF.Individual.ChargedOffenses := PROJECT(DEDUP(SORT(ChargedOffenses(value!=''),value),value),iesp.share.t_StringArrayItem);
    FRDLCharges := DATASET([{L.first_frdl_sys_charge_code},{L.second_frdl_sys_charge_code},{L.third_frdl_sys_charge_code},{L.fourth_frdl_sys_charge_code},
      {L.fifth_frdl_sys_charge_code},{L.sixth_sys_charge_code},{L.seventh_sys_charge_code},{L.eighth_sys_charge_code}],iesp.share.t_StringArrayItem);
    SELF.Individual.FRDLCharges := PROJECT(DEDUP(SORT(FRDLCharges(value!=''),value),value),iesp.share.t_StringArrayItem);
    Citations := DATASET([{L.first_citation_nbr},{L.second_citation_nbr},{L.third_citation_nbr},{L.fourth_citation_issued},
      {L.fifth_citation_issued},{L.sixth_citation_issued},{L.seventh_citation_issued},{L.eighth_citation_issued}],iesp.share.t_StringArrayItem);
    SELF.Individual.Citations := PROJECT(DEDUP(SORT(Citations(value!=''),value),value),iesp.share.t_StringArrayItem);
  END;

  // Key_eCrash7 (Property Damage)
  EXPORT iesp.accident.t_AccidentReportPropertyDamage propertyDamage(FLAccidents_eCrash.Key_eCrash7 L) := TRANSFORM
    SELF.PropertyDamageNumber := L.prop_damage_nbr;
    SELF.PropertyDamaged := L.prop_damaged;
    SELF.PropertyDamageAmount := L.prop_damage_amount;
    SELF.FRFixedObjectCap := L.fr_fixed_object_cap_code;
    SELF.Owner.Name := iesp.ECL2ESP.SetName(L.fname,L.mname,L.lname,L.suffix,L.title);
    SELF.Owner.Gender := '';
    SELF.Owner.CompanyName := L.cname;
    CountyName := IF(L.st!='' AND L.county!='', Functions.get_county_name(L.st, L.county),'');
    SELF.Owner.Address := iesp.ECL2ESP.SetAddress(L.prim_name,L.prim_range,L.predir,L.postdir,
        L.addr_suffix,L.unit_desig,L.sec_range,L.v_city_name,L.st,L.zip,L.zip4,countyname);
  END;

  // Key_eCrash5 (Passengers)
  EXPORT Accident_services.Layouts.accVehRecWithAccNbr addPassengerChildren(Accident_services.Layouts.accVehRecWithAccNbr L,DATASET(RECORDOF(FLAccidents_eCrash.Key_eCrash5)) R) := TRANSFORM
    SELF.Passengers := CHOOSEN(DEDUP(SORT(PROJECT(R,passengers(LEFT)),RECORD),RECORD),iesp.constants.ACCIDENTS_MAX_COUNT_PASSENGERS);
    SELF := L;
  END;

  // Key_eCrash2v (Vehicle Basic/Owner Info)
  EXPORT Accident_services.Layouts.accRptRecWithAccNbr addVehicleChildren(Accident_services.Layouts.accRptRecWithAccNbr L,DATASET(Accident_services.Layouts.accVehRecWithAccNbr) R) := TRANSFORM
    SELF.Vehicles := CHOOSEN(DEDUP(SORT(PROJECT(R,iesp.accident.t_AccidentReportVehicle),RECORD),RECORD),iesp.constants.ACCIDENTS_MAX_COUNT_VEHICLES);
    SELF := L;
  END;

  // Key_eCrash6 (Pedestrians)
  EXPORT Accident_services.Layouts.accRptRecWithAccNbr addPedestrianChildren(Accident_services.Layouts.accRptRecWithAccNbr L,DATASET(RECORDOF(FLAccidents_eCrash.Key_eCrash6)) R,BOOLEAN mask_dl=FALSE) := TRANSFORM
    SELF.Pedestrians := CHOOSEN(DEDUP(SORT(PROJECT(R,pedestrians(LEFT,mask_dl)),RECORD),RECORD),iesp.constants.ACCIDENTS_MAX_COUNT_PEDESTRIANS);
    SELF := L;
  END;

  // Key_eCrash7 (Property Damage)
  EXPORT Accident_services.Layouts.accRptRecWithAccNbr addPropertyDamageChildren(Accident_services.Layouts.accRptRecWithAccNbr L,DATASET(RECORDOF(FLAccidents_eCrash.Key_eCrash7)) R) := TRANSFORM
    SELF.PropertyDamages := CHOOSEN(DEDUP(SORT(PROJECT(R,propertyDamage(LEFT)),RECORD),RECORD),iesp.constants.ACCIDENTS_MAX_COUNT_PROP_DAMAGES);
    SELF := L;
  END;

  // Key_eCrashV2_accnbr
  EXPORT iesp.accident.t_AccidentSearchRecord searchRecord(Accident_services.Layouts.raw_rec L) := TRANSFORM
    SELF.Name := iesp.ECL2ESP.SetName(L.fname,L.mname,L.lname,L.name_suffix,L.title);
    SELF.Address := iesp.ECL2ESP.SetAddress(L.prim_name,L.prim_range,L.predir,L.postdir,
        L.addr_suffix,L.unit_desig,L.sec_range,L.v_city_name,L.st,L.zip,L.zip4,'');
    SELF.CompanyName := L.cname;
    SELF.RecordType := L.record_type;
    SELF.DriverLicenseNumber := L.driver_license_nbr;
    SELF.DriverLicenseState := L.dlnbr_st;
    SELF.VIN := L.vin;
    SELF.TagNumber := L.tag_nbr;
    SELF.TagState := L.tagnbr_st;
    SELF.AccidentNumber := L.l_accnbr;
    SELF.AccidentState := L.vehicle_incident_st;
    SELF.AccidentDate := iesp.ECL2ESP.toDatestring8((String8)TRIM(L.accident_date,LEFT,RIGHT));
    SELF.GenerateReport := L.vehicle_incident_st IN Constants.Report_States;
    SELF._penalty := L.penalt;
    SELF.AlsoFound := L.isDeepDive;
    SELF.pdfImageHash := L.image_hash;
    SELF.tifImageHash := L.tif_image_hash;
    SELF.HasCoverSheet := L.Report_Has_Coversheet='1';
  END;

END;
