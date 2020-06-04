IMPORT SALT311;
EXPORT OptOut_Fields := MODULE

EXPORT NumFields := 5;

// Processing for each FieldType
EXPORT SALT311.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'Invalid_Entry_Type','Invalid_Nums','Invalid_Prof_Data','invalid_state_Act');
EXPORT FieldTypeNum(SALT311.StrType fn) := CASE(fn,'Invalid_Entry_Type' => 1,'Invalid_Nums' => 2,'Invalid_Prof_Data' => 3,'invalid_state_Act' => 4,0);

EXPORT MakeFT_Invalid_Entry_Type(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_Entry_Type(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['DELETE','OPTOUT']);
EXPORT InValidMessageFT_Invalid_Entry_Type(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('DELETE|OPTOUT'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_Invalid_Nums(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Nums(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_Invalid_Nums(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_Invalid_Prof_Data(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_Prof_Data(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['Y','N'],~(LENGTH(TRIM(s)) = 1));
EXPORT InValidMessageFT_Invalid_Prof_Data(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('Y|N'),SALT311.HygieneErrors.NotLength('1'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_invalid_state_Act(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_state_Act(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['CA','NM'],~(LENGTH(TRIM(s)) = 2));
EXPORT InValidMessageFT_invalid_state_Act(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('CA|NM'),SALT311.HygieneErrors.NotLength('2'),SALT311.HygieneErrors.Good);


EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'entry_type','lexid','prof_data','state_act','date_of_request');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'entry_type','lexid','prof_data','state_act','date_of_request');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'entry_type' => 0,'lexid' => 1,'prof_data' => 2,'state_act' => 3,'date_of_request' => 4,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['ENUM'],['ALLOW'],['ENUM','LENGTHS'],['ENUM','LENGTHS'],['ALLOW'],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);

//Individual field level validation


EXPORT Make_entry_type(SALT311.StrType s0) := MakeFT_Invalid_Entry_Type(s0);
EXPORT InValid_entry_type(SALT311.StrType s) := InValidFT_Invalid_Entry_Type(s);
EXPORT InValidMessage_entry_type(UNSIGNED1 wh) := InValidMessageFT_Invalid_Entry_Type(wh);


EXPORT Make_lexid(SALT311.StrType s0) := MakeFT_Invalid_Nums(s0);
EXPORT InValid_lexid(SALT311.StrType s) := InValidFT_Invalid_Nums(s);
EXPORT InValidMessage_lexid(UNSIGNED1 wh) := InValidMessageFT_Invalid_Nums(wh);


EXPORT Make_prof_data(SALT311.StrType s0) := MakeFT_Invalid_Prof_Data(s0);
EXPORT InValid_prof_data(SALT311.StrType s) := InValidFT_Invalid_Prof_Data(s);
EXPORT InValidMessage_prof_data(UNSIGNED1 wh) := InValidMessageFT_Invalid_Prof_Data(wh);


EXPORT Make_state_act(SALT311.StrType s0) := MakeFT_invalid_state_Act(s0);
EXPORT InValid_state_act(SALT311.StrType s) := InValidFT_invalid_state_Act(s);
EXPORT InValidMessage_state_act(UNSIGNED1 wh) := InValidMessageFT_invalid_state_Act(wh);


EXPORT Make_date_of_request(SALT311.StrType s0) := MakeFT_Invalid_Nums(s0);
EXPORT InValid_date_of_request(SALT311.StrType s) := InValidFT_Invalid_Nums(s);
EXPORT InValidMessage_date_of_request(UNSIGNED1 wh) := InValidMessageFT_Invalid_Nums(wh);

// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT311,Scrubs_Suppress;
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
    BOOLEAN Diff_entry_type;
    BOOLEAN Diff_lexid;
    BOOLEAN Diff_prof_data;
    BOOLEAN Diff_state_act;
    BOOLEAN Diff_date_of_request;
    UNSIGNED Num_Diffs;
    SALT311.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_entry_type := le.entry_type <> ri.entry_type;
    SELF.Diff_lexid := le.lexid <> ri.lexid;
    SELF.Diff_prof_data := le.prof_data <> ri.prof_data;
    SELF.Diff_state_act := le.state_act <> ri.state_act;
    SELF.Diff_date_of_request := le.date_of_request <> ri.date_of_request;
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_entry_type,1,0)+ IF( SELF.Diff_lexid,1,0)+ IF( SELF.Diff_prof_data,1,0)+ IF( SELF.Diff_state_act,1,0)+ IF( SELF.Diff_date_of_request,1,0);
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
    Count_Diff_entry_type := COUNT(GROUP,%Closest%.Diff_entry_type);
    Count_Diff_lexid := COUNT(GROUP,%Closest%.Diff_lexid);
    Count_Diff_prof_data := COUNT(GROUP,%Closest%.Diff_prof_data);
    Count_Diff_state_act := COUNT(GROUP,%Closest%.Diff_state_act);
    Count_Diff_date_of_request := COUNT(GROUP,%Closest%.Diff_date_of_request);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
