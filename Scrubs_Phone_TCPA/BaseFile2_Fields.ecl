IMPORT SALT311;
IMPORT Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT BaseFile2_Fields := MODULE
 
EXPORT NumFields := 10;
 
// Processing for each FieldType
EXPORT SALT311.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'Invalid_Date','Invalid_Num','Invalid_Num_Space','Invalid_PType');
EXPORT FieldTypeNum(SALT311.StrType fn) := CASE(fn,'Invalid_Date' => 1,'Invalid_Num' => 2,'Invalid_Num_Space' => 3,'Invalid_PType' => 4,0);
 
EXPORT MakeFT_Invalid_Date(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_Date(SALT311.StrType s) := WHICH(~Scrubs.fn_valid_date(s)>0);
EXPORT InValidMessageFT_Invalid_Date(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.fn_valid_date'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Num(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Num(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_Invalid_Num(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Num_Space(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Num_Space(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789 '))));
EXPORT InValidMessageFT_Invalid_Num_Space(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789 '),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_PType(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'01'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_PType(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'01'))));
EXPORT InValidMessageFT_Invalid_PType(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('01'),SALT311.HygieneErrors.Good);
 
EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'num','phone','end_range','expand_end_range','expand_range_max_count','expand_phone','is_current','dt_first_seen','dt_last_seen','phone_type');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'num','phone','end_range','expand_end_range','expand_range_max_count','expand_phone','is_current','dt_first_seen','dt_last_seen','phone_type');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'num' => 0,'phone' => 1,'end_range' => 2,'expand_end_range' => 3,'expand_range_max_count' => 4,'expand_phone' => 5,'is_current' => 6,'dt_first_seen' => 7,'dt_last_seen' => 8,'phone_type' => 9,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],[],['CUSTOM'],['CUSTOM'],['ALLOW'],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_num(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_num(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_num(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_phone(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_phone(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_phone(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_end_range(SALT311.StrType s0) := MakeFT_Invalid_Num_Space(s0);
EXPORT InValid_end_range(SALT311.StrType s) := InValidFT_Invalid_Num_Space(s);
EXPORT InValidMessage_end_range(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num_Space(wh);
 
EXPORT Make_expand_end_range(SALT311.StrType s0) := MakeFT_Invalid_Num_Space(s0);
EXPORT InValid_expand_end_range(SALT311.StrType s) := InValidFT_Invalid_Num_Space(s);
EXPORT InValidMessage_expand_end_range(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num_Space(wh);
 
EXPORT Make_expand_range_max_count(SALT311.StrType s0) := MakeFT_Invalid_Num_Space(s0);
EXPORT InValid_expand_range_max_count(SALT311.StrType s) := InValidFT_Invalid_Num_Space(s);
EXPORT InValidMessage_expand_range_max_count(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num_Space(wh);
 
EXPORT Make_expand_phone(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_expand_phone(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_expand_phone(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_is_current(SALT311.StrType s0) := s0;
EXPORT InValid_is_current(SALT311.StrType s) := 0;
EXPORT InValidMessage_is_current(UNSIGNED1 wh) := '';
 
EXPORT Make_dt_first_seen(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_dt_first_seen(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_dt_first_seen(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_dt_last_seen(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_dt_last_seen(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_dt_last_seen(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_phone_type(SALT311.StrType s0) := MakeFT_Invalid_PType(s0);
EXPORT InValid_phone_type(SALT311.StrType s) := InValidFT_Invalid_PType(s);
EXPORT InValidMessage_phone_type(UNSIGNED1 wh) := InValidMessageFT_Invalid_PType(wh);
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT311,Scrubs_Phone_TCPA;
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
    BOOLEAN Diff_num;
    BOOLEAN Diff_phone;
    BOOLEAN Diff_end_range;
    BOOLEAN Diff_expand_end_range;
    BOOLEAN Diff_expand_range_max_count;
    BOOLEAN Diff_expand_phone;
    BOOLEAN Diff_is_current;
    BOOLEAN Diff_dt_first_seen;
    BOOLEAN Diff_dt_last_seen;
    BOOLEAN Diff_phone_type;
    UNSIGNED Num_Diffs;
    SALT311.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_num := le.num <> ri.num;
    SELF.Diff_phone := le.phone <> ri.phone;
    SELF.Diff_end_range := le.end_range <> ri.end_range;
    SELF.Diff_expand_end_range := le.expand_end_range <> ri.expand_end_range;
    SELF.Diff_expand_range_max_count := le.expand_range_max_count <> ri.expand_range_max_count;
    SELF.Diff_expand_phone := le.expand_phone <> ri.expand_phone;
    SELF.Diff_is_current := le.is_current <> ri.is_current;
    SELF.Diff_dt_first_seen := le.dt_first_seen <> ri.dt_first_seen;
    SELF.Diff_dt_last_seen := le.dt_last_seen <> ri.dt_last_seen;
    SELF.Diff_phone_type := le.phone_type <> ri.phone_type;
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_num,1,0)+ IF( SELF.Diff_phone,1,0)+ IF( SELF.Diff_end_range,1,0)+ IF( SELF.Diff_expand_end_range,1,0)+ IF( SELF.Diff_expand_range_max_count,1,0)+ IF( SELF.Diff_expand_phone,1,0)+ IF( SELF.Diff_is_current,1,0)+ IF( SELF.Diff_dt_first_seen,1,0)+ IF( SELF.Diff_dt_last_seen,1,0)+ IF( SELF.Diff_phone_type,1,0);
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
    Count_Diff_num := COUNT(GROUP,%Closest%.Diff_num);
    Count_Diff_phone := COUNT(GROUP,%Closest%.Diff_phone);
    Count_Diff_end_range := COUNT(GROUP,%Closest%.Diff_end_range);
    Count_Diff_expand_end_range := COUNT(GROUP,%Closest%.Diff_expand_end_range);
    Count_Diff_expand_range_max_count := COUNT(GROUP,%Closest%.Diff_expand_range_max_count);
    Count_Diff_expand_phone := COUNT(GROUP,%Closest%.Diff_expand_phone);
    Count_Diff_is_current := COUNT(GROUP,%Closest%.Diff_is_current);
    Count_Diff_dt_first_seen := COUNT(GROUP,%Closest%.Diff_dt_first_seen);
    Count_Diff_dt_last_seen := COUNT(GROUP,%Closest%.Diff_dt_last_seen);
    Count_Diff_phone_type := COUNT(GROUP,%Closest%.Diff_phone_type);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
