IMPORT BankruptcyV3, BIPV2, Cortera_Tradeline, Doxie, Doxie_Files, FAA, Header_Quick, PublicRecords_KEL, VehicleV2;

EXPORT Layouts_FDC(PublicRecords_KEL.Interface_Options Options = PublicRecords_KEL.Interface_Options) := MODULE 
	
	SHARED LayoutIDs := RECORD
		INTEGER InputUIDAppend;
		INTEGER7 LexIDAppend;
		INTEGER BusInputUIDAppend;
		INTEGER7 LexIDBusExtendedFamilyAppend;//UltID
		INTEGER7 LexIDBusLegalFamilyAppend;	//OrgID
		INTEGER7 LexIDBusLegalEntityAppend;//SeleID
	END;
	
	SHARED Doxie__Key_Header := IF(Options.IsFCRA, Doxie.Key_FCRA_Header, Doxie.Key_Header);
	EXPORT Layout_Doxie__Key_Header := RECORD
		LayoutIDs;
		RECORDOF(Doxie__Key_Header);
		UNSIGNED8 DPMBitmap;
	END;	

	SHARED Header_Quick__Key_Did := IF(Options.IsFCRA, Header_Quick.Key_Did_FCRA, Header_Quick.Key_Did);
	EXPORT Layout_Header_Quick__Key_Did := RECORD
		LayoutIDs;
		RECORDOF(Header_Quick__Key_Did);
		UNSIGNED8 DPMBitmap;
	END;	

	// --------------------[ Criminal ]--------------------
	
	EXPORT Layout_Doxie_Files__Key_BocaShell_Crim_FCRA_Denorm := RECORD
		LayoutIDs;
		RECORDOF(Doxie_Files.Key_BocaShell_Crim_FCRA);
		STRING2 src;
		UNSIGNED8 DPMBitmap;
	END;
	
	EXPORT Layout_Doxie_Files__Key_BocaShell_Crim_FCRA := RECORD
		LayoutIDs;
		RECORDOF(Doxie_Files.Key_BocaShell_Crim_FCRA) - Criminal_Count; // Changing layout to normalize child dataset Criminal_Count
		RECORDOF(Doxie_Files.Key_BocaShell_Crim_FCRA.Criminal_Count);
		STRING2 src;
		UNSIGNED8 DPMBitmap;
	END;
	
	EXPORT Layout_Doxie_Files__Key_Offenders := RECORD
		LayoutIDs;
		RECORDOF(Doxie_Files.Key_Offenders);
		STRING2 src;
		UNSIGNED8 DPMBitmap;
	END;	
	
	EXPORT Layout_Doxie_files__Key_Court_Offenses := RECORD
		LayoutIDs;
		RECORDOF(Doxie_files.Key_Court_Offenses);
		STRING2 src;
		UNSIGNED8 DPMBitmap;
	END;	
	
	EXPORT Layout_Doxie_Files__Key_Offenses := RECORD
		LayoutIDs;
		RECORDOF(Doxie_Files.Key_Offenses);
		STRING2 src;
		UNSIGNED8 DPMBitmap;
	END;	
	
	EXPORT Layout_Doxie_Files__Key_Offenders_Risk := RECORD
		LayoutIDs;
		RECORDOF(Doxie_Files.Key_Offenders_Risk);
		STRING2 src;
		UNSIGNED8 DPMBitmap;
	END;
	

	EXPORT Layout_Doxie_Files__Key_Punishment := RECORD
		LayoutIDs;
		RECORDOF(Doxie_Files.Key_Punishment);
		STRING2 src;
		UNSIGNED8 DPMBitmap;
	END;
	
	// --------------------[ Bankruptcy ]--------------------

	SHARED BankruptcyV3__key_bankruptcyV3_did := BankruptcyV3.key_bankruptcyV3_did(Options.IsFCRA);
	EXPORT Layout_Bankruptcy__Key_did := RECORD
		LayoutIDs;
		RECORDOF(BankruptcyV3__key_bankruptcyV3_did);
	END;		

	SHARED BankruptcyV3__key_bankruptcyv3_search_full_bip := BankruptcyV3.key_bankruptcyv3_search_full_bip(Options.IsFCRA);
	EXPORT Layout_BankruptcyV3__key_bankruptcyv3_search := RECORD
		LayoutIDs;
		RECORDOF(BankruptcyV3__key_bankruptcyv3_search_full_bip);
		STRING2 src;
		UNSIGNED8 DPMBitmap;
	END;	

	// --------------------[ Business Header ]--------------------

	SHARED BIPV2__Key_BH_Linking_Ids__key := BIPV2.Key_BH_Linking_Ids.key;
	EXPORT Layout_BIPV2__Key_BH_Linking_Ids := RECORD
		LayoutIDs;
		RECORDOF(BIPV2__Key_BH_Linking_Ids__key);
		UNSIGNED8 DPMBitmap;
	END;

	// --------------------[ Tradeline ]--------------------

	SHARED Cortera_Tradeline__Key_LinkIds__key := Cortera_Tradeline.Key_LinkIds.Key;
	EXPORT Layout_Cortera_Tradeline__Key_LinkIds := RECORD
		LayoutIDs;
		RECORDOF(Cortera_Tradeline__Key_LinkIds__key);
		UNSIGNED8 DPMBitmap;
	END;

	// --------------------[ Aircraft ]--------------------

	SHARED FAA__key_aircraft_did := FAA.key_aircraft_did();
	EXPORT Layout_FAA__key_aircraft_did := RECORD
		LayoutIDs;
		RECORDOF(FAA__key_aircraft_did);
	END;

	SHARED FAA__key_aircraft_id := FAA.key_aircraft_id();
	EXPORT Layout_FAA__key_aircraft_id := RECORD
		LayoutIDs;
		// RECORDOF(faa__key_aircraft_id);
		faa__key_aircraft_id.did_out;
		faa__key_aircraft_id.n_number;
		faa__key_aircraft_id.date_first_seen;
		faa__key_aircraft_id.date_last_seen;
		faa__key_aircraft_id.serial_number;
		faa__key_aircraft_id.mfr_mdl_code;
		faa__key_aircraft_id.eng_mfr_mdl;
		faa__key_aircraft_id.year_mfr;
		faa__key_aircraft_id.last_action_date;
		faa__key_aircraft_id.type_aircraft;
		faa__key_aircraft_id.type_engine;
		faa__key_aircraft_id.status_code;
		faa__key_aircraft_id.mode_s_code;
		faa__key_aircraft_id.fract_owner;
		faa__key_aircraft_id.aircraft_mfr_name;
		faa__key_aircraft_id.model_name;
		faa__key_aircraft_id.type_registrant;
		faa__key_aircraft_id.cert_issue_date;
		faa__key_aircraft_id.certification;
		STRING2 src;
		UNSIGNED8 DPMBitmap;
	END;

	// --------------------[ Vehicle ]--------------------

	SHARED VehicleV2__Key_Vehicle_DID := VehicleV2.Key_Vehicle_DID;
	EXPORT Layout_VehicleV2__Key_Vehicle_DID := RECORD
		LayoutIDs;
		RECORDOF(VehicleV2__Key_Vehicle_DID);
	END;

	SHARED VehicleV2__Key_Vehicle_Party_Key := VehicleV2.Key_Vehicle_Party_Key;
	EXPORT Layout_VehicleV2__Key_Vehicle_Party_Key := RECORD
		LayoutIDs;
		VehicleV2__Key_Vehicle_Party_Key.vehicle_key;
		VehicleV2__Key_Vehicle_Party_Key.state_origin;
		VehicleV2__Key_Vehicle_Party_Key.latest_vehicle_flag;
		VehicleV2__Key_Vehicle_Party_Key.latest_vehicle_iteration_flag;
		VehicleV2__Key_Vehicle_Party_Key.date_first_seen;
		VehicleV2__Key_Vehicle_Party_Key.date_last_seen;
		VehicleV2__Key_Vehicle_Party_Key.date_vendor_first_reported;
		VehicleV2__Key_Vehicle_Party_Key.date_vendor_last_reported;
		VehicleV2__Key_Vehicle_Party_Key.src_first_date;
		VehicleV2__Key_Vehicle_Party_Key.src_last_date;
		VehicleV2__Key_Vehicle_Party_Key.std_lienholder_name;
		VehicleV2__Key_Vehicle_Party_Key.source_code;
		VehicleV2__Key_Vehicle_Party_Key.append_did;
		VehicleV2__Key_Vehicle_Party_Key.reg_first_date;
		VehicleV2__Key_Vehicle_Party_Key.reg_earliest_effective_date;
		VehicleV2__Key_Vehicle_Party_Key.reg_latest_effective_date;
		VehicleV2__Key_Vehicle_Party_Key.reg_latest_expiration_date;
		VehicleV2__Key_Vehicle_Party_Key.reg_rollup_count;
		VehicleV2__Key_Vehicle_Party_Key.reg_decal_number;
		VehicleV2__Key_Vehicle_Party_Key.reg_decal_year;
		VehicleV2__Key_Vehicle_Party_Key.reg_status_code;
		VehicleV2__Key_Vehicle_Party_Key.reg_status_desc;
		VehicleV2__Key_Vehicle_Party_Key.reg_true_license_plate;
		VehicleV2__Key_Vehicle_Party_Key.reg_license_plate;
		VehicleV2__Key_Vehicle_Party_Key.reg_license_state;
		VehicleV2__Key_Vehicle_Party_Key.reg_license_plate_type_code;
		VehicleV2__Key_Vehicle_Party_Key.reg_license_plate_type_desc;
		VehicleV2__Key_Vehicle_Party_Key.reg_previous_license_state;
		VehicleV2__Key_Vehicle_Party_Key.reg_previous_license_plate;
		VehicleV2__Key_Vehicle_Party_Key.ttl_number;
		VehicleV2__Key_Vehicle_Party_Key.ttl_earliest_issue_date;
		VehicleV2__Key_Vehicle_Party_Key.ttl_latest_issue_date;
		VehicleV2__Key_Vehicle_Party_Key.ttl_previous_issue_date;
		VehicleV2__Key_Vehicle_Party_Key.ttl_rollup_count;
		VehicleV2__Key_Vehicle_Party_Key.ttl_status_code;
		VehicleV2__Key_Vehicle_Party_Key.ttl_status_desc;
		VehicleV2__Key_Vehicle_Party_Key.ttl_odometer_mileage;
		VehicleV2__Key_Vehicle_Party_Key.ttl_odometer_status_code;
		VehicleV2__Key_Vehicle_Party_Key.ttl_odometer_status_desc;
		VehicleV2__Key_Vehicle_Party_Key.ttl_odometer_date;
		VehicleV2__Key_Vehicle_Party_Key.sequence_key;
		VehicleV2__Key_Vehicle_Party_Key.history;
		STRING2 src;
		UNSIGNED8 DPMBitmap;
	END;

	SHARED VehicleV2__Key_Vehicle_Main_Key := VehicleV2.Key_Vehicle_Main_Key;
	EXPORT Layout_VehicleV2__Key_Vehicle_Main_Key := RECORD
		LayoutIDs;
		VehicleV2__Key_Vehicle_Main_Key.vehicle_key;
		VehicleV2__Key_Vehicle_Main_Key.state_origin;
		VehicleV2__Key_Vehicle_Main_Key.orig_vin;
		VehicleV2__Key_Vehicle_Main_Key.orig_year;
		VehicleV2__Key_Vehicle_Main_Key.orig_make_code;
		VehicleV2__Key_Vehicle_Main_Key.orig_make_desc;
		VehicleV2__Key_Vehicle_Main_Key.orig_series_code;
		VehicleV2__Key_Vehicle_Main_Key.orig_series_desc;
		VehicleV2__Key_Vehicle_Main_Key.orig_model_code;
		VehicleV2__Key_Vehicle_Main_Key.orig_model_desc;
		VehicleV2__Key_Vehicle_Main_Key.orig_body_code;
		VehicleV2__Key_Vehicle_Main_Key.orig_body_desc;
		VehicleV2__Key_Vehicle_Main_Key.orig_net_weight;
		VehicleV2__Key_Vehicle_Main_Key.orig_gross_weight;
		VehicleV2__Key_Vehicle_Main_Key.Orig_Number_Of_Axles; // not "orig_number_axles"
		VehicleV2__Key_Vehicle_Main_Key.orig_vehicle_use_code;
		VehicleV2__Key_Vehicle_Main_Key.orig_vehicle_use_desc;
		VehicleV2__Key_Vehicle_Main_Key.orig_vehicle_type_code;
		VehicleV2__Key_Vehicle_Main_Key.orig_vehicle_type_desc;
		VehicleV2__Key_Vehicle_Main_Key.orig_major_color_code;
		VehicleV2__Key_Vehicle_Main_Key.orig_major_color_desc;
		VehicleV2__Key_Vehicle_Main_Key.orig_minor_color_code;
		VehicleV2__Key_Vehicle_Main_Key.orig_minor_color_desc;
		VehicleV2__Key_Vehicle_Main_Key.vina_vin;
		VehicleV2__Key_Vehicle_Main_Key.vina_vin_pattern_indicator;
		VehicleV2__Key_Vehicle_Main_Key.vina_bypass_code;
		VehicleV2__Key_Vehicle_Main_Key.vina_veh_type;
		VehicleV2__Key_Vehicle_Main_Key.vina_ncic_make;
		VehicleV2__Key_Vehicle_Main_Key.vina_model_year_yy;
		VehicleV2__Key_Vehicle_Main_Key.vina_vp_restraint;
		VehicleV2__Key_Vehicle_Main_Key.vina_vp_abbrev_make_name;
		VehicleV2__Key_Vehicle_Main_Key.vina_vp_year;
		VehicleV2__Key_Vehicle_Main_Key.vina_vp_series;
		VehicleV2__Key_Vehicle_Main_Key.vina_vp_model;
		VehicleV2__Key_Vehicle_Main_Key.vina_vp_air_conditioning;
		VehicleV2__Key_Vehicle_Main_Key.vina_vp_power_steering;
		VehicleV2__Key_Vehicle_Main_Key.vina_vp_power_brakes;
		VehicleV2__Key_Vehicle_Main_Key.vina_vp_power_windows;
		VehicleV2__Key_Vehicle_Main_Key.vina_vp_tilt_wheel;
		VehicleV2__Key_Vehicle_Main_Key.vina_vp_roof;
		VehicleV2__Key_Vehicle_Main_Key.vina_vp_optional_roof1;
		VehicleV2__Key_Vehicle_Main_Key.vina_vp_optional_roof2;
		VehicleV2__Key_Vehicle_Main_Key.vina_vp_radio;
		VehicleV2__Key_Vehicle_Main_Key.vina_vp_optional_radio1;
		VehicleV2__Key_Vehicle_Main_Key.vina_vp_optional_radio2;
		VehicleV2__Key_Vehicle_Main_Key.vina_vp_transmission;
		VehicleV2__Key_Vehicle_Main_Key.vina_vp_optional_transmission1;
		VehicleV2__Key_Vehicle_Main_Key.vina_vp_optional_transmission2;
		VehicleV2__Key_Vehicle_Main_Key.vina_vp_anti_lock_brakes;
		VehicleV2__Key_Vehicle_Main_Key.vina_vp_front_wheel_drive;
		VehicleV2__Key_Vehicle_Main_Key.vina_vp_four_wheel_drive;
		VehicleV2__Key_Vehicle_Main_Key.vina_vp_security_system;
		VehicleV2__Key_Vehicle_Main_Key.vina_vp_daytime_running_lights;
		VehicleV2__Key_Vehicle_Main_Key.vina_vp_series_name;
		VehicleV2__Key_Vehicle_Main_Key.vina_model_year;
		VehicleV2__Key_Vehicle_Main_Key.vina_series;
		VehicleV2__Key_Vehicle_Main_Key.vina_model;
		VehicleV2__Key_Vehicle_Main_Key.vina_body_style;
		VehicleV2__Key_Vehicle_Main_Key.vina_make_desc;
		VehicleV2__Key_Vehicle_Main_Key.vina_model_desc;
		VehicleV2__Key_Vehicle_Main_Key.vina_series_desc;
		VehicleV2__Key_Vehicle_Main_Key.vina_body_style_desc;
		VehicleV2__Key_Vehicle_Main_Key.vina_number_of_cylinders;
		VehicleV2__Key_Vehicle_Main_Key.vina_engine_size;
		VehicleV2__Key_Vehicle_Main_Key.vina_fuel_code; // not "vina_vuel_code"
		VehicleV2__Key_Vehicle_Main_Key.vina_price;
		VehicleV2__Key_Vehicle_Main_Key.best_make_code;
		VehicleV2__Key_Vehicle_Main_Key.best_series_code;
		VehicleV2__Key_Vehicle_Main_Key.best_model_code;
		VehicleV2__Key_Vehicle_Main_Key.best_body_code;
		VehicleV2__Key_Vehicle_Main_Key.best_model_year;
		VehicleV2__Key_Vehicle_Main_Key.best_major_color_code;
		VehicleV2__Key_Vehicle_Main_Key.best_minor_color_code;
		VehicleV2__Key_Vehicle_Main_Key.branded_title_flag;
		VehicleV2__Key_Vehicle_Main_Key.brand_code_1;
		STRING cleaned_brand_date_1;
		VehicleV2__Key_Vehicle_Main_Key.brand_state_1;
		VehicleV2__Key_Vehicle_Main_Key.brand_code_2;
		STRING cleaned_brand_date_2;
		VehicleV2__Key_Vehicle_Main_Key.brand_state_2;
		VehicleV2__Key_Vehicle_Main_Key.brand_code_3;
		STRING cleaned_brand_date_3;
		VehicleV2__Key_Vehicle_Main_Key.brand_state_3;
		VehicleV2__Key_Vehicle_Main_Key.brand_code_4;
		STRING cleaned_brand_date_4;
		VehicleV2__Key_Vehicle_Main_Key.brand_state_4;
		VehicleV2__Key_Vehicle_Main_Key.brand_code_5;
		STRING cleaned_brand_date_5;
		VehicleV2__Key_Vehicle_Main_Key.brand_state_5;
		VehicleV2__Key_Vehicle_Main_Key.tod_flag;
		VehicleV2__Key_Vehicle_Main_Key.model_class_code;
		VehicleV2__Key_Vehicle_Main_Key.model_class;
		VehicleV2__Key_Vehicle_Main_Key.min_door_count;
		VehicleV2__Key_Vehicle_Main_Key.safety_type; // not "saftey_type"
		VehicleV2__Key_Vehicle_Main_Key.airbag_driver;
		VehicleV2__Key_Vehicle_Main_Key.airbag_front_driver_side;
		VehicleV2__Key_Vehicle_Main_Key.airbag_front_head_curtain;
		VehicleV2__Key_Vehicle_Main_Key.airbag_front_pass;
		VehicleV2__Key_Vehicle_Main_Key.airbag_front_pass_side;
		VehicleV2__Key_Vehicle_Main_Key.airbags;
		STRING2 src;
		UNSIGNED8 DPMBitmap;
	END;

  // ===================[ Composite Layout ]===================
  
	EXPORT Layout_FDC := RECORD
		LayoutIDs;
		DATASET(Layout_Doxie__Key_Header) Dataset_Doxie__Key_Header;
		DATASET(Layout_Header_Quick__Key_Did) Dataset_Header_Quick__Key_Did;
    
    // --------------------[ Consumer Section ]--------------------
		// Criminal
		DATASET(Layout_Doxie_Files__Key_BocaShell_Crim_FCRA) Dataset_Doxie_Files__Key_BocaShell_Crim_FCRA;
		DATASET(Layout_Doxie_Files__Key_Offenders) Dataset_Doxie_Files__Key_Offenders;
		DATASET(Layout_Doxie_files__Key_Court_Offenses) Dataset_Doxie_files__Key_Court_Offenses;
		DATASET(Layout_Doxie_Files__Key_Offenses) Dataset_Doxie_Files__Key_Offenses;
		DATASET(Layout_Doxie_Files__Key_Offenders_Risk) Dataset_Doxie_Files__Key_Offenders_Risk;
		DATASET(Layout_Doxie_Files__Key_Punishment) Dataset_Doxie_Files__Key_Punishment;
		// Bankruptcy
		DATASET(Layout_BankruptcyV3__key_bankruptcyv3_search) Dataset_Bankruptcy_Files__Key_Search;
		// Aircraft
		DATASET(Layout_FAA__key_aircraft_id) Dataset_FAA__Key_Aircraft_IDs;
		// Vehicle
		DATASET(Layout_VehicleV2__Key_Vehicle_Party_Key) Dataset_VehicleV2__Key_Vehicle_Party_Key;
		DATASET(Layout_VehicleV2__Key_Vehicle_Main_Key) Dataset_VehicleV2__Key_Vehicle_Main_Key;
    
    // --------------------[ Business Section ]--------------------
		// Business Header
		DATASET(Layout_BIPV2__Key_BH_Linking_Ids) Dataset_BIPV2__Key_BH_Linking_Ids;
		// Cortera Tradeline
		DATASET(Layout_Cortera_Tradeline__Key_LinkIds) Dataset_Cortera_Tradeline__Key_LinkIds;
	END;
	
END;