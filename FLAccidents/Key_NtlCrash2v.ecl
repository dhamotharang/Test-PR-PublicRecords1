/*2010-12-01T21:01:25Z (t gibson)

*/
import doxie;

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
	string10  accident_nbr,
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
	string40  vehicle_owner_st_city,
	string18  filler3,
	string2   vehicle_owner_st,
	string9   vehicle_owner_zip,
	string1   vehicle_owner_forge_asterisk,
	string15  vehicle_owner_dl_nbr,
	string8   vehicle_owner_dob,
	string9   vehicle_owner_ssn,
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
	string30 Policy_num;	   
  string8 Policy_Effective_Date;	   
	string8 Policy_Expiration_Date;	
	string9 inquiry_ssn,
	string8 inquiry_dob,
	string20 inquiry_mname,
	string5 inquiry_zip5,
	string4 inquiry_zip4,
	
  end;
xpnd_layout xpndrecs(flc2v L,FLAccidents.Key_FlCrash0 R) := transform
self.report_code					:= 'FA';
self.report_category			:= 'Auto Report';
self.report_code_desc			:= 'Auto Accident';
self.vehicle_incident_city:= stringlib.stringtouppercase(if(L.accident_nbr= R.accident_nbr,R.city_town_name,''));
self.vehicle_incident_st	:= 'FL';
self.carrier_name					:= '';
self.client_type_id				:= '';
self.vehicle_owner_ssn		:= '';
self.Policy_num						:= '';	   
self.Policy_Effective_Date:= '';	   
self.Policy_Expiration_Date:='';	
self.inquiry_ssn					:= '';
self.inquiry_dob					:= '';
self.inquiry_mname				:= '';
self.inquiry_zip5 				:= '';
self.inquiry_zip4 				:= '';
self 											:= L;
end;

pflc2v := join(distribute(flc2v,hash(accident_nbr))
			  ,distribute(pull(FLAccidents.Key_FlCrash0),hash(accident_nbr))
			  ,left.accident_nbr = right.accident_nbr,
			   xpndrecs(left,right),left outer,local);
  
/////////////////////////////////////////////////////////////////
//Slim National file 
/////////////////////////////////////////////////////////////////  
ntlFile := FLAccidents.BaseFile_NtlAccidents_Alpharetta(party_type != 'DRIVER');


pflc2v slimrec1(ntlFile L) := transform
self.did										:= if(L.did = 0,'000000000000',intformat(L.did,12,1));
self.b_did									:= if(L.bdid = 0,'',intformat(L.bdid,12,1)); 
self.b_did_score						:= L.bdid_score;
self.rec_type_2							:= '2';
self.accident_nbr 					:= (string10)((unsigned6)L.vehicle_incident_id+1000000000);
self.section_nbr						:= if(L.LAST_NAME+L.FIRST_NAME = L.LAST_NAME_1+L.FIRST_NAME_1,L.vehicle_nbr,'');;
self.vehicle_tag_nbr				:= L.TAG;
self.vehicle_reg_state			:= L.TAG_STATE;
//------------------------------------
//used for mobileTrac
self.vehicle_id_nbr					:= L.vehVin;
self.vehicle_year						:= L.vehYear;
self.vehicle_make						:= L.vehMake;															
self.make_description				:= if(L.make_description != '',L.make_description,L.vehMake);
self.model_description			:= if(L.model_description != '',L.model_description,L.vehModel);
self.vehicle_incident_city	:= stringlib.stringtouppercase(L.inc_city);
self.vehicle_incident_st		:= stringlib.stringtouppercase(L.state_abbr);
self.point_of_impact				:= L.impact_location;
//------------------------------------
self.ins_company_name				:= L.CARRIER_ID; 
self.ins_policy_nbr					:= L.POLICY_NBR;
self.vehicle_owner_name			:= map(L.LAST_NAME+L.FIRST_NAME = L.LAST_NAME_1+L.FIRST_NAME_1 => L.LAST_NAME  +' '+L.FIRST_NAME,'');
self.vehicle_owner_st_city	:= L.inc_city;
self.vehicle_owner_st				:= L.STATE_ABBR;
self.vehicle_owner_zip			:= '';
self.vehicle_owner_dl_nbr		:= L.pty_drivers_license;															
self.vehicle_owner_dob			:= L.dob;
self.vehicle_owner_sex			:= '';//inquiry data, if(L.LAST_NAME+L.FIRST_NAME = L.LAST_NAME_1+L.FIRST_NAME_1,L.gender_1[1],'');
self.vehicle_fault_code			:= map(L.LAST_NAME+L.FIRST_NAME = L.LAST_NAME_1+L.FIRST_NAME_1 => '1'
																  ,L.LAST_NAME+L.FIRST_NAME = L.LAST_NAME_2+L.FIRST_NAME_2 => '2'
																	,L.LAST_NAME+L.FIRST_NAME = L.LAST_NAME_3+L.FIRST_NAME_3 => '3'
																	,'');
self.addr_suffix 						:= L.suffix;
self.ace_fips_st						:= L.county_code[1..2];
self.county									:= L.county_code[3..5];
self.zip										:= L.zip5;
self.score 									:= L.name_score;
self.suffix 								:= L.name_suffix;
self.cname									:= stringlib.stringtouppercase(L.business_name);
self.carrier_name						:= L.LEGAL_NAME;
self.vehicle_owner_ssn			:= '';
self.Policy_num						  := L.POLICY_NBR;   
self.Policy_Effective_Date  := '';	   
self.Policy_Expiration_Date := L.POLICY_EXP_DATE;
self.inquiry_ssn						:= L.inquiry_ssn;
self.inquiry_dob						:= L.inquiry_dob;
self.inquiry_mname					:= L.inquiry_mname;
self.inquiry_zip5 					:= L.inquiry_zip5;
self.inquiry_zip4 					:= L.inquiry_zip4;

self												:= L;
self												:= [];
end;
pntl := project(ntlFile,slimrec1(left)); 

allrecs := dedup(pflc2v+pntl,record,all)
					: persist('~thor_data400::persist::ntlcrash2v');

export key_ntlcrash2v := index(allrecs
                             ,{unsigned6 l_acc_nbr := (integer)accident_nbr}
							 ,{allrecs}
							 ,'~thor_data400::key::ntlcrash2v_' + doxie.Version_SuperKey);
							