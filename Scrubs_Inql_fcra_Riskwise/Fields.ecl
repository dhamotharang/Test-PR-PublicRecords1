IMPORT SALT39;
EXPORT Fields := MODULE
 
EXPORT NumFields := 79;
 
// Processing for each FieldType
EXPORT SALT39.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'DEFAULT','ALPHA','NAME','NUMBER','ALPHANUM','WORDBAG','orig_login_id','orig_billing_code','orig_transaction_id','orig_function_name','orig_company_id','orig_reference_code','orig_fname','orig_mname','orig_lname','orig_name_suffix','orig_fname_2','orig_mname_2','orig_lname_2','orig_name_suffix_2','orig_address','orig_city','orig_state','orig_zip','orig_zip4','orig_address_2','orig_city_2','orig_state_2','orig_zip_2','orig_zip4_2','orig_clean_address','orig_clean_city','orig_clean_state','orig_clean_zip','orig_clean_zip4','orig_phone','orig_homephone','orig_homephone_2','orig_workphone','orig_workphone_2','orig_ssn','orig_ssn_2','orig_free','orig_record_count','orig_price','orig_revenue','orig_full_name','orig_business_name','orig_business_name_2','orig_years','orig_pricing_error_code','orig_fcra_purpose','orig_result_format','orig_dob','orig_dob_2','orig_unique_id','orig_response_time','orig_data_source','orig_report_options','orig_end_user_name','orig_end_user_address_1','orig_end_user_address_2','orig_end_user_city','orig_end_user_state','orig_end_user_zip','orig_login_history_id','orig_employment_state','orig_end_user_industry_class','orig_function_specific_data','orig_date_added','orig_retail_price','orig_country_code','orig_email','orig_email_2','orig_dl_number','orig_dl_number_2','orig_sub_id','orig_neighbors','orig_relatives','orig_associates','orig_property','orig_bankruptcy','orig_dls','orig_mvs','orig_ip_address');
EXPORT FieldTypeNum(SALT39.StrType fn) := CASE(fn,'DEFAULT' => 1,'ALPHA' => 2,'NAME' => 3,'NUMBER' => 4,'ALPHANUM' => 5,'WORDBAG' => 6,'orig_login_id' => 7,'orig_billing_code' => 8,'orig_transaction_id' => 9,'orig_function_name' => 10,'orig_company_id' => 11,'orig_reference_code' => 12,'orig_fname' => 13,'orig_mname' => 14,'orig_lname' => 15,'orig_name_suffix' => 16,'orig_fname_2' => 17,'orig_mname_2' => 18,'orig_lname_2' => 19,'orig_name_suffix_2' => 20,'orig_address' => 21,'orig_city' => 22,'orig_state' => 23,'orig_zip' => 24,'orig_zip4' => 25,'orig_address_2' => 26,'orig_city_2' => 27,'orig_state_2' => 28,'orig_zip_2' => 29,'orig_zip4_2' => 30,'orig_clean_address' => 31,'orig_clean_city' => 32,'orig_clean_state' => 33,'orig_clean_zip' => 34,'orig_clean_zip4' => 35,'orig_phone' => 36,'orig_homephone' => 37,'orig_homephone_2' => 38,'orig_workphone' => 39,'orig_workphone_2' => 40,'orig_ssn' => 41,'orig_ssn_2' => 42,'orig_free' => 43,'orig_record_count' => 44,'orig_price' => 45,'orig_revenue' => 46,'orig_full_name' => 47,'orig_business_name' => 48,'orig_business_name_2' => 49,'orig_years' => 50,'orig_pricing_error_code' => 51,'orig_fcra_purpose' => 52,'orig_result_format' => 53,'orig_dob' => 54,'orig_dob_2' => 55,'orig_unique_id' => 56,'orig_response_time' => 57,'orig_data_source' => 58,'orig_report_options' => 59,'orig_end_user_name' => 60,'orig_end_user_address_1' => 61,'orig_end_user_address_2' => 62,'orig_end_user_city' => 63,'orig_end_user_state' => 64,'orig_end_user_zip' => 65,'orig_login_history_id' => 66,'orig_employment_state' => 67,'orig_end_user_industry_class' => 68,'orig_function_specific_data' => 69,'orig_date_added' => 70,'orig_retail_price' => 71,'orig_country_code' => 72,'orig_email' => 73,'orig_email_2' => 74,'orig_dl_number' => 75,'orig_dl_number_2' => 76,'orig_sub_id' => 77,'orig_neighbors' => 78,'orig_relatives' => 79,'orig_associates' => 80,'orig_property' => 81,'orig_bankruptcy' => 82,'orig_dls' => 83,'orig_mvs' => 84,'orig_ip_address' => 85,0);
 
EXPORT MakeFT_DEFAULT(SALT39.StrType s0) := FUNCTION
  s1 := if ( SALT39.StringFind('"\'',s0[1],1)>0 and SALT39.StringFind('"\'',s0[LENGTH(TRIM(s0))],1)>0,s0[2..LENGTH(TRIM(s0))-1],s0 );// Remove quotes if required
  s2 := TRIM(s1,LEFT); // Left trim
  RETURN  s2;
