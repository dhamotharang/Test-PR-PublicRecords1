IMPORT FLAccidents, STD, dx_Ecrash;

EXPORT mod_PrepEcrashFLAccidentPRKeys := MODULE

SHARED ReadNtlFile := FLAccidents.BaseFile_NtlAccidents_Alpharetta;
SHARED ReadInqFile := FLAccidents.File_CRU_inquiries;
SHARED ReadEcrashFile := eCrashBaseAgencyExclusion(is_Terminated_Agency = FALSE);

//***************************************************************
//Ecrash0
//***************************************************************
//Expand Florida file 
flc0 	:= FLAccidents.basefile_flcrash0;

dx_Ecrash.Layouts.ECRASH0 xpndrecs(flc0 L) := TRANSFORM
SELF.report_code					:= 'FA';
SELF.report_category		  := 'Auto Report';
SELF.report_code_desc		  := 'Auto Accident';
accidentNumber            := STD.Str.Filter(l.accident_nbr,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789');
SELF.accident_nbr         := accidentNumber;
SELF.l_acc_nbr             := accidentNumber;
SELF.orig_accnbr          := l.accident_nbr; 
SELF 								      := L;
END;
pflc0 := PROJECT(flc0,xpndrecs(LEFT));
  
//Slim National file
ntlFile := ReadntlFile;

pflc0 slimrec(ntlFile L) := TRANSFORM

string8     fSlashedMDYtoCYMD(string pDateIn) :=
								INTFORMAT((integer2)REGEXREPLACE('.*/.*/([0-9]+)',pDateIn,'$1'),4,1) 
					+     INTFORMAT((integer1)REGEXREPLACE('([0-9]+)/.*/.*',pDateIn,'$1'),2,1)
					+     INTFORMAT((integer1)REGEXREPLACE('.*/([0-9]+)/.*',pDateIn,'$1'),2,1);

SELF.rec_type_o 			    := '0';
t_accident_nbr 			      := (string40)((unsigned6)L.vehicle_incident_id+10000000000);
t_scrub                   := STD.Str.Filter(t_accident_nbr,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789');
accidentNumber            := IF(t_scrub in ['UNK', 'UNKNOWN'], 'UNK'+l.vehicle_incident_id,t_scrub);  
SELF.accident_nbr         := accidentNumber;
SELF.l_acc_nbr             := accidentNumber;
SELF.orig_accnbr          := t_accident_nbr; 
SELF.accident_date				:= fSlashedMDYtoCYMD(L.loss_date[1..10]);
SELF.city_town_name 		  := stringlib.stringtouppercase(L.inc_city);
     
SELF						          := L;
SELF						          := [];
END;
pntl := PROJECT(ntlFile,slimrec(LEFT));

// inquiry file 
inqFile := ReadInqFile; 

pflc0 slimrecinq(inqFile L) := TRANSFORM

string8     fSlashedMDYtoCYMD(string pDateIn) :=
INTFORMAT((integer2)REGEXREPLACE('.*/.*/([0-9]+)',pDateIn,'$1'),4,1) 
+     INTFORMAT((integer1)REGEXREPLACE('([0-9]+)/.*/.*',pDateIn,'$1'),2,1)
+     INTFORMAT((integer1)REGEXREPLACE('.*/([0-9]+)/.*',pDateIn,'$1'),2,1);

SELF.rec_type_o 			    := '0';
t_accident_nbr            := IF(L.vehicle_incident_id[1..3] = 'OID',
													      (string40)((unsigned6)L.vehicle_incident_id[4..11]+100000000000),
													      (string40)((unsigned6)L.vehicle_incident_id+10000000000));
t_scrub                   := STD.Str.Filter(t_accident_nbr,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789');
accidentNumber            := IF(t_scrub in ['UNK', 'UNKNOWN'], 'UNK'+l.vehicle_incident_id,t_scrub);  
SELF.accident_nbr         := accidentNumber;
SELF.l_acc_nbr             := accidentNumber;
SELF.orig_accnbr          := t_accident_nbr; 
SELF.accident_date			  := fSlashedMDYtoCYMD(L.loss_date[1..10]);
SELF.city_town_name 		  := STD.Str.ToUpperCase(L.city);
SELF.report_code					:= 'I'+ L.report_code;
SELF						          := L;
SELF						          := [];
END;
pInq := PROJECT(inqFile,slimrecinq(LEFT));

// ecrash 
ecrashFile := ReadEcrashFile;

pflc0 slimrececrash(ecrashFile L) := TRANSFORM

SELF.rec_type_o 			    := '0';
t_accident_nbr 			      := IF(l.source_id in['TM','TF'],L.state_report_number, L.case_identifier);
t_scrub                   := STD.Str.Filter(t_accident_nbr,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789');
accidentNumber            := IF(t_scrub in ['UNK', 'UNKNOWN'], 'UNK'+l.incident_id,t_scrub);
SELF.accident_nbr         := accidentNumber;
SELF.l_acc_nbr             := accidentNumber;
SELF.orig_accnbr          := t_accident_nbr;
SELF.accident_date 			  := IF(L.incident_id[1..9] ='188188188','20100901',L.crash_date);
SELF.city_town_name 		  := STD.Str.ToUpperCase(L.crash_city);
SELF.county_name          := l.crash_county; 
SELF.ft_miles_node        := l.distance_from_node_miles;
SELF.dot_milepost         := l.milepost1;
SELF.at_intersect_of      := l.intersection_related ; 
SELF.st_road_hhwy_name    := l.state_highway_related; 
SELF.city_nbr             := l.city_code; 
SELF						          := L;
SELF						          := [];
END;
pecrash := PROJECT(ecrashFile,slimrececrash(LEFT));

export flc0_allrecs := DEDUP(pflc0+pntl+pInq+pecrash,record,all);
                 
//***************************************************************
//Ecrash1
//***************************************************************
//Expand Florida file 
flc1	:= FLAccidents.basefile_flcrash1;

dx_Ecrash.Layouts.ECRASH1 xpndrecs(flc1 L) := TRANSFORM
SELF.report_code					:= 'FA';
SELF.report_category		  := 'Auto Report';
SELF.report_code_desc			:= 'Auto Accident';
accidentNumber            := STD.Str.Filter(l.accident_nbr,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789');
SELF.accident_nbr         := accidentNumber;
SELF.l_acc_nbr             := accidentNumber;
SELF.orig_accnbr          := l.accident_nbr; 
SELF.invest_agency_desc   := TRIM(l.dept_name,LEFT,RIGHT); 
SELF 								      := L;
SELF                      := []; 
END;
pflc1:= PROJECT(flc1,xpndrecs(LEFT));
  
//ntlFile := ReadntlFile;
//National file does not have information pertinent to this layout.  Therefore only passing FL records.

ecrashfile := ReadEcrashFile; 

dx_Ecrash.Layouts.ECRASH1 xpndecrash(ecrashfile L) := TRANSFORM

	SELF.rec_type_1 := '1'; 
	t_accident_nbr := IF(l.source_id in ['TM','TF'],L.state_report_number, L.case_identifier);
	t_scrub := STD.Str.Filter(t_accident_nbr,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789');
  accidentNumber := IF(t_scrub in ['UNK', 'UNKNOWN'], 'UNK'+l.incident_id,t_scrub); 
	SELF.accident_nbr := accidentNumber;
  SELF.l_acc_nbr := accidentNumber;
  SELF.orig_accnbr := t_accident_nbr;
	SELF.hr_off_notified :=l.time_notified[1..2];
  SELF.min_off_notified:=l.time_notified[4..5];
  SELF.hr_off_arrived:=l.officer_arrival_time[1..2];
  SELF.min_off_arrived:=l.officer_arrival_time[4..5];
	SELF.city_nbr := l.city_code; 
	SELF.site_loc := ''; 
	SELF.trafficway_char := ''; 
	SELF.nbr_lanes := l.number_of_lanes; 
	SELF.divided_undivided := ''; 
	SELF.total_vehicle_damage := l.vehicle_damage_amount; 
	SELF.total_nbr_vehicles := l.number_of_vehicles; 
	SELF.total_nbr_fatalities := l.total_fatal_injuries; 
	SELF.total_nbr_non_traffic_fatal := l.total_nonfatal_injuries;
	SELF.invest_name := l.investigating_officer_name; 
	SELF.invest_rank := l.officer_rank; 
	SELF.dept_name:=l.officer_department;
	SELF.report_date:=l.officer_report_date;
	SELF.first_aid_name :=l.person_first_aid_party_type_description;
	SELF.first_aid_person_type_desc:=l.person_first_aid_party_type;          //string1   first_aid_person_type,
  SELF.accident_fault_code_desc := l.primary_fault_indicator;          //string1   accident_fault_code,  
  SELF.alcohol_drug_desc  := l.alcohol_drug_use;                //string1   alcohol_drug,
  SELF.accident_damage_severity_desc := l.Damaged_Areas_Severity1;   // string1   accident_damage_severity
  SELF.invest_agency_desc  := l.agency_name;           //,	string1   invest_agency,
  SELF.first_harmful_event_desc  := l.first_harmful_event;      //string2   first_harmful_event
  SELF.light_condition_desc := l.light_condition1;           //string2   light_condition
  SELF.weather_desc  := l.weather_condition1;                //string2  weather
  SELF.rd_surface_type_desc := l.road_surface;         //, string2   rd_surface_type, 
  SELF.type_shoulder_desc := l.shoulder_type;          //, string2   type_shoulder, 
  SELF.rd_surface_condition_desc := l.road_surface_condition;   //, string2   rd_surface_condition, 
  SELF.first_contrib_cause_desc := l.contributing_factors1;   //, string2   first_contrib_cause, 
  SELF.second_contrib_cause_desc := l.contributing_factors2; //, string2   second_contrib_cause, 
  SELF.first_contrib_envir_desc:= l.contributing_circumstances_environmental1;  // , string2   first_contrib_envir, 
  SELF.second_contrib_envir_desc:= l.contributing_circumstances_environmental2;  // , string2   second_contrib_envir, 
  SELF.first_traffic_control_desc:= l.traffic_control_type_at_intersection1;// , string2   first_traffic_control, 
  SELF.second_traffic_control_desc:= l.traffic_control_type_at_intersection2;//, string2   second_traffic_control 
	SELF.hr_ems_notified :=l.EMS_Notified_Time[1..2]; //currently this is blank
	SELF.min_ems_notified:=l.EMS_Notified_Time[4..5];
	SELF.hr_ems_arrived :=l.EMS_Arrival_Time[1..2];//currently this is blank not sure about the format
	SELF.min_ems_arrived:=l.EMS_Arrival_Time[4..5];
	SELF.day_week_desc  := l.day_of_week;
	SELF.location_type_desc := l.location_type; 
	SELF.location_type :='';
  SELF := l ; 
  SELF:=[];
 END; 
 pecrash := PROJECT(ecrashfile, xpndecrash(LEFT)); 
 
export flc1_ptotal := DEDUP(pflc1+pecrash,ALL); 

//***************************************************************
//Ecrash2v
//***************************************************************
//Expand Florida file 
flc2v 	:= FLAccidents.basefile_flcrash2v;

dx_Ecrash.Layouts.ECRASH2V xpndrecs(flc2v L,FLAccidents.BaseFile_FLCrash0 R) := TRANSFORM
SELF.report_code					:= 'FA';
SELF.report_category		  := 'Auto Report';
SELF.report_code_desc			:= 'Auto Accident';
SELF.vehicle_incident_city:= STD.Str.ToUpperCase(IF(L.accident_nbr= R.accident_nbr,R.city_town_name,''));
SELF.vehicle_incident_st  := 'FL';
SELF.carrier_name         := l.ins_company_name;
SELF.client_type_id			  := '';
accidentNumber            := stringlib.StringFilter(l.accident_nbr,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789');
SELF.accident_nbr         := accidentNumber;
SELF.l_acc_nbr             := accidentNumber;
SELF.orig_accnbr          := l.accident_nbr; 
SELF.vehicle_owner_dob		:=l.vehicle_owner_dob[5..8]+l.vehicle_owner_dob[1..4] ; 
SELF.direction_travel_desc:= ''; 
SELF.vehicle_type_desc    := ''; 
SELF.point_of_impact_desc := ''; 
SELF.vehicle_use_desc     := ''; 
SELF 								      := L;
END;

pflc2v := JOIN(DISTRIBUTE(flc2v,HASH32(accident_nbr))
			         ,DISTRIBUTE(FLAccidents.BaseFile_FLCrash0,HASH32(accident_nbr))
			         ,LEFT.accident_nbr = RIGHT.accident_nbr,
			         xpndrecs(LEFT,RIGHT),LEFT outer,LOCAL);
  
//Slim National file 
ntlFile := ReadntlFile(STD.Str.ToUpperCase(party_type) != 'DRIVER');

pflc2v slimrec1(ntlFile L) := TRANSFORM
SELF.did							    := IF(L.did = 0,'000000000000',INTFORMAT(L.did,12,1));
SELF.b_did							  := IF(L.bdid = 0,'',INTFORMAT(L.bdid,12,1)); 
SELF.b_did_score					:= L.bdid_score;
SELF.rec_type_2						:= '2';
t_accident_nbr 			      := (string40)((unsigned6)L.vehicle_incident_id+10000000000);
t_scrub                   := STD.Str.Filter(t_accident_nbr,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789');
accidentNumber            := IF(t_scrub in ['UNK', 'UNKNOWN'], 'UNK'+l.vehicle_incident_id,t_scrub); 
SELF.accident_nbr         := accidentNumber;
SELF.l_acc_nbr             := accidentNumber; 
SELF.orig_accnbr          := t_accident_nbr; 
SELF.section_nbr					:= IF(L.LAST_NAME+L.FIRST_NAME = L.LAST_NAME_1+L.FIRST_NAME_1,L.vehicle_nbr,'');;
SELF.vehicle_tag_nbr			:= L.TAG;
SELF.vehicle_reg_state	  := L.TAG_STATE;
//------------------------------------
//used for mobileTrac
SELF.vehicle_id_nbr				:= IF(L.vehVin !=''
										            ,L.vehVin
										            ,IF(L.LAST_NAME+L.FIRST_NAME = L.LAST_NAME_1+L.FIRST_NAME_1,L.vin,''));
SELF.vehicle_year					:=IF(L.vehYear !=''
										           ,L.vehYear
										           ,IF(L.LAST_NAME+L.FIRST_NAME = L.LAST_NAME_1+L.FIRST_NAME_1,L.year,''));	
SELF.vehicle_make					:=IF(L.vehmake !=''
										           ,L.vehMake
										           ,IF(L.LAST_NAME+L.FIRST_NAME = L.LAST_NAME_1+L.FIRST_NAME_1,L.make,''));
SELF.make_description     := IF(L.make_description != '',L.make_description,L.vehMake);
SELF.model_description    := IF(L.model_description != '',L.model_description,L.vehModel);
SELF.vehicle_incident_city:= STD.Str.ToUpperCase(L.inc_city);
SELF.vehicle_incident_st  := STD.Str.ToUpperCase(L.state_abbr);
SELF.point_of_impact      := '';
SELF.point_of_impact_desc :=L.impact_location;
//------------------------------------
SELF.ins_company_name		  := L.LEGAL_NAME;
SELF.ins_policy_nbr		   	:= L.POLICY_NBR;
SELF.carrier_name         := L.LEGAL_NAME;
SELF.vehicle_owner_name	  := MAP(L.LAST_NAME+L.FIRST_NAME = L.LAST_NAME_1+L.FIRST_NAME_1 => L.LAST_NAME  +' '+L.FIRST_NAME+' '+L.MIDDLE_NAME_1
										             ,'');
SELF.vehicle_owner_st_city:= IF(L.LAST_NAME+L.FIRST_NAME = L.LAST_NAME_1+L.FIRST_NAME_1,L.city,'');
SELF.vehicle_owner_st     := IF(L.LAST_NAME+L.FIRST_NAME = L.LAST_NAME_1+L.FIRST_NAME_1,L.state,'');
SELF.vehicle_owner_zip	 	:= IF(L.LAST_NAME+L.FIRST_NAME = L.LAST_NAME_1+L.FIRST_NAME_1,L.zip5,'');
SELF.vehicle_owner_dl_nbr := IF(L.pty_drivers_license !=''
										            ,L.pty_drivers_license
										            ,IF(L.LAST_NAME+L.FIRST_NAME = L.LAST_NAME_1+L.FIRST_NAME_1,L.drivers_license,''));
SELF.vehicle_owner_dob    := L.dob;
SELF.vehicle_owner_sex    := IF(L.LAST_NAME+L.FIRST_NAME = L.LAST_NAME_1+L.FIRST_NAME_1,L.gender_1[1],'');
SELF.vehicle_fault_code   := MAP(L.LAST_NAME+L.FIRST_NAME = L.LAST_NAME_1+L.FIRST_NAME_1 => '1'
										             ,L.LAST_NAME+L.FIRST_NAME = L.LAST_NAME_2+L.FIRST_NAME_2 => '2'
										             ,L.LAST_NAME+L.FIRST_NAME = L.LAST_NAME_3+L.FIRST_NAME_3 => '3'
										             ,'');
SELF.addr_suffix 					:= L.suffix;
SELF.ace_fips_st					:= L.county_code[1..2];
SELF.county							  := L.county_code[3..5];
SELF.zip							    := L.zip5;
SELF.score 							  := L.name_score;
SELF.suffix 						  := L.name_suffix;
SELF.cname							  := STD.Str.ToUpperCase(L.business_name);

SELF								      := L;
SELF								      := [];
END;
pntl := PROJECT(ntlFile,slimrec1(LEFT)); 

// ecrash 
ecrashFile := ReadEcrashFile(STD.Str.ToUpperCase(person_type) in ['OWNER','VEHICLE OWNER']); 

pflc2v slimrec3(ecrashFile L, unsigned1 cnt) := TRANSFORM

SELF.vehicle_incident_city	:= STD.Str.ToUpperCase(L.Crash_City);
SELF.vehicle_incident_st		:= STD.Str.ToUpperCase(L.Loss_State_Abbr);
SELF.carrier_name     := L.Insurance_Company;
SELF.client_type_id 	:= '';
SELF.rec_type_2  := '2'; 
t_accident_nbr 			:= IF(l.source_id in ['TF','TM'],L.state_report_number, L.case_identifier);
t_scrub := STD.Str.Filter(t_accident_nbr,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789');
accidentNumber := IF(t_scrub IN ['UNK', 'UNKNOWN'], 'UNK'+l.incident_id,t_scrub);
SELF.accident_nbr         := accidentNumber;
SELF.l_acc_nbr             := accidentNumber; 
SELF.orig_accnbr := t_accident_nbr;
SELF.section_nbr := l.vehicle_unit_number; 
SELF.vehicle_owner_driver_code := ''; 
SELF.vehicle_driver_action := l.driver_actions_at_time_of_crash1; 
SELF.vehicle_type_desc := l.vehicle_type ; 
SELF.vehicle_type := ''; 

year					              := TRIM(IF(L.Other_Unit_VIN !='',CHOOSE(cnt,IF(L.model_year != '',L.model_year,L.model_yr),
																														L.other_model_year),
																														IF(L.model_year != '',L.model_year,L.model_yr)),LEFT,RIGHT);																														
SELF.vehicle_year						:= MAP(LENGTH(year) = 2 and year>'50' => '19'+ year,
																	 LENGTH(year) = 2 and year<='50' => '20'+ year,year);
SELF.model_year 						:= MAP(LENGTH(year) = 2 and year>'50' => '19'+ year,
																	 LENGTH(year) = 2 and year<='50' => '20'+ year,year);
//------------------------------------------------------------	
SELF.vehicle_make					  := IF(L.Other_Unit_VIN !='',CHOOSE(cnt,IF(L.make_description != '',L.make_description,L.make),
																														IF(L.other_make_description != '',L.other_make_description,L.Other_Unit_Make)),
																														IF(L.make_description != '',L.make_description,L.make));

SELF.vehicle_tag_nbr := IF(L.Other_Unit_VIN !='',CHOOSE(cnt,L.License_Plate,L.Other_Unit_License_Plate),L.License_Plate);
SELF.vehicle_reg_state := IF(L.Other_Unit_VIN !='',CHOOSE(cnt,L.Registration_State,L.Other_Unit_Registration_State),L.Registration_State);
SELF.vehicle_id_nbr  := IF(L.Other_Unit_VIN !='',CHOOSE(cnt,L.vin,L.Other_Unit_VIN),L.vin);
SELF.vehicle_travel_on := '';//l.direction_of_travel_before_crash; 
SELF.direction_travel := '';//
SELF.direction_travel_desc := l.direction_of_travel; 
SELF.est_vehicle_speed := l.estimated_speed ; 
SELF.posted_speed :=  l.speed_limit_posted; 
SELF.est_vehicle_damage := l.vehicle_damage_amount ; 
SELF.damage_type := ''; 
SELF.ins_company_name :=  L.Insurance_Company;
SELF.ins_policy_nbr := L.Insurance_Policy_Number;  ; 
SELF.vehicle_removed_by:= ''; 
SELF.how_removed_code := ''; 
SELF.vehicle_owner_name := TRIM(l.first_name,LEFT,RIGHT)+' '+TRIM(l.middle_name,LEFT,RIGHT) +' '+TRIM(l.last_name ,LEFT,RIGHT);
SELF.vehicle_owner_suffix :=IF(TRIM(l.name_suffx,LEFT,RIGHT) ='N','',l.name_suffx);  
SELF.vehicle_owner_st_city := TRIM(l.address,LEFT,RIGHT)  +' '+ TRIM(l.city,LEFT,RIGHT); 
SELF.vehicle_owner_st := l.state ; 
SELF.vehicle_owner_zip := l.zip_code; 
SELF.vehicle_owner_forge_asterisk := ''; 
SELF.vehicle_owner_dl_nbr := l.drivers_license_number;
SELF.vehicle_owner_dob := l.date_of_birth;
SELF.vehicle_owner_sex := l.sex ; 
SELF.vehicle_owner_race := l.race; 
SELF.point_of_impact := l.impact_area1 ; 
SELF.point_of_impact_desc				:='';

SELF.vehicle_movement:= '';
SELF.vehicle_function:= '';
SELF.vehs_first_defect:= '';
SELF.vehs_second_defect:= '';
SELF.vehicle_modified:= '';
SELF.vehicle_roadway_loc:= '';
SELF.hazard_material_transport:= '';
SELF.total_occu_vehicle:= ''; 
SELF.total_occu_saf_equip:= ''; 
SELF.moving_violation:= ''; 
SELF.vehicle_insur_code:= ''; 
SELF.vehicle_fault_code := ''; 
SELF.vehicle_cap_code:= ''; 
SELF.vehicle_fr_code := ''; 
SELF.placarded := ''; 
SELF.dhsmv_vehicle_ind := ''; 
SELF.addr_suffix 					:= L.addr_suffix;
SELF.ace_fips_st					:= L.county_code[1..2];
SELF.county							:= L.county_code[3..5];
SELF.zip							:= L.z5;
SELF.zip4								:= L.z4;
SELF.score 							:= L.name_score;
SELF.suffix 						:= L.suffix;  
SELF.cname              := l.cname; 
SELF.match_code := ''; 
SELF.manufacturer_corporation := ''; 
SELF.division_code := '';
SELF.vehicle_group_code := ''; 
SELF.vehicle_subgroup_code := ''; 
SELF.vehicle_series_code := ''; 
SELF.vehicle_abbreviation := ''; 
SELF.assembly_country := ''; 
SELF.headquarter_country:= ''; 
SELF.number_of_doors := ''; 
SELF.seating_capacity := '';//l.seating_position_seat; add when silverlight is live 
SELF.number_of_cylinders := ''; 
SELF.carburetion_type := ''; 
SELF.number_of_barrels:= ''; 
SELF.price_class_code := ''; 
SELF.body_size_code := ''; 
SELF.number_of_wheels_on_road:= ''; 
SELF.drive_type := ''; 
SELF.gvw_code := ''; 
SELF.load_capacity_code :=''; 
SELF.cab_type_code := ''; 
SELF.bed_length := ''; 
SELF.rim_size := ''; 
SELF.manufacture_body_style :=  l.body_style_code; 
SELF.vehicle_type_code := ''; 
SELF.car_line_code := ''; 
SELF.car_series_code :=''; 
SELF.car_body_style_code := ''; 
SELF.engine_cylinder_code := ''; 
SELF.truck_make_abbreviation  := '';
SELF.truck_body_style_abbreviation := ''; 
SELF.motorcycle_make_abbreviation := ''; 
SELF.reference_number := l.vendor_reference_number; 
SELF.make_description				:= IF(L.Other_Unit_VIN !='',CHOOSE(cnt,IF(L.make_description != '',L.make_description,L.make),
																														IF(L.other_make_description != '',L.other_make_description,L.Other_Unit_Make)),
																														IF(L.make_description != '',L.make_description,L.make));
SELF.model_description			:= IF(L.Other_Unit_VIN !='',CHOOSE(cnt,IF(L.model_description != '',L.model_description,L.model),
																														IF(L.other_model_description != '',L.other_model_description,L.other_unit_model)),
																														IF(L.model_description != '',L.model_description,L.model));

SELF.car_series:= ''; 
SELF.car_body_style:= ''; 
SELF.car_cid:= ''; 
SELF.car_carburetion:= ''; 
SELF.car_fuel_code:= ''; 
SELF.truck_chassis_body_style:= ''; 
SELF.truck_wheels_driving_wheels:= ''; 
SELF.truck_cid:= ''; 
SELF.truck_cylinders:= ''; 
SELF.truck_fuel_code:= ''; 
SELF.truck_manufacturers_gvw_code:= ''; 
SELF.truck_ton_rating_code:= ''; 
SELF.truck_series:= ''; 
SELF.truck_model := ''; 
SELF.motorcycle_model := ''; 
SELF.motorcycle_engine_displacement := ''; 
SELF.motorcycle_type_of_bike := ''; 
SELF.motorcycle_cylinder_coding := ''; 
SELF.b_did							:= IF(L.bdid = 0,'',INTFORMAT(L.bdid,12,1)); 
SELF.did								:= IF(L.did = 0,'000000000000',INTFORMAT(L.did,12,1));	
SELF.b_did_score := l.bdid_score; 
SELF.vehicle_use_desc := l.vehicle_use; 
SELF.vehicle_use := ''; 
SELF:= l ; 
SELF := []; 
END; 

pecrash := NORMALIZE(ecrashFile,2,slimrec3(LEFT,COUNTER));

export flc2v_allrecs :=DEDUP(pflc2v+pntl+pecrash,RECORD,ALL): persist('~thor_data400::persist::ecrash2v');

//***************************************************************
//Ecrash3v
//***************************************************************
//Expand Florida file 
flc3v	:= FLAccidents.basefile_flcrash3v;

dx_Ecrash.Layouts.ECRASH3V xpndrecs(flc3v L) := TRANSFORM
SELF.report_code					:= 'FA';
SELF.report_category			:= 'Auto Report';
SELF.report_code_desc		  := 'Auto Accident';
accidentNumber            := STD.Str.Filter(l.accident_nbr,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789');
SELF.accident_nbr         := accidentNumber;
SELF.l_acc_nbr             := accidentNumber; 
SELF.orig_accnbr          := l.accident_nbr; 
SELF 								      := L;
END;
export pflc3v:= PROJECT(flc3v,xpndrecs(LEFT));
//ntlFile := ReadntlFile;
//National file does not have information pertinent to this layout.  Therefore only passing FL records.

//***************************************************************
//Ecrash4
//***************************************************************
//Expand Florida file 
flc4 := FLAccidents.flc4_Keybuild;
flc0 := FLAccidents.basefile_flcrash0;
//using flcrash input file where washington suppression are being removed.  National input file does not have driver phones.
dx_Ecrash.Layouts.ECRASH4 xpndrecs(flc4 L, flc0 R) := TRANSFORM
SELF.report_code					:= 'FA';
SELF.report_category			:= 'Auto Report';
SELF.report_code_desc			:= 'Auto Accident';
SELF.vehicle_id_nbr			  := '';
SELF.vehicle_year					:= '';
SELF.vehicle_make					:= '';
SELF.make_description			:= '';
SELF.model_description	  := '';
SELF.vehicle_incident_city:= STD.Str.ToUpperCase(IF(L.accident_nbr= R.accident_nbr,R.city_town_name,''));
SELF.vehicle_incident_st 	:= 'FL';
SELF.point_of_impact		  := '';
SELF.carrier_name					:= '';
SELF.client_type_id				:= '';
accidentNumber            := STD.Str.Filter(l.accident_nbr,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789');  
SELF.accident_nbr         := accidentNumber;
SELF.l_acc_nbr             := accidentNumber; 
SELF.orig_accnbr          := l.accident_nbr; 
tdriver_dob               := TRIM(l.driver_dob, LEFT, RIGHT);
SELF.driver_dob           := TRIM(TRIM(tdriver_dob[1..4], LEFT, RIGHT) + TRIM(tdriver_dob[5..8], LEFT, RIGHT), LEFT, RIGHT);
SELF.driver_race_desc     :='';
SELF.driver_sex_desc      :='';
SELF.driver_residence_desc:='';
SELF 								      := L;
END;

pflc4 := JOIN(DISTRIBUTE(flc4,HASH32(accident_nbr)), DISTRIBUTE(flc0,HASH32(accident_nbr))
			        ,LEFT.accident_nbr = RIGHT.accident_nbr,
			        xpndrecs(LEFT,RIGHT),LEFT OUTER,LOCAL);
							
//Slim National file  
ntlFile := ReadNtlFile;

pflc4 slimrec(ntlFile L) := TRANSFORM
SELF.did					:= IF(L.did = 0,'000000000000',INTFORMAT(L.did,12,1));
SELF.rec_type_4 	:= '4';
t_accident_nbr 		:= (string40)((unsigned6)L.vehicle_incident_id+10000000000);
t_scrub           := STD.Str.Filter(t_accident_nbr,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789');
accidentNumber    := IF(t_scrub IN ['UNK', 'UNKNOWN'], 'UNK'+l.vehicle_incident_id,t_scrub);  
SELF.accident_nbr := accidentNumber;
SELF.l_acc_nbr     := accidentNumber; 
SELF.orig_accnbr  := t_accident_nbr; 
//------------------------------------
//used for mobileTrac
SELF.vehicle_id_nbr := IF(L.vehVin !=''
										      ,L.vehVin
										      ,IF(L.LAST_NAME+L.FIRST_NAME = L.LAST_NAME_1+L.FIRST_NAME_1,L.vin,''));
SELF.vehicle_year :=IF(L.vehYear !=''
										   ,L.vehYear
										   ,IF(L.LAST_NAME+L.FIRST_NAME = L.LAST_NAME_1+L.FIRST_NAME_1,L.year,''));	
SELF.vehicle_make :=IF(L.vehmake !=''
										   ,L.vehMake
										   ,IF(L.LAST_NAME+L.FIRST_NAME = L.LAST_NAME_1+L.FIRST_NAME_1,L.make,''));
SELF.make_description := IF(L.make_description != '',L.make_description,L.vehMake);
SELF.model_description := IF(L.model_description != '',L.model_description,L.vehModel);
SELF.vehicle_incident_city := L.inc_city;
SELF.vehicle_incident_st := L.state_abbr;
SELF.point_of_impact := L.impact_location;
//------------------------------------
SELF.section_nbr :=  L.vehicle_nbr;
SELF.driver_full_name := MAP(L.LAST_NAME+L.FIRST_NAME = L.LAST_NAME_1+L.FIRST_NAME_1 => L.LAST_NAME  +' '+L.FIRST_NAME+' '+L.MIDDLE_NAME_1
										        ,L.LAST_NAME+L.FIRST_NAME = L.LAST_NAME_2+L.FIRST_NAME_2 => L.LAST_NAME  +' '+L.FIRST_NAME+' '+L.MIDDLE_NAME_2
										        ,L.LAST_NAME+L.FIRST_NAME = L.LAST_NAME_3+L.FIRST_NAME_3 => L.LAST_NAME  +' '+L.FIRST_NAME+' '+L.MIDDLE_NAME_3
										        ,'');
SELF.driver_st_city := IF(L.LAST_NAME+L.FIRST_NAME = L.LAST_NAME_1+L.FIRST_NAME_1,L.city,'');
									
SELF.driver_resident_state 	:= IF(L.LAST_NAME+L.FIRST_NAME = L.LAST_NAME_1+L.FIRST_NAME_1,L.state,'');
SELF.driver_zip := IF(L.LAST_NAME+L.FIRST_NAME = L.LAST_NAME_1+L.FIRST_NAME_1,L.zip5,'');
SELF.driver_dob := TRIM(L.dob, LEFT, RIGHT);
SELF.driver_dl_nbr := IF(L.pty_drivers_license !=''
										     ,L.pty_drivers_license
										     ,IF(L.LAST_NAME+L.FIRST_NAME = L.LAST_NAME_1+L.FIRST_NAME_1,L.drivers_license,''));
SELF.driver_lic_st := IF(L.pty_drivers_license_st !=''
										     ,L.pty_drivers_license_st
										     ,IF(L.LAST_NAME+L.FIRST_NAME = L.LAST_NAME_1+L.FIRST_NAME_1,L.drivers_license_st,''));
SELF.driver_sex := IF(L.LAST_NAME+L.FIRST_NAME = L.LAST_NAME_1+L.FIRST_NAME_1,L.gender_1[1],'');
SELF.addr_suffix := L.suffix;
SELF.ace_fips_st := L.county_code[1..2];
SELF.county := L.county_code[3..5];
SELF.zip := L.zip5;
SELF.score := L.name_score;
SELF.suffix := L.name_suffix;
SELF.cname := STD.Str.ToUpperCase(L.business_name);
SELF.carrier_name := L.LEGAL_NAME;
SELF.ins_company_name := L.LEGAL_NAME;
SELF.ins_policy_nbr := L.POLICY_NBR;
SELF := L;
SELF := [];
END;

pntl := PROJECT(ntlFile(STD.Str.ToUpperCase(party_type) IN ['DRIVER', 'VEHICLE DRIVER']),slimrec(LEFT));

//Slim National inquiry file  
inqFile := ReadInqFile;

pflc4 slimrec3(inqFile L) := TRANSFORM
SELF.report_code					:= 'I'+ L.report_code;
SELF.report_category				:= L.report_category;
SELF.report_code_desc				:= L.report_code_desc;
SELF.did					    := IF(L.did = 0,'000000000000',INTFORMAT(L.did,12,1));
SELF.rec_type_4 			:= '4';
t_accident_nbr := IF(L.vehicle_incident_id[1..3] = 'OID',
													(string40)((unsigned6)L.vehicle_incident_id[4..11]+100000000000),
													(string40)((unsigned6)L.vehicle_incident_id+10000000000));

t_scrub := STD.Str.Filter(t_accident_nbr,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789');
accidentNumber        := IF(t_scrub IN ['UNK', 'UNKNOWN'], 'UNK'+l.vehicle_incident_id,t_scrub); 
SELF.accident_nbr     := accidentNumber;
SELF.l_acc_nbr         := accidentNumber;  
SELF.orig_accnbr      := t_accident_nbr; 
SELF.vehicle_id_nbr		:= L.Vin;
SELF.vehicle_year			:= L.Year;
SELF.vehicle_make			:= L.make;
SELF.make_description				:= IF(L.make_description != '',L.make_description,L.Make);
SELF.model_description			:= IF(L.model_description != '',L.model_description,L.Model);
SELF.vehicle_incident_city	:= '';
SELF.vehicle_incident_st		:= '';
SELF.point_of_impact				:= '';
//------------------------------------
SELF.section_nbr			      := L.vehicle_nbr;
SELF.driver_full_name       := L.LAST_NAME_1  +' '+L.FIRST_NAME_1+' '+L.MIDDLE_NAME_1;
SELF.driver_st_city			    := L.city;
									
SELF.driver_resident_state 	:= L.state;
SELF.driver_zip  			  := L.zip5;
SELF.driver_dob    			:= TRIM(L.dob_1, LEFT, RIGHT);
SELF.driver_dl_nbr			:= L.drivers_license;
SELF.driver_lic_st			:= L.drivers_license_st;
SELF.driver_sex				:= L.gender_1[1];
SELF.addr_suffix 			:= L.suffix;
SELF.ace_fips_st			:= L.county_code[1..2];
SELF.county					  := L.county_code[3..5];
SELF.zip					    := L.zip5;
SELF.score 					  := L.name_score;
SELF.suffix 				  := L.name_suffix;
SELF.cname					  := '';
SELF.filler5 					:= L.claim_nbr;
SELF.carrier_name     := L.legal_name;
SELF.ins_company_name := L.LEGAL_NAME;
SELF.ins_policy_nbr := '';
SELF						:= L;
SELF 						:= [];
END;

pinq := PROJECT(inqFile,slimrec3(LEFT));

// ecrash 
ecrashFile := ReadEcrashFile(STD.Str.ToUpperCase(person_type) IN ['VEHICLE DRIVER', 'DRIVER']); 

pflc4 slimecrash(ecrashFile L, unsigned1 cnt) := TRANSFORM

SELF.vehicle_id_nbr  := IF(L.Other_Unit_VIN !='',CHOOSE(cnt,L.vin,L.Other_Unit_VIN),L.vin);
year					              := TRIM(IF(L.Other_Unit_VIN !='',CHOOSE(cnt,IF(L.model_year != '',L.model_year,L.model_yr),
																														L.other_model_year),
																														IF(L.model_year != '',L.model_year,L.model_yr)),LEFT,RIGHT);																														
SELF.vehicle_year						:= MAP(LENGTH(year) = 2 and year>'50' => '19'+ year,
																	 LENGTH(year) = 2 and year<='50' => '20'+ year,year);
//------------------------------------------------------------	
SELF.vehicle_make					  := IF(L.Other_Unit_VIN !='',CHOOSE(cnt,IF(L.make_description != '',L.make_description,L.make),
																														IF(L.other_make_description != '',L.other_make_description,L.Other_Unit_Make)),
																														IF(L.make_description != '',L.make_description,L.make));
SELF.make_description				:= IF(L.Other_Unit_VIN !='',CHOOSE(cnt,IF(L.make_description != '',L.make_description,L.make),
																														IF(L.other_make_description != '',L.other_make_description,L.Other_Unit_Make)),
																														IF(L.make_description != '',L.make_description,L.make));
SELF.model_description			:= IF(L.Other_Unit_VIN !='',CHOOSE(cnt,IF(L.model_description != '',L.model_description,L.model),
																														IF(L.other_model_description != '',L.other_model_description,L.other_unit_model)),
																														IF(L.model_description != '',L.model_description,L.model));
SELF.vehicle_incident_city	:= STD.Str.ToUpperCase(L.Crash_City);
SELF.vehicle_incident_st		:= STD.Str.ToUpperCase(L.Loss_State_Abbr);

SELF.point_of_impact := l.impact_area1 ; 
SELF.carrier_name     := L.Insurance_Company;
SELF.ins_company_name				:= L.Insurance_Company;
SELF.ins_policy_nbr := L.Insurance_Policy_Number;   
SELF.client_type_id := ''; 
SELF.rec_type_4 := '4'; 
t_accident_nbr 			:= IF(l.source_id IN ['TM','TF'],L.state_report_number, L.case_identifier);
t_scrub := STD.Str.Filter(t_accident_nbr,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789');
accidentNumber := IF(t_scrub IN ['UNK', 'UNKNOWN'], 'UNK'+l.incident_id,t_scrub);
SELF.accident_nbr := accidentNumber;
SELF.l_acc_nbr := accidentNumber; 
SELF.orig_accnbr := t_accident_nbr;
SELF.section_nbr := l.vehicle_unit_number; 
SELF.driver_full_name := TRIM(l.first_name,LEFT,RIGHT)+' '+TRIM(l.middle_name,LEFT,RIGHT) +' '+TRIM(l.last_name ,LEFT,RIGHT); 
SELF.driver_name_suffix := IF(l.name_suffx ='N', '',l.name_suffx) ;  
SELF.driver_st_city := TRIM(l.address,LEFT,RIGHT) +' '+TRIM( l.city,LEFT,RIGHT); 
SELF.driver_resident_state := l.state ;
SELF.driver_zip := l.zip_code; 
SELF.driver_dob := TRIM(l.date_of_birth, LEFT, RIGHT);
SELF.driver_dl_force_asterisk := ''; 
SELF.driver_dl_nbr := l.drivers_license_number;
SELF.driver_lic_st := L.drivers_license_jurisdiction; 
SELF.driver_lic_type :=''; 
SELF.driver_bac_test_type :=''; 
SELF.driver_bac_force_code :=''; 
SELF.driver_bac_test_results :=''; 
SELF.driver_alco_drug_code :=''; 
SELF.driver_physical_defects :=''; 
SELF.driver_residence :='';
SELF.driver_race :=''; 
SELF.driver_sex := '';
SELF.driver_race_desc := l.race; 
SELF.driver_sex_desc  := l.sex;
SELF.driver_residence_desc := l.driver_residence; 

SELF.driver_injury_severity :='';
SELF.first_driver_safety :='';
SELF.second_driver_safety:='';
SELF.driver_eject_code:='';
SELF.recommand_reexam:='';
SELF.driver_phone_nbr:='';
SELF.first_contrib_cause:='';
SELF.second_contrib_cause:='';
SELF.third_contrib_cause:='';
SELF.first_offense_charged:='';
SELF.first_frdl_sys_charge_code :='';
SELF.second_offense_charged :=''; 
SELF.second_frdl_sys_charge_code:=''; 
SELF.third_offense_charged :='';
SELF.third_frdl_sys_charge_code :='';
SELF.first_citation_nbr := l.citation_number1;
SELF.second_citation_nbr := l.citation_number2;
SELF.third_citation_nbr := '';
SELF.driver_fr_injury_cap_code :='';
SELF.dl_nbr_good_bad :='';
SELF.fourth_offense_charged :='';
SELF.fourth_frdl_sys_charge_code :='';
SELF.fifth_offense_charged :='';
SELF.fifth_frdl_sys_charge_code :='';
SELF.sixth_offense_charged :=''; 
SELF.sixth_frdl_sys_charge_code:=''; 
SELF.seveth_offense_charged:=''; 
SELF.seveth_frdl_sys_charge_code:=''; 
SELF.eighth_offense_charged:=''; 
SELF.eighth_frdl_sys_charge_code:=''; 
SELF.fourth_citation_nbr:=''; 
SELF.fifth_citation_nbr:='';
SELF.sixth_citation_nbr:='';
SELF.seventh_citation_nbr:='';
SELF.eighth_citation_nbr:='';
SELF.req_endorsement :=''; 
SELF.oos_dl_nbr:=''; 
SELF.addr_suffix := L.addr_suffix;
SELF.ace_fips_st := L.county_code[1..2];
SELF.county := L.county_code[3..5];
SELF.zip := L.z5;
SELF.zip4 := L.z4;
SELF.score := L.name_score;
SELF.suffix := L.suffix;  
SELF.did := IF(L.did = 0,'000000000000',INTFORMAT(L.did,12,1));	
SELF.cname := l.cname; 

SELF := l; 
SELF := [];
END; 

pecrash := NORMALIZE(ecrashFile,2,slimecrash(LEFT,COUNTER));

export flc4_allrecs := DEDUP(pflc4+pntl+pinq+pecrash,RECORD,ALL): persist('~thor_data400::persist::ecrash4');
//***************************************************************
//Ecrash5
//***************************************************************
//Expand Florida file 
/////////////////////////////////////////////////////////////////
flc5 := FLAccidents.basefile_flcrash5;
//using flcrash input file where washington suppression are being removed.  National input file does not have driver phones.

dx_Ecrash.Layouts.ECRASH5 xpndrecs(flc5 L) := TRANSFORM
SELF.report_code					:= 'FA';
SELF.report_category		  := 'Auto Report';
SELF.report_code_desc		  := 'Auto Accident';
accidentNumber            := STD.Str.Filter(l.accident_nbr,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789');
SELF.accident_nbr         := accidentNumber;
SELF.l_acc_nbr             := accidentNumber; 
SELF.orig_accnbr          := l.accident_nbr; 
SELF 								      := L;
END;

pflc5:= PROJECT(flc5,xpndrecs(LEFT));

//ntlFile := ReadntlFile;
//National file does not have information pertinent to this layout.  Therefore only passing FL records.
ecrashFile := ReadEcrashFile(STD.Str.ToUpperCase(TRIM(person_type)) IN ['\\PASSENGER',
																																													 '3PASSENGER',
																																													 'ÃƒÂ¢?Ã‚Â¢THEY ENTERED: PASSENGER',
																																													 'BICYCLE',
																																													 'BICYCLIST',
																																													 'BYCICLIST',
																																													 'INJURED PASSENGER',
																																													 'OASSENGER',
																																													 'PAASENGER',
																																													 'PAS',
																																													 'PASEENGER',
																																													 'PASENGER',
																																													 'PASS',
																																													 'PASSANGER',
																																													 'PASSE',
																																													 'PASSEBGER',
																																													 'PASSEDNGER',
																																													 'PASSEENGER',
																																													 'PASSEGER',
																																													 'PASSEGNER',
																																													 'PASSEMGER',
																																													 'PASSENDER',
																																													 'PASSENEGER',
																																													 'PASSENEGR',
																																													 'PASSENER',
																																													 'PASSENGER',
																																													 'PASSENGER',
																																													 'PASSENGER1',
																																													 'PASSENGERA',
																																													 'PASSENGERJENNIFER',
																																													 'PASSENGERS',
																																													 'PASSENGERT',
																																													 'PASSENGFER',
																																													 'PASSENGR',
																																													 'PASSENJGER',
																																													 'PASSENNGER',
																																													 'PASSSENGER']); 

dx_Ecrash.Layouts.ECRASH5 xpndecrash(ecrashFile L) := TRANSFORM

SELF.rec_type_5 := '5';
t_accident_nbr 			:= IF(l.source_id IN ['TM','TF'],L.state_report_number, L.case_identifier);
t_scrub := STD.Str.Filter(t_accident_nbr,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789');
accidentNumber := IF(t_scrub IN ['UNK', 'UNKNOWN'], 'UNK'+l.incident_id,t_scrub);
SELF.accident_nbr := accidentNumber;
SELF.l_acc_nbr := accidentNumber; 
SELF.orig_accnbr := t_accident_nbr;
SELF.did := IF(L.did = 0,'000000000000',INTFORMAT(L.did,12,1));	
SELF.section_nbr := l.vehicle_unit_number; 
SELF.passenger_nbr := TRIM(l.passenger_number,LEFT,RIGHT); 
SELF.passenger_full_name := TRIM(l.first_name,LEFT,RIGHT)+' '+TRIM(l.middle_name,LEFT,RIGHT) +' '+TRIM(l.last_name ,LEFT,RIGHT);
SELF.passenger_name_suffix := IF(TRIM(l.name_suffx,LEFT,RIGHT) ='N','',l.name_suffx);
SELF.passenger_st_city := TRIM(l.address,LEFT,RIGHT) +' '+ TRIM(l.city,LEFT,RIGHT); 
SELF.passenger_state := l.state ; 
SELF.passenger_zip := l.zip_code; 
SELF.passenger_age := ''; 
SELF.passenger_location := ''; 
SELF.passenger_injury_sev := ''; 
SELF.first_passenger_safe := ''; 
SELF.second_passenger_safe := ''; 
SELF.passenger_eject_code := ''; 
SELF.passenger_fr_cap_code := ''; 
SELF.addr_suffix := L.addr_suffix ;
SELF.ace_fips_st := L.county_code[1..2];
SELF.county := L.county_code[3..5];
SELF.zip := L.z5;
SELF.zip4 := L.z4;
SELF.score := L.name_score;
SELF.suffix := L.suffix;  
SELF.cname := l.cname; 

SELF := L;
SELF := []; 
END;

pecrash :=PROJECT(ecrashFile, xpndecrash(LEFT)); 

export flc5_ptotal := DEDUP(pflc5+pecrash,ALL); 
//***************************************************************
//Ecrash6
//***************************************************************
//Expand Florida file 
/////////////////////////////////////////////////////////////////
flc6 := FLAccidents.basefile_flcrash6;
//using flcrash input file where washington suppression are being removed.  National input file does not have driver phones.

dx_Ecrash.Layouts.ECRASH6 xpndrecs(flc6 L) := TRANSFORM
SELF.report_code					:= 'FA';
SELF.report_category		  := 'Auto Report';
SELF.report_code_desc		  := 'Auto Accident';
accidentNumber            := STD.Str.Filter(l.accident_nbr,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789');
SELF.accident_nbr         := accidentNumber;
SELF.l_acc_nbr             := accidentNumber; 
SELF.orig_accnbr          := l.accident_nbr;
SELF.ded_dob              := l.ded_dob[5..8]+l.ded_dob[1..4] ;
SELF.ped_race_desc        := '';
SELF.ped_sex_desc         := '';
SELF 								      := L;
END;

pflc6:= PROJECT(flc6,xpndrecs(LEFT));

//ecrash 
ecrashFile := ReadEcrashFile(STD.Str.ToUpperCase(TRIM(person_type)) IN ['PEDALCYCLIST',
																																													 'PEDESTRIAN',
																																								 					 'PEDETRIAN',
																																													 'PEDISTRIAN']); 
dx_Ecrash.Layouts.ECRASH6 xpndecrash(ecrashFile L) := TRANSFORM

  SELF.did							    := IF(L.did = 0,'000000000000',INTFORMAT(L.did,12,1));
  SELF.rec_type_6						:= '6';
  t_accident_nbr 			      := IF(l.source_id IN ['TM','TF'],L.state_report_number, L.case_identifier);
  t_scrub                   := STD.Str.Filter(t_accident_nbr,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789');
  accidentNumber            := IF(t_scrub IN ['UNK', 'UNKNOWN'], 'UNK'+l.incident_id,t_scrub);
	SELF.accident_nbr         := accidentNumber;
  SELF.l_acc_nbr             := accidentNumber; 
  SELF.orig_accnbr          := t_accident_nbr;
  SELF.addr_suffix 				  := L.addr_suffix;
  SELF.ace_fips_st				  := L.county_code[1..2];
  SELF.county							  := L.county_code[3..5];
  SELF.zip							    := L.z5;
  SELF.zip4								  := L.z4;
  SELF.score 							  := L.name_score;
  SELF.suffix 						  := L.suffix;  
  SELF.cname                := l.cname; 
	SELF.pedest_full_name     := TRIM(l.first_name,LEFT,RIGHT)+' '+TRIM(l.middle_name,LEFT,RIGHT) +' '+TRIM(l.last_name ,LEFT,RIGHT);
	SELF.ped_name_suffix      := IF(TRIM(l.name_suffx,LEFT,RIGHT) IN ['N','NUL','NU'], '', l.name_suffx);
	SELF.ped_st_city          := TRIM(l.address,LEFT,RIGHT)+' '+ TRIM(l.city,LEFT,RIGHT); 
	SELF.ped_state            := l.state ; 
	SELF.ped_zip              := l.zip_code; 
	SELF.ded_dob              := l.date_of_birth; 
  SELF.ped_race_desc        := l.race;;
  SELF.ped_sex_desc         := l.sex;
	SELF.section_nbr          := IF(l.vehicle_unit_number='NU','',l.vehicle_unit_number); 
  SELF                      := l; 
  SELF                      := []; 
END; 

pecrash := PROJECT(ecrashFile,xpndecrash(LEFT));  

export flc6_ptotal := DEDUP(pflc6+pecrash,ALL); 
//***************************************************************
//Ecrash7
//***************************************************************
//Expand Florida file 
flc7 := FLAccidents.basefile_flcrash7;
//using flcrash input file where washington suppression are being removed.  National input file does not have driver phones.

dx_Ecrash.Layouts.ECRASH7 xpndrecs(flc7 L) := TRANSFORM
SELF.report_code					:= 'FA';
SELF.report_category		  := 'Auto Report';
SELF.report_code_desc		  := 'Auto Accident';
accidentNumber            := STD.Str.Filter(l.accident_nbr,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789');
SELF.accident_nbr         := accidentNumber;
SELF.l_acc_nbr             := accidentNumber; 
SELF.orig_accnbr          := l.accident_nbr; 
SELF 								      := L;
END;

pflc7:= PROJECT(flc7,xpndrecs(LEFT));

//ecrash 
pecrshFile := ReadEcrashFile( STD.Str.ToUpperCase(TRIM(person_type)) IN ['PROPERTY DAMAGE OWNER','PROPERTY OWNER']); 

dx_Ecrash.Layouts.ECRASH7 xpndecrash(pecrshFile L) := TRANSFORM

SELF.rec_type_7 := '7';
SELF.did := IF(L.did = 0,'000000000000',INTFORMAT(L.did,12,1));
SELF.b_did := IF(L.bdid = 0,'',INTFORMAT(L.bdid,12,1)); 
SELF.b_did_score := l.bdid_score ; 
t_accident_nbr := IF(l.source_id IN ['TM','TF'],L.state_report_number, L.case_identifier);
t_scrub := STD.Str.Filter(t_accident_nbr,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789');
accidentNumber := IF(t_scrub IN ['UNK', 'UNKNOWN'], 'UNK'+l.incident_id,t_scrub);
SELF.accident_nbr := accidentNumber;
SELF.l_acc_nbr := accidentNumber; 
SELF.orig_accnbr := t_accident_nbr;
SELF.prop_damage_nbr := ''; // need to be populated after property damage file added IN prod 
SELF.prop_damaged := l.property_damage_description1;
SELF.prop_damage_code := ''; 
SELF.prop_damage_amount := l.property_damage_estimate1;
SELF.prop_owner_name := TRIM(l.first_name,LEFT,RIGHT)+' '+TRIM(l.middle_name,LEFT,RIGHT) +' '+TRIM(l.last_name ,LEFT,RIGHT);
SELF.prop_owner_suffix := IF(TRIM(l.name_suffx,LEFT,RIGHT) = 'N', '', l.name_suffx);
SELF.prop_owner_st_city := TRIM(l.address,LEFT,RIGHT) + TRIM(l.city,LEFT,RIGHT);
SELF.prop_owner_state := l.state ; 
SELF.prop_owner_zip := l.zip_code; 

SELF.addr_suffix := L.addr_suffix;
SELF.ace_fips_st := L.county_code[1..2];
SELF.county := L.county_code[3..5];
SELF.zip := L.z5;
SELF.zip4 := L.z4;
SELF.score := L.name_score;
SELF.suffix := L.suffix;  
SELF.cname := l.cname; 

SELF := l; 
SELF := [];
END; 

pecrash := PROJECT(pecrshFile, xpndecrash(LEFT)); 

export flc7_ptotal := DEDUP(pflc7+pecrash,ALL); 

END;
