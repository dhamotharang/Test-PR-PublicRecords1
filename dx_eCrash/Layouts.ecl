EXPORT Layouts := MODULE

// ########################################################################### 
//           ECRASH ANALYTICS KEYS
// ##########################################################################
EXPORT BY_AGENCYID := RECORD
  STRING11 agencyid;
  STRING10 accident_date;
  STRING30 precinct;
  STRING20 beat;
  INTEGER8 accidentcnt;
  INTEGER8 injurycnt;
  INTEGER8 fatalcnt;
  INTEGER8 unknowncnt;
END;

EXPORT BY_AGENCYID_KEYED_FIELDS := RECORD
    BY_AGENCYID.AGENCYID;
    BY_AGENCYID.ACCIDENT_DATE;
END;

EXPORT BY_AGENCYID_PAYLOAD_FIELDS := RECORD
	  BY_AGENCYID AND NOT BY_AGENCYID_KEYED_FIELDS;
END; 

EXPORT BY_CT := RECORD
  STRING11 agencyid;
  STRING8 accident_date;
  INTEGER8 accidentcnt;
  INTEGER8 ctfrontrear;
  INTEGER8 ctfrontfront;
  INTEGER8 ctangle;
  INTEGER8 ctsideswipesame;
  INTEGER8 ctsideswipeopposite;
  INTEGER8 ctrearside;
  INTEGER8 ctrearrear;
  INTEGER8 ctother;
  INTEGER8 ctunknown;
END;

EXPORT BY_CT_KEYED_FIELDS := RECORD
    BY_CT.AGENCYID;
    BY_CT.ACCIDENT_DATE;
END;

EXPORT BY_CT_PAYLOAD_FIELDS := RECORD
	  BY_CT AND NOT BY_CT_KEYED_FIELDS;
END; 

EXPORT BY_DOW := RECORD
  STRING11 agencyid;
  STRING8 accident_date;
  INTEGER8 dayofweek;
  INTEGER8 accidentcnt;
  INTEGER8 injurycnt;
  INTEGER8 fatalcnt;
  INTEGER8 unknowncnt;
END;
 
EXPORT BY_DOW_KEYED_FIELDS := RECORD
    BY_DOW.AGENCYID;
    BY_DOW.ACCIDENT_DATE;
END;

EXPORT BY_DOW_PAYLOAD_FIELDS := RECORD
	  BY_DOW AND NOT BY_DOW_KEYED_FIELDS;
END; 

EXPORT BY_HOD := RECORD
  STRING11 agencyid;
  STRING8 accident_date;
  INTEGER8 hourofday;
  INTEGER8 accidentcnt;
  INTEGER8 injurycnt;
  INTEGER8 fatalcnt;
  INTEGER8 unknowncnt;
END;

EXPORT BY_HOD_KEYED_FIELDS := RECORD
    BY_HOD.AGENCYID;
    BY_HOD.ACCIDENT_DATE;
END;

EXPORT BY_HOD_PAYLOAD_FIELDS := RECORD
	  BY_HOD AND NOT BY_HOD_KEYED_FIELDS;
END; 

EXPORT BY_INTER := RECORD
  STRING11 agencyid;
  STRING8 accident_date;
  INTEGER8 dayofweek;
  INTEGER8 tour;
  STRING intersection;
  INTEGER8 accidentcnt;
  INTEGER8 atvehicle;
  INTEGER8 atpedestrian;
  INTEGER8 atbicycle;
  INTEGER8 atmotorcycle;
  INTEGER8 atanimal;
  INTEGER8 attrain;
  INTEGER8 atunknown;
  INTEGER8 ctfrontrear;
  INTEGER8 ctfrontfront;
  INTEGER8 ctangle;
  INTEGER8 ctsideswipesame;
  INTEGER8 ctsideswipeopposite;
  INTEGER8 ctrearside;
  INTEGER8 ctrearrear;
  INTEGER8 ctother;
  INTEGER8 ctunknown;
  INTEGER8 injurycnt;
  INTEGER8 fatalcnt;
  INTEGER8 propdmgcnt;
END;
 
EXPORT BY_INTER_KEYED_FIELDS := RECORD
    BY_INTER.AGENCYID;
    BY_INTER.ACCIDENT_DATE;
END;

EXPORT BY_INTER_PAYLOAD_FIELDS := RECORD
	  BY_INTER AND NOT BY_INTER_KEYED_FIELDS;
END;

EXPORT BY_MOY := RECORD
  STRING11 agencyid;
  STRING8 accident_date;
  STRING2 monthofyear;
  INTEGER8 accidentcnt;
  INTEGER8 injurycnt;
  INTEGER8 fatalcnt;
  INTEGER8 unknowncnt;
END;
 
EXPORT BY_MOY_KEYED_FIELDS := RECORD
    BY_MOY.AGENCYID;
    BY_MOY.ACCIDENT_DATE;
END;

EXPORT BY_MOY_PAYLOAD_FIELDS := RECORD
	  BY_MOY AND NOT BY_MOY_KEYED_FIELDS;
END;

// ########################################################################### 
//           ECRASH KEYS
// ##########################################################################
EXPORT DOL := RECORD
  STRING8 accident_date;
  STRING2 report_code;
  STRING2 jurisdiction_state;
  STRING100 jurisdiction;
  STRING8 dt_first_seen;
  STRING8 dt_last_seen;
  STRING25 report_category;
  STRING65 report_code_desc;
  STRING11 vehicle_incident_id;
  STRING1 vehicle_status;
  STRING100 accident_location;
  STRING100 accident_street;
  STRING100 accident_cross_street;
  STRING11 jurisdiction_nbr;
  STRING64 image_hash;
  STRING1 airbags_deploy;
  STRING12 did;
  STRING40 accident_nbr;
  STRING5 title;
  STRING20 fname;
  STRING20 mname;
  STRING20 lname;
  STRING5 name_suffix;
  STRING12 b_did;
  STRING25 cname;
  STRING10 prim_range;
  STRING2 predir;
  STRING28 prim_name;
  STRING4 addr_suffix;
  STRING2 postdir;
  STRING10 unit_desig;
  STRING8 sec_range;
  STRING25 v_city_name;
  STRING2 st;
  STRING5 zip;
  STRING4 zip4;
  STRING100 record_type;
  STRING25 driver_license_nbr;
  STRING2 dlnbr_st;
  STRING30 vin;
  STRING10 tag_nbr;
  STRING2 tagnbr_st;
  STRING8 dob;
  STRING50 vehicle_incident_city;
  STRING2 vehicle_incident_st;
  STRING100 carrier_name;
  STRING5 client_type_id;
  STRING50 policy_num;
  STRING8 policy_effective_date;
  STRING8 policy_expiration_date;
  STRING4 report_has_coversheet;
  STRING1 other_vin_indicator;
  STRING7 vehicle_unit_number;
  STRING4 towed;
  STRING80 impact_location;
  STRING1 vehicle_owner_driver_code;
  STRING1 vehicle_driver_action;
  STRING4 vehicle_year;
  STRING100 vehicle_make;
  STRING2 vehicle_type;
  STRING36 vehicle_travel_on;
  STRING1 direction_travel;
  STRING3 est_vehicle_speed;
  STRING2 posted_speed;
  STRING7 est_vehicle_damage;
  STRING1 damage_type;
  STRING25 vehicle_removed_by;
  STRING1 how_removed_code;
  STRING15 point_of_impact;
  STRING2 vehicle_movement;
  STRING2 vehicle_function;
  STRING2 vehs_first_defect;
  STRING2 vehs_second_defect;
  STRING2 vehicle_modified;
  STRING2 vehicle_roadway_loc;
  STRING1 hazard_material_transport;
  STRING3 total_occu_vehicle;
  STRING3 total_occu_saf_equip;
  STRING1 moving_violation;
  STRING1 vehicle_insur_code;
  STRING1 vehicle_fault_code;
  STRING2 vehicle_cap_code;
  STRING1 vehicle_fr_code;
  STRING2 vehicle_use;
  STRING1 placarded;
  STRING1 dhsmv_vehicle_ind;
  STRING42 vehicle_seg;
  STRING1 vehicle_seg_type;
  STRING14 match_code;
  STRING4 model_year;
  STRING3 manufacturer_corporation;
  STRING1 division_code;
  STRING2 vehicle_group_code;
  STRING2 vehicle_subgroup_code;
  STRING2 vehicle_series_code;
  STRING2 body_style_code;
  STRING3 vehicle_abbreviation;
  STRING1 assembly_country;
  STRING1 headquarter_country;
  STRING1 number_of_doors;
  STRING1 seating_capacity;
  STRING2 number_of_cylinders;
  STRING4 engine_size;
  STRING1 fuel_code;
  STRING1 carburetion_type;
  STRING1 number_of_barrels;
  STRING1 price_class_code;
  STRING2 body_size_code;
  STRING1 number_of_wheels_on_road;
  STRING1 number_of_driving_wheels;
  STRING1 drive_type;
  STRING1 steering_type;
  STRING1 gvw_code;
  STRING1 load_capacity_code;
  STRING1 cab_type_code;
  STRING2 bed_length;
  STRING1 rim_size;
  STRING5 manufacture_body_style;
  STRING1 vehicle_type_code;
  STRING3 car_line_code;
  STRING1 car_series_code;
  STRING1 car_body_style_code;
  STRING1 engine_cylinder_code;
  STRING3 truck_make_abbreviation;
  STRING3 truck_body_style_abbreviation;
  STRING3 motorcycle_make_abbreviation;
  STRING3 vina_series;
  STRING3 vina_model;
  STRING5 reference_number;
  STRING3 vina_make;
  STRING2 vina_body_style;
  STRING100 make_description;
  STRING100 model_description;
  STRING20 series_description;
  STRING3 car_series;
  STRING2 car_body_style;
  STRING3 car_cid;
  STRING2 car_cylinders;
  STRING1 car_carburetion;
  STRING1 car_fuel_code;
  STRING2 truck_chassis_body_style;
  STRING2 truck_wheels_driving_wheels;
  STRING4 truck_cid;
  STRING2 truck_cylinders;
  STRING1 truck_fuel_code;
  STRING1 truck_manufacturers_gvw_code;
  STRING2 truck_ton_rating_code;
  STRING3 truck_series;
  STRING3 truck_model;
  STRING3 motorcycle_model;
  STRING4 motorcycle_engine_displacement;
  STRING2 motorcycle_type_of_bike;
  STRING2 motorcycle_cylinder_coding;
  STRING60 next_street;
  STRING40 orig_accnbr;
  STRING40 addl_report_number;
  STRING9 agency_ori;
  STRING100 insurance_company_standardized;
  STRING1 is_available_for_public;
  STRING20 report_status;
  STRING4 work_type_id;
  STRING150 orig_full_name;
  STRING60 orig_fname;
  STRING100 orig_lname;
  STRING60 orig_mname;
  STRING11 ssn;
  STRING12 cru_order_id;
  STRING2 cru_sequence_nbr;
  STRING8 date_vendor_last_reported;
  STRING3 report_type_id;
  STRING11 report_id;
  STRING11 super_report_id;
  STRING100 vendor_code;
  STRING20 vendor_report_id;
  UNSIGNED8 idfield;
  STRING20 reportlinkid;
 END;

