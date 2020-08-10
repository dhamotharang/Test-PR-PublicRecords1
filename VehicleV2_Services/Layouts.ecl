IMPORT VehicleV2, BIPV2,iesp, doxie_raw, doxie;

EXPORT Layouts := MODULE;

  EXPORT Layout_Vehicle_Vin_New := RECORD
    STRING25 Vin := '';
    STRING2 state_origin :='';
  END;
    
  EXPORT layout_standard_name := RECORD
    STRING20 fname;
    STRING20 mname;
    STRING20 lname;
    STRING5 name_suffix;
  END;
  
  EXPORT layout_standard_address := RECORD
    STRING10 prim_range;
    STRING2 predir;
    STRING28 prim_name;
    STRING4 addr_suffix;
    STRING2 postdir;
    STRING10 unit_desig;
    STRING8 sec_range;
    STRING25 v_city_name;
    STRING2 st;
    STRING5 zip5;
    STRING4 zip4;
  END;
  
  EXPORT matched_party_rec_New := RECORD
    STRING1 orig_name_type;
    // vehiclev2_services.Layout_Report_Party;
    STRING70 Orig_Name;
    layout_standard_name;
    layout_standard_address;
  END;
  
  
  EXPORT Layout_Report_Plate_New := RECORD
    VehicleV2.Layout_Base_Party.Reg_True_License_Plate; // true license plate
    VehicleV2.Layout_Base_Party.Reg_License_Plate; // true license plate
    VehicleV2.Layout_Base_Party.Reg_License_Plate_Type_Code;
    VehicleV2.Layout_Base_Party.Reg_License_Plate_Type_Desc;
    VehicleV2.Layout_Base_Party.Reg_License_State;
    VehicleV2.Layout_Base_Party.Reg_Previous_License_Plate;
    VehicleV2.Layout_Base_Party.Reg_Previous_License_State;
  
  END;
  EXPORT layout_vehicle_party_registrant_New := RECORD
    UNSIGNED2 party_penalty;
    VehicleV2.Layout_Base_Party.Sequence_Key;
    VehicleV2.Layout_Base_Party.Latest_Vehicle_Flag;
    STRING30 history_desc;
    layout_standard_name;
    layout_standard_address;
    STRING18 county_name;
    VehicleV2.Layout_Base_Party.orig_name;
    VehicleV2.Layout_Base_Party.Orig_DL_Number;
    VehicleV2.Layout_Base_Party.Orig_DOB;
    VehicleV2.Layout_Base_Party.Orig_Sex;
    STRING10 orig_sex_desc;
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
  END;
  
  EXPORT layout_match_flags := RECORD
    STRING1 surnameFlag;
    STRING1 fullNameFlag;
    STRING1 addressMatchFlag;
  END;

  EXPORT layout_registrant_New := RECORD
    layout_vehicle_party_registrant_New AND NOT [append_did, append_bdid];
    STRING3 age;
    STRING12 append_did;
    STRING12 append_bdid;
    BIPV2.IDlayouts.l_header_ids;
    layout_match_flags matchFlags;
    BOOLEAN HasCriminalConviction;
    BOOLEAN IsSexualOffender;
    STRING10 geo_lat := '';
    STRING11 geo_long := '';
    STRING8 title_issue_date;
    STRING1 name_source_cd;
    STRING30 name_source;
    STRING17 title_number; // populated with data from ExperianVIN gateway
    STRING30 reported_name; // populated with data from ExperianVIN gateway
  END;

  EXPORT Layout_Report_Title_New := RECORD
    VehicleV2.Layout_Base_Party.Ttl_Number; // title number
    VehicleV2.Layout_Base_Party.Ttl_Earliest_Issue_Date; // title issue date
    VehicleV2.Layout_Base_Party.Ttl_Latest_Issue_Date; // title issue date
    VehicleV2.Layout_Base_Party.Ttl_Previous_Issue_Date; // previous title issue date
    VehicleV2.Layout_Base_Party.Ttl_Status_Code; // title status code
    VehicleV2.Layout_Base_Party.Ttl_Status_Desc; // title status description
    VehicleV2.Layout_Base_Party.Ttl_Odometer_Mileage; // (Vehicle Sec.) odometer mileage
  END;
  
  EXPORT layout_vehicle_party_owner_New := RECORD
    UNSIGNED2 party_penalty;
    VehicleV2.Layout_Base_Party.Sequence_Key;
    VehicleV2.Layout_Base_Party.Latest_Vehicle_Flag;
    STRING30 history_desc;
    layout_standard_name;
    layout_standard_address;
    STRING18 county_name;
    VehicleV2.Layout_Base_Party.orig_name;
    VehicleV2.Layout_Base_Party.Orig_DL_Number;
    VehicleV2.Layout_Base_Party.Orig_DOB;
    VehicleV2.Layout_Base_Party.Orig_Sex;
    STRING10 orig_sex_desc;
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
  END;
  EXPORT layout_owner := RECORD
    layout_vehicle_party_owner_New AND NOT [append_did, append_bdid];
    STRING3 age;
    STRING12 append_did;
    STRING12 append_bdid;
    BIPV2.IDlayouts.l_header_ids;
    layout_match_flags matchFlags;
    BOOLEAN HasCriminalConviction;
    BOOLEAN IsSexualOffender;
    STRING10 geo_lat := '';
    STRING11 geo_long := '';
    STRING30 reported_name;
  END;

  EXPORT Layout_Report_Vehicle_New := RECORD
    VehicleV2.Layout_Base_Main.Vehicle_Key;
    VehicleV2.Layout_Base_Main.Iteration_Key;
    BOOLEAN is_deep_dive;
    STRING matchCode;
    VehicleV2.Layout_Base_Main.Source_Code;
    VehicleV2.Layout_Base_Main.State_Origin;
    STRING25 state_origin_decoded;
    STRING25 vin;
    STRING4 model_year;
    STRING36 make_desc;
    STRING40 vehicle_type_desc;
    STRING25 series_desc;
    STRING36 model_desc;
    STRING25 body_style_desc;
    STRING15 major_color_desc; // major color description
    STRING15 minor_color_desc;
    // odometer mileage (no field)
    // net weight (no field)
    // number of axles (no field)
    
    // -------------------------- from mapping append -------------------------------
    VehicleV2.Layout_Base_Main.VINA_VP_Year;
    VehicleV2.Layout_Base_Main.VINA_VP_Series;
    VehicleV2.Layout_Base_Main.VINA_VP_Series_Name;
    VehicleV2.Layout_Base_Main.VINA_VP_Model;
    STRING120 VINA_VP_RESTRAINT_Desc;
    STRING20 VINA_VP_AIR_CONDITIONING_Desc;
    STRING20 VINA_VP_POWER_STEERING_Desc;
    STRING20 VINA_VP_POWER_BRAKES_Desc;
    STRING20 VINA_VP_Power_Windows_Desc;
    STRING20 VINA_VP_Tilt_Wheel_Desc;
    STRING30 VINA_VP_Roof_Desc;
    STRING30 VINA_VP_Optional_Roof1_Desc;
    STRING30 VINA_VP_Optional_Roof2_Desc;
    STRING20 VINA_VP_Radio_Desc;
    STRING20 VINA_VP_Optional_Radio1_Desc;
    STRING20 VINA_VP_Optional_Radio2_Desc;
    VehicleV2.Layout_Base_Main.VINA_VP_Transmission;
    STRING40 VINA_VP_Transmission_Desc;
    STRING40 VINA_VP_Optional_Transmission1_Desc;
    STRING40 VINA_VP_Optional_Transmission2_Desc;
    STRING40 VINA_VP_Anti_Lock_Brakes_Desc;
    STRING30 VINA_VP_Front_Wheel_Drive_Desc;
    STRING30 VINA_VP_Four_Wheel_Drive_Desc;
    STRING50 VINA_VP_Security_System_Desc;
    STRING20 VINA_VP_Daytime_Running_Lights_Desc;
    VehicleV2.Layout_Base_Main.VINA_Number_Of_Cylinders;
    VehicleV2.Layout_Base_Main.VINA_Engine_Size;
    VehicleV2.Layout_Base_Main.Vina_fuel_code;
    STRING60 fuel_type_name;
    VehicleV2.Layout_Base_Main.VINA_Price;
    STRING6 BASE_PRICE;
    VehicleV2.Layout_Base_Main.Orig_Net_Weight;
    VehicleV2.Layout_Base_Main.Orig_Gross_Weight;
    VehicleV2.Layout_Base_Main.Orig_Number_Of_Axles;
    VehicleV2.Layout_Base_Main.Orig_Vehicle_Use_code;
    VehicleV2.Layout_Base_Main.Orig_Vehicle_Use_Desc;
    DATASET({Layout_Vehicle_Key.Sequence_Key}) Target_Sequence_Keys {MAXCOUNT(30)};
