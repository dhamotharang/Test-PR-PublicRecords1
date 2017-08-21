IMPORT ut,SALT31;
IMPORT Scrubs_PhonesInfo; // Import modules for FieldTypes attribute definitions
EXPORT DeactPattern_Fields := MODULE
// Processing for each FieldType
EXPORT SALT31.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'Invalid_Population');
EXPORT FieldTypeNum(SALT31.StrType fn) := CASE(fn,'Invalid_Population' => 1,0);
EXPORT MakeFT_Invalid_Population(SALT31.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_Population(SALT31.StrType s,SALT31.StrType patternfield,SALT31.StrType total) := WHICH(~Scrubs_PhonesInfo.fn_Population_Deact(s,patternfield,total)<1);
EXPORT InValidMessageFT_Invalid_Population(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.CustomFail('Scrubs_PhonesInfo.fn_Population_Deact'),SALT31.HygieneErrors.Good);
EXPORT SALT31.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'patternfield','population','total');
EXPORT FieldNum(SALT31.StrType fn) := CASE(fn,'patternfield' => 1,'population' => 2,'total' => 3,0);
//Individual field level validation
EXPORT Make_patternfield(SALT31.StrType s0) := s0;
EXPORT InValid_patternfield(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_patternfield(UNSIGNED1 wh) := '';
EXPORT Make_population(SALT31.StrType s0) := MakeFT_Invalid_Population(s0);
EXPORT InValid_population(SALT31.StrType s,SALT31.StrType patternfield,SALT31.StrType total) := InValidFT_Invalid_Population(s,patternfield,total);
EXPORT InValidMessage_population(UNSIGNED1 wh) := InValidMessageFT_Invalid_Population(wh);
EXPORT Make_total(SALT31.StrType s0) := s0;
EXPORT InValid_total(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_total(UNSIGNED1 wh) := '';
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT31,Scrubs_PhonesInfo;
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
    BOOLEAN Diff_patternfield;
    BOOLEAN Diff_population;
    BOOLEAN Diff_total;
    UNSIGNED Num_Diffs;
    SALT31.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_patternfield := le.patternfield <> ri.patternfield;
    SELF.Diff_population := le.population <> ri.population;
    SELF.Diff_total := le.total <> ri.total;
    SELF.Val := (SALT31.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_patternfield,1,0)+ IF( SELF.Diff_population,1,0)+ IF( SELF.Diff_total,1,0);
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
    Count_Diff_patternfield := COUNT(GROUP,%Closest%.Diff_patternfield);
    Count_Diff_population := COUNT(GROUP,%Closest%.Diff_population);
    Count_Diff_total := COUNT(GROUP,%Closest%.Diff_total);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
