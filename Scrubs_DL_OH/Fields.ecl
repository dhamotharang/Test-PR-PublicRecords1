IMPORT SALT311;
IMPORT Scrubs,Scrubs_DL_OH; // Import modules for FieldTypes attribute definitions
EXPORT Fields := MODULE
 
EXPORT NumFields := 28;
 
// Processing for each FieldType
EXPORT SALT311.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_8pastdate','invalid_numeric','invalid_dl_number_check','invalid_license_class','invalid_donor_flag','invalid_hair_color','invalid_eye_color','invalid_wgt','invalid_height','invalid_gender','invalid_endorsements','invalid_restrictions','invalid_alpha_num_bnk','invalid_8generaldate','invalid_name','invalid_city','invalid_street','invalid_state','invalid_zip','invalid_clean_name');
EXPORT FieldTypeNum(SALT311.StrType fn) := CASE(fn,'invalid_8pastdate' => 1,'invalid_numeric' => 2,'invalid_dl_number_check' => 3,'invalid_license_class' => 4,'invalid_donor_flag' => 5,'invalid_hair_color' => 6,'invalid_eye_color' => 7,'invalid_wgt' => 8,'invalid_height' => 9,'invalid_gender' => 10,'invalid_endorsements' => 11,'invalid_restrictions' => 12,'invalid_alpha_num_bnk' => 13,'invalid_8generaldate' => 14,'invalid_name' => 15,'invalid_city' => 16,'invalid_street' => 17,'invalid_state' => 18,'invalid_zip' => 19,'invalid_clean_name' => 20,0);
 
