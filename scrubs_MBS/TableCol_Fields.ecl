IMPORT SALT39;
EXPORT TableCol_Fields := MODULE
 
EXPORT NumFields := 4;
 
// Processing for each FieldType
EXPORT SALT39.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_alpha','invalid_alphanumeric','invalid_date','invalid_numeric');
EXPORT FieldTypeNum(SALT39.StrType fn) := CASE(fn,'invalid_alpha' => 1,'invalid_alphanumeric' => 2,'invalid_date' => 3,'invalid_numeric' => 4,0);
 
EXPORT MakeFT_invalid_alpha(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_alpha(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) >= 4));
EXPORT InValidMessageFT_invalid_alpha(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'),SALT39.HygieneErrors.NotLength('0,4..'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_alphanumeric(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 <>{}[]-^=\'!+&,./#()_'); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' <>{}[]-^=\'!+&,./#()_',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_alphanumeric(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 <>{}[]-^=\'!+&,./#()_'))));
EXPORT InValidMessageFT_invalid_alphanumeric(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 <>{}[]-^=\'!+&,./#()_'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_date(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789 -:'); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' -:',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_date(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789 -:'))));
EXPORT InValidMessageFT_invalid_date(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('0123456789 -:'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_numeric(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_numeric(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_invalid_numeric(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('0123456789'),SALT39.HygieneErrors.Good);
 
EXPORT SALT39.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'table_column_id','table_name','column_name','is_column_value');
EXPORT SALT39.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'table_column_id','table_name','column_name','is_column_value');
EXPORT FieldNum(SALT39.StrType fn) := CASE(fn,'table_column_id' => 0,'table_name' => 1,'column_name' => 2,'is_column_value' => 3,0);
EXPORT SET OF SALT39.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_table_column_id(SALT39.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_table_column_id(SALT39.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_table_column_id(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_table_name(SALT39.StrType s0) := MakeFT_invalid_alphanumeric(s0);
EXPORT InValid_table_name(SALT39.StrType s) := InValidFT_invalid_alphanumeric(s);
EXPORT InValidMessage_table_name(UNSIGNED1 wh) := InValidMessageFT_invalid_alphanumeric(wh);
 
EXPORT Make_column_name(SALT39.StrType s0) := MakeFT_invalid_alphanumeric(s0);
EXPORT InValid_column_name(SALT39.StrType s) := InValidFT_invalid_alphanumeric(s);
EXPORT InValidMessage_column_name(UNSIGNED1 wh) := InValidMessageFT_invalid_alphanumeric(wh);
 
EXPORT Make_is_column_value(SALT39.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_is_column_value(SALT39.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_is_column_value(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT39,Scrubs_MBS;
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
    BOOLEAN Diff_table_column_id;
    BOOLEAN Diff_table_name;
    BOOLEAN Diff_column_name;
    BOOLEAN Diff_is_column_value;
    UNSIGNED Num_Diffs;
    SALT39.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_table_column_id := le.table_column_id <> ri.table_column_id;
    SELF.Diff_table_name := le.table_name <> ri.table_name;
    SELF.Diff_column_name := le.column_name <> ri.column_name;
    SELF.Diff_is_column_value := le.is_column_value <> ri.is_column_value;
    SELF.Val := (SALT39.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_table_column_id,1,0)+ IF( SELF.Diff_table_name,1,0)+ IF( SELF.Diff_column_name,1,0)+ IF( SELF.Diff_is_column_value,1,0);
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
    Count_Diff_table_column_id := COUNT(GROUP,%Closest%.Diff_table_column_id);
    Count_Diff_table_name := COUNT(GROUP,%Closest%.Diff_table_name);
    Count_Diff_column_name := COUNT(GROUP,%Closest%.Diff_column_name);
    Count_Diff_is_column_value := COUNT(GROUP,%Closest%.Diff_is_column_value);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
