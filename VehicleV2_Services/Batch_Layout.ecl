IMPORT doxie,Autokey_batch,AutokeyB2_batch,VehicleV2;

EXPORT Batch_Layout := MODULE

  EXPORT LicPlate_InLayout := RECORD
    Layout_VKeysWithInput.year;
    Autokey_batch.Layouts.rec_inBatchMaster;
    Layout_VKeysWithInput.make;
    Layout_VKeysWithInput.model;
    Layout_VKeysWithInput.color;
  END;

  EXPORT filter_rec := RECORD
    doxie.layout_inBatchMaster.acctno;
    LicPlate_InLayout.year;
    LicPlate_InLayout.make;
    LicPlate_InLayout.model;
    LicPlate_InLayout.color;
    STRING10 Plate;
    STRING2 PlateState;
  END;
  
  EXPORT vin_rec := RECORD
    Doxie.layout_inBatchMaster.acctno;
    Doxie.layout_inBatchMaster.vin;
    Doxie.layout_inBatchMaster.st;
  END;
  
  EXPORT acctno_rec := RECORD
    Doxie.layout_inBatchMaster.acctno;
    STRING30 Vehicle_Key;
    STRING15 Iteration_Key;
    STRING2 state_origin := '';
    STRING10 MatchCode := '';

  END;
  
  
  EXPORT plate_rec := RECORD
    Doxie.layout_inBatchMaster.acctno;
    Doxie.layout_inBatchMaster.Plate;
    Doxie.layout_inBatchMaster.PlateState;
  END;
  
  EXPORT Key_Layout := VehicleV2_Services.Layout_Vehicle_Key;
  
  EXPORT vehicle_layout := RECORD
    Layout_Report_Vehicle.vin;
    Layout_Report_Vehicle.model_year;
    Layout_Report_Vehicle.make_desc;
    Layout_Report_Vehicle.vehicle_type_desc;
    Layout_Report_Vehicle.series_desc;
    Layout_Report_Vehicle.model_desc;
    Layout_Report_Vehicle.body_style_desc;
    Layout_Report_Vehicle.major_color_desc;
    Layout_Report_Vehicle.minor_color_desc;
    Layout_Report_Vehicle.base_price;
    Layout_Report_airbag_safety;
  END;
  
  EXPORT registration_layout := Layout_Report_Registration;
  EXPORT title_layout := Layout_Report_title;
  EXPORT plate_layout := Layout_Report_Plate;
  
  EXPORT name := VehicleV2_Services.layout_vehicle_party_out.layout_standard_name;
  EXPORT address := VehicleV2_Services.layout_vehicle_party_out.layout_standard_address;
  EXPORT owner := VehicleV2_Services.layout_vehicle_party_out.layout_vehicle_party_owner;

  
  EXPORT own_1_Layout := RECORD
    STRING5 own_1_title;
    STRING20 own_1_fname;
    STRING20 own_1_mname;
    STRING20 own_1_lname;
    STRING5 own_1_name_suffix;
    STRING70 own_1_Orig_Name;
    STRING1 own_1_Orig_Sex;
    STRING12 own_1_did;
    STRING13 own_1_driver_license_number;
    STRING8 own_1_dob;
    STRING9 own_1_ssn;
    STRING53 own_1_company_name;
    STRING12 own_1_bdid;
    STRING9 own_1_fein;
    STRING50 own_1_addr1;
    STRING19 own_1_addr2;
    STRING25 own_1_v_city_name;
    STRING25 own_1_city;
    STRING2 own_1_state;
    STRING10 own_1_zip;
    STRING18 own_1_county;
    STRING8 own_1_src_first_date;
    STRING8 own_1_src_last_date;
    UNSIGNED6 own_1_UltID;
    UNSIGNED6 own_1_OrgID;
    UNSIGNED6 own_1_SeleID;
    UNSIGNED6 own_1_ProxID;
    UNSIGNED6 own_1_PowID;
    UNSIGNED6 own_1_EmpID;
    UNSIGNED6 own_1_DotID;
  END;
  
  EXPORT own_2_Layout := RECORD
    STRING5 own_2_title;
    STRING20 own_2_fname;
    STRING20 own_2_mname;
    STRING20 own_2_lname;
    STRING5 own_2_name_suffix;
    STRING70 own_2_Orig_Name;
    STRING1 own_2_Orig_Sex;
    STRING12 own_2_did;
    STRING13 own_2_driver_license_number;
    STRING8 own_2_dob;
    STRING9 own_2_ssn;
    STRING53 own_2_company_name;
    STRING12 own_2_bdid;
    STRING9 own_2_fein;
    STRING50 Own_2_addr1;
    STRING19 Own_2_addr2;
    STRING25 own_2_v_city_name;
    STRING25 own_2_city;
    STRING2 own_2_state;
    STRING10 own_2_zip;
    STRING18 own_2_county;
    STRING8 own_2_src_first_date;
    STRING8 own_2_src_last_date;
    UNSIGNED6 own_2_UltID;
    UNSIGNED6 own_2_OrgID;
    UNSIGNED6 own_2_SeleID;
    UNSIGNED6 own_2_ProxID;
    UNSIGNED6 own_2_PowID;
    UNSIGNED6 own_2_EmpID;
    UNSIGNED6 own_2_DotID;
  END;
  
  //Owner3
  EXPORT own_3_Layout := RECORD
    STRING5 own_3_title;
    STRING20 own_3_fname;
    STRING20 own_3_mname;
    STRING20 own_3_lname;
    STRING5 own_3_name_suffix;
    STRING70 own_3_Orig_Name;
    STRING1 own_3_Orig_Sex;
    STRING12 own_3_did;
    STRING13 own_3_driver_license_number;
    STRING8 own_3_dob;
    STRING9 own_3_ssn;
    STRING53 own_3_company_name;
    STRING12 own_3_bdid;
    STRING9 own_3_fein;
    STRING50 Own_3_addr1;
    STRING19 Own_3_addr2;
    STRING25 own_3_v_city_name;
    STRING25 own_3_city;
    STRING2 own_3_state;
    STRING10 own_3_zip;
    STRING18 own_3_county;
    STRING8 own_3_src_first_date;
    STRING8 own_3_src_last_date;
    UNSIGNED6 own_3_UltID;
    UNSIGNED6 own_3_OrgID;
    UNSIGNED6 own_3_SeleID;
    UNSIGNED6 own_3_ProxID;
    UNSIGNED6 own_3_PowID;
    UNSIGNED6 own_3_EmpID;
    UNSIGNED6 own_3_DotID;
  END;
  
  //Registrant 1
  EXPORT reg_1_Layout := RECORD
    STRING5 reg_1_title;
    STRING20 reg_1_fname;
    STRING20 reg_1_mname;
    STRING20 reg_1_lname;
    STRING5 reg_1_name_suffix;
    STRING70 reg_1_Orig_Name;
    STRING1 reg_1_Orig_Sex;
    STRING12 reg_1_did;
    STRING13 reg_1_driver_license_number;
    STRING8 reg_1_dob;
    STRING9 reg_1_ssn;
    STRING53 reg_1_company_name;
    STRING12 reg_1_bdid;
    STRING9 reg_1_fein;
    STRING50 reg_1_addr1;
    STRING19 reg_1_addr2;
    STRING25 reg_1_v_city_name;
    STRING25 reg_1_city;
    STRING2 reg_1_state;
    STRING10 reg_1_zip;
    STRING18 reg_1_county;
    UNSIGNED6 reg_1_UltID;
    UNSIGNED6 reg_1_OrgID;
    UNSIGNED6 reg_1_SeleID;
    UNSIGNED6 reg_1_ProxID;
    UNSIGNED6 reg_1_PowID;
    UNSIGNED6 reg_1_EmpID;
    UNSIGNED6 reg_1_DotID;
  END;
 
  //Registrant 2
   EXPORT reg_2_Layout := RECORD
    STRING5 reg_2_title;
    STRING20 reg_2_fname;
    STRING20 reg_2_mname;
    STRING20 reg_2_lname;
    STRING5 reg_2_name_suffix;
    STRING70 reg_2_Orig_Name;
    STRING1 reg_2_Orig_Sex;
    STRING12 reg_2_did;
    STRING13 reg_2_driver_license_number;
    STRING8 reg_2_dob;
    STRING9 reg_2_ssn;
    STRING53 reg_2_company_name;
    STRING12 reg_2_bdid;
    STRING9 reg_2_fein;
    STRING50 reg_2_addr1;
    STRING19 reg_2_addr2;
    STRING25 reg_2_v_city_name;
    STRING25 reg_2_city;
    STRING2 reg_2_state;
    STRING10 reg_2_zip;
    STRING18 reg_2_county;
    UNSIGNED6 reg_2_UltID;
    UNSIGNED6 reg_2_OrgID;
    UNSIGNED6 reg_2_SeleID;
    UNSIGNED6 reg_2_ProxID;
    UNSIGNED6 reg_2_PowID;
    UNSIGNED6 reg_2_EmpID;
    UNSIGNED6 reg_2_DotID;
  END;
 
 //Registrant 3
   EXPORT reg_3_Layout := RECORD
    STRING5 reg_3_title;
    STRING20 reg_3_fname;
    STRING20 reg_3_mname;
    STRING20 reg_3_lname;
    STRING5 reg_3_name_suffix;
    STRING70 reg_3_Orig_Name;
    STRING1 reg_3_Orig_Sex;
    STRING12 reg_3_did;
    STRING13 reg_3_driver_license_number;
    STRING8 reg_3_dob;
    STRING9 reg_3_ssn;
    STRING53 reg_3_company_name;
    STRING12 reg_3_bdid;
    STRING9 reg_3_fein;
    STRING50 reg_3_addr1;
    STRING19 reg_3_addr2;
    STRING25 reg_3_v_city_name;
    STRING25 reg_3_city;
    STRING2 reg_3_state;
    STRING10 reg_3_zip;
    STRING18 reg_3_county;
    UNSIGNED6 reg_3_UltID;
    UNSIGNED6 reg_3_OrgID;
    UNSIGNED6 reg_3_SeleID;
    UNSIGNED6 reg_3_ProxID;
    UNSIGNED6 reg_3_PowID;
    UNSIGNED6 reg_3_EmpID;
    UNSIGNED6 reg_3_DotID;
  END;
 
   //LienHolder 1
  EXPORT lh_1_Layout := RECORD
    STRING5 lh_1_title;
    STRING20 lh_1_fname;
    STRING20 lh_1_mname;
    STRING20 lh_1_lname;
    STRING5 lh_1_name_suffix;
    STRING8 lh_1_lien_date;
    STRING70 lh_1_Orig_Name;
    STRING1 lh_1_Orig_Sex;
    STRING12 lh_1_did;
    STRING13 lh_1_driver_license_number;
    STRING8 lh_1_dob;
    STRING9 lh_1_ssn;
    STRING53 lh_1_company_name;
    STRING12 lh_1_bdid;
    STRING9 lh_1_fein;
    STRING50 lh_1_addr1;
    STRING19 lh_1_addr2;
    STRING25 lh_1_v_city_name;
    STRING25 lh_1_city;
    STRING2 lh_1_state;
    STRING10 lh_1_zip;
    STRING18 lh_1_county;
    UNSIGNED6 lh_1_UltID;
    UNSIGNED6 lh_1_OrgID;
    UNSIGNED6 lh_1_SeleID;
    UNSIGNED6 lh_1_ProxID;
    UNSIGNED6 lh_1_PowID;
    UNSIGNED6 lh_1_EmpID;
    UNSIGNED6 lh_1_DotID;
  END;
 
  //LienHolder 2
   EXPORT lh_2_Layout := RECORD
    STRING5 lh_2_title;
    STRING20 lh_2_fname;
    STRING20 lh_2_mname;
    STRING20 lh_2_lname;
    STRING5 lh_2_name_suffix;
    STRING8 lh_2_lien_date;
    STRING70 lh_2_Orig_Name;
    STRING1 lh_2_Orig_Sex;
    STRING12 lh_2_did;
    STRING13 lh_2_driver_license_number;
    STRING8 lh_2_dob;
    STRING9 lh_2_ssn;
    STRING53 lh_2_company_name;
    STRING12 lh_2_bdid;
    STRING9 lh_2_fein;
    STRING50 lh_2_addr1;
    STRING19 lh_2_addr2;
    STRING25 lh_2_v_city_name;
    STRING25 lh_2_city;
    STRING2 lh_2_state;
    STRING10 lh_2_zip;
    STRING18 lh_2_county;
    UNSIGNED6 lh_2_UltID;
    UNSIGNED6 lh_2_OrgID;
    UNSIGNED6 lh_2_SeleID;
    UNSIGNED6 lh_2_ProxID;
    UNSIGNED6 lh_2_PowID;
    UNSIGNED6 lh_2_EmpID;
    UNSIGNED6 lh_2_DotID;
  END;
  
    //LienHolder 3
   EXPORT lh_3_Layout := RECORD
    STRING5 lh_3_title;
    STRING20 lh_3_fname;
    STRING20 lh_3_mname;
    STRING20 lh_3_lname;
    STRING5 lh_3_name_suffix;
    STRING8 lh_3_lien_date;
    STRING70 lh_3_Orig_Name;
    STRING1 lh_3_Orig_Sex;
    STRING12 lh_3_did;
    STRING13 lh_3_driver_license_number;
    STRING8 lh_3_dob;
    STRING9 lh_3_ssn;
    STRING53 lh_3_company_name;
    STRING12 lh_3_bdid;
    STRING9 lh_3_fein;
    STRING50 lh_3_addr1;
    STRING19 lh_3_addr2;
    STRING25 lh_3_v_city_name;
    STRING25 lh_3_city;
    STRING2 lh_3_state;
    STRING10 lh_3_zip;
    STRING18 lh_3_county;
    UNSIGNED6 lh_3_UltID;
    UNSIGNED6 lh_3_OrgID;
    UNSIGNED6 lh_3_SeleID;
    UNSIGNED6 lh_3_ProxID;
    UNSIGNED6 lh_3_PowID;
    UNSIGNED6 lh_3_EmpID;
    UNSIGNED6 lh_3_DotID;
  END;
  
     //Lessee 1
  EXPORT le_1_Layout := RECORD
    STRING5 le_1_title;
    STRING20 le_1_fname;
    STRING20 le_1_mname;
    STRING20 le_1_lname;
    STRING5 le_1_name_suffix;
    STRING70 le_1_Orig_Name;
    STRING1 le_1_Orig_Sex;
    STRING12 le_1_did;
    STRING13 le_1_driver_license_number;
    STRING8 le_1_dob;
    STRING9 le_1_ssn;
    STRING53 le_1_company_name;
    STRING12 le_1_bdid;
    STRING9 le_1_fein;
    STRING50 le_1_addr1;
    STRING19 le_1_addr2;
    STRING25 le_1_v_city_name;
    STRING25 le_1_city;
    STRING2 le_1_state;
    STRING10 le_1_zip;
    STRING18 le_1_county;
    UNSIGNED6 le_1_UltID;
    UNSIGNED6 le_1_OrgID;
    UNSIGNED6 le_1_SeleID;
    UNSIGNED6 le_1_ProxID;
    UNSIGNED6 le_1_PowID;
    UNSIGNED6 le_1_EmpID;
    UNSIGNED6 le_1_DotID;
  END;
 
  //Lessee 2
   EXPORT le_2_Layout := RECORD
    STRING5 le_2_title;
    STRING20 le_2_fname;
    STRING20 le_2_mname;
    STRING20 le_2_lname;
    STRING5 le_2_name_suffix;
    STRING70 le_2_Orig_Name;
    STRING1 le_2_Orig_Sex;
    STRING12 le_2_did;
    STRING13 le_2_driver_license_number;
    STRING8 le_2_dob;
    STRING9 le_2_ssn;
    STRING53 le_2_company_name;
    STRING12 le_2_bdid;
    STRING9 le_2_fein;
    STRING50 le_2_addr1;
    STRING19 le_2_addr2;
    STRING25 le_2_v_city_name;
    STRING25 le_2_city;
    STRING2 le_2_state;
    STRING10 le_2_zip;
    STRING18 le_2_county;
    UNSIGNED6 le_2_UltID;
    UNSIGNED6 le_2_OrgID;
    UNSIGNED6 le_2_SeleID;
    UNSIGNED6 le_2_ProxID;
    UNSIGNED6 le_2_PowID;
    UNSIGNED6 le_2_EmpID;
    UNSIGNED6 le_2_DotID;
  END;

  //Lessee 3
   EXPORT le_3_Layout := RECORD
    STRING5 le_3_title;
    STRING20 le_3_fname;
    STRING20 le_3_mname;
    STRING20 le_3_lname;
    STRING5 le_3_name_suffix;
    STRING70 le_3_Orig_Name;
    STRING1 le_3_Orig_Sex;
    STRING12 le_3_did;
    STRING13 le_3_driver_license_number;
    STRING8 le_3_dob;
    STRING9 le_3_ssn;
    STRING53 le_3_company_name;
    STRING12 le_3_bdid;
    STRING9 le_3_fein;
    STRING50 le_3_addr1;
    STRING19 le_3_addr2;
    STRING25 le_3_v_city_name;
    STRING25 le_3_city;
    STRING2 le_3_state;
    STRING10 le_3_zip;
    STRING18 le_3_county;
    UNSIGNED6 le_3_UltID;
    UNSIGNED6 le_3_OrgID;
    UNSIGNED6 le_3_SeleID;
    UNSIGNED6 le_3_ProxID;
    UNSIGNED6 le_3_PowID;
    UNSIGNED6 le_3_EmpID;
    UNSIGNED6 le_3_DotID;
  END;


     //Lessor 1
  EXPORT lo_1_Layout := RECORD
    STRING5 lo_1_title;
    STRING20 lo_1_fname;
    STRING20 lo_1_mname;
    STRING20 lo_1_lname;
    STRING5 lo_1_name_suffix;
    STRING70 lo_1_Orig_Name;
    STRING1 lo_1_Orig_Sex;
    STRING12 lo_1_did;
    STRING13 lo_1_driver_license_number;
    STRING8 lo_1_dob;
    STRING9 lo_1_ssn;
    STRING53 lo_1_company_name;
    STRING12 lo_1_bdid;
    STRING9 lo_1_fein;
    STRING50 lo_1_addr1;
    STRING19 lo_1_addr2;
    STRING25 lo_1_v_city_name;
    STRING25 lo_1_city;
    STRING2 lo_1_state;
    STRING10 lo_1_zip;
    STRING18 lo_1_county;
    UNSIGNED6 lo_1_UltID;
    UNSIGNED6 lo_1_OrgID;
    UNSIGNED6 lo_1_SeleID;
    UNSIGNED6 lo_1_ProxID;
    UNSIGNED6 lo_1_PowID;
    UNSIGNED6 lo_1_EmpID;
    UNSIGNED6 lo_1_DotID;
  END;
 
  //Lessor 2
   EXPORT lo_2_Layout := RECORD
    STRING5 lo_2_title;
    STRING20 lo_2_fname;
    STRING20 lo_2_mname;
    STRING20 lo_2_lname;
    STRING5 lo_2_name_suffix;
    STRING70 lo_2_Orig_Name;
    STRING1 lo_2_Orig_Sex;
    STRING12 lo_2_did;
    STRING13 lo_2_driver_license_number;
    STRING8 lo_2_dob;
    STRING9 lo_2_ssn;
    STRING53 lo_2_company_name;
    STRING12 lo_2_bdid;
    STRING9 lo_2_fein;
    STRING50 lo_2_addr1;
    STRING19 lo_2_addr2;
    STRING25 lo_2_v_city_name;
    STRING25 lo_2_city;
    STRING2 lo_2_state;
    STRING10 lo_2_zip;
    STRING18 lo_2_county;
    UNSIGNED6 lo_2_UltID;
    UNSIGNED6 lo_2_OrgID;
    UNSIGNED6 lo_2_SeleID;
    UNSIGNED6 lo_2_ProxID;
    UNSIGNED6 lo_2_PowID;
    UNSIGNED6 lo_2_EmpID;
    UNSIGNED6 lo_2_DotID;
  END;
  
    //Lessor 3
   EXPORT lo_3_Layout := RECORD
    STRING5 lo_3_title;
    STRING20 lo_3_fname;
    STRING20 lo_3_mname;
    STRING20 lo_3_lname;
    STRING5 lo_3_name_suffix;
    STRING70 lo_3_Orig_Name;
    STRING1 lo_3_Orig_Sex;
    STRING12 lo_3_did;
    STRING13 lo_3_driver_license_number;
    STRING8 lo_3_dob;
    STRING9 lo_3_ssn;
    STRING53 lo_3_company_name;
    STRING12 lo_3_bdid;
    STRING9 lo_3_fein;
    STRING50 lo_3_addr1;
    STRING19 lo_3_addr2;
    STRING25 lo_3_v_city_name;
    STRING25 lo_3_city;
    STRING2 lo_3_state;
    STRING10 lo_3_zip;
    STRING18 lo_3_county;
    UNSIGNED6 lo_3_UltID;
    UNSIGNED6 lo_3_OrgID;
    UNSIGNED6 lo_3_SeleID;
    UNSIGNED6 lo_3_ProxID;
    UNSIGNED6 lo_3_PowID;
    UNSIGNED6 lo_3_EmpID;
    UNSIGNED6 lo_3_DotID;
  END;

