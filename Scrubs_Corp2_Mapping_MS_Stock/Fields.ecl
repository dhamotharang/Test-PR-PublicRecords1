IMPORT ut,SALT34;
EXPORT Fields := MODULE
 
// Processing for each FieldType
EXPORT SALT34.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_corp_key','invalid_stock_class');
EXPORT FieldTypeNum(SALT34.StrType fn) := CASE(fn,'invalid_corp_key' => 1,'invalid_stock_class' => 2,0);
 
EXPORT MakeFT_invalid_corp_key(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,'0123456789-'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_corp_key(SALT34.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,'0123456789-'))),~(LENGTH(TRIM(s)) >= 4));
EXPORT InValidMessageFT_invalid_corp_key(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotInChars('0123456789-'),SALT34.HygieneErrors.NotLength('4..'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_stock_class(SALT34.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_stock_class(SALT34.StrType s) := WHICH(((SALT34.StrType) s) NOT IN ['COMMON','COMMON NON-VOTING','COMMON A','COMMON A NON-VOTING','COMMON B','COMMON B NON-VOTING','COMMON C','COMMON C NON-VOTING','PREFERRED','PREFERRED A','PREFERRED B','OTHER',' ']);
EXPORT InValidMessageFT_invalid_stock_class(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotInEnum('COMMON|COMMON NON-VOTING|COMMON A|COMMON A NON-VOTING|COMMON B|COMMON B NON-VOTING|COMMON C|COMMON C NON-VOTING|PREFERRED|PREFERRED A|PREFERRED B|OTHER| '),SALT34.HygieneErrors.Good);
 
EXPORT SALT34.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'corp_key','stock_class');
EXPORT FieldNum(SALT34.StrType fn) := CASE(fn,'corp_key' => 0,'stock_class' => 1,0);
 
//Individual field level validation
 
EXPORT Make_corp_key(SALT34.StrType s0) := MakeFT_invalid_corp_key(s0);
EXPORT InValid_corp_key(SALT34.StrType s) := InValidFT_invalid_corp_key(s);
EXPORT InValidMessage_corp_key(UNSIGNED1 wh) := InValidMessageFT_invalid_corp_key(wh);
 
EXPORT Make_stock_class(SALT34.StrType s0) := MakeFT_invalid_stock_class(s0);
EXPORT InValid_stock_class(SALT34.StrType s) := InValidFT_invalid_stock_class(s);
EXPORT InValidMessage_stock_class(UNSIGNED1 wh) := InValidMessageFT_invalid_stock_class(wh);
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT34,Scrubs_Corp2_Mapping_MS_Stock;
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
    BOOLEAN Diff_corp_key;
    BOOLEAN Diff_stock_class;
    UNSIGNED Num_Diffs;
    SALT34.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_corp_key := le.corp_key <> ri.corp_key;
    SELF.Diff_stock_class := le.stock_class <> ri.stock_class;
    SELF.Val := (SALT34.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_corp_key,1,0)+ IF( SELF.Diff_stock_class,1,0);
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
    Count_Diff_corp_key := COUNT(GROUP,%Closest%.Diff_corp_key);
    Count_Diff_stock_class := COUNT(GROUP,%Closest%.Diff_stock_class);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