EXPORT DOL_KEYED_FIELDS := RECORD
    DOL.ACCIDENT_DATE;
    DOL.REPORT_CODE;
    DOL.JURISDICTION_STATE;
    DOL.JURISDICTION;
END;

EXPORT DOL_PAYLOAD_FIELDS := RECORD
	  DOL AND NOT DOL_KEYED_FIELDS;
END;

EXPORT LINKIDS := RECORD
  UNSIGNED6 ultid;
  UNSIGNED6 orgid;
  UNSIGNED6 seleid;
  UNSIGNED6 proxid;
  UNSIGNED6 powid;
  UNSIGNED6 empid;
  UNSIGNED6 dotid;
  UNSIGNED2 ultscore;
  UNSIGNED2 orgscore;
  UNSIGNED2 selescore;
  UNSIGNED2 proxscore;
  UNSIGNED2 powscore;
  UNSIGNED2 empscore;
  UNSIGNED2 dotscore;
  UNSIGNED2 ultweight;
  UNSIGNED2 orgweight;
  UNSIGNED2 seleweight;
  UNSIGNED2 proxweight;
  UNSIGNED2 powweight;
  UNSIGNED2 empweight;
  UNSIGNED2 dotweight;
  STRING12 b_did;
  STRING40 accident_nbr;
  STRING40 orig_accnbr;
  INTEGER1 fp;
 END;

EXPORT LINKIDS_KEYED_FIELDS := RECORD
    LINKIDS.ULTID;
    LINKIDS.ORGID;
    LINKIDS.SELEID;
    LINKIDS.PROXID;
    LINKIDS.POWID;
    LINKIDS.EMPID;
    LINKIDS.DOTID;
END;

EXPORT LINKIDS_PAYLOAD_FIELDS := RECORD
	  LINKIDS AND NOT LINKIDS_KEYED_FIELDS;
END;

EXPORT UNRESTRICTED_ACCNBRV1 := RECORD
  STRING40 l_accnbr;
  STRING2 report_code;
  STRING2 jurisdiction_state;
  STRING100 jurisdiction;
  STRING40 orig_accnbr;
  STRING11 vehicle_incident_id;
  STRING1 vehicle_status;
  STRING8 dt_first_seen;
  STRING8 dt_last_seen;
  STRING8 accident_date;
  STRING12 did;
  STRING5 title;
  STRING20 fname;
  STRING20 mname;
  STRING20 lname;
  STRING5 name_suffix;
  STRING8 dob;
  STRING12 b_did;
  STRING25 cname;
  STRING10 prim_range;
  STRING2 predir;
  STRING28 prim_name;
  STRING4 addr_suffix;
  STRING2 postdir;
  STRING10 unit_desig;
  STRING8 sec_range;
  STRING25 v_city_name;
  STRING2 st;
  STRING5 zip;
  STRING4 zip4;
  STRING100 record_type;
  STRING65 report_code_desc;
  STRING25 report_category;
  STRING30 vin;
  STRING25 driver_license_nbr;
  STRING2 dlnbr_st;
  STRING10 tag_nbr;
  STRING2 tagnbr_st;
  STRING100 accident_location;
  STRING100 accident_street;
  STRING100 accident_cross_street;
  STRING60 next_street;
  STRING11 jurisdiction_nbr;
  STRING64 image_hash;
  STRING1 airbags_deploy;
  STRING50 policy_num;
  STRING8 policy_effective_date;
  STRING8 policy_expiration_date;
  STRING4 report_has_coversheet;
  STRING1 other_vin_indicator;
  STRING7 vehicle_unit_number;
  STRING50 vehicle_incident_city;
  STRING2 vehicle_incident_st;
  STRING100 carrier_name;
  STRING5 client_type_id;
  STRING4 towed;
  STRING80 impact_location;
  STRING1 vehicle_owner_driver_code;
  STRING1 vehicle_driver_action;
  STRING4 vehicle_year;
  STRING100 vehicle_make;
  STRING2 vehicle_type;
  STRING36 vehicle_travel_on;
  STRING1 direction_travel;
  STRING3 est_vehicle_speed;
  STRING2 posted_speed;
  STRING7 est_vehicle_damage;
  STRING1 damage_type;
  STRING25 vehicle_removed_by;
  STRING1 how_removed_code;
  STRING15 point_of_impact;
  STRING2 vehicle_movement;
  STRING2 vehicle_function;
  STRING2 vehs_first_defect;
  STRING2 vehs_second_defect;
  STRING2 vehicle_modified;
  STRING2 vehicle_roadway_loc;
  STRING1 hazard_material_transport;
  STRING3 total_occu_vehicle;
  STRING3 total_occu_saf_equip;
  STRING1 moving_violation;
  STRING1 vehicle_insur_code;
  STRING1 vehicle_fault_code;
  STRING2 vehicle_cap_code;
  STRING1 vehicle_fr_code;
  STRING2 vehicle_use;
  STRING1 placarded;
  STRING1 dhsmv_vehicle_ind;
  STRING42 vehicle_seg;
  STRING1 vehicle_seg_type;
  STRING14 match_code;
  STRING4 model_year;
  STRING3 manufacturer_corporation;
  STRING1 division_code;
  STRING2 vehicle_group_code;
  STRING2 vehicle_subgroup_code;
  STRING2 vehicle_series_code;
  STRING2 body_style_code;
  STRING3 vehicle_abbreviation;
  STRING1 assembly_country;
  STRING1 headquarter_country;
  STRING1 number_of_doors;
  STRING1 seating_capacity;
  STRING2 number_of_cylinders;
  STRING4 engine_size;
  STRING1 fuel_code;
  STRING1 carburetion_type;
  STRING1 number_of_barrels;
  STRING1 price_class_code;
  STRING2 body_size_code;
  STRING1 number_of_wheels_on_road;
  STRING1 number_of_driving_wheels;
  STRING1 drive_type;
  STRING1 steering_type;
  STRING1 gvw_code;
  STRING1 load_capacity_code;
  STRING1 cab_type_code;
  STRING2 bed_length;
  STRING1 rim_size;
  STRING5 manufacture_body_style;
  STRING1 vehicle_type_code;
  STRING3 car_line_code;
  STRING1 car_series_code;
  STRING1 car_body_style_code;
  STRING1 engine_cylinder_code;
  STRING3 truck_make_abbreviation;
  STRING3 truck_body_style_abbreviation;
  STRING3 motorcycle_make_abbreviation;
  STRING3 vina_series;
  STRING3 vina_model;
  STRING5 reference_number;
  STRING3 vina_make;
  STRING2 vina_body_style;
  STRING100 make_description;
  STRING100 model_description;
  STRING20 series_description;
  STRING3 car_series;
  STRING2 car_body_style;
  STRING3 car_cid;
  STRING2 car_cylinders;
  STRING1 car_carburetion;
  STRING1 car_fuel_code;
  STRING2 truck_chassis_body_style;
  STRING2 truck_wheels_driving_wheels;
  STRING4 truck_cid;
  STRING2 truck_cylinders;
  STRING1 truck_fuel_code;
  STRING1 truck_manufacturers_gvw_code;
  STRING2 truck_ton_rating_code;
  STRING3 truck_series;
  STRING3 truck_model;
  STRING3 motorcycle_model;
  STRING4 motorcycle_engine_displacement;
  STRING2 motorcycle_type_of_bike;
  STRING2 motorcycle_cylinder_coding;
  STRING40 addl_report_number;
  STRING9 agency_ori;
  STRING100 insurance_company_standardized;
  STRING1 is_available_for_public;
  STRING20 report_status;
  STRING4 work_type_id;
  STRING60 orig_fname;
  STRING100 orig_lname;
  STRING60 orig_mname;
  STRING150 orig_full_name;
  STRING11 ssn;
  STRING12 cru_order_id;
  STRING2 cru_sequence_nbr;
  STRING8 date_vendor_last_reported;
  STRING3 report_type_id;
  STRING70 tif_image_hash;
  STRING11 super_report_id;
  STRING11 report_id;
  STRING100 vendor_code;
  STRING20 vendor_report_id;
  UNSIGNED6 idfield;
  STRING20 reportlinkid;
  STRING3 page_count;
  STRING3 contrib_source;
  STRING8 creation_date;
  STRING12 officer_id;
  STRING1 releasable;
  STRING10 date_report_submitted;
 END;

EXPORT UNRESTRICTED_ACCNBRV1_KEYED_FIELDS := RECORD
    UNRESTRICTED_ACCNBRV1.L_ACCNBR;
    UNRESTRICTED_ACCNBRV1.REPORT_CODE;
    UNRESTRICTED_ACCNBRV1.JURISDICTION_STATE;
    UNRESTRICTED_ACCNBRV1.JURISDICTION;
END;

EXPORT UNRESTRICTED_ACCNBRV1_PAYLOAD_FIELDS := RECORD
	  UNRESTRICTED_ACCNBRV1 AND NOT UNRESTRICTED_ACCNBRV1_KEYED_FIELDS;
END;

EXPORT DELTADATE := RECORD
  STRING9 delta_text;
	STRING19 Date_Added;
END;

EXPORT DELTADATE_KEYED_FIELDS := RECORD
    DELTADATE.DELTA_TEXT;
END;

EXPORT DELTADATE_PAYLOAD_FIELDS := RECORD
	  DELTADATE AND NOT DELTADATE_KEYED_FIELDS;
END;
	
