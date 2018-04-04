import address, AID, BIPV2, bair_composite;

export layouts := module
	
	export src_and_date	:= RECORD
		STRING2 		src;		
		UNSIGNED4 	dt_vendor_first_reported := 0;
		UNSIGNED4 	dt_vendor_last_reported := 0;
		UNSIGNED4		dt_first_seen	:= 0;
		UNSIGNED4		dt_last_seen	:= 0;
		STRING1   	record_type;
	end;
		
	export events_helper_ucr_group_classifications := RECORD
		UNSIGNED4 	ucr_group_id;
		string50  	name;
		string50  	display;
		string50  	color;
		string50  	image;		
		UNSIGNED4 	category;
		UNSIGNED4 	mode;
		UNSIGNED4 	severity;
	end;
	
 	export cfs_dbo_cfs_2_In := RECORD
		UNSIGNED4    cfs_id;
		UNSIGNED4    ori;
		string100    event_number;
		string25     edit_date;
		string30     report_number;
		string       caller_address;
		string       address;
		string       place_name;
		string       location_type;
		string30     district;
		string30     beat;
		string       rd;
		string50     how_received;
		string       initial_type;
		string	     final_type;
		string30     disposition;
		string30     priority1;
		string25     date_occurred;
		string25     date_time_received;
		string	     dispatcher_comments;
		string1	     report_flag;
		string	     event_relationship;
		string25     date_time_archived;
		string30     incident_code;
		string		   incident_progress;
		string100    city;
		string100    call_taker;
		string100    contacting_officer;
		string100    complainant;
		string30     current_phone;
		string		   complainant_address;
		string	     status;
		string30     apartment_number;
		real8        total_minutes_on_call;
		real8     	 x_coordinate;
		real8     	 y_coordinate;
		real8     	 projected_x_coordinate;
		real8     	 projected_y_coordinate;
		string1      geocoded;
		unsigned1    accuracy_code;
		real8     	 complainant_x_coordinate;
		real8     	 complainant_y_coordinate;
		real8     	 complainant_projected_x_coordinate;
		real8     	 complainant_projected_y_coordinate;
		string1      complainant_geocoded;
		unsigned1    complainant_accuracy;
		string1      quarantined;
		UNSIGNED2    group_id;
		UNSIGNED4    import_instance_id;
		UNSIGNED4    initial_ucr_group;
		UNSIGNED4    final_ucr_group;
		string 	 		 util_string_1;
		string 	 		 util_string_2;
		string 	 		 util_string_3;
		string 	 		 util_string_4;
		string 	 		 util_string_5;
		unsigned2 	 util_integer_1;
		unsigned2 	 util_integer_2;
		unsigned2 	 util_integer_3;
		real8 			 util_decimal_1;
		real8 			 util_decimal_2;
		real8 			 util_decimal_3;
		string25     util_datetime_1;
		string25     util_datetime_2;
		string25     util_datetime_3;
		string25     util_datetime_4;
		string25     util_datetime_5;
		boolean      util_yes_no_1;
		boolean      util_yes_no_2;
		boolean      util_yes_no_3;
		string20		 coordinate;
		string182    caller_address_clean := '';
		string182	   complainant_address_clean := '';
		string182    address_clean := '';
  END;
	
	export cfs_dbo_cfs_2_Base := RECORD
		cfs_dbo_cfs_2_In;
		src_and_date;
		string10  clean_Current_Phone;				
		UNSIGNED4 clean_Edit_Date := 0;
		UNSIGNED4 clean_date_occurred := 0;
		UNSIGNED4 clean_date_time_received := 0;
		UNSIGNED4 clean_date_time_archived := 0;
		UNSIGNED4 clean_util_datetime_1 := 0;	
		UNSIGNED4 clean_util_datetime_2 := 0;
		UNSIGNED4 clean_util_datetime_3 := 0;
		UNSIGNED4 clean_util_datetime_4 := 0;
		UNSIGNED4 clean_util_datetime_5 := 0;
	end;
	
	export cfs_dbo_cfs_officers_2_In := RECORD
		UNSIGNED4    cfs_officers_id;
		UNSIGNED4    cfs_id;
		string25     date_time_dispatched;
		string25     date_time_enroute;
		string25     date_time_arrived;
		string25     date_time_cleared;
		real8        minutes_on_call;
		real8        minutes_response;
		string30     unit;
		string50     officer_name;
		string			 synopsis;
		string1      primary_officer;
		string 	 		 off_util_string_1;
		string 	 		 off_util_string_2;
		string 	 		 off_util_string_3;
		string 	 		 off_util_string_4;
		string 	 		 off_util_string_5;
		unsigned2 	 off_util_integer_1;
		unsigned2 	 off_util_integer_2;
		unsigned2 	 off_util_integer_3;
		real8 			 off_util_decimal_1;
		real8 			 off_util_decimal_2;
		real8 			 off_util_decimal_3;
		string25     off_util_datetime_1;
		string25     off_util_datetime_2;
		string25     off_util_datetime_3;
		string25     off_util_datetime_4;
		string25     off_util_datetime_5;
		boolean      off_util_yes_no_1;
		boolean      off_util_yes_no_2;
		boolean      off_util_yes_no_3;
		UNSIGNED4    ori;
		string100    event_number;
	END;
		
	export cfs_dbo_cfs_officers_2_Base := RECORD
		cfs_dbo_cfs_officers_2_In;
		src_and_date;
		UNSIGNED4 clean_date_time_dispatched := 0;
		UNSIGNED4 clean_date_time_enroute := 0;
		UNSIGNED4 clean_date_time_arrived := 0;
		UNSIGNED4 clean_date_time_cleared := 0;	
		UNSIGNED4 clean_officers_util_datetime_1 := 0;	
		UNSIGNED4 clean_officers_util_datetime_2 := 0;
		UNSIGNED4 clean_officers_util_datetime_3 := 0;
		UNSIGNED4 clean_officers_util_datetime_4 := 0;
		UNSIGNED4 clean_officers_util_datetime_5 := 0;
	end;
	
	export cfs_dbo_AgencyCfsTypeLookup_In := RECORD
		UNSIGNED2 dataProviderId;
		string50  type;
		UNSIGNED2 visibility;
		string255 agencyType;
		string25  datetime;
		string25  updateDate;
		UNSIGNED4 id;
	end;	
	
	export crash_dbo_crash_In	:=	RECORD
		UNSIGNED4 	id;
		UNSIGNED4		ori;
		string100		case_number;
		string100		reportNumber;
		string25		report_date;
		string	  	address;
		string100		county;
		string100		crash_city;
		string100		crash_state;
		string100  	coordinate;
		real8				x;
		real8				y;
		string1			hitAndRun;
		string1			intersectionRelated;
		string100		officerName;
		string			crashType;
		string			locationType;
		string			accidentClass;
		string			specialCircumstance1;
		string			specialCircumstance2;
		string			specialCircumstance3;
		string			lightCondition;
		string			weatherCondition;
		string			surfaceType;
		string			roadSpecialFeature1;
		string			roadSpecialFeature2;
		string			roadSpecialFeature3;
		string			surfaceCondition;
		string			trafficControlPresent;
		string 			narrative;
		string1  		quarantined;
		UNSIGNED2  	crash_import_id;
		string182  	address_clean := '';		
	end;
	
	export crash_dbo_crash_Base := record
		crash_dbo_crash_In;
		src_and_date;
		UNSIGNED4 clean_report_date := 0;
	end;

	export crash_dbo_person_In := RECORD
		UNSIGNED4   per_id;
		UNSIGNED4   per_crashId;
		UNSIGNED4   vehicleId;
		string1    	driver;
		string100  	first_name;
		string100   last_name;
		string100   licenseNumber;
		string100   licenseState;
		string50   	race;
		string10    sex;
		string100   per_city;
		string25    per_state;
		UNSIGNED2   age;
		string		  driverActions;
		string100  	airbag;
		string100  	seatbelt;
		UNSIGNED4   agency_person_id;
		UNSIGNED5   per_crash_import_id;
		UNSIGNED4		ori;
		string100		case_number;
	end;
	
	export crash_dbo_person_Base := record
		crash_dbo_person_In;
		src_and_date;
	end;

	export crash_dbo_vehicle_In := RECORD
		UNSIGNED4    veh_id;
		UNSIGNED4    veh_crashId;
		string100    vin;
		string100    plate;
		string100    plateState;
		string100    year;
		string100    make;
		string100    model;
		string1      towed;
		string	     vehicle_type;
		string	     damage;
		string	     action;
		string	     sequence;
		string	     driverImpairment;
		string128		 agency_vehicle_id;
		UNSIGNED5		 veh_crash_import_id;
		UNSIGNED4		 ori;
		string100		 case_number;
	end;
	
	export crash_dbo_vehicle_Base := record
			crash_dbo_vehicle_In;
			src_and_date;  
	end;
	
	export event_dbo_mo_In := RECORD
		UNSIGNED5    recordID_RAIDS;
		string100    IR_Number;
		string		   Crime;
		string     	 Location_Type;
		string       Object_of_Attack_1;
		string       Object_of_Attack_2;
		string       Point_of_Entry_1;
		string       Point_of_Entry_2;
		string		   Method_of_Entry_1;
		string		   Method_of_Entry_2;
		string		   Suspects_Actions_Against_Person_1;
		string		   Suspects_Actions_Against_Person_2;
		string		   Suspects_Actions_Against_Person_3;
		string		   Suspects_Actions_Against_Person_4;
		string		   Suspects_Actions_Against_Person_5;
		string		   Suspects_Actions_Against_Property_1;
		string		   Suspects_Actions_Against_Property_2;
		string		   Suspects_Actions_Against_Property_3;
		string		   Property_Taken_1;
		string		   Property_Taken_2;
		string		   Property_Taken_3;
		string15     Property_Value;
		string		   Weapon_Type_1;
		string		   Weapon_Type_2;
		string		   Method_of_Departure;
		string25     First_Date;
		string25     Last_Date;
		string25     First_Date_Time;
		string25     Last_Date_Time;
		integer4     Duration;
		integer4     Sequence;
		string6      First_Day;
		real8        Interval;
		string6      Last_Day;
		string		   Address_of_Crime;		
		string		   Address_Name;
		string		   Beat;
		string		   RD;
		string		 	 Synopsis_of_Crime;
		string10     companions;
		string16     APT;
		string       Trend;
		integer      Commonalities;
		string1      Marked;
		unsigned4    MOSTAMP;
		real8     	 T_Coordinate;
		real8        X_Coordinate;
		real8        Y_Coordinate;
		string25     Edit_Date;
		string       Agency;
		unsigned1    Accuracy_code;
		UNSIGNED4    UCR_Group;
		UNSIGNED4    ORI;
		string1      Geocoded;
		string1      Raids;
		real8     	 X_Offset;
		real8     	 Y_Offset;
		real8     	 Projected_X;
		real8     	 Projected_Y;
		integer      Citizen_Observer_ID;
		string1      Quarantined;
		string       Public_Address;
		UNSIGNED2    group_id;
		string25     RAIDS_activityDate;
		UNSIGNED4    incidentID;
		UNSIGNED2    First_Time;
		UNSIGNED2    Last_Time;
		UNSIGNED5    import_instance_id;
		string       Public_Synopsis;
		string1      LE_Only;
		string25     Report_Date;
		string50		 coordinate;
		string182	   Address_of_Crime_Clean := '';
   END;
	 
	export event_dbo_mo_Base := record
		event_dbo_mo_In;
		src_and_date;
		UNSIGNED4 clean_First_Date_Time := 0;	
		UNSIGNED4 clean_Last_Date_Time := 0;
		UNSIGNED4 clean_First_Date := 0;
		UNSIGNED4 clean_Last_Date := 0;	
		UNSIGNED4 clean_Edit_Date := 0;
		UNSIGNED4 clean_Report_Date := 0;
		UNSIGNED4 clean_RAIDS_activityDate := 0;
	end;

	export event_dbo_mo_udf_In := RECORD
		UNSIGNED5	id;
		UNSIGNED5	recordID_RAIDS;
		UNSIGNED4	ORI;
		UNSIGNED2	fieldId;
		string		string_val;
		integer		integer_val;
		real8			decimal_val;
		string25	datetime_val;
		string1 	yes_no_val;
		string100 IR_Number;
		string 		crime;
	end;
	
	export event_dbo_mo_udf_Base := RECORD
		event_dbo_mo_udf_In;
		src_and_date;
		UNSIGNED4 clean_datetime_val := 0;
	end;
	
	export mo_udf_Base := RECORD
		string23 	eid 	:= '';
		unsigned8	crime	:= 0;
		event_dbo_mo_udf_In - [crime, IR_Number];
		src_and_date;
		UNSIGNED4 clean_datetime_val := 0;
		unsigned6 ts;
	end;
	
	export event_dbo_mo_udf_Key := RECORD
		UNSIGNED5	id;
		UNSIGNED5	recordID_RAIDS;
		UNSIGNED4	ORI;
		UNSIGNED2	fieldId;
		string510	string_val;
		integer		integer_val;
		real8			decimal_val;
		string25	datetime_val;
		string1 	yes_no_val;
	end;
	
	export mudfv2_Key := RECORD
		UNSIGNED4	data_provider_id;
		string23 	eid 	:= '';
		UNSIGNED4	stamp;
		string 		moudf1			:='';
		string 		moudf2			:='';
		string 		moudf3			:='';
		string 		moudf4			:='';
		string 		moudf5			:='';
		string 		moudf6			:='';
		string 		moudf7			:='';
		string 		moudf8			:='';
		unsigned1 udf1_type; // 1-string, 2-integer, 3-decimal, 4-date, 5-boolean
		unsigned1 udf2_type;
		unsigned1 udf3_type;
		unsigned1 udf4_type;
		unsigned1 udf5_type;
		unsigned1 udf6_type;
		unsigned1 udf7_type;
		unsigned1 udf8_type;
	end;
	
	export event_dbo_persons_In := RECORD
		UNSIGNED5    recordID_RAIDS;
		string100    ir_number;
		unsigned4    personstamp;
		string       name_type;
		string       last_name;
		string       first_name;
		string       middle_name;
		string       moniker;
		string       persons_address;
		string25     dob;
		string     	 race;
		string     	 sex;
		string     	 hair;
		string     	 hair_length;
		string    	 eyes;
		string     	 hand_use;
		string     	 speech;
		string     	 teeth;
		string     	 physical_condition;
		string     	 build;
		string     	 complexion;
		string     	 facial_hair;
		string     	 hat;
		string     	 mask;
		string     	 glasses;
		string     	 appearance;
		string     	 shirt;
		string     	 pants;
		string     	 shoes;
		string     	 jacket;
		string128    soundex;
		string  		 persons_notes;
		UNSIGNED2    weight_1;
		UNSIGNED2    weight_2;
		UNSIGNED2    height_1;
		UNSIGNED2    height_2;
		UNSIGNED2    age_1;
		UNSIGNED2    age_2;
		string       persons_sid;
		string  		 picture;
		string       facial_recognition;
		real8     	 persons_x_coordinate;
		real8     	 persons_y_coordinate;
		real8     	 persons_x_projected;
		real8     	 persons_y_projected;
		unsigned1    persons_accuracy_code;
		string1      persons_geocoded;
		string25     edit_date;
		UNSIGNED4    ori;
		string1      quarantined;
		integer4     mo_relationship;
		UNSIGNED4    group_id;
		string25     RAIDS_activityDate;
		UNSIGNED4    import_instance_id;
		string182    persons_address_clean := '';
	END;

	export event_dbo_persons_Base := record
		event_dbo_persons_In;
		src_and_date;
		string10  clean_dob;
		UNSIGNED4 clean_edit_date := 0;
		UNSIGNED4 clean_RAIDS_activityDate := 0;
	end;
	
	export event_dbo_persons_udf_In := RECORD
		UNSIGNED4	id;
		UNSIGNED5	recordID_RAIDS;
		UNSIGNED4	ORI;
		UNSIGNED2	fieldId;
		string		string_val;
		integer		integer_val;
		real8			decimal_val;
		string25	datetime_val;
		string1 	yes_no_val;
		string100 IR_Number;
	end;
	
	export event_dbo_persons_udf_Base := record
		event_dbo_persons_udf_In;
		src_and_date;
		UNSIGNED4 clean_datetime_val := 0;
	end;
	
	export persons_udf_Base := record
		string23 	eid := '';
		event_dbo_persons_udf_In - [IR_Number];
		src_and_date;
		UNSIGNED4 clean_datetime_val := 0;
		unsigned6 ts;
	end;

	export event_dbo_persons_udf_Key := record		
		unsigned5 recordid_raids;
		unsigned4 ori;
		unsigned4 id;
		unsigned2 fieldid;
		string150 string_val;
		integer8 integer_val;
		real8 decimal_val;
		string25 datetime_val;
		string1 yes_no_val;
	end;
	
	export pudfv2_Key := RECORD
		UNSIGNED4	data_provider_id;
		string23 	eid 	:= '';
		UNSIGNED4	stamp;
		string 		personudf1	:='';
		string 		personudf2	:='';
		string 		personudf3	:='';
		string 		personudf4	:='';
		unsigned1 personudf1_type; // 1-string, 2-integer, 3-decimal, 4-date, 5-boolean
		unsigned1 personudf2_type; 
		unsigned1 personudf3_type; 
		unsigned1 personudf4_type; 
	end;
	
	export event_dbo_vehicle_In := RECORD
		UNSIGNED5    recordID_RAIDS;
		string100    ir_number;
		unsigned4    vehiclestamp;
		string16     plate;
		string       plate_state;
		string    	 make;
		string   	   model;
		string     	 style;
		string     	 color;
		string100    year;
		string    	 type;
		string     	 vehicle_status;
		string	  	 vehicle_address;
		string       description;
		real8     	 vehicle_x_coordinate;
		real8     	 vehicle_y_coordinate;
		real8     	 vehicle_x_projected;
		real8     	 vehicle_y_projected;
		unsigned1    vehicle_accuracy_code;
		string1      vehicle_geocoded;
		string25     edit_date;
		UNSIGNED4    ori;
		string1      quarantined;
		integer4     person_relationship;
		UNSIGNED4    group_id;
		string25     RAIDS_activityDate;
		UNSIGNED4    import_instance_id;
		string182  	 vehicle_address_clean := '';
	END;
		
	export event_dbo_vehicle_Base := record
		event_dbo_vehicle_In;
		src_and_date;
		UNSIGNED4 clean_edit_date := 0;
		UNSIGNED4 clean_RAIDS_activityDate := 0;
  end;
	
	export event_dbo_AgencyCrimeTypeLookup_In := RECORD
		UNSIGNED2 dataProviderId;
		string50 	type;
		UNSIGNED2 visibility;
		UNSIGNED2 offsetType;
		string255 crime;
		string25  activityDate;
		UNSIGNED4 id;
		string25  updateDate;
		string50	updateStatus;
	end;
			
	export event_dbo_data_provider_In := RECORD
		UNSIGNED4    data_provider_id;
		string50     data_provider_ori;
		string	     data_provider_name;
		unsigned4    records_uploaded;
		unsigned4    records_approved;
		unsigned4    flagged_records;
		unsigned4    geocode_google;
		unsigned4    geocode_provider;
		string       url;
		string	     phone_number;
		string	     contact_name;
		string25     last_upload;
		string25     first_date;
		string25     last_date;
		string   		 custom_html;
		string1      uploadWarning;
		unsigned4    daysProvided;
		unsigned4    agencyTypeID;
		real8     	 X_Offset_Min;
		real8     	 X_Offset_Max;
		real8     	 Y_Offset_Min;
		real8     	 Y_Offset_Max;
		string1      sheriff;
		string    	 infoWindowMessage;
		unsigned4    minZoomLevel;
		string1      offenseMode;
		string1      cfsMode;
		string1      useInitialCfsType;
		unsigned4  	 max_sessions;
	END;
	
	export event_dbo_data_provider_Base := RECORD
		event_dbo_data_provider_In;
		src_and_date;
		UNSIGNED4  clean_last_upload := 0;		
		UNSIGNED4  clean_first_date := 0;
		UNSIGNED4  clean_last_date := 0;
		string10 	 clean_phone_number;
	end;
		
	export event_dbo_data_provider_Key := RECORD
		UNSIGNED4    data_provider_id;
		string50     data_provider_ori;
		string200    data_provider_name;
		integer      records_uploaded;
		integer      records_approved;
		integer      flagged_records;
		integer      geocode_google;
		integer      geocode_provider;
		string200    url;
		string20     phone_number;
		string50     contact_name;
		string25     last_upload;
		string25     first_date;
		string25     last_date;
		string200		 custom_html;
		string1      uploadWarning;
		integer      daysProvided;
		integer      agencyTypeID;
		real8     	 X_Offset_Min;
		real8     	 X_Offset_Max;
		real8     	 Y_Offset_Min;
		real8     	 Y_Offset_Max;
		string1      sheriff;
		string255    infoWindowMessage;
		integer	     minZoomLevel;
		string1      offenseMode;
		string1      cfsMode;
		string1      useInitialCfsType;
		integer    	 max_sessions;
	end;

	export event_dbo_data_provider_location_In := RECORD
		UNSIGNED4    dataProviderID;
		string50     address;
		real8     	 latitude;
		real8     	 longitude;
		string50     city;
		string5      state;
		string50     zip;
		real8     	 boundingBoxSouthWestLat;
		real8     	 boundingBoxSouthWestLong;
		real8     	 boundingBoxNorthEastLat;
		real8     	 boundingBoxNorthEastLong;
	END;
	
	export event_dbo_data_provider_import_In := RECORD
		UNSIGNED4    dataProviderID;
		string50     authenticationKey;
		string150    reportEmail;
		UNSIGNED1    importType;
		UNSIGNED2    citizenObserverID;
		UNSIGNED1    multipleCities;
		string250    projectionName;
		UNSIGNED1    active;
	END;

	export lpr_dbo_LicensePlate_In := RECORD
		string		LicensePlateRecordGUID;
		string100 EventNumber;
		string25  CaptureDateTime;
		string40  Plate;
		string40  PlateAlternate;
		integer   Confidence;
		string    PlateImage;
		string    OverviewImage;
		real8     X_Coordinate;
		real8 		Y_Coordinate;
		string50  coordinate;
		UNSIGNED4 ORI;
		boolean		base64	:= FALSE;
	end;
	
	export lpr_dbo_LicensePlate_Base := RECORD
		lpr_dbo_LicensePlate_In;		
		src_and_date;
		UNSIGNED4  clean_CaptureDateTime := 0;		
	end;
	
	export lpr_dbo_LicensePlateEvent_Base := RECORD
		string23  eid := '';
		STRING12 	gh12 := '';
		unsigned1 etype; // [1 - EVE, 2 - CFS, 3 - Crash, 4 - Lpr, 5 - Inte, 6 - Shotstopper, 7 - Offenders]
		boolean 	base64 := false;
		
		lpr_dbo_LicensePlate_In - [ori];
		
		// data_provider
		UNSIGNED4  data_provider_id;
		string50   data_provider_ori;
		string200  data_provider_name;
		
		src_and_date;
		UNSIGNED4  clean_CaptureDateTime := 0;
		unsigned6 ts;		
	END;
	
	export lpr_dbo_LicensePlateEvent_Key := RECORD
		string23 	eid := '';
		STRING12 	gh12 := '';
		unsigned1 etype; // [1 - EVE, 2 - CFS, 3 - Crash, 4 - Lpr, 5 - Inte, 6 - Shotstopper, 7 - Offenders]
		string100 LicensePlateRecordGUID;
		string100 EventNumber ;
		string25  CaptureDateTime;
		string40  Plate;
		string40  PlateAlternate;
		integer   Confidence;
		real8     X_Coordinate;
		real8 		Y_Coordinate;
		string50  coordinate;
		
		//data_provider
		UNSIGNED4  data_provider_id;
		string50   data_provider_ori;
		string200  data_provider_name;
		
		boolean 	 has_image;
	end;
	
	export lpr_dbo_nightlylprdeletes_In := RECORD
		string100 LicensePlateRecordGUID;
	end;	
	
	export Intel_dbo_entity_In := RECORD
		UNSIGNED2 entity_id;
		UNSIGNED2 incident_id;
		string100 name_type;
		string100 first_name;
		string100 middle_name;
		string100 last_name;
		string100 moniker;
		string100 ssn;
		string25  dob;
		string10  sex;
		string50  race;
		string100 ethnicity;
		string100 country_of_origin;
		string100 height;
		string100 weight;
		string100 eye_color;
		string100 hair_color;
		string100 hair_style;
		string100 facial_hair;
		string100 tattoo_text_1;
		string100 tattoo_location_1;
		string100 tattoo_text_2;
		string100 tattoo_location_2;
		string100 occupation;
		string	  place_of_employment;
		string100 entity_address;
		string100 entity_city;
		string100 entity_state;
		string100 entity_zip;
		real8     person_x;
		real8     person_y;
		string100 phone_number;
		string100 phone_type;
		string100 email_address;
		string100 social_media_type_1;
		string100 user_name_site_1;
		string100 social_media_type_2;
		string100 user_name_site_2;
		string100 social_media_type_3;
		string100 user_name_site_3;
		string100 social_media_type_4;
		string100 user_name_site_4;
		string100 organization_type;
		string100 organization_sub_type;
		string100 organization_name;
		string100 number_of_members;
		string100 organization_rank_role;
		string100 entity_source_type;
		string100 source_reliability;
		string100 entity_content_validity;
		integer   entity_source_score;
		string25  entity_entry_date;
		string25  entity_purge_date;
		string50  vehicle_type;
		string100 vehicle_make;
		string100 vehicle_model;
		string50  vehicle_color;
		unsigned4 vehicle_year;
		string100 vehicle_plate;
		string50  vehicle_plate_state;
		UNSIGNED4 vehicle_notes_id;
		UNSIGNED4 entity_photo_id;
		UNSIGNED4 entity_notes_id;
		UNSIGNED2 priority;
		string50	vehicle_color_secondary:='';
		string17	vehicle_vin:='';
		string182 entity_address_clean := '';
	end;
	
	export Intel_dbo_entity_Base := RECORD
		Intel_dbo_entity_In;
		src_and_date;
		UNSIGNED4 clean_entity_entry_date := 0;
		UNSIGNED4 clean_entity_purge_date := 0;
		string10  clean_dob;
	end;

	export Intel_dbo_entity_notes_In := RECORD
		UNSIGNED2 id;
		string    entity_notes;
	end;
	export Intel_dbo_entity_notes_Base := RECORD
		Intel_dbo_entity_notes_In;
		src_and_date;
	end;
	
	export Intel_dbo_entity_photo_In := RECORD
			UNSIGNED2 id;
			string photo;
	end;
	
	export Intel_dbo_entity_photo_Base := RECORD
		Intel_dbo_entity_photo_In;
		src_and_date;
	end;
	
	export Intel_dbo_incident_In := RECORD
		UNSIGNED2 id;
		string100 case_number;
		string100	call_case_number;
		string25 	incident_date;
		UNSIGNED2	incident_time;
		UNSIGNED2 reporting_officer_id;
		string50 	incident_type;
		string100 incident_address;
		string50 	incident_city;
		string50 	incident_state;
		string50 	incident_zip;
		real8 		x;
		real8 		y;
		string100 address_name;
		string100 location_type;
		string50 	source_relaiability;
		string50 	incident_content_validity;
		string50 	source_type;
		UNSIGNED2	incident_source_score;
		string25 	incident_entry_date;
		string25 	incident_purge_date;
		UNSIGNED4	notes_id;
		UNSIGNED4 dataProviderId;
		real8 		coordinate;
		string25 	update_date :='';
		string25	purgedate_computed:='';
		string		duration_since:='';
		string182 incident_address_clean := '';
	end;
	
	export Intel_dbo_incident_Base := RECORD
		Intel_dbo_incident_In;
		src_and_date;
		UNSIGNED4 clean_incident_entry_date := 0;
		UNSIGNED4 clean_incident_purge_date := 0;
		UNSIGNED4 clean_incident_date := 0;
	end;
	
	export Intel_dbo_incident_notes_In := RECORD
		UNSIGNED2 id;
		string    incident_notes;
	end;
	
	export Intel_dbo_incident_notes_Base := RECORD
		Intel_dbo_incident_notes_In;
		src_and_date;
	end;
	
	export Intel_dbo_reporting_officer_In := RECORD
		UNSIGNED2 id;
		string50  reporting_officer_first_name;
		string50  reporting_officer_last_name;
	end;
	
	export Intel_dbo_reporting_officer_Base := RECORD
		Intel_dbo_reporting_officer_In;
		src_and_date;
	end;
	
	export Intel_dbo_vehicle_notes_In := RECORD
			UNSIGNED2 id;
			string    vehicle_notes;
	end;
	
	export Intel_dbo_vehicle_notes_Base := RECORD
		Intel_dbo_vehicle_notes_In;
		src_and_date;
	end;
	
	export Offenders_dbo_classification_In := RECORD
		string8  classification_code;
		string96 classification_description;
		string 	 classification_guid;
	end;
	
	export Offenders_dbo_classification_Base := RECORD
		Offenders_dbo_classification_In;
		src_and_date;
	end;
	
	export Offenders_dbo_offender_In := RECORD
		string	    id;
		UNSIGNED4   ori;
		string64    agency_offender_id;
		string64    name_type;
		string64    last_name;
		string64    first_name;
		string64    middle_name;
		string104   moniker;
		string   		address;
		real8 			x_coordinate;
		real8 			y_coordinate;
		string50 	  coordinate;
		string25    dob;
		string30    race;
		string12    sex;
		string30    hair;
		string30   	hair_length;
		string30    eyes;
		string12    hand_use;
		string30    speech;
		string30    teeth;
		string64    physical_condition;
		string64    build;
		string30    complexion;
		string30    facial_hair;
		string64    hat;
		string64    mask;
		string64    glasses;
		string64    appearance;
		string64    shirt;
		string64    pants;
		string64    shoes;
		string64    jacket;
		string128   soundex;
		UNSIGNED3   weight_1;
		UNSIGNED3   weight_2;
		UNSIGNED3   height_1;
		UNSIGNED3   height_2;
		INTEGER2    age_1;
		INTEGER2    age_2;
		string64    Offenders_sid;
		string24 		dl_number;
		string24 		dl_state;
		string24 		fbi_number;
		string      picture;
		string      offender_notes;
		string25    edit_date;
		string1   	quarantined;
		UNSIGNED2   group_id;
		real8 			BAIR_score;
		string25    RAIDS_activityDate;
		UNSIGNED2   import_instance_id;
		string96    admin_State;
		string96   	agency_Name;
		string		 	user_text_1;
		string		 	user_text_2;
		UNSIGNED2	  user_integer;
		real8	  		user_float;
		string25	  user_datetime;		
		string182		address_clean := '';
	end;
	
	export Offenders_dbo_offender_Base := RECORD
		Offenders_dbo_offender_In;
		src_and_date;
		string10  clean_dob;
		UNSIGNED4 clean_RAIDS_activityDate := 0;
		UNSIGNED4 clean_edit_date := 0;
		UNSIGNED4	clean_user_datetime := 0;
	end;

	
	export Offenders_dbo_offender_classification_In := RECORD
		string 		id;
		string 		offender_id;
		string8  	classification;
		string64 	agency_category;
		string64 	agency_level;
		string64 	agency_score;
		string100	case_reference_number;
		string		charge_offense;
		string64  probation_type;
		string128 probation_officer;
		string64  warrant_type;
		string64  warrant_number;
		string64  gang_name;
		string64  gang_role;
		string25  classification_date;
		string25  expiration_date;
		UNSIGNED4 ori;
		string64  agency_offender_id;
	end;
	
	export Offenders_dbo_offender_classification_Base := RECORD
		Offenders_dbo_offender_classification_In;
		src_and_date;
		UNSIGNED4 clean_classification_date := 0;
		UNSIGNED4 clean_expiration_date := 0;
	end;
	
	export Offenders_dbo_offender_picture_In := RECORD
		string 		id;
		string 		offender_id;
		string  	picture_image;
		string16 	where_displayed;
		UNSIGNED4 ori;
		string64  agency_offender_id;
	end;
	
	export Offenders_dbo_offender_picture_Base := RECORD
		Offenders_dbo_offender_picture_In;
		src_and_date;
	end;
 	
	export dbo_cfs_Base := record
		string23	 	 eid := '';
		STRING12 		 gh12 := '';
		unsigned1 	 etype; // [1 - EVE, 2 - CFS, 3 - Crash, 4 - Lpr, 5 - Inte, 6 - Shotstopper, 7 - Offenders]
		string20     accuracy;
		cfs_dbo_cfs_2_Base;
		cfs_dbo_cfs_officers_2_Base - {src_and_date};
		
		UNSIGNED4    data_provider_id;
		string50     data_provider_ori;
		string200    data_provider_name;		
		unsigned8 	 lexid:=0;
		unsigned1 	 lexid_score:=0;
 
		unsigned2 	 xadl2_Weight:=0;
		unsigned2 	 xadl2_Score:=0; 
		unsigned4 	 xadl2_keys_used:=0; // A bitmap of the keys used
		unsigned2 	 xadl2_distance:=0; 
		string20 		 xadl2_matches:=''; // Indicator of what fields contributed to the DID match.
 
		UNSIGNED6 	 bdid:=0;
		UNSIGNED1 	 bdid_score := 0;
		BIPV2.IDlayouts.l_xlink_ids;
		unsigned6 	 ts;
	end;
	
	export dbo_cfs_Key := record
		string23	 	 eid := '';
		STRING12 		 gh12 := '';
		unsigned1 	 etype; // [1 - EVE, 2 - CFS, 3 - Crash, 4 - Lpr, 5 - Inte, 6 - Shotstopper, 7 - Offenders]
		UNSIGNED4    cfs_id;
		UNSIGNED4    ori;
		string100    event_number;
		string25     edit_date;
		string30     report_number;
		string100    caller_address;	
		string100    address;
		string100    place_name;
		string50   	 location_type;
		string30     district;
		string30     beat;
		string510    rd;
		string50     how_received;
		string50     initial_type;
		string50     final_type;
		string30     disposition;
		string30     priority1;
		string25     date_occurred;
		string25     date_time_received;
		string1	     report_flag;
		string50     event_relationship;
		string25     date_time_archived;
		string30     incident_code;
		string150    incident_progress;
		string50     city;
		string50     call_taker;
		string50     contacting_officer;
		string50     complainant;
		string30     current_phone;
		string100    complainant_address;
		string50     status;
		string30     apartment_number;
		real8        total_minutes_on_call;
		real8     	 x_coordinate;
		real8     	 y_coordinate;
		real8     	 projected_x_coordinate;
		real8     	 projected_y_coordinate;
		string1      geocoded;
		unsigned1    accuracy_code;
		string20     accuracy;
		real8     	 complainant_x_coordinate;
		real8     	 complainant_y_coordinate;
		real8     	 complainant_projected_x_coordinate;
		real8     	 complainant_projected_y_coordinate;
		string1      complainant_geocoded;
		unsigned1    complainant_accuracy;
		string1      quarantined;
		UNSIGNED2    group_id;
		UNSIGNED4    import_instance_id;
		UNSIGNED4    initial_ucr_group;
		UNSIGNED4    final_ucr_group;
		string20		 coordinate;
		
		//cfs_2_officers
		UNSIGNED4    cfs_officers_id;
		string25     date_time_dispatched;
		string25     date_time_enroute;
		string25     date_time_arrived;
		string25     date_time_cleared;
		real8        minutes_on_call;
		real8        minutes_response;
		string30     unit;
		string50     officer_name;
		string1      primary_officer;
		
		//data_provider
		UNSIGNED4    data_provider_id;
		string50     data_provider_ori;
		string200    data_provider_name;
		
		unsigned8 	 lexid := 0;
	end;
		
	export dbo_intel_Base := record
		string23  eid := '';
		STRING12 	gh12 := '';
		unsigned1 etype; // [1 - EVE, 2 - CFS, 3 - Crash, 4 - Lpr, 5 - Inte, 6 - Shotstopper, 7 - Offenders]
		
		Intel_dbo_entity_In - [entity_id];
		Intel_dbo_entity_notes_In;
		Intel_dbo_entity_photo_In - [id];
		Intel_dbo_incident_In - [id, dataProviderId];
		Intel_dbo_incident_notes_In - [id];
		Intel_dbo_reporting_officer_In - [id];
		Intel_dbo_vehicle_notes_In - [id];
		
		// data_provider_id
		UNSIGNED4    data_provider_id;
		string50     data_provider_ori;
		string200    data_provider_name;
				
		src_and_date;
		UNSIGNED4 clean_entity_entry_date := 0;
		UNSIGNED4 clean_entity_purge_date := 0;
		UNSIGNED4 clean_incident_entry_date := 0;
		UNSIGNED4 clean_incident_purge_date := 0;
		UNSIGNED4 clean_incident_date := 0;
		string10  clean_dob;
		string10 	clean_phone_number;
		unsigned6 ts;
	end;
	 
	export dbo_intel_Key := record
		string23 	eid := '';
		STRING12 	gh12 := '';
		unsigned1 etype; // [1 - EVE, 2 - CFS, 3 - Crash, 4 - Lpr, 5 - Inte, 6 - Shotstopper, 7 - Offenders]
		UNSIGNED2 id;
		UNSIGNED2 incident_id;
		string20  name_type;
		string50  first_name;
		string50  middle_name;
		string50  last_name;
		string100 moniker;
		string20  ssn;
		string25  dob;
		string10  sex;
		string50  race;
		string20  ethnicity;
		string20  country_of_origin;
		string10  height;
		string10  weight;
		string20  eye_color;
		string20  hair_color;
		string20  hair_style;
		string20  facial_hair;
		string100 tattoo_text_1;
		string100 tattoo_location_1;
		string100 tattoo_text_2;
		string100 tattoo_location_2;
		string100 occupation;
		string150 place_of_employment;
		string100 entity_address;
		string20  entity_city;
		string20  entity_state;
		string20  entity_zip;
		real8     person_x;
		real8     person_y;
		string20  phone_number;
		string10  phone_type;
		string50  email_address;
		string100 social_media_type_1;
		string100 user_name_site_1;
		string100 social_media_type_2;
		string100 user_name_site_2;
		string100 social_media_type_3;
		string100 user_name_site_3;
		string100 social_media_type_4;
		string100 user_name_site_4;
		string10  organization_type;
		string10  organization_sub_type;
		string50  organization_name;
		string10  number_of_members;
		string100 organization_rank_role;
		string20  entity_source_type;
		string100 source_reliability;
		string100 entity_content_validity;
		integer   entity_source_score;
		string25  entity_entry_date;
		string25  entity_purge_date;
		string20  vehicle_type;
		string50  vehicle_make;
		string50  vehicle_model;
		string20  vehicle_color;
		integer   vehicle_year;
		string100 vehicle_plate;
		string30  vehicle_plate_state;
		UNSIGNED4 vehicle_notes_id;
		UNSIGNED4 entity_photo_id;
		UNSIGNED4 entity_notes_id;
		UNSIGNED2 priority;

		string100 photo := '';

		string20 	case_number;
		string20 	call_case_number;
		string25 	incident_date;
		UNSIGNED2	incident_time;
		INTEGER2  reporting_officer_id;
		string50 	incident_type;
		string100 incident_address;
		string25 	incident_city;
		string25 	incident_state;
		string25 	incident_zip;
		real8 		x;
		real8 		y;
		string50 	address_name;
		string50 	location_type;
		string50 	source_relaiability;
		string50 	incident_content_validity;
		string50 	source_type;
		INTEGER2 	incident_source_score;
		string25 	incident_entry_date;
		string25 	incident_purge_date;
		UNSIGNED2	notes_id;
		real8 		coordinate;
		
		string50  reporting_officer_first_name;
		string50  reporting_officer_last_name;
		
		//data_provider_id
		UNSIGNED4    data_provider_id;
		string50     data_provider_ori;
		string200    data_provider_name;
	END;
	
	export dbo_offenders_Base := record
		string23 		eid := '';
		STRING12 		gh12 := '';
		unsigned1 	etype; // [1 - EVE, 2 - CFS, 3 - Crash, 4 - Lpr, 5 - Inte, 6 - Shotstopper, 7 - Offenders]
		
		Offenders_dbo_offender_In - [ori];
		Offenders_dbo_classification_In;
		Offenders_dbo_offender_classification_In - [ori, offender_id, agency_offender_id];
	
		// data_provider
		UNSIGNED4   data_provider_id;
		string50    data_provider_ori;
		string200   data_provider_name;
		
		src_and_date;
		
		string10  	clean_dob;
		UNSIGNED4 	clean_RAIDS_activityDate := 0;
		UNSIGNED4 	clean_edit_date := 0;
		UNSIGNED4		clean_user_datetime := 0;
		unsigned4 	clean_classification_date := 0;
		unsigned4 	clean_expiration_date := 0;
		
		unsigned8 	lexid:=0;
		unsigned1 	lexid_score:=0;
 
		unsigned2 	xadl2_Weight:=0;
		unsigned2 	xadl2_Score:=0; 
		unsigned4 	xadl2_keys_used:=0; // A bitmap of the keys used
		unsigned2 	xadl2_distance:=0; 
		string20 		xadl2_matches:=''; // Indicator of what fields contributed to the DID match.
 
		UNSIGNED6 	bdid:=0;
		UNSIGNED1 	bdid_score := 0;
		BIPV2.IDlayouts.l_xlink_ids;
		
		unsigned6   ts;
	end;
		
	export dbo_offenders_Key := record
		string23 		eid := '';
		STRING12 		gh12 := '';
		unsigned1 	etype; // [1 - EVE, 2 - CFS, 3 - Crash, 4 - Lpr, 5 - Inte, 6 - Shotstopper, 7 - Offenders]
		string      id;
		string64    agency_offender_id;
		string64    name_type;
		string64    last_name;
		string64    first_name;
		string64    middle_name;
		string104   moniker;
		string255   address;
		real8 			x_coordinate;
		real8 			y_coordinate;
		string50 	  coordinate;
		string25    dob;
		string30    race;
		string12    sex;
		string30    hair;
		string20   	hair_length;
		string20    eyes;
		string12    hand_use;
		string30    speech;
		string30    teeth;
		string64    physical_condition;
		string20    build;
		string30    complexion;
		string30    facial_hair;
		string20    hat;
		string20    mask;
		string20    glasses;
		string20    appearance;
		string20    shirt;
		string20    pants;
		string20    shoes;
		string20    jacket;
		string50    soundex;
		UNSIGNED3   weight_1;
		UNSIGNED3   weight_2;
		UNSIGNED3   height_1;
		UNSIGNED3   height_2;
		INTEGER2    age_1;
		INTEGER2    age_2;
		string20    Offenders_sid;
		string24 		dl_number;
		string24 		dl_state;
		string24 		fbi_number;
		string      picture;
		string25    edit_date;
		string1   	quarantined;
		UNSIGNED2   group_id;
		real8 			BAIR_score;
		string25    RAIDS_activityDate;
		UNSIGNED2   import_instance_id;
		string20    admin_State;
		string96   	agency_Name;
		string255 	user_text_1;
		string255 	user_text_2;
		UNSIGNED2	  user_integer;
		real8	  		user_float;
		string25	  user_datetime;		
		
		string8     classification_code;
		string30    classification_description;
		string50    classification_guid;
		
		string8  		classification;
		string64 		agency_category;
		string64 		agency_level;
		string10 		agency_score;
		string75 		case_reference_number;
		string255 	charge_offense;
		string64  	probation_type;
		string50  	probation_officer;
		string64  	warrant_type;
		string64  	warrant_number;
		string64  	gang_name;
		string10  	gang_role;
		string25  	classification_date;
		string25  	expiration_date;
		
		//data_provider
		UNSIGNED4   data_provider_id;
		string50    data_provider_ori;
		string200   data_provider_name;
		
		unsigned8 	lexid := 0;
		
		boolean 		has_image;
	END;
	
	export dbo_offenders_Picture_Base := RECORD
		string23 	eid 	 := '';
		boolean   base64 := false;
		Offenders_dbo_offender_picture_Base - [id, offender_id, ori, agency_offender_id];
		unsigned6 ts;
	end;
	
	export dbo_crash_Base := record
		string23 		eid := '';
		STRING12 		gh12 := '';
		unsigned1 	etype; // [1 - EVE, 2 - CFS, 3 - Crash, 4 - Lpr, 5 - Inte, 6 - Shotstopper, 7 - Offenders]
		
		crash_dbo_crash_In - [ori];
		crash_dbo_person_In - [ori, case_number];
		crash_dbo_vehicle_In - [ori, case_number];
		
		// data_provider
		UNSIGNED4   data_provider_id;
		string50    data_provider_ori;
		string200   data_provider_name;
				
		string1     sourceP;
		string1     sourceV;
				
		src_and_date;
		UNSIGNED4 	clean_report_date;
		
		unsigned8 	lexid:=0;
		unsigned1 	lexid_score:=0;
 
		unsigned2 	xadl2_Weight:=0;
		unsigned2 	xadl2_Score:=0; 
		unsigned4 	xadl2_keys_used:=0; // A bitmap of the keys used
		unsigned2 	xadl2_distance:=0; 
		string20 		xadl2_matches:=''; // Indicator of what fields contributed to the DID match.
 
		UNSIGNED6 	bdid:=0;
		UNSIGNED1 	bdid_score := 0;
		BIPV2.IDlayouts.l_xlink_ids;
		
		unsigned6   ts;
	end;
		
	export dbo_crash_Key := record
		string23 		eid := '';
		STRING12 		gh12 := '';
		unsigned1 	etype; // [1 - EVE, 2 - CFS, 3 - Crash, 4 - Lpr, 5 - Inte, 6 - Shotstopper, 7 - Offenders]
		UNSIGNED4 	id;
		string100		case_number;
		string100		reportNumber;
		string25		report_date;
		string255  	address;
		string20		county;
		string50		crash_city;
		string20		crash_state;
		string50  	coordinate;
		real8				x;
		real8				y;
		string1			hitAndRun;
		string1			intersectionRelated;
		string50		officerName;
		string20		crashType;
		string25		locationType;
		string60		accidentClass;
		string50		specialCircumstance1;
		string50		specialCircumstance2;
		string50		specialCircumstance3;
		string50		lightCondition;
		string50		weatherCondition;
		string50		surfaceType;
		string60		roadSpecialFeature1;
		string60		roadSpecialFeature2;
		string60		roadSpecialFeature3;
		string60		surfaceCondition;
		string150		trafficControlPresent;
		string1  		quarantined;
		UNSIGNED2  	crash_import_id;
		
		UNSIGNED4   per_id;
		UNSIGNED4   per_crashId;
		UNSIGNED4   vehicleId;
		string1    	driver;
		string50   	first_name;
		string50    last_name;
		string50    licenseNumber;
		string20    licenseState;
		string50   	race;
		string10    sex;
		string50    per_city;
		string25    per_state;
		UNSIGNED2   age;
		string150   driverActions;
		string50   	airbag;
		string50   	seatbelt;
		UNSIGNED4   agency_person_id;
		UNSIGNED5   per_crash_import_id;
		
		UNSIGNED4   veh_id;
		UNSIGNED4   veh_crashId;
		string100   vin;
		string100   plate;
		string100   plateState;
		string10    year;
		string50    make;
		string50    model;
		string1     towed;
		string50    vehicle_type;
		string255   damage;
		string255   action;
		string255   sequence;
		string255   driverImpairment;
		string128		agency_vehicle_id;
		UNSIGNED5		veh_crash_import_id;
		
		//data_provider
		UNSIGNED4   data_provider_id;
		string50    data_provider_ori;
		string200   data_provider_name;
				
		string1     sourceP;
		string1     sourceV;
		
		unsigned8 	 lexid := 0;
	END;
 
	export gunop_dbo_shot_In := record
		UNSIGNED2 	raids_record_id;
		UNSIGNED4 	data_provider_id;
		string24	 	shot_id;
		real8 			x_coordinate;
		real8 			y_coordinate;
		string		 	address;
		string50 	  coordinate;
		string    	shot_incident_notes;
		UNSIGNED2  	shots;
		string50		beat;
		string50  	district;
		string50  	shot_source;
		string25		shot_datetime;
		UNSIGNED1  	shot_incident_type;
		string24  	shot_incident_status;
		string182	 	address_clean	:= '';
	end;
	
	export gunop_dbo_shot_Base := record
		gunop_dbo_shot_In;
		src_and_date;
		UNSIGNED4 clean_shot_datetime := 0;
	end;
	
	export gunop_dbo_shot_incident_Base := record
		string23 		eid := '';
		STRING12 		gh12 := '';
		unsigned1 	etype; // [1 - EVE, 2 - CFS, 3 - Crash, 4 - Lpr, 5 - Inte, 6 - Shotstopper, 7 - Offenders]
		gunop_dbo_shot_In - [data_provider_id];
		
		//data_provider
		UNSIGNED4 	 data_provider_id;
		string50     data_provider_ori;
		string200    data_provider_name;
				
		src_and_date;
		UNSIGNED4 	 clean_shot_datetime := 0;
		unsigned6    ts;
	end;
		
	export gunop_dbo_shot_incident_Key := record
		// gunop_dbo_shot_incident_Base - {src_and_date} - [clean_shot_datetime, shot_incident_notes];
		string23 		eid := '';
		STRING12 		gh12 := '';
		unsigned1 	etype; // [1 - EVE, 2 - CFS, 3 - Crash, 4 - Lpr, 5 - Inte, 6 - Shotstopper, 7 - Offenders]
		UNSIGNED2 	raids_record_id;
		string24	 	shot_id;
		real8 			x_coordinate;
		real8 			y_coordinate;
		string100 	address;
		string50 	  coordinate;
		UNSIGNED2  	shots;
		string50		beat;
		string50  	district;
		string50  	shot_source;
		string25		shot_datetime;
		UNSIGNED1  	shot_incident_type;
		string24  	shot_incident_status;
		
		//data_provider
		UNSIGNED4 	 data_provider_id;
		string50     data_provider_ori;
		string200    data_provider_name;
	end;
	
	export event_import_group_access_In := record
		string50 	ORI;
		UNSIGNED2 group_id;
		UNSIGNED1 owner;
		string64 	msrepl_tran_version;
		UNSIGNED2 mode_id;
	end;
	
	export event_import_group_access_Base := record
		event_import_group_access_In;
		src_and_date;
	end;
	
	export event_group_access_Base := record
		event_import_group_access_In;
		src_and_date;
		unsigned4 data_provider_id;
		string50  data_provider_ori;
		string200 data_provider_name;
	END;
	
	export event_group_access_Key := record
		event_group_access_Base - {src_and_date};	
	END;
	
	export dbo_event_mo_final_Base := record
		string23 	   eid 				:= '';
		STRING12 		 gh12 := '';
		unsigned1 	 etype; // [1 - EVE, 2 - CFS, 3 - Crash, 4 - Lpr, 5 - Inte, 6 - Shotstopper, 7 - Offenders]
		string20     accuracy;
		
		event_dbo_mo_Base - {src_and_date};
				
		// data_provider
		UNSIGNED4    data_provider_id;
		string50     data_provider_ori;
		string200    data_provider_name;
	
		// data_provider_loc
		event_dbo_data_provider_location_In - [dataProviderID];
		
		src_and_date;
		unsigned6    ts;
	end;
		
	export dbo_event_mo_final_Key := record
		string23 	   eid := '';
		STRING12 		 gh12 := '';
		unsigned1 	 etype; // [1 - EVE, 2 - CFS, 3 - Crash, 4 - Lpr, 5 - Inte, 6 - Shotstopper, 7 - Offenders]
		UNSIGNED5    recordID_RAIDS;
		string100    IR_Number;
		string100    Crime;
		string30     Location_Type;
		string50     Object_of_Attack_1;
		string50     Object_of_Attack_2;
		string50     Point_of_Entry_1;
		string50     Point_of_Entry_2;
		string50     Method_of_Entry_1;
		string50     Method_of_Entry_2;
		string150    Suspects_Actions_Against_Person_1;
		string150    Suspects_Actions_Against_Person_2;
		string150    Suspects_Actions_Against_Person_3;
		string150    Suspects_Actions_Against_Person_4;
		string150    Suspects_Actions_Against_Person_5;
		string150    Suspects_Actions_Against_Property_1;
		string150    Suspects_Actions_Against_Property_2;
		string150    Suspects_Actions_Against_Property_3;
		string50     Property_Taken_1;
		string50     Property_Taken_2;
		string50     Property_Taken_3;
		string10     Property_Value;
		string50     Weapon_Type_1;
		string50     Weapon_Type_2;
		string100    Method_of_Departure;
		string25     First_Date;
		string25     Last_Date;
		string25     First_Date_Time;
		string25     Last_Date_Time;
		integer      Duration;
		integer      Sequence;
		string6      First_Day;
		real8        Interval;
		string6      Last_Day;
		string100    Address_of_Crime;
		string50     Address_Name;
		string50     Beat;
		string100    RD;
		string10     companions;
		string16     APT;
		string100    Trend;
		integer      Commonalities;
		string1      Marked;
		UNSIGNED4    MOSTAMP;
		real8     	 T_Coordinate;
		real8        X_Coordinate;
		real8        Y_Coordinate;
		string25     Edit_Date;
		string150    Agency;
		unsigned1    accuracy_code;
		string20     accuracy;
		UNSIGNED4    UCR_Group;
		UNSIGNED4    ORI;
		string1      Geocoded;
		string1      Raids;
		real8     	 X_Offset;
		real8     	 Y_Offset;
		real8     	 Projected_X;
		real8     	 Projected_Y;
		integer      Citizen_Observer_ID;
		string1      Quarantined;
		string150    Public_Address;
		UNSIGNED2    group_id;
		string25     RAIDS_activityDate;
		UNSIGNED4    incidentID;
		UNSIGNED2    First_Time;
		UNSIGNED2    Last_Time;
		UNSIGNED5    import_instance_id;
		string150    Public_Synopsis;
		string1      LE_Only;
		string25     Report_Date;
		string50		 coordinate;
				
		//data_provider
		UNSIGNED4    data_provider_id;
		string50     data_provider_ori;
		string200    data_provider_name;
			
		//data_provider_loc
		event_dbo_data_provider_location_In - [dataProviderID];
	end;
	
	export dbo_event_persons_final_Base := record
		string23 	 	 eid 		 		 := '';
		STRING12 		 gh12 := '';
		unsigned1 	 etype; // [1 - EVE, 2 - CFS, 3 - Crash, 4 - Lpr, 5 - Inte, 6 - Shotstopper, 7 - Offenders]
		boolean			 base64 := false;
		
		event_dbo_persons_Base;
		string20     persons_accuracy;
		
		// data_provider
		UNSIGNED4    data_provider_id;
		string50     data_provider_ori;
		string200    data_provider_name;
		
		// data_provider_loc
		string50     address;
		real8     	 latitude;
		real8     	 longitude;
		string50     city;
		string5      state;
		string50     zip;
		real8     	 boundingBoxSouthWestLat;
		real8     	 boundingBoxSouthWestLong;
		real8     	 boundingBoxNorthEastLat;
		real8     	 boundingBoxNorthEastLong;
		
		UNSIGNED4 	 clean_datetime_val := 0;
		
		unsigned8 	 lexid:=0;
		unsigned1 	 lexid_score:=0;
 
		unsigned2 	 xadl2_Weight:=0;
		unsigned2 	 xadl2_Score:=0; 
		unsigned4 	 xadl2_keys_used:=0; // A bitmap of the keys used
		unsigned2 	 xadl2_distance:=0; 
		string20 		 xadl2_matches:=''; // Indicator of what fields contributed to the DID match.
 
		UNSIGNED6 	 bdid:=0;
		UNSIGNED1 	 bdid_score := 0;
		BIPV2.IDlayouts.l_xlink_ids;
		
		unsigned6    ts;
	end;
		
	export dbo_event_persons_final_Key := record
		string23 	 	 eid := '';
		STRING12 		 gh12 := '';
		unsigned1 	 etype; // [1 - EVE, 2 - CFS, 3 - Crash, 4 - Lpr, 5 - Inte, 6 - Shotstopper, 7 - Offenders]
		UNSIGNED5    recordID_RAIDS;
		string50     ir_number;
		UNSIGNED4    personstamp;
		string30     name_type;
		string30     last_name;
		string30     first_name;
		string30     middle_name;
		string100    moniker;
		string100    persons_address;
		string25     dob;
		string25     race;
		string20     sex;
		string20     hair;
		string10     hair_length;
		string20     eyes;
		string20     hand_use;
		string20     speech;
		string20     teeth;
		string50     physical_condition;
		string50     build;
		string30     complexion;
		string20     facial_hair;
		string20     hat;
		string20     mask;
		string20     glasses;
		string20     appearance;
		string20     shirt;
		string20     pants;
		string20     shoes;
		string20     jacket;
		string128    soundex;
		UNSIGNED2    weight_1;
		UNSIGNED2    weight_2;
		UNSIGNED2    height_1;
		UNSIGNED2    height_2;
		UNSIGNED2    age_1;
		UNSIGNED2    age_2;
		string100    persons_sid;
		string  		 picture;
		string50     facial_recognition;
		real8     	 persons_x_coordinate;
		real8     	 persons_y_coordinate;
		real8     	 persons_x_projected;
		real8     	 persons_y_projected;
		unsigned1    persons_accuracy_code;
		string20     persons_accuracy;
		string1      persons_geocoded;
		string25     edit_date;
		UNSIGNED4    ORI;
		string1      quarantined;
		integer      mo_relationship;
		UNSIGNED2    group_id;
		string25     RAIDS_activityDate;
		UNSIGNED4    import_instance_id;	
		
		//data_provider
		UNSIGNED4    data_provider_id;
		string50     data_provider_ori;
		string200    data_provider_name;
				
		//data_provider_loc
		string50     address;
		real8     	 latitude;
		real8     	 longitude;
		string50     city;
		string5      state;
		string50     zip;
		real8     	 boundingBoxSouthWestLat;
		real8     	 boundingBoxSouthWestLong;
		real8     	 boundingBoxNorthEastLat;
		real8     	 boundingBoxNorthEastLong;		
		
		unsigned8 	 lexid := 0;
	end;
	
	export dbo_event_vehicle_final_Base := record
		string23 	   eid := '';
		STRING12 		 gh12 := '';
		unsigned1 	 etype; // [1 - EVE, 2 - CFS, 3 - Crash, 4 - Lpr, 5 - Inte, 6 - Shotstopper, 7 - Offenders]
		
		event_dbo_vehicle_Base;
		string20     vehicle_accuracy;
		
		// data_provider
		UNSIGNED4    data_provider_id;
		string50     data_provider_ori;
		string200    data_provider_name;
			
		// data_provider_loc
		string50     address;
		real8     	 latitude;
		real8     	 longitude;
		string50     city;
		string5      state;
		string50     zip;
		real8     	 boundingBoxSouthWestLat;
		real8     	 boundingBoxSouthWestLong;
		real8     	 boundingBoxNorthEastLat;
		real8     	 boundingBoxNorthEastLong;
		unsigned6    ts;
	end;
	
	export dbo_event_vehicle_final_Key := record
		string23 	 	 eid := '';
		STRING12 		 gh12 := '';
		unsigned1 	 etype; // [1 - EVE, 2 - CFS, 3 - Crash, 4 - Lpr, 5 - Inte, 6 - Shotstopper, 7 - Offenders]
		UNSIGNED5    recordID_RAIDS;
		string50     ir_number;
		UNSIGNED4    vehiclestamp;
		string16     plate;
		string30     plate_state;
		string30     make;
		string30     model;
		string30     style;
		string20     color;
		string10     year;
		string20     type;
		string50     vehicle_status;
		string100    vehicle_address;
		real8     	 vehicle_x_coordinate;
		real8     	 vehicle_y_coordinate;
		real8     	 vehicle_x_projected;
		real8     	 vehicle_y_projected;
		unsigned1    vehicle_accuracy_code;
		string20     vehicle_accuracy;
		string10     vehicle_geocoded;
		string25     edit_date;
		UNSIGNED4    ORI;
		string1      quarantined;
		integer      person_relationship;
		UNSIGNED2    group_id;
		string25     RAIDS_activityDate;
		UNSIGNED4    import_instance_id;
		
		//data_provider
		UNSIGNED4    data_provider_id;
		string50     data_provider_ori;
		string200    data_provider_name;
			
		//data_provider_loc
		string50     address;
		real8     	 latitude;
		real8     	 longitude;
		string50     city;
		string5      state;
		string50     zip;
		real8     	 boundingBoxSouthWestLat;
		real8     	 boundingBoxSouthWestLong;
		real8     	 boundingBoxNorthEastLat;
		real8     	 boundingBoxNorthEastLong;
	end;
	
	export Notes_Base := record,maxlength(150037)
		string23 	eid;
		UNSIGNED4 ReferId;
		unsigned1 Note_Type;
		unsigned1 Seq:=0;
		unsigned4 NoteLen;
		string 		Notes;
	end;
	
	export Images_Base := record,maxlength(150000)
		string23 	eid := '';
		unsigned1 Image_Type := 1;
		unsigned4 ImageLen;
		string    Photo;
	end;
	
	export GeoHashLayout := record
		STRING12 	gh12;
		string11 	longitude;
		string10 	latitude;
		unsigned7	date;		
		string10 	class;
		string10 	ori;
		unsigned1 etype; // [1 - EVE, 2 - CFS, 3 - Crash, 4 - Lpr, 5 - Inte, 6 - Shotstopper, 7 - Offenders]
		unsigned4 stamp;
		string23 	eid;
		unsigned2 group_id := 0;
		boolean   raids := false;
		unsigned1 s0:=0;
		unsigned1 s1:=0;
		unsigned1 s2:=0;
		unsigned1 s3:=0;
		unsigned1 s4:=0;
		unsigned1 s5:=0;
		unsigned1 s6:=0;
		unsigned1 s7:=0;
		unsigned1 s8:=0;
		unsigned1 s9:=0;
		unsigned1 s10:=0;
		unsigned1 s11:=0;
		unsigned1 s12:=0;
		unsigned1 s13:=0;
		unsigned1 s14:=0;
		unsigned1 s15:=0;
		unsigned1 s16:=0;
		unsigned1 s17:=0;
		unsigned1 s18:=0;
		unsigned1 s19:=0;
		unsigned1 s20:=0;
		unsigned1 s21:=0;
		unsigned1 s22:=0;
		unsigned1 s23:=0;
		unsigned1 s24:=0;
		unsigned1 s25:=0;
		unsigned1 s26:=0;
		unsigned1 s27:=0;
		unsigned1 s28:=0;
		unsigned1 s29:=0;
		unsigned1 s30:=0;
		unsigned1 s31:=0;
		unsigned1 s32:=0;
		unsigned1 s33:=0;
		unsigned1 s34:=0;
		unsigned1 s35:=0;
		unsigned1 s36:=0;
		unsigned1 s37:=0;
		unsigned1 s38:=0;
		unsigned1 s39:=0;
		unsigned1 s40:=0;
		unsigned1 s41:=0;
		unsigned1 s42:=0;
		unsigned1 s43:=0;
		unsigned1 s44:=0;
		unsigned1 s45:=0;
		unsigned1 s46:=0;
		unsigned1 s47:=0;
		unsigned1 s48:=0;
		unsigned1 s49:=0;
		unsigned1 s50:=0;
		unsigned1 s51:=0;
		unsigned1 s52:=0;
		unsigned1 s53:=0;
		unsigned1 s54:=0;
		unsigned1 s55:=0;
		unsigned1 s56:=0;
		unsigned1 s57:=0;
		unsigned1 s58:=0;
		unsigned1 s59:=0;
		unsigned1 s60:=0;
		unsigned1 s61:=0;
		unsigned1 s62:=0;
		unsigned1 s63:=0;
		unsigned1 s64:=0;
		unsigned1 s65:=0;
		unsigned1 s66:=0;
		unsigned1 s67:=0;
		unsigned1 s68:=0;
		unsigned1 s69:=0;
		unsigned1 s70:=0;
		unsigned1 s71:=0;
		unsigned1 s72:=0;
		unsigned1 s73:=0;
		unsigned1 s74:=0;
		unsigned1 s75:=0;
		unsigned1 s76:=0;
		unsigned1 s77:=0;
		unsigned1 s78:=0;
		unsigned1 s79:=0;
		unsigned1 s80:=0;
		unsigned1 s81:=0;
		unsigned1 s82:=0;
		unsigned1 s83:=0;
		unsigned1 s84:=0;
		unsigned1 s85:=0;
		unsigned1 s86:=0;
		unsigned1 s87:=0;
		unsigned1 s88:=0;
		unsigned1 s89:=0;
		unsigned1 s90:=0;
		unsigned1 s91:=0;
		unsigned1 s92:=0;
		unsigned1 s93:=0;
		unsigned1 s94:=0;
		unsigned1 s95:=0;
		unsigned1 s96:=0;
		unsigned1 s97:=0;
		unsigned1 s98:=0;
		unsigned1 s99:=0;
	end;	
	
	EXPORT Orbit_Agencies_Layout := RECORD
		STRING 	AgencyName;
		STRING 	BuildName;
		STRING  MemberId;
		STRING  BuildPrefix;
		UNSIGNED4	FilesCount;
	END;	
	
	EXPORT Orbit_Datasets_Layout := RECORD
		STRING 	FileNameID;
		STRING 	OrbitId;
	END;
	
	EXPORT Agency_Deletes := RECORD
		string field1;
		string field2;
		string field3;
	END;
	
	EXPORT Intersection_Coordinates_In :=  RECORD
		unsigned4 	id;
		unsigned4 	dataProviderID;
		real8 			X_Coordinate;
		real8				Y_Coordinate;
		string 			Coordinates;
	END;

	EXPORT ClassificationLayout := RECORD
		unsigned1  mode; //(keyed – 1 for event, 2 for cfs)
		string50   ori; //(keyed)
		unsigned4  ucr_group;
		string255  crime;
		string100  agencyType;
		string25   last_update;
	END;
	
	EXPORT FilesTypeLayout := RECORD
     STRING  fileType;
     BOOLEAN requiredFlag;
  END;
	
	EXPORT BuildVersionLayout := RECORD
     STRING  buildVersion;
  END;

  EXPORT OrbitBuildsLayout := RECORD
     STRING  preppedBuild;
		 STRING  agenciesBuild;
  END;	
	
	EXPORT AddressLookup_In := RECORD
		unsigned4	id;
		unsigned4 dataProviderID;
		string255	address;
		real8			x_coordinate;
		real8			y_coordinate;
		string50	accuracy;
		string1		geocoded;
		string25	edit_date;
		string64	msrepl_tran_version;
	END;
	
	EXPORT AgencyDeletes_Base := RECORD
		string23 eid;
		unsigned6 ts;
	END;

