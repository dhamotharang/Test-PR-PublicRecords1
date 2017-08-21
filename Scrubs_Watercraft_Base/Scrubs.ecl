IMPORT ut,SALT30;
EXPORT Scrubs := MODULE
// The module to handle the case where no scrubs exist
  EXPORT  Expanded_Layout := RECORD(Layout_Watercraft_Base)
    UNSIGNED1 watercraft_key_Invalid;
    UNSIGNED1 state_origin_Invalid;
    UNSIGNED1 source_code_Invalid;
    UNSIGNED1 st_registration_Invalid;
    UNSIGNED1 county_registration_Invalid;
    UNSIGNED1 registration_number_Invalid;
    UNSIGNED1 hull_number_Invalid;
    UNSIGNED1 model_year_Invalid;
    UNSIGNED1 watercraft_length_Invalid;
    UNSIGNED1 watercraft_width_Invalid;
    UNSIGNED1 watercraft_weight_Invalid;
    UNSIGNED1 registration_date_Invalid;
    UNSIGNED1 registration_expiration_date_Invalid;
    UNSIGNED1 registration_status_date_Invalid;
    UNSIGNED1 registration_renewal_date_Invalid;
    UNSIGNED1 decal_number_Invalid;
    UNSIGNED1 title_state_Invalid;
    UNSIGNED1 title_issue_date_Invalid;
    UNSIGNED1 lien_1_name_Invalid;
    UNSIGNED1 lien_1_date_Invalid;
    UNSIGNED1 lien_1_address_1_Invalid;
    UNSIGNED1 lien_1_address_2_Invalid;
    UNSIGNED1 lien_1_city_Invalid;
    UNSIGNED1 lien_1_state_Invalid;
    UNSIGNED1 lien_1_zip_Invalid;
    UNSIGNED1 lien_2_name_Invalid;
    UNSIGNED1 lien_2_date_Invalid;
    UNSIGNED1 lien_2_address_1_Invalid;
    UNSIGNED1 lien_2_address_2_Invalid;
    UNSIGNED1 lien_2_city_Invalid;
    UNSIGNED1 lien_2_state_Invalid;
    UNSIGNED1 lien_2_zip_Invalid;
    UNSIGNED1 state_purchased_Invalid;
    UNSIGNED1 purchase_date_Invalid;
    UNSIGNED1 history_flag_Invalid;
    UNSIGNED1 persistent_record_id_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Layout_Watercraft_Base)
    UNSIGNED8 ScrubsBits1;
    UNSIGNED8 ScrubsBits2;
  END;