EXPORT AGENCY := RECORD
  STRING3 agency_state_abbr;
  STRING100 agency_name;
  STRING11 agency_ori;
  STRING11 mbsi_agency_id;
  STRING5 cru_agency_id;
  UNSIGNED3 cru_state_number;
  STRING3 source_id;
  STRING2 append_overwrite_flag;
  STRING10 source_start_date;
  STRING10 source_end_date;
  STRING20 source_termination_date;
  STRING1 source_resale_allowed;
  STRING1 source_auto_renew;
  STRING1 source_allow_sale_of_component_data;
  STRING1 source_allow_extract_of_vehicle_data;
END;
 
EXPORT AGENCY_KEYED_FIELDS := RECORD
    AGENCY.AGENCY_STATE_ABBR;
    AGENCY.AGENCY_NAME;
    AGENCY.AGENCY_ORI;
END;

EXPORT AGENCY_PAYLOAD_FIELDS := RECORD
	  AGENCY AND NOT AGENCY_KEYED_FIELDS;
END;

EXPORT PHOTOID := RECORD
  STRING11 super_report_id;
  STRING11 document_id;
  STRING3 report_type;
  STRING11 incident_id;
  STRING64 document_hash_key;
  STRING19 date_created;
  STRING1 is_deleted;
  STRING3 page_count;
  STRING3 extension;
  STRING3 report_source;
END;
 
EXPORT PHOTOID_KEYED_FIELDS := RECORD
    PHOTOID.SUPER_REPORT_ID;
    PHOTOID.DOCUMENT_ID;
    PHOTOID.REPORT_TYPE;
END;

EXPORT PHOTOID_PAYLOAD_FIELDS := RECORD
	  PHOTOID AND NOT PHOTOID_KEYED_FIELDS;
END;

EXPORT REPORTID := RECORD
  STRING11 report_id;
	STRING11 super_report_id;
END;
 
EXPORT REPORTID_KEYED_FIELDS := RECORD
    REPORTID.REPORT_ID;
END;

EXPORT REPORTID_PAYLOAD_FIELDS := RECORD
	  REPORTID AND NOT REPORTID_KEYED_FIELDS;
END;

EXPORT SUPPLEMENTAL := RECORD
  STRING11 super_report_id;
  STRING11 report_id;
  STRING64 hash_key;
  STRING40 accident_nbr;
  STRING2 report_code;
  STRING100 jurisdiction;
  STRING2 jurisdiction_state;
  STRING8 accident_date;
  STRING40 orig_accnbr;
  STRING4 work_type_id;
  STRING3 report_type_id;
  STRING9 agency_ori;
  STRING40 addl_report_number;
  STRING100 vendor_code;
  STRING20 vendor_report_id;
  STRING3 page_count;
END;

EXPORT SUPPLEMENTAL_KEYED_FIELDS := RECORD
    SUPPLEMENTAL.SUPER_REPORT_ID;
END;

EXPORT SUPPLEMENTAL_PAYLOAD_FIELDS := RECORD
	  SUPPLEMENTAL AND NOT SUPPLEMENTAL_KEYED_FIELDS;
END;
// ########################################################################### 
//           ECRASH SEARCH KEYS
// ##########################################################################

EXPORT DLNNBRDLSTATE := RECORD
  STRING25 driver_license_nbr;
  STRING2 dlnbr_st;
  STRING2 jurisdiction_state;
  STRING100 jurisdiction;
  STRING40 accident_nbr;
  STRING40 orig_accnbr;
  STRING40 addl_report_number;
  STRING8 accident_date;
  STRING2 report_code;
  STRING11 jurisdiction_nbr;
  STRING4 work_type_id;
  STRING3 report_type_id;
  STRING11 report_id;
  STRING9 agency_ori;
  STRING100 vendor_code;
  STRING20 vendor_report_id;
  STRING20 reportlinkid;
  STRING30 vin;
  STRING10 tag_nbr;
  STRING2 tagnbr_st;
  STRING12 officer_id;
  STRING8 date_vendor_last_reported;
  STRING100 accident_location;
  UNSIGNED6 idfield;
  STRING12 did;
  STRING60 fname;
  STRING60 mname;
  STRING100 lname;
  STRING3 contrib_source;
END;

EXPORT DLNNBRDLSTATE_KEYED_FIELDS := RECORD
    DLNNBRDLSTATE.DRIVER_LICENSE_NBR;
    DLNNBRDLSTATE.DLNBR_ST;
    DLNNBRDLSTATE.JURISDICTION_STATE;
    DLNNBRDLSTATE.JURISDICTION;
END;

EXPORT DLNNBRDLSTATE_PAYLOAD_FIELDS := RECORD
	  DLNNBRDLSTATE AND NOT DLNNBRDLSTATE_KEYED_FIELDS;
END;

EXPORT VINNBR := RECORD
  STRING30 vin;
  STRING2 jurisdiction_state;
  STRING100 jurisdiction;
  STRING40 accident_nbr;
  STRING40 orig_accnbr;
  STRING40 addl_report_number;
  STRING8 accident_date;
  STRING2 report_code;
  STRING11 jurisdiction_nbr;
  STRING4 work_type_id;
  STRING3 report_type_id;
  STRING11 report_id;
  STRING9 agency_ori;
  STRING100 vendor_code;
  STRING20 vendor_report_id;
  STRING20 reportlinkid;
  STRING25 driver_license_nbr;
  STRING2 dlnbr_st;
  STRING10 tag_nbr;
  STRING2 tagnbr_st;
  STRING12 officer_id;
  STRING8 date_vendor_last_reported;
  STRING100 accident_location;
  UNSIGNED6 idfield;
  STRING12 did;
  STRING60 fname;
  STRING60 mname;
  STRING100 lname;
  STRING3 contrib_source;
END;

EXPORT VINNBR_KEYED_FIELDS := RECORD
    VINNBR.VIN;
    VINNBR.JURISDICTION_STATE;
    VINNBR.JURISDICTION;
END;

EXPORT VINNBR_PAYLOAD_FIELDS := RECORD
	  VINNBR AND NOT VINNBR_KEYED_FIELDS;
END;

EXPORT LICENSEPLATENBR := RECORD
  STRING10 tag_nbr;
  STRING2 tagnbr_st;
  STRING2 jurisdiction_state;
  STRING100 jurisdiction;
  STRING40 accident_nbr;
  STRING40 orig_accnbr;
  STRING40 addl_report_number;
  STRING8 accident_date;
  STRING2 report_code;
  STRING11 jurisdiction_nbr;
  STRING4 work_type_id;
  STRING3 report_type_id;
  STRING11 report_id;
  STRING9 agency_ori;
  STRING100 vendor_code;
  STRING20 vendor_report_id;
  STRING20 reportlinkid;
  STRING30 vin;
  STRING25 driver_license_nbr;
  STRING2 dlnbr_st;
  STRING12 officer_id;
  STRING8 date_vendor_last_reported;
  STRING100 accident_location;
  UNSIGNED6 idfield;
  STRING12 did;
  STRING60 fname;
  STRING60 mname;
  STRING100 lname;
  STRING3 contrib_source;
 END;

EXPORT LICENSEPLATENBR_KEYED_FIELDS := RECORD
    LICENSEPLATENBR.TAG_NBR;
    LICENSEPLATENBR.TAGNBR_ST;
    LICENSEPLATENBR.JURISDICTION_STATE;
    LICENSEPLATENBR.JURISDICTION;
END;

EXPORT LICENSEPLATENBR_PAYLOAD_FIELDS := RECORD
	  LICENSEPLATENBR AND NOT LICENSEPLATENBR_KEYED_FIELDS;
END;

EXPORT OFFICERBADGENBR := RECORD
  STRING12 officer_id;
  STRING2 jurisdiction_state;
  STRING100 jurisdiction;
  STRING40 accident_nbr;
  STRING40 orig_accnbr;
  STRING40 addl_report_number;
  STRING8 accident_date;
  STRING2 report_code;
  STRING11 jurisdiction_nbr;
  STRING4 work_type_id;
  STRING3 report_type_id;
  STRING11 report_id;
  STRING9 agency_ori;
  STRING100 vendor_code;
  STRING20 vendor_report_id;
  STRING20 reportlinkid;
  STRING30 vin;
  STRING25 driver_license_nbr;
  STRING2 dlnbr_st;
  STRING10 tag_nbr;
  STRING2 tagnbr_st;
  STRING8 date_vendor_last_reported;
  STRING100 accident_location;
  UNSIGNED6 idfield;
  STRING12 did;
  STRING60 fname;
  STRING60 mname;
  STRING100 lname;
  STRING3 contrib_source;
 END;

EXPORT OFFICERBADGENBR_KEYED_FIELDS := RECORD
    OFFICERBADGENBR.OFFICER_ID;
    OFFICERBADGENBR.JURISDICTION_STATE;
    OFFICERBADGENBR.JURISDICTION;
END;

EXPORT OFFICERBADGENBR_PAYLOAD_FIELDS := RECORD
	  OFFICERBADGENBR AND NOT OFFICERBADGENBR_KEYED_FIELDS;
END;

EXPORT LASTNAME := RECORD
  STRING100 lname;
  STRING2 jurisdiction_state;
  STRING100 jurisdiction;
  STRING40 accident_nbr;
  STRING40 orig_accnbr;
  STRING40 addl_report_number;
  STRING8 accident_date;
  STRING2 report_code;
  STRING11 jurisdiction_nbr;
  STRING4 work_type_id;
  STRING3 report_type_id;
  STRING11 report_id;
  STRING9 agency_ori;
  STRING100 vendor_code;
  STRING20 vendor_report_id;
  STRING20 reportlinkid;
  STRING30 vin;
  STRING25 driver_license_nbr;
  STRING2 dlnbr_st;
  STRING10 tag_nbr;
  STRING2 tagnbr_st;
  STRING12 officer_id;
  STRING8 date_vendor_last_reported;
  STRING100 accident_location;
  UNSIGNED6 idfield;
  STRING12 did;
  STRING60 fname;
  STRING60 mname;
  STRING3 contrib_source;
 END;

EXPORT LASTNAME_KEYED_FIELDS := RECORD
    LASTNAME.LNAME;
    LASTNAME.JURISDICTION_STATE;
    LASTNAME.JURISDICTION;
END;

