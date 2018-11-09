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
    integer2 cnp_number_weight100;
    boolean cnp_number_isnull;
    integer2 cnp_btype_weight100;
    boolean cnp_btype_isnull;
    integer2 company_phone_weight100;
    boolean company_phone_isnull;
    string prim_name_derived;
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
  
  r1 := RECORD
     string9 active_duns_number;
     unsigned8 cnt;
     unsigned4 id;
    END;

  r1___1 := RECORD
     string9 active_enterprise_number;
     unsigned8 cnt;
     unsigned4 id;
    END;

  r1___2 := RECORD
     string30 active_domestic_corp_key;
     unsigned8 cnt;
     unsigned4 id;
    END;

  r1___3 := RECORD
     string9 hist_enterprise_number;
     unsigned8 cnt;
     unsigned4 id;
    END;

  r1___4 := RECORD
     string9 hist_duns_number;
     unsigned8 cnt;
     unsigned4 id;
    END;

  r1___5 := RECORD
     string30 hist_domestic_corp_key;
     unsigned8 cnt;
     unsigned4 id;
    END;

  r1___6 := RECORD
     string30 foreign_corp_key;
     unsigned8 cnt;
     unsigned4 id;
    END;

  r1___7 := RECORD
     string30 unk_corp_key;
     unsigned8 cnt;
     unsigned4 id;
    END;

  r1___8 := RECORD
     string9 ebr_file_number;
     unsigned8 cnt;
     unsigned4 id;
    END;

  r1___9 := RECORD
     string9 company_fein;
     unsigned8 cnt;
     unsigned4 id;
    END;

  r1___10 := RECORD
     string250 cnp_name;
     unsigned8 cnt;
     unsigned4 id;
    END;

  r1___11 := RECORD
     string30 cnp_number;
     unsigned8 cnt;
     unsigned4 id;
    END;

  cnp_btype_childrec := RECORD
     string10 cnp_btype;
     unsigned8 cnt;
     unsigned4 id;
    END;

  r1___12 := RECORD
     string10 company_phone;
     unsigned8 cnt;
     unsigned4 id;
    END;

  r1___13 := RECORD
     string28 prim_name_derived;
     unsigned8 cnt;
     unsigned4 id;
    END;

  r1___14 := RECORD
     string8 sec_range;
     unsigned8 cnt;
     unsigned4 id;
    END;

  r1___15 := RECORD
     string25 v_city_name;
     unsigned8 cnt;
     unsigned4 id;
    END;

  st_childrec := RECORD
     string2 st;
     unsigned8 cnt;
     unsigned4 id;
    END;

  r1___16 := RECORD
     string5 zip;
     unsigned8 cnt;
     unsigned4 id;
    END;

  r1___17 := RECORD
     string10 prim_range_derived;
     unsigned8 cnt;
     unsigned4 id;
    END;

  r1___18 := RECORD
     unsigned4 company_csz;
     unsigned8 cnt;
     unsigned4 id;
    END;

  r1___19 := RECORD
     unsigned4 company_addr1;
     unsigned8 cnt;
     unsigned4 id;
    END;

  r1___20 := RECORD
     unsigned4 company_address;
     unsigned8 cnt;
     unsigned4 id;
    END;

  srcridvlid_childrec := RECORD
     string basis;
     unsigned8 cnt;
     unsigned4 id;
    END;

  export specs := RECORD,maxlength(32000)
    unsigned1 dummy;
    real4 active_duns_number_specificity;
    real4 active_duns_number_switch;
    real4 active_duns_number_max;
    DATASET(r1) nulls_active_duns_number{maxcount(100)};
    real4 active_enterprise_number_specificity;
    real4 active_enterprise_number_switch;
    real4 active_enterprise_number_max;
    DATASET(r1___1) nulls_active_enterprise_number{maxcount(100)};
    real4 active_domestic_corp_key_specificity;
    real4 active_domestic_corp_key_switch;
    real4 active_domestic_corp_key_max;
    DATASET(r1___2) nulls_active_domestic_corp_key{maxcount(100)};
    real4 hist_enterprise_number_specificity;
    real4 hist_enterprise_number_switch;
    real4 hist_enterprise_number_max;
    DATASET(r1___3) nulls_hist_enterprise_number{maxcount(100)};
    real4 hist_duns_number_specificity;
    real4 hist_duns_number_switch;
    real4 hist_duns_number_max;
    DATASET(r1___4) nulls_hist_duns_number{maxcount(100)};
    real4 hist_domestic_corp_key_specificity;
    real4 hist_domestic_corp_key_switch;
    real4 hist_domestic_corp_key_max;
    DATASET(r1___5) nulls_hist_domestic_corp_key{maxcount(100)};
    real4 foreign_corp_key_specificity;
    real4 foreign_corp_key_switch;
    real4 foreign_corp_key_max;
    DATASET(r1___6) nulls_foreign_corp_key{maxcount(100)};
    real4 unk_corp_key_specificity;
    real4 unk_corp_key_switch;
    real4 unk_corp_key_max;
    DATASET(r1___7) nulls_unk_corp_key{maxcount(100)};
    real4 ebr_file_number_specificity;
    real4 ebr_file_number_switch;
    real4 ebr_file_number_max;
    DATASET(r1___8) nulls_ebr_file_number{maxcount(100)};
    real4 company_fein_specificity;
    real4 company_fein_switch;
    real4 company_fein_max;
    DATASET(r1___9) nulls_company_fein{maxcount(100)};
    real4 cnp_name_specificity;
    real4 cnp_name_switch;
    real4 cnp_name_max;
    DATASET(r1___10) nulls_cnp_name{maxcount(100)};
    real4 cnp_number_specificity;
    real4 cnp_number_switch;
    real4 cnp_number_max;
    DATASET(r1___11) nulls_cnp_number{maxcount(100)};
    real4 cnp_btype_specificity;
    real4 cnp_btype_switch;
    real4 cnp_btype_max;
    DATASET(cnp_btype_childrec) nulls_cnp_btype{maxcount(100)};
    real4 company_phone_specificity;
    real4 company_phone_switch;
    real4 company_phone_max;
    DATASET(r1___12) nulls_company_phone{maxcount(100)};
    real4 prim_name_derived_specificity;
    real4 prim_name_derived_switch;
    real4 prim_name_derived_max;
    DATASET(r1___13) nulls_prim_name_derived{maxcount(100)};
    real4 sec_range_specificity;
    real4 sec_range_switch;
    real4 sec_range_max;
    DATASET(r1___14) nulls_sec_range{maxcount(100)};
    real4 v_city_name_specificity;
    real4 v_city_name_switch;
    real4 v_city_name_max;
    DATASET(r1___15) nulls_v_city_name{maxcount(100)};
    real4 st_specificity;
    real4 st_switch;
    real4 st_max;
    DATASET(st_childrec) nulls_st{maxcount(100)};
    real4 zip_specificity;
    real4 zip_switch;
    real4 zip_max;
    DATASET(r1___16) nulls_zip{maxcount(100)};
    real4 prim_range_derived_specificity;
    real4 prim_range_derived_switch;
    real4 prim_range_derived_max;
    DATASET(r1___17) nulls_prim_range_derived{maxcount(100)};
    real4 company_csz_specificity;
    real4 company_csz_switch;
    real4 company_csz_max;
    DATASET(r1___18) nulls_company_csz{maxcount(100)};
    real4 company_addr1_specificity;
    real4 company_addr1_switch;
    real4 company_addr1_max;
    DATASET(r1___19) nulls_company_addr1{maxcount(100)};
    real4 company_address_specificity;
    real4 company_address_switch;
    real4 company_address_max;
    DATASET(r1___20) nulls_company_address{maxcount(100)};
    real4 srcridvlid_specificity;
    real4 srcridvlid_switch;
    real4 srcridvlid_max;
    DATASET(srcridvlid_childrec) nulls_srcridvlid{maxcount(100)};
    real4 foreigncorpkey_specificity;
    real4 foreigncorpkey_switch;
    real4 foreigncorpkey_max;
    DATASET(srcridvlid_childrec) nulls_foreigncorpkey{maxcount(100)};
    real4 raaddresses_specificity;
    real4 raaddresses_switch;
    real4 raaddresses_max;
    DATASET(srcridvlid_childrec) nulls_raaddresses{maxcount(100)};
    real4 filterprimnames_specificity;
    real4 filterprimnames_switch;
    real4 filterprimnames_max;
    DATASET(srcridvlid_childrec) nulls_filterprimnames{maxcount(100)};
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
    string30 left_cnp_number;
    integer1 cnp_number_match_code;
    integer2 cnp_number_score;
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
    boolean prim_range_derived_skipped;
    string10 right_prim_range_derived;
    string9 left_hist_duns_number;
    integer1 hist_duns_number_match_code;
    integer2 hist_duns_number_score;
    string9 right_hist_duns_number;
    string9 left_ebr_file_number;
    integer1 ebr_file_number_match_code;
    integer2 ebr_file_number_score;
    string9 right_ebr_file_number;
    string9 left_active_duns_number;
    integer1 active_duns_number_match_code;
    integer2 active_duns_number_score;
    string9 right_active_duns_number;
    string9 left_hist_enterprise_number;
    integer1 hist_enterprise_number_match_code;
    integer2 hist_enterprise_number_score;
    string9 right_hist_enterprise_number;
    string30 left_hist_domestic_corp_key;
    integer1 hist_domestic_corp_key_match_code;
    integer2 hist_domestic_corp_key_score;
    string30 right_hist_domestic_corp_key;
    string30 left_foreign_corp_key;
    integer1 foreign_corp_key_match_code;
    integer2 foreign_corp_key_score;
    string30 right_foreign_corp_key;
    string30 left_unk_corp_key;
    integer1 unk_corp_key_match_code;
    integer2 unk_corp_key_score;
    string30 right_unk_corp_key;
    string9 left_company_fein;
    integer1 company_fein_match_code;
    integer2 company_fein_score;
    string9 right_company_fein;
    string10 left_company_phone;
    integer1 company_phone_match_code;
    integer2 company_phone_score;
    string10 right_company_phone;
    string9 left_active_enterprise_number;
    integer1 active_enterprise_number_match_code;
    integer2 active_enterprise_number_score;
    boolean active_enterprise_number_skipped;
    string9 right_active_enterprise_number;
    string30 left_active_domestic_corp_key;
    integer1 active_domestic_corp_key_match_code;
    integer2 active_domestic_corp_key_score;
    boolean active_domestic_corp_key_skipped;
    string30 right_active_domestic_corp_key;
    unsigned4 left_company_addr1;
    integer1 company_addr1_match_code;
    integer2 company_addr1_score;
    unsigned4 right_company_addr1;
    string500 left_cnp_name;
    integer1 cnp_name_match_code;
    integer2 cnp_name_score;
    boolean cnp_name_skipped;
    string500 right_cnp_name;
    string5 left_zip;
    integer1 zip_match_code;
    integer2 zip_score;
    string5 right_zip;
    unsigned4 left_company_csz;
    integer1 company_csz_match_code;
    integer2 company_csz_score;
    boolean company_csz_skipped;
    unsigned4 right_company_csz;
    string left_prim_name_derived;
    integer1 prim_name_derived_match_code;
    integer2 prim_name_derived_score;
    boolean prim_name_derived_skipped;
    string right_prim_name_derived;
    string8 left_sec_range;
    integer1 sec_range_match_code;
    integer2 sec_range_score;
    string8 right_sec_range;
    string25 left_v_city_name;
    integer1 v_city_name_match_code;
    integer2 v_city_name_score;
    string25 right_v_city_name;
    string10 left_cnp_btype;
    integer1 cnp_btype_match_code;
    integer2 cnp_btype_score;
    string10 right_cnp_btype;
    string120 left_company_name;
    string120 right_company_name;
    string50 left_company_name_type_raw;
    string50 right_company_name_type_raw;
    string50 left_company_name_type_derived;
    string50 right_company_name_type_derived;
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
    boolean company_address_skipped;
    unsigned4 right_company_address;
    unsigned4 left_dt_first_seen;
    unsigned4 right_dt_first_seen;
    unsigned4 left_dt_last_seen;
    unsigned4 right_dt_last_seen;
    unsigned2 support_cnp_name;                           
  END;
  
end;