//1 - Payload Base Full, 2 - Payload Key Full, 3 - PS Base Full, 4 - PS Key Full, 5 - Boolean Key Full
	//1 - Payload Base Delta, 2 - Payload Key Delta, 3 - PS Base Delta, 4 - PS Key Delta, 5 - Boolean Key Delta

	EXPORT rBldSegmentStatus := record
		unsigned seg;
		boolean  failed;
	end;
	
	EXPORT FsLogicalSuperSubRecord := RECORD 
		STRING supername{MAXLENGTH(255)};  
		STRING subname{MAXLENGTH(255)}; 
	END;

	EXPORT rFileList := record
		unsigned seg;
		STRING supername{MAXLENGTH(255)};  
		STRING subname{MAXLENGTH(255)}; 
	END;

	EXPORT rBuiltVers := record
		string  Ver;
		string  buildname;
		string  buildtime;
		boolean deployed;
	END;
	
	EXPORT rFlushVers := record
		string  DeltaVer;
		string  FullVer;
		boolean flushed;
	END;
	
	EXPORT rCompositeBase := record
		boolean	cached_addr := false;
		unsigned5 recordid_raids;
		UNSIGNED4 per_id;
		bair_composite.layouts.Base;	
	END;
	
	EXPORT GeoHashLayout_LPR := record
		STRING8 	gh8;	 	//(KEYED)  gh12[1..8]
		unsigned4 yyyymm; //(KEYED)
		string23 	eid; 		//(KEYED)
		string4 	gh4;		//gh12[9..12]
		unsigned7 date;
		string10 	latitude;
		string11 	longitude;
		string10 	ori;
		unsigned2 group_id;
		unsigned4 stamp;
		unsigned1 s0:=0;
		unsigned1 s1:=0;
		unsigned1 s2:=0;
		unsigned1 s3:=0;
		unsigned1 s4:=0;
		unsigned1 s5:=0;
		unsigned1 s6:=0;
		unsigned1 s7:=0;
		unsigned1 s8:=0;
		unsigned1 s9:=0;
		unsigned1 s10:=0;
		unsigned1 s11:=0;
		unsigned1 s12:=0;
		unsigned1 s13:=0;
		unsigned1 s14:=0;
		unsigned1 s15:=0;
		unsigned1 s16:=0;
		unsigned1 s17:=0;
		unsigned1 s18:=0;
		unsigned1 s19:=0;
		unsigned1 s20:=0;
		unsigned1 s21:=0;
		unsigned1 s22:=0;
		unsigned1 s23:=0;
		unsigned1 s24:=0;
		unsigned1 s25:=0;
		unsigned1 s26:=0;
		unsigned1 s27:=0;
		unsigned1 s28:=0;
		unsigned1 s29:=0;
		unsigned1 s30:=0;
		unsigned1 s31:=0;
		unsigned1 s32:=0;
		unsigned1 s33:=0;
		unsigned1 s34:=0;
		unsigned1 s35:=0;
		unsigned1 s36:=0;
		unsigned1 s37:=0;
		unsigned1 s38:=0;
		unsigned1 s39:=0;
		unsigned1 s40:=0;
		unsigned1 s41:=0;
		unsigned1 s42:=0;
		unsigned1 s43:=0;
		unsigned1 s44:=0;
		unsigned1 s45:=0;
		unsigned1 s46:=0;
		unsigned1 s47:=0;
		unsigned1 s48:=0;
		unsigned1 s49:=0;
		unsigned1 s50:=0;
		unsigned1 s51:=0;
		unsigned1 s52:=0;
		unsigned1 s53:=0;
		unsigned1 s54:=0;
		unsigned1 s55:=0;
		unsigned1 s56:=0;
		unsigned1 s57:=0;
		unsigned1 s58:=0;
		unsigned1 s59:=0;
		unsigned1 s60:=0;
		unsigned1 s61:=0;
		unsigned1 s62:=0;
		unsigned1 s63:=0;
		unsigned1 s64:=0;
		unsigned1 s65:=0;
		unsigned1 s66:=0;
		unsigned1 s67:=0;
		unsigned1 s68:=0;
		unsigned1 s69:=0;
		unsigned1 s70:=0;
		unsigned1 s71:=0;
		unsigned1 s72:=0;
		unsigned1 s73:=0;
		unsigned1 s74:=0;
		unsigned1 s75:=0;
		unsigned1 s76:=0;
		unsigned1 s77:=0;
		unsigned1 s78:=0;
		unsigned1 s79:=0;
		unsigned1 s80:=0;
		unsigned1 s81:=0;
		unsigned1 s82:=0;
		unsigned1 s83:=0;
		unsigned1 s84:=0;
		unsigned1 s85:=0;
		unsigned1 s86:=0;
		unsigned1 s87:=0;
		unsigned1 s88:=0;
		unsigned1 s89:=0;
		unsigned1 s90:=0;
		unsigned1 s91:=0;
		unsigned1 s92:=0;
		unsigned1 s93:=0;
		unsigned1 s94:=0;
		unsigned1 s95:=0;
		unsigned1 s96:=0;
		unsigned1 s97:=0;
		unsigned1 s98:=0;
		unsigned1 s99:=0;
	END;
	
	// CFS Key:
// New Attribute: Bair.Key_Payload_CFS_v2
// Key super file: thor_data400::key::bair::cfs::v2::qa::eid
	EXPORT cfs_v2_key := record
		string23  eid;					//KEYED
		string30 	event_number;
		string30 	report_number;
		unsigned4 initial_ucr_group;   
		unsigned4 final_ucr_group;
		string100 address;
		
		string10  inc_prim_range := '';
		string2   inc_predir := '' ;
		string28  inc_prim_name := '' ;
		string4   inc_addr_suffix := '' ;
		string2   inc_postdir := '' ;
		string10  inc_unit_desig := '' ;
		string8   inc_sec_range := '' ;
		string25  inc_p_city_name := '' ;
		string2   inc_st := '' ;
		string5   inc_z5 := '' ;
		string4   inc_zip4 := '' ;
		
		string20 	apartment_number;
		string25 	city;
		real8 		x_coordinate;
		real8 		y_coordinate;
		string1 	geocoded;
		unsigned1 accuracy_code;
		string20 	accuracy;
		string65  place_name;
		string60  location_type;
		string30 	district;
		string30 	beat;
		string30 	rd;
		string35 	how_received;
		string50  initial_type;
		string50  final_type;
		string30 	disposition;
		string30 	priority1;
		string25 	date_occurred;              
		string25 	date_time_received;
		string25 	edit_date;    
		string25 	date_time_archived;
		string30 	incident_code;
		string1 	report_flag;
		string50  event_relationship;
		string30  call_taker;
		string35 	contacting_officer;
		real8 		total_minutes_on_call;
		string70  status;
		unsigned4 data_provider_id;
		string10 	data_provider_ori;
		string70  data_provider_name;
		
		unsigned8 lexid;
		string50	complainant;
		string100 complainant_address;
		string100 caller_address;
		string30 	current_phone;
		real8 		complainant_x_coordinate;
		real8 		complainant_y_coordinate;
		string1 	complainant_geocoded;
		unsigned1 complainant_accuracy;
		string 		incident_progress;
	END;