EXPORT LASTNAME_PAYLOAD_FIELDS := RECORD
	  LASTNAME AND NOT LASTNAME_KEYED_FIELDS;
END;

EXPORT PREFNAME := RECORD
  STRING60 fname;
  STRING2 jurisdiction_state;
  STRING100 jurisdiction;
  STRING40 accident_nbr;
  STRING40 orig_accnbr;
  STRING40 addl_report_number;
  STRING8 accident_date;
  STRING2 report_code;
  STRING11 jurisdiction_nbr;
  STRING4 work_type_id;
  STRING3 report_type_id;
  STRING11 report_id;
  STRING9 agency_ori;
  STRING100 vendor_code;
  STRING20 vendor_report_id;
  STRING20 reportlinkid;
  STRING30 vin;
  STRING25 driver_license_nbr;
  STRING2 dlnbr_st;
  STRING10 tag_nbr;
  STRING2 tagnbr_st;
  STRING12 officer_id;
  STRING8 date_vendor_last_reported;
  STRING100 accident_location;
  UNSIGNED6 idfield;
  STRING12 did;
  STRING60 mname;
  STRING100 lname;
  STRING3 contrib_source;
 END;

EXPORT PREFNAME_KEYED_FIELDS := RECORD
    PREFNAME.FNAME;
    PREFNAME.JURISDICTION_STATE;
    PREFNAME.JURISDICTION;
END;

EXPORT PREFNAME_PAYLOAD_FIELDS := RECORD
	  PREFNAME AND NOT PREFNAME_KEYED_FIELDS;
END;

EXPORT REPORTLINKID := RECORD
  STRING20 reportlinkid;
  STRING40 accident_nbr;
  STRING40 orig_accnbr;
  STRING40 addl_report_number;
  STRING8 accident_date;
  STRING2 report_code;
  STRING100 jurisdiction;
  STRING2 jurisdiction_state;
  STRING11 jurisdiction_nbr;
  STRING4 work_type_id;
  STRING3 report_type_id;
  STRING11 report_id;
  STRING9 agency_ori;
  STRING100 vendor_code;
  STRING20 vendor_report_id;
  STRING30 vin;
  STRING25 driver_license_nbr;
  STRING2 dlnbr_st;
  STRING10 tag_nbr;
  STRING2 tagnbr_st;
  STRING12 officer_id;
  STRING8 date_vendor_last_reported;
  STRING100 accident_location;
  UNSIGNED6 idfield;
  STRING12 did;
  STRING60 fname;
  STRING60 mname;
  STRING100 lname;
  STRING3 contrib_source;
 END;

EXPORT REPORTLINKID_KEYED_FIELDS := RECORD
    REPORTLINKID.REPORTLINKID;
END;

EXPORT REPORTLINKID_PAYLOAD_FIELDS := RECORD
	  REPORTLINKID AND NOT REPORTLINKID_KEYED_FIELDS;
END;

EXPORT STANDLOCATION := RECORD
  STRING100 partial_accident_location;
  STRING2 jurisdiction_state;
  STRING100 jurisdiction;
  STRING40 accident_nbr;
  STRING40 orig_accnbr;
  STRING40 addl_report_number;
  STRING8 accident_date;
  STRING2 report_code;
  STRING11 jurisdiction_nbr;
  STRING4 work_type_id;
  STRING3 report_type_id;
  STRING11 report_id;
  STRING9 agency_ori;
  STRING100 vendor_code;
  STRING20 vendor_report_id;
  STRING20 reportlinkid;
  STRING30 vin;
  STRING25 driver_license_nbr;
  STRING2 dlnbr_st;
  STRING10 tag_nbr;
  STRING2 tagnbr_st;
  STRING12 officer_id;
  STRING8 date_vendor_last_reported;
  STRING100 accident_location;
  UNSIGNED6 idfield;
  STRING12 did;
  STRING60 fname;
  STRING60 mname;
  STRING100 lname;
  STRING3 contrib_source;
END;

EXPORT STANDLOCATION_KEYED_FIELDS := RECORD
    STANDLOCATION.PARTIAL_ACCIDENT_LOCATION;
    STANDLOCATION.JURISDICTION_STATE;
    STANDLOCATION.JURISDICTION;
END;

EXPORT STANDLOCATION_PAYLOAD_FIELDS := RECORD
	  STANDLOCATION AND NOT STANDLOCATION_KEYED_FIELDS;
END;

EXPORT AGENCYID_SENTDATE := RECORD
  STRING11 jurisdiction_nbr;
  STRING3 contrib_source;
  STRING8 maxsent_to_hpcc_date;
END;
 
EXPORT AGENCYID_SENTDATE_KEYED_FIELDS := RECORD
    AGENCYID_SENTDATE.JURISDICTION_NBR;
END;

EXPORT AGENCYID_SENTDATE_PAYLOAD_FIELDS := RECORD
	  AGENCYID_SENTDATE AND NOT AGENCYID_SENTDATE_KEYED_FIELDS;
END;

// ########################################################################### 
//           FL ACCIDENTS PR KEYS
// ##########################################################################
EXPORT ECRASH0 := RECORD
       STRING2    report_code;
       STRING25   report_category;
       STRING65   report_code_desc;
	     STRING1    rec_type_o,
       STRING40   accident_nbr,
       STRING40   l_acc_nbr,
       STRING4    filler1,
       STRING11   microfilm_nbr,
       STRING1    st_road_accident,
       STRING8    accident_date,
       STRING4    city_nbr,
       STRING4    ft_city_town,
       STRING2    miles_city_town,
       STRING1    direction_city_town,
       STRING50   city_town_name,
       STRING50   county_name,
       STRING5    at_node_nbr,
       STRING4    ft_miles_node,
       STRING1    ft_miles_code1,
       STRING5    from_node_nbr,
       STRING5    next_node_rdwy,
       STRING36   st_road_hhwy_name,
       STRING36   at_intersect_of,
       STRING4    ft_miles_from_intersect,
       STRING1    ft_miles_code2,
       STRING1    intersect_dir_of,
       STRING36   of_intersect_of,
       STRING1    codeable_noncodeable,
       STRING1    type_fr_case,
       STRING1    action_code,
       STRING1    filler2,
       STRING1    dot_type_facility,
       STRING1    dot_road_type,
       STRING2    dot_nbr_lanes,
       STRING2    dot_site_loc,
       STRING1    dot_district_ind,
       STRING2    dot_county,
       STRING3    dot_section_nbr,
       STRING2    dot_skid_resistance,
       STRING1    dot_friction_coarse,
       STRING6    dot_avg_daily_traffic,
       STRING5    dot_node_nbr,
       STRING5    dot_distance_node,
       STRING1    dot_dir_from_node,
       STRING6    dot_st_road_nbr,
       STRING5    dot_us_road_nbr,
       STRING6    dot_milepost,
       STRING1    dot_hhwy_loc,
       STRING3    dot_subsection,
       STRING1    dot_system_type,
       STRING1    dot_travelway,
       STRING2    dot_node_type,
       STRING2    dot_fixture_type,
       STRING1    dot_side_of_road,
       STRING1    dot_accident_severity,
       STRING1    dot_lane_id,
       STRING98   filler3,
       STRING1    dhsmv_veh_crash_ind,
       STRING15   acc_key_online_update,
       STRING1    form_type,
       STRING2    update_nbr,
       STRING1    accident_error,
			 STRING40   orig_accnbr, 
       STRING8    filler4
END;

EXPORT ECRASH0_KEYED_FIELDS := RECORD
    ECRASH0.L_ACC_NBR;
END;

EXPORT ECRASH0_PAYLOAD_FIELDS := RECORD
	  ECRASH0 AND NOT ECRASH0_KEYED_FIELDS;
END; 
	
EXPORT ECRASH1 := RECORD
  STRING2   report_code;
  STRING25  report_category;
  STRING65  report_code_desc;
	STRING1   rec_type_1,
	STRING40  accident_nbr,
  STRING40  l_acc_nbr,
	STRING4   filler1,
	STRING1   day_week,
	STRING2   hr_accident,
	STRING2   min_accident,
	STRING2   hr_off_notified,
	STRING2   min_off_notified,
	STRING2   hr_off_arrived,
	STRING2   min_off_arrived,
	STRING4   city_nbr,
	STRING1   pop_code,
	STRING1   rural_urban_code,
	STRING2   site_loc,
	STRING2   first_harmful_event,
	STRING2   subs_harmful_event,
	STRING1   on_off_roadway,
	STRING2   light_condition,
	STRING2   weather,
	STRING2   rd_surface_type,
	STRING2   type_shoulder,
	STRING2   rd_surface_condition,
	STRING2   first_contrib_cause,
	STRING2   second_contrib_cause,
	STRING2   first_contrib_envir,
	STRING2   second_contrib_envir,
	STRING2   first_traffic_control,
	STRING2   second_traffic_control,
	STRING2   trafficway_char,
	STRING2   nbr_lanes,
	STRING1   divided_undivided,
	STRING2   rd_sys_id,
	STRING1   invest_agency,
	STRING1   accident_injury_severity,
	STRING1   accident_damage_severity,
	STRING1   accident_insur_code,
	STRING1   accident_fault_code,
	STRING1   alcohol_drug,
	STRING7   total_tar_damage,
	STRING36   total_vehicle_damage,
	STRING7   total_prop_damage_amt,
	STRING4   total_nbr_persons,
	STRING2   total_nbr_drivers,
	STRING3   total_nbr_vehicles,
	STRING3   total_nbr_fatalities,
	STRING2   total_nbr_non_traffic_fatal,
	STRING3   total_nbr_injuries,
	STRING2   total_nbr_pedestrian,
	STRING2   total_nbr_pedalcyclist,
	STRING15  invest_agy_rpt_nbr,
	STRING100  invest_name,
	STRING16  filler2,
	STRING30   invest_rank,
	STRING6   invest_id_badge_nbr,
	STRING30  dept_name,
	STRING1   invest_maede,
	STRING1   invest_complete,
	STRING8   report_date,
	STRING1   photos_taken,
	STRING1   photos_taken_whom,
	STRING30  first_aid_name,
	STRING16  filler3,
	STRING1   first_aid_person_type,
	STRING41  injured_taken_to,
	STRING25  injured_taken_by,
	STRING1   type_driver_accident,
	STRING2   hr_ems_notified,
	STRING2   min_ems_notified,
	STRING2   hr_ems_arrived,
	STRING2   min_ems_arrived,
	STRING1   injured_taken_to_code,
	STRING1   location_type,
	STRING20   first_aid_person_type_desc,          //STRING1   first_aid_person_type
  STRING40   accident_fault_code_desc ,            //STRING1   accident_fault_code
  STRING40   alcohol_drug_desc  ,               // STRING1  alcohol_drug
  STRING100  accident_damage_severity_desc ,  // STRING1   accident_damage_severity
	STRING100   invest_agency_desc ,           //,	STRING1   invest_agency,
  STRING110  first_harmful_event_desc ,      //STRING2   first_harmful_event
  STRING40   light_condition_desc ,          //STRING2   light_condition
  STRING40   weather_desc   ,               //STRING2  weather
  STRING40   rd_surface_type_desc ,        //, STRING2   rd_surface_type, 
  STRING10   type_shoulder_desc,          //, STRING2   type_shoulder, 
  STRING40   rd_surface_condition_desc ,  //, STRING2   rd_surface_condition, 
  STRING50   first_contrib_cause_desc,   //, STRING2   first_contrib_cause, 
  STRING50   second_contrib_cause_desc,  //, STRING2   second_contrib_cause, 
  STRING40   first_contrib_envir_desc,   // , STRING2   first_contrib_envir, 
  STRING40   second_contrib_envir_desc,  // , STRING2   second_contrib_envir, 
  STRING30   first_traffic_control_desc ,// , STRING2   first_traffic_control, 
  STRING30   second_traffic_control_desc,//, STRING2   second_traffic_control 
	STRING9    day_week_desc;
  STRING30   location_type_desc;
	STRING40  orig_accnbr ; 
	STRING64  filler4,
