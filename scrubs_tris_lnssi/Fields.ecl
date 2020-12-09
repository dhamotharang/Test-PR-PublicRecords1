IMPORT SALT311;
EXPORT Fields := MODULE

EXPORT NumFields := 4;

// Processing for each FieldType
EXPORT SALT311.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'Invalid_AlphaNumDash','Invalid_AlphaNumPunc','Invalid_num','Invalid_AlphaState');
EXPORT FieldTypeNum(SALT311.StrType fn) := CASE(fn,'Invalid_AlphaNumDash' => 1,'Invalid_AlphaNumPunc' => 2,'Invalid_num' => 3,'Invalid_AlphaState' => 4,0);

EXPORT MakeFT_Invalid_AlphaNumDash(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz_- '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_AlphaNumDash(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz_- '))));
EXPORT InValidMessageFT_Invalid_AlphaNumDash(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz_- '),SALT311.HygieneErrors.Good);

EXPORT MakeFT_Invalid_AlphaNumPunc(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz. '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_AlphaNumPunc(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz. '))));
EXPORT InValidMessageFT_Invalid_AlphaNumPunc(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz. '),SALT311.HygieneErrors.Good);

EXPORT MakeFT_Invalid_num(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'12345'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_num(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'12345'))));
EXPORT InValidMessageFT_Invalid_num(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('12345'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_Invalid_AlphaState(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ACDEFGHIJKLMNOPRSTUVWXYZ_- '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_AlphaState(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ACDEFGHIJKLMNOPRSTUVWXYZ_- '))));
EXPORT InValidMessageFT_Invalid_AlphaState(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ACDEFGHIJKLMNOPRSTUVWXYZ_- '),SALT311.HygieneErrors.Good);


EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'contrib_risk_field','contrib_risk_value','contrib_risk_attr','contrib_state_excl');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'contrib_risk_field','contrib_risk_value','contrib_risk_attr','contrib_state_excl');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'contrib_risk_field' => 0,'contrib_risk_value' => 1,'contrib_risk_attr' => 2,'contrib_state_excl' => 3,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,FALSE);

//Individual field level validation


EXPORT Make_contrib_risk_field(SALT311.StrType s0) := MakeFT_Invalid_AlphaNumDash(s0);
EXPORT InValid_contrib_risk_field(SALT311.StrType s) := InValidFT_Invalid_AlphaNumDash(s);
EXPORT InValidMessage_contrib_risk_field(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNumDash(wh);


EXPORT Make_contrib_risk_value(SALT311.StrType s0) := MakeFT_Invalid_AlphaNumPunc(s0);
EXPORT InValid_contrib_risk_value(SALT311.StrType s) := InValidFT_Invalid_AlphaNumPunc(s);
EXPORT InValidMessage_contrib_risk_value(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNumPunc(wh);


EXPORT Make_contrib_risk_attr(SALT311.StrType s0) := MakeFT_Invalid_num(s0);
EXPORT InValid_contrib_risk_attr(SALT311.StrType s) := InValidFT_Invalid_num(s);
EXPORT InValidMessage_contrib_risk_attr(UNSIGNED1 wh) := InValidMessageFT_Invalid_num(wh);


EXPORT Make_contrib_state_excl(SALT311.StrType s0) := MakeFT_Invalid_AlphaState(s0);
EXPORT InValid_contrib_state_excl(SALT311.StrType s) := InValidFT_Invalid_AlphaState(s);
EXPORT InValidMessage_contrib_state_excl(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaState(wh);

// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT311,scrubs_tris_lnssi;
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
    BOOLEAN Diff_contrib_risk_field;
    BOOLEAN Diff_contrib_risk_value;
    BOOLEAN Diff_contrib_risk_attr;
    BOOLEAN Diff_contrib_state_excl;
    UNSIGNED Num_Diffs;
    SALT311.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_contrib_risk_field := le.contrib_risk_field <> ri.contrib_risk_field;
    SELF.Diff_contrib_risk_value := le.contrib_risk_value <> ri.contrib_risk_value;
    SELF.Diff_contrib_risk_attr := le.contrib_risk_attr <> ri.contrib_risk_attr;
    SELF.Diff_contrib_state_excl := le.contrib_state_excl <> ri.contrib_state_excl;
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_contrib_risk_field,1,0)+ IF( SELF.Diff_contrib_risk_value,1,0)+ IF( SELF.Diff_contrib_risk_attr,1,0)+ IF( SELF.Diff_contrib_state_excl,1,0);
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
    Count_Diff_contrib_risk_field := COUNT(GROUP,%Closest%.Diff_contrib_risk_field);
    Count_Diff_contrib_risk_value := COUNT(GROUP,%Closest%.Diff_contrib_risk_value);
    Count_Diff_contrib_risk_attr := COUNT(GROUP,%Closest%.Diff_contrib_risk_attr);
    Count_Diff_contrib_state_excl := COUNT(GROUP,%Closest%.Diff_contrib_state_excl);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