// CFS Officer Key:
// New Attribute: Bair.Key_Payload_CFS_Officer
// Key super file: thor_data400::key::bair::cfs::officer::v2::qa::eid
	EXPORT cfs_officer_v2_key := record		
		string23 	eid;							//KEYED
		boolean   primary_officer_indicator; //(KEYED)
		string1 	primary_officer;		
		UNSIGNED4 cfs_officers_id;
		string50 	officer_name;
		string25 	date_time_dispatched;
		string25 	date_time_enroute;
		string25 	date_time_arrived;
		string25 	date_time_cleared;
		real8 		minutes_on_call;
		real8 		minutes_response;
		string30  unit;
		
		unsigned4 data_provider_id;
	END;
	
	EXPORT crash_v2_key := record
		string23 	eid;
		string60 	case_number;
		string20 	reportnumber;
		string25 	report_date;
		string100 address;
		
		string10  prim_range := '';
		string2   predir := '' ;
		string28  prim_name := '' ;
		string4   addr_suffix := '' ;
		string2   postdir := '' ;
		string10  unit_desig := '' ;
		string8   sec_range := '' ;
		string25  p_city_name := '' ;
		string2   st := '' ;
		string5   z5 := '' ;
		string4   zip4 := '' ;

		string20 	county;
		string30 	crash_city; 
		string20 	crash_state;
		real8 		x;
		real8 		y;
		string1 	hitandrun;
		string1 	intersectionrelated;
		string30 	officername;
		string20 	crashtype;
		string40 	locationtype;
		string50 	accidentclass;		
		string40 	lightcondition;
		string30 	weathercondition;
		string40 	surfacetype;		
		unsigned4 data_provider_id; 
		string10 	data_provider_ori;
		string70 	data_provider_name;
		string 		specialcircumstance1;
		string 		specialcircumstance2;
		string 		specialcircumstance3;
		string 		roadspecialfeature1;
		string 		roadspecialfeature2;
		string 		roadspecialfeature3;
		string 		surfacecondition;
		string 		trafficcontrolpresent;		
	END;
	
	EXPORT crash_per_v2_key := record
		string23 	eid;
		unsigned4 personid;
		unsigned4 personvehicleid;
		unsigned8 lexid;
		string1 	driver;
		string20 	first_name;
		string20  last_name;
		string20  licensenumber;
		string20 	licensestate;
		string50 	race;
		string10 	sex;
		string30  city;
		string20  state;
		unsigned2 age;
		string40  airbag;
		string40  seatbelt;
		string  	driveractions;
		
		unsigned4 data_provider_id;
	END;

	
	EXPORT crash_veh_v2_key := record
		string23 	eid;
		unsigned4 vehicleid;
		string20  vin;
		string20  plate;
		string20  platestate;
		string10 	year;
		string40  make;
		string30  model;
		string1 	towed;
		string50  vehicle_type;
		string   	damage;
		string   	action;
		string  	sequence;
		string   	driverimpairment;
		
		unsigned4 data_provider_id;
	END;
	
	EXPORt rLastFullPkgType := record
		boolean BooleanPkg;
	END;
	
	EXPORT intel_v2_Key := record
		string23 	eid := '';
		STRING12 	gh12 := '';
		unsigned1 etype; // [1 - EVE, 2 - CFS, 3 - Crash, 4 - Lpr, 5 - Inte, 6 - Shotstopper, 7 - Offenders]
		UNSIGNED2 id;
		UNSIGNED2 incident_id;
		string20  name_type;
		string50  first_name;
		string50  middle_name;
		string50  last_name;
		string100 moniker;
		string20  ssn;
		string25  dob;
		string10  sex;
		string50  race;
		string20  ethnicity;
		string20  country_of_origin;
		string10  height;
		string10  weight;
		string20  eye_color;
		string20  hair_color;
		string20  hair_style;
		string20  facial_hair;
		string100 tattoo_text_1;
		string100 tattoo_location_1;
		string100 tattoo_text_2;
		string100 tattoo_location_2;
		string100 occupation;
		string150 place_of_employment;
		string100 entity_address;
		string20  entity_city;
		string20  entity_state;
		string20  entity_zip;
		real8     person_x;
		real8     person_y;
		string20  phone_number;
		string10  phone_type;
		string50  email_address;
		string100 social_media_type_1;
		string100 user_name_site_1;
		string100 social_media_type_2;
		string100 user_name_site_2;
		string100 social_media_type_3;
		string100 user_name_site_3;
		string100 social_media_type_4;
		string100 user_name_site_4;
		string10 	organization_type;
		string10	organization_sub_type;
		string50  organization_name;
		string10  number_of_members;
		string100 organization_rank_role;
		string20 	entity_source_type;
		string100 source_reliability;
		string100 entity_content_validity;
		integer   entity_source_score;
		string25  entity_entry_date;
		string25  entity_purge_date;
		string20  vehicle_type;
		string50  vehicle_make;
		string50  vehicle_model;
		string20  vehicle_color;
		integer   vehicle_year;
		string100 vehicle_plate;
		string30  vehicle_plate_state;
		UNSIGNED4 vehicle_notes_id;
		UNSIGNED4 entity_photo_id;
		UNSIGNED4 entity_notes_id;
		UNSIGNED2 priority;
		string50	vehicle_color_secondary;
		string17	vehicle_vin;
		string100	photo := '';

		string20 	case_number;
		string20 	call_case_number;
		string25 	incident_date;
		UNSIGNED2	incident_time;
		INTEGER2  reporting_officer_id;
		string50 	incident_type;
		string100 incident_address;
		string25 	incident_city;
		string25 	incident_state;
		string25 	incident_zip;
		real8 		x;
		real8 		y;
		string50 	address_name;
		string50 	location_type;
		string50 	source_relaiability;
		string50 	incident_content_validity;
		string50 	source_type;
		INTEGER2 	incident_source_score;
		string25 	incident_entry_date;
		string25 	incident_purge_date;
		UNSIGNED2	notes_id;
		real8 		coordinate;
		string25	update_date;
		string25	purgedate_computed;
		string		duration_since;
		string50  reporting_officer_first_name;
		string50  reporting_officer_last_name;
		
		//data_provider_id
		UNSIGNED4    data_provider_id;
		string50     data_provider_ori;
		string200    data_provider_name;
	END;
	
end;