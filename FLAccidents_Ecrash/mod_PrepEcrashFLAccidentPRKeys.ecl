import FLAccidents, STD;
export mod_PrepEcrashFLAccidentPRKeys := module

shared ReadNtlFile := FLAccidents.BaseFile_NtlAccidents_Alpharetta;
shared ReadInqFile := FLAccidents.File_CRU_inquiries;
shared ReadEcrashFile := eCrashBaseAgencyExclusion;
shared ReadEcrashBaseFile := FLAccidents_Ecrash.BaseFile;

//***************************************************************
//Ecrash0
//***************************************************************
//Expand Florida file 
flc0 	:= FLAccidents.basefile_flcrash0;

Layout_PrepEcrashFLAccidentPRKeys.flc0_interim xpndrecs(flc0 L) := transform
self.report_code					:= 'FA';
self.report_category		  := 'Auto Report';
self.report_code_desc		  := 'Auto Accident';
accidentNumber            := STD.Str.Filter(l.accident_nbr,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789');
self.accident_nbr         := accidentNumber;
self.l_acc_nbr             := accidentNumber;
self.orig_accnbr          := l.accident_nbr; 
self 								      := L;
end;
pflc0 := project(flc0,xpndrecs(left));
  
//Slim National file
ntlFile := ReadntlFile;

pflc0 slimrec(ntlFile L) := transform

string8     fSlashedMDYtoCYMD(string pDateIn) :=
								intformat((integer2)regexreplace('.*/.*/([0-9]+)',pDateIn,'$1'),4,1) 
					+     intformat((integer1)regexreplace('([0-9]+)/.*/.*',pDateIn,'$1'),2,1)
					+     intformat((integer1)regexreplace('.*/([0-9]+)/.*',pDateIn,'$1'),2,1);

self.rec_type_o 			    := '0';
t_accident_nbr 			      := (string40)((unsigned6)L.vehicle_incident_id+10000000000);
t_scrub                   := STD.Str.Filter(t_accident_nbr,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789');
accidentNumber            := if(t_scrub in ['UNK', 'UNKNOWN'], 'UNK'+l.vehicle_incident_id,t_scrub);  
self.accident_nbr         := accidentNumber;
self.l_acc_nbr             := accidentNumber;
self.orig_accnbr          := t_accident_nbr; 
self.accident_date				:= fSlashedMDYtoCYMD(L.loss_date[1..10]);
self.city_town_name 		  := stringlib.stringtouppercase(L.inc_city);
     
self						          := L;
self						          := [];
end;
pntl := project(ntlFile,slimrec(left));

// inquiry file 
inqFile := ReadInqFile; 

pflc0 slimrecinq(inqFile L) := transform

string8     fSlashedMDYtoCYMD(string pDateIn) :=
intformat((integer2)regexreplace('.*/.*/([0-9]+)',pDateIn,'$1'),4,1) 
+     intformat((integer1)regexreplace('([0-9]+)/.*/.*',pDateIn,'$1'),2,1)
+     intformat((integer1)regexreplace('.*/([0-9]+)/.*',pDateIn,'$1'),2,1);

self.rec_type_o 			    := '0';
t_accident_nbr            := if(L.vehicle_incident_id[1..3] = 'OID',
													      (string40)((unsigned6)L.vehicle_incident_id[4..11]+100000000000),
													      (string40)((unsigned6)L.vehicle_incident_id+10000000000));
t_scrub                   := STD.Str.Filter(t_accident_nbr,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789');
accidentNumber            := if(t_scrub in ['UNK', 'UNKNOWN'], 'UNK'+l.vehicle_incident_id,t_scrub);  
self.accident_nbr         := accidentNumber;
self.l_acc_nbr             := accidentNumber;
self.orig_accnbr          := t_accident_nbr; 
self.accident_date			  := fSlashedMDYtoCYMD(L.loss_date[1..10]);
self.city_town_name 		  := STD.Str.ToUpperCase(L.city);
self.report_code					:= 'I'+ L.report_code;
self						          := L;
self						          := [];
end;
pInq := project(inqFile,slimrecinq(left));

// ecrash 
ecrashFile := ReadEcrashFile;

pflc0 slimrececrash(ecrashFile L) := transform

self.rec_type_o 			    := '0';
t_accident_nbr 			      := if(l.source_id in['TM','TF'],L.state_report_number, L.case_identifier);
t_scrub                   := STD.Str.Filter(t_accident_nbr,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789');
accidentNumber            := if(t_scrub in ['UNK', 'UNKNOWN'], 'UNK'+l.incident_id,t_scrub);
self.accident_nbr         := accidentNumber;
self.l_acc_nbr             := accidentNumber;
self.orig_accnbr          := t_accident_nbr;
self.accident_date 			  := if(L.incident_id[1..9] ='188188188','20100901',L.crash_date);
self.city_town_name 		  := STD.Str.ToUpperCase(L.crash_city);
self.county_name          := l.crash_county; 
self.ft_miles_node        := l.distance_from_node_miles;
self.dot_milepost         := l.milepost1;
self.at_intersect_of      := l.intersection_related ; 
self.st_road_hhwy_name    :=l.state_highway_related; 
self.city_nbr             := l.city_code; 
self						          := L;
self						          := [];
end;
pecrash := project(ecrashFile,slimrececrash(left));

export flc0_allrecs := dedup(pflc0+pntl+pInq+pecrash,record,all);
                 
//***************************************************************
//Ecrash1
//***************************************************************
//Expand Florida file 
flc1	:= FLAccidents.basefile_flcrash1;

Layout_PrepEcrashFLAccidentPRKeys.flc1_interim xpndrecs(flc1 L) := transform
self.report_code					:= 'FA';
self.report_category		  := 'Auto Report';
self.report_code_desc			:= 'Auto Accident';
accidentNumber            := STD.Str.Filter(l.accident_nbr,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789');
self.accident_nbr         := accidentNumber;
self.l_acc_nbr             := accidentNumber;
self.orig_accnbr          := l.accident_nbr; 
self.invest_agency_desc   := trim(l.dept_name,left,right); 
self 								      := L;
self                      := []; 
end;
pflc1:= project(flc1,xpndrecs(left));
  
//ntlFile := ReadntlFile;
//National file does not have information pertinent to this layout.  Therefore only passing FL records.

ecrashfile := ReadEcrashFile; 

Layout_PrepEcrashFLAccidentPRKeys.flc1_interim xpndecrash(ecrashfile L) := transform

	self.rec_type_1 := '1'; 
	t_accident_nbr := if(l.source_id in ['TM','TF'],L.state_report_number, L.case_identifier);
	t_scrub := STD.Str.Filter(t_accident_nbr,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789');
  accidentNumber := if(t_scrub in ['UNK', 'UNKNOWN'], 'UNK'+l.incident_id,t_scrub); 
	self.accident_nbr := accidentNumber;
  self.l_acc_nbr := accidentNumber;
  self.orig_accnbr := t_accident_nbr;
	self.hr_off_notified :=l.time_notified[1..2];
  self.min_off_notified:=l.time_notified[4..5];
  self.hr_off_arrived:=l.officer_arrival_time[1..2];
  self.min_off_arrived:=l.officer_arrival_time[4..5];
	self.city_nbr := l.city_code; 
	self.site_loc := ''; 
	self.trafficway_char := ''; 
	self.nbr_lanes := l.number_of_lanes; 
	self.divided_undivided := ''; 
	self.total_vehicle_damage := l.vehicle_damage_amount; 
	self.total_nbr_vehicles := l.number_of_vehicles; 
	self.total_nbr_fatalities := l.total_fatal_injuries; 
	self.total_nbr_non_traffic_fatal := l.total_nonfatal_injuries;
	self.invest_name := l.investigating_officer_name; 
	self.invest_rank := l.officer_rank; 
	self.dept_name:=l.officer_department;
	self.report_date:=l.officer_report_date;
	self.first_aid_name :=l.person_first_aid_party_type_description;
	self.first_aid_person_type_desc:=l.person_first_aid_party_type;          //string1   first_aid_person_type,
  self.accident_fault_code_desc := l.primary_fault_indicator;          //string1   accident_fault_code,  
  self.alcohol_drug_desc  := l.alcohol_drug_use;                //string1   alcohol_drug,
  self.accident_damage_severity_desc := l.Damaged_Areas_Severity1;   // string1   accident_damage_severity
  self.invest_agency_desc  := l.agency_name;           //,	string1   invest_agency,
  self.first_harmful_event_desc  := l.first_harmful_event;      //string2   first_harmful_event
  self.light_condition_desc := l.light_condition1;           //string2   light_condition
  self.weather_desc  := l.weather_condition1;                //string2  weather
  self.rd_surface_type_desc := l.road_surface;         //, string2   rd_surface_type, 
  self.type_shoulder_desc := l.shoulder_type;          //, string2   type_shoulder, 
  self.rd_surface_condition_desc := l.road_surface_condition;   //, string2   rd_surface_condition, 
  self.first_contrib_cause_desc := l.contributing_factors1;   //, string2   first_contrib_cause, 
  self.second_contrib_cause_desc := l.contributing_factors2; //, string2   second_contrib_cause, 
  self.first_contrib_envir_desc:= l.contributing_circumstances_environmental1;  // , string2   first_contrib_envir, 
  self.second_contrib_envir_desc:= l.contributing_circumstances_environmental2;  // , string2   second_contrib_envir, 
  self.first_traffic_control_desc:= l.traffic_control_type_at_intersection1;// , string2   first_traffic_control, 
  self.second_traffic_control_desc:= l.traffic_control_type_at_intersection2;//, string2   second_traffic_control 
	self.hr_ems_notified :=l.EMS_Notified_Time[1..2]; //currently this is blank
	self.min_ems_notified:=l.EMS_Notified_Time[4..5];
	self.hr_ems_arrived :=l.EMS_Arrival_Time[1..2];//currently this is blank not sure about the format
	self.min_ems_arrived:=l.EMS_Arrival_Time[4..5];
	self.day_week_desc  := l.day_of_week;
	self.location_type_desc := l.location_type; 
	self.location_type :='';
  self := l ; 
  self:=[];
 end; 
 pecrash := project(ecrashfile, xpndecrash(left)); 
 
export flc1_ptotal := dedup(pflc1+pecrash,all); 

//***************************************************************
//Ecrash2v
//***************************************************************
//Expand Florida file 
flc2v 	:= FLAccidents.basefile_flcrash2v;

Layout_PrepEcrashFLAccidentPRKeys.flc2v_interim xpndrecs(flc2v L,FLAccidents.BaseFile_FLCrash0 R) := transform
self.report_code					:= 'FA';
self.report_category		  := 'Auto Report';
self.report_code_desc			:= 'Auto Accident';
self.vehicle_incident_city:= STD.Str.ToUpperCase(if(L.accident_nbr= R.accident_nbr,R.city_town_name,''));
self.vehicle_incident_st  := 'FL';
self.carrier_name         := l.ins_company_name;
self.client_type_id			  := '';
accidentNumber            := stringlib.StringFilter(l.accident_nbr,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789');
self.accident_nbr         := accidentNumber;
self.l_acc_nbr             := accidentNumber;
self.orig_accnbr          := l.accident_nbr; 
self.vehicle_owner_dob		:=l.vehicle_owner_dob[5..8]+l.vehicle_owner_dob[1..4] ; 
self.direction_travel_desc:= ''; 
self.vehicle_type_desc    := ''; 
self.point_of_impact_desc := ''; 
self.vehicle_use_desc     := ''; 
self 								      := L;
end;

pflc2v := join(distribute(flc2v,hash32(accident_nbr))
			         ,distribute(FLAccidents.BaseFile_FLCrash0,hash32(accident_nbr))
			         ,left.accident_nbr = right.accident_nbr,
			         xpndrecs(left,right),left outer,local);
  
//Slim National file 
ntlFile := ReadntlFile(STD.Str.ToUpperCase(party_type) != 'DRIVER');

pflc2v slimrec1(ntlFile L) := transform
self.did							    := if(L.did = 0,'000000000000',intformat(L.did,12,1));
self.b_did							  := if(L.bdid = 0,'',intformat(L.bdid,12,1)); 
self.b_did_score					:= L.bdid_score;
self.rec_type_2						:= '2';
t_accident_nbr 			      := (string40)((unsigned6)L.vehicle_incident_id+10000000000);
t_scrub                   := STD.Str.Filter(t_accident_nbr,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789');
accidentNumber            := if(t_scrub in ['UNK', 'UNKNOWN'], 'UNK'+l.vehicle_incident_id,t_scrub); 
self.accident_nbr         := accidentNumber;
self.l_acc_nbr             := accidentNumber; 
self.orig_accnbr          := t_accident_nbr; 
self.section_nbr					:= if(L.LAST_NAME+L.FIRST_NAME = L.LAST_NAME_1+L.FIRST_NAME_1,L.vehicle_nbr,'');;
self.vehicle_tag_nbr			:= L.TAG;
self.vehicle_reg_state	  := L.TAG_STATE;
//------------------------------------
//used for mobileTrac
self.vehicle_id_nbr				:= if(L.vehVin !=''
										            ,L.vehVin
										            ,if(L.LAST_NAME+L.FIRST_NAME = L.LAST_NAME_1+L.FIRST_NAME_1,L.vin,''));
self.vehicle_year					:=if(L.vehYear !=''
										           ,L.vehYear
										           ,if(L.LAST_NAME+L.FIRST_NAME = L.LAST_NAME_1+L.FIRST_NAME_1,L.year,''));	
self.vehicle_make					:=if(L.vehmake !=''
										           ,L.vehMake
										           ,if(L.LAST_NAME+L.FIRST_NAME = L.LAST_NAME_1+L.FIRST_NAME_1,L.make,''));
self.make_description     := if(L.make_description != '',L.make_description,L.vehMake);
self.model_description    := if(L.model_description != '',L.model_description,L.vehModel);
self.vehicle_incident_city:= STD.Str.ToUpperCase(L.inc_city);
self.vehicle_incident_st  := STD.Str.ToUpperCase(L.state_abbr);
self.point_of_impact      := '';
self.point_of_impact_desc :=L.impact_location;
//------------------------------------
self.ins_company_name		  := L.LEGAL_NAME;
self.ins_policy_nbr		   	:= L.POLICY_NBR;
self.carrier_name         := L.LEGAL_NAME;
self.vehicle_owner_name	  := map(L.LAST_NAME+L.FIRST_NAME = L.LAST_NAME_1+L.FIRST_NAME_1 => L.LAST_NAME  +' '+L.FIRST_NAME+' '+L.MIDDLE_NAME_1
										             ,'');
self.vehicle_owner_st_city:= if(L.LAST_NAME+L.FIRST_NAME = L.LAST_NAME_1+L.FIRST_NAME_1,L.city,'');
self.vehicle_owner_st     := if(L.LAST_NAME+L.FIRST_NAME = L.LAST_NAME_1+L.FIRST_NAME_1,L.state,'');
self.vehicle_owner_zip	 	:= if(L.LAST_NAME+L.FIRST_NAME = L.LAST_NAME_1+L.FIRST_NAME_1,L.zip5,'');
self.vehicle_owner_dl_nbr := if(L.pty_drivers_license !=''
										            ,L.pty_drivers_license
										            ,if(L.LAST_NAME+L.FIRST_NAME = L.LAST_NAME_1+L.FIRST_NAME_1,L.drivers_license,''));
self.vehicle_owner_dob    := L.dob;
self.vehicle_owner_sex    := if(L.LAST_NAME+L.FIRST_NAME = L.LAST_NAME_1+L.FIRST_NAME_1,L.gender_1[1],'');
self.vehicle_fault_code   := map(L.LAST_NAME+L.FIRST_NAME = L.LAST_NAME_1+L.FIRST_NAME_1 => '1'
										             ,L.LAST_NAME+L.FIRST_NAME = L.LAST_NAME_2+L.FIRST_NAME_2 => '2'
										             ,L.LAST_NAME+L.FIRST_NAME = L.LAST_NAME_3+L.FIRST_NAME_3 => '3'
										             ,'');
self.addr_suffix 					:= L.suffix;
self.ace_fips_st					:= L.county_code[1..2];
self.county							  := L.county_code[3..5];
self.zip							    := L.zip5;
self.score 							  := L.name_score;
self.suffix 						  := L.name_suffix;
self.cname							  := STD.Str.ToUpperCase(L.business_name);

self								      := L;
self								      := [];
end;
pntl := project(ntlFile,slimrec1(left)); 

// ecrash 
ecrashFile := ReadEcrashFile(STD.Str.ToUpperCase(person_type) in ['OWNER','VEHICLE OWNER']); 

pflc2v slimrec3(ecrashFile L, unsigned1 cnt) := transform

self.vehicle_incident_city	:= STD.Str.ToUpperCase(L.Crash_City);
self.vehicle_incident_st		:= STD.Str.ToUpperCase(L.Loss_State_Abbr);
self.carrier_name     := L.Insurance_Company;
self.client_type_id 	:= '';
self.rec_type_2  := '2'; 
t_accident_nbr 			:= if(l.source_id in ['TF','TM'],L.state_report_number, L.case_identifier);
t_scrub := STD.Str.Filter(t_accident_nbr,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789');
accidentNumber := if(t_scrub in ['UNK', 'UNKNOWN'], 'UNK'+l.incident_id,t_scrub);
self.accident_nbr         := accidentNumber;
self.l_acc_nbr             := accidentNumber; 
self.orig_accnbr := t_accident_nbr;
self.section_nbr := l.vehicle_unit_number; 
self.vehicle_owner_driver_code := ''; 
self.vehicle_driver_action := l.driver_actions_at_time_of_crash1; 
self.vehicle_type_desc := l.vehicle_type ; 
self.vehicle_type := ''; 

year					              := trim(if(L.Other_Unit_VIN !='',choose(cnt,if(L.model_year != '',L.model_year,L.model_yr),
																														L.other_model_year),
																														if(L.model_year != '',L.model_year,L.model_yr)),left,right);																														
self.vehicle_year						:= map(length(year) = 2 and year>'50' => '19'+ year,
																	 length(year) = 2 and year<='50' => '20'+ year,year);
self.model_year 						:= map(length(year) = 2 and year>'50' => '19'+ year,
																	 length(year) = 2 and year<='50' => '20'+ year,year);
//------------------------------------------------------------	
self.vehicle_make					  := if(L.Other_Unit_VIN !='',choose(cnt,if(L.make_description != '',L.make_description,L.make),
																														if(L.other_make_description != '',L.other_make_description,L.Other_Unit_Make)),
																														if(L.make_description != '',L.make_description,L.make));

self.vehicle_tag_nbr := if(L.Other_Unit_VIN !='',choose(cnt,L.License_Plate,L.Other_Unit_License_Plate),L.License_Plate);
self.vehicle_reg_state := if(L.Other_Unit_VIN !='',choose(cnt,L.Registration_State,L.Other_Unit_Registration_State),L.Registration_State);
self.vehicle_id_nbr  := if(L.Other_Unit_VIN !='',choose(cnt,L.vin,L.Other_Unit_VIN),L.vin);
self.vehicle_travel_on := '';//l.direction_of_travel_before_crash; 
self.direction_travel := '';//
self.direction_travel_desc := l.direction_of_travel; 
self.est_vehicle_speed := l.estimated_speed ; 
self.posted_speed :=  l.speed_limit_posted; 
self.est_vehicle_damage := l.vehicle_damage_amount ; 
self.damage_type := ''; 
self.ins_company_name :=  L.Insurance_Company;
self.ins_policy_nbr := L.Insurance_Policy_Number;  ; 
self.vehicle_removed_by:= ''; 
self.how_removed_code := ''; 
self.vehicle_owner_name := trim(l.first_name,left,right)+' '+trim(l.middle_name,left,right) +' '+trim(l.last_name ,left,right);
self.vehicle_owner_suffix :=if(trim(l.name_suffx,left,right) ='N','',l.name_suffx);  
self.vehicle_owner_st_city := trim(l.address,left,right)  +' '+ trim(l.city,left,right); 
self.vehicle_owner_st := l.state ; 
self.vehicle_owner_zip := l.zip_code; 
self.vehicle_owner_forge_asterisk := ''; 
self.vehicle_owner_dl_nbr := l.drivers_license_number;
self.vehicle_owner_dob := l.date_of_birth;
self.vehicle_owner_sex := l.sex ; 
self.vehicle_owner_race := l.race; 
self.point_of_impact := l.impact_area1 ; 
self.point_of_impact_desc				:='';

self.vehicle_movement:= '';
self.vehicle_function:= '';
self.vehs_first_defect:= '';
self.vehs_second_defect:= '';
self.vehicle_modified:= '';
self.vehicle_roadway_loc:= '';
self.hazard_material_transport:= '';
self.total_occu_vehicle:= ''; 
self.total_occu_saf_equip:= ''; 
self.moving_violation:= ''; 
self.vehicle_insur_code:= ''; 
self.vehicle_fault_code := ''; 
self.vehicle_cap_code:= ''; 
self.vehicle_fr_code := ''; 
self.placarded := ''; 
self.dhsmv_vehicle_ind := ''; 
self.addr_suffix 					:= L.addr_suffix;
self.ace_fips_st					:= L.county_code[1..2];
self.county							:= L.county_code[3..5];
self.zip							:= L.z5;
self.zip4								:= L.z4;
self.score 							:= L.name_score;
self.suffix 						:= L.suffix;  
self.cname              := l.cname; 
self.match_code := ''; 
self.manufacturer_corporation := ''; 
self.division_code := '';
self.vehicle_group_code := ''; 
self.vehicle_subgroup_code := ''; 
self.vehicle_series_code := ''; 
self.vehicle_abbreviation := ''; 
self.assembly_country := ''; 
self.headquarter_country:= ''; 
self.number_of_doors := ''; 
self.seating_capacity := '';//l.seating_position_seat; add when silverlight is live 
self.number_of_cylinders := ''; 
self.carburetion_type := ''; 
self.number_of_barrels:= ''; 
self.price_class_code := ''; 
self.body_size_code := ''; 
self.number_of_wheels_on_road:= ''; 
self.drive_type := ''; 
self.gvw_code := ''; 
self.load_capacity_code :=''; 
self.cab_type_code := ''; 
self.bed_length := ''; 
self.rim_size := ''; 
self.manufacture_body_style :=  l.body_style_code; 
self.vehicle_type_code := ''; 
self.car_line_code := ''; 
self.car_series_code :=''; 
self.car_body_style_code := ''; 
self.engine_cylinder_code := ''; 
self.truck_make_abbreviation  := '';
self.truck_body_style_abbreviation := ''; 
self.motorcycle_make_abbreviation := ''; 
self.reference_number := l.vendor_reference_number; 
self.make_description				:= if(L.Other_Unit_VIN !='',choose(cnt,if(L.make_description != '',L.make_description,L.make),
																														if(L.other_make_description != '',L.other_make_description,L.Other_Unit_Make)),
																														if(L.make_description != '',L.make_description,L.make));
self.model_description			:= if(L.Other_Unit_VIN !='',choose(cnt,if(L.model_description != '',L.model_description,L.model),
																														if(L.other_model_description != '',L.other_model_description,L.other_unit_model)),
																														if(L.model_description != '',L.model_description,L.model));

self.car_series:= ''; 
self.car_body_style:= ''; 
self.car_cid:= ''; 
self.car_carburetion:= ''; 
self.car_fuel_code:= ''; 
self.truck_chassis_body_style:= ''; 
self.truck_wheels_driving_wheels:= ''; 
self.truck_cid:= ''; 
self.truck_cylinders:= ''; 
self.truck_fuel_code:= ''; 
self.truck_manufacturers_gvw_code:= ''; 
self.truck_ton_rating_code:= ''; 
self.truck_series:= ''; 
self.truck_model := ''; 
self.motorcycle_model := ''; 
self.motorcycle_engine_displacement := ''; 
self.motorcycle_type_of_bike := ''; 
self.motorcycle_cylinder_coding := ''; 
self.b_did							:= if(L.bdid = 0,'',intformat(L.bdid,12,1)); 
self.did								:= if(L.did = 0,'000000000000',intformat(L.did,12,1));	
self.b_did_score := l.bdid_score; 
self.vehicle_use_desc := l.vehicle_use; 
self.vehicle_use := ''; 
self:= l ; 
self := []; 
end; 

pecrash := normalize(ecrashFile,2,slimrec3(left,counter));

export flc2v_allrecs :=dedup(pflc2v+pntl+pecrash,record,all): persist('~thor_data400::persist::ecrash2v');

//***************************************************************
//Ecrash3v
//***************************************************************
//Expand Florida file 
flc3v	:= FLAccidents.basefile_flcrash3v;

Layout_PrepEcrashFLAccidentPRKeys.flc3v_interim xpndrecs(flc3v L) := transform
self.report_code					:= 'FA';
self.report_category			:= 'Auto Report';
self.report_code_desc		  := 'Auto Accident';
accidentNumber            := STD.Str.Filter(l.accident_nbr,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789');
self.accident_nbr         := accidentNumber;
self.l_acc_nbr             := accidentNumber; 
self.orig_accnbr          := l.accident_nbr; 
self 								      := L;
end;
export pflc3v:= project(flc3v,xpndrecs(left));
//ntlFile := ReadntlFile;
//National file does not have information pertinent to this layout.  Therefore only passing FL records.

//***************************************************************
//Ecrash4
//***************************************************************
//Expand Florida file 
flc4 := FLAccidents.flc4_Keybuild;
flc0 := FLAccidents.basefile_flcrash0;
//using flcrash input file where washington suppression are being removed.  National input file does not have driver phones.
Layout_PrepEcrashFLAccidentPRKeys.flc4_interim xpndrecs(flc4 L, flc0 R) := transform
self.report_code					:= 'FA';
self.report_category			:= 'Auto Report';
self.report_code_desc			:= 'Auto Accident';
self.vehicle_id_nbr			  := '';
self.vehicle_year					:= '';
self.vehicle_make					:= '';
self.make_description			:= '';
self.model_description	  := '';
self.vehicle_incident_city:= STD.Str.ToUpperCase(if(L.accident_nbr= R.accident_nbr,R.city_town_name,''));
self.vehicle_incident_st 	:= 'FL';
self.point_of_impact		  := '';
self.carrier_name					:= '';
self.client_type_id				:= '';
accidentNumber            := STD.Str.Filter(l.accident_nbr,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789');  
self.accident_nbr         := accidentNumber;
self.l_acc_nbr             := accidentNumber; 
self.orig_accnbr          := l.accident_nbr; 
tdriver_dob               := TRIM(l.driver_dob, LEFT, RIGHT);
self.driver_dob           := TRIM(TRIM(tdriver_dob[1..4], LEFT, RIGHT) + TRIM(tdriver_dob[5..8], LEFT, RIGHT), LEFT, RIGHT);
self.driver_race_desc     :='';
self.driver_sex_desc      :='';
self.driver_residence_desc:='';
self 								      := L;
end;

pflc4 := join(distribute(flc4,hash32(accident_nbr)), distribute(flc0,hash32(accident_nbr))
			        ,left.accident_nbr = right.accident_nbr,
			        xpndrecs(left,right),left outer,local);
							
//Slim National file  
ntlFile := ReadNtlFile;

pflc4 slimrec(ntlFile L) := transform
self.did					:= if(L.did = 0,'000000000000',intformat(L.did,12,1));
self.rec_type_4 	:= '4';
t_accident_nbr 		:= (string40)((unsigned6)L.vehicle_incident_id+10000000000);
t_scrub           := STD.Str.Filter(t_accident_nbr,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789');
accidentNumber    := if(t_scrub in ['UNK', 'UNKNOWN'], 'UNK'+l.vehicle_incident_id,t_scrub);  
self.accident_nbr := accidentNumber;
self.l_acc_nbr     := accidentNumber; 
self.orig_accnbr  := t_accident_nbr; 
//------------------------------------
//used for mobileTrac
self.vehicle_id_nbr := if(L.vehVin !=''
										      ,L.vehVin
										      ,if(L.LAST_NAME+L.FIRST_NAME = L.LAST_NAME_1+L.FIRST_NAME_1,L.vin,''));
self.vehicle_year :=if(L.vehYear !=''
										   ,L.vehYear
										   ,if(L.LAST_NAME+L.FIRST_NAME = L.LAST_NAME_1+L.FIRST_NAME_1,L.year,''));	
self.vehicle_make :=if(L.vehmake !=''
										   ,L.vehMake
										   ,if(L.LAST_NAME+L.FIRST_NAME = L.LAST_NAME_1+L.FIRST_NAME_1,L.make,''));
self.make_description := if(L.make_description != '',L.make_description,L.vehMake);
self.model_description := if(L.model_description != '',L.model_description,L.vehModel);
self.vehicle_incident_city := L.inc_city;
self.vehicle_incident_st := L.state_abbr;
self.point_of_impact := L.impact_location;
//------------------------------------
self.section_nbr :=  L.vehicle_nbr;
self.driver_full_name := map(L.LAST_NAME+L.FIRST_NAME = L.LAST_NAME_1+L.FIRST_NAME_1 => L.LAST_NAME  +' '+L.FIRST_NAME+' '+L.MIDDLE_NAME_1
										        ,L.LAST_NAME+L.FIRST_NAME = L.LAST_NAME_2+L.FIRST_NAME_2 => L.LAST_NAME  +' '+L.FIRST_NAME+' '+L.MIDDLE_NAME_2
										        ,L.LAST_NAME+L.FIRST_NAME = L.LAST_NAME_3+L.FIRST_NAME_3 => L.LAST_NAME  +' '+L.FIRST_NAME+' '+L.MIDDLE_NAME_3
										        ,'');
self.driver_st_city := if(L.LAST_NAME+L.FIRST_NAME = L.LAST_NAME_1+L.FIRST_NAME_1,L.city,'');
									
self.driver_resident_state 	:= if(L.LAST_NAME+L.FIRST_NAME = L.LAST_NAME_1+L.FIRST_NAME_1,L.state,'');
self.driver_zip := if(L.LAST_NAME+L.FIRST_NAME = L.LAST_NAME_1+L.FIRST_NAME_1,L.zip5,'');
self.driver_dob := TRIM(L.dob, LEFT, RIGHT);
self.driver_dl_nbr := if(L.pty_drivers_license !=''
										     ,L.pty_drivers_license
										     ,if(L.LAST_NAME+L.FIRST_NAME = L.LAST_NAME_1+L.FIRST_NAME_1,L.drivers_license,''));
self.driver_lic_st := if(L.pty_drivers_license_st !=''
										     ,L.pty_drivers_license_st
										     ,if(L.LAST_NAME+L.FIRST_NAME = L.LAST_NAME_1+L.FIRST_NAME_1,L.drivers_license_st,''));
self.driver_sex := if(L.LAST_NAME+L.FIRST_NAME = L.LAST_NAME_1+L.FIRST_NAME_1,L.gender_1[1],'');
self.addr_suffix := L.suffix;
self.ace_fips_st := L.county_code[1..2];
self.county := L.county_code[3..5];
self.zip := L.zip5;
self.score := L.name_score;
self.suffix := L.name_suffix;
self.cname := STD.Str.ToUpperCase(L.business_name);
self.carrier_name := L.LEGAL_NAME;
self.ins_company_name := L.LEGAL_NAME;
self.ins_policy_nbr := L.POLICY_NBR;
self := L;
self := [];
end;

pntl := project(ntlFile(STD.Str.ToUpperCase(party_type) in ['DRIVER', 'VEHICLE DRIVER']),slimrec(left));

//Slim National inquiry file  
inqFile := ReadInqFile;

pflc4 slimrec3(inqFile L) := transform
self.report_code					:= 'I'+ L.report_code;
self.report_category				:= L.report_category;
self.report_code_desc				:= L.report_code_desc;
self.did					    := if(L.did = 0,'000000000000',intformat(L.did,12,1));
self.rec_type_4 			:= '4';
t_accident_nbr := if(L.vehicle_incident_id[1..3] = 'OID',
													(string40)((unsigned6)L.vehicle_incident_id[4..11]+100000000000),
													(string40)((unsigned6)L.vehicle_incident_id+10000000000));

t_scrub := STD.Str.Filter(t_accident_nbr,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789');
accidentNumber        := if(t_scrub in ['UNK', 'UNKNOWN'], 'UNK'+l.vehicle_incident_id,t_scrub); 
self.accident_nbr     := accidentNumber;
self.l_acc_nbr         := accidentNumber;  
self.orig_accnbr      := t_accident_nbr; 
self.vehicle_id_nbr		:= L.Vin;
self.vehicle_year			:= L.Year;
self.vehicle_make			:= L.make;
self.make_description				:= if(L.make_description != '',L.make_description,L.Make);
self.model_description			:= if(L.model_description != '',L.model_description,L.Model);
self.vehicle_incident_city	:= '';
self.vehicle_incident_st		:= '';
self.point_of_impact				:= '';
//------------------------------------
self.section_nbr			      := L.vehicle_nbr;
self.driver_full_name       := L.LAST_NAME_1  +' '+L.FIRST_NAME_1+' '+L.MIDDLE_NAME_1;
self.driver_st_city			    := L.city;
									
self.driver_resident_state 	:= L.state;
self.driver_zip  			  := L.zip5;
self.driver_dob    			:= TRIM(L.dob_1, LEFT, RIGHT);
self.driver_dl_nbr			:= L.drivers_license;
self.driver_lic_st			:= L.drivers_license_st;
self.driver_sex				:= L.gender_1[1];
self.addr_suffix 			:= L.suffix;
self.ace_fips_st			:= L.county_code[1..2];
self.county					  := L.county_code[3..5];
self.zip					    := L.zip5;
self.score 					  := L.name_score;
self.suffix 				  := L.name_suffix;
self.cname					  := '';
self.filler5 					:= L.claim_nbr;
self.carrier_name     := L.legal_name;
self.ins_company_name := L.LEGAL_NAME;
self.ins_policy_nbr := '';
self						:= L;
self 						:= [];
end;

pinq := project(inqFile,slimrec3(left));

// ecrash 
ecrashFile := ReadEcrashFile(STD.Str.ToUpperCase(person_type) in ['VEHICLE DRIVER', 'DRIVER']); 

pflc4 slimecrash(ecrashFile L, unsigned1 cnt) := transform

self.vehicle_id_nbr  := if(L.Other_Unit_VIN !='',choose(cnt,L.vin,L.Other_Unit_VIN),L.vin);
year					              := trim(if(L.Other_Unit_VIN !='',choose(cnt,if(L.model_year != '',L.model_year,L.model_yr),
																														L.other_model_year),
																														if(L.model_year != '',L.model_year,L.model_yr)),left,right);																														
self.vehicle_year						:= map(length(year) = 2 and year>'50' => '19'+ year,
																	 length(year) = 2 and year<='50' => '20'+ year,year);
//------------------------------------------------------------	
self.vehicle_make					  := if(L.Other_Unit_VIN !='',choose(cnt,if(L.make_description != '',L.make_description,L.make),
																														if(L.other_make_description != '',L.other_make_description,L.Other_Unit_Make)),
																														if(L.make_description != '',L.make_description,L.make));
self.make_description				:= if(L.Other_Unit_VIN !='',choose(cnt,if(L.make_description != '',L.make_description,L.make),
																														if(L.other_make_description != '',L.other_make_description,L.Other_Unit_Make)),
																														if(L.make_description != '',L.make_description,L.make));
self.model_description			:= if(L.Other_Unit_VIN !='',choose(cnt,if(L.model_description != '',L.model_description,L.model),
																														if(L.other_model_description != '',L.other_model_description,L.other_unit_model)),
																														if(L.model_description != '',L.model_description,L.model));
self.vehicle_incident_city	:= STD.Str.ToUpperCase(L.Crash_City);
self.vehicle_incident_st		:= STD.Str.ToUpperCase(L.Loss_State_Abbr);

self.point_of_impact := l.impact_area1 ; 
self.carrier_name     := L.Insurance_Company;
self.ins_company_name				:= L.Insurance_Company;
self.ins_policy_nbr := L.Insurance_Policy_Number;   
self.client_type_id := ''; 
self.rec_type_4 := '4'; 
t_accident_nbr 			:= if(l.source_id in ['TM','TF'],L.state_report_number, L.case_identifier);
t_scrub := STD.Str.Filter(t_accident_nbr,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789');
accidentNumber := if(t_scrub in ['UNK', 'UNKNOWN'], 'UNK'+l.incident_id,t_scrub);
self.accident_nbr := accidentNumber;
self.l_acc_nbr := accidentNumber; 
self.orig_accnbr := t_accident_nbr;
self.section_nbr := l.vehicle_unit_number; 
self.driver_full_name := trim(l.first_name,left,right)+' '+trim(l.middle_name,left,right) +' '+trim(l.last_name ,left,right); 
self.driver_name_suffix := if(l.name_suffx ='N', '',l.name_suffx) ;  
self.driver_st_city := trim(l.address,left,right) +' '+trim( l.city,left,right); 
self.driver_resident_state := l.state ;
self.driver_zip := l.zip_code; 
self.driver_dob := TRIM(l.date_of_birth, LEFT, RIGHT);
self.driver_dl_force_asterisk := ''; 
self.driver_dl_nbr := l.drivers_license_number;
self.driver_lic_st := L.drivers_license_jurisdiction; 
self.driver_lic_type :=''; 
self.driver_bac_test_type :=''; 
self.driver_bac_force_code :=''; 
self.driver_bac_test_results :=''; 
self.driver_alco_drug_code :=''; 
self.driver_physical_defects :=''; 
self.driver_residence :='';
self.driver_race :=''; 
self.driver_sex := '';
self.driver_race_desc := l.race; 
self.driver_sex_desc  := l.sex;
self.driver_residence_desc := l.driver_residence; 

self.driver_injury_severity :='';
self.first_driver_safety :='';
self.second_driver_safety:='';
self.driver_eject_code:='';
self.recommand_reexam:='';
self.driver_phone_nbr:='';
self.first_contrib_cause:='';
self.second_contrib_cause:='';
self.third_contrib_cause:='';
self.first_offense_charged:='';
self.first_frdl_sys_charge_code :='';
self.second_offense_charged :=''; 
self.second_frdl_sys_charge_code:=''; 
self.third_offense_charged :='';
self.third_frdl_sys_charge_code :='';
self.first_citation_nbr := l.citation_number1;
self.second_citation_nbr := l.citation_number2;
self.third_citation_nbr := '';
self.driver_fr_injury_cap_code :='';
self.dl_nbr_good_bad :='';
self.fourth_offense_charged :='';
self.fourth_frdl_sys_charge_code :='';
self.fifth_offense_charged :='';
self.fifth_frdl_sys_charge_code :='';
self.sixth_offense_charged :=''; 
self.sixth_frdl_sys_charge_code:=''; 
self.seveth_offense_charged:=''; 
self.seveth_frdl_sys_charge_code:=''; 
self.eighth_offense_charged:=''; 
self.eighth_frdl_sys_charge_code:=''; 
self.fourth_citation_nbr:=''; 
self.fifth_citation_nbr:='';
self.sixth_citation_nbr:='';
self.seventh_citation_nbr:='';
self.eighth_citation_nbr:='';
self.req_endorsement :=''; 
self.oos_dl_nbr:=''; 
self.addr_suffix := L.addr_suffix;
self.ace_fips_st := L.county_code[1..2];
self.county := L.county_code[3..5];
self.zip := L.z5;
self.zip4 := L.z4;
self.score := L.name_score;
self.suffix := L.suffix;  
self.did := if(L.did = 0,'000000000000',intformat(L.did,12,1));	
self.cname := l.cname; 

self := l; 
self := [];
end; 

pecrash := normalize(ecrashFile,2,slimecrash(left,counter));

export flc4_allrecs := dedup(pflc4+pntl+pinq+pecrash,record,all): persist('~thor_data400::persist::ecrash4');
//***************************************************************
//Ecrash5
//***************************************************************
//Expand Florida file 
/////////////////////////////////////////////////////////////////
flc5 := FLAccidents.basefile_flcrash5;
//using flcrash input file where washington suppression are being removed.  National input file does not have driver phones.

Layout_PrepEcrashFLAccidentPRKeys.flc5_interim xpndrecs(flc5 L) := transform
self.report_code					:= 'FA';
self.report_category		  := 'Auto Report';
self.report_code_desc		  := 'Auto Accident';
accidentNumber            := STD.Str.Filter(l.accident_nbr,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789');
self.accident_nbr         := accidentNumber;
self.l_acc_nbr             := accidentNumber; 
self.orig_accnbr          := l.accident_nbr; 
self 								      := L;
end;

pflc5:= project(flc5,xpndrecs(left));

//ntlFile := ReadntlFile;
//National file does not have information pertinent to this layout.  Therefore only passing FL records.
ecrashFile := ReadEcrashFile(STD.Str.ToUpperCase(trim(person_type)) in ['\\PASSENGER',
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

Layout_PrepEcrashFLAccidentPRKeys.flc5_interim xpndecrash(ecrashFile L) := transform

self.rec_type_5 := '5';
t_accident_nbr 			:= if(l.source_id in ['TM','TF'],L.state_report_number, L.case_identifier);
t_scrub := STD.Str.Filter(t_accident_nbr,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789');
accidentNumber := if(t_scrub in ['UNK', 'UNKNOWN'], 'UNK'+l.incident_id,t_scrub);
self.accident_nbr := accidentNumber;
self.l_acc_nbr := accidentNumber; 
self.orig_accnbr := t_accident_nbr;
self.did := if(L.did = 0,'000000000000',intformat(L.did,12,1));	
self.section_nbr := l.vehicle_unit_number; 
self.passenger_nbr := trim(l.passenger_number,left,right); 
self.passenger_full_name := trim(l.first_name,left,right)+' '+trim(l.middle_name,left,right) +' '+trim(l.last_name ,left,right);
self.passenger_name_suffix := if(trim(l.name_suffx,left,right) ='N','',l.name_suffx);
self.passenger_st_city := trim(l.address,left,right) +' '+ trim(l.city,left,right); 
self.passenger_state := l.state ; 
self.passenger_zip := l.zip_code; 
self.passenger_age := ''; 
self.passenger_location := ''; 
self.passenger_injury_sev := ''; 
self.first_passenger_safe := ''; 
self.second_passenger_safe := ''; 
self.passenger_eject_code := ''; 
self.passenger_fr_cap_code := ''; 
self.addr_suffix := L.addr_suffix ;
self.ace_fips_st := L.county_code[1..2];
self.county := L.county_code[3..5];
self.zip := L.z5;
self.zip4 := L.z4;
self.score := L.name_score;
self.suffix := L.suffix;  
self.cname := l.cname; 

self := L;
self := []; 
end;

pecrash :=project(ecrashFile, xpndecrash(left)); 

export flc5_ptotal := dedup(pflc5+pecrash,all); 
//***************************************************************
//Ecrash6
//***************************************************************
//Expand Florida file 
/////////////////////////////////////////////////////////////////
flc6 := FLAccidents.basefile_flcrash6;
//using flcrash input file where washington suppression are being removed.  National input file does not have driver phones.

Layout_PrepEcrashFLAccidentPRKeys.flc6_interim xpndrecs(flc6 L) := transform
self.report_code					:= 'FA';
self.report_category		  := 'Auto Report';
self.report_code_desc		  := 'Auto Accident';
accidentNumber            := STD.Str.Filter(l.accident_nbr,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789');
self.accident_nbr         := accidentNumber;
self.l_acc_nbr             := accidentNumber; 
self.orig_accnbr          := l.accident_nbr;
self.ded_dob              := l.ded_dob[5..8]+l.ded_dob[1..4] ;
self.ped_race_desc        := '';
self.ped_sex_desc         := '';
self 								      := L;
end;

pflc6:= project(flc6,xpndrecs(left));

//ecrash 
ecrashFile := ReadEcrashFile(STD.Str.ToUpperCase(trim(person_type)) in ['PEDALCYCLIST',
																																													 'PEDESTRIAN',
																																								 					 'PEDETRIAN',
																																													 'PEDISTRIAN']); 
Layout_PrepEcrashFLAccidentPRKeys.flc6_interim xpndecrash(ecrashFile L) := transform

  self.did							    := if(L.did = 0,'000000000000',intformat(L.did,12,1));
  self.rec_type_6						:= '6';
  t_accident_nbr 			      := if(l.source_id in ['TM','TF'],L.state_report_number, L.case_identifier);
  t_scrub                   := STD.Str.Filter(t_accident_nbr,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789');
  accidentNumber            := if(t_scrub in ['UNK', 'UNKNOWN'], 'UNK'+l.incident_id,t_scrub);
	self.accident_nbr         := accidentNumber;
  self.l_acc_nbr             := accidentNumber; 
  self.orig_accnbr          := t_accident_nbr;
  self.addr_suffix 				  := L.addr_suffix;
  self.ace_fips_st				  := L.county_code[1..2];
  self.county							  := L.county_code[3..5];
  self.zip							    := L.z5;
  self.zip4								  := L.z4;
  self.score 							  := L.name_score;
  self.suffix 						  := L.suffix;  
  self.cname                := l.cname; 
	self.pedest_full_name     := trim(l.first_name,left,right)+' '+trim(l.middle_name,left,right) +' '+trim(l.last_name ,left,right);
	self.ped_name_suffix      := if(trim(l.name_suffx,left,right) in ['N','NUL','NU'], '', l.name_suffx);
	self.ped_st_city          := trim(l.address,left,right)+' '+ trim(l.city,left,right); 
	self.ped_state            := l.state ; 
	self.ped_zip              := l.zip_code; 
	self.ded_dob              := l.date_of_birth; 
  self.ped_race_desc        := l.race;;
  self.ped_sex_desc         := l.sex;
	self.section_nbr          := if(l.vehicle_unit_number='NU','',l.vehicle_unit_number); 
  self                      := l; 
  self                      := []; 
end; 

pecrash := project(ecrashFile,xpndecrash(left));  

export flc6_ptotal := dedup(pflc6+pecrash,all); 
//***************************************************************
//Ecrash7
//***************************************************************
//Expand Florida file 
flc7 := FLAccidents.basefile_flcrash7;
//using flcrash input file where washington suppression are being removed.  National input file does not have driver phones.

Layout_PrepEcrashFLAccidentPRKeys.flc7_interim xpndrecs(flc7 L) := transform
self.report_code					:= 'FA';
self.report_category		  := 'Auto Report';
self.report_code_desc		  := 'Auto Accident';
accidentNumber            := STD.Str.Filter(l.accident_nbr,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789');
self.accident_nbr         := accidentNumber;
self.l_acc_nbr             := accidentNumber; 
self.orig_accnbr          := l.accident_nbr; 
self 								      := L;
end;

pflc7:= project(flc7,xpndrecs(left));

//ecrash 
pecrshFile := ReadEcrashFile( STD.Str.ToUpperCase(trim(person_type)) in ['PROPERTY DAMAGE OWNER','PROPERTY OWNER']); 

Layout_PrepEcrashFLAccidentPRKeys.flc7_interim xpndecrash(pecrshFile L) := transform

self.rec_type_7 := '7';
self.did := if(L.did = 0,'000000000000',intformat(L.did,12,1));
self.b_did := if(L.bdid = 0,'',intformat(L.bdid,12,1)); 
self.b_did_score := l.bdid_score ; 
t_accident_nbr := if(l.source_id in ['TM','TF'],L.state_report_number, L.case_identifier);
t_scrub := STD.Str.Filter(t_accident_nbr,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789');
accidentNumber := if(t_scrub in ['UNK', 'UNKNOWN'], 'UNK'+l.incident_id,t_scrub);
self.accident_nbr := accidentNumber;
self.l_acc_nbr := accidentNumber; 
self.orig_accnbr := t_accident_nbr;
self.prop_damage_nbr := ''; // need to be populated after property damage file added in prod 
self.prop_damaged := l.property_damage_description1;
self.prop_damage_code := ''; 
self.prop_damage_amount := l.property_damage_estimate1;
self.prop_owner_name := trim(l.first_name,left,right)+' '+trim(l.middle_name,left,right) +' '+trim(l.last_name ,left,right);
self.prop_owner_suffix := if(trim(l.name_suffx,left,right) = 'N', '', l.name_suffx);
self.prop_owner_st_city := trim(l.address,left,right) + trim(l.city,left,right);
self.prop_owner_state := l.state ; 
self.prop_owner_zip := l.zip_code; 

self.addr_suffix := L.addr_suffix;
self.ace_fips_st := L.county_code[1..2];
self.county := L.county_code[3..5];
self.zip := L.z5;
self.zip4 := L.z4;
self.score := L.name_score;
self.suffix := L.suffix;  
self.cname := l.cname; 

self := l; 
self := [];
end; 

pecrash := project(pecrshFile, xpndecrash(left)); 

export flc7_ptotal := dedup(pflc7+pecrash,all); 
//***************************************************************
//Ecrash8
//***************************************************************

//Expand Florida file 
flc8 := FLAccidents.basefile_flcrash8;
//using flcrash input file where washington suppression are being removed.  National input file does not have driver phones.

Layout_PrepEcrashFLAccidentPRKeys.flc8_interim xpndrecs(flc8 L) := transform
self.report_code := 'FA';
self.report_category := 'Auto Report';
self.report_code_desc := 'Auto Accident';
accidentNumber := STD.Str.Filter(l.accident_nbr,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789');
self.accident_nbr := accidentNumber;
self.l_acc_nbr := accidentNumber; 
self.orig_accnbr := l.accident_nbr; 
self := L;
end;

pflc8:= project(flc8,xpndrecs(left));
//ntlFile := ReadntlFile;
//National file does not have information pertinent to this layout.  Therefore only passing FL records.

ecrashBaseFile  := ReadEcrashBaseFile;

Layout_PrepEcrashFLAccidentPRKeys.flc8_interim xpndecrash(ecrashBaseFile L) := transform

self.rec_type_8 := '8';
t_accident_nbr := if(l.source_id in ['TF','TM'],L.state_report_number, L.case_identifier);
t_scrub := STD.Str.Filter(t_accident_nbr,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789');
accidentNumber := if(t_scrub in ['UNK', 'UNKNOWN'], 'UNK'+l.incident_id,t_scrub);
self.accident_nbr := accidentNumber;
self.l_acc_nbr := accidentNumber; 
self.orig_accnbr := t_accident_nbr;
self.carrier_name := L.Insurance_Company;

self := l; 
self := [];
end; 

pecrash := project(ecrashBaseFile, xpndecrash(left)); 

export flc8_ptotal :=dedup(pflc8+pecrash,all); 

end;