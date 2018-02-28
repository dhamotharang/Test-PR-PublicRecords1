IMPORT SALT39;
IMPORT Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT Activity_Fields := MODULE
 
EXPORT NumFields := 14;
 
// Processing for each FieldType
EXPORT SALT39.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'Invalid_Date','Invalid_Future_Date','Invalid_Num','Invalid_CapLetter','Invalid_SourceFile','Invalid_Char');
EXPORT FieldTypeNum(SALT39.StrType fn) := CASE(fn,'Invalid_Date' => 1,'Invalid_Future_Date' => 2,'Invalid_Num' => 3,'Invalid_CapLetter' => 4,'Invalid_SourceFile' => 5,'Invalid_Char' => 6,0);
 
EXPORT MakeFT_Invalid_Date(SALT39.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_Date(SALT39.StrType s) := WHICH(~Scrubs.fn_valid_date(s)>0);
EXPORT InValidMessageFT_Invalid_Date(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.CustomFail('Scrubs.fn_valid_date'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Future_Date(SALT39.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_Future_Date(SALT39.StrType s) := WHICH(~Scrubs.fn_valid_date(s,'future')>0);
EXPORT InValidMessageFT_Invalid_Future_Date(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.CustomFail('Scrubs.fn_valid_date'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Num(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789 -'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Num(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789 -'))));
EXPORT InValidMessageFT_Invalid_Num(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('0123456789 -'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_CapLetter(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ -'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_CapLetter(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ -'))));
EXPORT InValidMessageFT_Invalid_CapLetter(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ -'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_SourceFile(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ -()'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_SourceFile(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ -()'))));
EXPORT InValidMessageFT_Invalid_SourceFile(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ -()'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Char(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 -'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Char(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 -'))));
EXPORT InValidMessageFT_Invalid_Char(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 -'),SALT39.HygieneErrors.Good);
 
EXPORT SALT39.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'dt_first_reported','dt_last_reported','process_date','vendor','state_origin','source_file','case_key','court_code','court','case_number','event_date','event_type_code','event_type_description_1','event_type_description_2');
EXPORT SALT39.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'dt_first_reported','dt_last_reported','process_date','vendor','state_origin','source_file','case_key','court_code','court','case_number','event_date','event_type_code','event_type_description_1','event_type_description_2');
EXPORT FieldNum(SALT39.StrType fn) := CASE(fn,'dt_first_reported' => 0,'dt_last_reported' => 1,'process_date' => 2,'vendor' => 3,'state_origin' => 4,'source_file' => 5,'case_key' => 6,'court_code' => 7,'court' => 8,'case_number' => 9,'event_date' => 10,'event_type_code' => 11,'event_type_description_1' => 12,'event_type_description_2' => 13,0);
EXPORT SET OF SALT39.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['CUSTOM'],['CUSTOM'],['CUSTOM'],['ALLOW'],['ALLOW'],[],['ALLOW'],['ALLOW'],[],['ALLOW'],['CUSTOM'],['ALLOW'],[],[],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_dt_first_reported(SALT39.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_dt_first_reported(SALT39.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_dt_first_reported(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_dt_last_reported(SALT39.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_dt_last_reported(SALT39.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_dt_last_reported(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_process_date(SALT39.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_process_date(SALT39.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_process_date(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_vendor(SALT39.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_vendor(SALT39.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_vendor(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_state_origin(SALT39.StrType s0) := MakeFT_Invalid_CapLetter(s0);
EXPORT InValid_state_origin(SALT39.StrType s) := InValidFT_Invalid_CapLetter(s);
EXPORT InValidMessage_state_origin(UNSIGNED1 wh) := InValidMessageFT_Invalid_CapLetter(wh);
 
EXPORT Make_source_file(SALT39.StrType s0) := s0;
EXPORT InValid_source_file(SALT39.StrType s) := 0;
EXPORT InValidMessage_source_file(UNSIGNED1 wh) := '';
 
EXPORT Make_case_key(SALT39.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_case_key(SALT39.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_case_key(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);
 
EXPORT Make_court_code(SALT39.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_court_code(SALT39.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_court_code(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);
 
EXPORT Make_court(SALT39.StrType s0) := s0;
EXPORT InValid_court(SALT39.StrType s) := 0;
EXPORT InValidMessage_court(UNSIGNED1 wh) := '';
 
EXPORT Make_case_number(SALT39.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_case_number(SALT39.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_case_number(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);
 
EXPORT Make_event_date(SALT39.StrType s0) := MakeFT_Invalid_Future_Date(s0);
EXPORT InValid_event_date(SALT39.StrType s) := InValidFT_Invalid_Future_Date(s);
EXPORT InValidMessage_event_date(UNSIGNED1 wh) := InValidMessageFT_Invalid_Future_Date(wh);
 
EXPORT Make_event_type_code(SALT39.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_event_type_code(SALT39.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_event_type_code(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);
 
EXPORT Make_event_type_description_1(SALT39.StrType s0) := s0;
EXPORT InValid_event_type_description_1(SALT39.StrType s) := 0;
EXPORT InValidMessage_event_type_description_1(UNSIGNED1 wh) := '';
 
EXPORT Make_event_type_description_2(SALT39.StrType s0) := s0;
EXPORT InValid_event_type_description_2(SALT39.StrType s) := 0;
EXPORT InValidMessage_event_type_description_2(UNSIGNED1 wh) := '';
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT39,Scrubs_Civil_Court;
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
    BOOLEAN Diff_dt_first_reported;
    BOOLEAN Diff_dt_last_reported;
    BOOLEAN Diff_process_date;
    BOOLEAN Diff_vendor;
    BOOLEAN Diff_state_origin;
    BOOLEAN Diff_source_file;
    BOOLEAN Diff_case_key;
    BOOLEAN Diff_court_code;
    BOOLEAN Diff_court;
    BOOLEAN Diff_case_number;
    BOOLEAN Diff_event_date;
    BOOLEAN Diff_event_type_code;
    BOOLEAN Diff_event_type_description_1;
    BOOLEAN Diff_event_type_description_2;
    UNSIGNED Num_Diffs;
    SALT39.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_dt_first_reported := le.dt_first_reported <> ri.dt_first_reported;
    SELF.Diff_dt_last_reported := le.dt_last_reported <> ri.dt_last_reported;
    SELF.Diff_process_date := le.process_date <> ri.process_date;
    SELF.Diff_vendor := le.vendor <> ri.vendor;
    SELF.Diff_state_origin := le.state_origin <> ri.state_origin;
    SELF.Diff_source_file := le.source_file <> ri.source_file;
    SELF.Diff_case_key := le.case_key <> ri.case_key;
    SELF.Diff_court_code := le.court_code <> ri.court_code;
    SELF.Diff_court := le.court <> ri.court;
    SELF.Diff_case_number := le.case_number <> ri.case_number;
    SELF.Diff_event_date := le.event_date <> ri.event_date;
    SELF.Diff_event_type_code := le.event_type_code <> ri.event_type_code;
    SELF.Diff_event_type_description_1 := le.event_type_description_1 <> ri.event_type_description_1;
    SELF.Diff_event_type_description_2 := le.event_type_description_2 <> ri.event_type_description_2;
    SELF.Val := (SALT39.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_dt_first_reported,1,0)+ IF( SELF.Diff_dt_last_reported,1,0)+ IF( SELF.Diff_process_date,1,0)+ IF( SELF.Diff_vendor,1,0)+ IF( SELF.Diff_state_origin,1,0)+ IF( SELF.Diff_source_file,1,0)+ IF( SELF.Diff_case_key,1,0)+ IF( SELF.Diff_court_code,1,0)+ IF( SELF.Diff_court,1,0)+ IF( SELF.Diff_case_number,1,0)+ IF( SELF.Diff_event_date,1,0)+ IF( SELF.Diff_event_type_code,1,0)+ IF( SELF.Diff_event_type_description_1,1,0)+ IF( SELF.Diff_event_type_description_2,1,0);
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
    Count_Diff_dt_first_reported := COUNT(GROUP,%Closest%.Diff_dt_first_reported);
    Count_Diff_dt_last_reported := COUNT(GROUP,%Closest%.Diff_dt_last_reported);
    Count_Diff_process_date := COUNT(GROUP,%Closest%.Diff_process_date);
    Count_Diff_vendor := COUNT(GROUP,%Closest%.Diff_vendor);
    Count_Diff_state_origin := COUNT(GROUP,%Closest%.Diff_state_origin);
    Count_Diff_source_file := COUNT(GROUP,%Closest%.Diff_source_file);
    Count_Diff_case_key := COUNT(GROUP,%Closest%.Diff_case_key);
    Count_Diff_court_code := COUNT(GROUP,%Closest%.Diff_court_code);
    Count_Diff_court := COUNT(GROUP,%Closest%.Diff_court);
    Count_Diff_case_number := COUNT(GROUP,%Closest%.Diff_case_number);
    Count_Diff_event_date := COUNT(GROUP,%Closest%.Diff_event_date);
    Count_Diff_event_type_code := COUNT(GROUP,%Closest%.Diff_event_type_code);
    Count_Diff_event_type_description_1 := COUNT(GROUP,%Closest%.Diff_event_type_description_1);
    Count_Diff_event_type_description_2 := COUNT(GROUP,%Closest%.Diff_event_type_description_2);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
