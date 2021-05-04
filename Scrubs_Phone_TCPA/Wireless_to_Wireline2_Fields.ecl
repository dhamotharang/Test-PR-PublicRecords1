IMPORT SALT311;
EXPORT Wireless_to_Wireline2_Fields := MODULE
 
EXPORT NumFields := 4;
 
// Processing for each FieldType
EXPORT SALT311.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'Invalid_Num','Invalid_Num_Space');
EXPORT FieldTypeNum(SALT311.StrType fn) := CASE(fn,'Invalid_Num' => 1,'Invalid_Num_Space' => 2,0);
 
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
 
EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'cellphone','end_range','lf','filename');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'cellphone','end_range','lf','filename');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'cellphone' => 0,'end_range' => 1,'lf' => 2,'filename' => 3,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['ALLOW'],['ALLOW'],[],[],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_cellphone(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_cellphone(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_cellphone(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_end_range(SALT311.StrType s0) := MakeFT_Invalid_Num_Space(s0);
EXPORT InValid_end_range(SALT311.StrType s) := InValidFT_Invalid_Num_Space(s);
EXPORT InValidMessage_end_range(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num_Space(wh);
 
EXPORT Make_lf(SALT311.StrType s0) := s0;
EXPORT InValid_lf(SALT311.StrType s) := 0;
EXPORT InValidMessage_lf(UNSIGNED1 wh) := '';
 
EXPORT Make_filename(SALT311.StrType s0) := s0;
EXPORT InValid_filename(SALT311.StrType s) := 0;
EXPORT InValidMessage_filename(UNSIGNED1 wh) := '';
 
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
    BOOLEAN Diff_cellphone;
    BOOLEAN Diff_end_range;
    BOOLEAN Diff_lf;
    BOOLEAN Diff_filename;
    UNSIGNED Num_Diffs;
    SALT311.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_cellphone := le.cellphone <> ri.cellphone;
    SELF.Diff_end_range := le.end_range <> ri.end_range;
    SELF.Diff_lf := le.lf <> ri.lf;
    SELF.Diff_filename := le.filename <> ri.filename;
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_cellphone,1,0)+ IF( SELF.Diff_end_range,1,0)+ IF( SELF.Diff_lf,1,0)+ IF( SELF.Diff_filename,1,0);
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
    Count_Diff_cellphone := COUNT(GROUP,%Closest%.Diff_cellphone);
    Count_Diff_end_range := COUNT(GROUP,%Closest%.Diff_end_range);
    Count_Diff_lf := COUNT(GROUP,%Closest%.Diff_lf);
    Count_Diff_filename := COUNT(GROUP,%Closest%.Diff_filename);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
