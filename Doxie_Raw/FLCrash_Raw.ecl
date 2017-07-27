import doxie,doxie_crs,FLAccidents_eCrash,codes,Census_Data,suppress, ut;

export FLCrash_Raw(
    dataset(Doxie.layout_references) dids,
	boolean dl_mask_value = false,
	unsigned4 dateVal = 0,
	unsigned1 dppa_purpose = 0,
	unsigned1 glb_purpose = 0
) := FUNCTION 

did_key := FLAccidents_eCrash.key_ecrashv2_did;

key_eCrash0 := FLAccidents_eCrash.key_ecrash0;
key_eCrash1 := FLAccidents_eCrash.key_ecrash1;
key_eCrash2 := FLAccidents_eCrash.key_ecrash2v;
key_eCrash3 := FLAccidents_eCrash.key_ecrash3v;
key_eCrash4 := FLAccidents_eCrash.key_ecrash4;
key_eCrash5 := FLAccidents_eCrash.key_ecrash5;
key_eCrash6 := FLAccidents_eCrash.key_ecrash6;
key_eCrash7 := FLAccidents_eCrash.key_ecrash7;

did_acc_nbr := join(dids(did<>0), did_key, keyed(left.did = right.l_did), KEEP (ut.limits. ACCIDENTS_PER_DID));

layout_time_location := doxie_crs.layout_FSR_time_location;
layout_accident_char := doxie_crs.layout_FSR_accident_char;
layout_vehicle := doxie_crs.layout_FSR_vehicle;
layout_driver := doxie_crs.layout_FSR_driver;
layout_passenger := doxie_crs.layout_FSR_passenger;
layout_pedestrian := doxie_crs.layout_FSR_pedestrian;
	
//init
out_rec := doxie_crs.layout_FLCrash_Search_Records;

out_rec get_init(did_acc_nbr l) := transform
	self.accident_nbr := l.accident_nbr;
	self.flcrash_time_location := [];
	self.flcrash_accident_char := [];
	self.flcrash_vehicle := [];
	self.flcrash_towed_trailer_vehicle := [];
	self.flcrash_driver := [];
	self.flcrash_passenger := [];
	self.flcrash_pedestrian := [];
	self.flcrash_property := [];
end;

f_init := project(did_acc_nbr, get_init(left));

layout_time_location into_tl(key_eCrash0 l) := transform
	self.city_nbr_name := codes.FLCRASH0_TIME_LOCATION.CITY_NBR(l.city_nbr);
	self.type_fr_case_name := codes.FLCRASH0_TIME_LOCATION.TYPE_FR_CASE(l.type_fr_case);
	self.action_code_name := codes.FLCRASH0_TIME_LOCATION.ACTION_CODE(l.action_code);
	self.county_nbr_name := codes.FLCRASH0_TIME_LOCATION.COUNTY_NBR(l.city_nbr[1..2]);
	self := l;
end; 

