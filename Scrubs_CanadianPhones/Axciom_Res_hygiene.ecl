IMPORT ut,SALT32;
EXPORT Axciom_Res_hygiene(dataset(Axciom_Res_layout_CanadianPhones) h) := MODULE
//A simple summary record
EXPORT Summary(SALT32.Str30Type txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_record_id_pcnt := AVE(GROUP,IF(h.record_id = (TYPEOF(h.record_id))'',0,100));
    maxlength_record_id := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.record_id)));
    avelength_record_id := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.record_id)),h.record_id<>(typeof(h.record_id))'');
    populated_book_number_pcnt := AVE(GROUP,IF(h.book_number = (TYPEOF(h.book_number))'',0,100));
    maxlength_book_number := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.book_number)));
    avelength_book_number := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.book_number)),h.book_number<>(typeof(h.book_number))'');
    populated_pub_date_pcnt := AVE(GROUP,IF(h.pub_date = (TYPEOF(h.pub_date))'',0,100));
    maxlength_pub_date := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.pub_date)));
    avelength_pub_date := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.pub_date)),h.pub_date<>(typeof(h.pub_date))'');
    populated_section_number_pcnt := AVE(GROUP,IF(h.section_number = (TYPEOF(h.section_number))'',0,100));
    maxlength_section_number := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.section_number)));
    avelength_section_number := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.section_number)),h.section_number<>(typeof(h.section_number))'');
    populated_page_number_pcnt := AVE(GROUP,IF(h.page_number = (TYPEOF(h.page_number))'',0,100));
    maxlength_page_number := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.page_number)));
    avelength_page_number := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.page_number)),h.page_number<>(typeof(h.page_number))'');
    populated_status_code_pcnt := AVE(GROUP,IF(h.status_code = (TYPEOF(h.status_code))'',0,100));
    maxlength_status_code := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.status_code)));
    avelength_status_code := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.status_code)),h.status_code<>(typeof(h.status_code))'');
    populated_load_date_pcnt := AVE(GROUP,IF(h.load_date = (TYPEOF(h.load_date))'',0,100));
    maxlength_load_date := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.load_date)));
    avelength_load_date := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.load_date)),h.load_date<>(typeof(h.load_date))'');
    populated_section_type_pcnt := AVE(GROUP,IF(h.section_type = (TYPEOF(h.section_type))'',0,100));
    maxlength_section_type := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.section_type)));
    avelength_section_type := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.section_type)),h.section_type<>(typeof(h.section_type))'');
    populated_first_name_pcnt := AVE(GROUP,IF(h.first_name = (TYPEOF(h.first_name))'',0,100));
    maxlength_first_name := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.first_name)));
    avelength_first_name := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.first_name)),h.first_name<>(typeof(h.first_name))'');
    populated_middle_initial_pcnt := AVE(GROUP,IF(h.middle_initial = (TYPEOF(h.middle_initial))'',0,100));
    maxlength_middle_initial := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.middle_initial)));
    avelength_middle_initial := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.middle_initial)),h.middle_initial<>(typeof(h.middle_initial))'');
    populated_last_name_pcnt := AVE(GROUP,IF(h.last_name = (TYPEOF(h.last_name))'',0,100));
    maxlength_last_name := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.last_name)));
    avelength_last_name := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.last_name)),h.last_name<>(typeof(h.last_name))'');
    populated_generational_suffix_pcnt := AVE(GROUP,IF(h.generational_suffix = (TYPEOF(h.generational_suffix))'',0,100));
    maxlength_generational_suffix := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.generational_suffix)));
    avelength_generational_suffix := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.generational_suffix)),h.generational_suffix<>(typeof(h.generational_suffix))'');
    populated_primary_prefix_title_code_pcnt := AVE(GROUP,IF(h.primary_prefix_title_code = (TYPEOF(h.primary_prefix_title_code))'',0,100));
    maxlength_primary_prefix_title_code := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.primary_prefix_title_code)));
    avelength_primary_prefix_title_code := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.primary_prefix_title_code)),h.primary_prefix_title_code<>(typeof(h.primary_prefix_title_code))'');
    populated_primary_professional_suffix_code_pcnt := AVE(GROUP,IF(h.primary_professional_suffix_code = (TYPEOF(h.primary_professional_suffix_code))'',0,100));
    maxlength_primary_professional_suffix_code := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.primary_professional_suffix_code)));
    avelength_primary_professional_suffix_code := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.primary_professional_suffix_code)),h.primary_professional_suffix_code<>(typeof(h.primary_professional_suffix_code))'');
    populated_street_number_pcnt := AVE(GROUP,IF(h.street_number = (TYPEOF(h.street_number))'',0,100));
    maxlength_street_number := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.street_number)));
    avelength_street_number := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.street_number)),h.street_number<>(typeof(h.street_number))'');
    populated_street_name_pcnt := AVE(GROUP,IF(h.street_name = (TYPEOF(h.street_name))'',0,100));
    maxlength_street_name := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.street_name)));
    avelength_street_name := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.street_name)),h.street_name<>(typeof(h.street_name))'');
    populated_unit_number_pcnt := AVE(GROUP,IF(h.unit_number = (TYPEOF(h.unit_number))'',0,100));
    maxlength_unit_number := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.unit_number)));
    avelength_unit_number := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.unit_number)),h.unit_number<>(typeof(h.unit_number))'');
    populated_unit_designator_pcnt := AVE(GROUP,IF(h.unit_designator = (TYPEOF(h.unit_designator))'',0,100));
    maxlength_unit_designator := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.unit_designator)));
    avelength_unit_designator := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.unit_designator)),h.unit_designator<>(typeof(h.unit_designator))'');
    populated_city_pcnt := AVE(GROUP,IF(h.city = (TYPEOF(h.city))'',0,100));
    maxlength_city := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.city)));
    avelength_city := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.city)),h.city<>(typeof(h.city))'');
    populated_province_pcnt := AVE(GROUP,IF(h.province = (TYPEOF(h.province))'',0,100));
    maxlength_province := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.province)));
    avelength_province := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.province)),h.province<>(typeof(h.province))'');
    populated_postal_code_pcnt := AVE(GROUP,IF(h.postal_code = (TYPEOF(h.postal_code))'',0,100));
    maxlength_postal_code := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.postal_code)));
    avelength_postal_code := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.postal_code)),h.postal_code<>(typeof(h.postal_code))'');
    populated_area_code_pcnt := AVE(GROUP,IF(h.area_code = (TYPEOF(h.area_code))'',0,100));
    maxlength_area_code := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.area_code)));
    avelength_area_code := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.area_code)),h.area_code<>(typeof(h.area_code))'');
    populated_phone_number_pcnt := AVE(GROUP,IF(h.phone_number = (TYPEOF(h.phone_number))'',0,100));
    maxlength_phone_number := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.phone_number)));
    avelength_phone_number := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.phone_number)),h.phone_number<>(typeof(h.phone_number))'');
    populated_vanity_city_name_pcnt := AVE(GROUP,IF(h.vanity_city_name = (TYPEOF(h.vanity_city_name))'',0,100));
    maxlength_vanity_city_name := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.vanity_city_name)));
    avelength_vanity_city_name := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.vanity_city_name)),h.vanity_city_name<>(typeof(h.vanity_city_name))'');
    populated_latitude_pcnt := AVE(GROUP,IF(h.latitude = (TYPEOF(h.latitude))'',0,100));
    maxlength_latitude := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.latitude)));
    avelength_latitude := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.latitude)),h.latitude<>(typeof(h.latitude))'');
    populated_longitude_pcnt := AVE(GROUP,IF(h.longitude = (TYPEOF(h.longitude))'',0,100));
    maxlength_longitude := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.longitude)));
    avelength_longitude := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.longitude)),h.longitude<>(typeof(h.longitude))'');
    populated_lat_long_level_applied_pcnt := AVE(GROUP,IF(h.lat_long_level_applied = (TYPEOF(h.lat_long_level_applied))'',0,100));
    maxlength_lat_long_level_applied := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.lat_long_level_applied)));
    avelength_lat_long_level_applied := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.lat_long_level_applied)),h.lat_long_level_applied<>(typeof(h.lat_long_level_applied))'');
    populated_record_use_indicator_pcnt := AVE(GROUP,IF(h.record_use_indicator = (TYPEOF(h.record_use_indicator))'',0,100));
    maxlength_record_use_indicator := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.record_use_indicator)));
    avelength_record_use_indicator := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.record_use_indicator)),h.record_use_indicator<>(typeof(h.record_use_indicator))'');
    populated_email_pcnt := AVE(GROUP,IF(h.email = (TYPEOF(h.email))'',0,100));
    maxlength_email := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.email)));
    avelength_email := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.email)),h.email<>(typeof(h.email))'');
    populated_stated_address_pcnt := AVE(GROUP,IF(h.stated_address = (TYPEOF(h.stated_address))'',0,100));
    maxlength_stated_address := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.stated_address)));
    avelength_stated_address := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.stated_address)),h.stated_address<>(typeof(h.stated_address))'');
    populated_stated_city_pcnt := AVE(GROUP,IF(h.stated_city = (TYPEOF(h.stated_city))'',0,100));
    maxlength_stated_city := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.stated_city)));
    avelength_stated_city := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.stated_city)),h.stated_city<>(typeof(h.stated_city))'');
    populated_stated_postal_code_pcnt := AVE(GROUP,IF(h.stated_postal_code = (TYPEOF(h.stated_postal_code))'',0,100));
    maxlength_stated_postal_code := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.stated_postal_code)));
    avelength_stated_postal_code := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.stated_postal_code)),h.stated_postal_code<>(typeof(h.stated_postal_code))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_record_id_pcnt *   0.00 / 100 + T.Populated_book_number_pcnt *   0.00 / 100 + T.Populated_pub_date_pcnt *   0.00 / 100 + T.Populated_section_number_pcnt *   0.00 / 100 + T.Populated_page_number_pcnt *   0.00 / 100 + T.Populated_status_code_pcnt *   0.00 / 100 + T.Populated_load_date_pcnt *   0.00 / 100 + T.Populated_section_type_pcnt *   0.00 / 100 + T.Populated_first_name_pcnt *   0.00 / 100 + T.Populated_middle_initial_pcnt *   0.00 / 100 + T.Populated_last_name_pcnt *   0.00 / 100 + T.Populated_generational_suffix_pcnt *   0.00 / 100 + T.Populated_primary_prefix_title_code_pcnt *   0.00 / 100 + T.Populated_primary_professional_suffix_code_pcnt *   0.00 / 100 + T.Populated_street_number_pcnt *   0.00 / 100 + T.Populated_street_name_pcnt *   0.00 / 100 + T.Populated_unit_number_pcnt *   0.00 / 100 + T.Populated_unit_designator_pcnt *   0.00 / 100 + T.Populated_city_pcnt *   0.00 / 100 + T.Populated_province_pcnt *   0.00 / 100 + T.Populated_postal_code_pcnt *   0.00 / 100 + T.Populated_area_code_pcnt *   0.00 / 100 + T.Populated_phone_number_pcnt *   0.00 / 100 + T.Populated_vanity_city_name_pcnt *   0.00 / 100 + T.Populated_latitude_pcnt *   0.00 / 100 + T.Populated_longitude_pcnt *   0.00 / 100 + T.Populated_lat_long_level_applied_pcnt *   0.00 / 100 + T.Populated_record_use_indicator_pcnt *   0.00 / 100 + T.Populated_email_pcnt *   0.00 / 100 + T.Populated_stated_address_pcnt *   0.00 / 100 + T.Populated_stated_city_pcnt *   0.00 / 100 + T.Populated_stated_postal_code_pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;
