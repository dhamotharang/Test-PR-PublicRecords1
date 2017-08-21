IMPORT ut,SALT31;
EXPORT MA_Fields := MODULE
// Processing for each FieldType
EXPORT SALT31.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_segment_identifier','invalid_file_sequence_number','invalid_parent_sequence_number','invalid_account_base_number','invalid_master_account_or_contract_number');
EXPORT FieldTypeNum(SALT31.StrType fn) := CASE(fn,'invalid_segment_identifier' => 1,'invalid_file_sequence_number' => 2,'invalid_parent_sequence_number' => 3,'invalid_account_base_number' => 4,'invalid_master_account_or_contract_number' => 5,0);
EXPORT MakeFT_invalid_segment_identifier(SALT31.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_segment_identifier(SALT31.StrType s) := WHICH(((SALT31.StrType) s) NOT IN ['MA','MA']);
EXPORT InValidMessageFT_invalid_segment_identifier(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInEnum('MA|MA'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_file_sequence_number(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_file_sequence_number(SALT31.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) >= 1));
EXPORT InValidMessageFT_invalid_file_sequence_number(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInChars('0123456789'),SALT31.HygieneErrors.NotLength('1..'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_parent_sequence_number(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_parent_sequence_number(SALT31.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) >= 1));
EXPORT InValidMessageFT_invalid_parent_sequence_number(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInChars('0123456789'),SALT31.HygieneErrors.NotLength('1..'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_account_base_number(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_account_base_number(SALT31.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) >= 1));
EXPORT InValidMessageFT_invalid_account_base_number(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInChars('0123456789'),SALT31.HygieneErrors.NotLength('1..'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_master_account_or_contract_number(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_master_account_or_contract_number(SALT31.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'))));
EXPORT InValidMessageFT_invalid_master_account_or_contract_number(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'),SALT31.HygieneErrors.Good);
EXPORT SALT31.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'segment_identifier','file_sequence_number','parent_sequence_number','account_base_number','master_account_or_contract_number_identifier');
EXPORT FieldNum(SALT31.StrType fn) := CASE(fn,'segment_identifier' => 1,'file_sequence_number' => 2,'parent_sequence_number' => 3,'account_base_number' => 4,'master_account_or_contract_number_identifier' => 5,0);
//Individual field level validation
EXPORT Make_segment_identifier(SALT31.StrType s0) := MakeFT_invalid_segment_identifier(s0);
EXPORT InValid_segment_identifier(SALT31.StrType s) := InValidFT_invalid_segment_identifier(s);
EXPORT InValidMessage_segment_identifier(UNSIGNED1 wh) := InValidMessageFT_invalid_segment_identifier(wh);
EXPORT Make_file_sequence_number(SALT31.StrType s0) := MakeFT_invalid_file_sequence_number(s0);
EXPORT InValid_file_sequence_number(SALT31.StrType s) := InValidFT_invalid_file_sequence_number(s);
EXPORT InValidMessage_file_sequence_number(UNSIGNED1 wh) := InValidMessageFT_invalid_file_sequence_number(wh);
EXPORT Make_parent_sequence_number(SALT31.StrType s0) := MakeFT_invalid_parent_sequence_number(s0);
EXPORT InValid_parent_sequence_number(SALT31.StrType s) := InValidFT_invalid_parent_sequence_number(s);
EXPORT InValidMessage_parent_sequence_number(UNSIGNED1 wh) := InValidMessageFT_invalid_parent_sequence_number(wh);
EXPORT Make_account_base_number(SALT31.StrType s0) := MakeFT_invalid_account_base_number(s0);
EXPORT InValid_account_base_number(SALT31.StrType s) := InValidFT_invalid_account_base_number(s);
EXPORT InValidMessage_account_base_number(UNSIGNED1 wh) := InValidMessageFT_invalid_account_base_number(wh);
EXPORT Make_master_account_or_contract_number_identifier(SALT31.StrType s0) := MakeFT_invalid_master_account_or_contract_number(s0);
EXPORT InValid_master_account_or_contract_number_identifier(SALT31.StrType s) := InValidFT_invalid_master_account_or_contract_number(s);
EXPORT InValidMessage_master_account_or_contract_number_identifier(UNSIGNED1 wh) := InValidMessageFT_invalid_master_account_or_contract_number(wh);
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT31,Scrubs_Business_Credit;
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
    BOOLEAN Diff_master_account_or_contract_number_identifier;
    UNSIGNED Num_Diffs;
    SALT31.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_segment_identifier := le.segment_identifier <> ri.segment_identifier;
    SELF.Diff_file_sequence_number := le.file_sequence_number <> ri.file_sequence_number;
    SELF.Diff_parent_sequence_number := le.parent_sequence_number <> ri.parent_sequence_number;
    SELF.Diff_account_base_number := le.account_base_number <> ri.account_base_number;
    SELF.Diff_master_account_or_contract_number_identifier := le.master_account_or_contract_number_identifier <> ri.master_account_or_contract_number_identifier;
    SELF.Val := (SALT31.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_segment_identifier,1,0)+ IF( SELF.Diff_file_sequence_number,1,0)+ IF( SELF.Diff_parent_sequence_number,1,0)+ IF( SELF.Diff_account_base_number,1,0)+ IF( SELF.Diff_master_account_or_contract_number_identifier,1,0);
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
    Count_Diff_master_account_or_contract_number_identifier := COUNT(GROUP,%Closest%.Diff_master_account_or_contract_number_identifier);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
