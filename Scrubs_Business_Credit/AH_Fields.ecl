IMPORT ut,SALT31;
IMPORT Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT AH_Fields := MODULE
// Processing for each FieldType
EXPORT SALT31.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_segment_identifier','invalid_file_sequence_number','invalid_parent_sequence_number','invalid_account_base_ab_number','invalid_previous_member_id','invalid_previous_account_number','invalid_previous_account_type','invalid_type_of_conversion_maintenance','invalid_date_account_converted');
EXPORT FieldTypeNum(SALT31.StrType fn) := CASE(fn,'invalid_segment_identifier' => 1,'invalid_file_sequence_number' => 2,'invalid_parent_sequence_number' => 3,'invalid_account_base_ab_number' => 4,'invalid_previous_member_id' => 5,'invalid_previous_account_number' => 6,'invalid_previous_account_type' => 7,'invalid_type_of_conversion_maintenance' => 8,'invalid_date_account_converted' => 9,0);
EXPORT MakeFT_invalid_segment_identifier(SALT31.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_segment_identifier(SALT31.StrType s) := WHICH(((SALT31.StrType) s) NOT IN ['AH','AH']);
EXPORT InValidMessageFT_invalid_segment_identifier(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInEnum('AH|AH'),SALT31.HygieneErrors.Good);
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
EXPORT MakeFT_invalid_previous_member_id(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_previous_member_id(SALT31.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'))));
EXPORT InValidMessageFT_invalid_previous_member_id(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_previous_account_number(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_previous_account_number(SALT31.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-'))));
EXPORT InValidMessageFT_invalid_previous_account_number(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_previous_account_type(SALT31.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_previous_account_type(SALT31.StrType s) := WHICH(((SALT31.StrType) s) NOT IN ['001','002','003','004','005','006','099','']);
EXPORT InValidMessageFT_invalid_previous_account_type(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInEnum('001|002|003|004|005|006|099|'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_type_of_conversion_maintenance(SALT31.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_type_of_conversion_maintenance(SALT31.StrType s) := WHICH(((SALT31.StrType) s) NOT IN ['001','002','003','004','005','006','']);
EXPORT InValidMessageFT_invalid_type_of_conversion_maintenance(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInEnum('001|002|003|004|005|006|'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_date_account_converted(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_date_account_converted(SALT31.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789'))),~Scrubs.fn_valid_date(s)>0,~(LENGTH(TRIM(s)) = 8 OR LENGTH(TRIM(s)) = 6 OR LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_date_account_converted(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInChars('0123456789'),SALT31.HygieneErrors.CustomFail('Scrubs.fn_valid_date'),SALT31.HygieneErrors.NotLength('8,6,4,0'),SALT31.HygieneErrors.Good);
EXPORT SALT31.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'segment_identifier','file_sequence_number','parent_sequence_number','account_base_number','previous_member_id','previous_account_number','previous_account_type','type_of_conversion_maintenance','date_account_converted');
EXPORT FieldNum(SALT31.StrType fn) := CASE(fn,'segment_identifier' => 1,'file_sequence_number' => 2,'parent_sequence_number' => 3,'account_base_number' => 4,'previous_member_id' => 5,'previous_account_number' => 6,'previous_account_type' => 7,'type_of_conversion_maintenance' => 8,'date_account_converted' => 9,0);
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
EXPORT Make_previous_member_id(SALT31.StrType s0) := MakeFT_invalid_previous_member_id(s0);
EXPORT InValid_previous_member_id(SALT31.StrType s) := InValidFT_invalid_previous_member_id(s);
EXPORT InValidMessage_previous_member_id(UNSIGNED1 wh) := InValidMessageFT_invalid_previous_member_id(wh);
EXPORT Make_previous_account_number(SALT31.StrType s0) := MakeFT_invalid_previous_account_number(s0);
EXPORT InValid_previous_account_number(SALT31.StrType s) := InValidFT_invalid_previous_account_number(s);
EXPORT InValidMessage_previous_account_number(UNSIGNED1 wh) := InValidMessageFT_invalid_previous_account_number(wh);
EXPORT Make_previous_account_type(SALT31.StrType s0) := MakeFT_invalid_previous_account_number(s0);
EXPORT InValid_previous_account_type(SALT31.StrType s) := InValidFT_invalid_previous_account_number(s);
EXPORT InValidMessage_previous_account_type(UNSIGNED1 wh) := InValidMessageFT_invalid_previous_account_number(wh);
EXPORT Make_type_of_conversion_maintenance(SALT31.StrType s0) := MakeFT_invalid_type_of_conversion_maintenance(s0);
EXPORT InValid_type_of_conversion_maintenance(SALT31.StrType s) := InValidFT_invalid_type_of_conversion_maintenance(s);
EXPORT InValidMessage_type_of_conversion_maintenance(UNSIGNED1 wh) := InValidMessageFT_invalid_type_of_conversion_maintenance(wh);
EXPORT Make_date_account_converted(SALT31.StrType s0) := MakeFT_invalid_date_account_converted(s0);
EXPORT InValid_date_account_converted(SALT31.StrType s) := InValidFT_invalid_date_account_converted(s);
EXPORT InValidMessage_date_account_converted(UNSIGNED1 wh) := InValidMessageFT_invalid_date_account_converted(wh);
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
    BOOLEAN Diff_previous_member_id;
    BOOLEAN Diff_previous_account_number;
    BOOLEAN Diff_previous_account_type;
    BOOLEAN Diff_type_of_conversion_maintenance;
    BOOLEAN Diff_date_account_converted;
    UNSIGNED Num_Diffs;
    SALT31.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_segment_identifier := le.segment_identifier <> ri.segment_identifier;
    SELF.Diff_file_sequence_number := le.file_sequence_number <> ri.file_sequence_number;
    SELF.Diff_parent_sequence_number := le.parent_sequence_number <> ri.parent_sequence_number;
    SELF.Diff_account_base_number := le.account_base_number <> ri.account_base_number;
    SELF.Diff_previous_member_id := le.previous_member_id <> ri.previous_member_id;
    SELF.Diff_previous_account_number := le.previous_account_number <> ri.previous_account_number;
    SELF.Diff_previous_account_type := le.previous_account_type <> ri.previous_account_type;
    SELF.Diff_type_of_conversion_maintenance := le.type_of_conversion_maintenance <> ri.type_of_conversion_maintenance;
    SELF.Diff_date_account_converted := le.date_account_converted <> ri.date_account_converted;
    SELF.Val := (SALT31.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_segment_identifier,1,0)+ IF( SELF.Diff_file_sequence_number,1,0)+ IF( SELF.Diff_parent_sequence_number,1,0)+ IF( SELF.Diff_account_base_number,1,0)+ IF( SELF.Diff_previous_member_id,1,0)+ IF( SELF.Diff_previous_account_number,1,0)+ IF( SELF.Diff_previous_account_type,1,0)+ IF( SELF.Diff_type_of_conversion_maintenance,1,0)+ IF( SELF.Diff_date_account_converted,1,0);
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
    Count_Diff_previous_member_id := COUNT(GROUP,%Closest%.Diff_previous_member_id);
    Count_Diff_previous_account_number := COUNT(GROUP,%Closest%.Diff_previous_account_number);
    Count_Diff_previous_account_type := COUNT(GROUP,%Closest%.Diff_previous_account_type);
    Count_Diff_type_of_conversion_maintenance := COUNT(GROUP,%Closest%.Diff_type_of_conversion_maintenance);
    Count_Diff_date_account_converted := COUNT(GROUP,%Closest%.Diff_date_account_converted);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
