IMPORT SALT311;
EXPORT BS_Fields := MODULE
 
EXPORT NumFields := 10;
 
// Processing for each FieldType
EXPORT SALT311.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_segment_identifier','invalid_file_sequence_number','invalid_parent_sequence_number','invalid_account_base_ab_number','invalid_business_name','invalid_web_address','invalid_guarantor_owner_indicator','invalid_relationship_to_business_indicator','invalid_percent_of_liability','invalid_percent_of_ownership_if_owner_principal');
EXPORT FieldTypeNum(SALT311.StrType fn) := CASE(fn,'invalid_segment_identifier' => 1,'invalid_file_sequence_number' => 2,'invalid_parent_sequence_number' => 3,'invalid_account_base_ab_number' => 4,'invalid_business_name' => 5,'invalid_web_address' => 6,'invalid_guarantor_owner_indicator' => 7,'invalid_relationship_to_business_indicator' => 8,'invalid_percent_of_liability' => 9,'invalid_percent_of_ownership_if_owner_principal' => 10,0);
 
EXPORT MakeFT_invalid_segment_identifier(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_segment_identifier(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['BS','BS']);
EXPORT InValidMessageFT_invalid_segment_identifier(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('BS|BS'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_file_sequence_number(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_file_sequence_number(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) >= 1));
EXPORT InValidMessageFT_invalid_file_sequence_number(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789'),SALT311.HygieneErrors.NotLength('1..'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_parent_sequence_number(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_parent_sequence_number(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) >= 1));
EXPORT InValidMessageFT_invalid_parent_sequence_number(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789'),SALT311.HygieneErrors.NotLength('1..'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_account_base_ab_number(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_account_base_ab_number(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) >= 1));
EXPORT InValidMessageFT_invalid_account_base_ab_number(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789'),SALT311.HygieneErrors.NotLength('1..'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_business_name(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 ,&.\'-/#`+"!*@():;'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_business_name(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 ,&.\'-/#`+"!*@():;'))),~(LENGTH(TRIM(s)) >= 1));
EXPORT InValidMessageFT_invalid_business_name(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 ,&.\'-/#`+"!*@():;'),SALT311.HygieneErrors.NotLength('1..'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_web_address(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789./ '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_web_address(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789./ '))));
EXPORT InValidMessageFT_invalid_web_address(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789./ '),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_guarantor_owner_indicator(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_guarantor_owner_indicator(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['001','002','003']);
EXPORT InValidMessageFT_invalid_guarantor_owner_indicator(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('001|002|003'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_relationship_to_business_indicator(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_relationship_to_business_indicator(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_invalid_relationship_to_business_indicator(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_percent_of_liability(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_percent_of_liability(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_invalid_percent_of_liability(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_percent_of_ownership_if_owner_principal(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_percent_of_ownership_if_owner_principal(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_invalid_percent_of_ownership_if_owner_principal(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789'),SALT311.HygieneErrors.Good);
 
EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'segment_identifier','file_sequence_number','parent_sequence_number','account_base_number','business_name','web_address','guarantor_owner_indicator','relationship_to_business_indicator','percent_of_liability','percent_of_ownership_if_owner_principal');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'segment_identifier','file_sequence_number','parent_sequence_number','account_base_number','business_name','web_address','guarantor_owner_indicator','relationship_to_business_indicator','percent_of_liability','percent_of_ownership_if_owner_principal');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'segment_identifier' => 0,'file_sequence_number' => 1,'parent_sequence_number' => 2,'account_base_number' => 3,'business_name' => 4,'web_address' => 5,'guarantor_owner_indicator' => 6,'relationship_to_business_indicator' => 7,'percent_of_liability' => 8,'percent_of_ownership_if_owner_principal' => 9,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['ENUM'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW'],['ENUM'],['ALLOW'],['ALLOW'],['ALLOW'],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_segment_identifier(SALT311.StrType s0) := MakeFT_invalid_segment_identifier(s0);
EXPORT InValid_segment_identifier(SALT311.StrType s) := InValidFT_invalid_segment_identifier(s);
EXPORT InValidMessage_segment_identifier(UNSIGNED1 wh) := InValidMessageFT_invalid_segment_identifier(wh);
 
EXPORT Make_file_sequence_number(SALT311.StrType s0) := MakeFT_invalid_file_sequence_number(s0);
EXPORT InValid_file_sequence_number(SALT311.StrType s) := InValidFT_invalid_file_sequence_number(s);
EXPORT InValidMessage_file_sequence_number(UNSIGNED1 wh) := InValidMessageFT_invalid_file_sequence_number(wh);
 
EXPORT Make_parent_sequence_number(SALT311.StrType s0) := MakeFT_invalid_parent_sequence_number(s0);
EXPORT InValid_parent_sequence_number(SALT311.StrType s) := InValidFT_invalid_parent_sequence_number(s);
EXPORT InValidMessage_parent_sequence_number(UNSIGNED1 wh) := InValidMessageFT_invalid_parent_sequence_number(wh);
 
EXPORT Make_account_base_number(SALT311.StrType s0) := MakeFT_invalid_account_base_ab_number(s0);
EXPORT InValid_account_base_number(SALT311.StrType s) := InValidFT_invalid_account_base_ab_number(s);
EXPORT InValidMessage_account_base_number(UNSIGNED1 wh) := InValidMessageFT_invalid_account_base_ab_number(wh);
 
EXPORT Make_business_name(SALT311.StrType s0) := MakeFT_invalid_business_name(s0);
EXPORT InValid_business_name(SALT311.StrType s) := InValidFT_invalid_business_name(s);
EXPORT InValidMessage_business_name(UNSIGNED1 wh) := InValidMessageFT_invalid_business_name(wh);
 
EXPORT Make_web_address(SALT311.StrType s0) := MakeFT_invalid_web_address(s0);
EXPORT InValid_web_address(SALT311.StrType s) := InValidFT_invalid_web_address(s);
EXPORT InValidMessage_web_address(UNSIGNED1 wh) := InValidMessageFT_invalid_web_address(wh);
 
EXPORT Make_guarantor_owner_indicator(SALT311.StrType s0) := MakeFT_invalid_guarantor_owner_indicator(s0);
EXPORT InValid_guarantor_owner_indicator(SALT311.StrType s) := InValidFT_invalid_guarantor_owner_indicator(s);
EXPORT InValidMessage_guarantor_owner_indicator(UNSIGNED1 wh) := InValidMessageFT_invalid_guarantor_owner_indicator(wh);
 
EXPORT Make_relationship_to_business_indicator(SALT311.StrType s0) := MakeFT_invalid_relationship_to_business_indicator(s0);
EXPORT InValid_relationship_to_business_indicator(SALT311.StrType s) := InValidFT_invalid_relationship_to_business_indicator(s);
EXPORT InValidMessage_relationship_to_business_indicator(UNSIGNED1 wh) := InValidMessageFT_invalid_relationship_to_business_indicator(wh);
 
EXPORT Make_percent_of_liability(SALT311.StrType s0) := MakeFT_invalid_percent_of_liability(s0);
EXPORT InValid_percent_of_liability(SALT311.StrType s) := InValidFT_invalid_percent_of_liability(s);
EXPORT InValidMessage_percent_of_liability(UNSIGNED1 wh) := InValidMessageFT_invalid_percent_of_liability(wh);
 
EXPORT Make_percent_of_ownership_if_owner_principal(SALT311.StrType s0) := MakeFT_invalid_percent_of_ownership_if_owner_principal(s0);
EXPORT InValid_percent_of_ownership_if_owner_principal(SALT311.StrType s) := InValidFT_invalid_percent_of_ownership_if_owner_principal(s);
EXPORT InValidMessage_percent_of_ownership_if_owner_principal(UNSIGNED1 wh) := InValidMessageFT_invalid_percent_of_ownership_if_owner_principal(wh);
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT311,Scrubs_Business_Credit;
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
    BOOLEAN Diff_business_name;
    BOOLEAN Diff_web_address;
    BOOLEAN Diff_guarantor_owner_indicator;
    BOOLEAN Diff_relationship_to_business_indicator;
    BOOLEAN Diff_percent_of_liability;
    BOOLEAN Diff_percent_of_ownership_if_owner_principal;
    UNSIGNED Num_Diffs;
    SALT311.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_segment_identifier := le.segment_identifier <> ri.segment_identifier;
    SELF.Diff_file_sequence_number := le.file_sequence_number <> ri.file_sequence_number;
    SELF.Diff_parent_sequence_number := le.parent_sequence_number <> ri.parent_sequence_number;
    SELF.Diff_account_base_number := le.account_base_number <> ri.account_base_number;
    SELF.Diff_business_name := le.business_name <> ri.business_name;
    SELF.Diff_web_address := le.web_address <> ri.web_address;
    SELF.Diff_guarantor_owner_indicator := le.guarantor_owner_indicator <> ri.guarantor_owner_indicator;
    SELF.Diff_relationship_to_business_indicator := le.relationship_to_business_indicator <> ri.relationship_to_business_indicator;
    SELF.Diff_percent_of_liability := le.percent_of_liability <> ri.percent_of_liability;
    SELF.Diff_percent_of_ownership_if_owner_principal := le.percent_of_ownership_if_owner_principal <> ri.percent_of_ownership_if_owner_principal;
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_segment_identifier,1,0)+ IF( SELF.Diff_file_sequence_number,1,0)+ IF( SELF.Diff_parent_sequence_number,1,0)+ IF( SELF.Diff_account_base_number,1,0)+ IF( SELF.Diff_business_name,1,0)+ IF( SELF.Diff_web_address,1,0)+ IF( SELF.Diff_guarantor_owner_indicator,1,0)+ IF( SELF.Diff_relationship_to_business_indicator,1,0)+ IF( SELF.Diff_percent_of_liability,1,0)+ IF( SELF.Diff_percent_of_ownership_if_owner_principal,1,0);
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
    Count_Diff_business_name := COUNT(GROUP,%Closest%.Diff_business_name);
    Count_Diff_web_address := COUNT(GROUP,%Closest%.Diff_web_address);
    Count_Diff_guarantor_owner_indicator := COUNT(GROUP,%Closest%.Diff_guarantor_owner_indicator);
    Count_Diff_relationship_to_business_indicator := COUNT(GROUP,%Closest%.Diff_relationship_to_business_indicator);
    Count_Diff_percent_of_liability := COUNT(GROUP,%Closest%.Diff_percent_of_liability);
    Count_Diff_percent_of_ownership_if_owner_principal := COUNT(GROUP,%Closest%.Diff_percent_of_ownership_if_owner_principal);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
