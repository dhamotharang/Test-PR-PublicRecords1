IMPORT BatchShare, Doxie, doxie_crs, Watercraft, ut, FFD, BIPV2;

EXPORT Layouts := MODULE
  
  SHARED s_key_rec := RECORDOF(watercraft.key_watercraft_sid);
  
  EXPORT search_watercraftkey := RECORD
    STRING30 watercraft_key := '';
    STRING30 sequence_key := '';
    STRING2 state_origin := '';
    BOOLEAN isDeepDive := FALSE;
    UNSIGNED6 subject_did := 0;
  END;
  
  EXPORT search_hullnum := RECORD
    STRING30 hull_num := '';
  END;
  
  EXPORT search_offnum := RECORD
    STRING10 off_num := '';
  END;

  EXPORT search_vesselname := RECORD
    STRING50 vessel_name := '';
  END;

  EXPORT acct_rec:= RECORD
    Doxie.layout_inBatchMaster.acctno;
    UNSIGNED6 ldid;
    UNSIGNED6 lbdid;
    search_watercraftkey AND NOT [subject_did];
    BIPV2.IDlayouts.l_header_ids;
  END;
  
  EXPORT batch_in := RECORD
    BatchShare.Layouts.ShareAcct;
    BatchShare.Layouts.ShareDid;
    BatchShare.Layouts.ShareName;
    BatchShare.Layouts.ShareAddress;
    BatchShare.Layouts.SharePII;
    STRING10 homephone := '';
    STRING120 comp_name := '';
    STRING9 FEIN := '';
    BIPV2.IDlayouts.l_header_ids;
  END;
  
  EXPORT ak_payload_rec := RECORD
    Watercraft.Layout_Watercraft_Search_Base.watercraft_key;
    Watercraft.Layout_Watercraft_Search_Base.sequence_key;
    Watercraft.Layout_Watercraft_Search_Base.state_origin;
    Watercraft.Layout_Watercraft_Search_Base.fname;
    Watercraft.Layout_Watercraft_Search_Base.lname;
    Watercraft.Layout_Watercraft_Search_Base.mname;
    Watercraft.Layout_Watercraft_Search_Base.dob;
    Watercraft.Layout_Watercraft_Search_Base.prim_name;
    Watercraft.Layout_Watercraft_Search_Base.prim_range;
    Watercraft.Layout_Watercraft_Search_Base.st;
    Watercraft.Layout_Watercraft_Search_Base.zip5;
    Watercraft.Layout_Watercraft_Search_Base.sec_range;
    Watercraft.Layout_Watercraft_Search_Base.company_name;
    UNSIGNED6 ldid;
    UNSIGNED6 lbdid;
    STRING10 phone;
    UNSIGNED1 zero;
    STRING25 city;
    STRING2 bstate;
    STRING25 bcity;
    STRING10 bphone;
    STRING10 bprim_range;
    STRING28 bprim_name;
    STRING8 bsec_range;
    STRING5 bzip5;
    STRING9 fein_use;
    STRING9 ssn_use;
    Watercraft.Layout_Watercraft_Search_Base.global_sid;
    Watercraft.Layout_Watercraft_Search_Base.record_sid;
  END;
  
  EXPORT flat_s := RECORD
    search_watercraftkey AND NOT [subject_did];
    STRING25 state_origin_full := '';
    STRING10 rec_type;
    s_key_rec.date_last_seen;
    BOOLEAN NonDMVSource;
  END;
  
  EXPORT flat_c := RECORD
    STRING50 name_of_vessel := '';
    //description
    STRING6 registered_breadth := '';
    STRING6 registered_depth := '';
    STRING7 registered_length := '';
    STRING7 registered_gross_tons := '';
    STRING7 registered_net_tons := '';
    //registration
    STRING5 registration_status_code := '';
    STRING40 registration_status_description := '';
    STRING20 registration_number := '';
    STRING8 registration_date := '';
    STRING8 registration_expiration_date := '';
    STRING7 main_hp_ahead;
    STRING7 main_hp_astern; //manufacturer
    STRING50 ship_yard := '';
    //hailing port
    STRING50 hailing_port := '';
    STRING2 hailing_port_state := '';
    STRING50 hailing_port_province := '';
    //vessel build
    STRING4 vessel_build_year := '';
    STRING50 vessel_complete_build_city := '';
    STRING2 vessel_complete_build_state := '';
    STRING50 vessel_complete_build_province := '';
    STRING64 vessel_complete_build_country := '';
    STRING50 vessel_hull_build_city := '';
    STRING2 vessel_hull_build_state := '';
    STRING50 vessel_hull_build_province := '';
    STRING64 vessel_hull_build_country := '';
    //vessel info
    STRING10 vessel_id;
    STRING10 vessel_database_key;
    STRING8 call_sign;
    STRING30 imo_number;
    STRING10 party_identification_number;
    //itc
    STRING7 itc_gross_tons;
    STRING7 itc_net_tons;
    STRING7 itc_length;
    STRING6 itc_breadth;
    STRING6 itc_depth;
    //home port
    STRING50 home_port_name;
    STRING2 home_port_state;
    STRING50 home_port_province;
  END;
  
  EXPORT flat_w := RECORD
    //description
    STRING30 hull_number := '';
    STRING5 hull_type_code := '';
    STRING20 hull_type_description := '';
    //wk description
    STRING5 watercraft_length := '';
    STRING5 watercraft_width := '';
    STRING10 watercraft_weight := '';
    STRING5 watercraft_class_code := '';
    STRING35 watercraft_class_description := '';
    STRING5 watercraft_make_code := '';
    STRING30 watercraft_make_description := '';
    STRING5 watercraft_model_code := '';
    STRING30 watercraft_model_description := '';
    STRING3 watercraft_color_1_code := '';
    STRING20 watercraft_color_1_description := '';
    STRING3 watercraft_color_2_code := '';
    STRING20 watercraft_color_2_description := '';
    STRING4 model_year := '';
    //additional desc
    STRING5 use_code := '';
    STRING20 use_description := '';
    STRING2 propulsion_code := '';
    STRING20 propulsion_description := '';
    STRING1 fuel_code := '';
    STRING20 fuel_description := '';
    //title
    STRING2 title_state := '';
    STRING5 title_status_code := '';
    STRING40 title_status_description := '';
    STRING20 title_number := '';
    STRING5 title_type_code := '';
    STRING20 title_type_description := '';
    STRING8 title_issue_date := '';
    //purchase
    STRING2 state_purchased := '';
    STRING8 purchase_date := '';
    STRING10 purchase_price := '';
    STRING40 dealer := '';
    STRING1 new_used_flag;
    //registration_info
    STRING2 st_registration := '';
    STRING15 county_registration := '';
    STRING8 registration_status_date := '';
    STRING8 registration_renewal_date := '';
    STRING20 decal_number := '';
    STRING5 transaction_type_code := '';
    STRING40 transaction_type_description := '';
    STRING40 watercraft_toilet_description;
    STRING4 signatory := '' ;
    //vessel desc
    STRING2 vehicle_type_code := '';
    STRING20 vehicle_type_description := '';
    STRING2 watercraft_number_of_engines := '';
    //coast guard
    STRING1 coast_guard_documented_flag := '';
    STRING30 coast_guard_number := '';
  END;
  
  EXPORT flat_rec := RECORD
    flat_s;
    flat_c AND NOT [registration_status_code];
    flat_w AND NOT [hull_type_code, watercraft_class_code,
                    watercraft_make_code, watercraft_model_code,
                    watercraft_color_1_code, watercraft_color_2_code,
                    use_code, propulsion_code, fuel_code,
                    title_status_code, title_type_code,
                    county_registration, transaction_type_code,
                    vehicle_type_code, watercraft_number_of_engines,
                    coast_guard_documented_flag];
  END;
  
  EXPORT owner_report_rec := RECORD
    doxie_crs.layout_watercraft_owner;
    BIPV2.IDlayouts.l_header_ids;
    s_key_rec.orig_address_1;
    s_key_rec.orig_address_2;
    s_key_rec.orig_country;
    s_key_rec.orig_province;
    s_key_rec.orig_fips;
    STRING8 gender;
    s_key_rec.orig_name;
    s_key_rec.orig_name_first;
    s_key_rec.orig_name_middle;
    s_key_rec.orig_name_last;
    s_key_rec.bdid;
    s_key_rec.orig_fein; // this should be changed to fein when autokeys are rebuilt
    s_key_rec.fein; //added fein field
    s_key_rec.orig_ssn;
    s_key_rec.phone_1;
    s_key_rec.phone_2;
    FFD.Layouts.CommonRawRecordElements;
  END;
                                        
  EXPORT owner_search_rec := RECORD
    UNSIGNED2 penalt := 0;
    owner_report_rec AND NOT [orig_name_first, orig_name_middle, orig_name_last,
                                 orig_country, orig_province, orig_fips, gender];
  END;
  
  EXPORT owner_raw_rec := RECORD
    s_key_rec.dppa_flag;
    UNSIGNED2 penalt := 0;
    UNSIGNED6 subject_did;
    BIPV2.IDlayouts.l_header_ids;
    flat_s;
    owner_report_rec;
    s_key_rec.persistent_record_id;
  END;

  EXPORT engine_rec := RECORD
    doxie_crs.layout_watercraft_engine;
    STRING20 engine_number;
    STRING4 engine_year;
    STRING2 watercraft_number_of_engines;
  END;
  
  EXPORT lien_rec := RECORD
    doxie_crs.layout_watercraft_lien;
    STRING8 lien_date;
    STRING1 lien_indicator;
  END;
  
  EXPORT wc_desc := RECORD
    STRING40 watercraft_name := '';
    flat_w;
    flat_c AND NOT [name_of_vessel, registered_length, ship_yard];
  END;
  
  EXPORT engine_1_layout := RECORD
    STRING20 engine_1_number := '';
    STRING20 engine_1_make := '';
    STRING20 engine_1_model := '';
    STRING4 engine_1_year := '';
    STRING5 watercraft_hp_1:= '';
  END;

  EXPORT engine_2_layout := RECORD
    STRING20 engine_2_number := '';
    STRING20 engine_2_make := '';
    STRING20 engine_2_model := '';
    STRING4 engine_2_year := '';
    STRING5 watercraft_hp_2:= '';
  END;
  
  EXPORT engine_3_layout := RECORD
    STRING20 engine_3_number := '';
    STRING20 engine_3_make := '';
    STRING20 engine_3_model := '';
    STRING4 engine_3_year := '';
    STRING5 watercraft_hp_3:= '';
  END;
  
    EXPORT own1_layout := RECORD
      //person and address info
      STRING12 did_1;
      STRING12 bdid_1;
      UNSIGNED6 ultID_1;
      UNSIGNED6 orgID_1;
      UNSIGNED6 seleID_1;
      UNSIGNED6 proxID_1;
      UNSIGNED6 powID_1;
      UNSIGNED6 empID_1;
      UNSIGNED6 dotID_1;
      STRING100 orig_name_1:= '';
      STRING1 orig_name_type_code_1:= '';
      STRING20 orig_name_type_description_1:= '';
      STRING25 orig_name_first_1:= '';
      STRING25 orig_name_middle_1:= '';
      STRING25 orig_name_last_1:= '';
      STRING60 orig_address_1_1:= '';
      STRING60 orig_address_2_1:= '';
      STRING5 orig_fips_1:= '';
      STRING30 orig_province_1:='';
      STRING30 orig_country_1:='';
      STRING8 dob_1:= '';
      STRING9 orig_ssn_1:= '';
      STRING9 orig_fein_1:= '';
      STRING1 gender_1:= '';
      STRING10 phone_1_1:= '';
      STRING10 phone_2_1:= '';
      STRING5 title_1:= '';
      STRING20 fname_1:= '';
      STRING20 mname_1:= '';
      STRING20 lname_1:= '';
      STRING5 name_suffix_1:= '';
      STRING60 company_name_1:= '';
      STRING10 prim_range_1:= '';
      STRING2 predir_1:= '';
      STRING28 prim_name_1:= '';
      STRING4 suffix_1:= '';
      STRING2 postdir_1:= '';
      STRING10 unit_desig_1:= '';
      STRING8 sec_range_1:= '';
      STRING25 p_city_name_1:= '';
      STRING25 v_city_name_1:= '';
      STRING2 st_1:= '';
      STRING5 zip5_1:= '';
      STRING4 zip4_1:= '';
      STRING3 county_1:= '';
  END;
  
  EXPORT own2_layout := RECORD
      //person and address info
      STRING12 did_2;
      STRING12 bdid_2;
      UNSIGNED6 ultID_2;
      UNSIGNED6 orgID_2;
      UNSIGNED6 seleID_2;
      UNSIGNED6 proxID_2;
      UNSIGNED6 powID_2;
      UNSIGNED6 empID_2;
      UNSIGNED6 dotID_2;
      STRING100 orig_name_2:= '';
      STRING1 orig_name_type_code_2:= '';
      STRING20 orig_name_type_description_2:= '';
      STRING25 orig_name_first_2:= '';
      STRING25 orig_name_middle_2:= '';
      STRING25 orig_name_last_2:= '';
      STRING60 orig_address_1_2:= '';
      STRING60 orig_address_2_2:= '';
      STRING5 orig_fips_2:= '';
      STRING30 orig_province_2:='';
      STRING30 orig_country_2:='';
      STRING8 dob_2:= '';
      STRING9 orig_ssn_2:= '';
      STRING9 orig_fein_2:= '';
      STRING1 gender_2:= '';
      STRING10 phone_1_2:= '';
      STRING10 phone_2_2:= '';
      STRING5 title_2:= '';
      STRING20 fname_2:= '';
      STRING20 mname_2:= '';
      STRING20 lname_2:= '';
      STRING5 name_suffix_2:= '';
      STRING60 company_name_2:= '';
      STRING10 prim_range_2:= '';
      STRING2 predir_2:= '';
      STRING28 prim_name_2:= '';
      STRING4 suffix_2:= '';
      STRING2 postdir_2:= '';
      STRING10 unit_desig_2:= '';
      STRING8 sec_range_2:= '';
      STRING25 p_city_name_2:= '';
      STRING25 v_city_name_2:= '';
      STRING2 st_2:= '';
      STRING5 zip5_2:= '';
      STRING4 zip4_2:= '';
      STRING3 county_2:= '';
  END;
  
  EXPORT LH1_Layout := RECORD
    STRING40 lien_name_1;
    STRING60 lien_address_1_1;
    STRING60 lien_address_2_1;
    STRING25 lien_city_1;
    STRING2 lien_state_1;
    STRING10 lien_zip_1;
    STRING8 lien_date_1;
    STRING1 lien_indicator_1;
  END;
  
  EXPORT LH2_Layout := RECORD
    STRING40 lien_name_2;
    STRING60 lien_address_1_2;
    STRING60 lien_address_2_2;
    STRING25 lien_city_2;
    STRING2 lien_state_2;
    STRING10 lien_zip_2;
    STRING8 lien_date_2;
    STRING1 lien_indicator_2;
  END;
  
  EXPORT search_out := RECORD
    BOOLEAN isDeepDive := FALSE;
    UNSIGNED2 penalt :=0;
    UNSIGNED6 subject_did;
    STRING30 watercraft_key;
    STRING30 sequence_key;
    STRING2 state_origin;
    STRING8 date_last_seen;
    BOOLEAN NonDMVSource;
    STRING30 hull_number;
    STRING40 watercraft_name;
    STRING8 registration_date;
    STRING20 registration_number;
    STRING30 Make;
    STRING30 Model;
    UNSIGNED2 YearMake;
    STRING20 MajorColor;
    STRING20 MinorColor;
    UNSIGNED2 watercraft_length;
    DATASET(engine_rec) engines {MAXCOUNT(ut.limits.MAX_WATERCRAFT_ENGINES)}; // thor_data400::key::watercraft::fcra::20160701::wid
    DATASET(owner_search_rec) owners {MAXCOUNT(ut.limits.MAX_WATERCRAFT_OWNERS)}; // thor_data400::key::watercraft::fcra::20160701::sid
    //thor_data400::key::watercraft::fcra::20160701::cid & thor_data400::key::watercraft::fcra::20160701::wid
    FFD.Layouts.CommonRawRecordElements;
  END;
  
  EXPORT report_out := RECORD
    flat_rec;
    DATASET(engine_rec) engines {MAXCOUNT(ut.limits.MAX_WATERCRAFT_ENGINES)};
    DATASET(lien_rec) lienholders {MAXCOUNT(ut.limits.MAX_WATERCRAFT_LH)};
    DATASET(owner_report_rec) owners {MAXCOUNT(ut.limits.MAX_WATERCRAFT_OWNERS)};
    FFD.Layouts.CommonRawRecordElements;
  END;
  
  EXPORT batch_out :=RECORD
    //key info
    batch_in.acctno;
    STRING1 output_type := '';
    search_watercraftkey AND NOT [isDeepDive, subject_did];
    STRING10 watercraft_id:= '';
    STRING2 source_code:= '';
    BOOLEAN NonDMVSource;
    wc_desc;
    engine_1_layout;
    engine_2_layout;
    engine_3_layout;
    own1_layout;
    own2_layout;
    LH1_Layout;
    LH2_Layout;
    UNSIGNED2 penalt := 0;
    Batchshare.layouts.ShareErrors;
    FFD.Layouts.ConsumerStatementBatch.SequenceNumber;
    FFD.Layouts.ConsumerFlags;
    STRING12 inquiry_lexid := '';
  END;
  
  EXPORT batch_out_pre :=RECORD(batch_out)
    DATASET (FFD.Layouts.ConsumerStatementBatch) statements;
  END;
  
  
  main_rec := Watercraft.Layout_Watercraft_Main_Base;
  SHARED ExtraInfo := RECORD
    acct_rec.acctno; //for batch
    UNSIGNED2 penalt := 0; //for batch
    main_rec.propulsion_code;
    main_rec.vehicle_type_code;
    main_rec.hull_type_code;
    main_rec.watercraft_make_code;
  END;

  EXPORT WCReportEX := RECORD
    report_out;
    ExtraInfo;
    UNSIGNED6 subject_did;
  END;

  EXPORT batch_report := RECORD (WCReportEX)
    BatchShare.Layouts.ShareErrors;
  END;
  
  EXPORT int_raw_rec := RECORD
    s_key_rec.dppa_flag;
    UNSIGNED2 penalt := 0;
    UNSIGNED6 subject_did;
    flat_s;
    DATASET(owner_report_rec) owners {MAXCOUNT(20)};
  END;
  
  EXPORT c_key_plus_rec := RECORD
    UNSIGNED6 subject_did;
    Watercraft.Layout_Watercraft_Coastguard_Base;
    DATASET(FFD.Layouts.StatementIdRec) StatementIds := DATASET([],FFD.Layouts.StatementIdRec);
    BOOLEAN isDisputed := FALSE;
  END;

  EXPORT s_key_plus_rec := RECORD
    UNSIGNED6 subject_did;
    Watercraft.Layout_Watercraft_Search_Base_slim;
    DATASET(FFD.Layouts.StatementIdRec) StatementIds := DATASET([],FFD.Layouts.StatementIdRec);
    BOOLEAN isDisputed := FALSE;
  END;

  EXPORT w_key_plus_rec := RECORD
    UNSIGNED6 subject_did;
    Watercraft.Layout_Watercraft_Main_Base;
    DATASET(FFD.Layouts.StatementIdRec) StatementIds := DATASET([],FFD.Layouts.StatementIdRec);
    BOOLEAN isDisputed := FALSE;
  END;
  
END;
