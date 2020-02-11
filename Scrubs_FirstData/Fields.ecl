IMPORT SALT311;
IMPORT Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT Fields := MODULE
 
EXPORT NumFields := 11;
 
// Processing for each FieldType
EXPORT SALT311.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'Invalid_Date','Invalid_RecordType','Invalid_ActionType','Invalid_ConsID','Invalid_State','Invalid_LexID');
EXPORT FieldTypeNum(SALT311.StrType fn) := CASE(fn,'Invalid_Date' => 1,'Invalid_RecordType' => 2,'Invalid_ActionType' => 3,'Invalid_ConsID' => 4,'Invalid_State' => 5,'Invalid_LexID' => 6,0);
 
EXPORT MakeFT_Invalid_Date(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_Date(SALT311.StrType s) := WHICH(~Scrubs.fn_valid_date(s)>0);
EXPORT InValidMessageFT_Invalid_Date(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.fn_valid_date'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_RecordType(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_RecordType(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['D','T']);
EXPORT InValidMessageFT_Invalid_RecordType(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('D|T'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_ActionType(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_ActionType(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['I','0','']);
EXPORT InValidMessageFT_Invalid_ActionType(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('I|0|'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_ConsID(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_ConsID(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 9));
EXPORT InValidMessageFT_Invalid_ConsID(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789 '),SALT311.HygieneErrors.NotLength('0,9'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_State(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_State(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'))),~(LENGTH(TRIM(s)) = 2));
EXPORT InValidMessageFT_Invalid_State(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ'),SALT311.HygieneErrors.NotLength('2'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_LexID(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_LexID(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_Invalid_LexID(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789'),SALT311.HygieneErrors.Good);
 
EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'process_date','filedate','record_type','action_code','cons_id','dl_state','dl_id','first_seen_date_true','last_seen_date','dispute_status','lex_id');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'process_date','filedate','record_type','action_code','cons_id','dl_state','dl_id','first_seen_date_true','last_seen_date','dispute_status','lex_id');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'process_date' => 0,'filedate' => 1,'record_type' => 2,'action_code' => 3,'cons_id' => 4,'dl_state' => 5,'dl_id' => 6,'first_seen_date_true' => 7,'last_seen_date' => 8,'dispute_status' => 9,'lex_id' => 10,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['CUSTOM'],['CUSTOM'],['ENUM'],['ENUM'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],[],['CUSTOM'],['CUSTOM'],[],['ALLOW'],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_process_date(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_process_date(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_process_date(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_filedate(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_filedate(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_filedate(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_record_type(SALT311.StrType s0) := MakeFT_Invalid_RecordType(s0);
EXPORT InValid_record_type(SALT311.StrType s) := InValidFT_Invalid_RecordType(s);
EXPORT InValidMessage_record_type(UNSIGNED1 wh) := InValidMessageFT_Invalid_RecordType(wh);
 
EXPORT Make_action_code(SALT311.StrType s0) := MakeFT_Invalid_ActionType(s0);
EXPORT InValid_action_code(SALT311.StrType s) := InValidFT_Invalid_ActionType(s);
EXPORT InValidMessage_action_code(UNSIGNED1 wh) := InValidMessageFT_Invalid_ActionType(wh);
 
EXPORT Make_cons_id(SALT311.StrType s0) := MakeFT_Invalid_ConsID(s0);
EXPORT InValid_cons_id(SALT311.StrType s) := InValidFT_Invalid_ConsID(s);
EXPORT InValidMessage_cons_id(UNSIGNED1 wh) := InValidMessageFT_Invalid_ConsID(wh);
 
EXPORT Make_dl_state(SALT311.StrType s0) := MakeFT_Invalid_State(s0);
EXPORT InValid_dl_state(SALT311.StrType s) := InValidFT_Invalid_State(s);
EXPORT InValidMessage_dl_state(UNSIGNED1 wh) := InValidMessageFT_Invalid_State(wh);
 
EXPORT Make_dl_id(SALT311.StrType s0) := s0;
EXPORT InValid_dl_id(SALT311.StrType s) := 0;
EXPORT InValidMessage_dl_id(UNSIGNED1 wh) := '';
 
EXPORT Make_first_seen_date_true(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_first_seen_date_true(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_first_seen_date_true(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_last_seen_date(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_last_seen_date(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_last_seen_date(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_dispute_status(SALT311.StrType s0) := s0;
EXPORT InValid_dispute_status(SALT311.StrType s) := 0;
EXPORT InValidMessage_dispute_status(UNSIGNED1 wh) := '';
 
EXPORT Make_lex_id(SALT311.StrType s0) := MakeFT_Invalid_LexID(s0);
EXPORT InValid_lex_id(SALT311.StrType s) := InValidFT_Invalid_LexID(s);
EXPORT InValidMessage_lex_id(UNSIGNED1 wh) := InValidMessageFT_Invalid_LexID(wh);
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT311,Scrubs_FirstData;
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
    BOOLEAN Diff_process_date;
    BOOLEAN Diff_filedate;
    BOOLEAN Diff_record_type;
    BOOLEAN Diff_action_code;
    BOOLEAN Diff_cons_id;
    BOOLEAN Diff_dl_state;
    BOOLEAN Diff_dl_id;
    BOOLEAN Diff_first_seen_date_true;
    BOOLEAN Diff_last_seen_date;
    BOOLEAN Diff_dispute_status;
    BOOLEAN Diff_lex_id;
    UNSIGNED Num_Diffs;
    SALT311.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_process_date := le.process_date <> ri.process_date;
    SELF.Diff_filedate := le.filedate <> ri.filedate;
    SELF.Diff_record_type := le.record_type <> ri.record_type;
    SELF.Diff_action_code := le.action_code <> ri.action_code;
    SELF.Diff_cons_id := le.cons_id <> ri.cons_id;
    SELF.Diff_dl_state := le.dl_state <> ri.dl_state;
    SELF.Diff_dl_id := le.dl_id <> ri.dl_id;
    SELF.Diff_first_seen_date_true := le.first_seen_date_true <> ri.first_seen_date_true;
    SELF.Diff_last_seen_date := le.last_seen_date <> ri.last_seen_date;
    SELF.Diff_dispute_status := le.dispute_status <> ri.dispute_status;
    SELF.Diff_lex_id := le.lex_id <> ri.lex_id;
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_process_date,1,0)+ IF( SELF.Diff_filedate,1,0)+ IF( SELF.Diff_record_type,1,0)+ IF( SELF.Diff_action_code,1,0)+ IF( SELF.Diff_cons_id,1,0)+ IF( SELF.Diff_dl_state,1,0)+ IF( SELF.Diff_dl_id,1,0)+ IF( SELF.Diff_first_seen_date_true,1,0)+ IF( SELF.Diff_last_seen_date,1,0)+ IF( SELF.Diff_dispute_status,1,0)+ IF( SELF.Diff_lex_id,1,0);
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
    Count_Diff_process_date := COUNT(GROUP,%Closest%.Diff_process_date);
    Count_Diff_filedate := COUNT(GROUP,%Closest%.Diff_filedate);
    Count_Diff_record_type := COUNT(GROUP,%Closest%.Diff_record_type);
    Count_Diff_action_code := COUNT(GROUP,%Closest%.Diff_action_code);
    Count_Diff_cons_id := COUNT(GROUP,%Closest%.Diff_cons_id);
    Count_Diff_dl_state := COUNT(GROUP,%Closest%.Diff_dl_state);
    Count_Diff_dl_id := COUNT(GROUP,%Closest%.Diff_dl_id);
    Count_Diff_first_seen_date_true := COUNT(GROUP,%Closest%.Diff_first_seen_date_true);
    Count_Diff_last_seen_date := COUNT(GROUP,%Closest%.Diff_last_seen_date);
    Count_Diff_dispute_status := COUNT(GROUP,%Closest%.Diff_dispute_status);
    Count_Diff_lex_id := COUNT(GROUP,%Closest%.Diff_lex_id);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
