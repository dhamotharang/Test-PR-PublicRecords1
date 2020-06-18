﻿IMPORT PRTE2_Neighborhood, Address_Attributes, ACA, FBI_UCR;

EXPORT Layouts := MODULE

  EXPORT l_ACA := RECORD
    string12  geolink;
    qstring10 geo_lat;
    qstring11 geo_long;
    recordof(ACA.key_aca_addr);
  END;

  EXPORT l_neighborhoodstats  := RECORD
    string12 geolink;
    unsigned2 neighborhood_vacant_properties;
    unsigned2 neighborhood_business_count;
    unsigned2 neighborhood_sfd_count;
    unsigned2 neighborhood_mfd_count;
    unsigned2 neighborhood_collegeaddr_count;
    unsigned2 neighborhood_seasonaladdr_count;
    unsigned4 neighborhood_pobox_count;
    unsigned2 nod;
    unsigned2 nod_1yr;
    unsigned2 nod_2yr;
    unsigned2 nod_3yr;
    unsigned2 nod_4yr;
    unsigned2 nod_5yr;
    unsigned2 foreclosures;
    unsigned2 foreclosures_1yr;
    unsigned2 foreclosures_2yr;
    unsigned2 foreclosures_3yr;
    unsigned2 foreclosures_4yr;
    unsigned2 foreclosures_5yr;
    unsigned2 deed_transfers;
    unsigned2 deed_transfers_1yr;
    unsigned2 deed_transfers_2yr;
    unsigned2 deed_transfers_3yr;
    unsigned2 deed_transfers_4yr;
    unsigned2 deed_transfers_5yr;
    unsigned2 release_lis_pendens;
    unsigned2 release_lis_pendens_1yr;
    unsigned2 release_lis_pendens_2yr;
    unsigned2 release_lis_pendens_3yr;
    unsigned2 release_lis_pendens_4yr;
    unsigned2 release_lis_pendens_5yr;
    unsigned1 liens_recent_unreleased_count;
    unsigned1 liens_historical_unreleased_count;
    unsigned1 liens_recent_released_count;
    unsigned1 liens_historical_released_count;
    unsigned1 eviction_recent_unreleased_count;
    unsigned1 eviction_historical_unreleased_count;
    unsigned1 eviction_recent_released_count;
    unsigned1 eviction_historical_released_count;
    unsigned4 occupant_owned_count;
    unsigned4 cnt_building_age;
    unsigned4 ave_building_age;
    unsigned4 cnt_purchase_amount;
    unsigned4 ave_purchase_amount;
    unsigned4 cnt_mortgage_amount;
    unsigned4 ave_mortgage_amount;
    unsigned4 cnt_assessed_amount;
    unsigned4 ave_assessed_amount;
    unsigned8 cnt_building_area;
    unsigned8 ave_building_area;
    unsigned8 cnt_price_per_sf;
    unsigned8 ave_price_per_sf;
    unsigned8 cnt_no_of_buildings_count;
    unsigned8 ave_no_of_buildings_count;
    unsigned8 cnt_no_of_stories_count;
    unsigned8 ave_no_of_stories_count;
    unsigned8 cnt_no_of_rooms_count;
    unsigned8 ave_no_of_rooms_count;
    unsigned8 cnt_no_of_bedrooms_count;
    unsigned8 ave_no_of_bedrooms_count;
    unsigned8 cnt_no_of_baths_count;
    unsigned8 ave_no_of_baths_count;
    unsigned8 cnt_no_of_partial_baths_count;
    unsigned8 ave_no_of_partial_baths_count;
    unsigned4 total_property_count;
    unsigned1 bk_cnt;
    unsigned1 bk_1yr;
    unsigned1 bk_2yr;
    unsigned1 bk_3yr;
    unsigned1 bk_4yr;
    unsigned1 bk_5yr;
    unsigned1 bk_ch7_cnt;
    unsigned1 bk_ch11_cnt;
    unsigned1 bk_ch12_cnt;
    unsigned1 bk_ch13_cnt;
    unsigned1 bk_discharged_cnt;
    unsigned1 bk_dismissed_cnt;
    unsigned1 bk_pro_se_cnt;
    unsigned1 bk_business_flag_cnt;
    unsigned1 bk_corp_flag_cnt;
  END;

  EXPORT l_business := RECORD
    unsigned6  rcid := 0;
    unsigned6  bdid := 0;
    string2    source;
    qstring34  source_group;
    string3    pflag;
    unsigned6  group1_id  := 0;
    qstring34  vendor_id;
    unsigned4  dt_first_seen;
    unsigned4  dt_last_seen;
    unsigned4  dt_vendor_first_reported;
    unsigned4  dt_vendor_last_reported;
    qstring120 company_name;
    qstring10  prim_range;
    string2    predir;
    qstring28  prim_name;
    qstring4   addr_suffix;
    string2    postdir;
    qstring5   unit_desig;
    qstring8   sec_range;
    qstring25  city;
    string2    state;
    unsigned3  zip;
    unsigned2  zip4;
    string3    county;
    string4    msa;
    qstring10  geo_lat;
    qstring11  geo_long;
    unsigned6  phone;
    unsigned2  phone_score  := 0;
    unsigned4  fein := 0;
    boolean    current;
    boolean    dppa;
    string7    geo_blk;
    string12   geolink;
    string1    geo_match;
  END;

  Export linkids:=RECORD
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
     unsigned4 global_sid;
     unsigned8 record_sid;
     unsigned6 locid;
     integer1 fp;
 END;

  EXPORT l_Fbi_cius  := RECORD
    FBI_UCR.layouts.layout_CIUS_city;
  END;

  EXPORT l_GeoLinkDistance  := RECORD
    string12 geolink1;
    string12 geolink2;
    unsigned2 dist_100th;
  END;

  EXPORT l_geoblk_latlon  := RECORD
    qstring12 geolink;
    integer4 lat1000;
    real4 lat;
    real4 lon;
  END;

  EXPORT l_GeoblkInfo  := RECORD
    string12 geolink;
    string10 lat;
    string11 long;
  END;
  
  EXPORT rthor_data400_key_neighborhood_colleges_address := record
     string12 geolink;     
     string10 unitid;
     string120 college_name;
     string1 inst_type;
     string12 phone;
     string10 prim_range;
     string2 predir;
     string28 prim_name;
     string4 suffix;
     string2 postdir;
     string10 unit_desig;
     string8 sec_range;
     string25 p_city_name;
     string2 st;
     string5 zip;
     string4 zip4;
     string10 geo_lat;
     string11 geo_long;
     string7 geo_blk;
     string5 county;
     string4 msa;
     string1 geo_match;
     string240 webaddr;
     unsigned8 __internal_fpos__;
  END;
  
  EXPORT rthor_data400_key_neighborhood_schools_address := record
     string12 geolink;
     string15 unitid;
     string1 inst_type;
     string120 school_name;
     string10 prim_range;
     string2 predir;
     string28 prim_name;
     string4 suffix;
     string2 postdir;
     string10 unit_desig;
     string8 sec_range;
     string25 p_city_name;
     string2 st;
     string5 zip;
     string4 zip4;
     string10 geo_lat;
     string11 geo_long;
     string7 geo_blk;
     string5 county;
     string4 msa;
     string1 geo_match;
     unsigned8 __internal_fpos__;
  END;
  
  EXPORT rthor_data400_key_neighborhood_sex_offender_geolink := record
     string12 geolink;
     qstring10 prim_range;
     string2 predir;
     qstring28 prim_name;
     qstring4 addr_suffix;
     string2 postdir;
     qstring10 unit_desig;
     qstring8 sec_range;
     qstring25 p_city_name;
     qstring25 v_city_name;
     string2 st;
     qstring5 zip5;
     qstring4 zip4;
     qstring4 cart;
     string1 cr_sort_sz;
     qstring4 lot;
     string1 lot_order;
     string2 dbpc;
     string1 chk_digit;
     string2 rec_type;
     qstring5 county;
     qstring10 geo_lat;
     qstring11 geo_long;
     qstring4 msa;
     qstring7 geo_blk;
     string1 geo_match;
     qstring4 err_stat;
     unsigned1 clean_errors;
     unsigned8 did;
     string30 lname;
     string30 fname;
     string20 mname;
     string20 name_suffix;
     string50 offender_status;
     string40 offender_category;
     string10 risk_level_code;
     string8 reg_date_1;
     string125 registration_address_1;
     string30 offender_id;
     string30 st_id_number;
     string8 dob;
     string8 dob_aka;
     string3 age;
     string30 race;
     string30 ethnicity;
     string10 sex;
     string40 hair_color;
     string40 eye_color;
     string3 height;
     string3 weight;
     string20 skin_tone;
     string6 addr_dt_last_seen;
     unsigned8 rawaid;
     string1 curr_incar_flag;
     string1 curr_parole_flag;
     string1 curr_probation_flag;
     unsigned4 global_sid;
     unsigned8 record_sid;
  END;

END;