EXPORT Brand_Layout := RECORD
    STRING3 brand_code_1;
    STRING50 brand_type_1;
    STRING10 brand_date_1;
    STRING2 brand_state_1;
    STRING3 brand_code_2;
    STRING50 brand_type_2;
    STRING10 brand_date_2;
    STRING2 brand_state_2;
    STRING3 brand_code_3;
    STRING50 brand_type_3;
    STRING10 brand_date_3;
    STRING2 brand_state_3;
    STRING3 brand_code_4;
    STRING50 brand_type_4;
    STRING10 brand_date_4;
    STRING2 brand_state_4;
    STRING3 brand_code_5;
    STRING50 brand_type_5;
    STRING10 brand_date_5;
    STRING2 brand_state_5;
  END;

  EXPORT temp_out := RECORD
    UNSIGNED3 vendor_first_reported_date;
    UNSIGNED3 vendor_last_reported_date;
    INTEGER sk_len;
    STRING8 title_latest_issue_date;
    Layout_Report_Batch;
  END;
 
  SHARED all_Keys := RECORD
    Key_Layout - [Sequence_Key, state_origin];
    STRING15 own_Sequence_Key := '';
    STRING15 reg_Sequence_Key := '';
    STRING15 lh_Sequence_Key := '';
    STRING15 le_Sequence_Key := '';
    STRING15 lo_Sequence_Key := '';
  END;

  EXPORT vina_layout := RECORD
    Layout_Report_Vehicle.Orig_Net_Weight;
    Layout_Report_Vehicle.VINA_VP_Air_Conditioning_Desc;
    Layout_Report_Vehicle.VINA_VP_Power_Steering_Desc;
    Layout_Report_Vehicle.VINA_VP_Power_Brakes_Desc;
    Layout_Report_Vehicle.VINA_VP_Power_Windows_Desc;
    Layout_Report_Vehicle.VINA_VP_Tilt_Wheel_Desc;
    Layout_Report_Vehicle.VINA_VP_Roof_Desc;
    Layout_Report_Vehicle.VINA_VP_Optional_Roof1_Desc;
    Layout_Report_Vehicle.VINA_VP_Optional_Roof2_Desc;
    Layout_Report_Vehicle.VINA_VP_Radio_Desc;
    Layout_Report_Vehicle.VINA_VP_Optional_Radio1_Desc;
    Layout_Report_Vehicle.VINA_VP_Optional_Radio2_Desc;
    Layout_Report_Vehicle.VINA_VP_Transmission_Desc;
    Layout_Report_Vehicle.VINA_VP_Optional_Transmission1_Desc;
    Layout_Report_Vehicle.VINA_VP_Optional_Transmission2_Desc;
    Layout_Report_Vehicle.VINA_VP_Anti_Lock_Brakes_Desc;
    Layout_Report_Vehicle.VINA_VP_Front_Wheel_Drive_Desc;
    Layout_Report_Vehicle.VINA_VP_Four_Wheel_Drive_Desc;
    Layout_Report_Vehicle.VINA_VP_Security_System_Desc;
    Layout_Report_Vehicle.VINA_VP_Daytime_Running_Lights_Desc;
    Layout_Report_Vehicle.VINA_Number_Of_Cylinders;
    Layout_Report_Vehicle.VINA_Engine_Size;
    Layout_Report_Vehicle.Fuel_Type_Name;
  END;

  EXPORT bip_ids := RECORD
    UNSIGNED6 DotID := 0;
    UNSIGNED6 EmpID := 0;
    UNSIGNED6 POWID := 0;
    UNSIGNED6 ProxID := 0;
    UNSIGNED6 SELEID := 0;
    UNSIGNED6 OrgID := 0;
    UNSIGNED6 UltID := 0;
  END;
  
  EXPORT Vin_BatchIn := RECORD
    doxie.layout_inBatchMaster;
    STRING8 date := ''; // For VehicleV2 VIN/LicPlate
    STRING9 FEIN := '';
    STRING120 comp_name := '';
    STRING72 sic_code := '';
    STRING14 filing_number := ''; // For UCC Liens.
    STRING45 apn := '';
    STRING5 fips_code := '';
    UNSIGNED6 bdid := 0;
    UNSIGNED3 score_bdid := 0;
    bip_ids;
  END;
  
  EXPORT RealTime_InLayout := RECORD
    doxie.layout_inBatchMaster.acctNo;
    STRING120 name_full;
    doxie.layout_inBatchMaster.name_first;
    doxie.layout_inBatchMaster.name_middle;
    doxie.layout_inBatchMaster.name_last;
    doxie.layout_inBatchMaster.name_suffix;
    Autokey_batch.Layouts.rec_inBatchMaster.comp_name;
    STRING200 addr1;
    STRING100 addr2;
    doxie.layout_inBatchMaster.p_city_name;
    doxie.layout_inBatchMaster.st;
    doxie.layout_inBatchMaster.z5;
    Layout_VKeysWithInput.year;
    Layout_VKeysWithInput.make;
    Layout_VKeysWithInput.model;
    STRING17 vinIn;
    doxie.layout_inBatchMaster.plate;
    doxie.layout_inBatchMaster.plateState;
    Autokey_batch.Layouts.rec_inBatchMaster.date;
  END;

  EXPORT RealTime_InLayout_V2 := RECORD
    RealTime_InLayout;
    doxie.layout_inBatchMaster.ssn;
    doxie.layout_inBatchMaster.dob;
    bip_ids;
  END;

  EXPORT RealTime_OutLayout := RECORD
    BOOLEAN is_current := FALSE;
    RealTime_InLayout;
    Vehicle_Layout;
    VehicleV2.Layout_Base_Party.reg_license_plate_type_desc;
    VehicleV2.Layout_Base_Party.reg_license_state;
    VehicleV2.Layout_Base_Party.reg_latest_effective_date;
    VehicleV2.Layout_Base_Party.reg_latest_expiration_date;
    VehicleV2.Layout_Base_Party.Reg_True_License_Plate;
    VehicleV2.Layout_Base_Party.Reg_License_Plate;
    reg_1_Layout.reg_1_fname;
    reg_1_Layout.reg_1_mname;
    reg_1_Layout.reg_1_lname;
    reg_1_Layout.reg_1_name_suffix;
    reg_1_Layout.reg_1_company_name;
    reg_1_Layout.reg_1_addr1;
    reg_1_Layout.reg_1_addr2;
    reg_1_Layout.reg_1_v_city_name;
    reg_1_Layout.reg_1_state;
    reg_1_Layout.reg_1_zip;
    reg_2_Layout.reg_2_fname;
    reg_2_Layout.reg_2_mname;
    reg_2_Layout.reg_2_lname;
    reg_2_Layout.reg_2_company_name;
    reg_2_Layout.reg_2_name_suffix;
    reg_2_Layout.reg_2_addr1;
    reg_2_Layout.reg_2_addr2;
    reg_2_Layout.reg_2_v_city_name;
    reg_2_Layout.reg_2_state;
    reg_2_Layout.reg_2_zip;
    vina_layout;
    le_1_layout.le_1_Orig_Name;
    le_1_layout.le_1_company_name;
    le_1_Layout.le_1_fname;
    le_1_Layout.le_1_mname;
    le_1_Layout.le_1_lname;
    le_1_Layout.le_1_name_suffix;
    // v--- lo_1_*** ("Lessor" l) fields added for RQ-14898 bug fix.
    lo_1_layout.lo_1_Orig_Name;
    lo_1_layout.lo_1_company_name;
    lo_1_Layout.lo_1_fname;
    lo_1_Layout.lo_1_mname;
    lo_1_Layout.lo_1_lname;
    lo_1_Layout.lo_1_name_suffix;
    lh_1_layout.lh_1_Orig_Name;
    lh_1_layout.lh_1_company_name;
    lh_1_Layout.lh_1_fname;
    lh_1_Layout.lh_1_mname;
    lh_1_Layout.lh_1_lname;
    lh_1_Layout.lh_1_name_suffix;
    Layout_Report_Airbag_Safety;
    Brand_Layout;
  END;

  EXPORT RealTime_OutLayout_V1 := RECORD
    RealTime_OutLayout - [Reg_True_License_Plate, Reg_License_Plate];
  END;

  EXPORT layout_out := RECORD
    Doxie.layout_inBatchMaster.acctno;
    Layout_Vehicle_Key.state_origin;
    BOOLEAN is_current := FALSE;
    // STRING2 output_type;
    /*
    Need to add output_type for each entity
    */
    // STRING10 Matchcode;
    STRING2 Source_Code;
    BOOLEAN NonDMVSource;
    STRING6 vendor_first_reported_date;
    STRING6 vendor_date;
    all_Keys;

    Vehicle_Layout;
    vina_layout;
    Plate_Layout;
    Registration_Layout;
    Title_Layout;

    own_1_layout;
    reg_1_layout;
    lh_1_layout;
    le_1_layout;
    lo_1_layout;
    
    own_2_layout;
    reg_2_layout;
    lh_2_layout;
    le_2_layout;
    lo_2_layout;
    
    own_3_layout;
    reg_3_layout;
    lh_3_layout;
    le_3_layout;
    lo_3_layout;
    Brand_Layout;
    TYPEOF(Layout_Report.min_party_penalty) penalt;
  END;
  
  EXPORT final_layout := RECORD
    layout_out - all_Keys;
  END;




END;
