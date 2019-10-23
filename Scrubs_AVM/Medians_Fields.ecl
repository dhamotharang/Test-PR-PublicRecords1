IMPORT SALT38;
IMPORT Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT Medians_Fields := MODULE
 
EXPORT NumFields := 5;
 
// Processing for each FieldType
EXPORT SALT38.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'Invalid_Date','Invalid_AlphaNum','Invalid_Chars','Invalid_Alpha','Invalid_Num');
EXPORT FieldTypeNum(SALT38.StrType fn) := CASE(fn,'Invalid_Date' => 1,'Invalid_AlphaNum' => 2,'Invalid_Chars' => 3,'Invalid_Alpha' => 4,'Invalid_Num' => 5,0);
 
EXPORT MakeFT_Invalid_Date(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_Date(SALT38.StrType s) := WHICH(~Scrubs.fn_valid_date(s)>0);
EXPORT InValidMessageFT_Invalid_Date(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs.fn_valid_date'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_AlphaNum(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_AlphaNum(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789'))));
EXPORT InValidMessageFT_Invalid_AlphaNum(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Chars(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 .+'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Chars(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 .+'))));
EXPORT InValidMessageFT_Invalid_Chars(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 .+'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Alpha(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Alpha(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'))));
EXPORT InValidMessageFT_Invalid_Alpha(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Num(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Num(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_Invalid_Num(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('0123456789'),SALT38.HygieneErrors.Good);
 
EXPORT SALT38.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'history_date','fips_geo_12','median_valuation','history_history_date','history_median_valuation');
EXPORT SALT38.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'history_date','fips_geo_12','median_valuation','history_history_date','history_median_valuation');
EXPORT FieldNum(SALT38.StrType fn) := CASE(fn,'history_date' => 0,'fips_geo_12' => 1,'median_valuation' => 2,'history_history_date' => 3,'history_median_valuation' => 4,0);
EXPORT SET OF SALT38.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['CUSTOM'],['ALLOW'],['ALLOW'],['CUSTOM'],['ALLOW'],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_history_date(SALT38.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_history_date(SALT38.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_history_date(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_fips_geo_12(SALT38.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_fips_geo_12(SALT38.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_fips_geo_12(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_median_valuation(SALT38.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_median_valuation(SALT38.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_median_valuation(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_history_history_date(SALT38.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_history_history_date(SALT38.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_history_history_date(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_history_median_valuation(SALT38.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_history_median_valuation(SALT38.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_history_median_valuation(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT38,Scrubs_AVM;
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
    BOOLEAN Diff_history_date;
    BOOLEAN Diff_fips_geo_12;
    BOOLEAN Diff_median_valuation;
    BOOLEAN Diff_history_history_date;
    BOOLEAN Diff_history_median_valuation;
    UNSIGNED Num_Diffs;
    SALT38.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_history_date := le.history_date <> ri.history_date;
    SELF.Diff_fips_geo_12 := le.fips_geo_12 <> ri.fips_geo_12;
    SELF.Diff_median_valuation := le.median_valuation <> ri.median_valuation;
    SELF.Diff_history_history_date := le.history_history_date <> ri.history_history_date;
    SELF.Diff_history_median_valuation := le.history_median_valuation <> ri.history_median_valuation;
    SELF.Val := (SALT38.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_history_date,1,0)+ IF( SELF.Diff_fips_geo_12,1,0)+ IF( SELF.Diff_median_valuation,1,0)+ IF( SELF.Diff_history_history_date,1,0)+ IF( SELF.Diff_history_median_valuation,1,0);
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
    Count_Diff_history_date := COUNT(GROUP,%Closest%.Diff_history_date);
    Count_Diff_fips_geo_12 := COUNT(GROUP,%Closest%.Diff_fips_geo_12);
    Count_Diff_median_valuation := COUNT(GROUP,%Closest%.Diff_median_valuation);
    Count_Diff_history_history_date := COUNT(GROUP,%Closest%.Diff_history_history_date);
    Count_Diff_history_median_valuation := COUNT(GROUP,%Closest%.Diff_history_median_valuation);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
