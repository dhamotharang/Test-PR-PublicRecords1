IMPORT ut,SALT31;
EXPORT AD_Fields := MODULE
// Processing for each FieldType
EXPORT SALT31.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_segment_identifier','invalid_file_sequence_number','invalid_parent_sequence_number','invalid_account_base_number','invalid_address_line_1','invalid_address_line_2','invalid_city','invalid_state','invalid_zip_code_or_ca_postal_code','invalid_postal_code','invalid_country_code','invalid_primary_address_indicator','invalid_address_classification');
EXPORT FieldTypeNum(SALT31.StrType fn) := CASE(fn,'invalid_segment_identifier' => 1,'invalid_file_sequence_number' => 2,'invalid_parent_sequence_number' => 3,'invalid_account_base_number' => 4,'invalid_address_line_1' => 5,'invalid_address_line_2' => 6,'invalid_city' => 7,'invalid_state' => 8,'invalid_zip_code_or_ca_postal_code' => 9,'invalid_postal_code' => 10,'invalid_country_code' => 11,'invalid_primary_address_indicator' => 12,'invalid_address_classification' => 13,0);
EXPORT MakeFT_invalid_segment_identifier(SALT31.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_segment_identifier(SALT31.StrType s) := WHICH(((SALT31.StrType) s) NOT IN ['AD','AD']);
EXPORT InValidMessageFT_invalid_segment_identifier(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInEnum('AD|AD'),SALT31.HygieneErrors.Good);
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
EXPORT MakeFT_invalid_address_line_1(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 .:-#/\',&#'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_address_line_1(SALT31.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 .:-#/\',&#'))),~(LENGTH(TRIM(s)) >= 1));
EXPORT InValidMessageFT_invalid_address_line_1(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 .:-#/\',&#'),SALT31.HygieneErrors.NotLength('1..'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_address_line_2(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 \\\':&-.#/,'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_address_line_2(SALT31.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 \\\':&-.#/,'))));
EXPORT InValidMessageFT_invalid_address_line_2(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 \\\':&-.#/,'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_city(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ -.\''); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_city(SALT31.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ -.\''))));
EXPORT InValidMessageFT_invalid_city(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ -.\''),SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_state(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_state(SALT31.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'))));
EXPORT InValidMessageFT_invalid_state(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_zip_code_or_ca_postal_code(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_zip_code_or_ca_postal_code(SALT31.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'))));
EXPORT InValidMessageFT_invalid_zip_code_or_ca_postal_code(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_postal_code(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789\''); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_postal_code(SALT31.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789\''))));
EXPORT InValidMessageFT_invalid_postal_code(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInChars('0123456789\''),SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_country_code(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_country_code(SALT31.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'))));
EXPORT InValidMessageFT_invalid_country_code(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_primary_address_indicator(SALT31.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_primary_address_indicator(SALT31.StrType s) := WHICH(((SALT31.StrType) s) NOT IN ['Y','N','']);
EXPORT InValidMessageFT_invalid_primary_address_indicator(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInEnum('Y|N|'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_address_classification(SALT31.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_address_classification(SALT31.StrType s) := WHICH(((SALT31.StrType) s) NOT IN ['001','002','003','004','005','006','007','008','009','010','011','012','']);
EXPORT InValidMessageFT_invalid_address_classification(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInEnum('001|002|003|004|005|006|007|008|009|010|011|012|'),SALT31.HygieneErrors.Good);
EXPORT SALT31.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'segment_identifier','file_sequence_number','parent_sequence_number','account_base_number','address_line_1','address_line_2','city','state','zip_code_or_ca_postal_code','postal_code','country_code','primary_address_indicator','address_classification');
EXPORT FieldNum(SALT31.StrType fn) := CASE(fn,'segment_identifier' => 1,'file_sequence_number' => 2,'parent_sequence_number' => 3,'account_base_number' => 4,'address_line_1' => 5,'address_line_2' => 6,'city' => 7,'state' => 8,'zip_code_or_ca_postal_code' => 9,'postal_code' => 10,'country_code' => 11,'primary_address_indicator' => 12,'address_classification' => 13,0);
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
EXPORT Make_address_line_1(SALT31.StrType s0) := MakeFT_invalid_address_line_1(s0);
EXPORT InValid_address_line_1(SALT31.StrType s) := InValidFT_invalid_address_line_1(s);
EXPORT InValidMessage_address_line_1(UNSIGNED1 wh) := InValidMessageFT_invalid_address_line_1(wh);
EXPORT Make_address_line_2(SALT31.StrType s0) := MakeFT_invalid_address_line_2(s0);
EXPORT InValid_address_line_2(SALT31.StrType s) := InValidFT_invalid_address_line_2(s);
EXPORT InValidMessage_address_line_2(UNSIGNED1 wh) := InValidMessageFT_invalid_address_line_2(wh);
EXPORT Make_city(SALT31.StrType s0) := MakeFT_invalid_city(s0);
EXPORT InValid_city(SALT31.StrType s) := InValidFT_invalid_city(s);
EXPORT InValidMessage_city(UNSIGNED1 wh) := InValidMessageFT_invalid_city(wh);
EXPORT Make_state(SALT31.StrType s0) := MakeFT_invalid_state(s0);
EXPORT InValid_state(SALT31.StrType s) := InValidFT_invalid_state(s);
EXPORT InValidMessage_state(UNSIGNED1 wh) := InValidMessageFT_invalid_state(wh);
EXPORT Make_zip_code_or_ca_postal_code(SALT31.StrType s0) := MakeFT_invalid_zip_code_or_ca_postal_code(s0);
EXPORT InValid_zip_code_or_ca_postal_code(SALT31.StrType s) := InValidFT_invalid_zip_code_or_ca_postal_code(s);
EXPORT InValidMessage_zip_code_or_ca_postal_code(UNSIGNED1 wh) := InValidMessageFT_invalid_zip_code_or_ca_postal_code(wh);
EXPORT Make_postal_code(SALT31.StrType s0) := MakeFT_invalid_postal_code(s0);
EXPORT InValid_postal_code(SALT31.StrType s) := InValidFT_invalid_postal_code(s);
EXPORT InValidMessage_postal_code(UNSIGNED1 wh) := InValidMessageFT_invalid_postal_code(wh);
EXPORT Make_country_code(SALT31.StrType s0) := MakeFT_invalid_country_code(s0);
EXPORT InValid_country_code(SALT31.StrType s) := InValidFT_invalid_country_code(s);
EXPORT InValidMessage_country_code(UNSIGNED1 wh) := InValidMessageFT_invalid_country_code(wh);
EXPORT Make_primary_address_indicator(SALT31.StrType s0) := MakeFT_invalid_primary_address_indicator(s0);
EXPORT InValid_primary_address_indicator(SALT31.StrType s) := InValidFT_invalid_primary_address_indicator(s);
EXPORT InValidMessage_primary_address_indicator(UNSIGNED1 wh) := InValidMessageFT_invalid_primary_address_indicator(wh);
EXPORT Make_address_classification(SALT31.StrType s0) := MakeFT_invalid_address_classification(s0);
EXPORT InValid_address_classification(SALT31.StrType s) := InValidFT_invalid_address_classification(s);
EXPORT InValidMessage_address_classification(UNSIGNED1 wh) := InValidMessageFT_invalid_address_classification(wh);
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
    BOOLEAN Diff_address_line_1;
    BOOLEAN Diff_address_line_2;
    BOOLEAN Diff_city;
    BOOLEAN Diff_state;
    BOOLEAN Diff_zip_code_or_ca_postal_code;
    BOOLEAN Diff_postal_code;
    BOOLEAN Diff_country_code;
    BOOLEAN Diff_primary_address_indicator;
    BOOLEAN Diff_address_classification;
    UNSIGNED Num_Diffs;
    SALT31.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_segment_identifier := le.segment_identifier <> ri.segment_identifier;
    SELF.Diff_file_sequence_number := le.file_sequence_number <> ri.file_sequence_number;
    SELF.Diff_parent_sequence_number := le.parent_sequence_number <> ri.parent_sequence_number;
    SELF.Diff_account_base_number := le.account_base_number <> ri.account_base_number;
    SELF.Diff_address_line_1 := le.address_line_1 <> ri.address_line_1;
    SELF.Diff_address_line_2 := le.address_line_2 <> ri.address_line_2;
    SELF.Diff_city := le.city <> ri.city;
    SELF.Diff_state := le.state <> ri.state;
    SELF.Diff_zip_code_or_ca_postal_code := le.zip_code_or_ca_postal_code <> ri.zip_code_or_ca_postal_code;
    SELF.Diff_postal_code := le.postal_code <> ri.postal_code;
    SELF.Diff_country_code := le.country_code <> ri.country_code;
    SELF.Diff_primary_address_indicator := le.primary_address_indicator <> ri.primary_address_indicator;
    SELF.Diff_address_classification := le.address_classification <> ri.address_classification;
    SELF.Val := (SALT31.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_segment_identifier,1,0)+ IF( SELF.Diff_file_sequence_number,1,0)+ IF( SELF.Diff_parent_sequence_number,1,0)+ IF( SELF.Diff_account_base_number,1,0)+ IF( SELF.Diff_address_line_1,1,0)+ IF( SELF.Diff_address_line_2,1,0)+ IF( SELF.Diff_city,1,0)+ IF( SELF.Diff_state,1,0)+ IF( SELF.Diff_zip_code_or_ca_postal_code,1,0)+ IF( SELF.Diff_postal_code,1,0)+ IF( SELF.Diff_country_code,1,0)+ IF( SELF.Diff_primary_address_indicator,1,0)+ IF( SELF.Diff_address_classification,1,0);
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
    Count_Diff_address_line_1 := COUNT(GROUP,%Closest%.Diff_address_line_1);
    Count_Diff_address_line_2 := COUNT(GROUP,%Closest%.Diff_address_line_2);
    Count_Diff_city := COUNT(GROUP,%Closest%.Diff_city);
    Count_Diff_state := COUNT(GROUP,%Closest%.Diff_state);
    Count_Diff_zip_code_or_ca_postal_code := COUNT(GROUP,%Closest%.Diff_zip_code_or_ca_postal_code);
    Count_Diff_postal_code := COUNT(GROUP,%Closest%.Diff_postal_code);
    Count_Diff_country_code := COUNT(GROUP,%Closest%.Diff_country_code);
    Count_Diff_primary_address_indicator := COUNT(GROUP,%Closest%.Diff_primary_address_indicator);
    Count_Diff_address_classification := COUNT(GROUP,%Closest%.Diff_address_classification);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
