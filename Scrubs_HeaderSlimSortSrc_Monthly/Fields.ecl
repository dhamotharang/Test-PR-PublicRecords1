IMPORT SALT39;
EXPORT Fields := MODULE
 
EXPORT NumFields := 22;
 
// Processing for each FieldType
EXPORT SALT39.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'Invalid_AlphaNum','Invalid_Alpha','Invalid_Num','src','did','fname','lname','prim_range','prim_name','zip','mname','sec_range','name_suffix','ssn','dob','dids_with_this_nm_addr','suffix_cnt_with_this_nm_addr','sec_range_cnt_with_this_nm_addr','ssn_cnt_with_this_nm_addr','dob_cnt_with_this_nm_addr','mname_cnt_with_this_nm_addr','dids_with_this_nm_ssn','dob_cnt_with_this_nm_ssn','dids_with_this_nm_dob','zip_cnt_with_this_nm_dob');
EXPORT FieldTypeNum(SALT39.StrType fn) := CASE(fn,'Invalid_AlphaNum' => 1,'Invalid_Alpha' => 2,'Invalid_Num' => 3,'src' => 4,'did' => 5,'fname' => 6,'lname' => 7,'prim_range' => 8,'prim_name' => 9,'zip' => 10,'mname' => 11,'sec_range' => 12,'name_suffix' => 13,'ssn' => 14,'dob' => 15,'dids_with_this_nm_addr' => 16,'suffix_cnt_with_this_nm_addr' => 17,'sec_range_cnt_with_this_nm_addr' => 18,'ssn_cnt_with_this_nm_addr' => 19,'dob_cnt_with_this_nm_addr' => 20,'mname_cnt_with_this_nm_addr' => 21,'dids_with_this_nm_ssn' => 22,'dob_cnt_with_this_nm_ssn' => 23,'dids_with_this_nm_dob' => 24,'zip_cnt_with_this_nm_dob' => 25,0);
 