layout_accident_char into_ac(key_eCrash1 L) := transform
			SELF.First_Harmful_Event_Name := IF(L.first_harmful_event!='',codes.FLCRASH1_ACCIDENT_CHAR.FIRST_HARMFUL_EVENT(L.FIRST_HARMFUL_EVENT),L.first_harmful_event_desc);
	self.Subs_Harmful_Event_Name := codes.FLCRASH1_ACCIDENT_CHAR.SUBS_HARMFUL_EVENT(l.SUBS_HARMFUL_EVENT);
			SELF.Light_Condition_Name := IF(L.light_condition!='',codes.FLCRASH1_ACCIDENT_CHAR.LIGHT_CONDITION(L.LIGHT_CONDITION),L.light_condition_desc);
			SELF.Weather_Name := IF(L.weather!='',codes.FLCRASH1_ACCIDENT_CHAR.WEATHER(L.WEATHER),L.weather_desc);
			SELF.Rd_Surface_Condition_Name := IF(L.rd_surface_condition!='',codes.FLCRASH1_ACCIDENT_CHAR.RD_SURFACE_CONDITION(L.RD_SURFACE_CONDITION),L.rd_surface_condition_desc);
			SELF.First_Contrib_Envir_Name := IF(L.first_contrib_envir!='',codes.FLCRASH1_ACCIDENT_CHAR.FIRST_CONTRIB_ENVIR(L.FIRST_CONTRIB_ENVIR),L.first_contrib_envir_desc);
			SELF.Second_Contrib_Envir_Name := IF(L.second_contrib_envir!='',codes.FLCRASH1_ACCIDENT_CHAR.SECOND_CONTRIB_ENVIR(L.SECOND_CONTRIB_ENVIR),L.second_contrib_envir_desc);
			SELF.First_Traffic_Control_Name := IF(L.first_traffic_control!='',codes.FLCRASH1_ACCIDENT_CHAR.FIRST_TRAFFIC_CONTROL(L.FIRST_TRAFFIC_CONTROL),L.first_traffic_control_desc);
			SELF.Second_Traffic_Control_Name := IF(L.second_traffic_control!='',codes.FLCRASH1_ACCIDENT_CHAR.SECOND_TRAFFIC_CONTROL(L.SECOND_TRAFFIC_CONTROL),L.second_traffic_control_desc);
			SELF.Invest_Agency_Name := IF(L.invest_agency!='',codes.FLCRASH1_ACCIDENT_CHAR.INVEST_AGENCY(L.INVEST_AGENCY),L.invest_agency_desc);
	self.Accident_Injury_Severity_Name := codes.FLCRASH1_ACCIDENT_CHAR.ACCIDENT_INJURY_SEVERITY(l.ACCIDENT_INJURY_SEVERITY);
			SELF.Accident_Damage_Severity_Name := IF(L.accident_damage_severity!='',codes.FLCRASH1_ACCIDENT_CHAR.ACCIDENT_DAMAGE_SEVERITY(L.ACCIDENT_DAMAGE_SEVERITY),L.accident_damage_severity_desc);
			SELF.Alcohol_Drug_Name := IF(L.alcohol_drug!='',codes.FLCRASH1_ACCIDENT_CHAR.ALCOHOL_DRUG(L.ALCOHOL_DRUG),L.alcohol_drug_desc);
	self.rural_urban_code_name := codes.FLCRASH1_ACCIDENT_CHAR.RURAL_URBAN_CODE(l.RURAL_URBAN_CODE);
	self.accident_insur_code_name := codes.FLCRASH1_ACCIDENT_CHAR.ACCIDENT_INSUR_CODE(l.ACCIDENT_INSUR_CODE);
			SELF.accident_fault_code_name := IF(L.accident_fault_code!='',codes.FLCRASH1_ACCIDENT_CHAR.ACCIDENT_FAULT_CODE(L.ACCIDENT_FAULT_CODE),L.accident_fault_code_desc);
	self.type_driver_accident_name := codes.FLCRASH1_ACCIDENT_CHAR.TYPE_DRIVER_ACCIDENT(l.TYPE_DRIVER_ACCIDENT);
 			SELF.day_week_name := IF(L.day_week!='',MAP(
				L.day_week = '1' => 'MONDAY',
				L.day_week = '2' => 'TUESDAY',
				L.day_week = '3' => 'WEDNESDAY',
				L.day_week = '4' => 'THURSDAY',
				L.day_week = '5' => 'FRIDAY',
				L.day_week = '6' => 'SATURDAY',
				'SUNDAY'),L.day_week_desc);
	self.site_loc_name := codes.FLCRASH1_ACCIDENT_CHAR.SITE_LOC(l.site_loc);
	self.on_off_roadway_name := codes.FLCRASH1_ACCIDENT_CHAR.ON_OFF_ROADWAY(l.on_off_roadway);
			SELF.rd_surface_type_name := IF(L.rd_surface_type!='',codes.FLCRASH1_ACCIDENT_CHAR.RD_SURFACE_TYPE(L.rd_surface_type),L.rd_surface_type_desc);
			SELF.type_shoulder_name := IF(L.type_shoulder!='',codes.FLCRASH1_ACCIDENT_CHAR.TYPE_SHOULDER(L.type_shoulder),L.type_shoulder_desc);
			SELF.first_contrib_cause_name := IF(L.first_contrib_cause!='',codes.FLCRASH1_ACCIDENT_CHAR.FIRST_CONTRIB_CAUSE(L.first_contrib_cause),L.first_contrib_cause_desc);
			SELF.second_contrib_cause_name := IF(L.second_contrib_cause!='',codes.FLCRASH1_ACCIDENT_CHAR.SECOND_CONTRIB_CAUSE(L.second_contrib_cause),L.second_contrib_cause_desc);
	self.trafficway_char_name := codes.FLCRASH1_ACCIDENT_CHAR.TRAFFICWAY_CHAR(l.trafficway_char);
	self.divided_undivided_name := codes.FLCRASH1_ACCIDENT_CHAR.DIVIDED_UNDIVIDED(l.divided_undivided);
	self.rd_sys_id_name := codes.FLCRASH1_ACCIDENT_CHAR.RD_SYS_ID(l.rd_sys_id);
	self.invest_complete_name := codes.KeyCodes('FLCRASH1_ACCIDENT_CHAR','INVEST_COMPLETE','',l.invest_complete);
			SELF.location_type_name := IF(L.location_type!='',codes.KeyCodes('FLCRASH1_ACCIDENT_CHAR','LOCATION_TYPE','',L.LOCATION_TYPE),L.location_type_desc);
	self.injured_taken_to_code_name := codes.KeyCodes('FLCRASH1_ACCIDENT_CHAR','INJURED_TAKEN_TO_CODE','',l.injured_taken_to_code);
	self.photos_taken_name      := codes.KeyCodes('FLCRASH1_ACCIDENT_CHAR','PHOTOS_TAKEN',     '',l.photos_taken);
	self.photos_taken_whom_name := codes.KeyCodes('FLCRASH1_ACCIDENT_CHAR','PHOTOS_TAKEN_WHOM','',l.photos_taken_whom);
	self := L;
