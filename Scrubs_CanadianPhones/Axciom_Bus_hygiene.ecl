IMPORT ut,SALT32;
EXPORT Axciom_Bus_hygiene(dataset(Axciom_Bus_layout_CanadianPhones) h) := MODULE
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
    populated_business_name_pcnt := AVE(GROUP,IF(h.business_name = (TYPEOF(h.business_name))'',0,100));
    maxlength_business_name := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.business_name)));
    avelength_business_name := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.business_name)),h.business_name<>(typeof(h.business_name))'');
    populated_street_number_pcnt := AVE(GROUP,IF(h.street_number = (TYPEOF(h.street_number))'',0,100));
    maxlength_street_number := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.street_number)));
    avelength_street_number := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.street_number)),h.street_number<>(typeof(h.street_number))'');
    populated_street_name_pcnt := AVE(GROUP,IF(h.street_name = (TYPEOF(h.street_name))'',0,100));
    maxlength_street_name := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.street_name)));
    avelength_street_name := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.street_name)),h.street_name<>(typeof(h.street_name))'');
    populated_unit_designator_pcnt := AVE(GROUP,IF(h.unit_designator = (TYPEOF(h.unit_designator))'',0,100));
    maxlength_unit_designator := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.unit_designator)));
    avelength_unit_designator := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.unit_designator)),h.unit_designator<>(typeof(h.unit_designator))'');
    populated_unit_number_pcnt := AVE(GROUP,IF(h.unit_number = (TYPEOF(h.unit_number))'',0,100));
    maxlength_unit_number := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.unit_number)));
    avelength_unit_number := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.unit_number)),h.unit_number<>(typeof(h.unit_number))'');
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
    populated_syph_1_pcnt := AVE(GROUP,IF(h.syph_1 = (TYPEOF(h.syph_1))'',0,100));
    maxlength_syph_1 := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.syph_1)));
    avelength_syph_1 := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.syph_1)),h.syph_1<>(typeof(h.syph_1))'');
    populated_syph_2_pcnt := AVE(GROUP,IF(h.syph_2 = (TYPEOF(h.syph_2))'',0,100));
    maxlength_syph_2 := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.syph_2)));
    avelength_syph_2 := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.syph_2)),h.syph_2<>(typeof(h.syph_2))'');
    populated_syph_3_pcnt := AVE(GROUP,IF(h.syph_3 = (TYPEOF(h.syph_3))'',0,100));
    maxlength_syph_3 := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.syph_3)));
    avelength_syph_3 := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.syph_3)),h.syph_3<>(typeof(h.syph_3))'');
    populated_syph_4_pcnt := AVE(GROUP,IF(h.syph_4 = (TYPEOF(h.syph_4))'',0,100));
    maxlength_syph_4 := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.syph_4)));
    avelength_syph_4 := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.syph_4)),h.syph_4<>(typeof(h.syph_4))'');
    populated_syph_5_pcnt := AVE(GROUP,IF(h.syph_5 = (TYPEOF(h.syph_5))'',0,100));
    maxlength_syph_5 := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.syph_5)));
    avelength_syph_5 := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.syph_5)),h.syph_5<>(typeof(h.syph_5))'');
    populated_syph_6_pcnt := AVE(GROUP,IF(h.syph_6 = (TYPEOF(h.syph_6))'',0,100));
    maxlength_syph_6 := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.syph_6)));
    avelength_syph_6 := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.syph_6)),h.syph_6<>(typeof(h.syph_6))'');
    populated_naics_1_pcnt := AVE(GROUP,IF(h.naics_1 = (TYPEOF(h.naics_1))'',0,100));
    maxlength_naics_1 := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.naics_1)));
    avelength_naics_1 := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.naics_1)),h.naics_1<>(typeof(h.naics_1))'');
    populated_naics_2_pcnt := AVE(GROUP,IF(h.naics_2 = (TYPEOF(h.naics_2))'',0,100));
    maxlength_naics_2 := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.naics_2)));
    avelength_naics_2 := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.naics_2)),h.naics_2<>(typeof(h.naics_2))'');
    populated_naics_3_pcnt := AVE(GROUP,IF(h.naics_3 = (TYPEOF(h.naics_3))'',0,100));
    maxlength_naics_3 := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.naics_3)));
    avelength_naics_3 := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.naics_3)),h.naics_3<>(typeof(h.naics_3))'');
    populated_naics_4_pcnt := AVE(GROUP,IF(h.naics_4 = (TYPEOF(h.naics_4))'',0,100));
    maxlength_naics_4 := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.naics_4)));
    avelength_naics_4 := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.naics_4)),h.naics_4<>(typeof(h.naics_4))'');
    populated_naics_5_pcnt := AVE(GROUP,IF(h.naics_5 = (TYPEOF(h.naics_5))'',0,100));
    maxlength_naics_5 := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.naics_5)));
    avelength_naics_5 := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.naics_5)),h.naics_5<>(typeof(h.naics_5))'');
    populated_naics_6_pcnt := AVE(GROUP,IF(h.naics_6 = (TYPEOF(h.naics_6))'',0,100));
    maxlength_naics_6 := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.naics_6)));
    avelength_naics_6 := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.naics_6)),h.naics_6<>(typeof(h.naics_6))'');
    populated_bdc_1_pcnt := AVE(GROUP,IF(h.bdc_1 = (TYPEOF(h.bdc_1))'',0,100));
    maxlength_bdc_1 := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.bdc_1)));
    avelength_bdc_1 := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.bdc_1)),h.bdc_1<>(typeof(h.bdc_1))'');
    populated_bdc_2_pcnt := AVE(GROUP,IF(h.bdc_2 = (TYPEOF(h.bdc_2))'',0,100));
    maxlength_bdc_2 := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.bdc_2)));
    avelength_bdc_2 := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.bdc_2)),h.bdc_2<>(typeof(h.bdc_2))'');
    populated_bdc_3_pcnt := AVE(GROUP,IF(h.bdc_3 = (TYPEOF(h.bdc_3))'',0,100));
    maxlength_bdc_3 := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.bdc_3)));
    avelength_bdc_3 := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.bdc_3)),h.bdc_3<>(typeof(h.bdc_3))'');
    populated_bdc_4_pcnt := AVE(GROUP,IF(h.bdc_4 = (TYPEOF(h.bdc_4))'',0,100));
    maxlength_bdc_4 := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.bdc_4)));
    avelength_bdc_4 := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.bdc_4)),h.bdc_4<>(typeof(h.bdc_4))'');
    populated_bdc_5_pcnt := AVE(GROUP,IF(h.bdc_5 = (TYPEOF(h.bdc_5))'',0,100));
    maxlength_bdc_5 := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.bdc_5)));
    avelength_bdc_5 := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.bdc_5)),h.bdc_5<>(typeof(h.bdc_5))'');
    populated_bdc_6_pcnt := AVE(GROUP,IF(h.bdc_6 = (TYPEOF(h.bdc_6))'',0,100));
    maxlength_bdc_6 := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.bdc_6)));
    avelength_bdc_6 := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.bdc_6)),h.bdc_6<>(typeof(h.bdc_6))'');
    populated_sic_1_pcnt := AVE(GROUP,IF(h.sic_1 = (TYPEOF(h.sic_1))'',0,100));
    maxlength_sic_1 := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.sic_1)));
    avelength_sic_1 := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.sic_1)),h.sic_1<>(typeof(h.sic_1))'');
    populated_sic_2_pcnt := AVE(GROUP,IF(h.sic_2 = (TYPEOF(h.sic_2))'',0,100));
    maxlength_sic_2 := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.sic_2)));
    avelength_sic_2 := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.sic_2)),h.sic_2<>(typeof(h.sic_2))'');
    populated_sic_3_pcnt := AVE(GROUP,IF(h.sic_3 = (TYPEOF(h.sic_3))'',0,100));
    maxlength_sic_3 := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.sic_3)));
    avelength_sic_3 := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.sic_3)),h.sic_3<>(typeof(h.sic_3))'');
    populated_sic_4_pcnt := AVE(GROUP,IF(h.sic_4 = (TYPEOF(h.sic_4))'',0,100));
    maxlength_sic_4 := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.sic_4)));
    avelength_sic_4 := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.sic_4)),h.sic_4<>(typeof(h.sic_4))'');
    populated_sic_5_pcnt := AVE(GROUP,IF(h.sic_5 = (TYPEOF(h.sic_5))'',0,100));
    maxlength_sic_5 := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.sic_5)));
    avelength_sic_5 := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.sic_5)),h.sic_5<>(typeof(h.sic_5))'');
    populated_sic_6_pcnt := AVE(GROUP,IF(h.sic_6 = (TYPEOF(h.sic_6))'',0,100));
    maxlength_sic_6 := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.sic_6)));
    avelength_sic_6 := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.sic_6)),h.sic_6<>(typeof(h.sic_6))'');
    populated_caption_counter_pcnt := AVE(GROUP,IF(h.caption_counter = (TYPEOF(h.caption_counter))'',0,100));
    maxlength_caption_counter := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.caption_counter)));
    avelength_caption_counter := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.caption_counter)),h.caption_counter<>(typeof(h.caption_counter))'');
    populated_caption_1_pcnt := AVE(GROUP,IF(h.caption_1 = (TYPEOF(h.caption_1))'',0,100));
    maxlength_caption_1 := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.caption_1)));
    avelength_caption_1 := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.caption_1)),h.caption_1<>(typeof(h.caption_1))'');
    populated_caption_2_pcnt := AVE(GROUP,IF(h.caption_2 = (TYPEOF(h.caption_2))'',0,100));
    maxlength_caption_2 := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.caption_2)));
    avelength_caption_2 := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.caption_2)),h.caption_2<>(typeof(h.caption_2))'');
    populated_caption_3_pcnt := AVE(GROUP,IF(h.caption_3 = (TYPEOF(h.caption_3))'',0,100));
    maxlength_caption_3 := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.caption_3)));
    avelength_caption_3 := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.caption_3)),h.caption_3<>(typeof(h.caption_3))'');
    populated_caption_4_pcnt := AVE(GROUP,IF(h.caption_4 = (TYPEOF(h.caption_4))'',0,100));
    maxlength_caption_4 := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.caption_4)));
    avelength_caption_4 := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.caption_4)),h.caption_4<>(typeof(h.caption_4))'');
    populated_caption_5_pcnt := AVE(GROUP,IF(h.caption_5 = (TYPEOF(h.caption_5))'',0,100));
    maxlength_caption_5 := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.caption_5)));
    avelength_caption_5 := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.caption_5)),h.caption_5<>(typeof(h.caption_5))'');
    populated_caption_6_pcnt := AVE(GROUP,IF(h.caption_6 = (TYPEOF(h.caption_6))'',0,100));
    maxlength_caption_6 := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.caption_6)));
    avelength_caption_6 := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.caption_6)),h.caption_6<>(typeof(h.caption_6))'');
    populated_vanity_city_pcnt := AVE(GROUP,IF(h.vanity_city = (TYPEOF(h.vanity_city))'',0,100));
    maxlength_vanity_city := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.vanity_city)));
    avelength_vanity_city := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.vanity_city)),h.vanity_city<>(typeof(h.vanity_city))'');
    populated_bus_govt_indicator_pcnt := AVE(GROUP,IF(h.bus_govt_indicator = (TYPEOF(h.bus_govt_indicator))'',0,100));
    maxlength_bus_govt_indicator := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.bus_govt_indicator)));
    avelength_bus_govt_indicator := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.bus_govt_indicator)),h.bus_govt_indicator<>(typeof(h.bus_govt_indicator))'');
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
    populated_stated_addr_pcnt := AVE(GROUP,IF(h.stated_addr = (TYPEOF(h.stated_addr))'',0,100));
    maxlength_stated_addr := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.stated_addr)));
    avelength_stated_addr := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.stated_addr)),h.stated_addr<>(typeof(h.stated_addr))'');
    populated_stated_city_pcnt := AVE(GROUP,IF(h.stated_city = (TYPEOF(h.stated_city))'',0,100));
    maxlength_stated_city := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.stated_city)));
    avelength_stated_city := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.stated_city)),h.stated_city<>(typeof(h.stated_city))'');
    populated_stated_postal_code_pcnt := AVE(GROUP,IF(h.stated_postal_code = (TYPEOF(h.stated_postal_code))'',0,100));
    maxlength_stated_postal_code := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.stated_postal_code)));
    avelength_stated_postal_code := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.stated_postal_code)),h.stated_postal_code<>(typeof(h.stated_postal_code))'');
    populated_stated_bus_name_pcnt := AVE(GROUP,IF(h.stated_bus_name = (TYPEOF(h.stated_bus_name))'',0,100));
    maxlength_stated_bus_name := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.stated_bus_name)));
    avelength_stated_bus_name := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.stated_bus_name)),h.stated_bus_name<>(typeof(h.stated_bus_name))'');
    populated_verification_flag_pcnt := AVE(GROUP,IF(h.verification_flag = (TYPEOF(h.verification_flag))'',0,100));
    maxlength_verification_flag := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.verification_flag)));
    avelength_verification_flag := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.verification_flag)),h.verification_flag<>(typeof(h.verification_flag))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_record_id_pcnt *   0.00 / 100 + T.Populated_book_number_pcnt *   0.00 / 100 + T.Populated_pub_date_pcnt *   0.00 / 100 + T.Populated_business_name_pcnt *   0.00 / 100 + T.Populated_street_number_pcnt *   0.00 / 100 + T.Populated_street_name_pcnt *   0.00 / 100 + T.Populated_unit_designator_pcnt *   0.00 / 100 + T.Populated_unit_number_pcnt *   0.00 / 100 + T.Populated_city_pcnt *   0.00 / 100 + T.Populated_province_pcnt *   0.00 / 100 + T.Populated_postal_code_pcnt *   0.00 / 100 + T.Populated_area_code_pcnt *   0.00 / 100 + T.Populated_phone_number_pcnt *   0.00 / 100 + T.Populated_syph_1_pcnt *   0.00 / 100 + T.Populated_syph_2_pcnt *   0.00 / 100 + T.Populated_syph_3_pcnt *   0.00 / 100 + T.Populated_syph_4_pcnt *   0.00 / 100 + T.Populated_syph_5_pcnt *   0.00 / 100 + T.Populated_syph_6_pcnt *   0.00 / 100 + T.Populated_naics_1_pcnt *   0.00 / 100 + T.Populated_naics_2_pcnt *   0.00 / 100 + T.Populated_naics_3_pcnt *   0.00 / 100 + T.Populated_naics_4_pcnt *   0.00 / 100 + T.Populated_naics_5_pcnt *   0.00 / 100 + T.Populated_naics_6_pcnt *   0.00 / 100 + T.Populated_bdc_1_pcnt *   0.00 / 100 + T.Populated_bdc_2_pcnt *   0.00 / 100 + T.Populated_bdc_3_pcnt *   0.00 / 100 + T.Populated_bdc_4_pcnt *   0.00 / 100 + T.Populated_bdc_5_pcnt *   0.00 / 100 + T.Populated_bdc_6_pcnt *   0.00 / 100 + T.Populated_sic_1_pcnt *   0.00 / 100 + T.Populated_sic_2_pcnt *   0.00 / 100 + T.Populated_sic_3_pcnt *   0.00 / 100 + T.Populated_sic_4_pcnt *   0.00 / 100 + T.Populated_sic_5_pcnt *   0.00 / 100 + T.Populated_sic_6_pcnt *   0.00 / 100 + T.Populated_caption_counter_pcnt *   0.00 / 100 + T.Populated_caption_1_pcnt *   0.00 / 100 + T.Populated_caption_2_pcnt *   0.00 / 100 + T.Populated_caption_3_pcnt *   0.00 / 100 + T.Populated_caption_4_pcnt *   0.00 / 100 + T.Populated_caption_5_pcnt *   0.00 / 100 + T.Populated_caption_6_pcnt *   0.00 / 100 + T.Populated_vanity_city_pcnt *   0.00 / 100 + T.Populated_bus_govt_indicator_pcnt *   0.00 / 100 + T.Populated_latitude_pcnt *   0.00 / 100 + T.Populated_longitude_pcnt *   0.00 / 100 + T.Populated_lat_long_level_applied_pcnt *   0.00 / 100 + T.Populated_record_use_indicator_pcnt *   0.00 / 100 + T.Populated_email_pcnt *   0.00 / 100 + T.Populated_stated_addr_pcnt *   0.00 / 100 + T.Populated_stated_city_pcnt *   0.00 / 100 + T.Populated_stated_postal_code_pcnt *   0.00 / 100 + T.Populated_stated_bus_name_pcnt *   0.00 / 100 + T.Populated_verification_flag_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'record_id','book_number','pub_date','business_name','street_number','street_name','unit_designator','unit_number','city','province','postal_code','area_code','phone_number','syph_1','syph_2','syph_3','syph_4','syph_5','syph_6','naics_1','naics_2','naics_3','naics_4','naics_5','naics_6','bdc_1','bdc_2','bdc_3','bdc_4','bdc_5','bdc_6','sic_1','sic_2','sic_3','sic_4','sic_5','sic_6','caption_counter','caption_1','caption_2','caption_3','caption_4','caption_5','caption_6','vanity_city','bus_govt_indicator','latitude','longitude','lat_long_level_applied','record_use_indicator','email','stated_addr','stated_city','stated_postal_code','stated_bus_name','verification_flag');
  SELF.populated_pcnt := CHOOSE(C,le.populated_record_id_pcnt,le.populated_book_number_pcnt,le.populated_pub_date_pcnt,le.populated_business_name_pcnt,le.populated_street_number_pcnt,le.populated_street_name_pcnt,le.populated_unit_designator_pcnt,le.populated_unit_number_pcnt,le.populated_city_pcnt,le.populated_province_pcnt,le.populated_postal_code_pcnt,le.populated_area_code_pcnt,le.populated_phone_number_pcnt,le.populated_syph_1_pcnt,le.populated_syph_2_pcnt,le.populated_syph_3_pcnt,le.populated_syph_4_pcnt,le.populated_syph_5_pcnt,le.populated_syph_6_pcnt,le.populated_naics_1_pcnt,le.populated_naics_2_pcnt,le.populated_naics_3_pcnt,le.populated_naics_4_pcnt,le.populated_naics_5_pcnt,le.populated_naics_6_pcnt,le.populated_bdc_1_pcnt,le.populated_bdc_2_pcnt,le.populated_bdc_3_pcnt,le.populated_bdc_4_pcnt,le.populated_bdc_5_pcnt,le.populated_bdc_6_pcnt,le.populated_sic_1_pcnt,le.populated_sic_2_pcnt,le.populated_sic_3_pcnt,le.populated_sic_4_pcnt,le.populated_sic_5_pcnt,le.populated_sic_6_pcnt,le.populated_caption_counter_pcnt,le.populated_caption_1_pcnt,le.populated_caption_2_pcnt,le.populated_caption_3_pcnt,le.populated_caption_4_pcnt,le.populated_caption_5_pcnt,le.populated_caption_6_pcnt,le.populated_vanity_city_pcnt,le.populated_bus_govt_indicator_pcnt,le.populated_latitude_pcnt,le.populated_longitude_pcnt,le.populated_lat_long_level_applied_pcnt,le.populated_record_use_indicator_pcnt,le.populated_email_pcnt,le.populated_stated_addr_pcnt,le.populated_stated_city_pcnt,le.populated_stated_postal_code_pcnt,le.populated_stated_bus_name_pcnt,le.populated_verification_flag_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_record_id,le.maxlength_book_number,le.maxlength_pub_date,le.maxlength_business_name,le.maxlength_street_number,le.maxlength_street_name,le.maxlength_unit_designator,le.maxlength_unit_number,le.maxlength_city,le.maxlength_province,le.maxlength_postal_code,le.maxlength_area_code,le.maxlength_phone_number,le.maxlength_syph_1,le.maxlength_syph_2,le.maxlength_syph_3,le.maxlength_syph_4,le.maxlength_syph_5,le.maxlength_syph_6,le.maxlength_naics_1,le.maxlength_naics_2,le.maxlength_naics_3,le.maxlength_naics_4,le.maxlength_naics_5,le.maxlength_naics_6,le.maxlength_bdc_1,le.maxlength_bdc_2,le.maxlength_bdc_3,le.maxlength_bdc_4,le.maxlength_bdc_5,le.maxlength_bdc_6,le.maxlength_sic_1,le.maxlength_sic_2,le.maxlength_sic_3,le.maxlength_sic_4,le.maxlength_sic_5,le.maxlength_sic_6,le.maxlength_caption_counter,le.maxlength_caption_1,le.maxlength_caption_2,le.maxlength_caption_3,le.maxlength_caption_4,le.maxlength_caption_5,le.maxlength_caption_6,le.maxlength_vanity_city,le.maxlength_bus_govt_indicator,le.maxlength_latitude,le.maxlength_longitude,le.maxlength_lat_long_level_applied,le.maxlength_record_use_indicator,le.maxlength_email,le.maxlength_stated_addr,le.maxlength_stated_city,le.maxlength_stated_postal_code,le.maxlength_stated_bus_name,le.maxlength_verification_flag);
  SELF.avelength := CHOOSE(C,le.avelength_record_id,le.avelength_book_number,le.avelength_pub_date,le.avelength_business_name,le.avelength_street_number,le.avelength_street_name,le.avelength_unit_designator,le.avelength_unit_number,le.avelength_city,le.avelength_province,le.avelength_postal_code,le.avelength_area_code,le.avelength_phone_number,le.avelength_syph_1,le.avelength_syph_2,le.avelength_syph_3,le.avelength_syph_4,le.avelength_syph_5,le.avelength_syph_6,le.avelength_naics_1,le.avelength_naics_2,le.avelength_naics_3,le.avelength_naics_4,le.avelength_naics_5,le.avelength_naics_6,le.avelength_bdc_1,le.avelength_bdc_2,le.avelength_bdc_3,le.avelength_bdc_4,le.avelength_bdc_5,le.avelength_bdc_6,le.avelength_sic_1,le.avelength_sic_2,le.avelength_sic_3,le.avelength_sic_4,le.avelength_sic_5,le.avelength_sic_6,le.avelength_caption_counter,le.avelength_caption_1,le.avelength_caption_2,le.avelength_caption_3,le.avelength_caption_4,le.avelength_caption_5,le.avelength_caption_6,le.avelength_vanity_city,le.avelength_bus_govt_indicator,le.avelength_latitude,le.avelength_longitude,le.avelength_lat_long_level_applied,le.avelength_record_use_indicator,le.avelength_email,le.avelength_stated_addr,le.avelength_stated_city,le.avelength_stated_postal_code,le.avelength_stated_bus_name,le.avelength_verification_flag);