summary0 := Summary('Summary');
invRec := RECORD
  UNSIGNED  FldNo;
  SALT32.StrType FieldName;
  UNSIGNED NumberOfRecords;
  REAL8  populated_pcnt;
  UNSIGNED  maxlength;
  REAL8  avelength;
END;
invRec invert(summary0 le, INTEGER C) := TRANSFORM
  SELF.FldNo := C;
  SELF.NumberOfRecords := le.NumberOfRecords;
  SELF.FieldName := CHOOSE(C,'record_id','book_number','pub_date','section_number','page_number','status_code','load_date','section_type','first_name','middle_initial','last_name','generational_suffix','primary_prefix_title_code','primary_professional_suffix_code','street_number','street_name','unit_number','unit_designator','city','province','postal_code','area_code','phone_number','vanity_city_name','latitude','longitude','lat_long_level_applied','record_use_indicator','email','stated_address','stated_city','stated_postal_code');
  SELF.populated_pcnt := CHOOSE(C,le.populated_record_id_pcnt,le.populated_book_number_pcnt,le.populated_pub_date_pcnt,le.populated_section_number_pcnt,le.populated_page_number_pcnt,le.populated_status_code_pcnt,le.populated_load_date_pcnt,le.populated_section_type_pcnt,le.populated_first_name_pcnt,le.populated_middle_initial_pcnt,le.populated_last_name_pcnt,le.populated_generational_suffix_pcnt,le.populated_primary_prefix_title_code_pcnt,le.populated_primary_professional_suffix_code_pcnt,le.populated_street_number_pcnt,le.populated_street_name_pcnt,le.populated_unit_number_pcnt,le.populated_unit_designator_pcnt,le.populated_city_pcnt,le.populated_province_pcnt,le.populated_postal_code_pcnt,le.populated_area_code_pcnt,le.populated_phone_number_pcnt,le.populated_vanity_city_name_pcnt,le.populated_latitude_pcnt,le.populated_longitude_pcnt,le.populated_lat_long_level_applied_pcnt,le.populated_record_use_indicator_pcnt,le.populated_email_pcnt,le.populated_stated_address_pcnt,le.populated_stated_city_pcnt,le.populated_stated_postal_code_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_record_id,le.maxlength_book_number,le.maxlength_pub_date,le.maxlength_section_number,le.maxlength_page_number,le.maxlength_status_code,le.maxlength_load_date,le.maxlength_section_type,le.maxlength_first_name,le.maxlength_middle_initial,le.maxlength_last_name,le.maxlength_generational_suffix,le.maxlength_primary_prefix_title_code,le.maxlength_primary_professional_suffix_code,le.maxlength_street_number,le.maxlength_street_name,le.maxlength_unit_number,le.maxlength_unit_designator,le.maxlength_city,le.maxlength_province,le.maxlength_postal_code,le.maxlength_area_code,le.maxlength_phone_number,le.maxlength_vanity_city_name,le.maxlength_latitude,le.maxlength_longitude,le.maxlength_lat_long_level_applied,le.maxlength_record_use_indicator,le.maxlength_email,le.maxlength_stated_address,le.maxlength_stated_city,le.maxlength_stated_postal_code);
  SELF.avelength := CHOOSE(C,le.avelength_record_id,le.avelength_book_number,le.avelength_pub_date,le.avelength_section_number,le.avelength_page_number,le.avelength_status_code,le.avelength_load_date,le.avelength_section_type,le.avelength_first_name,le.avelength_middle_initial,le.avelength_last_name,le.avelength_generational_suffix,le.avelength_primary_prefix_title_code,le.avelength_primary_professional_suffix_code,le.avelength_street_number,le.avelength_street_name,le.avelength_unit_number,le.avelength_unit_designator,le.avelength_city,le.avelength_province,le.avelength_postal_code,le.avelength_area_code,le.avelength_phone_number,le.avelength_vanity_city_name,le.avelength_latitude,le.avelength_longitude,le.avelength_lat_long_level_applied,le.avelength_record_use_indicator,le.avelength_email,le.avelength_stated_address,le.avelength_stated_city,le.avelength_stated_postal_code);