EXPORT MakeFT_Invalid_AlphaNum(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789ABCDEFGHIJKLMNOPRSTUVWXYZ'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_AlphaNum(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789ABCDEFGHIJKLMNOPRSTUVWXYZ'))));
EXPORT InValidMessageFT_Invalid_AlphaNum(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('0123456789ABCDEFGHIJKLMNOPRSTUVWXYZ'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Alpha(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Alpha(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'))));
EXPORT InValidMessageFT_Invalid_Alpha(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Num(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Num(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_Invalid_Num(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('0123456789'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_src(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789ABCDEFGHIJKLMNOPRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_Invalid_AlphaNum(s2);
END;
EXPORT InValidFT_src(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789ABCDEFGHIJKLMNOPRSTUVWXYZ '))),~(LENGTH(TRIM(s)) = 2),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_src(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('0123456789ABCDEFGHIJKLMNOPRSTUVWXYZ '),SALT39.HygieneErrors.NotLength('2'),SALT39.HygieneErrors.NotWords('1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_did(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_Invalid_Num(s2);
END;
EXPORT InValidFT_did(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789 '))),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_did(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('0123456789 '),SALT39.HygieneErrors.NotWords('1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_fname(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_Invalid_Alpha(s2);
END;
EXPORT InValidFT_fname(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ '))));
EXPORT InValidMessageFT_fname(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_lname(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_Invalid_Alpha(s2);
END;
EXPORT InValidFT_lname(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ '))));
EXPORT InValidMessageFT_lname(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_prim_range(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'-/0123456789ABNW '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_prim_range(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'-/0123456789ABNW '))));
EXPORT InValidMessageFT_prim_range(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('-/0123456789ABNW '),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_prim_name(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789ABCDEFGHIJKLMNOPRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_Invalid_AlphaNum(s2);
END;
EXPORT InValidFT_prim_name(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789ABCDEFGHIJKLMNOPRSTUVWXYZ '))));
EXPORT InValidMessageFT_prim_name(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('0123456789ABCDEFGHIJKLMNOPRSTUVWXYZ '),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_zip(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_Invalid_Num(s2);
END;
EXPORT InValidFT_zip(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_zip(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('0123456789 '),SALT39.HygieneErrors.NotLength('5,0'),SALT39.HygieneErrors.NotWords('1,0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_mname(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_Invalid_Alpha(s2);
END;
EXPORT InValidFT_mname(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ '))));
EXPORT InValidMessageFT_mname(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_sec_range(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'-0123456789ABCDEFGHIJKLMNOPQRSTUVW '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_sec_range(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'-0123456789ABCDEFGHIJKLMNOPQRSTUVW '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 3 OR LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 6),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_sec_range(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('-0123456789ABCDEFGHIJKLMNOPQRSTUVW '),SALT39.HygieneErrors.NotLength('0,3,1,2,4,5,6'),SALT39.HygieneErrors.NotWords('0,1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_name_suffix(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'12345JRS '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_name_suffix(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'12345JRS '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 1),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_name_suffix(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('12345JRS '),SALT39.HygieneErrors.NotLength('0,2,1'),SALT39.HygieneErrors.NotWords('0,1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_ssn(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_Invalid_Num(s2);
END;
EXPORT InValidFT_ssn(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789 '))));
EXPORT InValidMessageFT_ssn(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('0123456789 '),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_dob(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_Invalid_Num(s2);
END;
EXPORT InValidFT_dob(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789 '))));
EXPORT InValidMessageFT_dob(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('0123456789 '),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_dids_with_this_nm_addr(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'123 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_dids_with_this_nm_addr(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'123 '))),~(LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_dids_with_this_nm_addr(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('123 '),SALT39.HygieneErrors.NotLength('1,0'),SALT39.HygieneErrors.NotWords('1,0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_suffix_cnt_with_this_nm_addr(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'123 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_suffix_cnt_with_this_nm_addr(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'123 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 1),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_suffix_cnt_with_this_nm_addr(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('123 '),SALT39.HygieneErrors.NotLength('0,1'),SALT39.HygieneErrors.NotWords('0,1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_sec_range_cnt_with_this_nm_addr(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'12345 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_sec_range_cnt_with_this_nm_addr(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'12345 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 1),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_sec_range_cnt_with_this_nm_addr(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('12345 '),SALT39.HygieneErrors.NotLength('0,1'),SALT39.HygieneErrors.NotWords('0,1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_ssn_cnt_with_this_nm_addr(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'123 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_ssn_cnt_with_this_nm_addr(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'123 '))),~(LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_ssn_cnt_with_this_nm_addr(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('123 '),SALT39.HygieneErrors.NotLength('1,0'),SALT39.HygieneErrors.NotWords('1,0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_dob_cnt_with_this_nm_addr(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'1234 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_dob_cnt_with_this_nm_addr(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'1234 '))),~(LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_dob_cnt_with_this_nm_addr(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('1234 '),SALT39.HygieneErrors.NotLength('1,0'),SALT39.HygieneErrors.NotWords('1,0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_mname_cnt_with_this_nm_addr(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'123 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_mname_cnt_with_this_nm_addr(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'123 '))),~(LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_mname_cnt_with_this_nm_addr(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('123 '),SALT39.HygieneErrors.NotLength('1,0'),SALT39.HygieneErrors.NotWords('1,0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_dids_with_this_nm_ssn(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'1 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_dids_with_this_nm_ssn(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'1 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 1),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_dids_with_this_nm_ssn(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('1 '),SALT39.HygieneErrors.NotLength('0,1'),SALT39.HygieneErrors.NotWords('0,1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_dob_cnt_with_this_nm_ssn(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'12 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_dob_cnt_with_this_nm_ssn(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'12 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 1),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_dob_cnt_with_this_nm_ssn(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('12 '),SALT39.HygieneErrors.NotLength('0,1'),SALT39.HygieneErrors.NotWords('0,1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_dids_with_this_nm_dob(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'123 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_dids_with_this_nm_dob(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'123 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 1),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_dids_with_this_nm_dob(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('123 '),SALT39.HygieneErrors.NotLength('0,1'),SALT39.HygieneErrors.NotWords('0,1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_zip_cnt_with_this_nm_dob(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'123 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_zip_cnt_with_this_nm_dob(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'123 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 1),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_zip_cnt_with_this_nm_dob(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('123 '),SALT39.HygieneErrors.NotLength('0,1'),SALT39.HygieneErrors.NotWords('0,1'),SALT39.HygieneErrors.Good);
 
EXPORT SALT39.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'src','did','fname','lname','prim_range','prim_name','zip','mname','sec_range','name_suffix','ssn','dob','dids_with_this_nm_addr','suffix_cnt_with_this_nm_addr','sec_range_cnt_with_this_nm_addr','ssn_cnt_with_this_nm_addr','dob_cnt_with_this_nm_addr','mname_cnt_with_this_nm_addr','dids_with_this_nm_ssn','dob_cnt_with_this_nm_ssn','dids_with_this_nm_dob','zip_cnt_with_this_nm_dob');
EXPORT SALT39.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'src','did','fname','lname','prim_range','prim_name','zip','mname','sec_range','name_suffix','ssn','dob','dids_with_this_nm_addr','suffix_cnt_with_this_nm_addr','sec_range_cnt_with_this_nm_addr','ssn_cnt_with_this_nm_addr','dob_cnt_with_this_nm_addr','mname_cnt_with_this_nm_addr','dids_with_this_nm_ssn','dob_cnt_with_this_nm_ssn','dids_with_this_nm_dob','zip_cnt_with_this_nm_dob');
EXPORT FieldNum(SALT39.StrType fn) := CASE(fn,'src' => 0,'did' => 1,'fname' => 2,'lname' => 3,'prim_range' => 4,'prim_name' => 5,'zip' => 6,'mname' => 7,'sec_range' => 8,'name_suffix' => 9,'ssn' => 10,'dob' => 11,'dids_with_this_nm_addr' => 12,'suffix_cnt_with_this_nm_addr' => 13,'sec_range_cnt_with_this_nm_addr' => 14,'ssn_cnt_with_this_nm_addr' => 15,'dob_cnt_with_this_nm_addr' => 16,'mname_cnt_with_this_nm_addr' => 17,'dids_with_this_nm_ssn' => 18,'dob_cnt_with_this_nm_ssn' => 19,'dids_with_this_nm_dob' => 20,'zip_cnt_with_this_nm_dob' => 21,0);
EXPORT SET OF SALT39.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['ALLOW','LENGTHS','WORDS'],['ALLOW','WORDS'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW','LENGTHS','WORDS'],['ALLOW'],['ALLOW','LENGTHS','WORDS'],['ALLOW','LENGTHS','WORDS'],['ALLOW'],['ALLOW'],['ALLOW','LENGTHS','WORDS'],['ALLOW','LENGTHS','WORDS'],['ALLOW','LENGTHS','WORDS'],['ALLOW','LENGTHS','WORDS'],['ALLOW','LENGTHS','WORDS'],['ALLOW','LENGTHS','WORDS'],['ALLOW','LENGTHS','WORDS'],['ALLOW','LENGTHS','WORDS'],['ALLOW','LENGTHS','WORDS'],['ALLOW','LENGTHS','WORDS'],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_src(SALT39.StrType s0) := MakeFT_src(s0);
EXPORT InValid_src(SALT39.StrType s) := InValidFT_src(s);
EXPORT InValidMessage_src(UNSIGNED1 wh) := InValidMessageFT_src(wh);
 
EXPORT Make_did(SALT39.StrType s0) := MakeFT_did(s0);
EXPORT InValid_did(SALT39.StrType s) := InValidFT_did(s);
EXPORT InValidMessage_did(UNSIGNED1 wh) := InValidMessageFT_did(wh);
 
EXPORT Make_fname(SALT39.StrType s0) := MakeFT_fname(s0);
EXPORT InValid_fname(SALT39.StrType s) := InValidFT_fname(s);
EXPORT InValidMessage_fname(UNSIGNED1 wh) := InValidMessageFT_fname(wh);
 
EXPORT Make_lname(SALT39.StrType s0) := MakeFT_lname(s0);
EXPORT InValid_lname(SALT39.StrType s) := InValidFT_lname(s);
EXPORT InValidMessage_lname(UNSIGNED1 wh) := InValidMessageFT_lname(wh);
 
EXPORT Make_prim_range(SALT39.StrType s0) := MakeFT_prim_range(s0);
EXPORT InValid_prim_range(SALT39.StrType s) := InValidFT_prim_range(s);
EXPORT InValidMessage_prim_range(UNSIGNED1 wh) := InValidMessageFT_prim_range(wh);
 
EXPORT Make_prim_name(SALT39.StrType s0) := MakeFT_prim_name(s0);
EXPORT InValid_prim_name(SALT39.StrType s) := InValidFT_prim_name(s);
EXPORT InValidMessage_prim_name(UNSIGNED1 wh) := InValidMessageFT_prim_name(wh);
 
EXPORT Make_zip(SALT39.StrType s0) := MakeFT_zip(s0);
EXPORT InValid_zip(SALT39.StrType s) := InValidFT_zip(s);
EXPORT InValidMessage_zip(UNSIGNED1 wh) := InValidMessageFT_zip(wh);
 
EXPORT Make_mname(SALT39.StrType s0) := MakeFT_mname(s0);
EXPORT InValid_mname(SALT39.StrType s) := InValidFT_mname(s);
EXPORT InValidMessage_mname(UNSIGNED1 wh) := InValidMessageFT_mname(wh);
 
EXPORT Make_sec_range(SALT39.StrType s0) := MakeFT_sec_range(s0);
EXPORT InValid_sec_range(SALT39.StrType s) := InValidFT_sec_range(s);
EXPORT InValidMessage_sec_range(UNSIGNED1 wh) := InValidMessageFT_sec_range(wh);
 
EXPORT Make_name_suffix(SALT39.StrType s0) := MakeFT_name_suffix(s0);
EXPORT InValid_name_suffix(SALT39.StrType s) := InValidFT_name_suffix(s);
EXPORT InValidMessage_name_suffix(UNSIGNED1 wh) := InValidMessageFT_name_suffix(wh);
 
EXPORT Make_ssn(SALT39.StrType s0) := MakeFT_ssn(s0);
EXPORT InValid_ssn(SALT39.StrType s) := InValidFT_ssn(s);
EXPORT InValidMessage_ssn(UNSIGNED1 wh) := InValidMessageFT_ssn(wh);
 
EXPORT Make_dob(SALT39.StrType s0) := MakeFT_dob(s0);
EXPORT InValid_dob(SALT39.StrType s) := InValidFT_dob(s);
EXPORT InValidMessage_dob(UNSIGNED1 wh) := InValidMessageFT_dob(wh);
 
EXPORT Make_dids_with_this_nm_addr(SALT39.StrType s0) := MakeFT_dids_with_this_nm_addr(s0);
EXPORT InValid_dids_with_this_nm_addr(SALT39.StrType s) := InValidFT_dids_with_this_nm_addr(s);
EXPORT InValidMessage_dids_with_this_nm_addr(UNSIGNED1 wh) := InValidMessageFT_dids_with_this_nm_addr(wh);
 
EXPORT Make_suffix_cnt_with_this_nm_addr(SALT39.StrType s0) := MakeFT_suffix_cnt_with_this_nm_addr(s0);
EXPORT InValid_suffix_cnt_with_this_nm_addr(SALT39.StrType s) := InValidFT_suffix_cnt_with_this_nm_addr(s);
EXPORT InValidMessage_suffix_cnt_with_this_nm_addr(UNSIGNED1 wh) := InValidMessageFT_suffix_cnt_with_this_nm_addr(wh);
 
EXPORT Make_sec_range_cnt_with_this_nm_addr(SALT39.StrType s0) := MakeFT_sec_range_cnt_with_this_nm_addr(s0);
EXPORT InValid_sec_range_cnt_with_this_nm_addr(SALT39.StrType s) := InValidFT_sec_range_cnt_with_this_nm_addr(s);
EXPORT InValidMessage_sec_range_cnt_with_this_nm_addr(UNSIGNED1 wh) := InValidMessageFT_sec_range_cnt_with_this_nm_addr(wh);
 
EXPORT Make_ssn_cnt_with_this_nm_addr(SALT39.StrType s0) := MakeFT_ssn_cnt_with_this_nm_addr(s0);
EXPORT InValid_ssn_cnt_with_this_nm_addr(SALT39.StrType s) := InValidFT_ssn_cnt_with_this_nm_addr(s);
EXPORT InValidMessage_ssn_cnt_with_this_nm_addr(UNSIGNED1 wh) := InValidMessageFT_ssn_cnt_with_this_nm_addr(wh);
 
EXPORT Make_dob_cnt_with_this_nm_addr(SALT39.StrType s0) := MakeFT_dob_cnt_with_this_nm_addr(s0);
EXPORT InValid_dob_cnt_with_this_nm_addr(SALT39.StrType s) := InValidFT_dob_cnt_with_this_nm_addr(s);
EXPORT InValidMessage_dob_cnt_with_this_nm_addr(UNSIGNED1 wh) := InValidMessageFT_dob_cnt_with_this_nm_addr(wh);
 
EXPORT Make_mname_cnt_with_this_nm_addr(SALT39.StrType s0) := MakeFT_mname_cnt_with_this_nm_addr(s0);
EXPORT InValid_mname_cnt_with_this_nm_addr(SALT39.StrType s) := InValidFT_mname_cnt_with_this_nm_addr(s);
EXPORT InValidMessage_mname_cnt_with_this_nm_addr(UNSIGNED1 wh) := InValidMessageFT_mname_cnt_with_this_nm_addr(wh);
 
EXPORT Make_dids_with_this_nm_ssn(SALT39.StrType s0) := MakeFT_dids_with_this_nm_ssn(s0);
EXPORT InValid_dids_with_this_nm_ssn(SALT39.StrType s) := InValidFT_dids_with_this_nm_ssn(s);
EXPORT InValidMessage_dids_with_this_nm_ssn(UNSIGNED1 wh) := InValidMessageFT_dids_with_this_nm_ssn(wh);
 
EXPORT Make_dob_cnt_with_this_nm_ssn(SALT39.StrType s0) := MakeFT_dob_cnt_with_this_nm_ssn(s0);
EXPORT InValid_dob_cnt_with_this_nm_ssn(SALT39.StrType s) := InValidFT_dob_cnt_with_this_nm_ssn(s);
EXPORT InValidMessage_dob_cnt_with_this_nm_ssn(UNSIGNED1 wh) := InValidMessageFT_dob_cnt_with_this_nm_ssn(wh);
 
EXPORT Make_dids_with_this_nm_dob(SALT39.StrType s0) := MakeFT_dids_with_this_nm_dob(s0);
EXPORT InValid_dids_with_this_nm_dob(SALT39.StrType s) := InValidFT_dids_with_this_nm_dob(s);
EXPORT InValidMessage_dids_with_this_nm_dob(UNSIGNED1 wh) := InValidMessageFT_dids_with_this_nm_dob(wh);
 
EXPORT Make_zip_cnt_with_this_nm_dob(SALT39.StrType s0) := MakeFT_zip_cnt_with_this_nm_dob(s0);
EXPORT InValid_zip_cnt_with_this_nm_dob(SALT39.StrType s) := InValidFT_zip_cnt_with_this_nm_dob(s);
EXPORT InValidMessage_zip_cnt_with_this_nm_dob(UNSIGNED1 wh) := InValidMessageFT_zip_cnt_with_this_nm_dob(wh);
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT39,Scrubs_HeaderSlimSortSrc_Monthly;
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
    BOOLEAN Diff_src;
    BOOLEAN Diff_did;
    BOOLEAN Diff_fname;
    BOOLEAN Diff_lname;
    BOOLEAN Diff_prim_range;
    BOOLEAN Diff_prim_name;
    BOOLEAN Diff_zip;
    BOOLEAN Diff_mname;
    BOOLEAN Diff_sec_range;
    BOOLEAN Diff_name_suffix;
    BOOLEAN Diff_ssn;
    BOOLEAN Diff_dob;
    BOOLEAN Diff_dids_with_this_nm_addr;
    BOOLEAN Diff_suffix_cnt_with_this_nm_addr;
    BOOLEAN Diff_sec_range_cnt_with_this_nm_addr;
    BOOLEAN Diff_ssn_cnt_with_this_nm_addr;
    BOOLEAN Diff_dob_cnt_with_this_nm_addr;
    BOOLEAN Diff_mname_cnt_with_this_nm_addr;
    BOOLEAN Diff_dids_with_this_nm_ssn;
    BOOLEAN Diff_dob_cnt_with_this_nm_ssn;
    BOOLEAN Diff_dids_with_this_nm_dob;
    BOOLEAN Diff_zip_cnt_with_this_nm_dob;
    UNSIGNED Num_Diffs;
    SALT39.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_src := le.src <> ri.src;
    SELF.Diff_did := le.did <> ri.did;
    SELF.Diff_fname := le.fname <> ri.fname;
    SELF.Diff_lname := le.lname <> ri.lname;
    SELF.Diff_prim_range := le.prim_range <> ri.prim_range;
    SELF.Diff_prim_name := le.prim_name <> ri.prim_name;
    SELF.Diff_zip := le.zip <> ri.zip;
    SELF.Diff_mname := le.mname <> ri.mname;
    SELF.Diff_sec_range := le.sec_range <> ri.sec_range;
    SELF.Diff_name_suffix := le.name_suffix <> ri.name_suffix;
    SELF.Diff_ssn := le.ssn <> ri.ssn;
    SELF.Diff_dob := le.dob <> ri.dob;
    SELF.Diff_dids_with_this_nm_addr := le.dids_with_this_nm_addr <> ri.dids_with_this_nm_addr;
    SELF.Diff_suffix_cnt_with_this_nm_addr := le.suffix_cnt_with_this_nm_addr <> ri.suffix_cnt_with_this_nm_addr;
    SELF.Diff_sec_range_cnt_with_this_nm_addr := le.sec_range_cnt_with_this_nm_addr <> ri.sec_range_cnt_with_this_nm_addr;
    SELF.Diff_ssn_cnt_with_this_nm_addr := le.ssn_cnt_with_this_nm_addr <> ri.ssn_cnt_with_this_nm_addr;
    SELF.Diff_dob_cnt_with_this_nm_addr := le.dob_cnt_with_this_nm_addr <> ri.dob_cnt_with_this_nm_addr;
    SELF.Diff_mname_cnt_with_this_nm_addr := le.mname_cnt_with_this_nm_addr <> ri.mname_cnt_with_this_nm_addr;
    SELF.Diff_dids_with_this_nm_ssn := le.dids_with_this_nm_ssn <> ri.dids_with_this_nm_ssn;
    SELF.Diff_dob_cnt_with_this_nm_ssn := le.dob_cnt_with_this_nm_ssn <> ri.dob_cnt_with_this_nm_ssn;
    SELF.Diff_dids_with_this_nm_dob := le.dids_with_this_nm_dob <> ri.dids_with_this_nm_dob;
    SELF.Diff_zip_cnt_with_this_nm_dob := le.zip_cnt_with_this_nm_dob <> ri.zip_cnt_with_this_nm_dob;
    SELF.Val := (SALT39.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_src,1,0)+ IF( SELF.Diff_did,1,0)+ IF( SELF.Diff_fname,1,0)+ IF( SELF.Diff_lname,1,0)+ IF( SELF.Diff_prim_range,1,0)+ IF( SELF.Diff_prim_name,1,0)+ IF( SELF.Diff_zip,1,0)+ IF( SELF.Diff_mname,1,0)+ IF( SELF.Diff_sec_range,1,0)+ IF( SELF.Diff_name_suffix,1,0)+ IF( SELF.Diff_ssn,1,0)+ IF( SELF.Diff_dob,1,0)+ IF( SELF.Diff_dids_with_this_nm_addr,1,0)+ IF( SELF.Diff_suffix_cnt_with_this_nm_addr,1,0)+ IF( SELF.Diff_sec_range_cnt_with_this_nm_addr,1,0)+ IF( SELF.Diff_ssn_cnt_with_this_nm_addr,1,0)+ IF( SELF.Diff_dob_cnt_with_this_nm_addr,1,0)+ IF( SELF.Diff_mname_cnt_with_this_nm_addr,1,0)+ IF( SELF.Diff_dids_with_this_nm_ssn,1,0)+ IF( SELF.Diff_dob_cnt_with_this_nm_ssn,1,0)+ IF( SELF.Diff_dids_with_this_nm_dob,1,0)+ IF( SELF.Diff_zip_cnt_with_this_nm_dob,1,0);
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
    Count_Diff_src := COUNT(GROUP,%Closest%.Diff_src);
    Count_Diff_did := COUNT(GROUP,%Closest%.Diff_did);
    Count_Diff_fname := COUNT(GROUP,%Closest%.Diff_fname);
    Count_Diff_lname := COUNT(GROUP,%Closest%.Diff_lname);
    Count_Diff_prim_range := COUNT(GROUP,%Closest%.Diff_prim_range);
    Count_Diff_prim_name := COUNT(GROUP,%Closest%.Diff_prim_name);
    Count_Diff_zip := COUNT(GROUP,%Closest%.Diff_zip);
    Count_Diff_mname := COUNT(GROUP,%Closest%.Diff_mname);
    Count_Diff_sec_range := COUNT(GROUP,%Closest%.Diff_sec_range);
    Count_Diff_name_suffix := COUNT(GROUP,%Closest%.Diff_name_suffix);
    Count_Diff_ssn := COUNT(GROUP,%Closest%.Diff_ssn);
    Count_Diff_dob := COUNT(GROUP,%Closest%.Diff_dob);
    Count_Diff_dids_with_this_nm_addr := COUNT(GROUP,%Closest%.Diff_dids_with_this_nm_addr);
    Count_Diff_suffix_cnt_with_this_nm_addr := COUNT(GROUP,%Closest%.Diff_suffix_cnt_with_this_nm_addr);
    Count_Diff_sec_range_cnt_with_this_nm_addr := COUNT(GROUP,%Closest%.Diff_sec_range_cnt_with_this_nm_addr);
    Count_Diff_ssn_cnt_with_this_nm_addr := COUNT(GROUP,%Closest%.Diff_ssn_cnt_with_this_nm_addr);
    Count_Diff_dob_cnt_with_this_nm_addr := COUNT(GROUP,%Closest%.Diff_dob_cnt_with_this_nm_addr);
    Count_Diff_mname_cnt_with_this_nm_addr := COUNT(GROUP,%Closest%.Diff_mname_cnt_with_this_nm_addr);
    Count_Diff_dids_with_this_nm_ssn := COUNT(GROUP,%Closest%.Diff_dids_with_this_nm_ssn);
    Count_Diff_dob_cnt_with_this_nm_ssn := COUNT(GROUP,%Closest%.Diff_dob_cnt_with_this_nm_ssn);
    Count_Diff_dids_with_this_nm_dob := COUNT(GROUP,%Closest%.Diff_dids_with_this_nm_dob);
    Count_Diff_zip_cnt_with_this_nm_dob := COUNT(GROUP,%Closest%.Diff_zip_cnt_with_this_nm_dob);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
