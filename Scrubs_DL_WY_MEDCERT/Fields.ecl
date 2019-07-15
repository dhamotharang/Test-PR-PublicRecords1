IMPORT SALT38;
IMPORT Scrubs_DL_WY_MEDCERT; // Import modules for FieldTypes attribute definitions
EXPORT Fields := MODULE
 
EXPORT NumFields := 34;
 
// Processing for each FieldType
EXPORT SALT38.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_Past_Date','invalid_General_Date','invalid_orig_name','invalid_numeric','invalid_mandatory','invalid_state','invalid_zip5','invalid_orig_code','invalid_med_cert_status','invalid_med_cert_type','invalid_clean_name');
EXPORT FieldTypeNum(SALT38.StrType fn) := CASE(fn,'invalid_Past_Date' => 1,'invalid_General_Date' => 2,'invalid_orig_name' => 3,'invalid_numeric' => 4,'invalid_mandatory' => 5,'invalid_state' => 6,'invalid_zip5' => 7,'invalid_orig_code' => 8,'invalid_med_cert_status' => 9,'invalid_med_cert_type' => 10,'invalid_clean_name' => 11,0);
 
EXPORT MakeFT_invalid_Past_Date(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_Past_Date(SALT38.StrType s) := WHICH(~Scrubs_DL_WY_MEDCERT.Functions.fn_valid_past_date(s)>0);
EXPORT InValidMessageFT_invalid_Past_Date(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_DL_WY_MEDCERT.Functions.fn_valid_past_date'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_General_Date(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_General_Date(SALT38.StrType s) := WHICH(~Scrubs_DL_WY_MEDCERT.Functions.fn_valid_general_Date(s)>0);
EXPORT InValidMessageFT_invalid_General_Date(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_DL_WY_MEDCERT.Functions.fn_valid_general_Date'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_orig_name(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_orig_name(SALT38.StrType s,SALT38.StrType orig_middle_name,SALT38.StrType orig_last_name) := WHICH(~Scrubs_DL_WY_MEDCERT.functions.fn_chk_people_names(s,orig_middle_name,orig_last_name)>0);
EXPORT InValidMessageFT_invalid_orig_name(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_DL_WY_MEDCERT.functions.fn_chk_people_names'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_numeric(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_numeric(SALT38.StrType s) := WHICH(~Scrubs_DL_WY_MEDCERT.functions.fn_numeric(s)>0);
EXPORT InValidMessageFT_invalid_numeric(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_DL_WY_MEDCERT.functions.fn_numeric'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_mandatory(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_mandatory(SALT38.StrType s) := WHICH(~Scrubs_DL_WY_MEDCERT.Functions.fn_chk_blanks(s)>0);
EXPORT InValidMessageFT_invalid_mandatory(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_DL_WY_MEDCERT.Functions.fn_chk_blanks'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_state(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_state(SALT38.StrType s) := WHICH(~Scrubs_DL_WY_MEDCERT.Functions.fn_verify_state(s)>0);
EXPORT InValidMessageFT_invalid_state(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_DL_WY_MEDCERT.Functions.fn_verify_state'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_zip5(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_zip5(SALT38.StrType s) := WHICH(~Scrubs_DL_WY_MEDCERT.Functions.fn_verify_zip5(s)>0);
EXPORT InValidMessageFT_invalid_zip5(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_DL_WY_MEDCERT.Functions.fn_verify_zip5'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_orig_code(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'1|2|-|A|B|C|H|I|M|N|P|R|S|T|X|Z|'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_orig_code(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'1|2|-|A|B|C|H|I|M|N|P|R|S|T|X|Z|'))));
EXPORT InValidMessageFT_invalid_orig_code(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('1|2|-|A|B|C|H|I|M|N|P|R|S|T|X|Z|'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_med_cert_status(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'C|E|N|'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_med_cert_status(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'C|E|N|'))));
EXPORT InValidMessageFT_invalid_med_cert_status(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('C|E|N|'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_med_cert_type(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'A|I|N|'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_med_cert_type(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'A|I|N|'))));
EXPORT InValidMessageFT_invalid_med_cert_type(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('A|I|N|'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_clean_name(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_clean_name(SALT38.StrType s,SALT38.StrType clean_name_middle,SALT38.StrType clean_name_last) := WHICH(~Scrubs_DL_WY_MEDCERT.functions.fn_chk_people_names(s,clean_name_middle,clean_name_last)>0);
EXPORT InValidMessageFT_invalid_clean_name(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_DL_WY_MEDCERT.functions.fn_chk_people_names'),SALT38.HygieneErrors.Good);
 
EXPORT SALT38.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'append_process_date','orig_first_name','orig_middle_name','orig_last_name','mailing_street_addr_1','mailing_city_1','mailing_state_1','mailing_zip_code_1','phys_street_addr_2','phys_city_2','phys_state_2','phys_zip_code_2','orig_dl_number','orig_dob','orig_code_1','orig_code_2','orig_code_3','orig_code_4','orig_code_5','orig_code_6','orig_code_7','orig_code_8','orig_issue_date','orig_expire_date','med_cert_status','med_cert_type','med_cert_expire_date','name_suffix','clean_name_prefix','clean_name_first','clean_name_middle','clean_name_last','clean_name_suffix','clean_name_score');
EXPORT SALT38.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'append_process_date','orig_first_name','orig_middle_name','orig_last_name','mailing_street_addr_1','mailing_city_1','mailing_state_1','mailing_zip_code_1','phys_street_addr_2','phys_city_2','phys_state_2','phys_zip_code_2','orig_dl_number','orig_dob','orig_code_1','orig_code_2','orig_code_3','orig_code_4','orig_code_5','orig_code_6','orig_code_7','orig_code_8','orig_issue_date','orig_expire_date','med_cert_status','med_cert_type','med_cert_expire_date','name_suffix','clean_name_prefix','clean_name_first','clean_name_middle','clean_name_last','clean_name_suffix','clean_name_score');
EXPORT FieldNum(SALT38.StrType fn) := CASE(fn,'append_process_date' => 0,'orig_first_name' => 1,'orig_middle_name' => 2,'orig_last_name' => 3,'mailing_street_addr_1' => 4,'mailing_city_1' => 5,'mailing_state_1' => 6,'mailing_zip_code_1' => 7,'phys_street_addr_2' => 8,'phys_city_2' => 9,'phys_state_2' => 10,'phys_zip_code_2' => 11,'orig_dl_number' => 12,'orig_dob' => 13,'orig_code_1' => 14,'orig_code_2' => 15,'orig_code_3' => 16,'orig_code_4' => 17,'orig_code_5' => 18,'orig_code_6' => 19,'orig_code_7' => 20,'orig_code_8' => 21,'orig_issue_date' => 22,'orig_expire_date' => 23,'med_cert_status' => 24,'med_cert_type' => 25,'med_cert_expire_date' => 26,'name_suffix' => 27,'clean_name_prefix' => 28,'clean_name_first' => 29,'clean_name_middle' => 30,'clean_name_last' => 31,'clean_name_suffix' => 32,'clean_name_score' => 33,0);
EXPORT SET OF SALT38.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['CUSTOM'],['CUSTOM'],[],[],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['CUSTOM'],['CUSTOM'],['ALLOW'],['ALLOW'],['CUSTOM'],[],[],['CUSTOM'],[],[],[],[],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_append_process_date(SALT38.StrType s0) := MakeFT_invalid_Past_Date(s0);
EXPORT InValid_append_process_date(SALT38.StrType s) := InValidFT_invalid_Past_Date(s);
EXPORT InValidMessage_append_process_date(UNSIGNED1 wh) := InValidMessageFT_invalid_Past_Date(wh);
 
EXPORT Make_orig_first_name(SALT38.StrType s0) := MakeFT_invalid_orig_name(s0);
EXPORT InValid_orig_first_name(SALT38.StrType s,SALT38.StrType orig_middle_name,SALT38.StrType orig_last_name) := InValidFT_invalid_orig_name(s,orig_middle_name,orig_last_name);
EXPORT InValidMessage_orig_first_name(UNSIGNED1 wh) := InValidMessageFT_invalid_orig_name(wh);
 
EXPORT Make_orig_middle_name(SALT38.StrType s0) := s0;
EXPORT InValid_orig_middle_name(SALT38.StrType s) := 0;
EXPORT InValidMessage_orig_middle_name(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_last_name(SALT38.StrType s0) := s0;
EXPORT InValid_orig_last_name(SALT38.StrType s) := 0;
EXPORT InValidMessage_orig_last_name(UNSIGNED1 wh) := '';
 
EXPORT Make_mailing_street_addr_1(SALT38.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_mailing_street_addr_1(SALT38.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_mailing_street_addr_1(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_mailing_city_1(SALT38.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_mailing_city_1(SALT38.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_mailing_city_1(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_mailing_state_1(SALT38.StrType s0) := MakeFT_invalid_state(s0);
EXPORT InValid_mailing_state_1(SALT38.StrType s) := InValidFT_invalid_state(s);
EXPORT InValidMessage_mailing_state_1(UNSIGNED1 wh) := InValidMessageFT_invalid_state(wh);
 
EXPORT Make_mailing_zip_code_1(SALT38.StrType s0) := MakeFT_invalid_zip5(s0);
EXPORT InValid_mailing_zip_code_1(SALT38.StrType s) := InValidFT_invalid_zip5(s);
EXPORT InValidMessage_mailing_zip_code_1(UNSIGNED1 wh) := InValidMessageFT_invalid_zip5(wh);
 
EXPORT Make_phys_street_addr_2(SALT38.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_phys_street_addr_2(SALT38.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_phys_street_addr_2(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_phys_city_2(SALT38.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_phys_city_2(SALT38.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_phys_city_2(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_phys_state_2(SALT38.StrType s0) := MakeFT_invalid_state(s0);
EXPORT InValid_phys_state_2(SALT38.StrType s) := InValidFT_invalid_state(s);
EXPORT InValidMessage_phys_state_2(UNSIGNED1 wh) := InValidMessageFT_invalid_state(wh);
 
EXPORT Make_phys_zip_code_2(SALT38.StrType s0) := MakeFT_invalid_zip5(s0);
EXPORT InValid_phys_zip_code_2(SALT38.StrType s) := InValidFT_invalid_zip5(s);
EXPORT InValidMessage_phys_zip_code_2(UNSIGNED1 wh) := InValidMessageFT_invalid_zip5(wh);
 
EXPORT Make_orig_dl_number(SALT38.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_orig_dl_number(SALT38.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_orig_dl_number(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_orig_dob(SALT38.StrType s0) := MakeFT_invalid_Past_Date(s0);
EXPORT InValid_orig_dob(SALT38.StrType s) := InValidFT_invalid_Past_Date(s);
EXPORT InValidMessage_orig_dob(UNSIGNED1 wh) := InValidMessageFT_invalid_Past_Date(wh);
 
EXPORT Make_orig_code_1(SALT38.StrType s0) := MakeFT_invalid_orig_code(s0);
EXPORT InValid_orig_code_1(SALT38.StrType s) := InValidFT_invalid_orig_code(s);
EXPORT InValidMessage_orig_code_1(UNSIGNED1 wh) := InValidMessageFT_invalid_orig_code(wh);
 
EXPORT Make_orig_code_2(SALT38.StrType s0) := MakeFT_invalid_orig_code(s0);
EXPORT InValid_orig_code_2(SALT38.StrType s) := InValidFT_invalid_orig_code(s);
EXPORT InValidMessage_orig_code_2(UNSIGNED1 wh) := InValidMessageFT_invalid_orig_code(wh);
 
EXPORT Make_orig_code_3(SALT38.StrType s0) := MakeFT_invalid_orig_code(s0);
EXPORT InValid_orig_code_3(SALT38.StrType s) := InValidFT_invalid_orig_code(s);
EXPORT InValidMessage_orig_code_3(UNSIGNED1 wh) := InValidMessageFT_invalid_orig_code(wh);
 
EXPORT Make_orig_code_4(SALT38.StrType s0) := MakeFT_invalid_orig_code(s0);
EXPORT InValid_orig_code_4(SALT38.StrType s) := InValidFT_invalid_orig_code(s);
EXPORT InValidMessage_orig_code_4(UNSIGNED1 wh) := InValidMessageFT_invalid_orig_code(wh);
 
EXPORT Make_orig_code_5(SALT38.StrType s0) := MakeFT_invalid_orig_code(s0);
EXPORT InValid_orig_code_5(SALT38.StrType s) := InValidFT_invalid_orig_code(s);
EXPORT InValidMessage_orig_code_5(UNSIGNED1 wh) := InValidMessageFT_invalid_orig_code(wh);
 
EXPORT Make_orig_code_6(SALT38.StrType s0) := MakeFT_invalid_orig_code(s0);
EXPORT InValid_orig_code_6(SALT38.StrType s) := InValidFT_invalid_orig_code(s);
EXPORT InValidMessage_orig_code_6(UNSIGNED1 wh) := InValidMessageFT_invalid_orig_code(wh);
 
EXPORT Make_orig_code_7(SALT38.StrType s0) := MakeFT_invalid_orig_code(s0);
EXPORT InValid_orig_code_7(SALT38.StrType s) := InValidFT_invalid_orig_code(s);
EXPORT InValidMessage_orig_code_7(UNSIGNED1 wh) := InValidMessageFT_invalid_orig_code(wh);
 
EXPORT Make_orig_code_8(SALT38.StrType s0) := MakeFT_invalid_orig_code(s0);
EXPORT InValid_orig_code_8(SALT38.StrType s) := InValidFT_invalid_orig_code(s);
EXPORT InValidMessage_orig_code_8(UNSIGNED1 wh) := InValidMessageFT_invalid_orig_code(wh);
 
EXPORT Make_orig_issue_date(SALT38.StrType s0) := MakeFT_invalid_Past_Date(s0);
EXPORT InValid_orig_issue_date(SALT38.StrType s) := InValidFT_invalid_Past_Date(s);
EXPORT InValidMessage_orig_issue_date(UNSIGNED1 wh) := InValidMessageFT_invalid_Past_Date(wh);
 
EXPORT Make_orig_expire_date(SALT38.StrType s0) := MakeFT_invalid_General_Date(s0);
EXPORT InValid_orig_expire_date(SALT38.StrType s) := InValidFT_invalid_General_Date(s);
EXPORT InValidMessage_orig_expire_date(UNSIGNED1 wh) := InValidMessageFT_invalid_General_Date(wh);
 
EXPORT Make_med_cert_status(SALT38.StrType s0) := MakeFT_invalid_med_cert_status(s0);
EXPORT InValid_med_cert_status(SALT38.StrType s) := InValidFT_invalid_med_cert_status(s);
EXPORT InValidMessage_med_cert_status(UNSIGNED1 wh) := InValidMessageFT_invalid_med_cert_status(wh);
 
EXPORT Make_med_cert_type(SALT38.StrType s0) := MakeFT_invalid_med_cert_type(s0);
EXPORT InValid_med_cert_type(SALT38.StrType s) := InValidFT_invalid_med_cert_type(s);
EXPORT InValidMessage_med_cert_type(UNSIGNED1 wh) := InValidMessageFT_invalid_med_cert_type(wh);
 
EXPORT Make_med_cert_expire_date(SALT38.StrType s0) := MakeFT_invalid_General_Date(s0);
EXPORT InValid_med_cert_expire_date(SALT38.StrType s) := InValidFT_invalid_General_Date(s);
EXPORT InValidMessage_med_cert_expire_date(UNSIGNED1 wh) := InValidMessageFT_invalid_General_Date(wh);
 
EXPORT Make_name_suffix(SALT38.StrType s0) := s0;
EXPORT InValid_name_suffix(SALT38.StrType s) := 0;
EXPORT InValidMessage_name_suffix(UNSIGNED1 wh) := '';
 
EXPORT Make_clean_name_prefix(SALT38.StrType s0) := s0;
EXPORT InValid_clean_name_prefix(SALT38.StrType s) := 0;
EXPORT InValidMessage_clean_name_prefix(UNSIGNED1 wh) := '';
 
EXPORT Make_clean_name_first(SALT38.StrType s0) := MakeFT_invalid_clean_name(s0);
EXPORT InValid_clean_name_first(SALT38.StrType s,SALT38.StrType clean_name_middle,SALT38.StrType clean_name_last) := InValidFT_invalid_clean_name(s,clean_name_middle,clean_name_last);
EXPORT InValidMessage_clean_name_first(UNSIGNED1 wh) := InValidMessageFT_invalid_clean_name(wh);
 
EXPORT Make_clean_name_middle(SALT38.StrType s0) := s0;
EXPORT InValid_clean_name_middle(SALT38.StrType s) := 0;
EXPORT InValidMessage_clean_name_middle(UNSIGNED1 wh) := '';
 
EXPORT Make_clean_name_last(SALT38.StrType s0) := s0;
EXPORT InValid_clean_name_last(SALT38.StrType s) := 0;
EXPORT InValidMessage_clean_name_last(UNSIGNED1 wh) := '';
 
EXPORT Make_clean_name_suffix(SALT38.StrType s0) := s0;
EXPORT InValid_clean_name_suffix(SALT38.StrType s) := 0;
EXPORT InValidMessage_clean_name_suffix(UNSIGNED1 wh) := '';
 
EXPORT Make_clean_name_score(SALT38.StrType s0) := s0;
EXPORT InValid_clean_name_score(SALT38.StrType s) := 0;
EXPORT InValidMessage_clean_name_score(UNSIGNED1 wh) := '';
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT38,Scrubs_DL_WY_MEDCERT;
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
    BOOLEAN Diff_append_process_date;
    BOOLEAN Diff_orig_first_name;
    BOOLEAN Diff_orig_middle_name;
    BOOLEAN Diff_orig_last_name;
    BOOLEAN Diff_mailing_street_addr_1;
    BOOLEAN Diff_mailing_city_1;
    BOOLEAN Diff_mailing_state_1;
    BOOLEAN Diff_mailing_zip_code_1;
    BOOLEAN Diff_phys_street_addr_2;
    BOOLEAN Diff_phys_city_2;
    BOOLEAN Diff_phys_state_2;
    BOOLEAN Diff_phys_zip_code_2;
    BOOLEAN Diff_orig_dl_number;
    BOOLEAN Diff_orig_dob;
    BOOLEAN Diff_orig_code_1;
    BOOLEAN Diff_orig_code_2;
    BOOLEAN Diff_orig_code_3;
    BOOLEAN Diff_orig_code_4;
    BOOLEAN Diff_orig_code_5;
    BOOLEAN Diff_orig_code_6;
    BOOLEAN Diff_orig_code_7;
    BOOLEAN Diff_orig_code_8;
    BOOLEAN Diff_orig_issue_date;
    BOOLEAN Diff_orig_expire_date;
    BOOLEAN Diff_med_cert_status;
    BOOLEAN Diff_med_cert_type;
    BOOLEAN Diff_med_cert_expire_date;
    BOOLEAN Diff_name_suffix;
    BOOLEAN Diff_clean_name_prefix;
    BOOLEAN Diff_clean_name_first;
    BOOLEAN Diff_clean_name_middle;
    BOOLEAN Diff_clean_name_last;
    BOOLEAN Diff_clean_name_suffix;
    BOOLEAN Diff_clean_name_score;
    UNSIGNED Num_Diffs;
    SALT38.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_append_process_date := le.append_process_date <> ri.append_process_date;
    SELF.Diff_orig_first_name := le.orig_first_name <> ri.orig_first_name;
    SELF.Diff_orig_middle_name := le.orig_middle_name <> ri.orig_middle_name;
    SELF.Diff_orig_last_name := le.orig_last_name <> ri.orig_last_name;
    SELF.Diff_mailing_street_addr_1 := le.mailing_street_addr_1 <> ri.mailing_street_addr_1;
    SELF.Diff_mailing_city_1 := le.mailing_city_1 <> ri.mailing_city_1;
    SELF.Diff_mailing_state_1 := le.mailing_state_1 <> ri.mailing_state_1;
    SELF.Diff_mailing_zip_code_1 := le.mailing_zip_code_1 <> ri.mailing_zip_code_1;
    SELF.Diff_phys_street_addr_2 := le.phys_street_addr_2 <> ri.phys_street_addr_2;
    SELF.Diff_phys_city_2 := le.phys_city_2 <> ri.phys_city_2;
    SELF.Diff_phys_state_2 := le.phys_state_2 <> ri.phys_state_2;
    SELF.Diff_phys_zip_code_2 := le.phys_zip_code_2 <> ri.phys_zip_code_2;
    SELF.Diff_orig_dl_number := le.orig_dl_number <> ri.orig_dl_number;
    SELF.Diff_orig_dob := le.orig_dob <> ri.orig_dob;
    SELF.Diff_orig_code_1 := le.orig_code_1 <> ri.orig_code_1;
    SELF.Diff_orig_code_2 := le.orig_code_2 <> ri.orig_code_2;
    SELF.Diff_orig_code_3 := le.orig_code_3 <> ri.orig_code_3;
    SELF.Diff_orig_code_4 := le.orig_code_4 <> ri.orig_code_4;
    SELF.Diff_orig_code_5 := le.orig_code_5 <> ri.orig_code_5;
    SELF.Diff_orig_code_6 := le.orig_code_6 <> ri.orig_code_6;
    SELF.Diff_orig_code_7 := le.orig_code_7 <> ri.orig_code_7;
    SELF.Diff_orig_code_8 := le.orig_code_8 <> ri.orig_code_8;
    SELF.Diff_orig_issue_date := le.orig_issue_date <> ri.orig_issue_date;
    SELF.Diff_orig_expire_date := le.orig_expire_date <> ri.orig_expire_date;
    SELF.Diff_med_cert_status := le.med_cert_status <> ri.med_cert_status;
    SELF.Diff_med_cert_type := le.med_cert_type <> ri.med_cert_type;
    SELF.Diff_med_cert_expire_date := le.med_cert_expire_date <> ri.med_cert_expire_date;
    SELF.Diff_name_suffix := le.name_suffix <> ri.name_suffix;
    SELF.Diff_clean_name_prefix := le.clean_name_prefix <> ri.clean_name_prefix;
    SELF.Diff_clean_name_first := le.clean_name_first <> ri.clean_name_first;
    SELF.Diff_clean_name_middle := le.clean_name_middle <> ri.clean_name_middle;
    SELF.Diff_clean_name_last := le.clean_name_last <> ri.clean_name_last;
    SELF.Diff_clean_name_suffix := le.clean_name_suffix <> ri.clean_name_suffix;
    SELF.Diff_clean_name_score := le.clean_name_score <> ri.clean_name_score;
    SELF.Val := (SALT38.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_append_process_date,1,0)+ IF( SELF.Diff_orig_first_name,1,0)+ IF( SELF.Diff_orig_middle_name,1,0)+ IF( SELF.Diff_orig_last_name,1,0)+ IF( SELF.Diff_mailing_street_addr_1,1,0)+ IF( SELF.Diff_mailing_city_1,1,0)+ IF( SELF.Diff_mailing_state_1,1,0)+ IF( SELF.Diff_mailing_zip_code_1,1,0)+ IF( SELF.Diff_phys_street_addr_2,1,0)+ IF( SELF.Diff_phys_city_2,1,0)+ IF( SELF.Diff_phys_state_2,1,0)+ IF( SELF.Diff_phys_zip_code_2,1,0)+ IF( SELF.Diff_orig_dl_number,1,0)+ IF( SELF.Diff_orig_dob,1,0)+ IF( SELF.Diff_orig_code_1,1,0)+ IF( SELF.Diff_orig_code_2,1,0)+ IF( SELF.Diff_orig_code_3,1,0)+ IF( SELF.Diff_orig_code_4,1,0)+ IF( SELF.Diff_orig_code_5,1,0)+ IF( SELF.Diff_orig_code_6,1,0)+ IF( SELF.Diff_orig_code_7,1,0)+ IF( SELF.Diff_orig_code_8,1,0)+ IF( SELF.Diff_orig_issue_date,1,0)+ IF( SELF.Diff_orig_expire_date,1,0)+ IF( SELF.Diff_med_cert_status,1,0)+ IF( SELF.Diff_med_cert_type,1,0)+ IF( SELF.Diff_med_cert_expire_date,1,0)+ IF( SELF.Diff_name_suffix,1,0)+ IF( SELF.Diff_clean_name_prefix,1,0)+ IF( SELF.Diff_clean_name_first,1,0)+ IF( SELF.Diff_clean_name_middle,1,0)+ IF( SELF.Diff_clean_name_last,1,0)+ IF( SELF.Diff_clean_name_suffix,1,0)+ IF( SELF.Diff_clean_name_score,1,0);
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
    Count_Diff_append_process_date := COUNT(GROUP,%Closest%.Diff_append_process_date);
    Count_Diff_orig_first_name := COUNT(GROUP,%Closest%.Diff_orig_first_name);
    Count_Diff_orig_middle_name := COUNT(GROUP,%Closest%.Diff_orig_middle_name);
    Count_Diff_orig_last_name := COUNT(GROUP,%Closest%.Diff_orig_last_name);
    Count_Diff_mailing_street_addr_1 := COUNT(GROUP,%Closest%.Diff_mailing_street_addr_1);
    Count_Diff_mailing_city_1 := COUNT(GROUP,%Closest%.Diff_mailing_city_1);
    Count_Diff_mailing_state_1 := COUNT(GROUP,%Closest%.Diff_mailing_state_1);
    Count_Diff_mailing_zip_code_1 := COUNT(GROUP,%Closest%.Diff_mailing_zip_code_1);
    Count_Diff_phys_street_addr_2 := COUNT(GROUP,%Closest%.Diff_phys_street_addr_2);
    Count_Diff_phys_city_2 := COUNT(GROUP,%Closest%.Diff_phys_city_2);
    Count_Diff_phys_state_2 := COUNT(GROUP,%Closest%.Diff_phys_state_2);
    Count_Diff_phys_zip_code_2 := COUNT(GROUP,%Closest%.Diff_phys_zip_code_2);
    Count_Diff_orig_dl_number := COUNT(GROUP,%Closest%.Diff_orig_dl_number);
    Count_Diff_orig_dob := COUNT(GROUP,%Closest%.Diff_orig_dob);
    Count_Diff_orig_code_1 := COUNT(GROUP,%Closest%.Diff_orig_code_1);
    Count_Diff_orig_code_2 := COUNT(GROUP,%Closest%.Diff_orig_code_2);
    Count_Diff_orig_code_3 := COUNT(GROUP,%Closest%.Diff_orig_code_3);
    Count_Diff_orig_code_4 := COUNT(GROUP,%Closest%.Diff_orig_code_4);
    Count_Diff_orig_code_5 := COUNT(GROUP,%Closest%.Diff_orig_code_5);
    Count_Diff_orig_code_6 := COUNT(GROUP,%Closest%.Diff_orig_code_6);
    Count_Diff_orig_code_7 := COUNT(GROUP,%Closest%.Diff_orig_code_7);
    Count_Diff_orig_code_8 := COUNT(GROUP,%Closest%.Diff_orig_code_8);
    Count_Diff_orig_issue_date := COUNT(GROUP,%Closest%.Diff_orig_issue_date);
    Count_Diff_orig_expire_date := COUNT(GROUP,%Closest%.Diff_orig_expire_date);
    Count_Diff_med_cert_status := COUNT(GROUP,%Closest%.Diff_med_cert_status);
    Count_Diff_med_cert_type := COUNT(GROUP,%Closest%.Diff_med_cert_type);
    Count_Diff_med_cert_expire_date := COUNT(GROUP,%Closest%.Diff_med_cert_expire_date);
    Count_Diff_name_suffix := COUNT(GROUP,%Closest%.Diff_name_suffix);
    Count_Diff_clean_name_prefix := COUNT(GROUP,%Closest%.Diff_clean_name_prefix);
    Count_Diff_clean_name_first := COUNT(GROUP,%Closest%.Diff_clean_name_first);
    Count_Diff_clean_name_middle := COUNT(GROUP,%Closest%.Diff_clean_name_middle);
    Count_Diff_clean_name_last := COUNT(GROUP,%Closest%.Diff_clean_name_last);
    Count_Diff_clean_name_suffix := COUNT(GROUP,%Closest%.Diff_clean_name_suffix);
    Count_Diff_clean_name_score := COUNT(GROUP,%Closest%.Diff_clean_name_score);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
