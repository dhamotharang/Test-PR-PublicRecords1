IMPORT ut,SALT31;
EXPORT PN_Fields := MODULE
// Processing for each FieldType
EXPORT SALT31.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_segment_identifier','invalid_file_sequence_number','invalid_parent_sequence_number','invalid_account_base_number','invalid_area_code','invalid_telephone_number','invalid_telephone_extension','invalid_primary_telephone_indicator','invalid_published_unlisted_indicator','invalid_phonetype');
EXPORT FieldTypeNum(SALT31.StrType fn) := CASE(fn,'invalid_segment_identifier' => 1,'invalid_file_sequence_number' => 2,'invalid_parent_sequence_number' => 3,'invalid_account_base_number' => 4,'invalid_area_code' => 5,'invalid_telephone_number' => 6,'invalid_telephone_extension' => 7,'invalid_primary_telephone_indicator' => 8,'invalid_published_unlisted_indicator' => 9,'invalid_phonetype' => 10,0);
EXPORT MakeFT_invalid_segment_identifier(SALT31.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_segment_identifier(SALT31.StrType s) := WHICH(((SALT31.StrType) s) NOT IN ['PN','PN']);
EXPORT InValidMessageFT_invalid_segment_identifier(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInEnum('PN|PN'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_file_sequence_number(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_file_sequence_number(SALT31.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) >= 1));
EXPORT InValidMessageFT_invalid_file_sequence_number(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInChars('0123456789'),SALT31.HygieneErrors.NotLength('1..'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_parent_sequence_number(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_parent_sequence_number(SALT31.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) >= 1));
EXPORT InValidMessageFT_invalid_parent_sequence_number(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInChars('0123456789'),SALT31.HygieneErrors.NotLength('1..'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_account_base_number(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_account_base_number(SALT31.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) >= 1));
EXPORT InValidMessageFT_invalid_account_base_number(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInChars('0123456789'),SALT31.HygieneErrors.NotLength('1..'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_area_code(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_area_code(SALT31.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))));
EXPORT InValidMessageFT_invalid_area_code(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_telephone_number(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_telephone_number(SALT31.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) >= 1));
EXPORT InValidMessageFT_invalid_telephone_number(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInChars('0123456789'),SALT31.HygieneErrors.NotLength('1..'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_telephone_extension(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_telephone_extension(SALT31.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 '))));
EXPORT InValidMessageFT_invalid_telephone_extension(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_primary_telephone_indicator(SALT31.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_primary_telephone_indicator(SALT31.StrType s) := WHICH(((SALT31.StrType) s) NOT IN ['Y','N','']);
EXPORT InValidMessageFT_invalid_primary_telephone_indicator(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInEnum('Y|N|'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_published_unlisted_indicator(SALT31.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_published_unlisted_indicator(SALT31.StrType s) := WHICH(((SALT31.StrType) s) NOT IN ['001','002','']);
EXPORT InValidMessageFT_invalid_published_unlisted_indicator(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInEnum('001|002|'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_phonetype(SALT31.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_phonetype(SALT31.StrType s) := WHICH(((SALT31.StrType) s) NOT IN ['001','002','003','004','']);
EXPORT InValidMessageFT_invalid_phonetype(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInEnum('001|002|003|004|'),SALT31.HygieneErrors.Good);
EXPORT SALT31.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'segment_identifier','file_sequence_number','parent_sequence_number','account_base_number','area_code','phone_number','phone_extension','primary_phone_indicator','published_unlisted_indicator','phone_type');
EXPORT FieldNum(SALT31.StrType fn) := CASE(fn,'segment_identifier' => 1,'file_sequence_number' => 2,'parent_sequence_number' => 3,'account_base_number' => 4,'area_code' => 5,'phone_number' => 6,'phone_extension' => 7,'primary_phone_indicator' => 8,'published_unlisted_indicator' => 9,'phone_type' => 10,0);
//Individual field level validation
EXPORT Make_segment_identifier(SALT31.StrType s0) := MakeFT_invalid_segment_identifier(s0);
EXPORT InValid_segment_identifier(SALT31.StrType s) := InValidFT_invalid_segment_identifier(s);
EXPORT InValidMessage_segment_identifier(UNSIGNED1 wh) := InValidMessageFT_invalid_segment_identifier(wh);
EXPORT Make_file_sequence_number(SALT31.StrType s0) := MakeFT_invalid_file_sequence_number(s0);
EXPORT InValid_file_sequence_number(SALT31.StrType s) := InValidFT_invalid_file_sequence_number(s);
EXPORT InValidMessage_file_sequence_number(UNSIGNED1 wh) := InValidMessageFT_invalid_file_sequence_number(wh);
EXPORT Make_parent_sequence_number(SALT31.StrType s0) := MakeFT_invalid_parent_sequence_number(s0);
EXPORT InValid_parent_sequence_number(SALT31.StrType s) := InValidFT_invalid_parent_sequence_number(s);
EXPORT InValidMessage_parent_sequence_number(UNSIGNED1 wh) := InValidMessageFT_invalid_parent_sequence_number(wh);
EXPORT Make_account_base_number(SALT31.StrType s0) := MakeFT_invalid_account_base_number(s0);
EXPORT InValid_account_base_number(SALT31.StrType s) := InValidFT_invalid_account_base_number(s);
EXPORT InValidMessage_account_base_number(UNSIGNED1 wh) := InValidMessageFT_invalid_account_base_number(wh);
EXPORT Make_area_code(SALT31.StrType s0) := MakeFT_invalid_area_code(s0);
EXPORT InValid_area_code(SALT31.StrType s) := InValidFT_invalid_area_code(s);
EXPORT InValidMessage_area_code(UNSIGNED1 wh) := InValidMessageFT_invalid_area_code(wh);
EXPORT Make_phone_number(SALT31.StrType s0) := MakeFT_invalid_telephone_number(s0);
EXPORT InValid_phone_number(SALT31.StrType s) := InValidFT_invalid_telephone_number(s);
EXPORT InValidMessage_phone_number(UNSIGNED1 wh) := InValidMessageFT_invalid_telephone_number(wh);
EXPORT Make_phone_extension(SALT31.StrType s0) := MakeFT_invalid_telephone_extension(s0);
EXPORT InValid_phone_extension(SALT31.StrType s) := InValidFT_invalid_telephone_extension(s);
EXPORT InValidMessage_phone_extension(UNSIGNED1 wh) := InValidMessageFT_invalid_telephone_extension(wh);
EXPORT Make_primary_phone_indicator(SALT31.StrType s0) := MakeFT_invalid_primary_telephone_indicator(s0);
EXPORT InValid_primary_phone_indicator(SALT31.StrType s) := InValidFT_invalid_primary_telephone_indicator(s);
EXPORT InValidMessage_primary_phone_indicator(UNSIGNED1 wh) := InValidMessageFT_invalid_primary_telephone_indicator(wh);
EXPORT Make_published_unlisted_indicator(SALT31.StrType s0) := MakeFT_invalid_published_unlisted_indicator(s0);
EXPORT InValid_published_unlisted_indicator(SALT31.StrType s) := InValidFT_invalid_published_unlisted_indicator(s);
EXPORT InValidMessage_published_unlisted_indicator(UNSIGNED1 wh) := InValidMessageFT_invalid_published_unlisted_indicator(wh);
EXPORT Make_phone_type(SALT31.StrType s0) := MakeFT_invalid_phonetype(s0);
EXPORT InValid_phone_type(SALT31.StrType s) := InValidFT_invalid_phonetype(s);
EXPORT InValidMessage_phone_type(UNSIGNED1 wh) := InValidMessageFT_invalid_phonetype(wh);
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT31,Scrubs_Business_Credit;
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
    BOOLEAN Diff_account_base_number;
    BOOLEAN Diff_area_code;
    BOOLEAN Diff_phone_number;
    BOOLEAN Diff_phone_extension;
    BOOLEAN Diff_primary_phone_indicator;
    BOOLEAN Diff_published_unlisted_indicator;
    BOOLEAN Diff_phone_type;
    UNSIGNED Num_Diffs;
    SALT31.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_segment_identifier := le.segment_identifier <> ri.segment_identifier;
    SELF.Diff_file_sequence_number := le.file_sequence_number <> ri.file_sequence_number;
    SELF.Diff_parent_sequence_number := le.parent_sequence_number <> ri.parent_sequence_number;
    SELF.Diff_account_base_number := le.account_base_number <> ri.account_base_number;
    SELF.Diff_area_code := le.area_code <> ri.area_code;
    SELF.Diff_phone_number := le.phone_number <> ri.phone_number;
    SELF.Diff_phone_extension := le.phone_extension <> ri.phone_extension;
    SELF.Diff_primary_phone_indicator := le.primary_phone_indicator <> ri.primary_phone_indicator;
    SELF.Diff_published_unlisted_indicator := le.published_unlisted_indicator <> ri.published_unlisted_indicator;
    SELF.Diff_phone_type := le.phone_type <> ri.phone_type;
    SELF.Val := (SALT31.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_segment_identifier,1,0)+ IF( SELF.Diff_file_sequence_number,1,0)+ IF( SELF.Diff_parent_sequence_number,1,0)+ IF( SELF.Diff_account_base_number,1,0)+ IF( SELF.Diff_area_code,1,0)+ IF( SELF.Diff_phone_number,1,0)+ IF( SELF.Diff_phone_extension,1,0)+ IF( SELF.Diff_primary_phone_indicator,1,0)+ IF( SELF.Diff_published_unlisted_indicator,1,0)+ IF( SELF.Diff_phone_type,1,0);
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
    Count_Diff_account_base_number := COUNT(GROUP,%Closest%.Diff_account_base_number);
    Count_Diff_area_code := COUNT(GROUP,%Closest%.Diff_area_code);
    Count_Diff_phone_number := COUNT(GROUP,%Closest%.Diff_phone_number);
    Count_Diff_phone_extension := COUNT(GROUP,%Closest%.Diff_phone_extension);
    Count_Diff_primary_phone_indicator := COUNT(GROUP,%Closest%.Diff_primary_phone_indicator);
    Count_Diff_published_unlisted_indicator := COUNT(GROUP,%Closest%.Diff_published_unlisted_indicator);
    Count_Diff_phone_type := COUNT(GROUP,%Closest%.Diff_phone_type);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
