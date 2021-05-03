IMPORT SALT311;
IMPORT Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT Fields := MODULE
 
EXPORT NumFields := 40;
 
// Processing for each FieldType
EXPORT SALT311.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'Invalid_No','Invalid_Alpha','Invalid_AlphaChar','Invalid_AlphaNum','Invalid_AlphaNumChar','Invalid_Date','Invalid_Dir','Invalid_Phone','Invalid_Zip','Invalid_State');
EXPORT FieldTypeNum(SALT311.StrType fn) := CASE(fn,'Invalid_No' => 1,'Invalid_Alpha' => 2,'Invalid_AlphaChar' => 3,'Invalid_AlphaNum' => 4,'Invalid_AlphaNumChar' => 5,'Invalid_Date' => 6,'Invalid_Dir' => 7,'Invalid_Phone' => 8,'Invalid_Zip' => 9,'Invalid_State' => 10,0);
 
EXPORT MakeFT_Invalid_No(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_No(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_Invalid_No(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Alpha(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Alpha(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ '))));
EXPORT InValidMessageFT_Invalid_Alpha(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_AlphaChar(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ \'-'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_AlphaChar(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ \'-'))));
EXPORT InValidMessageFT_Invalid_AlphaChar(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ \'-'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_AlphaNum(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_AlphaNum(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ '))));
EXPORT InValidMessageFT_Invalid_AlphaNum(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_AlphaNumChar(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ .,-/:#'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_AlphaNumChar(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ .,-/:#'))));
EXPORT InValidMessageFT_Invalid_AlphaNumChar(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ .,-/:#'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Date(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_Date(SALT311.StrType s) := WHICH(~Scrubs.fn_valid_date(s)>0);
EXPORT InValidMessageFT_Invalid_Date(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.fn_valid_date'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Dir(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'NSEW'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Dir(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'NSEW'))));
EXPORT InValidMessageFT_Invalid_Dir(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('NSEW'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Phone(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  MakeFT_Invalid_No(s1);
END;
EXPORT InValidFT_Invalid_Phone(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 10 OR LENGTH(TRIM(s)) = 11));
EXPORT InValidMessageFT_Invalid_Phone(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789'),SALT311.HygieneErrors.NotLength('0,10,11'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Zip(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  MakeFT_Invalid_No(s1);
END;
EXPORT InValidFT_Invalid_Zip(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 5));
EXPORT InValidMessageFT_Invalid_Zip(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789'),SALT311.HygieneErrors.NotLength('0,5'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_State(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  RETURN  MakeFT_Invalid_Alpha(s1);
END;
EXPORT InValidFT_Invalid_State(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 2));
EXPORT InValidMessageFT_Invalid_State(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT311.HygieneErrors.NotLength('0,2'),SALT311.HygieneErrors.Good);
 
EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'did','did_score','raw_aid','hhid','address_feedback_id','login_history_id','phone_number','unique_id','fname','lname','mname','orig_street_pre_direction','orig_street_post_direction','orig_street_number','orig_street_name','orig_street_suffix','orig_unit_number','orig_unit_designation','orig_zip5','orig_zip4','orig_city','orig_state','street_pre_direction','street_post_direction','street_number','street_name','street_suffix','unit_number','unit_designation','zip5','zip4','city','state','alt_phone','other_info','address_contact_type','feedback_source','date_time_added','loginid','companyid');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'did','did_score','raw_aid','hhid','address_feedback_id','login_history_id','phone_number','unique_id','fname','lname','mname','orig_street_pre_direction','orig_street_post_direction','orig_street_number','orig_street_name','orig_street_suffix','orig_unit_number','orig_unit_designation','orig_zip5','orig_zip4','orig_city','orig_state','street_pre_direction','street_post_direction','street_number','street_name','street_suffix','unit_number','unit_designation','zip5','zip4','city','state','alt_phone','other_info','address_contact_type','feedback_source','date_time_added','loginid','companyid');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'did' => 0,'did_score' => 1,'raw_aid' => 2,'hhid' => 3,'address_feedback_id' => 4,'login_history_id' => 5,'phone_number' => 6,'unique_id' => 7,'fname' => 8,'lname' => 9,'mname' => 10,'orig_street_pre_direction' => 11,'orig_street_post_direction' => 12,'orig_street_number' => 13,'orig_street_name' => 14,'orig_street_suffix' => 15,'orig_unit_number' => 16,'orig_unit_designation' => 17,'orig_zip5' => 18,'orig_zip4' => 19,'orig_city' => 20,'orig_state' => 21,'street_pre_direction' => 22,'street_post_direction' => 23,'street_number' => 24,'street_name' => 25,'street_suffix' => 26,'unit_number' => 27,'unit_designation' => 28,'zip5' => 29,'zip4' => 30,'city' => 31,'state' => 32,'alt_phone' => 33,'other_info' => 34,'address_contact_type' => 35,'feedback_source' => 36,'date_time_added' => 37,'loginid' => 38,'companyid' => 39,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,[],[],[],[],['ALLOW'],['ALLOW'],['ALLOW','LENGTHS'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW','LENGTHS'],['ALLOW'],['ALLOW'],['ALLOW','LENGTHS'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW','LENGTHS'],['ALLOW'],['ALLOW'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],[],['ALLOW'],['ALLOW'],['CUSTOM'],['ALLOW'],['ALLOW'],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_did(SALT311.StrType s0) := s0;
EXPORT InValid_did(SALT311.StrType s) := 0;
EXPORT InValidMessage_did(UNSIGNED1 wh) := '';
 
EXPORT Make_did_score(SALT311.StrType s0) := s0;
EXPORT InValid_did_score(SALT311.StrType s) := 0;
EXPORT InValidMessage_did_score(UNSIGNED1 wh) := '';
 
EXPORT Make_raw_aid(SALT311.StrType s0) := s0;
EXPORT InValid_raw_aid(SALT311.StrType s) := 0;
EXPORT InValidMessage_raw_aid(UNSIGNED1 wh) := '';
 
EXPORT Make_hhid(SALT311.StrType s0) := s0;
EXPORT InValid_hhid(SALT311.StrType s) := 0;
EXPORT InValidMessage_hhid(UNSIGNED1 wh) := '';
 
EXPORT Make_address_feedback_id(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_address_feedback_id(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_address_feedback_id(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_login_history_id(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_login_history_id(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_login_history_id(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_phone_number(SALT311.StrType s0) := MakeFT_Invalid_Phone(s0);
EXPORT InValid_phone_number(SALT311.StrType s) := InValidFT_Invalid_Phone(s);
EXPORT InValidMessage_phone_number(UNSIGNED1 wh) := InValidMessageFT_Invalid_Phone(wh);
 
EXPORT Make_unique_id(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_unique_id(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_unique_id(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_fname(SALT311.StrType s0) := MakeFT_Invalid_AlphaChar(s0);
EXPORT InValid_fname(SALT311.StrType s) := InValidFT_Invalid_AlphaChar(s);
EXPORT InValidMessage_fname(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaChar(wh);
 
EXPORT Make_lname(SALT311.StrType s0) := MakeFT_Invalid_AlphaChar(s0);
EXPORT InValid_lname(SALT311.StrType s) := InValidFT_Invalid_AlphaChar(s);
EXPORT InValidMessage_lname(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaChar(wh);
 
EXPORT Make_mname(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_mname(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_mname(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_orig_street_pre_direction(SALT311.StrType s0) := MakeFT_Invalid_Dir(s0);
EXPORT InValid_orig_street_pre_direction(SALT311.StrType s) := InValidFT_Invalid_Dir(s);
EXPORT InValidMessage_orig_street_pre_direction(UNSIGNED1 wh) := InValidMessageFT_Invalid_Dir(wh);
 
EXPORT Make_orig_street_post_direction(SALT311.StrType s0) := MakeFT_Invalid_Dir(s0);
EXPORT InValid_orig_street_post_direction(SALT311.StrType s) := InValidFT_Invalid_Dir(s);
EXPORT InValidMessage_orig_street_post_direction(UNSIGNED1 wh) := InValidMessageFT_Invalid_Dir(wh);
 
EXPORT Make_orig_street_number(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_orig_street_number(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_orig_street_number(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_orig_street_name(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_orig_street_name(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_orig_street_name(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
EXPORT Make_orig_street_suffix(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_orig_street_suffix(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_orig_street_suffix(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_orig_unit_number(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_orig_unit_number(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_orig_unit_number(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
EXPORT Make_orig_unit_designation(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_orig_unit_designation(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_orig_unit_designation(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_orig_zip5(SALT311.StrType s0) := MakeFT_Invalid_Zip(s0);
EXPORT InValid_orig_zip5(SALT311.StrType s) := InValidFT_Invalid_Zip(s);
EXPORT InValidMessage_orig_zip5(UNSIGNED1 wh) := InValidMessageFT_Invalid_Zip(wh);
 
EXPORT Make_orig_zip4(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_orig_zip4(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_orig_zip4(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_orig_city(SALT311.StrType s0) := MakeFT_Invalid_AlphaChar(s0);
EXPORT InValid_orig_city(SALT311.StrType s) := InValidFT_Invalid_AlphaChar(s);
EXPORT InValidMessage_orig_city(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaChar(wh);
 
EXPORT Make_orig_state(SALT311.StrType s0) := MakeFT_Invalid_State(s0);
EXPORT InValid_orig_state(SALT311.StrType s) := InValidFT_Invalid_State(s);
EXPORT InValidMessage_orig_state(UNSIGNED1 wh) := InValidMessageFT_Invalid_State(wh);
 
EXPORT Make_street_pre_direction(SALT311.StrType s0) := MakeFT_Invalid_Dir(s0);
EXPORT InValid_street_pre_direction(SALT311.StrType s) := InValidFT_Invalid_Dir(s);
EXPORT InValidMessage_street_pre_direction(UNSIGNED1 wh) := InValidMessageFT_Invalid_Dir(wh);
 
EXPORT Make_street_post_direction(SALT311.StrType s0) := MakeFT_Invalid_Dir(s0);
EXPORT InValid_street_post_direction(SALT311.StrType s) := InValidFT_Invalid_Dir(s);
EXPORT InValidMessage_street_post_direction(UNSIGNED1 wh) := InValidMessageFT_Invalid_Dir(wh);
 
EXPORT Make_street_number(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_street_number(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_street_number(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_street_name(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_street_name(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_street_name(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
EXPORT Make_street_suffix(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_street_suffix(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_street_suffix(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_unit_number(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_unit_number(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_unit_number(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
EXPORT Make_unit_designation(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_unit_designation(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_unit_designation(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_zip5(SALT311.StrType s0) := MakeFT_Invalid_Zip(s0);
EXPORT InValid_zip5(SALT311.StrType s) := InValidFT_Invalid_Zip(s);
EXPORT InValidMessage_zip5(UNSIGNED1 wh) := InValidMessageFT_Invalid_Zip(wh);
 
EXPORT Make_zip4(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_zip4(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_zip4(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_city(SALT311.StrType s0) := MakeFT_Invalid_AlphaChar(s0);
EXPORT InValid_city(SALT311.StrType s) := InValidFT_Invalid_AlphaChar(s);
EXPORT InValidMessage_city(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaChar(wh);
 
EXPORT Make_state(SALT311.StrType s0) := MakeFT_Invalid_State(s0);
EXPORT InValid_state(SALT311.StrType s) := InValidFT_Invalid_State(s);
EXPORT InValidMessage_state(UNSIGNED1 wh) := InValidMessageFT_Invalid_State(wh);
 
EXPORT Make_alt_phone(SALT311.StrType s0) := MakeFT_Invalid_Phone(s0);
EXPORT InValid_alt_phone(SALT311.StrType s) := InValidFT_Invalid_Phone(s);
EXPORT InValidMessage_alt_phone(UNSIGNED1 wh) := InValidMessageFT_Invalid_Phone(wh);
 
EXPORT Make_other_info(SALT311.StrType s0) := s0;
EXPORT InValid_other_info(SALT311.StrType s) := 0;
EXPORT InValidMessage_other_info(UNSIGNED1 wh) := '';
 
EXPORT Make_address_contact_type(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_address_contact_type(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_address_contact_type(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_feedback_source(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_feedback_source(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_feedback_source(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_date_time_added(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_date_time_added(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_date_time_added(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_loginid(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_loginid(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_loginid(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_companyid(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_companyid(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_companyid(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT311,Scrubs_AddressFeedback;
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
    BOOLEAN Diff_raw_aid;
    BOOLEAN Diff_hhid;
    BOOLEAN Diff_address_feedback_id;
    BOOLEAN Diff_login_history_id;
    BOOLEAN Diff_phone_number;
    BOOLEAN Diff_unique_id;
    BOOLEAN Diff_fname;
    BOOLEAN Diff_lname;
    BOOLEAN Diff_mname;
    BOOLEAN Diff_orig_street_pre_direction;
    BOOLEAN Diff_orig_street_post_direction;
    BOOLEAN Diff_orig_street_number;
    BOOLEAN Diff_orig_street_name;
    BOOLEAN Diff_orig_street_suffix;
    BOOLEAN Diff_orig_unit_number;
    BOOLEAN Diff_orig_unit_designation;
    BOOLEAN Diff_orig_zip5;
    BOOLEAN Diff_orig_zip4;
    BOOLEAN Diff_orig_city;
    BOOLEAN Diff_orig_state;
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
    BOOLEAN Diff_address_contact_type;
    BOOLEAN Diff_feedback_source;
    BOOLEAN Diff_date_time_added;
    BOOLEAN Diff_loginid;
    BOOLEAN Diff_companyid;
    UNSIGNED Num_Diffs;
    SALT311.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_did := le.did <> ri.did;
    SELF.Diff_did_score := le.did_score <> ri.did_score;
    SELF.Diff_raw_aid := le.raw_aid <> ri.raw_aid;
    SELF.Diff_hhid := le.hhid <> ri.hhid;
    SELF.Diff_address_feedback_id := le.address_feedback_id <> ri.address_feedback_id;
    SELF.Diff_login_history_id := le.login_history_id <> ri.login_history_id;
    SELF.Diff_phone_number := le.phone_number <> ri.phone_number;
    SELF.Diff_unique_id := le.unique_id <> ri.unique_id;
    SELF.Diff_fname := le.fname <> ri.fname;
    SELF.Diff_lname := le.lname <> ri.lname;
    SELF.Diff_mname := le.mname <> ri.mname;
    SELF.Diff_orig_street_pre_direction := le.orig_street_pre_direction <> ri.orig_street_pre_direction;
    SELF.Diff_orig_street_post_direction := le.orig_street_post_direction <> ri.orig_street_post_direction;
    SELF.Diff_orig_street_number := le.orig_street_number <> ri.orig_street_number;
    SELF.Diff_orig_street_name := le.orig_street_name <> ri.orig_street_name;
    SELF.Diff_orig_street_suffix := le.orig_street_suffix <> ri.orig_street_suffix;
    SELF.Diff_orig_unit_number := le.orig_unit_number <> ri.orig_unit_number;
    SELF.Diff_orig_unit_designation := le.orig_unit_designation <> ri.orig_unit_designation;
    SELF.Diff_orig_zip5 := le.orig_zip5 <> ri.orig_zip5;
    SELF.Diff_orig_zip4 := le.orig_zip4 <> ri.orig_zip4;
    SELF.Diff_orig_city := le.orig_city <> ri.orig_city;
    SELF.Diff_orig_state := le.orig_state <> ri.orig_state;
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
    SELF.Diff_address_contact_type := le.address_contact_type <> ri.address_contact_type;
    SELF.Diff_feedback_source := le.feedback_source <> ri.feedback_source;
    SELF.Diff_date_time_added := le.date_time_added <> ri.date_time_added;
    SELF.Diff_loginid := le.loginid <> ri.loginid;
    SELF.Diff_companyid := le.companyid <> ri.companyid;
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_did,1,0)+ IF( SELF.Diff_did_score,1,0)+ IF( SELF.Diff_raw_aid,1,0)+ IF( SELF.Diff_hhid,1,0)+ IF( SELF.Diff_address_feedback_id,1,0)+ IF( SELF.Diff_login_history_id,1,0)+ IF( SELF.Diff_phone_number,1,0)+ IF( SELF.Diff_unique_id,1,0)+ IF( SELF.Diff_fname,1,0)+ IF( SELF.Diff_lname,1,0)+ IF( SELF.Diff_mname,1,0)+ IF( SELF.Diff_orig_street_pre_direction,1,0)+ IF( SELF.Diff_orig_street_post_direction,1,0)+ IF( SELF.Diff_orig_street_number,1,0)+ IF( SELF.Diff_orig_street_name,1,0)+ IF( SELF.Diff_orig_street_suffix,1,0)+ IF( SELF.Diff_orig_unit_number,1,0)+ IF( SELF.Diff_orig_unit_designation,1,0)+ IF( SELF.Diff_orig_zip5,1,0)+ IF( SELF.Diff_orig_zip4,1,0)+ IF( SELF.Diff_orig_city,1,0)+ IF( SELF.Diff_orig_state,1,0)+ IF( SELF.Diff_street_pre_direction,1,0)+ IF( SELF.Diff_street_post_direction,1,0)+ IF( SELF.Diff_street_number,1,0)+ IF( SELF.Diff_street_name,1,0)+ IF( SELF.Diff_street_suffix,1,0)+ IF( SELF.Diff_unit_number,1,0)+ IF( SELF.Diff_unit_designation,1,0)+ IF( SELF.Diff_zip5,1,0)+ IF( SELF.Diff_zip4,1,0)+ IF( SELF.Diff_city,1,0)+ IF( SELF.Diff_state,1,0)+ IF( SELF.Diff_alt_phone,1,0)+ IF( SELF.Diff_other_info,1,0)+ IF( SELF.Diff_address_contact_type,1,0)+ IF( SELF.Diff_feedback_source,1,0)+ IF( SELF.Diff_date_time_added,1,0)+ IF( SELF.Diff_loginid,1,0)+ IF( SELF.Diff_companyid,1,0);
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
    Count_Diff_raw_aid := COUNT(GROUP,%Closest%.Diff_raw_aid);
    Count_Diff_hhid := COUNT(GROUP,%Closest%.Diff_hhid);
    Count_Diff_address_feedback_id := COUNT(GROUP,%Closest%.Diff_address_feedback_id);
    Count_Diff_login_history_id := COUNT(GROUP,%Closest%.Diff_login_history_id);
    Count_Diff_phone_number := COUNT(GROUP,%Closest%.Diff_phone_number);
    Count_Diff_unique_id := COUNT(GROUP,%Closest%.Diff_unique_id);
    Count_Diff_fname := COUNT(GROUP,%Closest%.Diff_fname);
    Count_Diff_lname := COUNT(GROUP,%Closest%.Diff_lname);
    Count_Diff_mname := COUNT(GROUP,%Closest%.Diff_mname);
    Count_Diff_orig_street_pre_direction := COUNT(GROUP,%Closest%.Diff_orig_street_pre_direction);
    Count_Diff_orig_street_post_direction := COUNT(GROUP,%Closest%.Diff_orig_street_post_direction);
    Count_Diff_orig_street_number := COUNT(GROUP,%Closest%.Diff_orig_street_number);
    Count_Diff_orig_street_name := COUNT(GROUP,%Closest%.Diff_orig_street_name);
    Count_Diff_orig_street_suffix := COUNT(GROUP,%Closest%.Diff_orig_street_suffix);
    Count_Diff_orig_unit_number := COUNT(GROUP,%Closest%.Diff_orig_unit_number);
    Count_Diff_orig_unit_designation := COUNT(GROUP,%Closest%.Diff_orig_unit_designation);
    Count_Diff_orig_zip5 := COUNT(GROUP,%Closest%.Diff_orig_zip5);
    Count_Diff_orig_zip4 := COUNT(GROUP,%Closest%.Diff_orig_zip4);
    Count_Diff_orig_city := COUNT(GROUP,%Closest%.Diff_orig_city);
    Count_Diff_orig_state := COUNT(GROUP,%Closest%.Diff_orig_state);
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
    Count_Diff_address_contact_type := COUNT(GROUP,%Closest%.Diff_address_contact_type);
    Count_Diff_feedback_source := COUNT(GROUP,%Closest%.Diff_feedback_source);
    Count_Diff_date_time_added := COUNT(GROUP,%Closest%.Diff_date_time_added);
    Count_Diff_loginid := COUNT(GROUP,%Closest%.Diff_loginid);
    Count_Diff_companyid := COUNT(GROUP,%Closest%.Diff_companyid);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
