import prte_bip;

export prte_csv_bip_bh :=
module

export rthor_data400__bip2_0__translations__date := 
record
  string50 from;
  string50 to;
  set of integer4 set_classes;
  unsigned8 __internal_fpos__;
end;

export rthor_data400__bip_v2__strnbrname :=
record
  unsigned6 cnp_nameid;
  string250 cnp_name;
  string30 cnp_number;
  string10 cnp_store_number;
  string10 cnp_btype;
  string1 cnp_component_code;
  string20 cnp_lowv;
  boolean cnp_translated;
  integer4 cnp_classid;
end;

export rthor_data400__bipv2_hrchy__key__lgid :=
record
  unsigned6 lgid;
  unsigned3 lgid_level;
  unsigned3 nodes_below;
  unsigned6 proxid;
  unsigned3 proxid_level_within_lgid;
  unsigned6 parent_proxid;
  unsigned6 sele_proxid;
  unsigned6 org_proxid;
  unsigned6 ultimate_proxid;
  boolean proxid_is_sele_level;
  string1 src;
  string3 biz_type;
  unsigned8 __internal_fpos__;
end;
 
export rthor_data400__bipv2_hrchy__key__proxid :=
record
  unsigned6 proxid;
  unsigned6 lgid;
  unsigned3 lgid_level;
  unsigned3 proxid_level_within_lgid;
  string1 src;
  string3 biz_type;
  unsigned8 __internal_fpos__; 
end;
			 
export rthor_data400__bipv2_aml__addr :=
record
  string5 zip;
  string10 prim_range;
  string28 prim_name;
  string4 addr_suffix;
  string2 predir;
  string2 postdir;
  string5 unit_desig;
  string8 sec_range;
  string25 city;
  string2 st;
  string4 zip4;
  string7 geo_blk;
  string13 geolink;
  string7 streetlink;
  string3 county;
  string4 msa;
  qstring10 geo_lat;
  qstring11 geo_long;
  unsigned4 dt_first_seen;
  unsigned4 dt_last_seen;
  boolean current;
  string6 cnp_status;
  unsigned6 powid;
  string250 cnp_name;
  string10 cnp_phone;
  string9 cnp_fein;
  string60 company_org_structure_derived;
  boolean potential_remail;
  string4 remail_reason;
  boolean potential_shelf;
  string4 shelf_reason;
  boolean potential_nis;
  string4 nis_reason;
  boolean potential_shell;
  integer4 shell_score;
  integer4 naics_risk_high;
  integer4 naics_risk_med;
  integer4 naics_risk_low;
  integer4 inc_st_tight;
  integer4 inc_st_loose;
  integer4 hifca;
  integer4 nis;
  integer4 cr_rpr;
  integer4 bank;
  integer4 llc;
  integer4 trust;
  integer4 holding_co;
  integer4 corp;
  integer4 no_fein;
  integer4 hr_sic;
  integer4 lgl_sic;
  integer4 biz_cnt_at_undel_sec;
  integer4 storage;
  integer4 priv_post;
  integer4 naics_risk_high_cnt;
  integer4 naics_risk_med_cnt;
  integer4 naics_risk_low_cnt;
  integer4 inc_st_tight_cnt;
  integer4 inc_st_loose_cnt;
  integer4 hifca_cnt;
  integer4 nis_cnt;
  integer4 cr_rpr_cnt;
  integer4 bank_cnt;
  integer4 llc_cnt;
  integer4 trust_cnt;
  integer4 holding_co_cnt;
  integer4 corp_cnt;
  integer4 no_fein_cnt;
  integer4 hr_sic_cnt;
  integer4 lgl_sic_cnt;
  integer4 biz_cnt;
  integer4 biz_use_cnt;
  integer4 vacant_cnt;
  integer4 dnd_cnt;
  integer4 rural_cnt;
  integer4 owgm_cnt;
  integer4 drop_cnt;
  integer4 deliverable_cnt;
  integer4 undel_sec_cnt;
  integer4 biz_at_undel_sec_cnt;
  integer4 storage_cnt;
  integer4 priv_post_cnt;
  string1 addr_type;
  integer4 biz_use;
  integer4 vacant;
  integer4 dnd;
  integer4 rural;
  integer4 owgm;
  integer4 drop;
  integer4 deliverable;
  integer4 undel_sec;
  boolean occupant_owned;
  string standardized_land_use_code;
  unsigned8 building_area;
  real8 id_to_sqft_ratio;
  boolean prop_sfd;
  string1 industry_group;
  string4 year_started;
  string8 date_of_incorporation;
  string2 state_of_incorporation_abbr;
  string15 annual_sales_volume;
  string1 annual_sales_code;
  string10 employees_here;
  string10 employees_total;
  string1 owns_rents;
  string1 small_business_indicator;
  string1 cottage_indicator;
  string1 foreign_owned;
  string1 public_indicator;
  string1 manufacturing_here_indicator;
  string30 parent_company_name;
  string30 ultimate_company_name;
  string1 ultimate_indicator;
  string1 active_duns_number;
  unsigned8 __internal_fpos__;
 END;

export rthor_data400__key__bipv2__business_header__linkids := 
RECORD
  unsigned6 ultid;
  unsigned6 orgid;
  unsigned6 seleid;
  unsigned6 proxid;
  unsigned6 powid;
  unsigned6 empid;
  unsigned6 dotid;
  unsigned2 ultscore;
  unsigned2 orgscore;
  unsigned2 selescore;
  unsigned2 proxscore;
  unsigned2 powscore;
  unsigned2 empscore;
  unsigned2 dotscore;
  unsigned2 ultweight;
  unsigned2 orgweight;
  unsigned2 seleweight;
  unsigned2 proxweight;
  unsigned2 powweight;
  unsigned2 empweight;
  unsigned2 dotweight;
  unsigned6 rcid;
  string2 source;
  string9 ingest_status;
  unsigned6 lgid3;
  unsigned6 vanity_owner_did;
  unsigned8 cnt_rcid_per_dotid;
  unsigned8 cnt_dot_per_proxid;
  unsigned8 cnt_prox_per_lgid3;
  unsigned8 cnt_prox_per_powid;
  unsigned8 cnt_dot_per_empid;
  boolean has_lgid;
  boolean is_sele_level;
  boolean is_org_level;
  boolean is_ult_level;
  unsigned6 parent_proxid;
  unsigned6 sele_proxid;
  unsigned6 org_proxid;
  unsigned6 ultimate_proxid;
  unsigned2 levels_from_top;
  unsigned3 nodes_below;
  unsigned3 nodes_total;
  string1 sele_gold;
  string1 ult_seg;
  string1 org_seg;
  string1 sele_seg;
  string1 prox_seg;
  string1 pow_seg;
  string1 ult_prob;
  string1 org_prob;
  string1 sele_prob;
  string1 prox_prob;
  string1 pow_prob;
  string1 iscontact;
  string5 title;
  string20 fname;
  string20 mname;
  string20 lname;
  string5 name_suffix;
  string3 name_score;
  string1 iscorp;
  string120 company_name;
  string50 company_name_type_raw;
  string50 company_name_type_derived;
  string1 cnp_hasnumber;
  string250 cnp_name;
  string30 cnp_number;
  string10 cnp_store_number;
  string10 cnp_btype;
  string1 cnp_component_code;
  string20 cnp_lowv;
  boolean cnp_translated;
  integer4 cnp_classid;
  unsigned8 company_rawaid;
  unsigned8 company_aceaid;
  string10 prim_range;
  string10 prim_range_derived;
  string2 predir;
  string28 prim_name;
  string28 prim_name_derived;
  string4 addr_suffix;
  string2 postdir;
  string10 unit_desig;
  string8 sec_range;
  string25 p_city_name;
  string25 v_city_name;
  string2 st;
  string5 zip;
  string4 zip4;
  string4 cart;
  string1 cr_sort_sz;
  string4 lot;
  string1 lot_order;
  string2 dbpc;
  string1 chk_digit;
  string2 rec_type;
  string2 fips_state;
  string3 fips_county;
  string10 geo_lat;
  string11 geo_long;
  string4 msa;
  string7 geo_blk;
  string1 geo_match;
  string4 err_stat;
  string250 corp_legal_name;
  string250 dba_name;
  string9 active_duns_number;
  string9 hist_duns_number;
  string9 deleted_key;
  string9 deleted_fein;
  string9 active_enterprise_number;
  string9 hist_enterprise_number;
  string9 ebr_file_number;
  string30 active_domestic_corp_key;
  string30 hist_domestic_corp_key;
  string30 foreign_corp_key;
  string30 unk_corp_key;
  unsigned4 dt_first_seen;
  unsigned4 dt_last_seen;
  unsigned4 dt_vendor_first_reported;
  unsigned4 dt_vendor_last_reported;
  unsigned6 company_bdid;
  string50 company_address_type_raw;
  string9 company_fein;
  string1 best_fein_indicator;
  string10 company_phone;
  string1 phone_type;
  string60 company_org_structure_raw;
  unsigned4 company_incorporation_date;
  string8 company_sic_code1;
  string8 company_sic_code2;
  string8 company_sic_code3;
  string8 company_sic_code4;
  string8 company_sic_code5;
  string6 company_naics_code1;
  string6 company_naics_code2;
  string6 company_naics_code3;
  string6 company_naics_code4;
  string6 company_naics_code5;
  string6 company_ticker;
  string6 company_ticker_exchange;
  string1 company_foreign_domestic;
  string80 company_url;
  string2 company_inc_state;
  string32 company_charter_number;
  unsigned4 company_filing_date;
  unsigned4 company_status_date;
  unsigned4 company_foreign_date;
  unsigned4 event_filing_date;
  string50 company_name_status_raw;
  string50 company_status_raw;
  unsigned4 dt_first_seen_company_name;
  unsigned4 dt_last_seen_company_name;
  unsigned4 dt_first_seen_company_address;
  unsigned4 dt_last_seen_company_address;
  string34 vl_id;
  boolean current;
  unsigned8 source_record_id;
  unsigned2 phone_score;
  string9 duns_number;
  string100 source_docid;
  unsigned4 dt_first_seen_contact;
  unsigned4 dt_last_seen_contact;
  unsigned6 contact_did;
  string50 contact_type_raw;
  string50 contact_job_title_raw;
  string9 contact_ssn;
  unsigned4 contact_dob;
  string30 contact_status_raw;
  string60 contact_email;
  string30 contact_email_username;
  string30 contact_email_domain;
  string10 contact_phone;
  string1 from_hdr;
  string35 company_department;
  string50 company_address_type_derived;
  string60 company_org_structure_derived;
  string50 company_name_status_derived;
  string50 company_status_derived;
  string1 proxid_status_private;
  string1 powid_status_private;
  string1 seleid_status_private;
  string1 orgid_status_private;
  string1 ultid_status_private;
  string1 proxid_status_public;
  string1 powid_status_public;
  string1 seleid_status_public;
  string1 orgid_status_public;
  string1 ultid_status_public;
  string50 contact_type_derived;
  string50 contact_job_title_derived;
  string30 contact_status_derived;
  string1 address_type_derived;
  boolean is_vanity_name_derived;
  integer1 fp;
 END;
 
