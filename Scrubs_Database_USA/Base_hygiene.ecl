IMPORT SALT311,STD;
EXPORT Base_hygiene(dataset(Scrubs_Database_USA.Base_Layout_Database_USA) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT311.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_dt_first_seen_cnt := COUNT(GROUP,h.dt_first_seen <> (TYPEOF(h.dt_first_seen))'');
    populated_dt_first_seen_pcnt := AVE(GROUP,IF(h.dt_first_seen = (TYPEOF(h.dt_first_seen))'',0,100));
    maxlength_dt_first_seen := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_first_seen)));
    avelength_dt_first_seen := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_first_seen)),h.dt_first_seen<>(typeof(h.dt_first_seen))'');
    populated_dt_last_seen_cnt := COUNT(GROUP,h.dt_last_seen <> (TYPEOF(h.dt_last_seen))'');
    populated_dt_last_seen_pcnt := AVE(GROUP,IF(h.dt_last_seen = (TYPEOF(h.dt_last_seen))'',0,100));
    maxlength_dt_last_seen := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_last_seen)));
    avelength_dt_last_seen := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_last_seen)),h.dt_last_seen<>(typeof(h.dt_last_seen))'');
    populated_dt_vendor_first_reported_cnt := COUNT(GROUP,h.dt_vendor_first_reported <> (TYPEOF(h.dt_vendor_first_reported))'');
    populated_dt_vendor_first_reported_pcnt := AVE(GROUP,IF(h.dt_vendor_first_reported = (TYPEOF(h.dt_vendor_first_reported))'',0,100));
    maxlength_dt_vendor_first_reported := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_vendor_first_reported)));
    avelength_dt_vendor_first_reported := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_vendor_first_reported)),h.dt_vendor_first_reported<>(typeof(h.dt_vendor_first_reported))'');
    populated_dt_vendor_last_reported_cnt := COUNT(GROUP,h.dt_vendor_last_reported <> (TYPEOF(h.dt_vendor_last_reported))'');
    populated_dt_vendor_last_reported_pcnt := AVE(GROUP,IF(h.dt_vendor_last_reported = (TYPEOF(h.dt_vendor_last_reported))'',0,100));
    maxlength_dt_vendor_last_reported := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_vendor_last_reported)));
    avelength_dt_vendor_last_reported := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_vendor_last_reported)),h.dt_vendor_last_reported<>(typeof(h.dt_vendor_last_reported))'');
    populated_process_date_cnt := COUNT(GROUP,h.process_date <> (TYPEOF(h.process_date))'');
    populated_process_date_pcnt := AVE(GROUP,IF(h.process_date = (TYPEOF(h.process_date))'',0,100));
    maxlength_process_date := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.process_date)));
    avelength_process_date := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.process_date)),h.process_date<>(typeof(h.process_date))'');
    populated_record_type_cnt := COUNT(GROUP,h.record_type <> (TYPEOF(h.record_type))'');
    populated_record_type_pcnt := AVE(GROUP,IF(h.record_type = (TYPEOF(h.record_type))'',0,100));
    maxlength_record_type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.record_type)));
    avelength_record_type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.record_type)),h.record_type<>(typeof(h.record_type))'');
    populated_ind_frm_indicator_cnt := COUNT(GROUP,h.ind_frm_indicator <> (TYPEOF(h.ind_frm_indicator))'');
    populated_ind_frm_indicator_pcnt := AVE(GROUP,IF(h.ind_frm_indicator = (TYPEOF(h.ind_frm_indicator))'',0,100));
    maxlength_ind_frm_indicator := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ind_frm_indicator)));
    avelength_ind_frm_indicator := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ind_frm_indicator)),h.ind_frm_indicator<>(typeof(h.ind_frm_indicator))'');
    populated_company_name_cnt := COUNT(GROUP,h.company_name <> (TYPEOF(h.company_name))'');
    populated_company_name_pcnt := AVE(GROUP,IF(h.company_name = (TYPEOF(h.company_name))'',0,100));
    maxlength_company_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_name)));
    avelength_company_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_name)),h.company_name<>(typeof(h.company_name))'');
    populated_full_name_cnt := COUNT(GROUP,h.full_name <> (TYPEOF(h.full_name))'');
    populated_full_name_pcnt := AVE(GROUP,IF(h.full_name = (TYPEOF(h.full_name))'',0,100));
    maxlength_full_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.full_name)));
    avelength_full_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.full_name)),h.full_name<>(typeof(h.full_name))'');
    populated_gender_cnt := COUNT(GROUP,h.gender <> (TYPEOF(h.gender))'');
    populated_gender_pcnt := AVE(GROUP,IF(h.gender = (TYPEOF(h.gender))'',0,100));
    maxlength_gender := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.gender)));
    avelength_gender := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.gender)),h.gender<>(typeof(h.gender))'');
    populated_primary_exec_flag_cnt := COUNT(GROUP,h.primary_exec_flag <> (TYPEOF(h.primary_exec_flag))'');
    populated_primary_exec_flag_pcnt := AVE(GROUP,IF(h.primary_exec_flag = (TYPEOF(h.primary_exec_flag))'',0,100));
    maxlength_primary_exec_flag := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.primary_exec_flag)));
    avelength_primary_exec_flag := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.primary_exec_flag)),h.primary_exec_flag<>(typeof(h.primary_exec_flag))'');
    populated_exec_type_cnt := COUNT(GROUP,h.exec_type <> (TYPEOF(h.exec_type))'');
    populated_exec_type_pcnt := AVE(GROUP,IF(h.exec_type = (TYPEOF(h.exec_type))'',0,100));
    maxlength_exec_type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.exec_type)));
    avelength_exec_type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.exec_type)),h.exec_type<>(typeof(h.exec_type))'');
    populated_phy_addr_state_cnt := COUNT(GROUP,h.phy_addr_state <> (TYPEOF(h.phy_addr_state))'');
    populated_phy_addr_state_pcnt := AVE(GROUP,IF(h.phy_addr_state = (TYPEOF(h.phy_addr_state))'',0,100));
    maxlength_phy_addr_state := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.phy_addr_state)));
    avelength_phy_addr_state := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.phy_addr_state)),h.phy_addr_state<>(typeof(h.phy_addr_state))'');
    populated_phy_addr_zip_cnt := COUNT(GROUP,h.phy_addr_zip <> (TYPEOF(h.phy_addr_zip))'');
    populated_phy_addr_zip_pcnt := AVE(GROUP,IF(h.phy_addr_zip = (TYPEOF(h.phy_addr_zip))'',0,100));
    maxlength_phy_addr_zip := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.phy_addr_zip)));
    avelength_phy_addr_zip := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.phy_addr_zip)),h.phy_addr_zip<>(typeof(h.phy_addr_zip))'');
    populated_mail_addr_state_cnt := COUNT(GROUP,h.mail_addr_state <> (TYPEOF(h.mail_addr_state))'');
    populated_mail_addr_state_pcnt := AVE(GROUP,IF(h.mail_addr_state = (TYPEOF(h.mail_addr_state))'',0,100));
    maxlength_mail_addr_state := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mail_addr_state)));
    avelength_mail_addr_state := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mail_addr_state)),h.mail_addr_state<>(typeof(h.mail_addr_state))'');
    populated_mail_addr_zip_cnt := COUNT(GROUP,h.mail_addr_zip <> (TYPEOF(h.mail_addr_zip))'');
    populated_mail_addr_zip_pcnt := AVE(GROUP,IF(h.mail_addr_zip = (TYPEOF(h.mail_addr_zip))'',0,100));
    maxlength_mail_addr_zip := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mail_addr_zip)));
    avelength_mail_addr_zip := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mail_addr_zip)),h.mail_addr_zip<>(typeof(h.mail_addr_zip))'');
    populated_mail_score_cnt := COUNT(GROUP,h.mail_score <> (TYPEOF(h.mail_score))'');
    populated_mail_score_pcnt := AVE(GROUP,IF(h.mail_score = (TYPEOF(h.mail_score))'',0,100));
    maxlength_mail_score := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mail_score)));
    avelength_mail_score := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mail_score)),h.mail_score<>(typeof(h.mail_score))'');
    populated_phone_cnt := COUNT(GROUP,h.phone <> (TYPEOF(h.phone))'');
    populated_phone_pcnt := AVE(GROUP,IF(h.phone = (TYPEOF(h.phone))'',0,100));
    maxlength_phone := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.phone)));
    avelength_phone := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.phone)),h.phone<>(typeof(h.phone))'');
    populated_email_cnt := COUNT(GROUP,h.email <> (TYPEOF(h.email))'');
    populated_email_pcnt := AVE(GROUP,IF(h.email = (TYPEOF(h.email))'',0,100));
    maxlength_email := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.email)));
    avelength_email := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.email)),h.email<>(typeof(h.email))'');
    populated_email_available_indicator_cnt := COUNT(GROUP,h.email_available_indicator <> (TYPEOF(h.email_available_indicator))'');
    populated_email_available_indicator_pcnt := AVE(GROUP,IF(h.email_available_indicator = (TYPEOF(h.email_available_indicator))'',0,100));
    maxlength_email_available_indicator := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.email_available_indicator)));
    avelength_email_available_indicator := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.email_available_indicator)),h.email_available_indicator<>(typeof(h.email_available_indicator))'');
    populated_url_cnt := COUNT(GROUP,h.url <> (TYPEOF(h.url))'');
    populated_url_pcnt := AVE(GROUP,IF(h.url = (TYPEOF(h.url))'',0,100));
    maxlength_url := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.url)));
    avelength_url := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.url)),h.url<>(typeof(h.url))'');
    populated_business_status_code_cnt := COUNT(GROUP,h.business_status_code <> (TYPEOF(h.business_status_code))'');
    populated_business_status_code_pcnt := AVE(GROUP,IF(h.business_status_code = (TYPEOF(h.business_status_code))'',0,100));
    maxlength_business_status_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.business_status_code)));
    avelength_business_status_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.business_status_code)),h.business_status_code<>(typeof(h.business_status_code))'');
    populated_franchise_flag_cnt := COUNT(GROUP,h.franchise_flag <> (TYPEOF(h.franchise_flag))'');
    populated_franchise_flag_pcnt := AVE(GROUP,IF(h.franchise_flag = (TYPEOF(h.franchise_flag))'',0,100));
    maxlength_franchise_flag := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.franchise_flag)));
    avelength_franchise_flag := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.franchise_flag)),h.franchise_flag<>(typeof(h.franchise_flag))'');
    populated_franchise_type_cnt := COUNT(GROUP,h.franchise_type <> (TYPEOF(h.franchise_type))'');
    populated_franchise_type_pcnt := AVE(GROUP,IF(h.franchise_type = (TYPEOF(h.franchise_type))'',0,100));
    maxlength_franchise_type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.franchise_type)));
    avelength_franchise_type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.franchise_type)),h.franchise_type<>(typeof(h.franchise_type))'');
    populated_county_code_cnt := COUNT(GROUP,h.county_code <> (TYPEOF(h.county_code))'');
    populated_county_code_pcnt := AVE(GROUP,IF(h.county_code = (TYPEOF(h.county_code))'',0,100));
    maxlength_county_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.county_code)));
    avelength_county_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.county_code)),h.county_code<>(typeof(h.county_code))'');
    populated_primary_sic_cnt := COUNT(GROUP,h.primary_sic <> (TYPEOF(h.primary_sic))'');
    populated_primary_sic_pcnt := AVE(GROUP,IF(h.primary_sic = (TYPEOF(h.primary_sic))'',0,100));
    maxlength_primary_sic := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.primary_sic)));
    avelength_primary_sic := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.primary_sic)),h.primary_sic<>(typeof(h.primary_sic))'');
    populated_sic02_cnt := COUNT(GROUP,h.sic02 <> (TYPEOF(h.sic02))'');
    populated_sic02_pcnt := AVE(GROUP,IF(h.sic02 = (TYPEOF(h.sic02))'',0,100));
    maxlength_sic02 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sic02)));
    avelength_sic02 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sic02)),h.sic02<>(typeof(h.sic02))'');
    populated_sic03_cnt := COUNT(GROUP,h.sic03 <> (TYPEOF(h.sic03))'');
    populated_sic03_pcnt := AVE(GROUP,IF(h.sic03 = (TYPEOF(h.sic03))'',0,100));
    maxlength_sic03 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sic03)));
    avelength_sic03 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sic03)),h.sic03<>(typeof(h.sic03))'');
    populated_sic04_cnt := COUNT(GROUP,h.sic04 <> (TYPEOF(h.sic04))'');
    populated_sic04_pcnt := AVE(GROUP,IF(h.sic04 = (TYPEOF(h.sic04))'',0,100));
    maxlength_sic04 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sic04)));
    avelength_sic04 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sic04)),h.sic04<>(typeof(h.sic04))'');
    populated_sic05_cnt := COUNT(GROUP,h.sic05 <> (TYPEOF(h.sic05))'');
    populated_sic05_pcnt := AVE(GROUP,IF(h.sic05 = (TYPEOF(h.sic05))'',0,100));
    maxlength_sic05 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sic05)));
    avelength_sic05 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sic05)),h.sic05<>(typeof(h.sic05))'');
    populated_sic06_cnt := COUNT(GROUP,h.sic06 <> (TYPEOF(h.sic06))'');
    populated_sic06_pcnt := AVE(GROUP,IF(h.sic06 = (TYPEOF(h.sic06))'',0,100));
    maxlength_sic06 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sic06)));
    avelength_sic06 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sic06)),h.sic06<>(typeof(h.sic06))'');
    populated_primarysic2_cnt := COUNT(GROUP,h.primarysic2 <> (TYPEOF(h.primarysic2))'');
    populated_primarysic2_pcnt := AVE(GROUP,IF(h.primarysic2 = (TYPEOF(h.primarysic2))'',0,100));
    maxlength_primarysic2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.primarysic2)));
    avelength_primarysic2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.primarysic2)),h.primarysic2<>(typeof(h.primarysic2))'');
    populated_primarysic4_cnt := COUNT(GROUP,h.primarysic4 <> (TYPEOF(h.primarysic4))'');
    populated_primarysic4_pcnt := AVE(GROUP,IF(h.primarysic4 = (TYPEOF(h.primarysic4))'',0,100));
    maxlength_primarysic4 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.primarysic4)));
    avelength_primarysic4 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.primarysic4)),h.primarysic4<>(typeof(h.primarysic4))'');
    populated_naics01_cnt := COUNT(GROUP,h.naics01 <> (TYPEOF(h.naics01))'');
    populated_naics01_pcnt := AVE(GROUP,IF(h.naics01 = (TYPEOF(h.naics01))'',0,100));
    maxlength_naics01 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.naics01)));
    avelength_naics01 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.naics01)),h.naics01<>(typeof(h.naics01))'');
    populated_naics02_cnt := COUNT(GROUP,h.naics02 <> (TYPEOF(h.naics02))'');
    populated_naics02_pcnt := AVE(GROUP,IF(h.naics02 = (TYPEOF(h.naics02))'',0,100));
    maxlength_naics02 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.naics02)));
    avelength_naics02 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.naics02)),h.naics02<>(typeof(h.naics02))'');
    populated_naics03_cnt := COUNT(GROUP,h.naics03 <> (TYPEOF(h.naics03))'');
    populated_naics03_pcnt := AVE(GROUP,IF(h.naics03 = (TYPEOF(h.naics03))'',0,100));
    maxlength_naics03 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.naics03)));
    avelength_naics03 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.naics03)),h.naics03<>(typeof(h.naics03))'');
    populated_naics04_cnt := COUNT(GROUP,h.naics04 <> (TYPEOF(h.naics04))'');
    populated_naics04_pcnt := AVE(GROUP,IF(h.naics04 = (TYPEOF(h.naics04))'',0,100));
    maxlength_naics04 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.naics04)));
    avelength_naics04 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.naics04)),h.naics04<>(typeof(h.naics04))'');
    populated_naics05_cnt := COUNT(GROUP,h.naics05 <> (TYPEOF(h.naics05))'');
    populated_naics05_pcnt := AVE(GROUP,IF(h.naics05 = (TYPEOF(h.naics05))'',0,100));
    maxlength_naics05 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.naics05)));
    avelength_naics05 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.naics05)),h.naics05<>(typeof(h.naics05))'');
    populated_naics06_cnt := COUNT(GROUP,h.naics06 <> (TYPEOF(h.naics06))'');
    populated_naics06_pcnt := AVE(GROUP,IF(h.naics06 = (TYPEOF(h.naics06))'',0,100));
    maxlength_naics06 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.naics06)));
    avelength_naics06 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.naics06)),h.naics06<>(typeof(h.naics06))'');
    populated_location_employee_code_cnt := COUNT(GROUP,h.location_employee_code <> (TYPEOF(h.location_employee_code))'');
    populated_location_employee_code_pcnt := AVE(GROUP,IF(h.location_employee_code = (TYPEOF(h.location_employee_code))'',0,100));
    maxlength_location_employee_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.location_employee_code)));
    avelength_location_employee_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.location_employee_code)),h.location_employee_code<>(typeof(h.location_employee_code))'');
    populated_location_sales_code_cnt := COUNT(GROUP,h.location_sales_code <> (TYPEOF(h.location_sales_code))'');
    populated_location_sales_code_pcnt := AVE(GROUP,IF(h.location_sales_code = (TYPEOF(h.location_sales_code))'',0,100));
    maxlength_location_sales_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.location_sales_code)));
    avelength_location_sales_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.location_sales_code)),h.location_sales_code<>(typeof(h.location_sales_code))'');
    populated_corporate_employee_code_cnt := COUNT(GROUP,h.corporate_employee_code <> (TYPEOF(h.corporate_employee_code))'');
    populated_corporate_employee_code_pcnt := AVE(GROUP,IF(h.corporate_employee_code = (TYPEOF(h.corporate_employee_code))'',0,100));
    maxlength_corporate_employee_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.corporate_employee_code)));
    avelength_corporate_employee_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.corporate_employee_code)),h.corporate_employee_code<>(typeof(h.corporate_employee_code))'');
    populated_year_established_cnt := COUNT(GROUP,h.year_established <> (TYPEOF(h.year_established))'');
    populated_year_established_pcnt := AVE(GROUP,IF(h.year_established = (TYPEOF(h.year_established))'',0,100));
    maxlength_year_established := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.year_established)));
    avelength_year_established := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.year_established)),h.year_established<>(typeof(h.year_established))'');
    populated_female_owned_cnt := COUNT(GROUP,h.female_owned <> (TYPEOF(h.female_owned))'');
    populated_female_owned_pcnt := AVE(GROUP,IF(h.female_owned = (TYPEOF(h.female_owned))'',0,100));
    maxlength_female_owned := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.female_owned)));
    avelength_female_owned := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.female_owned)),h.female_owned<>(typeof(h.female_owned))'');
    populated_minority_owned_flag_cnt := COUNT(GROUP,h.minority_owned_flag <> (TYPEOF(h.minority_owned_flag))'');
    populated_minority_owned_flag_pcnt := AVE(GROUP,IF(h.minority_owned_flag = (TYPEOF(h.minority_owned_flag))'',0,100));
    maxlength_minority_owned_flag := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.minority_owned_flag)));
    avelength_minority_owned_flag := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.minority_owned_flag)),h.minority_owned_flag<>(typeof(h.minority_owned_flag))'');
    populated_home_based_indicator_cnt := COUNT(GROUP,h.home_based_indicator <> (TYPEOF(h.home_based_indicator))'');
    populated_home_based_indicator_pcnt := AVE(GROUP,IF(h.home_based_indicator = (TYPEOF(h.home_based_indicator))'',0,100));
    maxlength_home_based_indicator := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.home_based_indicator)));
    avelength_home_based_indicator := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.home_based_indicator)),h.home_based_indicator<>(typeof(h.home_based_indicator))'');
    populated_small_business_indicator_cnt := COUNT(GROUP,h.small_business_indicator <> (TYPEOF(h.small_business_indicator))'');
    populated_small_business_indicator_pcnt := AVE(GROUP,IF(h.small_business_indicator = (TYPEOF(h.small_business_indicator))'',0,100));
    maxlength_small_business_indicator := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.small_business_indicator)));
    avelength_small_business_indicator := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.small_business_indicator)),h.small_business_indicator<>(typeof(h.small_business_indicator))'');
    populated_import_export_cnt := COUNT(GROUP,h.import_export <> (TYPEOF(h.import_export))'');
    populated_import_export_pcnt := AVE(GROUP,IF(h.import_export = (TYPEOF(h.import_export))'',0,100));
    maxlength_import_export := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.import_export)));
    avelength_import_export := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.import_export)),h.import_export<>(typeof(h.import_export))'');
    populated_manufacturing_location_cnt := COUNT(GROUP,h.manufacturing_location <> (TYPEOF(h.manufacturing_location))'');
    populated_manufacturing_location_pcnt := AVE(GROUP,IF(h.manufacturing_location = (TYPEOF(h.manufacturing_location))'',0,100));
    maxlength_manufacturing_location := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.manufacturing_location)));
    avelength_manufacturing_location := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.manufacturing_location)),h.manufacturing_location<>(typeof(h.manufacturing_location))'');
    populated_public_indicator_cnt := COUNT(GROUP,h.public_indicator <> (TYPEOF(h.public_indicator))'');
    populated_public_indicator_pcnt := AVE(GROUP,IF(h.public_indicator = (TYPEOF(h.public_indicator))'',0,100));
    maxlength_public_indicator := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.public_indicator)));
    avelength_public_indicator := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.public_indicator)),h.public_indicator<>(typeof(h.public_indicator))'');
    populated_non_profit_org_cnt := COUNT(GROUP,h.non_profit_org <> (TYPEOF(h.non_profit_org))'');
    populated_non_profit_org_pcnt := AVE(GROUP,IF(h.non_profit_org = (TYPEOF(h.non_profit_org))'',0,100));
    maxlength_non_profit_org := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.non_profit_org)));
    avelength_non_profit_org := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.non_profit_org)),h.non_profit_org<>(typeof(h.non_profit_org))'');
    populated_square_footage_code_cnt := COUNT(GROUP,h.square_footage_code <> (TYPEOF(h.square_footage_code))'');
    populated_square_footage_code_pcnt := AVE(GROUP,IF(h.square_footage_code = (TYPEOF(h.square_footage_code))'',0,100));
    maxlength_square_footage_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.square_footage_code)));
    avelength_square_footage_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.square_footage_code)),h.square_footage_code<>(typeof(h.square_footage_code))'');
    populated_creditcode_cnt := COUNT(GROUP,h.creditcode <> (TYPEOF(h.creditcode))'');
    populated_creditcode_pcnt := AVE(GROUP,IF(h.creditcode = (TYPEOF(h.creditcode))'',0,100));
    maxlength_creditcode := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.creditcode)));
    avelength_creditcode := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.creditcode)),h.creditcode<>(typeof(h.creditcode))'');
    populated_credit_capacity_code_cnt := COUNT(GROUP,h.credit_capacity_code <> (TYPEOF(h.credit_capacity_code))'');
    populated_credit_capacity_code_pcnt := AVE(GROUP,IF(h.credit_capacity_code = (TYPEOF(h.credit_capacity_code))'',0,100));
    maxlength_credit_capacity_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.credit_capacity_code)));
    avelength_credit_capacity_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.credit_capacity_code)),h.credit_capacity_code<>(typeof(h.credit_capacity_code))'');
    populated_advertising_expenses_code_cnt := COUNT(GROUP,h.advertising_expenses_code <> (TYPEOF(h.advertising_expenses_code))'');
    populated_advertising_expenses_code_pcnt := AVE(GROUP,IF(h.advertising_expenses_code = (TYPEOF(h.advertising_expenses_code))'',0,100));
    maxlength_advertising_expenses_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.advertising_expenses_code)));
    avelength_advertising_expenses_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.advertising_expenses_code)),h.advertising_expenses_code<>(typeof(h.advertising_expenses_code))'');
    populated_technology_expenses_code_cnt := COUNT(GROUP,h.technology_expenses_code <> (TYPEOF(h.technology_expenses_code))'');
    populated_technology_expenses_code_pcnt := AVE(GROUP,IF(h.technology_expenses_code = (TYPEOF(h.technology_expenses_code))'',0,100));
    maxlength_technology_expenses_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.technology_expenses_code)));
    avelength_technology_expenses_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.technology_expenses_code)),h.technology_expenses_code<>(typeof(h.technology_expenses_code))'');
    populated_office_equip_expenses_code_cnt := COUNT(GROUP,h.office_equip_expenses_code <> (TYPEOF(h.office_equip_expenses_code))'');
    populated_office_equip_expenses_code_pcnt := AVE(GROUP,IF(h.office_equip_expenses_code = (TYPEOF(h.office_equip_expenses_code))'',0,100));
    maxlength_office_equip_expenses_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.office_equip_expenses_code)));
    avelength_office_equip_expenses_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.office_equip_expenses_code)),h.office_equip_expenses_code<>(typeof(h.office_equip_expenses_code))'');
    populated_rent_expenses_code_cnt := COUNT(GROUP,h.rent_expenses_code <> (TYPEOF(h.rent_expenses_code))'');
    populated_rent_expenses_code_pcnt := AVE(GROUP,IF(h.rent_expenses_code = (TYPEOF(h.rent_expenses_code))'',0,100));
    maxlength_rent_expenses_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.rent_expenses_code)));
    avelength_rent_expenses_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.rent_expenses_code)),h.rent_expenses_code<>(typeof(h.rent_expenses_code))'');
    populated_telecom_expenses_code_cnt := COUNT(GROUP,h.telecom_expenses_code <> (TYPEOF(h.telecom_expenses_code))'');
    populated_telecom_expenses_code_pcnt := AVE(GROUP,IF(h.telecom_expenses_code = (TYPEOF(h.telecom_expenses_code))'',0,100));
    maxlength_telecom_expenses_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.telecom_expenses_code)));
    avelength_telecom_expenses_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.telecom_expenses_code)),h.telecom_expenses_code<>(typeof(h.telecom_expenses_code))'');
    populated_accounting_expenses_code_cnt := COUNT(GROUP,h.accounting_expenses_code <> (TYPEOF(h.accounting_expenses_code))'');
    populated_accounting_expenses_code_pcnt := AVE(GROUP,IF(h.accounting_expenses_code = (TYPEOF(h.accounting_expenses_code))'',0,100));
    maxlength_accounting_expenses_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.accounting_expenses_code)));
    avelength_accounting_expenses_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.accounting_expenses_code)),h.accounting_expenses_code<>(typeof(h.accounting_expenses_code))'');
    populated_bus_insurance_expense_code_cnt := COUNT(GROUP,h.bus_insurance_expense_code <> (TYPEOF(h.bus_insurance_expense_code))'');
    populated_bus_insurance_expense_code_pcnt := AVE(GROUP,IF(h.bus_insurance_expense_code = (TYPEOF(h.bus_insurance_expense_code))'',0,100));
    maxlength_bus_insurance_expense_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.bus_insurance_expense_code)));
    avelength_bus_insurance_expense_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.bus_insurance_expense_code)),h.bus_insurance_expense_code<>(typeof(h.bus_insurance_expense_code))'');
    populated_legal_expenses_code_cnt := COUNT(GROUP,h.legal_expenses_code <> (TYPEOF(h.legal_expenses_code))'');
    populated_legal_expenses_code_pcnt := AVE(GROUP,IF(h.legal_expenses_code = (TYPEOF(h.legal_expenses_code))'',0,100));
    maxlength_legal_expenses_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.legal_expenses_code)));
    avelength_legal_expenses_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.legal_expenses_code)),h.legal_expenses_code<>(typeof(h.legal_expenses_code))'');
    populated_utilities_expenses_code_cnt := COUNT(GROUP,h.utilities_expenses_code <> (TYPEOF(h.utilities_expenses_code))'');
    populated_utilities_expenses_code_pcnt := AVE(GROUP,IF(h.utilities_expenses_code = (TYPEOF(h.utilities_expenses_code))'',0,100));
    maxlength_utilities_expenses_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.utilities_expenses_code)));
    avelength_utilities_expenses_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.utilities_expenses_code)),h.utilities_expenses_code<>(typeof(h.utilities_expenses_code))'');
    populated_number_of_pcs_code_cnt := COUNT(GROUP,h.number_of_pcs_code <> (TYPEOF(h.number_of_pcs_code))'');
    populated_number_of_pcs_code_pcnt := AVE(GROUP,IF(h.number_of_pcs_code = (TYPEOF(h.number_of_pcs_code))'',0,100));
    maxlength_number_of_pcs_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.number_of_pcs_code)));
    avelength_number_of_pcs_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.number_of_pcs_code)),h.number_of_pcs_code<>(typeof(h.number_of_pcs_code))'');
    populated_nb_flag_cnt := COUNT(GROUP,h.nb_flag <> (TYPEOF(h.nb_flag))'');
    populated_nb_flag_pcnt := AVE(GROUP,IF(h.nb_flag = (TYPEOF(h.nb_flag))'',0,100));
    maxlength_nb_flag := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.nb_flag)));
    avelength_nb_flag := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.nb_flag)),h.nb_flag<>(typeof(h.nb_flag))'');
    populated_domestic_foreign_owner_flag_cnt := COUNT(GROUP,h.domestic_foreign_owner_flag <> (TYPEOF(h.domestic_foreign_owner_flag))'');
    populated_domestic_foreign_owner_flag_pcnt := AVE(GROUP,IF(h.domestic_foreign_owner_flag = (TYPEOF(h.domestic_foreign_owner_flag))'',0,100));
    maxlength_domestic_foreign_owner_flag := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.domestic_foreign_owner_flag)));
    avelength_domestic_foreign_owner_flag := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.domestic_foreign_owner_flag)),h.domestic_foreign_owner_flag<>(typeof(h.domestic_foreign_owner_flag))'');
    populated_db_cons_full_name_cnt := COUNT(GROUP,h.db_cons_full_name <> (TYPEOF(h.db_cons_full_name))'');
    populated_db_cons_full_name_pcnt := AVE(GROUP,IF(h.db_cons_full_name = (TYPEOF(h.db_cons_full_name))'',0,100));
    maxlength_db_cons_full_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_full_name)));
    avelength_db_cons_full_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_full_name)),h.db_cons_full_name<>(typeof(h.db_cons_full_name))'');
    populated_db_cons_email_cnt := COUNT(GROUP,h.db_cons_email <> (TYPEOF(h.db_cons_email))'');
    populated_db_cons_email_pcnt := AVE(GROUP,IF(h.db_cons_email = (TYPEOF(h.db_cons_email))'',0,100));
    maxlength_db_cons_email := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_email)));
    avelength_db_cons_email := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_email)),h.db_cons_email<>(typeof(h.db_cons_email))'');
    populated_db_cons_gender_cnt := COUNT(GROUP,h.db_cons_gender <> (TYPEOF(h.db_cons_gender))'');
    populated_db_cons_gender_pcnt := AVE(GROUP,IF(h.db_cons_gender = (TYPEOF(h.db_cons_gender))'',0,100));
    maxlength_db_cons_gender := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_gender)));
    avelength_db_cons_gender := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_gender)),h.db_cons_gender<>(typeof(h.db_cons_gender))'');
    populated_db_cons_date_of_birth_year_cnt := COUNT(GROUP,h.db_cons_date_of_birth_year <> (TYPEOF(h.db_cons_date_of_birth_year))'');
    populated_db_cons_date_of_birth_year_pcnt := AVE(GROUP,IF(h.db_cons_date_of_birth_year = (TYPEOF(h.db_cons_date_of_birth_year))'',0,100));
    maxlength_db_cons_date_of_birth_year := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_date_of_birth_year)));
    avelength_db_cons_date_of_birth_year := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_date_of_birth_year)),h.db_cons_date_of_birth_year<>(typeof(h.db_cons_date_of_birth_year))'');
    populated_db_cons_date_of_birth_month_cnt := COUNT(GROUP,h.db_cons_date_of_birth_month <> (TYPEOF(h.db_cons_date_of_birth_month))'');
    populated_db_cons_date_of_birth_month_pcnt := AVE(GROUP,IF(h.db_cons_date_of_birth_month = (TYPEOF(h.db_cons_date_of_birth_month))'',0,100));
    maxlength_db_cons_date_of_birth_month := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_date_of_birth_month)));
    avelength_db_cons_date_of_birth_month := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_date_of_birth_month)),h.db_cons_date_of_birth_month<>(typeof(h.db_cons_date_of_birth_month))'');
    populated_db_cons_age_cnt := COUNT(GROUP,h.db_cons_age <> (TYPEOF(h.db_cons_age))'');
    populated_db_cons_age_pcnt := AVE(GROUP,IF(h.db_cons_age = (TYPEOF(h.db_cons_age))'',0,100));
    maxlength_db_cons_age := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_age)));
    avelength_db_cons_age := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_age)),h.db_cons_age<>(typeof(h.db_cons_age))'');
    populated_db_cons_ethnic_code_cnt := COUNT(GROUP,h.db_cons_ethnic_code <> (TYPEOF(h.db_cons_ethnic_code))'');
    populated_db_cons_ethnic_code_pcnt := AVE(GROUP,IF(h.db_cons_ethnic_code = (TYPEOF(h.db_cons_ethnic_code))'',0,100));
    maxlength_db_cons_ethnic_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_ethnic_code)));
    avelength_db_cons_ethnic_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_ethnic_code)),h.db_cons_ethnic_code<>(typeof(h.db_cons_ethnic_code))'');
    populated_db_cons_religious_affil_cnt := COUNT(GROUP,h.db_cons_religious_affil <> (TYPEOF(h.db_cons_religious_affil))'');
    populated_db_cons_religious_affil_pcnt := AVE(GROUP,IF(h.db_cons_religious_affil = (TYPEOF(h.db_cons_religious_affil))'',0,100));
    maxlength_db_cons_religious_affil := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_religious_affil)));
    avelength_db_cons_religious_affil := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_religious_affil)),h.db_cons_religious_affil<>(typeof(h.db_cons_religious_affil))'');
    populated_db_cons_language_pref_cnt := COUNT(GROUP,h.db_cons_language_pref <> (TYPEOF(h.db_cons_language_pref))'');
    populated_db_cons_language_pref_pcnt := AVE(GROUP,IF(h.db_cons_language_pref = (TYPEOF(h.db_cons_language_pref))'',0,100));
    maxlength_db_cons_language_pref := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_language_pref)));
    avelength_db_cons_language_pref := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_language_pref)),h.db_cons_language_pref<>(typeof(h.db_cons_language_pref))'');
    populated_db_cons_time_zone_code_cnt := COUNT(GROUP,h.db_cons_time_zone_code <> (TYPEOF(h.db_cons_time_zone_code))'');
    populated_db_cons_time_zone_code_pcnt := AVE(GROUP,IF(h.db_cons_time_zone_code = (TYPEOF(h.db_cons_time_zone_code))'',0,100));
    maxlength_db_cons_time_zone_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_time_zone_code)));
    avelength_db_cons_time_zone_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_time_zone_code)),h.db_cons_time_zone_code<>(typeof(h.db_cons_time_zone_code))'');
    populated_db_cons_phone_cnt := COUNT(GROUP,h.db_cons_phone <> (TYPEOF(h.db_cons_phone))'');
    populated_db_cons_phone_pcnt := AVE(GROUP,IF(h.db_cons_phone = (TYPEOF(h.db_cons_phone))'',0,100));
    maxlength_db_cons_phone := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_phone)));
    avelength_db_cons_phone := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_phone)),h.db_cons_phone<>(typeof(h.db_cons_phone))'');
    populated_db_cons_dnc_cnt := COUNT(GROUP,h.db_cons_dnc <> (TYPEOF(h.db_cons_dnc))'');
    populated_db_cons_dnc_pcnt := AVE(GROUP,IF(h.db_cons_dnc = (TYPEOF(h.db_cons_dnc))'',0,100));
    maxlength_db_cons_dnc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_dnc)));
    avelength_db_cons_dnc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_dnc)),h.db_cons_dnc<>(typeof(h.db_cons_dnc))'');
    populated_db_cons_scrubbed_phoneable_cnt := COUNT(GROUP,h.db_cons_scrubbed_phoneable <> (TYPEOF(h.db_cons_scrubbed_phoneable))'');
    populated_db_cons_scrubbed_phoneable_pcnt := AVE(GROUP,IF(h.db_cons_scrubbed_phoneable = (TYPEOF(h.db_cons_scrubbed_phoneable))'',0,100));
    maxlength_db_cons_scrubbed_phoneable := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_scrubbed_phoneable)));
    avelength_db_cons_scrubbed_phoneable := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_scrubbed_phoneable)),h.db_cons_scrubbed_phoneable<>(typeof(h.db_cons_scrubbed_phoneable))'');
    populated_db_cons_children_present_cnt := COUNT(GROUP,h.db_cons_children_present <> (TYPEOF(h.db_cons_children_present))'');
    populated_db_cons_children_present_pcnt := AVE(GROUP,IF(h.db_cons_children_present = (TYPEOF(h.db_cons_children_present))'',0,100));
    maxlength_db_cons_children_present := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_children_present)));
    avelength_db_cons_children_present := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_children_present)),h.db_cons_children_present<>(typeof(h.db_cons_children_present))'');
    populated_db_cons_home_value_code_cnt := COUNT(GROUP,h.db_cons_home_value_code <> (TYPEOF(h.db_cons_home_value_code))'');
    populated_db_cons_home_value_code_pcnt := AVE(GROUP,IF(h.db_cons_home_value_code = (TYPEOF(h.db_cons_home_value_code))'',0,100));
    maxlength_db_cons_home_value_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_home_value_code)));
    avelength_db_cons_home_value_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_home_value_code)),h.db_cons_home_value_code<>(typeof(h.db_cons_home_value_code))'');
    populated_db_cons_donor_capacity_code_cnt := COUNT(GROUP,h.db_cons_donor_capacity_code <> (TYPEOF(h.db_cons_donor_capacity_code))'');
    populated_db_cons_donor_capacity_code_pcnt := AVE(GROUP,IF(h.db_cons_donor_capacity_code = (TYPEOF(h.db_cons_donor_capacity_code))'',0,100));
    maxlength_db_cons_donor_capacity_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_donor_capacity_code)));
    avelength_db_cons_donor_capacity_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_donor_capacity_code)),h.db_cons_donor_capacity_code<>(typeof(h.db_cons_donor_capacity_code))'');
    populated_db_cons_home_owner_renter_cnt := COUNT(GROUP,h.db_cons_home_owner_renter <> (TYPEOF(h.db_cons_home_owner_renter))'');
    populated_db_cons_home_owner_renter_pcnt := AVE(GROUP,IF(h.db_cons_home_owner_renter = (TYPEOF(h.db_cons_home_owner_renter))'',0,100));
    maxlength_db_cons_home_owner_renter := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_home_owner_renter)));
    avelength_db_cons_home_owner_renter := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_home_owner_renter)),h.db_cons_home_owner_renter<>(typeof(h.db_cons_home_owner_renter))'');
    populated_db_cons_length_of_res_code_cnt := COUNT(GROUP,h.db_cons_length_of_res_code <> (TYPEOF(h.db_cons_length_of_res_code))'');
    populated_db_cons_length_of_res_code_pcnt := AVE(GROUP,IF(h.db_cons_length_of_res_code = (TYPEOF(h.db_cons_length_of_res_code))'',0,100));
    maxlength_db_cons_length_of_res_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_length_of_res_code)));
    avelength_db_cons_length_of_res_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_length_of_res_code)),h.db_cons_length_of_res_code<>(typeof(h.db_cons_length_of_res_code))'');
    populated_db_cons_dwelling_type_cnt := COUNT(GROUP,h.db_cons_dwelling_type <> (TYPEOF(h.db_cons_dwelling_type))'');
    populated_db_cons_dwelling_type_pcnt := AVE(GROUP,IF(h.db_cons_dwelling_type = (TYPEOF(h.db_cons_dwelling_type))'',0,100));
    maxlength_db_cons_dwelling_type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_dwelling_type)));
    avelength_db_cons_dwelling_type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_dwelling_type)),h.db_cons_dwelling_type<>(typeof(h.db_cons_dwelling_type))'');
    populated_db_cons_recent_home_buyer_cnt := COUNT(GROUP,h.db_cons_recent_home_buyer <> (TYPEOF(h.db_cons_recent_home_buyer))'');
    populated_db_cons_recent_home_buyer_pcnt := AVE(GROUP,IF(h.db_cons_recent_home_buyer = (TYPEOF(h.db_cons_recent_home_buyer))'',0,100));
    maxlength_db_cons_recent_home_buyer := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_recent_home_buyer)));
    avelength_db_cons_recent_home_buyer := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_recent_home_buyer)),h.db_cons_recent_home_buyer<>(typeof(h.db_cons_recent_home_buyer))'');
    populated_db_cons_income_code_cnt := COUNT(GROUP,h.db_cons_income_code <> (TYPEOF(h.db_cons_income_code))'');
    populated_db_cons_income_code_pcnt := AVE(GROUP,IF(h.db_cons_income_code = (TYPEOF(h.db_cons_income_code))'',0,100));
    maxlength_db_cons_income_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_income_code)));
    avelength_db_cons_income_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_income_code)),h.db_cons_income_code<>(typeof(h.db_cons_income_code))'');
    populated_db_cons_unsecuredcredcapcode_cnt := COUNT(GROUP,h.db_cons_unsecuredcredcapcode <> (TYPEOF(h.db_cons_unsecuredcredcapcode))'');
    populated_db_cons_unsecuredcredcapcode_pcnt := AVE(GROUP,IF(h.db_cons_unsecuredcredcapcode = (TYPEOF(h.db_cons_unsecuredcredcapcode))'',0,100));
    maxlength_db_cons_unsecuredcredcapcode := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_unsecuredcredcapcode)));
    avelength_db_cons_unsecuredcredcapcode := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_unsecuredcredcapcode)),h.db_cons_unsecuredcredcapcode<>(typeof(h.db_cons_unsecuredcredcapcode))'');
    populated_db_cons_networthhomevalcode_cnt := COUNT(GROUP,h.db_cons_networthhomevalcode <> (TYPEOF(h.db_cons_networthhomevalcode))'');
    populated_db_cons_networthhomevalcode_pcnt := AVE(GROUP,IF(h.db_cons_networthhomevalcode = (TYPEOF(h.db_cons_networthhomevalcode))'',0,100));
    maxlength_db_cons_networthhomevalcode := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_networthhomevalcode)));
    avelength_db_cons_networthhomevalcode := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_networthhomevalcode)),h.db_cons_networthhomevalcode<>(typeof(h.db_cons_networthhomevalcode))'');
    populated_db_cons_discretincomecode_cnt := COUNT(GROUP,h.db_cons_discretincomecode <> (TYPEOF(h.db_cons_discretincomecode))'');
    populated_db_cons_discretincomecode_pcnt := AVE(GROUP,IF(h.db_cons_discretincomecode = (TYPEOF(h.db_cons_discretincomecode))'',0,100));
    maxlength_db_cons_discretincomecode := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_discretincomecode)));
    avelength_db_cons_discretincomecode := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_discretincomecode)),h.db_cons_discretincomecode<>(typeof(h.db_cons_discretincomecode))'');
    populated_db_cons_marital_status_cnt := COUNT(GROUP,h.db_cons_marital_status <> (TYPEOF(h.db_cons_marital_status))'');
    populated_db_cons_marital_status_pcnt := AVE(GROUP,IF(h.db_cons_marital_status = (TYPEOF(h.db_cons_marital_status))'',0,100));
    maxlength_db_cons_marital_status := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_marital_status)));
    avelength_db_cons_marital_status := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_marital_status)),h.db_cons_marital_status<>(typeof(h.db_cons_marital_status))'');
    populated_db_cons_new_parent_cnt := COUNT(GROUP,h.db_cons_new_parent <> (TYPEOF(h.db_cons_new_parent))'');
    populated_db_cons_new_parent_pcnt := AVE(GROUP,IF(h.db_cons_new_parent = (TYPEOF(h.db_cons_new_parent))'',0,100));
    maxlength_db_cons_new_parent := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_new_parent)));
    avelength_db_cons_new_parent := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_new_parent)),h.db_cons_new_parent<>(typeof(h.db_cons_new_parent))'');
    populated_db_cons_child_near_hs_grad_cnt := COUNT(GROUP,h.db_cons_child_near_hs_grad <> (TYPEOF(h.db_cons_child_near_hs_grad))'');
    populated_db_cons_child_near_hs_grad_pcnt := AVE(GROUP,IF(h.db_cons_child_near_hs_grad = (TYPEOF(h.db_cons_child_near_hs_grad))'',0,100));
    maxlength_db_cons_child_near_hs_grad := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_child_near_hs_grad)));
    avelength_db_cons_child_near_hs_grad := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_child_near_hs_grad)),h.db_cons_child_near_hs_grad<>(typeof(h.db_cons_child_near_hs_grad))'');
    populated_db_cons_college_graduate_cnt := COUNT(GROUP,h.db_cons_college_graduate <> (TYPEOF(h.db_cons_college_graduate))'');
    populated_db_cons_college_graduate_pcnt := AVE(GROUP,IF(h.db_cons_college_graduate = (TYPEOF(h.db_cons_college_graduate))'',0,100));
    maxlength_db_cons_college_graduate := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_college_graduate)));
    avelength_db_cons_college_graduate := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_college_graduate)),h.db_cons_college_graduate<>(typeof(h.db_cons_college_graduate))'');
    populated_db_cons_intend_purchase_veh_cnt := COUNT(GROUP,h.db_cons_intend_purchase_veh <> (TYPEOF(h.db_cons_intend_purchase_veh))'');
    populated_db_cons_intend_purchase_veh_pcnt := AVE(GROUP,IF(h.db_cons_intend_purchase_veh = (TYPEOF(h.db_cons_intend_purchase_veh))'',0,100));
    maxlength_db_cons_intend_purchase_veh := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_intend_purchase_veh)));
    avelength_db_cons_intend_purchase_veh := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_intend_purchase_veh)),h.db_cons_intend_purchase_veh<>(typeof(h.db_cons_intend_purchase_veh))'');
    populated_db_cons_recent_divorce_cnt := COUNT(GROUP,h.db_cons_recent_divorce <> (TYPEOF(h.db_cons_recent_divorce))'');
    populated_db_cons_recent_divorce_pcnt := AVE(GROUP,IF(h.db_cons_recent_divorce = (TYPEOF(h.db_cons_recent_divorce))'',0,100));
    maxlength_db_cons_recent_divorce := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_recent_divorce)));
    avelength_db_cons_recent_divorce := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_recent_divorce)),h.db_cons_recent_divorce<>(typeof(h.db_cons_recent_divorce))'');
    populated_db_cons_newlywed_cnt := COUNT(GROUP,h.db_cons_newlywed <> (TYPEOF(h.db_cons_newlywed))'');
    populated_db_cons_newlywed_pcnt := AVE(GROUP,IF(h.db_cons_newlywed = (TYPEOF(h.db_cons_newlywed))'',0,100));
    maxlength_db_cons_newlywed := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_newlywed)));
    avelength_db_cons_newlywed := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_newlywed)),h.db_cons_newlywed<>(typeof(h.db_cons_newlywed))'');
    populated_db_cons_new_teen_driver_cnt := COUNT(GROUP,h.db_cons_new_teen_driver <> (TYPEOF(h.db_cons_new_teen_driver))'');
    populated_db_cons_new_teen_driver_pcnt := AVE(GROUP,IF(h.db_cons_new_teen_driver = (TYPEOF(h.db_cons_new_teen_driver))'',0,100));
    maxlength_db_cons_new_teen_driver := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_new_teen_driver)));
    avelength_db_cons_new_teen_driver := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_new_teen_driver)),h.db_cons_new_teen_driver<>(typeof(h.db_cons_new_teen_driver))'');
    populated_db_cons_home_year_built_cnt := COUNT(GROUP,h.db_cons_home_year_built <> (TYPEOF(h.db_cons_home_year_built))'');
    populated_db_cons_home_year_built_pcnt := AVE(GROUP,IF(h.db_cons_home_year_built = (TYPEOF(h.db_cons_home_year_built))'',0,100));
    maxlength_db_cons_home_year_built := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_home_year_built)));
    avelength_db_cons_home_year_built := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_home_year_built)),h.db_cons_home_year_built<>(typeof(h.db_cons_home_year_built))'');
    populated_db_cons_home_sqft_ranges_cnt := COUNT(GROUP,h.db_cons_home_sqft_ranges <> (TYPEOF(h.db_cons_home_sqft_ranges))'');
    populated_db_cons_home_sqft_ranges_pcnt := AVE(GROUP,IF(h.db_cons_home_sqft_ranges = (TYPEOF(h.db_cons_home_sqft_ranges))'',0,100));
    maxlength_db_cons_home_sqft_ranges := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_home_sqft_ranges)));
    avelength_db_cons_home_sqft_ranges := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_home_sqft_ranges)),h.db_cons_home_sqft_ranges<>(typeof(h.db_cons_home_sqft_ranges))'');
    populated_db_cons_poli_party_ind_cnt := COUNT(GROUP,h.db_cons_poli_party_ind <> (TYPEOF(h.db_cons_poli_party_ind))'');
    populated_db_cons_poli_party_ind_pcnt := AVE(GROUP,IF(h.db_cons_poli_party_ind = (TYPEOF(h.db_cons_poli_party_ind))'',0,100));
    maxlength_db_cons_poli_party_ind := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_poli_party_ind)));
    avelength_db_cons_poli_party_ind := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_poli_party_ind)),h.db_cons_poli_party_ind<>(typeof(h.db_cons_poli_party_ind))'');
    populated_db_cons_occupation_ind_cnt := COUNT(GROUP,h.db_cons_occupation_ind <> (TYPEOF(h.db_cons_occupation_ind))'');
    populated_db_cons_occupation_ind_pcnt := AVE(GROUP,IF(h.db_cons_occupation_ind = (TYPEOF(h.db_cons_occupation_ind))'',0,100));
    maxlength_db_cons_occupation_ind := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_occupation_ind)));
    avelength_db_cons_occupation_ind := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_occupation_ind)),h.db_cons_occupation_ind<>(typeof(h.db_cons_occupation_ind))'');
    populated_db_cons_credit_card_user_cnt := COUNT(GROUP,h.db_cons_credit_card_user <> (TYPEOF(h.db_cons_credit_card_user))'');
    populated_db_cons_credit_card_user_pcnt := AVE(GROUP,IF(h.db_cons_credit_card_user = (TYPEOF(h.db_cons_credit_card_user))'',0,100));
    maxlength_db_cons_credit_card_user := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_credit_card_user)));
    avelength_db_cons_credit_card_user := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_credit_card_user)),h.db_cons_credit_card_user<>(typeof(h.db_cons_credit_card_user))'');
    populated_db_cons_home_property_type_cnt := COUNT(GROUP,h.db_cons_home_property_type <> (TYPEOF(h.db_cons_home_property_type))'');
    populated_db_cons_home_property_type_pcnt := AVE(GROUP,IF(h.db_cons_home_property_type = (TYPEOF(h.db_cons_home_property_type))'',0,100));
    maxlength_db_cons_home_property_type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_home_property_type)));
    avelength_db_cons_home_property_type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_home_property_type)),h.db_cons_home_property_type<>(typeof(h.db_cons_home_property_type))'');
    populated_db_cons_education_hh_cnt := COUNT(GROUP,h.db_cons_education_hh <> (TYPEOF(h.db_cons_education_hh))'');
    populated_db_cons_education_hh_pcnt := AVE(GROUP,IF(h.db_cons_education_hh = (TYPEOF(h.db_cons_education_hh))'',0,100));
    maxlength_db_cons_education_hh := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_education_hh)));
    avelength_db_cons_education_hh := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_education_hh)),h.db_cons_education_hh<>(typeof(h.db_cons_education_hh))'');
    populated_db_cons_education_ind_cnt := COUNT(GROUP,h.db_cons_education_ind <> (TYPEOF(h.db_cons_education_ind))'');
    populated_db_cons_education_ind_pcnt := AVE(GROUP,IF(h.db_cons_education_ind = (TYPEOF(h.db_cons_education_ind))'',0,100));
    maxlength_db_cons_education_ind := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_education_ind)));
    avelength_db_cons_education_ind := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_education_ind)),h.db_cons_education_ind<>(typeof(h.db_cons_education_ind))'');
    populated_db_cons_other_pet_owner_cnt := COUNT(GROUP,h.db_cons_other_pet_owner <> (TYPEOF(h.db_cons_other_pet_owner))'');
    populated_db_cons_other_pet_owner_pcnt := AVE(GROUP,IF(h.db_cons_other_pet_owner = (TYPEOF(h.db_cons_other_pet_owner))'',0,100));
    maxlength_db_cons_other_pet_owner := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_other_pet_owner)));
    avelength_db_cons_other_pet_owner := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_other_pet_owner)),h.db_cons_other_pet_owner<>(typeof(h.db_cons_other_pet_owner))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_dt_first_seen_pcnt *   0.00 / 100 + T.Populated_dt_last_seen_pcnt *   0.00 / 100 + T.Populated_dt_vendor_first_reported_pcnt *   0.00 / 100 + T.Populated_dt_vendor_last_reported_pcnt *   0.00 / 100 + T.Populated_process_date_pcnt *   0.00 / 100 + T.Populated_record_type_pcnt *   0.00 / 100 + T.Populated_ind_frm_indicator_pcnt *   0.00 / 100 + T.Populated_company_name_pcnt *   0.00 / 100 + T.Populated_full_name_pcnt *   0.00 / 100 + T.Populated_gender_pcnt *   0.00 / 100 + T.Populated_primary_exec_flag_pcnt *   0.00 / 100 + T.Populated_exec_type_pcnt *   0.00 / 100 + T.Populated_phy_addr_state_pcnt *   0.00 / 100 + T.Populated_phy_addr_zip_pcnt *   0.00 / 100 + T.Populated_mail_addr_state_pcnt *   0.00 / 100 + T.Populated_mail_addr_zip_pcnt *   0.00 / 100 + T.Populated_mail_score_pcnt *   0.00 / 100 + T.Populated_phone_pcnt *   0.00 / 100 + T.Populated_email_pcnt *   0.00 / 100 + T.Populated_email_available_indicator_pcnt *   0.00 / 100 + T.Populated_url_pcnt *   0.00 / 100 + T.Populated_business_status_code_pcnt *   0.00 / 100 + T.Populated_franchise_flag_pcnt *   0.00 / 100 + T.Populated_franchise_type_pcnt *   0.00 / 100 + T.Populated_county_code_pcnt *   0.00 / 100 + T.Populated_primary_sic_pcnt *   0.00 / 100 + T.Populated_sic02_pcnt *   0.00 / 100 + T.Populated_sic03_pcnt *   0.00 / 100 + T.Populated_sic04_pcnt *   0.00 / 100 + T.Populated_sic05_pcnt *   0.00 / 100 + T.Populated_sic06_pcnt *   0.00 / 100 + T.Populated_primarysic2_pcnt *   0.00 / 100 + T.Populated_primarysic4_pcnt *   0.00 / 100 + T.Populated_naics01_pcnt *   0.00 / 100 + T.Populated_naics02_pcnt *   0.00 / 100 + T.Populated_naics03_pcnt *   0.00 / 100 + T.Populated_naics04_pcnt *   0.00 / 100 + T.Populated_naics05_pcnt *   0.00 / 100 + T.Populated_naics06_pcnt *   0.00 / 100 + T.Populated_location_employee_code_pcnt *   0.00 / 100 + T.Populated_location_sales_code_pcnt *   0.00 / 100 + T.Populated_corporate_employee_code_pcnt *   0.00 / 100 + T.Populated_year_established_pcnt *   0.00 / 100 + T.Populated_female_owned_pcnt *   0.00 / 100 + T.Populated_minority_owned_flag_pcnt *   0.00 / 100 + T.Populated_home_based_indicator_pcnt *   0.00 / 100 + T.Populated_small_business_indicator_pcnt *   0.00 / 100 + T.Populated_import_export_pcnt *   0.00 / 100 + T.Populated_manufacturing_location_pcnt *   0.00 / 100 + T.Populated_public_indicator_pcnt *   0.00 / 100 + T.Populated_non_profit_org_pcnt *   0.00 / 100 + T.Populated_square_footage_code_pcnt *   0.00 / 100 + T.Populated_creditcode_pcnt *   0.00 / 100 + T.Populated_credit_capacity_code_pcnt *   0.00 / 100 + T.Populated_advertising_expenses_code_pcnt *   0.00 / 100 + T.Populated_technology_expenses_code_pcnt *   0.00 / 100 + T.Populated_office_equip_expenses_code_pcnt *   0.00 / 100 + T.Populated_rent_expenses_code_pcnt *   0.00 / 100 + T.Populated_telecom_expenses_code_pcnt *   0.00 / 100 + T.Populated_accounting_expenses_code_pcnt *   0.00 / 100 + T.Populated_bus_insurance_expense_code_pcnt *   0.00 / 100 + T.Populated_legal_expenses_code_pcnt *   0.00 / 100 + T.Populated_utilities_expenses_code_pcnt *   0.00 / 100 + T.Populated_number_of_pcs_code_pcnt *   0.00 / 100 + T.Populated_nb_flag_pcnt *   0.00 / 100 + T.Populated_domestic_foreign_owner_flag_pcnt *   0.00 / 100 + T.Populated_db_cons_full_name_pcnt *   0.00 / 100 + T.Populated_db_cons_email_pcnt *   0.00 / 100 + T.Populated_db_cons_gender_pcnt *   0.00 / 100 + T.Populated_db_cons_date_of_birth_year_pcnt *   0.00 / 100 + T.Populated_db_cons_date_of_birth_month_pcnt *   0.00 / 100 + T.Populated_db_cons_age_pcnt *   0.00 / 100 + T.Populated_db_cons_ethnic_code_pcnt *   0.00 / 100 + T.Populated_db_cons_religious_affil_pcnt *   0.00 / 100 + T.Populated_db_cons_language_pref_pcnt *   0.00 / 100 + T.Populated_db_cons_time_zone_code_pcnt *   0.00 / 100 + T.Populated_db_cons_phone_pcnt *   0.00 / 100 + T.Populated_db_cons_dnc_pcnt *   0.00 / 100 + T.Populated_db_cons_scrubbed_phoneable_pcnt *   0.00 / 100 + T.Populated_db_cons_children_present_pcnt *   0.00 / 100 + T.Populated_db_cons_home_value_code_pcnt *   0.00 / 100 + T.Populated_db_cons_donor_capacity_code_pcnt *   0.00 / 100 + T.Populated_db_cons_home_owner_renter_pcnt *   0.00 / 100 + T.Populated_db_cons_length_of_res_code_pcnt *   0.00 / 100 + T.Populated_db_cons_dwelling_type_pcnt *   0.00 / 100 + T.Populated_db_cons_recent_home_buyer_pcnt *   0.00 / 100 + T.Populated_db_cons_income_code_pcnt *   0.00 / 100 + T.Populated_db_cons_unsecuredcredcapcode_pcnt *   0.00 / 100 + T.Populated_db_cons_networthhomevalcode_pcnt *   0.00 / 100 + T.Populated_db_cons_discretincomecode_pcnt *   0.00 / 100 + T.Populated_db_cons_marital_status_pcnt *   0.00 / 100 + T.Populated_db_cons_new_parent_pcnt *   0.00 / 100 + T.Populated_db_cons_child_near_hs_grad_pcnt *   0.00 / 100 + T.Populated_db_cons_college_graduate_pcnt *   0.00 / 100 + T.Populated_db_cons_intend_purchase_veh_pcnt *   0.00 / 100 + T.Populated_db_cons_recent_divorce_pcnt *   0.00 / 100 + T.Populated_db_cons_newlywed_pcnt *   0.00 / 100 + T.Populated_db_cons_new_teen_driver_pcnt *   0.00 / 100 + T.Populated_db_cons_home_year_built_pcnt *   0.00 / 100 + T.Populated_db_cons_home_sqft_ranges_pcnt *   0.00 / 100 + T.Populated_db_cons_poli_party_ind_pcnt *   0.00 / 100 + T.Populated_db_cons_occupation_ind_pcnt *   0.00 / 100 + T.Populated_db_cons_credit_card_user_pcnt *   0.00 / 100 + T.Populated_db_cons_home_property_type_pcnt *   0.00 / 100 + T.Populated_db_cons_education_hh_pcnt *   0.00 / 100 + T.Populated_db_cons_education_ind_pcnt *   0.00 / 100 + T.Populated_db_cons_other_pet_owner_pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;
 
