IMPORT SALT38,STD;
EXPORT hygiene(dataset(layout_bank_routing) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT38.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_file_key_cnt := COUNT(GROUP,h.file_key <> (TYPEOF(h.file_key))'');
    populated_file_key_pcnt := AVE(GROUP,IF(h.file_key = (TYPEOF(h.file_key))'',0,100));
    maxlength_file_key := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.file_key)));
    avelength_file_key := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.file_key)),h.file_key<>(typeof(h.file_key))'');
    populated_dt_first_seen_cnt := COUNT(GROUP,h.dt_first_seen <> (TYPEOF(h.dt_first_seen))'');
    populated_dt_first_seen_pcnt := AVE(GROUP,IF(h.dt_first_seen = (TYPEOF(h.dt_first_seen))'',0,100));
    maxlength_dt_first_seen := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.dt_first_seen)));
    avelength_dt_first_seen := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.dt_first_seen)),h.dt_first_seen<>(typeof(h.dt_first_seen))'');
    populated_dt_last_seen_cnt := COUNT(GROUP,h.dt_last_seen <> (TYPEOF(h.dt_last_seen))'');
    populated_dt_last_seen_pcnt := AVE(GROUP,IF(h.dt_last_seen = (TYPEOF(h.dt_last_seen))'',0,100));
    maxlength_dt_last_seen := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.dt_last_seen)));
    avelength_dt_last_seen := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.dt_last_seen)),h.dt_last_seen<>(typeof(h.dt_last_seen))'');
    populated_dt_vendor_first_reported_cnt := COUNT(GROUP,h.dt_vendor_first_reported <> (TYPEOF(h.dt_vendor_first_reported))'');
    populated_dt_vendor_first_reported_pcnt := AVE(GROUP,IF(h.dt_vendor_first_reported = (TYPEOF(h.dt_vendor_first_reported))'',0,100));
    maxlength_dt_vendor_first_reported := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.dt_vendor_first_reported)));
    avelength_dt_vendor_first_reported := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.dt_vendor_first_reported)),h.dt_vendor_first_reported<>(typeof(h.dt_vendor_first_reported))'');
    populated_dt_vendor_last_reported_cnt := COUNT(GROUP,h.dt_vendor_last_reported <> (TYPEOF(h.dt_vendor_last_reported))'');
    populated_dt_vendor_last_reported_pcnt := AVE(GROUP,IF(h.dt_vendor_last_reported = (TYPEOF(h.dt_vendor_last_reported))'',0,100));
    maxlength_dt_vendor_last_reported := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.dt_vendor_last_reported)));
    avelength_dt_vendor_last_reported := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.dt_vendor_last_reported)),h.dt_vendor_last_reported<>(typeof(h.dt_vendor_last_reported))'');
    populated_date_updated_cnt := COUNT(GROUP,h.date_updated <> (TYPEOF(h.date_updated))'');
    populated_date_updated_pcnt := AVE(GROUP,IF(h.date_updated = (TYPEOF(h.date_updated))'',0,100));
    maxlength_date_updated := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.date_updated)));
    avelength_date_updated := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.date_updated)),h.date_updated<>(typeof(h.date_updated))'');
    populated_type_instituon_code_cnt := COUNT(GROUP,h.type_instituon_code <> (TYPEOF(h.type_instituon_code))'');
    populated_type_instituon_code_pcnt := AVE(GROUP,IF(h.type_instituon_code = (TYPEOF(h.type_instituon_code))'',0,100));
    maxlength_type_instituon_code := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.type_instituon_code)));
    avelength_type_instituon_code := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.type_instituon_code)),h.type_instituon_code<>(typeof(h.type_instituon_code))'');
    populated_head_office_branch_codes_cnt := COUNT(GROUP,h.head_office_branch_codes <> (TYPEOF(h.head_office_branch_codes))'');
    populated_head_office_branch_codes_pcnt := AVE(GROUP,IF(h.head_office_branch_codes = (TYPEOF(h.head_office_branch_codes))'',0,100));
    maxlength_head_office_branch_codes := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.head_office_branch_codes)));
    avelength_head_office_branch_codes := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.head_office_branch_codes)),h.head_office_branch_codes<>(typeof(h.head_office_branch_codes))'');
    populated_routing_number_micr_cnt := COUNT(GROUP,h.routing_number_micr <> (TYPEOF(h.routing_number_micr))'');
    populated_routing_number_micr_pcnt := AVE(GROUP,IF(h.routing_number_micr = (TYPEOF(h.routing_number_micr))'',0,100));
    maxlength_routing_number_micr := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.routing_number_micr)));
    avelength_routing_number_micr := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.routing_number_micr)),h.routing_number_micr<>(typeof(h.routing_number_micr))'');
    populated_routing_number_fractional_cnt := COUNT(GROUP,h.routing_number_fractional <> (TYPEOF(h.routing_number_fractional))'');
    populated_routing_number_fractional_pcnt := AVE(GROUP,IF(h.routing_number_fractional = (TYPEOF(h.routing_number_fractional))'',0,100));
    maxlength_routing_number_fractional := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.routing_number_fractional)));
    avelength_routing_number_fractional := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.routing_number_fractional)),h.routing_number_fractional<>(typeof(h.routing_number_fractional))'');
    populated_institution_name_full_cnt := COUNT(GROUP,h.institution_name_full <> (TYPEOF(h.institution_name_full))'');
    populated_institution_name_full_pcnt := AVE(GROUP,IF(h.institution_name_full = (TYPEOF(h.institution_name_full))'',0,100));
    maxlength_institution_name_full := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.institution_name_full)));
    avelength_institution_name_full := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.institution_name_full)),h.institution_name_full<>(typeof(h.institution_name_full))'');
    populated_institution_name_abbreviated_cnt := COUNT(GROUP,h.institution_name_abbreviated <> (TYPEOF(h.institution_name_abbreviated))'');
    populated_institution_name_abbreviated_pcnt := AVE(GROUP,IF(h.institution_name_abbreviated = (TYPEOF(h.institution_name_abbreviated))'',0,100));
    maxlength_institution_name_abbreviated := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.institution_name_abbreviated)));
    avelength_institution_name_abbreviated := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.institution_name_abbreviated)),h.institution_name_abbreviated<>(typeof(h.institution_name_abbreviated))'');
    populated_street_address_cnt := COUNT(GROUP,h.street_address <> (TYPEOF(h.street_address))'');
    populated_street_address_pcnt := AVE(GROUP,IF(h.street_address = (TYPEOF(h.street_address))'',0,100));
    maxlength_street_address := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.street_address)));
    avelength_street_address := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.street_address)),h.street_address<>(typeof(h.street_address))'');
    populated_city_town_cnt := COUNT(GROUP,h.city_town <> (TYPEOF(h.city_town))'');
    populated_city_town_pcnt := AVE(GROUP,IF(h.city_town = (TYPEOF(h.city_town))'',0,100));
    maxlength_city_town := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.city_town)));
    avelength_city_town := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.city_town)),h.city_town<>(typeof(h.city_town))'');
    populated_state_cnt := COUNT(GROUP,h.state <> (TYPEOF(h.state))'');
    populated_state_pcnt := AVE(GROUP,IF(h.state = (TYPEOF(h.state))'',0,100));
    maxlength_state := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.state)));
    avelength_state := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.state)),h.state<>(typeof(h.state))'');
    populated_zip_code_cnt := COUNT(GROUP,h.zip_code <> (TYPEOF(h.zip_code))'');
    populated_zip_code_pcnt := AVE(GROUP,IF(h.zip_code = (TYPEOF(h.zip_code))'',0,100));
    maxlength_zip_code := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.zip_code)));
    avelength_zip_code := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.zip_code)),h.zip_code<>(typeof(h.zip_code))'');
    populated_zip_4_cnt := COUNT(GROUP,h.zip_4 <> (TYPEOF(h.zip_4))'');
    populated_zip_4_pcnt := AVE(GROUP,IF(h.zip_4 = (TYPEOF(h.zip_4))'',0,100));
    maxlength_zip_4 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.zip_4)));
    avelength_zip_4 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.zip_4)),h.zip_4<>(typeof(h.zip_4))'');
    populated_mail_address_cnt := COUNT(GROUP,h.mail_address <> (TYPEOF(h.mail_address))'');
    populated_mail_address_pcnt := AVE(GROUP,IF(h.mail_address = (TYPEOF(h.mail_address))'',0,100));
    maxlength_mail_address := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.mail_address)));
    avelength_mail_address := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.mail_address)),h.mail_address<>(typeof(h.mail_address))'');
    populated_mail_city_town_cnt := COUNT(GROUP,h.mail_city_town <> (TYPEOF(h.mail_city_town))'');
    populated_mail_city_town_pcnt := AVE(GROUP,IF(h.mail_city_town = (TYPEOF(h.mail_city_town))'',0,100));
    maxlength_mail_city_town := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.mail_city_town)));
    avelength_mail_city_town := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.mail_city_town)),h.mail_city_town<>(typeof(h.mail_city_town))'');
    populated_mail_state_cnt := COUNT(GROUP,h.mail_state <> (TYPEOF(h.mail_state))'');
    populated_mail_state_pcnt := AVE(GROUP,IF(h.mail_state = (TYPEOF(h.mail_state))'',0,100));
    maxlength_mail_state := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.mail_state)));
    avelength_mail_state := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.mail_state)),h.mail_state<>(typeof(h.mail_state))'');
    populated_mail_zip_code_cnt := COUNT(GROUP,h.mail_zip_code <> (TYPEOF(h.mail_zip_code))'');
    populated_mail_zip_code_pcnt := AVE(GROUP,IF(h.mail_zip_code = (TYPEOF(h.mail_zip_code))'',0,100));
    maxlength_mail_zip_code := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.mail_zip_code)));
    avelength_mail_zip_code := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.mail_zip_code)),h.mail_zip_code<>(typeof(h.mail_zip_code))'');
    populated_mail_zip_4_cnt := COUNT(GROUP,h.mail_zip_4 <> (TYPEOF(h.mail_zip_4))'');
    populated_mail_zip_4_pcnt := AVE(GROUP,IF(h.mail_zip_4 = (TYPEOF(h.mail_zip_4))'',0,100));
    maxlength_mail_zip_4 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.mail_zip_4)));
    avelength_mail_zip_4 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.mail_zip_4)),h.mail_zip_4<>(typeof(h.mail_zip_4))'');
    populated_branch_office_name_cnt := COUNT(GROUP,h.branch_office_name <> (TYPEOF(h.branch_office_name))'');
    populated_branch_office_name_pcnt := AVE(GROUP,IF(h.branch_office_name = (TYPEOF(h.branch_office_name))'',0,100));
    maxlength_branch_office_name := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.branch_office_name)));
    avelength_branch_office_name := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.branch_office_name)),h.branch_office_name<>(typeof(h.branch_office_name))'');
    populated_head_office_routing_number_cnt := COUNT(GROUP,h.head_office_routing_number <> (TYPEOF(h.head_office_routing_number))'');
    populated_head_office_routing_number_pcnt := AVE(GROUP,IF(h.head_office_routing_number = (TYPEOF(h.head_office_routing_number))'',0,100));
    maxlength_head_office_routing_number := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.head_office_routing_number)));
    avelength_head_office_routing_number := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.head_office_routing_number)),h.head_office_routing_number<>(typeof(h.head_office_routing_number))'');
    populated_phone_number_area_code_cnt := COUNT(GROUP,h.phone_number_area_code <> (TYPEOF(h.phone_number_area_code))'');
    populated_phone_number_area_code_pcnt := AVE(GROUP,IF(h.phone_number_area_code = (TYPEOF(h.phone_number_area_code))'',0,100));
    maxlength_phone_number_area_code := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.phone_number_area_code)));
    avelength_phone_number_area_code := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.phone_number_area_code)),h.phone_number_area_code<>(typeof(h.phone_number_area_code))'');
    populated_phone_number_cnt := COUNT(GROUP,h.phone_number <> (TYPEOF(h.phone_number))'');
    populated_phone_number_pcnt := AVE(GROUP,IF(h.phone_number = (TYPEOF(h.phone_number))'',0,100));
    maxlength_phone_number := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.phone_number)));
    avelength_phone_number := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.phone_number)),h.phone_number<>(typeof(h.phone_number))'');
    populated_phone_number_extension_cnt := COUNT(GROUP,h.phone_number_extension <> (TYPEOF(h.phone_number_extension))'');
    populated_phone_number_extension_pcnt := AVE(GROUP,IF(h.phone_number_extension = (TYPEOF(h.phone_number_extension))'',0,100));
    maxlength_phone_number_extension := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.phone_number_extension)));
    avelength_phone_number_extension := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.phone_number_extension)),h.phone_number_extension<>(typeof(h.phone_number_extension))'');
    populated_fax_area_code_cnt := COUNT(GROUP,h.fax_area_code <> (TYPEOF(h.fax_area_code))'');
    populated_fax_area_code_pcnt := AVE(GROUP,IF(h.fax_area_code = (TYPEOF(h.fax_area_code))'',0,100));
    maxlength_fax_area_code := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.fax_area_code)));
    avelength_fax_area_code := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.fax_area_code)),h.fax_area_code<>(typeof(h.fax_area_code))'');
    populated_fax_number_cnt := COUNT(GROUP,h.fax_number <> (TYPEOF(h.fax_number))'');
    populated_fax_number_pcnt := AVE(GROUP,IF(h.fax_number = (TYPEOF(h.fax_number))'',0,100));
    maxlength_fax_number := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.fax_number)));
    avelength_fax_number := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.fax_number)),h.fax_number<>(typeof(h.fax_number))'');
    populated_fax_extension_cnt := COUNT(GROUP,h.fax_extension <> (TYPEOF(h.fax_extension))'');
    populated_fax_extension_pcnt := AVE(GROUP,IF(h.fax_extension = (TYPEOF(h.fax_extension))'',0,100));
    maxlength_fax_extension := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.fax_extension)));
    avelength_fax_extension := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.fax_extension)),h.fax_extension<>(typeof(h.fax_extension))'');
    populated_head_office_asset_size_cnt := COUNT(GROUP,h.head_office_asset_size <> (TYPEOF(h.head_office_asset_size))'');
    populated_head_office_asset_size_pcnt := AVE(GROUP,IF(h.head_office_asset_size = (TYPEOF(h.head_office_asset_size))'',0,100));
    maxlength_head_office_asset_size := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.head_office_asset_size)));
    avelength_head_office_asset_size := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.head_office_asset_size)),h.head_office_asset_size<>(typeof(h.head_office_asset_size))'');
    populated_federal_reserve_district_code_cnt := COUNT(GROUP,h.federal_reserve_district_code <> (TYPEOF(h.federal_reserve_district_code))'');
    populated_federal_reserve_district_code_pcnt := AVE(GROUP,IF(h.federal_reserve_district_code = (TYPEOF(h.federal_reserve_district_code))'',0,100));
    maxlength_federal_reserve_district_code := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.federal_reserve_district_code)));
    avelength_federal_reserve_district_code := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.federal_reserve_district_code)),h.federal_reserve_district_code<>(typeof(h.federal_reserve_district_code))'');
    populated_year_2000_date_last_updated_cnt := COUNT(GROUP,h.year_2000_date_last_updated <> (TYPEOF(h.year_2000_date_last_updated))'');
    populated_year_2000_date_last_updated_pcnt := AVE(GROUP,IF(h.year_2000_date_last_updated = (TYPEOF(h.year_2000_date_last_updated))'',0,100));
    maxlength_year_2000_date_last_updated := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.year_2000_date_last_updated)));
    avelength_year_2000_date_last_updated := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.year_2000_date_last_updated)),h.year_2000_date_last_updated<>(typeof(h.year_2000_date_last_updated))'');
    populated_head_office_file_key_cnt := COUNT(GROUP,h.head_office_file_key <> (TYPEOF(h.head_office_file_key))'');
    populated_head_office_file_key_pcnt := AVE(GROUP,IF(h.head_office_file_key = (TYPEOF(h.head_office_file_key))'',0,100));
    maxlength_head_office_file_key := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.head_office_file_key)));
    avelength_head_office_file_key := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.head_office_file_key)),h.head_office_file_key<>(typeof(h.head_office_file_key))'');
    populated_routing_number_type_cnt := COUNT(GROUP,h.routing_number_type <> (TYPEOF(h.routing_number_type))'');
    populated_routing_number_type_pcnt := AVE(GROUP,IF(h.routing_number_type = (TYPEOF(h.routing_number_type))'',0,100));
    maxlength_routing_number_type := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.routing_number_type)));
    avelength_routing_number_type := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.routing_number_type)),h.routing_number_type<>(typeof(h.routing_number_type))'');
    populated_routing_number_status_cnt := COUNT(GROUP,h.routing_number_status <> (TYPEOF(h.routing_number_status))'');
    populated_routing_number_status_pcnt := AVE(GROUP,IF(h.routing_number_status = (TYPEOF(h.routing_number_status))'',0,100));
    maxlength_routing_number_status := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.routing_number_status)));
    avelength_routing_number_status := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.routing_number_status)),h.routing_number_status<>(typeof(h.routing_number_status))'');
    populated_employer_tax_id_cnt := COUNT(GROUP,h.employer_tax_id <> (TYPEOF(h.employer_tax_id))'');
    populated_employer_tax_id_pcnt := AVE(GROUP,IF(h.employer_tax_id = (TYPEOF(h.employer_tax_id))'',0,100));
    maxlength_employer_tax_id := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.employer_tax_id)));
    avelength_employer_tax_id := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.employer_tax_id)),h.employer_tax_id<>(typeof(h.employer_tax_id))'');
    populated_institution_identifier_cnt := COUNT(GROUP,h.institution_identifier <> (TYPEOF(h.institution_identifier))'');
    populated_institution_identifier_pcnt := AVE(GROUP,IF(h.institution_identifier = (TYPEOF(h.institution_identifier))'',0,100));
    maxlength_institution_identifier := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.institution_identifier)));
    avelength_institution_identifier := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.institution_identifier)),h.institution_identifier<>(typeof(h.institution_identifier))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_file_key_pcnt *   0.00 / 100 + T.Populated_dt_first_seen_pcnt *   0.00 / 100 + T.Populated_dt_last_seen_pcnt *   0.00 / 100 + T.Populated_dt_vendor_first_reported_pcnt *   0.00 / 100 + T.Populated_dt_vendor_last_reported_pcnt *   0.00 / 100 + T.Populated_date_updated_pcnt *   0.00 / 100 + T.Populated_type_instituon_code_pcnt *   0.00 / 100 + T.Populated_head_office_branch_codes_pcnt *   0.00 / 100 + T.Populated_routing_number_micr_pcnt *   0.00 / 100 + T.Populated_routing_number_fractional_pcnt *   0.00 / 100 + T.Populated_institution_name_full_pcnt *   0.00 / 100 + T.Populated_institution_name_abbreviated_pcnt *   0.00 / 100 + T.Populated_street_address_pcnt *   0.00 / 100 + T.Populated_city_town_pcnt *   0.00 / 100 + T.Populated_state_pcnt *   0.00 / 100 + T.Populated_zip_code_pcnt *   0.00 / 100 + T.Populated_zip_4_pcnt *   0.00 / 100 + T.Populated_mail_address_pcnt *   0.00 / 100 + T.Populated_mail_city_town_pcnt *   0.00 / 100 + T.Populated_mail_state_pcnt *   0.00 / 100 + T.Populated_mail_zip_code_pcnt *   0.00 / 100 + T.Populated_mail_zip_4_pcnt *   0.00 / 100 + T.Populated_branch_office_name_pcnt *   0.00 / 100 + T.Populated_head_office_routing_number_pcnt *   0.00 / 100 + T.Populated_phone_number_area_code_pcnt *   0.00 / 100 + T.Populated_phone_number_pcnt *   0.00 / 100 + T.Populated_phone_number_extension_pcnt *   0.00 / 100 + T.Populated_fax_area_code_pcnt *   0.00 / 100 + T.Populated_fax_number_pcnt *   0.00 / 100 + T.Populated_fax_extension_pcnt *   0.00 / 100 + T.Populated_head_office_asset_size_pcnt *   0.00 / 100 + T.Populated_federal_reserve_district_code_pcnt *   0.00 / 100 + T.Populated_year_2000_date_last_updated_pcnt *   0.00 / 100 + T.Populated_head_office_file_key_pcnt *   0.00 / 100 + T.Populated_routing_number_type_pcnt *   0.00 / 100 + T.Populated_routing_number_status_pcnt *   0.00 / 100 + T.Populated_employer_tax_id_pcnt *   0.00 / 100 + T.Populated_institution_identifier_pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;
 