end;	

layout_vehicle into_veh(key_eCrash2 L, Census_Data.Key_Fips2County R) := transform
			SELF.Vehicle_Type_Name := IF(L.vehicle_type!='',codes.FLCRASH2_VEHICLE.VEHICLE_TYPE(L.VEHICLE_TYPE),L.vehicle_type_desc);
	self.Vehicle_Reg_State_Name := codes.GENERAL.STATE_LONG(l.VEHICLE_REG_STATE);
			SELF.Direction_Travel_Name := IF(L.direction_travel!='',codes.FLCRASH2_VEHICLE.DIRECTION_TRAVEL(L.DIRECTION_TRAVEL),L.direction_travel_desc);
	self.Damage_Type_Name := codes.FLCRASH2_VEHICLE.DAMAGE_TYPE(l.DAMAGE_TYPE);
	self.Vehicle_Owner_Sex_Name := codes.FLCRASH2_VEHICLE.VEHICLE_OWNER_SEX(l.VEHICLE_OWNER_SEX);
	self.Vehicle_Owner_Race_Name := codes.FLCRASH2_VEHICLE.VEHICLE_OWNER_RACE(l.VEHICLE_OWNER_RACE);
			SELF.Point_of_Impact_Name := IF(L.point_of_impact!='',codes.FLCRASH2_VEHICLE.POINT_OF_IMPACT(L.POINT_OF_IMPACT),L.point_of_impact_desc);
	self.Vehicle_Movement_Name := codes.FLCRASH2_VEHICLE.VEHICLE_MOVEMENT(l.VEHICLE_MOVEMENT);
	self.Vehs_First_Defect_Name := codes.FLCRASH2_VEHICLE.VEHS_FIRST_DEFECT(l.VEHS_FIRST_DEFECT);
	self.Vehs_Second_Defect_Name := codes.FLCRASH2_VEHICLE.VEHS_SECOND_DEFECT(l.VEHS_SECOND_DEFECT);
	self.Moving_Violation_Name := codes.FLCRASH2_VEHICLE.MOVING_VIOLATION(l.MOVING_VIOLATION);
	self.Vehicle_Fault_Code_Name := codes.FLCRASH2_VEHICLE.VEHICLE_FAULT_CODE(l.VEHICLE_FAULT_CODE);
	self.vehicle_fr_code_name := codes.FLCRASH2_VEHICLE.VEHICLE_FR_CODE(l.VEHICLE_FR_CODE);
	self.vehicle_insur_code_name := map(stringlib.StringToUpperCase(l.vehicle_insur_code) = 'U' => 'Vehicle Un-Insured',
	                                    stringlib.StringToUpperCase(l.vehicle_insur_code) = 'I' => 'Vehicle Insured',
								 '');
	self.vehicle_driver_action_name := codes.FLCRASH2_VEHICLE.VEHICLE_DRIVER_ACTION(l.VEHICLE_DRIVER_ACTION);
	self.vehicle_owner_driver_code_name := codes.FLCRASH2_VEHICLE.VEHICLE_OWNER_DRIVER_CODE(l.VEHICLE_OWNER_DRIVER_CODE);
	self.how_removed_code_name := codes.FLCRASH2_VEHICLE.HOW_REMOVED_CODE(l.HOW_REMOVED_CODE);
	self.hazard_material_transport_name := codes.FLCRASH2_VEHICLE.HAZARD_MATERIAL_TRANSPORT(l.hazard_material_transport);
			SELF.vehicle_use_Name := IF(L.vehicle_use!='',codes.FLCRASH2_VEHICLE.vehicle_use(L.vehicle_use),L.vehicle_use_desc);
	self.placarded_Name := codes.FLCRASH2_VEHICLE.placarded(l.placarded);
	self.vehicle_roadway_loc_Name := codes.FLCRASH2_VEHICLE.vehicle_roadway_loc(l.vehicle_roadway_loc);
	self.vehicle_function_name := codes.FLCRASH2_VEHICLE.vehicle_function(l.vehicle_function);
	self.county_name := R.county_name;
	self := l;
