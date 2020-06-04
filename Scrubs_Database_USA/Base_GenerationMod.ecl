// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT311;
EXPORT Base_GenerationMod := MODULE(SALT311.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.11.8';
  EXPORT salt_MODULE := 'SALT311'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_Database_USA';
  EXPORT spc_NAMESCOPE := 'Base';
  EXPORT spc_PROCESS := '';
  EXPORT spc_PROCLAYOUTS := 'Process__Layouts';
  EXPORT spc_IDNAME := ''; // cluster id (input)
  EXPORT spc_IDFIELD := ''; // cluster id (output)
  EXPORT spc_RIDFIELD := ''; // record id
  EXPORT spc_CONFIG := 'Config';
  EXPORT spc_CONFIGPARAM := FALSE;
  EXPORT spc_SOURCEFIELD := '';
  EXPORT spc_FILEPREFIX := 'In_';
  EXPORT spc_FILENAME := 'Scrubs_Database_USA.Base_In_Database_USA';
  EXPORT spc_INGESTSTATUS := '';
  EXPORT spc_EXTERNAL_MAPPING := 'UniqueID:';
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,dt_first_seen,dt_last_seen,dt_vendor_first_reported,dt_vendor_last_reported,process_date,record_type,ind_frm_indicator,company_name,full_name,gender,primary_exec_flag,exec_type,phy_addr_state,phy_addr_zip,mail_addr_state,mail_addr_zip,mail_score,phone,email,email_available_indicator,url,business_status_code,franchise_flag,franchise_type,county_code,primary_sic,sic02,sic03,sic04,sic05,sic06,primarysic2,primarysic4,naics01,naics02,naics03,naics04,naics05,naics06,location_employee_code,location_sales_code,corporate_employee_code,year_established,female_owned,minority_owned_flag,home_based_indicator,small_business_indicator,import_export,manufacturing_location,public_indicator,non_profit_org,square_footage_code,creditcode,credit_capacity_code,advertising_expenses_code,technology_expenses_code,office_equip_expenses_code,rent_expenses_code,telecom_expenses_code,accounting_expenses_code,bus_insurance_expense_code,legal_expenses_code,utilities_expenses_code,number_of_pcs_code,nb_flag,domestic_foreign_owner_flag,db_cons_full_name,db_cons_email,db_cons_gender,db_cons_date_of_birth_year,db_cons_date_of_birth_month,db_cons_age,db_cons_ethnic_code,db_cons_religious_affil,db_cons_language_pref,db_cons_time_zone_code,db_cons_phone,db_cons_dnc,db_cons_scrubbed_phoneable,db_cons_children_present,db_cons_home_value_code,db_cons_donor_capacity_code,db_cons_home_owner_renter,db_cons_length_of_res_code,db_cons_dwelling_type,db_cons_recent_home_buyer,db_cons_income_code,db_cons_unsecuredcredcapcode,db_cons_networthhomevalcode,db_cons_discretincomecode,db_cons_marital_status,db_cons_new_parent,db_cons_child_near_hs_grad,db_cons_college_graduate,db_cons_intend_purchase_veh,db_cons_recent_divorce,db_cons_newlywed,db_cons_new_teen_driver,db_cons_home_year_built,db_cons_home_sqft_ranges,db_cons_poli_party_ind,db_cons_occupation_ind,db_cons_credit_card_user,db_cons_home_property_type,db_cons_education_hh,db_cons_education_ind,db_cons_other_pet_owner';
  EXPORT spc_HAS_TWOSTEP := FALSE;
  EXPORT spc_HAS_PARTITION := FALSE;
  EXPORT spc_HAS_FIELDTYPES := TRUE;
  EXPORT spc_HAS_INCREMENTAL := FALSE;
  EXPORT spc_HAS_ASOF := FALSE;
  EXPORT spc_HAS_NONCONTIGUOUS := FALSE;
  EXPORT spc_HAS_SUPERFILES := FALSE;
  EXPORT spc_HAS_CONSISTENT := FALSE;
  EXPORT spc_HAS_EXTERNAL := FALSE;
  EXPORT spc_HAS_PARENTS := FALSE;
  EXPORT spc_HAS_FORCE := FALSE;
  EXPORT spc_HAS_BLOCKLINK := FALSE;
 
  // The entire spec file
  EXPORT spcString :=
    'OPTIONS:-gh\n'
    + 'MODULE:Scrubs_Database_USA\n'
    + 'FILENAME:Scrubs_Database_USA.Base_In_Database_USA\n'
    + 'NAMESCOPE:Base\n'
    + '\n'
    + 'FIELDTYPE:invalid_pastdate:CUSTOM(Scrubs_Database_USA.Functions.fn_past_yyyymmdd > 0)\n'
    + 'FIELDTYPE:invalid_generaldate:CUSTOM(Scrubs_Database_USA.Functions.fn_general_date > 0)\n'
    + 'FIELDTYPE:invalid_record_type:ENUM(C|H)\n'
    + 'FIELDTYPE:invalid_ind_frm:ENUM(B|D|F|I|P| )\n'
    + 'FIELDTYPE:invalid_mandatory:LENGTHS(1..)\n'
    + 'FIELDTYPE:invalid_gender_code:ENUM(F|M|U| )\n'
    + 'FIELDTYPE:invalid_flag:ENUM(Y|1| ) \n'
    + 'FIELDTYPE:invalid_exec_type:ENUM(C|E)\n'
    + 'FIELDTYPE:invalid_st:CUSTOM(Scrubs_Database_USA.Functions.fn_verify_state > 0)\n'
    + 'FIELDTYPE:invalid_zip5:CUSTOM(Scrubs_Database_USA.Functions.fn_numeric_or_blank > 0)\n'
    + 'FIELDTYPE:invalid_mail_score:CUSTOM(Scrubs_Database_USA.Functions.fn_verify_mail_score > 0)\n'
    + 'FIELDTYPE:invalid_phone:CUSTOM(Scrubs_Database_USA.Functions.fn_verify_optional_phone > 0)\n'
    + 'FIELDTYPE:invalid_email:ALLOW( 0123456789AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz-.@_,;\'&!+)\n'
    + 'FIELDTYPE:invalid_email_indicator:ENUM( |1|0)\n'
    + 'FIELDTYPE:invalid_indicator:ENUM(1|0)\n'
    + 'FIELDTYPE:invalid_url:CUSTOM(Scrubs_Database_USA.Functions.fn_url > 0)\n'
    + 'FIELDTYPE:invalid_bus_status_code:ENUM(1|2|3| )\n'
    + 'FIELDTYPE:invalid_franchise:CUSTOM(Scrubs_Database_USA.Functions.fn_franchise > 0)\n'
    + 'FIELDTYPE:invalid_numeric:CUSTOM(Scrubs_Database_USA.Functions.fn_numeric > 0)\n'
    + 'FIELDTYPE:invalid_sic:CUSTOM(Scrubs_Database_USA.Functions.fn_sic > 0)\n'
    + 'FIELDTYPE:invalid_naics:CUSTOM(Scrubs_Database_USA.Functions.fn_naics > 0)\n'
    + 'FIELDTYPE:invalid_loc_employee_code:CUSTOM(Scrubs_Database_USA.Functions.fn_employee_code > 0)\n'
    + 'FIELDTYPE:invalid_loc_sales_code:CUSTOM(Scrubs_Database_USA.Functions.fn_loc_sales_code > 0)\n'
    + 'FIELDTYPE:invalid_corp_employee_code:CUSTOM(Scrubs_Database_USA.Functions.fn_employee_code > 0)\n'
    + 'FIELDTYPE:invalid_year:CUSTOM(Scrubs_Database_USA.Functions.fn_dt_yyyy > 0)\n'
    + 'FIELDTYPE:invalid_sq_ft:CUSTOM(Scrubs_Database_USA.Functions.fn_sq_ft > 0)\n'
    + 'FIELDTYPE:invalid_credit_code:CUSTOM(Scrubs_Database_USA.Functions.fn_credit_code > 0)\n'
    + 'FIELDTYPE:invalid_credit_capacity_code:CUSTOM(Scrubs_Database_USA.Functions.fn_credit_capacity_code > 0)\n'
    + 'FIELDTYPE:invalid_advertising_code:CUSTOM(Scrubs_Database_USA.Functions.fn_advertising_code > 0)\n'
    + 'FIELDTYPE:invalid_technology_code:CUSTOM(Scrubs_Database_USA.Functions.fn_technology_code > 0)\n'
    + 'FIELDTYPE:invalid_office_equip_code:CUSTOM(Scrubs_Database_USA.Functions.fn_office_equip_code > 0)\n'
    + 'FIELDTYPE:invalid_rent_code:CUSTOM(Scrubs_Database_USA.Functions.fn_rent_code > 0)\n'
    + 'FIELDTYPE:invalid_telecom_code:CUSTOM(Scrubs_Database_USA.Functions.fn_telecom_code > 0)\n'
    + 'FIELDTYPE:invalid_accounting_code:CUSTOM(Scrubs_Database_USA.Functions.fn_accounting_code > 0)\n'
    + 'FIELDTYPE:invalid_bus_insurance_code:CUSTOM(Scrubs_Database_USA.Functions.fn_bus_insurance_code > 0)\n'
    + 'FIELDTYPE:invalid_legal_code:CUSTOM(Scrubs_Database_USA.Functions.fn_legal_code > 0)\n'
    + 'FIELDTYPE:invalid_utilities_code:CUSTOM(Scrubs_Database_USA.Functions.fn_utilities_code > 0)\n'
    + 'FIELDTYPE:invalid_number_of_pcs_code:CUSTOM(Scrubs_Database_USA.Functions.fn_number_of_pcs_code > 0)\n'
    + 'FIELDTYPE:invalid_month:ENUM( |1|2|3|4|5|6|7|8|9|01|02|03|04|05|06|07|08|09|10|11|12)\n'
    + 'FIELDTYPE:invalid_numeric_blank:ALLOW(0123456789 )\n'
    + 'FIELDTYPE:invalid_ethnic_code:CUSTOM(Scrubs_Database_USA.Functions.fn_ethnic_code > 0)\n'
    + 'FIELDTYPE:invalid_religious_affil:CUSTOM(Scrubs_Database_USA.Functions.fn_religious_affil > 0)\n'
    + 'FIELDTYPE:invalid_language:CUSTOM(Scrubs_Database_USA.Functions.fn_language > 0)\n'
    + 'FIELDTYPE:invalid_time_zone:CUSTOM(Scrubs_Database_USA.Functions.fn_time_zone > 0)\n'
    + 'FIELDTYPE:invalid_children_present:ENUM(1|N| )\n'
    + 'FIELDTYPE:invalid_home_value:CUSTOM(Scrubs_Database_USA.Functions.fn_home_value > 0)\n'
    + 'FIELDTYPE:invalid_donor_code:CUSTOM(Scrubs_Database_USA.Functions.fn_donor_code > 0)\n'
    + 'FIELDTYPE:invalid_home_owner_renter:CUSTOM(Scrubs_Database_USA.Functions.fn_home_owner_renter > 0)\n'
    + 'FIELDTYPE:invalid_length_of_res:CUSTOM(Scrubs_Database_USA.Functions.fn_length_of_res > 0)\n'
    + 'FIELDTYPE:invalid_dwelling_type:CUSTOM(Scrubs_Database_USA.Functions.fn_dwelling_type > 0)\n'
    + 'FIELDTYPE:invalid_income_code:CUSTOM(Scrubs_Database_USA.Functions.fn_income_code > 0)\n'
    + 'FIELDTYPE:invalid_unsec_cap:CUSTOM(Scrubs_Database_USA.Functions.fn_unsec_cap > 0)\n'
    + 'FIELDTYPE:invalid_net_worth:CUSTOM(Scrubs_Database_USA.Functions.fn_net_worth > 0)\n'
    + 'FIELDTYPE:invalid_discret_income:CUSTOM(Scrubs_Database_USA.Functions.fn_discret_income > 0)\n'
    + 'FIELDTYPE:invalid_marital_status:CUSTOM(Scrubs_Database_USA.Functions.fn_marital_status > 0)\n'
    + 'FIELDTYPE:invalid_new_parent:CUSTOM(Scrubs_Database_USA.Functions.fn_new_parent > 0)\n'
    + 'FIELDTYPE:invalid_teen_driver:CUSTOM(Scrubs_Database_USA.Functions.fn_teen_driver > 0)\n'
    + 'FIELDTYPE:invalid_home_sqft_ranges:CUSTOM(Scrubs_Database_USA.Functions.fn_home_sqft_ranges > 0)\n'
    + 'FIELDTYPE:invalid_poli_party_ind:CUSTOM(Scrubs_Database_USA.Functions.fn_poli_party_ind > 0)\n'
    + 'FIELDTYPE:invalid_occupation_ind:CUSTOM(Scrubs_Database_USA.Functions.fn_occupation_ind > 0)\n'
    + 'FIELDTYPE:invalid_home_property:CUSTOM(Scrubs_Database_USA.Functions.fn_home_property > 0)\n'
    + 'FIELDTYPE:invalid_education:CUSTOM(Scrubs_Database_USA.Functions.fn_education > 0)\n'
    + '\n'
    + 'FIELD:dt_first_seen:TYPE(UNSIGNED4):LIKE(invalid_pastdate):0,0\n'
    + 'FIELD:dt_last_seen:TYPE(UNSIGNED4):LIKE(invalid_pastdate):0,0\n'
    + 'FIELD:dt_vendor_first_reported:TYPE(UNSIGNED4):LIKE(invalid_pastdate):0,0\n'
    + 'FIELD:dt_vendor_last_reported:TYPE(UNSIGNED4):LIKE(invalid_pastdate):0,0\n'
    + 'FIELD:process_date:TYPE(UNSIGNED4):LIKE(invalid_generaldate):0,0\n'
    + 'FIELD:record_type:TYPE(STRING1):LIKE(invalid_record_type):0,0\n'
    + 'FIELD:ind_frm_indicator:TYPE(STRING):LIKE(invalid_ind_frm):0,0\n'
    + 'FIELD:company_name:TYPE(STRING):LIKE(invalid_mandatory):0,0\n'
    + 'FIELD:full_name:TYPE(STRING):LIKE(invalid_mandatory):0,0\n'
    + 'FIELD:gender:TYPE(STRING):LIKE(invalid_gender_code):0,0\n'
    + 'FIELD:primary_exec_flag:TYPE(STRING):LIKE(invalid_flag):0,0\n'
    + 'FIELD:exec_type:TYPE(STRING):LIKE(invalid_exec_type):0,0\n'
    + 'FIELD:phy_addr_state:TYPE(STRING):LIKE(invalid_st):0,0\n'
    + 'FIELD:phy_addr_zip:TYPE(STRING):LIKE(invalid_zip5):0,0\n'
    + 'FIELD:mail_addr_state:TYPE(STRING):LIKE(invalid_st):0,0\n'
    + 'FIELD:mail_addr_zip:TYPE(STRING):LIKE(invalid_zip5):0,0\n'
    + 'FIELD:mail_score:TYPE(STRING):LIKE(invalid_mail_score):0,0\n'
    + 'FIELD:phone:TYPE(STRING):LIKE(invalid_phone):0,0\n'
    + 'FIELD:email:TYPE(STRING):LIKE(invalid_email):0,0\n'
    + 'FIELD:email_available_indicator:TYPE(STRING):LIKE(invalid_email_indicator):0,0\n'
    + 'FIELD:url:TYPE(STRING):LIKE(invalid_url):0,0\n'
    + 'FIELD:business_status_code:TYPE(STRING):LIKE(invalid_bus_status_code):0,0\n'
    + 'FIELD:franchise_flag:TYPE(STRING):LIKE(invalid_flag):0,0\n'
    + 'FIELD:franchise_type:TYPE(STRING):LIKE(invalid_franchise):0,0\n'
    + 'FIELD:county_code:TYPE(STRING):LIKE(invalid_numeric):0,0\n'
    + 'FIELD:primary_sic:TYPE(STRING):LIKE(invalid_sic):0,0\n'
    + 'FIELD:sic02:TYPE(STRING):LIKE(invalid_sic):0,0\n'
    + 'FIELD:sic03:TYPE(STRING):LIKE(invalid_sic):0,0\n'
    + 'FIELD:sic04:TYPE(STRING):LIKE(invalid_sic):0,0\n'
    + 'FIELD:sic05:TYPE(STRING):LIKE(invalid_sic):0,0\n'
    + 'FIELD:sic06:TYPE(STRING):LIKE(invalid_sic):0,0\n'
    + 'FIELD:primarysic2:TYPE(STRING):LIKE(invalid_sic):0,0\n'
    + 'FIELD:primarysic4:TYPE(STRING):LIKE(invalid_sic):0,0\n'
    + 'FIELD:naics01:TYPE(STRING):LIKE(invalid_naics):0,0\n'
    + 'FIELD:naics02:TYPE(STRING):LIKE(invalid_naics):0,0\n'
    + 'FIELD:naics03:TYPE(STRING):LIKE(invalid_naics):0,0\n'
    + 'FIELD:naics04:TYPE(STRING):LIKE(invalid_naics):0,0\n'
    + 'FIELD:naics05:TYPE(STRING):LIKE(invalid_naics):0,0\n'
    + 'FIELD:naics06:TYPE(STRING):LIKE(invalid_naics):0,0\n'
    + 'FIELD:location_employee_code:TYPE(STRING):LIKE(invalid_loc_employee_code):0,0\n'
    + 'FIELD:location_sales_code:TYPE(STRING):LIKE(invalid_loc_sales_code):0,0\n'
    + 'FIELD:corporate_employee_code:TYPE(STRING):LIKE(invalid_corp_employee_code):0,0\n'
    + 'FIELD:year_established:TYPE(STRING):LIKE(invalid_year):0,0\n'
    + 'FIELD:female_owned:TYPE(STRING):LIKE(invalid_flag):0,0\n'
    + 'FIELD:minority_owned_flag:TYPE(STRING):LIKE(invalid_flag):0,0\n'
    + 'FIELD:home_based_indicator:TYPE(STRING):LIKE(invalid_flag):0,0\n'
    + 'FIELD:small_business_indicator:TYPE(STRING):LIKE(invalid_flag):0,0\n'
    + 'FIELD:import_export:TYPE(STRING):LIKE(invalid_flag):0,0\n'
    + 'FIELD:manufacturing_location:TYPE(STRING):LIKE(invalid_flag):0,0\n'
    + 'FIELD:public_indicator:TYPE(STRING):LIKE(invalid_flag):0,0\n'
    + 'FIELD:non_profit_org:TYPE(STRING):LIKE(invalid_flag):0,0\n'
    + 'FIELD:square_footage_code:TYPE(STRING):LIKE(invalid_sq_ft):0,0\n'
    + 'FIELD:creditcode:TYPE(STRING):LIKE(invalid_credit_code):0,0\n'
    + 'FIELD:credit_capacity_code:TYPE(STRING):LIKE(invalid_credit_capacity_code):0,0\n'
    + 'FIELD:advertising_expenses_code:TYPE(STRING):LIKE(invalid_advertising_code):0,0\n'
    + 'FIELD:technology_expenses_code:TYPE(STRING):LIKE(invalid_technology_code):0,0\n'
    + 'FIELD:office_equip_expenses_code:TYPE(STRING):LIKE(invalid_office_equip_code):0,0  \n'
    + 'FIELD:rent_expenses_code:TYPE(STRING):LIKE(invalid_rent_code):0,0\n'
    + 'FIELD:telecom_expenses_code:TYPE(STRING):LIKE(invalid_telecom_code):0,0\n'
    + 'FIELD:accounting_expenses_code:TYPE(STRING):LIKE(invalid_accounting_code):0,0\n'
    + 'FIELD:bus_insurance_expense_code:TYPE(STRING):LIKE(invalid_bus_insurance_code):0,0\n'
    + 'FIELD:legal_expenses_code:TYPE(STRING):LIKE(invalid_legal_code):0,0\n'
    + 'FIELD:utilities_expenses_code:TYPE(STRING):LIKE(invalid_utilities_code):0,0\n'
    + 'FIELD:number_of_pcs_code:TYPE(STRING):LIKE(invalid_number_of_pcs_code):0,0\n'
    + 'FIELD:nb_flag:TYPE(STRING):LIKE(invalid_flag):0,0\n'
    + 'FIELD:domestic_foreign_owner_flag:TYPE(STRING):LIKE(invalid_flag):0,0\n'
    + 'FIELD:db_cons_full_name:TYPE(STRING):LIKE(invalid_mandatory):0,0\n'
    + 'FIELD:db_cons_email:TYPE(STRING):LIKE(invalid_email):0,0\n'
    + 'FIELD:db_cons_gender:TYPE(STRING):LIKE(invalid_gender_code):0,0\n'
    + 'FIELD:db_cons_date_of_birth_year:TYPE(STRING):LIKE(invalid_year):0,0\n'
    + 'FIELD:db_cons_date_of_birth_month:TYPE(STRING):LIKE(invalid_month):0,0\n'
    + 'FIELD:db_cons_age:TYPE(STRING):LIKE(invalid_numeric_blank):0,0\n'
    + 'FIELD:db_cons_ethnic_code:TYPE(STRING):LIKE(invalid_ethnic_code):0,0\n'
    + 'FIELD:db_cons_religious_affil:TYPE(STRING):LIKE(invalid_religious_affil):0,0\n'
    + 'FIELD:db_cons_language_pref:TYPE(STRING):LIKE(invalid_language):0,0\n'
    + 'FIELD:db_cons_time_zone_code:TYPE(STRING):LIKE(invalid_time_zone):0,0\n'
    + 'FIELD:db_cons_phone:TYPE(STRING):LIKE(invalid_phone):0,0\n'
    + 'FIELD:db_cons_dnc:TYPE(STRING):LIKE(invalid_flag):0,0\n'
    + 'FIELD:db_cons_scrubbed_phoneable:TYPE(STRING):LIKE(invalid_flag):0,0\n'
    + 'FIELD:db_cons_children_present:TYPE(STRING):LIKE(invalid_children_present):0,0\n'
    + 'FIELD:db_cons_home_value_code:TYPE(STRING):LIKE(invalid_home_value):0,0\n'
    + 'FIELD:db_cons_donor_capacity_code:TYPE(STRING):LIKE(invalid_donor_code):0,0\n'
    + 'FIELD:db_cons_home_owner_renter:TYPE(STRING):LIKE(invalid_home_owner_renter):0,0\n'
    + 'FIELD:db_cons_length_of_res_code:TYPE(STRING):LIKE(invalid_length_of_res):0,0\n'
    + 'FIELD:db_cons_dwelling_type:TYPE(STRING):LIKE(invalid_dwelling_type):0,0\n'
    + 'FIELD:db_cons_recent_home_buyer:TYPE(STRING):LIKE(invalid_flag):0,0\n'
    + 'FIELD:db_cons_income_code:TYPE(STRING):LIKE(invalid_income_code):0,0\n'
    + 'FIELD:db_cons_unsecuredcredcapcode:TYPE(STRING):LIKE(invalid_unsec_cap):0,0\n'
    + 'FIELD:db_cons_networthhomevalcode:TYPE(STRING):LIKE(invalid_net_worth):0,0\n'
    + 'FIELD:db_cons_discretincomecode:TYPE(STRING):LIKE(invalid_discret_income):0,0\n'
    + 'FIELD:db_cons_marital_status:TYPE(STRING):LIKE(invalid_marital_status):0,0\n'
    + 'FIELD:db_cons_new_parent:TYPE(STRING):LIKE(invalid_new_parent):0,0\n'
    + 'FIELD:db_cons_child_near_hs_grad:TYPE(STRING):LIKE(invalid_flag):0,0\n'
    + 'FIELD:db_cons_college_graduate:TYPE(STRING):LIKE(invalid_flag):0,0\n'
    + 'FIELD:db_cons_intend_purchase_veh:TYPE(STRING):LIKE(invalid_flag):0,0\n'
    + 'FIELD:db_cons_recent_divorce:TYPE(STRING):LIKE(invalid_flag):0,0\n'
    + 'FIELD:db_cons_newlywed:TYPE(STRING):LIKE(invalid_flag):0,0\n'
    + 'FIELD:db_cons_new_teen_driver:TYPE(STRING):LIKE(invalid_teen_driver):0,0\n'
    + 'FIELD:db_cons_home_year_built:TYPE(STRING):LIKE(invalid_year):0,0\n'
    + 'FIELD:db_cons_home_sqft_ranges:TYPE(STRING):LIKE(invalid_home_sqft_ranges):0,0\n'
    + 'FIELD:db_cons_poli_party_ind:TYPE(STRING):LIKE(invalid_poli_party_ind):0,0\n'
    + 'FIELD:db_cons_occupation_ind:TYPE(STRING):LIKE(invalid_occupation_ind):0,0\n'
    + 'FIELD:db_cons_credit_card_user:TYPE(STRING):LIKE(invalid_flag):0,0\n'
    + 'FIELD:db_cons_home_property_type:TYPE(STRING):LIKE(invalid_home_property):0,0\n'
    + 'FIELD:db_cons_education_hh:TYPE(STRING):LIKE(invalid_education):0,0\n'
    + 'FIELD:db_cons_education_ind:TYPE(STRING):LIKE(invalid_education):0,0\n'
    + 'FIELD:db_cons_other_pet_owner:TYPE(STRING):LIKE(invalid_flag):0,0'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;

