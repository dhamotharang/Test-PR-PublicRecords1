IMPORT SALT311;
IMPORT Scrubs_Database_USA; // Import modules for FieldTypes attribute definitions
EXPORT Base_Fields := MODULE
 
EXPORT NumFields := 107;
 
// Processing for each FieldType
EXPORT SALT311.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_pastdate','invalid_generaldate','invalid_record_type','invalid_ind_frm','invalid_mandatory','invalid_gender_code','invalid_flag','invalid_exec_type','invalid_st','invalid_zip5','invalid_mail_score','invalid_phone','invalid_email','invalid_email_indicator','invalid_indicator','invalid_url','invalid_bus_status_code','invalid_franchise','invalid_numeric','invalid_sic','invalid_naics','invalid_loc_employee_code','invalid_loc_sales_code','invalid_corp_employee_code','invalid_year','invalid_sq_ft','invalid_credit_code','invalid_credit_capacity_code','invalid_advertising_code','invalid_technology_code','invalid_office_equip_code','invalid_rent_code','invalid_telecom_code','invalid_accounting_code','invalid_bus_insurance_code','invalid_legal_code','invalid_utilities_code','invalid_number_of_pcs_code','invalid_month','invalid_numeric_blank','invalid_ethnic_code','invalid_religious_affil','invalid_language','invalid_time_zone','invalid_children_present','invalid_home_value','invalid_donor_code','invalid_home_owner_renter','invalid_length_of_res','invalid_dwelling_type','invalid_income_code','invalid_unsec_cap','invalid_net_worth','invalid_discret_income','invalid_marital_status','invalid_new_parent','invalid_teen_driver','invalid_home_sqft_ranges','invalid_poli_party_ind','invalid_occupation_ind','invalid_home_property','invalid_education');
EXPORT FieldTypeNum(SALT311.StrType fn) := CASE(fn,'invalid_pastdate' => 1,'invalid_generaldate' => 2,'invalid_record_type' => 3,'invalid_ind_frm' => 4,'invalid_mandatory' => 5,'invalid_gender_code' => 6,'invalid_flag' => 7,'invalid_exec_type' => 8,'invalid_st' => 9,'invalid_zip5' => 10,'invalid_mail_score' => 11,'invalid_phone' => 12,'invalid_email' => 13,'invalid_email_indicator' => 14,'invalid_indicator' => 15,'invalid_url' => 16,'invalid_bus_status_code' => 17,'invalid_franchise' => 18,'invalid_numeric' => 19,'invalid_sic' => 20,'invalid_naics' => 21,'invalid_loc_employee_code' => 22,'invalid_loc_sales_code' => 23,'invalid_corp_employee_code' => 24,'invalid_year' => 25,'invalid_sq_ft' => 26,'invalid_credit_code' => 27,'invalid_credit_capacity_code' => 28,'invalid_advertising_code' => 29,'invalid_technology_code' => 30,'invalid_office_equip_code' => 31,'invalid_rent_code' => 32,'invalid_telecom_code' => 33,'invalid_accounting_code' => 34,'invalid_bus_insurance_code' => 35,'invalid_legal_code' => 36,'invalid_utilities_code' => 37,'invalid_number_of_pcs_code' => 38,'invalid_month' => 39,'invalid_numeric_blank' => 40,'invalid_ethnic_code' => 41,'invalid_religious_affil' => 42,'invalid_language' => 43,'invalid_time_zone' => 44,'invalid_children_present' => 45,'invalid_home_value' => 46,'invalid_donor_code' => 47,'invalid_home_owner_renter' => 48,'invalid_length_of_res' => 49,'invalid_dwelling_type' => 50,'invalid_income_code' => 51,'invalid_unsec_cap' => 52,'invalid_net_worth' => 53,'invalid_discret_income' => 54,'invalid_marital_status' => 55,'invalid_new_parent' => 56,'invalid_teen_driver' => 57,'invalid_home_sqft_ranges' => 58,'invalid_poli_party_ind' => 59,'invalid_occupation_ind' => 60,'invalid_home_property' => 61,'invalid_education' => 62,0);
 
