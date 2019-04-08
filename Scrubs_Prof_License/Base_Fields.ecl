IMPORT SALT37;
IMPORT Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT Base_Fields := MODULE
 
// Processing for each FieldType
EXPORT SALT37.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_alpha','invalid_numeric','invalid_yn','invalid_nonprintable','invalid_alphanumeric','invalid_alphanumerichyphen','invalid_alphaspaceslash','invalid_past_date','invalid_0468date','invalid_0468pastdate','invalid_068pastdate','invalid_prolic_key','invalid_profession_or_board','invalid_license_type','invalid_status','invalid_name_order','invalid_orig_city','invalid_orig_zip','invalid_phone','invalid_sex','invalid_license_obtained_by','invalid_vendor','invalid_action_case_number','invalid_action_status','invalid_additional_name_addr_type','invalid_additional_phone','invalid_misc_occupation','invalid_misc_practice_hours','invalid_misc_practice_type','invalid_misc_web_site','invalid_misc_other_id_type','invalid_education_continuing_education','invalid_education_dates_attended','invalid_education_curriculum','invalid_education_degree','personal_pob_desc');
EXPORT FieldTypeNum(SALT37.StrType fn) := CASE(fn,'invalid_alpha' => 1,'invalid_numeric' => 2,'invalid_yn' => 3,'invalid_nonprintable' => 4,'invalid_alphanumeric' => 5,'invalid_alphanumerichyphen' => 6,'invalid_alphaspaceslash' => 7,'invalid_past_date' => 8,'invalid_0468date' => 9,'invalid_0468pastdate' => 10,'invalid_068pastdate' => 11,'invalid_prolic_key' => 12,'invalid_profession_or_board' => 13,'invalid_license_type' => 14,'invalid_status' => 15,'invalid_name_order' => 16,'invalid_orig_city' => 17,'invalid_orig_zip' => 18,'invalid_phone' => 19,'invalid_sex' => 20,'invalid_license_obtained_by' => 21,'invalid_vendor' => 22,'invalid_action_case_number' => 23,'invalid_action_status' => 24,'invalid_additional_name_addr_type' => 25,'invalid_additional_phone' => 26,'invalid_misc_occupation' => 27,'invalid_misc_practice_hours' => 28,'invalid_misc_practice_type' => 29,'invalid_misc_web_site' => 30,'invalid_misc_other_id_type' => 31,'invalid_education_continuing_education' => 32,'invalid_education_dates_attended' => 33,'invalid_education_curriculum' => 34,'invalid_education_degree' => 35,'personal_pob_desc' => 36,0);
 
