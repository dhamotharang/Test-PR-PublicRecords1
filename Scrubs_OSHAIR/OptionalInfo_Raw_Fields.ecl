IMPORT SALT311;
IMPORT Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT OptionalInfo_Raw_Fields := MODULE
 
EXPORT NumFields := 3;
 
// Processing for each FieldType
EXPORT SALT311.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_numeric','Invalid_opt_type');
EXPORT FieldTypeNum(SALT311.StrType fn) := CASE(fn,'invalid_numeric' => 1,'Invalid_opt_type' => 2,0);
 
EXPORT MakeFT_invalid_numeric(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_numeric(SALT311.StrType s) := WHICH(~Scrubs.Functions.fn_numeric(s)>0);
EXPORT InValidMessageFT_invalid_numeric(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.Functions.fn_numeric'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_opt_type(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_opt_type(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['N','']);
EXPORT InValidMessageFT_Invalid_opt_type(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('N|'),SALT311.HygieneErrors.Good);
 
EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'activity_nr','opt_type','opt_id');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'activity_nr','opt_type','opt_id');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'activity_nr' => 0,'opt_type' => 1,'opt_id' => 2,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['CUSTOM'],['ENUM'],['CUSTOM'],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_activity_nr(SALT311.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_activity_nr(SALT311.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_activity_nr(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_opt_type(SALT311.StrType s0) := MakeFT_Invalid_opt_type(s0);
EXPORT InValid_opt_type(SALT311.StrType s) := InValidFT_Invalid_opt_type(s);
EXPORT InValidMessage_opt_type(UNSIGNED1 wh) := InValidMessageFT_Invalid_opt_type(wh);
 
EXPORT Make_opt_id(SALT311.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_opt_id(SALT311.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_opt_id(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
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
    BOOLEAN Diff_opt_type;
    BOOLEAN Diff_opt_id;
    UNSIGNED Num_Diffs;
    SALT311.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_activity_nr := le.activity_nr <> ri.activity_nr;
    SELF.Diff_opt_type := le.opt_type <> ri.opt_type;
    SELF.Diff_opt_id := le.opt_id <> ri.opt_id;
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_activity_nr,1,0)+ IF( SELF.Diff_opt_type,1,0)+ IF( SELF.Diff_opt_id,1,0);
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
    Count_Diff_opt_type := COUNT(GROUP,%Closest%.Diff_opt_type);
    Count_Diff_opt_id := COUNT(GROUP,%Closest%.Diff_opt_id);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
