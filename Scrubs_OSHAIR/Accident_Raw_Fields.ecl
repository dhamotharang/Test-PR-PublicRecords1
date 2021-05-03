IMPORT SALT311;
IMPORT Scrubs,Scrubs_Oshair; // Import modules for FieldTypes attribute definitions
EXPORT Accident_Raw_Fields := MODULE
 
EXPORT NumFields := 10;
 
// Processing for each FieldType
EXPORT SALT311.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_numeric','invalid_numeric_blank','invalid_date_time','invalid_const_end_use','invalid_project_cost','invalid_project_type','invalid_sic_list','invalid_fatality');
EXPORT FieldTypeNum(SALT311.StrType fn) := CASE(fn,'invalid_numeric' => 1,'invalid_numeric_blank' => 2,'invalid_date_time' => 3,'invalid_const_end_use' => 4,'invalid_project_cost' => 5,'invalid_project_type' => 6,'invalid_sic_list' => 7,'invalid_fatality' => 8,0);
 
EXPORT MakeFT_invalid_numeric(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_numeric(SALT311.StrType s) := WHICH(~Scrubs.Functions.fn_numeric(s)>0);
EXPORT InValidMessageFT_invalid_numeric(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.Functions.fn_numeric'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_numeric_blank(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_numeric_blank(SALT311.StrType s) := WHICH(~Scrubs_Oshair.Functions.fn_numeric_or_blank(s)>0);
EXPORT InValidMessageFT_invalid_numeric_blank(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Oshair.Functions.fn_numeric_or_blank'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_date_time(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_date_time(SALT311.StrType s) := WHICH(~Scrubs_Oshair.Functions.fn_date_time(s)>0);
EXPORT InValidMessageFT_invalid_date_time(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Oshair.Functions.fn_date_time'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_const_end_use(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_const_end_use(SALT311.StrType s) := WHICH(~Scrubs_Oshair.Functions.fn_const_end_use(s)>0);
EXPORT InValidMessageFT_invalid_const_end_use(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Oshair.Functions.fn_const_end_use'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_project_cost(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_project_cost(SALT311.StrType s) := WHICH(~Scrubs_Oshair.Functions.fn_project_cost(s)>0);
EXPORT InValidMessageFT_invalid_project_cost(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Oshair.Functions.fn_project_cost'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_project_type(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_project_type(SALT311.StrType s) := WHICH(~Scrubs_Oshair.Functions.fn_project_type(s)>0);
EXPORT InValidMessageFT_invalid_project_type(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Oshair.Functions.fn_project_type'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_sic_list(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_sic_list(SALT311.StrType s) := WHICH(~Scrubs_Oshair.Functions.fn_numeric_or_comma(s)>0);
EXPORT InValidMessageFT_invalid_sic_list(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Oshair.Functions.fn_numeric_or_comma'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_fatality(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_fatality(SALT311.StrType s) := WHICH(~Scrubs_Oshair.Functions.fn_fatality(s)>0);
EXPORT InValidMessageFT_invalid_fatality(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Oshair.Functions.fn_fatality'),SALT311.HygieneErrors.Good);
 
EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'summary_nr','report_id','event_date_time','const_end_use','build_stories','nonbuild_ht','project_cost','project_type','sic_list','fatality');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'summary_nr','report_id','event_date_time','const_end_use','build_stories','nonbuild_ht','project_cost','project_type','sic_list','fatality');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'summary_nr' => 0,'report_id' => 1,'event_date_time' => 2,'const_end_use' => 3,'build_stories' => 4,'nonbuild_ht' => 5,'project_cost' => 6,'project_type' => 7,'sic_list' => 8,'fatality' => 9,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_summary_nr(SALT311.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_summary_nr(SALT311.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_summary_nr(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_report_id(SALT311.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_report_id(SALT311.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_report_id(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_event_date_time(SALT311.StrType s0) := MakeFT_invalid_date_time(s0);
EXPORT InValid_event_date_time(SALT311.StrType s) := InValidFT_invalid_date_time(s);
EXPORT InValidMessage_event_date_time(UNSIGNED1 wh) := InValidMessageFT_invalid_date_time(wh);
 
EXPORT Make_const_end_use(SALT311.StrType s0) := MakeFT_invalid_const_end_use(s0);
EXPORT InValid_const_end_use(SALT311.StrType s) := InValidFT_invalid_const_end_use(s);
EXPORT InValidMessage_const_end_use(UNSIGNED1 wh) := InValidMessageFT_invalid_const_end_use(wh);
 
EXPORT Make_build_stories(SALT311.StrType s0) := MakeFT_invalid_numeric_blank(s0);
EXPORT InValid_build_stories(SALT311.StrType s) := InValidFT_invalid_numeric_blank(s);
EXPORT InValidMessage_build_stories(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric_blank(wh);
 
EXPORT Make_nonbuild_ht(SALT311.StrType s0) := MakeFT_invalid_numeric_blank(s0);
EXPORT InValid_nonbuild_ht(SALT311.StrType s) := InValidFT_invalid_numeric_blank(s);
EXPORT InValidMessage_nonbuild_ht(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric_blank(wh);
 
EXPORT Make_project_cost(SALT311.StrType s0) := MakeFT_invalid_project_cost(s0);
EXPORT InValid_project_cost(SALT311.StrType s) := InValidFT_invalid_project_cost(s);
EXPORT InValidMessage_project_cost(UNSIGNED1 wh) := InValidMessageFT_invalid_project_cost(wh);
 
EXPORT Make_project_type(SALT311.StrType s0) := MakeFT_invalid_project_type(s0);
EXPORT InValid_project_type(SALT311.StrType s) := InValidFT_invalid_project_type(s);
EXPORT InValidMessage_project_type(UNSIGNED1 wh) := InValidMessageFT_invalid_project_type(wh);
 
EXPORT Make_sic_list(SALT311.StrType s0) := MakeFT_invalid_sic_list(s0);
EXPORT InValid_sic_list(SALT311.StrType s) := InValidFT_invalid_sic_list(s);
EXPORT InValidMessage_sic_list(UNSIGNED1 wh) := InValidMessageFT_invalid_sic_list(wh);
 
EXPORT Make_fatality(SALT311.StrType s0) := MakeFT_invalid_fatality(s0);
EXPORT InValid_fatality(SALT311.StrType s) := InValidFT_invalid_fatality(s);
EXPORT InValidMessage_fatality(UNSIGNED1 wh) := InValidMessageFT_invalid_fatality(wh);
 
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
    BOOLEAN Diff_report_id;
    BOOLEAN Diff_event_date_time;
    BOOLEAN Diff_const_end_use;
    BOOLEAN Diff_build_stories;
    BOOLEAN Diff_nonbuild_ht;
    BOOLEAN Diff_project_cost;
    BOOLEAN Diff_project_type;
    BOOLEAN Diff_sic_list;
    BOOLEAN Diff_fatality;
    UNSIGNED Num_Diffs;
    SALT311.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_summary_nr := le.summary_nr <> ri.summary_nr;
    SELF.Diff_report_id := le.report_id <> ri.report_id;
    SELF.Diff_event_date_time := le.event_date_time <> ri.event_date_time;
    SELF.Diff_const_end_use := le.const_end_use <> ri.const_end_use;
    SELF.Diff_build_stories := le.build_stories <> ri.build_stories;
    SELF.Diff_nonbuild_ht := le.nonbuild_ht <> ri.nonbuild_ht;
    SELF.Diff_project_cost := le.project_cost <> ri.project_cost;
    SELF.Diff_project_type := le.project_type <> ri.project_type;
    SELF.Diff_sic_list := le.sic_list <> ri.sic_list;
    SELF.Diff_fatality := le.fatality <> ri.fatality;
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_summary_nr,1,0)+ IF( SELF.Diff_report_id,1,0)+ IF( SELF.Diff_event_date_time,1,0)+ IF( SELF.Diff_const_end_use,1,0)+ IF( SELF.Diff_build_stories,1,0)+ IF( SELF.Diff_nonbuild_ht,1,0)+ IF( SELF.Diff_project_cost,1,0)+ IF( SELF.Diff_project_type,1,0)+ IF( SELF.Diff_sic_list,1,0)+ IF( SELF.Diff_fatality,1,0);
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
    Count_Diff_report_id := COUNT(GROUP,%Closest%.Diff_report_id);
    Count_Diff_event_date_time := COUNT(GROUP,%Closest%.Diff_event_date_time);
    Count_Diff_const_end_use := COUNT(GROUP,%Closest%.Diff_const_end_use);
    Count_Diff_build_stories := COUNT(GROUP,%Closest%.Diff_build_stories);
    Count_Diff_nonbuild_ht := COUNT(GROUP,%Closest%.Diff_nonbuild_ht);
    Count_Diff_project_cost := COUNT(GROUP,%Closest%.Diff_project_cost);
    Count_Diff_project_type := COUNT(GROUP,%Closest%.Diff_project_type);
    Count_Diff_sic_list := COUNT(GROUP,%Closest%.Diff_sic_list);
    Count_Diff_fatality := COUNT(GROUP,%Closest%.Diff_fatality);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
