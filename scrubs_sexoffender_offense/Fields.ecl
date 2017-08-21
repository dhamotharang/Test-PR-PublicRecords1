IMPORT ut,SALT33;
EXPORT Fields := MODULE
// Processing for each FieldType
EXPORT SALT33.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_date','invalid_age');
EXPORT FieldTypeNum(SALT33.StrType fn) := CASE(fn,'invalid_date' => 1,'invalid_age' => 2,0);
EXPORT MakeFT_invalid_date(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_date(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_invalid_date(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('0123456789'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_age(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_age(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_invalid_age(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('0123456789'),SALT33.HygieneErrors.Good);
EXPORT SALT33.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'orig_state','orig_state_code','vendor_code','source_file','seisint_primary_key','conviction_jurisdiction','conviction_date','court','court_case_number','offense_date','offense_code_or_statute','offense_description','offense_description_2','offense_category','victim_minor','victim_age','victim_gender','victim_relationship','sentence_description','sentence_description_2','arrest_date','arrest_warrant','fcra_conviction_flag','fcra_traffic_flag','fcra_date','fcra_date_type','conviction_override_date','conviction_override_date_type','offense_score','offense_persistent_id');
EXPORT FieldNum(SALT33.StrType fn) := CASE(fn,'orig_state' => 0,'orig_state_code' => 1,'vendor_code' => 2,'source_file' => 3,'seisint_primary_key' => 4,'conviction_jurisdiction' => 5,'conviction_date' => 6,'court' => 7,'court_case_number' => 8,'offense_date' => 9,'offense_code_or_statute' => 10,'offense_description' => 11,'offense_description_2' => 12,'offense_category' => 13,'victim_minor' => 14,'victim_age' => 15,'victim_gender' => 16,'victim_relationship' => 17,'sentence_description' => 18,'sentence_description_2' => 19,'arrest_date' => 20,'arrest_warrant' => 21,'fcra_conviction_flag' => 22,'fcra_traffic_flag' => 23,'fcra_date' => 24,'fcra_date_type' => 25,'conviction_override_date' => 26,'conviction_override_date_type' => 27,'offense_score' => 28,'offense_persistent_id' => 29,0);
//Individual field level validation
EXPORT Make_orig_state(SALT33.StrType s0) := s0;
EXPORT InValid_orig_state(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_orig_state(UNSIGNED1 wh) := '';
EXPORT Make_orig_state_code(SALT33.StrType s0) := s0;
EXPORT InValid_orig_state_code(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_orig_state_code(UNSIGNED1 wh) := '';
EXPORT Make_vendor_code(SALT33.StrType s0) := s0;
EXPORT InValid_vendor_code(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_vendor_code(UNSIGNED1 wh) := '';
EXPORT Make_source_file(SALT33.StrType s0) := s0;
EXPORT InValid_source_file(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_source_file(UNSIGNED1 wh) := '';
EXPORT Make_seisint_primary_key(SALT33.StrType s0) := s0;
EXPORT InValid_seisint_primary_key(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_seisint_primary_key(UNSIGNED1 wh) := '';
EXPORT Make_conviction_jurisdiction(SALT33.StrType s0) := s0;
EXPORT InValid_conviction_jurisdiction(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_conviction_jurisdiction(UNSIGNED1 wh) := '';
EXPORT Make_conviction_date(SALT33.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_conviction_date(SALT33.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_conviction_date(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
EXPORT Make_court(SALT33.StrType s0) := s0;
EXPORT InValid_court(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_court(UNSIGNED1 wh) := '';
EXPORT Make_court_case_number(SALT33.StrType s0) := s0;
EXPORT InValid_court_case_number(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_court_case_number(UNSIGNED1 wh) := '';
EXPORT Make_offense_date(SALT33.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_offense_date(SALT33.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_offense_date(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
EXPORT Make_offense_code_or_statute(SALT33.StrType s0) := s0;
EXPORT InValid_offense_code_or_statute(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_offense_code_or_statute(UNSIGNED1 wh) := '';
EXPORT Make_offense_description(SALT33.StrType s0) := s0;
EXPORT InValid_offense_description(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_offense_description(UNSIGNED1 wh) := '';
EXPORT Make_offense_description_2(SALT33.StrType s0) := s0;
EXPORT InValid_offense_description_2(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_offense_description_2(UNSIGNED1 wh) := '';
EXPORT Make_offense_category(SALT33.StrType s0) := s0;
EXPORT InValid_offense_category(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_offense_category(UNSIGNED1 wh) := '';
EXPORT Make_victim_minor(SALT33.StrType s0) := s0;
EXPORT InValid_victim_minor(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_victim_minor(UNSIGNED1 wh) := '';
EXPORT Make_victim_age(SALT33.StrType s0) := MakeFT_invalid_age(s0);
EXPORT InValid_victim_age(SALT33.StrType s) := InValidFT_invalid_age(s);
EXPORT InValidMessage_victim_age(UNSIGNED1 wh) := InValidMessageFT_invalid_age(wh);
EXPORT Make_victim_gender(SALT33.StrType s0) := s0;
EXPORT InValid_victim_gender(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_victim_gender(UNSIGNED1 wh) := '';
EXPORT Make_victim_relationship(SALT33.StrType s0) := s0;
EXPORT InValid_victim_relationship(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_victim_relationship(UNSIGNED1 wh) := '';
EXPORT Make_sentence_description(SALT33.StrType s0) := s0;
EXPORT InValid_sentence_description(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_sentence_description(UNSIGNED1 wh) := '';
EXPORT Make_sentence_description_2(SALT33.StrType s0) := s0;
EXPORT InValid_sentence_description_2(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_sentence_description_2(UNSIGNED1 wh) := '';
EXPORT Make_arrest_date(SALT33.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_arrest_date(SALT33.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_arrest_date(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
EXPORT Make_arrest_warrant(SALT33.StrType s0) := s0;
EXPORT InValid_arrest_warrant(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_arrest_warrant(UNSIGNED1 wh) := '';
EXPORT Make_fcra_conviction_flag(SALT33.StrType s0) := s0;
EXPORT InValid_fcra_conviction_flag(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_fcra_conviction_flag(UNSIGNED1 wh) := '';
EXPORT Make_fcra_traffic_flag(SALT33.StrType s0) := s0;
EXPORT InValid_fcra_traffic_flag(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_fcra_traffic_flag(UNSIGNED1 wh) := '';
EXPORT Make_fcra_date(SALT33.StrType s0) := s0;
EXPORT InValid_fcra_date(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_fcra_date(UNSIGNED1 wh) := '';
EXPORT Make_fcra_date_type(SALT33.StrType s0) := s0;
EXPORT InValid_fcra_date_type(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_fcra_date_type(UNSIGNED1 wh) := '';
EXPORT Make_conviction_override_date(SALT33.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_conviction_override_date(SALT33.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_conviction_override_date(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
EXPORT Make_conviction_override_date_type(SALT33.StrType s0) := s0;
EXPORT InValid_conviction_override_date_type(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_conviction_override_date_type(UNSIGNED1 wh) := '';
EXPORT Make_offense_score(SALT33.StrType s0) := s0;
EXPORT InValid_offense_score(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_offense_score(UNSIGNED1 wh) := '';
EXPORT Make_offense_persistent_id(SALT33.StrType s0) := s0;
EXPORT InValid_offense_persistent_id(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_offense_persistent_id(UNSIGNED1 wh) := '';
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT33,scrubs_sexoffender_offense;
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
    BOOLEAN Diff_orig_state;
    BOOLEAN Diff_orig_state_code;
    BOOLEAN Diff_vendor_code;
    BOOLEAN Diff_source_file;
    BOOLEAN Diff_seisint_primary_key;
    BOOLEAN Diff_conviction_jurisdiction;
    BOOLEAN Diff_conviction_date;
    BOOLEAN Diff_court;
    BOOLEAN Diff_court_case_number;
    BOOLEAN Diff_offense_date;
    BOOLEAN Diff_offense_code_or_statute;
    BOOLEAN Diff_offense_description;
    BOOLEAN Diff_offense_description_2;
    BOOLEAN Diff_offense_category;
    BOOLEAN Diff_victim_minor;
    BOOLEAN Diff_victim_age;
    BOOLEAN Diff_victim_gender;
    BOOLEAN Diff_victim_relationship;
    BOOLEAN Diff_sentence_description;
    BOOLEAN Diff_sentence_description_2;
    BOOLEAN Diff_arrest_date;
    BOOLEAN Diff_arrest_warrant;
    BOOLEAN Diff_fcra_conviction_flag;
    BOOLEAN Diff_fcra_traffic_flag;
    BOOLEAN Diff_fcra_date;
    BOOLEAN Diff_fcra_date_type;
    BOOLEAN Diff_conviction_override_date;
    BOOLEAN Diff_conviction_override_date_type;
    BOOLEAN Diff_offense_score;
    BOOLEAN Diff_offense_persistent_id;
    SALT33.StrType SourceField {MAXLENGTH(30)};
    UNSIGNED Num_Diffs;
    SALT33.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_orig_state := le.orig_state <> ri.orig_state;
    SELF.Diff_orig_state_code := le.orig_state_code <> ri.orig_state_code;
    SELF.Diff_vendor_code := le.vendor_code <> ri.vendor_code;
    SELF.Diff_source_file := le.source_file <> ri.source_file;
    SELF.Diff_seisint_primary_key := le.seisint_primary_key <> ri.seisint_primary_key;
    SELF.Diff_conviction_jurisdiction := le.conviction_jurisdiction <> ri.conviction_jurisdiction;
    SELF.Diff_conviction_date := le.conviction_date <> ri.conviction_date;
    SELF.Diff_court := le.court <> ri.court;
    SELF.Diff_court_case_number := le.court_case_number <> ri.court_case_number;
    SELF.Diff_offense_date := le.offense_date <> ri.offense_date;
    SELF.Diff_offense_code_or_statute := le.offense_code_or_statute <> ri.offense_code_or_statute;
    SELF.Diff_offense_description := le.offense_description <> ri.offense_description;
    SELF.Diff_offense_description_2 := le.offense_description_2 <> ri.offense_description_2;
    SELF.Diff_offense_category := le.offense_category <> ri.offense_category;
    SELF.Diff_victim_minor := le.victim_minor <> ri.victim_minor;
    SELF.Diff_victim_age := le.victim_age <> ri.victim_age;
    SELF.Diff_victim_gender := le.victim_gender <> ri.victim_gender;
    SELF.Diff_victim_relationship := le.victim_relationship <> ri.victim_relationship;
    SELF.Diff_sentence_description := le.sentence_description <> ri.sentence_description;
    SELF.Diff_sentence_description_2 := le.sentence_description_2 <> ri.sentence_description_2;
    SELF.Diff_arrest_date := le.arrest_date <> ri.arrest_date;
    SELF.Diff_arrest_warrant := le.arrest_warrant <> ri.arrest_warrant;
    SELF.Diff_fcra_conviction_flag := le.fcra_conviction_flag <> ri.fcra_conviction_flag;
    SELF.Diff_fcra_traffic_flag := le.fcra_traffic_flag <> ri.fcra_traffic_flag;
    SELF.Diff_fcra_date := le.fcra_date <> ri.fcra_date;
    SELF.Diff_fcra_date_type := le.fcra_date_type <> ri.fcra_date_type;
    SELF.Diff_conviction_override_date := le.conviction_override_date <> ri.conviction_override_date;
    SELF.Diff_conviction_override_date_type := le.conviction_override_date_type <> ri.conviction_override_date_type;
    SELF.Diff_offense_score := le.offense_score <> ri.offense_score;
    SELF.Diff_offense_persistent_id := le.offense_persistent_id <> ri.offense_persistent_id;
    SELF.Val := (SALT33.StrType)evaluate(le,pivot_exp);
    SELF.SourceField := le.orig_state_code;
    SELF.Num_Diffs := 0+ IF( SELF.Diff_orig_state,1,0)+ IF( SELF.Diff_orig_state_code,1,0)+ IF( SELF.Diff_vendor_code,1,0)+ IF( SELF.Diff_source_file,1,0)+ IF( SELF.Diff_seisint_primary_key,1,0)+ IF( SELF.Diff_conviction_jurisdiction,1,0)+ IF( SELF.Diff_conviction_date,1,0)+ IF( SELF.Diff_court,1,0)+ IF( SELF.Diff_court_case_number,1,0)+ IF( SELF.Diff_offense_date,1,0)+ IF( SELF.Diff_offense_code_or_statute,1,0)+ IF( SELF.Diff_offense_description,1,0)+ IF( SELF.Diff_offense_description_2,1,0)+ IF( SELF.Diff_offense_category,1,0)+ IF( SELF.Diff_victim_minor,1,0)+ IF( SELF.Diff_victim_age,1,0)+ IF( SELF.Diff_victim_gender,1,0)+ IF( SELF.Diff_victim_relationship,1,0)+ IF( SELF.Diff_sentence_description,1,0)+ IF( SELF.Diff_sentence_description_2,1,0)+ IF( SELF.Diff_arrest_date,1,0)+ IF( SELF.Diff_arrest_warrant,1,0)+ IF( SELF.Diff_fcra_conviction_flag,1,0)+ IF( SELF.Diff_fcra_traffic_flag,1,0)+ IF( SELF.Diff_fcra_date,1,0)+ IF( SELF.Diff_fcra_date_type,1,0)+ IF( SELF.Diff_conviction_override_date,1,0)+ IF( SELF.Diff_conviction_override_date_type,1,0)+ IF( SELF.Diff_offense_score,1,0)+ IF( SELF.Diff_offense_persistent_id,1,0);
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
    Count_Diff_orig_state := COUNT(GROUP,%Closest%.Diff_orig_state);
    Count_Diff_orig_state_code := COUNT(GROUP,%Closest%.Diff_orig_state_code);
    Count_Diff_vendor_code := COUNT(GROUP,%Closest%.Diff_vendor_code);
    Count_Diff_source_file := COUNT(GROUP,%Closest%.Diff_source_file);
    Count_Diff_seisint_primary_key := COUNT(GROUP,%Closest%.Diff_seisint_primary_key);
    Count_Diff_conviction_jurisdiction := COUNT(GROUP,%Closest%.Diff_conviction_jurisdiction);
    Count_Diff_conviction_date := COUNT(GROUP,%Closest%.Diff_conviction_date);
    Count_Diff_court := COUNT(GROUP,%Closest%.Diff_court);
    Count_Diff_court_case_number := COUNT(GROUP,%Closest%.Diff_court_case_number);
    Count_Diff_offense_date := COUNT(GROUP,%Closest%.Diff_offense_date);
    Count_Diff_offense_code_or_statute := COUNT(GROUP,%Closest%.Diff_offense_code_or_statute);
    Count_Diff_offense_description := COUNT(GROUP,%Closest%.Diff_offense_description);
    Count_Diff_offense_description_2 := COUNT(GROUP,%Closest%.Diff_offense_description_2);
    Count_Diff_offense_category := COUNT(GROUP,%Closest%.Diff_offense_category);
    Count_Diff_victim_minor := COUNT(GROUP,%Closest%.Diff_victim_minor);
    Count_Diff_victim_age := COUNT(GROUP,%Closest%.Diff_victim_age);
    Count_Diff_victim_gender := COUNT(GROUP,%Closest%.Diff_victim_gender);
    Count_Diff_victim_relationship := COUNT(GROUP,%Closest%.Diff_victim_relationship);
    Count_Diff_sentence_description := COUNT(GROUP,%Closest%.Diff_sentence_description);
    Count_Diff_sentence_description_2 := COUNT(GROUP,%Closest%.Diff_sentence_description_2);
    Count_Diff_arrest_date := COUNT(GROUP,%Closest%.Diff_arrest_date);
    Count_Diff_arrest_warrant := COUNT(GROUP,%Closest%.Diff_arrest_warrant);
    Count_Diff_fcra_conviction_flag := COUNT(GROUP,%Closest%.Diff_fcra_conviction_flag);
    Count_Diff_fcra_traffic_flag := COUNT(GROUP,%Closest%.Diff_fcra_traffic_flag);
    Count_Diff_fcra_date := COUNT(GROUP,%Closest%.Diff_fcra_date);
    Count_Diff_fcra_date_type := COUNT(GROUP,%Closest%.Diff_fcra_date_type);
    Count_Diff_conviction_override_date := COUNT(GROUP,%Closest%.Diff_conviction_override_date);
    Count_Diff_conviction_override_date_type := COUNT(GROUP,%Closest%.Diff_conviction_override_date_type);
    Count_Diff_offense_score := COUNT(GROUP,%Closest%.Diff_offense_score);
    Count_Diff_offense_persistent_id := COUNT(GROUP,%Closest%.Diff_offense_persistent_id);
    %Closest%.SourceField;
  END;
  out_counts := table(%Closest%,%AggRec%,SourceField,few);
ENDMACRO;
END;
