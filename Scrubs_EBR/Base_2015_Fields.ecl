IMPORT SALT311;
IMPORT Scrubs_EBR; // Import modules for FieldTypes attribute definitions
EXPORT Base_2015_Fields := MODULE
 
EXPORT NumFields := 55;
 
// Processing for each FieldType
EXPORT SALT311.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_mandatory','invalid_numeric','invalid_numeric_or_allzeros','invalid_pastdate','invalid_dt_first_seen','invalid_account_balance','invalid_record_type','invalid_segment','invalid_mask','invalid_file_number');
EXPORT FieldTypeNum(SALT311.StrType fn) := CASE(fn,'invalid_mandatory' => 1,'invalid_numeric' => 2,'invalid_numeric_or_allzeros' => 3,'invalid_pastdate' => 4,'invalid_dt_first_seen' => 5,'invalid_account_balance' => 6,'invalid_record_type' => 7,'invalid_segment' => 8,'invalid_mask' => 9,'invalid_file_number' => 10,0);
 
EXPORT MakeFT_invalid_mandatory(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_mandatory(SALT311.StrType s) := WHICH(~(LENGTH(TRIM(s)) >= 1));
EXPORT InValidMessageFT_invalid_mandatory(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLength('1..'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_numeric(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_numeric(SALT311.StrType s) := WHICH(~Scrubs_EBR.Functions.fn_numeric(s)>0);
EXPORT InValidMessageFT_invalid_numeric(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_EBR.Functions.fn_numeric'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_numeric_or_allzeros(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_numeric_or_allzeros(SALT311.StrType s) := WHICH(~Scrubs_EBR.Functions.fn_numeric_or_allzeros(s)>0);
EXPORT InValidMessageFT_invalid_numeric_or_allzeros(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_EBR.Functions.fn_numeric_or_allzeros'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_pastdate(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_pastdate(SALT311.StrType s) := WHICH(~Scrubs_EBR.Functions.fn_past_yyyymmdd(s)>0);
EXPORT InValidMessageFT_invalid_pastdate(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_EBR.Functions.fn_past_yyyymmdd'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_dt_first_seen(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_dt_first_seen(SALT311.StrType s) := WHICH(~Scrubs_EBR.Functions.fn_dt_first_seen(s)>0);
EXPORT InValidMessageFT_invalid_dt_first_seen(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_EBR.Functions.fn_dt_first_seen'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_account_balance(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_account_balance(SALT311.StrType s) := WHICH(~Scrubs_EBR.Functions.fn_account_balance(s)>0);
EXPORT InValidMessageFT_invalid_account_balance(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_EBR.Functions.fn_account_balance'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_record_type(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_record_type(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['H','C']);
EXPORT InValidMessageFT_invalid_record_type(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('H|C'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_segment(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_segment(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['2015','2015']);
EXPORT InValidMessageFT_invalid_segment(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('2015|2015'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_mask(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_mask(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN [' ','-','<','+']);
EXPORT InValidMessageFT_invalid_mask(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum(' |-|<|+'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_file_number(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_file_number(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'))),~(LENGTH(TRIM(s)) = 9));
EXPORT InValidMessageFT_invalid_file_number(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'),SALT311.HygieneErrors.NotLength('9'),SALT311.HygieneErrors.Good);
 
EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'powid','proxid','seleid','orgid','ultid','bdid','date_first_seen','date_last_seen','process_date_first_seen','process_date_last_seen','record_type','process_date','file_number','segment_code','trade_count1','debt1','high_credit_mask1','recent_high_credit1','account_balance_mask1','masked_account_balance1','current_balance_percent1','debt_01_30_percent1','debt_31_60_percent1','debt_61_90_percent1','debt_91_plus_percent1','trade_count2','debt2','high_credit_mask2','recent_high_credit2','account_balance_mask2','masked_account_balance2','current_balance_percent2','debt_01_30_percent2','debt_31_60_percent2','debt_61_90_percent2','debt_91_plus_percent2','trade_count3','debt3','high_credit_mask3','recent_high_credit3','account_balance_mask3','masked_account_balance3','current_balance_percent3','debt_01_30_percent3','debt_31_60_percent3','debt_61_90_percent3','debt_91_plus_percent3','highest_credit_median','orig_account_balance_regular_tradelines','orig_account_balance_new','orig_account_balance_combined','aged_trades_count','account_balance_regular_tradelines','account_balance_new','account_balance_combined');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'powid','proxid','seleid','orgid','ultid','bdid','date_first_seen','date_last_seen','process_date_first_seen','process_date_last_seen','record_type','process_date','file_number','segment_code','trade_count1','debt1','high_credit_mask1','recent_high_credit1','account_balance_mask1','masked_account_balance1','current_balance_percent1','debt_01_30_percent1','debt_31_60_percent1','debt_61_90_percent1','debt_91_plus_percent1','trade_count2','debt2','high_credit_mask2','recent_high_credit2','account_balance_mask2','masked_account_balance2','current_balance_percent2','debt_01_30_percent2','debt_31_60_percent2','debt_61_90_percent2','debt_91_plus_percent2','trade_count3','debt3','high_credit_mask3','recent_high_credit3','account_balance_mask3','masked_account_balance3','current_balance_percent3','debt_01_30_percent3','debt_31_60_percent3','debt_61_90_percent3','debt_91_plus_percent3','highest_credit_median','orig_account_balance_regular_tradelines','orig_account_balance_new','orig_account_balance_combined','aged_trades_count','account_balance_regular_tradelines','account_balance_new','account_balance_combined');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'powid' => 0,'proxid' => 1,'seleid' => 2,'orgid' => 3,'ultid' => 4,'bdid' => 5,'date_first_seen' => 6,'date_last_seen' => 7,'process_date_first_seen' => 8,'process_date_last_seen' => 9,'record_type' => 10,'process_date' => 11,'file_number' => 12,'segment_code' => 13,'trade_count1' => 14,'debt1' => 15,'high_credit_mask1' => 16,'recent_high_credit1' => 17,'account_balance_mask1' => 18,'masked_account_balance1' => 19,'current_balance_percent1' => 20,'debt_01_30_percent1' => 21,'debt_31_60_percent1' => 22,'debt_61_90_percent1' => 23,'debt_91_plus_percent1' => 24,'trade_count2' => 25,'debt2' => 26,'high_credit_mask2' => 27,'recent_high_credit2' => 28,'account_balance_mask2' => 29,'masked_account_balance2' => 30,'current_balance_percent2' => 31,'debt_01_30_percent2' => 32,'debt_31_60_percent2' => 33,'debt_61_90_percent2' => 34,'debt_91_plus_percent2' => 35,'trade_count3' => 36,'debt3' => 37,'high_credit_mask3' => 38,'recent_high_credit3' => 39,'account_balance_mask3' => 40,'masked_account_balance3' => 41,'current_balance_percent3' => 42,'debt_01_30_percent3' => 43,'debt_31_60_percent3' => 44,'debt_61_90_percent3' => 45,'debt_91_plus_percent3' => 46,'highest_credit_median' => 47,'orig_account_balance_regular_tradelines' => 48,'orig_account_balance_new' => 49,'orig_account_balance_combined' => 50,'aged_trades_count' => 51,'account_balance_regular_tradelines' => 52,'account_balance_new' => 53,'account_balance_combined' => 54,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['LENGTHS'],['LENGTHS'],['LENGTHS'],['LENGTHS'],['LENGTHS'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['ENUM'],['CUSTOM'],['ALLOW','LENGTHS'],['ENUM'],['CUSTOM'],['CUSTOM'],['ENUM'],['CUSTOM'],['ENUM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['ENUM'],['CUSTOM'],['ENUM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['ENUM'],['CUSTOM'],['ENUM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_powid(SALT311.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_powid(SALT311.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_powid(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_proxid(SALT311.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_proxid(SALT311.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_proxid(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_seleid(SALT311.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_seleid(SALT311.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_seleid(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_orgid(SALT311.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_orgid(SALT311.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_orgid(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_ultid(SALT311.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_ultid(SALT311.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_ultid(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_bdid(SALT311.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_bdid(SALT311.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_bdid(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_date_first_seen(SALT311.StrType s0) := MakeFT_invalid_dt_first_seen(s0);
EXPORT InValid_date_first_seen(SALT311.StrType s) := InValidFT_invalid_dt_first_seen(s);
EXPORT InValidMessage_date_first_seen(UNSIGNED1 wh) := InValidMessageFT_invalid_dt_first_seen(wh);
 
EXPORT Make_date_last_seen(SALT311.StrType s0) := MakeFT_invalid_pastdate(s0);
EXPORT InValid_date_last_seen(SALT311.StrType s) := InValidFT_invalid_pastdate(s);
EXPORT InValidMessage_date_last_seen(UNSIGNED1 wh) := InValidMessageFT_invalid_pastdate(wh);
 
EXPORT Make_process_date_first_seen(SALT311.StrType s0) := MakeFT_invalid_pastdate(s0);
EXPORT InValid_process_date_first_seen(SALT311.StrType s) := InValidFT_invalid_pastdate(s);
EXPORT InValidMessage_process_date_first_seen(UNSIGNED1 wh) := InValidMessageFT_invalid_pastdate(wh);
 
EXPORT Make_process_date_last_seen(SALT311.StrType s0) := MakeFT_invalid_pastdate(s0);
EXPORT InValid_process_date_last_seen(SALT311.StrType s) := InValidFT_invalid_pastdate(s);
EXPORT InValidMessage_process_date_last_seen(UNSIGNED1 wh) := InValidMessageFT_invalid_pastdate(wh);
 
EXPORT Make_record_type(SALT311.StrType s0) := MakeFT_invalid_record_type(s0);
EXPORT InValid_record_type(SALT311.StrType s) := InValidFT_invalid_record_type(s);
EXPORT InValidMessage_record_type(UNSIGNED1 wh) := InValidMessageFT_invalid_record_type(wh);
 
EXPORT Make_process_date(SALT311.StrType s0) := MakeFT_invalid_pastdate(s0);
EXPORT InValid_process_date(SALT311.StrType s) := InValidFT_invalid_pastdate(s);
EXPORT InValidMessage_process_date(UNSIGNED1 wh) := InValidMessageFT_invalid_pastdate(wh);
 
EXPORT Make_file_number(SALT311.StrType s0) := MakeFT_invalid_file_number(s0);
EXPORT InValid_file_number(SALT311.StrType s) := InValidFT_invalid_file_number(s);
EXPORT InValidMessage_file_number(UNSIGNED1 wh) := InValidMessageFT_invalid_file_number(wh);
 
EXPORT Make_segment_code(SALT311.StrType s0) := MakeFT_invalid_segment(s0);
EXPORT InValid_segment_code(SALT311.StrType s) := InValidFT_invalid_segment(s);
EXPORT InValidMessage_segment_code(UNSIGNED1 wh) := InValidMessageFT_invalid_segment(wh);
 
EXPORT Make_trade_count1(SALT311.StrType s0) := MakeFT_invalid_numeric_or_allzeros(s0);
EXPORT InValid_trade_count1(SALT311.StrType s) := InValidFT_invalid_numeric_or_allzeros(s);
EXPORT InValidMessage_trade_count1(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric_or_allzeros(wh);
 
EXPORT Make_debt1(SALT311.StrType s0) := MakeFT_invalid_numeric_or_allzeros(s0);
EXPORT InValid_debt1(SALT311.StrType s) := InValidFT_invalid_numeric_or_allzeros(s);
EXPORT InValidMessage_debt1(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric_or_allzeros(wh);
 
EXPORT Make_high_credit_mask1(SALT311.StrType s0) := MakeFT_invalid_mask(s0);
EXPORT InValid_high_credit_mask1(SALT311.StrType s) := InValidFT_invalid_mask(s);
EXPORT InValidMessage_high_credit_mask1(UNSIGNED1 wh) := InValidMessageFT_invalid_mask(wh);
 
EXPORT Make_recent_high_credit1(SALT311.StrType s0) := MakeFT_invalid_numeric_or_allzeros(s0);
EXPORT InValid_recent_high_credit1(SALT311.StrType s) := InValidFT_invalid_numeric_or_allzeros(s);
EXPORT InValidMessage_recent_high_credit1(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric_or_allzeros(wh);
 
EXPORT Make_account_balance_mask1(SALT311.StrType s0) := MakeFT_invalid_mask(s0);
EXPORT InValid_account_balance_mask1(SALT311.StrType s) := InValidFT_invalid_mask(s);
EXPORT InValidMessage_account_balance_mask1(UNSIGNED1 wh) := InValidMessageFT_invalid_mask(wh);
 
EXPORT Make_masked_account_balance1(SALT311.StrType s0) := MakeFT_invalid_numeric_or_allzeros(s0);
EXPORT InValid_masked_account_balance1(SALT311.StrType s) := InValidFT_invalid_numeric_or_allzeros(s);
EXPORT InValidMessage_masked_account_balance1(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric_or_allzeros(wh);
 
EXPORT Make_current_balance_percent1(SALT311.StrType s0) := MakeFT_invalid_numeric_or_allzeros(s0);
EXPORT InValid_current_balance_percent1(SALT311.StrType s) := InValidFT_invalid_numeric_or_allzeros(s);
EXPORT InValidMessage_current_balance_percent1(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric_or_allzeros(wh);
 
EXPORT Make_debt_01_30_percent1(SALT311.StrType s0) := MakeFT_invalid_numeric_or_allzeros(s0);
EXPORT InValid_debt_01_30_percent1(SALT311.StrType s) := InValidFT_invalid_numeric_or_allzeros(s);
EXPORT InValidMessage_debt_01_30_percent1(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric_or_allzeros(wh);
 
EXPORT Make_debt_31_60_percent1(SALT311.StrType s0) := MakeFT_invalid_numeric_or_allzeros(s0);
EXPORT InValid_debt_31_60_percent1(SALT311.StrType s) := InValidFT_invalid_numeric_or_allzeros(s);
EXPORT InValidMessage_debt_31_60_percent1(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric_or_allzeros(wh);
 
EXPORT Make_debt_61_90_percent1(SALT311.StrType s0) := MakeFT_invalid_numeric_or_allzeros(s0);
EXPORT InValid_debt_61_90_percent1(SALT311.StrType s) := InValidFT_invalid_numeric_or_allzeros(s);
EXPORT InValidMessage_debt_61_90_percent1(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric_or_allzeros(wh);
 
EXPORT Make_debt_91_plus_percent1(SALT311.StrType s0) := MakeFT_invalid_numeric_or_allzeros(s0);
EXPORT InValid_debt_91_plus_percent1(SALT311.StrType s) := InValidFT_invalid_numeric_or_allzeros(s);
EXPORT InValidMessage_debt_91_plus_percent1(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric_or_allzeros(wh);
 
EXPORT Make_trade_count2(SALT311.StrType s0) := MakeFT_invalid_numeric_or_allzeros(s0);
EXPORT InValid_trade_count2(SALT311.StrType s) := InValidFT_invalid_numeric_or_allzeros(s);
EXPORT InValidMessage_trade_count2(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric_or_allzeros(wh);
 
EXPORT Make_debt2(SALT311.StrType s0) := MakeFT_invalid_numeric_or_allzeros(s0);
EXPORT InValid_debt2(SALT311.StrType s) := InValidFT_invalid_numeric_or_allzeros(s);
EXPORT InValidMessage_debt2(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric_or_allzeros(wh);
 
EXPORT Make_high_credit_mask2(SALT311.StrType s0) := MakeFT_invalid_mask(s0);
EXPORT InValid_high_credit_mask2(SALT311.StrType s) := InValidFT_invalid_mask(s);
EXPORT InValidMessage_high_credit_mask2(UNSIGNED1 wh) := InValidMessageFT_invalid_mask(wh);
 
EXPORT Make_recent_high_credit2(SALT311.StrType s0) := MakeFT_invalid_numeric_or_allzeros(s0);
EXPORT InValid_recent_high_credit2(SALT311.StrType s) := InValidFT_invalid_numeric_or_allzeros(s);
EXPORT InValidMessage_recent_high_credit2(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric_or_allzeros(wh);
 
EXPORT Make_account_balance_mask2(SALT311.StrType s0) := MakeFT_invalid_mask(s0);
EXPORT InValid_account_balance_mask2(SALT311.StrType s) := InValidFT_invalid_mask(s);
EXPORT InValidMessage_account_balance_mask2(UNSIGNED1 wh) := InValidMessageFT_invalid_mask(wh);
 
EXPORT Make_masked_account_balance2(SALT311.StrType s0) := MakeFT_invalid_numeric_or_allzeros(s0);
EXPORT InValid_masked_account_balance2(SALT311.StrType s) := InValidFT_invalid_numeric_or_allzeros(s);
EXPORT InValidMessage_masked_account_balance2(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric_or_allzeros(wh);
 
EXPORT Make_current_balance_percent2(SALT311.StrType s0) := MakeFT_invalid_numeric_or_allzeros(s0);
EXPORT InValid_current_balance_percent2(SALT311.StrType s) := InValidFT_invalid_numeric_or_allzeros(s);
EXPORT InValidMessage_current_balance_percent2(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric_or_allzeros(wh);
 
EXPORT Make_debt_01_30_percent2(SALT311.StrType s0) := MakeFT_invalid_numeric_or_allzeros(s0);
EXPORT InValid_debt_01_30_percent2(SALT311.StrType s) := InValidFT_invalid_numeric_or_allzeros(s);
EXPORT InValidMessage_debt_01_30_percent2(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric_or_allzeros(wh);
 
EXPORT Make_debt_31_60_percent2(SALT311.StrType s0) := MakeFT_invalid_numeric_or_allzeros(s0);
EXPORT InValid_debt_31_60_percent2(SALT311.StrType s) := InValidFT_invalid_numeric_or_allzeros(s);
EXPORT InValidMessage_debt_31_60_percent2(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric_or_allzeros(wh);
 
EXPORT Make_debt_61_90_percent2(SALT311.StrType s0) := MakeFT_invalid_numeric_or_allzeros(s0);
EXPORT InValid_debt_61_90_percent2(SALT311.StrType s) := InValidFT_invalid_numeric_or_allzeros(s);
EXPORT InValidMessage_debt_61_90_percent2(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric_or_allzeros(wh);
 
EXPORT Make_debt_91_plus_percent2(SALT311.StrType s0) := MakeFT_invalid_numeric_or_allzeros(s0);
EXPORT InValid_debt_91_plus_percent2(SALT311.StrType s) := InValidFT_invalid_numeric_or_allzeros(s);
EXPORT InValidMessage_debt_91_plus_percent2(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric_or_allzeros(wh);
 
EXPORT Make_trade_count3(SALT311.StrType s0) := MakeFT_invalid_numeric_or_allzeros(s0);
EXPORT InValid_trade_count3(SALT311.StrType s) := InValidFT_invalid_numeric_or_allzeros(s);
EXPORT InValidMessage_trade_count3(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric_or_allzeros(wh);
 
EXPORT Make_debt3(SALT311.StrType s0) := MakeFT_invalid_numeric_or_allzeros(s0);
EXPORT InValid_debt3(SALT311.StrType s) := InValidFT_invalid_numeric_or_allzeros(s);
EXPORT InValidMessage_debt3(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric_or_allzeros(wh);
 
EXPORT Make_high_credit_mask3(SALT311.StrType s0) := MakeFT_invalid_mask(s0);
EXPORT InValid_high_credit_mask3(SALT311.StrType s) := InValidFT_invalid_mask(s);
EXPORT InValidMessage_high_credit_mask3(UNSIGNED1 wh) := InValidMessageFT_invalid_mask(wh);
 
EXPORT Make_recent_high_credit3(SALT311.StrType s0) := MakeFT_invalid_numeric_or_allzeros(s0);
EXPORT InValid_recent_high_credit3(SALT311.StrType s) := InValidFT_invalid_numeric_or_allzeros(s);
EXPORT InValidMessage_recent_high_credit3(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric_or_allzeros(wh);
 
EXPORT Make_account_balance_mask3(SALT311.StrType s0) := MakeFT_invalid_mask(s0);
EXPORT InValid_account_balance_mask3(SALT311.StrType s) := InValidFT_invalid_mask(s);
EXPORT InValidMessage_account_balance_mask3(UNSIGNED1 wh) := InValidMessageFT_invalid_mask(wh);
 
EXPORT Make_masked_account_balance3(SALT311.StrType s0) := MakeFT_invalid_numeric_or_allzeros(s0);
EXPORT InValid_masked_account_balance3(SALT311.StrType s) := InValidFT_invalid_numeric_or_allzeros(s);
EXPORT InValidMessage_masked_account_balance3(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric_or_allzeros(wh);
 
EXPORT Make_current_balance_percent3(SALT311.StrType s0) := MakeFT_invalid_numeric_or_allzeros(s0);
EXPORT InValid_current_balance_percent3(SALT311.StrType s) := InValidFT_invalid_numeric_or_allzeros(s);
EXPORT InValidMessage_current_balance_percent3(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric_or_allzeros(wh);
 
EXPORT Make_debt_01_30_percent3(SALT311.StrType s0) := MakeFT_invalid_numeric_or_allzeros(s0);
EXPORT InValid_debt_01_30_percent3(SALT311.StrType s) := InValidFT_invalid_numeric_or_allzeros(s);
EXPORT InValidMessage_debt_01_30_percent3(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric_or_allzeros(wh);
 
EXPORT Make_debt_31_60_percent3(SALT311.StrType s0) := MakeFT_invalid_numeric_or_allzeros(s0);
EXPORT InValid_debt_31_60_percent3(SALT311.StrType s) := InValidFT_invalid_numeric_or_allzeros(s);
EXPORT InValidMessage_debt_31_60_percent3(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric_or_allzeros(wh);
 
EXPORT Make_debt_61_90_percent3(SALT311.StrType s0) := MakeFT_invalid_numeric_or_allzeros(s0);
EXPORT InValid_debt_61_90_percent3(SALT311.StrType s) := InValidFT_invalid_numeric_or_allzeros(s);
EXPORT InValidMessage_debt_61_90_percent3(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric_or_allzeros(wh);
 
EXPORT Make_debt_91_plus_percent3(SALT311.StrType s0) := MakeFT_invalid_numeric_or_allzeros(s0);
EXPORT InValid_debt_91_plus_percent3(SALT311.StrType s) := InValidFT_invalid_numeric_or_allzeros(s);
EXPORT InValidMessage_debt_91_plus_percent3(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric_or_allzeros(wh);
 
EXPORT Make_highest_credit_median(SALT311.StrType s0) := MakeFT_invalid_numeric_or_allzeros(s0);
EXPORT InValid_highest_credit_median(SALT311.StrType s) := InValidFT_invalid_numeric_or_allzeros(s);
EXPORT InValidMessage_highest_credit_median(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric_or_allzeros(wh);
 
EXPORT Make_orig_account_balance_regular_tradelines(SALT311.StrType s0) := MakeFT_invalid_account_balance(s0);
EXPORT InValid_orig_account_balance_regular_tradelines(SALT311.StrType s) := InValidFT_invalid_account_balance(s);
EXPORT InValidMessage_orig_account_balance_regular_tradelines(UNSIGNED1 wh) := InValidMessageFT_invalid_account_balance(wh);
 
EXPORT Make_orig_account_balance_new(SALT311.StrType s0) := MakeFT_invalid_account_balance(s0);
EXPORT InValid_orig_account_balance_new(SALT311.StrType s) := InValidFT_invalid_account_balance(s);
EXPORT InValidMessage_orig_account_balance_new(UNSIGNED1 wh) := InValidMessageFT_invalid_account_balance(wh);
 
EXPORT Make_orig_account_balance_combined(SALT311.StrType s0) := MakeFT_invalid_account_balance(s0);
EXPORT InValid_orig_account_balance_combined(SALT311.StrType s) := InValidFT_invalid_account_balance(s);
EXPORT InValidMessage_orig_account_balance_combined(UNSIGNED1 wh) := InValidMessageFT_invalid_account_balance(wh);
 
EXPORT Make_aged_trades_count(SALT311.StrType s0) := MakeFT_invalid_numeric_or_allzeros(s0);
EXPORT InValid_aged_trades_count(SALT311.StrType s) := InValidFT_invalid_numeric_or_allzeros(s);
EXPORT InValidMessage_aged_trades_count(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric_or_allzeros(wh);
 
EXPORT Make_account_balance_regular_tradelines(SALT311.StrType s0) := MakeFT_invalid_numeric_or_allzeros(s0);
EXPORT InValid_account_balance_regular_tradelines(SALT311.StrType s) := InValidFT_invalid_numeric_or_allzeros(s);
EXPORT InValidMessage_account_balance_regular_tradelines(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric_or_allzeros(wh);
 
EXPORT Make_account_balance_new(SALT311.StrType s0) := MakeFT_invalid_numeric_or_allzeros(s0);
EXPORT InValid_account_balance_new(SALT311.StrType s) := InValidFT_invalid_numeric_or_allzeros(s);
EXPORT InValidMessage_account_balance_new(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric_or_allzeros(wh);
 
EXPORT Make_account_balance_combined(SALT311.StrType s0) := MakeFT_invalid_numeric_or_allzeros(s0);
EXPORT InValid_account_balance_combined(SALT311.StrType s) := InValidFT_invalid_numeric_or_allzeros(s);
EXPORT InValidMessage_account_balance_combined(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric_or_allzeros(wh);
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT311,Scrubs_EBR;
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
    BOOLEAN Diff_powid;
    BOOLEAN Diff_proxid;
    BOOLEAN Diff_seleid;
    BOOLEAN Diff_orgid;
    BOOLEAN Diff_ultid;
    BOOLEAN Diff_bdid;
    BOOLEAN Diff_date_first_seen;
    BOOLEAN Diff_date_last_seen;
    BOOLEAN Diff_process_date_first_seen;
    BOOLEAN Diff_process_date_last_seen;
    BOOLEAN Diff_record_type;
    BOOLEAN Diff_process_date;
    BOOLEAN Diff_file_number;
    BOOLEAN Diff_segment_code;
    BOOLEAN Diff_trade_count1;
    BOOLEAN Diff_debt1;
    BOOLEAN Diff_high_credit_mask1;
    BOOLEAN Diff_recent_high_credit1;
    BOOLEAN Diff_account_balance_mask1;
    BOOLEAN Diff_masked_account_balance1;
    BOOLEAN Diff_current_balance_percent1;
    BOOLEAN Diff_debt_01_30_percent1;
    BOOLEAN Diff_debt_31_60_percent1;
    BOOLEAN Diff_debt_61_90_percent1;
    BOOLEAN Diff_debt_91_plus_percent1;
    BOOLEAN Diff_trade_count2;
    BOOLEAN Diff_debt2;
    BOOLEAN Diff_high_credit_mask2;
    BOOLEAN Diff_recent_high_credit2;
    BOOLEAN Diff_account_balance_mask2;
    BOOLEAN Diff_masked_account_balance2;
    BOOLEAN Diff_current_balance_percent2;
    BOOLEAN Diff_debt_01_30_percent2;
    BOOLEAN Diff_debt_31_60_percent2;
    BOOLEAN Diff_debt_61_90_percent2;
    BOOLEAN Diff_debt_91_plus_percent2;
    BOOLEAN Diff_trade_count3;
    BOOLEAN Diff_debt3;
    BOOLEAN Diff_high_credit_mask3;
    BOOLEAN Diff_recent_high_credit3;
    BOOLEAN Diff_account_balance_mask3;
    BOOLEAN Diff_masked_account_balance3;
    BOOLEAN Diff_current_balance_percent3;
    BOOLEAN Diff_debt_01_30_percent3;
    BOOLEAN Diff_debt_31_60_percent3;
    BOOLEAN Diff_debt_61_90_percent3;
    BOOLEAN Diff_debt_91_plus_percent3;
    BOOLEAN Diff_highest_credit_median;
    BOOLEAN Diff_orig_account_balance_regular_tradelines;
    BOOLEAN Diff_orig_account_balance_new;
    BOOLEAN Diff_orig_account_balance_combined;
    BOOLEAN Diff_aged_trades_count;
    BOOLEAN Diff_account_balance_regular_tradelines;
    BOOLEAN Diff_account_balance_new;
    BOOLEAN Diff_account_balance_combined;
    UNSIGNED Num_Diffs;
    SALT311.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_powid := le.powid <> ri.powid;
    SELF.Diff_proxid := le.proxid <> ri.proxid;
    SELF.Diff_seleid := le.seleid <> ri.seleid;
    SELF.Diff_orgid := le.orgid <> ri.orgid;
    SELF.Diff_ultid := le.ultid <> ri.ultid;
    SELF.Diff_bdid := le.bdid <> ri.bdid;
    SELF.Diff_date_first_seen := le.date_first_seen <> ri.date_first_seen;
    SELF.Diff_date_last_seen := le.date_last_seen <> ri.date_last_seen;
    SELF.Diff_process_date_first_seen := le.process_date_first_seen <> ri.process_date_first_seen;
    SELF.Diff_process_date_last_seen := le.process_date_last_seen <> ri.process_date_last_seen;
    SELF.Diff_record_type := le.record_type <> ri.record_type;
    SELF.Diff_process_date := le.process_date <> ri.process_date;
    SELF.Diff_file_number := le.file_number <> ri.file_number;
    SELF.Diff_segment_code := le.segment_code <> ri.segment_code;
    SELF.Diff_trade_count1 := le.trade_count1 <> ri.trade_count1;
    SELF.Diff_debt1 := le.debt1 <> ri.debt1;
    SELF.Diff_high_credit_mask1 := le.high_credit_mask1 <> ri.high_credit_mask1;
    SELF.Diff_recent_high_credit1 := le.recent_high_credit1 <> ri.recent_high_credit1;
    SELF.Diff_account_balance_mask1 := le.account_balance_mask1 <> ri.account_balance_mask1;
    SELF.Diff_masked_account_balance1 := le.masked_account_balance1 <> ri.masked_account_balance1;
    SELF.Diff_current_balance_percent1 := le.current_balance_percent1 <> ri.current_balance_percent1;
    SELF.Diff_debt_01_30_percent1 := le.debt_01_30_percent1 <> ri.debt_01_30_percent1;
    SELF.Diff_debt_31_60_percent1 := le.debt_31_60_percent1 <> ri.debt_31_60_percent1;
    SELF.Diff_debt_61_90_percent1 := le.debt_61_90_percent1 <> ri.debt_61_90_percent1;
    SELF.Diff_debt_91_plus_percent1 := le.debt_91_plus_percent1 <> ri.debt_91_plus_percent1;
    SELF.Diff_trade_count2 := le.trade_count2 <> ri.trade_count2;
    SELF.Diff_debt2 := le.debt2 <> ri.debt2;
    SELF.Diff_high_credit_mask2 := le.high_credit_mask2 <> ri.high_credit_mask2;
    SELF.Diff_recent_high_credit2 := le.recent_high_credit2 <> ri.recent_high_credit2;
    SELF.Diff_account_balance_mask2 := le.account_balance_mask2 <> ri.account_balance_mask2;
    SELF.Diff_masked_account_balance2 := le.masked_account_balance2 <> ri.masked_account_balance2;
    SELF.Diff_current_balance_percent2 := le.current_balance_percent2 <> ri.current_balance_percent2;
    SELF.Diff_debt_01_30_percent2 := le.debt_01_30_percent2 <> ri.debt_01_30_percent2;
    SELF.Diff_debt_31_60_percent2 := le.debt_31_60_percent2 <> ri.debt_31_60_percent2;
    SELF.Diff_debt_61_90_percent2 := le.debt_61_90_percent2 <> ri.debt_61_90_percent2;
    SELF.Diff_debt_91_plus_percent2 := le.debt_91_plus_percent2 <> ri.debt_91_plus_percent2;
    SELF.Diff_trade_count3 := le.trade_count3 <> ri.trade_count3;
    SELF.Diff_debt3 := le.debt3 <> ri.debt3;
    SELF.Diff_high_credit_mask3 := le.high_credit_mask3 <> ri.high_credit_mask3;
    SELF.Diff_recent_high_credit3 := le.recent_high_credit3 <> ri.recent_high_credit3;
    SELF.Diff_account_balance_mask3 := le.account_balance_mask3 <> ri.account_balance_mask3;
    SELF.Diff_masked_account_balance3 := le.masked_account_balance3 <> ri.masked_account_balance3;
    SELF.Diff_current_balance_percent3 := le.current_balance_percent3 <> ri.current_balance_percent3;
    SELF.Diff_debt_01_30_percent3 := le.debt_01_30_percent3 <> ri.debt_01_30_percent3;
    SELF.Diff_debt_31_60_percent3 := le.debt_31_60_percent3 <> ri.debt_31_60_percent3;
    SELF.Diff_debt_61_90_percent3 := le.debt_61_90_percent3 <> ri.debt_61_90_percent3;
    SELF.Diff_debt_91_plus_percent3 := le.debt_91_plus_percent3 <> ri.debt_91_plus_percent3;
    SELF.Diff_highest_credit_median := le.highest_credit_median <> ri.highest_credit_median;
    SELF.Diff_orig_account_balance_regular_tradelines := le.orig_account_balance_regular_tradelines <> ri.orig_account_balance_regular_tradelines;
    SELF.Diff_orig_account_balance_new := le.orig_account_balance_new <> ri.orig_account_balance_new;
    SELF.Diff_orig_account_balance_combined := le.orig_account_balance_combined <> ri.orig_account_balance_combined;
    SELF.Diff_aged_trades_count := le.aged_trades_count <> ri.aged_trades_count;
    SELF.Diff_account_balance_regular_tradelines := le.account_balance_regular_tradelines <> ri.account_balance_regular_tradelines;
    SELF.Diff_account_balance_new := le.account_balance_new <> ri.account_balance_new;
    SELF.Diff_account_balance_combined := le.account_balance_combined <> ri.account_balance_combined;
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_powid,1,0)+ IF( SELF.Diff_proxid,1,0)+ IF( SELF.Diff_seleid,1,0)+ IF( SELF.Diff_orgid,1,0)+ IF( SELF.Diff_ultid,1,0)+ IF( SELF.Diff_bdid,1,0)+ IF( SELF.Diff_date_first_seen,1,0)+ IF( SELF.Diff_date_last_seen,1,0)+ IF( SELF.Diff_process_date_first_seen,1,0)+ IF( SELF.Diff_process_date_last_seen,1,0)+ IF( SELF.Diff_record_type,1,0)+ IF( SELF.Diff_process_date,1,0)+ IF( SELF.Diff_file_number,1,0)+ IF( SELF.Diff_segment_code,1,0)+ IF( SELF.Diff_trade_count1,1,0)+ IF( SELF.Diff_debt1,1,0)+ IF( SELF.Diff_high_credit_mask1,1,0)+ IF( SELF.Diff_recent_high_credit1,1,0)+ IF( SELF.Diff_account_balance_mask1,1,0)+ IF( SELF.Diff_masked_account_balance1,1,0)+ IF( SELF.Diff_current_balance_percent1,1,0)+ IF( SELF.Diff_debt_01_30_percent1,1,0)+ IF( SELF.Diff_debt_31_60_percent1,1,0)+ IF( SELF.Diff_debt_61_90_percent1,1,0)+ IF( SELF.Diff_debt_91_plus_percent1,1,0)+ IF( SELF.Diff_trade_count2,1,0)+ IF( SELF.Diff_debt2,1,0)+ IF( SELF.Diff_high_credit_mask2,1,0)+ IF( SELF.Diff_recent_high_credit2,1,0)+ IF( SELF.Diff_account_balance_mask2,1,0)+ IF( SELF.Diff_masked_account_balance2,1,0)+ IF( SELF.Diff_current_balance_percent2,1,0)+ IF( SELF.Diff_debt_01_30_percent2,1,0)+ IF( SELF.Diff_debt_31_60_percent2,1,0)+ IF( SELF.Diff_debt_61_90_percent2,1,0)+ IF( SELF.Diff_debt_91_plus_percent2,1,0)+ IF( SELF.Diff_trade_count3,1,0)+ IF( SELF.Diff_debt3,1,0)+ IF( SELF.Diff_high_credit_mask3,1,0)+ IF( SELF.Diff_recent_high_credit3,1,0)+ IF( SELF.Diff_account_balance_mask3,1,0)+ IF( SELF.Diff_masked_account_balance3,1,0)+ IF( SELF.Diff_current_balance_percent3,1,0)+ IF( SELF.Diff_debt_01_30_percent3,1,0)+ IF( SELF.Diff_debt_31_60_percent3,1,0)+ IF( SELF.Diff_debt_61_90_percent3,1,0)+ IF( SELF.Diff_debt_91_plus_percent3,1,0)+ IF( SELF.Diff_highest_credit_median,1,0)+ IF( SELF.Diff_orig_account_balance_regular_tradelines,1,0)+ IF( SELF.Diff_orig_account_balance_new,1,0)+ IF( SELF.Diff_orig_account_balance_combined,1,0)+ IF( SELF.Diff_aged_trades_count,1,0)+ IF( SELF.Diff_account_balance_regular_tradelines,1,0)+ IF( SELF.Diff_account_balance_new,1,0)+ IF( SELF.Diff_account_balance_combined,1,0);
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
    Count_Diff_powid := COUNT(GROUP,%Closest%.Diff_powid);
    Count_Diff_proxid := COUNT(GROUP,%Closest%.Diff_proxid);
    Count_Diff_seleid := COUNT(GROUP,%Closest%.Diff_seleid);
    Count_Diff_orgid := COUNT(GROUP,%Closest%.Diff_orgid);
    Count_Diff_ultid := COUNT(GROUP,%Closest%.Diff_ultid);
    Count_Diff_bdid := COUNT(GROUP,%Closest%.Diff_bdid);
    Count_Diff_date_first_seen := COUNT(GROUP,%Closest%.Diff_date_first_seen);
    Count_Diff_date_last_seen := COUNT(GROUP,%Closest%.Diff_date_last_seen);
    Count_Diff_process_date_first_seen := COUNT(GROUP,%Closest%.Diff_process_date_first_seen);
    Count_Diff_process_date_last_seen := COUNT(GROUP,%Closest%.Diff_process_date_last_seen);
    Count_Diff_record_type := COUNT(GROUP,%Closest%.Diff_record_type);
    Count_Diff_process_date := COUNT(GROUP,%Closest%.Diff_process_date);
    Count_Diff_file_number := COUNT(GROUP,%Closest%.Diff_file_number);
    Count_Diff_segment_code := COUNT(GROUP,%Closest%.Diff_segment_code);
    Count_Diff_trade_count1 := COUNT(GROUP,%Closest%.Diff_trade_count1);
    Count_Diff_debt1 := COUNT(GROUP,%Closest%.Diff_debt1);
    Count_Diff_high_credit_mask1 := COUNT(GROUP,%Closest%.Diff_high_credit_mask1);
    Count_Diff_recent_high_credit1 := COUNT(GROUP,%Closest%.Diff_recent_high_credit1);
    Count_Diff_account_balance_mask1 := COUNT(GROUP,%Closest%.Diff_account_balance_mask1);
    Count_Diff_masked_account_balance1 := COUNT(GROUP,%Closest%.Diff_masked_account_balance1);
    Count_Diff_current_balance_percent1 := COUNT(GROUP,%Closest%.Diff_current_balance_percent1);
    Count_Diff_debt_01_30_percent1 := COUNT(GROUP,%Closest%.Diff_debt_01_30_percent1);
    Count_Diff_debt_31_60_percent1 := COUNT(GROUP,%Closest%.Diff_debt_31_60_percent1);
    Count_Diff_debt_61_90_percent1 := COUNT(GROUP,%Closest%.Diff_debt_61_90_percent1);
    Count_Diff_debt_91_plus_percent1 := COUNT(GROUP,%Closest%.Diff_debt_91_plus_percent1);
    Count_Diff_trade_count2 := COUNT(GROUP,%Closest%.Diff_trade_count2);
    Count_Diff_debt2 := COUNT(GROUP,%Closest%.Diff_debt2);
    Count_Diff_high_credit_mask2 := COUNT(GROUP,%Closest%.Diff_high_credit_mask2);
    Count_Diff_recent_high_credit2 := COUNT(GROUP,%Closest%.Diff_recent_high_credit2);
    Count_Diff_account_balance_mask2 := COUNT(GROUP,%Closest%.Diff_account_balance_mask2);
    Count_Diff_masked_account_balance2 := COUNT(GROUP,%Closest%.Diff_masked_account_balance2);
    Count_Diff_current_balance_percent2 := COUNT(GROUP,%Closest%.Diff_current_balance_percent2);
    Count_Diff_debt_01_30_percent2 := COUNT(GROUP,%Closest%.Diff_debt_01_30_percent2);
    Count_Diff_debt_31_60_percent2 := COUNT(GROUP,%Closest%.Diff_debt_31_60_percent2);
    Count_Diff_debt_61_90_percent2 := COUNT(GROUP,%Closest%.Diff_debt_61_90_percent2);
    Count_Diff_debt_91_plus_percent2 := COUNT(GROUP,%Closest%.Diff_debt_91_plus_percent2);
    Count_Diff_trade_count3 := COUNT(GROUP,%Closest%.Diff_trade_count3);
    Count_Diff_debt3 := COUNT(GROUP,%Closest%.Diff_debt3);
    Count_Diff_high_credit_mask3 := COUNT(GROUP,%Closest%.Diff_high_credit_mask3);
    Count_Diff_recent_high_credit3 := COUNT(GROUP,%Closest%.Diff_recent_high_credit3);
    Count_Diff_account_balance_mask3 := COUNT(GROUP,%Closest%.Diff_account_balance_mask3);
    Count_Diff_masked_account_balance3 := COUNT(GROUP,%Closest%.Diff_masked_account_balance3);
    Count_Diff_current_balance_percent3 := COUNT(GROUP,%Closest%.Diff_current_balance_percent3);
    Count_Diff_debt_01_30_percent3 := COUNT(GROUP,%Closest%.Diff_debt_01_30_percent3);
    Count_Diff_debt_31_60_percent3 := COUNT(GROUP,%Closest%.Diff_debt_31_60_percent3);
    Count_Diff_debt_61_90_percent3 := COUNT(GROUP,%Closest%.Diff_debt_61_90_percent3);
    Count_Diff_debt_91_plus_percent3 := COUNT(GROUP,%Closest%.Diff_debt_91_plus_percent3);
    Count_Diff_highest_credit_median := COUNT(GROUP,%Closest%.Diff_highest_credit_median);
    Count_Diff_orig_account_balance_regular_tradelines := COUNT(GROUP,%Closest%.Diff_orig_account_balance_regular_tradelines);
    Count_Diff_orig_account_balance_new := COUNT(GROUP,%Closest%.Diff_orig_account_balance_new);
    Count_Diff_orig_account_balance_combined := COUNT(GROUP,%Closest%.Diff_orig_account_balance_combined);
    Count_Diff_aged_trades_count := COUNT(GROUP,%Closest%.Diff_aged_trades_count);
    Count_Diff_account_balance_regular_tradelines := COUNT(GROUP,%Closest%.Diff_account_balance_regular_tradelines);
    Count_Diff_account_balance_new := COUNT(GROUP,%Closest%.Diff_account_balance_new);
    Count_Diff_account_balance_combined := COUNT(GROUP,%Closest%.Diff_account_balance_combined);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
