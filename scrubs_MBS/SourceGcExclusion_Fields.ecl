﻿IMPORT SALT37;
EXPORT SourceGcExclusion_Fields := MODULE
 
// Processing for each FieldType
EXPORT SALT37.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_alpha','invalid_alphanumeric','invalid_date','invalid_numeric');
EXPORT FieldTypeNum(SALT37.StrType fn) := CASE(fn,'invalid_alpha' => 1,'invalid_alphanumeric' => 2,'invalid_date' => 3,'invalid_numeric' => 4,0);
 
EXPORT MakeFT_invalid_alpha(SALT37.StrType s0) := FUNCTION
  s1 := SALT37.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_alpha(SALT37.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT37.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) >= 4));
EXPORT InValidMessageFT_invalid_alpha(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'),SALT37.HygieneErrors.NotLength('0,4..'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_alphanumeric(SALT37.StrType s0) := FUNCTION
  s1 := SALT37.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 <>{}[]-^=\'!+&,./#()_'); // Only allow valid symbols
  s2 := SALT37.stringcleanspaces( SALT37.stringsubstituteout(s1,' <>{}[]-^=\'!+&,./#()_',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_alphanumeric(SALT37.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT37.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 <>{}[]-^=\'!+&,./#()_'))));
EXPORT InValidMessageFT_invalid_alphanumeric(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 <>{}[]-^=\'!+&,./#()_'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_date(SALT37.StrType s0) := FUNCTION
  s1 := SALT37.stringfilter(s0,'0123456789 -:'); // Only allow valid symbols
  s2 := SALT37.stringcleanspaces( SALT37.stringsubstituteout(s1,' -:',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_date(SALT37.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT37.StringFilter(s,'0123456789 -:'))));
EXPORT InValidMessageFT_invalid_date(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotInChars('0123456789 -:'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_numeric(SALT37.StrType s0) := FUNCTION
  s1 := SALT37.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_numeric(SALT37.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT37.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_invalid_numeric(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotInChars('0123456789'),SALT37.HygieneErrors.Good);
 
EXPORT SALT37.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'gc_id','product_id','company_id','status','date_added','user_added','date_changed','user_changed');
EXPORT FieldNum(SALT37.StrType fn) := CASE(fn,'gc_id' => 0,'product_id' => 1,'company_id' => 2,'status' => 3,'date_added' => 4,'user_added' => 5,'date_changed' => 6,'user_changed' => 7,0);
 
//Individual field level validation
 
EXPORT Make_gc_id(SALT37.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_gc_id(SALT37.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_gc_id(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_product_id(SALT37.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_product_id(SALT37.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_product_id(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_company_id(SALT37.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_company_id(SALT37.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_company_id(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_status(SALT37.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_status(SALT37.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_status(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_date_added(SALT37.StrType s0) := s0;
EXPORT InValid_date_added(SALT37.StrType s) := 0;
EXPORT InValidMessage_date_added(UNSIGNED1 wh) := '';
 
EXPORT Make_user_added(SALT37.StrType s0) := s0;
EXPORT InValid_user_added(SALT37.StrType s) := 0;
EXPORT InValidMessage_user_added(UNSIGNED1 wh) := '';
 
EXPORT Make_date_changed(SALT37.StrType s0) := s0;
EXPORT InValid_date_changed(SALT37.StrType s) := 0;
EXPORT InValidMessage_date_changed(UNSIGNED1 wh) := '';
 
EXPORT Make_user_changed(SALT37.StrType s0) := s0;
EXPORT InValid_user_changed(SALT37.StrType s) := 0;
EXPORT InValidMessage_user_changed(UNSIGNED1 wh) := '';
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT37,Scrubs_MBS;
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
    BOOLEAN Diff_gc_id;
    BOOLEAN Diff_product_id;
    BOOLEAN Diff_company_id;
    BOOLEAN Diff_status;
    BOOLEAN Diff_date_added;
    BOOLEAN Diff_user_added;
    BOOLEAN Diff_date_changed;
    BOOLEAN Diff_user_changed;
    UNSIGNED Num_Diffs;
    SALT37.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_gc_id := le.gc_id <> ri.gc_id;
    SELF.Diff_product_id := le.product_id <> ri.product_id;
    SELF.Diff_company_id := le.company_id <> ri.company_id;
    SELF.Diff_status := le.status <> ri.status;
    SELF.Diff_date_added := le.date_added <> ri.date_added;
    SELF.Diff_user_added := le.user_added <> ri.user_added;
    SELF.Diff_date_changed := le.date_changed <> ri.date_changed;
    SELF.Diff_user_changed := le.user_changed <> ri.user_changed;
    SELF.Val := (SALT37.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_gc_id,1,0)+ IF( SELF.Diff_product_id,1,0)+ IF( SELF.Diff_company_id,1,0)+ IF( SELF.Diff_status,1,0)+ IF( SELF.Diff_date_added,1,0)+ IF( SELF.Diff_user_added,1,0)+ IF( SELF.Diff_date_changed,1,0)+ IF( SELF.Diff_user_changed,1,0);
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
    Count_Diff_gc_id := COUNT(GROUP,%Closest%.Diff_gc_id);
    Count_Diff_product_id := COUNT(GROUP,%Closest%.Diff_product_id);
    Count_Diff_company_id := COUNT(GROUP,%Closest%.Diff_company_id);
    Count_Diff_status := COUNT(GROUP,%Closest%.Diff_status);
    Count_Diff_date_added := COUNT(GROUP,%Closest%.Diff_date_added);
    Count_Diff_user_added := COUNT(GROUP,%Closest%.Diff_user_added);
    Count_Diff_date_changed := COUNT(GROUP,%Closest%.Diff_date_changed);
    Count_Diff_user_changed := COUNT(GROUP,%Closest%.Diff_user_changed);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
