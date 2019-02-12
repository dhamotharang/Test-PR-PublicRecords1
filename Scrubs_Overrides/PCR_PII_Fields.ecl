IMPORT SALT311;
IMPORT Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT PCR_PII_Fields := MODULE
 
EXPORT NumFields := 34;
 
// Processing for each FieldType
EXPORT SALT311.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'Invalid_Num','Invalid_Date','Invalid_Char','Invalid_SSN','Invalid_DOB','Invalid_DLNum','Invalid_State');
EXPORT FieldTypeNum(SALT311.StrType fn) := CASE(fn,'Invalid_Num' => 1,'Invalid_Date' => 2,'Invalid_Char' => 3,'Invalid_SSN' => 4,'Invalid_DOB' => 5,'Invalid_DLNum' => 6,'Invalid_State' => 7,0);
 
EXPORT MakeFT_Invalid_Num(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Num(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_Invalid_Num(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Date(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_Date(SALT311.StrType s) := WHICH(~Scrubs.fn_valid_date(s)>0);
EXPORT InValidMessageFT_Invalid_Date(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.fn_valid_date'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Char(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz \'.-,#'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Char(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz \'.-,#'))));
EXPORT InValidMessageFT_Invalid_Char(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz \'.-,#'),SALT311.HygieneErrors.Good);
 
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
 
EXPORT MakeFT_Invalid_DLNum(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ-0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_DLNum(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ-0123456789'))));
EXPORT InValidMessageFT_Invalid_DLNum(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ-0123456789'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_State(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_State(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 2));
EXPORT InValidMessageFT_Invalid_State(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ'),SALT311.HygieneErrors.NotLength('0,2'),SALT311.HygieneErrors.Good);
 
EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'uid','date_created','dt_first_seen','dt_last_seen','did','fname','mname','lname','name_suffix','ssn','dob','predir','prim_name','prim_range','suffix','postdir','unit_desig','sec_range','zip4','address','city_name','st','zip','phone','dl_number','dl_state','dispute_flag','security_freeze','security_freeze_pin','security_alert','negative_alert','id_theft_flag','insuff_inqry_data','consumer_statement_flag');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'uid','date_created','dt_first_seen','dt_last_seen','did','fname','mname','lname','name_suffix','ssn','dob','predir','prim_name','prim_range','suffix','postdir','unit_desig','sec_range','zip4','address','city_name','st','zip','phone','dl_number','dl_state','dispute_flag','security_freeze','security_freeze_pin','security_alert','negative_alert','id_theft_flag','insuff_inqry_data','consumer_statement_flag');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'uid' => 0,'date_created' => 1,'dt_first_seen' => 2,'dt_last_seen' => 3,'did' => 4,'fname' => 5,'mname' => 6,'lname' => 7,'name_suffix' => 8,'ssn' => 9,'dob' => 10,'predir' => 11,'prim_name' => 12,'prim_range' => 13,'suffix' => 14,'postdir' => 15,'unit_desig' => 16,'sec_range' => 17,'zip4' => 18,'address' => 19,'city_name' => 20,'st' => 21,'zip' => 22,'phone' => 23,'dl_number' => 24,'dl_state' => 25,'dispute_flag' => 26,'security_freeze' => 27,'security_freeze_pin' => 28,'security_alert' => 29,'negative_alert' => 30,'id_theft_flag' => 31,'insuff_inqry_data' => 32,'consumer_statement_flag' => 33,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['ALLOW'],['CUSTOM'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],[],[],['ALLOW','LENGTHS'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW','LENGTHS'],[],[],[],[],[],[],[],[],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_uid(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_uid(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_uid(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);
 
EXPORT Make_date_created(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_date_created(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_date_created(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_dt_first_seen(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_dt_first_seen(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_dt_first_seen(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_dt_last_seen(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_dt_last_seen(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_dt_last_seen(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_did(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_did(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_did(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
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
 
EXPORT Make_predir(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_predir(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_predir(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);
 
EXPORT Make_prim_name(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_prim_name(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_prim_name(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);
 
EXPORT Make_prim_range(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_prim_range(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_prim_range(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);
 
EXPORT Make_suffix(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_suffix(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_suffix(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);
 
EXPORT Make_postdir(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_postdir(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_postdir(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);
 
EXPORT Make_unit_desig(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_unit_desig(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_unit_desig(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);
 
EXPORT Make_sec_range(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_sec_range(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_sec_range(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);
 
EXPORT Make_zip4(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_zip4(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_zip4(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_address(SALT311.StrType s0) := s0;
EXPORT InValid_address(SALT311.StrType s) := 0;
EXPORT InValidMessage_address(UNSIGNED1 wh) := '';
 
EXPORT Make_city_name(SALT311.StrType s0) := s0;
EXPORT InValid_city_name(SALT311.StrType s) := 0;
EXPORT InValidMessage_city_name(UNSIGNED1 wh) := '';
 
EXPORT Make_st(SALT311.StrType s0) := MakeFT_Invalid_State(s0);
EXPORT InValid_st(SALT311.StrType s) := InValidFT_Invalid_State(s);
EXPORT InValidMessage_st(UNSIGNED1 wh) := InValidMessageFT_Invalid_State(wh);
 
EXPORT Make_zip(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_zip(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_zip(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_phone(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_phone(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_phone(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_dl_number(SALT311.StrType s0) := MakeFT_Invalid_DLNum(s0);
EXPORT InValid_dl_number(SALT311.StrType s) := InValidFT_Invalid_DLNum(s);
EXPORT InValidMessage_dl_number(UNSIGNED1 wh) := InValidMessageFT_Invalid_DLNum(wh);
 
EXPORT Make_dl_state(SALT311.StrType s0) := MakeFT_Invalid_State(s0);
EXPORT InValid_dl_state(SALT311.StrType s) := InValidFT_Invalid_State(s);
EXPORT InValidMessage_dl_state(UNSIGNED1 wh) := InValidMessageFT_Invalid_State(wh);
 
EXPORT Make_dispute_flag(SALT311.StrType s0) := s0;
EXPORT InValid_dispute_flag(SALT311.StrType s) := 0;
EXPORT InValidMessage_dispute_flag(UNSIGNED1 wh) := '';
 
EXPORT Make_security_freeze(SALT311.StrType s0) := s0;
EXPORT InValid_security_freeze(SALT311.StrType s) := 0;
EXPORT InValidMessage_security_freeze(UNSIGNED1 wh) := '';
 
EXPORT Make_security_freeze_pin(SALT311.StrType s0) := s0;
EXPORT InValid_security_freeze_pin(SALT311.StrType s) := 0;
EXPORT InValidMessage_security_freeze_pin(UNSIGNED1 wh) := '';
 
EXPORT Make_security_alert(SALT311.StrType s0) := s0;
EXPORT InValid_security_alert(SALT311.StrType s) := 0;
EXPORT InValidMessage_security_alert(UNSIGNED1 wh) := '';
 
EXPORT Make_negative_alert(SALT311.StrType s0) := s0;
EXPORT InValid_negative_alert(SALT311.StrType s) := 0;
EXPORT InValidMessage_negative_alert(UNSIGNED1 wh) := '';
 
EXPORT Make_id_theft_flag(SALT311.StrType s0) := s0;
EXPORT InValid_id_theft_flag(SALT311.StrType s) := 0;
EXPORT InValidMessage_id_theft_flag(UNSIGNED1 wh) := '';
 
EXPORT Make_insuff_inqry_data(SALT311.StrType s0) := s0;
EXPORT InValid_insuff_inqry_data(SALT311.StrType s) := 0;
EXPORT InValidMessage_insuff_inqry_data(UNSIGNED1 wh) := '';
 
EXPORT Make_consumer_statement_flag(SALT311.StrType s0) := s0;
EXPORT InValid_consumer_statement_flag(SALT311.StrType s) := 0;
EXPORT InValidMessage_consumer_statement_flag(UNSIGNED1 wh) := '';
 
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
    BOOLEAN Diff_uid;
    BOOLEAN Diff_date_created;
    BOOLEAN Diff_dt_first_seen;
    BOOLEAN Diff_dt_last_seen;
    BOOLEAN Diff_did;
    BOOLEAN Diff_fname;
    BOOLEAN Diff_mname;
    BOOLEAN Diff_lname;
    BOOLEAN Diff_name_suffix;
    BOOLEAN Diff_ssn;
    BOOLEAN Diff_dob;
    BOOLEAN Diff_predir;
    BOOLEAN Diff_prim_name;
    BOOLEAN Diff_prim_range;
    BOOLEAN Diff_suffix;
    BOOLEAN Diff_postdir;
    BOOLEAN Diff_unit_desig;
    BOOLEAN Diff_sec_range;
    BOOLEAN Diff_zip4;
    BOOLEAN Diff_address;
    BOOLEAN Diff_city_name;
    BOOLEAN Diff_st;
    BOOLEAN Diff_zip;
    BOOLEAN Diff_phone;
    BOOLEAN Diff_dl_number;
    BOOLEAN Diff_dl_state;
    BOOLEAN Diff_dispute_flag;
    BOOLEAN Diff_security_freeze;
    BOOLEAN Diff_security_freeze_pin;
    BOOLEAN Diff_security_alert;
    BOOLEAN Diff_negative_alert;
    BOOLEAN Diff_id_theft_flag;
    BOOLEAN Diff_insuff_inqry_data;
    BOOLEAN Diff_consumer_statement_flag;
    UNSIGNED Num_Diffs;
    SALT311.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_uid := le.uid <> ri.uid;
    SELF.Diff_date_created := le.date_created <> ri.date_created;
    SELF.Diff_dt_first_seen := le.dt_first_seen <> ri.dt_first_seen;
    SELF.Diff_dt_last_seen := le.dt_last_seen <> ri.dt_last_seen;
    SELF.Diff_did := le.did <> ri.did;
    SELF.Diff_fname := le.fname <> ri.fname;
    SELF.Diff_mname := le.mname <> ri.mname;
    SELF.Diff_lname := le.lname <> ri.lname;
    SELF.Diff_name_suffix := le.name_suffix <> ri.name_suffix;
    SELF.Diff_ssn := le.ssn <> ri.ssn;
    SELF.Diff_dob := le.dob <> ri.dob;
    SELF.Diff_predir := le.predir <> ri.predir;
    SELF.Diff_prim_name := le.prim_name <> ri.prim_name;
    SELF.Diff_prim_range := le.prim_range <> ri.prim_range;
    SELF.Diff_suffix := le.suffix <> ri.suffix;
    SELF.Diff_postdir := le.postdir <> ri.postdir;
    SELF.Diff_unit_desig := le.unit_desig <> ri.unit_desig;
    SELF.Diff_sec_range := le.sec_range <> ri.sec_range;
    SELF.Diff_zip4 := le.zip4 <> ri.zip4;
    SELF.Diff_address := le.address <> ri.address;
    SELF.Diff_city_name := le.city_name <> ri.city_name;
    SELF.Diff_st := le.st <> ri.st;
    SELF.Diff_zip := le.zip <> ri.zip;
    SELF.Diff_phone := le.phone <> ri.phone;
    SELF.Diff_dl_number := le.dl_number <> ri.dl_number;
    SELF.Diff_dl_state := le.dl_state <> ri.dl_state;
    SELF.Diff_dispute_flag := le.dispute_flag <> ri.dispute_flag;
    SELF.Diff_security_freeze := le.security_freeze <> ri.security_freeze;
    SELF.Diff_security_freeze_pin := le.security_freeze_pin <> ri.security_freeze_pin;
    SELF.Diff_security_alert := le.security_alert <> ri.security_alert;
    SELF.Diff_negative_alert := le.negative_alert <> ri.negative_alert;
    SELF.Diff_id_theft_flag := le.id_theft_flag <> ri.id_theft_flag;
    SELF.Diff_insuff_inqry_data := le.insuff_inqry_data <> ri.insuff_inqry_data;
    SELF.Diff_consumer_statement_flag := le.consumer_statement_flag <> ri.consumer_statement_flag;
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_uid,1,0)+ IF( SELF.Diff_date_created,1,0)+ IF( SELF.Diff_dt_first_seen,1,0)+ IF( SELF.Diff_dt_last_seen,1,0)+ IF( SELF.Diff_did,1,0)+ IF( SELF.Diff_fname,1,0)+ IF( SELF.Diff_mname,1,0)+ IF( SELF.Diff_lname,1,0)+ IF( SELF.Diff_name_suffix,1,0)+ IF( SELF.Diff_ssn,1,0)+ IF( SELF.Diff_dob,1,0)+ IF( SELF.Diff_predir,1,0)+ IF( SELF.Diff_prim_name,1,0)+ IF( SELF.Diff_prim_range,1,0)+ IF( SELF.Diff_suffix,1,0)+ IF( SELF.Diff_postdir,1,0)+ IF( SELF.Diff_unit_desig,1,0)+ IF( SELF.Diff_sec_range,1,0)+ IF( SELF.Diff_zip4,1,0)+ IF( SELF.Diff_address,1,0)+ IF( SELF.Diff_city_name,1,0)+ IF( SELF.Diff_st,1,0)+ IF( SELF.Diff_zip,1,0)+ IF( SELF.Diff_phone,1,0)+ IF( SELF.Diff_dl_number,1,0)+ IF( SELF.Diff_dl_state,1,0)+ IF( SELF.Diff_dispute_flag,1,0)+ IF( SELF.Diff_security_freeze,1,0)+ IF( SELF.Diff_security_freeze_pin,1,0)+ IF( SELF.Diff_security_alert,1,0)+ IF( SELF.Diff_negative_alert,1,0)+ IF( SELF.Diff_id_theft_flag,1,0)+ IF( SELF.Diff_insuff_inqry_data,1,0)+ IF( SELF.Diff_consumer_statement_flag,1,0);
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
    Count_Diff_uid := COUNT(GROUP,%Closest%.Diff_uid);
    Count_Diff_date_created := COUNT(GROUP,%Closest%.Diff_date_created);
    Count_Diff_dt_first_seen := COUNT(GROUP,%Closest%.Diff_dt_first_seen);
    Count_Diff_dt_last_seen := COUNT(GROUP,%Closest%.Diff_dt_last_seen);
    Count_Diff_did := COUNT(GROUP,%Closest%.Diff_did);
    Count_Diff_fname := COUNT(GROUP,%Closest%.Diff_fname);
    Count_Diff_mname := COUNT(GROUP,%Closest%.Diff_mname);
    Count_Diff_lname := COUNT(GROUP,%Closest%.Diff_lname);
    Count_Diff_name_suffix := COUNT(GROUP,%Closest%.Diff_name_suffix);
    Count_Diff_ssn := COUNT(GROUP,%Closest%.Diff_ssn);
    Count_Diff_dob := COUNT(GROUP,%Closest%.Diff_dob);
    Count_Diff_predir := COUNT(GROUP,%Closest%.Diff_predir);
    Count_Diff_prim_name := COUNT(GROUP,%Closest%.Diff_prim_name);
    Count_Diff_prim_range := COUNT(GROUP,%Closest%.Diff_prim_range);
    Count_Diff_suffix := COUNT(GROUP,%Closest%.Diff_suffix);
    Count_Diff_postdir := COUNT(GROUP,%Closest%.Diff_postdir);
    Count_Diff_unit_desig := COUNT(GROUP,%Closest%.Diff_unit_desig);
    Count_Diff_sec_range := COUNT(GROUP,%Closest%.Diff_sec_range);
    Count_Diff_zip4 := COUNT(GROUP,%Closest%.Diff_zip4);
    Count_Diff_address := COUNT(GROUP,%Closest%.Diff_address);
    Count_Diff_city_name := COUNT(GROUP,%Closest%.Diff_city_name);
    Count_Diff_st := COUNT(GROUP,%Closest%.Diff_st);
    Count_Diff_zip := COUNT(GROUP,%Closest%.Diff_zip);
    Count_Diff_phone := COUNT(GROUP,%Closest%.Diff_phone);
    Count_Diff_dl_number := COUNT(GROUP,%Closest%.Diff_dl_number);
    Count_Diff_dl_state := COUNT(GROUP,%Closest%.Diff_dl_state);
    Count_Diff_dispute_flag := COUNT(GROUP,%Closest%.Diff_dispute_flag);
    Count_Diff_security_freeze := COUNT(GROUP,%Closest%.Diff_security_freeze);
    Count_Diff_security_freeze_pin := COUNT(GROUP,%Closest%.Diff_security_freeze_pin);
    Count_Diff_security_alert := COUNT(GROUP,%Closest%.Diff_security_alert);
    Count_Diff_negative_alert := COUNT(GROUP,%Closest%.Diff_negative_alert);
    Count_Diff_id_theft_flag := COUNT(GROUP,%Closest%.Diff_id_theft_flag);
    Count_Diff_insuff_inqry_data := COUNT(GROUP,%Closest%.Diff_insuff_inqry_data);
    Count_Diff_consumer_statement_flag := COUNT(GROUP,%Closest%.Diff_consumer_statement_flag);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
