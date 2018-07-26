IMPORT SALT39;
IMPORT Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT Matter_Fields := MODULE
 
EXPORT NumFields := 34;
 
// Processing for each FieldType
EXPORT SALT39.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'Invalid_Date','Invalid_Num','Invalid_CapLetter','Invalid_Char');
EXPORT FieldTypeNum(SALT39.StrType fn) := CASE(fn,'Invalid_Date' => 1,'Invalid_Num' => 2,'Invalid_CapLetter' => 3,'Invalid_Char' => 4,0);
 
EXPORT MakeFT_Invalid_Date(SALT39.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_Date(SALT39.StrType s) := WHICH(~Scrubs.fn_valid_date(s)>0);
EXPORT InValidMessageFT_Invalid_Date(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.CustomFail('Scrubs.fn_valid_date'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Num(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789 -'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Num(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789 -'))));
EXPORT InValidMessageFT_Invalid_Num(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('0123456789 -'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_CapLetter(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ -*:&,\'.'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_CapLetter(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ -*:&,\'.'))));
EXPORT InValidMessageFT_Invalid_CapLetter(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ -*:&,\'.'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Char(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 -*:&,\'.'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Char(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 -*:&,\'.'))));
EXPORT InValidMessageFT_Invalid_Char(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 -*:&,\'.'),SALT39.HygieneErrors.Good);
 
EXPORT SALT39.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'dt_first_reported','dt_last_reported','process_date','vendor','state_origin','source_file','case_key','parent_case_key','court_code','court','case_number','case_type_code','case_type','case_title','case_cause_code','case_cause','manner_of_filing_code','manner_of_filing','filing_date','manner_of_judgmt_code','manner_of_judgmt','judgmt_date','ruled_for_against_code','ruled_for_against','judgmt_type_code','judgmt_type','judgmt_disposition_date','judgmt_disposition_code','judgmt_disposition','disposition_code','disposition_description','disposition_date','suit_amount','award_amount');
EXPORT SALT39.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'dt_first_reported','dt_last_reported','process_date','vendor','state_origin','source_file','case_key','parent_case_key','court_code','court','case_number','case_type_code','case_type','case_title','case_cause_code','case_cause','manner_of_filing_code','manner_of_filing','filing_date','manner_of_judgmt_code','manner_of_judgmt','judgmt_date','ruled_for_against_code','ruled_for_against','judgmt_type_code','judgmt_type','judgmt_disposition_date','judgmt_disposition_code','judgmt_disposition','disposition_code','disposition_description','disposition_date','suit_amount','award_amount');
EXPORT FieldNum(SALT39.StrType fn) := CASE(fn,'dt_first_reported' => 0,'dt_last_reported' => 1,'process_date' => 2,'vendor' => 3,'state_origin' => 4,'source_file' => 5,'case_key' => 6,'parent_case_key' => 7,'court_code' => 8,'court' => 9,'case_number' => 10,'case_type_code' => 11,'case_type' => 12,'case_title' => 13,'case_cause_code' => 14,'case_cause' => 15,'manner_of_filing_code' => 16,'manner_of_filing' => 17,'filing_date' => 18,'manner_of_judgmt_code' => 19,'manner_of_judgmt' => 20,'judgmt_date' => 21,'ruled_for_against_code' => 22,'ruled_for_against' => 23,'judgmt_type_code' => 24,'judgmt_type' => 25,'judgmt_disposition_date' => 26,'judgmt_disposition_code' => 27,'judgmt_disposition' => 28,'disposition_code' => 29,'disposition_description' => 30,'disposition_date' => 31,'suit_amount' => 32,'award_amount' => 33,0);
EXPORT SET OF SALT39.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['CUSTOM'],['CUSTOM'],['CUSTOM'],['ALLOW'],['ALLOW'],[],['ALLOW'],['ALLOW'],['ALLOW'],[],['ALLOW'],['ALLOW'],[],[],['ALLOW'],[],['ALLOW'],[],['CUSTOM'],['ALLOW'],[],['CUSTOM'],['ALLOW'],[],['ALLOW'],[],['CUSTOM'],['ALLOW'],[],['ALLOW'],[],['CUSTOM'],['ALLOW'],['ALLOW'],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
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
 
