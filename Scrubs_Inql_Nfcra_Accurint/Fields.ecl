IMPORT SALT39;
EXPORT Fields := MODULE
 
EXPORT NumFields := 49;
 
// Processing for each FieldType
EXPORT SALT39.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'DEFAULT','ALPHA','NAME','NUMBER','WORDBAG','orig_end_user_id','orig_loginid','orig_billing_code','orig_transaction_id','orig_transaction_type','orig_neighbors','orig_relatives','orig_associates','orig_property','orig_company_id','orig_reference_code','orig_fname','orig_mname','orig_lname','orig_address','orig_city','orig_state','orig_zip','orig_zip4','orig_phone','orig_ssn','orig_free','orig_record_count','orig_price','orig_bankruptcy','orig_transaction_code','orig_dateadded','orig_full_name','orig_billingdate','orig_business_name','orig_pricing_error_code','orig_dl_purpose','orig_result_format','orig_dob','orig_unique_id','orig_dls','orig_mvs','orig_function_name','orig_response_time','orig_data_source','orig_glb_purpose','orig_report_options','orig_unused','orig_login_history_id','orig_aseid','orig_years','orig_ip_address','orig_source_code','orig_retail_price');
EXPORT FieldTypeNum(SALT39.StrType fn) := CASE(fn,'DEFAULT' => 1,'ALPHA' => 2,'NAME' => 3,'NUMBER' => 4,'WORDBAG' => 5,'orig_end_user_id' => 6,'orig_loginid' => 7,'orig_billing_code' => 8,'orig_transaction_id' => 9,'orig_transaction_type' => 10,'orig_neighbors' => 11,'orig_relatives' => 12,'orig_associates' => 13,'orig_property' => 14,'orig_company_id' => 15,'orig_reference_code' => 16,'orig_fname' => 17,'orig_mname' => 18,'orig_lname' => 19,'orig_address' => 20,'orig_city' => 21,'orig_state' => 22,'orig_zip' => 23,'orig_zip4' => 24,'orig_phone' => 25,'orig_ssn' => 26,'orig_free' => 27,'orig_record_count' => 28,'orig_price' => 29,'orig_bankruptcy' => 30,'orig_transaction_code' => 31,'orig_dateadded' => 32,'orig_full_name' => 33,'orig_billingdate' => 34,'orig_business_name' => 35,'orig_pricing_error_code' => 36,'orig_dl_purpose' => 37,'orig_result_format' => 38,'orig_dob' => 39,'orig_unique_id' => 40,'orig_dls' => 41,'orig_mvs' => 42,'orig_function_name' => 43,'orig_response_time' => 44,'orig_data_source' => 45,'orig_glb_purpose' => 46,'orig_report_options' => 47,'orig_unused' => 48,'orig_login_history_id' => 49,'orig_aseid' => 50,'orig_years' => 51,'orig_ip_address' => 52,'orig_source_code' => 53,'orig_retail_price' => 54,0);
 
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
 
