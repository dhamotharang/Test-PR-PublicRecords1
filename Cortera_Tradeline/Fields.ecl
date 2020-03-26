IMPORT SALT311;
EXPORT Fields := MODULE

EXPORT NumFields := 13;

// Processing for each FieldType
EXPORT SALT311.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'numeric','number','date');
EXPORT FieldTypeNum(SALT311.StrType fn) := CASE(fn,'numeric' => 1,'number' => 2,'date' => 3,0);

EXPORT MakeFT_numeric(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_numeric(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_numeric(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_number(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789-'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_number(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789-'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) >= 1));
EXPORT InValidMessageFT_number(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789-'),SALT311.HygieneErrors.NotLength('0,1..'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_date(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_date(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 8));
EXPORT InValidMessageFT_date(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789'),SALT311.HygieneErrors.NotLength('0,8'),SALT311.HygieneErrors.Good);


EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'link_id','account_key','segment_id','ar_date','total_ar','current_ar','aging_1to30','aging_31to60','aging_61to90','aging_91plus','credit_limit','first_sale_date','last_sale_date');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'link_id','account_key','segment_id','ar_date','total_ar','current_ar','aging_1to30','aging_31to60','aging_61to90','aging_91plus','credit_limit','first_sale_date','last_sale_date');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'link_id' => 0,'account_key' => 1,'segment_id' => 2,'ar_date' => 3,'total_ar' => 4,'current_ar' => 5,'aging_1to30' => 6,'aging_31to60' => 7,'aging_61to90' => 8,'aging_91plus' => 9,'credit_limit' => 10,'first_sale_date' => 11,'last_sale_date' => 12,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['ALLOW'],[],[],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);

//Individual field level validation


EXPORT Make_link_id(SALT311.StrType s0) := MakeFT_numeric(s0);
EXPORT InValid_link_id(SALT311.StrType s) := InValidFT_numeric(s);
EXPORT InValidMessage_link_id(UNSIGNED1 wh) := InValidMessageFT_numeric(wh);


EXPORT Make_account_key(SALT311.StrType s0) := s0;
EXPORT InValid_account_key(SALT311.StrType s) := 0;
EXPORT InValidMessage_account_key(UNSIGNED1 wh) := '';


EXPORT Make_segment_id(SALT311.StrType s0) := s0;
EXPORT InValid_segment_id(SALT311.StrType s) := 0;
EXPORT InValidMessage_segment_id(UNSIGNED1 wh) := '';


EXPORT Make_ar_date(SALT311.StrType s0) := MakeFT_date(s0);
EXPORT InValid_ar_date(SALT311.StrType s) := InValidFT_date(s);
EXPORT InValidMessage_ar_date(UNSIGNED1 wh) := InValidMessageFT_date(wh);


EXPORT Make_total_ar(SALT311.StrType s0) := MakeFT_number(s0);
EXPORT InValid_total_ar(SALT311.StrType s) := InValidFT_number(s);
EXPORT InValidMessage_total_ar(UNSIGNED1 wh) := InValidMessageFT_number(wh);


EXPORT Make_current_ar(SALT311.StrType s0) := MakeFT_number(s0);
EXPORT InValid_current_ar(SALT311.StrType s) := InValidFT_number(s);
EXPORT InValidMessage_current_ar(UNSIGNED1 wh) := InValidMessageFT_number(wh);


EXPORT Make_aging_1to30(SALT311.StrType s0) := MakeFT_number(s0);
EXPORT InValid_aging_1to30(SALT311.StrType s) := InValidFT_number(s);
EXPORT InValidMessage_aging_1to30(UNSIGNED1 wh) := InValidMessageFT_number(wh);


EXPORT Make_aging_31to60(SALT311.StrType s0) := MakeFT_number(s0);
EXPORT InValid_aging_31to60(SALT311.StrType s) := InValidFT_number(s);
EXPORT InValidMessage_aging_31to60(UNSIGNED1 wh) := InValidMessageFT_number(wh);


EXPORT Make_aging_61to90(SALT311.StrType s0) := MakeFT_number(s0);
EXPORT InValid_aging_61to90(SALT311.StrType s) := InValidFT_number(s);
EXPORT InValidMessage_aging_61to90(UNSIGNED1 wh) := InValidMessageFT_number(wh);


EXPORT Make_aging_91plus(SALT311.StrType s0) := MakeFT_number(s0);
EXPORT InValid_aging_91plus(SALT311.StrType s) := InValidFT_number(s);
EXPORT InValidMessage_aging_91plus(UNSIGNED1 wh) := InValidMessageFT_number(wh);


