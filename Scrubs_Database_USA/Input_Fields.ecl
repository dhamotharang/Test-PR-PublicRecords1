IMPORT SALT311;
IMPORT Scrubs_Database_USA,Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT Input_Fields := MODULE
 
EXPORT NumFields := 133;
 
// Processing for each FieldType
EXPORT SALT311.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_accounting_code','invalid_accounting_expenses','invalid_advertising_code','invalid_advertising_expenses','invalid_bus_insurance_code','invalid_business_insurance_expenses','invalid_bus_status_code','invalid_business_status','invalid_children_present','invalid_city_population_code','invalid_city_population_desc','invalid_corp_employee_code','invalid_corporate_employee','invalid_credit','invalid_creditcode','invalid_credit_capacity','invalid_credit_capacity_code','invalid_discret_income','invalid_discretionary_income_expenses','invalid_donor_code','invalid_donor_capacity_expenses','invalid_dwelling_type','invalid_education','invalid_email','invalid_email_indicator','invalid_ethnic_code','invalid_employee_code','invalid_employee_desc','invalid_exec_type','invalid_executive_level','invalid_flag','invalid_franchise','invalid_gender_code','invalid_generaldate','invalid_home_owner_renter','invalid_home_property','invalid_home_sqft_ranges','invalid_home_value','invalid_home_value_desc','invalid_income_code','invalid_income_expenses','invalid_ind_frm','invalid_indicator','invalid_language','invalid_legal_code','invalid_legal_expenses','invalid_length_of_res','invalid_length_of_res_desc','invalid_loc_employee_code','invalid_location_employee','invalid_loc_sales_code','invalid_location_sales','invalid_mail_score','invalid_mandatory','invalid_marital_status','invalid_minority_type','invalid_month','invalid_naics','invalid_net_worth','invalid_networth_expenses','invalid_new_parent','invalid_number_of_pcs_code','invalid_number_of_pcs','invalid_numeric','invalid_numeric_blank','invalid_office_equipment_expenses','invalid_office_equipment_expenses_desc','invalid_occupation_ind','invalid_office_equip_code','invalid_pastdate','invalid_phone','invalid_poli_party_ind','invalid_record_type','invalid_rent_code','invalid_rent_expenses','invalid_religious_affil','invalid_sic','invalid_sq_ft','invalid_square_footage','invalid_st','invalid_standardized_title','invalid_technology_code','invalid_technology_expenses','invalid_teen_driver','invalid_telecom_code','invalid_telecom_expenses','invalid_time_zone','invalid_time_zone_desc','invalid_url','invalid_unsec_cap','invalid_unsecured_credit_capacity_expenses','invalid_utilities_code','invalid_utilities_expenses','invalid_year','invalid_years_in_business','invalid_zip5');
EXPORT FieldTypeNum(SALT311.StrType fn) := CASE(fn,'invalid_accounting_code' => 1,'invalid_accounting_expenses' => 2,'invalid_advertising_code' => 3,'invalid_advertising_expenses' => 4,'invalid_bus_insurance_code' => 5,'invalid_business_insurance_expenses' => 6,'invalid_bus_status_code' => 7,'invalid_business_status' => 8,'invalid_children_present' => 9,'invalid_city_population_code' => 10,'invalid_city_population_desc' => 11,'invalid_corp_employee_code' => 12,'invalid_corporate_employee' => 13,'invalid_credit' => 14,'invalid_creditcode' => 15,'invalid_credit_capacity' => 16,'invalid_credit_capacity_code' => 17,'invalid_discret_income' => 18,'invalid_discretionary_income_expenses' => 19,'invalid_donor_code' => 20,'invalid_donor_capacity_expenses' => 21,'invalid_dwelling_type' => 22,'invalid_education' => 23,'invalid_email' => 24,'invalid_email_indicator' => 25,'invalid_ethnic_code' => 26,'invalid_employee_code' => 27,'invalid_employee_desc' => 28,'invalid_exec_type' => 29,'invalid_executive_level' => 30,'invalid_flag' => 31,'invalid_franchise' => 32,'invalid_gender_code' => 33,'invalid_generaldate' => 34,'invalid_home_owner_renter' => 35,'invalid_home_property' => 36,'invalid_home_sqft_ranges' => 37,'invalid_home_value' => 38,'invalid_home_value_desc' => 39,'invalid_income_code' => 40,'invalid_income_expenses' => 41,'invalid_ind_frm' => 42,'invalid_indicator' => 43,'invalid_language' => 44,'invalid_legal_code' => 45,'invalid_legal_expenses' => 46,'invalid_length_of_res' => 47,'invalid_length_of_res_desc' => 48,'invalid_loc_employee_code' => 49,'invalid_location_employee' => 50,'invalid_loc_sales_code' => 51,'invalid_location_sales' => 52,'invalid_mail_score' => 53,'invalid_mandatory' => 54,'invalid_marital_status' => 55,'invalid_minority_type' => 56,'invalid_month' => 57,'invalid_naics' => 58,'invalid_net_worth' => 59,'invalid_networth_expenses' => 60,'invalid_new_parent' => 61,'invalid_number_of_pcs_code' => 62,'invalid_number_of_pcs' => 63,'invalid_numeric' => 64,'invalid_numeric_blank' => 65,'invalid_office_equipment_expenses' => 66,'invalid_office_equipment_expenses_desc' => 67,'invalid_occupation_ind' => 68,'invalid_office_equip_code' => 69,'invalid_pastdate' => 70,'invalid_phone' => 71,'invalid_poli_party_ind' => 72,'invalid_record_type' => 73,'invalid_rent_code' => 74,'invalid_rent_expenses' => 75,'invalid_religious_affil' => 76,'invalid_sic' => 77,'invalid_sq_ft' => 78,'invalid_square_footage' => 79,'invalid_st' => 80,'invalid_standardized_title' => 81,'invalid_technology_code' => 82,'invalid_technology_expenses' => 83,'invalid_teen_driver' => 84,'invalid_telecom_code' => 85,'invalid_telecom_expenses' => 86,'invalid_time_zone' => 87,'invalid_time_zone_desc' => 88,'invalid_url' => 89,'invalid_unsec_cap' => 90,'invalid_unsecured_credit_capacity_expenses' => 91,'invalid_utilities_code' => 92,'invalid_utilities_expenses' => 93,'invalid_year' => 94,'invalid_years_in_business' => 95,'invalid_zip5' => 96,0);
 
