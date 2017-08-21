IMPORT SALT36;
EXPORT Fields := MODULE
 
// Processing for each FieldType
EXPORT SALT36.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'base','az','nm','aznm','a_name','first_name','middle_initial','last_name','suffix','former_first_name','former_middle_initial','former_last_name','former_suffix','former_first_name2','former_middle_initial2','former_last_name2','former_suffix2','aka_first_name','aka_middle_initial','aka_last_name','aka_suffix','current_address','current_city','current_state','current_zip','current_address_date_reported','former1_address','former1_city','former1_state','former1_zip','former1_address_date_reported','former2_address','former2_city','former2_state','former2_zip','former2_address_date_reported','blank1','valid_ssn','cid','ssn_confirmed','blank2','blank3');
EXPORT FieldTypeNum(SALT36.StrType fn) := CASE(fn,'base' => 1,'az' => 2,'nm' => 3,'aznm' => 4,'a_name' => 5,'first_name' => 6,'middle_initial' => 7,'last_name' => 8,'suffix' => 9,'former_first_name' => 10,'former_middle_initial' => 11,'former_last_name' => 12,'former_suffix' => 13,'former_first_name2' => 14,'former_middle_initial2' => 15,'former_last_name2' => 16,'former_suffix2' => 17,'aka_first_name' => 18,'aka_middle_initial' => 19,'aka_last_name' => 20,'aka_suffix' => 21,'current_address' => 22,'current_city' => 23,'current_state' => 24,'current_zip' => 25,'current_address_date_reported' => 26,'former1_address' => 27,'former1_city' => 28,'former1_state' => 29,'former1_zip' => 30,'former1_address_date_reported' => 31,'former2_address' => 32,'former2_city' => 33,'former2_state' => 34,'former2_zip' => 35,'former2_address_date_reported' => 36,'blank1' => 37,'valid_ssn' => 38,'cid' => 39,'ssn_confirmed' => 40,'blank2' => 41,'blank3' => 42,0);
 
EXPORT MakeFT_base(SALT36.StrType s0) := FUNCTION
  s1 := SALT36.stringcleanspaces( SALT36.stringsubstituteout(s0,' ',' ') ); // Insert spaces but avoid doubles
  s2 := TRIM(s1,LEFT); // Left trim
  RETURN  s2;
END;
EXPORT InValidFT_base(SALT36.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0);
EXPORT InValidMessageFT_base(UNSIGNED1 wh) := CHOOSE(wh,SALT36.HygieneErrors.NotLeft,SALT36.HygieneErrors.Good);
 
