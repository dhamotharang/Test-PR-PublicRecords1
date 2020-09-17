IMPORT SALT311;
IMPORT Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT RelatedActivity_Raw_Fields := MODULE
 
EXPORT NumFields := 4;
 
// Processing for each FieldType
EXPORT SALT311.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_numeric','Invalid_X');
EXPORT FieldTypeNum(SALT311.StrType fn) := CASE(fn,'invalid_numeric' => 1,'Invalid_X' => 2,0);
 
EXPORT MakeFT_invalid_numeric(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_numeric(SALT311.StrType s) := WHICH(~Scrubs.Functions.fn_numeric(s)>0);
EXPORT InValidMessageFT_invalid_numeric(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.Functions.fn_numeric'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_X(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_X(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['X','']);
EXPORT InValidMessageFT_Invalid_X(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('X|'),SALT311.HygieneErrors.Good);
 
EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'activity_nr','rel_act_nr','rel_safety','rel_health');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'activity_nr','rel_act_nr','rel_safety','rel_health');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'activity_nr' => 0,'rel_act_nr' => 1,'rel_safety' => 2,'rel_health' => 3,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['CUSTOM'],['CUSTOM'],['ENUM'],['ENUM'],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_activity_nr(SALT311.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_activity_nr(SALT311.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_activity_nr(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_rel_act_nr(SALT311.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_rel_act_nr(SALT311.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_rel_act_nr(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_rel_safety(SALT311.StrType s0) := MakeFT_Invalid_X(s0);
EXPORT InValid_rel_safety(SALT311.StrType s) := InValidFT_Invalid_X(s);
EXPORT InValidMessage_rel_safety(UNSIGNED1 wh) := InValidMessageFT_Invalid_X(wh);
 
EXPORT Make_rel_health(SALT311.StrType s0) := MakeFT_Invalid_X(s0);
EXPORT InValid_rel_health(SALT311.StrType s) := InValidFT_Invalid_X(s);
EXPORT InValidMessage_rel_health(UNSIGNED1 wh) := InValidMessageFT_Invalid_X(wh);
 
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
    BOOLEAN Diff_rel_act_nr;
    BOOLEAN Diff_rel_safety;
    BOOLEAN Diff_rel_health;
    UNSIGNED Num_Diffs;
    SALT311.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_activity_nr := le.activity_nr <> ri.activity_nr;
    SELF.Diff_rel_act_nr := le.rel_act_nr <> ri.rel_act_nr;
    SELF.Diff_rel_safety := le.rel_safety <> ri.rel_safety;
    SELF.Diff_rel_health := le.rel_health <> ri.rel_health;
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_activity_nr,1,0)+ IF( SELF.Diff_rel_act_nr,1,0)+ IF( SELF.Diff_rel_safety,1,0)+ IF( SELF.Diff_rel_health,1,0);
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
    Count_Diff_rel_act_nr := COUNT(GROUP,%Closest%.Diff_rel_act_nr);
    Count_Diff_rel_safety := COUNT(GROUP,%Closest%.Diff_rel_safety);
    Count_Diff_rel_health := COUNT(GROUP,%Closest%.Diff_rel_health);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
