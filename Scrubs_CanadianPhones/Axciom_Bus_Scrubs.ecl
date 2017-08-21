IMPORT ut,SALT32;
EXPORT Axciom_Bus_Scrubs := MODULE
// The module to handle the case where no scrubs exist
  EXPORT  Expanded_Layout := RECORD(Axciom_Bus_Layout_CanadianPhones)
    UNSIGNED1 record_id_Invalid;
    UNSIGNED1 book_number_Invalid;
    UNSIGNED1 pub_date_Invalid;
    UNSIGNED1 business_name_Invalid;
    UNSIGNED1 street_name_Invalid;
    UNSIGNED1 unit_designator_Invalid;
    UNSIGNED1 unit_number_Invalid;
    UNSIGNED1 city_Invalid;
    UNSIGNED1 province_Invalid;
    UNSIGNED1 postal_code_Invalid;
    UNSIGNED1 area_code_Invalid;
    UNSIGNED1 phone_number_Invalid;
    UNSIGNED1 syph_1_Invalid;
    UNSIGNED1 syph_2_Invalid;
    UNSIGNED1 syph_3_Invalid;
    UNSIGNED1 syph_4_Invalid;
    UNSIGNED1 syph_5_Invalid;
    UNSIGNED1 syph_6_Invalid;
    UNSIGNED1 naics_1_Invalid;
    UNSIGNED1 naics_2_Invalid;
    UNSIGNED1 naics_3_Invalid;
    UNSIGNED1 naics_4_Invalid;
    UNSIGNED1 naics_5_Invalid;
    UNSIGNED1 naics_6_Invalid;
    UNSIGNED1 bdc_1_Invalid;
    UNSIGNED1 bdc_2_Invalid;
    UNSIGNED1 bdc_3_Invalid;
    UNSIGNED1 bdc_4_Invalid;
    UNSIGNED1 bdc_5_Invalid;
    UNSIGNED1 bdc_6_Invalid;
    UNSIGNED1 sic_1_Invalid;
    UNSIGNED1 sic_2_Invalid;
    UNSIGNED1 sic_3_Invalid;
    UNSIGNED1 sic_4_Invalid;
    UNSIGNED1 sic_5_Invalid;
    UNSIGNED1 sic_6_Invalid;
    UNSIGNED1 caption_counter_Invalid;
    UNSIGNED1 vanity_city_Invalid;
    UNSIGNED1 bus_govt_indicator_Invalid;
    UNSIGNED1 latitude_Invalid;
    UNSIGNED1 longitude_Invalid;
    UNSIGNED1 lat_long_level_applied_Invalid;
    UNSIGNED1 record_use_indicator_Invalid;
    UNSIGNED1 email_Invalid;
    UNSIGNED1 stated_addr_Invalid;
    UNSIGNED1 stated_city_Invalid;
    UNSIGNED1 stated_postal_code_Invalid;
    UNSIGNED1 stated_bus_name_Invalid;
    UNSIGNED1 verification_flag_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Axciom_Bus_Layout_CanadianPhones)
    UNSIGNED8 ScrubsBits1;
    UNSIGNED8 ScrubsBits2;
  END;