end;

recordof(FLAccidents_eCrash.Key_eCrash3v) into_tt(key_eCrash3 l) :=
TRANSFORM
	SELF.l_acc_nbr := (STRING)l.l_acc_nbr;
	SELF := l;
	SELF := [];
END;

layout_driver into_driver(key_eCrash4 L, Census_Data.Key_Fips2County R) := transform
	self.DL_State_Name := codes.GENERAL.STATE_LONG(l.DRIVER_LIC_ST);
	self.DL_Type_Name := codes.FLCRASH4_DRIVER.DRIVER_LIC_TYPE(l.DRIVER_LIC_TYPE);
	self.Driver_alco_drug_code_Name := codes.FLCRASH4_DRIVER.DRIVER_ALCO_DRUG_CODE(l.DRIVER_ALCO_DRUG_CODE);
	self.Driver_Physical_defects_code_Name := codes.FLCRASH4_DRIVER.DRIVER_PHYSICAL_DEFECTS(l.DRIVER_PHYSICAL_DEFECTS);
	self.Driver_Injury_Severity_Name := codes.FLCRASH4_DRIVER.DRIVER_INJURY_SEVERITY(l.DRIVER_INJURY_SEVERITY);
	self.First_Driver_Safety_Name := codes.FLCRASH4_DRIVER.FIRST_DRIVER_SAFETY(l.FIRST_DRIVER_SAFETY);
	self.First_Contrib_Cause_Name := codes.FLCRASH4_DRIVER.FIRST_CONTRIB_CAUSE(l.FIRST_CONTRIB_CAUSE);
	self.Second_Contrib_Cause_Name := codes.FLCRASH4_DRIVER.SECOND_CONTRIB_CAUSE(l.SECOND_CONTRIB_CAUSE);
	self.Third_Contrib_Cause_Name := codes.FLCRASH4_DRIVER.THIRD_CONTRIB_CAUSE(l.THIRD_CONTRIB_CAUSE);
	self.Dl_nbr_Good_Bad_Name := codes.FLCRASH4_DRIVER.DL_NBR_GOOD_BAD(l.DL_NBR_GOOD_BAD);
 	self.second_driver_safety_name := codes.FLCRASH4_DRIVER.SECOND_DRIVER_SAFETY(l.SECOND_DRIVER_SAFETY);
	self.driver_eject_code_name := codes.FLCRASH4_DRIVER.DRIVER_EJECT_CODE(l.DRIVER_EJECT_CODE);
  self.county_name := R.county_name;
			SELF.driver_sex_name := IF(L.driver_sex!='',codes.FLCRASH4_DRIVER.DRIVER_SEX(L.driver_sex),L.driver_sex_desc);
			SELF.driver_race_name := IF(L.driver_race!='',codes.FLCRASH4_DRIVER.DRIVER_RACE(L.driver_race),L.driver_race_desc);
	self.driver_bac_test_type_name := codes.FLCRASH4_DRIVER.DRIVER_BAC_TEST_TYPE(l.driver_bac_test_type);
	self.driver_physical_defects_name := codes.FLCRASH4_DRIVER.DRIVER_PHYSICAL_DEFECTS(l.driver_physical_defects);
			SELF.driver_residence_name := IF(L.driver_residence!='',codes.FLCRASH4_DRIVER.DRIVER_RESIDENCE(L.driver_residence),L.driver_residence_desc);
	self.recommand_reexam_name := codes.FLCRASH4_DRIVER.recommand_reexam(l.recommand_reexam);
	self.req_endorsement_name := case((unsigned2)l.req_endorsement, 1 => 'Yes', 2=> 'No', '');
	self := L;
