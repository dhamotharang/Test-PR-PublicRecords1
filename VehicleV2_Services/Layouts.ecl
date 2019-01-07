import VehicleV2, BIPV2,iesp, doxie_raw, doxie;

EXPORT Layouts := MODULE;

	EXPORT Layout_Vehicle_Vin_New := RECORD
		STRING25 Vin := '';
		STRING2 state_origin :='';
	END;
		
	export layout_standard_name := record
		STRING20 fname;
		STRING20 mname;
		STRING20 lname;
		STRING5  name_suffix;
	end;
	
	export layout_standard_address := record
		string10 prim_range;
		string2  predir;
		string28 prim_name;
		string4  addr_suffix;
		string2  postdir;
		string10 unit_desig;
		string8  sec_range;
		string25 v_city_name;
		string2  st;
		string5  zip5;
		string4  zip4;
	end;
	
	export matched_party_rec_New := RECORD
		string1 orig_name_type;	
		// vehiclev2_services.Layout_Report_Party;
		string70		Orig_Name;
		layout_standard_name;
		layout_standard_address;
	END;
	
	
	export Layout_Report_Plate_New := record
		VehicleV2.Layout_Base_Party.Reg_True_License_Plate;      // true license plate
		VehicleV2.Layout_Base_Party.Reg_License_Plate;           // true license plate
		VehicleV2.Layout_Base_Party.Reg_License_Plate_Type_Code;
		VehicleV2.Layout_Base_Party.Reg_License_Plate_Type_Desc;
		VehicleV2.Layout_Base_Party.Reg_License_State;
		VehicleV2.Layout_Base_Party.Reg_Previous_License_Plate;
		VehicleV2.Layout_Base_Party.Reg_Previous_License_State;
	
	end;
	export layout_vehicle_party_registrant_New := record
		unsigned2 party_penalty;                         
		VehicleV2.Layout_Base_Party.Sequence_Key;
		VehicleV2.Layout_Base_Party.Latest_Vehicle_Flag;  
		string30 history_desc;
	    layout_standard_name;
		layout_standard_address;
	    string18  county_name;                            
		VehicleV2.Layout_Base_Party.orig_name;
	    VehicleV2.Layout_Base_Party.Orig_DL_Number;       
	    VehicleV2.Layout_Base_Party.Orig_DOB;             
	    VehicleV2.Layout_Base_Party.Orig_Sex; 
		string10 orig_sex_desc;
		VehicleV2.Layout_Base_Party.Orig_SSN;
		VehicleV2.Layout_Base_Party.Orig_Fein;
	    VehicleV2.Layout_Base_Party.Append_Clean_CName;   
	    VehicleV2.Layout_Base_Party.Append_DID;
	    VehicleV2.Layout_Base_Party.Append_BDID;
		VehicleV2.Layout_Base_Party.Append_SSN;
		VehicleV2.Layout_Base_Party.Append_Fein;
	    VehicleV2.Layout_Base_Party.Reg_First_Date;            
	    VehicleV2.Layout_Base_Party.Reg_Earliest_Effective_Date; 
	    VehicleV2.Layout_Base_Party.Reg_Latest_Effective_Date;   
	    VehicleV2.Layout_Base_Party.Reg_Latest_Expiration_Date;  
	    VehicleV2.Layout_Base_Party.Reg_Decal_Number;            
	    VehicleV2.Layout_Base_Party.Reg_Decal_Year;              
	    VehicleV2.Layout_Base_Party.Reg_Status_Desc;             
	    Layout_Report_Plate;
		VehicleV2.Layout_Base_Party.Date_Vendor_first_Reported;
		VehicleV2.Layout_Base_Party.Date_Vendor_Last_Reported;
	end;
	
  export layout_match_flags := RECORD
		string1 surnameFlag;
		string1 fullNameFlag;
		string1 addressMatchFlag;
	END;

	export layout_registrant_New := RECORD
		layout_vehicle_party_registrant_New and not [append_did, append_bdid];
		string3 age;
		string12 append_did;
		string12 append_bdid;
		BIPV2.IDlayouts.l_header_ids;
		layout_match_flags matchFlags;
    boolean HasCriminalConviction;
    boolean IsSexualOffender;
		string10   geo_lat := '';
		string11   geo_long := '';
		string8 title_issue_date;
		string1 name_source_cd;
		string30 name_source;
		string17 title_number; 		// populated with data from ExperianVIN gateway	
		string30 reported_name;		// populated with data from ExperianVIN gateway			
	END;

	export Layout_Report_Title_New := record

		VehicleV2.Layout_Base_Party.Ttl_Number;              // title number
		VehicleV2.Layout_Base_Party.Ttl_Earliest_Issue_Date; // title issue date
		VehicleV2.Layout_Base_Party.Ttl_Latest_Issue_Date;   // title issue date
		VehicleV2.Layout_Base_Party.Ttl_Previous_Issue_Date; // previous title issue date
		VehicleV2.Layout_Base_Party.Ttl_Status_Code;         // title status code
		VehicleV2.Layout_Base_Party.Ttl_Status_Desc;         // title status description
		VehicleV2.Layout_Base_Party.Ttl_Odometer_Mileage;    // (Vehicle Sec.) odometer mileage
	end;
	
	export layout_vehicle_party_owner_New := record
		unsigned2 party_penalty;                    
		VehicleV2.Layout_Base_Party.Sequence_Key;
		VehicleV2.Layout_Base_Party.Latest_Vehicle_Flag; 
		string30 history_desc;
	     layout_standard_name;
		layout_standard_address;
	     string18  county_name;                           
		VehicleV2.Layout_Base_Party.orig_name;
	     VehicleV2.Layout_Base_Party.Orig_DL_Number;      
	     VehicleV2.Layout_Base_Party.Orig_DOB;            
	     VehicleV2.Layout_Base_Party.Orig_Sex; 
		string10 orig_sex_desc;
		VehicleV2.Layout_Base_Party.Orig_SSN; 
		VehicleV2.Layout_Base_Party.Orig_Fein;
	     VehicleV2.Layout_Base_Party.Append_Clean_CName;  
	     VehicleV2.Layout_Base_Party.Append_DID;
	     VehicleV2.Layout_Base_Party.Append_BDID;
		VehicleV2.Layout_Base_Party.Append_SSN;
		VehicleV2.Layout_Base_Party.Append_Fein;
		VehicleV2_Services.Layout_Report_Title;
		VehicleV2.Layout_Base_Party.Date_Vendor_first_Reported;
		VehicleV2.Layout_Base_Party.Date_Vendor_Last_Reported;
		VehicleV2.Layout_Base_Party.SRC_FIRST_DATE;
		VehicleV2.Layout_Base_Party.SRC_LAST_DATE;
	end;
	export layout_owner := RECORD
		layout_vehicle_party_owner_New and not [append_did, append_bdid];
		string3 age;
		string12 append_did;
		string12 append_bdid;
		BIPV2.IDlayouts.l_header_ids;
		layout_match_flags matchFlags;
    	boolean HasCriminalConviction;
    	boolean IsSexualOffender;
		string10   geo_lat := '';
		string11   geo_long := '';
		string30 reported_name;
	END;

	export Layout_Report_Vehicle_New := RECORD

	VehicleV2.Layout_Base_Main.Vehicle_Key;
	VehicleV2.Layout_Base_Main.Iteration_Key;	
	boolean is_deep_dive;
	string matchCode;
	VehicleV2.Layout_Base_Main.Source_Code;
	VehicleV2.Layout_Base_Main.State_Origin;
	string25 state_origin_decoded;
	string25 vin;
	string4 model_year; 
	string36 make_desc;	
	string40 vehicle_type_desc;
	string25 series_desc;
	string36 model_desc;
	string25 body_style_desc;
	string15 major_color_desc;                    // major color description
	string15 minor_color_desc;
	// odometer mileage (no field)
	// net weight (no field)
	// number of axles (no field)
	
	// -------------------------- from mapping append -------------------------------
	VehicleV2.Layout_Base_Main.VINA_VP_Year;
	VehicleV2.Layout_Base_Main.VINA_VP_Series;
	VehicleV2.Layout_Base_Main.VINA_VP_Series_Name;
	VehicleV2.Layout_Base_Main.VINA_VP_Model;
	string120 VINA_VP_RESTRAINT_Desc;
	string20 VINA_VP_AIR_CONDITIONING_Desc;
	string20 VINA_VP_POWER_STEERING_Desc;
	string20 VINA_VP_POWER_BRAKES_Desc;
	string20 VINA_VP_Power_Windows_Desc;
	string20 VINA_VP_Tilt_Wheel_Desc;
	string30 VINA_VP_Roof_Desc;
	string30 VINA_VP_Optional_Roof1_Desc;
	string30 VINA_VP_Optional_Roof2_Desc;
	string20 VINA_VP_Radio_Desc;
	string20 VINA_VP_Optional_Radio1_Desc;
	string20 VINA_VP_Optional_Radio2_Desc;
	VehicleV2.Layout_Base_Main.VINA_VP_Transmission;
	string40 VINA_VP_Transmission_Desc;
	string40 VINA_VP_Optional_Transmission1_Desc;
	string40 VINA_VP_Optional_Transmission2_Desc;
	string40 VINA_VP_Anti_Lock_Brakes_Desc;
	string30 VINA_VP_Front_Wheel_Drive_Desc;
	string30 VINA_VP_Four_Wheel_Drive_Desc;
	string50 VINA_VP_Security_System_Desc;
	string20 VINA_VP_Daytime_Running_Lights_Desc;
	VehicleV2.Layout_Base_Main.VINA_Number_Of_Cylinders;
	VehicleV2.Layout_Base_Main.VINA_Engine_Size;
	VehicleV2.Layout_Base_Main.Vina_fuel_code;
	string60 fuel_type_name;
	VehicleV2.Layout_Base_Main.VINA_Price;
	string6 BASE_PRICE;
	VehicleV2.Layout_Base_Main.Orig_Net_Weight;
	VehicleV2.Layout_Base_Main.Orig_Gross_Weight;
	VehicleV2.Layout_Base_Main.Orig_Number_Of_Axles;
	VehicleV2.Layout_Base_Main.Orig_Vehicle_Use_code;
	VehicleV2.Layout_Base_Main.Orig_Vehicle_Use_Desc;	
	DATASET({Layout_Vehicle_Key.Sequence_Key}) Target_Sequence_Keys {MAXCOUNT(30)};

