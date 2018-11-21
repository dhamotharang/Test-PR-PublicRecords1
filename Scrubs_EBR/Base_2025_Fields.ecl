﻿IMPORT SALT311;
IMPORT Scrubs_EBR; // Import modules for FieldTypes attribute definitions
EXPORT Base_2025_Fields := MODULE
 
EXPORT NumFields := 25;
 
// Processing for each FieldType
EXPORT SALT311.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_mandatory','invalid_numeric','invalid_numeric_or_allzeros','invalid_pastdate','invalid_dt_first_seen','invalid_record_type','invalid_quarter','invalid_segment','invalid_mask','invalid_file_number');
EXPORT FieldTypeNum(SALT311.StrType fn) := CASE(fn,'invalid_mandatory' => 1,'invalid_numeric' => 2,'invalid_numeric_or_allzeros' => 3,'invalid_pastdate' => 4,'invalid_dt_first_seen' => 5,'invalid_record_type' => 6,'invalid_quarter' => 7,'invalid_segment' => 8,'invalid_mask' => 9,'invalid_file_number' => 10,0);
 
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
 
EXPORT MakeFT_invalid_record_type(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_record_type(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['H','C']);
EXPORT InValidMessageFT_invalid_record_type(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('H|C'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_quarter(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_quarter(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['1','2','3','4']);
EXPORT InValidMessageFT_invalid_quarter(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('1|2|3|4'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_segment(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_segment(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['2025','2025']);
EXPORT InValidMessageFT_invalid_segment(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('2025|2025'),SALT311.HygieneErrors.Good);
 
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
 
EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'powid','proxid','seleid','orgid','ultid','bdid','date_first_seen','date_last_seen','process_date_first_seen','process_date_last_seen','record_type','process_date','file_number','segment_code','sequence_number','quarter','quarter_yy','debt','account_balance_mask','account_balance','current_balance_percent','debt_01_30_percent','debt_31_60_percent','debt_61_90_percent','debt_91_plus_percent');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'powid','proxid','seleid','orgid','ultid','bdid','date_first_seen','date_last_seen','process_date_first_seen','process_date_last_seen','record_type','process_date','file_number','segment_code','sequence_number','quarter','quarter_yy','debt','account_balance_mask','account_balance','current_balance_percent','debt_01_30_percent','debt_31_60_percent','debt_61_90_percent','debt_91_plus_percent');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'powid' => 0,'proxid' => 1,'seleid' => 2,'orgid' => 3,'ultid' => 4,'bdid' => 5,'date_first_seen' => 6,'date_last_seen' => 7,'process_date_first_seen' => 8,'process_date_last_seen' => 9,'record_type' => 10,'process_date' => 11,'file_number' => 12,'segment_code' => 13,'sequence_number' => 14,'quarter' => 15,'quarter_yy' => 16,'debt' => 17,'account_balance_mask' => 18,'account_balance' => 19,'current_balance_percent' => 20,'debt_01_30_percent' => 21,'debt_31_60_percent' => 22,'debt_61_90_percent' => 23,'debt_91_plus_percent' => 24,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['LENGTHS'],['LENGTHS'],['LENGTHS'],['LENGTHS'],['LENGTHS'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['ENUM'],['CUSTOM'],['ALLOW','LENGTHS'],['ENUM'],['CUSTOM'],['ENUM'],['CUSTOM'],['CUSTOM'],['ENUM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
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
 
EXPORT Make_quarter(SALT311.StrType s0) := MakeFT_invalid_quarter(s0);
EXPORT InValid_quarter(SALT311.StrType s) := InValidFT_invalid_quarter(s);
EXPORT InValidMessage_quarter(UNSIGNED1 wh) := InValidMessageFT_invalid_quarter(wh);
 
EXPORT Make_quarter_yy(SALT311.StrType s0) := MakeFT_invalid_numeric_or_allzeros(s0);
EXPORT InValid_quarter_yy(SALT311.StrType s) := InValidFT_invalid_numeric_or_allzeros(s);
EXPORT InValidMessage_quarter_yy(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric_or_allzeros(wh);
 
EXPORT Make_debt(SALT311.StrType s0) := MakeFT_invalid_numeric_or_allzeros(s0);
EXPORT InValid_debt(SALT311.StrType s) := InValidFT_invalid_numeric_or_allzeros(s);
EXPORT InValidMessage_debt(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric_or_allzeros(wh);
 
EXPORT Make_account_balance_mask(SALT311.StrType s0) := MakeFT_invalid_mask(s0);
EXPORT InValid_account_balance_mask(SALT311.StrType s) := InValidFT_invalid_mask(s);
EXPORT InValidMessage_account_balance_mask(UNSIGNED1 wh) := InValidMessageFT_invalid_mask(wh);
 
EXPORT Make_account_balance(SALT311.StrType s0) := MakeFT_invalid_numeric_or_allzeros(s0);
EXPORT InValid_account_balance(SALT311.StrType s) := InValidFT_invalid_numeric_or_allzeros(s);
EXPORT InValidMessage_account_balance(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric_or_allzeros(wh);
 
EXPORT Make_current_balance_percent(SALT311.StrType s0) := MakeFT_invalid_numeric_or_allzeros(s0);
EXPORT InValid_current_balance_percent(SALT311.StrType s) := InValidFT_invalid_numeric_or_allzeros(s);
EXPORT InValidMessage_current_balance_percent(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric_or_allzeros(wh);
 
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
    BOOLEAN Diff_quarter;
    BOOLEAN Diff_quarter_yy;
    BOOLEAN Diff_debt;
    BOOLEAN Diff_account_balance_mask;
    BOOLEAN Diff_account_balance;
    BOOLEAN Diff_current_balance_percent;
    BOOLEAN Diff_debt_01_30_percent;
    BOOLEAN Diff_debt_31_60_percent;
    BOOLEAN Diff_debt_61_90_percent;
    BOOLEAN Diff_debt_91_plus_percent;
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
    SELF.Diff_quarter := le.quarter <> ri.quarter;
    SELF.Diff_quarter_yy := le.quarter_yy <> ri.quarter_yy;
    SELF.Diff_debt := le.debt <> ri.debt;
    SELF.Diff_account_balance_mask := le.account_balance_mask <> ri.account_balance_mask;
    SELF.Diff_account_balance := le.account_balance <> ri.account_balance;
    SELF.Diff_current_balance_percent := le.current_balance_percent <> ri.current_balance_percent;
    SELF.Diff_debt_01_30_percent := le.debt_01_30_percent <> ri.debt_01_30_percent;
    SELF.Diff_debt_31_60_percent := le.debt_31_60_percent <> ri.debt_31_60_percent;
    SELF.Diff_debt_61_90_percent := le.debt_61_90_percent <> ri.debt_61_90_percent;
    SELF.Diff_debt_91_plus_percent := le.debt_91_plus_percent <> ri.debt_91_plus_percent;
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_powid,1,0)+ IF( SELF.Diff_proxid,1,0)+ IF( SELF.Diff_seleid,1,0)+ IF( SELF.Diff_orgid,1,0)+ IF( SELF.Diff_ultid,1,0)+ IF( SELF.Diff_bdid,1,0)+ IF( SELF.Diff_date_first_seen,1,0)+ IF( SELF.Diff_date_last_seen,1,0)+ IF( SELF.Diff_process_date_first_seen,1,0)+ IF( SELF.Diff_process_date_last_seen,1,0)+ IF( SELF.Diff_record_type,1,0)+ IF( SELF.Diff_process_date,1,0)+ IF( SELF.Diff_file_number,1,0)+ IF( SELF.Diff_segment_code,1,0)+ IF( SELF.Diff_sequence_number,1,0)+ IF( SELF.Diff_quarter,1,0)+ IF( SELF.Diff_quarter_yy,1,0)+ IF( SELF.Diff_debt,1,0)+ IF( SELF.Diff_account_balance_mask,1,0)+ IF( SELF.Diff_account_balance,1,0)+ IF( SELF.Diff_current_balance_percent,1,0)+ IF( SELF.Diff_debt_01_30_percent,1,0)+ IF( SELF.Diff_debt_31_60_percent,1,0)+ IF( SELF.Diff_debt_61_90_percent,1,0)+ IF( SELF.Diff_debt_91_plus_percent,1,0);
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
    Count_Diff_quarter := COUNT(GROUP,%Closest%.Diff_quarter);
    Count_Diff_quarter_yy := COUNT(GROUP,%Closest%.Diff_quarter_yy);
    Count_Diff_debt := COUNT(GROUP,%Closest%.Diff_debt);
    Count_Diff_account_balance_mask := COUNT(GROUP,%Closest%.Diff_account_balance_mask);
    Count_Diff_account_balance := COUNT(GROUP,%Closest%.Diff_account_balance);
    Count_Diff_current_balance_percent := COUNT(GROUP,%Closest%.Diff_current_balance_percent);
    Count_Diff_debt_01_30_percent := COUNT(GROUP,%Closest%.Diff_debt_01_30_percent);
    Count_Diff_debt_31_60_percent := COUNT(GROUP,%Closest%.Diff_debt_31_60_percent);
    Count_Diff_debt_61_90_percent := COUNT(GROUP,%Closest%.Diff_debt_61_90_percent);
    Count_Diff_debt_91_plus_percent := COUNT(GROUP,%Closest%.Diff_debt_91_plus_percent);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