EXPORT MakeFT_WORDBAG(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_WORDBAG(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$ '))));
EXPORT InValidMessageFT_WORDBAG(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$ '),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_end_user_id(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_NUMBER(s2);
END;
EXPORT InValidFT_orig_end_user_id(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789 '))));
EXPORT InValidMessageFT_orig_end_user_id(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('0123456789 '),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_loginid(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_WORDBAG(s2);
END;
EXPORT InValidFT_orig_loginid(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$ '))),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_loginid(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$ '),SALT39.HygieneErrors.NotWords('1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_billing_code(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_WORDBAG(s2);
END;
EXPORT InValidFT_orig_billing_code(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$ '))));
EXPORT InValidMessageFT_orig_billing_code(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$ '),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_transaction_id(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789ABIRT '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_orig_transaction_id(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789ABIRT '))),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_transaction_id(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('0123456789ABIRT '),SALT39.HygieneErrors.NotWords('1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_transaction_type(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'IRSTY '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_orig_transaction_type(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'IRSTY '))),~(LENGTH(TRIM(s)) = 1),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_transaction_type(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('IRSTY '),SALT39.HygieneErrors.NotLength('1'),SALT39.HygieneErrors.NotWords('1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_neighbors(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'01 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_orig_neighbors(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'01 '))),~(LENGTH(TRIM(s)) = 1),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_neighbors(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('01 '),SALT39.HygieneErrors.NotLength('1'),SALT39.HygieneErrors.NotWords('1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_relatives(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_orig_relatives(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123 '))),~(LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 2),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_relatives(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('0123 '),SALT39.HygieneErrors.NotLength('1,2'),SALT39.HygieneErrors.NotWords('1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_associates(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'01 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_orig_associates(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'01 '))),~(LENGTH(TRIM(s)) = 1),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_associates(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('01 '),SALT39.HygieneErrors.NotLength('1'),SALT39.HygieneErrors.NotWords('1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_property(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'01 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_orig_property(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'01 '))),~(LENGTH(TRIM(s)) = 1),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_property(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('01 '),SALT39.HygieneErrors.NotLength('1'),SALT39.HygieneErrors.NotWords('1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_company_id(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_NUMBER(s2);
END;
EXPORT InValidFT_orig_company_id(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 7),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_company_id(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('0123456789 '),SALT39.HygieneErrors.NotLength('7'),SALT39.HygieneErrors.NotWords('1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_reference_code(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_WORDBAG(s2);
END;
EXPORT InValidFT_orig_reference_code(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$ '))));
EXPORT InValidMessageFT_orig_reference_code(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$ '),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_fname(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz-,\'. '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_NAME(s2);
END;
EXPORT InValidFT_orig_fname(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz-,\'. '))),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) >= 0 AND SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) <= 2));
EXPORT InValidMessageFT_orig_fname(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz-,\'. '),SALT39.HygieneErrors.NotWords('0..2'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_mname(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz-,\'. '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_NAME(s2);
END;
EXPORT InValidFT_orig_mname(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz-,\'. '))),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) >= 0 AND SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) <= 2));
EXPORT InValidMessageFT_orig_mname(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz-,\'. '),SALT39.HygieneErrors.NotWords('0..2'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_lname(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz-,\'. '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_NAME(s2);
END;
EXPORT InValidFT_orig_lname(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz-,\'. '))),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) >= 0 AND SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) <= 2));
EXPORT InValidMessageFT_orig_lname(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz-,\'. '),SALT39.HygieneErrors.NotWords('0..2'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_address(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_WORDBAG(s2);
END;
EXPORT InValidFT_orig_address(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$ '))));
EXPORT InValidMessageFT_orig_address(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$ '),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_city(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_ALPHA(s2);
END;
EXPORT InValidFT_orig_city(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '))),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) >= 0 AND SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) <= 3));
EXPORT InValidMessageFT_orig_city(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '),SALT39.HygieneErrors.NotWords('0..3'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_state(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_ALPHA(s2);
END;
EXPORT InValidFT_orig_state(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '))),~(LENGTH(TRIM(s)) >= 0 AND LENGTH(TRIM(s)) <= 2),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_state(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '),SALT39.HygieneErrors.NotLength('0..2'),SALT39.HygieneErrors.NotWords('0,1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_zip(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_NUMBER(s2);
END;
EXPORT InValidFT_orig_zip(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 5),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_zip(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('0123456789 '),SALT39.HygieneErrors.NotLength('0,5'),SALT39.HygieneErrors.NotWords('0,1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_zip4(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_NUMBER(s2);
END;
EXPORT InValidFT_orig_zip4(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 4),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_zip4(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('0123456789 '),SALT39.HygieneErrors.NotLength('0,4'),SALT39.HygieneErrors.NotWords('0,1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_phone(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s0,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s1;
END;
EXPORT InValidFT_orig_phone(SALT39.StrType s) := WHICH(~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 10 OR LENGTH(TRIM(s)) = 11 OR LENGTH(TRIM(s)) = 12),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_phone(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLength('0,10,11,12'),SALT39.HygieneErrors.NotWords('0,1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_ssn(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_NUMBER(s2);
END;
EXPORT InValidFT_orig_ssn(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) >= 0 AND LENGTH(TRIM(s)) <= 9),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_ssn(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('0123456789 '),SALT39.HygieneErrors.NotLength('0..9'),SALT39.HygieneErrors.NotWords('0,1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_free(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'02346 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_orig_free(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'02346 '))),~(LENGTH(TRIM(s)) = 1),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_free(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('02346 '),SALT39.HygieneErrors.NotLength('1'),SALT39.HygieneErrors.NotWords('1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_record_count(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_NUMBER(s2);
END;
EXPORT InValidFT_orig_record_count(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 3),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_record_count(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('0123456789 '),SALT39.HygieneErrors.NotLength('1,2,3'),SALT39.HygieneErrors.NotWords('1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_price(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s0,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s1;
END;
EXPORT InValidFT_orig_price(SALT39.StrType s) := WHICH(~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_price(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotWords('1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_bankruptcy(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'01 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_orig_bankruptcy(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'01 '))),~(LENGTH(TRIM(s)) = 1),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_bankruptcy(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('01 '),SALT39.HygieneErrors.NotLength('1'),SALT39.HygieneErrors.NotWords('1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_transaction_code(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_NUMBER(s2);
END;
EXPORT InValidFT_orig_transaction_code(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 3 OR LENGTH(TRIM(s)) = 5),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_transaction_code(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('0123456789 '),SALT39.HygieneErrors.NotLength('3,5'),SALT39.HygieneErrors.NotWords('1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_dateadded(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,' 0123456789:AMPSep '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_orig_dateadded(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,' 0123456789:AMPSep '))),~(LENGTH(TRIM(s)) = 26),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 4));
EXPORT InValidMessageFT_orig_dateadded(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars(' 0123456789:AMPSep '),SALT39.HygieneErrors.NotLength('26'),SALT39.HygieneErrors.NotWords('4'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_full_name(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz-,\'. '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_NAME(s2);
END;
EXPORT InValidFT_orig_full_name(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz-,\'. '))),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) >= 0 AND SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) <= 3));
EXPORT InValidMessageFT_orig_full_name(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz-,\'. '),SALT39.HygieneErrors.NotWords('0..3'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_billingdate(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,' '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_orig_billingdate(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,' '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_billingdate(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars(' '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_business_name(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_WORDBAG(s2);
END;
EXPORT InValidFT_orig_business_name(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$ '))));
EXPORT InValidMessageFT_orig_business_name(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$ '),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_pricing_error_code(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'-0123 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_orig_pricing_error_code(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'-0123 '))),~(LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 2),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_pricing_error_code(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('-0123 '),SALT39.HygieneErrors.NotLength('1,2'),SALT39.HygieneErrors.NotWords('1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_dl_purpose(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_NUMBER(s2);
END;
EXPORT InValidFT_orig_dl_purpose(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 1),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_dl_purpose(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('0123456789 '),SALT39.HygieneErrors.NotLength('1'),SALT39.HygieneErrors.NotWords('1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_result_format(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0CNcn '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_orig_result_format(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0CNcn '))),~(LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 2),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_result_format(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('0CNcn '),SALT39.HygieneErrors.NotLength('1,2'),SALT39.HygieneErrors.NotWords('1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_dob(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_NUMBER(s2);
END;
EXPORT InValidFT_orig_dob(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) >= 0 AND LENGTH(TRIM(s)) <= 8),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_dob(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('0123456789 '),SALT39.HygieneErrors.NotLength('0..8'),SALT39.HygieneErrors.NotWords('0,1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_unique_id(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_WORDBAG(s2);
END;
EXPORT InValidFT_orig_unique_id(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$ '))),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_unique_id(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$ '),SALT39.HygieneErrors.NotWords('1,0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_dls(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'01 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_orig_dls(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'01 '))),~(LENGTH(TRIM(s)) = 1),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_dls(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('01 '),SALT39.HygieneErrors.NotLength('1'),SALT39.HygieneErrors.NotWords('1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_mvs(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'012 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_orig_mvs(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'012 '))),~(LENGTH(TRIM(s)) = 1),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_mvs(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('012 '),SALT39.HygieneErrors.NotLength('1'),SALT39.HygieneErrors.NotWords('1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_function_name(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_WORDBAG(s2);
END;
EXPORT InValidFT_orig_function_name(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$ '))),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_function_name(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$ '),SALT39.HygieneErrors.NotWords('1,0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_response_time(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s0,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s1;
END;
EXPORT InValidFT_orig_response_time(SALT39.StrType s) := WHICH(~(LENGTH(TRIM(s)) = 4),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_response_time(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLength('4'),SALT39.HygieneErrors.NotWords('1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_data_source(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ABDLRSTVaceilmo '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_orig_data_source(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABDLRSTVaceilmo '))),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_data_source(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('ABDLRSTVaceilmo '),SALT39.HygieneErrors.NotWords('0,1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_glb_purpose(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_NUMBER(s2);
END;
EXPORT InValidFT_orig_glb_purpose(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789 '))),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_glb_purpose(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('0123456789 '),SALT39.HygieneErrors.NotWords('1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_report_options(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,' ,-.012349:acdeiu '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_orig_report_options(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,' ,-.012349:acdeiu '))),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 3));
EXPORT InValidMessageFT_orig_report_options(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars(' ,-.012349:acdeiu '),SALT39.HygieneErrors.NotWords('1,3'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_unused(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'1 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_orig_unused(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'1 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 1),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_unused(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('1 '),SALT39.HygieneErrors.NotLength('0,1'),SALT39.HygieneErrors.NotWords('0,1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_login_history_id(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_NUMBER(s2);
END;
EXPORT InValidFT_orig_login_history_id(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789 '))),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_login_history_id(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('0123456789 '),SALT39.HygieneErrors.NotWords('1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_aseid(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'36 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_orig_aseid(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'36 '))),~(LENGTH(TRIM(s)) = 1),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_aseid(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('36 '),SALT39.HygieneErrors.NotLength('1'),SALT39.HygieneErrors.NotWords('1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_years(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0125 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_orig_years(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0125 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 2),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_years(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('0125 '),SALT39.HygieneErrors.NotLength('0,2'),SALT39.HygieneErrors.NotWords('0,1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_ip_address(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s0,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s1;
END;
EXPORT InValidFT_orig_ip_address(SALT39.StrType s) := WHICH(~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_ip_address(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotWords('1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_source_code(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'01234 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_orig_source_code(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'01234 '))),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_source_code(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('01234 '),SALT39.HygieneErrors.NotWords('1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_retail_price(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s0,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s1;
END;
EXPORT InValidFT_orig_retail_price(SALT39.StrType s) := WHICH(~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_retail_price(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotWords('1'),SALT39.HygieneErrors.Good);
 
EXPORT SALT39.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'orig_end_user_id','orig_loginid','orig_billing_code','orig_transaction_id','orig_transaction_type','orig_neighbors','orig_relatives','orig_associates','orig_property','orig_company_id','orig_reference_code','orig_fname','orig_mname','orig_lname','orig_address','orig_city','orig_state','orig_zip','orig_zip4','orig_phone','orig_ssn','orig_free','orig_record_count','orig_price','orig_bankruptcy','orig_transaction_code','orig_dateadded','orig_full_name','orig_billingdate','orig_business_name','orig_pricing_error_code','orig_dl_purpose','orig_result_format','orig_dob','orig_unique_id','orig_dls','orig_mvs','orig_function_name','orig_response_time','orig_data_source','orig_glb_purpose','orig_report_options','orig_unused','orig_login_history_id','orig_aseid','orig_years','orig_ip_address','orig_source_code','orig_retail_price');
EXPORT SALT39.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'orig_end_user_id','orig_loginid','orig_billing_code','orig_transaction_id','orig_transaction_type','orig_neighbors','orig_relatives','orig_associates','orig_property','orig_company_id','orig_reference_code','orig_fname','orig_mname','orig_lname','orig_address','orig_city','orig_state','orig_zip','orig_zip4','orig_phone','orig_ssn','orig_free','orig_record_count','orig_price','orig_bankruptcy','orig_transaction_code','orig_dateadded','orig_full_name','orig_billingdate','orig_business_name','orig_pricing_error_code','orig_dl_purpose','orig_result_format','orig_dob','orig_unique_id','orig_dls','orig_mvs','orig_function_name','orig_response_time','orig_data_source','orig_glb_purpose','orig_report_options','orig_unused','orig_login_history_id','orig_aseid','orig_years','orig_ip_address','orig_source_code','orig_retail_price');
EXPORT FieldNum(SALT39.StrType fn) := CASE(fn,'orig_end_user_id' => 0,'orig_loginid' => 1,'orig_billing_code' => 2,'orig_transaction_id' => 3,'orig_transaction_type' => 4,'orig_neighbors' => 5,'orig_relatives' => 6,'orig_associates' => 7,'orig_property' => 8,'orig_company_id' => 9,'orig_reference_code' => 10,'orig_fname' => 11,'orig_mname' => 12,'orig_lname' => 13,'orig_address' => 14,'orig_city' => 15,'orig_state' => 16,'orig_zip' => 17,'orig_zip4' => 18,'orig_phone' => 19,'orig_ssn' => 20,'orig_free' => 21,'orig_record_count' => 22,'orig_price' => 23,'orig_bankruptcy' => 24,'orig_transaction_code' => 25,'orig_dateadded' => 26,'orig_full_name' => 27,'orig_billingdate' => 28,'orig_business_name' => 29,'orig_pricing_error_code' => 30,'orig_dl_purpose' => 31,'orig_result_format' => 32,'orig_dob' => 33,'orig_unique_id' => 34,'orig_dls' => 35,'orig_mvs' => 36,'orig_function_name' => 37,'orig_response_time' => 38,'orig_data_source' => 39,'orig_glb_purpose' => 40,'orig_report_options' => 41,'orig_unused' => 42,'orig_login_history_id' => 43,'orig_aseid' => 44,'orig_years' => 45,'orig_ip_address' => 46,'orig_source_code' => 47,'orig_retail_price' => 48,0);
EXPORT SET OF SALT39.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['ALLOW'],['ALLOW','WORDS'],['ALLOW'],['ALLOW','WORDS'],['ALLOW','LENGTHS','WORDS'],['ALLOW','LENGTHS','WORDS'],['ALLOW','LENGTHS','WORDS'],['ALLOW','LENGTHS','WORDS'],['ALLOW','LENGTHS','WORDS'],['ALLOW','LENGTHS','WORDS'],['ALLOW'],['ALLOW','WORDS'],['ALLOW','WORDS'],['ALLOW','WORDS'],['ALLOW'],['ALLOW','WORDS'],['ALLOW','LENGTHS','WORDS'],['ALLOW','LENGTHS','WORDS'],['ALLOW','LENGTHS','WORDS'],['LENGTHS','WORDS'],['ALLOW','LENGTHS','WORDS'],['ALLOW','LENGTHS','WORDS'],['ALLOW','LENGTHS','WORDS'],['WORDS'],['ALLOW','LENGTHS','WORDS'],['ALLOW','LENGTHS','WORDS'],['ALLOW','LENGTHS','WORDS'],['ALLOW','WORDS'],['ALLOW','LENGTHS','WORDS'],['ALLOW'],['ALLOW','LENGTHS','WORDS'],['ALLOW','LENGTHS','WORDS'],['ALLOW','LENGTHS','WORDS'],['ALLOW','LENGTHS','WORDS'],['ALLOW','WORDS'],['ALLOW','LENGTHS','WORDS'],['ALLOW','LENGTHS','WORDS'],['ALLOW','WORDS'],['LENGTHS','WORDS'],['ALLOW','WORDS'],['ALLOW','WORDS'],['ALLOW','WORDS'],['ALLOW','LENGTHS','WORDS'],['ALLOW','WORDS'],['ALLOW','LENGTHS','WORDS'],['ALLOW','LENGTHS','WORDS'],['WORDS'],['ALLOW','WORDS'],['WORDS'],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
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
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT39,Scrubs_Inql_Nfcra_Accurint;
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
    SELF.Val := (SALT39.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_orig_end_user_id,1,0)+ IF( SELF.Diff_orig_loginid,1,0)+ IF( SELF.Diff_orig_billing_code,1,0)+ IF( SELF.Diff_orig_transaction_id,1,0)+ IF( SELF.Diff_orig_transaction_type,1,0)+ IF( SELF.Diff_orig_neighbors,1,0)+ IF( SELF.Diff_orig_relatives,1,0)+ IF( SELF.Diff_orig_associates,1,0)+ IF( SELF.Diff_orig_property,1,0)+ IF( SELF.Diff_orig_company_id,1,0)+ IF( SELF.Diff_orig_reference_code,1,0)+ IF( SELF.Diff_orig_fname,1,0)+ IF( SELF.Diff_orig_mname,1,0)+ IF( SELF.Diff_orig_lname,1,0)+ IF( SELF.Diff_orig_address,1,0)+ IF( SELF.Diff_orig_city,1,0)+ IF( SELF.Diff_orig_state,1,0)+ IF( SELF.Diff_orig_zip,1,0)+ IF( SELF.Diff_orig_zip4,1,0)+ IF( SELF.Diff_orig_phone,1,0)+ IF( SELF.Diff_orig_ssn,1,0)+ IF( SELF.Diff_orig_free,1,0)+ IF( SELF.Diff_orig_record_count,1,0)+ IF( SELF.Diff_orig_price,1,0)+ IF( SELF.Diff_orig_bankruptcy,1,0)+ IF( SELF.Diff_orig_transaction_code,1,0)+ IF( SELF.Diff_orig_dateadded,1,0)+ IF( SELF.Diff_orig_full_name,1,0)+ IF( SELF.Diff_orig_billingdate,1,0)+ IF( SELF.Diff_orig_business_name,1,0)+ IF( SELF.Diff_orig_pricing_error_code,1,0)+ IF( SELF.Diff_orig_dl_purpose,1,0)+ IF( SELF.Diff_orig_result_format,1,0)+ IF( SELF.Diff_orig_dob,1,0)+ IF( SELF.Diff_orig_unique_id,1,0)+ IF( SELF.Diff_orig_dls,1,0)+ IF( SELF.Diff_orig_mvs,1,0)+ IF( SELF.Diff_orig_function_name,1,0)+ IF( SELF.Diff_orig_response_time,1,0)+ IF( SELF.Diff_orig_data_source,1,0)+ IF( SELF.Diff_orig_glb_purpose,1,0)+ IF( SELF.Diff_orig_report_options,1,0)+ IF( SELF.Diff_orig_unused,1,0)+ IF( SELF.Diff_orig_login_history_id,1,0)+ IF( SELF.Diff_orig_aseid,1,0)+ IF( SELF.Diff_orig_years,1,0)+ IF( SELF.Diff_orig_ip_address,1,0)+ IF( SELF.Diff_orig_source_code,1,0)+ IF( SELF.Diff_orig_retail_price,1,0);
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
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