END;

	export Layout_Vehicle_Title_Number_New := record
  	string20		Ttl_Number;
		string2 state_origin :='';
end;

export Layout_Vehicle_DL_Number_New := record
	string20		DL_Number;
	string2			state_origin;
end;

export Layout_Vehicle_Lic_Plate_New := record
	string10 lic_plate; // NOTE: This must match field length in VehicleV2.key_vehicle_lic_plate and VehicleV2.key_vehicle_reverse_lic_plate
	string2 state_origin :='';
	string20 fname;
	string20 lname;
end;

EXPORT lic_plate_key_payload_fields_New := RECORD
		string2 state_origin;
		string6 dph_lname;
		string20 pfname;
		boolean is_minor;
		string30 vehicle_key;
		string15 iteration_key;
		string15 sequence_key;
		boolean is_current;
		unsigned integer4 date;
		string8 orig_dob;
		string9 use_ssn;
		string20 fname;
		string20 lname;
		string20 mname;
		string2 predir;
		string28 prim_name;
		string10 prim_range;
		string4 addr_suffix;
		string2 postdir;
		string8 sec_range;
		string25 v_city_name;
		string5 zip5;
		string70 append_clean_cname;
		string1 state_type :='C';
 END;

	export Layout_Report_Party_New := RECORD
		unsigned2 party_penalty;                          // for search results
		VehicleV2.Layout_Base_Party.Sequence_Key;
		VehicleV2.Layout_Base_Party.Latest_Vehicle_Flag;  // for search results
		VehicleV2.Layout_Base_Party.History;              // for search results
		string30 history_desc;
		VehicleV2.Layout_Base_Party.Orig_Party_Type;      // for search results
		VehicleV2.Layout_Base_Party.Orig_Conjunction;     // for search results
		VehicleV2.Layout_Base_Party.Append_Clean_Name;    // customer name
		VehicleV2.Layout_Base_Party.Orig_Name;            // customer name
		VehicleV2.Layout_Base_Party.Orig_DL_Number;       // driver license number
		VehicleV2.Layout_Base_Party.Orig_DOB;             // dob
		VehicleV2.Layout_Base_Party.Orig_Sex;             // sex
		string10 orig_sex_desc;
		VehicleV2.Layout_Base_Party.Append_Clean_Address; // street address
		string18  county_name;                            //decoded county name
		VehicleV2.Layout_Base_Party.Orig_Address;         // street address
		VehicleV2.Layout_Base_Party.Orig_City;            // city
		VehicleV2.Layout_Base_Party.Orig_State;           // state
		VehicleV2.Layout_Base_Party.Orig_Zip;             // zip
	
		VehicleV2.Layout_Base_Party.Orig_SSN;             // ssn (mapping append)
		VehicleV2.Layout_Base_Party.Orig_Fein;
		VehicleV2.Layout_Base_Party.Append_Clean_CName;   // company name (mapping append)
	
		// for search results
		string12 Append_DID;
		VehicleV2.Layout_Base_Party.Append_DID_Score;
		string12 Append_BDID;
		BIPV2.IDlayouts.l_header_ids;
		string3 age;
		VehicleV2.Layout_Base_Party.Append_BDID_Score;
		VehicleV2.Layout_Base_Party.Append_SSN;
		VehicleV2.Layout_Base_Party.Append_Fein;
		VehicleV2.Layout_Base_Party.Date_Vendor_first_Reported;
		VehicleV2.Layout_Base_Party.Date_Vendor_Last_Reported;	
	
		// for registrations
		VehicleV2.Layout_Base_Party.Reg_First_Date;              // first registration date
		VehicleV2.Layout_Base_Party.Reg_Earliest_Effective_Date; // registration effective date
		VehicleV2.Layout_Base_Party.Reg_Latest_Effective_Date;   // registration effective date
		VehicleV2.Layout_Base_Party.Reg_Latest_Expiration_Date;  // registration expiration date
		VehicleV2.Layout_Base_Party.Reg_Decal_Number;            // decal number	
		VehicleV2.Layout_Base_Party.Reg_Decal_Year;              // decal year
		VehicleV2.Layout_Base_Party.Reg_Status_Code;             // registration status code
		VehicleV2.Layout_Base_Party.Reg_Status_Desc;             // registration status description
	
	VehicleV2_Services.Layout_Report_Plate;
	VehicleV2_Services.Layout_Report_Title;
	VehicleV2.Layout_Base_Party.SRC_FIRST_DATE;
	VehicleV2.Layout_Base_Party.SRC_LAST_DATE;