EXPORT Make_parent_case_key(SALT39.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_parent_case_key(SALT39.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_parent_case_key(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);
 
EXPORT Make_court_code(SALT39.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_court_code(SALT39.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_court_code(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);
 
EXPORT Make_court(SALT39.StrType s0) := s0;
EXPORT InValid_court(SALT39.StrType s) := 0;
EXPORT InValidMessage_court(UNSIGNED1 wh) := '';
 
EXPORT Make_case_number(SALT39.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_case_number(SALT39.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_case_number(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);
 
EXPORT Make_case_type_code(SALT39.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_case_type_code(SALT39.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_case_type_code(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);
 
EXPORT Make_case_type(SALT39.StrType s0) := s0;
EXPORT InValid_case_type(SALT39.StrType s) := 0;
EXPORT InValidMessage_case_type(UNSIGNED1 wh) := '';
 
EXPORT Make_case_title(SALT39.StrType s0) := s0;
EXPORT InValid_case_title(SALT39.StrType s) := 0;
EXPORT InValidMessage_case_title(UNSIGNED1 wh) := '';
 
EXPORT Make_case_cause_code(SALT39.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_case_cause_code(SALT39.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_case_cause_code(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);
 
EXPORT Make_case_cause(SALT39.StrType s0) := s0;
EXPORT InValid_case_cause(SALT39.StrType s) := 0;
EXPORT InValidMessage_case_cause(UNSIGNED1 wh) := '';
 
EXPORT Make_manner_of_filing_code(SALT39.StrType s0) := MakeFT_Invalid_CapLetter(s0);
EXPORT InValid_manner_of_filing_code(SALT39.StrType s) := InValidFT_Invalid_CapLetter(s);
EXPORT InValidMessage_manner_of_filing_code(UNSIGNED1 wh) := InValidMessageFT_Invalid_CapLetter(wh);
 
EXPORT Make_manner_of_filing(SALT39.StrType s0) := s0;
EXPORT InValid_manner_of_filing(SALT39.StrType s) := 0;
EXPORT InValidMessage_manner_of_filing(UNSIGNED1 wh) := '';
 
EXPORT Make_filing_date(SALT39.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_filing_date(SALT39.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_filing_date(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_manner_of_judgmt_code(SALT39.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_manner_of_judgmt_code(SALT39.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_manner_of_judgmt_code(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);
 
EXPORT Make_manner_of_judgmt(SALT39.StrType s0) := s0;
EXPORT InValid_manner_of_judgmt(SALT39.StrType s) := 0;
EXPORT InValidMessage_manner_of_judgmt(UNSIGNED1 wh) := '';
 
EXPORT Make_judgmt_date(SALT39.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_judgmt_date(SALT39.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_judgmt_date(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_ruled_for_against_code(SALT39.StrType s0) := MakeFT_Invalid_CapLetter(s0);
EXPORT InValid_ruled_for_against_code(SALT39.StrType s) := InValidFT_Invalid_CapLetter(s);
EXPORT InValidMessage_ruled_for_against_code(UNSIGNED1 wh) := InValidMessageFT_Invalid_CapLetter(wh);
 
EXPORT Make_ruled_for_against(SALT39.StrType s0) := s0;
EXPORT InValid_ruled_for_against(SALT39.StrType s) := 0;
EXPORT InValidMessage_ruled_for_against(UNSIGNED1 wh) := '';
 
EXPORT Make_judgmt_type_code(SALT39.StrType s0) := MakeFT_Invalid_CapLetter(s0);
EXPORT InValid_judgmt_type_code(SALT39.StrType s) := InValidFT_Invalid_CapLetter(s);
EXPORT InValidMessage_judgmt_type_code(UNSIGNED1 wh) := InValidMessageFT_Invalid_CapLetter(wh);
 
EXPORT Make_judgmt_type(SALT39.StrType s0) := s0;
EXPORT InValid_judgmt_type(SALT39.StrType s) := 0;
EXPORT InValidMessage_judgmt_type(UNSIGNED1 wh) := '';
 
EXPORT Make_judgmt_disposition_date(SALT39.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_judgmt_disposition_date(SALT39.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_judgmt_disposition_date(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_judgmt_disposition_code(SALT39.StrType s0) := MakeFT_Invalid_CapLetter(s0);
EXPORT InValid_judgmt_disposition_code(SALT39.StrType s) := InValidFT_Invalid_CapLetter(s);
EXPORT InValidMessage_judgmt_disposition_code(UNSIGNED1 wh) := InValidMessageFT_Invalid_CapLetter(wh);
 
EXPORT Make_judgmt_disposition(SALT39.StrType s0) := s0;
EXPORT InValid_judgmt_disposition(SALT39.StrType s) := 0;
EXPORT InValidMessage_judgmt_disposition(UNSIGNED1 wh) := '';
 
EXPORT Make_disposition_code(SALT39.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_disposition_code(SALT39.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_disposition_code(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);
 
EXPORT Make_disposition_description(SALT39.StrType s0) := s0;
EXPORT InValid_disposition_description(SALT39.StrType s) := 0;
EXPORT InValidMessage_disposition_description(UNSIGNED1 wh) := '';
 
EXPORT Make_disposition_date(SALT39.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_disposition_date(SALT39.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_disposition_date(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_suit_amount(SALT39.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_suit_amount(SALT39.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_suit_amount(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_award_amount(SALT39.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_award_amount(SALT39.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_award_amount(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
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
    BOOLEAN Diff_parent_case_key;
    BOOLEAN Diff_court_code;
    BOOLEAN Diff_court;
    BOOLEAN Diff_case_number;
    BOOLEAN Diff_case_type_code;
    BOOLEAN Diff_case_type;
    BOOLEAN Diff_case_title;
    BOOLEAN Diff_case_cause_code;
    BOOLEAN Diff_case_cause;
    BOOLEAN Diff_manner_of_filing_code;
    BOOLEAN Diff_manner_of_filing;
    BOOLEAN Diff_filing_date;
    BOOLEAN Diff_manner_of_judgmt_code;
    BOOLEAN Diff_manner_of_judgmt;
    BOOLEAN Diff_judgmt_date;
    BOOLEAN Diff_ruled_for_against_code;
    BOOLEAN Diff_ruled_for_against;
    BOOLEAN Diff_judgmt_type_code;
    BOOLEAN Diff_judgmt_type;
    BOOLEAN Diff_judgmt_disposition_date;
    BOOLEAN Diff_judgmt_disposition_code;
    BOOLEAN Diff_judgmt_disposition;
    BOOLEAN Diff_disposition_code;
    BOOLEAN Diff_disposition_description;
    BOOLEAN Diff_disposition_date;
    BOOLEAN Diff_suit_amount;
    BOOLEAN Diff_award_amount;
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
    SELF.Diff_parent_case_key := le.parent_case_key <> ri.parent_case_key;
    SELF.Diff_court_code := le.court_code <> ri.court_code;
    SELF.Diff_court := le.court <> ri.court;
    SELF.Diff_case_number := le.case_number <> ri.case_number;
    SELF.Diff_case_type_code := le.case_type_code <> ri.case_type_code;
    SELF.Diff_case_type := le.case_type <> ri.case_type;
    SELF.Diff_case_title := le.case_title <> ri.case_title;
    SELF.Diff_case_cause_code := le.case_cause_code <> ri.case_cause_code;
    SELF.Diff_case_cause := le.case_cause <> ri.case_cause;
    SELF.Diff_manner_of_filing_code := le.manner_of_filing_code <> ri.manner_of_filing_code;
    SELF.Diff_manner_of_filing := le.manner_of_filing <> ri.manner_of_filing;
    SELF.Diff_filing_date := le.filing_date <> ri.filing_date;
    SELF.Diff_manner_of_judgmt_code := le.manner_of_judgmt_code <> ri.manner_of_judgmt_code;
    SELF.Diff_manner_of_judgmt := le.manner_of_judgmt <> ri.manner_of_judgmt;
    SELF.Diff_judgmt_date := le.judgmt_date <> ri.judgmt_date;
    SELF.Diff_ruled_for_against_code := le.ruled_for_against_code <> ri.ruled_for_against_code;
    SELF.Diff_ruled_for_against := le.ruled_for_against <> ri.ruled_for_against;
    SELF.Diff_judgmt_type_code := le.judgmt_type_code <> ri.judgmt_type_code;
    SELF.Diff_judgmt_type := le.judgmt_type <> ri.judgmt_type;
    SELF.Diff_judgmt_disposition_date := le.judgmt_disposition_date <> ri.judgmt_disposition_date;
    SELF.Diff_judgmt_disposition_code := le.judgmt_disposition_code <> ri.judgmt_disposition_code;
    SELF.Diff_judgmt_disposition := le.judgmt_disposition <> ri.judgmt_disposition;
    SELF.Diff_disposition_code := le.disposition_code <> ri.disposition_code;
    SELF.Diff_disposition_description := le.disposition_description <> ri.disposition_description;
    SELF.Diff_disposition_date := le.disposition_date <> ri.disposition_date;
    SELF.Diff_suit_amount := le.suit_amount <> ri.suit_amount;
    SELF.Diff_award_amount := le.award_amount <> ri.award_amount;
    SELF.Val := (SALT39.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_dt_first_reported,1,0)+ IF( SELF.Diff_dt_last_reported,1,0)+ IF( SELF.Diff_process_date,1,0)+ IF( SELF.Diff_vendor,1,0)+ IF( SELF.Diff_state_origin,1,0)+ IF( SELF.Diff_source_file,1,0)+ IF( SELF.Diff_case_key,1,0)+ IF( SELF.Diff_parent_case_key,1,0)+ IF( SELF.Diff_court_code,1,0)+ IF( SELF.Diff_court,1,0)+ IF( SELF.Diff_case_number,1,0)+ IF( SELF.Diff_case_type_code,1,0)+ IF( SELF.Diff_case_type,1,0)+ IF( SELF.Diff_case_title,1,0)+ IF( SELF.Diff_case_cause_code,1,0)+ IF( SELF.Diff_case_cause,1,0)+ IF( SELF.Diff_manner_of_filing_code,1,0)+ IF( SELF.Diff_manner_of_filing,1,0)+ IF( SELF.Diff_filing_date,1,0)+ IF( SELF.Diff_manner_of_judgmt_code,1,0)+ IF( SELF.Diff_manner_of_judgmt,1,0)+ IF( SELF.Diff_judgmt_date,1,0)+ IF( SELF.Diff_ruled_for_against_code,1,0)+ IF( SELF.Diff_ruled_for_against,1,0)+ IF( SELF.Diff_judgmt_type_code,1,0)+ IF( SELF.Diff_judgmt_type,1,0)+ IF( SELF.Diff_judgmt_disposition_date,1,0)+ IF( SELF.Diff_judgmt_disposition_code,1,0)+ IF( SELF.Diff_judgmt_disposition,1,0)+ IF( SELF.Diff_disposition_code,1,0)+ IF( SELF.Diff_disposition_description,1,0)+ IF( SELF.Diff_disposition_date,1,0)+ IF( SELF.Diff_suit_amount,1,0)+ IF( SELF.Diff_award_amount,1,0);
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
    Count_Diff_parent_case_key := COUNT(GROUP,%Closest%.Diff_parent_case_key);
    Count_Diff_court_code := COUNT(GROUP,%Closest%.Diff_court_code);
    Count_Diff_court := COUNT(GROUP,%Closest%.Diff_court);
    Count_Diff_case_number := COUNT(GROUP,%Closest%.Diff_case_number);
    Count_Diff_case_type_code := COUNT(GROUP,%Closest%.Diff_case_type_code);
    Count_Diff_case_type := COUNT(GROUP,%Closest%.Diff_case_type);
    Count_Diff_case_title := COUNT(GROUP,%Closest%.Diff_case_title);
    Count_Diff_case_cause_code := COUNT(GROUP,%Closest%.Diff_case_cause_code);
    Count_Diff_case_cause := COUNT(GROUP,%Closest%.Diff_case_cause);
    Count_Diff_manner_of_filing_code := COUNT(GROUP,%Closest%.Diff_manner_of_filing_code);
    Count_Diff_manner_of_filing := COUNT(GROUP,%Closest%.Diff_manner_of_filing);
    Count_Diff_filing_date := COUNT(GROUP,%Closest%.Diff_filing_date);
    Count_Diff_manner_of_judgmt_code := COUNT(GROUP,%Closest%.Diff_manner_of_judgmt_code);
    Count_Diff_manner_of_judgmt := COUNT(GROUP,%Closest%.Diff_manner_of_judgmt);
    Count_Diff_judgmt_date := COUNT(GROUP,%Closest%.Diff_judgmt_date);
    Count_Diff_ruled_for_against_code := COUNT(GROUP,%Closest%.Diff_ruled_for_against_code);
    Count_Diff_ruled_for_against := COUNT(GROUP,%Closest%.Diff_ruled_for_against);
    Count_Diff_judgmt_type_code := COUNT(GROUP,%Closest%.Diff_judgmt_type_code);
    Count_Diff_judgmt_type := COUNT(GROUP,%Closest%.Diff_judgmt_type);
    Count_Diff_judgmt_disposition_date := COUNT(GROUP,%Closest%.Diff_judgmt_disposition_date);
    Count_Diff_judgmt_disposition_code := COUNT(GROUP,%Closest%.Diff_judgmt_disposition_code);
    Count_Diff_judgmt_disposition := COUNT(GROUP,%Closest%.Diff_judgmt_disposition);
    Count_Diff_disposition_code := COUNT(GROUP,%Closest%.Diff_disposition_code);
    Count_Diff_disposition_description := COUNT(GROUP,%Closest%.Diff_disposition_description);
    Count_Diff_disposition_date := COUNT(GROUP,%Closest%.Diff_disposition_date);
    Count_Diff_suit_amount := COUNT(GROUP,%Closest%.Diff_suit_amount);
    Count_Diff_award_amount := COUNT(GROUP,%Closest%.Diff_award_amount);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
