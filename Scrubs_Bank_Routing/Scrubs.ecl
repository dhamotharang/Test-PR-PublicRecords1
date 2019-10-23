IMPORT SALT38,STD;
EXPORT Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 66;
  EXPORT NumRulesFromFieldType := 66;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 38;
  EXPORT NumFieldsWithPossibleEdits := 14;
  EXPORT NumRulesWithPossibleEdits := 36;
  EXPORT Expanded_Layout := RECORD(layout_bank_routing)
    UNSIGNED1 file_key_Invalid;
    UNSIGNED1 dt_first_seen_Invalid;
    UNSIGNED1 dt_last_seen_Invalid;
    UNSIGNED1 dt_vendor_first_reported_Invalid;
    UNSIGNED1 dt_vendor_last_reported_Invalid;
    UNSIGNED1 date_updated_Invalid;
    UNSIGNED1 type_instituon_code_Invalid;
    UNSIGNED1 head_office_branch_codes_Invalid;
    UNSIGNED1 routing_number_micr_Invalid;
    UNSIGNED1 routing_number_fractional_Invalid;
    UNSIGNED1 institution_name_full_Invalid;
    BOOLEAN institution_name_full_wouldClean;
    UNSIGNED1 institution_name_abbreviated_Invalid;
    BOOLEAN institution_name_abbreviated_wouldClean;
    UNSIGNED1 street_address_Invalid;
    BOOLEAN street_address_wouldClean;
    UNSIGNED1 city_town_Invalid;
    BOOLEAN city_town_wouldClean;
    UNSIGNED1 state_Invalid;
    BOOLEAN state_wouldClean;
    UNSIGNED1 zip_code_Invalid;
    BOOLEAN zip_code_wouldClean;
    UNSIGNED1 zip_4_Invalid;
    BOOLEAN zip_4_wouldClean;
    UNSIGNED1 mail_address_Invalid;
    BOOLEAN mail_address_wouldClean;
    UNSIGNED1 mail_city_town_Invalid;
    BOOLEAN mail_city_town_wouldClean;
    UNSIGNED1 mail_state_Invalid;
    BOOLEAN mail_state_wouldClean;
    UNSIGNED1 mail_zip_code_Invalid;
    BOOLEAN mail_zip_code_wouldClean;
    UNSIGNED1 mail_zip_4_Invalid;
    BOOLEAN mail_zip_4_wouldClean;
    UNSIGNED1 branch_office_name_Invalid;
    BOOLEAN branch_office_name_wouldClean;
    UNSIGNED1 head_office_routing_number_Invalid;
    UNSIGNED1 phone_number_area_code_Invalid;
    UNSIGNED1 phone_number_Invalid;
    UNSIGNED1 phone_number_extension_Invalid;
    UNSIGNED1 fax_area_code_Invalid;
    UNSIGNED1 fax_number_Invalid;
    UNSIGNED1 fax_extension_Invalid;
    UNSIGNED1 head_office_asset_size_Invalid;
    UNSIGNED1 federal_reserve_district_code_Invalid;
    UNSIGNED1 year_2000_date_last_updated_Invalid;
    UNSIGNED1 head_office_file_key_Invalid;
    UNSIGNED1 routing_number_type_Invalid;
    BOOLEAN routing_number_type_wouldClean;
    UNSIGNED1 routing_number_status_Invalid;
    UNSIGNED1 employer_tax_id_Invalid;
    UNSIGNED1 institution_identifier_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(layout_bank_routing)
    UNSIGNED8 ScrubsBits1;
    UNSIGNED8 ScrubsCleanBits1;
  END;