END;

EXPORT ECRASH1_KEYED_FIELDS := RECORD
    ECRASH1.L_ACC_NBR;
END;

EXPORT ECRASH1_PAYLOAD_FIELDS := RECORD
	  ECRASH1 AND NOT ECRASH1_KEYED_FIELDS;
	END; 

EXPORT ECRASH2V := RECORD
  STRING2 report_code;
  STRING25 report_category;
  STRING65 report_code_desc;
	STRING25 vehicle_incident_city;
	STRING2 vehicle_incident_st;
	STRING40 carrier_name;
	STRING5	client_type_id;
  STRING12 did,
	unsigned1 did_score,
	STRING12 b_did, 
  unsigned1 b_did_score,
	STRING1   rec_type_2,
	STRING40  accident_nbr,
  STRING40   l_acc_nbr,
	STRING2   section_nbr,
	STRING2   filler1,
	STRING1   vehicle_owner_driver_code,
	STRING1   vehicle_driver_action,
	STRING4   vehicle_year,
	STRING4   vehicle_make,
	STRING2   vehicle_type,
	STRING8   vehicle_tag_nbr,
	STRING2   vehicle_reg_state,
	STRING22  vehicle_id_nbr,
	STRING36  vehicle_travel_on,
	STRING1   direction_travel,
	STRING3   est_vehicle_speed,
	STRING2   posted_speed,
	STRING7   est_vehicle_damage,
	STRING1   damage_type,
	STRING41  ins_company_name,
	STRING25  ins_policy_nbr,
	STRING25  vehicle_removed_by,
	STRING1   how_removed_code,
	STRING25  vehicle_owner_name,
	STRING16  filler2,
	STRING1   vehicle_owner_suffix,
	STRING150  vehicle_owner_st_city,
	STRING18  filler3,
	STRING2   vehicle_owner_st,
	STRING9   vehicle_owner_zip,
	STRING1   vehicle_owner_forge_asterisk,
	STRING15  vehicle_owner_dl_nbr,
	STRING8   vehicle_owner_dob,
	STRING1   vehicle_owner_sex,
	STRING1   vehicle_owner_race,
	STRING15  point_of_impact,
	STRING2   vehicle_movement,
	STRING2   vehicle_function,
	STRING1   filler4,
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
	STRING31  filler5,
	STRING10  prim_range,
	STRING2   predir,
	STRING28  prim_name,
	STRING4   addr_suffix,
	STRING2   postdir,
	STRING10  unit_desig,
	STRING8   sec_range,
	STRING25  p_city_name,
	STRING25  v_city_name,
	STRING2   st,
	STRING5   zip,
	STRING4   zip4,
	STRING4   cart,
	STRING1   cr_sort_sz,
	STRING4   lot,
	STRING1   lot_order,
	STRING2   dpbc,
	STRING1   chk_digit,
	STRING2   rec_type,
	STRING2   ace_fips_st,
	STRING3   county,
	STRING10  geo_lat,
	STRING11  geo_long,
	STRING4   msa,
	STRING7   geo_blk,
	STRING1   geo_match,
	STRING4   err_stat,
	STRING5   title,
	STRING20  fname,
	STRING20  mname,
	STRING20  lname,
	STRING5   suffix,
	STRING3   score,
	STRING25  cname,
	STRING4   blank1,
	STRING42  vehicle_seg,
	STRING1   vehicle_seg_type,
	STRING14  match_code,
	STRING4   model_year,
	STRING1   blank2,
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
	STRING20  make_description,
	STRING20  model_description,
	STRING20  series_description,
	STRING2   blank3,
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
	STRING40  orig_accnbr,
	STRING15  direction_travel_desc,
	STRING25  vehicle_type_desc,
	STRING30  point_of_impact_desc, 
	STRING30  vehicle_use_desc,
END;
	
EXPORT ECRASH2V_KEYED_FIELDS := RECORD
    ECRASH2V.L_ACC_NBR;
END;

EXPORT ECRASH2V_PAYLOAD_FIELDS := RECORD
	  ECRASH2V AND NOT ECRASH2V_KEYED_FIELDS;
	END;
	
EXPORT ECRASH3V := RECORD
  STRING2 report_code;
  STRING25 report_category;
  STRING65 report_code_desc;
  STRING1    rec_type_3,
	STRING40   accident_nbr,
  STRING40   l_acc_nbr,
	STRING2    section_nbr,
	STRING2    filler1,
	STRING4    towed_trlr_veh_yr,
	STRING4    towed_trlr_make,
	STRING2    towed_trailer_type,
	STRING8    towed_trlr_veh_tag_nbr,
	STRING2    towed_trlr_veh_state,
	STRING22   towed_trlr_veh_id_nbr,
	STRING7    towed_trlr_veh_est_damage,
	STRING25   towed_trlr_veh_owner_name,
	STRING16   filler2,
	STRING1    towed_trlr_veh_owner_name_suffix,
	STRING40   towed_trlr_veh_owner_st_city,
	STRING18   filler3,
	STRING2    towed_trlr_veh_owner_st,
	STRING9    towed_trlr_veh_owner_zip,
	STRING2    towed_trlr_fr_cap_code,
	STRING224  filler4,
	STRING4    blank1,
	STRING42   vehicle_seg,
	STRING1    vehicle_seg_type,
	STRING14   match_code,
	STRING4    model_year,
	STRING1    blank2,
	STRING3    manufacturer_corporation,
	STRING1    division_code,
	STRING2    vehicle_group_code,
	STRING2    vehicle_subgroup_code,
	STRING2    vehicle_series_code,
	STRING2    body_style_code,
	STRING3    vehicle_abbreviation,
	STRING1    assembly_country,
	STRING1    headquarter_country,
	STRING1    number_of_doors,
	STRING1    seating_capacity,
	STRING2    number_of_cylinders,
	STRING4    engine_size,
	STRING1    fuel_code,
	STRING1    carburetion_type,
	STRING1    number_of_barrels,
	STRING1    price_class_code,
	STRING2    body_size_code,
	STRING1    number_of_wheels_on_road,
	STRING1    number_of_driving_wheels,
	STRING1    drive_type,
	STRING1    steering_type,
	STRING1    gvw_code,
	STRING1    load_capacity_code,
	STRING1    cab_type_code,
	STRING2    bed_length,
	STRING1    rim_size,
	STRING5    manufacture_body_style,
	STRING1    vehicle_type_code,
	STRING3    car_line_code,
	STRING1    car_series_code,
	STRING1    car_body_style_code,
	STRING1    engine_cylinder_code,
	STRING3    truck_make_abbreviation,
	STRING3    truck_body_style_abbreviation,
	STRING3    motorcycle_make_abbreviation,
	STRING3    vina_series,
	STRING3    vina_model,
	STRING5    reference_number,
	STRING3    vina_make,
	STRING2    vina_body_style,
	STRING20   make_description,
	STRING20   model_description,
	STRING20   series_description,
	STRING2    blank3,
	STRING3    car_series,
	STRING2    car_body_style,
	STRING3    car_cid,
	STRING2    car_cylinders,
	STRING1    car_carburetion,
	STRING1    car_fuel_code,
	STRING2    truck_chassis_body_style,
	STRING2    truck_wheels_driving_wheels,
	STRING4    truck_cid,
	STRING2    truck_cylinders,
	STRING1    truck_fuel_code,
	STRING1    truck_manufacturers_gvw_code,
	STRING2    truck_ton_rating_code,
	STRING3    truck_series,
	STRING3    truck_model,
	STRING3    motorcycle_model,
	STRING4    motorcycle_engine_displacement,
	STRING2    motorcycle_type_of_bike,
	STRING2    motorcycle_cylinder_coding,
	STRING40   orig_accnbr; 
END;

EXPORT ECRASH3V_KEYED_FIELDS := RECORD
    ECRASH3V.L_ACC_NBR;
END;

EXPORT ECRASH3V_PAYLOAD_FIELDS := RECORD
	  ECRASH3V AND NOT ECRASH3V_KEYED_FIELDS;
	END;
	