summary0 := Summary('Summary');
  invRec := RECORD
  UNSIGNED  FldNo;
  SALT38.StrType FieldName;
  UNSIGNED NumberOfRecords;
  REAL8  populated_pcnt;
  UNSIGNED  maxlength;
  REAL8  avelength;
END;
invRec invert(summary0 le, INTEGER C) := TRANSFORM
  SELF.FldNo := C;
  SELF.NumberOfRecords := le.NumberOfRecords;
  SELF.FieldName := CHOOSE(C,'file_key','dt_first_seen','dt_last_seen','dt_vendor_first_reported','dt_vendor_last_reported','date_updated','type_instituon_code','head_office_branch_codes','routing_number_micr','routing_number_fractional','institution_name_full','institution_name_abbreviated','street_address','city_town','state','zip_code','zip_4','mail_address','mail_city_town','mail_state','mail_zip_code','mail_zip_4','branch_office_name','head_office_routing_number','phone_number_area_code','phone_number','phone_number_extension','fax_area_code','fax_number','fax_extension','head_office_asset_size','federal_reserve_district_code','year_2000_date_last_updated','head_office_file_key','routing_number_type','routing_number_status','employer_tax_id','institution_identifier');
  SELF.populated_pcnt := CHOOSE(C,le.populated_file_key_pcnt,le.populated_dt_first_seen_pcnt,le.populated_dt_last_seen_pcnt,le.populated_dt_vendor_first_reported_pcnt,le.populated_dt_vendor_last_reported_pcnt,le.populated_date_updated_pcnt,le.populated_type_instituon_code_pcnt,le.populated_head_office_branch_codes_pcnt,le.populated_routing_number_micr_pcnt,le.populated_routing_number_fractional_pcnt,le.populated_institution_name_full_pcnt,le.populated_institution_name_abbreviated_pcnt,le.populated_street_address_pcnt,le.populated_city_town_pcnt,le.populated_state_pcnt,le.populated_zip_code_pcnt,le.populated_zip_4_pcnt,le.populated_mail_address_pcnt,le.populated_mail_city_town_pcnt,le.populated_mail_state_pcnt,le.populated_mail_zip_code_pcnt,le.populated_mail_zip_4_pcnt,le.populated_branch_office_name_pcnt,le.populated_head_office_routing_number_pcnt,le.populated_phone_number_area_code_pcnt,le.populated_phone_number_pcnt,le.populated_phone_number_extension_pcnt,le.populated_fax_area_code_pcnt,le.populated_fax_number_pcnt,le.populated_fax_extension_pcnt,le.populated_head_office_asset_size_pcnt,le.populated_federal_reserve_district_code_pcnt,le.populated_year_2000_date_last_updated_pcnt,le.populated_head_office_file_key_pcnt,le.populated_routing_number_type_pcnt,le.populated_routing_number_status_pcnt,le.populated_employer_tax_id_pcnt,le.populated_institution_identifier_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_file_key,le.maxlength_dt_first_seen,le.maxlength_dt_last_seen,le.maxlength_dt_vendor_first_reported,le.maxlength_dt_vendor_last_reported,le.maxlength_date_updated,le.maxlength_type_instituon_code,le.maxlength_head_office_branch_codes,le.maxlength_routing_number_micr,le.maxlength_routing_number_fractional,le.maxlength_institution_name_full,le.maxlength_institution_name_abbreviated,le.maxlength_street_address,le.maxlength_city_town,le.maxlength_state,le.maxlength_zip_code,le.maxlength_zip_4,le.maxlength_mail_address,le.maxlength_mail_city_town,le.maxlength_mail_state,le.maxlength_mail_zip_code,le.maxlength_mail_zip_4,le.maxlength_branch_office_name,le.maxlength_head_office_routing_number,le.maxlength_phone_number_area_code,le.maxlength_phone_number,le.maxlength_phone_number_extension,le.maxlength_fax_area_code,le.maxlength_fax_number,le.maxlength_fax_extension,le.maxlength_head_office_asset_size,le.maxlength_federal_reserve_district_code,le.maxlength_year_2000_date_last_updated,le.maxlength_head_office_file_key,le.maxlength_routing_number_type,le.maxlength_routing_number_status,le.maxlength_employer_tax_id,le.maxlength_institution_identifier);
  SELF.avelength := CHOOSE(C,le.avelength_file_key,le.avelength_dt_first_seen,le.avelength_dt_last_seen,le.avelength_dt_vendor_first_reported,le.avelength_dt_vendor_last_reported,le.avelength_date_updated,le.avelength_type_instituon_code,le.avelength_head_office_branch_codes,le.avelength_routing_number_micr,le.avelength_routing_number_fractional,le.avelength_institution_name_full,le.avelength_institution_name_abbreviated,le.avelength_street_address,le.avelength_city_town,le.avelength_state,le.avelength_zip_code,le.avelength_zip_4,le.avelength_mail_address,le.avelength_mail_city_town,le.avelength_mail_state,le.avelength_mail_zip_code,le.avelength_mail_zip_4,le.avelength_branch_office_name,le.avelength_head_office_routing_number,le.avelength_phone_number_area_code,le.avelength_phone_number,le.avelength_phone_number_extension,le.avelength_fax_area_code,le.avelength_fax_number,le.avelength_fax_extension,le.avelength_head_office_asset_size,le.avelength_federal_reserve_district_code,le.avelength_year_2000_date_last_updated,le.avelength_head_office_file_key,le.avelength_routing_number_type,le.avelength_routing_number_status,le.avelength_employer_tax_id,le.avelength_institution_identifier);
