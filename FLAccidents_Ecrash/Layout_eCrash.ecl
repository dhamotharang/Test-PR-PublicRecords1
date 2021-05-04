IMPORT BIPV2;

EXPORT Layout_eCrash := MODULE

  EXPORT Consolidation_AgencyOri := RECORD
		BIPV2.IDlayouts.l_xlink_ids;	//Added for BIP project   
		STRING8 dt_first_seen;
		STRING8 dt_last_seen;
		STRING4 report_code;
		STRING25 report_category;
		STRING65 report_code_desc;
		STRING14 vehicle_incident_id;
		STRING1	vehicle_status;
		STRING100 accident_location;
		STRING100 accident_street;
		STRING100 accident_cross_street;
		STRING100  jurisdiction;
		STRING2 jurisdiction_state;
		STRING11 jurisdiction_nbr;
		STRING64 IMAGE_HASH;
		STRING1 AIRBAGS_DEPLOY;
		STRING12  did;
		STRING40  accident_nbr;
		STRING8   accident_date; 
		STRING5   title;
		STRING20  fname;
		STRING20  mname;
		STRING20  lname;
		STRING5   name_suffix;
		STRING12  b_did;
		STRING25  cname;
		STRING10  prim_range;
		STRING2   predir;
		STRING28  prim_name;
		STRING4   addr_suffix;
		STRING2   postdir;
		STRING10  unit_desig;
		STRING8   sec_range;
		STRING25  v_city_name;
		STRING2   st;
		STRING5   zip;
		STRING4   zip4;
		STRING100  RECORD_type;
		STRING25  driver_license_nbr;
		STRING2   dlnbr_st;
		STRING30  vin;
		STRING10   tag_nbr;
		STRING2   tagnbr_st;
		STRING8 dob;
		STRING50 vehicle_incident_city;
		STRING2 vehicle_incident_st;
		STRING100 carrier_name;
		STRING5	client_type_id;
		STRING50 Policy_num;	   
		STRING8 Policy_Effective_Date;   
		STRING8 Policy_Expiration_Date;
		STRING4 Report_Has_Coversheet;
		STRING1 other_vin_indicator;
		STRING7 vehicle_unit_number;
		STRING4 towed;
		STRING80 impact_location;
		STRING1   vehicle_owner_driver_code;
		STRING1   vehicle_driver_action;
		STRING4   vehicle_year;
		STRING100   vehicle_make;  
		STRING2   vehicle_type;
		STRING36  vehicle_travel_on;
		STRING1   direction_travel;
		STRING3   est_vehicle_speed;
		STRING2   posted_speed;
		STRING7   est_vehicle_damage;
		STRING1   damage_type;
		STRING25  vehicle_removed_by;
		STRING1   how_removed_code;
		STRING15  point_of_impact;
		STRING2   vehicle_movement;
		STRING2   vehicle_function;
		STRING2   vehs_first_defect;
		STRING2   vehs_second_defect;
		STRING2   vehicle_modified;
		STRING2   vehicle_roadway_loc;
		STRING1   hazard_material_transport;
		STRING3   total_occu_vehicle;
		STRING3   total_occu_saf_equip;
		STRING1   moving_violation;
		STRING1   vehicle_insur_code;
		STRING1   vehicle_fault_code;
		STRING2   vehicle_cap_code;
		STRING1   vehicle_fr_code;
		STRING2   vehicle_use;
		STRING1   placarded;
		STRING1   dhsmv_vehicle_ind;
		STRING42  vehicle_seg;
		STRING1   vehicle_seg_type;
		STRING14  match_code;
		STRING4   model_year;
		STRING3   manufacturer_corporation;
		STRING1   division_code;
		STRING2   vehicle_group_code;
		STRING2   vehicle_subgroup_code;
		STRING2   vehicle_series_code;
		STRING2   body_style_code;
		STRING3   vehicle_abbreviation;
		STRING1   assembly_country;
		STRING1   headquarter_country;
		STRING1   number_of_doors;
		STRING1   seating_capacity;
		STRING2   number_of_cylinders;
		STRING4   engine_size;
		STRING1   fuel_code;
		STRING1   carburetion_type;
		STRING1   number_of_barrels;
		STRING1   price_class_code;
		STRING2   body_size_code;
		STRING1   number_of_wheels_on_road;
		STRING1   number_of_driving_wheels;
		STRING1   drive_type;
		STRING1   steering_type;
		STRING1   gvw_code;
		STRING1   load_capacity_code;
		STRING1   cab_type_code;
		STRING2   bed_length;
		STRING1   rim_size;
		STRING5   manufacture_body_style;
		STRING1   vehicle_type_code;
		STRING3   car_line_code;
		STRING1   car_series_code;
		STRING1   car_body_style_code;
		STRING1   engine_cylinder_code;
		STRING3   truck_make_abbreviation;
		STRING3   truck_body_style_abbreviation;
		STRING3   motorcycle_make_abbreviation;
		STRING3   vina_series;
		STRING3   vina_model;
		STRING5   reference_number;
		STRING3   vina_make;
		STRING2   vina_body_style;
		STRING100  make_description;
		STRING100  model_description;
		STRING20  series_description;
		STRING3   car_series;
		STRING2   car_body_style;
		STRING3   car_cid;
		STRING2   car_cylinders;
		STRING1   car_carburetion;
		STRING1   car_fuel_code;
		STRING2   truck_chassis_body_style;
		STRING2   truck_wheels_driving_wheels;
		STRING4   truck_cid;
		STRING2   truck_cylinders;
		STRING1   truck_fuel_code;
		STRING1   truck_manufacturers_gvw_code;
		STRING2   truck_ton_rating_code;
		STRING3   truck_series;
		STRING3   truck_model;
		STRING3   motorcycle_model;
		STRING4   motorcycle_engine_displacement;
		STRING2   motorcycle_type_of_bike;
		STRING2   motorcycle_cylinder_coding;
		STRING60 next_street;
		STRING40 addl_report_number;
		STRING11 agency_id;
		STRING9 agency_ori;		
	  STRING11 orig_agency_ori;
				
		//PR Recon COPPR-49
		BOOLEAN is_Terminated_Agency;
		//PR Recon COPPR-63
		BOOLEAN allow_Sale_Of_Component_Data; 
		
		STRING100 Insurance_Company_Standardized ;
		STRING1 is_available_for_public;
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
		STRING40  scrub_addl_report_number;
		STRING20    acct_nbr;
		// Enumaration fields 
		STRING   Report_Collision_Type;
		STRING   Report_First_Harmful_Event;
		STRING   Report_Light_Condition;
	  //PRtcc datatype update for code and description
		STRING Report_Weather_Condition;
		STRING Report_Road_Condition;
    STRING Report_Injury_Status;

		STRING   Report_Damage_Extent;
		STRING   Report_Vehicle_Type;
		STRING   Report_Traffic_Control_Device_Type;
		//PRtcc datatype update for code and description
		STRING Report_Contributing_Circumstances_v;
		
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
		STRING7 Citation_Issued;
		STRING7 Citation_Type;
		STRING200 Citation_Detail1;
		
		//CR-1237
		STRING64 Citation_Status; 
		
		STRING60 Violation_Code1;
		STRING60 Violation_Code2;
		STRING60 Violation_Code3;
		STRING60 Violation_Code4;
		STRING7 Photographs_Taken;
		STRING100 Photographed_By;
		STRING100 Photograph_Type;
		STRING10 Posted_Satutory_Speed_Limit;
		STRING25 Safety_Equipment_Available_Or_Used;
		STRING100 Ejection;
		STRING40 Safety_Equipment_Helmet;
		STRING60 Transported_To;
		STRING20 Dispatch_Time;
		STRING1 Ready_To_Sell_Data;
		//PRtcc new Enum fields
		STRING Alcohol_Drug_Use;
		STRING Alcohol_Drug_Test_Given;
		STRING Alcohol_Test_Status;
		STRING Alcohol_Test_Type;
		STRING Alcohol_Drug_Test_Type;
		STRING Drug_Test_Type;
		STRING Driver_Distracted_By;
		STRING Safety_Equipment_Restraint1;
		STRING Condition_At_Time_Of_Crash;
		STRING Drug_Use_Suspected;
		STRING Alcohol_Use_Suspected;
		STRING Drug_Test_Status;
		STRING Report_Contributing_Circumstances_P;
		STRING Driver_Actions_At_Time_Of_Crash;
		STRING Prior_Nonmotorist_Action;
		STRING Non_Motorist_Actions_At_Time_Of_Crash;
		STRING Pedestrian_Actions_At_Time_Of_Crash;
		STRING Pedalcyclist_Actions_At_Time_Of_Crash;
		STRING Passenger_Actions_At_Time_Of_Crash;
		
		//PRtcc CR-1237		
		STRING Marijuana_Use_Suspected;
				
		//PRtcc CR-1262 
    STRING Direction_Of_Impact;
	  STRING Event_Sequence;
		STRING1 is_Suppressed;
		DATASET(Layout_Infiles_Fixed.Citations_ChildRec) Citation_Details {MAXCOUNT(Constants.Max_Citations_ChildRec_Count)};
		END;

  EXPORT Consolidation := RECORD
		BIPV2.IDlayouts.l_xlink_ids;   //Added for BIP project   
    Consolidation_AgencyOri.dt_first_seen;
    Consolidation_AgencyOri.dt_last_seen;
    STRING2 report_code;
    Consolidation_AgencyOri.report_category;
    Consolidation_AgencyOri.report_code_desc;
    STRING11 vehicle_incident_id;
    Consolidation_AgencyOri.vehicle_status;
    Consolidation_AgencyOri.accident_location;
    Consolidation_AgencyOri.accident_street;
    Consolidation_AgencyOri.accident_cross_street;
    Consolidation_AgencyOri.jurisdiction;
    Consolidation_AgencyOri.jurisdiction_state;
    Consolidation_AgencyOri.jurisdiction_nbr;
    Consolidation_AgencyOri.image_hash;
    Consolidation_AgencyOri.airbags_deploy;
    Consolidation_AgencyOri.did;
    Consolidation_AgencyOri.accident_nbr;
    Consolidation_AgencyOri.accident_date;
    Consolidation_AgencyOri.title;
    Consolidation_AgencyOri.fname;
    Consolidation_AgencyOri.mname;
    Consolidation_AgencyOri.lname;
    Consolidation_AgencyOri.name_suffix;
    Consolidation_AgencyOri.b_did;
    Consolidation_AgencyOri.cname;
    Consolidation_AgencyOri.prim_range;
    Consolidation_AgencyOri.predir;
    Consolidation_AgencyOri.prim_name;
    Consolidation_AgencyOri.addr_suffix;
    Consolidation_AgencyOri.postdir;
    Consolidation_AgencyOri.unit_desig;
    Consolidation_AgencyOri.sec_range;
    Consolidation_AgencyOri.v_city_name;
    Consolidation_AgencyOri.st;
    Consolidation_AgencyOri.zip;
    Consolidation_AgencyOri.zip4;
    Consolidation_AgencyOri.record_type;
    Consolidation_AgencyOri.driver_license_nbr;
    Consolidation_AgencyOri.dlnbr_st;
    Consolidation_AgencyOri.vin;
    Consolidation_AgencyOri.tag_nbr;
    Consolidation_AgencyOri.tagnbr_st;
    Consolidation_AgencyOri.dob;
    Consolidation_AgencyOri.vehicle_incident_city;
    Consolidation_AgencyOri.vehicle_incident_st;
    Consolidation_AgencyOri.carrier_name;
    Consolidation_AgencyOri.client_type_id;
    Consolidation_AgencyOri.policy_num;
    Consolidation_AgencyOri.policy_effective_date;
    Consolidation_AgencyOri.policy_expiration_date;
    Consolidation_AgencyOri.report_has_coversheet;
    Consolidation_AgencyOri.other_vin_indicator;
    Consolidation_AgencyOri.vehicle_unit_number;
    Consolidation_AgencyOri.towed;
    Consolidation_AgencyOri.impact_location;
    Consolidation_AgencyOri.vehicle_owner_driver_code;
    Consolidation_AgencyOri.vehicle_driver_action;
    Consolidation_AgencyOri.vehicle_year;
    Consolidation_AgencyOri.vehicle_make;
    Consolidation_AgencyOri.vehicle_type;
    Consolidation_AgencyOri.vehicle_travel_on;
    Consolidation_AgencyOri.direction_travel;
    Consolidation_AgencyOri.est_vehicle_speed;
    Consolidation_AgencyOri.posted_speed;
    Consolidation_AgencyOri.est_vehicle_damage;
    Consolidation_AgencyOri.damage_type;
    Consolidation_AgencyOri.vehicle_removed_by;
    Consolidation_AgencyOri.how_removed_code;
    Consolidation_AgencyOri.point_of_impact;
    Consolidation_AgencyOri.vehicle_movement;
    Consolidation_AgencyOri.vehicle_function;
    Consolidation_AgencyOri.vehs_first_defect;
    Consolidation_AgencyOri.vehs_second_defect;
    Consolidation_AgencyOri.vehicle_modified;
    Consolidation_AgencyOri.vehicle_roadway_loc;
    Consolidation_AgencyOri.hazard_material_transport;
    Consolidation_AgencyOri.total_occu_vehicle;
    Consolidation_AgencyOri.total_occu_saf_equip;
    Consolidation_AgencyOri.moving_violation;
    Consolidation_AgencyOri.vehicle_insur_code;
    Consolidation_AgencyOri.vehicle_fault_code;
    Consolidation_AgencyOri.vehicle_cap_code;
    Consolidation_AgencyOri.vehicle_fr_code;
    Consolidation_AgencyOri.vehicle_use;
    Consolidation_AgencyOri.placarded;
    Consolidation_AgencyOri.dhsmv_vehicle_ind;
    Consolidation_AgencyOri.vehicle_seg;
    Consolidation_AgencyOri.vehicle_seg_type;
    Consolidation_AgencyOri.match_code;
    Consolidation_AgencyOri.model_year;
    Consolidation_AgencyOri.manufacturer_corporation;
    Consolidation_AgencyOri.division_code;
    Consolidation_AgencyOri.vehicle_group_code;
    Consolidation_AgencyOri.vehicle_subgroup_code;
    Consolidation_AgencyOri.vehicle_series_code;
    Consolidation_AgencyOri.body_style_code;
    Consolidation_AgencyOri.vehicle_abbreviation;
    Consolidation_AgencyOri.assembly_country;
    Consolidation_AgencyOri.headquarter_country;
    Consolidation_AgencyOri.number_of_doors;
    Consolidation_AgencyOri.seating_capacity;
    Consolidation_AgencyOri.number_of_cylinders;
    Consolidation_AgencyOri.engine_size;
    Consolidation_AgencyOri.fuel_code;
    Consolidation_AgencyOri.carburetion_type;
    Consolidation_AgencyOri.number_of_barrels;
    Consolidation_AgencyOri.price_class_code;
    Consolidation_AgencyOri.body_size_code;
    Consolidation_AgencyOri.number_of_wheels_on_road;
    Consolidation_AgencyOri.number_of_driving_wheels;
    Consolidation_AgencyOri.drive_type;
    Consolidation_AgencyOri.steering_type;
    Consolidation_AgencyOri.gvw_code;
    Consolidation_AgencyOri.load_capacity_code;
    Consolidation_AgencyOri.cab_type_code;
    Consolidation_AgencyOri.bed_length;
    Consolidation_AgencyOri.rim_size;
    Consolidation_AgencyOri.manufacture_body_style;
    Consolidation_AgencyOri.vehicle_type_code;
    Consolidation_AgencyOri.car_line_code;
    Consolidation_AgencyOri.car_series_code;
    Consolidation_AgencyOri.car_body_style_code;
    Consolidation_AgencyOri.engine_cylinder_code;
    Consolidation_AgencyOri.truck_make_abbreviation;
    Consolidation_AgencyOri.truck_body_style_abbreviation;
    Consolidation_AgencyOri.motorcycle_make_abbreviation;
    Consolidation_AgencyOri.vina_series;
    Consolidation_AgencyOri.vina_model;
    Consolidation_AgencyOri.reference_number;
    Consolidation_AgencyOri.vina_make;
    Consolidation_AgencyOri.vina_body_style;
    Consolidation_AgencyOri.make_description;
    Consolidation_AgencyOri.model_description;
    Consolidation_AgencyOri.series_description;
    Consolidation_AgencyOri.car_series;
    Consolidation_AgencyOri.car_body_style;
    Consolidation_AgencyOri.car_cid;
    Consolidation_AgencyOri.car_cylinders;
    Consolidation_AgencyOri.car_carburetion;
    Consolidation_AgencyOri.car_fuel_code;
    Consolidation_AgencyOri.truck_chassis_body_style;
    Consolidation_AgencyOri.truck_wheels_driving_wheels;
    Consolidation_AgencyOri.truck_cid;
    Consolidation_AgencyOri.truck_cylinders;
    Consolidation_AgencyOri.truck_fuel_code;
    Consolidation_AgencyOri.truck_manufacturers_gvw_code;
    Consolidation_AgencyOri.truck_ton_rating_code;
    Consolidation_AgencyOri.truck_series;
    Consolidation_AgencyOri.truck_model;
    Consolidation_AgencyOri.motorcycle_model;
    Consolidation_AgencyOri.motorcycle_engine_displacement;
    Consolidation_AgencyOri.motorcycle_type_of_bike;
    Consolidation_AgencyOri.motorcycle_cylinder_coding;
    Consolidation_AgencyOri.next_street;
    Consolidation_AgencyOri.addl_report_number;
    Consolidation_AgencyOri.agency_ori;
		
		//PR Recon COPPR-63
    Consolidation_AgencyOri.allow_Sale_Of_Component_Data;
		
    Consolidation_AgencyOri.insurance_company_standardized;
    Consolidation_AgencyOri.is_available_for_public;
    Consolidation_AgencyOri.report_status;
    Consolidation_AgencyOri.work_type_id;
    Consolidation_AgencyOri.orig_full_name;
    Consolidation_AgencyOri.orig_fname;
    Consolidation_AgencyOri.orig_lname;
    Consolidation_AgencyOri.orig_mname;
    Consolidation_AgencyOri.ssn;
    Consolidation_AgencyOri.cru_order_id;
    Consolidation_AgencyOri.cru_sequence_nbr;
    Consolidation_AgencyOri.date_vendor_last_reported;
    Consolidation_AgencyOri.report_type_id;
    Consolidation_AgencyOri.creation_date;
    Consolidation_AgencyOri.tif_image_hash;

    // Admin analytics
    Consolidation_AgencyOri.precinct;
    Consolidation_AgencyOri.beat;
    Consolidation_AgencyOri.crash_time;
    Consolidation_AgencyOri.vendor_code;
    Consolidation_AgencyOri.report_property_damage;

    // CRU2eCrash integration 
    Consolidation_AgencyOri.cru_jurisdiction;
    Consolidation_AgencyOri.cru_jurisdiction_nbr;
    Consolidation_AgencyOri.crash_county;
    Consolidation_AgencyOri.vehicle_color;
    Consolidation_AgencyOri.orig_accnbr;
    Consolidation_AgencyOri.scrub_addl_report_number;
    Consolidation_AgencyOri.acct_nbr;

    // Enumaration fields 
    Consolidation_AgencyOri.report_collision_type;
    Consolidation_AgencyOri.report_first_harmful_event;
    Consolidation_AgencyOri.report_light_condition;

    Consolidation_AgencyOri.report_weather_condition;
    Consolidation_AgencyOri.report_road_condition;
    Consolidation_AgencyOri.report_injury_status;

    //PRtcc datatype update for code and description
    Consolidation_AgencyOri.report_damage_extent;
    Consolidation_AgencyOri.report_vehicle_type;
    Consolidation_AgencyOri.report_traffic_control_device_type;

    //PRtcc datatype update for code and description
    Consolidation_AgencyOri.report_contributing_circumstances_v;

    Consolidation_AgencyOri.report_vehicle_maneuver_action_prior;
    Consolidation_AgencyOri.report_vehicle_body_type;
    Consolidation_AgencyOri.cru_inq_name_type;
    Consolidation_AgencyOri.vendor_report_id;
    Consolidation_AgencyOri.reason_id;
    Consolidation_AgencyOri.report_id;
    Consolidation_AgencyOri.super_report_id;
    Consolidation_AgencyOri.reportlinkid;
    Consolidation_AgencyOri.idfield;
    Consolidation_AgencyOri.page_count;
    Consolidation_AgencyOri.supplemental_report;

    // New fields for Police RECORDs
    Consolidation_AgencyOri.fatality_involved;
    Consolidation_AgencyOri.latitude;
    Consolidation_AgencyOri.longitude;
    Consolidation_AgencyOri.address1;
    Consolidation_AgencyOri.address2;
    Consolidation_AgencyOri.state;
    Consolidation_AgencyOri.home_phone;

    //Buycrash project KY integration
    Consolidation_AgencyOri.contrib_source;

    //Buycrash Release 4
    Consolidation_AgencyOri.officer_id;

    //Appriss Integration
    Consolidation_AgencyOri.releasable;

    //BuyCrash Release 6
    Consolidation_AgencyOri.date_report_submitted;

    //PRtCC new fields
    Consolidation_AgencyOri.citation_issued;
    Consolidation_AgencyOri.citation_type;
    Consolidation_AgencyOri.citation_detail1;
    Consolidation_AgencyOri.violation_code1;
    Consolidation_AgencyOri.violation_code2;
    Consolidation_AgencyOri.violation_code3;
    Consolidation_AgencyOri.violation_code4;
    Consolidation_AgencyOri.photographs_taken;
    Consolidation_AgencyOri.photographed_by;
    Consolidation_AgencyOri.photograph_type;
    Consolidation_AgencyOri.posted_satutory_speed_limit;
    Consolidation_AgencyOri.safety_equipment_available_or_used;
    Consolidation_AgencyOri.ejection;
    Consolidation_AgencyOri.safety_equipment_helmet;
    Consolidation_AgencyOri.transported_to;
    Consolidation_AgencyOri.dispatch_time;
    Consolidation_AgencyOri.ready_to_sell_data;

    //PRtcc new Enum fields
    Consolidation_AgencyOri.alcohol_drug_use;
    Consolidation_AgencyOri.alcohol_drug_test_given;
    Consolidation_AgencyOri.alcohol_test_status;
    Consolidation_AgencyOri.alcohol_test_type;
    Consolidation_AgencyOri.alcohol_drug_test_type;
    Consolidation_AgencyOri.drug_test_type;
    Consolidation_AgencyOri.driver_distracted_by;
    Consolidation_AgencyOri.safety_equipment_restraint1;
    Consolidation_AgencyOri.condition_at_time_of_crash;
    Consolidation_AgencyOri.drug_use_suspected;
    Consolidation_AgencyOri.alcohol_use_suspected;
    Consolidation_AgencyOri.drug_test_status;
    Consolidation_AgencyOri.report_contributing_circumstances_p;
    Consolidation_AgencyOri.driver_actions_at_time_of_crash;
    Consolidation_AgencyOri.prior_nonmotorist_action;
    Consolidation_AgencyOri.non_motorist_actions_at_time_of_crash;
    Consolidation_AgencyOri.pedestrian_actions_at_time_of_crash;
    Consolidation_AgencyOri.pedalcyclist_actions_at_time_of_crash;
    Consolidation_AgencyOri.passenger_actions_at_time_of_crash;
		
		//PRtcc CR-1262 
    Consolidation_AgencyOri.Direction_Of_Impact;
	  Consolidation_AgencyOri.Event_Sequence;
	END;

  EXPORT Accidents_Alpha := RECORD
    Consolidation_AgencyOri AND NOT [orig_agency_ori, Direction_Of_Impact, Event_Sequence, allow_Sale_Of_Component_Data];
  END;

END;