end;

layout_passenger into_passenger(key_eCrash5 L, Census_Data.Key_Fips2County R) := transform
  self.passenger_injury_sev_name := codes.FLCRASH5_PASSENGER.PASSENGER_INJURY_SEV(l.PASSENGER_INJURY_SEV);
	self.first_passenger_safe_name := codes.FLCRASH5_PASSENGER.FIRST_PASSENGER_SAFE(l.FIRST_PASSENGER_SAFE);
	self.second_passenger_safe_name := codes.FLCRASH5_PASSENGER.SECOND_PASSENGER_SAFE(l.SECOND_PASSENGER_SAFE);
	self.passenger_eject_code_name := codes.FLCRASH5_PASSENGER.PASSENGER_EJECT_CODE(l.PASSENGER_EJECT_CODE);
	self.PASSENGER_LOCATION_name := codes.KeyCodes('FLCRASH5_PASSENGER', 'PASSENGER_LOCATION','',l.PASSENGER_LOCATION);
  self.county_name := R.county_name;
	self := L;
end;

layout_pedestrian into_pedestrian(key_eCrash6 L) := transform
     self.ped_action_name := codes.FLCRASH6_PEDESTRIAN.PED_ACTION(l.PED_ACTION);
			SELF.ped_sex_name := IF(L.ped_sex!='',codes.KeyCodes('FLCRASH6_PEDESTRIAN','PED_SEX','',L.ped_sex),L.ped_sex_desc);
			SELF.ped_race_name := IF(L.ped_race!='',codes.KeyCodes('FLCRASH6_PEDESTRIAN','PED_RACE','',L.ped_race),L.ped_race_desc);
	self := L;
end;

recordof(FLAccidents_eCrash.Key_eCrash7) into_property(key_eCrash7 l) :=
TRANSFORM
	SELF.l_acc_nbr := l.l_acc_nbr;
	SELF := l;
	SELF := [];
END;

