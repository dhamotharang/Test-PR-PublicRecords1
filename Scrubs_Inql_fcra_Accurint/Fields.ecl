IMPORT SALT39;
EXPORT Fields := MODULE
 
EXPORT NumFields := 68;
 
// Processing for each FieldType
EXPORT SALT39.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'DEFAULT','ALPHA','NAME','NUMBER','ALPHANUM','WORDBAG','orig_end_user_id','orig_loginid','orig_billing_code','orig_transaction_id','orig_transaction_type','orig_neighbors','orig_relatives','orig_associates','orig_property','orig_company_id','orig_reference_code','orig_fname','orig_mname','orig_lname','orig_address','orig_city','orig_state','orig_zip','orig_zip4','orig_phone','orig_ssn','orig_free','orig_record_count','orig_price','orig_bankruptcy','orig_transaction_code','orig_dateadded','orig_full_name','orig_billingdate','orig_business_name','orig_pricing_error_code','orig_dl_purpose','orig_result_format','orig_dob','orig_unique_id','orig_dls','orig_mvs','orig_function_name','orig_response_time','orig_data_source','orig_glb_purpose','orig_report_options','orig_unused','orig_login_history_id','orig_aseid','orig_years','orig_ip_address','orig_source_code','orig_retail_price','inquiry_type','lex_id','reprice_batch_number','user_changed','date_changed','fcra_purpose','orig_address_2','orig_city_2','orig_state_2','orig_zip_2','orig_zip4_2','orig_jobid','orig_acctno','orig_end_user_name','orig_end_user_address_1','orig_end_user_address_2','orig_end_user_city','orig_end_user_state','orig_end_user_zip');
EXPORT FieldTypeNum(SALT39.StrType fn) := CASE(fn,'DEFAULT' => 1,'ALPHA' => 2,'NAME' => 3,'NUMBER' => 4,'ALPHANUM' => 5,'WORDBAG' => 6,'orig_end_user_id' => 7,'orig_loginid' => 8,'orig_billing_code' => 9,'orig_transaction_id' => 10,'orig_transaction_type' => 11,'orig_neighbors' => 12,'orig_relatives' => 13,'orig_associates' => 14,'orig_property' => 15,'orig_company_id' => 16,'orig_reference_code' => 17,'orig_fname' => 18,'orig_mname' => 19,'orig_lname' => 20,'orig_address' => 21,'orig_city' => 22,'orig_state' => 23,'orig_zip' => 24,'orig_zip4' => 25,'orig_phone' => 26,'orig_ssn' => 27,'orig_free' => 28,'orig_record_count' => 29,'orig_price' => 30,'orig_bankruptcy' => 31,'orig_transaction_code' => 32,'orig_dateadded' => 33,'orig_full_name' => 34,'orig_billingdate' => 35,'orig_business_name' => 36,'orig_pricing_error_code' => 37,'orig_dl_purpose' => 38,'orig_result_format' => 39,'orig_dob' => 40,'orig_unique_id' => 41,'orig_dls' => 42,'orig_mvs' => 43,'orig_function_name' => 44,'orig_response_time' => 45,'orig_data_source' => 46,'orig_glb_purpose' => 47,'orig_report_options' => 48,'orig_unused' => 49,'orig_login_history_id' => 50,'orig_aseid' => 51,'orig_years' => 52,'orig_ip_address' => 53,'orig_source_code' => 54,'orig_retail_price' => 55,'inquiry_type' => 56,'lex_id' => 57,'reprice_batch_number' => 58,'user_changed' => 59,'date_changed' => 60,'fcra_purpose' => 61,'orig_address_2' => 62,'orig_city_2' => 63,'orig_state_2' => 64,'orig_zip_2' => 65,'orig_zip4_2' => 66,'orig_jobid' => 67,'orig_acctno' => 68,'orig_end_user_name' => 69,'orig_end_user_address_1' => 70,'orig_end_user_address_2' => 71,'orig_end_user_city' => 72,'orig_end_user_state' => 73,'orig_end_user_zip' => 74,0);
 
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
  s1 := SALT39.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_ALPHANUM(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789'))));
EXPORT InValidMessageFT_ALPHANUM(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_WORDBAG(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$; '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_WORDBAG(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$; '))));
EXPORT InValidMessageFT_WORDBAG(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$; '),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_end_user_id(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,' '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_end_user_id(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,' '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_end_user_id(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars(' '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_loginid(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$; '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_WORDBAG(s2);
END;
EXPORT InValidFT_orig_loginid(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$; '))),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_loginid(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$; '),SALT39.HygieneErrors.NotWords('1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_billing_code(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$; '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  MakeFT_WORDBAG(s3);
END;
EXPORT InValidFT_orig_billing_code(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$; '))),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 2));
EXPORT InValidMessageFT_orig_billing_code(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$; '),SALT39.HygieneErrors.NotWords('1,2'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_transaction_id(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789ABR '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_transaction_id(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789ABR '))),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_transaction_id(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('0123456789ABR '),SALT39.HygieneErrors.NotWords('1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_transaction_type(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'I '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_transaction_type(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'I '))),~(LENGTH(TRIM(s)) = 1),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_transaction_type(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('I '),SALT39.HygieneErrors.NotLength('1'),SALT39.HygieneErrors.NotWords('1'),SALT39.HygieneErrors.Good);
 
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
  s1 := SALT39.stringfilter(s0,'01 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_property(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'01 '))),~(LENGTH(TRIM(s)) = 1),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_property(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('01 '),SALT39.HygieneErrors.NotLength('1'),SALT39.HygieneErrors.NotWords('1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_company_id(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_NUMBER(s2);
END;
EXPORT InValidFT_orig_company_id(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789 '))),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_company_id(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('0123456789 '),SALT39.HygieneErrors.NotWords('1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_reference_code(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$; '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_WORDBAG(s2);
END;
EXPORT InValidFT_orig_reference_code(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$; '))));
EXPORT InValidMessageFT_orig_reference_code(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$; '),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_fname(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz-,\'. '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_NAME(s2);
END;
EXPORT InValidFT_orig_fname(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz-,\'. '))),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 2));
EXPORT InValidMessageFT_orig_fname(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz-,\'. '),SALT39.HygieneErrors.NotWords('1,0,2'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_mname(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz-,\'. '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_NAME(s2);
END;
EXPORT InValidFT_orig_mname(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz-,\'. '))),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_mname(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz-,\'. '),SALT39.HygieneErrors.NotWords('0,1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_lname(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz-,\'. '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_NAME(s2);
END;
EXPORT InValidFT_orig_lname(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz-,\'. '))),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 2 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 3));
EXPORT InValidMessageFT_orig_lname(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz-,\'. '),SALT39.HygieneErrors.NotWords('1,0,2,3'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_address(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$; '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_WORDBAG(s2);
END;
EXPORT InValidFT_orig_address(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$; '))));
EXPORT InValidMessageFT_orig_address(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$; '),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_city(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_ALPHA(s2);
END;
EXPORT InValidFT_orig_city(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '))),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 2 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 3));
EXPORT InValidMessageFT_orig_city(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '),SALT39.HygieneErrors.NotWords('0,1,2,3'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_state(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  MakeFT_ALPHA(s3);
END;
EXPORT InValidFT_orig_state(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 2),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_state(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '),SALT39.HygieneErrors.NotLength('0,2'),SALT39.HygieneErrors.NotWords('0,1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_zip(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  MakeFT_NUMBER(s3);
END;
EXPORT InValidFT_orig_zip(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 5),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_zip(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('0123456789 '),SALT39.HygieneErrors.NotLength('0,5'),SALT39.HygieneErrors.NotWords('0,1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_zip4(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  MakeFT_NUMBER(s3);
END;
EXPORT InValidFT_orig_zip4(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 4),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_zip4(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('0123456789 '),SALT39.HygieneErrors.NotLength('0,4'),SALT39.HygieneErrors.NotWords('0,1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_phone(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  MakeFT_NUMBER(s3);
END;
EXPORT InValidFT_orig_phone(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_phone(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('0123456789 '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_ssn(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  MakeFT_NUMBER(s3);
END;
EXPORT InValidFT_orig_ssn(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 9 OR LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_ssn(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('0123456789 '),SALT39.HygieneErrors.NotLength('9,0'),SALT39.HygieneErrors.NotWords('1,0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_free(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'04 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_free(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'04 '))),~(LENGTH(TRIM(s)) = 1),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_free(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('04 '),SALT39.HygieneErrors.NotLength('1'),SALT39.HygieneErrors.NotWords('1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_record_count(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  MakeFT_NUMBER(s3);
END;
EXPORT InValidFT_orig_record_count(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 2),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_record_count(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('0123456789 '),SALT39.HygieneErrors.NotLength('1,2'),SALT39.HygieneErrors.NotWords('1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_price(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s0,' ',' ') ); // Insert spaces but avoid doubles
  s2 := TRIM(s1,LEFT); // Left trim
  RETURN  s2;
END;
EXPORT InValidFT_orig_price(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,~(LENGTH(TRIM(s)) = 9 OR LENGTH(TRIM(s)) = 8),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_price(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotLength('9,8'),SALT39.HygieneErrors.NotWords('1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_bankruptcy(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'01 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_bankruptcy(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'01 '))),~(LENGTH(TRIM(s)) = 1),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_bankruptcy(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('01 '),SALT39.HygieneErrors.NotLength('1'),SALT39.HygieneErrors.NotWords('1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_transaction_code(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  MakeFT_NUMBER(s3);
END;
EXPORT InValidFT_orig_transaction_code(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 3),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_transaction_code(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('0123456789 '),SALT39.HygieneErrors.NotLength('0,3'),SALT39.HygieneErrors.NotWords('0,1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_dateadded(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,' 0123456789:AMOPct '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_dateadded(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,' 0123456789:AMOPct '))),~(LENGTH(TRIM(s)) = 26),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 4));
EXPORT InValidMessageFT_orig_dateadded(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars(' 0123456789:AMOPct '),SALT39.HygieneErrors.NotLength('26'),SALT39.HygieneErrors.NotWords('4'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_full_name(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,' '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_full_name(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,' '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_full_name(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars(' '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_billingdate(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,' 0123456789:AMOPct '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_billingdate(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,' 0123456789:AMOPct '))),~(LENGTH(TRIM(s)) = 26 OR LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 4 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_billingdate(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars(' 0123456789:AMOPct '),SALT39.HygieneErrors.NotLength('26,0'),SALT39.HygieneErrors.NotWords('4,0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_business_name(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,' '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_business_name(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,' '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_business_name(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars(' '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_pricing_error_code(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'-012 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_pricing_error_code(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'-012 '))),~(LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 2),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_pricing_error_code(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('-012 '),SALT39.HygieneErrors.NotLength('1,2'),SALT39.HygieneErrors.NotWords('1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_dl_purpose(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0134 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_dl_purpose(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0134 '))),~(LENGTH(TRIM(s)) = 1),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_dl_purpose(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('0134 '),SALT39.HygieneErrors.NotLength('1'),SALT39.HygieneErrors.NotWords('1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_result_format(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0cn '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_result_format(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0cn '))),~(LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 2),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_result_format(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('0cn '),SALT39.HygieneErrors.NotLength('1,2'),SALT39.HygieneErrors.NotWords('1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_dob(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  MakeFT_NUMBER(s3);
END;
EXPORT InValidFT_orig_dob(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 8),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_dob(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('0123456789 '),SALT39.HygieneErrors.NotLength('0,8'),SALT39.HygieneErrors.NotWords('0,1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_unique_id(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  MakeFT_ALPHANUM(s3);
END;
EXPORT InValidFT_orig_unique_id(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 '))),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_unique_id(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 '),SALT39.HygieneErrors.NotWords('1,0'),SALT39.HygieneErrors.Good);
 
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
 
EXPORT MakeFT_orig_function_name(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$; '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  MakeFT_WORDBAG(s3);
END;
EXPORT InValidFT_orig_function_name(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$; '))),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_function_name(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$; '),SALT39.HygieneErrors.NotWords('1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_response_time(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s0,' ',' ') ); // Insert spaces but avoid doubles
  s2 := TRIM(s1,LEFT); // Left trim
  RETURN  s2;
END;
EXPORT InValidFT_orig_response_time(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,~(LENGTH(TRIM(s)) = 4),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_response_time(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotLength('4'),SALT39.HygieneErrors.NotWords('1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_data_source(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,' '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_data_source(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,' '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_data_source(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars(' '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_glb_purpose(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  MakeFT_NUMBER(s3);
END;
EXPORT InValidFT_orig_glb_purpose(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 2),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_glb_purpose(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('0123456789 '),SALT39.HygieneErrors.NotLength('1,2'),SALT39.HygieneErrors.NotWords('1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_report_options(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$; '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  MakeFT_WORDBAG(s3);
END;
EXPORT InValidFT_orig_report_options(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$; '))),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 4));
EXPORT InValidMessageFT_orig_report_options(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$; '),SALT39.HygieneErrors.NotWords('1,4'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_unused(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,' '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_unused(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,' '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_unused(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars(' '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_login_history_id(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  MakeFT_NUMBER(s3);
END;
EXPORT InValidFT_orig_login_history_id(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 10 OR LENGTH(TRIM(s)) = 9),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_login_history_id(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('0123456789 '),SALT39.HygieneErrors.NotLength('1,10,9'),SALT39.HygieneErrors.NotWords('1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_aseid(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'38 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_aseid(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'38 '))),~(LENGTH(TRIM(s)) = 1),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_aseid(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('38 '),SALT39.HygieneErrors.NotLength('1'),SALT39.HygieneErrors.NotWords('1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_years(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,' '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_years(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,' '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_years(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars(' '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_ip_address(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s0,' ',' ') ); // Insert spaces but avoid doubles
  s2 := TRIM(s1,LEFT); // Left trim
  RETURN  s2;
END;
EXPORT InValidFT_orig_ip_address(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_ip_address(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotWords('1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_source_code(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'012 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_source_code(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'012 '))),~(LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 3),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_source_code(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('012 '),SALT39.HygieneErrors.NotLength('1,3'),SALT39.HygieneErrors.NotWords('1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_retail_price(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s0,' ',' ') ); // Insert spaces but avoid doubles
  s2 := TRIM(s1,LEFT); // Left trim
  RETURN  s2;
END;
EXPORT InValidFT_orig_retail_price(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_retail_price(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotWords('0,1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_inquiry_type(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,' '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_inquiry_type(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,' '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_inquiry_type(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars(' '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_lex_id(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,' '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_lex_id(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,' '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_lex_id(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars(' '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_reprice_batch_number(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,' '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_reprice_batch_number(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,' '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_reprice_batch_number(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars(' '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_user_changed(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,' '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_user_changed(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,' '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_user_changed(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars(' '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_date_changed(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,' '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_date_changed(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,' '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_date_changed(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars(' '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_fcra_purpose(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'01235 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_fcra_purpose(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'01235 '))),~(LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 2),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_fcra_purpose(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('01235 '),SALT39.HygieneErrors.NotLength('1,2'),SALT39.HygieneErrors.NotWords('1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_address_2(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$; '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  MakeFT_WORDBAG(s3);
END;
EXPORT InValidFT_orig_address_2(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$; '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_address_2(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$; '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_city_2(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,' '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_city_2(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,' '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_city_2(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars(' '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_state_2(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,' '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_state_2(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,' '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_state_2(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars(' '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_zip_2(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,' '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_zip_2(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,' '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_zip_2(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars(' '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_zip4_2(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,' '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_zip4_2(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,' '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_zip4_2(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars(' '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_jobid(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  MakeFT_NUMBER(s3);
END;
EXPORT InValidFT_orig_jobid(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 8 OR LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_jobid(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('0123456789 '),SALT39.HygieneErrors.NotLength('8,0'),SALT39.HygieneErrors.NotWords('1,0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_acctno(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_NUMBER(s2);
END;
EXPORT InValidFT_orig_acctno(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789 '))),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_acctno(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('0123456789 '),SALT39.HygieneErrors.NotWords('1,0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_end_user_name(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz-,\'. '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  MakeFT_NAME(s3);
END;
EXPORT InValidFT_orig_end_user_name(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz-,\'. '))),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_end_user_name(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz-,\'. '),SALT39.HygieneErrors.NotWords('0,1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_end_user_address_1(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$; '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_WORDBAG(s2);
END;
EXPORT InValidFT_orig_end_user_address_1(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$; '))));
EXPORT InValidMessageFT_orig_end_user_address_1(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$; '),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_end_user_address_2(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,' '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_end_user_address_2(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,' '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_end_user_address_2(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars(' '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_end_user_city(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  MakeFT_ALPHA(s3);
END;
EXPORT InValidFT_orig_end_user_city(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '))),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 2));
EXPORT InValidMessageFT_orig_end_user_city(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '),SALT39.HygieneErrors.NotWords('0,1,2'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_end_user_state(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  MakeFT_ALPHA(s3);
END;
EXPORT InValidFT_orig_end_user_state(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 2),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_end_user_state(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '),SALT39.HygieneErrors.NotLength('0,2'),SALT39.HygieneErrors.NotWords('0,1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_end_user_zip(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  MakeFT_NUMBER(s3);
END;
EXPORT InValidFT_orig_end_user_zip(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 5),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_end_user_zip(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('0123456789 '),SALT39.HygieneErrors.NotLength('0,5'),SALT39.HygieneErrors.NotWords('0,1'),SALT39.HygieneErrors.Good);
 
EXPORT SALT39.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'orig_end_user_id','orig_loginid','orig_billing_code','orig_transaction_id','orig_transaction_type','orig_neighbors','orig_relatives','orig_associates','orig_property','orig_company_id','orig_reference_code','orig_fname','orig_mname','orig_lname','orig_address','orig_city','orig_state','orig_zip','orig_zip4','orig_phone','orig_ssn','orig_free','orig_record_count','orig_price','orig_bankruptcy','orig_transaction_code','orig_dateadded','orig_full_name','orig_billingdate','orig_business_name','orig_pricing_error_code','orig_dl_purpose','orig_result_format','orig_dob','orig_unique_id','orig_dls','orig_mvs','orig_function_name','orig_response_time','orig_data_source','orig_glb_purpose','orig_report_options','orig_unused','orig_login_history_id','orig_aseid','orig_years','orig_ip_address','orig_source_code','orig_retail_price','inquiry_type','lex_id','reprice_batch_number','user_changed','date_changed','fcra_purpose','orig_address_2','orig_city_2','orig_state_2','orig_zip_2','orig_zip4_2','orig_jobid','orig_acctno','orig_end_user_name','orig_end_user_address_1','orig_end_user_address_2','orig_end_user_city','orig_end_user_state','orig_end_user_zip');
EXPORT SALT39.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'orig_end_user_id','orig_loginid','orig_billing_code','orig_transaction_id','orig_transaction_type','orig_neighbors','orig_relatives','orig_associates','orig_property','orig_company_id','orig_reference_code','orig_fname','orig_mname','orig_lname','orig_address','orig_city','orig_state','orig_zip','orig_zip4','orig_phone','orig_ssn','orig_free','orig_record_count','orig_price','orig_bankruptcy','orig_transaction_code','orig_dateadded','orig_full_name','orig_billingdate','orig_business_name','orig_pricing_error_code','orig_dl_purpose','orig_result_format','orig_dob','orig_unique_id','orig_dls','orig_mvs','orig_function_name','orig_response_time','orig_data_source','orig_glb_purpose','orig_report_options','orig_unused','orig_login_history_id','orig_aseid','orig_years','orig_ip_address','orig_source_code','orig_retail_price','inquiry_type','lex_id','reprice_batch_number','user_changed','date_changed','fcra_purpose','orig_address_2','orig_city_2','orig_state_2','orig_zip_2','orig_zip4_2','orig_jobid','orig_acctno','orig_end_user_name','orig_end_user_address_1','orig_end_user_address_2','orig_end_user_city','orig_end_user_state','orig_end_user_zip');
EXPORT FieldNum(SALT39.StrType fn) := CASE(fn,'orig_end_user_id' => 0,'orig_loginid' => 1,'orig_billing_code' => 2,'orig_transaction_id' => 3,'orig_transaction_type' => 4,'orig_neighbors' => 5,'orig_relatives' => 6,'orig_associates' => 7,'orig_property' => 8,'orig_company_id' => 9,'orig_reference_code' => 10,'orig_fname' => 11,'orig_mname' => 12,'orig_lname' => 13,'orig_address' => 14,'orig_city' => 15,'orig_state' => 16,'orig_zip' => 17,'orig_zip4' => 18,'orig_phone' => 19,'orig_ssn' => 20,'orig_free' => 21,'orig_record_count' => 22,'orig_price' => 23,'orig_bankruptcy' => 24,'orig_transaction_code' => 25,'orig_dateadded' => 26,'orig_full_name' => 27,'orig_billingdate' => 28,'orig_business_name' => 29,'orig_pricing_error_code' => 30,'orig_dl_purpose' => 31,'orig_result_format' => 32,'orig_dob' => 33,'orig_unique_id' => 34,'orig_dls' => 35,'orig_mvs' => 36,'orig_function_name' => 37,'orig_response_time' => 38,'orig_data_source' => 39,'orig_glb_purpose' => 40,'orig_report_options' => 41,'orig_unused' => 42,'orig_login_history_id' => 43,'orig_aseid' => 44,'orig_years' => 45,'orig_ip_address' => 46,'orig_source_code' => 47,'orig_retail_price' => 48,'inquiry_type' => 49,'lex_id' => 50,'reprice_batch_number' => 51,'user_changed' => 52,'date_changed' => 53,'fcra_purpose' => 54,'orig_address_2' => 55,'orig_city_2' => 56,'orig_state_2' => 57,'orig_zip_2' => 58,'orig_zip4_2' => 59,'orig_jobid' => 60,'orig_acctno' => 61,'orig_end_user_name' => 62,'orig_end_user_address_1' => 63,'orig_end_user_address_2' => 64,'orig_end_user_city' => 65,'orig_end_user_state' => 66,'orig_end_user_zip' => 67,0);
EXPORT SET OF SALT39.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['ALLOW','WORDS'],['LEFTTRIM','ALLOW','WORDS'],['LEFTTRIM','ALLOW','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['ALLOW','WORDS'],['ALLOW'],['ALLOW','WORDS'],['ALLOW','WORDS'],['ALLOW','WORDS'],['ALLOW'],['ALLOW','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','WORDS'],['LEFTTRIM','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['ALLOW','WORDS'],['LEFTTRIM','ALLOW','WORDS'],['ALLOW'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_orig_end_user_id(SALT39.StrType s0) := MakeFT_orig_end_user_id(s0);
EXPORT InValid_orig_end_user_id(SALT39.StrType s) := InValidFT_orig_end_user_id(s);
EXPORT InValidMessage_orig_end_user_id(UNSIGNED1 wh) := InValidMessageFT_orig_end_user_id(wh);
 
EXPORT Make_orig_loginid(SALT39.StrType s0) := MakeFT_orig_loginid(s0);
EXPORT InValid_orig_loginid(SALT39.StrType s) := InValidFT_orig_loginid(s);
EXPORT InValidMessage_orig_loginid(UNSIGNED1 wh) := InValidMessageFT_orig_loginid(wh);
 
EXPORT Make_orig_billing_code(SALT39.StrType s0) := MakeFT_orig_billing_code(s0);
EXPORT InValid_orig_billing_code(SALT39.StrType s) := InValidFT_orig_billing_code(s);
EXPORT InValidMessage_orig_billing_code(UNSIGNED1 wh) := InValidMessageFT_orig_billing_code(wh);
 
EXPORT Make_orig_transaction_id(SALT39.StrType s0) := MakeFT_orig_transaction_id(s0);
EXPORT InValid_orig_transaction_id(SALT39.StrType s) := InValidFT_orig_transaction_id(s);
EXPORT InValidMessage_orig_transaction_id(UNSIGNED1 wh) := InValidMessageFT_orig_transaction_id(wh);
 
EXPORT Make_orig_transaction_type(SALT39.StrType s0) := MakeFT_orig_transaction_type(s0);
EXPORT InValid_orig_transaction_type(SALT39.StrType s) := InValidFT_orig_transaction_type(s);
EXPORT InValidMessage_orig_transaction_type(UNSIGNED1 wh) := InValidMessageFT_orig_transaction_type(wh);
 
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
 
EXPORT Make_orig_phone(SALT39.StrType s0) := MakeFT_orig_phone(s0);
EXPORT InValid_orig_phone(SALT39.StrType s) := InValidFT_orig_phone(s);
EXPORT InValidMessage_orig_phone(UNSIGNED1 wh) := InValidMessageFT_orig_phone(wh);
 
EXPORT Make_orig_ssn(SALT39.StrType s0) := MakeFT_orig_ssn(s0);
EXPORT InValid_orig_ssn(SALT39.StrType s) := InValidFT_orig_ssn(s);
EXPORT InValidMessage_orig_ssn(UNSIGNED1 wh) := InValidMessageFT_orig_ssn(wh);
 
EXPORT Make_orig_free(SALT39.StrType s0) := MakeFT_orig_free(s0);
EXPORT InValid_orig_free(SALT39.StrType s) := InValidFT_orig_free(s);
EXPORT InValidMessage_orig_free(UNSIGNED1 wh) := InValidMessageFT_orig_free(wh);
 
EXPORT Make_orig_record_count(SALT39.StrType s0) := MakeFT_orig_record_count(s0);
EXPORT InValid_orig_record_count(SALT39.StrType s) := InValidFT_orig_record_count(s);
EXPORT InValidMessage_orig_record_count(UNSIGNED1 wh) := InValidMessageFT_orig_record_count(wh);
 
EXPORT Make_orig_price(SALT39.StrType s0) := MakeFT_orig_price(s0);
EXPORT InValid_orig_price(SALT39.StrType s) := InValidFT_orig_price(s);
EXPORT InValidMessage_orig_price(UNSIGNED1 wh) := InValidMessageFT_orig_price(wh);
 
EXPORT Make_orig_bankruptcy(SALT39.StrType s0) := MakeFT_orig_bankruptcy(s0);
EXPORT InValid_orig_bankruptcy(SALT39.StrType s) := InValidFT_orig_bankruptcy(s);
EXPORT InValidMessage_orig_bankruptcy(UNSIGNED1 wh) := InValidMessageFT_orig_bankruptcy(wh);
 
EXPORT Make_orig_transaction_code(SALT39.StrType s0) := MakeFT_orig_transaction_code(s0);
EXPORT InValid_orig_transaction_code(SALT39.StrType s) := InValidFT_orig_transaction_code(s);
EXPORT InValidMessage_orig_transaction_code(UNSIGNED1 wh) := InValidMessageFT_orig_transaction_code(wh);
 
EXPORT Make_orig_dateadded(SALT39.StrType s0) := MakeFT_orig_dateadded(s0);
EXPORT InValid_orig_dateadded(SALT39.StrType s) := InValidFT_orig_dateadded(s);
EXPORT InValidMessage_orig_dateadded(UNSIGNED1 wh) := InValidMessageFT_orig_dateadded(wh);
 
EXPORT Make_orig_full_name(SALT39.StrType s0) := MakeFT_orig_full_name(s0);
EXPORT InValid_orig_full_name(SALT39.StrType s) := InValidFT_orig_full_name(s);
EXPORT InValidMessage_orig_full_name(UNSIGNED1 wh) := InValidMessageFT_orig_full_name(wh);
 
EXPORT Make_orig_billingdate(SALT39.StrType s0) := MakeFT_orig_billingdate(s0);
EXPORT InValid_orig_billingdate(SALT39.StrType s) := InValidFT_orig_billingdate(s);
EXPORT InValidMessage_orig_billingdate(UNSIGNED1 wh) := InValidMessageFT_orig_billingdate(wh);
 
EXPORT Make_orig_business_name(SALT39.StrType s0) := MakeFT_orig_business_name(s0);
EXPORT InValid_orig_business_name(SALT39.StrType s) := InValidFT_orig_business_name(s);
EXPORT InValidMessage_orig_business_name(UNSIGNED1 wh) := InValidMessageFT_orig_business_name(wh);
 
EXPORT Make_orig_pricing_error_code(SALT39.StrType s0) := MakeFT_orig_pricing_error_code(s0);
EXPORT InValid_orig_pricing_error_code(SALT39.StrType s) := InValidFT_orig_pricing_error_code(s);
EXPORT InValidMessage_orig_pricing_error_code(UNSIGNED1 wh) := InValidMessageFT_orig_pricing_error_code(wh);
 
EXPORT Make_orig_dl_purpose(SALT39.StrType s0) := MakeFT_orig_dl_purpose(s0);
EXPORT InValid_orig_dl_purpose(SALT39.StrType s) := InValidFT_orig_dl_purpose(s);
EXPORT InValidMessage_orig_dl_purpose(UNSIGNED1 wh) := InValidMessageFT_orig_dl_purpose(wh);
 
EXPORT Make_orig_result_format(SALT39.StrType s0) := MakeFT_orig_result_format(s0);
EXPORT InValid_orig_result_format(SALT39.StrType s) := InValidFT_orig_result_format(s);
EXPORT InValidMessage_orig_result_format(UNSIGNED1 wh) := InValidMessageFT_orig_result_format(wh);
 
EXPORT Make_orig_dob(SALT39.StrType s0) := MakeFT_orig_dob(s0);
EXPORT InValid_orig_dob(SALT39.StrType s) := InValidFT_orig_dob(s);
EXPORT InValidMessage_orig_dob(UNSIGNED1 wh) := InValidMessageFT_orig_dob(wh);
 
EXPORT Make_orig_unique_id(SALT39.StrType s0) := MakeFT_orig_unique_id(s0);
EXPORT InValid_orig_unique_id(SALT39.StrType s) := InValidFT_orig_unique_id(s);
EXPORT InValidMessage_orig_unique_id(UNSIGNED1 wh) := InValidMessageFT_orig_unique_id(wh);
 
EXPORT Make_orig_dls(SALT39.StrType s0) := MakeFT_orig_dls(s0);
EXPORT InValid_orig_dls(SALT39.StrType s) := InValidFT_orig_dls(s);
EXPORT InValidMessage_orig_dls(UNSIGNED1 wh) := InValidMessageFT_orig_dls(wh);
 
EXPORT Make_orig_mvs(SALT39.StrType s0) := MakeFT_orig_mvs(s0);
EXPORT InValid_orig_mvs(SALT39.StrType s) := InValidFT_orig_mvs(s);
EXPORT InValidMessage_orig_mvs(UNSIGNED1 wh) := InValidMessageFT_orig_mvs(wh);
 
EXPORT Make_orig_function_name(SALT39.StrType s0) := MakeFT_orig_function_name(s0);
EXPORT InValid_orig_function_name(SALT39.StrType s) := InValidFT_orig_function_name(s);
EXPORT InValidMessage_orig_function_name(UNSIGNED1 wh) := InValidMessageFT_orig_function_name(wh);
 
EXPORT Make_orig_response_time(SALT39.StrType s0) := MakeFT_orig_response_time(s0);
EXPORT InValid_orig_response_time(SALT39.StrType s) := InValidFT_orig_response_time(s);
EXPORT InValidMessage_orig_response_time(UNSIGNED1 wh) := InValidMessageFT_orig_response_time(wh);
 
EXPORT Make_orig_data_source(SALT39.StrType s0) := MakeFT_orig_data_source(s0);
EXPORT InValid_orig_data_source(SALT39.StrType s) := InValidFT_orig_data_source(s);
EXPORT InValidMessage_orig_data_source(UNSIGNED1 wh) := InValidMessageFT_orig_data_source(wh);
 
EXPORT Make_orig_glb_purpose(SALT39.StrType s0) := MakeFT_orig_glb_purpose(s0);
EXPORT InValid_orig_glb_purpose(SALT39.StrType s) := InValidFT_orig_glb_purpose(s);
EXPORT InValidMessage_orig_glb_purpose(UNSIGNED1 wh) := InValidMessageFT_orig_glb_purpose(wh);
 
EXPORT Make_orig_report_options(SALT39.StrType s0) := MakeFT_orig_report_options(s0);
EXPORT InValid_orig_report_options(SALT39.StrType s) := InValidFT_orig_report_options(s);
EXPORT InValidMessage_orig_report_options(UNSIGNED1 wh) := InValidMessageFT_orig_report_options(wh);
 
EXPORT Make_orig_unused(SALT39.StrType s0) := MakeFT_orig_unused(s0);
EXPORT InValid_orig_unused(SALT39.StrType s) := InValidFT_orig_unused(s);
EXPORT InValidMessage_orig_unused(UNSIGNED1 wh) := InValidMessageFT_orig_unused(wh);
 
EXPORT Make_orig_login_history_id(SALT39.StrType s0) := MakeFT_orig_login_history_id(s0);
EXPORT InValid_orig_login_history_id(SALT39.StrType s) := InValidFT_orig_login_history_id(s);
EXPORT InValidMessage_orig_login_history_id(UNSIGNED1 wh) := InValidMessageFT_orig_login_history_id(wh);
 
EXPORT Make_orig_aseid(SALT39.StrType s0) := MakeFT_orig_aseid(s0);
EXPORT InValid_orig_aseid(SALT39.StrType s) := InValidFT_orig_aseid(s);
EXPORT InValidMessage_orig_aseid(UNSIGNED1 wh) := InValidMessageFT_orig_aseid(wh);
 
EXPORT Make_orig_years(SALT39.StrType s0) := MakeFT_orig_years(s0);
EXPORT InValid_orig_years(SALT39.StrType s) := InValidFT_orig_years(s);
EXPORT InValidMessage_orig_years(UNSIGNED1 wh) := InValidMessageFT_orig_years(wh);
 
EXPORT Make_orig_ip_address(SALT39.StrType s0) := MakeFT_orig_ip_address(s0);
EXPORT InValid_orig_ip_address(SALT39.StrType s) := InValidFT_orig_ip_address(s);
EXPORT InValidMessage_orig_ip_address(UNSIGNED1 wh) := InValidMessageFT_orig_ip_address(wh);
 
EXPORT Make_orig_source_code(SALT39.StrType s0) := MakeFT_orig_source_code(s0);
EXPORT InValid_orig_source_code(SALT39.StrType s) := InValidFT_orig_source_code(s);
EXPORT InValidMessage_orig_source_code(UNSIGNED1 wh) := InValidMessageFT_orig_source_code(wh);
 
EXPORT Make_orig_retail_price(SALT39.StrType s0) := MakeFT_orig_retail_price(s0);
EXPORT InValid_orig_retail_price(SALT39.StrType s) := InValidFT_orig_retail_price(s);
EXPORT InValidMessage_orig_retail_price(UNSIGNED1 wh) := InValidMessageFT_orig_retail_price(wh);
 
EXPORT Make_inquiry_type(SALT39.StrType s0) := MakeFT_inquiry_type(s0);
EXPORT InValid_inquiry_type(SALT39.StrType s) := InValidFT_inquiry_type(s);
EXPORT InValidMessage_inquiry_type(UNSIGNED1 wh) := InValidMessageFT_inquiry_type(wh);
 
EXPORT Make_lex_id(SALT39.StrType s0) := MakeFT_lex_id(s0);
EXPORT InValid_lex_id(SALT39.StrType s) := InValidFT_lex_id(s);
EXPORT InValidMessage_lex_id(UNSIGNED1 wh) := InValidMessageFT_lex_id(wh);
 
EXPORT Make_reprice_batch_number(SALT39.StrType s0) := MakeFT_reprice_batch_number(s0);
EXPORT InValid_reprice_batch_number(SALT39.StrType s) := InValidFT_reprice_batch_number(s);
EXPORT InValidMessage_reprice_batch_number(UNSIGNED1 wh) := InValidMessageFT_reprice_batch_number(wh);
 
EXPORT Make_user_changed(SALT39.StrType s0) := MakeFT_user_changed(s0);
EXPORT InValid_user_changed(SALT39.StrType s) := InValidFT_user_changed(s);
EXPORT InValidMessage_user_changed(UNSIGNED1 wh) := InValidMessageFT_user_changed(wh);
 
EXPORT Make_date_changed(SALT39.StrType s0) := MakeFT_date_changed(s0);
EXPORT InValid_date_changed(SALT39.StrType s) := InValidFT_date_changed(s);
EXPORT InValidMessage_date_changed(UNSIGNED1 wh) := InValidMessageFT_date_changed(wh);
 
EXPORT Make_fcra_purpose(SALT39.StrType s0) := MakeFT_fcra_purpose(s0);
EXPORT InValid_fcra_purpose(SALT39.StrType s) := InValidFT_fcra_purpose(s);
EXPORT InValidMessage_fcra_purpose(UNSIGNED1 wh) := InValidMessageFT_fcra_purpose(wh);
 
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
 
EXPORT Make_orig_jobid(SALT39.StrType s0) := MakeFT_orig_jobid(s0);
EXPORT InValid_orig_jobid(SALT39.StrType s) := InValidFT_orig_jobid(s);
EXPORT InValidMessage_orig_jobid(UNSIGNED1 wh) := InValidMessageFT_orig_jobid(wh);
 
EXPORT Make_orig_acctno(SALT39.StrType s0) := MakeFT_orig_acctno(s0);
EXPORT InValid_orig_acctno(SALT39.StrType s) := InValidFT_orig_acctno(s);
EXPORT InValidMessage_orig_acctno(UNSIGNED1 wh) := InValidMessageFT_orig_acctno(wh);
 
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
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT39,Scrubs_Inql_fcra_Accurint;
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
    BOOLEAN Diff_orig_end_user_id;
    BOOLEAN Diff_orig_loginid;
    BOOLEAN Diff_orig_billing_code;
    BOOLEAN Diff_orig_transaction_id;
    BOOLEAN Diff_orig_transaction_type;
    BOOLEAN Diff_orig_neighbors;
    BOOLEAN Diff_orig_relatives;
    BOOLEAN Diff_orig_associates;
    BOOLEAN Diff_orig_property;
    BOOLEAN Diff_orig_company_id;
    BOOLEAN Diff_orig_reference_code;
    BOOLEAN Diff_orig_fname;
    BOOLEAN Diff_orig_mname;
    BOOLEAN Diff_orig_lname;
    BOOLEAN Diff_orig_address;
    BOOLEAN Diff_orig_city;
    BOOLEAN Diff_orig_state;
    BOOLEAN Diff_orig_zip;
    BOOLEAN Diff_orig_zip4;
    BOOLEAN Diff_orig_phone;
    BOOLEAN Diff_orig_ssn;
    BOOLEAN Diff_orig_free;
    BOOLEAN Diff_orig_record_count;
    BOOLEAN Diff_orig_price;
    BOOLEAN Diff_orig_bankruptcy;
    BOOLEAN Diff_orig_transaction_code;
    BOOLEAN Diff_orig_dateadded;
    BOOLEAN Diff_orig_full_name;
    BOOLEAN Diff_orig_billingdate;
    BOOLEAN Diff_orig_business_name;
    BOOLEAN Diff_orig_pricing_error_code;
    BOOLEAN Diff_orig_dl_purpose;
    BOOLEAN Diff_orig_result_format;
    BOOLEAN Diff_orig_dob;
    BOOLEAN Diff_orig_unique_id;
    BOOLEAN Diff_orig_dls;
    BOOLEAN Diff_orig_mvs;
    BOOLEAN Diff_orig_function_name;
    BOOLEAN Diff_orig_response_time;
    BOOLEAN Diff_orig_data_source;
    BOOLEAN Diff_orig_glb_purpose;
    BOOLEAN Diff_orig_report_options;
    BOOLEAN Diff_orig_unused;
    BOOLEAN Diff_orig_login_history_id;
    BOOLEAN Diff_orig_aseid;
    BOOLEAN Diff_orig_years;
    BOOLEAN Diff_orig_ip_address;
    BOOLEAN Diff_orig_source_code;
    BOOLEAN Diff_orig_retail_price;
    BOOLEAN Diff_inquiry_type;
    BOOLEAN Diff_lex_id;
    BOOLEAN Diff_reprice_batch_number;
    BOOLEAN Diff_user_changed;
    BOOLEAN Diff_date_changed;
    BOOLEAN Diff_fcra_purpose;
    BOOLEAN Diff_orig_address_2;
    BOOLEAN Diff_orig_city_2;
    BOOLEAN Diff_orig_state_2;
    BOOLEAN Diff_orig_zip_2;
    BOOLEAN Diff_orig_zip4_2;
    BOOLEAN Diff_orig_jobid;
    BOOLEAN Diff_orig_acctno;
    BOOLEAN Diff_orig_end_user_name;
    BOOLEAN Diff_orig_end_user_address_1;
    BOOLEAN Diff_orig_end_user_address_2;
    BOOLEAN Diff_orig_end_user_city;
    BOOLEAN Diff_orig_end_user_state;
    BOOLEAN Diff_orig_end_user_zip;
    UNSIGNED Num_Diffs;
    SALT39.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_orig_end_user_id := le.orig_end_user_id <> ri.orig_end_user_id;
    SELF.Diff_orig_loginid := le.orig_loginid <> ri.orig_loginid;
    SELF.Diff_orig_billing_code := le.orig_billing_code <> ri.orig_billing_code;
    SELF.Diff_orig_transaction_id := le.orig_transaction_id <> ri.orig_transaction_id;
    SELF.Diff_orig_transaction_type := le.orig_transaction_type <> ri.orig_transaction_type;
    SELF.Diff_orig_neighbors := le.orig_neighbors <> ri.orig_neighbors;
    SELF.Diff_orig_relatives := le.orig_relatives <> ri.orig_relatives;
    SELF.Diff_orig_associates := le.orig_associates <> ri.orig_associates;
    SELF.Diff_orig_property := le.orig_property <> ri.orig_property;
    SELF.Diff_orig_company_id := le.orig_company_id <> ri.orig_company_id;
    SELF.Diff_orig_reference_code := le.orig_reference_code <> ri.orig_reference_code;
    SELF.Diff_orig_fname := le.orig_fname <> ri.orig_fname;
    SELF.Diff_orig_mname := le.orig_mname <> ri.orig_mname;
    SELF.Diff_orig_lname := le.orig_lname <> ri.orig_lname;
    SELF.Diff_orig_address := le.orig_address <> ri.orig_address;
    SELF.Diff_orig_city := le.orig_city <> ri.orig_city;
    SELF.Diff_orig_state := le.orig_state <> ri.orig_state;
    SELF.Diff_orig_zip := le.orig_zip <> ri.orig_zip;
    SELF.Diff_orig_zip4 := le.orig_zip4 <> ri.orig_zip4;
    SELF.Diff_orig_phone := le.orig_phone <> ri.orig_phone;
    SELF.Diff_orig_ssn := le.orig_ssn <> ri.orig_ssn;
    SELF.Diff_orig_free := le.orig_free <> ri.orig_free;
    SELF.Diff_orig_record_count := le.orig_record_count <> ri.orig_record_count;
    SELF.Diff_orig_price := le.orig_price <> ri.orig_price;
    SELF.Diff_orig_bankruptcy := le.orig_bankruptcy <> ri.orig_bankruptcy;
    SELF.Diff_orig_transaction_code := le.orig_transaction_code <> ri.orig_transaction_code;
    SELF.Diff_orig_dateadded := le.orig_dateadded <> ri.orig_dateadded;
    SELF.Diff_orig_full_name := le.orig_full_name <> ri.orig_full_name;
    SELF.Diff_orig_billingdate := le.orig_billingdate <> ri.orig_billingdate;
    SELF.Diff_orig_business_name := le.orig_business_name <> ri.orig_business_name;
    SELF.Diff_orig_pricing_error_code := le.orig_pricing_error_code <> ri.orig_pricing_error_code;
    SELF.Diff_orig_dl_purpose := le.orig_dl_purpose <> ri.orig_dl_purpose;
    SELF.Diff_orig_result_format := le.orig_result_format <> ri.orig_result_format;
    SELF.Diff_orig_dob := le.orig_dob <> ri.orig_dob;
    SELF.Diff_orig_unique_id := le.orig_unique_id <> ri.orig_unique_id;
    SELF.Diff_orig_dls := le.orig_dls <> ri.orig_dls;
    SELF.Diff_orig_mvs := le.orig_mvs <> ri.orig_mvs;
    SELF.Diff_orig_function_name := le.orig_function_name <> ri.orig_function_name;
    SELF.Diff_orig_response_time := le.orig_response_time <> ri.orig_response_time;
    SELF.Diff_orig_data_source := le.orig_data_source <> ri.orig_data_source;
    SELF.Diff_orig_glb_purpose := le.orig_glb_purpose <> ri.orig_glb_purpose;
    SELF.Diff_orig_report_options := le.orig_report_options <> ri.orig_report_options;
    SELF.Diff_orig_unused := le.orig_unused <> ri.orig_unused;
    SELF.Diff_orig_login_history_id := le.orig_login_history_id <> ri.orig_login_history_id;
    SELF.Diff_orig_aseid := le.orig_aseid <> ri.orig_aseid;
    SELF.Diff_orig_years := le.orig_years <> ri.orig_years;
    SELF.Diff_orig_ip_address := le.orig_ip_address <> ri.orig_ip_address;
    SELF.Diff_orig_source_code := le.orig_source_code <> ri.orig_source_code;
    SELF.Diff_orig_retail_price := le.orig_retail_price <> ri.orig_retail_price;
    SELF.Diff_inquiry_type := le.inquiry_type <> ri.inquiry_type;
    SELF.Diff_lex_id := le.lex_id <> ri.lex_id;
    SELF.Diff_reprice_batch_number := le.reprice_batch_number <> ri.reprice_batch_number;
    SELF.Diff_user_changed := le.user_changed <> ri.user_changed;
    SELF.Diff_date_changed := le.date_changed <> ri.date_changed;
    SELF.Diff_fcra_purpose := le.fcra_purpose <> ri.fcra_purpose;
    SELF.Diff_orig_address_2 := le.orig_address_2 <> ri.orig_address_2;
    SELF.Diff_orig_city_2 := le.orig_city_2 <> ri.orig_city_2;
    SELF.Diff_orig_state_2 := le.orig_state_2 <> ri.orig_state_2;
    SELF.Diff_orig_zip_2 := le.orig_zip_2 <> ri.orig_zip_2;
    SELF.Diff_orig_zip4_2 := le.orig_zip4_2 <> ri.orig_zip4_2;
    SELF.Diff_orig_jobid := le.orig_jobid <> ri.orig_jobid;
    SELF.Diff_orig_acctno := le.orig_acctno <> ri.orig_acctno;
    SELF.Diff_orig_end_user_name := le.orig_end_user_name <> ri.orig_end_user_name;
    SELF.Diff_orig_end_user_address_1 := le.orig_end_user_address_1 <> ri.orig_end_user_address_1;
    SELF.Diff_orig_end_user_address_2 := le.orig_end_user_address_2 <> ri.orig_end_user_address_2;
    SELF.Diff_orig_end_user_city := le.orig_end_user_city <> ri.orig_end_user_city;
    SELF.Diff_orig_end_user_state := le.orig_end_user_state <> ri.orig_end_user_state;
    SELF.Diff_orig_end_user_zip := le.orig_end_user_zip <> ri.orig_end_user_zip;
    SELF.Val := (SALT39.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_orig_end_user_id,1,0)+ IF( SELF.Diff_orig_loginid,1,0)+ IF( SELF.Diff_orig_billing_code,1,0)+ IF( SELF.Diff_orig_transaction_id,1,0)+ IF( SELF.Diff_orig_transaction_type,1,0)+ IF( SELF.Diff_orig_neighbors,1,0)+ IF( SELF.Diff_orig_relatives,1,0)+ IF( SELF.Diff_orig_associates,1,0)+ IF( SELF.Diff_orig_property,1,0)+ IF( SELF.Diff_orig_company_id,1,0)+ IF( SELF.Diff_orig_reference_code,1,0)+ IF( SELF.Diff_orig_fname,1,0)+ IF( SELF.Diff_orig_mname,1,0)+ IF( SELF.Diff_orig_lname,1,0)+ IF( SELF.Diff_orig_address,1,0)+ IF( SELF.Diff_orig_city,1,0)+ IF( SELF.Diff_orig_state,1,0)+ IF( SELF.Diff_orig_zip,1,0)+ IF( SELF.Diff_orig_zip4,1,0)+ IF( SELF.Diff_orig_phone,1,0)+ IF( SELF.Diff_orig_ssn,1,0)+ IF( SELF.Diff_orig_free,1,0)+ IF( SELF.Diff_orig_record_count,1,0)+ IF( SELF.Diff_orig_price,1,0)+ IF( SELF.Diff_orig_bankruptcy,1,0)+ IF( SELF.Diff_orig_transaction_code,1,0)+ IF( SELF.Diff_orig_dateadded,1,0)+ IF( SELF.Diff_orig_full_name,1,0)+ IF( SELF.Diff_orig_billingdate,1,0)+ IF( SELF.Diff_orig_business_name,1,0)+ IF( SELF.Diff_orig_pricing_error_code,1,0)+ IF( SELF.Diff_orig_dl_purpose,1,0)+ IF( SELF.Diff_orig_result_format,1,0)+ IF( SELF.Diff_orig_dob,1,0)+ IF( SELF.Diff_orig_unique_id,1,0)+ IF( SELF.Diff_orig_dls,1,0)+ IF( SELF.Diff_orig_mvs,1,0)+ IF( SELF.Diff_orig_function_name,1,0)+ IF( SELF.Diff_orig_response_time,1,0)+ IF( SELF.Diff_orig_data_source,1,0)+ IF( SELF.Diff_orig_glb_purpose,1,0)+ IF( SELF.Diff_orig_report_options,1,0)+ IF( SELF.Diff_orig_unused,1,0)+ IF( SELF.Diff_orig_login_history_id,1,0)+ IF( SELF.Diff_orig_aseid,1,0)+ IF( SELF.Diff_orig_years,1,0)+ IF( SELF.Diff_orig_ip_address,1,0)+ IF( SELF.Diff_orig_source_code,1,0)+ IF( SELF.Diff_orig_retail_price,1,0)+ IF( SELF.Diff_inquiry_type,1,0)+ IF( SELF.Diff_lex_id,1,0)+ IF( SELF.Diff_reprice_batch_number,1,0)+ IF( SELF.Diff_user_changed,1,0)+ IF( SELF.Diff_date_changed,1,0)+ IF( SELF.Diff_fcra_purpose,1,0)+ IF( SELF.Diff_orig_address_2,1,0)+ IF( SELF.Diff_orig_city_2,1,0)+ IF( SELF.Diff_orig_state_2,1,0)+ IF( SELF.Diff_orig_zip_2,1,0)+ IF( SELF.Diff_orig_zip4_2,1,0)+ IF( SELF.Diff_orig_jobid,1,0)+ IF( SELF.Diff_orig_acctno,1,0)+ IF( SELF.Diff_orig_end_user_name,1,0)+ IF( SELF.Diff_orig_end_user_address_1,1,0)+ IF( SELF.Diff_orig_end_user_address_2,1,0)+ IF( SELF.Diff_orig_end_user_city,1,0)+ IF( SELF.Diff_orig_end_user_state,1,0)+ IF( SELF.Diff_orig_end_user_zip,1,0);
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
    Count_Diff_orig_end_user_id := COUNT(GROUP,%Closest%.Diff_orig_end_user_id);
    Count_Diff_orig_loginid := COUNT(GROUP,%Closest%.Diff_orig_loginid);
    Count_Diff_orig_billing_code := COUNT(GROUP,%Closest%.Diff_orig_billing_code);
    Count_Diff_orig_transaction_id := COUNT(GROUP,%Closest%.Diff_orig_transaction_id);
    Count_Diff_orig_transaction_type := COUNT(GROUP,%Closest%.Diff_orig_transaction_type);
    Count_Diff_orig_neighbors := COUNT(GROUP,%Closest%.Diff_orig_neighbors);
    Count_Diff_orig_relatives := COUNT(GROUP,%Closest%.Diff_orig_relatives);
    Count_Diff_orig_associates := COUNT(GROUP,%Closest%.Diff_orig_associates);
    Count_Diff_orig_property := COUNT(GROUP,%Closest%.Diff_orig_property);
    Count_Diff_orig_company_id := COUNT(GROUP,%Closest%.Diff_orig_company_id);
    Count_Diff_orig_reference_code := COUNT(GROUP,%Closest%.Diff_orig_reference_code);
    Count_Diff_orig_fname := COUNT(GROUP,%Closest%.Diff_orig_fname);
    Count_Diff_orig_mname := COUNT(GROUP,%Closest%.Diff_orig_mname);
    Count_Diff_orig_lname := COUNT(GROUP,%Closest%.Diff_orig_lname);
    Count_Diff_orig_address := COUNT(GROUP,%Closest%.Diff_orig_address);
    Count_Diff_orig_city := COUNT(GROUP,%Closest%.Diff_orig_city);
    Count_Diff_orig_state := COUNT(GROUP,%Closest%.Diff_orig_state);
    Count_Diff_orig_zip := COUNT(GROUP,%Closest%.Diff_orig_zip);
    Count_Diff_orig_zip4 := COUNT(GROUP,%Closest%.Diff_orig_zip4);
    Count_Diff_orig_phone := COUNT(GROUP,%Closest%.Diff_orig_phone);
    Count_Diff_orig_ssn := COUNT(GROUP,%Closest%.Diff_orig_ssn);
    Count_Diff_orig_free := COUNT(GROUP,%Closest%.Diff_orig_free);
    Count_Diff_orig_record_count := COUNT(GROUP,%Closest%.Diff_orig_record_count);
    Count_Diff_orig_price := COUNT(GROUP,%Closest%.Diff_orig_price);
    Count_Diff_orig_bankruptcy := COUNT(GROUP,%Closest%.Diff_orig_bankruptcy);
    Count_Diff_orig_transaction_code := COUNT(GROUP,%Closest%.Diff_orig_transaction_code);
    Count_Diff_orig_dateadded := COUNT(GROUP,%Closest%.Diff_orig_dateadded);
    Count_Diff_orig_full_name := COUNT(GROUP,%Closest%.Diff_orig_full_name);
    Count_Diff_orig_billingdate := COUNT(GROUP,%Closest%.Diff_orig_billingdate);
    Count_Diff_orig_business_name := COUNT(GROUP,%Closest%.Diff_orig_business_name);
    Count_Diff_orig_pricing_error_code := COUNT(GROUP,%Closest%.Diff_orig_pricing_error_code);
    Count_Diff_orig_dl_purpose := COUNT(GROUP,%Closest%.Diff_orig_dl_purpose);
    Count_Diff_orig_result_format := COUNT(GROUP,%Closest%.Diff_orig_result_format);
    Count_Diff_orig_dob := COUNT(GROUP,%Closest%.Diff_orig_dob);
    Count_Diff_orig_unique_id := COUNT(GROUP,%Closest%.Diff_orig_unique_id);
    Count_Diff_orig_dls := COUNT(GROUP,%Closest%.Diff_orig_dls);
    Count_Diff_orig_mvs := COUNT(GROUP,%Closest%.Diff_orig_mvs);
    Count_Diff_orig_function_name := COUNT(GROUP,%Closest%.Diff_orig_function_name);
    Count_Diff_orig_response_time := COUNT(GROUP,%Closest%.Diff_orig_response_time);
    Count_Diff_orig_data_source := COUNT(GROUP,%Closest%.Diff_orig_data_source);
    Count_Diff_orig_glb_purpose := COUNT(GROUP,%Closest%.Diff_orig_glb_purpose);
    Count_Diff_orig_report_options := COUNT(GROUP,%Closest%.Diff_orig_report_options);
    Count_Diff_orig_unused := COUNT(GROUP,%Closest%.Diff_orig_unused);
    Count_Diff_orig_login_history_id := COUNT(GROUP,%Closest%.Diff_orig_login_history_id);
    Count_Diff_orig_aseid := COUNT(GROUP,%Closest%.Diff_orig_aseid);
    Count_Diff_orig_years := COUNT(GROUP,%Closest%.Diff_orig_years);
    Count_Diff_orig_ip_address := COUNT(GROUP,%Closest%.Diff_orig_ip_address);
    Count_Diff_orig_source_code := COUNT(GROUP,%Closest%.Diff_orig_source_code);
    Count_Diff_orig_retail_price := COUNT(GROUP,%Closest%.Diff_orig_retail_price);
    Count_Diff_inquiry_type := COUNT(GROUP,%Closest%.Diff_inquiry_type);
    Count_Diff_lex_id := COUNT(GROUP,%Closest%.Diff_lex_id);
    Count_Diff_reprice_batch_number := COUNT(GROUP,%Closest%.Diff_reprice_batch_number);
    Count_Diff_user_changed := COUNT(GROUP,%Closest%.Diff_user_changed);
    Count_Diff_date_changed := COUNT(GROUP,%Closest%.Diff_date_changed);
    Count_Diff_fcra_purpose := COUNT(GROUP,%Closest%.Diff_fcra_purpose);
    Count_Diff_orig_address_2 := COUNT(GROUP,%Closest%.Diff_orig_address_2);
    Count_Diff_orig_city_2 := COUNT(GROUP,%Closest%.Diff_orig_city_2);
    Count_Diff_orig_state_2 := COUNT(GROUP,%Closest%.Diff_orig_state_2);
    Count_Diff_orig_zip_2 := COUNT(GROUP,%Closest%.Diff_orig_zip_2);
    Count_Diff_orig_zip4_2 := COUNT(GROUP,%Closest%.Diff_orig_zip4_2);
    Count_Diff_orig_jobid := COUNT(GROUP,%Closest%.Diff_orig_jobid);
    Count_Diff_orig_acctno := COUNT(GROUP,%Closest%.Diff_orig_acctno);
    Count_Diff_orig_end_user_name := COUNT(GROUP,%Closest%.Diff_orig_end_user_name);
    Count_Diff_orig_end_user_address_1 := COUNT(GROUP,%Closest%.Diff_orig_end_user_address_1);
    Count_Diff_orig_end_user_address_2 := COUNT(GROUP,%Closest%.Diff_orig_end_user_address_2);
    Count_Diff_orig_end_user_city := COUNT(GROUP,%Closest%.Diff_orig_end_user_city);
    Count_Diff_orig_end_user_state := COUNT(GROUP,%Closest%.Diff_orig_end_user_state);
    Count_Diff_orig_end_user_zip := COUNT(GROUP,%Closest%.Diff_orig_end_user_zip);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
