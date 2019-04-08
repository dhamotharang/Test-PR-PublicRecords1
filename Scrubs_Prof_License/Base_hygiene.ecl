IMPORT SALT37;
EXPORT Base_hygiene(dataset(Base_layout_Prof_License) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT37.Str30Type txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_prolic_key_pcnt := AVE(GROUP,IF(h.prolic_key = (TYPEOF(h.prolic_key))'',0,100));
    maxlength_prolic_key := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.prolic_key)));
    avelength_prolic_key := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.prolic_key)),h.prolic_key<>(typeof(h.prolic_key))'');
    populated_date_first_seen_pcnt := AVE(GROUP,IF(h.date_first_seen = (TYPEOF(h.date_first_seen))'',0,100));
    maxlength_date_first_seen := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.date_first_seen)));
    avelength_date_first_seen := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.date_first_seen)),h.date_first_seen<>(typeof(h.date_first_seen))'');
    populated_date_last_seen_pcnt := AVE(GROUP,IF(h.date_last_seen = (TYPEOF(h.date_last_seen))'',0,100));
    maxlength_date_last_seen := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.date_last_seen)));
    avelength_date_last_seen := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.date_last_seen)),h.date_last_seen<>(typeof(h.date_last_seen))'');
    populated_profession_or_board_pcnt := AVE(GROUP,IF(h.profession_or_board = (TYPEOF(h.profession_or_board))'',0,100));
    maxlength_profession_or_board := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.profession_or_board)));
    avelength_profession_or_board := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.profession_or_board)),h.profession_or_board<>(typeof(h.profession_or_board))'');
    populated_license_type_pcnt := AVE(GROUP,IF(h.license_type = (TYPEOF(h.license_type))'',0,100));
    maxlength_license_type := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.license_type)));
    avelength_license_type := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.license_type)),h.license_type<>(typeof(h.license_type))'');
    populated_status_pcnt := AVE(GROUP,IF(h.status = (TYPEOF(h.status))'',0,100));
    maxlength_status := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.status)));
    avelength_status := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.status)),h.status<>(typeof(h.status))'');
    populated_orig_license_number_pcnt := AVE(GROUP,IF(h.orig_license_number = (TYPEOF(h.orig_license_number))'',0,100));
    maxlength_orig_license_number := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.orig_license_number)));
    avelength_orig_license_number := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.orig_license_number)),h.orig_license_number<>(typeof(h.orig_license_number))'');
    populated_license_number_pcnt := AVE(GROUP,IF(h.license_number = (TYPEOF(h.license_number))'',0,100));
    maxlength_license_number := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.license_number)));
    avelength_license_number := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.license_number)),h.license_number<>(typeof(h.license_number))'');
    populated_previous_license_number_pcnt := AVE(GROUP,IF(h.previous_license_number = (TYPEOF(h.previous_license_number))'',0,100));
    maxlength_previous_license_number := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.previous_license_number)));
    avelength_previous_license_number := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.previous_license_number)),h.previous_license_number<>(typeof(h.previous_license_number))'');
    populated_previous_license_type_pcnt := AVE(GROUP,IF(h.previous_license_type = (TYPEOF(h.previous_license_type))'',0,100));
    maxlength_previous_license_type := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.previous_license_type)));
    avelength_previous_license_type := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.previous_license_type)),h.previous_license_type<>(typeof(h.previous_license_type))'');
    populated_company_name_pcnt := AVE(GROUP,IF(h.company_name = (TYPEOF(h.company_name))'',0,100));
    maxlength_company_name := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.company_name)));
    avelength_company_name := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.company_name)),h.company_name<>(typeof(h.company_name))'');
    populated_orig_name_pcnt := AVE(GROUP,IF(h.orig_name = (TYPEOF(h.orig_name))'',0,100));
    maxlength_orig_name := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.orig_name)));
    avelength_orig_name := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.orig_name)),h.orig_name<>(typeof(h.orig_name))'');
    populated_name_order_pcnt := AVE(GROUP,IF(h.name_order = (TYPEOF(h.name_order))'',0,100));
    maxlength_name_order := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.name_order)));
    avelength_name_order := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.name_order)),h.name_order<>(typeof(h.name_order))'');
    populated_orig_former_name_pcnt := AVE(GROUP,IF(h.orig_former_name = (TYPEOF(h.orig_former_name))'',0,100));
    maxlength_orig_former_name := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.orig_former_name)));
    avelength_orig_former_name := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.orig_former_name)),h.orig_former_name<>(typeof(h.orig_former_name))'');
    populated_former_name_order_pcnt := AVE(GROUP,IF(h.former_name_order = (TYPEOF(h.former_name_order))'',0,100));
    maxlength_former_name_order := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.former_name_order)));
    avelength_former_name_order := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.former_name_order)),h.former_name_order<>(typeof(h.former_name_order))'');
    populated_orig_addr_1_pcnt := AVE(GROUP,IF(h.orig_addr_1 = (TYPEOF(h.orig_addr_1))'',0,100));
    maxlength_orig_addr_1 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.orig_addr_1)));
    avelength_orig_addr_1 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.orig_addr_1)),h.orig_addr_1<>(typeof(h.orig_addr_1))'');
    populated_orig_addr_2_pcnt := AVE(GROUP,IF(h.orig_addr_2 = (TYPEOF(h.orig_addr_2))'',0,100));
    maxlength_orig_addr_2 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.orig_addr_2)));
    avelength_orig_addr_2 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.orig_addr_2)),h.orig_addr_2<>(typeof(h.orig_addr_2))'');
    populated_orig_addr_3_pcnt := AVE(GROUP,IF(h.orig_addr_3 = (TYPEOF(h.orig_addr_3))'',0,100));
    maxlength_orig_addr_3 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.orig_addr_3)));
    avelength_orig_addr_3 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.orig_addr_3)),h.orig_addr_3<>(typeof(h.orig_addr_3))'');
    populated_orig_addr_4_pcnt := AVE(GROUP,IF(h.orig_addr_4 = (TYPEOF(h.orig_addr_4))'',0,100));
    maxlength_orig_addr_4 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.orig_addr_4)));
    avelength_orig_addr_4 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.orig_addr_4)),h.orig_addr_4<>(typeof(h.orig_addr_4))'');
    populated_orig_city_pcnt := AVE(GROUP,IF(h.orig_city = (TYPEOF(h.orig_city))'',0,100));
    maxlength_orig_city := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.orig_city)));
    avelength_orig_city := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.orig_city)),h.orig_city<>(typeof(h.orig_city))'');
    populated_orig_st_pcnt := AVE(GROUP,IF(h.orig_st = (TYPEOF(h.orig_st))'',0,100));
    maxlength_orig_st := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.orig_st)));
    avelength_orig_st := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.orig_st)),h.orig_st<>(typeof(h.orig_st))'');
    populated_orig_zip_pcnt := AVE(GROUP,IF(h.orig_zip = (TYPEOF(h.orig_zip))'',0,100));
    maxlength_orig_zip := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.orig_zip)));
    avelength_orig_zip := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.orig_zip)),h.orig_zip<>(typeof(h.orig_zip))'');
    populated_county_str_pcnt := AVE(GROUP,IF(h.county_str = (TYPEOF(h.county_str))'',0,100));
    maxlength_county_str := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.county_str)));
    avelength_county_str := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.county_str)),h.county_str<>(typeof(h.county_str))'');
    populated_country_str_pcnt := AVE(GROUP,IF(h.country_str = (TYPEOF(h.country_str))'',0,100));
    maxlength_country_str := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.country_str)));
    avelength_country_str := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.country_str)),h.country_str<>(typeof(h.country_str))'');
    populated_business_flag_pcnt := AVE(GROUP,IF(h.business_flag = (TYPEOF(h.business_flag))'',0,100));
    maxlength_business_flag := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.business_flag)));
    avelength_business_flag := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.business_flag)),h.business_flag<>(typeof(h.business_flag))'');
    populated_phone_pcnt := AVE(GROUP,IF(h.phone = (TYPEOF(h.phone))'',0,100));
    maxlength_phone := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.phone)));
    avelength_phone := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.phone)),h.phone<>(typeof(h.phone))'');
    populated_sex_pcnt := AVE(GROUP,IF(h.sex = (TYPEOF(h.sex))'',0,100));
    maxlength_sex := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.sex)));
    avelength_sex := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.sex)),h.sex<>(typeof(h.sex))'');
    populated_dob_pcnt := AVE(GROUP,IF(h.dob = (TYPEOF(h.dob))'',0,100));
    maxlength_dob := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.dob)));
    avelength_dob := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.dob)),h.dob<>(typeof(h.dob))'');
    populated_issue_date_pcnt := AVE(GROUP,IF(h.issue_date = (TYPEOF(h.issue_date))'',0,100));
    maxlength_issue_date := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.issue_date)));
    avelength_issue_date := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.issue_date)),h.issue_date<>(typeof(h.issue_date))'');
    populated_expiration_date_pcnt := AVE(GROUP,IF(h.expiration_date = (TYPEOF(h.expiration_date))'',0,100));
    maxlength_expiration_date := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.expiration_date)));
    avelength_expiration_date := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.expiration_date)),h.expiration_date<>(typeof(h.expiration_date))'');
    populated_last_renewal_date_pcnt := AVE(GROUP,IF(h.last_renewal_date = (TYPEOF(h.last_renewal_date))'',0,100));
    maxlength_last_renewal_date := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.last_renewal_date)));
    avelength_last_renewal_date := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.last_renewal_date)),h.last_renewal_date<>(typeof(h.last_renewal_date))'');
    populated_license_obtained_by_pcnt := AVE(GROUP,IF(h.license_obtained_by = (TYPEOF(h.license_obtained_by))'',0,100));
    maxlength_license_obtained_by := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.license_obtained_by)));
    avelength_license_obtained_by := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.license_obtained_by)),h.license_obtained_by<>(typeof(h.license_obtained_by))'');
    populated_board_action_indicator_pcnt := AVE(GROUP,IF(h.board_action_indicator = (TYPEOF(h.board_action_indicator))'',0,100));
    maxlength_board_action_indicator := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.board_action_indicator)));
    avelength_board_action_indicator := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.board_action_indicator)),h.board_action_indicator<>(typeof(h.board_action_indicator))'');
    populated_source_st_pcnt := AVE(GROUP,IF(h.source_st = (TYPEOF(h.source_st))'',0,100));
    maxlength_source_st := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.source_st)));
    avelength_source_st := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.source_st)),h.source_st<>(typeof(h.source_st))'');
    populated_vendor_pcnt := AVE(GROUP,IF(h.vendor = (TYPEOF(h.vendor))'',0,100));
    maxlength_vendor := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.vendor)));
    avelength_vendor := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.vendor)),h.vendor<>(typeof(h.vendor))'');
    populated_action_record_type_pcnt := AVE(GROUP,IF(h.action_record_type = (TYPEOF(h.action_record_type))'',0,100));
    maxlength_action_record_type := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.action_record_type)));
    avelength_action_record_type := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.action_record_type)),h.action_record_type<>(typeof(h.action_record_type))'');
    populated_action_complaint_violation_cds_pcnt := AVE(GROUP,IF(h.action_complaint_violation_cds = (TYPEOF(h.action_complaint_violation_cds))'',0,100));
    maxlength_action_complaint_violation_cds := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.action_complaint_violation_cds)));
    avelength_action_complaint_violation_cds := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.action_complaint_violation_cds)),h.action_complaint_violation_cds<>(typeof(h.action_complaint_violation_cds))'');
    populated_action_complaint_violation_desc_pcnt := AVE(GROUP,IF(h.action_complaint_violation_desc = (TYPEOF(h.action_complaint_violation_desc))'',0,100));
    maxlength_action_complaint_violation_desc := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.action_complaint_violation_desc)));
    avelength_action_complaint_violation_desc := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.action_complaint_violation_desc)),h.action_complaint_violation_desc<>(typeof(h.action_complaint_violation_desc))'');
    populated_action_complaint_violation_dt_pcnt := AVE(GROUP,IF(h.action_complaint_violation_dt = (TYPEOF(h.action_complaint_violation_dt))'',0,100));
    maxlength_action_complaint_violation_dt := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.action_complaint_violation_dt)));
    avelength_action_complaint_violation_dt := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.action_complaint_violation_dt)),h.action_complaint_violation_dt<>(typeof(h.action_complaint_violation_dt))'');
    populated_action_case_number_pcnt := AVE(GROUP,IF(h.action_case_number = (TYPEOF(h.action_case_number))'',0,100));
    maxlength_action_case_number := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.action_case_number)));
    avelength_action_case_number := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.action_case_number)),h.action_case_number<>(typeof(h.action_case_number))'');
    populated_action_effective_dt_pcnt := AVE(GROUP,IF(h.action_effective_dt = (TYPEOF(h.action_effective_dt))'',0,100));
    maxlength_action_effective_dt := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.action_effective_dt)));
    avelength_action_effective_dt := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.action_effective_dt)),h.action_effective_dt<>(typeof(h.action_effective_dt))'');
    populated_action_cds_pcnt := AVE(GROUP,IF(h.action_cds = (TYPEOF(h.action_cds))'',0,100));
    maxlength_action_cds := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.action_cds)));
    avelength_action_cds := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.action_cds)),h.action_cds<>(typeof(h.action_cds))'');
    populated_action_desc_pcnt := AVE(GROUP,IF(h.action_desc = (TYPEOF(h.action_desc))'',0,100));
    maxlength_action_desc := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.action_desc)));
    avelength_action_desc := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.action_desc)),h.action_desc<>(typeof(h.action_desc))'');
    populated_action_final_order_no_pcnt := AVE(GROUP,IF(h.action_final_order_no = (TYPEOF(h.action_final_order_no))'',0,100));
    maxlength_action_final_order_no := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.action_final_order_no)));
    avelength_action_final_order_no := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.action_final_order_no)),h.action_final_order_no<>(typeof(h.action_final_order_no))'');
    populated_action_status_pcnt := AVE(GROUP,IF(h.action_status = (TYPEOF(h.action_status))'',0,100));
    maxlength_action_status := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.action_status)));
    avelength_action_status := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.action_status)),h.action_status<>(typeof(h.action_status))'');
    populated_action_posting_status_dt_pcnt := AVE(GROUP,IF(h.action_posting_status_dt = (TYPEOF(h.action_posting_status_dt))'',0,100));
    maxlength_action_posting_status_dt := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.action_posting_status_dt)));
    avelength_action_posting_status_dt := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.action_posting_status_dt)),h.action_posting_status_dt<>(typeof(h.action_posting_status_dt))'');
    populated_action_original_filename_or_url_pcnt := AVE(GROUP,IF(h.action_original_filename_or_url = (TYPEOF(h.action_original_filename_or_url))'',0,100));
    maxlength_action_original_filename_or_url := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.action_original_filename_or_url)));
    avelength_action_original_filename_or_url := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.action_original_filename_or_url)),h.action_original_filename_or_url<>(typeof(h.action_original_filename_or_url))'');
    populated_additional_name_addr_type_pcnt := AVE(GROUP,IF(h.additional_name_addr_type = (TYPEOF(h.additional_name_addr_type))'',0,100));
    maxlength_additional_name_addr_type := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.additional_name_addr_type)));
    avelength_additional_name_addr_type := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.additional_name_addr_type)),h.additional_name_addr_type<>(typeof(h.additional_name_addr_type))'');
    populated_additional_orig_name_pcnt := AVE(GROUP,IF(h.additional_orig_name = (TYPEOF(h.additional_orig_name))'',0,100));
    maxlength_additional_orig_name := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.additional_orig_name)));
    avelength_additional_orig_name := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.additional_orig_name)),h.additional_orig_name<>(typeof(h.additional_orig_name))'');
    populated_additional_name_order_pcnt := AVE(GROUP,IF(h.additional_name_order = (TYPEOF(h.additional_name_order))'',0,100));
    maxlength_additional_name_order := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.additional_name_order)));
    avelength_additional_name_order := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.additional_name_order)),h.additional_name_order<>(typeof(h.additional_name_order))'');
    populated_additional_orig_additional_1_pcnt := AVE(GROUP,IF(h.additional_orig_additional_1 = (TYPEOF(h.additional_orig_additional_1))'',0,100));
    maxlength_additional_orig_additional_1 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.additional_orig_additional_1)));
    avelength_additional_orig_additional_1 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.additional_orig_additional_1)),h.additional_orig_additional_1<>(typeof(h.additional_orig_additional_1))'');
    populated_additional_orig_additional_2_pcnt := AVE(GROUP,IF(h.additional_orig_additional_2 = (TYPEOF(h.additional_orig_additional_2))'',0,100));
    maxlength_additional_orig_additional_2 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.additional_orig_additional_2)));
    avelength_additional_orig_additional_2 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.additional_orig_additional_2)),h.additional_orig_additional_2<>(typeof(h.additional_orig_additional_2))'');
    populated_additional_orig_additional_3_pcnt := AVE(GROUP,IF(h.additional_orig_additional_3 = (TYPEOF(h.additional_orig_additional_3))'',0,100));
    maxlength_additional_orig_additional_3 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.additional_orig_additional_3)));
    avelength_additional_orig_additional_3 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.additional_orig_additional_3)),h.additional_orig_additional_3<>(typeof(h.additional_orig_additional_3))'');
    populated_additional_orig_additional_4_pcnt := AVE(GROUP,IF(h.additional_orig_additional_4 = (TYPEOF(h.additional_orig_additional_4))'',0,100));
    maxlength_additional_orig_additional_4 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.additional_orig_additional_4)));
    avelength_additional_orig_additional_4 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.additional_orig_additional_4)),h.additional_orig_additional_4<>(typeof(h.additional_orig_additional_4))'');
    populated_additional_orig_city_pcnt := AVE(GROUP,IF(h.additional_orig_city = (TYPEOF(h.additional_orig_city))'',0,100));
    maxlength_additional_orig_city := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.additional_orig_city)));
    avelength_additional_orig_city := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.additional_orig_city)),h.additional_orig_city<>(typeof(h.additional_orig_city))'');
    populated_additional_orig_st_pcnt := AVE(GROUP,IF(h.additional_orig_st = (TYPEOF(h.additional_orig_st))'',0,100));
    maxlength_additional_orig_st := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.additional_orig_st)));
    avelength_additional_orig_st := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.additional_orig_st)),h.additional_orig_st<>(typeof(h.additional_orig_st))'');
    populated_additional_orig_zip_pcnt := AVE(GROUP,IF(h.additional_orig_zip = (TYPEOF(h.additional_orig_zip))'',0,100));
    maxlength_additional_orig_zip := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.additional_orig_zip)));
    avelength_additional_orig_zip := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.additional_orig_zip)),h.additional_orig_zip<>(typeof(h.additional_orig_zip))'');
    populated_additional_phone_pcnt := AVE(GROUP,IF(h.additional_phone = (TYPEOF(h.additional_phone))'',0,100));
    maxlength_additional_phone := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.additional_phone)));
    avelength_additional_phone := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.additional_phone)),h.additional_phone<>(typeof(h.additional_phone))'');
    populated_misc_occupation_pcnt := AVE(GROUP,IF(h.misc_occupation = (TYPEOF(h.misc_occupation))'',0,100));
    maxlength_misc_occupation := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.misc_occupation)));
    avelength_misc_occupation := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.misc_occupation)),h.misc_occupation<>(typeof(h.misc_occupation))'');
    populated_misc_practice_hours_pcnt := AVE(GROUP,IF(h.misc_practice_hours = (TYPEOF(h.misc_practice_hours))'',0,100));
    maxlength_misc_practice_hours := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.misc_practice_hours)));
    avelength_misc_practice_hours := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.misc_practice_hours)),h.misc_practice_hours<>(typeof(h.misc_practice_hours))'');
    populated_misc_practice_type_pcnt := AVE(GROUP,IF(h.misc_practice_type = (TYPEOF(h.misc_practice_type))'',0,100));
    maxlength_misc_practice_type := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.misc_practice_type)));
    avelength_misc_practice_type := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.misc_practice_type)),h.misc_practice_type<>(typeof(h.misc_practice_type))'');
    populated_misc_email_pcnt := AVE(GROUP,IF(h.misc_email = (TYPEOF(h.misc_email))'',0,100));
    maxlength_misc_email := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.misc_email)));
    avelength_misc_email := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.misc_email)),h.misc_email<>(typeof(h.misc_email))'');
    populated_misc_fax_pcnt := AVE(GROUP,IF(h.misc_fax = (TYPEOF(h.misc_fax))'',0,100));
    maxlength_misc_fax := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.misc_fax)));
    avelength_misc_fax := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.misc_fax)),h.misc_fax<>(typeof(h.misc_fax))'');
    populated_misc_web_site_pcnt := AVE(GROUP,IF(h.misc_web_site = (TYPEOF(h.misc_web_site))'',0,100));
    maxlength_misc_web_site := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.misc_web_site)));
    avelength_misc_web_site := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.misc_web_site)),h.misc_web_site<>(typeof(h.misc_web_site))'');
    populated_misc_other_id_pcnt := AVE(GROUP,IF(h.misc_other_id = (TYPEOF(h.misc_other_id))'',0,100));
    maxlength_misc_other_id := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.misc_other_id)));
    avelength_misc_other_id := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.misc_other_id)),h.misc_other_id<>(typeof(h.misc_other_id))'');
    populated_misc_other_id_type_pcnt := AVE(GROUP,IF(h.misc_other_id_type = (TYPEOF(h.misc_other_id_type))'',0,100));
    maxlength_misc_other_id_type := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.misc_other_id_type)));
    avelength_misc_other_id_type := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.misc_other_id_type)),h.misc_other_id_type<>(typeof(h.misc_other_id_type))'');
    populated_education_continuing_education_pcnt := AVE(GROUP,IF(h.education_continuing_education = (TYPEOF(h.education_continuing_education))'',0,100));
    maxlength_education_continuing_education := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.education_continuing_education)));
    avelength_education_continuing_education := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.education_continuing_education)),h.education_continuing_education<>(typeof(h.education_continuing_education))'');
    populated_education_1_school_attended_pcnt := AVE(GROUP,IF(h.education_1_school_attended = (TYPEOF(h.education_1_school_attended))'',0,100));
    maxlength_education_1_school_attended := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.education_1_school_attended)));
    avelength_education_1_school_attended := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.education_1_school_attended)),h.education_1_school_attended<>(typeof(h.education_1_school_attended))'');
    populated_education_1_dates_attended_pcnt := AVE(GROUP,IF(h.education_1_dates_attended = (TYPEOF(h.education_1_dates_attended))'',0,100));
    maxlength_education_1_dates_attended := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.education_1_dates_attended)));
    avelength_education_1_dates_attended := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.education_1_dates_attended)),h.education_1_dates_attended<>(typeof(h.education_1_dates_attended))'');
    populated_education_1_curriculum_pcnt := AVE(GROUP,IF(h.education_1_curriculum = (TYPEOF(h.education_1_curriculum))'',0,100));
    maxlength_education_1_curriculum := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.education_1_curriculum)));
    avelength_education_1_curriculum := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.education_1_curriculum)),h.education_1_curriculum<>(typeof(h.education_1_curriculum))'');
    populated_education_1_degree_pcnt := AVE(GROUP,IF(h.education_1_degree = (TYPEOF(h.education_1_degree))'',0,100));
    maxlength_education_1_degree := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.education_1_degree)));
    avelength_education_1_degree := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.education_1_degree)),h.education_1_degree<>(typeof(h.education_1_degree))'');
    populated_education_2_school_attended_pcnt := AVE(GROUP,IF(h.education_2_school_attended = (TYPEOF(h.education_2_school_attended))'',0,100));
    maxlength_education_2_school_attended := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.education_2_school_attended)));
    avelength_education_2_school_attended := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.education_2_school_attended)),h.education_2_school_attended<>(typeof(h.education_2_school_attended))'');
    populated_education_2_dates_attended_pcnt := AVE(GROUP,IF(h.education_2_dates_attended = (TYPEOF(h.education_2_dates_attended))'',0,100));
    maxlength_education_2_dates_attended := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.education_2_dates_attended)));
    avelength_education_2_dates_attended := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.education_2_dates_attended)),h.education_2_dates_attended<>(typeof(h.education_2_dates_attended))'');
    populated_education_2_curriculum_pcnt := AVE(GROUP,IF(h.education_2_curriculum = (TYPEOF(h.education_2_curriculum))'',0,100));
    maxlength_education_2_curriculum := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.education_2_curriculum)));
    avelength_education_2_curriculum := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.education_2_curriculum)),h.education_2_curriculum<>(typeof(h.education_2_curriculum))'');
    populated_education_2_degree_pcnt := AVE(GROUP,IF(h.education_2_degree = (TYPEOF(h.education_2_degree))'',0,100));
    maxlength_education_2_degree := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.education_2_degree)));
    avelength_education_2_degree := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.education_2_degree)),h.education_2_degree<>(typeof(h.education_2_degree))'');
    populated_education_3_school_attended_pcnt := AVE(GROUP,IF(h.education_3_school_attended = (TYPEOF(h.education_3_school_attended))'',0,100));
    maxlength_education_3_school_attended := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.education_3_school_attended)));
    avelength_education_3_school_attended := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.education_3_school_attended)),h.education_3_school_attended<>(typeof(h.education_3_school_attended))'');
    populated_education_3_dates_attended_pcnt := AVE(GROUP,IF(h.education_3_dates_attended = (TYPEOF(h.education_3_dates_attended))'',0,100));
    maxlength_education_3_dates_attended := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.education_3_dates_attended)));
    avelength_education_3_dates_attended := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.education_3_dates_attended)),h.education_3_dates_attended<>(typeof(h.education_3_dates_attended))'');
    populated_education_3_curriculum_pcnt := AVE(GROUP,IF(h.education_3_curriculum = (TYPEOF(h.education_3_curriculum))'',0,100));
    maxlength_education_3_curriculum := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.education_3_curriculum)));
    avelength_education_3_curriculum := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.education_3_curriculum)),h.education_3_curriculum<>(typeof(h.education_3_curriculum))'');
    populated_education_3_degree_pcnt := AVE(GROUP,IF(h.education_3_degree = (TYPEOF(h.education_3_degree))'',0,100));
    maxlength_education_3_degree := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.education_3_degree)));
    avelength_education_3_degree := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.education_3_degree)),h.education_3_degree<>(typeof(h.education_3_degree))'');
    populated_additional_licensing_specifics_pcnt := AVE(GROUP,IF(h.additional_licensing_specifics = (TYPEOF(h.additional_licensing_specifics))'',0,100));
    maxlength_additional_licensing_specifics := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.additional_licensing_specifics)));
    avelength_additional_licensing_specifics := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.additional_licensing_specifics)),h.additional_licensing_specifics<>(typeof(h.additional_licensing_specifics))'');
    populated_personal_pob_cd_pcnt := AVE(GROUP,IF(h.personal_pob_cd = (TYPEOF(h.personal_pob_cd))'',0,100));
    maxlength_personal_pob_cd := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.personal_pob_cd)));
    avelength_personal_pob_cd := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.personal_pob_cd)),h.personal_pob_cd<>(typeof(h.personal_pob_cd))'');
    populated_personal_pob_desc_pcnt := AVE(GROUP,IF(h.personal_pob_desc = (TYPEOF(h.personal_pob_desc))'',0,100));
    maxlength_personal_pob_desc := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.personal_pob_desc)));
    avelength_personal_pob_desc := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.personal_pob_desc)),h.personal_pob_desc<>(typeof(h.personal_pob_desc))'');
    populated_personal_race_cd_pcnt := AVE(GROUP,IF(h.personal_race_cd = (TYPEOF(h.personal_race_cd))'',0,100));
    maxlength_personal_race_cd := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.personal_race_cd)));
    avelength_personal_race_cd := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.personal_race_cd)),h.personal_race_cd<>(typeof(h.personal_race_cd))'');
    populated_personal_race_desc_pcnt := AVE(GROUP,IF(h.personal_race_desc = (TYPEOF(h.personal_race_desc))'',0,100));
    maxlength_personal_race_desc := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.personal_race_desc)));
    avelength_personal_race_desc := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.personal_race_desc)),h.personal_race_desc<>(typeof(h.personal_race_desc))'');
    populated_status_status_cds_pcnt := AVE(GROUP,IF(h.status_status_cds = (TYPEOF(h.status_status_cds))'',0,100));
    maxlength_status_status_cds := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.status_status_cds)));
    avelength_status_status_cds := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.status_status_cds)),h.status_status_cds<>(typeof(h.status_status_cds))'');
    populated_status_effective_dt_pcnt := AVE(GROUP,IF(h.status_effective_dt = (TYPEOF(h.status_effective_dt))'',0,100));
    maxlength_status_effective_dt := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.status_effective_dt)));
    avelength_status_effective_dt := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.status_effective_dt)),h.status_effective_dt<>(typeof(h.status_effective_dt))'');
    populated_status_renewal_desc_pcnt := AVE(GROUP,IF(h.status_renewal_desc = (TYPEOF(h.status_renewal_desc))'',0,100));
    maxlength_status_renewal_desc := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.status_renewal_desc)));
    avelength_status_renewal_desc := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.status_renewal_desc)),h.status_renewal_desc<>(typeof(h.status_renewal_desc))'');
    populated_status_other_agency_pcnt := AVE(GROUP,IF(h.status_other_agency = (TYPEOF(h.status_other_agency))'',0,100));
    maxlength_status_other_agency := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.status_other_agency)));
    avelength_status_other_agency := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.status_other_agency)),h.status_other_agency<>(typeof(h.status_other_agency))'');
    populated_prim_range_pcnt := AVE(GROUP,IF(h.prim_range = (TYPEOF(h.prim_range))'',0,100));
    maxlength_prim_range := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.prim_range)));
    avelength_prim_range := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.prim_range)),h.prim_range<>(typeof(h.prim_range))'');
    populated_predir_pcnt := AVE(GROUP,IF(h.predir = (TYPEOF(h.predir))'',0,100));
    maxlength_predir := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.predir)));
    avelength_predir := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.predir)),h.predir<>(typeof(h.predir))'');
    populated_prim_name_pcnt := AVE(GROUP,IF(h.prim_name = (TYPEOF(h.prim_name))'',0,100));
    maxlength_prim_name := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.prim_name)));
    avelength_prim_name := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.prim_name)),h.prim_name<>(typeof(h.prim_name))'');
    populated_suffix_pcnt := AVE(GROUP,IF(h.suffix = (TYPEOF(h.suffix))'',0,100));
    maxlength_suffix := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.suffix)));
    avelength_suffix := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.suffix)),h.suffix<>(typeof(h.suffix))'');
    populated_postdir_pcnt := AVE(GROUP,IF(h.postdir = (TYPEOF(h.postdir))'',0,100));
    maxlength_postdir := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.postdir)));
    avelength_postdir := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.postdir)),h.postdir<>(typeof(h.postdir))'');
    populated_unit_desig_pcnt := AVE(GROUP,IF(h.unit_desig = (TYPEOF(h.unit_desig))'',0,100));
    maxlength_unit_desig := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.unit_desig)));
    avelength_unit_desig := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.unit_desig)),h.unit_desig<>(typeof(h.unit_desig))'');
    populated_sec_range_pcnt := AVE(GROUP,IF(h.sec_range = (TYPEOF(h.sec_range))'',0,100));
    maxlength_sec_range := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.sec_range)));
    avelength_sec_range := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.sec_range)),h.sec_range<>(typeof(h.sec_range))'');
    populated_p_city_name_pcnt := AVE(GROUP,IF(h.p_city_name = (TYPEOF(h.p_city_name))'',0,100));
    maxlength_p_city_name := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.p_city_name)));
    avelength_p_city_name := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.p_city_name)),h.p_city_name<>(typeof(h.p_city_name))'');
    populated_v_city_name_pcnt := AVE(GROUP,IF(h.v_city_name = (TYPEOF(h.v_city_name))'',0,100));
    maxlength_v_city_name := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.v_city_name)));
    avelength_v_city_name := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.v_city_name)),h.v_city_name<>(typeof(h.v_city_name))'');
    populated_st_pcnt := AVE(GROUP,IF(h.st = (TYPEOF(h.st))'',0,100));
    maxlength_st := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.st)));
    avelength_st := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.st)),h.st<>(typeof(h.st))'');
    populated_zip_pcnt := AVE(GROUP,IF(h.zip = (TYPEOF(h.zip))'',0,100));
    maxlength_zip := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.zip)));
    avelength_zip := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.zip)),h.zip<>(typeof(h.zip))'');
    populated_zip4_pcnt := AVE(GROUP,IF(h.zip4 = (TYPEOF(h.zip4))'',0,100));
    maxlength_zip4 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.zip4)));
    avelength_zip4 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.zip4)),h.zip4<>(typeof(h.zip4))'');
    populated_cart_pcnt := AVE(GROUP,IF(h.cart = (TYPEOF(h.cart))'',0,100));
    maxlength_cart := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.cart)));
    avelength_cart := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.cart)),h.cart<>(typeof(h.cart))'');
    populated_cr_sort_sz_pcnt := AVE(GROUP,IF(h.cr_sort_sz = (TYPEOF(h.cr_sort_sz))'',0,100));
    maxlength_cr_sort_sz := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.cr_sort_sz)));
    avelength_cr_sort_sz := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.cr_sort_sz)),h.cr_sort_sz<>(typeof(h.cr_sort_sz))'');
    populated_lot_pcnt := AVE(GROUP,IF(h.lot = (TYPEOF(h.lot))'',0,100));
    maxlength_lot := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.lot)));
    avelength_lot := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.lot)),h.lot<>(typeof(h.lot))'');
    populated_lot_order_pcnt := AVE(GROUP,IF(h.lot_order = (TYPEOF(h.lot_order))'',0,100));
    maxlength_lot_order := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.lot_order)));
    avelength_lot_order := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.lot_order)),h.lot_order<>(typeof(h.lot_order))'');
    populated_dpbc_pcnt := AVE(GROUP,IF(h.dpbc = (TYPEOF(h.dpbc))'',0,100));
    maxlength_dpbc := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.dpbc)));
    avelength_dpbc := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.dpbc)),h.dpbc<>(typeof(h.dpbc))'');
    populated_chk_digit_pcnt := AVE(GROUP,IF(h.chk_digit = (TYPEOF(h.chk_digit))'',0,100));
    maxlength_chk_digit := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.chk_digit)));
    avelength_chk_digit := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.chk_digit)),h.chk_digit<>(typeof(h.chk_digit))'');
    populated_record_type_pcnt := AVE(GROUP,IF(h.record_type = (TYPEOF(h.record_type))'',0,100));
    maxlength_record_type := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.record_type)));
    avelength_record_type := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.record_type)),h.record_type<>(typeof(h.record_type))'');
    populated_ace_fips_st_pcnt := AVE(GROUP,IF(h.ace_fips_st = (TYPEOF(h.ace_fips_st))'',0,100));
    maxlength_ace_fips_st := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.ace_fips_st)));
    avelength_ace_fips_st := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.ace_fips_st)),h.ace_fips_st<>(typeof(h.ace_fips_st))'');
    populated_county_pcnt := AVE(GROUP,IF(h.county = (TYPEOF(h.county))'',0,100));
    maxlength_county := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.county)));
    avelength_county := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.county)),h.county<>(typeof(h.county))'');
    populated_geo_lat_pcnt := AVE(GROUP,IF(h.geo_lat = (TYPEOF(h.geo_lat))'',0,100));
    maxlength_geo_lat := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.geo_lat)));
    avelength_geo_lat := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.geo_lat)),h.geo_lat<>(typeof(h.geo_lat))'');
    populated_geo_long_pcnt := AVE(GROUP,IF(h.geo_long = (TYPEOF(h.geo_long))'',0,100));
    maxlength_geo_long := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.geo_long)));
    avelength_geo_long := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.geo_long)),h.geo_long<>(typeof(h.geo_long))'');
    populated_msa_pcnt := AVE(GROUP,IF(h.msa = (TYPEOF(h.msa))'',0,100));
    maxlength_msa := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.msa)));
    avelength_msa := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.msa)),h.msa<>(typeof(h.msa))'');
    populated_geo_blk_pcnt := AVE(GROUP,IF(h.geo_blk = (TYPEOF(h.geo_blk))'',0,100));
    maxlength_geo_blk := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.geo_blk)));
    avelength_geo_blk := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.geo_blk)),h.geo_blk<>(typeof(h.geo_blk))'');
    populated_geo_match_pcnt := AVE(GROUP,IF(h.geo_match = (TYPEOF(h.geo_match))'',0,100));
    maxlength_geo_match := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.geo_match)));
    avelength_geo_match := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.geo_match)),h.geo_match<>(typeof(h.geo_match))'');
    populated_err_stat_pcnt := AVE(GROUP,IF(h.err_stat = (TYPEOF(h.err_stat))'',0,100));
    maxlength_err_stat := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.err_stat)));
    avelength_err_stat := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.err_stat)),h.err_stat<>(typeof(h.err_stat))'');
    populated_title_pcnt := AVE(GROUP,IF(h.title = (TYPEOF(h.title))'',0,100));
    maxlength_title := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.title)));
    avelength_title := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.title)),h.title<>(typeof(h.title))'');
    populated_fname_pcnt := AVE(GROUP,IF(h.fname = (TYPEOF(h.fname))'',0,100));
    maxlength_fname := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.fname)));
    avelength_fname := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.fname)),h.fname<>(typeof(h.fname))'');
    populated_mname_pcnt := AVE(GROUP,IF(h.mname = (TYPEOF(h.mname))'',0,100));
    maxlength_mname := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.mname)));
    avelength_mname := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.mname)),h.mname<>(typeof(h.mname))'');
    populated_lname_pcnt := AVE(GROUP,IF(h.lname = (TYPEOF(h.lname))'',0,100));
    maxlength_lname := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.lname)));
    avelength_lname := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.lname)),h.lname<>(typeof(h.lname))'');
    populated_name_suffix_pcnt := AVE(GROUP,IF(h.name_suffix = (TYPEOF(h.name_suffix))'',0,100));
    maxlength_name_suffix := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.name_suffix)));
    avelength_name_suffix := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.name_suffix)),h.name_suffix<>(typeof(h.name_suffix))'');
    populated_pl_score_in_pcnt := AVE(GROUP,IF(h.pl_score_in = (TYPEOF(h.pl_score_in))'',0,100));
    maxlength_pl_score_in := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.pl_score_in)));
    avelength_pl_score_in := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.pl_score_in)),h.pl_score_in<>(typeof(h.pl_score_in))'');
    populated_prep_addr_line1_pcnt := AVE(GROUP,IF(h.prep_addr_line1 = (TYPEOF(h.prep_addr_line1))'',0,100));
    maxlength_prep_addr_line1 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.prep_addr_line1)));
    avelength_prep_addr_line1 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.prep_addr_line1)),h.prep_addr_line1<>(typeof(h.prep_addr_line1))'');
    populated_prep_addr_last_line_pcnt := AVE(GROUP,IF(h.prep_addr_last_line = (TYPEOF(h.prep_addr_last_line))'',0,100));
    maxlength_prep_addr_last_line := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.prep_addr_last_line)));
    avelength_prep_addr_last_line := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.prep_addr_last_line)),h.prep_addr_last_line<>(typeof(h.prep_addr_last_line))'');
    populated_rawaid_pcnt := AVE(GROUP,IF(h.rawaid = (TYPEOF(h.rawaid))'',0,100));
    maxlength_rawaid := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.rawaid)));
    avelength_rawaid := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.rawaid)),h.rawaid<>(typeof(h.rawaid))'');
    populated_aceaid_pcnt := AVE(GROUP,IF(h.aceaid = (TYPEOF(h.aceaid))'',0,100));
    maxlength_aceaid := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.aceaid)));
    avelength_aceaid := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.aceaid)),h.aceaid<>(typeof(h.aceaid))'');
    populated_county_name_pcnt := AVE(GROUP,IF(h.county_name = (TYPEOF(h.county_name))'',0,100));
    maxlength_county_name := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.county_name)));
    avelength_county_name := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.county_name)),h.county_name<>(typeof(h.county_name))'');
    populated_did_pcnt := AVE(GROUP,IF(h.did = (TYPEOF(h.did))'',0,100));
    maxlength_did := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.did)));
    avelength_did := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.did)),h.did<>(typeof(h.did))'');
    populated_score_pcnt := AVE(GROUP,IF(h.score = (TYPEOF(h.score))'',0,100));
    maxlength_score := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.score)));
    avelength_score := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.score)),h.score<>(typeof(h.score))'');
    populated_best_ssn_pcnt := AVE(GROUP,IF(h.best_ssn = (TYPEOF(h.best_ssn))'',0,100));
    maxlength_best_ssn := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.best_ssn)));
    avelength_best_ssn := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.best_ssn)),h.best_ssn<>(typeof(h.best_ssn))'');
    populated_bdid_pcnt := AVE(GROUP,IF(h.bdid = (TYPEOF(h.bdid))'',0,100));
    maxlength_bdid := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.bdid)));
    avelength_bdid := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.bdid)),h.bdid<>(typeof(h.bdid))'');
    populated_source_rec_id_pcnt := AVE(GROUP,IF(h.source_rec_id = (TYPEOF(h.source_rec_id))'',0,100));
    maxlength_source_rec_id := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.source_rec_id)));
    avelength_source_rec_id := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.source_rec_id)),h.source_rec_id<>(typeof(h.source_rec_id))'');
    populated_dotid_pcnt := AVE(GROUP,IF(h.dotid = (TYPEOF(h.dotid))'',0,100));
    maxlength_dotid := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.dotid)));
    avelength_dotid := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.dotid)),h.dotid<>(typeof(h.dotid))'');
    populated_dotscore_pcnt := AVE(GROUP,IF(h.dotscore = (TYPEOF(h.dotscore))'',0,100));
    maxlength_dotscore := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.dotscore)));
    avelength_dotscore := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.dotscore)),h.dotscore<>(typeof(h.dotscore))'');
    populated_dotweight_pcnt := AVE(GROUP,IF(h.dotweight = (TYPEOF(h.dotweight))'',0,100));
    maxlength_dotweight := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.dotweight)));
    avelength_dotweight := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.dotweight)),h.dotweight<>(typeof(h.dotweight))'');
    populated_empid_pcnt := AVE(GROUP,IF(h.empid = (TYPEOF(h.empid))'',0,100));
    maxlength_empid := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.empid)));
    avelength_empid := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.empid)),h.empid<>(typeof(h.empid))'');
    populated_empscore_pcnt := AVE(GROUP,IF(h.empscore = (TYPEOF(h.empscore))'',0,100));
    maxlength_empscore := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.empscore)));
    avelength_empscore := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.empscore)),h.empscore<>(typeof(h.empscore))'');
    populated_empweight_pcnt := AVE(GROUP,IF(h.empweight = (TYPEOF(h.empweight))'',0,100));
    maxlength_empweight := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.empweight)));
    avelength_empweight := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.empweight)),h.empweight<>(typeof(h.empweight))'');
    populated_powid_pcnt := AVE(GROUP,IF(h.powid = (TYPEOF(h.powid))'',0,100));
    maxlength_powid := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.powid)));
    avelength_powid := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.powid)),h.powid<>(typeof(h.powid))'');
    populated_powscore_pcnt := AVE(GROUP,IF(h.powscore = (TYPEOF(h.powscore))'',0,100));
    maxlength_powscore := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.powscore)));
    avelength_powscore := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.powscore)),h.powscore<>(typeof(h.powscore))'');
    populated_powweight_pcnt := AVE(GROUP,IF(h.powweight = (TYPEOF(h.powweight))'',0,100));
    maxlength_powweight := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.powweight)));
    avelength_powweight := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.powweight)),h.powweight<>(typeof(h.powweight))'');
    populated_proxid_pcnt := AVE(GROUP,IF(h.proxid = (TYPEOF(h.proxid))'',0,100));
    maxlength_proxid := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.proxid)));
    avelength_proxid := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.proxid)),h.proxid<>(typeof(h.proxid))'');
    populated_proxscore_pcnt := AVE(GROUP,IF(h.proxscore = (TYPEOF(h.proxscore))'',0,100));
    maxlength_proxscore := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.proxscore)));
    avelength_proxscore := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.proxscore)),h.proxscore<>(typeof(h.proxscore))'');
    populated_proxweight_pcnt := AVE(GROUP,IF(h.proxweight = (TYPEOF(h.proxweight))'',0,100));
    maxlength_proxweight := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.proxweight)));
    avelength_proxweight := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.proxweight)),h.proxweight<>(typeof(h.proxweight))'');
    populated_seleid_pcnt := AVE(GROUP,IF(h.seleid = (TYPEOF(h.seleid))'',0,100));
    maxlength_seleid := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.seleid)));
    avelength_seleid := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.seleid)),h.seleid<>(typeof(h.seleid))'');
    populated_selescore_pcnt := AVE(GROUP,IF(h.selescore = (TYPEOF(h.selescore))'',0,100));
    maxlength_selescore := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.selescore)));
    avelength_selescore := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.selescore)),h.selescore<>(typeof(h.selescore))'');
    populated_seleweight_pcnt := AVE(GROUP,IF(h.seleweight = (TYPEOF(h.seleweight))'',0,100));
    maxlength_seleweight := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.seleweight)));
    avelength_seleweight := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.seleweight)),h.seleweight<>(typeof(h.seleweight))'');
    populated_orgid_pcnt := AVE(GROUP,IF(h.orgid = (TYPEOF(h.orgid))'',0,100));
    maxlength_orgid := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.orgid)));
    avelength_orgid := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.orgid)),h.orgid<>(typeof(h.orgid))'');
    populated_orgscore_pcnt := AVE(GROUP,IF(h.orgscore = (TYPEOF(h.orgscore))'',0,100));
    maxlength_orgscore := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.orgscore)));
    avelength_orgscore := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.orgscore)),h.orgscore<>(typeof(h.orgscore))'');
    populated_orgweight_pcnt := AVE(GROUP,IF(h.orgweight = (TYPEOF(h.orgweight))'',0,100));
    maxlength_orgweight := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.orgweight)));
    avelength_orgweight := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.orgweight)),h.orgweight<>(typeof(h.orgweight))'');
    populated_ultid_pcnt := AVE(GROUP,IF(h.ultid = (TYPEOF(h.ultid))'',0,100));
    maxlength_ultid := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.ultid)));
    avelength_ultid := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.ultid)),h.ultid<>(typeof(h.ultid))'');
    populated_ultscore_pcnt := AVE(GROUP,IF(h.ultscore = (TYPEOF(h.ultscore))'',0,100));
    maxlength_ultscore := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.ultscore)));
    avelength_ultscore := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.ultscore)),h.ultscore<>(typeof(h.ultscore))'');
    populated_ultweight_pcnt := AVE(GROUP,IF(h.ultweight = (TYPEOF(h.ultweight))'',0,100));
    maxlength_ultweight := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.ultweight)));
    avelength_ultweight := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.ultweight)),h.ultweight<>(typeof(h.ultweight))'');
    populated_lnpid_pcnt := AVE(GROUP,IF(h.lnpid = (TYPEOF(h.lnpid))'',0,100));
    maxlength_lnpid := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.lnpid)));
    avelength_lnpid := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.lnpid)),h.lnpid<>(typeof(h.lnpid))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_prolic_key_pcnt *   0.00 / 100 + T.Populated_date_first_seen_pcnt *   0.00 / 100 + T.Populated_date_last_seen_pcnt *   0.00 / 100 + T.Populated_profession_or_board_pcnt *   0.00 / 100 + T.Populated_license_type_pcnt *   0.00 / 100 + T.Populated_status_pcnt *   0.00 / 100 + T.Populated_orig_license_number_pcnt *   0.00 / 100 + T.Populated_license_number_pcnt *   0.00 / 100 + T.Populated_previous_license_number_pcnt *   0.00 / 100 + T.Populated_previous_license_type_pcnt *   0.00 / 100 + T.Populated_company_name_pcnt *   0.00 / 100 + T.Populated_orig_name_pcnt *   0.00 / 100 + T.Populated_name_order_pcnt *   0.00 / 100 + T.Populated_orig_former_name_pcnt *   0.00 / 100 + T.Populated_former_name_order_pcnt *   0.00 / 100 + T.Populated_orig_addr_1_pcnt *   0.00 / 100 + T.Populated_orig_addr_2_pcnt *   0.00 / 100 + T.Populated_orig_addr_3_pcnt *   0.00 / 100 + T.Populated_orig_addr_4_pcnt *   0.00 / 100 + T.Populated_orig_city_pcnt *   0.00 / 100 + T.Populated_orig_st_pcnt *   0.00 / 100 + T.Populated_orig_zip_pcnt *   0.00 / 100 + T.Populated_county_str_pcnt *   0.00 / 100 + T.Populated_country_str_pcnt *   0.00 / 100 + T.Populated_business_flag_pcnt *   0.00 / 100 + T.Populated_phone_pcnt *   0.00 / 100 + T.Populated_sex_pcnt *   0.00 / 100 + T.Populated_dob_pcnt *   0.00 / 100 + T.Populated_issue_date_pcnt *   0.00 / 100 + T.Populated_expiration_date_pcnt *   0.00 / 100 + T.Populated_last_renewal_date_pcnt *   0.00 / 100 + T.Populated_license_obtained_by_pcnt *   0.00 / 100 + T.Populated_board_action_indicator_pcnt *   0.00 / 100 + T.Populated_source_st_pcnt *   0.00 / 100 + T.Populated_vendor_pcnt *   0.00 / 100 + T.Populated_action_record_type_pcnt *   0.00 / 100 + T.Populated_action_complaint_violation_cds_pcnt *   0.00 / 100 + T.Populated_action_complaint_violation_desc_pcnt *   0.00 / 100 + T.Populated_action_complaint_violation_dt_pcnt *   0.00 / 100 + T.Populated_action_case_number_pcnt *   0.00 / 100 + T.Populated_action_effective_dt_pcnt *   0.00 / 100 + T.Populated_action_cds_pcnt *   0.00 / 100 + T.Populated_action_desc_pcnt *   0.00 / 100 + T.Populated_action_final_order_no_pcnt *   0.00 / 100 + T.Populated_action_status_pcnt *   0.00 / 100 + T.Populated_action_posting_status_dt_pcnt *   0.00 / 100 + T.Populated_action_original_filename_or_url_pcnt *   0.00 / 100 + T.Populated_additional_name_addr_type_pcnt *   0.00 / 100 + T.Populated_additional_orig_name_pcnt *   0.00 / 100 + T.Populated_additional_name_order_pcnt *   0.00 / 100 + T.Populated_additional_orig_additional_1_pcnt *   0.00 / 100 + T.Populated_additional_orig_additional_2_pcnt *   0.00 / 100 + T.Populated_additional_orig_additional_3_pcnt *   0.00 / 100 + T.Populated_additional_orig_additional_4_pcnt *   0.00 / 100 + T.Populated_additional_orig_city_pcnt *   0.00 / 100 + T.Populated_additional_orig_st_pcnt *   0.00 / 100 + T.Populated_additional_orig_zip_pcnt *   0.00 / 100 + T.Populated_additional_phone_pcnt *   0.00 / 100 + T.Populated_misc_occupation_pcnt *   0.00 / 100 + T.Populated_misc_practice_hours_pcnt *   0.00 / 100 + T.Populated_misc_practice_type_pcnt *   0.00 / 100 + T.Populated_misc_email_pcnt *   0.00 / 100 + T.Populated_misc_fax_pcnt *   0.00 / 100 + T.Populated_misc_web_site_pcnt *   0.00 / 100 + T.Populated_misc_other_id_pcnt *   0.00 / 100 + T.Populated_misc_other_id_type_pcnt *   0.00 / 100 + T.Populated_education_continuing_education_pcnt *   0.00 / 100 + T.Populated_education_1_school_attended_pcnt *   0.00 / 100 + T.Populated_education_1_dates_attended_pcnt *   0.00 / 100 + T.Populated_education_1_curriculum_pcnt *   0.00 / 100 + T.Populated_education_1_degree_pcnt *   0.00 / 100 + T.Populated_education_2_school_attended_pcnt *   0.00 / 100 + T.Populated_education_2_dates_attended_pcnt *   0.00 / 100 + T.Populated_education_2_curriculum_pcnt *   0.00 / 100 + T.Populated_education_2_degree_pcnt *   0.00 / 100 + T.Populated_education_3_school_attended_pcnt *   0.00 / 100 + T.Populated_education_3_dates_attended_pcnt *   0.00 / 100 + T.Populated_education_3_curriculum_pcnt *   0.00 / 100 + T.Populated_education_3_degree_pcnt *   0.00 / 100 + T.Populated_additional_licensing_specifics_pcnt *   0.00 / 100 + T.Populated_personal_pob_cd_pcnt *   0.00 / 100 + T.Populated_personal_pob_desc_pcnt *   0.00 / 100 + T.Populated_personal_race_cd_pcnt *   0.00 / 100 + T.Populated_personal_race_desc_pcnt *   0.00 / 100 + T.Populated_status_status_cds_pcnt *   0.00 / 100 + T.Populated_status_effective_dt_pcnt *   0.00 / 100 + T.Populated_status_renewal_desc_pcnt *   0.00 / 100 + T.Populated_status_other_agency_pcnt *   0.00 / 100 + T.Populated_prim_range_pcnt *   0.00 / 100 + T.Populated_predir_pcnt *   0.00 / 100 + T.Populated_prim_name_pcnt *   0.00 / 100 + T.Populated_suffix_pcnt *   0.00 / 100 + T.Populated_postdir_pcnt *   0.00 / 100 + T.Populated_unit_desig_pcnt *   0.00 / 100 + T.Populated_sec_range_pcnt *   0.00 / 100 + T.Populated_p_city_name_pcnt *   0.00 / 100 + T.Populated_v_city_name_pcnt *   0.00 / 100 + T.Populated_st_pcnt *   0.00 / 100 + T.Populated_zip_pcnt *   0.00 / 100 + T.Populated_zip4_pcnt *   0.00 / 100 + T.Populated_cart_pcnt *   0.00 / 100 + T.Populated_cr_sort_sz_pcnt *   0.00 / 100 + T.Populated_lot_pcnt *   0.00 / 100 + T.Populated_lot_order_pcnt *   0.00 / 100 + T.Populated_dpbc_pcnt *   0.00 / 100 + T.Populated_chk_digit_pcnt *   0.00 / 100 + T.Populated_record_type_pcnt *   0.00 / 100 + T.Populated_ace_fips_st_pcnt *   0.00 / 100 + T.Populated_county_pcnt *   0.00 / 100 + T.Populated_geo_lat_pcnt *   0.00 / 100 + T.Populated_geo_long_pcnt *   0.00 / 100 + T.Populated_msa_pcnt *   0.00 / 100 + T.Populated_geo_blk_pcnt *   0.00 / 100 + T.Populated_geo_match_pcnt *   0.00 / 100 + T.Populated_err_stat_pcnt *   0.00 / 100 + T.Populated_title_pcnt *   0.00 / 100 + T.Populated_fname_pcnt *   0.00 / 100 + T.Populated_mname_pcnt *   0.00 / 100 + T.Populated_lname_pcnt *   0.00 / 100 + T.Populated_name_suffix_pcnt *   0.00 / 100 + T.Populated_pl_score_in_pcnt *   0.00 / 100 + T.Populated_prep_addr_line1_pcnt *   0.00 / 100 + T.Populated_prep_addr_last_line_pcnt *   0.00 / 100 + T.Populated_rawaid_pcnt *   0.00 / 100 + T.Populated_aceaid_pcnt *   0.00 / 100 + T.Populated_county_name_pcnt *   0.00 / 100 + T.Populated_did_pcnt *   0.00 / 100 + T.Populated_score_pcnt *   0.00 / 100 + T.Populated_best_ssn_pcnt *   0.00 / 100 + T.Populated_bdid_pcnt *   0.00 / 100 + T.Populated_source_rec_id_pcnt *   0.00 / 100 + T.Populated_dotid_pcnt *   0.00 / 100 + T.Populated_dotscore_pcnt *   0.00 / 100 + T.Populated_dotweight_pcnt *   0.00 / 100 + T.Populated_empid_pcnt *   0.00 / 100 + T.Populated_empscore_pcnt *   0.00 / 100 + T.Populated_empweight_pcnt *   0.00 / 100 + T.Populated_powid_pcnt *   0.00 / 100 + T.Populated_powscore_pcnt *   0.00 / 100 + T.Populated_powweight_pcnt *   0.00 / 100 + T.Populated_proxid_pcnt *   0.00 / 100 + T.Populated_proxscore_pcnt *   0.00 / 100 + T.Populated_proxweight_pcnt *   0.00 / 100 + T.Populated_seleid_pcnt *   0.00 / 100 + T.Populated_selescore_pcnt *   0.00 / 100 + T.Populated_seleweight_pcnt *   0.00 / 100 + T.Populated_orgid_pcnt *   0.00 / 100 + T.Populated_orgscore_pcnt *   0.00 / 100 + T.Populated_orgweight_pcnt *   0.00 / 100 + T.Populated_ultid_pcnt *   0.00 / 100 + T.Populated_ultscore_pcnt *   0.00 / 100 + T.Populated_ultweight_pcnt *   0.00 / 100 + T.Populated_lnpid_pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;
 