summary0 := Summary('Summary');
  invRec := RECORD
  UNSIGNED  FldNo;
  SALT311.StrType FieldName;
  UNSIGNED NumberOfRecords;
  REAL8  populated_pcnt;
  UNSIGNED  maxlength;
  REAL8  avelength;
END;
invRec invert(summary0 le, INTEGER C) := TRANSFORM
  SELF.FldNo := C;
  SELF.NumberOfRecords := le.NumberOfRecords;
  SELF.FieldName := CHOOSE(C,'dt_first_seen','dt_last_seen','dt_vendor_first_reported','dt_vendor_last_reported','process_date','record_type','ind_frm_indicator','company_name','full_name','gender','primary_exec_flag','exec_type','phy_addr_state','phy_addr_zip','mail_addr_state','mail_addr_zip','mail_score','phone','email','email_available_indicator','url','business_status_code','franchise_flag','franchise_type','county_code','primary_sic','sic02','sic03','sic04','sic05','sic06','primarysic2','primarysic4','naics01','naics02','naics03','naics04','naics05','naics06','location_employee_code','location_sales_code','corporate_employee_code','year_established','female_owned','minority_owned_flag','home_based_indicator','small_business_indicator','import_export','manufacturing_location','public_indicator','non_profit_org','square_footage_code','creditcode','credit_capacity_code','advertising_expenses_code','technology_expenses_code','office_equip_expenses_code','rent_expenses_code','telecom_expenses_code','accounting_expenses_code','bus_insurance_expense_code','legal_expenses_code','utilities_expenses_code','number_of_pcs_code','nb_flag','domestic_foreign_owner_flag','db_cons_full_name','db_cons_email','db_cons_gender','db_cons_date_of_birth_year','db_cons_date_of_birth_month','db_cons_age','db_cons_ethnic_code','db_cons_religious_affil','db_cons_language_pref','db_cons_time_zone_code','db_cons_phone','db_cons_dnc','db_cons_scrubbed_phoneable','db_cons_children_present','db_cons_home_value_code','db_cons_donor_capacity_code','db_cons_home_owner_renter','db_cons_length_of_res_code','db_cons_dwelling_type','db_cons_recent_home_buyer','db_cons_income_code','db_cons_unsecuredcredcapcode','db_cons_networthhomevalcode','db_cons_discretincomecode','db_cons_marital_status','db_cons_new_parent','db_cons_child_near_hs_grad','db_cons_college_graduate','db_cons_intend_purchase_veh','db_cons_recent_divorce','db_cons_newlywed','db_cons_new_teen_driver','db_cons_home_year_built','db_cons_home_sqft_ranges','db_cons_poli_party_ind','db_cons_occupation_ind','db_cons_credit_card_user','db_cons_home_property_type','db_cons_education_hh','db_cons_education_ind','db_cons_other_pet_owner');
  SELF.populated_pcnt := CHOOSE(C,le.populated_dt_first_seen_pcnt,le.populated_dt_last_seen_pcnt,le.populated_dt_vendor_first_reported_pcnt,le.populated_dt_vendor_last_reported_pcnt,le.populated_process_date_pcnt,le.populated_record_type_pcnt,le.populated_ind_frm_indicator_pcnt,le.populated_company_name_pcnt,le.populated_full_name_pcnt,le.populated_gender_pcnt,le.populated_primary_exec_flag_pcnt,le.populated_exec_type_pcnt,le.populated_phy_addr_state_pcnt,le.populated_phy_addr_zip_pcnt,le.populated_mail_addr_state_pcnt,le.populated_mail_addr_zip_pcnt,le.populated_mail_score_pcnt,le.populated_phone_pcnt,le.populated_email_pcnt,le.populated_email_available_indicator_pcnt,le.populated_url_pcnt,le.populated_business_status_code_pcnt,le.populated_franchise_flag_pcnt,le.populated_franchise_type_pcnt,le.populated_county_code_pcnt,le.populated_primary_sic_pcnt,le.populated_sic02_pcnt,le.populated_sic03_pcnt,le.populated_sic04_pcnt,le.populated_sic05_pcnt,le.populated_sic06_pcnt,le.populated_primarysic2_pcnt,le.populated_primarysic4_pcnt,le.populated_naics01_pcnt,le.populated_naics02_pcnt,le.populated_naics03_pcnt,le.populated_naics04_pcnt,le.populated_naics05_pcnt,le.populated_naics06_pcnt,le.populated_location_employee_code_pcnt,le.populated_location_sales_code_pcnt,le.populated_corporate_employee_code_pcnt,le.populated_year_established_pcnt,le.populated_female_owned_pcnt,le.populated_minority_owned_flag_pcnt,le.populated_home_based_indicator_pcnt,le.populated_small_business_indicator_pcnt,le.populated_import_export_pcnt,le.populated_manufacturing_location_pcnt,le.populated_public_indicator_pcnt,le.populated_non_profit_org_pcnt,le.populated_square_footage_code_pcnt,le.populated_creditcode_pcnt,le.populated_credit_capacity_code_pcnt,le.populated_advertising_expenses_code_pcnt,le.populated_technology_expenses_code_pcnt,le.populated_office_equip_expenses_code_pcnt,le.populated_rent_expenses_code_pcnt,le.populated_telecom_expenses_code_pcnt,le.populated_accounting_expenses_code_pcnt,le.populated_bus_insurance_expense_code_pcnt,le.populated_legal_expenses_code_pcnt,le.populated_utilities_expenses_code_pcnt,le.populated_number_of_pcs_code_pcnt,le.populated_nb_flag_pcnt,le.populated_domestic_foreign_owner_flag_pcnt,le.populated_db_cons_full_name_pcnt,le.populated_db_cons_email_pcnt,le.populated_db_cons_gender_pcnt,le.populated_db_cons_date_of_birth_year_pcnt,le.populated_db_cons_date_of_birth_month_pcnt,le.populated_db_cons_age_pcnt,le.populated_db_cons_ethnic_code_pcnt,le.populated_db_cons_religious_affil_pcnt,le.populated_db_cons_language_pref_pcnt,le.populated_db_cons_time_zone_code_pcnt,le.populated_db_cons_phone_pcnt,le.populated_db_cons_dnc_pcnt,le.populated_db_cons_scrubbed_phoneable_pcnt,le.populated_db_cons_children_present_pcnt,le.populated_db_cons_home_value_code_pcnt,le.populated_db_cons_donor_capacity_code_pcnt,le.populated_db_cons_home_owner_renter_pcnt,le.populated_db_cons_length_of_res_code_pcnt,le.populated_db_cons_dwelling_type_pcnt,le.populated_db_cons_recent_home_buyer_pcnt,le.populated_db_cons_income_code_pcnt,le.populated_db_cons_unsecuredcredcapcode_pcnt,le.populated_db_cons_networthhomevalcode_pcnt,le.populated_db_cons_discretincomecode_pcnt,le.populated_db_cons_marital_status_pcnt,le.populated_db_cons_new_parent_pcnt,le.populated_db_cons_child_near_hs_grad_pcnt,le.populated_db_cons_college_graduate_pcnt,le.populated_db_cons_intend_purchase_veh_pcnt,le.populated_db_cons_recent_divorce_pcnt,le.populated_db_cons_newlywed_pcnt,le.populated_db_cons_new_teen_driver_pcnt,le.populated_db_cons_home_year_built_pcnt,le.populated_db_cons_home_sqft_ranges_pcnt,le.populated_db_cons_poli_party_ind_pcnt,le.populated_db_cons_occupation_ind_pcnt,le.populated_db_cons_credit_card_user_pcnt,le.populated_db_cons_home_property_type_pcnt,le.populated_db_cons_education_hh_pcnt,le.populated_db_cons_education_ind_pcnt,le.populated_db_cons_other_pet_owner_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_dt_first_seen,le.maxlength_dt_last_seen,le.maxlength_dt_vendor_first_reported,le.maxlength_dt_vendor_last_reported,le.maxlength_process_date,le.maxlength_record_type,le.maxlength_ind_frm_indicator,le.maxlength_company_name,le.maxlength_full_name,le.maxlength_gender,le.maxlength_primary_exec_flag,le.maxlength_exec_type,le.maxlength_phy_addr_state,le.maxlength_phy_addr_zip,le.maxlength_mail_addr_state,le.maxlength_mail_addr_zip,le.maxlength_mail_score,le.maxlength_phone,le.maxlength_email,le.maxlength_email_available_indicator,le.maxlength_url,le.maxlength_business_status_code,le.maxlength_franchise_flag,le.maxlength_franchise_type,le.maxlength_county_code,le.maxlength_primary_sic,le.maxlength_sic02,le.maxlength_sic03,le.maxlength_sic04,le.maxlength_sic05,le.maxlength_sic06,le.maxlength_primarysic2,le.maxlength_primarysic4,le.maxlength_naics01,le.maxlength_naics02,le.maxlength_naics03,le.maxlength_naics04,le.maxlength_naics05,le.maxlength_naics06,le.maxlength_location_employee_code,le.maxlength_location_sales_code,le.maxlength_corporate_employee_code,le.maxlength_year_established,le.maxlength_female_owned,le.maxlength_minority_owned_flag,le.maxlength_home_based_indicator,le.maxlength_small_business_indicator,le.maxlength_import_export,le.maxlength_manufacturing_location,le.maxlength_public_indicator,le.maxlength_non_profit_org,le.maxlength_square_footage_code,le.maxlength_creditcode,le.maxlength_credit_capacity_code,le.maxlength_advertising_expenses_code,le.maxlength_technology_expenses_code,le.maxlength_office_equip_expenses_code,le.maxlength_rent_expenses_code,le.maxlength_telecom_expenses_code,le.maxlength_accounting_expenses_code,le.maxlength_bus_insurance_expense_code,le.maxlength_legal_expenses_code,le.maxlength_utilities_expenses_code,le.maxlength_number_of_pcs_code,le.maxlength_nb_flag,le.maxlength_domestic_foreign_owner_flag,le.maxlength_db_cons_full_name,le.maxlength_db_cons_email,le.maxlength_db_cons_gender,le.maxlength_db_cons_date_of_birth_year,le.maxlength_db_cons_date_of_birth_month,le.maxlength_db_cons_age,le.maxlength_db_cons_ethnic_code,le.maxlength_db_cons_religious_affil,le.maxlength_db_cons_language_pref,le.maxlength_db_cons_time_zone_code,le.maxlength_db_cons_phone,le.maxlength_db_cons_dnc,le.maxlength_db_cons_scrubbed_phoneable,le.maxlength_db_cons_children_present,le.maxlength_db_cons_home_value_code,le.maxlength_db_cons_donor_capacity_code,le.maxlength_db_cons_home_owner_renter,le.maxlength_db_cons_length_of_res_code,le.maxlength_db_cons_dwelling_type,le.maxlength_db_cons_recent_home_buyer,le.maxlength_db_cons_income_code,le.maxlength_db_cons_unsecuredcredcapcode,le.maxlength_db_cons_networthhomevalcode,le.maxlength_db_cons_discretincomecode,le.maxlength_db_cons_marital_status,le.maxlength_db_cons_new_parent,le.maxlength_db_cons_child_near_hs_grad,le.maxlength_db_cons_college_graduate,le.maxlength_db_cons_intend_purchase_veh,le.maxlength_db_cons_recent_divorce,le.maxlength_db_cons_newlywed,le.maxlength_db_cons_new_teen_driver,le.maxlength_db_cons_home_year_built,le.maxlength_db_cons_home_sqft_ranges,le.maxlength_db_cons_poli_party_ind,le.maxlength_db_cons_occupation_ind,le.maxlength_db_cons_credit_card_user,le.maxlength_db_cons_home_property_type,le.maxlength_db_cons_education_hh,le.maxlength_db_cons_education_ind,le.maxlength_db_cons_other_pet_owner);
  SELF.avelength := CHOOSE(C,le.avelength_dt_first_seen,le.avelength_dt_last_seen,le.avelength_dt_vendor_first_reported,le.avelength_dt_vendor_last_reported,le.avelength_process_date,le.avelength_record_type,le.avelength_ind_frm_indicator,le.avelength_company_name,le.avelength_full_name,le.avelength_gender,le.avelength_primary_exec_flag,le.avelength_exec_type,le.avelength_phy_addr_state,le.avelength_phy_addr_zip,le.avelength_mail_addr_state,le.avelength_mail_addr_zip,le.avelength_mail_score,le.avelength_phone,le.avelength_email,le.avelength_email_available_indicator,le.avelength_url,le.avelength_business_status_code,le.avelength_franchise_flag,le.avelength_franchise_type,le.avelength_county_code,le.avelength_primary_sic,le.avelength_sic02,le.avelength_sic03,le.avelength_sic04,le.avelength_sic05,le.avelength_sic06,le.avelength_primarysic2,le.avelength_primarysic4,le.avelength_naics01,le.avelength_naics02,le.avelength_naics03,le.avelength_naics04,le.avelength_naics05,le.avelength_naics06,le.avelength_location_employee_code,le.avelength_location_sales_code,le.avelength_corporate_employee_code,le.avelength_year_established,le.avelength_female_owned,le.avelength_minority_owned_flag,le.avelength_home_based_indicator,le.avelength_small_business_indicator,le.avelength_import_export,le.avelength_manufacturing_location,le.avelength_public_indicator,le.avelength_non_profit_org,le.avelength_square_footage_code,le.avelength_creditcode,le.avelength_credit_capacity_code,le.avelength_advertising_expenses_code,le.avelength_technology_expenses_code,le.avelength_office_equip_expenses_code,le.avelength_rent_expenses_code,le.avelength_telecom_expenses_code,le.avelength_accounting_expenses_code,le.avelength_bus_insurance_expense_code,le.avelength_legal_expenses_code,le.avelength_utilities_expenses_code,le.avelength_number_of_pcs_code,le.avelength_nb_flag,le.avelength_domestic_foreign_owner_flag,le.avelength_db_cons_full_name,le.avelength_db_cons_email,le.avelength_db_cons_gender,le.avelength_db_cons_date_of_birth_year,le.avelength_db_cons_date_of_birth_month,le.avelength_db_cons_age,le.avelength_db_cons_ethnic_code,le.avelength_db_cons_religious_affil,le.avelength_db_cons_language_pref,le.avelength_db_cons_time_zone_code,le.avelength_db_cons_phone,le.avelength_db_cons_dnc,le.avelength_db_cons_scrubbed_phoneable,le.avelength_db_cons_children_present,le.avelength_db_cons_home_value_code,le.avelength_db_cons_donor_capacity_code,le.avelength_db_cons_home_owner_renter,le.avelength_db_cons_length_of_res_code,le.avelength_db_cons_dwelling_type,le.avelength_db_cons_recent_home_buyer,le.avelength_db_cons_income_code,le.avelength_db_cons_unsecuredcredcapcode,le.avelength_db_cons_networthhomevalcode,le.avelength_db_cons_discretincomecode,le.avelength_db_cons_marital_status,le.avelength_db_cons_new_parent,le.avelength_db_cons_child_near_hs_grad,le.avelength_db_cons_college_graduate,le.avelength_db_cons_intend_purchase_veh,le.avelength_db_cons_recent_divorce,le.avelength_db_cons_newlywed,le.avelength_db_cons_new_teen_driver,le.avelength_db_cons_home_year_built,le.avelength_db_cons_home_sqft_ranges,le.avelength_db_cons_poli_party_ind,le.avelength_db_cons_occupation_ind,le.avelength_db_cons_credit_card_user,le.avelength_db_cons_home_property_type,le.avelength_db_cons_education_hh,le.avelength_db_cons_education_ind,le.avelength_db_cons_other_pet_owner);
