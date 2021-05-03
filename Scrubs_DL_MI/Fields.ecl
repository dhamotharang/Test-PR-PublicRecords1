IMPORT SALT311;
IMPORT Scrubs,Scrubs_DL_MI; // Import modules for FieldTypes attribute definitions
EXPORT Fields := MODULE
 
EXPORT NumFields := 26;
 
// Processing for each FieldType
EXPORT SALT311.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_past_date','invalid_code','invalid_numeric','invalid_dl_number_check','invalid_gender','invalid_dln_pid_indi','invalid_name','invalid_city','invalid_street','invalid_state','invalid_zip','invalid_clean_name');
EXPORT FieldTypeNum(SALT311.StrType fn) := CASE(fn,'invalid_past_date' => 1,'invalid_code' => 2,'invalid_numeric' => 3,'invalid_dl_number_check' => 4,'invalid_gender' => 5,'invalid_dln_pid_indi' => 6,'invalid_name' => 7,'invalid_city' => 8,'invalid_street' => 9,'invalid_state' => 10,'invalid_zip' => 11,'invalid_clean_name' => 12,0);
 
EXPORT MakeFT_invalid_past_date(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_past_date(SALT311.StrType s) := WHICH(~Scrubs.fn_valid_pastDate(s)>0,~(LENGTH(TRIM(s)) = 8));
EXPORT InValidMessageFT_invalid_past_date(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.fn_valid_pastDate'),SALT311.HygieneErrors.NotLength('8'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_code(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_code(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['A','C','']);
EXPORT InValidMessageFT_invalid_code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('A|C|'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_numeric(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_numeric(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_invalid_numeric(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_dl_number_check(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_dl_number_check(SALT311.StrType s) := WHICH(~Scrubs_DL_MI.Functions.fn_check_dl_number(s)>0);
EXPORT InValidMessageFT_invalid_dl_number_check(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_DL_MI.Functions.fn_check_dl_number'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_gender(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_gender(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['F','M','U','']);
EXPORT InValidMessageFT_invalid_gender(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('F|M|U|'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_dln_pid_indi(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_dln_pid_indi(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['D','P','']);
EXPORT InValidMessageFT_invalid_dln_pid_indi(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('D|P|'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_name(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_name(SALT311.StrType s,SALT311.StrType middle_name,SALT311.StrType last_name) := WHICH(~scrubs.functions.fn_populated_strings(s,middle_name,last_name)>0);
EXPORT InValidMessageFT_invalid_name(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('scrubs.functions.fn_populated_strings'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_city(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-#,.\'@& '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_city(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-#,.\'@& '))));
EXPORT InValidMessageFT_invalid_city(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-#,.\'@& '),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_street(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'\\-/#,.\'=%:&(;)0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_street(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'\\-/#,.\'=%:&(;)0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ '))));
EXPORT InValidMessageFT_invalid_street(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('\\-/#,.\'=%:&(;)0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_state(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_state(SALT311.StrType s) := WHICH(~Scrubs_DL_MI.Functions.fn_verify_state(s)>0);
EXPORT InValidMessageFT_invalid_state(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_DL_MI.Functions.fn_verify_state'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_zip(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_zip(SALT311.StrType s) := WHICH(~Scrubs.Functions.fn_verify_zip59(s)>0);
EXPORT InValidMessageFT_invalid_zip(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.Functions.fn_verify_zip59'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_clean_name(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_clean_name(SALT311.StrType s,SALT311.StrType clean_mname,SALT311.StrType clean_lname) := WHICH(~scrubs.functions.fn_populated_strings(s,clean_mname,clean_lname)>0);
EXPORT InValidMessageFT_invalid_clean_name(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('scrubs.functions.fn_populated_strings'),SALT311.HygieneErrors.Good);
 
EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'process_date','code','customer_dln_pid','last_name','first_name','middle_name','name_suffix','street_address','city','state','zipcode','date_of_birth','gender','county','dln_pid_indicator','mailing_street_address','mailing_city','mailing_state','mailing_zipcode','blob','clean_name_prefix','clean_fname','clean_mname','clean_lname','clean_name_suffix','clean_name_score');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'process_date','code','customer_dln_pid','last_name','first_name','middle_name','name_suffix','street_address','city','state','zipcode','date_of_birth','gender','county','dln_pid_indicator','mailing_street_address','mailing_city','mailing_state','mailing_zipcode','blob','clean_name_prefix','clean_fname','clean_mname','clean_lname','clean_name_suffix','clean_name_score');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'process_date' => 0,'code' => 1,'customer_dln_pid' => 2,'last_name' => 3,'first_name' => 4,'middle_name' => 5,'name_suffix' => 6,'street_address' => 7,'city' => 8,'state' => 9,'zipcode' => 10,'date_of_birth' => 11,'gender' => 12,'county' => 13,'dln_pid_indicator' => 14,'mailing_street_address' => 15,'mailing_city' => 16,'mailing_state' => 17,'mailing_zipcode' => 18,'blob' => 19,'clean_name_prefix' => 20,'clean_fname' => 21,'clean_mname' => 22,'clean_lname' => 23,'clean_name_suffix' => 24,'clean_name_score' => 25,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['CUSTOM','LENGTHS'],['ENUM'],['CUSTOM'],[],['CUSTOM'],[],[],['ALLOW'],['ALLOW'],['CUSTOM'],['CUSTOM'],['CUSTOM','LENGTHS'],['ENUM'],['ALLOW'],['ENUM'],['ALLOW'],['ALLOW'],['CUSTOM'],['CUSTOM'],[],[],['CUSTOM'],[],[],[],[],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_process_date(SALT311.StrType s0) := MakeFT_invalid_past_date(s0);
EXPORT InValid_process_date(SALT311.StrType s) := InValidFT_invalid_past_date(s);
EXPORT InValidMessage_process_date(UNSIGNED1 wh) := InValidMessageFT_invalid_past_date(wh);
 
EXPORT Make_code(SALT311.StrType s0) := MakeFT_invalid_code(s0);
EXPORT InValid_code(SALT311.StrType s) := InValidFT_invalid_code(s);
EXPORT InValidMessage_code(UNSIGNED1 wh) := InValidMessageFT_invalid_code(wh);
 
EXPORT Make_customer_dln_pid(SALT311.StrType s0) := MakeFT_invalid_dl_number_check(s0);
EXPORT InValid_customer_dln_pid(SALT311.StrType s) := InValidFT_invalid_dl_number_check(s);
EXPORT InValidMessage_customer_dln_pid(UNSIGNED1 wh) := InValidMessageFT_invalid_dl_number_check(wh);
 
EXPORT Make_last_name(SALT311.StrType s0) := s0;
EXPORT InValid_last_name(SALT311.StrType s) := 0;
EXPORT InValidMessage_last_name(UNSIGNED1 wh) := '';
 
EXPORT Make_first_name(SALT311.StrType s0) := MakeFT_invalid_name(s0);
EXPORT InValid_first_name(SALT311.StrType s,SALT311.StrType middle_name,SALT311.StrType last_name) := InValidFT_invalid_name(s,middle_name,last_name);
EXPORT InValidMessage_first_name(UNSIGNED1 wh) := InValidMessageFT_invalid_name(wh);
 
EXPORT Make_middle_name(SALT311.StrType s0) := s0;
EXPORT InValid_middle_name(SALT311.StrType s) := 0;
EXPORT InValidMessage_middle_name(UNSIGNED1 wh) := '';
 
EXPORT Make_name_suffix(SALT311.StrType s0) := s0;
EXPORT InValid_name_suffix(SALT311.StrType s) := 0;
EXPORT InValidMessage_name_suffix(UNSIGNED1 wh) := '';
 
EXPORT Make_street_address(SALT311.StrType s0) := MakeFT_invalid_street(s0);
EXPORT InValid_street_address(SALT311.StrType s) := InValidFT_invalid_street(s);
EXPORT InValidMessage_street_address(UNSIGNED1 wh) := InValidMessageFT_invalid_street(wh);
 
EXPORT Make_city(SALT311.StrType s0) := MakeFT_invalid_city(s0);
EXPORT InValid_city(SALT311.StrType s) := InValidFT_invalid_city(s);
EXPORT InValidMessage_city(UNSIGNED1 wh) := InValidMessageFT_invalid_city(wh);
 
EXPORT Make_state(SALT311.StrType s0) := MakeFT_invalid_state(s0);
EXPORT InValid_state(SALT311.StrType s) := InValidFT_invalid_state(s);
EXPORT InValidMessage_state(UNSIGNED1 wh) := InValidMessageFT_invalid_state(wh);
 
EXPORT Make_zipcode(SALT311.StrType s0) := MakeFT_invalid_zip(s0);
EXPORT InValid_zipcode(SALT311.StrType s) := InValidFT_invalid_zip(s);
EXPORT InValidMessage_zipcode(UNSIGNED1 wh) := InValidMessageFT_invalid_zip(wh);
 
EXPORT Make_date_of_birth(SALT311.StrType s0) := MakeFT_invalid_past_date(s0);
EXPORT InValid_date_of_birth(SALT311.StrType s) := InValidFT_invalid_past_date(s);
EXPORT InValidMessage_date_of_birth(UNSIGNED1 wh) := InValidMessageFT_invalid_past_date(wh);
 
EXPORT Make_gender(SALT311.StrType s0) := MakeFT_invalid_gender(s0);
EXPORT InValid_gender(SALT311.StrType s) := InValidFT_invalid_gender(s);
EXPORT InValidMessage_gender(UNSIGNED1 wh) := InValidMessageFT_invalid_gender(wh);
 
EXPORT Make_county(SALT311.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_county(SALT311.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_county(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_dln_pid_indicator(SALT311.StrType s0) := MakeFT_invalid_dln_pid_indi(s0);
EXPORT InValid_dln_pid_indicator(SALT311.StrType s) := InValidFT_invalid_dln_pid_indi(s);
EXPORT InValidMessage_dln_pid_indicator(UNSIGNED1 wh) := InValidMessageFT_invalid_dln_pid_indi(wh);
 
EXPORT Make_mailing_street_address(SALT311.StrType s0) := MakeFT_invalid_street(s0);
EXPORT InValid_mailing_street_address(SALT311.StrType s) := InValidFT_invalid_street(s);
EXPORT InValidMessage_mailing_street_address(UNSIGNED1 wh) := InValidMessageFT_invalid_street(wh);
 
EXPORT Make_mailing_city(SALT311.StrType s0) := MakeFT_invalid_city(s0);
EXPORT InValid_mailing_city(SALT311.StrType s) := InValidFT_invalid_city(s);
EXPORT InValidMessage_mailing_city(UNSIGNED1 wh) := InValidMessageFT_invalid_city(wh);
 
EXPORT Make_mailing_state(SALT311.StrType s0) := MakeFT_invalid_state(s0);
EXPORT InValid_mailing_state(SALT311.StrType s) := InValidFT_invalid_state(s);
EXPORT InValidMessage_mailing_state(UNSIGNED1 wh) := InValidMessageFT_invalid_state(wh);
 
EXPORT Make_mailing_zipcode(SALT311.StrType s0) := MakeFT_invalid_zip(s0);
EXPORT InValid_mailing_zipcode(SALT311.StrType s) := InValidFT_invalid_zip(s);
EXPORT InValidMessage_mailing_zipcode(UNSIGNED1 wh) := InValidMessageFT_invalid_zip(wh);
 
EXPORT Make_blob(SALT311.StrType s0) := s0;
EXPORT InValid_blob(SALT311.StrType s) := 0;
EXPORT InValidMessage_blob(UNSIGNED1 wh) := '';
 
EXPORT Make_clean_name_prefix(SALT311.StrType s0) := s0;
EXPORT InValid_clean_name_prefix(SALT311.StrType s) := 0;
EXPORT InValidMessage_clean_name_prefix(UNSIGNED1 wh) := '';
 
EXPORT Make_clean_fname(SALT311.StrType s0) := MakeFT_invalid_clean_name(s0);
EXPORT InValid_clean_fname(SALT311.StrType s,SALT311.StrType clean_mname,SALT311.StrType clean_lname) := InValidFT_invalid_clean_name(s,clean_mname,clean_lname);
EXPORT InValidMessage_clean_fname(UNSIGNED1 wh) := InValidMessageFT_invalid_clean_name(wh);
 
EXPORT Make_clean_mname(SALT311.StrType s0) := s0;
EXPORT InValid_clean_mname(SALT311.StrType s) := 0;
EXPORT InValidMessage_clean_mname(UNSIGNED1 wh) := '';
 
EXPORT Make_clean_lname(SALT311.StrType s0) := s0;
EXPORT InValid_clean_lname(SALT311.StrType s) := 0;
EXPORT InValidMessage_clean_lname(UNSIGNED1 wh) := '';
 
EXPORT Make_clean_name_suffix(SALT311.StrType s0) := s0;
EXPORT InValid_clean_name_suffix(SALT311.StrType s) := 0;
EXPORT InValidMessage_clean_name_suffix(UNSIGNED1 wh) := '';
 
EXPORT Make_clean_name_score(SALT311.StrType s0) := s0;
EXPORT InValid_clean_name_score(SALT311.StrType s) := 0;
EXPORT InValidMessage_clean_name_score(UNSIGNED1 wh) := '';
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT311,Scrubs_DL_MI;
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
    BOOLEAN Diff_code;
    BOOLEAN Diff_customer_dln_pid;
    BOOLEAN Diff_last_name;
    BOOLEAN Diff_first_name;
    BOOLEAN Diff_middle_name;
    BOOLEAN Diff_name_suffix;
    BOOLEAN Diff_street_address;
    BOOLEAN Diff_city;
    BOOLEAN Diff_state;
    BOOLEAN Diff_zipcode;
    BOOLEAN Diff_date_of_birth;
    BOOLEAN Diff_gender;
    BOOLEAN Diff_county;
    BOOLEAN Diff_dln_pid_indicator;
    BOOLEAN Diff_mailing_street_address;
    BOOLEAN Diff_mailing_city;
    BOOLEAN Diff_mailing_state;
    BOOLEAN Diff_mailing_zipcode;
    BOOLEAN Diff_blob;
    BOOLEAN Diff_clean_name_prefix;
    BOOLEAN Diff_clean_fname;
    BOOLEAN Diff_clean_mname;
    BOOLEAN Diff_clean_lname;
    BOOLEAN Diff_clean_name_suffix;
    BOOLEAN Diff_clean_name_score;
    UNSIGNED Num_Diffs;
    SALT311.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_process_date := le.process_date <> ri.process_date;
    SELF.Diff_code := le.code <> ri.code;
    SELF.Diff_customer_dln_pid := le.customer_dln_pid <> ri.customer_dln_pid;
    SELF.Diff_last_name := le.last_name <> ri.last_name;
    SELF.Diff_first_name := le.first_name <> ri.first_name;
    SELF.Diff_middle_name := le.middle_name <> ri.middle_name;
    SELF.Diff_name_suffix := le.name_suffix <> ri.name_suffix;
    SELF.Diff_street_address := le.street_address <> ri.street_address;
    SELF.Diff_city := le.city <> ri.city;
    SELF.Diff_state := le.state <> ri.state;
    SELF.Diff_zipcode := le.zipcode <> ri.zipcode;
    SELF.Diff_date_of_birth := le.date_of_birth <> ri.date_of_birth;
    SELF.Diff_gender := le.gender <> ri.gender;
    SELF.Diff_county := le.county <> ri.county;
    SELF.Diff_dln_pid_indicator := le.dln_pid_indicator <> ri.dln_pid_indicator;
    SELF.Diff_mailing_street_address := le.mailing_street_address <> ri.mailing_street_address;
    SELF.Diff_mailing_city := le.mailing_city <> ri.mailing_city;
    SELF.Diff_mailing_state := le.mailing_state <> ri.mailing_state;
    SELF.Diff_mailing_zipcode := le.mailing_zipcode <> ri.mailing_zipcode;
    SELF.Diff_blob := le.blob <> ri.blob;
    SELF.Diff_clean_name_prefix := le.clean_name_prefix <> ri.clean_name_prefix;
    SELF.Diff_clean_fname := le.clean_fname <> ri.clean_fname;
    SELF.Diff_clean_mname := le.clean_mname <> ri.clean_mname;
    SELF.Diff_clean_lname := le.clean_lname <> ri.clean_lname;
    SELF.Diff_clean_name_suffix := le.clean_name_suffix <> ri.clean_name_suffix;
    SELF.Diff_clean_name_score := le.clean_name_score <> ri.clean_name_score;
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_process_date,1,0)+ IF( SELF.Diff_code,1,0)+ IF( SELF.Diff_customer_dln_pid,1,0)+ IF( SELF.Diff_last_name,1,0)+ IF( SELF.Diff_first_name,1,0)+ IF( SELF.Diff_middle_name,1,0)+ IF( SELF.Diff_name_suffix,1,0)+ IF( SELF.Diff_street_address,1,0)+ IF( SELF.Diff_city,1,0)+ IF( SELF.Diff_state,1,0)+ IF( SELF.Diff_zipcode,1,0)+ IF( SELF.Diff_date_of_birth,1,0)+ IF( SELF.Diff_gender,1,0)+ IF( SELF.Diff_county,1,0)+ IF( SELF.Diff_dln_pid_indicator,1,0)+ IF( SELF.Diff_mailing_street_address,1,0)+ IF( SELF.Diff_mailing_city,1,0)+ IF( SELF.Diff_mailing_state,1,0)+ IF( SELF.Diff_mailing_zipcode,1,0)+ IF( SELF.Diff_blob,1,0)+ IF( SELF.Diff_clean_name_prefix,1,0)+ IF( SELF.Diff_clean_fname,1,0)+ IF( SELF.Diff_clean_mname,1,0)+ IF( SELF.Diff_clean_lname,1,0)+ IF( SELF.Diff_clean_name_suffix,1,0)+ IF( SELF.Diff_clean_name_score,1,0);
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
    Count_Diff_code := COUNT(GROUP,%Closest%.Diff_code);
    Count_Diff_customer_dln_pid := COUNT(GROUP,%Closest%.Diff_customer_dln_pid);
    Count_Diff_last_name := COUNT(GROUP,%Closest%.Diff_last_name);
    Count_Diff_first_name := COUNT(GROUP,%Closest%.Diff_first_name);
    Count_Diff_middle_name := COUNT(GROUP,%Closest%.Diff_middle_name);
    Count_Diff_name_suffix := COUNT(GROUP,%Closest%.Diff_name_suffix);
    Count_Diff_street_address := COUNT(GROUP,%Closest%.Diff_street_address);
    Count_Diff_city := COUNT(GROUP,%Closest%.Diff_city);
    Count_Diff_state := COUNT(GROUP,%Closest%.Diff_state);
    Count_Diff_zipcode := COUNT(GROUP,%Closest%.Diff_zipcode);
    Count_Diff_date_of_birth := COUNT(GROUP,%Closest%.Diff_date_of_birth);
    Count_Diff_gender := COUNT(GROUP,%Closest%.Diff_gender);
    Count_Diff_county := COUNT(GROUP,%Closest%.Diff_county);
    Count_Diff_dln_pid_indicator := COUNT(GROUP,%Closest%.Diff_dln_pid_indicator);
    Count_Diff_mailing_street_address := COUNT(GROUP,%Closest%.Diff_mailing_street_address);
    Count_Diff_mailing_city := COUNT(GROUP,%Closest%.Diff_mailing_city);
    Count_Diff_mailing_state := COUNT(GROUP,%Closest%.Diff_mailing_state);
    Count_Diff_mailing_zipcode := COUNT(GROUP,%Closest%.Diff_mailing_zipcode);
    Count_Diff_blob := COUNT(GROUP,%Closest%.Diff_blob);
    Count_Diff_clean_name_prefix := COUNT(GROUP,%Closest%.Diff_clean_name_prefix);
    Count_Diff_clean_fname := COUNT(GROUP,%Closest%.Diff_clean_fname);
    Count_Diff_clean_mname := COUNT(GROUP,%Closest%.Diff_clean_mname);
    Count_Diff_clean_lname := COUNT(GROUP,%Closest%.Diff_clean_lname);
    Count_Diff_clean_name_suffix := COUNT(GROUP,%Closest%.Diff_clean_name_suffix);
    Count_Diff_clean_name_score := COUNT(GROUP,%Closest%.Diff_clean_name_score);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