EXPORT MakeFT_invalid_alpha(SALT37.StrType s0) := FUNCTION
  s1 := SALT37.stringtouppercase(s0); // Force to upper case
  s2 := SALT37.stringfilter(s1,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Only allow valid symbols
  RETURN  s2;
END;
EXPORT InValidFT_invalid_alpha(SALT37.StrType s) := WHICH(SALT37.stringtouppercase(s)<>s,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT37.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'))));
EXPORT InValidMessageFT_invalid_alpha(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotCaps,SALT37.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_numeric(SALT37.StrType s0) := FUNCTION
  s1 := SALT37.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_numeric(SALT37.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT37.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_invalid_numeric(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotInChars('0123456789'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_yn(SALT37.StrType s0) := FUNCTION
  s1 := SALT37.stringtouppercase(s0); // Force to upper case
  RETURN  s1;
END;
EXPORT InValidFT_invalid_yn(SALT37.StrType s) := WHICH(SALT37.stringtouppercase(s)<>s,((SALT37.StrType) s) NOT IN [' ','Y','N']);
EXPORT InValidMessageFT_invalid_yn(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotCaps,SALT37.HygieneErrors.NotInEnum(' |Y|N'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_nonprintable(SALT37.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_nonprintable(SALT37.StrType s) := WHICH(~Scrubs.valid_text.fn_nonprintable_chars(s)<1);
EXPORT InValidMessageFT_invalid_nonprintable(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.CustomFail('Scrubs.valid_text.fn_nonprintable_chars'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_alphanumeric(SALT37.StrType s0) := FUNCTION
  s1 := SALT37.stringtouppercase(s0); // Force to upper case
  s2 := SALT37.stringfilter(s1,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'); // Only allow valid symbols
  RETURN  s2;
END;
EXPORT InValidFT_invalid_alphanumeric(SALT37.StrType s) := WHICH(SALT37.stringtouppercase(s)<>s,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT37.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'))));
EXPORT InValidMessageFT_invalid_alphanumeric(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotCaps,SALT37.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_alphanumerichyphen(SALT37.StrType s0) := FUNCTION
  s1 := SALT37.stringfilter(s0,'-ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_alphanumerichyphen(SALT37.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT37.StringFilter(s,'-ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'))));
EXPORT InValidMessageFT_invalid_alphanumerichyphen(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotInChars('-ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_alphaspaceslash(SALT37.StrType s0) := FUNCTION
  s1 := SALT37.stringfilter(s0,' /ABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_alphaspaceslash(SALT37.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT37.StringFilter(s,' /ABCDEFGHIJKLMNOPQRSTUVWXYZ'))));
EXPORT InValidMessageFT_invalid_alphaspaceslash(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotInChars(' /ABCDEFGHIJKLMNOPQRSTUVWXYZ'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_past_date(SALT37.StrType s0) := FUNCTION
  s1 := SALT37.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_past_date(SALT37.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT37.StringFilter(s,'0123456789'))),~Scrubs.fn_valid_pastDate(s)>0);
EXPORT InValidMessageFT_invalid_past_date(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotInChars('0123456789'),SALT37.HygieneErrors.CustomFail('Scrubs.fn_valid_pastDate'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_0468date(SALT37.StrType s0) := FUNCTION
  s1 := SALT37.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_0468date(SALT37.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT37.StringFilter(s,'0123456789'))),~Scrubs.valid_date.fn_valid_0468date(s,true,true)>0,~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 6 OR LENGTH(TRIM(s)) = 8));
EXPORT InValidMessageFT_invalid_0468date(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotInChars('0123456789'),SALT37.HygieneErrors.CustomFail('Scrubs.valid_date.fn_valid_0468date'),SALT37.HygieneErrors.NotLength('0,1,4,6,8'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_0468pastdate(SALT37.StrType s0) := FUNCTION
  s1 := SALT37.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_0468pastdate(SALT37.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT37.StringFilter(s,'0123456789'))),~Scrubs.valid_date.fn_valid_0468pastDate(s,true,true)>0,~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 6 OR LENGTH(TRIM(s)) = 8));
EXPORT InValidMessageFT_invalid_0468pastdate(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotInChars('0123456789'),SALT37.HygieneErrors.CustomFail('Scrubs.valid_date.fn_valid_0468pastDate'),SALT37.HygieneErrors.NotLength('0,1,4,6,8'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_068pastdate(SALT37.StrType s0) := FUNCTION
  s1 := SALT37.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_068pastdate(SALT37.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT37.StringFilter(s,'0123456789'))),~Scrubs.valid_date.fn_valid_0468pastDate(s,true,true)>0,~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 6 OR LENGTH(TRIM(s)) = 8));
EXPORT InValidMessageFT_invalid_068pastdate(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotInChars('0123456789'),SALT37.HygieneErrors.CustomFail('Scrubs.valid_date.fn_valid_0468pastDate'),SALT37.HygieneErrors.NotLength('0,1,6,8'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_prolic_key(SALT37.StrType s0) := FUNCTION
  s1 := SALT37.stringfilter(s0,' #*()_-\\/ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_prolic_key(SALT37.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT37.StringFilter(s,' #*()_-\\/ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'))),~Scrubs.valid_text.fn_nonprintable_chars(s)<1);
EXPORT InValidMessageFT_invalid_prolic_key(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotInChars(' #*()_-\\/ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'),SALT37.HygieneErrors.CustomFail('Scrubs.valid_text.fn_nonprintable_chars'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_profession_or_board(SALT37.StrType s0) := FUNCTION
  s1 := SALT37.stringfilter(s0,' #&()-\',./ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_profession_or_board(SALT37.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT37.StringFilter(s,' #&()-\',./ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'))),~Scrubs.valid_text.fn_nonprintable_chars(s)<1);
EXPORT InValidMessageFT_invalid_profession_or_board(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotInChars(' #&()-\',./ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'),SALT37.HygieneErrors.CustomFail('Scrubs.valid_text.fn_nonprintable_chars'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_license_type(SALT37.StrType s0) := FUNCTION
  s1 := SALT37.stringfilter(s0,' #&()_-\\:\'<>,./ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_license_type(SALT37.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT37.StringFilter(s,' #&()_-\\:\'<>,./ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'))),~Scrubs.valid_text.fn_nonprintable_chars(s)<1);
EXPORT InValidMessageFT_invalid_license_type(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotInChars(' #&()_-\\:\'<>,./ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'),SALT37.HygieneErrors.CustomFail('Scrubs.valid_text.fn_nonprintable_chars'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_status(SALT37.StrType s0) := FUNCTION
  s1 := SALT37.stringfilter(s0,' !#&*()+-:;\',./ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_status(SALT37.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT37.StringFilter(s,' !#&*()+-:;\',./ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'))),~Scrubs.valid_text.fn_nonprintable_chars(s)<1);
EXPORT InValidMessageFT_invalid_status(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotInChars(' !#&*()+-:;\',./ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'),SALT37.HygieneErrors.CustomFail('Scrubs.valid_text.fn_nonprintable_chars'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_name_order(SALT37.StrType s0) := FUNCTION
  s1 := SALT37.stringfilter(s0,'FLM'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_name_order(SALT37.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT37.StringFilter(s,'FLM'))));
EXPORT InValidMessageFT_invalid_name_order(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotInChars('FLM'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_orig_city(SALT37.StrType s0) := FUNCTION
  s1 := SALT37.stringfilter(s0,' #&()_-\',./ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_orig_city(SALT37.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT37.StringFilter(s,' #&()_-\',./ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'))),~Scrubs.valid_text.fn_latin_nonprintable_chars(s)<1);
EXPORT InValidMessageFT_invalid_orig_city(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotInChars(' #&()_-\',./ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'),SALT37.HygieneErrors.CustomFail('Scrubs.valid_text.fn_latin_nonprintable_chars'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_orig_zip(SALT37.StrType s0) := FUNCTION
  s1 := SALT37.stringfilter(s0,' _+-./ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_orig_zip(SALT37.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT37.StringFilter(s,' _+-./ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'))),~Scrubs.valid_text.fn_nonprintable_chars(s)<1);
EXPORT InValidMessageFT_invalid_orig_zip(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotInChars(' _+-./ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'),SALT37.HygieneErrors.CustomFail('Scrubs.valid_text.fn_nonprintable_chars'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_phone(SALT37.StrType s0) := FUNCTION
  s1 := SALT37.stringfilter(s0,' _+ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_phone(SALT37.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT37.StringFilter(s,' _+ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'))),~Scrubs.valid_text.fn_nonprintable_chars(s)<1);
EXPORT InValidMessageFT_invalid_phone(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotInChars(' _+ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'),SALT37.HygieneErrors.CustomFail('Scrubs.valid_text.fn_nonprintable_chars'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_sex(SALT37.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_sex(SALT37.StrType s) := WHICH(((SALT37.StrType) s) NOT IN [' ','M','MALE','F','FEMALE']);
EXPORT InValidMessageFT_invalid_sex(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotInEnum(' |M|MALE|F|FEMALE'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_license_obtained_by(SALT37.StrType s0) := FUNCTION
  s1 := SALT37.stringfilter(s0,' %()_-:;\',./ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_license_obtained_by(SALT37.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT37.StringFilter(s,' %()_-:;\',./ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'))),~Scrubs.valid_text.fn_nonprintable_chars(s)<1);
EXPORT InValidMessageFT_invalid_license_obtained_by(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotInChars(' %()_-:;\',./ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'),SALT37.HygieneErrors.CustomFail('Scrubs.valid_text.fn_nonprintable_chars'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_vendor(SALT37.StrType s0) := FUNCTION
  s1 := SALT37.stringfilter(s0,' &()_-\',./ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_vendor(SALT37.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT37.StringFilter(s,' &()_-\',./ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'))),~Scrubs.valid_text.fn_nonprintable_chars(s)<1);
EXPORT InValidMessageFT_invalid_vendor(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotInChars(' &()_-\',./ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'),SALT37.HygieneErrors.CustomFail('Scrubs.valid_text.fn_nonprintable_chars'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_action_case_number(SALT37.StrType s0) := FUNCTION
  s1 := SALT37.stringfilter(s0,' #&*()-[]:;,./ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_action_case_number(SALT37.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT37.StringFilter(s,' #&*()-[]:;,./ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'))),~Scrubs.valid_text.fn_nonprintable_chars(s)<1);
EXPORT InValidMessageFT_invalid_action_case_number(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotInChars(' #&*()-[]:;,./ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'),SALT37.HygieneErrors.CustomFail('Scrubs.valid_text.fn_nonprintable_chars'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_action_status(SALT37.StrType s0) := FUNCTION
  s1 := SALT37.stringfilter(s0,' &-ABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_action_status(SALT37.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT37.StringFilter(s,' &-ABCDEFGHIJKLMNOPQRSTUVWXYZ'))),~Scrubs.valid_text.fn_nonprintable_chars(s)<1);
EXPORT InValidMessageFT_invalid_action_status(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotInChars(' &-ABCDEFGHIJKLMNOPQRSTUVWXYZ'),SALT37.HygieneErrors.CustomFail('Scrubs.valid_text.fn_nonprintable_chars'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_additional_name_addr_type(SALT37.StrType s0) := FUNCTION
  s1 := SALT37.stringfilter(s0,' .ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_additional_name_addr_type(SALT37.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT37.StringFilter(s,' .ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'))),~Scrubs.valid_text.fn_nonprintable_chars(s)<1);
EXPORT InValidMessageFT_invalid_additional_name_addr_type(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotInChars(' .ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'),SALT37.HygieneErrors.CustomFail('Scrubs.valid_text.fn_nonprintable_chars'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_additional_phone(SALT37.StrType s0) := FUNCTION
  s1 := SALT37.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_additional_phone(SALT37.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT37.StringFilter(s,'0123456789'))),~Scrubs.valid_text.fn_nonprintable_chars(s)<1,~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 10));
EXPORT InValidMessageFT_invalid_additional_phone(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotInChars('0123456789'),SALT37.HygieneErrors.CustomFail('Scrubs.valid_text.fn_nonprintable_chars'),SALT37.HygieneErrors.NotLength('0,10'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_misc_occupation(SALT37.StrType s0) := FUNCTION
  s1 := SALT37.stringfilter(s0,' &()-;\',./ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_misc_occupation(SALT37.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT37.StringFilter(s,' &()-;\',./ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'))),~Scrubs.valid_text.fn_nonprintable_chars(s)<1);
EXPORT InValidMessageFT_invalid_misc_occupation(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotInChars(' &()-;\',./ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'),SALT37.HygieneErrors.CustomFail('Scrubs.valid_text.fn_nonprintable_chars'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_misc_practice_hours(SALT37.StrType s0) := FUNCTION
  s1 := SALT37.stringfilter(s0,' +-:ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_misc_practice_hours(SALT37.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT37.StringFilter(s,' +-:ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'))),~Scrubs.valid_text.fn_nonprintable_chars(s)<1);
EXPORT InValidMessageFT_invalid_misc_practice_hours(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotInChars(' +-:ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'),SALT37.HygieneErrors.CustomFail('Scrubs.valid_text.fn_nonprintable_chars'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_misc_practice_type(SALT37.StrType s0) := FUNCTION
  s1 := SALT37.stringfilter(s0,' #&*()-{}|[]\\;\',./ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_misc_practice_type(SALT37.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT37.StringFilter(s,' #&*()-{}|[]\\;\',./ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'))),~Scrubs.valid_text.fn_nonprintable_chars(s)<1);
EXPORT InValidMessageFT_invalid_misc_practice_type(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotInChars(' #&*()-{}|[]\\;\',./ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'),SALT37.HygieneErrors.CustomFail('Scrubs.valid_text.fn_nonprintable_chars'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_misc_web_site(SALT37.StrType s0) := FUNCTION
  s1 := SALT37.stringfilter(s0,'~@#&_-=\\:\'?./ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_misc_web_site(SALT37.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT37.StringFilter(s,'~@#&_-=\\:\'?./ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'))),~Scrubs.valid_text.fn_nonprintable_chars(s)<1);
EXPORT InValidMessageFT_invalid_misc_web_site(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotInChars('~@#&_-=\\:\'?./ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'),SALT37.HygieneErrors.CustomFail('Scrubs.valid_text.fn_nonprintable_chars'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_misc_other_id_type(SALT37.StrType s0) := FUNCTION
  s1 := SALT37.stringfilter(s0,' #-.ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_misc_other_id_type(SALT37.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT37.StringFilter(s,' #-.ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'))),~Scrubs.valid_text.fn_nonprintable_chars(s)<1);
EXPORT InValidMessageFT_invalid_misc_other_id_type(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotInChars(' #-.ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'),SALT37.HygieneErrors.CustomFail('Scrubs.valid_text.fn_nonprintable_chars'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_education_continuing_education(SALT37.StrType s0) := FUNCTION
  s1 := SALT37.stringfilter(s0,' !#%&()+-=:\',?./ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_education_continuing_education(SALT37.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT37.StringFilter(s,' !#%&()+-=:\',?./ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'))),~Scrubs.valid_text.fn_nonprintable_chars(s)<1);
EXPORT InValidMessageFT_invalid_education_continuing_education(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotInChars(' !#%&()+-=:\',?./ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'),SALT37.HygieneErrors.CustomFail('Scrubs.valid_text.fn_nonprintable_chars'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_education_dates_attended(SALT37.StrType s0) := FUNCTION
  s1 := SALT37.stringfilter(s0,' &-:;\',./ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_education_dates_attended(SALT37.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT37.StringFilter(s,' &-:;\',./ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'))),~Scrubs.valid_text.fn_nonprintable_chars(s)<1);
EXPORT InValidMessageFT_invalid_education_dates_attended(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotInChars(' &-:;\',./ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'),SALT37.HygieneErrors.CustomFail('Scrubs.valid_text.fn_nonprintable_chars'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_education_curriculum(SALT37.StrType s0) := FUNCTION
  s1 := SALT37.stringfilter(s0,' &()-./ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_education_curriculum(SALT37.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT37.StringFilter(s,' &()-./ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'))),~Scrubs.valid_text.fn_nonprintable_chars(s)<1);
EXPORT InValidMessageFT_invalid_education_curriculum(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotInChars(' &()-./ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'),SALT37.HygieneErrors.CustomFail('Scrubs.valid_text.fn_nonprintable_chars'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_education_degree(SALT37.StrType s0) := FUNCTION
  s1 := SALT37.stringfilter(s0,' &()-=\\:";\'?,./ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_education_degree(SALT37.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT37.StringFilter(s,' &()-=\\:";\'?,./ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'))),~Scrubs.valid_text.fn_nonprintable_chars(s)<1);
EXPORT InValidMessageFT_invalid_education_degree(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotInChars(' &()-=\\:";\'?,./ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'),SALT37.HygieneErrors.CustomFail('Scrubs.valid_text.fn_nonprintable_chars'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_personal_pob_desc(SALT37.StrType s0) := FUNCTION
  s1 := SALT37.stringfilter(s0,' #()-\\\',./ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_personal_pob_desc(SALT37.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT37.StringFilter(s,' #()-\\\',./ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'))),~Scrubs.valid_text.fn_nonprintable_chars(s)<1);
EXPORT InValidMessageFT_personal_pob_desc(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotInChars(' #()-\\\',./ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'),SALT37.HygieneErrors.CustomFail('Scrubs.valid_text.fn_nonprintable_chars'),SALT37.HygieneErrors.Good);
 
EXPORT SALT37.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'prolic_key','date_first_seen','date_last_seen','profession_or_board','license_type','status','orig_license_number','license_number','previous_license_number','previous_license_type','company_name','orig_name','name_order','orig_former_name','former_name_order','orig_addr_1','orig_addr_2','orig_addr_3','orig_addr_4','orig_city','orig_st','orig_zip','county_str','country_str','business_flag','phone','sex','dob','issue_date','expiration_date','last_renewal_date','license_obtained_by','board_action_indicator','source_st','vendor','action_record_type','action_complaint_violation_cds','action_complaint_violation_desc','action_complaint_violation_dt','action_case_number','action_effective_dt','action_cds','action_desc','action_final_order_no','action_status','action_posting_status_dt','action_original_filename_or_url','additional_name_addr_type','additional_orig_name','additional_name_order','additional_orig_additional_1','additional_orig_additional_2','additional_orig_additional_3','additional_orig_additional_4','additional_orig_city','additional_orig_st','additional_orig_zip','additional_phone','misc_occupation','misc_practice_hours','misc_practice_type','misc_email','misc_fax','misc_web_site','misc_other_id','misc_other_id_type','education_continuing_education','education_1_school_attended','education_1_dates_attended','education_1_curriculum','education_1_degree','education_2_school_attended','education_2_dates_attended','education_2_curriculum','education_2_degree','education_3_school_attended','education_3_dates_attended','education_3_curriculum','education_3_degree','additional_licensing_specifics','personal_pob_cd','personal_pob_desc','personal_race_cd','personal_race_desc','status_status_cds','status_effective_dt','status_renewal_desc','status_other_agency','prim_range','predir','prim_name','suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dpbc','chk_digit','record_type','ace_fips_st','county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','title','fname','mname','lname','name_suffix','pl_score_in','prep_addr_line1','prep_addr_last_line','rawaid','aceaid','county_name','did','score','best_ssn','bdid','source_rec_id','dotid','dotscore','dotweight','empid','empscore','empweight','powid','powscore','powweight','proxid','proxscore','proxweight','seleid','selescore','seleweight','orgid','orgscore','orgweight','ultid','ultscore','ultweight','lnpid');
EXPORT FieldNum(SALT37.StrType fn) := CASE(fn,'prolic_key' => 0,'date_first_seen' => 1,'date_last_seen' => 2,'profession_or_board' => 3,'license_type' => 4,'status' => 5,'orig_license_number' => 6,'license_number' => 7,'previous_license_number' => 8,'previous_license_type' => 9,'company_name' => 10,'orig_name' => 11,'name_order' => 12,'orig_former_name' => 13,'former_name_order' => 14,'orig_addr_1' => 15,'orig_addr_2' => 16,'orig_addr_3' => 17,'orig_addr_4' => 18,'orig_city' => 19,'orig_st' => 20,'orig_zip' => 21,'county_str' => 22,'country_str' => 23,'business_flag' => 24,'phone' => 25,'sex' => 26,'dob' => 27,'issue_date' => 28,'expiration_date' => 29,'last_renewal_date' => 30,'license_obtained_by' => 31,'board_action_indicator' => 32,'source_st' => 33,'vendor' => 34,'action_record_type' => 35,'action_complaint_violation_cds' => 36,'action_complaint_violation_desc' => 37,'action_complaint_violation_dt' => 38,'action_case_number' => 39,'action_effective_dt' => 40,'action_cds' => 41,'action_desc' => 42,'action_final_order_no' => 43,'action_status' => 44,'action_posting_status_dt' => 45,'action_original_filename_or_url' => 46,'additional_name_addr_type' => 47,'additional_orig_name' => 48,'additional_name_order' => 49,'additional_orig_additional_1' => 50,'additional_orig_additional_2' => 51,'additional_orig_additional_3' => 52,'additional_orig_additional_4' => 53,'additional_orig_city' => 54,'additional_orig_st' => 55,'additional_orig_zip' => 56,'additional_phone' => 57,'misc_occupation' => 58,'misc_practice_hours' => 59,'misc_practice_type' => 60,'misc_email' => 61,'misc_fax' => 62,'misc_web_site' => 63,'misc_other_id' => 64,'misc_other_id_type' => 65,'education_continuing_education' => 66,'education_1_school_attended' => 67,'education_1_dates_attended' => 68,'education_1_curriculum' => 69,'education_1_degree' => 70,'education_2_school_attended' => 71,'education_2_dates_attended' => 72,'education_2_curriculum' => 73,'education_2_degree' => 74,'education_3_school_attended' => 75,'education_3_dates_attended' => 76,'education_3_curriculum' => 77,'education_3_degree' => 78,'additional_licensing_specifics' => 79,'personal_pob_cd' => 80,'personal_pob_desc' => 81,'personal_race_cd' => 82,'personal_race_desc' => 83,'status_status_cds' => 84,'status_effective_dt' => 85,'status_renewal_desc' => 86,'status_other_agency' => 87,'prim_range' => 88,'predir' => 89,'prim_name' => 90,'suffix' => 91,'postdir' => 92,'unit_desig' => 93,'sec_range' => 94,'p_city_name' => 95,'v_city_name' => 96,'st' => 97,'zip' => 98,'zip4' => 99,'cart' => 100,'cr_sort_sz' => 101,'lot' => 102,'lot_order' => 103,'dpbc' => 104,'chk_digit' => 105,'record_type' => 106,'ace_fips_st' => 107,'county' => 108,'geo_lat' => 109,'geo_long' => 110,'msa' => 111,'geo_blk' => 112,'geo_match' => 113,'err_stat' => 114,'title' => 115,'fname' => 116,'mname' => 117,'lname' => 118,'name_suffix' => 119,'pl_score_in' => 120,'prep_addr_line1' => 121,'prep_addr_last_line' => 122,'rawaid' => 123,'aceaid' => 124,'county_name' => 125,'did' => 126,'score' => 127,'best_ssn' => 128,'bdid' => 129,'source_rec_id' => 130,'dotid' => 131,'dotscore' => 132,'dotweight' => 133,'empid' => 134,'empscore' => 135,'empweight' => 136,'powid' => 137,'powscore' => 138,'powweight' => 139,'proxid' => 140,'proxscore' => 141,'proxweight' => 142,'seleid' => 143,'selescore' => 144,'seleweight' => 145,'orgid' => 146,'orgscore' => 147,'orgweight' => 148,'ultid' => 149,'ultscore' => 150,'ultweight' => 151,'lnpid' => 152,0);
 
//Individual field level validation
 
EXPORT Make_prolic_key(SALT37.StrType s0) := MakeFT_invalid_prolic_key(s0);
EXPORT InValid_prolic_key(SALT37.StrType s) := InValidFT_invalid_prolic_key(s);
EXPORT InValidMessage_prolic_key(UNSIGNED1 wh) := InValidMessageFT_invalid_prolic_key(wh);
 
EXPORT Make_date_first_seen(SALT37.StrType s0) := MakeFT_invalid_068pastdate(s0);
EXPORT InValid_date_first_seen(SALT37.StrType s) := InValidFT_invalid_068pastdate(s);
EXPORT InValidMessage_date_first_seen(UNSIGNED1 wh) := InValidMessageFT_invalid_068pastdate(wh);
 
EXPORT Make_date_last_seen(SALT37.StrType s0) := MakeFT_invalid_068pastdate(s0);
EXPORT InValid_date_last_seen(SALT37.StrType s) := InValidFT_invalid_068pastdate(s);
EXPORT InValidMessage_date_last_seen(UNSIGNED1 wh) := InValidMessageFT_invalid_068pastdate(wh);
 
EXPORT Make_profession_or_board(SALT37.StrType s0) := MakeFT_invalid_profession_or_board(s0);
EXPORT InValid_profession_or_board(SALT37.StrType s) := InValidFT_invalid_profession_or_board(s);
EXPORT InValidMessage_profession_or_board(UNSIGNED1 wh) := InValidMessageFT_invalid_profession_or_board(wh);
 
EXPORT Make_license_type(SALT37.StrType s0) := MakeFT_invalid_license_type(s0);
EXPORT InValid_license_type(SALT37.StrType s) := InValidFT_invalid_license_type(s);
EXPORT InValidMessage_license_type(UNSIGNED1 wh) := InValidMessageFT_invalid_license_type(wh);
 
EXPORT Make_status(SALT37.StrType s0) := MakeFT_invalid_status(s0);
EXPORT InValid_status(SALT37.StrType s) := InValidFT_invalid_status(s);
EXPORT InValidMessage_status(UNSIGNED1 wh) := InValidMessageFT_invalid_status(wh);
 
EXPORT Make_orig_license_number(SALT37.StrType s0) := MakeFT_invalid_prolic_key(s0);
EXPORT InValid_orig_license_number(SALT37.StrType s) := InValidFT_invalid_prolic_key(s);
EXPORT InValidMessage_orig_license_number(UNSIGNED1 wh) := InValidMessageFT_invalid_prolic_key(wh);
 
EXPORT Make_license_number(SALT37.StrType s0) := MakeFT_invalid_prolic_key(s0);
EXPORT InValid_license_number(SALT37.StrType s) := InValidFT_invalid_prolic_key(s);
EXPORT InValidMessage_license_number(UNSIGNED1 wh) := InValidMessageFT_invalid_prolic_key(wh);
 
EXPORT Make_previous_license_number(SALT37.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_previous_license_number(SALT37.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_previous_license_number(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_previous_license_type(SALT37.StrType s0) := MakeFT_invalid_license_type(s0);
EXPORT InValid_previous_license_type(SALT37.StrType s) := InValidFT_invalid_license_type(s);
EXPORT InValidMessage_previous_license_type(UNSIGNED1 wh) := InValidMessageFT_invalid_license_type(wh);
 
EXPORT Make_company_name(SALT37.StrType s0) := s0;
EXPORT InValid_company_name(SALT37.StrType s) := 0;
EXPORT InValidMessage_company_name(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_name(SALT37.StrType s0) := s0;
EXPORT InValid_orig_name(SALT37.StrType s) := 0;
EXPORT InValidMessage_orig_name(UNSIGNED1 wh) := '';
 
EXPORT Make_name_order(SALT37.StrType s0) := MakeFT_invalid_name_order(s0);
EXPORT InValid_name_order(SALT37.StrType s) := InValidFT_invalid_name_order(s);
EXPORT InValidMessage_name_order(UNSIGNED1 wh) := InValidMessageFT_invalid_name_order(wh);
 
EXPORT Make_orig_former_name(SALT37.StrType s0) := s0;
EXPORT InValid_orig_former_name(SALT37.StrType s) := 0;
EXPORT InValidMessage_orig_former_name(UNSIGNED1 wh) := '';
 
EXPORT Make_former_name_order(SALT37.StrType s0) := MakeFT_invalid_name_order(s0);
EXPORT InValid_former_name_order(SALT37.StrType s) := InValidFT_invalid_name_order(s);
EXPORT InValidMessage_former_name_order(UNSIGNED1 wh) := InValidMessageFT_invalid_name_order(wh);
 
EXPORT Make_orig_addr_1(SALT37.StrType s0) := s0;
EXPORT InValid_orig_addr_1(SALT37.StrType s) := 0;
EXPORT InValidMessage_orig_addr_1(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_addr_2(SALT37.StrType s0) := s0;
EXPORT InValid_orig_addr_2(SALT37.StrType s) := 0;
EXPORT InValidMessage_orig_addr_2(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_addr_3(SALT37.StrType s0) := s0;
EXPORT InValid_orig_addr_3(SALT37.StrType s) := 0;
EXPORT InValidMessage_orig_addr_3(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_addr_4(SALT37.StrType s0) := s0;
EXPORT InValid_orig_addr_4(SALT37.StrType s) := 0;
EXPORT InValidMessage_orig_addr_4(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_city(SALT37.StrType s0) := MakeFT_invalid_orig_city(s0);
EXPORT InValid_orig_city(SALT37.StrType s) := InValidFT_invalid_orig_city(s);
EXPORT InValidMessage_orig_city(UNSIGNED1 wh) := InValidMessageFT_invalid_orig_city(wh);
 
EXPORT Make_orig_st(SALT37.StrType s0) := MakeFT_invalid_alpha(s0);
EXPORT InValid_orig_st(SALT37.StrType s) := InValidFT_invalid_alpha(s);
EXPORT InValidMessage_orig_st(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha(wh);
 
EXPORT Make_orig_zip(SALT37.StrType s0) := MakeFT_invalid_orig_zip(s0);
EXPORT InValid_orig_zip(SALT37.StrType s) := InValidFT_invalid_orig_zip(s);
EXPORT InValidMessage_orig_zip(UNSIGNED1 wh) := InValidMessageFT_invalid_orig_zip(wh);
 
EXPORT Make_county_str(SALT37.StrType s0) := s0;
EXPORT InValid_county_str(SALT37.StrType s) := 0;
EXPORT InValidMessage_county_str(UNSIGNED1 wh) := '';
 
EXPORT Make_country_str(SALT37.StrType s0) := s0;
EXPORT InValid_country_str(SALT37.StrType s) := 0;
EXPORT InValidMessage_country_str(UNSIGNED1 wh) := '';
 
EXPORT Make_business_flag(SALT37.StrType s0) := MakeFT_invalid_yn(s0);
EXPORT InValid_business_flag(SALT37.StrType s) := InValidFT_invalid_yn(s);
EXPORT InValidMessage_business_flag(UNSIGNED1 wh) := InValidMessageFT_invalid_yn(wh);
 
EXPORT Make_phone(SALT37.StrType s0) := MakeFT_invalid_phone(s0);
EXPORT InValid_phone(SALT37.StrType s) := InValidFT_invalid_phone(s);
EXPORT InValidMessage_phone(UNSIGNED1 wh) := InValidMessageFT_invalid_phone(wh);
 
EXPORT Make_sex(SALT37.StrType s0) := MakeFT_invalid_sex(s0);
EXPORT InValid_sex(SALT37.StrType s) := InValidFT_invalid_sex(s);
EXPORT InValidMessage_sex(UNSIGNED1 wh) := InValidMessageFT_invalid_sex(wh);
 
EXPORT Make_dob(SALT37.StrType s0) := MakeFT_invalid_0468pastdate(s0);
EXPORT InValid_dob(SALT37.StrType s) := InValidFT_invalid_0468pastdate(s);
EXPORT InValidMessage_dob(UNSIGNED1 wh) := InValidMessageFT_invalid_0468pastdate(wh);
 
EXPORT Make_issue_date(SALT37.StrType s0) := MakeFT_invalid_0468date(s0);
EXPORT InValid_issue_date(SALT37.StrType s) := InValidFT_invalid_0468date(s);
EXPORT InValidMessage_issue_date(UNSIGNED1 wh) := InValidMessageFT_invalid_0468date(wh);
 
EXPORT Make_expiration_date(SALT37.StrType s0) := MakeFT_invalid_0468date(s0);
EXPORT InValid_expiration_date(SALT37.StrType s) := InValidFT_invalid_0468date(s);
EXPORT InValidMessage_expiration_date(UNSIGNED1 wh) := InValidMessageFT_invalid_0468date(wh);
 
EXPORT Make_last_renewal_date(SALT37.StrType s0) := MakeFT_invalid_past_date(s0);
EXPORT InValid_last_renewal_date(SALT37.StrType s) := InValidFT_invalid_past_date(s);
EXPORT InValidMessage_last_renewal_date(UNSIGNED1 wh) := InValidMessageFT_invalid_past_date(wh);
 
EXPORT Make_license_obtained_by(SALT37.StrType s0) := MakeFT_invalid_license_obtained_by(s0);
EXPORT InValid_license_obtained_by(SALT37.StrType s) := InValidFT_invalid_license_obtained_by(s);
EXPORT InValidMessage_license_obtained_by(UNSIGNED1 wh) := InValidMessageFT_invalid_license_obtained_by(wh);
 
EXPORT Make_board_action_indicator(SALT37.StrType s0) := MakeFT_invalid_yn(s0);
EXPORT InValid_board_action_indicator(SALT37.StrType s) := InValidFT_invalid_yn(s);
EXPORT InValidMessage_board_action_indicator(UNSIGNED1 wh) := InValidMessageFT_invalid_yn(wh);
 
EXPORT Make_source_st(SALT37.StrType s0) := MakeFT_invalid_alpha(s0);
EXPORT InValid_source_st(SALT37.StrType s) := InValidFT_invalid_alpha(s);
EXPORT InValidMessage_source_st(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha(wh);
 
EXPORT Make_vendor(SALT37.StrType s0) := MakeFT_invalid_vendor(s0);
EXPORT InValid_vendor(SALT37.StrType s) := InValidFT_invalid_vendor(s);
EXPORT InValidMessage_vendor(UNSIGNED1 wh) := InValidMessageFT_invalid_vendor(wh);
 
EXPORT Make_action_record_type(SALT37.StrType s0) := MakeFT_invalid_nonprintable(s0);
EXPORT InValid_action_record_type(SALT37.StrType s) := InValidFT_invalid_nonprintable(s);
EXPORT InValidMessage_action_record_type(UNSIGNED1 wh) := InValidMessageFT_invalid_nonprintable(wh);
 
EXPORT Make_action_complaint_violation_cds(SALT37.StrType s0) := MakeFT_invalid_nonprintable(s0);
EXPORT InValid_action_complaint_violation_cds(SALT37.StrType s) := InValidFT_invalid_nonprintable(s);
EXPORT InValidMessage_action_complaint_violation_cds(UNSIGNED1 wh) := InValidMessageFT_invalid_nonprintable(wh);
 
EXPORT Make_action_complaint_violation_desc(SALT37.StrType s0) := s0;
EXPORT InValid_action_complaint_violation_desc(SALT37.StrType s) := 0;
EXPORT InValidMessage_action_complaint_violation_desc(UNSIGNED1 wh) := '';
 
EXPORT Make_action_complaint_violation_dt(SALT37.StrType s0) := MakeFT_invalid_past_date(s0);
EXPORT InValid_action_complaint_violation_dt(SALT37.StrType s) := InValidFT_invalid_past_date(s);
EXPORT InValidMessage_action_complaint_violation_dt(UNSIGNED1 wh) := InValidMessageFT_invalid_past_date(wh);
 
EXPORT Make_action_case_number(SALT37.StrType s0) := MakeFT_invalid_action_case_number(s0);
EXPORT InValid_action_case_number(SALT37.StrType s) := InValidFT_invalid_action_case_number(s);
EXPORT InValidMessage_action_case_number(UNSIGNED1 wh) := InValidMessageFT_invalid_action_case_number(wh);
 
EXPORT Make_action_effective_dt(SALT37.StrType s0) := MakeFT_invalid_past_date(s0);
EXPORT InValid_action_effective_dt(SALT37.StrType s) := InValidFT_invalid_past_date(s);
EXPORT InValidMessage_action_effective_dt(UNSIGNED1 wh) := InValidMessageFT_invalid_past_date(wh);
 
EXPORT Make_action_cds(SALT37.StrType s0) := MakeFT_invalid_alpha(s0);
EXPORT InValid_action_cds(SALT37.StrType s) := InValidFT_invalid_alpha(s);
EXPORT InValidMessage_action_cds(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha(wh);
 
EXPORT Make_action_desc(SALT37.StrType s0) := s0;
EXPORT InValid_action_desc(SALT37.StrType s) := 0;
EXPORT InValidMessage_action_desc(UNSIGNED1 wh) := '';
 
EXPORT Make_action_final_order_no(SALT37.StrType s0) := MakeFT_invalid_nonprintable(s0);
EXPORT InValid_action_final_order_no(SALT37.StrType s) := InValidFT_invalid_nonprintable(s);
EXPORT InValidMessage_action_final_order_no(UNSIGNED1 wh) := InValidMessageFT_invalid_nonprintable(wh);
 
EXPORT Make_action_status(SALT37.StrType s0) := MakeFT_invalid_action_status(s0);
EXPORT InValid_action_status(SALT37.StrType s) := InValidFT_invalid_action_status(s);
EXPORT InValidMessage_action_status(UNSIGNED1 wh) := InValidMessageFT_invalid_action_status(wh);
 
EXPORT Make_action_posting_status_dt(SALT37.StrType s0) := MakeFT_invalid_past_date(s0);
EXPORT InValid_action_posting_status_dt(SALT37.StrType s) := InValidFT_invalid_past_date(s);
EXPORT InValidMessage_action_posting_status_dt(UNSIGNED1 wh) := InValidMessageFT_invalid_past_date(wh);
 
EXPORT Make_action_original_filename_or_url(SALT37.StrType s0) := s0;
EXPORT InValid_action_original_filename_or_url(SALT37.StrType s) := 0;
EXPORT InValidMessage_action_original_filename_or_url(UNSIGNED1 wh) := '';
 
EXPORT Make_additional_name_addr_type(SALT37.StrType s0) := MakeFT_invalid_additional_name_addr_type(s0);
EXPORT InValid_additional_name_addr_type(SALT37.StrType s) := InValidFT_invalid_additional_name_addr_type(s);
EXPORT InValidMessage_additional_name_addr_type(UNSIGNED1 wh) := InValidMessageFT_invalid_additional_name_addr_type(wh);
 
EXPORT Make_additional_orig_name(SALT37.StrType s0) := s0;
EXPORT InValid_additional_orig_name(SALT37.StrType s) := 0;
EXPORT InValidMessage_additional_orig_name(UNSIGNED1 wh) := '';
 
EXPORT Make_additional_name_order(SALT37.StrType s0) := MakeFT_invalid_name_order(s0);
EXPORT InValid_additional_name_order(SALT37.StrType s) := InValidFT_invalid_name_order(s);
EXPORT InValidMessage_additional_name_order(UNSIGNED1 wh) := InValidMessageFT_invalid_name_order(wh);
 
EXPORT Make_additional_orig_additional_1(SALT37.StrType s0) := s0;
EXPORT InValid_additional_orig_additional_1(SALT37.StrType s) := 0;
EXPORT InValidMessage_additional_orig_additional_1(UNSIGNED1 wh) := '';
 
EXPORT Make_additional_orig_additional_2(SALT37.StrType s0) := s0;
EXPORT InValid_additional_orig_additional_2(SALT37.StrType s) := 0;
EXPORT InValidMessage_additional_orig_additional_2(UNSIGNED1 wh) := '';
 
EXPORT Make_additional_orig_additional_3(SALT37.StrType s0) := s0;
EXPORT InValid_additional_orig_additional_3(SALT37.StrType s) := 0;
EXPORT InValidMessage_additional_orig_additional_3(UNSIGNED1 wh) := '';
 
EXPORT Make_additional_orig_additional_4(SALT37.StrType s0) := s0;
EXPORT InValid_additional_orig_additional_4(SALT37.StrType s) := 0;
EXPORT InValidMessage_additional_orig_additional_4(UNSIGNED1 wh) := '';
 
EXPORT Make_additional_orig_city(SALT37.StrType s0) := MakeFT_invalid_orig_city(s0);
EXPORT InValid_additional_orig_city(SALT37.StrType s) := InValidFT_invalid_orig_city(s);
EXPORT InValidMessage_additional_orig_city(UNSIGNED1 wh) := InValidMessageFT_invalid_orig_city(wh);
 
EXPORT Make_additional_orig_st(SALT37.StrType s0) := MakeFT_invalid_alpha(s0);
EXPORT InValid_additional_orig_st(SALT37.StrType s) := InValidFT_invalid_alpha(s);
EXPORT InValidMessage_additional_orig_st(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha(wh);
 
EXPORT Make_additional_orig_zip(SALT37.StrType s0) := MakeFT_invalid_orig_zip(s0);
EXPORT InValid_additional_orig_zip(SALT37.StrType s) := InValidFT_invalid_orig_zip(s);
EXPORT InValidMessage_additional_orig_zip(UNSIGNED1 wh) := InValidMessageFT_invalid_orig_zip(wh);
 
EXPORT Make_additional_phone(SALT37.StrType s0) := MakeFT_invalid_additional_phone(s0);
EXPORT InValid_additional_phone(SALT37.StrType s) := InValidFT_invalid_additional_phone(s);
EXPORT InValidMessage_additional_phone(UNSIGNED1 wh) := InValidMessageFT_invalid_additional_phone(wh);
 
EXPORT Make_misc_occupation(SALT37.StrType s0) := MakeFT_invalid_misc_occupation(s0);
EXPORT InValid_misc_occupation(SALT37.StrType s) := InValidFT_invalid_misc_occupation(s);
EXPORT InValidMessage_misc_occupation(UNSIGNED1 wh) := InValidMessageFT_invalid_misc_occupation(wh);
 
EXPORT Make_misc_practice_hours(SALT37.StrType s0) := MakeFT_invalid_misc_practice_hours(s0);
EXPORT InValid_misc_practice_hours(SALT37.StrType s) := InValidFT_invalid_misc_practice_hours(s);
EXPORT InValidMessage_misc_practice_hours(UNSIGNED1 wh) := InValidMessageFT_invalid_misc_practice_hours(wh);
 
EXPORT Make_misc_practice_type(SALT37.StrType s0) := MakeFT_invalid_misc_practice_type(s0);
EXPORT InValid_misc_practice_type(SALT37.StrType s) := InValidFT_invalid_misc_practice_type(s);
EXPORT InValidMessage_misc_practice_type(UNSIGNED1 wh) := InValidMessageFT_invalid_misc_practice_type(wh);
 
EXPORT Make_misc_email(SALT37.StrType s0) := s0;
EXPORT InValid_misc_email(SALT37.StrType s) := 0;
EXPORT InValidMessage_misc_email(UNSIGNED1 wh) := '';
 
EXPORT Make_misc_fax(SALT37.StrType s0) := MakeFT_invalid_additional_phone(s0);
EXPORT InValid_misc_fax(SALT37.StrType s) := InValidFT_invalid_additional_phone(s);
EXPORT InValidMessage_misc_fax(UNSIGNED1 wh) := InValidMessageFT_invalid_additional_phone(wh);
 
EXPORT Make_misc_web_site(SALT37.StrType s0) := MakeFT_invalid_misc_web_site(s0);
EXPORT InValid_misc_web_site(SALT37.StrType s) := InValidFT_invalid_misc_web_site(s);
EXPORT InValidMessage_misc_web_site(UNSIGNED1 wh) := InValidMessageFT_invalid_misc_web_site(wh);
 
EXPORT Make_misc_other_id(SALT37.StrType s0) := MakeFT_invalid_nonprintable(s0);
EXPORT InValid_misc_other_id(SALT37.StrType s) := InValidFT_invalid_nonprintable(s);
EXPORT InValidMessage_misc_other_id(UNSIGNED1 wh) := InValidMessageFT_invalid_nonprintable(wh);
 
EXPORT Make_misc_other_id_type(SALT37.StrType s0) := MakeFT_invalid_misc_other_id_type(s0);
EXPORT InValid_misc_other_id_type(SALT37.StrType s) := InValidFT_invalid_misc_other_id_type(s);
EXPORT InValidMessage_misc_other_id_type(UNSIGNED1 wh) := InValidMessageFT_invalid_misc_other_id_type(wh);
 
EXPORT Make_education_continuing_education(SALT37.StrType s0) := MakeFT_invalid_education_continuing_education(s0);
EXPORT InValid_education_continuing_education(SALT37.StrType s) := InValidFT_invalid_education_continuing_education(s);
EXPORT InValidMessage_education_continuing_education(UNSIGNED1 wh) := InValidMessageFT_invalid_education_continuing_education(wh);
 
EXPORT Make_education_1_school_attended(SALT37.StrType s0) := s0;
EXPORT InValid_education_1_school_attended(SALT37.StrType s) := 0;
EXPORT InValidMessage_education_1_school_attended(UNSIGNED1 wh) := '';
 
EXPORT Make_education_1_dates_attended(SALT37.StrType s0) := MakeFT_invalid_education_dates_attended(s0);
EXPORT InValid_education_1_dates_attended(SALT37.StrType s) := InValidFT_invalid_education_dates_attended(s);
EXPORT InValidMessage_education_1_dates_attended(UNSIGNED1 wh) := InValidMessageFT_invalid_education_dates_attended(wh);
 
EXPORT Make_education_1_curriculum(SALT37.StrType s0) := MakeFT_invalid_education_curriculum(s0);
EXPORT InValid_education_1_curriculum(SALT37.StrType s) := InValidFT_invalid_education_curriculum(s);
EXPORT InValidMessage_education_1_curriculum(UNSIGNED1 wh) := InValidMessageFT_invalid_education_curriculum(wh);
 
EXPORT Make_education_1_degree(SALT37.StrType s0) := MakeFT_invalid_education_degree(s0);
EXPORT InValid_education_1_degree(SALT37.StrType s) := InValidFT_invalid_education_degree(s);
EXPORT InValidMessage_education_1_degree(UNSIGNED1 wh) := InValidMessageFT_invalid_education_degree(wh);
 
EXPORT Make_education_2_school_attended(SALT37.StrType s0) := s0;
EXPORT InValid_education_2_school_attended(SALT37.StrType s) := 0;
EXPORT InValidMessage_education_2_school_attended(UNSIGNED1 wh) := '';
 
EXPORT Make_education_2_dates_attended(SALT37.StrType s0) := MakeFT_invalid_education_dates_attended(s0);
EXPORT InValid_education_2_dates_attended(SALT37.StrType s) := InValidFT_invalid_education_dates_attended(s);
EXPORT InValidMessage_education_2_dates_attended(UNSIGNED1 wh) := InValidMessageFT_invalid_education_dates_attended(wh);
 
EXPORT Make_education_2_curriculum(SALT37.StrType s0) := MakeFT_invalid_education_curriculum(s0);
EXPORT InValid_education_2_curriculum(SALT37.StrType s) := InValidFT_invalid_education_curriculum(s);
EXPORT InValidMessage_education_2_curriculum(UNSIGNED1 wh) := InValidMessageFT_invalid_education_curriculum(wh);
 
EXPORT Make_education_2_degree(SALT37.StrType s0) := MakeFT_invalid_education_degree(s0);
EXPORT InValid_education_2_degree(SALT37.StrType s) := InValidFT_invalid_education_degree(s);
EXPORT InValidMessage_education_2_degree(UNSIGNED1 wh) := InValidMessageFT_invalid_education_degree(wh);
 
EXPORT Make_education_3_school_attended(SALT37.StrType s0) := s0;
EXPORT InValid_education_3_school_attended(SALT37.StrType s) := 0;
EXPORT InValidMessage_education_3_school_attended(UNSIGNED1 wh) := '';
 
EXPORT Make_education_3_dates_attended(SALT37.StrType s0) := MakeFT_invalid_education_dates_attended(s0);
EXPORT InValid_education_3_dates_attended(SALT37.StrType s) := InValidFT_invalid_education_dates_attended(s);
EXPORT InValidMessage_education_3_dates_attended(UNSIGNED1 wh) := InValidMessageFT_invalid_education_dates_attended(wh);
 
EXPORT Make_education_3_curriculum(SALT37.StrType s0) := MakeFT_invalid_education_curriculum(s0);
EXPORT InValid_education_3_curriculum(SALT37.StrType s) := InValidFT_invalid_education_curriculum(s);
EXPORT InValidMessage_education_3_curriculum(UNSIGNED1 wh) := InValidMessageFT_invalid_education_curriculum(wh);
 
EXPORT Make_education_3_degree(SALT37.StrType s0) := MakeFT_invalid_education_degree(s0);
EXPORT InValid_education_3_degree(SALT37.StrType s) := InValidFT_invalid_education_degree(s);
EXPORT InValidMessage_education_3_degree(UNSIGNED1 wh) := InValidMessageFT_invalid_education_degree(wh);
 
EXPORT Make_additional_licensing_specifics(SALT37.StrType s0) := s0;
EXPORT InValid_additional_licensing_specifics(SALT37.StrType s) := 0;
EXPORT InValidMessage_additional_licensing_specifics(UNSIGNED1 wh) := '';
 
EXPORT Make_personal_pob_cd(SALT37.StrType s0) := MakeFT_invalid_alpha(s0);
EXPORT InValid_personal_pob_cd(SALT37.StrType s) := InValidFT_invalid_alpha(s);
EXPORT InValidMessage_personal_pob_cd(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha(wh);
 
EXPORT Make_personal_pob_desc(SALT37.StrType s0) := MakeFT_personal_pob_desc(s0);
EXPORT InValid_personal_pob_desc(SALT37.StrType s) := InValidFT_personal_pob_desc(s);
EXPORT InValidMessage_personal_pob_desc(UNSIGNED1 wh) := InValidMessageFT_personal_pob_desc(wh);
 
EXPORT Make_personal_race_cd(SALT37.StrType s0) := MakeFT_invalid_alphanumeric(s0);
EXPORT InValid_personal_race_cd(SALT37.StrType s) := InValidFT_invalid_alphanumeric(s);
EXPORT InValidMessage_personal_race_cd(UNSIGNED1 wh) := InValidMessageFT_invalid_alphanumeric(wh);
 
EXPORT Make_personal_race_desc(SALT37.StrType s0) := MakeFT_invalid_alphaspaceslash(s0);
EXPORT InValid_personal_race_desc(SALT37.StrType s) := InValidFT_invalid_alphaspaceslash(s);
EXPORT InValidMessage_personal_race_desc(UNSIGNED1 wh) := InValidMessageFT_invalid_alphaspaceslash(wh);
 
EXPORT Make_status_status_cds(SALT37.StrType s0) := MakeFT_invalid_alphanumerichyphen(s0);
EXPORT InValid_status_status_cds(SALT37.StrType s) := InValidFT_invalid_alphanumerichyphen(s);
EXPORT InValidMessage_status_status_cds(UNSIGNED1 wh) := InValidMessageFT_invalid_alphanumerichyphen(wh);
 
EXPORT Make_status_effective_dt(SALT37.StrType s0) := MakeFT_invalid_past_date(s0);
EXPORT InValid_status_effective_dt(SALT37.StrType s) := InValidFT_invalid_past_date(s);
EXPORT InValidMessage_status_effective_dt(UNSIGNED1 wh) := InValidMessageFT_invalid_past_date(wh);
 
EXPORT Make_status_renewal_desc(SALT37.StrType s0) := s0;
EXPORT InValid_status_renewal_desc(SALT37.StrType s) := 0;
EXPORT InValidMessage_status_renewal_desc(UNSIGNED1 wh) := '';
 
EXPORT Make_status_other_agency(SALT37.StrType s0) := s0;
EXPORT InValid_status_other_agency(SALT37.StrType s) := 0;
EXPORT InValidMessage_status_other_agency(UNSIGNED1 wh) := '';
 
EXPORT Make_prim_range(SALT37.StrType s0) := s0;
EXPORT InValid_prim_range(SALT37.StrType s) := 0;
EXPORT InValidMessage_prim_range(UNSIGNED1 wh) := '';
 
EXPORT Make_predir(SALT37.StrType s0) := s0;
EXPORT InValid_predir(SALT37.StrType s) := 0;
EXPORT InValidMessage_predir(UNSIGNED1 wh) := '';
 
EXPORT Make_prim_name(SALT37.StrType s0) := s0;
EXPORT InValid_prim_name(SALT37.StrType s) := 0;
EXPORT InValidMessage_prim_name(UNSIGNED1 wh) := '';
 
EXPORT Make_suffix(SALT37.StrType s0) := s0;
EXPORT InValid_suffix(SALT37.StrType s) := 0;
EXPORT InValidMessage_suffix(UNSIGNED1 wh) := '';
 
EXPORT Make_postdir(SALT37.StrType s0) := s0;
EXPORT InValid_postdir(SALT37.StrType s) := 0;
EXPORT InValidMessage_postdir(UNSIGNED1 wh) := '';
 
EXPORT Make_unit_desig(SALT37.StrType s0) := s0;
EXPORT InValid_unit_desig(SALT37.StrType s) := 0;
EXPORT InValidMessage_unit_desig(UNSIGNED1 wh) := '';
 
EXPORT Make_sec_range(SALT37.StrType s0) := s0;
EXPORT InValid_sec_range(SALT37.StrType s) := 0;
EXPORT InValidMessage_sec_range(UNSIGNED1 wh) := '';
 
EXPORT Make_p_city_name(SALT37.StrType s0) := s0;
EXPORT InValid_p_city_name(SALT37.StrType s) := 0;
EXPORT InValidMessage_p_city_name(UNSIGNED1 wh) := '';
 
EXPORT Make_v_city_name(SALT37.StrType s0) := s0;
EXPORT InValid_v_city_name(SALT37.StrType s) := 0;
EXPORT InValidMessage_v_city_name(UNSIGNED1 wh) := '';
 
EXPORT Make_st(SALT37.StrType s0) := s0;
EXPORT InValid_st(SALT37.StrType s) := 0;
EXPORT InValidMessage_st(UNSIGNED1 wh) := '';
 
EXPORT Make_zip(SALT37.StrType s0) := s0;
EXPORT InValid_zip(SALT37.StrType s) := 0;
EXPORT InValidMessage_zip(UNSIGNED1 wh) := '';
 
EXPORT Make_zip4(SALT37.StrType s0) := s0;
EXPORT InValid_zip4(SALT37.StrType s) := 0;
EXPORT InValidMessage_zip4(UNSIGNED1 wh) := '';
 
EXPORT Make_cart(SALT37.StrType s0) := s0;
EXPORT InValid_cart(SALT37.StrType s) := 0;
EXPORT InValidMessage_cart(UNSIGNED1 wh) := '';
 
EXPORT Make_cr_sort_sz(SALT37.StrType s0) := s0;
EXPORT InValid_cr_sort_sz(SALT37.StrType s) := 0;
EXPORT InValidMessage_cr_sort_sz(UNSIGNED1 wh) := '';
 
EXPORT Make_lot(SALT37.StrType s0) := s0;
EXPORT InValid_lot(SALT37.StrType s) := 0;
EXPORT InValidMessage_lot(UNSIGNED1 wh) := '';
 
EXPORT Make_lot_order(SALT37.StrType s0) := s0;
EXPORT InValid_lot_order(SALT37.StrType s) := 0;
EXPORT InValidMessage_lot_order(UNSIGNED1 wh) := '';
 
EXPORT Make_dpbc(SALT37.StrType s0) := s0;
EXPORT InValid_dpbc(SALT37.StrType s) := 0;
EXPORT InValidMessage_dpbc(UNSIGNED1 wh) := '';
 
EXPORT Make_chk_digit(SALT37.StrType s0) := s0;
EXPORT InValid_chk_digit(SALT37.StrType s) := 0;
EXPORT InValidMessage_chk_digit(UNSIGNED1 wh) := '';
 
EXPORT Make_record_type(SALT37.StrType s0) := s0;
EXPORT InValid_record_type(SALT37.StrType s) := 0;
EXPORT InValidMessage_record_type(UNSIGNED1 wh) := '';
 
EXPORT Make_ace_fips_st(SALT37.StrType s0) := s0;
EXPORT InValid_ace_fips_st(SALT37.StrType s) := 0;
EXPORT InValidMessage_ace_fips_st(UNSIGNED1 wh) := '';
 
EXPORT Make_county(SALT37.StrType s0) := s0;
EXPORT InValid_county(SALT37.StrType s) := 0;
EXPORT InValidMessage_county(UNSIGNED1 wh) := '';
 
EXPORT Make_geo_lat(SALT37.StrType s0) := s0;
EXPORT InValid_geo_lat(SALT37.StrType s) := 0;
EXPORT InValidMessage_geo_lat(UNSIGNED1 wh) := '';
 
EXPORT Make_geo_long(SALT37.StrType s0) := s0;
EXPORT InValid_geo_long(SALT37.StrType s) := 0;
EXPORT InValidMessage_geo_long(UNSIGNED1 wh) := '';
 
EXPORT Make_msa(SALT37.StrType s0) := s0;
EXPORT InValid_msa(SALT37.StrType s) := 0;
EXPORT InValidMessage_msa(UNSIGNED1 wh) := '';
 
EXPORT Make_geo_blk(SALT37.StrType s0) := s0;
EXPORT InValid_geo_blk(SALT37.StrType s) := 0;
EXPORT InValidMessage_geo_blk(UNSIGNED1 wh) := '';
 
EXPORT Make_geo_match(SALT37.StrType s0) := s0;
EXPORT InValid_geo_match(SALT37.StrType s) := 0;
EXPORT InValidMessage_geo_match(UNSIGNED1 wh) := '';
 
EXPORT Make_err_stat(SALT37.StrType s0) := s0;
EXPORT InValid_err_stat(SALT37.StrType s) := 0;
EXPORT InValidMessage_err_stat(UNSIGNED1 wh) := '';
 
EXPORT Make_title(SALT37.StrType s0) := s0;
EXPORT InValid_title(SALT37.StrType s) := 0;
EXPORT InValidMessage_title(UNSIGNED1 wh) := '';
 
EXPORT Make_fname(SALT37.StrType s0) := s0;
EXPORT InValid_fname(SALT37.StrType s) := 0;
EXPORT InValidMessage_fname(UNSIGNED1 wh) := '';
 
EXPORT Make_mname(SALT37.StrType s0) := s0;
EXPORT InValid_mname(SALT37.StrType s) := 0;
EXPORT InValidMessage_mname(UNSIGNED1 wh) := '';
 
EXPORT Make_lname(SALT37.StrType s0) := s0;
EXPORT InValid_lname(SALT37.StrType s) := 0;
EXPORT InValidMessage_lname(UNSIGNED1 wh) := '';
 
EXPORT Make_name_suffix(SALT37.StrType s0) := s0;
EXPORT InValid_name_suffix(SALT37.StrType s) := 0;
EXPORT InValidMessage_name_suffix(UNSIGNED1 wh) := '';
 
EXPORT Make_pl_score_in(SALT37.StrType s0) := s0;
EXPORT InValid_pl_score_in(SALT37.StrType s) := 0;
EXPORT InValidMessage_pl_score_in(UNSIGNED1 wh) := '';
 
EXPORT Make_prep_addr_line1(SALT37.StrType s0) := s0;
EXPORT InValid_prep_addr_line1(SALT37.StrType s) := 0;
EXPORT InValidMessage_prep_addr_line1(UNSIGNED1 wh) := '';
 
EXPORT Make_prep_addr_last_line(SALT37.StrType s0) := s0;
EXPORT InValid_prep_addr_last_line(SALT37.StrType s) := 0;
EXPORT InValidMessage_prep_addr_last_line(UNSIGNED1 wh) := '';
 
EXPORT Make_rawaid(SALT37.StrType s0) := s0;
EXPORT InValid_rawaid(SALT37.StrType s) := 0;
EXPORT InValidMessage_rawaid(UNSIGNED1 wh) := '';
 
EXPORT Make_aceaid(SALT37.StrType s0) := s0;
EXPORT InValid_aceaid(SALT37.StrType s) := 0;
EXPORT InValidMessage_aceaid(UNSIGNED1 wh) := '';
 
EXPORT Make_county_name(SALT37.StrType s0) := s0;
EXPORT InValid_county_name(SALT37.StrType s) := 0;
EXPORT InValidMessage_county_name(UNSIGNED1 wh) := '';
 
EXPORT Make_did(SALT37.StrType s0) := s0;
EXPORT InValid_did(SALT37.StrType s) := 0;
EXPORT InValidMessage_did(UNSIGNED1 wh) := '';
 
EXPORT Make_score(SALT37.StrType s0) := s0;
EXPORT InValid_score(SALT37.StrType s) := 0;
EXPORT InValidMessage_score(UNSIGNED1 wh) := '';
 
EXPORT Make_best_ssn(SALT37.StrType s0) := s0;
EXPORT InValid_best_ssn(SALT37.StrType s) := 0;
EXPORT InValidMessage_best_ssn(UNSIGNED1 wh) := '';
 
EXPORT Make_bdid(SALT37.StrType s0) := s0;
EXPORT InValid_bdid(SALT37.StrType s) := 0;
EXPORT InValidMessage_bdid(UNSIGNED1 wh) := '';
 
EXPORT Make_source_rec_id(SALT37.StrType s0) := s0;
EXPORT InValid_source_rec_id(SALT37.StrType s) := 0;
EXPORT InValidMessage_source_rec_id(UNSIGNED1 wh) := '';
 
EXPORT Make_dotid(SALT37.StrType s0) := s0;
EXPORT InValid_dotid(SALT37.StrType s) := 0;
EXPORT InValidMessage_dotid(UNSIGNED1 wh) := '';
 
EXPORT Make_dotscore(SALT37.StrType s0) := s0;
EXPORT InValid_dotscore(SALT37.StrType s) := 0;
EXPORT InValidMessage_dotscore(UNSIGNED1 wh) := '';
 
EXPORT Make_dotweight(SALT37.StrType s0) := s0;
EXPORT InValid_dotweight(SALT37.StrType s) := 0;
EXPORT InValidMessage_dotweight(UNSIGNED1 wh) := '';
 
EXPORT Make_empid(SALT37.StrType s0) := s0;
EXPORT InValid_empid(SALT37.StrType s) := 0;
EXPORT InValidMessage_empid(UNSIGNED1 wh) := '';
 
EXPORT Make_empscore(SALT37.StrType s0) := s0;
EXPORT InValid_empscore(SALT37.StrType s) := 0;
EXPORT InValidMessage_empscore(UNSIGNED1 wh) := '';
 
EXPORT Make_empweight(SALT37.StrType s0) := s0;
EXPORT InValid_empweight(SALT37.StrType s) := 0;
EXPORT InValidMessage_empweight(UNSIGNED1 wh) := '';
 
EXPORT Make_powid(SALT37.StrType s0) := s0;
EXPORT InValid_powid(SALT37.StrType s) := 0;
EXPORT InValidMessage_powid(UNSIGNED1 wh) := '';
 
EXPORT Make_powscore(SALT37.StrType s0) := s0;
EXPORT InValid_powscore(SALT37.StrType s) := 0;
EXPORT InValidMessage_powscore(UNSIGNED1 wh) := '';
 
EXPORT Make_powweight(SALT37.StrType s0) := s0;
EXPORT InValid_powweight(SALT37.StrType s) := 0;
EXPORT InValidMessage_powweight(UNSIGNED1 wh) := '';
 
EXPORT Make_proxid(SALT37.StrType s0) := s0;
EXPORT InValid_proxid(SALT37.StrType s) := 0;
EXPORT InValidMessage_proxid(UNSIGNED1 wh) := '';
 
EXPORT Make_proxscore(SALT37.StrType s0) := s0;
EXPORT InValid_proxscore(SALT37.StrType s) := 0;
EXPORT InValidMessage_proxscore(UNSIGNED1 wh) := '';
 
EXPORT Make_proxweight(SALT37.StrType s0) := s0;
EXPORT InValid_proxweight(SALT37.StrType s) := 0;
EXPORT InValidMessage_proxweight(UNSIGNED1 wh) := '';
 
EXPORT Make_seleid(SALT37.StrType s0) := s0;
EXPORT InValid_seleid(SALT37.StrType s) := 0;
EXPORT InValidMessage_seleid(UNSIGNED1 wh) := '';
 
EXPORT Make_selescore(SALT37.StrType s0) := s0;
EXPORT InValid_selescore(SALT37.StrType s) := 0;
EXPORT InValidMessage_selescore(UNSIGNED1 wh) := '';
 
EXPORT Make_seleweight(SALT37.StrType s0) := s0;
EXPORT InValid_seleweight(SALT37.StrType s) := 0;
EXPORT InValidMessage_seleweight(UNSIGNED1 wh) := '';
 
EXPORT Make_orgid(SALT37.StrType s0) := s0;
EXPORT InValid_orgid(SALT37.StrType s) := 0;
EXPORT InValidMessage_orgid(UNSIGNED1 wh) := '';
 
EXPORT Make_orgscore(SALT37.StrType s0) := s0;
EXPORT InValid_orgscore(SALT37.StrType s) := 0;
EXPORT InValidMessage_orgscore(UNSIGNED1 wh) := '';
 
EXPORT Make_orgweight(SALT37.StrType s0) := s0;
EXPORT InValid_orgweight(SALT37.StrType s) := 0;
EXPORT InValidMessage_orgweight(UNSIGNED1 wh) := '';
 
EXPORT Make_ultid(SALT37.StrType s0) := s0;
EXPORT InValid_ultid(SALT37.StrType s) := 0;
EXPORT InValidMessage_ultid(UNSIGNED1 wh) := '';
 
EXPORT Make_ultscore(SALT37.StrType s0) := s0;
EXPORT InValid_ultscore(SALT37.StrType s) := 0;
EXPORT InValidMessage_ultscore(UNSIGNED1 wh) := '';
 
EXPORT Make_ultweight(SALT37.StrType s0) := s0;
EXPORT InValid_ultweight(SALT37.StrType s) := 0;
EXPORT InValidMessage_ultweight(UNSIGNED1 wh) := '';
 
EXPORT Make_lnpid(SALT37.StrType s0) := s0;
EXPORT InValid_lnpid(SALT37.StrType s) := 0;
EXPORT InValidMessage_lnpid(UNSIGNED1 wh) := '';
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT37,Scrubs_Prof_License;
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
    BOOLEAN Diff_prolic_key;
    BOOLEAN Diff_date_first_seen;
    BOOLEAN Diff_date_last_seen;
    BOOLEAN Diff_profession_or_board;
    BOOLEAN Diff_license_type;
    BOOLEAN Diff_status;
    BOOLEAN Diff_orig_license_number;
    BOOLEAN Diff_license_number;
    BOOLEAN Diff_previous_license_number;
    BOOLEAN Diff_previous_license_type;
    BOOLEAN Diff_company_name;
    BOOLEAN Diff_orig_name;
    BOOLEAN Diff_name_order;
    BOOLEAN Diff_orig_former_name;
    BOOLEAN Diff_former_name_order;
    BOOLEAN Diff_orig_addr_1;
    BOOLEAN Diff_orig_addr_2;
    BOOLEAN Diff_orig_addr_3;
    BOOLEAN Diff_orig_addr_4;
    BOOLEAN Diff_orig_city;
    BOOLEAN Diff_orig_st;
    BOOLEAN Diff_orig_zip;
    BOOLEAN Diff_county_str;
    BOOLEAN Diff_country_str;
    BOOLEAN Diff_business_flag;
    BOOLEAN Diff_phone;
    BOOLEAN Diff_sex;
    BOOLEAN Diff_dob;
    BOOLEAN Diff_issue_date;
    BOOLEAN Diff_expiration_date;
    BOOLEAN Diff_last_renewal_date;
    BOOLEAN Diff_license_obtained_by;
    BOOLEAN Diff_board_action_indicator;
    BOOLEAN Diff_source_st;
    BOOLEAN Diff_vendor;
    BOOLEAN Diff_action_record_type;
    BOOLEAN Diff_action_complaint_violation_cds;
    BOOLEAN Diff_action_complaint_violation_desc;
    BOOLEAN Diff_action_complaint_violation_dt;
    BOOLEAN Diff_action_case_number;
    BOOLEAN Diff_action_effective_dt;
    BOOLEAN Diff_action_cds;
    BOOLEAN Diff_action_desc;
    BOOLEAN Diff_action_final_order_no;
    BOOLEAN Diff_action_status;
    BOOLEAN Diff_action_posting_status_dt;
    BOOLEAN Diff_action_original_filename_or_url;
    BOOLEAN Diff_additional_name_addr_type;
    BOOLEAN Diff_additional_orig_name;
    BOOLEAN Diff_additional_name_order;
    BOOLEAN Diff_additional_orig_additional_1;
    BOOLEAN Diff_additional_orig_additional_2;
    BOOLEAN Diff_additional_orig_additional_3;
    BOOLEAN Diff_additional_orig_additional_4;
    BOOLEAN Diff_additional_orig_city;
    BOOLEAN Diff_additional_orig_st;
    BOOLEAN Diff_additional_orig_zip;
    BOOLEAN Diff_additional_phone;
    BOOLEAN Diff_misc_occupation;
    BOOLEAN Diff_misc_practice_hours;
    BOOLEAN Diff_misc_practice_type;
    BOOLEAN Diff_misc_email;
    BOOLEAN Diff_misc_fax;
    BOOLEAN Diff_misc_web_site;
    BOOLEAN Diff_misc_other_id;
    BOOLEAN Diff_misc_other_id_type;
    BOOLEAN Diff_education_continuing_education;
    BOOLEAN Diff_education_1_school_attended;
    BOOLEAN Diff_education_1_dates_attended;
    BOOLEAN Diff_education_1_curriculum;
    BOOLEAN Diff_education_1_degree;
    BOOLEAN Diff_education_2_school_attended;
    BOOLEAN Diff_education_2_dates_attended;
    BOOLEAN Diff_education_2_curriculum;
    BOOLEAN Diff_education_2_degree;
    BOOLEAN Diff_education_3_school_attended;
    BOOLEAN Diff_education_3_dates_attended;
    BOOLEAN Diff_education_3_curriculum;
    BOOLEAN Diff_education_3_degree;
    BOOLEAN Diff_additional_licensing_specifics;
    BOOLEAN Diff_personal_pob_cd;
    BOOLEAN Diff_personal_pob_desc;
    BOOLEAN Diff_personal_race_cd;
    BOOLEAN Diff_personal_race_desc;
    BOOLEAN Diff_status_status_cds;
    BOOLEAN Diff_status_effective_dt;
    BOOLEAN Diff_status_renewal_desc;
    BOOLEAN Diff_status_other_agency;
    BOOLEAN Diff_prim_range;
    BOOLEAN Diff_predir;
    BOOLEAN Diff_prim_name;
    BOOLEAN Diff_suffix;
    BOOLEAN Diff_postdir;
    BOOLEAN Diff_unit_desig;
    BOOLEAN Diff_sec_range;
    BOOLEAN Diff_p_city_name;
    BOOLEAN Diff_v_city_name;
    BOOLEAN Diff_st;
    BOOLEAN Diff_zip;
    BOOLEAN Diff_zip4;
    BOOLEAN Diff_cart;
    BOOLEAN Diff_cr_sort_sz;
    BOOLEAN Diff_lot;
    BOOLEAN Diff_lot_order;
    BOOLEAN Diff_dpbc;
    BOOLEAN Diff_chk_digit;
    BOOLEAN Diff_record_type;
    BOOLEAN Diff_ace_fips_st;
    BOOLEAN Diff_county;
    BOOLEAN Diff_geo_lat;
    BOOLEAN Diff_geo_long;
    BOOLEAN Diff_msa;
    BOOLEAN Diff_geo_blk;
    BOOLEAN Diff_geo_match;
    BOOLEAN Diff_err_stat;
    BOOLEAN Diff_title;
    BOOLEAN Diff_fname;
    BOOLEAN Diff_mname;
    BOOLEAN Diff_lname;
    BOOLEAN Diff_name_suffix;
    BOOLEAN Diff_pl_score_in;
    BOOLEAN Diff_prep_addr_line1;
    BOOLEAN Diff_prep_addr_last_line;
    BOOLEAN Diff_rawaid;
    BOOLEAN Diff_aceaid;
    BOOLEAN Diff_county_name;
    BOOLEAN Diff_did;
    BOOLEAN Diff_score;
    BOOLEAN Diff_best_ssn;
    BOOLEAN Diff_bdid;
    BOOLEAN Diff_source_rec_id;
    BOOLEAN Diff_dotid;
    BOOLEAN Diff_dotscore;
    BOOLEAN Diff_dotweight;
    BOOLEAN Diff_empid;
    BOOLEAN Diff_empscore;
    BOOLEAN Diff_empweight;
    BOOLEAN Diff_powid;
    BOOLEAN Diff_powscore;
    BOOLEAN Diff_powweight;
    BOOLEAN Diff_proxid;
    BOOLEAN Diff_proxscore;
    BOOLEAN Diff_proxweight;
    BOOLEAN Diff_seleid;
    BOOLEAN Diff_selescore;
    BOOLEAN Diff_seleweight;
    BOOLEAN Diff_orgid;
    BOOLEAN Diff_orgscore;
    BOOLEAN Diff_orgweight;
    BOOLEAN Diff_ultid;
    BOOLEAN Diff_ultscore;
    BOOLEAN Diff_ultweight;
    BOOLEAN Diff_lnpid;
    UNSIGNED Num_Diffs;
    SALT37.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_prolic_key := le.prolic_key <> ri.prolic_key;
    SELF.Diff_date_first_seen := le.date_first_seen <> ri.date_first_seen;
    SELF.Diff_date_last_seen := le.date_last_seen <> ri.date_last_seen;
    SELF.Diff_profession_or_board := le.profession_or_board <> ri.profession_or_board;
    SELF.Diff_license_type := le.license_type <> ri.license_type;
    SELF.Diff_status := le.status <> ri.status;
    SELF.Diff_orig_license_number := le.orig_license_number <> ri.orig_license_number;
    SELF.Diff_license_number := le.license_number <> ri.license_number;
    SELF.Diff_previous_license_number := le.previous_license_number <> ri.previous_license_number;
    SELF.Diff_previous_license_type := le.previous_license_type <> ri.previous_license_type;
    SELF.Diff_company_name := le.company_name <> ri.company_name;
    SELF.Diff_orig_name := le.orig_name <> ri.orig_name;
    SELF.Diff_name_order := le.name_order <> ri.name_order;
    SELF.Diff_orig_former_name := le.orig_former_name <> ri.orig_former_name;
    SELF.Diff_former_name_order := le.former_name_order <> ri.former_name_order;
    SELF.Diff_orig_addr_1 := le.orig_addr_1 <> ri.orig_addr_1;
    SELF.Diff_orig_addr_2 := le.orig_addr_2 <> ri.orig_addr_2;
    SELF.Diff_orig_addr_3 := le.orig_addr_3 <> ri.orig_addr_3;
    SELF.Diff_orig_addr_4 := le.orig_addr_4 <> ri.orig_addr_4;
    SELF.Diff_orig_city := le.orig_city <> ri.orig_city;
    SELF.Diff_orig_st := le.orig_st <> ri.orig_st;
    SELF.Diff_orig_zip := le.orig_zip <> ri.orig_zip;
    SELF.Diff_county_str := le.county_str <> ri.county_str;
    SELF.Diff_country_str := le.country_str <> ri.country_str;
    SELF.Diff_business_flag := le.business_flag <> ri.business_flag;
    SELF.Diff_phone := le.phone <> ri.phone;
    SELF.Diff_sex := le.sex <> ri.sex;
    SELF.Diff_dob := le.dob <> ri.dob;
    SELF.Diff_issue_date := le.issue_date <> ri.issue_date;
    SELF.Diff_expiration_date := le.expiration_date <> ri.expiration_date;
    SELF.Diff_last_renewal_date := le.last_renewal_date <> ri.last_renewal_date;
    SELF.Diff_license_obtained_by := le.license_obtained_by <> ri.license_obtained_by;
    SELF.Diff_board_action_indicator := le.board_action_indicator <> ri.board_action_indicator;
    SELF.Diff_source_st := le.source_st <> ri.source_st;
    SELF.Diff_vendor := le.vendor <> ri.vendor;
    SELF.Diff_action_record_type := le.action_record_type <> ri.action_record_type;
    SELF.Diff_action_complaint_violation_cds := le.action_complaint_violation_cds <> ri.action_complaint_violation_cds;
    SELF.Diff_action_complaint_violation_desc := le.action_complaint_violation_desc <> ri.action_complaint_violation_desc;
    SELF.Diff_action_complaint_violation_dt := le.action_complaint_violation_dt <> ri.action_complaint_violation_dt;
    SELF.Diff_action_case_number := le.action_case_number <> ri.action_case_number;
    SELF.Diff_action_effective_dt := le.action_effective_dt <> ri.action_effective_dt;
    SELF.Diff_action_cds := le.action_cds <> ri.action_cds;
    SELF.Diff_action_desc := le.action_desc <> ri.action_desc;
    SELF.Diff_action_final_order_no := le.action_final_order_no <> ri.action_final_order_no;
    SELF.Diff_action_status := le.action_status <> ri.action_status;
    SELF.Diff_action_posting_status_dt := le.action_posting_status_dt <> ri.action_posting_status_dt;
    SELF.Diff_action_original_filename_or_url := le.action_original_filename_or_url <> ri.action_original_filename_or_url;
    SELF.Diff_additional_name_addr_type := le.additional_name_addr_type <> ri.additional_name_addr_type;
    SELF.Diff_additional_orig_name := le.additional_orig_name <> ri.additional_orig_name;
    SELF.Diff_additional_name_order := le.additional_name_order <> ri.additional_name_order;
    SELF.Diff_additional_orig_additional_1 := le.additional_orig_additional_1 <> ri.additional_orig_additional_1;
    SELF.Diff_additional_orig_additional_2 := le.additional_orig_additional_2 <> ri.additional_orig_additional_2;
    SELF.Diff_additional_orig_additional_3 := le.additional_orig_additional_3 <> ri.additional_orig_additional_3;
    SELF.Diff_additional_orig_additional_4 := le.additional_orig_additional_4 <> ri.additional_orig_additional_4;
    SELF.Diff_additional_orig_city := le.additional_orig_city <> ri.additional_orig_city;
    SELF.Diff_additional_orig_st := le.additional_orig_st <> ri.additional_orig_st;
    SELF.Diff_additional_orig_zip := le.additional_orig_zip <> ri.additional_orig_zip;
    SELF.Diff_additional_phone := le.additional_phone <> ri.additional_phone;
    SELF.Diff_misc_occupation := le.misc_occupation <> ri.misc_occupation;
    SELF.Diff_misc_practice_hours := le.misc_practice_hours <> ri.misc_practice_hours;
    SELF.Diff_misc_practice_type := le.misc_practice_type <> ri.misc_practice_type;
    SELF.Diff_misc_email := le.misc_email <> ri.misc_email;
    SELF.Diff_misc_fax := le.misc_fax <> ri.misc_fax;
    SELF.Diff_misc_web_site := le.misc_web_site <> ri.misc_web_site;
    SELF.Diff_misc_other_id := le.misc_other_id <> ri.misc_other_id;
    SELF.Diff_misc_other_id_type := le.misc_other_id_type <> ri.misc_other_id_type;
    SELF.Diff_education_continuing_education := le.education_continuing_education <> ri.education_continuing_education;
    SELF.Diff_education_1_school_attended := le.education_1_school_attended <> ri.education_1_school_attended;
    SELF.Diff_education_1_dates_attended := le.education_1_dates_attended <> ri.education_1_dates_attended;
    SELF.Diff_education_1_curriculum := le.education_1_curriculum <> ri.education_1_curriculum;
    SELF.Diff_education_1_degree := le.education_1_degree <> ri.education_1_degree;
    SELF.Diff_education_2_school_attended := le.education_2_school_attended <> ri.education_2_school_attended;
    SELF.Diff_education_2_dates_attended := le.education_2_dates_attended <> ri.education_2_dates_attended;
    SELF.Diff_education_2_curriculum := le.education_2_curriculum <> ri.education_2_curriculum;
    SELF.Diff_education_2_degree := le.education_2_degree <> ri.education_2_degree;
    SELF.Diff_education_3_school_attended := le.education_3_school_attended <> ri.education_3_school_attended;
    SELF.Diff_education_3_dates_attended := le.education_3_dates_attended <> ri.education_3_dates_attended;
    SELF.Diff_education_3_curriculum := le.education_3_curriculum <> ri.education_3_curriculum;
    SELF.Diff_education_3_degree := le.education_3_degree <> ri.education_3_degree;
    SELF.Diff_additional_licensing_specifics := le.additional_licensing_specifics <> ri.additional_licensing_specifics;
    SELF.Diff_personal_pob_cd := le.personal_pob_cd <> ri.personal_pob_cd;
    SELF.Diff_personal_pob_desc := le.personal_pob_desc <> ri.personal_pob_desc;
    SELF.Diff_personal_race_cd := le.personal_race_cd <> ri.personal_race_cd;
    SELF.Diff_personal_race_desc := le.personal_race_desc <> ri.personal_race_desc;
    SELF.Diff_status_status_cds := le.status_status_cds <> ri.status_status_cds;
    SELF.Diff_status_effective_dt := le.status_effective_dt <> ri.status_effective_dt;
    SELF.Diff_status_renewal_desc := le.status_renewal_desc <> ri.status_renewal_desc;
    SELF.Diff_status_other_agency := le.status_other_agency <> ri.status_other_agency;
    SELF.Diff_prim_range := le.prim_range <> ri.prim_range;
    SELF.Diff_predir := le.predir <> ri.predir;
    SELF.Diff_prim_name := le.prim_name <> ri.prim_name;
    SELF.Diff_suffix := le.suffix <> ri.suffix;
    SELF.Diff_postdir := le.postdir <> ri.postdir;
    SELF.Diff_unit_desig := le.unit_desig <> ri.unit_desig;
    SELF.Diff_sec_range := le.sec_range <> ri.sec_range;
    SELF.Diff_p_city_name := le.p_city_name <> ri.p_city_name;
    SELF.Diff_v_city_name := le.v_city_name <> ri.v_city_name;
    SELF.Diff_st := le.st <> ri.st;
    SELF.Diff_zip := le.zip <> ri.zip;
    SELF.Diff_zip4 := le.zip4 <> ri.zip4;
    SELF.Diff_cart := le.cart <> ri.cart;
    SELF.Diff_cr_sort_sz := le.cr_sort_sz <> ri.cr_sort_sz;
    SELF.Diff_lot := le.lot <> ri.lot;
    SELF.Diff_lot_order := le.lot_order <> ri.lot_order;
    SELF.Diff_dpbc := le.dpbc <> ri.dpbc;
    SELF.Diff_chk_digit := le.chk_digit <> ri.chk_digit;
    SELF.Diff_record_type := le.record_type <> ri.record_type;
    SELF.Diff_ace_fips_st := le.ace_fips_st <> ri.ace_fips_st;
    SELF.Diff_county := le.county <> ri.county;
    SELF.Diff_geo_lat := le.geo_lat <> ri.geo_lat;
    SELF.Diff_geo_long := le.geo_long <> ri.geo_long;
    SELF.Diff_msa := le.msa <> ri.msa;
    SELF.Diff_geo_blk := le.geo_blk <> ri.geo_blk;
    SELF.Diff_geo_match := le.geo_match <> ri.geo_match;
    SELF.Diff_err_stat := le.err_stat <> ri.err_stat;
    SELF.Diff_title := le.title <> ri.title;
    SELF.Diff_fname := le.fname <> ri.fname;
    SELF.Diff_mname := le.mname <> ri.mname;
    SELF.Diff_lname := le.lname <> ri.lname;
    SELF.Diff_name_suffix := le.name_suffix <> ri.name_suffix;
    SELF.Diff_pl_score_in := le.pl_score_in <> ri.pl_score_in;
    SELF.Diff_prep_addr_line1 := le.prep_addr_line1 <> ri.prep_addr_line1;
    SELF.Diff_prep_addr_last_line := le.prep_addr_last_line <> ri.prep_addr_last_line;
    SELF.Diff_rawaid := le.rawaid <> ri.rawaid;
    SELF.Diff_aceaid := le.aceaid <> ri.aceaid;
    SELF.Diff_county_name := le.county_name <> ri.county_name;
    SELF.Diff_did := le.did <> ri.did;
    SELF.Diff_score := le.score <> ri.score;
    SELF.Diff_best_ssn := le.best_ssn <> ri.best_ssn;
    SELF.Diff_bdid := le.bdid <> ri.bdid;
    SELF.Diff_source_rec_id := le.source_rec_id <> ri.source_rec_id;
    SELF.Diff_dotid := le.dotid <> ri.dotid;
    SELF.Diff_dotscore := le.dotscore <> ri.dotscore;
    SELF.Diff_dotweight := le.dotweight <> ri.dotweight;
    SELF.Diff_empid := le.empid <> ri.empid;
    SELF.Diff_empscore := le.empscore <> ri.empscore;
    SELF.Diff_empweight := le.empweight <> ri.empweight;
    SELF.Diff_powid := le.powid <> ri.powid;
    SELF.Diff_powscore := le.powscore <> ri.powscore;
    SELF.Diff_powweight := le.powweight <> ri.powweight;
    SELF.Diff_proxid := le.proxid <> ri.proxid;
    SELF.Diff_proxscore := le.proxscore <> ri.proxscore;
    SELF.Diff_proxweight := le.proxweight <> ri.proxweight;
    SELF.Diff_seleid := le.seleid <> ri.seleid;
    SELF.Diff_selescore := le.selescore <> ri.selescore;
    SELF.Diff_seleweight := le.seleweight <> ri.seleweight;
    SELF.Diff_orgid := le.orgid <> ri.orgid;
    SELF.Diff_orgscore := le.orgscore <> ri.orgscore;
    SELF.Diff_orgweight := le.orgweight <> ri.orgweight;
    SELF.Diff_ultid := le.ultid <> ri.ultid;
    SELF.Diff_ultscore := le.ultscore <> ri.ultscore;
    SELF.Diff_ultweight := le.ultweight <> ri.ultweight;
    SELF.Diff_lnpid := le.lnpid <> ri.lnpid;
    SELF.Val := (SALT37.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_prolic_key,1,0)+ IF( SELF.Diff_date_first_seen,1,0)+ IF( SELF.Diff_date_last_seen,1,0)+ IF( SELF.Diff_profession_or_board,1,0)+ IF( SELF.Diff_license_type,1,0)+ IF( SELF.Diff_status,1,0)+ IF( SELF.Diff_orig_license_number,1,0)+ IF( SELF.Diff_license_number,1,0)+ IF( SELF.Diff_previous_license_number,1,0)+ IF( SELF.Diff_previous_license_type,1,0)+ IF( SELF.Diff_company_name,1,0)+ IF( SELF.Diff_orig_name,1,0)+ IF( SELF.Diff_name_order,1,0)+ IF( SELF.Diff_orig_former_name,1,0)+ IF( SELF.Diff_former_name_order,1,0)+ IF( SELF.Diff_orig_addr_1,1,0)+ IF( SELF.Diff_orig_addr_2,1,0)+ IF( SELF.Diff_orig_addr_3,1,0)+ IF( SELF.Diff_orig_addr_4,1,0)+ IF( SELF.Diff_orig_city,1,0)+ IF( SELF.Diff_orig_st,1,0)+ IF( SELF.Diff_orig_zip,1,0)+ IF( SELF.Diff_county_str,1,0)+ IF( SELF.Diff_country_str,1,0)+ IF( SELF.Diff_business_flag,1,0)+ IF( SELF.Diff_phone,1,0)+ IF( SELF.Diff_sex,1,0)+ IF( SELF.Diff_dob,1,0)+ IF( SELF.Diff_issue_date,1,0)+ IF( SELF.Diff_expiration_date,1,0)+ IF( SELF.Diff_last_renewal_date,1,0)+ IF( SELF.Diff_license_obtained_by,1,0)+ IF( SELF.Diff_board_action_indicator,1,0)+ IF( SELF.Diff_source_st,1,0)+ IF( SELF.Diff_vendor,1,0)+ IF( SELF.Diff_action_record_type,1,0)+ IF( SELF.Diff_action_complaint_violation_cds,1,0)+ IF( SELF.Diff_action_complaint_violation_desc,1,0)+ IF( SELF.Diff_action_complaint_violation_dt,1,0)+ IF( SELF.Diff_action_case_number,1,0)+ IF( SELF.Diff_action_effective_dt,1,0)+ IF( SELF.Diff_action_cds,1,0)+ IF( SELF.Diff_action_desc,1,0)+ IF( SELF.Diff_action_final_order_no,1,0)+ IF( SELF.Diff_action_status,1,0)+ IF( SELF.Diff_action_posting_status_dt,1,0)+ IF( SELF.Diff_action_original_filename_or_url,1,0)+ IF( SELF.Diff_additional_name_addr_type,1,0)+ IF( SELF.Diff_additional_orig_name,1,0)+ IF( SELF.Diff_additional_name_order,1,0)+ IF( SELF.Diff_additional_orig_additional_1,1,0)+ IF( SELF.Diff_additional_orig_additional_2,1,0)+ IF( SELF.Diff_additional_orig_additional_3,1,0)+ IF( SELF.Diff_additional_orig_additional_4,1,0)+ IF( SELF.Diff_additional_orig_city,1,0)+ IF( SELF.Diff_additional_orig_st,1,0)+ IF( SELF.Diff_additional_orig_zip,1,0)+ IF( SELF.Diff_additional_phone,1,0)+ IF( SELF.Diff_misc_occupation,1,0)+ IF( SELF.Diff_misc_practice_hours,1,0)+ IF( SELF.Diff_misc_practice_type,1,0)+ IF( SELF.Diff_misc_email,1,0)+ IF( SELF.Diff_misc_fax,1,0)+ IF( SELF.Diff_misc_web_site,1,0)+ IF( SELF.Diff_misc_other_id,1,0)+ IF( SELF.Diff_misc_other_id_type,1,0)+ IF( SELF.Diff_education_continuing_education,1,0)+ IF( SELF.Diff_education_1_school_attended,1,0)+ IF( SELF.Diff_education_1_dates_attended,1,0)+ IF( SELF.Diff_education_1_curriculum,1,0)+ IF( SELF.Diff_education_1_degree,1,0)+ IF( SELF.Diff_education_2_school_attended,1,0)+ IF( SELF.Diff_education_2_dates_attended,1,0)+ IF( SELF.Diff_education_2_curriculum,1,0)+ IF( SELF.Diff_education_2_degree,1,0)+ IF( SELF.Diff_education_3_school_attended,1,0)+ IF( SELF.Diff_education_3_dates_attended,1,0)+ IF( SELF.Diff_education_3_curriculum,1,0)+ IF( SELF.Diff_education_3_degree,1,0)+ IF( SELF.Diff_additional_licensing_specifics,1,0)+ IF( SELF.Diff_personal_pob_cd,1,0)+ IF( SELF.Diff_personal_pob_desc,1,0)+ IF( SELF.Diff_personal_race_cd,1,0)+ IF( SELF.Diff_personal_race_desc,1,0)+ IF( SELF.Diff_status_status_cds,1,0)+ IF( SELF.Diff_status_effective_dt,1,0)+ IF( SELF.Diff_status_renewal_desc,1,0)+ IF( SELF.Diff_status_other_agency,1,0)+ IF( SELF.Diff_prim_range,1,0)+ IF( SELF.Diff_predir,1,0)+ IF( SELF.Diff_prim_name,1,0)+ IF( SELF.Diff_suffix,1,0)+ IF( SELF.Diff_postdir,1,0)+ IF( SELF.Diff_unit_desig,1,0)+ IF( SELF.Diff_sec_range,1,0)+ IF( SELF.Diff_p_city_name,1,0)+ IF( SELF.Diff_v_city_name,1,0)+ IF( SELF.Diff_st,1,0)+ IF( SELF.Diff_zip,1,0)+ IF( SELF.Diff_zip4,1,0)+ IF( SELF.Diff_cart,1,0)+ IF( SELF.Diff_cr_sort_sz,1,0)+ IF( SELF.Diff_lot,1,0)+ IF( SELF.Diff_lot_order,1,0)+ IF( SELF.Diff_dpbc,1,0)+ IF( SELF.Diff_chk_digit,1,0)+ IF( SELF.Diff_record_type,1,0)+ IF( SELF.Diff_ace_fips_st,1,0)+ IF( SELF.Diff_county,1,0)+ IF( SELF.Diff_geo_lat,1,0)+ IF( SELF.Diff_geo_long,1,0)+ IF( SELF.Diff_msa,1,0)+ IF( SELF.Diff_geo_blk,1,0)+ IF( SELF.Diff_geo_match,1,0)+ IF( SELF.Diff_err_stat,1,0)+ IF( SELF.Diff_title,1,0)+ IF( SELF.Diff_fname,1,0)+ IF( SELF.Diff_mname,1,0)+ IF( SELF.Diff_lname,1,0)+ IF( SELF.Diff_name_suffix,1,0)+ IF( SELF.Diff_pl_score_in,1,0)+ IF( SELF.Diff_prep_addr_line1,1,0)+ IF( SELF.Diff_prep_addr_last_line,1,0)+ IF( SELF.Diff_rawaid,1,0)+ IF( SELF.Diff_aceaid,1,0)+ IF( SELF.Diff_county_name,1,0)+ IF( SELF.Diff_did,1,0)+ IF( SELF.Diff_score,1,0)+ IF( SELF.Diff_best_ssn,1,0)+ IF( SELF.Diff_bdid,1,0)+ IF( SELF.Diff_source_rec_id,1,0)+ IF( SELF.Diff_dotid,1,0)+ IF( SELF.Diff_dotscore,1,0)+ IF( SELF.Diff_dotweight,1,0)+ IF( SELF.Diff_empid,1,0)+ IF( SELF.Diff_empscore,1,0)+ IF( SELF.Diff_empweight,1,0)+ IF( SELF.Diff_powid,1,0)+ IF( SELF.Diff_powscore,1,0)+ IF( SELF.Diff_powweight,1,0)+ IF( SELF.Diff_proxid,1,0)+ IF( SELF.Diff_proxscore,1,0)+ IF( SELF.Diff_proxweight,1,0)+ IF( SELF.Diff_seleid,1,0)+ IF( SELF.Diff_selescore,1,0)+ IF( SELF.Diff_seleweight,1,0)+ IF( SELF.Diff_orgid,1,0)+ IF( SELF.Diff_orgscore,1,0)+ IF( SELF.Diff_orgweight,1,0)+ IF( SELF.Diff_ultid,1,0)+ IF( SELF.Diff_ultscore,1,0)+ IF( SELF.Diff_ultweight,1,0)+ IF( SELF.Diff_lnpid,1,0);
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
    Count_Diff_prolic_key := COUNT(GROUP,%Closest%.Diff_prolic_key);
    Count_Diff_date_first_seen := COUNT(GROUP,%Closest%.Diff_date_first_seen);
    Count_Diff_date_last_seen := COUNT(GROUP,%Closest%.Diff_date_last_seen);
    Count_Diff_profession_or_board := COUNT(GROUP,%Closest%.Diff_profession_or_board);
    Count_Diff_license_type := COUNT(GROUP,%Closest%.Diff_license_type);
    Count_Diff_status := COUNT(GROUP,%Closest%.Diff_status);
    Count_Diff_orig_license_number := COUNT(GROUP,%Closest%.Diff_orig_license_number);
    Count_Diff_license_number := COUNT(GROUP,%Closest%.Diff_license_number);
    Count_Diff_previous_license_number := COUNT(GROUP,%Closest%.Diff_previous_license_number);
    Count_Diff_previous_license_type := COUNT(GROUP,%Closest%.Diff_previous_license_type);
    Count_Diff_company_name := COUNT(GROUP,%Closest%.Diff_company_name);
    Count_Diff_orig_name := COUNT(GROUP,%Closest%.Diff_orig_name);
    Count_Diff_name_order := COUNT(GROUP,%Closest%.Diff_name_order);
    Count_Diff_orig_former_name := COUNT(GROUP,%Closest%.Diff_orig_former_name);
    Count_Diff_former_name_order := COUNT(GROUP,%Closest%.Diff_former_name_order);
    Count_Diff_orig_addr_1 := COUNT(GROUP,%Closest%.Diff_orig_addr_1);
    Count_Diff_orig_addr_2 := COUNT(GROUP,%Closest%.Diff_orig_addr_2);
    Count_Diff_orig_addr_3 := COUNT(GROUP,%Closest%.Diff_orig_addr_3);
    Count_Diff_orig_addr_4 := COUNT(GROUP,%Closest%.Diff_orig_addr_4);
    Count_Diff_orig_city := COUNT(GROUP,%Closest%.Diff_orig_city);
    Count_Diff_orig_st := COUNT(GROUP,%Closest%.Diff_orig_st);
    Count_Diff_orig_zip := COUNT(GROUP,%Closest%.Diff_orig_zip);
    Count_Diff_county_str := COUNT(GROUP,%Closest%.Diff_county_str);
    Count_Diff_country_str := COUNT(GROUP,%Closest%.Diff_country_str);
    Count_Diff_business_flag := COUNT(GROUP,%Closest%.Diff_business_flag);
    Count_Diff_phone := COUNT(GROUP,%Closest%.Diff_phone);
    Count_Diff_sex := COUNT(GROUP,%Closest%.Diff_sex);
    Count_Diff_dob := COUNT(GROUP,%Closest%.Diff_dob);
    Count_Diff_issue_date := COUNT(GROUP,%Closest%.Diff_issue_date);
    Count_Diff_expiration_date := COUNT(GROUP,%Closest%.Diff_expiration_date);
    Count_Diff_last_renewal_date := COUNT(GROUP,%Closest%.Diff_last_renewal_date);
    Count_Diff_license_obtained_by := COUNT(GROUP,%Closest%.Diff_license_obtained_by);
    Count_Diff_board_action_indicator := COUNT(GROUP,%Closest%.Diff_board_action_indicator);
    Count_Diff_source_st := COUNT(GROUP,%Closest%.Diff_source_st);
    Count_Diff_vendor := COUNT(GROUP,%Closest%.Diff_vendor);
    Count_Diff_action_record_type := COUNT(GROUP,%Closest%.Diff_action_record_type);
    Count_Diff_action_complaint_violation_cds := COUNT(GROUP,%Closest%.Diff_action_complaint_violation_cds);
    Count_Diff_action_complaint_violation_desc := COUNT(GROUP,%Closest%.Diff_action_complaint_violation_desc);
    Count_Diff_action_complaint_violation_dt := COUNT(GROUP,%Closest%.Diff_action_complaint_violation_dt);
    Count_Diff_action_case_number := COUNT(GROUP,%Closest%.Diff_action_case_number);
    Count_Diff_action_effective_dt := COUNT(GROUP,%Closest%.Diff_action_effective_dt);
    Count_Diff_action_cds := COUNT(GROUP,%Closest%.Diff_action_cds);
    Count_Diff_action_desc := COUNT(GROUP,%Closest%.Diff_action_desc);
    Count_Diff_action_final_order_no := COUNT(GROUP,%Closest%.Diff_action_final_order_no);
    Count_Diff_action_status := COUNT(GROUP,%Closest%.Diff_action_status);
    Count_Diff_action_posting_status_dt := COUNT(GROUP,%Closest%.Diff_action_posting_status_dt);
    Count_Diff_action_original_filename_or_url := COUNT(GROUP,%Closest%.Diff_action_original_filename_or_url);
    Count_Diff_additional_name_addr_type := COUNT(GROUP,%Closest%.Diff_additional_name_addr_type);
    Count_Diff_additional_orig_name := COUNT(GROUP,%Closest%.Diff_additional_orig_name);
    Count_Diff_additional_name_order := COUNT(GROUP,%Closest%.Diff_additional_name_order);
    Count_Diff_additional_orig_additional_1 := COUNT(GROUP,%Closest%.Diff_additional_orig_additional_1);
    Count_Diff_additional_orig_additional_2 := COUNT(GROUP,%Closest%.Diff_additional_orig_additional_2);
    Count_Diff_additional_orig_additional_3 := COUNT(GROUP,%Closest%.Diff_additional_orig_additional_3);
    Count_Diff_additional_orig_additional_4 := COUNT(GROUP,%Closest%.Diff_additional_orig_additional_4);
    Count_Diff_additional_orig_city := COUNT(GROUP,%Closest%.Diff_additional_orig_city);
    Count_Diff_additional_orig_st := COUNT(GROUP,%Closest%.Diff_additional_orig_st);
    Count_Diff_additional_orig_zip := COUNT(GROUP,%Closest%.Diff_additional_orig_zip);
    Count_Diff_additional_phone := COUNT(GROUP,%Closest%.Diff_additional_phone);
    Count_Diff_misc_occupation := COUNT(GROUP,%Closest%.Diff_misc_occupation);
    Count_Diff_misc_practice_hours := COUNT(GROUP,%Closest%.Diff_misc_practice_hours);
    Count_Diff_misc_practice_type := COUNT(GROUP,%Closest%.Diff_misc_practice_type);
    Count_Diff_misc_email := COUNT(GROUP,%Closest%.Diff_misc_email);
    Count_Diff_misc_fax := COUNT(GROUP,%Closest%.Diff_misc_fax);
    Count_Diff_misc_web_site := COUNT(GROUP,%Closest%.Diff_misc_web_site);
    Count_Diff_misc_other_id := COUNT(GROUP,%Closest%.Diff_misc_other_id);
    Count_Diff_misc_other_id_type := COUNT(GROUP,%Closest%.Diff_misc_other_id_type);
    Count_Diff_education_continuing_education := COUNT(GROUP,%Closest%.Diff_education_continuing_education);
    Count_Diff_education_1_school_attended := COUNT(GROUP,%Closest%.Diff_education_1_school_attended);
    Count_Diff_education_1_dates_attended := COUNT(GROUP,%Closest%.Diff_education_1_dates_attended);
    Count_Diff_education_1_curriculum := COUNT(GROUP,%Closest%.Diff_education_1_curriculum);
    Count_Diff_education_1_degree := COUNT(GROUP,%Closest%.Diff_education_1_degree);
    Count_Diff_education_2_school_attended := COUNT(GROUP,%Closest%.Diff_education_2_school_attended);
    Count_Diff_education_2_dates_attended := COUNT(GROUP,%Closest%.Diff_education_2_dates_attended);
    Count_Diff_education_2_curriculum := COUNT(GROUP,%Closest%.Diff_education_2_curriculum);
    Count_Diff_education_2_degree := COUNT(GROUP,%Closest%.Diff_education_2_degree);
    Count_Diff_education_3_school_attended := COUNT(GROUP,%Closest%.Diff_education_3_school_attended);
    Count_Diff_education_3_dates_attended := COUNT(GROUP,%Closest%.Diff_education_3_dates_attended);
    Count_Diff_education_3_curriculum := COUNT(GROUP,%Closest%.Diff_education_3_curriculum);
    Count_Diff_education_3_degree := COUNT(GROUP,%Closest%.Diff_education_3_degree);
    Count_Diff_additional_licensing_specifics := COUNT(GROUP,%Closest%.Diff_additional_licensing_specifics);
    Count_Diff_personal_pob_cd := COUNT(GROUP,%Closest%.Diff_personal_pob_cd);
    Count_Diff_personal_pob_desc := COUNT(GROUP,%Closest%.Diff_personal_pob_desc);
    Count_Diff_personal_race_cd := COUNT(GROUP,%Closest%.Diff_personal_race_cd);
    Count_Diff_personal_race_desc := COUNT(GROUP,%Closest%.Diff_personal_race_desc);
    Count_Diff_status_status_cds := COUNT(GROUP,%Closest%.Diff_status_status_cds);
    Count_Diff_status_effective_dt := COUNT(GROUP,%Closest%.Diff_status_effective_dt);
    Count_Diff_status_renewal_desc := COUNT(GROUP,%Closest%.Diff_status_renewal_desc);
    Count_Diff_status_other_agency := COUNT(GROUP,%Closest%.Diff_status_other_agency);
    Count_Diff_prim_range := COUNT(GROUP,%Closest%.Diff_prim_range);
    Count_Diff_predir := COUNT(GROUP,%Closest%.Diff_predir);
    Count_Diff_prim_name := COUNT(GROUP,%Closest%.Diff_prim_name);
    Count_Diff_suffix := COUNT(GROUP,%Closest%.Diff_suffix);
    Count_Diff_postdir := COUNT(GROUP,%Closest%.Diff_postdir);
    Count_Diff_unit_desig := COUNT(GROUP,%Closest%.Diff_unit_desig);
    Count_Diff_sec_range := COUNT(GROUP,%Closest%.Diff_sec_range);
    Count_Diff_p_city_name := COUNT(GROUP,%Closest%.Diff_p_city_name);
    Count_Diff_v_city_name := COUNT(GROUP,%Closest%.Diff_v_city_name);
    Count_Diff_st := COUNT(GROUP,%Closest%.Diff_st);
    Count_Diff_zip := COUNT(GROUP,%Closest%.Diff_zip);
    Count_Diff_zip4 := COUNT(GROUP,%Closest%.Diff_zip4);
    Count_Diff_cart := COUNT(GROUP,%Closest%.Diff_cart);
    Count_Diff_cr_sort_sz := COUNT(GROUP,%Closest%.Diff_cr_sort_sz);
    Count_Diff_lot := COUNT(GROUP,%Closest%.Diff_lot);
    Count_Diff_lot_order := COUNT(GROUP,%Closest%.Diff_lot_order);
    Count_Diff_dpbc := COUNT(GROUP,%Closest%.Diff_dpbc);
    Count_Diff_chk_digit := COUNT(GROUP,%Closest%.Diff_chk_digit);
    Count_Diff_record_type := COUNT(GROUP,%Closest%.Diff_record_type);
    Count_Diff_ace_fips_st := COUNT(GROUP,%Closest%.Diff_ace_fips_st);
    Count_Diff_county := COUNT(GROUP,%Closest%.Diff_county);
    Count_Diff_geo_lat := COUNT(GROUP,%Closest%.Diff_geo_lat);
    Count_Diff_geo_long := COUNT(GROUP,%Closest%.Diff_geo_long);
    Count_Diff_msa := COUNT(GROUP,%Closest%.Diff_msa);
    Count_Diff_geo_blk := COUNT(GROUP,%Closest%.Diff_geo_blk);
    Count_Diff_geo_match := COUNT(GROUP,%Closest%.Diff_geo_match);
    Count_Diff_err_stat := COUNT(GROUP,%Closest%.Diff_err_stat);
    Count_Diff_title := COUNT(GROUP,%Closest%.Diff_title);
    Count_Diff_fname := COUNT(GROUP,%Closest%.Diff_fname);
    Count_Diff_mname := COUNT(GROUP,%Closest%.Diff_mname);
    Count_Diff_lname := COUNT(GROUP,%Closest%.Diff_lname);
    Count_Diff_name_suffix := COUNT(GROUP,%Closest%.Diff_name_suffix);
    Count_Diff_pl_score_in := COUNT(GROUP,%Closest%.Diff_pl_score_in);
    Count_Diff_prep_addr_line1 := COUNT(GROUP,%Closest%.Diff_prep_addr_line1);
    Count_Diff_prep_addr_last_line := COUNT(GROUP,%Closest%.Diff_prep_addr_last_line);
    Count_Diff_rawaid := COUNT(GROUP,%Closest%.Diff_rawaid);
    Count_Diff_aceaid := COUNT(GROUP,%Closest%.Diff_aceaid);
    Count_Diff_county_name := COUNT(GROUP,%Closest%.Diff_county_name);
    Count_Diff_did := COUNT(GROUP,%Closest%.Diff_did);
    Count_Diff_score := COUNT(GROUP,%Closest%.Diff_score);
    Count_Diff_best_ssn := COUNT(GROUP,%Closest%.Diff_best_ssn);
    Count_Diff_bdid := COUNT(GROUP,%Closest%.Diff_bdid);
    Count_Diff_source_rec_id := COUNT(GROUP,%Closest%.Diff_source_rec_id);
    Count_Diff_dotid := COUNT(GROUP,%Closest%.Diff_dotid);
    Count_Diff_dotscore := COUNT(GROUP,%Closest%.Diff_dotscore);
    Count_Diff_dotweight := COUNT(GROUP,%Closest%.Diff_dotweight);
    Count_Diff_empid := COUNT(GROUP,%Closest%.Diff_empid);
    Count_Diff_empscore := COUNT(GROUP,%Closest%.Diff_empscore);
    Count_Diff_empweight := COUNT(GROUP,%Closest%.Diff_empweight);
    Count_Diff_powid := COUNT(GROUP,%Closest%.Diff_powid);
    Count_Diff_powscore := COUNT(GROUP,%Closest%.Diff_powscore);
    Count_Diff_powweight := COUNT(GROUP,%Closest%.Diff_powweight);
    Count_Diff_proxid := COUNT(GROUP,%Closest%.Diff_proxid);
    Count_Diff_proxscore := COUNT(GROUP,%Closest%.Diff_proxscore);
    Count_Diff_proxweight := COUNT(GROUP,%Closest%.Diff_proxweight);
    Count_Diff_seleid := COUNT(GROUP,%Closest%.Diff_seleid);
    Count_Diff_selescore := COUNT(GROUP,%Closest%.Diff_selescore);
    Count_Diff_seleweight := COUNT(GROUP,%Closest%.Diff_seleweight);
    Count_Diff_orgid := COUNT(GROUP,%Closest%.Diff_orgid);
    Count_Diff_orgscore := COUNT(GROUP,%Closest%.Diff_orgscore);
    Count_Diff_orgweight := COUNT(GROUP,%Closest%.Diff_orgweight);
    Count_Diff_ultid := COUNT(GROUP,%Closest%.Diff_ultid);
    Count_Diff_ultscore := COUNT(GROUP,%Closest%.Diff_ultscore);
    Count_Diff_ultweight := COUNT(GROUP,%Closest%.Diff_ultweight);
    Count_Diff_lnpid := COUNT(GROUP,%Closest%.Diff_lnpid);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