END;
EXPORT invSummary := NORMALIZE(summary0, 32, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT32.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT32.StrType)le.record_id),TRIM((SALT32.StrType)le.book_number),TRIM((SALT32.StrType)le.pub_date),TRIM((SALT32.StrType)le.section_number),TRIM((SALT32.StrType)le.page_number),TRIM((SALT32.StrType)le.status_code),TRIM((SALT32.StrType)le.load_date),TRIM((SALT32.StrType)le.section_type),TRIM((SALT32.StrType)le.first_name),TRIM((SALT32.StrType)le.middle_initial),TRIM((SALT32.StrType)le.last_name),TRIM((SALT32.StrType)le.generational_suffix),TRIM((SALT32.StrType)le.primary_prefix_title_code),TRIM((SALT32.StrType)le.primary_professional_suffix_code),TRIM((SALT32.StrType)le.street_number),TRIM((SALT32.StrType)le.street_name),TRIM((SALT32.StrType)le.unit_number),TRIM((SALT32.StrType)le.unit_designator),TRIM((SALT32.StrType)le.city),TRIM((SALT32.StrType)le.province),TRIM((SALT32.StrType)le.postal_code),TRIM((SALT32.StrType)le.area_code),TRIM((SALT32.StrType)le.phone_number),TRIM((SALT32.StrType)le.vanity_city_name),TRIM((SALT32.StrType)le.latitude),TRIM((SALT32.StrType)le.longitude),TRIM((SALT32.StrType)le.lat_long_level_applied),TRIM((SALT32.StrType)le.record_use_indicator),TRIM((SALT32.StrType)le.email),TRIM((SALT32.StrType)le.stated_address),TRIM((SALT32.StrType)le.stated_city),TRIM((SALT32.StrType)le.stated_postal_code)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,32,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT32.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 32);
  SELF.FldNo2 := 1 + (C % 32);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT32.StrType)le.record_id),TRIM((SALT32.StrType)le.book_number),TRIM((SALT32.StrType)le.pub_date),TRIM((SALT32.StrType)le.section_number),TRIM((SALT32.StrType)le.page_number),TRIM((SALT32.StrType)le.status_code),TRIM((SALT32.StrType)le.load_date),TRIM((SALT32.StrType)le.section_type),TRIM((SALT32.StrType)le.first_name),TRIM((SALT32.StrType)le.middle_initial),TRIM((SALT32.StrType)le.last_name),TRIM((SALT32.StrType)le.generational_suffix),TRIM((SALT32.StrType)le.primary_prefix_title_code),TRIM((SALT32.StrType)le.primary_professional_suffix_code),TRIM((SALT32.StrType)le.street_number),TRIM((SALT32.StrType)le.street_name),TRIM((SALT32.StrType)le.unit_number),TRIM((SALT32.StrType)le.unit_designator),TRIM((SALT32.StrType)le.city),TRIM((SALT32.StrType)le.province),TRIM((SALT32.StrType)le.postal_code),TRIM((SALT32.StrType)le.area_code),TRIM((SALT32.StrType)le.phone_number),TRIM((SALT32.StrType)le.vanity_city_name),TRIM((SALT32.StrType)le.latitude),TRIM((SALT32.StrType)le.longitude),TRIM((SALT32.StrType)le.lat_long_level_applied),TRIM((SALT32.StrType)le.record_use_indicator),TRIM((SALT32.StrType)le.email),TRIM((SALT32.StrType)le.stated_address),TRIM((SALT32.StrType)le.stated_city),TRIM((SALT32.StrType)le.stated_postal_code)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT32.StrType)le.record_id),TRIM((SALT32.StrType)le.book_number),TRIM((SALT32.StrType)le.pub_date),TRIM((SALT32.StrType)le.section_number),TRIM((SALT32.StrType)le.page_number),TRIM((SALT32.StrType)le.status_code),TRIM((SALT32.StrType)le.load_date),TRIM((SALT32.StrType)le.section_type),TRIM((SALT32.StrType)le.first_name),TRIM((SALT32.StrType)le.middle_initial),TRIM((SALT32.StrType)le.last_name),TRIM((SALT32.StrType)le.generational_suffix),TRIM((SALT32.StrType)le.primary_prefix_title_code),TRIM((SALT32.StrType)le.primary_professional_suffix_code),TRIM((SALT32.StrType)le.street_number),TRIM((SALT32.StrType)le.street_name),TRIM((SALT32.StrType)le.unit_number),TRIM((SALT32.StrType)le.unit_designator),TRIM((SALT32.StrType)le.city),TRIM((SALT32.StrType)le.province),TRIM((SALT32.StrType)le.postal_code),TRIM((SALT32.StrType)le.area_code),TRIM((SALT32.StrType)le.phone_number),TRIM((SALT32.StrType)le.vanity_city_name),TRIM((SALT32.StrType)le.latitude),TRIM((SALT32.StrType)le.longitude),TRIM((SALT32.StrType)le.lat_long_level_applied),TRIM((SALT32.StrType)le.record_use_indicator),TRIM((SALT32.StrType)le.email),TRIM((SALT32.StrType)le.stated_address),TRIM((SALT32.StrType)le.stated_city),TRIM((SALT32.StrType)le.stated_postal_code)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),32*32,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'record_id'}
      ,{2,'book_number'}
      ,{3,'pub_date'}
      ,{4,'section_number'}
      ,{5,'page_number'}
      ,{6,'status_code'}
      ,{7,'load_date'}
      ,{8,'section_type'}
      ,{9,'first_name'}
      ,{10,'middle_initial'}
      ,{11,'last_name'}
      ,{12,'generational_suffix'}
      ,{13,'primary_prefix_title_code'}
      ,{14,'primary_professional_suffix_code'}
      ,{15,'street_number'}
      ,{16,'street_name'}
      ,{17,'unit_number'}
      ,{18,'unit_designator'}
      ,{19,'city'}
      ,{20,'province'}
      ,{21,'postal_code'}
      ,{22,'area_code'}
      ,{23,'phone_number'}
      ,{24,'vanity_city_name'}
      ,{25,'latitude'}
      ,{26,'longitude'}
      ,{27,'lat_long_level_applied'}
      ,{28,'record_use_indicator'}
      ,{29,'email'}
      ,{30,'stated_address'}
      ,{31,'stated_city'}
      ,{32,'stated_postal_code'}],SALT32.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT32.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
