IMPORT SALT38;
EXPORT CodesV3_Fields := MODULE
 
EXPORT NumFields := 6;
 
// Processing for each FieldType
EXPORT SALT38.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'InvalidCode');
EXPORT FieldTypeNum(SALT38.StrType fn) := CASE(fn,'InvalidCode' => 1,0);
 
EXPORT MakeFT_InvalidCode(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_InvalidCode(SALT38.StrType s) := WHICH(~(LENGTH(TRIM(s)) >= 1));
EXPORT InValidMessageFT_InvalidCode(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotLength('1..'),SALT38.HygieneErrors.Good);
 
EXPORT SALT38.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'file_name','field_name','field_name2','code','long_flag','long_desc');
EXPORT SALT38.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'file_name','field_name','field_name2','code','long_flag','long_desc');
EXPORT FieldNum(SALT38.StrType fn) := CASE(fn,'file_name' => 0,'field_name' => 1,'field_name2' => 2,'code' => 3,'long_flag' => 4,'long_desc' => 5,0);
EXPORT SET OF SALT38.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,[],[],[],['LENGTH'],[],[],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_file_name(SALT38.StrType s0) := s0;
EXPORT InValid_file_name(SALT38.StrType s) := 0;
EXPORT InValidMessage_file_name(UNSIGNED1 wh) := '';
 
EXPORT Make_field_name(SALT38.StrType s0) := s0;
EXPORT InValid_field_name(SALT38.StrType s) := 0;
EXPORT InValidMessage_field_name(UNSIGNED1 wh) := '';
 
EXPORT Make_field_name2(SALT38.StrType s0) := s0;
EXPORT InValid_field_name2(SALT38.StrType s) := 0;
EXPORT InValidMessage_field_name2(UNSIGNED1 wh) := '';
 
EXPORT Make_code(SALT38.StrType s0) := MakeFT_InvalidCode(s0);
EXPORT InValid_code(SALT38.StrType s) := InValidFT_InvalidCode(s);
EXPORT InValidMessage_code(UNSIGNED1 wh) := InValidMessageFT_InvalidCode(wh);
 
EXPORT Make_long_flag(SALT38.StrType s0) := s0;
EXPORT InValid_long_flag(SALT38.StrType s) := 0;
EXPORT InValidMessage_long_flag(UNSIGNED1 wh) := '';
 
EXPORT Make_long_desc(SALT38.StrType s0) := s0;
EXPORT InValid_long_desc(SALT38.StrType s) := 0;
EXPORT InValidMessage_long_desc(UNSIGNED1 wh) := '';
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT38,Scrubs_Codes;
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
    BOOLEAN Diff_file_name;
    BOOLEAN Diff_field_name;
    BOOLEAN Diff_field_name2;
    BOOLEAN Diff_code;
    BOOLEAN Diff_long_flag;
    BOOLEAN Diff_long_desc;
    UNSIGNED Num_Diffs;
    SALT38.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_file_name := le.file_name <> ri.file_name;
    SELF.Diff_field_name := le.field_name <> ri.field_name;
    SELF.Diff_field_name2 := le.field_name2 <> ri.field_name2;
    SELF.Diff_code := le.code <> ri.code;
    SELF.Diff_long_flag := le.long_flag <> ri.long_flag;
    SELF.Diff_long_desc := le.long_desc <> ri.long_desc;
    SELF.Val := (SALT38.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_file_name,1,0)+ IF( SELF.Diff_field_name,1,0)+ IF( SELF.Diff_field_name2,1,0)+ IF( SELF.Diff_code,1,0)+ IF( SELF.Diff_long_flag,1,0)+ IF( SELF.Diff_long_desc,1,0);
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
    Count_Diff_file_name := COUNT(GROUP,%Closest%.Diff_file_name);
    Count_Diff_field_name := COUNT(GROUP,%Closest%.Diff_field_name);
    Count_Diff_field_name2 := COUNT(GROUP,%Closest%.Diff_field_name2);
    Count_Diff_code := COUNT(GROUP,%Closest%.Diff_code);
    Count_Diff_long_flag := COUNT(GROUP,%Closest%.Diff_long_flag);
    Count_Diff_long_desc := COUNT(GROUP,%Closest%.Diff_long_desc);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
