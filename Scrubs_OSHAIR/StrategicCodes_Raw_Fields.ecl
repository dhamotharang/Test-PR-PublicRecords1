IMPORT SALT311;
IMPORT Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT StrategicCodes_Raw_Fields := MODULE
 
EXPORT NumFields := 2;
 
// Processing for each FieldType
EXPORT SALT311.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_numeric','Invalid_prog_type');
EXPORT FieldTypeNum(SALT311.StrType fn) := CASE(fn,'invalid_numeric' => 1,'Invalid_prog_type' => 2,0);
 
EXPORT MakeFT_invalid_numeric(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_numeric(SALT311.StrType s) := WHICH(~Scrubs.Functions.fn_numeric(s)>0);
EXPORT InValidMessageFT_invalid_numeric(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.Functions.fn_numeric'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_prog_type(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_prog_type(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['L','N','P','S']);
EXPORT InValidMessageFT_Invalid_prog_type(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('L|N|P|S'),SALT311.HygieneErrors.Good);
 
EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'activity_nr','prog_type');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'activity_nr','prog_type');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'activity_nr' => 0,'prog_type' => 1,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['CUSTOM'],['ENUM'],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_activity_nr(SALT311.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_activity_nr(SALT311.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_activity_nr(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_prog_type(SALT311.StrType s0) := MakeFT_Invalid_prog_type(s0);
EXPORT InValid_prog_type(SALT311.StrType s) := InValidFT_Invalid_prog_type(s);
EXPORT InValidMessage_prog_type(UNSIGNED1 wh) := InValidMessageFT_Invalid_prog_type(wh);
 
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
    BOOLEAN Diff_prog_type;
    UNSIGNED Num_Diffs;
    SALT311.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_activity_nr := le.activity_nr <> ri.activity_nr;
    SELF.Diff_prog_type := le.prog_type <> ri.prog_type;
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_activity_nr,1,0)+ IF( SELF.Diff_prog_type,1,0);
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
    Count_Diff_prog_type := COUNT(GROUP,%Closest%.Diff_prog_type);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