export rthor_data400__key__bipv2__business_header__status := 
record
  unsigned6 ultid;
  unsigned6 orgid;
  unsigned6 seleid;
  unsigned6 proxid;
  string2 source;
  string50 company_status_derived;
  unsigned4 dt_first_seen;
  unsigned4 dt_last_seen;
  unsigned4 dt_vendor_first_reported;
  unsigned4 dt_vendor_last_reported;
end;

export rthor_data400__key__bipv2__industry_linkids := 
record
  unsigned6 ultid;
  unsigned6 orgid;
  unsigned6 seleid;
  unsigned6 proxid;
  unsigned6 powid;
  unsigned6 empid;
  unsigned6 dotid;
  unsigned2 ultscore;
  unsigned2 orgscore;
  unsigned2 selescore;
  unsigned2 proxscore;
  unsigned2 powscore;
  unsigned2 empscore;
  unsigned2 dotscore;
  unsigned2 ultweight;
  unsigned2 orgweight;
  unsigned2 seleweight;
  unsigned2 proxweight;
  unsigned2 powweight;
  unsigned2 empweight;
  unsigned2 dotweight;
  unsigned6 bdid;
  unsigned1 bdid_score;
  string2 source;
  string50 source_docid;
  unsigned8 source_rec_id;
  string4 siccode;
  string6 naics;
  string350 industry_description;
  string1502 business_description;
  unsigned4 dt_first_seen;
  unsigned4 dt_last_seen;
  unsigned4 dt_vendor_first_reported;
  unsigned4 dt_vendor_last_reported;
  string1 record_type;
  unsigned4 record_date;
  integer1 fp;
end;

export rthor_data400__key__bipv2__license_linkids := 
record
  unsigned6 ultid;
  unsigned6 orgid;
  unsigned6 seleid;
  unsigned6 proxid;
  unsigned6 powid;
  unsigned6 empid;
  unsigned6 dotid;
  unsigned2 ultscore;
  unsigned2 orgscore;
  unsigned2 selescore;
  unsigned2 proxscore;
  unsigned2 powscore;
  unsigned2 empscore;
  unsigned2 dotscore;
  unsigned2 ultweight;
  unsigned2 orgweight;
  unsigned2 seleweight;
  unsigned2 proxweight;
  unsigned2 powweight;
  unsigned2 empweight;
  unsigned2 dotweight;
  unsigned6 bdid;
  unsigned1 bdid_score;
  string2 source;
  string50 source_docid;
  unsigned8 source_rec_id;
  string2 license_state;
  string160 license_board;
  string25 license_number;
  string100 license_type;
  string8 issue_date;
  string8 expiration_date;
  unsigned4 dt_first_seen;
  unsigned4 dt_last_seen;
  unsigned4 dt_vendor_first_reported;
  unsigned4 dt_vendor_last_reported;
  string1 record_type;
  unsigned4 record_date;
  integer1 fp;
end;

export rthor_data400__key__bipv2__zipcityst := 
record
  string28 city;
  string2 state;
  string5 zip5;
  string1 zipclass;
  string25 county;
  string28 prefctystname;
  unsigned8 __internal_fpos__;
end;

source := RECORD
    string2 source;
    unsigned8 source_record_id;
    string34 vl_id;
   END;

company_name_case_layout := RECORD
   string120 company_name;
   unsigned2 company_name_data_permits;
   unsigned1 company_name_method;
   unsigned4 dt_first_seen;
   unsigned4 dt_last_seen;
   DATASET(source) sources;
  END;

company_address_case_layout := RECORD
   string10 company_prim_range;
   string2 company_predir;
   string28 company_prim_name;
   string4 company_addr_suffix;
   string2 company_postdir;
   string10 company_unit_desig;
   string8 company_sec_range;
   string25 company_p_city_name;
   string25 address_v_city_name;
   string2 company_st;
   string5 company_zip5;
   string4 company_zip4;
   string18 county_name;
   unsigned2 company_address_data_permits;
   unsigned1 company_address_method;
  END;

company_phone_case_layout := RECORD
   string10 company_phone;
   unsigned2 company_phone_data_permits;
   unsigned1 company_phone_method;
  END;

company_fein_case_layout := RECORD
   string9 company_fein;
   unsigned2 company_fein_data_permits;
   unsigned1 company_fein_method;
   DATASET(source) sources;
  END;

company_url_case_layout := RECORD
   string80 company_url;
   unsigned2 company_url_data_permits;
   unsigned1 company_url_method;
  END;

company_incorporation_date_layout := RECORD
   unsigned4 company_incorporation_date;
   unsigned2 company_incorporation_date_permits;
   unsigned1 company_incorporation_date_method;
   DATASET(source) sources;
  END;

duns_number_case_layout := RECORD
   string9 duns_number;
   unsigned2 duns_number_data_permits;
   unsigned1 duns_number_method;
  END;

company_sic_code1_case_layout := RECORD
   string8 company_sic_code1;
   unsigned2 company_sic_code1_data_permits;
   unsigned1 company_sic_code1_method;
  END;

company_naics_code1_case_layout := RECORD
   string6 company_naics_code1;
   unsigned2 company_naics_code1_data_permits;
   unsigned1 company_naics_code1_method;
  END;

export rthor_data400__key__bipv2_best__linkids:= 
RECORD
  unsigned6 ultid;
  unsigned6 orgid;
  unsigned6 seleid;
  unsigned6 proxid;
  unsigned6 powid;
  unsigned6 empid;
  unsigned6 dotid;
  unsigned2 ultscore;
  unsigned2 orgscore;
  unsigned2 selescore;
  unsigned2 proxscore;
  unsigned2 powscore;
  unsigned2 empscore;
  unsigned2 dotscore;
  unsigned2 ultweight;
  unsigned2 orgweight;
  unsigned2 seleweight;
  unsigned2 proxweight;
  unsigned2 powweight;
  unsigned2 empweight;
  unsigned2 dotweight;
  boolean isactive;
  boolean isdefunct;
  unsigned6 company_bdid;
  DATASET(company_name_case_layout) company_name;
  DATASET(company_address_case_layout) company_address;
  DATASET(company_phone_case_layout) company_phone;
  DATASET(company_fein_case_layout) company_fein;
  DATASET(company_url_case_layout) company_url;
  DATASET(company_incorporation_date_layout) company_incorporation_date;
  DATASET(duns_number_case_layout) duns_number;
  DATASET(company_sic_code1_case_layout) sic_code;
  DATASET(company_naics_code1_case_layout) naics_code;
  integer1 fp;
 END;

