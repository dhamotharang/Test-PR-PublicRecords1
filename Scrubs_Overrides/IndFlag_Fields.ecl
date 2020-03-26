IMPORT SALT311;
EXPORT IndFlag_Fields := MODULE
 
EXPORT NumFields := 2;
 
// Processing for each FieldType
EXPORT SALT311.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'Invalid_FlagID');
EXPORT FieldTypeNum(SALT311.StrType fn) := CASE(fn,'Invalid_FlagID' => 1,0);
 
EXPORT MakeFT_Invalid_FlagID(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_FlagID(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) >= 6));
EXPORT InValidMessageFT_Invalid_FlagID(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789'),SALT311.HygieneErrors.NotLength('6..'),SALT311.HygieneErrors.Good);
 
EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'Key_Ind','flag_file_id');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'Key_Ind','flag_file_id');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'Key_Ind' => 0,'flag_file_id' => 1,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,[],['ALLOW','LENGTHS'],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_Key_Ind(SALT311.StrType s0) := s0;
EXPORT InValid_Key_Ind(SALT311.StrType s) := 0;
EXPORT InValidMessage_Key_Ind(UNSIGNED1 wh) := '';
 
EXPORT Make_flag_file_id(SALT311.StrType s0) := MakeFT_Invalid_FlagID(s0);
EXPORT InValid_flag_file_id(SALT311.StrType s) := InValidFT_Invalid_FlagID(s);
EXPORT InValidMessage_flag_file_id(UNSIGNED1 wh) := InValidMessageFT_Invalid_FlagID(wh);
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT311,Scrubs_Overrides;
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
    BOOLEAN Diff_Key_Ind;
    BOOLEAN Diff_flag_file_id;
    SALT311.StrType SourceField {MAXLENGTH(30)};
    UNSIGNED Num_Diffs;
    SALT311.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_Key_Ind := le.Key_Ind <> ri.Key_Ind;
    SELF.Diff_flag_file_id := le.flag_file_id <> ri.flag_file_id;
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.SourceField := le.Key_Ind;
    SELF.Num_Diffs := 0+ IF( SELF.Diff_Key_Ind,1,0)+ IF( SELF.Diff_flag_file_id,1,0);
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
    Count_Diff_Key_Ind := COUNT(GROUP,%Closest%.Diff_Key_Ind);
    Count_Diff_flag_file_id := COUNT(GROUP,%Closest%.Diff_flag_file_id);
    %Closest%.SourceField;
  END;
  out_counts := table(%Closest%,%AggRec%,SourceField,few);
ENDMACRO;
END;
