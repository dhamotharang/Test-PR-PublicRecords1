IMPORT ut,SALT30;
EXPORT Scrubs := MODULE
  EXPORT InValidMessage_invalid_vendor_dates(UNSIGNED1 wh) := CHOOSE(wh, 'dt_vendor_first_reported_Invalid', 'dt_vendor_last_reported_Invalid', 'dt_vendor_first_reported_dt_vendor_last_reported_Cnd_Invalid');
  EXPORT InValidMessage_invalid_seen_dates(UNSIGNED1 wh) := CHOOSE(wh, 'dt_first_seen_Invalid', 'dt_last_seen_Invalid', 'dt_first_seen_dt_last_seen_Condition_Invalid');
// The module to handle the case where no scrubs exist
  EXPORT  Expanded_Layout := RECORD(Layout_Targus)
    UNSIGNED1 record_id_Invalid;
    UNSIGNED1 pubdate_Invalid;
    UNSIGNED1 yppa_code_Invalid;
    UNSIGNED1 book_code_Invalid;
    UNSIGNED1 page_number_Invalid;
    UNSIGNED1 record_number_Invalid;
    UNSIGNED1 phone_number_Invalid;
    UNSIGNED1 phone_type_Invalid;
    UNSIGNED1 record_type_Invalid;
    UNSIGNED1 no_solicitation_code_Invalid;
    UNSIGNED1 title_Invalid;
    UNSIGNED1 first_name_Invalid;
    UNSIGNED1 middle_name_Invalid;
    UNSIGNED1 last_name_Invalid;
    UNSIGNED1 last_name_suffix_Invalid;
    UNSIGNED1 job_title_Invalid;
    UNSIGNED1 secondary_name_title_Invalid;
    UNSIGNED1 secondary_first_name_Invalid;
    UNSIGNED1 secondary_middle_name_Invalid;
    UNSIGNED1 secondary_name_suffix_Invalid;
    UNSIGNED1 house_number_Invalid;
    UNSIGNED1 pre_direction_Invalid;
    UNSIGNED1 street_name_Invalid;
    UNSIGNED1 street_type_Invalid;
    UNSIGNED1 post_direction_Invalid;
    UNSIGNED1 apt_type_Invalid;
    UNSIGNED1 apt_number_Invalid;
    UNSIGNED1 box_number_Invalid;
    UNSIGNED1 expanded_pub_city_name_Invalid;
    UNSIGNED1 postal_city_name_Invalid;
    UNSIGNED1 state_Invalid;
    UNSIGNED1 z5_Invalid;
    UNSIGNED1 plus4_Invalid;
    UNSIGNED1 delivery_point_code_Invalid;
    UNSIGNED1 carrier_route_Invalid;
    UNSIGNED1 county_code__Invalid;
    UNSIGNED1 gnrl_address_return_code_Invalid;
    UNSIGNED1 house_number_usage_flag_Invalid;
    UNSIGNED1 pre_direction_usage_flag_Invalid;
    UNSIGNED1 street_name_usage_flag_Invalid;
    UNSIGNED1 street_type_usage_flag_Invalid;
    UNSIGNED1 post_direction_usage_flag_Invalid;
    UNSIGNED1 apt_number_usage_flag_Invalid;
    UNSIGNED1 validation_date_Invalid;
    UNSIGNED1 validation_flag_Invalid;
    UNSIGNED1 dt_first_seen_Invalid;
    UNSIGNED1 dt_last_seen_Invalid;
    UNSIGNED1 dt_vendor_last_reported_Invalid;
    UNSIGNED1 dt_vendor_first_reported_Invalid;
    UNSIGNED1 rec_type_Invalid;
    UNSIGNED1 fname_Invalid;
    UNSIGNED1 minit_Invalid;
    UNSIGNED1 lname_Invalid;
    UNSIGNED1 name_suffix_Invalid;
    UNSIGNED1 prim_range_Invalid;
    UNSIGNED1 predir_Invalid;
    UNSIGNED1 prim_name_Invalid;
    UNSIGNED1 suffix_Invalid;
    UNSIGNED1 postdir_Invalid;
    UNSIGNED1 unit_desig_Invalid;
    UNSIGNED1 sec_range_Invalid;
    UNSIGNED1 city_name_Invalid;
    UNSIGNED1 st_Invalid;
    UNSIGNED1 zip_Invalid;
    UNSIGNED1 zip4_Invalid;
    UNSIGNED1 county_Invalid;
    UNSIGNED1 cbsa_Invalid;
    UNSIGNED1 geo_blk_Invalid;
    UNSIGNED1 cleanname_Invalid;
    UNSIGNED1 cleanaddress_Invalid;
    UNSIGNED1 invalid_vendor_dates_Invalid;
    UNSIGNED1 invalid_seen_dates_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Layout_Targus)
    UNSIGNED8 ScrubsBits1;
    UNSIGNED8 ScrubsBits2;
  END;
