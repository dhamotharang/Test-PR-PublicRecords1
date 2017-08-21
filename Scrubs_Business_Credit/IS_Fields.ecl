IMPORT ut,SALT31;
EXPORT IS_Fields := MODULE
// Processing for each FieldType
EXPORT SALT31.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_segment_identifier','invalid_file_sequence_number','invalid_parent_sequence_number','invalid_account_base_ab_number','invalid_first_name','invalid_middle_name','invalid_last_name','invalid_suffix','invalid_e_mail_address','invalid_guarantor_owner_indicator','invalid_relationship_to_business_indicator','invalid_business_title','invalid_percent_of_liability','invalid_percent_of_ownership');
EXPORT FieldTypeNum(SALT31.StrType fn) := CASE(fn,'invalid_segment_identifier' => 1,'invalid_file_sequence_number' => 2,'invalid_parent_sequence_number' => 3,'invalid_account_base_ab_number' => 4,'invalid_first_name' => 5,'invalid_middle_name' => 6,'invalid_last_name' => 7,'invalid_suffix' => 8,'invalid_e_mail_address' => 9,'invalid_guarantor_owner_indicator' => 10,'invalid_relationship_to_business_indicator' => 11,'invalid_business_title' => 12,'invalid_percent_of_liability' => 13,'invalid_percent_of_ownership' => 14,0);
EXPORT MakeFT_invalid_segment_identifier(SALT31.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_segment_identifier(SALT31.StrType s) := WHICH(((SALT31.StrType) s) NOT IN ['IS','IS']);
EXPORT InValidMessageFT_invalid_segment_identifier(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInEnum('IS|IS'),SALT31.HygieneErrors.Good);
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
EXPORT MakeFT_invalid_account_base_ab_number(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_account_base_ab_number(SALT31.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) >= 1));
EXPORT InValidMessageFT_invalid_account_base_ab_number(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInChars('0123456789'),SALT31.HygieneErrors.NotLength('1..'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_first_name(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ -/\''); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_first_name(SALT31.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ -/\''))),~(LENGTH(TRIM(s)) >= 1));
EXPORT InValidMessageFT_invalid_first_name(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ -/\''),SALT31.HygieneErrors.NotLength('1..'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_middle_name(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ -/\''); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_middle_name(SALT31.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ -/\''))));
EXPORT InValidMessageFT_invalid_middle_name(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ -/\''),SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_last_name(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ -/\''); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_last_name(SALT31.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ -/\''))),~(LENGTH(TRIM(s)) >= 1));
EXPORT InValidMessageFT_invalid_last_name(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ -/\''),SALT31.HygieneErrors.NotLength('1..'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_suffix(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_suffix(SALT31.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'))));
EXPORT InValidMessageFT_invalid_suffix(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_e_mail_address(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789@._-;'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_e_mail_address(SALT31.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789@._-;'))));
EXPORT InValidMessageFT_invalid_e_mail_address(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789@._-;'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_guarantor_owner_indicator(SALT31.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_guarantor_owner_indicator(SALT31.StrType s) := WHICH(((SALT31.StrType) s) NOT IN ['001','002','003']);
EXPORT InValidMessageFT_invalid_guarantor_owner_indicator(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInEnum('001|002|003'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_relationship_to_business_indicator(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_relationship_to_business_indicator(SALT31.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_invalid_relationship_to_business_indicator(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInChars('0123456789'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_business_title(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_business_title(SALT31.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'))));
EXPORT InValidMessageFT_invalid_business_title(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_percent_of_liability(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_percent_of_liability(SALT31.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_invalid_percent_of_liability(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInChars('0123456789'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_percent_of_ownership(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_percent_of_ownership(SALT31.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_invalid_percent_of_ownership(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInChars('0123456789'),SALT31.HygieneErrors.Good);
EXPORT SALT31.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'segment_identifier','file_sequence_number','parent_sequence_number','account_base_number','original_fname','original_mname','original_lname','original_suffix','e_mail_address','guarantor_owner_indicator','relationship_to_business_indicator','business_title','percent_of_liability','percent_of_ownership');
EXPORT FieldNum(SALT31.StrType fn) := CASE(fn,'segment_identifier' => 1,'file_sequence_number' => 2,'parent_sequence_number' => 3,'account_base_number' => 4,'original_fname' => 5,'original_mname' => 6,'original_lname' => 7,'original_suffix' => 8,'e_mail_address' => 9,'guarantor_owner_indicator' => 10,'relationship_to_business_indicator' => 11,'business_title' => 12,'percent_of_liability' => 13,'percent_of_ownership' => 14,0);
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
EXPORT Make_account_base_number(SALT31.StrType s0) := MakeFT_invalid_account_base_ab_number(s0);
EXPORT InValid_account_base_number(SALT31.StrType s) := InValidFT_invalid_account_base_ab_number(s);
EXPORT InValidMessage_account_base_number(UNSIGNED1 wh) := InValidMessageFT_invalid_account_base_ab_number(wh);
EXPORT Make_original_fname(SALT31.StrType s0) := MakeFT_invalid_first_name(s0);
EXPORT InValid_original_fname(SALT31.StrType s) := InValidFT_invalid_first_name(s);
EXPORT InValidMessage_original_fname(UNSIGNED1 wh) := InValidMessageFT_invalid_first_name(wh);
EXPORT Make_original_mname(SALT31.StrType s0) := MakeFT_invalid_middle_name(s0);
EXPORT InValid_original_mname(SALT31.StrType s) := InValidFT_invalid_middle_name(s);
EXPORT InValidMessage_original_mname(UNSIGNED1 wh) := InValidMessageFT_invalid_middle_name(wh);
EXPORT Make_original_lname(SALT31.StrType s0) := MakeFT_invalid_last_name(s0);
EXPORT InValid_original_lname(SALT31.StrType s) := InValidFT_invalid_last_name(s);
EXPORT InValidMessage_original_lname(UNSIGNED1 wh) := InValidMessageFT_invalid_last_name(wh);
EXPORT Make_original_suffix(SALT31.StrType s0) := MakeFT_invalid_suffix(s0);
EXPORT InValid_original_suffix(SALT31.StrType s) := InValidFT_invalid_suffix(s);
EXPORT InValidMessage_original_suffix(UNSIGNED1 wh) := InValidMessageFT_invalid_suffix(wh);
EXPORT Make_e_mail_address(SALT31.StrType s0) := MakeFT_invalid_e_mail_address(s0);
EXPORT InValid_e_mail_address(SALT31.StrType s) := InValidFT_invalid_e_mail_address(s);
EXPORT InValidMessage_e_mail_address(UNSIGNED1 wh) := InValidMessageFT_invalid_e_mail_address(wh);
EXPORT Make_guarantor_owner_indicator(SALT31.StrType s0) := MakeFT_invalid_guarantor_owner_indicator(s0);
EXPORT InValid_guarantor_owner_indicator(SALT31.StrType s) := InValidFT_invalid_guarantor_owner_indicator(s);
EXPORT InValidMessage_guarantor_owner_indicator(UNSIGNED1 wh) := InValidMessageFT_invalid_guarantor_owner_indicator(wh);
EXPORT Make_relationship_to_business_indicator(SALT31.StrType s0) := MakeFT_invalid_relationship_to_business_indicator(s0);
EXPORT InValid_relationship_to_business_indicator(SALT31.StrType s) := InValidFT_invalid_relationship_to_business_indicator(s);
EXPORT InValidMessage_relationship_to_business_indicator(UNSIGNED1 wh) := InValidMessageFT_invalid_relationship_to_business_indicator(wh);
EXPORT Make_business_title(SALT31.StrType s0) := MakeFT_invalid_business_title(s0);
EXPORT InValid_business_title(SALT31.StrType s) := InValidFT_invalid_business_title(s);
EXPORT InValidMessage_business_title(UNSIGNED1 wh) := InValidMessageFT_invalid_business_title(wh);
EXPORT Make_percent_of_liability(SALT31.StrType s0) := MakeFT_invalid_percent_of_liability(s0);
EXPORT InValid_percent_of_liability(SALT31.StrType s) := InValidFT_invalid_percent_of_liability(s);
EXPORT InValidMessage_percent_of_liability(UNSIGNED1 wh) := InValidMessageFT_invalid_percent_of_liability(wh);
EXPORT Make_percent_of_ownership(SALT31.StrType s0) := MakeFT_invalid_percent_of_ownership(s0);
EXPORT InValid_percent_of_ownership(SALT31.StrType s) := InValidFT_invalid_percent_of_ownership(s);
EXPORT InValidMessage_percent_of_ownership(UNSIGNED1 wh) := InValidMessageFT_invalid_percent_of_ownership(wh);
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
    BOOLEAN Diff_original_fname;
    BOOLEAN Diff_original_mname;
    BOOLEAN Diff_original_lname;
    BOOLEAN Diff_original_suffix;
    BOOLEAN Diff_e_mail_address;
    BOOLEAN Diff_guarantor_owner_indicator;
    BOOLEAN Diff_relationship_to_business_indicator;
    BOOLEAN Diff_business_title;
    BOOLEAN Diff_percent_of_liability;
    BOOLEAN Diff_percent_of_ownership;
    UNSIGNED Num_Diffs;
    SALT31.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_segment_identifier := le.segment_identifier <> ri.segment_identifier;
    SELF.Diff_file_sequence_number := le.file_sequence_number <> ri.file_sequence_number;
    SELF.Diff_parent_sequence_number := le.parent_sequence_number <> ri.parent_sequence_number;
    SELF.Diff_account_base_number := le.account_base_number <> ri.account_base_number;
    SELF.Diff_original_fname := le.original_fname <> ri.original_fname;
    SELF.Diff_original_mname := le.original_mname <> ri.original_mname;
    SELF.Diff_original_lname := le.original_lname <> ri.original_lname;
    SELF.Diff_original_suffix := le.original_suffix <> ri.original_suffix;
    SELF.Diff_e_mail_address := le.e_mail_address <> ri.e_mail_address;
    SELF.Diff_guarantor_owner_indicator := le.guarantor_owner_indicator <> ri.guarantor_owner_indicator;
    SELF.Diff_relationship_to_business_indicator := le.relationship_to_business_indicator <> ri.relationship_to_business_indicator;
    SELF.Diff_business_title := le.business_title <> ri.business_title;
    SELF.Diff_percent_of_liability := le.percent_of_liability <> ri.percent_of_liability;
    SELF.Diff_percent_of_ownership := le.percent_of_ownership <> ri.percent_of_ownership;
    SELF.Val := (SALT31.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_segment_identifier,1,0)+ IF( SELF.Diff_file_sequence_number,1,0)+ IF( SELF.Diff_parent_sequence_number,1,0)+ IF( SELF.Diff_account_base_number,1,0)+ IF( SELF.Diff_original_fname,1,0)+ IF( SELF.Diff_original_mname,1,0)+ IF( SELF.Diff_original_lname,1,0)+ IF( SELF.Diff_original_suffix,1,0)+ IF( SELF.Diff_e_mail_address,1,0)+ IF( SELF.Diff_guarantor_owner_indicator,1,0)+ IF( SELF.Diff_relationship_to_business_indicator,1,0)+ IF( SELF.Diff_business_title,1,0)+ IF( SELF.Diff_percent_of_liability,1,0)+ IF( SELF.Diff_percent_of_ownership,1,0);
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
    Count_Diff_original_fname := COUNT(GROUP,%Closest%.Diff_original_fname);
    Count_Diff_original_mname := COUNT(GROUP,%Closest%.Diff_original_mname);
    Count_Diff_original_lname := COUNT(GROUP,%Closest%.Diff_original_lname);
    Count_Diff_original_suffix := COUNT(GROUP,%Closest%.Diff_original_suffix);
    Count_Diff_e_mail_address := COUNT(GROUP,%Closest%.Diff_e_mail_address);
    Count_Diff_guarantor_owner_indicator := COUNT(GROUP,%Closest%.Diff_guarantor_owner_indicator);
    Count_Diff_relationship_to_business_indicator := COUNT(GROUP,%Closest%.Diff_relationship_to_business_indicator);
    Count_Diff_business_title := COUNT(GROUP,%Closest%.Diff_business_title);
    Count_Diff_percent_of_liability := COUNT(GROUP,%Closest%.Diff_percent_of_liability);
    Count_Diff_percent_of_ownership := COUNT(GROUP,%Closest%.Diff_percent_of_ownership);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
