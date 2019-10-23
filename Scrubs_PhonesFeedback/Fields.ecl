IMPORT SALT311;
EXPORT Fields := MODULE
 
EXPORT NumFields := 26;
 
// Processing for each FieldType
EXPORT SALT311.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'Invalid_Num','Invalid_Direction','Invalid_State');
EXPORT FieldTypeNum(SALT311.StrType fn) := CASE(fn,'Invalid_Num' => 1,'Invalid_Direction' => 2,'Invalid_State' => 3,0);
 
EXPORT MakeFT_Invalid_Num(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Num(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_Invalid_Num(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Direction(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_Direction(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['N','S','E','W','NE','NW','SW','SE','']);
EXPORT InValidMessageFT_Invalid_Direction(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('N|S|E|W|NE|NW|SW|SE|'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_State(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_State(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 2));
EXPORT InValidMessageFT_Invalid_State(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ'),SALT311.HygieneErrors.NotLength('0,2'),SALT311.HygieneErrors.Good);
 
EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'did','did_score','hhid','phone_number','login_history_id','fname','lname','mname','street_pre_direction','street_post_direction','street_number','street_name','street_suffix','unit_number','unit_designation','zip5','zip4','city','state','alt_phone','other_info','phone_contact_type','feedback_source','date_time_added','loginid','customerid');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'did','did_score','hhid','phone_number','login_history_id','fname','lname','mname','street_pre_direction','street_post_direction','street_number','street_name','street_suffix','unit_number','unit_designation','zip5','zip4','city','state','alt_phone','other_info','phone_contact_type','feedback_source','date_time_added','loginid','customerid');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'did' => 0,'did_score' => 1,'hhid' => 2,'phone_number' => 3,'login_history_id' => 4,'fname' => 5,'lname' => 6,'mname' => 7,'street_pre_direction' => 8,'street_post_direction' => 9,'street_number' => 10,'street_name' => 11,'street_suffix' => 12,'unit_number' => 13,'unit_designation' => 14,'zip5' => 15,'zip4' => 16,'city' => 17,'state' => 18,'alt_phone' => 19,'other_info' => 20,'phone_contact_type' => 21,'feedback_source' => 22,'date_time_added' => 23,'loginid' => 24,'customerid' => 25,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],[],[],[],['ENUM'],['ENUM'],[],[],[],[],[],['ALLOW'],['ALLOW'],[],['ALLOW','LENGTHS'],['ALLOW'],[],['ALLOW'],['ALLOW'],[],[],[],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_did(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_did(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_did(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_did_score(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_did_score(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_did_score(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_hhid(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_hhid(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_hhid(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_phone_number(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_phone_number(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_phone_number(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_login_history_id(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_login_history_id(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_login_history_id(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_fname(SALT311.StrType s0) := s0;
EXPORT InValid_fname(SALT311.StrType s) := 0;
EXPORT InValidMessage_fname(UNSIGNED1 wh) := '';
 
EXPORT Make_lname(SALT311.StrType s0) := s0;
EXPORT InValid_lname(SALT311.StrType s) := 0;
EXPORT InValidMessage_lname(UNSIGNED1 wh) := '';
 
EXPORT Make_mname(SALT311.StrType s0) := s0;
EXPORT InValid_mname(SALT311.StrType s) := 0;
EXPORT InValidMessage_mname(UNSIGNED1 wh) := '';
 
EXPORT Make_street_pre_direction(SALT311.StrType s0) := MakeFT_Invalid_Direction(s0);
EXPORT InValid_street_pre_direction(SALT311.StrType s) := InValidFT_Invalid_Direction(s);
EXPORT InValidMessage_street_pre_direction(UNSIGNED1 wh) := InValidMessageFT_Invalid_Direction(wh);
 
EXPORT Make_street_post_direction(SALT311.StrType s0) := MakeFT_Invalid_Direction(s0);
EXPORT InValid_street_post_direction(SALT311.StrType s) := InValidFT_Invalid_Direction(s);
EXPORT InValidMessage_street_post_direction(UNSIGNED1 wh) := InValidMessageFT_Invalid_Direction(wh);
 
EXPORT Make_street_number(SALT311.StrType s0) := s0;
EXPORT InValid_street_number(SALT311.StrType s) := 0;
EXPORT InValidMessage_street_number(UNSIGNED1 wh) := '';
 
EXPORT Make_street_name(SALT311.StrType s0) := s0;
EXPORT InValid_street_name(SALT311.StrType s) := 0;
EXPORT InValidMessage_street_name(UNSIGNED1 wh) := '';
 
EXPORT Make_street_suffix(SALT311.StrType s0) := s0;
EXPORT InValid_street_suffix(SALT311.StrType s) := 0;
EXPORT InValidMessage_street_suffix(UNSIGNED1 wh) := '';
 
EXPORT Make_unit_number(SALT311.StrType s0) := s0;
EXPORT InValid_unit_number(SALT311.StrType s) := 0;
EXPORT InValidMessage_unit_number(UNSIGNED1 wh) := '';
 
EXPORT Make_unit_designation(SALT311.StrType s0) := s0;
EXPORT InValid_unit_designation(SALT311.StrType s) := 0;
EXPORT InValidMessage_unit_designation(UNSIGNED1 wh) := '';
 
EXPORT Make_zip5(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_zip5(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_zip5(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_zip4(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_zip4(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_zip4(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_city(SALT311.StrType s0) := s0;
EXPORT InValid_city(SALT311.StrType s) := 0;
EXPORT InValidMessage_city(UNSIGNED1 wh) := '';
 
EXPORT Make_state(SALT311.StrType s0) := MakeFT_Invalid_State(s0);
EXPORT InValid_state(SALT311.StrType s) := InValidFT_Invalid_State(s);
EXPORT InValidMessage_state(UNSIGNED1 wh) := InValidMessageFT_Invalid_State(wh);
 
EXPORT Make_alt_phone(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_alt_phone(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_alt_phone(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_other_info(SALT311.StrType s0) := s0;
EXPORT InValid_other_info(SALT311.StrType s) := 0;
EXPORT InValidMessage_other_info(UNSIGNED1 wh) := '';
 
EXPORT Make_phone_contact_type(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_phone_contact_type(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_phone_contact_type(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_feedback_source(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_feedback_source(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_feedback_source(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_date_time_added(SALT311.StrType s0) := s0;
EXPORT InValid_date_time_added(SALT311.StrType s) := 0;
EXPORT InValidMessage_date_time_added(UNSIGNED1 wh) := '';
 
EXPORT Make_loginid(SALT311.StrType s0) := s0;
EXPORT InValid_loginid(SALT311.StrType s) := 0;
EXPORT InValidMessage_loginid(UNSIGNED1 wh) := '';
 
EXPORT Make_customerid(SALT311.StrType s0) := s0;
EXPORT InValid_customerid(SALT311.StrType s) := 0;
EXPORT InValidMessage_customerid(UNSIGNED1 wh) := '';
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT311,Scrubs_PhonesFeedback;
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
    BOOLEAN Diff_did;
    BOOLEAN Diff_did_score;
    BOOLEAN Diff_hhid;
    BOOLEAN Diff_phone_number;
    BOOLEAN Diff_login_history_id;
    BOOLEAN Diff_fname;
    BOOLEAN Diff_lname;
    BOOLEAN Diff_mname;
    BOOLEAN Diff_street_pre_direction;
    BOOLEAN Diff_street_post_direction;
    BOOLEAN Diff_street_number;
    BOOLEAN Diff_street_name;
    BOOLEAN Diff_street_suffix;
    BOOLEAN Diff_unit_number;
    BOOLEAN Diff_unit_designation;
    BOOLEAN Diff_zip5;
    BOOLEAN Diff_zip4;
    BOOLEAN Diff_city;
    BOOLEAN Diff_state;
    BOOLEAN Diff_alt_phone;
    BOOLEAN Diff_other_info;
    BOOLEAN Diff_phone_contact_type;
    BOOLEAN Diff_feedback_source;
    BOOLEAN Diff_date_time_added;
    BOOLEAN Diff_loginid;
    BOOLEAN Diff_customerid;
    UNSIGNED Num_Diffs;
    SALT311.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_did := le.did <> ri.did;
    SELF.Diff_did_score := le.did_score <> ri.did_score;
    SELF.Diff_hhid := le.hhid <> ri.hhid;
    SELF.Diff_phone_number := le.phone_number <> ri.phone_number;
    SELF.Diff_login_history_id := le.login_history_id <> ri.login_history_id;
    SELF.Diff_fname := le.fname <> ri.fname;
    SELF.Diff_lname := le.lname <> ri.lname;
    SELF.Diff_mname := le.mname <> ri.mname;
    SELF.Diff_street_pre_direction := le.street_pre_direction <> ri.street_pre_direction;
    SELF.Diff_street_post_direction := le.street_post_direction <> ri.street_post_direction;
    SELF.Diff_street_number := le.street_number <> ri.street_number;
    SELF.Diff_street_name := le.street_name <> ri.street_name;
    SELF.Diff_street_suffix := le.street_suffix <> ri.street_suffix;
    SELF.Diff_unit_number := le.unit_number <> ri.unit_number;
    SELF.Diff_unit_designation := le.unit_designation <> ri.unit_designation;
    SELF.Diff_zip5 := le.zip5 <> ri.zip5;
    SELF.Diff_zip4 := le.zip4 <> ri.zip4;
    SELF.Diff_city := le.city <> ri.city;
    SELF.Diff_state := le.state <> ri.state;
    SELF.Diff_alt_phone := le.alt_phone <> ri.alt_phone;
    SELF.Diff_other_info := le.other_info <> ri.other_info;
    SELF.Diff_phone_contact_type := le.phone_contact_type <> ri.phone_contact_type;
    SELF.Diff_feedback_source := le.feedback_source <> ri.feedback_source;
    SELF.Diff_date_time_added := le.date_time_added <> ri.date_time_added;
    SELF.Diff_loginid := le.loginid <> ri.loginid;
    SELF.Diff_customerid := le.customerid <> ri.customerid;
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_did,1,0)+ IF( SELF.Diff_did_score,1,0)+ IF( SELF.Diff_hhid,1,0)+ IF( SELF.Diff_phone_number,1,0)+ IF( SELF.Diff_login_history_id,1,0)+ IF( SELF.Diff_fname,1,0)+ IF( SELF.Diff_lname,1,0)+ IF( SELF.Diff_mname,1,0)+ IF( SELF.Diff_street_pre_direction,1,0)+ IF( SELF.Diff_street_post_direction,1,0)+ IF( SELF.Diff_street_number,1,0)+ IF( SELF.Diff_street_name,1,0)+ IF( SELF.Diff_street_suffix,1,0)+ IF( SELF.Diff_unit_number,1,0)+ IF( SELF.Diff_unit_designation,1,0)+ IF( SELF.Diff_zip5,1,0)+ IF( SELF.Diff_zip4,1,0)+ IF( SELF.Diff_city,1,0)+ IF( SELF.Diff_state,1,0)+ IF( SELF.Diff_alt_phone,1,0)+ IF( SELF.Diff_other_info,1,0)+ IF( SELF.Diff_phone_contact_type,1,0)+ IF( SELF.Diff_feedback_source,1,0)+ IF( SELF.Diff_date_time_added,1,0)+ IF( SELF.Diff_loginid,1,0)+ IF( SELF.Diff_customerid,1,0);
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
    Count_Diff_did := COUNT(GROUP,%Closest%.Diff_did);
    Count_Diff_did_score := COUNT(GROUP,%Closest%.Diff_did_score);
    Count_Diff_hhid := COUNT(GROUP,%Closest%.Diff_hhid);
    Count_Diff_phone_number := COUNT(GROUP,%Closest%.Diff_phone_number);
    Count_Diff_login_history_id := COUNT(GROUP,%Closest%.Diff_login_history_id);
    Count_Diff_fname := COUNT(GROUP,%Closest%.Diff_fname);
    Count_Diff_lname := COUNT(GROUP,%Closest%.Diff_lname);
    Count_Diff_mname := COUNT(GROUP,%Closest%.Diff_mname);
    Count_Diff_street_pre_direction := COUNT(GROUP,%Closest%.Diff_street_pre_direction);
    Count_Diff_street_post_direction := COUNT(GROUP,%Closest%.Diff_street_post_direction);
    Count_Diff_street_number := COUNT(GROUP,%Closest%.Diff_street_number);
    Count_Diff_street_name := COUNT(GROUP,%Closest%.Diff_street_name);
    Count_Diff_street_suffix := COUNT(GROUP,%Closest%.Diff_street_suffix);
    Count_Diff_unit_number := COUNT(GROUP,%Closest%.Diff_unit_number);
    Count_Diff_unit_designation := COUNT(GROUP,%Closest%.Diff_unit_designation);
    Count_Diff_zip5 := COUNT(GROUP,%Closest%.Diff_zip5);
    Count_Diff_zip4 := COUNT(GROUP,%Closest%.Diff_zip4);
    Count_Diff_city := COUNT(GROUP,%Closest%.Diff_city);
    Count_Diff_state := COUNT(GROUP,%Closest%.Diff_state);
    Count_Diff_alt_phone := COUNT(GROUP,%Closest%.Diff_alt_phone);
    Count_Diff_other_info := COUNT(GROUP,%Closest%.Diff_other_info);
    Count_Diff_phone_contact_type := COUNT(GROUP,%Closest%.Diff_phone_contact_type);
    Count_Diff_feedback_source := COUNT(GROUP,%Closest%.Diff_feedback_source);
    Count_Diff_date_time_added := COUNT(GROUP,%Closest%.Diff_date_time_added);
    Count_Diff_loginid := COUNT(GROUP,%Closest%.Diff_loginid);
    Count_Diff_customerid := COUNT(GROUP,%Closest%.Diff_customerid);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
