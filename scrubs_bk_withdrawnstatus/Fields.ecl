IMPORT SALT37;
EXPORT Fields := MODULE
 
// Processing for each FieldType
EXPORT SALT37.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'logid','logdate','caseid','defendantid','currentchapter','previouschapter','conversionid','convertdate','currentdisposition','dcode','currentdispositiondate','intseed','pid','tmsid','vacateid','vacatedate','vacateddisposition','vacateddispositiondate','withdrawnid','originalwithdrawndate','withdrawndate','withdrawndisposition','withdrawndispositiondate','originalwithdrawndispositiondate','filedinerror','reopendate','lastupdateddate','iscurrent','__filename');
EXPORT FieldTypeNum(SALT37.StrType fn) := CASE(fn,'logid' => 1,'logdate' => 2,'caseid' => 3,'defendantid' => 4,'currentchapter' => 5,'previouschapter' => 6,'conversionid' => 7,'convertdate' => 8,'currentdisposition' => 9,'dcode' => 10,'currentdispositiondate' => 11,'intseed' => 12,'pid' => 13,'tmsid' => 14,'vacateid' => 15,'vacatedate' => 16,'vacateddisposition' => 17,'vacateddispositiondate' => 18,'withdrawnid' => 19,'originalwithdrawndate' => 20,'withdrawndate' => 21,'withdrawndisposition' => 22,'withdrawndispositiondate' => 23,'originalwithdrawndispositiondate' => 24,'filedinerror' => 25,'reopendate' => 26,'lastupdateddate' => 27,'iscurrent' => 28,'__filename' => 29,0);
 