END;
EXPORT invSummary := NORMALIZE(summary0, 38, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT38.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT38.StrType)le.file_key),IF (le.dt_first_seen <> 0,TRIM((SALT38.StrType)le.dt_first_seen), ''),IF (le.dt_last_seen <> 0,TRIM((SALT38.StrType)le.dt_last_seen), ''),IF (le.dt_vendor_first_reported <> 0,TRIM((SALT38.StrType)le.dt_vendor_first_reported), ''),IF (le.dt_vendor_last_reported <> 0,TRIM((SALT38.StrType)le.dt_vendor_last_reported), ''),TRIM((SALT38.StrType)le.date_updated),TRIM((SALT38.StrType)le.type_instituon_code),TRIM((SALT38.StrType)le.head_office_branch_codes),TRIM((SALT38.StrType)le.routing_number_micr),TRIM((SALT38.StrType)le.routing_number_fractional),TRIM((SALT38.StrType)le.institution_name_full),TRIM((SALT38.StrType)le.institution_name_abbreviated),TRIM((SALT38.StrType)le.street_address),TRIM((SALT38.StrType)le.city_town),TRIM((SALT38.StrType)le.state),TRIM((SALT38.StrType)le.zip_code),TRIM((SALT38.StrType)le.zip_4),TRIM((SALT38.StrType)le.mail_address),TRIM((SALT38.StrType)le.mail_city_town),TRIM((SALT38.StrType)le.mail_state),TRIM((SALT38.StrType)le.mail_zip_code),TRIM((SALT38.StrType)le.mail_zip_4),TRIM((SALT38.StrType)le.branch_office_name),TRIM((SALT38.StrType)le.head_office_routing_number),TRIM((SALT38.StrType)le.phone_number_area_code),TRIM((SALT38.StrType)le.phone_number),TRIM((SALT38.StrType)le.phone_number_extension),TRIM((SALT38.StrType)le.fax_area_code),TRIM((SALT38.StrType)le.fax_number),TRIM((SALT38.StrType)le.fax_extension),TRIM((SALT38.StrType)le.head_office_asset_size),TRIM((SALT38.StrType)le.federal_reserve_district_code),TRIM((SALT38.StrType)le.year_2000_date_last_updated),TRIM((SALT38.StrType)le.head_office_file_key),TRIM((SALT38.StrType)le.routing_number_type),TRIM((SALT38.StrType)le.routing_number_status),TRIM((SALT38.StrType)le.employer_tax_id),TRIM((SALT38.StrType)le.institution_identifier)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,38,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT38.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 38);
  SELF.FldNo2 := 1 + (C % 38);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT38.StrType)le.file_key),IF (le.dt_first_seen <> 0,TRIM((SALT38.StrType)le.dt_first_seen), ''),IF (le.dt_last_seen <> 0,TRIM((SALT38.StrType)le.dt_last_seen), ''),IF (le.dt_vendor_first_reported <> 0,TRIM((SALT38.StrType)le.dt_vendor_first_reported), ''),IF (le.dt_vendor_last_reported <> 0,TRIM((SALT38.StrType)le.dt_vendor_last_reported), ''),TRIM((SALT38.StrType)le.date_updated),TRIM((SALT38.StrType)le.type_instituon_code),TRIM((SALT38.StrType)le.head_office_branch_codes),TRIM((SALT38.StrType)le.routing_number_micr),TRIM((SALT38.StrType)le.routing_number_fractional),TRIM((SALT38.StrType)le.institution_name_full),TRIM((SALT38.StrType)le.institution_name_abbreviated),TRIM((SALT38.StrType)le.street_address),TRIM((SALT38.StrType)le.city_town),TRIM((SALT38.StrType)le.state),TRIM((SALT38.StrType)le.zip_code),TRIM((SALT38.StrType)le.zip_4),TRIM((SALT38.StrType)le.mail_address),TRIM((SALT38.StrType)le.mail_city_town),TRIM((SALT38.StrType)le.mail_state),TRIM((SALT38.StrType)le.mail_zip_code),TRIM((SALT38.StrType)le.mail_zip_4),TRIM((SALT38.StrType)le.branch_office_name),TRIM((SALT38.StrType)le.head_office_routing_number),TRIM((SALT38.StrType)le.phone_number_area_code),TRIM((SALT38.StrType)le.phone_number),TRIM((SALT38.StrType)le.phone_number_extension),TRIM((SALT38.StrType)le.fax_area_code),TRIM((SALT38.StrType)le.fax_number),TRIM((SALT38.StrType)le.fax_extension),TRIM((SALT38.StrType)le.head_office_asset_size),TRIM((SALT38.StrType)le.federal_reserve_district_code),TRIM((SALT38.StrType)le.year_2000_date_last_updated),TRIM((SALT38.StrType)le.head_office_file_key),TRIM((SALT38.StrType)le.routing_number_type),TRIM((SALT38.StrType)le.routing_number_status),TRIM((SALT38.StrType)le.employer_tax_id),TRIM((SALT38.StrType)le.institution_identifier)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT38.StrType)le.file_key),IF (le.dt_first_seen <> 0,TRIM((SALT38.StrType)le.dt_first_seen), ''),IF (le.dt_last_seen <> 0,TRIM((SALT38.StrType)le.dt_last_seen), ''),IF (le.dt_vendor_first_reported <> 0,TRIM((SALT38.StrType)le.dt_vendor_first_reported), ''),IF (le.dt_vendor_last_reported <> 0,TRIM((SALT38.StrType)le.dt_vendor_last_reported), ''),TRIM((SALT38.StrType)le.date_updated),TRIM((SALT38.StrType)le.type_instituon_code),TRIM((SALT38.StrType)le.head_office_branch_codes),TRIM((SALT38.StrType)le.routing_number_micr),TRIM((SALT38.StrType)le.routing_number_fractional),TRIM((SALT38.StrType)le.institution_name_full),TRIM((SALT38.StrType)le.institution_name_abbreviated),TRIM((SALT38.StrType)le.street_address),TRIM((SALT38.StrType)le.city_town),TRIM((SALT38.StrType)le.state),TRIM((SALT38.StrType)le.zip_code),TRIM((SALT38.StrType)le.zip_4),TRIM((SALT38.StrType)le.mail_address),TRIM((SALT38.StrType)le.mail_city_town),TRIM((SALT38.StrType)le.mail_state),TRIM((SALT38.StrType)le.mail_zip_code),TRIM((SALT38.StrType)le.mail_zip_4),TRIM((SALT38.StrType)le.branch_office_name),TRIM((SALT38.StrType)le.head_office_routing_number),TRIM((SALT38.StrType)le.phone_number_area_code),TRIM((SALT38.StrType)le.phone_number),TRIM((SALT38.StrType)le.phone_number_extension),TRIM((SALT38.StrType)le.fax_area_code),TRIM((SALT38.StrType)le.fax_number),TRIM((SALT38.StrType)le.fax_extension),TRIM((SALT38.StrType)le.head_office_asset_size),TRIM((SALT38.StrType)le.federal_reserve_district_code),TRIM((SALT38.StrType)le.year_2000_date_last_updated),TRIM((SALT38.StrType)le.head_office_file_key),TRIM((SALT38.StrType)le.routing_number_type),TRIM((SALT38.StrType)le.routing_number_status),TRIM((SALT38.StrType)le.employer_tax_id),TRIM((SALT38.StrType)le.institution_identifier)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),38*38,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'file_key'}
      ,{2,'dt_first_seen'}
      ,{3,'dt_last_seen'}
      ,{4,'dt_vendor_first_reported'}
      ,{5,'dt_vendor_last_reported'}
      ,{6,'date_updated'}
      ,{7,'type_instituon_code'}
      ,{8,'head_office_branch_codes'}
      ,{9,'routing_number_micr'}
      ,{10,'routing_number_fractional'}
      ,{11,'institution_name_full'}
      ,{12,'institution_name_abbreviated'}
      ,{13,'street_address'}
      ,{14,'city_town'}
      ,{15,'state'}
      ,{16,'zip_code'}
      ,{17,'zip_4'}
      ,{18,'mail_address'}
      ,{19,'mail_city_town'}
      ,{20,'mail_state'}
      ,{21,'mail_zip_code'}
      ,{22,'mail_zip_4'}
      ,{23,'branch_office_name'}
      ,{24,'head_office_routing_number'}
      ,{25,'phone_number_area_code'}
      ,{26,'phone_number'}
      ,{27,'phone_number_extension'}
      ,{28,'fax_area_code'}
      ,{29,'fax_number'}
      ,{30,'fax_extension'}
      ,{31,'head_office_asset_size'}
      ,{32,'federal_reserve_district_code'}
      ,{33,'year_2000_date_last_updated'}
      ,{34,'head_office_file_key'}
      ,{35,'routing_number_type'}
      ,{36,'routing_number_status'}
      ,{37,'employer_tax_id'}
      ,{38,'institution_identifier'}],SALT38.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT38.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT38.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT38.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Fields.InValid_file_key((SALT38.StrType)le.file_key),
    Fields.InValid_dt_first_seen((SALT38.StrType)le.dt_first_seen),
    Fields.InValid_dt_last_seen((SALT38.StrType)le.dt_last_seen),
    Fields.InValid_dt_vendor_first_reported((SALT38.StrType)le.dt_vendor_first_reported),
    Fields.InValid_dt_vendor_last_reported((SALT38.StrType)le.dt_vendor_last_reported),
    Fields.InValid_date_updated((SALT38.StrType)le.date_updated),
    Fields.InValid_type_instituon_code((SALT38.StrType)le.type_instituon_code),
    Fields.InValid_head_office_branch_codes((SALT38.StrType)le.head_office_branch_codes),
    Fields.InValid_routing_number_micr((SALT38.StrType)le.routing_number_micr),
    Fields.InValid_routing_number_fractional((SALT38.StrType)le.routing_number_fractional),
    Fields.InValid_institution_name_full((SALT38.StrType)le.institution_name_full),
    Fields.InValid_institution_name_abbreviated((SALT38.StrType)le.institution_name_abbreviated),
    Fields.InValid_street_address((SALT38.StrType)le.street_address),
    Fields.InValid_city_town((SALT38.StrType)le.city_town),
    Fields.InValid_state((SALT38.StrType)le.state),
    Fields.InValid_zip_code((SALT38.StrType)le.zip_code),
    Fields.InValid_zip_4((SALT38.StrType)le.zip_4),
    Fields.InValid_mail_address((SALT38.StrType)le.mail_address),
    Fields.InValid_mail_city_town((SALT38.StrType)le.mail_city_town),
    Fields.InValid_mail_state((SALT38.StrType)le.mail_state),
    Fields.InValid_mail_zip_code((SALT38.StrType)le.mail_zip_code),
    Fields.InValid_mail_zip_4((SALT38.StrType)le.mail_zip_4),
    Fields.InValid_branch_office_name((SALT38.StrType)le.branch_office_name),
    Fields.InValid_head_office_routing_number((SALT38.StrType)le.head_office_routing_number),
    Fields.InValid_phone_number_area_code((SALT38.StrType)le.phone_number_area_code),
    Fields.InValid_phone_number((SALT38.StrType)le.phone_number),
    Fields.InValid_phone_number_extension((SALT38.StrType)le.phone_number_extension),
    Fields.InValid_fax_area_code((SALT38.StrType)le.fax_area_code),
    Fields.InValid_fax_number((SALT38.StrType)le.fax_number),
    Fields.InValid_fax_extension((SALT38.StrType)le.fax_extension),
    Fields.InValid_head_office_asset_size((SALT38.StrType)le.head_office_asset_size),
    Fields.InValid_federal_reserve_district_code((SALT38.StrType)le.federal_reserve_district_code),
    Fields.InValid_year_2000_date_last_updated((SALT38.StrType)le.year_2000_date_last_updated),
    Fields.InValid_head_office_file_key((SALT38.StrType)le.head_office_file_key),
    Fields.InValid_routing_number_type((SALT38.StrType)le.routing_number_type),
    Fields.InValid_routing_number_status((SALT38.StrType)le.routing_number_status),
    Fields.InValid_employer_tax_id((SALT38.StrType)le.employer_tax_id),
    Fields.InValid_institution_identifier((SALT38.StrType)le.institution_identifier),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,38,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'NUMBER','DEFAULT','DEFAULT','DEFAULT','DEFAULT','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','UPPERNAME','UPPERNAME','STREET_ADDR','CITY','ST','ZIP5','HASZIP4','STREET_ADDR','CITY','ST','ZIP5','HASZIP4','UPPERNAME','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','DEFAULT','NUMBER','NUMBER','UPPERNAME','ALPHA','NUMBER','NUMBER');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_file_key(TotalErrors.ErrorNum),Fields.InValidMessage_dt_first_seen(TotalErrors.ErrorNum),Fields.InValidMessage_dt_last_seen(TotalErrors.ErrorNum),Fields.InValidMessage_dt_vendor_first_reported(TotalErrors.ErrorNum),Fields.InValidMessage_dt_vendor_last_reported(TotalErrors.ErrorNum),Fields.InValidMessage_date_updated(TotalErrors.ErrorNum),Fields.InValidMessage_type_instituon_code(TotalErrors.ErrorNum),Fields.InValidMessage_head_office_branch_codes(TotalErrors.ErrorNum),Fields.InValidMessage_routing_number_micr(TotalErrors.ErrorNum),Fields.InValidMessage_routing_number_fractional(TotalErrors.ErrorNum),Fields.InValidMessage_institution_name_full(TotalErrors.ErrorNum),Fields.InValidMessage_institution_name_abbreviated(TotalErrors.ErrorNum),Fields.InValidMessage_street_address(TotalErrors.ErrorNum),Fields.InValidMessage_city_town(TotalErrors.ErrorNum),Fields.InValidMessage_state(TotalErrors.ErrorNum),Fields.InValidMessage_zip_code(TotalErrors.ErrorNum),Fields.InValidMessage_zip_4(TotalErrors.ErrorNum),Fields.InValidMessage_mail_address(TotalErrors.ErrorNum),Fields.InValidMessage_mail_city_town(TotalErrors.ErrorNum),Fields.InValidMessage_mail_state(TotalErrors.ErrorNum),Fields.InValidMessage_mail_zip_code(TotalErrors.ErrorNum),Fields.InValidMessage_mail_zip_4(TotalErrors.ErrorNum),Fields.InValidMessage_branch_office_name(TotalErrors.ErrorNum),Fields.InValidMessage_head_office_routing_number(TotalErrors.ErrorNum),Fields.InValidMessage_phone_number_area_code(TotalErrors.ErrorNum),Fields.InValidMessage_phone_number(TotalErrors.ErrorNum),Fields.InValidMessage_phone_number_extension(TotalErrors.ErrorNum),Fields.InValidMessage_fax_area_code(TotalErrors.ErrorNum),Fields.InValidMessage_fax_number(TotalErrors.ErrorNum),Fields.InValidMessage_fax_extension(TotalErrors.ErrorNum),Fields.InValidMessage_head_office_asset_size(TotalErrors.ErrorNum),Fields.InValidMessage_federal_reserve_district_code(TotalErrors.ErrorNum),Fields.InValidMessage_year_2000_date_last_updated(TotalErrors.ErrorNum),Fields.InValidMessage_head_office_file_key(TotalErrors.ErrorNum),Fields.InValidMessage_routing_number_type(TotalErrors.ErrorNum),Fields.InValidMessage_routing_number_status(TotalErrors.ErrorNum),Fields.InValidMessage_employer_tax_id(TotalErrors.ErrorNum),Fields.InValidMessage_institution_identifier(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT38.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT38.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(scrubs_bank_routing, Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT38.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT38.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;
