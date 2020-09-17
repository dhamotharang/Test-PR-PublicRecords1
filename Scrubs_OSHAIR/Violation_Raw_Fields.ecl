IMPORT SALT311;
IMPORT Scrubs,Scrubs_Oshair; // Import modules for FieldTypes attribute definitions
EXPORT Violation_Raw_Fields := MODULE
 
EXPORT NumFields := 26;
 
// Processing for each FieldType
EXPORT SALT311.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_numeric','invalid_numeric_blank','Invalid_rec','Invalid_viol_type','Invalid_X','invalid_alpha_numeric','Invalid_alpha_Numeric_blank','invalid_numeric_or_period','invalid_alpha_blank','invalid_date_future','invalid_date_ccyymm');
EXPORT FieldTypeNum(SALT311.StrType fn) := CASE(fn,'invalid_numeric' => 1,'invalid_numeric_blank' => 2,'Invalid_rec' => 3,'Invalid_viol_type' => 4,'Invalid_X' => 5,'invalid_alpha_numeric' => 6,'Invalid_alpha_Numeric_blank' => 7,'invalid_numeric_or_period' => 8,'invalid_alpha_blank' => 9,'invalid_date_future' => 10,'invalid_date_ccyymm' => 11,0);
 
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
 
EXPORT MakeFT_Invalid_rec(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_rec(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['1','A','C','I','F','V','D','B','R','S',' ']);
EXPORT InValidMessageFT_Invalid_rec(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('1|A|C|I|F|V|D|B|R|S| '),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_viol_type(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_viol_type(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['P','H','O','R','S','W','U','F',' ']);
EXPORT InValidMessageFT_Invalid_viol_type(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('P|H|O|R|S|W|U|F| '),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_X(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_X(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['X',' ','x']);
EXPORT InValidMessageFT_Invalid_X(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('X| |x'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_alpha_numeric(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_alpha_numeric(SALT311.StrType s) := WHICH(~Scrubs.Functions.fn_alphanum(s)>0);
EXPORT InValidMessageFT_invalid_alpha_numeric(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.Functions.fn_alphanum'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_alpha_Numeric_blank(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_alpha_Numeric_blank(SALT311.StrType s) := WHICH(~Scrubs.Functions.fn_alphaNum_or_blank(s)>0);
EXPORT InValidMessageFT_Invalid_alpha_Numeric_blank(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.Functions.fn_alphaNum_or_blank'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_numeric_or_period(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_numeric_or_period(SALT311.StrType s) := WHICH(~Scrubs_Oshair.Functions.fn_numeric_or_period(s)>0);
EXPORT InValidMessageFT_invalid_numeric_or_period(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Oshair.Functions.fn_numeric_or_period'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_alpha_blank(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_alpha_blank(SALT311.StrType s) := WHICH(~Scrubs_Oshair.Functions.fn_alpha_blank(s)>0);
EXPORT InValidMessageFT_invalid_alpha_blank(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Oshair.Functions.fn_alpha_blank'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_date_future(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_date_future(SALT311.StrType s) := WHICH(~Scrubs_Oshair.Functions.fn_date_time(s,'FUTURE')>0);
EXPORT InValidMessageFT_invalid_date_future(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Oshair.Functions.fn_date_time'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_date_ccyymm(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_date_ccyymm(SALT311.StrType s) := WHICH(~Scrubs_Oshair.Functions.fn_date_ccyymm(s)>0);
EXPORT InValidMessageFT_invalid_date_ccyymm(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Oshair.Functions.fn_date_ccyymm'),SALT311.HygieneErrors.Good);
 
EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'activity_nr','citation_id','delete_flag','viol_type','issuance_date','abate_date','current_penalty','initial_penalty','contest_date','final_order_date','nr_instances','nr_exposed','rec','gravity','emphasis','hazcat','fta_insp_nr','fta_issuance_date','fta_penalty','fta_contest_date','fta_final_order_date','hazsub1','hazsub2','hazsub3','hazsub4','hazsub5');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'activity_nr','citation_id','delete_flag','viol_type','issuance_date','abate_date','current_penalty','initial_penalty','contest_date','final_order_date','nr_instances','nr_exposed','rec','gravity','emphasis','hazcat','fta_insp_nr','fta_issuance_date','fta_penalty','fta_contest_date','fta_final_order_date','hazsub1','hazsub2','hazsub3','hazsub4','hazsub5');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'activity_nr' => 0,'citation_id' => 1,'delete_flag' => 2,'viol_type' => 3,'issuance_date' => 4,'abate_date' => 5,'current_penalty' => 6,'initial_penalty' => 7,'contest_date' => 8,'final_order_date' => 9,'nr_instances' => 10,'nr_exposed' => 11,'rec' => 12,'gravity' => 13,'emphasis' => 14,'hazcat' => 15,'fta_insp_nr' => 16,'fta_issuance_date' => 17,'fta_penalty' => 18,'fta_contest_date' => 19,'fta_final_order_date' => 20,'hazsub1' => 21,'hazsub2' => 22,'hazsub3' => 23,'hazsub4' => 24,'hazsub5' => 25,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['CUSTOM'],['CUSTOM'],['ENUM'],['ENUM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['ENUM'],['CUSTOM'],['ENUM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_activity_nr(SALT311.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_activity_nr(SALT311.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_activity_nr(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_citation_id(SALT311.StrType s0) := MakeFT_invalid_alpha_numeric(s0);
EXPORT InValid_citation_id(SALT311.StrType s) := InValidFT_invalid_alpha_numeric(s);
EXPORT InValidMessage_citation_id(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha_numeric(wh);
 
EXPORT Make_delete_flag(SALT311.StrType s0) := MakeFT_Invalid_X(s0);
EXPORT InValid_delete_flag(SALT311.StrType s) := InValidFT_Invalid_X(s);
EXPORT InValidMessage_delete_flag(UNSIGNED1 wh) := InValidMessageFT_Invalid_X(wh);
 
EXPORT Make_viol_type(SALT311.StrType s0) := MakeFT_Invalid_viol_type(s0);
EXPORT InValid_viol_type(SALT311.StrType s) := InValidFT_Invalid_viol_type(s);
EXPORT InValidMessage_viol_type(UNSIGNED1 wh) := InValidMessageFT_Invalid_viol_type(wh);
 
EXPORT Make_issuance_date(SALT311.StrType s0) := MakeFT_invalid_date_ccyymm(s0);
EXPORT InValid_issuance_date(SALT311.StrType s) := InValidFT_invalid_date_ccyymm(s);
EXPORT InValidMessage_issuance_date(UNSIGNED1 wh) := InValidMessageFT_invalid_date_ccyymm(wh);
 
EXPORT Make_abate_date(SALT311.StrType s0) := MakeFT_invalid_date_future(s0);
EXPORT InValid_abate_date(SALT311.StrType s) := InValidFT_invalid_date_future(s);
EXPORT InValidMessage_abate_date(UNSIGNED1 wh) := InValidMessageFT_invalid_date_future(wh);
 
EXPORT Make_current_penalty(SALT311.StrType s0) := MakeFT_invalid_numeric_or_period(s0);
EXPORT InValid_current_penalty(SALT311.StrType s) := InValidFT_invalid_numeric_or_period(s);
EXPORT InValidMessage_current_penalty(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric_or_period(wh);
 
EXPORT Make_initial_penalty(SALT311.StrType s0) := MakeFT_invalid_numeric_or_period(s0);
EXPORT InValid_initial_penalty(SALT311.StrType s) := InValidFT_invalid_numeric_or_period(s);
EXPORT InValidMessage_initial_penalty(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric_or_period(wh);
 
EXPORT Make_contest_date(SALT311.StrType s0) := MakeFT_invalid_date_ccyymm(s0);
EXPORT InValid_contest_date(SALT311.StrType s) := InValidFT_invalid_date_ccyymm(s);
EXPORT InValidMessage_contest_date(UNSIGNED1 wh) := InValidMessageFT_invalid_date_ccyymm(wh);
 
EXPORT Make_final_order_date(SALT311.StrType s0) := MakeFT_invalid_date_future(s0);
EXPORT InValid_final_order_date(SALT311.StrType s) := InValidFT_invalid_date_future(s);
EXPORT InValidMessage_final_order_date(UNSIGNED1 wh) := InValidMessageFT_invalid_date_future(wh);
 
EXPORT Make_nr_instances(SALT311.StrType s0) := MakeFT_invalid_numeric_blank(s0);
EXPORT InValid_nr_instances(SALT311.StrType s) := InValidFT_invalid_numeric_blank(s);
EXPORT InValidMessage_nr_instances(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric_blank(wh);
 
EXPORT Make_nr_exposed(SALT311.StrType s0) := MakeFT_invalid_numeric_blank(s0);
EXPORT InValid_nr_exposed(SALT311.StrType s) := InValidFT_invalid_numeric_blank(s);
EXPORT InValidMessage_nr_exposed(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric_blank(wh);
 
EXPORT Make_rec(SALT311.StrType s0) := MakeFT_Invalid_rec(s0);
EXPORT InValid_rec(SALT311.StrType s) := InValidFT_Invalid_rec(s);
EXPORT InValidMessage_rec(UNSIGNED1 wh) := InValidMessageFT_Invalid_rec(wh);
 
EXPORT Make_gravity(SALT311.StrType s0) := MakeFT_invalid_numeric_blank(s0);
EXPORT InValid_gravity(SALT311.StrType s) := InValidFT_invalid_numeric_blank(s);
EXPORT InValidMessage_gravity(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric_blank(wh);
 
EXPORT Make_emphasis(SALT311.StrType s0) := MakeFT_Invalid_X(s0);
EXPORT InValid_emphasis(SALT311.StrType s) := InValidFT_Invalid_X(s);
EXPORT InValidMessage_emphasis(UNSIGNED1 wh) := InValidMessageFT_Invalid_X(wh);
 
EXPORT Make_hazcat(SALT311.StrType s0) := MakeFT_invalid_alpha_blank(s0);
EXPORT InValid_hazcat(SALT311.StrType s) := InValidFT_invalid_alpha_blank(s);
EXPORT InValidMessage_hazcat(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha_blank(wh);
 
EXPORT Make_fta_insp_nr(SALT311.StrType s0) := MakeFT_invalid_numeric_blank(s0);
EXPORT InValid_fta_insp_nr(SALT311.StrType s) := InValidFT_invalid_numeric_blank(s);
EXPORT InValidMessage_fta_insp_nr(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric_blank(wh);
 
EXPORT Make_fta_issuance_date(SALT311.StrType s0) := MakeFT_invalid_date_ccyymm(s0);
EXPORT InValid_fta_issuance_date(SALT311.StrType s) := InValidFT_invalid_date_ccyymm(s);
EXPORT InValidMessage_fta_issuance_date(UNSIGNED1 wh) := InValidMessageFT_invalid_date_ccyymm(wh);
 
EXPORT Make_fta_penalty(SALT311.StrType s0) := MakeFT_invalid_numeric_or_period(s0);
EXPORT InValid_fta_penalty(SALT311.StrType s) := InValidFT_invalid_numeric_or_period(s);
EXPORT InValidMessage_fta_penalty(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric_or_period(wh);
 
EXPORT Make_fta_contest_date(SALT311.StrType s0) := MakeFT_invalid_date_ccyymm(s0);
EXPORT InValid_fta_contest_date(SALT311.StrType s) := InValidFT_invalid_date_ccyymm(s);
EXPORT InValidMessage_fta_contest_date(UNSIGNED1 wh) := InValidMessageFT_invalid_date_ccyymm(wh);
 
EXPORT Make_fta_final_order_date(SALT311.StrType s0) := MakeFT_invalid_date_ccyymm(s0);
EXPORT InValid_fta_final_order_date(SALT311.StrType s) := InValidFT_invalid_date_ccyymm(s);
EXPORT InValidMessage_fta_final_order_date(UNSIGNED1 wh) := InValidMessageFT_invalid_date_ccyymm(wh);
 
EXPORT Make_hazsub1(SALT311.StrType s0) := MakeFT_Invalid_alpha_Numeric_blank(s0);
EXPORT InValid_hazsub1(SALT311.StrType s) := InValidFT_Invalid_alpha_Numeric_blank(s);
EXPORT InValidMessage_hazsub1(UNSIGNED1 wh) := InValidMessageFT_Invalid_alpha_Numeric_blank(wh);
 
EXPORT Make_hazsub2(SALT311.StrType s0) := MakeFT_Invalid_alpha_Numeric_blank(s0);
EXPORT InValid_hazsub2(SALT311.StrType s) := InValidFT_Invalid_alpha_Numeric_blank(s);
EXPORT InValidMessage_hazsub2(UNSIGNED1 wh) := InValidMessageFT_Invalid_alpha_Numeric_blank(wh);
 
EXPORT Make_hazsub3(SALT311.StrType s0) := MakeFT_Invalid_alpha_Numeric_blank(s0);
EXPORT InValid_hazsub3(SALT311.StrType s) := InValidFT_Invalid_alpha_Numeric_blank(s);
EXPORT InValidMessage_hazsub3(UNSIGNED1 wh) := InValidMessageFT_Invalid_alpha_Numeric_blank(wh);
 
EXPORT Make_hazsub4(SALT311.StrType s0) := MakeFT_Invalid_alpha_Numeric_blank(s0);
EXPORT InValid_hazsub4(SALT311.StrType s) := InValidFT_Invalid_alpha_Numeric_blank(s);
EXPORT InValidMessage_hazsub4(UNSIGNED1 wh) := InValidMessageFT_Invalid_alpha_Numeric_blank(wh);
 
EXPORT Make_hazsub5(SALT311.StrType s0) := MakeFT_Invalid_alpha_Numeric_blank(s0);
EXPORT InValid_hazsub5(SALT311.StrType s) := InValidFT_Invalid_alpha_Numeric_blank(s);
EXPORT InValidMessage_hazsub5(UNSIGNED1 wh) := InValidMessageFT_Invalid_alpha_Numeric_blank(wh);
 
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
    BOOLEAN Diff_activity_nr;
    BOOLEAN Diff_citation_id;
    BOOLEAN Diff_delete_flag;
    BOOLEAN Diff_viol_type;
    BOOLEAN Diff_issuance_date;
    BOOLEAN Diff_abate_date;
    BOOLEAN Diff_current_penalty;
    BOOLEAN Diff_initial_penalty;
    BOOLEAN Diff_contest_date;
    BOOLEAN Diff_final_order_date;
    BOOLEAN Diff_nr_instances;
    BOOLEAN Diff_nr_exposed;
    BOOLEAN Diff_rec;
    BOOLEAN Diff_gravity;
    BOOLEAN Diff_emphasis;
    BOOLEAN Diff_hazcat;
    BOOLEAN Diff_fta_insp_nr;
    BOOLEAN Diff_fta_issuance_date;
    BOOLEAN Diff_fta_penalty;
    BOOLEAN Diff_fta_contest_date;
    BOOLEAN Diff_fta_final_order_date;
    BOOLEAN Diff_hazsub1;
    BOOLEAN Diff_hazsub2;
    BOOLEAN Diff_hazsub3;
    BOOLEAN Diff_hazsub4;
    BOOLEAN Diff_hazsub5;
    UNSIGNED Num_Diffs;
    SALT311.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_activity_nr := le.activity_nr <> ri.activity_nr;
    SELF.Diff_citation_id := le.citation_id <> ri.citation_id;
    SELF.Diff_delete_flag := le.delete_flag <> ri.delete_flag;
    SELF.Diff_viol_type := le.viol_type <> ri.viol_type;
    SELF.Diff_issuance_date := le.issuance_date <> ri.issuance_date;
    SELF.Diff_abate_date := le.abate_date <> ri.abate_date;
    SELF.Diff_current_penalty := le.current_penalty <> ri.current_penalty;
    SELF.Diff_initial_penalty := le.initial_penalty <> ri.initial_penalty;
    SELF.Diff_contest_date := le.contest_date <> ri.contest_date;
    SELF.Diff_final_order_date := le.final_order_date <> ri.final_order_date;
    SELF.Diff_nr_instances := le.nr_instances <> ri.nr_instances;
    SELF.Diff_nr_exposed := le.nr_exposed <> ri.nr_exposed;
    SELF.Diff_rec := le.rec <> ri.rec;
    SELF.Diff_gravity := le.gravity <> ri.gravity;
    SELF.Diff_emphasis := le.emphasis <> ri.emphasis;
    SELF.Diff_hazcat := le.hazcat <> ri.hazcat;
    SELF.Diff_fta_insp_nr := le.fta_insp_nr <> ri.fta_insp_nr;
    SELF.Diff_fta_issuance_date := le.fta_issuance_date <> ri.fta_issuance_date;
    SELF.Diff_fta_penalty := le.fta_penalty <> ri.fta_penalty;
    SELF.Diff_fta_contest_date := le.fta_contest_date <> ri.fta_contest_date;
    SELF.Diff_fta_final_order_date := le.fta_final_order_date <> ri.fta_final_order_date;
    SELF.Diff_hazsub1 := le.hazsub1 <> ri.hazsub1;
    SELF.Diff_hazsub2 := le.hazsub2 <> ri.hazsub2;
    SELF.Diff_hazsub3 := le.hazsub3 <> ri.hazsub3;
    SELF.Diff_hazsub4 := le.hazsub4 <> ri.hazsub4;
    SELF.Diff_hazsub5 := le.hazsub5 <> ri.hazsub5;
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_activity_nr,1,0)+ IF( SELF.Diff_citation_id,1,0)+ IF( SELF.Diff_delete_flag,1,0)+ IF( SELF.Diff_viol_type,1,0)+ IF( SELF.Diff_issuance_date,1,0)+ IF( SELF.Diff_abate_date,1,0)+ IF( SELF.Diff_current_penalty,1,0)+ IF( SELF.Diff_initial_penalty,1,0)+ IF( SELF.Diff_contest_date,1,0)+ IF( SELF.Diff_final_order_date,1,0)+ IF( SELF.Diff_nr_instances,1,0)+ IF( SELF.Diff_nr_exposed,1,0)+ IF( SELF.Diff_rec,1,0)+ IF( SELF.Diff_gravity,1,0)+ IF( SELF.Diff_emphasis,1,0)+ IF( SELF.Diff_hazcat,1,0)+ IF( SELF.Diff_fta_insp_nr,1,0)+ IF( SELF.Diff_fta_issuance_date,1,0)+ IF( SELF.Diff_fta_penalty,1,0)+ IF( SELF.Diff_fta_contest_date,1,0)+ IF( SELF.Diff_fta_final_order_date,1,0)+ IF( SELF.Diff_hazsub1,1,0)+ IF( SELF.Diff_hazsub2,1,0)+ IF( SELF.Diff_hazsub3,1,0)+ IF( SELF.Diff_hazsub4,1,0)+ IF( SELF.Diff_hazsub5,1,0);
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
    Count_Diff_activity_nr := COUNT(GROUP,%Closest%.Diff_activity_nr);
    Count_Diff_citation_id := COUNT(GROUP,%Closest%.Diff_citation_id);
    Count_Diff_delete_flag := COUNT(GROUP,%Closest%.Diff_delete_flag);
    Count_Diff_viol_type := COUNT(GROUP,%Closest%.Diff_viol_type);
    Count_Diff_issuance_date := COUNT(GROUP,%Closest%.Diff_issuance_date);
    Count_Diff_abate_date := COUNT(GROUP,%Closest%.Diff_abate_date);
    Count_Diff_current_penalty := COUNT(GROUP,%Closest%.Diff_current_penalty);
    Count_Diff_initial_penalty := COUNT(GROUP,%Closest%.Diff_initial_penalty);
    Count_Diff_contest_date := COUNT(GROUP,%Closest%.Diff_contest_date);
    Count_Diff_final_order_date := COUNT(GROUP,%Closest%.Diff_final_order_date);
    Count_Diff_nr_instances := COUNT(GROUP,%Closest%.Diff_nr_instances);
    Count_Diff_nr_exposed := COUNT(GROUP,%Closest%.Diff_nr_exposed);
    Count_Diff_rec := COUNT(GROUP,%Closest%.Diff_rec);
    Count_Diff_gravity := COUNT(GROUP,%Closest%.Diff_gravity);
    Count_Diff_emphasis := COUNT(GROUP,%Closest%.Diff_emphasis);
    Count_Diff_hazcat := COUNT(GROUP,%Closest%.Diff_hazcat);
    Count_Diff_fta_insp_nr := COUNT(GROUP,%Closest%.Diff_fta_insp_nr);
    Count_Diff_fta_issuance_date := COUNT(GROUP,%Closest%.Diff_fta_issuance_date);
    Count_Diff_fta_penalty := COUNT(GROUP,%Closest%.Diff_fta_penalty);
    Count_Diff_fta_contest_date := COUNT(GROUP,%Closest%.Diff_fta_contest_date);
    Count_Diff_fta_final_order_date := COUNT(GROUP,%Closest%.Diff_fta_final_order_date);
    Count_Diff_hazsub1 := COUNT(GROUP,%Closest%.Diff_hazsub1);
    Count_Diff_hazsub2 := COUNT(GROUP,%Closest%.Diff_hazsub2);
    Count_Diff_hazsub3 := COUNT(GROUP,%Closest%.Diff_hazsub3);
    Count_Diff_hazsub4 := COUNT(GROUP,%Closest%.Diff_hazsub4);
    Count_Diff_hazsub5 := COUNT(GROUP,%Closest%.Diff_hazsub5);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
