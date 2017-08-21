IMPORT ut,SALT32;
EXPORT Fields := MODULE
 
// Processing for each FieldType
EXPORT SALT32.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_cd');
EXPORT FieldTypeNum(SALT32.StrType fn) := CASE(fn,'invalid_cd' => 1,0);
 
EXPORT MakeFT_invalid_cd(SALT32.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_cd(SALT32.StrType s) := WHICH(((SALT32.StrType) s) NOT IN ['01','1','02','2','03','3','04','4','05','5','06','6','07','7','08','8','09','9','10','11','12','15','16','17','20','44','45','48','62','99',' ']);
EXPORT InValidMessageFT_invalid_cd(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotInEnum('01|1|02|2|03|3|04|4|05|5|06|6|07|7|08|8|09|9|10|11|12|15|16|17|20|44|45|48|62|99| '),SALT32.HygieneErrors.Good);
 
EXPORT SALT32.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'event_filing_cd');
EXPORT FieldNum(SALT32.StrType fn) := CASE(fn,'event_filing_cd' => 0,0);
 
//Individual field level validation
 
EXPORT Make_event_filing_cd(SALT32.StrType s0) := MakeFT_invalid_cd(s0);
EXPORT InValid_event_filing_cd(SALT32.StrType s) := InValidFT_invalid_cd(s);
EXPORT InValidMessage_event_filing_cd(UNSIGNED1 wh) := InValidMessageFT_invalid_cd(wh);
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT32,Scrubs_Corp2_Mapping_AL_Event;
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
    BOOLEAN Diff_event_filing_cd;
    UNSIGNED Num_Diffs;
    SALT32.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_event_filing_cd := le.event_filing_cd <> ri.event_filing_cd;
    SELF.Val := (SALT32.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_event_filing_cd,1,0);
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
    Count_Diff_event_filing_cd := COUNT(GROUP,%Closest%.Diff_event_filing_cd);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
