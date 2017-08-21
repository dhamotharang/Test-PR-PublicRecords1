IMPORT ut,SALT33;
EXPORT MS_Fields := MODULE
// Processing for each FieldType
EXPORT SALT33.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_segment_identifier','invalid_file_sequence_number','invalid_parent_sequence_number','invalid_account_base_ab_number','invalid_name_of_value','invalid_valuenum','invalid_privacy_indicator');
EXPORT FieldTypeNum(SALT33.StrType fn) := CASE(fn,'invalid_segment_identifier' => 1,'invalid_file_sequence_number' => 2,'invalid_parent_sequence_number' => 3,'invalid_account_base_ab_number' => 4,'invalid_name_of_value' => 5,'invalid_valuenum' => 6,'invalid_privacy_indicator' => 7,0);
EXPORT MakeFT_invalid_segment_identifier(SALT33.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_segment_identifier(SALT33.StrType s) := WHICH(((SALT33.StrType) s) NOT IN ['MS','MS']);
EXPORT InValidMessageFT_invalid_segment_identifier(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInEnum('MS|MS'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_file_sequence_number(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_file_sequence_number(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) >= 1));
EXPORT InValidMessageFT_invalid_file_sequence_number(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('0123456789'),SALT33.HygieneErrors.NotLength('1..'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_parent_sequence_number(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_parent_sequence_number(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) >= 1));
EXPORT InValidMessageFT_invalid_parent_sequence_number(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('0123456789'),SALT33.HygieneErrors.NotLength('1..'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_account_base_ab_number(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_account_base_ab_number(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) >= 1));
EXPORT InValidMessageFT_invalid_account_base_ab_number(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('0123456789'),SALT33.HygieneErrors.NotLength('1..'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_name_of_value(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789_'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_name_of_value(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789_'))),~(LENGTH(TRIM(s)) >= 1));
EXPORT InValidMessageFT_invalid_name_of_value(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789_'),SALT33.HygieneErrors.NotLength('1..'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_valuenum(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'-ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 .'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_valuenum(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'-ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 .'))),~(LENGTH(TRIM(s)) >= 1));
EXPORT InValidMessageFT_invalid_valuenum(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('-ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 .'),SALT33.HygieneErrors.NotLength('1..'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_privacy_indicator(SALT33.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_privacy_indicator(SALT33.StrType s) := WHICH(((SALT33.StrType) s) NOT IN ['Y','N','']);
EXPORT InValidMessageFT_invalid_privacy_indicator(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInEnum('Y|N|'),SALT33.HygieneErrors.Good);
EXPORT SALT33.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'segment_identifier','file_sequence_number','parent_sequence_number','account_base_number','name_of_value','value_string','privacy_indicator');
EXPORT FieldNum(SALT33.StrType fn) := CASE(fn,'segment_identifier' => 0,'file_sequence_number' => 1,'parent_sequence_number' => 2,'account_base_number' => 3,'name_of_value' => 4,'value_string' => 5,'privacy_indicator' => 6,0);
//Individual field level validation
EXPORT Make_segment_identifier(SALT33.StrType s0) := MakeFT_invalid_segment_identifier(s0);
EXPORT InValid_segment_identifier(SALT33.StrType s) := InValidFT_invalid_segment_identifier(s);
EXPORT InValidMessage_segment_identifier(UNSIGNED1 wh) := InValidMessageFT_invalid_segment_identifier(wh);
EXPORT Make_file_sequence_number(SALT33.StrType s0) := MakeFT_invalid_file_sequence_number(s0);
EXPORT InValid_file_sequence_number(SALT33.StrType s) := InValidFT_invalid_file_sequence_number(s);
EXPORT InValidMessage_file_sequence_number(UNSIGNED1 wh) := InValidMessageFT_invalid_file_sequence_number(wh);
EXPORT Make_parent_sequence_number(SALT33.StrType s0) := MakeFT_invalid_parent_sequence_number(s0);
EXPORT InValid_parent_sequence_number(SALT33.StrType s) := InValidFT_invalid_parent_sequence_number(s);
EXPORT InValidMessage_parent_sequence_number(UNSIGNED1 wh) := InValidMessageFT_invalid_parent_sequence_number(wh);
EXPORT Make_account_base_number(SALT33.StrType s0) := MakeFT_invalid_account_base_ab_number(s0);
EXPORT InValid_account_base_number(SALT33.StrType s) := InValidFT_invalid_account_base_ab_number(s);
EXPORT InValidMessage_account_base_number(UNSIGNED1 wh) := InValidMessageFT_invalid_account_base_ab_number(wh);
EXPORT Make_name_of_value(SALT33.StrType s0) := MakeFT_invalid_name_of_value(s0);
EXPORT InValid_name_of_value(SALT33.StrType s) := InValidFT_invalid_name_of_value(s);
EXPORT InValidMessage_name_of_value(UNSIGNED1 wh) := InValidMessageFT_invalid_name_of_value(wh);
EXPORT Make_value_string(SALT33.StrType s0) := MakeFT_invalid_valuenum(s0);
EXPORT InValid_value_string(SALT33.StrType s) := InValidFT_invalid_valuenum(s);
EXPORT InValidMessage_value_string(UNSIGNED1 wh) := InValidMessageFT_invalid_valuenum(wh);
EXPORT Make_privacy_indicator(SALT33.StrType s0) := MakeFT_invalid_privacy_indicator(s0);
EXPORT InValid_privacy_indicator(SALT33.StrType s) := InValidFT_invalid_privacy_indicator(s);
EXPORT InValidMessage_privacy_indicator(UNSIGNED1 wh) := InValidMessageFT_invalid_privacy_indicator(wh);
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
    BOOLEAN Diff_account_base_number;
    BOOLEAN Diff_name_of_value;
    BOOLEAN Diff_value_string;
    BOOLEAN Diff_privacy_indicator;
    UNSIGNED Num_Diffs;
    SALT33.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_segment_identifier := le.segment_identifier <> ri.segment_identifier;
    SELF.Diff_file_sequence_number := le.file_sequence_number <> ri.file_sequence_number;
    SELF.Diff_parent_sequence_number := le.parent_sequence_number <> ri.parent_sequence_number;
    SELF.Diff_account_base_number := le.account_base_number <> ri.account_base_number;
    SELF.Diff_name_of_value := le.name_of_value <> ri.name_of_value;
    SELF.Diff_value_string := le.value_string <> ri.value_string;
    SELF.Diff_privacy_indicator := le.privacy_indicator <> ri.privacy_indicator;
    SELF.Val := (SALT33.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_segment_identifier,1,0)+ IF( SELF.Diff_file_sequence_number,1,0)+ IF( SELF.Diff_parent_sequence_number,1,0)+ IF( SELF.Diff_account_base_number,1,0)+ IF( SELF.Diff_name_of_value,1,0)+ IF( SELF.Diff_value_string,1,0)+ IF( SELF.Diff_privacy_indicator,1,0);
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
    Count_Diff_account_base_number := COUNT(GROUP,%Closest%.Diff_account_base_number);
    Count_Diff_name_of_value := COUNT(GROUP,%Closest%.Diff_name_of_value);
    Count_Diff_value_string := COUNT(GROUP,%Closest%.Diff_value_string);
    Count_Diff_privacy_indicator := COUNT(GROUP,%Closest%.Diff_privacy_indicator);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