export rthor_data400__key__bipv2_biz__preferred := 
record
  string160 cname;
  string clean_name;
  string preferred_name;
  unsigned8 __internal_fpos__;
end;

export rthor_data400__key__bipv2_lgid3__match_candidates_debug := 
RECORD
  unsigned6 lgid3;
  unsigned6 rcid;
  string34 sbfe_id;
  string10 nodes_below_st;
  string20 lgid3ifhrchy;
  unsigned6 originalseleid;
  unsigned6 originalorgid;
  string30 cnp_number;
  string9 active_duns_number;
  string9 duns_number;
  unsigned4 duns_number_concept;
  string9 company_fein;
  string2 company_inc_state;
  string32 company_charter_number;
  string10 cnp_btype;
  string50 company_name_type_derived;
  string9 hist_duns_number;
  string30 active_domestic_corp_key;
  string30 hist_domestic_corp_key;
  string30 foreign_corp_key;
  string30 unk_corp_key;
  string250 cnp_name;
  string1 cnp_hasnumber;
  string20 cnp_lowv;
  boolean cnp_translated;
  integer4 cnp_classid;
  string10 prim_range;
  string28 prim_name;
  string8 sec_range;
  string25 v_city_name;
  string2 st;
  string5 zip;
  boolean has_lgid;
  boolean is_sele_level;
  boolean is_org_level;
  boolean is_ult_level;
  unsigned6 parent_proxid;
  unsigned6 sele_proxid;
  unsigned6 org_proxid;
  unsigned6 ultimate_proxid;
  unsigned2 levels_from_top;
  unsigned3 nodes_total;
  unsigned4 dt_first_seen;
  unsigned4 dt_last_seen;
  string2 salt_partition;
  unsigned6 ultid;
  unsigned6 orgid;
  unsigned6 seleid;
  unsigned1 lgid3ifhrchy_prop;
  unsigned1 company_name_prop;
  unsigned1 cnp_number_prop;
  unsigned1 active_duns_number_prop;
  unsigned1 duns_number_prop;
  unsigned1 duns_number_concept_prop;
  unsigned1 company_inc_state_prop;
  unsigned1 company_charter_number_prop;
  integer2 sbfe_id_weight100;
  boolean sbfe_id_isnull;
  integer2 lgid3ifhrchy_weight100;
  boolean lgid3ifhrchy_isnull;
  string500 company_name;
  integer2 company_name_weight100;
  boolean company_name_isnull;
  integer2 cnp_number_weight100;
  boolean cnp_number_isnull;
  integer2 active_duns_number_weight100;
  boolean active_duns_number_isnull;
  integer2 duns_number_weight100;
  boolean duns_number_isnull;
  integer2 duns_number_concept_weight100;
  boolean duns_number_concept_isnull;
  integer2 company_fein_weight100;
  boolean company_fein_isnull;
  integer2 company_inc_state_weight100;
  boolean company_inc_state_isnull;
  integer2 company_charter_number_weight100;
  boolean company_charter_number_isnull;
  integer2 cnp_btype_weight100;
  boolean cnp_btype_isnull;
  unsigned8 __internal_fpos__;
 END;

export bipv2_lgid3_specificities_debug := module

r1 := RECORD
   string34 sbfe_id;
   unsigned8 cnt;
   unsigned4 id;
  END;

r1___1 := RECORD
   string20 lgid3ifhrchy;
   unsigned8 cnt;
   unsigned4 id;
  END;

r1___2 := RECORD
   string120 company_name;
   unsigned8 cnt;
   unsigned4 id;
  END;

r1___3 := RECORD
   string30 cnp_number;
   unsigned8 cnt;
   unsigned4 id;
  END;

r1___4 := RECORD
   string9 active_duns_number;
   unsigned8 cnt;
   unsigned4 id;
  END;

r1___5 := RECORD
   string9 duns_number;
   unsigned8 cnt;
   unsigned4 id;
  END;

r1___6 := RECORD
   unsigned4 duns_number_concept;
   unsigned8 cnt;
   unsigned4 id;
  END;

r1___7 := RECORD
   string9 company_fein;
   unsigned8 cnt;
   unsigned4 id;
  END;

company_inc_state_childrec := RECORD
   string2 company_inc_state;
   unsigned8 cnt;
   unsigned4 id;
  END;

r1___8 := RECORD
   string32 company_charter_number;
   unsigned8 cnt;
   unsigned4 id;
  END;

cnp_btype_childrec := RECORD
   string10 cnp_btype;
   unsigned8 cnt;
   unsigned4 id;
  END;

	export rthor_data400__key__bipv2_lgid3__specificities_debug := 
	RECORD,maxlength(32000)
  integer8 _unnamed_1;
  unsigned1 dummy;
  real4 sbfe_id_specificity;
  real4 sbfe_id_switch;
  real4 sbfe_id_max;
  DATASET(r1) nulls_sbfe_id{maxcount(100)};
  real4 lgid3ifhrchy_specificity;
  real4 lgid3ifhrchy_switch;
  real4 lgid3ifhrchy_max;
  DATASET(r1___1) nulls_lgid3ifhrchy{maxcount(100)};
  real4 company_name_specificity;
  real4 company_name_switch;
  real4 company_name_max;
  DATASET(r1___2) nulls_company_name{maxcount(100)};
  real4 cnp_number_specificity;
  real4 cnp_number_switch;
  real4 cnp_number_max;
  DATASET(r1___3) nulls_cnp_number{maxcount(100)};
  real4 active_duns_number_specificity;
  real4 active_duns_number_switch;
  real4 active_duns_number_max;
  DATASET(r1___4) nulls_active_duns_number{maxcount(100)};
  real4 duns_number_specificity;
  real4 duns_number_switch;
  real4 duns_number_max;
  DATASET(r1___5) nulls_duns_number{maxcount(100)};
  real4 duns_number_concept_specificity;
  real4 duns_number_concept_switch;
  real4 duns_number_concept_max;
  DATASET(r1___6) nulls_duns_number_concept{maxcount(100)};
  real4 company_fein_specificity;
  real4 company_fein_switch;
  real4 company_fein_max;
  DATASET(r1___7) nulls_company_fein{maxcount(100)};
  real4 company_inc_state_specificity;
  real4 company_inc_state_switch;
  real4 company_inc_state_max;
  DATASET(company_inc_state_childrec) nulls_company_inc_state{maxcount(100)};
  real4 company_charter_number_specificity;
  real4 company_charter_number_switch;
  real4 company_charter_number_max;
  DATASET(r1___8) nulls_company_charter_number{maxcount(100)};
  real4 cnp_btype_specificity;
  real4 cnp_btype_switch;
  real4 cnp_btype_max;
  DATASET(cnp_btype_childrec) nulls_cnp_btype{maxcount(100)};
  unsigned8 __internal_fpos__;
 END;
end;

export rthor_data400__key__bipv2_seleid_relative__seleid__rel__assoc := 
RECORD
  unsigned6 seleid1;
  unsigned6 seleid2;
  integer2 duns_number_score;
  integer2 duns_number_cnt;
  integer2 enterprise_number_score;
  integer2 enterprise_number_cnt;
  integer2 source_score;
  integer2 source_cnt;
  integer2 contact_score;
  integer2 contact_cnt;
  integer2 address_score;
  integer2 address_cnt;
  integer2 namest_score;
  integer2 namest_cnt;
  integer2 charter_score;
  integer2 charter_cnt;
  integer2 fein_score;
  integer2 fein_cnt;
  integer2 mname_score;
  integer2 contact_ssn_score;
  integer2 contact_phone_score;
  integer2 contact_email_username_score;
  unsigned4 dt_first_seen_track;
  unsigned4 dt_last_seen_track;
  unsigned4 dt_first_seen_contact_track;
  unsigned4 dt_last_seen_contact_track;
  unsigned2 total_cnt;
  integer2 total_score;
 END;