EXPORT MakeFT_invalid_accounting_code(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_accounting_code(SALT311.StrType s) := WHICH(~Scrubs_Database_USA.Functions.fn_accounting_code(s)>0);
EXPORT InValidMessageFT_invalid_accounting_code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Database_USA.Functions.fn_accounting_code'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_accounting_expenses(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_accounting_expenses(SALT311.StrType s,SALT311.StrType accounting_expenses_code) := WHICH(~Scrubs_Database_USA.Functions.fn_verify_accounting_expenses_desc(s,accounting_expenses_code)>0);
EXPORT InValidMessageFT_invalid_accounting_expenses(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Database_USA.Functions.fn_verify_accounting_expenses_desc'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_advertising_code(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_advertising_code(SALT311.StrType s) := WHICH(~Scrubs_Database_USA.Functions.fn_advertising_code(s)>0);
EXPORT InValidMessageFT_invalid_advertising_code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Database_USA.Functions.fn_advertising_code'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_advertising_expenses(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_advertising_expenses(SALT311.StrType s,SALT311.StrType advertising_expenses_code) := WHICH(~Scrubs_Database_USA.Functions.fn_verify_advertising_expenses_desc(s,advertising_expenses_code)>0);
EXPORT InValidMessageFT_invalid_advertising_expenses(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Database_USA.Functions.fn_verify_advertising_expenses_desc'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_bus_insurance_code(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_bus_insurance_code(SALT311.StrType s) := WHICH(~Scrubs_Database_USA.Functions.fn_bus_insurance_code(s)>0);
EXPORT InValidMessageFT_invalid_bus_insurance_code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Database_USA.Functions.fn_bus_insurance_code'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_business_insurance_expenses(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_business_insurance_expenses(SALT311.StrType s,SALT311.StrType bus_insurance_expense_code) := WHICH(~Scrubs_Database_USA.Functions.fn_verify_business_insurance_expenses_desc(s,bus_insurance_expense_code)>0);
EXPORT InValidMessageFT_invalid_business_insurance_expenses(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Database_USA.Functions.fn_verify_business_insurance_expenses_desc'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_bus_status_code(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_bus_status_code(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['1','2','3',' ']);
EXPORT InValidMessageFT_invalid_bus_status_code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('1|2|3| '),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_business_status(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_business_status(SALT311.StrType s,SALT311.StrType business_status_code) := WHICH(~Scrubs_Database_USA.Functions.fn_verify_business_status(s,business_status_code)>0);
EXPORT InValidMessageFT_invalid_business_status(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Database_USA.Functions.fn_verify_business_status'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_children_present(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_children_present(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['1','0',' ']);
EXPORT InValidMessageFT_invalid_children_present(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('1|0| '),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_city_population_code(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_city_population_code(SALT311.StrType s) := WHICH(~Scrubs_Database_USA.Functions.fn_city_population_code(s)>0);
EXPORT InValidMessageFT_invalid_city_population_code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Database_USA.Functions.fn_city_population_code'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_city_population_desc(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_city_population_desc(SALT311.StrType s,SALT311.StrType city_population_code) := WHICH(~Scrubs_Database_USA.Functions.fn_verify_city_population_desc(s,city_population_code)>0);
EXPORT InValidMessageFT_invalid_city_population_desc(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Database_USA.Functions.fn_verify_city_population_desc'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_corp_employee_code(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_corp_employee_code(SALT311.StrType s) := WHICH(~Scrubs_Database_USA.Functions.fn_employee_code(s)>0);
EXPORT InValidMessageFT_invalid_corp_employee_code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Database_USA.Functions.fn_employee_code'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_corporate_employee(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_corporate_employee(SALT311.StrType s,SALT311.StrType corporate_employee_code) := WHICH(~Scrubs_Database_USA.Functions.fn_verify_location_employee_desc(s,corporate_employee_code)>0);
EXPORT InValidMessageFT_invalid_corporate_employee(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Database_USA.Functions.fn_verify_location_employee_desc'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_credit(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_credit(SALT311.StrType s,SALT311.StrType creditcode) := WHICH(~Scrubs_Database_USA.Functions.fn_verify_credit_desc(s,creditcode)>0);
EXPORT InValidMessageFT_invalid_credit(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Database_USA.Functions.fn_verify_credit_desc'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_creditcode(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_creditcode(SALT311.StrType s) := WHICH(~Scrubs_Database_USA.Functions.fn_credit_code(s)>0);
EXPORT InValidMessageFT_invalid_creditcode(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Database_USA.Functions.fn_credit_code'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_credit_capacity(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_credit_capacity(SALT311.StrType s,SALT311.StrType credit_capacity_code) := WHICH(~Scrubs_Database_USA.Functions.fn_verify_credit_capacity_desc(s,credit_capacity_code)>0);
EXPORT InValidMessageFT_invalid_credit_capacity(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Database_USA.Functions.fn_verify_credit_capacity_desc'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_credit_capacity_code(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_credit_capacity_code(SALT311.StrType s) := WHICH(~Scrubs_Database_USA.Functions.fn_credit_capacity_code(s)>0);
EXPORT InValidMessageFT_invalid_credit_capacity_code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Database_USA.Functions.fn_credit_capacity_code'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_discret_income(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_discret_income(SALT311.StrType s) := WHICH(~Scrubs_Database_USA.Functions.fn_discret_income(s)>0);
EXPORT InValidMessageFT_invalid_discret_income(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Database_USA.Functions.fn_discret_income'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_discretionary_income_expenses(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_discretionary_income_expenses(SALT311.StrType s,SALT311.StrType db_cons_discretincomecode) := WHICH(~Scrubs_Database_USA.Functions.fn_verify_discretionary_income_desc(s,db_cons_discretincomecode)>0);
EXPORT InValidMessageFT_invalid_discretionary_income_expenses(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Database_USA.Functions.fn_verify_discretionary_income_desc'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_donor_code(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_donor_code(SALT311.StrType s) := WHICH(~Scrubs_Database_USA.Functions.fn_donor_code(s)>0);
EXPORT InValidMessageFT_invalid_donor_code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Database_USA.Functions.fn_donor_code'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_donor_capacity_expenses(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_donor_capacity_expenses(SALT311.StrType s,SALT311.StrType db_cons_donor_capacity_code) := WHICH(~Scrubs_Database_USA.Functions.fn_verify_donor_capacity_desc(s,db_cons_donor_capacity_code)>0);
EXPORT InValidMessageFT_invalid_donor_capacity_expenses(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Database_USA.Functions.fn_verify_donor_capacity_desc'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_dwelling_type(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_dwelling_type(SALT311.StrType s) := WHICH(~Scrubs_Database_USA.Functions.fn_dwelling_type(s)>0);
EXPORT InValidMessageFT_invalid_dwelling_type(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Database_USA.Functions.fn_dwelling_type'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_education(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_education(SALT311.StrType s) := WHICH(~Scrubs_Database_USA.Functions.fn_education(s)>0);
EXPORT InValidMessageFT_invalid_education(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Database_USA.Functions.fn_education'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_email(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,' 0123456789AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz-.@_,;\'&!+'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_email(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,' 0123456789AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz-.@_,;\'&!+'))));
EXPORT InValidMessageFT_invalid_email(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars(' 0123456789AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz-.@_,;\'&!+'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_email_indicator(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_email_indicator(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN [' ','1','0']);
EXPORT InValidMessageFT_invalid_email_indicator(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum(' |1|0'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_ethnic_code(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_ethnic_code(SALT311.StrType s) := WHICH(~Scrubs_Database_USA.Functions.fn_ethnic_code(s)>0);
EXPORT InValidMessageFT_invalid_ethnic_code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Database_USA.Functions.fn_ethnic_code'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_employee_code(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_employee_code(SALT311.StrType s) := WHICH(~Scrubs_Database_USA.Functions.fn_employee_code(s)>0);
EXPORT InValidMessageFT_invalid_employee_code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Database_USA.Functions.fn_employee_code'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_employee_desc(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_employee_desc(SALT311.StrType s,SALT311.StrType corporate_employee_code) := WHICH(~Scrubs_Database_USA.Functions.fn_verify_location_employee_desc(s,corporate_employee_code)>0);
EXPORT InValidMessageFT_invalid_employee_desc(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Database_USA.Functions.fn_verify_location_employee_desc'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_exec_type(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_exec_type(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['C','E']);
EXPORT InValidMessageFT_invalid_exec_type(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('C|E'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_executive_level(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_executive_level(SALT311.StrType s) := WHICH(~Scrubs_Database_USA.Functions.fn_verify_executive_level(s)>0);
EXPORT InValidMessageFT_invalid_executive_level(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Database_USA.Functions.fn_verify_executive_level'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_flag(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_flag(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['Y','1',' ']);
EXPORT InValidMessageFT_invalid_flag(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('Y|1| '),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_franchise(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_franchise(SALT311.StrType s) := WHICH(~Scrubs_Database_USA.Functions.fn_franchise(s)>0);
EXPORT InValidMessageFT_invalid_franchise(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Database_USA.Functions.fn_franchise'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_gender_code(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_gender_code(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['F','M','U']);
EXPORT InValidMessageFT_invalid_gender_code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('F|M|U'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_generaldate(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_generaldate(SALT311.StrType s) := WHICH(~Scrubs_Database_USA.Functions.fn_general_date(s)>0);
EXPORT InValidMessageFT_invalid_generaldate(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Database_USA.Functions.fn_general_date'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_home_owner_renter(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_home_owner_renter(SALT311.StrType s) := WHICH(~Scrubs_Database_USA.Functions.fn_home_owner_renter(s)>0);
EXPORT InValidMessageFT_invalid_home_owner_renter(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Database_USA.Functions.fn_home_owner_renter'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_home_property(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_home_property(SALT311.StrType s) := WHICH(~Scrubs_Database_USA.Functions.fn_home_property(s)>0);
EXPORT InValidMessageFT_invalid_home_property(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Database_USA.Functions.fn_home_property'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_home_sqft_ranges(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_home_sqft_ranges(SALT311.StrType s) := WHICH(~Scrubs_Database_USA.Functions.fn_verify_home_square_footage_desc(s)>0);
EXPORT InValidMessageFT_invalid_home_sqft_ranges(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Database_USA.Functions.fn_verify_home_square_footage_desc'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_home_value(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_home_value(SALT311.StrType s) := WHICH(~Scrubs_Database_USA.Functions.fn_home_value(s)>0);
EXPORT InValidMessageFT_invalid_home_value(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Database_USA.Functions.fn_home_value'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_home_value_desc(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_home_value_desc(SALT311.StrType s,SALT311.StrType db_cons_home_value_code) := WHICH(~Scrubs_Database_USA.Functions.fn_verify_home_value_desc(s,db_cons_home_value_code)>0);
EXPORT InValidMessageFT_invalid_home_value_desc(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Database_USA.Functions.fn_verify_home_value_desc'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_income_code(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_income_code(SALT311.StrType s) := WHICH(~Scrubs_Database_USA.Functions.fn_income_code(s)>0);
EXPORT InValidMessageFT_invalid_income_code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Database_USA.Functions.fn_income_code'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_income_expenses(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_income_expenses(SALT311.StrType s,SALT311.StrType db_cons_income_code) := WHICH(~Scrubs_Database_USA.Functions.fn_verify_income_desc(s,db_cons_income_code)>0);
EXPORT InValidMessageFT_invalid_income_expenses(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Database_USA.Functions.fn_verify_income_desc'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_ind_frm(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_ind_frm(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['B','D','F','I','P',' ']);
EXPORT InValidMessageFT_invalid_ind_frm(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('B|D|F|I|P| '),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_indicator(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_indicator(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['1','0']);
EXPORT InValidMessageFT_invalid_indicator(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('1|0'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_language(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_language(SALT311.StrType s) := WHICH(~Scrubs_Database_USA.Functions.fn_language(s)>0);
EXPORT InValidMessageFT_invalid_language(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Database_USA.Functions.fn_language'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_legal_code(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_legal_code(SALT311.StrType s) := WHICH(~Scrubs_Database_USA.Functions.fn_legal_code(s)>0);
EXPORT InValidMessageFT_invalid_legal_code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Database_USA.Functions.fn_legal_code'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_legal_expenses(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_legal_expenses(SALT311.StrType s,SALT311.StrType legal_expenses_code) := WHICH(~Scrubs_Database_USA.Functions.fn_verify_legal_expenses_desc(s,legal_expenses_code)>0);
EXPORT InValidMessageFT_invalid_legal_expenses(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Database_USA.Functions.fn_verify_legal_expenses_desc'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_length_of_res(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_length_of_res(SALT311.StrType s) := WHICH(~Scrubs_Database_USA.Functions.fn_length_of_res(s)>0);
EXPORT InValidMessageFT_invalid_length_of_res(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Database_USA.Functions.fn_length_of_res'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_length_of_res_desc(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_length_of_res_desc(SALT311.StrType s,SALT311.StrType db_cons_length_of_res_code) := WHICH(~Scrubs_Database_USA.Functions.fn_verify_length_of_residence_desc(s,db_cons_length_of_res_code)>0);
EXPORT InValidMessageFT_invalid_length_of_res_desc(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Database_USA.Functions.fn_verify_length_of_residence_desc'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_loc_employee_code(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_loc_employee_code(SALT311.StrType s) := WHICH(~Scrubs_Database_USA.Functions.fn_employee_code(s)>0);
EXPORT InValidMessageFT_invalid_loc_employee_code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Database_USA.Functions.fn_employee_code'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_location_employee(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_location_employee(SALT311.StrType s,SALT311.StrType location_employee_code) := WHICH(~Scrubs_Database_USA.Functions.fn_verify_location_employee_desc(s,location_employee_code)>0);
EXPORT InValidMessageFT_invalid_location_employee(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Database_USA.Functions.fn_verify_location_employee_desc'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_loc_sales_code(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_loc_sales_code(SALT311.StrType s) := WHICH(~Scrubs_Database_USA.Functions.fn_loc_sales_code(s)>0);
EXPORT InValidMessageFT_invalid_loc_sales_code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Database_USA.Functions.fn_loc_sales_code'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_location_sales(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_location_sales(SALT311.StrType s,SALT311.StrType location_sales_code) := WHICH(~Scrubs_Database_USA.Functions.fn_verify_location_sales_desc(s,location_sales_code)>0);
EXPORT InValidMessageFT_invalid_location_sales(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Database_USA.Functions.fn_verify_location_sales_desc'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_mail_score(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_mail_score(SALT311.StrType s) := WHICH(~Scrubs_Database_USA.Functions.fn_verify_mail_score(s)>0);
EXPORT InValidMessageFT_invalid_mail_score(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Database_USA.Functions.fn_verify_mail_score'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_mandatory(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_mandatory(SALT311.StrType s) := WHICH(~(LENGTH(TRIM(s)) >= 1));
EXPORT InValidMessageFT_invalid_mandatory(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLength('1..'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_marital_status(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_marital_status(SALT311.StrType s) := WHICH(~Scrubs_Database_USA.Functions.fn_marital_status(s)>0);
EXPORT InValidMessageFT_invalid_marital_status(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Database_USA.Functions.fn_marital_status'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_minority_type(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_minority_type(SALT311.StrType s) := WHICH(~Scrubs_Database_USA.Functions.fn_verify_minority_type(s)>0);
EXPORT InValidMessageFT_invalid_minority_type(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Database_USA.Functions.fn_verify_minority_type'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_month(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_month(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN [' ','1','2','3','4','5','6','7','8','9','01','02','03','04','05','06','07','08','09','10','11','12']);
EXPORT InValidMessageFT_invalid_month(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum(' |1|2|3|4|5|6|7|8|9|01|02|03|04|05|06|07|08|09|10|11|12'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_naics(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_naics(SALT311.StrType s) := WHICH(~Scrubs.fn_valid_NAICSCode(s)>0);
EXPORT InValidMessageFT_invalid_naics(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.fn_valid_NAICSCode'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_net_worth(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_net_worth(SALT311.StrType s) := WHICH(~Scrubs_Database_USA.Functions.fn_net_worth(s)>0);
EXPORT InValidMessageFT_invalid_net_worth(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Database_USA.Functions.fn_net_worth'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_networth_expenses(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_networth_expenses(SALT311.StrType s,SALT311.StrType db_cons_networthhomevalcode) := WHICH(~Scrubs_Database_USA.Functions.fn_verify_networth_desc(s,db_cons_networthhomevalcode)>0);
EXPORT InValidMessageFT_invalid_networth_expenses(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Database_USA.Functions.fn_verify_networth_desc'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_new_parent(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_new_parent(SALT311.StrType s) := WHICH(~Scrubs_Database_USA.Functions.fn_new_parent(s)>0);
EXPORT InValidMessageFT_invalid_new_parent(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Database_USA.Functions.fn_new_parent'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_number_of_pcs_code(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_number_of_pcs_code(SALT311.StrType s) := WHICH(~Scrubs_Database_USA.Functions.fn_number_of_pcs_code(s)>0);
EXPORT InValidMessageFT_invalid_number_of_pcs_code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Database_USA.Functions.fn_number_of_pcs_code'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_number_of_pcs(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_number_of_pcs(SALT311.StrType s,SALT311.StrType number_of_pcs_code) := WHICH(~Scrubs_Database_USA.Functions.fn_verify_number_of_pcs(s,number_of_pcs_code)>0);
EXPORT InValidMessageFT_invalid_number_of_pcs(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Database_USA.Functions.fn_verify_number_of_pcs'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_numeric(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_numeric(SALT311.StrType s) := WHICH(~Scrubs_Database_USA.Functions.fn_numeric(s)>0);
EXPORT InValidMessageFT_invalid_numeric(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Database_USA.Functions.fn_numeric'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_numeric_blank(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_numeric_blank(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789 '))));
EXPORT InValidMessageFT_invalid_numeric_blank(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789 '),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_office_equipment_expenses(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_office_equipment_expenses(SALT311.StrType s) := WHICH(~Scrubs_Database_USA.Functions.fn_office_equip_code(s)>0);
EXPORT InValidMessageFT_invalid_office_equipment_expenses(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Database_USA.Functions.fn_office_equip_code'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_office_equipment_expenses_desc(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_office_equipment_expenses_desc(SALT311.StrType s,SALT311.StrType office_equip_expenses_code) := WHICH(~Scrubs_Database_USA.Functions.fn_verify_office_equipment_expenses_desc(s,office_equip_expenses_code)>0);
EXPORT InValidMessageFT_invalid_office_equipment_expenses_desc(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Database_USA.Functions.fn_verify_office_equipment_expenses_desc'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_occupation_ind(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_occupation_ind(SALT311.StrType s) := WHICH(~Scrubs_Database_USA.Functions.fn_occupation_ind(s)>0);
EXPORT InValidMessageFT_invalid_occupation_ind(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Database_USA.Functions.fn_occupation_ind'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_office_equip_code(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_office_equip_code(SALT311.StrType s) := WHICH(~Scrubs_Database_USA.Functions.fn_office_equip_code(s)>0);
EXPORT InValidMessageFT_invalid_office_equip_code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Database_USA.Functions.fn_office_equip_code'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_pastdate(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_pastdate(SALT311.StrType s) := WHICH(~Scrubs_Database_USA.Functions.fn_past_yyyymmdd(s)>0);
EXPORT InValidMessageFT_invalid_pastdate(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Database_USA.Functions.fn_past_yyyymmdd'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_phone(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_phone(SALT311.StrType s) := WHICH(~Scrubs_Database_USA.Functions.fn_verify_optional_phone(s)>0);
EXPORT InValidMessageFT_invalid_phone(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Database_USA.Functions.fn_verify_optional_phone'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_poli_party_ind(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_poli_party_ind(SALT311.StrType s) := WHICH(~Scrubs_Database_USA.Functions.fn_poli_party_ind(s)>0);
EXPORT InValidMessageFT_invalid_poli_party_ind(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Database_USA.Functions.fn_poli_party_ind'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_record_type(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_record_type(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['C','H']);
EXPORT InValidMessageFT_invalid_record_type(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('C|H'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_rent_code(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_rent_code(SALT311.StrType s) := WHICH(~Scrubs_Database_USA.Functions.fn_rent_code(s)>0);
EXPORT InValidMessageFT_invalid_rent_code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Database_USA.Functions.fn_rent_code'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_rent_expenses(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_rent_expenses(SALT311.StrType s,SALT311.StrType rent_expenses_code) := WHICH(~Scrubs_Database_USA.Functions.fn_verify_rent_expenses_desc(s,rent_expenses_code)>0);
EXPORT InValidMessageFT_invalid_rent_expenses(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Database_USA.Functions.fn_verify_rent_expenses_desc'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_religious_affil(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_religious_affil(SALT311.StrType s) := WHICH(~Scrubs_Database_USA.Functions.fn_religious_affil(s)>0);
EXPORT InValidMessageFT_invalid_religious_affil(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Database_USA.Functions.fn_religious_affil'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_sic(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_sic(SALT311.StrType s) := WHICH(~Scrubs_Database_USA.Functions.fn_sic(s)>0);
EXPORT InValidMessageFT_invalid_sic(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Database_USA.Functions.fn_sic'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_sq_ft(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_sq_ft(SALT311.StrType s) := WHICH(~Scrubs_Database_USA.Functions.fn_sq_ft(s)>0);
EXPORT InValidMessageFT_invalid_sq_ft(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Database_USA.Functions.fn_sq_ft'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_square_footage(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_square_footage(SALT311.StrType s,SALT311.StrType square_footage_code) := WHICH(~Scrubs_Database_USA.Functions.fn_verify_square_footage_desc(s,square_footage_code)>0);
EXPORT InValidMessageFT_invalid_square_footage(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Database_USA.Functions.fn_verify_square_footage_desc'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_st(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_st(SALT311.StrType s) := WHICH(~Scrubs_Database_USA.Functions.fn_verify_state(s)>0);
EXPORT InValidMessageFT_invalid_st(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Database_USA.Functions.fn_verify_state'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_standardized_title(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_standardized_title(SALT311.StrType s,SALT311.StrType executive_title_rank) := WHICH(~Scrubs_Database_USA.Functions.fn_verify_standardized_title(s,executive_title_rank)>0);
EXPORT InValidMessageFT_invalid_standardized_title(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Database_USA.Functions.fn_verify_standardized_title'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_technology_code(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_technology_code(SALT311.StrType s) := WHICH(~Scrubs_Database_USA.Functions.fn_technology_code(s)>0);
EXPORT InValidMessageFT_invalid_technology_code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Database_USA.Functions.fn_technology_code'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_technology_expenses(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_technology_expenses(SALT311.StrType s,SALT311.StrType technology_expenses_code) := WHICH(~Scrubs_Database_USA.Functions.fn_verify_technology_expenses_desc(s,technology_expenses_code)>0);
EXPORT InValidMessageFT_invalid_technology_expenses(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Database_USA.Functions.fn_verify_technology_expenses_desc'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_teen_driver(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_teen_driver(SALT311.StrType s) := WHICH(~Scrubs_Database_USA.Functions.fn_teen_driver(s)>0);
EXPORT InValidMessageFT_invalid_teen_driver(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Database_USA.Functions.fn_teen_driver'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_telecom_code(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_telecom_code(SALT311.StrType s) := WHICH(~Scrubs_Database_USA.Functions.fn_telecom_code(s)>0);
EXPORT InValidMessageFT_invalid_telecom_code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Database_USA.Functions.fn_telecom_code'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_telecom_expenses(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_telecom_expenses(SALT311.StrType s,SALT311.StrType telecom_expenses_code) := WHICH(~Scrubs_Database_USA.Functions.fn_verify_telecom_expenses_desc(s,telecom_expenses_code)>0);
EXPORT InValidMessageFT_invalid_telecom_expenses(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Database_USA.Functions.fn_verify_telecom_expenses_desc'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_time_zone(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_time_zone(SALT311.StrType s) := WHICH(~Scrubs_Database_USA.Functions.fn_time_zone(s)>0);
EXPORT InValidMessageFT_invalid_time_zone(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Database_USA.Functions.fn_time_zone'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_time_zone_desc(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_time_zone_desc(SALT311.StrType s) := WHICH(~Scrubs_Database_USA.Functions.fn_verify_time_zone_desc(s)>0);
EXPORT InValidMessageFT_invalid_time_zone_desc(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Database_USA.Functions.fn_verify_time_zone_desc'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_url(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_url(SALT311.StrType s) := WHICH(~Scrubs_Database_USA.Functions.fn_url(s)>0);
EXPORT InValidMessageFT_invalid_url(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Database_USA.Functions.fn_url'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_unsec_cap(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_unsec_cap(SALT311.StrType s) := WHICH(~Scrubs_Database_USA.Functions.fn_unsec_cap(s)>0);
EXPORT InValidMessageFT_invalid_unsec_cap(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Database_USA.Functions.fn_unsec_cap'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_unsecured_credit_capacity_expenses(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_unsecured_credit_capacity_expenses(SALT311.StrType s,SALT311.StrType db_cons_unsecuredcredcapcode) := WHICH(~Scrubs_Database_USA.Functions.fn_verify_unsecured_credit_capacity_desc(s,db_cons_unsecuredcredcapcode)>0);
EXPORT InValidMessageFT_invalid_unsecured_credit_capacity_expenses(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Database_USA.Functions.fn_verify_unsecured_credit_capacity_desc'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_utilities_code(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_utilities_code(SALT311.StrType s) := WHICH(~Scrubs_Database_USA.Functions.fn_utilities_code(s)>0);
EXPORT InValidMessageFT_invalid_utilities_code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Database_USA.Functions.fn_utilities_code'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_utilities_expenses(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_utilities_expenses(SALT311.StrType s,SALT311.StrType utilities_expenses_code) := WHICH(~Scrubs_Database_USA.Functions.fn_verify_utilities_expenses_desc(s,utilities_expenses_code)>0);
EXPORT InValidMessageFT_invalid_utilities_expenses(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Database_USA.Functions.fn_verify_utilities_expenses_desc'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_year(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_year(SALT311.StrType s) := WHICH(~Scrubs_Database_USA.Functions.fn_dt_yyyy(s)>0);
EXPORT InValidMessageFT_invalid_year(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Database_USA.Functions.fn_dt_yyyy'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_years_in_business(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_years_in_business(SALT311.StrType s) := WHICH(~Scrubs_Database_USA.Functions.fn_verify_years_in_business_range(s)>0);
EXPORT InValidMessageFT_invalid_years_in_business(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Database_USA.Functions.fn_verify_years_in_business_range'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_zip5(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_zip5(SALT311.StrType s) := WHICH(~Scrubs_Database_USA.Functions.fn_numeric_or_blank(s)>0);
EXPORT InValidMessageFT_invalid_zip5(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Database_USA.Functions.fn_numeric_or_blank'),SALT311.HygieneErrors.Good);
 
EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'accounting_expenses_code','advertising_expenses_code','bus_insurance_expense_code','business_status_code','business_status_desc','city_population_code','city_population_descr','company_name','corporate_employee_code','corporate_employee_desc','county_code','creditcode','credit_desc','credit_capacity_code','credit_capacity_desc','db_cons_age','db_cons_child_near_hs_grad','db_cons_children_present','db_cons_college_graduate','db_cons_credit_card_user','db_cons_date_of_birth_month','db_cons_date_of_birth_year','db_cons_discretincomecode','db_cons_discretincomedesc','db_cons_dnc','db_cons_donor_capacity_code','db_cons_donor_capacity_desc','db_cons_dwelling_type','db_cons_education_hh','db_cons_education_ind','db_cons_email','db_cons_ethnic_code','db_cons_full_name','db_cons_gender','db_cons_home_owner_renter','db_cons_home_property_type','db_cons_home_sqft_ranges','db_cons_home_value_code','db_cons_home_value_desc','db_cons_home_year_built','db_cons_income_code','db_cons_income_desc','db_cons_intend_purchase_veh','db_cons_language_pref','db_cons_length_of_res_code','db_cons_length_of_res_desc','db_cons_marital_status','db_cons_networthhomevalcode','db_cons_net_worth_desc','db_cons_new_parent','db_cons_new_teen_driver','db_cons_newlywed','db_cons_occupation_ind','db_cons_other_pet_owner','db_cons_phone','db_cons_poli_party_ind','db_cons_recent_divorce','db_cons_recent_home_buyer','db_cons_religious_affil','db_cons_scrubbed_phoneable','db_cons_time_zone_code','db_cons_time_zone_desc','db_cons_unsecuredcredcapcode','db_cons_unsecuredcredcapdesc','domestic_foreign_owner_flag','email','email_available_indicator','exec_type','executive_level','executive_title_rank','expense_accounting_desc','expense_advertising_desc','expense_bus_insurance_desc','expense_legal_desc','expense_office_equip_desc','expense_rent_desc','expense_technology_desc','expense_telecom_desc','expense_utilities_desc','female_owned','franchise_flag','franchise_type','full_name','gender','home_based_indicator','import_export','ind_frm_indicator','legal_expenses_code','location_employee_code','location_employee_desc','location_sales_code','location_sales_desc','mail_addr_state','mail_addr_zip','mail_score','manufacturing_location','minority_owned_flag','minority_type','naics01','naics02','naics03','naics04','naics05','naics06','nb_flag','non_profit_org','number_of_pcs_code','number_of_pcs_desc','office_equip_expenses_code','phone','phy_addr_state','phy_addr_zip','primary_exec_flag','primary_sic','primarysic2','primarysic4','public_indicator','rent_expenses_code','sic02','sic03','sic04','sic05','sic06','small_business_indicator','square_footage_code','square_footage_desc','standardized_title','technology_expenses_code','telecom_expenses_code','url','utilities_expenses_code','year_established','years_in_business_range');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'accounting_expenses_code','advertising_expenses_code','bus_insurance_expense_code','business_status_code','business_status_desc','city_population_code','city_population_descr','company_name','corporate_employee_code','corporate_employee_desc','county_code','creditcode','credit_desc','credit_capacity_code','credit_capacity_desc','db_cons_age','db_cons_child_near_hs_grad','db_cons_children_present','db_cons_college_graduate','db_cons_credit_card_user','db_cons_date_of_birth_month','db_cons_date_of_birth_year','db_cons_discretincomecode','db_cons_discretincomedesc','db_cons_dnc','db_cons_donor_capacity_code','db_cons_donor_capacity_desc','db_cons_dwelling_type','db_cons_education_hh','db_cons_education_ind','db_cons_email','db_cons_ethnic_code','db_cons_full_name','db_cons_gender','db_cons_home_owner_renter','db_cons_home_property_type','db_cons_home_sqft_ranges','db_cons_home_value_code','db_cons_home_value_desc','db_cons_home_year_built','db_cons_income_code','db_cons_income_desc','db_cons_intend_purchase_veh','db_cons_language_pref','db_cons_length_of_res_code','db_cons_length_of_res_desc','db_cons_marital_status','db_cons_networthhomevalcode','db_cons_net_worth_desc','db_cons_new_parent','db_cons_new_teen_driver','db_cons_newlywed','db_cons_occupation_ind','db_cons_other_pet_owner','db_cons_phone','db_cons_poli_party_ind','db_cons_recent_divorce','db_cons_recent_home_buyer','db_cons_religious_affil','db_cons_scrubbed_phoneable','db_cons_time_zone_code','db_cons_time_zone_desc','db_cons_unsecuredcredcapcode','db_cons_unsecuredcredcapdesc','domestic_foreign_owner_flag','email','email_available_indicator','exec_type','executive_level','executive_title_rank','expense_accounting_desc','expense_advertising_desc','expense_bus_insurance_desc','expense_legal_desc','expense_office_equip_desc','expense_rent_desc','expense_technology_desc','expense_telecom_desc','expense_utilities_desc','female_owned','franchise_flag','franchise_type','full_name','gender','home_based_indicator','import_export','ind_frm_indicator','legal_expenses_code','location_employee_code','location_employee_desc','location_sales_code','location_sales_desc','mail_addr_state','mail_addr_zip','mail_score','manufacturing_location','minority_owned_flag','minority_type','naics01','naics02','naics03','naics04','naics05','naics06','nb_flag','non_profit_org','number_of_pcs_code','number_of_pcs_desc','office_equip_expenses_code','phone','phy_addr_state','phy_addr_zip','primary_exec_flag','primary_sic','primarysic2','primarysic4','public_indicator','rent_expenses_code','sic02','sic03','sic04','sic05','sic06','small_business_indicator','square_footage_code','square_footage_desc','standardized_title','technology_expenses_code','telecom_expenses_code','url','utilities_expenses_code','year_established','years_in_business_range');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'accounting_expenses_code' => 0,'advertising_expenses_code' => 1,'bus_insurance_expense_code' => 2,'business_status_code' => 3,'business_status_desc' => 4,'city_population_code' => 5,'city_population_descr' => 6,'company_name' => 7,'corporate_employee_code' => 8,'corporate_employee_desc' => 9,'county_code' => 10,'creditcode' => 11,'credit_desc' => 12,'credit_capacity_code' => 13,'credit_capacity_desc' => 14,'db_cons_age' => 15,'db_cons_child_near_hs_grad' => 16,'db_cons_children_present' => 17,'db_cons_college_graduate' => 18,'db_cons_credit_card_user' => 19,'db_cons_date_of_birth_month' => 20,'db_cons_date_of_birth_year' => 21,'db_cons_discretincomecode' => 22,'db_cons_discretincomedesc' => 23,'db_cons_dnc' => 24,'db_cons_donor_capacity_code' => 25,'db_cons_donor_capacity_desc' => 26,'db_cons_dwelling_type' => 27,'db_cons_education_hh' => 28,'db_cons_education_ind' => 29,'db_cons_email' => 30,'db_cons_ethnic_code' => 31,'db_cons_full_name' => 32,'db_cons_gender' => 33,'db_cons_home_owner_renter' => 34,'db_cons_home_property_type' => 35,'db_cons_home_sqft_ranges' => 36,'db_cons_home_value_code' => 37,'db_cons_home_value_desc' => 38,'db_cons_home_year_built' => 39,'db_cons_income_code' => 40,'db_cons_income_desc' => 41,'db_cons_intend_purchase_veh' => 42,'db_cons_language_pref' => 43,'db_cons_length_of_res_code' => 44,'db_cons_length_of_res_desc' => 45,'db_cons_marital_status' => 46,'db_cons_networthhomevalcode' => 47,'db_cons_net_worth_desc' => 48,'db_cons_new_parent' => 49,'db_cons_new_teen_driver' => 50,'db_cons_newlywed' => 51,'db_cons_occupation_ind' => 52,'db_cons_other_pet_owner' => 53,'db_cons_phone' => 54,'db_cons_poli_party_ind' => 55,'db_cons_recent_divorce' => 56,'db_cons_recent_home_buyer' => 57,'db_cons_religious_affil' => 58,'db_cons_scrubbed_phoneable' => 59,'db_cons_time_zone_code' => 60,'db_cons_time_zone_desc' => 61,'db_cons_unsecuredcredcapcode' => 62,'db_cons_unsecuredcredcapdesc' => 63,'domestic_foreign_owner_flag' => 64,'email' => 65,'email_available_indicator' => 66,'exec_type' => 67,'executive_level' => 68,'executive_title_rank' => 69,'expense_accounting_desc' => 70,'expense_advertising_desc' => 71,'expense_bus_insurance_desc' => 72,'expense_legal_desc' => 73,'expense_office_equip_desc' => 74,'expense_rent_desc' => 75,'expense_technology_desc' => 76,'expense_telecom_desc' => 77,'expense_utilities_desc' => 78,'female_owned' => 79,'franchise_flag' => 80,'franchise_type' => 81,'full_name' => 82,'gender' => 83,'home_based_indicator' => 84,'import_export' => 85,'ind_frm_indicator' => 86,'legal_expenses_code' => 87,'location_employee_code' => 88,'location_employee_desc' => 89,'location_sales_code' => 90,'location_sales_desc' => 91,'mail_addr_state' => 92,'mail_addr_zip' => 93,'mail_score' => 94,'manufacturing_location' => 95,'minority_owned_flag' => 96,'minority_type' => 97,'naics01' => 98,'naics02' => 99,'naics03' => 100,'naics04' => 101,'naics05' => 102,'naics06' => 103,'nb_flag' => 104,'non_profit_org' => 105,'number_of_pcs_code' => 106,'number_of_pcs_desc' => 107,'office_equip_expenses_code' => 108,'phone' => 109,'phy_addr_state' => 110,'phy_addr_zip' => 111,'primary_exec_flag' => 112,'primary_sic' => 113,'primarysic2' => 114,'primarysic4' => 115,'public_indicator' => 116,'rent_expenses_code' => 117,'sic02' => 118,'sic03' => 119,'sic04' => 120,'sic05' => 121,'sic06' => 122,'small_business_indicator' => 123,'square_footage_code' => 124,'square_footage_desc' => 125,'standardized_title' => 126,'technology_expenses_code' => 127,'telecom_expenses_code' => 128,'url' => 129,'utilities_expenses_code' => 130,'year_established' => 131,'years_in_business_range' => 132,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['CUSTOM'],['CUSTOM'],['CUSTOM'],['ENUM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['LENGTHS'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['ALLOW'],['ENUM'],['ENUM'],['ENUM'],['ENUM'],['ENUM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['ENUM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['ALLOW'],['CUSTOM'],['LENGTHS'],['ENUM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['ENUM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['ENUM'],['CUSTOM'],['ENUM'],['CUSTOM'],['CUSTOM'],['ENUM'],['ENUM'],['CUSTOM'],['ENUM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['ENUM'],['ALLOW'],['ENUM'],['ENUM'],['CUSTOM'],['ALLOW'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['ENUM'],['ENUM'],['CUSTOM'],['LENGTHS'],['ENUM'],['ENUM'],['ENUM'],['ENUM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['ENUM'],['ENUM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['ENUM'],['ENUM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['ENUM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['ENUM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['ENUM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_accounting_expenses_code(SALT311.StrType s0) := MakeFT_invalid_accounting_code(s0);
EXPORT InValid_accounting_expenses_code(SALT311.StrType s) := InValidFT_invalid_accounting_code(s);
EXPORT InValidMessage_accounting_expenses_code(UNSIGNED1 wh) := InValidMessageFT_invalid_accounting_code(wh);
 
EXPORT Make_advertising_expenses_code(SALT311.StrType s0) := MakeFT_invalid_advertising_code(s0);
EXPORT InValid_advertising_expenses_code(SALT311.StrType s) := InValidFT_invalid_advertising_code(s);
EXPORT InValidMessage_advertising_expenses_code(UNSIGNED1 wh) := InValidMessageFT_invalid_advertising_code(wh);
 
EXPORT Make_bus_insurance_expense_code(SALT311.StrType s0) := MakeFT_invalid_bus_insurance_code(s0);
EXPORT InValid_bus_insurance_expense_code(SALT311.StrType s) := InValidFT_invalid_bus_insurance_code(s);
EXPORT InValidMessage_bus_insurance_expense_code(UNSIGNED1 wh) := InValidMessageFT_invalid_bus_insurance_code(wh);
 
EXPORT Make_business_status_code(SALT311.StrType s0) := MakeFT_invalid_bus_status_code(s0);
EXPORT InValid_business_status_code(SALT311.StrType s) := InValidFT_invalid_bus_status_code(s);
EXPORT InValidMessage_business_status_code(UNSIGNED1 wh) := InValidMessageFT_invalid_bus_status_code(wh);
 
EXPORT Make_business_status_desc(SALT311.StrType s0) := MakeFT_invalid_business_status(s0);
EXPORT InValid_business_status_desc(SALT311.StrType s,SALT311.StrType business_status_code) := InValidFT_invalid_business_status(s,business_status_code);
EXPORT InValidMessage_business_status_desc(UNSIGNED1 wh) := InValidMessageFT_invalid_business_status(wh);
 
EXPORT Make_city_population_code(SALT311.StrType s0) := MakeFT_invalid_city_population_code(s0);
EXPORT InValid_city_population_code(SALT311.StrType s) := InValidFT_invalid_city_population_code(s);
EXPORT InValidMessage_city_population_code(UNSIGNED1 wh) := InValidMessageFT_invalid_city_population_code(wh);
 
EXPORT Make_city_population_descr(SALT311.StrType s0) := MakeFT_invalid_city_population_desc(s0);
EXPORT InValid_city_population_descr(SALT311.StrType s,SALT311.StrType city_population_code) := InValidFT_invalid_city_population_desc(s,city_population_code);
EXPORT InValidMessage_city_population_descr(UNSIGNED1 wh) := InValidMessageFT_invalid_city_population_desc(wh);
 
EXPORT Make_company_name(SALT311.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_company_name(SALT311.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_company_name(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_corporate_employee_code(SALT311.StrType s0) := MakeFT_invalid_employee_code(s0);
EXPORT InValid_corporate_employee_code(SALT311.StrType s) := InValidFT_invalid_employee_code(s);
EXPORT InValidMessage_corporate_employee_code(UNSIGNED1 wh) := InValidMessageFT_invalid_employee_code(wh);
 
EXPORT Make_corporate_employee_desc(SALT311.StrType s0) := MakeFT_invalid_employee_desc(s0);
EXPORT InValid_corporate_employee_desc(SALT311.StrType s,SALT311.StrType corporate_employee_code) := InValidFT_invalid_employee_desc(s,corporate_employee_code);
EXPORT InValidMessage_corporate_employee_desc(UNSIGNED1 wh) := InValidMessageFT_invalid_employee_desc(wh);
 
EXPORT Make_county_code(SALT311.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_county_code(SALT311.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_county_code(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_creditcode(SALT311.StrType s0) := MakeFT_invalid_creditcode(s0);
EXPORT InValid_creditcode(SALT311.StrType s) := InValidFT_invalid_creditcode(s);
EXPORT InValidMessage_creditcode(UNSIGNED1 wh) := InValidMessageFT_invalid_creditcode(wh);
 
EXPORT Make_credit_desc(SALT311.StrType s0) := MakeFT_invalid_credit(s0);
EXPORT InValid_credit_desc(SALT311.StrType s,SALT311.StrType creditcode) := InValidFT_invalid_credit(s,creditcode);
EXPORT InValidMessage_credit_desc(UNSIGNED1 wh) := InValidMessageFT_invalid_credit(wh);
 
EXPORT Make_credit_capacity_code(SALT311.StrType s0) := MakeFT_invalid_credit_capacity_code(s0);
EXPORT InValid_credit_capacity_code(SALT311.StrType s) := InValidFT_invalid_credit_capacity_code(s);
EXPORT InValidMessage_credit_capacity_code(UNSIGNED1 wh) := InValidMessageFT_invalid_credit_capacity_code(wh);
 
EXPORT Make_credit_capacity_desc(SALT311.StrType s0) := MakeFT_invalid_credit_capacity(s0);
EXPORT InValid_credit_capacity_desc(SALT311.StrType s,SALT311.StrType credit_capacity_code) := InValidFT_invalid_credit_capacity(s,credit_capacity_code);
EXPORT InValidMessage_credit_capacity_desc(UNSIGNED1 wh) := InValidMessageFT_invalid_credit_capacity(wh);
 
EXPORT Make_db_cons_age(SALT311.StrType s0) := MakeFT_invalid_numeric_blank(s0);
EXPORT InValid_db_cons_age(SALT311.StrType s) := InValidFT_invalid_numeric_blank(s);
EXPORT InValidMessage_db_cons_age(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric_blank(wh);
 
EXPORT Make_db_cons_child_near_hs_grad(SALT311.StrType s0) := MakeFT_invalid_flag(s0);
EXPORT InValid_db_cons_child_near_hs_grad(SALT311.StrType s) := InValidFT_invalid_flag(s);
EXPORT InValidMessage_db_cons_child_near_hs_grad(UNSIGNED1 wh) := InValidMessageFT_invalid_flag(wh);
 
EXPORT Make_db_cons_children_present(SALT311.StrType s0) := MakeFT_invalid_children_present(s0);
EXPORT InValid_db_cons_children_present(SALT311.StrType s) := InValidFT_invalid_children_present(s);
EXPORT InValidMessage_db_cons_children_present(UNSIGNED1 wh) := InValidMessageFT_invalid_children_present(wh);
 
EXPORT Make_db_cons_college_graduate(SALT311.StrType s0) := MakeFT_invalid_flag(s0);
EXPORT InValid_db_cons_college_graduate(SALT311.StrType s) := InValidFT_invalid_flag(s);
EXPORT InValidMessage_db_cons_college_graduate(UNSIGNED1 wh) := InValidMessageFT_invalid_flag(wh);
 
EXPORT Make_db_cons_credit_card_user(SALT311.StrType s0) := MakeFT_invalid_flag(s0);
EXPORT InValid_db_cons_credit_card_user(SALT311.StrType s) := InValidFT_invalid_flag(s);
EXPORT InValidMessage_db_cons_credit_card_user(UNSIGNED1 wh) := InValidMessageFT_invalid_flag(wh);
 
EXPORT Make_db_cons_date_of_birth_month(SALT311.StrType s0) := MakeFT_invalid_month(s0);
EXPORT InValid_db_cons_date_of_birth_month(SALT311.StrType s) := InValidFT_invalid_month(s);
EXPORT InValidMessage_db_cons_date_of_birth_month(UNSIGNED1 wh) := InValidMessageFT_invalid_month(wh);
 
EXPORT Make_db_cons_date_of_birth_year(SALT311.StrType s0) := MakeFT_invalid_year(s0);
EXPORT InValid_db_cons_date_of_birth_year(SALT311.StrType s) := InValidFT_invalid_year(s);
EXPORT InValidMessage_db_cons_date_of_birth_year(UNSIGNED1 wh) := InValidMessageFT_invalid_year(wh);
 
EXPORT Make_db_cons_discretincomecode(SALT311.StrType s0) := MakeFT_invalid_discret_income(s0);
EXPORT InValid_db_cons_discretincomecode(SALT311.StrType s) := InValidFT_invalid_discret_income(s);
EXPORT InValidMessage_db_cons_discretincomecode(UNSIGNED1 wh) := InValidMessageFT_invalid_discret_income(wh);
 
EXPORT Make_db_cons_discretincomedesc(SALT311.StrType s0) := MakeFT_invalid_discretionary_income_expenses(s0);
EXPORT InValid_db_cons_discretincomedesc(SALT311.StrType s,SALT311.StrType db_cons_discretincomecode) := InValidFT_invalid_discretionary_income_expenses(s,db_cons_discretincomecode);
EXPORT InValidMessage_db_cons_discretincomedesc(UNSIGNED1 wh) := InValidMessageFT_invalid_discretionary_income_expenses(wh);
 
EXPORT Make_db_cons_dnc(SALT311.StrType s0) := MakeFT_invalid_flag(s0);
EXPORT InValid_db_cons_dnc(SALT311.StrType s) := InValidFT_invalid_flag(s);
EXPORT InValidMessage_db_cons_dnc(UNSIGNED1 wh) := InValidMessageFT_invalid_flag(wh);
 
EXPORT Make_db_cons_donor_capacity_code(SALT311.StrType s0) := MakeFT_invalid_donor_code(s0);
EXPORT InValid_db_cons_donor_capacity_code(SALT311.StrType s) := InValidFT_invalid_donor_code(s);
EXPORT InValidMessage_db_cons_donor_capacity_code(UNSIGNED1 wh) := InValidMessageFT_invalid_donor_code(wh);
 
EXPORT Make_db_cons_donor_capacity_desc(SALT311.StrType s0) := MakeFT_invalid_donor_capacity_expenses(s0);
EXPORT InValid_db_cons_donor_capacity_desc(SALT311.StrType s,SALT311.StrType db_cons_donor_capacity_code) := InValidFT_invalid_donor_capacity_expenses(s,db_cons_donor_capacity_code);
EXPORT InValidMessage_db_cons_donor_capacity_desc(UNSIGNED1 wh) := InValidMessageFT_invalid_donor_capacity_expenses(wh);
 
EXPORT Make_db_cons_dwelling_type(SALT311.StrType s0) := MakeFT_invalid_dwelling_type(s0);
EXPORT InValid_db_cons_dwelling_type(SALT311.StrType s) := InValidFT_invalid_dwelling_type(s);
EXPORT InValidMessage_db_cons_dwelling_type(UNSIGNED1 wh) := InValidMessageFT_invalid_dwelling_type(wh);
 
EXPORT Make_db_cons_education_hh(SALT311.StrType s0) := MakeFT_invalid_education(s0);
EXPORT InValid_db_cons_education_hh(SALT311.StrType s) := InValidFT_invalid_education(s);
EXPORT InValidMessage_db_cons_education_hh(UNSIGNED1 wh) := InValidMessageFT_invalid_education(wh);
 
EXPORT Make_db_cons_education_ind(SALT311.StrType s0) := MakeFT_invalid_education(s0);
EXPORT InValid_db_cons_education_ind(SALT311.StrType s) := InValidFT_invalid_education(s);
EXPORT InValidMessage_db_cons_education_ind(UNSIGNED1 wh) := InValidMessageFT_invalid_education(wh);
 
EXPORT Make_db_cons_email(SALT311.StrType s0) := MakeFT_invalid_email(s0);
EXPORT InValid_db_cons_email(SALT311.StrType s) := InValidFT_invalid_email(s);
EXPORT InValidMessage_db_cons_email(UNSIGNED1 wh) := InValidMessageFT_invalid_email(wh);
 
EXPORT Make_db_cons_ethnic_code(SALT311.StrType s0) := MakeFT_invalid_ethnic_code(s0);
EXPORT InValid_db_cons_ethnic_code(SALT311.StrType s) := InValidFT_invalid_ethnic_code(s);
EXPORT InValidMessage_db_cons_ethnic_code(UNSIGNED1 wh) := InValidMessageFT_invalid_ethnic_code(wh);
 
EXPORT Make_db_cons_full_name(SALT311.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_db_cons_full_name(SALT311.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_db_cons_full_name(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_db_cons_gender(SALT311.StrType s0) := MakeFT_invalid_gender_code(s0);
EXPORT InValid_db_cons_gender(SALT311.StrType s) := InValidFT_invalid_gender_code(s);
EXPORT InValidMessage_db_cons_gender(UNSIGNED1 wh) := InValidMessageFT_invalid_gender_code(wh);
 
EXPORT Make_db_cons_home_owner_renter(SALT311.StrType s0) := MakeFT_invalid_home_owner_renter(s0);
EXPORT InValid_db_cons_home_owner_renter(SALT311.StrType s) := InValidFT_invalid_home_owner_renter(s);
EXPORT InValidMessage_db_cons_home_owner_renter(UNSIGNED1 wh) := InValidMessageFT_invalid_home_owner_renter(wh);
 
EXPORT Make_db_cons_home_property_type(SALT311.StrType s0) := MakeFT_invalid_home_property(s0);
EXPORT InValid_db_cons_home_property_type(SALT311.StrType s) := InValidFT_invalid_home_property(s);
EXPORT InValidMessage_db_cons_home_property_type(UNSIGNED1 wh) := InValidMessageFT_invalid_home_property(wh);
 
EXPORT Make_db_cons_home_sqft_ranges(SALT311.StrType s0) := MakeFT_invalid_home_sqft_ranges(s0);
EXPORT InValid_db_cons_home_sqft_ranges(SALT311.StrType s) := InValidFT_invalid_home_sqft_ranges(s);
EXPORT InValidMessage_db_cons_home_sqft_ranges(UNSIGNED1 wh) := InValidMessageFT_invalid_home_sqft_ranges(wh);
 
EXPORT Make_db_cons_home_value_code(SALT311.StrType s0) := MakeFT_invalid_home_value(s0);
EXPORT InValid_db_cons_home_value_code(SALT311.StrType s) := InValidFT_invalid_home_value(s);
EXPORT InValidMessage_db_cons_home_value_code(UNSIGNED1 wh) := InValidMessageFT_invalid_home_value(wh);
 
EXPORT Make_db_cons_home_value_desc(SALT311.StrType s0) := MakeFT_invalid_home_value_desc(s0);
EXPORT InValid_db_cons_home_value_desc(SALT311.StrType s,SALT311.StrType db_cons_home_value_code) := InValidFT_invalid_home_value_desc(s,db_cons_home_value_code);
EXPORT InValidMessage_db_cons_home_value_desc(UNSIGNED1 wh) := InValidMessageFT_invalid_home_value_desc(wh);
 
EXPORT Make_db_cons_home_year_built(SALT311.StrType s0) := MakeFT_invalid_year(s0);
EXPORT InValid_db_cons_home_year_built(SALT311.StrType s) := InValidFT_invalid_year(s);
EXPORT InValidMessage_db_cons_home_year_built(UNSIGNED1 wh) := InValidMessageFT_invalid_year(wh);
 
EXPORT Make_db_cons_income_code(SALT311.StrType s0) := MakeFT_invalid_income_code(s0);
EXPORT InValid_db_cons_income_code(SALT311.StrType s) := InValidFT_invalid_income_code(s);
EXPORT InValidMessage_db_cons_income_code(UNSIGNED1 wh) := InValidMessageFT_invalid_income_code(wh);
 
EXPORT Make_db_cons_income_desc(SALT311.StrType s0) := MakeFT_invalid_income_expenses(s0);
EXPORT InValid_db_cons_income_desc(SALT311.StrType s,SALT311.StrType db_cons_income_code) := InValidFT_invalid_income_expenses(s,db_cons_income_code);
EXPORT InValidMessage_db_cons_income_desc(UNSIGNED1 wh) := InValidMessageFT_invalid_income_expenses(wh);
 
EXPORT Make_db_cons_intend_purchase_veh(SALT311.StrType s0) := MakeFT_invalid_flag(s0);
EXPORT InValid_db_cons_intend_purchase_veh(SALT311.StrType s) := InValidFT_invalid_flag(s);
EXPORT InValidMessage_db_cons_intend_purchase_veh(UNSIGNED1 wh) := InValidMessageFT_invalid_flag(wh);
 
EXPORT Make_db_cons_language_pref(SALT311.StrType s0) := MakeFT_invalid_language(s0);
EXPORT InValid_db_cons_language_pref(SALT311.StrType s) := InValidFT_invalid_language(s);
EXPORT InValidMessage_db_cons_language_pref(UNSIGNED1 wh) := InValidMessageFT_invalid_language(wh);
 
EXPORT Make_db_cons_length_of_res_code(SALT311.StrType s0) := MakeFT_invalid_length_of_res(s0);
EXPORT InValid_db_cons_length_of_res_code(SALT311.StrType s) := InValidFT_invalid_length_of_res(s);
EXPORT InValidMessage_db_cons_length_of_res_code(UNSIGNED1 wh) := InValidMessageFT_invalid_length_of_res(wh);
 
EXPORT Make_db_cons_length_of_res_desc(SALT311.StrType s0) := MakeFT_invalid_length_of_res_desc(s0);
EXPORT InValid_db_cons_length_of_res_desc(SALT311.StrType s,SALT311.StrType db_cons_length_of_res_code) := InValidFT_invalid_length_of_res_desc(s,db_cons_length_of_res_code);
EXPORT InValidMessage_db_cons_length_of_res_desc(UNSIGNED1 wh) := InValidMessageFT_invalid_length_of_res_desc(wh);
 
EXPORT Make_db_cons_marital_status(SALT311.StrType s0) := MakeFT_invalid_marital_status(s0);
EXPORT InValid_db_cons_marital_status(SALT311.StrType s) := InValidFT_invalid_marital_status(s);
EXPORT InValidMessage_db_cons_marital_status(UNSIGNED1 wh) := InValidMessageFT_invalid_marital_status(wh);
 
EXPORT Make_db_cons_networthhomevalcode(SALT311.StrType s0) := MakeFT_invalid_net_worth(s0);
EXPORT InValid_db_cons_networthhomevalcode(SALT311.StrType s) := InValidFT_invalid_net_worth(s);
EXPORT InValidMessage_db_cons_networthhomevalcode(UNSIGNED1 wh) := InValidMessageFT_invalid_net_worth(wh);
 
EXPORT Make_db_cons_net_worth_desc(SALT311.StrType s0) := MakeFT_invalid_networth_expenses(s0);
EXPORT InValid_db_cons_net_worth_desc(SALT311.StrType s,SALT311.StrType db_cons_networthhomevalcode) := InValidFT_invalid_networth_expenses(s,db_cons_networthhomevalcode);
EXPORT InValidMessage_db_cons_net_worth_desc(UNSIGNED1 wh) := InValidMessageFT_invalid_networth_expenses(wh);
 
EXPORT Make_db_cons_new_parent(SALT311.StrType s0) := MakeFT_invalid_new_parent(s0);
EXPORT InValid_db_cons_new_parent(SALT311.StrType s) := InValidFT_invalid_new_parent(s);
EXPORT InValidMessage_db_cons_new_parent(UNSIGNED1 wh) := InValidMessageFT_invalid_new_parent(wh);
 
EXPORT Make_db_cons_new_teen_driver(SALT311.StrType s0) := MakeFT_invalid_teen_driver(s0);
EXPORT InValid_db_cons_new_teen_driver(SALT311.StrType s) := InValidFT_invalid_teen_driver(s);
EXPORT InValidMessage_db_cons_new_teen_driver(UNSIGNED1 wh) := InValidMessageFT_invalid_teen_driver(wh);
 
EXPORT Make_db_cons_newlywed(SALT311.StrType s0) := MakeFT_invalid_flag(s0);
EXPORT InValid_db_cons_newlywed(SALT311.StrType s) := InValidFT_invalid_flag(s);
EXPORT InValidMessage_db_cons_newlywed(UNSIGNED1 wh) := InValidMessageFT_invalid_flag(wh);
 
EXPORT Make_db_cons_occupation_ind(SALT311.StrType s0) := MakeFT_invalid_occupation_ind(s0);
EXPORT InValid_db_cons_occupation_ind(SALT311.StrType s) := InValidFT_invalid_occupation_ind(s);
EXPORT InValidMessage_db_cons_occupation_ind(UNSIGNED1 wh) := InValidMessageFT_invalid_occupation_ind(wh);
 
EXPORT Make_db_cons_other_pet_owner(SALT311.StrType s0) := MakeFT_invalid_flag(s0);
EXPORT InValid_db_cons_other_pet_owner(SALT311.StrType s) := InValidFT_invalid_flag(s);
EXPORT InValidMessage_db_cons_other_pet_owner(UNSIGNED1 wh) := InValidMessageFT_invalid_flag(wh);
 
EXPORT Make_db_cons_phone(SALT311.StrType s0) := MakeFT_invalid_phone(s0);
EXPORT InValid_db_cons_phone(SALT311.StrType s) := InValidFT_invalid_phone(s);
EXPORT InValidMessage_db_cons_phone(UNSIGNED1 wh) := InValidMessageFT_invalid_phone(wh);
 
EXPORT Make_db_cons_poli_party_ind(SALT311.StrType s0) := MakeFT_invalid_poli_party_ind(s0);
EXPORT InValid_db_cons_poli_party_ind(SALT311.StrType s) := InValidFT_invalid_poli_party_ind(s);
EXPORT InValidMessage_db_cons_poli_party_ind(UNSIGNED1 wh) := InValidMessageFT_invalid_poli_party_ind(wh);
 
EXPORT Make_db_cons_recent_divorce(SALT311.StrType s0) := MakeFT_invalid_flag(s0);
EXPORT InValid_db_cons_recent_divorce(SALT311.StrType s) := InValidFT_invalid_flag(s);
EXPORT InValidMessage_db_cons_recent_divorce(UNSIGNED1 wh) := InValidMessageFT_invalid_flag(wh);
 
EXPORT Make_db_cons_recent_home_buyer(SALT311.StrType s0) := MakeFT_invalid_flag(s0);
EXPORT InValid_db_cons_recent_home_buyer(SALT311.StrType s) := InValidFT_invalid_flag(s);
EXPORT InValidMessage_db_cons_recent_home_buyer(UNSIGNED1 wh) := InValidMessageFT_invalid_flag(wh);
 
EXPORT Make_db_cons_religious_affil(SALT311.StrType s0) := MakeFT_invalid_religious_affil(s0);
EXPORT InValid_db_cons_religious_affil(SALT311.StrType s) := InValidFT_invalid_religious_affil(s);
EXPORT InValidMessage_db_cons_religious_affil(UNSIGNED1 wh) := InValidMessageFT_invalid_religious_affil(wh);
 
EXPORT Make_db_cons_scrubbed_phoneable(SALT311.StrType s0) := MakeFT_invalid_flag(s0);
EXPORT InValid_db_cons_scrubbed_phoneable(SALT311.StrType s) := InValidFT_invalid_flag(s);
EXPORT InValidMessage_db_cons_scrubbed_phoneable(UNSIGNED1 wh) := InValidMessageFT_invalid_flag(wh);
 
EXPORT Make_db_cons_time_zone_code(SALT311.StrType s0) := MakeFT_invalid_time_zone(s0);
EXPORT InValid_db_cons_time_zone_code(SALT311.StrType s) := InValidFT_invalid_time_zone(s);
EXPORT InValidMessage_db_cons_time_zone_code(UNSIGNED1 wh) := InValidMessageFT_invalid_time_zone(wh);
 
EXPORT Make_db_cons_time_zone_desc(SALT311.StrType s0) := MakeFT_invalid_time_zone_desc(s0);
EXPORT InValid_db_cons_time_zone_desc(SALT311.StrType s) := InValidFT_invalid_time_zone_desc(s);
EXPORT InValidMessage_db_cons_time_zone_desc(UNSIGNED1 wh) := InValidMessageFT_invalid_time_zone_desc(wh);
 
EXPORT Make_db_cons_unsecuredcredcapcode(SALT311.StrType s0) := MakeFT_invalid_unsec_cap(s0);
EXPORT InValid_db_cons_unsecuredcredcapcode(SALT311.StrType s) := InValidFT_invalid_unsec_cap(s);
EXPORT InValidMessage_db_cons_unsecuredcredcapcode(UNSIGNED1 wh) := InValidMessageFT_invalid_unsec_cap(wh);
 
EXPORT Make_db_cons_unsecuredcredcapdesc(SALT311.StrType s0) := MakeFT_invalid_unsecured_credit_capacity_expenses(s0);
EXPORT InValid_db_cons_unsecuredcredcapdesc(SALT311.StrType s,SALT311.StrType db_cons_unsecuredcredcapcode) := InValidFT_invalid_unsecured_credit_capacity_expenses(s,db_cons_unsecuredcredcapcode);
EXPORT InValidMessage_db_cons_unsecuredcredcapdesc(UNSIGNED1 wh) := InValidMessageFT_invalid_unsecured_credit_capacity_expenses(wh);
 
EXPORT Make_domestic_foreign_owner_flag(SALT311.StrType s0) := MakeFT_invalid_flag(s0);
EXPORT InValid_domestic_foreign_owner_flag(SALT311.StrType s) := InValidFT_invalid_flag(s);
EXPORT InValidMessage_domestic_foreign_owner_flag(UNSIGNED1 wh) := InValidMessageFT_invalid_flag(wh);
 
EXPORT Make_email(SALT311.StrType s0) := MakeFT_invalid_email(s0);
EXPORT InValid_email(SALT311.StrType s) := InValidFT_invalid_email(s);
EXPORT InValidMessage_email(UNSIGNED1 wh) := InValidMessageFT_invalid_email(wh);
 
EXPORT Make_email_available_indicator(SALT311.StrType s0) := MakeFT_invalid_email_indicator(s0);
EXPORT InValid_email_available_indicator(SALT311.StrType s) := InValidFT_invalid_email_indicator(s);
EXPORT InValidMessage_email_available_indicator(UNSIGNED1 wh) := InValidMessageFT_invalid_email_indicator(wh);
 
EXPORT Make_exec_type(SALT311.StrType s0) := MakeFT_invalid_exec_type(s0);
EXPORT InValid_exec_type(SALT311.StrType s) := InValidFT_invalid_exec_type(s);
EXPORT InValidMessage_exec_type(UNSIGNED1 wh) := InValidMessageFT_invalid_exec_type(wh);
 
EXPORT Make_executive_level(SALT311.StrType s0) := MakeFT_invalid_executive_level(s0);
EXPORT InValid_executive_level(SALT311.StrType s) := InValidFT_invalid_executive_level(s);
EXPORT InValidMessage_executive_level(UNSIGNED1 wh) := InValidMessageFT_invalid_executive_level(wh);
 
EXPORT Make_executive_title_rank(SALT311.StrType s0) := MakeFT_invalid_numeric_blank(s0);
EXPORT InValid_executive_title_rank(SALT311.StrType s) := InValidFT_invalid_numeric_blank(s);
EXPORT InValidMessage_executive_title_rank(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric_blank(wh);
 
EXPORT Make_expense_accounting_desc(SALT311.StrType s0) := MakeFT_invalid_accounting_expenses(s0);
EXPORT InValid_expense_accounting_desc(SALT311.StrType s,SALT311.StrType accounting_expenses_code) := InValidFT_invalid_accounting_expenses(s,accounting_expenses_code);
EXPORT InValidMessage_expense_accounting_desc(UNSIGNED1 wh) := InValidMessageFT_invalid_accounting_expenses(wh);
 
EXPORT Make_expense_advertising_desc(SALT311.StrType s0) := MakeFT_invalid_advertising_expenses(s0);
EXPORT InValid_expense_advertising_desc(SALT311.StrType s,SALT311.StrType advertising_expenses_code) := InValidFT_invalid_advertising_expenses(s,advertising_expenses_code);
EXPORT InValidMessage_expense_advertising_desc(UNSIGNED1 wh) := InValidMessageFT_invalid_advertising_expenses(wh);
 
EXPORT Make_expense_bus_insurance_desc(SALT311.StrType s0) := MakeFT_invalid_business_insurance_expenses(s0);
EXPORT InValid_expense_bus_insurance_desc(SALT311.StrType s,SALT311.StrType bus_insurance_expense_code) := InValidFT_invalid_business_insurance_expenses(s,bus_insurance_expense_code);
EXPORT InValidMessage_expense_bus_insurance_desc(UNSIGNED1 wh) := InValidMessageFT_invalid_business_insurance_expenses(wh);
 
EXPORT Make_expense_legal_desc(SALT311.StrType s0) := MakeFT_invalid_legal_expenses(s0);
EXPORT InValid_expense_legal_desc(SALT311.StrType s,SALT311.StrType legal_expenses_code) := InValidFT_invalid_legal_expenses(s,legal_expenses_code);
EXPORT InValidMessage_expense_legal_desc(UNSIGNED1 wh) := InValidMessageFT_invalid_legal_expenses(wh);
 
EXPORT Make_expense_office_equip_desc(SALT311.StrType s0) := MakeFT_invalid_office_equipment_expenses_desc(s0);
EXPORT InValid_expense_office_equip_desc(SALT311.StrType s,SALT311.StrType office_equip_expenses_code) := InValidFT_invalid_office_equipment_expenses_desc(s,office_equip_expenses_code);
EXPORT InValidMessage_expense_office_equip_desc(UNSIGNED1 wh) := InValidMessageFT_invalid_office_equipment_expenses_desc(wh);
 
EXPORT Make_expense_rent_desc(SALT311.StrType s0) := MakeFT_invalid_rent_expenses(s0);
EXPORT InValid_expense_rent_desc(SALT311.StrType s,SALT311.StrType rent_expenses_code) := InValidFT_invalid_rent_expenses(s,rent_expenses_code);
EXPORT InValidMessage_expense_rent_desc(UNSIGNED1 wh) := InValidMessageFT_invalid_rent_expenses(wh);
 
EXPORT Make_expense_technology_desc(SALT311.StrType s0) := MakeFT_invalid_technology_expenses(s0);
EXPORT InValid_expense_technology_desc(SALT311.StrType s,SALT311.StrType technology_expenses_code) := InValidFT_invalid_technology_expenses(s,technology_expenses_code);
EXPORT InValidMessage_expense_technology_desc(UNSIGNED1 wh) := InValidMessageFT_invalid_technology_expenses(wh);
 
EXPORT Make_expense_telecom_desc(SALT311.StrType s0) := MakeFT_invalid_telecom_expenses(s0);
EXPORT InValid_expense_telecom_desc(SALT311.StrType s,SALT311.StrType telecom_expenses_code) := InValidFT_invalid_telecom_expenses(s,telecom_expenses_code);
EXPORT InValidMessage_expense_telecom_desc(UNSIGNED1 wh) := InValidMessageFT_invalid_telecom_expenses(wh);
 
EXPORT Make_expense_utilities_desc(SALT311.StrType s0) := MakeFT_invalid_utilities_expenses(s0);
EXPORT InValid_expense_utilities_desc(SALT311.StrType s,SALT311.StrType utilities_expenses_code) := InValidFT_invalid_utilities_expenses(s,utilities_expenses_code);
EXPORT InValidMessage_expense_utilities_desc(UNSIGNED1 wh) := InValidMessageFT_invalid_utilities_expenses(wh);
 
EXPORT Make_female_owned(SALT311.StrType s0) := MakeFT_invalid_flag(s0);
EXPORT InValid_female_owned(SALT311.StrType s) := InValidFT_invalid_flag(s);
EXPORT InValidMessage_female_owned(UNSIGNED1 wh) := InValidMessageFT_invalid_flag(wh);
 
EXPORT Make_franchise_flag(SALT311.StrType s0) := MakeFT_invalid_flag(s0);
EXPORT InValid_franchise_flag(SALT311.StrType s) := InValidFT_invalid_flag(s);
EXPORT InValidMessage_franchise_flag(UNSIGNED1 wh) := InValidMessageFT_invalid_flag(wh);
 
EXPORT Make_franchise_type(SALT311.StrType s0) := MakeFT_invalid_franchise(s0);
EXPORT InValid_franchise_type(SALT311.StrType s) := InValidFT_invalid_franchise(s);
EXPORT InValidMessage_franchise_type(UNSIGNED1 wh) := InValidMessageFT_invalid_franchise(wh);
 
EXPORT Make_full_name(SALT311.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_full_name(SALT311.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_full_name(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_gender(SALT311.StrType s0) := MakeFT_invalid_gender_code(s0);
EXPORT InValid_gender(SALT311.StrType s) := InValidFT_invalid_gender_code(s);
EXPORT InValidMessage_gender(UNSIGNED1 wh) := InValidMessageFT_invalid_gender_code(wh);
 
EXPORT Make_home_based_indicator(SALT311.StrType s0) := MakeFT_invalid_flag(s0);
EXPORT InValid_home_based_indicator(SALT311.StrType s) := InValidFT_invalid_flag(s);
EXPORT InValidMessage_home_based_indicator(UNSIGNED1 wh) := InValidMessageFT_invalid_flag(wh);
 
EXPORT Make_import_export(SALT311.StrType s0) := MakeFT_invalid_flag(s0);
EXPORT InValid_import_export(SALT311.StrType s) := InValidFT_invalid_flag(s);
EXPORT InValidMessage_import_export(UNSIGNED1 wh) := InValidMessageFT_invalid_flag(wh);
 
EXPORT Make_ind_frm_indicator(SALT311.StrType s0) := MakeFT_invalid_ind_frm(s0);
EXPORT InValid_ind_frm_indicator(SALT311.StrType s) := InValidFT_invalid_ind_frm(s);
EXPORT InValidMessage_ind_frm_indicator(UNSIGNED1 wh) := InValidMessageFT_invalid_ind_frm(wh);
 
EXPORT Make_legal_expenses_code(SALT311.StrType s0) := MakeFT_invalid_legal_code(s0);
EXPORT InValid_legal_expenses_code(SALT311.StrType s) := InValidFT_invalid_legal_code(s);
EXPORT InValidMessage_legal_expenses_code(UNSIGNED1 wh) := InValidMessageFT_invalid_legal_code(wh);
 
EXPORT Make_location_employee_code(SALT311.StrType s0) := MakeFT_invalid_loc_employee_code(s0);
EXPORT InValid_location_employee_code(SALT311.StrType s) := InValidFT_invalid_loc_employee_code(s);
EXPORT InValidMessage_location_employee_code(UNSIGNED1 wh) := InValidMessageFT_invalid_loc_employee_code(wh);
 
EXPORT Make_location_employee_desc(SALT311.StrType s0) := MakeFT_invalid_location_employee(s0);
EXPORT InValid_location_employee_desc(SALT311.StrType s,SALT311.StrType location_employee_code) := InValidFT_invalid_location_employee(s,location_employee_code);
EXPORT InValidMessage_location_employee_desc(UNSIGNED1 wh) := InValidMessageFT_invalid_location_employee(wh);
 
EXPORT Make_location_sales_code(SALT311.StrType s0) := MakeFT_invalid_loc_sales_code(s0);
EXPORT InValid_location_sales_code(SALT311.StrType s) := InValidFT_invalid_loc_sales_code(s);
EXPORT InValidMessage_location_sales_code(UNSIGNED1 wh) := InValidMessageFT_invalid_loc_sales_code(wh);
 
EXPORT Make_location_sales_desc(SALT311.StrType s0) := MakeFT_invalid_location_sales(s0);
EXPORT InValid_location_sales_desc(SALT311.StrType s,SALT311.StrType location_sales_code) := InValidFT_invalid_location_sales(s,location_sales_code);
EXPORT InValidMessage_location_sales_desc(UNSIGNED1 wh) := InValidMessageFT_invalid_location_sales(wh);
 
EXPORT Make_mail_addr_state(SALT311.StrType s0) := MakeFT_invalid_st(s0);
EXPORT InValid_mail_addr_state(SALT311.StrType s) := InValidFT_invalid_st(s);
EXPORT InValidMessage_mail_addr_state(UNSIGNED1 wh) := InValidMessageFT_invalid_st(wh);
 
EXPORT Make_mail_addr_zip(SALT311.StrType s0) := MakeFT_invalid_zip5(s0);
EXPORT InValid_mail_addr_zip(SALT311.StrType s) := InValidFT_invalid_zip5(s);
EXPORT InValidMessage_mail_addr_zip(UNSIGNED1 wh) := InValidMessageFT_invalid_zip5(wh);
 
EXPORT Make_mail_score(SALT311.StrType s0) := MakeFT_invalid_mail_score(s0);
EXPORT InValid_mail_score(SALT311.StrType s) := InValidFT_invalid_mail_score(s);
EXPORT InValidMessage_mail_score(UNSIGNED1 wh) := InValidMessageFT_invalid_mail_score(wh);
 
EXPORT Make_manufacturing_location(SALT311.StrType s0) := MakeFT_invalid_flag(s0);
EXPORT InValid_manufacturing_location(SALT311.StrType s) := InValidFT_invalid_flag(s);
EXPORT InValidMessage_manufacturing_location(UNSIGNED1 wh) := InValidMessageFT_invalid_flag(wh);
 
EXPORT Make_minority_owned_flag(SALT311.StrType s0) := MakeFT_invalid_flag(s0);
EXPORT InValid_minority_owned_flag(SALT311.StrType s) := InValidFT_invalid_flag(s);
EXPORT InValidMessage_minority_owned_flag(UNSIGNED1 wh) := InValidMessageFT_invalid_flag(wh);
 
EXPORT Make_minority_type(SALT311.StrType s0) := MakeFT_invalid_minority_type(s0);
EXPORT InValid_minority_type(SALT311.StrType s) := InValidFT_invalid_minority_type(s);
EXPORT InValidMessage_minority_type(UNSIGNED1 wh) := InValidMessageFT_invalid_minority_type(wh);
 
EXPORT Make_naics01(SALT311.StrType s0) := MakeFT_invalid_naics(s0);
EXPORT InValid_naics01(SALT311.StrType s) := InValidFT_invalid_naics(s);
EXPORT InValidMessage_naics01(UNSIGNED1 wh) := InValidMessageFT_invalid_naics(wh);
 
EXPORT Make_naics02(SALT311.StrType s0) := MakeFT_invalid_naics(s0);
EXPORT InValid_naics02(SALT311.StrType s) := InValidFT_invalid_naics(s);
EXPORT InValidMessage_naics02(UNSIGNED1 wh) := InValidMessageFT_invalid_naics(wh);
 
EXPORT Make_naics03(SALT311.StrType s0) := MakeFT_invalid_naics(s0);
EXPORT InValid_naics03(SALT311.StrType s) := InValidFT_invalid_naics(s);
EXPORT InValidMessage_naics03(UNSIGNED1 wh) := InValidMessageFT_invalid_naics(wh);
 
EXPORT Make_naics04(SALT311.StrType s0) := MakeFT_invalid_naics(s0);
EXPORT InValid_naics04(SALT311.StrType s) := InValidFT_invalid_naics(s);
EXPORT InValidMessage_naics04(UNSIGNED1 wh) := InValidMessageFT_invalid_naics(wh);
 
EXPORT Make_naics05(SALT311.StrType s0) := MakeFT_invalid_naics(s0);
EXPORT InValid_naics05(SALT311.StrType s) := InValidFT_invalid_naics(s);
EXPORT InValidMessage_naics05(UNSIGNED1 wh) := InValidMessageFT_invalid_naics(wh);
 
EXPORT Make_naics06(SALT311.StrType s0) := MakeFT_invalid_naics(s0);
EXPORT InValid_naics06(SALT311.StrType s) := InValidFT_invalid_naics(s);
EXPORT InValidMessage_naics06(UNSIGNED1 wh) := InValidMessageFT_invalid_naics(wh);
 
EXPORT Make_nb_flag(SALT311.StrType s0) := MakeFT_invalid_flag(s0);
EXPORT InValid_nb_flag(SALT311.StrType s) := InValidFT_invalid_flag(s);
EXPORT InValidMessage_nb_flag(UNSIGNED1 wh) := InValidMessageFT_invalid_flag(wh);
 
EXPORT Make_non_profit_org(SALT311.StrType s0) := MakeFT_invalid_flag(s0);
EXPORT InValid_non_profit_org(SALT311.StrType s) := InValidFT_invalid_flag(s);
EXPORT InValidMessage_non_profit_org(UNSIGNED1 wh) := InValidMessageFT_invalid_flag(wh);
 
EXPORT Make_number_of_pcs_code(SALT311.StrType s0) := MakeFT_invalid_number_of_pcs_code(s0);
EXPORT InValid_number_of_pcs_code(SALT311.StrType s) := InValidFT_invalid_number_of_pcs_code(s);
EXPORT InValidMessage_number_of_pcs_code(UNSIGNED1 wh) := InValidMessageFT_invalid_number_of_pcs_code(wh);
 
EXPORT Make_number_of_pcs_desc(SALT311.StrType s0) := MakeFT_invalid_number_of_pcs(s0);
EXPORT InValid_number_of_pcs_desc(SALT311.StrType s,SALT311.StrType number_of_pcs_code) := InValidFT_invalid_number_of_pcs(s,number_of_pcs_code);
EXPORT InValidMessage_number_of_pcs_desc(UNSIGNED1 wh) := InValidMessageFT_invalid_number_of_pcs(wh);
 
EXPORT Make_office_equip_expenses_code(SALT311.StrType s0) := MakeFT_invalid_office_equipment_expenses(s0);
EXPORT InValid_office_equip_expenses_code(SALT311.StrType s) := InValidFT_invalid_office_equipment_expenses(s);
EXPORT InValidMessage_office_equip_expenses_code(UNSIGNED1 wh) := InValidMessageFT_invalid_office_equipment_expenses(wh);
 
EXPORT Make_phone(SALT311.StrType s0) := MakeFT_invalid_phone(s0);
EXPORT InValid_phone(SALT311.StrType s) := InValidFT_invalid_phone(s);
EXPORT InValidMessage_phone(UNSIGNED1 wh) := InValidMessageFT_invalid_phone(wh);
 
EXPORT Make_phy_addr_state(SALT311.StrType s0) := MakeFT_invalid_st(s0);
EXPORT InValid_phy_addr_state(SALT311.StrType s) := InValidFT_invalid_st(s);
EXPORT InValidMessage_phy_addr_state(UNSIGNED1 wh) := InValidMessageFT_invalid_st(wh);
 
EXPORT Make_phy_addr_zip(SALT311.StrType s0) := MakeFT_invalid_zip5(s0);
EXPORT InValid_phy_addr_zip(SALT311.StrType s) := InValidFT_invalid_zip5(s);
EXPORT InValidMessage_phy_addr_zip(UNSIGNED1 wh) := InValidMessageFT_invalid_zip5(wh);
 
EXPORT Make_primary_exec_flag(SALT311.StrType s0) := MakeFT_invalid_flag(s0);
EXPORT InValid_primary_exec_flag(SALT311.StrType s) := InValidFT_invalid_flag(s);
EXPORT InValidMessage_primary_exec_flag(UNSIGNED1 wh) := InValidMessageFT_invalid_flag(wh);
 
EXPORT Make_primary_sic(SALT311.StrType s0) := MakeFT_invalid_sic(s0);
EXPORT InValid_primary_sic(SALT311.StrType s) := InValidFT_invalid_sic(s);
EXPORT InValidMessage_primary_sic(UNSIGNED1 wh) := InValidMessageFT_invalid_sic(wh);
 
EXPORT Make_primarysic2(SALT311.StrType s0) := MakeFT_invalid_sic(s0);
EXPORT InValid_primarysic2(SALT311.StrType s) := InValidFT_invalid_sic(s);
EXPORT InValidMessage_primarysic2(UNSIGNED1 wh) := InValidMessageFT_invalid_sic(wh);
 
EXPORT Make_primarysic4(SALT311.StrType s0) := MakeFT_invalid_sic(s0);
EXPORT InValid_primarysic4(SALT311.StrType s) := InValidFT_invalid_sic(s);
EXPORT InValidMessage_primarysic4(UNSIGNED1 wh) := InValidMessageFT_invalid_sic(wh);
 
EXPORT Make_public_indicator(SALT311.StrType s0) := MakeFT_invalid_flag(s0);
EXPORT InValid_public_indicator(SALT311.StrType s) := InValidFT_invalid_flag(s);
EXPORT InValidMessage_public_indicator(UNSIGNED1 wh) := InValidMessageFT_invalid_flag(wh);
 
EXPORT Make_rent_expenses_code(SALT311.StrType s0) := MakeFT_invalid_rent_code(s0);
EXPORT InValid_rent_expenses_code(SALT311.StrType s) := InValidFT_invalid_rent_code(s);
EXPORT InValidMessage_rent_expenses_code(UNSIGNED1 wh) := InValidMessageFT_invalid_rent_code(wh);
 
EXPORT Make_sic02(SALT311.StrType s0) := MakeFT_invalid_sic(s0);
EXPORT InValid_sic02(SALT311.StrType s) := InValidFT_invalid_sic(s);
EXPORT InValidMessage_sic02(UNSIGNED1 wh) := InValidMessageFT_invalid_sic(wh);
 
EXPORT Make_sic03(SALT311.StrType s0) := MakeFT_invalid_sic(s0);
EXPORT InValid_sic03(SALT311.StrType s) := InValidFT_invalid_sic(s);
EXPORT InValidMessage_sic03(UNSIGNED1 wh) := InValidMessageFT_invalid_sic(wh);
 
EXPORT Make_sic04(SALT311.StrType s0) := MakeFT_invalid_sic(s0);
EXPORT InValid_sic04(SALT311.StrType s) := InValidFT_invalid_sic(s);
EXPORT InValidMessage_sic04(UNSIGNED1 wh) := InValidMessageFT_invalid_sic(wh);
 
EXPORT Make_sic05(SALT311.StrType s0) := MakeFT_invalid_sic(s0);
EXPORT InValid_sic05(SALT311.StrType s) := InValidFT_invalid_sic(s);
EXPORT InValidMessage_sic05(UNSIGNED1 wh) := InValidMessageFT_invalid_sic(wh);
 
EXPORT Make_sic06(SALT311.StrType s0) := MakeFT_invalid_sic(s0);
EXPORT InValid_sic06(SALT311.StrType s) := InValidFT_invalid_sic(s);
EXPORT InValidMessage_sic06(UNSIGNED1 wh) := InValidMessageFT_invalid_sic(wh);
 
EXPORT Make_small_business_indicator(SALT311.StrType s0) := MakeFT_invalid_flag(s0);
EXPORT InValid_small_business_indicator(SALT311.StrType s) := InValidFT_invalid_flag(s);
EXPORT InValidMessage_small_business_indicator(UNSIGNED1 wh) := InValidMessageFT_invalid_flag(wh);
 
EXPORT Make_square_footage_code(SALT311.StrType s0) := MakeFT_invalid_sq_ft(s0);
EXPORT InValid_square_footage_code(SALT311.StrType s) := InValidFT_invalid_sq_ft(s);
EXPORT InValidMessage_square_footage_code(UNSIGNED1 wh) := InValidMessageFT_invalid_sq_ft(wh);
 
EXPORT Make_square_footage_desc(SALT311.StrType s0) := MakeFT_invalid_square_footage(s0);
EXPORT InValid_square_footage_desc(SALT311.StrType s,SALT311.StrType square_footage_code) := InValidFT_invalid_square_footage(s,square_footage_code);
EXPORT InValidMessage_square_footage_desc(UNSIGNED1 wh) := InValidMessageFT_invalid_square_footage(wh);
 
EXPORT Make_standardized_title(SALT311.StrType s0) := MakeFT_invalid_standardized_title(s0);
EXPORT InValid_standardized_title(SALT311.StrType s,SALT311.StrType executive_title_rank) := InValidFT_invalid_standardized_title(s,executive_title_rank);
EXPORT InValidMessage_standardized_title(UNSIGNED1 wh) := InValidMessageFT_invalid_standardized_title(wh);
 
EXPORT Make_technology_expenses_code(SALT311.StrType s0) := MakeFT_invalid_technology_code(s0);
EXPORT InValid_technology_expenses_code(SALT311.StrType s) := InValidFT_invalid_technology_code(s);
EXPORT InValidMessage_technology_expenses_code(UNSIGNED1 wh) := InValidMessageFT_invalid_technology_code(wh);
 
EXPORT Make_telecom_expenses_code(SALT311.StrType s0) := MakeFT_invalid_telecom_code(s0);
EXPORT InValid_telecom_expenses_code(SALT311.StrType s) := InValidFT_invalid_telecom_code(s);
EXPORT InValidMessage_telecom_expenses_code(UNSIGNED1 wh) := InValidMessageFT_invalid_telecom_code(wh);
 
EXPORT Make_url(SALT311.StrType s0) := MakeFT_invalid_url(s0);
EXPORT InValid_url(SALT311.StrType s) := InValidFT_invalid_url(s);
EXPORT InValidMessage_url(UNSIGNED1 wh) := InValidMessageFT_invalid_url(wh);
 
EXPORT Make_utilities_expenses_code(SALT311.StrType s0) := MakeFT_invalid_utilities_code(s0);
EXPORT InValid_utilities_expenses_code(SALT311.StrType s) := InValidFT_invalid_utilities_code(s);
EXPORT InValidMessage_utilities_expenses_code(UNSIGNED1 wh) := InValidMessageFT_invalid_utilities_code(wh);
 
EXPORT Make_year_established(SALT311.StrType s0) := MakeFT_invalid_year(s0);
EXPORT InValid_year_established(SALT311.StrType s) := InValidFT_invalid_year(s);
EXPORT InValidMessage_year_established(UNSIGNED1 wh) := InValidMessageFT_invalid_year(wh);
 
EXPORT Make_years_in_business_range(SALT311.StrType s0) := MakeFT_invalid_years_in_business(s0);
EXPORT InValid_years_in_business_range(SALT311.StrType s) := InValidFT_invalid_years_in_business(s);
EXPORT InValidMessage_years_in_business_range(UNSIGNED1 wh) := InValidMessageFT_invalid_years_in_business(wh);
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT311,Scrubs_Database_USA;
//Find those highly occuring pivot values to remove them from consideration
#uniquename(tr)
  %tr% := table(in_left+in_right,{ val := pivot_exp; });
#uniquename(r1)
  %r1% := record
    %tr%.val;    unsigned Cnt := COUNT(GROUP);
  end;
#uniquename(t1)
  %t1% := table(%tr%,%r1%,val,local); // Pre-aggregate before distribute
#uniquename(r2)
  %r2% := record
    %t1%.val;    unsigned Cnt := SUM(GROUP,%t1%.Cnt);
  end;
#uniquename(t2)
  %t2% := table(%t1%,%r2%,val); // Now do global aggregate
Bad_Pivots := %t2%(Cnt>100);
#uniquename(dl)
  %dl% := RECORD
    BOOLEAN Diff_accounting_expenses_code;
    BOOLEAN Diff_advertising_expenses_code;
    BOOLEAN Diff_bus_insurance_expense_code;
    BOOLEAN Diff_business_status_code;
    BOOLEAN Diff_business_status_desc;
    BOOLEAN Diff_city_population_code;
    BOOLEAN Diff_city_population_descr;
    BOOLEAN Diff_company_name;
    BOOLEAN Diff_corporate_employee_code;
    BOOLEAN Diff_corporate_employee_desc;
    BOOLEAN Diff_county_code;
    BOOLEAN Diff_creditcode;
    BOOLEAN Diff_credit_desc;
    BOOLEAN Diff_credit_capacity_code;
    BOOLEAN Diff_credit_capacity_desc;
    BOOLEAN Diff_db_cons_age;
    BOOLEAN Diff_db_cons_child_near_hs_grad;
    BOOLEAN Diff_db_cons_children_present;
    BOOLEAN Diff_db_cons_college_graduate;
    BOOLEAN Diff_db_cons_credit_card_user;
    BOOLEAN Diff_db_cons_date_of_birth_month;
    BOOLEAN Diff_db_cons_date_of_birth_year;
    BOOLEAN Diff_db_cons_discretincomecode;
    BOOLEAN Diff_db_cons_discretincomedesc;
    BOOLEAN Diff_db_cons_dnc;
    BOOLEAN Diff_db_cons_donor_capacity_code;
    BOOLEAN Diff_db_cons_donor_capacity_desc;
    BOOLEAN Diff_db_cons_dwelling_type;
    BOOLEAN Diff_db_cons_education_hh;
    BOOLEAN Diff_db_cons_education_ind;
    BOOLEAN Diff_db_cons_email;
    BOOLEAN Diff_db_cons_ethnic_code;
    BOOLEAN Diff_db_cons_full_name;
    BOOLEAN Diff_db_cons_gender;
    BOOLEAN Diff_db_cons_home_owner_renter;
    BOOLEAN Diff_db_cons_home_property_type;
    BOOLEAN Diff_db_cons_home_sqft_ranges;
    BOOLEAN Diff_db_cons_home_value_code;
    BOOLEAN Diff_db_cons_home_value_desc;
    BOOLEAN Diff_db_cons_home_year_built;
    BOOLEAN Diff_db_cons_income_code;
    BOOLEAN Diff_db_cons_income_desc;
    BOOLEAN Diff_db_cons_intend_purchase_veh;
    BOOLEAN Diff_db_cons_language_pref;
    BOOLEAN Diff_db_cons_length_of_res_code;
    BOOLEAN Diff_db_cons_length_of_res_desc;
    BOOLEAN Diff_db_cons_marital_status;
    BOOLEAN Diff_db_cons_networthhomevalcode;
    BOOLEAN Diff_db_cons_net_worth_desc;
    BOOLEAN Diff_db_cons_new_parent;
    BOOLEAN Diff_db_cons_new_teen_driver;
    BOOLEAN Diff_db_cons_newlywed;
    BOOLEAN Diff_db_cons_occupation_ind;
    BOOLEAN Diff_db_cons_other_pet_owner;
    BOOLEAN Diff_db_cons_phone;
    BOOLEAN Diff_db_cons_poli_party_ind;
    BOOLEAN Diff_db_cons_recent_divorce;
    BOOLEAN Diff_db_cons_recent_home_buyer;
    BOOLEAN Diff_db_cons_religious_affil;
    BOOLEAN Diff_db_cons_scrubbed_phoneable;
    BOOLEAN Diff_db_cons_time_zone_code;
    BOOLEAN Diff_db_cons_time_zone_desc;
    BOOLEAN Diff_db_cons_unsecuredcredcapcode;
    BOOLEAN Diff_db_cons_unsecuredcredcapdesc;
    BOOLEAN Diff_domestic_foreign_owner_flag;
    BOOLEAN Diff_email;
    BOOLEAN Diff_email_available_indicator;
    BOOLEAN Diff_exec_type;
    BOOLEAN Diff_executive_level;
    BOOLEAN Diff_executive_title_rank;
    BOOLEAN Diff_expense_accounting_desc;
    BOOLEAN Diff_expense_advertising_desc;
    BOOLEAN Diff_expense_bus_insurance_desc;
    BOOLEAN Diff_expense_legal_desc;
    BOOLEAN Diff_expense_office_equip_desc;
    BOOLEAN Diff_expense_rent_desc;
    BOOLEAN Diff_expense_technology_desc;
    BOOLEAN Diff_expense_telecom_desc;
    BOOLEAN Diff_expense_utilities_desc;
    BOOLEAN Diff_female_owned;
    BOOLEAN Diff_franchise_flag;
    BOOLEAN Diff_franchise_type;
    BOOLEAN Diff_full_name;
    BOOLEAN Diff_gender;
    BOOLEAN Diff_home_based_indicator;
    BOOLEAN Diff_import_export;
    BOOLEAN Diff_ind_frm_indicator;
    BOOLEAN Diff_legal_expenses_code;
    BOOLEAN Diff_location_employee_code;
    BOOLEAN Diff_location_employee_desc;
    BOOLEAN Diff_location_sales_code;
    BOOLEAN Diff_location_sales_desc;
    BOOLEAN Diff_mail_addr_state;
    BOOLEAN Diff_mail_addr_zip;
    BOOLEAN Diff_mail_score;
    BOOLEAN Diff_manufacturing_location;
    BOOLEAN Diff_minority_owned_flag;
    BOOLEAN Diff_minority_type;
    BOOLEAN Diff_naics01;
    BOOLEAN Diff_naics02;
    BOOLEAN Diff_naics03;
    BOOLEAN Diff_naics04;
    BOOLEAN Diff_naics05;
    BOOLEAN Diff_naics06;
    BOOLEAN Diff_nb_flag;
    BOOLEAN Diff_non_profit_org;
    BOOLEAN Diff_number_of_pcs_code;
    BOOLEAN Diff_number_of_pcs_desc;
    BOOLEAN Diff_office_equip_expenses_code;
    BOOLEAN Diff_phone;
    BOOLEAN Diff_phy_addr_state;
    BOOLEAN Diff_phy_addr_zip;
    BOOLEAN Diff_primary_exec_flag;
    BOOLEAN Diff_primary_sic;
    BOOLEAN Diff_primarysic2;
    BOOLEAN Diff_primarysic4;
    BOOLEAN Diff_public_indicator;
    BOOLEAN Diff_rent_expenses_code;
    BOOLEAN Diff_sic02;
    BOOLEAN Diff_sic03;
    BOOLEAN Diff_sic04;
    BOOLEAN Diff_sic05;
    BOOLEAN Diff_sic06;
    BOOLEAN Diff_small_business_indicator;
    BOOLEAN Diff_square_footage_code;
    BOOLEAN Diff_square_footage_desc;
    BOOLEAN Diff_standardized_title;
    BOOLEAN Diff_technology_expenses_code;
    BOOLEAN Diff_telecom_expenses_code;
    BOOLEAN Diff_url;
    BOOLEAN Diff_utilities_expenses_code;
    BOOLEAN Diff_year_established;
    BOOLEAN Diff_years_in_business_range;
    UNSIGNED Num_Diffs;
    SALT311.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_accounting_expenses_code := le.accounting_expenses_code <> ri.accounting_expenses_code;
    SELF.Diff_advertising_expenses_code := le.advertising_expenses_code <> ri.advertising_expenses_code;
    SELF.Diff_bus_insurance_expense_code := le.bus_insurance_expense_code <> ri.bus_insurance_expense_code;
    SELF.Diff_business_status_code := le.business_status_code <> ri.business_status_code;
    SELF.Diff_business_status_desc := le.business_status_desc <> ri.business_status_desc;
    SELF.Diff_city_population_code := le.city_population_code <> ri.city_population_code;
    SELF.Diff_city_population_descr := le.city_population_descr <> ri.city_population_descr;
    SELF.Diff_company_name := le.company_name <> ri.company_name;
    SELF.Diff_corporate_employee_code := le.corporate_employee_code <> ri.corporate_employee_code;
    SELF.Diff_corporate_employee_desc := le.corporate_employee_desc <> ri.corporate_employee_desc;
    SELF.Diff_county_code := le.county_code <> ri.county_code;
    SELF.Diff_creditcode := le.creditcode <> ri.creditcode;
    SELF.Diff_credit_desc := le.credit_desc <> ri.credit_desc;
    SELF.Diff_credit_capacity_code := le.credit_capacity_code <> ri.credit_capacity_code;
    SELF.Diff_credit_capacity_desc := le.credit_capacity_desc <> ri.credit_capacity_desc;
    SELF.Diff_db_cons_age := le.db_cons_age <> ri.db_cons_age;
    SELF.Diff_db_cons_child_near_hs_grad := le.db_cons_child_near_hs_grad <> ri.db_cons_child_near_hs_grad;
    SELF.Diff_db_cons_children_present := le.db_cons_children_present <> ri.db_cons_children_present;
    SELF.Diff_db_cons_college_graduate := le.db_cons_college_graduate <> ri.db_cons_college_graduate;
    SELF.Diff_db_cons_credit_card_user := le.db_cons_credit_card_user <> ri.db_cons_credit_card_user;
    SELF.Diff_db_cons_date_of_birth_month := le.db_cons_date_of_birth_month <> ri.db_cons_date_of_birth_month;
    SELF.Diff_db_cons_date_of_birth_year := le.db_cons_date_of_birth_year <> ri.db_cons_date_of_birth_year;
    SELF.Diff_db_cons_discretincomecode := le.db_cons_discretincomecode <> ri.db_cons_discretincomecode;
    SELF.Diff_db_cons_discretincomedesc := le.db_cons_discretincomedesc <> ri.db_cons_discretincomedesc;
    SELF.Diff_db_cons_dnc := le.db_cons_dnc <> ri.db_cons_dnc;
    SELF.Diff_db_cons_donor_capacity_code := le.db_cons_donor_capacity_code <> ri.db_cons_donor_capacity_code;
    SELF.Diff_db_cons_donor_capacity_desc := le.db_cons_donor_capacity_desc <> ri.db_cons_donor_capacity_desc;
    SELF.Diff_db_cons_dwelling_type := le.db_cons_dwelling_type <> ri.db_cons_dwelling_type;
    SELF.Diff_db_cons_education_hh := le.db_cons_education_hh <> ri.db_cons_education_hh;
    SELF.Diff_db_cons_education_ind := le.db_cons_education_ind <> ri.db_cons_education_ind;
    SELF.Diff_db_cons_email := le.db_cons_email <> ri.db_cons_email;
    SELF.Diff_db_cons_ethnic_code := le.db_cons_ethnic_code <> ri.db_cons_ethnic_code;
    SELF.Diff_db_cons_full_name := le.db_cons_full_name <> ri.db_cons_full_name;
    SELF.Diff_db_cons_gender := le.db_cons_gender <> ri.db_cons_gender;
    SELF.Diff_db_cons_home_owner_renter := le.db_cons_home_owner_renter <> ri.db_cons_home_owner_renter;
    SELF.Diff_db_cons_home_property_type := le.db_cons_home_property_type <> ri.db_cons_home_property_type;
    SELF.Diff_db_cons_home_sqft_ranges := le.db_cons_home_sqft_ranges <> ri.db_cons_home_sqft_ranges;
    SELF.Diff_db_cons_home_value_code := le.db_cons_home_value_code <> ri.db_cons_home_value_code;
    SELF.Diff_db_cons_home_value_desc := le.db_cons_home_value_desc <> ri.db_cons_home_value_desc;
    SELF.Diff_db_cons_home_year_built := le.db_cons_home_year_built <> ri.db_cons_home_year_built;
    SELF.Diff_db_cons_income_code := le.db_cons_income_code <> ri.db_cons_income_code;
    SELF.Diff_db_cons_income_desc := le.db_cons_income_desc <> ri.db_cons_income_desc;
    SELF.Diff_db_cons_intend_purchase_veh := le.db_cons_intend_purchase_veh <> ri.db_cons_intend_purchase_veh;
    SELF.Diff_db_cons_language_pref := le.db_cons_language_pref <> ri.db_cons_language_pref;
    SELF.Diff_db_cons_length_of_res_code := le.db_cons_length_of_res_code <> ri.db_cons_length_of_res_code;
    SELF.Diff_db_cons_length_of_res_desc := le.db_cons_length_of_res_desc <> ri.db_cons_length_of_res_desc;
    SELF.Diff_db_cons_marital_status := le.db_cons_marital_status <> ri.db_cons_marital_status;
    SELF.Diff_db_cons_networthhomevalcode := le.db_cons_networthhomevalcode <> ri.db_cons_networthhomevalcode;
    SELF.Diff_db_cons_net_worth_desc := le.db_cons_net_worth_desc <> ri.db_cons_net_worth_desc;
    SELF.Diff_db_cons_new_parent := le.db_cons_new_parent <> ri.db_cons_new_parent;
    SELF.Diff_db_cons_new_teen_driver := le.db_cons_new_teen_driver <> ri.db_cons_new_teen_driver;
    SELF.Diff_db_cons_newlywed := le.db_cons_newlywed <> ri.db_cons_newlywed;
    SELF.Diff_db_cons_occupation_ind := le.db_cons_occupation_ind <> ri.db_cons_occupation_ind;
    SELF.Diff_db_cons_other_pet_owner := le.db_cons_other_pet_owner <> ri.db_cons_other_pet_owner;
    SELF.Diff_db_cons_phone := le.db_cons_phone <> ri.db_cons_phone;
    SELF.Diff_db_cons_poli_party_ind := le.db_cons_poli_party_ind <> ri.db_cons_poli_party_ind;
    SELF.Diff_db_cons_recent_divorce := le.db_cons_recent_divorce <> ri.db_cons_recent_divorce;
    SELF.Diff_db_cons_recent_home_buyer := le.db_cons_recent_home_buyer <> ri.db_cons_recent_home_buyer;
    SELF.Diff_db_cons_religious_affil := le.db_cons_religious_affil <> ri.db_cons_religious_affil;
    SELF.Diff_db_cons_scrubbed_phoneable := le.db_cons_scrubbed_phoneable <> ri.db_cons_scrubbed_phoneable;
    SELF.Diff_db_cons_time_zone_code := le.db_cons_time_zone_code <> ri.db_cons_time_zone_code;
    SELF.Diff_db_cons_time_zone_desc := le.db_cons_time_zone_desc <> ri.db_cons_time_zone_desc;
    SELF.Diff_db_cons_unsecuredcredcapcode := le.db_cons_unsecuredcredcapcode <> ri.db_cons_unsecuredcredcapcode;
    SELF.Diff_db_cons_unsecuredcredcapdesc := le.db_cons_unsecuredcredcapdesc <> ri.db_cons_unsecuredcredcapdesc;
    SELF.Diff_domestic_foreign_owner_flag := le.domestic_foreign_owner_flag <> ri.domestic_foreign_owner_flag;
    SELF.Diff_email := le.email <> ri.email;
    SELF.Diff_email_available_indicator := le.email_available_indicator <> ri.email_available_indicator;
    SELF.Diff_exec_type := le.exec_type <> ri.exec_type;
    SELF.Diff_executive_level := le.executive_level <> ri.executive_level;
    SELF.Diff_executive_title_rank := le.executive_title_rank <> ri.executive_title_rank;
    SELF.Diff_expense_accounting_desc := le.expense_accounting_desc <> ri.expense_accounting_desc;
    SELF.Diff_expense_advertising_desc := le.expense_advertising_desc <> ri.expense_advertising_desc;
    SELF.Diff_expense_bus_insurance_desc := le.expense_bus_insurance_desc <> ri.expense_bus_insurance_desc;
    SELF.Diff_expense_legal_desc := le.expense_legal_desc <> ri.expense_legal_desc;
    SELF.Diff_expense_office_equip_desc := le.expense_office_equip_desc <> ri.expense_office_equip_desc;
    SELF.Diff_expense_rent_desc := le.expense_rent_desc <> ri.expense_rent_desc;
    SELF.Diff_expense_technology_desc := le.expense_technology_desc <> ri.expense_technology_desc;
    SELF.Diff_expense_telecom_desc := le.expense_telecom_desc <> ri.expense_telecom_desc;
    SELF.Diff_expense_utilities_desc := le.expense_utilities_desc <> ri.expense_utilities_desc;
    SELF.Diff_female_owned := le.female_owned <> ri.female_owned;
    SELF.Diff_franchise_flag := le.franchise_flag <> ri.franchise_flag;
    SELF.Diff_franchise_type := le.franchise_type <> ri.franchise_type;
    SELF.Diff_full_name := le.full_name <> ri.full_name;
    SELF.Diff_gender := le.gender <> ri.gender;
    SELF.Diff_home_based_indicator := le.home_based_indicator <> ri.home_based_indicator;
    SELF.Diff_import_export := le.import_export <> ri.import_export;
    SELF.Diff_ind_frm_indicator := le.ind_frm_indicator <> ri.ind_frm_indicator;
    SELF.Diff_legal_expenses_code := le.legal_expenses_code <> ri.legal_expenses_code;
    SELF.Diff_location_employee_code := le.location_employee_code <> ri.location_employee_code;
    SELF.Diff_location_employee_desc := le.location_employee_desc <> ri.location_employee_desc;
    SELF.Diff_location_sales_code := le.location_sales_code <> ri.location_sales_code;
    SELF.Diff_location_sales_desc := le.location_sales_desc <> ri.location_sales_desc;
    SELF.Diff_mail_addr_state := le.mail_addr_state <> ri.mail_addr_state;
    SELF.Diff_mail_addr_zip := le.mail_addr_zip <> ri.mail_addr_zip;
    SELF.Diff_mail_score := le.mail_score <> ri.mail_score;
    SELF.Diff_manufacturing_location := le.manufacturing_location <> ri.manufacturing_location;
    SELF.Diff_minority_owned_flag := le.minority_owned_flag <> ri.minority_owned_flag;
    SELF.Diff_minority_type := le.minority_type <> ri.minority_type;
    SELF.Diff_naics01 := le.naics01 <> ri.naics01;
    SELF.Diff_naics02 := le.naics02 <> ri.naics02;
    SELF.Diff_naics03 := le.naics03 <> ri.naics03;
    SELF.Diff_naics04 := le.naics04 <> ri.naics04;
    SELF.Diff_naics05 := le.naics05 <> ri.naics05;
    SELF.Diff_naics06 := le.naics06 <> ri.naics06;
    SELF.Diff_nb_flag := le.nb_flag <> ri.nb_flag;
    SELF.Diff_non_profit_org := le.non_profit_org <> ri.non_profit_org;
    SELF.Diff_number_of_pcs_code := le.number_of_pcs_code <> ri.number_of_pcs_code;
    SELF.Diff_number_of_pcs_desc := le.number_of_pcs_desc <> ri.number_of_pcs_desc;
    SELF.Diff_office_equip_expenses_code := le.office_equip_expenses_code <> ri.office_equip_expenses_code;
    SELF.Diff_phone := le.phone <> ri.phone;
    SELF.Diff_phy_addr_state := le.phy_addr_state <> ri.phy_addr_state;
    SELF.Diff_phy_addr_zip := le.phy_addr_zip <> ri.phy_addr_zip;
    SELF.Diff_primary_exec_flag := le.primary_exec_flag <> ri.primary_exec_flag;
    SELF.Diff_primary_sic := le.primary_sic <> ri.primary_sic;
    SELF.Diff_primarysic2 := le.primarysic2 <> ri.primarysic2;
    SELF.Diff_primarysic4 := le.primarysic4 <> ri.primarysic4;
    SELF.Diff_public_indicator := le.public_indicator <> ri.public_indicator;
    SELF.Diff_rent_expenses_code := le.rent_expenses_code <> ri.rent_expenses_code;
    SELF.Diff_sic02 := le.sic02 <> ri.sic02;
    SELF.Diff_sic03 := le.sic03 <> ri.sic03;
    SELF.Diff_sic04 := le.sic04 <> ri.sic04;
    SELF.Diff_sic05 := le.sic05 <> ri.sic05;
    SELF.Diff_sic06 := le.sic06 <> ri.sic06;
    SELF.Diff_small_business_indicator := le.small_business_indicator <> ri.small_business_indicator;
    SELF.Diff_square_footage_code := le.square_footage_code <> ri.square_footage_code;
    SELF.Diff_square_footage_desc := le.square_footage_desc <> ri.square_footage_desc;
    SELF.Diff_standardized_title := le.standardized_title <> ri.standardized_title;
    SELF.Diff_technology_expenses_code := le.technology_expenses_code <> ri.technology_expenses_code;
    SELF.Diff_telecom_expenses_code := le.telecom_expenses_code <> ri.telecom_expenses_code;
    SELF.Diff_url := le.url <> ri.url;
    SELF.Diff_utilities_expenses_code := le.utilities_expenses_code <> ri.utilities_expenses_code;
    SELF.Diff_year_established := le.year_established <> ri.year_established;
    SELF.Diff_years_in_business_range := le.years_in_business_range <> ri.years_in_business_range;
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_accounting_expenses_code,1,0)+ IF( SELF.Diff_advertising_expenses_code,1,0)+ IF( SELF.Diff_bus_insurance_expense_code,1,0)+ IF( SELF.Diff_business_status_code,1,0)+ IF( SELF.Diff_business_status_desc,1,0)+ IF( SELF.Diff_city_population_code,1,0)+ IF( SELF.Diff_city_population_descr,1,0)+ IF( SELF.Diff_company_name,1,0)+ IF( SELF.Diff_corporate_employee_code,1,0)+ IF( SELF.Diff_corporate_employee_desc,1,0)+ IF( SELF.Diff_county_code,1,0)+ IF( SELF.Diff_creditcode,1,0)+ IF( SELF.Diff_credit_desc,1,0)+ IF( SELF.Diff_credit_capacity_code,1,0)+ IF( SELF.Diff_credit_capacity_desc,1,0)+ IF( SELF.Diff_db_cons_age,1,0)+ IF( SELF.Diff_db_cons_child_near_hs_grad,1,0)+ IF( SELF.Diff_db_cons_children_present,1,0)+ IF( SELF.Diff_db_cons_college_graduate,1,0)+ IF( SELF.Diff_db_cons_credit_card_user,1,0)+ IF( SELF.Diff_db_cons_date_of_birth_month,1,0)+ IF( SELF.Diff_db_cons_date_of_birth_year,1,0)+ IF( SELF.Diff_db_cons_discretincomecode,1,0)+ IF( SELF.Diff_db_cons_discretincomedesc,1,0)+ IF( SELF.Diff_db_cons_dnc,1,0)+ IF( SELF.Diff_db_cons_donor_capacity_code,1,0)+ IF( SELF.Diff_db_cons_donor_capacity_desc,1,0)+ IF( SELF.Diff_db_cons_dwelling_type,1,0)+ IF( SELF.Diff_db_cons_education_hh,1,0)+ IF( SELF.Diff_db_cons_education_ind,1,0)+ IF( SELF.Diff_db_cons_email,1,0)+ IF( SELF.Diff_db_cons_ethnic_code,1,0)+ IF( SELF.Diff_db_cons_full_name,1,0)+ IF( SELF.Diff_db_cons_gender,1,0)+ IF( SELF.Diff_db_cons_home_owner_renter,1,0)+ IF( SELF.Diff_db_cons_home_property_type,1,0)+ IF( SELF.Diff_db_cons_home_sqft_ranges,1,0)+ IF( SELF.Diff_db_cons_home_value_code,1,0)+ IF( SELF.Diff_db_cons_home_value_desc,1,0)+ IF( SELF.Diff_db_cons_home_year_built,1,0)+ IF( SELF.Diff_db_cons_income_code,1,0)+ IF( SELF.Diff_db_cons_income_desc,1,0)+ IF( SELF.Diff_db_cons_intend_purchase_veh,1,0)+ IF( SELF.Diff_db_cons_language_pref,1,0)+ IF( SELF.Diff_db_cons_length_of_res_code,1,0)+ IF( SELF.Diff_db_cons_length_of_res_desc,1,0)+ IF( SELF.Diff_db_cons_marital_status,1,0)+ IF( SELF.Diff_db_cons_networthhomevalcode,1,0)+ IF( SELF.Diff_db_cons_net_worth_desc,1,0)+ IF( SELF.Diff_db_cons_new_parent,1,0)+ IF( SELF.Diff_db_cons_new_teen_driver,1,0)+ IF( SELF.Diff_db_cons_newlywed,1,0)+ IF( SELF.Diff_db_cons_occupation_ind,1,0)+ IF( SELF.Diff_db_cons_other_pet_owner,1,0)+ IF( SELF.Diff_db_cons_phone,1,0)+ IF( SELF.Diff_db_cons_poli_party_ind,1,0)+ IF( SELF.Diff_db_cons_recent_divorce,1,0)+ IF( SELF.Diff_db_cons_recent_home_buyer,1,0)+ IF( SELF.Diff_db_cons_religious_affil,1,0)+ IF( SELF.Diff_db_cons_scrubbed_phoneable,1,0)+ IF( SELF.Diff_db_cons_time_zone_code,1,0)+ IF( SELF.Diff_db_cons_time_zone_desc,1,0)+ IF( SELF.Diff_db_cons_unsecuredcredcapcode,1,0)+ IF( SELF.Diff_db_cons_unsecuredcredcapdesc,1,0)+ IF( SELF.Diff_domestic_foreign_owner_flag,1,0)+ IF( SELF.Diff_email,1,0)+ IF( SELF.Diff_email_available_indicator,1,0)+ IF( SELF.Diff_exec_type,1,0)+ IF( SELF.Diff_executive_level,1,0)+ IF( SELF.Diff_executive_title_rank,1,0)+ IF( SELF.Diff_expense_accounting_desc,1,0)+ IF( SELF.Diff_expense_advertising_desc,1,0)+ IF( SELF.Diff_expense_bus_insurance_desc,1,0)+ IF( SELF.Diff_expense_legal_desc,1,0)+ IF( SELF.Diff_expense_office_equip_desc,1,0)+ IF( SELF.Diff_expense_rent_desc,1,0)+ IF( SELF.Diff_expense_technology_desc,1,0)+ IF( SELF.Diff_expense_telecom_desc,1,0)+ IF( SELF.Diff_expense_utilities_desc,1,0)+ IF( SELF.Diff_female_owned,1,0)+ IF( SELF.Diff_franchise_flag,1,0)+ IF( SELF.Diff_franchise_type,1,0)+ IF( SELF.Diff_full_name,1,0)+ IF( SELF.Diff_gender,1,0)+ IF( SELF.Diff_home_based_indicator,1,0)+ IF( SELF.Diff_import_export,1,0)+ IF( SELF.Diff_ind_frm_indicator,1,0)+ IF( SELF.Diff_legal_expenses_code,1,0)+ IF( SELF.Diff_location_employee_code,1,0)+ IF( SELF.Diff_location_employee_desc,1,0)+ IF( SELF.Diff_location_sales_code,1,0)+ IF( SELF.Diff_location_sales_desc,1,0)+ IF( SELF.Diff_mail_addr_state,1,0)+ IF( SELF.Diff_mail_addr_zip,1,0)+ IF( SELF.Diff_mail_score,1,0)+ IF( SELF.Diff_manufacturing_location,1,0)+ IF( SELF.Diff_minority_owned_flag,1,0)+ IF( SELF.Diff_minority_type,1,0)+ IF( SELF.Diff_naics01,1,0)+ IF( SELF.Diff_naics02,1,0)+ IF( SELF.Diff_naics03,1,0)+ IF( SELF.Diff_naics04,1,0)+ IF( SELF.Diff_naics05,1,0)+ IF( SELF.Diff_naics06,1,0)+ IF( SELF.Diff_nb_flag,1,0)+ IF( SELF.Diff_non_profit_org,1,0)+ IF( SELF.Diff_number_of_pcs_code,1,0)+ IF( SELF.Diff_number_of_pcs_desc,1,0)+ IF( SELF.Diff_office_equip_expenses_code,1,0)+ IF( SELF.Diff_phone,1,0)+ IF( SELF.Diff_phy_addr_state,1,0)+ IF( SELF.Diff_phy_addr_zip,1,0)+ IF( SELF.Diff_primary_exec_flag,1,0)+ IF( SELF.Diff_primary_sic,1,0)+ IF( SELF.Diff_primarysic2,1,0)+ IF( SELF.Diff_primarysic4,1,0)+ IF( SELF.Diff_public_indicator,1,0)+ IF( SELF.Diff_rent_expenses_code,1,0)+ IF( SELF.Diff_sic02,1,0)+ IF( SELF.Diff_sic03,1,0)+ IF( SELF.Diff_sic04,1,0)+ IF( SELF.Diff_sic05,1,0)+ IF( SELF.Diff_sic06,1,0)+ IF( SELF.Diff_small_business_indicator,1,0)+ IF( SELF.Diff_square_footage_code,1,0)+ IF( SELF.Diff_square_footage_desc,1,0)+ IF( SELF.Diff_standardized_title,1,0)+ IF( SELF.Diff_technology_expenses_code,1,0)+ IF( SELF.Diff_telecom_expenses_code,1,0)+ IF( SELF.Diff_url,1,0)+ IF( SELF.Diff_utilities_expenses_code,1,0)+ IF( SELF.Diff_year_established,1,0)+ IF( SELF.Diff_years_in_business_range,1,0);
  END;
// Now need to remove bad pivots from comparison
#uniquename(L)
  %L% := JOIN(in_left,bad_pivots,evaluate(LEFT,pivot_exp)=right.val,transform(left),left only,lookup);
#uniquename(R)
  %R% := JOIN(in_right,bad_pivots,evaluate(LEFT,pivot_exp)=right.val,transform(left),left only,lookup);
#uniquename(DiffL)
  %DiffL% := JOIN(%L%,%R%,evaluate(left,pivot_exp)=evaluate(right,pivot_exp),%fd%(left,right),hash);
#uniquename(Closest)
  %Closest% := DEDUP(SORT(%DiffL%,Val,Num_Diffs,local),Val,local); // Join will have distributed by pivot_exp
#uniquename(AggRec)
  %AggRec% := RECORD
    Count_Diff_accounting_expenses_code := COUNT(GROUP,%Closest%.Diff_accounting_expenses_code);
    Count_Diff_advertising_expenses_code := COUNT(GROUP,%Closest%.Diff_advertising_expenses_code);
    Count_Diff_bus_insurance_expense_code := COUNT(GROUP,%Closest%.Diff_bus_insurance_expense_code);
    Count_Diff_business_status_code := COUNT(GROUP,%Closest%.Diff_business_status_code);
    Count_Diff_business_status_desc := COUNT(GROUP,%Closest%.Diff_business_status_desc);
    Count_Diff_city_population_code := COUNT(GROUP,%Closest%.Diff_city_population_code);
    Count_Diff_city_population_descr := COUNT(GROUP,%Closest%.Diff_city_population_descr);
    Count_Diff_company_name := COUNT(GROUP,%Closest%.Diff_company_name);
    Count_Diff_corporate_employee_code := COUNT(GROUP,%Closest%.Diff_corporate_employee_code);
    Count_Diff_corporate_employee_desc := COUNT(GROUP,%Closest%.Diff_corporate_employee_desc);
    Count_Diff_county_code := COUNT(GROUP,%Closest%.Diff_county_code);
    Count_Diff_creditcode := COUNT(GROUP,%Closest%.Diff_creditcode);
    Count_Diff_credit_desc := COUNT(GROUP,%Closest%.Diff_credit_desc);
    Count_Diff_credit_capacity_code := COUNT(GROUP,%Closest%.Diff_credit_capacity_code);
    Count_Diff_credit_capacity_desc := COUNT(GROUP,%Closest%.Diff_credit_capacity_desc);
    Count_Diff_db_cons_age := COUNT(GROUP,%Closest%.Diff_db_cons_age);
    Count_Diff_db_cons_child_near_hs_grad := COUNT(GROUP,%Closest%.Diff_db_cons_child_near_hs_grad);
    Count_Diff_db_cons_children_present := COUNT(GROUP,%Closest%.Diff_db_cons_children_present);
    Count_Diff_db_cons_college_graduate := COUNT(GROUP,%Closest%.Diff_db_cons_college_graduate);
    Count_Diff_db_cons_credit_card_user := COUNT(GROUP,%Closest%.Diff_db_cons_credit_card_user);
    Count_Diff_db_cons_date_of_birth_month := COUNT(GROUP,%Closest%.Diff_db_cons_date_of_birth_month);
    Count_Diff_db_cons_date_of_birth_year := COUNT(GROUP,%Closest%.Diff_db_cons_date_of_birth_year);
    Count_Diff_db_cons_discretincomecode := COUNT(GROUP,%Closest%.Diff_db_cons_discretincomecode);
    Count_Diff_db_cons_discretincomedesc := COUNT(GROUP,%Closest%.Diff_db_cons_discretincomedesc);
    Count_Diff_db_cons_dnc := COUNT(GROUP,%Closest%.Diff_db_cons_dnc);
    Count_Diff_db_cons_donor_capacity_code := COUNT(GROUP,%Closest%.Diff_db_cons_donor_capacity_code);
    Count_Diff_db_cons_donor_capacity_desc := COUNT(GROUP,%Closest%.Diff_db_cons_donor_capacity_desc);
    Count_Diff_db_cons_dwelling_type := COUNT(GROUP,%Closest%.Diff_db_cons_dwelling_type);
    Count_Diff_db_cons_education_hh := COUNT(GROUP,%Closest%.Diff_db_cons_education_hh);
    Count_Diff_db_cons_education_ind := COUNT(GROUP,%Closest%.Diff_db_cons_education_ind);
    Count_Diff_db_cons_email := COUNT(GROUP,%Closest%.Diff_db_cons_email);
    Count_Diff_db_cons_ethnic_code := COUNT(GROUP,%Closest%.Diff_db_cons_ethnic_code);
    Count_Diff_db_cons_full_name := COUNT(GROUP,%Closest%.Diff_db_cons_full_name);
    Count_Diff_db_cons_gender := COUNT(GROUP,%Closest%.Diff_db_cons_gender);
    Count_Diff_db_cons_home_owner_renter := COUNT(GROUP,%Closest%.Diff_db_cons_home_owner_renter);
    Count_Diff_db_cons_home_property_type := COUNT(GROUP,%Closest%.Diff_db_cons_home_property_type);
    Count_Diff_db_cons_home_sqft_ranges := COUNT(GROUP,%Closest%.Diff_db_cons_home_sqft_ranges);
    Count_Diff_db_cons_home_value_code := COUNT(GROUP,%Closest%.Diff_db_cons_home_value_code);
    Count_Diff_db_cons_home_value_desc := COUNT(GROUP,%Closest%.Diff_db_cons_home_value_desc);
    Count_Diff_db_cons_home_year_built := COUNT(GROUP,%Closest%.Diff_db_cons_home_year_built);
    Count_Diff_db_cons_income_code := COUNT(GROUP,%Closest%.Diff_db_cons_income_code);
    Count_Diff_db_cons_income_desc := COUNT(GROUP,%Closest%.Diff_db_cons_income_desc);
    Count_Diff_db_cons_intend_purchase_veh := COUNT(GROUP,%Closest%.Diff_db_cons_intend_purchase_veh);
    Count_Diff_db_cons_language_pref := COUNT(GROUP,%Closest%.Diff_db_cons_language_pref);
    Count_Diff_db_cons_length_of_res_code := COUNT(GROUP,%Closest%.Diff_db_cons_length_of_res_code);
    Count_Diff_db_cons_length_of_res_desc := COUNT(GROUP,%Closest%.Diff_db_cons_length_of_res_desc);
    Count_Diff_db_cons_marital_status := COUNT(GROUP,%Closest%.Diff_db_cons_marital_status);
    Count_Diff_db_cons_networthhomevalcode := COUNT(GROUP,%Closest%.Diff_db_cons_networthhomevalcode);
    Count_Diff_db_cons_net_worth_desc := COUNT(GROUP,%Closest%.Diff_db_cons_net_worth_desc);
    Count_Diff_db_cons_new_parent := COUNT(GROUP,%Closest%.Diff_db_cons_new_parent);
    Count_Diff_db_cons_new_teen_driver := COUNT(GROUP,%Closest%.Diff_db_cons_new_teen_driver);
    Count_Diff_db_cons_newlywed := COUNT(GROUP,%Closest%.Diff_db_cons_newlywed);
    Count_Diff_db_cons_occupation_ind := COUNT(GROUP,%Closest%.Diff_db_cons_occupation_ind);
    Count_Diff_db_cons_other_pet_owner := COUNT(GROUP,%Closest%.Diff_db_cons_other_pet_owner);
    Count_Diff_db_cons_phone := COUNT(GROUP,%Closest%.Diff_db_cons_phone);
    Count_Diff_db_cons_poli_party_ind := COUNT(GROUP,%Closest%.Diff_db_cons_poli_party_ind);
    Count_Diff_db_cons_recent_divorce := COUNT(GROUP,%Closest%.Diff_db_cons_recent_divorce);
    Count_Diff_db_cons_recent_home_buyer := COUNT(GROUP,%Closest%.Diff_db_cons_recent_home_buyer);
    Count_Diff_db_cons_religious_affil := COUNT(GROUP,%Closest%.Diff_db_cons_religious_affil);
    Count_Diff_db_cons_scrubbed_phoneable := COUNT(GROUP,%Closest%.Diff_db_cons_scrubbed_phoneable);
    Count_Diff_db_cons_time_zone_code := COUNT(GROUP,%Closest%.Diff_db_cons_time_zone_code);
    Count_Diff_db_cons_time_zone_desc := COUNT(GROUP,%Closest%.Diff_db_cons_time_zone_desc);
    Count_Diff_db_cons_unsecuredcredcapcode := COUNT(GROUP,%Closest%.Diff_db_cons_unsecuredcredcapcode);
    Count_Diff_db_cons_unsecuredcredcapdesc := COUNT(GROUP,%Closest%.Diff_db_cons_unsecuredcredcapdesc);
    Count_Diff_domestic_foreign_owner_flag := COUNT(GROUP,%Closest%.Diff_domestic_foreign_owner_flag);
    Count_Diff_email := COUNT(GROUP,%Closest%.Diff_email);
    Count_Diff_email_available_indicator := COUNT(GROUP,%Closest%.Diff_email_available_indicator);
    Count_Diff_exec_type := COUNT(GROUP,%Closest%.Diff_exec_type);
    Count_Diff_executive_level := COUNT(GROUP,%Closest%.Diff_executive_level);
    Count_Diff_executive_title_rank := COUNT(GROUP,%Closest%.Diff_executive_title_rank);
    Count_Diff_expense_accounting_desc := COUNT(GROUP,%Closest%.Diff_expense_accounting_desc);
    Count_Diff_expense_advertising_desc := COUNT(GROUP,%Closest%.Diff_expense_advertising_desc);
    Count_Diff_expense_bus_insurance_desc := COUNT(GROUP,%Closest%.Diff_expense_bus_insurance_desc);
    Count_Diff_expense_legal_desc := COUNT(GROUP,%Closest%.Diff_expense_legal_desc);
    Count_Diff_expense_office_equip_desc := COUNT(GROUP,%Closest%.Diff_expense_office_equip_desc);
    Count_Diff_expense_rent_desc := COUNT(GROUP,%Closest%.Diff_expense_rent_desc);
    Count_Diff_expense_technology_desc := COUNT(GROUP,%Closest%.Diff_expense_technology_desc);
    Count_Diff_expense_telecom_desc := COUNT(GROUP,%Closest%.Diff_expense_telecom_desc);
    Count_Diff_expense_utilities_desc := COUNT(GROUP,%Closest%.Diff_expense_utilities_desc);
    Count_Diff_female_owned := COUNT(GROUP,%Closest%.Diff_female_owned);
    Count_Diff_franchise_flag := COUNT(GROUP,%Closest%.Diff_franchise_flag);
    Count_Diff_franchise_type := COUNT(GROUP,%Closest%.Diff_franchise_type);
    Count_Diff_full_name := COUNT(GROUP,%Closest%.Diff_full_name);
    Count_Diff_gender := COUNT(GROUP,%Closest%.Diff_gender);
    Count_Diff_home_based_indicator := COUNT(GROUP,%Closest%.Diff_home_based_indicator);
    Count_Diff_import_export := COUNT(GROUP,%Closest%.Diff_import_export);
    Count_Diff_ind_frm_indicator := COUNT(GROUP,%Closest%.Diff_ind_frm_indicator);
    Count_Diff_legal_expenses_code := COUNT(GROUP,%Closest%.Diff_legal_expenses_code);
    Count_Diff_location_employee_code := COUNT(GROUP,%Closest%.Diff_location_employee_code);
    Count_Diff_location_employee_desc := COUNT(GROUP,%Closest%.Diff_location_employee_desc);
    Count_Diff_location_sales_code := COUNT(GROUP,%Closest%.Diff_location_sales_code);
    Count_Diff_location_sales_desc := COUNT(GROUP,%Closest%.Diff_location_sales_desc);
    Count_Diff_mail_addr_state := COUNT(GROUP,%Closest%.Diff_mail_addr_state);
    Count_Diff_mail_addr_zip := COUNT(GROUP,%Closest%.Diff_mail_addr_zip);
    Count_Diff_mail_score := COUNT(GROUP,%Closest%.Diff_mail_score);
    Count_Diff_manufacturing_location := COUNT(GROUP,%Closest%.Diff_manufacturing_location);
    Count_Diff_minority_owned_flag := COUNT(GROUP,%Closest%.Diff_minority_owned_flag);
    Count_Diff_minority_type := COUNT(GROUP,%Closest%.Diff_minority_type);
    Count_Diff_naics01 := COUNT(GROUP,%Closest%.Diff_naics01);
    Count_Diff_naics02 := COUNT(GROUP,%Closest%.Diff_naics02);
    Count_Diff_naics03 := COUNT(GROUP,%Closest%.Diff_naics03);
    Count_Diff_naics04 := COUNT(GROUP,%Closest%.Diff_naics04);
    Count_Diff_naics05 := COUNT(GROUP,%Closest%.Diff_naics05);
    Count_Diff_naics06 := COUNT(GROUP,%Closest%.Diff_naics06);
    Count_Diff_nb_flag := COUNT(GROUP,%Closest%.Diff_nb_flag);
    Count_Diff_non_profit_org := COUNT(GROUP,%Closest%.Diff_non_profit_org);
    Count_Diff_number_of_pcs_code := COUNT(GROUP,%Closest%.Diff_number_of_pcs_code);
    Count_Diff_number_of_pcs_desc := COUNT(GROUP,%Closest%.Diff_number_of_pcs_desc);
    Count_Diff_office_equip_expenses_code := COUNT(GROUP,%Closest%.Diff_office_equip_expenses_code);
    Count_Diff_phone := COUNT(GROUP,%Closest%.Diff_phone);
    Count_Diff_phy_addr_state := COUNT(GROUP,%Closest%.Diff_phy_addr_state);
    Count_Diff_phy_addr_zip := COUNT(GROUP,%Closest%.Diff_phy_addr_zip);
    Count_Diff_primary_exec_flag := COUNT(GROUP,%Closest%.Diff_primary_exec_flag);
    Count_Diff_primary_sic := COUNT(GROUP,%Closest%.Diff_primary_sic);
    Count_Diff_primarysic2 := COUNT(GROUP,%Closest%.Diff_primarysic2);
    Count_Diff_primarysic4 := COUNT(GROUP,%Closest%.Diff_primarysic4);
    Count_Diff_public_indicator := COUNT(GROUP,%Closest%.Diff_public_indicator);
    Count_Diff_rent_expenses_code := COUNT(GROUP,%Closest%.Diff_rent_expenses_code);
    Count_Diff_sic02 := COUNT(GROUP,%Closest%.Diff_sic02);
    Count_Diff_sic03 := COUNT(GROUP,%Closest%.Diff_sic03);
    Count_Diff_sic04 := COUNT(GROUP,%Closest%.Diff_sic04);
    Count_Diff_sic05 := COUNT(GROUP,%Closest%.Diff_sic05);
    Count_Diff_sic06 := COUNT(GROUP,%Closest%.Diff_sic06);
    Count_Diff_small_business_indicator := COUNT(GROUP,%Closest%.Diff_small_business_indicator);
    Count_Diff_square_footage_code := COUNT(GROUP,%Closest%.Diff_square_footage_code);
    Count_Diff_square_footage_desc := COUNT(GROUP,%Closest%.Diff_square_footage_desc);
    Count_Diff_standardized_title := COUNT(GROUP,%Closest%.Diff_standardized_title);
    Count_Diff_technology_expenses_code := COUNT(GROUP,%Closest%.Diff_technology_expenses_code);
    Count_Diff_telecom_expenses_code := COUNT(GROUP,%Closest%.Diff_telecom_expenses_code);
    Count_Diff_url := COUNT(GROUP,%Closest%.Diff_url);
    Count_Diff_utilities_expenses_code := COUNT(GROUP,%Closest%.Diff_utilities_expenses_code);
    Count_Diff_year_established := COUNT(GROUP,%Closest%.Diff_year_established);
    Count_Diff_years_in_business_range := COUNT(GROUP,%Closest%.Diff_years_in_business_range);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
