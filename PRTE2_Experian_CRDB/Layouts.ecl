﻿Import Experian_CRDB;

EXPORT Layouts := module

Export In_Layout := RECORD
unsigned4 dt_first_seen;
unsigned4 dt_last_seen;
unsigned4 dt_vendor_first_reported;
unsigned4 dt_vendor_last_reported;
string9 experian_bus_id;
string120 business_name;
string60 address;
string40 city;
string2 state;
string5 zip_code;
string4 zip_plus_4;
string4 carrier_route;
string3 county_code;
string30 county_name;
string10 phone_number;
string4 msa_code;
string50 msa_description;
string8 establish_date;
string8 latest_reported_date;
string2 years_in_file;
string10 geo_code_latitude;
string1 geo_code_latitude_direction;
string10 geo_code_longitude;
string1 geo_code_longitude_direction;
string1 recent_update_code;
string1 years_in_business_code;
string4 year_business_started;
string4 months_in_file;
string1 address_type_code;
string7 estimated_number_of_employees;
string1 employee_size_code;
string1 estimated_annual_sales_amount_sign;
string8 estimated_annual_sales_amount;
string1 annual_sales_size_code;
string1 location_code;
string1 primary_sic_code_industry_classification;
string4 primary_sic_code_4_digit;
string8 primary_sic_code;
string8 second_sic_code;
string8 third_sic_code;
string8 fourth_sic_code;
string8 fifth_sic_code;
string8 sixth_sic_code;
string6 primary_naics_code;
string6 second_naics_code;
string6 third_naics_code;
string6 fourth_naics_code;
string3 executive_count;
string20 executive_last_name;
string10 executive_first_name;
string1 executive_middle_initial;
string10 executive_title;
string1 business_type;
string1 ownership_code;
string50 url;
string1 derogatory_indicator;
string8 recent_derogatory_filed_date;
string1 derogatory_liability_amount_sign;
string10 derogatory_liability_amount;
string1 ucc_data_indicator;
string5 ucc_count;
string3 number_of_legal_items;
string1 legal_balance_sign;
string10 legal_balance_amount;
string1 pmtkbankruptcy;
string1 pmtkjudgment;
string1 pmtktaxlien;
string1 pmtkpayment;
string1 bankruptcy_filed;
string3 number_of_derogatory_legal_items;
string3 lien_count;
string3 judgment_count;
string5 bkc006;
string5 bkc007;
string5 bkc008;
string1 bko009;
string1 bkb001_sign;
string11 bkb001;
string1 bkb003_sign;
string11 bkb003;
string5 bko010;
string5 bko011;
string5 jdc010;
string5 jdc011;
string5 jdc012;
string10 jdb004;
string10 jdb005;
string10 jdb006;
string5 jdo013;
string5 jdo014;
string10 jdb002;
string10 jdp016;
string5 lgc004;
string5 pro001;
string5 pro003;
string5 txc010;
string5 txc011;
string1 txb004_sign;
string11 txb004;
string5 txo013;
string1 txb002_sign;
string11 txb002;
string10 txp016;
string5 ucc001;
string5 ucc002;
string5 ucc003;
string8 intelliscore_plus;
string3 percentile_model;
string30 model_action;
string3 score_factor_1;
string3 score_factor_2;
string3 score_factor_3;
string3 score_factor_4;
string6 model_code;
string1 model_type;
string8 last_experian_inquiry_date;
string1 recent_high_credit_sign;
string9 recent_high_credit;
string1 median_credit_amount_sign;
string9 median_credit_amount;
string3 total_combined_trade_lines_count;
string3 dbt_of_combined_trade_totals;
string9 combined_trade_balance;
string5 aged_trade_lines;
string1 experian_credit_rating;
string5 quarter_1_average_dbt;
string5 quarter_2_average_dbt;
string5 quarter_3_average_dbt;
string5 quarter_4_average_dbt;
string5 quarter_5_average_dbt;
string3 combined_dbt;
string1 total_account_balance_sign;
string10 total_account_balance;
string1 combined_account_balance_sign;
string10 combined_account_balance;
string3 collection_count;
string5 atc021;
string5 atc022;
string5 atc023;
string5 atc024;
string5 atc025;
string1 last_activity_age_code;
string1 cottage_indicator;
string1 nonprofit_indicator;
string8 financial_stability_risk_score;
string1 fsr_risk_class;
string3 fsr_score_factor_1;
string3 fsr_score_factor_2;
string3 fsr_score_factor_3;
string3 fsr_score_factor_4;
string1 ip_score_change_sign;
string2 ip_score_change;
string1 fsr_score_change_sign;
string2 fsr_score_change;
string122 dba_name;
string30 recent_update_desc;
string30 years_in_business_desc;
string30 address_type_desc;
string20 employee_size_desc;
string30 annual_sales_size_desc;
string30 location_desc;
string30 primary_sic_code_industry_class_desc;
string30 business_type_desc;
string10 ownership_code_desc;
string30 ucc_data_indicator_desc;
string30 experian_credit_rating_desc;
string20 last_activity_age_desc;
string20 cottage_indicator_desc;
string20 nonprofit_indicator_desc;
string100 company_name;
string5 p_title;
string20 p_fname;
string20 p_mname;
string20 p_lname;
string5 p_name_suffix;
unsigned8 raw_aid;
unsigned8 ace_aid;
string100 prep_addr_line1;
string50 prep_addr_line_last;
unsigned8 source_rec_id;
string10 customerID;
string9  link_fein;
string20 cust_name;
string10 bug_num;
string8 link_inc_date;
End;

Export Experian_CRDB_Base := Experian_CRDB.layouts.Base;

Export Base := Record
Experian_CRDB.layouts.Base;
string20 customerID;
string9  link_fein;
string10 cust_name;
string10 bug_num;
string8 link_inc_date;
End;

Export msa_Layout:=Record
string4    msa_code;
string50			msa_Description	;
End;

END;