export rthor_data400__key__bizlinkfull__proxid__meow := 
RECORD
  unsigned6 ultid;
  unsigned6 orgid;
  unsigned6 seleid;
  unsigned6 proxid;
  unsigned6 powid;
  unsigned6 empid;
  unsigned6 dotid;
  unsigned6 parent_proxid;
  unsigned6 sele_proxid;
  unsigned6 org_proxid;
  unsigned6 ultimate_proxid;
  boolean has_lgid;
  string120 company_name;
  string5 title;
  string20 fname;
  string20 mname;
  string20 lname;
  string5 name_suffix;
  string1 iscontact;
  string9 contact_ssn;
  string60 contact_email;
  string10 prim_range;
  string2 predir;
  string28 prim_name;
  string4 addr_suffix;
  string2 postdir;
  string10 unit_desig;
  string8 sec_range;
  string25 p_city_name;
  string25 v_city_name;
  string2 st;
  string5 zip;
  string4 zip4;
  string3 fips_county;
  string2 source;
  unsigned4 dt_first_seen;
  unsigned4 dt_last_seen;
  unsigned4 dt_vendor_last_reported;
  unsigned6 company_bdid;
  string9 company_fein;
  string9 active_duns_number;
  string10 company_phone;
  string1 phone_type;
  string80 company_url;
  string8 company_sic_code1;
  string50 company_status_derived;
  string34 vl_id;
  unsigned8 source_record_id;
  string100 source_docid;
  unsigned6 contact_did;
  string30 contact_email_domain;
  string50 contact_job_title_derived;
  unsigned6 rcid;
  string1 address_type_derived;
  string4 err_stat;
  boolean is_sele_level;
  boolean is_org_level;
  boolean is_ult_level;
  string250 cnp_name;
  string30 cnp_number;
  string10 cnp_store_number;
  string10 cnp_btype;
  string1 cnp_component_code;
  string20 cnp_lowv;
  boolean cnp_translated;
  integer4 cnp_classid;
  string5 company_name_prefix;
  string25 city;
  string25 city_clean;
  string3 company_phone_3;
  string3 company_phone_3_ex;
  string7 company_phone_7;
  string20 fname_preferred;
  string1 sele_flag;
  string1 org_flag;
  string1 ult_flag;
  unsigned1 fallback_value;
 END;

export rthor_data400__key__bizlinkfull__proxid__refs := 
record
  unsigned4 word_id;
  unsigned2 field;
  unsigned6 uid;
  unsigned8 __internal_fpos__;
end;

export rthor_data400__key__bizlinkfull__proxid__refs__l_address1 := 
RECORD
  string28 prim_name;
  string25 city;
  string2 st;
  unsigned1 fallback_value;
  unsigned6 ultid;
  unsigned6 orgid;
  unsigned6 seleid;
  unsigned6 proxid;
  string10 prim_range;
  string240 cnp_name;
  string5 zip;
  string8 company_sic_code1;
  string30 cnp_number;
  string10 cnp_btype;
  string20 cnp_lowv;
  string8 sec_range;
  unsigned6 parent_proxid;
  unsigned6 sele_proxid;
  unsigned6 org_proxid;
  unsigned6 ultimate_proxid;
  string1 sele_flag;
  string1 org_flag;
  string1 ult_flag;
  unsigned6 powid;
  integer2 prim_name_weight100;
  unsigned2 prim_name_e1_weight100;
  integer2 city_weight100;
  integer2 city_p_weight100;
  integer2 city_e2_weight100;
  integer2 city_e2p_weight100;
  integer2 st_weight100;
  integer2 prim_range_weight100;
  unsigned2 prim_range_e1_weight100;
  integer2 cnp_name_weight100;
  integer2 cnp_name_initial_char_weight100;
  integer2 zip_weight100;
  integer2 company_sic_code1_weight100;
  integer2 cnp_number_weight100;
  integer2 cnp_btype_weight100;
  integer2 cnp_lowv_weight100;
  integer2 sec_range_weight100;
  unsigned2 sec_range_e1_weight100;
  integer2 parent_proxid_weight100;
  integer2 sele_proxid_weight100;
  integer2 org_proxid_weight100;
  integer2 ultimate_proxid_weight100;
  integer2 sele_flag_weight100;
  integer2 org_flag_weight100;
  integer2 ult_flag_weight100;
 END;

export rthor_data400__key__bizlinkfull__proxid__refs__l_address2 := 
RECORD
  string28 prim_name;
  string5 zip;
  string2 st;
  unsigned1 fallback_value;
  unsigned6 ultid;
  unsigned6 orgid;
  unsigned6 seleid;
  unsigned6 proxid;
  string10 prim_range;
  string240 cnp_name;
  string25 city;
  string8 company_sic_code1;
  string30 cnp_number;
  string10 cnp_btype;
  string20 cnp_lowv;
  string8 sec_range;
  unsigned6 parent_proxid;
  unsigned6 sele_proxid;
  unsigned6 org_proxid;
  unsigned6 ultimate_proxid;
  string1 sele_flag;
  string1 org_flag;
  string1 ult_flag;
  unsigned6 powid;
  integer2 prim_name_weight100;
  unsigned2 prim_name_e1_weight100;
  integer2 zip_weight100;
  integer2 prim_range_weight100;
  unsigned2 prim_range_e1_weight100;
  integer2 cnp_name_weight100;
  integer2 cnp_name_initial_char_weight100;
  integer2 st_weight100;
  integer2 city_weight100;
  integer2 city_p_weight100;
  integer2 city_e2_weight100;
  integer2 city_e2p_weight100;
  integer2 company_sic_code1_weight100;
  integer2 cnp_number_weight100;
  integer2 cnp_btype_weight100;
  integer2 cnp_lowv_weight100;
  integer2 sec_range_weight100;
  unsigned2 sec_range_e1_weight100;
  integer2 parent_proxid_weight100;
  integer2 sele_proxid_weight100;
  integer2 org_proxid_weight100;
  integer2 ultimate_proxid_weight100;
  integer2 sele_flag_weight100;
  integer2 org_flag_weight100;
  integer2 ult_flag_weight100;
 END;

export rthor_data400__key__bizlinkfull__proxid__refs__l_address3 := 
RECORD
  string28 prim_name;
  string10 prim_range;
  string5 zip;
  string2 st;
  unsigned1 fallback_value;
  unsigned6 ultid;
  unsigned6 orgid;
  unsigned6 seleid;
  unsigned6 proxid;
  string240 cnp_name;
  string25 city;
  string8 company_sic_code1;
  string30 cnp_number;
  string10 cnp_btype;
  string20 cnp_lowv;
  string8 sec_range;
  unsigned6 parent_proxid;
  unsigned6 sele_proxid;
  unsigned6 org_proxid;
  unsigned6 ultimate_proxid;
  string1 sele_flag;
  string1 org_flag;
  string1 ult_flag;
  unsigned6 powid;
  integer2 prim_name_weight100;
  unsigned2 prim_name_e1_weight100;
  integer2 prim_range_weight100;
  unsigned2 prim_range_e1_weight100;
  integer2 zip_weight100;
  integer2 cnp_name_weight100;
  integer2 cnp_name_initial_char_weight100;
  integer2 st_weight100;
  integer2 city_weight100;
  integer2 city_p_weight100;
  integer2 city_e2_weight100;
  integer2 city_e2p_weight100;
  integer2 company_sic_code1_weight100;
  integer2 cnp_number_weight100;
  integer2 cnp_btype_weight100;
  integer2 cnp_lowv_weight100;
  integer2 sec_range_weight100;
  unsigned2 sec_range_e1_weight100;
  integer2 parent_proxid_weight100;
  integer2 sele_proxid_weight100;
  integer2 org_proxid_weight100;
  integer2 ultimate_proxid_weight100;
  integer2 sele_flag_weight100;
  integer2 org_flag_weight100;
  integer2 ult_flag_weight100;
 END;

