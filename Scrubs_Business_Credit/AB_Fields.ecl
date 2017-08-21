IMPORT ut,SALT33;
IMPORT Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT AB_Fields := MODULE
// Processing for each FieldType
EXPORT SALT33.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_segment_identifier','invalid_file_segment_num','invalid_parent_sequence_number','invalid_accholder_businessname','invalid_dba','invalid_comp_website','invalid_legal_busi_structure','invalid_busi_established_date','invalid_contractacc_num','invalid_accounttypereported','invalid_acc_status1','invalid_acc_status2','invalid_dateaccopened','invalid_dateaccclosed','invalid_accountcloseurebasis','invalid_accexpirationdate','invalid_lastactivitydate','invalid_lastactivitytype','invalid_recentactivityindicator','invalid_origcreditlimit','invalid_highestcreditused','invalid_currentcreditlimit','invalid_reporterindicatorlength','invalid_paymentinterval','invalid_paymentstatuscategory','invalid_termofacc_months','invalid_firstpymtduedate','invalid_finalpymtduedate','invalid_origrate','invalid_floatingrate','invalid_graceperiod','invalid_paymentcategory','invalid_pymthistprofile12','invalid_pymthistprofile13_24','invalid_pymthistprofile25_36','invalid_pymthistprofile37_48','invalid_pymthistlength','invalid_ytd_purchasescount','invalid_ltd_purchasescount','invalid_ytd_purchasessumamt','invalid_ltd_purchasessumamt','invalid_pymtamtscheduled','invalid_recentpymtamt','invalid_recentpaymentdate','invalid_remainingbalance','invalid_carriedoveramt','invalid_newappliedcharges','invalid_balloonpymtdue','invalid_balloonpymtduedate','invalid_delinquencydate','invalid_daysdelinquent','invalid_pastdueamt','invalid_maximum_num_bucket','invalid_past_due_aging_bucket_type','invalid_past_due_aging_amount_bucket_1','invalid_past_due_aging_amount_bucket_2','invalid_past_due_aging_amount_bucket_3','invalid_past_due_aging_amount_bucket_4','invalid_past_due_aging_amount_bucket_5','invalid_past_due_aging_amount_bucket_6','invalid_past_due_aging_amount_bucket_7','invalid_maximum_num_tracking','invalid_payment_tracking_cycle_type','invalid_num','invalid_date_account_was_charged_off','invalid_amount_charged_off_by_creditor','invalid_charge_off_type_indicator','invalid_total_charge_off_recoveries_to_date','invalid_government_guarantee_flag','invalid_government_guarantee_category','invalid_guarantors_indicator','invalid_number_of_guarantors','invalid_owners_indicator','invalid_number_of_principals','invalid_account_update_deletion_indicator');
EXPORT FieldTypeNum(SALT33.StrType fn) := CASE(fn,'invalid_segment_identifier' => 1,'invalid_file_segment_num' => 2,'invalid_parent_sequence_number' => 3,'invalid_accholder_businessname' => 4,'invalid_dba' => 5,'invalid_comp_website' => 6,'invalid_legal_busi_structure' => 7,'invalid_busi_established_date' => 8,'invalid_contractacc_num' => 9,'invalid_accounttypereported' => 10,'invalid_acc_status1' => 11,'invalid_acc_status2' => 12,'invalid_dateaccopened' => 13,'invalid_dateaccclosed' => 14,'invalid_accountcloseurebasis' => 15,'invalid_accexpirationdate' => 16,'invalid_lastactivitydate' => 17,'invalid_lastactivitytype' => 18,'invalid_recentactivityindicator' => 19,'invalid_origcreditlimit' => 20,'invalid_highestcreditused' => 21,'invalid_currentcreditlimit' => 22,'invalid_reporterindicatorlength' => 23,'invalid_paymentinterval' => 24,'invalid_paymentstatuscategory' => 25,'invalid_termofacc_months' => 26,'invalid_firstpymtduedate' => 27,'invalid_finalpymtduedate' => 28,'invalid_origrate' => 29,'invalid_floatingrate' => 30,'invalid_graceperiod' => 31,'invalid_paymentcategory' => 32,'invalid_pymthistprofile12' => 33,'invalid_pymthistprofile13_24' => 34,'invalid_pymthistprofile25_36' => 35,'invalid_pymthistprofile37_48' => 36,'invalid_pymthistlength' => 37,'invalid_ytd_purchasescount' => 38,'invalid_ltd_purchasescount' => 39,'invalid_ytd_purchasessumamt' => 40,'invalid_ltd_purchasessumamt' => 41,'invalid_pymtamtscheduled' => 42,'invalid_recentpymtamt' => 43,'invalid_recentpaymentdate' => 44,'invalid_remainingbalance' => 45,'invalid_carriedoveramt' => 46,'invalid_newappliedcharges' => 47,'invalid_balloonpymtdue' => 48,'invalid_balloonpymtduedate' => 49,'invalid_delinquencydate' => 50,'invalid_daysdelinquent' => 51,'invalid_pastdueamt' => 52,'invalid_maximum_num_bucket' => 53,'invalid_past_due_aging_bucket_type' => 54,'invalid_past_due_aging_amount_bucket_1' => 55,'invalid_past_due_aging_amount_bucket_2' => 56,'invalid_past_due_aging_amount_bucket_3' => 57,'invalid_past_due_aging_amount_bucket_4' => 58,'invalid_past_due_aging_amount_bucket_5' => 59,'invalid_past_due_aging_amount_bucket_6' => 60,'invalid_past_due_aging_amount_bucket_7' => 61,'invalid_maximum_num_tracking' => 62,'invalid_payment_tracking_cycle_type' => 63,'invalid_num' => 64,'invalid_date_account_was_charged_off' => 65,'invalid_amount_charged_off_by_creditor' => 66,'invalid_charge_off_type_indicator' => 67,'invalid_total_charge_off_recoveries_to_date' => 68,'invalid_government_guarantee_flag' => 69,'invalid_government_guarantee_category' => 70,'invalid_guarantors_indicator' => 71,'invalid_number_of_guarantors' => 72,'invalid_owners_indicator' => 73,'invalid_number_of_principals' => 74,'invalid_account_update_deletion_indicator' => 75,0);
EXPORT MakeFT_invalid_segment_identifier(SALT33.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_segment_identifier(SALT33.StrType s) := WHICH(((SALT33.StrType) s) NOT IN ['AB','AB']);
EXPORT InValidMessageFT_invalid_segment_identifier(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInEnum('AB|AB'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_file_segment_num(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_file_segment_num(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) >= 1));
EXPORT InValidMessageFT_invalid_file_segment_num(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('0123456789'),SALT33.HygieneErrors.NotLength('1..'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_parent_sequence_number(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_parent_sequence_number(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) >= 1));
EXPORT InValidMessageFT_invalid_parent_sequence_number(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('0123456789'),SALT33.HygieneErrors.NotLength('1..'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_accholder_businessname(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 ,&.\'-/#`+"!*@():;'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_accholder_businessname(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 ,&.\'-/#`+"!*@():;'))),~(LENGTH(TRIM(s)) >= 1));
EXPORT InValidMessageFT_invalid_accholder_businessname(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 ,&.\'-/#`+"!*@():;'),SALT33.HygieneErrors.NotLength('1..'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_dba(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 ,&.\'-/#`+"!*@():;'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_dba(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 ,&.\'-/#`+"!*@():;'))));
EXPORT InValidMessageFT_invalid_dba(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 ,&.\'-/#`+"!*@():;'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_comp_website(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789. /:-'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_comp_website(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789. /:-'))));
EXPORT InValidMessageFT_invalid_comp_website(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789. /:-'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_legal_busi_structure(SALT33.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_legal_busi_structure(SALT33.StrType s) := WHICH(((SALT33.StrType) s) NOT IN ['001','002','003','004','005','006','007','008','009','010','011','012','013','014','015','016','050','051','052','053','070','071','080','']);
EXPORT InValidMessageFT_invalid_legal_busi_structure(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInEnum('001|002|003|004|005|006|007|008|009|010|011|012|013|014|015|016|050|051|052|053|070|071|080|'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_busi_established_date(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_busi_established_date(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'0123456789'))),~Scrubs.fn_valid_date(s)>0,~(LENGTH(TRIM(s)) = 8 OR LENGTH(TRIM(s)) = 6 OR LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_busi_established_date(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('0123456789'),SALT33.HygieneErrors.CustomFail('Scrubs.fn_valid_date'),SALT33.HygieneErrors.NotLength('8,6,4,0'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_contractacc_num(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789- _'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_contractacc_num(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789- _'))),~(LENGTH(TRIM(s)) >= 1));
EXPORT InValidMessageFT_invalid_contractacc_num(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789- _'),SALT33.HygieneErrors.NotLength('1..'),SALT33.HygieneErrors.Good);
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
EXPORT InValidFT_invalid_accexpirationdate(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'0123456789'))),~Scrubs.fn_valid_date(s,'future')>0,~(LENGTH(TRIM(s)) = 8 OR LENGTH(TRIM(s)) = 6 OR LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 0));
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
EXPORT InValidFT_invalid_paymentstatuscategory(SALT33.StrType s) := WHICH(((SALT33.StrType) s) NOT IN ['000','001','002','003','004','005','006','007','']);
EXPORT InValidMessageFT_invalid_paymentstatuscategory(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInEnum('000|001|002|003|004|005|006|007|'),SALT33.HygieneErrors.Good);
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
EXPORT InValidFT_invalid_firstpymtduedate(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'0123456789'))),~Scrubs.fn_valid_date(s)>0,~(LENGTH(TRIM(s)) = 8 OR LENGTH(TRIM(s)) = 6 OR LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_firstpymtduedate(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('0123456789'),SALT33.HygieneErrors.CustomFail('Scrubs.fn_valid_date'),SALT33.HygieneErrors.NotLength('8,6,4,0'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_finalpymtduedate(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_finalpymtduedate(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'0123456789'))),~Scrubs.fn_valid_date(s)>0,~(LENGTH(TRIM(s)) = 8 OR LENGTH(TRIM(s)) = 6 OR LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_finalpymtduedate(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('0123456789'),SALT33.HygieneErrors.CustomFail('Scrubs.fn_valid_date'),SALT33.HygieneErrors.NotLength('8,6,4,0'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_origrate(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'.0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_origrate(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'.0123456789'))));
EXPORT InValidMessageFT_invalid_origrate(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('.0123456789'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_floatingrate(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_floatingrate(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_invalid_floatingrate(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('0123456789'),SALT33.HygieneErrors.Good);
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
EXPORT InValidFT_invalid_balloonpymtduedate(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'0123456789'))),~Scrubs.fn_valid_date(s,'future')>0,~(LENGTH(TRIM(s)) = 8 OR LENGTH(TRIM(s)) = 6 OR LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 0));
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
EXPORT MakeFT_invalid_maximum_num_bucket(SALT33.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_maximum_num_bucket(SALT33.StrType s) := WHICH(((SALT33.StrType) s) NOT IN ['001','002','003','004','005','006','007','']);
EXPORT InValidMessageFT_invalid_maximum_num_bucket(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInEnum('001|002|003|004|005|006|007|'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_past_due_aging_bucket_type(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_past_due_aging_bucket_type(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_invalid_past_due_aging_bucket_type(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('0123456789'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_past_due_aging_amount_bucket_1(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'0123456789-'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_past_due_aging_amount_bucket_1(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'0123456789-'))));
EXPORT InValidMessageFT_invalid_past_due_aging_amount_bucket_1(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('0123456789-'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_past_due_aging_amount_bucket_2(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'0123456789-'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_past_due_aging_amount_bucket_2(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'0123456789-'))));
EXPORT InValidMessageFT_invalid_past_due_aging_amount_bucket_2(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('0123456789-'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_past_due_aging_amount_bucket_3(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'0123456789-'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_past_due_aging_amount_bucket_3(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'0123456789-'))));
EXPORT InValidMessageFT_invalid_past_due_aging_amount_bucket_3(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('0123456789-'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_past_due_aging_amount_bucket_4(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'0123456789-'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_past_due_aging_amount_bucket_4(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'0123456789-'))));
EXPORT InValidMessageFT_invalid_past_due_aging_amount_bucket_4(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('0123456789-'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_past_due_aging_amount_bucket_5(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'0123456789-'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_past_due_aging_amount_bucket_5(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'0123456789-'))));
EXPORT InValidMessageFT_invalid_past_due_aging_amount_bucket_5(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('0123456789-'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_past_due_aging_amount_bucket_6(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'0123456789-'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_past_due_aging_amount_bucket_6(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'0123456789-'))));
EXPORT InValidMessageFT_invalid_past_due_aging_amount_bucket_6(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('0123456789-'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_past_due_aging_amount_bucket_7(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'0123456789-'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_past_due_aging_amount_bucket_7(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'0123456789-'))));
EXPORT InValidMessageFT_invalid_past_due_aging_amount_bucket_7(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('0123456789-'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_maximum_num_tracking(SALT33.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_maximum_num_tracking(SALT33.StrType s) := WHICH(((SALT33.StrType) s) NOT IN ['000','001','002','003','004','005','006','007','']);
EXPORT InValidMessageFT_invalid_maximum_num_tracking(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInEnum('000|001|002|003|004|005|006|007|'),SALT33.HygieneErrors.Good);
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
EXPORT SALT33.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'segment_identifier','file_sequence_number','parent_sequence_number','account_holder_business_name','dba','company_website','legal_business_structure','business_established_date','contract_account_number','account_type_reported','account_status_1','account_status_2','date_account_opened','date_account_closed','account_closure_basis','account_expiration_date','last_activity_date','last_activity_type','recent_activity_indicator','original_credit_limit','highest_credit_used','current_credit_limit','reporting_indicator_length','payment_interval','payment_status_category','term_of_account_in_months','first_payment_due_date','final_payment_due_date','original_rate','floating_rate','grace_period','payment_category','payment_history_profile_12_months','payment_history_profile_13_24_months','payment_history_profile_25_36_months','payment_history_profile_37_48_months','payment_history_length','year_to_date_purchases_count','lifetime_to_date_purchases_count','year_to_date_purchases_sum_amount','lifetime_to_date_purchases_sum_amount','payment_amount_scheduled','recent_payment_amount','recent_payment_date','remaining_balance','carried_over_amount','new_applied_charges','balloon_payment_due','balloon_payment_due_date','delinquency_date','days_delinquent','past_due_amount','maximum_number_of_past_due_aging_amounts_buckets_provided','past_due_aging_bucket_type','past_due_aging_amount_bucket_1','past_due_aging_amount_bucket_2','past_due_aging_amount_bucket_3','past_due_aging_amount_bucket_4','past_due_aging_amount_bucket_5','past_due_aging_amount_bucket_6','past_due_aging_amount_bucket_7','maximum_number_of_payment_tracking_cycle_periods_provided','payment_tracking_cycle_type','payment_tracking_cycle_0_current','payment_tracking_cycle_1_1_to_30_days','payment_tracking_cycle_2_31_to_60_days','payment_tracking_cycle_3_61_to_90_days','payment_tracking_cycle_4_91_to_120_days','payment_tracking_cycle_5_121_to_150days','payment_tracking_number_of_times_cycle_6_151_to_180_days','payment_tracking_number_of_times_cycle_7_181_or_greater_days','date_account_was_charged_off','amount_charged_off_by_creditor','charge_off_type_indicator','total_charge_off_recoveries_to_date','government_guarantee_flag','government_guarantee_category','portion_of_account_guaranteed_by_government','guarantors_indicator','number_of_guarantors','owners_indicator','number_of_principals','account_update_deletion_indicator');
EXPORT FieldNum(SALT33.StrType fn) := CASE(fn,'segment_identifier' => 0,'file_sequence_number' => 1,'parent_sequence_number' => 2,'account_holder_business_name' => 3,'dba' => 4,'company_website' => 5,'legal_business_structure' => 6,'business_established_date' => 7,'contract_account_number' => 8,'account_type_reported' => 9,'account_status_1' => 10,'account_status_2' => 11,'date_account_opened' => 12,'date_account_closed' => 13,'account_closure_basis' => 14,'account_expiration_date' => 15,'last_activity_date' => 16,'last_activity_type' => 17,'recent_activity_indicator' => 18,'original_credit_limit' => 19,'highest_credit_used' => 20,'current_credit_limit' => 21,'reporting_indicator_length' => 22,'payment_interval' => 23,'payment_status_category' => 24,'term_of_account_in_months' => 25,'first_payment_due_date' => 26,'final_payment_due_date' => 27,'original_rate' => 28,'floating_rate' => 29,'grace_period' => 30,'payment_category' => 31,'payment_history_profile_12_months' => 32,'payment_history_profile_13_24_months' => 33,'payment_history_profile_25_36_months' => 34,'payment_history_profile_37_48_months' => 35,'payment_history_length' => 36,'year_to_date_purchases_count' => 37,'lifetime_to_date_purchases_count' => 38,'year_to_date_purchases_sum_amount' => 39,'lifetime_to_date_purchases_sum_amount' => 40,'payment_amount_scheduled' => 41,'recent_payment_amount' => 42,'recent_payment_date' => 43,'remaining_balance' => 44,'carried_over_amount' => 45,'new_applied_charges' => 46,'balloon_payment_due' => 47,'balloon_payment_due_date' => 48,'delinquency_date' => 49,'days_delinquent' => 50,'past_due_amount' => 51,'maximum_number_of_past_due_aging_amounts_buckets_provided' => 52,'past_due_aging_bucket_type' => 53,'past_due_aging_amount_bucket_1' => 54,'past_due_aging_amount_bucket_2' => 55,'past_due_aging_amount_bucket_3' => 56,'past_due_aging_amount_bucket_4' => 57,'past_due_aging_amount_bucket_5' => 58,'past_due_aging_amount_bucket_6' => 59,'past_due_aging_amount_bucket_7' => 60,'maximum_number_of_payment_tracking_cycle_periods_provided' => 61,'payment_tracking_cycle_type' => 62,'payment_tracking_cycle_0_current' => 63,'payment_tracking_cycle_1_1_to_30_days' => 64,'payment_tracking_cycle_2_31_to_60_days' => 65,'payment_tracking_cycle_3_61_to_90_days' => 66,'payment_tracking_cycle_4_91_to_120_days' => 67,'payment_tracking_cycle_5_121_to_150days' => 68,'payment_tracking_number_of_times_cycle_6_151_to_180_days' => 69,'payment_tracking_number_of_times_cycle_7_181_or_greater_days' => 70,'date_account_was_charged_off' => 71,'amount_charged_off_by_creditor' => 72,'charge_off_type_indicator' => 73,'total_charge_off_recoveries_to_date' => 74,'government_guarantee_flag' => 75,'government_guarantee_category' => 76,'portion_of_account_guaranteed_by_government' => 77,'guarantors_indicator' => 78,'number_of_guarantors' => 79,'owners_indicator' => 80,'number_of_principals' => 81,'account_update_deletion_indicator' => 82,0);
//Individual field level validation
EXPORT Make_segment_identifier(SALT33.StrType s0) := MakeFT_invalid_segment_identifier(s0);
EXPORT InValid_segment_identifier(SALT33.StrType s) := InValidFT_invalid_segment_identifier(s);
EXPORT InValidMessage_segment_identifier(UNSIGNED1 wh) := InValidMessageFT_invalid_segment_identifier(wh);
EXPORT Make_file_sequence_number(SALT33.StrType s0) := MakeFT_invalid_file_segment_num(s0);
EXPORT InValid_file_sequence_number(SALT33.StrType s) := InValidFT_invalid_file_segment_num(s);
EXPORT InValidMessage_file_sequence_number(UNSIGNED1 wh) := InValidMessageFT_invalid_file_segment_num(wh);
EXPORT Make_parent_sequence_number(SALT33.StrType s0) := MakeFT_invalid_parent_sequence_number(s0);
EXPORT InValid_parent_sequence_number(SALT33.StrType s) := InValidFT_invalid_parent_sequence_number(s);
EXPORT InValidMessage_parent_sequence_number(UNSIGNED1 wh) := InValidMessageFT_invalid_parent_sequence_number(wh);
EXPORT Make_account_holder_business_name(SALT33.StrType s0) := MakeFT_invalid_accholder_businessname(s0);
EXPORT InValid_account_holder_business_name(SALT33.StrType s) := InValidFT_invalid_accholder_businessname(s);
EXPORT InValidMessage_account_holder_business_name(UNSIGNED1 wh) := InValidMessageFT_invalid_accholder_businessname(wh);
EXPORT Make_dba(SALT33.StrType s0) := MakeFT_invalid_dba(s0);
EXPORT InValid_dba(SALT33.StrType s) := InValidFT_invalid_dba(s);
EXPORT InValidMessage_dba(UNSIGNED1 wh) := InValidMessageFT_invalid_dba(wh);
EXPORT Make_company_website(SALT33.StrType s0) := MakeFT_invalid_comp_website(s0);
EXPORT InValid_company_website(SALT33.StrType s) := InValidFT_invalid_comp_website(s);
EXPORT InValidMessage_company_website(UNSIGNED1 wh) := InValidMessageFT_invalid_comp_website(wh);
EXPORT Make_legal_business_structure(SALT33.StrType s0) := MakeFT_invalid_legal_busi_structure(s0);
EXPORT InValid_legal_business_structure(SALT33.StrType s) := InValidFT_invalid_legal_busi_structure(s);
EXPORT InValidMessage_legal_business_structure(UNSIGNED1 wh) := InValidMessageFT_invalid_legal_busi_structure(wh);
EXPORT Make_business_established_date(SALT33.StrType s0) := MakeFT_invalid_busi_established_date(s0);
EXPORT InValid_business_established_date(SALT33.StrType s) := InValidFT_invalid_busi_established_date(s);
EXPORT InValidMessage_business_established_date(UNSIGNED1 wh) := InValidMessageFT_invalid_busi_established_date(wh);
EXPORT Make_contract_account_number(SALT33.StrType s0) := MakeFT_invalid_contractacc_num(s0);
EXPORT InValid_contract_account_number(SALT33.StrType s) := InValidFT_invalid_contractacc_num(s);
EXPORT InValidMessage_contract_account_number(UNSIGNED1 wh) := InValidMessageFT_invalid_contractacc_num(wh);
EXPORT Make_account_type_reported(SALT33.StrType s0) := MakeFT_invalid_accounttypereported(s0);
EXPORT InValid_account_type_reported(SALT33.StrType s) := InValidFT_invalid_accounttypereported(s);
EXPORT InValidMessage_account_type_reported(UNSIGNED1 wh) := InValidMessageFT_invalid_accounttypereported(wh);
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
EXPORT Make_floating_rate(SALT33.StrType s0) := MakeFT_invalid_floatingrate(s0);
EXPORT InValid_floating_rate(SALT33.StrType s) := InValidFT_invalid_floatingrate(s);
EXPORT InValidMessage_floating_rate(UNSIGNED1 wh) := InValidMessageFT_invalid_floatingrate(wh);
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
EXPORT Make_maximum_number_of_past_due_aging_amounts_buckets_provided(SALT33.StrType s0) := MakeFT_invalid_maximum_num_bucket(s0);
EXPORT InValid_maximum_number_of_past_due_aging_amounts_buckets_provided(SALT33.StrType s) := InValidFT_invalid_maximum_num_bucket(s);
EXPORT InValidMessage_maximum_number_of_past_due_aging_amounts_buckets_provided(UNSIGNED1 wh) := InValidMessageFT_invalid_maximum_num_bucket(wh);
EXPORT Make_past_due_aging_bucket_type(SALT33.StrType s0) := MakeFT_invalid_past_due_aging_bucket_type(s0);
EXPORT InValid_past_due_aging_bucket_type(SALT33.StrType s) := InValidFT_invalid_past_due_aging_bucket_type(s);
EXPORT InValidMessage_past_due_aging_bucket_type(UNSIGNED1 wh) := InValidMessageFT_invalid_past_due_aging_bucket_type(wh);
EXPORT Make_past_due_aging_amount_bucket_1(SALT33.StrType s0) := MakeFT_invalid_past_due_aging_amount_bucket_1(s0);
EXPORT InValid_past_due_aging_amount_bucket_1(SALT33.StrType s) := InValidFT_invalid_past_due_aging_amount_bucket_1(s);
EXPORT InValidMessage_past_due_aging_amount_bucket_1(UNSIGNED1 wh) := InValidMessageFT_invalid_past_due_aging_amount_bucket_1(wh);
EXPORT Make_past_due_aging_amount_bucket_2(SALT33.StrType s0) := MakeFT_invalid_past_due_aging_amount_bucket_2(s0);
EXPORT InValid_past_due_aging_amount_bucket_2(SALT33.StrType s) := InValidFT_invalid_past_due_aging_amount_bucket_2(s);
EXPORT InValidMessage_past_due_aging_amount_bucket_2(UNSIGNED1 wh) := InValidMessageFT_invalid_past_due_aging_amount_bucket_2(wh);
EXPORT Make_past_due_aging_amount_bucket_3(SALT33.StrType s0) := MakeFT_invalid_past_due_aging_amount_bucket_3(s0);
EXPORT InValid_past_due_aging_amount_bucket_3(SALT33.StrType s) := InValidFT_invalid_past_due_aging_amount_bucket_3(s);
EXPORT InValidMessage_past_due_aging_amount_bucket_3(UNSIGNED1 wh) := InValidMessageFT_invalid_past_due_aging_amount_bucket_3(wh);
EXPORT Make_past_due_aging_amount_bucket_4(SALT33.StrType s0) := MakeFT_invalid_past_due_aging_amount_bucket_4(s0);
EXPORT InValid_past_due_aging_amount_bucket_4(SALT33.StrType s) := InValidFT_invalid_past_due_aging_amount_bucket_4(s);
EXPORT InValidMessage_past_due_aging_amount_bucket_4(UNSIGNED1 wh) := InValidMessageFT_invalid_past_due_aging_amount_bucket_4(wh);
EXPORT Make_past_due_aging_amount_bucket_5(SALT33.StrType s0) := MakeFT_invalid_past_due_aging_amount_bucket_5(s0);
EXPORT InValid_past_due_aging_amount_bucket_5(SALT33.StrType s) := InValidFT_invalid_past_due_aging_amount_bucket_5(s);
EXPORT InValidMessage_past_due_aging_amount_bucket_5(UNSIGNED1 wh) := InValidMessageFT_invalid_past_due_aging_amount_bucket_5(wh);
EXPORT Make_past_due_aging_amount_bucket_6(SALT33.StrType s0) := MakeFT_invalid_past_due_aging_amount_bucket_6(s0);
EXPORT InValid_past_due_aging_amount_bucket_6(SALT33.StrType s) := InValidFT_invalid_past_due_aging_amount_bucket_6(s);
EXPORT InValidMessage_past_due_aging_amount_bucket_6(UNSIGNED1 wh) := InValidMessageFT_invalid_past_due_aging_amount_bucket_6(wh);
EXPORT Make_past_due_aging_amount_bucket_7(SALT33.StrType s0) := MakeFT_invalid_past_due_aging_amount_bucket_7(s0);
EXPORT InValid_past_due_aging_amount_bucket_7(SALT33.StrType s) := InValidFT_invalid_past_due_aging_amount_bucket_7(s);
EXPORT InValidMessage_past_due_aging_amount_bucket_7(UNSIGNED1 wh) := InValidMessageFT_invalid_past_due_aging_amount_bucket_7(wh);
EXPORT Make_maximum_number_of_payment_tracking_cycle_periods_provided(SALT33.StrType s0) := MakeFT_invalid_maximum_num_tracking(s0);
EXPORT InValid_maximum_number_of_payment_tracking_cycle_periods_provided(SALT33.StrType s) := InValidFT_invalid_maximum_num_tracking(s);
EXPORT InValidMessage_maximum_number_of_payment_tracking_cycle_periods_provided(UNSIGNED1 wh) := InValidMessageFT_invalid_maximum_num_tracking(wh);
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
    BOOLEAN Diff_segment_identifier;
    BOOLEAN Diff_file_sequence_number;
    BOOLEAN Diff_parent_sequence_number;
    BOOLEAN Diff_account_holder_business_name;
    BOOLEAN Diff_dba;
    BOOLEAN Diff_company_website;
    BOOLEAN Diff_legal_business_structure;
    BOOLEAN Diff_business_established_date;
    BOOLEAN Diff_contract_account_number;
    BOOLEAN Diff_account_type_reported;
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
    UNSIGNED Num_Diffs;
    SALT33.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_segment_identifier := le.segment_identifier <> ri.segment_identifier;
    SELF.Diff_file_sequence_number := le.file_sequence_number <> ri.file_sequence_number;
    SELF.Diff_parent_sequence_number := le.parent_sequence_number <> ri.parent_sequence_number;
    SELF.Diff_account_holder_business_name := le.account_holder_business_name <> ri.account_holder_business_name;
    SELF.Diff_dba := le.dba <> ri.dba;
    SELF.Diff_company_website := le.company_website <> ri.company_website;
    SELF.Diff_legal_business_structure := le.legal_business_structure <> ri.legal_business_structure;
    SELF.Diff_business_established_date := le.business_established_date <> ri.business_established_date;
    SELF.Diff_contract_account_number := le.contract_account_number <> ri.contract_account_number;
    SELF.Diff_account_type_reported := le.account_type_reported <> ri.account_type_reported;
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
    SELF.Val := (SALT33.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_segment_identifier,1,0)+ IF( SELF.Diff_file_sequence_number,1,0)+ IF( SELF.Diff_parent_sequence_number,1,0)+ IF( SELF.Diff_account_holder_business_name,1,0)+ IF( SELF.Diff_dba,1,0)+ IF( SELF.Diff_company_website,1,0)+ IF( SELF.Diff_legal_business_structure,1,0)+ IF( SELF.Diff_business_established_date,1,0)+ IF( SELF.Diff_contract_account_number,1,0)+ IF( SELF.Diff_account_type_reported,1,0)+ IF( SELF.Diff_account_status_1,1,0)+ IF( SELF.Diff_account_status_2,1,0)+ IF( SELF.Diff_date_account_opened,1,0)+ IF( SELF.Diff_date_account_closed,1,0)+ IF( SELF.Diff_account_closure_basis,1,0)+ IF( SELF.Diff_account_expiration_date,1,0)+ IF( SELF.Diff_last_activity_date,1,0)+ IF( SELF.Diff_last_activity_type,1,0)+ IF( SELF.Diff_recent_activity_indicator,1,0)+ IF( SELF.Diff_original_credit_limit,1,0)+ IF( SELF.Diff_highest_credit_used,1,0)+ IF( SELF.Diff_current_credit_limit,1,0)+ IF( SELF.Diff_reporting_indicator_length,1,0)+ IF( SELF.Diff_payment_interval,1,0)+ IF( SELF.Diff_payment_status_category,1,0)+ IF( SELF.Diff_term_of_account_in_months,1,0)+ IF( SELF.Diff_first_payment_due_date,1,0)+ IF( SELF.Diff_final_payment_due_date,1,0)+ IF( SELF.Diff_original_rate,1,0)+ IF( SELF.Diff_floating_rate,1,0)+ IF( SELF.Diff_grace_period,1,0)+ IF( SELF.Diff_payment_category,1,0)+ IF( SELF.Diff_payment_history_profile_12_months,1,0)+ IF( SELF.Diff_payment_history_profile_13_24_months,1,0)+ IF( SELF.Diff_payment_history_profile_25_36_months,1,0)+ IF( SELF.Diff_payment_history_profile_37_48_months,1,0)+ IF( SELF.Diff_payment_history_length,1,0)+ IF( SELF.Diff_year_to_date_purchases_count,1,0)+ IF( SELF.Diff_lifetime_to_date_purchases_count,1,0)+ IF( SELF.Diff_year_to_date_purchases_sum_amount,1,0)+ IF( SELF.Diff_lifetime_to_date_purchases_sum_amount,1,0)+ IF( SELF.Diff_payment_amount_scheduled,1,0)+ IF( SELF.Diff_recent_payment_amount,1,0)+ IF( SELF.Diff_recent_payment_date,1,0)+ IF( SELF.Diff_remaining_balance,1,0)+ IF( SELF.Diff_carried_over_amount,1,0)+ IF( SELF.Diff_new_applied_charges,1,0)+ IF( SELF.Diff_balloon_payment_due,1,0)+ IF( SELF.Diff_balloon_payment_due_date,1,0)+ IF( SELF.Diff_delinquency_date,1,0)+ IF( SELF.Diff_days_delinquent,1,0)+ IF( SELF.Diff_past_due_amount,1,0)+ IF( SELF.Diff_maximum_number_of_past_due_aging_amounts_buckets_provided,1,0)+ IF( SELF.Diff_past_due_aging_bucket_type,1,0)+ IF( SELF.Diff_past_due_aging_amount_bucket_1,1,0)+ IF( SELF.Diff_past_due_aging_amount_bucket_2,1,0)+ IF( SELF.Diff_past_due_aging_amount_bucket_3,1,0)+ IF( SELF.Diff_past_due_aging_amount_bucket_4,1,0)+ IF( SELF.Diff_past_due_aging_amount_bucket_5,1,0)+ IF( SELF.Diff_past_due_aging_amount_bucket_6,1,0)+ IF( SELF.Diff_past_due_aging_amount_bucket_7,1,0)+ IF( SELF.Diff_maximum_number_of_payment_tracking_cycle_periods_provided,1,0)+ IF( SELF.Diff_payment_tracking_cycle_type,1,0)+ IF( SELF.Diff_payment_tracking_cycle_0_current,1,0)+ IF( SELF.Diff_payment_tracking_cycle_1_1_to_30_days,1,0)+ IF( SELF.Diff_payment_tracking_cycle_2_31_to_60_days,1,0)+ IF( SELF.Diff_payment_tracking_cycle_3_61_to_90_days,1,0)+ IF( SELF.Diff_payment_tracking_cycle_4_91_to_120_days,1,0)+ IF( SELF.Diff_payment_tracking_cycle_5_121_to_150days,1,0)+ IF( SELF.Diff_payment_tracking_number_of_times_cycle_6_151_to_180_days,1,0)+ IF( SELF.Diff_payment_tracking_number_of_times_cycle_7_181_or_greater_days,1,0)+ IF( SELF.Diff_date_account_was_charged_off,1,0)+ IF( SELF.Diff_amount_charged_off_by_creditor,1,0)+ IF( SELF.Diff_charge_off_type_indicator,1,0)+ IF( SELF.Diff_total_charge_off_recoveries_to_date,1,0)+ IF( SELF.Diff_government_guarantee_flag,1,0)+ IF( SELF.Diff_government_guarantee_category,1,0)+ IF( SELF.Diff_portion_of_account_guaranteed_by_government,1,0)+ IF( SELF.Diff_guarantors_indicator,1,0)+ IF( SELF.Diff_number_of_guarantors,1,0)+ IF( SELF.Diff_owners_indicator,1,0)+ IF( SELF.Diff_number_of_principals,1,0)+ IF( SELF.Diff_account_update_deletion_indicator,1,0);
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
    Count_Diff_segment_identifier := COUNT(GROUP,%Closest%.Diff_segment_identifier);
    Count_Diff_file_sequence_number := COUNT(GROUP,%Closest%.Diff_file_sequence_number);
    Count_Diff_parent_sequence_number := COUNT(GROUP,%Closest%.Diff_parent_sequence_number);
    Count_Diff_account_holder_business_name := COUNT(GROUP,%Closest%.Diff_account_holder_business_name);
    Count_Diff_dba := COUNT(GROUP,%Closest%.Diff_dba);
    Count_Diff_company_website := COUNT(GROUP,%Closest%.Diff_company_website);
    Count_Diff_legal_business_structure := COUNT(GROUP,%Closest%.Diff_legal_business_structure);
    Count_Diff_business_established_date := COUNT(GROUP,%Closest%.Diff_business_established_date);
    Count_Diff_contract_account_number := COUNT(GROUP,%Closest%.Diff_contract_account_number);
    Count_Diff_account_type_reported := COUNT(GROUP,%Closest%.Diff_account_type_reported);
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
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
