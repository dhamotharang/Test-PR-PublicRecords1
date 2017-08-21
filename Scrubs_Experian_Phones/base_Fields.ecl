IMPORT ut,SALT33;
IMPORT Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT base_Fields := MODULE
// Processing for each FieldType
EXPORT SALT33.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'Invalid_Num','Invalid_Pin','Invalid_Type','Invalid_Source','Invalid_Char','Invalid_Date','Invalid_RecType');
EXPORT FieldTypeNum(SALT33.StrType fn) := CASE(fn,'Invalid_Num' => 1,'Invalid_Pin' => 2,'Invalid_Type' => 3,'Invalid_Source' => 4,'Invalid_Char' => 5,'Invalid_Date' => 6,'Invalid_RecType' => 7,0);
EXPORT MakeFT_Invalid_Num(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Num(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'0123456789 '))));
EXPORT InValidMessageFT_Invalid_Num(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('0123456789 '),SALT33.HygieneErrors.Good);
EXPORT MakeFT_Invalid_Pin(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Pin(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'))));
EXPORT InValidMessageFT_Invalid_Pin(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'),SALT33.HygieneErrors.Good);
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
EXPORT MakeFT_Invalid_Char(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqurstuvwxyz0123456789\'- '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Char(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqurstuvwxyz0123456789\'- '))));
EXPORT InValidMessageFT_Invalid_Char(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqurstuvwxyz0123456789\'- '),SALT33.HygieneErrors.Good);
EXPORT MakeFT_Invalid_Date(SALT33.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_Date(SALT33.StrType s) := WHICH(~Scrubs.fn_valid_date(s)>0);
EXPORT InValidMessageFT_Invalid_Date(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.CustomFail('Scrubs.fn_valid_date'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_Invalid_RecType(SALT33.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_RecType(SALT33.StrType s) := WHICH(((SALT33.StrType) s) NOT IN ['C1','C2','O1','O2','O3','SP',' ']);
EXPORT InValidMessageFT_Invalid_RecType(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInEnum('C1|C2|O1|O2|O3|SP| '),SALT33.HygieneErrors.Good);
EXPORT SALT33.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'score','encrypted_experian_pin','phone_pos','phone_digits','phone_type','phone_source','phone_last_updt','did','did_score','pin_did','pin_title','pin_fname','pin_mname','pin_lname','pin_name_suffix','date_first_seen','date_last_seen','date_vendor_first_reported','date_vendor_last_reported','rec_type','is_current');
EXPORT FieldNum(SALT33.StrType fn) := CASE(fn,'score' => 0,'encrypted_experian_pin' => 1,'phone_pos' => 2,'phone_digits' => 3,'phone_type' => 4,'phone_source' => 5,'phone_last_updt' => 6,'did' => 7,'did_score' => 8,'pin_did' => 9,'pin_title' => 10,'pin_fname' => 11,'pin_mname' => 12,'pin_lname' => 13,'pin_name_suffix' => 14,'date_first_seen' => 15,'date_last_seen' => 16,'date_vendor_first_reported' => 17,'date_vendor_last_reported' => 18,'rec_type' => 19,'is_current' => 20,0);
//Individual field level validation
EXPORT Make_score(SALT33.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_score(SALT33.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_score(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
EXPORT Make_encrypted_experian_pin(SALT33.StrType s0) := MakeFT_Invalid_Pin(s0);
EXPORT InValid_encrypted_experian_pin(SALT33.StrType s) := InValidFT_Invalid_Pin(s);
EXPORT InValidMessage_encrypted_experian_pin(UNSIGNED1 wh) := InValidMessageFT_Invalid_Pin(wh);
EXPORT Make_phone_pos(SALT33.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_phone_pos(SALT33.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_phone_pos(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
EXPORT Make_phone_digits(SALT33.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_phone_digits(SALT33.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_phone_digits(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
EXPORT Make_phone_type(SALT33.StrType s0) := MakeFT_Invalid_Type(s0);
EXPORT InValid_phone_type(SALT33.StrType s) := InValidFT_Invalid_Type(s);
EXPORT InValidMessage_phone_type(UNSIGNED1 wh) := InValidMessageFT_Invalid_Type(wh);
EXPORT Make_phone_source(SALT33.StrType s0) := MakeFT_Invalid_Source(s0);
EXPORT InValid_phone_source(SALT33.StrType s) := InValidFT_Invalid_Source(s);
EXPORT InValidMessage_phone_source(UNSIGNED1 wh) := InValidMessageFT_Invalid_Source(wh);
EXPORT Make_phone_last_updt(SALT33.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_phone_last_updt(SALT33.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_phone_last_updt(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
EXPORT Make_did(SALT33.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_did(SALT33.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_did(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
EXPORT Make_did_score(SALT33.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_did_score(SALT33.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_did_score(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
EXPORT Make_pin_did(SALT33.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_pin_did(SALT33.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_pin_did(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
EXPORT Make_pin_title(SALT33.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_pin_title(SALT33.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_pin_title(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);
EXPORT Make_pin_fname(SALT33.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_pin_fname(SALT33.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_pin_fname(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);
EXPORT Make_pin_mname(SALT33.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_pin_mname(SALT33.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_pin_mname(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);
EXPORT Make_pin_lname(SALT33.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_pin_lname(SALT33.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_pin_lname(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);
EXPORT Make_pin_name_suffix(SALT33.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_pin_name_suffix(SALT33.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_pin_name_suffix(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);
EXPORT Make_date_first_seen(SALT33.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_date_first_seen(SALT33.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_date_first_seen(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
EXPORT Make_date_last_seen(SALT33.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_date_last_seen(SALT33.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_date_last_seen(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
EXPORT Make_date_vendor_first_reported(SALT33.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_date_vendor_first_reported(SALT33.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_date_vendor_first_reported(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
EXPORT Make_date_vendor_last_reported(SALT33.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_date_vendor_last_reported(SALT33.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_date_vendor_last_reported(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
EXPORT Make_rec_type(SALT33.StrType s0) := MakeFT_Invalid_RecType(s0);
EXPORT InValid_rec_type(SALT33.StrType s) := InValidFT_Invalid_RecType(s);
EXPORT InValidMessage_rec_type(UNSIGNED1 wh) := InValidMessageFT_Invalid_RecType(wh);
EXPORT Make_is_current(SALT33.StrType s0) := s0;
EXPORT InValid_is_current(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_is_current(UNSIGNED1 wh) := '';
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
    BOOLEAN Diff_score;
    BOOLEAN Diff_encrypted_experian_pin;
    BOOLEAN Diff_phone_pos;
    BOOLEAN Diff_phone_digits;
    BOOLEAN Diff_phone_type;
    BOOLEAN Diff_phone_source;
    BOOLEAN Diff_phone_last_updt;
    BOOLEAN Diff_did;
    BOOLEAN Diff_did_score;
    BOOLEAN Diff_pin_did;
    BOOLEAN Diff_pin_title;
    BOOLEAN Diff_pin_fname;
    BOOLEAN Diff_pin_mname;
    BOOLEAN Diff_pin_lname;
    BOOLEAN Diff_pin_name_suffix;
    BOOLEAN Diff_date_first_seen;
    BOOLEAN Diff_date_last_seen;
    BOOLEAN Diff_date_vendor_first_reported;
    BOOLEAN Diff_date_vendor_last_reported;
    BOOLEAN Diff_rec_type;
    BOOLEAN Diff_is_current;
    UNSIGNED Num_Diffs;
    SALT33.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_score := le.score <> ri.score;
    SELF.Diff_encrypted_experian_pin := le.encrypted_experian_pin <> ri.encrypted_experian_pin;
    SELF.Diff_phone_pos := le.phone_pos <> ri.phone_pos;
    SELF.Diff_phone_digits := le.phone_digits <> ri.phone_digits;
    SELF.Diff_phone_type := le.phone_type <> ri.phone_type;
    SELF.Diff_phone_source := le.phone_source <> ri.phone_source;
    SELF.Diff_phone_last_updt := le.phone_last_updt <> ri.phone_last_updt;
    SELF.Diff_did := le.did <> ri.did;
    SELF.Diff_did_score := le.did_score <> ri.did_score;
    SELF.Diff_pin_did := le.pin_did <> ri.pin_did;
    SELF.Diff_pin_title := le.pin_title <> ri.pin_title;
    SELF.Diff_pin_fname := le.pin_fname <> ri.pin_fname;
    SELF.Diff_pin_mname := le.pin_mname <> ri.pin_mname;
    SELF.Diff_pin_lname := le.pin_lname <> ri.pin_lname;
    SELF.Diff_pin_name_suffix := le.pin_name_suffix <> ri.pin_name_suffix;
    SELF.Diff_date_first_seen := le.date_first_seen <> ri.date_first_seen;
    SELF.Diff_date_last_seen := le.date_last_seen <> ri.date_last_seen;
    SELF.Diff_date_vendor_first_reported := le.date_vendor_first_reported <> ri.date_vendor_first_reported;
    SELF.Diff_date_vendor_last_reported := le.date_vendor_last_reported <> ri.date_vendor_last_reported;
    SELF.Diff_rec_type := le.rec_type <> ri.rec_type;
    SELF.Diff_is_current := le.is_current <> ri.is_current;
    SELF.Val := (SALT33.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_score,1,0)+ IF( SELF.Diff_encrypted_experian_pin,1,0)+ IF( SELF.Diff_phone_pos,1,0)+ IF( SELF.Diff_phone_digits,1,0)+ IF( SELF.Diff_phone_type,1,0)+ IF( SELF.Diff_phone_source,1,0)+ IF( SELF.Diff_phone_last_updt,1,0)+ IF( SELF.Diff_did,1,0)+ IF( SELF.Diff_did_score,1,0)+ IF( SELF.Diff_pin_did,1,0)+ IF( SELF.Diff_pin_title,1,0)+ IF( SELF.Diff_pin_fname,1,0)+ IF( SELF.Diff_pin_mname,1,0)+ IF( SELF.Diff_pin_lname,1,0)+ IF( SELF.Diff_pin_name_suffix,1,0)+ IF( SELF.Diff_date_first_seen,1,0)+ IF( SELF.Diff_date_last_seen,1,0)+ IF( SELF.Diff_date_vendor_first_reported,1,0)+ IF( SELF.Diff_date_vendor_last_reported,1,0)+ IF( SELF.Diff_rec_type,1,0)+ IF( SELF.Diff_is_current,1,0);
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
    Count_Diff_score := COUNT(GROUP,%Closest%.Diff_score);
    Count_Diff_encrypted_experian_pin := COUNT(GROUP,%Closest%.Diff_encrypted_experian_pin);
    Count_Diff_phone_pos := COUNT(GROUP,%Closest%.Diff_phone_pos);
    Count_Diff_phone_digits := COUNT(GROUP,%Closest%.Diff_phone_digits);
    Count_Diff_phone_type := COUNT(GROUP,%Closest%.Diff_phone_type);
    Count_Diff_phone_source := COUNT(GROUP,%Closest%.Diff_phone_source);
    Count_Diff_phone_last_updt := COUNT(GROUP,%Closest%.Diff_phone_last_updt);
    Count_Diff_did := COUNT(GROUP,%Closest%.Diff_did);
    Count_Diff_did_score := COUNT(GROUP,%Closest%.Diff_did_score);
    Count_Diff_pin_did := COUNT(GROUP,%Closest%.Diff_pin_did);
    Count_Diff_pin_title := COUNT(GROUP,%Closest%.Diff_pin_title);
    Count_Diff_pin_fname := COUNT(GROUP,%Closest%.Diff_pin_fname);
    Count_Diff_pin_mname := COUNT(GROUP,%Closest%.Diff_pin_mname);
    Count_Diff_pin_lname := COUNT(GROUP,%Closest%.Diff_pin_lname);
    Count_Diff_pin_name_suffix := COUNT(GROUP,%Closest%.Diff_pin_name_suffix);
    Count_Diff_date_first_seen := COUNT(GROUP,%Closest%.Diff_date_first_seen);
    Count_Diff_date_last_seen := COUNT(GROUP,%Closest%.Diff_date_last_seen);
    Count_Diff_date_vendor_first_reported := COUNT(GROUP,%Closest%.Diff_date_vendor_first_reported);
    Count_Diff_date_vendor_last_reported := COUNT(GROUP,%Closest%.Diff_date_vendor_last_reported);
    Count_Diff_rec_type := COUNT(GROUP,%Closest%.Diff_rec_type);
    Count_Diff_is_current := COUNT(GROUP,%Closest%.Diff_is_current);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
