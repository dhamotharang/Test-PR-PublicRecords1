IMPORT SALT311;
IMPORT Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT Flag_Fields := MODULE
 
EXPORT NumFields := 20;
 
// Processing for each FieldType
EXPORT SALT311.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'Invalid_FlagID','Invalid_Num','Invalid_Letters','Invalid_OverrideFlag','Invalid_Char','Invalid_SSN','Invalid_DOB','Invalid_Date');
EXPORT FieldTypeNum(SALT311.StrType fn) := CASE(fn,'Invalid_FlagID' => 1,'Invalid_Num' => 2,'Invalid_Letters' => 3,'Invalid_OverrideFlag' => 4,'Invalid_Char' => 5,'Invalid_SSN' => 6,'Invalid_DOB' => 7,'Invalid_Date' => 8,0);
 
EXPORT MakeFT_Invalid_FlagID(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_FlagID(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) >= 6));
EXPORT InValidMessageFT_Invalid_FlagID(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789'),SALT311.HygieneErrors.NotLength('6..'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Num(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Num(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789 '))));
EXPORT InValidMessageFT_Invalid_Num(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789 '),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Letters(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'abcdefghijklmnopqrstuvwxyz_'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Letters(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'abcdefghijklmnopqrstuvwxyz_'))),~(LENGTH(TRIM(s)) >= 1));
EXPORT InValidMessageFT_Invalid_Letters(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('abcdefghijklmnopqrstuvwxyz_'),SALT311.HygieneErrors.NotLength('1..'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_OverrideFlag(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_OverrideFlag(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['1','2','']);
EXPORT InValidMessageFT_Invalid_OverrideFlag(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('1|2|'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Char(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz \'.-'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Char(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz \'.-'))));
EXPORT InValidMessageFT_Invalid_Char(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz \'.-'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_SSN(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_SSN(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 9));
EXPORT InValidMessageFT_Invalid_SSN(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789'),SALT311.HygieneErrors.NotLength('0,9'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_DOB(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_DOB(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 8));
EXPORT InValidMessageFT_Invalid_DOB(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789'),SALT311.HygieneErrors.NotLength('0,8'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Date(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_Date(SALT311.StrType s) := WHICH(~Scrubs.fn_valid_date(s)>0);
EXPORT InValidMessageFT_Invalid_Date(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.fn_valid_date'),SALT311.HygieneErrors.Good);
 
EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'flag_file_id','did','file_id','record_id','override_flag','in_dispute_flag','consumer_statement_flag','fname','mname','lname','name_suffix','ssn','dob','riskwise_uid','user_added','date_added','known_missing','user_changed','date_changed','lf');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'flag_file_id','did','file_id','record_id','override_flag','in_dispute_flag','consumer_statement_flag','fname','mname','lname','name_suffix','ssn','dob','riskwise_uid','user_added','date_added','known_missing','user_changed','date_changed','lf');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'flag_file_id' => 0,'did' => 1,'file_id' => 2,'record_id' => 3,'override_flag' => 4,'in_dispute_flag' => 5,'consumer_statement_flag' => 6,'fname' => 7,'mname' => 8,'lname' => 9,'name_suffix' => 10,'ssn' => 11,'dob' => 12,'riskwise_uid' => 13,'user_added' => 14,'date_added' => 15,'known_missing' => 16,'user_changed' => 17,'date_changed' => 18,'lf' => 19,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['ALLOW','LENGTHS'],['ALLOW'],['ALLOW','LENGTHS'],[],['ENUM'],[],[],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW'],[],['CUSTOM'],[],[],[],[],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_flag_file_id(SALT311.StrType s0) := MakeFT_Invalid_FlagID(s0);
EXPORT InValid_flag_file_id(SALT311.StrType s) := InValidFT_Invalid_FlagID(s);
EXPORT InValidMessage_flag_file_id(UNSIGNED1 wh) := InValidMessageFT_Invalid_FlagID(wh);
 
EXPORT Make_did(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_did(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_did(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_file_id(SALT311.StrType s0) := MakeFT_Invalid_Letters(s0);
EXPORT InValid_file_id(SALT311.StrType s) := InValidFT_Invalid_Letters(s);
EXPORT InValidMessage_file_id(UNSIGNED1 wh) := InValidMessageFT_Invalid_Letters(wh);
 
EXPORT Make_record_id(SALT311.StrType s0) := s0;
EXPORT InValid_record_id(SALT311.StrType s) := 0;
EXPORT InValidMessage_record_id(UNSIGNED1 wh) := '';
 
EXPORT Make_override_flag(SALT311.StrType s0) := MakeFT_Invalid_OverrideFlag(s0);
EXPORT InValid_override_flag(SALT311.StrType s) := InValidFT_Invalid_OverrideFlag(s);
EXPORT InValidMessage_override_flag(UNSIGNED1 wh) := InValidMessageFT_Invalid_OverrideFlag(wh);
 
EXPORT Make_in_dispute_flag(SALT311.StrType s0) := s0;
EXPORT InValid_in_dispute_flag(SALT311.StrType s) := 0;
EXPORT InValidMessage_in_dispute_flag(UNSIGNED1 wh) := '';
 
EXPORT Make_consumer_statement_flag(SALT311.StrType s0) := s0;
EXPORT InValid_consumer_statement_flag(SALT311.StrType s) := 0;
EXPORT InValidMessage_consumer_statement_flag(UNSIGNED1 wh) := '';
 
EXPORT Make_fname(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_fname(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_fname(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);
 
EXPORT Make_mname(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_mname(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_mname(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);
 
EXPORT Make_lname(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_lname(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_lname(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);
 
EXPORT Make_name_suffix(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_name_suffix(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_name_suffix(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);
 
EXPORT Make_ssn(SALT311.StrType s0) := MakeFT_Invalid_SSN(s0);
EXPORT InValid_ssn(SALT311.StrType s) := InValidFT_Invalid_SSN(s);
EXPORT InValidMessage_ssn(UNSIGNED1 wh) := InValidMessageFT_Invalid_SSN(wh);
 
EXPORT Make_dob(SALT311.StrType s0) := MakeFT_Invalid_DOB(s0);
EXPORT InValid_dob(SALT311.StrType s) := InValidFT_Invalid_DOB(s);
EXPORT InValidMessage_dob(UNSIGNED1 wh) := InValidMessageFT_Invalid_DOB(wh);
 
EXPORT Make_riskwise_uid(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_riskwise_uid(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_riskwise_uid(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_user_added(SALT311.StrType s0) := s0;
EXPORT InValid_user_added(SALT311.StrType s) := 0;
EXPORT InValidMessage_user_added(UNSIGNED1 wh) := '';
 
EXPORT Make_date_added(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_date_added(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_date_added(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_known_missing(SALT311.StrType s0) := s0;
EXPORT InValid_known_missing(SALT311.StrType s) := 0;
EXPORT InValidMessage_known_missing(UNSIGNED1 wh) := '';
 
EXPORT Make_user_changed(SALT311.StrType s0) := s0;
EXPORT InValid_user_changed(SALT311.StrType s) := 0;
EXPORT InValidMessage_user_changed(UNSIGNED1 wh) := '';
 
EXPORT Make_date_changed(SALT311.StrType s0) := s0;
EXPORT InValid_date_changed(SALT311.StrType s) := 0;
EXPORT InValidMessage_date_changed(UNSIGNED1 wh) := '';
 
EXPORT Make_lf(SALT311.StrType s0) := s0;
EXPORT InValid_lf(SALT311.StrType s) := 0;
EXPORT InValidMessage_lf(UNSIGNED1 wh) := '';
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT311,Scrubs_Overrides;
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
    BOOLEAN Diff_flag_file_id;
    BOOLEAN Diff_did;
    BOOLEAN Diff_file_id;
    BOOLEAN Diff_record_id;
    BOOLEAN Diff_override_flag;
    BOOLEAN Diff_in_dispute_flag;
    BOOLEAN Diff_consumer_statement_flag;
    BOOLEAN Diff_fname;
    BOOLEAN Diff_mname;
    BOOLEAN Diff_lname;
    BOOLEAN Diff_name_suffix;
    BOOLEAN Diff_ssn;
    BOOLEAN Diff_dob;
    BOOLEAN Diff_riskwise_uid;
    BOOLEAN Diff_user_added;
    BOOLEAN Diff_date_added;
    BOOLEAN Diff_known_missing;
    BOOLEAN Diff_user_changed;
    BOOLEAN Diff_date_changed;
    BOOLEAN Diff_lf;
    UNSIGNED Num_Diffs;
    SALT311.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_flag_file_id := le.flag_file_id <> ri.flag_file_id;
    SELF.Diff_did := le.did <> ri.did;
    SELF.Diff_file_id := le.file_id <> ri.file_id;
    SELF.Diff_record_id := le.record_id <> ri.record_id;
    SELF.Diff_override_flag := le.override_flag <> ri.override_flag;
    SELF.Diff_in_dispute_flag := le.in_dispute_flag <> ri.in_dispute_flag;
    SELF.Diff_consumer_statement_flag := le.consumer_statement_flag <> ri.consumer_statement_flag;
    SELF.Diff_fname := le.fname <> ri.fname;
    SELF.Diff_mname := le.mname <> ri.mname;
    SELF.Diff_lname := le.lname <> ri.lname;
    SELF.Diff_name_suffix := le.name_suffix <> ri.name_suffix;
    SELF.Diff_ssn := le.ssn <> ri.ssn;
    SELF.Diff_dob := le.dob <> ri.dob;
    SELF.Diff_riskwise_uid := le.riskwise_uid <> ri.riskwise_uid;
    SELF.Diff_user_added := le.user_added <> ri.user_added;
    SELF.Diff_date_added := le.date_added <> ri.date_added;
    SELF.Diff_known_missing := le.known_missing <> ri.known_missing;
    SELF.Diff_user_changed := le.user_changed <> ri.user_changed;
    SELF.Diff_date_changed := le.date_changed <> ri.date_changed;
    SELF.Diff_lf := le.lf <> ri.lf;
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_flag_file_id,1,0)+ IF( SELF.Diff_did,1,0)+ IF( SELF.Diff_file_id,1,0)+ IF( SELF.Diff_record_id,1,0)+ IF( SELF.Diff_override_flag,1,0)+ IF( SELF.Diff_in_dispute_flag,1,0)+ IF( SELF.Diff_consumer_statement_flag,1,0)+ IF( SELF.Diff_fname,1,0)+ IF( SELF.Diff_mname,1,0)+ IF( SELF.Diff_lname,1,0)+ IF( SELF.Diff_name_suffix,1,0)+ IF( SELF.Diff_ssn,1,0)+ IF( SELF.Diff_dob,1,0)+ IF( SELF.Diff_riskwise_uid,1,0)+ IF( SELF.Diff_user_added,1,0)+ IF( SELF.Diff_date_added,1,0)+ IF( SELF.Diff_known_missing,1,0)+ IF( SELF.Diff_user_changed,1,0)+ IF( SELF.Diff_date_changed,1,0)+ IF( SELF.Diff_lf,1,0);
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
    Count_Diff_flag_file_id := COUNT(GROUP,%Closest%.Diff_flag_file_id);
    Count_Diff_did := COUNT(GROUP,%Closest%.Diff_did);
    Count_Diff_file_id := COUNT(GROUP,%Closest%.Diff_file_id);
    Count_Diff_record_id := COUNT(GROUP,%Closest%.Diff_record_id);
    Count_Diff_override_flag := COUNT(GROUP,%Closest%.Diff_override_flag);
    Count_Diff_in_dispute_flag := COUNT(GROUP,%Closest%.Diff_in_dispute_flag);
    Count_Diff_consumer_statement_flag := COUNT(GROUP,%Closest%.Diff_consumer_statement_flag);
    Count_Diff_fname := COUNT(GROUP,%Closest%.Diff_fname);
    Count_Diff_mname := COUNT(GROUP,%Closest%.Diff_mname);
    Count_Diff_lname := COUNT(GROUP,%Closest%.Diff_lname);
    Count_Diff_name_suffix := COUNT(GROUP,%Closest%.Diff_name_suffix);
    Count_Diff_ssn := COUNT(GROUP,%Closest%.Diff_ssn);
    Count_Diff_dob := COUNT(GROUP,%Closest%.Diff_dob);
    Count_Diff_riskwise_uid := COUNT(GROUP,%Closest%.Diff_riskwise_uid);
    Count_Diff_user_added := COUNT(GROUP,%Closest%.Diff_user_added);
    Count_Diff_date_added := COUNT(GROUP,%Closest%.Diff_date_added);
    Count_Diff_known_missing := COUNT(GROUP,%Closest%.Diff_known_missing);
    Count_Diff_user_changed := COUNT(GROUP,%Closest%.Diff_user_changed);
    Count_Diff_date_changed := COUNT(GROUP,%Closest%.Diff_date_changed);
    Count_Diff_lf := COUNT(GROUP,%Closest%.Diff_lf);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