EXPORT Make_credit_limit(SALT311.StrType s0) := MakeFT_number(s0);
EXPORT InValid_credit_limit(SALT311.StrType s) := InValidFT_number(s);
EXPORT InValidMessage_credit_limit(UNSIGNED1 wh) := InValidMessageFT_number(wh);


EXPORT Make_first_sale_date(SALT311.StrType s0) := MakeFT_date(s0);
EXPORT InValid_first_sale_date(SALT311.StrType s) := InValidFT_date(s);
EXPORT InValidMessage_first_sale_date(UNSIGNED1 wh) := InValidMessageFT_date(wh);


EXPORT Make_last_sale_date(SALT311.StrType s0) := MakeFT_date(s0);
EXPORT InValid_last_sale_date(SALT311.StrType s) := InValidFT_date(s);
EXPORT InValidMessage_last_sale_date(UNSIGNED1 wh) := InValidMessageFT_date(wh);

// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT311,Cortera_Tradeline;
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
    BOOLEAN Diff_link_id;
    BOOLEAN Diff_account_key;
    BOOLEAN Diff_segment_id;
    BOOLEAN Diff_ar_date;
    BOOLEAN Diff_total_ar;
    BOOLEAN Diff_current_ar;
    BOOLEAN Diff_aging_1to30;
    BOOLEAN Diff_aging_31to60;
    BOOLEAN Diff_aging_61to90;
    BOOLEAN Diff_aging_91plus;
    BOOLEAN Diff_credit_limit;
    BOOLEAN Diff_first_sale_date;
    BOOLEAN Diff_last_sale_date;
    UNSIGNED Num_Diffs;
    SALT311.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_link_id := le.link_id <> ri.link_id;
    SELF.Diff_account_key := le.account_key <> ri.account_key;
    SELF.Diff_segment_id := le.segment_id <> ri.segment_id;
    SELF.Diff_ar_date := le.ar_date <> ri.ar_date;
    SELF.Diff_total_ar := le.total_ar <> ri.total_ar;
    SELF.Diff_current_ar := le.current_ar <> ri.current_ar;
    SELF.Diff_aging_1to30 := le.aging_1to30 <> ri.aging_1to30;
    SELF.Diff_aging_31to60 := le.aging_31to60 <> ri.aging_31to60;
    SELF.Diff_aging_61to90 := le.aging_61to90 <> ri.aging_61to90;
    SELF.Diff_aging_91plus := le.aging_91plus <> ri.aging_91plus;
    SELF.Diff_credit_limit := le.credit_limit <> ri.credit_limit;
    SELF.Diff_first_sale_date := le.first_sale_date <> ri.first_sale_date;
    SELF.Diff_last_sale_date := le.last_sale_date <> ri.last_sale_date;
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_link_id,1,0)+ IF( SELF.Diff_account_key,1,0)+ IF( SELF.Diff_segment_id,1,0)+ IF( SELF.Diff_ar_date,1,0)+ IF( SELF.Diff_total_ar,1,0)+ IF( SELF.Diff_current_ar,1,0)+ IF( SELF.Diff_aging_1to30,1,0)+ IF( SELF.Diff_aging_31to60,1,0)+ IF( SELF.Diff_aging_61to90,1,0)+ IF( SELF.Diff_aging_91plus,1,0)+ IF( SELF.Diff_credit_limit,1,0)+ IF( SELF.Diff_first_sale_date,1,0)+ IF( SELF.Diff_last_sale_date,1,0);
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
    Count_Diff_link_id := COUNT(GROUP,%Closest%.Diff_link_id);
    Count_Diff_account_key := COUNT(GROUP,%Closest%.Diff_account_key);
    Count_Diff_segment_id := COUNT(GROUP,%Closest%.Diff_segment_id);
    Count_Diff_ar_date := COUNT(GROUP,%Closest%.Diff_ar_date);
    Count_Diff_total_ar := COUNT(GROUP,%Closest%.Diff_total_ar);
    Count_Diff_current_ar := COUNT(GROUP,%Closest%.Diff_current_ar);
    Count_Diff_aging_1to30 := COUNT(GROUP,%Closest%.Diff_aging_1to30);
    Count_Diff_aging_31to60 := COUNT(GROUP,%Closest%.Diff_aging_31to60);
    Count_Diff_aging_61to90 := COUNT(GROUP,%Closest%.Diff_aging_61to90);
    Count_Diff_aging_91plus := COUNT(GROUP,%Closest%.Diff_aging_91plus);
    Count_Diff_credit_limit := COUNT(GROUP,%Closest%.Diff_credit_limit);
    Count_Diff_first_sale_date := COUNT(GROUP,%Closest%.Diff_first_sale_date);
    Count_Diff_last_sale_date := COUNT(GROUP,%Closest%.Diff_last_sale_date);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
