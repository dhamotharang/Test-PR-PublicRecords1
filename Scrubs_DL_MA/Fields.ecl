IMPORT SALT39;
IMPORT Scrubs,Scrubs_DL_MA; // Import modules for FieldTypes attribute definitions
EXPORT Fields := MODULE
 
EXPORT NumFields := 26;
 
// Processing for each FieldType
EXPORT SALT39.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_mandatory','invalid_alpha','invalid_alpha_specials','invalid_numeric','invalid_alpha_num','invalid_empty','invalid_wordbag','invalid_8date','invalid_8pastdate','invalid_08pastdate','invalid_pers_surrogate','invalid_license_licno','invalid_license_lic_class','invalid_license_height','invalid_license_sex','invalid_license_name','invalid_licmail_state','invalid_mailzip','invalid_licresi_state','invalid_resizip','invalid_license_status');
EXPORT FieldTypeNum(SALT39.StrType fn) := CASE(fn,'invalid_mandatory' => 1,'invalid_alpha' => 2,'invalid_alpha_specials' => 3,'invalid_numeric' => 4,'invalid_alpha_num' => 5,'invalid_empty' => 6,'invalid_wordbag' => 7,'invalid_8date' => 8,'invalid_8pastdate' => 9,'invalid_08pastdate' => 10,'invalid_pers_surrogate' => 11,'invalid_license_licno' => 12,'invalid_license_lic_class' => 13,'invalid_license_height' => 14,'invalid_license_sex' => 15,'invalid_license_name' => 16,'invalid_licmail_state' => 17,'invalid_mailzip' => 18,'invalid_licresi_state' => 19,'invalid_resizip' => 20,'invalid_license_status' => 21,0);
 
