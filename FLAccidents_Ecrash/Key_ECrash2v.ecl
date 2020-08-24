Import doxie, FLAccidents, data_services;

/////////////////////////////////////////////////////////////////
//Expand Florida file 
/////////////////////////////////////////////////////////////////
flc2v 	:= FLAccidents.basefile_flcrash2v;
xpnd_layout := record
    string2 report_code;
    string25 report_category;
    string65 report_code_desc;
	string25 vehicle_incident_city;
	string2 vehicle_incident_st;
	string40 carrier_name;
	string5	client_type_id;
  	string12 did,
	unsigned1 did_score,
	string12 b_did, 
    unsigned1 b_did_score,
	string1   rec_type_2,
	string40  accident_nbr,
	string2   section_nbr,
	string2   filler1,
	string1   vehicle_owner_driver_code,
	string1   vehicle_driver_action,
	string4   vehicle_year,
	string4   vehicle_make,
	string2   vehicle_type,
	string8   vehicle_tag_nbr,
	string2   vehicle_reg_state,
	string22  vehicle_id_nbr,
	string36  vehicle_travel_on,
	string1   direction_travel,
	string3   est_vehicle_speed,
	string2   posted_speed,
	string7   est_vehicle_damage,
	string1   damage_type,
	string41  ins_company_name,
	string25  ins_policy_nbr,
	string25  vehicle_removed_by,
	string1   how_removed_code,
	string25  vehicle_owner_name,
	string16  filler2,
	string1   vehicle_owner_suffix,
	string150  vehicle_owner_st_city,
	string18  filler3,
	string2   vehicle_owner_st,
	string9   vehicle_owner_zip,
	string1   vehicle_owner_forge_asterisk,
	string15  vehicle_owner_dl_nbr,
	string8   vehicle_owner_dob,
	string1   vehicle_owner_sex,
	string1   vehicle_owner_race,
	string15  point_of_impact,
	string2   vehicle_movement,
	string2   vehicle_function,
	string1   filler4,
	string2   vehs_first_defect,
	string2   vehs_second_defect,
	string2   vehicle_modified,
	string2   vehicle_roadway_loc,
	string1   hazard_material_transport,
	string3   total_occu_vehicle,
	string3   total_occu_saf_equip,
	string1   moving_violation,
	string1   vehicle_insur_code,
	string1   vehicle_fault_code,
	string2   vehicle_cap_code,
	string1   vehicle_fr_code,
	string2   vehicle_use,
	string1   placarded,
	string1   dhsmv_vehicle_ind,
	string31  filler5,
	string10  prim_range,
	string2   predir,
	string28  prim_name,
	string4   addr_suffix,
	string2   postdir,
	string10  unit_desig,
	string8   sec_range,
	string25  p_city_name,
	string25  v_city_name,
	string2   st,
	string5   zip,
	string4   zip4,
	string4   cart,
	string1   cr_sort_sz,
	string4   lot,
	string1   lot_order,
	string2   dpbc,
	string1   chk_digit,
	string2   rec_type,
	string2   ace_fips_st,
	string3   county,
	string10  geo_lat,
	string11  geo_long,
	string4   msa,
	string7   geo_blk,
	string1   geo_match,
	string4   err_stat,
	string5   title,
	string20  fname,
	string20  mname,
	string20  lname,
	string5   suffix,
	string3   score,
	string25  cname,
	string4   blank1,
	string42  vehicle_seg,
	string1   vehicle_seg_type,
	string14  match_code,
	string4   model_year,
	string1   blank2,
	string3   manufacturer_corporation,
	string1   division_code,
	string2   vehicle_group_code,
	string2   vehicle_subgroup_code,
	string2   vehicle_series_code,
	string2   body_style_code,
	string3   vehicle_abbreviation,
	string1   assembly_country,
	string1   headquarter_country,
	string1   number_of_doors,
	string1   seating_capacity,
	string2   number_of_cylinders,
	string4   engine_size,
	string1   fuel_code,
	string1   carburetion_type,
	string1   number_of_barrels,
	string1   price_class_code,
	string2   body_size_code,
	string1   number_of_wheels_on_road,
	string1   number_of_driving_wheels,
	string1   drive_type,
	string1   steering_type,
	string1   gvw_code,
	string1   load_capacity_code,
	string1   cab_type_code,
	string2   bed_length,
	string1   rim_size,
	string5   manufacture_body_style,
	string1   vehicle_type_code,
	string3   car_line_code,
	string1   car_series_code,
	string1   car_body_style_code,
	string1   engine_cylinder_code,
	string3   truck_make_abbreviation,
	string3   truck_body_style_abbreviation,
	string3   motorcycle_make_abbreviation,
	string3   vina_series,
	string3   vina_model,
	string5   reference_number,
	string3   vina_make,
	string2   vina_body_style,
	string20  make_description,
	string20  model_description,
	string20  series_description,
	string2   blank3,
	string3   car_series,
	string2   car_body_style,
	string3   car_cid,
	string2   car_cylinders,
	string1   car_carburetion,
	string1   car_fuel_code,
	string2   truck_chassis_body_style,
	string2   truck_wheels_driving_wheels,
	string4   truck_cid,
	string2   truck_cylinders,
	string1   truck_fuel_code,
	string1   truck_manufacturers_gvw_code,
	string2   truck_ton_rating_code,
	string3   truck_series,
	string3   truck_model,
	string3   motorcycle_model,
	string4   motorcycle_engine_displacement,
	string2   motorcycle_type_of_bike,
	string2   motorcycle_cylinder_coding,
	string40  orig_accnbr,
	string15  direction_travel_desc,
	string25  vehicle_type_desc,
	string30  point_of_impact_desc, 
	string30  vehicle_use_desc,
  end;