END;

  EXPORT Layout_Vehicle_Title_Number_New := RECORD
    STRING20 Ttl_Number;
    STRING2 state_origin :='';
  END;

  EXPORT Layout_Vehicle_DL_Number_New := RECORD
    STRING20 DL_Number;
    STRING2 state_origin;
  END;

  EXPORT Layout_Vehicle_Lic_Plate_New := RECORD
    STRING10 lic_plate; // NOTE: This must match field length in VehicleV2.key_vehicle_lic_plate and VehicleV2.key_vehicle_reverse_lic_plate
    STRING2 state_origin :='';
    STRING20 fname;
    STRING20 lname;
  END;

  EXPORT lic_plate_key_payload_fields_New := RECORD
      STRING2 state_origin;
      STRING6 dph_lname;
      STRING20 pfname;
      BOOLEAN is_minor;
      STRING30 vehicle_key;
      STRING15 iteration_key;
      STRING15 sequence_key;
      BOOLEAN is_current;
      UNSIGNED INTEGER4 date;
      STRING8 orig_dob;
      STRING9 use_ssn;
      STRING20 fname;
      STRING20 lname;
      STRING20 mname;
      STRING2 predir;
      STRING28 prim_name;
      STRING10 prim_range;
      STRING4 addr_suffix;
      STRING2 postdir;
      STRING8 sec_range;
      STRING25 v_city_name;
      STRING5 zip5;
      STRING70 append_clean_cname;
      STRING1 state_type :='C';
  END;

  EXPORT Layout_Report_Party_New := RECORD
    UNSIGNED2 party_penalty; // for search results
    VehicleV2.Layout_Base_Party.Sequence_Key;
    VehicleV2.Layout_Base_Party.Latest_Vehicle_Flag; // for search results
    VehicleV2.Layout_Base_Party.History; // for search results
    STRING30 history_desc;
    VehicleV2.Layout_Base_Party.Orig_Party_Type; // for search results
    VehicleV2.Layout_Base_Party.Orig_Conjunction; // for search results
    VehicleV2.Layout_Base_Party.Append_Clean_Name; // customer name
    VehicleV2.Layout_Base_Party.Orig_Name; // customer name
    VehicleV2.Layout_Base_Party.Orig_DL_Number; // driver license number
    VehicleV2.Layout_Base_Party.Orig_DOB; // dob
    VehicleV2.Layout_Base_Party.Orig_Sex; // sex
    STRING10 orig_sex_desc;
    VehicleV2.Layout_Base_Party.Append_Clean_Address; // street address
    STRING18 county_name; //decoded county name
    VehicleV2.Layout_Base_Party.Orig_Address; // street address
    VehicleV2.Layout_Base_Party.Orig_City; // city
    VehicleV2.Layout_Base_Party.Orig_State; // state
    VehicleV2.Layout_Base_Party.Orig_Zip; // zip
  
    VehicleV2.Layout_Base_Party.Orig_SSN; // ssn (mapping append)
    VehicleV2.Layout_Base_Party.Orig_Fein;
    VehicleV2.Layout_Base_Party.Append_Clean_CName; // company name (mapping append)
  
    // for search results
    STRING12 Append_DID;
    VehicleV2.Layout_Base_Party.Append_DID_Score;
    STRING12 Append_BDID;
    BIPV2.IDlayouts.l_header_ids;
    STRING3 age;
    VehicleV2.Layout_Base_Party.Append_BDID_Score;
    VehicleV2.Layout_Base_Party.Append_SSN;
    VehicleV2.Layout_Base_Party.Append_Fein;
    VehicleV2.Layout_Base_Party.Date_Vendor_first_Reported;
    VehicleV2.Layout_Base_Party.Date_Vendor_Last_Reported;
  
    // for registrations
    VehicleV2.Layout_Base_Party.Reg_First_Date; // first registration date
    VehicleV2.Layout_Base_Party.Reg_Earliest_Effective_Date; // registration effective date
    VehicleV2.Layout_Base_Party.Reg_Latest_Effective_Date; // registration effective date
    VehicleV2.Layout_Base_Party.Reg_Latest_Expiration_Date; // registration expiration date
    VehicleV2.Layout_Base_Party.Reg_Decal_Number; // decal number
    VehicleV2.Layout_Base_Party.Reg_Decal_Year; // decal year
    VehicleV2.Layout_Base_Party.Reg_Status_Code; // registration status code
    VehicleV2.Layout_Base_Party.Reg_Status_Desc; // registration status description
  
    VehicleV2_Services.Layout_Report_Plate;
    VehicleV2_Services.Layout_Report_Title;
    VehicleV2.Layout_Base_Party.SRC_FIRST_DATE;
    VehicleV2.Layout_Base_Party.SRC_LAST_DATE;
  END;

  EXPORT Layout_Report_Batch_New := RECORD
    STRING20 acctno;
    vehicleV2_Services.Layout_Report;
  END;

  EXPORT standard__addr := RECORD
    STRING10 prim_range;
    STRING2 predir;
    STRING28 prim_name;
    STRING4 addr_suffix;
    STRING2 postdir;
    STRING10 unit_desig;
    STRING8 sec_range;
    STRING25 v_city_name;
    STRING2 st;
    STRING5 zip5;
    STRING4 zip4;
    STRING2 addr_rec_type;
    STRING2 fips_state;
    STRING3 fips_county;
    STRING10 geo_lat;
    STRING11 geo_long;
    STRING4 cbsa;
    STRING7 geo_blk;
    STRING1 geo_match;
    STRING4 err_stat;
  END;

  EXPORT standard__name := RECORD
    STRING5 title;
    STRING20 fname;
    STRING20 mname;
    STRING20 lname;
    STRING5 name_suffix;
    STRING3 name_score;
  END;
  
  EXPORT layout_common := RECORD
    STRING30 vehicle_key;
    STRING15 iteration_key;
    STRING15 sequence_key;
    UNSIGNED INTEGER1 zero;
    UNSIGNED4 lookup_bit;
    STRING2 Source_Code;
    UNSIGNED INTEGER6 append_did;
    UNSIGNED INTEGER6 append_bdid;
    STRING70 append_clean_cname;
    STRING9 append_ssn;
    STRING9 append_fein;
    standard__addr company_addr;
    standard__addr person_addr;
    standard__name person_name;
    STRING1 orig_name_type;
    STRING1 history;
    UNSIGNED4 global_sid;
    UNSIGNED8 record_sid;
    UNSIGNED INTEGER4 reg_latest_effective_date;
    UNSIGNED INTEGER4 reg_latest_expiration_date;
    UNSIGNED INTEGER4 ttl_latest_issue_date;
  END;
  
  EXPORT layout_MVRRegistrationExtra := RECORD
      iesp.motorVehicle.t_MotorVehicleSearch2Record;
      BOOLEAN unacceptableInput;
      INTEGER SeqNumber;
  END;



  // A simplIFied version of Moxie_vehicle_registration2_1_Server.Layout_Out.layout_w_v1;
  // some redundancies are removed, criminal indicators are added.
  EXPORT flat_vehicle := RECORD
    // STRING2 state_origin;
    STRING2 source_field;
    STRING1 history_flag;

    doxie_raw.layout_VehRawBatchInput.input_w_keys;// and not [state_origin];
    doxie.layout_VehicleSearch_wCrimInd
  END;

END;
