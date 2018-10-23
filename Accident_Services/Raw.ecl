import AutoStandardI, doxie, FLAccidents_eCrash, doxie_crs, codes, Census_Data, suppress, ut, Accident_services, STD;

export Raw := MODULE

	export byDIDs(dataset(Accident_services.layouts.search_did) in_dids) := function 
			deduped := dedup(sort(in_dids,did),did);
			joinup := join(deduped,FLAccidents_eCrash.Key_eCrashV2_did,
			               keyed(left.did=right.l_did),
										 transform(Accident_services.layouts.search,
				                       self := left,
															 self := right),LIMIT(Accident_services.Constants.MAX_RECS_ON_JOIN,skip)); 
			return joinup;
	end;
		
	export byBDIDs(dataset(Accident_services.layouts.search_bdid) in_bdids) := function
			deduped := dedup(sort(in_bdids,bdid),bdid);
			joinup := join(deduped,FLAccidents_eCrash.key_eCrashV2_bdid,
			               keyed(left.bdid=right.l_bdid),
										 transform(Accident_services.layouts.search,
				                       self := left,
															 self := right),LIMIT(Accident_services.Constants.MAX_RECS_ON_JOIN,skip)); 
			return joinup;
	end;	
	
	export byDLNbr(dataset(Accident_services.layouts.search_dlnbr) in_dlnbr) := function 
			deduped := dedup(sort(in_dlnbr,dlnbr),dlnbr);
			joinup := join(deduped,FLAccidents_eCrash.Key_eCrashV2_DLNbr,
			               keyed(left.dlnbr=right.l_dlnbr),
										 transform(Accident_services.layouts.search,
				                       self := left,
															 self := right),LIMIT(Accident_services.Constants.MAX_RECS_ON_JOIN,skip));
			return joinup;
	end;
	
	export byTagNbr(dataset(Accident_services.layouts.search_tagnbr) in_tagnbr) := function 
			deduped := dedup(sort(in_tagnbr,tagnbr),tagnbr);
			joinup := join(deduped,FLAccidents_eCrash.Key_eCrashV2_tagnbr,
			               keyed(left.tagnbr=right.l_tagnbr),
										 transform(Accident_services.layouts.search,
				                       self := left,
															 self := right),LIMIT(Accident_services.Constants.MAX_RECS_ON_JOIN,skip));
			return joinup;
	end;
	
	export byVIN(dataset(Accident_services.layouts.search_vin) in_vin) := function 
			deduped := dedup(sort(in_vin,vin),vin);
			joinup := join(deduped,FLAccidents_eCrash.Key_eCrashV2_vin,
			               keyed(left.vin=right.l_vin),
										 transform(Accident_services.layouts.search,
				                       self := left,
															 self := right),LIMIT(Accident_services.Constants.MAX_RECS_ON_JOIN,skip));
			return joinup;
	end;

	export byAccNbr (dataset (Accident_services.layouts.search) in_accnbrs, Accident_services.IParam.searchRecords in_mod) := function
			deduped := dedup(sort(in_accnbrs,accident_nbr),accident_nbr);
						
			// MobileTrac and Claims Discovery data filters business requirements
			rptCodeSet := if(in_mod.EnableExtraAccidents,Accident_services.constants.rptCodeSet+Accident_services.constants.eCrashAccident_source,Accident_services.constants.rptCodeSet);
			vStatusSet := Accident_services.constants.vStatusSet; // VIN has been validated
			FLAccident_source := Accident_services.constants.FLAccident_source;
						
			recs_ntl := join(deduped,FLAccidents_eCrash.Key_eCrashV2_accnbrV1,
										keyed(left.accident_nbr=right.l_accnbr) and
										right.report_code in rptCodeSet and
										right.vehicle_status in vStatusSet,
										limit(Accident_services.Constants.MAX_RECS_ON_JOIN));
			
			recs_fla := join(deduped,FLAccidents_eCrash.Key_eCrashV2_accnbrV1,
										 keyed(left.accident_nbr=right.l_accnbr) and right.report_code in FLAccident_source,
										 limit(Accident_services.Constants.MAX_RECS_ON_JOIN, skip));						
			
			return if (in_mod.EnableNationalAccidents,recs_ntl,recs_fla);
	end;

	EXPORT byAccNbrSrch (DATASET(Accident_services.layouts.search) accnbrs, Accident_services.IParam.searchRecords in_mod) := FUNCTION
		deduped := DEDUP(SORT(accnbrs,accident_nbr),accident_nbr);
		// Join deduped input ids (accident numbers) to main acc_nbr key file on accident_nbr
		accidentRecs := 
			JOIN(deduped,FLAccidents_eCrash.Key_eCrashV2_accnbrV1,
			KEYED(LEFT.accident_nbr=RIGHT.l_accnbr)
			AND RIGHT.report_code IN Accident_services.constants.FLAccident_source+Accident_services.constants.NtlAccident_source+Accident_services.constants.eCrashAccident_source,
			TRANSFORM(Accident_services.Layouts.raw_rec,SELF.isDeepDive:=LEFT.isDeepDive,SELF:=RIGHT,SELF:=[]),
			LIMIT(Accident_services.Constants.MAX_RECS_ON_JOIN, SKIP));

		// filter by accident state requested
		accRecsFilterState := IF((in_mod.EnableNationalAccidents OR in_mod.EnableExtraAccidents) AND in_mod.Accident_State!='',
			accidentRecs(vehicle_incident_st=STD.Str.ToUpperCase(in_mod.Accident_State)),
			accidentRecs);

		// Filter records where states require a DPPA permissible purpose
		accRecsFilterDPPA := IF((in_mod.EnableNationalAccidents OR in_mod.EnableExtraAccidents) AND ~Accident_services.Functions.allowDPPA(),
			accRecsFilterState(vehicle_incident_st NOT IN Accident_services.Constants.DPPA_States),accRecsFilterState);

		// Apply state restrictions national accidents
		accRecsRestricted := Accident_services.StateRestrictionsFunctions.applyRestrictions(in_mod,accRecsFilterDPPA);

		// combine sources
		nationalAccidents := IF(in_mod.EnableNationalAccidents AND in_mod.ApplicationType!='',accRecsRestricted(report_code IN Accident_services.Constants.NtlAccident_source));
		eCrashAccidents := IF(in_mod.EnableExtraAccidents,accRecsFilterDPPA(report_code IN Accident_services.Constants.eCrashAccident_source));
		recs := accRecsFilterDPPA(report_code IN Accident_services.Constants.FLAccident_source)+nationalAccidents+eCrashAccidents;

		// Calculate the penalty on the records
		recs_plus_pen := PROJECT(recs,TRANSFORM(Accident_services.Layouts.raw_rec,
			tempindvmod := MODULE(PROJECT(in_mod,AutoStandardI.LIBIN.PenaltyI_Indv.full,OPT))
				EXPORT allow_wildcard := FALSE;
				EXPORT fname_field    := LEFT.fname;
				EXPORT mname_field    := LEFT.mname;
				EXPORT lname_field    := LEFT.lname;
				EXPORT prange_field   := LEFT.prim_range;
				EXPORT predir_field   := LEFT.predir;
				EXPORT pname_field    := LEFT.prim_name;
				EXPORT suffix_field   := LEFT.addr_suffix;
				EXPORT postdir_field  := LEFT.postdir;
				EXPORT sec_range_field  := LEFT.sec_range ;
				EXPORT city_field     := LEFT.v_city_name;
				EXPORT city2_field    := '';
				EXPORT state_field    := LEFT.st;
				EXPORT zip_field      := LEFT.zip;
				// set fields not input to null
				EXPORT ssn_field      := '';
				EXPORT did_field      := LEFT.did;
				EXPORT dob_field      := '';
				EXPORT phone_field    := '';
				EXPORT county_field   := '';
			END;

			tempbizmod := MODULE(PROJECT(in_mod,AutoStandardI.LIBIN.PenaltyI_Biz.full,OPT))
				EXPORT allow_wildcard := FALSE;
				EXPORT cname_field    := LEFT.cname;
				EXPORT prange_field   := LEFT.prim_range;
				EXPORT predir_field   := LEFT.predir;
				EXPORT pname_field    := LEFT.prim_name;
				EXPORT suffix_field   := LEFT.addr_suffix;
				EXPORT postdir_field  := LEFT.postdir;
				EXPORT sec_range_field  := LEFT.sec_range ;
				EXPORT city_field     := LEFT.v_city_name;
				EXPORT city2_field    := '';
				EXPORT state_field    := LEFT.st;
				EXPORT zip_field      := LEFT.zip;
				// set fields not input to null
				EXPORT fein_field     := '';
				EXPORT bdid_field     := LEFT.b_did;
				EXPORT county_field   := '';
				EXPORT phone_field    := '';
			END;

			tempPenaltIndv := AutoStandardI.LIBCALL_PenaltyI_Indv.val(tempindvmod);
			//Only use vals unique to biz so addr penalty doesn't get counted twice.
			tempPenaltBiz := AutoStandardI.LIBCALL_PenaltyI_Biz.val_biz_name(tempbizmod) + 
							 AutoStandardI.LIBCALL_PenaltyI_Biz.val_bdid(tempbizmod);

			// if its deepdive, don't apply the penalty
			SELF.penalt := IF(LEFT.isDeepDive,0,tempPenaltIndv+tempPenaltBiz),
			SELF := LEFT));

		// Don't return records for certain DIDs
		Suppress.MAC_Suppress(recs_plus_pen,recs_pulled,in_mod.ApplicationType,Suppress.Constants.LinkTypes.DID,did);

		RETURN recs_pulled;
	END;

	EXPORT CrsAccidentRpt(DATASET(Doxie.layout_references) dids, Accident_services.IParam.searchRecords in_mod) := FUNCTION
  
  Boolean isCNSMR := in_mod.IndustryClass= 'CNSMR';

		layout_report := doxie_crs.layout_FLCrash_Search_Records;
		layout_time_location := doxie_crs.layout_FSR_time_location;
		layout_accident := doxie_crs.layout_FSR_accident_char;
		layout_vehicle := doxie_crs.layout_FSR_vehicle;
		layout_driver := doxie_crs.layout_FSR_driver;
		layout_passenger := doxie_crs.layout_FSR_passenger;
		layout_pedestrian := doxie_crs.layout_FSR_pedestrian;
		layout_did_acc_nbr := record
			recordof(FLAccidents_eCrash.Key_eCrashV2_did);
			string2 report_code;
			string2 vehicle_incident_st;
		end;

		layout_report initReport(layout_did_acc_nbr L) := TRANSFORM
			SELF.accident_nbr := L.accident_nbr;
			SELF.accident_state := L.vehicle_incident_st;
			SELF := [];
		END;

		layout_time_location into_tl(FLAccidents_eCrash.Key_eCrash0 L) := TRANSFORM
			SELF.city_nbr_name := codes.FLCRASH0_TIME_LOCATION.CITY_NBR(L.city_nbr);
			SELF.type_fr_case_name := codes.FLCRASH0_TIME_LOCATION.TYPE_FR_CASE(L.type_fr_case);
			SELF.action_code_name := codes.FLCRASH0_TIME_LOCATION.ACTION_CODE(L.action_code);
			SELF.county_nbr_name := codes.FLCRASH0_TIME_LOCATION.COUNTY_NBR(L.city_nbr[1..2]);
			SELF.ft_miles_code1 := '';
			SELF.ft_miles_code2 := '';
			SELF := L;
		END; 

		layout_accident into_ac(FLAccidents_eCrash.Key_eCrash1 L) := TRANSFORM
			SELF.First_Harmful_Event_Name := IF(L.first_harmful_event!='',codes.FLCRASH1_ACCIDENT_CHAR.FIRST_HARMFUL_EVENT(L.FIRST_HARMFUL_EVENT),L.first_harmful_event_desc);
			SELF.Subs_Harmful_Event_Name := codes.FLCRASH1_ACCIDENT_CHAR.SUBS_HARMFUL_EVENT(L.SUBS_HARMFUL_EVENT);
			SELF.Light_Condition_Name := IF(L.light_condition!='',codes.FLCRASH1_ACCIDENT_CHAR.LIGHT_CONDITION(L.LIGHT_CONDITION),L.light_condition_desc);
			SELF.Weather_Name := IF(L.weather!='',codes.FLCRASH1_ACCIDENT_CHAR.WEATHER(L.WEATHER),L.weather_desc);
			SELF.Rd_Surface_Condition_Name := IF(L.rd_surface_condition!='',codes.FLCRASH1_ACCIDENT_CHAR.RD_SURFACE_CONDITION(L.RD_SURFACE_CONDITION),L.rd_surface_condition_desc);
			SELF.First_Contrib_Envir_Name := IF(L.first_contrib_envir!='',codes.FLCRASH1_ACCIDENT_CHAR.FIRST_CONTRIB_ENVIR(L.FIRST_CONTRIB_ENVIR),L.first_contrib_envir_desc);
			SELF.Second_Contrib_Envir_Name := IF(L.second_contrib_envir_desc!='',codes.FLCRASH1_ACCIDENT_CHAR.SECOND_CONTRIB_ENVIR(L.SECOND_CONTRIB_ENVIR),L.second_contrib_envir_desc);
			SELF.First_Traffic_Control_Name := IF(L.first_traffic_control!='',codes.FLCRASH1_ACCIDENT_CHAR.FIRST_TRAFFIC_CONTROL(L.FIRST_TRAFFIC_CONTROL),L.first_traffic_control_desc);
			SELF.Second_Traffic_Control_Name := IF(L.second_traffic_control!='',codes.FLCRASH1_ACCIDENT_CHAR.SECOND_TRAFFIC_CONTROL(L.SECOND_TRAFFIC_CONTROL),L.second_traffic_control_desc);
			SELF.Invest_Agency_Name := IF(L.invest_agency!='',codes.FLCRASH1_ACCIDENT_CHAR.INVEST_AGENCY(L.INVEST_AGENCY),L.invest_agency_desc);
			SELF.Accident_Injury_Severity_Name := codes.FLCRASH1_ACCIDENT_CHAR.ACCIDENT_INJURY_SEVERITY(L.ACCIDENT_INJURY_SEVERITY);
			SELF.Accident_Damage_Severity_Name := IF(L.accident_damage_severity!='',codes.FLCRASH1_ACCIDENT_CHAR.ACCIDENT_DAMAGE_SEVERITY(L.ACCIDENT_DAMAGE_SEVERITY),L.accident_damage_severity_desc);
			SELF.Alcohol_Drug_Name := IF(L.alcohol_drug!='',codes.FLCRASH1_ACCIDENT_CHAR.ALCOHOL_DRUG(L.ALCOHOL_DRUG),L.alcohol_drug_desc);
			SELF.rural_urban_code_name := codes.FLCRASH1_ACCIDENT_CHAR.RURAL_URBAN_CODE(L.RURAL_URBAN_CODE);
			SELF.accident_insur_code_name := codes.FLCRASH1_ACCIDENT_CHAR.ACCIDENT_INSUR_CODE(L.ACCIDENT_INSUR_CODE);
			SELF.accident_fault_code_name := IF(L.accident_fault_code!='',codes.FLCRASH1_ACCIDENT_CHAR.ACCIDENT_FAULT_CODE(L.ACCIDENT_FAULT_CODE),L.accident_fault_code_desc);
			SELF.type_driver_accident_name := codes.FLCRASH1_ACCIDENT_CHAR.TYPE_DRIVER_ACCIDENT(L.TYPE_DRIVER_ACCIDENT);
			SELF.day_week_name := IF(L.day_week!='',MAP(
				L.day_week = '1' => 'MONDAY',
				L.day_week = '2' => 'TUESDAY',
				L.day_week = '3' => 'WEDNESDAY',
				L.day_week = '4' => 'THURSDAY',
				L.day_week = '5' => 'FRIDAY',
				L.day_week = '6' => 'SATURDAY',
				'SUNDAY'),L.day_week_desc);
			SELF.site_loc_name := codes.FLCRASH1_ACCIDENT_CHAR.SITE_LOC(L.site_loc);
			SELF.on_off_roadway_name := codes.FLCRASH1_ACCIDENT_CHAR.ON_OFF_ROADWAY(L.on_off_roadway);
			SELF.rd_surface_type_name := IF(L.rd_surface_type!='',codes.FLCRASH1_ACCIDENT_CHAR.RD_SURFACE_TYPE(L.rd_surface_type),L.rd_surface_type_desc);
			SELF.type_shoulder_name := IF(L.type_shoulder!='',codes.FLCRASH1_ACCIDENT_CHAR.TYPE_SHOULDER(L.type_shoulder),L.type_shoulder_desc);
			SELF.first_contrib_cause_name := IF(L.first_contrib_cause!='',codes.FLCRASH1_ACCIDENT_CHAR.FIRST_CONTRIB_CAUSE(L.first_contrib_cause),L.first_contrib_cause_desc);
			SELF.second_contrib_cause_name := IF(L.second_contrib_cause!='',codes.FLCRASH1_ACCIDENT_CHAR.SECOND_CONTRIB_CAUSE(L.second_contrib_cause),L.second_contrib_cause_desc);
			SELF.trafficway_char_name := codes.FLCRASH1_ACCIDENT_CHAR.TRAFFICWAY_CHAR(L.trafficway_char);
			SELF.divided_undivided_name := codes.FLCRASH1_ACCIDENT_CHAR.DIVIDED_UNDIVIDED(L.divided_undivided);
			SELF.rd_sys_id_name := codes.FLCRASH1_ACCIDENT_CHAR.RD_SYS_ID(L.rd_sys_id);
			SELF.invest_complete_name := codes.KeyCodes('FLCRASH1_ACCIDENT_CHAR','INVEST_COMPLETE','',L.invest_complete);
			SELF.location_type_name := IF(L.location_type!='',codes.KeyCodes('FLCRASH1_ACCIDENT_CHAR','LOCATION_TYPE','',L.LOCATION_TYPE),L.location_type_desc);
			SELF.injured_taken_to_code_name := codes.KeyCodes('FLCRASH1_ACCIDENT_CHAR','INJURED_TAKEN_TO_CODE','',L.injured_taken_to_code);
			SELF.photos_taken_name := codes.KeyCodes('FLCRASH1_ACCIDENT_CHAR','PHOTOS_TAKEN',     '',L.photos_taken);
			SELF.photos_taken_whom_name := codes.KeyCodes('FLCRASH1_ACCIDENT_CHAR','PHOTOS_TAKEN_WHOM','',L.photos_taken_whom);
			SELF := L;
		END;	

		layout_vehicle into_veh(FLAccidents_eCrash.Key_eCrash2v L, Census_Data.Key_Fips2County R) := TRANSFORM
			SELF.Vehicle_Type_Name := IF(L.vehicle_type!='',codes.FLCRASH2_VEHICLE.VEHICLE_TYPE(L.VEHICLE_TYPE),L.vehicle_type_desc);
			SELF.Vehicle_Reg_State_Name := codes.GENERAL.STATE_LONG(L.VEHICLE_REG_STATE);
			SELF.Direction_Travel_Name := IF(L.direction_travel!='',codes.FLCRASH2_VEHICLE.DIRECTION_TRAVEL(L.DIRECTION_TRAVEL),L.direction_travel_desc);
			SELF.Damage_Type_Name := codes.FLCRASH2_VEHICLE.DAMAGE_TYPE(L.DAMAGE_TYPE);
			SELF.Vehicle_Owner_Sex_Name := codes.FLCRASH2_VEHICLE.VEHICLE_OWNER_SEX(L.VEHICLE_OWNER_SEX);
			SELF.Vehicle_Owner_Race_Name := codes.FLCRASH2_VEHICLE.VEHICLE_OWNER_RACE(L.VEHICLE_OWNER_RACE);
			SELF.Point_of_Impact_Name := IF(L.point_of_impact!='',codes.FLCRASH2_VEHICLE.POINT_OF_IMPACT(L.POINT_OF_IMPACT),L.point_of_impact_desc);
			SELF.Vehicle_Movement_Name := codes.FLCRASH2_VEHICLE.VEHICLE_MOVEMENT(L.VEHICLE_MOVEMENT);
			SELF.Vehs_First_Defect_Name := codes.FLCRASH2_VEHICLE.VEHS_FIRST_DEFECT(L.VEHS_FIRST_DEFECT);
			SELF.Vehs_Second_Defect_Name := codes.FLCRASH2_VEHICLE.VEHS_SECOND_DEFECT(L.VEHS_SECOND_DEFECT);
			SELF.Moving_Violation_Name := codes.FLCRASH2_VEHICLE.MOVING_VIOLATION(L.MOVING_VIOLATION);
			SELF.Vehicle_Fault_Code_Name := codes.FLCRASH2_VEHICLE.VEHICLE_FAULT_CODE(L.VEHICLE_FAULT_CODE);
			SELF.vehicle_fr_code_name := codes.FLCRASH2_VEHICLE.VEHICLE_FR_CODE(L.VEHICLE_FR_CODE);
			SELF.vehicle_insur_code_name := MAP(
				STD.Str.ToUpperCase(L.vehicle_insur_code) = 'U' => 'Vehicle Un-Insured',
				STD.Str.ToUpperCase(L.vehicle_insur_code) = 'I' => 'Vehicle Insured',
				'');
			SELF.vehicle_driver_action_name := codes.FLCRASH2_VEHICLE.VEHICLE_DRIVER_ACTION(L.VEHICLE_DRIVER_ACTION);
			SELF.vehicle_owner_driver_code_name := codes.FLCRASH2_VEHICLE.VEHICLE_OWNER_DRIVER_CODE(L.VEHICLE_OWNER_DRIVER_CODE);
			SELF.how_removed_code_name := codes.FLCRASH2_VEHICLE.HOW_REMOVED_CODE(L.HOW_REMOVED_CODE);
			SELF.hazard_material_transport_name := codes.FLCRASH2_VEHICLE.HAZARD_MATERIAL_TRANSPORT(L.hazard_material_transport);
			SELF.vehicle_use_Name := IF(L.vehicle_use!='',codes.FLCRASH2_VEHICLE.vehicle_use(L.vehicle_use),L.vehicle_use_desc);
			SELF.placarded_Name := codes.FLCRASH2_VEHICLE.placarded(L.placarded);
			SELF.vehicle_roadway_loc_Name := codes.FLCRASH2_VEHICLE.vehicle_roadway_loc(L.vehicle_roadway_loc);
			SELF.vehicle_function_name := codes.FLCRASH2_VEHICLE.vehicle_function(L.vehicle_function);
			SELF.county_name := R.county_name;
			SELF := L;
		END;

		RECORDOF(FLAccidents_eCrash.Key_eCrash3v) into_tt(FLAccidents_eCrash.Key_eCrash3v L) := TRANSFORM
			SELF := L;
		END;

		layout_driver into_driver(FLAccidents_eCrash.Key_eCrash4 L, Census_Data.Key_Fips2County R) := TRANSFORM
			SELF.DL_State_Name := codes.GENERAL.STATE_LONG(L.DRIVER_LIC_ST);
			SELF.DL_Type_Name := codes.FLCRASH4_DRIVER.DRIVER_LIC_TYPE(L.DRIVER_LIC_TYPE);
			SELF.Driver_alco_drug_code_Name := codes.FLCRASH4_DRIVER.DRIVER_ALCO_DRUG_CODE(L.DRIVER_ALCO_DRUG_CODE);
			SELF.Driver_Physical_defects_code_Name := codes.FLCRASH4_DRIVER.DRIVER_PHYSICAL_DEFECTS(L.DRIVER_PHYSICAL_DEFECTS);
			SELF.Driver_Injury_Severity_Name := codes.FLCRASH4_DRIVER.DRIVER_INJURY_SEVERITY(L.DRIVER_INJURY_SEVERITY);
			SELF.First_Driver_Safety_Name := codes.FLCRASH4_DRIVER.FIRST_DRIVER_SAFETY(L.FIRST_DRIVER_SAFETY);
			SELF.First_Contrib_Cause_Name := codes.FLCRASH4_DRIVER.FIRST_CONTRIB_CAUSE(L.FIRST_CONTRIB_CAUSE);
			SELF.Second_Contrib_Cause_Name := codes.FLCRASH4_DRIVER.SECOND_CONTRIB_CAUSE(L.SECOND_CONTRIB_CAUSE);
			SELF.Third_Contrib_Cause_Name := codes.FLCRASH4_DRIVER.THIRD_CONTRIB_CAUSE(L.THIRD_CONTRIB_CAUSE);
			SELF.Dl_nbr_Good_Bad_Name := codes.FLCRASH4_DRIVER.DL_NBR_GOOD_BAD(L.DL_NBR_GOOD_BAD);
			SELF.second_driver_safety_name := codes.FLCRASH4_DRIVER.SECOND_DRIVER_SAFETY(L.SECOND_DRIVER_SAFETY);
			SELF.driver_eject_code_name := codes.FLCRASH4_DRIVER.DRIVER_EJECT_CODE(L.DRIVER_EJECT_CODE);
			SELF.county_name := R.county_name;
			SELF.driver_sex_name := IF(L.driver_sex!='',codes.FLCRASH4_DRIVER.DRIVER_SEX(L.driver_sex),L.driver_sex_desc);
			SELF.driver_race_name := IF(L.driver_race!='',codes.FLCRASH4_DRIVER.DRIVER_RACE(L.driver_race),L.driver_race_desc);
			SELF.driver_bac_test_type_name := codes.FLCRASH4_DRIVER.DRIVER_BAC_TEST_TYPE(L.driver_bac_test_type);
			SELF.driver_physical_defects_name := codes.FLCRASH4_DRIVER.DRIVER_PHYSICAL_DEFECTS(L.driver_physical_defects);
			SELF.driver_residence_name := IF(L.driver_residence!='',codes.FLCRASH4_DRIVER.DRIVER_RESIDENCE(L.driver_residence),L.driver_residence_desc);
			SELF.recommand_reexam_name := codes.FLCRASH4_DRIVER.recommand_reexam(L.recommand_reexam);
			SELF.req_endorsement_name := CASE((UNSIGNED2)L.req_endorsement, 1 => 'Yes', 2=> 'No', '');
			SELF := L;
		END;

		layout_passenger into_passenger(FLAccidents_eCrash.Key_eCrash5 L, Census_Data.Key_Fips2County R) := TRANSFORM
			SELF.passenger_injury_sev_name := codes.FLCRASH5_PASSENGER.PASSENGER_INJURY_SEV(L.PASSENGER_INJURY_SEV);
			SELF.first_passenger_safe_name := codes.FLCRASH5_PASSENGER.FIRST_PASSENGER_SAFE(L.FIRST_PASSENGER_SAFE);
			SELF.second_passenger_safe_name := codes.FLCRASH5_PASSENGER.SECOND_PASSENGER_SAFE(L.SECOND_PASSENGER_SAFE);
			SELF.passenger_eject_code_name := codes.FLCRASH5_PASSENGER.PASSENGER_EJECT_CODE(L.PASSENGER_EJECT_CODE);
			SELF.passenger_location_name := codes.KeyCodes('FLCRASH5_PASSENGER', 'PASSENGER_LOCATION','',L.PASSENGER_LOCATION);
			SELF.county_name := R.county_name;
			SELF := L;
		END;

		layout_pedestrian into_pedestrian(FLAccidents_eCrash.Key_eCrash6 L) := TRANSFORM
			SELF.ped_action_name := codes.FLCRASH6_PEDESTRIAN.PED_ACTION(L.PED_ACTION);
			SELF.ped_sex_name := IF(L.ped_sex!='',codes.KeyCodes('FLCRASH6_PEDESTRIAN','PED_SEX','',L.ped_sex),L.ped_sex_desc);
			SELF.ped_race_name := IF(L.ped_race!='',codes.KeyCodes('FLCRASH6_PEDESTRIAN','PED_RACE','',L.ped_race),L.ped_race_desc);
			SELF := L;
		END;

		RECORDOF(FLAccidents_eCrash.Key_eCrash7) into_property(FLAccidents_eCrash.Key_eCrash7 L) := TRANSFORM
			SELF := L;
		END;

		layout_report addChildDatasets(layout_report L) := TRANSFORM
			county_can_match := MACRO LEFT.st<>'' AND LEFT.county<>'' ENDMACRO;
			SELF.flcrash_time_location := DEDUP(SORT(
				PROJECT(CHOOSEN(FLAccidents_eCrash.Key_eCrash0(KEYED(L.accident_nbr=l_acc_nbr)),ut.limits.ACCIDENTS_MAX),into_tl(LEFT))
				,RECORD),RECORD);
			SELF.flcrash_accident_char := DEDUP(SORT(
				PROJECT(CHOOSEN(FLAccidents_eCrash.Key_eCrash1(KEYED(L.accident_nbr=l_acc_nbr)),ut.limits.ACCIDENTS_MAX),into_ac(LEFT))
				,RECORD),RECORD);
			SELF.flcrash_vehicle := 
				JOIN(CHOOSEN(FLAccidents_eCrash.Key_eCrash2v(KEYED(L.accident_nbr=l_acc_nbr)),ut.limits.ACCIDENTS_MAX),
				Census_Data.Key_Fips2County,county_can_match() AND 
				KEYED(LEFT.st=RIGHT.state_code) AND 
				KEYED(LEFT.county=RIGHT.county_fips),
				into_veh(LEFT,RIGHT),LEFT OUTER,KEEP(1));
			SELF.flcrash_towed_trailer_vehicle := DEDUP(SORT(
				PROJECT(CHOOSEN(FLAccidents_eCrash.Key_eCrash3v(KEYED(L.accident_nbr=l_acc_nbr)),ut.limits.ACCIDENTS_MAX),into_tt(LEFT))
				,RECORD),RECORD);
			SELF.flcrash_driver := 
				JOIN(CHOOSEN(FLAccidents_eCrash.Key_eCrash4(KEYED(L.accident_nbr=l_acc_nbr)),ut.limits.ACCIDENTS_MAX),
				Census_Data.Key_Fips2County,county_can_match() AND
				KEYED(LEFT.st=RIGHT.state_code) AND 
				KEYED(LEFT.county=RIGHT.county_fips),
				into_driver(LEFT,RIGHT),LEFT OUTER,KEEP(1));
			SELF.flcrash_passenger := 
				JOIN(CHOOSEN(FLAccidents_eCrash.Key_eCrash5(KEYED(L.accident_nbr=l_acc_nbr)),ut.limits.ACCIDENTS_MAX),
				Census_Data.Key_Fips2County,county_can_match() AND
				KEYED(LEFT.st=RIGHT.state_code) AND 
				KEYED(LEFT.county=RIGHT.county_fips),
				into_passenger(LEFT,RIGHT),LEFT OUTER,KEEP(1));
			SELF.flcrash_pedestrian := DEDUP(SORT(
				PROJECT(CHOOSEN(FLAccidents_eCrash.Key_eCrash6(KEYED(L.accident_nbr=l_acc_nbr)),ut.limits.ACCIDENTS_MAX),into_pedestrian(LEFT))
				,RECORD),RECORD);
			SELF.flcrash_property := DEDUP(SORT(
				PROJECT(CHOOSEN(FLAccidents_eCrash.Key_eCrash7(KEYED(L.accident_nbr=l_acc_nbr)),ut.limits.ACCIDENTS_MAX),into_property(LEFT))
				,RECORD),RECORD);
			SELF := L;
		END;

		layout_report suppressDL(layout_report L, BOOLEAN dl_mask_value=FALSE) := TRANSFORM
			flcd := L.flcrash_driver;
			flcv := L.flcrash_vehicle;
			flcp := L.flcrash_pedestrian;
			suppress.MAC_Mask(flcd, drv, blank, driver_dl_nbr, FALSE, TRUE);		
			suppress.MAC_Mask(flcp, ped, blank, ped_dl_nbr, FALSE, TRUE);
			suppress.MAC_Mask(flcv, veh, blank, vehicle_owner_dl_nbr, FALSE, TRUE);
			SELF.flcrash_driver := drv;
			SELF.flcrash_vehicle := veh;
			SELF.flcrash_pedestrian := ped;
			SELF := L;
		END;

		layout_report sortChildren(layout_report L) := TRANSFORM
			SELF.flcrash_vehicle := SORT(L.flcrash_vehicle, section_nbr);
			SELF.flcrash_towed_trailer_vehicle := SORT(L.flcrash_towed_trailer_vehicle, section_nbr);
			SELF.flcrash_driver := SORT(L.flcrash_driver, section_nbr);
			SELF.flcrash_passenger := SORT(L.flcrash_passenger, section_nbr);
			SELF.flcrash_pedestrian := SORT(L.flcrash_pedestrian, section_nbr);
			SELF := L;
		END;

		// get accident numbers by DID
		accNbrs0 :=
			DEDUP(SORT(JOIN(dids(did<>0),FLAccidents_eCrash.Key_eCrashV2_did,
			KEYED(LEFT.did=RIGHT.l_did),LIMIT(ut.limits.ACCIDENTS_PER_DID,SKIP)),
			accident_nbr,-vin),accident_nbr);

		// get report code and vehicle incident state for filtering
		accNbrs1 :=
			JOIN(accNbrs0,FLAccidents_eCrash.Key_eCrashV2_accnbrV1,
			KEYED(LEFT.accident_nbr=RIGHT.l_accnbr),
			TRANSFORM(layout_did_acc_nbr,
				SELF.report_code:=RIGHT.report_code,
				SELF.vehicle_incident_st:=RIGHT.vehicle_incident_st,
				SELF:=LEFT),
			LEFT OUTER,KEEP(1),LIMIT(ut.limits.ACCIDENTS_PER_DID,SKIP)); 


		// filter by accident state requested
		accNbrs2 := IF(in_mod.EnableNationalAccidents AND in_mod.accident_State!='',
			accNbrs1(vehicle_incident_st=STD.Str.ToUpperCase(in_mod.accident_State)),
			accNbrs1);

		// Filter records where states require a DPPA permissible purpose
		accNbrs3 := IF((in_mod.EnableNationalAccidents OR in_mod.EnableExtraAccidents) AND ~Accident_services.Functions.allowDPPA(),
			accNbrs2(vehicle_incident_st NOT IN Accident_services.Constants.DPPA_States),accNbrs2);

		ApplicationType := STD.Str.ToUpperCase(in_mod.applicationType);
		allowableStates := SET(Accident_Services.StateRestrictionsFunctions.getRestrictions(ApplicationType),accidentState);

		nationalAccidents := IF(in_mod.EnableNationalAccidents AND in_mod.ApplicationType!='',accNbrs3(report_code IN Accident_services.Constants.NtlAccident_source AND vehicle_incident_st IN allowableStates));
		eCrashAccidents := IF(in_mod.EnableExtraAccidents,accNbrs3(report_code IN Accident_services.Constants.eCrashAccident_source));
		accNbrs4 := accNbrs3(report_code IN Accident_services.Constants.FLAccident_source)+nationalAccidents+eCrashAccidents;

		accRpt0 := PROJECT(accNbrs4,initReport(left));

		accRpt1_add_childds := PROJECT(accRpt0, addChildDatasets(LEFT))
						(in_mod.dateVal=0 OR (UNSIGNED3)MIN(flcrash_time_location,accident_date[1..6]) <= in_mod.dateVal);
						
	 //Blanking out to be compliant with D2C; Key data should not go through 
	 accRpt1 := IF(~isCNSMR, accRpt1_add_childds);
	 
		accRpt2 := PROJECT(accRpt1,suppressDL(LEFT,in_mod.mask_dl));

		accRpt3 := PROJECT(accRpt2,sortChildren(LEFT));

		RETURN accRpt3;		

	END;

END;
