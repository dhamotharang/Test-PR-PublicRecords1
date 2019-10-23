IMPORT SALT39;
EXPORT Fields := MODULE
 
EXPORT NumFields := 64;
 
// Processing for each FieldType
EXPORT SALT39.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'DEFAULT','ALPHA','NAME','NUMBER','ALPHANUM','WORDBAG','orig_datetime_stamp','orig_global_company_id','orig_company_id','orig_product_cd','orig_method','orig_vertical','orig_function_name','orig_transaction_type','orig_login_history_id','orig_job_id','orig_sequence_number','orig_first_name','orig_middle_name','orig_last_name','orig_ssn','orig_dob','orig_dl_num','orig_dl_state','orig_address1_addressline1','orig_address1_addressline2','orig_address1_prim_range','orig_address1_predir','orig_address1_prim_name','orig_address1_suffix','orig_address1_postdir','orig_address1_unit_desig','orig_address1_sec_range','orig_address1_city','orig_address1_st','orig_address1_z5','orig_address1_z4','orig_address2_addressline1','orig_address2_addressline2','orig_address2_prim_range','orig_address2_predir','orig_address2_prim_name','orig_address2_suffix','orig_address2_postdir','orig_address2_unit_desig','orig_address2_sec_range','orig_address2_city','orig_address2_st','orig_address2_z5','orig_address2_z4','orig_bdid','orig_bdl','orig_did','orig_company_name','orig_fein','orig_phone','orig_work_phone','orig_company_phone','orig_reference_code','orig_ip_address_initiated','orig_ip_address_executed','orig_charter_number','orig_ucc_original_filing_number','orig_email_address','orig_domain_name','orig_full_name','orig_dl_purpose','orig_glb_purpose','orig_fcra_purpose','orig_process_id');
EXPORT FieldTypeNum(SALT39.StrType fn) := CASE(fn,'DEFAULT' => 1,'ALPHA' => 2,'NAME' => 3,'NUMBER' => 4,'ALPHANUM' => 5,'WORDBAG' => 6,'orig_datetime_stamp' => 7,'orig_global_company_id' => 8,'orig_company_id' => 9,'orig_product_cd' => 10,'orig_method' => 11,'orig_vertical' => 12,'orig_function_name' => 13,'orig_transaction_type' => 14,'orig_login_history_id' => 15,'orig_job_id' => 16,'orig_sequence_number' => 17,'orig_first_name' => 18,'orig_middle_name' => 19,'orig_last_name' => 20,'orig_ssn' => 21,'orig_dob' => 22,'orig_dl_num' => 23,'orig_dl_state' => 24,'orig_address1_addressline1' => 25,'orig_address1_addressline2' => 26,'orig_address1_prim_range' => 27,'orig_address1_predir' => 28,'orig_address1_prim_name' => 29,'orig_address1_suffix' => 30,'orig_address1_postdir' => 31,'orig_address1_unit_desig' => 32,'orig_address1_sec_range' => 33,'orig_address1_city' => 34,'orig_address1_st' => 35,'orig_address1_z5' => 36,'orig_address1_z4' => 37,'orig_address2_addressline1' => 38,'orig_address2_addressline2' => 39,'orig_address2_prim_range' => 40,'orig_address2_predir' => 41,'orig_address2_prim_name' => 42,'orig_address2_suffix' => 43,'orig_address2_postdir' => 44,'orig_address2_unit_desig' => 45,'orig_address2_sec_range' => 46,'orig_address2_city' => 47,'orig_address2_st' => 48,'orig_address2_z5' => 49,'orig_address2_z4' => 50,'orig_bdid' => 51,'orig_bdl' => 52,'orig_did' => 53,'orig_company_name' => 54,'orig_fein' => 55,'orig_phone' => 56,'orig_work_phone' => 57,'orig_company_phone' => 58,'orig_reference_code' => 59,'orig_ip_address_initiated' => 60,'orig_ip_address_executed' => 61,'orig_charter_number' => 62,'orig_ucc_original_filing_number' => 63,'orig_email_address' => 64,'orig_domain_name' => 65,'orig_full_name' => 66,'orig_dl_purpose' => 67,'orig_glb_purpose' => 68,'orig_fcra_purpose' => 69,'orig_process_id' => 70,0);
 
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
 