END;
EXPORT invSummary := NORMALIZE(summary0, 56, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT32.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT32.StrType)le.record_id),TRIM((SALT32.StrType)le.book_number),TRIM((SALT32.StrType)le.pub_date),TRIM((SALT32.StrType)le.business_name),TRIM((SALT32.StrType)le.street_number),TRIM((SALT32.StrType)le.street_name),TRIM((SALT32.StrType)le.unit_designator),TRIM((SALT32.StrType)le.unit_number),TRIM((SALT32.StrType)le.city),TRIM((SALT32.StrType)le.province),TRIM((SALT32.StrType)le.postal_code),TRIM((SALT32.StrType)le.area_code),TRIM((SALT32.StrType)le.phone_number),TRIM((SALT32.StrType)le.syph_1),TRIM((SALT32.StrType)le.syph_2),TRIM((SALT32.StrType)le.syph_3),TRIM((SALT32.StrType)le.syph_4),TRIM((SALT32.StrType)le.syph_5),TRIM((SALT32.StrType)le.syph_6),TRIM((SALT32.StrType)le.naics_1),TRIM((SALT32.StrType)le.naics_2),TRIM((SALT32.StrType)le.naics_3),TRIM((SALT32.StrType)le.naics_4),TRIM((SALT32.StrType)le.naics_5),TRIM((SALT32.StrType)le.naics_6),TRIM((SALT32.StrType)le.bdc_1),TRIM((SALT32.StrType)le.bdc_2),TRIM((SALT32.StrType)le.bdc_3),TRIM((SALT32.StrType)le.bdc_4),TRIM((SALT32.StrType)le.bdc_5),TRIM((SALT32.StrType)le.bdc_6),TRIM((SALT32.StrType)le.sic_1),TRIM((SALT32.StrType)le.sic_2),TRIM((SALT32.StrType)le.sic_3),TRIM((SALT32.StrType)le.sic_4),TRIM((SALT32.StrType)le.sic_5),TRIM((SALT32.StrType)le.sic_6),TRIM((SALT32.StrType)le.caption_counter),TRIM((SALT32.StrType)le.caption_1),TRIM((SALT32.StrType)le.caption_2),TRIM((SALT32.StrType)le.caption_3),TRIM((SALT32.StrType)le.caption_4),TRIM((SALT32.StrType)le.caption_5),TRIM((SALT32.StrType)le.caption_6),TRIM((SALT32.StrType)le.vanity_city),TRIM((SALT32.StrType)le.bus_govt_indicator),TRIM((SALT32.StrType)le.latitude),TRIM((SALT32.StrType)le.longitude),TRIM((SALT32.StrType)le.lat_long_level_applied),TRIM((SALT32.StrType)le.record_use_indicator),TRIM((SALT32.StrType)le.email),TRIM((SALT32.StrType)le.stated_addr),TRIM((SALT32.StrType)le.stated_city),TRIM((SALT32.StrType)le.stated_postal_code),TRIM((SALT32.StrType)le.stated_bus_name),TRIM((SALT32.StrType)le.verification_flag)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,56,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT32.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 56);
  SELF.FldNo2 := 1 + (C % 56);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT32.StrType)le.record_id),TRIM((SALT32.StrType)le.book_number),TRIM((SALT32.StrType)le.pub_date),TRIM((SALT32.StrType)le.business_name),TRIM((SALT32.StrType)le.street_number),TRIM((SALT32.StrType)le.street_name),TRIM((SALT32.StrType)le.unit_designator),TRIM((SALT32.StrType)le.unit_number),TRIM((SALT32.StrType)le.city),TRIM((SALT32.StrType)le.province),TRIM((SALT32.StrType)le.postal_code),TRIM((SALT32.StrType)le.area_code),TRIM((SALT32.StrType)le.phone_number),TRIM((SALT32.StrType)le.syph_1),TRIM((SALT32.StrType)le.syph_2),TRIM((SALT32.StrType)le.syph_3),TRIM((SALT32.StrType)le.syph_4),TRIM((SALT32.StrType)le.syph_5),TRIM((SALT32.StrType)le.syph_6),TRIM((SALT32.StrType)le.naics_1),TRIM((SALT32.StrType)le.naics_2),TRIM((SALT32.StrType)le.naics_3),TRIM((SALT32.StrType)le.naics_4),TRIM((SALT32.StrType)le.naics_5),TRIM((SALT32.StrType)le.naics_6),TRIM((SALT32.StrType)le.bdc_1),TRIM((SALT32.StrType)le.bdc_2),TRIM((SALT32.StrType)le.bdc_3),TRIM((SALT32.StrType)le.bdc_4),TRIM((SALT32.StrType)le.bdc_5),TRIM((SALT32.StrType)le.bdc_6),TRIM((SALT32.StrType)le.sic_1),TRIM((SALT32.StrType)le.sic_2),TRIM((SALT32.StrType)le.sic_3),TRIM((SALT32.StrType)le.sic_4),TRIM((SALT32.StrType)le.sic_5),TRIM((SALT32.StrType)le.sic_6),TRIM((SALT32.StrType)le.caption_counter),TRIM((SALT32.StrType)le.caption_1),TRIM((SALT32.StrType)le.caption_2),TRIM((SALT32.StrType)le.caption_3),TRIM((SALT32.StrType)le.caption_4),TRIM((SALT32.StrType)le.caption_5),TRIM((SALT32.StrType)le.caption_6),TRIM((SALT32.StrType)le.vanity_city),TRIM((SALT32.StrType)le.bus_govt_indicator),TRIM((SALT32.StrType)le.latitude),TRIM((SALT32.StrType)le.longitude),TRIM((SALT32.StrType)le.lat_long_level_applied),TRIM((SALT32.StrType)le.record_use_indicator),TRIM((SALT32.StrType)le.email),TRIM((SALT32.StrType)le.stated_addr),TRIM((SALT32.StrType)le.stated_city),TRIM((SALT32.StrType)le.stated_postal_code),TRIM((SALT32.StrType)le.stated_bus_name),TRIM((SALT32.StrType)le.verification_flag)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT32.StrType)le.record_id),TRIM((SALT32.StrType)le.book_number),TRIM((SALT32.StrType)le.pub_date),TRIM((SALT32.StrType)le.business_name),TRIM((SALT32.StrType)le.street_number),TRIM((SALT32.StrType)le.street_name),TRIM((SALT32.StrType)le.unit_designator),TRIM((SALT32.StrType)le.unit_number),TRIM((SALT32.StrType)le.city),TRIM((SALT32.StrType)le.province),TRIM((SALT32.StrType)le.postal_code),TRIM((SALT32.StrType)le.area_code),TRIM((SALT32.StrType)le.phone_number),TRIM((SALT32.StrType)le.syph_1),TRIM((SALT32.StrType)le.syph_2),TRIM((SALT32.StrType)le.syph_3),TRIM((SALT32.StrType)le.syph_4),TRIM((SALT32.StrType)le.syph_5),TRIM((SALT32.StrType)le.syph_6),TRIM((SALT32.StrType)le.naics_1),TRIM((SALT32.StrType)le.naics_2),TRIM((SALT32.StrType)le.naics_3),TRIM((SALT32.StrType)le.naics_4),TRIM((SALT32.StrType)le.naics_5),TRIM((SALT32.StrType)le.naics_6),TRIM((SALT32.StrType)le.bdc_1),TRIM((SALT32.StrType)le.bdc_2),TRIM((SALT32.StrType)le.bdc_3),TRIM((SALT32.StrType)le.bdc_4),TRIM((SALT32.StrType)le.bdc_5),TRIM((SALT32.StrType)le.bdc_6),TRIM((SALT32.StrType)le.sic_1),TRIM((SALT32.StrType)le.sic_2),TRIM((SALT32.StrType)le.sic_3),TRIM((SALT32.StrType)le.sic_4),TRIM((SALT32.StrType)le.sic_5),TRIM((SALT32.StrType)le.sic_6),TRIM((SALT32.StrType)le.caption_counter),TRIM((SALT32.StrType)le.caption_1),TRIM((SALT32.StrType)le.caption_2),TRIM((SALT32.StrType)le.caption_3),TRIM((SALT32.StrType)le.caption_4),TRIM((SALT32.StrType)le.caption_5),TRIM((SALT32.StrType)le.caption_6),TRIM((SALT32.StrType)le.vanity_city),TRIM((SALT32.StrType)le.bus_govt_indicator),TRIM((SALT32.StrType)le.latitude),TRIM((SALT32.StrType)le.longitude),TRIM((SALT32.StrType)le.lat_long_level_applied),TRIM((SALT32.StrType)le.record_use_indicator),TRIM((SALT32.StrType)le.email),TRIM((SALT32.StrType)le.stated_addr),TRIM((SALT32.StrType)le.stated_city),TRIM((SALT32.StrType)le.stated_postal_code),TRIM((SALT32.StrType)le.stated_bus_name),TRIM((SALT32.StrType)le.verification_flag)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),56*56,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'record_id'}
      ,{2,'book_number'}
      ,{3,'pub_date'}
      ,{4,'business_name'}
      ,{5,'street_number'}
      ,{6,'street_name'}
      ,{7,'unit_designator'}
      ,{8,'unit_number'}
      ,{9,'city'}
      ,{10,'province'}
      ,{11,'postal_code'}
      ,{12,'area_code'}
      ,{13,'phone_number'}
      ,{14,'syph_1'}
      ,{15,'syph_2'}
      ,{16,'syph_3'}
      ,{17,'syph_4'}
      ,{18,'syph_5'}
      ,{19,'syph_6'}
      ,{20,'naics_1'}
      ,{21,'naics_2'}
      ,{22,'naics_3'}
      ,{23,'naics_4'}
      ,{24,'naics_5'}
      ,{25,'naics_6'}
      ,{26,'bdc_1'}
      ,{27,'bdc_2'}
      ,{28,'bdc_3'}
      ,{29,'bdc_4'}
      ,{30,'bdc_5'}
      ,{31,'bdc_6'}
      ,{32,'sic_1'}
      ,{33,'sic_2'}
      ,{34,'sic_3'}
      ,{35,'sic_4'}
      ,{36,'sic_5'}
      ,{37,'sic_6'}
      ,{38,'caption_counter'}
      ,{39,'caption_1'}
      ,{40,'caption_2'}
      ,{41,'caption_3'}
      ,{42,'caption_4'}
      ,{43,'caption_5'}
      ,{44,'caption_6'}
      ,{45,'vanity_city'}
      ,{46,'bus_govt_indicator'}
      ,{47,'latitude'}
      ,{48,'longitude'}
      ,{49,'lat_long_level_applied'}
      ,{50,'record_use_indicator'}
      ,{51,'email'}
      ,{52,'stated_addr'}
      ,{53,'stated_city'}
      ,{54,'stated_postal_code'}
      ,{55,'stated_bus_name'}
      ,{56,'verification_flag'}],SALT32.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT32.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