END;
EXPORT InValidFT_DEFAULT(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,SALT39.StringFind('"\'',s[1],1)<>0 and SALT39.StringFind('"\'',s[LENGTH(TRIM(s))],1)<>0);
EXPORT InValidMessageFT_DEFAULT(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.Inquotes('"\''),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_ALPHA(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_ALPHA(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'))));
EXPORT InValidMessageFT_ALPHA(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_NAME(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz-,\'.'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_NAME(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz-,\'.'))));
EXPORT InValidMessageFT_NAME(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz-,\'.'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_NUMBER(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_NUMBER(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_NUMBER(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('0123456789'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_ALPHANUM(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_ALPHANUM(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_'))));
EXPORT InValidMessageFT_ALPHANUM(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_WORDBAG(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$; '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_WORDBAG(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$; '))));
EXPORT InValidMessageFT_WORDBAG(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$; '),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_login_id(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_ALPHANUM(s2);
END;
EXPORT InValidFT_orig_login_id(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_ '))),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_login_id(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_ '),SALT39.HygieneErrors.NotWords('1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_billing_code(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0148Naent '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_billing_code(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0148Naent '))),~(LENGTH(TRIM(s)) = 2),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_billing_code(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('0148Naent '),SALT39.HygieneErrors.NotLength('2'),SALT39.HygieneErrors.NotWords('1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_transaction_id(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789BR '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_transaction_id(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789BR '))),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_transaction_id(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('0123456789BR '),SALT39.HygieneErrors.NotWords('1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_function_name(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  MakeFT_ALPHANUM(s3);
END;
EXPORT InValidFT_orig_function_name(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_ '))),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_function_name(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_ '),SALT39.HygieneErrors.NotWords('1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_company_id(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  MakeFT_NUMBER(s3);
END;
EXPORT InValidFT_orig_company_id(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789 '))),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_company_id(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('0123456789 '),SALT39.HygieneErrors.NotWords('1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_reference_code(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$; '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_WORDBAG(s2);
END;
EXPORT InValidFT_orig_reference_code(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$; '))),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 2 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 6));
EXPORT InValidMessageFT_orig_reference_code(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$; '),SALT39.HygieneErrors.NotWords('1,2,6'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_fname(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz-,\'. '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_NAME(s2);
END;
EXPORT InValidFT_orig_fname(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz-,\'. '))),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 2 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_fname(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz-,\'. '),SALT39.HygieneErrors.NotWords('1,2,0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_mname(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz-,\'. '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_NAME(s2);
END;
EXPORT InValidFT_orig_mname(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz-,\'. '))),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_mname(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz-,\'. '),SALT39.HygieneErrors.NotWords('1,0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_lname(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz-,\'. '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_NAME(s2);
END;
EXPORT InValidFT_orig_lname(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz-,\'. '))),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 2 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 3 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_lname(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz-,\'. '),SALT39.HygieneErrors.NotWords('1,2,3,0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_name_suffix(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'IJNR '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_name_suffix(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'IJNR '))),~(LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_name_suffix(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('IJNR '),SALT39.HygieneErrors.NotLength('2,0'),SALT39.HygieneErrors.NotWords('1,0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_fname_2(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'N '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_fname_2(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'N '))),~(LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_fname_2(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('N '),SALT39.HygieneErrors.NotLength('2,0'),SALT39.HygieneErrors.NotWords('1,0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_mname_2(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'N '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_mname_2(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'N '))),~(LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_mname_2(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('N '),SALT39.HygieneErrors.NotLength('2,0'),SALT39.HygieneErrors.NotWords('1,0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_lname_2(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'N '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_lname_2(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'N '))),~(LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_lname_2(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('N '),SALT39.HygieneErrors.NotLength('2,0'),SALT39.HygieneErrors.NotWords('1,0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_name_suffix_2(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'N '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_name_suffix_2(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'N '))),~(LENGTH(TRIM(s)) = 2),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_name_suffix_2(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('N '),SALT39.HygieneErrors.NotLength('2'),SALT39.HygieneErrors.NotWords('1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_address(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$; '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  MakeFT_WORDBAG(s3);
END;
EXPORT InValidFT_orig_address(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$; '))));
EXPORT InValidMessageFT_orig_address(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$; '),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_city(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  MakeFT_ALPHA(s3);
END;
EXPORT InValidFT_orig_city(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '))),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 2 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 3 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_city(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '),SALT39.HygieneErrors.NotWords('1,2,3,0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_state(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  MakeFT_ALPHA(s3);
END;
EXPORT InValidFT_orig_state(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '))),~(LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_state(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '),SALT39.HygieneErrors.NotLength('2,0'),SALT39.HygieneErrors.NotWords('1,0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_zip(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  MakeFT_NUMBER(s3);
END;
EXPORT InValidFT_orig_zip(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789 '))),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_zip(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('0123456789 '),SALT39.HygieneErrors.NotWords('1,0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_zip4(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_NUMBER(s2);
END;
EXPORT InValidFT_orig_zip4(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789 '))),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_zip4(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('0123456789 '),SALT39.HygieneErrors.NotWords('1,0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_address_2(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'N '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_address_2(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'N '))),~(LENGTH(TRIM(s)) = 2),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_address_2(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('N '),SALT39.HygieneErrors.NotLength('2'),SALT39.HygieneErrors.NotWords('1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_city_2(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'N '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_city_2(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'N '))),~(LENGTH(TRIM(s)) = 2),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_city_2(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('N '),SALT39.HygieneErrors.NotLength('2'),SALT39.HygieneErrors.NotWords('1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_state_2(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'N '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_state_2(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'N '))),~(LENGTH(TRIM(s)) = 2),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_state_2(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('N '),SALT39.HygieneErrors.NotLength('2'),SALT39.HygieneErrors.NotWords('1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_zip_2(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'N '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_zip_2(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'N '))),~(LENGTH(TRIM(s)) = 2),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_zip_2(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('N '),SALT39.HygieneErrors.NotLength('2'),SALT39.HygieneErrors.NotWords('1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_zip4_2(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'N '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_zip4_2(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'N '))),~(LENGTH(TRIM(s)) = 2),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_zip4_2(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('N '),SALT39.HygieneErrors.NotLength('2'),SALT39.HygieneErrors.NotWords('1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_clean_address(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'N '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_clean_address(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'N '))),~(LENGTH(TRIM(s)) = 2),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_clean_address(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('N '),SALT39.HygieneErrors.NotLength('2'),SALT39.HygieneErrors.NotWords('1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_clean_city(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'N '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_clean_city(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'N '))),~(LENGTH(TRIM(s)) = 2),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_clean_city(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('N '),SALT39.HygieneErrors.NotLength('2'),SALT39.HygieneErrors.NotWords('1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_clean_state(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'N '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_clean_state(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'N '))),~(LENGTH(TRIM(s)) = 2),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_clean_state(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('N '),SALT39.HygieneErrors.NotLength('2'),SALT39.HygieneErrors.NotWords('1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_clean_zip(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'N '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_clean_zip(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'N '))),~(LENGTH(TRIM(s)) = 2),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_clean_zip(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('N '),SALT39.HygieneErrors.NotLength('2'),SALT39.HygieneErrors.NotWords('1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_clean_zip4(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'N '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_clean_zip4(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'N '))),~(LENGTH(TRIM(s)) = 2),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_clean_zip4(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('N '),SALT39.HygieneErrors.NotLength('2'),SALT39.HygieneErrors.NotWords('1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_phone(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'N '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_phone(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'N '))),~(LENGTH(TRIM(s)) = 2),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_phone(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('N '),SALT39.HygieneErrors.NotLength('2'),SALT39.HygieneErrors.NotWords('1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_homephone(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789N '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_homephone(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789N '))),~(LENGTH(TRIM(s)) = 10 OR LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_homephone(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('0123456789N '),SALT39.HygieneErrors.NotLength('10,2,0'),SALT39.HygieneErrors.NotWords('1,0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_homephone_2(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'N '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_homephone_2(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'N '))),~(LENGTH(TRIM(s)) = 2),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_homephone_2(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('N '),SALT39.HygieneErrors.NotLength('2'),SALT39.HygieneErrors.NotWords('1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_workphone(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789N '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_workphone(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789N '))),~(LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 10),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_workphone(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('0123456789N '),SALT39.HygieneErrors.NotLength('2,0,10'),SALT39.HygieneErrors.NotWords('1,0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_workphone_2(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'01N '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_workphone_2(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'01N '))),~(LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 3),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_workphone_2(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('01N '),SALT39.HygieneErrors.NotLength('2,3'),SALT39.HygieneErrors.NotWords('1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_ssn(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789N '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_ssn(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789N '))),~(LENGTH(TRIM(s)) = 9 OR LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 4),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_ssn(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('0123456789N '),SALT39.HygieneErrors.NotLength('9,2,0,4'),SALT39.HygieneErrors.NotWords('1,0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_ssn_2(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'N '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_ssn_2(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'N '))),~(LENGTH(TRIM(s)) = 2),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_ssn_2(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('N '),SALT39.HygieneErrors.NotLength('2'),SALT39.HygieneErrors.NotWords('1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_free(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'02 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_free(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'02 '))),~(LENGTH(TRIM(s)) = 1),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_free(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('02 '),SALT39.HygieneErrors.NotLength('1'),SALT39.HygieneErrors.NotWords('1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_record_count(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'01 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_record_count(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'01 '))),~(LENGTH(TRIM(s)) = 1),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_record_count(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('01 '),SALT39.HygieneErrors.NotLength('1'),SALT39.HygieneErrors.NotWords('1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_price(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s0,' ',' ') ); // Insert spaces but avoid doubles
  s2 := TRIM(s1,LEFT); // Left trim
  RETURN  s2;
END;
EXPORT InValidFT_orig_price(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_price(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotWords('1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_revenue(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'N '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_revenue(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'N '))),~(LENGTH(TRIM(s)) = 2),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_revenue(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('N '),SALT39.HygieneErrors.NotLength('2'),SALT39.HygieneErrors.NotWords('1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_full_name(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz-,\'. '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  MakeFT_NAME(s3);
END;
EXPORT InValidFT_orig_full_name(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz-,\'. '))),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 2));
EXPORT InValidMessageFT_orig_full_name(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz-,\'. '),SALT39.HygieneErrors.NotWords('1,2'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_business_name(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'N '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_business_name(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'N '))),~(LENGTH(TRIM(s)) = 2),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_business_name(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('N '),SALT39.HygieneErrors.NotLength('2'),SALT39.HygieneErrors.NotWords('1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_business_name_2(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'N '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_business_name_2(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'N '))),~(LENGTH(TRIM(s)) = 2),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_business_name_2(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('N '),SALT39.HygieneErrors.NotLength('2'),SALT39.HygieneErrors.NotWords('1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_years(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'N '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_years(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'N '))),~(LENGTH(TRIM(s)) = 2),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_years(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('N '),SALT39.HygieneErrors.NotLength('2'),SALT39.HygieneErrors.NotWords('1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_pricing_error_code(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'-02 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_pricing_error_code(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'-02 '))),~(LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 2),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_pricing_error_code(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('-02 '),SALT39.HygieneErrors.NotLength('1,2'),SALT39.HygieneErrors.NotWords('1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_fcra_purpose(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  MakeFT_NUMBER(s3);
END;
EXPORT InValidFT_orig_fcra_purpose(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 3),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_fcra_purpose(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('0123456789 '),SALT39.HygieneErrors.NotLength('3'),SALT39.HygieneErrors.NotWords('1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_result_format(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_result_format(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0 '))),~(LENGTH(TRIM(s)) = 1),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_result_format(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('0 '),SALT39.HygieneErrors.NotLength('1'),SALT39.HygieneErrors.NotWords('1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_dob(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789N '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_dob(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789N '))),~(LENGTH(TRIM(s)) = 8 OR LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_dob(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('0123456789N '),SALT39.HygieneErrors.NotLength('8,2,5,0'),SALT39.HygieneErrors.NotWords('1,0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_dob_2(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'N '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_dob_2(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'N '))),~(LENGTH(TRIM(s)) = 2),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_dob_2(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('N '),SALT39.HygieneErrors.NotLength('2'),SALT39.HygieneErrors.NotWords('1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_unique_id(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789N '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_unique_id(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789N '))),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_unique_id(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('0123456789N '),SALT39.HygieneErrors.NotWords('1,0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_response_time(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'.0123456789N '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_response_time(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'.0123456789N '))),~(LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 2),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_response_time(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('.0123456789N '),SALT39.HygieneErrors.NotLength('4,2'),SALT39.HygieneErrors.NotWords('1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_data_source(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'N '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_data_source(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'N '))),~(LENGTH(TRIM(s)) = 2),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_data_source(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('N '),SALT39.HygieneErrors.NotLength('2'),SALT39.HygieneErrors.NotWords('1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_report_options(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'01 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_report_options(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'01 '))),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_report_options(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('01 '),SALT39.HygieneErrors.NotWords('1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_end_user_name(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$; '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  MakeFT_WORDBAG(s3);
END;
EXPORT InValidFT_orig_end_user_name(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$; '))));
EXPORT InValidMessageFT_orig_end_user_name(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$; '),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_end_user_address_1(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$; '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  MakeFT_WORDBAG(s3);
END;
EXPORT InValidFT_orig_end_user_address_1(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$; '))));
EXPORT InValidMessageFT_orig_end_user_address_1(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$; '),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_end_user_address_2(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'N '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_end_user_address_2(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'N '))),~(LENGTH(TRIM(s)) = 2),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_end_user_address_2(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('N '),SALT39.HygieneErrors.NotLength('2'),SALT39.HygieneErrors.NotWords('1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_end_user_city(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz-,\'. '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  MakeFT_NAME(s3);
END;
EXPORT InValidFT_orig_end_user_city(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz-,\'. '))),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 2 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 3));
EXPORT InValidMessageFT_orig_end_user_city(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz-,\'. '),SALT39.HygieneErrors.NotWords('0,1,2,3'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_end_user_state(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz-,\'. '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  MakeFT_NAME(s3);
END;
EXPORT InValidFT_orig_end_user_state(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz-,\'. '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 2),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_end_user_state(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz-,\'. '),SALT39.HygieneErrors.NotLength('0,2'),SALT39.HygieneErrors.NotWords('0,1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_end_user_zip(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  MakeFT_NUMBER(s3);
END;
EXPORT InValidFT_orig_end_user_zip(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789 '))),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_end_user_zip(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('0123456789 '),SALT39.HygieneErrors.NotWords('0,1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_login_history_id(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_login_history_id(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0 '))),~(LENGTH(TRIM(s)) = 1),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_login_history_id(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('0 '),SALT39.HygieneErrors.NotLength('1'),SALT39.HygieneErrors.NotWords('1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_employment_state(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'N '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_employment_state(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'N '))),~(LENGTH(TRIM(s)) = 2),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_employment_state(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('N '),SALT39.HygieneErrors.NotLength('2'),SALT39.HygieneErrors.NotWords('1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_end_user_industry_class(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_end_user_industry_class(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0 '))),~(LENGTH(TRIM(s)) = 1),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_end_user_industry_class(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('0 '),SALT39.HygieneErrors.NotLength('1'),SALT39.HygieneErrors.NotWords('1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_function_specific_data(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'N '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_function_specific_data(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'N '))),~(LENGTH(TRIM(s)) = 2),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_function_specific_data(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('N '),SALT39.HygieneErrors.NotLength('2'),SALT39.HygieneErrors.NotWords('1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_date_added(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,' -0123456789: '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_date_added(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,' -0123456789: '))),~(LENGTH(TRIM(s)) = 19),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 2));
EXPORT InValidMessageFT_orig_date_added(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars(' -0123456789: '),SALT39.HygieneErrors.NotLength('19'),SALT39.HygieneErrors.NotWords('2'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_retail_price(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s0,' ',' ') ); // Insert spaces but avoid doubles
  s2 := TRIM(s1,LEFT); // Left trim
  RETURN  s2;
END;
EXPORT InValidFT_orig_retail_price(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_retail_price(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotWords('1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_country_code(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'N '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_country_code(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'N '))),~(LENGTH(TRIM(s)) = 2),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_country_code(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('N '),SALT39.HygieneErrors.NotLength('2'),SALT39.HygieneErrors.NotWords('1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_email(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$; '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  MakeFT_WORDBAG(s3);
END;
EXPORT InValidFT_orig_email(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$; '))),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_email(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$; '),SALT39.HygieneErrors.NotWords('1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_email_2(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'N '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_email_2(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'N '))),~(LENGTH(TRIM(s)) = 2),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_email_2(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('N '),SALT39.HygieneErrors.NotLength('2'),SALT39.HygieneErrors.NotWords('1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_dl_number(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$; '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  MakeFT_WORDBAG(s3);
END;
EXPORT InValidFT_orig_dl_number(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$; '))),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_dl_number(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$; '),SALT39.HygieneErrors.NotWords('1,0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_dl_number_2(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'N '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_dl_number_2(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'N '))),~(LENGTH(TRIM(s)) = 2),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_dl_number_2(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('N '),SALT39.HygieneErrors.NotLength('2'),SALT39.HygieneErrors.NotWords('1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_sub_id(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$; '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  MakeFT_WORDBAG(s3);
END;
EXPORT InValidFT_orig_sub_id(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$; '))),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 2 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 3));
EXPORT InValidMessageFT_orig_sub_id(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$; '),SALT39.HygieneErrors.NotWords('1,2,3'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_neighbors(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_neighbors(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0 '))),~(LENGTH(TRIM(s)) = 1),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_neighbors(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('0 '),SALT39.HygieneErrors.NotLength('1'),SALT39.HygieneErrors.NotWords('1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_relatives(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_relatives(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0 '))),~(LENGTH(TRIM(s)) = 1),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_relatives(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('0 '),SALT39.HygieneErrors.NotLength('1'),SALT39.HygieneErrors.NotWords('1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_associates(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_associates(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0 '))),~(LENGTH(TRIM(s)) = 1),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_associates(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('0 '),SALT39.HygieneErrors.NotLength('1'),SALT39.HygieneErrors.NotWords('1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_property(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_property(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0 '))),~(LENGTH(TRIM(s)) = 1),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_property(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('0 '),SALT39.HygieneErrors.NotLength('1'),SALT39.HygieneErrors.NotWords('1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_bankruptcy(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_bankruptcy(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0 '))),~(LENGTH(TRIM(s)) = 1),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_bankruptcy(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('0 '),SALT39.HygieneErrors.NotLength('1'),SALT39.HygieneErrors.NotWords('1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_dls(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_dls(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0 '))),~(LENGTH(TRIM(s)) = 1),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_dls(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('0 '),SALT39.HygieneErrors.NotLength('1'),SALT39.HygieneErrors.NotWords('1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_mvs(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_mvs(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0 '))),~(LENGTH(TRIM(s)) = 1),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_mvs(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('0 '),SALT39.HygieneErrors.NotLength('1'),SALT39.HygieneErrors.NotWords('1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_ip_address(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s0,' ',' ') ); // Insert spaces but avoid doubles
  s2 := TRIM(s1,LEFT); // Left trim
  RETURN  s2;
END;
EXPORT InValidFT_orig_ip_address(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_ip_address(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotWords('1,0'),SALT39.HygieneErrors.Good);
 
EXPORT SALT39.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'orig_login_id','orig_billing_code','orig_transaction_id','orig_function_name','orig_company_id','orig_reference_code','orig_fname','orig_mname','orig_lname','orig_name_suffix','orig_fname_2','orig_mname_2','orig_lname_2','orig_name_suffix_2','orig_address','orig_city','orig_state','orig_zip','orig_zip4','orig_address_2','orig_city_2','orig_state_2','orig_zip_2','orig_zip4_2','orig_clean_address','orig_clean_city','orig_clean_state','orig_clean_zip','orig_clean_zip4','orig_phone','orig_homephone','orig_homephone_2','orig_workphone','orig_workphone_2','orig_ssn','orig_ssn_2','orig_free','orig_record_count','orig_price','orig_revenue','orig_full_name','orig_business_name','orig_business_name_2','orig_years','orig_pricing_error_code','orig_fcra_purpose','orig_result_format','orig_dob','orig_dob_2','orig_unique_id','orig_response_time','orig_data_source','orig_report_options','orig_end_user_name','orig_end_user_address_1','orig_end_user_address_2','orig_end_user_city','orig_end_user_state','orig_end_user_zip','orig_login_history_id','orig_employment_state','orig_end_user_industry_class','orig_function_specific_data','orig_date_added','orig_retail_price','orig_country_code','orig_email','orig_email_2','orig_dl_number','orig_dl_number_2','orig_sub_id','orig_neighbors','orig_relatives','orig_associates','orig_property','orig_bankruptcy','orig_dls','orig_mvs','orig_ip_address');
EXPORT SALT39.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'orig_login_id','orig_billing_code','orig_transaction_id','orig_function_name','orig_company_id','orig_reference_code','orig_fname','orig_mname','orig_lname','orig_name_suffix','orig_fname_2','orig_mname_2','orig_lname_2','orig_name_suffix_2','orig_address','orig_city','orig_state','orig_zip','orig_zip4','orig_address_2','orig_city_2','orig_state_2','orig_zip_2','orig_zip4_2','orig_clean_address','orig_clean_city','orig_clean_state','orig_clean_zip','orig_clean_zip4','orig_phone','orig_homephone','orig_homephone_2','orig_workphone','orig_workphone_2','orig_ssn','orig_ssn_2','orig_free','orig_record_count','orig_price','orig_revenue','orig_full_name','orig_business_name','orig_business_name_2','orig_years','orig_pricing_error_code','orig_fcra_purpose','orig_result_format','orig_dob','orig_dob_2','orig_unique_id','orig_response_time','orig_data_source','orig_report_options','orig_end_user_name','orig_end_user_address_1','orig_end_user_address_2','orig_end_user_city','orig_end_user_state','orig_end_user_zip','orig_login_history_id','orig_employment_state','orig_end_user_industry_class','orig_function_specific_data','orig_date_added','orig_retail_price','orig_country_code','orig_email','orig_email_2','orig_dl_number','orig_dl_number_2','orig_sub_id','orig_neighbors','orig_relatives','orig_associates','orig_property','orig_bankruptcy','orig_dls','orig_mvs','orig_ip_address');
EXPORT FieldNum(SALT39.StrType fn) := CASE(fn,'orig_login_id' => 0,'orig_billing_code' => 1,'orig_transaction_id' => 2,'orig_function_name' => 3,'orig_company_id' => 4,'orig_reference_code' => 5,'orig_fname' => 6,'orig_mname' => 7,'orig_lname' => 8,'orig_name_suffix' => 9,'orig_fname_2' => 10,'orig_mname_2' => 11,'orig_lname_2' => 12,'orig_name_suffix_2' => 13,'orig_address' => 14,'orig_city' => 15,'orig_state' => 16,'orig_zip' => 17,'orig_zip4' => 18,'orig_address_2' => 19,'orig_city_2' => 20,'orig_state_2' => 21,'orig_zip_2' => 22,'orig_zip4_2' => 23,'orig_clean_address' => 24,'orig_clean_city' => 25,'orig_clean_state' => 26,'orig_clean_zip' => 27,'orig_clean_zip4' => 28,'orig_phone' => 29,'orig_homephone' => 30,'orig_homephone_2' => 31,'orig_workphone' => 32,'orig_workphone_2' => 33,'orig_ssn' => 34,'orig_ssn_2' => 35,'orig_free' => 36,'orig_record_count' => 37,'orig_price' => 38,'orig_revenue' => 39,'orig_full_name' => 40,'orig_business_name' => 41,'orig_business_name_2' => 42,'orig_years' => 43,'orig_pricing_error_code' => 44,'orig_fcra_purpose' => 45,'orig_result_format' => 46,'orig_dob' => 47,'orig_dob_2' => 48,'orig_unique_id' => 49,'orig_response_time' => 50,'orig_data_source' => 51,'orig_report_options' => 52,'orig_end_user_name' => 53,'orig_end_user_address_1' => 54,'orig_end_user_address_2' => 55,'orig_end_user_city' => 56,'orig_end_user_state' => 57,'orig_end_user_zip' => 58,'orig_login_history_id' => 59,'orig_employment_state' => 60,'orig_end_user_industry_class' => 61,'orig_function_specific_data' => 62,'orig_date_added' => 63,'orig_retail_price' => 64,'orig_country_code' => 65,'orig_email' => 66,'orig_email_2' => 67,'orig_dl_number' => 68,'orig_dl_number_2' => 69,'orig_sub_id' => 70,'orig_neighbors' => 71,'orig_relatives' => 72,'orig_associates' => 73,'orig_property' => 74,'orig_bankruptcy' => 75,'orig_dls' => 76,'orig_mvs' => 77,'orig_ip_address' => 78,0);
EXPORT SET OF SALT39.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['ALLOW','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','WORDS'],['LEFTTRIM','ALLOW','WORDS'],['LEFTTRIM','ALLOW','WORDS'],['ALLOW','WORDS'],['ALLOW','WORDS'],['ALLOW','WORDS'],['ALLOW','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW'],['LEFTTRIM','ALLOW','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','WORDS'],['ALLOW','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','WORDS'],['LEFTTRIM','ALLOW'],['LEFTTRIM','ALLOW'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','WORDS'],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_orig_login_id(SALT39.StrType s0) := MakeFT_orig_login_id(s0);
EXPORT InValid_orig_login_id(SALT39.StrType s) := InValidFT_orig_login_id(s);
EXPORT InValidMessage_orig_login_id(UNSIGNED1 wh) := InValidMessageFT_orig_login_id(wh);
 
EXPORT Make_orig_billing_code(SALT39.StrType s0) := MakeFT_orig_billing_code(s0);
EXPORT InValid_orig_billing_code(SALT39.StrType s) := InValidFT_orig_billing_code(s);
EXPORT InValidMessage_orig_billing_code(UNSIGNED1 wh) := InValidMessageFT_orig_billing_code(wh);
 
EXPORT Make_orig_transaction_id(SALT39.StrType s0) := MakeFT_orig_transaction_id(s0);
EXPORT InValid_orig_transaction_id(SALT39.StrType s) := InValidFT_orig_transaction_id(s);
EXPORT InValidMessage_orig_transaction_id(UNSIGNED1 wh) := InValidMessageFT_orig_transaction_id(wh);
 
EXPORT Make_orig_function_name(SALT39.StrType s0) := MakeFT_orig_function_name(s0);
EXPORT InValid_orig_function_name(SALT39.StrType s) := InValidFT_orig_function_name(s);
EXPORT InValidMessage_orig_function_name(UNSIGNED1 wh) := InValidMessageFT_orig_function_name(wh);
 
EXPORT Make_orig_company_id(SALT39.StrType s0) := MakeFT_orig_company_id(s0);
EXPORT InValid_orig_company_id(SALT39.StrType s) := InValidFT_orig_company_id(s);
EXPORT InValidMessage_orig_company_id(UNSIGNED1 wh) := InValidMessageFT_orig_company_id(wh);
 
EXPORT Make_orig_reference_code(SALT39.StrType s0) := MakeFT_orig_reference_code(s0);
EXPORT InValid_orig_reference_code(SALT39.StrType s) := InValidFT_orig_reference_code(s);
EXPORT InValidMessage_orig_reference_code(UNSIGNED1 wh) := InValidMessageFT_orig_reference_code(wh);
 
EXPORT Make_orig_fname(SALT39.StrType s0) := MakeFT_orig_fname(s0);
EXPORT InValid_orig_fname(SALT39.StrType s) := InValidFT_orig_fname(s);
EXPORT InValidMessage_orig_fname(UNSIGNED1 wh) := InValidMessageFT_orig_fname(wh);
 
EXPORT Make_orig_mname(SALT39.StrType s0) := MakeFT_orig_mname(s0);
EXPORT InValid_orig_mname(SALT39.StrType s) := InValidFT_orig_mname(s);
EXPORT InValidMessage_orig_mname(UNSIGNED1 wh) := InValidMessageFT_orig_mname(wh);
 
EXPORT Make_orig_lname(SALT39.StrType s0) := MakeFT_orig_lname(s0);
EXPORT InValid_orig_lname(SALT39.StrType s) := InValidFT_orig_lname(s);
EXPORT InValidMessage_orig_lname(UNSIGNED1 wh) := InValidMessageFT_orig_lname(wh);
 
EXPORT Make_orig_name_suffix(SALT39.StrType s0) := MakeFT_orig_name_suffix(s0);
EXPORT InValid_orig_name_suffix(SALT39.StrType s) := InValidFT_orig_name_suffix(s);
EXPORT InValidMessage_orig_name_suffix(UNSIGNED1 wh) := InValidMessageFT_orig_name_suffix(wh);
 
EXPORT Make_orig_fname_2(SALT39.StrType s0) := MakeFT_orig_fname_2(s0);
EXPORT InValid_orig_fname_2(SALT39.StrType s) := InValidFT_orig_fname_2(s);
EXPORT InValidMessage_orig_fname_2(UNSIGNED1 wh) := InValidMessageFT_orig_fname_2(wh);
 
EXPORT Make_orig_mname_2(SALT39.StrType s0) := MakeFT_orig_mname_2(s0);
EXPORT InValid_orig_mname_2(SALT39.StrType s) := InValidFT_orig_mname_2(s);
EXPORT InValidMessage_orig_mname_2(UNSIGNED1 wh) := InValidMessageFT_orig_mname_2(wh);
 
EXPORT Make_orig_lname_2(SALT39.StrType s0) := MakeFT_orig_lname_2(s0);
EXPORT InValid_orig_lname_2(SALT39.StrType s) := InValidFT_orig_lname_2(s);
EXPORT InValidMessage_orig_lname_2(UNSIGNED1 wh) := InValidMessageFT_orig_lname_2(wh);
 
EXPORT Make_orig_name_suffix_2(SALT39.StrType s0) := MakeFT_orig_name_suffix_2(s0);
EXPORT InValid_orig_name_suffix_2(SALT39.StrType s) := InValidFT_orig_name_suffix_2(s);
EXPORT InValidMessage_orig_name_suffix_2(UNSIGNED1 wh) := InValidMessageFT_orig_name_suffix_2(wh);
 
EXPORT Make_orig_address(SALT39.StrType s0) := MakeFT_orig_address(s0);
EXPORT InValid_orig_address(SALT39.StrType s) := InValidFT_orig_address(s);
EXPORT InValidMessage_orig_address(UNSIGNED1 wh) := InValidMessageFT_orig_address(wh);
 
EXPORT Make_orig_city(SALT39.StrType s0) := MakeFT_orig_city(s0);
EXPORT InValid_orig_city(SALT39.StrType s) := InValidFT_orig_city(s);
EXPORT InValidMessage_orig_city(UNSIGNED1 wh) := InValidMessageFT_orig_city(wh);
 
EXPORT Make_orig_state(SALT39.StrType s0) := MakeFT_orig_state(s0);
EXPORT InValid_orig_state(SALT39.StrType s) := InValidFT_orig_state(s);
EXPORT InValidMessage_orig_state(UNSIGNED1 wh) := InValidMessageFT_orig_state(wh);
 
EXPORT Make_orig_zip(SALT39.StrType s0) := MakeFT_orig_zip(s0);
EXPORT InValid_orig_zip(SALT39.StrType s) := InValidFT_orig_zip(s);
EXPORT InValidMessage_orig_zip(UNSIGNED1 wh) := InValidMessageFT_orig_zip(wh);
 
EXPORT Make_orig_zip4(SALT39.StrType s0) := MakeFT_orig_zip4(s0);
EXPORT InValid_orig_zip4(SALT39.StrType s) := InValidFT_orig_zip4(s);
EXPORT InValidMessage_orig_zip4(UNSIGNED1 wh) := InValidMessageFT_orig_zip4(wh);
 
EXPORT Make_orig_address_2(SALT39.StrType s0) := MakeFT_orig_address_2(s0);
EXPORT InValid_orig_address_2(SALT39.StrType s) := InValidFT_orig_address_2(s);
EXPORT InValidMessage_orig_address_2(UNSIGNED1 wh) := InValidMessageFT_orig_address_2(wh);
 
EXPORT Make_orig_city_2(SALT39.StrType s0) := MakeFT_orig_city_2(s0);
EXPORT InValid_orig_city_2(SALT39.StrType s) := InValidFT_orig_city_2(s);
EXPORT InValidMessage_orig_city_2(UNSIGNED1 wh) := InValidMessageFT_orig_city_2(wh);
 
EXPORT Make_orig_state_2(SALT39.StrType s0) := MakeFT_orig_state_2(s0);
EXPORT InValid_orig_state_2(SALT39.StrType s) := InValidFT_orig_state_2(s);
EXPORT InValidMessage_orig_state_2(UNSIGNED1 wh) := InValidMessageFT_orig_state_2(wh);
 
EXPORT Make_orig_zip_2(SALT39.StrType s0) := MakeFT_orig_zip_2(s0);
EXPORT InValid_orig_zip_2(SALT39.StrType s) := InValidFT_orig_zip_2(s);
EXPORT InValidMessage_orig_zip_2(UNSIGNED1 wh) := InValidMessageFT_orig_zip_2(wh);
 
EXPORT Make_orig_zip4_2(SALT39.StrType s0) := MakeFT_orig_zip4_2(s0);
EXPORT InValid_orig_zip4_2(SALT39.StrType s) := InValidFT_orig_zip4_2(s);
EXPORT InValidMessage_orig_zip4_2(UNSIGNED1 wh) := InValidMessageFT_orig_zip4_2(wh);
 
EXPORT Make_orig_clean_address(SALT39.StrType s0) := MakeFT_orig_clean_address(s0);
EXPORT InValid_orig_clean_address(SALT39.StrType s) := InValidFT_orig_clean_address(s);
EXPORT InValidMessage_orig_clean_address(UNSIGNED1 wh) := InValidMessageFT_orig_clean_address(wh);
 
EXPORT Make_orig_clean_city(SALT39.StrType s0) := MakeFT_orig_clean_city(s0);
EXPORT InValid_orig_clean_city(SALT39.StrType s) := InValidFT_orig_clean_city(s);
EXPORT InValidMessage_orig_clean_city(UNSIGNED1 wh) := InValidMessageFT_orig_clean_city(wh);
 
EXPORT Make_orig_clean_state(SALT39.StrType s0) := MakeFT_orig_clean_state(s0);
EXPORT InValid_orig_clean_state(SALT39.StrType s) := InValidFT_orig_clean_state(s);
EXPORT InValidMessage_orig_clean_state(UNSIGNED1 wh) := InValidMessageFT_orig_clean_state(wh);
 
EXPORT Make_orig_clean_zip(SALT39.StrType s0) := MakeFT_orig_clean_zip(s0);
EXPORT InValid_orig_clean_zip(SALT39.StrType s) := InValidFT_orig_clean_zip(s);
EXPORT InValidMessage_orig_clean_zip(UNSIGNED1 wh) := InValidMessageFT_orig_clean_zip(wh);
 
EXPORT Make_orig_clean_zip4(SALT39.StrType s0) := MakeFT_orig_clean_zip4(s0);
EXPORT InValid_orig_clean_zip4(SALT39.StrType s) := InValidFT_orig_clean_zip4(s);
EXPORT InValidMessage_orig_clean_zip4(UNSIGNED1 wh) := InValidMessageFT_orig_clean_zip4(wh);
 
EXPORT Make_orig_phone(SALT39.StrType s0) := MakeFT_orig_phone(s0);
EXPORT InValid_orig_phone(SALT39.StrType s) := InValidFT_orig_phone(s);
EXPORT InValidMessage_orig_phone(UNSIGNED1 wh) := InValidMessageFT_orig_phone(wh);
 
EXPORT Make_orig_homephone(SALT39.StrType s0) := MakeFT_orig_homephone(s0);
EXPORT InValid_orig_homephone(SALT39.StrType s) := InValidFT_orig_homephone(s);
EXPORT InValidMessage_orig_homephone(UNSIGNED1 wh) := InValidMessageFT_orig_homephone(wh);
 
EXPORT Make_orig_homephone_2(SALT39.StrType s0) := MakeFT_orig_homephone_2(s0);
EXPORT InValid_orig_homephone_2(SALT39.StrType s) := InValidFT_orig_homephone_2(s);
EXPORT InValidMessage_orig_homephone_2(UNSIGNED1 wh) := InValidMessageFT_orig_homephone_2(wh);
 
EXPORT Make_orig_workphone(SALT39.StrType s0) := MakeFT_orig_workphone(s0);
EXPORT InValid_orig_workphone(SALT39.StrType s) := InValidFT_orig_workphone(s);
EXPORT InValidMessage_orig_workphone(UNSIGNED1 wh) := InValidMessageFT_orig_workphone(wh);
 
EXPORT Make_orig_workphone_2(SALT39.StrType s0) := MakeFT_orig_workphone_2(s0);
EXPORT InValid_orig_workphone_2(SALT39.StrType s) := InValidFT_orig_workphone_2(s);
EXPORT InValidMessage_orig_workphone_2(UNSIGNED1 wh) := InValidMessageFT_orig_workphone_2(wh);
 
EXPORT Make_orig_ssn(SALT39.StrType s0) := MakeFT_orig_ssn(s0);
EXPORT InValid_orig_ssn(SALT39.StrType s) := InValidFT_orig_ssn(s);
EXPORT InValidMessage_orig_ssn(UNSIGNED1 wh) := InValidMessageFT_orig_ssn(wh);
 
EXPORT Make_orig_ssn_2(SALT39.StrType s0) := MakeFT_orig_ssn_2(s0);
EXPORT InValid_orig_ssn_2(SALT39.StrType s) := InValidFT_orig_ssn_2(s);
EXPORT InValidMessage_orig_ssn_2(UNSIGNED1 wh) := InValidMessageFT_orig_ssn_2(wh);
 
EXPORT Make_orig_free(SALT39.StrType s0) := MakeFT_orig_free(s0);
EXPORT InValid_orig_free(SALT39.StrType s) := InValidFT_orig_free(s);
EXPORT InValidMessage_orig_free(UNSIGNED1 wh) := InValidMessageFT_orig_free(wh);
 
EXPORT Make_orig_record_count(SALT39.StrType s0) := MakeFT_orig_record_count(s0);
EXPORT InValid_orig_record_count(SALT39.StrType s) := InValidFT_orig_record_count(s);
EXPORT InValidMessage_orig_record_count(UNSIGNED1 wh) := InValidMessageFT_orig_record_count(wh);
 
EXPORT Make_orig_price(SALT39.StrType s0) := MakeFT_orig_price(s0);
EXPORT InValid_orig_price(SALT39.StrType s) := InValidFT_orig_price(s);
EXPORT InValidMessage_orig_price(UNSIGNED1 wh) := InValidMessageFT_orig_price(wh);
 
EXPORT Make_orig_revenue(SALT39.StrType s0) := MakeFT_orig_revenue(s0);
EXPORT InValid_orig_revenue(SALT39.StrType s) := InValidFT_orig_revenue(s);
EXPORT InValidMessage_orig_revenue(UNSIGNED1 wh) := InValidMessageFT_orig_revenue(wh);
 
EXPORT Make_orig_full_name(SALT39.StrType s0) := MakeFT_orig_full_name(s0);
EXPORT InValid_orig_full_name(SALT39.StrType s) := InValidFT_orig_full_name(s);
EXPORT InValidMessage_orig_full_name(UNSIGNED1 wh) := InValidMessageFT_orig_full_name(wh);
 
EXPORT Make_orig_business_name(SALT39.StrType s0) := MakeFT_orig_business_name(s0);
EXPORT InValid_orig_business_name(SALT39.StrType s) := InValidFT_orig_business_name(s);
EXPORT InValidMessage_orig_business_name(UNSIGNED1 wh) := InValidMessageFT_orig_business_name(wh);
 
EXPORT Make_orig_business_name_2(SALT39.StrType s0) := MakeFT_orig_business_name_2(s0);
EXPORT InValid_orig_business_name_2(SALT39.StrType s) := InValidFT_orig_business_name_2(s);
EXPORT InValidMessage_orig_business_name_2(UNSIGNED1 wh) := InValidMessageFT_orig_business_name_2(wh);
 
EXPORT Make_orig_years(SALT39.StrType s0) := MakeFT_orig_years(s0);
EXPORT InValid_orig_years(SALT39.StrType s) := InValidFT_orig_years(s);
EXPORT InValidMessage_orig_years(UNSIGNED1 wh) := InValidMessageFT_orig_years(wh);
 
EXPORT Make_orig_pricing_error_code(SALT39.StrType s0) := MakeFT_orig_pricing_error_code(s0);
EXPORT InValid_orig_pricing_error_code(SALT39.StrType s) := InValidFT_orig_pricing_error_code(s);
EXPORT InValidMessage_orig_pricing_error_code(UNSIGNED1 wh) := InValidMessageFT_orig_pricing_error_code(wh);
 
EXPORT Make_orig_fcra_purpose(SALT39.StrType s0) := MakeFT_orig_fcra_purpose(s0);
EXPORT InValid_orig_fcra_purpose(SALT39.StrType s) := InValidFT_orig_fcra_purpose(s);
EXPORT InValidMessage_orig_fcra_purpose(UNSIGNED1 wh) := InValidMessageFT_orig_fcra_purpose(wh);
 
EXPORT Make_orig_result_format(SALT39.StrType s0) := MakeFT_orig_result_format(s0);
EXPORT InValid_orig_result_format(SALT39.StrType s) := InValidFT_orig_result_format(s);
EXPORT InValidMessage_orig_result_format(UNSIGNED1 wh) := InValidMessageFT_orig_result_format(wh);
 
EXPORT Make_orig_dob(SALT39.StrType s0) := MakeFT_orig_dob(s0);
EXPORT InValid_orig_dob(SALT39.StrType s) := InValidFT_orig_dob(s);
EXPORT InValidMessage_orig_dob(UNSIGNED1 wh) := InValidMessageFT_orig_dob(wh);
 
EXPORT Make_orig_dob_2(SALT39.StrType s0) := MakeFT_orig_dob_2(s0);
EXPORT InValid_orig_dob_2(SALT39.StrType s) := InValidFT_orig_dob_2(s);
EXPORT InValidMessage_orig_dob_2(UNSIGNED1 wh) := InValidMessageFT_orig_dob_2(wh);
 
EXPORT Make_orig_unique_id(SALT39.StrType s0) := MakeFT_orig_unique_id(s0);
EXPORT InValid_orig_unique_id(SALT39.StrType s) := InValidFT_orig_unique_id(s);
EXPORT InValidMessage_orig_unique_id(UNSIGNED1 wh) := InValidMessageFT_orig_unique_id(wh);
 
EXPORT Make_orig_response_time(SALT39.StrType s0) := MakeFT_orig_response_time(s0);
EXPORT InValid_orig_response_time(SALT39.StrType s) := InValidFT_orig_response_time(s);
EXPORT InValidMessage_orig_response_time(UNSIGNED1 wh) := InValidMessageFT_orig_response_time(wh);
 
EXPORT Make_orig_data_source(SALT39.StrType s0) := MakeFT_orig_data_source(s0);
EXPORT InValid_orig_data_source(SALT39.StrType s) := InValidFT_orig_data_source(s);
EXPORT InValidMessage_orig_data_source(UNSIGNED1 wh) := InValidMessageFT_orig_data_source(wh);
 
EXPORT Make_orig_report_options(SALT39.StrType s0) := MakeFT_orig_report_options(s0);
EXPORT InValid_orig_report_options(SALT39.StrType s) := InValidFT_orig_report_options(s);
EXPORT InValidMessage_orig_report_options(UNSIGNED1 wh) := InValidMessageFT_orig_report_options(wh);
 
EXPORT Make_orig_end_user_name(SALT39.StrType s0) := MakeFT_orig_end_user_name(s0);
EXPORT InValid_orig_end_user_name(SALT39.StrType s) := InValidFT_orig_end_user_name(s);
EXPORT InValidMessage_orig_end_user_name(UNSIGNED1 wh) := InValidMessageFT_orig_end_user_name(wh);
 
EXPORT Make_orig_end_user_address_1(SALT39.StrType s0) := MakeFT_orig_end_user_address_1(s0);
EXPORT InValid_orig_end_user_address_1(SALT39.StrType s) := InValidFT_orig_end_user_address_1(s);
EXPORT InValidMessage_orig_end_user_address_1(UNSIGNED1 wh) := InValidMessageFT_orig_end_user_address_1(wh);
 
EXPORT Make_orig_end_user_address_2(SALT39.StrType s0) := MakeFT_orig_end_user_address_2(s0);
EXPORT InValid_orig_end_user_address_2(SALT39.StrType s) := InValidFT_orig_end_user_address_2(s);
EXPORT InValidMessage_orig_end_user_address_2(UNSIGNED1 wh) := InValidMessageFT_orig_end_user_address_2(wh);
 
EXPORT Make_orig_end_user_city(SALT39.StrType s0) := MakeFT_orig_end_user_city(s0);
EXPORT InValid_orig_end_user_city(SALT39.StrType s) := InValidFT_orig_end_user_city(s);
EXPORT InValidMessage_orig_end_user_city(UNSIGNED1 wh) := InValidMessageFT_orig_end_user_city(wh);
 
EXPORT Make_orig_end_user_state(SALT39.StrType s0) := MakeFT_orig_end_user_state(s0);
EXPORT InValid_orig_end_user_state(SALT39.StrType s) := InValidFT_orig_end_user_state(s);
EXPORT InValidMessage_orig_end_user_state(UNSIGNED1 wh) := InValidMessageFT_orig_end_user_state(wh);
 
EXPORT Make_orig_end_user_zip(SALT39.StrType s0) := MakeFT_orig_end_user_zip(s0);
EXPORT InValid_orig_end_user_zip(SALT39.StrType s) := InValidFT_orig_end_user_zip(s);
EXPORT InValidMessage_orig_end_user_zip(UNSIGNED1 wh) := InValidMessageFT_orig_end_user_zip(wh);
 
EXPORT Make_orig_login_history_id(SALT39.StrType s0) := MakeFT_orig_login_history_id(s0);
EXPORT InValid_orig_login_history_id(SALT39.StrType s) := InValidFT_orig_login_history_id(s);
EXPORT InValidMessage_orig_login_history_id(UNSIGNED1 wh) := InValidMessageFT_orig_login_history_id(wh);
 
EXPORT Make_orig_employment_state(SALT39.StrType s0) := MakeFT_orig_employment_state(s0);
EXPORT InValid_orig_employment_state(SALT39.StrType s) := InValidFT_orig_employment_state(s);
EXPORT InValidMessage_orig_employment_state(UNSIGNED1 wh) := InValidMessageFT_orig_employment_state(wh);
 
EXPORT Make_orig_end_user_industry_class(SALT39.StrType s0) := MakeFT_orig_end_user_industry_class(s0);
EXPORT InValid_orig_end_user_industry_class(SALT39.StrType s) := InValidFT_orig_end_user_industry_class(s);
EXPORT InValidMessage_orig_end_user_industry_class(UNSIGNED1 wh) := InValidMessageFT_orig_end_user_industry_class(wh);
 
EXPORT Make_orig_function_specific_data(SALT39.StrType s0) := MakeFT_orig_function_specific_data(s0);
EXPORT InValid_orig_function_specific_data(SALT39.StrType s) := InValidFT_orig_function_specific_data(s);
EXPORT InValidMessage_orig_function_specific_data(UNSIGNED1 wh) := InValidMessageFT_orig_function_specific_data(wh);
 
EXPORT Make_orig_date_added(SALT39.StrType s0) := MakeFT_orig_date_added(s0);
EXPORT InValid_orig_date_added(SALT39.StrType s) := InValidFT_orig_date_added(s);
EXPORT InValidMessage_orig_date_added(UNSIGNED1 wh) := InValidMessageFT_orig_date_added(wh);
 
EXPORT Make_orig_retail_price(SALT39.StrType s0) := MakeFT_orig_retail_price(s0);
EXPORT InValid_orig_retail_price(SALT39.StrType s) := InValidFT_orig_retail_price(s);
EXPORT InValidMessage_orig_retail_price(UNSIGNED1 wh) := InValidMessageFT_orig_retail_price(wh);
 
EXPORT Make_orig_country_code(SALT39.StrType s0) := MakeFT_orig_country_code(s0);
EXPORT InValid_orig_country_code(SALT39.StrType s) := InValidFT_orig_country_code(s);
EXPORT InValidMessage_orig_country_code(UNSIGNED1 wh) := InValidMessageFT_orig_country_code(wh);
 
EXPORT Make_orig_email(SALT39.StrType s0) := MakeFT_orig_email(s0);
EXPORT InValid_orig_email(SALT39.StrType s) := InValidFT_orig_email(s);
EXPORT InValidMessage_orig_email(UNSIGNED1 wh) := InValidMessageFT_orig_email(wh);
 
EXPORT Make_orig_email_2(SALT39.StrType s0) := MakeFT_orig_email_2(s0);
EXPORT InValid_orig_email_2(SALT39.StrType s) := InValidFT_orig_email_2(s);
EXPORT InValidMessage_orig_email_2(UNSIGNED1 wh) := InValidMessageFT_orig_email_2(wh);
 
EXPORT Make_orig_dl_number(SALT39.StrType s0) := MakeFT_orig_dl_number(s0);
EXPORT InValid_orig_dl_number(SALT39.StrType s) := InValidFT_orig_dl_number(s);
EXPORT InValidMessage_orig_dl_number(UNSIGNED1 wh) := InValidMessageFT_orig_dl_number(wh);
 
EXPORT Make_orig_dl_number_2(SALT39.StrType s0) := MakeFT_orig_dl_number_2(s0);
EXPORT InValid_orig_dl_number_2(SALT39.StrType s) := InValidFT_orig_dl_number_2(s);
EXPORT InValidMessage_orig_dl_number_2(UNSIGNED1 wh) := InValidMessageFT_orig_dl_number_2(wh);
 
EXPORT Make_orig_sub_id(SALT39.StrType s0) := MakeFT_orig_sub_id(s0);
EXPORT InValid_orig_sub_id(SALT39.StrType s) := InValidFT_orig_sub_id(s);
EXPORT InValidMessage_orig_sub_id(UNSIGNED1 wh) := InValidMessageFT_orig_sub_id(wh);
 
EXPORT Make_orig_neighbors(SALT39.StrType s0) := MakeFT_orig_neighbors(s0);
EXPORT InValid_orig_neighbors(SALT39.StrType s) := InValidFT_orig_neighbors(s);
EXPORT InValidMessage_orig_neighbors(UNSIGNED1 wh) := InValidMessageFT_orig_neighbors(wh);
 
EXPORT Make_orig_relatives(SALT39.StrType s0) := MakeFT_orig_relatives(s0);
EXPORT InValid_orig_relatives(SALT39.StrType s) := InValidFT_orig_relatives(s);
EXPORT InValidMessage_orig_relatives(UNSIGNED1 wh) := InValidMessageFT_orig_relatives(wh);
 
EXPORT Make_orig_associates(SALT39.StrType s0) := MakeFT_orig_associates(s0);
EXPORT InValid_orig_associates(SALT39.StrType s) := InValidFT_orig_associates(s);
EXPORT InValidMessage_orig_associates(UNSIGNED1 wh) := InValidMessageFT_orig_associates(wh);
 
EXPORT Make_orig_property(SALT39.StrType s0) := MakeFT_orig_property(s0);
EXPORT InValid_orig_property(SALT39.StrType s) := InValidFT_orig_property(s);
EXPORT InValidMessage_orig_property(UNSIGNED1 wh) := InValidMessageFT_orig_property(wh);
 
EXPORT Make_orig_bankruptcy(SALT39.StrType s0) := MakeFT_orig_bankruptcy(s0);
EXPORT InValid_orig_bankruptcy(SALT39.StrType s) := InValidFT_orig_bankruptcy(s);
EXPORT InValidMessage_orig_bankruptcy(UNSIGNED1 wh) := InValidMessageFT_orig_bankruptcy(wh);
 
EXPORT Make_orig_dls(SALT39.StrType s0) := MakeFT_orig_dls(s0);
EXPORT InValid_orig_dls(SALT39.StrType s) := InValidFT_orig_dls(s);
EXPORT InValidMessage_orig_dls(UNSIGNED1 wh) := InValidMessageFT_orig_dls(wh);
 
EXPORT Make_orig_mvs(SALT39.StrType s0) := MakeFT_orig_mvs(s0);
EXPORT InValid_orig_mvs(SALT39.StrType s) := InValidFT_orig_mvs(s);
EXPORT InValidMessage_orig_mvs(UNSIGNED1 wh) := InValidMessageFT_orig_mvs(wh);
 
EXPORT Make_orig_ip_address(SALT39.StrType s0) := MakeFT_orig_ip_address(s0);
EXPORT InValid_orig_ip_address(SALT39.StrType s) := InValidFT_orig_ip_address(s);
EXPORT InValidMessage_orig_ip_address(UNSIGNED1 wh) := InValidMessageFT_orig_ip_address(wh);
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT39,Scrubs_Inql_fcra_Riskwise;
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
    BOOLEAN Diff_orig_login_id;
    BOOLEAN Diff_orig_billing_code;
    BOOLEAN Diff_orig_transaction_id;
    BOOLEAN Diff_orig_function_name;
    BOOLEAN Diff_orig_company_id;
    BOOLEAN Diff_orig_reference_code;
    BOOLEAN Diff_orig_fname;
    BOOLEAN Diff_orig_mname;
    BOOLEAN Diff_orig_lname;
    BOOLEAN Diff_orig_name_suffix;
    BOOLEAN Diff_orig_fname_2;
    BOOLEAN Diff_orig_mname_2;
    BOOLEAN Diff_orig_lname_2;
    BOOLEAN Diff_orig_name_suffix_2;
    BOOLEAN Diff_orig_address;
    BOOLEAN Diff_orig_city;
    BOOLEAN Diff_orig_state;
    BOOLEAN Diff_orig_zip;
    BOOLEAN Diff_orig_zip4;
    BOOLEAN Diff_orig_address_2;
    BOOLEAN Diff_orig_city_2;
    BOOLEAN Diff_orig_state_2;
    BOOLEAN Diff_orig_zip_2;
    BOOLEAN Diff_orig_zip4_2;
    BOOLEAN Diff_orig_clean_address;
    BOOLEAN Diff_orig_clean_city;
    BOOLEAN Diff_orig_clean_state;
    BOOLEAN Diff_orig_clean_zip;
    BOOLEAN Diff_orig_clean_zip4;
    BOOLEAN Diff_orig_phone;
    BOOLEAN Diff_orig_homephone;
    BOOLEAN Diff_orig_homephone_2;
    BOOLEAN Diff_orig_workphone;
    BOOLEAN Diff_orig_workphone_2;
    BOOLEAN Diff_orig_ssn;
    BOOLEAN Diff_orig_ssn_2;
    BOOLEAN Diff_orig_free;
    BOOLEAN Diff_orig_record_count;
    BOOLEAN Diff_orig_price;
    BOOLEAN Diff_orig_revenue;
    BOOLEAN Diff_orig_full_name;
    BOOLEAN Diff_orig_business_name;
    BOOLEAN Diff_orig_business_name_2;
    BOOLEAN Diff_orig_years;
    BOOLEAN Diff_orig_pricing_error_code;
    BOOLEAN Diff_orig_fcra_purpose;
    BOOLEAN Diff_orig_result_format;
    BOOLEAN Diff_orig_dob;
    BOOLEAN Diff_orig_dob_2;
    BOOLEAN Diff_orig_unique_id;
    BOOLEAN Diff_orig_response_time;
    BOOLEAN Diff_orig_data_source;
    BOOLEAN Diff_orig_report_options;
    BOOLEAN Diff_orig_end_user_name;
    BOOLEAN Diff_orig_end_user_address_1;
    BOOLEAN Diff_orig_end_user_address_2;
    BOOLEAN Diff_orig_end_user_city;
    BOOLEAN Diff_orig_end_user_state;
    BOOLEAN Diff_orig_end_user_zip;
    BOOLEAN Diff_orig_login_history_id;
    BOOLEAN Diff_orig_employment_state;
    BOOLEAN Diff_orig_end_user_industry_class;
    BOOLEAN Diff_orig_function_specific_data;
    BOOLEAN Diff_orig_date_added;
    BOOLEAN Diff_orig_retail_price;
    BOOLEAN Diff_orig_country_code;
    BOOLEAN Diff_orig_email;
    BOOLEAN Diff_orig_email_2;
    BOOLEAN Diff_orig_dl_number;
    BOOLEAN Diff_orig_dl_number_2;
    BOOLEAN Diff_orig_sub_id;
    BOOLEAN Diff_orig_neighbors;
    BOOLEAN Diff_orig_relatives;
    BOOLEAN Diff_orig_associates;
    BOOLEAN Diff_orig_property;
    BOOLEAN Diff_orig_bankruptcy;
    BOOLEAN Diff_orig_dls;
    BOOLEAN Diff_orig_mvs;
    BOOLEAN Diff_orig_ip_address;
    UNSIGNED Num_Diffs;
    SALT39.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_orig_login_id := le.orig_login_id <> ri.orig_login_id;
    SELF.Diff_orig_billing_code := le.orig_billing_code <> ri.orig_billing_code;
    SELF.Diff_orig_transaction_id := le.orig_transaction_id <> ri.orig_transaction_id;
    SELF.Diff_orig_function_name := le.orig_function_name <> ri.orig_function_name;
    SELF.Diff_orig_company_id := le.orig_company_id <> ri.orig_company_id;
    SELF.Diff_orig_reference_code := le.orig_reference_code <> ri.orig_reference_code;
    SELF.Diff_orig_fname := le.orig_fname <> ri.orig_fname;
    SELF.Diff_orig_mname := le.orig_mname <> ri.orig_mname;
    SELF.Diff_orig_lname := le.orig_lname <> ri.orig_lname;
    SELF.Diff_orig_name_suffix := le.orig_name_suffix <> ri.orig_name_suffix;
    SELF.Diff_orig_fname_2 := le.orig_fname_2 <> ri.orig_fname_2;
    SELF.Diff_orig_mname_2 := le.orig_mname_2 <> ri.orig_mname_2;
    SELF.Diff_orig_lname_2 := le.orig_lname_2 <> ri.orig_lname_2;
    SELF.Diff_orig_name_suffix_2 := le.orig_name_suffix_2 <> ri.orig_name_suffix_2;
    SELF.Diff_orig_address := le.orig_address <> ri.orig_address;
    SELF.Diff_orig_city := le.orig_city <> ri.orig_city;
    SELF.Diff_orig_state := le.orig_state <> ri.orig_state;
    SELF.Diff_orig_zip := le.orig_zip <> ri.orig_zip;
    SELF.Diff_orig_zip4 := le.orig_zip4 <> ri.orig_zip4;
    SELF.Diff_orig_address_2 := le.orig_address_2 <> ri.orig_address_2;
    SELF.Diff_orig_city_2 := le.orig_city_2 <> ri.orig_city_2;
    SELF.Diff_orig_state_2 := le.orig_state_2 <> ri.orig_state_2;
    SELF.Diff_orig_zip_2 := le.orig_zip_2 <> ri.orig_zip_2;
    SELF.Diff_orig_zip4_2 := le.orig_zip4_2 <> ri.orig_zip4_2;
    SELF.Diff_orig_clean_address := le.orig_clean_address <> ri.orig_clean_address;
    SELF.Diff_orig_clean_city := le.orig_clean_city <> ri.orig_clean_city;
    SELF.Diff_orig_clean_state := le.orig_clean_state <> ri.orig_clean_state;
    SELF.Diff_orig_clean_zip := le.orig_clean_zip <> ri.orig_clean_zip;
    SELF.Diff_orig_clean_zip4 := le.orig_clean_zip4 <> ri.orig_clean_zip4;
    SELF.Diff_orig_phone := le.orig_phone <> ri.orig_phone;
    SELF.Diff_orig_homephone := le.orig_homephone <> ri.orig_homephone;
    SELF.Diff_orig_homephone_2 := le.orig_homephone_2 <> ri.orig_homephone_2;
    SELF.Diff_orig_workphone := le.orig_workphone <> ri.orig_workphone;
    SELF.Diff_orig_workphone_2 := le.orig_workphone_2 <> ri.orig_workphone_2;
    SELF.Diff_orig_ssn := le.orig_ssn <> ri.orig_ssn;
    SELF.Diff_orig_ssn_2 := le.orig_ssn_2 <> ri.orig_ssn_2;
    SELF.Diff_orig_free := le.orig_free <> ri.orig_free;
    SELF.Diff_orig_record_count := le.orig_record_count <> ri.orig_record_count;
    SELF.Diff_orig_price := le.orig_price <> ri.orig_price;
    SELF.Diff_orig_revenue := le.orig_revenue <> ri.orig_revenue;
    SELF.Diff_orig_full_name := le.orig_full_name <> ri.orig_full_name;
    SELF.Diff_orig_business_name := le.orig_business_name <> ri.orig_business_name;
    SELF.Diff_orig_business_name_2 := le.orig_business_name_2 <> ri.orig_business_name_2;
    SELF.Diff_orig_years := le.orig_years <> ri.orig_years;
    SELF.Diff_orig_pricing_error_code := le.orig_pricing_error_code <> ri.orig_pricing_error_code;
    SELF.Diff_orig_fcra_purpose := le.orig_fcra_purpose <> ri.orig_fcra_purpose;
    SELF.Diff_orig_result_format := le.orig_result_format <> ri.orig_result_format;
    SELF.Diff_orig_dob := le.orig_dob <> ri.orig_dob;
    SELF.Diff_orig_dob_2 := le.orig_dob_2 <> ri.orig_dob_2;
    SELF.Diff_orig_unique_id := le.orig_unique_id <> ri.orig_unique_id;
    SELF.Diff_orig_response_time := le.orig_response_time <> ri.orig_response_time;
    SELF.Diff_orig_data_source := le.orig_data_source <> ri.orig_data_source;
    SELF.Diff_orig_report_options := le.orig_report_options <> ri.orig_report_options;
    SELF.Diff_orig_end_user_name := le.orig_end_user_name <> ri.orig_end_user_name;
    SELF.Diff_orig_end_user_address_1 := le.orig_end_user_address_1 <> ri.orig_end_user_address_1;
    SELF.Diff_orig_end_user_address_2 := le.orig_end_user_address_2 <> ri.orig_end_user_address_2;
    SELF.Diff_orig_end_user_city := le.orig_end_user_city <> ri.orig_end_user_city;
    SELF.Diff_orig_end_user_state := le.orig_end_user_state <> ri.orig_end_user_state;
    SELF.Diff_orig_end_user_zip := le.orig_end_user_zip <> ri.orig_end_user_zip;
    SELF.Diff_orig_login_history_id := le.orig_login_history_id <> ri.orig_login_history_id;
    SELF.Diff_orig_employment_state := le.orig_employment_state <> ri.orig_employment_state;
    SELF.Diff_orig_end_user_industry_class := le.orig_end_user_industry_class <> ri.orig_end_user_industry_class;
    SELF.Diff_orig_function_specific_data := le.orig_function_specific_data <> ri.orig_function_specific_data;
    SELF.Diff_orig_date_added := le.orig_date_added <> ri.orig_date_added;
    SELF.Diff_orig_retail_price := le.orig_retail_price <> ri.orig_retail_price;
    SELF.Diff_orig_country_code := le.orig_country_code <> ri.orig_country_code;
    SELF.Diff_orig_email := le.orig_email <> ri.orig_email;
    SELF.Diff_orig_email_2 := le.orig_email_2 <> ri.orig_email_2;
    SELF.Diff_orig_dl_number := le.orig_dl_number <> ri.orig_dl_number;
    SELF.Diff_orig_dl_number_2 := le.orig_dl_number_2 <> ri.orig_dl_number_2;
    SELF.Diff_orig_sub_id := le.orig_sub_id <> ri.orig_sub_id;
    SELF.Diff_orig_neighbors := le.orig_neighbors <> ri.orig_neighbors;
    SELF.Diff_orig_relatives := le.orig_relatives <> ri.orig_relatives;
    SELF.Diff_orig_associates := le.orig_associates <> ri.orig_associates;
    SELF.Diff_orig_property := le.orig_property <> ri.orig_property;
    SELF.Diff_orig_bankruptcy := le.orig_bankruptcy <> ri.orig_bankruptcy;
    SELF.Diff_orig_dls := le.orig_dls <> ri.orig_dls;
    SELF.Diff_orig_mvs := le.orig_mvs <> ri.orig_mvs;
    SELF.Diff_orig_ip_address := le.orig_ip_address <> ri.orig_ip_address;
    SELF.Val := (SALT39.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_orig_login_id,1,0)+ IF( SELF.Diff_orig_billing_code,1,0)+ IF( SELF.Diff_orig_transaction_id,1,0)+ IF( SELF.Diff_orig_function_name,1,0)+ IF( SELF.Diff_orig_company_id,1,0)+ IF( SELF.Diff_orig_reference_code,1,0)+ IF( SELF.Diff_orig_fname,1,0)+ IF( SELF.Diff_orig_mname,1,0)+ IF( SELF.Diff_orig_lname,1,0)+ IF( SELF.Diff_orig_name_suffix,1,0)+ IF( SELF.Diff_orig_fname_2,1,0)+ IF( SELF.Diff_orig_mname_2,1,0)+ IF( SELF.Diff_orig_lname_2,1,0)+ IF( SELF.Diff_orig_name_suffix_2,1,0)+ IF( SELF.Diff_orig_address,1,0)+ IF( SELF.Diff_orig_city,1,0)+ IF( SELF.Diff_orig_state,1,0)+ IF( SELF.Diff_orig_zip,1,0)+ IF( SELF.Diff_orig_zip4,1,0)+ IF( SELF.Diff_orig_address_2,1,0)+ IF( SELF.Diff_orig_city_2,1,0)+ IF( SELF.Diff_orig_state_2,1,0)+ IF( SELF.Diff_orig_zip_2,1,0)+ IF( SELF.Diff_orig_zip4_2,1,0)+ IF( SELF.Diff_orig_clean_address,1,0)+ IF( SELF.Diff_orig_clean_city,1,0)+ IF( SELF.Diff_orig_clean_state,1,0)+ IF( SELF.Diff_orig_clean_zip,1,0)+ IF( SELF.Diff_orig_clean_zip4,1,0)+ IF( SELF.Diff_orig_phone,1,0)+ IF( SELF.Diff_orig_homephone,1,0)+ IF( SELF.Diff_orig_homephone_2,1,0)+ IF( SELF.Diff_orig_workphone,1,0)+ IF( SELF.Diff_orig_workphone_2,1,0)+ IF( SELF.Diff_orig_ssn,1,0)+ IF( SELF.Diff_orig_ssn_2,1,0)+ IF( SELF.Diff_orig_free,1,0)+ IF( SELF.Diff_orig_record_count,1,0)+ IF( SELF.Diff_orig_price,1,0)+ IF( SELF.Diff_orig_revenue,1,0)+ IF( SELF.Diff_orig_full_name,1,0)+ IF( SELF.Diff_orig_business_name,1,0)+ IF( SELF.Diff_orig_business_name_2,1,0)+ IF( SELF.Diff_orig_years,1,0)+ IF( SELF.Diff_orig_pricing_error_code,1,0)+ IF( SELF.Diff_orig_fcra_purpose,1,0)+ IF( SELF.Diff_orig_result_format,1,0)+ IF( SELF.Diff_orig_dob,1,0)+ IF( SELF.Diff_orig_dob_2,1,0)+ IF( SELF.Diff_orig_unique_id,1,0)+ IF( SELF.Diff_orig_response_time,1,0)+ IF( SELF.Diff_orig_data_source,1,0)+ IF( SELF.Diff_orig_report_options,1,0)+ IF( SELF.Diff_orig_end_user_name,1,0)+ IF( SELF.Diff_orig_end_user_address_1,1,0)+ IF( SELF.Diff_orig_end_user_address_2,1,0)+ IF( SELF.Diff_orig_end_user_city,1,0)+ IF( SELF.Diff_orig_end_user_state,1,0)+ IF( SELF.Diff_orig_end_user_zip,1,0)+ IF( SELF.Diff_orig_login_history_id,1,0)+ IF( SELF.Diff_orig_employment_state,1,0)+ IF( SELF.Diff_orig_end_user_industry_class,1,0)+ IF( SELF.Diff_orig_function_specific_data,1,0)+ IF( SELF.Diff_orig_date_added,1,0)+ IF( SELF.Diff_orig_retail_price,1,0)+ IF( SELF.Diff_orig_country_code,1,0)+ IF( SELF.Diff_orig_email,1,0)+ IF( SELF.Diff_orig_email_2,1,0)+ IF( SELF.Diff_orig_dl_number,1,0)+ IF( SELF.Diff_orig_dl_number_2,1,0)+ IF( SELF.Diff_orig_sub_id,1,0)+ IF( SELF.Diff_orig_neighbors,1,0)+ IF( SELF.Diff_orig_relatives,1,0)+ IF( SELF.Diff_orig_associates,1,0)+ IF( SELF.Diff_orig_property,1,0)+ IF( SELF.Diff_orig_bankruptcy,1,0)+ IF( SELF.Diff_orig_dls,1,0)+ IF( SELF.Diff_orig_mvs,1,0)+ IF( SELF.Diff_orig_ip_address,1,0);
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
    Count_Diff_orig_login_id := COUNT(GROUP,%Closest%.Diff_orig_login_id);
    Count_Diff_orig_billing_code := COUNT(GROUP,%Closest%.Diff_orig_billing_code);
    Count_Diff_orig_transaction_id := COUNT(GROUP,%Closest%.Diff_orig_transaction_id);
    Count_Diff_orig_function_name := COUNT(GROUP,%Closest%.Diff_orig_function_name);
    Count_Diff_orig_company_id := COUNT(GROUP,%Closest%.Diff_orig_company_id);
    Count_Diff_orig_reference_code := COUNT(GROUP,%Closest%.Diff_orig_reference_code);
    Count_Diff_orig_fname := COUNT(GROUP,%Closest%.Diff_orig_fname);
    Count_Diff_orig_mname := COUNT(GROUP,%Closest%.Diff_orig_mname);
    Count_Diff_orig_lname := COUNT(GROUP,%Closest%.Diff_orig_lname);
    Count_Diff_orig_name_suffix := COUNT(GROUP,%Closest%.Diff_orig_name_suffix);
    Count_Diff_orig_fname_2 := COUNT(GROUP,%Closest%.Diff_orig_fname_2);
    Count_Diff_orig_mname_2 := COUNT(GROUP,%Closest%.Diff_orig_mname_2);
    Count_Diff_orig_lname_2 := COUNT(GROUP,%Closest%.Diff_orig_lname_2);
    Count_Diff_orig_name_suffix_2 := COUNT(GROUP,%Closest%.Diff_orig_name_suffix_2);
    Count_Diff_orig_address := COUNT(GROUP,%Closest%.Diff_orig_address);
    Count_Diff_orig_city := COUNT(GROUP,%Closest%.Diff_orig_city);
    Count_Diff_orig_state := COUNT(GROUP,%Closest%.Diff_orig_state);
    Count_Diff_orig_zip := COUNT(GROUP,%Closest%.Diff_orig_zip);
    Count_Diff_orig_zip4 := COUNT(GROUP,%Closest%.Diff_orig_zip4);
    Count_Diff_orig_address_2 := COUNT(GROUP,%Closest%.Diff_orig_address_2);
    Count_Diff_orig_city_2 := COUNT(GROUP,%Closest%.Diff_orig_city_2);
    Count_Diff_orig_state_2 := COUNT(GROUP,%Closest%.Diff_orig_state_2);
    Count_Diff_orig_zip_2 := COUNT(GROUP,%Closest%.Diff_orig_zip_2);
    Count_Diff_orig_zip4_2 := COUNT(GROUP,%Closest%.Diff_orig_zip4_2);
    Count_Diff_orig_clean_address := COUNT(GROUP,%Closest%.Diff_orig_clean_address);
    Count_Diff_orig_clean_city := COUNT(GROUP,%Closest%.Diff_orig_clean_city);
    Count_Diff_orig_clean_state := COUNT(GROUP,%Closest%.Diff_orig_clean_state);
    Count_Diff_orig_clean_zip := COUNT(GROUP,%Closest%.Diff_orig_clean_zip);
    Count_Diff_orig_clean_zip4 := COUNT(GROUP,%Closest%.Diff_orig_clean_zip4);
    Count_Diff_orig_phone := COUNT(GROUP,%Closest%.Diff_orig_phone);
    Count_Diff_orig_homephone := COUNT(GROUP,%Closest%.Diff_orig_homephone);
    Count_Diff_orig_homephone_2 := COUNT(GROUP,%Closest%.Diff_orig_homephone_2);
    Count_Diff_orig_workphone := COUNT(GROUP,%Closest%.Diff_orig_workphone);
    Count_Diff_orig_workphone_2 := COUNT(GROUP,%Closest%.Diff_orig_workphone_2);
    Count_Diff_orig_ssn := COUNT(GROUP,%Closest%.Diff_orig_ssn);
    Count_Diff_orig_ssn_2 := COUNT(GROUP,%Closest%.Diff_orig_ssn_2);
    Count_Diff_orig_free := COUNT(GROUP,%Closest%.Diff_orig_free);
    Count_Diff_orig_record_count := COUNT(GROUP,%Closest%.Diff_orig_record_count);
    Count_Diff_orig_price := COUNT(GROUP,%Closest%.Diff_orig_price);
    Count_Diff_orig_revenue := COUNT(GROUP,%Closest%.Diff_orig_revenue);
    Count_Diff_orig_full_name := COUNT(GROUP,%Closest%.Diff_orig_full_name);
    Count_Diff_orig_business_name := COUNT(GROUP,%Closest%.Diff_orig_business_name);
    Count_Diff_orig_business_name_2 := COUNT(GROUP,%Closest%.Diff_orig_business_name_2);
    Count_Diff_orig_years := COUNT(GROUP,%Closest%.Diff_orig_years);
    Count_Diff_orig_pricing_error_code := COUNT(GROUP,%Closest%.Diff_orig_pricing_error_code);
    Count_Diff_orig_fcra_purpose := COUNT(GROUP,%Closest%.Diff_orig_fcra_purpose);
    Count_Diff_orig_result_format := COUNT(GROUP,%Closest%.Diff_orig_result_format);
    Count_Diff_orig_dob := COUNT(GROUP,%Closest%.Diff_orig_dob);
    Count_Diff_orig_dob_2 := COUNT(GROUP,%Closest%.Diff_orig_dob_2);
    Count_Diff_orig_unique_id := COUNT(GROUP,%Closest%.Diff_orig_unique_id);
    Count_Diff_orig_response_time := COUNT(GROUP,%Closest%.Diff_orig_response_time);
    Count_Diff_orig_data_source := COUNT(GROUP,%Closest%.Diff_orig_data_source);
    Count_Diff_orig_report_options := COUNT(GROUP,%Closest%.Diff_orig_report_options);
    Count_Diff_orig_end_user_name := COUNT(GROUP,%Closest%.Diff_orig_end_user_name);
    Count_Diff_orig_end_user_address_1 := COUNT(GROUP,%Closest%.Diff_orig_end_user_address_1);
    Count_Diff_orig_end_user_address_2 := COUNT(GROUP,%Closest%.Diff_orig_end_user_address_2);
    Count_Diff_orig_end_user_city := COUNT(GROUP,%Closest%.Diff_orig_end_user_city);
    Count_Diff_orig_end_user_state := COUNT(GROUP,%Closest%.Diff_orig_end_user_state);
    Count_Diff_orig_end_user_zip := COUNT(GROUP,%Closest%.Diff_orig_end_user_zip);
    Count_Diff_orig_login_history_id := COUNT(GROUP,%Closest%.Diff_orig_login_history_id);
    Count_Diff_orig_employment_state := COUNT(GROUP,%Closest%.Diff_orig_employment_state);
    Count_Diff_orig_end_user_industry_class := COUNT(GROUP,%Closest%.Diff_orig_end_user_industry_class);
    Count_Diff_orig_function_specific_data := COUNT(GROUP,%Closest%.Diff_orig_function_specific_data);
    Count_Diff_orig_date_added := COUNT(GROUP,%Closest%.Diff_orig_date_added);
    Count_Diff_orig_retail_price := COUNT(GROUP,%Closest%.Diff_orig_retail_price);
    Count_Diff_orig_country_code := COUNT(GROUP,%Closest%.Diff_orig_country_code);
    Count_Diff_orig_email := COUNT(GROUP,%Closest%.Diff_orig_email);
    Count_Diff_orig_email_2 := COUNT(GROUP,%Closest%.Diff_orig_email_2);
    Count_Diff_orig_dl_number := COUNT(GROUP,%Closest%.Diff_orig_dl_number);
    Count_Diff_orig_dl_number_2 := COUNT(GROUP,%Closest%.Diff_orig_dl_number_2);
    Count_Diff_orig_sub_id := COUNT(GROUP,%Closest%.Diff_orig_sub_id);
    Count_Diff_orig_neighbors := COUNT(GROUP,%Closest%.Diff_orig_neighbors);
    Count_Diff_orig_relatives := COUNT(GROUP,%Closest%.Diff_orig_relatives);
    Count_Diff_orig_associates := COUNT(GROUP,%Closest%.Diff_orig_associates);
    Count_Diff_orig_property := COUNT(GROUP,%Closest%.Diff_orig_property);
    Count_Diff_orig_bankruptcy := COUNT(GROUP,%Closest%.Diff_orig_bankruptcy);
    Count_Diff_orig_dls := COUNT(GROUP,%Closest%.Diff_orig_dls);
    Count_Diff_orig_mvs := COUNT(GROUP,%Closest%.Diff_orig_mvs);
    Count_Diff_orig_ip_address := COUNT(GROUP,%Closest%.Diff_orig_ip_address);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
