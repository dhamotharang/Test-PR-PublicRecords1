﻿IMPORT SALT38;
IMPORT Scrubs_DL_TN_CONV; // Import modules for FieldTypes attribute definitions
EXPORT Fields := MODULE
 
EXPORT NumFields := 8;
 
// Processing for each FieldType
EXPORT SALT38.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_dl_nbr','invalid_lname','invalid_past_date','invalid_action_code','invalid_county_code');
EXPORT FieldTypeNum(SALT38.StrType fn) := CASE(fn,'invalid_dl_nbr' => 1,'invalid_lname' => 2,'invalid_past_date' => 3,'invalid_action_code' => 4,'invalid_county_code' => 5,0);
 
EXPORT MakeFT_invalid_dl_nbr(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_dl_nbr(SALT38.StrType s) := WHICH(~Scrubs_DL_TN_CONV.Functions.fn_check_dl_number(s)>0);
EXPORT InValidMessageFT_invalid_dl_nbr(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_DL_TN_CONV.Functions.fn_check_dl_number'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_lname(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_lname(SALT38.StrType s) := WHICH(~Scrubs_DL_TN_CONV.Functions.fn_valid_lname(s)>0);
EXPORT InValidMessageFT_invalid_lname(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_DL_TN_CONV.Functions.fn_valid_lname'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_past_date(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_past_date(SALT38.StrType s) := WHICH(~Scrubs_DL_TN_CONV.Functions.fn_valid_past_date(s)>0);
EXPORT InValidMessageFT_invalid_past_date(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_DL_TN_CONV.Functions.fn_valid_past_date'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_action_code(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_action_code(SALT38.StrType s) := WHICH(~Scrubs_DL_TN_CONV.Functions.fn_action_code(s)>0);
EXPORT InValidMessageFT_invalid_action_code(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_DL_TN_CONV.Functions.fn_action_code'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_county_code(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_county_code(SALT38.StrType s) := WHICH(~Scrubs_DL_TN_CONV.Functions.fn_county_code(s)>0);
EXPORT InValidMessageFT_invalid_county_code(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_DL_TN_CONV.Functions.fn_county_code'),SALT38.HygieneErrors.Good);
 
EXPORT SALT38.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'process_date','dl_number','birthdate','action_code','event_date','post_date','last_name','county_code');
EXPORT SALT38.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'process_date','dl_number','birthdate','action_code','event_date','post_date','last_name','county_code');
EXPORT FieldNum(SALT38.StrType fn) := CASE(fn,'process_date' => 0,'dl_number' => 1,'birthdate' => 2,'action_code' => 3,'event_date' => 4,'post_date' => 5,'last_name' => 6,'county_code' => 7,0);
EXPORT SET OF SALT38.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_process_date(SALT38.StrType s0) := MakeFT_invalid_past_date(s0);
EXPORT InValid_process_date(SALT38.StrType s) := InValidFT_invalid_past_date(s);
EXPORT InValidMessage_process_date(UNSIGNED1 wh) := InValidMessageFT_invalid_past_date(wh);
 
EXPORT Make_dl_number(SALT38.StrType s0) := MakeFT_invalid_dl_nbr(s0);
EXPORT InValid_dl_number(SALT38.StrType s) := InValidFT_invalid_dl_nbr(s);
EXPORT InValidMessage_dl_number(UNSIGNED1 wh) := InValidMessageFT_invalid_dl_nbr(wh);
 
EXPORT Make_birthdate(SALT38.StrType s0) := MakeFT_invalid_past_date(s0);
EXPORT InValid_birthdate(SALT38.StrType s) := InValidFT_invalid_past_date(s);
EXPORT InValidMessage_birthdate(UNSIGNED1 wh) := InValidMessageFT_invalid_past_date(wh);
 
EXPORT Make_action_code(SALT38.StrType s0) := MakeFT_invalid_action_code(s0);
EXPORT InValid_action_code(SALT38.StrType s) := InValidFT_invalid_action_code(s);
EXPORT InValidMessage_action_code(UNSIGNED1 wh) := InValidMessageFT_invalid_action_code(wh);
 
EXPORT Make_event_date(SALT38.StrType s0) := MakeFT_invalid_past_date(s0);
EXPORT InValid_event_date(SALT38.StrType s) := InValidFT_invalid_past_date(s);
EXPORT InValidMessage_event_date(UNSIGNED1 wh) := InValidMessageFT_invalid_past_date(wh);
 
EXPORT Make_post_date(SALT38.StrType s0) := MakeFT_invalid_past_date(s0);
EXPORT InValid_post_date(SALT38.StrType s) := InValidFT_invalid_past_date(s);
EXPORT InValidMessage_post_date(UNSIGNED1 wh) := InValidMessageFT_invalid_past_date(wh);
 
EXPORT Make_last_name(SALT38.StrType s0) := MakeFT_invalid_lname(s0);
EXPORT InValid_last_name(SALT38.StrType s) := InValidFT_invalid_lname(s);
EXPORT InValidMessage_last_name(UNSIGNED1 wh) := InValidMessageFT_invalid_lname(wh);
 
EXPORT Make_county_code(SALT38.StrType s0) := MakeFT_invalid_county_code(s0);
EXPORT InValid_county_code(SALT38.StrType s) := InValidFT_invalid_county_code(s);
EXPORT InValidMessage_county_code(UNSIGNED1 wh) := InValidMessageFT_invalid_county_code(wh);
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT38,Scrubs_DL_TN_CONV;
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
    BOOLEAN Diff_process_date;
    BOOLEAN Diff_dl_number;
    BOOLEAN Diff_birthdate;
    BOOLEAN Diff_action_code;
    BOOLEAN Diff_event_date;
    BOOLEAN Diff_post_date;
    BOOLEAN Diff_last_name;
    BOOLEAN Diff_county_code;
    UNSIGNED Num_Diffs;
    SALT38.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_process_date := le.process_date <> ri.process_date;
    SELF.Diff_dl_number := le.dl_number <> ri.dl_number;
    SELF.Diff_birthdate := le.birthdate <> ri.birthdate;
    SELF.Diff_action_code := le.action_code <> ri.action_code;
    SELF.Diff_event_date := le.event_date <> ri.event_date;
    SELF.Diff_post_date := le.post_date <> ri.post_date;
    SELF.Diff_last_name := le.last_name <> ri.last_name;
    SELF.Diff_county_code := le.county_code <> ri.county_code;
    SELF.Val := (SALT38.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_process_date,1,0)+ IF( SELF.Diff_dl_number,1,0)+ IF( SELF.Diff_birthdate,1,0)+ IF( SELF.Diff_action_code,1,0)+ IF( SELF.Diff_event_date,1,0)+ IF( SELF.Diff_post_date,1,0)+ IF( SELF.Diff_last_name,1,0)+ IF( SELF.Diff_county_code,1,0);
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
    Count_Diff_process_date := COUNT(GROUP,%Closest%.Diff_process_date);
    Count_Diff_dl_number := COUNT(GROUP,%Closest%.Diff_dl_number);
    Count_Diff_birthdate := COUNT(GROUP,%Closest%.Diff_birthdate);
    Count_Diff_action_code := COUNT(GROUP,%Closest%.Diff_action_code);
    Count_Diff_event_date := COUNT(GROUP,%Closest%.Diff_event_date);
    Count_Diff_post_date := COUNT(GROUP,%Closest%.Diff_post_date);
    Count_Diff_last_name := COUNT(GROUP,%Closest%.Diff_last_name);
    Count_Diff_county_code := COUNT(GROUP,%Closest%.Diff_county_code);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
