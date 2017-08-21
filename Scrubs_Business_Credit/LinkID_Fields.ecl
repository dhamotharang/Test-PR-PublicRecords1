IMPORT ut,SALT33;
IMPORT scrubs_business_credit,Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT LinkID_Fields := MODULE
// Processing for each FieldType
EXPORT SALT33.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_process_date','invalid_timestamp','invalid_invalid_record_type','invalid_did','invalid_did_score','invalid_dt_first_seen','invalid_dt_last_seen','invalid_dt_vendor_first_reported','invalid_dt_vendor_last_reported','invalid_dt_datawarehouse_first_reported','invalid_dt_datawarehouse_last_reported','invalid_sbfe_contributor_num','invalid_contractacc_num','invalid_extracted_date','invalid_cycleend_date','invalid_accholder_businessname','invalid_cln_accholder_businessname','invalid_dba','invalid_cln_dba','invalid_business_name','invalid_cln_business_name','invalid_comp_website','invalid_first_name','invalid_middle_name','invalid_last_name','invalid_suffix','invalid_e_mail_address','invalid_guarantor_owner_indicator','invalid_relationship_to_business_indicator','invalid_business_title','invalid_cln_title','invalid_cln_fname','invalid_cln_mname','invalid_cln_lname','invalid_cln_suffix','invalid_orig_address_line_1','invalid_orig_address_line_2','invalid_orig_city','invalid_orig_state','invalid_orig_zip_code_or_ca_postal_code','invalid_orig_postal_code','invalid_orig_country_code','invalid_prim_range','invalid_predir','invalid_prim_name','invalid_addr_suffix','invalid_postdir','invalid_unit_desig','invalid_sec_range','invalid_p_city_name','invalid_v_city_name','invalid_st','invalid_zip','invalid_zip4','invalid_orig_area_code','invalid_orig_telephone_number','invalid_telephone_extension','invalid_primary_telephone_indicator','invalid_published_unlisted_indicator','invalid_phonetype','invalid_phonenumber','invalid_federal_tax_id_ssn','invalid_federal_tax_id_ssn_identifier','invalid_dotid','invalid_dotscore','invalid_dotweight','invalid_empid','invalid_empscore','invalid_empweight','invalid_powid','invalid_powscore','invalid_powweight','invalid_proxid','invalid_proxscore','invalid_proxweight','invalid_seleid','invalid_selescore','invalid_seleweight','invalid_orgid','invalid_orgscore','invalid_orgweight','invalid_ultid','invalid_ultscore','invalid_ultweight','invalid_sbfe_id','invalid_legal_busi_structure','invalid_busi_established_date','invalid_accounttypereported','invalid_acc_status1','invalid_acc_status2','invalid_dateaccopened','invalid_dateaccclosed','invalid_accountcloseurebasis','invalid_accexpirationdate','invalid_lastactivitydate','invalid_lastactivitytype','invalid_recentactivityindicator','invalid_origcreditlimit','invalid_highestcreditused','invalid_currentcreditlimit','invalid_reporterindicatorlength','invalid_paymentinterval','invalid_paymentstatuscategory','invalid_termofacc_months','invalid_firstpymtduedate','invalid_finalpymtduedate','invalid_origrate','invalid_graceperiod','invalid_paymentcategory','invalid_pymthistprofile12','invalid_pymthistprofile13_24','invalid_pymthistprofile25_36','invalid_pymthistprofile37_48','invalid_pymthistlength','invalid_ytd_purchasescount','invalid_ltd_purchasescount','invalid_ytd_purchasessumamt','invalid_ltd_purchasessumamt','invalid_pymtamtscheduled','invalid_recentpymtamt','invalid_recentpaymentdate','invalid_remainingbalance','invalid_carriedoveramt','invalid_newappliedcharges','invalid_balloonpymtdue','invalid_balloonpymtduedate','invalid_delinquencydate','invalid_daysdelinquent','invalid_pastdueamt','invalid_maximum_number_bucket','invalid_past_due_aging_bucket_type','invalid_past_due_aging_amount_bucket','invalid_maximum_number_tracking','invalid_payment_tracking_cycle_type','invalid_num','invalid_date_account_was_charged_off','invalid_amount_charged_off_by_creditor','invalid_charge_off_type_indicator','invalid_total_charge_off_recoveries_to_date','invalid_government_guarantee_flag','invalid_government_guarantee_category','invalid_guarantors_indicator','invalid_number_of_guarantors','invalid_owners_indicator','invalid_number_of_principals','invalid_account_update_deletion_indicator','invalid_percent');
EXPORT FieldTypeNum(SALT33.StrType fn) := CASE(fn,'invalid_process_date' => 1,'invalid_timestamp' => 2,'invalid_invalid_record_type' => 3,'invalid_did' => 4,'invalid_did_score' => 5,'invalid_dt_first_seen' => 6,'invalid_dt_last_seen' => 7,'invalid_dt_vendor_first_reported' => 8,'invalid_dt_vendor_last_reported' => 9,'invalid_dt_datawarehouse_first_reported' => 10,'invalid_dt_datawarehouse_last_reported' => 11,'invalid_sbfe_contributor_num' => 12,'invalid_contractacc_num' => 13,'invalid_extracted_date' => 14,'invalid_cycleend_date' => 15,'invalid_accholder_businessname' => 16,'invalid_cln_accholder_businessname' => 17,'invalid_dba' => 18,'invalid_cln_dba' => 19,'invalid_business_name' => 20,'invalid_cln_business_name' => 21,'invalid_comp_website' => 22,'invalid_first_name' => 23,'invalid_middle_name' => 24,'invalid_last_name' => 25,'invalid_suffix' => 26,'invalid_e_mail_address' => 27,'invalid_guarantor_owner_indicator' => 28,'invalid_relationship_to_business_indicator' => 29,'invalid_business_title' => 30,'invalid_cln_title' => 31,'invalid_cln_fname' => 32,'invalid_cln_mname' => 33,'invalid_cln_lname' => 34,'invalid_cln_suffix' => 35,'invalid_orig_address_line_1' => 36,'invalid_orig_address_line_2' => 37,'invalid_orig_city' => 38,'invalid_orig_state' => 39,'invalid_orig_zip_code_or_ca_postal_code' => 40,'invalid_orig_postal_code' => 41,'invalid_orig_country_code' => 42,'invalid_prim_range' => 43,'invalid_predir' => 44,'invalid_prim_name' => 45,'invalid_addr_suffix' => 46,'invalid_postdir' => 47,'invalid_unit_desig' => 48,'invalid_sec_range' => 49,'invalid_p_city_name' => 50,'invalid_v_city_name' => 51,'invalid_st' => 52,'invalid_zip' => 53,'invalid_zip4' => 54,'invalid_orig_area_code' => 55,'invalid_orig_telephone_number' => 56,'invalid_telephone_extension' => 57,'invalid_primary_telephone_indicator' => 58,'invalid_published_unlisted_indicator' => 59,'invalid_phonetype' => 60,'invalid_phonenumber' => 61,'invalid_federal_tax_id_ssn' => 62,'invalid_federal_tax_id_ssn_identifier' => 63,'invalid_dotid' => 64,'invalid_dotscore' => 65,'invalid_dotweight' => 66,'invalid_empid' => 67,'invalid_empscore' => 68,'invalid_empweight' => 69,'invalid_powid' => 70,'invalid_powscore' => 71,'invalid_powweight' => 72,'invalid_proxid' => 73,'invalid_proxscore' => 74,'invalid_proxweight' => 75,'invalid_seleid' => 76,'invalid_selescore' => 77,'invalid_seleweight' => 78,'invalid_orgid' => 79,'invalid_orgscore' => 80,'invalid_orgweight' => 81,'invalid_ultid' => 82,'invalid_ultscore' => 83,'invalid_ultweight' => 84,'invalid_sbfe_id' => 85,'invalid_legal_busi_structure' => 86,'invalid_busi_established_date' => 87,'invalid_accounttypereported' => 88,'invalid_acc_status1' => 89,'invalid_acc_status2' => 90,'invalid_dateaccopened' => 91,'invalid_dateaccclosed' => 92,'invalid_accountcloseurebasis' => 93,'invalid_accexpirationdate' => 94,'invalid_lastactivitydate' => 95,'invalid_lastactivitytype' => 96,'invalid_recentactivityindicator' => 97,'invalid_origcreditlimit' => 98,'invalid_highestcreditused' => 99,'invalid_currentcreditlimit' => 100,'invalid_reporterindicatorlength' => 101,'invalid_paymentinterval' => 102,'invalid_paymentstatuscategory' => 103,'invalid_termofacc_months' => 104,'invalid_firstpymtduedate' => 105,'invalid_finalpymtduedate' => 106,'invalid_origrate' => 107,'invalid_graceperiod' => 108,'invalid_paymentcategory' => 109,'invalid_pymthistprofile12' => 110,'invalid_pymthistprofile13_24' => 111,'invalid_pymthistprofile25_36' => 112,'invalid_pymthistprofile37_48' => 113,'invalid_pymthistlength' => 114,'invalid_ytd_purchasescount' => 115,'invalid_ltd_purchasescount' => 116,'invalid_ytd_purchasessumamt' => 117,'invalid_ltd_purchasessumamt' => 118,'invalid_pymtamtscheduled' => 119,'invalid_recentpymtamt' => 120,'invalid_recentpaymentdate' => 121,'invalid_remainingbalance' => 122,'invalid_carriedoveramt' => 123,'invalid_newappliedcharges' => 124,'invalid_balloonpymtdue' => 125,'invalid_balloonpymtduedate' => 126,'invalid_delinquencydate' => 127,'invalid_daysdelinquent' => 128,'invalid_pastdueamt' => 129,'invalid_maximum_number_bucket' => 130,'invalid_past_due_aging_bucket_type' => 131,'invalid_past_due_aging_amount_bucket' => 132,'invalid_maximum_number_tracking' => 133,'invalid_payment_tracking_cycle_type' => 134,'invalid_num' => 135,'invalid_date_account_was_charged_off' => 136,'invalid_amount_charged_off_by_creditor' => 137,'invalid_charge_off_type_indicator' => 138,'invalid_total_charge_off_recoveries_to_date' => 139,'invalid_government_guarantee_flag' => 140,'invalid_government_guarantee_category' => 141,'invalid_guarantors_indicator' => 142,'invalid_number_of_guarantors' => 143,'invalid_owners_indicator' => 144,'invalid_number_of_principals' => 145,'invalid_account_update_deletion_indicator' => 146,'invalid_percent' => 147,0);
EXPORT MakeFT_invalid_process_date(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrztuvwxyz'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_process_date(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrztuvwxyz'))));
EXPORT InValidMessageFT_invalid_process_date(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrztuvwxyz'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_timestamp(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_timestamp(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_invalid_timestamp(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('0123456789'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_invalid_record_type(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'ABCDFHILMNPSTZ'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_invalid_record_type(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'ABCDFHILMNPSTZ'))));
EXPORT InValidMessageFT_invalid_invalid_record_type(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('ABCDFHILMNPSTZ'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_did(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_did(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_invalid_did(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('0123456789'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_did_score(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_did_score(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_invalid_did_score(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('0123456789'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_dt_first_seen(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_dt_first_seen(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_invalid_dt_first_seen(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('0123456789'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_dt_last_seen(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_dt_last_seen(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_invalid_dt_last_seen(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('0123456789'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_dt_vendor_first_reported(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_dt_vendor_first_reported(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_invalid_dt_vendor_first_reported(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('0123456789'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_dt_vendor_last_reported(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_dt_vendor_last_reported(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_invalid_dt_vendor_last_reported(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('0123456789'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_dt_datawarehouse_first_reported(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_dt_datawarehouse_first_reported(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_invalid_dt_datawarehouse_first_reported(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('0123456789'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_dt_datawarehouse_last_reported(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_dt_datawarehouse_last_reported(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_invalid_dt_datawarehouse_last_reported(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('0123456789'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_sbfe_contributor_num(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789- _'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_sbfe_contributor_num(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789- _'))),~scrubs_business_credit.fn_invalid_SBFEContributorNum(s)>0,~(LENGTH(TRIM(s)) >= 1));
EXPORT InValidMessageFT_invalid_sbfe_contributor_num(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789- _'),SALT33.HygieneErrors.CustomFail('scrubs_business_credit.fn_invalid_SBFEContributorNum'),SALT33.HygieneErrors.NotLength('1..'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_contractacc_num(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789- _'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_contractacc_num(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789- _'))),~(LENGTH(TRIM(s)) >= 1));
EXPORT InValidMessageFT_invalid_contractacc_num(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789- _'),SALT33.HygieneErrors.NotLength('1..'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_extracted_date(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_extracted_date(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'0123456789'))),~Scrubs.fn_valid_date(s)>0,~(LENGTH(TRIM(s)) = 8 OR LENGTH(TRIM(s)) = 6 OR LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_extracted_date(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('0123456789'),SALT33.HygieneErrors.CustomFail('Scrubs.fn_valid_date'),SALT33.HygieneErrors.NotLength('8,6,4,0'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_cycleend_date(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_cycleend_date(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'0123456789'))),~Scrubs.fn_valid_date(s)>0,~(LENGTH(TRIM(s)) = 8 OR LENGTH(TRIM(s)) = 6 OR LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_cycleend_date(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('0123456789'),SALT33.HygieneErrors.CustomFail('Scrubs.fn_valid_date'),SALT33.HygieneErrors.NotLength('8,6,4,0'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_accholder_businessname(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 ,&.\'-/#`+"!*@():;'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_accholder_businessname(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 ,&.\'-/#`+"!*@():;'))));
EXPORT InValidMessageFT_invalid_accholder_businessname(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 ,&.\'-/#`+"!*@():;'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_cln_accholder_businessname(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 ,&.\'-/#`+"!*@():;'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_cln_accholder_businessname(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 ,&.\'-/#`+"!*@():;'))));
EXPORT InValidMessageFT_invalid_cln_accholder_businessname(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 ,&.\'-/#`+"!*@():;'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_dba(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 ,&.\'-/#`+"!*@():;'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_dba(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 ,&.\'-/#`+"!*@():;'))));
EXPORT InValidMessageFT_invalid_dba(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 ,&.\'-/#`+"!*@():;'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_cln_dba(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 ,&.\'-/#`+"!*@():;'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_cln_dba(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 ,&.\'-/#`+"!*@():;'))));
EXPORT InValidMessageFT_invalid_cln_dba(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 ,&.\'-/#`+"!*@():;'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_business_name(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 ,&.\'-/#`+"!*@():;'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_business_name(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 ,&.\'-/#`+"!*@():;'))));
EXPORT InValidMessageFT_invalid_business_name(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 ,&.\'-/#`+"!*@():;'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_cln_business_name(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 ,&.\'-/#`+"!*@():;'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_cln_business_name(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 ,&.\'-/#`+"!*@():;'))));
EXPORT InValidMessageFT_invalid_cln_business_name(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 ,&.\'-/#`+"!*@():;'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_comp_website(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789. /:-'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_comp_website(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789. /:-'))));
EXPORT InValidMessageFT_invalid_comp_website(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789. /:-'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_first_name(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ -/\''); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_first_name(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ -/\''))));
EXPORT InValidMessageFT_invalid_first_name(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ -/\''),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_middle_name(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ -/\''); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_middle_name(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ -/\''))));
EXPORT InValidMessageFT_invalid_middle_name(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ -/\''),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_last_name(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ -/\''); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_last_name(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ -/\''))));
EXPORT InValidMessageFT_invalid_last_name(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ -/\''),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_suffix(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ.'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_suffix(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ.'))));
EXPORT InValidMessageFT_invalid_suffix(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ.'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_e_mail_address(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789@._-;'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_e_mail_address(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789@._-;'))));
EXPORT InValidMessageFT_invalid_e_mail_address(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789@._-;'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_guarantor_owner_indicator(SALT33.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_guarantor_owner_indicator(SALT33.StrType s) := WHICH(((SALT33.StrType) s) NOT IN ['001','002','003','01','02','03','1','2','3','','']);
EXPORT InValidMessageFT_invalid_guarantor_owner_indicator(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInEnum('001|002|003|01|02|03|1|2|3||'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_relationship_to_business_indicator(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_relationship_to_business_indicator(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_invalid_relationship_to_business_indicator(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('0123456789'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_business_title(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_business_title(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'))));
EXPORT InValidMessageFT_invalid_business_title(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_cln_title(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ -/\''); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_cln_title(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ -/\''))));
EXPORT InValidMessageFT_invalid_cln_title(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ -/\''),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_cln_fname(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ -/\''); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_cln_fname(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ -/\''))));
EXPORT InValidMessageFT_invalid_cln_fname(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ -/\''),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_cln_mname(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ -/\''); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_cln_mname(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ -/\''))));
EXPORT InValidMessageFT_invalid_cln_mname(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ -/\''),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_cln_lname(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ -/\''); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_cln_lname(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ -/\''))));
EXPORT InValidMessageFT_invalid_cln_lname(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ -/\''),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_cln_suffix(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ -/\''); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_cln_suffix(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ -/\''))));
EXPORT InValidMessageFT_invalid_cln_suffix(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ -/\''),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_orig_address_line_1(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 .:-#/\',&#'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_orig_address_line_1(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 .:-#/\',&#'))));
EXPORT InValidMessageFT_invalid_orig_address_line_1(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 .:-#/\',&#'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_orig_address_line_2(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 \\\':&-.#/,'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_orig_address_line_2(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 \\\':&-.#/,'))));
EXPORT InValidMessageFT_invalid_orig_address_line_2(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 \\\':&-.#/,'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_orig_city(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ -.\''); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_orig_city(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ -.\''))));
EXPORT InValidMessageFT_invalid_orig_city(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ -.\''),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_orig_state(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_orig_state(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'))));
EXPORT InValidMessageFT_invalid_orig_state(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_orig_zip_code_or_ca_postal_code(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_orig_zip_code_or_ca_postal_code(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'))));
EXPORT InValidMessageFT_invalid_orig_zip_code_or_ca_postal_code(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_orig_postal_code(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'0123456789\''); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_orig_postal_code(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'0123456789\''))));
EXPORT InValidMessageFT_invalid_orig_postal_code(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('0123456789\''),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_orig_country_code(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_orig_country_code(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'))));
EXPORT InValidMessageFT_invalid_orig_country_code(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_prim_range(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789/ -.\''); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_prim_range(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789/ -.\''))));
EXPORT InValidMessageFT_invalid_prim_range(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789/ -.\''),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_predir(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789/ -.\''); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_predir(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789/ -.\''))));
EXPORT InValidMessageFT_invalid_predir(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789/ -.\''),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_prim_name(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789/ -.\''); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_prim_name(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789/ -.\''))));
EXPORT InValidMessageFT_invalid_prim_name(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789/ -.\''),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_addr_suffix(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789/ -.\''); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_addr_suffix(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789/ -.\''))));
EXPORT InValidMessageFT_invalid_addr_suffix(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789/ -.\''),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_postdir(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789/ -.\''); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_postdir(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789/ -.\''))));
EXPORT InValidMessageFT_invalid_postdir(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789/ -.\''),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_unit_desig(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789/ -.\''); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_unit_desig(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789/ -.\''))));
EXPORT InValidMessageFT_invalid_unit_desig(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789/ -.\''),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_sec_range(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789/ -.\''); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_sec_range(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789/ -.\''))));
EXPORT InValidMessageFT_invalid_sec_range(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789/ -.\''),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_p_city_name(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789/ -.\''); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_p_city_name(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789/ -.\''))));
EXPORT InValidMessageFT_invalid_p_city_name(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789/ -.\''),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_v_city_name(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789/ -.\''); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_v_city_name(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789/ -.\''))));
EXPORT InValidMessageFT_invalid_v_city_name(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789/ -.\''),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_st(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_st(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'))));
EXPORT InValidMessageFT_invalid_st(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_zip(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'0123456789\''); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_zip(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'0123456789\''))));
EXPORT InValidMessageFT_invalid_zip(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('0123456789\''),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_zip4(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'0123456789\''); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_zip4(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'0123456789\''))));
EXPORT InValidMessageFT_invalid_zip4(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('0123456789\''),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_orig_area_code(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_orig_area_code(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'0123456789 '))));
EXPORT InValidMessageFT_invalid_orig_area_code(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('0123456789 '),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_orig_telephone_number(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_orig_telephone_number(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_invalid_orig_telephone_number(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('0123456789'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_telephone_extension(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_telephone_extension(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 '))));
EXPORT InValidMessageFT_invalid_telephone_extension(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 '),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_primary_telephone_indicator(SALT33.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_primary_telephone_indicator(SALT33.StrType s) := WHICH(((SALT33.StrType) s) NOT IN ['Y','N','']);
EXPORT InValidMessageFT_invalid_primary_telephone_indicator(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInEnum('Y|N|'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_published_unlisted_indicator(SALT33.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_published_unlisted_indicator(SALT33.StrType s) := WHICH(((SALT33.StrType) s) NOT IN ['001','002','']);
EXPORT InValidMessageFT_invalid_published_unlisted_indicator(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInEnum('001|002|'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_phonetype(SALT33.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_phonetype(SALT33.StrType s) := WHICH(((SALT33.StrType) s) NOT IN ['001','002','003','004','']);
EXPORT InValidMessageFT_invalid_phonetype(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInEnum('001|002|003|004|'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_phonenumber(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_phonenumber(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'0123456789 '))));
EXPORT InValidMessageFT_invalid_phonenumber(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('0123456789 '),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_federal_tax_id_ssn(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'0123456789X'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_federal_tax_id_ssn(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'0123456789X'))));
EXPORT InValidMessageFT_invalid_federal_tax_id_ssn(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('0123456789X'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_federal_tax_id_ssn_identifier(SALT33.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_federal_tax_id_ssn_identifier(SALT33.StrType s) := WHICH(((SALT33.StrType) s) NOT IN ['001','002','']);
EXPORT InValidMessageFT_invalid_federal_tax_id_ssn_identifier(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInEnum('001|002|'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_dotid(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_dotid(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_invalid_dotid(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('0123456789'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_dotscore(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_dotscore(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_invalid_dotscore(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('0123456789'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_dotweight(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_dotweight(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_invalid_dotweight(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('0123456789'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_empid(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_empid(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_invalid_empid(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('0123456789'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_empscore(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_empscore(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_invalid_empscore(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('0123456789'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_empweight(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_empweight(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_invalid_empweight(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('0123456789'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_powid(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_powid(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_invalid_powid(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('0123456789'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_powscore(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_powscore(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_invalid_powscore(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('0123456789'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_powweight(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_powweight(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_invalid_powweight(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('0123456789'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_proxid(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_proxid(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_invalid_proxid(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('0123456789'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_proxscore(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_proxscore(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_invalid_proxscore(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('0123456789'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_proxweight(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_proxweight(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_invalid_proxweight(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('0123456789'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_seleid(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_seleid(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_invalid_seleid(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('0123456789'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_selescore(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_selescore(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_invalid_selescore(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('0123456789'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_seleweight(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_seleweight(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_invalid_seleweight(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('0123456789'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_orgid(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_orgid(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_invalid_orgid(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('0123456789'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_orgscore(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_orgscore(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_invalid_orgscore(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('0123456789'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_orgweight(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_orgweight(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_invalid_orgweight(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('0123456789'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_ultid(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_ultid(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_invalid_ultid(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('0123456789'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_ultscore(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_ultscore(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_invalid_ultscore(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('0123456789'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_ultweight(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_ultweight(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_invalid_ultweight(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('0123456789'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_sbfe_id(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_sbfe_id(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_invalid_sbfe_id(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('0123456789'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_legal_busi_structure(SALT33.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_legal_busi_structure(SALT33.StrType s) := WHICH(((SALT33.StrType) s) NOT IN ['001','002','003','004','005','006','007','008','009','010','011','012','013','014','015','016','050','051','052','053','070','071','080','']);
EXPORT InValidMessageFT_invalid_legal_busi_structure(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInEnum('001|002|003|004|005|006|007|008|009|010|011|012|013|014|015|016|050|051|052|053|070|071|080|'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_busi_established_date(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_busi_established_date(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 8 OR LENGTH(TRIM(s)) = 6 OR LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_busi_established_date(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('0123456789'),SALT33.HygieneErrors.NotLength('8,6,4,0'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_accounttypereported(SALT33.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_accounttypereported(SALT33.StrType s) := WHICH(((SALT33.StrType) s) NOT IN ['001','002','003','004','005','006','099']);
EXPORT InValidMessageFT_invalid_accounttypereported(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInEnum('001|002|003|004|005|006|099'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_acc_status1(SALT33.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_acc_status1(SALT33.StrType s) := WHICH(((SALT33.StrType) s) NOT IN ['001','002','003','004','005','006','007','008','009','010','011','012','013','014','015','016','017','018','019','020','021','022','']);
EXPORT InValidMessageFT_invalid_acc_status1(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInEnum('001|002|003|004|005|006|007|008|009|010|011|012|013|014|015|016|017|018|019|020|021|022|'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_acc_status2(SALT33.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_acc_status2(SALT33.StrType s) := WHICH(((SALT33.StrType) s) NOT IN ['001','002','003','004','005','006','007','008','009','010','011','012','013','014','015','016','017','018','019','020','021','022','']);
EXPORT InValidMessageFT_invalid_acc_status2(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInEnum('001|002|003|004|005|006|007|008|009|010|011|012|013|014|015|016|017|018|019|020|021|022|'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_dateaccopened(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_dateaccopened(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'0123456789'))),~Scrubs.fn_valid_date(s)>0,~(LENGTH(TRIM(s)) = 8 OR LENGTH(TRIM(s)) = 6 OR LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_dateaccopened(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('0123456789'),SALT33.HygieneErrors.CustomFail('Scrubs.fn_valid_date'),SALT33.HygieneErrors.NotLength('8,6,4,0'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_dateaccclosed(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_dateaccclosed(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'0123456789'))),~Scrubs.fn_valid_date(s)>0,~(LENGTH(TRIM(s)) = 8 OR LENGTH(TRIM(s)) = 6 OR LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_dateaccclosed(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('0123456789'),SALT33.HygieneErrors.CustomFail('Scrubs.fn_valid_date'),SALT33.HygieneErrors.NotLength('8,6,4,0'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_accountcloseurebasis(SALT33.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_accountcloseurebasis(SALT33.StrType s) := WHICH(((SALT33.StrType) s) NOT IN ['V','X','F','B','P','O','']);
EXPORT InValidMessageFT_invalid_accountcloseurebasis(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInEnum('V|X|F|B|P|O|'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_accexpirationdate(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_accexpirationdate(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'0123456789'))),~Scrubs.fn_valid_date(s,'F')>0,~(LENGTH(TRIM(s)) = 8 OR LENGTH(TRIM(s)) = 6 OR LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_accexpirationdate(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('0123456789'),SALT33.HygieneErrors.CustomFail('Scrubs.fn_valid_date'),SALT33.HygieneErrors.NotLength('8,6,4,0'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_lastactivitydate(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_lastactivitydate(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'0123456789'))),~Scrubs.fn_valid_date(s)>0,~(LENGTH(TRIM(s)) = 8 OR LENGTH(TRIM(s)) = 6 OR LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_lastactivitydate(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('0123456789'),SALT33.HygieneErrors.CustomFail('Scrubs.fn_valid_date'),SALT33.HygieneErrors.NotLength('8,6,4,0'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_lastactivitytype(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_lastactivitytype(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_invalid_lastactivitytype(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('0123456789'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_recentactivityindicator(SALT33.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_recentactivityindicator(SALT33.StrType s) := WHICH(((SALT33.StrType) s) NOT IN ['Y','N','']);
EXPORT InValidMessageFT_invalid_recentactivityindicator(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInEnum('Y|N|'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_origcreditlimit(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_origcreditlimit(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_invalid_origcreditlimit(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('0123456789'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_highestcreditused(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_highestcreditused(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_invalid_highestcreditused(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('0123456789'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_currentcreditlimit(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'0123456789-'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_currentcreditlimit(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'0123456789-'))));
EXPORT InValidMessageFT_invalid_currentcreditlimit(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('0123456789-'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_reporterindicatorlength(SALT33.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_reporterindicatorlength(SALT33.StrType s) := WHICH(((SALT33.StrType) s) NOT IN ['001','002','003','999','']);
EXPORT InValidMessageFT_invalid_reporterindicatorlength(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInEnum('001|002|003|999|'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_paymentinterval(SALT33.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_paymentinterval(SALT33.StrType s) := WHICH(((SALT33.StrType) s) NOT IN ['A','Q','S','SA','SM','SP','BM','BW','D','M','W','']);
EXPORT InValidMessageFT_invalid_paymentinterval(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInEnum('A|Q|S|SA|SM|SP|BM|BW|D|M|W|'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_paymentstatuscategory(SALT33.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_paymentstatuscategory(SALT33.StrType s) := WHICH(((SALT33.StrType) s) NOT IN ['000','001','002','003','004','005','006','007','00','01','02','03','04','05','06','07','0','1','2','3','4','5','6','7','']);
EXPORT InValidMessageFT_invalid_paymentstatuscategory(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInEnum('000|001|002|003|004|005|006|007|00|01|02|03|04|05|06|07|0|1|2|3|4|5|6|7|'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_termofacc_months(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_termofacc_months(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_invalid_termofacc_months(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('0123456789'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_firstpymtduedate(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_firstpymtduedate(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'0123456789'))),~Scrubs.fn_valid_date(s,'F')>0,~(LENGTH(TRIM(s)) = 8 OR LENGTH(TRIM(s)) = 6 OR LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_firstpymtduedate(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('0123456789'),SALT33.HygieneErrors.CustomFail('Scrubs.fn_valid_date'),SALT33.HygieneErrors.NotLength('8,6,4,0'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_finalpymtduedate(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_finalpymtduedate(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'0123456789'))),~Scrubs.fn_valid_date(s,'F')>0,~(LENGTH(TRIM(s)) = 8 OR LENGTH(TRIM(s)) = 6 OR LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_finalpymtduedate(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('0123456789'),SALT33.HygieneErrors.CustomFail('Scrubs.fn_valid_date'),SALT33.HygieneErrors.NotLength('8,6,4,0'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_origrate(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'0123456789.'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_origrate(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'0123456789.'))));
EXPORT InValidMessageFT_invalid_origrate(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('0123456789.'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_graceperiod(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_graceperiod(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_invalid_graceperiod(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('0123456789'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_paymentcategory(SALT33.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_paymentcategory(SALT33.StrType s) := WHICH(((SALT33.StrType) s) NOT IN ['001','002','003','004','005','006','007','008','009','099','']);
EXPORT InValidMessageFT_invalid_paymentcategory(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInEnum('001|002|003|004|005|006|007|008|009|099|'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_pymthistprofile12(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'0123456LBDEGHJK'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_pymthistprofile12(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'0123456LBDEGHJK'))));
EXPORT InValidMessageFT_invalid_pymthistprofile12(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('0123456LBDEGHJK'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_pymthistprofile13_24(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'0123456LBDEGHJK'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_pymthistprofile13_24(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'0123456LBDEGHJK'))));
EXPORT InValidMessageFT_invalid_pymthistprofile13_24(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('0123456LBDEGHJK'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_pymthistprofile25_36(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'0123456LBDEGHJK'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_pymthistprofile25_36(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'0123456LBDEGHJK'))));
EXPORT InValidMessageFT_invalid_pymthistprofile25_36(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('0123456LBDEGHJK'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_pymthistprofile37_48(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'0123456LBDEGHJK'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_pymthistprofile37_48(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'0123456LBDEGHJK'))));
EXPORT InValidMessageFT_invalid_pymthistprofile37_48(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('0123456LBDEGHJK'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_pymthistlength(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_pymthistlength(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_invalid_pymthistlength(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('0123456789'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_ytd_purchasescount(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_ytd_purchasescount(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_invalid_ytd_purchasescount(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('0123456789'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_ltd_purchasescount(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_ltd_purchasescount(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_invalid_ltd_purchasescount(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('0123456789'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_ytd_purchasessumamt(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_ytd_purchasessumamt(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_invalid_ytd_purchasessumamt(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('0123456789'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_ltd_purchasessumamt(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_ltd_purchasessumamt(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_invalid_ltd_purchasessumamt(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('0123456789'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_pymtamtscheduled(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_pymtamtscheduled(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_invalid_pymtamtscheduled(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('0123456789'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_recentpymtamt(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'0123456789-'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_recentpymtamt(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'0123456789-'))));
EXPORT InValidMessageFT_invalid_recentpymtamt(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('0123456789-'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_recentpaymentdate(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_recentpaymentdate(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'0123456789'))),~Scrubs.fn_valid_date(s)>0,~(LENGTH(TRIM(s)) = 8 OR LENGTH(TRIM(s)) = 6 OR LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_recentpaymentdate(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('0123456789'),SALT33.HygieneErrors.CustomFail('Scrubs.fn_valid_date'),SALT33.HygieneErrors.NotLength('8,6,4,0'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_remainingbalance(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'0123456789-'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_remainingbalance(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'0123456789-'))));
EXPORT InValidMessageFT_invalid_remainingbalance(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('0123456789-'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_carriedoveramt(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'0123456789-'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_carriedoveramt(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'0123456789-'))));
EXPORT InValidMessageFT_invalid_carriedoveramt(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('0123456789-'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_newappliedcharges(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_newappliedcharges(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_invalid_newappliedcharges(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('0123456789'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_balloonpymtdue(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_balloonpymtdue(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_invalid_balloonpymtdue(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('0123456789'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_balloonpymtduedate(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_balloonpymtduedate(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'0123456789'))),~Scrubs.fn_valid_date(s,'F')>0,~(LENGTH(TRIM(s)) = 8 OR LENGTH(TRIM(s)) = 6 OR LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_balloonpymtduedate(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('0123456789'),SALT33.HygieneErrors.CustomFail('Scrubs.fn_valid_date'),SALT33.HygieneErrors.NotLength('8,6,4,0'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_delinquencydate(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_delinquencydate(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'0123456789'))),~Scrubs.fn_valid_date(s)>0,~(LENGTH(TRIM(s)) = 8 OR LENGTH(TRIM(s)) = 6 OR LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_delinquencydate(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('0123456789'),SALT33.HygieneErrors.CustomFail('Scrubs.fn_valid_date'),SALT33.HygieneErrors.NotLength('8,6,4,0'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_daysdelinquent(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_daysdelinquent(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_invalid_daysdelinquent(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('0123456789'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_pastdueamt(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'0123456789-'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_pastdueamt(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'0123456789-'))));
EXPORT InValidMessageFT_invalid_pastdueamt(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('0123456789-'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_maximum_number_bucket(SALT33.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_maximum_number_bucket(SALT33.StrType s) := WHICH(((SALT33.StrType) s) NOT IN ['001','002','003','004','005','006','007','']);
EXPORT InValidMessageFT_invalid_maximum_number_bucket(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInEnum('001|002|003|004|005|006|007|'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_past_due_aging_bucket_type(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_past_due_aging_bucket_type(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_invalid_past_due_aging_bucket_type(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('0123456789'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_past_due_aging_amount_bucket(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'0123456789-'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_past_due_aging_amount_bucket(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'0123456789-'))));
EXPORT InValidMessageFT_invalid_past_due_aging_amount_bucket(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('0123456789-'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_maximum_number_tracking(SALT33.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_maximum_number_tracking(SALT33.StrType s) := WHICH(((SALT33.StrType) s) NOT IN ['000','001','002','003','004','005','006','007','']);
EXPORT InValidMessageFT_invalid_maximum_number_tracking(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInEnum('000|001|002|003|004|005|006|007|'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_payment_tracking_cycle_type(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_payment_tracking_cycle_type(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_invalid_payment_tracking_cycle_type(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('0123456789'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_num(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_num(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_invalid_num(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('0123456789'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_date_account_was_charged_off(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_date_account_was_charged_off(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'0123456789'))),~Scrubs.fn_valid_date(s)>0,~(LENGTH(TRIM(s)) = 8 OR LENGTH(TRIM(s)) = 6 OR LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_date_account_was_charged_off(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('0123456789'),SALT33.HygieneErrors.CustomFail('Scrubs.fn_valid_date'),SALT33.HygieneErrors.NotLength('8,6,4,0'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_amount_charged_off_by_creditor(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_amount_charged_off_by_creditor(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_invalid_amount_charged_off_by_creditor(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('0123456789'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_charge_off_type_indicator(SALT33.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_charge_off_type_indicator(SALT33.StrType s) := WHICH(((SALT33.StrType) s) NOT IN ['001','002','003','']);
EXPORT InValidMessageFT_invalid_charge_off_type_indicator(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInEnum('001|002|003|'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_total_charge_off_recoveries_to_date(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'0123456789-'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_total_charge_off_recoveries_to_date(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'0123456789-'))));
EXPORT InValidMessageFT_invalid_total_charge_off_recoveries_to_date(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('0123456789-'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_government_guarantee_flag(SALT33.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_government_guarantee_flag(SALT33.StrType s) := WHICH(((SALT33.StrType) s) NOT IN ['Y','N','']);
EXPORT InValidMessageFT_invalid_government_guarantee_flag(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInEnum('Y|N|'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_government_guarantee_category(SALT33.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_government_guarantee_category(SALT33.StrType s) := WHICH(((SALT33.StrType) s) NOT IN ['001','002','003','004','005','006','007','100','200','300','400','500','600','700','800','810','']);
EXPORT InValidMessageFT_invalid_government_guarantee_category(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInEnum('001|002|003|004|005|006|007|100|200|300|400|500|600|700|800|810|'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_guarantors_indicator(SALT33.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_guarantors_indicator(SALT33.StrType s) := WHICH(((SALT33.StrType) s) NOT IN ['Y','N','']);
EXPORT InValidMessageFT_invalid_guarantors_indicator(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInEnum('Y|N|'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_number_of_guarantors(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_number_of_guarantors(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_invalid_number_of_guarantors(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('0123456789'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_owners_indicator(SALT33.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_owners_indicator(SALT33.StrType s) := WHICH(((SALT33.StrType) s) NOT IN ['Y','N','']);
EXPORT InValidMessageFT_invalid_owners_indicator(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInEnum('Y|N|'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_number_of_principals(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_number_of_principals(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_invalid_number_of_principals(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('0123456789'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_account_update_deletion_indicator(SALT33.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_account_update_deletion_indicator(SALT33.StrType s) := WHICH(((SALT33.StrType) s) NOT IN ['000','001','002','003','080','090','0','','']);
EXPORT InValidMessageFT_invalid_account_update_deletion_indicator(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInEnum('000|001|002|003|080|090|0||'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_percent(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_percent(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_invalid_percent(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('0123456789'),SALT33.HygieneErrors.Good);
EXPORT SALT33.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'timestamp','process_date','record_type','did','did_score','dt_first_seen','dt_last_seen','dt_vendor_first_reported','dt_vendor_last_reported','dt_datawarehouse_first_reported','dt_datawarehouse_last_reported','sbfe_contributor_number','contract_account_number','account_type_reported','extracted_date','cycle_end_date','account_holder_business_name','clean_account_holder_business_name','dba','clean_dba','business_name','clean_business_name','company_website','original_fname','original_mname','original_lname','original_suffix','e_mail_address','guarantor_owner_indicator','relationship_to_business_indicator','business_title','clean_title','clean_fname','clean_mname','clean_lname','clean_suffix','original_address_line_1','original_address_line_2','original_city','original_state','original_zip_code_or_ca_postal_code','original_postal_code','original_country_code','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dbpc','chk_digit','rec_type','fips_state','fips_county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','rawaid','original_area_code','original_phone_number','phone_extension','primary_phone_indicator','published_unlisted_indicator','phone_type','phone_number','federal_taxid_ssn','federal_taxid_ssn_identifier','dotid','dotscore','dotweight','empid','empscore','empweight','powid','powscore','powweight','proxid','proxscore','proxweight','seleid','selescore','seleweight','orgid','orgscore','orgweight','ultid','ultscore','ultweight','persistent_record_id','sbfe_id','source','active','legal_business_structure','business_established_date','account_status_1','account_status_2','date_account_opened','date_account_closed','account_closure_basis','account_expiration_date','last_activity_date','last_activity_type','recent_activity_indicator','original_credit_limit','highest_credit_used','current_credit_limit','reporting_indicator_length','payment_interval','payment_status_category','term_of_account_in_months','first_payment_due_date','final_payment_due_date','original_rate','floating_rate','grace_period','payment_category','payment_history_profile_12_months','payment_history_profile_13_24_months','payment_history_profile_25_36_months','payment_history_profile_37_48_months','payment_history_length','year_to_date_purchases_count','lifetime_to_date_purchases_count','year_to_date_purchases_sum_amount','lifetime_to_date_purchases_sum_amount','payment_amount_scheduled','recent_payment_amount','recent_payment_date','remaining_balance','carried_over_amount','new_applied_charges','balloon_payment_due','balloon_payment_due_date','delinquency_date','days_delinquent','past_due_amount','maximum_number_of_past_due_aging_amounts_buckets_provided','past_due_aging_bucket_type','past_due_aging_amount_bucket_1','past_due_aging_amount_bucket_2','past_due_aging_amount_bucket_3','past_due_aging_amount_bucket_4','past_due_aging_amount_bucket_5','past_due_aging_amount_bucket_6','past_due_aging_amount_bucket_7','maximum_number_of_payment_tracking_cycle_periods_provided','payment_tracking_cycle_type','payment_tracking_cycle_0_current','payment_tracking_cycle_1_1_to_30_days','payment_tracking_cycle_2_31_to_60_days','payment_tracking_cycle_3_61_to_90_days','payment_tracking_cycle_4_91_to_120_days','payment_tracking_cycle_5_121_to_150days','payment_tracking_number_of_times_cycle_6_151_to_180_days','payment_tracking_number_of_times_cycle_7_181_or_greater_days','date_account_was_charged_off','amount_charged_off_by_creditor','charge_off_type_indicator','total_charge_off_recoveries_to_date','government_guarantee_flag','government_guarantee_category','portion_of_account_guaranteed_by_government','guarantors_indicator','number_of_guarantors','owners_indicator','number_of_principals','account_update_deletion_indicator','percent_of_liability','percent_of_ownership');
EXPORT FieldNum(SALT33.StrType fn) := CASE(fn,'timestamp' => 0,'process_date' => 1,'record_type' => 2,'did' => 3,'did_score' => 4,'dt_first_seen' => 5,'dt_last_seen' => 6,'dt_vendor_first_reported' => 7,'dt_vendor_last_reported' => 8,'dt_datawarehouse_first_reported' => 9,'dt_datawarehouse_last_reported' => 10,'sbfe_contributor_number' => 11,'contract_account_number' => 12,'account_type_reported' => 13,'extracted_date' => 14,'cycle_end_date' => 15,'account_holder_business_name' => 16,'clean_account_holder_business_name' => 17,'dba' => 18,'clean_dba' => 19,'business_name' => 20,'clean_business_name' => 21,'company_website' => 22,'original_fname' => 23,'original_mname' => 24,'original_lname' => 25,'original_suffix' => 26,'e_mail_address' => 27,'guarantor_owner_indicator' => 28,'relationship_to_business_indicator' => 29,'business_title' => 30,'clean_title' => 31,'clean_fname' => 32,'clean_mname' => 33,'clean_lname' => 34,'clean_suffix' => 35,'original_address_line_1' => 36,'original_address_line_2' => 37,'original_city' => 38,'original_state' => 39,'original_zip_code_or_ca_postal_code' => 40,'original_postal_code' => 41,'original_country_code' => 42,'prim_range' => 43,'predir' => 44,'prim_name' => 45,'addr_suffix' => 46,'postdir' => 47,'unit_desig' => 48,'sec_range' => 49,'p_city_name' => 50,'v_city_name' => 51,'st' => 52,'zip' => 53,'zip4' => 54,'cart' => 55,'cr_sort_sz' => 56,'lot' => 57,'lot_order' => 58,'dbpc' => 59,'chk_digit' => 60,'rec_type' => 61,'fips_state' => 62,'fips_county' => 63,'geo_lat' => 64,'geo_long' => 65,'msa' => 66,'geo_blk' => 67,'geo_match' => 68,'err_stat' => 69,'rawaid' => 70,'original_area_code' => 71,'original_phone_number' => 72,'phone_extension' => 73,'primary_phone_indicator' => 74,'published_unlisted_indicator' => 75,'phone_type' => 76,'phone_number' => 77,'federal_taxid_ssn' => 78,'federal_taxid_ssn_identifier' => 79,'dotid' => 80,'dotscore' => 81,'dotweight' => 82,'empid' => 83,'empscore' => 84,'empweight' => 85,'powid' => 86,'powscore' => 87,'powweight' => 88,'proxid' => 89,'proxscore' => 90,'proxweight' => 91,'seleid' => 92,'selescore' => 93,'seleweight' => 94,'orgid' => 95,'orgscore' => 96,'orgweight' => 97,'ultid' => 98,'ultscore' => 99,'ultweight' => 100,'persistent_record_id' => 101,'sbfe_id' => 102,'source' => 103,'active' => 104,'legal_business_structure' => 105,'business_established_date' => 106,'account_status_1' => 107,'account_status_2' => 108,'date_account_opened' => 109,'date_account_closed' => 110,'account_closure_basis' => 111,'account_expiration_date' => 112,'last_activity_date' => 113,'last_activity_type' => 114,'recent_activity_indicator' => 115,'original_credit_limit' => 116,'highest_credit_used' => 117,'current_credit_limit' => 118,'reporting_indicator_length' => 119,'payment_interval' => 120,'payment_status_category' => 121,'term_of_account_in_months' => 122,'first_payment_due_date' => 123,'final_payment_due_date' => 124,'original_rate' => 125,'floating_rate' => 126,'grace_period' => 127,'payment_category' => 128,'payment_history_profile_12_months' => 129,'payment_history_profile_13_24_months' => 130,'payment_history_profile_25_36_months' => 131,'payment_history_profile_37_48_months' => 132,'payment_history_length' => 133,'year_to_date_purchases_count' => 134,'lifetime_to_date_purchases_count' => 135,'year_to_date_purchases_sum_amount' => 136,'lifetime_to_date_purchases_sum_amount' => 137,'payment_amount_scheduled' => 138,'recent_payment_amount' => 139,'recent_payment_date' => 140,'remaining_balance' => 141,'carried_over_amount' => 142,'new_applied_charges' => 143,'balloon_payment_due' => 144,'balloon_payment_due_date' => 145,'delinquency_date' => 146,'days_delinquent' => 147,'past_due_amount' => 148,'maximum_number_of_past_due_aging_amounts_buckets_provided' => 149,'past_due_aging_bucket_type' => 150,'past_due_aging_amount_bucket_1' => 151,'past_due_aging_amount_bucket_2' => 152,'past_due_aging_amount_bucket_3' => 153,'past_due_aging_amount_bucket_4' => 154,'past_due_aging_amount_bucket_5' => 155,'past_due_aging_amount_bucket_6' => 156,'past_due_aging_amount_bucket_7' => 157,'maximum_number_of_payment_tracking_cycle_periods_provided' => 158,'payment_tracking_cycle_type' => 159,'payment_tracking_cycle_0_current' => 160,'payment_tracking_cycle_1_1_to_30_days' => 161,'payment_tracking_cycle_2_31_to_60_days' => 162,'payment_tracking_cycle_3_61_to_90_days' => 163,'payment_tracking_cycle_4_91_to_120_days' => 164,'payment_tracking_cycle_5_121_to_150days' => 165,'payment_tracking_number_of_times_cycle_6_151_to_180_days' => 166,'payment_tracking_number_of_times_cycle_7_181_or_greater_days' => 167,'date_account_was_charged_off' => 168,'amount_charged_off_by_creditor' => 169,'charge_off_type_indicator' => 170,'total_charge_off_recoveries_to_date' => 171,'government_guarantee_flag' => 172,'government_guarantee_category' => 173,'portion_of_account_guaranteed_by_government' => 174,'guarantors_indicator' => 175,'number_of_guarantors' => 176,'owners_indicator' => 177,'number_of_principals' => 178,'account_update_deletion_indicator' => 179,'percent_of_liability' => 180,'percent_of_ownership' => 181,0);
//Individual field level validation
EXPORT Make_timestamp(SALT33.StrType s0) := MakeFT_invalid_timestamp(s0);
EXPORT InValid_timestamp(SALT33.StrType s) := InValidFT_invalid_timestamp(s);
EXPORT InValidMessage_timestamp(UNSIGNED1 wh) := InValidMessageFT_invalid_timestamp(wh);
EXPORT Make_process_date(SALT33.StrType s0) := MakeFT_invalid_process_date(s0);
EXPORT InValid_process_date(SALT33.StrType s) := InValidFT_invalid_process_date(s);
EXPORT InValidMessage_process_date(UNSIGNED1 wh) := InValidMessageFT_invalid_process_date(wh);
EXPORT Make_record_type(SALT33.StrType s0) := MakeFT_invalid_invalid_record_type(s0);
EXPORT InValid_record_type(SALT33.StrType s) := InValidFT_invalid_invalid_record_type(s);
EXPORT InValidMessage_record_type(UNSIGNED1 wh) := InValidMessageFT_invalid_invalid_record_type(wh);
EXPORT Make_did(SALT33.StrType s0) := MakeFT_invalid_did(s0);
EXPORT InValid_did(SALT33.StrType s) := InValidFT_invalid_did(s);
EXPORT InValidMessage_did(UNSIGNED1 wh) := InValidMessageFT_invalid_did(wh);
EXPORT Make_did_score(SALT33.StrType s0) := MakeFT_invalid_did_score(s0);
EXPORT InValid_did_score(SALT33.StrType s) := InValidFT_invalid_did_score(s);
EXPORT InValidMessage_did_score(UNSIGNED1 wh) := InValidMessageFT_invalid_did_score(wh);
EXPORT Make_dt_first_seen(SALT33.StrType s0) := MakeFT_invalid_dt_first_seen(s0);
EXPORT InValid_dt_first_seen(SALT33.StrType s) := InValidFT_invalid_dt_first_seen(s);
EXPORT InValidMessage_dt_first_seen(UNSIGNED1 wh) := InValidMessageFT_invalid_dt_first_seen(wh);
EXPORT Make_dt_last_seen(SALT33.StrType s0) := MakeFT_invalid_dt_last_seen(s0);
EXPORT InValid_dt_last_seen(SALT33.StrType s) := InValidFT_invalid_dt_last_seen(s);
EXPORT InValidMessage_dt_last_seen(UNSIGNED1 wh) := InValidMessageFT_invalid_dt_last_seen(wh);
EXPORT Make_dt_vendor_first_reported(SALT33.StrType s0) := MakeFT_invalid_dt_vendor_first_reported(s0);
EXPORT InValid_dt_vendor_first_reported(SALT33.StrType s) := InValidFT_invalid_dt_vendor_first_reported(s);
EXPORT InValidMessage_dt_vendor_first_reported(UNSIGNED1 wh) := InValidMessageFT_invalid_dt_vendor_first_reported(wh);
EXPORT Make_dt_vendor_last_reported(SALT33.StrType s0) := MakeFT_invalid_dt_vendor_last_reported(s0);
EXPORT InValid_dt_vendor_last_reported(SALT33.StrType s) := InValidFT_invalid_dt_vendor_last_reported(s);
EXPORT InValidMessage_dt_vendor_last_reported(UNSIGNED1 wh) := InValidMessageFT_invalid_dt_vendor_last_reported(wh);
EXPORT Make_dt_datawarehouse_first_reported(SALT33.StrType s0) := MakeFT_invalid_dt_datawarehouse_first_reported(s0);
EXPORT InValid_dt_datawarehouse_first_reported(SALT33.StrType s) := InValidFT_invalid_dt_datawarehouse_first_reported(s);
EXPORT InValidMessage_dt_datawarehouse_first_reported(UNSIGNED1 wh) := InValidMessageFT_invalid_dt_datawarehouse_first_reported(wh);
EXPORT Make_dt_datawarehouse_last_reported(SALT33.StrType s0) := MakeFT_invalid_dt_datawarehouse_last_reported(s0);
EXPORT InValid_dt_datawarehouse_last_reported(SALT33.StrType s) := InValidFT_invalid_dt_datawarehouse_last_reported(s);
EXPORT InValidMessage_dt_datawarehouse_last_reported(UNSIGNED1 wh) := InValidMessageFT_invalid_dt_datawarehouse_last_reported(wh);
EXPORT Make_sbfe_contributor_number(SALT33.StrType s0) := MakeFT_invalid_sbfe_contributor_num(s0);
EXPORT InValid_sbfe_contributor_number(SALT33.StrType s) := InValidFT_invalid_sbfe_contributor_num(s);
EXPORT InValidMessage_sbfe_contributor_number(UNSIGNED1 wh) := InValidMessageFT_invalid_sbfe_contributor_num(wh);
EXPORT Make_contract_account_number(SALT33.StrType s0) := MakeFT_invalid_contractacc_num(s0);
EXPORT InValid_contract_account_number(SALT33.StrType s) := InValidFT_invalid_contractacc_num(s);
EXPORT InValidMessage_contract_account_number(UNSIGNED1 wh) := InValidMessageFT_invalid_contractacc_num(wh);
EXPORT Make_account_type_reported(SALT33.StrType s0) := s0;
EXPORT InValid_account_type_reported(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_account_type_reported(UNSIGNED1 wh) := '';
EXPORT Make_extracted_date(SALT33.StrType s0) := MakeFT_invalid_extracted_date(s0);
EXPORT InValid_extracted_date(SALT33.StrType s) := InValidFT_invalid_extracted_date(s);
EXPORT InValidMessage_extracted_date(UNSIGNED1 wh) := InValidMessageFT_invalid_extracted_date(wh);
EXPORT Make_cycle_end_date(SALT33.StrType s0) := MakeFT_invalid_cycleend_date(s0);
EXPORT InValid_cycle_end_date(SALT33.StrType s) := InValidFT_invalid_cycleend_date(s);
EXPORT InValidMessage_cycle_end_date(UNSIGNED1 wh) := InValidMessageFT_invalid_cycleend_date(wh);
EXPORT Make_account_holder_business_name(SALT33.StrType s0) := MakeFT_invalid_accholder_businessname(s0);
EXPORT InValid_account_holder_business_name(SALT33.StrType s) := InValidFT_invalid_accholder_businessname(s);
EXPORT InValidMessage_account_holder_business_name(UNSIGNED1 wh) := InValidMessageFT_invalid_accholder_businessname(wh);
EXPORT Make_clean_account_holder_business_name(SALT33.StrType s0) := MakeFT_invalid_cln_accholder_businessname(s0);
EXPORT InValid_clean_account_holder_business_name(SALT33.StrType s) := InValidFT_invalid_cln_accholder_businessname(s);
EXPORT InValidMessage_clean_account_holder_business_name(UNSIGNED1 wh) := InValidMessageFT_invalid_cln_accholder_businessname(wh);
EXPORT Make_dba(SALT33.StrType s0) := MakeFT_invalid_dba(s0);
EXPORT InValid_dba(SALT33.StrType s) := InValidFT_invalid_dba(s);
EXPORT InValidMessage_dba(UNSIGNED1 wh) := InValidMessageFT_invalid_dba(wh);
EXPORT Make_clean_dba(SALT33.StrType s0) := MakeFT_invalid_cln_dba(s0);
EXPORT InValid_clean_dba(SALT33.StrType s) := InValidFT_invalid_cln_dba(s);
EXPORT InValidMessage_clean_dba(UNSIGNED1 wh) := InValidMessageFT_invalid_cln_dba(wh);
EXPORT Make_business_name(SALT33.StrType s0) := MakeFT_invalid_business_name(s0);
EXPORT InValid_business_name(SALT33.StrType s) := InValidFT_invalid_business_name(s);
EXPORT InValidMessage_business_name(UNSIGNED1 wh) := InValidMessageFT_invalid_business_name(wh);
EXPORT Make_clean_business_name(SALT33.StrType s0) := MakeFT_invalid_cln_business_name(s0);
EXPORT InValid_clean_business_name(SALT33.StrType s) := InValidFT_invalid_cln_business_name(s);
EXPORT InValidMessage_clean_business_name(UNSIGNED1 wh) := InValidMessageFT_invalid_cln_business_name(wh);
EXPORT Make_company_website(SALT33.StrType s0) := MakeFT_invalid_comp_website(s0);
EXPORT InValid_company_website(SALT33.StrType s) := InValidFT_invalid_comp_website(s);
EXPORT InValidMessage_company_website(UNSIGNED1 wh) := InValidMessageFT_invalid_comp_website(wh);
EXPORT Make_original_fname(SALT33.StrType s0) := MakeFT_invalid_first_name(s0);
EXPORT InValid_original_fname(SALT33.StrType s) := InValidFT_invalid_first_name(s);
EXPORT InValidMessage_original_fname(UNSIGNED1 wh) := InValidMessageFT_invalid_first_name(wh);
EXPORT Make_original_mname(SALT33.StrType s0) := MakeFT_invalid_middle_name(s0);
EXPORT InValid_original_mname(SALT33.StrType s) := InValidFT_invalid_middle_name(s);
EXPORT InValidMessage_original_mname(UNSIGNED1 wh) := InValidMessageFT_invalid_middle_name(wh);
EXPORT Make_original_lname(SALT33.StrType s0) := MakeFT_invalid_last_name(s0);
EXPORT InValid_original_lname(SALT33.StrType s) := InValidFT_invalid_last_name(s);
EXPORT InValidMessage_original_lname(UNSIGNED1 wh) := InValidMessageFT_invalid_last_name(wh);
EXPORT Make_original_suffix(SALT33.StrType s0) := MakeFT_invalid_suffix(s0);
EXPORT InValid_original_suffix(SALT33.StrType s) := InValidFT_invalid_suffix(s);
EXPORT InValidMessage_original_suffix(UNSIGNED1 wh) := InValidMessageFT_invalid_suffix(wh);
EXPORT Make_e_mail_address(SALT33.StrType s0) := MakeFT_invalid_e_mail_address(s0);
EXPORT InValid_e_mail_address(SALT33.StrType s) := InValidFT_invalid_e_mail_address(s);
EXPORT InValidMessage_e_mail_address(UNSIGNED1 wh) := InValidMessageFT_invalid_e_mail_address(wh);
EXPORT Make_guarantor_owner_indicator(SALT33.StrType s0) := MakeFT_invalid_guarantor_owner_indicator(s0);
EXPORT InValid_guarantor_owner_indicator(SALT33.StrType s) := InValidFT_invalid_guarantor_owner_indicator(s);
EXPORT InValidMessage_guarantor_owner_indicator(UNSIGNED1 wh) := InValidMessageFT_invalid_guarantor_owner_indicator(wh);
EXPORT Make_relationship_to_business_indicator(SALT33.StrType s0) := MakeFT_invalid_relationship_to_business_indicator(s0);
EXPORT InValid_relationship_to_business_indicator(SALT33.StrType s) := InValidFT_invalid_relationship_to_business_indicator(s);
EXPORT InValidMessage_relationship_to_business_indicator(UNSIGNED1 wh) := InValidMessageFT_invalid_relationship_to_business_indicator(wh);
EXPORT Make_business_title(SALT33.StrType s0) := MakeFT_invalid_business_title(s0);
EXPORT InValid_business_title(SALT33.StrType s) := InValidFT_invalid_business_title(s);
EXPORT InValidMessage_business_title(UNSIGNED1 wh) := InValidMessageFT_invalid_business_title(wh);
EXPORT Make_clean_title(SALT33.StrType s0) := MakeFT_invalid_cln_title(s0);
EXPORT InValid_clean_title(SALT33.StrType s) := InValidFT_invalid_cln_title(s);
EXPORT InValidMessage_clean_title(UNSIGNED1 wh) := InValidMessageFT_invalid_cln_title(wh);
EXPORT Make_clean_fname(SALT33.StrType s0) := MakeFT_invalid_cln_fname(s0);
EXPORT InValid_clean_fname(SALT33.StrType s) := InValidFT_invalid_cln_fname(s);
EXPORT InValidMessage_clean_fname(UNSIGNED1 wh) := InValidMessageFT_invalid_cln_fname(wh);
EXPORT Make_clean_mname(SALT33.StrType s0) := MakeFT_invalid_cln_mname(s0);
EXPORT InValid_clean_mname(SALT33.StrType s) := InValidFT_invalid_cln_mname(s);
EXPORT InValidMessage_clean_mname(UNSIGNED1 wh) := InValidMessageFT_invalid_cln_mname(wh);
EXPORT Make_clean_lname(SALT33.StrType s0) := MakeFT_invalid_cln_lname(s0);
EXPORT InValid_clean_lname(SALT33.StrType s) := InValidFT_invalid_cln_lname(s);
EXPORT InValidMessage_clean_lname(UNSIGNED1 wh) := InValidMessageFT_invalid_cln_lname(wh);
EXPORT Make_clean_suffix(SALT33.StrType s0) := MakeFT_invalid_cln_suffix(s0);
EXPORT InValid_clean_suffix(SALT33.StrType s) := InValidFT_invalid_cln_suffix(s);
EXPORT InValidMessage_clean_suffix(UNSIGNED1 wh) := InValidMessageFT_invalid_cln_suffix(wh);
EXPORT Make_original_address_line_1(SALT33.StrType s0) := MakeFT_invalid_orig_address_line_1(s0);
EXPORT InValid_original_address_line_1(SALT33.StrType s) := InValidFT_invalid_orig_address_line_1(s);
EXPORT InValidMessage_original_address_line_1(UNSIGNED1 wh) := InValidMessageFT_invalid_orig_address_line_1(wh);
EXPORT Make_original_address_line_2(SALT33.StrType s0) := MakeFT_invalid_orig_address_line_2(s0);
EXPORT InValid_original_address_line_2(SALT33.StrType s) := InValidFT_invalid_orig_address_line_2(s);
EXPORT InValidMessage_original_address_line_2(UNSIGNED1 wh) := InValidMessageFT_invalid_orig_address_line_2(wh);
EXPORT Make_original_city(SALT33.StrType s0) := MakeFT_invalid_orig_city(s0);
EXPORT InValid_original_city(SALT33.StrType s) := InValidFT_invalid_orig_city(s);
EXPORT InValidMessage_original_city(UNSIGNED1 wh) := InValidMessageFT_invalid_orig_city(wh);
EXPORT Make_original_state(SALT33.StrType s0) := MakeFT_invalid_orig_state(s0);
EXPORT InValid_original_state(SALT33.StrType s) := InValidFT_invalid_orig_state(s);
EXPORT InValidMessage_original_state(UNSIGNED1 wh) := InValidMessageFT_invalid_orig_state(wh);
EXPORT Make_original_zip_code_or_ca_postal_code(SALT33.StrType s0) := MakeFT_invalid_orig_zip_code_or_ca_postal_code(s0);
EXPORT InValid_original_zip_code_or_ca_postal_code(SALT33.StrType s) := InValidFT_invalid_orig_zip_code_or_ca_postal_code(s);
EXPORT InValidMessage_original_zip_code_or_ca_postal_code(UNSIGNED1 wh) := InValidMessageFT_invalid_orig_zip_code_or_ca_postal_code(wh);
EXPORT Make_original_postal_code(SALT33.StrType s0) := MakeFT_invalid_orig_postal_code(s0);
EXPORT InValid_original_postal_code(SALT33.StrType s) := InValidFT_invalid_orig_postal_code(s);
EXPORT InValidMessage_original_postal_code(UNSIGNED1 wh) := InValidMessageFT_invalid_orig_postal_code(wh);
EXPORT Make_original_country_code(SALT33.StrType s0) := MakeFT_invalid_orig_country_code(s0);
EXPORT InValid_original_country_code(SALT33.StrType s) := InValidFT_invalid_orig_country_code(s);
EXPORT InValidMessage_original_country_code(UNSIGNED1 wh) := InValidMessageFT_invalid_orig_country_code(wh);
EXPORT Make_prim_range(SALT33.StrType s0) := MakeFT_invalid_prim_range(s0);
EXPORT InValid_prim_range(SALT33.StrType s) := InValidFT_invalid_prim_range(s);
EXPORT InValidMessage_prim_range(UNSIGNED1 wh) := InValidMessageFT_invalid_prim_range(wh);
EXPORT Make_predir(SALT33.StrType s0) := MakeFT_invalid_predir(s0);
EXPORT InValid_predir(SALT33.StrType s) := InValidFT_invalid_predir(s);
EXPORT InValidMessage_predir(UNSIGNED1 wh) := InValidMessageFT_invalid_predir(wh);
EXPORT Make_prim_name(SALT33.StrType s0) := MakeFT_invalid_prim_name(s0);
EXPORT InValid_prim_name(SALT33.StrType s) := InValidFT_invalid_prim_name(s);
EXPORT InValidMessage_prim_name(UNSIGNED1 wh) := InValidMessageFT_invalid_prim_name(wh);
EXPORT Make_addr_suffix(SALT33.StrType s0) := MakeFT_invalid_addr_suffix(s0);
EXPORT InValid_addr_suffix(SALT33.StrType s) := InValidFT_invalid_addr_suffix(s);
EXPORT InValidMessage_addr_suffix(UNSIGNED1 wh) := InValidMessageFT_invalid_addr_suffix(wh);
EXPORT Make_postdir(SALT33.StrType s0) := MakeFT_invalid_postdir(s0);
EXPORT InValid_postdir(SALT33.StrType s) := InValidFT_invalid_postdir(s);
EXPORT InValidMessage_postdir(UNSIGNED1 wh) := InValidMessageFT_invalid_postdir(wh);
EXPORT Make_unit_desig(SALT33.StrType s0) := MakeFT_invalid_unit_desig(s0);
EXPORT InValid_unit_desig(SALT33.StrType s) := InValidFT_invalid_unit_desig(s);
EXPORT InValidMessage_unit_desig(UNSIGNED1 wh) := InValidMessageFT_invalid_unit_desig(wh);
EXPORT Make_sec_range(SALT33.StrType s0) := MakeFT_invalid_sec_range(s0);
EXPORT InValid_sec_range(SALT33.StrType s) := InValidFT_invalid_sec_range(s);
EXPORT InValidMessage_sec_range(UNSIGNED1 wh) := InValidMessageFT_invalid_sec_range(wh);
EXPORT Make_p_city_name(SALT33.StrType s0) := MakeFT_invalid_p_city_name(s0);
EXPORT InValid_p_city_name(SALT33.StrType s) := InValidFT_invalid_p_city_name(s);
EXPORT InValidMessage_p_city_name(UNSIGNED1 wh) := InValidMessageFT_invalid_p_city_name(wh);
EXPORT Make_v_city_name(SALT33.StrType s0) := MakeFT_invalid_v_city_name(s0);
EXPORT InValid_v_city_name(SALT33.StrType s) := InValidFT_invalid_v_city_name(s);
EXPORT InValidMessage_v_city_name(UNSIGNED1 wh) := InValidMessageFT_invalid_v_city_name(wh);
EXPORT Make_st(SALT33.StrType s0) := MakeFT_invalid_st(s0);
EXPORT InValid_st(SALT33.StrType s) := InValidFT_invalid_st(s);
EXPORT InValidMessage_st(UNSIGNED1 wh) := InValidMessageFT_invalid_st(wh);
EXPORT Make_zip(SALT33.StrType s0) := MakeFT_invalid_zip(s0);
EXPORT InValid_zip(SALT33.StrType s) := InValidFT_invalid_zip(s);
EXPORT InValidMessage_zip(UNSIGNED1 wh) := InValidMessageFT_invalid_zip(wh);
EXPORT Make_zip4(SALT33.StrType s0) := MakeFT_invalid_zip4(s0);
EXPORT InValid_zip4(SALT33.StrType s) := InValidFT_invalid_zip4(s);
EXPORT InValidMessage_zip4(UNSIGNED1 wh) := InValidMessageFT_invalid_zip4(wh);
EXPORT Make_cart(SALT33.StrType s0) := s0;
EXPORT InValid_cart(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_cart(UNSIGNED1 wh) := '';
EXPORT Make_cr_sort_sz(SALT33.StrType s0) := s0;
EXPORT InValid_cr_sort_sz(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_cr_sort_sz(UNSIGNED1 wh) := '';
EXPORT Make_lot(SALT33.StrType s0) := s0;
EXPORT InValid_lot(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_lot(UNSIGNED1 wh) := '';
EXPORT Make_lot_order(SALT33.StrType s0) := s0;
EXPORT InValid_lot_order(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_lot_order(UNSIGNED1 wh) := '';
EXPORT Make_dbpc(SALT33.StrType s0) := s0;
EXPORT InValid_dbpc(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_dbpc(UNSIGNED1 wh) := '';
EXPORT Make_chk_digit(SALT33.StrType s0) := s0;
EXPORT InValid_chk_digit(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_chk_digit(UNSIGNED1 wh) := '';
EXPORT Make_rec_type(SALT33.StrType s0) := s0;
EXPORT InValid_rec_type(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_rec_type(UNSIGNED1 wh) := '';
EXPORT Make_fips_state(SALT33.StrType s0) := s0;
EXPORT InValid_fips_state(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_fips_state(UNSIGNED1 wh) := '';
EXPORT Make_fips_county(SALT33.StrType s0) := s0;
EXPORT InValid_fips_county(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_fips_county(UNSIGNED1 wh) := '';
EXPORT Make_geo_lat(SALT33.StrType s0) := s0;
EXPORT InValid_geo_lat(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_geo_lat(UNSIGNED1 wh) := '';
EXPORT Make_geo_long(SALT33.StrType s0) := s0;
EXPORT InValid_geo_long(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_geo_long(UNSIGNED1 wh) := '';
EXPORT Make_msa(SALT33.StrType s0) := s0;
EXPORT InValid_msa(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_msa(UNSIGNED1 wh) := '';
EXPORT Make_geo_blk(SALT33.StrType s0) := s0;
EXPORT InValid_geo_blk(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_geo_blk(UNSIGNED1 wh) := '';
EXPORT Make_geo_match(SALT33.StrType s0) := s0;
EXPORT InValid_geo_match(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_geo_match(UNSIGNED1 wh) := '';
EXPORT Make_err_stat(SALT33.StrType s0) := s0;
EXPORT InValid_err_stat(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_err_stat(UNSIGNED1 wh) := '';
EXPORT Make_rawaid(SALT33.StrType s0) := s0;
EXPORT InValid_rawaid(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_rawaid(UNSIGNED1 wh) := '';
EXPORT Make_original_area_code(SALT33.StrType s0) := MakeFT_invalid_orig_area_code(s0);
EXPORT InValid_original_area_code(SALT33.StrType s) := InValidFT_invalid_orig_area_code(s);
EXPORT InValidMessage_original_area_code(UNSIGNED1 wh) := InValidMessageFT_invalid_orig_area_code(wh);
EXPORT Make_original_phone_number(SALT33.StrType s0) := MakeFT_invalid_orig_telephone_number(s0);
EXPORT InValid_original_phone_number(SALT33.StrType s) := InValidFT_invalid_orig_telephone_number(s);
EXPORT InValidMessage_original_phone_number(UNSIGNED1 wh) := InValidMessageFT_invalid_orig_telephone_number(wh);
EXPORT Make_phone_extension(SALT33.StrType s0) := MakeFT_invalid_telephone_extension(s0);
EXPORT InValid_phone_extension(SALT33.StrType s) := InValidFT_invalid_telephone_extension(s);
EXPORT InValidMessage_phone_extension(UNSIGNED1 wh) := InValidMessageFT_invalid_telephone_extension(wh);
EXPORT Make_primary_phone_indicator(SALT33.StrType s0) := MakeFT_invalid_primary_telephone_indicator(s0);
EXPORT InValid_primary_phone_indicator(SALT33.StrType s) := InValidFT_invalid_primary_telephone_indicator(s);
EXPORT InValidMessage_primary_phone_indicator(UNSIGNED1 wh) := InValidMessageFT_invalid_primary_telephone_indicator(wh);
EXPORT Make_published_unlisted_indicator(SALT33.StrType s0) := MakeFT_invalid_published_unlisted_indicator(s0);
EXPORT InValid_published_unlisted_indicator(SALT33.StrType s) := InValidFT_invalid_published_unlisted_indicator(s);
EXPORT InValidMessage_published_unlisted_indicator(UNSIGNED1 wh) := InValidMessageFT_invalid_published_unlisted_indicator(wh);
EXPORT Make_phone_type(SALT33.StrType s0) := MakeFT_invalid_phonetype(s0);
EXPORT InValid_phone_type(SALT33.StrType s) := InValidFT_invalid_phonetype(s);
EXPORT InValidMessage_phone_type(UNSIGNED1 wh) := InValidMessageFT_invalid_phonetype(wh);
EXPORT Make_phone_number(SALT33.StrType s0) := MakeFT_invalid_phonenumber(s0);
EXPORT InValid_phone_number(SALT33.StrType s) := InValidFT_invalid_phonenumber(s);
EXPORT InValidMessage_phone_number(UNSIGNED1 wh) := InValidMessageFT_invalid_phonenumber(wh);
EXPORT Make_federal_taxid_ssn(SALT33.StrType s0) := MakeFT_invalid_federal_tax_id_ssn(s0);
EXPORT InValid_federal_taxid_ssn(SALT33.StrType s) := InValidFT_invalid_federal_tax_id_ssn(s);
EXPORT InValidMessage_federal_taxid_ssn(UNSIGNED1 wh) := InValidMessageFT_invalid_federal_tax_id_ssn(wh);
EXPORT Make_federal_taxid_ssn_identifier(SALT33.StrType s0) := MakeFT_invalid_federal_tax_id_ssn_identifier(s0);
EXPORT InValid_federal_taxid_ssn_identifier(SALT33.StrType s) := InValidFT_invalid_federal_tax_id_ssn_identifier(s);
EXPORT InValidMessage_federal_taxid_ssn_identifier(UNSIGNED1 wh) := InValidMessageFT_invalid_federal_tax_id_ssn_identifier(wh);
EXPORT Make_dotid(SALT33.StrType s0) := MakeFT_invalid_dotid(s0);
EXPORT InValid_dotid(SALT33.StrType s) := InValidFT_invalid_dotid(s);
EXPORT InValidMessage_dotid(UNSIGNED1 wh) := InValidMessageFT_invalid_dotid(wh);
EXPORT Make_dotscore(SALT33.StrType s0) := MakeFT_invalid_dotscore(s0);
EXPORT InValid_dotscore(SALT33.StrType s) := InValidFT_invalid_dotscore(s);
EXPORT InValidMessage_dotscore(UNSIGNED1 wh) := InValidMessageFT_invalid_dotscore(wh);
EXPORT Make_dotweight(SALT33.StrType s0) := MakeFT_invalid_dotweight(s0);
EXPORT InValid_dotweight(SALT33.StrType s) := InValidFT_invalid_dotweight(s);
EXPORT InValidMessage_dotweight(UNSIGNED1 wh) := InValidMessageFT_invalid_dotweight(wh);
EXPORT Make_empid(SALT33.StrType s0) := MakeFT_invalid_empid(s0);
EXPORT InValid_empid(SALT33.StrType s) := InValidFT_invalid_empid(s);
EXPORT InValidMessage_empid(UNSIGNED1 wh) := InValidMessageFT_invalid_empid(wh);
EXPORT Make_empscore(SALT33.StrType s0) := MakeFT_invalid_empscore(s0);
EXPORT InValid_empscore(SALT33.StrType s) := InValidFT_invalid_empscore(s);
EXPORT InValidMessage_empscore(UNSIGNED1 wh) := InValidMessageFT_invalid_empscore(wh);
EXPORT Make_empweight(SALT33.StrType s0) := MakeFT_invalid_empweight(s0);
EXPORT InValid_empweight(SALT33.StrType s) := InValidFT_invalid_empweight(s);
EXPORT InValidMessage_empweight(UNSIGNED1 wh) := InValidMessageFT_invalid_empweight(wh);
EXPORT Make_powid(SALT33.StrType s0) := MakeFT_invalid_powid(s0);
EXPORT InValid_powid(SALT33.StrType s) := InValidFT_invalid_powid(s);
EXPORT InValidMessage_powid(UNSIGNED1 wh) := InValidMessageFT_invalid_powid(wh);
EXPORT Make_powscore(SALT33.StrType s0) := MakeFT_invalid_powscore(s0);
EXPORT InValid_powscore(SALT33.StrType s) := InValidFT_invalid_powscore(s);
EXPORT InValidMessage_powscore(UNSIGNED1 wh) := InValidMessageFT_invalid_powscore(wh);
EXPORT Make_powweight(SALT33.StrType s0) := MakeFT_invalid_powweight(s0);
EXPORT InValid_powweight(SALT33.StrType s) := InValidFT_invalid_powweight(s);
EXPORT InValidMessage_powweight(UNSIGNED1 wh) := InValidMessageFT_invalid_powweight(wh);
EXPORT Make_proxid(SALT33.StrType s0) := MakeFT_invalid_proxid(s0);
EXPORT InValid_proxid(SALT33.StrType s) := InValidFT_invalid_proxid(s);
EXPORT InValidMessage_proxid(UNSIGNED1 wh) := InValidMessageFT_invalid_proxid(wh);
EXPORT Make_proxscore(SALT33.StrType s0) := MakeFT_invalid_proxscore(s0);
EXPORT InValid_proxscore(SALT33.StrType s) := InValidFT_invalid_proxscore(s);
EXPORT InValidMessage_proxscore(UNSIGNED1 wh) := InValidMessageFT_invalid_proxscore(wh);
EXPORT Make_proxweight(SALT33.StrType s0) := MakeFT_invalid_proxweight(s0);
EXPORT InValid_proxweight(SALT33.StrType s) := InValidFT_invalid_proxweight(s);
EXPORT InValidMessage_proxweight(UNSIGNED1 wh) := InValidMessageFT_invalid_proxweight(wh);
EXPORT Make_seleid(SALT33.StrType s0) := MakeFT_invalid_seleid(s0);
EXPORT InValid_seleid(SALT33.StrType s) := InValidFT_invalid_seleid(s);
EXPORT InValidMessage_seleid(UNSIGNED1 wh) := InValidMessageFT_invalid_seleid(wh);
EXPORT Make_selescore(SALT33.StrType s0) := MakeFT_invalid_selescore(s0);
EXPORT InValid_selescore(SALT33.StrType s) := InValidFT_invalid_selescore(s);
EXPORT InValidMessage_selescore(UNSIGNED1 wh) := InValidMessageFT_invalid_selescore(wh);
EXPORT Make_seleweight(SALT33.StrType s0) := MakeFT_invalid_seleweight(s0);
EXPORT InValid_seleweight(SALT33.StrType s) := InValidFT_invalid_seleweight(s);
EXPORT InValidMessage_seleweight(UNSIGNED1 wh) := InValidMessageFT_invalid_seleweight(wh);
EXPORT Make_orgid(SALT33.StrType s0) := MakeFT_invalid_orgid(s0);
EXPORT InValid_orgid(SALT33.StrType s) := InValidFT_invalid_orgid(s);
EXPORT InValidMessage_orgid(UNSIGNED1 wh) := InValidMessageFT_invalid_orgid(wh);
EXPORT Make_orgscore(SALT33.StrType s0) := MakeFT_invalid_orgscore(s0);
EXPORT InValid_orgscore(SALT33.StrType s) := InValidFT_invalid_orgscore(s);
EXPORT InValidMessage_orgscore(UNSIGNED1 wh) := InValidMessageFT_invalid_orgscore(wh);
EXPORT Make_orgweight(SALT33.StrType s0) := MakeFT_invalid_orgweight(s0);
EXPORT InValid_orgweight(SALT33.StrType s) := InValidFT_invalid_orgweight(s);
EXPORT InValidMessage_orgweight(UNSIGNED1 wh) := InValidMessageFT_invalid_orgweight(wh);
EXPORT Make_ultid(SALT33.StrType s0) := MakeFT_invalid_ultid(s0);
EXPORT InValid_ultid(SALT33.StrType s) := InValidFT_invalid_ultid(s);
EXPORT InValidMessage_ultid(UNSIGNED1 wh) := InValidMessageFT_invalid_ultid(wh);
EXPORT Make_ultscore(SALT33.StrType s0) := MakeFT_invalid_ultscore(s0);
EXPORT InValid_ultscore(SALT33.StrType s) := InValidFT_invalid_ultscore(s);
EXPORT InValidMessage_ultscore(UNSIGNED1 wh) := InValidMessageFT_invalid_ultscore(wh);
EXPORT Make_ultweight(SALT33.StrType s0) := MakeFT_invalid_ultweight(s0);
EXPORT InValid_ultweight(SALT33.StrType s) := InValidFT_invalid_ultweight(s);
EXPORT InValidMessage_ultweight(UNSIGNED1 wh) := InValidMessageFT_invalid_ultweight(wh);
EXPORT Make_persistent_record_id(SALT33.StrType s0) := s0;
EXPORT InValid_persistent_record_id(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_persistent_record_id(UNSIGNED1 wh) := '';
EXPORT Make_sbfe_id(SALT33.StrType s0) := MakeFT_invalid_sbfe_id(s0);
EXPORT InValid_sbfe_id(SALT33.StrType s) := InValidFT_invalid_sbfe_id(s);
EXPORT InValidMessage_sbfe_id(UNSIGNED1 wh) := InValidMessageFT_invalid_sbfe_id(wh);
EXPORT Make_source(SALT33.StrType s0) := s0;
EXPORT InValid_source(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_source(UNSIGNED1 wh) := '';
EXPORT Make_active(SALT33.StrType s0) := s0;
EXPORT InValid_active(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_active(UNSIGNED1 wh) := '';
EXPORT Make_legal_business_structure(SALT33.StrType s0) := MakeFT_invalid_legal_busi_structure(s0);
EXPORT InValid_legal_business_structure(SALT33.StrType s) := InValidFT_invalid_legal_busi_structure(s);
EXPORT InValidMessage_legal_business_structure(UNSIGNED1 wh) := InValidMessageFT_invalid_legal_busi_structure(wh);
EXPORT Make_business_established_date(SALT33.StrType s0) := MakeFT_invalid_busi_established_date(s0);
EXPORT InValid_business_established_date(SALT33.StrType s) := InValidFT_invalid_busi_established_date(s);
EXPORT InValidMessage_business_established_date(UNSIGNED1 wh) := InValidMessageFT_invalid_busi_established_date(wh);
EXPORT Make_account_status_1(SALT33.StrType s0) := MakeFT_invalid_acc_status1(s0);
EXPORT InValid_account_status_1(SALT33.StrType s) := InValidFT_invalid_acc_status1(s);
EXPORT InValidMessage_account_status_1(UNSIGNED1 wh) := InValidMessageFT_invalid_acc_status1(wh);
EXPORT Make_account_status_2(SALT33.StrType s0) := MakeFT_invalid_acc_status2(s0);
EXPORT InValid_account_status_2(SALT33.StrType s) := InValidFT_invalid_acc_status2(s);
EXPORT InValidMessage_account_status_2(UNSIGNED1 wh) := InValidMessageFT_invalid_acc_status2(wh);
EXPORT Make_date_account_opened(SALT33.StrType s0) := MakeFT_invalid_dateaccopened(s0);
EXPORT InValid_date_account_opened(SALT33.StrType s) := InValidFT_invalid_dateaccopened(s);
EXPORT InValidMessage_date_account_opened(UNSIGNED1 wh) := InValidMessageFT_invalid_dateaccopened(wh);
EXPORT Make_date_account_closed(SALT33.StrType s0) := MakeFT_invalid_dateaccclosed(s0);
EXPORT InValid_date_account_closed(SALT33.StrType s) := InValidFT_invalid_dateaccclosed(s);
EXPORT InValidMessage_date_account_closed(UNSIGNED1 wh) := InValidMessageFT_invalid_dateaccclosed(wh);
EXPORT Make_account_closure_basis(SALT33.StrType s0) := MakeFT_invalid_accountcloseurebasis(s0);
EXPORT InValid_account_closure_basis(SALT33.StrType s) := InValidFT_invalid_accountcloseurebasis(s);
EXPORT InValidMessage_account_closure_basis(UNSIGNED1 wh) := InValidMessageFT_invalid_accountcloseurebasis(wh);
EXPORT Make_account_expiration_date(SALT33.StrType s0) := MakeFT_invalid_accexpirationdate(s0);
EXPORT InValid_account_expiration_date(SALT33.StrType s) := InValidFT_invalid_accexpirationdate(s);
EXPORT InValidMessage_account_expiration_date(UNSIGNED1 wh) := InValidMessageFT_invalid_accexpirationdate(wh);
EXPORT Make_last_activity_date(SALT33.StrType s0) := MakeFT_invalid_lastactivitydate(s0);
EXPORT InValid_last_activity_date(SALT33.StrType s) := InValidFT_invalid_lastactivitydate(s);
EXPORT InValidMessage_last_activity_date(UNSIGNED1 wh) := InValidMessageFT_invalid_lastactivitydate(wh);
EXPORT Make_last_activity_type(SALT33.StrType s0) := MakeFT_invalid_lastactivitytype(s0);
EXPORT InValid_last_activity_type(SALT33.StrType s) := InValidFT_invalid_lastactivitytype(s);
EXPORT InValidMessage_last_activity_type(UNSIGNED1 wh) := InValidMessageFT_invalid_lastactivitytype(wh);
EXPORT Make_recent_activity_indicator(SALT33.StrType s0) := MakeFT_invalid_recentactivityindicator(s0);
EXPORT InValid_recent_activity_indicator(SALT33.StrType s) := InValidFT_invalid_recentactivityindicator(s);
EXPORT InValidMessage_recent_activity_indicator(UNSIGNED1 wh) := InValidMessageFT_invalid_recentactivityindicator(wh);
EXPORT Make_original_credit_limit(SALT33.StrType s0) := MakeFT_invalid_origcreditlimit(s0);
EXPORT InValid_original_credit_limit(SALT33.StrType s) := InValidFT_invalid_origcreditlimit(s);
EXPORT InValidMessage_original_credit_limit(UNSIGNED1 wh) := InValidMessageFT_invalid_origcreditlimit(wh);
EXPORT Make_highest_credit_used(SALT33.StrType s0) := MakeFT_invalid_highestcreditused(s0);
EXPORT InValid_highest_credit_used(SALT33.StrType s) := InValidFT_invalid_highestcreditused(s);
EXPORT InValidMessage_highest_credit_used(UNSIGNED1 wh) := InValidMessageFT_invalid_highestcreditused(wh);
EXPORT Make_current_credit_limit(SALT33.StrType s0) := MakeFT_invalid_currentcreditlimit(s0);
EXPORT InValid_current_credit_limit(SALT33.StrType s) := InValidFT_invalid_currentcreditlimit(s);
EXPORT InValidMessage_current_credit_limit(UNSIGNED1 wh) := InValidMessageFT_invalid_currentcreditlimit(wh);
EXPORT Make_reporting_indicator_length(SALT33.StrType s0) := MakeFT_invalid_reporterindicatorlength(s0);
EXPORT InValid_reporting_indicator_length(SALT33.StrType s) := InValidFT_invalid_reporterindicatorlength(s);
EXPORT InValidMessage_reporting_indicator_length(UNSIGNED1 wh) := InValidMessageFT_invalid_reporterindicatorlength(wh);
EXPORT Make_payment_interval(SALT33.StrType s0) := MakeFT_invalid_paymentinterval(s0);
EXPORT InValid_payment_interval(SALT33.StrType s) := InValidFT_invalid_paymentinterval(s);
EXPORT InValidMessage_payment_interval(UNSIGNED1 wh) := InValidMessageFT_invalid_paymentinterval(wh);
EXPORT Make_payment_status_category(SALT33.StrType s0) := MakeFT_invalid_paymentstatuscategory(s0);
EXPORT InValid_payment_status_category(SALT33.StrType s) := InValidFT_invalid_paymentstatuscategory(s);
EXPORT InValidMessage_payment_status_category(UNSIGNED1 wh) := InValidMessageFT_invalid_paymentstatuscategory(wh);
EXPORT Make_term_of_account_in_months(SALT33.StrType s0) := MakeFT_invalid_termofacc_months(s0);
EXPORT InValid_term_of_account_in_months(SALT33.StrType s) := InValidFT_invalid_termofacc_months(s);
EXPORT InValidMessage_term_of_account_in_months(UNSIGNED1 wh) := InValidMessageFT_invalid_termofacc_months(wh);
EXPORT Make_first_payment_due_date(SALT33.StrType s0) := MakeFT_invalid_firstpymtduedate(s0);
EXPORT InValid_first_payment_due_date(SALT33.StrType s) := InValidFT_invalid_firstpymtduedate(s);
EXPORT InValidMessage_first_payment_due_date(UNSIGNED1 wh) := InValidMessageFT_invalid_firstpymtduedate(wh);
EXPORT Make_final_payment_due_date(SALT33.StrType s0) := MakeFT_invalid_finalpymtduedate(s0);
EXPORT InValid_final_payment_due_date(SALT33.StrType s) := InValidFT_invalid_finalpymtduedate(s);
EXPORT InValidMessage_final_payment_due_date(UNSIGNED1 wh) := InValidMessageFT_invalid_finalpymtduedate(wh);
EXPORT Make_original_rate(SALT33.StrType s0) := MakeFT_invalid_origrate(s0);
EXPORT InValid_original_rate(SALT33.StrType s) := InValidFT_invalid_origrate(s);
EXPORT InValidMessage_original_rate(UNSIGNED1 wh) := InValidMessageFT_invalid_origrate(wh);
EXPORT Make_floating_rate(SALT33.StrType s0) := MakeFT_invalid_origrate(s0);
EXPORT InValid_floating_rate(SALT33.StrType s) := InValidFT_invalid_origrate(s);
EXPORT InValidMessage_floating_rate(UNSIGNED1 wh) := InValidMessageFT_invalid_origrate(wh);
EXPORT Make_grace_period(SALT33.StrType s0) := MakeFT_invalid_graceperiod(s0);
EXPORT InValid_grace_period(SALT33.StrType s) := InValidFT_invalid_graceperiod(s);
EXPORT InValidMessage_grace_period(UNSIGNED1 wh) := InValidMessageFT_invalid_graceperiod(wh);
EXPORT Make_payment_category(SALT33.StrType s0) := MakeFT_invalid_paymentcategory(s0);
EXPORT InValid_payment_category(SALT33.StrType s) := InValidFT_invalid_paymentcategory(s);
EXPORT InValidMessage_payment_category(UNSIGNED1 wh) := InValidMessageFT_invalid_paymentcategory(wh);
EXPORT Make_payment_history_profile_12_months(SALT33.StrType s0) := MakeFT_invalid_pymthistprofile12(s0);
EXPORT InValid_payment_history_profile_12_months(SALT33.StrType s) := InValidFT_invalid_pymthistprofile12(s);
EXPORT InValidMessage_payment_history_profile_12_months(UNSIGNED1 wh) := InValidMessageFT_invalid_pymthistprofile12(wh);
EXPORT Make_payment_history_profile_13_24_months(SALT33.StrType s0) := MakeFT_invalid_pymthistprofile13_24(s0);
EXPORT InValid_payment_history_profile_13_24_months(SALT33.StrType s) := InValidFT_invalid_pymthistprofile13_24(s);
EXPORT InValidMessage_payment_history_profile_13_24_months(UNSIGNED1 wh) := InValidMessageFT_invalid_pymthistprofile13_24(wh);
EXPORT Make_payment_history_profile_25_36_months(SALT33.StrType s0) := MakeFT_invalid_pymthistprofile25_36(s0);
EXPORT InValid_payment_history_profile_25_36_months(SALT33.StrType s) := InValidFT_invalid_pymthistprofile25_36(s);
EXPORT InValidMessage_payment_history_profile_25_36_months(UNSIGNED1 wh) := InValidMessageFT_invalid_pymthistprofile25_36(wh);
EXPORT Make_payment_history_profile_37_48_months(SALT33.StrType s0) := MakeFT_invalid_pymthistprofile37_48(s0);
EXPORT InValid_payment_history_profile_37_48_months(SALT33.StrType s) := InValidFT_invalid_pymthistprofile37_48(s);
EXPORT InValidMessage_payment_history_profile_37_48_months(UNSIGNED1 wh) := InValidMessageFT_invalid_pymthistprofile37_48(wh);
EXPORT Make_payment_history_length(SALT33.StrType s0) := MakeFT_invalid_pymthistlength(s0);
EXPORT InValid_payment_history_length(SALT33.StrType s) := InValidFT_invalid_pymthistlength(s);
EXPORT InValidMessage_payment_history_length(UNSIGNED1 wh) := InValidMessageFT_invalid_pymthistlength(wh);
EXPORT Make_year_to_date_purchases_count(SALT33.StrType s0) := MakeFT_invalid_ytd_purchasescount(s0);
EXPORT InValid_year_to_date_purchases_count(SALT33.StrType s) := InValidFT_invalid_ytd_purchasescount(s);
EXPORT InValidMessage_year_to_date_purchases_count(UNSIGNED1 wh) := InValidMessageFT_invalid_ytd_purchasescount(wh);
EXPORT Make_lifetime_to_date_purchases_count(SALT33.StrType s0) := MakeFT_invalid_ltd_purchasescount(s0);
EXPORT InValid_lifetime_to_date_purchases_count(SALT33.StrType s) := InValidFT_invalid_ltd_purchasescount(s);
EXPORT InValidMessage_lifetime_to_date_purchases_count(UNSIGNED1 wh) := InValidMessageFT_invalid_ltd_purchasescount(wh);
EXPORT Make_year_to_date_purchases_sum_amount(SALT33.StrType s0) := MakeFT_invalid_ytd_purchasessumamt(s0);
EXPORT InValid_year_to_date_purchases_sum_amount(SALT33.StrType s) := InValidFT_invalid_ytd_purchasessumamt(s);
EXPORT InValidMessage_year_to_date_purchases_sum_amount(UNSIGNED1 wh) := InValidMessageFT_invalid_ytd_purchasessumamt(wh);
EXPORT Make_lifetime_to_date_purchases_sum_amount(SALT33.StrType s0) := MakeFT_invalid_ltd_purchasessumamt(s0);
EXPORT InValid_lifetime_to_date_purchases_sum_amount(SALT33.StrType s) := InValidFT_invalid_ltd_purchasessumamt(s);
EXPORT InValidMessage_lifetime_to_date_purchases_sum_amount(UNSIGNED1 wh) := InValidMessageFT_invalid_ltd_purchasessumamt(wh);
EXPORT Make_payment_amount_scheduled(SALT33.StrType s0) := MakeFT_invalid_pymtamtscheduled(s0);
EXPORT InValid_payment_amount_scheduled(SALT33.StrType s) := InValidFT_invalid_pymtamtscheduled(s);
EXPORT InValidMessage_payment_amount_scheduled(UNSIGNED1 wh) := InValidMessageFT_invalid_pymtamtscheduled(wh);
EXPORT Make_recent_payment_amount(SALT33.StrType s0) := MakeFT_invalid_recentpymtamt(s0);
EXPORT InValid_recent_payment_amount(SALT33.StrType s) := InValidFT_invalid_recentpymtamt(s);
EXPORT InValidMessage_recent_payment_amount(UNSIGNED1 wh) := InValidMessageFT_invalid_recentpymtamt(wh);
EXPORT Make_recent_payment_date(SALT33.StrType s0) := MakeFT_invalid_recentpaymentdate(s0);
EXPORT InValid_recent_payment_date(SALT33.StrType s) := InValidFT_invalid_recentpaymentdate(s);
EXPORT InValidMessage_recent_payment_date(UNSIGNED1 wh) := InValidMessageFT_invalid_recentpaymentdate(wh);
EXPORT Make_remaining_balance(SALT33.StrType s0) := MakeFT_invalid_remainingbalance(s0);
EXPORT InValid_remaining_balance(SALT33.StrType s) := InValidFT_invalid_remainingbalance(s);
EXPORT InValidMessage_remaining_balance(UNSIGNED1 wh) := InValidMessageFT_invalid_remainingbalance(wh);
EXPORT Make_carried_over_amount(SALT33.StrType s0) := MakeFT_invalid_carriedoveramt(s0);
EXPORT InValid_carried_over_amount(SALT33.StrType s) := InValidFT_invalid_carriedoveramt(s);
EXPORT InValidMessage_carried_over_amount(UNSIGNED1 wh) := InValidMessageFT_invalid_carriedoveramt(wh);
EXPORT Make_new_applied_charges(SALT33.StrType s0) := MakeFT_invalid_newappliedcharges(s0);
EXPORT InValid_new_applied_charges(SALT33.StrType s) := InValidFT_invalid_newappliedcharges(s);
EXPORT InValidMessage_new_applied_charges(UNSIGNED1 wh) := InValidMessageFT_invalid_newappliedcharges(wh);
EXPORT Make_balloon_payment_due(SALT33.StrType s0) := MakeFT_invalid_balloonpymtdue(s0);
EXPORT InValid_balloon_payment_due(SALT33.StrType s) := InValidFT_invalid_balloonpymtdue(s);
EXPORT InValidMessage_balloon_payment_due(UNSIGNED1 wh) := InValidMessageFT_invalid_balloonpymtdue(wh);
EXPORT Make_balloon_payment_due_date(SALT33.StrType s0) := MakeFT_invalid_balloonpymtduedate(s0);
EXPORT InValid_balloon_payment_due_date(SALT33.StrType s) := InValidFT_invalid_balloonpymtduedate(s);
EXPORT InValidMessage_balloon_payment_due_date(UNSIGNED1 wh) := InValidMessageFT_invalid_balloonpymtduedate(wh);
EXPORT Make_delinquency_date(SALT33.StrType s0) := MakeFT_invalid_delinquencydate(s0);
EXPORT InValid_delinquency_date(SALT33.StrType s) := InValidFT_invalid_delinquencydate(s);
EXPORT InValidMessage_delinquency_date(UNSIGNED1 wh) := InValidMessageFT_invalid_delinquencydate(wh);
EXPORT Make_days_delinquent(SALT33.StrType s0) := MakeFT_invalid_daysdelinquent(s0);
EXPORT InValid_days_delinquent(SALT33.StrType s) := InValidFT_invalid_daysdelinquent(s);
EXPORT InValidMessage_days_delinquent(UNSIGNED1 wh) := InValidMessageFT_invalid_daysdelinquent(wh);
EXPORT Make_past_due_amount(SALT33.StrType s0) := MakeFT_invalid_pastdueamt(s0);
EXPORT InValid_past_due_amount(SALT33.StrType s) := InValidFT_invalid_pastdueamt(s);
EXPORT InValidMessage_past_due_amount(UNSIGNED1 wh) := InValidMessageFT_invalid_pastdueamt(wh);
EXPORT Make_maximum_number_of_past_due_aging_amounts_buckets_provided(SALT33.StrType s0) := MakeFT_invalid_maximum_number_bucket(s0);
EXPORT InValid_maximum_number_of_past_due_aging_amounts_buckets_provided(SALT33.StrType s) := InValidFT_invalid_maximum_number_bucket(s);
EXPORT InValidMessage_maximum_number_of_past_due_aging_amounts_buckets_provided(UNSIGNED1 wh) := InValidMessageFT_invalid_maximum_number_bucket(wh);
EXPORT Make_past_due_aging_bucket_type(SALT33.StrType s0) := MakeFT_invalid_past_due_aging_bucket_type(s0);
EXPORT InValid_past_due_aging_bucket_type(SALT33.StrType s) := InValidFT_invalid_past_due_aging_bucket_type(s);
EXPORT InValidMessage_past_due_aging_bucket_type(UNSIGNED1 wh) := InValidMessageFT_invalid_past_due_aging_bucket_type(wh);
EXPORT Make_past_due_aging_amount_bucket_1(SALT33.StrType s0) := MakeFT_invalid_past_due_aging_amount_bucket(s0);
EXPORT InValid_past_due_aging_amount_bucket_1(SALT33.StrType s) := InValidFT_invalid_past_due_aging_amount_bucket(s);
EXPORT InValidMessage_past_due_aging_amount_bucket_1(UNSIGNED1 wh) := InValidMessageFT_invalid_past_due_aging_amount_bucket(wh);
EXPORT Make_past_due_aging_amount_bucket_2(SALT33.StrType s0) := MakeFT_invalid_past_due_aging_amount_bucket(s0);
EXPORT InValid_past_due_aging_amount_bucket_2(SALT33.StrType s) := InValidFT_invalid_past_due_aging_amount_bucket(s);
EXPORT InValidMessage_past_due_aging_amount_bucket_2(UNSIGNED1 wh) := InValidMessageFT_invalid_past_due_aging_amount_bucket(wh);
EXPORT Make_past_due_aging_amount_bucket_3(SALT33.StrType s0) := MakeFT_invalid_past_due_aging_amount_bucket(s0);
EXPORT InValid_past_due_aging_amount_bucket_3(SALT33.StrType s) := InValidFT_invalid_past_due_aging_amount_bucket(s);
EXPORT InValidMessage_past_due_aging_amount_bucket_3(UNSIGNED1 wh) := InValidMessageFT_invalid_past_due_aging_amount_bucket(wh);
EXPORT Make_past_due_aging_amount_bucket_4(SALT33.StrType s0) := MakeFT_invalid_past_due_aging_amount_bucket(s0);
EXPORT InValid_past_due_aging_amount_bucket_4(SALT33.StrType s) := InValidFT_invalid_past_due_aging_amount_bucket(s);
EXPORT InValidMessage_past_due_aging_amount_bucket_4(UNSIGNED1 wh) := InValidMessageFT_invalid_past_due_aging_amount_bucket(wh);
EXPORT Make_past_due_aging_amount_bucket_5(SALT33.StrType s0) := MakeFT_invalid_past_due_aging_amount_bucket(s0);
EXPORT InValid_past_due_aging_amount_bucket_5(SALT33.StrType s) := InValidFT_invalid_past_due_aging_amount_bucket(s);
EXPORT InValidMessage_past_due_aging_amount_bucket_5(UNSIGNED1 wh) := InValidMessageFT_invalid_past_due_aging_amount_bucket(wh);
EXPORT Make_past_due_aging_amount_bucket_6(SALT33.StrType s0) := MakeFT_invalid_past_due_aging_amount_bucket(s0);
EXPORT InValid_past_due_aging_amount_bucket_6(SALT33.StrType s) := InValidFT_invalid_past_due_aging_amount_bucket(s);
EXPORT InValidMessage_past_due_aging_amount_bucket_6(UNSIGNED1 wh) := InValidMessageFT_invalid_past_due_aging_amount_bucket(wh);
EXPORT Make_past_due_aging_amount_bucket_7(SALT33.StrType s0) := MakeFT_invalid_past_due_aging_amount_bucket(s0);
EXPORT InValid_past_due_aging_amount_bucket_7(SALT33.StrType s) := InValidFT_invalid_past_due_aging_amount_bucket(s);
EXPORT InValidMessage_past_due_aging_amount_bucket_7(UNSIGNED1 wh) := InValidMessageFT_invalid_past_due_aging_amount_bucket(wh);
EXPORT Make_maximum_number_of_payment_tracking_cycle_periods_provided(SALT33.StrType s0) := MakeFT_invalid_maximum_number_tracking(s0);
EXPORT InValid_maximum_number_of_payment_tracking_cycle_periods_provided(SALT33.StrType s) := InValidFT_invalid_maximum_number_tracking(s);
EXPORT InValidMessage_maximum_number_of_payment_tracking_cycle_periods_provided(UNSIGNED1 wh) := InValidMessageFT_invalid_maximum_number_tracking(wh);
EXPORT Make_payment_tracking_cycle_type(SALT33.StrType s0) := MakeFT_invalid_payment_tracking_cycle_type(s0);
EXPORT InValid_payment_tracking_cycle_type(SALT33.StrType s) := InValidFT_invalid_payment_tracking_cycle_type(s);
EXPORT InValidMessage_payment_tracking_cycle_type(UNSIGNED1 wh) := InValidMessageFT_invalid_payment_tracking_cycle_type(wh);
EXPORT Make_payment_tracking_cycle_0_current(SALT33.StrType s0) := MakeFT_invalid_num(s0);
EXPORT InValid_payment_tracking_cycle_0_current(SALT33.StrType s) := InValidFT_invalid_num(s);
EXPORT InValidMessage_payment_tracking_cycle_0_current(UNSIGNED1 wh) := InValidMessageFT_invalid_num(wh);
EXPORT Make_payment_tracking_cycle_1_1_to_30_days(SALT33.StrType s0) := MakeFT_invalid_num(s0);
EXPORT InValid_payment_tracking_cycle_1_1_to_30_days(SALT33.StrType s) := InValidFT_invalid_num(s);
EXPORT InValidMessage_payment_tracking_cycle_1_1_to_30_days(UNSIGNED1 wh) := InValidMessageFT_invalid_num(wh);
EXPORT Make_payment_tracking_cycle_2_31_to_60_days(SALT33.StrType s0) := MakeFT_invalid_num(s0);
EXPORT InValid_payment_tracking_cycle_2_31_to_60_days(SALT33.StrType s) := InValidFT_invalid_num(s);
EXPORT InValidMessage_payment_tracking_cycle_2_31_to_60_days(UNSIGNED1 wh) := InValidMessageFT_invalid_num(wh);
EXPORT Make_payment_tracking_cycle_3_61_to_90_days(SALT33.StrType s0) := MakeFT_invalid_num(s0);
EXPORT InValid_payment_tracking_cycle_3_61_to_90_days(SALT33.StrType s) := InValidFT_invalid_num(s);
EXPORT InValidMessage_payment_tracking_cycle_3_61_to_90_days(UNSIGNED1 wh) := InValidMessageFT_invalid_num(wh);
EXPORT Make_payment_tracking_cycle_4_91_to_120_days(SALT33.StrType s0) := MakeFT_invalid_num(s0);
EXPORT InValid_payment_tracking_cycle_4_91_to_120_days(SALT33.StrType s) := InValidFT_invalid_num(s);
EXPORT InValidMessage_payment_tracking_cycle_4_91_to_120_days(UNSIGNED1 wh) := InValidMessageFT_invalid_num(wh);
EXPORT Make_payment_tracking_cycle_5_121_to_150days(SALT33.StrType s0) := MakeFT_invalid_num(s0);
EXPORT InValid_payment_tracking_cycle_5_121_to_150days(SALT33.StrType s) := InValidFT_invalid_num(s);
EXPORT InValidMessage_payment_tracking_cycle_5_121_to_150days(UNSIGNED1 wh) := InValidMessageFT_invalid_num(wh);
EXPORT Make_payment_tracking_number_of_times_cycle_6_151_to_180_days(SALT33.StrType s0) := MakeFT_invalid_num(s0);
EXPORT InValid_payment_tracking_number_of_times_cycle_6_151_to_180_days(SALT33.StrType s) := InValidFT_invalid_num(s);
EXPORT InValidMessage_payment_tracking_number_of_times_cycle_6_151_to_180_days(UNSIGNED1 wh) := InValidMessageFT_invalid_num(wh);
EXPORT Make_payment_tracking_number_of_times_cycle_7_181_or_greater_days(SALT33.StrType s0) := MakeFT_invalid_num(s0);
EXPORT InValid_payment_tracking_number_of_times_cycle_7_181_or_greater_days(SALT33.StrType s) := InValidFT_invalid_num(s);
EXPORT InValidMessage_payment_tracking_number_of_times_cycle_7_181_or_greater_days(UNSIGNED1 wh) := InValidMessageFT_invalid_num(wh);
EXPORT Make_date_account_was_charged_off(SALT33.StrType s0) := MakeFT_invalid_date_account_was_charged_off(s0);
EXPORT InValid_date_account_was_charged_off(SALT33.StrType s) := InValidFT_invalid_date_account_was_charged_off(s);
EXPORT InValidMessage_date_account_was_charged_off(UNSIGNED1 wh) := InValidMessageFT_invalid_date_account_was_charged_off(wh);
EXPORT Make_amount_charged_off_by_creditor(SALT33.StrType s0) := MakeFT_invalid_amount_charged_off_by_creditor(s0);
EXPORT InValid_amount_charged_off_by_creditor(SALT33.StrType s) := InValidFT_invalid_amount_charged_off_by_creditor(s);
EXPORT InValidMessage_amount_charged_off_by_creditor(UNSIGNED1 wh) := InValidMessageFT_invalid_amount_charged_off_by_creditor(wh);
EXPORT Make_charge_off_type_indicator(SALT33.StrType s0) := MakeFT_invalid_charge_off_type_indicator(s0);
EXPORT InValid_charge_off_type_indicator(SALT33.StrType s) := InValidFT_invalid_charge_off_type_indicator(s);
EXPORT InValidMessage_charge_off_type_indicator(UNSIGNED1 wh) := InValidMessageFT_invalid_charge_off_type_indicator(wh);
EXPORT Make_total_charge_off_recoveries_to_date(SALT33.StrType s0) := MakeFT_invalid_total_charge_off_recoveries_to_date(s0);
EXPORT InValid_total_charge_off_recoveries_to_date(SALT33.StrType s) := InValidFT_invalid_total_charge_off_recoveries_to_date(s);
EXPORT InValidMessage_total_charge_off_recoveries_to_date(UNSIGNED1 wh) := InValidMessageFT_invalid_total_charge_off_recoveries_to_date(wh);
EXPORT Make_government_guarantee_flag(SALT33.StrType s0) := MakeFT_invalid_government_guarantee_flag(s0);
EXPORT InValid_government_guarantee_flag(SALT33.StrType s) := InValidFT_invalid_government_guarantee_flag(s);
EXPORT InValidMessage_government_guarantee_flag(UNSIGNED1 wh) := InValidMessageFT_invalid_government_guarantee_flag(wh);
EXPORT Make_government_guarantee_category(SALT33.StrType s0) := MakeFT_invalid_government_guarantee_category(s0);
EXPORT InValid_government_guarantee_category(SALT33.StrType s) := InValidFT_invalid_government_guarantee_category(s);
EXPORT InValidMessage_government_guarantee_category(UNSIGNED1 wh) := InValidMessageFT_invalid_government_guarantee_category(wh);
EXPORT Make_portion_of_account_guaranteed_by_government(SALT33.StrType s0) := MakeFT_invalid_num(s0);
EXPORT InValid_portion_of_account_guaranteed_by_government(SALT33.StrType s) := InValidFT_invalid_num(s);
EXPORT InValidMessage_portion_of_account_guaranteed_by_government(UNSIGNED1 wh) := InValidMessageFT_invalid_num(wh);
EXPORT Make_guarantors_indicator(SALT33.StrType s0) := MakeFT_invalid_guarantors_indicator(s0);
EXPORT InValid_guarantors_indicator(SALT33.StrType s) := InValidFT_invalid_guarantors_indicator(s);
EXPORT InValidMessage_guarantors_indicator(UNSIGNED1 wh) := InValidMessageFT_invalid_guarantors_indicator(wh);
EXPORT Make_number_of_guarantors(SALT33.StrType s0) := MakeFT_invalid_number_of_guarantors(s0);
EXPORT InValid_number_of_guarantors(SALT33.StrType s) := InValidFT_invalid_number_of_guarantors(s);
EXPORT InValidMessage_number_of_guarantors(UNSIGNED1 wh) := InValidMessageFT_invalid_number_of_guarantors(wh);
EXPORT Make_owners_indicator(SALT33.StrType s0) := MakeFT_invalid_owners_indicator(s0);
EXPORT InValid_owners_indicator(SALT33.StrType s) := InValidFT_invalid_owners_indicator(s);
EXPORT InValidMessage_owners_indicator(UNSIGNED1 wh) := InValidMessageFT_invalid_owners_indicator(wh);
EXPORT Make_number_of_principals(SALT33.StrType s0) := MakeFT_invalid_number_of_principals(s0);
EXPORT InValid_number_of_principals(SALT33.StrType s) := InValidFT_invalid_number_of_principals(s);
EXPORT InValidMessage_number_of_principals(UNSIGNED1 wh) := InValidMessageFT_invalid_number_of_principals(wh);
EXPORT Make_account_update_deletion_indicator(SALT33.StrType s0) := MakeFT_invalid_account_update_deletion_indicator(s0);
EXPORT InValid_account_update_deletion_indicator(SALT33.StrType s) := InValidFT_invalid_account_update_deletion_indicator(s);
EXPORT InValidMessage_account_update_deletion_indicator(UNSIGNED1 wh) := InValidMessageFT_invalid_account_update_deletion_indicator(wh);
EXPORT Make_percent_of_liability(SALT33.StrType s0) := MakeFT_invalid_percent(s0);
EXPORT InValid_percent_of_liability(SALT33.StrType s) := InValidFT_invalid_percent(s);
EXPORT InValidMessage_percent_of_liability(UNSIGNED1 wh) := InValidMessageFT_invalid_percent(wh);
EXPORT Make_percent_of_ownership(SALT33.StrType s0) := MakeFT_invalid_percent(s0);
EXPORT InValid_percent_of_ownership(SALT33.StrType s) := InValidFT_invalid_percent(s);
EXPORT InValidMessage_percent_of_ownership(UNSIGNED1 wh) := InValidMessageFT_invalid_percent(wh);
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT33,Scrubs_Business_Credit;
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
    BOOLEAN Diff_timestamp;
    BOOLEAN Diff_process_date;
    BOOLEAN Diff_record_type;
    BOOLEAN Diff_did;
    BOOLEAN Diff_did_score;
    BOOLEAN Diff_dt_first_seen;
    BOOLEAN Diff_dt_last_seen;
    BOOLEAN Diff_dt_vendor_first_reported;
    BOOLEAN Diff_dt_vendor_last_reported;
    BOOLEAN Diff_dt_datawarehouse_first_reported;
    BOOLEAN Diff_dt_datawarehouse_last_reported;
    BOOLEAN Diff_sbfe_contributor_number;
    BOOLEAN Diff_contract_account_number;
    BOOLEAN Diff_account_type_reported;
    BOOLEAN Diff_extracted_date;
    BOOLEAN Diff_cycle_end_date;
    BOOLEAN Diff_account_holder_business_name;
    BOOLEAN Diff_clean_account_holder_business_name;
    BOOLEAN Diff_dba;
    BOOLEAN Diff_clean_dba;
    BOOLEAN Diff_business_name;
    BOOLEAN Diff_clean_business_name;
    BOOLEAN Diff_company_website;
    BOOLEAN Diff_original_fname;
    BOOLEAN Diff_original_mname;
    BOOLEAN Diff_original_lname;
    BOOLEAN Diff_original_suffix;
    BOOLEAN Diff_e_mail_address;
    BOOLEAN Diff_guarantor_owner_indicator;
    BOOLEAN Diff_relationship_to_business_indicator;
    BOOLEAN Diff_business_title;
    BOOLEAN Diff_clean_title;
    BOOLEAN Diff_clean_fname;
    BOOLEAN Diff_clean_mname;
    BOOLEAN Diff_clean_lname;
    BOOLEAN Diff_clean_suffix;
    BOOLEAN Diff_original_address_line_1;
    BOOLEAN Diff_original_address_line_2;
    BOOLEAN Diff_original_city;
    BOOLEAN Diff_original_state;
    BOOLEAN Diff_original_zip_code_or_ca_postal_code;
    BOOLEAN Diff_original_postal_code;
    BOOLEAN Diff_original_country_code;
    BOOLEAN Diff_prim_range;
    BOOLEAN Diff_predir;
    BOOLEAN Diff_prim_name;
    BOOLEAN Diff_addr_suffix;
    BOOLEAN Diff_postdir;
    BOOLEAN Diff_unit_desig;
    BOOLEAN Diff_sec_range;
    BOOLEAN Diff_p_city_name;
    BOOLEAN Diff_v_city_name;
    BOOLEAN Diff_st;
    BOOLEAN Diff_zip;
    BOOLEAN Diff_zip4;
    BOOLEAN Diff_cart;
    BOOLEAN Diff_cr_sort_sz;
    BOOLEAN Diff_lot;
    BOOLEAN Diff_lot_order;
    BOOLEAN Diff_dbpc;
    BOOLEAN Diff_chk_digit;
    BOOLEAN Diff_rec_type;
    BOOLEAN Diff_fips_state;
    BOOLEAN Diff_fips_county;
    BOOLEAN Diff_geo_lat;
    BOOLEAN Diff_geo_long;
    BOOLEAN Diff_msa;
    BOOLEAN Diff_geo_blk;
    BOOLEAN Diff_geo_match;
    BOOLEAN Diff_err_stat;
    BOOLEAN Diff_rawaid;
    BOOLEAN Diff_original_area_code;
    BOOLEAN Diff_original_phone_number;
    BOOLEAN Diff_phone_extension;
    BOOLEAN Diff_primary_phone_indicator;
    BOOLEAN Diff_published_unlisted_indicator;
    BOOLEAN Diff_phone_type;
    BOOLEAN Diff_phone_number;
    BOOLEAN Diff_federal_taxid_ssn;
    BOOLEAN Diff_federal_taxid_ssn_identifier;
    BOOLEAN Diff_dotid;
    BOOLEAN Diff_dotscore;
    BOOLEAN Diff_dotweight;
    BOOLEAN Diff_empid;
    BOOLEAN Diff_empscore;
    BOOLEAN Diff_empweight;
    BOOLEAN Diff_powid;
    BOOLEAN Diff_powscore;
    BOOLEAN Diff_powweight;
    BOOLEAN Diff_proxid;
    BOOLEAN Diff_proxscore;
    BOOLEAN Diff_proxweight;
    BOOLEAN Diff_seleid;
    BOOLEAN Diff_selescore;
    BOOLEAN Diff_seleweight;
    BOOLEAN Diff_orgid;
    BOOLEAN Diff_orgscore;
    BOOLEAN Diff_orgweight;
    BOOLEAN Diff_ultid;
    BOOLEAN Diff_ultscore;
    BOOLEAN Diff_ultweight;
    BOOLEAN Diff_persistent_record_id;
    BOOLEAN Diff_sbfe_id;
    BOOLEAN Diff_source;
    BOOLEAN Diff_active;
    BOOLEAN Diff_legal_business_structure;
    BOOLEAN Diff_business_established_date;
    BOOLEAN Diff_account_status_1;
    BOOLEAN Diff_account_status_2;
    BOOLEAN Diff_date_account_opened;
    BOOLEAN Diff_date_account_closed;
    BOOLEAN Diff_account_closure_basis;
    BOOLEAN Diff_account_expiration_date;
    BOOLEAN Diff_last_activity_date;
    BOOLEAN Diff_last_activity_type;
    BOOLEAN Diff_recent_activity_indicator;
    BOOLEAN Diff_original_credit_limit;
    BOOLEAN Diff_highest_credit_used;
    BOOLEAN Diff_current_credit_limit;
    BOOLEAN Diff_reporting_indicator_length;
    BOOLEAN Diff_payment_interval;
    BOOLEAN Diff_payment_status_category;
    BOOLEAN Diff_term_of_account_in_months;
    BOOLEAN Diff_first_payment_due_date;
    BOOLEAN Diff_final_payment_due_date;
    BOOLEAN Diff_original_rate;
    BOOLEAN Diff_floating_rate;
    BOOLEAN Diff_grace_period;
    BOOLEAN Diff_payment_category;
    BOOLEAN Diff_payment_history_profile_12_months;
    BOOLEAN Diff_payment_history_profile_13_24_months;
    BOOLEAN Diff_payment_history_profile_25_36_months;
    BOOLEAN Diff_payment_history_profile_37_48_months;
    BOOLEAN Diff_payment_history_length;
    BOOLEAN Diff_year_to_date_purchases_count;
    BOOLEAN Diff_lifetime_to_date_purchases_count;
    BOOLEAN Diff_year_to_date_purchases_sum_amount;
    BOOLEAN Diff_lifetime_to_date_purchases_sum_amount;
    BOOLEAN Diff_payment_amount_scheduled;
    BOOLEAN Diff_recent_payment_amount;
    BOOLEAN Diff_recent_payment_date;
    BOOLEAN Diff_remaining_balance;
    BOOLEAN Diff_carried_over_amount;
    BOOLEAN Diff_new_applied_charges;
    BOOLEAN Diff_balloon_payment_due;
    BOOLEAN Diff_balloon_payment_due_date;
    BOOLEAN Diff_delinquency_date;
    BOOLEAN Diff_days_delinquent;
    BOOLEAN Diff_past_due_amount;
    BOOLEAN Diff_maximum_number_of_past_due_aging_amounts_buckets_provided;
    BOOLEAN Diff_past_due_aging_bucket_type;
    BOOLEAN Diff_past_due_aging_amount_bucket_1;
    BOOLEAN Diff_past_due_aging_amount_bucket_2;
    BOOLEAN Diff_past_due_aging_amount_bucket_3;
    BOOLEAN Diff_past_due_aging_amount_bucket_4;
    BOOLEAN Diff_past_due_aging_amount_bucket_5;
    BOOLEAN Diff_past_due_aging_amount_bucket_6;
    BOOLEAN Diff_past_due_aging_amount_bucket_7;
    BOOLEAN Diff_maximum_number_of_payment_tracking_cycle_periods_provided;
    BOOLEAN Diff_payment_tracking_cycle_type;
    BOOLEAN Diff_payment_tracking_cycle_0_current;
    BOOLEAN Diff_payment_tracking_cycle_1_1_to_30_days;
    BOOLEAN Diff_payment_tracking_cycle_2_31_to_60_days;
    BOOLEAN Diff_payment_tracking_cycle_3_61_to_90_days;
    BOOLEAN Diff_payment_tracking_cycle_4_91_to_120_days;
    BOOLEAN Diff_payment_tracking_cycle_5_121_to_150days;
    BOOLEAN Diff_payment_tracking_number_of_times_cycle_6_151_to_180_days;
    BOOLEAN Diff_payment_tracking_number_of_times_cycle_7_181_or_greater_days;
    BOOLEAN Diff_date_account_was_charged_off;
    BOOLEAN Diff_amount_charged_off_by_creditor;
    BOOLEAN Diff_charge_off_type_indicator;
    BOOLEAN Diff_total_charge_off_recoveries_to_date;
    BOOLEAN Diff_government_guarantee_flag;
    BOOLEAN Diff_government_guarantee_category;
    BOOLEAN Diff_portion_of_account_guaranteed_by_government;
    BOOLEAN Diff_guarantors_indicator;
    BOOLEAN Diff_number_of_guarantors;
    BOOLEAN Diff_owners_indicator;
    BOOLEAN Diff_number_of_principals;
    BOOLEAN Diff_account_update_deletion_indicator;
    BOOLEAN Diff_percent_of_liability;
    BOOLEAN Diff_percent_of_ownership;
    UNSIGNED Num_Diffs;
    SALT33.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_timestamp := le.timestamp <> ri.timestamp;
    SELF.Diff_process_date := le.process_date <> ri.process_date;
    SELF.Diff_record_type := le.record_type <> ri.record_type;
    SELF.Diff_did := le.did <> ri.did;
    SELF.Diff_did_score := le.did_score <> ri.did_score;
    SELF.Diff_dt_first_seen := le.dt_first_seen <> ri.dt_first_seen;
    SELF.Diff_dt_last_seen := le.dt_last_seen <> ri.dt_last_seen;
    SELF.Diff_dt_vendor_first_reported := le.dt_vendor_first_reported <> ri.dt_vendor_first_reported;
    SELF.Diff_dt_vendor_last_reported := le.dt_vendor_last_reported <> ri.dt_vendor_last_reported;
    SELF.Diff_dt_datawarehouse_first_reported := le.dt_datawarehouse_first_reported <> ri.dt_datawarehouse_first_reported;
    SELF.Diff_dt_datawarehouse_last_reported := le.dt_datawarehouse_last_reported <> ri.dt_datawarehouse_last_reported;
    SELF.Diff_sbfe_contributor_number := le.sbfe_contributor_number <> ri.sbfe_contributor_number;
    SELF.Diff_contract_account_number := le.contract_account_number <> ri.contract_account_number;
    SELF.Diff_account_type_reported := le.account_type_reported <> ri.account_type_reported;
    SELF.Diff_extracted_date := le.extracted_date <> ri.extracted_date;
    SELF.Diff_cycle_end_date := le.cycle_end_date <> ri.cycle_end_date;
    SELF.Diff_account_holder_business_name := le.account_holder_business_name <> ri.account_holder_business_name;
    SELF.Diff_clean_account_holder_business_name := le.clean_account_holder_business_name <> ri.clean_account_holder_business_name;
    SELF.Diff_dba := le.dba <> ri.dba;
    SELF.Diff_clean_dba := le.clean_dba <> ri.clean_dba;
    SELF.Diff_business_name := le.business_name <> ri.business_name;
    SELF.Diff_clean_business_name := le.clean_business_name <> ri.clean_business_name;
    SELF.Diff_company_website := le.company_website <> ri.company_website;
    SELF.Diff_original_fname := le.original_fname <> ri.original_fname;
    SELF.Diff_original_mname := le.original_mname <> ri.original_mname;
    SELF.Diff_original_lname := le.original_lname <> ri.original_lname;
    SELF.Diff_original_suffix := le.original_suffix <> ri.original_suffix;
    SELF.Diff_e_mail_address := le.e_mail_address <> ri.e_mail_address;
    SELF.Diff_guarantor_owner_indicator := le.guarantor_owner_indicator <> ri.guarantor_owner_indicator;
    SELF.Diff_relationship_to_business_indicator := le.relationship_to_business_indicator <> ri.relationship_to_business_indicator;
    SELF.Diff_business_title := le.business_title <> ri.business_title;
    SELF.Diff_clean_title := le.clean_title <> ri.clean_title;
    SELF.Diff_clean_fname := le.clean_fname <> ri.clean_fname;
    SELF.Diff_clean_mname := le.clean_mname <> ri.clean_mname;
    SELF.Diff_clean_lname := le.clean_lname <> ri.clean_lname;
    SELF.Diff_clean_suffix := le.clean_suffix <> ri.clean_suffix;
    SELF.Diff_original_address_line_1 := le.original_address_line_1 <> ri.original_address_line_1;
    SELF.Diff_original_address_line_2 := le.original_address_line_2 <> ri.original_address_line_2;
    SELF.Diff_original_city := le.original_city <> ri.original_city;
    SELF.Diff_original_state := le.original_state <> ri.original_state;
    SELF.Diff_original_zip_code_or_ca_postal_code := le.original_zip_code_or_ca_postal_code <> ri.original_zip_code_or_ca_postal_code;
    SELF.Diff_original_postal_code := le.original_postal_code <> ri.original_postal_code;
    SELF.Diff_original_country_code := le.original_country_code <> ri.original_country_code;
    SELF.Diff_prim_range := le.prim_range <> ri.prim_range;
    SELF.Diff_predir := le.predir <> ri.predir;
    SELF.Diff_prim_name := le.prim_name <> ri.prim_name;
    SELF.Diff_addr_suffix := le.addr_suffix <> ri.addr_suffix;
    SELF.Diff_postdir := le.postdir <> ri.postdir;
    SELF.Diff_unit_desig := le.unit_desig <> ri.unit_desig;
    SELF.Diff_sec_range := le.sec_range <> ri.sec_range;
    SELF.Diff_p_city_name := le.p_city_name <> ri.p_city_name;
    SELF.Diff_v_city_name := le.v_city_name <> ri.v_city_name;
    SELF.Diff_st := le.st <> ri.st;
    SELF.Diff_zip := le.zip <> ri.zip;
    SELF.Diff_zip4 := le.zip4 <> ri.zip4;
    SELF.Diff_cart := le.cart <> ri.cart;
    SELF.Diff_cr_sort_sz := le.cr_sort_sz <> ri.cr_sort_sz;
    SELF.Diff_lot := le.lot <> ri.lot;
    SELF.Diff_lot_order := le.lot_order <> ri.lot_order;
    SELF.Diff_dbpc := le.dbpc <> ri.dbpc;
    SELF.Diff_chk_digit := le.chk_digit <> ri.chk_digit;
    SELF.Diff_rec_type := le.rec_type <> ri.rec_type;
    SELF.Diff_fips_state := le.fips_state <> ri.fips_state;
    SELF.Diff_fips_county := le.fips_county <> ri.fips_county;
    SELF.Diff_geo_lat := le.geo_lat <> ri.geo_lat;
    SELF.Diff_geo_long := le.geo_long <> ri.geo_long;
    SELF.Diff_msa := le.msa <> ri.msa;
    SELF.Diff_geo_blk := le.geo_blk <> ri.geo_blk;
    SELF.Diff_geo_match := le.geo_match <> ri.geo_match;
    SELF.Diff_err_stat := le.err_stat <> ri.err_stat;
    SELF.Diff_rawaid := le.rawaid <> ri.rawaid;
    SELF.Diff_original_area_code := le.original_area_code <> ri.original_area_code;
    SELF.Diff_original_phone_number := le.original_phone_number <> ri.original_phone_number;
    SELF.Diff_phone_extension := le.phone_extension <> ri.phone_extension;
    SELF.Diff_primary_phone_indicator := le.primary_phone_indicator <> ri.primary_phone_indicator;
    SELF.Diff_published_unlisted_indicator := le.published_unlisted_indicator <> ri.published_unlisted_indicator;
    SELF.Diff_phone_type := le.phone_type <> ri.phone_type;
    SELF.Diff_phone_number := le.phone_number <> ri.phone_number;
    SELF.Diff_federal_taxid_ssn := le.federal_taxid_ssn <> ri.federal_taxid_ssn;
    SELF.Diff_federal_taxid_ssn_identifier := le.federal_taxid_ssn_identifier <> ri.federal_taxid_ssn_identifier;
    SELF.Diff_dotid := le.dotid <> ri.dotid;
    SELF.Diff_dotscore := le.dotscore <> ri.dotscore;
    SELF.Diff_dotweight := le.dotweight <> ri.dotweight;
    SELF.Diff_empid := le.empid <> ri.empid;
    SELF.Diff_empscore := le.empscore <> ri.empscore;
    SELF.Diff_empweight := le.empweight <> ri.empweight;
    SELF.Diff_powid := le.powid <> ri.powid;
    SELF.Diff_powscore := le.powscore <> ri.powscore;
    SELF.Diff_powweight := le.powweight <> ri.powweight;
    SELF.Diff_proxid := le.proxid <> ri.proxid;
    SELF.Diff_proxscore := le.proxscore <> ri.proxscore;
    SELF.Diff_proxweight := le.proxweight <> ri.proxweight;
    SELF.Diff_seleid := le.seleid <> ri.seleid;
    SELF.Diff_selescore := le.selescore <> ri.selescore;
    SELF.Diff_seleweight := le.seleweight <> ri.seleweight;
    SELF.Diff_orgid := le.orgid <> ri.orgid;
    SELF.Diff_orgscore := le.orgscore <> ri.orgscore;
    SELF.Diff_orgweight := le.orgweight <> ri.orgweight;
    SELF.Diff_ultid := le.ultid <> ri.ultid;
    SELF.Diff_ultscore := le.ultscore <> ri.ultscore;
    SELF.Diff_ultweight := le.ultweight <> ri.ultweight;
    SELF.Diff_persistent_record_id := le.persistent_record_id <> ri.persistent_record_id;
    SELF.Diff_sbfe_id := le.sbfe_id <> ri.sbfe_id;
    SELF.Diff_source := le.source <> ri.source;
    SELF.Diff_active := le.active <> ri.active;
    SELF.Diff_legal_business_structure := le.legal_business_structure <> ri.legal_business_structure;
    SELF.Diff_business_established_date := le.business_established_date <> ri.business_established_date;
    SELF.Diff_account_status_1 := le.account_status_1 <> ri.account_status_1;
    SELF.Diff_account_status_2 := le.account_status_2 <> ri.account_status_2;
    SELF.Diff_date_account_opened := le.date_account_opened <> ri.date_account_opened;
    SELF.Diff_date_account_closed := le.date_account_closed <> ri.date_account_closed;
    SELF.Diff_account_closure_basis := le.account_closure_basis <> ri.account_closure_basis;
    SELF.Diff_account_expiration_date := le.account_expiration_date <> ri.account_expiration_date;
    SELF.Diff_last_activity_date := le.last_activity_date <> ri.last_activity_date;
    SELF.Diff_last_activity_type := le.last_activity_type <> ri.last_activity_type;
    SELF.Diff_recent_activity_indicator := le.recent_activity_indicator <> ri.recent_activity_indicator;
    SELF.Diff_original_credit_limit := le.original_credit_limit <> ri.original_credit_limit;
    SELF.Diff_highest_credit_used := le.highest_credit_used <> ri.highest_credit_used;
    SELF.Diff_current_credit_limit := le.current_credit_limit <> ri.current_credit_limit;
    SELF.Diff_reporting_indicator_length := le.reporting_indicator_length <> ri.reporting_indicator_length;
    SELF.Diff_payment_interval := le.payment_interval <> ri.payment_interval;
    SELF.Diff_payment_status_category := le.payment_status_category <> ri.payment_status_category;
    SELF.Diff_term_of_account_in_months := le.term_of_account_in_months <> ri.term_of_account_in_months;
    SELF.Diff_first_payment_due_date := le.first_payment_due_date <> ri.first_payment_due_date;
    SELF.Diff_final_payment_due_date := le.final_payment_due_date <> ri.final_payment_due_date;
    SELF.Diff_original_rate := le.original_rate <> ri.original_rate;
    SELF.Diff_floating_rate := le.floating_rate <> ri.floating_rate;
    SELF.Diff_grace_period := le.grace_period <> ri.grace_period;
    SELF.Diff_payment_category := le.payment_category <> ri.payment_category;
    SELF.Diff_payment_history_profile_12_months := le.payment_history_profile_12_months <> ri.payment_history_profile_12_months;
    SELF.Diff_payment_history_profile_13_24_months := le.payment_history_profile_13_24_months <> ri.payment_history_profile_13_24_months;
    SELF.Diff_payment_history_profile_25_36_months := le.payment_history_profile_25_36_months <> ri.payment_history_profile_25_36_months;
    SELF.Diff_payment_history_profile_37_48_months := le.payment_history_profile_37_48_months <> ri.payment_history_profile_37_48_months;
    SELF.Diff_payment_history_length := le.payment_history_length <> ri.payment_history_length;
    SELF.Diff_year_to_date_purchases_count := le.year_to_date_purchases_count <> ri.year_to_date_purchases_count;
    SELF.Diff_lifetime_to_date_purchases_count := le.lifetime_to_date_purchases_count <> ri.lifetime_to_date_purchases_count;
    SELF.Diff_year_to_date_purchases_sum_amount := le.year_to_date_purchases_sum_amount <> ri.year_to_date_purchases_sum_amount;
    SELF.Diff_lifetime_to_date_purchases_sum_amount := le.lifetime_to_date_purchases_sum_amount <> ri.lifetime_to_date_purchases_sum_amount;
    SELF.Diff_payment_amount_scheduled := le.payment_amount_scheduled <> ri.payment_amount_scheduled;
    SELF.Diff_recent_payment_amount := le.recent_payment_amount <> ri.recent_payment_amount;
    SELF.Diff_recent_payment_date := le.recent_payment_date <> ri.recent_payment_date;
    SELF.Diff_remaining_balance := le.remaining_balance <> ri.remaining_balance;
    SELF.Diff_carried_over_amount := le.carried_over_amount <> ri.carried_over_amount;
    SELF.Diff_new_applied_charges := le.new_applied_charges <> ri.new_applied_charges;
    SELF.Diff_balloon_payment_due := le.balloon_payment_due <> ri.balloon_payment_due;
    SELF.Diff_balloon_payment_due_date := le.balloon_payment_due_date <> ri.balloon_payment_due_date;
    SELF.Diff_delinquency_date := le.delinquency_date <> ri.delinquency_date;
    SELF.Diff_days_delinquent := le.days_delinquent <> ri.days_delinquent;
    SELF.Diff_past_due_amount := le.past_due_amount <> ri.past_due_amount;
    SELF.Diff_maximum_number_of_past_due_aging_amounts_buckets_provided := le.maximum_number_of_past_due_aging_amounts_buckets_provided <> ri.maximum_number_of_past_due_aging_amounts_buckets_provided;
    SELF.Diff_past_due_aging_bucket_type := le.past_due_aging_bucket_type <> ri.past_due_aging_bucket_type;
    SELF.Diff_past_due_aging_amount_bucket_1 := le.past_due_aging_amount_bucket_1 <> ri.past_due_aging_amount_bucket_1;
    SELF.Diff_past_due_aging_amount_bucket_2 := le.past_due_aging_amount_bucket_2 <> ri.past_due_aging_amount_bucket_2;
    SELF.Diff_past_due_aging_amount_bucket_3 := le.past_due_aging_amount_bucket_3 <> ri.past_due_aging_amount_bucket_3;
    SELF.Diff_past_due_aging_amount_bucket_4 := le.past_due_aging_amount_bucket_4 <> ri.past_due_aging_amount_bucket_4;
    SELF.Diff_past_due_aging_amount_bucket_5 := le.past_due_aging_amount_bucket_5 <> ri.past_due_aging_amount_bucket_5;
    SELF.Diff_past_due_aging_amount_bucket_6 := le.past_due_aging_amount_bucket_6 <> ri.past_due_aging_amount_bucket_6;
    SELF.Diff_past_due_aging_amount_bucket_7 := le.past_due_aging_amount_bucket_7 <> ri.past_due_aging_amount_bucket_7;
    SELF.Diff_maximum_number_of_payment_tracking_cycle_periods_provided := le.maximum_number_of_payment_tracking_cycle_periods_provided <> ri.maximum_number_of_payment_tracking_cycle_periods_provided;
    SELF.Diff_payment_tracking_cycle_type := le.payment_tracking_cycle_type <> ri.payment_tracking_cycle_type;
    SELF.Diff_payment_tracking_cycle_0_current := le.payment_tracking_cycle_0_current <> ri.payment_tracking_cycle_0_current;
    SELF.Diff_payment_tracking_cycle_1_1_to_30_days := le.payment_tracking_cycle_1_1_to_30_days <> ri.payment_tracking_cycle_1_1_to_30_days;
    SELF.Diff_payment_tracking_cycle_2_31_to_60_days := le.payment_tracking_cycle_2_31_to_60_days <> ri.payment_tracking_cycle_2_31_to_60_days;
    SELF.Diff_payment_tracking_cycle_3_61_to_90_days := le.payment_tracking_cycle_3_61_to_90_days <> ri.payment_tracking_cycle_3_61_to_90_days;
    SELF.Diff_payment_tracking_cycle_4_91_to_120_days := le.payment_tracking_cycle_4_91_to_120_days <> ri.payment_tracking_cycle_4_91_to_120_days;
    SELF.Diff_payment_tracking_cycle_5_121_to_150days := le.payment_tracking_cycle_5_121_to_150days <> ri.payment_tracking_cycle_5_121_to_150days;
    SELF.Diff_payment_tracking_number_of_times_cycle_6_151_to_180_days := le.payment_tracking_number_of_times_cycle_6_151_to_180_days <> ri.payment_tracking_number_of_times_cycle_6_151_to_180_days;
    SELF.Diff_payment_tracking_number_of_times_cycle_7_181_or_greater_days := le.payment_tracking_number_of_times_cycle_7_181_or_greater_days <> ri.payment_tracking_number_of_times_cycle_7_181_or_greater_days;
    SELF.Diff_date_account_was_charged_off := le.date_account_was_charged_off <> ri.date_account_was_charged_off;
    SELF.Diff_amount_charged_off_by_creditor := le.amount_charged_off_by_creditor <> ri.amount_charged_off_by_creditor;
    SELF.Diff_charge_off_type_indicator := le.charge_off_type_indicator <> ri.charge_off_type_indicator;
    SELF.Diff_total_charge_off_recoveries_to_date := le.total_charge_off_recoveries_to_date <> ri.total_charge_off_recoveries_to_date;
    SELF.Diff_government_guarantee_flag := le.government_guarantee_flag <> ri.government_guarantee_flag;
    SELF.Diff_government_guarantee_category := le.government_guarantee_category <> ri.government_guarantee_category;
    SELF.Diff_portion_of_account_guaranteed_by_government := le.portion_of_account_guaranteed_by_government <> ri.portion_of_account_guaranteed_by_government;
    SELF.Diff_guarantors_indicator := le.guarantors_indicator <> ri.guarantors_indicator;
    SELF.Diff_number_of_guarantors := le.number_of_guarantors <> ri.number_of_guarantors;
    SELF.Diff_owners_indicator := le.owners_indicator <> ri.owners_indicator;
    SELF.Diff_number_of_principals := le.number_of_principals <> ri.number_of_principals;
    SELF.Diff_account_update_deletion_indicator := le.account_update_deletion_indicator <> ri.account_update_deletion_indicator;
    SELF.Diff_percent_of_liability := le.percent_of_liability <> ri.percent_of_liability;
    SELF.Diff_percent_of_ownership := le.percent_of_ownership <> ri.percent_of_ownership;
    SELF.Val := (SALT33.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_timestamp,1,0)+ IF( SELF.Diff_process_date,1,0)+ IF( SELF.Diff_record_type,1,0)+ IF( SELF.Diff_did,1,0)+ IF( SELF.Diff_did_score,1,0)+ IF( SELF.Diff_dt_first_seen,1,0)+ IF( SELF.Diff_dt_last_seen,1,0)+ IF( SELF.Diff_dt_vendor_first_reported,1,0)+ IF( SELF.Diff_dt_vendor_last_reported,1,0)+ IF( SELF.Diff_dt_datawarehouse_first_reported,1,0)+ IF( SELF.Diff_dt_datawarehouse_last_reported,1,0)+ IF( SELF.Diff_sbfe_contributor_number,1,0)+ IF( SELF.Diff_contract_account_number,1,0)+ IF( SELF.Diff_account_type_reported,1,0)+ IF( SELF.Diff_extracted_date,1,0)+ IF( SELF.Diff_cycle_end_date,1,0)+ IF( SELF.Diff_account_holder_business_name,1,0)+ IF( SELF.Diff_clean_account_holder_business_name,1,0)+ IF( SELF.Diff_dba,1,0)+ IF( SELF.Diff_clean_dba,1,0)+ IF( SELF.Diff_business_name,1,0)+ IF( SELF.Diff_clean_business_name,1,0)+ IF( SELF.Diff_company_website,1,0)+ IF( SELF.Diff_original_fname,1,0)+ IF( SELF.Diff_original_mname,1,0)+ IF( SELF.Diff_original_lname,1,0)+ IF( SELF.Diff_original_suffix,1,0)+ IF( SELF.Diff_e_mail_address,1,0)+ IF( SELF.Diff_guarantor_owner_indicator,1,0)+ IF( SELF.Diff_relationship_to_business_indicator,1,0)+ IF( SELF.Diff_business_title,1,0)+ IF( SELF.Diff_clean_title,1,0)+ IF( SELF.Diff_clean_fname,1,0)+ IF( SELF.Diff_clean_mname,1,0)+ IF( SELF.Diff_clean_lname,1,0)+ IF( SELF.Diff_clean_suffix,1,0)+ IF( SELF.Diff_original_address_line_1,1,0)+ IF( SELF.Diff_original_address_line_2,1,0)+ IF( SELF.Diff_original_city,1,0)+ IF( SELF.Diff_original_state,1,0)+ IF( SELF.Diff_original_zip_code_or_ca_postal_code,1,0)+ IF( SELF.Diff_original_postal_code,1,0)+ IF( SELF.Diff_original_country_code,1,0)+ IF( SELF.Diff_prim_range,1,0)+ IF( SELF.Diff_predir,1,0)+ IF( SELF.Diff_prim_name,1,0)+ IF( SELF.Diff_addr_suffix,1,0)+ IF( SELF.Diff_postdir,1,0)+ IF( SELF.Diff_unit_desig,1,0)+ IF( SELF.Diff_sec_range,1,0)+ IF( SELF.Diff_p_city_name,1,0)+ IF( SELF.Diff_v_city_name,1,0)+ IF( SELF.Diff_st,1,0)+ IF( SELF.Diff_zip,1,0)+ IF( SELF.Diff_zip4,1,0)+ IF( SELF.Diff_cart,1,0)+ IF( SELF.Diff_cr_sort_sz,1,0)+ IF( SELF.Diff_lot,1,0)+ IF( SELF.Diff_lot_order,1,0)+ IF( SELF.Diff_dbpc,1,0)+ IF( SELF.Diff_chk_digit,1,0)+ IF( SELF.Diff_rec_type,1,0)+ IF( SELF.Diff_fips_state,1,0)+ IF( SELF.Diff_fips_county,1,0)+ IF( SELF.Diff_geo_lat,1,0)+ IF( SELF.Diff_geo_long,1,0)+ IF( SELF.Diff_msa,1,0)+ IF( SELF.Diff_geo_blk,1,0)+ IF( SELF.Diff_geo_match,1,0)+ IF( SELF.Diff_err_stat,1,0)+ IF( SELF.Diff_rawaid,1,0)+ IF( SELF.Diff_original_area_code,1,0)+ IF( SELF.Diff_original_phone_number,1,0)+ IF( SELF.Diff_phone_extension,1,0)+ IF( SELF.Diff_primary_phone_indicator,1,0)+ IF( SELF.Diff_published_unlisted_indicator,1,0)+ IF( SELF.Diff_phone_type,1,0)+ IF( SELF.Diff_phone_number,1,0)+ IF( SELF.Diff_federal_taxid_ssn,1,0)+ IF( SELF.Diff_federal_taxid_ssn_identifier,1,0)+ IF( SELF.Diff_dotid,1,0)+ IF( SELF.Diff_dotscore,1,0)+ IF( SELF.Diff_dotweight,1,0)+ IF( SELF.Diff_empid,1,0)+ IF( SELF.Diff_empscore,1,0)+ IF( SELF.Diff_empweight,1,0)+ IF( SELF.Diff_powid,1,0)+ IF( SELF.Diff_powscore,1,0)+ IF( SELF.Diff_powweight,1,0)+ IF( SELF.Diff_proxid,1,0)+ IF( SELF.Diff_proxscore,1,0)+ IF( SELF.Diff_proxweight,1,0)+ IF( SELF.Diff_seleid,1,0)+ IF( SELF.Diff_selescore,1,0)+ IF( SELF.Diff_seleweight,1,0)+ IF( SELF.Diff_orgid,1,0)+ IF( SELF.Diff_orgscore,1,0)+ IF( SELF.Diff_orgweight,1,0)+ IF( SELF.Diff_ultid,1,0)+ IF( SELF.Diff_ultscore,1,0)+ IF( SELF.Diff_ultweight,1,0)+ IF( SELF.Diff_persistent_record_id,1,0)+ IF( SELF.Diff_sbfe_id,1,0)+ IF( SELF.Diff_source,1,0)+ IF( SELF.Diff_active,1,0)+ IF( SELF.Diff_legal_business_structure,1,0)+ IF( SELF.Diff_business_established_date,1,0)+ IF( SELF.Diff_account_status_1,1,0)+ IF( SELF.Diff_account_status_2,1,0)+ IF( SELF.Diff_date_account_opened,1,0)+ IF( SELF.Diff_date_account_closed,1,0)+ IF( SELF.Diff_account_closure_basis,1,0)+ IF( SELF.Diff_account_expiration_date,1,0)+ IF( SELF.Diff_last_activity_date,1,0)+ IF( SELF.Diff_last_activity_type,1,0)+ IF( SELF.Diff_recent_activity_indicator,1,0)+ IF( SELF.Diff_original_credit_limit,1,0)+ IF( SELF.Diff_highest_credit_used,1,0)+ IF( SELF.Diff_current_credit_limit,1,0)+ IF( SELF.Diff_reporting_indicator_length,1,0)+ IF( SELF.Diff_payment_interval,1,0)+ IF( SELF.Diff_payment_status_category,1,0)+ IF( SELF.Diff_term_of_account_in_months,1,0)+ IF( SELF.Diff_first_payment_due_date,1,0)+ IF( SELF.Diff_final_payment_due_date,1,0)+ IF( SELF.Diff_original_rate,1,0)+ IF( SELF.Diff_floating_rate,1,0)+ IF( SELF.Diff_grace_period,1,0)+ IF( SELF.Diff_payment_category,1,0)+ IF( SELF.Diff_payment_history_profile_12_months,1,0)+ IF( SELF.Diff_payment_history_profile_13_24_months,1,0)+ IF( SELF.Diff_payment_history_profile_25_36_months,1,0)+ IF( SELF.Diff_payment_history_profile_37_48_months,1,0)+ IF( SELF.Diff_payment_history_length,1,0)+ IF( SELF.Diff_year_to_date_purchases_count,1,0)+ IF( SELF.Diff_lifetime_to_date_purchases_count,1,0)+ IF( SELF.Diff_year_to_date_purchases_sum_amount,1,0)+ IF( SELF.Diff_lifetime_to_date_purchases_sum_amount,1,0)+ IF( SELF.Diff_payment_amount_scheduled,1,0)+ IF( SELF.Diff_recent_payment_amount,1,0)+ IF( SELF.Diff_recent_payment_date,1,0)+ IF( SELF.Diff_remaining_balance,1,0)+ IF( SELF.Diff_carried_over_amount,1,0)+ IF( SELF.Diff_new_applied_charges,1,0)+ IF( SELF.Diff_balloon_payment_due,1,0)+ IF( SELF.Diff_balloon_payment_due_date,1,0)+ IF( SELF.Diff_delinquency_date,1,0)+ IF( SELF.Diff_days_delinquent,1,0)+ IF( SELF.Diff_past_due_amount,1,0)+ IF( SELF.Diff_maximum_number_of_past_due_aging_amounts_buckets_provided,1,0)+ IF( SELF.Diff_past_due_aging_bucket_type,1,0)+ IF( SELF.Diff_past_due_aging_amount_bucket_1,1,0)+ IF( SELF.Diff_past_due_aging_amount_bucket_2,1,0)+ IF( SELF.Diff_past_due_aging_amount_bucket_3,1,0)+ IF( SELF.Diff_past_due_aging_amount_bucket_4,1,0)+ IF( SELF.Diff_past_due_aging_amount_bucket_5,1,0)+ IF( SELF.Diff_past_due_aging_amount_bucket_6,1,0)+ IF( SELF.Diff_past_due_aging_amount_bucket_7,1,0)+ IF( SELF.Diff_maximum_number_of_payment_tracking_cycle_periods_provided,1,0)+ IF( SELF.Diff_payment_tracking_cycle_type,1,0)+ IF( SELF.Diff_payment_tracking_cycle_0_current,1,0)+ IF( SELF.Diff_payment_tracking_cycle_1_1_to_30_days,1,0)+ IF( SELF.Diff_payment_tracking_cycle_2_31_to_60_days,1,0)+ IF( SELF.Diff_payment_tracking_cycle_3_61_to_90_days,1,0)+ IF( SELF.Diff_payment_tracking_cycle_4_91_to_120_days,1,0)+ IF( SELF.Diff_payment_tracking_cycle_5_121_to_150days,1,0)+ IF( SELF.Diff_payment_tracking_number_of_times_cycle_6_151_to_180_days,1,0)+ IF( SELF.Diff_payment_tracking_number_of_times_cycle_7_181_or_greater_days,1,0)+ IF( SELF.Diff_date_account_was_charged_off,1,0)+ IF( SELF.Diff_amount_charged_off_by_creditor,1,0)+ IF( SELF.Diff_charge_off_type_indicator,1,0)+ IF( SELF.Diff_total_charge_off_recoveries_to_date,1,0)+ IF( SELF.Diff_government_guarantee_flag,1,0)+ IF( SELF.Diff_government_guarantee_category,1,0)+ IF( SELF.Diff_portion_of_account_guaranteed_by_government,1,0)+ IF( SELF.Diff_guarantors_indicator,1,0)+ IF( SELF.Diff_number_of_guarantors,1,0)+ IF( SELF.Diff_owners_indicator,1,0)+ IF( SELF.Diff_number_of_principals,1,0)+ IF( SELF.Diff_account_update_deletion_indicator,1,0)+ IF( SELF.Diff_percent_of_liability,1,0)+ IF( SELF.Diff_percent_of_ownership,1,0);
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
    Count_Diff_timestamp := COUNT(GROUP,%Closest%.Diff_timestamp);
    Count_Diff_process_date := COUNT(GROUP,%Closest%.Diff_process_date);
    Count_Diff_record_type := COUNT(GROUP,%Closest%.Diff_record_type);
    Count_Diff_did := COUNT(GROUP,%Closest%.Diff_did);
    Count_Diff_did_score := COUNT(GROUP,%Closest%.Diff_did_score);
    Count_Diff_dt_first_seen := COUNT(GROUP,%Closest%.Diff_dt_first_seen);
    Count_Diff_dt_last_seen := COUNT(GROUP,%Closest%.Diff_dt_last_seen);
    Count_Diff_dt_vendor_first_reported := COUNT(GROUP,%Closest%.Diff_dt_vendor_first_reported);
    Count_Diff_dt_vendor_last_reported := COUNT(GROUP,%Closest%.Diff_dt_vendor_last_reported);
    Count_Diff_dt_datawarehouse_first_reported := COUNT(GROUP,%Closest%.Diff_dt_datawarehouse_first_reported);
    Count_Diff_dt_datawarehouse_last_reported := COUNT(GROUP,%Closest%.Diff_dt_datawarehouse_last_reported);
    Count_Diff_sbfe_contributor_number := COUNT(GROUP,%Closest%.Diff_sbfe_contributor_number);
    Count_Diff_contract_account_number := COUNT(GROUP,%Closest%.Diff_contract_account_number);
    Count_Diff_account_type_reported := COUNT(GROUP,%Closest%.Diff_account_type_reported);
    Count_Diff_extracted_date := COUNT(GROUP,%Closest%.Diff_extracted_date);
    Count_Diff_cycle_end_date := COUNT(GROUP,%Closest%.Diff_cycle_end_date);
    Count_Diff_account_holder_business_name := COUNT(GROUP,%Closest%.Diff_account_holder_business_name);
    Count_Diff_clean_account_holder_business_name := COUNT(GROUP,%Closest%.Diff_clean_account_holder_business_name);
    Count_Diff_dba := COUNT(GROUP,%Closest%.Diff_dba);
    Count_Diff_clean_dba := COUNT(GROUP,%Closest%.Diff_clean_dba);
    Count_Diff_business_name := COUNT(GROUP,%Closest%.Diff_business_name);
    Count_Diff_clean_business_name := COUNT(GROUP,%Closest%.Diff_clean_business_name);
    Count_Diff_company_website := COUNT(GROUP,%Closest%.Diff_company_website);
    Count_Diff_original_fname := COUNT(GROUP,%Closest%.Diff_original_fname);
    Count_Diff_original_mname := COUNT(GROUP,%Closest%.Diff_original_mname);
    Count_Diff_original_lname := COUNT(GROUP,%Closest%.Diff_original_lname);
    Count_Diff_original_suffix := COUNT(GROUP,%Closest%.Diff_original_suffix);
    Count_Diff_e_mail_address := COUNT(GROUP,%Closest%.Diff_e_mail_address);
    Count_Diff_guarantor_owner_indicator := COUNT(GROUP,%Closest%.Diff_guarantor_owner_indicator);
    Count_Diff_relationship_to_business_indicator := COUNT(GROUP,%Closest%.Diff_relationship_to_business_indicator);
    Count_Diff_business_title := COUNT(GROUP,%Closest%.Diff_business_title);
    Count_Diff_clean_title := COUNT(GROUP,%Closest%.Diff_clean_title);
    Count_Diff_clean_fname := COUNT(GROUP,%Closest%.Diff_clean_fname);
    Count_Diff_clean_mname := COUNT(GROUP,%Closest%.Diff_clean_mname);
    Count_Diff_clean_lname := COUNT(GROUP,%Closest%.Diff_clean_lname);
    Count_Diff_clean_suffix := COUNT(GROUP,%Closest%.Diff_clean_suffix);
    Count_Diff_original_address_line_1 := COUNT(GROUP,%Closest%.Diff_original_address_line_1);
    Count_Diff_original_address_line_2 := COUNT(GROUP,%Closest%.Diff_original_address_line_2);
    Count_Diff_original_city := COUNT(GROUP,%Closest%.Diff_original_city);
    Count_Diff_original_state := COUNT(GROUP,%Closest%.Diff_original_state);
    Count_Diff_original_zip_code_or_ca_postal_code := COUNT(GROUP,%Closest%.Diff_original_zip_code_or_ca_postal_code);
    Count_Diff_original_postal_code := COUNT(GROUP,%Closest%.Diff_original_postal_code);
    Count_Diff_original_country_code := COUNT(GROUP,%Closest%.Diff_original_country_code);
    Count_Diff_prim_range := COUNT(GROUP,%Closest%.Diff_prim_range);
    Count_Diff_predir := COUNT(GROUP,%Closest%.Diff_predir);
    Count_Diff_prim_name := COUNT(GROUP,%Closest%.Diff_prim_name);
    Count_Diff_addr_suffix := COUNT(GROUP,%Closest%.Diff_addr_suffix);
    Count_Diff_postdir := COUNT(GROUP,%Closest%.Diff_postdir);
    Count_Diff_unit_desig := COUNT(GROUP,%Closest%.Diff_unit_desig);
    Count_Diff_sec_range := COUNT(GROUP,%Closest%.Diff_sec_range);
    Count_Diff_p_city_name := COUNT(GROUP,%Closest%.Diff_p_city_name);
    Count_Diff_v_city_name := COUNT(GROUP,%Closest%.Diff_v_city_name);
    Count_Diff_st := COUNT(GROUP,%Closest%.Diff_st);
    Count_Diff_zip := COUNT(GROUP,%Closest%.Diff_zip);
    Count_Diff_zip4 := COUNT(GROUP,%Closest%.Diff_zip4);
    Count_Diff_cart := COUNT(GROUP,%Closest%.Diff_cart);
    Count_Diff_cr_sort_sz := COUNT(GROUP,%Closest%.Diff_cr_sort_sz);
    Count_Diff_lot := COUNT(GROUP,%Closest%.Diff_lot);
    Count_Diff_lot_order := COUNT(GROUP,%Closest%.Diff_lot_order);
    Count_Diff_dbpc := COUNT(GROUP,%Closest%.Diff_dbpc);
    Count_Diff_chk_digit := COUNT(GROUP,%Closest%.Diff_chk_digit);
    Count_Diff_rec_type := COUNT(GROUP,%Closest%.Diff_rec_type);
    Count_Diff_fips_state := COUNT(GROUP,%Closest%.Diff_fips_state);
    Count_Diff_fips_county := COUNT(GROUP,%Closest%.Diff_fips_county);
    Count_Diff_geo_lat := COUNT(GROUP,%Closest%.Diff_geo_lat);
    Count_Diff_geo_long := COUNT(GROUP,%Closest%.Diff_geo_long);
    Count_Diff_msa := COUNT(GROUP,%Closest%.Diff_msa);
    Count_Diff_geo_blk := COUNT(GROUP,%Closest%.Diff_geo_blk);
    Count_Diff_geo_match := COUNT(GROUP,%Closest%.Diff_geo_match);
    Count_Diff_err_stat := COUNT(GROUP,%Closest%.Diff_err_stat);
    Count_Diff_rawaid := COUNT(GROUP,%Closest%.Diff_rawaid);
    Count_Diff_original_area_code := COUNT(GROUP,%Closest%.Diff_original_area_code);
    Count_Diff_original_phone_number := COUNT(GROUP,%Closest%.Diff_original_phone_number);
    Count_Diff_phone_extension := COUNT(GROUP,%Closest%.Diff_phone_extension);
    Count_Diff_primary_phone_indicator := COUNT(GROUP,%Closest%.Diff_primary_phone_indicator);
    Count_Diff_published_unlisted_indicator := COUNT(GROUP,%Closest%.Diff_published_unlisted_indicator);
    Count_Diff_phone_type := COUNT(GROUP,%Closest%.Diff_phone_type);
    Count_Diff_phone_number := COUNT(GROUP,%Closest%.Diff_phone_number);
    Count_Diff_federal_taxid_ssn := COUNT(GROUP,%Closest%.Diff_federal_taxid_ssn);
    Count_Diff_federal_taxid_ssn_identifier := COUNT(GROUP,%Closest%.Diff_federal_taxid_ssn_identifier);
    Count_Diff_dotid := COUNT(GROUP,%Closest%.Diff_dotid);
    Count_Diff_dotscore := COUNT(GROUP,%Closest%.Diff_dotscore);
    Count_Diff_dotweight := COUNT(GROUP,%Closest%.Diff_dotweight);
    Count_Diff_empid := COUNT(GROUP,%Closest%.Diff_empid);
    Count_Diff_empscore := COUNT(GROUP,%Closest%.Diff_empscore);
    Count_Diff_empweight := COUNT(GROUP,%Closest%.Diff_empweight);
    Count_Diff_powid := COUNT(GROUP,%Closest%.Diff_powid);
    Count_Diff_powscore := COUNT(GROUP,%Closest%.Diff_powscore);
    Count_Diff_powweight := COUNT(GROUP,%Closest%.Diff_powweight);
    Count_Diff_proxid := COUNT(GROUP,%Closest%.Diff_proxid);
    Count_Diff_proxscore := COUNT(GROUP,%Closest%.Diff_proxscore);
    Count_Diff_proxweight := COUNT(GROUP,%Closest%.Diff_proxweight);
    Count_Diff_seleid := COUNT(GROUP,%Closest%.Diff_seleid);
    Count_Diff_selescore := COUNT(GROUP,%Closest%.Diff_selescore);
    Count_Diff_seleweight := COUNT(GROUP,%Closest%.Diff_seleweight);
    Count_Diff_orgid := COUNT(GROUP,%Closest%.Diff_orgid);
    Count_Diff_orgscore := COUNT(GROUP,%Closest%.Diff_orgscore);
    Count_Diff_orgweight := COUNT(GROUP,%Closest%.Diff_orgweight);
    Count_Diff_ultid := COUNT(GROUP,%Closest%.Diff_ultid);
    Count_Diff_ultscore := COUNT(GROUP,%Closest%.Diff_ultscore);
    Count_Diff_ultweight := COUNT(GROUP,%Closest%.Diff_ultweight);
    Count_Diff_persistent_record_id := COUNT(GROUP,%Closest%.Diff_persistent_record_id);
    Count_Diff_sbfe_id := COUNT(GROUP,%Closest%.Diff_sbfe_id);
    Count_Diff_source := COUNT(GROUP,%Closest%.Diff_source);
    Count_Diff_active := COUNT(GROUP,%Closest%.Diff_active);
    Count_Diff_legal_business_structure := COUNT(GROUP,%Closest%.Diff_legal_business_structure);
    Count_Diff_business_established_date := COUNT(GROUP,%Closest%.Diff_business_established_date);
    Count_Diff_account_status_1 := COUNT(GROUP,%Closest%.Diff_account_status_1);
    Count_Diff_account_status_2 := COUNT(GROUP,%Closest%.Diff_account_status_2);
    Count_Diff_date_account_opened := COUNT(GROUP,%Closest%.Diff_date_account_opened);
    Count_Diff_date_account_closed := COUNT(GROUP,%Closest%.Diff_date_account_closed);
    Count_Diff_account_closure_basis := COUNT(GROUP,%Closest%.Diff_account_closure_basis);
    Count_Diff_account_expiration_date := COUNT(GROUP,%Closest%.Diff_account_expiration_date);
    Count_Diff_last_activity_date := COUNT(GROUP,%Closest%.Diff_last_activity_date);
    Count_Diff_last_activity_type := COUNT(GROUP,%Closest%.Diff_last_activity_type);
    Count_Diff_recent_activity_indicator := COUNT(GROUP,%Closest%.Diff_recent_activity_indicator);
    Count_Diff_original_credit_limit := COUNT(GROUP,%Closest%.Diff_original_credit_limit);
    Count_Diff_highest_credit_used := COUNT(GROUP,%Closest%.Diff_highest_credit_used);
    Count_Diff_current_credit_limit := COUNT(GROUP,%Closest%.Diff_current_credit_limit);
    Count_Diff_reporting_indicator_length := COUNT(GROUP,%Closest%.Diff_reporting_indicator_length);
    Count_Diff_payment_interval := COUNT(GROUP,%Closest%.Diff_payment_interval);
    Count_Diff_payment_status_category := COUNT(GROUP,%Closest%.Diff_payment_status_category);
    Count_Diff_term_of_account_in_months := COUNT(GROUP,%Closest%.Diff_term_of_account_in_months);
    Count_Diff_first_payment_due_date := COUNT(GROUP,%Closest%.Diff_first_payment_due_date);
    Count_Diff_final_payment_due_date := COUNT(GROUP,%Closest%.Diff_final_payment_due_date);
    Count_Diff_original_rate := COUNT(GROUP,%Closest%.Diff_original_rate);
    Count_Diff_floating_rate := COUNT(GROUP,%Closest%.Diff_floating_rate);
    Count_Diff_grace_period := COUNT(GROUP,%Closest%.Diff_grace_period);
    Count_Diff_payment_category := COUNT(GROUP,%Closest%.Diff_payment_category);
    Count_Diff_payment_history_profile_12_months := COUNT(GROUP,%Closest%.Diff_payment_history_profile_12_months);
    Count_Diff_payment_history_profile_13_24_months := COUNT(GROUP,%Closest%.Diff_payment_history_profile_13_24_months);
    Count_Diff_payment_history_profile_25_36_months := COUNT(GROUP,%Closest%.Diff_payment_history_profile_25_36_months);
    Count_Diff_payment_history_profile_37_48_months := COUNT(GROUP,%Closest%.Diff_payment_history_profile_37_48_months);
    Count_Diff_payment_history_length := COUNT(GROUP,%Closest%.Diff_payment_history_length);
    Count_Diff_year_to_date_purchases_count := COUNT(GROUP,%Closest%.Diff_year_to_date_purchases_count);
    Count_Diff_lifetime_to_date_purchases_count := COUNT(GROUP,%Closest%.Diff_lifetime_to_date_purchases_count);
    Count_Diff_year_to_date_purchases_sum_amount := COUNT(GROUP,%Closest%.Diff_year_to_date_purchases_sum_amount);
    Count_Diff_lifetime_to_date_purchases_sum_amount := COUNT(GROUP,%Closest%.Diff_lifetime_to_date_purchases_sum_amount);
    Count_Diff_payment_amount_scheduled := COUNT(GROUP,%Closest%.Diff_payment_amount_scheduled);
    Count_Diff_recent_payment_amount := COUNT(GROUP,%Closest%.Diff_recent_payment_amount);
    Count_Diff_recent_payment_date := COUNT(GROUP,%Closest%.Diff_recent_payment_date);
    Count_Diff_remaining_balance := COUNT(GROUP,%Closest%.Diff_remaining_balance);
    Count_Diff_carried_over_amount := COUNT(GROUP,%Closest%.Diff_carried_over_amount);
    Count_Diff_new_applied_charges := COUNT(GROUP,%Closest%.Diff_new_applied_charges);
    Count_Diff_balloon_payment_due := COUNT(GROUP,%Closest%.Diff_balloon_payment_due);
    Count_Diff_balloon_payment_due_date := COUNT(GROUP,%Closest%.Diff_balloon_payment_due_date);
    Count_Diff_delinquency_date := COUNT(GROUP,%Closest%.Diff_delinquency_date);
    Count_Diff_days_delinquent := COUNT(GROUP,%Closest%.Diff_days_delinquent);
    Count_Diff_past_due_amount := COUNT(GROUP,%Closest%.Diff_past_due_amount);
    Count_Diff_maximum_number_of_past_due_aging_amounts_buckets_provided := COUNT(GROUP,%Closest%.Diff_maximum_number_of_past_due_aging_amounts_buckets_provided);
    Count_Diff_past_due_aging_bucket_type := COUNT(GROUP,%Closest%.Diff_past_due_aging_bucket_type);
    Count_Diff_past_due_aging_amount_bucket_1 := COUNT(GROUP,%Closest%.Diff_past_due_aging_amount_bucket_1);
    Count_Diff_past_due_aging_amount_bucket_2 := COUNT(GROUP,%Closest%.Diff_past_due_aging_amount_bucket_2);
    Count_Diff_past_due_aging_amount_bucket_3 := COUNT(GROUP,%Closest%.Diff_past_due_aging_amount_bucket_3);
    Count_Diff_past_due_aging_amount_bucket_4 := COUNT(GROUP,%Closest%.Diff_past_due_aging_amount_bucket_4);
    Count_Diff_past_due_aging_amount_bucket_5 := COUNT(GROUP,%Closest%.Diff_past_due_aging_amount_bucket_5);
    Count_Diff_past_due_aging_amount_bucket_6 := COUNT(GROUP,%Closest%.Diff_past_due_aging_amount_bucket_6);
    Count_Diff_past_due_aging_amount_bucket_7 := COUNT(GROUP,%Closest%.Diff_past_due_aging_amount_bucket_7);
    Count_Diff_maximum_number_of_payment_tracking_cycle_periods_provided := COUNT(GROUP,%Closest%.Diff_maximum_number_of_payment_tracking_cycle_periods_provided);
    Count_Diff_payment_tracking_cycle_type := COUNT(GROUP,%Closest%.Diff_payment_tracking_cycle_type);
    Count_Diff_payment_tracking_cycle_0_current := COUNT(GROUP,%Closest%.Diff_payment_tracking_cycle_0_current);
    Count_Diff_payment_tracking_cycle_1_1_to_30_days := COUNT(GROUP,%Closest%.Diff_payment_tracking_cycle_1_1_to_30_days);
    Count_Diff_payment_tracking_cycle_2_31_to_60_days := COUNT(GROUP,%Closest%.Diff_payment_tracking_cycle_2_31_to_60_days);
    Count_Diff_payment_tracking_cycle_3_61_to_90_days := COUNT(GROUP,%Closest%.Diff_payment_tracking_cycle_3_61_to_90_days);
    Count_Diff_payment_tracking_cycle_4_91_to_120_days := COUNT(GROUP,%Closest%.Diff_payment_tracking_cycle_4_91_to_120_days);
    Count_Diff_payment_tracking_cycle_5_121_to_150days := COUNT(GROUP,%Closest%.Diff_payment_tracking_cycle_5_121_to_150days);
    Count_Diff_payment_tracking_number_of_times_cycle_6_151_to_180_days := COUNT(GROUP,%Closest%.Diff_payment_tracking_number_of_times_cycle_6_151_to_180_days);
    Count_Diff_payment_tracking_number_of_times_cycle_7_181_or_greater_days := COUNT(GROUP,%Closest%.Diff_payment_tracking_number_of_times_cycle_7_181_or_greater_days);
    Count_Diff_date_account_was_charged_off := COUNT(GROUP,%Closest%.Diff_date_account_was_charged_off);
    Count_Diff_amount_charged_off_by_creditor := COUNT(GROUP,%Closest%.Diff_amount_charged_off_by_creditor);
    Count_Diff_charge_off_type_indicator := COUNT(GROUP,%Closest%.Diff_charge_off_type_indicator);
    Count_Diff_total_charge_off_recoveries_to_date := COUNT(GROUP,%Closest%.Diff_total_charge_off_recoveries_to_date);
    Count_Diff_government_guarantee_flag := COUNT(GROUP,%Closest%.Diff_government_guarantee_flag);
    Count_Diff_government_guarantee_category := COUNT(GROUP,%Closest%.Diff_government_guarantee_category);
    Count_Diff_portion_of_account_guaranteed_by_government := COUNT(GROUP,%Closest%.Diff_portion_of_account_guaranteed_by_government);
    Count_Diff_guarantors_indicator := COUNT(GROUP,%Closest%.Diff_guarantors_indicator);
    Count_Diff_number_of_guarantors := COUNT(GROUP,%Closest%.Diff_number_of_guarantors);
    Count_Diff_owners_indicator := COUNT(GROUP,%Closest%.Diff_owners_indicator);
    Count_Diff_number_of_principals := COUNT(GROUP,%Closest%.Diff_number_of_principals);
    Count_Diff_account_update_deletion_indicator := COUNT(GROUP,%Closest%.Diff_account_update_deletion_indicator);
    Count_Diff_percent_of_liability := COUNT(GROUP,%Closest%.Diff_percent_of_liability);
    Count_Diff_percent_of_ownership := COUNT(GROUP,%Closest%.Diff_percent_of_ownership);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