EXPORT SrcProfiles := SALT32.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
EXPORT Correlations := SALT32.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Axciom_Res_Fields.InValid_record_id((SALT32.StrType)le.record_id),
    Axciom_Res_Fields.InValid_book_number((SALT32.StrType)le.book_number),
    Axciom_Res_Fields.InValid_pub_date((SALT32.StrType)le.pub_date),
    Axciom_Res_Fields.InValid_section_number((SALT32.StrType)le.section_number),
    Axciom_Res_Fields.InValid_page_number((SALT32.StrType)le.page_number),
    Axciom_Res_Fields.InValid_status_code((SALT32.StrType)le.status_code),
    Axciom_Res_Fields.InValid_load_date((SALT32.StrType)le.load_date),
    Axciom_Res_Fields.InValid_section_type((SALT32.StrType)le.section_type),
    Axciom_Res_Fields.InValid_first_name((SALT32.StrType)le.first_name),
    Axciom_Res_Fields.InValid_middle_initial((SALT32.StrType)le.middle_initial),
    Axciom_Res_Fields.InValid_last_name((SALT32.StrType)le.last_name),
    Axciom_Res_Fields.InValid_generational_suffix((SALT32.StrType)le.generational_suffix),
    Axciom_Res_Fields.InValid_primary_prefix_title_code((SALT32.StrType)le.primary_prefix_title_code),
    Axciom_Res_Fields.InValid_primary_professional_suffix_code((SALT32.StrType)le.primary_professional_suffix_code),
    Axciom_Res_Fields.InValid_street_number((SALT32.StrType)le.street_number),
    Axciom_Res_Fields.InValid_street_name((SALT32.StrType)le.street_name),
    Axciom_Res_Fields.InValid_unit_number((SALT32.StrType)le.unit_number),
    Axciom_Res_Fields.InValid_unit_designator((SALT32.StrType)le.unit_designator),
    Axciom_Res_Fields.InValid_city((SALT32.StrType)le.city),
    Axciom_Res_Fields.InValid_province((SALT32.StrType)le.province),
    Axciom_Res_Fields.InValid_postal_code((SALT32.StrType)le.postal_code),
    Axciom_Res_Fields.InValid_area_code((SALT32.StrType)le.area_code),
    Axciom_Res_Fields.InValid_phone_number((SALT32.StrType)le.phone_number),
    Axciom_Res_Fields.InValid_vanity_city_name((SALT32.StrType)le.vanity_city_name),
    Axciom_Res_Fields.InValid_latitude((SALT32.StrType)le.latitude),
    Axciom_Res_Fields.InValid_longitude((SALT32.StrType)le.longitude),
    Axciom_Res_Fields.InValid_lat_long_level_applied((SALT32.StrType)le.lat_long_level_applied),
    Axciom_Res_Fields.InValid_record_use_indicator((SALT32.StrType)le.record_use_indicator),
    Axciom_Res_Fields.InValid_email((SALT32.StrType)le.email),
    Axciom_Res_Fields.InValid_stated_address((SALT32.StrType)le.stated_address),
    Axciom_Res_Fields.InValid_stated_city((SALT32.StrType)le.stated_city),
    Axciom_Res_Fields.InValid_stated_postal_code((SALT32.StrType)le.stated_postal_code),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,32,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Axciom_Res_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid_record_id','invalid_numeric','invalid_date','invalid_numeric','invalid_numeric','invalid_status_code','invalid_date1','invalid_section_type','invalid_name','invalid_mid_init','invalid_name','invalid_alpha','Unknown','Unknown','invalid_alnum','invalid_address','invalid_address','invalid_address','invalid_city','invalid_province','invalid_canadian_zip','invalid_area_code','invalid_phone','invalid_city','invalid_numeric','invalid_numeric','invalid_lat_long_level_applied','invalid_record_use_indicator','invalid_email','invalid_address','invalid_city','invalid_canadian_zip');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Axciom_Res_Fields.InValidMessage_record_id(TotalErrors.ErrorNum),Axciom_Res_Fields.InValidMessage_book_number(TotalErrors.ErrorNum),Axciom_Res_Fields.InValidMessage_pub_date(TotalErrors.ErrorNum),Axciom_Res_Fields.InValidMessage_section_number(TotalErrors.ErrorNum),Axciom_Res_Fields.InValidMessage_page_number(TotalErrors.ErrorNum),Axciom_Res_Fields.InValidMessage_status_code(TotalErrors.ErrorNum),Axciom_Res_Fields.InValidMessage_load_date(TotalErrors.ErrorNum),Axciom_Res_Fields.InValidMessage_section_type(TotalErrors.ErrorNum),Axciom_Res_Fields.InValidMessage_first_name(TotalErrors.ErrorNum),Axciom_Res_Fields.InValidMessage_middle_initial(TotalErrors.ErrorNum),Axciom_Res_Fields.InValidMessage_last_name(TotalErrors.ErrorNum),Axciom_Res_Fields.InValidMessage_generational_suffix(TotalErrors.ErrorNum),Axciom_Res_Fields.InValidMessage_primary_prefix_title_code(TotalErrors.ErrorNum),Axciom_Res_Fields.InValidMessage_primary_professional_suffix_code(TotalErrors.ErrorNum),Axciom_Res_Fields.InValidMessage_street_number(TotalErrors.ErrorNum),Axciom_Res_Fields.InValidMessage_street_name(TotalErrors.ErrorNum),Axciom_Res_Fields.InValidMessage_unit_number(TotalErrors.ErrorNum),Axciom_Res_Fields.InValidMessage_unit_designator(TotalErrors.ErrorNum),Axciom_Res_Fields.InValidMessage_city(TotalErrors.ErrorNum),Axciom_Res_Fields.InValidMessage_province(TotalErrors.ErrorNum),Axciom_Res_Fields.InValidMessage_postal_code(TotalErrors.ErrorNum),Axciom_Res_Fields.InValidMessage_area_code(TotalErrors.ErrorNum),Axciom_Res_Fields.InValidMessage_phone_number(TotalErrors.ErrorNum),Axciom_Res_Fields.InValidMessage_vanity_city_name(TotalErrors.ErrorNum),Axciom_Res_Fields.InValidMessage_latitude(TotalErrors.ErrorNum),Axciom_Res_Fields.InValidMessage_longitude(TotalErrors.ErrorNum),Axciom_Res_Fields.InValidMessage_lat_long_level_applied(TotalErrors.ErrorNum),Axciom_Res_Fields.InValidMessage_record_use_indicator(TotalErrors.ErrorNum),Axciom_Res_Fields.InValidMessage_email(TotalErrors.ErrorNum),Axciom_Res_Fields.InValidMessage_stated_address(TotalErrors.ErrorNum),Axciom_Res_Fields.InValidMessage_stated_city(TotalErrors.ErrorNum),Axciom_Res_Fields.InValidMessage_stated_postal_code(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
END;