EXPORT MakeFT_invalid_pastdate(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_pastdate(SALT311.StrType s) := WHICH(~Scrubs_Database_USA.Functions.fn_past_yyyymmdd(s)>0);
EXPORT InValidMessageFT_invalid_pastdate(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Database_USA.Functions.fn_past_yyyymmdd'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_generaldate(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_generaldate(SALT311.StrType s) := WHICH(~Scrubs_Database_USA.Functions.fn_general_date(s)>0);
EXPORT InValidMessageFT_invalid_generaldate(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Database_USA.Functions.fn_general_date'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_record_type(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_record_type(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['C','H']);
EXPORT InValidMessageFT_invalid_record_type(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('C|H'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_ind_frm(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_ind_frm(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['B','D','F','I','P',' ']);
EXPORT InValidMessageFT_invalid_ind_frm(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('B|D|F|I|P| '),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_mandatory(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_mandatory(SALT311.StrType s) := WHICH(~(LENGTH(TRIM(s)) >= 1));
EXPORT InValidMessageFT_invalid_mandatory(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLength('1..'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_gender_code(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_gender_code(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['F','M','U',' ']);
EXPORT InValidMessageFT_invalid_gender_code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('F|M|U| '),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_flag(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_flag(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['Y','1',' ']);
EXPORT InValidMessageFT_invalid_flag(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('Y|1| '),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_exec_type(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_exec_type(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['C','E']);
EXPORT InValidMessageFT_invalid_exec_type(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('C|E'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_st(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_st(SALT311.StrType s) := WHICH(~Scrubs_Database_USA.Functions.fn_verify_state(s)>0);
EXPORT InValidMessageFT_invalid_st(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Database_USA.Functions.fn_verify_state'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_zip5(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_zip5(SALT311.StrType s) := WHICH(~Scrubs_Database_USA.Functions.fn_numeric_or_blank(s)>0);
EXPORT InValidMessageFT_invalid_zip5(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Database_USA.Functions.fn_numeric_or_blank'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_mail_score(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_mail_score(SALT311.StrType s) := WHICH(~Scrubs_Database_USA.Functions.fn_verify_mail_score(s)>0);
EXPORT InValidMessageFT_invalid_mail_score(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Database_USA.Functions.fn_verify_mail_score'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_phone(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_phone(SALT311.StrType s) := WHICH(~Scrubs_Database_USA.Functions.fn_verify_optional_phone(s)>0);
EXPORT InValidMessageFT_invalid_phone(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Database_USA.Functions.fn_verify_optional_phone'),SALT311.HygieneErrors.Good);
 
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
 
EXPORT MakeFT_invalid_indicator(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_indicator(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['1','0']);
EXPORT InValidMessageFT_invalid_indicator(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('1|0'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_url(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_url(SALT311.StrType s) := WHICH(~Scrubs_Database_USA.Functions.fn_url(s)>0);
EXPORT InValidMessageFT_invalid_url(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Database_USA.Functions.fn_url'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_bus_status_code(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_bus_status_code(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['1','2','3',' ']);
EXPORT InValidMessageFT_invalid_bus_status_code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('1|2|3| '),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_franchise(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_franchise(SALT311.StrType s) := WHICH(~Scrubs_Database_USA.Functions.fn_franchise(s)>0);
EXPORT InValidMessageFT_invalid_franchise(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Database_USA.Functions.fn_franchise'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_numeric(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_numeric(SALT311.StrType s) := WHICH(~Scrubs_Database_USA.Functions.fn_numeric(s)>0);
EXPORT InValidMessageFT_invalid_numeric(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Database_USA.Functions.fn_numeric'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_sic(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_sic(SALT311.StrType s) := WHICH(~Scrubs_Database_USA.Functions.fn_sic(s)>0);
EXPORT InValidMessageFT_invalid_sic(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Database_USA.Functions.fn_sic'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_naics(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_naics(SALT311.StrType s) := WHICH(~Scrubs_Database_USA.Functions.fn_naics(s)>0);
EXPORT InValidMessageFT_invalid_naics(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Database_USA.Functions.fn_naics'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_loc_employee_code(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_loc_employee_code(SALT311.StrType s) := WHICH(~Scrubs_Database_USA.Functions.fn_employee_code(s)>0);
EXPORT InValidMessageFT_invalid_loc_employee_code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Database_USA.Functions.fn_employee_code'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_loc_sales_code(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_loc_sales_code(SALT311.StrType s) := WHICH(~Scrubs_Database_USA.Functions.fn_loc_sales_code(s)>0);
EXPORT InValidMessageFT_invalid_loc_sales_code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Database_USA.Functions.fn_loc_sales_code'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_corp_employee_code(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_corp_employee_code(SALT311.StrType s) := WHICH(~Scrubs_Database_USA.Functions.fn_employee_code(s)>0);
EXPORT InValidMessageFT_invalid_corp_employee_code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Database_USA.Functions.fn_employee_code'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_year(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_year(SALT311.StrType s) := WHICH(~Scrubs_Database_USA.Functions.fn_dt_yyyy(s)>0);
EXPORT InValidMessageFT_invalid_year(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Database_USA.Functions.fn_dt_yyyy'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_sq_ft(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_sq_ft(SALT311.StrType s) := WHICH(~Scrubs_Database_USA.Functions.fn_sq_ft(s)>0);
EXPORT InValidMessageFT_invalid_sq_ft(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Database_USA.Functions.fn_sq_ft'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_credit_code(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_credit_code(SALT311.StrType s) := WHICH(~Scrubs_Database_USA.Functions.fn_credit_code(s)>0);
EXPORT InValidMessageFT_invalid_credit_code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Database_USA.Functions.fn_credit_code'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_credit_capacity_code(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_credit_capacity_code(SALT311.StrType s) := WHICH(~Scrubs_Database_USA.Functions.fn_credit_capacity_code(s)>0);
EXPORT InValidMessageFT_invalid_credit_capacity_code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Database_USA.Functions.fn_credit_capacity_code'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_advertising_code(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_advertising_code(SALT311.StrType s) := WHICH(~Scrubs_Database_USA.Functions.fn_advertising_code(s)>0);
EXPORT InValidMessageFT_invalid_advertising_code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Database_USA.Functions.fn_advertising_code'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_technology_code(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_technology_code(SALT311.StrType s) := WHICH(~Scrubs_Database_USA.Functions.fn_technology_code(s)>0);
EXPORT InValidMessageFT_invalid_technology_code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Database_USA.Functions.fn_technology_code'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_office_equip_code(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_office_equip_code(SALT311.StrType s) := WHICH(~Scrubs_Database_USA.Functions.fn_office_equip_code(s)>0);
EXPORT InValidMessageFT_invalid_office_equip_code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Database_USA.Functions.fn_office_equip_code'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_rent_code(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_rent_code(SALT311.StrType s) := WHICH(~Scrubs_Database_USA.Functions.fn_rent_code(s)>0);
EXPORT InValidMessageFT_invalid_rent_code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Database_USA.Functions.fn_rent_code'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_telecom_code(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_telecom_code(SALT311.StrType s) := WHICH(~Scrubs_Database_USA.Functions.fn_telecom_code(s)>0);
EXPORT InValidMessageFT_invalid_telecom_code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Database_USA.Functions.fn_telecom_code'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_accounting_code(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_accounting_code(SALT311.StrType s) := WHICH(~Scrubs_Database_USA.Functions.fn_accounting_code(s)>0);
EXPORT InValidMessageFT_invalid_accounting_code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Database_USA.Functions.fn_accounting_code'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_bus_insurance_code(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_bus_insurance_code(SALT311.StrType s) := WHICH(~Scrubs_Database_USA.Functions.fn_bus_insurance_code(s)>0);
EXPORT InValidMessageFT_invalid_bus_insurance_code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Database_USA.Functions.fn_bus_insurance_code'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_legal_code(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_legal_code(SALT311.StrType s) := WHICH(~Scrubs_Database_USA.Functions.fn_legal_code(s)>0);
EXPORT InValidMessageFT_invalid_legal_code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Database_USA.Functions.fn_legal_code'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_utilities_code(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_utilities_code(SALT311.StrType s) := WHICH(~Scrubs_Database_USA.Functions.fn_utilities_code(s)>0);
EXPORT InValidMessageFT_invalid_utilities_code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Database_USA.Functions.fn_utilities_code'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_number_of_pcs_code(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_number_of_pcs_code(SALT311.StrType s) := WHICH(~Scrubs_Database_USA.Functions.fn_number_of_pcs_code(s)>0);
EXPORT InValidMessageFT_invalid_number_of_pcs_code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Database_USA.Functions.fn_number_of_pcs_code'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_month(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_month(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN [' ','1','2','3','4','5','6','7','8','9','01','02','03','04','05','06','07','08','09','10','11','12']);
EXPORT InValidMessageFT_invalid_month(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum(' |1|2|3|4|5|6|7|8|9|01|02|03|04|05|06|07|08|09|10|11|12'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_numeric_blank(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_numeric_blank(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789 '))));
EXPORT InValidMessageFT_invalid_numeric_blank(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789 '),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_ethnic_code(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_ethnic_code(SALT311.StrType s) := WHICH(~Scrubs_Database_USA.Functions.fn_ethnic_code(s)>0);
EXPORT InValidMessageFT_invalid_ethnic_code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Database_USA.Functions.fn_ethnic_code'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_religious_affil(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_religious_affil(SALT311.StrType s) := WHICH(~Scrubs_Database_USA.Functions.fn_religious_affil(s)>0);
EXPORT InValidMessageFT_invalid_religious_affil(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Database_USA.Functions.fn_religious_affil'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_language(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_language(SALT311.StrType s) := WHICH(~Scrubs_Database_USA.Functions.fn_language(s)>0);
EXPORT InValidMessageFT_invalid_language(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Database_USA.Functions.fn_language'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_time_zone(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_time_zone(SALT311.StrType s) := WHICH(~Scrubs_Database_USA.Functions.fn_time_zone(s)>0);
EXPORT InValidMessageFT_invalid_time_zone(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Database_USA.Functions.fn_time_zone'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_children_present(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_children_present(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['1','N',' ']);
EXPORT InValidMessageFT_invalid_children_present(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('1|N| '),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_home_value(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_home_value(SALT311.StrType s) := WHICH(~Scrubs_Database_USA.Functions.fn_home_value(s)>0);
EXPORT InValidMessageFT_invalid_home_value(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Database_USA.Functions.fn_home_value'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_donor_code(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_donor_code(SALT311.StrType s) := WHICH(~Scrubs_Database_USA.Functions.fn_donor_code(s)>0);
EXPORT InValidMessageFT_invalid_donor_code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Database_USA.Functions.fn_donor_code'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_home_owner_renter(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_home_owner_renter(SALT311.StrType s) := WHICH(~Scrubs_Database_USA.Functions.fn_home_owner_renter(s)>0);
EXPORT InValidMessageFT_invalid_home_owner_renter(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Database_USA.Functions.fn_home_owner_renter'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_length_of_res(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_length_of_res(SALT311.StrType s) := WHICH(~Scrubs_Database_USA.Functions.fn_length_of_res(s)>0);
EXPORT InValidMessageFT_invalid_length_of_res(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Database_USA.Functions.fn_length_of_res'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_dwelling_type(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_dwelling_type(SALT311.StrType s) := WHICH(~Scrubs_Database_USA.Functions.fn_dwelling_type(s)>0);
EXPORT InValidMessageFT_invalid_dwelling_type(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Database_USA.Functions.fn_dwelling_type'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_income_code(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_income_code(SALT311.StrType s) := WHICH(~Scrubs_Database_USA.Functions.fn_income_code(s)>0);
EXPORT InValidMessageFT_invalid_income_code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Database_USA.Functions.fn_income_code'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_unsec_cap(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_unsec_cap(SALT311.StrType s) := WHICH(~Scrubs_Database_USA.Functions.fn_unsec_cap(s)>0);
EXPORT InValidMessageFT_invalid_unsec_cap(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Database_USA.Functions.fn_unsec_cap'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_net_worth(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_net_worth(SALT311.StrType s) := WHICH(~Scrubs_Database_USA.Functions.fn_net_worth(s)>0);
EXPORT InValidMessageFT_invalid_net_worth(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Database_USA.Functions.fn_net_worth'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_discret_income(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_discret_income(SALT311.StrType s) := WHICH(~Scrubs_Database_USA.Functions.fn_discret_income(s)>0);
EXPORT InValidMessageFT_invalid_discret_income(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Database_USA.Functions.fn_discret_income'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_marital_status(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_marital_status(SALT311.StrType s) := WHICH(~Scrubs_Database_USA.Functions.fn_marital_status(s)>0);
EXPORT InValidMessageFT_invalid_marital_status(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Database_USA.Functions.fn_marital_status'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_new_parent(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_new_parent(SALT311.StrType s) := WHICH(~Scrubs_Database_USA.Functions.fn_new_parent(s)>0);
EXPORT InValidMessageFT_invalid_new_parent(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Database_USA.Functions.fn_new_parent'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_teen_driver(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_teen_driver(SALT311.StrType s) := WHICH(~Scrubs_Database_USA.Functions.fn_teen_driver(s)>0);
EXPORT InValidMessageFT_invalid_teen_driver(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Database_USA.Functions.fn_teen_driver'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_home_sqft_ranges(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_home_sqft_ranges(SALT311.StrType s) := WHICH(~Scrubs_Database_USA.Functions.fn_home_sqft_ranges(s)>0);
EXPORT InValidMessageFT_invalid_home_sqft_ranges(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Database_USA.Functions.fn_home_sqft_ranges'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_poli_party_ind(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_poli_party_ind(SALT311.StrType s) := WHICH(~Scrubs_Database_USA.Functions.fn_poli_party_ind(s)>0);
EXPORT InValidMessageFT_invalid_poli_party_ind(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Database_USA.Functions.fn_poli_party_ind'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_occupation_ind(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_occupation_ind(SALT311.StrType s) := WHICH(~Scrubs_Database_USA.Functions.fn_occupation_ind(s)>0);
EXPORT InValidMessageFT_invalid_occupation_ind(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Database_USA.Functions.fn_occupation_ind'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_home_property(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_home_property(SALT311.StrType s) := WHICH(~Scrubs_Database_USA.Functions.fn_home_property(s)>0);
EXPORT InValidMessageFT_invalid_home_property(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Database_USA.Functions.fn_home_property'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_education(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_education(SALT311.StrType s) := WHICH(~Scrubs_Database_USA.Functions.fn_education(s)>0);
EXPORT InValidMessageFT_invalid_education(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Database_USA.Functions.fn_education'),SALT311.HygieneErrors.Good);
 
EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'dt_first_seen','dt_last_seen','dt_vendor_first_reported','dt_vendor_last_reported','process_date','record_type','ind_frm_indicator','company_name','full_name','gender','primary_exec_flag','exec_type','phy_addr_state','phy_addr_zip','mail_addr_state','mail_addr_zip','mail_score','phone','email','email_available_indicator','url','business_status_code','franchise_flag','franchise_type','county_code','primary_sic','sic02','sic03','sic04','sic05','sic06','primarysic2','primarysic4','naics01','naics02','naics03','naics04','naics05','naics06','location_employee_code','location_sales_code','corporate_employee_code','year_established','female_owned','minority_owned_flag','home_based_indicator','small_business_indicator','import_export','manufacturing_location','public_indicator','non_profit_org','square_footage_code','creditcode','credit_capacity_code','advertising_expenses_code','technology_expenses_code','office_equip_expenses_code','rent_expenses_code','telecom_expenses_code','accounting_expenses_code','bus_insurance_expense_code','legal_expenses_code','utilities_expenses_code','number_of_pcs_code','nb_flag','domestic_foreign_owner_flag','db_cons_full_name','db_cons_email','db_cons_gender','db_cons_date_of_birth_year','db_cons_date_of_birth_month','db_cons_age','db_cons_ethnic_code','db_cons_religious_affil','db_cons_language_pref','db_cons_time_zone_code','db_cons_phone','db_cons_dnc','db_cons_scrubbed_phoneable','db_cons_children_present','db_cons_home_value_code','db_cons_donor_capacity_code','db_cons_home_owner_renter','db_cons_length_of_res_code','db_cons_dwelling_type','db_cons_recent_home_buyer','db_cons_income_code','db_cons_unsecuredcredcapcode','db_cons_networthhomevalcode','db_cons_discretincomecode','db_cons_marital_status','db_cons_new_parent','db_cons_child_near_hs_grad','db_cons_college_graduate','db_cons_intend_purchase_veh','db_cons_recent_divorce','db_cons_newlywed','db_cons_new_teen_driver','db_cons_home_year_built','db_cons_home_sqft_ranges','db_cons_poli_party_ind','db_cons_occupation_ind','db_cons_credit_card_user','db_cons_home_property_type','db_cons_education_hh','db_cons_education_ind','db_cons_other_pet_owner');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'dt_first_seen','dt_last_seen','dt_vendor_first_reported','dt_vendor_last_reported','process_date','record_type','ind_frm_indicator','company_name','full_name','gender','primary_exec_flag','exec_type','phy_addr_state','phy_addr_zip','mail_addr_state','mail_addr_zip','mail_score','phone','email','email_available_indicator','url','business_status_code','franchise_flag','franchise_type','county_code','primary_sic','sic02','sic03','sic04','sic05','sic06','primarysic2','primarysic4','naics01','naics02','naics03','naics04','naics05','naics06','location_employee_code','location_sales_code','corporate_employee_code','year_established','female_owned','minority_owned_flag','home_based_indicator','small_business_indicator','import_export','manufacturing_location','public_indicator','non_profit_org','square_footage_code','creditcode','credit_capacity_code','advertising_expenses_code','technology_expenses_code','office_equip_expenses_code','rent_expenses_code','telecom_expenses_code','accounting_expenses_code','bus_insurance_expense_code','legal_expenses_code','utilities_expenses_code','number_of_pcs_code','nb_flag','domestic_foreign_owner_flag','db_cons_full_name','db_cons_email','db_cons_gender','db_cons_date_of_birth_year','db_cons_date_of_birth_month','db_cons_age','db_cons_ethnic_code','db_cons_religious_affil','db_cons_language_pref','db_cons_time_zone_code','db_cons_phone','db_cons_dnc','db_cons_scrubbed_phoneable','db_cons_children_present','db_cons_home_value_code','db_cons_donor_capacity_code','db_cons_home_owner_renter','db_cons_length_of_res_code','db_cons_dwelling_type','db_cons_recent_home_buyer','db_cons_income_code','db_cons_unsecuredcredcapcode','db_cons_networthhomevalcode','db_cons_discretincomecode','db_cons_marital_status','db_cons_new_parent','db_cons_child_near_hs_grad','db_cons_college_graduate','db_cons_intend_purchase_veh','db_cons_recent_divorce','db_cons_newlywed','db_cons_new_teen_driver','db_cons_home_year_built','db_cons_home_sqft_ranges','db_cons_poli_party_ind','db_cons_occupation_ind','db_cons_credit_card_user','db_cons_home_property_type','db_cons_education_hh','db_cons_education_ind','db_cons_other_pet_owner');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'dt_first_seen' => 0,'dt_last_seen' => 1,'dt_vendor_first_reported' => 2,'dt_vendor_last_reported' => 3,'process_date' => 4,'record_type' => 5,'ind_frm_indicator' => 6,'company_name' => 7,'full_name' => 8,'gender' => 9,'primary_exec_flag' => 10,'exec_type' => 11,'phy_addr_state' => 12,'phy_addr_zip' => 13,'mail_addr_state' => 14,'mail_addr_zip' => 15,'mail_score' => 16,'phone' => 17,'email' => 18,'email_available_indicator' => 19,'url' => 20,'business_status_code' => 21,'franchise_flag' => 22,'franchise_type' => 23,'county_code' => 24,'primary_sic' => 25,'sic02' => 26,'sic03' => 27,'sic04' => 28,'sic05' => 29,'sic06' => 30,'primarysic2' => 31,'primarysic4' => 32,'naics01' => 33,'naics02' => 34,'naics03' => 35,'naics04' => 36,'naics05' => 37,'naics06' => 38,'location_employee_code' => 39,'location_sales_code' => 40,'corporate_employee_code' => 41,'year_established' => 42,'female_owned' => 43,'minority_owned_flag' => 44,'home_based_indicator' => 45,'small_business_indicator' => 46,'import_export' => 47,'manufacturing_location' => 48,'public_indicator' => 49,'non_profit_org' => 50,'square_footage_code' => 51,'creditcode' => 52,'credit_capacity_code' => 53,'advertising_expenses_code' => 54,'technology_expenses_code' => 55,'office_equip_expenses_code' => 56,'rent_expenses_code' => 57,'telecom_expenses_code' => 58,'accounting_expenses_code' => 59,'bus_insurance_expense_code' => 60,'legal_expenses_code' => 61,'utilities_expenses_code' => 62,'number_of_pcs_code' => 63,'nb_flag' => 64,'domestic_foreign_owner_flag' => 65,'db_cons_full_name' => 66,'db_cons_email' => 67,'db_cons_gender' => 68,'db_cons_date_of_birth_year' => 69,'db_cons_date_of_birth_month' => 70,'db_cons_age' => 71,'db_cons_ethnic_code' => 72,'db_cons_religious_affil' => 73,'db_cons_language_pref' => 74,'db_cons_time_zone_code' => 75,'db_cons_phone' => 76,'db_cons_dnc' => 77,'db_cons_scrubbed_phoneable' => 78,'db_cons_children_present' => 79,'db_cons_home_value_code' => 80,'db_cons_donor_capacity_code' => 81,'db_cons_home_owner_renter' => 82,'db_cons_length_of_res_code' => 83,'db_cons_dwelling_type' => 84,'db_cons_recent_home_buyer' => 85,'db_cons_income_code' => 86,'db_cons_unsecuredcredcapcode' => 87,'db_cons_networthhomevalcode' => 88,'db_cons_discretincomecode' => 89,'db_cons_marital_status' => 90,'db_cons_new_parent' => 91,'db_cons_child_near_hs_grad' => 92,'db_cons_college_graduate' => 93,'db_cons_intend_purchase_veh' => 94,'db_cons_recent_divorce' => 95,'db_cons_newlywed' => 96,'db_cons_new_teen_driver' => 97,'db_cons_home_year_built' => 98,'db_cons_home_sqft_ranges' => 99,'db_cons_poli_party_ind' => 100,'db_cons_occupation_ind' => 101,'db_cons_credit_card_user' => 102,'db_cons_home_property_type' => 103,'db_cons_education_hh' => 104,'db_cons_education_ind' => 105,'db_cons_other_pet_owner' => 106,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['ENUM'],['ENUM'],['LENGTHS'],['LENGTHS'],['ENUM'],['ENUM'],['ENUM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['ALLOW'],['ENUM'],['CUSTOM'],['ENUM'],['ENUM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['ENUM'],['ENUM'],['ENUM'],['ENUM'],['ENUM'],['ENUM'],['ENUM'],['ENUM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['ENUM'],['ENUM'],['LENGTHS'],['ALLOW'],['ENUM'],['CUSTOM'],['ENUM'],['ALLOW'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['ENUM'],['ENUM'],['ENUM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['ENUM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['ENUM'],['ENUM'],['ENUM'],['ENUM'],['ENUM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['ENUM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['ENUM'],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_dt_first_seen(SALT311.StrType s0) := MakeFT_invalid_pastdate(s0);
EXPORT InValid_dt_first_seen(SALT311.StrType s) := InValidFT_invalid_pastdate(s);
EXPORT InValidMessage_dt_first_seen(UNSIGNED1 wh) := InValidMessageFT_invalid_pastdate(wh);
 
EXPORT Make_dt_last_seen(SALT311.StrType s0) := MakeFT_invalid_pastdate(s0);
EXPORT InValid_dt_last_seen(SALT311.StrType s) := InValidFT_invalid_pastdate(s);
EXPORT InValidMessage_dt_last_seen(UNSIGNED1 wh) := InValidMessageFT_invalid_pastdate(wh);
 
EXPORT Make_dt_vendor_first_reported(SALT311.StrType s0) := MakeFT_invalid_pastdate(s0);
EXPORT InValid_dt_vendor_first_reported(SALT311.StrType s) := InValidFT_invalid_pastdate(s);
EXPORT InValidMessage_dt_vendor_first_reported(UNSIGNED1 wh) := InValidMessageFT_invalid_pastdate(wh);
 
EXPORT Make_dt_vendor_last_reported(SALT311.StrType s0) := MakeFT_invalid_pastdate(s0);
EXPORT InValid_dt_vendor_last_reported(SALT311.StrType s) := InValidFT_invalid_pastdate(s);
EXPORT InValidMessage_dt_vendor_last_reported(UNSIGNED1 wh) := InValidMessageFT_invalid_pastdate(wh);
 
EXPORT Make_process_date(SALT311.StrType s0) := MakeFT_invalid_generaldate(s0);
EXPORT InValid_process_date(SALT311.StrType s) := InValidFT_invalid_generaldate(s);
EXPORT InValidMessage_process_date(UNSIGNED1 wh) := InValidMessageFT_invalid_generaldate(wh);
 
EXPORT Make_record_type(SALT311.StrType s0) := MakeFT_invalid_record_type(s0);
EXPORT InValid_record_type(SALT311.StrType s) := InValidFT_invalid_record_type(s);
EXPORT InValidMessage_record_type(UNSIGNED1 wh) := InValidMessageFT_invalid_record_type(wh);
 
EXPORT Make_ind_frm_indicator(SALT311.StrType s0) := MakeFT_invalid_ind_frm(s0);
EXPORT InValid_ind_frm_indicator(SALT311.StrType s) := InValidFT_invalid_ind_frm(s);
EXPORT InValidMessage_ind_frm_indicator(UNSIGNED1 wh) := InValidMessageFT_invalid_ind_frm(wh);
 
EXPORT Make_company_name(SALT311.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_company_name(SALT311.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_company_name(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_full_name(SALT311.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_full_name(SALT311.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_full_name(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_gender(SALT311.StrType s0) := MakeFT_invalid_gender_code(s0);
EXPORT InValid_gender(SALT311.StrType s) := InValidFT_invalid_gender_code(s);
EXPORT InValidMessage_gender(UNSIGNED1 wh) := InValidMessageFT_invalid_gender_code(wh);
 
EXPORT Make_primary_exec_flag(SALT311.StrType s0) := MakeFT_invalid_flag(s0);
EXPORT InValid_primary_exec_flag(SALT311.StrType s) := InValidFT_invalid_flag(s);
EXPORT InValidMessage_primary_exec_flag(UNSIGNED1 wh) := InValidMessageFT_invalid_flag(wh);
 
EXPORT Make_exec_type(SALT311.StrType s0) := MakeFT_invalid_exec_type(s0);
EXPORT InValid_exec_type(SALT311.StrType s) := InValidFT_invalid_exec_type(s);
EXPORT InValidMessage_exec_type(UNSIGNED1 wh) := InValidMessageFT_invalid_exec_type(wh);
 
EXPORT Make_phy_addr_state(SALT311.StrType s0) := MakeFT_invalid_st(s0);
EXPORT InValid_phy_addr_state(SALT311.StrType s) := InValidFT_invalid_st(s);
EXPORT InValidMessage_phy_addr_state(UNSIGNED1 wh) := InValidMessageFT_invalid_st(wh);
 
EXPORT Make_phy_addr_zip(SALT311.StrType s0) := MakeFT_invalid_zip5(s0);
EXPORT InValid_phy_addr_zip(SALT311.StrType s) := InValidFT_invalid_zip5(s);
EXPORT InValidMessage_phy_addr_zip(UNSIGNED1 wh) := InValidMessageFT_invalid_zip5(wh);
 
EXPORT Make_mail_addr_state(SALT311.StrType s0) := MakeFT_invalid_st(s0);
EXPORT InValid_mail_addr_state(SALT311.StrType s) := InValidFT_invalid_st(s);
EXPORT InValidMessage_mail_addr_state(UNSIGNED1 wh) := InValidMessageFT_invalid_st(wh);
 
EXPORT Make_mail_addr_zip(SALT311.StrType s0) := MakeFT_invalid_zip5(s0);
EXPORT InValid_mail_addr_zip(SALT311.StrType s) := InValidFT_invalid_zip5(s);
EXPORT InValidMessage_mail_addr_zip(UNSIGNED1 wh) := InValidMessageFT_invalid_zip5(wh);
 
EXPORT Make_mail_score(SALT311.StrType s0) := MakeFT_invalid_mail_score(s0);
EXPORT InValid_mail_score(SALT311.StrType s) := InValidFT_invalid_mail_score(s);
EXPORT InValidMessage_mail_score(UNSIGNED1 wh) := InValidMessageFT_invalid_mail_score(wh);
 
EXPORT Make_phone(SALT311.StrType s0) := MakeFT_invalid_phone(s0);
EXPORT InValid_phone(SALT311.StrType s) := InValidFT_invalid_phone(s);
EXPORT InValidMessage_phone(UNSIGNED1 wh) := InValidMessageFT_invalid_phone(wh);
 
EXPORT Make_email(SALT311.StrType s0) := MakeFT_invalid_email(s0);
EXPORT InValid_email(SALT311.StrType s) := InValidFT_invalid_email(s);
EXPORT InValidMessage_email(UNSIGNED1 wh) := InValidMessageFT_invalid_email(wh);
 
EXPORT Make_email_available_indicator(SALT311.StrType s0) := MakeFT_invalid_email_indicator(s0);
EXPORT InValid_email_available_indicator(SALT311.StrType s) := InValidFT_invalid_email_indicator(s);
EXPORT InValidMessage_email_available_indicator(UNSIGNED1 wh) := InValidMessageFT_invalid_email_indicator(wh);
 
EXPORT Make_url(SALT311.StrType s0) := MakeFT_invalid_url(s0);
EXPORT InValid_url(SALT311.StrType s) := InValidFT_invalid_url(s);
EXPORT InValidMessage_url(UNSIGNED1 wh) := InValidMessageFT_invalid_url(wh);
 
EXPORT Make_business_status_code(SALT311.StrType s0) := MakeFT_invalid_bus_status_code(s0);
EXPORT InValid_business_status_code(SALT311.StrType s) := InValidFT_invalid_bus_status_code(s);
EXPORT InValidMessage_business_status_code(UNSIGNED1 wh) := InValidMessageFT_invalid_bus_status_code(wh);
 
EXPORT Make_franchise_flag(SALT311.StrType s0) := MakeFT_invalid_flag(s0);
EXPORT InValid_franchise_flag(SALT311.StrType s) := InValidFT_invalid_flag(s);
EXPORT InValidMessage_franchise_flag(UNSIGNED1 wh) := InValidMessageFT_invalid_flag(wh);
 
EXPORT Make_franchise_type(SALT311.StrType s0) := MakeFT_invalid_franchise(s0);
EXPORT InValid_franchise_type(SALT311.StrType s) := InValidFT_invalid_franchise(s);
EXPORT InValidMessage_franchise_type(UNSIGNED1 wh) := InValidMessageFT_invalid_franchise(wh);
 
EXPORT Make_county_code(SALT311.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_county_code(SALT311.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_county_code(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_primary_sic(SALT311.StrType s0) := MakeFT_invalid_sic(s0);
EXPORT InValid_primary_sic(SALT311.StrType s) := InValidFT_invalid_sic(s);
EXPORT InValidMessage_primary_sic(UNSIGNED1 wh) := InValidMessageFT_invalid_sic(wh);
 
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
 
EXPORT Make_primarysic2(SALT311.StrType s0) := MakeFT_invalid_sic(s0);
EXPORT InValid_primarysic2(SALT311.StrType s) := InValidFT_invalid_sic(s);
EXPORT InValidMessage_primarysic2(UNSIGNED1 wh) := InValidMessageFT_invalid_sic(wh);
 
EXPORT Make_primarysic4(SALT311.StrType s0) := MakeFT_invalid_sic(s0);
EXPORT InValid_primarysic4(SALT311.StrType s) := InValidFT_invalid_sic(s);
EXPORT InValidMessage_primarysic4(UNSIGNED1 wh) := InValidMessageFT_invalid_sic(wh);
 
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
 
EXPORT Make_location_employee_code(SALT311.StrType s0) := MakeFT_invalid_loc_employee_code(s0);
EXPORT InValid_location_employee_code(SALT311.StrType s) := InValidFT_invalid_loc_employee_code(s);
EXPORT InValidMessage_location_employee_code(UNSIGNED1 wh) := InValidMessageFT_invalid_loc_employee_code(wh);
 
EXPORT Make_location_sales_code(SALT311.StrType s0) := MakeFT_invalid_loc_sales_code(s0);
EXPORT InValid_location_sales_code(SALT311.StrType s) := InValidFT_invalid_loc_sales_code(s);
EXPORT InValidMessage_location_sales_code(UNSIGNED1 wh) := InValidMessageFT_invalid_loc_sales_code(wh);
 
EXPORT Make_corporate_employee_code(SALT311.StrType s0) := MakeFT_invalid_corp_employee_code(s0);
EXPORT InValid_corporate_employee_code(SALT311.StrType s) := InValidFT_invalid_corp_employee_code(s);
EXPORT InValidMessage_corporate_employee_code(UNSIGNED1 wh) := InValidMessageFT_invalid_corp_employee_code(wh);
 
EXPORT Make_year_established(SALT311.StrType s0) := MakeFT_invalid_year(s0);
EXPORT InValid_year_established(SALT311.StrType s) := InValidFT_invalid_year(s);
EXPORT InValidMessage_year_established(UNSIGNED1 wh) := InValidMessageFT_invalid_year(wh);
 
EXPORT Make_female_owned(SALT311.StrType s0) := MakeFT_invalid_flag(s0);
EXPORT InValid_female_owned(SALT311.StrType s) := InValidFT_invalid_flag(s);
EXPORT InValidMessage_female_owned(UNSIGNED1 wh) := InValidMessageFT_invalid_flag(wh);
 
EXPORT Make_minority_owned_flag(SALT311.StrType s0) := MakeFT_invalid_flag(s0);
EXPORT InValid_minority_owned_flag(SALT311.StrType s) := InValidFT_invalid_flag(s);
EXPORT InValidMessage_minority_owned_flag(UNSIGNED1 wh) := InValidMessageFT_invalid_flag(wh);
 
EXPORT Make_home_based_indicator(SALT311.StrType s0) := MakeFT_invalid_flag(s0);
EXPORT InValid_home_based_indicator(SALT311.StrType s) := InValidFT_invalid_flag(s);
EXPORT InValidMessage_home_based_indicator(UNSIGNED1 wh) := InValidMessageFT_invalid_flag(wh);
 
EXPORT Make_small_business_indicator(SALT311.StrType s0) := MakeFT_invalid_flag(s0);
EXPORT InValid_small_business_indicator(SALT311.StrType s) := InValidFT_invalid_flag(s);
EXPORT InValidMessage_small_business_indicator(UNSIGNED1 wh) := InValidMessageFT_invalid_flag(wh);
 
EXPORT Make_import_export(SALT311.StrType s0) := MakeFT_invalid_flag(s0);
EXPORT InValid_import_export(SALT311.StrType s) := InValidFT_invalid_flag(s);
EXPORT InValidMessage_import_export(UNSIGNED1 wh) := InValidMessageFT_invalid_flag(wh);
 
EXPORT Make_manufacturing_location(SALT311.StrType s0) := MakeFT_invalid_flag(s0);
EXPORT InValid_manufacturing_location(SALT311.StrType s) := InValidFT_invalid_flag(s);
EXPORT InValidMessage_manufacturing_location(UNSIGNED1 wh) := InValidMessageFT_invalid_flag(wh);
 
EXPORT Make_public_indicator(SALT311.StrType s0) := MakeFT_invalid_flag(s0);
EXPORT InValid_public_indicator(SALT311.StrType s) := InValidFT_invalid_flag(s);
EXPORT InValidMessage_public_indicator(UNSIGNED1 wh) := InValidMessageFT_invalid_flag(wh);
 
EXPORT Make_non_profit_org(SALT311.StrType s0) := MakeFT_invalid_flag(s0);
EXPORT InValid_non_profit_org(SALT311.StrType s) := InValidFT_invalid_flag(s);
EXPORT InValidMessage_non_profit_org(UNSIGNED1 wh) := InValidMessageFT_invalid_flag(wh);
 
EXPORT Make_square_footage_code(SALT311.StrType s0) := MakeFT_invalid_sq_ft(s0);
EXPORT InValid_square_footage_code(SALT311.StrType s) := InValidFT_invalid_sq_ft(s);
EXPORT InValidMessage_square_footage_code(UNSIGNED1 wh) := InValidMessageFT_invalid_sq_ft(wh);
 
EXPORT Make_creditcode(SALT311.StrType s0) := MakeFT_invalid_credit_code(s0);
EXPORT InValid_creditcode(SALT311.StrType s) := InValidFT_invalid_credit_code(s);
EXPORT InValidMessage_creditcode(UNSIGNED1 wh) := InValidMessageFT_invalid_credit_code(wh);
 
EXPORT Make_credit_capacity_code(SALT311.StrType s0) := MakeFT_invalid_credit_capacity_code(s0);
EXPORT InValid_credit_capacity_code(SALT311.StrType s) := InValidFT_invalid_credit_capacity_code(s);
EXPORT InValidMessage_credit_capacity_code(UNSIGNED1 wh) := InValidMessageFT_invalid_credit_capacity_code(wh);
 
EXPORT Make_advertising_expenses_code(SALT311.StrType s0) := MakeFT_invalid_advertising_code(s0);
EXPORT InValid_advertising_expenses_code(SALT311.StrType s) := InValidFT_invalid_advertising_code(s);
EXPORT InValidMessage_advertising_expenses_code(UNSIGNED1 wh) := InValidMessageFT_invalid_advertising_code(wh);
 
EXPORT Make_technology_expenses_code(SALT311.StrType s0) := MakeFT_invalid_technology_code(s0);
EXPORT InValid_technology_expenses_code(SALT311.StrType s) := InValidFT_invalid_technology_code(s);
EXPORT InValidMessage_technology_expenses_code(UNSIGNED1 wh) := InValidMessageFT_invalid_technology_code(wh);
 
EXPORT Make_office_equip_expenses_code(SALT311.StrType s0) := MakeFT_invalid_office_equip_code(s0);
EXPORT InValid_office_equip_expenses_code(SALT311.StrType s) := InValidFT_invalid_office_equip_code(s);
EXPORT InValidMessage_office_equip_expenses_code(UNSIGNED1 wh) := InValidMessageFT_invalid_office_equip_code(wh);
 
EXPORT Make_rent_expenses_code(SALT311.StrType s0) := MakeFT_invalid_rent_code(s0);
EXPORT InValid_rent_expenses_code(SALT311.StrType s) := InValidFT_invalid_rent_code(s);
EXPORT InValidMessage_rent_expenses_code(UNSIGNED1 wh) := InValidMessageFT_invalid_rent_code(wh);
 
EXPORT Make_telecom_expenses_code(SALT311.StrType s0) := MakeFT_invalid_telecom_code(s0);
EXPORT InValid_telecom_expenses_code(SALT311.StrType s) := InValidFT_invalid_telecom_code(s);
EXPORT InValidMessage_telecom_expenses_code(UNSIGNED1 wh) := InValidMessageFT_invalid_telecom_code(wh);
 
EXPORT Make_accounting_expenses_code(SALT311.StrType s0) := MakeFT_invalid_accounting_code(s0);
EXPORT InValid_accounting_expenses_code(SALT311.StrType s) := InValidFT_invalid_accounting_code(s);
EXPORT InValidMessage_accounting_expenses_code(UNSIGNED1 wh) := InValidMessageFT_invalid_accounting_code(wh);
 
EXPORT Make_bus_insurance_expense_code(SALT311.StrType s0) := MakeFT_invalid_bus_insurance_code(s0);
EXPORT InValid_bus_insurance_expense_code(SALT311.StrType s) := InValidFT_invalid_bus_insurance_code(s);
EXPORT InValidMessage_bus_insurance_expense_code(UNSIGNED1 wh) := InValidMessageFT_invalid_bus_insurance_code(wh);
 
EXPORT Make_legal_expenses_code(SALT311.StrType s0) := MakeFT_invalid_legal_code(s0);
EXPORT InValid_legal_expenses_code(SALT311.StrType s) := InValidFT_invalid_legal_code(s);
EXPORT InValidMessage_legal_expenses_code(UNSIGNED1 wh) := InValidMessageFT_invalid_legal_code(wh);
 
EXPORT Make_utilities_expenses_code(SALT311.StrType s0) := MakeFT_invalid_utilities_code(s0);
EXPORT InValid_utilities_expenses_code(SALT311.StrType s) := InValidFT_invalid_utilities_code(s);
EXPORT InValidMessage_utilities_expenses_code(UNSIGNED1 wh) := InValidMessageFT_invalid_utilities_code(wh);
 
EXPORT Make_number_of_pcs_code(SALT311.StrType s0) := MakeFT_invalid_number_of_pcs_code(s0);
EXPORT InValid_number_of_pcs_code(SALT311.StrType s) := InValidFT_invalid_number_of_pcs_code(s);
EXPORT InValidMessage_number_of_pcs_code(UNSIGNED1 wh) := InValidMessageFT_invalid_number_of_pcs_code(wh);
 
EXPORT Make_nb_flag(SALT311.StrType s0) := MakeFT_invalid_flag(s0);
EXPORT InValid_nb_flag(SALT311.StrType s) := InValidFT_invalid_flag(s);
EXPORT InValidMessage_nb_flag(UNSIGNED1 wh) := InValidMessageFT_invalid_flag(wh);
 
EXPORT Make_domestic_foreign_owner_flag(SALT311.StrType s0) := MakeFT_invalid_flag(s0);
EXPORT InValid_domestic_foreign_owner_flag(SALT311.StrType s) := InValidFT_invalid_flag(s);
EXPORT InValidMessage_domestic_foreign_owner_flag(UNSIGNED1 wh) := InValidMessageFT_invalid_flag(wh);
 
EXPORT Make_db_cons_full_name(SALT311.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_db_cons_full_name(SALT311.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_db_cons_full_name(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_db_cons_email(SALT311.StrType s0) := MakeFT_invalid_email(s0);
EXPORT InValid_db_cons_email(SALT311.StrType s) := InValidFT_invalid_email(s);
EXPORT InValidMessage_db_cons_email(UNSIGNED1 wh) := InValidMessageFT_invalid_email(wh);
 
EXPORT Make_db_cons_gender(SALT311.StrType s0) := MakeFT_invalid_gender_code(s0);
EXPORT InValid_db_cons_gender(SALT311.StrType s) := InValidFT_invalid_gender_code(s);
EXPORT InValidMessage_db_cons_gender(UNSIGNED1 wh) := InValidMessageFT_invalid_gender_code(wh);
 
EXPORT Make_db_cons_date_of_birth_year(SALT311.StrType s0) := MakeFT_invalid_year(s0);
EXPORT InValid_db_cons_date_of_birth_year(SALT311.StrType s) := InValidFT_invalid_year(s);
EXPORT InValidMessage_db_cons_date_of_birth_year(UNSIGNED1 wh) := InValidMessageFT_invalid_year(wh);
 
EXPORT Make_db_cons_date_of_birth_month(SALT311.StrType s0) := MakeFT_invalid_month(s0);
EXPORT InValid_db_cons_date_of_birth_month(SALT311.StrType s) := InValidFT_invalid_month(s);
EXPORT InValidMessage_db_cons_date_of_birth_month(UNSIGNED1 wh) := InValidMessageFT_invalid_month(wh);
 
EXPORT Make_db_cons_age(SALT311.StrType s0) := MakeFT_invalid_numeric_blank(s0);
EXPORT InValid_db_cons_age(SALT311.StrType s) := InValidFT_invalid_numeric_blank(s);
EXPORT InValidMessage_db_cons_age(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric_blank(wh);
 
EXPORT Make_db_cons_ethnic_code(SALT311.StrType s0) := MakeFT_invalid_ethnic_code(s0);
EXPORT InValid_db_cons_ethnic_code(SALT311.StrType s) := InValidFT_invalid_ethnic_code(s);
EXPORT InValidMessage_db_cons_ethnic_code(UNSIGNED1 wh) := InValidMessageFT_invalid_ethnic_code(wh);
 
EXPORT Make_db_cons_religious_affil(SALT311.StrType s0) := MakeFT_invalid_religious_affil(s0);
EXPORT InValid_db_cons_religious_affil(SALT311.StrType s) := InValidFT_invalid_religious_affil(s);
EXPORT InValidMessage_db_cons_religious_affil(UNSIGNED1 wh) := InValidMessageFT_invalid_religious_affil(wh);
 
EXPORT Make_db_cons_language_pref(SALT311.StrType s0) := MakeFT_invalid_language(s0);
EXPORT InValid_db_cons_language_pref(SALT311.StrType s) := InValidFT_invalid_language(s);
EXPORT InValidMessage_db_cons_language_pref(UNSIGNED1 wh) := InValidMessageFT_invalid_language(wh);
 
EXPORT Make_db_cons_time_zone_code(SALT311.StrType s0) := MakeFT_invalid_time_zone(s0);
EXPORT InValid_db_cons_time_zone_code(SALT311.StrType s) := InValidFT_invalid_time_zone(s);
EXPORT InValidMessage_db_cons_time_zone_code(UNSIGNED1 wh) := InValidMessageFT_invalid_time_zone(wh);
 
EXPORT Make_db_cons_phone(SALT311.StrType s0) := MakeFT_invalid_phone(s0);
EXPORT InValid_db_cons_phone(SALT311.StrType s) := InValidFT_invalid_phone(s);
EXPORT InValidMessage_db_cons_phone(UNSIGNED1 wh) := InValidMessageFT_invalid_phone(wh);
 
EXPORT Make_db_cons_dnc(SALT311.StrType s0) := MakeFT_invalid_flag(s0);
EXPORT InValid_db_cons_dnc(SALT311.StrType s) := InValidFT_invalid_flag(s);
EXPORT InValidMessage_db_cons_dnc(UNSIGNED1 wh) := InValidMessageFT_invalid_flag(wh);
 
EXPORT Make_db_cons_scrubbed_phoneable(SALT311.StrType s0) := MakeFT_invalid_flag(s0);
EXPORT InValid_db_cons_scrubbed_phoneable(SALT311.StrType s) := InValidFT_invalid_flag(s);
EXPORT InValidMessage_db_cons_scrubbed_phoneable(UNSIGNED1 wh) := InValidMessageFT_invalid_flag(wh);
 
EXPORT Make_db_cons_children_present(SALT311.StrType s0) := MakeFT_invalid_children_present(s0);
EXPORT InValid_db_cons_children_present(SALT311.StrType s) := InValidFT_invalid_children_present(s);
EXPORT InValidMessage_db_cons_children_present(UNSIGNED1 wh) := InValidMessageFT_invalid_children_present(wh);
 
EXPORT Make_db_cons_home_value_code(SALT311.StrType s0) := MakeFT_invalid_home_value(s0);
EXPORT InValid_db_cons_home_value_code(SALT311.StrType s) := InValidFT_invalid_home_value(s);
EXPORT InValidMessage_db_cons_home_value_code(UNSIGNED1 wh) := InValidMessageFT_invalid_home_value(wh);
 
EXPORT Make_db_cons_donor_capacity_code(SALT311.StrType s0) := MakeFT_invalid_donor_code(s0);
EXPORT InValid_db_cons_donor_capacity_code(SALT311.StrType s) := InValidFT_invalid_donor_code(s);
EXPORT InValidMessage_db_cons_donor_capacity_code(UNSIGNED1 wh) := InValidMessageFT_invalid_donor_code(wh);
 
EXPORT Make_db_cons_home_owner_renter(SALT311.StrType s0) := MakeFT_invalid_home_owner_renter(s0);
EXPORT InValid_db_cons_home_owner_renter(SALT311.StrType s) := InValidFT_invalid_home_owner_renter(s);
EXPORT InValidMessage_db_cons_home_owner_renter(UNSIGNED1 wh) := InValidMessageFT_invalid_home_owner_renter(wh);
 
EXPORT Make_db_cons_length_of_res_code(SALT311.StrType s0) := MakeFT_invalid_length_of_res(s0);
EXPORT InValid_db_cons_length_of_res_code(SALT311.StrType s) := InValidFT_invalid_length_of_res(s);
EXPORT InValidMessage_db_cons_length_of_res_code(UNSIGNED1 wh) := InValidMessageFT_invalid_length_of_res(wh);
 
EXPORT Make_db_cons_dwelling_type(SALT311.StrType s0) := MakeFT_invalid_dwelling_type(s0);
EXPORT InValid_db_cons_dwelling_type(SALT311.StrType s) := InValidFT_invalid_dwelling_type(s);
EXPORT InValidMessage_db_cons_dwelling_type(UNSIGNED1 wh) := InValidMessageFT_invalid_dwelling_type(wh);
 
EXPORT Make_db_cons_recent_home_buyer(SALT311.StrType s0) := MakeFT_invalid_flag(s0);
EXPORT InValid_db_cons_recent_home_buyer(SALT311.StrType s) := InValidFT_invalid_flag(s);
EXPORT InValidMessage_db_cons_recent_home_buyer(UNSIGNED1 wh) := InValidMessageFT_invalid_flag(wh);
 
EXPORT Make_db_cons_income_code(SALT311.StrType s0) := MakeFT_invalid_income_code(s0);
EXPORT InValid_db_cons_income_code(SALT311.StrType s) := InValidFT_invalid_income_code(s);
EXPORT InValidMessage_db_cons_income_code(UNSIGNED1 wh) := InValidMessageFT_invalid_income_code(wh);
 
EXPORT Make_db_cons_unsecuredcredcapcode(SALT311.StrType s0) := MakeFT_invalid_unsec_cap(s0);
EXPORT InValid_db_cons_unsecuredcredcapcode(SALT311.StrType s) := InValidFT_invalid_unsec_cap(s);
EXPORT InValidMessage_db_cons_unsecuredcredcapcode(UNSIGNED1 wh) := InValidMessageFT_invalid_unsec_cap(wh);
 
EXPORT Make_db_cons_networthhomevalcode(SALT311.StrType s0) := MakeFT_invalid_net_worth(s0);
EXPORT InValid_db_cons_networthhomevalcode(SALT311.StrType s) := InValidFT_invalid_net_worth(s);
EXPORT InValidMessage_db_cons_networthhomevalcode(UNSIGNED1 wh) := InValidMessageFT_invalid_net_worth(wh);
 
EXPORT Make_db_cons_discretincomecode(SALT311.StrType s0) := MakeFT_invalid_discret_income(s0);
EXPORT InValid_db_cons_discretincomecode(SALT311.StrType s) := InValidFT_invalid_discret_income(s);
EXPORT InValidMessage_db_cons_discretincomecode(UNSIGNED1 wh) := InValidMessageFT_invalid_discret_income(wh);
 
EXPORT Make_db_cons_marital_status(SALT311.StrType s0) := MakeFT_invalid_marital_status(s0);
EXPORT InValid_db_cons_marital_status(SALT311.StrType s) := InValidFT_invalid_marital_status(s);
EXPORT InValidMessage_db_cons_marital_status(UNSIGNED1 wh) := InValidMessageFT_invalid_marital_status(wh);
 
EXPORT Make_db_cons_new_parent(SALT311.StrType s0) := MakeFT_invalid_new_parent(s0);
EXPORT InValid_db_cons_new_parent(SALT311.StrType s) := InValidFT_invalid_new_parent(s);
EXPORT InValidMessage_db_cons_new_parent(UNSIGNED1 wh) := InValidMessageFT_invalid_new_parent(wh);
 
EXPORT Make_db_cons_child_near_hs_grad(SALT311.StrType s0) := MakeFT_invalid_flag(s0);
EXPORT InValid_db_cons_child_near_hs_grad(SALT311.StrType s) := InValidFT_invalid_flag(s);
EXPORT InValidMessage_db_cons_child_near_hs_grad(UNSIGNED1 wh) := InValidMessageFT_invalid_flag(wh);
 
EXPORT Make_db_cons_college_graduate(SALT311.StrType s0) := MakeFT_invalid_flag(s0);
EXPORT InValid_db_cons_college_graduate(SALT311.StrType s) := InValidFT_invalid_flag(s);
EXPORT InValidMessage_db_cons_college_graduate(UNSIGNED1 wh) := InValidMessageFT_invalid_flag(wh);
 
EXPORT Make_db_cons_intend_purchase_veh(SALT311.StrType s0) := MakeFT_invalid_flag(s0);
EXPORT InValid_db_cons_intend_purchase_veh(SALT311.StrType s) := InValidFT_invalid_flag(s);
EXPORT InValidMessage_db_cons_intend_purchase_veh(UNSIGNED1 wh) := InValidMessageFT_invalid_flag(wh);
 
EXPORT Make_db_cons_recent_divorce(SALT311.StrType s0) := MakeFT_invalid_flag(s0);
EXPORT InValid_db_cons_recent_divorce(SALT311.StrType s) := InValidFT_invalid_flag(s);
EXPORT InValidMessage_db_cons_recent_divorce(UNSIGNED1 wh) := InValidMessageFT_invalid_flag(wh);
 
EXPORT Make_db_cons_newlywed(SALT311.StrType s0) := MakeFT_invalid_flag(s0);
EXPORT InValid_db_cons_newlywed(SALT311.StrType s) := InValidFT_invalid_flag(s);
EXPORT InValidMessage_db_cons_newlywed(UNSIGNED1 wh) := InValidMessageFT_invalid_flag(wh);
 
EXPORT Make_db_cons_new_teen_driver(SALT311.StrType s0) := MakeFT_invalid_teen_driver(s0);
EXPORT InValid_db_cons_new_teen_driver(SALT311.StrType s) := InValidFT_invalid_teen_driver(s);
EXPORT InValidMessage_db_cons_new_teen_driver(UNSIGNED1 wh) := InValidMessageFT_invalid_teen_driver(wh);
 
EXPORT Make_db_cons_home_year_built(SALT311.StrType s0) := MakeFT_invalid_year(s0);
EXPORT InValid_db_cons_home_year_built(SALT311.StrType s) := InValidFT_invalid_year(s);
EXPORT InValidMessage_db_cons_home_year_built(UNSIGNED1 wh) := InValidMessageFT_invalid_year(wh);
 
EXPORT Make_db_cons_home_sqft_ranges(SALT311.StrType s0) := MakeFT_invalid_home_sqft_ranges(s0);
EXPORT InValid_db_cons_home_sqft_ranges(SALT311.StrType s) := InValidFT_invalid_home_sqft_ranges(s);
EXPORT InValidMessage_db_cons_home_sqft_ranges(UNSIGNED1 wh) := InValidMessageFT_invalid_home_sqft_ranges(wh);
 
EXPORT Make_db_cons_poli_party_ind(SALT311.StrType s0) := MakeFT_invalid_poli_party_ind(s0);
EXPORT InValid_db_cons_poli_party_ind(SALT311.StrType s) := InValidFT_invalid_poli_party_ind(s);
EXPORT InValidMessage_db_cons_poli_party_ind(UNSIGNED1 wh) := InValidMessageFT_invalid_poli_party_ind(wh);
 
EXPORT Make_db_cons_occupation_ind(SALT311.StrType s0) := MakeFT_invalid_occupation_ind(s0);
EXPORT InValid_db_cons_occupation_ind(SALT311.StrType s) := InValidFT_invalid_occupation_ind(s);
EXPORT InValidMessage_db_cons_occupation_ind(UNSIGNED1 wh) := InValidMessageFT_invalid_occupation_ind(wh);
 
EXPORT Make_db_cons_credit_card_user(SALT311.StrType s0) := MakeFT_invalid_flag(s0);
EXPORT InValid_db_cons_credit_card_user(SALT311.StrType s) := InValidFT_invalid_flag(s);
EXPORT InValidMessage_db_cons_credit_card_user(UNSIGNED1 wh) := InValidMessageFT_invalid_flag(wh);
 
EXPORT Make_db_cons_home_property_type(SALT311.StrType s0) := MakeFT_invalid_home_property(s0);
EXPORT InValid_db_cons_home_property_type(SALT311.StrType s) := InValidFT_invalid_home_property(s);
EXPORT InValidMessage_db_cons_home_property_type(UNSIGNED1 wh) := InValidMessageFT_invalid_home_property(wh);
 
EXPORT Make_db_cons_education_hh(SALT311.StrType s0) := MakeFT_invalid_education(s0);
EXPORT InValid_db_cons_education_hh(SALT311.StrType s) := InValidFT_invalid_education(s);
EXPORT InValidMessage_db_cons_education_hh(UNSIGNED1 wh) := InValidMessageFT_invalid_education(wh);
 
EXPORT Make_db_cons_education_ind(SALT311.StrType s0) := MakeFT_invalid_education(s0);
EXPORT InValid_db_cons_education_ind(SALT311.StrType s) := InValidFT_invalid_education(s);
EXPORT InValidMessage_db_cons_education_ind(UNSIGNED1 wh) := InValidMessageFT_invalid_education(wh);
 
EXPORT Make_db_cons_other_pet_owner(SALT311.StrType s0) := MakeFT_invalid_flag(s0);
EXPORT InValid_db_cons_other_pet_owner(SALT311.StrType s) := InValidFT_invalid_flag(s);
EXPORT InValidMessage_db_cons_other_pet_owner(UNSIGNED1 wh) := InValidMessageFT_invalid_flag(wh);
 
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
    BOOLEAN Diff_dt_first_seen;
    BOOLEAN Diff_dt_last_seen;
    BOOLEAN Diff_dt_vendor_first_reported;
    BOOLEAN Diff_dt_vendor_last_reported;
    BOOLEAN Diff_process_date;
    BOOLEAN Diff_record_type;
    BOOLEAN Diff_ind_frm_indicator;
    BOOLEAN Diff_company_name;
    BOOLEAN Diff_full_name;
    BOOLEAN Diff_gender;
    BOOLEAN Diff_primary_exec_flag;
    BOOLEAN Diff_exec_type;
    BOOLEAN Diff_phy_addr_state;
    BOOLEAN Diff_phy_addr_zip;
    BOOLEAN Diff_mail_addr_state;
    BOOLEAN Diff_mail_addr_zip;
    BOOLEAN Diff_mail_score;
    BOOLEAN Diff_phone;
    BOOLEAN Diff_email;
    BOOLEAN Diff_email_available_indicator;
    BOOLEAN Diff_url;
    BOOLEAN Diff_business_status_code;
    BOOLEAN Diff_franchise_flag;
    BOOLEAN Diff_franchise_type;
    BOOLEAN Diff_county_code;
    BOOLEAN Diff_primary_sic;
    BOOLEAN Diff_sic02;
    BOOLEAN Diff_sic03;
    BOOLEAN Diff_sic04;
    BOOLEAN Diff_sic05;
    BOOLEAN Diff_sic06;
    BOOLEAN Diff_primarysic2;
    BOOLEAN Diff_primarysic4;
    BOOLEAN Diff_naics01;
    BOOLEAN Diff_naics02;
    BOOLEAN Diff_naics03;
    BOOLEAN Diff_naics04;
    BOOLEAN Diff_naics05;
    BOOLEAN Diff_naics06;
    BOOLEAN Diff_location_employee_code;
    BOOLEAN Diff_location_sales_code;
    BOOLEAN Diff_corporate_employee_code;
    BOOLEAN Diff_year_established;
    BOOLEAN Diff_female_owned;
    BOOLEAN Diff_minority_owned_flag;
    BOOLEAN Diff_home_based_indicator;
    BOOLEAN Diff_small_business_indicator;
    BOOLEAN Diff_import_export;
    BOOLEAN Diff_manufacturing_location;
    BOOLEAN Diff_public_indicator;
    BOOLEAN Diff_non_profit_org;
    BOOLEAN Diff_square_footage_code;
    BOOLEAN Diff_creditcode;
    BOOLEAN Diff_credit_capacity_code;
    BOOLEAN Diff_advertising_expenses_code;
    BOOLEAN Diff_technology_expenses_code;
    BOOLEAN Diff_office_equip_expenses_code;
    BOOLEAN Diff_rent_expenses_code;
    BOOLEAN Diff_telecom_expenses_code;
    BOOLEAN Diff_accounting_expenses_code;
    BOOLEAN Diff_bus_insurance_expense_code;
    BOOLEAN Diff_legal_expenses_code;
    BOOLEAN Diff_utilities_expenses_code;
    BOOLEAN Diff_number_of_pcs_code;
    BOOLEAN Diff_nb_flag;
    BOOLEAN Diff_domestic_foreign_owner_flag;
    BOOLEAN Diff_db_cons_full_name;
    BOOLEAN Diff_db_cons_email;
    BOOLEAN Diff_db_cons_gender;
    BOOLEAN Diff_db_cons_date_of_birth_year;
    BOOLEAN Diff_db_cons_date_of_birth_month;
    BOOLEAN Diff_db_cons_age;
    BOOLEAN Diff_db_cons_ethnic_code;
    BOOLEAN Diff_db_cons_religious_affil;
    BOOLEAN Diff_db_cons_language_pref;
    BOOLEAN Diff_db_cons_time_zone_code;
    BOOLEAN Diff_db_cons_phone;
    BOOLEAN Diff_db_cons_dnc;
    BOOLEAN Diff_db_cons_scrubbed_phoneable;
    BOOLEAN Diff_db_cons_children_present;
    BOOLEAN Diff_db_cons_home_value_code;
    BOOLEAN Diff_db_cons_donor_capacity_code;
    BOOLEAN Diff_db_cons_home_owner_renter;
    BOOLEAN Diff_db_cons_length_of_res_code;
    BOOLEAN Diff_db_cons_dwelling_type;
    BOOLEAN Diff_db_cons_recent_home_buyer;
    BOOLEAN Diff_db_cons_income_code;
    BOOLEAN Diff_db_cons_unsecuredcredcapcode;
    BOOLEAN Diff_db_cons_networthhomevalcode;
    BOOLEAN Diff_db_cons_discretincomecode;
    BOOLEAN Diff_db_cons_marital_status;
    BOOLEAN Diff_db_cons_new_parent;
    BOOLEAN Diff_db_cons_child_near_hs_grad;
    BOOLEAN Diff_db_cons_college_graduate;
    BOOLEAN Diff_db_cons_intend_purchase_veh;
    BOOLEAN Diff_db_cons_recent_divorce;
    BOOLEAN Diff_db_cons_newlywed;
    BOOLEAN Diff_db_cons_new_teen_driver;
    BOOLEAN Diff_db_cons_home_year_built;
    BOOLEAN Diff_db_cons_home_sqft_ranges;
    BOOLEAN Diff_db_cons_poli_party_ind;
    BOOLEAN Diff_db_cons_occupation_ind;
    BOOLEAN Diff_db_cons_credit_card_user;
    BOOLEAN Diff_db_cons_home_property_type;
    BOOLEAN Diff_db_cons_education_hh;
    BOOLEAN Diff_db_cons_education_ind;
    BOOLEAN Diff_db_cons_other_pet_owner;
    UNSIGNED Num_Diffs;
    SALT311.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_dt_first_seen := le.dt_first_seen <> ri.dt_first_seen;
    SELF.Diff_dt_last_seen := le.dt_last_seen <> ri.dt_last_seen;
    SELF.Diff_dt_vendor_first_reported := le.dt_vendor_first_reported <> ri.dt_vendor_first_reported;
    SELF.Diff_dt_vendor_last_reported := le.dt_vendor_last_reported <> ri.dt_vendor_last_reported;
    SELF.Diff_process_date := le.process_date <> ri.process_date;
    SELF.Diff_record_type := le.record_type <> ri.record_type;
    SELF.Diff_ind_frm_indicator := le.ind_frm_indicator <> ri.ind_frm_indicator;
    SELF.Diff_company_name := le.company_name <> ri.company_name;
    SELF.Diff_full_name := le.full_name <> ri.full_name;
    SELF.Diff_gender := le.gender <> ri.gender;
    SELF.Diff_primary_exec_flag := le.primary_exec_flag <> ri.primary_exec_flag;
    SELF.Diff_exec_type := le.exec_type <> ri.exec_type;
    SELF.Diff_phy_addr_state := le.phy_addr_state <> ri.phy_addr_state;
    SELF.Diff_phy_addr_zip := le.phy_addr_zip <> ri.phy_addr_zip;
    SELF.Diff_mail_addr_state := le.mail_addr_state <> ri.mail_addr_state;
    SELF.Diff_mail_addr_zip := le.mail_addr_zip <> ri.mail_addr_zip;
    SELF.Diff_mail_score := le.mail_score <> ri.mail_score;
    SELF.Diff_phone := le.phone <> ri.phone;
    SELF.Diff_email := le.email <> ri.email;
    SELF.Diff_email_available_indicator := le.email_available_indicator <> ri.email_available_indicator;
    SELF.Diff_url := le.url <> ri.url;
    SELF.Diff_business_status_code := le.business_status_code <> ri.business_status_code;
    SELF.Diff_franchise_flag := le.franchise_flag <> ri.franchise_flag;
    SELF.Diff_franchise_type := le.franchise_type <> ri.franchise_type;
    SELF.Diff_county_code := le.county_code <> ri.county_code;
    SELF.Diff_primary_sic := le.primary_sic <> ri.primary_sic;
    SELF.Diff_sic02 := le.sic02 <> ri.sic02;
    SELF.Diff_sic03 := le.sic03 <> ri.sic03;
    SELF.Diff_sic04 := le.sic04 <> ri.sic04;
    SELF.Diff_sic05 := le.sic05 <> ri.sic05;
    SELF.Diff_sic06 := le.sic06 <> ri.sic06;
    SELF.Diff_primarysic2 := le.primarysic2 <> ri.primarysic2;
    SELF.Diff_primarysic4 := le.primarysic4 <> ri.primarysic4;
    SELF.Diff_naics01 := le.naics01 <> ri.naics01;
    SELF.Diff_naics02 := le.naics02 <> ri.naics02;
    SELF.Diff_naics03 := le.naics03 <> ri.naics03;
    SELF.Diff_naics04 := le.naics04 <> ri.naics04;
    SELF.Diff_naics05 := le.naics05 <> ri.naics05;
    SELF.Diff_naics06 := le.naics06 <> ri.naics06;
    SELF.Diff_location_employee_code := le.location_employee_code <> ri.location_employee_code;
    SELF.Diff_location_sales_code := le.location_sales_code <> ri.location_sales_code;
    SELF.Diff_corporate_employee_code := le.corporate_employee_code <> ri.corporate_employee_code;
    SELF.Diff_year_established := le.year_established <> ri.year_established;
    SELF.Diff_female_owned := le.female_owned <> ri.female_owned;
    SELF.Diff_minority_owned_flag := le.minority_owned_flag <> ri.minority_owned_flag;
    SELF.Diff_home_based_indicator := le.home_based_indicator <> ri.home_based_indicator;
    SELF.Diff_small_business_indicator := le.small_business_indicator <> ri.small_business_indicator;
    SELF.Diff_import_export := le.import_export <> ri.import_export;
    SELF.Diff_manufacturing_location := le.manufacturing_location <> ri.manufacturing_location;
    SELF.Diff_public_indicator := le.public_indicator <> ri.public_indicator;
    SELF.Diff_non_profit_org := le.non_profit_org <> ri.non_profit_org;
    SELF.Diff_square_footage_code := le.square_footage_code <> ri.square_footage_code;
    SELF.Diff_creditcode := le.creditcode <> ri.creditcode;
    SELF.Diff_credit_capacity_code := le.credit_capacity_code <> ri.credit_capacity_code;
    SELF.Diff_advertising_expenses_code := le.advertising_expenses_code <> ri.advertising_expenses_code;
    SELF.Diff_technology_expenses_code := le.technology_expenses_code <> ri.technology_expenses_code;
    SELF.Diff_office_equip_expenses_code := le.office_equip_expenses_code <> ri.office_equip_expenses_code;
    SELF.Diff_rent_expenses_code := le.rent_expenses_code <> ri.rent_expenses_code;
    SELF.Diff_telecom_expenses_code := le.telecom_expenses_code <> ri.telecom_expenses_code;
    SELF.Diff_accounting_expenses_code := le.accounting_expenses_code <> ri.accounting_expenses_code;
    SELF.Diff_bus_insurance_expense_code := le.bus_insurance_expense_code <> ri.bus_insurance_expense_code;
    SELF.Diff_legal_expenses_code := le.legal_expenses_code <> ri.legal_expenses_code;
    SELF.Diff_utilities_expenses_code := le.utilities_expenses_code <> ri.utilities_expenses_code;
    SELF.Diff_number_of_pcs_code := le.number_of_pcs_code <> ri.number_of_pcs_code;
    SELF.Diff_nb_flag := le.nb_flag <> ri.nb_flag;
    SELF.Diff_domestic_foreign_owner_flag := le.domestic_foreign_owner_flag <> ri.domestic_foreign_owner_flag;
    SELF.Diff_db_cons_full_name := le.db_cons_full_name <> ri.db_cons_full_name;
    SELF.Diff_db_cons_email := le.db_cons_email <> ri.db_cons_email;
    SELF.Diff_db_cons_gender := le.db_cons_gender <> ri.db_cons_gender;
    SELF.Diff_db_cons_date_of_birth_year := le.db_cons_date_of_birth_year <> ri.db_cons_date_of_birth_year;
    SELF.Diff_db_cons_date_of_birth_month := le.db_cons_date_of_birth_month <> ri.db_cons_date_of_birth_month;
    SELF.Diff_db_cons_age := le.db_cons_age <> ri.db_cons_age;
    SELF.Diff_db_cons_ethnic_code := le.db_cons_ethnic_code <> ri.db_cons_ethnic_code;
    SELF.Diff_db_cons_religious_affil := le.db_cons_religious_affil <> ri.db_cons_religious_affil;
    SELF.Diff_db_cons_language_pref := le.db_cons_language_pref <> ri.db_cons_language_pref;
    SELF.Diff_db_cons_time_zone_code := le.db_cons_time_zone_code <> ri.db_cons_time_zone_code;
    SELF.Diff_db_cons_phone := le.db_cons_phone <> ri.db_cons_phone;
    SELF.Diff_db_cons_dnc := le.db_cons_dnc <> ri.db_cons_dnc;
    SELF.Diff_db_cons_scrubbed_phoneable := le.db_cons_scrubbed_phoneable <> ri.db_cons_scrubbed_phoneable;
    SELF.Diff_db_cons_children_present := le.db_cons_children_present <> ri.db_cons_children_present;
    SELF.Diff_db_cons_home_value_code := le.db_cons_home_value_code <> ri.db_cons_home_value_code;
    SELF.Diff_db_cons_donor_capacity_code := le.db_cons_donor_capacity_code <> ri.db_cons_donor_capacity_code;
    SELF.Diff_db_cons_home_owner_renter := le.db_cons_home_owner_renter <> ri.db_cons_home_owner_renter;
    SELF.Diff_db_cons_length_of_res_code := le.db_cons_length_of_res_code <> ri.db_cons_length_of_res_code;
    SELF.Diff_db_cons_dwelling_type := le.db_cons_dwelling_type <> ri.db_cons_dwelling_type;
    SELF.Diff_db_cons_recent_home_buyer := le.db_cons_recent_home_buyer <> ri.db_cons_recent_home_buyer;
    SELF.Diff_db_cons_income_code := le.db_cons_income_code <> ri.db_cons_income_code;
    SELF.Diff_db_cons_unsecuredcredcapcode := le.db_cons_unsecuredcredcapcode <> ri.db_cons_unsecuredcredcapcode;
    SELF.Diff_db_cons_networthhomevalcode := le.db_cons_networthhomevalcode <> ri.db_cons_networthhomevalcode;
    SELF.Diff_db_cons_discretincomecode := le.db_cons_discretincomecode <> ri.db_cons_discretincomecode;
    SELF.Diff_db_cons_marital_status := le.db_cons_marital_status <> ri.db_cons_marital_status;
    SELF.Diff_db_cons_new_parent := le.db_cons_new_parent <> ri.db_cons_new_parent;
    SELF.Diff_db_cons_child_near_hs_grad := le.db_cons_child_near_hs_grad <> ri.db_cons_child_near_hs_grad;
    SELF.Diff_db_cons_college_graduate := le.db_cons_college_graduate <> ri.db_cons_college_graduate;
    SELF.Diff_db_cons_intend_purchase_veh := le.db_cons_intend_purchase_veh <> ri.db_cons_intend_purchase_veh;
    SELF.Diff_db_cons_recent_divorce := le.db_cons_recent_divorce <> ri.db_cons_recent_divorce;
    SELF.Diff_db_cons_newlywed := le.db_cons_newlywed <> ri.db_cons_newlywed;
    SELF.Diff_db_cons_new_teen_driver := le.db_cons_new_teen_driver <> ri.db_cons_new_teen_driver;
    SELF.Diff_db_cons_home_year_built := le.db_cons_home_year_built <> ri.db_cons_home_year_built;
    SELF.Diff_db_cons_home_sqft_ranges := le.db_cons_home_sqft_ranges <> ri.db_cons_home_sqft_ranges;
    SELF.Diff_db_cons_poli_party_ind := le.db_cons_poli_party_ind <> ri.db_cons_poli_party_ind;
    SELF.Diff_db_cons_occupation_ind := le.db_cons_occupation_ind <> ri.db_cons_occupation_ind;
    SELF.Diff_db_cons_credit_card_user := le.db_cons_credit_card_user <> ri.db_cons_credit_card_user;
    SELF.Diff_db_cons_home_property_type := le.db_cons_home_property_type <> ri.db_cons_home_property_type;
    SELF.Diff_db_cons_education_hh := le.db_cons_education_hh <> ri.db_cons_education_hh;
    SELF.Diff_db_cons_education_ind := le.db_cons_education_ind <> ri.db_cons_education_ind;
    SELF.Diff_db_cons_other_pet_owner := le.db_cons_other_pet_owner <> ri.db_cons_other_pet_owner;
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_dt_first_seen,1,0)+ IF( SELF.Diff_dt_last_seen,1,0)+ IF( SELF.Diff_dt_vendor_first_reported,1,0)+ IF( SELF.Diff_dt_vendor_last_reported,1,0)+ IF( SELF.Diff_process_date,1,0)+ IF( SELF.Diff_record_type,1,0)+ IF( SELF.Diff_ind_frm_indicator,1,0)+ IF( SELF.Diff_company_name,1,0)+ IF( SELF.Diff_full_name,1,0)+ IF( SELF.Diff_gender,1,0)+ IF( SELF.Diff_primary_exec_flag,1,0)+ IF( SELF.Diff_exec_type,1,0)+ IF( SELF.Diff_phy_addr_state,1,0)+ IF( SELF.Diff_phy_addr_zip,1,0)+ IF( SELF.Diff_mail_addr_state,1,0)+ IF( SELF.Diff_mail_addr_zip,1,0)+ IF( SELF.Diff_mail_score,1,0)+ IF( SELF.Diff_phone,1,0)+ IF( SELF.Diff_email,1,0)+ IF( SELF.Diff_email_available_indicator,1,0)+ IF( SELF.Diff_url,1,0)+ IF( SELF.Diff_business_status_code,1,0)+ IF( SELF.Diff_franchise_flag,1,0)+ IF( SELF.Diff_franchise_type,1,0)+ IF( SELF.Diff_county_code,1,0)+ IF( SELF.Diff_primary_sic,1,0)+ IF( SELF.Diff_sic02,1,0)+ IF( SELF.Diff_sic03,1,0)+ IF( SELF.Diff_sic04,1,0)+ IF( SELF.Diff_sic05,1,0)+ IF( SELF.Diff_sic06,1,0)+ IF( SELF.Diff_primarysic2,1,0)+ IF( SELF.Diff_primarysic4,1,0)+ IF( SELF.Diff_naics01,1,0)+ IF( SELF.Diff_naics02,1,0)+ IF( SELF.Diff_naics03,1,0)+ IF( SELF.Diff_naics04,1,0)+ IF( SELF.Diff_naics05,1,0)+ IF( SELF.Diff_naics06,1,0)+ IF( SELF.Diff_location_employee_code,1,0)+ IF( SELF.Diff_location_sales_code,1,0)+ IF( SELF.Diff_corporate_employee_code,1,0)+ IF( SELF.Diff_year_established,1,0)+ IF( SELF.Diff_female_owned,1,0)+ IF( SELF.Diff_minority_owned_flag,1,0)+ IF( SELF.Diff_home_based_indicator,1,0)+ IF( SELF.Diff_small_business_indicator,1,0)+ IF( SELF.Diff_import_export,1,0)+ IF( SELF.Diff_manufacturing_location,1,0)+ IF( SELF.Diff_public_indicator,1,0)+ IF( SELF.Diff_non_profit_org,1,0)+ IF( SELF.Diff_square_footage_code,1,0)+ IF( SELF.Diff_creditcode,1,0)+ IF( SELF.Diff_credit_capacity_code,1,0)+ IF( SELF.Diff_advertising_expenses_code,1,0)+ IF( SELF.Diff_technology_expenses_code,1,0)+ IF( SELF.Diff_office_equip_expenses_code,1,0)+ IF( SELF.Diff_rent_expenses_code,1,0)+ IF( SELF.Diff_telecom_expenses_code,1,0)+ IF( SELF.Diff_accounting_expenses_code,1,0)+ IF( SELF.Diff_bus_insurance_expense_code,1,0)+ IF( SELF.Diff_legal_expenses_code,1,0)+ IF( SELF.Diff_utilities_expenses_code,1,0)+ IF( SELF.Diff_number_of_pcs_code,1,0)+ IF( SELF.Diff_nb_flag,1,0)+ IF( SELF.Diff_domestic_foreign_owner_flag,1,0)+ IF( SELF.Diff_db_cons_full_name,1,0)+ IF( SELF.Diff_db_cons_email,1,0)+ IF( SELF.Diff_db_cons_gender,1,0)+ IF( SELF.Diff_db_cons_date_of_birth_year,1,0)+ IF( SELF.Diff_db_cons_date_of_birth_month,1,0)+ IF( SELF.Diff_db_cons_age,1,0)+ IF( SELF.Diff_db_cons_ethnic_code,1,0)+ IF( SELF.Diff_db_cons_religious_affil,1,0)+ IF( SELF.Diff_db_cons_language_pref,1,0)+ IF( SELF.Diff_db_cons_time_zone_code,1,0)+ IF( SELF.Diff_db_cons_phone,1,0)+ IF( SELF.Diff_db_cons_dnc,1,0)+ IF( SELF.Diff_db_cons_scrubbed_phoneable,1,0)+ IF( SELF.Diff_db_cons_children_present,1,0)+ IF( SELF.Diff_db_cons_home_value_code,1,0)+ IF( SELF.Diff_db_cons_donor_capacity_code,1,0)+ IF( SELF.Diff_db_cons_home_owner_renter,1,0)+ IF( SELF.Diff_db_cons_length_of_res_code,1,0)+ IF( SELF.Diff_db_cons_dwelling_type,1,0)+ IF( SELF.Diff_db_cons_recent_home_buyer,1,0)+ IF( SELF.Diff_db_cons_income_code,1,0)+ IF( SELF.Diff_db_cons_unsecuredcredcapcode,1,0)+ IF( SELF.Diff_db_cons_networthhomevalcode,1,0)+ IF( SELF.Diff_db_cons_discretincomecode,1,0)+ IF( SELF.Diff_db_cons_marital_status,1,0)+ IF( SELF.Diff_db_cons_new_parent,1,0)+ IF( SELF.Diff_db_cons_child_near_hs_grad,1,0)+ IF( SELF.Diff_db_cons_college_graduate,1,0)+ IF( SELF.Diff_db_cons_intend_purchase_veh,1,0)+ IF( SELF.Diff_db_cons_recent_divorce,1,0)+ IF( SELF.Diff_db_cons_newlywed,1,0)+ IF( SELF.Diff_db_cons_new_teen_driver,1,0)+ IF( SELF.Diff_db_cons_home_year_built,1,0)+ IF( SELF.Diff_db_cons_home_sqft_ranges,1,0)+ IF( SELF.Diff_db_cons_poli_party_ind,1,0)+ IF( SELF.Diff_db_cons_occupation_ind,1,0)+ IF( SELF.Diff_db_cons_credit_card_user,1,0)+ IF( SELF.Diff_db_cons_home_property_type,1,0)+ IF( SELF.Diff_db_cons_education_hh,1,0)+ IF( SELF.Diff_db_cons_education_ind,1,0)+ IF( SELF.Diff_db_cons_other_pet_owner,1,0);
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
    Count_Diff_dt_first_seen := COUNT(GROUP,%Closest%.Diff_dt_first_seen);
    Count_Diff_dt_last_seen := COUNT(GROUP,%Closest%.Diff_dt_last_seen);
    Count_Diff_dt_vendor_first_reported := COUNT(GROUP,%Closest%.Diff_dt_vendor_first_reported);
    Count_Diff_dt_vendor_last_reported := COUNT(GROUP,%Closest%.Diff_dt_vendor_last_reported);
    Count_Diff_process_date := COUNT(GROUP,%Closest%.Diff_process_date);
    Count_Diff_record_type := COUNT(GROUP,%Closest%.Diff_record_type);
    Count_Diff_ind_frm_indicator := COUNT(GROUP,%Closest%.Diff_ind_frm_indicator);
    Count_Diff_company_name := COUNT(GROUP,%Closest%.Diff_company_name);
    Count_Diff_full_name := COUNT(GROUP,%Closest%.Diff_full_name);
    Count_Diff_gender := COUNT(GROUP,%Closest%.Diff_gender);
    Count_Diff_primary_exec_flag := COUNT(GROUP,%Closest%.Diff_primary_exec_flag);
    Count_Diff_exec_type := COUNT(GROUP,%Closest%.Diff_exec_type);
    Count_Diff_phy_addr_state := COUNT(GROUP,%Closest%.Diff_phy_addr_state);
    Count_Diff_phy_addr_zip := COUNT(GROUP,%Closest%.Diff_phy_addr_zip);
    Count_Diff_mail_addr_state := COUNT(GROUP,%Closest%.Diff_mail_addr_state);
    Count_Diff_mail_addr_zip := COUNT(GROUP,%Closest%.Diff_mail_addr_zip);
    Count_Diff_mail_score := COUNT(GROUP,%Closest%.Diff_mail_score);
    Count_Diff_phone := COUNT(GROUP,%Closest%.Diff_phone);
    Count_Diff_email := COUNT(GROUP,%Closest%.Diff_email);
    Count_Diff_email_available_indicator := COUNT(GROUP,%Closest%.Diff_email_available_indicator);
    Count_Diff_url := COUNT(GROUP,%Closest%.Diff_url);
    Count_Diff_business_status_code := COUNT(GROUP,%Closest%.Diff_business_status_code);
    Count_Diff_franchise_flag := COUNT(GROUP,%Closest%.Diff_franchise_flag);
    Count_Diff_franchise_type := COUNT(GROUP,%Closest%.Diff_franchise_type);
    Count_Diff_county_code := COUNT(GROUP,%Closest%.Diff_county_code);
    Count_Diff_primary_sic := COUNT(GROUP,%Closest%.Diff_primary_sic);
    Count_Diff_sic02 := COUNT(GROUP,%Closest%.Diff_sic02);
    Count_Diff_sic03 := COUNT(GROUP,%Closest%.Diff_sic03);
    Count_Diff_sic04 := COUNT(GROUP,%Closest%.Diff_sic04);
    Count_Diff_sic05 := COUNT(GROUP,%Closest%.Diff_sic05);
    Count_Diff_sic06 := COUNT(GROUP,%Closest%.Diff_sic06);
    Count_Diff_primarysic2 := COUNT(GROUP,%Closest%.Diff_primarysic2);
    Count_Diff_primarysic4 := COUNT(GROUP,%Closest%.Diff_primarysic4);
    Count_Diff_naics01 := COUNT(GROUP,%Closest%.Diff_naics01);
    Count_Diff_naics02 := COUNT(GROUP,%Closest%.Diff_naics02);
    Count_Diff_naics03 := COUNT(GROUP,%Closest%.Diff_naics03);
    Count_Diff_naics04 := COUNT(GROUP,%Closest%.Diff_naics04);
    Count_Diff_naics05 := COUNT(GROUP,%Closest%.Diff_naics05);
    Count_Diff_naics06 := COUNT(GROUP,%Closest%.Diff_naics06);
    Count_Diff_location_employee_code := COUNT(GROUP,%Closest%.Diff_location_employee_code);
    Count_Diff_location_sales_code := COUNT(GROUP,%Closest%.Diff_location_sales_code);
    Count_Diff_corporate_employee_code := COUNT(GROUP,%Closest%.Diff_corporate_employee_code);
    Count_Diff_year_established := COUNT(GROUP,%Closest%.Diff_year_established);
    Count_Diff_female_owned := COUNT(GROUP,%Closest%.Diff_female_owned);
    Count_Diff_minority_owned_flag := COUNT(GROUP,%Closest%.Diff_minority_owned_flag);
    Count_Diff_home_based_indicator := COUNT(GROUP,%Closest%.Diff_home_based_indicator);
    Count_Diff_small_business_indicator := COUNT(GROUP,%Closest%.Diff_small_business_indicator);
    Count_Diff_import_export := COUNT(GROUP,%Closest%.Diff_import_export);
    Count_Diff_manufacturing_location := COUNT(GROUP,%Closest%.Diff_manufacturing_location);
    Count_Diff_public_indicator := COUNT(GROUP,%Closest%.Diff_public_indicator);
    Count_Diff_non_profit_org := COUNT(GROUP,%Closest%.Diff_non_profit_org);
    Count_Diff_square_footage_code := COUNT(GROUP,%Closest%.Diff_square_footage_code);
    Count_Diff_creditcode := COUNT(GROUP,%Closest%.Diff_creditcode);
    Count_Diff_credit_capacity_code := COUNT(GROUP,%Closest%.Diff_credit_capacity_code);
    Count_Diff_advertising_expenses_code := COUNT(GROUP,%Closest%.Diff_advertising_expenses_code);
    Count_Diff_technology_expenses_code := COUNT(GROUP,%Closest%.Diff_technology_expenses_code);
    Count_Diff_office_equip_expenses_code := COUNT(GROUP,%Closest%.Diff_office_equip_expenses_code);
    Count_Diff_rent_expenses_code := COUNT(GROUP,%Closest%.Diff_rent_expenses_code);
    Count_Diff_telecom_expenses_code := COUNT(GROUP,%Closest%.Diff_telecom_expenses_code);
    Count_Diff_accounting_expenses_code := COUNT(GROUP,%Closest%.Diff_accounting_expenses_code);
    Count_Diff_bus_insurance_expense_code := COUNT(GROUP,%Closest%.Diff_bus_insurance_expense_code);
    Count_Diff_legal_expenses_code := COUNT(GROUP,%Closest%.Diff_legal_expenses_code);
    Count_Diff_utilities_expenses_code := COUNT(GROUP,%Closest%.Diff_utilities_expenses_code);
    Count_Diff_number_of_pcs_code := COUNT(GROUP,%Closest%.Diff_number_of_pcs_code);
    Count_Diff_nb_flag := COUNT(GROUP,%Closest%.Diff_nb_flag);
    Count_Diff_domestic_foreign_owner_flag := COUNT(GROUP,%Closest%.Diff_domestic_foreign_owner_flag);
    Count_Diff_db_cons_full_name := COUNT(GROUP,%Closest%.Diff_db_cons_full_name);
    Count_Diff_db_cons_email := COUNT(GROUP,%Closest%.Diff_db_cons_email);
    Count_Diff_db_cons_gender := COUNT(GROUP,%Closest%.Diff_db_cons_gender);
    Count_Diff_db_cons_date_of_birth_year := COUNT(GROUP,%Closest%.Diff_db_cons_date_of_birth_year);
    Count_Diff_db_cons_date_of_birth_month := COUNT(GROUP,%Closest%.Diff_db_cons_date_of_birth_month);
    Count_Diff_db_cons_age := COUNT(GROUP,%Closest%.Diff_db_cons_age);
    Count_Diff_db_cons_ethnic_code := COUNT(GROUP,%Closest%.Diff_db_cons_ethnic_code);
    Count_Diff_db_cons_religious_affil := COUNT(GROUP,%Closest%.Diff_db_cons_religious_affil);
    Count_Diff_db_cons_language_pref := COUNT(GROUP,%Closest%.Diff_db_cons_language_pref);
    Count_Diff_db_cons_time_zone_code := COUNT(GROUP,%Closest%.Diff_db_cons_time_zone_code);
    Count_Diff_db_cons_phone := COUNT(GROUP,%Closest%.Diff_db_cons_phone);
    Count_Diff_db_cons_dnc := COUNT(GROUP,%Closest%.Diff_db_cons_dnc);
    Count_Diff_db_cons_scrubbed_phoneable := COUNT(GROUP,%Closest%.Diff_db_cons_scrubbed_phoneable);
    Count_Diff_db_cons_children_present := COUNT(GROUP,%Closest%.Diff_db_cons_children_present);
    Count_Diff_db_cons_home_value_code := COUNT(GROUP,%Closest%.Diff_db_cons_home_value_code);
    Count_Diff_db_cons_donor_capacity_code := COUNT(GROUP,%Closest%.Diff_db_cons_donor_capacity_code);
    Count_Diff_db_cons_home_owner_renter := COUNT(GROUP,%Closest%.Diff_db_cons_home_owner_renter);
    Count_Diff_db_cons_length_of_res_code := COUNT(GROUP,%Closest%.Diff_db_cons_length_of_res_code);
    Count_Diff_db_cons_dwelling_type := COUNT(GROUP,%Closest%.Diff_db_cons_dwelling_type);
    Count_Diff_db_cons_recent_home_buyer := COUNT(GROUP,%Closest%.Diff_db_cons_recent_home_buyer);
    Count_Diff_db_cons_income_code := COUNT(GROUP,%Closest%.Diff_db_cons_income_code);
    Count_Diff_db_cons_unsecuredcredcapcode := COUNT(GROUP,%Closest%.Diff_db_cons_unsecuredcredcapcode);
    Count_Diff_db_cons_networthhomevalcode := COUNT(GROUP,%Closest%.Diff_db_cons_networthhomevalcode);
    Count_Diff_db_cons_discretincomecode := COUNT(GROUP,%Closest%.Diff_db_cons_discretincomecode);
    Count_Diff_db_cons_marital_status := COUNT(GROUP,%Closest%.Diff_db_cons_marital_status);
    Count_Diff_db_cons_new_parent := COUNT(GROUP,%Closest%.Diff_db_cons_new_parent);
    Count_Diff_db_cons_child_near_hs_grad := COUNT(GROUP,%Closest%.Diff_db_cons_child_near_hs_grad);
    Count_Diff_db_cons_college_graduate := COUNT(GROUP,%Closest%.Diff_db_cons_college_graduate);
    Count_Diff_db_cons_intend_purchase_veh := COUNT(GROUP,%Closest%.Diff_db_cons_intend_purchase_veh);
    Count_Diff_db_cons_recent_divorce := COUNT(GROUP,%Closest%.Diff_db_cons_recent_divorce);
    Count_Diff_db_cons_newlywed := COUNT(GROUP,%Closest%.Diff_db_cons_newlywed);
    Count_Diff_db_cons_new_teen_driver := COUNT(GROUP,%Closest%.Diff_db_cons_new_teen_driver);
    Count_Diff_db_cons_home_year_built := COUNT(GROUP,%Closest%.Diff_db_cons_home_year_built);
    Count_Diff_db_cons_home_sqft_ranges := COUNT(GROUP,%Closest%.Diff_db_cons_home_sqft_ranges);
    Count_Diff_db_cons_poli_party_ind := COUNT(GROUP,%Closest%.Diff_db_cons_poli_party_ind);
    Count_Diff_db_cons_occupation_ind := COUNT(GROUP,%Closest%.Diff_db_cons_occupation_ind);
    Count_Diff_db_cons_credit_card_user := COUNT(GROUP,%Closest%.Diff_db_cons_credit_card_user);
    Count_Diff_db_cons_home_property_type := COUNT(GROUP,%Closest%.Diff_db_cons_home_property_type);
    Count_Diff_db_cons_education_hh := COUNT(GROUP,%Closest%.Diff_db_cons_education_hh);
    Count_Diff_db_cons_education_ind := COUNT(GROUP,%Closest%.Diff_db_cons_education_ind);
    Count_Diff_db_cons_other_pet_owner := COUNT(GROUP,%Closest%.Diff_db_cons_other_pet_owner);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