summary0 := Summary('Summary');
invRec := RECORD
  UNSIGNED  FldNo;
  SALT37.StrType FieldName;
  UNSIGNED NumberOfRecords;
  REAL8  populated_pcnt;
  UNSIGNED  maxlength;
  REAL8  avelength;
END;
invRec invert(summary0 le, INTEGER C) := TRANSFORM
  SELF.FldNo := C;
  SELF.NumberOfRecords := le.NumberOfRecords;
  SELF.FieldName := CHOOSE(C,'prolic_key','date_first_seen','date_last_seen','profession_or_board','license_type','status','orig_license_number','license_number','previous_license_number','previous_license_type','company_name','orig_name','name_order','orig_former_name','former_name_order','orig_addr_1','orig_addr_2','orig_addr_3','orig_addr_4','orig_city','orig_st','orig_zip','county_str','country_str','business_flag','phone','sex','dob','issue_date','expiration_date','last_renewal_date','license_obtained_by','board_action_indicator','source_st','vendor','action_record_type','action_complaint_violation_cds','action_complaint_violation_desc','action_complaint_violation_dt','action_case_number','action_effective_dt','action_cds','action_desc','action_final_order_no','action_status','action_posting_status_dt','action_original_filename_or_url','additional_name_addr_type','additional_orig_name','additional_name_order','additional_orig_additional_1','additional_orig_additional_2','additional_orig_additional_3','additional_orig_additional_4','additional_orig_city','additional_orig_st','additional_orig_zip','additional_phone','misc_occupation','misc_practice_hours','misc_practice_type','misc_email','misc_fax','misc_web_site','misc_other_id','misc_other_id_type','education_continuing_education','education_1_school_attended','education_1_dates_attended','education_1_curriculum','education_1_degree','education_2_school_attended','education_2_dates_attended','education_2_curriculum','education_2_degree','education_3_school_attended','education_3_dates_attended','education_3_curriculum','education_3_degree','additional_licensing_specifics','personal_pob_cd','personal_pob_desc','personal_race_cd','personal_race_desc','status_status_cds','status_effective_dt','status_renewal_desc','status_other_agency','prim_range','predir','prim_name','suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dpbc','chk_digit','record_type','ace_fips_st','county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','title','fname','mname','lname','name_suffix','pl_score_in','prep_addr_line1','prep_addr_last_line','rawaid','aceaid','county_name','did','score','best_ssn','bdid','source_rec_id','dotid','dotscore','dotweight','empid','empscore','empweight','powid','powscore','powweight','proxid','proxscore','proxweight','seleid','selescore','seleweight','orgid','orgscore','orgweight','ultid','ultscore','ultweight','lnpid');
  SELF.populated_pcnt := CHOOSE(C,le.populated_prolic_key_pcnt,le.populated_date_first_seen_pcnt,le.populated_date_last_seen_pcnt,le.populated_profession_or_board_pcnt,le.populated_license_type_pcnt,le.populated_status_pcnt,le.populated_orig_license_number_pcnt,le.populated_license_number_pcnt,le.populated_previous_license_number_pcnt,le.populated_previous_license_type_pcnt,le.populated_company_name_pcnt,le.populated_orig_name_pcnt,le.populated_name_order_pcnt,le.populated_orig_former_name_pcnt,le.populated_former_name_order_pcnt,le.populated_orig_addr_1_pcnt,le.populated_orig_addr_2_pcnt,le.populated_orig_addr_3_pcnt,le.populated_orig_addr_4_pcnt,le.populated_orig_city_pcnt,le.populated_orig_st_pcnt,le.populated_orig_zip_pcnt,le.populated_county_str_pcnt,le.populated_country_str_pcnt,le.populated_business_flag_pcnt,le.populated_phone_pcnt,le.populated_sex_pcnt,le.populated_dob_pcnt,le.populated_issue_date_pcnt,le.populated_expiration_date_pcnt,le.populated_last_renewal_date_pcnt,le.populated_license_obtained_by_pcnt,le.populated_board_action_indicator_pcnt,le.populated_source_st_pcnt,le.populated_vendor_pcnt,le.populated_action_record_type_pcnt,le.populated_action_complaint_violation_cds_pcnt,le.populated_action_complaint_violation_desc_pcnt,le.populated_action_complaint_violation_dt_pcnt,le.populated_action_case_number_pcnt,le.populated_action_effective_dt_pcnt,le.populated_action_cds_pcnt,le.populated_action_desc_pcnt,le.populated_action_final_order_no_pcnt,le.populated_action_status_pcnt,le.populated_action_posting_status_dt_pcnt,le.populated_action_original_filename_or_url_pcnt,le.populated_additional_name_addr_type_pcnt,le.populated_additional_orig_name_pcnt,le.populated_additional_name_order_pcnt,le.populated_additional_orig_additional_1_pcnt,le.populated_additional_orig_additional_2_pcnt,le.populated_additional_orig_additional_3_pcnt,le.populated_additional_orig_additional_4_pcnt,le.populated_additional_orig_city_pcnt,le.populated_additional_orig_st_pcnt,le.populated_additional_orig_zip_pcnt,le.populated_additional_phone_pcnt,le.populated_misc_occupation_pcnt,le.populated_misc_practice_hours_pcnt,le.populated_misc_practice_type_pcnt,le.populated_misc_email_pcnt,le.populated_misc_fax_pcnt,le.populated_misc_web_site_pcnt,le.populated_misc_other_id_pcnt,le.populated_misc_other_id_type_pcnt,le.populated_education_continuing_education_pcnt,le.populated_education_1_school_attended_pcnt,le.populated_education_1_dates_attended_pcnt,le.populated_education_1_curriculum_pcnt,le.populated_education_1_degree_pcnt,le.populated_education_2_school_attended_pcnt,le.populated_education_2_dates_attended_pcnt,le.populated_education_2_curriculum_pcnt,le.populated_education_2_degree_pcnt,le.populated_education_3_school_attended_pcnt,le.populated_education_3_dates_attended_pcnt,le.populated_education_3_curriculum_pcnt,le.populated_education_3_degree_pcnt,le.populated_additional_licensing_specifics_pcnt,le.populated_personal_pob_cd_pcnt,le.populated_personal_pob_desc_pcnt,le.populated_personal_race_cd_pcnt,le.populated_personal_race_desc_pcnt,le.populated_status_status_cds_pcnt,le.populated_status_effective_dt_pcnt,le.populated_status_renewal_desc_pcnt,le.populated_status_other_agency_pcnt,le.populated_prim_range_pcnt,le.populated_predir_pcnt,le.populated_prim_name_pcnt,le.populated_suffix_pcnt,le.populated_postdir_pcnt,le.populated_unit_desig_pcnt,le.populated_sec_range_pcnt,le.populated_p_city_name_pcnt,le.populated_v_city_name_pcnt,le.populated_st_pcnt,le.populated_zip_pcnt,le.populated_zip4_pcnt,le.populated_cart_pcnt,le.populated_cr_sort_sz_pcnt,le.populated_lot_pcnt,le.populated_lot_order_pcnt,le.populated_dpbc_pcnt,le.populated_chk_digit_pcnt,le.populated_record_type_pcnt,le.populated_ace_fips_st_pcnt,le.populated_county_pcnt,le.populated_geo_lat_pcnt,le.populated_geo_long_pcnt,le.populated_msa_pcnt,le.populated_geo_blk_pcnt,le.populated_geo_match_pcnt,le.populated_err_stat_pcnt,le.populated_title_pcnt,le.populated_fname_pcnt,le.populated_mname_pcnt,le.populated_lname_pcnt,le.populated_name_suffix_pcnt,le.populated_pl_score_in_pcnt,le.populated_prep_addr_line1_pcnt,le.populated_prep_addr_last_line_pcnt,le.populated_rawaid_pcnt,le.populated_aceaid_pcnt,le.populated_county_name_pcnt,le.populated_did_pcnt,le.populated_score_pcnt,le.populated_best_ssn_pcnt,le.populated_bdid_pcnt,le.populated_source_rec_id_pcnt,le.populated_dotid_pcnt,le.populated_dotscore_pcnt,le.populated_dotweight_pcnt,le.populated_empid_pcnt,le.populated_empscore_pcnt,le.populated_empweight_pcnt,le.populated_powid_pcnt,le.populated_powscore_pcnt,le.populated_powweight_pcnt,le.populated_proxid_pcnt,le.populated_proxscore_pcnt,le.populated_proxweight_pcnt,le.populated_seleid_pcnt,le.populated_selescore_pcnt,le.populated_seleweight_pcnt,le.populated_orgid_pcnt,le.populated_orgscore_pcnt,le.populated_orgweight_pcnt,le.populated_ultid_pcnt,le.populated_ultscore_pcnt,le.populated_ultweight_pcnt,le.populated_lnpid_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_prolic_key,le.maxlength_date_first_seen,le.maxlength_date_last_seen,le.maxlength_profession_or_board,le.maxlength_license_type,le.maxlength_status,le.maxlength_orig_license_number,le.maxlength_license_number,le.maxlength_previous_license_number,le.maxlength_previous_license_type,le.maxlength_company_name,le.maxlength_orig_name,le.maxlength_name_order,le.maxlength_orig_former_name,le.maxlength_former_name_order,le.maxlength_orig_addr_1,le.maxlength_orig_addr_2,le.maxlength_orig_addr_3,le.maxlength_orig_addr_4,le.maxlength_orig_city,le.maxlength_orig_st,le.maxlength_orig_zip,le.maxlength_county_str,le.maxlength_country_str,le.maxlength_business_flag,le.maxlength_phone,le.maxlength_sex,le.maxlength_dob,le.maxlength_issue_date,le.maxlength_expiration_date,le.maxlength_last_renewal_date,le.maxlength_license_obtained_by,le.maxlength_board_action_indicator,le.maxlength_source_st,le.maxlength_vendor,le.maxlength_action_record_type,le.maxlength_action_complaint_violation_cds,le.maxlength_action_complaint_violation_desc,le.maxlength_action_complaint_violation_dt,le.maxlength_action_case_number,le.maxlength_action_effective_dt,le.maxlength_action_cds,le.maxlength_action_desc,le.maxlength_action_final_order_no,le.maxlength_action_status,le.maxlength_action_posting_status_dt,le.maxlength_action_original_filename_or_url,le.maxlength_additional_name_addr_type,le.maxlength_additional_orig_name,le.maxlength_additional_name_order,le.maxlength_additional_orig_additional_1,le.maxlength_additional_orig_additional_2,le.maxlength_additional_orig_additional_3,le.maxlength_additional_orig_additional_4,le.maxlength_additional_orig_city,le.maxlength_additional_orig_st,le.maxlength_additional_orig_zip,le.maxlength_additional_phone,le.maxlength_misc_occupation,le.maxlength_misc_practice_hours,le.maxlength_misc_practice_type,le.maxlength_misc_email,le.maxlength_misc_fax,le.maxlength_misc_web_site,le.maxlength_misc_other_id,le.maxlength_misc_other_id_type,le.maxlength_education_continuing_education,le.maxlength_education_1_school_attended,le.maxlength_education_1_dates_attended,le.maxlength_education_1_curriculum,le.maxlength_education_1_degree,le.maxlength_education_2_school_attended,le.maxlength_education_2_dates_attended,le.maxlength_education_2_curriculum,le.maxlength_education_2_degree,le.maxlength_education_3_school_attended,le.maxlength_education_3_dates_attended,le.maxlength_education_3_curriculum,le.maxlength_education_3_degree,le.maxlength_additional_licensing_specifics,le.maxlength_personal_pob_cd,le.maxlength_personal_pob_desc,le.maxlength_personal_race_cd,le.maxlength_personal_race_desc,le.maxlength_status_status_cds,le.maxlength_status_effective_dt,le.maxlength_status_renewal_desc,le.maxlength_status_other_agency,le.maxlength_prim_range,le.maxlength_predir,le.maxlength_prim_name,le.maxlength_suffix,le.maxlength_postdir,le.maxlength_unit_desig,le.maxlength_sec_range,le.maxlength_p_city_name,le.maxlength_v_city_name,le.maxlength_st,le.maxlength_zip,le.maxlength_zip4,le.maxlength_cart,le.maxlength_cr_sort_sz,le.maxlength_lot,le.maxlength_lot_order,le.maxlength_dpbc,le.maxlength_chk_digit,le.maxlength_record_type,le.maxlength_ace_fips_st,le.maxlength_county,le.maxlength_geo_lat,le.maxlength_geo_long,le.maxlength_msa,le.maxlength_geo_blk,le.maxlength_geo_match,le.maxlength_err_stat,le.maxlength_title,le.maxlength_fname,le.maxlength_mname,le.maxlength_lname,le.maxlength_name_suffix,le.maxlength_pl_score_in,le.maxlength_prep_addr_line1,le.maxlength_prep_addr_last_line,le.maxlength_rawaid,le.maxlength_aceaid,le.maxlength_county_name,le.maxlength_did,le.maxlength_score,le.maxlength_best_ssn,le.maxlength_bdid,le.maxlength_source_rec_id,le.maxlength_dotid,le.maxlength_dotscore,le.maxlength_dotweight,le.maxlength_empid,le.maxlength_empscore,le.maxlength_empweight,le.maxlength_powid,le.maxlength_powscore,le.maxlength_powweight,le.maxlength_proxid,le.maxlength_proxscore,le.maxlength_proxweight,le.maxlength_seleid,le.maxlength_selescore,le.maxlength_seleweight,le.maxlength_orgid,le.maxlength_orgscore,le.maxlength_orgweight,le.maxlength_ultid,le.maxlength_ultscore,le.maxlength_ultweight,le.maxlength_lnpid);
  SELF.avelength := CHOOSE(C,le.avelength_prolic_key,le.avelength_date_first_seen,le.avelength_date_last_seen,le.avelength_profession_or_board,le.avelength_license_type,le.avelength_status,le.avelength_orig_license_number,le.avelength_license_number,le.avelength_previous_license_number,le.avelength_previous_license_type,le.avelength_company_name,le.avelength_orig_name,le.avelength_name_order,le.avelength_orig_former_name,le.avelength_former_name_order,le.avelength_orig_addr_1,le.avelength_orig_addr_2,le.avelength_orig_addr_3,le.avelength_orig_addr_4,le.avelength_orig_city,le.avelength_orig_st,le.avelength_orig_zip,le.avelength_county_str,le.avelength_country_str,le.avelength_business_flag,le.avelength_phone,le.avelength_sex,le.avelength_dob,le.avelength_issue_date,le.avelength_expiration_date,le.avelength_last_renewal_date,le.avelength_license_obtained_by,le.avelength_board_action_indicator,le.avelength_source_st,le.avelength_vendor,le.avelength_action_record_type,le.avelength_action_complaint_violation_cds,le.avelength_action_complaint_violation_desc,le.avelength_action_complaint_violation_dt,le.avelength_action_case_number,le.avelength_action_effective_dt,le.avelength_action_cds,le.avelength_action_desc,le.avelength_action_final_order_no,le.avelength_action_status,le.avelength_action_posting_status_dt,le.avelength_action_original_filename_or_url,le.avelength_additional_name_addr_type,le.avelength_additional_orig_name,le.avelength_additional_name_order,le.avelength_additional_orig_additional_1,le.avelength_additional_orig_additional_2,le.avelength_additional_orig_additional_3,le.avelength_additional_orig_additional_4,le.avelength_additional_orig_city,le.avelength_additional_orig_st,le.avelength_additional_orig_zip,le.avelength_additional_phone,le.avelength_misc_occupation,le.avelength_misc_practice_hours,le.avelength_misc_practice_type,le.avelength_misc_email,le.avelength_misc_fax,le.avelength_misc_web_site,le.avelength_misc_other_id,le.avelength_misc_other_id_type,le.avelength_education_continuing_education,le.avelength_education_1_school_attended,le.avelength_education_1_dates_attended,le.avelength_education_1_curriculum,le.avelength_education_1_degree,le.avelength_education_2_school_attended,le.avelength_education_2_dates_attended,le.avelength_education_2_curriculum,le.avelength_education_2_degree,le.avelength_education_3_school_attended,le.avelength_education_3_dates_attended,le.avelength_education_3_curriculum,le.avelength_education_3_degree,le.avelength_additional_licensing_specifics,le.avelength_personal_pob_cd,le.avelength_personal_pob_desc,le.avelength_personal_race_cd,le.avelength_personal_race_desc,le.avelength_status_status_cds,le.avelength_status_effective_dt,le.avelength_status_renewal_desc,le.avelength_status_other_agency,le.avelength_prim_range,le.avelength_predir,le.avelength_prim_name,le.avelength_suffix,le.avelength_postdir,le.avelength_unit_desig,le.avelength_sec_range,le.avelength_p_city_name,le.avelength_v_city_name,le.avelength_st,le.avelength_zip,le.avelength_zip4,le.avelength_cart,le.avelength_cr_sort_sz,le.avelength_lot,le.avelength_lot_order,le.avelength_dpbc,le.avelength_chk_digit,le.avelength_record_type,le.avelength_ace_fips_st,le.avelength_county,le.avelength_geo_lat,le.avelength_geo_long,le.avelength_msa,le.avelength_geo_blk,le.avelength_geo_match,le.avelength_err_stat,le.avelength_title,le.avelength_fname,le.avelength_mname,le.avelength_lname,le.avelength_name_suffix,le.avelength_pl_score_in,le.avelength_prep_addr_line1,le.avelength_prep_addr_last_line,le.avelength_rawaid,le.avelength_aceaid,le.avelength_county_name,le.avelength_did,le.avelength_score,le.avelength_best_ssn,le.avelength_bdid,le.avelength_source_rec_id,le.avelength_dotid,le.avelength_dotscore,le.avelength_dotweight,le.avelength_empid,le.avelength_empscore,le.avelength_empweight,le.avelength_powid,le.avelength_powscore,le.avelength_powweight,le.avelength_proxid,le.avelength_proxscore,le.avelength_proxweight,le.avelength_seleid,le.avelength_selescore,le.avelength_seleweight,le.avelength_orgid,le.avelength_orgscore,le.avelength_orgweight,le.avelength_ultid,le.avelength_ultscore,le.avelength_ultweight,le.avelength_lnpid);