export rthor_data400__key__bizlinkfull__proxid__refs__l_cnpname := 
RECORD
  unsigned4 gss_hash;
  unsigned1 fallback_value;
  unsigned6 ultid;
  unsigned6 orgid;
  unsigned6 seleid;
  unsigned6 proxid;
  string28 prim_name;
  string2 st;
  string25 city;
  string8 company_sic_code1;
  string30 cnp_number;
  string10 cnp_btype;
  string20 cnp_lowv;
  string10 prim_range;
  string8 sec_range;
  unsigned6 parent_proxid;
  unsigned6 sele_proxid;
  unsigned6 org_proxid;
  unsigned6 ultimate_proxid;
  string1 sele_flag;
  string1 org_flag;
  string1 ult_flag;
  string5 zip;
  unsigned6 powid;
  unsigned2 gss_word_weight;
  string240 cnp_name;
  unsigned8 gss_bloom;
  integer2 prim_name_weight100;
  unsigned2 prim_name_e1_weight100;
  integer2 st_weight100;
  integer2 city_weight100;
  integer2 city_p_weight100;
  integer2 city_e2_weight100;
  integer2 city_e2p_weight100;
  integer2 company_sic_code1_weight100;
  integer2 cnp_number_weight100;
  integer2 cnp_btype_weight100;
  integer2 cnp_lowv_weight100;
  integer2 prim_range_weight100;
  unsigned2 prim_range_e1_weight100;
  integer2 sec_range_weight100;
  unsigned2 sec_range_e1_weight100;
  integer2 parent_proxid_weight100;
  integer2 sele_proxid_weight100;
  integer2 org_proxid_weight100;
  integer2 ultimate_proxid_weight100;
  integer2 sele_flag_weight100;
  integer2 org_flag_weight100;
  integer2 ult_flag_weight100;
  integer2 zip_weight100;
 END;

export rthor_data400__key__bizlinkfull__proxid__refs__l_cnpname_fuzzy := 
RECORD
  string5 company_name_prefix;
  string5 zip;
  string2 st;
  unsigned1 fallback_value;
  unsigned6 ultid;
  unsigned6 orgid;
  unsigned6 seleid;
  unsigned6 proxid;
  string240 cnp_name;
  string25 city;
  string8 company_sic_code1;
  string30 cnp_number;
  string10 cnp_btype;
  string20 cnp_lowv;
  string10 prim_range;
  string8 sec_range;
  unsigned6 parent_proxid;
  unsigned6 sele_proxid;
  unsigned6 org_proxid;
  unsigned6 ultimate_proxid;
  string1 sele_flag;
  string1 org_flag;
  string1 ult_flag;
  unsigned6 powid;
  integer2 company_name_prefix_weight100;
  integer2 cnp_name_weight100;
  integer2 cnp_name_initial_char_weight100;
  integer2 zip_weight100;
  integer2 city_weight100;
  integer2 city_p_weight100;
  integer2 city_e2_weight100;
  integer2 city_e2p_weight100;
  integer2 st_weight100;
  integer2 company_sic_code1_weight100;
  integer2 cnp_number_weight100;
  integer2 cnp_btype_weight100;
  integer2 cnp_lowv_weight100;
  integer2 prim_range_weight100;
  unsigned2 prim_range_e1_weight100;
  integer2 sec_range_weight100;
  unsigned2 sec_range_e1_weight100;
  integer2 parent_proxid_weight100;
  integer2 sele_proxid_weight100;
  integer2 org_proxid_weight100;
  integer2 ultimate_proxid_weight100;
  integer2 sele_flag_weight100;
  integer2 org_flag_weight100;
  integer2 ult_flag_weight100;
 END;

export rthor_data400__key__bizlinkfull__proxid__refs__l_cnpname_st := 
RECORD
  unsigned4 gss_hash;
  string2 st;
  unsigned1 fallback_value;
  unsigned6 ultid;
  unsigned6 orgid;
  unsigned6 seleid;
  unsigned6 proxid;
  string28 prim_name;
  string5 zip;
  string25 city;
  string8 company_sic_code1;
  string30 cnp_number;
  string10 cnp_btype;
  string20 cnp_lowv;
  string10 prim_range;
  string8 sec_range;
  unsigned6 parent_proxid;
  unsigned6 sele_proxid;
  unsigned6 org_proxid;
  unsigned6 ultimate_proxid;
  string1 sele_flag;
  string1 org_flag;
  string1 ult_flag;
  unsigned6 powid;
  unsigned2 gss_word_weight;
  string240 cnp_name;
  unsigned8 gss_bloom;
  integer2 st_weight100;
  integer2 prim_name_weight100;
  unsigned2 prim_name_e1_weight100;
  integer2 zip_weight100;
  integer2 city_weight100;
  integer2 city_p_weight100;
  integer2 city_e2_weight100;
  integer2 city_e2p_weight100;
  integer2 company_sic_code1_weight100;
  integer2 cnp_number_weight100;
  integer2 cnp_btype_weight100;
  integer2 cnp_lowv_weight100;
  integer2 prim_range_weight100;
  unsigned2 prim_range_e1_weight100;
  integer2 sec_range_weight100;
  unsigned2 sec_range_e1_weight100;
  integer2 parent_proxid_weight100;
  integer2 sele_proxid_weight100;
  integer2 org_proxid_weight100;
  integer2 ultimate_proxid_weight100;
  integer2 sele_flag_weight100;
  integer2 org_flag_weight100;
  integer2 ult_flag_weight100;
 END;

export rthor_data400__key__bizlinkfull__proxid__refs__l_cnpname_zip := 
RECORD
  unsigned4 gss_hash;
  string5 zip;
  unsigned1 fallback_value;
  unsigned6 ultid;
  unsigned6 orgid;
  unsigned6 seleid;
  unsigned6 proxid;
  string28 prim_name;
  string2 st;
  string25 city;
  string8 company_sic_code1;
  string30 cnp_number;
  string10 cnp_btype;
  string20 cnp_lowv;
  string10 prim_range;
  string8 sec_range;
  unsigned6 parent_proxid;
  unsigned6 sele_proxid;
  unsigned6 org_proxid;
  unsigned6 ultimate_proxid;
  string1 sele_flag;
  string1 org_flag;
  string1 ult_flag;
  unsigned6 powid;
  unsigned2 gss_word_weight;
  string240 cnp_name;
  unsigned8 gss_bloom;
  integer2 zip_weight100;
  integer2 prim_name_weight100;
  unsigned2 prim_name_e1_weight100;
  integer2 st_weight100;
  integer2 city_weight100;
  integer2 city_p_weight100;
  integer2 city_e2_weight100;
  integer2 city_e2p_weight100;
  integer2 company_sic_code1_weight100;
  integer2 cnp_number_weight100;
  integer2 cnp_btype_weight100;
  integer2 cnp_lowv_weight100;
  integer2 prim_range_weight100;
  unsigned2 prim_range_e1_weight100;
  integer2 sec_range_weight100;
  unsigned2 sec_range_e1_weight100;
  integer2 parent_proxid_weight100;
  integer2 sele_proxid_weight100;
  integer2 org_proxid_weight100;
  integer2 ultimate_proxid_weight100;
  integer2 sele_flag_weight100;
  integer2 org_flag_weight100;
  integer2 ult_flag_weight100;
 END;

export rthor_data400__key__bizlinkfull__proxid__refs__l_contact := 
RECORD
  string20 fname_preferred;
  string20 lname;
  string5 zip;
  string2 st;
  unsigned1 fallback_value;
  unsigned6 ultid;
  unsigned6 orgid;
  unsigned6 seleid;
  unsigned6 proxid;
  string20 mname;
  string240 cnp_name;
  string20 fname;
  string8 company_sic_code1;
  string30 cnp_number;
  string10 cnp_btype;
  string20 cnp_lowv;
  string28 prim_name;
  string25 city;
  string10 prim_range;
  string8 sec_range;
  unsigned6 parent_proxid;
  unsigned6 sele_proxid;
  unsigned6 org_proxid;
  unsigned6 ultimate_proxid;
  string1 sele_flag;
  string1 org_flag;
  string1 ult_flag;
  unsigned6 powid;
  integer2 fname_preferred_weight100;
  integer2 lname_weight100;
  integer2 lname_initial_char_weight100;
  unsigned2 lname_e2_weight100;
  integer2 mname_weight100;
  integer2 mname_initial_char_weight100;
  unsigned2 mname_e2_weight100;
  integer2 cnp_name_weight100;
  integer2 cnp_name_initial_char_weight100;
  integer2 zip_weight100;
  integer2 st_weight100;
  integer2 fname_weight100;
  integer2 fname_initial_char_weight100;
  unsigned2 fname_e1_weight100;
  integer2 company_sic_code1_weight100;
  integer2 cnp_number_weight100;
  integer2 cnp_btype_weight100;
  integer2 cnp_lowv_weight100;
  integer2 prim_name_weight100;
  unsigned2 prim_name_e1_weight100;
  integer2 city_weight100;
  integer2 city_p_weight100;
  integer2 city_e2_weight100;
  integer2 city_e2p_weight100;
  integer2 prim_range_weight100;
  unsigned2 prim_range_e1_weight100;
  integer2 sec_range_weight100;
  unsigned2 sec_range_e1_weight100;
  integer2 parent_proxid_weight100;
  integer2 sele_proxid_weight100;
  integer2 org_proxid_weight100;
  integer2 ultimate_proxid_weight100;
  integer2 sele_flag_weight100;
  integer2 org_flag_weight100;
  integer2 ult_flag_weight100;
 END;

