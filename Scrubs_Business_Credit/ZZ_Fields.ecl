IMPORT ut,SALT33;
EXPORT ZZ_Fields := MODULE
// Processing for each FieldType
EXPORT SALT33.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_segment_identifier','invalid_zz_file_sequence_number','invalid_parent_sequence_number','invalid_total_ab_segments','invalid_total_segments','invalid_sum_of_balance_amounts');
EXPORT FieldTypeNum(SALT33.StrType fn) := CASE(fn,'invalid_segment_identifier' => 1,'invalid_zz_file_sequence_number' => 2,'invalid_parent_sequence_number' => 3,'invalid_total_ab_segments' => 4,'invalid_total_segments' => 5,'invalid_sum_of_balance_amounts' => 6,0);
EXPORT MakeFT_invalid_segment_identifier(SALT33.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_segment_identifier(SALT33.StrType s) := WHICH(((SALT33.StrType) s) NOT IN ['ZZ','ZZ']);
EXPORT InValidMessageFT_invalid_segment_identifier(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInEnum('ZZ|ZZ'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_zz_file_sequence_number(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_zz_file_sequence_number(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) >= 1));
EXPORT InValidMessageFT_invalid_zz_file_sequence_number(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('0123456789'),SALT33.HygieneErrors.NotLength('1..'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_parent_sequence_number(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_parent_sequence_number(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) >= 1));
EXPORT InValidMessageFT_invalid_parent_sequence_number(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('0123456789'),SALT33.HygieneErrors.NotLength('1..'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_total_ab_segments(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_total_ab_segments(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) >= 1));
EXPORT InValidMessageFT_invalid_total_ab_segments(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('0123456789'),SALT33.HygieneErrors.NotLength('1..'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_total_segments(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_total_segments(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_invalid_total_segments(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('0123456789'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_sum_of_balance_amounts(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'-0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_sum_of_balance_amounts(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'-0123456789'))),~(LENGTH(TRIM(s)) >= 1));
EXPORT InValidMessageFT_invalid_sum_of_balance_amounts(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('-0123456789'),SALT33.HygieneErrors.NotLength('1..'),SALT33.HygieneErrors.Good);
EXPORT SALT33.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'segment_identifier','file_sequence_number','parent_sequence_number','total_ab_segments','total_ma_segments','total_ad_segments','total_pn_segments','total_ti_segments','total_is_segments','total_bs_segments','total_bi_segments','total_cl_segments','total_ms_segments','total_ah_segments','sum_of_balance_amounts');
EXPORT FieldNum(SALT33.StrType fn) := CASE(fn,'segment_identifier' => 0,'file_sequence_number' => 1,'parent_sequence_number' => 2,'total_ab_segments' => 3,'total_ma_segments' => 4,'total_ad_segments' => 5,'total_pn_segments' => 6,'total_ti_segments' => 7,'total_is_segments' => 8,'total_bs_segments' => 9,'total_bi_segments' => 10,'total_cl_segments' => 11,'total_ms_segments' => 12,'total_ah_segments' => 13,'sum_of_balance_amounts' => 14,0);
//Individual field level validation
EXPORT Make_segment_identifier(SALT33.StrType s0) := MakeFT_invalid_segment_identifier(s0);
EXPORT InValid_segment_identifier(SALT33.StrType s) := InValidFT_invalid_segment_identifier(s);
EXPORT InValidMessage_segment_identifier(UNSIGNED1 wh) := InValidMessageFT_invalid_segment_identifier(wh);
EXPORT Make_file_sequence_number(SALT33.StrType s0) := MakeFT_invalid_zz_file_sequence_number(s0);
EXPORT InValid_file_sequence_number(SALT33.StrType s) := InValidFT_invalid_zz_file_sequence_number(s);
EXPORT InValidMessage_file_sequence_number(UNSIGNED1 wh) := InValidMessageFT_invalid_zz_file_sequence_number(wh);
EXPORT Make_parent_sequence_number(SALT33.StrType s0) := MakeFT_invalid_parent_sequence_number(s0);
EXPORT InValid_parent_sequence_number(SALT33.StrType s) := InValidFT_invalid_parent_sequence_number(s);
EXPORT InValidMessage_parent_sequence_number(UNSIGNED1 wh) := InValidMessageFT_invalid_parent_sequence_number(wh);
EXPORT Make_total_ab_segments(SALT33.StrType s0) := MakeFT_invalid_total_ab_segments(s0);
EXPORT InValid_total_ab_segments(SALT33.StrType s) := InValidFT_invalid_total_ab_segments(s);
EXPORT InValidMessage_total_ab_segments(UNSIGNED1 wh) := InValidMessageFT_invalid_total_ab_segments(wh);
EXPORT Make_total_ma_segments(SALT33.StrType s0) := MakeFT_invalid_total_segments(s0);
EXPORT InValid_total_ma_segments(SALT33.StrType s) := InValidFT_invalid_total_segments(s);
EXPORT InValidMessage_total_ma_segments(UNSIGNED1 wh) := InValidMessageFT_invalid_total_segments(wh);
EXPORT Make_total_ad_segments(SALT33.StrType s0) := MakeFT_invalid_total_segments(s0);
EXPORT InValid_total_ad_segments(SALT33.StrType s) := InValidFT_invalid_total_segments(s);
EXPORT InValidMessage_total_ad_segments(UNSIGNED1 wh) := InValidMessageFT_invalid_total_segments(wh);
EXPORT Make_total_pn_segments(SALT33.StrType s0) := MakeFT_invalid_total_segments(s0);
EXPORT InValid_total_pn_segments(SALT33.StrType s) := InValidFT_invalid_total_segments(s);
EXPORT InValidMessage_total_pn_segments(UNSIGNED1 wh) := InValidMessageFT_invalid_total_segments(wh);
EXPORT Make_total_ti_segments(SALT33.StrType s0) := MakeFT_invalid_total_segments(s0);
EXPORT InValid_total_ti_segments(SALT33.StrType s) := InValidFT_invalid_total_segments(s);
EXPORT InValidMessage_total_ti_segments(UNSIGNED1 wh) := InValidMessageFT_invalid_total_segments(wh);
EXPORT Make_total_is_segments(SALT33.StrType s0) := MakeFT_invalid_total_segments(s0);
EXPORT InValid_total_is_segments(SALT33.StrType s) := InValidFT_invalid_total_segments(s);
EXPORT InValidMessage_total_is_segments(UNSIGNED1 wh) := InValidMessageFT_invalid_total_segments(wh);
EXPORT Make_total_bs_segments(SALT33.StrType s0) := MakeFT_invalid_total_segments(s0);
EXPORT InValid_total_bs_segments(SALT33.StrType s) := InValidFT_invalid_total_segments(s);
EXPORT InValidMessage_total_bs_segments(UNSIGNED1 wh) := InValidMessageFT_invalid_total_segments(wh);
EXPORT Make_total_bi_segments(SALT33.StrType s0) := MakeFT_invalid_total_segments(s0);
EXPORT InValid_total_bi_segments(SALT33.StrType s) := InValidFT_invalid_total_segments(s);
EXPORT InValidMessage_total_bi_segments(UNSIGNED1 wh) := InValidMessageFT_invalid_total_segments(wh);
EXPORT Make_total_cl_segments(SALT33.StrType s0) := MakeFT_invalid_total_segments(s0);
EXPORT InValid_total_cl_segments(SALT33.StrType s) := InValidFT_invalid_total_segments(s);
EXPORT InValidMessage_total_cl_segments(UNSIGNED1 wh) := InValidMessageFT_invalid_total_segments(wh);
EXPORT Make_total_ms_segments(SALT33.StrType s0) := MakeFT_invalid_total_segments(s0);
EXPORT InValid_total_ms_segments(SALT33.StrType s) := InValidFT_invalid_total_segments(s);
EXPORT InValidMessage_total_ms_segments(UNSIGNED1 wh) := InValidMessageFT_invalid_total_segments(wh);
EXPORT Make_total_ah_segments(SALT33.StrType s0) := MakeFT_invalid_total_segments(s0);
EXPORT InValid_total_ah_segments(SALT33.StrType s) := InValidFT_invalid_total_segments(s);
EXPORT InValidMessage_total_ah_segments(UNSIGNED1 wh) := InValidMessageFT_invalid_total_segments(wh);
EXPORT Make_sum_of_balance_amounts(SALT33.StrType s0) := MakeFT_invalid_sum_of_balance_amounts(s0);
EXPORT InValid_sum_of_balance_amounts(SALT33.StrType s) := InValidFT_invalid_sum_of_balance_amounts(s);
EXPORT InValidMessage_sum_of_balance_amounts(UNSIGNED1 wh) := InValidMessageFT_invalid_sum_of_balance_amounts(wh);
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT33,Scrubs_Business_Credit;
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
    BOOLEAN Diff_segment_identifier;
    BOOLEAN Diff_file_sequence_number;
    BOOLEAN Diff_parent_sequence_number;
    BOOLEAN Diff_total_ab_segments;
    BOOLEAN Diff_total_ma_segments;
    BOOLEAN Diff_total_ad_segments;
    BOOLEAN Diff_total_pn_segments;
    BOOLEAN Diff_total_ti_segments;
    BOOLEAN Diff_total_is_segments;
    BOOLEAN Diff_total_bs_segments;
    BOOLEAN Diff_total_bi_segments;
    BOOLEAN Diff_total_cl_segments;
    BOOLEAN Diff_total_ms_segments;
    BOOLEAN Diff_total_ah_segments;
    BOOLEAN Diff_sum_of_balance_amounts;
    UNSIGNED Num_Diffs;
    SALT33.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_segment_identifier := le.segment_identifier <> ri.segment_identifier;
    SELF.Diff_file_sequence_number := le.file_sequence_number <> ri.file_sequence_number;
    SELF.Diff_parent_sequence_number := le.parent_sequence_number <> ri.parent_sequence_number;
    SELF.Diff_total_ab_segments := le.total_ab_segments <> ri.total_ab_segments;
    SELF.Diff_total_ma_segments := le.total_ma_segments <> ri.total_ma_segments;
    SELF.Diff_total_ad_segments := le.total_ad_segments <> ri.total_ad_segments;
    SELF.Diff_total_pn_segments := le.total_pn_segments <> ri.total_pn_segments;
    SELF.Diff_total_ti_segments := le.total_ti_segments <> ri.total_ti_segments;
    SELF.Diff_total_is_segments := le.total_is_segments <> ri.total_is_segments;
    SELF.Diff_total_bs_segments := le.total_bs_segments <> ri.total_bs_segments;
    SELF.Diff_total_bi_segments := le.total_bi_segments <> ri.total_bi_segments;
    SELF.Diff_total_cl_segments := le.total_cl_segments <> ri.total_cl_segments;
    SELF.Diff_total_ms_segments := le.total_ms_segments <> ri.total_ms_segments;
    SELF.Diff_total_ah_segments := le.total_ah_segments <> ri.total_ah_segments;
    SELF.Diff_sum_of_balance_amounts := le.sum_of_balance_amounts <> ri.sum_of_balance_amounts;
    SELF.Val := (SALT33.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_segment_identifier,1,0)+ IF( SELF.Diff_file_sequence_number,1,0)+ IF( SELF.Diff_parent_sequence_number,1,0)+ IF( SELF.Diff_total_ab_segments,1,0)+ IF( SELF.Diff_total_ma_segments,1,0)+ IF( SELF.Diff_total_ad_segments,1,0)+ IF( SELF.Diff_total_pn_segments,1,0)+ IF( SELF.Diff_total_ti_segments,1,0)+ IF( SELF.Diff_total_is_segments,1,0)+ IF( SELF.Diff_total_bs_segments,1,0)+ IF( SELF.Diff_total_bi_segments,1,0)+ IF( SELF.Diff_total_cl_segments,1,0)+ IF( SELF.Diff_total_ms_segments,1,0)+ IF( SELF.Diff_total_ah_segments,1,0)+ IF( SELF.Diff_sum_of_balance_amounts,1,0);
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
    Count_Diff_segment_identifier := COUNT(GROUP,%Closest%.Diff_segment_identifier);
    Count_Diff_file_sequence_number := COUNT(GROUP,%Closest%.Diff_file_sequence_number);
    Count_Diff_parent_sequence_number := COUNT(GROUP,%Closest%.Diff_parent_sequence_number);
    Count_Diff_total_ab_segments := COUNT(GROUP,%Closest%.Diff_total_ab_segments);
    Count_Diff_total_ma_segments := COUNT(GROUP,%Closest%.Diff_total_ma_segments);
    Count_Diff_total_ad_segments := COUNT(GROUP,%Closest%.Diff_total_ad_segments);
    Count_Diff_total_pn_segments := COUNT(GROUP,%Closest%.Diff_total_pn_segments);
    Count_Diff_total_ti_segments := COUNT(GROUP,%Closest%.Diff_total_ti_segments);
    Count_Diff_total_is_segments := COUNT(GROUP,%Closest%.Diff_total_is_segments);
    Count_Diff_total_bs_segments := COUNT(GROUP,%Closest%.Diff_total_bs_segments);
    Count_Diff_total_bi_segments := COUNT(GROUP,%Closest%.Diff_total_bi_segments);
    Count_Diff_total_cl_segments := COUNT(GROUP,%Closest%.Diff_total_cl_segments);
    Count_Diff_total_ms_segments := COUNT(GROUP,%Closest%.Diff_total_ms_segments);
    Count_Diff_total_ah_segments := COUNT(GROUP,%Closest%.Diff_total_ah_segments);
    Count_Diff_sum_of_balance_amounts := COUNT(GROUP,%Closest%.Diff_sum_of_balance_amounts);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
