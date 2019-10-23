IMPORT SALT311;
IMPORT Scrubs_EBR; // Import modules for FieldTypes attribute definitions
EXPORT Base_6500_Fields := MODULE
 
EXPORT NumFields := 33;
 
// Processing for each FieldType
EXPORT SALT311.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_mandatory','invalid_numeric','invalid_numeric_or_allzeros','invalid_pastdate','invalid_dt_first_seen','invalid_dt_ccyymm','invalid_record_type','invalid_segment','invalid_file_number','invalid_cat_code','invalid_cat_desc','invalid_terms','invalid_comment_code','invalid_comment_desc','invalid_mask','invalid_dt_mmddyy','invalid_dt_yymm');
EXPORT FieldTypeNum(SALT311.StrType fn) := CASE(fn,'invalid_mandatory' => 1,'invalid_numeric' => 2,'invalid_numeric_or_allzeros' => 3,'invalid_pastdate' => 4,'invalid_dt_first_seen' => 5,'invalid_dt_ccyymm' => 6,'invalid_record_type' => 7,'invalid_segment' => 8,'invalid_file_number' => 9,'invalid_cat_code' => 10,'invalid_cat_desc' => 11,'invalid_terms' => 12,'invalid_comment_code' => 13,'invalid_comment_desc' => 14,'invalid_mask' => 15,'invalid_dt_mmddyy' => 16,'invalid_dt_yymm' => 17,0);
 
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
 