END;

	export Layout_Report_Batch_New := record
		string20 acctno;
		vehicleV2_Services.Layout_Report;
	end;

	EXPORT standard__addr := RECORD
		string10 prim_range;
		string2 predir;
		string28 prim_name;
		string4 addr_suffix;
		string2 postdir;
		string10 unit_desig;
		string8 sec_range;
		string25 v_city_name;
		string2 st;
		string5 zip5;
		string4 zip4;
		string2 addr_rec_type;
		string2 fips_state;
		STRING3 fips_county;
		string10 geo_lat;
		string11 geo_long;
		string4 cbsa;
		string7 geo_blk;
		string1 geo_match;
		string4 err_stat;
	END;

	EXPORT standard__name := RECORD
		string5 title;
		string20 fname;
		string20 mname;
		string20 lname;
		string5 name_suffix;
		string3 name_score;
	END;
  
	export layout_common := RECORD
		string30 vehicle_key;
		string15 iteration_key;
		string15 sequence_key;
		unsigned integer1 zero;
		unsigned4 lookup_bit;
		string2	 Source_Code;
		unsigned integer6 append_did;
		unsigned integer6 append_bdid;
		string70 append_clean_cname;
		string9 append_ssn;
		string9 append_fein;
		standard__addr company_addr;
		standard__addr person_addr;
		standard__name person_name;
		string1 orig_name_type;
		string1 history;
		unsigned integer4 reg_latest_effective_date;
		unsigned integer4 reg_latest_expiration_date;
		unsigned integer4 ttl_latest_issue_date;
	END;
	
	EXPORT layout_MVRRegistrationExtra := RECORD
      iesp.motorVehicle.t_MotorVehicleSearch2Record;
			boolean   unacceptableInput;
			INTEGER   SeqNumber;
  END;



  // A simplified version of Moxie_vehicle_registration2_1_Server.Layout_Out.layout_w_v1;
  // some redundancies are removed, criminal indicators are added.
  EXPORT flat_vehicle := RECORD
    // string2   	state_origin;
    string2   	source_field;
    string1   	history_flag;

	  doxie_raw.layout_VehRawBatchInput.input_w_keys;// and not [state_origin];
    doxie.layout_VehicleSearch_wCrimInd
  END;

END;
