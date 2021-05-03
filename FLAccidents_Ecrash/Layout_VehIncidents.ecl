EXPORT Layout_VehIncidents := MODULE

	EXPORT SlimIncidents := record
	 STRING40		accident_nbr;
	 STRING14 		vehicle_incident_id;
	 STRING8 		Sent_to_HPCC_DateTime;
	 STRING11 		agency_id;
	 //PR Recon COPPR-49
	 BOOLEAN is_Terminated_Agency;
	 STRING4 		report_code;
	 STRING11 		Report_ID;
	 STRING4 		jurisdiction_state;
	 STRING100 	jurisdiction;
	 STRING8 		accident_date;
	 STRING4 		report_type_id;
	 STRING4 		Work_Type_ID;
	 STRING9 		CRU_Order_ID;
	 STRING14 		vehicle_incident_id_latest;
	 STRING11 		jurisdiction_nbr;
	 STRING9 		ORI_Number;
	 STRING50 		Crash_City;
	 STRING100 	Loss_Street;
	 STRING100 	Loss_Cross_Street;
	END;
	
	EXPORT enum_code_desc := RECORD
   STRING65 code;
   STRING150 description;
  END;
	
	EXPORT Citations_ChildRec := RECORD
		STRING7 Citation_Issued;
		STRING7 Citation_Type;
		STRING200 Citation_Detail1; 
		STRING64 Citation_Status;
		STRING60 Violation_Code1;
		STRING60 Violation_Code2;
		STRING60 Violation_Code3;
		STRING60 Violation_Code4;
	END;

	EXPORT MeowLayout := RECORD
		UNSIGNED6 	idfield;
		UNSIGNED6 	rid;
		STRING4				report_code;
		STRING14 			vehicle_incident_id;
		STRING1 			vehicle_status;
		STRING100 		accident_street;
		STRING100 		accident_cross_street;
		STRING100 		orig_jurisdiction;
		STRING100 		jurisdiction;
		STRING2 			jurisdiction_state;
		STRING100 		cru_jurisdiction;
		STRING20 			cru_jurisdiction_nbr;
		STRING11 			jurisdiction_nbr;
		STRING64 			image_hash;
		STRING1 			airbags_deploy;
		STRING12 			did;
		STRING40 			l_accnbr;
		STRING8 			accident_date;
		STRING20 			fname;
		STRING20 			mname;
		STRING20 			lname;
		STRING5 			name_suffix;
		STRING5 			zip;
		STRING4 			zip4;
		STRING100 		record_type;
		STRING25 			driver_license_nbr;
		STRING2 			dlnbr_st;
		STRING30 			vin;
		STRING10 			tag_nbr;
		STRING2 			tagnbr_st;
		STRING8 			dob;
		STRING50 			vehicle_incident_city;
		STRING50 			crash_county;
		STRING100 		carrier_name;
		STRING7 			vehicle_unit_number;
		STRING4 			towed;
		STRING80 			impact_location;
		STRING4 			model_year;
		STRING100 		make_description;
		STRING100 		model_description;
		STRING15 			vehicle_color;
		STRING40 			orig_accnbr;
		STRING40 			addl_report_number;
		STRING9 			agency_ori;
		STRING1 			is_available_for_public;
		STRING20 			report_status;
		STRING4 			work_type_id;
		STRING11 			ssn;
		STRING12 			cru_order_id;
		STRING2 			cru_sequence_nbr;
		STRING8 			date_vendor_last_reported;
		STRING3 			report_type_id;
		STRING8 			creation_date;
		STRING1 			order_vs_report;
		STRING30 			precinct;
		STRING9 			crash_time;
		STRING100 		vendor_code;
		STRING20 			vendor_report_id;
		STRING11 			report_id;
		STRING11 			super_report_id;
		// Police records Project - Addition of new fields
		STRING7 fatality_involved;
		STRING12 latitude;
		STRING18 longitude;
		STRING100 address1;
		STRING100 address2;
		STRING2 state;
		STRING20 home_phone;
		STRING50 Policy_num;
		STRING8 Policy_Expiration_Date;
		STRING25 v_city_name;
    //BuyCrash project KY Integration
		STRING3 contrib_source;
		//Buycrash Release6
		STRING10 date_report_submitted;
		//CrashLogic Release4
    STRING1 releasable;
    BOOLEAN flag_for_delete;
		//PRtCC new fields
		STRING7 citation_issued;
		STRING7 citation_type;
		STRING200 citation_detail1;		
	  //CR-1237
	  STRING64 citation_status; 		
		STRING60 violation_code1;
		STRING60 violation_code2;
		STRING60 violation_code3;
		STRING60 violation_code4;
		STRING7 photographs_taken;
		STRING100 photographed_by;
		STRING100 photograph_type;
		STRING10 posted_satutory_speed_limit;
		STRING25 safety_equipment_available_or_used;
		STRING100 ejection;
		STRING40 safety_equipment_helmet;
		STRING60 transported_to;
		STRING20 dispatch_time;
		STRING1 ready_to_sell_data;
    STRING3 page_count;
		//PRtcc enum fields
		DATASET(enum_code_desc) report_weather_condition;
		DATASET(enum_code_desc) report_road_condition;
		DATASET(enum_code_desc) report_injury_status;
		DATASET(enum_code_desc) report_contributing_circumstances_v;
	  DATASET(enum_code_desc) Alcohol_Drug_Use;
		DATASET(enum_code_desc) alcohol_drug_test_given;
		DATASET(enum_code_desc) alcohol_test_status;
		DATASET(enum_code_desc) alcohol_test_type;
		DATASET(enum_code_desc) alcohol_drug_test_type;
		DATASET(enum_code_desc) drug_test_type;
		DATASET(enum_code_desc) driver_distracted_by;
		DATASET(enum_code_desc) safety_equipment_restraint1;
		DATASET(enum_code_desc) condition_at_time_of_crash;
		DATASET(enum_code_desc) drug_use_suspected;
		DATASET(enum_code_desc) alcohol_use_suspected;
		DATASET(enum_code_desc) drug_test_status;
		DATASET(enum_code_desc) report_contributing_circumstances_p;
		DATASET(enum_code_desc) driver_actions_at_time_of_crash;
		DATASET(enum_code_desc) prior_nonmotorist_action;
		DATASET(enum_code_desc) non_motorist_actions_at_time_of_crash;
		DATASET(enum_code_desc) pedestrian_actions_at_time_of_crash;
		DATASET(enum_code_desc) pedalcyclist_actions_at_time_of_crash;
		DATASET(enum_code_desc) passenger_actions_at_time_of_crash;
	  //CR-1237		
	  DATASET(enum_code_desc) marijuana_use_suspected;
		
		DATASET(Citations_ChildRec) Citation_Details {MAXCOUNT(Constants.Max_Citations_ChildRec_Count)};
		UNSIGNED8 	__internal_fpos__;
	END;

END;