EXPORT MakeFT_invalid_dt_ccyymm(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_dt_ccyymm(SALT311.StrType s) := WHICH(~Scrubs_EBR.Functions.fn_dt_ccyymm_or_200000(s)>0);
EXPORT InValidMessageFT_invalid_dt_ccyymm(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_EBR.Functions.fn_dt_ccyymm_or_200000'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_record_type(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_record_type(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['H','C']);
EXPORT InValidMessageFT_invalid_record_type(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('H|C'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_segment(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_segment(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['6500','6500']);
EXPORT InValidMessageFT_invalid_segment(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('6500|6500'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_file_number(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_file_number(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'))),~(LENGTH(TRIM(s)) = 9));
EXPORT InValidMessageFT_invalid_file_number(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'),SALT311.HygieneErrors.NotLength('9'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_cat_code(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_cat_code(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['2911','2916']);
EXPORT InValidMessageFT_invalid_cat_code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('2911|2916'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_cat_desc(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_cat_desc(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['GOVT/SBA','GOVT/HUD']);
EXPORT InValidMessageFT_invalid_cat_desc(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('GOVT/SBA|GOVT/HUD'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_terms(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_terms(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['CONTRCT','NET 30']);
EXPORT InValidMessageFT_invalid_terms(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('CONTRCT|NET 30'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_comment_code(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_comment_code(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN [' ','76']);
EXPORT InValidMessageFT_invalid_comment_code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum(' |76'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_comment_desc(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_comment_desc(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN [' ','COLLECTION']);
EXPORT InValidMessageFT_invalid_comment_desc(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum(' |COLLECTION'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_mask(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_mask(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN [' ','<']);
EXPORT InValidMessageFT_invalid_mask(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum(' |<'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_dt_mmddyy(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_dt_mmddyy(SALT311.StrType s) := WHICH(~Scrubs_EBR.Functions.fn_dt_mmddyy(s)>0);
EXPORT InValidMessageFT_invalid_dt_mmddyy(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_EBR.Functions.fn_dt_mmddyy'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_dt_yymm(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_dt_yymm(SALT311.StrType s) := WHICH(~Scrubs_EBR.Functions.fn_dt_yymm_or_0000(s)>0);
EXPORT InValidMessageFT_invalid_dt_yymm(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_EBR.Functions.fn_dt_yymm_or_0000'),SALT311.HygieneErrors.Good);
 
EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'powid','proxid','seleid','orgid','ultid','bdid','date_first_seen','date_last_seen','process_date_first_seen','process_date_last_seen','record_type','process_date','file_number','segment_code','sequence_number','bus_cat_code','bus_cat_desc','orig_date_reported_ymd','orig_date_last_sale_ym','payment_terms','high_credit_mask','recent_high_credit','acct_bal_mask','masked_acct_bal','current_pct','dbt_01_30_pct','dbt_31_60_pct','dbt_61_90_pct','dbt_91_plus_pct','comment_code','comment_desc','date_reported','date_last_sale');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'powid','proxid','seleid','orgid','ultid','bdid','date_first_seen','date_last_seen','process_date_first_seen','process_date_last_seen','record_type','process_date','file_number','segment_code','sequence_number','bus_cat_code','bus_cat_desc','orig_date_reported_ymd','orig_date_last_sale_ym','payment_terms','high_credit_mask','recent_high_credit','acct_bal_mask','masked_acct_bal','current_pct','dbt_01_30_pct','dbt_31_60_pct','dbt_61_90_pct','dbt_91_plus_pct','comment_code','comment_desc','date_reported','date_last_sale');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'powid' => 0,'proxid' => 1,'seleid' => 2,'orgid' => 3,'ultid' => 4,'bdid' => 5,'date_first_seen' => 6,'date_last_seen' => 7,'process_date_first_seen' => 8,'process_date_last_seen' => 9,'record_type' => 10,'process_date' => 11,'file_number' => 12,'segment_code' => 13,'sequence_number' => 14,'bus_cat_code' => 15,'bus_cat_desc' => 16,'orig_date_reported_ymd' => 17,'orig_date_last_sale_ym' => 18,'payment_terms' => 19,'high_credit_mask' => 20,'recent_high_credit' => 21,'acct_bal_mask' => 22,'masked_acct_bal' => 23,'current_pct' => 24,'dbt_01_30_pct' => 25,'dbt_31_60_pct' => 26,'dbt_61_90_pct' => 27,'dbt_91_plus_pct' => 28,'comment_code' => 29,'comment_desc' => 30,'date_reported' => 31,'date_last_sale' => 32,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['LENGTHS'],['LENGTHS'],['LENGTHS'],['LENGTHS'],['LENGTHS'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['ENUM'],['CUSTOM'],['ALLOW','LENGTHS'],['ENUM'],['CUSTOM'],['ENUM'],['ENUM'],['CUSTOM'],['CUSTOM'],['ENUM'],['ENUM'],['CUSTOM'],['ENUM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['ENUM'],['ENUM'],['CUSTOM'],['CUSTOM'],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
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
 
EXPORT Make_bus_cat_code(SALT311.StrType s0) := MakeFT_invalid_cat_code(s0);
EXPORT InValid_bus_cat_code(SALT311.StrType s) := InValidFT_invalid_cat_code(s);
EXPORT InValidMessage_bus_cat_code(UNSIGNED1 wh) := InValidMessageFT_invalid_cat_code(wh);
 
EXPORT Make_bus_cat_desc(SALT311.StrType s0) := MakeFT_invalid_cat_desc(s0);
EXPORT InValid_bus_cat_desc(SALT311.StrType s) := InValidFT_invalid_cat_desc(s);
EXPORT InValidMessage_bus_cat_desc(UNSIGNED1 wh) := InValidMessageFT_invalid_cat_desc(wh);
 
EXPORT Make_orig_date_reported_ymd(SALT311.StrType s0) := MakeFT_invalid_dt_mmddyy(s0);
EXPORT InValid_orig_date_reported_ymd(SALT311.StrType s) := InValidFT_invalid_dt_mmddyy(s);
EXPORT InValidMessage_orig_date_reported_ymd(UNSIGNED1 wh) := InValidMessageFT_invalid_dt_mmddyy(wh);
 
EXPORT Make_orig_date_last_sale_ym(SALT311.StrType s0) := MakeFT_invalid_dt_yymm(s0);
EXPORT InValid_orig_date_last_sale_ym(SALT311.StrType s) := InValidFT_invalid_dt_yymm(s);
EXPORT InValidMessage_orig_date_last_sale_ym(UNSIGNED1 wh) := InValidMessageFT_invalid_dt_yymm(wh);
 
EXPORT Make_payment_terms(SALT311.StrType s0) := MakeFT_invalid_terms(s0);
EXPORT InValid_payment_terms(SALT311.StrType s) := InValidFT_invalid_terms(s);
EXPORT InValidMessage_payment_terms(UNSIGNED1 wh) := InValidMessageFT_invalid_terms(wh);
 
EXPORT Make_high_credit_mask(SALT311.StrType s0) := MakeFT_invalid_mask(s0);
EXPORT InValid_high_credit_mask(SALT311.StrType s) := InValidFT_invalid_mask(s);
EXPORT InValidMessage_high_credit_mask(UNSIGNED1 wh) := InValidMessageFT_invalid_mask(wh);
 
EXPORT Make_recent_high_credit(SALT311.StrType s0) := MakeFT_invalid_numeric_or_allzeros(s0);
EXPORT InValid_recent_high_credit(SALT311.StrType s) := InValidFT_invalid_numeric_or_allzeros(s);
EXPORT InValidMessage_recent_high_credit(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric_or_allzeros(wh);
 
EXPORT Make_acct_bal_mask(SALT311.StrType s0) := MakeFT_invalid_mask(s0);
EXPORT InValid_acct_bal_mask(SALT311.StrType s) := InValidFT_invalid_mask(s);
EXPORT InValidMessage_acct_bal_mask(UNSIGNED1 wh) := InValidMessageFT_invalid_mask(wh);
 
EXPORT Make_masked_acct_bal(SALT311.StrType s0) := MakeFT_invalid_numeric_or_allzeros(s0);
EXPORT InValid_masked_acct_bal(SALT311.StrType s) := InValidFT_invalid_numeric_or_allzeros(s);
EXPORT InValidMessage_masked_acct_bal(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric_or_allzeros(wh);
 
EXPORT Make_current_pct(SALT311.StrType s0) := MakeFT_invalid_numeric_or_allzeros(s0);
EXPORT InValid_current_pct(SALT311.StrType s) := InValidFT_invalid_numeric_or_allzeros(s);
EXPORT InValidMessage_current_pct(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric_or_allzeros(wh);
 
EXPORT Make_dbt_01_30_pct(SALT311.StrType s0) := MakeFT_invalid_numeric_or_allzeros(s0);
EXPORT InValid_dbt_01_30_pct(SALT311.StrType s) := InValidFT_invalid_numeric_or_allzeros(s);
EXPORT InValidMessage_dbt_01_30_pct(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric_or_allzeros(wh);
 
EXPORT Make_dbt_31_60_pct(SALT311.StrType s0) := MakeFT_invalid_numeric_or_allzeros(s0);
EXPORT InValid_dbt_31_60_pct(SALT311.StrType s) := InValidFT_invalid_numeric_or_allzeros(s);
EXPORT InValidMessage_dbt_31_60_pct(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric_or_allzeros(wh);
 
EXPORT Make_dbt_61_90_pct(SALT311.StrType s0) := MakeFT_invalid_numeric_or_allzeros(s0);
EXPORT InValid_dbt_61_90_pct(SALT311.StrType s) := InValidFT_invalid_numeric_or_allzeros(s);
EXPORT InValidMessage_dbt_61_90_pct(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric_or_allzeros(wh);
 
EXPORT Make_dbt_91_plus_pct(SALT311.StrType s0) := MakeFT_invalid_numeric_or_allzeros(s0);
EXPORT InValid_dbt_91_plus_pct(SALT311.StrType s) := InValidFT_invalid_numeric_or_allzeros(s);
EXPORT InValidMessage_dbt_91_plus_pct(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric_or_allzeros(wh);
 
EXPORT Make_comment_code(SALT311.StrType s0) := MakeFT_invalid_comment_code(s0);
EXPORT InValid_comment_code(SALT311.StrType s) := InValidFT_invalid_comment_code(s);
EXPORT InValidMessage_comment_code(UNSIGNED1 wh) := InValidMessageFT_invalid_comment_code(wh);
 
EXPORT Make_comment_desc(SALT311.StrType s0) := MakeFT_invalid_comment_desc(s0);
EXPORT InValid_comment_desc(SALT311.StrType s) := InValidFT_invalid_comment_desc(s);
EXPORT InValidMessage_comment_desc(UNSIGNED1 wh) := InValidMessageFT_invalid_comment_desc(wh);
 
EXPORT Make_date_reported(SALT311.StrType s0) := MakeFT_invalid_pastdate(s0);
EXPORT InValid_date_reported(SALT311.StrType s) := InValidFT_invalid_pastdate(s);
EXPORT InValidMessage_date_reported(UNSIGNED1 wh) := InValidMessageFT_invalid_pastdate(wh);
 
EXPORT Make_date_last_sale(SALT311.StrType s0) := MakeFT_invalid_dt_ccyymm(s0);
EXPORT InValid_date_last_sale(SALT311.StrType s) := InValidFT_invalid_dt_ccyymm(s);
EXPORT InValidMessage_date_last_sale(UNSIGNED1 wh) := InValidMessageFT_invalid_dt_ccyymm(wh);
 
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
    BOOLEAN Diff_bus_cat_code;
    BOOLEAN Diff_bus_cat_desc;
    BOOLEAN Diff_orig_date_reported_ymd;
    BOOLEAN Diff_orig_date_last_sale_ym;
    BOOLEAN Diff_payment_terms;
    BOOLEAN Diff_high_credit_mask;
    BOOLEAN Diff_recent_high_credit;
    BOOLEAN Diff_acct_bal_mask;
    BOOLEAN Diff_masked_acct_bal;
    BOOLEAN Diff_current_pct;
    BOOLEAN Diff_dbt_01_30_pct;
    BOOLEAN Diff_dbt_31_60_pct;
    BOOLEAN Diff_dbt_61_90_pct;
    BOOLEAN Diff_dbt_91_plus_pct;
    BOOLEAN Diff_comment_code;
    BOOLEAN Diff_comment_desc;
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
    SELF.Diff_bus_cat_code := le.bus_cat_code <> ri.bus_cat_code;
    SELF.Diff_bus_cat_desc := le.bus_cat_desc <> ri.bus_cat_desc;
    SELF.Diff_orig_date_reported_ymd := le.orig_date_reported_ymd <> ri.orig_date_reported_ymd;
    SELF.Diff_orig_date_last_sale_ym := le.orig_date_last_sale_ym <> ri.orig_date_last_sale_ym;
    SELF.Diff_payment_terms := le.payment_terms <> ri.payment_terms;
    SELF.Diff_high_credit_mask := le.high_credit_mask <> ri.high_credit_mask;
    SELF.Diff_recent_high_credit := le.recent_high_credit <> ri.recent_high_credit;
    SELF.Diff_acct_bal_mask := le.acct_bal_mask <> ri.acct_bal_mask;
    SELF.Diff_masked_acct_bal := le.masked_acct_bal <> ri.masked_acct_bal;
    SELF.Diff_current_pct := le.current_pct <> ri.current_pct;
    SELF.Diff_dbt_01_30_pct := le.dbt_01_30_pct <> ri.dbt_01_30_pct;
    SELF.Diff_dbt_31_60_pct := le.dbt_31_60_pct <> ri.dbt_31_60_pct;
    SELF.Diff_dbt_61_90_pct := le.dbt_61_90_pct <> ri.dbt_61_90_pct;
    SELF.Diff_dbt_91_plus_pct := le.dbt_91_plus_pct <> ri.dbt_91_plus_pct;
    SELF.Diff_comment_code := le.comment_code <> ri.comment_code;
    SELF.Diff_comment_desc := le.comment_desc <> ri.comment_desc;
    SELF.Diff_date_reported := le.date_reported <> ri.date_reported;
    SELF.Diff_date_last_sale := le.date_last_sale <> ri.date_last_sale;
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_powid,1,0)+ IF( SELF.Diff_proxid,1,0)+ IF( SELF.Diff_seleid,1,0)+ IF( SELF.Diff_orgid,1,0)+ IF( SELF.Diff_ultid,1,0)+ IF( SELF.Diff_bdid,1,0)+ IF( SELF.Diff_date_first_seen,1,0)+ IF( SELF.Diff_date_last_seen,1,0)+ IF( SELF.Diff_process_date_first_seen,1,0)+ IF( SELF.Diff_process_date_last_seen,1,0)+ IF( SELF.Diff_record_type,1,0)+ IF( SELF.Diff_process_date,1,0)+ IF( SELF.Diff_file_number,1,0)+ IF( SELF.Diff_segment_code,1,0)+ IF( SELF.Diff_sequence_number,1,0)+ IF( SELF.Diff_bus_cat_code,1,0)+ IF( SELF.Diff_bus_cat_desc,1,0)+ IF( SELF.Diff_orig_date_reported_ymd,1,0)+ IF( SELF.Diff_orig_date_last_sale_ym,1,0)+ IF( SELF.Diff_payment_terms,1,0)+ IF( SELF.Diff_high_credit_mask,1,0)+ IF( SELF.Diff_recent_high_credit,1,0)+ IF( SELF.Diff_acct_bal_mask,1,0)+ IF( SELF.Diff_masked_acct_bal,1,0)+ IF( SELF.Diff_current_pct,1,0)+ IF( SELF.Diff_dbt_01_30_pct,1,0)+ IF( SELF.Diff_dbt_31_60_pct,1,0)+ IF( SELF.Diff_dbt_61_90_pct,1,0)+ IF( SELF.Diff_dbt_91_plus_pct,1,0)+ IF( SELF.Diff_comment_code,1,0)+ IF( SELF.Diff_comment_desc,1,0)+ IF( SELF.Diff_date_reported,1,0)+ IF( SELF.Diff_date_last_sale,1,0);
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
    Count_Diff_bus_cat_code := COUNT(GROUP,%Closest%.Diff_bus_cat_code);
    Count_Diff_bus_cat_desc := COUNT(GROUP,%Closest%.Diff_bus_cat_desc);
    Count_Diff_orig_date_reported_ymd := COUNT(GROUP,%Closest%.Diff_orig_date_reported_ymd);
    Count_Diff_orig_date_last_sale_ym := COUNT(GROUP,%Closest%.Diff_orig_date_last_sale_ym);
    Count_Diff_payment_terms := COUNT(GROUP,%Closest%.Diff_payment_terms);
    Count_Diff_high_credit_mask := COUNT(GROUP,%Closest%.Diff_high_credit_mask);
    Count_Diff_recent_high_credit := COUNT(GROUP,%Closest%.Diff_recent_high_credit);
    Count_Diff_acct_bal_mask := COUNT(GROUP,%Closest%.Diff_acct_bal_mask);
    Count_Diff_masked_acct_bal := COUNT(GROUP,%Closest%.Diff_masked_acct_bal);
    Count_Diff_current_pct := COUNT(GROUP,%Closest%.Diff_current_pct);
    Count_Diff_dbt_01_30_pct := COUNT(GROUP,%Closest%.Diff_dbt_01_30_pct);
    Count_Diff_dbt_31_60_pct := COUNT(GROUP,%Closest%.Diff_dbt_31_60_pct);
    Count_Diff_dbt_61_90_pct := COUNT(GROUP,%Closest%.Diff_dbt_61_90_pct);
    Count_Diff_dbt_91_plus_pct := COUNT(GROUP,%Closest%.Diff_dbt_91_plus_pct);
    Count_Diff_comment_code := COUNT(GROUP,%Closest%.Diff_comment_code);
    Count_Diff_comment_desc := COUNT(GROUP,%Closest%.Diff_comment_desc);
    Count_Diff_date_reported := COUNT(GROUP,%Closest%.Diff_date_reported);
    Count_Diff_date_last_sale := COUNT(GROUP,%Closest%.Diff_date_last_sale);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