export rthor_data400__key__bizlinkfull__proxid__refs__l_contact_did := 
RECORD
  unsigned6 contact_did;
  unsigned1 fallback_value;
  unsigned6 ultid;
  unsigned6 orgid;
  unsigned6 seleid;
  unsigned6 proxid;
  unsigned6 powid;
  integer2 contact_did_weight100;
 END;

export rthor_data400__key__bizlinkfull__proxid__refs__l_contact_ssn := 
RECORD
  string9 contact_ssn;
  unsigned1 fallback_value;
  unsigned6 ultid;
  unsigned6 orgid;
  unsigned6 seleid;
  unsigned6 proxid;
  string60 contact_email;
  string8 company_sic_code1;
  string240 cnp_name;
  string30 cnp_number;
  string10 cnp_btype;
  string20 cnp_lowv;
  string5 zip;
  string28 prim_name;
  string25 city;
  string2 st;
  string10 prim_range;
  string8 sec_range;
  unsigned6 parent_proxid;
  unsigned6 sele_proxid;
  unsigned6 org_proxid;
  unsigned6 ultimate_proxid;
  string1 sele_flag;
  string1 org_flag;
  string1 ult_flag;
  unsigned6 powid;
  integer2 contact_ssn_weight100;
  integer2 contact_email_weight100;
  integer2 company_sic_code1_weight100;
  integer2 cnp_name_weight100;
  integer2 cnp_name_initial_char_weight100;
  integer2 cnp_number_weight100;
  integer2 cnp_btype_weight100;
  integer2 cnp_lowv_weight100;
  integer2 zip_weight100;
  integer2 prim_name_weight100;
  unsigned2 prim_name_e1_weight100;
  integer2 city_weight100;
  integer2 city_p_weight100;
  integer2 city_e2_weight100;
  integer2 city_e2p_weight100;
  integer2 st_weight100;
  integer2 prim_range_weight100;
  unsigned2 prim_range_e1_weight100;
  integer2 sec_range_weight100;
  unsigned2 sec_range_e1_weight100;
  integer2 parent_proxid_weight100;
  integer2 sele_proxid_weight100;
  integer2 org_proxid_weight100;
  integer2 ultimate_proxid_weight100;
  integer2 sele_flag_weight100;
  integer2 org_flag_weight100;
  integer2 ult_flag_weight100;
 END;

export rthor_data400__key__bizlinkfull__proxid__refs__l_email := 
RECORD
  string60 contact_email;
  unsigned1 fallback_value;
  unsigned6 ultid;
  unsigned6 orgid;
  unsigned6 seleid;
  unsigned6 proxid;
  string8 company_sic_code1;
  string240 cnp_name;
  string30 cnp_number;
  string10 cnp_btype;
  string20 cnp_lowv;
  string5 zip;
  string28 prim_name;
  string25 city;
  string2 st;
  string10 prim_range;
  string8 sec_range;
  unsigned6 parent_proxid;
  unsigned6 sele_proxid;
  unsigned6 org_proxid;
  unsigned6 ultimate_proxid;
  string1 sele_flag;
  string1 org_flag;
  string1 ult_flag;
  unsigned6 powid;
  integer2 contact_email_weight100;
  integer2 company_sic_code1_weight100;
  integer2 cnp_name_weight100;
  integer2 cnp_name_initial_char_weight100;
  integer2 cnp_number_weight100;
  integer2 cnp_btype_weight100;
  integer2 cnp_lowv_weight100;
  integer2 zip_weight100;
  integer2 prim_name_weight100;
  unsigned2 prim_name_e1_weight100;
  integer2 city_weight100;
  integer2 city_p_weight100;
  integer2 city_e2_weight100;
  integer2 city_e2p_weight100;
  integer2 st_weight100;
  integer2 prim_range_weight100;
  unsigned2 prim_range_e1_weight100;
  integer2 sec_range_weight100;
  unsigned2 sec_range_e1_weight100;
  integer2 parent_proxid_weight100;
  integer2 sele_proxid_weight100;
  integer2 org_proxid_weight100;
  integer2 ultimate_proxid_weight100;
  integer2 sele_flag_weight100;
  integer2 org_flag_weight100;
  integer2 ult_flag_weight100;
 END;

export rthor_data400__key__bizlinkfull__proxid__refs__l_fein := 
RECORD
  string9 company_fein;
  unsigned1 fallback_value;
  unsigned6 ultid;
  unsigned6 orgid;
  unsigned6 seleid;
  unsigned6 proxid;
  string8 company_sic_code1;
  string240 cnp_name;
  string30 cnp_number;
  string10 cnp_btype;
  string20 cnp_lowv;
  string5 zip;
  string28 prim_name;
  string25 city;
  string2 st;
  string10 prim_range;
  string8 sec_range;
  unsigned6 parent_proxid;
  unsigned6 sele_proxid;
  unsigned6 org_proxid;
  unsigned6 ultimate_proxid;
  string1 sele_flag;
  string1 org_flag;
  string1 ult_flag;
  unsigned6 powid;
  integer2 company_fein_weight100;
  integer2 company_fein_e1_weight100;
  integer2 company_sic_code1_weight100;
  integer2 cnp_name_weight100;
  integer2 cnp_name_initial_char_weight100;
  integer2 cnp_number_weight100;
  integer2 cnp_btype_weight100;
  integer2 cnp_lowv_weight100;
  integer2 zip_weight100;
  integer2 prim_name_weight100;
  unsigned2 prim_name_e1_weight100;
  integer2 city_weight100;
  integer2 city_p_weight100;
  integer2 city_e2_weight100;
  integer2 city_e2p_weight100;
  integer2 st_weight100;
  integer2 prim_range_weight100;
  unsigned2 prim_range_e1_weight100;
  integer2 sec_range_weight100;
  unsigned2 sec_range_e1_weight100;
  integer2 parent_proxid_weight100;
  integer2 sele_proxid_weight100;
  integer2 org_proxid_weight100;
  integer2 ultimate_proxid_weight100;
  integer2 sele_flag_weight100;
  integer2 org_flag_weight100;
  integer2 ult_flag_weight100;
 END;

export rthor_data400__key__bizlinkfull__proxid__refs__l_phone := 
RECORD
  string7 company_phone_7;
  string3 company_phone_3;
  unsigned1 fallback_value;
  unsigned6 ultid;
  unsigned6 orgid;
  unsigned6 seleid;
  unsigned6 proxid;
  string240 cnp_name;
  string3 company_phone_3_ex;
  string8 company_sic_code1;
  string30 cnp_number;
  string10 cnp_btype;
  string20 cnp_lowv;
  string5 zip;
  string28 prim_name;
  string25 city;
  string2 st;
  string10 prim_range;
  string8 sec_range;
  unsigned6 parent_proxid;
  unsigned6 sele_proxid;
  unsigned6 org_proxid;
  unsigned6 ultimate_proxid;
  string1 sele_flag;
  string1 org_flag;
  string1 ult_flag;
  unsigned6 powid;
  integer2 company_phone_7_weight100;
  integer2 cnp_name_weight100;
  integer2 cnp_name_initial_char_weight100;
  integer2 company_phone_3_weight100;
  integer2 company_phone_3_ex_weight100;
  integer2 company_sic_code1_weight100;
  integer2 cnp_number_weight100;
  integer2 cnp_btype_weight100;
  integer2 cnp_lowv_weight100;
  integer2 zip_weight100;
  integer2 prim_name_weight100;
  unsigned2 prim_name_e1_weight100;
  integer2 city_weight100;
  integer2 city_p_weight100;
  integer2 city_e2_weight100;
  integer2 city_e2p_weight100;
  integer2 st_weight100;
  integer2 prim_range_weight100;
  unsigned2 prim_range_e1_weight100;
  integer2 sec_range_weight100;
  unsigned2 sec_range_e1_weight100;
  integer2 parent_proxid_weight100;
  integer2 sele_proxid_weight100;
  integer2 org_proxid_weight100;
  integer2 ultimate_proxid_weight100;
  integer2 sele_flag_weight100;
  integer2 org_flag_weight100;
  integer2 ult_flag_weight100;
 END;


