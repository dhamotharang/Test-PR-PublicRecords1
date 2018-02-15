IMPORT SALT310;
EXPORT Daily_Raw_Wireline_to_Wireless_Fields := MODULE
 
EXPORT NumFields := 3;
 
// Processing for each FieldType
EXPORT SALT310.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'Invalid_Phone','Invalid_Filename');
EXPORT FieldTypeNum(SALT310.StrType fn) := CASE(fn,'Invalid_Phone' => 1,'Invalid_Filename' => 2,0);
 
EXPORT MakeFT_Invalid_Phone(SALT310.StrType s0) := FUNCTION
  s1 := SALT310.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Phone(SALT310.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT310.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_Invalid_Phone(UNSIGNED1 wh) := CHOOSE(wh,SALT310.HygieneErrors.NotInChars('0123456789'),SALT310.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Filename(SALT310.StrType s0) := FUNCTION
  s1 := SALT310.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_.-:'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Filename(SALT310.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT310.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_.-:'))));
EXPORT InValidMessageFT_Invalid_Filename(UNSIGNED1 wh) := CHOOSE(wh,SALT310.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_.-:'),SALT310.HygieneErrors.Good);
 
EXPORT SALT310.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'phone','lf','filename');
EXPORT SALT310.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'phone','lf','filename');
EXPORT FieldNum(SALT310.StrType fn) := CASE(fn,'phone' => 0,'lf' => 1,'filename' => 2,0);
EXPORT SET OF SALT310.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['ALLOW'],[],['ALLOW'],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_phone(SALT310.StrType s0) := MakeFT_Invalid_Phone(s0);
EXPORT InValid_phone(SALT310.StrType s) := InValidFT_Invalid_Phone(s);
EXPORT InValidMessage_phone(UNSIGNED1 wh) := InValidMessageFT_Invalid_Phone(wh);
 
EXPORT Make_lf(SALT310.StrType s0) := s0;
EXPORT InValid_lf(SALT310.StrType s) := 0;
EXPORT InValidMessage_lf(UNSIGNED1 wh) := '';
 
EXPORT Make_filename(SALT310.StrType s0) := MakeFT_Invalid_Filename(s0);
EXPORT InValid_filename(SALT310.StrType s) := InValidFT_Invalid_Filename(s);
EXPORT InValidMessage_filename(UNSIGNED1 wh) := InValidMessageFT_Invalid_Filename(wh);
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT310,Scrubs_PhonesInfo;
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
    BOOLEAN Diff_phone;
    BOOLEAN Diff_lf;
    BOOLEAN Diff_filename;
    UNSIGNED Num_Diffs;
    SALT310.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_phone := le.phone <> ri.phone;
    SELF.Diff_lf := le.lf <> ri.lf;
    SELF.Diff_filename := le.filename <> ri.filename;
    SELF.Val := (SALT310.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_phone,1,0)+ IF( SELF.Diff_lf,1,0)+ IF( SELF.Diff_filename,1,0);
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
    Count_Diff_phone := COUNT(GROUP,%Closest%.Diff_phone);
    Count_Diff_lf := COUNT(GROUP,%Closest%.Diff_lf);
    Count_Diff_filename := COUNT(GROUP,%Closest%.Diff_filename);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
