IMPORT ut,SALT31;
IMPORT Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT CL_Fields := MODULE
// Processing for each FieldType
EXPORT SALT31.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_segment_identifier','invalid_file_sequence_number','invalid_parent_sequence_number','invalid_account_base_ab_number','invalid_collateral_indicator','invalid_type_of_collateral','invalid_collateral_description','invalid_ucc_filing_number','invalid_ucc_filing_type','invalid_ucc_filing_date','invalid_ucc_filing_expiration_date','invalid_ucc_filing_jurisdiction','invalid_ucc_filing_description');
EXPORT FieldTypeNum(SALT31.StrType fn) := CASE(fn,'invalid_segment_identifier' => 1,'invalid_file_sequence_number' => 2,'invalid_parent_sequence_number' => 3,'invalid_account_base_ab_number' => 4,'invalid_collateral_indicator' => 5,'invalid_type_of_collateral' => 6,'invalid_collateral_description' => 7,'invalid_ucc_filing_number' => 8,'invalid_ucc_filing_type' => 9,'invalid_ucc_filing_date' => 10,'invalid_ucc_filing_expiration_date' => 11,'invalid_ucc_filing_jurisdiction' => 12,'invalid_ucc_filing_description' => 13,0);
EXPORT MakeFT_invalid_segment_identifier(SALT31.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_segment_identifier(SALT31.StrType s) := WHICH(((SALT31.StrType) s) NOT IN ['CL','CL']);
EXPORT InValidMessageFT_invalid_segment_identifier(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInEnum('CL|CL'),SALT31.HygieneErrors.Good);
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
EXPORT MakeFT_invalid_collateral_indicator(SALT31.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_collateral_indicator(SALT31.StrType s) := WHICH(((SALT31.StrType) s) NOT IN ['Y','N']);
EXPORT InValidMessageFT_invalid_collateral_indicator(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInEnum('Y|N'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_type_of_collateral(SALT31.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_type_of_collateral(SALT31.StrType s) := WHICH(((SALT31.StrType) s) NOT IN ['001','002','003','004','005','006','007','008','009','010','099','']);
EXPORT InValidMessageFT_invalid_type_of_collateral(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInEnum('001|002|003|004|005|006|007|008|009|010|099|'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_collateral_description(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_collateral_description(SALT31.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'))));
EXPORT InValidMessageFT_invalid_collateral_description(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_ucc_filing_number(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_ucc_filing_number(SALT31.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'))));
EXPORT InValidMessageFT_invalid_ucc_filing_number(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_ucc_filing_type(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_ucc_filing_type(SALT31.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_invalid_ucc_filing_type(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInChars('0123456789'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_ucc_filing_date(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_ucc_filing_date(SALT31.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789'))),~Scrubs.fn_valid_date(s)>0,~(LENGTH(TRIM(s)) = 8 OR LENGTH(TRIM(s)) = 6 OR LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_ucc_filing_date(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInChars('0123456789'),SALT31.HygieneErrors.CustomFail('Scrubs.fn_valid_date'),SALT31.HygieneErrors.NotLength('8,6,4,0'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_ucc_filing_expiration_date(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_ucc_filing_expiration_date(SALT31.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789'))),~Scrubs.fn_valid_date(s)>0,~(LENGTH(TRIM(s)) = 8 OR LENGTH(TRIM(s)) = 6 OR LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_ucc_filing_expiration_date(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInChars('0123456789'),SALT31.HygieneErrors.CustomFail('Scrubs.fn_valid_date'),SALT31.HygieneErrors.NotLength('8,6,4,0'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_ucc_filing_jurisdiction(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_ucc_filing_jurisdiction(SALT31.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'))));
EXPORT InValidMessageFT_invalid_ucc_filing_jurisdiction(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_ucc_filing_description(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_ucc_filing_description(SALT31.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'))));
EXPORT InValidMessageFT_invalid_ucc_filing_description(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'),SALT31.HygieneErrors.Good);
EXPORT SALT31.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'segment_identifier','file_sequence_number','parent_sequence_number','account_base_number','collateral_indicator','type_of_collateral_secured_for_this_account','collateral_description','ucc_filing_number','ucc_filing_type','ucc_filing_date','ucc_filing_expiration_date','ucc_filing_jurisdiction','ucc_filing_description');
EXPORT FieldNum(SALT31.StrType fn) := CASE(fn,'segment_identifier' => 1,'file_sequence_number' => 2,'parent_sequence_number' => 3,'account_base_number' => 4,'collateral_indicator' => 5,'type_of_collateral_secured_for_this_account' => 6,'collateral_description' => 7,'ucc_filing_number' => 8,'ucc_filing_type' => 9,'ucc_filing_date' => 10,'ucc_filing_expiration_date' => 11,'ucc_filing_jurisdiction' => 12,'ucc_filing_description' => 13,0);
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
EXPORT Make_collateral_indicator(SALT31.StrType s0) := MakeFT_invalid_collateral_indicator(s0);
EXPORT InValid_collateral_indicator(SALT31.StrType s) := InValidFT_invalid_collateral_indicator(s);
EXPORT InValidMessage_collateral_indicator(UNSIGNED1 wh) := InValidMessageFT_invalid_collateral_indicator(wh);
EXPORT Make_type_of_collateral_secured_for_this_account(SALT31.StrType s0) := MakeFT_invalid_type_of_collateral(s0);
EXPORT InValid_type_of_collateral_secured_for_this_account(SALT31.StrType s) := InValidFT_invalid_type_of_collateral(s);
EXPORT InValidMessage_type_of_collateral_secured_for_this_account(UNSIGNED1 wh) := InValidMessageFT_invalid_type_of_collateral(wh);
EXPORT Make_collateral_description(SALT31.StrType s0) := MakeFT_invalid_collateral_description(s0);
EXPORT InValid_collateral_description(SALT31.StrType s) := InValidFT_invalid_collateral_description(s);
EXPORT InValidMessage_collateral_description(UNSIGNED1 wh) := InValidMessageFT_invalid_collateral_description(wh);
EXPORT Make_ucc_filing_number(SALT31.StrType s0) := MakeFT_invalid_ucc_filing_number(s0);
EXPORT InValid_ucc_filing_number(SALT31.StrType s) := InValidFT_invalid_ucc_filing_number(s);
EXPORT InValidMessage_ucc_filing_number(UNSIGNED1 wh) := InValidMessageFT_invalid_ucc_filing_number(wh);
EXPORT Make_ucc_filing_type(SALT31.StrType s0) := MakeFT_invalid_ucc_filing_type(s0);
EXPORT InValid_ucc_filing_type(SALT31.StrType s) := InValidFT_invalid_ucc_filing_type(s);
EXPORT InValidMessage_ucc_filing_type(UNSIGNED1 wh) := InValidMessageFT_invalid_ucc_filing_type(wh);
EXPORT Make_ucc_filing_date(SALT31.StrType s0) := MakeFT_invalid_ucc_filing_date(s0);
EXPORT InValid_ucc_filing_date(SALT31.StrType s) := InValidFT_invalid_ucc_filing_date(s);
EXPORT InValidMessage_ucc_filing_date(UNSIGNED1 wh) := InValidMessageFT_invalid_ucc_filing_date(wh);
EXPORT Make_ucc_filing_expiration_date(SALT31.StrType s0) := MakeFT_invalid_ucc_filing_expiration_date(s0);
EXPORT InValid_ucc_filing_expiration_date(SALT31.StrType s) := InValidFT_invalid_ucc_filing_expiration_date(s);
EXPORT InValidMessage_ucc_filing_expiration_date(UNSIGNED1 wh) := InValidMessageFT_invalid_ucc_filing_expiration_date(wh);
EXPORT Make_ucc_filing_jurisdiction(SALT31.StrType s0) := MakeFT_invalid_ucc_filing_jurisdiction(s0);
EXPORT InValid_ucc_filing_jurisdiction(SALT31.StrType s) := InValidFT_invalid_ucc_filing_jurisdiction(s);
EXPORT InValidMessage_ucc_filing_jurisdiction(UNSIGNED1 wh) := InValidMessageFT_invalid_ucc_filing_jurisdiction(wh);
EXPORT Make_ucc_filing_description(SALT31.StrType s0) := MakeFT_invalid_ucc_filing_description(s0);
EXPORT InValid_ucc_filing_description(SALT31.StrType s) := InValidFT_invalid_ucc_filing_description(s);
EXPORT InValidMessage_ucc_filing_description(UNSIGNED1 wh) := InValidMessageFT_invalid_ucc_filing_description(wh);
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
    BOOLEAN Diff_collateral_indicator;
    BOOLEAN Diff_type_of_collateral_secured_for_this_account;
    BOOLEAN Diff_collateral_description;
    BOOLEAN Diff_ucc_filing_number;
    BOOLEAN Diff_ucc_filing_type;
    BOOLEAN Diff_ucc_filing_date;
    BOOLEAN Diff_ucc_filing_expiration_date;
    BOOLEAN Diff_ucc_filing_jurisdiction;
    BOOLEAN Diff_ucc_filing_description;
    UNSIGNED Num_Diffs;
    SALT31.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_segment_identifier := le.segment_identifier <> ri.segment_identifier;
    SELF.Diff_file_sequence_number := le.file_sequence_number <> ri.file_sequence_number;
    SELF.Diff_parent_sequence_number := le.parent_sequence_number <> ri.parent_sequence_number;
    SELF.Diff_account_base_number := le.account_base_number <> ri.account_base_number;
    SELF.Diff_collateral_indicator := le.collateral_indicator <> ri.collateral_indicator;
    SELF.Diff_type_of_collateral_secured_for_this_account := le.type_of_collateral_secured_for_this_account <> ri.type_of_collateral_secured_for_this_account;
    SELF.Diff_collateral_description := le.collateral_description <> ri.collateral_description;
    SELF.Diff_ucc_filing_number := le.ucc_filing_number <> ri.ucc_filing_number;
    SELF.Diff_ucc_filing_type := le.ucc_filing_type <> ri.ucc_filing_type;
    SELF.Diff_ucc_filing_date := le.ucc_filing_date <> ri.ucc_filing_date;
    SELF.Diff_ucc_filing_expiration_date := le.ucc_filing_expiration_date <> ri.ucc_filing_expiration_date;
    SELF.Diff_ucc_filing_jurisdiction := le.ucc_filing_jurisdiction <> ri.ucc_filing_jurisdiction;
    SELF.Diff_ucc_filing_description := le.ucc_filing_description <> ri.ucc_filing_description;
    SELF.Val := (SALT31.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_segment_identifier,1,0)+ IF( SELF.Diff_file_sequence_number,1,0)+ IF( SELF.Diff_parent_sequence_number,1,0)+ IF( SELF.Diff_account_base_number,1,0)+ IF( SELF.Diff_collateral_indicator,1,0)+ IF( SELF.Diff_type_of_collateral_secured_for_this_account,1,0)+ IF( SELF.Diff_collateral_description,1,0)+ IF( SELF.Diff_ucc_filing_number,1,0)+ IF( SELF.Diff_ucc_filing_type,1,0)+ IF( SELF.Diff_ucc_filing_date,1,0)+ IF( SELF.Diff_ucc_filing_expiration_date,1,0)+ IF( SELF.Diff_ucc_filing_jurisdiction,1,0)+ IF( SELF.Diff_ucc_filing_description,1,0);
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
    Count_Diff_collateral_indicator := COUNT(GROUP,%Closest%.Diff_collateral_indicator);
    Count_Diff_type_of_collateral_secured_for_this_account := COUNT(GROUP,%Closest%.Diff_type_of_collateral_secured_for_this_account);
    Count_Diff_collateral_description := COUNT(GROUP,%Closest%.Diff_collateral_description);
    Count_Diff_ucc_filing_number := COUNT(GROUP,%Closest%.Diff_ucc_filing_number);
    Count_Diff_ucc_filing_type := COUNT(GROUP,%Closest%.Diff_ucc_filing_type);
    Count_Diff_ucc_filing_date := COUNT(GROUP,%Closest%.Diff_ucc_filing_date);
    Count_Diff_ucc_filing_expiration_date := COUNT(GROUP,%Closest%.Diff_ucc_filing_expiration_date);
    Count_Diff_ucc_filing_jurisdiction := COUNT(GROUP,%Closest%.Diff_ucc_filing_jurisdiction);
    Count_Diff_ucc_filing_description := COUNT(GROUP,%Closest%.Diff_ucc_filing_description);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