EXPORT MakeFT_az(SALT36.StrType s0) := FUNCTION
  s1 := SALT36.stringfilter(s0,' ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT36.stringcleanspaces( SALT36.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  MakeFT_base(s3);
END;
EXPORT InValidFT_az(SALT36.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT36.StringFilter(s,' ABCDEFGHIJKLMNOPQRSTUVWXYZ '))));
EXPORT InValidMessageFT_az(UNSIGNED1 wh) := CHOOSE(wh,SALT36.HygieneErrors.NotLeft,SALT36.HygieneErrors.NotInChars(' ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT36.HygieneErrors.Good);
 
EXPORT MakeFT_nm(SALT36.StrType s0) := FUNCTION
  s1 := SALT36.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT36.stringcleanspaces( SALT36.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  MakeFT_base(s3);
END;
EXPORT InValidFT_nm(SALT36.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT36.StringFilter(s,'0123456789 '))));
EXPORT InValidMessageFT_nm(UNSIGNED1 wh) := CHOOSE(wh,SALT36.HygieneErrors.NotLeft,SALT36.HygieneErrors.NotInChars('0123456789 '),SALT36.HygieneErrors.Good);
 
EXPORT MakeFT_aznm(SALT36.StrType s0) := FUNCTION
  s1 := SALT36.stringfilter(s0,' #0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT36.stringcleanspaces( SALT36.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  MakeFT_base(s3);
END;
EXPORT InValidFT_aznm(SALT36.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT36.StringFilter(s,' #0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ '))));
EXPORT InValidMessageFT_aznm(UNSIGNED1 wh) := CHOOSE(wh,SALT36.HygieneErrors.NotLeft,SALT36.HygieneErrors.NotInChars(' #0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT36.HygieneErrors.Good);
 
EXPORT MakeFT_a_name(SALT36.StrType s0) := FUNCTION
  s1 := SALT36.stringfilter(s0,' ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT36.stringcleanspaces( SALT36.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  MakeFT_base(s3);
END;
EXPORT InValidFT_a_name(SALT36.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT36.StringFilter(s,' ABCDEFGHIJKLMNOPQRSTUVWXYZ '))),~(LENGTH(TRIM(s)) >= 0 AND LENGTH(TRIM(s)) <= 13),~(SALT36.WordCount(SALT36.StringSubstituteOut(s,' ',' ')) >= 1 AND SALT36.WordCount(SALT36.StringSubstituteOut(s,' ',' ')) <= 4));
EXPORT InValidMessageFT_a_name(UNSIGNED1 wh) := CHOOSE(wh,SALT36.HygieneErrors.NotLeft,SALT36.HygieneErrors.NotInChars(' ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT36.HygieneErrors.NotLength('0..13'),SALT36.HygieneErrors.NotWords('1..4'),SALT36.HygieneErrors.Good);
 
EXPORT MakeFT_first_name(SALT36.StrType s0) := FUNCTION
  s1 := SALT36.stringfilter(s0,' ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT36.stringcleanspaces( SALT36.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  MakeFT_a_name(s3);
END;
EXPORT InValidFT_first_name(SALT36.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT36.StringFilter(s,' ABCDEFGHIJKLMNOPQRSTUVWXYZ '))),~(LENGTH(TRIM(s)) >= 3 AND LENGTH(TRIM(s)) <= 11),~(SALT36.WordCount(SALT36.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_first_name(UNSIGNED1 wh) := CHOOSE(wh,SALT36.HygieneErrors.NotLeft,SALT36.HygieneErrors.NotInChars(' ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT36.HygieneErrors.NotLength('3..11'),SALT36.HygieneErrors.NotWords('1..1'),SALT36.HygieneErrors.Good);
 
EXPORT MakeFT_middle_initial(SALT36.StrType s0) := FUNCTION
  s1 := SALT36.stringfilter(s0,' ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT36.stringcleanspaces( SALT36.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  MakeFT_a_name(s3);
END;
EXPORT InValidFT_middle_initial(SALT36.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT36.StringFilter(s,' ABCDEFGHIJKLMNOPQRSTUVWXYZ '))),~(LENGTH(TRIM(s)) = 1),~(SALT36.WordCount(SALT36.StringSubstituteOut(s,' ',' ')) >= 0 AND SALT36.WordCount(SALT36.StringSubstituteOut(s,' ',' ')) <= 1));
EXPORT InValidMessageFT_middle_initial(UNSIGNED1 wh) := CHOOSE(wh,SALT36.HygieneErrors.NotLeft,SALT36.HygieneErrors.NotInChars(' ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT36.HygieneErrors.NotLength('1..1'),SALT36.HygieneErrors.NotWords('0..1'),SALT36.HygieneErrors.Good);
 
EXPORT MakeFT_last_name(SALT36.StrType s0) := FUNCTION
  s1 := SALT36.stringfilter(s0,' ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT36.stringcleanspaces( SALT36.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  MakeFT_a_name(s3);
END;
EXPORT InValidFT_last_name(SALT36.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT36.StringFilter(s,' ABCDEFGHIJKLMNOPQRSTUVWXYZ '))),~(LENGTH(TRIM(s)) >= 3 AND LENGTH(TRIM(s)) <= 11),~(SALT36.WordCount(SALT36.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_last_name(UNSIGNED1 wh) := CHOOSE(wh,SALT36.HygieneErrors.NotLeft,SALT36.HygieneErrors.NotInChars(' ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT36.HygieneErrors.NotLength('3..11'),SALT36.HygieneErrors.NotWords('1..1'),SALT36.HygieneErrors.Good);
 
EXPORT MakeFT_suffix(SALT36.StrType s0) := FUNCTION
  s1 := SALT36.stringfilter(s0,'1234567JRS '); // Only allow valid symbols
  s2 := SALT36.stringcleanspaces( SALT36.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  MakeFT_a_name(s3);
END;
EXPORT InValidFT_suffix(SALT36.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT36.StringFilter(s,'1234567JRS '))),~(LENGTH(TRIM(s)) = 0),~(SALT36.WordCount(SALT36.StringSubstituteOut(s,' ',' ')) >= 0 AND SALT36.WordCount(SALT36.StringSubstituteOut(s,' ',' ')) <= 1));
EXPORT InValidMessageFT_suffix(UNSIGNED1 wh) := CHOOSE(wh,SALT36.HygieneErrors.NotLeft,SALT36.HygieneErrors.NotInChars('1234567JRS '),SALT36.HygieneErrors.NotLength('0'),SALT36.HygieneErrors.NotWords('0..1'),SALT36.HygieneErrors.Good);
 
EXPORT MakeFT_former_first_name(SALT36.StrType s0) := FUNCTION
  s1 := SALT36.stringfilter(s0,' ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT36.stringcleanspaces( SALT36.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  MakeFT_first_name(s3);
END;
EXPORT InValidFT_former_first_name(SALT36.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT36.StringFilter(s,' ABCDEFGHIJKLMNOPQRSTUVWXYZ '))),~(LENGTH(TRIM(s)) = 0),~(SALT36.WordCount(SALT36.StringSubstituteOut(s,' ',' ')) >= 0 AND SALT36.WordCount(SALT36.StringSubstituteOut(s,' ',' ')) <= 1));
EXPORT InValidMessageFT_former_first_name(UNSIGNED1 wh) := CHOOSE(wh,SALT36.HygieneErrors.NotLeft,SALT36.HygieneErrors.NotInChars(' ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT36.HygieneErrors.NotLength('0'),SALT36.HygieneErrors.NotWords('0..1'),SALT36.HygieneErrors.Good);
 
EXPORT MakeFT_former_middle_initial(SALT36.StrType s0) := FUNCTION
  s1 := SALT36.stringfilter(s0,' ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT36.stringcleanspaces( SALT36.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  MakeFT_middle_initial(s3);
END;
EXPORT InValidFT_former_middle_initial(SALT36.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT36.StringFilter(s,' ABCDEFGHIJKLMNOPQRSTUVWXYZ '))),~(LENGTH(TRIM(s)) = 0),~(SALT36.WordCount(SALT36.StringSubstituteOut(s,' ',' ')) >= 0 AND SALT36.WordCount(SALT36.StringSubstituteOut(s,' ',' ')) <= 1));
EXPORT InValidMessageFT_former_middle_initial(UNSIGNED1 wh) := CHOOSE(wh,SALT36.HygieneErrors.NotLeft,SALT36.HygieneErrors.NotInChars(' ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT36.HygieneErrors.NotLength('0'),SALT36.HygieneErrors.NotWords('0..1'),SALT36.HygieneErrors.Good);
 
EXPORT MakeFT_former_last_name(SALT36.StrType s0) := FUNCTION
  s1 := SALT36.stringfilter(s0,' ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT36.stringcleanspaces( SALT36.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  MakeFT_last_name(s3);
END;
EXPORT InValidFT_former_last_name(SALT36.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT36.StringFilter(s,' ABCDEFGHIJKLMNOPQRSTUVWXYZ '))),~(LENGTH(TRIM(s)) = 0),~(SALT36.WordCount(SALT36.StringSubstituteOut(s,' ',' ')) >= 0 AND SALT36.WordCount(SALT36.StringSubstituteOut(s,' ',' ')) <= 1));
EXPORT InValidMessageFT_former_last_name(UNSIGNED1 wh) := CHOOSE(wh,SALT36.HygieneErrors.NotLeft,SALT36.HygieneErrors.NotInChars(' ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT36.HygieneErrors.NotLength('0'),SALT36.HygieneErrors.NotWords('0..1'),SALT36.HygieneErrors.Good);
 
EXPORT MakeFT_former_suffix(SALT36.StrType s0) := FUNCTION
  s1 := SALT36.stringfilter(s0,'1234567JRS '); // Only allow valid symbols
  s2 := SALT36.stringcleanspaces( SALT36.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  MakeFT_suffix(s3);
END;
EXPORT InValidFT_former_suffix(SALT36.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT36.StringFilter(s,'1234567JRS '))),~(LENGTH(TRIM(s)) = 0),~(SALT36.WordCount(SALT36.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_former_suffix(UNSIGNED1 wh) := CHOOSE(wh,SALT36.HygieneErrors.NotLeft,SALT36.HygieneErrors.NotInChars('1234567JRS '),SALT36.HygieneErrors.NotLength('0'),SALT36.HygieneErrors.NotWords('0'),SALT36.HygieneErrors.Good);
 
EXPORT MakeFT_former_first_name2(SALT36.StrType s0) := FUNCTION
  s1 := SALT36.stringfilter(s0,' ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT36.stringcleanspaces( SALT36.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  MakeFT_former_first_name(s3);
END;
EXPORT InValidFT_former_first_name2(SALT36.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT36.StringFilter(s,' ABCDEFGHIJKLMNOPQRSTUVWXYZ '))),~(LENGTH(TRIM(s)) = 0),~(SALT36.WordCount(SALT36.StringSubstituteOut(s,' ',' ')) >= 0 AND SALT36.WordCount(SALT36.StringSubstituteOut(s,' ',' ')) <= 1));
EXPORT InValidMessageFT_former_first_name2(UNSIGNED1 wh) := CHOOSE(wh,SALT36.HygieneErrors.NotLeft,SALT36.HygieneErrors.NotInChars(' ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT36.HygieneErrors.NotLength('0'),SALT36.HygieneErrors.NotWords('0..1'),SALT36.HygieneErrors.Good);
 
EXPORT MakeFT_former_middle_initial2(SALT36.StrType s0) := FUNCTION
  s1 := SALT36.stringfilter(s0,' ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT36.stringcleanspaces( SALT36.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  MakeFT_former_middle_initial(s3);
END;
EXPORT InValidFT_former_middle_initial2(SALT36.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT36.StringFilter(s,' ABCDEFGHIJKLMNOPQRSTUVWXYZ '))),~(LENGTH(TRIM(s)) = 0),~(SALT36.WordCount(SALT36.StringSubstituteOut(s,' ',' ')) >= 0 AND SALT36.WordCount(SALT36.StringSubstituteOut(s,' ',' ')) <= 1));
EXPORT InValidMessageFT_former_middle_initial2(UNSIGNED1 wh) := CHOOSE(wh,SALT36.HygieneErrors.NotLeft,SALT36.HygieneErrors.NotInChars(' ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT36.HygieneErrors.NotLength('0'),SALT36.HygieneErrors.NotWords('0..1'),SALT36.HygieneErrors.Good);
 
EXPORT MakeFT_former_last_name2(SALT36.StrType s0) := FUNCTION
  s1 := SALT36.stringfilter(s0,' ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT36.stringcleanspaces( SALT36.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  MakeFT_former_last_name(s3);
END;
EXPORT InValidFT_former_last_name2(SALT36.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT36.StringFilter(s,' ABCDEFGHIJKLMNOPQRSTUVWXYZ '))),~(LENGTH(TRIM(s)) = 0),~(SALT36.WordCount(SALT36.StringSubstituteOut(s,' ',' ')) >= 0 AND SALT36.WordCount(SALT36.StringSubstituteOut(s,' ',' ')) <= 1));
EXPORT InValidMessageFT_former_last_name2(UNSIGNED1 wh) := CHOOSE(wh,SALT36.HygieneErrors.NotLeft,SALT36.HygieneErrors.NotInChars(' ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT36.HygieneErrors.NotLength('0'),SALT36.HygieneErrors.NotWords('0..1'),SALT36.HygieneErrors.Good);
 
EXPORT MakeFT_former_suffix2(SALT36.StrType s0) := FUNCTION
  s1 := SALT36.stringfilter(s0,'1234567JRS '); // Only allow valid symbols
  s2 := SALT36.stringcleanspaces( SALT36.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  MakeFT_former_suffix(s3);
END;
EXPORT InValidFT_former_suffix2(SALT36.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT36.StringFilter(s,'1234567JRS '))),~(LENGTH(TRIM(s)) = 0),~(SALT36.WordCount(SALT36.StringSubstituteOut(s,' ',' ')) >= 0 AND SALT36.WordCount(SALT36.StringSubstituteOut(s,' ',' ')) <= 1));
EXPORT InValidMessageFT_former_suffix2(UNSIGNED1 wh) := CHOOSE(wh,SALT36.HygieneErrors.NotLeft,SALT36.HygieneErrors.NotInChars('1234567JRS '),SALT36.HygieneErrors.NotLength('0'),SALT36.HygieneErrors.NotWords('0..1'),SALT36.HygieneErrors.Good);
 
EXPORT MakeFT_aka_first_name(SALT36.StrType s0) := FUNCTION
  s1 := SALT36.stringfilter(s0,' ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT36.stringcleanspaces( SALT36.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  MakeFT_a_name(s3);
END;
EXPORT InValidFT_aka_first_name(SALT36.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT36.StringFilter(s,' ABCDEFGHIJKLMNOPQRSTUVWXYZ '))),~(LENGTH(TRIM(s)) = 0),~(SALT36.WordCount(SALT36.StringSubstituteOut(s,' ',' ')) >= 0 AND SALT36.WordCount(SALT36.StringSubstituteOut(s,' ',' ')) <= 1));
EXPORT InValidMessageFT_aka_first_name(UNSIGNED1 wh) := CHOOSE(wh,SALT36.HygieneErrors.NotLeft,SALT36.HygieneErrors.NotInChars(' ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT36.HygieneErrors.NotLength('0'),SALT36.HygieneErrors.NotWords('0..1'),SALT36.HygieneErrors.Good);
 
EXPORT MakeFT_aka_middle_initial(SALT36.StrType s0) := FUNCTION
  s1 := SALT36.stringfilter(s0,' ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT36.stringcleanspaces( SALT36.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  MakeFT_middle_initial(s3);
END;
EXPORT InValidFT_aka_middle_initial(SALT36.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT36.StringFilter(s,' ABCDEFGHIJKLMNOPQRSTUVWXYZ '))),~(LENGTH(TRIM(s)) = 0),~(SALT36.WordCount(SALT36.StringSubstituteOut(s,' ',' ')) >= 0 AND SALT36.WordCount(SALT36.StringSubstituteOut(s,' ',' ')) <= 1));
EXPORT InValidMessageFT_aka_middle_initial(UNSIGNED1 wh) := CHOOSE(wh,SALT36.HygieneErrors.NotLeft,SALT36.HygieneErrors.NotInChars(' ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT36.HygieneErrors.NotLength('0'),SALT36.HygieneErrors.NotWords('0..1'),SALT36.HygieneErrors.Good);
 
EXPORT MakeFT_aka_last_name(SALT36.StrType s0) := FUNCTION
  s1 := SALT36.stringfilter(s0,' ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT36.stringcleanspaces( SALT36.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  MakeFT_last_name(s3);
END;
EXPORT InValidFT_aka_last_name(SALT36.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT36.StringFilter(s,' ABCDEFGHIJKLMNOPQRSTUVWXYZ '))),~(LENGTH(TRIM(s)) = 0),~(SALT36.WordCount(SALT36.StringSubstituteOut(s,' ',' ')) >= 0 AND SALT36.WordCount(SALT36.StringSubstituteOut(s,' ',' ')) <= 1));
EXPORT InValidMessageFT_aka_last_name(UNSIGNED1 wh) := CHOOSE(wh,SALT36.HygieneErrors.NotLeft,SALT36.HygieneErrors.NotInChars(' ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT36.HygieneErrors.NotLength('0'),SALT36.HygieneErrors.NotWords('0..1'),SALT36.HygieneErrors.Good);
 
EXPORT MakeFT_aka_suffix(SALT36.StrType s0) := FUNCTION
  s1 := SALT36.stringfilter(s0,'1234567JRS '); // Only allow valid symbols
  s2 := SALT36.stringcleanspaces( SALT36.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  MakeFT_suffix(s3);
END;
EXPORT InValidFT_aka_suffix(SALT36.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT36.StringFilter(s,'1234567JRS '))),~(LENGTH(TRIM(s)) = 0),~(SALT36.WordCount(SALT36.StringSubstituteOut(s,' ',' ')) >= 0 AND SALT36.WordCount(SALT36.StringSubstituteOut(s,' ',' ')) <= 1));
EXPORT InValidMessageFT_aka_suffix(UNSIGNED1 wh) := CHOOSE(wh,SALT36.HygieneErrors.NotLeft,SALT36.HygieneErrors.NotInChars('1234567JRS '),SALT36.HygieneErrors.NotLength('0'),SALT36.HygieneErrors.NotWords('0..1'),SALT36.HygieneErrors.Good);
 
EXPORT MakeFT_current_address(SALT36.StrType s0) := FUNCTION
  s1 := SALT36.stringfilter(s0,' #0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT36.stringcleanspaces( SALT36.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  MakeFT_aznm(s3);
END;
EXPORT InValidFT_current_address(SALT36.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT36.StringFilter(s,' #0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ '))),~(LENGTH(TRIM(s)) >= 10 AND LENGTH(TRIM(s)) <= 30),~(SALT36.WordCount(SALT36.StringSubstituteOut(s,' ',' ')) >= 1 AND SALT36.WordCount(SALT36.StringSubstituteOut(s,' ',' ')) <= 6));
EXPORT InValidMessageFT_current_address(UNSIGNED1 wh) := CHOOSE(wh,SALT36.HygieneErrors.NotLeft,SALT36.HygieneErrors.NotInChars(' #0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT36.HygieneErrors.NotLength('10..30'),SALT36.HygieneErrors.NotWords('1..6'),SALT36.HygieneErrors.Good);
 
EXPORT MakeFT_current_city(SALT36.StrType s0) := FUNCTION
  s1 := SALT36.stringfilter(s0,' ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT36.stringcleanspaces( SALT36.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  MakeFT_az(s3);
END;
EXPORT InValidFT_current_city(SALT36.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT36.StringFilter(s,' ABCDEFGHIJKLMNOPQRSTUVWXYZ '))),~(LENGTH(TRIM(s)) >= 4 AND LENGTH(TRIM(s)) <= 16),~(SALT36.WordCount(SALT36.StringSubstituteOut(s,' ',' ')) >= 1 AND SALT36.WordCount(SALT36.StringSubstituteOut(s,' ',' ')) <= 3));
EXPORT InValidMessageFT_current_city(UNSIGNED1 wh) := CHOOSE(wh,SALT36.HygieneErrors.NotLeft,SALT36.HygieneErrors.NotInChars(' ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT36.HygieneErrors.NotLength('4..16'),SALT36.HygieneErrors.NotWords('1..3'),SALT36.HygieneErrors.Good);
 
EXPORT MakeFT_current_state(SALT36.StrType s0) := FUNCTION
  s1 := SALT36.stringfilter(s0,' ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT36.stringcleanspaces( SALT36.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  MakeFT_az(s3);
END;
EXPORT InValidFT_current_state(SALT36.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT36.StringFilter(s,' ABCDEFGHIJKLMNOPQRSTUVWXYZ '))),~(LENGTH(TRIM(s)) = 2),~(SALT36.WordCount(SALT36.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_current_state(UNSIGNED1 wh) := CHOOSE(wh,SALT36.HygieneErrors.NotLeft,SALT36.HygieneErrors.NotInChars(' ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT36.HygieneErrors.NotLength('2'),SALT36.HygieneErrors.NotWords('1'),SALT36.HygieneErrors.Good);
 
EXPORT MakeFT_current_zip(SALT36.StrType s0) := FUNCTION
  s1 := SALT36.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT36.stringcleanspaces( SALT36.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  MakeFT_nm(s3);
END;
EXPORT InValidFT_current_zip(SALT36.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT36.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 5),~(SALT36.WordCount(SALT36.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_current_zip(UNSIGNED1 wh) := CHOOSE(wh,SALT36.HygieneErrors.NotLeft,SALT36.HygieneErrors.NotInChars('0123456789 '),SALT36.HygieneErrors.NotLength('5'),SALT36.HygieneErrors.NotWords('1'),SALT36.HygieneErrors.Good);
 
EXPORT MakeFT_current_address_date_reported(SALT36.StrType s0) := FUNCTION
  s1 := SALT36.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT36.stringcleanspaces( SALT36.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  MakeFT_nm(s3);
END;
EXPORT InValidFT_current_address_date_reported(SALT36.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT36.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 6),~(SALT36.WordCount(SALT36.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_current_address_date_reported(UNSIGNED1 wh) := CHOOSE(wh,SALT36.HygieneErrors.NotLeft,SALT36.HygieneErrors.NotInChars('0123456789 '),SALT36.HygieneErrors.NotLength('6'),SALT36.HygieneErrors.NotWords('1'),SALT36.HygieneErrors.Good);
 
EXPORT MakeFT_former1_address(SALT36.StrType s0) := FUNCTION
  s1 := SALT36.stringfilter(s0,' #0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT36.stringcleanspaces( SALT36.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  MakeFT_current_address(s3);
END;
EXPORT InValidFT_former1_address(SALT36.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT36.StringFilter(s,' #0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ '))),~(LENGTH(TRIM(s)) >= 10 AND LENGTH(TRIM(s)) <= 30),~(SALT36.WordCount(SALT36.StringSubstituteOut(s,' ',' ')) >= 1 AND SALT36.WordCount(SALT36.StringSubstituteOut(s,' ',' ')) <= 6));
EXPORT InValidMessageFT_former1_address(UNSIGNED1 wh) := CHOOSE(wh,SALT36.HygieneErrors.NotLeft,SALT36.HygieneErrors.NotInChars(' #0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT36.HygieneErrors.NotLength('10..30'),SALT36.HygieneErrors.NotWords('1..6'),SALT36.HygieneErrors.Good);
 
EXPORT MakeFT_former1_city(SALT36.StrType s0) := FUNCTION
  s1 := SALT36.stringfilter(s0,' ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT36.stringcleanspaces( SALT36.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  MakeFT_current_city(s3);
END;
EXPORT InValidFT_former1_city(SALT36.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT36.StringFilter(s,' ABCDEFGHIJKLMNOPQRSTUVWXYZ '))),~(LENGTH(TRIM(s)) >= 4 AND LENGTH(TRIM(s)) <= 16),~(SALT36.WordCount(SALT36.StringSubstituteOut(s,' ',' ')) >= 1 AND SALT36.WordCount(SALT36.StringSubstituteOut(s,' ',' ')) <= 3));
EXPORT InValidMessageFT_former1_city(UNSIGNED1 wh) := CHOOSE(wh,SALT36.HygieneErrors.NotLeft,SALT36.HygieneErrors.NotInChars(' ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT36.HygieneErrors.NotLength('4..16'),SALT36.HygieneErrors.NotWords('1..3'),SALT36.HygieneErrors.Good);
 
EXPORT MakeFT_former1_state(SALT36.StrType s0) := FUNCTION
  s1 := SALT36.stringfilter(s0,' ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT36.stringcleanspaces( SALT36.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  MakeFT_current_state(s3);
END;
EXPORT InValidFT_former1_state(SALT36.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT36.StringFilter(s,' ABCDEFGHIJKLMNOPQRSTUVWXYZ '))),~(LENGTH(TRIM(s)) = 2),~(SALT36.WordCount(SALT36.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_former1_state(UNSIGNED1 wh) := CHOOSE(wh,SALT36.HygieneErrors.NotLeft,SALT36.HygieneErrors.NotInChars(' ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT36.HygieneErrors.NotLength('2'),SALT36.HygieneErrors.NotWords('1'),SALT36.HygieneErrors.Good);
 
EXPORT MakeFT_former1_zip(SALT36.StrType s0) := FUNCTION
  s1 := SALT36.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT36.stringcleanspaces( SALT36.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  MakeFT_current_zip(s3);
END;
EXPORT InValidFT_former1_zip(SALT36.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT36.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 5),~(SALT36.WordCount(SALT36.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_former1_zip(UNSIGNED1 wh) := CHOOSE(wh,SALT36.HygieneErrors.NotLeft,SALT36.HygieneErrors.NotInChars('0123456789 '),SALT36.HygieneErrors.NotLength('5'),SALT36.HygieneErrors.NotWords('1'),SALT36.HygieneErrors.Good);
 
EXPORT MakeFT_former1_address_date_reported(SALT36.StrType s0) := FUNCTION
  s1 := SALT36.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT36.stringcleanspaces( SALT36.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  MakeFT_current_address_date_reported(s3);
END;
EXPORT InValidFT_former1_address_date_reported(SALT36.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT36.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 6),~(SALT36.WordCount(SALT36.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_former1_address_date_reported(UNSIGNED1 wh) := CHOOSE(wh,SALT36.HygieneErrors.NotLeft,SALT36.HygieneErrors.NotInChars('0123456789 '),SALT36.HygieneErrors.NotLength('6'),SALT36.HygieneErrors.NotWords('1'),SALT36.HygieneErrors.Good);
 
EXPORT MakeFT_former2_address(SALT36.StrType s0) := FUNCTION
  s1 := SALT36.stringfilter(s0,' #0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT36.stringcleanspaces( SALT36.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  MakeFT_current_address(s3);
END;
EXPORT InValidFT_former2_address(SALT36.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT36.StringFilter(s,' #0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ '))),~(LENGTH(TRIM(s)) >= 10 AND LENGTH(TRIM(s)) <= 30),~(SALT36.WordCount(SALT36.StringSubstituteOut(s,' ',' ')) >= 1 AND SALT36.WordCount(SALT36.StringSubstituteOut(s,' ',' ')) <= 6));
EXPORT InValidMessageFT_former2_address(UNSIGNED1 wh) := CHOOSE(wh,SALT36.HygieneErrors.NotLeft,SALT36.HygieneErrors.NotInChars(' #0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT36.HygieneErrors.NotLength('10..30'),SALT36.HygieneErrors.NotWords('1..6'),SALT36.HygieneErrors.Good);
 
EXPORT MakeFT_former2_city(SALT36.StrType s0) := FUNCTION
  s1 := SALT36.stringfilter(s0,' ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT36.stringcleanspaces( SALT36.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  MakeFT_current_city(s3);
END;
EXPORT InValidFT_former2_city(SALT36.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT36.StringFilter(s,' ABCDEFGHIJKLMNOPQRSTUVWXYZ '))),~(LENGTH(TRIM(s)) >= 4 AND LENGTH(TRIM(s)) <= 16),~(SALT36.WordCount(SALT36.StringSubstituteOut(s,' ',' ')) >= 1 AND SALT36.WordCount(SALT36.StringSubstituteOut(s,' ',' ')) <= 3));
EXPORT InValidMessageFT_former2_city(UNSIGNED1 wh) := CHOOSE(wh,SALT36.HygieneErrors.NotLeft,SALT36.HygieneErrors.NotInChars(' ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT36.HygieneErrors.NotLength('4..16'),SALT36.HygieneErrors.NotWords('1..3'),SALT36.HygieneErrors.Good);
 
EXPORT MakeFT_former2_state(SALT36.StrType s0) := FUNCTION
  s1 := SALT36.stringfilter(s0,' ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT36.stringcleanspaces( SALT36.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  MakeFT_current_state(s3);
END;
EXPORT InValidFT_former2_state(SALT36.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT36.StringFilter(s,' ABCDEFGHIJKLMNOPQRSTUVWXYZ '))),~(LENGTH(TRIM(s)) = 2),~(SALT36.WordCount(SALT36.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_former2_state(UNSIGNED1 wh) := CHOOSE(wh,SALT36.HygieneErrors.NotLeft,SALT36.HygieneErrors.NotInChars(' ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT36.HygieneErrors.NotLength('2'),SALT36.HygieneErrors.NotWords('1'),SALT36.HygieneErrors.Good);
 
EXPORT MakeFT_former2_zip(SALT36.StrType s0) := FUNCTION
  s1 := SALT36.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT36.stringcleanspaces( SALT36.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  MakeFT_current_zip(s3);
END;
EXPORT InValidFT_former2_zip(SALT36.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT36.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 5),~(SALT36.WordCount(SALT36.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_former2_zip(UNSIGNED1 wh) := CHOOSE(wh,SALT36.HygieneErrors.NotLeft,SALT36.HygieneErrors.NotInChars('0123456789 '),SALT36.HygieneErrors.NotLength('5'),SALT36.HygieneErrors.NotWords('1'),SALT36.HygieneErrors.Good);
 
EXPORT MakeFT_former2_address_date_reported(SALT36.StrType s0) := FUNCTION
  s1 := SALT36.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT36.stringcleanspaces( SALT36.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  MakeFT_current_address_date_reported(s3);
END;
EXPORT InValidFT_former2_address_date_reported(SALT36.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT36.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 6),~(SALT36.WordCount(SALT36.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_former2_address_date_reported(UNSIGNED1 wh) := CHOOSE(wh,SALT36.HygieneErrors.NotLeft,SALT36.HygieneErrors.NotInChars('0123456789 '),SALT36.HygieneErrors.NotLength('6'),SALT36.HygieneErrors.NotWords('1'),SALT36.HygieneErrors.Good);
 
EXPORT MakeFT_blank1(SALT36.StrType s0) := FUNCTION
  s1 := SALT36.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT36.stringcleanspaces( SALT36.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  MakeFT_nm(s3);
END;
EXPORT InValidFT_blank1(SALT36.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT36.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 4),~(SALT36.WordCount(SALT36.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_blank1(UNSIGNED1 wh) := CHOOSE(wh,SALT36.HygieneErrors.NotLeft,SALT36.HygieneErrors.NotInChars('0123456789 '),SALT36.HygieneErrors.NotLength('4'),SALT36.HygieneErrors.NotWords('1'),SALT36.HygieneErrors.Good);
 
EXPORT MakeFT_valid_ssn(SALT36.StrType s0) := FUNCTION
  s1 := SALT36.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT36.stringcleanspaces( SALT36.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  MakeFT_nm(s3);
END;
EXPORT InValidFT_valid_ssn(SALT36.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT36.StringFilter(s,'0123456789 '))),~fn_valid_ssn(s),~(LENGTH(TRIM(s)) = 9),~(SALT36.WordCount(SALT36.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_valid_ssn(UNSIGNED1 wh) := CHOOSE(wh,SALT36.HygieneErrors.NotLeft,SALT36.HygieneErrors.NotInChars('0123456789 '),SALT36.HygieneErrors.CustomFail('fn_valid_ssn'),SALT36.HygieneErrors.NotLength('9'),SALT36.HygieneErrors.NotWords('1'),SALT36.HygieneErrors.Good);
 
EXPORT MakeFT_cid(SALT36.StrType s0) := FUNCTION
  s1 := SALT36.stringfilter(s0,'0123456789ABCDEF '); // Only allow valid symbols
  s2 := SALT36.stringcleanspaces( SALT36.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  MakeFT_base(s3);
END;
EXPORT InValidFT_cid(SALT36.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT36.StringFilter(s,'0123456789ABCDEF '))),~(LENGTH(TRIM(s)) = 9),~(SALT36.WordCount(SALT36.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_cid(UNSIGNED1 wh) := CHOOSE(wh,SALT36.HygieneErrors.NotLeft,SALT36.HygieneErrors.NotInChars('0123456789ABCDEF '),SALT36.HygieneErrors.NotLength('9'),SALT36.HygieneErrors.NotWords('1'),SALT36.HygieneErrors.Good);
 
EXPORT MakeFT_ssn_confirmed(SALT36.StrType s0) := FUNCTION
  s1 := SALT36.stringfilter(s0,'C '); // Only allow valid symbols
  s2 := SALT36.stringcleanspaces( SALT36.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  MakeFT_base(s3);
END;
EXPORT InValidFT_ssn_confirmed(SALT36.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT36.StringFilter(s,'C '))),~(LENGTH(TRIM(s)) = 1),~(SALT36.WordCount(SALT36.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_ssn_confirmed(UNSIGNED1 wh) := CHOOSE(wh,SALT36.HygieneErrors.NotLeft,SALT36.HygieneErrors.NotInChars('C '),SALT36.HygieneErrors.NotLength('1'),SALT36.HygieneErrors.NotWords('1'),SALT36.HygieneErrors.Good);
 
EXPORT MakeFT_blank2(SALT36.StrType s0) := FUNCTION
  s1 := SALT36.stringcleanspaces( SALT36.stringsubstituteout(s0,' ',' ') ); // Insert spaces but avoid doubles
  s2 := TRIM(s1,LEFT); // Left trim
  RETURN  MakeFT_base(s2);
END;
EXPORT InValidFT_blank2(SALT36.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,~(LENGTH(TRIM(s)) = 0),~(SALT36.WordCount(SALT36.StringSubstituteOut(s,' ',' ')) >= 0 AND SALT36.WordCount(SALT36.StringSubstituteOut(s,' ',' ')) <= 1));
EXPORT InValidMessageFT_blank2(UNSIGNED1 wh) := CHOOSE(wh,SALT36.HygieneErrors.NotLeft,SALT36.HygieneErrors.NotLength('0'),SALT36.HygieneErrors.NotWords('0..1'),SALT36.HygieneErrors.Good);
 
EXPORT MakeFT_blank3(SALT36.StrType s0) := FUNCTION
  s1 := SALT36.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT36.stringcleanspaces( SALT36.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  MakeFT_nm(s3);
END;
EXPORT InValidFT_blank3(SALT36.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT36.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 0),~(SALT36.WordCount(SALT36.StringSubstituteOut(s,' ',' ')) >= 0 AND SALT36.WordCount(SALT36.StringSubstituteOut(s,' ',' ')) <= 1));
EXPORT InValidMessageFT_blank3(UNSIGNED1 wh) := CHOOSE(wh,SALT36.HygieneErrors.NotLeft,SALT36.HygieneErrors.NotInChars('0123456789 '),SALT36.HygieneErrors.NotLength('0'),SALT36.HygieneErrors.NotWords('0..1'),SALT36.HygieneErrors.Good);
 
EXPORT SALT36.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'first_name','middle_initial','last_name','suffix','former_first_name','former_middle_initial','former_last_name','former_suffix','former_first_name2','former_middle_initial2','former_last_name2','former_suffix2','aka_first_name','aka_middle_initial','aka_last_name','aka_suffix','current_address','current_city','current_state','current_zip','current_address_date_reported','former1_address','former1_city','former1_state','former1_zip','former1_address_date_reported','former2_address','former2_city','former2_state','former2_zip','former2_address_date_reported','blank1','ssn','cid','ssn_confirmed','blank2','blank3');
EXPORT FieldNum(SALT36.StrType fn) := CASE(fn,'first_name' => 0,'middle_initial' => 1,'last_name' => 2,'suffix' => 3,'former_first_name' => 4,'former_middle_initial' => 5,'former_last_name' => 6,'former_suffix' => 7,'former_first_name2' => 8,'former_middle_initial2' => 9,'former_last_name2' => 10,'former_suffix2' => 11,'aka_first_name' => 12,'aka_middle_initial' => 13,'aka_last_name' => 14,'aka_suffix' => 15,'current_address' => 16,'current_city' => 17,'current_state' => 18,'current_zip' => 19,'current_address_date_reported' => 20,'former1_address' => 21,'former1_city' => 22,'former1_state' => 23,'former1_zip' => 24,'former1_address_date_reported' => 25,'former2_address' => 26,'former2_city' => 27,'former2_state' => 28,'former2_zip' => 29,'former2_address_date_reported' => 30,'blank1' => 31,'ssn' => 32,'cid' => 33,'ssn_confirmed' => 34,'blank2' => 35,'blank3' => 36,0);
 
//Individual field level validation
 
EXPORT Make_first_name(SALT36.StrType s0) := MakeFT_first_name(s0);
EXPORT InValid_first_name(SALT36.StrType s) := InValidFT_first_name(s);
EXPORT InValidMessage_first_name(UNSIGNED1 wh) := InValidMessageFT_first_name(wh);
 
EXPORT Make_middle_initial(SALT36.StrType s0) := MakeFT_middle_initial(s0);
EXPORT InValid_middle_initial(SALT36.StrType s) := InValidFT_middle_initial(s);
EXPORT InValidMessage_middle_initial(UNSIGNED1 wh) := InValidMessageFT_middle_initial(wh);
 
EXPORT Make_last_name(SALT36.StrType s0) := MakeFT_last_name(s0);
EXPORT InValid_last_name(SALT36.StrType s) := InValidFT_last_name(s);
EXPORT InValidMessage_last_name(UNSIGNED1 wh) := InValidMessageFT_last_name(wh);
 
EXPORT Make_suffix(SALT36.StrType s0) := MakeFT_suffix(s0);
EXPORT InValid_suffix(SALT36.StrType s) := InValidFT_suffix(s);
EXPORT InValidMessage_suffix(UNSIGNED1 wh) := InValidMessageFT_suffix(wh);
 
EXPORT Make_former_first_name(SALT36.StrType s0) := MakeFT_former_first_name(s0);
EXPORT InValid_former_first_name(SALT36.StrType s) := InValidFT_former_first_name(s);
EXPORT InValidMessage_former_first_name(UNSIGNED1 wh) := InValidMessageFT_former_first_name(wh);
 
EXPORT Make_former_middle_initial(SALT36.StrType s0) := MakeFT_former_middle_initial(s0);
EXPORT InValid_former_middle_initial(SALT36.StrType s) := InValidFT_former_middle_initial(s);
EXPORT InValidMessage_former_middle_initial(UNSIGNED1 wh) := InValidMessageFT_former_middle_initial(wh);
 
EXPORT Make_former_last_name(SALT36.StrType s0) := MakeFT_former_last_name(s0);
EXPORT InValid_former_last_name(SALT36.StrType s) := InValidFT_former_last_name(s);
EXPORT InValidMessage_former_last_name(UNSIGNED1 wh) := InValidMessageFT_former_last_name(wh);
 
EXPORT Make_former_suffix(SALT36.StrType s0) := MakeFT_former_suffix(s0);
EXPORT InValid_former_suffix(SALT36.StrType s) := InValidFT_former_suffix(s);
EXPORT InValidMessage_former_suffix(UNSIGNED1 wh) := InValidMessageFT_former_suffix(wh);
 
EXPORT Make_former_first_name2(SALT36.StrType s0) := MakeFT_former_first_name2(s0);
EXPORT InValid_former_first_name2(SALT36.StrType s) := InValidFT_former_first_name2(s);
EXPORT InValidMessage_former_first_name2(UNSIGNED1 wh) := InValidMessageFT_former_first_name2(wh);
 
EXPORT Make_former_middle_initial2(SALT36.StrType s0) := MakeFT_former_middle_initial2(s0);
EXPORT InValid_former_middle_initial2(SALT36.StrType s) := InValidFT_former_middle_initial2(s);
EXPORT InValidMessage_former_middle_initial2(UNSIGNED1 wh) := InValidMessageFT_former_middle_initial2(wh);
 
EXPORT Make_former_last_name2(SALT36.StrType s0) := MakeFT_former_last_name2(s0);
EXPORT InValid_former_last_name2(SALT36.StrType s) := InValidFT_former_last_name2(s);
EXPORT InValidMessage_former_last_name2(UNSIGNED1 wh) := InValidMessageFT_former_last_name2(wh);
 
EXPORT Make_former_suffix2(SALT36.StrType s0) := MakeFT_former_suffix2(s0);
EXPORT InValid_former_suffix2(SALT36.StrType s) := InValidFT_former_suffix2(s);
EXPORT InValidMessage_former_suffix2(UNSIGNED1 wh) := InValidMessageFT_former_suffix2(wh);
 
EXPORT Make_aka_first_name(SALT36.StrType s0) := MakeFT_aka_first_name(s0);
EXPORT InValid_aka_first_name(SALT36.StrType s) := InValidFT_aka_first_name(s);
EXPORT InValidMessage_aka_first_name(UNSIGNED1 wh) := InValidMessageFT_aka_first_name(wh);
 
EXPORT Make_aka_middle_initial(SALT36.StrType s0) := MakeFT_aka_middle_initial(s0);
EXPORT InValid_aka_middle_initial(SALT36.StrType s) := InValidFT_aka_middle_initial(s);
EXPORT InValidMessage_aka_middle_initial(UNSIGNED1 wh) := InValidMessageFT_aka_middle_initial(wh);
 
EXPORT Make_aka_last_name(SALT36.StrType s0) := MakeFT_aka_last_name(s0);
EXPORT InValid_aka_last_name(SALT36.StrType s) := InValidFT_aka_last_name(s);
EXPORT InValidMessage_aka_last_name(UNSIGNED1 wh) := InValidMessageFT_aka_last_name(wh);
 
EXPORT Make_aka_suffix(SALT36.StrType s0) := MakeFT_aka_suffix(s0);
EXPORT InValid_aka_suffix(SALT36.StrType s) := InValidFT_aka_suffix(s);
EXPORT InValidMessage_aka_suffix(UNSIGNED1 wh) := InValidMessageFT_aka_suffix(wh);
 
EXPORT Make_current_address(SALT36.StrType s0) := MakeFT_current_address(s0);
EXPORT InValid_current_address(SALT36.StrType s) := InValidFT_current_address(s);
EXPORT InValidMessage_current_address(UNSIGNED1 wh) := InValidMessageFT_current_address(wh);
 
EXPORT Make_current_city(SALT36.StrType s0) := MakeFT_current_city(s0);
EXPORT InValid_current_city(SALT36.StrType s) := InValidFT_current_city(s);
EXPORT InValidMessage_current_city(UNSIGNED1 wh) := InValidMessageFT_current_city(wh);
 
EXPORT Make_current_state(SALT36.StrType s0) := MakeFT_current_state(s0);
EXPORT InValid_current_state(SALT36.StrType s) := InValidFT_current_state(s);
EXPORT InValidMessage_current_state(UNSIGNED1 wh) := InValidMessageFT_current_state(wh);
 
EXPORT Make_current_zip(SALT36.StrType s0) := MakeFT_current_zip(s0);
EXPORT InValid_current_zip(SALT36.StrType s) := InValidFT_current_zip(s);
EXPORT InValidMessage_current_zip(UNSIGNED1 wh) := InValidMessageFT_current_zip(wh);
 
EXPORT Make_current_address_date_reported(SALT36.StrType s0) := MakeFT_current_address_date_reported(s0);
EXPORT InValid_current_address_date_reported(SALT36.StrType s) := InValidFT_current_address_date_reported(s);
EXPORT InValidMessage_current_address_date_reported(UNSIGNED1 wh) := InValidMessageFT_current_address_date_reported(wh);
 
EXPORT Make_former1_address(SALT36.StrType s0) := MakeFT_former1_address(s0);
EXPORT InValid_former1_address(SALT36.StrType s) := InValidFT_former1_address(s);
EXPORT InValidMessage_former1_address(UNSIGNED1 wh) := InValidMessageFT_former1_address(wh);
 
EXPORT Make_former1_city(SALT36.StrType s0) := MakeFT_former1_city(s0);
EXPORT InValid_former1_city(SALT36.StrType s) := InValidFT_former1_city(s);
EXPORT InValidMessage_former1_city(UNSIGNED1 wh) := InValidMessageFT_former1_city(wh);
 
EXPORT Make_former1_state(SALT36.StrType s0) := MakeFT_former1_state(s0);
EXPORT InValid_former1_state(SALT36.StrType s) := InValidFT_former1_state(s);
EXPORT InValidMessage_former1_state(UNSIGNED1 wh) := InValidMessageFT_former1_state(wh);
 
EXPORT Make_former1_zip(SALT36.StrType s0) := MakeFT_former1_zip(s0);
EXPORT InValid_former1_zip(SALT36.StrType s) := InValidFT_former1_zip(s);
EXPORT InValidMessage_former1_zip(UNSIGNED1 wh) := InValidMessageFT_former1_zip(wh);
 
EXPORT Make_former1_address_date_reported(SALT36.StrType s0) := MakeFT_former1_address_date_reported(s0);
EXPORT InValid_former1_address_date_reported(SALT36.StrType s) := InValidFT_former1_address_date_reported(s);
EXPORT InValidMessage_former1_address_date_reported(UNSIGNED1 wh) := InValidMessageFT_former1_address_date_reported(wh);
 
EXPORT Make_former2_address(SALT36.StrType s0) := MakeFT_former2_address(s0);
EXPORT InValid_former2_address(SALT36.StrType s) := InValidFT_former2_address(s);
EXPORT InValidMessage_former2_address(UNSIGNED1 wh) := InValidMessageFT_former2_address(wh);
 
EXPORT Make_former2_city(SALT36.StrType s0) := MakeFT_former2_city(s0);
EXPORT InValid_former2_city(SALT36.StrType s) := InValidFT_former2_city(s);
EXPORT InValidMessage_former2_city(UNSIGNED1 wh) := InValidMessageFT_former2_city(wh);
 
EXPORT Make_former2_state(SALT36.StrType s0) := MakeFT_former2_state(s0);
EXPORT InValid_former2_state(SALT36.StrType s) := InValidFT_former2_state(s);
EXPORT InValidMessage_former2_state(UNSIGNED1 wh) := InValidMessageFT_former2_state(wh);
 
EXPORT Make_former2_zip(SALT36.StrType s0) := MakeFT_former2_zip(s0);
EXPORT InValid_former2_zip(SALT36.StrType s) := InValidFT_former2_zip(s);
EXPORT InValidMessage_former2_zip(UNSIGNED1 wh) := InValidMessageFT_former2_zip(wh);
 
EXPORT Make_former2_address_date_reported(SALT36.StrType s0) := MakeFT_former2_address_date_reported(s0);
EXPORT InValid_former2_address_date_reported(SALT36.StrType s) := InValidFT_former2_address_date_reported(s);
EXPORT InValidMessage_former2_address_date_reported(UNSIGNED1 wh) := InValidMessageFT_former2_address_date_reported(wh);
 
EXPORT Make_blank1(SALT36.StrType s0) := MakeFT_blank1(s0);
EXPORT InValid_blank1(SALT36.StrType s) := InValidFT_blank1(s);
EXPORT InValidMessage_blank1(UNSIGNED1 wh) := InValidMessageFT_blank1(wh);
 
EXPORT Make_ssn(SALT36.StrType s0) := MakeFT_valid_ssn(s0);
EXPORT InValid_ssn(SALT36.StrType s) := InValidFT_valid_ssn(s);
EXPORT InValidMessage_ssn(UNSIGNED1 wh) := InValidMessageFT_valid_ssn(wh);
 
EXPORT Make_cid(SALT36.StrType s0) := MakeFT_cid(s0);
EXPORT InValid_cid(SALT36.StrType s) := InValidFT_cid(s);
EXPORT InValidMessage_cid(UNSIGNED1 wh) := InValidMessageFT_cid(wh);
 
EXPORT Make_ssn_confirmed(SALT36.StrType s0) := MakeFT_ssn_confirmed(s0);
EXPORT InValid_ssn_confirmed(SALT36.StrType s) := InValidFT_ssn_confirmed(s);
EXPORT InValidMessage_ssn_confirmed(UNSIGNED1 wh) := InValidMessageFT_ssn_confirmed(wh);
 
EXPORT Make_blank2(SALT36.StrType s0) := MakeFT_blank2(s0);
EXPORT InValid_blank2(SALT36.StrType s) := InValidFT_blank2(s);
EXPORT InValidMessage_blank2(UNSIGNED1 wh) := InValidMessageFT_blank2(wh);
 
EXPORT Make_blank3(SALT36.StrType s0) := MakeFT_blank3(s0);
EXPORT InValid_blank3(SALT36.StrType s) := InValidFT_blank3(s);
EXPORT InValidMessage_blank3(UNSIGNED1 wh) := InValidMessageFT_blank3(wh);
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT36,Scrubs_Equifax_Monthly;
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
    BOOLEAN Diff_first_name;
    BOOLEAN Diff_middle_initial;
    BOOLEAN Diff_last_name;
    BOOLEAN Diff_suffix;
    BOOLEAN Diff_former_first_name;
    BOOLEAN Diff_former_middle_initial;
    BOOLEAN Diff_former_last_name;
    BOOLEAN Diff_former_suffix;
    BOOLEAN Diff_former_first_name2;
    BOOLEAN Diff_former_middle_initial2;
    BOOLEAN Diff_former_last_name2;
    BOOLEAN Diff_former_suffix2;
    BOOLEAN Diff_aka_first_name;
    BOOLEAN Diff_aka_middle_initial;
    BOOLEAN Diff_aka_last_name;
    BOOLEAN Diff_aka_suffix;
    BOOLEAN Diff_current_address;
    BOOLEAN Diff_current_city;
    BOOLEAN Diff_current_state;
    BOOLEAN Diff_current_zip;
    BOOLEAN Diff_current_address_date_reported;
    BOOLEAN Diff_former1_address;
    BOOLEAN Diff_former1_city;
    BOOLEAN Diff_former1_state;
    BOOLEAN Diff_former1_zip;
    BOOLEAN Diff_former1_address_date_reported;
    BOOLEAN Diff_former2_address;
    BOOLEAN Diff_former2_city;
    BOOLEAN Diff_former2_state;
    BOOLEAN Diff_former2_zip;
    BOOLEAN Diff_former2_address_date_reported;
    BOOLEAN Diff_blank1;
    BOOLEAN Diff_ssn;
    BOOLEAN Diff_cid;
    BOOLEAN Diff_ssn_confirmed;
    BOOLEAN Diff_blank2;
    BOOLEAN Diff_blank3;
    UNSIGNED Num_Diffs;
    SALT36.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_first_name := le.first_name <> ri.first_name;
    SELF.Diff_middle_initial := le.middle_initial <> ri.middle_initial;
    SELF.Diff_last_name := le.last_name <> ri.last_name;
    SELF.Diff_suffix := le.suffix <> ri.suffix;
    SELF.Diff_former_first_name := le.former_first_name <> ri.former_first_name;
    SELF.Diff_former_middle_initial := le.former_middle_initial <> ri.former_middle_initial;
    SELF.Diff_former_last_name := le.former_last_name <> ri.former_last_name;
    SELF.Diff_former_suffix := le.former_suffix <> ri.former_suffix;
    SELF.Diff_former_first_name2 := le.former_first_name2 <> ri.former_first_name2;
    SELF.Diff_former_middle_initial2 := le.former_middle_initial2 <> ri.former_middle_initial2;
    SELF.Diff_former_last_name2 := le.former_last_name2 <> ri.former_last_name2;
    SELF.Diff_former_suffix2 := le.former_suffix2 <> ri.former_suffix2;
    SELF.Diff_aka_first_name := le.aka_first_name <> ri.aka_first_name;
    SELF.Diff_aka_middle_initial := le.aka_middle_initial <> ri.aka_middle_initial;
    SELF.Diff_aka_last_name := le.aka_last_name <> ri.aka_last_name;
    SELF.Diff_aka_suffix := le.aka_suffix <> ri.aka_suffix;
    SELF.Diff_current_address := le.current_address <> ri.current_address;
    SELF.Diff_current_city := le.current_city <> ri.current_city;
    SELF.Diff_current_state := le.current_state <> ri.current_state;
    SELF.Diff_current_zip := le.current_zip <> ri.current_zip;
    SELF.Diff_current_address_date_reported := le.current_address_date_reported <> ri.current_address_date_reported;
    SELF.Diff_former1_address := le.former1_address <> ri.former1_address;
    SELF.Diff_former1_city := le.former1_city <> ri.former1_city;
    SELF.Diff_former1_state := le.former1_state <> ri.former1_state;
    SELF.Diff_former1_zip := le.former1_zip <> ri.former1_zip;
    SELF.Diff_former1_address_date_reported := le.former1_address_date_reported <> ri.former1_address_date_reported;
    SELF.Diff_former2_address := le.former2_address <> ri.former2_address;
    SELF.Diff_former2_city := le.former2_city <> ri.former2_city;
    SELF.Diff_former2_state := le.former2_state <> ri.former2_state;
    SELF.Diff_former2_zip := le.former2_zip <> ri.former2_zip;
    SELF.Diff_former2_address_date_reported := le.former2_address_date_reported <> ri.former2_address_date_reported;
    SELF.Diff_blank1 := le.blank1 <> ri.blank1;
    SELF.Diff_ssn := le.ssn <> ri.ssn;
    SELF.Diff_cid := le.cid <> ri.cid;
    SELF.Diff_ssn_confirmed := le.ssn_confirmed <> ri.ssn_confirmed;
    SELF.Diff_blank2 := le.blank2 <> ri.blank2;
    SELF.Diff_blank3 := le.blank3 <> ri.blank3;
    SELF.Val := (SALT36.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_first_name,1,0)+ IF( SELF.Diff_middle_initial,1,0)+ IF( SELF.Diff_last_name,1,0)+ IF( SELF.Diff_suffix,1,0)+ IF( SELF.Diff_former_first_name,1,0)+ IF( SELF.Diff_former_middle_initial,1,0)+ IF( SELF.Diff_former_last_name,1,0)+ IF( SELF.Diff_former_suffix,1,0)+ IF( SELF.Diff_former_first_name2,1,0)+ IF( SELF.Diff_former_middle_initial2,1,0)+ IF( SELF.Diff_former_last_name2,1,0)+ IF( SELF.Diff_former_suffix2,1,0)+ IF( SELF.Diff_aka_first_name,1,0)+ IF( SELF.Diff_aka_middle_initial,1,0)+ IF( SELF.Diff_aka_last_name,1,0)+ IF( SELF.Diff_aka_suffix,1,0)+ IF( SELF.Diff_current_address,1,0)+ IF( SELF.Diff_current_city,1,0)+ IF( SELF.Diff_current_state,1,0)+ IF( SELF.Diff_current_zip,1,0)+ IF( SELF.Diff_current_address_date_reported,1,0)+ IF( SELF.Diff_former1_address,1,0)+ IF( SELF.Diff_former1_city,1,0)+ IF( SELF.Diff_former1_state,1,0)+ IF( SELF.Diff_former1_zip,1,0)+ IF( SELF.Diff_former1_address_date_reported,1,0)+ IF( SELF.Diff_former2_address,1,0)+ IF( SELF.Diff_former2_city,1,0)+ IF( SELF.Diff_former2_state,1,0)+ IF( SELF.Diff_former2_zip,1,0)+ IF( SELF.Diff_former2_address_date_reported,1,0)+ IF( SELF.Diff_blank1,1,0)+ IF( SELF.Diff_ssn,1,0)+ IF( SELF.Diff_cid,1,0)+ IF( SELF.Diff_ssn_confirmed,1,0)+ IF( SELF.Diff_blank2,1,0)+ IF( SELF.Diff_blank3,1,0);
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
    Count_Diff_first_name := COUNT(GROUP,%Closest%.Diff_first_name);
    Count_Diff_middle_initial := COUNT(GROUP,%Closest%.Diff_middle_initial);
    Count_Diff_last_name := COUNT(GROUP,%Closest%.Diff_last_name);
    Count_Diff_suffix := COUNT(GROUP,%Closest%.Diff_suffix);
    Count_Diff_former_first_name := COUNT(GROUP,%Closest%.Diff_former_first_name);
    Count_Diff_former_middle_initial := COUNT(GROUP,%Closest%.Diff_former_middle_initial);
    Count_Diff_former_last_name := COUNT(GROUP,%Closest%.Diff_former_last_name);
    Count_Diff_former_suffix := COUNT(GROUP,%Closest%.Diff_former_suffix);
    Count_Diff_former_first_name2 := COUNT(GROUP,%Closest%.Diff_former_first_name2);
    Count_Diff_former_middle_initial2 := COUNT(GROUP,%Closest%.Diff_former_middle_initial2);
    Count_Diff_former_last_name2 := COUNT(GROUP,%Closest%.Diff_former_last_name2);
    Count_Diff_former_suffix2 := COUNT(GROUP,%Closest%.Diff_former_suffix2);
    Count_Diff_aka_first_name := COUNT(GROUP,%Closest%.Diff_aka_first_name);
    Count_Diff_aka_middle_initial := COUNT(GROUP,%Closest%.Diff_aka_middle_initial);
    Count_Diff_aka_last_name := COUNT(GROUP,%Closest%.Diff_aka_last_name);
    Count_Diff_aka_suffix := COUNT(GROUP,%Closest%.Diff_aka_suffix);
    Count_Diff_current_address := COUNT(GROUP,%Closest%.Diff_current_address);
    Count_Diff_current_city := COUNT(GROUP,%Closest%.Diff_current_city);
    Count_Diff_current_state := COUNT(GROUP,%Closest%.Diff_current_state);
    Count_Diff_current_zip := COUNT(GROUP,%Closest%.Diff_current_zip);
    Count_Diff_current_address_date_reported := COUNT(GROUP,%Closest%.Diff_current_address_date_reported);
    Count_Diff_former1_address := COUNT(GROUP,%Closest%.Diff_former1_address);
    Count_Diff_former1_city := COUNT(GROUP,%Closest%.Diff_former1_city);
    Count_Diff_former1_state := COUNT(GROUP,%Closest%.Diff_former1_state);
    Count_Diff_former1_zip := COUNT(GROUP,%Closest%.Diff_former1_zip);
    Count_Diff_former1_address_date_reported := COUNT(GROUP,%Closest%.Diff_former1_address_date_reported);
    Count_Diff_former2_address := COUNT(GROUP,%Closest%.Diff_former2_address);
    Count_Diff_former2_city := COUNT(GROUP,%Closest%.Diff_former2_city);
    Count_Diff_former2_state := COUNT(GROUP,%Closest%.Diff_former2_state);
    Count_Diff_former2_zip := COUNT(GROUP,%Closest%.Diff_former2_zip);
    Count_Diff_former2_address_date_reported := COUNT(GROUP,%Closest%.Diff_former2_address_date_reported);
    Count_Diff_blank1 := COUNT(GROUP,%Closest%.Diff_blank1);
    Count_Diff_ssn := COUNT(GROUP,%Closest%.Diff_ssn);
    Count_Diff_cid := COUNT(GROUP,%Closest%.Diff_cid);
    Count_Diff_ssn_confirmed := COUNT(GROUP,%Closest%.Diff_ssn_confirmed);
    Count_Diff_blank2 := COUNT(GROUP,%Closest%.Diff_blank2);
    Count_Diff_blank3 := COUNT(GROUP,%Closest%.Diff_blank3);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
