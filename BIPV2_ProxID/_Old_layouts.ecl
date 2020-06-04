EXPORT _Old_layouts :=
module
  
  export mc := 
  RECORD
    unsigned6 proxid;
    unsigned6 rcid;
    string9 active_duns_number;
    string9 active_enterprise_number;
    string30 active_domestic_corp_key;
    string9 hist_enterprise_number;
    string9 hist_duns_number;
    string30 hist_domestic_corp_key;
    string30 foreign_corp_key;
    string30 unk_corp_key;
    string9 ebr_file_number;
    string9 company_fein;
    unsigned1 company_fein_len;
    string120 company_name;
    string50 company_name_type_raw;
    string50 company_name_type_derived;
    string1 cnp_hasnumber;
    string30 cnp_number;
    string10 cnp_btype;
    string20 cnp_lowv;
    boolean cnp_translated;
    integer4 cnp_classid;
    string1 company_foreign_domestic;
    unsigned6 company_bdid;
    string10 company_phone;
    string28 prim_name;
    string8 sec_range;
    string25 v_city_name;
    string2 st;
    string5 zip;
    string10 prim_range;
    string10 prim_range_derived;
    unsigned4 company_csz;
    unsigned4 company_addr1;
    unsigned4 company_address;
    unsigned4 dt_first_seen;
    unsigned4 dt_last_seen;
    string2 salt_partition;
    unsigned6 ultid;
    unsigned6 orgid;
    unsigned6 lgid3;
    unsigned1 active_duns_number_prop;
    unsigned1 active_enterprise_number_prop;
    unsigned1 active_domestic_corp_key_prop;
    unsigned1 hist_enterprise_number_prop;
    unsigned1 hist_duns_number_prop;
    unsigned1 hist_domestic_corp_key_prop;
    unsigned1 foreign_corp_key_prop;
    unsigned1 unk_corp_key_prop;
    unsigned1 ebr_file_number_prop;
    unsigned1 company_fein_prop;
    unsigned1 company_name_type_derived_prop;
    unsigned1 cnp_number_prop;
    unsigned1 company_phone_prop;
    unsigned1 prim_name_derived_prop;
    unsigned1 sec_range_prop;
    unsigned1 v_city_name_prop;
    unsigned1 st_prop;
    unsigned1 zip_prop;
    unsigned1 prim_range_derived_prop;
    unsigned1 company_csz_prop;
    unsigned1 company_addr1_prop;
    unsigned1 company_address_prop;
    unsigned2 buddies;
    integer2 active_duns_number_weight100;
    boolean active_duns_number_isnull;
    integer2 active_enterprise_number_weight100;
    boolean active_enterprise_number_isnull;
    integer2 active_domestic_corp_key_weight100;
    boolean active_domestic_corp_key_isnull;
    integer2 hist_enterprise_number_weight100;
    boolean hist_enterprise_number_isnull;
    integer2 hist_duns_number_weight100;
    boolean hist_duns_number_isnull;
    integer2 hist_domestic_corp_key_weight100;
    boolean hist_domestic_corp_key_isnull;
    integer2 foreign_corp_key_weight100;
    boolean foreign_corp_key_isnull;
    integer2 unk_corp_key_weight100;
    boolean unk_corp_key_isnull;
    integer2 ebr_file_number_weight100;
    boolean ebr_file_number_isnull;
    integer2 company_fein_weight100;
    boolean company_fein_isnull;
    unsigned8 company_fein_cnt;
    unsigned8 company_fein_e1_cnt;
    string500 cnp_name;
    integer2 cnp_name_weight100;
    boolean cnp_name_isnull;
    integer2 company_name_type_derived_weight100;
    boolean company_name_type_derived_isnull;
    integer2 cnp_number_weight100;
    boolean cnp_number_isnull;
    integer2 cnp_btype_weight100;
    boolean cnp_btype_isnull;
    integer2 company_phone_weight100;
    boolean company_phone_isnull;
    string500 prim_name_derived;
    integer2 prim_name_derived_weight100;
    boolean prim_name_derived_isnull;
    integer2 sec_range_weight100;
    boolean sec_range_isnull;
    integer2 v_city_name_weight100;
    boolean v_city_name_isnull;
    integer2 st_weight100;
    boolean st_isnull;
    integer2 zip_weight100;
    boolean zip_isnull;
    integer2 prim_range_derived_weight100;
    boolean prim_range_derived_isnull;
    integer2 company_csz_weight100;
    boolean company_csz_isnull;
    integer2 company_addr1_weight100;
    boolean company_addr1_isnull;
    integer2 company_address_weight100;
    boolean company_address_isnull;
   END;

  
  export active_duns_number_childrec := RECORD
     string9 active_duns_number;
     unsigned8 cnt;
     unsigned4 id;
    END;

  export active_enterprise_number_childrec := RECORD
     string9 active_enterprise_number;
     unsigned8 cnt;
     unsigned4 id;
    END;

  export active_domestic_corp_key_childrec := RECORD
     string30 active_domestic_corp_key;
     unsigned8 cnt;
     unsigned4 id;
    END;

  export hist_enterprise_number_childrec := RECORD
     string9 hist_enterprise_number;
     unsigned8 cnt;
     unsigned4 id;
    END;

  export hist_duns_number_childrec := RECORD
     string9 hist_duns_number;
     unsigned8 cnt;
     unsigned4 id;
    END;

  export hist_domestic_corp_key_childrec := RECORD
     string30 hist_domestic_corp_key;
     unsigned8 cnt;
     unsigned4 id;
    END;

  export foreign_corp_key_childrec := RECORD
     string30 foreign_corp_key;
     unsigned8 cnt;
     unsigned4 id;
    END;

  export unk_corp_key_childrec := RECORD
     string30 unk_corp_key;
     unsigned8 cnt;
     unsigned4 id;
    END;

  export ebr_file_number_childrec := RECORD
     string9 ebr_file_number;
     unsigned8 cnt;
     unsigned4 id;
    END;

  export company_fein_childrec := RECORD
     string9 company_fein;
     unsigned8 cnt;
     unsigned4 id;
    END;

  export cnp_name_childrec := RECORD
     string250 cnp_name;
     unsigned8 cnt;
     unsigned4 id;
    END;

  export company_name_type_derived_childrec := RECORD
     string50 company_name_type_derived;
     unsigned8 cnt;
     unsigned4 id;
    END;

  export cnp_number_childrec := RECORD
     string30 cnp_number;
     unsigned8 cnt;
     unsigned4 id;
    END;

  export cnp_btype_childrec := RECORD
     string10 cnp_btype;
     unsigned8 cnt;
     unsigned4 id;
    END;

  export company_phone_childrec := RECORD
     string10 company_phone;
     unsigned8 cnt;
     unsigned4 id;
    END;

  export prim_name_derived_childrec := RECORD
     string28 prim_name_derived;
     unsigned8 cnt;
     unsigned4 id;
    END;

  export sec_range_childrec := RECORD
     string8 sec_range;
     unsigned8 cnt;
     unsigned4 id;
    END;

  export v_city_name_childrec := RECORD
     string25 v_city_name;
     unsigned8 cnt;
     unsigned4 id;
    END;

  export st_childrec := RECORD
     string2 st;
     unsigned8 cnt;
     unsigned4 id;
    END;

  export zip_childrec := RECORD
     string5 zip;
     unsigned8 cnt;
     unsigned4 id;
    END;

  export prim_range_derived_childrec := RECORD
     string10 prim_range_derived;
     unsigned8 cnt;
     unsigned4 id;
    END;

  export company_csz_childrec := RECORD
     unsigned4 company_csz;
     unsigned8 cnt;
     unsigned4 id;
    END;

  export company_addr1_childrec := RECORD
     unsigned4 company_addr1;
     unsigned8 cnt;
     unsigned4 id;
    END;

  export company_address_childrec := RECORD
     unsigned4 company_address;
     unsigned8 cnt;
     unsigned4 id;
    END;

  export dt_first_seen_childrec := RECORD
     unsigned4 dt_first_seen;
     unsigned8 cnt;
     unsigned4 id;
    END;

  export dt_last_seen_childrec := RECORD
     unsigned4 dt_last_seen;
     unsigned8 cnt;
     unsigned4 id;
    END;

  export srcridvlid_childrec := RECORD
     string basis;
     unsigned8 cnt;
     unsigned4 id;
    END;

  export uber_childrec := RECORD
     string30 word;
     unsigned8 cnt;
     unsigned4 id;
    END;


  export specs := RECORD,maxlength(32000)
    unsigned1 dummy;
    real4 active_duns_number_specificity;
    real4 active_duns_number_switch;
    real4 active_duns_number_maximum;
    DATASET(active_duns_number_childrec) nulls_active_duns_number{maxcount(100)};
    real4 active_enterprise_number_specificity;
    real4 active_enterprise_number_switch;
    real4 active_enterprise_number_maximum;
    DATASET(active_enterprise_number_childrec) nulls_active_enterprise_number{maxcount(100)};
    real4 active_domestic_corp_key_specificity;
    real4 active_domestic_corp_key_switch;
    real4 active_domestic_corp_key_maximum;
    DATASET(active_domestic_corp_key_childrec) nulls_active_domestic_corp_key{maxcount(100)};
    real4 hist_enterprise_number_specificity;
    real4 hist_enterprise_number_switch;
    real4 hist_enterprise_number_maximum;
    DATASET(hist_enterprise_number_childrec) nulls_hist_enterprise_number{maxcount(100)};
    real4 hist_duns_number_specificity;
    real4 hist_duns_number_switch;
    real4 hist_duns_number_maximum;
    DATASET(hist_duns_number_childrec) nulls_hist_duns_number{maxcount(100)};
    real4 hist_domestic_corp_key_specificity;
    real4 hist_domestic_corp_key_switch;
    real4 hist_domestic_corp_key_maximum;
    DATASET(hist_domestic_corp_key_childrec) nulls_hist_domestic_corp_key{maxcount(100)};
    real4 foreign_corp_key_specificity;
    real4 foreign_corp_key_switch;
    real4 foreign_corp_key_maximum;
    DATASET(foreign_corp_key_childrec) nulls_foreign_corp_key{maxcount(100)};
    real4 unk_corp_key_specificity;
    real4 unk_corp_key_switch;
    real4 unk_corp_key_maximum;
    DATASET(unk_corp_key_childrec) nulls_unk_corp_key{maxcount(100)};
    real4 ebr_file_number_specificity;
    real4 ebr_file_number_switch;
    real4 ebr_file_number_maximum;
    DATASET(ebr_file_number_childrec) nulls_ebr_file_number{maxcount(100)};
    real4 company_fein_specificity;
    real4 company_fein_switch;
    real4 company_fein_maximum;
    DATASET(company_fein_childrec) nulls_company_fein{maxcount(100)};
    real4 cnp_name_specificity;
    real4 cnp_name_switch;
    real4 cnp_name_maximum;
    DATASET(cnp_name_childrec) nulls_cnp_name{maxcount(100)};
    real4 company_name_type_derived_specificity;
    real4 company_name_type_derived_switch;
    real4 company_name_type_derived_maximum;
    DATASET(company_name_type_derived_childrec) nulls_company_name_type_derived{maxcount(100)};
    real4 cnp_number_specificity;
    real4 cnp_number_switch;
    real4 cnp_number_maximum;
    DATASET(cnp_number_childrec) nulls_cnp_number{maxcount(100)};
    real4 cnp_btype_specificity;
    real4 cnp_btype_switch;
    real4 cnp_btype_maximum;
    DATASET(cnp_btype_childrec) nulls_cnp_btype{maxcount(100)};
    real4 company_phone_specificity;
    real4 company_phone_switch;
    real4 company_phone_maximum;
    DATASET(company_phone_childrec) nulls_company_phone{maxcount(100)};
    real4 prim_name_derived_specificity;
    real4 prim_name_derived_switch;
    real4 prim_name_derived_maximum;
    DATASET(prim_name_derived_childrec) nulls_prim_name_derived{maxcount(100)};
    real4 sec_range_specificity;
    real4 sec_range_switch;
    real4 sec_range_maximum;
    DATASET(sec_range_childrec) nulls_sec_range{maxcount(100)};
    real4 v_city_name_specificity;
    real4 v_city_name_switch;
    real4 v_city_name_maximum;
    DATASET(v_city_name_childrec) nulls_v_city_name{maxcount(100)};
    real4 st_specificity;
    real4 st_switch;
    real4 st_maximum;
    DATASET(st_childrec) nulls_st{maxcount(100)};
    real4 zip_specificity;
    real4 zip_switch;
    real4 zip_maximum;
    DATASET(zip_childrec) nulls_zip{maxcount(100)};
    real4 prim_range_derived_specificity;
    real4 prim_range_derived_switch;
    real4 prim_range_derived_maximum;
    DATASET(prim_range_derived_childrec) nulls_prim_range_derived{maxcount(100)};
    real4 company_csz_specificity;
    real4 company_csz_switch;
    real4 company_csz_maximum;
    DATASET(company_csz_childrec) nulls_company_csz{maxcount(100)};
    real4 company_addr1_specificity;
    real4 company_addr1_switch;
    real4 company_addr1_maximum;
    DATASET(company_addr1_childrec) nulls_company_addr1{maxcount(100)};
    real4 company_address_specificity;
    real4 company_address_switch;
    real4 company_address_maximum;
    DATASET(company_address_childrec) nulls_company_address{maxcount(100)};
    real4 dt_first_seen_specificity;
    real4 dt_first_seen_switch;
    real4 dt_first_seen_maximum;
    DATASET(dt_first_seen_childrec) nulls_dt_first_seen{maxcount(100)};
    real4 dt_last_seen_specificity;
    real4 dt_last_seen_switch;
    real4 dt_last_seen_maximum;
    DATASET(dt_last_seen_childrec) nulls_dt_last_seen{maxcount(100)};
    real4 srcridvlid_specificity;
    real4 srcridvlid_switch;
    real4 srcridvlid_maximum;
    DATASET(srcridvlid_childrec) nulls_srcridvlid{maxcount(100)};
    real4 foreigncorpkey_specificity;
    real4 foreigncorpkey_switch;
    real4 foreigncorpkey_maximum;
    DATASET(srcridvlid_childrec) nulls_foreigncorpkey{maxcount(100)};
    real4 raaddresses_specificity;
    real4 raaddresses_switch;
    real4 raaddresses_maximum;
    DATASET(srcridvlid_childrec) nulls_raaddresses{maxcount(100)};
    real4 filterprimnames_specificity;
    real4 filterprimnames_switch;
    real4 filterprimnames_maximum;
    DATASET(srcridvlid_childrec) nulls_filterprimnames{maxcount(100)};
    real4 underlinks_specificity;
    real4 underlinks_switch;
    real4 underlinks_maximum;
    DATASET(srcridvlid_childrec) nulls_underlinks{maxcount(100)};
    real4 uber_specificity;
    real4 uber_switch;
    real4 uber_maximum;
    DATASET(uber_childrec) nulls_uber{maxcount(100)};
 END;
 
  export ms := 
  RECORD
    integer2 conf;
    unsigned6 proxid1;
    unsigned6 proxid2;
    unsigned2 rule;
    integer2 dateoverlap;
    integer2 conf_prop;
    unsigned6 rcid1;
    unsigned6 rcid2;
    integer2 attribute_conf;
    string matching_attributes;
    string cnp_name_match_info;
    string2 left_salt_partition;
    string2 right_salt_partition;
    integer2 salt_partition_score;
    string30 left_cnp_number;
    integer1 cnp_number_match_code;
    integer2 cnp_number_score;
    integer2 cnp_number_score_prop;
    boolean cnp_number_skipped;
    string30 right_cnp_number;
    string2 left_st;
    integer1 st_match_code;
    integer2 st_score;
    boolean st_skipped;
    string2 right_st;
    string10 left_prim_range_derived;
    integer1 prim_range_derived_match_code;
    integer2 prim_range_derived_score;
    integer2 prim_range_derived_score_prop;
    boolean prim_range_derived_skipped;
    string10 right_prim_range_derived;
    string9 left_hist_enterprise_number;
    integer1 hist_enterprise_number_match_code;
    integer2 hist_enterprise_number_score;
    integer2 hist_enterprise_number_score_prop;
    string9 right_hist_enterprise_number;
    string9 left_ebr_file_number;
    integer1 ebr_file_number_match_code;
    integer2 ebr_file_number_score;
    integer2 ebr_file_number_score_prop;
    string9 right_ebr_file_number;
    string9 left_active_enterprise_number;
    integer1 active_enterprise_number_match_code;
    integer2 active_enterprise_number_score;
    integer2 active_enterprise_number_score_prop;
    boolean active_enterprise_number_skipped;
    string9 right_active_enterprise_number;
    string30 left_hist_domestic_corp_key;
    integer1 hist_domestic_corp_key_match_code;
    integer2 hist_domestic_corp_key_score;
    integer2 hist_domestic_corp_key_score_prop;
    string30 right_hist_domestic_corp_key;
    string30 left_foreign_corp_key;
    integer1 foreign_corp_key_match_code;
    integer2 foreign_corp_key_score;
    integer2 foreign_corp_key_score_prop;
    string30 right_foreign_corp_key;
    string30 left_unk_corp_key;
    integer1 unk_corp_key_match_code;
    integer2 unk_corp_key_score;
    integer2 unk_corp_key_score_prop;
    string30 right_unk_corp_key;
    string30 left_active_domestic_corp_key;
    integer1 active_domestic_corp_key_match_code;
    integer2 active_domestic_corp_key_score;
    integer2 active_domestic_corp_key_score_prop;
    boolean active_domestic_corp_key_skipped;
    string30 right_active_domestic_corp_key;
    string9 left_hist_duns_number;
    integer1 hist_duns_number_match_code;
    integer2 hist_duns_number_score;
    integer2 hist_duns_number_score_prop;
    string9 right_hist_duns_number;
    string9 left_active_duns_number;
    integer1 active_duns_number_match_code;
    integer2 active_duns_number_score;
    integer2 active_duns_number_score_prop;
    string9 right_active_duns_number;
    string10 left_company_phone;
    integer1 company_phone_match_code;
    integer2 company_phone_score;
    integer2 company_phone_score_prop;
    string10 right_company_phone;
    string9 left_company_fein;
    integer1 company_fein_match_code;
    integer2 company_fein_score;
    integer2 company_fein_score_prop;
    string9 right_company_fein;
    unsigned4 left_company_addr1;
    integer1 company_addr1_match_code;
    integer2 company_addr1_score;
    integer2 company_addr1_score_prop;
    unsigned4 right_company_addr1;
    string5 left_zip;
    integer1 zip_match_code;
    integer2 zip_score;
    string5 right_zip;
    unsigned4 left_company_csz;
    integer1 company_csz_match_code;
    integer2 company_csz_score;
    boolean company_csz_skipped;
    unsigned4 right_company_csz;
    string500 left_cnp_name;
    integer1 cnp_name_match_code;
    integer2 cnp_name_score;
    boolean cnp_name_skipped;
    string500 right_cnp_name;
    string500 left_prim_name_derived;
    integer1 prim_name_derived_match_code;
    integer2 prim_name_derived_score;
    boolean prim_name_derived_skipped;
    string500 right_prim_name_derived;
    string8 left_sec_range;
    integer1 sec_range_match_code;
    integer2 sec_range_score;
    integer2 sec_range_score_prop;
    string8 right_sec_range;
    string25 left_v_city_name;
    integer1 v_city_name_match_code;
    integer2 v_city_name_score;
    string25 right_v_city_name;
    string10 left_cnp_btype;
    integer1 cnp_btype_match_code;
    integer2 cnp_btype_score;
    string10 right_cnp_btype;
    string50 left_company_name_type_derived;
    integer1 company_name_type_derived_match_code;
    integer2 company_name_type_derived_score;
    integer2 company_name_type_derived_score_prop;
    string50 right_company_name_type_derived;
    string120 left_company_name;
    string120 right_company_name;
    string50 left_company_name_type_raw;
    string50 right_company_name_type_raw;
    string1 left_cnp_hasnumber;
    string1 right_cnp_hasnumber;
    string20 left_cnp_lowv;
    string20 right_cnp_lowv;
    boolean left_cnp_translated;
    boolean right_cnp_translated;
    integer4 left_cnp_classid;
    integer4 right_cnp_classid;
    string1 left_company_foreign_domestic;
    string1 right_company_foreign_domestic;
    unsigned6 left_company_bdid;
    unsigned6 right_company_bdid;
    string28 left_prim_name;
    string28 right_prim_name;
    string10 left_prim_range;
    string10 right_prim_range;
    unsigned4 left_company_address;
    integer1 company_address_match_code;
    integer2 company_address_score;
    integer2 company_address_score_prop;
    boolean company_address_skipped;
    unsigned4 right_company_address;
    unsigned4 left_dt_first_seen;
    unsigned4 right_dt_first_seen;
    unsigned4 left_dt_last_seen;
    unsigned4 right_dt_last_seen;
    unsigned2 support_cnp_name;
   END;
  
end;