EXPORT MakeFT_logid(SALT37.StrType s0) := FUNCTION
  s1 := SALT37.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT37.stringcleanspaces( SALT37.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_logid(SALT37.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT37.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 8 OR LENGTH(TRIM(s)) = 7 OR LENGTH(TRIM(s)) = 6 OR LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 3 OR LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 1),~(SALT37.WordCount(SALT37.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_logid(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotLeft,SALT37.HygieneErrors.NotInChars('0123456789 '),SALT37.HygieneErrors.NotLength('8,7,6,5,4,3,2,1'),SALT37.HygieneErrors.NotWords('1'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_logdate(SALT37.StrType s0) := FUNCTION
  s1 := SALT37.stringfilter(s0,' ./0123456789: '); // Only allow valid symbols
  s2 := SALT37.stringcleanspaces( SALT37.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_logdate(SALT37.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT37.StringFilter(s,' ./0123456789: '))),~(LENGTH(TRIM(s)) = 22),~(SALT37.WordCount(SALT37.StringSubstituteOut(s,' ',' ')) = 2));
EXPORT InValidMessageFT_logdate(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotLeft,SALT37.HygieneErrors.NotInChars(' ./0123456789: '),SALT37.HygieneErrors.NotLength('22'),SALT37.HygieneErrors.NotWords('2'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_caseid(SALT37.StrType s0) := FUNCTION
  s1 := SALT37.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT37.stringcleanspaces( SALT37.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_caseid(SALT37.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT37.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 8 OR LENGTH(TRIM(s)) = 7 OR LENGTH(TRIM(s)) = 6 OR LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 3 OR LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 1),~(SALT37.WordCount(SALT37.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_caseid(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotLeft,SALT37.HygieneErrors.NotInChars('0123456789 '),SALT37.HygieneErrors.NotLength('8,7,6,5,4,3,2,1'),SALT37.HygieneErrors.NotWords('1'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_defendantid(SALT37.StrType s0) := FUNCTION
  s1 := SALT37.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT37.stringcleanspaces( SALT37.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_defendantid(SALT37.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT37.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 8 OR LENGTH(TRIM(s)) = 7 OR LENGTH(TRIM(s)) = 6 OR LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 3 OR LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 1),~(SALT37.WordCount(SALT37.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_defendantid(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotLeft,SALT37.HygieneErrors.NotInChars('0123456789 '),SALT37.HygieneErrors.NotLength('8,7,6,5,4,3,2,1'),SALT37.HygieneErrors.NotWords('1'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_currentchapter(SALT37.StrType s0) := FUNCTION
  s1 := SALT37.stringfilter(s0,'1237 '); // Only allow valid symbols
  s2 := SALT37.stringcleanspaces( SALT37.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_currentchapter(SALT37.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT37.StringFilter(s,'1237 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 2),~(SALT37.WordCount(SALT37.StringSubstituteOut(s,' ',' ')) = 0 OR SALT37.WordCount(SALT37.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_currentchapter(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotLeft,SALT37.HygieneErrors.NotInChars('1237 '),SALT37.HygieneErrors.NotLength('0,1,2'),SALT37.HygieneErrors.NotWords('0,1'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_previouschapter(SALT37.StrType s0) := FUNCTION
  s1 := SALT37.stringfilter(s0,'1237 '); // Only allow valid symbols
  s2 := SALT37.stringcleanspaces( SALT37.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_previouschapter(SALT37.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT37.StringFilter(s,'1237 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 1),~(SALT37.WordCount(SALT37.StringSubstituteOut(s,' ',' ')) = 0 OR SALT37.WordCount(SALT37.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_previouschapter(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotLeft,SALT37.HygieneErrors.NotInChars('1237 '),SALT37.HygieneErrors.NotLength('0,2,1'),SALT37.HygieneErrors.NotWords('0,1'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_conversionid(SALT37.StrType s0) := FUNCTION
  s1 := SALT37.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT37.stringcleanspaces( SALT37.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_conversionid(SALT37.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT37.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 7 OR LENGTH(TRIM(s)) = 6 OR LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 3 OR LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 1),~(SALT37.WordCount(SALT37.StringSubstituteOut(s,' ',' ')) = 0 OR SALT37.WordCount(SALT37.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_conversionid(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotLeft,SALT37.HygieneErrors.NotInChars('0123456789 '),SALT37.HygieneErrors.NotLength('0,7,6,5,4,3,2,1'),SALT37.HygieneErrors.NotWords('0,1'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_convertdate(SALT37.StrType s0) := FUNCTION
  s1 := SALT37.stringfilter(s0,' ./0123456789: '); // Only allow valid symbols
  s2 := SALT37.stringcleanspaces( SALT37.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_convertdate(SALT37.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT37.StringFilter(s,' ./0123456789: '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 22),~(SALT37.WordCount(SALT37.StringSubstituteOut(s,' ',' ')) = 0 OR SALT37.WordCount(SALT37.StringSubstituteOut(s,' ',' ')) = 2));
EXPORT InValidMessageFT_convertdate(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotLeft,SALT37.HygieneErrors.NotInChars(' ./0123456789: '),SALT37.HygieneErrors.NotLength('0,22'),SALT37.HygieneErrors.NotWords('0,2'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_currentdisposition(SALT37.StrType s0) := FUNCTION
  s1 := SALT37.stringfilter(s0,'ACDEFGHILMNOPRSTU_ '); // Only allow valid symbols
  s2 := SALT37.stringcleanspaces( SALT37.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_currentdisposition(SALT37.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT37.StringFilter(s,'ACDEFGHILMNOPRSTU_ '))),~(LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 6 OR LENGTH(TRIM(s)) = 10 OR LENGTH(TRIM(s)) = 9 OR LENGTH(TRIM(s)) = 12 OR LENGTH(TRIM(s)) = 14 OR LENGTH(TRIM(s)) = 16),~(SALT37.WordCount(SALT37.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_currentdisposition(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotLeft,SALT37.HygieneErrors.NotInChars('ACDEFGHILMNOPRSTU_ '),SALT37.HygieneErrors.NotLength('4,6,10,9,12,14,16'),SALT37.HygieneErrors.NotWords('1'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_dcode(SALT37.StrType s0) := FUNCTION
  s1 := SALT37.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT37.stringcleanspaces( SALT37.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_dcode(SALT37.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT37.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 1),~(SALT37.WordCount(SALT37.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_dcode(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotLeft,SALT37.HygieneErrors.NotInChars('0123456789 '),SALT37.HygieneErrors.NotLength('2,1'),SALT37.HygieneErrors.NotWords('1'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_currentdispositiondate(SALT37.StrType s0) := FUNCTION
  s1 := SALT37.stringfilter(s0,' ./0123456789: '); // Only allow valid symbols
  s2 := SALT37.stringcleanspaces( SALT37.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_currentdispositiondate(SALT37.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT37.StringFilter(s,' ./0123456789: '))),~(LENGTH(TRIM(s)) = 22 OR LENGTH(TRIM(s)) = 0),~(SALT37.WordCount(SALT37.StringSubstituteOut(s,' ',' ')) = 2 OR SALT37.WordCount(SALT37.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_currentdispositiondate(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotLeft,SALT37.HygieneErrors.NotInChars(' ./0123456789: '),SALT37.HygieneErrors.NotLength('22,0'),SALT37.HygieneErrors.NotWords('2,0'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_intseed(SALT37.StrType s0) := FUNCTION
  s1 := SALT37.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT37.stringcleanspaces( SALT37.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_intseed(SALT37.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT37.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 8 OR LENGTH(TRIM(s)) = 7 OR LENGTH(TRIM(s)) = 6 OR LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 3 OR LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 0),~(SALT37.WordCount(SALT37.StringSubstituteOut(s,' ',' ')) = 0 OR SALT37.WordCount(SALT37.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_intseed(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotLeft,SALT37.HygieneErrors.NotInChars('0123456789 '),SALT37.HygieneErrors.NotLength('8,7,6,5,4,3,2,1,0'),SALT37.HygieneErrors.NotWords('0,1'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_pid(SALT37.StrType s0) := FUNCTION
  s1 := SALT37.stringfilter(s0,'-0123456789abcdef '); // Only allow valid symbols
  s2 := SALT37.stringcleanspaces( SALT37.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_pid(SALT37.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT37.StringFilter(s,'-0123456789abcdef '))),~(LENGTH(TRIM(s)) = 36),~(SALT37.WordCount(SALT37.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_pid(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotLeft,SALT37.HygieneErrors.NotInChars('-0123456789abcdef '),SALT37.HygieneErrors.NotLength('36'),SALT37.HygieneErrors.NotWords('1'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_tmsid(SALT37.StrType s0) := FUNCTION
  s1 := SALT37.stringfilter(s0,'0123456789ABCDEFGHIJKLMNOPRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT37.stringcleanspaces( SALT37.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_tmsid(SALT37.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT37.StringFilter(s,'0123456789ABCDEFGHIJKLMNOPRSTUVWXYZ '))),~(LENGTH(TRIM(s)) = 12 OR LENGTH(TRIM(s)) = 13 OR LENGTH(TRIM(s)) = 14 OR LENGTH(TRIM(s)) = 15),~(SALT37.WordCount(SALT37.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_tmsid(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotLeft,SALT37.HygieneErrors.NotInChars('0123456789ABCDEFGHIJKLMNOPRSTUVWXYZ '),SALT37.HygieneErrors.NotLength('12,13,14,15'),SALT37.HygieneErrors.NotWords('1'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_vacateid(SALT37.StrType s0) := FUNCTION
  s1 := SALT37.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT37.stringcleanspaces( SALT37.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_vacateid(SALT37.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT37.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 6 OR LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 3 OR LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 1),~(SALT37.WordCount(SALT37.StringSubstituteOut(s,' ',' ')) = 0 OR SALT37.WordCount(SALT37.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_vacateid(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotLeft,SALT37.HygieneErrors.NotInChars('0123456789 '),SALT37.HygieneErrors.NotLength('0,6,5,4,3,2,1'),SALT37.HygieneErrors.NotWords('0,1'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_vacatedate(SALT37.StrType s0) := FUNCTION
  s1 := SALT37.stringfilter(s0,' ./0123456789: '); // Only allow valid symbols
  s2 := SALT37.stringcleanspaces( SALT37.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_vacatedate(SALT37.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT37.StringFilter(s,' ./0123456789: '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 22),~(SALT37.WordCount(SALT37.StringSubstituteOut(s,' ',' ')) = 0 OR SALT37.WordCount(SALT37.StringSubstituteOut(s,' ',' ')) = 2));
EXPORT InValidMessageFT_vacatedate(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotLeft,SALT37.HygieneErrors.NotInChars(' ./0123456789: '),SALT37.HygieneErrors.NotLength('0,22'),SALT37.HygieneErrors.NotWords('0,2'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_vacateddisposition(SALT37.StrType s0) := FUNCTION
  s1 := SALT37.stringfilter(s0,'ACDEFGHILMNOPRSTU_ '); // Only allow valid symbols
  s2 := SALT37.stringcleanspaces( SALT37.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_vacateddisposition(SALT37.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT37.StringFilter(s,'ACDEFGHILMNOPRSTU_ '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 6 OR LENGTH(TRIM(s)) = 9 OR LENGTH(TRIM(s)) = 12 OR LENGTH(TRIM(s)) = 14 OR LENGTH(TRIM(s)) = 10 OR LENGTH(TRIM(s)) = 16),~(SALT37.WordCount(SALT37.StringSubstituteOut(s,' ',' ')) = 0 OR SALT37.WordCount(SALT37.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_vacateddisposition(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotLeft,SALT37.HygieneErrors.NotInChars('ACDEFGHILMNOPRSTU_ '),SALT37.HygieneErrors.NotLength('0,6,9,12,14,10,16'),SALT37.HygieneErrors.NotWords('0,1'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_vacateddispositiondate(SALT37.StrType s0) := FUNCTION
  s1 := SALT37.stringfilter(s0,' ./0123456789: '); // Only allow valid symbols
  s2 := SALT37.stringcleanspaces( SALT37.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_vacateddispositiondate(SALT37.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT37.StringFilter(s,' ./0123456789: '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 22),~(SALT37.WordCount(SALT37.StringSubstituteOut(s,' ',' ')) = 0 OR SALT37.WordCount(SALT37.StringSubstituteOut(s,' ',' ')) = 2));
EXPORT InValidMessageFT_vacateddispositiondate(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotLeft,SALT37.HygieneErrors.NotInChars(' ./0123456789: '),SALT37.HygieneErrors.NotLength('0,22'),SALT37.HygieneErrors.NotWords('0,2'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_withdrawnid(SALT37.StrType s0) := FUNCTION
  s1 := SALT37.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT37.stringcleanspaces( SALT37.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_withdrawnid(SALT37.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT37.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 1),~(SALT37.WordCount(SALT37.StringSubstituteOut(s,' ',' ')) = 0 OR SALT37.WordCount(SALT37.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_withdrawnid(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotLeft,SALT37.HygieneErrors.NotInChars('0123456789 '),SALT37.HygieneErrors.NotLength('0,2,1'),SALT37.HygieneErrors.NotWords('0,1'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_originalwithdrawndate(SALT37.StrType s0) := FUNCTION
  s1 := SALT37.stringfilter(s0,' ./0123456789: '); // Only allow valid symbols
  s2 := SALT37.stringcleanspaces( SALT37.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_originalwithdrawndate(SALT37.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT37.StringFilter(s,' ./0123456789: '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 22),~(SALT37.WordCount(SALT37.StringSubstituteOut(s,' ',' ')) = 0 OR SALT37.WordCount(SALT37.StringSubstituteOut(s,' ',' ')) = 2));
EXPORT InValidMessageFT_originalwithdrawndate(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotLeft,SALT37.HygieneErrors.NotInChars(' ./0123456789: '),SALT37.HygieneErrors.NotLength('0,22'),SALT37.HygieneErrors.NotWords('0,2'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_withdrawndate(SALT37.StrType s0) := FUNCTION
  s1 := SALT37.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT37.stringcleanspaces( SALT37.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_withdrawndate(SALT37.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT37.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 8),~(SALT37.WordCount(SALT37.StringSubstituteOut(s,' ',' ')) = 0 OR SALT37.WordCount(SALT37.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_withdrawndate(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotLeft,SALT37.HygieneErrors.NotInChars('0123456789 '),SALT37.HygieneErrors.NotLength('0,8'),SALT37.HygieneErrors.NotWords('0,1'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_withdrawndisposition(SALT37.StrType s0) := FUNCTION
  s1 := SALT37.stringfilter(s0,'DEIMS '); // Only allow valid symbols
  s2 := SALT37.stringcleanspaces( SALT37.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_withdrawndisposition(SALT37.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT37.StringFilter(s,'DEIMS '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 9),~(SALT37.WordCount(SALT37.StringSubstituteOut(s,' ',' ')) = 0 OR SALT37.WordCount(SALT37.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_withdrawndisposition(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotLeft,SALT37.HygieneErrors.NotInChars('DEIMS '),SALT37.HygieneErrors.NotLength('0,9'),SALT37.HygieneErrors.NotWords('0,1'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_withdrawndispositiondate(SALT37.StrType s0) := FUNCTION
  s1 := SALT37.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT37.stringcleanspaces( SALT37.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_withdrawndispositiondate(SALT37.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT37.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 8),~(SALT37.WordCount(SALT37.StringSubstituteOut(s,' ',' ')) = 0 OR SALT37.WordCount(SALT37.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_withdrawndispositiondate(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotLeft,SALT37.HygieneErrors.NotInChars('0123456789 '),SALT37.HygieneErrors.NotLength('0,8'),SALT37.HygieneErrors.NotWords('0,1'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_originalwithdrawndispositiondate(SALT37.StrType s0) := FUNCTION
  s1 := SALT37.stringfilter(s0,' ./0123456789: '); // Only allow valid symbols
  s2 := SALT37.stringcleanspaces( SALT37.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_originalwithdrawndispositiondate(SALT37.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT37.StringFilter(s,' ./0123456789: '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 22),~(SALT37.WordCount(SALT37.StringSubstituteOut(s,' ',' ')) = 0 OR SALT37.WordCount(SALT37.StringSubstituteOut(s,' ',' ')) = 2));
EXPORT InValidMessageFT_originalwithdrawndispositiondate(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotLeft,SALT37.HygieneErrors.NotInChars(' ./0123456789: '),SALT37.HygieneErrors.NotLength('0,22'),SALT37.HygieneErrors.NotWords('0,2'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_filedinerror(SALT37.StrType s0) := FUNCTION
  s1 := SALT37.stringfilter(s0,'FalseTrue '); // Only allow valid symbols
  s2 := SALT37.stringcleanspaces( SALT37.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_filedinerror(SALT37.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT37.StringFilter(s,'FalseTrue '))),~(LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 5),~(SALT37.WordCount(SALT37.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_filedinerror(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotLeft,SALT37.HygieneErrors.NotInChars('FalseTrue '),SALT37.HygieneErrors.NotLength('4,5'),SALT37.HygieneErrors.NotWords('1'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_reopendate(SALT37.StrType s0) := FUNCTION
  s1 := SALT37.stringfilter(s0,' '); // Only allow valid symbols
  s2 := SALT37.stringcleanspaces( SALT37.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_reopendate(SALT37.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT37.StringFilter(s,' '))),~(LENGTH(TRIM(s)) = 0),~(SALT37.WordCount(SALT37.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_reopendate(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotLeft,SALT37.HygieneErrors.NotInChars(' '),SALT37.HygieneErrors.NotLength('0'),SALT37.HygieneErrors.NotWords('0'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_lastupdateddate(SALT37.StrType s0) := FUNCTION
  s1 := SALT37.stringfilter(s0,' ./0123456789: '); // Only allow valid symbols
  s2 := SALT37.stringcleanspaces( SALT37.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_lastupdateddate(SALT37.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT37.StringFilter(s,' ./0123456789: '))),~(LENGTH(TRIM(s)) = 22),~(SALT37.WordCount(SALT37.StringSubstituteOut(s,' ',' ')) = 2));
EXPORT InValidMessageFT_lastupdateddate(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotLeft,SALT37.HygieneErrors.NotInChars(' ./0123456789: '),SALT37.HygieneErrors.NotLength('22'),SALT37.HygieneErrors.NotWords('2'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_iscurrent(SALT37.StrType s0) := FUNCTION
  s1 := SALT37.stringfilter(s0,'1 '); // Only allow valid symbols
  s2 := SALT37.stringcleanspaces( SALT37.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_iscurrent(SALT37.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT37.StringFilter(s,'1 '))),~(LENGTH(TRIM(s)) = 1),~(SALT37.WordCount(SALT37.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_iscurrent(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotLeft,SALT37.HygieneErrors.NotInChars('1 '),SALT37.HygieneErrors.NotLength('1'),SALT37.HygieneErrors.NotWords('1'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT___filename(SALT37.StrType s0) := FUNCTION
  s1 := SALT37.stringfilter(s0,'0123456789:_abcdhiknoprstuvwy '); // Only allow valid symbols
  s2 := SALT37.stringcleanspaces( SALT37.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT___filename(SALT37.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT37.StringFilter(s,'0123456789:_abcdhiknoprstuvwy '))),~(LENGTH(TRIM(s)) = 57 OR LENGTH(TRIM(s)) = 58 OR LENGTH(TRIM(s)) = 59 OR LENGTH(TRIM(s)) = 60),~(SALT37.WordCount(SALT37.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT___filename(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotLeft,SALT37.HygieneErrors.NotInChars('0123456789:_abcdhiknoprstuvwy '),SALT37.HygieneErrors.NotLength('57,58,59,60'),SALT37.HygieneErrors.NotWords('1'),SALT37.HygieneErrors.Good);
 
EXPORT SALT37.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'logid','logdate','caseid','defendantid','currentchapter','previouschapter','conversionid','convertdate','currentdisposition','dcode','currentdispositiondate','intseed','pid','tmsid','vacateid','vacatedate','vacateddisposition','vacateddispositiondate','withdrawnid','originalwithdrawndate','withdrawndate','withdrawndisposition','withdrawndispositiondate','originalwithdrawndispositiondate','filedinerror','reopendate','lastupdateddate','iscurrent','__filename');
EXPORT FieldNum(SALT37.StrType fn) := CASE(fn,'logid' => 0,'logdate' => 1,'caseid' => 2,'defendantid' => 3,'currentchapter' => 4,'previouschapter' => 5,'conversionid' => 6,'convertdate' => 7,'currentdisposition' => 8,'dcode' => 9,'currentdispositiondate' => 10,'intseed' => 11,'pid' => 12,'tmsid' => 13,'vacateid' => 14,'vacatedate' => 15,'vacateddisposition' => 16,'vacateddispositiondate' => 17,'withdrawnid' => 18,'originalwithdrawndate' => 19,'withdrawndate' => 20,'withdrawndisposition' => 21,'withdrawndispositiondate' => 22,'originalwithdrawndispositiondate' => 23,'filedinerror' => 24,'reopendate' => 25,'lastupdateddate' => 26,'iscurrent' => 27,'__filename' => 28,0);
 
//Individual field level validation
 
EXPORT Make_logid(SALT37.StrType s0) := MakeFT_logid(s0);
EXPORT InValid_logid(SALT37.StrType s) := InValidFT_logid(s);
EXPORT InValidMessage_logid(UNSIGNED1 wh) := InValidMessageFT_logid(wh);
 
EXPORT Make_logdate(SALT37.StrType s0) := MakeFT_logdate(s0);
EXPORT InValid_logdate(SALT37.StrType s) := InValidFT_logdate(s);
EXPORT InValidMessage_logdate(UNSIGNED1 wh) := InValidMessageFT_logdate(wh);
 
EXPORT Make_caseid(SALT37.StrType s0) := MakeFT_caseid(s0);
EXPORT InValid_caseid(SALT37.StrType s) := InValidFT_caseid(s);
EXPORT InValidMessage_caseid(UNSIGNED1 wh) := InValidMessageFT_caseid(wh);
 
EXPORT Make_defendantid(SALT37.StrType s0) := MakeFT_defendantid(s0);
EXPORT InValid_defendantid(SALT37.StrType s) := InValidFT_defendantid(s);
EXPORT InValidMessage_defendantid(UNSIGNED1 wh) := InValidMessageFT_defendantid(wh);
 
EXPORT Make_currentchapter(SALT37.StrType s0) := MakeFT_currentchapter(s0);
EXPORT InValid_currentchapter(SALT37.StrType s) := InValidFT_currentchapter(s);
EXPORT InValidMessage_currentchapter(UNSIGNED1 wh) := InValidMessageFT_currentchapter(wh);
 
EXPORT Make_previouschapter(SALT37.StrType s0) := MakeFT_previouschapter(s0);
EXPORT InValid_previouschapter(SALT37.StrType s) := InValidFT_previouschapter(s);
EXPORT InValidMessage_previouschapter(UNSIGNED1 wh) := InValidMessageFT_previouschapter(wh);
 
EXPORT Make_conversionid(SALT37.StrType s0) := MakeFT_conversionid(s0);
EXPORT InValid_conversionid(SALT37.StrType s) := InValidFT_conversionid(s);
EXPORT InValidMessage_conversionid(UNSIGNED1 wh) := InValidMessageFT_conversionid(wh);
 
EXPORT Make_convertdate(SALT37.StrType s0) := MakeFT_convertdate(s0);
EXPORT InValid_convertdate(SALT37.StrType s) := InValidFT_convertdate(s);
EXPORT InValidMessage_convertdate(UNSIGNED1 wh) := InValidMessageFT_convertdate(wh);
 
EXPORT Make_currentdisposition(SALT37.StrType s0) := MakeFT_currentdisposition(s0);
EXPORT InValid_currentdisposition(SALT37.StrType s) := InValidFT_currentdisposition(s);
EXPORT InValidMessage_currentdisposition(UNSIGNED1 wh) := InValidMessageFT_currentdisposition(wh);
 
EXPORT Make_dcode(SALT37.StrType s0) := MakeFT_dcode(s0);
EXPORT InValid_dcode(SALT37.StrType s) := InValidFT_dcode(s);
EXPORT InValidMessage_dcode(UNSIGNED1 wh) := InValidMessageFT_dcode(wh);
 
EXPORT Make_currentdispositiondate(SALT37.StrType s0) := MakeFT_currentdispositiondate(s0);
EXPORT InValid_currentdispositiondate(SALT37.StrType s) := InValidFT_currentdispositiondate(s);
EXPORT InValidMessage_currentdispositiondate(UNSIGNED1 wh) := InValidMessageFT_currentdispositiondate(wh);
 
EXPORT Make_intseed(SALT37.StrType s0) := MakeFT_intseed(s0);
EXPORT InValid_intseed(SALT37.StrType s) := InValidFT_intseed(s);
EXPORT InValidMessage_intseed(UNSIGNED1 wh) := InValidMessageFT_intseed(wh);
 
EXPORT Make_pid(SALT37.StrType s0) := MakeFT_pid(s0);
EXPORT InValid_pid(SALT37.StrType s) := InValidFT_pid(s);
EXPORT InValidMessage_pid(UNSIGNED1 wh) := InValidMessageFT_pid(wh);
 
EXPORT Make_tmsid(SALT37.StrType s0) := MakeFT_tmsid(s0);
EXPORT InValid_tmsid(SALT37.StrType s) := InValidFT_tmsid(s);
EXPORT InValidMessage_tmsid(UNSIGNED1 wh) := InValidMessageFT_tmsid(wh);
 
EXPORT Make_vacateid(SALT37.StrType s0) := MakeFT_vacateid(s0);
EXPORT InValid_vacateid(SALT37.StrType s) := InValidFT_vacateid(s);
EXPORT InValidMessage_vacateid(UNSIGNED1 wh) := InValidMessageFT_vacateid(wh);
 
EXPORT Make_vacatedate(SALT37.StrType s0) := MakeFT_vacatedate(s0);
EXPORT InValid_vacatedate(SALT37.StrType s) := InValidFT_vacatedate(s);
EXPORT InValidMessage_vacatedate(UNSIGNED1 wh) := InValidMessageFT_vacatedate(wh);
 
EXPORT Make_vacateddisposition(SALT37.StrType s0) := MakeFT_vacateddisposition(s0);
EXPORT InValid_vacateddisposition(SALT37.StrType s) := InValidFT_vacateddisposition(s);
EXPORT InValidMessage_vacateddisposition(UNSIGNED1 wh) := InValidMessageFT_vacateddisposition(wh);
 
EXPORT Make_vacateddispositiondate(SALT37.StrType s0) := MakeFT_vacateddispositiondate(s0);
EXPORT InValid_vacateddispositiondate(SALT37.StrType s) := InValidFT_vacateddispositiondate(s);
EXPORT InValidMessage_vacateddispositiondate(UNSIGNED1 wh) := InValidMessageFT_vacateddispositiondate(wh);
 
EXPORT Make_withdrawnid(SALT37.StrType s0) := MakeFT_withdrawnid(s0);
EXPORT InValid_withdrawnid(SALT37.StrType s) := InValidFT_withdrawnid(s);
EXPORT InValidMessage_withdrawnid(UNSIGNED1 wh) := InValidMessageFT_withdrawnid(wh);
 
EXPORT Make_originalwithdrawndate(SALT37.StrType s0) := MakeFT_originalwithdrawndate(s0);
EXPORT InValid_originalwithdrawndate(SALT37.StrType s) := InValidFT_originalwithdrawndate(s);
EXPORT InValidMessage_originalwithdrawndate(UNSIGNED1 wh) := InValidMessageFT_originalwithdrawndate(wh);
 
EXPORT Make_withdrawndate(SALT37.StrType s0) := MakeFT_withdrawndate(s0);
EXPORT InValid_withdrawndate(SALT37.StrType s) := InValidFT_withdrawndate(s);
EXPORT InValidMessage_withdrawndate(UNSIGNED1 wh) := InValidMessageFT_withdrawndate(wh);
 
EXPORT Make_withdrawndisposition(SALT37.StrType s0) := MakeFT_withdrawndisposition(s0);
EXPORT InValid_withdrawndisposition(SALT37.StrType s) := InValidFT_withdrawndisposition(s);
EXPORT InValidMessage_withdrawndisposition(UNSIGNED1 wh) := InValidMessageFT_withdrawndisposition(wh);
 
EXPORT Make_withdrawndispositiondate(SALT37.StrType s0) := MakeFT_withdrawndispositiondate(s0);
EXPORT InValid_withdrawndispositiondate(SALT37.StrType s) := InValidFT_withdrawndispositiondate(s);
EXPORT InValidMessage_withdrawndispositiondate(UNSIGNED1 wh) := InValidMessageFT_withdrawndispositiondate(wh);
 
EXPORT Make_originalwithdrawndispositiondate(SALT37.StrType s0) := MakeFT_originalwithdrawndispositiondate(s0);
EXPORT InValid_originalwithdrawndispositiondate(SALT37.StrType s) := InValidFT_originalwithdrawndispositiondate(s);
EXPORT InValidMessage_originalwithdrawndispositiondate(UNSIGNED1 wh) := InValidMessageFT_originalwithdrawndispositiondate(wh);
 
EXPORT Make_filedinerror(SALT37.StrType s0) := MakeFT_filedinerror(s0);
EXPORT InValid_filedinerror(SALT37.StrType s) := InValidFT_filedinerror(s);
EXPORT InValidMessage_filedinerror(UNSIGNED1 wh) := InValidMessageFT_filedinerror(wh);
 
EXPORT Make_reopendate(SALT37.StrType s0) := MakeFT_reopendate(s0);
EXPORT InValid_reopendate(SALT37.StrType s) := InValidFT_reopendate(s);
EXPORT InValidMessage_reopendate(UNSIGNED1 wh) := InValidMessageFT_reopendate(wh);
 
EXPORT Make_lastupdateddate(SALT37.StrType s0) := MakeFT_lastupdateddate(s0);
EXPORT InValid_lastupdateddate(SALT37.StrType s) := InValidFT_lastupdateddate(s);
EXPORT InValidMessage_lastupdateddate(UNSIGNED1 wh) := InValidMessageFT_lastupdateddate(wh);
 
EXPORT Make_iscurrent(SALT37.StrType s0) := MakeFT_iscurrent(s0);
EXPORT InValid_iscurrent(SALT37.StrType s) := InValidFT_iscurrent(s);
EXPORT InValidMessage_iscurrent(UNSIGNED1 wh) := InValidMessageFT_iscurrent(wh);
 
EXPORT Make___filename(SALT37.StrType s0) := MakeFT___filename(s0);
EXPORT InValid___filename(SALT37.StrType s) := InValidFT___filename(s);
EXPORT InValidMessage___filename(UNSIGNED1 wh) := InValidMessageFT___filename(wh);
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT37,scrubs_bk_withdrawnstatus;
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
    BOOLEAN Diff_logid;
    BOOLEAN Diff_logdate;
    BOOLEAN Diff_caseid;
    BOOLEAN Diff_defendantid;
    BOOLEAN Diff_currentchapter;
    BOOLEAN Diff_previouschapter;
    BOOLEAN Diff_conversionid;
    BOOLEAN Diff_convertdate;
    BOOLEAN Diff_currentdisposition;
    BOOLEAN Diff_dcode;
    BOOLEAN Diff_currentdispositiondate;
    BOOLEAN Diff_intseed;
    BOOLEAN Diff_pid;
    BOOLEAN Diff_tmsid;
    BOOLEAN Diff_vacateid;
    BOOLEAN Diff_vacatedate;
    BOOLEAN Diff_vacateddisposition;
    BOOLEAN Diff_vacateddispositiondate;
    BOOLEAN Diff_withdrawnid;
    BOOLEAN Diff_originalwithdrawndate;
    BOOLEAN Diff_withdrawndate;
    BOOLEAN Diff_withdrawndisposition;
    BOOLEAN Diff_withdrawndispositiondate;
    BOOLEAN Diff_originalwithdrawndispositiondate;
    BOOLEAN Diff_filedinerror;
    BOOLEAN Diff_reopendate;
    BOOLEAN Diff_lastupdateddate;
    BOOLEAN Diff_iscurrent;
    BOOLEAN Diff___filename;
    UNSIGNED Num_Diffs;
    SALT37.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_logid := le.logid <> ri.logid;
    SELF.Diff_logdate := le.logdate <> ri.logdate;
    SELF.Diff_caseid := le.caseid <> ri.caseid;
    SELF.Diff_defendantid := le.defendantid <> ri.defendantid;
    SELF.Diff_currentchapter := le.currentchapter <> ri.currentchapter;
    SELF.Diff_previouschapter := le.previouschapter <> ri.previouschapter;
    SELF.Diff_conversionid := le.conversionid <> ri.conversionid;
    SELF.Diff_convertdate := le.convertdate <> ri.convertdate;
    SELF.Diff_currentdisposition := le.currentdisposition <> ri.currentdisposition;
    SELF.Diff_dcode := le.dcode <> ri.dcode;
    SELF.Diff_currentdispositiondate := le.currentdispositiondate <> ri.currentdispositiondate;
    SELF.Diff_intseed := le.intseed <> ri.intseed;
    SELF.Diff_pid := le.pid <> ri.pid;
    SELF.Diff_tmsid := le.tmsid <> ri.tmsid;
    SELF.Diff_vacateid := le.vacateid <> ri.vacateid;
    SELF.Diff_vacatedate := le.vacatedate <> ri.vacatedate;
    SELF.Diff_vacateddisposition := le.vacateddisposition <> ri.vacateddisposition;
    SELF.Diff_vacateddispositiondate := le.vacateddispositiondate <> ri.vacateddispositiondate;
    SELF.Diff_withdrawnid := le.withdrawnid <> ri.withdrawnid;
    SELF.Diff_originalwithdrawndate := le.originalwithdrawndate <> ri.originalwithdrawndate;
    SELF.Diff_withdrawndate := le.withdrawndate <> ri.withdrawndate;
    SELF.Diff_withdrawndisposition := le.withdrawndisposition <> ri.withdrawndisposition;
    SELF.Diff_withdrawndispositiondate := le.withdrawndispositiondate <> ri.withdrawndispositiondate;
    SELF.Diff_originalwithdrawndispositiondate := le.originalwithdrawndispositiondate <> ri.originalwithdrawndispositiondate;
    SELF.Diff_filedinerror := le.filedinerror <> ri.filedinerror;
    SELF.Diff_reopendate := le.reopendate <> ri.reopendate;
    SELF.Diff_lastupdateddate := le.lastupdateddate <> ri.lastupdateddate;
    SELF.Diff_iscurrent := le.iscurrent <> ri.iscurrent;
    SELF.Diff___filename := le.__filename <> ri.__filename;
    SELF.Val := (SALT37.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_logid,1,0)+ IF( SELF.Diff_logdate,1,0)+ IF( SELF.Diff_caseid,1,0)+ IF( SELF.Diff_defendantid,1,0)+ IF( SELF.Diff_currentchapter,1,0)+ IF( SELF.Diff_previouschapter,1,0)+ IF( SELF.Diff_conversionid,1,0)+ IF( SELF.Diff_convertdate,1,0)+ IF( SELF.Diff_currentdisposition,1,0)+ IF( SELF.Diff_dcode,1,0)+ IF( SELF.Diff_currentdispositiondate,1,0)+ IF( SELF.Diff_intseed,1,0)+ IF( SELF.Diff_pid,1,0)+ IF( SELF.Diff_tmsid,1,0)+ IF( SELF.Diff_vacateid,1,0)+ IF( SELF.Diff_vacatedate,1,0)+ IF( SELF.Diff_vacateddisposition,1,0)+ IF( SELF.Diff_vacateddispositiondate,1,0)+ IF( SELF.Diff_withdrawnid,1,0)+ IF( SELF.Diff_originalwithdrawndate,1,0)+ IF( SELF.Diff_withdrawndate,1,0)+ IF( SELF.Diff_withdrawndisposition,1,0)+ IF( SELF.Diff_withdrawndispositiondate,1,0)+ IF( SELF.Diff_originalwithdrawndispositiondate,1,0)+ IF( SELF.Diff_filedinerror,1,0)+ IF( SELF.Diff_reopendate,1,0)+ IF( SELF.Diff_lastupdateddate,1,0)+ IF( SELF.Diff_iscurrent,1,0)+ IF( SELF.Diff___filename,1,0);
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
    Count_Diff_logid := COUNT(GROUP,%Closest%.Diff_logid);
    Count_Diff_logdate := COUNT(GROUP,%Closest%.Diff_logdate);
    Count_Diff_caseid := COUNT(GROUP,%Closest%.Diff_caseid);
    Count_Diff_defendantid := COUNT(GROUP,%Closest%.Diff_defendantid);
    Count_Diff_currentchapter := COUNT(GROUP,%Closest%.Diff_currentchapter);
    Count_Diff_previouschapter := COUNT(GROUP,%Closest%.Diff_previouschapter);
    Count_Diff_conversionid := COUNT(GROUP,%Closest%.Diff_conversionid);
    Count_Diff_convertdate := COUNT(GROUP,%Closest%.Diff_convertdate);
    Count_Diff_currentdisposition := COUNT(GROUP,%Closest%.Diff_currentdisposition);
    Count_Diff_dcode := COUNT(GROUP,%Closest%.Diff_dcode);
    Count_Diff_currentdispositiondate := COUNT(GROUP,%Closest%.Diff_currentdispositiondate);
    Count_Diff_intseed := COUNT(GROUP,%Closest%.Diff_intseed);
    Count_Diff_pid := COUNT(GROUP,%Closest%.Diff_pid);
    Count_Diff_tmsid := COUNT(GROUP,%Closest%.Diff_tmsid);
    Count_Diff_vacateid := COUNT(GROUP,%Closest%.Diff_vacateid);
    Count_Diff_vacatedate := COUNT(GROUP,%Closest%.Diff_vacatedate);
    Count_Diff_vacateddisposition := COUNT(GROUP,%Closest%.Diff_vacateddisposition);
    Count_Diff_vacateddispositiondate := COUNT(GROUP,%Closest%.Diff_vacateddispositiondate);
    Count_Diff_withdrawnid := COUNT(GROUP,%Closest%.Diff_withdrawnid);
    Count_Diff_originalwithdrawndate := COUNT(GROUP,%Closest%.Diff_originalwithdrawndate);
    Count_Diff_withdrawndate := COUNT(GROUP,%Closest%.Diff_withdrawndate);
    Count_Diff_withdrawndisposition := COUNT(GROUP,%Closest%.Diff_withdrawndisposition);
    Count_Diff_withdrawndispositiondate := COUNT(GROUP,%Closest%.Diff_withdrawndispositiondate);
    Count_Diff_originalwithdrawndispositiondate := COUNT(GROUP,%Closest%.Diff_originalwithdrawndispositiondate);
    Count_Diff_filedinerror := COUNT(GROUP,%Closest%.Diff_filedinerror);
    Count_Diff_reopendate := COUNT(GROUP,%Closest%.Diff_reopendate);
    Count_Diff_lastupdateddate := COUNT(GROUP,%Closest%.Diff_lastupdateddate);
    Count_Diff_iscurrent := COUNT(GROUP,%Closest%.Diff_iscurrent);
    Count_Diff___filename := COUNT(GROUP,%Closest%.Diff___filename);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