END;
EXPORT invSummary := NORMALIZE(summary0, 107, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT311.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,IF (le.dt_first_seen <> 0,TRIM((SALT311.StrType)le.dt_first_seen), ''),IF (le.dt_last_seen <> 0,TRIM((SALT311.StrType)le.dt_last_seen), ''),IF (le.dt_vendor_first_reported <> 0,TRIM((SALT311.StrType)le.dt_vendor_first_reported), ''),IF (le.dt_vendor_last_reported <> 0,TRIM((SALT311.StrType)le.dt_vendor_last_reported), ''),IF (le.process_date <> 0,TRIM((SALT311.StrType)le.process_date), ''),TRIM((SALT311.StrType)le.record_type),TRIM((SALT311.StrType)le.ind_frm_indicator),TRIM((SALT311.StrType)le.company_name),TRIM((SALT311.StrType)le.full_name),TRIM((SALT311.StrType)le.gender),TRIM((SALT311.StrType)le.primary_exec_flag),TRIM((SALT311.StrType)le.exec_type),TRIM((SALT311.StrType)le.phy_addr_state),TRIM((SALT311.StrType)le.phy_addr_zip),TRIM((SALT311.StrType)le.mail_addr_state),TRIM((SALT311.StrType)le.mail_addr_zip),TRIM((SALT311.StrType)le.mail_score),TRIM((SALT311.StrType)le.phone),TRIM((SALT311.StrType)le.email),TRIM((SALT311.StrType)le.email_available_indicator),TRIM((SALT311.StrType)le.url),TRIM((SALT311.StrType)le.business_status_code),TRIM((SALT311.StrType)le.franchise_flag),TRIM((SALT311.StrType)le.franchise_type),TRIM((SALT311.StrType)le.county_code),TRIM((SALT311.StrType)le.primary_sic),TRIM((SALT311.StrType)le.sic02),TRIM((SALT311.StrType)le.sic03),TRIM((SALT311.StrType)le.sic04),TRIM((SALT311.StrType)le.sic05),TRIM((SALT311.StrType)le.sic06),TRIM((SALT311.StrType)le.primarysic2),TRIM((SALT311.StrType)le.primarysic4),TRIM((SALT311.StrType)le.naics01),TRIM((SALT311.StrType)le.naics02),TRIM((SALT311.StrType)le.naics03),TRIM((SALT311.StrType)le.naics04),TRIM((SALT311.StrType)le.naics05),TRIM((SALT311.StrType)le.naics06),TRIM((SALT311.StrType)le.location_employee_code),TRIM((SALT311.StrType)le.location_sales_code),TRIM((SALT311.StrType)le.corporate_employee_code),TRIM((SALT311.StrType)le.year_established),TRIM((SALT311.StrType)le.female_owned),TRIM((SALT311.StrType)le.minority_owned_flag),TRIM((SALT311.StrType)le.home_based_indicator),TRIM((SALT311.StrType)le.small_business_indicator),TRIM((SALT311.StrType)le.import_export),TRIM((SALT311.StrType)le.manufacturing_location),TRIM((SALT311.StrType)le.public_indicator),TRIM((SALT311.StrType)le.non_profit_org),TRIM((SALT311.StrType)le.square_footage_code),TRIM((SALT311.StrType)le.creditcode),TRIM((SALT311.StrType)le.credit_capacity_code),TRIM((SALT311.StrType)le.advertising_expenses_code),TRIM((SALT311.StrType)le.technology_expenses_code),TRIM((SALT311.StrType)le.office_equip_expenses_code),TRIM((SALT311.StrType)le.rent_expenses_code),TRIM((SALT311.StrType)le.telecom_expenses_code),TRIM((SALT311.StrType)le.accounting_expenses_code),TRIM((SALT311.StrType)le.bus_insurance_expense_code),TRIM((SALT311.StrType)le.legal_expenses_code),TRIM((SALT311.StrType)le.utilities_expenses_code),TRIM((SALT311.StrType)le.number_of_pcs_code),TRIM((SALT311.StrType)le.nb_flag),TRIM((SALT311.StrType)le.domestic_foreign_owner_flag),TRIM((SALT311.StrType)le.db_cons_full_name),TRIM((SALT311.StrType)le.db_cons_email),TRIM((SALT311.StrType)le.db_cons_gender),TRIM((SALT311.StrType)le.db_cons_date_of_birth_year),TRIM((SALT311.StrType)le.db_cons_date_of_birth_month),TRIM((SALT311.StrType)le.db_cons_age),TRIM((SALT311.StrType)le.db_cons_ethnic_code),TRIM((SALT311.StrType)le.db_cons_religious_affil),TRIM((SALT311.StrType)le.db_cons_language_pref),TRIM((SALT311.StrType)le.db_cons_time_zone_code),TRIM((SALT311.StrType)le.db_cons_phone),TRIM((SALT311.StrType)le.db_cons_dnc),TRIM((SALT311.StrType)le.db_cons_scrubbed_phoneable),TRIM((SALT311.StrType)le.db_cons_children_present),TRIM((SALT311.StrType)le.db_cons_home_value_code),TRIM((SALT311.StrType)le.db_cons_donor_capacity_code),TRIM((SALT311.StrType)le.db_cons_home_owner_renter),TRIM((SALT311.StrType)le.db_cons_length_of_res_code),TRIM((SALT311.StrType)le.db_cons_dwelling_type),TRIM((SALT311.StrType)le.db_cons_recent_home_buyer),TRIM((SALT311.StrType)le.db_cons_income_code),TRIM((SALT311.StrType)le.db_cons_unsecuredcredcapcode),TRIM((SALT311.StrType)le.db_cons_networthhomevalcode),TRIM((SALT311.StrType)le.db_cons_discretincomecode),TRIM((SALT311.StrType)le.db_cons_marital_status),TRIM((SALT311.StrType)le.db_cons_new_parent),TRIM((SALT311.StrType)le.db_cons_child_near_hs_grad),TRIM((SALT311.StrType)le.db_cons_college_graduate),TRIM((SALT311.StrType)le.db_cons_intend_purchase_veh),TRIM((SALT311.StrType)le.db_cons_recent_divorce),TRIM((SALT311.StrType)le.db_cons_newlywed),TRIM((SALT311.StrType)le.db_cons_new_teen_driver),TRIM((SALT311.StrType)le.db_cons_home_year_built),TRIM((SALT311.StrType)le.db_cons_home_sqft_ranges),TRIM((SALT311.StrType)le.db_cons_poli_party_ind),TRIM((SALT311.StrType)le.db_cons_occupation_ind),TRIM((SALT311.StrType)le.db_cons_credit_card_user),TRIM((SALT311.StrType)le.db_cons_home_property_type),TRIM((SALT311.StrType)le.db_cons_education_hh),TRIM((SALT311.StrType)le.db_cons_education_ind),TRIM((SALT311.StrType)le.db_cons_other_pet_owner)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,107,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT311.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 107);
  SELF.FldNo2 := 1 + (C % 107);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,IF (le.dt_first_seen <> 0,TRIM((SALT311.StrType)le.dt_first_seen), ''),IF (le.dt_last_seen <> 0,TRIM((SALT311.StrType)le.dt_last_seen), ''),IF (le.dt_vendor_first_reported <> 0,TRIM((SALT311.StrType)le.dt_vendor_first_reported), ''),IF (le.dt_vendor_last_reported <> 0,TRIM((SALT311.StrType)le.dt_vendor_last_reported), ''),IF (le.process_date <> 0,TRIM((SALT311.StrType)le.process_date), ''),TRIM((SALT311.StrType)le.record_type),TRIM((SALT311.StrType)le.ind_frm_indicator),TRIM((SALT311.StrType)le.company_name),TRIM((SALT311.StrType)le.full_name),TRIM((SALT311.StrType)le.gender),TRIM((SALT311.StrType)le.primary_exec_flag),TRIM((SALT311.StrType)le.exec_type),TRIM((SALT311.StrType)le.phy_addr_state),TRIM((SALT311.StrType)le.phy_addr_zip),TRIM((SALT311.StrType)le.mail_addr_state),TRIM((SALT311.StrType)le.mail_addr_zip),TRIM((SALT311.StrType)le.mail_score),TRIM((SALT311.StrType)le.phone),TRIM((SALT311.StrType)le.email),TRIM((SALT311.StrType)le.email_available_indicator),TRIM((SALT311.StrType)le.url),TRIM((SALT311.StrType)le.business_status_code),TRIM((SALT311.StrType)le.franchise_flag),TRIM((SALT311.StrType)le.franchise_type),TRIM((SALT311.StrType)le.county_code),TRIM((SALT311.StrType)le.primary_sic),TRIM((SALT311.StrType)le.sic02),TRIM((SALT311.StrType)le.sic03),TRIM((SALT311.StrType)le.sic04),TRIM((SALT311.StrType)le.sic05),TRIM((SALT311.StrType)le.sic06),TRIM((SALT311.StrType)le.primarysic2),TRIM((SALT311.StrType)le.primarysic4),TRIM((SALT311.StrType)le.naics01),TRIM((SALT311.StrType)le.naics02),TRIM((SALT311.StrType)le.naics03),TRIM((SALT311.StrType)le.naics04),TRIM((SALT311.StrType)le.naics05),TRIM((SALT311.StrType)le.naics06),TRIM((SALT311.StrType)le.location_employee_code),TRIM((SALT311.StrType)le.location_sales_code),TRIM((SALT311.StrType)le.corporate_employee_code),TRIM((SALT311.StrType)le.year_established),TRIM((SALT311.StrType)le.female_owned),TRIM((SALT311.StrType)le.minority_owned_flag),TRIM((SALT311.StrType)le.home_based_indicator),TRIM((SALT311.StrType)le.small_business_indicator),TRIM((SALT311.StrType)le.import_export),TRIM((SALT311.StrType)le.manufacturing_location),TRIM((SALT311.StrType)le.public_indicator),TRIM((SALT311.StrType)le.non_profit_org),TRIM((SALT311.StrType)le.square_footage_code),TRIM((SALT311.StrType)le.creditcode),TRIM((SALT311.StrType)le.credit_capacity_code),TRIM((SALT311.StrType)le.advertising_expenses_code),TRIM((SALT311.StrType)le.technology_expenses_code),TRIM((SALT311.StrType)le.office_equip_expenses_code),TRIM((SALT311.StrType)le.rent_expenses_code),TRIM((SALT311.StrType)le.telecom_expenses_code),TRIM((SALT311.StrType)le.accounting_expenses_code),TRIM((SALT311.StrType)le.bus_insurance_expense_code),TRIM((SALT311.StrType)le.legal_expenses_code),TRIM((SALT311.StrType)le.utilities_expenses_code),TRIM((SALT311.StrType)le.number_of_pcs_code),TRIM((SALT311.StrType)le.nb_flag),TRIM((SALT311.StrType)le.domestic_foreign_owner_flag),TRIM((SALT311.StrType)le.db_cons_full_name),TRIM((SALT311.StrType)le.db_cons_email),TRIM((SALT311.StrType)le.db_cons_gender),TRIM((SALT311.StrType)le.db_cons_date_of_birth_year),TRIM((SALT311.StrType)le.db_cons_date_of_birth_month),TRIM((SALT311.StrType)le.db_cons_age),TRIM((SALT311.StrType)le.db_cons_ethnic_code),TRIM((SALT311.StrType)le.db_cons_religious_affil),TRIM((SALT311.StrType)le.db_cons_language_pref),TRIM((SALT311.StrType)le.db_cons_time_zone_code),TRIM((SALT311.StrType)le.db_cons_phone),TRIM((SALT311.StrType)le.db_cons_dnc),TRIM((SALT311.StrType)le.db_cons_scrubbed_phoneable),TRIM((SALT311.StrType)le.db_cons_children_present),TRIM((SALT311.StrType)le.db_cons_home_value_code),TRIM((SALT311.StrType)le.db_cons_donor_capacity_code),TRIM((SALT311.StrType)le.db_cons_home_owner_renter),TRIM((SALT311.StrType)le.db_cons_length_of_res_code),TRIM((SALT311.StrType)le.db_cons_dwelling_type),TRIM((SALT311.StrType)le.db_cons_recent_home_buyer),TRIM((SALT311.StrType)le.db_cons_income_code),TRIM((SALT311.StrType)le.db_cons_unsecuredcredcapcode),TRIM((SALT311.StrType)le.db_cons_networthhomevalcode),TRIM((SALT311.StrType)le.db_cons_discretincomecode),TRIM((SALT311.StrType)le.db_cons_marital_status),TRIM((SALT311.StrType)le.db_cons_new_parent),TRIM((SALT311.StrType)le.db_cons_child_near_hs_grad),TRIM((SALT311.StrType)le.db_cons_college_graduate),TRIM((SALT311.StrType)le.db_cons_intend_purchase_veh),TRIM((SALT311.StrType)le.db_cons_recent_divorce),TRIM((SALT311.StrType)le.db_cons_newlywed),TRIM((SALT311.StrType)le.db_cons_new_teen_driver),TRIM((SALT311.StrType)le.db_cons_home_year_built),TRIM((SALT311.StrType)le.db_cons_home_sqft_ranges),TRIM((SALT311.StrType)le.db_cons_poli_party_ind),TRIM((SALT311.StrType)le.db_cons_occupation_ind),TRIM((SALT311.StrType)le.db_cons_credit_card_user),TRIM((SALT311.StrType)le.db_cons_home_property_type),TRIM((SALT311.StrType)le.db_cons_education_hh),TRIM((SALT311.StrType)le.db_cons_education_ind),TRIM((SALT311.StrType)le.db_cons_other_pet_owner)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,IF (le.dt_first_seen <> 0,TRIM((SALT311.StrType)le.dt_first_seen), ''),IF (le.dt_last_seen <> 0,TRIM((SALT311.StrType)le.dt_last_seen), ''),IF (le.dt_vendor_first_reported <> 0,TRIM((SALT311.StrType)le.dt_vendor_first_reported), ''),IF (le.dt_vendor_last_reported <> 0,TRIM((SALT311.StrType)le.dt_vendor_last_reported), ''),IF (le.process_date <> 0,TRIM((SALT311.StrType)le.process_date), ''),TRIM((SALT311.StrType)le.record_type),TRIM((SALT311.StrType)le.ind_frm_indicator),TRIM((SALT311.StrType)le.company_name),TRIM((SALT311.StrType)le.full_name),TRIM((SALT311.StrType)le.gender),TRIM((SALT311.StrType)le.primary_exec_flag),TRIM((SALT311.StrType)le.exec_type),TRIM((SALT311.StrType)le.phy_addr_state),TRIM((SALT311.StrType)le.phy_addr_zip),TRIM((SALT311.StrType)le.mail_addr_state),TRIM((SALT311.StrType)le.mail_addr_zip),TRIM((SALT311.StrType)le.mail_score),TRIM((SALT311.StrType)le.phone),TRIM((SALT311.StrType)le.email),TRIM((SALT311.StrType)le.email_available_indicator),TRIM((SALT311.StrType)le.url),TRIM((SALT311.StrType)le.business_status_code),TRIM((SALT311.StrType)le.franchise_flag),TRIM((SALT311.StrType)le.franchise_type),TRIM((SALT311.StrType)le.county_code),TRIM((SALT311.StrType)le.primary_sic),TRIM((SALT311.StrType)le.sic02),TRIM((SALT311.StrType)le.sic03),TRIM((SALT311.StrType)le.sic04),TRIM((SALT311.StrType)le.sic05),TRIM((SALT311.StrType)le.sic06),TRIM((SALT311.StrType)le.primarysic2),TRIM((SALT311.StrType)le.primarysic4),TRIM((SALT311.StrType)le.naics01),TRIM((SALT311.StrType)le.naics02),TRIM((SALT311.StrType)le.naics03),TRIM((SALT311.StrType)le.naics04),TRIM((SALT311.StrType)le.naics05),TRIM((SALT311.StrType)le.naics06),TRIM((SALT311.StrType)le.location_employee_code),TRIM((SALT311.StrType)le.location_sales_code),TRIM((SALT311.StrType)le.corporate_employee_code),TRIM((SALT311.StrType)le.year_established),TRIM((SALT311.StrType)le.female_owned),TRIM((SALT311.StrType)le.minority_owned_flag),TRIM((SALT311.StrType)le.home_based_indicator),TRIM((SALT311.StrType)le.small_business_indicator),TRIM((SALT311.StrType)le.import_export),TRIM((SALT311.StrType)le.manufacturing_location),TRIM((SALT311.StrType)le.public_indicator),TRIM((SALT311.StrType)le.non_profit_org),TRIM((SALT311.StrType)le.square_footage_code),TRIM((SALT311.StrType)le.creditcode),TRIM((SALT311.StrType)le.credit_capacity_code),TRIM((SALT311.StrType)le.advertising_expenses_code),TRIM((SALT311.StrType)le.technology_expenses_code),TRIM((SALT311.StrType)le.office_equip_expenses_code),TRIM((SALT311.StrType)le.rent_expenses_code),TRIM((SALT311.StrType)le.telecom_expenses_code),TRIM((SALT311.StrType)le.accounting_expenses_code),TRIM((SALT311.StrType)le.bus_insurance_expense_code),TRIM((SALT311.StrType)le.legal_expenses_code),TRIM((SALT311.StrType)le.utilities_expenses_code),TRIM((SALT311.StrType)le.number_of_pcs_code),TRIM((SALT311.StrType)le.nb_flag),TRIM((SALT311.StrType)le.domestic_foreign_owner_flag),TRIM((SALT311.StrType)le.db_cons_full_name),TRIM((SALT311.StrType)le.db_cons_email),TRIM((SALT311.StrType)le.db_cons_gender),TRIM((SALT311.StrType)le.db_cons_date_of_birth_year),TRIM((SALT311.StrType)le.db_cons_date_of_birth_month),TRIM((SALT311.StrType)le.db_cons_age),TRIM((SALT311.StrType)le.db_cons_ethnic_code),TRIM((SALT311.StrType)le.db_cons_religious_affil),TRIM((SALT311.StrType)le.db_cons_language_pref),TRIM((SALT311.StrType)le.db_cons_time_zone_code),TRIM((SALT311.StrType)le.db_cons_phone),TRIM((SALT311.StrType)le.db_cons_dnc),TRIM((SALT311.StrType)le.db_cons_scrubbed_phoneable),TRIM((SALT311.StrType)le.db_cons_children_present),TRIM((SALT311.StrType)le.db_cons_home_value_code),TRIM((SALT311.StrType)le.db_cons_donor_capacity_code),TRIM((SALT311.StrType)le.db_cons_home_owner_renter),TRIM((SALT311.StrType)le.db_cons_length_of_res_code),TRIM((SALT311.StrType)le.db_cons_dwelling_type),TRIM((SALT311.StrType)le.db_cons_recent_home_buyer),TRIM((SALT311.StrType)le.db_cons_income_code),TRIM((SALT311.StrType)le.db_cons_unsecuredcredcapcode),TRIM((SALT311.StrType)le.db_cons_networthhomevalcode),TRIM((SALT311.StrType)le.db_cons_discretincomecode),TRIM((SALT311.StrType)le.db_cons_marital_status),TRIM((SALT311.StrType)le.db_cons_new_parent),TRIM((SALT311.StrType)le.db_cons_child_near_hs_grad),TRIM((SALT311.StrType)le.db_cons_college_graduate),TRIM((SALT311.StrType)le.db_cons_intend_purchase_veh),TRIM((SALT311.StrType)le.db_cons_recent_divorce),TRIM((SALT311.StrType)le.db_cons_newlywed),TRIM((SALT311.StrType)le.db_cons_new_teen_driver),TRIM((SALT311.StrType)le.db_cons_home_year_built),TRIM((SALT311.StrType)le.db_cons_home_sqft_ranges),TRIM((SALT311.StrType)le.db_cons_poli_party_ind),TRIM((SALT311.StrType)le.db_cons_occupation_ind),TRIM((SALT311.StrType)le.db_cons_credit_card_user),TRIM((SALT311.StrType)le.db_cons_home_property_type),TRIM((SALT311.StrType)le.db_cons_education_hh),TRIM((SALT311.StrType)le.db_cons_education_ind),TRIM((SALT311.StrType)le.db_cons_other_pet_owner)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),107*107,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'dt_first_seen'}
      ,{2,'dt_last_seen'}
      ,{3,'dt_vendor_first_reported'}
      ,{4,'dt_vendor_last_reported'}
      ,{5,'process_date'}
      ,{6,'record_type'}
      ,{7,'ind_frm_indicator'}
      ,{8,'company_name'}
      ,{9,'full_name'}
      ,{10,'gender'}
      ,{11,'primary_exec_flag'}
      ,{12,'exec_type'}
      ,{13,'phy_addr_state'}
      ,{14,'phy_addr_zip'}
      ,{15,'mail_addr_state'}
      ,{16,'mail_addr_zip'}
      ,{17,'mail_score'}
      ,{18,'phone'}
      ,{19,'email'}
      ,{20,'email_available_indicator'}
      ,{21,'url'}
      ,{22,'business_status_code'}
      ,{23,'franchise_flag'}
      ,{24,'franchise_type'}
      ,{25,'county_code'}
      ,{26,'primary_sic'}
      ,{27,'sic02'}
      ,{28,'sic03'}
      ,{29,'sic04'}
      ,{30,'sic05'}
      ,{31,'sic06'}
      ,{32,'primarysic2'}
      ,{33,'primarysic4'}
      ,{34,'naics01'}
      ,{35,'naics02'}
      ,{36,'naics03'}
      ,{37,'naics04'}
      ,{38,'naics05'}
      ,{39,'naics06'}
      ,{40,'location_employee_code'}
      ,{41,'location_sales_code'}
      ,{42,'corporate_employee_code'}
      ,{43,'year_established'}
      ,{44,'female_owned'}
      ,{45,'minority_owned_flag'}
      ,{46,'home_based_indicator'}
      ,{47,'small_business_indicator'}
      ,{48,'import_export'}
      ,{49,'manufacturing_location'}
      ,{50,'public_indicator'}
      ,{51,'non_profit_org'}
      ,{52,'square_footage_code'}
      ,{53,'creditcode'}
      ,{54,'credit_capacity_code'}
      ,{55,'advertising_expenses_code'}
      ,{56,'technology_expenses_code'}
      ,{57,'office_equip_expenses_code'}
      ,{58,'rent_expenses_code'}
      ,{59,'telecom_expenses_code'}
      ,{60,'accounting_expenses_code'}
      ,{61,'bus_insurance_expense_code'}
      ,{62,'legal_expenses_code'}
      ,{63,'utilities_expenses_code'}
      ,{64,'number_of_pcs_code'}
      ,{65,'nb_flag'}
      ,{66,'domestic_foreign_owner_flag'}
      ,{67,'db_cons_full_name'}
      ,{68,'db_cons_email'}
      ,{69,'db_cons_gender'}
      ,{70,'db_cons_date_of_birth_year'}
      ,{71,'db_cons_date_of_birth_month'}
      ,{72,'db_cons_age'}
      ,{73,'db_cons_ethnic_code'}
      ,{74,'db_cons_religious_affil'}
      ,{75,'db_cons_language_pref'}
      ,{76,'db_cons_time_zone_code'}
      ,{77,'db_cons_phone'}
      ,{78,'db_cons_dnc'}
      ,{79,'db_cons_scrubbed_phoneable'}
      ,{80,'db_cons_children_present'}
      ,{81,'db_cons_home_value_code'}
      ,{82,'db_cons_donor_capacity_code'}
      ,{83,'db_cons_home_owner_renter'}
      ,{84,'db_cons_length_of_res_code'}
      ,{85,'db_cons_dwelling_type'}
      ,{86,'db_cons_recent_home_buyer'}
      ,{87,'db_cons_income_code'}
      ,{88,'db_cons_unsecuredcredcapcode'}
      ,{89,'db_cons_networthhomevalcode'}
      ,{90,'db_cons_discretincomecode'}
      ,{91,'db_cons_marital_status'}
      ,{92,'db_cons_new_parent'}
      ,{93,'db_cons_child_near_hs_grad'}
      ,{94,'db_cons_college_graduate'}
      ,{95,'db_cons_intend_purchase_veh'}
      ,{96,'db_cons_recent_divorce'}
      ,{97,'db_cons_newlywed'}
      ,{98,'db_cons_new_teen_driver'}
      ,{99,'db_cons_home_year_built'}
      ,{100,'db_cons_home_sqft_ranges'}
      ,{101,'db_cons_poli_party_ind'}
      ,{102,'db_cons_occupation_ind'}
      ,{103,'db_cons_credit_card_user'}
      ,{104,'db_cons_home_property_type'}
      ,{105,'db_cons_education_hh'}
      ,{106,'db_cons_education_ind'}
      ,{107,'db_cons_other_pet_owner'}],SALT311.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT311.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT311.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT311.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Base_Fields.InValid_dt_first_seen((SALT311.StrType)le.dt_first_seen),
    Base_Fields.InValid_dt_last_seen((SALT311.StrType)le.dt_last_seen),
    Base_Fields.InValid_dt_vendor_first_reported((SALT311.StrType)le.dt_vendor_first_reported),
    Base_Fields.InValid_dt_vendor_last_reported((SALT311.StrType)le.dt_vendor_last_reported),
    Base_Fields.InValid_process_date((SALT311.StrType)le.process_date),
    Base_Fields.InValid_record_type((SALT311.StrType)le.record_type),
    Base_Fields.InValid_ind_frm_indicator((SALT311.StrType)le.ind_frm_indicator),
    Base_Fields.InValid_company_name((SALT311.StrType)le.company_name),
    Base_Fields.InValid_full_name((SALT311.StrType)le.full_name),
    Base_Fields.InValid_gender((SALT311.StrType)le.gender),
    Base_Fields.InValid_primary_exec_flag((SALT311.StrType)le.primary_exec_flag),
    Base_Fields.InValid_exec_type((SALT311.StrType)le.exec_type),
    Base_Fields.InValid_phy_addr_state((SALT311.StrType)le.phy_addr_state),
    Base_Fields.InValid_phy_addr_zip((SALT311.StrType)le.phy_addr_zip),
    Base_Fields.InValid_mail_addr_state((SALT311.StrType)le.mail_addr_state),
    Base_Fields.InValid_mail_addr_zip((SALT311.StrType)le.mail_addr_zip),
    Base_Fields.InValid_mail_score((SALT311.StrType)le.mail_score),
    Base_Fields.InValid_phone((SALT311.StrType)le.phone),
    Base_Fields.InValid_email((SALT311.StrType)le.email),
    Base_Fields.InValid_email_available_indicator((SALT311.StrType)le.email_available_indicator),
    Base_Fields.InValid_url((SALT311.StrType)le.url),
    Base_Fields.InValid_business_status_code((SALT311.StrType)le.business_status_code),
    Base_Fields.InValid_franchise_flag((SALT311.StrType)le.franchise_flag),
    Base_Fields.InValid_franchise_type((SALT311.StrType)le.franchise_type),
    Base_Fields.InValid_county_code((SALT311.StrType)le.county_code),
    Base_Fields.InValid_primary_sic((SALT311.StrType)le.primary_sic),
    Base_Fields.InValid_sic02((SALT311.StrType)le.sic02),
    Base_Fields.InValid_sic03((SALT311.StrType)le.sic03),
    Base_Fields.InValid_sic04((SALT311.StrType)le.sic04),
    Base_Fields.InValid_sic05((SALT311.StrType)le.sic05),
    Base_Fields.InValid_sic06((SALT311.StrType)le.sic06),
    Base_Fields.InValid_primarysic2((SALT311.StrType)le.primarysic2),
    Base_Fields.InValid_primarysic4((SALT311.StrType)le.primarysic4),
    Base_Fields.InValid_naics01((SALT311.StrType)le.naics01),
    Base_Fields.InValid_naics02((SALT311.StrType)le.naics02),
    Base_Fields.InValid_naics03((SALT311.StrType)le.naics03),
    Base_Fields.InValid_naics04((SALT311.StrType)le.naics04),
    Base_Fields.InValid_naics05((SALT311.StrType)le.naics05),
    Base_Fields.InValid_naics06((SALT311.StrType)le.naics06),
    Base_Fields.InValid_location_employee_code((SALT311.StrType)le.location_employee_code),
    Base_Fields.InValid_location_sales_code((SALT311.StrType)le.location_sales_code),
    Base_Fields.InValid_corporate_employee_code((SALT311.StrType)le.corporate_employee_code),
    Base_Fields.InValid_year_established((SALT311.StrType)le.year_established),
    Base_Fields.InValid_female_owned((SALT311.StrType)le.female_owned),
    Base_Fields.InValid_minority_owned_flag((SALT311.StrType)le.minority_owned_flag),
    Base_Fields.InValid_home_based_indicator((SALT311.StrType)le.home_based_indicator),
    Base_Fields.InValid_small_business_indicator((SALT311.StrType)le.small_business_indicator),
    Base_Fields.InValid_import_export((SALT311.StrType)le.import_export),
    Base_Fields.InValid_manufacturing_location((SALT311.StrType)le.manufacturing_location),
    Base_Fields.InValid_public_indicator((SALT311.StrType)le.public_indicator),
    Base_Fields.InValid_non_profit_org((SALT311.StrType)le.non_profit_org),
    Base_Fields.InValid_square_footage_code((SALT311.StrType)le.square_footage_code),
    Base_Fields.InValid_creditcode((SALT311.StrType)le.creditcode),
    Base_Fields.InValid_credit_capacity_code((SALT311.StrType)le.credit_capacity_code),
    Base_Fields.InValid_advertising_expenses_code((SALT311.StrType)le.advertising_expenses_code),
    Base_Fields.InValid_technology_expenses_code((SALT311.StrType)le.technology_expenses_code),
    Base_Fields.InValid_office_equip_expenses_code((SALT311.StrType)le.office_equip_expenses_code),
    Base_Fields.InValid_rent_expenses_code((SALT311.StrType)le.rent_expenses_code),
    Base_Fields.InValid_telecom_expenses_code((SALT311.StrType)le.telecom_expenses_code),
    Base_Fields.InValid_accounting_expenses_code((SALT311.StrType)le.accounting_expenses_code),
    Base_Fields.InValid_bus_insurance_expense_code((SALT311.StrType)le.bus_insurance_expense_code),
    Base_Fields.InValid_legal_expenses_code((SALT311.StrType)le.legal_expenses_code),
    Base_Fields.InValid_utilities_expenses_code((SALT311.StrType)le.utilities_expenses_code),
    Base_Fields.InValid_number_of_pcs_code((SALT311.StrType)le.number_of_pcs_code),
    Base_Fields.InValid_nb_flag((SALT311.StrType)le.nb_flag),
    Base_Fields.InValid_domestic_foreign_owner_flag((SALT311.StrType)le.domestic_foreign_owner_flag),
    Base_Fields.InValid_db_cons_full_name((SALT311.StrType)le.db_cons_full_name),
    Base_Fields.InValid_db_cons_email((SALT311.StrType)le.db_cons_email),
    Base_Fields.InValid_db_cons_gender((SALT311.StrType)le.db_cons_gender),
    Base_Fields.InValid_db_cons_date_of_birth_year((SALT311.StrType)le.db_cons_date_of_birth_year),
    Base_Fields.InValid_db_cons_date_of_birth_month((SALT311.StrType)le.db_cons_date_of_birth_month),
    Base_Fields.InValid_db_cons_age((SALT311.StrType)le.db_cons_age),
    Base_Fields.InValid_db_cons_ethnic_code((SALT311.StrType)le.db_cons_ethnic_code),
    Base_Fields.InValid_db_cons_religious_affil((SALT311.StrType)le.db_cons_religious_affil),
    Base_Fields.InValid_db_cons_language_pref((SALT311.StrType)le.db_cons_language_pref),
    Base_Fields.InValid_db_cons_time_zone_code((SALT311.StrType)le.db_cons_time_zone_code),
    Base_Fields.InValid_db_cons_phone((SALT311.StrType)le.db_cons_phone),
    Base_Fields.InValid_db_cons_dnc((SALT311.StrType)le.db_cons_dnc),
    Base_Fields.InValid_db_cons_scrubbed_phoneable((SALT311.StrType)le.db_cons_scrubbed_phoneable),
    Base_Fields.InValid_db_cons_children_present((SALT311.StrType)le.db_cons_children_present),
    Base_Fields.InValid_db_cons_home_value_code((SALT311.StrType)le.db_cons_home_value_code),
    Base_Fields.InValid_db_cons_donor_capacity_code((SALT311.StrType)le.db_cons_donor_capacity_code),
    Base_Fields.InValid_db_cons_home_owner_renter((SALT311.StrType)le.db_cons_home_owner_renter),
    Base_Fields.InValid_db_cons_length_of_res_code((SALT311.StrType)le.db_cons_length_of_res_code),
    Base_Fields.InValid_db_cons_dwelling_type((SALT311.StrType)le.db_cons_dwelling_type),
    Base_Fields.InValid_db_cons_recent_home_buyer((SALT311.StrType)le.db_cons_recent_home_buyer),
    Base_Fields.InValid_db_cons_income_code((SALT311.StrType)le.db_cons_income_code),
    Base_Fields.InValid_db_cons_unsecuredcredcapcode((SALT311.StrType)le.db_cons_unsecuredcredcapcode),
    Base_Fields.InValid_db_cons_networthhomevalcode((SALT311.StrType)le.db_cons_networthhomevalcode),
    Base_Fields.InValid_db_cons_discretincomecode((SALT311.StrType)le.db_cons_discretincomecode),
    Base_Fields.InValid_db_cons_marital_status((SALT311.StrType)le.db_cons_marital_status),
    Base_Fields.InValid_db_cons_new_parent((SALT311.StrType)le.db_cons_new_parent),
    Base_Fields.InValid_db_cons_child_near_hs_grad((SALT311.StrType)le.db_cons_child_near_hs_grad),
    Base_Fields.InValid_db_cons_college_graduate((SALT311.StrType)le.db_cons_college_graduate),
    Base_Fields.InValid_db_cons_intend_purchase_veh((SALT311.StrType)le.db_cons_intend_purchase_veh),
    Base_Fields.InValid_db_cons_recent_divorce((SALT311.StrType)le.db_cons_recent_divorce),
    Base_Fields.InValid_db_cons_newlywed((SALT311.StrType)le.db_cons_newlywed),
    Base_Fields.InValid_db_cons_new_teen_driver((SALT311.StrType)le.db_cons_new_teen_driver),
    Base_Fields.InValid_db_cons_home_year_built((SALT311.StrType)le.db_cons_home_year_built),
    Base_Fields.InValid_db_cons_home_sqft_ranges((SALT311.StrType)le.db_cons_home_sqft_ranges),
    Base_Fields.InValid_db_cons_poli_party_ind((SALT311.StrType)le.db_cons_poli_party_ind),
    Base_Fields.InValid_db_cons_occupation_ind((SALT311.StrType)le.db_cons_occupation_ind),
    Base_Fields.InValid_db_cons_credit_card_user((SALT311.StrType)le.db_cons_credit_card_user),
    Base_Fields.InValid_db_cons_home_property_type((SALT311.StrType)le.db_cons_home_property_type),
    Base_Fields.InValid_db_cons_education_hh((SALT311.StrType)le.db_cons_education_hh),
    Base_Fields.InValid_db_cons_education_ind((SALT311.StrType)le.db_cons_education_ind),
    Base_Fields.InValid_db_cons_other_pet_owner((SALT311.StrType)le.db_cons_other_pet_owner),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,107,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Base_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid_pastdate','invalid_pastdate','invalid_pastdate','invalid_pastdate','invalid_generaldate','invalid_record_type','invalid_ind_frm','invalid_mandatory','invalid_mandatory','invalid_gender_code','invalid_flag','invalid_exec_type','invalid_st','invalid_zip5','invalid_st','invalid_zip5','invalid_mail_score','invalid_phone','invalid_email','invalid_email_indicator','invalid_url','invalid_bus_status_code','invalid_flag','invalid_franchise','invalid_numeric','invalid_sic','invalid_sic','invalid_sic','invalid_sic','invalid_sic','invalid_sic','invalid_sic','invalid_sic','invalid_naics','invalid_naics','invalid_naics','invalid_naics','invalid_naics','invalid_naics','invalid_loc_employee_code','invalid_loc_sales_code','invalid_corp_employee_code','invalid_year','invalid_flag','invalid_flag','invalid_flag','invalid_flag','invalid_flag','invalid_flag','invalid_flag','invalid_flag','invalid_sq_ft','invalid_credit_code','invalid_credit_capacity_code','invalid_advertising_code','invalid_technology_code','invalid_office_equip_code','invalid_rent_code','invalid_telecom_code','invalid_accounting_code','invalid_bus_insurance_code','invalid_legal_code','invalid_utilities_code','invalid_number_of_pcs_code','invalid_flag','invalid_flag','invalid_mandatory','invalid_email','invalid_gender_code','invalid_year','invalid_month','invalid_numeric_blank','invalid_ethnic_code','invalid_religious_affil','invalid_language','invalid_time_zone','invalid_phone','invalid_flag','invalid_flag','invalid_children_present','invalid_home_value','invalid_donor_code','invalid_home_owner_renter','invalid_length_of_res','invalid_dwelling_type','invalid_flag','invalid_income_code','invalid_unsec_cap','invalid_net_worth','invalid_discret_income','invalid_marital_status','invalid_new_parent','invalid_flag','invalid_flag','invalid_flag','invalid_flag','invalid_flag','invalid_teen_driver','invalid_year','invalid_home_sqft_ranges','invalid_poli_party_ind','invalid_occupation_ind','invalid_flag','invalid_home_property','invalid_education','invalid_education','invalid_flag');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Base_Fields.InValidMessage_dt_first_seen(TotalErrors.ErrorNum),Base_Fields.InValidMessage_dt_last_seen(TotalErrors.ErrorNum),Base_Fields.InValidMessage_dt_vendor_first_reported(TotalErrors.ErrorNum),Base_Fields.InValidMessage_dt_vendor_last_reported(TotalErrors.ErrorNum),Base_Fields.InValidMessage_process_date(TotalErrors.ErrorNum),Base_Fields.InValidMessage_record_type(TotalErrors.ErrorNum),Base_Fields.InValidMessage_ind_frm_indicator(TotalErrors.ErrorNum),Base_Fields.InValidMessage_company_name(TotalErrors.ErrorNum),Base_Fields.InValidMessage_full_name(TotalErrors.ErrorNum),Base_Fields.InValidMessage_gender(TotalErrors.ErrorNum),Base_Fields.InValidMessage_primary_exec_flag(TotalErrors.ErrorNum),Base_Fields.InValidMessage_exec_type(TotalErrors.ErrorNum),Base_Fields.InValidMessage_phy_addr_state(TotalErrors.ErrorNum),Base_Fields.InValidMessage_phy_addr_zip(TotalErrors.ErrorNum),Base_Fields.InValidMessage_mail_addr_state(TotalErrors.ErrorNum),Base_Fields.InValidMessage_mail_addr_zip(TotalErrors.ErrorNum),Base_Fields.InValidMessage_mail_score(TotalErrors.ErrorNum),Base_Fields.InValidMessage_phone(TotalErrors.ErrorNum),Base_Fields.InValidMessage_email(TotalErrors.ErrorNum),Base_Fields.InValidMessage_email_available_indicator(TotalErrors.ErrorNum),Base_Fields.InValidMessage_url(TotalErrors.ErrorNum),Base_Fields.InValidMessage_business_status_code(TotalErrors.ErrorNum),Base_Fields.InValidMessage_franchise_flag(TotalErrors.ErrorNum),Base_Fields.InValidMessage_franchise_type(TotalErrors.ErrorNum),Base_Fields.InValidMessage_county_code(TotalErrors.ErrorNum),Base_Fields.InValidMessage_primary_sic(TotalErrors.ErrorNum),Base_Fields.InValidMessage_sic02(TotalErrors.ErrorNum),Base_Fields.InValidMessage_sic03(TotalErrors.ErrorNum),Base_Fields.InValidMessage_sic04(TotalErrors.ErrorNum),Base_Fields.InValidMessage_sic05(TotalErrors.ErrorNum),Base_Fields.InValidMessage_sic06(TotalErrors.ErrorNum),Base_Fields.InValidMessage_primarysic2(TotalErrors.ErrorNum),Base_Fields.InValidMessage_primarysic4(TotalErrors.ErrorNum),Base_Fields.InValidMessage_naics01(TotalErrors.ErrorNum),Base_Fields.InValidMessage_naics02(TotalErrors.ErrorNum),Base_Fields.InValidMessage_naics03(TotalErrors.ErrorNum),Base_Fields.InValidMessage_naics04(TotalErrors.ErrorNum),Base_Fields.InValidMessage_naics05(TotalErrors.ErrorNum),Base_Fields.InValidMessage_naics06(TotalErrors.ErrorNum),Base_Fields.InValidMessage_location_employee_code(TotalErrors.ErrorNum),Base_Fields.InValidMessage_location_sales_code(TotalErrors.ErrorNum),Base_Fields.InValidMessage_corporate_employee_code(TotalErrors.ErrorNum),Base_Fields.InValidMessage_year_established(TotalErrors.ErrorNum),Base_Fields.InValidMessage_female_owned(TotalErrors.ErrorNum),Base_Fields.InValidMessage_minority_owned_flag(TotalErrors.ErrorNum),Base_Fields.InValidMessage_home_based_indicator(TotalErrors.ErrorNum),Base_Fields.InValidMessage_small_business_indicator(TotalErrors.ErrorNum),Base_Fields.InValidMessage_import_export(TotalErrors.ErrorNum),Base_Fields.InValidMessage_manufacturing_location(TotalErrors.ErrorNum),Base_Fields.InValidMessage_public_indicator(TotalErrors.ErrorNum),Base_Fields.InValidMessage_non_profit_org(TotalErrors.ErrorNum),Base_Fields.InValidMessage_square_footage_code(TotalErrors.ErrorNum),Base_Fields.InValidMessage_creditcode(TotalErrors.ErrorNum),Base_Fields.InValidMessage_credit_capacity_code(TotalErrors.ErrorNum),Base_Fields.InValidMessage_advertising_expenses_code(TotalErrors.ErrorNum),Base_Fields.InValidMessage_technology_expenses_code(TotalErrors.ErrorNum),Base_Fields.InValidMessage_office_equip_expenses_code(TotalErrors.ErrorNum),Base_Fields.InValidMessage_rent_expenses_code(TotalErrors.ErrorNum),Base_Fields.InValidMessage_telecom_expenses_code(TotalErrors.ErrorNum),Base_Fields.InValidMessage_accounting_expenses_code(TotalErrors.ErrorNum),Base_Fields.InValidMessage_bus_insurance_expense_code(TotalErrors.ErrorNum),Base_Fields.InValidMessage_legal_expenses_code(TotalErrors.ErrorNum),Base_Fields.InValidMessage_utilities_expenses_code(TotalErrors.ErrorNum),Base_Fields.InValidMessage_number_of_pcs_code(TotalErrors.ErrorNum),Base_Fields.InValidMessage_nb_flag(TotalErrors.ErrorNum),Base_Fields.InValidMessage_domestic_foreign_owner_flag(TotalErrors.ErrorNum),Base_Fields.InValidMessage_db_cons_full_name(TotalErrors.ErrorNum),Base_Fields.InValidMessage_db_cons_email(TotalErrors.ErrorNum),Base_Fields.InValidMessage_db_cons_gender(TotalErrors.ErrorNum),Base_Fields.InValidMessage_db_cons_date_of_birth_year(TotalErrors.ErrorNum),Base_Fields.InValidMessage_db_cons_date_of_birth_month(TotalErrors.ErrorNum),Base_Fields.InValidMessage_db_cons_age(TotalErrors.ErrorNum),Base_Fields.InValidMessage_db_cons_ethnic_code(TotalErrors.ErrorNum),Base_Fields.InValidMessage_db_cons_religious_affil(TotalErrors.ErrorNum),Base_Fields.InValidMessage_db_cons_language_pref(TotalErrors.ErrorNum),Base_Fields.InValidMessage_db_cons_time_zone_code(TotalErrors.ErrorNum),Base_Fields.InValidMessage_db_cons_phone(TotalErrors.ErrorNum),Base_Fields.InValidMessage_db_cons_dnc(TotalErrors.ErrorNum),Base_Fields.InValidMessage_db_cons_scrubbed_phoneable(TotalErrors.ErrorNum),Base_Fields.InValidMessage_db_cons_children_present(TotalErrors.ErrorNum),Base_Fields.InValidMessage_db_cons_home_value_code(TotalErrors.ErrorNum),Base_Fields.InValidMessage_db_cons_donor_capacity_code(TotalErrors.ErrorNum),Base_Fields.InValidMessage_db_cons_home_owner_renter(TotalErrors.ErrorNum),Base_Fields.InValidMessage_db_cons_length_of_res_code(TotalErrors.ErrorNum),Base_Fields.InValidMessage_db_cons_dwelling_type(TotalErrors.ErrorNum),Base_Fields.InValidMessage_db_cons_recent_home_buyer(TotalErrors.ErrorNum),Base_Fields.InValidMessage_db_cons_income_code(TotalErrors.ErrorNum),Base_Fields.InValidMessage_db_cons_unsecuredcredcapcode(TotalErrors.ErrorNum),Base_Fields.InValidMessage_db_cons_networthhomevalcode(TotalErrors.ErrorNum),Base_Fields.InValidMessage_db_cons_discretincomecode(TotalErrors.ErrorNum),Base_Fields.InValidMessage_db_cons_marital_status(TotalErrors.ErrorNum),Base_Fields.InValidMessage_db_cons_new_parent(TotalErrors.ErrorNum),Base_Fields.InValidMessage_db_cons_child_near_hs_grad(TotalErrors.ErrorNum),Base_Fields.InValidMessage_db_cons_college_graduate(TotalErrors.ErrorNum),Base_Fields.InValidMessage_db_cons_intend_purchase_veh(TotalErrors.ErrorNum),Base_Fields.InValidMessage_db_cons_recent_divorce(TotalErrors.ErrorNum),Base_Fields.InValidMessage_db_cons_newlywed(TotalErrors.ErrorNum),Base_Fields.InValidMessage_db_cons_new_teen_driver(TotalErrors.ErrorNum),Base_Fields.InValidMessage_db_cons_home_year_built(TotalErrors.ErrorNum),Base_Fields.InValidMessage_db_cons_home_sqft_ranges(TotalErrors.ErrorNum),Base_Fields.InValidMessage_db_cons_poli_party_ind(TotalErrors.ErrorNum),Base_Fields.InValidMessage_db_cons_occupation_ind(TotalErrors.ErrorNum),Base_Fields.InValidMessage_db_cons_credit_card_user(TotalErrors.ErrorNum),Base_Fields.InValidMessage_db_cons_home_property_type(TotalErrors.ErrorNum),Base_Fields.InValidMessage_db_cons_education_hh(TotalErrors.ErrorNum),Base_Fields.InValidMessage_db_cons_education_ind(TotalErrors.ErrorNum),Base_Fields.InValidMessage_db_cons_other_pet_owner(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_Database_USA, Base_Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT311.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;
