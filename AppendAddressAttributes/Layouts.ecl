EXPORT Layouts := MODULE

/* 
 Corresponds with ADVO.Layouts.Layout_Common_Out_k in the repository.
*/ 

EXPORT Layout_Common_Out_k := RECORD
  string5 zip;
  string10 prim_range;
  string28 prim_name;
  string4 addr_suffix;
  string2 predir;
  string2 postdir;
  string8 sec_range;
  string5 zip_5;
  string4 route_num;
  string4 zip_4;
  string9 walk_sequence;
  string10 street_num;
  string2 street_pre_directional;
  string28 street_name;
  string2 street_post_directional;
  string4 street_suffix;
  string4 secondary_unit_designator;
  string8 secondary_unit_number;
  string1 address_vacancy_indicator;
  string1 throw_back_indicator;
  string1 seasonal_delivery_indicator;
  string5 seasonal_start_suppression_date;
  string5 seasonal_end_suppression_date;
  string1 dnd_indicator;
  string1 college_indicator;
  string10 college_start_suppression_date;
  string10 college_end_suppression_date;
  string1 address_style_flag;
  string5 simplify_address_count;
  string1 drop_indicator;
  string1 residential_or_business_ind;
  string2 dpbc_digit;
  string1 dpbc_check_digit;
  string10 update_date;
  string10 file_release_date;
  string10 override_file_release_date;
  string3 county_num;
  string28 county_name;
  string28 city_name;
  string2 state_code;
  string2 state_num;
  string2 congressional_district_number;
  string1 owgm_indicator;
  string1 record_type_code;
  string10 advo_key;
  string1 address_type;
  string1 mixed_address_usage;
  string8 date_first_seen;
  string8 date_last_seen;
  string8 date_vendor_first_reported;
  string8 date_vendor_last_reported;
  string8 vac_begdt;
  string8 vac_enddt;
  string8 months_vac_curr;
  string8 months_vac_max;
  string8 vac_count;
  string10 unit_desig;
  string25 p_city_name;
  string25 v_city_name;
  string2 st;
  string4 zip4;
  string4 cart;
  string1 cr_sort_sz;
  string4 lot;
  string1 lot_order;
  string2 dbpc;
  string1 chk_digit;
  string2 rec_type;
  string2 fips_county;
  string3 county;
  string10 geo_lat;
  string11 geo_long;
  string4 msa;
  string7 geo_blk;
  string1 geo_match;
  string4 err_stat;
 END;

END;