EXPORT MakeFT_invalid_mandatory(SALT39.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_mandatory(SALT39.StrType s) := WHICH(~(LENGTH(TRIM(s)) >= 1));
EXPORT InValidMessageFT_invalid_mandatory(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLength('1..'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_alpha(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_alpha(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'))));
EXPORT InValidMessageFT_invalid_alpha(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_alpha_specials(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ @-.,#'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_alpha_specials(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ @-.,#'))));
EXPORT InValidMessageFT_invalid_alpha_specials(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ @-.,#'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_numeric(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_numeric(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_invalid_numeric(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('0123456789'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_alpha_num(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_alpha_num(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'))));
EXPORT InValidMessageFT_invalid_alpha_num(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_empty(SALT39.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_empty(SALT39.StrType s) := WHICH(~(LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_empty(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_wordbag(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringtouppercase(s0); // Force to upper case
  s2 := SALT39.stringfilter(s1,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 <>{}[]()-^=!+&,./#*\'\\|"'); // Only allow valid symbols
  s3 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s2,' <>{}[]()-^=!+&,./#*\'\\|"',' ') ); // Insert spaces but avoid doubles
  RETURN  s3;
END;
EXPORT InValidFT_invalid_wordbag(SALT39.StrType s) := WHICH(SALT39.stringtouppercase(s)<>s,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 <>{}[]()-^=!+&,./#*\'\\|"'))));
EXPORT InValidMessageFT_invalid_wordbag(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotCaps,SALT39.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 <>{}[]()-^=!+&,./#*\'\\|"'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_8date(SALT39.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_8date(SALT39.StrType s) := WHICH(~Scrubs.fn_valid_GeneralDate(s)>0,~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 8));
EXPORT InValidMessageFT_invalid_8date(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.CustomFail('Scrubs.fn_valid_GeneralDate'),SALT39.HygieneErrors.NotLength('0,8'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_8pastdate(SALT39.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_8pastdate(SALT39.StrType s) := WHICH(~Scrubs.fn_valid_pastDate(s)>0,~(LENGTH(TRIM(s)) = 8));
EXPORT InValidMessageFT_invalid_8pastdate(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.CustomFail('Scrubs.fn_valid_pastDate'),SALT39.HygieneErrors.NotLength('8'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_08pastdate(SALT39.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_08pastdate(SALT39.StrType s) := WHICH(~Scrubs.fn_valid_pastDate(s)>0,~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 8));
EXPORT InValidMessageFT_invalid_08pastdate(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.CustomFail('Scrubs.fn_valid_pastDate'),SALT39.HygieneErrors.NotLength('0,8'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_pers_surrogate(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  MakeFT_invalid_numeric(s1);
END;
EXPORT InValidFT_invalid_pers_surrogate(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 9 OR LENGTH(TRIM(s)) = 10));
EXPORT InValidMessageFT_invalid_pers_surrogate(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('0123456789'),SALT39.HygieneErrors.NotLength('9,10'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_license_licno(SALT39.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_license_licno(SALT39.StrType s) := WHICH(~Scrubs_DL_MA.Functions.fn_verify_licno(s)>0,~(LENGTH(TRIM(s)) = 9));
EXPORT InValidMessageFT_invalid_license_licno(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.CustomFail('Scrubs_DL_MA.Functions.fn_verify_licno'),SALT39.HygieneErrors.NotLength('9'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_license_lic_class(SALT39.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_license_lic_class(SALT39.StrType s) := WHICH(~Scrubs_DL_MA.Functions.fn_verify_lic_class(s)>0,~(LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 2));
EXPORT InValidMessageFT_invalid_license_lic_class(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.CustomFail('Scrubs_DL_MA.Functions.fn_verify_lic_class'),SALT39.HygieneErrors.NotLength('1,2'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_license_height(SALT39.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_license_height(SALT39.StrType s) := WHICH(~Scrubs_DL_MA.Functions.fn_verify_height(s)>0);
EXPORT InValidMessageFT_invalid_license_height(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.CustomFail('Scrubs_DL_MA.Functions.fn_verify_height'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_license_sex(SALT39.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_license_sex(SALT39.StrType s) := WHICH(((SALT39.StrType) s) NOT IN ['F','M','U']);
EXPORT InValidMessageFT_invalid_license_sex(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInEnum('F|M|U'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_license_name(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringtouppercase(s0); // Force to upper case
  s2 := SALT39.stringfilter(s1,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 <>{}[]()-^=!+&,./#*\'\\|"'); // Only allow valid symbols
  s3 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s2,' <>{}[]()-^=!+&,./#*\'\\|"',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_invalid_wordbag(s3);
END;
EXPORT InValidFT_invalid_license_name(SALT39.StrType s,SALT39.StrType license_first_name,SALT39.StrType license_middle_name) := WHICH(SALT39.stringtouppercase(s)<>s,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 <>{}[]()-^=!+&,./#*\'\\|"'))),~Scrubs_DL_MA.Functions.fn_valid_name(s,license_first_name,license_middle_name)>0);
EXPORT InValidMessageFT_invalid_license_name(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotCaps,SALT39.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 <>{}[]()-^=!+&,./#*\'\\|"'),SALT39.HygieneErrors.CustomFail('Scrubs_DL_MA.Functions.fn_valid_name'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_licmail_state(SALT39.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_licmail_state(SALT39.StrType s) := WHICH(~Scrubs_DL_MA.Functions.fn_verify_state(s)>0,~(LENGTH(TRIM(s)) = 2));
EXPORT InValidMessageFT_invalid_licmail_state(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.CustomFail('Scrubs_DL_MA.Functions.fn_verify_state'),SALT39.HygieneErrors.NotLength('2'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_mailzip(SALT39.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_mailzip(SALT39.StrType s,SALT39.StrType licmail_state) := WHICH(~Scrubs_DL_MA.Functions.fn_verify_zip(s,licmail_state)>0,~(LENGTH(TRIM(s)) = 9));
EXPORT InValidMessageFT_invalid_mailzip(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.CustomFail('Scrubs_DL_MA.Functions.fn_verify_zip'),SALT39.HygieneErrors.NotLength('9'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_licresi_state(SALT39.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_licresi_state(SALT39.StrType s) := WHICH(~Scrubs_DL_MA.Functions.fn_verify_state(s)>0,~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 2));
EXPORT InValidMessageFT_invalid_licresi_state(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.CustomFail('Scrubs_DL_MA.Functions.fn_verify_state'),SALT39.HygieneErrors.NotLength('0,2'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_resizip(SALT39.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_resizip(SALT39.StrType s,SALT39.StrType licresi_state) := WHICH(~Scrubs_DL_MA.Functions.fn_verify_zip(s,licresi_state)>0,~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 9));
EXPORT InValidMessageFT_invalid_resizip(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.CustomFail('Scrubs_DL_MA.Functions.fn_verify_zip'),SALT39.HygieneErrors.NotLength('0,9'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_license_status(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'/ACENPRSTUVX'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_license_status(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'/ACENPRSTUVX'))),~(LENGTH(TRIM(s)) = 3 OR LENGTH(TRIM(s)) = 7));
EXPORT InValidMessageFT_invalid_license_status(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('/ACENPRSTUVX'),SALT39.HygieneErrors.NotLength('3,7'),SALT39.HygieneErrors.Good);
 
EXPORT SALT39.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'pers_surrogate','filler1','license_licno','filler2','license_bdate_yyyymmdd','license_edate_yyyymmdd','license_lic_class','license_height','license_sex','license_last_name','license_first_name','license_middle_name','licmail_street1','licmail_street2','licmail_city','licmail_state','licmail_zip','licresi_street1','licresi_street2','licresi_city','licresi_state','licresi_zip','issue_date_yyyymmdd','license_status','clean_status','process_date');
EXPORT SALT39.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'pers_surrogate','filler1','license_licno','filler2','license_bdate_yyyymmdd','license_edate_yyyymmdd','license_lic_class','license_height','license_sex','license_last_name','license_first_name','license_middle_name','licmail_street1','licmail_street2','licmail_city','licmail_state','licmail_zip','licresi_street1','licresi_street2','licresi_city','licresi_state','licresi_zip','issue_date_yyyymmdd','license_status','clean_status','process_date');
EXPORT FieldNum(SALT39.StrType fn) := CASE(fn,'pers_surrogate' => 0,'filler1' => 1,'license_licno' => 2,'filler2' => 3,'license_bdate_yyyymmdd' => 4,'license_edate_yyyymmdd' => 5,'license_lic_class' => 6,'license_height' => 7,'license_sex' => 8,'license_last_name' => 9,'license_first_name' => 10,'license_middle_name' => 11,'licmail_street1' => 12,'licmail_street2' => 13,'licmail_city' => 14,'licmail_state' => 15,'licmail_zip' => 16,'licresi_street1' => 17,'licresi_street2' => 18,'licresi_city' => 19,'licresi_state' => 20,'licresi_zip' => 21,'issue_date_yyyymmdd' => 22,'license_status' => 23,'clean_status' => 24,'process_date' => 25,0);
EXPORT SET OF SALT39.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['ALLOW','LENGTHS'],[],['CUSTOM','LENGTHS'],[],['CUSTOM','LENGTHS'],['CUSTOM','LENGTHS'],['CUSTOM','LENGTHS'],['CUSTOM'],['ENUM'],['CAPS','ALLOW','CUSTOM'],['CAPS','ALLOW'],['CAPS','ALLOW'],[],[],[],['CUSTOM','LENGTHS'],['CUSTOM','LENGTHS'],['CAPS','ALLOW'],['CAPS','ALLOW'],['CAPS','ALLOW'],['CUSTOM','LENGTHS'],['CUSTOM','LENGTHS'],['CUSTOM','LENGTHS'],['ALLOW','LENGTHS'],[],['CUSTOM','LENGTHS'],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_pers_surrogate(SALT39.StrType s0) := MakeFT_invalid_pers_surrogate(s0);
EXPORT InValid_pers_surrogate(SALT39.StrType s) := InValidFT_invalid_pers_surrogate(s);
EXPORT InValidMessage_pers_surrogate(UNSIGNED1 wh) := InValidMessageFT_invalid_pers_surrogate(wh);
 
EXPORT Make_filler1(SALT39.StrType s0) := s0;
EXPORT InValid_filler1(SALT39.StrType s) := 0;
EXPORT InValidMessage_filler1(UNSIGNED1 wh) := '';
 
EXPORT Make_license_licno(SALT39.StrType s0) := MakeFT_invalid_license_licno(s0);
EXPORT InValid_license_licno(SALT39.StrType s) := InValidFT_invalid_license_licno(s);
EXPORT InValidMessage_license_licno(UNSIGNED1 wh) := InValidMessageFT_invalid_license_licno(wh);
 
EXPORT Make_filler2(SALT39.StrType s0) := s0;
EXPORT InValid_filler2(SALT39.StrType s) := 0;
EXPORT InValidMessage_filler2(UNSIGNED1 wh) := '';
 
EXPORT Make_license_bdate_yyyymmdd(SALT39.StrType s0) := MakeFT_invalid_8pastdate(s0);
EXPORT InValid_license_bdate_yyyymmdd(SALT39.StrType s) := InValidFT_invalid_8pastdate(s);
EXPORT InValidMessage_license_bdate_yyyymmdd(UNSIGNED1 wh) := InValidMessageFT_invalid_8pastdate(wh);
 
EXPORT Make_license_edate_yyyymmdd(SALT39.StrType s0) := MakeFT_invalid_8date(s0);
EXPORT InValid_license_edate_yyyymmdd(SALT39.StrType s) := InValidFT_invalid_8date(s);
EXPORT InValidMessage_license_edate_yyyymmdd(UNSIGNED1 wh) := InValidMessageFT_invalid_8date(wh);
 
EXPORT Make_license_lic_class(SALT39.StrType s0) := MakeFT_invalid_license_lic_class(s0);
EXPORT InValid_license_lic_class(SALT39.StrType s) := InValidFT_invalid_license_lic_class(s);
EXPORT InValidMessage_license_lic_class(UNSIGNED1 wh) := InValidMessageFT_invalid_license_lic_class(wh);
 
EXPORT Make_license_height(SALT39.StrType s0) := MakeFT_invalid_license_height(s0);
EXPORT InValid_license_height(SALT39.StrType s) := InValidFT_invalid_license_height(s);
EXPORT InValidMessage_license_height(UNSIGNED1 wh) := InValidMessageFT_invalid_license_height(wh);
 
EXPORT Make_license_sex(SALT39.StrType s0) := MakeFT_invalid_license_sex(s0);
EXPORT InValid_license_sex(SALT39.StrType s) := InValidFT_invalid_license_sex(s);
EXPORT InValidMessage_license_sex(UNSIGNED1 wh) := InValidMessageFT_invalid_license_sex(wh);
 
EXPORT Make_license_last_name(SALT39.StrType s0) := MakeFT_invalid_license_name(s0);
EXPORT InValid_license_last_name(SALT39.StrType s,SALT39.StrType license_first_name,SALT39.StrType license_middle_name) := InValidFT_invalid_license_name(s,license_first_name,license_middle_name);
EXPORT InValidMessage_license_last_name(UNSIGNED1 wh) := InValidMessageFT_invalid_license_name(wh);
 
EXPORT Make_license_first_name(SALT39.StrType s0) := MakeFT_invalid_wordbag(s0);
EXPORT InValid_license_first_name(SALT39.StrType s) := InValidFT_invalid_wordbag(s);
EXPORT InValidMessage_license_first_name(UNSIGNED1 wh) := InValidMessageFT_invalid_wordbag(wh);
 
EXPORT Make_license_middle_name(SALT39.StrType s0) := MakeFT_invalid_wordbag(s0);
EXPORT InValid_license_middle_name(SALT39.StrType s) := InValidFT_invalid_wordbag(s);
EXPORT InValidMessage_license_middle_name(UNSIGNED1 wh) := InValidMessageFT_invalid_wordbag(wh);
 
EXPORT Make_licmail_street1(SALT39.StrType s0) := s0;
EXPORT InValid_licmail_street1(SALT39.StrType s) := 0;
EXPORT InValidMessage_licmail_street1(UNSIGNED1 wh) := '';
 
EXPORT Make_licmail_street2(SALT39.StrType s0) := s0;
EXPORT InValid_licmail_street2(SALT39.StrType s) := 0;
EXPORT InValidMessage_licmail_street2(UNSIGNED1 wh) := '';
 
EXPORT Make_licmail_city(SALT39.StrType s0) := s0;
EXPORT InValid_licmail_city(SALT39.StrType s) := 0;
EXPORT InValidMessage_licmail_city(UNSIGNED1 wh) := '';
 
EXPORT Make_licmail_state(SALT39.StrType s0) := MakeFT_invalid_licmail_state(s0);
EXPORT InValid_licmail_state(SALT39.StrType s) := InValidFT_invalid_licmail_state(s);
EXPORT InValidMessage_licmail_state(UNSIGNED1 wh) := InValidMessageFT_invalid_licmail_state(wh);
 
EXPORT Make_licmail_zip(SALT39.StrType s0) := MakeFT_invalid_mailzip(s0);
EXPORT InValid_licmail_zip(SALT39.StrType s,SALT39.StrType licmail_state) := InValidFT_invalid_mailzip(s,licmail_state);
EXPORT InValidMessage_licmail_zip(UNSIGNED1 wh) := InValidMessageFT_invalid_mailzip(wh);
 
EXPORT Make_licresi_street1(SALT39.StrType s0) := MakeFT_invalid_wordbag(s0);
EXPORT InValid_licresi_street1(SALT39.StrType s) := InValidFT_invalid_wordbag(s);
EXPORT InValidMessage_licresi_street1(UNSIGNED1 wh) := InValidMessageFT_invalid_wordbag(wh);
 
EXPORT Make_licresi_street2(SALT39.StrType s0) := MakeFT_invalid_wordbag(s0);
EXPORT InValid_licresi_street2(SALT39.StrType s) := InValidFT_invalid_wordbag(s);
EXPORT InValidMessage_licresi_street2(UNSIGNED1 wh) := InValidMessageFT_invalid_wordbag(wh);
 
EXPORT Make_licresi_city(SALT39.StrType s0) := MakeFT_invalid_wordbag(s0);
EXPORT InValid_licresi_city(SALT39.StrType s) := InValidFT_invalid_wordbag(s);
EXPORT InValidMessage_licresi_city(UNSIGNED1 wh) := InValidMessageFT_invalid_wordbag(wh);
 
EXPORT Make_licresi_state(SALT39.StrType s0) := MakeFT_invalid_licresi_state(s0);
EXPORT InValid_licresi_state(SALT39.StrType s) := InValidFT_invalid_licresi_state(s);
EXPORT InValidMessage_licresi_state(UNSIGNED1 wh) := InValidMessageFT_invalid_licresi_state(wh);
 
EXPORT Make_licresi_zip(SALT39.StrType s0) := MakeFT_invalid_resizip(s0);
EXPORT InValid_licresi_zip(SALT39.StrType s,SALT39.StrType licresi_state) := InValidFT_invalid_resizip(s,licresi_state);
EXPORT InValidMessage_licresi_zip(UNSIGNED1 wh) := InValidMessageFT_invalid_resizip(wh);
 
EXPORT Make_issue_date_yyyymmdd(SALT39.StrType s0) := MakeFT_invalid_08pastdate(s0);
EXPORT InValid_issue_date_yyyymmdd(SALT39.StrType s) := InValidFT_invalid_08pastdate(s);
EXPORT InValidMessage_issue_date_yyyymmdd(UNSIGNED1 wh) := InValidMessageFT_invalid_08pastdate(wh);
 
EXPORT Make_license_status(SALT39.StrType s0) := MakeFT_invalid_license_status(s0);
EXPORT InValid_license_status(SALT39.StrType s) := InValidFT_invalid_license_status(s);
EXPORT InValidMessage_license_status(UNSIGNED1 wh) := InValidMessageFT_invalid_license_status(wh);
 
EXPORT Make_clean_status(SALT39.StrType s0) := s0;
EXPORT InValid_clean_status(SALT39.StrType s) := 0;
EXPORT InValidMessage_clean_status(UNSIGNED1 wh) := '';
 
EXPORT Make_process_date(SALT39.StrType s0) := MakeFT_invalid_8pastdate(s0);
EXPORT InValid_process_date(SALT39.StrType s) := InValidFT_invalid_8pastdate(s);
EXPORT InValidMessage_process_date(UNSIGNED1 wh) := InValidMessageFT_invalid_8pastdate(wh);
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT39,Scrubs_DL_MA;
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
    BOOLEAN Diff_pers_surrogate;
    BOOLEAN Diff_filler1;
    BOOLEAN Diff_license_licno;
    BOOLEAN Diff_filler2;
    BOOLEAN Diff_license_bdate_yyyymmdd;
    BOOLEAN Diff_license_edate_yyyymmdd;
    BOOLEAN Diff_license_lic_class;
    BOOLEAN Diff_license_height;
    BOOLEAN Diff_license_sex;
    BOOLEAN Diff_license_last_name;
    BOOLEAN Diff_license_first_name;
    BOOLEAN Diff_license_middle_name;
    BOOLEAN Diff_licmail_street1;
    BOOLEAN Diff_licmail_street2;
    BOOLEAN Diff_licmail_city;
    BOOLEAN Diff_licmail_state;
    BOOLEAN Diff_licmail_zip;
    BOOLEAN Diff_licresi_street1;
    BOOLEAN Diff_licresi_street2;
    BOOLEAN Diff_licresi_city;
    BOOLEAN Diff_licresi_state;
    BOOLEAN Diff_licresi_zip;
    BOOLEAN Diff_issue_date_yyyymmdd;
    BOOLEAN Diff_license_status;
    BOOLEAN Diff_clean_status;
    BOOLEAN Diff_process_date;
    UNSIGNED Num_Diffs;
    SALT39.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_pers_surrogate := le.pers_surrogate <> ri.pers_surrogate;
    SELF.Diff_filler1 := le.filler1 <> ri.filler1;
    SELF.Diff_license_licno := le.license_licno <> ri.license_licno;
    SELF.Diff_filler2 := le.filler2 <> ri.filler2;
    SELF.Diff_license_bdate_yyyymmdd := le.license_bdate_yyyymmdd <> ri.license_bdate_yyyymmdd;
    SELF.Diff_license_edate_yyyymmdd := le.license_edate_yyyymmdd <> ri.license_edate_yyyymmdd;
    SELF.Diff_license_lic_class := le.license_lic_class <> ri.license_lic_class;
    SELF.Diff_license_height := le.license_height <> ri.license_height;
    SELF.Diff_license_sex := le.license_sex <> ri.license_sex;
    SELF.Diff_license_last_name := le.license_last_name <> ri.license_last_name;
    SELF.Diff_license_first_name := le.license_first_name <> ri.license_first_name;
    SELF.Diff_license_middle_name := le.license_middle_name <> ri.license_middle_name;
    SELF.Diff_licmail_street1 := le.licmail_street1 <> ri.licmail_street1;
    SELF.Diff_licmail_street2 := le.licmail_street2 <> ri.licmail_street2;
    SELF.Diff_licmail_city := le.licmail_city <> ri.licmail_city;
    SELF.Diff_licmail_state := le.licmail_state <> ri.licmail_state;
    SELF.Diff_licmail_zip := le.licmail_zip <> ri.licmail_zip;
    SELF.Diff_licresi_street1 := le.licresi_street1 <> ri.licresi_street1;
    SELF.Diff_licresi_street2 := le.licresi_street2 <> ri.licresi_street2;
    SELF.Diff_licresi_city := le.licresi_city <> ri.licresi_city;
    SELF.Diff_licresi_state := le.licresi_state <> ri.licresi_state;
    SELF.Diff_licresi_zip := le.licresi_zip <> ri.licresi_zip;
    SELF.Diff_issue_date_yyyymmdd := le.issue_date_yyyymmdd <> ri.issue_date_yyyymmdd;
    SELF.Diff_license_status := le.license_status <> ri.license_status;
    SELF.Diff_clean_status := le.clean_status <> ri.clean_status;
    SELF.Diff_process_date := le.process_date <> ri.process_date;
    SELF.Val := (SALT39.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_pers_surrogate,1,0)+ IF( SELF.Diff_filler1,1,0)+ IF( SELF.Diff_license_licno,1,0)+ IF( SELF.Diff_filler2,1,0)+ IF( SELF.Diff_license_bdate_yyyymmdd,1,0)+ IF( SELF.Diff_license_edate_yyyymmdd,1,0)+ IF( SELF.Diff_license_lic_class,1,0)+ IF( SELF.Diff_license_height,1,0)+ IF( SELF.Diff_license_sex,1,0)+ IF( SELF.Diff_license_last_name,1,0)+ IF( SELF.Diff_license_first_name,1,0)+ IF( SELF.Diff_license_middle_name,1,0)+ IF( SELF.Diff_licmail_street1,1,0)+ IF( SELF.Diff_licmail_street2,1,0)+ IF( SELF.Diff_licmail_city,1,0)+ IF( SELF.Diff_licmail_state,1,0)+ IF( SELF.Diff_licmail_zip,1,0)+ IF( SELF.Diff_licresi_street1,1,0)+ IF( SELF.Diff_licresi_street2,1,0)+ IF( SELF.Diff_licresi_city,1,0)+ IF( SELF.Diff_licresi_state,1,0)+ IF( SELF.Diff_licresi_zip,1,0)+ IF( SELF.Diff_issue_date_yyyymmdd,1,0)+ IF( SELF.Diff_license_status,1,0)+ IF( SELF.Diff_clean_status,1,0)+ IF( SELF.Diff_process_date,1,0);
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
    Count_Diff_pers_surrogate := COUNT(GROUP,%Closest%.Diff_pers_surrogate);
    Count_Diff_filler1 := COUNT(GROUP,%Closest%.Diff_filler1);
    Count_Diff_license_licno := COUNT(GROUP,%Closest%.Diff_license_licno);
    Count_Diff_filler2 := COUNT(GROUP,%Closest%.Diff_filler2);
    Count_Diff_license_bdate_yyyymmdd := COUNT(GROUP,%Closest%.Diff_license_bdate_yyyymmdd);
    Count_Diff_license_edate_yyyymmdd := COUNT(GROUP,%Closest%.Diff_license_edate_yyyymmdd);
    Count_Diff_license_lic_class := COUNT(GROUP,%Closest%.Diff_license_lic_class);
    Count_Diff_license_height := COUNT(GROUP,%Closest%.Diff_license_height);
    Count_Diff_license_sex := COUNT(GROUP,%Closest%.Diff_license_sex);
    Count_Diff_license_last_name := COUNT(GROUP,%Closest%.Diff_license_last_name);
    Count_Diff_license_first_name := COUNT(GROUP,%Closest%.Diff_license_first_name);
    Count_Diff_license_middle_name := COUNT(GROUP,%Closest%.Diff_license_middle_name);
    Count_Diff_licmail_street1 := COUNT(GROUP,%Closest%.Diff_licmail_street1);
    Count_Diff_licmail_street2 := COUNT(GROUP,%Closest%.Diff_licmail_street2);
    Count_Diff_licmail_city := COUNT(GROUP,%Closest%.Diff_licmail_city);
    Count_Diff_licmail_state := COUNT(GROUP,%Closest%.Diff_licmail_state);
    Count_Diff_licmail_zip := COUNT(GROUP,%Closest%.Diff_licmail_zip);
    Count_Diff_licresi_street1 := COUNT(GROUP,%Closest%.Diff_licresi_street1);
    Count_Diff_licresi_street2 := COUNT(GROUP,%Closest%.Diff_licresi_street2);
    Count_Diff_licresi_city := COUNT(GROUP,%Closest%.Diff_licresi_city);
    Count_Diff_licresi_state := COUNT(GROUP,%Closest%.Diff_licresi_state);
    Count_Diff_licresi_zip := COUNT(GROUP,%Closest%.Diff_licresi_zip);
    Count_Diff_issue_date_yyyymmdd := COUNT(GROUP,%Closest%.Diff_issue_date_yyyymmdd);
    Count_Diff_license_status := COUNT(GROUP,%Closest%.Diff_license_status);
    Count_Diff_clean_status := COUNT(GROUP,%Closest%.Diff_clean_status);
    Count_Diff_process_date := COUNT(GROUP,%Closest%.Diff_process_date);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
