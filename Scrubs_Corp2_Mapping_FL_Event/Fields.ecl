IMPORT ut,SALT32;
EXPORT Fields := MODULE
 
// Processing for each FieldType
EXPORT SALT32.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_corp_key','invalid_charter','invalid_cd');
EXPORT FieldTypeNum(SALT32.StrType fn) := CASE(fn,'invalid_corp_key' => 1,'invalid_charter' => 2,'invalid_cd' => 3,0);
 
EXPORT MakeFT_invalid_corp_key(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_corp_key(SALT32.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-'))),~(LENGTH(TRIM(s)) >= 4 AND LENGTH(TRIM(s)) <= 15));
EXPORT InValidMessageFT_invalid_corp_key(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-'),SALT32.HygieneErrors.NotLength('4..15'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_charter(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_charter(SALT32.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'))),~(LENGTH(TRIM(s)) >= 1 AND LENGTH(TRIM(s)) <= 12));
EXPORT InValidMessageFT_invalid_charter(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'),SALT32.HygieneErrors.NotLength('1..12'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_cd(SALT32.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_cd(SALT32.StrType s) := WHICH(((SALT32.StrType) s) NOT IN set_valid_filing);
EXPORT InValidMessageFT_invalid_cd(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotInEnum('set_valid_filing'),SALT32.HygieneErrors.Good);
 
EXPORT SALT32.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'corp_key','corp_sos_charter_nbr','event_revocation_comment1');
EXPORT FieldNum(SALT32.StrType fn) := CASE(fn,'corp_key' => 0,'corp_sos_charter_nbr' => 1,'event_revocation_comment1' => 2,0);
 
//Individual field level validation
 
EXPORT Make_corp_key(SALT32.StrType s0) := MakeFT_invalid_corp_key(s0);
EXPORT InValid_corp_key(SALT32.StrType s) := InValidFT_invalid_corp_key(s);
EXPORT InValidMessage_corp_key(UNSIGNED1 wh) := InValidMessageFT_invalid_corp_key(wh);
 
EXPORT Make_corp_sos_charter_nbr(SALT32.StrType s0) := MakeFT_invalid_charter(s0);
EXPORT InValid_corp_sos_charter_nbr(SALT32.StrType s) := InValidFT_invalid_charter(s);
EXPORT InValidMessage_corp_sos_charter_nbr(UNSIGNED1 wh) := InValidMessageFT_invalid_charter(wh);
 
EXPORT Make_event_revocation_comment1(SALT32.StrType s0) := MakeFT_invalid_cd(s0);
EXPORT InValid_event_revocation_comment1(SALT32.StrType s) := InValidFT_invalid_cd(s);
EXPORT InValidMessage_event_revocation_comment1(UNSIGNED1 wh) := InValidMessageFT_invalid_cd(wh);
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT32,Scrubs_Corp2_Mapping_FL_Event;
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
    BOOLEAN Diff_corp_key;
    BOOLEAN Diff_corp_sos_charter_nbr;
    BOOLEAN Diff_event_revocation_comment1;
    UNSIGNED Num_Diffs;
    SALT32.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_corp_key := le.corp_key <> ri.corp_key;
    SELF.Diff_corp_sos_charter_nbr := le.corp_sos_charter_nbr <> ri.corp_sos_charter_nbr;
    SELF.Diff_event_revocation_comment1 := le.event_revocation_comment1 <> ri.event_revocation_comment1;
    SELF.Val := (SALT32.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_corp_key,1,0)+ IF( SELF.Diff_corp_sos_charter_nbr,1,0)+ IF( SELF.Diff_event_revocation_comment1,1,0);
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
    Count_Diff_corp_key := COUNT(GROUP,%Closest%.Diff_corp_key);
    Count_Diff_corp_sos_charter_nbr := COUNT(GROUP,%Closest%.Diff_corp_sos_charter_nbr);
    Count_Diff_event_revocation_comment1 := COUNT(GROUP,%Closest%.Diff_event_revocation_comment1);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
