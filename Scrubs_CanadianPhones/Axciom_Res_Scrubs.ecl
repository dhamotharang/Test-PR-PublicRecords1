IMPORT ut,SALT32;
EXPORT Axciom_Res_Scrubs := MODULE
// The module to handle the case where no scrubs exist
  EXPORT  Expanded_Layout := RECORD(Axciom_Res_Layout_CanadianPhones)
    UNSIGNED1 record_id_Invalid;
    UNSIGNED1 book_number_Invalid;
    UNSIGNED1 pub_date_Invalid;
    UNSIGNED1 section_number_Invalid;
    UNSIGNED1 page_number_Invalid;
    UNSIGNED1 status_code_Invalid;
    UNSIGNED1 load_date_Invalid;
    UNSIGNED1 section_type_Invalid;
    UNSIGNED1 first_name_Invalid;
    UNSIGNED1 middle_initial_Invalid;
    UNSIGNED1 last_name_Invalid;
    UNSIGNED1 generational_suffix_Invalid;
    UNSIGNED1 street_number_Invalid;
    UNSIGNED1 street_name_Invalid;
    UNSIGNED1 unit_number_Invalid;
    UNSIGNED1 unit_designator_Invalid;
    UNSIGNED1 city_Invalid;
    UNSIGNED1 province_Invalid;
    UNSIGNED1 postal_code_Invalid;
    UNSIGNED1 area_code_Invalid;
    UNSIGNED1 phone_number_Invalid;
    UNSIGNED1 vanity_city_name_Invalid;
    UNSIGNED1 latitude_Invalid;
    UNSIGNED1 longitude_Invalid;
    UNSIGNED1 lat_long_level_applied_Invalid;
    UNSIGNED1 record_use_indicator_Invalid;
    UNSIGNED1 email_Invalid;
    UNSIGNED1 stated_address_Invalid;
    UNSIGNED1 stated_city_Invalid;
    UNSIGNED1 stated_postal_code_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Axciom_Res_Layout_CanadianPhones)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(Axciom_Res_Layout_CanadianPhones) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.record_id_Invalid := Axciom_Res_Fields.InValid_record_id((SALT32.StrType)le.record_id);
    SELF.book_number_Invalid := Axciom_Res_Fields.InValid_book_number((SALT32.StrType)le.book_number);
    SELF.pub_date_Invalid := Axciom_Res_Fields.InValid_pub_date((SALT32.StrType)le.pub_date);
    SELF.section_number_Invalid := Axciom_Res_Fields.InValid_section_number((SALT32.StrType)le.section_number);
    SELF.page_number_Invalid := Axciom_Res_Fields.InValid_page_number((SALT32.StrType)le.page_number);
    SELF.status_code_Invalid := Axciom_Res_Fields.InValid_status_code((SALT32.StrType)le.status_code);
    SELF.load_date_Invalid := Axciom_Res_Fields.InValid_load_date((SALT32.StrType)le.load_date);
    SELF.section_type_Invalid := Axciom_Res_Fields.InValid_section_type((SALT32.StrType)le.section_type);
    SELF.first_name_Invalid := Axciom_Res_Fields.InValid_first_name((SALT32.StrType)le.first_name);
    SELF.middle_initial_Invalid := Axciom_Res_Fields.InValid_middle_initial((SALT32.StrType)le.middle_initial);
    SELF.last_name_Invalid := Axciom_Res_Fields.InValid_last_name((SALT32.StrType)le.last_name);
    SELF.generational_suffix_Invalid := Axciom_Res_Fields.InValid_generational_suffix((SALT32.StrType)le.generational_suffix);
    SELF.street_number_Invalid := Axciom_Res_Fields.InValid_street_number((SALT32.StrType)le.street_number);
    SELF.street_name_Invalid := Axciom_Res_Fields.InValid_street_name((SALT32.StrType)le.street_name);
    SELF.unit_number_Invalid := Axciom_Res_Fields.InValid_unit_number((SALT32.StrType)le.unit_number);
    SELF.unit_designator_Invalid := Axciom_Res_Fields.InValid_unit_designator((SALT32.StrType)le.unit_designator);
    SELF.city_Invalid := Axciom_Res_Fields.InValid_city((SALT32.StrType)le.city);
    SELF.province_Invalid := Axciom_Res_Fields.InValid_province((SALT32.StrType)le.province);
    SELF.postal_code_Invalid := Axciom_Res_Fields.InValid_postal_code((SALT32.StrType)le.postal_code);
    SELF.area_code_Invalid := Axciom_Res_Fields.InValid_area_code((SALT32.StrType)le.area_code);
    SELF.phone_number_Invalid := Axciom_Res_Fields.InValid_phone_number((SALT32.StrType)le.phone_number);
    SELF.vanity_city_name_Invalid := Axciom_Res_Fields.InValid_vanity_city_name((SALT32.StrType)le.vanity_city_name);
    SELF.latitude_Invalid := Axciom_Res_Fields.InValid_latitude((SALT32.StrType)le.latitude);
    SELF.longitude_Invalid := Axciom_Res_Fields.InValid_longitude((SALT32.StrType)le.longitude);
    SELF.lat_long_level_applied_Invalid := Axciom_Res_Fields.InValid_lat_long_level_applied((SALT32.StrType)le.lat_long_level_applied);
    SELF.record_use_indicator_Invalid := Axciom_Res_Fields.InValid_record_use_indicator((SALT32.StrType)le.record_use_indicator);
    SELF.email_Invalid := Axciom_Res_Fields.InValid_email((SALT32.StrType)le.email);
    SELF.stated_address_Invalid := Axciom_Res_Fields.InValid_stated_address((SALT32.StrType)le.stated_address);
    SELF.stated_city_Invalid := Axciom_Res_Fields.InValid_stated_city((SALT32.StrType)le.stated_city);
    SELF.stated_postal_code_Invalid := Axciom_Res_Fields.InValid_stated_postal_code((SALT32.StrType)le.stated_postal_code);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Axciom_Res_Layout_CanadianPhones);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.record_id_Invalid << 0 ) + ( le.book_number_Invalid << 2 ) + ( le.pub_date_Invalid << 3 ) + ( le.section_number_Invalid << 5 ) + ( le.page_number_Invalid << 6 ) + ( le.status_code_Invalid << 7 ) + ( le.load_date_Invalid << 9 ) + ( le.section_type_Invalid << 11 ) + ( le.first_name_Invalid << 13 ) + ( le.middle_initial_Invalid << 15 ) + ( le.last_name_Invalid << 17 ) + ( le.generational_suffix_Invalid << 19 ) + ( le.street_number_Invalid << 21 ) + ( le.street_name_Invalid << 23 ) + ( le.unit_number_Invalid << 25 ) + ( le.unit_designator_Invalid << 27 ) + ( le.city_Invalid << 29 ) + ( le.province_Invalid << 31 ) + ( le.postal_code_Invalid << 33 ) + ( le.area_code_Invalid << 35 ) + ( le.phone_number_Invalid << 37 ) + ( le.vanity_city_name_Invalid << 39 ) + ( le.latitude_Invalid << 41 ) + ( le.longitude_Invalid << 42 ) + ( le.lat_long_level_applied_Invalid << 43 ) + ( le.record_use_indicator_Invalid << 45 ) + ( le.email_Invalid << 47 ) + ( le.stated_address_Invalid << 48 ) + ( le.stated_city_Invalid << 50 ) + ( le.stated_postal_code_Invalid << 52 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Axciom_Res_Layout_CanadianPhones);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.record_id_Invalid := (le.ScrubsBits1 >> 0) & 3;
    SELF.book_number_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.pub_date_Invalid := (le.ScrubsBits1 >> 3) & 3;
    SELF.section_number_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.page_number_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.status_code_Invalid := (le.ScrubsBits1 >> 7) & 3;
    SELF.load_date_Invalid := (le.ScrubsBits1 >> 9) & 3;
    SELF.section_type_Invalid := (le.ScrubsBits1 >> 11) & 3;
    SELF.first_name_Invalid := (le.ScrubsBits1 >> 13) & 3;
    SELF.middle_initial_Invalid := (le.ScrubsBits1 >> 15) & 3;
    SELF.last_name_Invalid := (le.ScrubsBits1 >> 17) & 3;
    SELF.generational_suffix_Invalid := (le.ScrubsBits1 >> 19) & 3;
    SELF.street_number_Invalid := (le.ScrubsBits1 >> 21) & 3;
    SELF.street_name_Invalid := (le.ScrubsBits1 >> 23) & 3;
    SELF.unit_number_Invalid := (le.ScrubsBits1 >> 25) & 3;
    SELF.unit_designator_Invalid := (le.ScrubsBits1 >> 27) & 3;
    SELF.city_Invalid := (le.ScrubsBits1 >> 29) & 3;
    SELF.province_Invalid := (le.ScrubsBits1 >> 31) & 3;
    SELF.postal_code_Invalid := (le.ScrubsBits1 >> 33) & 3;
    SELF.area_code_Invalid := (le.ScrubsBits1 >> 35) & 3;
    SELF.phone_number_Invalid := (le.ScrubsBits1 >> 37) & 3;
    SELF.vanity_city_name_Invalid := (le.ScrubsBits1 >> 39) & 3;
    SELF.latitude_Invalid := (le.ScrubsBits1 >> 41) & 1;
    SELF.longitude_Invalid := (le.ScrubsBits1 >> 42) & 1;
    SELF.lat_long_level_applied_Invalid := (le.ScrubsBits1 >> 43) & 3;
    SELF.record_use_indicator_Invalid := (le.ScrubsBits1 >> 45) & 3;
    SELF.email_Invalid := (le.ScrubsBits1 >> 47) & 1;
    SELF.stated_address_Invalid := (le.ScrubsBits1 >> 48) & 3;
    SELF.stated_city_Invalid := (le.ScrubsBits1 >> 50) & 3;
    SELF.stated_postal_code_Invalid := (le.ScrubsBits1 >> 52) & 3;
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
    section_number_ALLOW_ErrorCount := COUNT(GROUP,h.section_number_Invalid=1);
    page_number_ALLOW_ErrorCount := COUNT(GROUP,h.page_number_Invalid=1);
    status_code_ALLOW_ErrorCount := COUNT(GROUP,h.status_code_Invalid=1);
    status_code_LENGTH_ErrorCount := COUNT(GROUP,h.status_code_Invalid=2);
    status_code_Total_ErrorCount := COUNT(GROUP,h.status_code_Invalid>0);
    load_date_ALLOW_ErrorCount := COUNT(GROUP,h.load_date_Invalid=1);
    load_date_LENGTH_ErrorCount := COUNT(GROUP,h.load_date_Invalid=2);
    load_date_Total_ErrorCount := COUNT(GROUP,h.load_date_Invalid>0);
    section_type_ENUM_ErrorCount := COUNT(GROUP,h.section_type_Invalid=1);
    section_type_LENGTH_ErrorCount := COUNT(GROUP,h.section_type_Invalid=2);
    section_type_Total_ErrorCount := COUNT(GROUP,h.section_type_Invalid>0);
    first_name_ALLOW_ErrorCount := COUNT(GROUP,h.first_name_Invalid=1);
    first_name_LENGTH_ErrorCount := COUNT(GROUP,h.first_name_Invalid=2);
    first_name_Total_ErrorCount := COUNT(GROUP,h.first_name_Invalid>0);
    middle_initial_ALLOW_ErrorCount := COUNT(GROUP,h.middle_initial_Invalid=1);
    middle_initial_LENGTH_ErrorCount := COUNT(GROUP,h.middle_initial_Invalid=2);
    middle_initial_Total_ErrorCount := COUNT(GROUP,h.middle_initial_Invalid>0);
    last_name_ALLOW_ErrorCount := COUNT(GROUP,h.last_name_Invalid=1);
    last_name_LENGTH_ErrorCount := COUNT(GROUP,h.last_name_Invalid=2);
    last_name_Total_ErrorCount := COUNT(GROUP,h.last_name_Invalid>0);
    generational_suffix_ALLOW_ErrorCount := COUNT(GROUP,h.generational_suffix_Invalid=1);
    generational_suffix_LENGTH_ErrorCount := COUNT(GROUP,h.generational_suffix_Invalid=2);
    generational_suffix_Total_ErrorCount := COUNT(GROUP,h.generational_suffix_Invalid>0);
    street_number_ALLOW_ErrorCount := COUNT(GROUP,h.street_number_Invalid=1);
    street_number_LENGTH_ErrorCount := COUNT(GROUP,h.street_number_Invalid=2);
    street_number_Total_ErrorCount := COUNT(GROUP,h.street_number_Invalid>0);
    street_name_ALLOW_ErrorCount := COUNT(GROUP,h.street_name_Invalid=1);
    street_name_LENGTH_ErrorCount := COUNT(GROUP,h.street_name_Invalid=2);
    street_name_Total_ErrorCount := COUNT(GROUP,h.street_name_Invalid>0);
    unit_number_ALLOW_ErrorCount := COUNT(GROUP,h.unit_number_Invalid=1);
    unit_number_LENGTH_ErrorCount := COUNT(GROUP,h.unit_number_Invalid=2);
    unit_number_Total_ErrorCount := COUNT(GROUP,h.unit_number_Invalid>0);
    unit_designator_ALLOW_ErrorCount := COUNT(GROUP,h.unit_designator_Invalid=1);
    unit_designator_LENGTH_ErrorCount := COUNT(GROUP,h.unit_designator_Invalid=2);
    unit_designator_Total_ErrorCount := COUNT(GROUP,h.unit_designator_Invalid>0);
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
    vanity_city_name_ALLOW_ErrorCount := COUNT(GROUP,h.vanity_city_name_Invalid=1);
    vanity_city_name_LENGTH_ErrorCount := COUNT(GROUP,h.vanity_city_name_Invalid=2);
    vanity_city_name_Total_ErrorCount := COUNT(GROUP,h.vanity_city_name_Invalid>0);
    latitude_ALLOW_ErrorCount := COUNT(GROUP,h.latitude_Invalid=1);
    longitude_ALLOW_ErrorCount := COUNT(GROUP,h.longitude_Invalid=1);
    lat_long_level_applied_ALLOW_ErrorCount := COUNT(GROUP,h.lat_long_level_applied_Invalid=1);
    lat_long_level_applied_LENGTH_ErrorCount := COUNT(GROUP,h.lat_long_level_applied_Invalid=2);
    lat_long_level_applied_Total_ErrorCount := COUNT(GROUP,h.lat_long_level_applied_Invalid>0);
    record_use_indicator_ENUM_ErrorCount := COUNT(GROUP,h.record_use_indicator_Invalid=1);
    record_use_indicator_LENGTH_ErrorCount := COUNT(GROUP,h.record_use_indicator_Invalid=2);
    record_use_indicator_Total_ErrorCount := COUNT(GROUP,h.record_use_indicator_Invalid>0);
    email_ALLOW_ErrorCount := COUNT(GROUP,h.email_Invalid=1);
    stated_address_ALLOW_ErrorCount := COUNT(GROUP,h.stated_address_Invalid=1);
    stated_address_LENGTH_ErrorCount := COUNT(GROUP,h.stated_address_Invalid=2);
    stated_address_Total_ErrorCount := COUNT(GROUP,h.stated_address_Invalid>0);
    stated_city_ALLOW_ErrorCount := COUNT(GROUP,h.stated_city_Invalid=1);
    stated_city_LENGTH_ErrorCount := COUNT(GROUP,h.stated_city_Invalid=2);
    stated_city_Total_ErrorCount := COUNT(GROUP,h.stated_city_Invalid>0);
    stated_postal_code_ALLOW_ErrorCount := COUNT(GROUP,h.stated_postal_code_Invalid=1);
    stated_postal_code_LENGTH_ErrorCount := COUNT(GROUP,h.stated_postal_code_Invalid=2);
    stated_postal_code_Total_ErrorCount := COUNT(GROUP,h.stated_postal_code_Invalid>0);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.record_id_Invalid,le.book_number_Invalid,le.pub_date_Invalid,le.section_number_Invalid,le.page_number_Invalid,le.status_code_Invalid,le.load_date_Invalid,le.section_type_Invalid,le.first_name_Invalid,le.middle_initial_Invalid,le.last_name_Invalid,le.generational_suffix_Invalid,le.street_number_Invalid,le.street_name_Invalid,le.unit_number_Invalid,le.unit_designator_Invalid,le.city_Invalid,le.province_Invalid,le.postal_code_Invalid,le.area_code_Invalid,le.phone_number_Invalid,le.vanity_city_name_Invalid,le.latitude_Invalid,le.longitude_Invalid,le.lat_long_level_applied_Invalid,le.record_use_indicator_Invalid,le.email_Invalid,le.stated_address_Invalid,le.stated_city_Invalid,le.stated_postal_code_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Axciom_Res_Fields.InvalidMessage_record_id(le.record_id_Invalid),Axciom_Res_Fields.InvalidMessage_book_number(le.book_number_Invalid),Axciom_Res_Fields.InvalidMessage_pub_date(le.pub_date_Invalid),Axciom_Res_Fields.InvalidMessage_section_number(le.section_number_Invalid),Axciom_Res_Fields.InvalidMessage_page_number(le.page_number_Invalid),Axciom_Res_Fields.InvalidMessage_status_code(le.status_code_Invalid),Axciom_Res_Fields.InvalidMessage_load_date(le.load_date_Invalid),Axciom_Res_Fields.InvalidMessage_section_type(le.section_type_Invalid),Axciom_Res_Fields.InvalidMessage_first_name(le.first_name_Invalid),Axciom_Res_Fields.InvalidMessage_middle_initial(le.middle_initial_Invalid),Axciom_Res_Fields.InvalidMessage_last_name(le.last_name_Invalid),Axciom_Res_Fields.InvalidMessage_generational_suffix(le.generational_suffix_Invalid),Axciom_Res_Fields.InvalidMessage_street_number(le.street_number_Invalid),Axciom_Res_Fields.InvalidMessage_street_name(le.street_name_Invalid),Axciom_Res_Fields.InvalidMessage_unit_number(le.unit_number_Invalid),Axciom_Res_Fields.InvalidMessage_unit_designator(le.unit_designator_Invalid),Axciom_Res_Fields.InvalidMessage_city(le.city_Invalid),Axciom_Res_Fields.InvalidMessage_province(le.province_Invalid),Axciom_Res_Fields.InvalidMessage_postal_code(le.postal_code_Invalid),Axciom_Res_Fields.InvalidMessage_area_code(le.area_code_Invalid),Axciom_Res_Fields.InvalidMessage_phone_number(le.phone_number_Invalid),Axciom_Res_Fields.InvalidMessage_vanity_city_name(le.vanity_city_name_Invalid),Axciom_Res_Fields.InvalidMessage_latitude(le.latitude_Invalid),Axciom_Res_Fields.InvalidMessage_longitude(le.longitude_Invalid),Axciom_Res_Fields.InvalidMessage_lat_long_level_applied(le.lat_long_level_applied_Invalid),Axciom_Res_Fields.InvalidMessage_record_use_indicator(le.record_use_indicator_Invalid),Axciom_Res_Fields.InvalidMessage_email(le.email_Invalid),Axciom_Res_Fields.InvalidMessage_stated_address(le.stated_address_Invalid),Axciom_Res_Fields.InvalidMessage_stated_city(le.stated_city_Invalid),Axciom_Res_Fields.InvalidMessage_stated_postal_code(le.stated_postal_code_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.record_id_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.book_number_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.pub_date_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.section_number_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.page_number_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.status_code_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.load_date_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.section_type_Invalid,'ENUM','LENGTH','UNKNOWN')
          ,CHOOSE(le.first_name_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.middle_initial_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.last_name_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.generational_suffix_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.street_number_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.street_name_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.unit_number_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.unit_designator_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.city_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.province_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.postal_code_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.area_code_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.phone_number_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.vanity_city_name_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.latitude_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.longitude_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.lat_long_level_applied_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.record_use_indicator_Invalid,'ENUM','LENGTH','UNKNOWN')
          ,CHOOSE(le.email_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.stated_address_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.stated_city_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.stated_postal_code_Invalid,'ALLOW','LENGTH','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'record_id','book_number','pub_date','section_number','page_number','status_code','load_date','section_type','first_name','middle_initial','last_name','generational_suffix','street_number','street_name','unit_number','unit_designator','city','province','postal_code','area_code','phone_number','vanity_city_name','latitude','longitude','lat_long_level_applied','record_use_indicator','email','stated_address','stated_city','stated_postal_code','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_record_id','invalid_numeric','invalid_date','invalid_numeric','invalid_numeric','invalid_status_code','invalid_date1','invalid_section_type','invalid_name','invalid_mid_init','invalid_name','invalid_alpha','invalid_alnum','invalid_address','invalid_address','invalid_address','invalid_city','invalid_province','invalid_canadian_zip','invalid_area_code','invalid_phone','invalid_city','invalid_numeric','invalid_numeric','invalid_lat_long_level_applied','invalid_record_use_indicator','invalid_email','invalid_address','invalid_city','invalid_canadian_zip','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT32.StrType)le.record_id,(SALT32.StrType)le.book_number,(SALT32.StrType)le.pub_date,(SALT32.StrType)le.section_number,(SALT32.StrType)le.page_number,(SALT32.StrType)le.status_code,(SALT32.StrType)le.load_date,(SALT32.StrType)le.section_type,(SALT32.StrType)le.first_name,(SALT32.StrType)le.middle_initial,(SALT32.StrType)le.last_name,(SALT32.StrType)le.generational_suffix,(SALT32.StrType)le.street_number,(SALT32.StrType)le.street_name,(SALT32.StrType)le.unit_number,(SALT32.StrType)le.unit_designator,(SALT32.StrType)le.city,(SALT32.StrType)le.province,(SALT32.StrType)le.postal_code,(SALT32.StrType)le.area_code,(SALT32.StrType)le.phone_number,(SALT32.StrType)le.vanity_city_name,(SALT32.StrType)le.latitude,(SALT32.StrType)le.longitude,(SALT32.StrType)le.lat_long_level_applied,(SALT32.StrType)le.record_use_indicator,(SALT32.StrType)le.email,(SALT32.StrType)le.stated_address,(SALT32.StrType)le.stated_city,(SALT32.StrType)le.stated_postal_code,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,30,Into(LEFT,COUNTER));
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
          ,'section_number:invalid_numeric:ALLOW'
          ,'page_number:invalid_numeric:ALLOW'
          ,'status_code:invalid_status_code:ALLOW','status_code:invalid_status_code:LENGTH'
          ,'load_date:invalid_date1:ALLOW','load_date:invalid_date1:LENGTH'
          ,'section_type:invalid_section_type:ENUM','section_type:invalid_section_type:LENGTH'
          ,'first_name:invalid_name:ALLOW','first_name:invalid_name:LENGTH'
          ,'middle_initial:invalid_mid_init:ALLOW','middle_initial:invalid_mid_init:LENGTH'
          ,'last_name:invalid_name:ALLOW','last_name:invalid_name:LENGTH'
          ,'generational_suffix:invalid_alpha:ALLOW','generational_suffix:invalid_alpha:LENGTH'
          ,'street_number:invalid_alnum:ALLOW','street_number:invalid_alnum:LENGTH'
          ,'street_name:invalid_address:ALLOW','street_name:invalid_address:LENGTH'
          ,'unit_number:invalid_address:ALLOW','unit_number:invalid_address:LENGTH'
          ,'unit_designator:invalid_address:ALLOW','unit_designator:invalid_address:LENGTH'
          ,'city:invalid_city:ALLOW','city:invalid_city:LENGTH'
          ,'province:invalid_province:ALLOW','province:invalid_province:LENGTH'
          ,'postal_code:invalid_canadian_zip:ALLOW','postal_code:invalid_canadian_zip:LENGTH'
          ,'area_code:invalid_area_code:ALLOW','area_code:invalid_area_code:LENGTH'
          ,'phone_number:invalid_phone:ALLOW','phone_number:invalid_phone:LENGTH'
          ,'vanity_city_name:invalid_city:ALLOW','vanity_city_name:invalid_city:LENGTH'
          ,'latitude:invalid_numeric:ALLOW'
          ,'longitude:invalid_numeric:ALLOW'
          ,'lat_long_level_applied:invalid_lat_long_level_applied:ALLOW','lat_long_level_applied:invalid_lat_long_level_applied:LENGTH'
          ,'record_use_indicator:invalid_record_use_indicator:ENUM','record_use_indicator:invalid_record_use_indicator:LENGTH'
          ,'email:invalid_email:ALLOW'
          ,'stated_address:invalid_address:ALLOW','stated_address:invalid_address:LENGTH'
          ,'stated_city:invalid_city:ALLOW','stated_city:invalid_city:LENGTH'
          ,'stated_postal_code:invalid_canadian_zip:ALLOW','stated_postal_code:invalid_canadian_zip:LENGTH','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,Axciom_Res_Fields.InvalidMessage_record_id(1),Axciom_Res_Fields.InvalidMessage_record_id(2)
          ,Axciom_Res_Fields.InvalidMessage_book_number(1)
          ,Axciom_Res_Fields.InvalidMessage_pub_date(1),Axciom_Res_Fields.InvalidMessage_pub_date(2)
          ,Axciom_Res_Fields.InvalidMessage_section_number(1)
          ,Axciom_Res_Fields.InvalidMessage_page_number(1)
          ,Axciom_Res_Fields.InvalidMessage_status_code(1),Axciom_Res_Fields.InvalidMessage_status_code(2)
          ,Axciom_Res_Fields.InvalidMessage_load_date(1),Axciom_Res_Fields.InvalidMessage_load_date(2)
          ,Axciom_Res_Fields.InvalidMessage_section_type(1),Axciom_Res_Fields.InvalidMessage_section_type(2)
          ,Axciom_Res_Fields.InvalidMessage_first_name(1),Axciom_Res_Fields.InvalidMessage_first_name(2)
          ,Axciom_Res_Fields.InvalidMessage_middle_initial(1),Axciom_Res_Fields.InvalidMessage_middle_initial(2)
          ,Axciom_Res_Fields.InvalidMessage_last_name(1),Axciom_Res_Fields.InvalidMessage_last_name(2)
          ,Axciom_Res_Fields.InvalidMessage_generational_suffix(1),Axciom_Res_Fields.InvalidMessage_generational_suffix(2)
          ,Axciom_Res_Fields.InvalidMessage_street_number(1),Axciom_Res_Fields.InvalidMessage_street_number(2)
          ,Axciom_Res_Fields.InvalidMessage_street_name(1),Axciom_Res_Fields.InvalidMessage_street_name(2)
          ,Axciom_Res_Fields.InvalidMessage_unit_number(1),Axciom_Res_Fields.InvalidMessage_unit_number(2)
          ,Axciom_Res_Fields.InvalidMessage_unit_designator(1),Axciom_Res_Fields.InvalidMessage_unit_designator(2)
          ,Axciom_Res_Fields.InvalidMessage_city(1),Axciom_Res_Fields.InvalidMessage_city(2)
          ,Axciom_Res_Fields.InvalidMessage_province(1),Axciom_Res_Fields.InvalidMessage_province(2)
          ,Axciom_Res_Fields.InvalidMessage_postal_code(1),Axciom_Res_Fields.InvalidMessage_postal_code(2)
          ,Axciom_Res_Fields.InvalidMessage_area_code(1),Axciom_Res_Fields.InvalidMessage_area_code(2)
          ,Axciom_Res_Fields.InvalidMessage_phone_number(1),Axciom_Res_Fields.InvalidMessage_phone_number(2)
          ,Axciom_Res_Fields.InvalidMessage_vanity_city_name(1),Axciom_Res_Fields.InvalidMessage_vanity_city_name(2)
          ,Axciom_Res_Fields.InvalidMessage_latitude(1)
          ,Axciom_Res_Fields.InvalidMessage_longitude(1)
          ,Axciom_Res_Fields.InvalidMessage_lat_long_level_applied(1),Axciom_Res_Fields.InvalidMessage_lat_long_level_applied(2)
          ,Axciom_Res_Fields.InvalidMessage_record_use_indicator(1),Axciom_Res_Fields.InvalidMessage_record_use_indicator(2)
          ,Axciom_Res_Fields.InvalidMessage_email(1)
          ,Axciom_Res_Fields.InvalidMessage_stated_address(1),Axciom_Res_Fields.InvalidMessage_stated_address(2)
          ,Axciom_Res_Fields.InvalidMessage_stated_city(1),Axciom_Res_Fields.InvalidMessage_stated_city(2)
          ,Axciom_Res_Fields.InvalidMessage_stated_postal_code(1),Axciom_Res_Fields.InvalidMessage_stated_postal_code(2),'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.record_id_ALLOW_ErrorCount,le.record_id_LENGTH_ErrorCount
          ,le.book_number_ALLOW_ErrorCount
          ,le.pub_date_ALLOW_ErrorCount,le.pub_date_LENGTH_ErrorCount
          ,le.section_number_ALLOW_ErrorCount
          ,le.page_number_ALLOW_ErrorCount
          ,le.status_code_ALLOW_ErrorCount,le.status_code_LENGTH_ErrorCount
          ,le.load_date_ALLOW_ErrorCount,le.load_date_LENGTH_ErrorCount
          ,le.section_type_ENUM_ErrorCount,le.section_type_LENGTH_ErrorCount
          ,le.first_name_ALLOW_ErrorCount,le.first_name_LENGTH_ErrorCount
          ,le.middle_initial_ALLOW_ErrorCount,le.middle_initial_LENGTH_ErrorCount
          ,le.last_name_ALLOW_ErrorCount,le.last_name_LENGTH_ErrorCount
          ,le.generational_suffix_ALLOW_ErrorCount,le.generational_suffix_LENGTH_ErrorCount
          ,le.street_number_ALLOW_ErrorCount,le.street_number_LENGTH_ErrorCount
          ,le.street_name_ALLOW_ErrorCount,le.street_name_LENGTH_ErrorCount
          ,le.unit_number_ALLOW_ErrorCount,le.unit_number_LENGTH_ErrorCount
          ,le.unit_designator_ALLOW_ErrorCount,le.unit_designator_LENGTH_ErrorCount
          ,le.city_ALLOW_ErrorCount,le.city_LENGTH_ErrorCount
          ,le.province_ALLOW_ErrorCount,le.province_LENGTH_ErrorCount
          ,le.postal_code_ALLOW_ErrorCount,le.postal_code_LENGTH_ErrorCount
          ,le.area_code_ALLOW_ErrorCount,le.area_code_LENGTH_ErrorCount
          ,le.phone_number_ALLOW_ErrorCount,le.phone_number_LENGTH_ErrorCount
          ,le.vanity_city_name_ALLOW_ErrorCount,le.vanity_city_name_LENGTH_ErrorCount
          ,le.latitude_ALLOW_ErrorCount
          ,le.longitude_ALLOW_ErrorCount
          ,le.lat_long_level_applied_ALLOW_ErrorCount,le.lat_long_level_applied_LENGTH_ErrorCount
          ,le.record_use_indicator_ENUM_ErrorCount,le.record_use_indicator_LENGTH_ErrorCount
          ,le.email_ALLOW_ErrorCount
          ,le.stated_address_ALLOW_ErrorCount,le.stated_address_LENGTH_ErrorCount
          ,le.stated_city_ALLOW_ErrorCount,le.stated_city_LENGTH_ErrorCount
          ,le.stated_postal_code_ALLOW_ErrorCount,le.stated_postal_code_LENGTH_ErrorCount,0);
      SELF.rulepcnt := 100 * CHOOSE(c
          ,le.record_id_ALLOW_ErrorCount,le.record_id_LENGTH_ErrorCount
          ,le.book_number_ALLOW_ErrorCount
          ,le.pub_date_ALLOW_ErrorCount,le.pub_date_LENGTH_ErrorCount
          ,le.section_number_ALLOW_ErrorCount
          ,le.page_number_ALLOW_ErrorCount
          ,le.status_code_ALLOW_ErrorCount,le.status_code_LENGTH_ErrorCount
          ,le.load_date_ALLOW_ErrorCount,le.load_date_LENGTH_ErrorCount
          ,le.section_type_ENUM_ErrorCount,le.section_type_LENGTH_ErrorCount
          ,le.first_name_ALLOW_ErrorCount,le.first_name_LENGTH_ErrorCount
          ,le.middle_initial_ALLOW_ErrorCount,le.middle_initial_LENGTH_ErrorCount
          ,le.last_name_ALLOW_ErrorCount,le.last_name_LENGTH_ErrorCount
          ,le.generational_suffix_ALLOW_ErrorCount,le.generational_suffix_LENGTH_ErrorCount
          ,le.street_number_ALLOW_ErrorCount,le.street_number_LENGTH_ErrorCount
          ,le.street_name_ALLOW_ErrorCount,le.street_name_LENGTH_ErrorCount
          ,le.unit_number_ALLOW_ErrorCount,le.unit_number_LENGTH_ErrorCount
          ,le.unit_designator_ALLOW_ErrorCount,le.unit_designator_LENGTH_ErrorCount
          ,le.city_ALLOW_ErrorCount,le.city_LENGTH_ErrorCount
          ,le.province_ALLOW_ErrorCount,le.province_LENGTH_ErrorCount
          ,le.postal_code_ALLOW_ErrorCount,le.postal_code_LENGTH_ErrorCount
          ,le.area_code_ALLOW_ErrorCount,le.area_code_LENGTH_ErrorCount
          ,le.phone_number_ALLOW_ErrorCount,le.phone_number_LENGTH_ErrorCount
          ,le.vanity_city_name_ALLOW_ErrorCount,le.vanity_city_name_LENGTH_ErrorCount
          ,le.latitude_ALLOW_ErrorCount
          ,le.longitude_ALLOW_ErrorCount
          ,le.lat_long_level_applied_ALLOW_ErrorCount,le.lat_long_level_applied_LENGTH_ErrorCount
          ,le.record_use_indicator_ENUM_ErrorCount,le.record_use_indicator_LENGTH_ErrorCount
          ,le.email_ALLOW_ErrorCount
          ,le.stated_address_ALLOW_ErrorCount,le.stated_address_LENGTH_ErrorCount
          ,le.stated_city_ALLOW_ErrorCount,le.stated_city_LENGTH_ErrorCount
          ,le.stated_postal_code_ALLOW_ErrorCount,le.stated_postal_code_LENGTH_ErrorCount,0) / le.TotalCnt + 0.5;
    END;
    SummaryInfo := NORMALIZE(SummaryStats,54,Into(LEFT,COUNTER));
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