EXPORT FromNone(DATASET(Layout_Targus) h) := MODULE
  Expanded_Layout into(h le) := TRANSFORM
    SELF.record_id_Invalid := Fields.InValid_record_id((SALT30.StrType)le.record_id);
    SELF.pubdate_Invalid := Fields.InValid_pubdate((SALT30.StrType)le.pubdate);
    SELF.yppa_code_Invalid := Fields.InValid_yppa_code((SALT30.StrType)le.yppa_code);
    SELF.book_code_Invalid := Fields.InValid_book_code((SALT30.StrType)le.book_code);
    SELF.page_number_Invalid := Fields.InValid_page_number((SALT30.StrType)le.page_number);
    SELF.record_number_Invalid := Fields.InValid_record_number((SALT30.StrType)le.record_number);
    SELF.phone_number_Invalid := Fields.InValid_phone_number((SALT30.StrType)le.phone_number);
    SELF.phone_type_Invalid := Fields.InValid_phone_type((SALT30.StrType)le.phone_type);
    SELF.record_type_Invalid := Fields.InValid_record_type((SALT30.StrType)le.record_type);
    SELF.no_solicitation_code_Invalid := Fields.InValid_no_solicitation_code((SALT30.StrType)le.no_solicitation_code);
    SELF.title_Invalid := Fields.InValid_title((SALT30.StrType)le.title);
    SELF.first_name_Invalid := Fields.InValid_first_name((SALT30.StrType)le.first_name);
    SELF.middle_name_Invalid := Fields.InValid_middle_name((SALT30.StrType)le.middle_name);
    SELF.last_name_Invalid := Fields.InValid_last_name((SALT30.StrType)le.last_name);
    SELF.last_name_suffix_Invalid := Fields.InValid_last_name_suffix((SALT30.StrType)le.last_name_suffix);
    SELF.job_title_Invalid := Fields.InValid_job_title((SALT30.StrType)le.job_title);
    SELF.secondary_name_title_Invalid := Fields.InValid_secondary_name_title((SALT30.StrType)le.secondary_name_title);
    SELF.secondary_first_name_Invalid := Fields.InValid_secondary_first_name((SALT30.StrType)le.secondary_first_name);
    SELF.secondary_middle_name_Invalid := Fields.InValid_secondary_middle_name((SALT30.StrType)le.secondary_middle_name);
    SELF.secondary_name_suffix_Invalid := Fields.InValid_secondary_name_suffix((SALT30.StrType)le.secondary_name_suffix);
    SELF.house_number_Invalid := Fields.InValid_house_number((SALT30.StrType)le.house_number);
    SELF.pre_direction_Invalid := Fields.InValid_pre_direction((SALT30.StrType)le.pre_direction);
    SELF.street_name_Invalid := Fields.InValid_street_name((SALT30.StrType)le.street_name);
    SELF.street_type_Invalid := Fields.InValid_street_type((SALT30.StrType)le.street_type);
    SELF.post_direction_Invalid := Fields.InValid_post_direction((SALT30.StrType)le.post_direction);
    SELF.apt_type_Invalid := Fields.InValid_apt_type((SALT30.StrType)le.apt_type);
    SELF.apt_number_Invalid := Fields.InValid_apt_number((SALT30.StrType)le.apt_number);
    SELF.box_number_Invalid := Fields.InValid_box_number((SALT30.StrType)le.box_number);
    SELF.expanded_pub_city_name_Invalid := Fields.InValid_expanded_pub_city_name((SALT30.StrType)le.expanded_pub_city_name);
    SELF.postal_city_name_Invalid := Fields.InValid_postal_city_name((SALT30.StrType)le.postal_city_name);
    SELF.state_Invalid := Fields.InValid_state((SALT30.StrType)le.state);
    SELF.z5_Invalid := Fields.InValid_z5((SALT30.StrType)le.z5);
    SELF.plus4_Invalid := Fields.InValid_plus4((SALT30.StrType)le.plus4);
    SELF.delivery_point_code_Invalid := Fields.InValid_delivery_point_code((SALT30.StrType)le.delivery_point_code);
    SELF.carrier_route_Invalid := Fields.InValid_carrier_route((SALT30.StrType)le.carrier_route);
    SELF.county_code__Invalid := Fields.InValid_county_code_((SALT30.StrType)le.county_code_);
    SELF.gnrl_address_return_code_Invalid := Fields.InValid_gnrl_address_return_code((SALT30.StrType)le.gnrl_address_return_code);
    SELF.house_number_usage_flag_Invalid := Fields.InValid_house_number_usage_flag((SALT30.StrType)le.house_number_usage_flag);
    SELF.pre_direction_usage_flag_Invalid := Fields.InValid_pre_direction_usage_flag((SALT30.StrType)le.pre_direction_usage_flag);
    SELF.street_name_usage_flag_Invalid := Fields.InValid_street_name_usage_flag((SALT30.StrType)le.street_name_usage_flag);
    SELF.street_type_usage_flag_Invalid := Fields.InValid_street_type_usage_flag((SALT30.StrType)le.street_type_usage_flag);
    SELF.post_direction_usage_flag_Invalid := Fields.InValid_post_direction_usage_flag((SALT30.StrType)le.post_direction_usage_flag);
    SELF.apt_number_usage_flag_Invalid := Fields.InValid_apt_number_usage_flag((SALT30.StrType)le.apt_number_usage_flag);
    SELF.validation_date_Invalid := Fields.InValid_validation_date((SALT30.StrType)le.validation_date);
    SELF.validation_flag_Invalid := Fields.InValid_validation_flag((SALT30.StrType)le.validation_flag);
    SELF.dt_first_seen_Invalid := Fields.InValid_dt_first_seen((SALT30.StrType)le.dt_first_seen);
    SELF.dt_last_seen_Invalid := Fields.InValid_dt_last_seen((SALT30.StrType)le.dt_last_seen);
    SELF.dt_vendor_last_reported_Invalid := Fields.InValid_dt_vendor_last_reported((SALT30.StrType)le.dt_vendor_last_reported);
    SELF.dt_vendor_first_reported_Invalid := Fields.InValid_dt_vendor_first_reported((SALT30.StrType)le.dt_vendor_first_reported);
    SELF.rec_type_Invalid := Fields.InValid_rec_type((SALT30.StrType)le.rec_type);
    SELF.fname_Invalid := Fields.InValid_fname((SALT30.StrType)le.fname);
    SELF.minit_Invalid := Fields.InValid_minit((SALT30.StrType)le.minit);
    SELF.lname_Invalid := Fields.InValid_lname((SALT30.StrType)le.lname);
    SELF.name_suffix_Invalid := Fields.InValid_name_suffix((SALT30.StrType)le.name_suffix);
    SELF.prim_range_Invalid := Fields.InValid_prim_range((SALT30.StrType)le.prim_range);
    SELF.predir_Invalid := Fields.InValid_predir((SALT30.StrType)le.predir);
    SELF.prim_name_Invalid := Fields.InValid_prim_name((SALT30.StrType)le.prim_name);
    SELF.suffix_Invalid := Fields.InValid_suffix((SALT30.StrType)le.suffix);
    SELF.postdir_Invalid := Fields.InValid_postdir((SALT30.StrType)le.postdir);
    SELF.unit_desig_Invalid := Fields.InValid_unit_desig((SALT30.StrType)le.unit_desig);
    SELF.sec_range_Invalid := Fields.InValid_sec_range((SALT30.StrType)le.sec_range);
    SELF.city_name_Invalid := Fields.InValid_city_name((SALT30.StrType)le.city_name);
    SELF.st_Invalid := Fields.InValid_st((SALT30.StrType)le.st);
    SELF.zip_Invalid := Fields.InValid_zip((SALT30.StrType)le.zip);
    SELF.zip4_Invalid := Fields.InValid_zip4((SALT30.StrType)le.zip4);
    SELF.county_Invalid := Fields.InValid_county((SALT30.StrType)le.county);
    SELF.cbsa_Invalid := Fields.InValid_cbsa((SALT30.StrType)le.cbsa);
    SELF.geo_blk_Invalid := Fields.InValid_geo_blk((SALT30.StrType)le.geo_blk);
    SELF.cleanname_Invalid := Fields.InValid_cleanname((SALT30.StrType)le.cleanname);
    SELF.cleanaddress_Invalid := Fields.InValid_cleanaddress((SALT30.StrType)le.cleanaddress);
    SELF.invalid_vendor_dates_Invalid := WHICH(Fields.InValid_dt_vendor_first_reported((SALT30.StrType)le.dt_vendor_first_reported)>0, Fields.InValid_dt_vendor_last_reported((SALT30.StrType)le.dt_vendor_last_reported)>0, NOT(le.dt_vendor_first_reported <= le.dt_vendor_last_reported));
    SELF.invalid_seen_dates_Invalid := WHICH(Fields.InValid_dt_first_seen((SALT30.StrType)le.dt_first_seen)>0, Fields.InValid_dt_last_seen((SALT30.StrType)le.dt_last_seen)>0, NOT(le.dt_first_seen <= le.dt_last_seen));
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.record_id_Invalid << 0 ) + ( le.pubdate_Invalid << 2 ) + ( le.yppa_code_Invalid << 4 ) + ( le.book_code_Invalid << 6 ) + ( le.page_number_Invalid << 8 ) + ( le.record_number_Invalid << 10 ) + ( le.phone_number_Invalid << 12 ) + ( le.phone_type_Invalid << 14 ) + ( le.record_type_Invalid << 16 ) + ( le.no_solicitation_code_Invalid << 17 ) + ( le.title_Invalid << 18 ) + ( le.first_name_Invalid << 19 ) + ( le.middle_name_Invalid << 20 ) + ( le.last_name_Invalid << 21 ) + ( le.last_name_suffix_Invalid << 22 ) + ( le.job_title_Invalid << 23 ) + ( le.secondary_name_title_Invalid << 24 ) + ( le.secondary_first_name_Invalid << 25 ) + ( le.secondary_middle_name_Invalid << 26 ) + ( le.secondary_name_suffix_Invalid << 27 ) + ( le.house_number_Invalid << 28 ) + ( le.pre_direction_Invalid << 29 ) + ( le.street_name_Invalid << 31 ) + ( le.street_type_Invalid << 32 ) + ( le.post_direction_Invalid << 33 ) + ( le.apt_type_Invalid << 35 ) + ( le.apt_number_Invalid << 36 ) + ( le.box_number_Invalid << 37 ) + ( le.expanded_pub_city_name_Invalid << 38 ) + ( le.postal_city_name_Invalid << 39 ) + ( le.state_Invalid << 40 ) + ( le.z5_Invalid << 42 ) + ( le.plus4_Invalid << 44 ) + ( le.delivery_point_code_Invalid << 46 ) + ( le.carrier_route_Invalid << 48 ) + ( le.county_code__Invalid << 50 ) + ( le.gnrl_address_return_code_Invalid << 52 ) + ( le.house_number_usage_flag_Invalid << 53 ) + ( le.pre_direction_usage_flag_Invalid << 55 ) + ( le.street_name_usage_flag_Invalid << 57 ) + ( le.street_type_usage_flag_Invalid << 59 ) + ( le.post_direction_usage_flag_Invalid << 61 );
    SELF.ScrubsBits2 := ( le.apt_number_usage_flag_Invalid << 0 ) + ( le.validation_date_Invalid << 2 ) + ( le.validation_flag_Invalid << 4 ) + ( le.dt_first_seen_Invalid << 6 ) + ( le.dt_last_seen_Invalid << 8 ) + ( le.dt_vendor_last_reported_Invalid << 10 ) + ( le.dt_vendor_first_reported_Invalid << 12 ) + ( le.rec_type_Invalid << 14 ) + ( le.fname_Invalid << 16 ) + ( le.minit_Invalid << 17 ) + ( le.lname_Invalid << 18 ) + ( le.name_suffix_Invalid << 19 ) + ( le.prim_range_Invalid << 20 ) + ( le.predir_Invalid << 21 ) + ( le.prim_name_Invalid << 23 ) + ( le.suffix_Invalid << 24 ) + ( le.postdir_Invalid << 25 ) + ( le.unit_desig_Invalid << 27 ) + ( le.sec_range_Invalid << 28 ) + ( le.city_name_Invalid << 29 ) + ( le.st_Invalid << 30 ) + ( le.zip_Invalid << 32 ) + ( le.zip4_Invalid << 34 ) + ( le.county_Invalid << 36 ) + ( le.cbsa_Invalid << 38 ) + ( le.geo_blk_Invalid << 40 ) + ( le.cleanname_Invalid << 42 ) + ( le.cleanaddress_Invalid << 43 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Layout_Targus);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.record_id_Invalid := (le.ScrubsBits1 >> 0) & 3;
    SELF.pubdate_Invalid := (le.ScrubsBits1 >> 2) & 3;
    SELF.yppa_code_Invalid := (le.ScrubsBits1 >> 4) & 3;
    SELF.book_code_Invalid := (le.ScrubsBits1 >> 6) & 3;
    SELF.page_number_Invalid := (le.ScrubsBits1 >> 8) & 3;
    SELF.record_number_Invalid := (le.ScrubsBits1 >> 10) & 3;
    SELF.phone_number_Invalid := (le.ScrubsBits1 >> 12) & 3;
    SELF.phone_type_Invalid := (le.ScrubsBits1 >> 14) & 3;
    SELF.record_type_Invalid := (le.ScrubsBits1 >> 16) & 1;
    SELF.no_solicitation_code_Invalid := (le.ScrubsBits1 >> 17) & 1;
    SELF.title_Invalid := (le.ScrubsBits1 >> 18) & 1;
    SELF.first_name_Invalid := (le.ScrubsBits1 >> 19) & 1;
    SELF.middle_name_Invalid := (le.ScrubsBits1 >> 20) & 1;
    SELF.last_name_Invalid := (le.ScrubsBits1 >> 21) & 1;
    SELF.last_name_suffix_Invalid := (le.ScrubsBits1 >> 22) & 1;
    SELF.job_title_Invalid := (le.ScrubsBits1 >> 23) & 1;
    SELF.secondary_name_title_Invalid := (le.ScrubsBits1 >> 24) & 1;
    SELF.secondary_first_name_Invalid := (le.ScrubsBits1 >> 25) & 1;
    SELF.secondary_middle_name_Invalid := (le.ScrubsBits1 >> 26) & 1;
    SELF.secondary_name_suffix_Invalid := (le.ScrubsBits1 >> 27) & 1;
    SELF.house_number_Invalid := (le.ScrubsBits1 >> 28) & 1;
    SELF.pre_direction_Invalid := (le.ScrubsBits1 >> 29) & 3;
    SELF.street_name_Invalid := (le.ScrubsBits1 >> 31) & 1;
    SELF.street_type_Invalid := (le.ScrubsBits1 >> 32) & 1;
    SELF.post_direction_Invalid := (le.ScrubsBits1 >> 33) & 3;
    SELF.apt_type_Invalid := (le.ScrubsBits1 >> 35) & 1;
    SELF.apt_number_Invalid := (le.ScrubsBits1 >> 36) & 1;
    SELF.box_number_Invalid := (le.ScrubsBits1 >> 37) & 1;
    SELF.expanded_pub_city_name_Invalid := (le.ScrubsBits1 >> 38) & 1;
    SELF.postal_city_name_Invalid := (le.ScrubsBits1 >> 39) & 1;
    SELF.state_Invalid := (le.ScrubsBits1 >> 40) & 3;
    SELF.z5_Invalid := (le.ScrubsBits1 >> 42) & 3;
    SELF.plus4_Invalid := (le.ScrubsBits1 >> 44) & 3;
    SELF.delivery_point_code_Invalid := (le.ScrubsBits1 >> 46) & 3;
    SELF.carrier_route_Invalid := (le.ScrubsBits1 >> 48) & 3;
    SELF.county_code__Invalid := (le.ScrubsBits1 >> 50) & 3;
    SELF.gnrl_address_return_code_Invalid := (le.ScrubsBits1 >> 52) & 1;
    SELF.house_number_usage_flag_Invalid := (le.ScrubsBits1 >> 53) & 3;
    SELF.pre_direction_usage_flag_Invalid := (le.ScrubsBits1 >> 55) & 3;
    SELF.street_name_usage_flag_Invalid := (le.ScrubsBits1 >> 57) & 3;
    SELF.street_type_usage_flag_Invalid := (le.ScrubsBits1 >> 59) & 3;
    SELF.post_direction_usage_flag_Invalid := (le.ScrubsBits1 >> 61) & 3;
    SELF.apt_number_usage_flag_Invalid := (le.ScrubsBits2 >> 0) & 3;
    SELF.validation_date_Invalid := (le.ScrubsBits2 >> 2) & 3;
    SELF.validation_flag_Invalid := (le.ScrubsBits2 >> 4) & 3;
    SELF.dt_first_seen_Invalid := (le.ScrubsBits2 >> 6) & 3;
    SELF.dt_last_seen_Invalid := (le.ScrubsBits2 >> 8) & 3;
    SELF.dt_vendor_last_reported_Invalid := (le.ScrubsBits2 >> 10) & 3;
    SELF.dt_vendor_first_reported_Invalid := (le.ScrubsBits2 >> 12) & 3;
    SELF.rec_type_Invalid := (le.ScrubsBits2 >> 14) & 3;
    SELF.fname_Invalid := (le.ScrubsBits2 >> 16) & 1;
    SELF.minit_Invalid := (le.ScrubsBits2 >> 17) & 1;
    SELF.lname_Invalid := (le.ScrubsBits2 >> 18) & 1;
    SELF.name_suffix_Invalid := (le.ScrubsBits2 >> 19) & 1;
    SELF.prim_range_Invalid := (le.ScrubsBits2 >> 20) & 1;
    SELF.predir_Invalid := (le.ScrubsBits2 >> 21) & 3;
    SELF.prim_name_Invalid := (le.ScrubsBits2 >> 23) & 1;
    SELF.suffix_Invalid := (le.ScrubsBits2 >> 24) & 1;
    SELF.postdir_Invalid := (le.ScrubsBits2 >> 25) & 3;
    SELF.unit_desig_Invalid := (le.ScrubsBits2 >> 27) & 1;
    SELF.sec_range_Invalid := (le.ScrubsBits2 >> 28) & 1;
    SELF.city_name_Invalid := (le.ScrubsBits2 >> 29) & 1;
    SELF.st_Invalid := (le.ScrubsBits2 >> 30) & 3;
    SELF.zip_Invalid := (le.ScrubsBits2 >> 32) & 3;
    SELF.zip4_Invalid := (le.ScrubsBits2 >> 34) & 3;
    SELF.county_Invalid := (le.ScrubsBits2 >> 36) & 3;
    SELF.cbsa_Invalid := (le.ScrubsBits2 >> 38) & 3;
    SELF.geo_blk_Invalid := (le.ScrubsBits2 >> 40) & 3;
    SELF.cleanname_Invalid := (le.ScrubsBits2 >> 42) & 1;
    SELF.cleanaddress_Invalid := (le.ScrubsBits2 >> 43) & 1;
    SELF.invalid_vendor_dates_Invalid := (le.ScrubsBits1 >> 44) & 3;
    SELF.invalid_seen_dates_Invalid := (le.ScrubsBits1 >> 46) & 3;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    record_id_ALLOW_ErrorCount := COUNT(GROUP,h.record_id_Invalid=1);
    record_id_LENGTH_ErrorCount := COUNT(GROUP,h.record_id_Invalid=2);
    record_id_Total_ErrorCount := COUNT(GROUP,h.record_id_Invalid>0);
    pubdate_ALLOW_ErrorCount := COUNT(GROUP,h.pubdate_Invalid=1);
    pubdate_LENGTH_ErrorCount := COUNT(GROUP,h.pubdate_Invalid=2);
    pubdate_Total_ErrorCount := COUNT(GROUP,h.pubdate_Invalid>0);
    yppa_code_ALLOW_ErrorCount := COUNT(GROUP,h.yppa_code_Invalid=1);
    yppa_code_LENGTH_ErrorCount := COUNT(GROUP,h.yppa_code_Invalid=2);
    yppa_code_Total_ErrorCount := COUNT(GROUP,h.yppa_code_Invalid>0);
    book_code_ALLOW_ErrorCount := COUNT(GROUP,h.book_code_Invalid=1);
    book_code_LENGTH_ErrorCount := COUNT(GROUP,h.book_code_Invalid=2);
    book_code_Total_ErrorCount := COUNT(GROUP,h.book_code_Invalid>0);
    page_number_ALLOW_ErrorCount := COUNT(GROUP,h.page_number_Invalid=1);
    page_number_LENGTH_ErrorCount := COUNT(GROUP,h.page_number_Invalid=2);
    page_number_Total_ErrorCount := COUNT(GROUP,h.page_number_Invalid>0);
    record_number_ALLOW_ErrorCount := COUNT(GROUP,h.record_number_Invalid=1);
    record_number_LENGTH_ErrorCount := COUNT(GROUP,h.record_number_Invalid=2);
    record_number_Total_ErrorCount := COUNT(GROUP,h.record_number_Invalid>0);
    phone_number_ALLOW_ErrorCount := COUNT(GROUP,h.phone_number_Invalid=1);
    phone_number_LENGTH_ErrorCount := COUNT(GROUP,h.phone_number_Invalid=2);
    phone_number_Total_ErrorCount := COUNT(GROUP,h.phone_number_Invalid>0);
    phone_type_ALLOW_ErrorCount := COUNT(GROUP,h.phone_type_Invalid=1);
    phone_type_LENGTH_ErrorCount := COUNT(GROUP,h.phone_type_Invalid=2);
    phone_type_Total_ErrorCount := COUNT(GROUP,h.phone_type_Invalid>0);
    record_type_ENUM_ErrorCount := COUNT(GROUP,h.record_type_Invalid=1);
    no_solicitation_code_ENUM_ErrorCount := COUNT(GROUP,h.no_solicitation_code_Invalid=1);
    title_ALLOW_ErrorCount := COUNT(GROUP,h.title_Invalid=1);
    first_name_ALLOW_ErrorCount := COUNT(GROUP,h.first_name_Invalid=1);
    middle_name_ALLOW_ErrorCount := COUNT(GROUP,h.middle_name_Invalid=1);
    last_name_ALLOW_ErrorCount := COUNT(GROUP,h.last_name_Invalid=1);
    last_name_suffix_ALLOW_ErrorCount := COUNT(GROUP,h.last_name_suffix_Invalid=1);
    job_title_ALLOW_ErrorCount := COUNT(GROUP,h.job_title_Invalid=1);
    secondary_name_title_ALLOW_ErrorCount := COUNT(GROUP,h.secondary_name_title_Invalid=1);
    secondary_first_name_ALLOW_ErrorCount := COUNT(GROUP,h.secondary_first_name_Invalid=1);
    secondary_middle_name_ALLOW_ErrorCount := COUNT(GROUP,h.secondary_middle_name_Invalid=1);
    secondary_name_suffix_ALLOW_ErrorCount := COUNT(GROUP,h.secondary_name_suffix_Invalid=1);
    house_number_ALLOW_ErrorCount := COUNT(GROUP,h.house_number_Invalid=1);
    pre_direction_ALLOW_ErrorCount := COUNT(GROUP,h.pre_direction_Invalid=1);
    pre_direction_LENGTH_ErrorCount := COUNT(GROUP,h.pre_direction_Invalid=2);
    pre_direction_Total_ErrorCount := COUNT(GROUP,h.pre_direction_Invalid>0);
    street_name_ALLOW_ErrorCount := COUNT(GROUP,h.street_name_Invalid=1);
    street_type_ALLOW_ErrorCount := COUNT(GROUP,h.street_type_Invalid=1);
    post_direction_ALLOW_ErrorCount := COUNT(GROUP,h.post_direction_Invalid=1);
    post_direction_LENGTH_ErrorCount := COUNT(GROUP,h.post_direction_Invalid=2);
    post_direction_Total_ErrorCount := COUNT(GROUP,h.post_direction_Invalid>0);
    apt_type_ALLOW_ErrorCount := COUNT(GROUP,h.apt_type_Invalid=1);
    apt_number_ALLOW_ErrorCount := COUNT(GROUP,h.apt_number_Invalid=1);
    box_number_ALLOW_ErrorCount := COUNT(GROUP,h.box_number_Invalid=1);
    expanded_pub_city_name_ALLOW_ErrorCount := COUNT(GROUP,h.expanded_pub_city_name_Invalid=1);
    postal_city_name_ALLOW_ErrorCount := COUNT(GROUP,h.postal_city_name_Invalid=1);
    state_ALLOW_ErrorCount := COUNT(GROUP,h.state_Invalid=1);
    state_LENGTH_ErrorCount := COUNT(GROUP,h.state_Invalid=2);
    state_Total_ErrorCount := COUNT(GROUP,h.state_Invalid>0);
    z5_ALLOW_ErrorCount := COUNT(GROUP,h.z5_Invalid=1);
    z5_LENGTH_ErrorCount := COUNT(GROUP,h.z5_Invalid=2);
    z5_Total_ErrorCount := COUNT(GROUP,h.z5_Invalid>0);
    plus4_ALLOW_ErrorCount := COUNT(GROUP,h.plus4_Invalid=1);
    plus4_LENGTH_ErrorCount := COUNT(GROUP,h.plus4_Invalid=2);
    plus4_Total_ErrorCount := COUNT(GROUP,h.plus4_Invalid>0);
    delivery_point_code_ALLOW_ErrorCount := COUNT(GROUP,h.delivery_point_code_Invalid=1);
    delivery_point_code_LENGTH_ErrorCount := COUNT(GROUP,h.delivery_point_code_Invalid=2);
    delivery_point_code_Total_ErrorCount := COUNT(GROUP,h.delivery_point_code_Invalid>0);
    carrier_route_ALLOW_ErrorCount := COUNT(GROUP,h.carrier_route_Invalid=1);
    carrier_route_LENGTH_ErrorCount := COUNT(GROUP,h.carrier_route_Invalid=2);
    carrier_route_Total_ErrorCount := COUNT(GROUP,h.carrier_route_Invalid>0);
    county_code__ALLOW_ErrorCount := COUNT(GROUP,h.county_code__Invalid=1);
    county_code__LENGTH_ErrorCount := COUNT(GROUP,h.county_code__Invalid=2);
    county_code__Total_ErrorCount := COUNT(GROUP,h.county_code__Invalid>0);
    gnrl_address_return_code_LENGTH_ErrorCount := COUNT(GROUP,h.gnrl_address_return_code_Invalid=1);
    house_number_usage_flag_ALLOW_ErrorCount := COUNT(GROUP,h.house_number_usage_flag_Invalid=1);
    house_number_usage_flag_LENGTH_ErrorCount := COUNT(GROUP,h.house_number_usage_flag_Invalid=2);
    house_number_usage_flag_Total_ErrorCount := COUNT(GROUP,h.house_number_usage_flag_Invalid>0);
    pre_direction_usage_flag_ALLOW_ErrorCount := COUNT(GROUP,h.pre_direction_usage_flag_Invalid=1);
    pre_direction_usage_flag_LENGTH_ErrorCount := COUNT(GROUP,h.pre_direction_usage_flag_Invalid=2);
    pre_direction_usage_flag_Total_ErrorCount := COUNT(GROUP,h.pre_direction_usage_flag_Invalid>0);
    street_name_usage_flag_ALLOW_ErrorCount := COUNT(GROUP,h.street_name_usage_flag_Invalid=1);
    street_name_usage_flag_LENGTH_ErrorCount := COUNT(GROUP,h.street_name_usage_flag_Invalid=2);
    street_name_usage_flag_Total_ErrorCount := COUNT(GROUP,h.street_name_usage_flag_Invalid>0);
    street_type_usage_flag_ALLOW_ErrorCount := COUNT(GROUP,h.street_type_usage_flag_Invalid=1);
    street_type_usage_flag_LENGTH_ErrorCount := COUNT(GROUP,h.street_type_usage_flag_Invalid=2);
    street_type_usage_flag_Total_ErrorCount := COUNT(GROUP,h.street_type_usage_flag_Invalid>0);
    post_direction_usage_flag_ALLOW_ErrorCount := COUNT(GROUP,h.post_direction_usage_flag_Invalid=1);
    post_direction_usage_flag_LENGTH_ErrorCount := COUNT(GROUP,h.post_direction_usage_flag_Invalid=2);
    post_direction_usage_flag_Total_ErrorCount := COUNT(GROUP,h.post_direction_usage_flag_Invalid>0);
    apt_number_usage_flag_ALLOW_ErrorCount := COUNT(GROUP,h.apt_number_usage_flag_Invalid=1);
    apt_number_usage_flag_LENGTH_ErrorCount := COUNT(GROUP,h.apt_number_usage_flag_Invalid=2);
    apt_number_usage_flag_Total_ErrorCount := COUNT(GROUP,h.apt_number_usage_flag_Invalid>0);
    validation_date_ALLOW_ErrorCount := COUNT(GROUP,h.validation_date_Invalid=1);
    validation_date_LENGTH_ErrorCount := COUNT(GROUP,h.validation_date_Invalid=2);
    validation_date_Total_ErrorCount := COUNT(GROUP,h.validation_date_Invalid>0);
    validation_flag_ALLOW_ErrorCount := COUNT(GROUP,h.validation_flag_Invalid=1);
    validation_flag_LENGTH_ErrorCount := COUNT(GROUP,h.validation_flag_Invalid=2);
    validation_flag_Total_ErrorCount := COUNT(GROUP,h.validation_flag_Invalid>0);
    dt_first_seen_ALLOW_ErrorCount := COUNT(GROUP,h.dt_first_seen_Invalid=1);
    dt_first_seen_LENGTH_ErrorCount := COUNT(GROUP,h.dt_first_seen_Invalid=2);
    dt_first_seen_Total_ErrorCount := COUNT(GROUP,h.dt_first_seen_Invalid>0);
    dt_last_seen_ALLOW_ErrorCount := COUNT(GROUP,h.dt_last_seen_Invalid=1);
    dt_last_seen_LENGTH_ErrorCount := COUNT(GROUP,h.dt_last_seen_Invalid=2);
    dt_last_seen_Total_ErrorCount := COUNT(GROUP,h.dt_last_seen_Invalid>0);
    dt_vendor_last_reported_ALLOW_ErrorCount := COUNT(GROUP,h.dt_vendor_last_reported_Invalid=1);
    dt_vendor_last_reported_LENGTH_ErrorCount := COUNT(GROUP,h.dt_vendor_last_reported_Invalid=2);
    dt_vendor_last_reported_Total_ErrorCount := COUNT(GROUP,h.dt_vendor_last_reported_Invalid>0);
    dt_vendor_first_reported_ALLOW_ErrorCount := COUNT(GROUP,h.dt_vendor_first_reported_Invalid=1);
    dt_vendor_first_reported_LENGTH_ErrorCount := COUNT(GROUP,h.dt_vendor_first_reported_Invalid=2);
    dt_vendor_first_reported_Total_ErrorCount := COUNT(GROUP,h.dt_vendor_first_reported_Invalid>0);
    rec_type_ALLOW_ErrorCount := COUNT(GROUP,h.rec_type_Invalid=1);
    rec_type_LENGTH_ErrorCount := COUNT(GROUP,h.rec_type_Invalid=2);
    rec_type_Total_ErrorCount := COUNT(GROUP,h.rec_type_Invalid>0);
    fname_ALLOW_ErrorCount := COUNT(GROUP,h.fname_Invalid=1);
    minit_ALLOW_ErrorCount := COUNT(GROUP,h.minit_Invalid=1);
    lname_ALLOW_ErrorCount := COUNT(GROUP,h.lname_Invalid=1);
    name_suffix_ALLOW_ErrorCount := COUNT(GROUP,h.name_suffix_Invalid=1);
    prim_range_ALLOW_ErrorCount := COUNT(GROUP,h.prim_range_Invalid=1);
    predir_ALLOW_ErrorCount := COUNT(GROUP,h.predir_Invalid=1);
    predir_LENGTH_ErrorCount := COUNT(GROUP,h.predir_Invalid=2);
    predir_Total_ErrorCount := COUNT(GROUP,h.predir_Invalid>0);
    prim_name_ALLOW_ErrorCount := COUNT(GROUP,h.prim_name_Invalid=1);
    suffix_ALLOW_ErrorCount := COUNT(GROUP,h.suffix_Invalid=1);
    postdir_ALLOW_ErrorCount := COUNT(GROUP,h.postdir_Invalid=1);
    postdir_LENGTH_ErrorCount := COUNT(GROUP,h.postdir_Invalid=2);
    postdir_Total_ErrorCount := COUNT(GROUP,h.postdir_Invalid>0);
    unit_desig_ALLOW_ErrorCount := COUNT(GROUP,h.unit_desig_Invalid=1);
    sec_range_ALLOW_ErrorCount := COUNT(GROUP,h.sec_range_Invalid=1);
    city_name_ALLOW_ErrorCount := COUNT(GROUP,h.city_name_Invalid=1);
    st_ALLOW_ErrorCount := COUNT(GROUP,h.st_Invalid=1);
    st_LENGTH_ErrorCount := COUNT(GROUP,h.st_Invalid=2);
    st_Total_ErrorCount := COUNT(GROUP,h.st_Invalid>0);
    zip_ALLOW_ErrorCount := COUNT(GROUP,h.zip_Invalid=1);
    zip_LENGTH_ErrorCount := COUNT(GROUP,h.zip_Invalid=2);
    zip_Total_ErrorCount := COUNT(GROUP,h.zip_Invalid>0);
    zip4_ALLOW_ErrorCount := COUNT(GROUP,h.zip4_Invalid=1);
    zip4_LENGTH_ErrorCount := COUNT(GROUP,h.zip4_Invalid=2);
    zip4_Total_ErrorCount := COUNT(GROUP,h.zip4_Invalid>0);
    county_ALLOW_ErrorCount := COUNT(GROUP,h.county_Invalid=1);
    county_LENGTH_ErrorCount := COUNT(GROUP,h.county_Invalid=2);
    county_Total_ErrorCount := COUNT(GROUP,h.county_Invalid>0);
    cbsa_ALLOW_ErrorCount := COUNT(GROUP,h.cbsa_Invalid=1);
    cbsa_LENGTH_ErrorCount := COUNT(GROUP,h.cbsa_Invalid=2);
    cbsa_Total_ErrorCount := COUNT(GROUP,h.cbsa_Invalid>0);
    geo_blk_ALLOW_ErrorCount := COUNT(GROUP,h.geo_blk_Invalid=1);
    geo_blk_LENGTH_ErrorCount := COUNT(GROUP,h.geo_blk_Invalid=2);
    geo_blk_Total_ErrorCount := COUNT(GROUP,h.geo_blk_Invalid>0);
    cleanname_ALLOW_ErrorCount := COUNT(GROUP,h.cleanname_Invalid=1);
    cleanaddress_ALLOW_ErrorCount := COUNT(GROUP,h.cleanaddress_Invalid=1);
    invalid_vendor_dates_dt_vendor_first_reported_Invalid_ErrorCount := COUNT(GROUP,h.invalid_vendor_dates_Invalid=1);
    invalid_vendor_dates_dt_vendor_last_reported_Invalid_ErrorCount := COUNT(GROUP,h.invalid_vendor_dates_Invalid=2);
    invalid_vendor_dates_dt_vendor_first_reported_dt_vendor_last_reported_Cnd_Invalid_ErrorCount := COUNT(GROUP,h.invalid_vendor_dates_Invalid=3);
    invalid_vendor_dates_Total_ErrorCount := COUNT(GROUP,h.invalid_vendor_dates_Invalid>0);
    invalid_seen_dates_dt_first_seen_Invalid_ErrorCount := COUNT(GROUP,h.invalid_seen_dates_Invalid=1);
    invalid_seen_dates_dt_last_seen_Invalid_ErrorCount := COUNT(GROUP,h.invalid_seen_dates_Invalid=2);
    invalid_seen_dates_dt_first_seen_dt_last_seen_Condition_Invalid_ErrorCount := COUNT(GROUP,h.invalid_seen_dates_Invalid=3);
    invalid_seen_dates_Total_ErrorCount := COUNT(GROUP,h.invalid_seen_dates_Invalid>0);
  END;
  EXPORT SummaryStats := TABLE(h,r);
  r := RECORD
    STRING10 Src;
    STRING FieldName;
    STRING FieldType;
    STRING ErrorType;
    SALT30.StrType ErrorMessage;
    SALT30.StrType FieldContents;
  END;
  r into(h le,UNSIGNED c) := TRANSFORM
    SELF.Src :=  ''; // Source not provided
    UNSIGNED1 ErrNum := CHOOSE(c,le.record_id_Invalid,le.pubdate_Invalid,le.yppa_code_Invalid,le.book_code_Invalid,le.page_number_Invalid,le.record_number_Invalid,le.phone_number_Invalid,le.phone_type_Invalid,le.record_type_Invalid,le.no_solicitation_code_Invalid,le.title_Invalid,le.first_name_Invalid,le.middle_name_Invalid,le.last_name_Invalid,le.last_name_suffix_Invalid,le.job_title_Invalid,le.secondary_name_title_Invalid,le.secondary_first_name_Invalid,le.secondary_middle_name_Invalid,le.secondary_name_suffix_Invalid,le.house_number_Invalid,le.pre_direction_Invalid,le.street_name_Invalid,le.street_type_Invalid,le.post_direction_Invalid,le.apt_type_Invalid,le.apt_number_Invalid,le.box_number_Invalid,le.expanded_pub_city_name_Invalid,le.postal_city_name_Invalid,le.state_Invalid,le.z5_Invalid,le.plus4_Invalid,le.delivery_point_code_Invalid,le.carrier_route_Invalid,le.county_code__Invalid,le.gnrl_address_return_code_Invalid,le.house_number_usage_flag_Invalid,le.pre_direction_usage_flag_Invalid,le.street_name_usage_flag_Invalid,le.street_type_usage_flag_Invalid,le.post_direction_usage_flag_Invalid,le.apt_number_usage_flag_Invalid,le.validation_date_Invalid,le.validation_flag_Invalid,le.dt_first_seen_Invalid,le.dt_last_seen_Invalid,le.dt_vendor_last_reported_Invalid,le.dt_vendor_first_reported_Invalid,le.rec_type_Invalid,le.fname_Invalid,le.minit_Invalid,le.lname_Invalid,le.name_suffix_Invalid,le.prim_range_Invalid,le.predir_Invalid,le.prim_name_Invalid,le.suffix_Invalid,le.postdir_Invalid,le.unit_desig_Invalid,le.sec_range_Invalid,le.city_name_Invalid,le.st_Invalid,le.zip_Invalid,le.zip4_Invalid,le.county_Invalid,le.cbsa_Invalid,le.geo_blk_Invalid,le.cleanname_Invalid,le.cleanaddress_Invalid,le.invalid_vendor_dates_Invalid,le.invalid_seen_dates_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Fields.InvalidMessage_record_id(le.record_id_Invalid),Fields.InvalidMessage_pubdate(le.pubdate_Invalid),Fields.InvalidMessage_yppa_code(le.yppa_code_Invalid),Fields.InvalidMessage_book_code(le.book_code_Invalid),Fields.InvalidMessage_page_number(le.page_number_Invalid),Fields.InvalidMessage_record_number(le.record_number_Invalid),Fields.InvalidMessage_phone_number(le.phone_number_Invalid),Fields.InvalidMessage_phone_type(le.phone_type_Invalid),Fields.InvalidMessage_record_type(le.record_type_Invalid),Fields.InvalidMessage_no_solicitation_code(le.no_solicitation_code_Invalid),Fields.InvalidMessage_title(le.title_Invalid),Fields.InvalidMessage_first_name(le.first_name_Invalid),Fields.InvalidMessage_middle_name(le.middle_name_Invalid),Fields.InvalidMessage_last_name(le.last_name_Invalid),Fields.InvalidMessage_last_name_suffix(le.last_name_suffix_Invalid),Fields.InvalidMessage_job_title(le.job_title_Invalid),Fields.InvalidMessage_secondary_name_title(le.secondary_name_title_Invalid),Fields.InvalidMessage_secondary_first_name(le.secondary_first_name_Invalid),Fields.InvalidMessage_secondary_middle_name(le.secondary_middle_name_Invalid),Fields.InvalidMessage_secondary_name_suffix(le.secondary_name_suffix_Invalid),Fields.InvalidMessage_house_number(le.house_number_Invalid),Fields.InvalidMessage_pre_direction(le.pre_direction_Invalid),Fields.InvalidMessage_street_name(le.street_name_Invalid),Fields.InvalidMessage_street_type(le.street_type_Invalid),Fields.InvalidMessage_post_direction(le.post_direction_Invalid),Fields.InvalidMessage_apt_type(le.apt_type_Invalid),Fields.InvalidMessage_apt_number(le.apt_number_Invalid),Fields.InvalidMessage_box_number(le.box_number_Invalid),Fields.InvalidMessage_expanded_pub_city_name(le.expanded_pub_city_name_Invalid),Fields.InvalidMessage_postal_city_name(le.postal_city_name_Invalid),Fields.InvalidMessage_state(le.state_Invalid),Fields.InvalidMessage_z5(le.z5_Invalid),Fields.InvalidMessage_plus4(le.plus4_Invalid),Fields.InvalidMessage_delivery_point_code(le.delivery_point_code_Invalid),Fields.InvalidMessage_carrier_route(le.carrier_route_Invalid),Fields.InvalidMessage_county_code_(le.county_code__Invalid),Fields.InvalidMessage_gnrl_address_return_code(le.gnrl_address_return_code_Invalid),Fields.InvalidMessage_house_number_usage_flag(le.house_number_usage_flag_Invalid),Fields.InvalidMessage_pre_direction_usage_flag(le.pre_direction_usage_flag_Invalid),Fields.InvalidMessage_street_name_usage_flag(le.street_name_usage_flag_Invalid),Fields.InvalidMessage_street_type_usage_flag(le.street_type_usage_flag_Invalid),Fields.InvalidMessage_post_direction_usage_flag(le.post_direction_usage_flag_Invalid),Fields.InvalidMessage_apt_number_usage_flag(le.apt_number_usage_flag_Invalid),Fields.InvalidMessage_validation_date(le.validation_date_Invalid),Fields.InvalidMessage_validation_flag(le.validation_flag_Invalid),Fields.InvalidMessage_dt_first_seen(le.dt_first_seen_Invalid),Fields.InvalidMessage_dt_last_seen(le.dt_last_seen_Invalid),Fields.InvalidMessage_dt_vendor_last_reported(le.dt_vendor_last_reported_Invalid),Fields.InvalidMessage_dt_vendor_first_reported(le.dt_vendor_first_reported_Invalid),Fields.InvalidMessage_rec_type(le.rec_type_Invalid),Fields.InvalidMessage_fname(le.fname_Invalid),Fields.InvalidMessage_minit(le.minit_Invalid),Fields.InvalidMessage_lname(le.lname_Invalid),Fields.InvalidMessage_name_suffix(le.name_suffix_Invalid),Fields.InvalidMessage_prim_range(le.prim_range_Invalid),Fields.InvalidMessage_predir(le.predir_Invalid),Fields.InvalidMessage_prim_name(le.prim_name_Invalid),Fields.InvalidMessage_suffix(le.suffix_Invalid),Fields.InvalidMessage_postdir(le.postdir_Invalid),Fields.InvalidMessage_unit_desig(le.unit_desig_Invalid),Fields.InvalidMessage_sec_range(le.sec_range_Invalid),Fields.InvalidMessage_city_name(le.city_name_Invalid),Fields.InvalidMessage_st(le.st_Invalid),Fields.InvalidMessage_zip(le.zip_Invalid),Fields.InvalidMessage_zip4(le.zip4_Invalid),Fields.InvalidMessage_county(le.county_Invalid),Fields.InvalidMessage_cbsa(le.cbsa_Invalid),Fields.InvalidMessage_geo_blk(le.geo_blk_Invalid),Fields.InvalidMessage_cleanname(le.cleanname_Invalid),Fields.InvalidMessage_cleanaddress(le.cleanaddress_Invalid),InvalidMessage_invalid_vendor_dates(le.invalid_vendor_dates_Invalid),InvalidMessage_invalid_seen_dates(le.invalid_seen_dates_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.record_id_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.pubdate_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.yppa_code_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.book_code_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.page_number_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.record_number_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.phone_number_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.phone_type_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.record_type_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.no_solicitation_code_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.title_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.first_name_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.middle_name_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.last_name_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.last_name_suffix_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.job_title_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.secondary_name_title_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.secondary_first_name_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.secondary_middle_name_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.secondary_name_suffix_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.house_number_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.pre_direction_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.street_name_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.street_type_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.post_direction_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.apt_type_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.apt_number_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.box_number_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.expanded_pub_city_name_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.postal_city_name_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.state_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.z5_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.plus4_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.delivery_point_code_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.carrier_route_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.county_code__Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.gnrl_address_return_code_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.house_number_usage_flag_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.pre_direction_usage_flag_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.street_name_usage_flag_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.street_type_usage_flag_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.post_direction_usage_flag_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.apt_number_usage_flag_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.validation_date_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.validation_flag_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.dt_first_seen_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.dt_last_seen_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.dt_vendor_last_reported_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.dt_vendor_first_reported_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.rec_type_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.fname_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.minit_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.lname_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.name_suffix_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.prim_range_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.predir_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.prim_name_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.suffix_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.postdir_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.unit_desig_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.sec_range_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.city_name_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.st_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.zip_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.zip4_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.county_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.cbsa_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.geo_blk_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.cleanname_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cleanaddress_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.invalid_vendor_dates_Invalid,'dt_vendor_first_reported_Invalid','dt_vendor_last_reported_Invalid','dt_vendor_first_reported_dt_vendor_last_reported_Cnd_Invalid','UNKNOWN')
          ,CHOOSE(le.invalid_seen_dates_Invalid,'dt_first_seen_Invalid','dt_last_seen_Invalid','dt_first_seen_dt_last_seen_Condition_Invalid','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'record_id','pubdate','yppa_code','book_code','page_number','record_number','phone_number','phone_type','record_type','no_solicitation_code','title','first_name','middle_name','last_name','last_name_suffix','job_title','secondary_name_title','secondary_first_name','secondary_middle_name','secondary_name_suffix','house_number','pre_direction','street_name','street_type','post_direction','apt_type','apt_number','box_number','expanded_pub_city_name','postal_city_name','state','z5','plus4','delivery_point_code','carrier_route','county_code_','gnrl_address_return_code','house_number_usage_flag','pre_direction_usage_flag','street_name_usage_flag','street_type_usage_flag','post_direction_usage_flag','apt_number_usage_flag','validation_date','validation_flag','dt_first_seen','dt_last_seen','dt_vendor_last_reported','dt_vendor_first_reported','rec_type','fname','minit','lname','name_suffix','prim_range','predir','prim_name','suffix','postdir','unit_desig','sec_range','city_name','st','zip','zip4','county','cbsa','geo_blk','cleanname','cleanaddress','invalid_vendor_dates','invalid_seen_dates','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_record_id','invalid_pubdate','invalid_yppa_code','invalid_book_code','invalid_page_number','invalid_record_number','invalid_phone_number','invalid_phone_type','invalid_record_type','invalid_no_solicitation_code','invalid_name','invalid_raw_name','invalid_raw_name','invalid_raw_name','invalid_raw_name','invalid_job_title','invalid_raw_name','invalid_raw_name','invalid_raw_name','invalid_raw_name','invalid_house_number','invalid_predir','invalid_street_name','invalid_street_type','invalid_predir','invalid_apt_type','invalid_apt_number','invalid_box_number','invalid_postal_city_name','invalid_postal_city_name','invalid_st','invalid_zip','invalid_zip4','invalid_delivery_point_code','invalid_carrier_route','invalid_county_code_','invalid_gnrl_address_return_code','invalid_address_flag','invalid_address_flag','invalid_address_flag','invalid_address_flag','invalid_address_flag','invalid_address_flag','invalid_longdate','invalid_validation_flag','invalid_shortdate','invalid_shortdate','invalid_shortdate','invalid_shortdate','invalid_rec_type','invalid_name','invalid_name','invalid_name','invalid_name','invalid_prim_range','invalid_predir','invalid_prim_name','invalid_suffix','invalid_postdir','invalid_unit_desig','invalid_sec_range','invalid_city_name','invalid_st','invalid_zip','invalid_zip4','invalid_county','invalid_cbsa','invalid_geo_blk','invalid_raw_name','invalid_cleanaddress','RECORDTYPE','RECORDTYPE','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT30.StrType)le.record_id,(SALT30.StrType)le.pubdate,(SALT30.StrType)le.yppa_code,(SALT30.StrType)le.book_code,(SALT30.StrType)le.page_number,(SALT30.StrType)le.record_number,(SALT30.StrType)le.phone_number,(SALT30.StrType)le.phone_type,(SALT30.StrType)le.record_type,(SALT30.StrType)le.no_solicitation_code,(SALT30.StrType)le.title,(SALT30.StrType)le.first_name,(SALT30.StrType)le.middle_name,(SALT30.StrType)le.last_name,(SALT30.StrType)le.last_name_suffix,(SALT30.StrType)le.job_title,(SALT30.StrType)le.secondary_name_title,(SALT30.StrType)le.secondary_first_name,(SALT30.StrType)le.secondary_middle_name,(SALT30.StrType)le.secondary_name_suffix,(SALT30.StrType)le.house_number,(SALT30.StrType)le.pre_direction,(SALT30.StrType)le.street_name,(SALT30.StrType)le.street_type,(SALT30.StrType)le.post_direction,(SALT30.StrType)le.apt_type,(SALT30.StrType)le.apt_number,(SALT30.StrType)le.box_number,(SALT30.StrType)le.expanded_pub_city_name,(SALT30.StrType)le.postal_city_name,(SALT30.StrType)le.state,(SALT30.StrType)le.z5,(SALT30.StrType)le.plus4,(SALT30.StrType)le.delivery_point_code,(SALT30.StrType)le.carrier_route,(SALT30.StrType)le.county_code_,(SALT30.StrType)le.gnrl_address_return_code,(SALT30.StrType)le.house_number_usage_flag,(SALT30.StrType)le.pre_direction_usage_flag,(SALT30.StrType)le.street_name_usage_flag,(SALT30.StrType)le.street_type_usage_flag,(SALT30.StrType)le.post_direction_usage_flag,(SALT30.StrType)le.apt_number_usage_flag,(SALT30.StrType)le.validation_date,(SALT30.StrType)le.validation_flag,(SALT30.StrType)le.dt_first_seen,(SALT30.StrType)le.dt_last_seen,(SALT30.StrType)le.dt_vendor_last_reported,(SALT30.StrType)le.dt_vendor_first_reported,(SALT30.StrType)le.rec_type,(SALT30.StrType)le.fname,(SALT30.StrType)le.minit,(SALT30.StrType)le.lname,(SALT30.StrType)le.name_suffix,(SALT30.StrType)le.prim_range,(SALT30.StrType)le.predir,(SALT30.StrType)le.prim_name,(SALT30.StrType)le.suffix,(SALT30.StrType)le.postdir,(SALT30.StrType)le.unit_desig,(SALT30.StrType)le.sec_range,(SALT30.StrType)le.city_name,(SALT30.StrType)le.st,(SALT30.StrType)le.zip,(SALT30.StrType)le.zip4,(SALT30.StrType)le.county,(SALT30.StrType)le.cbsa,(SALT30.StrType)le.geo_blk,(SALT30.StrType)le.cleanname,(SALT30.StrType)le.cleanaddress,(SALT30.StrType)le.dt_vendor_first_reported+':'+(SALT30.StrType)le.dt_vendor_last_reported+':'+(SALT30.StrType)le.dt_vendor_first_reported+'<='+(SALT30.StrType)le.dt_vendor_last_reported,(SALT30.StrType)le.dt_first_seen+':'+(SALT30.StrType)le.dt_last_seen+':'+(SALT30.StrType)le.dt_first_seen+'<='+(SALT30.StrType)le.dt_last_seen,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,72,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10,UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(),STRING10 Src='UNK') := FUNCTION
    SALT30.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'record_id:invalid_record_id:ALLOW','record_id:invalid_record_id:LENGTH'
          ,'pubdate:invalid_pubdate:ALLOW','pubdate:invalid_pubdate:LENGTH'
          ,'yppa_code:invalid_yppa_code:ALLOW','yppa_code:invalid_yppa_code:LENGTH'
          ,'book_code:invalid_book_code:ALLOW','book_code:invalid_book_code:LENGTH'
          ,'page_number:invalid_page_number:ALLOW','page_number:invalid_page_number:LENGTH'
          ,'record_number:invalid_record_number:ALLOW','record_number:invalid_record_number:LENGTH'
          ,'phone_number:invalid_phone_number:ALLOW','phone_number:invalid_phone_number:LENGTH'
          ,'phone_type:invalid_phone_type:ALLOW','phone_type:invalid_phone_type:LENGTH'
          ,'record_type:invalid_record_type:ENUM'
          ,'no_solicitation_code:invalid_no_solicitation_code:ENUM'
          ,'title:invalid_name:ALLOW'
          ,'first_name:invalid_raw_name:ALLOW'
          ,'middle_name:invalid_raw_name:ALLOW'
          ,'last_name:invalid_raw_name:ALLOW'
          ,'last_name_suffix:invalid_raw_name:ALLOW'
          ,'job_title:invalid_job_title:ALLOW'
          ,'secondary_name_title:invalid_raw_name:ALLOW'
          ,'secondary_first_name:invalid_raw_name:ALLOW'
          ,'secondary_middle_name:invalid_raw_name:ALLOW'
          ,'secondary_name_suffix:invalid_raw_name:ALLOW'
          ,'house_number:invalid_house_number:ALLOW'
          ,'pre_direction:invalid_predir:ALLOW','pre_direction:invalid_predir:LENGTH'
          ,'street_name:invalid_street_name:ALLOW'
          ,'street_type:invalid_street_type:ALLOW'
          ,'post_direction:invalid_predir:ALLOW','post_direction:invalid_predir:LENGTH'
          ,'apt_type:invalid_apt_type:ALLOW'
          ,'apt_number:invalid_apt_number:ALLOW'
          ,'box_number:invalid_box_number:ALLOW'
          ,'expanded_pub_city_name:invalid_postal_city_name:ALLOW'
          ,'postal_city_name:invalid_postal_city_name:ALLOW'
          ,'state:invalid_st:ALLOW','state:invalid_st:LENGTH'
          ,'z5:invalid_zip:ALLOW','z5:invalid_zip:LENGTH'
          ,'plus4:invalid_zip4:ALLOW','plus4:invalid_zip4:LENGTH'
          ,'delivery_point_code:invalid_delivery_point_code:ALLOW','delivery_point_code:invalid_delivery_point_code:LENGTH'
          ,'carrier_route:invalid_carrier_route:ALLOW','carrier_route:invalid_carrier_route:LENGTH'
          ,'county_code_:invalid_county_code_:ALLOW','county_code_:invalid_county_code_:LENGTH'
          ,'gnrl_address_return_code:invalid_gnrl_address_return_code:LENGTH'
          ,'house_number_usage_flag:invalid_address_flag:ALLOW','house_number_usage_flag:invalid_address_flag:LENGTH'
          ,'pre_direction_usage_flag:invalid_address_flag:ALLOW','pre_direction_usage_flag:invalid_address_flag:LENGTH'
          ,'street_name_usage_flag:invalid_address_flag:ALLOW','street_name_usage_flag:invalid_address_flag:LENGTH'
          ,'street_type_usage_flag:invalid_address_flag:ALLOW','street_type_usage_flag:invalid_address_flag:LENGTH'
          ,'post_direction_usage_flag:invalid_address_flag:ALLOW','post_direction_usage_flag:invalid_address_flag:LENGTH'
          ,'apt_number_usage_flag:invalid_address_flag:ALLOW','apt_number_usage_flag:invalid_address_flag:LENGTH'
          ,'validation_date:invalid_longdate:ALLOW','validation_date:invalid_longdate:LENGTH'
          ,'validation_flag:invalid_validation_flag:ALLOW','validation_flag:invalid_validation_flag:LENGTH'
          ,'dt_first_seen:invalid_shortdate:ALLOW','dt_first_seen:invalid_shortdate:LENGTH'
          ,'dt_last_seen:invalid_shortdate:ALLOW','dt_last_seen:invalid_shortdate:LENGTH'
          ,'dt_vendor_last_reported:invalid_shortdate:ALLOW','dt_vendor_last_reported:invalid_shortdate:LENGTH'
          ,'dt_vendor_first_reported:invalid_shortdate:ALLOW','dt_vendor_first_reported:invalid_shortdate:LENGTH'
          ,'rec_type:invalid_rec_type:ALLOW','rec_type:invalid_rec_type:LENGTH'
          ,'fname:invalid_name:ALLOW'
          ,'minit:invalid_name:ALLOW'
          ,'lname:invalid_name:ALLOW'
          ,'name_suffix:invalid_name:ALLOW'
          ,'prim_range:invalid_prim_range:ALLOW'
          ,'predir:invalid_predir:ALLOW','predir:invalid_predir:LENGTH'
          ,'prim_name:invalid_prim_name:ALLOW'
          ,'suffix:invalid_suffix:ALLOW'
          ,'postdir:invalid_postdir:ALLOW','postdir:invalid_postdir:LENGTH'
          ,'unit_desig:invalid_unit_desig:ALLOW'
          ,'sec_range:invalid_sec_range:ALLOW'
          ,'city_name:invalid_city_name:ALLOW'
          ,'st:invalid_st:ALLOW','st:invalid_st:LENGTH'
          ,'zip:invalid_zip:ALLOW','zip:invalid_zip:LENGTH'
          ,'zip4:invalid_zip4:ALLOW','zip4:invalid_zip4:LENGTH'
          ,'county:invalid_county:ALLOW','county:invalid_county:LENGTH'
          ,'cbsa:invalid_cbsa:ALLOW','cbsa:invalid_cbsa:LENGTH'
          ,'geo_blk:invalid_geo_blk:ALLOW','geo_blk:invalid_geo_blk:LENGTH'
          ,'cleanname:invalid_raw_name:ALLOW'
          ,'cleanaddress:invalid_cleanaddress:ALLOW'
          ,'invalid_vendor_dates:RECORDTYPE:dt_vendor_first_reported_Invalid','invalid_vendor_dates:RECORDTYPE:dt_vendor_last_reported_Invalid','invalid_vendor_dates:RECORDTYPE:dt_vendor_first_reported_dt_vendor_last_reported_Cnd_Invalid'
          ,'invalid_seen_dates:RECORDTYPE:dt_first_seen_Invalid','invalid_seen_dates:RECORDTYPE:dt_last_seen_Invalid','invalid_seen_dates:RECORDTYPE:dt_first_seen_dt_last_seen_Condition_Invalid','UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.record_id_ALLOW_ErrorCount,le.record_id_LENGTH_ErrorCount
          ,le.pubdate_ALLOW_ErrorCount,le.pubdate_LENGTH_ErrorCount
          ,le.yppa_code_ALLOW_ErrorCount,le.yppa_code_LENGTH_ErrorCount
          ,le.book_code_ALLOW_ErrorCount,le.book_code_LENGTH_ErrorCount
          ,le.page_number_ALLOW_ErrorCount,le.page_number_LENGTH_ErrorCount
          ,le.record_number_ALLOW_ErrorCount,le.record_number_LENGTH_ErrorCount
          ,le.phone_number_ALLOW_ErrorCount,le.phone_number_LENGTH_ErrorCount
          ,le.phone_type_ALLOW_ErrorCount,le.phone_type_LENGTH_ErrorCount
          ,le.record_type_ENUM_ErrorCount
          ,le.no_solicitation_code_ENUM_ErrorCount
          ,le.title_ALLOW_ErrorCount
          ,le.first_name_ALLOW_ErrorCount
          ,le.middle_name_ALLOW_ErrorCount
          ,le.last_name_ALLOW_ErrorCount
          ,le.last_name_suffix_ALLOW_ErrorCount
          ,le.job_title_ALLOW_ErrorCount
          ,le.secondary_name_title_ALLOW_ErrorCount
          ,le.secondary_first_name_ALLOW_ErrorCount
          ,le.secondary_middle_name_ALLOW_ErrorCount
          ,le.secondary_name_suffix_ALLOW_ErrorCount
          ,le.house_number_ALLOW_ErrorCount
          ,le.pre_direction_ALLOW_ErrorCount,le.pre_direction_LENGTH_ErrorCount
          ,le.street_name_ALLOW_ErrorCount
          ,le.street_type_ALLOW_ErrorCount
          ,le.post_direction_ALLOW_ErrorCount,le.post_direction_LENGTH_ErrorCount
          ,le.apt_type_ALLOW_ErrorCount
          ,le.apt_number_ALLOW_ErrorCount
          ,le.box_number_ALLOW_ErrorCount
          ,le.expanded_pub_city_name_ALLOW_ErrorCount
          ,le.postal_city_name_ALLOW_ErrorCount
          ,le.state_ALLOW_ErrorCount,le.state_LENGTH_ErrorCount
          ,le.z5_ALLOW_ErrorCount,le.z5_LENGTH_ErrorCount
          ,le.plus4_ALLOW_ErrorCount,le.plus4_LENGTH_ErrorCount
          ,le.delivery_point_code_ALLOW_ErrorCount,le.delivery_point_code_LENGTH_ErrorCount
          ,le.carrier_route_ALLOW_ErrorCount,le.carrier_route_LENGTH_ErrorCount
          ,le.county_code__ALLOW_ErrorCount,le.county_code__LENGTH_ErrorCount
          ,le.gnrl_address_return_code_LENGTH_ErrorCount
          ,le.house_number_usage_flag_ALLOW_ErrorCount,le.house_number_usage_flag_LENGTH_ErrorCount
          ,le.pre_direction_usage_flag_ALLOW_ErrorCount,le.pre_direction_usage_flag_LENGTH_ErrorCount
          ,le.street_name_usage_flag_ALLOW_ErrorCount,le.street_name_usage_flag_LENGTH_ErrorCount
          ,le.street_type_usage_flag_ALLOW_ErrorCount,le.street_type_usage_flag_LENGTH_ErrorCount
          ,le.post_direction_usage_flag_ALLOW_ErrorCount,le.post_direction_usage_flag_LENGTH_ErrorCount
          ,le.apt_number_usage_flag_ALLOW_ErrorCount,le.apt_number_usage_flag_LENGTH_ErrorCount
          ,le.validation_date_ALLOW_ErrorCount,le.validation_date_LENGTH_ErrorCount
          ,le.validation_flag_ALLOW_ErrorCount,le.validation_flag_LENGTH_ErrorCount
          ,le.dt_first_seen_ALLOW_ErrorCount,le.dt_first_seen_LENGTH_ErrorCount
          ,le.dt_last_seen_ALLOW_ErrorCount,le.dt_last_seen_LENGTH_ErrorCount
          ,le.dt_vendor_last_reported_ALLOW_ErrorCount,le.dt_vendor_last_reported_LENGTH_ErrorCount
          ,le.dt_vendor_first_reported_ALLOW_ErrorCount,le.dt_vendor_first_reported_LENGTH_ErrorCount
          ,le.rec_type_ALLOW_ErrorCount,le.rec_type_LENGTH_ErrorCount
          ,le.fname_ALLOW_ErrorCount
          ,le.minit_ALLOW_ErrorCount
          ,le.lname_ALLOW_ErrorCount
          ,le.name_suffix_ALLOW_ErrorCount
          ,le.prim_range_ALLOW_ErrorCount
          ,le.predir_ALLOW_ErrorCount,le.predir_LENGTH_ErrorCount
          ,le.prim_name_ALLOW_ErrorCount
          ,le.suffix_ALLOW_ErrorCount
          ,le.postdir_ALLOW_ErrorCount,le.postdir_LENGTH_ErrorCount
          ,le.unit_desig_ALLOW_ErrorCount
          ,le.sec_range_ALLOW_ErrorCount
          ,le.city_name_ALLOW_ErrorCount
          ,le.st_ALLOW_ErrorCount,le.st_LENGTH_ErrorCount
          ,le.zip_ALLOW_ErrorCount,le.zip_LENGTH_ErrorCount
          ,le.zip4_ALLOW_ErrorCount,le.zip4_LENGTH_ErrorCount
          ,le.county_ALLOW_ErrorCount,le.county_LENGTH_ErrorCount
          ,le.cbsa_ALLOW_ErrorCount,le.cbsa_LENGTH_ErrorCount
          ,le.geo_blk_ALLOW_ErrorCount,le.geo_blk_LENGTH_ErrorCount
          ,le.cleanname_ALLOW_ErrorCount
          ,le.cleanaddress_ALLOW_ErrorCount
          ,le.invalid_vendor_dates_dt_vendor_first_reported_Invalid_ErrorCount,le.invalid_vendor_dates_dt_vendor_last_reported_Invalid_ErrorCount,le.invalid_vendor_dates_dt_vendor_first_reported_dt_vendor_last_reported_Cnd_Invalid_ErrorCount
          ,le.invalid_seen_dates_dt_first_seen_Invalid_ErrorCount,le.invalid_seen_dates_dt_last_seen_Invalid_ErrorCount,le.invalid_seen_dates_dt_first_seen_dt_last_seen_Condition_Invalid_ErrorCount,0);
      SELF.rulepcnt := 100 * CHOOSE(c
          ,le.record_id_ALLOW_ErrorCount,le.record_id_LENGTH_ErrorCount
          ,le.pubdate_ALLOW_ErrorCount,le.pubdate_LENGTH_ErrorCount
          ,le.yppa_code_ALLOW_ErrorCount,le.yppa_code_LENGTH_ErrorCount
          ,le.book_code_ALLOW_ErrorCount,le.book_code_LENGTH_ErrorCount
          ,le.page_number_ALLOW_ErrorCount,le.page_number_LENGTH_ErrorCount
          ,le.record_number_ALLOW_ErrorCount,le.record_number_LENGTH_ErrorCount
          ,le.phone_number_ALLOW_ErrorCount,le.phone_number_LENGTH_ErrorCount
          ,le.phone_type_ALLOW_ErrorCount,le.phone_type_LENGTH_ErrorCount
          ,le.record_type_ENUM_ErrorCount
          ,le.no_solicitation_code_ENUM_ErrorCount
          ,le.title_ALLOW_ErrorCount
          ,le.first_name_ALLOW_ErrorCount
          ,le.middle_name_ALLOW_ErrorCount
          ,le.last_name_ALLOW_ErrorCount
          ,le.last_name_suffix_ALLOW_ErrorCount
          ,le.job_title_ALLOW_ErrorCount
          ,le.secondary_name_title_ALLOW_ErrorCount
          ,le.secondary_first_name_ALLOW_ErrorCount
          ,le.secondary_middle_name_ALLOW_ErrorCount
          ,le.secondary_name_suffix_ALLOW_ErrorCount
          ,le.house_number_ALLOW_ErrorCount
          ,le.pre_direction_ALLOW_ErrorCount,le.pre_direction_LENGTH_ErrorCount
          ,le.street_name_ALLOW_ErrorCount
          ,le.street_type_ALLOW_ErrorCount
          ,le.post_direction_ALLOW_ErrorCount,le.post_direction_LENGTH_ErrorCount
          ,le.apt_type_ALLOW_ErrorCount
          ,le.apt_number_ALLOW_ErrorCount
          ,le.box_number_ALLOW_ErrorCount
          ,le.expanded_pub_city_name_ALLOW_ErrorCount
          ,le.postal_city_name_ALLOW_ErrorCount
          ,le.state_ALLOW_ErrorCount,le.state_LENGTH_ErrorCount
          ,le.z5_ALLOW_ErrorCount,le.z5_LENGTH_ErrorCount
          ,le.plus4_ALLOW_ErrorCount,le.plus4_LENGTH_ErrorCount
          ,le.delivery_point_code_ALLOW_ErrorCount,le.delivery_point_code_LENGTH_ErrorCount
          ,le.carrier_route_ALLOW_ErrorCount,le.carrier_route_LENGTH_ErrorCount
          ,le.county_code__ALLOW_ErrorCount,le.county_code__LENGTH_ErrorCount
          ,le.gnrl_address_return_code_LENGTH_ErrorCount
          ,le.house_number_usage_flag_ALLOW_ErrorCount,le.house_number_usage_flag_LENGTH_ErrorCount
          ,le.pre_direction_usage_flag_ALLOW_ErrorCount,le.pre_direction_usage_flag_LENGTH_ErrorCount
          ,le.street_name_usage_flag_ALLOW_ErrorCount,le.street_name_usage_flag_LENGTH_ErrorCount
          ,le.street_type_usage_flag_ALLOW_ErrorCount,le.street_type_usage_flag_LENGTH_ErrorCount
          ,le.post_direction_usage_flag_ALLOW_ErrorCount,le.post_direction_usage_flag_LENGTH_ErrorCount
          ,le.apt_number_usage_flag_ALLOW_ErrorCount,le.apt_number_usage_flag_LENGTH_ErrorCount
          ,le.validation_date_ALLOW_ErrorCount,le.validation_date_LENGTH_ErrorCount
          ,le.validation_flag_ALLOW_ErrorCount,le.validation_flag_LENGTH_ErrorCount
          ,le.dt_first_seen_ALLOW_ErrorCount,le.dt_first_seen_LENGTH_ErrorCount
          ,le.dt_last_seen_ALLOW_ErrorCount,le.dt_last_seen_LENGTH_ErrorCount
          ,le.dt_vendor_last_reported_ALLOW_ErrorCount,le.dt_vendor_last_reported_LENGTH_ErrorCount
          ,le.dt_vendor_first_reported_ALLOW_ErrorCount,le.dt_vendor_first_reported_LENGTH_ErrorCount
          ,le.rec_type_ALLOW_ErrorCount,le.rec_type_LENGTH_ErrorCount
          ,le.fname_ALLOW_ErrorCount
          ,le.minit_ALLOW_ErrorCount
          ,le.lname_ALLOW_ErrorCount
          ,le.name_suffix_ALLOW_ErrorCount
          ,le.prim_range_ALLOW_ErrorCount
          ,le.predir_ALLOW_ErrorCount,le.predir_LENGTH_ErrorCount
          ,le.prim_name_ALLOW_ErrorCount
          ,le.suffix_ALLOW_ErrorCount
          ,le.postdir_ALLOW_ErrorCount,le.postdir_LENGTH_ErrorCount
          ,le.unit_desig_ALLOW_ErrorCount
          ,le.sec_range_ALLOW_ErrorCount
          ,le.city_name_ALLOW_ErrorCount
          ,le.st_ALLOW_ErrorCount,le.st_LENGTH_ErrorCount
          ,le.zip_ALLOW_ErrorCount,le.zip_LENGTH_ErrorCount
          ,le.zip4_ALLOW_ErrorCount,le.zip4_LENGTH_ErrorCount
          ,le.county_ALLOW_ErrorCount,le.county_LENGTH_ErrorCount
          ,le.cbsa_ALLOW_ErrorCount,le.cbsa_LENGTH_ErrorCount
          ,le.geo_blk_ALLOW_ErrorCount,le.geo_blk_LENGTH_ErrorCount
          ,le.cleanname_ALLOW_ErrorCount
          ,le.cleanaddress_ALLOW_ErrorCount
          ,le.invalid_vendor_dates_dt_vendor_first_reported_Invalid_ErrorCount,le.invalid_vendor_dates_dt_vendor_last_reported_Invalid_ErrorCount,le.invalid_vendor_dates_dt_vendor_first_reported_dt_vendor_last_reported_Cnd_Invalid_ErrorCount
          ,le.invalid_seen_dates_dt_first_seen_Invalid_ErrorCount,le.invalid_seen_dates_dt_last_seen_Invalid_ErrorCount,le.invalid_seen_dates_dt_first_seen_dt_last_seen_Condition_Invalid_ErrorCount,0) / le.TotalCnt + 0.5;
    END;
    SummaryInfo := NORMALIZE(SummaryStats,113,Into(LEFT,COUNTER));
    orb_r := RECORD
      AllErrors.Src;
      STRING RuleDesc := TRIM(AllErrors.FieldName)+':'+TRIM(AllErrors.FieldType)+':'+AllErrors.ErrorType;
      SALT30.StrType RawCodeMissing := AllErrors.FieldContents;
    END;
    tab := TABLE(AllErrors,orb_r);
    orb_sum := TABLE(tab,{src,ruledesc,rawcodemissing,rawcodemissingcnt := COUNT(GROUP)},src,ruledesc,rawcodemissing,MERGE);
    gt := GROUP(TOPN(GROUP(orb_sum,src,ruledesc,ALL),examples,-rawcodemissingcnt));
    SALT30.ScrubsOrbitLayout jn(SummaryInfo le, gt ri) := TRANSFORM
      SELF.rawcodemissing := ri.rawcodemissing;
      SELF.rawcodemissingcnt := ri.rawcodemissingcnt;
      SELF := le;
    END;
    j := JOIN(SummaryInfo,gt,LEFT.SourceCode=RIGHT.SRC AND LEFT.ruledesc=RIGHT.ruledesc,jn(LEFT,RIGHT),HASH,LEFT OUTER);
    RETURN IF(examples>0,j,SummaryInfo);
  END;
END;
END;
