IMPORT SALT311;
IMPORT Scrubs,Scrubs_OSHAIR; // Import modules for FieldTypes attribute definitions
EXPORT AccidentInjury_Raw_Fields := MODULE
 
EXPORT NumFields := 20;
 
// Processing for each FieldType
EXPORT SALT311.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_numeric','invalid_numeric_blank','invalid_date_time','invalid_sex','invalid_degree_of_inj','invalid_task_assigned','invalid_alpha_numeric');
EXPORT FieldTypeNum(SALT311.StrType fn) := CASE(fn,'invalid_numeric' => 1,'invalid_numeric_blank' => 2,'invalid_date_time' => 3,'invalid_sex' => 4,'invalid_degree_of_inj' => 5,'invalid_task_assigned' => 6,'invalid_alpha_numeric' => 7,0);
 
EXPORT MakeFT_invalid_numeric(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_numeric(SALT311.StrType s) := WHICH(~Scrubs.Functions.fn_numeric(s)>0);
EXPORT InValidMessageFT_invalid_numeric(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.Functions.fn_numeric'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_numeric_blank(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_numeric_blank(SALT311.StrType s) := WHICH(~Scrubs_OSHAIR.Functions.fn_numeric_or_blank(s)>0);
EXPORT InValidMessageFT_invalid_numeric_blank(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_OSHAIR.Functions.fn_numeric_or_blank'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_date_time(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_date_time(SALT311.StrType s) := WHICH(~Scrubs_Oshair.Functions.fn_date_time(s)>0);
EXPORT InValidMessageFT_invalid_date_time(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Oshair.Functions.fn_date_time'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_sex(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_sex(SALT311.StrType s) := WHICH(~Scrubs_Oshair.Functions.fn_sex_code(s)>0);
EXPORT InValidMessageFT_invalid_sex(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Oshair.Functions.fn_sex_code'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_degree_of_inj(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_degree_of_inj(SALT311.StrType s) := WHICH(~Scrubs_Oshair.Functions.fn_degree_inj(s)>0);
EXPORT InValidMessageFT_invalid_degree_of_inj(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Oshair.Functions.fn_degree_inj'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_task_assigned(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_task_assigned(SALT311.StrType s) := WHICH(~Scrubs_Oshair.Functions.fn_task_assigned(s)>0);
EXPORT InValidMessageFT_invalid_task_assigned(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Oshair.Functions.fn_task_assigned'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_alpha_numeric(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_alpha_numeric(SALT311.StrType s) := WHICH(~Scrubs.Functions.fn_alphaNum_or_blank(s)>0);
EXPORT InValidMessageFT_invalid_alpha_numeric(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.Functions.fn_alphaNum_or_blank'),SALT311.HygieneErrors.Good);
 
EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'summary_nr','rel_insp_nr','age','sex','nature_of_inj','part_of_body','src_of_injury','event_type','evn_factor','hum_factor','occ_code','degree_of_inj','task_assigned','hazsub','const_op','const_op_cause','fat_cause','fall_distance','fall_ht','injury_line_nr');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'summary_nr','rel_insp_nr','age','sex','nature_of_inj','part_of_body','src_of_injury','event_type','evn_factor','hum_factor','occ_code','degree_of_inj','task_assigned','hazsub','const_op','const_op_cause','fat_cause','fall_distance','fall_ht','injury_line_nr');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'summary_nr' => 0,'rel_insp_nr' => 1,'age' => 2,'sex' => 3,'nature_of_inj' => 4,'part_of_body' => 5,'src_of_injury' => 6,'event_type' => 7,'evn_factor' => 8,'hum_factor' => 9,'occ_code' => 10,'degree_of_inj' => 11,'task_assigned' => 12,'hazsub' => 13,'const_op' => 14,'const_op_cause' => 15,'fat_cause' => 16,'fall_distance' => 17,'fall_ht' => 18,'injury_line_nr' => 19,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_summary_nr(SALT311.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_summary_nr(SALT311.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_summary_nr(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_rel_insp_nr(SALT311.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_rel_insp_nr(SALT311.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_rel_insp_nr(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_age(SALT311.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_age(SALT311.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_age(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_sex(SALT311.StrType s0) := MakeFT_invalid_sex(s0);
EXPORT InValid_sex(SALT311.StrType s) := InValidFT_invalid_sex(s);
EXPORT InValidMessage_sex(UNSIGNED1 wh) := InValidMessageFT_invalid_sex(wh);
 
EXPORT Make_nature_of_inj(SALT311.StrType s0) := MakeFT_invalid_numeric_blank(s0);
EXPORT InValid_nature_of_inj(SALT311.StrType s) := InValidFT_invalid_numeric_blank(s);
EXPORT InValidMessage_nature_of_inj(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric_blank(wh);
 
EXPORT Make_part_of_body(SALT311.StrType s0) := MakeFT_invalid_numeric_blank(s0);
EXPORT InValid_part_of_body(SALT311.StrType s) := InValidFT_invalid_numeric_blank(s);
EXPORT InValidMessage_part_of_body(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric_blank(wh);
 
EXPORT Make_src_of_injury(SALT311.StrType s0) := MakeFT_invalid_numeric_blank(s0);
EXPORT InValid_src_of_injury(SALT311.StrType s) := InValidFT_invalid_numeric_blank(s);
EXPORT InValidMessage_src_of_injury(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric_blank(wh);
 
EXPORT Make_event_type(SALT311.StrType s0) := MakeFT_invalid_numeric_blank(s0);
EXPORT InValid_event_type(SALT311.StrType s) := InValidFT_invalid_numeric_blank(s);
EXPORT InValidMessage_event_type(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric_blank(wh);
 
EXPORT Make_evn_factor(SALT311.StrType s0) := MakeFT_invalid_numeric_blank(s0);
EXPORT InValid_evn_factor(SALT311.StrType s) := InValidFT_invalid_numeric_blank(s);
EXPORT InValidMessage_evn_factor(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric_blank(wh);
 
EXPORT Make_hum_factor(SALT311.StrType s0) := MakeFT_invalid_numeric_blank(s0);
EXPORT InValid_hum_factor(SALT311.StrType s) := InValidFT_invalid_numeric_blank(s);
EXPORT InValidMessage_hum_factor(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric_blank(wh);
 
EXPORT Make_occ_code(SALT311.StrType s0) := MakeFT_invalid_numeric_blank(s0);
EXPORT InValid_occ_code(SALT311.StrType s) := InValidFT_invalid_numeric_blank(s);
EXPORT InValidMessage_occ_code(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric_blank(wh);
 
EXPORT Make_degree_of_inj(SALT311.StrType s0) := MakeFT_invalid_degree_of_inj(s0);
EXPORT InValid_degree_of_inj(SALT311.StrType s) := InValidFT_invalid_degree_of_inj(s);
EXPORT InValidMessage_degree_of_inj(UNSIGNED1 wh) := InValidMessageFT_invalid_degree_of_inj(wh);
 
EXPORT Make_task_assigned(SALT311.StrType s0) := MakeFT_invalid_task_assigned(s0);
EXPORT InValid_task_assigned(SALT311.StrType s) := InValidFT_invalid_task_assigned(s);
EXPORT InValidMessage_task_assigned(UNSIGNED1 wh) := InValidMessageFT_invalid_task_assigned(wh);
 
EXPORT Make_hazsub(SALT311.StrType s0) := MakeFT_invalid_alpha_numeric(s0);
EXPORT InValid_hazsub(SALT311.StrType s) := InValidFT_invalid_alpha_numeric(s);
EXPORT InValidMessage_hazsub(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha_numeric(wh);
 
EXPORT Make_const_op(SALT311.StrType s0) := MakeFT_invalid_numeric_blank(s0);
EXPORT InValid_const_op(SALT311.StrType s) := InValidFT_invalid_numeric_blank(s);
EXPORT InValidMessage_const_op(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric_blank(wh);
 
EXPORT Make_const_op_cause(SALT311.StrType s0) := MakeFT_invalid_numeric_blank(s0);
EXPORT InValid_const_op_cause(SALT311.StrType s) := InValidFT_invalid_numeric_blank(s);
EXPORT InValidMessage_const_op_cause(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric_blank(wh);
 
EXPORT Make_fat_cause(SALT311.StrType s0) := MakeFT_invalid_numeric_blank(s0);
EXPORT InValid_fat_cause(SALT311.StrType s) := InValidFT_invalid_numeric_blank(s);
EXPORT InValidMessage_fat_cause(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric_blank(wh);
 
EXPORT Make_fall_distance(SALT311.StrType s0) := MakeFT_invalid_numeric_blank(s0);
EXPORT InValid_fall_distance(SALT311.StrType s) := InValidFT_invalid_numeric_blank(s);
EXPORT InValidMessage_fall_distance(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric_blank(wh);
 
EXPORT Make_fall_ht(SALT311.StrType s0) := MakeFT_invalid_numeric_blank(s0);
EXPORT InValid_fall_ht(SALT311.StrType s) := InValidFT_invalid_numeric_blank(s);
EXPORT InValidMessage_fall_ht(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric_blank(wh);
 
EXPORT Make_injury_line_nr(SALT311.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_injury_line_nr(SALT311.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_injury_line_nr(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT311,Scrubs_OSHAIR;
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
    BOOLEAN Diff_summary_nr;
    BOOLEAN Diff_rel_insp_nr;
    BOOLEAN Diff_age;
    BOOLEAN Diff_sex;
    BOOLEAN Diff_nature_of_inj;
    BOOLEAN Diff_part_of_body;
    BOOLEAN Diff_src_of_injury;
    BOOLEAN Diff_event_type;
    BOOLEAN Diff_evn_factor;
    BOOLEAN Diff_hum_factor;
    BOOLEAN Diff_occ_code;
    BOOLEAN Diff_degree_of_inj;
    BOOLEAN Diff_task_assigned;
    BOOLEAN Diff_hazsub;
    BOOLEAN Diff_const_op;
    BOOLEAN Diff_const_op_cause;
    BOOLEAN Diff_fat_cause;
    BOOLEAN Diff_fall_distance;
    BOOLEAN Diff_fall_ht;
    BOOLEAN Diff_injury_line_nr;
    UNSIGNED Num_Diffs;
    SALT311.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_summary_nr := le.summary_nr <> ri.summary_nr;
    SELF.Diff_rel_insp_nr := le.rel_insp_nr <> ri.rel_insp_nr;
    SELF.Diff_age := le.age <> ri.age;
    SELF.Diff_sex := le.sex <> ri.sex;
    SELF.Diff_nature_of_inj := le.nature_of_inj <> ri.nature_of_inj;
    SELF.Diff_part_of_body := le.part_of_body <> ri.part_of_body;
    SELF.Diff_src_of_injury := le.src_of_injury <> ri.src_of_injury;
    SELF.Diff_event_type := le.event_type <> ri.event_type;
    SELF.Diff_evn_factor := le.evn_factor <> ri.evn_factor;
    SELF.Diff_hum_factor := le.hum_factor <> ri.hum_factor;
    SELF.Diff_occ_code := le.occ_code <> ri.occ_code;
    SELF.Diff_degree_of_inj := le.degree_of_inj <> ri.degree_of_inj;
    SELF.Diff_task_assigned := le.task_assigned <> ri.task_assigned;
    SELF.Diff_hazsub := le.hazsub <> ri.hazsub;
    SELF.Diff_const_op := le.const_op <> ri.const_op;
    SELF.Diff_const_op_cause := le.const_op_cause <> ri.const_op_cause;
    SELF.Diff_fat_cause := le.fat_cause <> ri.fat_cause;
    SELF.Diff_fall_distance := le.fall_distance <> ri.fall_distance;
    SELF.Diff_fall_ht := le.fall_ht <> ri.fall_ht;
    SELF.Diff_injury_line_nr := le.injury_line_nr <> ri.injury_line_nr;
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_summary_nr,1,0)+ IF( SELF.Diff_rel_insp_nr,1,0)+ IF( SELF.Diff_age,1,0)+ IF( SELF.Diff_sex,1,0)+ IF( SELF.Diff_nature_of_inj,1,0)+ IF( SELF.Diff_part_of_body,1,0)+ IF( SELF.Diff_src_of_injury,1,0)+ IF( SELF.Diff_event_type,1,0)+ IF( SELF.Diff_evn_factor,1,0)+ IF( SELF.Diff_hum_factor,1,0)+ IF( SELF.Diff_occ_code,1,0)+ IF( SELF.Diff_degree_of_inj,1,0)+ IF( SELF.Diff_task_assigned,1,0)+ IF( SELF.Diff_hazsub,1,0)+ IF( SELF.Diff_const_op,1,0)+ IF( SELF.Diff_const_op_cause,1,0)+ IF( SELF.Diff_fat_cause,1,0)+ IF( SELF.Diff_fall_distance,1,0)+ IF( SELF.Diff_fall_ht,1,0)+ IF( SELF.Diff_injury_line_nr,1,0);
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
    Count_Diff_summary_nr := COUNT(GROUP,%Closest%.Diff_summary_nr);
    Count_Diff_rel_insp_nr := COUNT(GROUP,%Closest%.Diff_rel_insp_nr);
    Count_Diff_age := COUNT(GROUP,%Closest%.Diff_age);
    Count_Diff_sex := COUNT(GROUP,%Closest%.Diff_sex);
    Count_Diff_nature_of_inj := COUNT(GROUP,%Closest%.Diff_nature_of_inj);
    Count_Diff_part_of_body := COUNT(GROUP,%Closest%.Diff_part_of_body);
    Count_Diff_src_of_injury := COUNT(GROUP,%Closest%.Diff_src_of_injury);
    Count_Diff_event_type := COUNT(GROUP,%Closest%.Diff_event_type);
    Count_Diff_evn_factor := COUNT(GROUP,%Closest%.Diff_evn_factor);
    Count_Diff_hum_factor := COUNT(GROUP,%Closest%.Diff_hum_factor);
    Count_Diff_occ_code := COUNT(GROUP,%Closest%.Diff_occ_code);
    Count_Diff_degree_of_inj := COUNT(GROUP,%Closest%.Diff_degree_of_inj);
    Count_Diff_task_assigned := COUNT(GROUP,%Closest%.Diff_task_assigned);
    Count_Diff_hazsub := COUNT(GROUP,%Closest%.Diff_hazsub);
    Count_Diff_const_op := COUNT(GROUP,%Closest%.Diff_const_op);
    Count_Diff_const_op_cause := COUNT(GROUP,%Closest%.Diff_const_op_cause);
    Count_Diff_fat_cause := COUNT(GROUP,%Closest%.Diff_fat_cause);
    Count_Diff_fall_distance := COUNT(GROUP,%Closest%.Diff_fall_distance);
    Count_Diff_fall_ht := COUNT(GROUP,%Closest%.Diff_fall_ht);
    Count_Diff_injury_line_nr := COUNT(GROUP,%Closest%.Diff_injury_line_nr);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
