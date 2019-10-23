IMPORT SALT311;
IMPORT Scrubs_EBR; // Import modules for FieldTypes attribute definitions
EXPORT Base_1000_Fields := MODULE
 
EXPORT NumFields := 27;
 
// Processing for each FieldType
EXPORT SALT311.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_mandatory','invalid_pastdate','invalid_generaldate','invalid_dt_first_seen','invalid_mmddyy_Date','invalid_record_type','invalid_payment_trend','invalid_payment_performance','invalid_file_number','invalid_numeric');
EXPORT FieldTypeNum(SALT311.StrType fn) := CASE(fn,'invalid_mandatory' => 1,'invalid_pastdate' => 2,'invalid_generaldate' => 3,'invalid_dt_first_seen' => 4,'invalid_mmddyy_Date' => 5,'invalid_record_type' => 6,'invalid_payment_trend' => 7,'invalid_payment_performance' => 8,'invalid_file_number' => 9,'invalid_numeric' => 10,0);
 
EXPORT MakeFT_invalid_mandatory(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_mandatory(SALT311.StrType s) := WHICH(~(LENGTH(TRIM(s)) >= 1));
EXPORT InValidMessageFT_invalid_mandatory(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLength('1..'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_pastdate(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_pastdate(SALT311.StrType s) := WHICH(~Scrubs_EBR.Functions.fn_past_yyyymmdd(s)>0);
EXPORT InValidMessageFT_invalid_pastdate(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_EBR.Functions.fn_past_yyyymmdd'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_generaldate(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_generaldate(SALT311.StrType s) := WHICH(~Scrubs_EBR.Functions.fn_general_yyyymmdd(s)>0);
EXPORT InValidMessageFT_invalid_generaldate(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_EBR.Functions.fn_general_yyyymmdd'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_dt_first_seen(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_dt_first_seen(SALT311.StrType s) := WHICH(~Scrubs_EBR.Functions.fn_dt_first_seen(s)>0);
EXPORT InValidMessageFT_invalid_dt_first_seen(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_EBR.Functions.fn_dt_first_seen'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_mmddyy_Date(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_mmddyy_Date(SALT311.StrType s) := WHICH(~Scrubs_EBR.Functions.fn_valid_mmddyy_Date(s)>0);
EXPORT InValidMessageFT_invalid_mmddyy_Date(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_EBR.Functions.fn_valid_mmddyy_Date'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_record_type(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_record_type(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['H','C']);
EXPORT InValidMessageFT_invalid_record_type(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('H|C'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_payment_trend(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_payment_trend(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['I','L','N','S']);
EXPORT InValidMessageFT_invalid_payment_trend(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('I|L|N|S'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_payment_performance(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_payment_performance(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN [' ','F','L','H','S']);
EXPORT InValidMessageFT_invalid_payment_performance(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum(' |F|L|H|S'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_file_number(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_file_number(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'))),~(LENGTH(TRIM(s)) = 9));
EXPORT InValidMessageFT_invalid_file_number(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'),SALT311.HygieneErrors.NotLength('9'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_numeric(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_numeric(SALT311.StrType s) := WHICH(~Scrubs_EBR.Functions.fn_numeric(s)>0);
EXPORT InValidMessageFT_invalid_numeric(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_EBR.Functions.fn_numeric'),SALT311.HygieneErrors.Good);
 
EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'powid','proxid','seleid','orgid','ultid','bdid','date_first_seen','date_last_seen','process_date_first_seen','process_date_last_seen','record_type','process_date','file_number','current_dbt','predicted_dbt','orig_predicted_dbt_date_mmddyy','average_industry_dbt','average_all_industries_dbt','low_balance','high_balance','current_account_balance','high_credit_extended','median_credit_extended','payment_performance','payment_trend','industry_description','predicted_dbt_date');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'powid','proxid','seleid','orgid','ultid','bdid','date_first_seen','date_last_seen','process_date_first_seen','process_date_last_seen','record_type','process_date','file_number','current_dbt','predicted_dbt','orig_predicted_dbt_date_mmddyy','average_industry_dbt','average_all_industries_dbt','low_balance','high_balance','current_account_balance','high_credit_extended','median_credit_extended','payment_performance','payment_trend','industry_description','predicted_dbt_date');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'powid' => 0,'proxid' => 1,'seleid' => 2,'orgid' => 3,'ultid' => 4,'bdid' => 5,'date_first_seen' => 6,'date_last_seen' => 7,'process_date_first_seen' => 8,'process_date_last_seen' => 9,'record_type' => 10,'process_date' => 11,'file_number' => 12,'current_dbt' => 13,'predicted_dbt' => 14,'orig_predicted_dbt_date_mmddyy' => 15,'average_industry_dbt' => 16,'average_all_industries_dbt' => 17,'low_balance' => 18,'high_balance' => 19,'current_account_balance' => 20,'high_credit_extended' => 21,'median_credit_extended' => 22,'payment_performance' => 23,'payment_trend' => 24,'industry_description' => 25,'predicted_dbt_date' => 26,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['LENGTHS'],['LENGTHS'],['LENGTHS'],['LENGTHS'],['LENGTHS'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['ENUM'],['CUSTOM'],['ALLOW','LENGTHS'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['ENUM'],['ENUM'],['LENGTHS'],['CUSTOM'],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
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
 
EXPORT Make_current_dbt(SALT311.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_current_dbt(SALT311.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_current_dbt(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_predicted_dbt(SALT311.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_predicted_dbt(SALT311.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_predicted_dbt(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_orig_predicted_dbt_date_mmddyy(SALT311.StrType s0) := MakeFT_invalid_mmddyy_Date(s0);
EXPORT InValid_orig_predicted_dbt_date_mmddyy(SALT311.StrType s) := InValidFT_invalid_mmddyy_Date(s);
EXPORT InValidMessage_orig_predicted_dbt_date_mmddyy(UNSIGNED1 wh) := InValidMessageFT_invalid_mmddyy_Date(wh);
 
EXPORT Make_average_industry_dbt(SALT311.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_average_industry_dbt(SALT311.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_average_industry_dbt(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_average_all_industries_dbt(SALT311.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_average_all_industries_dbt(SALT311.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_average_all_industries_dbt(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_low_balance(SALT311.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_low_balance(SALT311.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_low_balance(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_high_balance(SALT311.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_high_balance(SALT311.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_high_balance(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_current_account_balance(SALT311.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_current_account_balance(SALT311.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_current_account_balance(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_high_credit_extended(SALT311.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_high_credit_extended(SALT311.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_high_credit_extended(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_median_credit_extended(SALT311.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_median_credit_extended(SALT311.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_median_credit_extended(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_payment_performance(SALT311.StrType s0) := MakeFT_invalid_payment_performance(s0);
EXPORT InValid_payment_performance(SALT311.StrType s) := InValidFT_invalid_payment_performance(s);
EXPORT InValidMessage_payment_performance(UNSIGNED1 wh) := InValidMessageFT_invalid_payment_performance(wh);
 
EXPORT Make_payment_trend(SALT311.StrType s0) := MakeFT_invalid_payment_trend(s0);
EXPORT InValid_payment_trend(SALT311.StrType s) := InValidFT_invalid_payment_trend(s);
EXPORT InValidMessage_payment_trend(UNSIGNED1 wh) := InValidMessageFT_invalid_payment_trend(wh);
 
EXPORT Make_industry_description(SALT311.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_industry_description(SALT311.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_industry_description(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_predicted_dbt_date(SALT311.StrType s0) := MakeFT_invalid_generaldate(s0);
EXPORT InValid_predicted_dbt_date(SALT311.StrType s) := InValidFT_invalid_generaldate(s);
EXPORT InValidMessage_predicted_dbt_date(UNSIGNED1 wh) := InValidMessageFT_invalid_generaldate(wh);
 
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
    BOOLEAN Diff_current_dbt;
    BOOLEAN Diff_predicted_dbt;
    BOOLEAN Diff_orig_predicted_dbt_date_mmddyy;
    BOOLEAN Diff_average_industry_dbt;
    BOOLEAN Diff_average_all_industries_dbt;
    BOOLEAN Diff_low_balance;
    BOOLEAN Diff_high_balance;
    BOOLEAN Diff_current_account_balance;
    BOOLEAN Diff_high_credit_extended;
    BOOLEAN Diff_median_credit_extended;
    BOOLEAN Diff_payment_performance;
    BOOLEAN Diff_payment_trend;
    BOOLEAN Diff_industry_description;
    BOOLEAN Diff_predicted_dbt_date;
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
    SELF.Diff_current_dbt := le.current_dbt <> ri.current_dbt;
    SELF.Diff_predicted_dbt := le.predicted_dbt <> ri.predicted_dbt;
    SELF.Diff_orig_predicted_dbt_date_mmddyy := le.orig_predicted_dbt_date_mmddyy <> ri.orig_predicted_dbt_date_mmddyy;
    SELF.Diff_average_industry_dbt := le.average_industry_dbt <> ri.average_industry_dbt;
    SELF.Diff_average_all_industries_dbt := le.average_all_industries_dbt <> ri.average_all_industries_dbt;
    SELF.Diff_low_balance := le.low_balance <> ri.low_balance;
    SELF.Diff_high_balance := le.high_balance <> ri.high_balance;
    SELF.Diff_current_account_balance := le.current_account_balance <> ri.current_account_balance;
    SELF.Diff_high_credit_extended := le.high_credit_extended <> ri.high_credit_extended;
    SELF.Diff_median_credit_extended := le.median_credit_extended <> ri.median_credit_extended;
    SELF.Diff_payment_performance := le.payment_performance <> ri.payment_performance;
    SELF.Diff_payment_trend := le.payment_trend <> ri.payment_trend;
    SELF.Diff_industry_description := le.industry_description <> ri.industry_description;
    SELF.Diff_predicted_dbt_date := le.predicted_dbt_date <> ri.predicted_dbt_date;
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_powid,1,0)+ IF( SELF.Diff_proxid,1,0)+ IF( SELF.Diff_seleid,1,0)+ IF( SELF.Diff_orgid,1,0)+ IF( SELF.Diff_ultid,1,0)+ IF( SELF.Diff_bdid,1,0)+ IF( SELF.Diff_date_first_seen,1,0)+ IF( SELF.Diff_date_last_seen,1,0)+ IF( SELF.Diff_process_date_first_seen,1,0)+ IF( SELF.Diff_process_date_last_seen,1,0)+ IF( SELF.Diff_record_type,1,0)+ IF( SELF.Diff_process_date,1,0)+ IF( SELF.Diff_file_number,1,0)+ IF( SELF.Diff_current_dbt,1,0)+ IF( SELF.Diff_predicted_dbt,1,0)+ IF( SELF.Diff_orig_predicted_dbt_date_mmddyy,1,0)+ IF( SELF.Diff_average_industry_dbt,1,0)+ IF( SELF.Diff_average_all_industries_dbt,1,0)+ IF( SELF.Diff_low_balance,1,0)+ IF( SELF.Diff_high_balance,1,0)+ IF( SELF.Diff_current_account_balance,1,0)+ IF( SELF.Diff_high_credit_extended,1,0)+ IF( SELF.Diff_median_credit_extended,1,0)+ IF( SELF.Diff_payment_performance,1,0)+ IF( SELF.Diff_payment_trend,1,0)+ IF( SELF.Diff_industry_description,1,0)+ IF( SELF.Diff_predicted_dbt_date,1,0);
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
    Count_Diff_current_dbt := COUNT(GROUP,%Closest%.Diff_current_dbt);
    Count_Diff_predicted_dbt := COUNT(GROUP,%Closest%.Diff_predicted_dbt);
    Count_Diff_orig_predicted_dbt_date_mmddyy := COUNT(GROUP,%Closest%.Diff_orig_predicted_dbt_date_mmddyy);
    Count_Diff_average_industry_dbt := COUNT(GROUP,%Closest%.Diff_average_industry_dbt);
    Count_Diff_average_all_industries_dbt := COUNT(GROUP,%Closest%.Diff_average_all_industries_dbt);
    Count_Diff_low_balance := COUNT(GROUP,%Closest%.Diff_low_balance);
    Count_Diff_high_balance := COUNT(GROUP,%Closest%.Diff_high_balance);
    Count_Diff_current_account_balance := COUNT(GROUP,%Closest%.Diff_current_account_balance);
    Count_Diff_high_credit_extended := COUNT(GROUP,%Closest%.Diff_high_credit_extended);
    Count_Diff_median_credit_extended := COUNT(GROUP,%Closest%.Diff_median_credit_extended);
    Count_Diff_payment_performance := COUNT(GROUP,%Closest%.Diff_payment_performance);
    Count_Diff_payment_trend := COUNT(GROUP,%Closest%.Diff_payment_trend);
    Count_Diff_industry_description := COUNT(GROUP,%Closest%.Diff_industry_description);
    Count_Diff_predicted_dbt_date := COUNT(GROUP,%Closest%.Diff_predicted_dbt_date);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