EXPORT ECRASH4 := RECORD
  STRING2 report_code;
  STRING25 report_category;
  STRING65 report_code_desc;
	STRING22  vehicle_id_nbr,
	STRING4   vehicle_year,
	STRING4   vehicle_make,
	STRING20  make_description,
	STRING20  model_description,
	STRING25 vehicle_incident_city;
	STRING2 vehicle_incident_st;
	STRING15  point_of_impact,
	STRING40 carrier_name;
	STRING5	client_type_id;
 	STRING12 did,
	unsigned1 did_score,
	STRING1   rec_type_4,
	STRING40  accident_nbr,
  STRING40   l_acc_nbr,
	STRING2   section_nbr,
	STRING2   filler1,
	STRING25  driver_full_name,
	STRING16  filler2, 
	STRING1   driver_name_suffix,
	STRING150  driver_st_city,
	STRING18  filler3,
	STRING2   driver_resident_state,
	STRING9   driver_zip,
	STRING8   driver_dob,
	STRING1   driver_dl_force_asterisk,
	STRING15  driver_dl_nbr,
	STRING2   driver_lic_st,
	STRING1   driver_lic_type,
	STRING1   driver_bac_test_type,
	STRING1   driver_bac_force_code,
	STRING2   driver_bac_test_results,
	STRING2   filler4,
	STRING1   driver_alco_drug_code,
	STRING1   driver_physical_defects,
	STRING1   driver_residence,
	STRING1   driver_race,
	STRING1   driver_sex,
	STRING1   driver_injury_severity,
	STRING1   first_driver_safety,
	STRING1   second_driver_safety,
	STRING1   driver_eject_code,
	STRING1   recommand_reexam,
	STRING10  driver_phone_nbr,
	STRING2   first_contrib_cause,
	STRING2   second_contrib_cause,
	STRING2   third_contrib_cause,
	STRING8   first_offense_charged,
	STRING2   first_frdl_sys_charge_code,
	STRING8   second_offense_charged,
	STRING2   second_frdl_sys_charge_code,
	STRING8   third_offense_charged,
	STRING2   third_frdl_sys_charge_code,
	STRING7   first_citation_nbr,
	STRING7   second_citation_nbr,
	STRING7   third_citation_nbr,
	STRING2   driver_fr_injury_cap_code,
	STRING1   dl_nbr_good_bad,
	STRING8   fourth_offense_charged,
	STRING2   fourth_frdl_sys_charge_code,
	STRING8   fifth_offense_charged,
	STRING2   fifth_frdl_sys_charge_code,
	STRING8   sixth_offense_charged,
	STRING2   sixth_frdl_sys_charge_code,
	STRING8   seveth_offense_charged,
	STRING2   seveth_frdl_sys_charge_code,
	STRING8   eighth_offense_charged,
	STRING2   eighth_frdl_sys_charge_code,
	STRING7   fourth_citation_nbr,
	STRING7   fifth_citation_nbr,
	STRING7   sixth_citation_nbr,
	STRING7   seventh_citation_nbr,
	STRING7   eighth_citation_nbr,
	STRING1   req_ENDorsement,
	STRING25  oos_dl_nbr,
	STRING51  filler5,//claim_nbr
	STRING10  prim_range,
	STRING2   predir,
	STRING28  prim_name,
	STRING4   addr_suffix,
	STRING2   postdir,
	STRING10  unit_desig,
	STRING8   sec_range,
	STRING25  p_city_name,
	STRING25  v_city_name,
	STRING2   st,
	STRING5   zip,
	STRING4   zip4,
	STRING4   cart,
	STRING1   cr_sort_sz,
	STRING4   lot,
	STRING1   lot_order,
	STRING2   dpbc,
	STRING1   chk_digit,
	STRING2   rec_type,
	STRING2   ace_fips_st,
	STRING3   county,
	STRING10  geo_lat,
	STRING11  geo_long,
	STRING4   msa,
	STRING7   geo_blk,
	STRING1   geo_match,
	STRING4   err_stat,
	STRING5   title,
	STRING20  fname,
	STRING20  mname,
	STRING20  lname,
	STRING5   suffix,
	STRING3   score,
	STRING25  cname,
	STRING40  orig_accnbr, 
	STRING25 driver_race_desc,
  STRING8 driver_sex_desc,
  STRING40 driver_residence_desc ,
	STRING41  ins_company_name:= '';	
	STRING25  ins_policy_nbr:='';	
/*STRING30 Policy_num;	   
  STRING8 Policy_Effective_Date;	   
	STRING8 Policy_Expiration_Date;	
	STRING9 inquiry_ssn,
	STRING8 inquiry_dob,
	STRING20 inquiry_mname,
	STRING5 inquiry_zip5,
	STRING4 inquiry_zip4*/
END;
	
EXPORT ECRASH4_KEYED_FIELDS := RECORD
    ECRASH4.L_ACC_NBR;
END;

EXPORT ECRASH4_PAYLOAD_FIELDS := RECORD
	  ECRASH4 AND NOT ECRASH4_KEYED_FIELDS;
	END;
	
EXPORT ECRASH5 := RECORD
  STRING2 report_code;
  STRING25 report_category;
  STRING65 report_code_desc;
 	STRING12 did,
	unsigned1 did_score,
	STRING1   rec_type_5,
	STRING40  accident_nbr,
  STRING40   l_acc_nbr,
	STRING2   section_nbr,
	STRING2   passenger_nbr,
	STRING25  passenger_full_name,
	STRING16  filler1,
	STRING1   passenger_name_suffix,
	STRING150  passenger_st_city,
	STRING18  filler2,
	STRING2   passenger_state,
	STRING9   passenger_zip,
	STRING2   passenger_age,
	STRING1   passenger_location,
	STRING1   passenger_injury_sev,
	STRING1   first_passenger_safe,
	STRING1   second_passenger_safe,
	STRING1   passenger_eject_code,
	STRING2   passenger_fr_cap_code,
	STRING266 filler3,
	STRING10  prim_range,
	STRING2   predir,
	STRING28  prim_name,
	STRING4   addr_suffix,
	STRING2   postdir,
	STRING10  unit_desig,
	STRING8   sec_range,
	STRING25  p_city_name,
	STRING25  v_city_name,
	STRING2   st,
	STRING5   zip,
	STRING4   zip4,
	STRING4   cart,
	STRING1   cr_sort_sz,
	STRING4   lot,
	STRING1   lot_order,
	STRING2   dpbc,
	STRING1   chk_digit,
	STRING2   rec_type,
	STRING2   ace_fips_st,
	STRING3   county,
	STRING10  geo_lat,
	STRING11  geo_long,
	STRING4   msa,
	STRING7   geo_blk,
	STRING1   geo_match,
	STRING4   err_stat,
	STRING5   title,
	STRING20  fname,
	STRING20  mname,
	STRING20  lname,
	STRING5   suffix,
	STRING3   score,
	STRING25  cname,
	STRING40 orig_accnbr, 
END;

EXPORT ECRASH5_KEYED_FIELDS := RECORD
    ECRASH5.L_ACC_NBR;
END;

EXPORT ECRASH5_PAYLOAD_FIELDS := RECORD
	  ECRASH5 AND NOT ECRASH5_KEYED_FIELDS;
	END;
	
EXPORT ECRASH6 := RECORD
  STRING2 report_code;
  STRING25 report_category;
  STRING65 report_code_desc;
	STRING12 did,
	unsigned1 did_score,
	STRING1   rec_type_6,
	STRING40  accident_nbr,
  STRING40   l_acc_nbr,
	STRING2   section_nbr,
	STRING2   filler1,
	STRING25  pedest_full_name,
	STRING16  filler2,
	STRING1   ped_name_suffix,
	STRING150  ped_st_city,
	STRING18  filler3,
	STRING2   ped_state,
	STRING9   ped_zip,
	STRING8   ded_dob,
	STRING1   ped_bac_test_type,
	STRING1   ped_bac_force_code,
	STRING2   ped_bac_results,
	STRING2   filler4,
	STRING1   ped_alco_drugs,
	STRING1   ped_physical_defect,
	STRING1   ped_residence,
	STRING1   ped_race,
	STRING1   ped_sex,
	STRING1   ped_injury_sev,
	STRING2   ped_first_contrib_cause,
	STRING2   ped_second_contrib_cause,
	STRING2   ped_third_contrib_cause,
	STRING2   ped_action,
	STRING8   first_offense_charged,
	STRING2   first_frdl_sys_charge_code,
	STRING8   second_offense_charged,
	STRING2   second_frdl_sys_charge_code,
	STRING8   third_offense_charged,
	STRING2   third_frdl_sys_charge_code,
	STRING7   first_citation_nbr,
	STRING7   second_citation_nbr,
	STRING7   third_citation_nbr,
	STRING2   ped_fr_injury_cap,
	STRING8   fourth_offense_charged,
	STRING2   fourth_frdl_sys_charge_code,
	STRING8   fifth_offense_charged,
	STRING2   fifth_frdl_sys_charge_code,
	STRING8   sixth_offense_charged,
	STRING2   sixth_sys_charge_code,
	STRING8   seventh_offense_charged,
	STRING2   seventh_sys_charge_code,
	STRING8   eighth_offense_charged,
	STRING2   eighth_sys_charge_code,
	STRING7   fourth_citation_issued,
	STRING7   fifth_citation_issued,
	STRING7   sixth_citation_issued,
	STRING7   seventh_citation_issued,
	STRING7   eighth_citation_issued,
	STRING15  ped_dl_nbr,
	STRING94  filler5,
	STRING10  prim_range,
	STRING2   predir,
	STRING28  prim_name,
	STRING4   addr_suffix,
	STRING2   postdir,
	STRING10  unit_desig,
	STRING8   sec_range,
	STRING25  p_city_name,
	STRING25  v_city_name,
	STRING2   st,
	STRING5   zip,
	STRING4   zip4,
	STRING4   cart,
	STRING1   cr_sort_sz,
	STRING4   lot,
	STRING1   lot_order,
	STRING2   dpbc,
	STRING1   chk_digit,
	STRING2   rec_type,
	STRING2   ace_fips_st,
	STRING3   county,
	STRING10  geo_lat,
	STRING11  geo_long,
	STRING4   msa,
	STRING7   geo_blk,
	STRING1   geo_match,
	STRING4   err_stat,
	STRING5   title,
	STRING20  fname,
	STRING20  mname,
	STRING20  lname,
	STRING5   suffix,
	STRING3   score,
	STRING25  cname,
	STRING40 orig_accnbr,
	STRING25 ped_race_desc,
  STRING8 ped_sex_desc,
END;
	
EXPORT ECRASH6_KEYED_FIELDS := RECORD
    ECRASH6.L_ACC_NBR;
END;

EXPORT ECRASH6_PAYLOAD_FIELDS := RECORD
	  ECRASH6 AND NOT ECRASH6_KEYED_FIELDS;
	END;
	