xpnd_layout xpndrecs(flc2v L,FLAccidents.Key_FlCrash0 R) := transform
self.report_code					:= 'FA';
self.report_category				:= 'Auto Report';
self.report_code_desc				:= 'Auto Accident';
self.vehicle_incident_city			:= stringlib.stringtouppercase(if(L.accident_nbr= R.accident_nbr,R.city_town_name,''));
self.vehicle_incident_st			:= 'FL';
self.carrier_name := l.ins_company_name;
self.client_type_id					:= '';
self.accident_nbr           := stringlib.StringFilter(l.accident_nbr,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789');
self.orig_accnbr           := l.accident_nbr; 
self.vehicle_owner_dob				:=l.vehicle_owner_dob[5..8]+l.vehicle_owner_dob[1..4] ; 
self.direction_travel_desc    := ''; 
self.vehicle_type_desc         := ''; 
self.point_of_impact_desc  := ''; 
self.vehicle_use_desc   := ''; 
self 								:= L;
end;

pflc2v := join(distribute(flc2v,hash(accident_nbr))
			  ,distribute(pull(FLAccidents.Key_FlCrash0),hash(accident_nbr))
			  ,left.accident_nbr = right.accident_nbr,
			   xpndrecs(left,right),left outer,local);
  
/////////////////////////////////////////////////////////////////
//Slim National file 
/////////////////////////////////////////////////////////////////  
ntlFile := FLAccidents.BaseFile_NtlAccidents_Alpharetta(stringlib.stringtouppercase(party_type) != 'DRIVER');


pflc2v slimrec1(ntlFile L) := transform
self.did							:= if(L.did = 0,'000000000000',intformat(L.did,12,1));
self.b_did							:= if(L.bdid = 0,'',intformat(L.bdid,12,1)); 
self.b_did_score					:= L.bdid_score;
self.rec_type_2						:= '2';
t_accident_nbr 			:= (string40)((unsigned6)L.vehicle_incident_id+10000000000);
t_scrub := stringlib.StringFilter(t_accident_nbr,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789');
self.accident_nbr := if(t_scrub in ['UNK', 'UNKNOWN'], 'UNK'+l.vehicle_incident_id,t_scrub);  
self.orig_accnbr := t_accident_nbr; 
self.section_nbr					:= if(L.LAST_NAME+L.FIRST_NAME = L.LAST_NAME_1+L.FIRST_NAME_1,L.vehicle_nbr,'');;
self.vehicle_tag_nbr				:= L.TAG;
self.vehicle_reg_state				:= L.TAG_STATE;
//------------------------------------
//used for mobileTrac
self.vehicle_id_nbr					:= if(L.vehVin !=''
										,L.vehVin
										,if(L.LAST_NAME+L.FIRST_NAME = L.LAST_NAME_1+L.FIRST_NAME_1,L.vin,''));
self.vehicle_year					:=if(L.vehYear !=''
										,L.vehYear
										,if(L.LAST_NAME+L.FIRST_NAME = L.LAST_NAME_1+L.FIRST_NAME_1,L.year,''));	
self.vehicle_make					:=if(L.vehmake !=''
										,L.vehMake
										,if(L.LAST_NAME+L.FIRST_NAME = L.LAST_NAME_1+L.FIRST_NAME_1,L.make,''));
self.make_description				:= if(L.make_description != '',L.make_description,L.vehMake);
self.model_description				:= if(L.model_description != '',L.model_description,L.vehModel);
self.vehicle_incident_city	        := stringlib.stringtouppercase(L.inc_city);
self.vehicle_incident_st			:= stringlib.stringtouppercase(L.state_abbr);
self.point_of_impact				:= '';
self.point_of_impact_desc				:=L.impact_location;
//------------------------------------
self.ins_company_name				:= L.LEGAL_NAME;
self.ins_policy_nbr					:= L.POLICY_NBR;
self.carrier_name           := L.LEGAL_NAME;
self.vehicle_owner_name				:= map(L.LAST_NAME+L.FIRST_NAME = L.LAST_NAME_1+L.FIRST_NAME_1 => L.LAST_NAME  +' '+L.FIRST_NAME+' '+L.MIDDLE_NAME_1
										  ,'');
self.vehicle_owner_st_city			:= if(L.LAST_NAME+L.FIRST_NAME = L.LAST_NAME_1+L.FIRST_NAME_1,L.city,'');
self.vehicle_owner_st				:= if(L.LAST_NAME+L.FIRST_NAME = L.LAST_NAME_1+L.FIRST_NAME_1,L.state,'');
self.vehicle_owner_zip				:= if(L.LAST_NAME+L.FIRST_NAME = L.LAST_NAME_1+L.FIRST_NAME_1,L.zip5,'');
self.vehicle_owner_dl_nbr			:= if(L.pty_drivers_license !=''
										,L.pty_drivers_license
										,if(L.LAST_NAME+L.FIRST_NAME = L.LAST_NAME_1+L.FIRST_NAME_1,L.drivers_license,''));
self.vehicle_owner_dob				:= L.dob;
self.vehicle_owner_sex				:= if(L.LAST_NAME+L.FIRST_NAME = L.LAST_NAME_1+L.FIRST_NAME_1,L.gender_1[1],'');
self.vehicle_fault_code				:= map(L.LAST_NAME+L.FIRST_NAME = L.LAST_NAME_1+L.FIRST_NAME_1 => '1'
										  ,L.LAST_NAME+L.FIRST_NAME = L.LAST_NAME_2+L.FIRST_NAME_2 => '2'
										  ,L.LAST_NAME+L.FIRST_NAME = L.LAST_NAME_3+L.FIRST_NAME_3 => '3'
										  ,'');
self.addr_suffix 					:= L.suffix;
self.ace_fips_st					:= L.county_code[1..2];
self.county							:= L.county_code[3..5];
self.zip							:= L.zip5;
self.score 							:= L.name_score;
self.suffix 						:= L.name_suffix;
self.cname							:= stringlib.stringtouppercase(L.business_name);

self								:= L;
self								:= [];
end;
pntl := project(ntlFile,slimrec1(left)); 

// ecrash 
ecrashFile := FLAccidents_Ecrash.BaseFile (stringlib.stringtouppercase(person_type) in ['OWNER','VEHICLE OWNER']); 

pflc2v slimrec3(ecrashFile L, unsigned1 cnt) := transform

self.vehicle_incident_city	:= stringlib.stringtouppercase(L.Crash_City);
self.vehicle_incident_st		:= stringlib.stringtouppercase(L.Loss_State_Abbr);
self.carrier_name     := L.Insurance_Company;
self.client_type_id 	:= '';
self.rec_type_2  := '2'; 
t_accident_nbr 			:= if(l.source_id in ['TF','TM'],L.state_report_number, L.case_identifier);
t_scrub := stringlib.StringFilter(t_accident_nbr,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789');
self.accident_nbr := if(t_scrub in ['UNK', 'UNKNOWN'], 'UNK'+l.incident_id,t_scrub);
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

//iyetek 
/*
IytekFile := FLAccidents_Ecrash.BaseFile_Iyetek (stringlib.stringtouppercase(person_type) in ['OWNER','VEHICLE OWNER']);; 

pflc2v slimrec4(IytekFile L) := transform

t_scrub := stringlib.StringFilter(L.state_report_number,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789');
self.accident_nbr := if(t_scrub in ['UNK', 'UNKNOWN'], 'UNK'+l.incident_id,t_scrub);  
self.orig_accnbr := L.state_report_number; 
self.b_did							:= if(L.bdid = 0,'',intformat(L.bdid,12,1)); 
self.cname							:= l.cname;
self.suffix 				    := L.suffix;
self.did								:= if(L.did = 0,'000000000000',intformat(L.did,12,1));	
self.addr_suffix 				:= L.addr_suffix;
self.ace_fips_st				:= L.county_code[1..2];
self.county							:= L.county_code[3..5];
self.rec_type_2         := '2'; 
self.vehicle_tag_nbr		:= L.License_Plate;
self.vehicle_reg_state	:= L.Registration_State;
self.vehicle_id_nbr			:= L.vin;
self.b_did_score        := L.bdid_score ; 
self.carrier_name       := L.Insurance_Company;
self.ins_company_name   := l.Insurance_Company;
self.vehicle_incident_city	:= stringlib.stringtouppercase(L.Crash_City);
self.vehicle_incident_st		:= stringlib.stringtouppercase(L.Loss_State_Abbr);
year					              := trim(if(L.model_year != '',L.model_year,L.model_yr),left,right);				
																										
self.vehicle_year						:= map(length(year) = 2 and year>'50' => '19'+ year,
																	 length(year) = 2 and year<='50' => '20'+ year,year);
self.model_year 						:= map(length(year) = 2 and year>'50' => '19'+ year,
																	 length(year) = 2 and year<='50' => '20'+ year,year);
																	 
self.vehicle_make					  := if(L.make_description != '',L.make_description,L.make);
self.make_description				:= if(L.make_description != '',L.make_description,L.make);
self.model_description			:= if(L.model_description != '',L.model_description,L.model);
self.client_type_id 	      := '';
self.vehicle_owner_name     := trim(l.first_name,left,right)+' '+trim(l.middle_name,left,right)+' ' +trim(l.last_name ,left,right);
self.vehicle_owner_suffix   :=L.suffix;  
self.vehicle_owner_st_city  := trim(l.address,left,right) +' '+ trim(l.city,left,right); 
self.vehicle_owner_st       := l.state ; 
self.vehicle_owner_zip := l.zip; 
self.vehicle_owner_forge_asterisk := ''; 
self.vehicle_owner_dl_nbr	:= if(regexfind('[0-9]',L.drivers_license_number),L.drivers_license_number,'');
self.vehicle_owner_dob := l.date_of_birth;
self.vehicle_owner_sex := ''; 
self.vehicle_owner_race := ''; 
self.point_of_impact := l.impact_area1 ; 
self.ins_policy_nbr := l.insurance_policy_number ; 
self.zip4								:= L.z4;
self.score 							:= L.name_score;
self.section_nbr := l.vehicle_unit_number; 
self := l ;
self :=[]; 
end;
piyetek := project(IytekFile,slimrec4(left)); 
 
*/
allrecs :=dedup(pflc2v+pntl+pecrash/*+piyetek*/,record,all): persist('~thor_data400::persist::ecrash2v');

export key_Ecrash2v := index(allrecs,
                             {string40 l_acc_nbr := accident_nbr},
                             {allrecs},
                             Data_Services.Data_location.Prefix() + 'thor_data400::key::ecrash2v_' + doxie.Version_SuperKey);