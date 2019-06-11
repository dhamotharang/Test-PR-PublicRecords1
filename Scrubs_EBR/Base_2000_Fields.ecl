IMPORT SALT311;
IMPORT Scrubs_EBR; // Import modules for FieldTypes attribute definitions
EXPORT Base_2000_Fields := MODULE
 
EXPORT NumFields := 35;
 
// Processing for each FieldType
EXPORT SALT311.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_mandatory','invalid_numeric','invalid_numeric_or_allzeros','invalid_pastdate','invalid_dt_first_seen','invalid_dt_yymmdd','invalid_dt_ccyymm_or_200000','invalid_dt_yymm_or_0000','invalid_record_type','invalid_segment','invalid_payment_indicator','invalid_mask','invalid_flag','invalid_trade_code','invalid_trade_desc','invalid_file_number');
EXPORT FieldTypeNum(SALT311.StrType fn) := CASE(fn,'invalid_mandatory' => 1,'invalid_numeric' => 2,'invalid_numeric_or_allzeros' => 3,'invalid_pastdate' => 4,'invalid_dt_first_seen' => 5,'invalid_dt_yymmdd' => 6,'invalid_dt_ccyymm_or_200000' => 7,'invalid_dt_yymm_or_0000' => 8,'invalid_record_type' => 9,'invalid_segment' => 10,'invalid_payment_indicator' => 11,'invalid_mask' => 12,'invalid_flag' => 13,'invalid_trade_code' => 14,'invalid_trade_desc' => 15,'invalid_file_number' => 16,0);
 
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
 
