IMPORT SALT39;
IMPORT Scrubs_Voters; // Import modules for FieldTypes attribute definitions
EXPORT Base_History_Fields := MODULE
 
EXPORT NumFields := 9;
 
// Processing for each FieldType
EXPORT SALT39.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_numeric','invalid_voted_year','invalid_pres','invalid_vote_date');
EXPORT FieldTypeNum(SALT39.StrType fn) := CASE(fn,'invalid_numeric' => 1,'invalid_voted_year' => 2,'invalid_pres' => 3,'invalid_vote_date' => 4,0);
 
EXPORT MakeFT_invalid_numeric(SALT39.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_numeric(SALT39.StrType s) := WHICH(~Scrubs_Voters.Functions.fn_numeric(s)>0);
EXPORT InValidMessageFT_invalid_numeric(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.CustomFail('Scrubs_Voters.Functions.fn_numeric'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_voted_year(SALT39.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_voted_year(SALT39.StrType s) := WHICH(~Scrubs_Voters.Functions.fn_valid_year(s)>0);
EXPORT InValidMessageFT_invalid_voted_year(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.CustomFail('Scrubs_Voters.Functions.fn_valid_year'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_pres(SALT39.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_pres(SALT39.StrType s,SALT39.StrType primary,SALT39.StrType special_1,SALT39.StrType other,SALT39.StrType special_2,SALT39.StrType general) := WHICH(~Scrubs_Voters.Functions.fn_populated_strings(s,primary,special_1,other,special_2,general)>0);
EXPORT InValidMessageFT_invalid_pres(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.CustomFail('Scrubs_Voters.Functions.fn_populated_strings'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_vote_date(SALT39.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_vote_date(SALT39.StrType s) := WHICH(~Scrubs_Voters.Functions.fn_valid_generic_date(s)>0);
EXPORT InValidMessageFT_invalid_vote_date(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.CustomFail('Scrubs_Voters.Functions.fn_valid_generic_date'),SALT39.HygieneErrors.Good);
 
EXPORT SALT39.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'vtid','voted_year','primary','special_1','other','special_2','general','pres','vote_date');
EXPORT SALT39.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'vtid','voted_year','primary','special_1','other','special_2','general','pres','vote_date');
EXPORT FieldNum(SALT39.StrType fn) := CASE(fn,'vtid' => 0,'voted_year' => 1,'primary' => 2,'special_1' => 3,'other' => 4,'special_2' => 5,'general' => 6,'pres' => 7,'vote_date' => 8,0);
EXPORT SET OF SALT39.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['CUSTOM'],['CUSTOM'],[],[],[],[],[],['CUSTOM'],['CUSTOM'],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_vtid(SALT39.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_vtid(SALT39.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_vtid(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_voted_year(SALT39.StrType s0) := MakeFT_invalid_voted_year(s0);
EXPORT InValid_voted_year(SALT39.StrType s) := InValidFT_invalid_voted_year(s);
EXPORT InValidMessage_voted_year(UNSIGNED1 wh) := InValidMessageFT_invalid_voted_year(wh);
 
EXPORT Make_primary(SALT39.StrType s0) := s0;
EXPORT InValid_primary(SALT39.StrType s) := 0;
EXPORT InValidMessage_primary(UNSIGNED1 wh) := '';
 
EXPORT Make_special_1(SALT39.StrType s0) := s0;
EXPORT InValid_special_1(SALT39.StrType s) := 0;
EXPORT InValidMessage_special_1(UNSIGNED1 wh) := '';
 
EXPORT Make_other(SALT39.StrType s0) := s0;
EXPORT InValid_other(SALT39.StrType s) := 0;
EXPORT InValidMessage_other(UNSIGNED1 wh) := '';
 
EXPORT Make_special_2(SALT39.StrType s0) := s0;
EXPORT InValid_special_2(SALT39.StrType s) := 0;
EXPORT InValidMessage_special_2(UNSIGNED1 wh) := '';
 
EXPORT Make_general(SALT39.StrType s0) := s0;
EXPORT InValid_general(SALT39.StrType s) := 0;
EXPORT InValidMessage_general(UNSIGNED1 wh) := '';
 
EXPORT Make_pres(SALT39.StrType s0) := MakeFT_invalid_pres(s0);
EXPORT InValid_pres(SALT39.StrType s,SALT39.StrType primary,SALT39.StrType special_1,SALT39.StrType other,SALT39.StrType special_2,SALT39.StrType general) := InValidFT_invalid_pres(s,primary,special_1,other,special_2,general);
EXPORT InValidMessage_pres(UNSIGNED1 wh) := InValidMessageFT_invalid_pres(wh);
 
EXPORT Make_vote_date(SALT39.StrType s0) := MakeFT_invalid_vote_date(s0);
EXPORT InValid_vote_date(SALT39.StrType s) := InValidFT_invalid_vote_date(s);
EXPORT InValidMessage_vote_date(UNSIGNED1 wh) := InValidMessageFT_invalid_vote_date(wh);
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT39,Scrubs_Voters;
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
    BOOLEAN Diff_vtid;
    BOOLEAN Diff_voted_year;
    BOOLEAN Diff_primary;
    BOOLEAN Diff_special_1;
    BOOLEAN Diff_other;
    BOOLEAN Diff_special_2;
    BOOLEAN Diff_general;
    BOOLEAN Diff_pres;
    BOOLEAN Diff_vote_date;
    UNSIGNED Num_Diffs;
    SALT39.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_vtid := le.vtid <> ri.vtid;
    SELF.Diff_voted_year := le.voted_year <> ri.voted_year;
    SELF.Diff_primary := le.primary <> ri.primary;
    SELF.Diff_special_1 := le.special_1 <> ri.special_1;
    SELF.Diff_other := le.other <> ri.other;
    SELF.Diff_special_2 := le.special_2 <> ri.special_2;
    SELF.Diff_general := le.general <> ri.general;
    SELF.Diff_pres := le.pres <> ri.pres;
    SELF.Diff_vote_date := le.vote_date <> ri.vote_date;
    SELF.Val := (SALT39.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_vtid,1,0)+ IF( SELF.Diff_voted_year,1,0)+ IF( SELF.Diff_primary,1,0)+ IF( SELF.Diff_special_1,1,0)+ IF( SELF.Diff_other,1,0)+ IF( SELF.Diff_special_2,1,0)+ IF( SELF.Diff_general,1,0)+ IF( SELF.Diff_pres,1,0)+ IF( SELF.Diff_vote_date,1,0);
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
    Count_Diff_vtid := COUNT(GROUP,%Closest%.Diff_vtid);
    Count_Diff_voted_year := COUNT(GROUP,%Closest%.Diff_voted_year);
    Count_Diff_primary := COUNT(GROUP,%Closest%.Diff_primary);
    Count_Diff_special_1 := COUNT(GROUP,%Closest%.Diff_special_1);
    Count_Diff_other := COUNT(GROUP,%Closest%.Diff_other);
    Count_Diff_special_2 := COUNT(GROUP,%Closest%.Diff_special_2);
    Count_Diff_general := COUNT(GROUP,%Closest%.Diff_general);
    Count_Diff_pres := COUNT(GROUP,%Closest%.Diff_pres);
    Count_Diff_vote_date := COUNT(GROUP,%Closest%.Diff_vote_date);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
