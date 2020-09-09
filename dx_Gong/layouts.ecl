EXPORT layouts := MODULE

  SHARED raw := RECORD
    unsigned6 did;
    $.layout_prepped_for_keys;  //almost same as gong_neustar.Layout_Gong, perhaps, this one should be a primary layout.
    unsigned4 global_sid := 0;
    unsigned8 record_sid := 0;
  END;  


  EXPORT i_phone := RECORD (raw)
    string7 ph7;
    string3 ph3;
    string7 phone7;
    string3 area_code;
    boolean business_flag;
  END;

  EXPORT i_lczf := RECORD (raw)
  END;

  EXPORT i_czsslf := RECORD (raw)
  END;

  //rec_address, as defined in Gong_Neustar\File_Address_Current.ecl
  //(Gong_neustar.key_address_current defines a subset, payload-fields)
  EXPORT i_address_current := RECORD  
    raw.prim_range;
    raw.predir;
    raw.prim_name;
    raw.suffix;
    raw.sec_range;
    raw.st;
    raw.z5;
    raw.phone10;
    raw.listed_name;
    typeof (raw.name_first) fname; 
    typeof (raw.name_middle) mname;
    typeof (raw.name_last) lname;
    raw.name_suffix;
    raw.dual_name_flag;
    string8 date_first_seen;
    unsigned1 listing_type;
    raw.publish_code;
    raw.omit_phone;
    raw.did;
    raw.global_sid;
    raw.record_sid;
  END;

  // gong_neustar.ds_surname_cnts
  EXPORT i_surname_count := RECORD
    raw.name_last;
    raw.st;
    integer cnt;
  END;

  //AreaCodeFinal, as defined in Gong_neustar.File_Npa_Zip
  EXPORT i_areacode := RECORD 
    string5 zip;
    string3 areacode;
    string3 timezone;
    integer occurs;
  END;

  //ScoringRecord == LayoutScoringAttributes.KeyLayout, as defined in Gong_Neustar\fn_phone_scoring_attributes.ecl
  EXPORT i_scoring_attributes := $.layouts_scoring.attribute_key;

  // %in_slim_rec% as defined in Gong_Neustar\MAC_hist_full_slim_fcra.ecl + two flags
  EXPORT i_history_slim := RECORD
    string2    src;
    $.layout_history.listing_type_bus;
    $.layout_history.listing_type_res;
    $.layout_history.listing_type_gov;
    $.layout_history.publish_code;
    $.layout_history.prior_area_code;
    $.layout_history.phone10; 
    $.layout_history.prim_range;
    $.layout_history.predir;
    $.layout_history.prim_name;
    $.layout_history.suffix;
    $.layout_history.postdir;
    $.layout_history.unit_desig;
    $.layout_history.sec_range;
    $.layout_history.p_city_name;
    $.layout_history.v_predir;
    $.layout_history.v_prim_name;
    $.layout_history.v_suffix;
    $.layout_history.v_postdir;
    $.layout_history.v_city_name;
    $.layout_history.st;
    $.layout_history.z5;
    $.layout_history.z4;
    $.layout_history.county_code;
    $.layout_history.geo_lat;
    $.layout_history.geo_long;
    $.layout_history.msa;
    $.layout_history.designation;
    $.layout_history.name_prefix;
    $.layout_history.name_first;
    $.layout_history.name_middle;
    $.layout_history.name_last;
    $.layout_history.name_suffix;
    $.layout_history.listed_name;
    $.layout_history.caption_text;
    $.layout_history.omit_address;
    $.layout_history.omit_phone;
    $.layout_history.omit_locality;
    $.layout_history.see_also_text;
    $.layout_history.did;
    $.layout_history.hhid;
    $.layout_history.bdid;
    $.layout_history.dt_first_seen;
    $.layout_history.dt_last_seen;
    $.layout_history.current_record_flag;  
    $.layout_history.deletion_date;
    $.layout_history.disc_cnt6;
    $.layout_history.disc_cnt12;
    $.layout_history.disc_cnt18;
    $.layout_history.persistent_record_id;
    $.layout_history.global_sid;
    $.layout_history.record_sid;
    
    // additional flags needed as keyed fields: can be moved to each layout, if needed.
    boolean current_flag;
    boolean business_flag;
  END;

  EXPORT i_history_address := RECORD (i_history_slim)
  END;

  EXPORT i_history_phone := RECORD(i_history_slim)
    string7 p7;
    string3 p3;
    string7 phone7; 
    string3 area_code; 
  END;  

  EXPORT i_history_did := RECORD(i_history_slim)
    unsigned6 l_did;  
  END;  

  EXPORT i_history_hhid := RECORD
    unsigned6 s_hhid;
    i_history_slim AND NOT [src, persistent_record_id];
  END;

  EXPORT i_history_bdid := RECORD
    i_history_slim AND NOT [src, persistent_record_id, current_flag, business_flag];
  END;

  EXPORT i_history_name := RECORD
    string6 dph_name_last;
    string20 p_name_first;
    i_history_slim AND NOT [src, persistent_record_id, current_flag, business_flag];
  END;

  EXPORT i_history_zip_name := RECORD
    string6 dph_name_last;
    string20 p_name_first;
    integer4 zip5;
    i_history_slim AND NOT [src, persistent_record_id, current_flag, business_flag];
  END;

  EXPORT i_history_npa_nxx_line := RECORD
    $.layout_prepped_for_keys;
    unsigned6 did;
    unsigned6 hhid;
    unsigned6	bdid;
    string8 dt_first_seen;
    string8 dt_last_seen;
    string1 current_record_flag;  
    string8 deletion_date;
    unsigned2 disc_cnt6 := 0;
    unsigned2 disc_cnt12 := 0;
    unsigned2 disc_cnt18 := 0;
    UNSIGNED4 global_sid := 0;
    UNSIGNED8 record_sid := 0;
    string3 npa;
    string3 nxx;
    string4 line;
    boolean current_flag;
    boolean business_flag;
  END;

  // "f_layout" as defined in Gong_Neustar.data_key_history_surname
  EXPORT i_history_surname := RECORD
    // {Gong_Neustar.Layout_HistorySurname}
    $.layout_history.listed_name;
    $.layout_history.prim_range;
    $.layout_history.predir;
    $.layout_history.prim_name;
    $.layout_history.suffix;
    $.layout_history.postdir;
    $.layout_history.unit_desig;
    $.layout_history.sec_range;
    $.layout_history.p_city_name;
    $.layout_history.v_predir;
    $.layout_history.v_prim_name;
    $.layout_history.v_suffix;
    $.layout_history.v_postdir;
    $.layout_history.v_city_name;
    $.layout_history.st;
    $.layout_history.z5;
    $.layout_history.z4;
    $.layout_history.phone10;
    $.layout_history.county_code;
    $.layout_history.name_prefix;
    $.layout_history.name_first;
    $.layout_history.name_middle;
    $.layout_history.name_last;
    $.layout_history.name_suffix;
    $.layout_history.did;
    string20 k_name_last := '';
    string20 k_name_first := '';
    string2 k_st := '';
    unsigned cnt;
  END;

  EXPORT i_history_wdtg := RECORD
    string6 dph_name_last;
    integer4 zip5;
    string20 p_name_first;
    //layout_narrow := Relocations.layout_wdtg.narrow;
    $.layout_history.listed_name;
    $.layout_history.name_prefix;
    $.layout_history.name_first;
    $.layout_history.name_middle;
    $.layout_history.name_last;
    $.layout_history.name_suffix;
    $.layout_history.prim_range;
    $.layout_history.predir;
    $.layout_history.prim_name;
    $.layout_history.suffix;
    $.layout_history.postdir;
    $.layout_history.unit_desig;
    $.layout_history.sec_range;
    $.layout_history.p_city_name;
    $.layout_history.st;
    $.layout_history.z5;
    $.layout_history.z4;
    $.layout_history.geo_lat;
    $.layout_history.geo_long;
    $.layout_history.did;
    $.layout_history.phone10;
    $.layout_history.dt_first_seen;
    $.layout_history.dt_last_seen;
    $.layout_history.current_record_flag;
    $.layout_history.deletion_date;
    typeof($.layout_history.dt_first_seen) span_first_seen;
    typeof($.layout_history.dt_last_seen)  span_last_seen;

    $.layout_history.global_sid;
    $.layout_history.record_sid;
  END;

  EXPORT i_history_companyname := RECORD
    string120 listed_name_new;
    i_history_slim AND NOT [src, persistent_record_id, business_flag];
  END;

  EXPORT i_history_city_st_name := RECORD
    unsigned4 city_code;
    string6 dph_name_last;
    string20 p_name_first;
    i_history_slim AND NOT [src, persistent_record_id, current_flag, business_flag];
    string25 city_name; // adding it as a first field will result in a smaller size: 
                        // field unsigned8 __internal_fpos__ will not appear in the index.
  END;

  EXPORT i_history_wild_name_zip := RECORD
    integer4 zip5;
    i_history_slim AND NOT [src, persistent_record_id, current_flag, business_flag];
  END;

  EXPORT i_did := RECORD (raw)
    unsigned6 l_did;
  END;

  EXPORT i_hhid := RECORD 
    unsigned6 s_hhid;
    unsigned6 hhid;
    $.layout_prepped_for_keys;
    unsigned4 global_sid;
    unsigned8 record_sid;
    unsigned6 did;      //CCPA-1067 Add lexid field to thor_data400::key::gong_hhid_qa key
  END;

  EXPORT i_phone10 := RECORD (raw)
  END;

  EXPORT i_cn := RECORD
    string6 dph_cn;
    $.layout_history.listed_name;
    string100 cn;
    string2 st;
    string25 p_city_name;
    string25 v_city_name;
    string5 z5;
    string10 phone10;
  END;

  EXPORT i_cn_to_company := RECORD 
    i_history_slim AND NOT [src, persistent_record_id, current_flag, business_flag];
  END;

  EXPORT i_phone_table := RECORD // rec, as defined in Risk_Indicators\Phone_Table_v2.ecl
    string10	phone10;
    boolean 	isCurrent;
    unsigned3 dt_first_seen;
    string20 	lname;
    string28 	prim_name;
    string10 	prim_range;
    string25 	city;
    string2  	state;
    STRING5  	zip5;
    STRING4  	zip4;
    boolean  	potDisconnect;
    boolean  	isaCompany;
    string1  	company_type;
    boolean  	company_type_A;
    string4  	sic_code;
    string120 company_name;
    unsigned3 hri_dt_first_seen;
    string2 	nxx_type;
    integer   did_ct;
    integer   did_ct_c6;	

    unsigned6 did := 0;
    unsigned4 global_sid := 0;
    unsigned8 record_sid := 0;    
  END;

END;