EXPORT FromNone(DATASET(layout_bank_routing) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.file_key_Invalid := Fields.InValid_file_key((SALT38.StrType)le.file_key);
    SELF.dt_first_seen_Invalid := Fields.InValid_dt_first_seen((SALT38.StrType)le.dt_first_seen);
    SELF.dt_last_seen_Invalid := Fields.InValid_dt_last_seen((SALT38.StrType)le.dt_last_seen);
    SELF.dt_vendor_first_reported_Invalid := Fields.InValid_dt_vendor_first_reported((SALT38.StrType)le.dt_vendor_first_reported);
    SELF.dt_vendor_last_reported_Invalid := Fields.InValid_dt_vendor_last_reported((SALT38.StrType)le.dt_vendor_last_reported);
    SELF.date_updated_Invalid := Fields.InValid_date_updated((SALT38.StrType)le.date_updated);
    SELF.type_instituon_code_Invalid := Fields.InValid_type_instituon_code((SALT38.StrType)le.type_instituon_code);
    SELF.head_office_branch_codes_Invalid := Fields.InValid_head_office_branch_codes((SALT38.StrType)le.head_office_branch_codes);
    SELF.routing_number_micr_Invalid := Fields.InValid_routing_number_micr((SALT38.StrType)le.routing_number_micr);
    SELF.routing_number_fractional_Invalid := Fields.InValid_routing_number_fractional((SALT38.StrType)le.routing_number_fractional);
    SELF.institution_name_full_Invalid := Fields.InValid_institution_name_full((SALT38.StrType)le.institution_name_full);
    clean_institution_name_full := (TYPEOF(le.institution_name_full))Fields.Make_institution_name_full((SALT38.StrType)le.institution_name_full);
    clean_institution_name_full_Invalid := Fields.InValid_institution_name_full((SALT38.StrType)clean_institution_name_full);
    SELF.institution_name_full := IF(withOnfail, clean_institution_name_full, le.institution_name_full); // ONFAIL(CLEAN)
    SELF.institution_name_full_wouldClean := TRIM((SALT38.StrType)le.institution_name_full) <> TRIM((SALT38.StrType)clean_institution_name_full);
    SELF.institution_name_abbreviated_Invalid := Fields.InValid_institution_name_abbreviated((SALT38.StrType)le.institution_name_abbreviated);
    clean_institution_name_abbreviated := (TYPEOF(le.institution_name_abbreviated))Fields.Make_institution_name_abbreviated((SALT38.StrType)le.institution_name_abbreviated);
    clean_institution_name_abbreviated_Invalid := Fields.InValid_institution_name_abbreviated((SALT38.StrType)clean_institution_name_abbreviated);
    SELF.institution_name_abbreviated := IF(withOnfail, clean_institution_name_abbreviated, le.institution_name_abbreviated); // ONFAIL(CLEAN)
    SELF.institution_name_abbreviated_wouldClean := TRIM((SALT38.StrType)le.institution_name_abbreviated) <> TRIM((SALT38.StrType)clean_institution_name_abbreviated);
    SELF.street_address_Invalid := Fields.InValid_street_address((SALT38.StrType)le.street_address);
    clean_street_address := (TYPEOF(le.street_address))Fields.Make_street_address((SALT38.StrType)le.street_address);
    clean_street_address_Invalid := Fields.InValid_street_address((SALT38.StrType)clean_street_address);
    SELF.street_address := IF(withOnfail, clean_street_address, le.street_address); // ONFAIL(CLEAN)
    SELF.street_address_wouldClean := TRIM((SALT38.StrType)le.street_address) <> TRIM((SALT38.StrType)clean_street_address);
    SELF.city_town_Invalid := Fields.InValid_city_town((SALT38.StrType)le.city_town);
    clean_city_town := (TYPEOF(le.city_town))Fields.Make_city_town((SALT38.StrType)le.city_town);
    clean_city_town_Invalid := Fields.InValid_city_town((SALT38.StrType)clean_city_town);
    SELF.city_town := IF(withOnfail, clean_city_town, le.city_town); // ONFAIL(CLEAN)
    SELF.city_town_wouldClean := TRIM((SALT38.StrType)le.city_town) <> TRIM((SALT38.StrType)clean_city_town);
    SELF.state_Invalid := Fields.InValid_state((SALT38.StrType)le.state);
    clean_state := (TYPEOF(le.state))Fields.Make_state((SALT38.StrType)le.state);
    clean_state_Invalid := Fields.InValid_state((SALT38.StrType)clean_state);
    SELF.state := IF(withOnfail, clean_state, le.state); // ONFAIL(CLEAN)
    SELF.state_wouldClean := TRIM((SALT38.StrType)le.state) <> TRIM((SALT38.StrType)clean_state);
    SELF.zip_code_Invalid := Fields.InValid_zip_code((SALT38.StrType)le.zip_code);
    clean_zip_code := (TYPEOF(le.zip_code))Fields.Make_zip_code((SALT38.StrType)le.zip_code);
    clean_zip_code_Invalid := Fields.InValid_zip_code((SALT38.StrType)clean_zip_code);
    SELF.zip_code := IF(withOnfail, clean_zip_code, le.zip_code); // ONFAIL(CLEAN)
    SELF.zip_code_wouldClean := TRIM((SALT38.StrType)le.zip_code) <> TRIM((SALT38.StrType)clean_zip_code);
    SELF.zip_4_Invalid := Fields.InValid_zip_4((SALT38.StrType)le.zip_4);
    clean_zip_4 := (TYPEOF(le.zip_4))Fields.Make_zip_4((SALT38.StrType)le.zip_4);
    clean_zip_4_Invalid := Fields.InValid_zip_4((SALT38.StrType)clean_zip_4);
    SELF.zip_4 := IF(withOnfail, clean_zip_4, le.zip_4); // ONFAIL(CLEAN)
    SELF.zip_4_wouldClean := TRIM((SALT38.StrType)le.zip_4) <> TRIM((SALT38.StrType)clean_zip_4);
    SELF.mail_address_Invalid := Fields.InValid_mail_address((SALT38.StrType)le.mail_address);
    clean_mail_address := (TYPEOF(le.mail_address))Fields.Make_mail_address((SALT38.StrType)le.mail_address);
    clean_mail_address_Invalid := Fields.InValid_mail_address((SALT38.StrType)clean_mail_address);
    SELF.mail_address := IF(withOnfail, clean_mail_address, le.mail_address); // ONFAIL(CLEAN)
    SELF.mail_address_wouldClean := TRIM((SALT38.StrType)le.mail_address) <> TRIM((SALT38.StrType)clean_mail_address);
    SELF.mail_city_town_Invalid := Fields.InValid_mail_city_town((SALT38.StrType)le.mail_city_town);
    clean_mail_city_town := (TYPEOF(le.mail_city_town))Fields.Make_mail_city_town((SALT38.StrType)le.mail_city_town);
    clean_mail_city_town_Invalid := Fields.InValid_mail_city_town((SALT38.StrType)clean_mail_city_town);
    SELF.mail_city_town := IF(withOnfail, clean_mail_city_town, le.mail_city_town); // ONFAIL(CLEAN)
    SELF.mail_city_town_wouldClean := TRIM((SALT38.StrType)le.mail_city_town) <> TRIM((SALT38.StrType)clean_mail_city_town);
    SELF.mail_state_Invalid := Fields.InValid_mail_state((SALT38.StrType)le.mail_state);
    clean_mail_state := (TYPEOF(le.mail_state))Fields.Make_mail_state((SALT38.StrType)le.mail_state);
    clean_mail_state_Invalid := Fields.InValid_mail_state((SALT38.StrType)clean_mail_state);
    SELF.mail_state := IF(withOnfail, clean_mail_state, le.mail_state); // ONFAIL(CLEAN)
    SELF.mail_state_wouldClean := TRIM((SALT38.StrType)le.mail_state) <> TRIM((SALT38.StrType)clean_mail_state);
    SELF.mail_zip_code_Invalid := Fields.InValid_mail_zip_code((SALT38.StrType)le.mail_zip_code);
    clean_mail_zip_code := (TYPEOF(le.mail_zip_code))Fields.Make_mail_zip_code((SALT38.StrType)le.mail_zip_code);
    clean_mail_zip_code_Invalid := Fields.InValid_mail_zip_code((SALT38.StrType)clean_mail_zip_code);
    SELF.mail_zip_code := IF(withOnfail, clean_mail_zip_code, le.mail_zip_code); // ONFAIL(CLEAN)
    SELF.mail_zip_code_wouldClean := TRIM((SALT38.StrType)le.mail_zip_code) <> TRIM((SALT38.StrType)clean_mail_zip_code);
    SELF.mail_zip_4_Invalid := Fields.InValid_mail_zip_4((SALT38.StrType)le.mail_zip_4);
    clean_mail_zip_4 := (TYPEOF(le.mail_zip_4))Fields.Make_mail_zip_4((SALT38.StrType)le.mail_zip_4);
    clean_mail_zip_4_Invalid := Fields.InValid_mail_zip_4((SALT38.StrType)clean_mail_zip_4);
    SELF.mail_zip_4 := IF(withOnfail, clean_mail_zip_4, le.mail_zip_4); // ONFAIL(CLEAN)
    SELF.mail_zip_4_wouldClean := TRIM((SALT38.StrType)le.mail_zip_4) <> TRIM((SALT38.StrType)clean_mail_zip_4);
    SELF.branch_office_name_Invalid := Fields.InValid_branch_office_name((SALT38.StrType)le.branch_office_name);
    clean_branch_office_name := (TYPEOF(le.branch_office_name))Fields.Make_branch_office_name((SALT38.StrType)le.branch_office_name);
    clean_branch_office_name_Invalid := Fields.InValid_branch_office_name((SALT38.StrType)clean_branch_office_name);
    SELF.branch_office_name := IF(withOnfail, clean_branch_office_name, le.branch_office_name); // ONFAIL(CLEAN)
    SELF.branch_office_name_wouldClean := TRIM((SALT38.StrType)le.branch_office_name) <> TRIM((SALT38.StrType)clean_branch_office_name);
    SELF.head_office_routing_number_Invalid := Fields.InValid_head_office_routing_number((SALT38.StrType)le.head_office_routing_number);
    SELF.phone_number_area_code_Invalid := Fields.InValid_phone_number_area_code((SALT38.StrType)le.phone_number_area_code);
    SELF.phone_number_Invalid := Fields.InValid_phone_number((SALT38.StrType)le.phone_number);
    SELF.phone_number_extension_Invalid := Fields.InValid_phone_number_extension((SALT38.StrType)le.phone_number_extension);
    SELF.fax_area_code_Invalid := Fields.InValid_fax_area_code((SALT38.StrType)le.fax_area_code);
    SELF.fax_number_Invalid := Fields.InValid_fax_number((SALT38.StrType)le.fax_number);
    SELF.fax_extension_Invalid := Fields.InValid_fax_extension((SALT38.StrType)le.fax_extension);
    SELF.head_office_asset_size_Invalid := Fields.InValid_head_office_asset_size((SALT38.StrType)le.head_office_asset_size);
    SELF.federal_reserve_district_code_Invalid := Fields.InValid_federal_reserve_district_code((SALT38.StrType)le.federal_reserve_district_code);
    SELF.year_2000_date_last_updated_Invalid := Fields.InValid_year_2000_date_last_updated((SALT38.StrType)le.year_2000_date_last_updated);
    SELF.head_office_file_key_Invalid := Fields.InValid_head_office_file_key((SALT38.StrType)le.head_office_file_key);
    SELF.routing_number_type_Invalid := Fields.InValid_routing_number_type((SALT38.StrType)le.routing_number_type);
    clean_routing_number_type := (TYPEOF(le.routing_number_type))Fields.Make_routing_number_type((SALT38.StrType)le.routing_number_type);
    clean_routing_number_type_Invalid := Fields.InValid_routing_number_type((SALT38.StrType)clean_routing_number_type);
    SELF.routing_number_type := IF(withOnfail, clean_routing_number_type, le.routing_number_type); // ONFAIL(CLEAN)
    SELF.routing_number_type_wouldClean := TRIM((SALT38.StrType)le.routing_number_type) <> TRIM((SALT38.StrType)clean_routing_number_type);
    SELF.routing_number_status_Invalid := Fields.InValid_routing_number_status((SALT38.StrType)le.routing_number_status);
    SELF.employer_tax_id_Invalid := Fields.InValid_employer_tax_id((SALT38.StrType)le.employer_tax_id);
    SELF.institution_identifier_Invalid := Fields.InValid_institution_identifier((SALT38.StrType)le.institution_identifier);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),layout_bank_routing);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.file_key_Invalid << 0 ) + ( le.dt_first_seen_Invalid << 1 ) + ( le.dt_last_seen_Invalid << 3 ) + ( le.dt_vendor_first_reported_Invalid << 5 ) + ( le.dt_vendor_last_reported_Invalid << 7 ) + ( le.date_updated_Invalid << 9 ) + ( le.type_instituon_code_Invalid << 10 ) + ( le.head_office_branch_codes_Invalid << 11 ) + ( le.routing_number_micr_Invalid << 12 ) + ( le.routing_number_fractional_Invalid << 13 ) + ( le.institution_name_full_Invalid << 14 ) + ( le.institution_name_abbreviated_Invalid << 16 ) + ( le.street_address_Invalid << 18 ) + ( le.city_town_Invalid << 20 ) + ( le.state_Invalid << 23 ) + ( le.zip_code_Invalid << 26 ) + ( le.zip_4_Invalid << 28 ) + ( le.mail_address_Invalid << 30 ) + ( le.mail_city_town_Invalid << 32 ) + ( le.mail_state_Invalid << 35 ) + ( le.mail_zip_code_Invalid << 38 ) + ( le.mail_zip_4_Invalid << 40 ) + ( le.branch_office_name_Invalid << 42 ) + ( le.head_office_routing_number_Invalid << 44 ) + ( le.phone_number_area_code_Invalid << 45 ) + ( le.phone_number_Invalid << 46 ) + ( le.phone_number_extension_Invalid << 47 ) + ( le.fax_area_code_Invalid << 48 ) + ( le.fax_number_Invalid << 49 ) + ( le.fax_extension_Invalid << 50 ) + ( le.head_office_asset_size_Invalid << 51 ) + ( le.federal_reserve_district_code_Invalid << 52 ) + ( le.year_2000_date_last_updated_Invalid << 54 ) + ( le.head_office_file_key_Invalid << 55 ) + ( le.routing_number_type_Invalid << 56 ) + ( le.routing_number_status_Invalid << 58 ) + ( le.employer_tax_id_Invalid << 60 ) + ( le.institution_identifier_Invalid << 61 );
    SELF.ScrubsCleanBits1 := ( IF(le.institution_name_full_wouldClean, 1, 0) << 0 ) + ( IF(le.institution_name_abbreviated_wouldClean, 1, 0) << 1 ) + ( IF(le.street_address_wouldClean, 1, 0) << 2 ) + ( IF(le.city_town_wouldClean, 1, 0) << 3 ) + ( IF(le.state_wouldClean, 1, 0) << 4 ) + ( IF(le.zip_code_wouldClean, 1, 0) << 5 ) + ( IF(le.zip_4_wouldClean, 1, 0) << 6 ) + ( IF(le.mail_address_wouldClean, 1, 0) << 7 ) + ( IF(le.mail_city_town_wouldClean, 1, 0) << 8 ) + ( IF(le.mail_state_wouldClean, 1, 0) << 9 ) + ( IF(le.mail_zip_code_wouldClean, 1, 0) << 10 ) + ( IF(le.mail_zip_4_wouldClean, 1, 0) << 11 ) + ( IF(le.branch_office_name_wouldClean, 1, 0) << 12 ) + ( IF(le.routing_number_type_wouldClean, 1, 0) << 13 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,layout_bank_routing);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.file_key_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.dt_first_seen_Invalid := (le.ScrubsBits1 >> 1) & 3;
    SELF.dt_last_seen_Invalid := (le.ScrubsBits1 >> 3) & 3;
    SELF.dt_vendor_first_reported_Invalid := (le.ScrubsBits1 >> 5) & 3;
    SELF.dt_vendor_last_reported_Invalid := (le.ScrubsBits1 >> 7) & 3;
    SELF.date_updated_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF.type_instituon_code_Invalid := (le.ScrubsBits1 >> 10) & 1;
    SELF.head_office_branch_codes_Invalid := (le.ScrubsBits1 >> 11) & 1;
    SELF.routing_number_micr_Invalid := (le.ScrubsBits1 >> 12) & 1;
    SELF.routing_number_fractional_Invalid := (le.ScrubsBits1 >> 13) & 1;
    SELF.institution_name_full_Invalid := (le.ScrubsBits1 >> 14) & 3;
    SELF.institution_name_abbreviated_Invalid := (le.ScrubsBits1 >> 16) & 3;
    SELF.street_address_Invalid := (le.ScrubsBits1 >> 18) & 3;
    SELF.city_town_Invalid := (le.ScrubsBits1 >> 20) & 7;
    SELF.state_Invalid := (le.ScrubsBits1 >> 23) & 7;
    SELF.zip_code_Invalid := (le.ScrubsBits1 >> 26) & 3;
    SELF.zip_4_Invalid := (le.ScrubsBits1 >> 28) & 3;
    SELF.mail_address_Invalid := (le.ScrubsBits1 >> 30) & 3;
    SELF.mail_city_town_Invalid := (le.ScrubsBits1 >> 32) & 7;
    SELF.mail_state_Invalid := (le.ScrubsBits1 >> 35) & 7;
    SELF.mail_zip_code_Invalid := (le.ScrubsBits1 >> 38) & 3;
    SELF.mail_zip_4_Invalid := (le.ScrubsBits1 >> 40) & 3;
    SELF.branch_office_name_Invalid := (le.ScrubsBits1 >> 42) & 3;
    SELF.head_office_routing_number_Invalid := (le.ScrubsBits1 >> 44) & 1;
    SELF.phone_number_area_code_Invalid := (le.ScrubsBits1 >> 45) & 1;
    SELF.phone_number_Invalid := (le.ScrubsBits1 >> 46) & 1;
    SELF.phone_number_extension_Invalid := (le.ScrubsBits1 >> 47) & 1;
    SELF.fax_area_code_Invalid := (le.ScrubsBits1 >> 48) & 1;
    SELF.fax_number_Invalid := (le.ScrubsBits1 >> 49) & 1;
    SELF.fax_extension_Invalid := (le.ScrubsBits1 >> 50) & 1;
    SELF.head_office_asset_size_Invalid := (le.ScrubsBits1 >> 51) & 1;
    SELF.federal_reserve_district_code_Invalid := (le.ScrubsBits1 >> 52) & 3;
    SELF.year_2000_date_last_updated_Invalid := (le.ScrubsBits1 >> 54) & 1;
    SELF.head_office_file_key_Invalid := (le.ScrubsBits1 >> 55) & 1;
    SELF.routing_number_type_Invalid := (le.ScrubsBits1 >> 56) & 3;
    SELF.routing_number_status_Invalid := (le.ScrubsBits1 >> 58) & 3;
    SELF.employer_tax_id_Invalid := (le.ScrubsBits1 >> 60) & 1;
    SELF.institution_identifier_Invalid := (le.ScrubsBits1 >> 61) & 1;
    SELF.institution_name_full_wouldClean := le.ScrubsCleanBits1 >> 0;
    SELF.institution_name_abbreviated_wouldClean := le.ScrubsCleanBits1 >> 1;
    SELF.street_address_wouldClean := le.ScrubsCleanBits1 >> 2;
    SELF.city_town_wouldClean := le.ScrubsCleanBits1 >> 3;
    SELF.state_wouldClean := le.ScrubsCleanBits1 >> 4;
    SELF.zip_code_wouldClean := le.ScrubsCleanBits1 >> 5;
    SELF.zip_4_wouldClean := le.ScrubsCleanBits1 >> 6;
    SELF.mail_address_wouldClean := le.ScrubsCleanBits1 >> 7;
    SELF.mail_city_town_wouldClean := le.ScrubsCleanBits1 >> 8;
    SELF.mail_state_wouldClean := le.ScrubsCleanBits1 >> 9;
    SELF.mail_zip_code_wouldClean := le.ScrubsCleanBits1 >> 10;
    SELF.mail_zip_4_wouldClean := le.ScrubsCleanBits1 >> 11;
    SELF.branch_office_name_wouldClean := le.ScrubsCleanBits1 >> 12;
    SELF.routing_number_type_wouldClean := le.ScrubsCleanBits1 >> 13;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    file_key_ALLOW_ErrorCount := COUNT(GROUP,h.file_key_Invalid=1);
    dt_first_seen_LEFTTRIM_ErrorCount := COUNT(GROUP,h.dt_first_seen_Invalid=1);
    dt_first_seen_QUOTES_ErrorCount := COUNT(GROUP,h.dt_first_seen_Invalid=2);
    dt_first_seen_Total_ErrorCount := COUNT(GROUP,h.dt_first_seen_Invalid>0);
    dt_last_seen_LEFTTRIM_ErrorCount := COUNT(GROUP,h.dt_last_seen_Invalid=1);
    dt_last_seen_QUOTES_ErrorCount := COUNT(GROUP,h.dt_last_seen_Invalid=2);
    dt_last_seen_Total_ErrorCount := COUNT(GROUP,h.dt_last_seen_Invalid>0);
    dt_vendor_first_reported_LEFTTRIM_ErrorCount := COUNT(GROUP,h.dt_vendor_first_reported_Invalid=1);
    dt_vendor_first_reported_QUOTES_ErrorCount := COUNT(GROUP,h.dt_vendor_first_reported_Invalid=2);
    dt_vendor_first_reported_Total_ErrorCount := COUNT(GROUP,h.dt_vendor_first_reported_Invalid>0);
    dt_vendor_last_reported_LEFTTRIM_ErrorCount := COUNT(GROUP,h.dt_vendor_last_reported_Invalid=1);
    dt_vendor_last_reported_QUOTES_ErrorCount := COUNT(GROUP,h.dt_vendor_last_reported_Invalid=2);
    dt_vendor_last_reported_Total_ErrorCount := COUNT(GROUP,h.dt_vendor_last_reported_Invalid>0);
    date_updated_ALLOW_ErrorCount := COUNT(GROUP,h.date_updated_Invalid=1);
    type_instituon_code_ALLOW_ErrorCount := COUNT(GROUP,h.type_instituon_code_Invalid=1);
    head_office_branch_codes_ALLOW_ErrorCount := COUNT(GROUP,h.head_office_branch_codes_Invalid=1);
    routing_number_micr_ALLOW_ErrorCount := COUNT(GROUP,h.routing_number_micr_Invalid=1);
    routing_number_fractional_ALLOW_ErrorCount := COUNT(GROUP,h.routing_number_fractional_Invalid=1);
    institution_name_full_CAPS_ErrorCount := COUNT(GROUP,h.institution_name_full_Invalid=1);
    institution_name_full_CAPS_WouldModifyCount := COUNT(GROUP,h.institution_name_full_Invalid=1 AND h.institution_name_full_wouldClean);
    institution_name_full_ALLOW_ErrorCount := COUNT(GROUP,h.institution_name_full_Invalid=2);
    institution_name_full_ALLOW_WouldModifyCount := COUNT(GROUP,h.institution_name_full_Invalid=2 AND h.institution_name_full_wouldClean);
    institution_name_full_Total_ErrorCount := COUNT(GROUP,h.institution_name_full_Invalid>0);
    institution_name_abbreviated_CAPS_ErrorCount := COUNT(GROUP,h.institution_name_abbreviated_Invalid=1);
    institution_name_abbreviated_CAPS_WouldModifyCount := COUNT(GROUP,h.institution_name_abbreviated_Invalid=1 AND h.institution_name_abbreviated_wouldClean);
    institution_name_abbreviated_ALLOW_ErrorCount := COUNT(GROUP,h.institution_name_abbreviated_Invalid=2);
    institution_name_abbreviated_ALLOW_WouldModifyCount := COUNT(GROUP,h.institution_name_abbreviated_Invalid=2 AND h.institution_name_abbreviated_wouldClean);
    institution_name_abbreviated_Total_ErrorCount := COUNT(GROUP,h.institution_name_abbreviated_Invalid>0);
    street_address_CAPS_ErrorCount := COUNT(GROUP,h.street_address_Invalid=1);
    street_address_CAPS_WouldModifyCount := COUNT(GROUP,h.street_address_Invalid=1 AND h.street_address_wouldClean);
    street_address_ALLOW_ErrorCount := COUNT(GROUP,h.street_address_Invalid=2);
    street_address_ALLOW_WouldModifyCount := COUNT(GROUP,h.street_address_Invalid=2 AND h.street_address_wouldClean);
    street_address_Total_ErrorCount := COUNT(GROUP,h.street_address_Invalid>0);
    city_town_CAPS_ErrorCount := COUNT(GROUP,h.city_town_Invalid=1);
    city_town_CAPS_WouldModifyCount := COUNT(GROUP,h.city_town_Invalid=1 AND h.city_town_wouldClean);
    city_town_ALLOW_ErrorCount := COUNT(GROUP,h.city_town_Invalid=2);
    city_town_ALLOW_WouldModifyCount := COUNT(GROUP,h.city_town_Invalid=2 AND h.city_town_wouldClean);
    city_town_LENGTH_ErrorCount := COUNT(GROUP,h.city_town_Invalid=3);
    city_town_LENGTH_WouldModifyCount := COUNT(GROUP,h.city_town_Invalid=3 AND h.city_town_wouldClean);
    city_town_WORDS_ErrorCount := COUNT(GROUP,h.city_town_Invalid=4);
    city_town_WORDS_WouldModifyCount := COUNT(GROUP,h.city_town_Invalid=4 AND h.city_town_wouldClean);
    city_town_Total_ErrorCount := COUNT(GROUP,h.city_town_Invalid>0);
    state_CAPS_ErrorCount := COUNT(GROUP,h.state_Invalid=1);
    state_CAPS_WouldModifyCount := COUNT(GROUP,h.state_Invalid=1 AND h.state_wouldClean);
    state_ALLOW_ErrorCount := COUNT(GROUP,h.state_Invalid=2);
    state_ALLOW_WouldModifyCount := COUNT(GROUP,h.state_Invalid=2 AND h.state_wouldClean);
    state_LENGTH_ErrorCount := COUNT(GROUP,h.state_Invalid=3);
    state_LENGTH_WouldModifyCount := COUNT(GROUP,h.state_Invalid=3 AND h.state_wouldClean);
    state_WORDS_ErrorCount := COUNT(GROUP,h.state_Invalid=4);
    state_WORDS_WouldModifyCount := COUNT(GROUP,h.state_Invalid=4 AND h.state_wouldClean);
    state_Total_ErrorCount := COUNT(GROUP,h.state_Invalid>0);
    zip_code_ALLOW_ErrorCount := COUNT(GROUP,h.zip_code_Invalid=1);
    zip_code_ALLOW_WouldModifyCount := COUNT(GROUP,h.zip_code_Invalid=1 AND h.zip_code_wouldClean);
    zip_code_LENGTH_ErrorCount := COUNT(GROUP,h.zip_code_Invalid=2);
    zip_code_LENGTH_WouldModifyCount := COUNT(GROUP,h.zip_code_Invalid=2 AND h.zip_code_wouldClean);
    zip_code_Total_ErrorCount := COUNT(GROUP,h.zip_code_Invalid>0);
    zip_4_ALLOW_ErrorCount := COUNT(GROUP,h.zip_4_Invalid=1);
    zip_4_ALLOW_WouldModifyCount := COUNT(GROUP,h.zip_4_Invalid=1 AND h.zip_4_wouldClean);
    zip_4_LENGTH_ErrorCount := COUNT(GROUP,h.zip_4_Invalid=2);
    zip_4_LENGTH_WouldModifyCount := COUNT(GROUP,h.zip_4_Invalid=2 AND h.zip_4_wouldClean);
    zip_4_Total_ErrorCount := COUNT(GROUP,h.zip_4_Invalid>0);
    mail_address_CAPS_ErrorCount := COUNT(GROUP,h.mail_address_Invalid=1);
    mail_address_CAPS_WouldModifyCount := COUNT(GROUP,h.mail_address_Invalid=1 AND h.mail_address_wouldClean);
    mail_address_ALLOW_ErrorCount := COUNT(GROUP,h.mail_address_Invalid=2);
    mail_address_ALLOW_WouldModifyCount := COUNT(GROUP,h.mail_address_Invalid=2 AND h.mail_address_wouldClean);
    mail_address_Total_ErrorCount := COUNT(GROUP,h.mail_address_Invalid>0);
    mail_city_town_CAPS_ErrorCount := COUNT(GROUP,h.mail_city_town_Invalid=1);
    mail_city_town_CAPS_WouldModifyCount := COUNT(GROUP,h.mail_city_town_Invalid=1 AND h.mail_city_town_wouldClean);
    mail_city_town_ALLOW_ErrorCount := COUNT(GROUP,h.mail_city_town_Invalid=2);
    mail_city_town_ALLOW_WouldModifyCount := COUNT(GROUP,h.mail_city_town_Invalid=2 AND h.mail_city_town_wouldClean);
    mail_city_town_LENGTH_ErrorCount := COUNT(GROUP,h.mail_city_town_Invalid=3);
    mail_city_town_LENGTH_WouldModifyCount := COUNT(GROUP,h.mail_city_town_Invalid=3 AND h.mail_city_town_wouldClean);
    mail_city_town_WORDS_ErrorCount := COUNT(GROUP,h.mail_city_town_Invalid=4);
    mail_city_town_WORDS_WouldModifyCount := COUNT(GROUP,h.mail_city_town_Invalid=4 AND h.mail_city_town_wouldClean);
    mail_city_town_Total_ErrorCount := COUNT(GROUP,h.mail_city_town_Invalid>0);
    mail_state_CAPS_ErrorCount := COUNT(GROUP,h.mail_state_Invalid=1);
    mail_state_CAPS_WouldModifyCount := COUNT(GROUP,h.mail_state_Invalid=1 AND h.mail_state_wouldClean);
    mail_state_ALLOW_ErrorCount := COUNT(GROUP,h.mail_state_Invalid=2);
    mail_state_ALLOW_WouldModifyCount := COUNT(GROUP,h.mail_state_Invalid=2 AND h.mail_state_wouldClean);
    mail_state_LENGTH_ErrorCount := COUNT(GROUP,h.mail_state_Invalid=3);
    mail_state_LENGTH_WouldModifyCount := COUNT(GROUP,h.mail_state_Invalid=3 AND h.mail_state_wouldClean);
    mail_state_WORDS_ErrorCount := COUNT(GROUP,h.mail_state_Invalid=4);
    mail_state_WORDS_WouldModifyCount := COUNT(GROUP,h.mail_state_Invalid=4 AND h.mail_state_wouldClean);
    mail_state_Total_ErrorCount := COUNT(GROUP,h.mail_state_Invalid>0);
    mail_zip_code_ALLOW_ErrorCount := COUNT(GROUP,h.mail_zip_code_Invalid=1);
    mail_zip_code_ALLOW_WouldModifyCount := COUNT(GROUP,h.mail_zip_code_Invalid=1 AND h.mail_zip_code_wouldClean);
    mail_zip_code_LENGTH_ErrorCount := COUNT(GROUP,h.mail_zip_code_Invalid=2);
    mail_zip_code_LENGTH_WouldModifyCount := COUNT(GROUP,h.mail_zip_code_Invalid=2 AND h.mail_zip_code_wouldClean);
    mail_zip_code_Total_ErrorCount := COUNT(GROUP,h.mail_zip_code_Invalid>0);
    mail_zip_4_ALLOW_ErrorCount := COUNT(GROUP,h.mail_zip_4_Invalid=1);
    mail_zip_4_ALLOW_WouldModifyCount := COUNT(GROUP,h.mail_zip_4_Invalid=1 AND h.mail_zip_4_wouldClean);
    mail_zip_4_LENGTH_ErrorCount := COUNT(GROUP,h.mail_zip_4_Invalid=2);
    mail_zip_4_LENGTH_WouldModifyCount := COUNT(GROUP,h.mail_zip_4_Invalid=2 AND h.mail_zip_4_wouldClean);
    mail_zip_4_Total_ErrorCount := COUNT(GROUP,h.mail_zip_4_Invalid>0);
    branch_office_name_CAPS_ErrorCount := COUNT(GROUP,h.branch_office_name_Invalid=1);
    branch_office_name_CAPS_WouldModifyCount := COUNT(GROUP,h.branch_office_name_Invalid=1 AND h.branch_office_name_wouldClean);
    branch_office_name_ALLOW_ErrorCount := COUNT(GROUP,h.branch_office_name_Invalid=2);
    branch_office_name_ALLOW_WouldModifyCount := COUNT(GROUP,h.branch_office_name_Invalid=2 AND h.branch_office_name_wouldClean);
    branch_office_name_Total_ErrorCount := COUNT(GROUP,h.branch_office_name_Invalid>0);
    head_office_routing_number_ALLOW_ErrorCount := COUNT(GROUP,h.head_office_routing_number_Invalid=1);
    phone_number_area_code_ALLOW_ErrorCount := COUNT(GROUP,h.phone_number_area_code_Invalid=1);
    phone_number_ALLOW_ErrorCount := COUNT(GROUP,h.phone_number_Invalid=1);
    phone_number_extension_ALLOW_ErrorCount := COUNT(GROUP,h.phone_number_extension_Invalid=1);
    fax_area_code_ALLOW_ErrorCount := COUNT(GROUP,h.fax_area_code_Invalid=1);
    fax_number_ALLOW_ErrorCount := COUNT(GROUP,h.fax_number_Invalid=1);
    fax_extension_ALLOW_ErrorCount := COUNT(GROUP,h.fax_extension_Invalid=1);
    head_office_asset_size_ALLOW_ErrorCount := COUNT(GROUP,h.head_office_asset_size_Invalid=1);
    federal_reserve_district_code_LEFTTRIM_ErrorCount := COUNT(GROUP,h.federal_reserve_district_code_Invalid=1);
    federal_reserve_district_code_QUOTES_ErrorCount := COUNT(GROUP,h.federal_reserve_district_code_Invalid=2);
    federal_reserve_district_code_Total_ErrorCount := COUNT(GROUP,h.federal_reserve_district_code_Invalid>0);
    year_2000_date_last_updated_ALLOW_ErrorCount := COUNT(GROUP,h.year_2000_date_last_updated_Invalid=1);
    head_office_file_key_ALLOW_ErrorCount := COUNT(GROUP,h.head_office_file_key_Invalid=1);
    routing_number_type_CAPS_ErrorCount := COUNT(GROUP,h.routing_number_type_Invalid=1);
    routing_number_type_CAPS_WouldModifyCount := COUNT(GROUP,h.routing_number_type_Invalid=1 AND h.routing_number_type_wouldClean);
    routing_number_type_ALLOW_ErrorCount := COUNT(GROUP,h.routing_number_type_Invalid=2);
    routing_number_type_ALLOW_WouldModifyCount := COUNT(GROUP,h.routing_number_type_Invalid=2 AND h.routing_number_type_wouldClean);
    routing_number_type_Total_ErrorCount := COUNT(GROUP,h.routing_number_type_Invalid>0);
    routing_number_status_CAPS_ErrorCount := COUNT(GROUP,h.routing_number_status_Invalid=1);
    routing_number_status_ALLOW_ErrorCount := COUNT(GROUP,h.routing_number_status_Invalid=2);
    routing_number_status_Total_ErrorCount := COUNT(GROUP,h.routing_number_status_Invalid>0);
    employer_tax_id_ALLOW_ErrorCount := COUNT(GROUP,h.employer_tax_id_Invalid=1);
    institution_identifier_ALLOW_ErrorCount := COUNT(GROUP,h.institution_identifier_Invalid=1);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.file_key_Invalid > 0 OR h.dt_first_seen_Invalid > 0 OR h.dt_last_seen_Invalid > 0 OR h.dt_vendor_first_reported_Invalid > 0 OR h.dt_vendor_last_reported_Invalid > 0 OR h.date_updated_Invalid > 0 OR h.type_instituon_code_Invalid > 0 OR h.head_office_branch_codes_Invalid > 0 OR h.routing_number_micr_Invalid > 0 OR h.routing_number_fractional_Invalid > 0 OR h.institution_name_full_Invalid > 0 OR h.institution_name_abbreviated_Invalid > 0 OR h.street_address_Invalid > 0 OR h.city_town_Invalid > 0 OR h.state_Invalid > 0 OR h.zip_code_Invalid > 0 OR h.zip_4_Invalid > 0 OR h.mail_address_Invalid > 0 OR h.mail_city_town_Invalid > 0 OR h.mail_state_Invalid > 0 OR h.mail_zip_code_Invalid > 0 OR h.mail_zip_4_Invalid > 0 OR h.branch_office_name_Invalid > 0 OR h.head_office_routing_number_Invalid > 0 OR h.phone_number_area_code_Invalid > 0 OR h.phone_number_Invalid > 0 OR h.phone_number_extension_Invalid > 0 OR h.fax_area_code_Invalid > 0 OR h.fax_number_Invalid > 0 OR h.fax_extension_Invalid > 0 OR h.head_office_asset_size_Invalid > 0 OR h.federal_reserve_district_code_Invalid > 0 OR h.year_2000_date_last_updated_Invalid > 0 OR h.head_office_file_key_Invalid > 0 OR h.routing_number_type_Invalid > 0 OR h.routing_number_status_Invalid > 0 OR h.employer_tax_id_Invalid > 0 OR h.institution_identifier_Invalid > 0);
    AnyRule_WithEditsCount := COUNT(GROUP, h.institution_name_full_wouldClean OR h.institution_name_abbreviated_wouldClean OR h.street_address_wouldClean OR h.city_town_wouldClean OR h.state_wouldClean OR h.zip_code_wouldClean OR h.zip_4_wouldClean OR h.mail_address_wouldClean OR h.mail_city_town_wouldClean OR h.mail_state_wouldClean OR h.mail_zip_code_wouldClean OR h.mail_zip_4_wouldClean OR h.branch_office_name_wouldClean OR h.routing_number_type_wouldClean);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
    Rules_WithEdits := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.file_key_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dt_first_seen_Total_ErrorCount > 0, 1, 0) + IF(le.dt_last_seen_Total_ErrorCount > 0, 1, 0) + IF(le.dt_vendor_first_reported_Total_ErrorCount > 0, 1, 0) + IF(le.dt_vendor_last_reported_Total_ErrorCount > 0, 1, 0) + IF(le.date_updated_ALLOW_ErrorCount > 0, 1, 0) + IF(le.type_instituon_code_ALLOW_ErrorCount > 0, 1, 0) + IF(le.head_office_branch_codes_ALLOW_ErrorCount > 0, 1, 0) + IF(le.routing_number_micr_ALLOW_ErrorCount > 0, 1, 0) + IF(le.routing_number_fractional_ALLOW_ErrorCount > 0, 1, 0) + IF(le.institution_name_full_Total_ErrorCount > 0, 1, 0) + IF(le.institution_name_abbreviated_Total_ErrorCount > 0, 1, 0) + IF(le.street_address_Total_ErrorCount > 0, 1, 0) + IF(le.city_town_Total_ErrorCount > 0, 1, 0) + IF(le.state_Total_ErrorCount > 0, 1, 0) + IF(le.zip_code_Total_ErrorCount > 0, 1, 0) + IF(le.zip_4_Total_ErrorCount > 0, 1, 0) + IF(le.mail_address_Total_ErrorCount > 0, 1, 0) + IF(le.mail_city_town_Total_ErrorCount > 0, 1, 0) + IF(le.mail_state_Total_ErrorCount > 0, 1, 0) + IF(le.mail_zip_code_Total_ErrorCount > 0, 1, 0) + IF(le.mail_zip_4_Total_ErrorCount > 0, 1, 0) + IF(le.branch_office_name_Total_ErrorCount > 0, 1, 0) + IF(le.head_office_routing_number_ALLOW_ErrorCount > 0, 1, 0) + IF(le.phone_number_area_code_ALLOW_ErrorCount > 0, 1, 0) + IF(le.phone_number_ALLOW_ErrorCount > 0, 1, 0) + IF(le.phone_number_extension_ALLOW_ErrorCount > 0, 1, 0) + IF(le.fax_area_code_ALLOW_ErrorCount > 0, 1, 0) + IF(le.fax_number_ALLOW_ErrorCount > 0, 1, 0) + IF(le.fax_extension_ALLOW_ErrorCount > 0, 1, 0) + IF(le.head_office_asset_size_ALLOW_ErrorCount > 0, 1, 0) + IF(le.federal_reserve_district_code_Total_ErrorCount > 0, 1, 0) + IF(le.year_2000_date_last_updated_ALLOW_ErrorCount > 0, 1, 0) + IF(le.head_office_file_key_ALLOW_ErrorCount > 0, 1, 0) + IF(le.routing_number_type_Total_ErrorCount > 0, 1, 0) + IF(le.routing_number_status_Total_ErrorCount > 0, 1, 0) + IF(le.employer_tax_id_ALLOW_ErrorCount > 0, 1, 0) + IF(le.institution_identifier_ALLOW_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.file_key_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dt_first_seen_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.dt_first_seen_QUOTES_ErrorCount > 0, 1, 0) + IF(le.dt_last_seen_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.dt_last_seen_QUOTES_ErrorCount > 0, 1, 0) + IF(le.dt_vendor_first_reported_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.dt_vendor_first_reported_QUOTES_ErrorCount > 0, 1, 0) + IF(le.dt_vendor_last_reported_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.dt_vendor_last_reported_QUOTES_ErrorCount > 0, 1, 0) + IF(le.date_updated_ALLOW_ErrorCount > 0, 1, 0) + IF(le.type_instituon_code_ALLOW_ErrorCount > 0, 1, 0) + IF(le.head_office_branch_codes_ALLOW_ErrorCount > 0, 1, 0) + IF(le.routing_number_micr_ALLOW_ErrorCount > 0, 1, 0) + IF(le.routing_number_fractional_ALLOW_ErrorCount > 0, 1, 0) + IF(le.institution_name_full_CAPS_ErrorCount > 0, 1, 0) + IF(le.institution_name_full_ALLOW_ErrorCount > 0, 1, 0) + IF(le.institution_name_abbreviated_CAPS_ErrorCount > 0, 1, 0) + IF(le.institution_name_abbreviated_ALLOW_ErrorCount > 0, 1, 0) + IF(le.street_address_CAPS_ErrorCount > 0, 1, 0) + IF(le.street_address_ALLOW_ErrorCount > 0, 1, 0) + IF(le.city_town_CAPS_ErrorCount > 0, 1, 0) + IF(le.city_town_ALLOW_ErrorCount > 0, 1, 0) + IF(le.city_town_LENGTH_ErrorCount > 0, 1, 0) + IF(le.city_town_WORDS_ErrorCount > 0, 1, 0) + IF(le.state_CAPS_ErrorCount > 0, 1, 0) + IF(le.state_ALLOW_ErrorCount > 0, 1, 0) + IF(le.state_LENGTH_ErrorCount > 0, 1, 0) + IF(le.state_WORDS_ErrorCount > 0, 1, 0) + IF(le.zip_code_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip_code_LENGTH_ErrorCount > 0, 1, 0) + IF(le.zip_4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip_4_LENGTH_ErrorCount > 0, 1, 0) + IF(le.mail_address_CAPS_ErrorCount > 0, 1, 0) + IF(le.mail_address_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_city_town_CAPS_ErrorCount > 0, 1, 0) + IF(le.mail_city_town_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_city_town_LENGTH_ErrorCount > 0, 1, 0) + IF(le.mail_city_town_WORDS_ErrorCount > 0, 1, 0) + IF(le.mail_state_CAPS_ErrorCount > 0, 1, 0) + IF(le.mail_state_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_state_LENGTH_ErrorCount > 0, 1, 0) + IF(le.mail_state_WORDS_ErrorCount > 0, 1, 0) + IF(le.mail_zip_code_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_zip_code_LENGTH_ErrorCount > 0, 1, 0) + IF(le.mail_zip_4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_zip_4_LENGTH_ErrorCount > 0, 1, 0) + IF(le.branch_office_name_CAPS_ErrorCount > 0, 1, 0) + IF(le.branch_office_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.head_office_routing_number_ALLOW_ErrorCount > 0, 1, 0) + IF(le.phone_number_area_code_ALLOW_ErrorCount > 0, 1, 0) + IF(le.phone_number_ALLOW_ErrorCount > 0, 1, 0) + IF(le.phone_number_extension_ALLOW_ErrorCount > 0, 1, 0) + IF(le.fax_area_code_ALLOW_ErrorCount > 0, 1, 0) + IF(le.fax_number_ALLOW_ErrorCount > 0, 1, 0) + IF(le.fax_extension_ALLOW_ErrorCount > 0, 1, 0) + IF(le.head_office_asset_size_ALLOW_ErrorCount > 0, 1, 0) + IF(le.federal_reserve_district_code_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.federal_reserve_district_code_QUOTES_ErrorCount > 0, 1, 0) + IF(le.year_2000_date_last_updated_ALLOW_ErrorCount > 0, 1, 0) + IF(le.head_office_file_key_ALLOW_ErrorCount > 0, 1, 0) + IF(le.routing_number_type_CAPS_ErrorCount > 0, 1, 0) + IF(le.routing_number_type_ALLOW_ErrorCount > 0, 1, 0) + IF(le.routing_number_status_CAPS_ErrorCount > 0, 1, 0) + IF(le.routing_number_status_ALLOW_ErrorCount > 0, 1, 0) + IF(le.employer_tax_id_ALLOW_ErrorCount > 0, 1, 0) + IF(le.institution_identifier_ALLOW_ErrorCount > 0, 1, 0);
    SELF.Rules_NoErrors := NumRules - SELF.Rules_WithErrors;
    SELF.Rules_WithEdits := IF(le.institution_name_full_CAPS_WouldModifyCount > 0, 1, 0) + IF(le.institution_name_full_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.institution_name_abbreviated_CAPS_WouldModifyCount > 0, 1, 0) + IF(le.institution_name_abbreviated_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.street_address_CAPS_WouldModifyCount > 0, 1, 0) + IF(le.street_address_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.city_town_CAPS_WouldModifyCount > 0, 1, 0) + IF(le.city_town_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.city_town_LENGTH_WouldModifyCount > 0, 1, 0) + IF(le.city_town_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.state_CAPS_WouldModifyCount > 0, 1, 0) + IF(le.state_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.state_LENGTH_WouldModifyCount > 0, 1, 0) + IF(le.state_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.zip_code_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.zip_code_LENGTH_WouldModifyCount > 0, 1, 0) + IF(le.zip_4_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.zip_4_LENGTH_WouldModifyCount > 0, 1, 0) + IF(le.mail_address_CAPS_WouldModifyCount > 0, 1, 0) + IF(le.mail_address_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.mail_city_town_CAPS_WouldModifyCount > 0, 1, 0) + IF(le.mail_city_town_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.mail_city_town_LENGTH_WouldModifyCount > 0, 1, 0) + IF(le.mail_city_town_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.mail_state_CAPS_WouldModifyCount > 0, 1, 0) + IF(le.mail_state_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.mail_state_LENGTH_WouldModifyCount > 0, 1, 0) + IF(le.mail_state_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.mail_zip_code_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.mail_zip_code_LENGTH_WouldModifyCount > 0, 1, 0) + IF(le.mail_zip_4_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.mail_zip_4_LENGTH_WouldModifyCount > 0, 1, 0) + IF(le.branch_office_name_CAPS_WouldModifyCount > 0, 1, 0) + IF(le.branch_office_name_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.routing_number_type_CAPS_WouldModifyCount > 0, 1, 0) + IF(le.routing_number_type_ALLOW_WouldModifyCount > 0, 1, 0);
    SELF := le;
  END;
  EXPORT SummaryStats := PROJECT(SummaryStats0, xAddErrSummary(LEFT));
  r := RECORD
    STRING10 Src;
    STRING FieldName;
    STRING FieldType;
    STRING ErrorType;
    SALT38.StrType ErrorMessage;
    SALT38.StrType FieldContents;
  END;
  r into(h le,UNSIGNED c) := TRANSFORM
    SELF.Src :=  ''; // Source not provided
    UNSIGNED1 ErrNum := CHOOSE(c,le.file_key_Invalid,le.dt_first_seen_Invalid,le.dt_last_seen_Invalid,le.dt_vendor_first_reported_Invalid,le.dt_vendor_last_reported_Invalid,le.date_updated_Invalid,le.type_instituon_code_Invalid,le.head_office_branch_codes_Invalid,le.routing_number_micr_Invalid,le.routing_number_fractional_Invalid,le.institution_name_full_Invalid,le.institution_name_abbreviated_Invalid,le.street_address_Invalid,le.city_town_Invalid,le.state_Invalid,le.zip_code_Invalid,le.zip_4_Invalid,le.mail_address_Invalid,le.mail_city_town_Invalid,le.mail_state_Invalid,le.mail_zip_code_Invalid,le.mail_zip_4_Invalid,le.branch_office_name_Invalid,le.head_office_routing_number_Invalid,le.phone_number_area_code_Invalid,le.phone_number_Invalid,le.phone_number_extension_Invalid,le.fax_area_code_Invalid,le.fax_number_Invalid,le.fax_extension_Invalid,le.head_office_asset_size_Invalid,le.federal_reserve_district_code_Invalid,le.year_2000_date_last_updated_Invalid,le.head_office_file_key_Invalid,le.routing_number_type_Invalid,le.routing_number_status_Invalid,le.employer_tax_id_Invalid,le.institution_identifier_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Fields.InvalidMessage_file_key(le.file_key_Invalid),Fields.InvalidMessage_dt_first_seen(le.dt_first_seen_Invalid),Fields.InvalidMessage_dt_last_seen(le.dt_last_seen_Invalid),Fields.InvalidMessage_dt_vendor_first_reported(le.dt_vendor_first_reported_Invalid),Fields.InvalidMessage_dt_vendor_last_reported(le.dt_vendor_last_reported_Invalid),Fields.InvalidMessage_date_updated(le.date_updated_Invalid),Fields.InvalidMessage_type_instituon_code(le.type_instituon_code_Invalid),Fields.InvalidMessage_head_office_branch_codes(le.head_office_branch_codes_Invalid),Fields.InvalidMessage_routing_number_micr(le.routing_number_micr_Invalid),Fields.InvalidMessage_routing_number_fractional(le.routing_number_fractional_Invalid),Fields.InvalidMessage_institution_name_full(le.institution_name_full_Invalid),Fields.InvalidMessage_institution_name_abbreviated(le.institution_name_abbreviated_Invalid),Fields.InvalidMessage_street_address(le.street_address_Invalid),Fields.InvalidMessage_city_town(le.city_town_Invalid),Fields.InvalidMessage_state(le.state_Invalid),Fields.InvalidMessage_zip_code(le.zip_code_Invalid),Fields.InvalidMessage_zip_4(le.zip_4_Invalid),Fields.InvalidMessage_mail_address(le.mail_address_Invalid),Fields.InvalidMessage_mail_city_town(le.mail_city_town_Invalid),Fields.InvalidMessage_mail_state(le.mail_state_Invalid),Fields.InvalidMessage_mail_zip_code(le.mail_zip_code_Invalid),Fields.InvalidMessage_mail_zip_4(le.mail_zip_4_Invalid),Fields.InvalidMessage_branch_office_name(le.branch_office_name_Invalid),Fields.InvalidMessage_head_office_routing_number(le.head_office_routing_number_Invalid),Fields.InvalidMessage_phone_number_area_code(le.phone_number_area_code_Invalid),Fields.InvalidMessage_phone_number(le.phone_number_Invalid),Fields.InvalidMessage_phone_number_extension(le.phone_number_extension_Invalid),Fields.InvalidMessage_fax_area_code(le.fax_area_code_Invalid),Fields.InvalidMessage_fax_number(le.fax_number_Invalid),Fields.InvalidMessage_fax_extension(le.fax_extension_Invalid),Fields.InvalidMessage_head_office_asset_size(le.head_office_asset_size_Invalid),Fields.InvalidMessage_federal_reserve_district_code(le.federal_reserve_district_code_Invalid),Fields.InvalidMessage_year_2000_date_last_updated(le.year_2000_date_last_updated_Invalid),Fields.InvalidMessage_head_office_file_key(le.head_office_file_key_Invalid),Fields.InvalidMessage_routing_number_type(le.routing_number_type_Invalid),Fields.InvalidMessage_routing_number_status(le.routing_number_status_Invalid),Fields.InvalidMessage_employer_tax_id(le.employer_tax_id_Invalid),Fields.InvalidMessage_institution_identifier(le.institution_identifier_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.file_key_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.dt_first_seen_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.dt_last_seen_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.dt_vendor_first_reported_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.dt_vendor_last_reported_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.date_updated_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.type_instituon_code_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.head_office_branch_codes_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.routing_number_micr_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.routing_number_fractional_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.institution_name_full_Invalid,'CAPS','ALLOW','UNKNOWN')
          ,CHOOSE(le.institution_name_abbreviated_Invalid,'CAPS','ALLOW','UNKNOWN')
          ,CHOOSE(le.street_address_Invalid,'CAPS','ALLOW','UNKNOWN')
          ,CHOOSE(le.city_town_Invalid,'CAPS','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.state_Invalid,'CAPS','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.zip_code_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.zip_4_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.mail_address_Invalid,'CAPS','ALLOW','UNKNOWN')
          ,CHOOSE(le.mail_city_town_Invalid,'CAPS','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.mail_state_Invalid,'CAPS','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.mail_zip_code_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.mail_zip_4_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.branch_office_name_Invalid,'CAPS','ALLOW','UNKNOWN')
          ,CHOOSE(le.head_office_routing_number_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.phone_number_area_code_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.phone_number_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.phone_number_extension_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.fax_area_code_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.fax_number_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.fax_extension_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.head_office_asset_size_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.federal_reserve_district_code_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.year_2000_date_last_updated_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.head_office_file_key_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.routing_number_type_Invalid,'CAPS','ALLOW','UNKNOWN')
          ,CHOOSE(le.routing_number_status_Invalid,'CAPS','ALLOW','UNKNOWN')
          ,CHOOSE(le.employer_tax_id_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.institution_identifier_Invalid,'ALLOW','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'file_key','dt_first_seen','dt_last_seen','dt_vendor_first_reported','dt_vendor_last_reported','date_updated','type_instituon_code','head_office_branch_codes','routing_number_micr','routing_number_fractional','institution_name_full','institution_name_abbreviated','street_address','city_town','state','zip_code','zip_4','mail_address','mail_city_town','mail_state','mail_zip_code','mail_zip_4','branch_office_name','head_office_routing_number','phone_number_area_code','phone_number','phone_number_extension','fax_area_code','fax_number','fax_extension','head_office_asset_size','federal_reserve_district_code','year_2000_date_last_updated','head_office_file_key','routing_number_type','routing_number_status','employer_tax_id','institution_identifier','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'NUMBER','DEFAULT','DEFAULT','DEFAULT','DEFAULT','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','UPPERNAME','UPPERNAME','STREET_ADDR','CITY','ST','ZIP5','HASZIP4','STREET_ADDR','CITY','ST','ZIP5','HASZIP4','UPPERNAME','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','DEFAULT','NUMBER','NUMBER','UPPERNAME','ALPHA','NUMBER','NUMBER','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT38.StrType)le.file_key,(SALT38.StrType)le.dt_first_seen,(SALT38.StrType)le.dt_last_seen,(SALT38.StrType)le.dt_vendor_first_reported,(SALT38.StrType)le.dt_vendor_last_reported,(SALT38.StrType)le.date_updated,(SALT38.StrType)le.type_instituon_code,(SALT38.StrType)le.head_office_branch_codes,(SALT38.StrType)le.routing_number_micr,(SALT38.StrType)le.routing_number_fractional,(SALT38.StrType)le.institution_name_full,(SALT38.StrType)le.institution_name_abbreviated,(SALT38.StrType)le.street_address,(SALT38.StrType)le.city_town,(SALT38.StrType)le.state,(SALT38.StrType)le.zip_code,(SALT38.StrType)le.zip_4,(SALT38.StrType)le.mail_address,(SALT38.StrType)le.mail_city_town,(SALT38.StrType)le.mail_state,(SALT38.StrType)le.mail_zip_code,(SALT38.StrType)le.mail_zip_4,(SALT38.StrType)le.branch_office_name,(SALT38.StrType)le.head_office_routing_number,(SALT38.StrType)le.phone_number_area_code,(SALT38.StrType)le.phone_number,(SALT38.StrType)le.phone_number_extension,(SALT38.StrType)le.fax_area_code,(SALT38.StrType)le.fax_number,(SALT38.StrType)le.fax_extension,(SALT38.StrType)le.head_office_asset_size,(SALT38.StrType)le.federal_reserve_district_code,(SALT38.StrType)le.year_2000_date_last_updated,(SALT38.StrType)le.head_office_file_key,(SALT38.StrType)le.routing_number_type,(SALT38.StrType)le.routing_number_status,(SALT38.StrType)le.employer_tax_id,(SALT38.StrType)le.institution_identifier,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,38,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(layout_bank_routing) prevDS = DATASET([], layout_bank_routing), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT38.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'file_key:NUMBER:ALLOW'
          ,'dt_first_seen:DEFAULT:LEFTTRIM','dt_first_seen:DEFAULT:QUOTES'
          ,'dt_last_seen:DEFAULT:LEFTTRIM','dt_last_seen:DEFAULT:QUOTES'
          ,'dt_vendor_first_reported:DEFAULT:LEFTTRIM','dt_vendor_first_reported:DEFAULT:QUOTES'
          ,'dt_vendor_last_reported:DEFAULT:LEFTTRIM','dt_vendor_last_reported:DEFAULT:QUOTES'
          ,'date_updated:NUMBER:ALLOW'
          ,'type_instituon_code:NUMBER:ALLOW'
          ,'head_office_branch_codes:NUMBER:ALLOW'
          ,'routing_number_micr:NUMBER:ALLOW'
          ,'routing_number_fractional:NUMBER:ALLOW'
          ,'institution_name_full:UPPERNAME:CAPS','institution_name_full:UPPERNAME:ALLOW'
          ,'institution_name_abbreviated:UPPERNAME:CAPS','institution_name_abbreviated:UPPERNAME:ALLOW'
          ,'street_address:STREET_ADDR:CAPS','street_address:STREET_ADDR:ALLOW'
          ,'city_town:CITY:CAPS','city_town:CITY:ALLOW','city_town:CITY:LENGTH','city_town:CITY:WORDS'
          ,'state:ST:CAPS','state:ST:ALLOW','state:ST:LENGTH','state:ST:WORDS'
          ,'zip_code:ZIP5:ALLOW','zip_code:ZIP5:LENGTH'
          ,'zip_4:HASZIP4:ALLOW','zip_4:HASZIP4:LENGTH'
          ,'mail_address:STREET_ADDR:CAPS','mail_address:STREET_ADDR:ALLOW'
          ,'mail_city_town:CITY:CAPS','mail_city_town:CITY:ALLOW','mail_city_town:CITY:LENGTH','mail_city_town:CITY:WORDS'
          ,'mail_state:ST:CAPS','mail_state:ST:ALLOW','mail_state:ST:LENGTH','mail_state:ST:WORDS'
          ,'mail_zip_code:ZIP5:ALLOW','mail_zip_code:ZIP5:LENGTH'
          ,'mail_zip_4:HASZIP4:ALLOW','mail_zip_4:HASZIP4:LENGTH'
          ,'branch_office_name:UPPERNAME:CAPS','branch_office_name:UPPERNAME:ALLOW'
          ,'head_office_routing_number:NUMBER:ALLOW'
          ,'phone_number_area_code:NUMBER:ALLOW'
          ,'phone_number:NUMBER:ALLOW'
          ,'phone_number_extension:NUMBER:ALLOW'
          ,'fax_area_code:NUMBER:ALLOW'
          ,'fax_number:NUMBER:ALLOW'
          ,'fax_extension:NUMBER:ALLOW'
          ,'head_office_asset_size:NUMBER:ALLOW'
          ,'federal_reserve_district_code:DEFAULT:LEFTTRIM','federal_reserve_district_code:DEFAULT:QUOTES'
          ,'year_2000_date_last_updated:NUMBER:ALLOW'
          ,'head_office_file_key:NUMBER:ALLOW'
          ,'routing_number_type:UPPERNAME:CAPS','routing_number_type:UPPERNAME:ALLOW'
          ,'routing_number_status:ALPHA:CAPS','routing_number_status:ALPHA:ALLOW'
          ,'employer_tax_id:NUMBER:ALLOW'
          ,'institution_identifier:NUMBER:ALLOW'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY'
          ,'record:Number_Edited_Records:SUMMARY'
          ,'rule:Number_Edited_Rules:SUMMARY','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,Fields.InvalidMessage_file_key(1)
          ,Fields.InvalidMessage_dt_first_seen(1),Fields.InvalidMessage_dt_first_seen(2)
          ,Fields.InvalidMessage_dt_last_seen(1),Fields.InvalidMessage_dt_last_seen(2)
          ,Fields.InvalidMessage_dt_vendor_first_reported(1),Fields.InvalidMessage_dt_vendor_first_reported(2)
          ,Fields.InvalidMessage_dt_vendor_last_reported(1),Fields.InvalidMessage_dt_vendor_last_reported(2)
          ,Fields.InvalidMessage_date_updated(1)
          ,Fields.InvalidMessage_type_instituon_code(1)
          ,Fields.InvalidMessage_head_office_branch_codes(1)
          ,Fields.InvalidMessage_routing_number_micr(1)
          ,Fields.InvalidMessage_routing_number_fractional(1)
          ,Fields.InvalidMessage_institution_name_full(1),Fields.InvalidMessage_institution_name_full(2)
          ,Fields.InvalidMessage_institution_name_abbreviated(1),Fields.InvalidMessage_institution_name_abbreviated(2)
          ,Fields.InvalidMessage_street_address(1),Fields.InvalidMessage_street_address(2)
          ,Fields.InvalidMessage_city_town(1),Fields.InvalidMessage_city_town(2),Fields.InvalidMessage_city_town(3),Fields.InvalidMessage_city_town(4)
          ,Fields.InvalidMessage_state(1),Fields.InvalidMessage_state(2),Fields.InvalidMessage_state(3),Fields.InvalidMessage_state(4)
          ,Fields.InvalidMessage_zip_code(1),Fields.InvalidMessage_zip_code(2)
          ,Fields.InvalidMessage_zip_4(1),Fields.InvalidMessage_zip_4(2)
          ,Fields.InvalidMessage_mail_address(1),Fields.InvalidMessage_mail_address(2)
          ,Fields.InvalidMessage_mail_city_town(1),Fields.InvalidMessage_mail_city_town(2),Fields.InvalidMessage_mail_city_town(3),Fields.InvalidMessage_mail_city_town(4)
          ,Fields.InvalidMessage_mail_state(1),Fields.InvalidMessage_mail_state(2),Fields.InvalidMessage_mail_state(3),Fields.InvalidMessage_mail_state(4)
          ,Fields.InvalidMessage_mail_zip_code(1),Fields.InvalidMessage_mail_zip_code(2)
          ,Fields.InvalidMessage_mail_zip_4(1),Fields.InvalidMessage_mail_zip_4(2)
          ,Fields.InvalidMessage_branch_office_name(1),Fields.InvalidMessage_branch_office_name(2)
          ,Fields.InvalidMessage_head_office_routing_number(1)
          ,Fields.InvalidMessage_phone_number_area_code(1)
          ,Fields.InvalidMessage_phone_number(1)
          ,Fields.InvalidMessage_phone_number_extension(1)
          ,Fields.InvalidMessage_fax_area_code(1)
          ,Fields.InvalidMessage_fax_number(1)
          ,Fields.InvalidMessage_fax_extension(1)
          ,Fields.InvalidMessage_head_office_asset_size(1)
          ,Fields.InvalidMessage_federal_reserve_district_code(1),Fields.InvalidMessage_federal_reserve_district_code(2)
          ,Fields.InvalidMessage_year_2000_date_last_updated(1)
          ,Fields.InvalidMessage_head_office_file_key(1)
          ,Fields.InvalidMessage_routing_number_type(1),Fields.InvalidMessage_routing_number_type(2)
          ,Fields.InvalidMessage_routing_number_status(1),Fields.InvalidMessage_routing_number_status(2)
          ,Fields.InvalidMessage_employer_tax_id(1)
          ,Fields.InvalidMessage_institution_identifier(1)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors'
          ,'Edited records'
          ,'Rules leading to edits','UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.file_key_ALLOW_ErrorCount
          ,le.dt_first_seen_LEFTTRIM_ErrorCount,le.dt_first_seen_QUOTES_ErrorCount
          ,le.dt_last_seen_LEFTTRIM_ErrorCount,le.dt_last_seen_QUOTES_ErrorCount
          ,le.dt_vendor_first_reported_LEFTTRIM_ErrorCount,le.dt_vendor_first_reported_QUOTES_ErrorCount
          ,le.dt_vendor_last_reported_LEFTTRIM_ErrorCount,le.dt_vendor_last_reported_QUOTES_ErrorCount
          ,le.date_updated_ALLOW_ErrorCount
          ,le.type_instituon_code_ALLOW_ErrorCount
          ,le.head_office_branch_codes_ALLOW_ErrorCount
          ,le.routing_number_micr_ALLOW_ErrorCount
          ,le.routing_number_fractional_ALLOW_ErrorCount
          ,le.institution_name_full_CAPS_ErrorCount,le.institution_name_full_ALLOW_ErrorCount
          ,le.institution_name_abbreviated_CAPS_ErrorCount,le.institution_name_abbreviated_ALLOW_ErrorCount
          ,le.street_address_CAPS_ErrorCount,le.street_address_ALLOW_ErrorCount
          ,le.city_town_CAPS_ErrorCount,le.city_town_ALLOW_ErrorCount,le.city_town_LENGTH_ErrorCount,le.city_town_WORDS_ErrorCount
          ,le.state_CAPS_ErrorCount,le.state_ALLOW_ErrorCount,le.state_LENGTH_ErrorCount,le.state_WORDS_ErrorCount
          ,le.zip_code_ALLOW_ErrorCount,le.zip_code_LENGTH_ErrorCount
          ,le.zip_4_ALLOW_ErrorCount,le.zip_4_LENGTH_ErrorCount
          ,le.mail_address_CAPS_ErrorCount,le.mail_address_ALLOW_ErrorCount
          ,le.mail_city_town_CAPS_ErrorCount,le.mail_city_town_ALLOW_ErrorCount,le.mail_city_town_LENGTH_ErrorCount,le.mail_city_town_WORDS_ErrorCount
          ,le.mail_state_CAPS_ErrorCount,le.mail_state_ALLOW_ErrorCount,le.mail_state_LENGTH_ErrorCount,le.mail_state_WORDS_ErrorCount
          ,le.mail_zip_code_ALLOW_ErrorCount,le.mail_zip_code_LENGTH_ErrorCount
          ,le.mail_zip_4_ALLOW_ErrorCount,le.mail_zip_4_LENGTH_ErrorCount
          ,le.branch_office_name_CAPS_ErrorCount,le.branch_office_name_ALLOW_ErrorCount
          ,le.head_office_routing_number_ALLOW_ErrorCount
          ,le.phone_number_area_code_ALLOW_ErrorCount
          ,le.phone_number_ALLOW_ErrorCount
          ,le.phone_number_extension_ALLOW_ErrorCount
          ,le.fax_area_code_ALLOW_ErrorCount
          ,le.fax_number_ALLOW_ErrorCount
          ,le.fax_extension_ALLOW_ErrorCount
          ,le.head_office_asset_size_ALLOW_ErrorCount
          ,le.federal_reserve_district_code_LEFTTRIM_ErrorCount,le.federal_reserve_district_code_QUOTES_ErrorCount
          ,le.year_2000_date_last_updated_ALLOW_ErrorCount
          ,le.head_office_file_key_ALLOW_ErrorCount
          ,le.routing_number_type_CAPS_ErrorCount,le.routing_number_type_ALLOW_ErrorCount
          ,le.routing_number_status_CAPS_ErrorCount,le.routing_number_status_ALLOW_ErrorCount
          ,le.employer_tax_id_ALLOW_ErrorCount
          ,le.institution_identifier_ALLOW_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount
          ,le.AnyRule_WithEditsCount
          ,le.Rules_WithEdits,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.file_key_ALLOW_ErrorCount
          ,le.dt_first_seen_LEFTTRIM_ErrorCount,le.dt_first_seen_QUOTES_ErrorCount
          ,le.dt_last_seen_LEFTTRIM_ErrorCount,le.dt_last_seen_QUOTES_ErrorCount
          ,le.dt_vendor_first_reported_LEFTTRIM_ErrorCount,le.dt_vendor_first_reported_QUOTES_ErrorCount
          ,le.dt_vendor_last_reported_LEFTTRIM_ErrorCount,le.dt_vendor_last_reported_QUOTES_ErrorCount
          ,le.date_updated_ALLOW_ErrorCount
          ,le.type_instituon_code_ALLOW_ErrorCount
          ,le.head_office_branch_codes_ALLOW_ErrorCount
          ,le.routing_number_micr_ALLOW_ErrorCount
          ,le.routing_number_fractional_ALLOW_ErrorCount
          ,le.institution_name_full_CAPS_ErrorCount,le.institution_name_full_ALLOW_ErrorCount
          ,le.institution_name_abbreviated_CAPS_ErrorCount,le.institution_name_abbreviated_ALLOW_ErrorCount
          ,le.street_address_CAPS_ErrorCount,le.street_address_ALLOW_ErrorCount
          ,le.city_town_CAPS_ErrorCount,le.city_town_ALLOW_ErrorCount,le.city_town_LENGTH_ErrorCount,le.city_town_WORDS_ErrorCount
          ,le.state_CAPS_ErrorCount,le.state_ALLOW_ErrorCount,le.state_LENGTH_ErrorCount,le.state_WORDS_ErrorCount
          ,le.zip_code_ALLOW_ErrorCount,le.zip_code_LENGTH_ErrorCount
          ,le.zip_4_ALLOW_ErrorCount,le.zip_4_LENGTH_ErrorCount
          ,le.mail_address_CAPS_ErrorCount,le.mail_address_ALLOW_ErrorCount
          ,le.mail_city_town_CAPS_ErrorCount,le.mail_city_town_ALLOW_ErrorCount,le.mail_city_town_LENGTH_ErrorCount,le.mail_city_town_WORDS_ErrorCount
          ,le.mail_state_CAPS_ErrorCount,le.mail_state_ALLOW_ErrorCount,le.mail_state_LENGTH_ErrorCount,le.mail_state_WORDS_ErrorCount
          ,le.mail_zip_code_ALLOW_ErrorCount,le.mail_zip_code_LENGTH_ErrorCount
          ,le.mail_zip_4_ALLOW_ErrorCount,le.mail_zip_4_LENGTH_ErrorCount
          ,le.branch_office_name_CAPS_ErrorCount,le.branch_office_name_ALLOW_ErrorCount
          ,le.head_office_routing_number_ALLOW_ErrorCount
          ,le.phone_number_area_code_ALLOW_ErrorCount
          ,le.phone_number_ALLOW_ErrorCount
          ,le.phone_number_extension_ALLOW_ErrorCount
          ,le.fax_area_code_ALLOW_ErrorCount
          ,le.fax_number_ALLOW_ErrorCount
          ,le.fax_extension_ALLOW_ErrorCount
          ,le.head_office_asset_size_ALLOW_ErrorCount
          ,le.federal_reserve_district_code_LEFTTRIM_ErrorCount,le.federal_reserve_district_code_QUOTES_ErrorCount
          ,le.year_2000_date_last_updated_ALLOW_ErrorCount
          ,le.head_office_file_key_ALLOW_ErrorCount
          ,le.routing_number_type_CAPS_ErrorCount,le.routing_number_type_ALLOW_ErrorCount
          ,le.routing_number_status_CAPS_ErrorCount,le.routing_number_status_ALLOW_ErrorCount
          ,le.employer_tax_id_ALLOW_ErrorCount
          ,le.institution_identifier_ALLOW_ErrorCount,0) / le.TotalCnt + 0.5, CHOOSE(c - NumRules
          ,IF(NumFieldsWithRules = 0, 0, le.FieldsChecked_WithErrors/NumFieldsWithRules * 100)
          ,IF(NumFieldsWithRules = 0, 0, le.FieldsChecked_NoErrors/NumFieldsWithRules * 100)
          ,IF(NumRules = 0, 0, le.Rules_WithErrors/NumRules * 100)
          ,IF(NumRules = 0, 0, le.Rules_NoErrors/NumRules * 100)
          ,0
          ,IF(SELF.recordstotal = 0, 0, le.AnyRule_WithErrorsCount/SELF.recordstotal * 100)
          ,IF(SELF.recordstotal = 0, 0, (SELF.recordstotal - le.AnyRule_WithErrorsCount)/SELF.recordstotal * 100)
          ,IF(SELF.recordstotal = 0, 0, le.AnyRule_WithEditsCount/SELF.recordstotal * 100)
          ,IF(NumRulesWithPossibleEdits = 0, 0, le.Rules_WithEdits/NumRulesWithPossibleEdits * 100),0));
    END;
    SummaryInfo := NORMALIZE(SummaryStats,NumRules + 9,Into(LEFT,COUNTER));
    orb_r := RECORD
      AllErrors.Src;
      STRING RuleDesc := TRIM(AllErrors.FieldName)+':'+TRIM(AllErrors.FieldType)+':'+AllErrors.ErrorType;
      STRING ErrorMessage := TRIM(AllErrors.errormessage);
      SALT38.StrType RawCodeMissing := AllErrors.FieldContents;
    END;
    tab := TABLE(AllErrors,orb_r);
    orb_sum := TABLE(tab,{src,ruledesc,ErrorMessage,rawcodemissing,rawcodemissingcnt := COUNT(GROUP)},src,ruledesc,ErrorMessage,rawcodemissing,MERGE);
    gt := GROUP(TOPN(GROUP(orb_sum,src,ruledesc,ALL),examples,-rawcodemissingcnt));
    SALT38.ScrubsOrbitLayout jn(SummaryInfo le, gt ri) := TRANSFORM
      SELF.rawcodemissing := ri.rawcodemissing;
      SELF.rawcodemissingcnt := ri.rawcodemissingcnt;
      SELF := le;
    END;
    j := JOIN(SummaryInfo,gt,LEFT.ruledesc=RIGHT.ruledesc,jn(LEFT,RIGHT),HASH,LEFT OUTER);
    FieldErrorStats := IF(examples>0,j,SummaryInfo);
 
    // field population stats
    mod_hygiene := hygiene(PROJECT(h, layout_bank_routing));
    hygiene_summaryStats := mod_hygiene.Summary('');
    getFieldTypeText(infield) := FUNCTIONMACRO
      isNumField := (STRING)((TYPEOF(infield))'') = '0';
      RETURN IF(isNumField, 'nonzero', 'nonblank');
    ENDMACRO;
    SALT38.ScrubsOrbitLayout xNormHygieneStats(hygiene_summaryStats le, UNSIGNED c, STRING suffix) := TRANSFORM
      SELF.recordstotal := le.NumberOfRecords;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'file_key:' + getFieldTypeText(h.file_key) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dt_first_seen:' + getFieldTypeText(h.dt_first_seen) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dt_last_seen:' + getFieldTypeText(h.dt_last_seen) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dt_vendor_first_reported:' + getFieldTypeText(h.dt_vendor_first_reported) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dt_vendor_last_reported:' + getFieldTypeText(h.dt_vendor_last_reported) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'date_updated:' + getFieldTypeText(h.date_updated) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'type_instituon_code:' + getFieldTypeText(h.type_instituon_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'head_office_branch_codes:' + getFieldTypeText(h.head_office_branch_codes) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'routing_number_micr:' + getFieldTypeText(h.routing_number_micr) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'routing_number_fractional:' + getFieldTypeText(h.routing_number_fractional) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'institution_name_full:' + getFieldTypeText(h.institution_name_full) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'institution_name_abbreviated:' + getFieldTypeText(h.institution_name_abbreviated) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'street_address:' + getFieldTypeText(h.street_address) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'city_town:' + getFieldTypeText(h.city_town) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'state:' + getFieldTypeText(h.state) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zip_code:' + getFieldTypeText(h.zip_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zip_4:' + getFieldTypeText(h.zip_4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mail_address:' + getFieldTypeText(h.mail_address) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mail_city_town:' + getFieldTypeText(h.mail_city_town) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mail_state:' + getFieldTypeText(h.mail_state) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mail_zip_code:' + getFieldTypeText(h.mail_zip_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mail_zip_4:' + getFieldTypeText(h.mail_zip_4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'branch_office_name:' + getFieldTypeText(h.branch_office_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'head_office_routing_number:' + getFieldTypeText(h.head_office_routing_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'phone_number_area_code:' + getFieldTypeText(h.phone_number_area_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'phone_number:' + getFieldTypeText(h.phone_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'phone_number_extension:' + getFieldTypeText(h.phone_number_extension) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fax_area_code:' + getFieldTypeText(h.fax_area_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fax_number:' + getFieldTypeText(h.fax_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fax_extension:' + getFieldTypeText(h.fax_extension) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'head_office_asset_size:' + getFieldTypeText(h.head_office_asset_size) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'federal_reserve_district_code:' + getFieldTypeText(h.federal_reserve_district_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'year_2000_date_last_updated:' + getFieldTypeText(h.year_2000_date_last_updated) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'head_office_file_key:' + getFieldTypeText(h.head_office_file_key) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'routing_number_type:' + getFieldTypeText(h.routing_number_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'routing_number_status:' + getFieldTypeText(h.routing_number_status) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'employer_tax_id:' + getFieldTypeText(h.employer_tax_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'institution_identifier:' + getFieldTypeText(h.institution_identifier) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_file_key_cnt
          ,le.populated_dt_first_seen_cnt
          ,le.populated_dt_last_seen_cnt
          ,le.populated_dt_vendor_first_reported_cnt
          ,le.populated_dt_vendor_last_reported_cnt
          ,le.populated_date_updated_cnt
          ,le.populated_type_instituon_code_cnt
          ,le.populated_head_office_branch_codes_cnt
          ,le.populated_routing_number_micr_cnt
          ,le.populated_routing_number_fractional_cnt
          ,le.populated_institution_name_full_cnt
          ,le.populated_institution_name_abbreviated_cnt
          ,le.populated_street_address_cnt
          ,le.populated_city_town_cnt
          ,le.populated_state_cnt
          ,le.populated_zip_code_cnt
          ,le.populated_zip_4_cnt
          ,le.populated_mail_address_cnt
          ,le.populated_mail_city_town_cnt
          ,le.populated_mail_state_cnt
          ,le.populated_mail_zip_code_cnt
          ,le.populated_mail_zip_4_cnt
          ,le.populated_branch_office_name_cnt
          ,le.populated_head_office_routing_number_cnt
          ,le.populated_phone_number_area_code_cnt
          ,le.populated_phone_number_cnt
          ,le.populated_phone_number_extension_cnt
          ,le.populated_fax_area_code_cnt
          ,le.populated_fax_number_cnt
          ,le.populated_fax_extension_cnt
          ,le.populated_head_office_asset_size_cnt
          ,le.populated_federal_reserve_district_code_cnt
          ,le.populated_year_2000_date_last_updated_cnt
          ,le.populated_head_office_file_key_cnt
          ,le.populated_routing_number_type_cnt
          ,le.populated_routing_number_status_cnt
          ,le.populated_employer_tax_id_cnt
          ,le.populated_institution_identifier_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_file_key_pcnt
          ,le.populated_dt_first_seen_pcnt
          ,le.populated_dt_last_seen_pcnt
          ,le.populated_dt_vendor_first_reported_pcnt
          ,le.populated_dt_vendor_last_reported_pcnt
          ,le.populated_date_updated_pcnt
          ,le.populated_type_instituon_code_pcnt
          ,le.populated_head_office_branch_codes_pcnt
          ,le.populated_routing_number_micr_pcnt
          ,le.populated_routing_number_fractional_pcnt
          ,le.populated_institution_name_full_pcnt
          ,le.populated_institution_name_abbreviated_pcnt
          ,le.populated_street_address_pcnt
          ,le.populated_city_town_pcnt
          ,le.populated_state_pcnt
          ,le.populated_zip_code_pcnt
          ,le.populated_zip_4_pcnt
          ,le.populated_mail_address_pcnt
          ,le.populated_mail_city_town_pcnt
          ,le.populated_mail_state_pcnt
          ,le.populated_mail_zip_code_pcnt
          ,le.populated_mail_zip_4_pcnt
          ,le.populated_branch_office_name_pcnt
          ,le.populated_head_office_routing_number_pcnt
          ,le.populated_phone_number_area_code_pcnt
          ,le.populated_phone_number_pcnt
          ,le.populated_phone_number_extension_pcnt
          ,le.populated_fax_area_code_pcnt
          ,le.populated_fax_number_pcnt
          ,le.populated_fax_extension_pcnt
          ,le.populated_head_office_asset_size_pcnt
          ,le.populated_federal_reserve_district_code_pcnt
          ,le.populated_year_2000_date_last_updated_pcnt
          ,le.populated_head_office_file_key_pcnt
          ,le.populated_routing_number_type_pcnt
          ,le.populated_routing_number_status_pcnt
          ,le.populated_employer_tax_id_pcnt
          ,le.populated_institution_identifier_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,38,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
  // record count stats
    SALT38.ScrubsOrbitLayout xTotalRecs(hygiene_summaryStats le, STRING inRuleDesc) := TRANSFORM
      SELF.recordstotal := le.NumberOfRecords;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := inRuleDesc;
      SELF.ErrorMessage := '';
      SELF.rulecnt := le.NumberOfRecords;
      SELF.rulepcnt := 0;
    END;
    TotalRecsStats := PROJECT(hygiene_summaryStats, xTotalRecs(LEFT, 'records:total_records:POP'));
 
    mod_Delta := Delta(prevDS, PROJECT(h, layout_bank_routing));
    deltaHygieneSummary := mod_Delta.DifferenceSummary;
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),38,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);
 
    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;
 
EXPORT StandardStats(DATASET(layout_bank_routing) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT38.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT38.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(scrubs_bank_routing, Fields, 'RECORDOF(scrubsSummaryOverall)', '');
  scrubsSummaryOverall_Standard := NORMALIZE(scrubsSummaryOverall, (NumRulesFromFieldType + NumFieldsWithRules) * 4, xSummaryStats(LEFT, COUNTER, myTimeStamp, 'all', 'all'));
 
  allErrsOverall := mod_fromexpandedOverall.AllErrors;
  tErrsOverall := TABLE(DISTRIBUTE(allErrsOverall, HASH(FieldName, ErrorType)), {FieldName, ErrorType, FieldContents, cntExamples := COUNT(GROUP)}, FieldName, ErrorType, FieldContents, LOCAL);
 
  scrubsSummaryOverall_Standard_addErr   := IF(doErrorOverall,
                                               DENORMALIZE(SORT(DISTRIBUTE(scrubsSummaryOverall_Standard, HASH(field, ruletype)), field, ruletype, LOCAL),
  	                                                       SORT(tErrsOverall, FieldName, ErrorType, -cntExamples, FieldContents, LOCAL),
  	                                                       LEFT.field = RIGHT.FieldName AND LEFT.ruletype = RIGHT.ErrorType AND LEFT.MeasureType = 'CntRecs',
  	                                                       TRANSFORM(RECORDOF(LEFT),
  	                                                       SELF.dsExamples := LEFT.dsExamples & DATASET([{RIGHT.FieldContents, RIGHT.cntExamples, IF(LEFT.StatValue > 0, RIGHT.cntExamples/LEFT.StatValue * 100, 0)}], SALT38.Layout_Stats_Standard.Examples);
  	                                                       SELF := LEFT),
  	                                                       KEEP(10), LEFT OUTER, LOCAL, NOSORT));
  scrubsSummaryOverall_Standard_GeneralErrs := IF(doErrorOverall, SALT38.mod_StandardStatsTransforms.scrubsSummaryStatsGeneral(scrubsSummaryOverall,, myTimeStamp, 'all', 'all'));
 
  RETURN scrubsSummaryOverall_Standard_addErr & scrubsSummaryOverall_Standard_GeneralErrs;
END;
END;