END;
EXPORT invSummary := NORMALIZE(summary0, 153, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT37.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT37.StrType)le.prolic_key),TRIM((SALT37.StrType)le.date_first_seen),TRIM((SALT37.StrType)le.date_last_seen),TRIM((SALT37.StrType)le.profession_or_board),TRIM((SALT37.StrType)le.license_type),TRIM((SALT37.StrType)le.status),TRIM((SALT37.StrType)le.orig_license_number),TRIM((SALT37.StrType)le.license_number),TRIM((SALT37.StrType)le.previous_license_number),TRIM((SALT37.StrType)le.previous_license_type),TRIM((SALT37.StrType)le.company_name),TRIM((SALT37.StrType)le.orig_name),TRIM((SALT37.StrType)le.name_order),TRIM((SALT37.StrType)le.orig_former_name),TRIM((SALT37.StrType)le.former_name_order),TRIM((SALT37.StrType)le.orig_addr_1),TRIM((SALT37.StrType)le.orig_addr_2),TRIM((SALT37.StrType)le.orig_addr_3),TRIM((SALT37.StrType)le.orig_addr_4),TRIM((SALT37.StrType)le.orig_city),TRIM((SALT37.StrType)le.orig_st),TRIM((SALT37.StrType)le.orig_zip),TRIM((SALT37.StrType)le.county_str),TRIM((SALT37.StrType)le.country_str),TRIM((SALT37.StrType)le.business_flag),TRIM((SALT37.StrType)le.phone),TRIM((SALT37.StrType)le.sex),TRIM((SALT37.StrType)le.dob),TRIM((SALT37.StrType)le.issue_date),TRIM((SALT37.StrType)le.expiration_date),TRIM((SALT37.StrType)le.last_renewal_date),TRIM((SALT37.StrType)le.license_obtained_by),TRIM((SALT37.StrType)le.board_action_indicator),TRIM((SALT37.StrType)le.source_st),TRIM((SALT37.StrType)le.vendor),TRIM((SALT37.StrType)le.action_record_type),TRIM((SALT37.StrType)le.action_complaint_violation_cds),TRIM((SALT37.StrType)le.action_complaint_violation_desc),TRIM((SALT37.StrType)le.action_complaint_violation_dt),TRIM((SALT37.StrType)le.action_case_number),TRIM((SALT37.StrType)le.action_effective_dt),TRIM((SALT37.StrType)le.action_cds),TRIM((SALT37.StrType)le.action_desc),TRIM((SALT37.StrType)le.action_final_order_no),TRIM((SALT37.StrType)le.action_status),TRIM((SALT37.StrType)le.action_posting_status_dt),TRIM((SALT37.StrType)le.action_original_filename_or_url),TRIM((SALT37.StrType)le.additional_name_addr_type),TRIM((SALT37.StrType)le.additional_orig_name),TRIM((SALT37.StrType)le.additional_name_order),TRIM((SALT37.StrType)le.additional_orig_additional_1),TRIM((SALT37.StrType)le.additional_orig_additional_2),TRIM((SALT37.StrType)le.additional_orig_additional_3),TRIM((SALT37.StrType)le.additional_orig_additional_4),TRIM((SALT37.StrType)le.additional_orig_city),TRIM((SALT37.StrType)le.additional_orig_st),TRIM((SALT37.StrType)le.additional_orig_zip),TRIM((SALT37.StrType)le.additional_phone),TRIM((SALT37.StrType)le.misc_occupation),TRIM((SALT37.StrType)le.misc_practice_hours),TRIM((SALT37.StrType)le.misc_practice_type),TRIM((SALT37.StrType)le.misc_email),TRIM((SALT37.StrType)le.misc_fax),TRIM((SALT37.StrType)le.misc_web_site),TRIM((SALT37.StrType)le.misc_other_id),TRIM((SALT37.StrType)le.misc_other_id_type),TRIM((SALT37.StrType)le.education_continuing_education),TRIM((SALT37.StrType)le.education_1_school_attended),TRIM((SALT37.StrType)le.education_1_dates_attended),TRIM((SALT37.StrType)le.education_1_curriculum),TRIM((SALT37.StrType)le.education_1_degree),TRIM((SALT37.StrType)le.education_2_school_attended),TRIM((SALT37.StrType)le.education_2_dates_attended),TRIM((SALT37.StrType)le.education_2_curriculum),TRIM((SALT37.StrType)le.education_2_degree),TRIM((SALT37.StrType)le.education_3_school_attended),TRIM((SALT37.StrType)le.education_3_dates_attended),TRIM((SALT37.StrType)le.education_3_curriculum),TRIM((SALT37.StrType)le.education_3_degree),TRIM((SALT37.StrType)le.additional_licensing_specifics),TRIM((SALT37.StrType)le.personal_pob_cd),TRIM((SALT37.StrType)le.personal_pob_desc),TRIM((SALT37.StrType)le.personal_race_cd),TRIM((SALT37.StrType)le.personal_race_desc),TRIM((SALT37.StrType)le.status_status_cds),TRIM((SALT37.StrType)le.status_effective_dt),TRIM((SALT37.StrType)le.status_renewal_desc),TRIM((SALT37.StrType)le.status_other_agency),TRIM((SALT37.StrType)le.prim_range),TRIM((SALT37.StrType)le.predir),TRIM((SALT37.StrType)le.prim_name),TRIM((SALT37.StrType)le.suffix),TRIM((SALT37.StrType)le.postdir),TRIM((SALT37.StrType)le.unit_desig),TRIM((SALT37.StrType)le.sec_range),TRIM((SALT37.StrType)le.p_city_name),TRIM((SALT37.StrType)le.v_city_name),TRIM((SALT37.StrType)le.st),TRIM((SALT37.StrType)le.zip),TRIM((SALT37.StrType)le.zip4),TRIM((SALT37.StrType)le.cart),TRIM((SALT37.StrType)le.cr_sort_sz),TRIM((SALT37.StrType)le.lot),TRIM((SALT37.StrType)le.lot_order),TRIM((SALT37.StrType)le.dpbc),TRIM((SALT37.StrType)le.chk_digit),TRIM((SALT37.StrType)le.record_type),TRIM((SALT37.StrType)le.ace_fips_st),TRIM((SALT37.StrType)le.county),TRIM((SALT37.StrType)le.geo_lat),TRIM((SALT37.StrType)le.geo_long),TRIM((SALT37.StrType)le.msa),TRIM((SALT37.StrType)le.geo_blk),TRIM((SALT37.StrType)le.geo_match),TRIM((SALT37.StrType)le.err_stat),TRIM((SALT37.StrType)le.title),TRIM((SALT37.StrType)le.fname),TRIM((SALT37.StrType)le.mname),TRIM((SALT37.StrType)le.lname),TRIM((SALT37.StrType)le.name_suffix),TRIM((SALT37.StrType)le.pl_score_in),TRIM((SALT37.StrType)le.prep_addr_line1),TRIM((SALT37.StrType)le.prep_addr_last_line),IF (le.rawaid <> 0,TRIM((SALT37.StrType)le.rawaid), ''),IF (le.aceaid <> 0,TRIM((SALT37.StrType)le.aceaid), ''),TRIM((SALT37.StrType)le.county_name),TRIM((SALT37.StrType)le.did),TRIM((SALT37.StrType)le.score),TRIM((SALT37.StrType)le.best_ssn),TRIM((SALT37.StrType)le.bdid),IF (le.source_rec_id <> 0,TRIM((SALT37.StrType)le.source_rec_id), ''),IF (le.dotid <> 0,TRIM((SALT37.StrType)le.dotid), ''),IF (le.dotscore <> 0,TRIM((SALT37.StrType)le.dotscore), ''),IF (le.dotweight <> 0,TRIM((SALT37.StrType)le.dotweight), ''),IF (le.empid <> 0,TRIM((SALT37.StrType)le.empid), ''),IF (le.empscore <> 0,TRIM((SALT37.StrType)le.empscore), ''),IF (le.empweight <> 0,TRIM((SALT37.StrType)le.empweight), ''),IF (le.powid <> 0,TRIM((SALT37.StrType)le.powid), ''),IF (le.powscore <> 0,TRIM((SALT37.StrType)le.powscore), ''),IF (le.powweight <> 0,TRIM((SALT37.StrType)le.powweight), ''),IF (le.proxid <> 0,TRIM((SALT37.StrType)le.proxid), ''),IF (le.proxscore <> 0,TRIM((SALT37.StrType)le.proxscore), ''),IF (le.proxweight <> 0,TRIM((SALT37.StrType)le.proxweight), ''),IF (le.seleid <> 0,TRIM((SALT37.StrType)le.seleid), ''),IF (le.selescore <> 0,TRIM((SALT37.StrType)le.selescore), ''),IF (le.seleweight <> 0,TRIM((SALT37.StrType)le.seleweight), ''),IF (le.orgid <> 0,TRIM((SALT37.StrType)le.orgid), ''),IF (le.orgscore <> 0,TRIM((SALT37.StrType)le.orgscore), ''),IF (le.orgweight <> 0,TRIM((SALT37.StrType)le.orgweight), ''),IF (le.ultid <> 0,TRIM((SALT37.StrType)le.ultid), ''),IF (le.ultscore <> 0,TRIM((SALT37.StrType)le.ultscore), ''),IF (le.ultweight <> 0,TRIM((SALT37.StrType)le.ultweight), ''),IF (le.lnpid <> 0,TRIM((SALT37.StrType)le.lnpid), '')));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,153,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT37.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 153);
  SELF.FldNo2 := 1 + (C % 153);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT37.StrType)le.prolic_key),TRIM((SALT37.StrType)le.date_first_seen),TRIM((SALT37.StrType)le.date_last_seen),TRIM((SALT37.StrType)le.profession_or_board),TRIM((SALT37.StrType)le.license_type),TRIM((SALT37.StrType)le.status),TRIM((SALT37.StrType)le.orig_license_number),TRIM((SALT37.StrType)le.license_number),TRIM((SALT37.StrType)le.previous_license_number),TRIM((SALT37.StrType)le.previous_license_type),TRIM((SALT37.StrType)le.company_name),TRIM((SALT37.StrType)le.orig_name),TRIM((SALT37.StrType)le.name_order),TRIM((SALT37.StrType)le.orig_former_name),TRIM((SALT37.StrType)le.former_name_order),TRIM((SALT37.StrType)le.orig_addr_1),TRIM((SALT37.StrType)le.orig_addr_2),TRIM((SALT37.StrType)le.orig_addr_3),TRIM((SALT37.StrType)le.orig_addr_4),TRIM((SALT37.StrType)le.orig_city),TRIM((SALT37.StrType)le.orig_st),TRIM((SALT37.StrType)le.orig_zip),TRIM((SALT37.StrType)le.county_str),TRIM((SALT37.StrType)le.country_str),TRIM((SALT37.StrType)le.business_flag),TRIM((SALT37.StrType)le.phone),TRIM((SALT37.StrType)le.sex),TRIM((SALT37.StrType)le.dob),TRIM((SALT37.StrType)le.issue_date),TRIM((SALT37.StrType)le.expiration_date),TRIM((SALT37.StrType)le.last_renewal_date),TRIM((SALT37.StrType)le.license_obtained_by),TRIM((SALT37.StrType)le.board_action_indicator),TRIM((SALT37.StrType)le.source_st),TRIM((SALT37.StrType)le.vendor),TRIM((SALT37.StrType)le.action_record_type),TRIM((SALT37.StrType)le.action_complaint_violation_cds),TRIM((SALT37.StrType)le.action_complaint_violation_desc),TRIM((SALT37.StrType)le.action_complaint_violation_dt),TRIM((SALT37.StrType)le.action_case_number),TRIM((SALT37.StrType)le.action_effective_dt),TRIM((SALT37.StrType)le.action_cds),TRIM((SALT37.StrType)le.action_desc),TRIM((SALT37.StrType)le.action_final_order_no),TRIM((SALT37.StrType)le.action_status),TRIM((SALT37.StrType)le.action_posting_status_dt),TRIM((SALT37.StrType)le.action_original_filename_or_url),TRIM((SALT37.StrType)le.additional_name_addr_type),TRIM((SALT37.StrType)le.additional_orig_name),TRIM((SALT37.StrType)le.additional_name_order),TRIM((SALT37.StrType)le.additional_orig_additional_1),TRIM((SALT37.StrType)le.additional_orig_additional_2),TRIM((SALT37.StrType)le.additional_orig_additional_3),TRIM((SALT37.StrType)le.additional_orig_additional_4),TRIM((SALT37.StrType)le.additional_orig_city),TRIM((SALT37.StrType)le.additional_orig_st),TRIM((SALT37.StrType)le.additional_orig_zip),TRIM((SALT37.StrType)le.additional_phone),TRIM((SALT37.StrType)le.misc_occupation),TRIM((SALT37.StrType)le.misc_practice_hours),TRIM((SALT37.StrType)le.misc_practice_type),TRIM((SALT37.StrType)le.misc_email),TRIM((SALT37.StrType)le.misc_fax),TRIM((SALT37.StrType)le.misc_web_site),TRIM((SALT37.StrType)le.misc_other_id),TRIM((SALT37.StrType)le.misc_other_id_type),TRIM((SALT37.StrType)le.education_continuing_education),TRIM((SALT37.StrType)le.education_1_school_attended),TRIM((SALT37.StrType)le.education_1_dates_attended),TRIM((SALT37.StrType)le.education_1_curriculum),TRIM((SALT37.StrType)le.education_1_degree),TRIM((SALT37.StrType)le.education_2_school_attended),TRIM((SALT37.StrType)le.education_2_dates_attended),TRIM((SALT37.StrType)le.education_2_curriculum),TRIM((SALT37.StrType)le.education_2_degree),TRIM((SALT37.StrType)le.education_3_school_attended),TRIM((SALT37.StrType)le.education_3_dates_attended),TRIM((SALT37.StrType)le.education_3_curriculum),TRIM((SALT37.StrType)le.education_3_degree),TRIM((SALT37.StrType)le.additional_licensing_specifics),TRIM((SALT37.StrType)le.personal_pob_cd),TRIM((SALT37.StrType)le.personal_pob_desc),TRIM((SALT37.StrType)le.personal_race_cd),TRIM((SALT37.StrType)le.personal_race_desc),TRIM((SALT37.StrType)le.status_status_cds),TRIM((SALT37.StrType)le.status_effective_dt),TRIM((SALT37.StrType)le.status_renewal_desc),TRIM((SALT37.StrType)le.status_other_agency),TRIM((SALT37.StrType)le.prim_range),TRIM((SALT37.StrType)le.predir),TRIM((SALT37.StrType)le.prim_name),TRIM((SALT37.StrType)le.suffix),TRIM((SALT37.StrType)le.postdir),TRIM((SALT37.StrType)le.unit_desig),TRIM((SALT37.StrType)le.sec_range),TRIM((SALT37.StrType)le.p_city_name),TRIM((SALT37.StrType)le.v_city_name),TRIM((SALT37.StrType)le.st),TRIM((SALT37.StrType)le.zip),TRIM((SALT37.StrType)le.zip4),TRIM((SALT37.StrType)le.cart),TRIM((SALT37.StrType)le.cr_sort_sz),TRIM((SALT37.StrType)le.lot),TRIM((SALT37.StrType)le.lot_order),TRIM((SALT37.StrType)le.dpbc),TRIM((SALT37.StrType)le.chk_digit),TRIM((SALT37.StrType)le.record_type),TRIM((SALT37.StrType)le.ace_fips_st),TRIM((SALT37.StrType)le.county),TRIM((SALT37.StrType)le.geo_lat),TRIM((SALT37.StrType)le.geo_long),TRIM((SALT37.StrType)le.msa),TRIM((SALT37.StrType)le.geo_blk),TRIM((SALT37.StrType)le.geo_match),TRIM((SALT37.StrType)le.err_stat),TRIM((SALT37.StrType)le.title),TRIM((SALT37.StrType)le.fname),TRIM((SALT37.StrType)le.mname),TRIM((SALT37.StrType)le.lname),TRIM((SALT37.StrType)le.name_suffix),TRIM((SALT37.StrType)le.pl_score_in),TRIM((SALT37.StrType)le.prep_addr_line1),TRIM((SALT37.StrType)le.prep_addr_last_line),IF (le.rawaid <> 0,TRIM((SALT37.StrType)le.rawaid), ''),IF (le.aceaid <> 0,TRIM((SALT37.StrType)le.aceaid), ''),TRIM((SALT37.StrType)le.county_name),TRIM((SALT37.StrType)le.did),TRIM((SALT37.StrType)le.score),TRIM((SALT37.StrType)le.best_ssn),TRIM((SALT37.StrType)le.bdid),IF (le.source_rec_id <> 0,TRIM((SALT37.StrType)le.source_rec_id), ''),IF (le.dotid <> 0,TRIM((SALT37.StrType)le.dotid), ''),IF (le.dotscore <> 0,TRIM((SALT37.StrType)le.dotscore), ''),IF (le.dotweight <> 0,TRIM((SALT37.StrType)le.dotweight), ''),IF (le.empid <> 0,TRIM((SALT37.StrType)le.empid), ''),IF (le.empscore <> 0,TRIM((SALT37.StrType)le.empscore), ''),IF (le.empweight <> 0,TRIM((SALT37.StrType)le.empweight), ''),IF (le.powid <> 0,TRIM((SALT37.StrType)le.powid), ''),IF (le.powscore <> 0,TRIM((SALT37.StrType)le.powscore), ''),IF (le.powweight <> 0,TRIM((SALT37.StrType)le.powweight), ''),IF (le.proxid <> 0,TRIM((SALT37.StrType)le.proxid), ''),IF (le.proxscore <> 0,TRIM((SALT37.StrType)le.proxscore), ''),IF (le.proxweight <> 0,TRIM((SALT37.StrType)le.proxweight), ''),IF (le.seleid <> 0,TRIM((SALT37.StrType)le.seleid), ''),IF (le.selescore <> 0,TRIM((SALT37.StrType)le.selescore), ''),IF (le.seleweight <> 0,TRIM((SALT37.StrType)le.seleweight), ''),IF (le.orgid <> 0,TRIM((SALT37.StrType)le.orgid), ''),IF (le.orgscore <> 0,TRIM((SALT37.StrType)le.orgscore), ''),IF (le.orgweight <> 0,TRIM((SALT37.StrType)le.orgweight), ''),IF (le.ultid <> 0,TRIM((SALT37.StrType)le.ultid), ''),IF (le.ultscore <> 0,TRIM((SALT37.StrType)le.ultscore), ''),IF (le.ultweight <> 0,TRIM((SALT37.StrType)le.ultweight), ''),IF (le.lnpid <> 0,TRIM((SALT37.StrType)le.lnpid), '')));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT37.StrType)le.prolic_key),TRIM((SALT37.StrType)le.date_first_seen),TRIM((SALT37.StrType)le.date_last_seen),TRIM((SALT37.StrType)le.profession_or_board),TRIM((SALT37.StrType)le.license_type),TRIM((SALT37.StrType)le.status),TRIM((SALT37.StrType)le.orig_license_number),TRIM((SALT37.StrType)le.license_number),TRIM((SALT37.StrType)le.previous_license_number),TRIM((SALT37.StrType)le.previous_license_type),TRIM((SALT37.StrType)le.company_name),TRIM((SALT37.StrType)le.orig_name),TRIM((SALT37.StrType)le.name_order),TRIM((SALT37.StrType)le.orig_former_name),TRIM((SALT37.StrType)le.former_name_order),TRIM((SALT37.StrType)le.orig_addr_1),TRIM((SALT37.StrType)le.orig_addr_2),TRIM((SALT37.StrType)le.orig_addr_3),TRIM((SALT37.StrType)le.orig_addr_4),TRIM((SALT37.StrType)le.orig_city),TRIM((SALT37.StrType)le.orig_st),TRIM((SALT37.StrType)le.orig_zip),TRIM((SALT37.StrType)le.county_str),TRIM((SALT37.StrType)le.country_str),TRIM((SALT37.StrType)le.business_flag),TRIM((SALT37.StrType)le.phone),TRIM((SALT37.StrType)le.sex),TRIM((SALT37.StrType)le.dob),TRIM((SALT37.StrType)le.issue_date),TRIM((SALT37.StrType)le.expiration_date),TRIM((SALT37.StrType)le.last_renewal_date),TRIM((SALT37.StrType)le.license_obtained_by),TRIM((SALT37.StrType)le.board_action_indicator),TRIM((SALT37.StrType)le.source_st),TRIM((SALT37.StrType)le.vendor),TRIM((SALT37.StrType)le.action_record_type),TRIM((SALT37.StrType)le.action_complaint_violation_cds),TRIM((SALT37.StrType)le.action_complaint_violation_desc),TRIM((SALT37.StrType)le.action_complaint_violation_dt),TRIM((SALT37.StrType)le.action_case_number),TRIM((SALT37.StrType)le.action_effective_dt),TRIM((SALT37.StrType)le.action_cds),TRIM((SALT37.StrType)le.action_desc),TRIM((SALT37.StrType)le.action_final_order_no),TRIM((SALT37.StrType)le.action_status),TRIM((SALT37.StrType)le.action_posting_status_dt),TRIM((SALT37.StrType)le.action_original_filename_or_url),TRIM((SALT37.StrType)le.additional_name_addr_type),TRIM((SALT37.StrType)le.additional_orig_name),TRIM((SALT37.StrType)le.additional_name_order),TRIM((SALT37.StrType)le.additional_orig_additional_1),TRIM((SALT37.StrType)le.additional_orig_additional_2),TRIM((SALT37.StrType)le.additional_orig_additional_3),TRIM((SALT37.StrType)le.additional_orig_additional_4),TRIM((SALT37.StrType)le.additional_orig_city),TRIM((SALT37.StrType)le.additional_orig_st),TRIM((SALT37.StrType)le.additional_orig_zip),TRIM((SALT37.StrType)le.additional_phone),TRIM((SALT37.StrType)le.misc_occupation),TRIM((SALT37.StrType)le.misc_practice_hours),TRIM((SALT37.StrType)le.misc_practice_type),TRIM((SALT37.StrType)le.misc_email),TRIM((SALT37.StrType)le.misc_fax),TRIM((SALT37.StrType)le.misc_web_site),TRIM((SALT37.StrType)le.misc_other_id),TRIM((SALT37.StrType)le.misc_other_id_type),TRIM((SALT37.StrType)le.education_continuing_education),TRIM((SALT37.StrType)le.education_1_school_attended),TRIM((SALT37.StrType)le.education_1_dates_attended),TRIM((SALT37.StrType)le.education_1_curriculum),TRIM((SALT37.StrType)le.education_1_degree),TRIM((SALT37.StrType)le.education_2_school_attended),TRIM((SALT37.StrType)le.education_2_dates_attended),TRIM((SALT37.StrType)le.education_2_curriculum),TRIM((SALT37.StrType)le.education_2_degree),TRIM((SALT37.StrType)le.education_3_school_attended),TRIM((SALT37.StrType)le.education_3_dates_attended),TRIM((SALT37.StrType)le.education_3_curriculum),TRIM((SALT37.StrType)le.education_3_degree),TRIM((SALT37.StrType)le.additional_licensing_specifics),TRIM((SALT37.StrType)le.personal_pob_cd),TRIM((SALT37.StrType)le.personal_pob_desc),TRIM((SALT37.StrType)le.personal_race_cd),TRIM((SALT37.StrType)le.personal_race_desc),TRIM((SALT37.StrType)le.status_status_cds),TRIM((SALT37.StrType)le.status_effective_dt),TRIM((SALT37.StrType)le.status_renewal_desc),TRIM((SALT37.StrType)le.status_other_agency),TRIM((SALT37.StrType)le.prim_range),TRIM((SALT37.StrType)le.predir),TRIM((SALT37.StrType)le.prim_name),TRIM((SALT37.StrType)le.suffix),TRIM((SALT37.StrType)le.postdir),TRIM((SALT37.StrType)le.unit_desig),TRIM((SALT37.StrType)le.sec_range),TRIM((SALT37.StrType)le.p_city_name),TRIM((SALT37.StrType)le.v_city_name),TRIM((SALT37.StrType)le.st),TRIM((SALT37.StrType)le.zip),TRIM((SALT37.StrType)le.zip4),TRIM((SALT37.StrType)le.cart),TRIM((SALT37.StrType)le.cr_sort_sz),TRIM((SALT37.StrType)le.lot),TRIM((SALT37.StrType)le.lot_order),TRIM((SALT37.StrType)le.dpbc),TRIM((SALT37.StrType)le.chk_digit),TRIM((SALT37.StrType)le.record_type),TRIM((SALT37.StrType)le.ace_fips_st),TRIM((SALT37.StrType)le.county),TRIM((SALT37.StrType)le.geo_lat),TRIM((SALT37.StrType)le.geo_long),TRIM((SALT37.StrType)le.msa),TRIM((SALT37.StrType)le.geo_blk),TRIM((SALT37.StrType)le.geo_match),TRIM((SALT37.StrType)le.err_stat),TRIM((SALT37.StrType)le.title),TRIM((SALT37.StrType)le.fname),TRIM((SALT37.StrType)le.mname),TRIM((SALT37.StrType)le.lname),TRIM((SALT37.StrType)le.name_suffix),TRIM((SALT37.StrType)le.pl_score_in),TRIM((SALT37.StrType)le.prep_addr_line1),TRIM((SALT37.StrType)le.prep_addr_last_line),IF (le.rawaid <> 0,TRIM((SALT37.StrType)le.rawaid), ''),IF (le.aceaid <> 0,TRIM((SALT37.StrType)le.aceaid), ''),TRIM((SALT37.StrType)le.county_name),TRIM((SALT37.StrType)le.did),TRIM((SALT37.StrType)le.score),TRIM((SALT37.StrType)le.best_ssn),TRIM((SALT37.StrType)le.bdid),IF (le.source_rec_id <> 0,TRIM((SALT37.StrType)le.source_rec_id), ''),IF (le.dotid <> 0,TRIM((SALT37.StrType)le.dotid), ''),IF (le.dotscore <> 0,TRIM((SALT37.StrType)le.dotscore), ''),IF (le.dotweight <> 0,TRIM((SALT37.StrType)le.dotweight), ''),IF (le.empid <> 0,TRIM((SALT37.StrType)le.empid), ''),IF (le.empscore <> 0,TRIM((SALT37.StrType)le.empscore), ''),IF (le.empweight <> 0,TRIM((SALT37.StrType)le.empweight), ''),IF (le.powid <> 0,TRIM((SALT37.StrType)le.powid), ''),IF (le.powscore <> 0,TRIM((SALT37.StrType)le.powscore), ''),IF (le.powweight <> 0,TRIM((SALT37.StrType)le.powweight), ''),IF (le.proxid <> 0,TRIM((SALT37.StrType)le.proxid), ''),IF (le.proxscore <> 0,TRIM((SALT37.StrType)le.proxscore), ''),IF (le.proxweight <> 0,TRIM((SALT37.StrType)le.proxweight), ''),IF (le.seleid <> 0,TRIM((SALT37.StrType)le.seleid), ''),IF (le.selescore <> 0,TRIM((SALT37.StrType)le.selescore), ''),IF (le.seleweight <> 0,TRIM((SALT37.StrType)le.seleweight), ''),IF (le.orgid <> 0,TRIM((SALT37.StrType)le.orgid), ''),IF (le.orgscore <> 0,TRIM((SALT37.StrType)le.orgscore), ''),IF (le.orgweight <> 0,TRIM((SALT37.StrType)le.orgweight), ''),IF (le.ultid <> 0,TRIM((SALT37.StrType)le.ultid), ''),IF (le.ultscore <> 0,TRIM((SALT37.StrType)le.ultscore), ''),IF (le.ultweight <> 0,TRIM((SALT37.StrType)le.ultweight), ''),IF (le.lnpid <> 0,TRIM((SALT37.StrType)le.lnpid), '')));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),153*153,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'prolic_key'}
      ,{2,'date_first_seen'}
      ,{3,'date_last_seen'}
      ,{4,'profession_or_board'}
      ,{5,'license_type'}
      ,{6,'status'}
      ,{7,'orig_license_number'}
      ,{8,'license_number'}
      ,{9,'previous_license_number'}
      ,{10,'previous_license_type'}
      ,{11,'company_name'}
      ,{12,'orig_name'}
      ,{13,'name_order'}
      ,{14,'orig_former_name'}
      ,{15,'former_name_order'}
      ,{16,'orig_addr_1'}
      ,{17,'orig_addr_2'}
      ,{18,'orig_addr_3'}
      ,{19,'orig_addr_4'}
      ,{20,'orig_city'}
      ,{21,'orig_st'}
      ,{22,'orig_zip'}
      ,{23,'county_str'}
      ,{24,'country_str'}
      ,{25,'business_flag'}
      ,{26,'phone'}
      ,{27,'sex'}
      ,{28,'dob'}
      ,{29,'issue_date'}
      ,{30,'expiration_date'}
      ,{31,'last_renewal_date'}
      ,{32,'license_obtained_by'}
      ,{33,'board_action_indicator'}
      ,{34,'source_st'}
      ,{35,'vendor'}
      ,{36,'action_record_type'}
      ,{37,'action_complaint_violation_cds'}
      ,{38,'action_complaint_violation_desc'}
      ,{39,'action_complaint_violation_dt'}
      ,{40,'action_case_number'}
      ,{41,'action_effective_dt'}
      ,{42,'action_cds'}
      ,{43,'action_desc'}
      ,{44,'action_final_order_no'}
      ,{45,'action_status'}
      ,{46,'action_posting_status_dt'}
      ,{47,'action_original_filename_or_url'}
      ,{48,'additional_name_addr_type'}
      ,{49,'additional_orig_name'}
      ,{50,'additional_name_order'}
      ,{51,'additional_orig_additional_1'}
      ,{52,'additional_orig_additional_2'}
      ,{53,'additional_orig_additional_3'}
      ,{54,'additional_orig_additional_4'}
      ,{55,'additional_orig_city'}
      ,{56,'additional_orig_st'}
      ,{57,'additional_orig_zip'}
      ,{58,'additional_phone'}
      ,{59,'misc_occupation'}
      ,{60,'misc_practice_hours'}
      ,{61,'misc_practice_type'}
      ,{62,'misc_email'}
      ,{63,'misc_fax'}
      ,{64,'misc_web_site'}
      ,{65,'misc_other_id'}
      ,{66,'misc_other_id_type'}
      ,{67,'education_continuing_education'}
      ,{68,'education_1_school_attended'}
      ,{69,'education_1_dates_attended'}
      ,{70,'education_1_curriculum'}
      ,{71,'education_1_degree'}
      ,{72,'education_2_school_attended'}
      ,{73,'education_2_dates_attended'}
      ,{74,'education_2_curriculum'}
      ,{75,'education_2_degree'}
      ,{76,'education_3_school_attended'}
      ,{77,'education_3_dates_attended'}
      ,{78,'education_3_curriculum'}
      ,{79,'education_3_degree'}
      ,{80,'additional_licensing_specifics'}
      ,{81,'personal_pob_cd'}
      ,{82,'personal_pob_desc'}
      ,{83,'personal_race_cd'}
      ,{84,'personal_race_desc'}
      ,{85,'status_status_cds'}
      ,{86,'status_effective_dt'}
      ,{87,'status_renewal_desc'}
      ,{88,'status_other_agency'}
      ,{89,'prim_range'}
      ,{90,'predir'}
      ,{91,'prim_name'}
      ,{92,'suffix'}
      ,{93,'postdir'}
      ,{94,'unit_desig'}
      ,{95,'sec_range'}
      ,{96,'p_city_name'}
      ,{97,'v_city_name'}
      ,{98,'st'}
      ,{99,'zip'}
      ,{100,'zip4'}
      ,{101,'cart'}
      ,{102,'cr_sort_sz'}
      ,{103,'lot'}
      ,{104,'lot_order'}
      ,{105,'dpbc'}
      ,{106,'chk_digit'}
      ,{107,'record_type'}
      ,{108,'ace_fips_st'}
      ,{109,'county'}
      ,{110,'geo_lat'}
      ,{111,'geo_long'}
      ,{112,'msa'}
      ,{113,'geo_blk'}
      ,{114,'geo_match'}
      ,{115,'err_stat'}
      ,{116,'title'}
      ,{117,'fname'}
      ,{118,'mname'}
      ,{119,'lname'}
      ,{120,'name_suffix'}
      ,{121,'pl_score_in'}
      ,{122,'prep_addr_line1'}
      ,{123,'prep_addr_last_line'}
      ,{124,'rawaid'}
      ,{125,'aceaid'}
      ,{126,'county_name'}
      ,{127,'did'}
      ,{128,'score'}
      ,{129,'best_ssn'}
      ,{130,'bdid'}
      ,{131,'source_rec_id'}
      ,{132,'dotid'}
      ,{133,'dotscore'}
      ,{134,'dotweight'}
      ,{135,'empid'}
      ,{136,'empscore'}
      ,{137,'empweight'}
      ,{138,'powid'}
      ,{139,'powscore'}
      ,{140,'powweight'}
      ,{141,'proxid'}
      ,{142,'proxscore'}
      ,{143,'proxweight'}
      ,{144,'seleid'}
      ,{145,'selescore'}
      ,{146,'seleweight'}
      ,{147,'orgid'}
      ,{148,'orgscore'}
      ,{149,'orgweight'}
      ,{150,'ultid'}
      ,{151,'ultscore'}
      ,{152,'ultweight'}
      ,{153,'lnpid'}],SALT37.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT37.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT37.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT37.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Base_Fields.InValid_prolic_key((SALT37.StrType)le.prolic_key),
    Base_Fields.InValid_date_first_seen((SALT37.StrType)le.date_first_seen),
    Base_Fields.InValid_date_last_seen((SALT37.StrType)le.date_last_seen),
    Base_Fields.InValid_profession_or_board((SALT37.StrType)le.profession_or_board),
    Base_Fields.InValid_license_type((SALT37.StrType)le.license_type),
    Base_Fields.InValid_status((SALT37.StrType)le.status),
    Base_Fields.InValid_orig_license_number((SALT37.StrType)le.orig_license_number),
    Base_Fields.InValid_license_number((SALT37.StrType)le.license_number),
    Base_Fields.InValid_previous_license_number((SALT37.StrType)le.previous_license_number),
    Base_Fields.InValid_previous_license_type((SALT37.StrType)le.previous_license_type),
    Base_Fields.InValid_company_name((SALT37.StrType)le.company_name),
    Base_Fields.InValid_orig_name((SALT37.StrType)le.orig_name),
    Base_Fields.InValid_name_order((SALT37.StrType)le.name_order),
    Base_Fields.InValid_orig_former_name((SALT37.StrType)le.orig_former_name),
    Base_Fields.InValid_former_name_order((SALT37.StrType)le.former_name_order),
    Base_Fields.InValid_orig_addr_1((SALT37.StrType)le.orig_addr_1),
    Base_Fields.InValid_orig_addr_2((SALT37.StrType)le.orig_addr_2),
    Base_Fields.InValid_orig_addr_3((SALT37.StrType)le.orig_addr_3),
    Base_Fields.InValid_orig_addr_4((SALT37.StrType)le.orig_addr_4),
    Base_Fields.InValid_orig_city((SALT37.StrType)le.orig_city),
    Base_Fields.InValid_orig_st((SALT37.StrType)le.orig_st),
    Base_Fields.InValid_orig_zip((SALT37.StrType)le.orig_zip),
    Base_Fields.InValid_county_str((SALT37.StrType)le.county_str),
    Base_Fields.InValid_country_str((SALT37.StrType)le.country_str),
    Base_Fields.InValid_business_flag((SALT37.StrType)le.business_flag),
    Base_Fields.InValid_phone((SALT37.StrType)le.phone),
    Base_Fields.InValid_sex((SALT37.StrType)le.sex),
    Base_Fields.InValid_dob((SALT37.StrType)le.dob),
    Base_Fields.InValid_issue_date((SALT37.StrType)le.issue_date),
    Base_Fields.InValid_expiration_date((SALT37.StrType)le.expiration_date),
    Base_Fields.InValid_last_renewal_date((SALT37.StrType)le.last_renewal_date),
    Base_Fields.InValid_license_obtained_by((SALT37.StrType)le.license_obtained_by),
    Base_Fields.InValid_board_action_indicator((SALT37.StrType)le.board_action_indicator),
    Base_Fields.InValid_source_st((SALT37.StrType)le.source_st),
    Base_Fields.InValid_vendor((SALT37.StrType)le.vendor),
    Base_Fields.InValid_action_record_type((SALT37.StrType)le.action_record_type),
    Base_Fields.InValid_action_complaint_violation_cds((SALT37.StrType)le.action_complaint_violation_cds),
    Base_Fields.InValid_action_complaint_violation_desc((SALT37.StrType)le.action_complaint_violation_desc),
    Base_Fields.InValid_action_complaint_violation_dt((SALT37.StrType)le.action_complaint_violation_dt),
    Base_Fields.InValid_action_case_number((SALT37.StrType)le.action_case_number),
    Base_Fields.InValid_action_effective_dt((SALT37.StrType)le.action_effective_dt),
    Base_Fields.InValid_action_cds((SALT37.StrType)le.action_cds),
    Base_Fields.InValid_action_desc((SALT37.StrType)le.action_desc),
    Base_Fields.InValid_action_final_order_no((SALT37.StrType)le.action_final_order_no),
    Base_Fields.InValid_action_status((SALT37.StrType)le.action_status),
    Base_Fields.InValid_action_posting_status_dt((SALT37.StrType)le.action_posting_status_dt),
    Base_Fields.InValid_action_original_filename_or_url((SALT37.StrType)le.action_original_filename_or_url),
    Base_Fields.InValid_additional_name_addr_type((SALT37.StrType)le.additional_name_addr_type),
    Base_Fields.InValid_additional_orig_name((SALT37.StrType)le.additional_orig_name),
    Base_Fields.InValid_additional_name_order((SALT37.StrType)le.additional_name_order),
    Base_Fields.InValid_additional_orig_additional_1((SALT37.StrType)le.additional_orig_additional_1),
    Base_Fields.InValid_additional_orig_additional_2((SALT37.StrType)le.additional_orig_additional_2),
    Base_Fields.InValid_additional_orig_additional_3((SALT37.StrType)le.additional_orig_additional_3),
    Base_Fields.InValid_additional_orig_additional_4((SALT37.StrType)le.additional_orig_additional_4),
    Base_Fields.InValid_additional_orig_city((SALT37.StrType)le.additional_orig_city),
    Base_Fields.InValid_additional_orig_st((SALT37.StrType)le.additional_orig_st),
    Base_Fields.InValid_additional_orig_zip((SALT37.StrType)le.additional_orig_zip),
    Base_Fields.InValid_additional_phone((SALT37.StrType)le.additional_phone),
    Base_Fields.InValid_misc_occupation((SALT37.StrType)le.misc_occupation),
    Base_Fields.InValid_misc_practice_hours((SALT37.StrType)le.misc_practice_hours),
    Base_Fields.InValid_misc_practice_type((SALT37.StrType)le.misc_practice_type),
    Base_Fields.InValid_misc_email((SALT37.StrType)le.misc_email),
    Base_Fields.InValid_misc_fax((SALT37.StrType)le.misc_fax),
    Base_Fields.InValid_misc_web_site((SALT37.StrType)le.misc_web_site),
    Base_Fields.InValid_misc_other_id((SALT37.StrType)le.misc_other_id),
    Base_Fields.InValid_misc_other_id_type((SALT37.StrType)le.misc_other_id_type),
    Base_Fields.InValid_education_continuing_education((SALT37.StrType)le.education_continuing_education),
    Base_Fields.InValid_education_1_school_attended((SALT37.StrType)le.education_1_school_attended),
    Base_Fields.InValid_education_1_dates_attended((SALT37.StrType)le.education_1_dates_attended),
    Base_Fields.InValid_education_1_curriculum((SALT37.StrType)le.education_1_curriculum),
    Base_Fields.InValid_education_1_degree((SALT37.StrType)le.education_1_degree),
    Base_Fields.InValid_education_2_school_attended((SALT37.StrType)le.education_2_school_attended),
    Base_Fields.InValid_education_2_dates_attended((SALT37.StrType)le.education_2_dates_attended),
    Base_Fields.InValid_education_2_curriculum((SALT37.StrType)le.education_2_curriculum),
    Base_Fields.InValid_education_2_degree((SALT37.StrType)le.education_2_degree),
    Base_Fields.InValid_education_3_school_attended((SALT37.StrType)le.education_3_school_attended),
    Base_Fields.InValid_education_3_dates_attended((SALT37.StrType)le.education_3_dates_attended),
    Base_Fields.InValid_education_3_curriculum((SALT37.StrType)le.education_3_curriculum),
    Base_Fields.InValid_education_3_degree((SALT37.StrType)le.education_3_degree),
    Base_Fields.InValid_additional_licensing_specifics((SALT37.StrType)le.additional_licensing_specifics),
    Base_Fields.InValid_personal_pob_cd((SALT37.StrType)le.personal_pob_cd),
    Base_Fields.InValid_personal_pob_desc((SALT37.StrType)le.personal_pob_desc),
    Base_Fields.InValid_personal_race_cd((SALT37.StrType)le.personal_race_cd),
    Base_Fields.InValid_personal_race_desc((SALT37.StrType)le.personal_race_desc),
    Base_Fields.InValid_status_status_cds((SALT37.StrType)le.status_status_cds),
    Base_Fields.InValid_status_effective_dt((SALT37.StrType)le.status_effective_dt),
    Base_Fields.InValid_status_renewal_desc((SALT37.StrType)le.status_renewal_desc),
    Base_Fields.InValid_status_other_agency((SALT37.StrType)le.status_other_agency),
    Base_Fields.InValid_prim_range((SALT37.StrType)le.prim_range),
    Base_Fields.InValid_predir((SALT37.StrType)le.predir),
    Base_Fields.InValid_prim_name((SALT37.StrType)le.prim_name),
    Base_Fields.InValid_suffix((SALT37.StrType)le.suffix),
    Base_Fields.InValid_postdir((SALT37.StrType)le.postdir),
    Base_Fields.InValid_unit_desig((SALT37.StrType)le.unit_desig),
    Base_Fields.InValid_sec_range((SALT37.StrType)le.sec_range),
    Base_Fields.InValid_p_city_name((SALT37.StrType)le.p_city_name),
    Base_Fields.InValid_v_city_name((SALT37.StrType)le.v_city_name),
    Base_Fields.InValid_st((SALT37.StrType)le.st),
    Base_Fields.InValid_zip((SALT37.StrType)le.zip),
    Base_Fields.InValid_zip4((SALT37.StrType)le.zip4),
    Base_Fields.InValid_cart((SALT37.StrType)le.cart),
    Base_Fields.InValid_cr_sort_sz((SALT37.StrType)le.cr_sort_sz),
    Base_Fields.InValid_lot((SALT37.StrType)le.lot),
    Base_Fields.InValid_lot_order((SALT37.StrType)le.lot_order),
    Base_Fields.InValid_dpbc((SALT37.StrType)le.dpbc),
    Base_Fields.InValid_chk_digit((SALT37.StrType)le.chk_digit),
    Base_Fields.InValid_record_type((SALT37.StrType)le.record_type),
    Base_Fields.InValid_ace_fips_st((SALT37.StrType)le.ace_fips_st),
    Base_Fields.InValid_county((SALT37.StrType)le.county),
    Base_Fields.InValid_geo_lat((SALT37.StrType)le.geo_lat),
    Base_Fields.InValid_geo_long((SALT37.StrType)le.geo_long),
    Base_Fields.InValid_msa((SALT37.StrType)le.msa),
    Base_Fields.InValid_geo_blk((SALT37.StrType)le.geo_blk),
    Base_Fields.InValid_geo_match((SALT37.StrType)le.geo_match),
    Base_Fields.InValid_err_stat((SALT37.StrType)le.err_stat),
    Base_Fields.InValid_title((SALT37.StrType)le.title),
    Base_Fields.InValid_fname((SALT37.StrType)le.fname),
    Base_Fields.InValid_mname((SALT37.StrType)le.mname),
    Base_Fields.InValid_lname((SALT37.StrType)le.lname),
    Base_Fields.InValid_name_suffix((SALT37.StrType)le.name_suffix),
    Base_Fields.InValid_pl_score_in((SALT37.StrType)le.pl_score_in),
    Base_Fields.InValid_prep_addr_line1((SALT37.StrType)le.prep_addr_line1),
    Base_Fields.InValid_prep_addr_last_line((SALT37.StrType)le.prep_addr_last_line),
    Base_Fields.InValid_rawaid((SALT37.StrType)le.rawaid),
    Base_Fields.InValid_aceaid((SALT37.StrType)le.aceaid),
    Base_Fields.InValid_county_name((SALT37.StrType)le.county_name),
    Base_Fields.InValid_did((SALT37.StrType)le.did),
    Base_Fields.InValid_score((SALT37.StrType)le.score),
    Base_Fields.InValid_best_ssn((SALT37.StrType)le.best_ssn),
    Base_Fields.InValid_bdid((SALT37.StrType)le.bdid),
    Base_Fields.InValid_source_rec_id((SALT37.StrType)le.source_rec_id),
    Base_Fields.InValid_dotid((SALT37.StrType)le.dotid),
    Base_Fields.InValid_dotscore((SALT37.StrType)le.dotscore),
    Base_Fields.InValid_dotweight((SALT37.StrType)le.dotweight),
    Base_Fields.InValid_empid((SALT37.StrType)le.empid),
    Base_Fields.InValid_empscore((SALT37.StrType)le.empscore),
    Base_Fields.InValid_empweight((SALT37.StrType)le.empweight),
    Base_Fields.InValid_powid((SALT37.StrType)le.powid),
    Base_Fields.InValid_powscore((SALT37.StrType)le.powscore),
    Base_Fields.InValid_powweight((SALT37.StrType)le.powweight),
    Base_Fields.InValid_proxid((SALT37.StrType)le.proxid),
    Base_Fields.InValid_proxscore((SALT37.StrType)le.proxscore),
    Base_Fields.InValid_proxweight((SALT37.StrType)le.proxweight),
    Base_Fields.InValid_seleid((SALT37.StrType)le.seleid),
    Base_Fields.InValid_selescore((SALT37.StrType)le.selescore),
    Base_Fields.InValid_seleweight((SALT37.StrType)le.seleweight),
    Base_Fields.InValid_orgid((SALT37.StrType)le.orgid),
    Base_Fields.InValid_orgscore((SALT37.StrType)le.orgscore),
    Base_Fields.InValid_orgweight((SALT37.StrType)le.orgweight),
    Base_Fields.InValid_ultid((SALT37.StrType)le.ultid),
    Base_Fields.InValid_ultscore((SALT37.StrType)le.ultscore),
    Base_Fields.InValid_ultweight((SALT37.StrType)le.ultweight),
    Base_Fields.InValid_lnpid((SALT37.StrType)le.lnpid),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,153,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Base_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid_prolic_key','invalid_068pastdate','invalid_068pastdate','invalid_profession_or_board','invalid_license_type','invalid_status','invalid_prolic_key','invalid_prolic_key','invalid_numeric','invalid_license_type','Unknown','Unknown','invalid_name_order','Unknown','invalid_name_order','Unknown','Unknown','Unknown','Unknown','invalid_orig_city','invalid_alpha','invalid_orig_zip','Unknown','Unknown','invalid_yn','invalid_phone','invalid_sex','invalid_0468pastdate','invalid_0468date','invalid_0468date','invalid_past_date','invalid_license_obtained_by','invalid_yn','invalid_alpha','invalid_vendor','invalid_nonprintable','invalid_nonprintable','Unknown','invalid_past_date','invalid_action_case_number','invalid_past_date','invalid_alpha','Unknown','invalid_nonprintable','invalid_action_status','invalid_past_date','Unknown','invalid_additional_name_addr_type','Unknown','invalid_name_order','Unknown','Unknown','Unknown','Unknown','invalid_orig_city','invalid_alpha','invalid_orig_zip','invalid_additional_phone','invalid_misc_occupation','invalid_misc_practice_hours','invalid_misc_practice_type','Unknown','invalid_additional_phone','invalid_misc_web_site','invalid_nonprintable','invalid_misc_other_id_type','invalid_education_continuing_education','Unknown','invalid_education_dates_attended','invalid_education_curriculum','invalid_education_degree','Unknown','invalid_education_dates_attended','invalid_education_curriculum','invalid_education_degree','Unknown','invalid_education_dates_attended','invalid_education_curriculum','invalid_education_degree','Unknown','invalid_alpha','personal_pob_desc','invalid_alphanumeric','invalid_alphaspaceslash','invalid_alphanumerichyphen','invalid_past_date','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Base_Fields.InValidMessage_prolic_key(TotalErrors.ErrorNum),Base_Fields.InValidMessage_date_first_seen(TotalErrors.ErrorNum),Base_Fields.InValidMessage_date_last_seen(TotalErrors.ErrorNum),Base_Fields.InValidMessage_profession_or_board(TotalErrors.ErrorNum),Base_Fields.InValidMessage_license_type(TotalErrors.ErrorNum),Base_Fields.InValidMessage_status(TotalErrors.ErrorNum),Base_Fields.InValidMessage_orig_license_number(TotalErrors.ErrorNum),Base_Fields.InValidMessage_license_number(TotalErrors.ErrorNum),Base_Fields.InValidMessage_previous_license_number(TotalErrors.ErrorNum),Base_Fields.InValidMessage_previous_license_type(TotalErrors.ErrorNum),Base_Fields.InValidMessage_company_name(TotalErrors.ErrorNum),Base_Fields.InValidMessage_orig_name(TotalErrors.ErrorNum),Base_Fields.InValidMessage_name_order(TotalErrors.ErrorNum),Base_Fields.InValidMessage_orig_former_name(TotalErrors.ErrorNum),Base_Fields.InValidMessage_former_name_order(TotalErrors.ErrorNum),Base_Fields.InValidMessage_orig_addr_1(TotalErrors.ErrorNum),Base_Fields.InValidMessage_orig_addr_2(TotalErrors.ErrorNum),Base_Fields.InValidMessage_orig_addr_3(TotalErrors.ErrorNum),Base_Fields.InValidMessage_orig_addr_4(TotalErrors.ErrorNum),Base_Fields.InValidMessage_orig_city(TotalErrors.ErrorNum),Base_Fields.InValidMessage_orig_st(TotalErrors.ErrorNum),Base_Fields.InValidMessage_orig_zip(TotalErrors.ErrorNum),Base_Fields.InValidMessage_county_str(TotalErrors.ErrorNum),Base_Fields.InValidMessage_country_str(TotalErrors.ErrorNum),Base_Fields.InValidMessage_business_flag(TotalErrors.ErrorNum),Base_Fields.InValidMessage_phone(TotalErrors.ErrorNum),Base_Fields.InValidMessage_sex(TotalErrors.ErrorNum),Base_Fields.InValidMessage_dob(TotalErrors.ErrorNum),Base_Fields.InValidMessage_issue_date(TotalErrors.ErrorNum),Base_Fields.InValidMessage_expiration_date(TotalErrors.ErrorNum),Base_Fields.InValidMessage_last_renewal_date(TotalErrors.ErrorNum),Base_Fields.InValidMessage_license_obtained_by(TotalErrors.ErrorNum),Base_Fields.InValidMessage_board_action_indicator(TotalErrors.ErrorNum),Base_Fields.InValidMessage_source_st(TotalErrors.ErrorNum),Base_Fields.InValidMessage_vendor(TotalErrors.ErrorNum),Base_Fields.InValidMessage_action_record_type(TotalErrors.ErrorNum),Base_Fields.InValidMessage_action_complaint_violation_cds(TotalErrors.ErrorNum),Base_Fields.InValidMessage_action_complaint_violation_desc(TotalErrors.ErrorNum),Base_Fields.InValidMessage_action_complaint_violation_dt(TotalErrors.ErrorNum),Base_Fields.InValidMessage_action_case_number(TotalErrors.ErrorNum),Base_Fields.InValidMessage_action_effective_dt(TotalErrors.ErrorNum),Base_Fields.InValidMessage_action_cds(TotalErrors.ErrorNum),Base_Fields.InValidMessage_action_desc(TotalErrors.ErrorNum),Base_Fields.InValidMessage_action_final_order_no(TotalErrors.ErrorNum),Base_Fields.InValidMessage_action_status(TotalErrors.ErrorNum),Base_Fields.InValidMessage_action_posting_status_dt(TotalErrors.ErrorNum),Base_Fields.InValidMessage_action_original_filename_or_url(TotalErrors.ErrorNum),Base_Fields.InValidMessage_additional_name_addr_type(TotalErrors.ErrorNum),Base_Fields.InValidMessage_additional_orig_name(TotalErrors.ErrorNum),Base_Fields.InValidMessage_additional_name_order(TotalErrors.ErrorNum),Base_Fields.InValidMessage_additional_orig_additional_1(TotalErrors.ErrorNum),Base_Fields.InValidMessage_additional_orig_additional_2(TotalErrors.ErrorNum),Base_Fields.InValidMessage_additional_orig_additional_3(TotalErrors.ErrorNum),Base_Fields.InValidMessage_additional_orig_additional_4(TotalErrors.ErrorNum),Base_Fields.InValidMessage_additional_orig_city(TotalErrors.ErrorNum),Base_Fields.InValidMessage_additional_orig_st(TotalErrors.ErrorNum),Base_Fields.InValidMessage_additional_orig_zip(TotalErrors.ErrorNum),Base_Fields.InValidMessage_additional_phone(TotalErrors.ErrorNum),Base_Fields.InValidMessage_misc_occupation(TotalErrors.ErrorNum),Base_Fields.InValidMessage_misc_practice_hours(TotalErrors.ErrorNum),Base_Fields.InValidMessage_misc_practice_type(TotalErrors.ErrorNum),Base_Fields.InValidMessage_misc_email(TotalErrors.ErrorNum),Base_Fields.InValidMessage_misc_fax(TotalErrors.ErrorNum),Base_Fields.InValidMessage_misc_web_site(TotalErrors.ErrorNum),Base_Fields.InValidMessage_misc_other_id(TotalErrors.ErrorNum),Base_Fields.InValidMessage_misc_other_id_type(TotalErrors.ErrorNum),Base_Fields.InValidMessage_education_continuing_education(TotalErrors.ErrorNum),Base_Fields.InValidMessage_education_1_school_attended(TotalErrors.ErrorNum),Base_Fields.InValidMessage_education_1_dates_attended(TotalErrors.ErrorNum),Base_Fields.InValidMessage_education_1_curriculum(TotalErrors.ErrorNum),Base_Fields.InValidMessage_education_1_degree(TotalErrors.ErrorNum),Base_Fields.InValidMessage_education_2_school_attended(TotalErrors.ErrorNum),Base_Fields.InValidMessage_education_2_dates_attended(TotalErrors.ErrorNum),Base_Fields.InValidMessage_education_2_curriculum(TotalErrors.ErrorNum),Base_Fields.InValidMessage_education_2_degree(TotalErrors.ErrorNum),Base_Fields.InValidMessage_education_3_school_attended(TotalErrors.ErrorNum),Base_Fields.InValidMessage_education_3_dates_attended(TotalErrors.ErrorNum),Base_Fields.InValidMessage_education_3_curriculum(TotalErrors.ErrorNum),Base_Fields.InValidMessage_education_3_degree(TotalErrors.ErrorNum),Base_Fields.InValidMessage_additional_licensing_specifics(TotalErrors.ErrorNum),Base_Fields.InValidMessage_personal_pob_cd(TotalErrors.ErrorNum),Base_Fields.InValidMessage_personal_pob_desc(TotalErrors.ErrorNum),Base_Fields.InValidMessage_personal_race_cd(TotalErrors.ErrorNum),Base_Fields.InValidMessage_personal_race_desc(TotalErrors.ErrorNum),Base_Fields.InValidMessage_status_status_cds(TotalErrors.ErrorNum),Base_Fields.InValidMessage_status_effective_dt(TotalErrors.ErrorNum),Base_Fields.InValidMessage_status_renewal_desc(TotalErrors.ErrorNum),Base_Fields.InValidMessage_status_other_agency(TotalErrors.ErrorNum),Base_Fields.InValidMessage_prim_range(TotalErrors.ErrorNum),Base_Fields.InValidMessage_predir(TotalErrors.ErrorNum),Base_Fields.InValidMessage_prim_name(TotalErrors.ErrorNum),Base_Fields.InValidMessage_suffix(TotalErrors.ErrorNum),Base_Fields.InValidMessage_postdir(TotalErrors.ErrorNum),Base_Fields.InValidMessage_unit_desig(TotalErrors.ErrorNum),Base_Fields.InValidMessage_sec_range(TotalErrors.ErrorNum),Base_Fields.InValidMessage_p_city_name(TotalErrors.ErrorNum),Base_Fields.InValidMessage_v_city_name(TotalErrors.ErrorNum),Base_Fields.InValidMessage_st(TotalErrors.ErrorNum),Base_Fields.InValidMessage_zip(TotalErrors.ErrorNum),Base_Fields.InValidMessage_zip4(TotalErrors.ErrorNum),Base_Fields.InValidMessage_cart(TotalErrors.ErrorNum),Base_Fields.InValidMessage_cr_sort_sz(TotalErrors.ErrorNum),Base_Fields.InValidMessage_lot(TotalErrors.ErrorNum),Base_Fields.InValidMessage_lot_order(TotalErrors.ErrorNum),Base_Fields.InValidMessage_dpbc(TotalErrors.ErrorNum),Base_Fields.InValidMessage_chk_digit(TotalErrors.ErrorNum),Base_Fields.InValidMessage_record_type(TotalErrors.ErrorNum),Base_Fields.InValidMessage_ace_fips_st(TotalErrors.ErrorNum),Base_Fields.InValidMessage_county(TotalErrors.ErrorNum),Base_Fields.InValidMessage_geo_lat(TotalErrors.ErrorNum),Base_Fields.InValidMessage_geo_long(TotalErrors.ErrorNum),Base_Fields.InValidMessage_msa(TotalErrors.ErrorNum),Base_Fields.InValidMessage_geo_blk(TotalErrors.ErrorNum),Base_Fields.InValidMessage_geo_match(TotalErrors.ErrorNum),Base_Fields.InValidMessage_err_stat(TotalErrors.ErrorNum),Base_Fields.InValidMessage_title(TotalErrors.ErrorNum),Base_Fields.InValidMessage_fname(TotalErrors.ErrorNum),Base_Fields.InValidMessage_mname(TotalErrors.ErrorNum),Base_Fields.InValidMessage_lname(TotalErrors.ErrorNum),Base_Fields.InValidMessage_name_suffix(TotalErrors.ErrorNum),Base_Fields.InValidMessage_pl_score_in(TotalErrors.ErrorNum),Base_Fields.InValidMessage_prep_addr_line1(TotalErrors.ErrorNum),Base_Fields.InValidMessage_prep_addr_last_line(TotalErrors.ErrorNum),Base_Fields.InValidMessage_rawaid(TotalErrors.ErrorNum),Base_Fields.InValidMessage_aceaid(TotalErrors.ErrorNum),Base_Fields.InValidMessage_county_name(TotalErrors.ErrorNum),Base_Fields.InValidMessage_did(TotalErrors.ErrorNum),Base_Fields.InValidMessage_score(TotalErrors.ErrorNum),Base_Fields.InValidMessage_best_ssn(TotalErrors.ErrorNum),Base_Fields.InValidMessage_bdid(TotalErrors.ErrorNum),Base_Fields.InValidMessage_source_rec_id(TotalErrors.ErrorNum),Base_Fields.InValidMessage_dotid(TotalErrors.ErrorNum),Base_Fields.InValidMessage_dotscore(TotalErrors.ErrorNum),Base_Fields.InValidMessage_dotweight(TotalErrors.ErrorNum),Base_Fields.InValidMessage_empid(TotalErrors.ErrorNum),Base_Fields.InValidMessage_empscore(TotalErrors.ErrorNum),Base_Fields.InValidMessage_empweight(TotalErrors.ErrorNum),Base_Fields.InValidMessage_powid(TotalErrors.ErrorNum),Base_Fields.InValidMessage_powscore(TotalErrors.ErrorNum),Base_Fields.InValidMessage_powweight(TotalErrors.ErrorNum),Base_Fields.InValidMessage_proxid(TotalErrors.ErrorNum),Base_Fields.InValidMessage_proxscore(TotalErrors.ErrorNum),Base_Fields.InValidMessage_proxweight(TotalErrors.ErrorNum),Base_Fields.InValidMessage_seleid(TotalErrors.ErrorNum),Base_Fields.InValidMessage_selescore(TotalErrors.ErrorNum),Base_Fields.InValidMessage_seleweight(TotalErrors.ErrorNum),Base_Fields.InValidMessage_orgid(TotalErrors.ErrorNum),Base_Fields.InValidMessage_orgscore(TotalErrors.ErrorNum),Base_Fields.InValidMessage_orgweight(TotalErrors.ErrorNum),Base_Fields.InValidMessage_ultid(TotalErrors.ErrorNum),Base_Fields.InValidMessage_ultscore(TotalErrors.ErrorNum),Base_Fields.InValidMessage_ultweight(TotalErrors.ErrorNum),Base_Fields.InValidMessage_lnpid(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
END;
