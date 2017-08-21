IMPORT ut,SALT33;
EXPORT input_Fields := MODULE
// Processing for each FieldType
EXPORT SALT33.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'Invalid_Pin','Invalid_Num','Invalid_Type','Invalid_Source');
EXPORT FieldTypeNum(SALT33.StrType fn) := CASE(fn,'Invalid_Pin' => 1,'Invalid_Num' => 2,'Invalid_Type' => 3,'Invalid_Source' => 4,0);
EXPORT MakeFT_Invalid_Pin(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Pin(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'))));
EXPORT InValidMessageFT_Invalid_Pin(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_Invalid_Num(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Num(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'0123456789 '))));
EXPORT InValidMessageFT_Invalid_Num(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('0123456789 '),SALT33.HygieneErrors.Good);
EXPORT MakeFT_Invalid_Type(SALT33.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_Type(SALT33.StrType s) := WHICH(((SALT33.StrType) s) NOT IN ['C','N',' ']);
EXPORT InValidMessageFT_Invalid_Type(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInEnum('C|N| '),SALT33.HygieneErrors.Good);
EXPORT MakeFT_Invalid_Source(SALT33.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_Source(SALT33.StrType s) := WHICH(((SALT33.StrType) s) NOT IN ['S','P',' ']);
EXPORT InValidMessageFT_Invalid_Source(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInEnum('S|P| '),SALT33.HygieneErrors.Good);
EXPORT SALT33.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'encrypted_experian_pin','phone_1_digits','phone_1_type','phone_1_source','phone_1_last_updt','phone_2_digits','phone_2_type','phone_2_source','phone_2_last_updt','phone_3_digits','phone_3_type','phone_3_source','phone_3_last_updt','filler','crlf');
EXPORT FieldNum(SALT33.StrType fn) := CASE(fn,'encrypted_experian_pin' => 0,'phone_1_digits' => 1,'phone_1_type' => 2,'phone_1_source' => 3,'phone_1_last_updt' => 4,'phone_2_digits' => 5,'phone_2_type' => 6,'phone_2_source' => 7,'phone_2_last_updt' => 8,'phone_3_digits' => 9,'phone_3_type' => 10,'phone_3_source' => 11,'phone_3_last_updt' => 12,'filler' => 13,'crlf' => 14,0);
//Individual field level validation
EXPORT Make_encrypted_experian_pin(SALT33.StrType s0) := MakeFT_Invalid_Pin(s0);
EXPORT InValid_encrypted_experian_pin(SALT33.StrType s) := InValidFT_Invalid_Pin(s);
EXPORT InValidMessage_encrypted_experian_pin(UNSIGNED1 wh) := InValidMessageFT_Invalid_Pin(wh);
EXPORT Make_phone_1_digits(SALT33.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_phone_1_digits(SALT33.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_phone_1_digits(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
EXPORT Make_phone_1_type(SALT33.StrType s0) := MakeFT_Invalid_Type(s0);
EXPORT InValid_phone_1_type(SALT33.StrType s) := InValidFT_Invalid_Type(s);
EXPORT InValidMessage_phone_1_type(UNSIGNED1 wh) := InValidMessageFT_Invalid_Type(wh);
EXPORT Make_phone_1_source(SALT33.StrType s0) := MakeFT_Invalid_Source(s0);
EXPORT InValid_phone_1_source(SALT33.StrType s) := InValidFT_Invalid_Source(s);
EXPORT InValidMessage_phone_1_source(UNSIGNED1 wh) := InValidMessageFT_Invalid_Source(wh);
EXPORT Make_phone_1_last_updt(SALT33.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_phone_1_last_updt(SALT33.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_phone_1_last_updt(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
EXPORT Make_phone_2_digits(SALT33.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_phone_2_digits(SALT33.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_phone_2_digits(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
EXPORT Make_phone_2_type(SALT33.StrType s0) := MakeFT_Invalid_Type(s0);
EXPORT InValid_phone_2_type(SALT33.StrType s) := InValidFT_Invalid_Type(s);
EXPORT InValidMessage_phone_2_type(UNSIGNED1 wh) := InValidMessageFT_Invalid_Type(wh);
EXPORT Make_phone_2_source(SALT33.StrType s0) := MakeFT_Invalid_Source(s0);
EXPORT InValid_phone_2_source(SALT33.StrType s) := InValidFT_Invalid_Source(s);
EXPORT InValidMessage_phone_2_source(UNSIGNED1 wh) := InValidMessageFT_Invalid_Source(wh);
EXPORT Make_phone_2_last_updt(SALT33.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_phone_2_last_updt(SALT33.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_phone_2_last_updt(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
EXPORT Make_phone_3_digits(SALT33.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_phone_3_digits(SALT33.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_phone_3_digits(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
EXPORT Make_phone_3_type(SALT33.StrType s0) := MakeFT_Invalid_Type(s0);
EXPORT InValid_phone_3_type(SALT33.StrType s) := InValidFT_Invalid_Type(s);
EXPORT InValidMessage_phone_3_type(UNSIGNED1 wh) := InValidMessageFT_Invalid_Type(wh);
EXPORT Make_phone_3_source(SALT33.StrType s0) := MakeFT_Invalid_Source(s0);
EXPORT InValid_phone_3_source(SALT33.StrType s) := InValidFT_Invalid_Source(s);
EXPORT InValidMessage_phone_3_source(UNSIGNED1 wh) := InValidMessageFT_Invalid_Source(wh);
EXPORT Make_phone_3_last_updt(SALT33.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_phone_3_last_updt(SALT33.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_phone_3_last_updt(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
EXPORT Make_filler(SALT33.StrType s0) := s0;
EXPORT InValid_filler(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_filler(UNSIGNED1 wh) := '';
EXPORT Make_crlf(SALT33.StrType s0) := s0;
EXPORT InValid_crlf(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_crlf(UNSIGNED1 wh) := '';
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT33,Scrubs_Experian_Phones;
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
    BOOLEAN Diff_encrypted_experian_pin;
    BOOLEAN Diff_phone_1_digits;
    BOOLEAN Diff_phone_1_type;
    BOOLEAN Diff_phone_1_source;
    BOOLEAN Diff_phone_1_last_updt;
    BOOLEAN Diff_phone_2_digits;
    BOOLEAN Diff_phone_2_type;
    BOOLEAN Diff_phone_2_source;
    BOOLEAN Diff_phone_2_last_updt;
    BOOLEAN Diff_phone_3_digits;
    BOOLEAN Diff_phone_3_type;
    BOOLEAN Diff_phone_3_source;
    BOOLEAN Diff_phone_3_last_updt;
    BOOLEAN Diff_filler;
    BOOLEAN Diff_crlf;
    UNSIGNED Num_Diffs;
    SALT33.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_encrypted_experian_pin := le.encrypted_experian_pin <> ri.encrypted_experian_pin;
    SELF.Diff_phone_1_digits := le.phone_1_digits <> ri.phone_1_digits;
    SELF.Diff_phone_1_type := le.phone_1_type <> ri.phone_1_type;
    SELF.Diff_phone_1_source := le.phone_1_source <> ri.phone_1_source;
    SELF.Diff_phone_1_last_updt := le.phone_1_last_updt <> ri.phone_1_last_updt;
    SELF.Diff_phone_2_digits := le.phone_2_digits <> ri.phone_2_digits;
    SELF.Diff_phone_2_type := le.phone_2_type <> ri.phone_2_type;
    SELF.Diff_phone_2_source := le.phone_2_source <> ri.phone_2_source;
    SELF.Diff_phone_2_last_updt := le.phone_2_last_updt <> ri.phone_2_last_updt;
    SELF.Diff_phone_3_digits := le.phone_3_digits <> ri.phone_3_digits;
    SELF.Diff_phone_3_type := le.phone_3_type <> ri.phone_3_type;
    SELF.Diff_phone_3_source := le.phone_3_source <> ri.phone_3_source;
    SELF.Diff_phone_3_last_updt := le.phone_3_last_updt <> ri.phone_3_last_updt;
    SELF.Diff_filler := le.filler <> ri.filler;
    SELF.Diff_crlf := le.crlf <> ri.crlf;
    SELF.Val := (SALT33.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_encrypted_experian_pin,1,0)+ IF( SELF.Diff_phone_1_digits,1,0)+ IF( SELF.Diff_phone_1_type,1,0)+ IF( SELF.Diff_phone_1_source,1,0)+ IF( SELF.Diff_phone_1_last_updt,1,0)+ IF( SELF.Diff_phone_2_digits,1,0)+ IF( SELF.Diff_phone_2_type,1,0)+ IF( SELF.Diff_phone_2_source,1,0)+ IF( SELF.Diff_phone_2_last_updt,1,0)+ IF( SELF.Diff_phone_3_digits,1,0)+ IF( SELF.Diff_phone_3_type,1,0)+ IF( SELF.Diff_phone_3_source,1,0)+ IF( SELF.Diff_phone_3_last_updt,1,0)+ IF( SELF.Diff_filler,1,0)+ IF( SELF.Diff_crlf,1,0);
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
    Count_Diff_encrypted_experian_pin := COUNT(GROUP,%Closest%.Diff_encrypted_experian_pin);
    Count_Diff_phone_1_digits := COUNT(GROUP,%Closest%.Diff_phone_1_digits);
    Count_Diff_phone_1_type := COUNT(GROUP,%Closest%.Diff_phone_1_type);
    Count_Diff_phone_1_source := COUNT(GROUP,%Closest%.Diff_phone_1_source);
    Count_Diff_phone_1_last_updt := COUNT(GROUP,%Closest%.Diff_phone_1_last_updt);
    Count_Diff_phone_2_digits := COUNT(GROUP,%Closest%.Diff_phone_2_digits);
    Count_Diff_phone_2_type := COUNT(GROUP,%Closest%.Diff_phone_2_type);
    Count_Diff_phone_2_source := COUNT(GROUP,%Closest%.Diff_phone_2_source);
    Count_Diff_phone_2_last_updt := COUNT(GROUP,%Closest%.Diff_phone_2_last_updt);
    Count_Diff_phone_3_digits := COUNT(GROUP,%Closest%.Diff_phone_3_digits);
    Count_Diff_phone_3_type := COUNT(GROUP,%Closest%.Diff_phone_3_type);
    Count_Diff_phone_3_source := COUNT(GROUP,%Closest%.Diff_phone_3_source);
    Count_Diff_phone_3_last_updt := COUNT(GROUP,%Closest%.Diff_phone_3_last_updt);
    Count_Diff_filler := COUNT(GROUP,%Closest%.Diff_filler);
    Count_Diff_crlf := COUNT(GROUP,%Closest%.Diff_crlf);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
