IMPORT SALT311,STD;
IMPORT Scrubs_Database_USA; // Import modules for FieldTypes attribute definitions
EXPORT Base_Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 107;
  EXPORT NumRulesFromFieldType := 107;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 107;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(Scrubs_Database_USA.Base_Layout_Database_USA)
    UNSIGNED1 dt_first_seen_Invalid;
    UNSIGNED1 dt_last_seen_Invalid;
    UNSIGNED1 dt_vendor_first_reported_Invalid;
    UNSIGNED1 dt_vendor_last_reported_Invalid;
    UNSIGNED1 process_date_Invalid;
    UNSIGNED1 record_type_Invalid;
    UNSIGNED1 ind_frm_indicator_Invalid;
    UNSIGNED1 company_name_Invalid;
    UNSIGNED1 full_name_Invalid;
    UNSIGNED1 gender_Invalid;
    UNSIGNED1 primary_exec_flag_Invalid;
    UNSIGNED1 exec_type_Invalid;
    UNSIGNED1 phy_addr_state_Invalid;
    UNSIGNED1 phy_addr_zip_Invalid;
    UNSIGNED1 mail_addr_state_Invalid;
    UNSIGNED1 mail_addr_zip_Invalid;
    UNSIGNED1 mail_score_Invalid;
    UNSIGNED1 phone_Invalid;
    UNSIGNED1 email_Invalid;
    UNSIGNED1 email_available_indicator_Invalid;
    UNSIGNED1 url_Invalid;
    UNSIGNED1 business_status_code_Invalid;
    UNSIGNED1 franchise_flag_Invalid;
    UNSIGNED1 franchise_type_Invalid;
    UNSIGNED1 county_code_Invalid;
    UNSIGNED1 primary_sic_Invalid;
    UNSIGNED1 sic02_Invalid;
    UNSIGNED1 sic03_Invalid;
    UNSIGNED1 sic04_Invalid;
    UNSIGNED1 sic05_Invalid;
    UNSIGNED1 sic06_Invalid;
    UNSIGNED1 primarysic2_Invalid;
    UNSIGNED1 primarysic4_Invalid;
    UNSIGNED1 naics01_Invalid;
    UNSIGNED1 naics02_Invalid;
    UNSIGNED1 naics03_Invalid;
    UNSIGNED1 naics04_Invalid;
    UNSIGNED1 naics05_Invalid;
    UNSIGNED1 naics06_Invalid;
    UNSIGNED1 location_employee_code_Invalid;
    UNSIGNED1 location_sales_code_Invalid;
    UNSIGNED1 corporate_employee_code_Invalid;
    UNSIGNED1 year_established_Invalid;
    UNSIGNED1 female_owned_Invalid;
    UNSIGNED1 minority_owned_flag_Invalid;
    UNSIGNED1 home_based_indicator_Invalid;
    UNSIGNED1 small_business_indicator_Invalid;
    UNSIGNED1 import_export_Invalid;
    UNSIGNED1 manufacturing_location_Invalid;
    UNSIGNED1 public_indicator_Invalid;
    UNSIGNED1 non_profit_org_Invalid;
    UNSIGNED1 square_footage_code_Invalid;
    UNSIGNED1 creditcode_Invalid;
    UNSIGNED1 credit_capacity_code_Invalid;
    UNSIGNED1 advertising_expenses_code_Invalid;
    UNSIGNED1 technology_expenses_code_Invalid;
    UNSIGNED1 office_equip_expenses_code_Invalid;
    UNSIGNED1 rent_expenses_code_Invalid;
    UNSIGNED1 telecom_expenses_code_Invalid;
    UNSIGNED1 accounting_expenses_code_Invalid;
    UNSIGNED1 bus_insurance_expense_code_Invalid;
    UNSIGNED1 legal_expenses_code_Invalid;
    UNSIGNED1 utilities_expenses_code_Invalid;
    UNSIGNED1 number_of_pcs_code_Invalid;
    UNSIGNED1 nb_flag_Invalid;
    UNSIGNED1 domestic_foreign_owner_flag_Invalid;
    UNSIGNED1 db_cons_full_name_Invalid;
    UNSIGNED1 db_cons_email_Invalid;
    UNSIGNED1 db_cons_gender_Invalid;
    UNSIGNED1 db_cons_date_of_birth_year_Invalid;
    UNSIGNED1 db_cons_date_of_birth_month_Invalid;
    UNSIGNED1 db_cons_age_Invalid;
    UNSIGNED1 db_cons_ethnic_code_Invalid;
    UNSIGNED1 db_cons_religious_affil_Invalid;
    UNSIGNED1 db_cons_language_pref_Invalid;
    UNSIGNED1 db_cons_time_zone_code_Invalid;
    UNSIGNED1 db_cons_phone_Invalid;
    UNSIGNED1 db_cons_dnc_Invalid;
    UNSIGNED1 db_cons_scrubbed_phoneable_Invalid;
    UNSIGNED1 db_cons_children_present_Invalid;
    UNSIGNED1 db_cons_home_value_code_Invalid;
    UNSIGNED1 db_cons_donor_capacity_code_Invalid;
    UNSIGNED1 db_cons_home_owner_renter_Invalid;
    UNSIGNED1 db_cons_length_of_res_code_Invalid;
    UNSIGNED1 db_cons_dwelling_type_Invalid;
    UNSIGNED1 db_cons_recent_home_buyer_Invalid;
    UNSIGNED1 db_cons_income_code_Invalid;
    UNSIGNED1 db_cons_unsecuredcredcapcode_Invalid;
    UNSIGNED1 db_cons_networthhomevalcode_Invalid;
    UNSIGNED1 db_cons_discretincomecode_Invalid;
    UNSIGNED1 db_cons_marital_status_Invalid;
    UNSIGNED1 db_cons_new_parent_Invalid;
    UNSIGNED1 db_cons_child_near_hs_grad_Invalid;
    UNSIGNED1 db_cons_college_graduate_Invalid;
    UNSIGNED1 db_cons_intend_purchase_veh_Invalid;
    UNSIGNED1 db_cons_recent_divorce_Invalid;
    UNSIGNED1 db_cons_newlywed_Invalid;
    UNSIGNED1 db_cons_new_teen_driver_Invalid;
    UNSIGNED1 db_cons_home_year_built_Invalid;
    UNSIGNED1 db_cons_home_sqft_ranges_Invalid;
    UNSIGNED1 db_cons_poli_party_ind_Invalid;
    UNSIGNED1 db_cons_occupation_ind_Invalid;
    UNSIGNED1 db_cons_credit_card_user_Invalid;
    UNSIGNED1 db_cons_home_property_type_Invalid;
    UNSIGNED1 db_cons_education_hh_Invalid;
    UNSIGNED1 db_cons_education_ind_Invalid;
    UNSIGNED1 db_cons_other_pet_owner_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Scrubs_Database_USA.Base_Layout_Database_USA)
    UNSIGNED8 ScrubsBits1;
    UNSIGNED8 ScrubsBits2;
  END;
