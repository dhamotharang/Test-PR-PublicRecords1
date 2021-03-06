EXPORT Fn_Upcase ( dataset(recordof(FLAccidents_Ecrash.Layout_keybuild_SSv2)) infile):= function 


in_upcase := project( infile , transform ({infile}, 
	self.image_hash					:= left.image_hash;
	self.tif_image_hash     := left.tif_image_hash;
	
  self.report_code:= StringLib.StringToUpperCase(left.report_code  );  
  self.report_category:= StringLib.StringToUpperCase(left.report_category  );  
  self.report_code_desc:= StringLib.StringToUpperCase(left.report_code_desc  );  
	self.vehicle_incident_id:= StringLib.StringToUpperCase(left.vehicle_incident_id  );  
	self.vehicle_status:= StringLib.StringToUpperCase(left.vehicle_status  );  
	self.accident_location:= StringLib.StringToUpperCase(left.accident_location  );  
	self.accident_street:= StringLib.StringToUpperCase(left.accident_street  );  
	self.accident_cross_street:= StringLib.StringToUpperCase(left.accident_cross_street  );  
	self.jurisdiction:= StringLib.StringToUpperCase(left.jurisdiction  );  
	self.jurisdiction_state:= StringLib.StringToUpperCase(left.jurisdiction_state  );  
	self.jurisdiction_nbr:= StringLib.StringToUpperCase(left.jurisdiction_nbr  );  
  self.AIRBAGS_DEPLOY:= StringLib.StringToUpperCase(left.AIRBAGS_DEPLOY  );  
	self.accident_nbr:= StringLib.StringToUpperCase(left.accident_nbr  );  
	self.accident_date:= StringLib.StringToUpperCase(left.accident_date  );   
	self.title:= StringLib.StringToUpperCase(left.title);  
	self.fname:= StringLib.StringToUpperCase(left.fname);  
	self.mname:= StringLib.StringToUpperCase(left.mname);  
	self.lname:= StringLib.StringToUpperCase(left.lname);  
	self.name_suffix:= StringLib.StringToUpperCase(left.name_suffix);
	self.cname:= StringLib.StringToUpperCase(left.cname  );  
	self.prim_range:= StringLib.StringToUpperCase(left.prim_range  );  
	self.predir:= StringLib.StringToUpperCase(left.predir  );  
	self.prim_name:= StringLib.StringToUpperCase(left.prim_name  );  
	self.addr_suffix:= StringLib.StringToUpperCase(left.addr_suffix  );  
	self.postdir:= StringLib.StringToUpperCase(left.postdir  );  
	self.unit_desig:= StringLib.StringToUpperCase(left.unit_desig);  
	self.sec_range:= StringLib.StringToUpperCase(left.sec_range);  
	self.v_city_name:= StringLib.StringToUpperCase(left.v_city_name);  
	self.st:= StringLib.StringToUpperCase(left.st);  
	self.zip:= StringLib.StringToUpperCase(left.zip);  
	self.zip4:= StringLib.StringToUpperCase(left.zip4);  
  self.record_type:= StringLib.StringToUpperCase(left.record_type  );  
	self.driver_license_nbr:= StringLib.StringToUpperCase(left.driver_license_nbr  );  
	self.dlnbr_st:= StringLib.StringToUpperCase(left.dlnbr_st  );  
	self.vin:= StringLib.StringToUpperCase(left.vin  );  
	self.tag_nbr:= StringLib.StringToUpperCase(left.tag_nbr  );  
	self.tagnbr_st:= StringLib.StringToUpperCase(left.tagnbr_st  );  
	self.dob:= StringLib.StringToUpperCase(left.dob  );  
	self.vehicle_incident_city:= StringLib.StringToUpperCase(left.vehicle_incident_city  );  
	self.vehicle_incident_st:= StringLib.StringToUpperCase(left.vehicle_incident_st  );  
	self.carrier_name:= StringLib.StringToUpperCase(left.carrier_name  );  
	self.client_type_id:= StringLib.StringToUpperCase(left.client_type_id  );  
	self.Policy_num:= StringLib.StringToUpperCase(left.Policy_num  );  	   
  self.Policy_Effective_Date:= StringLib.StringToUpperCase(left.Policy_Effective_Date  );     
	self.Policy_Expiration_Date:= StringLib.StringToUpperCase(left.Policy_Expiration_Date  );  
	self.Report_Has_Coversheet:= StringLib.StringToUpperCase(left.Report_Has_Coversheet  );  
	self.other_vin_indicator:= StringLib.StringToUpperCase(left.other_vin_indicator  );  
	self.vehicle_unit_number:= StringLib.StringToUpperCase(left.vehicle_unit_number  );  
	self.towed:= StringLib.StringToUpperCase(left.towed  );  
	self.impact_location:= StringLib.StringToUpperCase(left.impact_location  );  
	self.vehicle_owner_driver_code:= StringLib.StringToUpperCase(left.vehicle_owner_driver_code  );  
	self.vehicle_driver_action:= StringLib.StringToUpperCase(left.vehicle_driver_action  );  
	self.vehicle_year:= StringLib.StringToUpperCase(left.vehicle_year  );  
	self.vehicle_make:= StringLib.StringToUpperCase(left.vehicle_make  );    
	self.vehicle_type:= StringLib.StringToUpperCase(left.vehicle_type  );  
	self.vehicle_travel_on:= StringLib.StringToUpperCase(left.vehicle_travel_on  );  
	self.direction_travel:= StringLib.StringToUpperCase(left.direction_travel  );  
	self.est_vehicle_speed:= StringLib.StringToUpperCase(left.est_vehicle_speed  );  
	self.posted_speed:= StringLib.StringToUpperCase(left.posted_speed  );  
	self.est_vehicle_damage:= StringLib.StringToUpperCase(left.est_vehicle_damage  );  
	self.damage_type:= StringLib.StringToUpperCase(left.damage_type  );  
	self.vehicle_removed_by:= StringLib.StringToUpperCase(left.vehicle_removed_by  );  
	self.how_removed_code:= StringLib.StringToUpperCase(left.how_removed_code  );  
	self.point_of_impact:= StringLib.StringToUpperCase(left.point_of_impact  );  
	self.vehicle_movement:= StringLib.StringToUpperCase(left.vehicle_movement  );  
	self.vehicle_function:= StringLib.StringToUpperCase(left.vehicle_function  );  
	self.vehs_first_defect:= StringLib.StringToUpperCase(left.vehs_first_defect  );  
	self.vehs_second_defect:= StringLib.StringToUpperCase(left.vehs_second_defect  );  
	self.vehicle_modified:= StringLib.StringToUpperCase(left.vehicle_modified  );  
	self.vehicle_roadway_loc:= StringLib.StringToUpperCase(left.vehicle_roadway_loc  );  
	self.hazard_material_transport:= StringLib.StringToUpperCase(left.hazard_material_transport  );  
	self.total_occu_vehicle:= StringLib.StringToUpperCase(left.total_occu_vehicle  );  
	self.total_occu_saf_equip:= StringLib.StringToUpperCase(left.total_occu_saf_equip  );  
	self.moving_violation:= StringLib.StringToUpperCase(left.moving_violation  );  
	self.vehicle_insur_code:= StringLib.StringToUpperCase(left.vehicle_insur_code  );  
	self.vehicle_fault_code:= StringLib.StringToUpperCase(left.vehicle_fault_code  );  
	self.vehicle_cap_code:= StringLib.StringToUpperCase(left.vehicle_cap_code  );  
	self.vehicle_fr_code:= StringLib.StringToUpperCase(left.vehicle_fr_code  );  
	self.vehicle_use:= StringLib.StringToUpperCase(left.vehicle_use  );  
	self.placarded:= StringLib.StringToUpperCase(left.placarded  );  
	self.dhsmv_vehicle_ind:= StringLib.StringToUpperCase(left.dhsmv_vehicle_ind  );  
	self.vehicle_seg:= StringLib.StringToUpperCase(left.vehicle_seg  );  
	self.vehicle_seg_type:= StringLib.StringToUpperCase(left.vehicle_seg_type  );  
	self.match_code:= StringLib.StringToUpperCase(left.match_code  );  
	self.model_year:= StringLib.StringToUpperCase(left.model_year  );  
	self.manufacturer_corporation:= StringLib.StringToUpperCase(left.manufacturer_corporation  );  
	self.division_code:= StringLib.StringToUpperCase(left.division_code  );  
	self.vehicle_group_code:= StringLib.StringToUpperCase(left.vehicle_group_code  );  
	self.vehicle_subgroup_code:= StringLib.StringToUpperCase(left.vehicle_subgroup_code  );  
	self.vehicle_series_code:= StringLib.StringToUpperCase(left.vehicle_series_code  );  
	self.body_style_code:= StringLib.StringToUpperCase(left.body_style_code  );  
	self.vehicle_abbreviation:= StringLib.StringToUpperCase(left.vehicle_abbreviation  );  
	self.assembly_country:= StringLib.StringToUpperCase(left.assembly_country  );  
	self.headquarter_country:= StringLib.StringToUpperCase(left.headquarter_country  );  
	self.number_of_doors:= StringLib.StringToUpperCase(left.number_of_doors  );  
	self.seating_capacity:= StringLib.StringToUpperCase(left.seating_capacity  );  
	self.number_of_cylinders:= StringLib.StringToUpperCase(left.number_of_cylinders  );  
	self.engine_size:= StringLib.StringToUpperCase(left.engine_size  );  
	self.fuel_code:= StringLib.StringToUpperCase(left.fuel_code  );  
	self.carburetion_type:= StringLib.StringToUpperCase(left.carburetion_type  );  
	self.number_of_barrels:= StringLib.StringToUpperCase(left.number_of_barrels  );  
	self.price_class_code:= StringLib.StringToUpperCase(left.price_class_code  );  
	self.body_size_code:= StringLib.StringToUpperCase(left.body_size_code  );  
	self.number_of_wheels_on_road:= StringLib.StringToUpperCase(left.number_of_wheels_on_road  );  
	self.number_of_driving_wheels:= StringLib.StringToUpperCase(left.number_of_driving_wheels  );  
	self.drive_type:= StringLib.StringToUpperCase(left.drive_type  );  
	self.steering_type:= StringLib.StringToUpperCase(left.steering_type );  
	self.gvw_code:= StringLib.StringToUpperCase(left.gvw_code  );  
	self.load_capacity_code:= StringLib.StringToUpperCase(left.load_capacity_code  );  
	self.cab_type_code:= StringLib.StringToUpperCase(left.cab_type_code  );  
	self.bed_length:= StringLib.StringToUpperCase(left.bed_length  );  
	self.rim_size:= StringLib.StringToUpperCase(left.rim_size  );  
	self.manufacture_body_style:= StringLib.StringToUpperCase(left.manufacture_body_style  );  
	self.vehicle_type_code:= StringLib.StringToUpperCase(left.vehicle_type_code  );  
	self.car_line_code:= StringLib.StringToUpperCase(left.car_line_code  );  
	self.car_series_code:= StringLib.StringToUpperCase(left.car_series_code  );  
	self.car_body_style_code:= StringLib.StringToUpperCase(left.car_body_style_code  );  
	self.engine_cylinder_code:= StringLib.StringToUpperCase(left.engine_cylinder_code  );  
	self.truck_make_abbreviation:= StringLib.StringToUpperCase(left.truck_make_abbreviation  );  
	self.truck_body_style_abbreviation:= StringLib.StringToUpperCase(left.truck_body_style_abbreviation  );  
	self.motorcycle_make_abbreviation:= StringLib.StringToUpperCase(left.motorcycle_make_abbreviation  );  
	self.vina_series:= StringLib.StringToUpperCase(left.vina_series  );  
	self.vina_model:= StringLib.StringToUpperCase(left.vina_model  );  
	self.reference_number:= StringLib.StringToUpperCase(left.reference_number  );  
	self.vina_make:= StringLib.StringToUpperCase(left.vina_make  );  
	self.vina_body_style:= StringLib.StringToUpperCase(left.vina_body_style  );  
	self.make_description:= StringLib.StringToUpperCase(left.make_description  );  
	self.model_description:= StringLib.StringToUpperCase(left.model_description  );  
	self.series_description:= StringLib.StringToUpperCase(left.series_description  );  
	self.car_series:= StringLib.StringToUpperCase(left.car_series  );  
	self.car_body_style:= StringLib.StringToUpperCase(left.car_body_style  );  
	self.car_cid:= StringLib.StringToUpperCase(left.car_cid  );  
	self.car_cylinders:= StringLib.StringToUpperCase(left.car_cylinders  );  
	self.car_carburetion:= StringLib.StringToUpperCase(left.car_carburetion  );  
	self.car_fuel_code:= StringLib.StringToUpperCase(left.car_fuel_code  );  
	self.truck_chassis_body_style:= StringLib.StringToUpperCase(left.truck_chassis_body_style  );  
	self.truck_wheels_driving_wheels:= StringLib.StringToUpperCase(left.truck_wheels_driving_wheels  );  
	self.truck_cid:= StringLib.StringToUpperCase(left.truck_cid  );  
	self.truck_cylinders:= StringLib.StringToUpperCase(left.truck_cylinders  );  
	self.truck_fuel_code:= StringLib.StringToUpperCase(left.truck_fuel_code  );  
	self.truck_manufacturers_gvw_code:= StringLib.StringToUpperCase(left.truck_manufacturers_gvw_code  );  
	self.truck_ton_rating_code:= StringLib.StringToUpperCase(left.truck_ton_rating_code  );  
	self.truck_series:= StringLib.StringToUpperCase(left.truck_series  );  
	self.truck_model:= StringLib.StringToUpperCase(left.truck_model  );  
	self.motorcycle_model:= StringLib.StringToUpperCase(left.motorcycle_model  );  
	self.motorcycle_engine_displacement:= StringLib.StringToUpperCase(left.motorcycle_engine_displacement  );  
	self.motorcycle_type_of_bike:= StringLib.StringToUpperCase(left.motorcycle_type_of_bike  );  
	self.motorcycle_cylinder_coding:= StringLib.StringToUpperCase(left.motorcycle_cylinder_coding  );  
	self.next_street:= StringLib.StringToUpperCase(left.next_street  );  
	self.addl_report_number:= StringLib.StringToUpperCase(left.addl_report_number  );  
        self.agency_ori:= StringLib.StringToUpperCase(left.agency_ori  );  
        self.Insurance_Company_Standardized := StringLib.StringToUpperCase(left.Insurance_Company_Standardized  );  
        self.is_available_for_public:= StringLib.StringToUpperCase(left.is_available_for_public  );  
        self.report_status := StringLib.StringToUpperCase(left.report_status  );  
        self.work_type_id:= StringLib.StringToUpperCase(left.work_type_id  );  
        self.orig_full_name := StringLib.StringToUpperCase(left.orig_full_name  );   
        self.orig_fname:= StringLib.StringToUpperCase(left.orig_fname  );   
        self.orig_lname:= StringLib.StringToUpperCase(left.orig_lname  );   
        self.orig_mname:= StringLib.StringToUpperCase(left.orig_mname  );   
        self.ssn:= StringLib.StringToUpperCase(left.ssn  );  
        self.cru_order_id:= StringLib.StringToUpperCase(left.cru_order_id  );  
        self.cru_sequence_nbr:= StringLib.StringToUpperCase(left.cru_sequence_nbr  );  
	self.report_type_id:= StringLib.StringToUpperCase(left.report_type_id  );  

// Admin analytics
self.precinct:= StringLib.StringToUpperCase(left.precinct  );  
self.beat:= StringLib.StringToUpperCase(left.beat  );  
self.crash_time:= StringLib.StringToUpperCase(left.crash_time  );  
//self.Admin_Portal_Visible:= StringLib.StringToUpperCase(left.Admin_Portal_Visible  );  
self.Vendor_Code:= StringLib.StringToUpperCase(left.Vendor_Code  );  
self.Report_Property_Damage:= StringLib.StringToUpperCase(left.Report_Property_Damage  );  
// CRU2eCrash integration 
self.cru_jurisdiction:= StringLib.StringToUpperCase(left.cru_jurisdiction  );  
self.cru_jurisdiction_nbr:= StringLib.StringToUpperCase(left.cru_jurisdiction_nbr  );  
self.crash_county:= StringLib.StringToUpperCase(left.crash_county  );  
self.vehicle_color:= StringLib.StringToUpperCase(left.vehicle_color  );  
self.orig_accnbr:= StringLib.StringToUpperCase(left.orig_accnbr  );  
self.acct_nbr:= StringLib.StringToUpperCase(left.acct_nbr );  
// Enumaration fields 
self.Report_Collision_Type:= StringLib.StringToUpperCase(left.Report_Collision_Type  );  
self.Report_First_Harmful_Event:= StringLib.StringToUpperCase(left.Report_First_Harmful_Event  );  
self.Report_Light_Condition:= StringLib.StringToUpperCase(left.Report_Light_Condition  );  
self.Report_Weather_Condition:= StringLib.StringToUpperCase(left.Report_Weather_Condition  );  
self.Report_Road_Condition:= StringLib.StringToUpperCase(left.Report_Road_Condition  );  
self.Report_Injury_Status:= StringLib.StringToUpperCase(left.Report_Injury_Status  );  
self.Report_Damage_Extent:= StringLib.StringToUpperCase(left.Report_Damage_Extent  );  
self.Report_Vehicle_Type:= StringLib.StringToUpperCase(left.Report_Vehicle_Type  );  
self.Report_Traffic_Control_Device_Type:= StringLib.StringToUpperCase(left.Report_Traffic_Control_Device_Type  );  
self.Report_Contributing_Circumstances_v:= StringLib.StringToUpperCase(left.Report_Contributing_Circumstances_v  );  
self.Report_Vehicle_Maneuver_Action_Prior:= StringLib.StringToUpperCase(left.Report_Vehicle_Maneuver_Action_Prior  );  
self.Report_Vehicle_Body_Type:= StringLib.StringToUpperCase(left.Report_Vehicle_Body_Type );  

self := left
  )); 
	
    return in_upcase;

end; 