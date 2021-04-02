﻿Generated by SALT V3.11.4
Command line options: -MScrubs_Database_USA -eC:\Users\oneillbw\AppData\Local\Temp\TFRF0FC.tmp 
File being processed :-
OPTIONS:-gh
MODULE:Scrubs_Database_USA
FILENAME:Database_USA
NAMESCOPE:Base
 
FIELDTYPE:invalid_accounting_code:CUSTOM(Scrubs_Database_USA.Functions.fn_accounting_code > 0)
FIELDTYPE:invalid_accounting_expenses:CUSTOM(Scrubs_Database_USA.Functions.fn_verify_accounting_expenses_desc >0, accounting_expenses_code)
FIELDTYPE:invalid_advertising_code:CUSTOM(Scrubs_Database_USA.Functions.fn_advertising_code > 0)
FIELDTYPE:invalid_advertising_expenses:CUSTOM(Scrubs_Database_USA.Functions.fn_verify_advertising_expenses_desc >0, advertising_expenses_code)
FIELDTYPE:invalid_bus_insurance_code:CUSTOM(Scrubs_Database_USA.Functions.fn_bus_insurance_code > 0)
FIELDTYPE:invalid_business_insurance_expenses:CUSTOM(Scrubs_Database_USA.Functions.fn_verify_business_insurance_expenses_desc >0, bus_insurance_expense_code)
FIELDTYPE:invalid_bus_status_code:ENUM(1|2|3| )
FIELDTYPE:invalid_business_status:CUSTOM(Scrubs_Database_USA.Functions.fn_verify_business_status >0, business_status_code)
FIELDTYPE:invalid_children_present:ENUM(1|0| )
FIELDTYPE:invalid_city_population_code:CUSTOM(Scrubs_Database_USA.Functions.fn_city_population_code > 0)
FIELDTYPE:invalid_city_population_desc:CUSTOM(Scrubs_Database_USA.Functions.fn_verify_city_population_desc > 0,city_population_code)
FIELDTYPE:invalid_corp_employee_code:CUSTOM(Scrubs_Database_USA.Functions.fn_employee_code > 0)
FIELDTYPE:invalid_corporate_employee:CUSTOM(Scrubs_Database_USA.Functions.fn_verify_location_employee_desc >0, corporate_employee_code)
FIELDTYPE:invalid_credit:CUSTOM(Scrubs_Database_USA.Functions.fn_verify_credit_desc >0, creditcode)
FIELDTYPE:invalid_creditcode:CUSTOM(Scrubs_Database_USA.Functions.fn_credit_code > 0)
FIELDTYPE:invalid_credit_capacity:CUSTOM(Scrubs_Database_USA.Functions.fn_verify_credit_capacity_desc >0, credit_capacity_code)
FIELDTYPE:invalid_credit_capacity_code:CUSTOM(Scrubs_Database_USA.Functions.fn_credit_capacity_code > 0)
FIELDTYPE:invalid_discret_income:CUSTOM(Scrubs_Database_USA.Functions.fn_discret_income > 0)
FIELDTYPE:invalid_discretionary_income_expenses:CUSTOM(Scrubs_Database_USA.Functions.fn_verify_discretionary_income_desc >0, db_cons_discretincomecode)
FIELDTYPE:invalid_donor_code:CUSTOM(Scrubs_Database_USA.Functions.fn_donor_code > 0)
FIELDTYPE:invalid_donor_capacity_expenses:CUSTOM(Scrubs_Database_USA.Functions.fn_verify_donor_capacity_desc >0, db_cons_donor_capacity_code)
FIELDTYPE:invalid_dwelling_type:CUSTOM(Scrubs_Database_USA.Functions.fn_dwelling_type > 0)
FIELDTYPE:invalid_education:CUSTOM(Scrubs_Database_USA.Functions.fn_education > 0)
FIELDTYPE:invalid_email:ALLOW( 0123456789AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz-.@_,;'&!+)
FIELDTYPE:invalid_email_indicator:ENUM( |1|0)
FIELDTYPE:invalid_ethnic_code:CUSTOM(Scrubs_Database_USA.Functions.fn_ethnic_code > 0)
FIELDTYPE:invalid_employee_code:CUSTOM(Scrubs_Database_USA.Functions.fn_employee_code > 0)
FIELDTYPE:invalid_employee_desc:CUSTOM(Scrubs_Database_USA.Functions.fn_verify_location_employee_desc > 0,corporate_employee_code)
FIELDTYPE:invalid_exec_type:ENUM(C|E)
FIELDTYPE:invalid_executive_level:CUSTOM(Scrubs_Database_USA.Functions.fn_verify_executive_level > 0)
FIELDTYPE:invalid_flag:ENUM(Y|1| ) 
FIELDTYPE:invalid_franchise:CUSTOM(Scrubs_Database_USA.Functions.fn_franchise > 0)
FIELDTYPE:invalid_gender_code:ENUM(F|M|U)
FIELDTYPE:invalid_generaldate:CUSTOM(Scrubs_Database_USA.Functions.fn_general_date > 0)
FIELDTYPE:invalid_home_owner_renter:CUSTOM(Scrubs_Database_USA.Functions.fn_home_owner_renter > 0)
FIELDTYPE:invalid_home_property:CUSTOM(Scrubs_Database_USA.Functions.fn_home_property > 0)
FIELDTYPE:invalid_home_sqft_ranges:CUSTOM(Scrubs_Database_USA.Functions.fn_verify_home_square_footage_desc >0)
FIELDTYPE:invalid_home_value:CUSTOM(Scrubs_Database_USA.Functions.fn_home_value > 0)
FIELDTYPE:invalid_home_value_desc:CUSTOM(Scrubs_Database_USA.Functions.fn_verify_home_value_desc >0, db_cons_home_value_code)
FIELDTYPE:invalid_income_code:CUSTOM(Scrubs_Database_USA.Functions.fn_income_code > 0)
FIELDTYPE:invalid_income_expenses:CUSTOM(Scrubs_Database_USA.Functions.fn_verify_income_desc >0, db_cons_income_code)
FIELDTYPE:invalid_ind_frm:ENUM(B|D|F|I|P| )
FIELDTYPE:invalid_indicator:ENUM(1|0)
FIELDTYPE:invalid_language:CUSTOM(Scrubs_Database_USA.Functions.fn_language > 0)
FIELDTYPE:invalid_legal_code:CUSTOM(Scrubs_Database_USA.Functions.fn_legal_code > 0)
FIELDTYPE:invalid_legal_expenses:CUSTOM(Scrubs_Database_USA.Functions.fn_verify_legal_expenses_desc >0, legal_expenses_code)
FIELDTYPE:invalid_length_of_res:CUSTOM(Scrubs_Database_USA.Functions.fn_length_of_res > 0)
FIELDTYPE:invalid_length_of_res_desc:CUSTOM(Scrubs_Database_USA.Functions.fn_verify_length_of_residence_desc >0, db_cons_length_of_res_code)
FIELDTYPE:invalid_loc_employee_code:CUSTOM(Scrubs_Database_USA.Functions.fn_employee_code > 0)
FIELDTYPE:invalid_location_employee:CUSTOM(Scrubs_Database_USA.Functions.fn_verify_location_employee_desc >0, location_employee_code)
FIELDTYPE:invalid_loc_sales_code:CUSTOM(Scrubs_Database_USA.Functions.fn_loc_sales_code > 0)
FIELDTYPE:invalid_location_sales:CUSTOM(Scrubs_Database_USA.Functions.fn_verify_location_sales_desc >0, location_sales_code)
FIELDTYPE:invalid_mail_score:CUSTOM(Scrubs_Database_USA.Functions.fn_verify_mail_score > 0)
FIELDTYPE:invalid_mandatory:LENGTHS(1..)
FIELDTYPE:invalid_marital_status:CUSTOM(Scrubs_Database_USA.Functions.fn_marital_status > 0)
FIELDTYPE:invalid_minority_type:CUSTOM(Scrubs_Database_USA.Functions.fn_verify_minority_type >0)
FIELDTYPE:invalid_month:ENUM( |1|2|3|4|5|6|7|8|9|01|02|03|04|05|06|07|08|09|10|11|12)
FIELDTYPE:invalid_naics:CUSTOM(Scrubs.fn_valid_NAICSCode > 0)
FIELDTYPE:invalid_net_worth:CUSTOM(Scrubs_Database_USA.Functions.fn_net_worth > 0)
FIELDTYPE:invalid_networth_expenses:CUSTOM(Scrubs_Database_USA.Functions.fn_verify_networth_desc >0, db_cons_networthhomevalcode)
FIELDTYPE:invalid_new_parent:CUSTOM(Scrubs_Database_USA.Functions.fn_new_parent > 0)
FIELDTYPE:invalid_number_of_pcs_code:CUSTOM(Scrubs_Database_USA.Functions.fn_number_of_pcs_code > 0)
FIELDTYPE:invalid_number_of_pcs:CUSTOM(Scrubs_Database_USA.Functions.fn_verify_number_of_pcs >0, number_of_pcs_code)
FIELDTYPE:invalid_numeric:CUSTOM(Scrubs_Database_USA.Functions.fn_numeric > 0)
FIELDTYPE:invalid_numeric_blank:ALLOW(0123456789 )
FIELDTYPE:invalid_office_equipment_expenses:CUSTOM(Scrubs_Database_USA.Functions.fn_office_equip_code >0)
FIELDTYPE:invalid_office_equipment_expenses_desc:CUSTOM(Scrubs_Database_USA.Functions.fn_verify_office_equipment_expenses_desc >0, office_equip_expenses_code)
FIELDTYPE:invalid_occupation_ind:CUSTOM(Scrubs_Database_USA.Functions.fn_occupation_ind > 0)
FIELDTYPE:invalid_office_equip_code:CUSTOM(Scrubs_Database_USA.Functions.fn_office_equip_code > 0)
FIELDTYPE:invalid_pastdate:CUSTOM(Scrubs_Database_USA.Functions.fn_past_yyyymmdd > 0)
FIELDTYPE:invalid_phone:CUSTOM(Scrubs_Database_USA.Functions.fn_verify_optional_phone > 0)
FIELDTYPE:invalid_poli_party_ind:CUSTOM(Scrubs_Database_USA.Functions.fn_poli_party_ind > 0)
FIELDTYPE:invalid_record_type:ENUM(C|H)
FIELDTYPE:invalid_rent_code:CUSTOM(Scrubs_Database_USA.Functions.fn_rent_code > 0)
FIELDTYPE:invalid_rent_expenses:CUSTOM(Scrubs_Database_USA.Functions.fn_verify_rent_expenses_desc >0, rent_expenses_code)
FIELDTYPE:invalid_religious_affil:CUSTOM(Scrubs_Database_USA.Functions.fn_religious_affil > 0)
FIELDTYPE:invalid_sic:CUSTOM(Scrubs_Database_USA.Functions.fn_sic > 0)
FIELDTYPE:invalid_sq_ft:CUSTOM(Scrubs_Database_USA.Functions.fn_sq_ft > 0)
FIELDTYPE:invalid_square_footage:CUSTOM(Scrubs_Database_USA.Functions.fn_verify_square_footage_desc >0, square_footage_code)
FIELDTYPE:invalid_st:CUSTOM(Scrubs_Database_USA.Functions.fn_verify_state > 0)
FIELDTYPE:invalid_standardized_title:CUSTOM(Scrubs_Database_USA.Functions.fn_verify_standardized_title > 0,executive_title_rank)
FIELDTYPE:invalid_technology_code:CUSTOM(Scrubs_Database_USA.Functions.fn_technology_code > 0)
FIELDTYPE:invalid_technology_expenses:CUSTOM(Scrubs_Database_USA.Functions.fn_verify_technology_expenses_desc >0, technology_expenses_code)
FIELDTYPE:invalid_teen_driver:CUSTOM(Scrubs_Database_USA.Functions.fn_teen_driver > 0)
FIELDTYPE:invalid_telecom_code:CUSTOM(Scrubs_Database_USA.Functions.fn_telecom_code > 0)
FIELDTYPE:invalid_telecom_expenses:CUSTOM(Scrubs_Database_USA.Functions.fn_verify_telecom_expenses_desc >0, telecom_expenses_code)
FIELDTYPE:invalid_time_zone:CUSTOM(Scrubs_Database_USA.Functions.fn_time_zone > 0)
FIELDTYPE:invalid_time_zone_desc:CUSTOM(Scrubs_Database_USA.Functions.fn_verify_time_zone_desc > 0)
FIELDTYPE:invalid_url:CUSTOM(Scrubs_Database_USA.Functions.fn_url > 0)
FIELDTYPE:invalid_unsec_cap:CUSTOM(Scrubs_Database_USA.Functions.fn_unsec_cap > 0)
FIELDTYPE:invalid_unsecured_credit_capacity_expenses:CUSTOM(Scrubs_Database_USA.Functions.fn_verify_unsecured_credit_capacity_desc >0, db_cons_unsecuredcredcapcode)
FIELDTYPE:invalid_utilities_code:CUSTOM(Scrubs_Database_USA.Functions.fn_utilities_code > 0)
FIELDTYPE:invalid_utilities_expenses:CUSTOM(Scrubs_Database_USA.Functions.fn_verify_utilities_expenses_desc >0, utilities_expenses_code)
FIELDTYPE:invalid_year:CUSTOM(Scrubs_Database_USA.Functions.fn_dt_yyyy > 0)
FIELDTYPE:invalid_years_in_business:CUSTOM(Scrubs_Database_USA.Functions.fn_verify_years_in_business_range >0)
FIELDTYPE:invalid_zip5:CUSTOM(Scrubs_Database_USA.Functions.fn_numeric_or_blank > 0)
 
FIELD:dt_first_seen:TYPE(UNSIGNED4):LIKE(invalid_pastdate):0,0
FIELD:dt_last_seen:TYPE(UNSIGNED4):LIKE(invalid_pastdate):0,0
FIELD:dt_vendor_first_reported:TYPE(UNSIGNED4):LIKE(invalid_pastdate):0,0
FIELD:dt_vendor_last_reported:TYPE(UNSIGNED4):LIKE(invalid_pastdate):0,0
FIELD:process_date:TYPE(UNSIGNED4):LIKE(invalid_generaldate):0,0
FIELD:record_type:TYPE(STRING1):LIKE(invalid_record_type):0,0
 
FIELD:accounting_expenses_code:TYPE(STRING):LIKE(invalid_accounting_code):0,0
FIELD:advertising_expenses_code:TYPE(STRING):LIKE(invalid_advertising_code):0,0
FIELD:bus_insurance_expense_code:TYPE(STRING):LIKE(invalid_bus_insurance_code):0,0
FIELD:business_status_code:TYPE(STRING):LIKE(invalid_bus_status_code):0,0
FIELD:business_status_desc:TYPE(STRING):LIKE(invalid_business_status):0,0
FIELD:city_population_code:TYPE(STRING):LIKE(invalid_city_population_code):0,0
FIELD:city_population_descr:TYPE(STRING):LIKE(invalid_city_population_desc):0,0
FIELD:company_name:TYPE(STRING):LIKE(invalid_mandatory):0,0
FIELD:corporate_employee_code:TYPE(STRING):LIKE(invalid_employee_code):0,0
FIELD:corporate_employee_desc:TYPE(STRING):LIKE(invalid_employee_desc):0,0
FIELD:county_code:TYPE(STRING):LIKE(invalid_numeric):0,0
FIELD:creditcode:TYPE(STRING):LIKE(invalid_creditcode):0,0
FIELD:credit_desc:TYPE(STRING):LIKE(invalid_credit):0,0
FIELD:credit_capacity_code:TYPE(STRING):LIKE(invalid_credit_capacity_code):0,0
FIELD:credit_capacity_desc:TYPE(STRING):LIKE(invalid_credit_capacity):0,0
 
FIELD:db_cons_age:TYPE(STRING):LIKE(invalid_numeric_blank):0,0
FIELD:db_cons_child_near_hs_grad:TYPE(STRING):LIKE(invalid_flag):0,0
FIELD:db_cons_children_present:TYPE(STRING):LIKE(invalid_children_present):0,0
FIELD:db_cons_college_graduate:TYPE(STRING):LIKE(invalid_flag):0,0
FIELD:db_cons_credit_card_user:TYPE(STRING):LIKE(invalid_flag):0,0
FIELD:db_cons_date_of_birth_month:TYPE(STRING):LIKE(invalid_month):0,0
FIELD:db_cons_date_of_birth_year:TYPE(STRING):LIKE(invalid_year):0,0
FIELD:db_cons_discretincomecode:TYPE(STRING):LIKE(invalid_discret_income):0,0
FIELD:db_cons_discretincomedesc:TYPE(STRING):LIKE(invalid_discretionary_income_expenses):0,0
FIELD:db_cons_dnc:TYPE(STRING):LIKE(invalid_flag):0,0
FIELD:db_cons_donor_capacity_code:TYPE(STRING):LIKE(invalid_donor_code):0,0
FIELD:db_cons_donor_capacity_desc:TYPE(STRING):LIKE(invalid_donor_capacity_expenses):0,0
FIELD:db_cons_dwelling_type:TYPE(STRING):LIKE(invalid_dwelling_type):0,0
FIELD:db_cons_education_hh:TYPE(STRING):LIKE(invalid_education):0,0
FIELD:db_cons_education_ind:TYPE(STRING):LIKE(invalid_education):0,0
FIELD:db_cons_email:TYPE(STRING):LIKE(invalid_email):0,0
FIELD:db_cons_ethnic_code:TYPE(STRING):LIKE(invalid_ethnic_code):0,0
FIELD:db_cons_full_name:TYPE(STRING):LIKE(invalid_mandatory):0,0
FIELD:db_cons_gender:TYPE(STRING):LIKE(invalid_gender_code):0,0
FIELD:db_cons_home_owner_renter:TYPE(STRING):LIKE(invalid_home_owner_renter):0,0
FIELD:db_cons_home_property_type:TYPE(STRING):LIKE(invalid_home_property):0,0
FIELD:db_cons_home_sqft_ranges:TYPE(STRING):LIKE(invalid_home_sqft_ranges):0,0
FIELD:db_cons_home_value_code:TYPE(STRING):LIKE(invalid_home_value):0,0
FIELD:db_cons_home_value_desc:TYPE(STRING):LIKE(invalid_home_value_desc):0,0
FIELD:db_cons_home_year_built:TYPE(STRING):LIKE(invalid_year):0,0
FIELD:db_cons_income_code:TYPE(STRING):LIKE(invalid_income_code):0,0
FIELD:db_cons_income_desc:TYPE(STRING):LIKE(invalid_income_expenses):0,0
FIELD:db_cons_intend_purchase_veh:TYPE(STRING):LIKE(invalid_flag):0,0
FIELD:db_cons_language_pref:TYPE(STRING):LIKE(invalid_language):0,0
FIELD:db_cons_length_of_res_code:TYPE(STRING):LIKE(invalid_length_of_res):0,0
FIELD:db_cons_length_of_res_desc:TYPE(STRING):LIKE(invalid_length_of_res_desc):0,0
FIELD:db_cons_marital_status:TYPE(STRING):LIKE(invalid_marital_status):0,0
FIELD:db_cons_networthhomevalcode:TYPE(STRING):LIKE(invalid_net_worth):0,0
FIELD:db_cons_net_worth_desc:TYPE(STRING):LIKE(invalid_networth_expenses):0,0
FIELD:db_cons_new_parent:TYPE(STRING):LIKE(invalid_new_parent):0,0
FIELD:db_cons_new_teen_driver:TYPE(STRING):LIKE(invalid_teen_driver):0,0
FIELD:db_cons_newlywed:TYPE(STRING):LIKE(invalid_flag):0,0
FIELD:db_cons_occupation_ind:TYPE(STRING):LIKE(invalid_occupation_ind):0,0
FIELD:db_cons_other_pet_owner:TYPE(STRING):LIKE(invalid_flag):0,0
FIELD:db_cons_phone:TYPE(STRING):LIKE(invalid_phone):0,0
FIELD:db_cons_poli_party_ind:TYPE(STRING):LIKE(invalid_poli_party_ind):0,0
FIELD:db_cons_recent_divorce:TYPE(STRING):LIKE(invalid_flag):0,0
FIELD:db_cons_recent_home_buyer:TYPE(STRING):LIKE(invalid_flag):0,0
FIELD:db_cons_religious_affil:TYPE(STRING):LIKE(invalid_religious_affil):0,0
FIELD:db_cons_scrubbed_phoneable:TYPE(STRING):LIKE(invalid_flag):0,0
FIELD:db_cons_time_zone_code:TYPE(STRING):LIKE(invalid_time_zone):0,0
FIELD:db_cons_time_zone_desc:TYPE(STRING):LIKE(invalid_time_zone_desc):0,0
FIELD:db_cons_unsecuredcredcapcode:TYPE(STRING):LIKE(invalid_unsec_cap):0,0
FIELD:db_cons_unsecuredcredcapdesc:TYPE(STRING):LIKE(invalid_unsecured_credit_capacity_expenses):0,0
FIELD:domestic_foreign_owner_flag:TYPE(STRING):LIKE(invalid_flag):0,0
FIELD:email:TYPE(STRING):LIKE(invalid_email):0,0
FIELD:email_available_indicator:TYPE(STRING):LIKE(invalid_email_indicator):0,0
FIELD:exec_type:TYPE(STRING):LIKE(invalid_exec_type):0,0
FIELD:executive_level:TYPE(STRING):LIKE(invalid_executive_level):0,0
FIELD:executive_title_rank:TYPE(STRING):LIKE(invalid_numeric_blank):0,0
 
FIELD:expense_accounting_desc:TYPE(STRING):LIKE(invalid_accounting_expenses):0,0
FIELD:expense_advertising_desc:TYPE(STRING):LIKE(invalid_advertising_expenses):0,0
FIELD:expense_bus_insurance_desc:TYPE(STRING):LIKE(invalid_business_insurance_expenses):0,0
FIELD:expense_legal_desc:TYPE(STRING):LIKE(invalid_legal_expenses):0,0
FIELD:expense_office_equip_desc:TYPE(STRING):LIKE(invalid_office_equipment_expenses_desc):0,0
FIELD:expense_rent_desc:TYPE(STRING):LIKE(invalid_rent_expenses):0,0
FIELD:expense_technology_desc:TYPE(STRING):LIKE(invalid_technology_expenses):0,0
FIELD:expense_telecom_desc:TYPE(STRING):LIKE(invalid_telecom_expenses):0,0
FIELD:expense_utilities_desc:TYPE(STRING):LIKE(invalid_utilities_expenses):0,0
 
FIELD:female_owned:TYPE(STRING):LIKE(invalid_flag):0,0
FIELD:franchise_flag:TYPE(STRING):LIKE(invalid_flag):0,0
FIELD:franchise_type:TYPE(STRING):LIKE(invalid_franchise):0,0
FIELD:full_name:TYPE(STRING):LIKE(invalid_mandatory):0,0
FIELD:gender:TYPE(STRING):LIKE(invalid_gender_code):0,0
FIELD:home_based_indicator:TYPE(STRING):LIKE(invalid_flag):0,0
FIELD:import_export:TYPE(STRING):LIKE(invalid_flag):0,0
FIELD:ind_frm_indicator:TYPE(STRING):LIKE(invalid_ind_frm):0,0 
FIELD:legal_expenses_code:TYPE(STRING):LIKE(invalid_legal_code):0,0
FIELD:location_employee_code:TYPE(STRING):LIKE(invalid_loc_employee_code):0,0
FIELD:location_employee_desc:TYPE(STRING):LIKE(invalid_location_employee):0,0
FIELD:location_sales_code:TYPE(STRING):LIKE(invalid_loc_sales_code):0,0
FIELD:location_sales_desc:TYPE(STRING):LIKE(invalid_location_sales):0,0
FIELD:mail_addr_state:TYPE(STRING):LIKE(invalid_st):0,0
FIELD:mail_addr_zip:TYPE(STRING):LIKE(invalid_zip5):0,0
FIELD:mail_score:TYPE(STRING):LIKE(invalid_mail_score):0,0
FIELD:manufacturing_location:TYPE(STRING):LIKE(invalid_flag):0,0
FIELD:minority_owned_flag:TYPE(STRING):LIKE(invalid_flag):0,0
FIELD:minority_type:TYPE(STRING):LIKE(invalid_minority_type):0,0
FIELD:naics01:TYPE(STRING):LIKE(invalid_naics):0,0
FIELD:naics02:TYPE(STRING):LIKE(invalid_naics):0,0
FIELD:naics03:TYPE(STRING):LIKE(invalid_naics):0,0
FIELD:naics04:TYPE(STRING):LIKE(invalid_naics):0,0
FIELD:naics05:TYPE(STRING):LIKE(invalid_naics):0,0
FIELD:naics06:TYPE(STRING):LIKE(invalid_naics):0,0
FIELD:nb_flag:TYPE(STRING):LIKE(invalid_flag):0,0
FIELD:non_profit_org:TYPE(STRING):LIKE(invalid_flag):0,0
FIELD:number_of_pcs_code:TYPE(STRING):LIKE(invalid_number_of_pcs_code):0,0
FIELD:number_of_pcs_desc:TYPE(STRING):LIKE(invalid_number_of_pcs):0,0
FIELD:office_equip_expenses_code:TYPE(STRING):LIKE(invalid_office_equipment_expenses):0,0
FIELD:phone:TYPE(STRING):LIKE(invalid_phone):0,0
FIELD:phy_addr_state:TYPE(STRING):LIKE(invalid_st):0,0
FIELD:phy_addr_zip:TYPE(STRING):LIKE(invalid_zip5):0,0
FIELD:primary_exec_flag:TYPE(STRING):LIKE(invalid_flag):0,0
FIELD:primary_sic:TYPE(STRING):LIKE(invalid_sic):0,0
FIELD:primarysic2:TYPE(STRING):LIKE(invalid_sic):0,0
FIELD:primarysic4:TYPE(STRING):LIKE(invalid_sic):0,0
FIELD:public_indicator:TYPE(STRING):LIKE(invalid_flag):0,0
FIELD:rent_expenses_code:TYPE(STRING):LIKE(invalid_rent_code):0,0
FIELD:sic02:TYPE(STRING):LIKE(invalid_sic):0,0
FIELD:sic03:TYPE(STRING):LIKE(invalid_sic):0,0
FIELD:sic04:TYPE(STRING):LIKE(invalid_sic):0,0
FIELD:sic05:TYPE(STRING):LIKE(invalid_sic):0,0
FIELD:sic06:TYPE(STRING):LIKE(invalid_sic):0,0
FIELD:small_business_indicator:TYPE(STRING):LIKE(invalid_flag):0,0
FIELD:square_footage_code:TYPE(STRING):LIKE(invalid_sq_ft):0,0
FIELD:square_footage_desc:TYPE(STRING):LIKE(invalid_square_footage):0,0
FIELD:standardized_title:TYPE(STRING):LIKE(invalid_standardized_title):0,0
FIELD:technology_expenses_code:TYPE(STRING):LIKE(invalid_technology_code):0,0
FIELD:telecom_expenses_code:TYPE(STRING):LIKE(invalid_telecom_code):0,0
FIELD:url:TYPE(STRING):LIKE(invalid_url):0,0
FIELD:utilities_expenses_code:TYPE(STRING):LIKE(invalid_utilities_code):0,0
FIELD:year_established:TYPE(STRING):LIKE(invalid_year):0,0
FIELD:years_in_business_range:TYPE(STRING):LIKE(invalid_years_in_business):0,0
 
Total available specificity:0
Search Threshold set at -4
Use of PERSISTs in code set at:3
 
__Glossary__
Edit Distance: An edit distance of (say) one implies that one string can be converted into another by doing one of
  - Changing one character
  - Deleting one character
  - Transposing two characters
 
Forcing Criteria: In addition to the general 'best match' logic it is possible to insist that
one particular field must match to some degree or the whole record is considered a bad match.
The criterial applied to that one field is the forcing criteria.
 
Cascade: Best Type rules are applied in such a way that the rules are applied one by one UNTIL the first rule succeeds; subsequent rules are then skipped.
 
__General Notes__
How is it decided how much to subtract for a bad match?
SALT computes for each field the percentage likelihood that a valid cluster will have two or more values for a given field
this value (called the switch value in the SALT literature) is then used to produce the subtraction value from the match value.
The value in this document is the one typed into the SPC file; the code will use a value computed at run-time.
 