EXPORT FromNone(DATASET(Scrubs_Database_USA.Base_Layout_Database_USA) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.dt_first_seen_Invalid := Base_Fields.InValid_dt_first_seen((SALT311.StrType)le.dt_first_seen);
    SELF.dt_last_seen_Invalid := Base_Fields.InValid_dt_last_seen((SALT311.StrType)le.dt_last_seen);
    SELF.dt_vendor_first_reported_Invalid := Base_Fields.InValid_dt_vendor_first_reported((SALT311.StrType)le.dt_vendor_first_reported);
    SELF.dt_vendor_last_reported_Invalid := Base_Fields.InValid_dt_vendor_last_reported((SALT311.StrType)le.dt_vendor_last_reported);
    SELF.process_date_Invalid := Base_Fields.InValid_process_date((SALT311.StrType)le.process_date);
    SELF.record_type_Invalid := Base_Fields.InValid_record_type((SALT311.StrType)le.record_type);
    SELF.ind_frm_indicator_Invalid := Base_Fields.InValid_ind_frm_indicator((SALT311.StrType)le.ind_frm_indicator);
    SELF.company_name_Invalid := Base_Fields.InValid_company_name((SALT311.StrType)le.company_name);
    SELF.full_name_Invalid := Base_Fields.InValid_full_name((SALT311.StrType)le.full_name);
    SELF.gender_Invalid := Base_Fields.InValid_gender((SALT311.StrType)le.gender);
    SELF.primary_exec_flag_Invalid := Base_Fields.InValid_primary_exec_flag((SALT311.StrType)le.primary_exec_flag);
    SELF.exec_type_Invalid := Base_Fields.InValid_exec_type((SALT311.StrType)le.exec_type);
    SELF.phy_addr_state_Invalid := Base_Fields.InValid_phy_addr_state((SALT311.StrType)le.phy_addr_state);
    SELF.phy_addr_zip_Invalid := Base_Fields.InValid_phy_addr_zip((SALT311.StrType)le.phy_addr_zip);
    SELF.mail_addr_state_Invalid := Base_Fields.InValid_mail_addr_state((SALT311.StrType)le.mail_addr_state);
    SELF.mail_addr_zip_Invalid := Base_Fields.InValid_mail_addr_zip((SALT311.StrType)le.mail_addr_zip);
    SELF.mail_score_Invalid := Base_Fields.InValid_mail_score((SALT311.StrType)le.mail_score);
    SELF.phone_Invalid := Base_Fields.InValid_phone((SALT311.StrType)le.phone);
    SELF.email_Invalid := Base_Fields.InValid_email((SALT311.StrType)le.email);
    SELF.email_available_indicator_Invalid := Base_Fields.InValid_email_available_indicator((SALT311.StrType)le.email_available_indicator);
    SELF.url_Invalid := Base_Fields.InValid_url((SALT311.StrType)le.url);
    SELF.business_status_code_Invalid := Base_Fields.InValid_business_status_code((SALT311.StrType)le.business_status_code);
    SELF.franchise_flag_Invalid := Base_Fields.InValid_franchise_flag((SALT311.StrType)le.franchise_flag);
    SELF.franchise_type_Invalid := Base_Fields.InValid_franchise_type((SALT311.StrType)le.franchise_type);
    SELF.county_code_Invalid := Base_Fields.InValid_county_code((SALT311.StrType)le.county_code);
    SELF.primary_sic_Invalid := Base_Fields.InValid_primary_sic((SALT311.StrType)le.primary_sic);
    SELF.sic02_Invalid := Base_Fields.InValid_sic02((SALT311.StrType)le.sic02);
    SELF.sic03_Invalid := Base_Fields.InValid_sic03((SALT311.StrType)le.sic03);
    SELF.sic04_Invalid := Base_Fields.InValid_sic04((SALT311.StrType)le.sic04);
    SELF.sic05_Invalid := Base_Fields.InValid_sic05((SALT311.StrType)le.sic05);
    SELF.sic06_Invalid := Base_Fields.InValid_sic06((SALT311.StrType)le.sic06);
    SELF.primarysic2_Invalid := Base_Fields.InValid_primarysic2((SALT311.StrType)le.primarysic2);
    SELF.primarysic4_Invalid := Base_Fields.InValid_primarysic4((SALT311.StrType)le.primarysic4);
    SELF.naics01_Invalid := Base_Fields.InValid_naics01((SALT311.StrType)le.naics01);
    SELF.naics02_Invalid := Base_Fields.InValid_naics02((SALT311.StrType)le.naics02);
    SELF.naics03_Invalid := Base_Fields.InValid_naics03((SALT311.StrType)le.naics03);
    SELF.naics04_Invalid := Base_Fields.InValid_naics04((SALT311.StrType)le.naics04);
    SELF.naics05_Invalid := Base_Fields.InValid_naics05((SALT311.StrType)le.naics05);
    SELF.naics06_Invalid := Base_Fields.InValid_naics06((SALT311.StrType)le.naics06);
    SELF.location_employee_code_Invalid := Base_Fields.InValid_location_employee_code((SALT311.StrType)le.location_employee_code);
    SELF.location_sales_code_Invalid := Base_Fields.InValid_location_sales_code((SALT311.StrType)le.location_sales_code);
    SELF.corporate_employee_code_Invalid := Base_Fields.InValid_corporate_employee_code((SALT311.StrType)le.corporate_employee_code);
    SELF.year_established_Invalid := Base_Fields.InValid_year_established((SALT311.StrType)le.year_established);
    SELF.female_owned_Invalid := Base_Fields.InValid_female_owned((SALT311.StrType)le.female_owned);
    SELF.minority_owned_flag_Invalid := Base_Fields.InValid_minority_owned_flag((SALT311.StrType)le.minority_owned_flag);
    SELF.home_based_indicator_Invalid := Base_Fields.InValid_home_based_indicator((SALT311.StrType)le.home_based_indicator);
    SELF.small_business_indicator_Invalid := Base_Fields.InValid_small_business_indicator((SALT311.StrType)le.small_business_indicator);
    SELF.import_export_Invalid := Base_Fields.InValid_import_export((SALT311.StrType)le.import_export);
    SELF.manufacturing_location_Invalid := Base_Fields.InValid_manufacturing_location((SALT311.StrType)le.manufacturing_location);
    SELF.public_indicator_Invalid := Base_Fields.InValid_public_indicator((SALT311.StrType)le.public_indicator);
    SELF.non_profit_org_Invalid := Base_Fields.InValid_non_profit_org((SALT311.StrType)le.non_profit_org);
    SELF.square_footage_code_Invalid := Base_Fields.InValid_square_footage_code((SALT311.StrType)le.square_footage_code);
    SELF.creditcode_Invalid := Base_Fields.InValid_creditcode((SALT311.StrType)le.creditcode);
    SELF.credit_capacity_code_Invalid := Base_Fields.InValid_credit_capacity_code((SALT311.StrType)le.credit_capacity_code);
    SELF.advertising_expenses_code_Invalid := Base_Fields.InValid_advertising_expenses_code((SALT311.StrType)le.advertising_expenses_code);
    SELF.technology_expenses_code_Invalid := Base_Fields.InValid_technology_expenses_code((SALT311.StrType)le.technology_expenses_code);
    SELF.office_equip_expenses_code_Invalid := Base_Fields.InValid_office_equip_expenses_code((SALT311.StrType)le.office_equip_expenses_code);
    SELF.rent_expenses_code_Invalid := Base_Fields.InValid_rent_expenses_code((SALT311.StrType)le.rent_expenses_code);
    SELF.telecom_expenses_code_Invalid := Base_Fields.InValid_telecom_expenses_code((SALT311.StrType)le.telecom_expenses_code);
    SELF.accounting_expenses_code_Invalid := Base_Fields.InValid_accounting_expenses_code((SALT311.StrType)le.accounting_expenses_code);
    SELF.bus_insurance_expense_code_Invalid := Base_Fields.InValid_bus_insurance_expense_code((SALT311.StrType)le.bus_insurance_expense_code);
    SELF.legal_expenses_code_Invalid := Base_Fields.InValid_legal_expenses_code((SALT311.StrType)le.legal_expenses_code);
    SELF.utilities_expenses_code_Invalid := Base_Fields.InValid_utilities_expenses_code((SALT311.StrType)le.utilities_expenses_code);
    SELF.number_of_pcs_code_Invalid := Base_Fields.InValid_number_of_pcs_code((SALT311.StrType)le.number_of_pcs_code);
    SELF.nb_flag_Invalid := Base_Fields.InValid_nb_flag((SALT311.StrType)le.nb_flag);
    SELF.domestic_foreign_owner_flag_Invalid := Base_Fields.InValid_domestic_foreign_owner_flag((SALT311.StrType)le.domestic_foreign_owner_flag);
    SELF.db_cons_full_name_Invalid := Base_Fields.InValid_db_cons_full_name((SALT311.StrType)le.db_cons_full_name);
    SELF.db_cons_email_Invalid := Base_Fields.InValid_db_cons_email((SALT311.StrType)le.db_cons_email);
    SELF.db_cons_gender_Invalid := Base_Fields.InValid_db_cons_gender((SALT311.StrType)le.db_cons_gender);
    SELF.db_cons_date_of_birth_year_Invalid := Base_Fields.InValid_db_cons_date_of_birth_year((SALT311.StrType)le.db_cons_date_of_birth_year);
    SELF.db_cons_date_of_birth_month_Invalid := Base_Fields.InValid_db_cons_date_of_birth_month((SALT311.StrType)le.db_cons_date_of_birth_month);
    SELF.db_cons_age_Invalid := Base_Fields.InValid_db_cons_age((SALT311.StrType)le.db_cons_age);
    SELF.db_cons_ethnic_code_Invalid := Base_Fields.InValid_db_cons_ethnic_code((SALT311.StrType)le.db_cons_ethnic_code);
    SELF.db_cons_religious_affil_Invalid := Base_Fields.InValid_db_cons_religious_affil((SALT311.StrType)le.db_cons_religious_affil);
    SELF.db_cons_language_pref_Invalid := Base_Fields.InValid_db_cons_language_pref((SALT311.StrType)le.db_cons_language_pref);
    SELF.db_cons_time_zone_code_Invalid := Base_Fields.InValid_db_cons_time_zone_code((SALT311.StrType)le.db_cons_time_zone_code);
    SELF.db_cons_phone_Invalid := Base_Fields.InValid_db_cons_phone((SALT311.StrType)le.db_cons_phone);
    SELF.db_cons_dnc_Invalid := Base_Fields.InValid_db_cons_dnc((SALT311.StrType)le.db_cons_dnc);
    SELF.db_cons_scrubbed_phoneable_Invalid := Base_Fields.InValid_db_cons_scrubbed_phoneable((SALT311.StrType)le.db_cons_scrubbed_phoneable);
    SELF.db_cons_children_present_Invalid := Base_Fields.InValid_db_cons_children_present((SALT311.StrType)le.db_cons_children_present);
    SELF.db_cons_home_value_code_Invalid := Base_Fields.InValid_db_cons_home_value_code((SALT311.StrType)le.db_cons_home_value_code);
    SELF.db_cons_donor_capacity_code_Invalid := Base_Fields.InValid_db_cons_donor_capacity_code((SALT311.StrType)le.db_cons_donor_capacity_code);
    SELF.db_cons_home_owner_renter_Invalid := Base_Fields.InValid_db_cons_home_owner_renter((SALT311.StrType)le.db_cons_home_owner_renter);
    SELF.db_cons_length_of_res_code_Invalid := Base_Fields.InValid_db_cons_length_of_res_code((SALT311.StrType)le.db_cons_length_of_res_code);
    SELF.db_cons_dwelling_type_Invalid := Base_Fields.InValid_db_cons_dwelling_type((SALT311.StrType)le.db_cons_dwelling_type);
    SELF.db_cons_recent_home_buyer_Invalid := Base_Fields.InValid_db_cons_recent_home_buyer((SALT311.StrType)le.db_cons_recent_home_buyer);
    SELF.db_cons_income_code_Invalid := Base_Fields.InValid_db_cons_income_code((SALT311.StrType)le.db_cons_income_code);
    SELF.db_cons_unsecuredcredcapcode_Invalid := Base_Fields.InValid_db_cons_unsecuredcredcapcode((SALT311.StrType)le.db_cons_unsecuredcredcapcode);
    SELF.db_cons_networthhomevalcode_Invalid := Base_Fields.InValid_db_cons_networthhomevalcode((SALT311.StrType)le.db_cons_networthhomevalcode);
    SELF.db_cons_discretincomecode_Invalid := Base_Fields.InValid_db_cons_discretincomecode((SALT311.StrType)le.db_cons_discretincomecode);
    SELF.db_cons_marital_status_Invalid := Base_Fields.InValid_db_cons_marital_status((SALT311.StrType)le.db_cons_marital_status);
    SELF.db_cons_new_parent_Invalid := Base_Fields.InValid_db_cons_new_parent((SALT311.StrType)le.db_cons_new_parent);
    SELF.db_cons_child_near_hs_grad_Invalid := Base_Fields.InValid_db_cons_child_near_hs_grad((SALT311.StrType)le.db_cons_child_near_hs_grad);
    SELF.db_cons_college_graduate_Invalid := Base_Fields.InValid_db_cons_college_graduate((SALT311.StrType)le.db_cons_college_graduate);
    SELF.db_cons_intend_purchase_veh_Invalid := Base_Fields.InValid_db_cons_intend_purchase_veh((SALT311.StrType)le.db_cons_intend_purchase_veh);
    SELF.db_cons_recent_divorce_Invalid := Base_Fields.InValid_db_cons_recent_divorce((SALT311.StrType)le.db_cons_recent_divorce);
    SELF.db_cons_newlywed_Invalid := Base_Fields.InValid_db_cons_newlywed((SALT311.StrType)le.db_cons_newlywed);
    SELF.db_cons_new_teen_driver_Invalid := Base_Fields.InValid_db_cons_new_teen_driver((SALT311.StrType)le.db_cons_new_teen_driver);
    SELF.db_cons_home_year_built_Invalid := Base_Fields.InValid_db_cons_home_year_built((SALT311.StrType)le.db_cons_home_year_built);
    SELF.db_cons_home_sqft_ranges_Invalid := Base_Fields.InValid_db_cons_home_sqft_ranges((SALT311.StrType)le.db_cons_home_sqft_ranges);
    SELF.db_cons_poli_party_ind_Invalid := Base_Fields.InValid_db_cons_poli_party_ind((SALT311.StrType)le.db_cons_poli_party_ind);
    SELF.db_cons_occupation_ind_Invalid := Base_Fields.InValid_db_cons_occupation_ind((SALT311.StrType)le.db_cons_occupation_ind);
    SELF.db_cons_credit_card_user_Invalid := Base_Fields.InValid_db_cons_credit_card_user((SALT311.StrType)le.db_cons_credit_card_user);
    SELF.db_cons_home_property_type_Invalid := Base_Fields.InValid_db_cons_home_property_type((SALT311.StrType)le.db_cons_home_property_type);
    SELF.db_cons_education_hh_Invalid := Base_Fields.InValid_db_cons_education_hh((SALT311.StrType)le.db_cons_education_hh);
    SELF.db_cons_education_ind_Invalid := Base_Fields.InValid_db_cons_education_ind((SALT311.StrType)le.db_cons_education_ind);
    SELF.db_cons_other_pet_owner_Invalid := Base_Fields.InValid_db_cons_other_pet_owner((SALT311.StrType)le.db_cons_other_pet_owner);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Scrubs_Database_USA.Base_Layout_Database_USA);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.dt_first_seen_Invalid << 0 ) + ( le.dt_last_seen_Invalid << 1 ) + ( le.dt_vendor_first_reported_Invalid << 2 ) + ( le.dt_vendor_last_reported_Invalid << 3 ) + ( le.process_date_Invalid << 4 ) + ( le.record_type_Invalid << 5 ) + ( le.ind_frm_indicator_Invalid << 6 ) + ( le.company_name_Invalid << 7 ) + ( le.full_name_Invalid << 8 ) + ( le.gender_Invalid << 9 ) + ( le.primary_exec_flag_Invalid << 10 ) + ( le.exec_type_Invalid << 11 ) + ( le.phy_addr_state_Invalid << 12 ) + ( le.phy_addr_zip_Invalid << 13 ) + ( le.mail_addr_state_Invalid << 14 ) + ( le.mail_addr_zip_Invalid << 15 ) + ( le.mail_score_Invalid << 16 ) + ( le.phone_Invalid << 17 ) + ( le.email_Invalid << 18 ) + ( le.email_available_indicator_Invalid << 19 ) + ( le.url_Invalid << 20 ) + ( le.business_status_code_Invalid << 21 ) + ( le.franchise_flag_Invalid << 22 ) + ( le.franchise_type_Invalid << 23 ) + ( le.county_code_Invalid << 24 ) + ( le.primary_sic_Invalid << 25 ) + ( le.sic02_Invalid << 26 ) + ( le.sic03_Invalid << 27 ) + ( le.sic04_Invalid << 28 ) + ( le.sic05_Invalid << 29 ) + ( le.sic06_Invalid << 30 ) + ( le.primarysic2_Invalid << 31 ) + ( le.primarysic4_Invalid << 32 ) + ( le.naics01_Invalid << 33 ) + ( le.naics02_Invalid << 34 ) + ( le.naics03_Invalid << 35 ) + ( le.naics04_Invalid << 36 ) + ( le.naics05_Invalid << 37 ) + ( le.naics06_Invalid << 38 ) + ( le.location_employee_code_Invalid << 39 ) + ( le.location_sales_code_Invalid << 40 ) + ( le.corporate_employee_code_Invalid << 41 ) + ( le.year_established_Invalid << 42 ) + ( le.female_owned_Invalid << 43 ) + ( le.minority_owned_flag_Invalid << 44 ) + ( le.home_based_indicator_Invalid << 45 ) + ( le.small_business_indicator_Invalid << 46 ) + ( le.import_export_Invalid << 47 ) + ( le.manufacturing_location_Invalid << 48 ) + ( le.public_indicator_Invalid << 49 ) + ( le.non_profit_org_Invalid << 50 ) + ( le.square_footage_code_Invalid << 51 ) + ( le.creditcode_Invalid << 52 ) + ( le.credit_capacity_code_Invalid << 53 ) + ( le.advertising_expenses_code_Invalid << 54 ) + ( le.technology_expenses_code_Invalid << 55 ) + ( le.office_equip_expenses_code_Invalid << 56 ) + ( le.rent_expenses_code_Invalid << 57 ) + ( le.telecom_expenses_code_Invalid << 58 ) + ( le.accounting_expenses_code_Invalid << 59 ) + ( le.bus_insurance_expense_code_Invalid << 60 ) + ( le.legal_expenses_code_Invalid << 61 ) + ( le.utilities_expenses_code_Invalid << 62 ) + ( le.number_of_pcs_code_Invalid << 63 );
    SELF.ScrubsBits2 := ( le.nb_flag_Invalid << 0 ) + ( le.domestic_foreign_owner_flag_Invalid << 1 ) + ( le.db_cons_full_name_Invalid << 2 ) + ( le.db_cons_email_Invalid << 3 ) + ( le.db_cons_gender_Invalid << 4 ) + ( le.db_cons_date_of_birth_year_Invalid << 5 ) + ( le.db_cons_date_of_birth_month_Invalid << 6 ) + ( le.db_cons_age_Invalid << 7 ) + ( le.db_cons_ethnic_code_Invalid << 8 ) + ( le.db_cons_religious_affil_Invalid << 9 ) + ( le.db_cons_language_pref_Invalid << 10 ) + ( le.db_cons_time_zone_code_Invalid << 11 ) + ( le.db_cons_phone_Invalid << 12 ) + ( le.db_cons_dnc_Invalid << 13 ) + ( le.db_cons_scrubbed_phoneable_Invalid << 14 ) + ( le.db_cons_children_present_Invalid << 15 ) + ( le.db_cons_home_value_code_Invalid << 16 ) + ( le.db_cons_donor_capacity_code_Invalid << 17 ) + ( le.db_cons_home_owner_renter_Invalid << 18 ) + ( le.db_cons_length_of_res_code_Invalid << 19 ) + ( le.db_cons_dwelling_type_Invalid << 20 ) + ( le.db_cons_recent_home_buyer_Invalid << 21 ) + ( le.db_cons_income_code_Invalid << 22 ) + ( le.db_cons_unsecuredcredcapcode_Invalid << 23 ) + ( le.db_cons_networthhomevalcode_Invalid << 24 ) + ( le.db_cons_discretincomecode_Invalid << 25 ) + ( le.db_cons_marital_status_Invalid << 26 ) + ( le.db_cons_new_parent_Invalid << 27 ) + ( le.db_cons_child_near_hs_grad_Invalid << 28 ) + ( le.db_cons_college_graduate_Invalid << 29 ) + ( le.db_cons_intend_purchase_veh_Invalid << 30 ) + ( le.db_cons_recent_divorce_Invalid << 31 ) + ( le.db_cons_newlywed_Invalid << 32 ) + ( le.db_cons_new_teen_driver_Invalid << 33 ) + ( le.db_cons_home_year_built_Invalid << 34 ) + ( le.db_cons_home_sqft_ranges_Invalid << 35 ) + ( le.db_cons_poli_party_ind_Invalid << 36 ) + ( le.db_cons_occupation_ind_Invalid << 37 ) + ( le.db_cons_credit_card_user_Invalid << 38 ) + ( le.db_cons_home_property_type_Invalid << 39 ) + ( le.db_cons_education_hh_Invalid << 40 ) + ( le.db_cons_education_ind_Invalid << 41 ) + ( le.db_cons_other_pet_owner_Invalid << 42 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Scrubs_Database_USA.Base_Layout_Database_USA);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.dt_first_seen_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.dt_last_seen_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.dt_vendor_first_reported_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.dt_vendor_last_reported_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.process_date_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.record_type_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.ind_frm_indicator_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.company_name_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.full_name_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.gender_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF.primary_exec_flag_Invalid := (le.ScrubsBits1 >> 10) & 1;
    SELF.exec_type_Invalid := (le.ScrubsBits1 >> 11) & 1;
    SELF.phy_addr_state_Invalid := (le.ScrubsBits1 >> 12) & 1;
    SELF.phy_addr_zip_Invalid := (le.ScrubsBits1 >> 13) & 1;
    SELF.mail_addr_state_Invalid := (le.ScrubsBits1 >> 14) & 1;
    SELF.mail_addr_zip_Invalid := (le.ScrubsBits1 >> 15) & 1;
    SELF.mail_score_Invalid := (le.ScrubsBits1 >> 16) & 1;
    SELF.phone_Invalid := (le.ScrubsBits1 >> 17) & 1;
    SELF.email_Invalid := (le.ScrubsBits1 >> 18) & 1;
    SELF.email_available_indicator_Invalid := (le.ScrubsBits1 >> 19) & 1;
    SELF.url_Invalid := (le.ScrubsBits1 >> 20) & 1;
    SELF.business_status_code_Invalid := (le.ScrubsBits1 >> 21) & 1;
    SELF.franchise_flag_Invalid := (le.ScrubsBits1 >> 22) & 1;
    SELF.franchise_type_Invalid := (le.ScrubsBits1 >> 23) & 1;
    SELF.county_code_Invalid := (le.ScrubsBits1 >> 24) & 1;
    SELF.primary_sic_Invalid := (le.ScrubsBits1 >> 25) & 1;
    SELF.sic02_Invalid := (le.ScrubsBits1 >> 26) & 1;
    SELF.sic03_Invalid := (le.ScrubsBits1 >> 27) & 1;
    SELF.sic04_Invalid := (le.ScrubsBits1 >> 28) & 1;
    SELF.sic05_Invalid := (le.ScrubsBits1 >> 29) & 1;
    SELF.sic06_Invalid := (le.ScrubsBits1 >> 30) & 1;
    SELF.primarysic2_Invalid := (le.ScrubsBits1 >> 31) & 1;
    SELF.primarysic4_Invalid := (le.ScrubsBits1 >> 32) & 1;
    SELF.naics01_Invalid := (le.ScrubsBits1 >> 33) & 1;
    SELF.naics02_Invalid := (le.ScrubsBits1 >> 34) & 1;
    SELF.naics03_Invalid := (le.ScrubsBits1 >> 35) & 1;
    SELF.naics04_Invalid := (le.ScrubsBits1 >> 36) & 1;
    SELF.naics05_Invalid := (le.ScrubsBits1 >> 37) & 1;
    SELF.naics06_Invalid := (le.ScrubsBits1 >> 38) & 1;
    SELF.location_employee_code_Invalid := (le.ScrubsBits1 >> 39) & 1;
    SELF.location_sales_code_Invalid := (le.ScrubsBits1 >> 40) & 1;
    SELF.corporate_employee_code_Invalid := (le.ScrubsBits1 >> 41) & 1;
    SELF.year_established_Invalid := (le.ScrubsBits1 >> 42) & 1;
    SELF.female_owned_Invalid := (le.ScrubsBits1 >> 43) & 1;
    SELF.minority_owned_flag_Invalid := (le.ScrubsBits1 >> 44) & 1;
    SELF.home_based_indicator_Invalid := (le.ScrubsBits1 >> 45) & 1;
    SELF.small_business_indicator_Invalid := (le.ScrubsBits1 >> 46) & 1;
    SELF.import_export_Invalid := (le.ScrubsBits1 >> 47) & 1;
    SELF.manufacturing_location_Invalid := (le.ScrubsBits1 >> 48) & 1;
    SELF.public_indicator_Invalid := (le.ScrubsBits1 >> 49) & 1;
    SELF.non_profit_org_Invalid := (le.ScrubsBits1 >> 50) & 1;
    SELF.square_footage_code_Invalid := (le.ScrubsBits1 >> 51) & 1;
    SELF.creditcode_Invalid := (le.ScrubsBits1 >> 52) & 1;
    SELF.credit_capacity_code_Invalid := (le.ScrubsBits1 >> 53) & 1;
    SELF.advertising_expenses_code_Invalid := (le.ScrubsBits1 >> 54) & 1;
    SELF.technology_expenses_code_Invalid := (le.ScrubsBits1 >> 55) & 1;
    SELF.office_equip_expenses_code_Invalid := (le.ScrubsBits1 >> 56) & 1;
    SELF.rent_expenses_code_Invalid := (le.ScrubsBits1 >> 57) & 1;
    SELF.telecom_expenses_code_Invalid := (le.ScrubsBits1 >> 58) & 1;
    SELF.accounting_expenses_code_Invalid := (le.ScrubsBits1 >> 59) & 1;
    SELF.bus_insurance_expense_code_Invalid := (le.ScrubsBits1 >> 60) & 1;
    SELF.legal_expenses_code_Invalid := (le.ScrubsBits1 >> 61) & 1;
    SELF.utilities_expenses_code_Invalid := (le.ScrubsBits1 >> 62) & 1;
    SELF.number_of_pcs_code_Invalid := (le.ScrubsBits1 >> 63) & 1;
    SELF.nb_flag_Invalid := (le.ScrubsBits2 >> 0) & 1;
    SELF.domestic_foreign_owner_flag_Invalid := (le.ScrubsBits2 >> 1) & 1;
    SELF.db_cons_full_name_Invalid := (le.ScrubsBits2 >> 2) & 1;
    SELF.db_cons_email_Invalid := (le.ScrubsBits2 >> 3) & 1;
    SELF.db_cons_gender_Invalid := (le.ScrubsBits2 >> 4) & 1;
    SELF.db_cons_date_of_birth_year_Invalid := (le.ScrubsBits2 >> 5) & 1;
    SELF.db_cons_date_of_birth_month_Invalid := (le.ScrubsBits2 >> 6) & 1;
    SELF.db_cons_age_Invalid := (le.ScrubsBits2 >> 7) & 1;
    SELF.db_cons_ethnic_code_Invalid := (le.ScrubsBits2 >> 8) & 1;
    SELF.db_cons_religious_affil_Invalid := (le.ScrubsBits2 >> 9) & 1;
    SELF.db_cons_language_pref_Invalid := (le.ScrubsBits2 >> 10) & 1;
    SELF.db_cons_time_zone_code_Invalid := (le.ScrubsBits2 >> 11) & 1;
    SELF.db_cons_phone_Invalid := (le.ScrubsBits2 >> 12) & 1;
    SELF.db_cons_dnc_Invalid := (le.ScrubsBits2 >> 13) & 1;
    SELF.db_cons_scrubbed_phoneable_Invalid := (le.ScrubsBits2 >> 14) & 1;
    SELF.db_cons_children_present_Invalid := (le.ScrubsBits2 >> 15) & 1;
    SELF.db_cons_home_value_code_Invalid := (le.ScrubsBits2 >> 16) & 1;
    SELF.db_cons_donor_capacity_code_Invalid := (le.ScrubsBits2 >> 17) & 1;
    SELF.db_cons_home_owner_renter_Invalid := (le.ScrubsBits2 >> 18) & 1;
    SELF.db_cons_length_of_res_code_Invalid := (le.ScrubsBits2 >> 19) & 1;
    SELF.db_cons_dwelling_type_Invalid := (le.ScrubsBits2 >> 20) & 1;
    SELF.db_cons_recent_home_buyer_Invalid := (le.ScrubsBits2 >> 21) & 1;
    SELF.db_cons_income_code_Invalid := (le.ScrubsBits2 >> 22) & 1;
    SELF.db_cons_unsecuredcredcapcode_Invalid := (le.ScrubsBits2 >> 23) & 1;
    SELF.db_cons_networthhomevalcode_Invalid := (le.ScrubsBits2 >> 24) & 1;
    SELF.db_cons_discretincomecode_Invalid := (le.ScrubsBits2 >> 25) & 1;
    SELF.db_cons_marital_status_Invalid := (le.ScrubsBits2 >> 26) & 1;
    SELF.db_cons_new_parent_Invalid := (le.ScrubsBits2 >> 27) & 1;
    SELF.db_cons_child_near_hs_grad_Invalid := (le.ScrubsBits2 >> 28) & 1;
    SELF.db_cons_college_graduate_Invalid := (le.ScrubsBits2 >> 29) & 1;
    SELF.db_cons_intend_purchase_veh_Invalid := (le.ScrubsBits2 >> 30) & 1;
    SELF.db_cons_recent_divorce_Invalid := (le.ScrubsBits2 >> 31) & 1;
    SELF.db_cons_newlywed_Invalid := (le.ScrubsBits2 >> 32) & 1;
    SELF.db_cons_new_teen_driver_Invalid := (le.ScrubsBits2 >> 33) & 1;
    SELF.db_cons_home_year_built_Invalid := (le.ScrubsBits2 >> 34) & 1;
    SELF.db_cons_home_sqft_ranges_Invalid := (le.ScrubsBits2 >> 35) & 1;
    SELF.db_cons_poli_party_ind_Invalid := (le.ScrubsBits2 >> 36) & 1;
    SELF.db_cons_occupation_ind_Invalid := (le.ScrubsBits2 >> 37) & 1;
    SELF.db_cons_credit_card_user_Invalid := (le.ScrubsBits2 >> 38) & 1;
    SELF.db_cons_home_property_type_Invalid := (le.ScrubsBits2 >> 39) & 1;
    SELF.db_cons_education_hh_Invalid := (le.ScrubsBits2 >> 40) & 1;
    SELF.db_cons_education_ind_Invalid := (le.ScrubsBits2 >> 41) & 1;
    SELF.db_cons_other_pet_owner_Invalid := (le.ScrubsBits2 >> 42) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    dt_first_seen_CUSTOM_ErrorCount := COUNT(GROUP,h.dt_first_seen_Invalid=1);
    dt_last_seen_CUSTOM_ErrorCount := COUNT(GROUP,h.dt_last_seen_Invalid=1);
    dt_vendor_first_reported_CUSTOM_ErrorCount := COUNT(GROUP,h.dt_vendor_first_reported_Invalid=1);
    dt_vendor_last_reported_CUSTOM_ErrorCount := COUNT(GROUP,h.dt_vendor_last_reported_Invalid=1);
    process_date_CUSTOM_ErrorCount := COUNT(GROUP,h.process_date_Invalid=1);
    record_type_ENUM_ErrorCount := COUNT(GROUP,h.record_type_Invalid=1);
    ind_frm_indicator_ENUM_ErrorCount := COUNT(GROUP,h.ind_frm_indicator_Invalid=1);
    company_name_LENGTHS_ErrorCount := COUNT(GROUP,h.company_name_Invalid=1);
    full_name_LENGTHS_ErrorCount := COUNT(GROUP,h.full_name_Invalid=1);
    gender_ENUM_ErrorCount := COUNT(GROUP,h.gender_Invalid=1);
    primary_exec_flag_ENUM_ErrorCount := COUNT(GROUP,h.primary_exec_flag_Invalid=1);
    exec_type_ENUM_ErrorCount := COUNT(GROUP,h.exec_type_Invalid=1);
    phy_addr_state_CUSTOM_ErrorCount := COUNT(GROUP,h.phy_addr_state_Invalid=1);
    phy_addr_zip_CUSTOM_ErrorCount := COUNT(GROUP,h.phy_addr_zip_Invalid=1);
    mail_addr_state_CUSTOM_ErrorCount := COUNT(GROUP,h.mail_addr_state_Invalid=1);
    mail_addr_zip_CUSTOM_ErrorCount := COUNT(GROUP,h.mail_addr_zip_Invalid=1);
    mail_score_CUSTOM_ErrorCount := COUNT(GROUP,h.mail_score_Invalid=1);
    phone_CUSTOM_ErrorCount := COUNT(GROUP,h.phone_Invalid=1);
    email_ALLOW_ErrorCount := COUNT(GROUP,h.email_Invalid=1);
    email_available_indicator_ENUM_ErrorCount := COUNT(GROUP,h.email_available_indicator_Invalid=1);
    url_CUSTOM_ErrorCount := COUNT(GROUP,h.url_Invalid=1);
    business_status_code_ENUM_ErrorCount := COUNT(GROUP,h.business_status_code_Invalid=1);
    franchise_flag_ENUM_ErrorCount := COUNT(GROUP,h.franchise_flag_Invalid=1);
    franchise_type_CUSTOM_ErrorCount := COUNT(GROUP,h.franchise_type_Invalid=1);
    county_code_CUSTOM_ErrorCount := COUNT(GROUP,h.county_code_Invalid=1);
    primary_sic_CUSTOM_ErrorCount := COUNT(GROUP,h.primary_sic_Invalid=1);
    sic02_CUSTOM_ErrorCount := COUNT(GROUP,h.sic02_Invalid=1);
    sic03_CUSTOM_ErrorCount := COUNT(GROUP,h.sic03_Invalid=1);
    sic04_CUSTOM_ErrorCount := COUNT(GROUP,h.sic04_Invalid=1);
    sic05_CUSTOM_ErrorCount := COUNT(GROUP,h.sic05_Invalid=1);
    sic06_CUSTOM_ErrorCount := COUNT(GROUP,h.sic06_Invalid=1);
    primarysic2_CUSTOM_ErrorCount := COUNT(GROUP,h.primarysic2_Invalid=1);
    primarysic4_CUSTOM_ErrorCount := COUNT(GROUP,h.primarysic4_Invalid=1);
    naics01_CUSTOM_ErrorCount := COUNT(GROUP,h.naics01_Invalid=1);
    naics02_CUSTOM_ErrorCount := COUNT(GROUP,h.naics02_Invalid=1);
    naics03_CUSTOM_ErrorCount := COUNT(GROUP,h.naics03_Invalid=1);
    naics04_CUSTOM_ErrorCount := COUNT(GROUP,h.naics04_Invalid=1);
    naics05_CUSTOM_ErrorCount := COUNT(GROUP,h.naics05_Invalid=1);
    naics06_CUSTOM_ErrorCount := COUNT(GROUP,h.naics06_Invalid=1);
    location_employee_code_CUSTOM_ErrorCount := COUNT(GROUP,h.location_employee_code_Invalid=1);
    location_sales_code_CUSTOM_ErrorCount := COUNT(GROUP,h.location_sales_code_Invalid=1);
    corporate_employee_code_CUSTOM_ErrorCount := COUNT(GROUP,h.corporate_employee_code_Invalid=1);
    year_established_CUSTOM_ErrorCount := COUNT(GROUP,h.year_established_Invalid=1);
    female_owned_ENUM_ErrorCount := COUNT(GROUP,h.female_owned_Invalid=1);
    minority_owned_flag_ENUM_ErrorCount := COUNT(GROUP,h.minority_owned_flag_Invalid=1);
    home_based_indicator_ENUM_ErrorCount := COUNT(GROUP,h.home_based_indicator_Invalid=1);
    small_business_indicator_ENUM_ErrorCount := COUNT(GROUP,h.small_business_indicator_Invalid=1);
    import_export_ENUM_ErrorCount := COUNT(GROUP,h.import_export_Invalid=1);
    manufacturing_location_ENUM_ErrorCount := COUNT(GROUP,h.manufacturing_location_Invalid=1);
    public_indicator_ENUM_ErrorCount := COUNT(GROUP,h.public_indicator_Invalid=1);
    non_profit_org_ENUM_ErrorCount := COUNT(GROUP,h.non_profit_org_Invalid=1);
    square_footage_code_CUSTOM_ErrorCount := COUNT(GROUP,h.square_footage_code_Invalid=1);
    creditcode_CUSTOM_ErrorCount := COUNT(GROUP,h.creditcode_Invalid=1);
    credit_capacity_code_CUSTOM_ErrorCount := COUNT(GROUP,h.credit_capacity_code_Invalid=1);
    advertising_expenses_code_CUSTOM_ErrorCount := COUNT(GROUP,h.advertising_expenses_code_Invalid=1);
    technology_expenses_code_CUSTOM_ErrorCount := COUNT(GROUP,h.technology_expenses_code_Invalid=1);
    office_equip_expenses_code_CUSTOM_ErrorCount := COUNT(GROUP,h.office_equip_expenses_code_Invalid=1);
    rent_expenses_code_CUSTOM_ErrorCount := COUNT(GROUP,h.rent_expenses_code_Invalid=1);
    telecom_expenses_code_CUSTOM_ErrorCount := COUNT(GROUP,h.telecom_expenses_code_Invalid=1);
    accounting_expenses_code_CUSTOM_ErrorCount := COUNT(GROUP,h.accounting_expenses_code_Invalid=1);
    bus_insurance_expense_code_CUSTOM_ErrorCount := COUNT(GROUP,h.bus_insurance_expense_code_Invalid=1);
    legal_expenses_code_CUSTOM_ErrorCount := COUNT(GROUP,h.legal_expenses_code_Invalid=1);
    utilities_expenses_code_CUSTOM_ErrorCount := COUNT(GROUP,h.utilities_expenses_code_Invalid=1);
    number_of_pcs_code_CUSTOM_ErrorCount := COUNT(GROUP,h.number_of_pcs_code_Invalid=1);
    nb_flag_ENUM_ErrorCount := COUNT(GROUP,h.nb_flag_Invalid=1);
    domestic_foreign_owner_flag_ENUM_ErrorCount := COUNT(GROUP,h.domestic_foreign_owner_flag_Invalid=1);
    db_cons_full_name_LENGTHS_ErrorCount := COUNT(GROUP,h.db_cons_full_name_Invalid=1);
    db_cons_email_ALLOW_ErrorCount := COUNT(GROUP,h.db_cons_email_Invalid=1);
    db_cons_gender_ENUM_ErrorCount := COUNT(GROUP,h.db_cons_gender_Invalid=1);
    db_cons_date_of_birth_year_CUSTOM_ErrorCount := COUNT(GROUP,h.db_cons_date_of_birth_year_Invalid=1);
    db_cons_date_of_birth_month_ENUM_ErrorCount := COUNT(GROUP,h.db_cons_date_of_birth_month_Invalid=1);
    db_cons_age_ALLOW_ErrorCount := COUNT(GROUP,h.db_cons_age_Invalid=1);
    db_cons_ethnic_code_CUSTOM_ErrorCount := COUNT(GROUP,h.db_cons_ethnic_code_Invalid=1);
    db_cons_religious_affil_CUSTOM_ErrorCount := COUNT(GROUP,h.db_cons_religious_affil_Invalid=1);
    db_cons_language_pref_CUSTOM_ErrorCount := COUNT(GROUP,h.db_cons_language_pref_Invalid=1);
    db_cons_time_zone_code_CUSTOM_ErrorCount := COUNT(GROUP,h.db_cons_time_zone_code_Invalid=1);
    db_cons_phone_CUSTOM_ErrorCount := COUNT(GROUP,h.db_cons_phone_Invalid=1);
    db_cons_dnc_ENUM_ErrorCount := COUNT(GROUP,h.db_cons_dnc_Invalid=1);
    db_cons_scrubbed_phoneable_ENUM_ErrorCount := COUNT(GROUP,h.db_cons_scrubbed_phoneable_Invalid=1);
    db_cons_children_present_ENUM_ErrorCount := COUNT(GROUP,h.db_cons_children_present_Invalid=1);
    db_cons_home_value_code_CUSTOM_ErrorCount := COUNT(GROUP,h.db_cons_home_value_code_Invalid=1);
    db_cons_donor_capacity_code_CUSTOM_ErrorCount := COUNT(GROUP,h.db_cons_donor_capacity_code_Invalid=1);
    db_cons_home_owner_renter_CUSTOM_ErrorCount := COUNT(GROUP,h.db_cons_home_owner_renter_Invalid=1);
    db_cons_length_of_res_code_CUSTOM_ErrorCount := COUNT(GROUP,h.db_cons_length_of_res_code_Invalid=1);
    db_cons_dwelling_type_CUSTOM_ErrorCount := COUNT(GROUP,h.db_cons_dwelling_type_Invalid=1);
    db_cons_recent_home_buyer_ENUM_ErrorCount := COUNT(GROUP,h.db_cons_recent_home_buyer_Invalid=1);
    db_cons_income_code_CUSTOM_ErrorCount := COUNT(GROUP,h.db_cons_income_code_Invalid=1);
    db_cons_unsecuredcredcapcode_CUSTOM_ErrorCount := COUNT(GROUP,h.db_cons_unsecuredcredcapcode_Invalid=1);
    db_cons_networthhomevalcode_CUSTOM_ErrorCount := COUNT(GROUP,h.db_cons_networthhomevalcode_Invalid=1);
    db_cons_discretincomecode_CUSTOM_ErrorCount := COUNT(GROUP,h.db_cons_discretincomecode_Invalid=1);
    db_cons_marital_status_CUSTOM_ErrorCount := COUNT(GROUP,h.db_cons_marital_status_Invalid=1);
    db_cons_new_parent_CUSTOM_ErrorCount := COUNT(GROUP,h.db_cons_new_parent_Invalid=1);
    db_cons_child_near_hs_grad_ENUM_ErrorCount := COUNT(GROUP,h.db_cons_child_near_hs_grad_Invalid=1);
    db_cons_college_graduate_ENUM_ErrorCount := COUNT(GROUP,h.db_cons_college_graduate_Invalid=1);
    db_cons_intend_purchase_veh_ENUM_ErrorCount := COUNT(GROUP,h.db_cons_intend_purchase_veh_Invalid=1);
    db_cons_recent_divorce_ENUM_ErrorCount := COUNT(GROUP,h.db_cons_recent_divorce_Invalid=1);
    db_cons_newlywed_ENUM_ErrorCount := COUNT(GROUP,h.db_cons_newlywed_Invalid=1);
    db_cons_new_teen_driver_CUSTOM_ErrorCount := COUNT(GROUP,h.db_cons_new_teen_driver_Invalid=1);
    db_cons_home_year_built_CUSTOM_ErrorCount := COUNT(GROUP,h.db_cons_home_year_built_Invalid=1);
    db_cons_home_sqft_ranges_CUSTOM_ErrorCount := COUNT(GROUP,h.db_cons_home_sqft_ranges_Invalid=1);
    db_cons_poli_party_ind_CUSTOM_ErrorCount := COUNT(GROUP,h.db_cons_poli_party_ind_Invalid=1);
    db_cons_occupation_ind_CUSTOM_ErrorCount := COUNT(GROUP,h.db_cons_occupation_ind_Invalid=1);
    db_cons_credit_card_user_ENUM_ErrorCount := COUNT(GROUP,h.db_cons_credit_card_user_Invalid=1);
    db_cons_home_property_type_CUSTOM_ErrorCount := COUNT(GROUP,h.db_cons_home_property_type_Invalid=1);
    db_cons_education_hh_CUSTOM_ErrorCount := COUNT(GROUP,h.db_cons_education_hh_Invalid=1);
    db_cons_education_ind_CUSTOM_ErrorCount := COUNT(GROUP,h.db_cons_education_ind_Invalid=1);
    db_cons_other_pet_owner_ENUM_ErrorCount := COUNT(GROUP,h.db_cons_other_pet_owner_Invalid=1);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.dt_first_seen_Invalid > 0 OR h.dt_last_seen_Invalid > 0 OR h.dt_vendor_first_reported_Invalid > 0 OR h.dt_vendor_last_reported_Invalid > 0 OR h.process_date_Invalid > 0 OR h.record_type_Invalid > 0 OR h.ind_frm_indicator_Invalid > 0 OR h.company_name_Invalid > 0 OR h.full_name_Invalid > 0 OR h.gender_Invalid > 0 OR h.primary_exec_flag_Invalid > 0 OR h.exec_type_Invalid > 0 OR h.phy_addr_state_Invalid > 0 OR h.phy_addr_zip_Invalid > 0 OR h.mail_addr_state_Invalid > 0 OR h.mail_addr_zip_Invalid > 0 OR h.mail_score_Invalid > 0 OR h.phone_Invalid > 0 OR h.email_Invalid > 0 OR h.email_available_indicator_Invalid > 0 OR h.url_Invalid > 0 OR h.business_status_code_Invalid > 0 OR h.franchise_flag_Invalid > 0 OR h.franchise_type_Invalid > 0 OR h.county_code_Invalid > 0 OR h.primary_sic_Invalid > 0 OR h.sic02_Invalid > 0 OR h.sic03_Invalid > 0 OR h.sic04_Invalid > 0 OR h.sic05_Invalid > 0 OR h.sic06_Invalid > 0 OR h.primarysic2_Invalid > 0 OR h.primarysic4_Invalid > 0 OR h.naics01_Invalid > 0 OR h.naics02_Invalid > 0 OR h.naics03_Invalid > 0 OR h.naics04_Invalid > 0 OR h.naics05_Invalid > 0 OR h.naics06_Invalid > 0 OR h.location_employee_code_Invalid > 0 OR h.location_sales_code_Invalid > 0 OR h.corporate_employee_code_Invalid > 0 OR h.year_established_Invalid > 0 OR h.female_owned_Invalid > 0 OR h.minority_owned_flag_Invalid > 0 OR h.home_based_indicator_Invalid > 0 OR h.small_business_indicator_Invalid > 0 OR h.import_export_Invalid > 0 OR h.manufacturing_location_Invalid > 0 OR h.public_indicator_Invalid > 0 OR h.non_profit_org_Invalid > 0 OR h.square_footage_code_Invalid > 0 OR h.creditcode_Invalid > 0 OR h.credit_capacity_code_Invalid > 0 OR h.advertising_expenses_code_Invalid > 0 OR h.technology_expenses_code_Invalid > 0 OR h.office_equip_expenses_code_Invalid > 0 OR h.rent_expenses_code_Invalid > 0 OR h.telecom_expenses_code_Invalid > 0 OR h.accounting_expenses_code_Invalid > 0 OR h.bus_insurance_expense_code_Invalid > 0 OR h.legal_expenses_code_Invalid > 0 OR h.utilities_expenses_code_Invalid > 0 OR h.number_of_pcs_code_Invalid > 0 OR h.nb_flag_Invalid > 0 OR h.domestic_foreign_owner_flag_Invalid > 0 OR h.db_cons_full_name_Invalid > 0 OR h.db_cons_email_Invalid > 0 OR h.db_cons_gender_Invalid > 0 OR h.db_cons_date_of_birth_year_Invalid > 0 OR h.db_cons_date_of_birth_month_Invalid > 0 OR h.db_cons_age_Invalid > 0 OR h.db_cons_ethnic_code_Invalid > 0 OR h.db_cons_religious_affil_Invalid > 0 OR h.db_cons_language_pref_Invalid > 0 OR h.db_cons_time_zone_code_Invalid > 0 OR h.db_cons_phone_Invalid > 0 OR h.db_cons_dnc_Invalid > 0 OR h.db_cons_scrubbed_phoneable_Invalid > 0 OR h.db_cons_children_present_Invalid > 0 OR h.db_cons_home_value_code_Invalid > 0 OR h.db_cons_donor_capacity_code_Invalid > 0 OR h.db_cons_home_owner_renter_Invalid > 0 OR h.db_cons_length_of_res_code_Invalid > 0 OR h.db_cons_dwelling_type_Invalid > 0 OR h.db_cons_recent_home_buyer_Invalid > 0 OR h.db_cons_income_code_Invalid > 0 OR h.db_cons_unsecuredcredcapcode_Invalid > 0 OR h.db_cons_networthhomevalcode_Invalid > 0 OR h.db_cons_discretincomecode_Invalid > 0 OR h.db_cons_marital_status_Invalid > 0 OR h.db_cons_new_parent_Invalid > 0 OR h.db_cons_child_near_hs_grad_Invalid > 0 OR h.db_cons_college_graduate_Invalid > 0 OR h.db_cons_intend_purchase_veh_Invalid > 0 OR h.db_cons_recent_divorce_Invalid > 0 OR h.db_cons_newlywed_Invalid > 0 OR h.db_cons_new_teen_driver_Invalid > 0 OR h.db_cons_home_year_built_Invalid > 0 OR h.db_cons_home_sqft_ranges_Invalid > 0 OR h.db_cons_poli_party_ind_Invalid > 0 OR h.db_cons_occupation_ind_Invalid > 0 OR h.db_cons_credit_card_user_Invalid > 0 OR h.db_cons_home_property_type_Invalid > 0 OR h.db_cons_education_hh_Invalid > 0 OR h.db_cons_education_ind_Invalid > 0 OR h.db_cons_other_pet_owner_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.dt_first_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dt_last_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dt_vendor_first_reported_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dt_vendor_last_reported_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.process_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.record_type_ENUM_ErrorCount > 0, 1, 0) + IF(le.ind_frm_indicator_ENUM_ErrorCount > 0, 1, 0) + IF(le.company_name_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.full_name_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.gender_ENUM_ErrorCount > 0, 1, 0) + IF(le.primary_exec_flag_ENUM_ErrorCount > 0, 1, 0) + IF(le.exec_type_ENUM_ErrorCount > 0, 1, 0) + IF(le.phy_addr_state_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.phy_addr_zip_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.mail_addr_state_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.mail_addr_zip_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.mail_score_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.phone_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.email_ALLOW_ErrorCount > 0, 1, 0) + IF(le.email_available_indicator_ENUM_ErrorCount > 0, 1, 0) + IF(le.url_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.business_status_code_ENUM_ErrorCount > 0, 1, 0) + IF(le.franchise_flag_ENUM_ErrorCount > 0, 1, 0) + IF(le.franchise_type_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.county_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.primary_sic_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.sic02_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.sic03_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.sic04_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.sic05_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.sic06_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.primarysic2_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.primarysic4_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.naics01_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.naics02_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.naics03_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.naics04_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.naics05_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.naics06_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.location_employee_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.location_sales_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.corporate_employee_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.year_established_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.female_owned_ENUM_ErrorCount > 0, 1, 0) + IF(le.minority_owned_flag_ENUM_ErrorCount > 0, 1, 0) + IF(le.home_based_indicator_ENUM_ErrorCount > 0, 1, 0) + IF(le.small_business_indicator_ENUM_ErrorCount > 0, 1, 0) + IF(le.import_export_ENUM_ErrorCount > 0, 1, 0) + IF(le.manufacturing_location_ENUM_ErrorCount > 0, 1, 0) + IF(le.public_indicator_ENUM_ErrorCount > 0, 1, 0) + IF(le.non_profit_org_ENUM_ErrorCount > 0, 1, 0) + IF(le.square_footage_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.creditcode_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.credit_capacity_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.advertising_expenses_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.technology_expenses_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.office_equip_expenses_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.rent_expenses_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.telecom_expenses_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.accounting_expenses_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.bus_insurance_expense_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.legal_expenses_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.utilities_expenses_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.number_of_pcs_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.nb_flag_ENUM_ErrorCount > 0, 1, 0) + IF(le.domestic_foreign_owner_flag_ENUM_ErrorCount > 0, 1, 0) + IF(le.db_cons_full_name_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.db_cons_email_ALLOW_ErrorCount > 0, 1, 0) + IF(le.db_cons_gender_ENUM_ErrorCount > 0, 1, 0) + IF(le.db_cons_date_of_birth_year_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.db_cons_date_of_birth_month_ENUM_ErrorCount > 0, 1, 0) + IF(le.db_cons_age_ALLOW_ErrorCount > 0, 1, 0) + IF(le.db_cons_ethnic_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.db_cons_religious_affil_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.db_cons_language_pref_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.db_cons_time_zone_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.db_cons_phone_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.db_cons_dnc_ENUM_ErrorCount > 0, 1, 0) + IF(le.db_cons_scrubbed_phoneable_ENUM_ErrorCount > 0, 1, 0) + IF(le.db_cons_children_present_ENUM_ErrorCount > 0, 1, 0) + IF(le.db_cons_home_value_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.db_cons_donor_capacity_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.db_cons_home_owner_renter_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.db_cons_length_of_res_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.db_cons_dwelling_type_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.db_cons_recent_home_buyer_ENUM_ErrorCount > 0, 1, 0) + IF(le.db_cons_income_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.db_cons_unsecuredcredcapcode_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.db_cons_networthhomevalcode_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.db_cons_discretincomecode_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.db_cons_marital_status_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.db_cons_new_parent_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.db_cons_child_near_hs_grad_ENUM_ErrorCount > 0, 1, 0) + IF(le.db_cons_college_graduate_ENUM_ErrorCount > 0, 1, 0) + IF(le.db_cons_intend_purchase_veh_ENUM_ErrorCount > 0, 1, 0) + IF(le.db_cons_recent_divorce_ENUM_ErrorCount > 0, 1, 0) + IF(le.db_cons_newlywed_ENUM_ErrorCount > 0, 1, 0) + IF(le.db_cons_new_teen_driver_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.db_cons_home_year_built_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.db_cons_home_sqft_ranges_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.db_cons_poli_party_ind_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.db_cons_occupation_ind_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.db_cons_credit_card_user_ENUM_ErrorCount > 0, 1, 0) + IF(le.db_cons_home_property_type_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.db_cons_education_hh_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.db_cons_education_ind_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.db_cons_other_pet_owner_ENUM_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.dt_first_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dt_last_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dt_vendor_first_reported_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dt_vendor_last_reported_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.process_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.record_type_ENUM_ErrorCount > 0, 1, 0) + IF(le.ind_frm_indicator_ENUM_ErrorCount > 0, 1, 0) + IF(le.company_name_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.full_name_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.gender_ENUM_ErrorCount > 0, 1, 0) + IF(le.primary_exec_flag_ENUM_ErrorCount > 0, 1, 0) + IF(le.exec_type_ENUM_ErrorCount > 0, 1, 0) + IF(le.phy_addr_state_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.phy_addr_zip_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.mail_addr_state_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.mail_addr_zip_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.mail_score_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.phone_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.email_ALLOW_ErrorCount > 0, 1, 0) + IF(le.email_available_indicator_ENUM_ErrorCount > 0, 1, 0) + IF(le.url_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.business_status_code_ENUM_ErrorCount > 0, 1, 0) + IF(le.franchise_flag_ENUM_ErrorCount > 0, 1, 0) + IF(le.franchise_type_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.county_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.primary_sic_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.sic02_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.sic03_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.sic04_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.sic05_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.sic06_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.primarysic2_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.primarysic4_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.naics01_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.naics02_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.naics03_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.naics04_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.naics05_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.naics06_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.location_employee_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.location_sales_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.corporate_employee_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.year_established_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.female_owned_ENUM_ErrorCount > 0, 1, 0) + IF(le.minority_owned_flag_ENUM_ErrorCount > 0, 1, 0) + IF(le.home_based_indicator_ENUM_ErrorCount > 0, 1, 0) + IF(le.small_business_indicator_ENUM_ErrorCount > 0, 1, 0) + IF(le.import_export_ENUM_ErrorCount > 0, 1, 0) + IF(le.manufacturing_location_ENUM_ErrorCount > 0, 1, 0) + IF(le.public_indicator_ENUM_ErrorCount > 0, 1, 0) + IF(le.non_profit_org_ENUM_ErrorCount > 0, 1, 0) + IF(le.square_footage_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.creditcode_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.credit_capacity_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.advertising_expenses_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.technology_expenses_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.office_equip_expenses_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.rent_expenses_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.telecom_expenses_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.accounting_expenses_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.bus_insurance_expense_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.legal_expenses_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.utilities_expenses_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.number_of_pcs_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.nb_flag_ENUM_ErrorCount > 0, 1, 0) + IF(le.domestic_foreign_owner_flag_ENUM_ErrorCount > 0, 1, 0) + IF(le.db_cons_full_name_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.db_cons_email_ALLOW_ErrorCount > 0, 1, 0) + IF(le.db_cons_gender_ENUM_ErrorCount > 0, 1, 0) + IF(le.db_cons_date_of_birth_year_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.db_cons_date_of_birth_month_ENUM_ErrorCount > 0, 1, 0) + IF(le.db_cons_age_ALLOW_ErrorCount > 0, 1, 0) + IF(le.db_cons_ethnic_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.db_cons_religious_affil_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.db_cons_language_pref_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.db_cons_time_zone_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.db_cons_phone_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.db_cons_dnc_ENUM_ErrorCount > 0, 1, 0) + IF(le.db_cons_scrubbed_phoneable_ENUM_ErrorCount > 0, 1, 0) + IF(le.db_cons_children_present_ENUM_ErrorCount > 0, 1, 0) + IF(le.db_cons_home_value_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.db_cons_donor_capacity_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.db_cons_home_owner_renter_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.db_cons_length_of_res_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.db_cons_dwelling_type_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.db_cons_recent_home_buyer_ENUM_ErrorCount > 0, 1, 0) + IF(le.db_cons_income_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.db_cons_unsecuredcredcapcode_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.db_cons_networthhomevalcode_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.db_cons_discretincomecode_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.db_cons_marital_status_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.db_cons_new_parent_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.db_cons_child_near_hs_grad_ENUM_ErrorCount > 0, 1, 0) + IF(le.db_cons_college_graduate_ENUM_ErrorCount > 0, 1, 0) + IF(le.db_cons_intend_purchase_veh_ENUM_ErrorCount > 0, 1, 0) + IF(le.db_cons_recent_divorce_ENUM_ErrorCount > 0, 1, 0) + IF(le.db_cons_newlywed_ENUM_ErrorCount > 0, 1, 0) + IF(le.db_cons_new_teen_driver_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.db_cons_home_year_built_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.db_cons_home_sqft_ranges_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.db_cons_poli_party_ind_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.db_cons_occupation_ind_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.db_cons_credit_card_user_ENUM_ErrorCount > 0, 1, 0) + IF(le.db_cons_home_property_type_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.db_cons_education_hh_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.db_cons_education_ind_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.db_cons_other_pet_owner_ENUM_ErrorCount > 0, 1, 0);
    SELF.Rules_NoErrors := NumRules - SELF.Rules_WithErrors;
    SELF := le;
  END;
  EXPORT SummaryStats := PROJECT(SummaryStats0, xAddErrSummary(LEFT));
  r := RECORD
    STRING10 Src;
    STRING FieldName;
    STRING FieldType;
    STRING ErrorType;
    SALT311.StrType ErrorMessage;
    SALT311.StrType FieldContents;
  END;
  r into(h le,UNSIGNED c) := TRANSFORM
    SELF.Src :=  ''; // Source not provided
    UNSIGNED1 ErrNum := CHOOSE(c,le.dt_first_seen_Invalid,le.dt_last_seen_Invalid,le.dt_vendor_first_reported_Invalid,le.dt_vendor_last_reported_Invalid,le.process_date_Invalid,le.record_type_Invalid,le.ind_frm_indicator_Invalid,le.company_name_Invalid,le.full_name_Invalid,le.gender_Invalid,le.primary_exec_flag_Invalid,le.exec_type_Invalid,le.phy_addr_state_Invalid,le.phy_addr_zip_Invalid,le.mail_addr_state_Invalid,le.mail_addr_zip_Invalid,le.mail_score_Invalid,le.phone_Invalid,le.email_Invalid,le.email_available_indicator_Invalid,le.url_Invalid,le.business_status_code_Invalid,le.franchise_flag_Invalid,le.franchise_type_Invalid,le.county_code_Invalid,le.primary_sic_Invalid,le.sic02_Invalid,le.sic03_Invalid,le.sic04_Invalid,le.sic05_Invalid,le.sic06_Invalid,le.primarysic2_Invalid,le.primarysic4_Invalid,le.naics01_Invalid,le.naics02_Invalid,le.naics03_Invalid,le.naics04_Invalid,le.naics05_Invalid,le.naics06_Invalid,le.location_employee_code_Invalid,le.location_sales_code_Invalid,le.corporate_employee_code_Invalid,le.year_established_Invalid,le.female_owned_Invalid,le.minority_owned_flag_Invalid,le.home_based_indicator_Invalid,le.small_business_indicator_Invalid,le.import_export_Invalid,le.manufacturing_location_Invalid,le.public_indicator_Invalid,le.non_profit_org_Invalid,le.square_footage_code_Invalid,le.creditcode_Invalid,le.credit_capacity_code_Invalid,le.advertising_expenses_code_Invalid,le.technology_expenses_code_Invalid,le.office_equip_expenses_code_Invalid,le.rent_expenses_code_Invalid,le.telecom_expenses_code_Invalid,le.accounting_expenses_code_Invalid,le.bus_insurance_expense_code_Invalid,le.legal_expenses_code_Invalid,le.utilities_expenses_code_Invalid,le.number_of_pcs_code_Invalid,le.nb_flag_Invalid,le.domestic_foreign_owner_flag_Invalid,le.db_cons_full_name_Invalid,le.db_cons_email_Invalid,le.db_cons_gender_Invalid,le.db_cons_date_of_birth_year_Invalid,le.db_cons_date_of_birth_month_Invalid,le.db_cons_age_Invalid,le.db_cons_ethnic_code_Invalid,le.db_cons_religious_affil_Invalid,le.db_cons_language_pref_Invalid,le.db_cons_time_zone_code_Invalid,le.db_cons_phone_Invalid,le.db_cons_dnc_Invalid,le.db_cons_scrubbed_phoneable_Invalid,le.db_cons_children_present_Invalid,le.db_cons_home_value_code_Invalid,le.db_cons_donor_capacity_code_Invalid,le.db_cons_home_owner_renter_Invalid,le.db_cons_length_of_res_code_Invalid,le.db_cons_dwelling_type_Invalid,le.db_cons_recent_home_buyer_Invalid,le.db_cons_income_code_Invalid,le.db_cons_unsecuredcredcapcode_Invalid,le.db_cons_networthhomevalcode_Invalid,le.db_cons_discretincomecode_Invalid,le.db_cons_marital_status_Invalid,le.db_cons_new_parent_Invalid,le.db_cons_child_near_hs_grad_Invalid,le.db_cons_college_graduate_Invalid,le.db_cons_intend_purchase_veh_Invalid,le.db_cons_recent_divorce_Invalid,le.db_cons_newlywed_Invalid,le.db_cons_new_teen_driver_Invalid,le.db_cons_home_year_built_Invalid,le.db_cons_home_sqft_ranges_Invalid,le.db_cons_poli_party_ind_Invalid,le.db_cons_occupation_ind_Invalid,le.db_cons_credit_card_user_Invalid,le.db_cons_home_property_type_Invalid,le.db_cons_education_hh_Invalid,le.db_cons_education_ind_Invalid,le.db_cons_other_pet_owner_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Base_Fields.InvalidMessage_dt_first_seen(le.dt_first_seen_Invalid),Base_Fields.InvalidMessage_dt_last_seen(le.dt_last_seen_Invalid),Base_Fields.InvalidMessage_dt_vendor_first_reported(le.dt_vendor_first_reported_Invalid),Base_Fields.InvalidMessage_dt_vendor_last_reported(le.dt_vendor_last_reported_Invalid),Base_Fields.InvalidMessage_process_date(le.process_date_Invalid),Base_Fields.InvalidMessage_record_type(le.record_type_Invalid),Base_Fields.InvalidMessage_ind_frm_indicator(le.ind_frm_indicator_Invalid),Base_Fields.InvalidMessage_company_name(le.company_name_Invalid),Base_Fields.InvalidMessage_full_name(le.full_name_Invalid),Base_Fields.InvalidMessage_gender(le.gender_Invalid),Base_Fields.InvalidMessage_primary_exec_flag(le.primary_exec_flag_Invalid),Base_Fields.InvalidMessage_exec_type(le.exec_type_Invalid),Base_Fields.InvalidMessage_phy_addr_state(le.phy_addr_state_Invalid),Base_Fields.InvalidMessage_phy_addr_zip(le.phy_addr_zip_Invalid),Base_Fields.InvalidMessage_mail_addr_state(le.mail_addr_state_Invalid),Base_Fields.InvalidMessage_mail_addr_zip(le.mail_addr_zip_Invalid),Base_Fields.InvalidMessage_mail_score(le.mail_score_Invalid),Base_Fields.InvalidMessage_phone(le.phone_Invalid),Base_Fields.InvalidMessage_email(le.email_Invalid),Base_Fields.InvalidMessage_email_available_indicator(le.email_available_indicator_Invalid),Base_Fields.InvalidMessage_url(le.url_Invalid),Base_Fields.InvalidMessage_business_status_code(le.business_status_code_Invalid),Base_Fields.InvalidMessage_franchise_flag(le.franchise_flag_Invalid),Base_Fields.InvalidMessage_franchise_type(le.franchise_type_Invalid),Base_Fields.InvalidMessage_county_code(le.county_code_Invalid),Base_Fields.InvalidMessage_primary_sic(le.primary_sic_Invalid),Base_Fields.InvalidMessage_sic02(le.sic02_Invalid),Base_Fields.InvalidMessage_sic03(le.sic03_Invalid),Base_Fields.InvalidMessage_sic04(le.sic04_Invalid),Base_Fields.InvalidMessage_sic05(le.sic05_Invalid),Base_Fields.InvalidMessage_sic06(le.sic06_Invalid),Base_Fields.InvalidMessage_primarysic2(le.primarysic2_Invalid),Base_Fields.InvalidMessage_primarysic4(le.primarysic4_Invalid),Base_Fields.InvalidMessage_naics01(le.naics01_Invalid),Base_Fields.InvalidMessage_naics02(le.naics02_Invalid),Base_Fields.InvalidMessage_naics03(le.naics03_Invalid),Base_Fields.InvalidMessage_naics04(le.naics04_Invalid),Base_Fields.InvalidMessage_naics05(le.naics05_Invalid),Base_Fields.InvalidMessage_naics06(le.naics06_Invalid),Base_Fields.InvalidMessage_location_employee_code(le.location_employee_code_Invalid),Base_Fields.InvalidMessage_location_sales_code(le.location_sales_code_Invalid),Base_Fields.InvalidMessage_corporate_employee_code(le.corporate_employee_code_Invalid),Base_Fields.InvalidMessage_year_established(le.year_established_Invalid),Base_Fields.InvalidMessage_female_owned(le.female_owned_Invalid),Base_Fields.InvalidMessage_minority_owned_flag(le.minority_owned_flag_Invalid),Base_Fields.InvalidMessage_home_based_indicator(le.home_based_indicator_Invalid),Base_Fields.InvalidMessage_small_business_indicator(le.small_business_indicator_Invalid),Base_Fields.InvalidMessage_import_export(le.import_export_Invalid),Base_Fields.InvalidMessage_manufacturing_location(le.manufacturing_location_Invalid),Base_Fields.InvalidMessage_public_indicator(le.public_indicator_Invalid),Base_Fields.InvalidMessage_non_profit_org(le.non_profit_org_Invalid),Base_Fields.InvalidMessage_square_footage_code(le.square_footage_code_Invalid),Base_Fields.InvalidMessage_creditcode(le.creditcode_Invalid),Base_Fields.InvalidMessage_credit_capacity_code(le.credit_capacity_code_Invalid),Base_Fields.InvalidMessage_advertising_expenses_code(le.advertising_expenses_code_Invalid),Base_Fields.InvalidMessage_technology_expenses_code(le.technology_expenses_code_Invalid),Base_Fields.InvalidMessage_office_equip_expenses_code(le.office_equip_expenses_code_Invalid),Base_Fields.InvalidMessage_rent_expenses_code(le.rent_expenses_code_Invalid),Base_Fields.InvalidMessage_telecom_expenses_code(le.telecom_expenses_code_Invalid),Base_Fields.InvalidMessage_accounting_expenses_code(le.accounting_expenses_code_Invalid),Base_Fields.InvalidMessage_bus_insurance_expense_code(le.bus_insurance_expense_code_Invalid),Base_Fields.InvalidMessage_legal_expenses_code(le.legal_expenses_code_Invalid),Base_Fields.InvalidMessage_utilities_expenses_code(le.utilities_expenses_code_Invalid),Base_Fields.InvalidMessage_number_of_pcs_code(le.number_of_pcs_code_Invalid),Base_Fields.InvalidMessage_nb_flag(le.nb_flag_Invalid),Base_Fields.InvalidMessage_domestic_foreign_owner_flag(le.domestic_foreign_owner_flag_Invalid),Base_Fields.InvalidMessage_db_cons_full_name(le.db_cons_full_name_Invalid),Base_Fields.InvalidMessage_db_cons_email(le.db_cons_email_Invalid),Base_Fields.InvalidMessage_db_cons_gender(le.db_cons_gender_Invalid),Base_Fields.InvalidMessage_db_cons_date_of_birth_year(le.db_cons_date_of_birth_year_Invalid),Base_Fields.InvalidMessage_db_cons_date_of_birth_month(le.db_cons_date_of_birth_month_Invalid),Base_Fields.InvalidMessage_db_cons_age(le.db_cons_age_Invalid),Base_Fields.InvalidMessage_db_cons_ethnic_code(le.db_cons_ethnic_code_Invalid),Base_Fields.InvalidMessage_db_cons_religious_affil(le.db_cons_religious_affil_Invalid),Base_Fields.InvalidMessage_db_cons_language_pref(le.db_cons_language_pref_Invalid),Base_Fields.InvalidMessage_db_cons_time_zone_code(le.db_cons_time_zone_code_Invalid),Base_Fields.InvalidMessage_db_cons_phone(le.db_cons_phone_Invalid),Base_Fields.InvalidMessage_db_cons_dnc(le.db_cons_dnc_Invalid),Base_Fields.InvalidMessage_db_cons_scrubbed_phoneable(le.db_cons_scrubbed_phoneable_Invalid),Base_Fields.InvalidMessage_db_cons_children_present(le.db_cons_children_present_Invalid),Base_Fields.InvalidMessage_db_cons_home_value_code(le.db_cons_home_value_code_Invalid),Base_Fields.InvalidMessage_db_cons_donor_capacity_code(le.db_cons_donor_capacity_code_Invalid),Base_Fields.InvalidMessage_db_cons_home_owner_renter(le.db_cons_home_owner_renter_Invalid),Base_Fields.InvalidMessage_db_cons_length_of_res_code(le.db_cons_length_of_res_code_Invalid),Base_Fields.InvalidMessage_db_cons_dwelling_type(le.db_cons_dwelling_type_Invalid),Base_Fields.InvalidMessage_db_cons_recent_home_buyer(le.db_cons_recent_home_buyer_Invalid),Base_Fields.InvalidMessage_db_cons_income_code(le.db_cons_income_code_Invalid),Base_Fields.InvalidMessage_db_cons_unsecuredcredcapcode(le.db_cons_unsecuredcredcapcode_Invalid),Base_Fields.InvalidMessage_db_cons_networthhomevalcode(le.db_cons_networthhomevalcode_Invalid),Base_Fields.InvalidMessage_db_cons_discretincomecode(le.db_cons_discretincomecode_Invalid),Base_Fields.InvalidMessage_db_cons_marital_status(le.db_cons_marital_status_Invalid),Base_Fields.InvalidMessage_db_cons_new_parent(le.db_cons_new_parent_Invalid),Base_Fields.InvalidMessage_db_cons_child_near_hs_grad(le.db_cons_child_near_hs_grad_Invalid),Base_Fields.InvalidMessage_db_cons_college_graduate(le.db_cons_college_graduate_Invalid),Base_Fields.InvalidMessage_db_cons_intend_purchase_veh(le.db_cons_intend_purchase_veh_Invalid),Base_Fields.InvalidMessage_db_cons_recent_divorce(le.db_cons_recent_divorce_Invalid),Base_Fields.InvalidMessage_db_cons_newlywed(le.db_cons_newlywed_Invalid),Base_Fields.InvalidMessage_db_cons_new_teen_driver(le.db_cons_new_teen_driver_Invalid),Base_Fields.InvalidMessage_db_cons_home_year_built(le.db_cons_home_year_built_Invalid),Base_Fields.InvalidMessage_db_cons_home_sqft_ranges(le.db_cons_home_sqft_ranges_Invalid),Base_Fields.InvalidMessage_db_cons_poli_party_ind(le.db_cons_poli_party_ind_Invalid),Base_Fields.InvalidMessage_db_cons_occupation_ind(le.db_cons_occupation_ind_Invalid),Base_Fields.InvalidMessage_db_cons_credit_card_user(le.db_cons_credit_card_user_Invalid),Base_Fields.InvalidMessage_db_cons_home_property_type(le.db_cons_home_property_type_Invalid),Base_Fields.InvalidMessage_db_cons_education_hh(le.db_cons_education_hh_Invalid),Base_Fields.InvalidMessage_db_cons_education_ind(le.db_cons_education_ind_Invalid),Base_Fields.InvalidMessage_db_cons_other_pet_owner(le.db_cons_other_pet_owner_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.dt_first_seen_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.dt_last_seen_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.dt_vendor_first_reported_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.dt_vendor_last_reported_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.process_date_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.record_type_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.ind_frm_indicator_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.company_name_Invalid,'LENGTHS','UNKNOWN')
          ,CHOOSE(le.full_name_Invalid,'LENGTHS','UNKNOWN')
          ,CHOOSE(le.gender_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.primary_exec_flag_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.exec_type_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.phy_addr_state_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.phy_addr_zip_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.mail_addr_state_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.mail_addr_zip_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.mail_score_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.phone_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.email_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.email_available_indicator_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.url_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.business_status_code_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.franchise_flag_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.franchise_type_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.county_code_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.primary_sic_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.sic02_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.sic03_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.sic04_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.sic05_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.sic06_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.primarysic2_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.primarysic4_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.naics01_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.naics02_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.naics03_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.naics04_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.naics05_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.naics06_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.location_employee_code_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.location_sales_code_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.corporate_employee_code_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.year_established_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.female_owned_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.minority_owned_flag_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.home_based_indicator_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.small_business_indicator_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.import_export_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.manufacturing_location_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.public_indicator_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.non_profit_org_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.square_footage_code_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.creditcode_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.credit_capacity_code_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.advertising_expenses_code_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.technology_expenses_code_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.office_equip_expenses_code_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.rent_expenses_code_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.telecom_expenses_code_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.accounting_expenses_code_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.bus_insurance_expense_code_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.legal_expenses_code_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.utilities_expenses_code_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.number_of_pcs_code_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.nb_flag_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.domestic_foreign_owner_flag_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.db_cons_full_name_Invalid,'LENGTHS','UNKNOWN')
          ,CHOOSE(le.db_cons_email_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.db_cons_gender_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.db_cons_date_of_birth_year_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.db_cons_date_of_birth_month_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.db_cons_age_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.db_cons_ethnic_code_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.db_cons_religious_affil_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.db_cons_language_pref_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.db_cons_time_zone_code_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.db_cons_phone_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.db_cons_dnc_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.db_cons_scrubbed_phoneable_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.db_cons_children_present_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.db_cons_home_value_code_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.db_cons_donor_capacity_code_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.db_cons_home_owner_renter_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.db_cons_length_of_res_code_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.db_cons_dwelling_type_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.db_cons_recent_home_buyer_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.db_cons_income_code_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.db_cons_unsecuredcredcapcode_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.db_cons_networthhomevalcode_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.db_cons_discretincomecode_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.db_cons_marital_status_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.db_cons_new_parent_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.db_cons_child_near_hs_grad_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.db_cons_college_graduate_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.db_cons_intend_purchase_veh_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.db_cons_recent_divorce_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.db_cons_newlywed_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.db_cons_new_teen_driver_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.db_cons_home_year_built_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.db_cons_home_sqft_ranges_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.db_cons_poli_party_ind_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.db_cons_occupation_ind_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.db_cons_credit_card_user_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.db_cons_home_property_type_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.db_cons_education_hh_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.db_cons_education_ind_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.db_cons_other_pet_owner_Invalid,'ENUM','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'dt_first_seen','dt_last_seen','dt_vendor_first_reported','dt_vendor_last_reported','process_date','record_type','ind_frm_indicator','company_name','full_name','gender','primary_exec_flag','exec_type','phy_addr_state','phy_addr_zip','mail_addr_state','mail_addr_zip','mail_score','phone','email','email_available_indicator','url','business_status_code','franchise_flag','franchise_type','county_code','primary_sic','sic02','sic03','sic04','sic05','sic06','primarysic2','primarysic4','naics01','naics02','naics03','naics04','naics05','naics06','location_employee_code','location_sales_code','corporate_employee_code','year_established','female_owned','minority_owned_flag','home_based_indicator','small_business_indicator','import_export','manufacturing_location','public_indicator','non_profit_org','square_footage_code','creditcode','credit_capacity_code','advertising_expenses_code','technology_expenses_code','office_equip_expenses_code','rent_expenses_code','telecom_expenses_code','accounting_expenses_code','bus_insurance_expense_code','legal_expenses_code','utilities_expenses_code','number_of_pcs_code','nb_flag','domestic_foreign_owner_flag','db_cons_full_name','db_cons_email','db_cons_gender','db_cons_date_of_birth_year','db_cons_date_of_birth_month','db_cons_age','db_cons_ethnic_code','db_cons_religious_affil','db_cons_language_pref','db_cons_time_zone_code','db_cons_phone','db_cons_dnc','db_cons_scrubbed_phoneable','db_cons_children_present','db_cons_home_value_code','db_cons_donor_capacity_code','db_cons_home_owner_renter','db_cons_length_of_res_code','db_cons_dwelling_type','db_cons_recent_home_buyer','db_cons_income_code','db_cons_unsecuredcredcapcode','db_cons_networthhomevalcode','db_cons_discretincomecode','db_cons_marital_status','db_cons_new_parent','db_cons_child_near_hs_grad','db_cons_college_graduate','db_cons_intend_purchase_veh','db_cons_recent_divorce','db_cons_newlywed','db_cons_new_teen_driver','db_cons_home_year_built','db_cons_home_sqft_ranges','db_cons_poli_party_ind','db_cons_occupation_ind','db_cons_credit_card_user','db_cons_home_property_type','db_cons_education_hh','db_cons_education_ind','db_cons_other_pet_owner','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_pastdate','invalid_pastdate','invalid_pastdate','invalid_pastdate','invalid_generaldate','invalid_record_type','invalid_ind_frm','invalid_mandatory','invalid_mandatory','invalid_gender_code','invalid_flag','invalid_exec_type','invalid_st','invalid_zip5','invalid_st','invalid_zip5','invalid_mail_score','invalid_phone','invalid_email','invalid_email_indicator','invalid_url','invalid_bus_status_code','invalid_flag','invalid_franchise','invalid_numeric','invalid_sic','invalid_sic','invalid_sic','invalid_sic','invalid_sic','invalid_sic','invalid_sic','invalid_sic','invalid_naics','invalid_naics','invalid_naics','invalid_naics','invalid_naics','invalid_naics','invalid_loc_employee_code','invalid_loc_sales_code','invalid_corp_employee_code','invalid_year','invalid_flag','invalid_flag','invalid_flag','invalid_flag','invalid_flag','invalid_flag','invalid_flag','invalid_flag','invalid_sq_ft','invalid_credit_code','invalid_credit_capacity_code','invalid_advertising_code','invalid_technology_code','invalid_office_equip_code','invalid_rent_code','invalid_telecom_code','invalid_accounting_code','invalid_bus_insurance_code','invalid_legal_code','invalid_utilities_code','invalid_number_of_pcs_code','invalid_flag','invalid_flag','invalid_mandatory','invalid_email','invalid_gender_code','invalid_year','invalid_month','invalid_numeric_blank','invalid_ethnic_code','invalid_religious_affil','invalid_language','invalid_time_zone','invalid_phone','invalid_flag','invalid_flag','invalid_children_present','invalid_home_value','invalid_donor_code','invalid_home_owner_renter','invalid_length_of_res','invalid_dwelling_type','invalid_flag','invalid_income_code','invalid_unsec_cap','invalid_net_worth','invalid_discret_income','invalid_marital_status','invalid_new_parent','invalid_flag','invalid_flag','invalid_flag','invalid_flag','invalid_flag','invalid_teen_driver','invalid_year','invalid_home_sqft_ranges','invalid_poli_party_ind','invalid_occupation_ind','invalid_flag','invalid_home_property','invalid_education','invalid_education','invalid_flag','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT311.StrType)le.dt_first_seen,(SALT311.StrType)le.dt_last_seen,(SALT311.StrType)le.dt_vendor_first_reported,(SALT311.StrType)le.dt_vendor_last_reported,(SALT311.StrType)le.process_date,(SALT311.StrType)le.record_type,(SALT311.StrType)le.ind_frm_indicator,(SALT311.StrType)le.company_name,(SALT311.StrType)le.full_name,(SALT311.StrType)le.gender,(SALT311.StrType)le.primary_exec_flag,(SALT311.StrType)le.exec_type,(SALT311.StrType)le.phy_addr_state,(SALT311.StrType)le.phy_addr_zip,(SALT311.StrType)le.mail_addr_state,(SALT311.StrType)le.mail_addr_zip,(SALT311.StrType)le.mail_score,(SALT311.StrType)le.phone,(SALT311.StrType)le.email,(SALT311.StrType)le.email_available_indicator,(SALT311.StrType)le.url,(SALT311.StrType)le.business_status_code,(SALT311.StrType)le.franchise_flag,(SALT311.StrType)le.franchise_type,(SALT311.StrType)le.county_code,(SALT311.StrType)le.primary_sic,(SALT311.StrType)le.sic02,(SALT311.StrType)le.sic03,(SALT311.StrType)le.sic04,(SALT311.StrType)le.sic05,(SALT311.StrType)le.sic06,(SALT311.StrType)le.primarysic2,(SALT311.StrType)le.primarysic4,(SALT311.StrType)le.naics01,(SALT311.StrType)le.naics02,(SALT311.StrType)le.naics03,(SALT311.StrType)le.naics04,(SALT311.StrType)le.naics05,(SALT311.StrType)le.naics06,(SALT311.StrType)le.location_employee_code,(SALT311.StrType)le.location_sales_code,(SALT311.StrType)le.corporate_employee_code,(SALT311.StrType)le.year_established,(SALT311.StrType)le.female_owned,(SALT311.StrType)le.minority_owned_flag,(SALT311.StrType)le.home_based_indicator,(SALT311.StrType)le.small_business_indicator,(SALT311.StrType)le.import_export,(SALT311.StrType)le.manufacturing_location,(SALT311.StrType)le.public_indicator,(SALT311.StrType)le.non_profit_org,(SALT311.StrType)le.square_footage_code,(SALT311.StrType)le.creditcode,(SALT311.StrType)le.credit_capacity_code,(SALT311.StrType)le.advertising_expenses_code,(SALT311.StrType)le.technology_expenses_code,(SALT311.StrType)le.office_equip_expenses_code,(SALT311.StrType)le.rent_expenses_code,(SALT311.StrType)le.telecom_expenses_code,(SALT311.StrType)le.accounting_expenses_code,(SALT311.StrType)le.bus_insurance_expense_code,(SALT311.StrType)le.legal_expenses_code,(SALT311.StrType)le.utilities_expenses_code,(SALT311.StrType)le.number_of_pcs_code,(SALT311.StrType)le.nb_flag,(SALT311.StrType)le.domestic_foreign_owner_flag,(SALT311.StrType)le.db_cons_full_name,(SALT311.StrType)le.db_cons_email,(SALT311.StrType)le.db_cons_gender,(SALT311.StrType)le.db_cons_date_of_birth_year,(SALT311.StrType)le.db_cons_date_of_birth_month,(SALT311.StrType)le.db_cons_age,(SALT311.StrType)le.db_cons_ethnic_code,(SALT311.StrType)le.db_cons_religious_affil,(SALT311.StrType)le.db_cons_language_pref,(SALT311.StrType)le.db_cons_time_zone_code,(SALT311.StrType)le.db_cons_phone,(SALT311.StrType)le.db_cons_dnc,(SALT311.StrType)le.db_cons_scrubbed_phoneable,(SALT311.StrType)le.db_cons_children_present,(SALT311.StrType)le.db_cons_home_value_code,(SALT311.StrType)le.db_cons_donor_capacity_code,(SALT311.StrType)le.db_cons_home_owner_renter,(SALT311.StrType)le.db_cons_length_of_res_code,(SALT311.StrType)le.db_cons_dwelling_type,(SALT311.StrType)le.db_cons_recent_home_buyer,(SALT311.StrType)le.db_cons_income_code,(SALT311.StrType)le.db_cons_unsecuredcredcapcode,(SALT311.StrType)le.db_cons_networthhomevalcode,(SALT311.StrType)le.db_cons_discretincomecode,(SALT311.StrType)le.db_cons_marital_status,(SALT311.StrType)le.db_cons_new_parent,(SALT311.StrType)le.db_cons_child_near_hs_grad,(SALT311.StrType)le.db_cons_college_graduate,(SALT311.StrType)le.db_cons_intend_purchase_veh,(SALT311.StrType)le.db_cons_recent_divorce,(SALT311.StrType)le.db_cons_newlywed,(SALT311.StrType)le.db_cons_new_teen_driver,(SALT311.StrType)le.db_cons_home_year_built,(SALT311.StrType)le.db_cons_home_sqft_ranges,(SALT311.StrType)le.db_cons_poli_party_ind,(SALT311.StrType)le.db_cons_occupation_ind,(SALT311.StrType)le.db_cons_credit_card_user,(SALT311.StrType)le.db_cons_home_property_type,(SALT311.StrType)le.db_cons_education_hh,(SALT311.StrType)le.db_cons_education_ind,(SALT311.StrType)le.db_cons_other_pet_owner,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,107,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(Scrubs_Database_USA.Base_Layout_Database_USA) prevDS = DATASET([], Scrubs_Database_USA.Base_Layout_Database_USA), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT311.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'dt_first_seen:invalid_pastdate:CUSTOM'
          ,'dt_last_seen:invalid_pastdate:CUSTOM'
          ,'dt_vendor_first_reported:invalid_pastdate:CUSTOM'
          ,'dt_vendor_last_reported:invalid_pastdate:CUSTOM'
          ,'process_date:invalid_generaldate:CUSTOM'
          ,'record_type:invalid_record_type:ENUM'
          ,'ind_frm_indicator:invalid_ind_frm:ENUM'
          ,'company_name:invalid_mandatory:LENGTHS'
          ,'full_name:invalid_mandatory:LENGTHS'
          ,'gender:invalid_gender_code:ENUM'
          ,'primary_exec_flag:invalid_flag:ENUM'
          ,'exec_type:invalid_exec_type:ENUM'
          ,'phy_addr_state:invalid_st:CUSTOM'
          ,'phy_addr_zip:invalid_zip5:CUSTOM'
          ,'mail_addr_state:invalid_st:CUSTOM'
          ,'mail_addr_zip:invalid_zip5:CUSTOM'
          ,'mail_score:invalid_mail_score:CUSTOM'
          ,'phone:invalid_phone:CUSTOM'
          ,'email:invalid_email:ALLOW'
          ,'email_available_indicator:invalid_email_indicator:ENUM'
          ,'url:invalid_url:CUSTOM'
          ,'business_status_code:invalid_bus_status_code:ENUM'
          ,'franchise_flag:invalid_flag:ENUM'
          ,'franchise_type:invalid_franchise:CUSTOM'
          ,'county_code:invalid_numeric:CUSTOM'
          ,'primary_sic:invalid_sic:CUSTOM'
          ,'sic02:invalid_sic:CUSTOM'
          ,'sic03:invalid_sic:CUSTOM'
          ,'sic04:invalid_sic:CUSTOM'
          ,'sic05:invalid_sic:CUSTOM'
          ,'sic06:invalid_sic:CUSTOM'
          ,'primarysic2:invalid_sic:CUSTOM'
          ,'primarysic4:invalid_sic:CUSTOM'
          ,'naics01:invalid_naics:CUSTOM'
          ,'naics02:invalid_naics:CUSTOM'
          ,'naics03:invalid_naics:CUSTOM'
          ,'naics04:invalid_naics:CUSTOM'
          ,'naics05:invalid_naics:CUSTOM'
          ,'naics06:invalid_naics:CUSTOM'
          ,'location_employee_code:invalid_loc_employee_code:CUSTOM'
          ,'location_sales_code:invalid_loc_sales_code:CUSTOM'
          ,'corporate_employee_code:invalid_corp_employee_code:CUSTOM'
          ,'year_established:invalid_year:CUSTOM'
          ,'female_owned:invalid_flag:ENUM'
          ,'minority_owned_flag:invalid_flag:ENUM'
          ,'home_based_indicator:invalid_flag:ENUM'
          ,'small_business_indicator:invalid_flag:ENUM'
          ,'import_export:invalid_flag:ENUM'
          ,'manufacturing_location:invalid_flag:ENUM'
          ,'public_indicator:invalid_flag:ENUM'
          ,'non_profit_org:invalid_flag:ENUM'
          ,'square_footage_code:invalid_sq_ft:CUSTOM'
          ,'creditcode:invalid_credit_code:CUSTOM'
          ,'credit_capacity_code:invalid_credit_capacity_code:CUSTOM'
          ,'advertising_expenses_code:invalid_advertising_code:CUSTOM'
          ,'technology_expenses_code:invalid_technology_code:CUSTOM'
          ,'office_equip_expenses_code:invalid_office_equip_code:CUSTOM'
          ,'rent_expenses_code:invalid_rent_code:CUSTOM'
          ,'telecom_expenses_code:invalid_telecom_code:CUSTOM'
          ,'accounting_expenses_code:invalid_accounting_code:CUSTOM'
          ,'bus_insurance_expense_code:invalid_bus_insurance_code:CUSTOM'
          ,'legal_expenses_code:invalid_legal_code:CUSTOM'
          ,'utilities_expenses_code:invalid_utilities_code:CUSTOM'
          ,'number_of_pcs_code:invalid_number_of_pcs_code:CUSTOM'
          ,'nb_flag:invalid_flag:ENUM'
          ,'domestic_foreign_owner_flag:invalid_flag:ENUM'
          ,'db_cons_full_name:invalid_mandatory:LENGTHS'
          ,'db_cons_email:invalid_email:ALLOW'
          ,'db_cons_gender:invalid_gender_code:ENUM'
          ,'db_cons_date_of_birth_year:invalid_year:CUSTOM'
          ,'db_cons_date_of_birth_month:invalid_month:ENUM'
          ,'db_cons_age:invalid_numeric_blank:ALLOW'
          ,'db_cons_ethnic_code:invalid_ethnic_code:CUSTOM'
          ,'db_cons_religious_affil:invalid_religious_affil:CUSTOM'
          ,'db_cons_language_pref:invalid_language:CUSTOM'
          ,'db_cons_time_zone_code:invalid_time_zone:CUSTOM'
          ,'db_cons_phone:invalid_phone:CUSTOM'
          ,'db_cons_dnc:invalid_flag:ENUM'
          ,'db_cons_scrubbed_phoneable:invalid_flag:ENUM'
          ,'db_cons_children_present:invalid_children_present:ENUM'
          ,'db_cons_home_value_code:invalid_home_value:CUSTOM'
          ,'db_cons_donor_capacity_code:invalid_donor_code:CUSTOM'
          ,'db_cons_home_owner_renter:invalid_home_owner_renter:CUSTOM'
          ,'db_cons_length_of_res_code:invalid_length_of_res:CUSTOM'
          ,'db_cons_dwelling_type:invalid_dwelling_type:CUSTOM'
          ,'db_cons_recent_home_buyer:invalid_flag:ENUM'
          ,'db_cons_income_code:invalid_income_code:CUSTOM'
          ,'db_cons_unsecuredcredcapcode:invalid_unsec_cap:CUSTOM'
          ,'db_cons_networthhomevalcode:invalid_net_worth:CUSTOM'
          ,'db_cons_discretincomecode:invalid_discret_income:CUSTOM'
          ,'db_cons_marital_status:invalid_marital_status:CUSTOM'
          ,'db_cons_new_parent:invalid_new_parent:CUSTOM'
          ,'db_cons_child_near_hs_grad:invalid_flag:ENUM'
          ,'db_cons_college_graduate:invalid_flag:ENUM'
          ,'db_cons_intend_purchase_veh:invalid_flag:ENUM'
          ,'db_cons_recent_divorce:invalid_flag:ENUM'
          ,'db_cons_newlywed:invalid_flag:ENUM'
          ,'db_cons_new_teen_driver:invalid_teen_driver:CUSTOM'
          ,'db_cons_home_year_built:invalid_year:CUSTOM'
          ,'db_cons_home_sqft_ranges:invalid_home_sqft_ranges:CUSTOM'
          ,'db_cons_poli_party_ind:invalid_poli_party_ind:CUSTOM'
          ,'db_cons_occupation_ind:invalid_occupation_ind:CUSTOM'
          ,'db_cons_credit_card_user:invalid_flag:ENUM'
          ,'db_cons_home_property_type:invalid_home_property:CUSTOM'
          ,'db_cons_education_hh:invalid_education:CUSTOM'
          ,'db_cons_education_ind:invalid_education:CUSTOM'
          ,'db_cons_other_pet_owner:invalid_flag:ENUM'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,Base_Fields.InvalidMessage_dt_first_seen(1)
          ,Base_Fields.InvalidMessage_dt_last_seen(1)
          ,Base_Fields.InvalidMessage_dt_vendor_first_reported(1)
          ,Base_Fields.InvalidMessage_dt_vendor_last_reported(1)
          ,Base_Fields.InvalidMessage_process_date(1)
          ,Base_Fields.InvalidMessage_record_type(1)
          ,Base_Fields.InvalidMessage_ind_frm_indicator(1)
          ,Base_Fields.InvalidMessage_company_name(1)
          ,Base_Fields.InvalidMessage_full_name(1)
          ,Base_Fields.InvalidMessage_gender(1)
          ,Base_Fields.InvalidMessage_primary_exec_flag(1)
          ,Base_Fields.InvalidMessage_exec_type(1)
          ,Base_Fields.InvalidMessage_phy_addr_state(1)
          ,Base_Fields.InvalidMessage_phy_addr_zip(1)
          ,Base_Fields.InvalidMessage_mail_addr_state(1)
          ,Base_Fields.InvalidMessage_mail_addr_zip(1)
          ,Base_Fields.InvalidMessage_mail_score(1)
          ,Base_Fields.InvalidMessage_phone(1)
          ,Base_Fields.InvalidMessage_email(1)
          ,Base_Fields.InvalidMessage_email_available_indicator(1)
          ,Base_Fields.InvalidMessage_url(1)
          ,Base_Fields.InvalidMessage_business_status_code(1)
          ,Base_Fields.InvalidMessage_franchise_flag(1)
          ,Base_Fields.InvalidMessage_franchise_type(1)
          ,Base_Fields.InvalidMessage_county_code(1)
          ,Base_Fields.InvalidMessage_primary_sic(1)
          ,Base_Fields.InvalidMessage_sic02(1)
          ,Base_Fields.InvalidMessage_sic03(1)
          ,Base_Fields.InvalidMessage_sic04(1)
          ,Base_Fields.InvalidMessage_sic05(1)
          ,Base_Fields.InvalidMessage_sic06(1)
          ,Base_Fields.InvalidMessage_primarysic2(1)
          ,Base_Fields.InvalidMessage_primarysic4(1)
          ,Base_Fields.InvalidMessage_naics01(1)
          ,Base_Fields.InvalidMessage_naics02(1)
          ,Base_Fields.InvalidMessage_naics03(1)
          ,Base_Fields.InvalidMessage_naics04(1)
          ,Base_Fields.InvalidMessage_naics05(1)
          ,Base_Fields.InvalidMessage_naics06(1)
          ,Base_Fields.InvalidMessage_location_employee_code(1)
          ,Base_Fields.InvalidMessage_location_sales_code(1)
          ,Base_Fields.InvalidMessage_corporate_employee_code(1)
          ,Base_Fields.InvalidMessage_year_established(1)
          ,Base_Fields.InvalidMessage_female_owned(1)
          ,Base_Fields.InvalidMessage_minority_owned_flag(1)
          ,Base_Fields.InvalidMessage_home_based_indicator(1)
          ,Base_Fields.InvalidMessage_small_business_indicator(1)
          ,Base_Fields.InvalidMessage_import_export(1)
          ,Base_Fields.InvalidMessage_manufacturing_location(1)
          ,Base_Fields.InvalidMessage_public_indicator(1)
          ,Base_Fields.InvalidMessage_non_profit_org(1)
          ,Base_Fields.InvalidMessage_square_footage_code(1)
          ,Base_Fields.InvalidMessage_creditcode(1)
          ,Base_Fields.InvalidMessage_credit_capacity_code(1)
          ,Base_Fields.InvalidMessage_advertising_expenses_code(1)
          ,Base_Fields.InvalidMessage_technology_expenses_code(1)
          ,Base_Fields.InvalidMessage_office_equip_expenses_code(1)
          ,Base_Fields.InvalidMessage_rent_expenses_code(1)
          ,Base_Fields.InvalidMessage_telecom_expenses_code(1)
          ,Base_Fields.InvalidMessage_accounting_expenses_code(1)
          ,Base_Fields.InvalidMessage_bus_insurance_expense_code(1)
          ,Base_Fields.InvalidMessage_legal_expenses_code(1)
          ,Base_Fields.InvalidMessage_utilities_expenses_code(1)
          ,Base_Fields.InvalidMessage_number_of_pcs_code(1)
          ,Base_Fields.InvalidMessage_nb_flag(1)
          ,Base_Fields.InvalidMessage_domestic_foreign_owner_flag(1)
          ,Base_Fields.InvalidMessage_db_cons_full_name(1)
          ,Base_Fields.InvalidMessage_db_cons_email(1)
          ,Base_Fields.InvalidMessage_db_cons_gender(1)
          ,Base_Fields.InvalidMessage_db_cons_date_of_birth_year(1)
          ,Base_Fields.InvalidMessage_db_cons_date_of_birth_month(1)
          ,Base_Fields.InvalidMessage_db_cons_age(1)
          ,Base_Fields.InvalidMessage_db_cons_ethnic_code(1)
          ,Base_Fields.InvalidMessage_db_cons_religious_affil(1)
          ,Base_Fields.InvalidMessage_db_cons_language_pref(1)
          ,Base_Fields.InvalidMessage_db_cons_time_zone_code(1)
          ,Base_Fields.InvalidMessage_db_cons_phone(1)
          ,Base_Fields.InvalidMessage_db_cons_dnc(1)
          ,Base_Fields.InvalidMessage_db_cons_scrubbed_phoneable(1)
          ,Base_Fields.InvalidMessage_db_cons_children_present(1)
          ,Base_Fields.InvalidMessage_db_cons_home_value_code(1)
          ,Base_Fields.InvalidMessage_db_cons_donor_capacity_code(1)
          ,Base_Fields.InvalidMessage_db_cons_home_owner_renter(1)
          ,Base_Fields.InvalidMessage_db_cons_length_of_res_code(1)
          ,Base_Fields.InvalidMessage_db_cons_dwelling_type(1)
          ,Base_Fields.InvalidMessage_db_cons_recent_home_buyer(1)
          ,Base_Fields.InvalidMessage_db_cons_income_code(1)
          ,Base_Fields.InvalidMessage_db_cons_unsecuredcredcapcode(1)
          ,Base_Fields.InvalidMessage_db_cons_networthhomevalcode(1)
          ,Base_Fields.InvalidMessage_db_cons_discretincomecode(1)
          ,Base_Fields.InvalidMessage_db_cons_marital_status(1)
          ,Base_Fields.InvalidMessage_db_cons_new_parent(1)
          ,Base_Fields.InvalidMessage_db_cons_child_near_hs_grad(1)
          ,Base_Fields.InvalidMessage_db_cons_college_graduate(1)
          ,Base_Fields.InvalidMessage_db_cons_intend_purchase_veh(1)
          ,Base_Fields.InvalidMessage_db_cons_recent_divorce(1)
          ,Base_Fields.InvalidMessage_db_cons_newlywed(1)
          ,Base_Fields.InvalidMessage_db_cons_new_teen_driver(1)
          ,Base_Fields.InvalidMessage_db_cons_home_year_built(1)
          ,Base_Fields.InvalidMessage_db_cons_home_sqft_ranges(1)
          ,Base_Fields.InvalidMessage_db_cons_poli_party_ind(1)
          ,Base_Fields.InvalidMessage_db_cons_occupation_ind(1)
          ,Base_Fields.InvalidMessage_db_cons_credit_card_user(1)
          ,Base_Fields.InvalidMessage_db_cons_home_property_type(1)
          ,Base_Fields.InvalidMessage_db_cons_education_hh(1)
          ,Base_Fields.InvalidMessage_db_cons_education_ind(1)
          ,Base_Fields.InvalidMessage_db_cons_other_pet_owner(1)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.dt_first_seen_CUSTOM_ErrorCount
          ,le.dt_last_seen_CUSTOM_ErrorCount
          ,le.dt_vendor_first_reported_CUSTOM_ErrorCount
          ,le.dt_vendor_last_reported_CUSTOM_ErrorCount
          ,le.process_date_CUSTOM_ErrorCount
          ,le.record_type_ENUM_ErrorCount
          ,le.ind_frm_indicator_ENUM_ErrorCount
          ,le.company_name_LENGTHS_ErrorCount
          ,le.full_name_LENGTHS_ErrorCount
          ,le.gender_ENUM_ErrorCount
          ,le.primary_exec_flag_ENUM_ErrorCount
          ,le.exec_type_ENUM_ErrorCount
          ,le.phy_addr_state_CUSTOM_ErrorCount
          ,le.phy_addr_zip_CUSTOM_ErrorCount
          ,le.mail_addr_state_CUSTOM_ErrorCount
          ,le.mail_addr_zip_CUSTOM_ErrorCount
          ,le.mail_score_CUSTOM_ErrorCount
          ,le.phone_CUSTOM_ErrorCount
          ,le.email_ALLOW_ErrorCount
          ,le.email_available_indicator_ENUM_ErrorCount
          ,le.url_CUSTOM_ErrorCount
          ,le.business_status_code_ENUM_ErrorCount
          ,le.franchise_flag_ENUM_ErrorCount
          ,le.franchise_type_CUSTOM_ErrorCount
          ,le.county_code_CUSTOM_ErrorCount
          ,le.primary_sic_CUSTOM_ErrorCount
          ,le.sic02_CUSTOM_ErrorCount
          ,le.sic03_CUSTOM_ErrorCount
          ,le.sic04_CUSTOM_ErrorCount
          ,le.sic05_CUSTOM_ErrorCount
          ,le.sic06_CUSTOM_ErrorCount
          ,le.primarysic2_CUSTOM_ErrorCount
          ,le.primarysic4_CUSTOM_ErrorCount
          ,le.naics01_CUSTOM_ErrorCount
          ,le.naics02_CUSTOM_ErrorCount
          ,le.naics03_CUSTOM_ErrorCount
          ,le.naics04_CUSTOM_ErrorCount
          ,le.naics05_CUSTOM_ErrorCount
          ,le.naics06_CUSTOM_ErrorCount
          ,le.location_employee_code_CUSTOM_ErrorCount
          ,le.location_sales_code_CUSTOM_ErrorCount
          ,le.corporate_employee_code_CUSTOM_ErrorCount
          ,le.year_established_CUSTOM_ErrorCount
          ,le.female_owned_ENUM_ErrorCount
          ,le.minority_owned_flag_ENUM_ErrorCount
          ,le.home_based_indicator_ENUM_ErrorCount
          ,le.small_business_indicator_ENUM_ErrorCount
          ,le.import_export_ENUM_ErrorCount
          ,le.manufacturing_location_ENUM_ErrorCount
          ,le.public_indicator_ENUM_ErrorCount
          ,le.non_profit_org_ENUM_ErrorCount
          ,le.square_footage_code_CUSTOM_ErrorCount
          ,le.creditcode_CUSTOM_ErrorCount
          ,le.credit_capacity_code_CUSTOM_ErrorCount
          ,le.advertising_expenses_code_CUSTOM_ErrorCount
          ,le.technology_expenses_code_CUSTOM_ErrorCount
          ,le.office_equip_expenses_code_CUSTOM_ErrorCount
          ,le.rent_expenses_code_CUSTOM_ErrorCount
          ,le.telecom_expenses_code_CUSTOM_ErrorCount
          ,le.accounting_expenses_code_CUSTOM_ErrorCount
          ,le.bus_insurance_expense_code_CUSTOM_ErrorCount
          ,le.legal_expenses_code_CUSTOM_ErrorCount
          ,le.utilities_expenses_code_CUSTOM_ErrorCount
          ,le.number_of_pcs_code_CUSTOM_ErrorCount
          ,le.nb_flag_ENUM_ErrorCount
          ,le.domestic_foreign_owner_flag_ENUM_ErrorCount
          ,le.db_cons_full_name_LENGTHS_ErrorCount
          ,le.db_cons_email_ALLOW_ErrorCount
          ,le.db_cons_gender_ENUM_ErrorCount
          ,le.db_cons_date_of_birth_year_CUSTOM_ErrorCount
          ,le.db_cons_date_of_birth_month_ENUM_ErrorCount
          ,le.db_cons_age_ALLOW_ErrorCount
          ,le.db_cons_ethnic_code_CUSTOM_ErrorCount
          ,le.db_cons_religious_affil_CUSTOM_ErrorCount
          ,le.db_cons_language_pref_CUSTOM_ErrorCount
          ,le.db_cons_time_zone_code_CUSTOM_ErrorCount
          ,le.db_cons_phone_CUSTOM_ErrorCount
          ,le.db_cons_dnc_ENUM_ErrorCount
          ,le.db_cons_scrubbed_phoneable_ENUM_ErrorCount
          ,le.db_cons_children_present_ENUM_ErrorCount
          ,le.db_cons_home_value_code_CUSTOM_ErrorCount
          ,le.db_cons_donor_capacity_code_CUSTOM_ErrorCount
          ,le.db_cons_home_owner_renter_CUSTOM_ErrorCount
          ,le.db_cons_length_of_res_code_CUSTOM_ErrorCount
          ,le.db_cons_dwelling_type_CUSTOM_ErrorCount
          ,le.db_cons_recent_home_buyer_ENUM_ErrorCount
          ,le.db_cons_income_code_CUSTOM_ErrorCount
          ,le.db_cons_unsecuredcredcapcode_CUSTOM_ErrorCount
          ,le.db_cons_networthhomevalcode_CUSTOM_ErrorCount
          ,le.db_cons_discretincomecode_CUSTOM_ErrorCount
          ,le.db_cons_marital_status_CUSTOM_ErrorCount
          ,le.db_cons_new_parent_CUSTOM_ErrorCount
          ,le.db_cons_child_near_hs_grad_ENUM_ErrorCount
          ,le.db_cons_college_graduate_ENUM_ErrorCount
          ,le.db_cons_intend_purchase_veh_ENUM_ErrorCount
          ,le.db_cons_recent_divorce_ENUM_ErrorCount
          ,le.db_cons_newlywed_ENUM_ErrorCount
          ,le.db_cons_new_teen_driver_CUSTOM_ErrorCount
          ,le.db_cons_home_year_built_CUSTOM_ErrorCount
          ,le.db_cons_home_sqft_ranges_CUSTOM_ErrorCount
          ,le.db_cons_poli_party_ind_CUSTOM_ErrorCount
          ,le.db_cons_occupation_ind_CUSTOM_ErrorCount
          ,le.db_cons_credit_card_user_ENUM_ErrorCount
          ,le.db_cons_home_property_type_CUSTOM_ErrorCount
          ,le.db_cons_education_hh_CUSTOM_ErrorCount
          ,le.db_cons_education_ind_CUSTOM_ErrorCount
          ,le.db_cons_other_pet_owner_ENUM_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.dt_first_seen_CUSTOM_ErrorCount
          ,le.dt_last_seen_CUSTOM_ErrorCount
          ,le.dt_vendor_first_reported_CUSTOM_ErrorCount
          ,le.dt_vendor_last_reported_CUSTOM_ErrorCount
          ,le.process_date_CUSTOM_ErrorCount
          ,le.record_type_ENUM_ErrorCount
          ,le.ind_frm_indicator_ENUM_ErrorCount
          ,le.company_name_LENGTHS_ErrorCount
          ,le.full_name_LENGTHS_ErrorCount
          ,le.gender_ENUM_ErrorCount
          ,le.primary_exec_flag_ENUM_ErrorCount
          ,le.exec_type_ENUM_ErrorCount
          ,le.phy_addr_state_CUSTOM_ErrorCount
          ,le.phy_addr_zip_CUSTOM_ErrorCount
          ,le.mail_addr_state_CUSTOM_ErrorCount
          ,le.mail_addr_zip_CUSTOM_ErrorCount
          ,le.mail_score_CUSTOM_ErrorCount
          ,le.phone_CUSTOM_ErrorCount
          ,le.email_ALLOW_ErrorCount
          ,le.email_available_indicator_ENUM_ErrorCount
          ,le.url_CUSTOM_ErrorCount
          ,le.business_status_code_ENUM_ErrorCount
          ,le.franchise_flag_ENUM_ErrorCount
          ,le.franchise_type_CUSTOM_ErrorCount
          ,le.county_code_CUSTOM_ErrorCount
          ,le.primary_sic_CUSTOM_ErrorCount
          ,le.sic02_CUSTOM_ErrorCount
          ,le.sic03_CUSTOM_ErrorCount
          ,le.sic04_CUSTOM_ErrorCount
          ,le.sic05_CUSTOM_ErrorCount
          ,le.sic06_CUSTOM_ErrorCount
          ,le.primarysic2_CUSTOM_ErrorCount
          ,le.primarysic4_CUSTOM_ErrorCount
          ,le.naics01_CUSTOM_ErrorCount
          ,le.naics02_CUSTOM_ErrorCount
          ,le.naics03_CUSTOM_ErrorCount
          ,le.naics04_CUSTOM_ErrorCount
          ,le.naics05_CUSTOM_ErrorCount
          ,le.naics06_CUSTOM_ErrorCount
          ,le.location_employee_code_CUSTOM_ErrorCount
          ,le.location_sales_code_CUSTOM_ErrorCount
          ,le.corporate_employee_code_CUSTOM_ErrorCount
          ,le.year_established_CUSTOM_ErrorCount
          ,le.female_owned_ENUM_ErrorCount
          ,le.minority_owned_flag_ENUM_ErrorCount
          ,le.home_based_indicator_ENUM_ErrorCount
          ,le.small_business_indicator_ENUM_ErrorCount
          ,le.import_export_ENUM_ErrorCount
          ,le.manufacturing_location_ENUM_ErrorCount
          ,le.public_indicator_ENUM_ErrorCount
          ,le.non_profit_org_ENUM_ErrorCount
          ,le.square_footage_code_CUSTOM_ErrorCount
          ,le.creditcode_CUSTOM_ErrorCount
          ,le.credit_capacity_code_CUSTOM_ErrorCount
          ,le.advertising_expenses_code_CUSTOM_ErrorCount
          ,le.technology_expenses_code_CUSTOM_ErrorCount
          ,le.office_equip_expenses_code_CUSTOM_ErrorCount
          ,le.rent_expenses_code_CUSTOM_ErrorCount
          ,le.telecom_expenses_code_CUSTOM_ErrorCount
          ,le.accounting_expenses_code_CUSTOM_ErrorCount
          ,le.bus_insurance_expense_code_CUSTOM_ErrorCount
          ,le.legal_expenses_code_CUSTOM_ErrorCount
          ,le.utilities_expenses_code_CUSTOM_ErrorCount
          ,le.number_of_pcs_code_CUSTOM_ErrorCount
          ,le.nb_flag_ENUM_ErrorCount
          ,le.domestic_foreign_owner_flag_ENUM_ErrorCount
          ,le.db_cons_full_name_LENGTHS_ErrorCount
          ,le.db_cons_email_ALLOW_ErrorCount
          ,le.db_cons_gender_ENUM_ErrorCount
          ,le.db_cons_date_of_birth_year_CUSTOM_ErrorCount
          ,le.db_cons_date_of_birth_month_ENUM_ErrorCount
          ,le.db_cons_age_ALLOW_ErrorCount
          ,le.db_cons_ethnic_code_CUSTOM_ErrorCount
          ,le.db_cons_religious_affil_CUSTOM_ErrorCount
          ,le.db_cons_language_pref_CUSTOM_ErrorCount
          ,le.db_cons_time_zone_code_CUSTOM_ErrorCount
          ,le.db_cons_phone_CUSTOM_ErrorCount
          ,le.db_cons_dnc_ENUM_ErrorCount
          ,le.db_cons_scrubbed_phoneable_ENUM_ErrorCount
          ,le.db_cons_children_present_ENUM_ErrorCount
          ,le.db_cons_home_value_code_CUSTOM_ErrorCount
          ,le.db_cons_donor_capacity_code_CUSTOM_ErrorCount
          ,le.db_cons_home_owner_renter_CUSTOM_ErrorCount
          ,le.db_cons_length_of_res_code_CUSTOM_ErrorCount
          ,le.db_cons_dwelling_type_CUSTOM_ErrorCount
          ,le.db_cons_recent_home_buyer_ENUM_ErrorCount
          ,le.db_cons_income_code_CUSTOM_ErrorCount
          ,le.db_cons_unsecuredcredcapcode_CUSTOM_ErrorCount
          ,le.db_cons_networthhomevalcode_CUSTOM_ErrorCount
          ,le.db_cons_discretincomecode_CUSTOM_ErrorCount
          ,le.db_cons_marital_status_CUSTOM_ErrorCount
          ,le.db_cons_new_parent_CUSTOM_ErrorCount
          ,le.db_cons_child_near_hs_grad_ENUM_ErrorCount
          ,le.db_cons_college_graduate_ENUM_ErrorCount
          ,le.db_cons_intend_purchase_veh_ENUM_ErrorCount
          ,le.db_cons_recent_divorce_ENUM_ErrorCount
          ,le.db_cons_newlywed_ENUM_ErrorCount
          ,le.db_cons_new_teen_driver_CUSTOM_ErrorCount
          ,le.db_cons_home_year_built_CUSTOM_ErrorCount
          ,le.db_cons_home_sqft_ranges_CUSTOM_ErrorCount
          ,le.db_cons_poli_party_ind_CUSTOM_ErrorCount
          ,le.db_cons_occupation_ind_CUSTOM_ErrorCount
          ,le.db_cons_credit_card_user_ENUM_ErrorCount
          ,le.db_cons_home_property_type_CUSTOM_ErrorCount
          ,le.db_cons_education_hh_CUSTOM_ErrorCount
          ,le.db_cons_education_ind_CUSTOM_ErrorCount
          ,le.db_cons_other_pet_owner_ENUM_ErrorCount,0) / le.TotalCnt, CHOOSE(c - NumRules
          ,IF(NumFieldsWithRules = 0, 0, le.FieldsChecked_WithErrors/NumFieldsWithRules * 100)
          ,IF(NumFieldsWithRules = 0, 0, le.FieldsChecked_NoErrors/NumFieldsWithRules * 100)
          ,IF(NumRules = 0, 0, le.Rules_WithErrors/NumRules * 100)
          ,IF(NumRules = 0, 0, le.Rules_NoErrors/NumRules * 100)
          ,0
          ,IF(SELF.recordstotal = 0, 0, le.AnyRule_WithErrorsCount/SELF.recordstotal * 100)
          ,IF(SELF.recordstotal = 0, 0, (SELF.recordstotal - le.AnyRule_WithErrorsCount)/SELF.recordstotal * 100),0));
    END;
    SummaryInfo := NORMALIZE(SummaryStats,NumRules + 7,Into(LEFT,COUNTER));
    orb_r := RECORD
      AllErrors.Src;
      STRING RuleDesc := TRIM(AllErrors.FieldName)+':'+TRIM(AllErrors.FieldType)+':'+AllErrors.ErrorType;
      STRING ErrorMessage := TRIM(AllErrors.errormessage);
      SALT311.StrType RawCodeMissing := AllErrors.FieldContents;
    END;
    tab := TABLE(AllErrors,orb_r);
    orb_sum := TABLE(tab,{src,ruledesc,ErrorMessage,rawcodemissing,rawcodemissingcnt := COUNT(GROUP)},src,ruledesc,ErrorMessage,rawcodemissing,MERGE);
    gt := GROUP(TOPN(GROUP(orb_sum,src,ruledesc,ALL),examples,-rawcodemissingcnt));
    SALT311.ScrubsOrbitLayout jn(SummaryInfo le, gt ri) := TRANSFORM
      SELF.rawcodemissing := ri.rawcodemissing;
      SELF.rawcodemissingcnt := ri.rawcodemissingcnt;
      SELF := le;
    END;
    j := JOIN(SummaryInfo,gt,LEFT.ruledesc=RIGHT.ruledesc,jn(LEFT,RIGHT),HASH,LEFT OUTER);
    FieldErrorStats := IF(examples>0,j,SummaryInfo);
 
    // field population stats
    mod_hygiene := Base_hygiene(PROJECT(h, Scrubs_Database_USA.Base_Layout_Database_USA));
    hygiene_summaryStats := mod_hygiene.Summary('');
    getFieldTypeText(infield) := FUNCTIONMACRO
      isNumField := (STRING)((TYPEOF(infield))'') = '0';
      RETURN IF(isNumField, 'nonzero', 'nonblank');
    ENDMACRO;
    SALT311.ScrubsOrbitLayout xNormHygieneStats(hygiene_summaryStats le, UNSIGNED c, STRING suffix) := TRANSFORM
      SELF.recordstotal := le.NumberOfRecords;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'dt_first_seen:' + getFieldTypeText(h.dt_first_seen) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dt_last_seen:' + getFieldTypeText(h.dt_last_seen) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dt_vendor_first_reported:' + getFieldTypeText(h.dt_vendor_first_reported) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dt_vendor_last_reported:' + getFieldTypeText(h.dt_vendor_last_reported) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'process_date:' + getFieldTypeText(h.process_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'record_type:' + getFieldTypeText(h.record_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ind_frm_indicator:' + getFieldTypeText(h.ind_frm_indicator) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'company_name:' + getFieldTypeText(h.company_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'full_name:' + getFieldTypeText(h.full_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'gender:' + getFieldTypeText(h.gender) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'primary_exec_flag:' + getFieldTypeText(h.primary_exec_flag) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'exec_type:' + getFieldTypeText(h.exec_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'phy_addr_state:' + getFieldTypeText(h.phy_addr_state) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'phy_addr_zip:' + getFieldTypeText(h.phy_addr_zip) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mail_addr_state:' + getFieldTypeText(h.mail_addr_state) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mail_addr_zip:' + getFieldTypeText(h.mail_addr_zip) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mail_score:' + getFieldTypeText(h.mail_score) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'phone:' + getFieldTypeText(h.phone) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'email:' + getFieldTypeText(h.email) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'email_available_indicator:' + getFieldTypeText(h.email_available_indicator) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'url:' + getFieldTypeText(h.url) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'business_status_code:' + getFieldTypeText(h.business_status_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'franchise_flag:' + getFieldTypeText(h.franchise_flag) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'franchise_type:' + getFieldTypeText(h.franchise_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'county_code:' + getFieldTypeText(h.county_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'primary_sic:' + getFieldTypeText(h.primary_sic) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sic02:' + getFieldTypeText(h.sic02) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sic03:' + getFieldTypeText(h.sic03) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sic04:' + getFieldTypeText(h.sic04) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sic05:' + getFieldTypeText(h.sic05) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sic06:' + getFieldTypeText(h.sic06) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'primarysic2:' + getFieldTypeText(h.primarysic2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'primarysic4:' + getFieldTypeText(h.primarysic4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'naics01:' + getFieldTypeText(h.naics01) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'naics02:' + getFieldTypeText(h.naics02) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'naics03:' + getFieldTypeText(h.naics03) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'naics04:' + getFieldTypeText(h.naics04) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'naics05:' + getFieldTypeText(h.naics05) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'naics06:' + getFieldTypeText(h.naics06) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'location_employee_code:' + getFieldTypeText(h.location_employee_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'location_sales_code:' + getFieldTypeText(h.location_sales_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corporate_employee_code:' + getFieldTypeText(h.corporate_employee_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'year_established:' + getFieldTypeText(h.year_established) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'female_owned:' + getFieldTypeText(h.female_owned) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'minority_owned_flag:' + getFieldTypeText(h.minority_owned_flag) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'home_based_indicator:' + getFieldTypeText(h.home_based_indicator) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'small_business_indicator:' + getFieldTypeText(h.small_business_indicator) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'import_export:' + getFieldTypeText(h.import_export) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'manufacturing_location:' + getFieldTypeText(h.manufacturing_location) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'public_indicator:' + getFieldTypeText(h.public_indicator) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'non_profit_org:' + getFieldTypeText(h.non_profit_org) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'square_footage_code:' + getFieldTypeText(h.square_footage_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'creditcode:' + getFieldTypeText(h.creditcode) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'credit_capacity_code:' + getFieldTypeText(h.credit_capacity_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'advertising_expenses_code:' + getFieldTypeText(h.advertising_expenses_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'technology_expenses_code:' + getFieldTypeText(h.technology_expenses_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'office_equip_expenses_code:' + getFieldTypeText(h.office_equip_expenses_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rent_expenses_code:' + getFieldTypeText(h.rent_expenses_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'telecom_expenses_code:' + getFieldTypeText(h.telecom_expenses_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'accounting_expenses_code:' + getFieldTypeText(h.accounting_expenses_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'bus_insurance_expense_code:' + getFieldTypeText(h.bus_insurance_expense_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'legal_expenses_code:' + getFieldTypeText(h.legal_expenses_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'utilities_expenses_code:' + getFieldTypeText(h.utilities_expenses_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'number_of_pcs_code:' + getFieldTypeText(h.number_of_pcs_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'nb_flag:' + getFieldTypeText(h.nb_flag) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'domestic_foreign_owner_flag:' + getFieldTypeText(h.domestic_foreign_owner_flag) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'db_cons_full_name:' + getFieldTypeText(h.db_cons_full_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'db_cons_email:' + getFieldTypeText(h.db_cons_email) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'db_cons_gender:' + getFieldTypeText(h.db_cons_gender) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'db_cons_date_of_birth_year:' + getFieldTypeText(h.db_cons_date_of_birth_year) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'db_cons_date_of_birth_month:' + getFieldTypeText(h.db_cons_date_of_birth_month) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'db_cons_age:' + getFieldTypeText(h.db_cons_age) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'db_cons_ethnic_code:' + getFieldTypeText(h.db_cons_ethnic_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'db_cons_religious_affil:' + getFieldTypeText(h.db_cons_religious_affil) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'db_cons_language_pref:' + getFieldTypeText(h.db_cons_language_pref) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'db_cons_time_zone_code:' + getFieldTypeText(h.db_cons_time_zone_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'db_cons_phone:' + getFieldTypeText(h.db_cons_phone) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'db_cons_dnc:' + getFieldTypeText(h.db_cons_dnc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'db_cons_scrubbed_phoneable:' + getFieldTypeText(h.db_cons_scrubbed_phoneable) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'db_cons_children_present:' + getFieldTypeText(h.db_cons_children_present) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'db_cons_home_value_code:' + getFieldTypeText(h.db_cons_home_value_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'db_cons_donor_capacity_code:' + getFieldTypeText(h.db_cons_donor_capacity_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'db_cons_home_owner_renter:' + getFieldTypeText(h.db_cons_home_owner_renter) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'db_cons_length_of_res_code:' + getFieldTypeText(h.db_cons_length_of_res_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'db_cons_dwelling_type:' + getFieldTypeText(h.db_cons_dwelling_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'db_cons_recent_home_buyer:' + getFieldTypeText(h.db_cons_recent_home_buyer) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'db_cons_income_code:' + getFieldTypeText(h.db_cons_income_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'db_cons_unsecuredcredcapcode:' + getFieldTypeText(h.db_cons_unsecuredcredcapcode) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'db_cons_networthhomevalcode:' + getFieldTypeText(h.db_cons_networthhomevalcode) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'db_cons_discretincomecode:' + getFieldTypeText(h.db_cons_discretincomecode) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'db_cons_marital_status:' + getFieldTypeText(h.db_cons_marital_status) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'db_cons_new_parent:' + getFieldTypeText(h.db_cons_new_parent) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'db_cons_child_near_hs_grad:' + getFieldTypeText(h.db_cons_child_near_hs_grad) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'db_cons_college_graduate:' + getFieldTypeText(h.db_cons_college_graduate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'db_cons_intend_purchase_veh:' + getFieldTypeText(h.db_cons_intend_purchase_veh) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'db_cons_recent_divorce:' + getFieldTypeText(h.db_cons_recent_divorce) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'db_cons_newlywed:' + getFieldTypeText(h.db_cons_newlywed) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'db_cons_new_teen_driver:' + getFieldTypeText(h.db_cons_new_teen_driver) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'db_cons_home_year_built:' + getFieldTypeText(h.db_cons_home_year_built) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'db_cons_home_sqft_ranges:' + getFieldTypeText(h.db_cons_home_sqft_ranges) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'db_cons_poli_party_ind:' + getFieldTypeText(h.db_cons_poli_party_ind) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'db_cons_occupation_ind:' + getFieldTypeText(h.db_cons_occupation_ind) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'db_cons_credit_card_user:' + getFieldTypeText(h.db_cons_credit_card_user) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'db_cons_home_property_type:' + getFieldTypeText(h.db_cons_home_property_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'db_cons_education_hh:' + getFieldTypeText(h.db_cons_education_hh) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'db_cons_education_ind:' + getFieldTypeText(h.db_cons_education_ind) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'db_cons_other_pet_owner:' + getFieldTypeText(h.db_cons_other_pet_owner) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_dt_first_seen_cnt
          ,le.populated_dt_last_seen_cnt
          ,le.populated_dt_vendor_first_reported_cnt
          ,le.populated_dt_vendor_last_reported_cnt
          ,le.populated_process_date_cnt
          ,le.populated_record_type_cnt
          ,le.populated_ind_frm_indicator_cnt
          ,le.populated_company_name_cnt
          ,le.populated_full_name_cnt
          ,le.populated_gender_cnt
          ,le.populated_primary_exec_flag_cnt
          ,le.populated_exec_type_cnt
          ,le.populated_phy_addr_state_cnt
          ,le.populated_phy_addr_zip_cnt
          ,le.populated_mail_addr_state_cnt
          ,le.populated_mail_addr_zip_cnt
          ,le.populated_mail_score_cnt
          ,le.populated_phone_cnt
          ,le.populated_email_cnt
          ,le.populated_email_available_indicator_cnt
          ,le.populated_url_cnt
          ,le.populated_business_status_code_cnt
          ,le.populated_franchise_flag_cnt
          ,le.populated_franchise_type_cnt
          ,le.populated_county_code_cnt
          ,le.populated_primary_sic_cnt
          ,le.populated_sic02_cnt
          ,le.populated_sic03_cnt
          ,le.populated_sic04_cnt
          ,le.populated_sic05_cnt
          ,le.populated_sic06_cnt
          ,le.populated_primarysic2_cnt
          ,le.populated_primarysic4_cnt
          ,le.populated_naics01_cnt
          ,le.populated_naics02_cnt
          ,le.populated_naics03_cnt
          ,le.populated_naics04_cnt
          ,le.populated_naics05_cnt
          ,le.populated_naics06_cnt
          ,le.populated_location_employee_code_cnt
          ,le.populated_location_sales_code_cnt
          ,le.populated_corporate_employee_code_cnt
          ,le.populated_year_established_cnt
          ,le.populated_female_owned_cnt
          ,le.populated_minority_owned_flag_cnt
          ,le.populated_home_based_indicator_cnt
          ,le.populated_small_business_indicator_cnt
          ,le.populated_import_export_cnt
          ,le.populated_manufacturing_location_cnt
          ,le.populated_public_indicator_cnt
          ,le.populated_non_profit_org_cnt
          ,le.populated_square_footage_code_cnt
          ,le.populated_creditcode_cnt
          ,le.populated_credit_capacity_code_cnt
          ,le.populated_advertising_expenses_code_cnt
          ,le.populated_technology_expenses_code_cnt
          ,le.populated_office_equip_expenses_code_cnt
          ,le.populated_rent_expenses_code_cnt
          ,le.populated_telecom_expenses_code_cnt
          ,le.populated_accounting_expenses_code_cnt
          ,le.populated_bus_insurance_expense_code_cnt
          ,le.populated_legal_expenses_code_cnt
          ,le.populated_utilities_expenses_code_cnt
          ,le.populated_number_of_pcs_code_cnt
          ,le.populated_nb_flag_cnt
          ,le.populated_domestic_foreign_owner_flag_cnt
          ,le.populated_db_cons_full_name_cnt
          ,le.populated_db_cons_email_cnt
          ,le.populated_db_cons_gender_cnt
          ,le.populated_db_cons_date_of_birth_year_cnt
          ,le.populated_db_cons_date_of_birth_month_cnt
          ,le.populated_db_cons_age_cnt
          ,le.populated_db_cons_ethnic_code_cnt
          ,le.populated_db_cons_religious_affil_cnt
          ,le.populated_db_cons_language_pref_cnt
          ,le.populated_db_cons_time_zone_code_cnt
          ,le.populated_db_cons_phone_cnt
          ,le.populated_db_cons_dnc_cnt
          ,le.populated_db_cons_scrubbed_phoneable_cnt
          ,le.populated_db_cons_children_present_cnt
          ,le.populated_db_cons_home_value_code_cnt
          ,le.populated_db_cons_donor_capacity_code_cnt
          ,le.populated_db_cons_home_owner_renter_cnt
          ,le.populated_db_cons_length_of_res_code_cnt
          ,le.populated_db_cons_dwelling_type_cnt
          ,le.populated_db_cons_recent_home_buyer_cnt
          ,le.populated_db_cons_income_code_cnt
          ,le.populated_db_cons_unsecuredcredcapcode_cnt
          ,le.populated_db_cons_networthhomevalcode_cnt
          ,le.populated_db_cons_discretincomecode_cnt
          ,le.populated_db_cons_marital_status_cnt
          ,le.populated_db_cons_new_parent_cnt
          ,le.populated_db_cons_child_near_hs_grad_cnt
          ,le.populated_db_cons_college_graduate_cnt
          ,le.populated_db_cons_intend_purchase_veh_cnt
          ,le.populated_db_cons_recent_divorce_cnt
          ,le.populated_db_cons_newlywed_cnt
          ,le.populated_db_cons_new_teen_driver_cnt
          ,le.populated_db_cons_home_year_built_cnt
          ,le.populated_db_cons_home_sqft_ranges_cnt
          ,le.populated_db_cons_poli_party_ind_cnt
          ,le.populated_db_cons_occupation_ind_cnt
          ,le.populated_db_cons_credit_card_user_cnt
          ,le.populated_db_cons_home_property_type_cnt
          ,le.populated_db_cons_education_hh_cnt
          ,le.populated_db_cons_education_ind_cnt
          ,le.populated_db_cons_other_pet_owner_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_dt_first_seen_pcnt
          ,le.populated_dt_last_seen_pcnt
          ,le.populated_dt_vendor_first_reported_pcnt
          ,le.populated_dt_vendor_last_reported_pcnt
          ,le.populated_process_date_pcnt
          ,le.populated_record_type_pcnt
          ,le.populated_ind_frm_indicator_pcnt
          ,le.populated_company_name_pcnt
          ,le.populated_full_name_pcnt
          ,le.populated_gender_pcnt
          ,le.populated_primary_exec_flag_pcnt
          ,le.populated_exec_type_pcnt
          ,le.populated_phy_addr_state_pcnt
          ,le.populated_phy_addr_zip_pcnt
          ,le.populated_mail_addr_state_pcnt
          ,le.populated_mail_addr_zip_pcnt
          ,le.populated_mail_score_pcnt
          ,le.populated_phone_pcnt
          ,le.populated_email_pcnt
          ,le.populated_email_available_indicator_pcnt
          ,le.populated_url_pcnt
          ,le.populated_business_status_code_pcnt
          ,le.populated_franchise_flag_pcnt
          ,le.populated_franchise_type_pcnt
          ,le.populated_county_code_pcnt
          ,le.populated_primary_sic_pcnt
          ,le.populated_sic02_pcnt
          ,le.populated_sic03_pcnt
          ,le.populated_sic04_pcnt
          ,le.populated_sic05_pcnt
          ,le.populated_sic06_pcnt
          ,le.populated_primarysic2_pcnt
          ,le.populated_primarysic4_pcnt
          ,le.populated_naics01_pcnt
          ,le.populated_naics02_pcnt
          ,le.populated_naics03_pcnt
          ,le.populated_naics04_pcnt
          ,le.populated_naics05_pcnt
          ,le.populated_naics06_pcnt
          ,le.populated_location_employee_code_pcnt
          ,le.populated_location_sales_code_pcnt
          ,le.populated_corporate_employee_code_pcnt
          ,le.populated_year_established_pcnt
          ,le.populated_female_owned_pcnt
          ,le.populated_minority_owned_flag_pcnt
          ,le.populated_home_based_indicator_pcnt
          ,le.populated_small_business_indicator_pcnt
          ,le.populated_import_export_pcnt
          ,le.populated_manufacturing_location_pcnt
          ,le.populated_public_indicator_pcnt
          ,le.populated_non_profit_org_pcnt
          ,le.populated_square_footage_code_pcnt
          ,le.populated_creditcode_pcnt
          ,le.populated_credit_capacity_code_pcnt
          ,le.populated_advertising_expenses_code_pcnt
          ,le.populated_technology_expenses_code_pcnt
          ,le.populated_office_equip_expenses_code_pcnt
          ,le.populated_rent_expenses_code_pcnt
          ,le.populated_telecom_expenses_code_pcnt
          ,le.populated_accounting_expenses_code_pcnt
          ,le.populated_bus_insurance_expense_code_pcnt
          ,le.populated_legal_expenses_code_pcnt
          ,le.populated_utilities_expenses_code_pcnt
          ,le.populated_number_of_pcs_code_pcnt
          ,le.populated_nb_flag_pcnt
          ,le.populated_domestic_foreign_owner_flag_pcnt
          ,le.populated_db_cons_full_name_pcnt
          ,le.populated_db_cons_email_pcnt
          ,le.populated_db_cons_gender_pcnt
          ,le.populated_db_cons_date_of_birth_year_pcnt
          ,le.populated_db_cons_date_of_birth_month_pcnt
          ,le.populated_db_cons_age_pcnt
          ,le.populated_db_cons_ethnic_code_pcnt
          ,le.populated_db_cons_religious_affil_pcnt
          ,le.populated_db_cons_language_pref_pcnt
          ,le.populated_db_cons_time_zone_code_pcnt
          ,le.populated_db_cons_phone_pcnt
          ,le.populated_db_cons_dnc_pcnt
          ,le.populated_db_cons_scrubbed_phoneable_pcnt
          ,le.populated_db_cons_children_present_pcnt
          ,le.populated_db_cons_home_value_code_pcnt
          ,le.populated_db_cons_donor_capacity_code_pcnt
          ,le.populated_db_cons_home_owner_renter_pcnt
          ,le.populated_db_cons_length_of_res_code_pcnt
          ,le.populated_db_cons_dwelling_type_pcnt
          ,le.populated_db_cons_recent_home_buyer_pcnt
          ,le.populated_db_cons_income_code_pcnt
          ,le.populated_db_cons_unsecuredcredcapcode_pcnt
          ,le.populated_db_cons_networthhomevalcode_pcnt
          ,le.populated_db_cons_discretincomecode_pcnt
          ,le.populated_db_cons_marital_status_pcnt
          ,le.populated_db_cons_new_parent_pcnt
          ,le.populated_db_cons_child_near_hs_grad_pcnt
          ,le.populated_db_cons_college_graduate_pcnt
          ,le.populated_db_cons_intend_purchase_veh_pcnt
          ,le.populated_db_cons_recent_divorce_pcnt
          ,le.populated_db_cons_newlywed_pcnt
          ,le.populated_db_cons_new_teen_driver_pcnt
          ,le.populated_db_cons_home_year_built_pcnt
          ,le.populated_db_cons_home_sqft_ranges_pcnt
          ,le.populated_db_cons_poli_party_ind_pcnt
          ,le.populated_db_cons_occupation_ind_pcnt
          ,le.populated_db_cons_credit_card_user_pcnt
          ,le.populated_db_cons_home_property_type_pcnt
          ,le.populated_db_cons_education_hh_pcnt
          ,le.populated_db_cons_education_ind_pcnt
          ,le.populated_db_cons_other_pet_owner_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,107,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
  // record count stats
    SALT311.ScrubsOrbitLayout xTotalRecs(hygiene_summaryStats le, STRING inRuleDesc) := TRANSFORM
      SELF.recordstotal := le.NumberOfRecords;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := inRuleDesc;
      SELF.ErrorMessage := '';
      SELF.rulecnt := le.NumberOfRecords;
      SELF.rulepcnt := 0;
    END;
    TotalRecsStats := PROJECT(hygiene_summaryStats, xTotalRecs(LEFT, 'records:total_records:POP'));
 
    mod_Delta := Base_Delta(prevDS, PROJECT(h, Scrubs_Database_USA.Base_Layout_Database_USA));
    deltaHygieneSummary := mod_Delta.DifferenceSummary;
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),107,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);
 
    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;
 
EXPORT StandardStats(DATASET(Scrubs_Database_USA.Base_Layout_Database_USA) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT311.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_Database_USA, Base_Fields, 'RECORDOF(scrubsSummaryOverall)', '');
  scrubsSummaryOverall_Standard := NORMALIZE(scrubsSummaryOverall, (NumRulesFromFieldType + NumFieldsWithRules) * 4, xSummaryStats(LEFT, COUNTER, myTimeStamp, 'all', 'all'));
 
  allErrsOverall := mod_fromexpandedOverall.AllErrors;
  tErrsOverall := TABLE(DISTRIBUTE(allErrsOverall, HASH(FieldName, ErrorType)), {FieldName, ErrorType, FieldContents, cntExamples := COUNT(GROUP)}, FieldName, ErrorType, FieldContents, LOCAL);
 
  scrubsSummaryOverall_Standard_addErr   := IF(doErrorOverall,
                                               DENORMALIZE(SORT(DISTRIBUTE(scrubsSummaryOverall_Standard, HASH(field, ruletype)), field, ruletype, LOCAL),
  	                                                       SORT(tErrsOverall, FieldName, ErrorType, -cntExamples, FieldContents, LOCAL),
  	                                                       LEFT.field = RIGHT.FieldName AND LEFT.ruletype = RIGHT.ErrorType AND LEFT.MeasureType = 'CntRecs',
  	                                                       TRANSFORM(RECORDOF(LEFT),
  	                                                       SELF.dsExamples := LEFT.dsExamples & DATASET([{RIGHT.FieldContents, RIGHT.cntExamples, IF(LEFT.StatValue > 0, RIGHT.cntExamples/LEFT.StatValue * 100, 0)}], SALT311.Layout_Stats_Standard.Examples);
  	                                                       SELF := LEFT),
  	                                                       KEEP(10), LEFT OUTER, LOCAL, NOSORT));
  scrubsSummaryOverall_Standard_GeneralErrs := IF(doErrorOverall, SALT311.mod_StandardStatsTransforms.scrubsSummaryStatsGeneral(scrubsSummaryOverall,, myTimeStamp, 'all', 'all'));
 
  RETURN scrubsSummaryOverall_Standard_addErr & scrubsSummaryOverall_Standard_GeneralErrs;
END;
END;