export rthor_data400__key__bizlinkfull__proxid__refs__l_sic := 
RECORD
  string8 company_sic_code1;
  string5 zip;
  unsigned1 fallback_value;
  unsigned6 ultid;
  unsigned6 orgid;
  unsigned6 seleid;
  unsigned6 proxid;
  string240 cnp_name;
  string28 prim_name;
  unsigned6 powid;
  integer2 company_sic_code1_weight100;
  integer2 zip_weight100;
  integer2 cnp_name_weight100;
  integer2 cnp_name_initial_char_weight100;
  integer2 prim_name_weight100;
  unsigned2 prim_name_e1_weight100;
 END;

export rthor_data400__key__bizlinkfull__proxid__refs__l_source := 
RECORD
  unsigned8 source_record_id;
  string2 source;
  string5 zip;
  string2 st;
  unsigned1 fallback_value;
  unsigned6 ultid;
  unsigned6 orgid;
  unsigned6 seleid;
  unsigned6 proxid;
  string240 cnp_name;
  string28 prim_name;
  string25 city;
  string8 company_sic_code1;
  string30 cnp_number;
  string10 cnp_btype;
  string20 cnp_lowv;
  string10 prim_range;
  string8 sec_range;
  unsigned6 parent_proxid;
  unsigned6 sele_proxid;
  unsigned6 org_proxid;
  unsigned6 ultimate_proxid;
  string1 sele_flag;
  string1 org_flag;
  string1 ult_flag;
  unsigned6 powid;
  integer2 source_record_id_weight100;
  integer2 source_weight100;
  integer2 cnp_name_weight100;
  integer2 cnp_name_initial_char_weight100;
  integer2 prim_name_weight100;
  unsigned2 prim_name_e1_weight100;
  integer2 zip_weight100;
  integer2 city_weight100;
  integer2 city_p_weight100;
  integer2 city_e2_weight100;
  integer2 city_e2p_weight100;
  integer2 st_weight100;
  integer2 company_sic_code1_weight100;
  integer2 cnp_number_weight100;
  integer2 cnp_btype_weight100;
  integer2 cnp_lowv_weight100;
  integer2 prim_range_weight100;
  unsigned2 prim_range_e1_weight100;
  integer2 sec_range_weight100;
  unsigned2 sec_range_e1_weight100;
  integer2 parent_proxid_weight100;
  integer2 sele_proxid_weight100;
  integer2 org_proxid_weight100;
  integer2 ultimate_proxid_weight100;
  integer2 sele_flag_weight100;
  integer2 org_flag_weight100;
  integer2 ult_flag_weight100;
 END;

export rthor_data400__key__bizlinkfull__proxid__refs__l_url := 
RECORD
  unsigned4 gss_hash;
  unsigned1 fallback_value;
  unsigned6 ultid;
  unsigned6 orgid;
  unsigned6 seleid;
  unsigned6 proxid;
  string2 st;
  string8 company_sic_code1;
  string240 cnp_name;
  string30 cnp_number;
  string10 cnp_btype;
  string20 cnp_lowv;
  string5 zip;
  string28 prim_name;
  string25 city;
  string10 prim_range;
  string8 sec_range;
  unsigned6 parent_proxid;
  unsigned6 sele_proxid;
  unsigned6 org_proxid;
  unsigned6 ultimate_proxid;
  string1 sele_flag;
  string1 org_flag;
  string1 ult_flag;
  unsigned6 powid;
  unsigned2 gss_word_weight;
  string240 company_url;
  unsigned8 gss_bloom;
  integer2 st_weight100;
  integer2 company_sic_code1_weight100;
  integer2 cnp_name_weight100;
  integer2 cnp_name_initial_char_weight100;
  integer2 cnp_number_weight100;
  integer2 cnp_btype_weight100;
  integer2 cnp_lowv_weight100;
  integer2 zip_weight100;
  integer2 prim_name_weight100;
  unsigned2 prim_name_e1_weight100;
  integer2 city_weight100;
  integer2 city_p_weight100;
  integer2 city_e2_weight100;
  integer2 city_e2p_weight100;
  integer2 prim_range_weight100;
  unsigned2 prim_range_e1_weight100;
  integer2 sec_range_weight100;
  unsigned2 sec_range_e1_weight100;
  integer2 parent_proxid_weight100;
  integer2 sele_proxid_weight100;
  integer2 org_proxid_weight100;
  integer2 ultimate_proxid_weight100;
  integer2 sele_flag_weight100;
  integer2 org_flag_weight100;
  integer2 ult_flag_weight100;
 END;

export rthor_data400__key__bizlinkfull__proxid__sup__orgid := 
record  
	unsigned6 orgid; unsigned6 ultid ;
end;

export rthor_data400__key__bizlinkfull__proxid__sup__proxid := 
record
  unsigned6 proxid;
  unsigned6 ultid;
  unsigned6 orgid;
  unsigned6 seleid;
	unsigned6 powid;
end;

export rthor_data400__key__bizlinkfull__proxid__sup__rcid := 
record
  unsigned6 rcid;
  unsigned6 ultid;
  unsigned6 orgid;
  unsigned6 seleid;
  unsigned6 proxid;
	unsigned6 powid;
end;

export rthor_data400__key__bizlinkfull__proxid__sup__seleid := 
record  
	unsigned6 seleid; 
	unsigned6 ultid;
	unsigned6 orgid;
end;

export rthor_data400__key__bizlinkfull__proxid__wheel__city_clean := 
record  
	string30 prefix;
	real8 specificity;
	unsigned8 __internal_fpos__ ;
end;

export rthor_data400__key__bizlinkfull__proxid__wheel_quick__city_clean := 
record  
	string30 prefix;
	real8 specificity;
	unsigned8 __internal_fpos__ ;
end;

export rthor_data400__key__bizlinkfull__proxid__word__cnp_name := 
RECORD
  string250 cnp_name;
  unsigned8 cnt;
  unsigned8 t_cnt;
  real8 field_specificity;
  unsigned8 __internal_fpos__;
 END;

export rthor_data400__key__bizlinkfull__proxid__word__company_url := 
RECORD
  string80 company_url;
  unsigned8 cnt;
  unsigned8 t_cnt;
  real8 field_specificity;
  unsigned8 __internal_fpos__;
 END;

export rthor_data400__key__bizlinkfull__proxid__words := 
record
  string30 word;
  unsigned8 cnt;
  unsigned8 t_cnt;
  unsigned4 id;
  real8 field_specificity;
  unsigned8 __internal_fpos__;
end;

export rthor_data400__key__proxid__bipv2_proxid__attribute_matches := 
record,maxlength(32000)
  unsigned6 proxid1;
  unsigned6 proxid2;
  unsigned2 rule;
  integer2 conf;
  integer2 dateoverlap;
  integer2 conf_prop;
  unsigned6 rcid1;
  unsigned6 rcid2;
  string source_id;
  unsigned2 support_cnp_name;
end; 

export rthor_data400__key__proxid__bipv2_proxid__match_candidates_debug := 
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
  unsigned8 __internal_fpos__;
 END;

export proxid_bipv2_proxid_specificities_debug := module

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


export rthor_data400__key__proxid__bipv2_proxid__specificities_debug := 
RECORD,maxlength(32000)
  integer8 _unnamed_1;
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
  unsigned8 __internal_fpos__;
 END;
end;

export rthor_data400__key__proxid__bipv2_relative__assoc := 
record
  unsigned6 proxid1;
  unsigned6 proxid2;
  integer2 duns_number_score;
  integer2 duns_number_cnt;
  integer2 enterprise_number_score;
  integer2 enterprise_number_cnt;
  integer2 source_score;
  integer2 source_cnt;
  integer2 contact_score;
  integer2 contact_cnt;
  integer2 address_score;
  integer2 address_cnt;
  integer2 namest_score;
  integer2 namest_cnt;
  integer2 charter_score;
  integer2 charter_cnt;
  integer2 fein_score;
  integer2 fein_cnt;
  integer2 mname_score;
  integer2 contact_ssn_score;
  integer2 contact_phone_score;
  integer2 contact_email_username_score;
  unsigned2 total_cnt;
  integer2 total_score;
end;