EXPORT MakeFT_invalid_8pastdate(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_8pastdate(SALT311.StrType s) := WHICH(~Scrubs.fn_valid_pastDate(s)>0,~(LENGTH(TRIM(s)) = 8));
EXPORT InValidMessageFT_invalid_8pastdate(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.fn_valid_pastDate'),SALT311.HygieneErrors.NotLength('8'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_numeric(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_numeric(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_invalid_numeric(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_dl_number_check(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_dl_number_check(SALT311.StrType s) := WHICH(~Scrubs_DL_OH.Functions.fn_check_dl_number(s)>0);
EXPORT InValidMessageFT_invalid_dl_number_check(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_DL_OH.Functions.fn_check_dl_number'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_license_class(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_license_class(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['A','B','C','D','I','M1','M2','M3','M4','T','']);
EXPORT InValidMessageFT_invalid_license_class(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('A|B|C|D|I|M1|M2|M3|M4|T|'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_donor_flag(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_donor_flag(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['F','U','Y','']);
EXPORT InValidMessageFT_invalid_donor_flag(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('F|U|Y|'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_hair_color(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_hair_color(SALT311.StrType s) := WHICH(~Scrubs_DL_OH.Functions.fn_check_hair_color(s)>0);
EXPORT InValidMessageFT_invalid_hair_color(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_DL_OH.Functions.fn_check_hair_color'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_eye_color(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_eye_color(SALT311.StrType s) := WHICH(~Scrubs_DL_OH.Functions.fn_check_eye_color(s)>0);
EXPORT InValidMessageFT_invalid_eye_color(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_DL_OH.Functions.fn_check_eye_color'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_wgt(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_wgt(SALT311.StrType s) := WHICH(~Scrubs_DL_OH.Functions.fn_verify_weight(s)>0);
EXPORT InValidMessageFT_invalid_wgt(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_DL_OH.Functions.fn_verify_weight'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_height(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_height(SALT311.StrType s,SALT311.StrType height_inches) := WHICH(~Scrubs_DL_OH.Functions.fn_verify_height(s,height_inches)>0);
EXPORT InValidMessageFT_invalid_height(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_DL_OH.Functions.fn_verify_height'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_gender(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_gender(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['F','M','U','']);
EXPORT InValidMessageFT_invalid_gender(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('F|M|U|'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_endorsements(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'23HMNOPQRSTX '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_endorsements(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'23HMNOPQRSTX '))));
EXPORT InValidMessageFT_invalid_endorsements(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('23HMNOPQRSTX '),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_restrictions(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789ABCDEFGHIJKLMNOPVWXZ '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_restrictions(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789ABCDEFGHIJKLMNOPVWXZ '))));
EXPORT InValidMessageFT_invalid_restrictions(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789ABCDEFGHIJKLMNOPVWXZ '),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_alpha_num_bnk(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_alpha_num_bnk(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ '))));
EXPORT InValidMessageFT_invalid_alpha_num_bnk(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_8generaldate(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_8generaldate(SALT311.StrType s) := WHICH(~Scrubs.fn_valid_GeneralDate(s)>0,~(LENGTH(TRIM(s)) = 8));
EXPORT InValidMessageFT_invalid_8generaldate(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.fn_valid_GeneralDate'),SALT311.HygieneErrors.NotLength('8'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_name(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_name(SALT311.StrType s,SALT311.StrType middle_name,SALT311.StrType last_name) := WHICH(~scrubs.functions.fn_populated_strings(s,middle_name,last_name)>0);
EXPORT InValidMessageFT_invalid_name(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('scrubs.functions.fn_populated_strings'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_city(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789/\'@-.,#` '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_city(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789/\'@-.,#` '))));
EXPORT InValidMessageFT_invalid_city(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789/\'@-.,#` '),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_street(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'\\-/#,.\'=%:`&(;)0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_street(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'\\-/#,.\'=%:`&(;)0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ '))));
EXPORT InValidMessageFT_invalid_street(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('\\-/#,.\'=%:`&(;)0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_state(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_state(SALT311.StrType s) := WHICH(~Scrubs_DL_OH.Functions.fn_verify_state(s)>0);
EXPORT InValidMessageFT_invalid_state(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_DL_OH.Functions.fn_verify_state'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_zip(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_zip(SALT311.StrType s) := WHICH(~Scrubs_DL_OH.Functions.fn_verify_zip(s)>0);
EXPORT InValidMessageFT_invalid_zip(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_DL_OH.Functions.fn_verify_zip'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_clean_name(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_clean_name(SALT311.StrType s,SALT311.StrType clean_mname,SALT311.StrType clean_lname) := WHICH(~scrubs.functions.fn_populated_strings(s,clean_mname,clean_lname)>0);
EXPORT InValidMessageFT_invalid_clean_name(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('scrubs.functions.fn_populated_strings'),SALT311.HygieneErrors.Good);
 
EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'process_date','key_number','license_number','license_class','donor_flag','hair_color','eye_color','weight_l','height_feet','height_inches','sex_gender','permanent_license_issue_date','license_expiration_date','restriction_codes','endorsement_codes','first_name','middle_name','last_name','street_address','city','state','zip_code','county_number','birth_date','clean_name_prefix','clean_fname','clean_mname','clean_lname');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'process_date','key_number','license_number','license_class','donor_flag','hair_color','eye_color','weight_l','height_feet','height_inches','sex_gender','permanent_license_issue_date','license_expiration_date','restriction_codes','endorsement_codes','first_name','middle_name','last_name','street_address','city','state','zip_code','county_number','birth_date','clean_name_prefix','clean_fname','clean_mname','clean_lname');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'process_date' => 0,'key_number' => 1,'license_number' => 2,'license_class' => 3,'donor_flag' => 4,'hair_color' => 5,'eye_color' => 6,'weight_l' => 7,'height_feet' => 8,'height_inches' => 9,'sex_gender' => 10,'permanent_license_issue_date' => 11,'license_expiration_date' => 12,'restriction_codes' => 13,'endorsement_codes' => 14,'first_name' => 15,'middle_name' => 16,'last_name' => 17,'street_address' => 18,'city' => 19,'state' => 20,'zip_code' => 21,'county_number' => 22,'birth_date' => 23,'clean_name_prefix' => 24,'clean_fname' => 25,'clean_mname' => 26,'clean_lname' => 27,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['CUSTOM','LENGTHS'],['CUSTOM'],['CUSTOM'],['ENUM'],['ENUM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],[],['ENUM'],['CUSTOM','LENGTHS'],['CUSTOM','LENGTHS'],['ALLOW'],['ALLOW'],['CUSTOM'],[],[],['ALLOW'],['ALLOW'],['CUSTOM'],['CUSTOM'],['ALLOW'],['CUSTOM','LENGTHS'],[],['CUSTOM'],[],[],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_process_date(SALT311.StrType s0) := MakeFT_invalid_8pastdate(s0);
EXPORT InValid_process_date(SALT311.StrType s) := InValidFT_invalid_8pastdate(s);
EXPORT InValidMessage_process_date(UNSIGNED1 wh) := InValidMessageFT_invalid_8pastdate(wh);
 
EXPORT Make_key_number(SALT311.StrType s0) := MakeFT_invalid_dl_number_check(s0);
EXPORT InValid_key_number(SALT311.StrType s) := InValidFT_invalid_dl_number_check(s);
EXPORT InValidMessage_key_number(UNSIGNED1 wh) := InValidMessageFT_invalid_dl_number_check(wh);
 
EXPORT Make_license_number(SALT311.StrType s0) := MakeFT_invalid_dl_number_check(s0);
EXPORT InValid_license_number(SALT311.StrType s) := InValidFT_invalid_dl_number_check(s);
EXPORT InValidMessage_license_number(UNSIGNED1 wh) := InValidMessageFT_invalid_dl_number_check(wh);
 
EXPORT Make_license_class(SALT311.StrType s0) := MakeFT_invalid_license_class(s0);
EXPORT InValid_license_class(SALT311.StrType s) := InValidFT_invalid_license_class(s);
EXPORT InValidMessage_license_class(UNSIGNED1 wh) := InValidMessageFT_invalid_license_class(wh);
 
EXPORT Make_donor_flag(SALT311.StrType s0) := MakeFT_invalid_donor_flag(s0);
EXPORT InValid_donor_flag(SALT311.StrType s) := InValidFT_invalid_donor_flag(s);
EXPORT InValidMessage_donor_flag(UNSIGNED1 wh) := InValidMessageFT_invalid_donor_flag(wh);
 
EXPORT Make_hair_color(SALT311.StrType s0) := MakeFT_invalid_hair_color(s0);
EXPORT InValid_hair_color(SALT311.StrType s) := InValidFT_invalid_hair_color(s);
EXPORT InValidMessage_hair_color(UNSIGNED1 wh) := InValidMessageFT_invalid_hair_color(wh);
 
EXPORT Make_eye_color(SALT311.StrType s0) := MakeFT_invalid_eye_color(s0);
EXPORT InValid_eye_color(SALT311.StrType s) := InValidFT_invalid_eye_color(s);
EXPORT InValidMessage_eye_color(UNSIGNED1 wh) := InValidMessageFT_invalid_eye_color(wh);
 
EXPORT Make_weight_l(SALT311.StrType s0) := MakeFT_invalid_wgt(s0);
EXPORT InValid_weight_l(SALT311.StrType s) := InValidFT_invalid_wgt(s);
EXPORT InValidMessage_weight_l(UNSIGNED1 wh) := InValidMessageFT_invalid_wgt(wh);
 
EXPORT Make_height_feet(SALT311.StrType s0) := MakeFT_invalid_height(s0);
EXPORT InValid_height_feet(SALT311.StrType s,SALT311.StrType height_inches) := InValidFT_invalid_height(s,height_inches);
EXPORT InValidMessage_height_feet(UNSIGNED1 wh) := InValidMessageFT_invalid_height(wh);
 
EXPORT Make_height_inches(SALT311.StrType s0) := s0;
EXPORT InValid_height_inches(SALT311.StrType s) := 0;
EXPORT InValidMessage_height_inches(UNSIGNED1 wh) := '';
 
EXPORT Make_sex_gender(SALT311.StrType s0) := MakeFT_invalid_gender(s0);
EXPORT InValid_sex_gender(SALT311.StrType s) := InValidFT_invalid_gender(s);
EXPORT InValidMessage_sex_gender(UNSIGNED1 wh) := InValidMessageFT_invalid_gender(wh);
 
EXPORT Make_permanent_license_issue_date(SALT311.StrType s0) := MakeFT_invalid_8pastdate(s0);
EXPORT InValid_permanent_license_issue_date(SALT311.StrType s) := InValidFT_invalid_8pastdate(s);
EXPORT InValidMessage_permanent_license_issue_date(UNSIGNED1 wh) := InValidMessageFT_invalid_8pastdate(wh);
 
EXPORT Make_license_expiration_date(SALT311.StrType s0) := MakeFT_invalid_8generaldate(s0);
EXPORT InValid_license_expiration_date(SALT311.StrType s) := InValidFT_invalid_8generaldate(s);
EXPORT InValidMessage_license_expiration_date(UNSIGNED1 wh) := InValidMessageFT_invalid_8generaldate(wh);
 
EXPORT Make_restriction_codes(SALT311.StrType s0) := MakeFT_invalid_restrictions(s0);
EXPORT InValid_restriction_codes(SALT311.StrType s) := InValidFT_invalid_restrictions(s);
EXPORT InValidMessage_restriction_codes(UNSIGNED1 wh) := InValidMessageFT_invalid_restrictions(wh);
 
EXPORT Make_endorsement_codes(SALT311.StrType s0) := MakeFT_invalid_endorsements(s0);
EXPORT InValid_endorsement_codes(SALT311.StrType s) := InValidFT_invalid_endorsements(s);
EXPORT InValidMessage_endorsement_codes(UNSIGNED1 wh) := InValidMessageFT_invalid_endorsements(wh);
 
EXPORT Make_first_name(SALT311.StrType s0) := MakeFT_invalid_name(s0);
EXPORT InValid_first_name(SALT311.StrType s,SALT311.StrType middle_name,SALT311.StrType last_name) := InValidFT_invalid_name(s,middle_name,last_name);
EXPORT InValidMessage_first_name(UNSIGNED1 wh) := InValidMessageFT_invalid_name(wh);
 
EXPORT Make_middle_name(SALT311.StrType s0) := s0;
EXPORT InValid_middle_name(SALT311.StrType s) := 0;
EXPORT InValidMessage_middle_name(UNSIGNED1 wh) := '';
 
EXPORT Make_last_name(SALT311.StrType s0) := s0;
EXPORT InValid_last_name(SALT311.StrType s) := 0;
EXPORT InValidMessage_last_name(UNSIGNED1 wh) := '';
 
EXPORT Make_street_address(SALT311.StrType s0) := MakeFT_invalid_street(s0);
EXPORT InValid_street_address(SALT311.StrType s) := InValidFT_invalid_street(s);
EXPORT InValidMessage_street_address(UNSIGNED1 wh) := InValidMessageFT_invalid_street(wh);
 
EXPORT Make_city(SALT311.StrType s0) := MakeFT_invalid_city(s0);
EXPORT InValid_city(SALT311.StrType s) := InValidFT_invalid_city(s);
EXPORT InValidMessage_city(UNSIGNED1 wh) := InValidMessageFT_invalid_city(wh);
 
EXPORT Make_state(SALT311.StrType s0) := MakeFT_invalid_state(s0);
EXPORT InValid_state(SALT311.StrType s) := InValidFT_invalid_state(s);
EXPORT InValidMessage_state(UNSIGNED1 wh) := InValidMessageFT_invalid_state(wh);
 
EXPORT Make_zip_code(SALT311.StrType s0) := MakeFT_invalid_zip(s0);
EXPORT InValid_zip_code(SALT311.StrType s) := InValidFT_invalid_zip(s);
EXPORT InValidMessage_zip_code(UNSIGNED1 wh) := InValidMessageFT_invalid_zip(wh);
 
EXPORT Make_county_number(SALT311.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_county_number(SALT311.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_county_number(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_birth_date(SALT311.StrType s0) := MakeFT_invalid_8pastdate(s0);
EXPORT InValid_birth_date(SALT311.StrType s) := InValidFT_invalid_8pastdate(s);
EXPORT InValidMessage_birth_date(UNSIGNED1 wh) := InValidMessageFT_invalid_8pastdate(wh);
 
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
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT311,Scrubs_DL_OH;
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
    BOOLEAN Diff_key_number;
    BOOLEAN Diff_license_number;
    BOOLEAN Diff_license_class;
    BOOLEAN Diff_donor_flag;
    BOOLEAN Diff_hair_color;
    BOOLEAN Diff_eye_color;
    BOOLEAN Diff_weight_l;
    BOOLEAN Diff_height_feet;
    BOOLEAN Diff_height_inches;
    BOOLEAN Diff_sex_gender;
    BOOLEAN Diff_permanent_license_issue_date;
    BOOLEAN Diff_license_expiration_date;
    BOOLEAN Diff_restriction_codes;
    BOOLEAN Diff_endorsement_codes;
    BOOLEAN Diff_first_name;
    BOOLEAN Diff_middle_name;
    BOOLEAN Diff_last_name;
    BOOLEAN Diff_street_address;
    BOOLEAN Diff_city;
    BOOLEAN Diff_state;
    BOOLEAN Diff_zip_code;
    BOOLEAN Diff_county_number;
    BOOLEAN Diff_birth_date;
    BOOLEAN Diff_clean_name_prefix;
    BOOLEAN Diff_clean_fname;
    BOOLEAN Diff_clean_mname;
    BOOLEAN Diff_clean_lname;
    UNSIGNED Num_Diffs;
    SALT311.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_process_date := le.process_date <> ri.process_date;
    SELF.Diff_key_number := le.key_number <> ri.key_number;
    SELF.Diff_license_number := le.license_number <> ri.license_number;
    SELF.Diff_license_class := le.license_class <> ri.license_class;
    SELF.Diff_donor_flag := le.donor_flag <> ri.donor_flag;
    SELF.Diff_hair_color := le.hair_color <> ri.hair_color;
    SELF.Diff_eye_color := le.eye_color <> ri.eye_color;
    SELF.Diff_weight_l := le.weight_l <> ri.weight_l;
    SELF.Diff_height_feet := le.height_feet <> ri.height_feet;
    SELF.Diff_height_inches := le.height_inches <> ri.height_inches;
    SELF.Diff_sex_gender := le.sex_gender <> ri.sex_gender;
    SELF.Diff_permanent_license_issue_date := le.permanent_license_issue_date <> ri.permanent_license_issue_date;
    SELF.Diff_license_expiration_date := le.license_expiration_date <> ri.license_expiration_date;
    SELF.Diff_restriction_codes := le.restriction_codes <> ri.restriction_codes;
    SELF.Diff_endorsement_codes := le.endorsement_codes <> ri.endorsement_codes;
    SELF.Diff_first_name := le.first_name <> ri.first_name;
    SELF.Diff_middle_name := le.middle_name <> ri.middle_name;
    SELF.Diff_last_name := le.last_name <> ri.last_name;
    SELF.Diff_street_address := le.street_address <> ri.street_address;
    SELF.Diff_city := le.city <> ri.city;
    SELF.Diff_state := le.state <> ri.state;
    SELF.Diff_zip_code := le.zip_code <> ri.zip_code;
    SELF.Diff_county_number := le.county_number <> ri.county_number;
    SELF.Diff_birth_date := le.birth_date <> ri.birth_date;
    SELF.Diff_clean_name_prefix := le.clean_name_prefix <> ri.clean_name_prefix;
    SELF.Diff_clean_fname := le.clean_fname <> ri.clean_fname;
    SELF.Diff_clean_mname := le.clean_mname <> ri.clean_mname;
    SELF.Diff_clean_lname := le.clean_lname <> ri.clean_lname;
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_process_date,1,0)+ IF( SELF.Diff_key_number,1,0)+ IF( SELF.Diff_license_number,1,0)+ IF( SELF.Diff_license_class,1,0)+ IF( SELF.Diff_donor_flag,1,0)+ IF( SELF.Diff_hair_color,1,0)+ IF( SELF.Diff_eye_color,1,0)+ IF( SELF.Diff_weight_l,1,0)+ IF( SELF.Diff_height_feet,1,0)+ IF( SELF.Diff_height_inches,1,0)+ IF( SELF.Diff_sex_gender,1,0)+ IF( SELF.Diff_permanent_license_issue_date,1,0)+ IF( SELF.Diff_license_expiration_date,1,0)+ IF( SELF.Diff_restriction_codes,1,0)+ IF( SELF.Diff_endorsement_codes,1,0)+ IF( SELF.Diff_first_name,1,0)+ IF( SELF.Diff_middle_name,1,0)+ IF( SELF.Diff_last_name,1,0)+ IF( SELF.Diff_street_address,1,0)+ IF( SELF.Diff_city,1,0)+ IF( SELF.Diff_state,1,0)+ IF( SELF.Diff_zip_code,1,0)+ IF( SELF.Diff_county_number,1,0)+ IF( SELF.Diff_birth_date,1,0)+ IF( SELF.Diff_clean_name_prefix,1,0)+ IF( SELF.Diff_clean_fname,1,0)+ IF( SELF.Diff_clean_mname,1,0)+ IF( SELF.Diff_clean_lname,1,0);
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
    Count_Diff_key_number := COUNT(GROUP,%Closest%.Diff_key_number);
    Count_Diff_license_number := COUNT(GROUP,%Closest%.Diff_license_number);
    Count_Diff_license_class := COUNT(GROUP,%Closest%.Diff_license_class);
    Count_Diff_donor_flag := COUNT(GROUP,%Closest%.Diff_donor_flag);
    Count_Diff_hair_color := COUNT(GROUP,%Closest%.Diff_hair_color);
    Count_Diff_eye_color := COUNT(GROUP,%Closest%.Diff_eye_color);
    Count_Diff_weight_l := COUNT(GROUP,%Closest%.Diff_weight_l);
    Count_Diff_height_feet := COUNT(GROUP,%Closest%.Diff_height_feet);
    Count_Diff_height_inches := COUNT(GROUP,%Closest%.Diff_height_inches);
    Count_Diff_sex_gender := COUNT(GROUP,%Closest%.Diff_sex_gender);
    Count_Diff_permanent_license_issue_date := COUNT(GROUP,%Closest%.Diff_permanent_license_issue_date);
    Count_Diff_license_expiration_date := COUNT(GROUP,%Closest%.Diff_license_expiration_date);
    Count_Diff_restriction_codes := COUNT(GROUP,%Closest%.Diff_restriction_codes);
    Count_Diff_endorsement_codes := COUNT(GROUP,%Closest%.Diff_endorsement_codes);
    Count_Diff_first_name := COUNT(GROUP,%Closest%.Diff_first_name);
    Count_Diff_middle_name := COUNT(GROUP,%Closest%.Diff_middle_name);
    Count_Diff_last_name := COUNT(GROUP,%Closest%.Diff_last_name);
    Count_Diff_street_address := COUNT(GROUP,%Closest%.Diff_street_address);
    Count_Diff_city := COUNT(GROUP,%Closest%.Diff_city);
    Count_Diff_state := COUNT(GROUP,%Closest%.Diff_state);
    Count_Diff_zip_code := COUNT(GROUP,%Closest%.Diff_zip_code);
    Count_Diff_county_number := COUNT(GROUP,%Closest%.Diff_county_number);
    Count_Diff_birth_date := COUNT(GROUP,%Closest%.Diff_birth_date);
    Count_Diff_clean_name_prefix := COUNT(GROUP,%Closest%.Diff_clean_name_prefix);
    Count_Diff_clean_fname := COUNT(GROUP,%Closest%.Diff_clean_fname);
    Count_Diff_clean_mname := COUNT(GROUP,%Closest%.Diff_clean_mname);
    Count_Diff_clean_lname := COUNT(GROUP,%Closest%.Diff_clean_lname);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