EXPORT FromNone(DATASET(Axciom_Bus_Layout_CanadianPhones) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.record_id_Invalid := Axciom_Bus_Fields.InValid_record_id((SALT32.StrType)le.record_id);
    SELF.book_number_Invalid := Axciom_Bus_Fields.InValid_book_number((SALT32.StrType)le.book_number);
    SELF.pub_date_Invalid := Axciom_Bus_Fields.InValid_pub_date((SALT32.StrType)le.pub_date);
    SELF.business_name_Invalid := Axciom_Bus_Fields.InValid_business_name((SALT32.StrType)le.business_name);
    SELF.street_name_Invalid := Axciom_Bus_Fields.InValid_street_name((SALT32.StrType)le.street_name);
    SELF.unit_designator_Invalid := Axciom_Bus_Fields.InValid_unit_designator((SALT32.StrType)le.unit_designator);
    SELF.unit_number_Invalid := Axciom_Bus_Fields.InValid_unit_number((SALT32.StrType)le.unit_number);
    SELF.city_Invalid := Axciom_Bus_Fields.InValid_city((SALT32.StrType)le.city);
    SELF.province_Invalid := Axciom_Bus_Fields.InValid_province((SALT32.StrType)le.province);
    SELF.postal_code_Invalid := Axciom_Bus_Fields.InValid_postal_code((SALT32.StrType)le.postal_code);
    SELF.area_code_Invalid := Axciom_Bus_Fields.InValid_area_code((SALT32.StrType)le.area_code);
    SELF.phone_number_Invalid := Axciom_Bus_Fields.InValid_phone_number((SALT32.StrType)le.phone_number);
    SELF.syph_1_Invalid := Axciom_Bus_Fields.InValid_syph_1((SALT32.StrType)le.syph_1);
    SELF.syph_2_Invalid := Axciom_Bus_Fields.InValid_syph_2((SALT32.StrType)le.syph_2);
    SELF.syph_3_Invalid := Axciom_Bus_Fields.InValid_syph_3((SALT32.StrType)le.syph_3);
    SELF.syph_4_Invalid := Axciom_Bus_Fields.InValid_syph_4((SALT32.StrType)le.syph_4);
    SELF.syph_5_Invalid := Axciom_Bus_Fields.InValid_syph_5((SALT32.StrType)le.syph_5);
    SELF.syph_6_Invalid := Axciom_Bus_Fields.InValid_syph_6((SALT32.StrType)le.syph_6);
    SELF.naics_1_Invalid := Axciom_Bus_Fields.InValid_naics_1((SALT32.StrType)le.naics_1);
    SELF.naics_2_Invalid := Axciom_Bus_Fields.InValid_naics_2((SALT32.StrType)le.naics_2);
    SELF.naics_3_Invalid := Axciom_Bus_Fields.InValid_naics_3((SALT32.StrType)le.naics_3);
    SELF.naics_4_Invalid := Axciom_Bus_Fields.InValid_naics_4((SALT32.StrType)le.naics_4);
    SELF.naics_5_Invalid := Axciom_Bus_Fields.InValid_naics_5((SALT32.StrType)le.naics_5);
    SELF.naics_6_Invalid := Axciom_Bus_Fields.InValid_naics_6((SALT32.StrType)le.naics_6);
    SELF.bdc_1_Invalid := Axciom_Bus_Fields.InValid_bdc_1((SALT32.StrType)le.bdc_1);
    SELF.bdc_2_Invalid := Axciom_Bus_Fields.InValid_bdc_2((SALT32.StrType)le.bdc_2);
    SELF.bdc_3_Invalid := Axciom_Bus_Fields.InValid_bdc_3((SALT32.StrType)le.bdc_3);
    SELF.bdc_4_Invalid := Axciom_Bus_Fields.InValid_bdc_4((SALT32.StrType)le.bdc_4);
    SELF.bdc_5_Invalid := Axciom_Bus_Fields.InValid_bdc_5((SALT32.StrType)le.bdc_5);
    SELF.bdc_6_Invalid := Axciom_Bus_Fields.InValid_bdc_6((SALT32.StrType)le.bdc_6);
    SELF.sic_1_Invalid := Axciom_Bus_Fields.InValid_sic_1((SALT32.StrType)le.sic_1);
    SELF.sic_2_Invalid := Axciom_Bus_Fields.InValid_sic_2((SALT32.StrType)le.sic_2);
    SELF.sic_3_Invalid := Axciom_Bus_Fields.InValid_sic_3((SALT32.StrType)le.sic_3);
    SELF.sic_4_Invalid := Axciom_Bus_Fields.InValid_sic_4((SALT32.StrType)le.sic_4);
    SELF.sic_5_Invalid := Axciom_Bus_Fields.InValid_sic_5((SALT32.StrType)le.sic_5);
    SELF.sic_6_Invalid := Axciom_Bus_Fields.InValid_sic_6((SALT32.StrType)le.sic_6);
    SELF.caption_counter_Invalid := Axciom_Bus_Fields.InValid_caption_counter((SALT32.StrType)le.caption_counter);
    SELF.vanity_city_Invalid := Axciom_Bus_Fields.InValid_vanity_city((SALT32.StrType)le.vanity_city);
    SELF.bus_govt_indicator_Invalid := Axciom_Bus_Fields.InValid_bus_govt_indicator((SALT32.StrType)le.bus_govt_indicator);
    SELF.latitude_Invalid := Axciom_Bus_Fields.InValid_latitude((SALT32.StrType)le.latitude);
    SELF.longitude_Invalid := Axciom_Bus_Fields.InValid_longitude((SALT32.StrType)le.longitude);
    SELF.lat_long_level_applied_Invalid := Axciom_Bus_Fields.InValid_lat_long_level_applied((SALT32.StrType)le.lat_long_level_applied);
    SELF.record_use_indicator_Invalid := Axciom_Bus_Fields.InValid_record_use_indicator((SALT32.StrType)le.record_use_indicator);
    SELF.email_Invalid := Axciom_Bus_Fields.InValid_email((SALT32.StrType)le.email);
    SELF.stated_addr_Invalid := Axciom_Bus_Fields.InValid_stated_addr((SALT32.StrType)le.stated_addr);
    SELF.stated_city_Invalid := Axciom_Bus_Fields.InValid_stated_city((SALT32.StrType)le.stated_city);
    SELF.stated_postal_code_Invalid := Axciom_Bus_Fields.InValid_stated_postal_code((SALT32.StrType)le.stated_postal_code);
    SELF.stated_bus_name_Invalid := Axciom_Bus_Fields.InValid_stated_bus_name((SALT32.StrType)le.stated_bus_name);
    SELF.verification_flag_Invalid := Axciom_Bus_Fields.InValid_verification_flag((SALT32.StrType)le.verification_flag);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Axciom_Bus_Layout_CanadianPhones);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.record_id_Invalid << 0 ) + ( le.book_number_Invalid << 2 ) + ( le.pub_date_Invalid << 3 ) + ( le.business_name_Invalid << 5 ) + ( le.street_name_Invalid << 7 ) + ( le.unit_designator_Invalid << 9 ) + ( le.unit_number_Invalid << 11 ) + ( le.city_Invalid << 13 ) + ( le.province_Invalid << 15 ) + ( le.postal_code_Invalid << 17 ) + ( le.area_code_Invalid << 19 ) + ( le.phone_number_Invalid << 21 ) + ( le.syph_1_Invalid << 23 ) + ( le.syph_2_Invalid << 24 ) + ( le.syph_3_Invalid << 25 ) + ( le.syph_4_Invalid << 26 ) + ( le.syph_5_Invalid << 27 ) + ( le.syph_6_Invalid << 28 ) + ( le.naics_1_Invalid << 29 ) + ( le.naics_2_Invalid << 30 ) + ( le.naics_3_Invalid << 31 ) + ( le.naics_4_Invalid << 32 ) + ( le.naics_5_Invalid << 33 ) + ( le.naics_6_Invalid << 34 ) + ( le.bdc_1_Invalid << 35 ) + ( le.bdc_2_Invalid << 36 ) + ( le.bdc_3_Invalid << 37 ) + ( le.bdc_4_Invalid << 38 ) + ( le.bdc_5_Invalid << 39 ) + ( le.bdc_6_Invalid << 40 ) + ( le.sic_1_Invalid << 41 ) + ( le.sic_2_Invalid << 42 ) + ( le.sic_3_Invalid << 43 ) + ( le.sic_4_Invalid << 44 ) + ( le.sic_5_Invalid << 45 ) + ( le.sic_6_Invalid << 46 ) + ( le.caption_counter_Invalid << 47 ) + ( le.vanity_city_Invalid << 48 ) + ( le.bus_govt_indicator_Invalid << 50 ) + ( le.latitude_Invalid << 52 ) + ( le.longitude_Invalid << 53 ) + ( le.lat_long_level_applied_Invalid << 54 ) + ( le.record_use_indicator_Invalid << 56 ) + ( le.email_Invalid << 58 ) + ( le.stated_addr_Invalid << 59 ) + ( le.stated_city_Invalid << 61 );
    SELF.ScrubsBits2 := ( le.stated_postal_code_Invalid << 0 ) + ( le.stated_bus_name_Invalid << 2 ) + ( le.verification_flag_Invalid << 4 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Axciom_Bus_Layout_CanadianPhones);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.record_id_Invalid := (le.ScrubsBits1 >> 0) & 3;
    SELF.book_number_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.pub_date_Invalid := (le.ScrubsBits1 >> 3) & 3;
    SELF.business_name_Invalid := (le.ScrubsBits1 >> 5) & 3;
    SELF.street_name_Invalid := (le.ScrubsBits1 >> 7) & 3;
    SELF.unit_designator_Invalid := (le.ScrubsBits1 >> 9) & 3;
    SELF.unit_number_Invalid := (le.ScrubsBits1 >> 11) & 3;
    SELF.city_Invalid := (le.ScrubsBits1 >> 13) & 3;
    SELF.province_Invalid := (le.ScrubsBits1 >> 15) & 3;
    SELF.postal_code_Invalid := (le.ScrubsBits1 >> 17) & 3;
    SELF.area_code_Invalid := (le.ScrubsBits1 >> 19) & 3;
    SELF.phone_number_Invalid := (le.ScrubsBits1 >> 21) & 3;
    SELF.syph_1_Invalid := (le.ScrubsBits1 >> 23) & 1;
    SELF.syph_2_Invalid := (le.ScrubsBits1 >> 24) & 1;
    SELF.syph_3_Invalid := (le.ScrubsBits1 >> 25) & 1;
    SELF.syph_4_Invalid := (le.ScrubsBits1 >> 26) & 1;
    SELF.syph_5_Invalid := (le.ScrubsBits1 >> 27) & 1;
    SELF.syph_6_Invalid := (le.ScrubsBits1 >> 28) & 1;
    SELF.naics_1_Invalid := (le.ScrubsBits1 >> 29) & 1;
    SELF.naics_2_Invalid := (le.ScrubsBits1 >> 30) & 1;
    SELF.naics_3_Invalid := (le.ScrubsBits1 >> 31) & 1;
    SELF.naics_4_Invalid := (le.ScrubsBits1 >> 32) & 1;
    SELF.naics_5_Invalid := (le.ScrubsBits1 >> 33) & 1;
    SELF.naics_6_Invalid := (le.ScrubsBits1 >> 34) & 1;
    SELF.bdc_1_Invalid := (le.ScrubsBits1 >> 35) & 1;
    SELF.bdc_2_Invalid := (le.ScrubsBits1 >> 36) & 1;
    SELF.bdc_3_Invalid := (le.ScrubsBits1 >> 37) & 1;
    SELF.bdc_4_Invalid := (le.ScrubsBits1 >> 38) & 1;
    SELF.bdc_5_Invalid := (le.ScrubsBits1 >> 39) & 1;
    SELF.bdc_6_Invalid := (le.ScrubsBits1 >> 40) & 1;
    SELF.sic_1_Invalid := (le.ScrubsBits1 >> 41) & 1;
    SELF.sic_2_Invalid := (le.ScrubsBits1 >> 42) & 1;
    SELF.sic_3_Invalid := (le.ScrubsBits1 >> 43) & 1;
    SELF.sic_4_Invalid := (le.ScrubsBits1 >> 44) & 1;
    SELF.sic_5_Invalid := (le.ScrubsBits1 >> 45) & 1;
    SELF.sic_6_Invalid := (le.ScrubsBits1 >> 46) & 1;
    SELF.caption_counter_Invalid := (le.ScrubsBits1 >> 47) & 1;
    SELF.vanity_city_Invalid := (le.ScrubsBits1 >> 48) & 3;
    SELF.bus_govt_indicator_Invalid := (le.ScrubsBits1 >> 50) & 3;
    SELF.latitude_Invalid := (le.ScrubsBits1 >> 52) & 1;
    SELF.longitude_Invalid := (le.ScrubsBits1 >> 53) & 1;
    SELF.lat_long_level_applied_Invalid := (le.ScrubsBits1 >> 54) & 3;
    SELF.record_use_indicator_Invalid := (le.ScrubsBits1 >> 56) & 3;
    SELF.email_Invalid := (le.ScrubsBits1 >> 58) & 1;
    SELF.stated_addr_Invalid := (le.ScrubsBits1 >> 59) & 3;
    SELF.stated_city_Invalid := (le.ScrubsBits1 >> 61) & 3;
    SELF.stated_postal_code_Invalid := (le.ScrubsBits2 >> 0) & 3;
    SELF.stated_bus_name_Invalid := (le.ScrubsBits2 >> 2) & 3;
    SELF.verification_flag_Invalid := (le.ScrubsBits2 >> 4) & 3;
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
    book_number_ALLOW_ErrorCount := COUNT(GROUP,h.book_number_Invalid=1);
    pub_date_ALLOW_ErrorCount := COUNT(GROUP,h.pub_date_Invalid=1);
    pub_date_LENGTH_ErrorCount := COUNT(GROUP,h.pub_date_Invalid=2);
    pub_date_Total_ErrorCount := COUNT(GROUP,h.pub_date_Invalid>0);
    business_name_ALLOW_ErrorCount := COUNT(GROUP,h.business_name_Invalid=1);
    business_name_LENGTH_ErrorCount := COUNT(GROUP,h.business_name_Invalid=2);
    business_name_Total_ErrorCount := COUNT(GROUP,h.business_name_Invalid>0);
    street_name_ALLOW_ErrorCount := COUNT(GROUP,h.street_name_Invalid=1);
    street_name_LENGTH_ErrorCount := COUNT(GROUP,h.street_name_Invalid=2);
    street_name_Total_ErrorCount := COUNT(GROUP,h.street_name_Invalid>0);
    unit_designator_ALLOW_ErrorCount := COUNT(GROUP,h.unit_designator_Invalid=1);
    unit_designator_LENGTH_ErrorCount := COUNT(GROUP,h.unit_designator_Invalid=2);
    unit_designator_Total_ErrorCount := COUNT(GROUP,h.unit_designator_Invalid>0);
    unit_number_ALLOW_ErrorCount := COUNT(GROUP,h.unit_number_Invalid=1);
    unit_number_LENGTH_ErrorCount := COUNT(GROUP,h.unit_number_Invalid=2);
    unit_number_Total_ErrorCount := COUNT(GROUP,h.unit_number_Invalid>0);
    city_ALLOW_ErrorCount := COUNT(GROUP,h.city_Invalid=1);
    city_LENGTH_ErrorCount := COUNT(GROUP,h.city_Invalid=2);
    city_Total_ErrorCount := COUNT(GROUP,h.city_Invalid>0);
    province_ALLOW_ErrorCount := COUNT(GROUP,h.province_Invalid=1);
    province_LENGTH_ErrorCount := COUNT(GROUP,h.province_Invalid=2);
    province_Total_ErrorCount := COUNT(GROUP,h.province_Invalid>0);
    postal_code_ALLOW_ErrorCount := COUNT(GROUP,h.postal_code_Invalid=1);
    postal_code_LENGTH_ErrorCount := COUNT(GROUP,h.postal_code_Invalid=2);
    postal_code_Total_ErrorCount := COUNT(GROUP,h.postal_code_Invalid>0);
    area_code_ALLOW_ErrorCount := COUNT(GROUP,h.area_code_Invalid=1);
    area_code_LENGTH_ErrorCount := COUNT(GROUP,h.area_code_Invalid=2);
    area_code_Total_ErrorCount := COUNT(GROUP,h.area_code_Invalid>0);
    phone_number_ALLOW_ErrorCount := COUNT(GROUP,h.phone_number_Invalid=1);
    phone_number_LENGTH_ErrorCount := COUNT(GROUP,h.phone_number_Invalid=2);
    phone_number_Total_ErrorCount := COUNT(GROUP,h.phone_number_Invalid>0);
    syph_1_ALLOW_ErrorCount := COUNT(GROUP,h.syph_1_Invalid=1);
    syph_2_ALLOW_ErrorCount := COUNT(GROUP,h.syph_2_Invalid=1);
    syph_3_ALLOW_ErrorCount := COUNT(GROUP,h.syph_3_Invalid=1);
    syph_4_ALLOW_ErrorCount := COUNT(GROUP,h.syph_4_Invalid=1);
    syph_5_ALLOW_ErrorCount := COUNT(GROUP,h.syph_5_Invalid=1);
    syph_6_ALLOW_ErrorCount := COUNT(GROUP,h.syph_6_Invalid=1);
    naics_1_ALLOW_ErrorCount := COUNT(GROUP,h.naics_1_Invalid=1);
    naics_2_ALLOW_ErrorCount := COUNT(GROUP,h.naics_2_Invalid=1);
    naics_3_ALLOW_ErrorCount := COUNT(GROUP,h.naics_3_Invalid=1);
    naics_4_ALLOW_ErrorCount := COUNT(GROUP,h.naics_4_Invalid=1);
    naics_5_ALLOW_ErrorCount := COUNT(GROUP,h.naics_5_Invalid=1);
    naics_6_ALLOW_ErrorCount := COUNT(GROUP,h.naics_6_Invalid=1);
    bdc_1_ALLOW_ErrorCount := COUNT(GROUP,h.bdc_1_Invalid=1);
    bdc_2_ALLOW_ErrorCount := COUNT(GROUP,h.bdc_2_Invalid=1);
    bdc_3_ALLOW_ErrorCount := COUNT(GROUP,h.bdc_3_Invalid=1);
    bdc_4_ALLOW_ErrorCount := COUNT(GROUP,h.bdc_4_Invalid=1);
    bdc_5_ALLOW_ErrorCount := COUNT(GROUP,h.bdc_5_Invalid=1);
    bdc_6_ALLOW_ErrorCount := COUNT(GROUP,h.bdc_6_Invalid=1);
    sic_1_ALLOW_ErrorCount := COUNT(GROUP,h.sic_1_Invalid=1);
    sic_2_ALLOW_ErrorCount := COUNT(GROUP,h.sic_2_Invalid=1);
    sic_3_ALLOW_ErrorCount := COUNT(GROUP,h.sic_3_Invalid=1);
    sic_4_ALLOW_ErrorCount := COUNT(GROUP,h.sic_4_Invalid=1);
    sic_5_ALLOW_ErrorCount := COUNT(GROUP,h.sic_5_Invalid=1);
    sic_6_ALLOW_ErrorCount := COUNT(GROUP,h.sic_6_Invalid=1);
    caption_counter_ALLOW_ErrorCount := COUNT(GROUP,h.caption_counter_Invalid=1);
    vanity_city_ALLOW_ErrorCount := COUNT(GROUP,h.vanity_city_Invalid=1);
    vanity_city_LENGTH_ErrorCount := COUNT(GROUP,h.vanity_city_Invalid=2);
    vanity_city_Total_ErrorCount := COUNT(GROUP,h.vanity_city_Invalid>0);
    bus_govt_indicator_ENUM_ErrorCount := COUNT(GROUP,h.bus_govt_indicator_Invalid=1);
    bus_govt_indicator_LENGTH_ErrorCount := COUNT(GROUP,h.bus_govt_indicator_Invalid=2);
    bus_govt_indicator_Total_ErrorCount := COUNT(GROUP,h.bus_govt_indicator_Invalid>0);
    latitude_ALLOW_ErrorCount := COUNT(GROUP,h.latitude_Invalid=1);
    longitude_ALLOW_ErrorCount := COUNT(GROUP,h.longitude_Invalid=1);
    lat_long_level_applied_ALLOW_ErrorCount := COUNT(GROUP,h.lat_long_level_applied_Invalid=1);
    lat_long_level_applied_LENGTH_ErrorCount := COUNT(GROUP,h.lat_long_level_applied_Invalid=2);
    lat_long_level_applied_Total_ErrorCount := COUNT(GROUP,h.lat_long_level_applied_Invalid>0);
    record_use_indicator_ENUM_ErrorCount := COUNT(GROUP,h.record_use_indicator_Invalid=1);
    record_use_indicator_LENGTH_ErrorCount := COUNT(GROUP,h.record_use_indicator_Invalid=2);
    record_use_indicator_Total_ErrorCount := COUNT(GROUP,h.record_use_indicator_Invalid>0);
    email_ALLOW_ErrorCount := COUNT(GROUP,h.email_Invalid=1);
    stated_addr_ALLOW_ErrorCount := COUNT(GROUP,h.stated_addr_Invalid=1);
    stated_addr_LENGTH_ErrorCount := COUNT(GROUP,h.stated_addr_Invalid=2);
    stated_addr_Total_ErrorCount := COUNT(GROUP,h.stated_addr_Invalid>0);
    stated_city_ALLOW_ErrorCount := COUNT(GROUP,h.stated_city_Invalid=1);
    stated_city_LENGTH_ErrorCount := COUNT(GROUP,h.stated_city_Invalid=2);
    stated_city_Total_ErrorCount := COUNT(GROUP,h.stated_city_Invalid>0);
    stated_postal_code_ALLOW_ErrorCount := COUNT(GROUP,h.stated_postal_code_Invalid=1);
    stated_postal_code_LENGTH_ErrorCount := COUNT(GROUP,h.stated_postal_code_Invalid=2);
    stated_postal_code_Total_ErrorCount := COUNT(GROUP,h.stated_postal_code_Invalid>0);
    stated_bus_name_ALLOW_ErrorCount := COUNT(GROUP,h.stated_bus_name_Invalid=1);
    stated_bus_name_LENGTH_ErrorCount := COUNT(GROUP,h.stated_bus_name_Invalid=2);
    stated_bus_name_Total_ErrorCount := COUNT(GROUP,h.stated_bus_name_Invalid>0);
    verification_flag_ENUM_ErrorCount := COUNT(GROUP,h.verification_flag_Invalid=1);
    verification_flag_LENGTH_ErrorCount := COUNT(GROUP,h.verification_flag_Invalid=2);
    verification_flag_Total_ErrorCount := COUNT(GROUP,h.verification_flag_Invalid>0);
  END;
  EXPORT SummaryStats := TABLE(h,r);
  r := RECORD
    STRING10 Src;
    STRING FieldName;
    STRING FieldType;
    STRING ErrorType;
    SALT32.StrType ErrorMessage;
    SALT32.StrType FieldContents;
  END;
  r into(h le,UNSIGNED c) := TRANSFORM
    SELF.Src :=  ''; // Source not provided
    UNSIGNED1 ErrNum := CHOOSE(c,le.record_id_Invalid,le.book_number_Invalid,le.pub_date_Invalid,le.business_name_Invalid,le.street_name_Invalid,le.unit_designator_Invalid,le.unit_number_Invalid,le.city_Invalid,le.province_Invalid,le.postal_code_Invalid,le.area_code_Invalid,le.phone_number_Invalid,le.syph_1_Invalid,le.syph_2_Invalid,le.syph_3_Invalid,le.syph_4_Invalid,le.syph_5_Invalid,le.syph_6_Invalid,le.naics_1_Invalid,le.naics_2_Invalid,le.naics_3_Invalid,le.naics_4_Invalid,le.naics_5_Invalid,le.naics_6_Invalid,le.bdc_1_Invalid,le.bdc_2_Invalid,le.bdc_3_Invalid,le.bdc_4_Invalid,le.bdc_5_Invalid,le.bdc_6_Invalid,le.sic_1_Invalid,le.sic_2_Invalid,le.sic_3_Invalid,le.sic_4_Invalid,le.sic_5_Invalid,le.sic_6_Invalid,le.caption_counter_Invalid,le.vanity_city_Invalid,le.bus_govt_indicator_Invalid,le.latitude_Invalid,le.longitude_Invalid,le.lat_long_level_applied_Invalid,le.record_use_indicator_Invalid,le.email_Invalid,le.stated_addr_Invalid,le.stated_city_Invalid,le.stated_postal_code_Invalid,le.stated_bus_name_Invalid,le.verification_flag_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Axciom_Bus_Fields.InvalidMessage_record_id(le.record_id_Invalid),Axciom_Bus_Fields.InvalidMessage_book_number(le.book_number_Invalid),Axciom_Bus_Fields.InvalidMessage_pub_date(le.pub_date_Invalid),Axciom_Bus_Fields.InvalidMessage_business_name(le.business_name_Invalid),Axciom_Bus_Fields.InvalidMessage_street_name(le.street_name_Invalid),Axciom_Bus_Fields.InvalidMessage_unit_designator(le.unit_designator_Invalid),Axciom_Bus_Fields.InvalidMessage_unit_number(le.unit_number_Invalid),Axciom_Bus_Fields.InvalidMessage_city(le.city_Invalid),Axciom_Bus_Fields.InvalidMessage_province(le.province_Invalid),Axciom_Bus_Fields.InvalidMessage_postal_code(le.postal_code_Invalid),Axciom_Bus_Fields.InvalidMessage_area_code(le.area_code_Invalid),Axciom_Bus_Fields.InvalidMessage_phone_number(le.phone_number_Invalid),Axciom_Bus_Fields.InvalidMessage_syph_1(le.syph_1_Invalid),Axciom_Bus_Fields.InvalidMessage_syph_2(le.syph_2_Invalid),Axciom_Bus_Fields.InvalidMessage_syph_3(le.syph_3_Invalid),Axciom_Bus_Fields.InvalidMessage_syph_4(le.syph_4_Invalid),Axciom_Bus_Fields.InvalidMessage_syph_5(le.syph_5_Invalid),Axciom_Bus_Fields.InvalidMessage_syph_6(le.syph_6_Invalid),Axciom_Bus_Fields.InvalidMessage_naics_1(le.naics_1_Invalid),Axciom_Bus_Fields.InvalidMessage_naics_2(le.naics_2_Invalid),Axciom_Bus_Fields.InvalidMessage_naics_3(le.naics_3_Invalid),Axciom_Bus_Fields.InvalidMessage_naics_4(le.naics_4_Invalid),Axciom_Bus_Fields.InvalidMessage_naics_5(le.naics_5_Invalid),Axciom_Bus_Fields.InvalidMessage_naics_6(le.naics_6_Invalid),Axciom_Bus_Fields.InvalidMessage_bdc_1(le.bdc_1_Invalid),Axciom_Bus_Fields.InvalidMessage_bdc_2(le.bdc_2_Invalid),Axciom_Bus_Fields.InvalidMessage_bdc_3(le.bdc_3_Invalid),Axciom_Bus_Fields.InvalidMessage_bdc_4(le.bdc_4_Invalid),Axciom_Bus_Fields.InvalidMessage_bdc_5(le.bdc_5_Invalid),Axciom_Bus_Fields.InvalidMessage_bdc_6(le.bdc_6_Invalid),Axciom_Bus_Fields.InvalidMessage_sic_1(le.sic_1_Invalid),Axciom_Bus_Fields.InvalidMessage_sic_2(le.sic_2_Invalid),Axciom_Bus_Fields.InvalidMessage_sic_3(le.sic_3_Invalid),Axciom_Bus_Fields.InvalidMessage_sic_4(le.sic_4_Invalid),Axciom_Bus_Fields.InvalidMessage_sic_5(le.sic_5_Invalid),Axciom_Bus_Fields.InvalidMessage_sic_6(le.sic_6_Invalid),Axciom_Bus_Fields.InvalidMessage_caption_counter(le.caption_counter_Invalid),Axciom_Bus_Fields.InvalidMessage_vanity_city(le.vanity_city_Invalid),Axciom_Bus_Fields.InvalidMessage_bus_govt_indicator(le.bus_govt_indicator_Invalid),Axciom_Bus_Fields.InvalidMessage_latitude(le.latitude_Invalid),Axciom_Bus_Fields.InvalidMessage_longitude(le.longitude_Invalid),Axciom_Bus_Fields.InvalidMessage_lat_long_level_applied(le.lat_long_level_applied_Invalid),Axciom_Bus_Fields.InvalidMessage_record_use_indicator(le.record_use_indicator_Invalid),Axciom_Bus_Fields.InvalidMessage_email(le.email_Invalid),Axciom_Bus_Fields.InvalidMessage_stated_addr(le.stated_addr_Invalid),Axciom_Bus_Fields.InvalidMessage_stated_city(le.stated_city_Invalid),Axciom_Bus_Fields.InvalidMessage_stated_postal_code(le.stated_postal_code_Invalid),Axciom_Bus_Fields.InvalidMessage_stated_bus_name(le.stated_bus_name_Invalid),Axciom_Bus_Fields.InvalidMessage_verification_flag(le.verification_flag_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.record_id_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.book_number_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.pub_date_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.business_name_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.street_name_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.unit_designator_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.unit_number_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.city_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.province_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.postal_code_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.area_code_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.phone_number_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.syph_1_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.syph_2_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.syph_3_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.syph_4_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.syph_5_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.syph_6_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.naics_1_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.naics_2_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.naics_3_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.naics_4_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.naics_5_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.naics_6_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.bdc_1_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.bdc_2_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.bdc_3_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.bdc_4_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.bdc_5_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.bdc_6_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.sic_1_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.sic_2_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.sic_3_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.sic_4_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.sic_5_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.sic_6_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.caption_counter_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.vanity_city_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.bus_govt_indicator_Invalid,'ENUM','LENGTH','UNKNOWN')
          ,CHOOSE(le.latitude_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.longitude_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.lat_long_level_applied_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.record_use_indicator_Invalid,'ENUM','LENGTH','UNKNOWN')
          ,CHOOSE(le.email_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.stated_addr_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.stated_city_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.stated_postal_code_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.stated_bus_name_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.verification_flag_Invalid,'ENUM','LENGTH','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'record_id','book_number','pub_date','business_name','street_name','unit_designator','unit_number','city','province','postal_code','area_code','phone_number','syph_1','syph_2','syph_3','syph_4','syph_5','syph_6','naics_1','naics_2','naics_3','naics_4','naics_5','naics_6','bdc_1','bdc_2','bdc_3','bdc_4','bdc_5','bdc_6','sic_1','sic_2','sic_3','sic_4','sic_5','sic_6','caption_counter','vanity_city','bus_govt_indicator','latitude','longitude','lat_long_level_applied','record_use_indicator','email','stated_addr','stated_city','stated_postal_code','stated_bus_name','verification_flag','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_record_id','invalid_numeric','invalid_date','invalid_name','invalid_address','invalid_address','invalid_address','invalid_city','invalid_province','invalid_canadian_zip','invalid_area_code','invalid_phone','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_city','invalid_bus_govt_indicator','invalid_numeric','invalid_numeric','invalid_lat_long_level_applied','invalid_record_use_indicator','invalid_email','invalid_address','invalid_city','invalid_canadian_zip','invalid_name','invalid_verification_flag','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT32.StrType)le.record_id,(SALT32.StrType)le.book_number,(SALT32.StrType)le.pub_date,(SALT32.StrType)le.business_name,(SALT32.StrType)le.street_name,(SALT32.StrType)le.unit_designator,(SALT32.StrType)le.unit_number,(SALT32.StrType)le.city,(SALT32.StrType)le.province,(SALT32.StrType)le.postal_code,(SALT32.StrType)le.area_code,(SALT32.StrType)le.phone_number,(SALT32.StrType)le.syph_1,(SALT32.StrType)le.syph_2,(SALT32.StrType)le.syph_3,(SALT32.StrType)le.syph_4,(SALT32.StrType)le.syph_5,(SALT32.StrType)le.syph_6,(SALT32.StrType)le.naics_1,(SALT32.StrType)le.naics_2,(SALT32.StrType)le.naics_3,(SALT32.StrType)le.naics_4,(SALT32.StrType)le.naics_5,(SALT32.StrType)le.naics_6,(SALT32.StrType)le.bdc_1,(SALT32.StrType)le.bdc_2,(SALT32.StrType)le.bdc_3,(SALT32.StrType)le.bdc_4,(SALT32.StrType)le.bdc_5,(SALT32.StrType)le.bdc_6,(SALT32.StrType)le.sic_1,(SALT32.StrType)le.sic_2,(SALT32.StrType)le.sic_3,(SALT32.StrType)le.sic_4,(SALT32.StrType)le.sic_5,(SALT32.StrType)le.sic_6,(SALT32.StrType)le.caption_counter,(SALT32.StrType)le.vanity_city,(SALT32.StrType)le.bus_govt_indicator,(SALT32.StrType)le.latitude,(SALT32.StrType)le.longitude,(SALT32.StrType)le.lat_long_level_applied,(SALT32.StrType)le.record_use_indicator,(SALT32.StrType)le.email,(SALT32.StrType)le.stated_addr,(SALT32.StrType)le.stated_city,(SALT32.StrType)le.stated_postal_code,(SALT32.StrType)le.stated_bus_name,(SALT32.StrType)le.verification_flag,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,49,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10,UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(),STRING10 Src='UNK') := FUNCTION
    SALT32.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'record_id:invalid_record_id:ALLOW','record_id:invalid_record_id:LENGTH'
          ,'book_number:invalid_numeric:ALLOW'
          ,'pub_date:invalid_date:ALLOW','pub_date:invalid_date:LENGTH'
          ,'business_name:invalid_name:ALLOW','business_name:invalid_name:LENGTH'
          ,'street_name:invalid_address:ALLOW','street_name:invalid_address:LENGTH'
          ,'unit_designator:invalid_address:ALLOW','unit_designator:invalid_address:LENGTH'
          ,'unit_number:invalid_address:ALLOW','unit_number:invalid_address:LENGTH'
          ,'city:invalid_city:ALLOW','city:invalid_city:LENGTH'
          ,'province:invalid_province:ALLOW','province:invalid_province:LENGTH'
          ,'postal_code:invalid_canadian_zip:ALLOW','postal_code:invalid_canadian_zip:LENGTH'
          ,'area_code:invalid_area_code:ALLOW','area_code:invalid_area_code:LENGTH'
          ,'phone_number:invalid_phone:ALLOW','phone_number:invalid_phone:LENGTH'
          ,'syph_1:invalid_numeric:ALLOW'
          ,'syph_2:invalid_numeric:ALLOW'
          ,'syph_3:invalid_numeric:ALLOW'
          ,'syph_4:invalid_numeric:ALLOW'
          ,'syph_5:invalid_numeric:ALLOW'
          ,'syph_6:invalid_numeric:ALLOW'
          ,'naics_1:invalid_numeric:ALLOW'
          ,'naics_2:invalid_numeric:ALLOW'
          ,'naics_3:invalid_numeric:ALLOW'
          ,'naics_4:invalid_numeric:ALLOW'
          ,'naics_5:invalid_numeric:ALLOW'
          ,'naics_6:invalid_numeric:ALLOW'
          ,'bdc_1:invalid_numeric:ALLOW'
          ,'bdc_2:invalid_numeric:ALLOW'
          ,'bdc_3:invalid_numeric:ALLOW'
          ,'bdc_4:invalid_numeric:ALLOW'
          ,'bdc_5:invalid_numeric:ALLOW'
          ,'bdc_6:invalid_numeric:ALLOW'
          ,'sic_1:invalid_numeric:ALLOW'
          ,'sic_2:invalid_numeric:ALLOW'
          ,'sic_3:invalid_numeric:ALLOW'
          ,'sic_4:invalid_numeric:ALLOW'
          ,'sic_5:invalid_numeric:ALLOW'
          ,'sic_6:invalid_numeric:ALLOW'
          ,'caption_counter:invalid_numeric:ALLOW'
          ,'vanity_city:invalid_city:ALLOW','vanity_city:invalid_city:LENGTH'
          ,'bus_govt_indicator:invalid_bus_govt_indicator:ENUM','bus_govt_indicator:invalid_bus_govt_indicator:LENGTH'
          ,'latitude:invalid_numeric:ALLOW'
          ,'longitude:invalid_numeric:ALLOW'
          ,'lat_long_level_applied:invalid_lat_long_level_applied:ALLOW','lat_long_level_applied:invalid_lat_long_level_applied:LENGTH'
          ,'record_use_indicator:invalid_record_use_indicator:ENUM','record_use_indicator:invalid_record_use_indicator:LENGTH'
          ,'email:invalid_email:ALLOW'
          ,'stated_addr:invalid_address:ALLOW','stated_addr:invalid_address:LENGTH'
          ,'stated_city:invalid_city:ALLOW','stated_city:invalid_city:LENGTH'
          ,'stated_postal_code:invalid_canadian_zip:ALLOW','stated_postal_code:invalid_canadian_zip:LENGTH'
          ,'stated_bus_name:invalid_name:ALLOW','stated_bus_name:invalid_name:LENGTH'
          ,'verification_flag:invalid_verification_flag:ENUM','verification_flag:invalid_verification_flag:LENGTH','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,Axciom_Bus_Fields.InvalidMessage_record_id(1),Axciom_Bus_Fields.InvalidMessage_record_id(2)
          ,Axciom_Bus_Fields.InvalidMessage_book_number(1)
          ,Axciom_Bus_Fields.InvalidMessage_pub_date(1),Axciom_Bus_Fields.InvalidMessage_pub_date(2)
          ,Axciom_Bus_Fields.InvalidMessage_business_name(1),Axciom_Bus_Fields.InvalidMessage_business_name(2)
          ,Axciom_Bus_Fields.InvalidMessage_street_name(1),Axciom_Bus_Fields.InvalidMessage_street_name(2)
          ,Axciom_Bus_Fields.InvalidMessage_unit_designator(1),Axciom_Bus_Fields.InvalidMessage_unit_designator(2)
          ,Axciom_Bus_Fields.InvalidMessage_unit_number(1),Axciom_Bus_Fields.InvalidMessage_unit_number(2)
          ,Axciom_Bus_Fields.InvalidMessage_city(1),Axciom_Bus_Fields.InvalidMessage_city(2)
          ,Axciom_Bus_Fields.InvalidMessage_province(1),Axciom_Bus_Fields.InvalidMessage_province(2)
          ,Axciom_Bus_Fields.InvalidMessage_postal_code(1),Axciom_Bus_Fields.InvalidMessage_postal_code(2)
          ,Axciom_Bus_Fields.InvalidMessage_area_code(1),Axciom_Bus_Fields.InvalidMessage_area_code(2)
          ,Axciom_Bus_Fields.InvalidMessage_phone_number(1),Axciom_Bus_Fields.InvalidMessage_phone_number(2)
          ,Axciom_Bus_Fields.InvalidMessage_syph_1(1)
          ,Axciom_Bus_Fields.InvalidMessage_syph_2(1)
          ,Axciom_Bus_Fields.InvalidMessage_syph_3(1)
          ,Axciom_Bus_Fields.InvalidMessage_syph_4(1)
          ,Axciom_Bus_Fields.InvalidMessage_syph_5(1)
          ,Axciom_Bus_Fields.InvalidMessage_syph_6(1)
          ,Axciom_Bus_Fields.InvalidMessage_naics_1(1)
          ,Axciom_Bus_Fields.InvalidMessage_naics_2(1)
          ,Axciom_Bus_Fields.InvalidMessage_naics_3(1)
          ,Axciom_Bus_Fields.InvalidMessage_naics_4(1)
          ,Axciom_Bus_Fields.InvalidMessage_naics_5(1)
          ,Axciom_Bus_Fields.InvalidMessage_naics_6(1)
          ,Axciom_Bus_Fields.InvalidMessage_bdc_1(1)
          ,Axciom_Bus_Fields.InvalidMessage_bdc_2(1)
          ,Axciom_Bus_Fields.InvalidMessage_bdc_3(1)
          ,Axciom_Bus_Fields.InvalidMessage_bdc_4(1)
          ,Axciom_Bus_Fields.InvalidMessage_bdc_5(1)
          ,Axciom_Bus_Fields.InvalidMessage_bdc_6(1)
          ,Axciom_Bus_Fields.InvalidMessage_sic_1(1)
          ,Axciom_Bus_Fields.InvalidMessage_sic_2(1)
          ,Axciom_Bus_Fields.InvalidMessage_sic_3(1)
          ,Axciom_Bus_Fields.InvalidMessage_sic_4(1)
          ,Axciom_Bus_Fields.InvalidMessage_sic_5(1)
          ,Axciom_Bus_Fields.InvalidMessage_sic_6(1)
          ,Axciom_Bus_Fields.InvalidMessage_caption_counter(1)
          ,Axciom_Bus_Fields.InvalidMessage_vanity_city(1),Axciom_Bus_Fields.InvalidMessage_vanity_city(2)
          ,Axciom_Bus_Fields.InvalidMessage_bus_govt_indicator(1),Axciom_Bus_Fields.InvalidMessage_bus_govt_indicator(2)
          ,Axciom_Bus_Fields.InvalidMessage_latitude(1)
          ,Axciom_Bus_Fields.InvalidMessage_longitude(1)
          ,Axciom_Bus_Fields.InvalidMessage_lat_long_level_applied(1),Axciom_Bus_Fields.InvalidMessage_lat_long_level_applied(2)
          ,Axciom_Bus_Fields.InvalidMessage_record_use_indicator(1),Axciom_Bus_Fields.InvalidMessage_record_use_indicator(2)
          ,Axciom_Bus_Fields.InvalidMessage_email(1)
          ,Axciom_Bus_Fields.InvalidMessage_stated_addr(1),Axciom_Bus_Fields.InvalidMessage_stated_addr(2)
          ,Axciom_Bus_Fields.InvalidMessage_stated_city(1),Axciom_Bus_Fields.InvalidMessage_stated_city(2)
          ,Axciom_Bus_Fields.InvalidMessage_stated_postal_code(1),Axciom_Bus_Fields.InvalidMessage_stated_postal_code(2)
          ,Axciom_Bus_Fields.InvalidMessage_stated_bus_name(1),Axciom_Bus_Fields.InvalidMessage_stated_bus_name(2)
          ,Axciom_Bus_Fields.InvalidMessage_verification_flag(1),Axciom_Bus_Fields.InvalidMessage_verification_flag(2),'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.record_id_ALLOW_ErrorCount,le.record_id_LENGTH_ErrorCount
          ,le.book_number_ALLOW_ErrorCount
          ,le.pub_date_ALLOW_ErrorCount,le.pub_date_LENGTH_ErrorCount
          ,le.business_name_ALLOW_ErrorCount,le.business_name_LENGTH_ErrorCount
          ,le.street_name_ALLOW_ErrorCount,le.street_name_LENGTH_ErrorCount
          ,le.unit_designator_ALLOW_ErrorCount,le.unit_designator_LENGTH_ErrorCount
          ,le.unit_number_ALLOW_ErrorCount,le.unit_number_LENGTH_ErrorCount
          ,le.city_ALLOW_ErrorCount,le.city_LENGTH_ErrorCount
          ,le.province_ALLOW_ErrorCount,le.province_LENGTH_ErrorCount
          ,le.postal_code_ALLOW_ErrorCount,le.postal_code_LENGTH_ErrorCount
          ,le.area_code_ALLOW_ErrorCount,le.area_code_LENGTH_ErrorCount
          ,le.phone_number_ALLOW_ErrorCount,le.phone_number_LENGTH_ErrorCount
          ,le.syph_1_ALLOW_ErrorCount
          ,le.syph_2_ALLOW_ErrorCount
          ,le.syph_3_ALLOW_ErrorCount
          ,le.syph_4_ALLOW_ErrorCount
          ,le.syph_5_ALLOW_ErrorCount
          ,le.syph_6_ALLOW_ErrorCount
          ,le.naics_1_ALLOW_ErrorCount
          ,le.naics_2_ALLOW_ErrorCount
          ,le.naics_3_ALLOW_ErrorCount
          ,le.naics_4_ALLOW_ErrorCount
          ,le.naics_5_ALLOW_ErrorCount
          ,le.naics_6_ALLOW_ErrorCount
          ,le.bdc_1_ALLOW_ErrorCount
          ,le.bdc_2_ALLOW_ErrorCount
          ,le.bdc_3_ALLOW_ErrorCount
          ,le.bdc_4_ALLOW_ErrorCount
          ,le.bdc_5_ALLOW_ErrorCount
          ,le.bdc_6_ALLOW_ErrorCount
          ,le.sic_1_ALLOW_ErrorCount
          ,le.sic_2_ALLOW_ErrorCount
          ,le.sic_3_ALLOW_ErrorCount
          ,le.sic_4_ALLOW_ErrorCount
          ,le.sic_5_ALLOW_ErrorCount
          ,le.sic_6_ALLOW_ErrorCount
          ,le.caption_counter_ALLOW_ErrorCount
          ,le.vanity_city_ALLOW_ErrorCount,le.vanity_city_LENGTH_ErrorCount
          ,le.bus_govt_indicator_ENUM_ErrorCount,le.bus_govt_indicator_LENGTH_ErrorCount
          ,le.latitude_ALLOW_ErrorCount
          ,le.longitude_ALLOW_ErrorCount
          ,le.lat_long_level_applied_ALLOW_ErrorCount,le.lat_long_level_applied_LENGTH_ErrorCount
          ,le.record_use_indicator_ENUM_ErrorCount,le.record_use_indicator_LENGTH_ErrorCount
          ,le.email_ALLOW_ErrorCount
          ,le.stated_addr_ALLOW_ErrorCount,le.stated_addr_LENGTH_ErrorCount
          ,le.stated_city_ALLOW_ErrorCount,le.stated_city_LENGTH_ErrorCount
          ,le.stated_postal_code_ALLOW_ErrorCount,le.stated_postal_code_LENGTH_ErrorCount
          ,le.stated_bus_name_ALLOW_ErrorCount,le.stated_bus_name_LENGTH_ErrorCount
          ,le.verification_flag_ENUM_ErrorCount,le.verification_flag_LENGTH_ErrorCount,0);
      SELF.rulepcnt := 100 * CHOOSE(c
          ,le.record_id_ALLOW_ErrorCount,le.record_id_LENGTH_ErrorCount
          ,le.book_number_ALLOW_ErrorCount
          ,le.pub_date_ALLOW_ErrorCount,le.pub_date_LENGTH_ErrorCount
          ,le.business_name_ALLOW_ErrorCount,le.business_name_LENGTH_ErrorCount
          ,le.street_name_ALLOW_ErrorCount,le.street_name_LENGTH_ErrorCount
          ,le.unit_designator_ALLOW_ErrorCount,le.unit_designator_LENGTH_ErrorCount
          ,le.unit_number_ALLOW_ErrorCount,le.unit_number_LENGTH_ErrorCount
          ,le.city_ALLOW_ErrorCount,le.city_LENGTH_ErrorCount
          ,le.province_ALLOW_ErrorCount,le.province_LENGTH_ErrorCount
          ,le.postal_code_ALLOW_ErrorCount,le.postal_code_LENGTH_ErrorCount
          ,le.area_code_ALLOW_ErrorCount,le.area_code_LENGTH_ErrorCount
          ,le.phone_number_ALLOW_ErrorCount,le.phone_number_LENGTH_ErrorCount
          ,le.syph_1_ALLOW_ErrorCount
          ,le.syph_2_ALLOW_ErrorCount
          ,le.syph_3_ALLOW_ErrorCount
          ,le.syph_4_ALLOW_ErrorCount
          ,le.syph_5_ALLOW_ErrorCount
          ,le.syph_6_ALLOW_ErrorCount
          ,le.naics_1_ALLOW_ErrorCount
          ,le.naics_2_ALLOW_ErrorCount
          ,le.naics_3_ALLOW_ErrorCount
          ,le.naics_4_ALLOW_ErrorCount
          ,le.naics_5_ALLOW_ErrorCount
          ,le.naics_6_ALLOW_ErrorCount
          ,le.bdc_1_ALLOW_ErrorCount
          ,le.bdc_2_ALLOW_ErrorCount
          ,le.bdc_3_ALLOW_ErrorCount
          ,le.bdc_4_ALLOW_ErrorCount
          ,le.bdc_5_ALLOW_ErrorCount
          ,le.bdc_6_ALLOW_ErrorCount
          ,le.sic_1_ALLOW_ErrorCount
          ,le.sic_2_ALLOW_ErrorCount
          ,le.sic_3_ALLOW_ErrorCount
          ,le.sic_4_ALLOW_ErrorCount
          ,le.sic_5_ALLOW_ErrorCount
          ,le.sic_6_ALLOW_ErrorCount
          ,le.caption_counter_ALLOW_ErrorCount
          ,le.vanity_city_ALLOW_ErrorCount,le.vanity_city_LENGTH_ErrorCount
          ,le.bus_govt_indicator_ENUM_ErrorCount,le.bus_govt_indicator_LENGTH_ErrorCount
          ,le.latitude_ALLOW_ErrorCount
          ,le.longitude_ALLOW_ErrorCount
          ,le.lat_long_level_applied_ALLOW_ErrorCount,le.lat_long_level_applied_LENGTH_ErrorCount
          ,le.record_use_indicator_ENUM_ErrorCount,le.record_use_indicator_LENGTH_ErrorCount
          ,le.email_ALLOW_ErrorCount
          ,le.stated_addr_ALLOW_ErrorCount,le.stated_addr_LENGTH_ErrorCount
          ,le.stated_city_ALLOW_ErrorCount,le.stated_city_LENGTH_ErrorCount
          ,le.stated_postal_code_ALLOW_ErrorCount,le.stated_postal_code_LENGTH_ErrorCount
          ,le.stated_bus_name_ALLOW_ErrorCount,le.stated_bus_name_LENGTH_ErrorCount
          ,le.verification_flag_ENUM_ErrorCount,le.verification_flag_LENGTH_ErrorCount,0) / le.TotalCnt + 0.5;
    END;
    SummaryInfo := NORMALIZE(SummaryStats,69,Into(LEFT,COUNTER));
    orb_r := RECORD
      AllErrors.Src;
      STRING RuleDesc := TRIM(AllErrors.FieldName)+':'+TRIM(AllErrors.FieldType)+':'+AllErrors.ErrorType;
      STRING ErrorMessage := TRIM(AllErrors.errormessage);
      SALT32.StrType RawCodeMissing := AllErrors.FieldContents;
    END;
    tab := TABLE(AllErrors,orb_r);
    orb_sum := TABLE(tab,{src,ruledesc,ErrorMessage,rawcodemissing,rawcodemissingcnt := COUNT(GROUP)},src,ruledesc,ErrorMessage,rawcodemissing,MERGE);
    gt := GROUP(TOPN(GROUP(orb_sum,src,ruledesc,ALL),examples,-rawcodemissingcnt));
    SALT32.ScrubsOrbitLayout jn(SummaryInfo le, gt ri) := TRANSFORM
      SELF.rawcodemissing := ri.rawcodemissing;
      SELF.rawcodemissingcnt := ri.rawcodemissingcnt;
      SELF := le;
    END;
    j := JOIN(SummaryInfo,gt,LEFT.SourceCode=RIGHT.SRC AND LEFT.ruledesc=RIGHT.ruledesc,jn(LEFT,RIGHT),HASH,LEFT OUTER);
    RETURN IF(examples>0,j,SummaryInfo);
  END;
END;
END;