export dthor_data400__bip2_0__translations__date 														:= dataset([],rthor_data400__bip2_0__translations__date);
export dthor_data400__bip_v2__strnbrname 																		:= dataset([],rthor_data400__bip_v2__strnbrname);
export dthor_data400__bipv2_hrchy__key__lgid 																:= dataset([],rthor_data400__bipv2_hrchy__key__lgid);
export dthor_data400__bipv2_hrchy__key__proxid 															:= dataset([],rthor_data400__bipv2_hrchy__key__proxid);
export dthor_data400__key__bipv2__aml_addr																	:= project(prte_bip.files('business_header').base.built,transform(rthor_data400__bipv2_aml__addr,self := left; self := [];));
export dthor_data400__key__bipv2__business_header__linkids									:= project(prte_bip.files('business_header').base.built,transform(rthor_data400__key__bipv2__business_header__linkids,self := left; self := [];));
export dthor_data400__key__bipv2__business_header__status 									:= project(prte_bip.files('business_header').base.built,transform(rthor_data400__key__bipv2__business_header__status,self := left; self := [];));
export dthor_data400__key__bipv2__industry_linkids													:= project(prte_bip.files('business_header').base.built,transform(rthor_data400__key__bipv2__industry_linkids,self := left; self := [];));
export dthor_data400__key__bipv2__license_linkids 													:= project(prte_bip.files('business_header').base.built,transform(rthor_data400__key__bipv2__license_linkids,self := left; self := [];));
export dthor_data400__key__bipv2__zipcityst 																:= dataset([],rthor_data400__key__bipv2__zipcityst);
export dthor_data400__key__bipv2_best__linkids 															:= dataset([],rthor_data400__key__bipv2_best__linkids);
export dthor_data400__key__bipv2_biz__preferred															:= dataset([],rthor_data400__key__bipv2_biz__preferred);
export dthor_data400__key__bipv2_lgid3__match_candidates_debug							:= dataset([],rthor_data400__key__bipv2_lgid3__match_candidates_debug);
export dthor_data400__key__bipv2_lgid3__specificities_debug 								:= dataset([],bipv2_lgid3_specificities_debug.rthor_data400__key__bipv2_lgid3__specificities_debug);
export dthor_data400__key__bipv2_seleid_relative__seleid__rel__assoc 				:= dataset([],rthor_data400__key__bipv2_seleid_relative__seleid__rel__assoc);
export dthor_data400__key__bizlinkfull__proxid__meow 												:= project(prte_bip.files('business_header').base.built,transform(rthor_data400__key__bizlinkfull__proxid__meow,self := left; self := [];));
export dthor_data400__key__bizlinkfull__proxid__refs 												:= project(prte_bip.files('business_header').base.built,transform(rthor_data400__key__bizlinkfull__proxid__refs,self := left; self := [];));
export dthor_data400__key__bizlinkfull__proxid__refs__l_address1 						:= project(prte_bip.files('business_header').base.built,transform(rthor_data400__key__bizlinkfull__proxid__refs__l_address1,self := left; self := [];));
export dthor_data400__key__bizlinkfull__proxid__refs__l_address2 						:= project(prte_bip.files('business_header').base.built,transform(rthor_data400__key__bizlinkfull__proxid__refs__l_address2,self := left; self := [];));
export dthor_data400__key__bizlinkfull__proxid__refs__l_address3 						:= project(prte_bip.files('business_header').base.built,transform(rthor_data400__key__bizlinkfull__proxid__refs__l_address3,self := left; self := [];));
export dthor_data400__key__bizlinkfull__proxid__refs__l_cnpname 						:= project(prte_bip.files('business_header').base.built,transform(rthor_data400__key__bizlinkfull__proxid__refs__l_cnpname,self := left; self := [];));
export dthor_data400__key__bizlinkfull__proxid__refs__l_cnpname_fuzzy 			:= project(prte_bip.files('business_header').base.built,transform(rthor_data400__key__bizlinkfull__proxid__refs__l_cnpname_fuzzy,self := left; self := [];));
export dthor_data400__key__bizlinkfull__proxid__refs__l_cnpname_st 					:= project(prte_bip.files('business_header').base.built,transform(rthor_data400__key__bizlinkfull__proxid__refs__l_cnpname_st,self := left; self := [];));
export dthor_data400__key__bizlinkfull__proxid__refs__l_cnpname_zip 				:= project(prte_bip.files('business_header').base.built,transform(rthor_data400__key__bizlinkfull__proxid__refs__l_cnpname_zip,self := left; self := [];));
export dthor_data400__key__bizlinkfull__proxid__refs__l_contact 						:= project(prte_bip.files('business_header').base.built,transform(rthor_data400__key__bizlinkfull__proxid__refs__l_contact,self := left; self := [];));
export dthor_data400__key__bizlinkfull__proxid__refs__l_contact_did 				:= project(prte_bip.files('business_header').base.built,transform(rthor_data400__key__bizlinkfull__proxid__refs__l_contact_did,self := left; self := [];));
export dthor_data400__key__bizlinkfull__proxid__refs__l_contact_ssn 				:= project(prte_bip.files('business_header').base.built,transform(rthor_data400__key__bizlinkfull__proxid__refs__l_contact_ssn,self := left; self := [];));
export dthor_data400__key__bizlinkfull__proxid__refs__l_email 							:= project(prte_bip.files('business_header').base.built,transform(rthor_data400__key__bizlinkfull__proxid__refs__l_email,self := left; self := [];));
export dthor_data400__key__bizlinkfull__proxid__refs__l_fein 								:= project(prte_bip.files('business_header').base.built,transform(rthor_data400__key__bizlinkfull__proxid__refs__l_fein,self := left; self := [];));
export dthor_data400__key__bizlinkfull__proxid__refs__l_phone 							:= project(prte_bip.files('business_header').base.built,transform(rthor_data400__key__bizlinkfull__proxid__refs__l_phone,self := left; self := [];));
export dthor_data400__key__bizlinkfull__proxid__refs__l_sic		 							:= project(prte_bip.files('business_header').base.built,transform(rthor_data400__key__bizlinkfull__proxid__refs__l_sic,self := left; self := [];));
export dthor_data400__key__bizlinkfull__proxid__refs__l_source 							:= project(prte_bip.files('business_header').base.built,transform(rthor_data400__key__bizlinkfull__proxid__refs__l_source,self := left; self := [];));
export dthor_data400__key__bizlinkfull__proxid__refs__l_url 								:= project(prte_bip.files('business_header').base.built,transform(rthor_data400__key__bizlinkfull__proxid__refs__l_url,self := left; self := [];));
export dthor_data400__key__bizlinkfull__proxid__sup__orgid 									:= project(prte_bip.files('business_header').base.built,transform(rthor_data400__key__bizlinkfull__proxid__sup__orgid,self := left; self := [];));
export dthor_data400__key__bizlinkfull__proxid__sup__proxid 								:= project(prte_bip.files('business_header').base.built,transform(rthor_data400__key__bizlinkfull__proxid__sup__proxid,self := left; self := [];));
export dthor_data400__key__bizlinkfull__proxid__sup__rcid 									:= project(prte_bip.files('business_header').base.built,transform(rthor_data400__key__bizlinkfull__proxid__sup__rcid,self := left; self := [];));
export dthor_data400__key__bizlinkfull__proxid__sup__seleid 								:= project(prte_bip.files('business_header').base.built,transform(rthor_data400__key__bizlinkfull__proxid__sup__seleid,self := left; self := [];));
export dthor_data400__key__bizlinkfull__proxid__wheel__city_clean 					:= project(prte_bip.files('business_header').base.built,transform(rthor_data400__key__bizlinkfull__proxid__wheel__city_clean,self := left; self := [];));
export dthor_data400__key__bizlinkfull__proxid__wheel_quick__city_clean 		:= project(prte_bip.files('business_header').base.built,transform(rthor_data400__key__bizlinkfull__proxid__wheel_quick__city_clean,self := left; self := [];));
export dthor_data400__key__bizlinkfull__proxid__word__cnp_name 							:= project(prte_bip.files('business_header').base.built,transform(rthor_data400__key__bizlinkfull__proxid__word__cnp_name,self := left; self := [];));
export dthor_data400__key__bizlinkfull__proxid__word__company_url 					:= project(prte_bip.files('business_header').base.built,transform(rthor_data400__key__bizlinkfull__proxid__word__company_url,self := left; self := [];));
export dthor_data400__key__bizlinkfull__proxid__words 											:= project(prte_bip.files('business_header').base.built,transform(rthor_data400__key__bizlinkfull__proxid__words,self := left; self := [];));
export dthor_data400__key__proxid__bipv2_proxid__attribute_matches 					:= dataset([],rthor_data400__key__proxid__bipv2_proxid__attribute_matches);
export dthor_data400__key__proxid__bipv2_proxid__match_candidates_debug 		:= dataset([],rthor_data400__key__proxid__bipv2_proxid__match_candidates_debug);
export dthor_data400__key__proxid__bipv2_proxid__specificities_debug 				:= dataset([],proxid_bipv2_proxid_specificities_debug.rthor_data400__key__proxid__bipv2_proxid__specificities_debug);
export dthor_data400__key__proxid__bipv2_relative__assoc 										:= dataset([],rthor_data400__key__proxid__bipv2_relative__assoc);

end;