EXPORT ECRASH7 := RECORD
  STRING2 report_code;
  STRING25 report_category;
  STRING65 report_code_desc;
	STRING12  did,
	unsigned1 did_score,
	STRING12  b_did, 
  unsigned1 b_did_score,
	STRING1   rec_type_7,
	STRING40  accident_nbr,
  STRING40   l_acc_nbr,
	STRING2   prop_damage_code,
	STRING2   prop_damage_nbr,
	STRING25  prop_damaged,
	STRING7   prop_damage_amount,
	STRING25  prop_owner_name,
	STRING16  filler1,
	STRING1   prop_owner_suffix,
	STRING150  prop_owner_st_city,
	STRING18  filler2,
	STRING2   prop_owner_state,
	STRING9   prop_owner_zip,
	STRING2   fr_fixed_object_cap_code,
	STRING241 filler3,
	STRING10  prim_range,
	STRING2   predir,
	STRING28  prim_name,
	STRING4   addr_suffix,
	STRING2   postdir,
	STRING10  unit_desig,
	STRING8   sec_range,
	STRING25  p_city_name,
	STRING25  v_city_name,
	STRING2   st,
	STRING5   zip,
	STRING4   zip4,
	STRING4   cart,
	STRING1   cr_sort_sz,
	STRING4   lot,
	STRING1   lot_order,
	STRING2   dpbc,
	STRING1   chk_digit,
	STRING2   rec_type,
	STRING2   ace_fips_st,
	STRING3   county,
	STRING10  geo_lat,
	STRING11  geo_long,
	STRING4   msa,
	STRING7   geo_blk,
	STRING1   geo_match,
	STRING4   err_stat,
	STRING5   title,
	STRING20  fname,
	STRING20  mname,
	STRING20  lname,
	STRING5   suffix,
	STRING3   score,
	STRING25  cname,
	STRING40 orig_accnbr, 
END;	

EXPORT ECRASH7_KEYED_FIELDS := RECORD
    ECRASH7.L_ACC_NBR;
END;

EXPORT ECRASH7_PAYLOAD_FIELDS := RECORD
	  ECRASH7 AND NOT ECRASH7_KEYED_FIELDS;
END;
	
// ########################################################################### 
//           ECRASH PR KEYS
// ##########################################################################

EXPORT ACCNBR := RECORD
  STRING40 l_accnbr;
  STRING2 report_code;
  STRING2 jurisdiction_state;
  STRING100 jurisdiction;
  STRING40 orig_accnbr;
  STRING11 vehicle_incident_id;
  STRING1 vehicle_status;
  STRING8 dt_first_seen;
  STRING8 dt_last_seen;
  STRING8 accident_date;
  STRING12 did;
  STRING5 title;
  STRING20 fname;
  STRING20 mname;
  STRING20 lname;
  STRING5 name_suffix;
  STRING8 dob;
  STRING12 b_did;
  STRING25 cname;
  STRING10 prim_range;
  STRING2 predir;
  STRING28 prim_name;
  STRING4 addr_suffix;
  STRING2 postdir;
  STRING10 unit_desig;
  STRING8 sec_range;
  STRING25 v_city_name;
  STRING2 st;
  STRING5 zip;
  STRING4 zip4;
  STRING100 record_type;
  STRING65 report_code_desc;
  STRING25 report_category;
  STRING30 vin;
  STRING25 driver_license_nbr;
  STRING2 dlnbr_st;
  STRING10 tag_nbr;
  STRING2 tagnbr_st;
  STRING100 accident_location;
  STRING100 accident_street;
  STRING100 accident_cross_street;
  STRING60 next_street;
  STRING11 jurisdiction_nbr;
  STRING64 image_hash;
  STRING1 airbags_deploy;
  STRING50 policy_num;
  STRING8 policy_effective_date;
  STRING8 policy_expiration_date;
  STRING4 report_has_coversheet;
  STRING1 other_vin_indicator;
  STRING7 vehicle_unit_number;
  STRING50 vehicle_incident_city;
  STRING2 vehicle_incident_st;
  STRING100 carrier_name;
  STRING5 client_type_id;
  STRING4 towed;
  STRING80 impact_location;
  STRING1 vehicle_owner_driver_code;
  STRING1 vehicle_driver_action;
  STRING4 vehicle_year;
  STRING100 vehicle_make;
  STRING2 vehicle_type;
  STRING36 vehicle_travel_on;
  STRING1 direction_travel;
  STRING3 est_vehicle_speed;
  STRING2 posted_speed;
  STRING7 est_vehicle_damage;
  STRING1 damage_type;
  STRING25 vehicle_removed_by;
  STRING1 how_removed_code;
  STRING15 point_of_impact;
  STRING2 vehicle_movement;
  STRING2 vehicle_function;
  STRING2 vehs_first_defect;
  STRING2 vehs_second_defect;
  STRING2 vehicle_modified;
  STRING2 vehicle_roadway_loc;
  STRING1 hazard_material_transport;
  STRING3 total_occu_vehicle;
  STRING3 total_occu_saf_equip;
  STRING1 moving_violation;
  STRING1 vehicle_insur_code;
  STRING1 vehicle_fault_code;
  STRING2 vehicle_cap_code;
  STRING1 vehicle_fr_code;
  STRING2 vehicle_use;
  STRING1 placarded;
  STRING1 dhsmv_vehicle_ind;
  STRING42 vehicle_seg;
  STRING1 vehicle_seg_type;
  STRING14 match_code;
  STRING4 model_year;
  STRING3 manufacturer_corporation;
  STRING1 division_code;
  STRING2 vehicle_group_code;
  STRING2 vehicle_subgroup_code;
  STRING2 vehicle_series_code;
  STRING2 body_style_code;
  STRING3 vehicle_abbreviation;
  STRING1 assembly_country;
  STRING1 headquarter_country;
  STRING1 number_of_doors;
  STRING1 seating_capacity;
  STRING2 number_of_cylinders;
  STRING4 engine_size;
  STRING1 fuel_code;
  STRING1 carburetion_type;
  STRING1 number_of_barrels;
  STRING1 price_class_code;
  STRING2 body_size_code;
  STRING1 number_of_wheels_on_road;
  STRING1 number_of_driving_wheels;
  STRING1 drive_type;
  STRING1 steering_type;
  STRING1 gvw_code;
  STRING1 load_capacity_code;
  STRING1 cab_type_code;
  STRING2 bed_length;
  STRING1 rim_size;
  STRING5 manufacture_body_style;
  STRING1 vehicle_type_code;
  STRING3 car_line_code;
  STRING1 car_series_code;
  STRING1 car_body_style_code;
  STRING1 engine_cylinder_code;
  STRING3 truck_make_abbreviation;
  STRING3 truck_body_style_abbreviation;
  STRING3 motorcycle_make_abbreviation;
  STRING3 vina_series;
  STRING3 vina_model;
  STRING5 reference_number;
  STRING3 vina_make;
  STRING2 vina_body_style;
  STRING100 make_description;
  STRING100 model_description;
  STRING20 series_description;
  STRING3 car_series;
  STRING2 car_body_style;
  STRING3 car_cid;
  STRING2 car_cylinders;
  STRING1 car_carburetion;
  STRING1 car_fuel_code;
  STRING2 truck_chassis_body_style;
  STRING2 truck_wheels_driving_wheels;
  STRING4 truck_cid;
  STRING2 truck_cylinders;
  STRING1 truck_fuel_code;
  STRING1 truck_manufacturers_gvw_code;
  STRING2 truck_ton_rating_code;
  STRING3 truck_series;
  STRING3 truck_model;
  STRING3 motorcycle_model;
  STRING4 motorcycle_engine_displacement;
  STRING2 motorcycle_type_of_bike;
  STRING2 motorcycle_cylinder_coding;
  STRING40 addl_report_number;
  STRING9 agency_ori;
  STRING100 insurance_company_standardized;
  STRING1 is_available_for_public;
  STRING20 report_status;
  STRING4 work_type_id;
  STRING60 orig_fname;
  STRING100 orig_lname;
  STRING60 orig_mname;
  STRING150 orig_full_name;
  STRING11 ssn;
  STRING12 cru_order_id;
  STRING2 cru_sequence_nbr;
  STRING8 date_vendor_last_reported;
  STRING3 report_type_id;
END;

EXPORT ACCNBR_KEYED_FIELDS := RECORD
    ACCNBR.L_ACCNBR;
    ACCNBR.REPORT_CODE;
    ACCNBR.JURISDICTION_STATE;
    ACCNBR.JURISDICTION;
END;

EXPORT ACCNBR_PAYLOAD_FIELDS := RECORD
	  ACCNBR AND NOT ACCNBR_KEYED_FIELDS;
	END;
	
