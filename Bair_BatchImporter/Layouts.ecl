IMPORT address,AID,bair;

EXPORT Layouts := MODULE
	SHARED max_size := _Dataset().max_record_size;
	export Input := {,maxlength(max_size * 40) string line {maxlength(max_size * 40)}};
	export Bair_Sentinel_Flag := RECORD
		boolean sentinel := true;
	END;	
	

	export SprayedEventMos_CSV 			:= record
			STRING 			IR_Number;
			STRING 			Crime;
			STRING 			Location_Type;
			STRING 			Object_of_Attack_1;
			STRING 			Object_of_Attack_2;
			STRING 			Point_of_Entry_1;
			STRING 			Point_of_Entry_2;
			STRING 			Method_of_Entry_1;
			STRING 			Method_of_Entry_2;
			STRING 			Suspects_Actions_Against_Person_1;
			STRING 			Suspects_Actions_Against_Person_2;
			STRING 			Suspects_Actions_Against_Person_3;
			STRING 			Suspects_Actions_Against_Person_4;
			STRING 			Suspects_Actions_Against_Person_5;
			STRING 			Suspects_Actions_Against_Property_1;
			STRING 			Suspects_Actions_Against_Property_2;
			STRING 			Suspects_Actions_Against_Property_3;
			STRING 			Property_Taken_1;
			STRING 			Property_Taken_2;
			STRING 			Property_Taken_3;
			STRING 			Property_Value;
			STRING 			Weapon_Type_1;
			STRING 			Weapon_Type_2;
			STRING 			Method_of_Departure;
			STRING 			First_Date;
			STRING 			Last_Date;
			STRING 			First_Date_Time;
			STRING 			Last_Date_Time;
			STRING 			Duration;
			STRING 			Sequence;
			STRING 			First_Day;
			STRING 			Interval;
			STRING 			Last_Day;
			STRING 			Address_of_Crime;
			STRING 			Address_Name;
			STRING 			Beat;
			STRING 			RD;
			STRING 			Synopsis_of_Crime;
			STRING 			companions;
			STRING 			APT;
			STRING 			Trend;
			STRING 			Commonalities;
			STRING 			Marked;
			STRING 			MOSTAMP;
			STRING 			T_Coordinate;
			STRING 			X_Coordinate;
			STRING 			Y_Coordinate;
			STRING 			Edit_Date;
			STRING 			Agency;
			STRING 			Accuracy;
			STRING 			UCR_Group;
			UNSIGNED4		ORI;
			STRING 			Geocoded;
			STRING 			Raids;
			STRING 			X_Offset;
			STRING 			Y_Offset;
			STRING 			Projected_X;
			STRING 			Projected_Y;
			STRING 			Citizen_Observer_ID;
			STRING 			Quarantined;
			STRING 			Public_Address;
			STRING 			group_id;
			STRING 			RAIDS_activityDate;
			STRING 			incidentID;
			STRING 			First_Time;
			STRING 			Last_Time;
			STRING 			import_instance_id;
			STRING 			Public_Synopsis;
			STRING 			LE_Only;
			STRING 			Report_Date;			
			STRING 			coordinate;
			STRING 			action;
			STRING			mo_udf_1;
			STRING			mo_udf_2;
			STRING			mo_udf_3;
			STRING			mo_udf_4;
			STRING			mo_udf_5;
			STRING			mo_udf_6;
			STRING 			mo_udf_7;
			STRING			mo_udf_8;
			STRING			timestamp;
			STRING 			coordinates := '';
	END;	
	//-
	
	export SprayedEventPersons_CSV 	:= RECORD
		STRING			ir_number;
		STRING			personstamp;
		STRING			name_type;
		STRING			last_name;
		STRING			first_name;
		STRING			middle_name;
		STRING			moniker;
		STRING			persons_address;
		STRING			dob;
		STRING			race;
		STRING			sex;
		STRING			hair;
		STRING			hair_length;
		STRING			eyes;
		STRING			hand_use;
		STRING			speech;
		STRING			teeth;
		STRING			physical_condition;
		STRING			build;
		STRING			complexion;
		STRING			facial_hair;
		STRING			hat;
		STRING			mask;
		STRING			glasses;
		STRING			appearance;
		STRING			shirt;
		STRING			pants;
		STRING			shoes;
		STRING			jacket;
		STRING			soundex;
		STRING			persons_notes;
		STRING			weight_1;
		STRING			weight_2;
		STRING			height_1;
		STRING			height_2;
		STRING			age_1;
		STRING			age_2;
		STRING			sid;
		STRING			picture;
		STRING			facial_recognition;
		STRING			persons_x_coordinate;
		STRING			persons_y_coordinate;
		STRING			persons_x_projected;
		STRING			persons_y_projected;
		STRING			persons_accuracy;
		STRING			persons_geocoded;
		STRING			edit_date;
		UNSIGNED4 	ori;
		STRING			quarantined;
		STRING			mo_relationship;
		STRING			group_id;
		STRING			RAIDS_activityDate;
		STRING			import_instance_id;
		STRING			person_udf_1;
		STRING			person_udf_2;
		STRING			person_udf_3;
		STRING			person_udf_4;
		STRING			timestamp;
		STRING			person_udf_5 := '';
	END;
	//-
	export SprayedEventVehicles_CSV 	:= RECORD
		STRING			ir_number;
		STRING			vehiclestamp;
		STRING			plate;
		STRING			plate_state;
		STRING			make;
		STRING			model;
		STRING			style;
		STRING			color;
		STRING			year;
		STRING			type;
		STRING			vehicle_status;
		STRING			vehicle_address;
		STRING			description;
		STRING			vehicle_x_coordinate;
		STRING			vehicle_y_coordinate;
		STRING			vehicle_x_projected;
		STRING			vehicle_y_projected;
		STRING			vehicle_accuracy;
		STRING			vehicle_geocoded;
		STRING			edit_date;
		UNSIGNED4		ori;
		STRING			quarantined;
		STRING			person_relationship;
		STRING			group_id;
		STRING			RAIDS_activityDate;
		STRING			import_instance_id;
		STRING			timestamp;
	END;
	//-
	
	//-
	export SprayedCFS_CSV 	:= RECORD
		UNSIGNED4		ori;
		STRING			event_number;	
		STRING			edit_date;	
		STRING			report_number;
		STRING			caller_address;
		STRING			address;
		STRING			place_name;
		STRING			location_type;
		STRING			district;
		STRING			beat;
		STRING			rd;
		STRING			how_received;
		STRING			initial_type;
		STRING			final_type;
		STRING			disposition;
		STRING			priority;
		STRING			date_occurred;
		STRING			date_time_received;
		STRING			dispatcher_comments;
		STRING			report_flag;
		STRING			event_relationship;
		STRING			date_time_archived;
		STRING			incident_code;
		STRING			incident_progress;
		STRING			city;
		STRING			call_taker;
		STRING			contacting_officer;
		STRING			complainant;
		STRING			current_phone;
		STRING			complainant_address;
		STRING			status;
		STRING			apartment_number;
		STRING			total_minutes_on_call;
		STRING			x_coordinate;
		STRING			y_coordinate;
		STRING			projected_x_coordinate;
		STRING			projected_y_coordinate;
		STRING			geocoded;
		STRING			accuracy;
		STRING			complainant_x_coordinate;
		STRING			complainant_y_coordinate;
		STRING			complainant_projected_x_coordinate;
		STRING			complainant_projected_y_coordinate;
		STRING			complainant_geocoded;
		STRING			complainant_accuracy;
		STRING			quarantined;
		STRING			group_id;
		STRING			import_instance_id;
		STRING			initial_ucr_group;
		STRING			final_ucr_group;
		STRING 			action;		
		STRING			util_string_1;
		STRING			util_string_2;
		STRING			util_string_3;
		STRING			util_string_4;
		STRING			util_string_5;
		STRING			util_integer_1;
		STRING			util_integer_2;
		STRING			util_integer_3;
		STRING			util_decimal_1;
		STRING			util_decimal_2;
		STRING			util_decimal_3;
		STRING			util_datetime_1;
		STRING			util_datetime_2;
		STRING			util_datetime_3;
		STRING			util_datetime_4;
		STRING			util_datetime_5;
		STRING			util_yes_no_1;
		STRING			util_yes_no_2;
		STRING			util_yes_no_3;
		STRING			coordinate;
		STRING			timestamp;		
		STRING			coordinates := '';
		STRING			cfs_id := '';
	END;

	//-
	export SprayedCFSOfficers_CSV 	:= RECORD
		UNSIGNED4   officer_ori;
		STRING			officer_event_number;
		STRING			date_time_dispatched;
		STRING			date_time_enroute;
		STRING			date_time_arrived;
		STRING			date_time_cleared;
		STRING			minutes_on_call;
		STRING			minutes_response;
		STRING			unit;
		STRING			officer_name;
		STRING			synopsis;
		STRING			primary_officer;
		STRING			util_string_1;
		STRING			util_string_2;
		STRING			util_string_3;
		STRING			util_string_4;
		STRING			util_string_5;
		STRING			util_integer_1;
		STRING			util_integer_2;
		STRING			util_integer_3;
		STRING			util_decimal_1;
		STRING			util_decimal_2;
		STRING			util_decimal_3;
		STRING			util_datetime_1;
		STRING			util_datetime_2;
		STRING			util_datetime_3;
		STRING			util_datetime_4;
		STRING			util_datetime_5;
		STRING			util_yes_no_1;
		STRING			util_yes_no_2;
		STRING			util_yes_no_3;
		STRING			timestamp;
		STRING			cfs_officers_id := '';
		STRING			cfs_id := '';

	END;
	//-
	export CFSOfficers_CSV 	:= RECORD
		SprayedCFS_CSV;
		SprayedCFSOfficers_CSV;
	END;	
	//-	
	export SprayedCrash_CSV 	:= RECORD
		UNSIGNED4		dataProviderId;
		STRING			caseNumber;
		STRING			reportNumber;
		STRING			reportDate;
		STRING			address;
		STRING			county;
		STRING			city;
		STRING			state;
		STRING			x_coordinate;
		STRING			y_coordinate;
		STRING			coordinate;
		STRING			hitAndRun;
		STRING			intersectionRelated;
		STRING			officerName;
		STRING			crashType;
		STRING			locationType;
		STRING			accidentClass;
		STRING			specialCircumstance1;
		STRING			specialCircumstance2;
		STRING			specialCircumstance3;
		STRING			lightCondition;
		STRING			weatherCondition;
		STRING			surfaceType;
		STRING			roadSpecialFeature1;
		STRING			roadSpecialFeature2;
		STRING			roadSpecialFeature3;
		STRING			surfaceCondition;
		STRING			trafficControlPresent;
		STRING			narrative;
		STRING			quarantined;
		STRING			action;
		STRING			timestamp;	
		STRING			agency_id := '';
		STRING			crash_import_id := '';
		STRING			Agency := '';
		UNSIGNED4   Id := 0;
	END;
  //-
	export SprayedCrashPersons_CSV 	:= RECORD
		STRING			dataProviderId;
		STRING			caseNumber;
		STRING			vehicleId;
		STRING			driver;
		STRING			firstName;
		STRING			lastName;
		STRING			licenseNumber;
		STRING			licenseState;
		STRING			race;
		STRING			sex;
		STRING			city;
		STRING			state;
		STRING			age;
		STRING			driverActions;
		STRING			airbag;
		STRING			seatbelt;
		STRING			timestamp;	
		STRING			agency_person_id := '';
		STRING			crash_import_id := '';
		STRING			id := '';
		STRING			crashId := '';		
	END;
	//-
	export SprayedCrashVehicles_CSV 	:= RECORD
		STRING			dataProviderId;
		STRING			caseNumber;
		STRING			vehicleId;		
		STRING			vin;
		STRING			plate;
		STRING			plateState;
		STRING			year;
		STRING			make;
		STRING			model;
		STRING			towed;
		STRING			vehicleType;
		STRING			damage;
		STRING			action;
		STRING			sequence;
		STRING			driverImpairment;
		STRING			timestamp;
		STRING			agency_vehicle_id := '';
		STRING			crash_import_id := '';
		STRING			id := '';
		STRING			crashId := '';
	END;
	//-	
	export SprayedOffenders_CSV 	:= RECORD
		UNSIGNED4		data_provider_id;
		STRING			agency_offender_id;
		STRING			name_type;
		STRING			last_name;
		STRING			first_name;
		STRING			middle_name;
		STRING			moniker;
		STRING			address;
		STRING			x_coordinate;
		STRING			y_coordinate;
		STRING			coordinate;
		STRING			dob;
		STRING			race;
		STRING			sex;
		STRING			hair;
		STRING			hair_length;
		STRING			eyes;
		STRING			hand_use;
		STRING			speech;
		STRING			teeth;
		STRING			physical_condition;
		STRING			build;
		STRING			complexion;
		STRING			facial_hair;
		STRING			hat;
		STRING			mask;
		STRING			glasses;
		STRING			appearance;
		STRING			shirt;
		STRING			pants;
		STRING			shoes;
		STRING			jacket;
		STRING			soundex;
		STRING			weight_1;
		STRING			weight_2;
		STRING			height_1;
		STRING			height_2;
		STRING			age_1;
		STRING			age_2;
		STRING			sid;
		STRING			dl_number;
		STRING			dl_state;
		STRING			fbi_number;
		STRING			picture;
		STRING			offender_notes;
		STRING			edit_date;
		STRING			BAIR_score;
		STRING			admin_state;
		STRING			agency_name;
		STRING			user_text_1;
		STRING			user_text_2;
		STRING			user_integer;
		STRING			user_float;
		STRING			user_datetime;
		STRING			action;
		STRING			timestamp;
		STRING			quarantined := '';
		STRING			group_id := '';
		STRING			raids_activity_date := '';
		STRING			import_instance_id := '';	
		STRING			id := '';
	END;
	//-
	export SprayedClassification_CSV 	:= RECORD
		STRING			data_provider_id;
		STRING			agency_offender_id;
		STRING			classification;
		STRING			agency_category;
		STRING			agency_level;
		STRING			agency_score;
		STRING			case_reference_number;
		STRING			charge_offense;
		STRING			probation_type;
		STRING			probation_officer;
		STRING			warrant_type;
		STRING			warrant_number;
		STRING			gang_name;
		STRING			gang_role;
		STRING			classification_date;
		STRING			expiration_date;
		STRING			timestamp;
		STRING			id := '';
		STRING			offender_id := '';
	END;
	//-
	export SprayedPictures_CSV 	:= RECORD
		STRING			data_provider_id;
		STRING			agency_offender_id;
		STRING			offender_picture;
		STRING			timestamp;
		STRING			id := '';
		STRING			offender_id := '';
		STRING			where_displayed := '';
	END;	
	//-
	export SprayedLPR_CSV := record
			string 		EventNumber;
			string  	CaptureDateTime;
			string  	Plate;
			string  	PlateAlternate;
			string  	Confidence;
			string  	PlateImage;
			string  	OverviewImage;
			string  	X_Coordinate;
			string 		Y_Coordinate;
			string		ORI;
			STRING		timestamp;			
			string		coordinate := '';						
			string		action := 'ADD';			
			string		LicensePlateRecordGUID := '';			
	end;

	
	export address_cache  := RECORD
		unsigned4 ac_dataProviderID;
		string255	ac_address;
		real8			ac_x_coordinate;
		real8			ac_y_coordinate;
		string50	ac_accuracy;
		string1		ac_geocoded;
		string25	ac_edit_date;
		string182 ac_clean_address_182;
		string		ac_google_geocoded;
		string12  ac_originated;
	END;


	export event_dbo_mo_In_extended := RECORD
		bair.layouts.event_dbo_mo_In;
		UNSIGNED1 quarantine_code;
		BOOLEAN   DoNotImport := FALSE;
		STRING		mo_udf_1;
		STRING		mo_udf_2;
		STRING		mo_udf_3;
		STRING		mo_udf_4;
		STRING		mo_udf_5;
		STRING		mo_udf_6;
		STRING 		mo_udf_7;
		STRING		mo_udf_8;
		real8     X_Offset_Min;
		real8     X_Offset_Max;
		real8     Y_Offset_Min;
		real8     Y_Offset_Max;
		real8     boundingBoxSouthWestLat;
		real8     boundingBoxSouthWestLong;
		real8     boundingBoxNorthEastLat;
		real8     boundingBoxNorthEastLong;		
		UNSIGNED2 offsetType;
	END;
	
	export event_dbo_persons_In_extended  := RECORD	
		bair.layouts.event_dbo_persons_In;
		UNSIGNED1 quarantine_code;
		STRING		person_udf_1;
		STRING		person_udf_2;
		STRING		person_udf_3;
		STRING		person_udf_4;
		STRING		person_udf_5;
		
	END;

	export event_dbo_vehicle_In_extended  := RECORD	
		bair.layouts.event_dbo_vehicle_In;
		unsigned1 quarantine_code;
	END;
	
	export cfs_dbo_cfs_2_In_extended := RECORD
		bair.layouts.cfs_dbo_cfs_2_In;
		BOOLEAN   initial_DoNotImport := FALSE;
		BOOLEAN   final_DoNotImport   := FALSE;
		unsigned1 quarantine_code;
		string25  date_time_dispatched;
		string25  date_time_enroute;
		string25  date_time_arrived;
		string25  date_time_cleared;
		string30  unit;
		string50  officer_name;			
	  UNSIGNED4 officer_ori;
		string100 officer_event_number;
		real8     boundingBoxSouthWestLat;
		real8     boundingBoxSouthWestLong;
		real8     boundingBoxNorthEastLat;
		real8     boundingBoxNorthEastLong;		
		
	END;
	
	export Offenders_dbo_offender_In_extended := RECORD
		bair.layouts.Offenders_dbo_offender_In;
		unsigned1 quarantine_code;
	END;
	
	export crash_dbo_crash_In_extended := RECORD
		bair.layouts.crash_dbo_crash_In;
		unsigned1 quarantine_code;
		real8     boundingBoxSouthWestLat;
		real8     boundingBoxSouthWestLong;
		real8     boundingBoxNorthEastLat;
		real8     boundingBoxNorthEastLong;			
	END;

	export lpr_dbo_LicensePlate_In_extended := RECORD
		bair.layouts.lpr_dbo_LicensePlate_In;
		unsigned1 quarantine_code;
		real8     boundingBoxSouthWestLat;
		real8     boundingBoxSouthWestLong;
		real8     boundingBoxNorthEastLat;
		real8     boundingBoxNorthEastLong;			
	END;
	
	export orbitbuilds_layout := RECORD
		STRING orbitbuild;
	END;

	export recordid_raids := RECORD
		integer mo_recordid_raids;
		integer person_recordid_raids;
	END;	

	export geocoding_log := RECORD
		unsigned8		datetime;
		string			file;
		unsigned4 	counts;
	END;		
	
	export orbit_receivings  := record
		STRING receivingid;
		STRING fullfilename;
		STRING FileCurLocation;
	end;

	export orbit_build := record
		STRING buildName;
		STRING buildVersion;
		STRING FileType;
		STRING fileextension;
		STRING Agency;
		STRING LandingZone;
		STRING preppedAgencyBuildVersion;
		STRING ReProcessFlag;
		DATASET({orbit_receivings}) Receivings;
	end;
	
	export manifest := record
		STRING field1;
	end;
END;

