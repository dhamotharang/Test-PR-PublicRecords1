IMPORT DriversV2, doxie, doxie_build;

EXPORT layouts := MODULE
  
  EXPORT key_dl := DriversV2.Key_DL_Seq;
  EXPORT key_conviction := DriversV2.Key_DL_Conviction_DLCPKey;
  EXPORT key_suspension := DriversV2.Key_DL_Suspension_DLCPKey;
  EXPORT key_drinfo := DriversV2.Key_DL_DR_Info_DLCPKey;
  EXPORT key_accident := DriversV2.Key_DL_Accident_DLCPKey;
  EXPORT key_insurance := DriversV2.Key_DL_FRA_Insurance_DLCPKey;
  
  EXPORT src := RECORD
    key_dl;
  END;
  
  EXPORT seq := RECORD
    key_dl.dl_seq;
  END;
  
  EXPORT search_ids := RECORD
    seq;
    BOOLEAN isDeepDive := FALSE;
  END;
  
  EXPORT num := RECORD
    key_dl.dl_number;
  END;
  
  EXPORT snum := RECORD
    key_dl.dl_number;
    key_dl.orig_state;
  END;

  EXPORT did := doxie.layout_references;
  
  EXPORT pen := RECORD
    UNSIGNED2 penalt;
  END;
  
  EXPORT name := MODULE
    EXPORT narrow := RECORD
      key_dl.name;
      key_dl.title;
      key_dl.fname;
      key_dl.mname;
      key_dl.lname;
      key_dl.name_suffix;
    END;
    EXPORT wide := RECORD
      narrow;
      key_dl.name_change;
    END;
  END;
  
  EXPORT address := MODULE
    EXPORT narrow := RECORD
      key_dl.addr1;
      key_dl.city;
      key_dl.state;
      key_dl.zip;
      
      key_dl.prim_range;
      key_dl.predir;
      key_dl.prim_name;
      key_dl.suffix;
      key_dl.postdir;
      key_dl.unit_desig;
      key_dl.sec_range;
      key_dl.p_city_name;
      key_dl.v_city_name;
      key_dl.st;
      key_dl.zip5;
      key_dl.zip4;
    END;
    EXPORT wide := RECORD
      narrow;
      key_dl.address_change;
      key_dl.country;
      key_dl.postal_code;
      key_dl.province;
    END;
  END;
  
  EXPORT individual := MODULE
    EXPORT narrow := RECORD
      key_dl.did; // needed for suppression
      key_dl.dob;
      key_dl.race;
      key_dl.sex_flag;
      key_dl.ssn;
      key_dl.height;
      key_dl.hair_color;
      key_dl.eye_color;
      key_dl.weight;
      key_dl.history;
      
      // derived fields
      STRING20 race_name; // max=15
      STRING10 sex_name; // max=7
      STRING10 hair_color_name; // max=9
      STRING15 eye_color_name; // max=11
      STRING10 history_name; // max=10
    END;
    EXPORT wide := RECORD
      narrow;
      key_dl.dod;
      key_dl.age;
      key_dl.privacy_flag; // needed for DPPA
    END;
  END;
  
  EXPORT DLinfo := MODULE
    EXPORT narrow := RECORD
      key_dl.license_type;
      key_dl.license_class;
      key_dl.status;
      key_dl.cdl_status;
      key_dl.attention_flag;
      key_dl.lic_issue_date;
      key_dl.expiration_date;
      key_dl.motorcycle_code;
      key_dl.dl_number;
      key_dl.orig_state; // listed as "state_origin" in spreadsheet
      key_dl.county;
      key_dl.rec_type;
      key_dl.restrictions_delimited;
      key_dl.lic_endorsement;
      key_dl.oos_previous_dl_number;
      key_dl.oos_previous_st;
      
      // derived fields
      STRING75 license_type_name; // max=69
      STRING250 license_class_name; // max=241
      STRING50 status_name; // max=33
      STRING50 cdl_status_name; // max=33
      STRING25 attention_name; // max=22
      STRING20 orig_state_name; // max=20
      STRING18 county_name; // max=18
      STRING120 restriction1; // max=107
      STRING120 restriction2; // max=107
      STRING120 restriction3; // max=107
      STRING120 restriction4; // max=107
      STRING120 restriction5; // max=107
      STRING135 endorsement1; // max=131
      STRING135 endorsement2; // max=131
      STRING135 endorsement3; // max=131
      STRING135 endorsement4; // max=131
      STRING135 endorsement5; // max=131
    END;
    EXPORT wide := RECORD
      narrow;
      key_dl.orig_expiration_date;
      key_dl.orig_issue_date;
      key_dl.active_date;
      key_dl.inactive_date;
      key_dl.issuance;
      key_dl.old_dl_number;
      
      // derived fields
      UNSIGNED1 age_today;
      UNSIGNED1 dead_age;
    END;
  END;
  
  EXPORT result_narrow := RECORD
    seq;
    pen;
    STRING9 source_code;
    STRING1 nonDMVsource;
    UNSIGNED8 dt_first_seen;
    UNSIGNED8 dt_last_seen;
    name.narrow;
    address.narrow;
    individual.narrow;
    DLinfo.narrow;
  END;
  
  EXPORT result_wide := RECORD
    seq;
    pen;
    STRING9 source_code;
    STRING1 nonDMVsource;
    UNSIGNED8 dt_first_seen;
    UNSIGNED8 dt_last_seen;
    name.wide;
    address.wide;
    individual.wide;
    DLinfo.wide;
    INTEGER2 addr_no := 0;
  END;
  EXPORT result_wide_tmp := RECORD
    result_wide;
    
    // This is needed to join with the CP keys
    key_dl.dlcp_key;
    
    // These are all needed for MOXIE
    key_dl.Preglb_did; // STUB - is this RIGHT?
    key_dl.cleaning_score;
    key_dl.addr_fix_flag;
    key_dl.cart;
    key_dl.cr_sort_sz;
    key_dl.lot;
    key_dl.lot_order;
    key_dl.dpbc;
    key_dl.chk_digit;
    key_dl.ace_fips_st;
    key_dl.geo_lat;
    key_dl.geo_long;
    key_dl.msa;
    key_dl.geo_blk;
    key_dl.geo_match;
    key_dl.err_stat;
    key_dl.dob_change;
    key_dl.sex_change;
    key_dl.driver_edu_code;
    key_dl.dup_lic_count;
    key_dl.rcd_stat_flag;
    key_dl.dl_key_number;
    key_dl.restrictions;
    key_dl.moxie_license_type;
    
    // and these are needed for legacy
    key_dl.dt_vendor_first_reported;
    key_dl.dt_vendor_last_reported;
    key_dl.record_type;
    key_dl.ssn_safe;
  END;
  
  // conviction points
  EXPORT cp := MODULE
    EXPORT conviction := RECORD
      key_conviction.type_cd; // "type"
      key_conviction.type_desc;
      key_conviction.violation_date;
      key_conviction.plate_nbr;
      key_conviction.conviction_date;
      key_conviction.court_name_cd;
      key_conviction.court_name_desc;
      key_conviction.court_county;
      key_conviction.court_type_cd; // "court_type"
      key_conviction.court_type_desc; // "court_type"
      key_conviction.st_offense_conv_cd; // "offense"
      key_conviction.st_offense_conv_desc; // "offense"
      key_conviction.sentence;
      key_conviction.sentence_desc;
      key_conviction.points;
      key_conviction.hazardous_cd;
      key_conviction.hazardous_desc;
      key_conviction.plea_cd; // "plea"
      key_conviction.plea_desc; // "plea"
      key_conviction.court_case_nbr;
      key_conviction.acd_offense_cd; // "offense_code"
      key_conviction.acd_offense_desc; // "offense_desc"
      key_conviction.vehicle_no;
      key_conviction.reduced_cd;
      key_conviction.reduced_desc;
      key_conviction.create_date;
      key_conviction.bmv_case_nbr_1;
      key_conviction.bmv_case_nbr_2;
      key_conviction.bmv_case_nbr_3;
      key_conviction.habitual_case_nbr;
      key_conviction.filed_date;
      key_conviction.expunged_date;
      key_conviction.jurisdiction;
      key_conviction.soa_conviction;
      key_conviction.bmv_sp_case_nbr;
      key_conviction.out_of_state_dl_nbr;
      key_conviction.state_of_origin;
      key_conviction.county;
    END;
    
    EXPORT suspension := RECORD
      key_suspension.type_cd; // "type"
      key_suspension.type_desc;
      key_suspension.violation_date;
      key_suspension.clear_date;
      key_suspension.filed_date;
      key_suspension.action_date;
      key_suspension.start_date;
      key_suspension.end_date;
      key_suspension.bmv_case_nbr_1;
      key_suspension.court_case_nbr;
      key_suspension.court_name_cd; // "court_name_code"
      key_suspension.court_name_desc; // "court_name_code"
      key_suspension.court_county;
      key_suspension.court_type;
      key_suspension.st_offense_conv_cd; // "offense_conv"
      key_suspension.st_offense_conv_desc; // "offense_desc"
      key_suspension.vehicle_no_cd;
      key_suspension.vehicle_no_desc;
      key_suspension.hazardous_cd;
      key_suspension.hazardous_desc;
      key_suspension.jurisdiction;
      key_suspension.fee_pd_date;
      key_suspension.plate_nbr;
      key_suspension.cdl_disq_reason_cd;
      key_suspension.cdl_disq_reason_desc;
      key_suspension.cdl_ofs_disqual_reason_cd;
      key_suspension.cdl_ofs_disqual_reason_desc;
      key_suspension.disq_ext_cd;
      key_suspension.disq_ext_desc;
      key_suspension.disq_reason_ref;
      key_suspension.disq_reason_desc;
      key_suspension.sd_nbr;
      key_suspension.wd_clear_reason_cd;
      key_suspension.wd_clear_reason_desc;
      key_suspension.naic_ins_cd; // "naic_ins_code"
      key_suspension.naic_ins_desc; // "naic_ins_code"
      key_suspension.ins_bnd_filing_ind;
      key_suspension.cleared_date;
      key_suspension.wd_reason_cd;
      key_suspension.wd_reason_desc;
      key_suspension.remedial_drv_crs_dt;
      key_suspension.exam_date;
      key_suspension.acd_offense_cd;
      key_suspension.acd_offense_desc;
      key_suspension.wd_status_cd;
      key_suspension.wd_status_desc;
      key_suspension.mod_drv_date;
      key_suspension.settle_agree_date;
      key_suspension.restriction_cd;
      key_suspension.restriction_desc;
      key_suspension.conviction_date;
      key_suspension.appeal_file_date;
      key_suspension.appeal_deny_date;
      key_suspension.appeal_granted_date;
      key_suspension.plea_cd;
      key_suspension.plea_desc;
      key_suspension.suspension_revocation;
      key_suspension.county_cd;
      key_suspension.county_desc;
      key_suspension.arrest_date;
      key_suspension.license_number;
      key_suspension.create_date;
      key_suspension.license_rec_date;
      key_suspension.plate_rec_date;
      key_suspension.fra_sup_start_date;
      key_suspension.fra_sup_end_date;
      key_suspension.accident_date;
      key_suspension.related_bmv_case_nbr;
      key_suspension.narrative_cd;
      key_suspension.narrative_desc;
      key_suspension.fee_required;
      key_suspension.vehicle_owner_ind;
      key_suspension.soa_conviction;
      key_suspension.expunged_date;
      key_suspension.modified_drv_end_dt;
      key_suspension.appeal_sup_stay;
      key_suspension.wd_type_detail;
      key_suspension.hp_license_cancel;
      key_suspension.bmv_dl_case_nbr;
      key_suspension.related_bmv_case_nbr_2;
      key_suspension.fine_paid_date; // "fine_paid"
      key_suspension.csea;
      key_suspension.csea_case_nbr;
      key_suspension.csea_order_nbr;
      key_suspension.csea_part_nbr;
    END;
    
    EXPORT drinfo := RECORD
      key_drinfo.action_date;
      key_drinfo.bmv_case_nbr_1;
      key_drinfo.clear_date;
      key_drinfo.cosigners_dl_nbr;
      key_drinfo.cosigners_name;
      key_drinfo.cosigners_relationship;
      key_drinfo.court_case_nbr;
      key_drinfo.create_date;
      key_drinfo.dl_nbr;
      key_drinfo.expunged_date;
      key_drinfo.mailed_date;
      key_drinfo.narrative;
      key_drinfo.out_of_state_dl_nbr;
      key_drinfo.remedial_require_comp;
      key_drinfo.remedial_require_denied;
      key_drinfo.type_cd;
      key_drinfo.type_desc;
      key_drinfo.warrant_eff_date;
    END;
    
    EXPORT accident := RECORD
      key_accident.type_cd;
      key_accident.type_desc;
      key_accident.county;
      key_accident.jurisdiction;
      STRING18 county_name :=''; // max=18
      key_accident.severity_cd;
      key_accident.severity_desc;
      key_accident.accident_date;
      key_accident.vehicle_no;
      key_accident.hazardous_cd;
      key_accident.hazardous_desc;
      key_accident.create_date;
      key_accident.bmv_case_nbr_1;
      key_accident.expunged_date;
    END;
    
    EXPORT insurance := RECORD
      key_insurance.cancel_posted_date;
      key_insurance.create_date;
      key_insurance.filed_date;
      key_insurance.ins_cancel_dt;
      key_insurance.ins_policy_nbr;
      key_insurance.insurance_co_cd;
      key_insurance.insurance_co_desc;
      key_insurance.latest_proof_start_dt;
      key_insurance.proof_end_date;
      key_insurance.proof_start_date;
    END;
  END;

  EXPORT max_dl := 100;
  EXPORT max_dlcp_raw := 1000;
  EXPORT max_convictions := 200; // 470 - 5/27/08
  EXPORT max_suspensions := 200; // 872 - 5/27/08
  EXPORT max_drinfo := 200; // 317 - 5/27/08
  EXPORT max_accidents := 200; // 46 - 5/27/08
  EXPORT max_insurance := 200; // 253 - 5/27/08
  
  // Actual counts generated with...
  // output( choosen( sort( table( pull(key_conviction), {DLCP_Key, cnt:=count(group)}, DLCP_Key, many, unsorted ), -cnt), 1) );
  // output( choosen( sort( table( pull(key_suspension), {DLCP_Key, cnt:=count(group)}, DLCP_Key, many, unsorted ), -cnt), 1) );
  // output( choosen( sort( table( pull(key_drinfo), {DLCP_Key, cnt:=count(group)}, DLCP_Key, many, unsorted ), -cnt), 1) );
  // output( choosen( sort( table( pull(key_accident), {DLCP_Key, cnt:=count(group)}, DLCP_Key, many, unsorted ), -cnt), 1) );
  // output( choosen( sort( table( pull(key_insurance), {DLCP_Key, cnt:=count(group)}, DLCP_Key, many, unsorted ), -cnt), 1) );
  
  EXPORT result_rolled := RECORD
    key_dl.dlcp_key;
    DATASET(result_wide) dl { MAXCOUNT(max_dl) };
    DATASET(cp.conviction) Convictions { MAXCOUNT(max_convictions) };
    DATASET(cp.suspension) Suspensions { MAXCOUNT(max_suspensions) };
    DATASET(cp.drinfo) DR_Info { MAXCOUNT(max_drinfo) };
    DATASET(cp.accident) Accidents { MAXCOUNT(max_accidents) };
    DATASET(cp.insurance) FRA_Insurance { MAXCOUNT(max_insurance) };
  END;
  
  // This layout is supplied by Lee, defining output for the moxie services
  EXPORT Layout_drivers_license2_1 := RECORD
    STRING12 did;
    STRING12 pgid;
    STRING1 history;
    STRING2 state_origin;
    STRING2 source_code;
    STRING52 name;
    STRING40 addr1;
    STRING20 city;
    STRING2 state;
    STRING5 zip;
    STRING8 dob;
    STRING1 race;
    STRING1 sex_flag;
    STRING4 license_type;
    STRING14 attention_flag;
    STRING8 dod;
    STRING42 restrictions;
    STRING42 restrictions_delimited;
    STRING8 expiration_date;
    STRING8 lic_issue_date;
    STRING10 lic_endorsement;
    STRING4 motorcycle_code;
    STRING24 dl_number;
    STRING9 ssn;
    STRING3 age;
    STRING1 privacy_flag;
    STRING8 dl_orig_issue_date;
    STRING3 height;
    STRING25 oos_previous_dl_number;
    STRING2 oos_previous_st;
    STRING5 title;
    STRING20 fname;
    STRING20 mname;
    STRING20 lname;
    STRING5 name_suffix;
    STRING3 cleaning_score;
    STRING1 addr_fix_flag;
    STRING10 prim_range;
    STRING2 predir;
    STRING28 prim_name;
    STRING4 suffix;
    STRING2 postdir;
    STRING10 unit_desig;
    STRING8 sec_range;
    STRING25 p_city_name;
    STRING25 v_city_name;
    STRING2 st;
    STRING5 zip5;
    STRING4 zip4;
    STRING4 cart;
    STRING1 cr_sort_sz;
    STRING4 lot;
    STRING1 lot_order;
    STRING2 dpbc;
    STRING1 chk_digit;
    STRING2 rec_type;
    STRING2 ace_fips_st;
    STRING3 county;
    STRING10 geo_lat;
    STRING11 geo_long;
    STRING4 msa;
    STRING7 geo_blk;
    STRING1 geo_match;
    STRING4 err_stat;
    STRING1 status;
    STRING2 issuance;
    STRING8 address_change;
    STRING1 name_change;
    STRING1 dob_change;
    STRING1 sex_change;
    STRING24 old_dl_number;
    STRING1 driver_edu_code;
    STRING1 dup_lic_count;
    STRING1 rcd_stat_flag;
    STRING3 hair_color;
    STRING3 eye_color;
    STRING3 weight;
    STRING9 dl_key_number;
  END;
  
  // Extra fields are used for deduping, then thinned back out before delivery
  EXPORT moxie_tmp := RECORD
    Layout_drivers_license2_1;
    STRING10 history_name;
  END;
END;