EXPORT ACCNBRV1 := RECORD
  STRING40 l_accnbr;
  STRING2 report_code;
  STRING2 jurisdiction_state;
  STRING100 jurisdiction;
  STRING40 orig_accnbr;
  STRING11 vehicle_incident_id;
  STRING1 vehicle_status;
  STRING8 dt_first_seen;
  STRING8 dt_last_seen;
  STRING8 accident_date;
  STRING12 did;
  STRING5 title;
  STRING20 fname;
  STRING20 mname;
  STRING20 lname;
  STRING5 name_suffix;
  STRING8 dob;
  STRING12 b_did;
  STRING25 cname;
  STRING10 prim_range;
  STRING2 predir;
  STRING28 prim_name;
  STRING4 addr_suffix;
  STRING2 postdir;
  STRING10 unit_desig;
  STRING8 sec_range;
  STRING25 v_city_name;
  STRING2 st;
  STRING5 zip;
  STRING4 zip4;
  STRING100 record_type;
  STRING65 report_code_desc;
  STRING25 report_category;
  STRING30 vin;
  STRING25 driver_license_nbr;
  STRING2 dlnbr_st;
  STRING10 tag_nbr;
  STRING2 tagnbr_st;
  STRING100 accident_location;
  STRING100 accident_street;
  STRING100 accident_cross_street;
  STRING60 next_street;
  STRING11 jurisdiction_nbr;
  STRING64 image_hash;
  STRING1 airbags_deploy;
  STRING50 policy_num;
  STRING8 policy_effective_date;
  STRING8 policy_expiration_date;
  STRING4 report_has_coversheet;
  STRING1 other_vin_indicator;
  STRING7 vehicle_unit_number;
  STRING50 vehicle_incident_city;
  STRING2 vehicle_incident_st;
  STRING100 carrier_name;
  STRING5 client_type_id;
  STRING4 towed;
  STRING80 impact_location;
  STRING1 vehicle_owner_driver_code;
  STRING1 vehicle_driver_action;
  STRING4 vehicle_year;
  STRING100 vehicle_make;
  STRING2 vehicle_type;
  STRING36 vehicle_travel_on;
  STRING1 direction_travel;
  STRING3 est_vehicle_speed;
  STRING2 posted_speed;
  STRING7 est_vehicle_damage;
  STRING1 damage_type;
  STRING25 vehicle_removed_by;
  STRING1 how_removed_code;
  STRING15 point_of_impact;
  STRING2 vehicle_movement;
  STRING2 vehicle_function;
  STRING2 vehs_first_defect;
  STRING2 vehs_second_defect;
  STRING2 vehicle_modified;
  STRING2 vehicle_roadway_loc;
  STRING1 hazard_material_transport;
  STRING3 total_occu_vehicle;
  STRING3 total_occu_saf_equip;
  STRING1 moving_violation;
  STRING1 vehicle_insur_code;
  STRING1 vehicle_fault_code;
  STRING2 vehicle_cap_code;
  STRING1 vehicle_fr_code;
  STRING2 vehicle_use;
  STRING1 placarded;
  STRING1 dhsmv_vehicle_ind;
  STRING42 vehicle_seg;
  STRING1 vehicle_seg_type;
  STRING14 match_code;
  STRING4 model_year;
  STRING3 manufacturer_corporation;
  STRING1 division_code;
  STRING2 vehicle_group_code;
  STRING2 vehicle_subgroup_code;
  STRING2 vehicle_series_code;
  STRING2 body_style_code;
  STRING3 vehicle_abbreviation;
  STRING1 assembly_country;
  STRING1 headquarter_country;
  STRING1 number_of_doors;
  STRING1 seating_capacity;
  STRING2 number_of_cylinders;
  STRING4 engine_size;
  STRING1 fuel_code;
  STRING1 carburetion_type;
  STRING1 number_of_barrels;
  STRING1 price_class_code;
  STRING2 body_size_code;
  STRING1 number_of_wheels_on_road;
  STRING1 number_of_driving_wheels;
  STRING1 drive_type;
  STRING1 steering_type;
  STRING1 gvw_code;
  STRING1 load_capacity_code;
  STRING1 cab_type_code;
  STRING2 bed_length;
  STRING1 rim_size;
  STRING5 manufacture_body_style;
  STRING1 vehicle_type_code;
  STRING3 car_line_code;
  STRING1 car_series_code;
  STRING1 car_body_style_code;
  STRING1 engine_cylinder_code;
  STRING3 truck_make_abbreviation;
  STRING3 truck_body_style_abbreviation;
  STRING3 motorcycle_make_abbreviation;
  STRING3 vina_series;
  STRING3 vina_model;
  STRING5 reference_number;
  STRING3 vina_make;
  STRING2 vina_body_style;
  STRING100 make_description;
  STRING100 model_description;
  STRING20 series_description;
  STRING3 car_series;
  STRING2 car_body_style;
  STRING3 car_cid;
  STRING2 car_cylinders;
  STRING1 car_carburetion;
  STRING1 car_fuel_code;
  STRING2 truck_chassis_body_style;
  STRING2 truck_wheels_driving_wheels;
  STRING4 truck_cid;
  STRING2 truck_cylinders;
  STRING1 truck_fuel_code;
  STRING1 truck_manufacturers_gvw_code;
  STRING2 truck_ton_rating_code;
  STRING3 truck_series;
  STRING3 truck_model;
  STRING3 motorcycle_model;
  STRING4 motorcycle_engine_displacement;
  STRING2 motorcycle_type_of_bike;
  STRING2 motorcycle_cylinder_coding;
  STRING40 addl_report_number;
  STRING9 agency_ori;
  STRING100 insurance_company_standardized;
  STRING1 is_available_for_public;
  STRING20 report_status;
  STRING4 work_type_id;
  STRING60 orig_fname;
  STRING100 orig_lname;
  STRING60 orig_mname;
  STRING150 orig_full_name;
  STRING11 ssn;
  STRING12 cru_order_id;
  STRING2 cru_sequence_nbr;
  STRING8 date_vendor_last_reported;
  STRING3 report_type_id;
  STRING70 tif_image_hash;
  STRING11 super_report_id;
  STRING11 report_id;
  STRING100 vendor_code;
  STRING20 vendor_report_id;
  unsigned6 idfield;
  STRING20 reportlinkid;
  STRING3 page_count;
  STRING3 contrib_source;
  STRING8 creation_date;
  STRING12 officer_id;
  STRING1 releasable;
  STRING10 date_report_submitted;
 END;

EXPORT ACCNBRV1_KEYED_FIELDS := RECORD
    ACCNBRV1.L_ACCNBR;
    ACCNBRV1.REPORT_CODE;
    ACCNBRV1.JURISDICTION_STATE;
    ACCNBRV1.JURISDICTION;
END;

EXPORT ACCNBRV1_PAYLOAD_FIELDS := RECORD
	  ACCNBRV1 AND NOT ACCNBRV1_KEYED_FIELDS;
	END;
	
EXPORT PARTIAL_ACCNBR := RECORD
  STRING4 partial_report_nbr;
  STRING2 report_code;
  STRING2 jurisdiction_state;
  STRING100 jurisdiction;
  STRING8 accident_date;
  STRING40 l_accnbr;
  STRING40 orig_accnbr;
  STRING40 addl_report_number;
  STRING3 report_type_id;
  STRING4 work_type_id;
  STRING100 vendor_code;
  STRING20 vendor_report_id;
  UNSIGNED8 idfield;
  STRING20 reportlinkid;
 END;

EXPORT PARTIAL_ACCNBR_KEYED_FIELDS := RECORD
    PARTIAL_ACCNBR.PARTIAL_REPORT_NBR;
    PARTIAL_ACCNBR.REPORT_CODE;
    PARTIAL_ACCNBR.JURISDICTION_STATE;
    PARTIAL_ACCNBR.JURISDICTION;
    PARTIAL_ACCNBR.ACCIDENT_DATE;
END;

EXPORT PARTIAL_ACCNBR_PAYLOAD_FIELDS := RECORD
	  PARTIAL_ACCNBR AND NOT PARTIAL_ACCNBR_KEYED_FIELDS;
END;
	
EXPORT BDID := RECORD
  UNSIGNED6 l_bdid;
  STRING40 accident_nbr;
  STRING40 orig_accnbr;
END;

EXPORT BDID_KEYED_FIELDS := RECORD
    BDID.L_BDID;
END;

EXPORT BDID_PAYLOAD_FIELDS := RECORD
	  BDID AND NOT BDID_KEYED_FIELDS;
	END;

EXPORT DID := RECORD
  UNSIGNED6 l_did;
  STRING40 accident_nbr;
  STRING30 vin;
  STRING40 orig_accnbr;
  STRING4 report_code;
  STRING100 jurisdiction;
  STRING2 jurisdiction_state;
  STRING11 jurisdiction_nbr;
  STRING2 vehicle_incident_st;
 END;
 
EXPORT DID_KEYED_FIELDS := RECORD
    DID.L_DID;
END;

EXPORT DID_PAYLOAD_FIELDS := RECORD
	  DID AND NOT DID_KEYED_FIELDS;
END;

EXPORT DLNBR := RECORD
  STRING25 l_dlnbr;
  STRING40 accident_nbr;
  STRING40 orig_accnbr;
END;

EXPORT DLNBR_KEYED_FIELDS := RECORD
    DLNBR.L_DLNBR;
END;

EXPORT DLNBR_PAYLOAD_FIELDS := RECORD
	  DLNBR AND NOT DLNBR_KEYED_FIELDS;
END;
 
EXPORT TAGNBR := RECORD
  STRING10 l_tagnbr;
  STRING40 accident_nbr;
  STRING40 orig_accnbr;
END;
 
EXPORT TAGNBR_KEYED_FIELDS := RECORD
    TAGNBR.L_TAGNBR;
END;

EXPORT TAGNBR_PAYLOAD_FIELDS := RECORD
	  TAGNBR AND NOT TAGNBR_KEYED_FIELDS;
END;

EXPORT VIN := RECORD
  STRING30 l_vin;
  STRING40 accident_nbr;
  STRING40 orig_accnbr;
  STRING4 report_code;
  STRING100 jurisdiction;
  STRING2 jurisdiction_state;
  STRING11 jurisdiction_nbr;
  STRING2 vehicle_incident_st;
END;

EXPORT VIN_KEYED_FIELDS := RECORD
    VIN.L_VIN;
END;

EXPORT VIN_PAYLOAD_FIELDS := RECORD
	  VIN AND NOT VIN_KEYED_FIELDS;
END;

EXPORT VIN7 := RECORD
  STRING7 l_vin7;
  STRING30 l_vin;
  STRING40 accident_nbr;
  STRING40 orig_accnbr;
END;

EXPORT VIN7_KEYED_FIELDS := RECORD
    VIN7.L_VIN7;
END;

EXPORT VIN7_PAYLOAD_FIELDS := RECORD
	  VIN7 AND NOT VIN7_KEYED_FIELDS;
END;

// ########################################################################### 
//           ECRASH ANALYTICS KEYS
// ##########################################################################

EXPORT AUTOKEY_PAYLOAD := RECORD
  STRING8 dt_first_seen;
  STRING8 dt_last_seen;
  STRING40 accident_nbr;
  STRING40 orig_accnbr;
  UNSIGNED6 did;
  STRING20 fname;
  STRING20 mname;
  STRING20 lname;
  STRING28 prim_name ;
  STRING10 prim_range ;
  STRING8 sec_range ;
  STRING25 v_city_name ;
  STRING2 st ;
  STRING5 zip5;
  UNSIGNED6 b_did;
  STRING25 b_name;
  STRING28 b_prim_name ;
  STRING10 b_prim_range ;
  STRING8 b_sec_range ;
  STRING25 b_v_city_name ;
  STRING2 b_st ;
  STRING5 b_zip5 ;
  UNSIGNED1 zero := 0;
  STRING1 blank := '';
END;

END;