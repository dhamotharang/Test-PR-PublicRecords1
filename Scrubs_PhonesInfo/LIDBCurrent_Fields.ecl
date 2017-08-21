IMPORT ut,SALT33;
EXPORT LIDBCurrent_Fields := MODULE
// Processing for each FieldType
EXPORT SALT33.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'Invalid_RefID','Invalid_Num');
EXPORT FieldTypeNum(SALT33.StrType fn) := CASE(fn,'Invalid_RefID' => 1,'Invalid_Num' => 2,0);
EXPORT MakeFT_Invalid_RefID(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'MGP0123456789 '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_RefID(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'MGP0123456789 '))));
EXPORT InValidMessageFT_Invalid_RefID(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('MGP0123456789 '),SALT33.HygieneErrors.Good);
EXPORT MakeFT_Invalid_Num(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Num(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_Invalid_Num(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('0123456789'),SALT33.HygieneErrors.Good);
EXPORT SALT33.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'reference_id','phone');
EXPORT FieldNum(SALT33.StrType fn) := CASE(fn,'reference_id' => 0,'phone' => 1,0);
//Individual field level validation
EXPORT Make_reference_id(SALT33.StrType s0) := MakeFT_Invalid_RefID(s0);
EXPORT InValid_reference_id(SALT33.StrType s) := InValidFT_Invalid_RefID(s);
EXPORT InValidMessage_reference_id(UNSIGNED1 wh) := InValidMessageFT_Invalid_RefID(wh);
EXPORT Make_phone(SALT33.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_phone(SALT33.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_phone(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT33,Scrubs_PhonesInfo;
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
    BOOLEAN Diff_reference_id;
    BOOLEAN Diff_phone;
    UNSIGNED Num_Diffs;
    SALT33.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_reference_id := le.reference_id <> ri.reference_id;
    SELF.Diff_phone := le.phone <> ri.phone;
    SELF.Val := (SALT33.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_reference_id,1,0)+ IF( SELF.Diff_phone,1,0);
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
    Count_Diff_reference_id := COUNT(GROUP,%Closest%.Diff_reference_id);
    Count_Diff_phone := COUNT(GROUP,%Closest%.Diff_phone);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