EXPORT SrcProfiles := SALT32.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
EXPORT Correlations := SALT32.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Axciom_Bus_Fields.InValid_record_id((SALT32.StrType)le.record_id),
    Axciom_Bus_Fields.InValid_book_number((SALT32.StrType)le.book_number),
    Axciom_Bus_Fields.InValid_pub_date((SALT32.StrType)le.pub_date),
    Axciom_Bus_Fields.InValid_business_name((SALT32.StrType)le.business_name),
    Axciom_Bus_Fields.InValid_street_number((SALT32.StrType)le.street_number),
    Axciom_Bus_Fields.InValid_street_name((SALT32.StrType)le.street_name),
    Axciom_Bus_Fields.InValid_unit_designator((SALT32.StrType)le.unit_designator),
    Axciom_Bus_Fields.InValid_unit_number((SALT32.StrType)le.unit_number),
    Axciom_Bus_Fields.InValid_city((SALT32.StrType)le.city),
    Axciom_Bus_Fields.InValid_province((SALT32.StrType)le.province),
    Axciom_Bus_Fields.InValid_postal_code((SALT32.StrType)le.postal_code),
    Axciom_Bus_Fields.InValid_area_code((SALT32.StrType)le.area_code),
    Axciom_Bus_Fields.InValid_phone_number((SALT32.StrType)le.phone_number),
    Axciom_Bus_Fields.InValid_syph_1((SALT32.StrType)le.syph_1),
    Axciom_Bus_Fields.InValid_syph_2((SALT32.StrType)le.syph_2),
    Axciom_Bus_Fields.InValid_syph_3((SALT32.StrType)le.syph_3),
    Axciom_Bus_Fields.InValid_syph_4((SALT32.StrType)le.syph_4),
    Axciom_Bus_Fields.InValid_syph_5((SALT32.StrType)le.syph_5),
    Axciom_Bus_Fields.InValid_syph_6((SALT32.StrType)le.syph_6),
    Axciom_Bus_Fields.InValid_naics_1((SALT32.StrType)le.naics_1),
    Axciom_Bus_Fields.InValid_naics_2((SALT32.StrType)le.naics_2),
    Axciom_Bus_Fields.InValid_naics_3((SALT32.StrType)le.naics_3),
    Axciom_Bus_Fields.InValid_naics_4((SALT32.StrType)le.naics_4),
    Axciom_Bus_Fields.InValid_naics_5((SALT32.StrType)le.naics_5),
    Axciom_Bus_Fields.InValid_naics_6((SALT32.StrType)le.naics_6),
    Axciom_Bus_Fields.InValid_bdc_1((SALT32.StrType)le.bdc_1),
    Axciom_Bus_Fields.InValid_bdc_2((SALT32.StrType)le.bdc_2),
    Axciom_Bus_Fields.InValid_bdc_3((SALT32.StrType)le.bdc_3),
    Axciom_Bus_Fields.InValid_bdc_4((SALT32.StrType)le.bdc_4),
    Axciom_Bus_Fields.InValid_bdc_5((SALT32.StrType)le.bdc_5),
    Axciom_Bus_Fields.InValid_bdc_6((SALT32.StrType)le.bdc_6),
    Axciom_Bus_Fields.InValid_sic_1((SALT32.StrType)le.sic_1),
    Axciom_Bus_Fields.InValid_sic_2((SALT32.StrType)le.sic_2),
    Axciom_Bus_Fields.InValid_sic_3((SALT32.StrType)le.sic_3),
    Axciom_Bus_Fields.InValid_sic_4((SALT32.StrType)le.sic_4),
    Axciom_Bus_Fields.InValid_sic_5((SALT32.StrType)le.sic_5),
    Axciom_Bus_Fields.InValid_sic_6((SALT32.StrType)le.sic_6),
    Axciom_Bus_Fields.InValid_caption_counter((SALT32.StrType)le.caption_counter),
    Axciom_Bus_Fields.InValid_caption_1((SALT32.StrType)le.caption_1),
    Axciom_Bus_Fields.InValid_caption_2((SALT32.StrType)le.caption_2),
    Axciom_Bus_Fields.InValid_caption_3((SALT32.StrType)le.caption_3),
    Axciom_Bus_Fields.InValid_caption_4((SALT32.StrType)le.caption_4),
    Axciom_Bus_Fields.InValid_caption_5((SALT32.StrType)le.caption_5),
    Axciom_Bus_Fields.InValid_caption_6((SALT32.StrType)le.caption_6),
    Axciom_Bus_Fields.InValid_vanity_city((SALT32.StrType)le.vanity_city),
    Axciom_Bus_Fields.InValid_bus_govt_indicator((SALT32.StrType)le.bus_govt_indicator),
    Axciom_Bus_Fields.InValid_latitude((SALT32.StrType)le.latitude),
    Axciom_Bus_Fields.InValid_longitude((SALT32.StrType)le.longitude),
    Axciom_Bus_Fields.InValid_lat_long_level_applied((SALT32.StrType)le.lat_long_level_applied),
    Axciom_Bus_Fields.InValid_record_use_indicator((SALT32.StrType)le.record_use_indicator),
    Axciom_Bus_Fields.InValid_email((SALT32.StrType)le.email),
    Axciom_Bus_Fields.InValid_stated_addr((SALT32.StrType)le.stated_addr),
    Axciom_Bus_Fields.InValid_stated_city((SALT32.StrType)le.stated_city),
    Axciom_Bus_Fields.InValid_stated_postal_code((SALT32.StrType)le.stated_postal_code),
    Axciom_Bus_Fields.InValid_stated_bus_name((SALT32.StrType)le.stated_bus_name),
    Axciom_Bus_Fields.InValid_verification_flag((SALT32.StrType)le.verification_flag),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,56,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Axciom_Bus_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid_record_id','invalid_numeric','invalid_date','invalid_name','Unknown','invalid_address','invalid_address','invalid_address','invalid_city','invalid_province','invalid_canadian_zip','invalid_area_code','invalid_phone','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','invalid_city','invalid_bus_govt_indicator','invalid_numeric','invalid_numeric','invalid_lat_long_level_applied','invalid_record_use_indicator','invalid_email','invalid_address','invalid_city','invalid_canadian_zip','invalid_name','invalid_verification_flag');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Axciom_Bus_Fields.InValidMessage_record_id(TotalErrors.ErrorNum),Axciom_Bus_Fields.InValidMessage_book_number(TotalErrors.ErrorNum),Axciom_Bus_Fields.InValidMessage_pub_date(TotalErrors.ErrorNum),Axciom_Bus_Fields.InValidMessage_business_name(TotalErrors.ErrorNum),Axciom_Bus_Fields.InValidMessage_street_number(TotalErrors.ErrorNum),Axciom_Bus_Fields.InValidMessage_street_name(TotalErrors.ErrorNum),Axciom_Bus_Fields.InValidMessage_unit_designator(TotalErrors.ErrorNum),Axciom_Bus_Fields.InValidMessage_unit_number(TotalErrors.ErrorNum),Axciom_Bus_Fields.InValidMessage_city(TotalErrors.ErrorNum),Axciom_Bus_Fields.InValidMessage_province(TotalErrors.ErrorNum),Axciom_Bus_Fields.InValidMessage_postal_code(TotalErrors.ErrorNum),Axciom_Bus_Fields.InValidMessage_area_code(TotalErrors.ErrorNum),Axciom_Bus_Fields.InValidMessage_phone_number(TotalErrors.ErrorNum),Axciom_Bus_Fields.InValidMessage_syph_1(TotalErrors.ErrorNum),Axciom_Bus_Fields.InValidMessage_syph_2(TotalErrors.ErrorNum),Axciom_Bus_Fields.InValidMessage_syph_3(TotalErrors.ErrorNum),Axciom_Bus_Fields.InValidMessage_syph_4(TotalErrors.ErrorNum),Axciom_Bus_Fields.InValidMessage_syph_5(TotalErrors.ErrorNum),Axciom_Bus_Fields.InValidMessage_syph_6(TotalErrors.ErrorNum),Axciom_Bus_Fields.InValidMessage_naics_1(TotalErrors.ErrorNum),Axciom_Bus_Fields.InValidMessage_naics_2(TotalErrors.ErrorNum),Axciom_Bus_Fields.InValidMessage_naics_3(TotalErrors.ErrorNum),Axciom_Bus_Fields.InValidMessage_naics_4(TotalErrors.ErrorNum),Axciom_Bus_Fields.InValidMessage_naics_5(TotalErrors.ErrorNum),Axciom_Bus_Fields.InValidMessage_naics_6(TotalErrors.ErrorNum),Axciom_Bus_Fields.InValidMessage_bdc_1(TotalErrors.ErrorNum),Axciom_Bus_Fields.InValidMessage_bdc_2(TotalErrors.ErrorNum),Axciom_Bus_Fields.InValidMessage_bdc_3(TotalErrors.ErrorNum),Axciom_Bus_Fields.InValidMessage_bdc_4(TotalErrors.ErrorNum),Axciom_Bus_Fields.InValidMessage_bdc_5(TotalErrors.ErrorNum),Axciom_Bus_Fields.InValidMessage_bdc_6(TotalErrors.ErrorNum),Axciom_Bus_Fields.InValidMessage_sic_1(TotalErrors.ErrorNum),Axciom_Bus_Fields.InValidMessage_sic_2(TotalErrors.ErrorNum),Axciom_Bus_Fields.InValidMessage_sic_3(TotalErrors.ErrorNum),Axciom_Bus_Fields.InValidMessage_sic_4(TotalErrors.ErrorNum),Axciom_Bus_Fields.InValidMessage_sic_5(TotalErrors.ErrorNum),Axciom_Bus_Fields.InValidMessage_sic_6(TotalErrors.ErrorNum),Axciom_Bus_Fields.InValidMessage_caption_counter(TotalErrors.ErrorNum),Axciom_Bus_Fields.InValidMessage_caption_1(TotalErrors.ErrorNum),Axciom_Bus_Fields.InValidMessage_caption_2(TotalErrors.ErrorNum),Axciom_Bus_Fields.InValidMessage_caption_3(TotalErrors.ErrorNum),Axciom_Bus_Fields.InValidMessage_caption_4(TotalErrors.ErrorNum),Axciom_Bus_Fields.InValidMessage_caption_5(TotalErrors.ErrorNum),Axciom_Bus_Fields.InValidMessage_caption_6(TotalErrors.ErrorNum),Axciom_Bus_Fields.InValidMessage_vanity_city(TotalErrors.ErrorNum),Axciom_Bus_Fields.InValidMessage_bus_govt_indicator(TotalErrors.ErrorNum),Axciom_Bus_Fields.InValidMessage_latitude(TotalErrors.ErrorNum),Axciom_Bus_Fields.InValidMessage_longitude(TotalErrors.ErrorNum),Axciom_Bus_Fields.InValidMessage_lat_long_level_applied(TotalErrors.ErrorNum),Axciom_Bus_Fields.InValidMessage_record_use_indicator(TotalErrors.ErrorNum),Axciom_Bus_Fields.InValidMessage_email(TotalErrors.ErrorNum),Axciom_Bus_Fields.InValidMessage_stated_addr(TotalErrors.ErrorNum),Axciom_Bus_Fields.InValidMessage_stated_city(TotalErrors.ErrorNum),Axciom_Bus_Fields.InValidMessage_stated_postal_code(TotalErrors.ErrorNum),Axciom_Bus_Fields.InValidMessage_stated_bus_name(TotalErrors.ErrorNum),Axciom_Bus_Fields.InValidMessage_verification_flag(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
END;