EXPORT MakeFT_invalid_dt_yymmdd(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_dt_yymmdd(SALT311.StrType s) := WHICH(~Scrubs_EBR.Functions.fn_dt_yymmdd(s)>0);
EXPORT InValidMessageFT_invalid_dt_yymmdd(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_EBR.Functions.fn_dt_yymmdd'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_dt_ccyymm_or_200000(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_dt_ccyymm_or_200000(SALT311.StrType s) := WHICH(~Scrubs_EBR.Functions.fn_dt_ccyymm_or_200000(s)>0);
EXPORT InValidMessageFT_invalid_dt_ccyymm_or_200000(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_EBR.Functions.fn_dt_ccyymm_or_200000'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_dt_yymm_or_0000(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_dt_yymm_or_0000(SALT311.StrType s) := WHICH(~Scrubs_EBR.Functions.fn_dt_yymm_or_0000(s)>0);
EXPORT InValidMessageFT_invalid_dt_yymm_or_0000(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_EBR.Functions.fn_dt_yymm_or_0000'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_record_type(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_record_type(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['H','C']);
EXPORT InValidMessageFT_invalid_record_type(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('H|C'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_segment(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_segment(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['2000','2010']);
EXPORT InValidMessageFT_invalid_segment(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('2000|2010'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_payment_indicator(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_payment_indicator(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN [' ','+','-','=']);
EXPORT InValidMessageFT_invalid_payment_indicator(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum(' |+|-|='),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_mask(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_mask(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN [' ','-','<','+']);
EXPORT InValidMessageFT_invalid_mask(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum(' |-|<|+'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_flag(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_flag(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN [' ','Y']);
EXPORT InValidMessageFT_invalid_flag(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum(' |Y'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_trade_code(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_trade_code(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['A','C','F','L','N','R','S','T']);
EXPORT InValidMessageFT_invalid_trade_code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('A|C|F|L|N|R|S|T'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_trade_desc(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_trade_desc(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['AGED','COLLECTION','ADDITIONAL','LEASING','NEW','CONTINUOUS','OTHER','TELECOM']);
EXPORT InValidMessageFT_invalid_trade_desc(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('AGED|COLLECTION|ADDITIONAL|LEASING|NEW|CONTINUOUS|OTHER|TELECOM'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_file_number(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_file_number(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'))),~(LENGTH(TRIM(s)) = 9));
EXPORT InValidMessageFT_invalid_file_number(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'),SALT311.HygieneErrors.NotLength('9'),SALT311.HygieneErrors.Good);
 
EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'powid','proxid','seleid','orgid','ultid','bdid','date_first_seen','date_last_seen','process_date_first_seen','process_date_last_seen','record_type','process_date','file_number','segment_code','sequence_number','payment_indicator','business_category_code','business_category_description','orig_date_reported_ymd','orig_date_last_sale_ym','payment_terms','high_credit_mask','recent_high_credit','account_balance_mask','masked_account_balance','current_percent','debt_01_30_percent','debt_31_60_percent','debt_61_90_percent','debt_91_plus_percent','new_trade_flag','trade_type_code','trade_type_desc','date_reported','date_last_sale');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'powid','proxid','seleid','orgid','ultid','bdid','date_first_seen','date_last_seen','process_date_first_seen','process_date_last_seen','record_type','process_date','file_number','segment_code','sequence_number','payment_indicator','business_category_code','business_category_description','orig_date_reported_ymd','orig_date_last_sale_ym','payment_terms','high_credit_mask','recent_high_credit','account_balance_mask','masked_account_balance','current_percent','debt_01_30_percent','debt_31_60_percent','debt_61_90_percent','debt_91_plus_percent','new_trade_flag','trade_type_code','trade_type_desc','date_reported','date_last_sale');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'powid' => 0,'proxid' => 1,'seleid' => 2,'orgid' => 3,'ultid' => 4,'bdid' => 5,'date_first_seen' => 6,'date_last_seen' => 7,'process_date_first_seen' => 8,'process_date_last_seen' => 9,'record_type' => 10,'process_date' => 11,'file_number' => 12,'segment_code' => 13,'sequence_number' => 14,'payment_indicator' => 15,'business_category_code' => 16,'business_category_description' => 17,'orig_date_reported_ymd' => 18,'orig_date_last_sale_ym' => 19,'payment_terms' => 20,'high_credit_mask' => 21,'recent_high_credit' => 22,'account_balance_mask' => 23,'masked_account_balance' => 24,'current_percent' => 25,'debt_01_30_percent' => 26,'debt_31_60_percent' => 27,'debt_61_90_percent' => 28,'debt_91_plus_percent' => 29,'new_trade_flag' => 30,'trade_type_code' => 31,'trade_type_desc' => 32,'date_reported' => 33,'date_last_sale' => 34,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['LENGTHS'],['LENGTHS'],['LENGTHS'],['LENGTHS'],['LENGTHS'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['ENUM'],['CUSTOM'],['ALLOW','LENGTHS'],['ENUM'],['CUSTOM'],['ENUM'],['CUSTOM'],['LENGTHS'],['CUSTOM'],['CUSTOM'],['LENGTHS'],['ENUM'],['CUSTOM'],['ENUM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['ENUM'],['ENUM'],['ENUM'],['CUSTOM'],['CUSTOM'],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
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
 
EXPORT Make_sequence_number(SALT311.StrType s0) := MakeFT_invalid_numeric_or_allzeros(s0);
EXPORT InValid_sequence_number(SALT311.StrType s) := InValidFT_invalid_numeric_or_allzeros(s);
EXPORT InValidMessage_sequence_number(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric_or_allzeros(wh);
 
EXPORT Make_payment_indicator(SALT311.StrType s0) := MakeFT_invalid_payment_indicator(s0);
EXPORT InValid_payment_indicator(SALT311.StrType s) := InValidFT_invalid_payment_indicator(s);
EXPORT InValidMessage_payment_indicator(UNSIGNED1 wh) := InValidMessageFT_invalid_payment_indicator(wh);
 
EXPORT Make_business_category_code(SALT311.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_business_category_code(SALT311.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_business_category_code(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_business_category_description(SALT311.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_business_category_description(SALT311.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_business_category_description(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_orig_date_reported_ymd(SALT311.StrType s0) := MakeFT_invalid_dt_yymmdd(s0);
EXPORT InValid_orig_date_reported_ymd(SALT311.StrType s) := InValidFT_invalid_dt_yymmdd(s);
EXPORT InValidMessage_orig_date_reported_ymd(UNSIGNED1 wh) := InValidMessageFT_invalid_dt_yymmdd(wh);
 
EXPORT Make_orig_date_last_sale_ym(SALT311.StrType s0) := MakeFT_invalid_dt_yymm_or_0000(s0);
EXPORT InValid_orig_date_last_sale_ym(SALT311.StrType s) := InValidFT_invalid_dt_yymm_or_0000(s);
EXPORT InValidMessage_orig_date_last_sale_ym(UNSIGNED1 wh) := InValidMessageFT_invalid_dt_yymm_or_0000(wh);
 
EXPORT Make_payment_terms(SALT311.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_payment_terms(SALT311.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_payment_terms(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_high_credit_mask(SALT311.StrType s0) := MakeFT_invalid_mask(s0);
EXPORT InValid_high_credit_mask(SALT311.StrType s) := InValidFT_invalid_mask(s);
EXPORT InValidMessage_high_credit_mask(UNSIGNED1 wh) := InValidMessageFT_invalid_mask(wh);
 
EXPORT Make_recent_high_credit(SALT311.StrType s0) := MakeFT_invalid_numeric_or_allzeros(s0);
EXPORT InValid_recent_high_credit(SALT311.StrType s) := InValidFT_invalid_numeric_or_allzeros(s);
EXPORT InValidMessage_recent_high_credit(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric_or_allzeros(wh);
 
EXPORT Make_account_balance_mask(SALT311.StrType s0) := MakeFT_invalid_mask(s0);
EXPORT InValid_account_balance_mask(SALT311.StrType s) := InValidFT_invalid_mask(s);
EXPORT InValidMessage_account_balance_mask(UNSIGNED1 wh) := InValidMessageFT_invalid_mask(wh);
 
EXPORT Make_masked_account_balance(SALT311.StrType s0) := MakeFT_invalid_numeric_or_allzeros(s0);
EXPORT InValid_masked_account_balance(SALT311.StrType s) := InValidFT_invalid_numeric_or_allzeros(s);
EXPORT InValidMessage_masked_account_balance(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric_or_allzeros(wh);
 
EXPORT Make_current_percent(SALT311.StrType s0) := MakeFT_invalid_numeric_or_allzeros(s0);
EXPORT InValid_current_percent(SALT311.StrType s) := InValidFT_invalid_numeric_or_allzeros(s);
EXPORT InValidMessage_current_percent(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric_or_allzeros(wh);
 
EXPORT Make_debt_01_30_percent(SALT311.StrType s0) := MakeFT_invalid_numeric_or_allzeros(s0);
EXPORT InValid_debt_01_30_percent(SALT311.StrType s) := InValidFT_invalid_numeric_or_allzeros(s);
EXPORT InValidMessage_debt_01_30_percent(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric_or_allzeros(wh);
 
EXPORT Make_debt_31_60_percent(SALT311.StrType s0) := MakeFT_invalid_numeric_or_allzeros(s0);
EXPORT InValid_debt_31_60_percent(SALT311.StrType s) := InValidFT_invalid_numeric_or_allzeros(s);
EXPORT InValidMessage_debt_31_60_percent(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric_or_allzeros(wh);
 
EXPORT Make_debt_61_90_percent(SALT311.StrType s0) := MakeFT_invalid_numeric_or_allzeros(s0);
EXPORT InValid_debt_61_90_percent(SALT311.StrType s) := InValidFT_invalid_numeric_or_allzeros(s);
EXPORT InValidMessage_debt_61_90_percent(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric_or_allzeros(wh);
 
EXPORT Make_debt_91_plus_percent(SALT311.StrType s0) := MakeFT_invalid_numeric_or_allzeros(s0);
EXPORT InValid_debt_91_plus_percent(SALT311.StrType s) := InValidFT_invalid_numeric_or_allzeros(s);
EXPORT InValidMessage_debt_91_plus_percent(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric_or_allzeros(wh);
 
EXPORT Make_new_trade_flag(SALT311.StrType s0) := MakeFT_invalid_flag(s0);
EXPORT InValid_new_trade_flag(SALT311.StrType s) := InValidFT_invalid_flag(s);
EXPORT InValidMessage_new_trade_flag(UNSIGNED1 wh) := InValidMessageFT_invalid_flag(wh);
 
EXPORT Make_trade_type_code(SALT311.StrType s0) := MakeFT_invalid_trade_code(s0);
EXPORT InValid_trade_type_code(SALT311.StrType s) := InValidFT_invalid_trade_code(s);
EXPORT InValidMessage_trade_type_code(UNSIGNED1 wh) := InValidMessageFT_invalid_trade_code(wh);
 
EXPORT Make_trade_type_desc(SALT311.StrType s0) := MakeFT_invalid_trade_desc(s0);
EXPORT InValid_trade_type_desc(SALT311.StrType s) := InValidFT_invalid_trade_desc(s);
EXPORT InValidMessage_trade_type_desc(UNSIGNED1 wh) := InValidMessageFT_invalid_trade_desc(wh);
 
EXPORT Make_date_reported(SALT311.StrType s0) := MakeFT_invalid_pastdate(s0);
EXPORT InValid_date_reported(SALT311.StrType s) := InValidFT_invalid_pastdate(s);
EXPORT InValidMessage_date_reported(UNSIGNED1 wh) := InValidMessageFT_invalid_pastdate(wh);
 
EXPORT Make_date_last_sale(SALT311.StrType s0) := MakeFT_invalid_dt_ccyymm_or_200000(s0);
EXPORT InValid_date_last_sale(SALT311.StrType s) := InValidFT_invalid_dt_ccyymm_or_200000(s);
EXPORT InValidMessage_date_last_sale(UNSIGNED1 wh) := InValidMessageFT_invalid_dt_ccyymm_or_200000(wh);
 
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
    BOOLEAN Diff_sequence_number;
    BOOLEAN Diff_payment_indicator;
    BOOLEAN Diff_business_category_code;
    BOOLEAN Diff_business_category_description;
    BOOLEAN Diff_orig_date_reported_ymd;
    BOOLEAN Diff_orig_date_last_sale_ym;
    BOOLEAN Diff_payment_terms;
    BOOLEAN Diff_high_credit_mask;
    BOOLEAN Diff_recent_high_credit;
    BOOLEAN Diff_account_balance_mask;
    BOOLEAN Diff_masked_account_balance;
    BOOLEAN Diff_current_percent;
    BOOLEAN Diff_debt_01_30_percent;
    BOOLEAN Diff_debt_31_60_percent;
    BOOLEAN Diff_debt_61_90_percent;
    BOOLEAN Diff_debt_91_plus_percent;
    BOOLEAN Diff_new_trade_flag;
    BOOLEAN Diff_trade_type_code;
    BOOLEAN Diff_trade_type_desc;
    BOOLEAN Diff_date_reported;
    BOOLEAN Diff_date_last_sale;
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
    SELF.Diff_sequence_number := le.sequence_number <> ri.sequence_number;
    SELF.Diff_payment_indicator := le.payment_indicator <> ri.payment_indicator;
    SELF.Diff_business_category_code := le.business_category_code <> ri.business_category_code;
    SELF.Diff_business_category_description := le.business_category_description <> ri.business_category_description;
    SELF.Diff_orig_date_reported_ymd := le.orig_date_reported_ymd <> ri.orig_date_reported_ymd;
    SELF.Diff_orig_date_last_sale_ym := le.orig_date_last_sale_ym <> ri.orig_date_last_sale_ym;
    SELF.Diff_payment_terms := le.payment_terms <> ri.payment_terms;
    SELF.Diff_high_credit_mask := le.high_credit_mask <> ri.high_credit_mask;
    SELF.Diff_recent_high_credit := le.recent_high_credit <> ri.recent_high_credit;
    SELF.Diff_account_balance_mask := le.account_balance_mask <> ri.account_balance_mask;
    SELF.Diff_masked_account_balance := le.masked_account_balance <> ri.masked_account_balance;
    SELF.Diff_current_percent := le.current_percent <> ri.current_percent;
    SELF.Diff_debt_01_30_percent := le.debt_01_30_percent <> ri.debt_01_30_percent;
    SELF.Diff_debt_31_60_percent := le.debt_31_60_percent <> ri.debt_31_60_percent;
    SELF.Diff_debt_61_90_percent := le.debt_61_90_percent <> ri.debt_61_90_percent;
    SELF.Diff_debt_91_plus_percent := le.debt_91_plus_percent <> ri.debt_91_plus_percent;
    SELF.Diff_new_trade_flag := le.new_trade_flag <> ri.new_trade_flag;
    SELF.Diff_trade_type_code := le.trade_type_code <> ri.trade_type_code;
    SELF.Diff_trade_type_desc := le.trade_type_desc <> ri.trade_type_desc;
    SELF.Diff_date_reported := le.date_reported <> ri.date_reported;
    SELF.Diff_date_last_sale := le.date_last_sale <> ri.date_last_sale;
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_powid,1,0)+ IF( SELF.Diff_proxid,1,0)+ IF( SELF.Diff_seleid,1,0)+ IF( SELF.Diff_orgid,1,0)+ IF( SELF.Diff_ultid,1,0)+ IF( SELF.Diff_bdid,1,0)+ IF( SELF.Diff_date_first_seen,1,0)+ IF( SELF.Diff_date_last_seen,1,0)+ IF( SELF.Diff_process_date_first_seen,1,0)+ IF( SELF.Diff_process_date_last_seen,1,0)+ IF( SELF.Diff_record_type,1,0)+ IF( SELF.Diff_process_date,1,0)+ IF( SELF.Diff_file_number,1,0)+ IF( SELF.Diff_segment_code,1,0)+ IF( SELF.Diff_sequence_number,1,0)+ IF( SELF.Diff_payment_indicator,1,0)+ IF( SELF.Diff_business_category_code,1,0)+ IF( SELF.Diff_business_category_description,1,0)+ IF( SELF.Diff_orig_date_reported_ymd,1,0)+ IF( SELF.Diff_orig_date_last_sale_ym,1,0)+ IF( SELF.Diff_payment_terms,1,0)+ IF( SELF.Diff_high_credit_mask,1,0)+ IF( SELF.Diff_recent_high_credit,1,0)+ IF( SELF.Diff_account_balance_mask,1,0)+ IF( SELF.Diff_masked_account_balance,1,0)+ IF( SELF.Diff_current_percent,1,0)+ IF( SELF.Diff_debt_01_30_percent,1,0)+ IF( SELF.Diff_debt_31_60_percent,1,0)+ IF( SELF.Diff_debt_61_90_percent,1,0)+ IF( SELF.Diff_debt_91_plus_percent,1,0)+ IF( SELF.Diff_new_trade_flag,1,0)+ IF( SELF.Diff_trade_type_code,1,0)+ IF( SELF.Diff_trade_type_desc,1,0)+ IF( SELF.Diff_date_reported,1,0)+ IF( SELF.Diff_date_last_sale,1,0);
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
    Count_Diff_sequence_number := COUNT(GROUP,%Closest%.Diff_sequence_number);
    Count_Diff_payment_indicator := COUNT(GROUP,%Closest%.Diff_payment_indicator);
    Count_Diff_business_category_code := COUNT(GROUP,%Closest%.Diff_business_category_code);
    Count_Diff_business_category_description := COUNT(GROUP,%Closest%.Diff_business_category_description);
    Count_Diff_orig_date_reported_ymd := COUNT(GROUP,%Closest%.Diff_orig_date_reported_ymd);
    Count_Diff_orig_date_last_sale_ym := COUNT(GROUP,%Closest%.Diff_orig_date_last_sale_ym);
    Count_Diff_payment_terms := COUNT(GROUP,%Closest%.Diff_payment_terms);
    Count_Diff_high_credit_mask := COUNT(GROUP,%Closest%.Diff_high_credit_mask);
    Count_Diff_recent_high_credit := COUNT(GROUP,%Closest%.Diff_recent_high_credit);
    Count_Diff_account_balance_mask := COUNT(GROUP,%Closest%.Diff_account_balance_mask);
    Count_Diff_masked_account_balance := COUNT(GROUP,%Closest%.Diff_masked_account_balance);
    Count_Diff_current_percent := COUNT(GROUP,%Closest%.Diff_current_percent);
    Count_Diff_debt_01_30_percent := COUNT(GROUP,%Closest%.Diff_debt_01_30_percent);
    Count_Diff_debt_31_60_percent := COUNT(GROUP,%Closest%.Diff_debt_31_60_percent);
    Count_Diff_debt_61_90_percent := COUNT(GROUP,%Closest%.Diff_debt_61_90_percent);
    Count_Diff_debt_91_plus_percent := COUNT(GROUP,%Closest%.Diff_debt_91_plus_percent);
    Count_Diff_new_trade_flag := COUNT(GROUP,%Closest%.Diff_new_trade_flag);
    Count_Diff_trade_type_code := COUNT(GROUP,%Closest%.Diff_trade_type_code);
    Count_Diff_trade_type_desc := COUNT(GROUP,%Closest%.Diff_trade_type_desc);
    Count_Diff_date_reported := COUNT(GROUP,%Closest%.Diff_date_reported);
    Count_Diff_date_last_sale := COUNT(GROUP,%Closest%.Diff_date_last_sale);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
