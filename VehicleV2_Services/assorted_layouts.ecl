IMPORT BIPV2;
EXPORT asSORTed_layouts := MODULE

  EXPORT lic_plate_key_payload_fields := RECORD
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
  
  EXPORT matched_party_rec := RECORD
    STRING1 orig_name_type;
    // vehiclev2_services.Layout_Report_Party;
    STRING70 Orig_Name;
    VehicleV2_Services.layout_vehicle_party_out.layout_standard_name;
    VehicleV2_Services.layout_vehicle_party_out.layout_standard_address;
  END;
  
  EXPORT layout_match_flags := RECORD
    STRING1 surnameFlag;
    STRING1 fullNameFlag;
    STRING1 addressMatchFlag;
  END;

  EXPORT layout_crim_indicators := RECORD
    BOOLEAN HasCriminalConviction := FALSE;
    BOOLEAN IsSexualOffender := FALSE;
  END;

  EXPORT layout_registrant := RECORD
    VehicleV2_Services.Layout_vehicle_party_out.layout_vehicle_party_registrant AND NOT [append_did, append_bdid];
    STRING3 age;
    STRING12 append_did;
    STRING12 append_bdid;
    BIPV2.IDlayouts.l_header_ids;
    layout_match_flags matchFlags;
    layout_crim_indicators;
    STRING10 geo_lat := '';
    STRING11 geo_long := '';
    STRING8 title_issue_date;
    STRING1 name_source_cd;
    STRING30 name_source;
    STRING17 title_number; // populated with data from ExperianVIN gateway
    STRING30 reported_name; // populated with data from ExperianVIN gateway
  END;

  EXPORT layout_owner := RECORD
    VehicleV2_Services.Layout_vehicle_party_out.layout_vehicle_party_owner AND NOT [append_did, append_bdid];
    STRING3 age;
    STRING12 append_did;
    STRING12 append_bdid;
    BIPV2.IDlayouts.l_header_ids;
    layout_match_flags matchFlags;
    layout_crim_indicators;
    STRING10 geo_lat := '';
    STRING11 geo_long := '';
    STRING30 reported_name;
  END;
  
  EXPORT layout_lienholder := RECORD
    VehicleV2_Services.Layout_vehicle_party_out.layout_vehicle_party_lienholder AND NOT [append_did, append_bdid];
    STRING3 age;
    STRING12 append_did;
    STRING12 append_bdid;
    BIPV2.IDlayouts.l_header_ids;
    layout_match_flags matchFlags;
    layout_crim_indicators;
    STRING70 std_lienholder_name;
    STRING10 geo_lat := '';
    STRING11 geo_long := '';
    STRING1 name_source_cd;
    STRING30 name_source;
   STRING30 reported_name;
  END;
  
  EXPORT layout_lessee_or_lessor := RECORD
    VehicleV2_Services.Layout_vehicle_party_out.layout_vehicle_party_lessor AND NOT [append_did, append_bdid];
    STRING3 age;
    STRING12 append_did;
    STRING12 append_bdid;
    BIPV2.IDlayouts.l_header_ids;
    layout_match_flags matchFlags;
    layout_crim_indicators;
    STRING10 geo_lat := '';
    STRING11 geo_long := '';
    STRING1 name_source_cd;
    STRING30 name_source;
  END;

  EXPORT layout_lessee := RECORD
    VehicleV2_Services.Layout_vehicle_party_out.layout_vehicle_party_lessee AND NOT [append_did, append_bdid];
    STRING3 age;
    STRING12 append_did;
    STRING12 append_bdid;
    BIPV2.IDlayouts.l_header_ids;
    layout_match_flags matchFlags;
    layout_crim_indicators;
    STRING10 geo_lat := '';
    STRING11 geo_long := '';
  END;
  
  EXPORT layout_brand := RECORD
    STRING10 brand_date;
    STRING2 brand_state;
    STRING3 brand_code;
    STRING50 brand_type := '';
  END;
  
END;
