IMPORT BIPV2;

	EXPORT Layout_keybuild_SSv2 := RECORD
		BIPV2.IDlayouts.l_xlink_ids       ;	//Added for BIP project   
		STRING8 dt_first_seen;
		STRING8 dt_last_seen;
		STRING2 report_code;
		STRING25 report_category;
		STRING65 report_code_desc;
		STRING11 vehicle_incident_id;
		STRING1	vehicle_status;
		STRING100 accident_location;
		STRING100 accident_street;
		STRING100 accident_cross_street;
		STRING100  jurisdiction;
		STRING2 jurisdiction_state;
		STRING11 jurisdiction_nbr;
		STRING64 IMAGE_HASH;
		STRING1 AIRBAGS_DEPLOY;
		STRING12  did,
		STRING40  accident_nbr,
		STRING8   accident_date, 
		STRING5   title,
		STRING20  fname,
		STRING20  mname,
		STRING20  lname,
		STRING5   name_suffix,
		STRING12  b_did,
		STRING25  cname,
		STRING10  prim_range,
		STRING2   predir,
		STRING28  prim_name,
		STRING4   addr_suffix,
		STRING2   postdir,
		STRING10  unit_desig,
		STRING8   sec_range,
		STRING25  v_city_name,
		STRING2   st,
		STRING5   zip,
		STRING4   zip4,
		STRING100  RECORD_type,
		STRING25  driver_license_nbr,
		STRING2   dlnbr_st,
		STRING30  vin,
		STRING10   tag_nbr,
		STRING2   tagnbr_st,
		STRING8 dob,
		STRING50 vehicle_incident_city;
		STRING2 vehicle_incident_st;
		STRING100 carrier_name;
		STRING5	client_type_id;
		STRING50 Policy_num,	   
		STRING8 Policy_Effective_Date,   
		STRING8 Policy_Expiration_Date,
		STRING4 Report_Has_Coversheet,
		STRING1 other_vin_indicator;
		STRING7 vehicle_unit_number;
		STRING4 towed,
		STRING80 impact_location,
		STRING1   vehicle_owner_driver_code,
		STRING1   vehicle_driver_action,
		STRING4   vehicle_year,
		STRING100   vehicle_make,  
		STRING2   vehicle_type,
		STRING36  vehicle_travel_on,
		STRING1   direction_travel,
		STRING3   est_vehicle_speed,
		STRING2   posted_speed,
		STRING7   est_vehicle_damage,
		STRING1   damage_type,
		STRING25  vehicle_removed_by,
		STRING1   how_removed_code,
		STRING15  point_of_impact,
		STRING2   vehicle_movement,
		STRING2   vehicle_function,
		STRING2   vehs_first_defect,
		STRING2   vehs_second_defect,
		STRING2   vehicle_modified,
		STRING2   vehicle_roadway_loc,
		STRING1   hazard_material_transport,
		STRING3   total_occu_vehicle,
		STRING3   total_occu_saf_equip,
		STRING1   moving_violation,
		STRING1   vehicle_insur_code,
		STRING1   vehicle_fault_code,
		STRING2   vehicle_cap_code,
		STRING1   vehicle_fr_code,
		STRING2   vehicle_use,
		STRING1   placarded,
		STRING1   dhsmv_vehicle_ind,
		STRING42  vehicle_seg,
		STRING1   vehicle_seg_type,
		STRING14  match_code,
		STRING4   model_year,
		STRING3   manufacturer_corporation,
		STRING1   division_code,
		STRING2   vehicle_group_code,
		STRING2   vehicle_subgroup_code,
		STRING2   vehicle_series_code,
		STRING2   body_style_code,
		STRING3   vehicle_abbreviation,
		STRING1   assembly_country,
		STRING1   headquarter_country,
		STRING1   number_of_doors,
		STRING1   seating_capacity,
		STRING2   number_of_cylinders,
		STRING4   engine_size,
		STRING1   fuel_code,
		STRING1   carburetion_type,
		STRING1   number_of_barrels,
		STRING1   price_class_code,
		STRING2   body_size_code,
		STRING1   number_of_wheels_on_road,
		STRING1   number_of_driving_wheels,
		STRING1   drive_type,
		STRING1   steering_type,
		STRING1   gvw_code,
		STRING1   load_capacity_code,
		STRING1   cab_type_code,
		STRING2   bed_length,
		STRING1   rim_size,
		STRING5   manufacture_body_style,
		STRING1   vehicle_type_code,
		STRING3   car_line_code,
		STRING1   car_series_code,
		STRING1   car_body_style_code,
		STRING1   engine_cylinder_code,
		STRING3   truck_make_abbreviation,
		STRING3   truck_body_style_abbreviation,
		STRING3   motorcycle_make_abbreviation,
		STRING3   vina_series,
		STRING3   vina_model,
		STRING5   reference_number,
		STRING3   vina_make,
		STRING2   vina_body_style,
		STRING100  make_description,
		STRING100  model_description,
		STRING20  series_description,
		STRING3   car_series,
		STRING2   car_body_style,
		STRING3   car_cid,
		STRING2   car_cylinders,
		STRING1   car_carburetion,
		STRING1   car_fuel_code,
		STRING2   truck_chassis_body_style,
		STRING2   truck_wheels_driving_wheels,
		STRING4   truck_cid,
		STRING2   truck_cylinders,
		STRING1   truck_fuel_code,
		STRING1   truck_manufacturers_gvw_code,
		STRING2   truck_ton_rating_code,
		STRING3   truck_series,
		STRING3   truck_model,
		STRING3   motorcycle_model,
		STRING4   motorcycle_engine_displacement,
		STRING2   motorcycle_type_of_bike,
		STRING2   motorcycle_cylinder_coding,
		STRING60 next_street;
		STRING40 addl_report_number,
		STRING9 agency_ori,
		STRING100 Insurance_Company_Standardized ,
		STRING1 is_available_for_public,
		STRING20 report_status ;
		STRING4 work_type_id;
		STRING150 orig_full_name ; 
		STRING60 orig_fname; 
		STRING100 orig_lname; 
		STRING60 orig_mname; 
		STRING11 ssn;
		STRING12 cru_order_id;
		STRING2 cru_sequence_nbr;
		STRING8 date_vendor_last_reported; 
		STRING3 report_type_id;
		STRING8 creation_date; 
		STRING70 tif_image_hash; 

		// Admin analytics
		STRING30 precinct;
		STRING20 beat;
		STRING9 crash_time;
		//STRING1   Admin_Portal_Visible;
		STRING100 Vendor_Code;
		STRING1   Report_Property_Damage;
		// CRU2eCrash integration 
		STRING100 cru_jurisdiction;
		STRING20  cru_jurisdiction_nbr;
		STRING50  crash_county;
		STRING15  vehicle_color;
		STRING40  orig_accnbr;
		STRING40  scrub_addl_report_number,
		STRING20    acct_nbr;
		// Enumaration fields 
		STRING   Report_Collision_Type;
		STRING   Report_First_Harmful_Event;
		STRING   Report_Light_Condition;
	  //PRtcc datatyp update
		STRING200 Report_Weather_Condition;
		STRING200 Report_Road_Condition;
		STRING100 Report_Injury_Status;
		STRING   Report_Damage_Extent;
		STRING   Report_Vehicle_Type;
		STRING   Report_Traffic_Control_Device_Type;
		//PRtcc datatype update
		STRING200 Report_Contributing_Circumstances_v;
		STRING   Report_Vehicle_Maneuver_Action_Prior;
		STRING   Report_Vehicle_Body_Type;
		STRING1  CRU_inq_name_type := '' ; 
		STRING20  vendor_report_id := ''; 
		STRING5   reason_id; 
		STRING11  report_id ;
		STRING11  super_report_id; 
		STRING20  ReportLinkID ; 
		UNSIGNED6 Idfield;
		STRING3 Page_Count; 
		STRING12 Supplemental_Report;

		// New fields for Police RECORDs

		STRING7 fatality_involved;
		STRING12 latitude;
		STRING18 longitude;
		STRING100 address1;
		STRING100 address2;
		STRING2 state;
		STRING20 home_phone;
		//STRING9 vehicle_id;	

		//Buycrash project KY integration		
		STRING3 contrib_source;
		
		//Buycrash Release 4		
	  STRING12 officer_id;
		
		//Appriss Integration
		STRING1 Releasable;
		
		//BuyCrash Release 6
    STRING10 Date_Report_Submitted;
		
		//PRtCC new fields
		STRING40 Safety_Equipment_Restraint1;
		STRING20 Ejection;
		STRING40 Safety_Equipment_Helmet;
		STRING60 Transported_To;
		STRING7 Photographs_Taken;
		STRING200 Citation_Detail1;
		STRING200 Driver_Distracted_By;
		STRING7 Posted_Satutory_Speed_Limit;
		STRING60 Violation_Code1;
		STRING60 Violation_Code2;
		STRING60 Violation_Code3;
		STRING60 Violation_Code4;
		STRING20 Dispatch_Time;
		STRING1 Additional_Keying;
		STRING200 Dui_Suspected;
		STRING200 Report_Contributing_Circumstances_p;
END;