out_rec get_sub(f_init l) := transform
  iaccident := l.accident_nbr;
	county_can_match := MACRO left.st<>'' AND left.county<>'' ENDMACRO;
	
	SELF.flcrash_time_location := PROJECT(CHOOSEN (key_eCrash0(keyed(iaccident=l_acc_nbr)), ut.limits. ACCIDENTS_MAX), into_tl(LEFT));
	SELF.flcrash_accident_char := PROJECT(CHOOSEN (key_eCrash1(keyed(iaccident=l_acc_nbr)), ut.limits. ACCIDENTS_MAX), into_ac(LEFT));
	SELF.flcrash_vehicle := join(CHOOSEN (key_eCrash2(keyed(iaccident=l_acc_nbr)), ut.limits. ACCIDENTS_MAX),Census_Data.Key_Fips2County,
																county_can_match() AND 
																keyed(left.st = right.state_code) and 
																keyed(left.county = right.county_fips),
																into_veh(LEFT, right),
																left outer, KEEP (1));
	SELF.flcrash_towed_trailer_vehicle := PROJECT(CHOOSEN (key_eCrash3(keyed(iaccident=l_acc_nbr)), ut.limits. ACCIDENTS_MAX), into_tt(LEFT));
	SELF.flcrash_driver := JOIN(CHOOSEN (key_eCrash4(keyed(iaccident=l_acc_nbr)), ut.limits. ACCIDENTS_MAX),Census_Data.Key_Fips2County,
																county_can_match() AND
																keyed(left.st = right.state_code) and 
																keyed(left.county = right.county_fips),
																into_driver(LEFT, right),
																left outer, KEEP (1));
	SELF.flcrash_passenger := JOIN(CHOOSEN (key_eCrash5(keyed(iaccident=l_acc_nbr)), ut.limits. ACCIDENTS_MAX),Census_Data.Key_Fips2County,
																county_can_match() AND
																keyed(left.st = right.state_code) and 
																keyed(left.county = right.county_fips),
																into_passenger(LEFT, right),
																left outer, KEEP (1));
	SELF.flcrash_pedestrian := PROJECT(CHOOSEN (key_eCrash6(keyed(iaccident=l_acc_nbr)), ut.limits. ACCIDENTS_MAX), into_pedestrian(LEFT));
	SELF.flcrash_property := PROJECT(CHOOSEN (key_eCrash7(keyed(iaccident=l_acc_nbr)), ut.limits. ACCIDENTS_MAX), into_property(LEFT));
	self := l;
end;
f_zero := PROJECT(f_init((unsigned6)accident_nbr<>0), get_sub(LEFT))
					(dateVal=0 OR (unsigned3)MIN(flcrash_time_location,accident_date[1..6]) <= dateVal);

out_Rec suppress(out_rec l) :=
TRANSFORM
	flcd := l.flcrash_driver;
	flcv := l.flcrash_vehicle;
	flcp := l.flcrash_pedestrian;
	suppress.MAC_Mask(flcd, drv, blank, driver_dl_nbr, false, true);		
	suppress.MAC_Mask(flcp, ped, blank, ped_dl_nbr, false, true);
	suppress.MAC_Mask(flcv, veh, blank, vehicle_owner_dl_nbr, false, true);
	
	SELF.flcrash_driver := drv;
	SELF.flcrash_vehicle := veh;
	SELF.flcrash_pedestrian := ped;
	SELF := l;
END;
f_suppressed := PROJECT(f_zero, suppress(LEFT));

out_rec sort_child(out_rec l) := transform
	self.flcrash_vehicle := sort(l.flcrash_vehicle, section_nbr);
  self.flcrash_towed_trailer_vehicle := sort(l.flcrash_towed_trailer_vehicle, section_nbr);
	self.flcrash_driver := sort(l.flcrash_driver, section_nbr);
	self.flcrash_passenger := sort(l.flcrash_passenger, section_nbr);
	self.flcrash_pedestrian := sort(l.flcrash_pedestrian, section_nbr);
	self := l;
end;

f_sorted := PROJECT(f_suppressed, sort_child(LEFT));

return f_sorted;		
END;