EXPORT MakeFT_orig_datetime_stamp(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  MakeFT_NUMBER(s3);
END;
EXPORT InValidFT_orig_datetime_stamp(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789 '))),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_datetime_stamp(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('0123456789 '),SALT39.HygieneErrors.NotWords('1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_global_company_id(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  MakeFT_NUMBER(s3);
END;
EXPORT InValidFT_orig_global_company_id(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789 '))),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_global_company_id(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('0123456789 '),SALT39.HygieneErrors.NotWords('1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_company_id(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  MakeFT_NUMBER(s3);
END;
EXPORT InValidFT_orig_company_id(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789 '))),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_company_id(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('0123456789 '),SALT39.HygieneErrors.NotWords('1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_product_cd(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'CDOPRTU_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_product_cd(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'CDOPRTU_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_product_cd(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('CDOPRTU_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_method(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'Bacht '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_method(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'Bacht '))),~(LENGTH(TRIM(s)) = 5),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_method(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('Bacht '),SALT39.HygieneErrors.NotLength('5'),SALT39.HygieneErrors.NotWords('1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_vertical(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ACEILRTV '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_vertical(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ACEILRTV '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_vertical(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('ACEILRTV '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_function_name(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  MakeFT_ALPHANUM(s3);
END;
EXPORT InValidFT_orig_function_name(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_ '))),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_function_name(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_ '),SALT39.HygieneErrors.NotWords('1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_transaction_type(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ACEINOPRSTY_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_transaction_type(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ACEINOPRSTY_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_transaction_type(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('ACEINOPRSTY_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_login_history_id(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'DGHILNORSTY_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_login_history_id(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'DGHILNORSTY_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_login_history_id(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('DGHILNORSTY_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_job_id(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  MakeFT_NUMBER(s3);
END;
EXPORT InValidFT_orig_job_id(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789 '))),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_job_id(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('0123456789 '),SALT39.HygieneErrors.NotWords('1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_sequence_number(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  MakeFT_NUMBER(s3);
END;
EXPORT InValidFT_orig_sequence_number(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789 '))),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_sequence_number(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('0123456789 '),SALT39.HygieneErrors.NotWords('1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_first_name(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz-,\'. '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_NAME(s2);
END;
EXPORT InValidFT_orig_first_name(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz-,\'. '))),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 2 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_first_name(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz-,\'. '),SALT39.HygieneErrors.NotWords('1,2,0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_middle_name(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz-,\'. '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_NAME(s2);
END;
EXPORT InValidFT_orig_middle_name(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz-,\'. '))),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 2));
EXPORT InValidMessageFT_orig_middle_name(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz-,\'. '),SALT39.HygieneErrors.NotWords('0,1,2'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_last_name(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz-,\'. '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_NAME(s2);
END;
EXPORT InValidFT_orig_last_name(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz-,\'. '))),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 2 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 3));
EXPORT InValidMessageFT_orig_last_name(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz-,\'. '),SALT39.HygieneErrors.NotWords('1,0,2,3'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_ssn(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  MakeFT_NUMBER(s3);
END;
EXPORT InValidFT_orig_ssn(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 9 OR LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_ssn(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('0123456789 '),SALT39.HygieneErrors.NotLength('9,0'),SALT39.HygieneErrors.NotWords('1,0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_dob(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789BO '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_dob(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789BO '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 8),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_dob(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('0123456789BO '),SALT39.HygieneErrors.NotLength('0,8'),SALT39.HygieneErrors.NotWords('0,1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_dl_num(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'DLMNU_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_dl_num(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'DLMNU_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_dl_num(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('DLMNU_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_dl_state(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ADELST_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_dl_state(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ADELST_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_dl_state(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('ADELST_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_address1_addressline1(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$; '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_WORDBAG(s2);
END;
EXPORT InValidFT_orig_address1_addressline1(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$; '))));
EXPORT InValidMessageFT_orig_address1_addressline1(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$; '),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_address1_addressline2(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$; '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  MakeFT_WORDBAG(s3);
END;
EXPORT InValidFT_orig_address1_addressline2(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$; '))));
EXPORT InValidMessageFT_orig_address1_addressline2(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$; '),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_address1_prim_range(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_ALPHANUM(s2);
END;
EXPORT InValidFT_orig_address1_prim_range(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_ '))),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_address1_prim_range(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_ '),SALT39.HygieneErrors.NotWords('1,0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_address1_predir(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'1DEINRSW_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_address1_predir(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'1DEINRSW_ '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 2),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_address1_predir(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('1DEINRSW_ '),SALT39.HygieneErrors.NotLength('0,1,2'),SALT39.HygieneErrors.NotWords('0,1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_address1_prim_name(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_ALPHANUM(s2);
END;
EXPORT InValidFT_orig_address1_prim_name(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_ '))));
EXPORT InValidMessageFT_orig_address1_prim_name(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_ '),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_address1_suffix(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_ALPHA(s2);
END;
EXPORT InValidFT_orig_address1_suffix(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '))),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_address1_suffix(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '),SALT39.HygieneErrors.NotWords('1,0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_address1_postdir(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  MakeFT_ALPHANUM(s3);
END;
EXPORT InValidFT_orig_address1_postdir(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_ '))),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_address1_postdir(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_ '),SALT39.HygieneErrors.NotWords('0,1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_address1_unit_desig(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  MakeFT_ALPHANUM(s3);
END;
EXPORT InValidFT_orig_address1_unit_desig(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_ '))),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_address1_unit_desig(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_ '),SALT39.HygieneErrors.NotWords('0,1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_address1_sec_range(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  MakeFT_ALPHANUM(s3);
END;
EXPORT InValidFT_orig_address1_sec_range(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_ '))),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_address1_sec_range(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_ '),SALT39.HygieneErrors.NotWords('0,1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_address1_city(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  MakeFT_ALPHA(s3);
END;
EXPORT InValidFT_orig_address1_city(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '))),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 2 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 3));
EXPORT InValidMessageFT_orig_address1_city(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '),SALT39.HygieneErrors.NotWords('1,2,0,3'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_address1_st(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  MakeFT_ALPHA(s3);
END;
EXPORT InValidFT_orig_address1_st(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '))),~(LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_address1_st(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '),SALT39.HygieneErrors.NotLength('2,0'),SALT39.HygieneErrors.NotWords('1,0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_address1_z5(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  MakeFT_NUMBER(s3);
END;
EXPORT InValidFT_orig_address1_z5(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_address1_z5(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('0123456789 '),SALT39.HygieneErrors.NotLength('5,0'),SALT39.HygieneErrors.NotWords('1,0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_address1_z4(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  MakeFT_NUMBER(s3);
END;
EXPORT InValidFT_orig_address1_z4(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_address1_z4(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('0123456789 '),SALT39.HygieneErrors.NotLength('4,0'),SALT39.HygieneErrors.NotWords('1,0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_address2_addressline1(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'12ADEILNRS_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_address2_addressline1(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'12ADEILNRS_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_address2_addressline1(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('12ADEILNRS_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_address2_addressline2(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'2ADEILNRS_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_address2_addressline2(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'2ADEILNRS_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_address2_addressline2(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('2ADEILNRS_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_address2_prim_range(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'2ADEGIMNPRS_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_address2_prim_range(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'2ADEGIMNPRS_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_address2_prim_range(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('2ADEGIMNPRS_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_address2_predir(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'2ADEIPRS_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_address2_predir(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'2ADEIPRS_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_address2_predir(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('2ADEIPRS_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_address2_prim_name(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'2ADEIMNPRS_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_address2_prim_name(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'2ADEIMNPRS_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_address2_prim_name(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('2ADEIMNPRS_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_address2_suffix(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'2ADEFIRSUX_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_address2_suffix(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'2ADEFIRSUX_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_address2_suffix(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('2ADEFIRSUX_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_address2_postdir(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'2ADEIOPRST_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_address2_postdir(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'2ADEIOPRST_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_address2_postdir(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('2ADEIOPRST_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_address2_unit_desig(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'2ADEGINRSTU_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_address2_unit_desig(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'2ADEGINRSTU_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_address2_unit_desig(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('2ADEGINRSTU_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_address2_sec_range(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'2ACDEGNRS_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_address2_sec_range(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'2ACDEGNRS_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_address2_sec_range(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('2ACDEGNRS_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_address2_city(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'2ACDEIRSTY_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_address2_city(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'2ACDEIRSTY_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_address2_city(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('2ACDEIRSTY_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_address2_st(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'2ADERST_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_address2_st(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'2ADERST_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_address2_st(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('2ADERST_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_address2_z5(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'25ADERSZ_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_address2_z5(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'25ADERSZ_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_address2_z5(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('25ADERSZ_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_address2_z4(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'24ADERSZ_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_address2_z4(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'24ADERSZ_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_address2_z4(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('24ADERSZ_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_bdid(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'04 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_bdid(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'04 '))),~(LENGTH(TRIM(s)) = 3 OR LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_bdid(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('04 '),SALT39.HygieneErrors.NotLength('3,0'),SALT39.HygieneErrors.NotWords('1,0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_bdl(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'BDL '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_bdl(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'BDL '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_bdl(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('BDL '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_did(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  MakeFT_NUMBER(s3);
END;
EXPORT InValidFT_orig_did(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 12 OR LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_did(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('0123456789 '),SALT39.HygieneErrors.NotLength('12,0'),SALT39.HygieneErrors.NotWords('1,0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_company_name(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz-,\'. '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  MakeFT_NAME(s3);
END;
EXPORT InValidFT_orig_company_name(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz-,\'. '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_company_name(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz-,\'. '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_fein(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  MakeFT_NUMBER(s3);
END;
EXPORT InValidFT_orig_fein(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 9 OR LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_fein(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('0123456789 '),SALT39.HygieneErrors.NotLength('9,0'),SALT39.HygieneErrors.NotWords('1,0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_phone(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789HNOP '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_phone(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789HNOP '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 10),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_phone(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('0123456789HNOP '),SALT39.HygieneErrors.NotLength('0,10'),SALT39.HygieneErrors.NotWords('0,1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_work_phone(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'EHKNOPRW_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_work_phone(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'EHKNOPRW_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_work_phone(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('EHKNOPRW_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_company_phone(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ACEHMNOPY_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_company_phone(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ACEHMNOPY_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_company_phone(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('ACEHMNOPY_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_reference_code(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'CDEFNOR_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_reference_code(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'CDEFNOR_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_reference_code(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('CDEFNOR_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_ip_address_initiated(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ADEINPRST_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_ip_address_initiated(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ADEINPRST_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_ip_address_initiated(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('ADEINPRST_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_ip_address_executed(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s0,' ',' ') ); // Insert spaces but avoid doubles
  s2 := TRIM(s1,LEFT); // Left trim
  RETURN  s2;
END;
EXPORT InValidFT_orig_ip_address_executed(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_ip_address_executed(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotWords('1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_charter_number(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ABCEHMNRTU_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_charter_number(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABCEHMNRTU_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_charter_number(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('ABCEHMNRTU_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_ucc_original_filing_number(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz-,\'. '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  MakeFT_NAME(s3);
END;
EXPORT InValidFT_orig_ucc_original_filing_number(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz-,\'. '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_ucc_original_filing_number(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz-,\'. '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_email_address(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ADEILMRS_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_email_address(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ADEILMRS_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_email_address(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('ADEILMRS_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_domain_name(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ADEIMNO_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_domain_name(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ADEIMNO_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_domain_name(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('ADEIMNO_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_full_name(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'AEFLMNU_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_full_name(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'AEFLMNU_ '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_orig_full_name(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('AEFLMNU_ '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_dl_purpose(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  MakeFT_NUMBER(s3);
END;
EXPORT InValidFT_orig_dl_purpose(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 1),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_dl_purpose(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('0123456789 '),SALT39.HygieneErrors.NotLength('1'),SALT39.HygieneErrors.NotWords('1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_glb_purpose(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  MakeFT_NUMBER(s3);
END;
EXPORT InValidFT_orig_glb_purpose(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 2),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_glb_purpose(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('0123456789 '),SALT39.HygieneErrors.NotLength('1,2'),SALT39.HygieneErrors.NotWords('1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_fcra_purpose(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'012R '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_fcra_purpose(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'012R '))),~(LENGTH(TRIM(s)) = 1),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_fcra_purpose(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('012R '),SALT39.HygieneErrors.NotLength('1'),SALT39.HygieneErrors.NotWords('1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_orig_process_id(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  MakeFT_NUMBER(s3);
END;
EXPORT InValidFT_orig_process_id(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789 '))),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_process_id(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('0123456789 '),SALT39.HygieneErrors.NotWords('1'),SALT39.HygieneErrors.Good);
 
EXPORT SALT39.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'orig_datetime_stamp','orig_global_company_id','orig_company_id','orig_product_cd','orig_method','orig_vertical','orig_function_name','orig_transaction_type','orig_login_history_id','orig_job_id','orig_sequence_number','orig_first_name','orig_middle_name','orig_last_name','orig_ssn','orig_dob','orig_dl_num','orig_dl_state','orig_address1_addressline1','orig_address1_addressline2','orig_address1_prim_range','orig_address1_predir','orig_address1_prim_name','orig_address1_suffix','orig_address1_postdir','orig_address1_unit_desig','orig_address1_sec_range','orig_address1_city','orig_address1_st','orig_address1_z5','orig_address1_z4','orig_address2_addressline1','orig_address2_addressline2','orig_address2_prim_range','orig_address2_predir','orig_address2_prim_name','orig_address2_suffix','orig_address2_postdir','orig_address2_unit_desig','orig_address2_sec_range','orig_address2_city','orig_address2_st','orig_address2_z5','orig_address2_z4','orig_bdid','orig_bdl','orig_did','orig_company_name','orig_fein','orig_phone','orig_work_phone','orig_company_phone','orig_reference_code','orig_ip_address_initiated','orig_ip_address_executed','orig_charter_number','orig_ucc_original_filing_number','orig_email_address','orig_domain_name','orig_full_name','orig_dl_purpose','orig_glb_purpose','orig_fcra_purpose','orig_process_id');
EXPORT SALT39.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'orig_datetime_stamp','orig_global_company_id','orig_company_id','orig_product_cd','orig_method','orig_vertical','orig_function_name','orig_transaction_type','orig_login_history_id','orig_job_id','orig_sequence_number','orig_first_name','orig_middle_name','orig_last_name','orig_ssn','orig_dob','orig_dl_num','orig_dl_state','orig_address1_addressline1','orig_address1_addressline2','orig_address1_prim_range','orig_address1_predir','orig_address1_prim_name','orig_address1_suffix','orig_address1_postdir','orig_address1_unit_desig','orig_address1_sec_range','orig_address1_city','orig_address1_st','orig_address1_z5','orig_address1_z4','orig_address2_addressline1','orig_address2_addressline2','orig_address2_prim_range','orig_address2_predir','orig_address2_prim_name','orig_address2_suffix','orig_address2_postdir','orig_address2_unit_desig','orig_address2_sec_range','orig_address2_city','orig_address2_st','orig_address2_z5','orig_address2_z4','orig_bdid','orig_bdl','orig_did','orig_company_name','orig_fein','orig_phone','orig_work_phone','orig_company_phone','orig_reference_code','orig_ip_address_initiated','orig_ip_address_executed','orig_charter_number','orig_ucc_original_filing_number','orig_email_address','orig_domain_name','orig_full_name','orig_dl_purpose','orig_glb_purpose','orig_fcra_purpose','orig_process_id');
EXPORT FieldNum(SALT39.StrType fn) := CASE(fn,'orig_datetime_stamp' => 0,'orig_global_company_id' => 1,'orig_company_id' => 2,'orig_product_cd' => 3,'orig_method' => 4,'orig_vertical' => 5,'orig_function_name' => 6,'orig_transaction_type' => 7,'orig_login_history_id' => 8,'orig_job_id' => 9,'orig_sequence_number' => 10,'orig_first_name' => 11,'orig_middle_name' => 12,'orig_last_name' => 13,'orig_ssn' => 14,'orig_dob' => 15,'orig_dl_num' => 16,'orig_dl_state' => 17,'orig_address1_addressline1' => 18,'orig_address1_addressline2' => 19,'orig_address1_prim_range' => 20,'orig_address1_predir' => 21,'orig_address1_prim_name' => 22,'orig_address1_suffix' => 23,'orig_address1_postdir' => 24,'orig_address1_unit_desig' => 25,'orig_address1_sec_range' => 26,'orig_address1_city' => 27,'orig_address1_st' => 28,'orig_address1_z5' => 29,'orig_address1_z4' => 30,'orig_address2_addressline1' => 31,'orig_address2_addressline2' => 32,'orig_address2_prim_range' => 33,'orig_address2_predir' => 34,'orig_address2_prim_name' => 35,'orig_address2_suffix' => 36,'orig_address2_postdir' => 37,'orig_address2_unit_desig' => 38,'orig_address2_sec_range' => 39,'orig_address2_city' => 40,'orig_address2_st' => 41,'orig_address2_z5' => 42,'orig_address2_z4' => 43,'orig_bdid' => 44,'orig_bdl' => 45,'orig_did' => 46,'orig_company_name' => 47,'orig_fein' => 48,'orig_phone' => 49,'orig_work_phone' => 50,'orig_company_phone' => 51,'orig_reference_code' => 52,'orig_ip_address_initiated' => 53,'orig_ip_address_executed' => 54,'orig_charter_number' => 55,'orig_ucc_original_filing_number' => 56,'orig_email_address' => 57,'orig_domain_name' => 58,'orig_full_name' => 59,'orig_dl_purpose' => 60,'orig_glb_purpose' => 61,'orig_fcra_purpose' => 62,'orig_process_id' => 63,0);
EXPORT SET OF SALT39.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['LEFTTRIM','ALLOW','WORDS'],['LEFTTRIM','ALLOW','WORDS'],['LEFTTRIM','ALLOW','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','WORDS'],['LEFTTRIM','ALLOW','WORDS'],['ALLOW','WORDS'],['ALLOW','WORDS'],['ALLOW','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['ALLOW'],['LEFTTRIM','ALLOW'],['ALLOW','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['ALLOW'],['ALLOW','WORDS'],['LEFTTRIM','ALLOW','WORDS'],['LEFTTRIM','ALLOW','WORDS'],['LEFTTRIM','ALLOW','WORDS'],['LEFTTRIM','ALLOW','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','WORDS'],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_orig_datetime_stamp(SALT39.StrType s0) := MakeFT_orig_datetime_stamp(s0);
EXPORT InValid_orig_datetime_stamp(SALT39.StrType s) := InValidFT_orig_datetime_stamp(s);
EXPORT InValidMessage_orig_datetime_stamp(UNSIGNED1 wh) := InValidMessageFT_orig_datetime_stamp(wh);
 
EXPORT Make_orig_global_company_id(SALT39.StrType s0) := MakeFT_orig_global_company_id(s0);
EXPORT InValid_orig_global_company_id(SALT39.StrType s) := InValidFT_orig_global_company_id(s);
EXPORT InValidMessage_orig_global_company_id(UNSIGNED1 wh) := InValidMessageFT_orig_global_company_id(wh);
 
EXPORT Make_orig_company_id(SALT39.StrType s0) := MakeFT_orig_company_id(s0);
EXPORT InValid_orig_company_id(SALT39.StrType s) := InValidFT_orig_company_id(s);
EXPORT InValidMessage_orig_company_id(UNSIGNED1 wh) := InValidMessageFT_orig_company_id(wh);
 
EXPORT Make_orig_product_cd(SALT39.StrType s0) := MakeFT_orig_product_cd(s0);
EXPORT InValid_orig_product_cd(SALT39.StrType s) := InValidFT_orig_product_cd(s);
EXPORT InValidMessage_orig_product_cd(UNSIGNED1 wh) := InValidMessageFT_orig_product_cd(wh);
 
EXPORT Make_orig_method(SALT39.StrType s0) := MakeFT_orig_method(s0);
EXPORT InValid_orig_method(SALT39.StrType s) := InValidFT_orig_method(s);
EXPORT InValidMessage_orig_method(UNSIGNED1 wh) := InValidMessageFT_orig_method(wh);
 
EXPORT Make_orig_vertical(SALT39.StrType s0) := MakeFT_orig_vertical(s0);
EXPORT InValid_orig_vertical(SALT39.StrType s) := InValidFT_orig_vertical(s);
EXPORT InValidMessage_orig_vertical(UNSIGNED1 wh) := InValidMessageFT_orig_vertical(wh);
 
EXPORT Make_orig_function_name(SALT39.StrType s0) := MakeFT_orig_function_name(s0);
EXPORT InValid_orig_function_name(SALT39.StrType s) := InValidFT_orig_function_name(s);
EXPORT InValidMessage_orig_function_name(UNSIGNED1 wh) := InValidMessageFT_orig_function_name(wh);
 
EXPORT Make_orig_transaction_type(SALT39.StrType s0) := MakeFT_orig_transaction_type(s0);
EXPORT InValid_orig_transaction_type(SALT39.StrType s) := InValidFT_orig_transaction_type(s);
EXPORT InValidMessage_orig_transaction_type(UNSIGNED1 wh) := InValidMessageFT_orig_transaction_type(wh);
 
EXPORT Make_orig_login_history_id(SALT39.StrType s0) := MakeFT_orig_login_history_id(s0);
EXPORT InValid_orig_login_history_id(SALT39.StrType s) := InValidFT_orig_login_history_id(s);
EXPORT InValidMessage_orig_login_history_id(UNSIGNED1 wh) := InValidMessageFT_orig_login_history_id(wh);
 
EXPORT Make_orig_job_id(SALT39.StrType s0) := MakeFT_orig_job_id(s0);
EXPORT InValid_orig_job_id(SALT39.StrType s) := InValidFT_orig_job_id(s);
EXPORT InValidMessage_orig_job_id(UNSIGNED1 wh) := InValidMessageFT_orig_job_id(wh);
 
EXPORT Make_orig_sequence_number(SALT39.StrType s0) := MakeFT_orig_sequence_number(s0);
EXPORT InValid_orig_sequence_number(SALT39.StrType s) := InValidFT_orig_sequence_number(s);
EXPORT InValidMessage_orig_sequence_number(UNSIGNED1 wh) := InValidMessageFT_orig_sequence_number(wh);
 
EXPORT Make_orig_first_name(SALT39.StrType s0) := MakeFT_orig_first_name(s0);
EXPORT InValid_orig_first_name(SALT39.StrType s) := InValidFT_orig_first_name(s);
EXPORT InValidMessage_orig_first_name(UNSIGNED1 wh) := InValidMessageFT_orig_first_name(wh);
 
EXPORT Make_orig_middle_name(SALT39.StrType s0) := MakeFT_orig_middle_name(s0);
EXPORT InValid_orig_middle_name(SALT39.StrType s) := InValidFT_orig_middle_name(s);
EXPORT InValidMessage_orig_middle_name(UNSIGNED1 wh) := InValidMessageFT_orig_middle_name(wh);
 
EXPORT Make_orig_last_name(SALT39.StrType s0) := MakeFT_orig_last_name(s0);
EXPORT InValid_orig_last_name(SALT39.StrType s) := InValidFT_orig_last_name(s);
EXPORT InValidMessage_orig_last_name(UNSIGNED1 wh) := InValidMessageFT_orig_last_name(wh);
 
EXPORT Make_orig_ssn(SALT39.StrType s0) := MakeFT_orig_ssn(s0);
EXPORT InValid_orig_ssn(SALT39.StrType s) := InValidFT_orig_ssn(s);
EXPORT InValidMessage_orig_ssn(UNSIGNED1 wh) := InValidMessageFT_orig_ssn(wh);
 
EXPORT Make_orig_dob(SALT39.StrType s0) := MakeFT_orig_dob(s0);
EXPORT InValid_orig_dob(SALT39.StrType s) := InValidFT_orig_dob(s);
EXPORT InValidMessage_orig_dob(UNSIGNED1 wh) := InValidMessageFT_orig_dob(wh);
 
EXPORT Make_orig_dl_num(SALT39.StrType s0) := MakeFT_orig_dl_num(s0);
EXPORT InValid_orig_dl_num(SALT39.StrType s) := InValidFT_orig_dl_num(s);
EXPORT InValidMessage_orig_dl_num(UNSIGNED1 wh) := InValidMessageFT_orig_dl_num(wh);
 
EXPORT Make_orig_dl_state(SALT39.StrType s0) := MakeFT_orig_dl_state(s0);
EXPORT InValid_orig_dl_state(SALT39.StrType s) := InValidFT_orig_dl_state(s);
EXPORT InValidMessage_orig_dl_state(UNSIGNED1 wh) := InValidMessageFT_orig_dl_state(wh);
 
EXPORT Make_orig_address1_addressline1(SALT39.StrType s0) := MakeFT_orig_address1_addressline1(s0);
EXPORT InValid_orig_address1_addressline1(SALT39.StrType s) := InValidFT_orig_address1_addressline1(s);
EXPORT InValidMessage_orig_address1_addressline1(UNSIGNED1 wh) := InValidMessageFT_orig_address1_addressline1(wh);
 
EXPORT Make_orig_address1_addressline2(SALT39.StrType s0) := MakeFT_orig_address1_addressline2(s0);
EXPORT InValid_orig_address1_addressline2(SALT39.StrType s) := InValidFT_orig_address1_addressline2(s);
EXPORT InValidMessage_orig_address1_addressline2(UNSIGNED1 wh) := InValidMessageFT_orig_address1_addressline2(wh);
 
EXPORT Make_orig_address1_prim_range(SALT39.StrType s0) := MakeFT_orig_address1_prim_range(s0);
EXPORT InValid_orig_address1_prim_range(SALT39.StrType s) := InValidFT_orig_address1_prim_range(s);
EXPORT InValidMessage_orig_address1_prim_range(UNSIGNED1 wh) := InValidMessageFT_orig_address1_prim_range(wh);
 
EXPORT Make_orig_address1_predir(SALT39.StrType s0) := MakeFT_orig_address1_predir(s0);
EXPORT InValid_orig_address1_predir(SALT39.StrType s) := InValidFT_orig_address1_predir(s);
EXPORT InValidMessage_orig_address1_predir(UNSIGNED1 wh) := InValidMessageFT_orig_address1_predir(wh);
 
EXPORT Make_orig_address1_prim_name(SALT39.StrType s0) := MakeFT_orig_address1_prim_name(s0);
EXPORT InValid_orig_address1_prim_name(SALT39.StrType s) := InValidFT_orig_address1_prim_name(s);
EXPORT InValidMessage_orig_address1_prim_name(UNSIGNED1 wh) := InValidMessageFT_orig_address1_prim_name(wh);
 
EXPORT Make_orig_address1_suffix(SALT39.StrType s0) := MakeFT_orig_address1_suffix(s0);
EXPORT InValid_orig_address1_suffix(SALT39.StrType s) := InValidFT_orig_address1_suffix(s);
EXPORT InValidMessage_orig_address1_suffix(UNSIGNED1 wh) := InValidMessageFT_orig_address1_suffix(wh);
 
EXPORT Make_orig_address1_postdir(SALT39.StrType s0) := MakeFT_orig_address1_postdir(s0);
EXPORT InValid_orig_address1_postdir(SALT39.StrType s) := InValidFT_orig_address1_postdir(s);
EXPORT InValidMessage_orig_address1_postdir(UNSIGNED1 wh) := InValidMessageFT_orig_address1_postdir(wh);
 
EXPORT Make_orig_address1_unit_desig(SALT39.StrType s0) := MakeFT_orig_address1_unit_desig(s0);
EXPORT InValid_orig_address1_unit_desig(SALT39.StrType s) := InValidFT_orig_address1_unit_desig(s);
EXPORT InValidMessage_orig_address1_unit_desig(UNSIGNED1 wh) := InValidMessageFT_orig_address1_unit_desig(wh);
 
EXPORT Make_orig_address1_sec_range(SALT39.StrType s0) := MakeFT_orig_address1_sec_range(s0);
EXPORT InValid_orig_address1_sec_range(SALT39.StrType s) := InValidFT_orig_address1_sec_range(s);
EXPORT InValidMessage_orig_address1_sec_range(UNSIGNED1 wh) := InValidMessageFT_orig_address1_sec_range(wh);
 
EXPORT Make_orig_address1_city(SALT39.StrType s0) := MakeFT_orig_address1_city(s0);
EXPORT InValid_orig_address1_city(SALT39.StrType s) := InValidFT_orig_address1_city(s);
EXPORT InValidMessage_orig_address1_city(UNSIGNED1 wh) := InValidMessageFT_orig_address1_city(wh);
 
EXPORT Make_orig_address1_st(SALT39.StrType s0) := MakeFT_orig_address1_st(s0);
EXPORT InValid_orig_address1_st(SALT39.StrType s) := InValidFT_orig_address1_st(s);
EXPORT InValidMessage_orig_address1_st(UNSIGNED1 wh) := InValidMessageFT_orig_address1_st(wh);
 
EXPORT Make_orig_address1_z5(SALT39.StrType s0) := MakeFT_orig_address1_z5(s0);
EXPORT InValid_orig_address1_z5(SALT39.StrType s) := InValidFT_orig_address1_z5(s);
EXPORT InValidMessage_orig_address1_z5(UNSIGNED1 wh) := InValidMessageFT_orig_address1_z5(wh);
 
EXPORT Make_orig_address1_z4(SALT39.StrType s0) := MakeFT_orig_address1_z4(s0);
EXPORT InValid_orig_address1_z4(SALT39.StrType s) := InValidFT_orig_address1_z4(s);
EXPORT InValidMessage_orig_address1_z4(UNSIGNED1 wh) := InValidMessageFT_orig_address1_z4(wh);
 
EXPORT Make_orig_address2_addressline1(SALT39.StrType s0) := MakeFT_orig_address2_addressline1(s0);
EXPORT InValid_orig_address2_addressline1(SALT39.StrType s) := InValidFT_orig_address2_addressline1(s);
EXPORT InValidMessage_orig_address2_addressline1(UNSIGNED1 wh) := InValidMessageFT_orig_address2_addressline1(wh);
 
EXPORT Make_orig_address2_addressline2(SALT39.StrType s0) := MakeFT_orig_address2_addressline2(s0);
EXPORT InValid_orig_address2_addressline2(SALT39.StrType s) := InValidFT_orig_address2_addressline2(s);
EXPORT InValidMessage_orig_address2_addressline2(UNSIGNED1 wh) := InValidMessageFT_orig_address2_addressline2(wh);
 
EXPORT Make_orig_address2_prim_range(SALT39.StrType s0) := MakeFT_orig_address2_prim_range(s0);
EXPORT InValid_orig_address2_prim_range(SALT39.StrType s) := InValidFT_orig_address2_prim_range(s);
EXPORT InValidMessage_orig_address2_prim_range(UNSIGNED1 wh) := InValidMessageFT_orig_address2_prim_range(wh);
 
EXPORT Make_orig_address2_predir(SALT39.StrType s0) := MakeFT_orig_address2_predir(s0);
EXPORT InValid_orig_address2_predir(SALT39.StrType s) := InValidFT_orig_address2_predir(s);
EXPORT InValidMessage_orig_address2_predir(UNSIGNED1 wh) := InValidMessageFT_orig_address2_predir(wh);
 
EXPORT Make_orig_address2_prim_name(SALT39.StrType s0) := MakeFT_orig_address2_prim_name(s0);
EXPORT InValid_orig_address2_prim_name(SALT39.StrType s) := InValidFT_orig_address2_prim_name(s);
EXPORT InValidMessage_orig_address2_prim_name(UNSIGNED1 wh) := InValidMessageFT_orig_address2_prim_name(wh);
 
EXPORT Make_orig_address2_suffix(SALT39.StrType s0) := MakeFT_orig_address2_suffix(s0);
EXPORT InValid_orig_address2_suffix(SALT39.StrType s) := InValidFT_orig_address2_suffix(s);
EXPORT InValidMessage_orig_address2_suffix(UNSIGNED1 wh) := InValidMessageFT_orig_address2_suffix(wh);
 
EXPORT Make_orig_address2_postdir(SALT39.StrType s0) := MakeFT_orig_address2_postdir(s0);
EXPORT InValid_orig_address2_postdir(SALT39.StrType s) := InValidFT_orig_address2_postdir(s);
EXPORT InValidMessage_orig_address2_postdir(UNSIGNED1 wh) := InValidMessageFT_orig_address2_postdir(wh);
 
EXPORT Make_orig_address2_unit_desig(SALT39.StrType s0) := MakeFT_orig_address2_unit_desig(s0);
EXPORT InValid_orig_address2_unit_desig(SALT39.StrType s) := InValidFT_orig_address2_unit_desig(s);
EXPORT InValidMessage_orig_address2_unit_desig(UNSIGNED1 wh) := InValidMessageFT_orig_address2_unit_desig(wh);
 
EXPORT Make_orig_address2_sec_range(SALT39.StrType s0) := MakeFT_orig_address2_sec_range(s0);
EXPORT InValid_orig_address2_sec_range(SALT39.StrType s) := InValidFT_orig_address2_sec_range(s);
EXPORT InValidMessage_orig_address2_sec_range(UNSIGNED1 wh) := InValidMessageFT_orig_address2_sec_range(wh);
 
EXPORT Make_orig_address2_city(SALT39.StrType s0) := MakeFT_orig_address2_city(s0);
EXPORT InValid_orig_address2_city(SALT39.StrType s) := InValidFT_orig_address2_city(s);
EXPORT InValidMessage_orig_address2_city(UNSIGNED1 wh) := InValidMessageFT_orig_address2_city(wh);
 
EXPORT Make_orig_address2_st(SALT39.StrType s0) := MakeFT_orig_address2_st(s0);
EXPORT InValid_orig_address2_st(SALT39.StrType s) := InValidFT_orig_address2_st(s);
EXPORT InValidMessage_orig_address2_st(UNSIGNED1 wh) := InValidMessageFT_orig_address2_st(wh);
 
EXPORT Make_orig_address2_z5(SALT39.StrType s0) := MakeFT_orig_address2_z5(s0);
EXPORT InValid_orig_address2_z5(SALT39.StrType s) := InValidFT_orig_address2_z5(s);
EXPORT InValidMessage_orig_address2_z5(UNSIGNED1 wh) := InValidMessageFT_orig_address2_z5(wh);
 
EXPORT Make_orig_address2_z4(SALT39.StrType s0) := MakeFT_orig_address2_z4(s0);
EXPORT InValid_orig_address2_z4(SALT39.StrType s) := InValidFT_orig_address2_z4(s);
EXPORT InValidMessage_orig_address2_z4(UNSIGNED1 wh) := InValidMessageFT_orig_address2_z4(wh);
 
EXPORT Make_orig_bdid(SALT39.StrType s0) := MakeFT_orig_bdid(s0);
EXPORT InValid_orig_bdid(SALT39.StrType s) := InValidFT_orig_bdid(s);
EXPORT InValidMessage_orig_bdid(UNSIGNED1 wh) := InValidMessageFT_orig_bdid(wh);
 
EXPORT Make_orig_bdl(SALT39.StrType s0) := MakeFT_orig_bdl(s0);
EXPORT InValid_orig_bdl(SALT39.StrType s) := InValidFT_orig_bdl(s);
EXPORT InValidMessage_orig_bdl(UNSIGNED1 wh) := InValidMessageFT_orig_bdl(wh);
 
EXPORT Make_orig_did(SALT39.StrType s0) := MakeFT_orig_did(s0);
EXPORT InValid_orig_did(SALT39.StrType s) := InValidFT_orig_did(s);
EXPORT InValidMessage_orig_did(UNSIGNED1 wh) := InValidMessageFT_orig_did(wh);
 
EXPORT Make_orig_company_name(SALT39.StrType s0) := MakeFT_orig_company_name(s0);
EXPORT InValid_orig_company_name(SALT39.StrType s) := InValidFT_orig_company_name(s);
EXPORT InValidMessage_orig_company_name(UNSIGNED1 wh) := InValidMessageFT_orig_company_name(wh);
 
EXPORT Make_orig_fein(SALT39.StrType s0) := MakeFT_orig_fein(s0);
EXPORT InValid_orig_fein(SALT39.StrType s) := InValidFT_orig_fein(s);
EXPORT InValidMessage_orig_fein(UNSIGNED1 wh) := InValidMessageFT_orig_fein(wh);
 
EXPORT Make_orig_phone(SALT39.StrType s0) := MakeFT_orig_phone(s0);
EXPORT InValid_orig_phone(SALT39.StrType s) := InValidFT_orig_phone(s);
EXPORT InValidMessage_orig_phone(UNSIGNED1 wh) := InValidMessageFT_orig_phone(wh);
 
EXPORT Make_orig_work_phone(SALT39.StrType s0) := MakeFT_orig_work_phone(s0);
EXPORT InValid_orig_work_phone(SALT39.StrType s) := InValidFT_orig_work_phone(s);
EXPORT InValidMessage_orig_work_phone(UNSIGNED1 wh) := InValidMessageFT_orig_work_phone(wh);
 
EXPORT Make_orig_company_phone(SALT39.StrType s0) := MakeFT_orig_company_phone(s0);
EXPORT InValid_orig_company_phone(SALT39.StrType s) := InValidFT_orig_company_phone(s);
EXPORT InValidMessage_orig_company_phone(UNSIGNED1 wh) := InValidMessageFT_orig_company_phone(wh);
 
EXPORT Make_orig_reference_code(SALT39.StrType s0) := MakeFT_orig_reference_code(s0);
EXPORT InValid_orig_reference_code(SALT39.StrType s) := InValidFT_orig_reference_code(s);
EXPORT InValidMessage_orig_reference_code(UNSIGNED1 wh) := InValidMessageFT_orig_reference_code(wh);
 
EXPORT Make_orig_ip_address_initiated(SALT39.StrType s0) := MakeFT_orig_ip_address_initiated(s0);
EXPORT InValid_orig_ip_address_initiated(SALT39.StrType s) := InValidFT_orig_ip_address_initiated(s);
EXPORT InValidMessage_orig_ip_address_initiated(UNSIGNED1 wh) := InValidMessageFT_orig_ip_address_initiated(wh);
 
EXPORT Make_orig_ip_address_executed(SALT39.StrType s0) := MakeFT_orig_ip_address_executed(s0);
EXPORT InValid_orig_ip_address_executed(SALT39.StrType s) := InValidFT_orig_ip_address_executed(s);
EXPORT InValidMessage_orig_ip_address_executed(UNSIGNED1 wh) := InValidMessageFT_orig_ip_address_executed(wh);
 
EXPORT Make_orig_charter_number(SALT39.StrType s0) := MakeFT_orig_charter_number(s0);
EXPORT InValid_orig_charter_number(SALT39.StrType s) := InValidFT_orig_charter_number(s);
EXPORT InValidMessage_orig_charter_number(UNSIGNED1 wh) := InValidMessageFT_orig_charter_number(wh);
 
EXPORT Make_orig_ucc_original_filing_number(SALT39.StrType s0) := MakeFT_orig_ucc_original_filing_number(s0);
EXPORT InValid_orig_ucc_original_filing_number(SALT39.StrType s) := InValidFT_orig_ucc_original_filing_number(s);
EXPORT InValidMessage_orig_ucc_original_filing_number(UNSIGNED1 wh) := InValidMessageFT_orig_ucc_original_filing_number(wh);
 
EXPORT Make_orig_email_address(SALT39.StrType s0) := MakeFT_orig_email_address(s0);
EXPORT InValid_orig_email_address(SALT39.StrType s) := InValidFT_orig_email_address(s);
EXPORT InValidMessage_orig_email_address(UNSIGNED1 wh) := InValidMessageFT_orig_email_address(wh);
 
EXPORT Make_orig_domain_name(SALT39.StrType s0) := MakeFT_orig_domain_name(s0);
EXPORT InValid_orig_domain_name(SALT39.StrType s) := InValidFT_orig_domain_name(s);
EXPORT InValidMessage_orig_domain_name(UNSIGNED1 wh) := InValidMessageFT_orig_domain_name(wh);
 
EXPORT Make_orig_full_name(SALT39.StrType s0) := MakeFT_orig_full_name(s0);
EXPORT InValid_orig_full_name(SALT39.StrType s) := InValidFT_orig_full_name(s);
EXPORT InValidMessage_orig_full_name(UNSIGNED1 wh) := InValidMessageFT_orig_full_name(wh);
 
EXPORT Make_orig_dl_purpose(SALT39.StrType s0) := MakeFT_orig_dl_purpose(s0);
EXPORT InValid_orig_dl_purpose(SALT39.StrType s) := InValidFT_orig_dl_purpose(s);
EXPORT InValidMessage_orig_dl_purpose(UNSIGNED1 wh) := InValidMessageFT_orig_dl_purpose(wh);
 
EXPORT Make_orig_glb_purpose(SALT39.StrType s0) := MakeFT_orig_glb_purpose(s0);
EXPORT InValid_orig_glb_purpose(SALT39.StrType s) := InValidFT_orig_glb_purpose(s);
EXPORT InValidMessage_orig_glb_purpose(UNSIGNED1 wh) := InValidMessageFT_orig_glb_purpose(wh);
 
EXPORT Make_orig_fcra_purpose(SALT39.StrType s0) := MakeFT_orig_fcra_purpose(s0);
EXPORT InValid_orig_fcra_purpose(SALT39.StrType s) := InValidFT_orig_fcra_purpose(s);
EXPORT InValidMessage_orig_fcra_purpose(UNSIGNED1 wh) := InValidMessageFT_orig_fcra_purpose(wh);
 
EXPORT Make_orig_process_id(SALT39.StrType s0) := MakeFT_orig_process_id(s0);
EXPORT InValid_orig_process_id(SALT39.StrType s) := InValidFT_orig_process_id(s);
EXPORT InValidMessage_orig_process_id(UNSIGNED1 wh) := InValidMessageFT_orig_process_id(wh);
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT39,Scrubs_Inql_fcra_Batch;
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
    BOOLEAN Diff_orig_datetime_stamp;
    BOOLEAN Diff_orig_global_company_id;
    BOOLEAN Diff_orig_company_id;
    BOOLEAN Diff_orig_product_cd;
    BOOLEAN Diff_orig_method;
    BOOLEAN Diff_orig_vertical;
    BOOLEAN Diff_orig_function_name;
    BOOLEAN Diff_orig_transaction_type;
    BOOLEAN Diff_orig_login_history_id;
    BOOLEAN Diff_orig_job_id;
    BOOLEAN Diff_orig_sequence_number;
    BOOLEAN Diff_orig_first_name;
    BOOLEAN Diff_orig_middle_name;
    BOOLEAN Diff_orig_last_name;
    BOOLEAN Diff_orig_ssn;
    BOOLEAN Diff_orig_dob;
    BOOLEAN Diff_orig_dl_num;
    BOOLEAN Diff_orig_dl_state;
    BOOLEAN Diff_orig_address1_addressline1;
    BOOLEAN Diff_orig_address1_addressline2;
    BOOLEAN Diff_orig_address1_prim_range;
    BOOLEAN Diff_orig_address1_predir;
    BOOLEAN Diff_orig_address1_prim_name;
    BOOLEAN Diff_orig_address1_suffix;
    BOOLEAN Diff_orig_address1_postdir;
    BOOLEAN Diff_orig_address1_unit_desig;
    BOOLEAN Diff_orig_address1_sec_range;
    BOOLEAN Diff_orig_address1_city;
    BOOLEAN Diff_orig_address1_st;
    BOOLEAN Diff_orig_address1_z5;
    BOOLEAN Diff_orig_address1_z4;
    BOOLEAN Diff_orig_address2_addressline1;
    BOOLEAN Diff_orig_address2_addressline2;
    BOOLEAN Diff_orig_address2_prim_range;
    BOOLEAN Diff_orig_address2_predir;
    BOOLEAN Diff_orig_address2_prim_name;
    BOOLEAN Diff_orig_address2_suffix;
    BOOLEAN Diff_orig_address2_postdir;
    BOOLEAN Diff_orig_address2_unit_desig;
    BOOLEAN Diff_orig_address2_sec_range;
    BOOLEAN Diff_orig_address2_city;
    BOOLEAN Diff_orig_address2_st;
    BOOLEAN Diff_orig_address2_z5;
    BOOLEAN Diff_orig_address2_z4;
    BOOLEAN Diff_orig_bdid;
    BOOLEAN Diff_orig_bdl;
    BOOLEAN Diff_orig_did;
    BOOLEAN Diff_orig_company_name;
    BOOLEAN Diff_orig_fein;
    BOOLEAN Diff_orig_phone;
    BOOLEAN Diff_orig_work_phone;
    BOOLEAN Diff_orig_company_phone;
    BOOLEAN Diff_orig_reference_code;
    BOOLEAN Diff_orig_ip_address_initiated;
    BOOLEAN Diff_orig_ip_address_executed;
    BOOLEAN Diff_orig_charter_number;
    BOOLEAN Diff_orig_ucc_original_filing_number;
    BOOLEAN Diff_orig_email_address;
    BOOLEAN Diff_orig_domain_name;
    BOOLEAN Diff_orig_full_name;
    BOOLEAN Diff_orig_dl_purpose;
    BOOLEAN Diff_orig_glb_purpose;
    BOOLEAN Diff_orig_fcra_purpose;
    BOOLEAN Diff_orig_process_id;
    UNSIGNED Num_Diffs;
    SALT39.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_orig_datetime_stamp := le.orig_datetime_stamp <> ri.orig_datetime_stamp;
    SELF.Diff_orig_global_company_id := le.orig_global_company_id <> ri.orig_global_company_id;
    SELF.Diff_orig_company_id := le.orig_company_id <> ri.orig_company_id;
    SELF.Diff_orig_product_cd := le.orig_product_cd <> ri.orig_product_cd;
    SELF.Diff_orig_method := le.orig_method <> ri.orig_method;
    SELF.Diff_orig_vertical := le.orig_vertical <> ri.orig_vertical;
    SELF.Diff_orig_function_name := le.orig_function_name <> ri.orig_function_name;
    SELF.Diff_orig_transaction_type := le.orig_transaction_type <> ri.orig_transaction_type;
    SELF.Diff_orig_login_history_id := le.orig_login_history_id <> ri.orig_login_history_id;
    SELF.Diff_orig_job_id := le.orig_job_id <> ri.orig_job_id;
    SELF.Diff_orig_sequence_number := le.orig_sequence_number <> ri.orig_sequence_number;
    SELF.Diff_orig_first_name := le.orig_first_name <> ri.orig_first_name;
    SELF.Diff_orig_middle_name := le.orig_middle_name <> ri.orig_middle_name;
    SELF.Diff_orig_last_name := le.orig_last_name <> ri.orig_last_name;
    SELF.Diff_orig_ssn := le.orig_ssn <> ri.orig_ssn;
    SELF.Diff_orig_dob := le.orig_dob <> ri.orig_dob;
    SELF.Diff_orig_dl_num := le.orig_dl_num <> ri.orig_dl_num;
    SELF.Diff_orig_dl_state := le.orig_dl_state <> ri.orig_dl_state;
    SELF.Diff_orig_address1_addressline1 := le.orig_address1_addressline1 <> ri.orig_address1_addressline1;
    SELF.Diff_orig_address1_addressline2 := le.orig_address1_addressline2 <> ri.orig_address1_addressline2;
    SELF.Diff_orig_address1_prim_range := le.orig_address1_prim_range <> ri.orig_address1_prim_range;
    SELF.Diff_orig_address1_predir := le.orig_address1_predir <> ri.orig_address1_predir;
    SELF.Diff_orig_address1_prim_name := le.orig_address1_prim_name <> ri.orig_address1_prim_name;
    SELF.Diff_orig_address1_suffix := le.orig_address1_suffix <> ri.orig_address1_suffix;
    SELF.Diff_orig_address1_postdir := le.orig_address1_postdir <> ri.orig_address1_postdir;
    SELF.Diff_orig_address1_unit_desig := le.orig_address1_unit_desig <> ri.orig_address1_unit_desig;
    SELF.Diff_orig_address1_sec_range := le.orig_address1_sec_range <> ri.orig_address1_sec_range;
    SELF.Diff_orig_address1_city := le.orig_address1_city <> ri.orig_address1_city;
    SELF.Diff_orig_address1_st := le.orig_address1_st <> ri.orig_address1_st;
    SELF.Diff_orig_address1_z5 := le.orig_address1_z5 <> ri.orig_address1_z5;
    SELF.Diff_orig_address1_z4 := le.orig_address1_z4 <> ri.orig_address1_z4;
    SELF.Diff_orig_address2_addressline1 := le.orig_address2_addressline1 <> ri.orig_address2_addressline1;
    SELF.Diff_orig_address2_addressline2 := le.orig_address2_addressline2 <> ri.orig_address2_addressline2;
    SELF.Diff_orig_address2_prim_range := le.orig_address2_prim_range <> ri.orig_address2_prim_range;
    SELF.Diff_orig_address2_predir := le.orig_address2_predir <> ri.orig_address2_predir;
    SELF.Diff_orig_address2_prim_name := le.orig_address2_prim_name <> ri.orig_address2_prim_name;
    SELF.Diff_orig_address2_suffix := le.orig_address2_suffix <> ri.orig_address2_suffix;
    SELF.Diff_orig_address2_postdir := le.orig_address2_postdir <> ri.orig_address2_postdir;
    SELF.Diff_orig_address2_unit_desig := le.orig_address2_unit_desig <> ri.orig_address2_unit_desig;
    SELF.Diff_orig_address2_sec_range := le.orig_address2_sec_range <> ri.orig_address2_sec_range;
    SELF.Diff_orig_address2_city := le.orig_address2_city <> ri.orig_address2_city;
    SELF.Diff_orig_address2_st := le.orig_address2_st <> ri.orig_address2_st;
    SELF.Diff_orig_address2_z5 := le.orig_address2_z5 <> ri.orig_address2_z5;
    SELF.Diff_orig_address2_z4 := le.orig_address2_z4 <> ri.orig_address2_z4;
    SELF.Diff_orig_bdid := le.orig_bdid <> ri.orig_bdid;
    SELF.Diff_orig_bdl := le.orig_bdl <> ri.orig_bdl;
    SELF.Diff_orig_did := le.orig_did <> ri.orig_did;
    SELF.Diff_orig_company_name := le.orig_company_name <> ri.orig_company_name;
    SELF.Diff_orig_fein := le.orig_fein <> ri.orig_fein;
    SELF.Diff_orig_phone := le.orig_phone <> ri.orig_phone;
    SELF.Diff_orig_work_phone := le.orig_work_phone <> ri.orig_work_phone;
    SELF.Diff_orig_company_phone := le.orig_company_phone <> ri.orig_company_phone;
    SELF.Diff_orig_reference_code := le.orig_reference_code <> ri.orig_reference_code;
    SELF.Diff_orig_ip_address_initiated := le.orig_ip_address_initiated <> ri.orig_ip_address_initiated;
    SELF.Diff_orig_ip_address_executed := le.orig_ip_address_executed <> ri.orig_ip_address_executed;
    SELF.Diff_orig_charter_number := le.orig_charter_number <> ri.orig_charter_number;
    SELF.Diff_orig_ucc_original_filing_number := le.orig_ucc_original_filing_number <> ri.orig_ucc_original_filing_number;
    SELF.Diff_orig_email_address := le.orig_email_address <> ri.orig_email_address;
    SELF.Diff_orig_domain_name := le.orig_domain_name <> ri.orig_domain_name;
    SELF.Diff_orig_full_name := le.orig_full_name <> ri.orig_full_name;
    SELF.Diff_orig_dl_purpose := le.orig_dl_purpose <> ri.orig_dl_purpose;
    SELF.Diff_orig_glb_purpose := le.orig_glb_purpose <> ri.orig_glb_purpose;
    SELF.Diff_orig_fcra_purpose := le.orig_fcra_purpose <> ri.orig_fcra_purpose;
    SELF.Diff_orig_process_id := le.orig_process_id <> ri.orig_process_id;
    SELF.Val := (SALT39.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_orig_datetime_stamp,1,0)+ IF( SELF.Diff_orig_global_company_id,1,0)+ IF( SELF.Diff_orig_company_id,1,0)+ IF( SELF.Diff_orig_product_cd,1,0)+ IF( SELF.Diff_orig_method,1,0)+ IF( SELF.Diff_orig_vertical,1,0)+ IF( SELF.Diff_orig_function_name,1,0)+ IF( SELF.Diff_orig_transaction_type,1,0)+ IF( SELF.Diff_orig_login_history_id,1,0)+ IF( SELF.Diff_orig_job_id,1,0)+ IF( SELF.Diff_orig_sequence_number,1,0)+ IF( SELF.Diff_orig_first_name,1,0)+ IF( SELF.Diff_orig_middle_name,1,0)+ IF( SELF.Diff_orig_last_name,1,0)+ IF( SELF.Diff_orig_ssn,1,0)+ IF( SELF.Diff_orig_dob,1,0)+ IF( SELF.Diff_orig_dl_num,1,0)+ IF( SELF.Diff_orig_dl_state,1,0)+ IF( SELF.Diff_orig_address1_addressline1,1,0)+ IF( SELF.Diff_orig_address1_addressline2,1,0)+ IF( SELF.Diff_orig_address1_prim_range,1,0)+ IF( SELF.Diff_orig_address1_predir,1,0)+ IF( SELF.Diff_orig_address1_prim_name,1,0)+ IF( SELF.Diff_orig_address1_suffix,1,0)+ IF( SELF.Diff_orig_address1_postdir,1,0)+ IF( SELF.Diff_orig_address1_unit_desig,1,0)+ IF( SELF.Diff_orig_address1_sec_range,1,0)+ IF( SELF.Diff_orig_address1_city,1,0)+ IF( SELF.Diff_orig_address1_st,1,0)+ IF( SELF.Diff_orig_address1_z5,1,0)+ IF( SELF.Diff_orig_address1_z4,1,0)+ IF( SELF.Diff_orig_address2_addressline1,1,0)+ IF( SELF.Diff_orig_address2_addressline2,1,0)+ IF( SELF.Diff_orig_address2_prim_range,1,0)+ IF( SELF.Diff_orig_address2_predir,1,0)+ IF( SELF.Diff_orig_address2_prim_name,1,0)+ IF( SELF.Diff_orig_address2_suffix,1,0)+ IF( SELF.Diff_orig_address2_postdir,1,0)+ IF( SELF.Diff_orig_address2_unit_desig,1,0)+ IF( SELF.Diff_orig_address2_sec_range,1,0)+ IF( SELF.Diff_orig_address2_city,1,0)+ IF( SELF.Diff_orig_address2_st,1,0)+ IF( SELF.Diff_orig_address2_z5,1,0)+ IF( SELF.Diff_orig_address2_z4,1,0)+ IF( SELF.Diff_orig_bdid,1,0)+ IF( SELF.Diff_orig_bdl,1,0)+ IF( SELF.Diff_orig_did,1,0)+ IF( SELF.Diff_orig_company_name,1,0)+ IF( SELF.Diff_orig_fein,1,0)+ IF( SELF.Diff_orig_phone,1,0)+ IF( SELF.Diff_orig_work_phone,1,0)+ IF( SELF.Diff_orig_company_phone,1,0)+ IF( SELF.Diff_orig_reference_code,1,0)+ IF( SELF.Diff_orig_ip_address_initiated,1,0)+ IF( SELF.Diff_orig_ip_address_executed,1,0)+ IF( SELF.Diff_orig_charter_number,1,0)+ IF( SELF.Diff_orig_ucc_original_filing_number,1,0)+ IF( SELF.Diff_orig_email_address,1,0)+ IF( SELF.Diff_orig_domain_name,1,0)+ IF( SELF.Diff_orig_full_name,1,0)+ IF( SELF.Diff_orig_dl_purpose,1,0)+ IF( SELF.Diff_orig_glb_purpose,1,0)+ IF( SELF.Diff_orig_fcra_purpose,1,0)+ IF( SELF.Diff_orig_process_id,1,0);
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
    Count_Diff_orig_datetime_stamp := COUNT(GROUP,%Closest%.Diff_orig_datetime_stamp);
    Count_Diff_orig_global_company_id := COUNT(GROUP,%Closest%.Diff_orig_global_company_id);
    Count_Diff_orig_company_id := COUNT(GROUP,%Closest%.Diff_orig_company_id);
    Count_Diff_orig_product_cd := COUNT(GROUP,%Closest%.Diff_orig_product_cd);
    Count_Diff_orig_method := COUNT(GROUP,%Closest%.Diff_orig_method);
    Count_Diff_orig_vertical := COUNT(GROUP,%Closest%.Diff_orig_vertical);
    Count_Diff_orig_function_name := COUNT(GROUP,%Closest%.Diff_orig_function_name);
    Count_Diff_orig_transaction_type := COUNT(GROUP,%Closest%.Diff_orig_transaction_type);
    Count_Diff_orig_login_history_id := COUNT(GROUP,%Closest%.Diff_orig_login_history_id);
    Count_Diff_orig_job_id := COUNT(GROUP,%Closest%.Diff_orig_job_id);
    Count_Diff_orig_sequence_number := COUNT(GROUP,%Closest%.Diff_orig_sequence_number);
    Count_Diff_orig_first_name := COUNT(GROUP,%Closest%.Diff_orig_first_name);
    Count_Diff_orig_middle_name := COUNT(GROUP,%Closest%.Diff_orig_middle_name);
    Count_Diff_orig_last_name := COUNT(GROUP,%Closest%.Diff_orig_last_name);
    Count_Diff_orig_ssn := COUNT(GROUP,%Closest%.Diff_orig_ssn);
    Count_Diff_orig_dob := COUNT(GROUP,%Closest%.Diff_orig_dob);
    Count_Diff_orig_dl_num := COUNT(GROUP,%Closest%.Diff_orig_dl_num);
    Count_Diff_orig_dl_state := COUNT(GROUP,%Closest%.Diff_orig_dl_state);
    Count_Diff_orig_address1_addressline1 := COUNT(GROUP,%Closest%.Diff_orig_address1_addressline1);
    Count_Diff_orig_address1_addressline2 := COUNT(GROUP,%Closest%.Diff_orig_address1_addressline2);
    Count_Diff_orig_address1_prim_range := COUNT(GROUP,%Closest%.Diff_orig_address1_prim_range);
    Count_Diff_orig_address1_predir := COUNT(GROUP,%Closest%.Diff_orig_address1_predir);
    Count_Diff_orig_address1_prim_name := COUNT(GROUP,%Closest%.Diff_orig_address1_prim_name);
    Count_Diff_orig_address1_suffix := COUNT(GROUP,%Closest%.Diff_orig_address1_suffix);
    Count_Diff_orig_address1_postdir := COUNT(GROUP,%Closest%.Diff_orig_address1_postdir);
    Count_Diff_orig_address1_unit_desig := COUNT(GROUP,%Closest%.Diff_orig_address1_unit_desig);
    Count_Diff_orig_address1_sec_range := COUNT(GROUP,%Closest%.Diff_orig_address1_sec_range);
    Count_Diff_orig_address1_city := COUNT(GROUP,%Closest%.Diff_orig_address1_city);
    Count_Diff_orig_address1_st := COUNT(GROUP,%Closest%.Diff_orig_address1_st);
    Count_Diff_orig_address1_z5 := COUNT(GROUP,%Closest%.Diff_orig_address1_z5);
    Count_Diff_orig_address1_z4 := COUNT(GROUP,%Closest%.Diff_orig_address1_z4);
    Count_Diff_orig_address2_addressline1 := COUNT(GROUP,%Closest%.Diff_orig_address2_addressline1);
    Count_Diff_orig_address2_addressline2 := COUNT(GROUP,%Closest%.Diff_orig_address2_addressline2);
    Count_Diff_orig_address2_prim_range := COUNT(GROUP,%Closest%.Diff_orig_address2_prim_range);
    Count_Diff_orig_address2_predir := COUNT(GROUP,%Closest%.Diff_orig_address2_predir);
    Count_Diff_orig_address2_prim_name := COUNT(GROUP,%Closest%.Diff_orig_address2_prim_name);
    Count_Diff_orig_address2_suffix := COUNT(GROUP,%Closest%.Diff_orig_address2_suffix);
    Count_Diff_orig_address2_postdir := COUNT(GROUP,%Closest%.Diff_orig_address2_postdir);
    Count_Diff_orig_address2_unit_desig := COUNT(GROUP,%Closest%.Diff_orig_address2_unit_desig);
    Count_Diff_orig_address2_sec_range := COUNT(GROUP,%Closest%.Diff_orig_address2_sec_range);
    Count_Diff_orig_address2_city := COUNT(GROUP,%Closest%.Diff_orig_address2_city);
    Count_Diff_orig_address2_st := COUNT(GROUP,%Closest%.Diff_orig_address2_st);
    Count_Diff_orig_address2_z5 := COUNT(GROUP,%Closest%.Diff_orig_address2_z5);
    Count_Diff_orig_address2_z4 := COUNT(GROUP,%Closest%.Diff_orig_address2_z4);
    Count_Diff_orig_bdid := COUNT(GROUP,%Closest%.Diff_orig_bdid);
    Count_Diff_orig_bdl := COUNT(GROUP,%Closest%.Diff_orig_bdl);
    Count_Diff_orig_did := COUNT(GROUP,%Closest%.Diff_orig_did);
    Count_Diff_orig_company_name := COUNT(GROUP,%Closest%.Diff_orig_company_name);
    Count_Diff_orig_fein := COUNT(GROUP,%Closest%.Diff_orig_fein);
    Count_Diff_orig_phone := COUNT(GROUP,%Closest%.Diff_orig_phone);
    Count_Diff_orig_work_phone := COUNT(GROUP,%Closest%.Diff_orig_work_phone);
    Count_Diff_orig_company_phone := COUNT(GROUP,%Closest%.Diff_orig_company_phone);
    Count_Diff_orig_reference_code := COUNT(GROUP,%Closest%.Diff_orig_reference_code);
    Count_Diff_orig_ip_address_initiated := COUNT(GROUP,%Closest%.Diff_orig_ip_address_initiated);
    Count_Diff_orig_ip_address_executed := COUNT(GROUP,%Closest%.Diff_orig_ip_address_executed);
    Count_Diff_orig_charter_number := COUNT(GROUP,%Closest%.Diff_orig_charter_number);
    Count_Diff_orig_ucc_original_filing_number := COUNT(GROUP,%Closest%.Diff_orig_ucc_original_filing_number);
    Count_Diff_orig_email_address := COUNT(GROUP,%Closest%.Diff_orig_email_address);
    Count_Diff_orig_domain_name := COUNT(GROUP,%Closest%.Diff_orig_domain_name);
    Count_Diff_orig_full_name := COUNT(GROUP,%Closest%.Diff_orig_full_name);
    Count_Diff_orig_dl_purpose := COUNT(GROUP,%Closest%.Diff_orig_dl_purpose);
    Count_Diff_orig_glb_purpose := COUNT(GROUP,%Closest%.Diff_orig_glb_purpose);
    Count_Diff_orig_fcra_purpose := COUNT(GROUP,%Closest%.Diff_orig_fcra_purpose);
    Count_Diff_orig_process_id := COUNT(GROUP,%Closest%.Diff_orig_process_id);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