EXPORT FromNone(DATASET(Layout_Watercraft_Base) h) := MODULE
  Expanded_Layout into(h le) := TRANSFORM
    SELF.watercraft_key_Invalid := Fields.InValid_watercraft_key((SALT30.StrType)le.watercraft_key);
    SELF.state_origin_Invalid := Fields.InValid_state_origin((SALT30.StrType)le.state_origin);
    SELF.source_code_Invalid := Fields.InValid_source_code((SALT30.StrType)le.source_code);
    SELF.st_registration_Invalid := Fields.InValid_st_registration((SALT30.StrType)le.st_registration);
    SELF.county_registration_Invalid := Fields.InValid_county_registration((SALT30.StrType)le.county_registration);
    SELF.registration_number_Invalid := Fields.InValid_registration_number((SALT30.StrType)le.registration_number);
    SELF.hull_number_Invalid := Fields.InValid_hull_number((SALT30.StrType)le.hull_number);
    SELF.model_year_Invalid := Fields.InValid_model_year((SALT30.StrType)le.model_year);
    SELF.watercraft_length_Invalid := Fields.InValid_watercraft_length((SALT30.StrType)le.watercraft_length);
    SELF.watercraft_width_Invalid := Fields.InValid_watercraft_width((SALT30.StrType)le.watercraft_width);
    SELF.watercraft_weight_Invalid := Fields.InValid_watercraft_weight((SALT30.StrType)le.watercraft_weight);
    SELF.registration_date_Invalid := Fields.InValid_registration_date((SALT30.StrType)le.registration_date);
    SELF.registration_expiration_date_Invalid := Fields.InValid_registration_expiration_date((SALT30.StrType)le.registration_expiration_date);
    SELF.registration_status_date_Invalid := Fields.InValid_registration_status_date((SALT30.StrType)le.registration_status_date);
    SELF.registration_renewal_date_Invalid := Fields.InValid_registration_renewal_date((SALT30.StrType)le.registration_renewal_date);
    SELF.decal_number_Invalid := Fields.InValid_decal_number((SALT30.StrType)le.decal_number);
    SELF.title_state_Invalid := Fields.InValid_title_state((SALT30.StrType)le.title_state);
    SELF.title_issue_date_Invalid := Fields.InValid_title_issue_date((SALT30.StrType)le.title_issue_date);
    SELF.lien_1_name_Invalid := Fields.InValid_lien_1_name((SALT30.StrType)le.lien_1_name);
    SELF.lien_1_date_Invalid := Fields.InValid_lien_1_date((SALT30.StrType)le.lien_1_date);
    SELF.lien_1_address_1_Invalid := Fields.InValid_lien_1_address_1((SALT30.StrType)le.lien_1_address_1);
    SELF.lien_1_address_2_Invalid := Fields.InValid_lien_1_address_2((SALT30.StrType)le.lien_1_address_2);
    SELF.lien_1_city_Invalid := Fields.InValid_lien_1_city((SALT30.StrType)le.lien_1_city);
    SELF.lien_1_state_Invalid := Fields.InValid_lien_1_state((SALT30.StrType)le.lien_1_state);
    SELF.lien_1_zip_Invalid := Fields.InValid_lien_1_zip((SALT30.StrType)le.lien_1_zip);
    SELF.lien_2_name_Invalid := Fields.InValid_lien_2_name((SALT30.StrType)le.lien_2_name);
    SELF.lien_2_date_Invalid := Fields.InValid_lien_2_date((SALT30.StrType)le.lien_2_date);
    SELF.lien_2_address_1_Invalid := Fields.InValid_lien_2_address_1((SALT30.StrType)le.lien_2_address_1);
    SELF.lien_2_address_2_Invalid := Fields.InValid_lien_2_address_2((SALT30.StrType)le.lien_2_address_2);
    SELF.lien_2_city_Invalid := Fields.InValid_lien_2_city((SALT30.StrType)le.lien_2_city);
    SELF.lien_2_state_Invalid := Fields.InValid_lien_2_state((SALT30.StrType)le.lien_2_state);
    SELF.lien_2_zip_Invalid := Fields.InValid_lien_2_zip((SALT30.StrType)le.lien_2_zip);
    SELF.state_purchased_Invalid := Fields.InValid_state_purchased((SALT30.StrType)le.state_purchased);
    SELF.purchase_date_Invalid := Fields.InValid_purchase_date((SALT30.StrType)le.purchase_date);
    SELF.history_flag_Invalid := Fields.InValid_history_flag((SALT30.StrType)le.history_flag);
    SELF.persistent_record_id_Invalid := Fields.InValid_persistent_record_id((SALT30.StrType)le.persistent_record_id);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.watercraft_key_Invalid << 0 ) + ( le.state_origin_Invalid << 1 ) + ( le.source_code_Invalid << 3 ) + ( le.st_registration_Invalid << 5 ) + ( le.county_registration_Invalid << 7 ) + ( le.registration_number_Invalid << 9 ) + ( le.hull_number_Invalid << 11 ) + ( le.model_year_Invalid << 13 ) + ( le.watercraft_length_Invalid << 15 ) + ( le.watercraft_width_Invalid << 17 ) + ( le.watercraft_weight_Invalid << 19 ) + ( le.registration_date_Invalid << 21 ) + ( le.registration_expiration_date_Invalid << 23 ) + ( le.registration_status_date_Invalid << 25 ) + ( le.registration_renewal_date_Invalid << 27 ) + ( le.decal_number_Invalid << 29 ) + ( le.title_state_Invalid << 31 ) + ( le.title_issue_date_Invalid << 33 ) + ( le.lien_1_name_Invalid << 35 ) + ( le.lien_1_date_Invalid << 37 ) + ( le.lien_1_address_1_Invalid << 39 ) + ( le.lien_1_address_2_Invalid << 41 ) + ( le.lien_1_city_Invalid << 43 ) + ( le.lien_1_state_Invalid << 45 ) + ( le.lien_1_zip_Invalid << 47 ) + ( le.lien_2_name_Invalid << 49 ) + ( le.lien_2_date_Invalid << 51 ) + ( le.lien_2_address_1_Invalid << 53 ) + ( le.lien_2_address_2_Invalid << 55 ) + ( le.lien_2_city_Invalid << 57 ) + ( le.lien_2_state_Invalid << 59 ) + ( le.lien_2_zip_Invalid << 61 );
    SELF.ScrubsBits2 := ( le.state_purchased_Invalid << 0 ) + ( le.purchase_date_Invalid << 2 ) + ( le.history_flag_Invalid << 4 ) + ( le.persistent_record_id_Invalid << 6 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Layout_Watercraft_Base);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.watercraft_key_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.state_origin_Invalid := (le.ScrubsBits1 >> 1) & 3;
    SELF.source_code_Invalid := (le.ScrubsBits1 >> 3) & 3;
    SELF.st_registration_Invalid := (le.ScrubsBits1 >> 5) & 3;
    SELF.county_registration_Invalid := (le.ScrubsBits1 >> 7) & 3;
    SELF.registration_number_Invalid := (le.ScrubsBits1 >> 9) & 3;
    SELF.hull_number_Invalid := (le.ScrubsBits1 >> 11) & 3;
    SELF.model_year_Invalid := (le.ScrubsBits1 >> 13) & 3;
    SELF.watercraft_length_Invalid := (le.ScrubsBits1 >> 15) & 3;
    SELF.watercraft_width_Invalid := (le.ScrubsBits1 >> 17) & 3;
    SELF.watercraft_weight_Invalid := (le.ScrubsBits1 >> 19) & 3;
    SELF.registration_date_Invalid := (le.ScrubsBits1 >> 21) & 3;
    SELF.registration_expiration_date_Invalid := (le.ScrubsBits1 >> 23) & 3;
    SELF.registration_status_date_Invalid := (le.ScrubsBits1 >> 25) & 3;
    SELF.registration_renewal_date_Invalid := (le.ScrubsBits1 >> 27) & 3;
    SELF.decal_number_Invalid := (le.ScrubsBits1 >> 29) & 3;
    SELF.title_state_Invalid := (le.ScrubsBits1 >> 31) & 3;
    SELF.title_issue_date_Invalid := (le.ScrubsBits1 >> 33) & 3;
    SELF.lien_1_name_Invalid := (le.ScrubsBits1 >> 35) & 3;
    SELF.lien_1_date_Invalid := (le.ScrubsBits1 >> 37) & 3;
    SELF.lien_1_address_1_Invalid := (le.ScrubsBits1 >> 39) & 3;
    SELF.lien_1_address_2_Invalid := (le.ScrubsBits1 >> 41) & 3;
    SELF.lien_1_city_Invalid := (le.ScrubsBits1 >> 43) & 3;
    SELF.lien_1_state_Invalid := (le.ScrubsBits1 >> 45) & 3;
    SELF.lien_1_zip_Invalid := (le.ScrubsBits1 >> 47) & 3;
    SELF.lien_2_name_Invalid := (le.ScrubsBits1 >> 49) & 3;
    SELF.lien_2_date_Invalid := (le.ScrubsBits1 >> 51) & 3;
    SELF.lien_2_address_1_Invalid := (le.ScrubsBits1 >> 53) & 3;
    SELF.lien_2_address_2_Invalid := (le.ScrubsBits1 >> 55) & 3;
    SELF.lien_2_city_Invalid := (le.ScrubsBits1 >> 57) & 3;
    SELF.lien_2_state_Invalid := (le.ScrubsBits1 >> 59) & 3;
    SELF.lien_2_zip_Invalid := (le.ScrubsBits1 >> 61) & 3;
    SELF.state_purchased_Invalid := (le.ScrubsBits2 >> 0) & 3;
    SELF.purchase_date_Invalid := (le.ScrubsBits2 >> 2) & 3;
    SELF.history_flag_Invalid := (le.ScrubsBits2 >> 4) & 3;
    SELF.persistent_record_id_Invalid := (le.ScrubsBits2 >> 6) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    h.source_code;
    TotalCnt := COUNT(GROUP); // Number of records in total
    watercraft_key_LENGTH_ErrorCount := COUNT(GROUP,h.watercraft_key_Invalid=1);
    state_origin_ALLOW_ErrorCount := COUNT(GROUP,h.state_origin_Invalid=1);
    state_origin_LENGTH_ErrorCount := COUNT(GROUP,h.state_origin_Invalid=2);
    state_origin_Total_ErrorCount := COUNT(GROUP,h.state_origin_Invalid>0);
    source_code_ALLOW_ErrorCount := COUNT(GROUP,h.source_code_Invalid=1);
    source_code_LENGTH_ErrorCount := COUNT(GROUP,h.source_code_Invalid=2);
    source_code_Total_ErrorCount := COUNT(GROUP,h.source_code_Invalid>0);
    st_registration_ALLOW_ErrorCount := COUNT(GROUP,h.st_registration_Invalid=1);
    st_registration_LENGTH_ErrorCount := COUNT(GROUP,h.st_registration_Invalid=2);
    st_registration_Total_ErrorCount := COUNT(GROUP,h.st_registration_Invalid>0);
    county_registration_CAPS_ErrorCount := COUNT(GROUP,h.county_registration_Invalid=1);
    county_registration_ALLOW_ErrorCount := COUNT(GROUP,h.county_registration_Invalid=2);
    county_registration_LENGTH_ErrorCount := COUNT(GROUP,h.county_registration_Invalid=3);
    county_registration_Total_ErrorCount := COUNT(GROUP,h.county_registration_Invalid>0);
    registration_number_CAPS_ErrorCount := COUNT(GROUP,h.registration_number_Invalid=1);
    registration_number_ALLOW_ErrorCount := COUNT(GROUP,h.registration_number_Invalid=2);
    registration_number_LENGTH_ErrorCount := COUNT(GROUP,h.registration_number_Invalid=3);
    registration_number_Total_ErrorCount := COUNT(GROUP,h.registration_number_Invalid>0);
    hull_number_ALLOW_ErrorCount := COUNT(GROUP,h.hull_number_Invalid=1);
    hull_number_LENGTH_ErrorCount := COUNT(GROUP,h.hull_number_Invalid=2);
    hull_number_Total_ErrorCount := COUNT(GROUP,h.hull_number_Invalid>0);
    model_year_ALLOW_ErrorCount := COUNT(GROUP,h.model_year_Invalid=1);
    model_year_LENGTH_ErrorCount := COUNT(GROUP,h.model_year_Invalid=2);
    model_year_Total_ErrorCount := COUNT(GROUP,h.model_year_Invalid>0);
    watercraft_length_ALLOW_ErrorCount := COUNT(GROUP,h.watercraft_length_Invalid=1);
    watercraft_length_LENGTH_ErrorCount := COUNT(GROUP,h.watercraft_length_Invalid=2);
    watercraft_length_Total_ErrorCount := COUNT(GROUP,h.watercraft_length_Invalid>0);
    watercraft_width_ALLOW_ErrorCount := COUNT(GROUP,h.watercraft_width_Invalid=1);
    watercraft_width_LENGTH_ErrorCount := COUNT(GROUP,h.watercraft_width_Invalid=2);
    watercraft_width_Total_ErrorCount := COUNT(GROUP,h.watercraft_width_Invalid>0);
    watercraft_weight_ALLOW_ErrorCount := COUNT(GROUP,h.watercraft_weight_Invalid=1);
    watercraft_weight_LENGTH_ErrorCount := COUNT(GROUP,h.watercraft_weight_Invalid=2);
    watercraft_weight_Total_ErrorCount := COUNT(GROUP,h.watercraft_weight_Invalid>0);
    registration_date_ALLOW_ErrorCount := COUNT(GROUP,h.registration_date_Invalid=1);
    registration_date_LENGTH_ErrorCount := COUNT(GROUP,h.registration_date_Invalid=2);
    registration_date_Total_ErrorCount := COUNT(GROUP,h.registration_date_Invalid>0);
    registration_expiration_date_ALLOW_ErrorCount := COUNT(GROUP,h.registration_expiration_date_Invalid=1);
    registration_expiration_date_LENGTH_ErrorCount := COUNT(GROUP,h.registration_expiration_date_Invalid=2);
    registration_expiration_date_Total_ErrorCount := COUNT(GROUP,h.registration_expiration_date_Invalid>0);
    registration_status_date_ALLOW_ErrorCount := COUNT(GROUP,h.registration_status_date_Invalid=1);
    registration_status_date_LENGTH_ErrorCount := COUNT(GROUP,h.registration_status_date_Invalid=2);
    registration_status_date_Total_ErrorCount := COUNT(GROUP,h.registration_status_date_Invalid>0);
    registration_renewal_date_ALLOW_ErrorCount := COUNT(GROUP,h.registration_renewal_date_Invalid=1);
    registration_renewal_date_LENGTH_ErrorCount := COUNT(GROUP,h.registration_renewal_date_Invalid=2);
    registration_renewal_date_Total_ErrorCount := COUNT(GROUP,h.registration_renewal_date_Invalid>0);
    decal_number_CAPS_ErrorCount := COUNT(GROUP,h.decal_number_Invalid=1);
    decal_number_ALLOW_ErrorCount := COUNT(GROUP,h.decal_number_Invalid=2);
    decal_number_LENGTH_ErrorCount := COUNT(GROUP,h.decal_number_Invalid=3);
    decal_number_Total_ErrorCount := COUNT(GROUP,h.decal_number_Invalid>0);
    title_state_ALLOW_ErrorCount := COUNT(GROUP,h.title_state_Invalid=1);
    title_state_LENGTH_ErrorCount := COUNT(GROUP,h.title_state_Invalid=2);
    title_state_Total_ErrorCount := COUNT(GROUP,h.title_state_Invalid>0);
    title_issue_date_ALLOW_ErrorCount := COUNT(GROUP,h.title_issue_date_Invalid=1);
    title_issue_date_LENGTH_ErrorCount := COUNT(GROUP,h.title_issue_date_Invalid=2);
    title_issue_date_Total_ErrorCount := COUNT(GROUP,h.title_issue_date_Invalid>0);
    lien_1_name_CAPS_ErrorCount := COUNT(GROUP,h.lien_1_name_Invalid=1);
    lien_1_name_ALLOW_ErrorCount := COUNT(GROUP,h.lien_1_name_Invalid=2);
    lien_1_name_LENGTH_ErrorCount := COUNT(GROUP,h.lien_1_name_Invalid=3);
    lien_1_name_Total_ErrorCount := COUNT(GROUP,h.lien_1_name_Invalid>0);
    lien_1_date_ALLOW_ErrorCount := COUNT(GROUP,h.lien_1_date_Invalid=1);
    lien_1_date_LENGTH_ErrorCount := COUNT(GROUP,h.lien_1_date_Invalid=2);
    lien_1_date_Total_ErrorCount := COUNT(GROUP,h.lien_1_date_Invalid>0);
    lien_1_address_1_CAPS_ErrorCount := COUNT(GROUP,h.lien_1_address_1_Invalid=1);
    lien_1_address_1_ALLOW_ErrorCount := COUNT(GROUP,h.lien_1_address_1_Invalid=2);
    lien_1_address_1_LENGTH_ErrorCount := COUNT(GROUP,h.lien_1_address_1_Invalid=3);
    lien_1_address_1_Total_ErrorCount := COUNT(GROUP,h.lien_1_address_1_Invalid>0);
    lien_1_address_2_CAPS_ErrorCount := COUNT(GROUP,h.lien_1_address_2_Invalid=1);
    lien_1_address_2_ALLOW_ErrorCount := COUNT(GROUP,h.lien_1_address_2_Invalid=2);
    lien_1_address_2_LENGTH_ErrorCount := COUNT(GROUP,h.lien_1_address_2_Invalid=3);
    lien_1_address_2_Total_ErrorCount := COUNT(GROUP,h.lien_1_address_2_Invalid>0);
    lien_1_city_CAPS_ErrorCount := COUNT(GROUP,h.lien_1_city_Invalid=1);
    lien_1_city_ALLOW_ErrorCount := COUNT(GROUP,h.lien_1_city_Invalid=2);
    lien_1_city_LENGTH_ErrorCount := COUNT(GROUP,h.lien_1_city_Invalid=3);
    lien_1_city_Total_ErrorCount := COUNT(GROUP,h.lien_1_city_Invalid>0);
    lien_1_state_ALLOW_ErrorCount := COUNT(GROUP,h.lien_1_state_Invalid=1);
    lien_1_state_LENGTH_ErrorCount := COUNT(GROUP,h.lien_1_state_Invalid=2);
    lien_1_state_Total_ErrorCount := COUNT(GROUP,h.lien_1_state_Invalid>0);
    lien_1_zip_ALLOW_ErrorCount := COUNT(GROUP,h.lien_1_zip_Invalid=1);
    lien_1_zip_LENGTH_ErrorCount := COUNT(GROUP,h.lien_1_zip_Invalid=2);
    lien_1_zip_Total_ErrorCount := COUNT(GROUP,h.lien_1_zip_Invalid>0);
    lien_2_name_CAPS_ErrorCount := COUNT(GROUP,h.lien_2_name_Invalid=1);
    lien_2_name_ALLOW_ErrorCount := COUNT(GROUP,h.lien_2_name_Invalid=2);
    lien_2_name_LENGTH_ErrorCount := COUNT(GROUP,h.lien_2_name_Invalid=3);
    lien_2_name_Total_ErrorCount := COUNT(GROUP,h.lien_2_name_Invalid>0);
    lien_2_date_ALLOW_ErrorCount := COUNT(GROUP,h.lien_2_date_Invalid=1);
    lien_2_date_LENGTH_ErrorCount := COUNT(GROUP,h.lien_2_date_Invalid=2);
    lien_2_date_Total_ErrorCount := COUNT(GROUP,h.lien_2_date_Invalid>0);
    lien_2_address_1_CAPS_ErrorCount := COUNT(GROUP,h.lien_2_address_1_Invalid=1);
    lien_2_address_1_ALLOW_ErrorCount := COUNT(GROUP,h.lien_2_address_1_Invalid=2);
    lien_2_address_1_LENGTH_ErrorCount := COUNT(GROUP,h.lien_2_address_1_Invalid=3);
    lien_2_address_1_Total_ErrorCount := COUNT(GROUP,h.lien_2_address_1_Invalid>0);
    lien_2_address_2_CAPS_ErrorCount := COUNT(GROUP,h.lien_2_address_2_Invalid=1);
    lien_2_address_2_ALLOW_ErrorCount := COUNT(GROUP,h.lien_2_address_2_Invalid=2);
    lien_2_address_2_LENGTH_ErrorCount := COUNT(GROUP,h.lien_2_address_2_Invalid=3);
    lien_2_address_2_Total_ErrorCount := COUNT(GROUP,h.lien_2_address_2_Invalid>0);
    lien_2_city_CAPS_ErrorCount := COUNT(GROUP,h.lien_2_city_Invalid=1);
    lien_2_city_ALLOW_ErrorCount := COUNT(GROUP,h.lien_2_city_Invalid=2);
    lien_2_city_LENGTH_ErrorCount := COUNT(GROUP,h.lien_2_city_Invalid=3);
    lien_2_city_Total_ErrorCount := COUNT(GROUP,h.lien_2_city_Invalid>0);
    lien_2_state_ALLOW_ErrorCount := COUNT(GROUP,h.lien_2_state_Invalid=1);
    lien_2_state_LENGTH_ErrorCount := COUNT(GROUP,h.lien_2_state_Invalid=2);
    lien_2_state_Total_ErrorCount := COUNT(GROUP,h.lien_2_state_Invalid>0);
    lien_2_zip_ALLOW_ErrorCount := COUNT(GROUP,h.lien_2_zip_Invalid=1);
    lien_2_zip_LENGTH_ErrorCount := COUNT(GROUP,h.lien_2_zip_Invalid=2);
    lien_2_zip_Total_ErrorCount := COUNT(GROUP,h.lien_2_zip_Invalid>0);
    state_purchased_ALLOW_ErrorCount := COUNT(GROUP,h.state_purchased_Invalid=1);
    state_purchased_LENGTH_ErrorCount := COUNT(GROUP,h.state_purchased_Invalid=2);
    state_purchased_Total_ErrorCount := COUNT(GROUP,h.state_purchased_Invalid>0);
    purchase_date_ALLOW_ErrorCount := COUNT(GROUP,h.purchase_date_Invalid=1);
    purchase_date_LENGTH_ErrorCount := COUNT(GROUP,h.purchase_date_Invalid=2);
    purchase_date_Total_ErrorCount := COUNT(GROUP,h.purchase_date_Invalid>0);
    history_flag_ENUM_ErrorCount := COUNT(GROUP,h.history_flag_Invalid=1);
    history_flag_LENGTH_ErrorCount := COUNT(GROUP,h.history_flag_Invalid=2);
    history_flag_Total_ErrorCount := COUNT(GROUP,h.history_flag_Invalid>0);
    persistent_record_id_LENGTH_ErrorCount := COUNT(GROUP,h.persistent_record_id_Invalid=1);
  END;
  EXPORT SummaryStats := TABLE(h,r,source_code,FEW);
  r := RECORD
    STRING10 Src;
    STRING FieldName;
    STRING FieldType;
    STRING ErrorType;
    SALT30.StrType ErrorMessage;
    SALT30.StrType FieldContents;
  END;
  r into(h le,UNSIGNED c) := TRANSFORM
    SELF.Src :=  le.source_code;
    UNSIGNED1 ErrNum := CHOOSE(c,le.watercraft_key_Invalid,le.state_origin_Invalid,le.source_code_Invalid,le.st_registration_Invalid,le.county_registration_Invalid,le.registration_number_Invalid,le.hull_number_Invalid,le.model_year_Invalid,le.watercraft_length_Invalid,le.watercraft_width_Invalid,le.watercraft_weight_Invalid,le.registration_date_Invalid,le.registration_expiration_date_Invalid,le.registration_status_date_Invalid,le.registration_renewal_date_Invalid,le.decal_number_Invalid,le.title_state_Invalid,le.title_issue_date_Invalid,le.lien_1_name_Invalid,le.lien_1_date_Invalid,le.lien_1_address_1_Invalid,le.lien_1_address_2_Invalid,le.lien_1_city_Invalid,le.lien_1_state_Invalid,le.lien_1_zip_Invalid,le.lien_2_name_Invalid,le.lien_2_date_Invalid,le.lien_2_address_1_Invalid,le.lien_2_address_2_Invalid,le.lien_2_city_Invalid,le.lien_2_state_Invalid,le.lien_2_zip_Invalid,le.state_purchased_Invalid,le.purchase_date_Invalid,le.history_flag_Invalid,le.persistent_record_id_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Fields.InvalidMessage_watercraft_key(le.watercraft_key_Invalid),Fields.InvalidMessage_state_origin(le.state_origin_Invalid),Fields.InvalidMessage_source_code(le.source_code_Invalid),Fields.InvalidMessage_st_registration(le.st_registration_Invalid),Fields.InvalidMessage_county_registration(le.county_registration_Invalid),Fields.InvalidMessage_registration_number(le.registration_number_Invalid),Fields.InvalidMessage_hull_number(le.hull_number_Invalid),Fields.InvalidMessage_model_year(le.model_year_Invalid),Fields.InvalidMessage_watercraft_length(le.watercraft_length_Invalid),Fields.InvalidMessage_watercraft_width(le.watercraft_width_Invalid),Fields.InvalidMessage_watercraft_weight(le.watercraft_weight_Invalid),Fields.InvalidMessage_registration_date(le.registration_date_Invalid),Fields.InvalidMessage_registration_expiration_date(le.registration_expiration_date_Invalid),Fields.InvalidMessage_registration_status_date(le.registration_status_date_Invalid),Fields.InvalidMessage_registration_renewal_date(le.registration_renewal_date_Invalid),Fields.InvalidMessage_decal_number(le.decal_number_Invalid),Fields.InvalidMessage_title_state(le.title_state_Invalid),Fields.InvalidMessage_title_issue_date(le.title_issue_date_Invalid),Fields.InvalidMessage_lien_1_name(le.lien_1_name_Invalid),Fields.InvalidMessage_lien_1_date(le.lien_1_date_Invalid),Fields.InvalidMessage_lien_1_address_1(le.lien_1_address_1_Invalid),Fields.InvalidMessage_lien_1_address_2(le.lien_1_address_2_Invalid),Fields.InvalidMessage_lien_1_city(le.lien_1_city_Invalid),Fields.InvalidMessage_lien_1_state(le.lien_1_state_Invalid),Fields.InvalidMessage_lien_1_zip(le.lien_1_zip_Invalid),Fields.InvalidMessage_lien_2_name(le.lien_2_name_Invalid),Fields.InvalidMessage_lien_2_date(le.lien_2_date_Invalid),Fields.InvalidMessage_lien_2_address_1(le.lien_2_address_1_Invalid),Fields.InvalidMessage_lien_2_address_2(le.lien_2_address_2_Invalid),Fields.InvalidMessage_lien_2_city(le.lien_2_city_Invalid),Fields.InvalidMessage_lien_2_state(le.lien_2_state_Invalid),Fields.InvalidMessage_lien_2_zip(le.lien_2_zip_Invalid),Fields.InvalidMessage_state_purchased(le.state_purchased_Invalid),Fields.InvalidMessage_purchase_date(le.purchase_date_Invalid),Fields.InvalidMessage_history_flag(le.history_flag_Invalid),Fields.InvalidMessage_persistent_record_id(le.persistent_record_id_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.watercraft_key_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.state_origin_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.source_code_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.st_registration_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.county_registration_Invalid,'CAPS','ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.registration_number_Invalid,'CAPS','ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.hull_number_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.model_year_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.watercraft_length_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.watercraft_width_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.watercraft_weight_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.registration_date_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.registration_expiration_date_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.registration_status_date_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.registration_renewal_date_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.decal_number_Invalid,'CAPS','ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.title_state_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.title_issue_date_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.lien_1_name_Invalid,'CAPS','ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.lien_1_date_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.lien_1_address_1_Invalid,'CAPS','ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.lien_1_address_2_Invalid,'CAPS','ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.lien_1_city_Invalid,'CAPS','ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.lien_1_state_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.lien_1_zip_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.lien_2_name_Invalid,'CAPS','ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.lien_2_date_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.lien_2_address_1_Invalid,'CAPS','ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.lien_2_address_2_Invalid,'CAPS','ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.lien_2_city_Invalid,'CAPS','ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.lien_2_state_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.lien_2_zip_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.state_purchased_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.purchase_date_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.history_flag_Invalid,'ENUM','LENGTH','UNKNOWN')
          ,CHOOSE(le.persistent_record_id_Invalid,'LENGTH','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'watercraft_key','state_origin','source_code','st_registration','county_registration','registration_number','hull_number','model_year','watercraft_length','watercraft_width','watercraft_weight','registration_date','registration_expiration_date','registration_status_date','registration_renewal_date','decal_number','title_state','title_issue_date','lien_1_name','lien_1_date','lien_1_address_1','lien_1_address_2','lien_1_city','lien_1_state','lien_1_zip','lien_2_name','lien_2_date','lien_2_address_1','lien_2_address_2','lien_2_city','lien_2_state','lien_2_zip','state_purchased','purchase_date','history_flag','persistent_record_id','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_blank','invalid_state','invalid_source_code','invalid_state','invalid_alnum','invalid_alnum','invalid_hull_number','invalid_year','invalid_numeric','invalid_numeric','invalid_numeric','invalid_date','invalid_date','invalid_date','invalid_date','invalid_alnum','invalid_state','invalid_date','invalid_name','invalid_date','invalid_address','invalid_name','invalid_alpha','invalid_state','invalid_zip','invalid_name','invalid_date','invalid_address','invalid_name','invalid_alpha','invalid_state','invalid_zip','invalid_state','invalid_date','invalid_history_flag','invalid_blank','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT30.StrType)le.watercraft_key,(SALT30.StrType)le.state_origin,(SALT30.StrType)le.source_code,(SALT30.StrType)le.st_registration,(SALT30.StrType)le.county_registration,(SALT30.StrType)le.registration_number,(SALT30.StrType)le.hull_number,(SALT30.StrType)le.model_year,(SALT30.StrType)le.watercraft_length,(SALT30.StrType)le.watercraft_width,(SALT30.StrType)le.watercraft_weight,(SALT30.StrType)le.registration_date,(SALT30.StrType)le.registration_expiration_date,(SALT30.StrType)le.registration_status_date,(SALT30.StrType)le.registration_renewal_date,(SALT30.StrType)le.decal_number,(SALT30.StrType)le.title_state,(SALT30.StrType)le.title_issue_date,(SALT30.StrType)le.lien_1_name,(SALT30.StrType)le.lien_1_date,(SALT30.StrType)le.lien_1_address_1,(SALT30.StrType)le.lien_1_address_2,(SALT30.StrType)le.lien_1_city,(SALT30.StrType)le.lien_1_state,(SALT30.StrType)le.lien_1_zip,(SALT30.StrType)le.lien_2_name,(SALT30.StrType)le.lien_2_date,(SALT30.StrType)le.lien_2_address_1,(SALT30.StrType)le.lien_2_address_2,(SALT30.StrType)le.lien_2_city,(SALT30.StrType)le.lien_2_state,(SALT30.StrType)le.lien_2_zip,(SALT30.StrType)le.state_purchased,(SALT30.StrType)le.purchase_date,(SALT30.StrType)le.history_flag,(SALT30.StrType)le.persistent_record_id,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,36,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10,UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD()) := FUNCTION
    SALT30.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := le.source_code;
      SELF.ruledesc := CHOOSE(c
          ,'watercraft_key:invalid_blank:LENGTH'
          ,'state_origin:invalid_state:ALLOW','state_origin:invalid_state:LENGTH'
          ,'source_code:invalid_source_code:ALLOW','source_code:invalid_source_code:LENGTH'
          ,'st_registration:invalid_state:ALLOW','st_registration:invalid_state:LENGTH'
          ,'county_registration:invalid_alnum:CAPS','county_registration:invalid_alnum:ALLOW','county_registration:invalid_alnum:LENGTH'
          ,'registration_number:invalid_alnum:CAPS','registration_number:invalid_alnum:ALLOW','registration_number:invalid_alnum:LENGTH'
          ,'hull_number:invalid_hull_number:ALLOW','hull_number:invalid_hull_number:LENGTH'
          ,'model_year:invalid_year:ALLOW','model_year:invalid_year:LENGTH'
          ,'watercraft_length:invalid_numeric:ALLOW','watercraft_length:invalid_numeric:LENGTH'
          ,'watercraft_width:invalid_numeric:ALLOW','watercraft_width:invalid_numeric:LENGTH'
          ,'watercraft_weight:invalid_numeric:ALLOW','watercraft_weight:invalid_numeric:LENGTH'
          ,'registration_date:invalid_date:ALLOW','registration_date:invalid_date:LENGTH'
          ,'registration_expiration_date:invalid_date:ALLOW','registration_expiration_date:invalid_date:LENGTH'
          ,'registration_status_date:invalid_date:ALLOW','registration_status_date:invalid_date:LENGTH'
          ,'registration_renewal_date:invalid_date:ALLOW','registration_renewal_date:invalid_date:LENGTH'
          ,'decal_number:invalid_alnum:CAPS','decal_number:invalid_alnum:ALLOW','decal_number:invalid_alnum:LENGTH'
          ,'title_state:invalid_state:ALLOW','title_state:invalid_state:LENGTH'
          ,'title_issue_date:invalid_date:ALLOW','title_issue_date:invalid_date:LENGTH'
          ,'lien_1_name:invalid_name:CAPS','lien_1_name:invalid_name:ALLOW','lien_1_name:invalid_name:LENGTH'
          ,'lien_1_date:invalid_date:ALLOW','lien_1_date:invalid_date:LENGTH'
          ,'lien_1_address_1:invalid_address:CAPS','lien_1_address_1:invalid_address:ALLOW','lien_1_address_1:invalid_address:LENGTH'
          ,'lien_1_address_2:invalid_name:CAPS','lien_1_address_2:invalid_name:ALLOW','lien_1_address_2:invalid_name:LENGTH'
          ,'lien_1_city:invalid_alpha:CAPS','lien_1_city:invalid_alpha:ALLOW','lien_1_city:invalid_alpha:LENGTH'
          ,'lien_1_state:invalid_state:ALLOW','lien_1_state:invalid_state:LENGTH'
          ,'lien_1_zip:invalid_zip:ALLOW','lien_1_zip:invalid_zip:LENGTH'
          ,'lien_2_name:invalid_name:CAPS','lien_2_name:invalid_name:ALLOW','lien_2_name:invalid_name:LENGTH'
          ,'lien_2_date:invalid_date:ALLOW','lien_2_date:invalid_date:LENGTH'
          ,'lien_2_address_1:invalid_address:CAPS','lien_2_address_1:invalid_address:ALLOW','lien_2_address_1:invalid_address:LENGTH'
          ,'lien_2_address_2:invalid_name:CAPS','lien_2_address_2:invalid_name:ALLOW','lien_2_address_2:invalid_name:LENGTH'
          ,'lien_2_city:invalid_alpha:CAPS','lien_2_city:invalid_alpha:ALLOW','lien_2_city:invalid_alpha:LENGTH'
          ,'lien_2_state:invalid_state:ALLOW','lien_2_state:invalid_state:LENGTH'
          ,'lien_2_zip:invalid_zip:ALLOW','lien_2_zip:invalid_zip:LENGTH'
          ,'state_purchased:invalid_state:ALLOW','state_purchased:invalid_state:LENGTH'
          ,'purchase_date:invalid_date:ALLOW','purchase_date:invalid_date:LENGTH'
          ,'history_flag:invalid_history_flag:ENUM','history_flag:invalid_history_flag:LENGTH'
          ,'persistent_record_id:invalid_blank:LENGTH','UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.watercraft_key_LENGTH_ErrorCount
          ,le.state_origin_ALLOW_ErrorCount,le.state_origin_LENGTH_ErrorCount
          ,le.source_code_ALLOW_ErrorCount,le.source_code_LENGTH_ErrorCount
          ,le.st_registration_ALLOW_ErrorCount,le.st_registration_LENGTH_ErrorCount
          ,le.county_registration_CAPS_ErrorCount,le.county_registration_ALLOW_ErrorCount,le.county_registration_LENGTH_ErrorCount
          ,le.registration_number_CAPS_ErrorCount,le.registration_number_ALLOW_ErrorCount,le.registration_number_LENGTH_ErrorCount
          ,le.hull_number_ALLOW_ErrorCount,le.hull_number_LENGTH_ErrorCount
          ,le.model_year_ALLOW_ErrorCount,le.model_year_LENGTH_ErrorCount
          ,le.watercraft_length_ALLOW_ErrorCount,le.watercraft_length_LENGTH_ErrorCount
          ,le.watercraft_width_ALLOW_ErrorCount,le.watercraft_width_LENGTH_ErrorCount
          ,le.watercraft_weight_ALLOW_ErrorCount,le.watercraft_weight_LENGTH_ErrorCount
          ,le.registration_date_ALLOW_ErrorCount,le.registration_date_LENGTH_ErrorCount
          ,le.registration_expiration_date_ALLOW_ErrorCount,le.registration_expiration_date_LENGTH_ErrorCount
          ,le.registration_status_date_ALLOW_ErrorCount,le.registration_status_date_LENGTH_ErrorCount
          ,le.registration_renewal_date_ALLOW_ErrorCount,le.registration_renewal_date_LENGTH_ErrorCount
          ,le.decal_number_CAPS_ErrorCount,le.decal_number_ALLOW_ErrorCount,le.decal_number_LENGTH_ErrorCount
          ,le.title_state_ALLOW_ErrorCount,le.title_state_LENGTH_ErrorCount
          ,le.title_issue_date_ALLOW_ErrorCount,le.title_issue_date_LENGTH_ErrorCount
          ,le.lien_1_name_CAPS_ErrorCount,le.lien_1_name_ALLOW_ErrorCount,le.lien_1_name_LENGTH_ErrorCount
          ,le.lien_1_date_ALLOW_ErrorCount,le.lien_1_date_LENGTH_ErrorCount
          ,le.lien_1_address_1_CAPS_ErrorCount,le.lien_1_address_1_ALLOW_ErrorCount,le.lien_1_address_1_LENGTH_ErrorCount
          ,le.lien_1_address_2_CAPS_ErrorCount,le.lien_1_address_2_ALLOW_ErrorCount,le.lien_1_address_2_LENGTH_ErrorCount
          ,le.lien_1_city_CAPS_ErrorCount,le.lien_1_city_ALLOW_ErrorCount,le.lien_1_city_LENGTH_ErrorCount
          ,le.lien_1_state_ALLOW_ErrorCount,le.lien_1_state_LENGTH_ErrorCount
          ,le.lien_1_zip_ALLOW_ErrorCount,le.lien_1_zip_LENGTH_ErrorCount
          ,le.lien_2_name_CAPS_ErrorCount,le.lien_2_name_ALLOW_ErrorCount,le.lien_2_name_LENGTH_ErrorCount
          ,le.lien_2_date_ALLOW_ErrorCount,le.lien_2_date_LENGTH_ErrorCount
          ,le.lien_2_address_1_CAPS_ErrorCount,le.lien_2_address_1_ALLOW_ErrorCount,le.lien_2_address_1_LENGTH_ErrorCount
          ,le.lien_2_address_2_CAPS_ErrorCount,le.lien_2_address_2_ALLOW_ErrorCount,le.lien_2_address_2_LENGTH_ErrorCount
          ,le.lien_2_city_CAPS_ErrorCount,le.lien_2_city_ALLOW_ErrorCount,le.lien_2_city_LENGTH_ErrorCount
          ,le.lien_2_state_ALLOW_ErrorCount,le.lien_2_state_LENGTH_ErrorCount
          ,le.lien_2_zip_ALLOW_ErrorCount,le.lien_2_zip_LENGTH_ErrorCount
          ,le.state_purchased_ALLOW_ErrorCount,le.state_purchased_LENGTH_ErrorCount
          ,le.purchase_date_ALLOW_ErrorCount,le.purchase_date_LENGTH_ErrorCount
          ,le.history_flag_ENUM_ErrorCount,le.history_flag_LENGTH_ErrorCount
          ,le.persistent_record_id_LENGTH_ErrorCount,0);
      SELF.rulepcnt := 100 * CHOOSE(c
          ,le.watercraft_key_LENGTH_ErrorCount
          ,le.state_origin_ALLOW_ErrorCount,le.state_origin_LENGTH_ErrorCount
          ,le.source_code_ALLOW_ErrorCount,le.source_code_LENGTH_ErrorCount
          ,le.st_registration_ALLOW_ErrorCount,le.st_registration_LENGTH_ErrorCount
          ,le.county_registration_CAPS_ErrorCount,le.county_registration_ALLOW_ErrorCount,le.county_registration_LENGTH_ErrorCount
          ,le.registration_number_CAPS_ErrorCount,le.registration_number_ALLOW_ErrorCount,le.registration_number_LENGTH_ErrorCount
          ,le.hull_number_ALLOW_ErrorCount,le.hull_number_LENGTH_ErrorCount
          ,le.model_year_ALLOW_ErrorCount,le.model_year_LENGTH_ErrorCount
          ,le.watercraft_length_ALLOW_ErrorCount,le.watercraft_length_LENGTH_ErrorCount
          ,le.watercraft_width_ALLOW_ErrorCount,le.watercraft_width_LENGTH_ErrorCount
          ,le.watercraft_weight_ALLOW_ErrorCount,le.watercraft_weight_LENGTH_ErrorCount
          ,le.registration_date_ALLOW_ErrorCount,le.registration_date_LENGTH_ErrorCount
          ,le.registration_expiration_date_ALLOW_ErrorCount,le.registration_expiration_date_LENGTH_ErrorCount
          ,le.registration_status_date_ALLOW_ErrorCount,le.registration_status_date_LENGTH_ErrorCount
          ,le.registration_renewal_date_ALLOW_ErrorCount,le.registration_renewal_date_LENGTH_ErrorCount
          ,le.decal_number_CAPS_ErrorCount,le.decal_number_ALLOW_ErrorCount,le.decal_number_LENGTH_ErrorCount
          ,le.title_state_ALLOW_ErrorCount,le.title_state_LENGTH_ErrorCount
          ,le.title_issue_date_ALLOW_ErrorCount,le.title_issue_date_LENGTH_ErrorCount
          ,le.lien_1_name_CAPS_ErrorCount,le.lien_1_name_ALLOW_ErrorCount,le.lien_1_name_LENGTH_ErrorCount
          ,le.lien_1_date_ALLOW_ErrorCount,le.lien_1_date_LENGTH_ErrorCount
          ,le.lien_1_address_1_CAPS_ErrorCount,le.lien_1_address_1_ALLOW_ErrorCount,le.lien_1_address_1_LENGTH_ErrorCount
          ,le.lien_1_address_2_CAPS_ErrorCount,le.lien_1_address_2_ALLOW_ErrorCount,le.lien_1_address_2_LENGTH_ErrorCount
          ,le.lien_1_city_CAPS_ErrorCount,le.lien_1_city_ALLOW_ErrorCount,le.lien_1_city_LENGTH_ErrorCount
          ,le.lien_1_state_ALLOW_ErrorCount,le.lien_1_state_LENGTH_ErrorCount
          ,le.lien_1_zip_ALLOW_ErrorCount,le.lien_1_zip_LENGTH_ErrorCount
          ,le.lien_2_name_CAPS_ErrorCount,le.lien_2_name_ALLOW_ErrorCount,le.lien_2_name_LENGTH_ErrorCount
          ,le.lien_2_date_ALLOW_ErrorCount,le.lien_2_date_LENGTH_ErrorCount
          ,le.lien_2_address_1_CAPS_ErrorCount,le.lien_2_address_1_ALLOW_ErrorCount,le.lien_2_address_1_LENGTH_ErrorCount
          ,le.lien_2_address_2_CAPS_ErrorCount,le.lien_2_address_2_ALLOW_ErrorCount,le.lien_2_address_2_LENGTH_ErrorCount
          ,le.lien_2_city_CAPS_ErrorCount,le.lien_2_city_ALLOW_ErrorCount,le.lien_2_city_LENGTH_ErrorCount
          ,le.lien_2_state_ALLOW_ErrorCount,le.lien_2_state_LENGTH_ErrorCount
          ,le.lien_2_zip_ALLOW_ErrorCount,le.lien_2_zip_LENGTH_ErrorCount
          ,le.state_purchased_ALLOW_ErrorCount,le.state_purchased_LENGTH_ErrorCount
          ,le.purchase_date_ALLOW_ErrorCount,le.purchase_date_LENGTH_ErrorCount
          ,le.history_flag_ENUM_ErrorCount,le.history_flag_LENGTH_ErrorCount
          ,le.persistent_record_id_LENGTH_ErrorCount,0) / le.TotalCnt + 0.5;
    END;
    SummaryInfo := NORMALIZE(SummaryStats,81,Into(LEFT,COUNTER));
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
