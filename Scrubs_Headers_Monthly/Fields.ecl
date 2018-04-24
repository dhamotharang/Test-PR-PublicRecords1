IMPORT SALT39;
EXPORT Fields := MODULE
 
EXPORT NumFields := 46;
 
// Processing for each FieldType
EXPORT SALT39.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'Invalid_Alpha','Invalid_Num','did','rid','pflag1','pflag2','pflag3','src','dt_first_seen','dt_last_seen','dt_vendor_last_reported','dt_vendor_first_reported','dt_nonglb_last_seen','rec_type','vendor_id','phone','ssn','dob','title','fname','mname','lname','name_suffix','prim_range','predir','prim_name','suffix','postdir','unit_desig','sec_range','city_name','st','zip','zip4','county','geo_blk','cbsa','tnt','valid_ssn','jflag1','jflag2','jflag3','rawaid','dodgy_tracking','nid','address_ind','name_ind','persistent_record_id');
EXPORT FieldTypeNum(SALT39.StrType fn) := CASE(fn,'Invalid_Alpha' => 1,'Invalid_Num' => 2,'did' => 3,'rid' => 4,'pflag1' => 5,'pflag2' => 6,'pflag3' => 7,'src' => 8,'dt_first_seen' => 9,'dt_last_seen' => 10,'dt_vendor_last_reported' => 11,'dt_vendor_first_reported' => 12,'dt_nonglb_last_seen' => 13,'rec_type' => 14,'vendor_id' => 15,'phone' => 16,'ssn' => 17,'dob' => 18,'title' => 19,'fname' => 20,'mname' => 21,'lname' => 22,'name_suffix' => 23,'prim_range' => 24,'predir' => 25,'prim_name' => 26,'suffix' => 27,'postdir' => 28,'unit_desig' => 29,'sec_range' => 30,'city_name' => 31,'st' => 32,'zip' => 33,'zip4' => 34,'county' => 35,'geo_blk' => 36,'cbsa' => 37,'tnt' => 38,'valid_ssn' => 39,'jflag1' => 40,'jflag2' => 41,'jflag3' => 42,'rawaid' => 43,'dodgy_tracking' => 44,'nid' => 45,'address_ind' => 46,'name_ind' => 47,'persistent_record_id' => 48,0);
 
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
 
EXPORT MakeFT_did(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_Invalid_Num(s2);
END;
EXPORT InValidFT_did(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789 '))),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_did(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('0123456789 '),SALT39.HygieneErrors.NotWords('1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_rid(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_Invalid_Num(s2);
END;
EXPORT InValidFT_rid(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789 '))),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_rid(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('0123456789 '),SALT39.HygieneErrors.NotWords('1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_pflag1(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'+A '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_pflag1(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'+A '))),~(LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_pflag1(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('+A '),SALT39.HygieneErrors.NotLength('1,0'),SALT39.HygieneErrors.NotWords('1,0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_pflag2(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'?ANR '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_pflag2(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'?ANR '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 1),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_pflag2(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('?ANR '),SALT39.HygieneErrors.NotLength('0,1'),SALT39.HygieneErrors.NotWords('0,1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_pflag3(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'GV '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_pflag3(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'GV '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 1),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_pflag3(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('GV '),SALT39.HygieneErrors.NotLength('0,1'),SALT39.HygieneErrors.NotWords('0,1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_src(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'!+.01234567?ABCDEFGHIKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_src(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'!+.01234567?ABCDEFGHIKLMNOPQRSTUVWXYZ '))),~(LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 1),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_src(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('!+.01234567?ABCDEFGHIKLMNOPQRSTUVWXYZ '),SALT39.HygieneErrors.NotLength('2,1'),SALT39.HygieneErrors.NotWords('1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_dt_first_seen(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_Invalid_Num(s2);
END;
EXPORT InValidFT_dt_first_seen(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 6 OR LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_dt_first_seen(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('0123456789 '),SALT39.HygieneErrors.NotLength('6,0'),SALT39.HygieneErrors.NotWords('1,0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_dt_last_seen(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_Invalid_Num(s2);
END;
EXPORT InValidFT_dt_last_seen(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 6 OR LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_dt_last_seen(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('0123456789 '),SALT39.HygieneErrors.NotLength('6,0'),SALT39.HygieneErrors.NotWords('1,0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_dt_vendor_last_reported(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_Invalid_Num(s2);
END;
EXPORT InValidFT_dt_vendor_last_reported(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 6 OR LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_dt_vendor_last_reported(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('0123456789 '),SALT39.HygieneErrors.NotLength('6,0'),SALT39.HygieneErrors.NotWords('1,0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_dt_vendor_first_reported(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_Invalid_Num(s2);
END;
EXPORT InValidFT_dt_vendor_first_reported(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 6 OR LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_dt_vendor_first_reported(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('0123456789 '),SALT39.HygieneErrors.NotLength('6,0'),SALT39.HygieneErrors.NotWords('1,0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_dt_nonglb_last_seen(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_Invalid_Num(s2);
END;
EXPORT InValidFT_dt_nonglb_last_seen(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 6),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_dt_nonglb_last_seen(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('0123456789 '),SALT39.HygieneErrors.NotLength('0,6'),SALT39.HygieneErrors.NotWords('0,1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_rec_type(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'123AHS '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_rec_type(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'123AHS '))),~(LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_rec_type(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('123AHS '),SALT39.HygieneErrors.NotLength('1,0'),SALT39.HygieneErrors.NotWords('1,0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_vendor_id(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_vendor_id(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ_ '))),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_vendor_id(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ_ '),SALT39.HygieneErrors.NotWords('1,0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_phone(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_Invalid_Num(s2);
END;
EXPORT InValidFT_phone(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789 '))),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_phone(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('0123456789 '),SALT39.HygieneErrors.NotWords('0,1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_ssn(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_Invalid_Num(s2);
END;
EXPORT InValidFT_ssn(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 9 OR LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_ssn(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('0123456789 '),SALT39.HygieneErrors.NotLength('9,0'),SALT39.HygieneErrors.NotWords('1,0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_dob(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_Invalid_Num(s2);
END;
EXPORT InValidFT_dob(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 8 OR LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_dob(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('0123456789 '),SALT39.HygieneErrors.NotLength('8,0'),SALT39.HygieneErrors.NotWords('1,0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_title(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'MRS '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_title(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'MRS '))),~(LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_title(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('MRS '),SALT39.HygieneErrors.NotLength('2,0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_fname(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_Invalid_Alpha(s2);
END;
EXPORT InValidFT_fname(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ '))));
EXPORT InValidMessageFT_fname(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_mname(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_Invalid_Alpha(s2);
END;
EXPORT InValidFT_mname(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ '))));
EXPORT InValidMessageFT_mname(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_lname(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_Invalid_Alpha(s2);
END;
EXPORT InValidFT_lname(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ '))));
EXPORT InValidMessageFT_lname(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_name_suffix(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'12345JRS '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_name_suffix(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'12345JRS '))));
EXPORT InValidMessageFT_name_suffix(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('12345JRS '),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_prim_range(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'-/0123456789ABNW '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_prim_range(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'-/0123456789ABNW '))));
EXPORT InValidMessageFT_prim_range(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('-/0123456789ABNW '),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_predir(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ENSW '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_predir(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ENSW '))));
EXPORT InValidMessageFT_predir(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('ENSW '),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_prim_name(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789ABCDEFGHIJKLMNOPRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_prim_name(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789ABCDEFGHIJKLMNOPRSTUVWXYZ '))));
EXPORT InValidMessageFT_prim_name(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('0123456789ABCDEFGHIJKLMNOPRSTUVWXYZ '),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_suffix(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_Invalid_Alpha(s2);
END;
EXPORT InValidFT_suffix(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ '))));
EXPORT InValidMessageFT_suffix(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_postdir(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ENSW '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_postdir(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ENSW '))));
EXPORT InValidMessageFT_postdir(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('ENSW '),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_unit_desig(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'#ABCDEFILMNOPRSTUX '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_unit_desig(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'#ABCDEFILMNOPRSTUX '))));
EXPORT InValidMessageFT_unit_desig(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('#ABCDEFILMNOPRSTUX '),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_sec_range(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'-0123456789ABCDEFGHIJKLMNOPQRSTUVW '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_sec_range(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'-0123456789ABCDEFGHIJKLMNOPQRSTUVW '))));
EXPORT InValidMessageFT_sec_range(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('-0123456789ABCDEFGHIJKLMNOPQRSTUVW '),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_city_name(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_Invalid_Alpha(s2);
END;
EXPORT InValidFT_city_name(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ '))));
EXPORT InValidMessageFT_city_name(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_st(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_Invalid_Alpha(s2);
END;
EXPORT InValidFT_st(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ '))));
EXPORT InValidMessageFT_st(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_zip(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_Invalid_Num(s2);
END;
EXPORT InValidFT_zip(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_zip(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('0123456789 '),SALT39.HygieneErrors.NotLength('5,0'),SALT39.HygieneErrors.NotWords('1,0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_zip4(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_Invalid_Num(s2);
END;
EXPORT InValidFT_zip4(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_zip4(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('0123456789 '),SALT39.HygieneErrors.NotLength('4,0'),SALT39.HygieneErrors.NotWords('1,0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_county(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_Invalid_Num(s2);
END;
EXPORT InValidFT_county(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 3 OR LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_county(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('0123456789 '),SALT39.HygieneErrors.NotLength('3,0'),SALT39.HygieneErrors.NotWords('1,0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_geo_blk(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_Invalid_Num(s2);
END;
EXPORT InValidFT_geo_blk(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 7 OR LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_geo_blk(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('0123456789 '),SALT39.HygieneErrors.NotLength('7,0'),SALT39.HygieneErrors.NotWords('1,0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_cbsa(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_Invalid_Num(s2);
END;
EXPORT InValidFT_cbsa(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_cbsa(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('0123456789 '),SALT39.HygieneErrors.NotLength('5,4,0'),SALT39.HygieneErrors.NotWords('1,0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_tnt(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'DNPY '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_tnt(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'DNPY '))),~(LENGTH(TRIM(s)) = 1),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_tnt(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('DNPY '),SALT39.HygieneErrors.NotLength('1'),SALT39.HygieneErrors.NotWords('1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_valid_ssn(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'BFGORUZ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_valid_ssn(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'BFGORUZ '))),~(LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_valid_ssn(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('BFGORUZ '),SALT39.HygieneErrors.NotLength('1,0'),SALT39.HygieneErrors.NotWords('1,0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_jflag1(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'CLTU '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_jflag1(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'CLTU '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 1),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_jflag1(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('CLTU '),SALT39.HygieneErrors.NotLength('0,1'),SALT39.HygieneErrors.NotWords('0,1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_jflag2(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ABCD '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_jflag2(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABCD '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 1),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_jflag2(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('ABCD '),SALT39.HygieneErrors.NotLength('0,1'),SALT39.HygieneErrors.NotWords('0,1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_jflag3(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'C '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_jflag3(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'C '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 1),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_jflag3(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('C '),SALT39.HygieneErrors.NotLength('0,1'),SALT39.HygieneErrors.NotWords('0,1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_rawaid(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_Invalid_Num(s2);
END;
EXPORT InValidFT_rawaid(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 13),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_rawaid(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('0123456789 '),SALT39.HygieneErrors.NotLength('13'),SALT39.HygieneErrors.NotWords('1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_dodgy_tracking(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789KNU '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_dodgy_tracking(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789KNU '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 3),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_dodgy_tracking(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('0123456789KNU '),SALT39.HygieneErrors.NotLength('0,3'),SALT39.HygieneErrors.NotWords('0,1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_nid(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s0,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s1;
END;
EXPORT InValidFT_nid(SALT39.StrType s) := WHICH();
EXPORT InValidMessageFT_nid(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_address_ind(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s0,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s1;
END;
EXPORT InValidFT_address_ind(SALT39.StrType s) := WHICH();
EXPORT InValidMessageFT_address_ind(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_name_ind(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s0,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s1;
END;
EXPORT InValidFT_name_ind(SALT39.StrType s) := WHICH();
EXPORT InValidMessageFT_name_ind(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_persistent_record_id(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s0,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s1;
END;
EXPORT InValidFT_persistent_record_id(SALT39.StrType s) := WHICH();
EXPORT InValidMessageFT_persistent_record_id(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.Good);
 
EXPORT SALT39.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'did','rid','pflag1','pflag2','pflag3','src','dt_first_seen','dt_last_seen','dt_vendor_last_reported','dt_vendor_first_reported','dt_nonglb_last_seen','rec_type','vendor_id','phone','ssn','dob','title','fname','mname','lname','name_suffix','prim_range','predir','prim_name','suffix','postdir','unit_desig','sec_range','city_name','st','zip','zip4','county','geo_blk','cbsa','tnt','valid_ssn','jflag1','jflag2','jflag3','rawaid','dodgy_tracking','nid','address_ind','name_ind','persistent_record_id');
EXPORT SALT39.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'did','rid','pflag1','pflag2','pflag3','src','dt_first_seen','dt_last_seen','dt_vendor_last_reported','dt_vendor_first_reported','dt_nonglb_last_seen','rec_type','vendor_id','phone','ssn','dob','title','fname','mname','lname','name_suffix','prim_range','predir','prim_name','suffix','postdir','unit_desig','sec_range','city_name','st','zip','zip4','county','geo_blk','cbsa','tnt','valid_ssn','jflag1','jflag2','jflag3','rawaid','dodgy_tracking','nid','address_ind','name_ind','persistent_record_id');
EXPORT FieldNum(SALT39.StrType fn) := CASE(fn,'did' => 0,'rid' => 1,'pflag1' => 2,'pflag2' => 3,'pflag3' => 4,'src' => 5,'dt_first_seen' => 6,'dt_last_seen' => 7,'dt_vendor_last_reported' => 8,'dt_vendor_first_reported' => 9,'dt_nonglb_last_seen' => 10,'rec_type' => 11,'vendor_id' => 12,'phone' => 13,'ssn' => 14,'dob' => 15,'title' => 16,'fname' => 17,'mname' => 18,'lname' => 19,'name_suffix' => 20,'prim_range' => 21,'predir' => 22,'prim_name' => 23,'suffix' => 24,'postdir' => 25,'unit_desig' => 26,'sec_range' => 27,'city_name' => 28,'st' => 29,'zip' => 30,'zip4' => 31,'county' => 32,'geo_blk' => 33,'cbsa' => 34,'tnt' => 35,'valid_ssn' => 36,'jflag1' => 37,'jflag2' => 38,'jflag3' => 39,'rawaid' => 40,'dodgy_tracking' => 41,'nid' => 42,'address_ind' => 43,'name_ind' => 44,'persistent_record_id' => 45,0);
EXPORT SET OF SALT39.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['ALLOW','WORDS'],['ALLOW','WORDS'],['ALLOW','LENGTHS','WORDS'],['ALLOW','LENGTHS','WORDS'],['ALLOW','LENGTHS','WORDS'],['ALLOW','LENGTHS','WORDS'],['ALLOW','LENGTHS','WORDS'],['ALLOW','LENGTHS','WORDS'],['ALLOW','LENGTHS','WORDS'],['ALLOW','LENGTHS','WORDS'],['ALLOW','LENGTHS','WORDS'],['ALLOW','LENGTHS','WORDS'],['ALLOW','WORDS'],['ALLOW','WORDS'],['ALLOW','LENGTHS','WORDS'],['ALLOW','LENGTHS','WORDS'],['ALLOW','LENGTHS'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW','LENGTHS','WORDS'],['ALLOW','LENGTHS','WORDS'],['ALLOW','LENGTHS','WORDS'],['ALLOW','LENGTHS','WORDS'],['ALLOW','LENGTHS','WORDS'],['ALLOW','LENGTHS','WORDS'],['ALLOW','LENGTHS','WORDS'],['ALLOW','LENGTHS','WORDS'],['ALLOW','LENGTHS','WORDS'],['ALLOW','LENGTHS','WORDS'],['ALLOW','LENGTHS','WORDS'],['ALLOW','LENGTHS','WORDS'],[],[],[],[],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_did(SALT39.StrType s0) := MakeFT_did(s0);
EXPORT InValid_did(SALT39.StrType s) := InValidFT_did(s);
EXPORT InValidMessage_did(UNSIGNED1 wh) := InValidMessageFT_did(wh);
 
EXPORT Make_rid(SALT39.StrType s0) := MakeFT_rid(s0);
EXPORT InValid_rid(SALT39.StrType s) := InValidFT_rid(s);
EXPORT InValidMessage_rid(UNSIGNED1 wh) := InValidMessageFT_rid(wh);
 
EXPORT Make_pflag1(SALT39.StrType s0) := MakeFT_pflag1(s0);
EXPORT InValid_pflag1(SALT39.StrType s) := InValidFT_pflag1(s);
EXPORT InValidMessage_pflag1(UNSIGNED1 wh) := InValidMessageFT_pflag1(wh);
 
EXPORT Make_pflag2(SALT39.StrType s0) := MakeFT_pflag2(s0);
EXPORT InValid_pflag2(SALT39.StrType s) := InValidFT_pflag2(s);
EXPORT InValidMessage_pflag2(UNSIGNED1 wh) := InValidMessageFT_pflag2(wh);
 
EXPORT Make_pflag3(SALT39.StrType s0) := MakeFT_pflag3(s0);
EXPORT InValid_pflag3(SALT39.StrType s) := InValidFT_pflag3(s);
EXPORT InValidMessage_pflag3(UNSIGNED1 wh) := InValidMessageFT_pflag3(wh);
 
EXPORT Make_src(SALT39.StrType s0) := MakeFT_src(s0);
EXPORT InValid_src(SALT39.StrType s) := InValidFT_src(s);
EXPORT InValidMessage_src(UNSIGNED1 wh) := InValidMessageFT_src(wh);
 
EXPORT Make_dt_first_seen(SALT39.StrType s0) := MakeFT_dt_first_seen(s0);
EXPORT InValid_dt_first_seen(SALT39.StrType s) := InValidFT_dt_first_seen(s);
EXPORT InValidMessage_dt_first_seen(UNSIGNED1 wh) := InValidMessageFT_dt_first_seen(wh);
 
EXPORT Make_dt_last_seen(SALT39.StrType s0) := MakeFT_dt_last_seen(s0);
EXPORT InValid_dt_last_seen(SALT39.StrType s) := InValidFT_dt_last_seen(s);
EXPORT InValidMessage_dt_last_seen(UNSIGNED1 wh) := InValidMessageFT_dt_last_seen(wh);
 
EXPORT Make_dt_vendor_last_reported(SALT39.StrType s0) := MakeFT_dt_vendor_last_reported(s0);
EXPORT InValid_dt_vendor_last_reported(SALT39.StrType s) := InValidFT_dt_vendor_last_reported(s);
EXPORT InValidMessage_dt_vendor_last_reported(UNSIGNED1 wh) := InValidMessageFT_dt_vendor_last_reported(wh);
 
EXPORT Make_dt_vendor_first_reported(SALT39.StrType s0) := MakeFT_dt_vendor_first_reported(s0);
EXPORT InValid_dt_vendor_first_reported(SALT39.StrType s) := InValidFT_dt_vendor_first_reported(s);
EXPORT InValidMessage_dt_vendor_first_reported(UNSIGNED1 wh) := InValidMessageFT_dt_vendor_first_reported(wh);
 
EXPORT Make_dt_nonglb_last_seen(SALT39.StrType s0) := MakeFT_dt_nonglb_last_seen(s0);
EXPORT InValid_dt_nonglb_last_seen(SALT39.StrType s) := InValidFT_dt_nonglb_last_seen(s);
EXPORT InValidMessage_dt_nonglb_last_seen(UNSIGNED1 wh) := InValidMessageFT_dt_nonglb_last_seen(wh);
 
EXPORT Make_rec_type(SALT39.StrType s0) := MakeFT_rec_type(s0);
EXPORT InValid_rec_type(SALT39.StrType s) := InValidFT_rec_type(s);
EXPORT InValidMessage_rec_type(UNSIGNED1 wh) := InValidMessageFT_rec_type(wh);
 
EXPORT Make_vendor_id(SALT39.StrType s0) := MakeFT_vendor_id(s0);
EXPORT InValid_vendor_id(SALT39.StrType s) := InValidFT_vendor_id(s);
EXPORT InValidMessage_vendor_id(UNSIGNED1 wh) := InValidMessageFT_vendor_id(wh);
 
EXPORT Make_phone(SALT39.StrType s0) := MakeFT_phone(s0);
EXPORT InValid_phone(SALT39.StrType s) := InValidFT_phone(s);
EXPORT InValidMessage_phone(UNSIGNED1 wh) := InValidMessageFT_phone(wh);
 
EXPORT Make_ssn(SALT39.StrType s0) := MakeFT_ssn(s0);
EXPORT InValid_ssn(SALT39.StrType s) := InValidFT_ssn(s);
EXPORT InValidMessage_ssn(UNSIGNED1 wh) := InValidMessageFT_ssn(wh);
 
EXPORT Make_dob(SALT39.StrType s0) := MakeFT_dob(s0);
EXPORT InValid_dob(SALT39.StrType s) := InValidFT_dob(s);
EXPORT InValidMessage_dob(UNSIGNED1 wh) := InValidMessageFT_dob(wh);
 
EXPORT Make_title(SALT39.StrType s0) := MakeFT_title(s0);
EXPORT InValid_title(SALT39.StrType s) := InValidFT_title(s);
EXPORT InValidMessage_title(UNSIGNED1 wh) := InValidMessageFT_title(wh);
 
EXPORT Make_fname(SALT39.StrType s0) := MakeFT_fname(s0);
EXPORT InValid_fname(SALT39.StrType s) := InValidFT_fname(s);
EXPORT InValidMessage_fname(UNSIGNED1 wh) := InValidMessageFT_fname(wh);
 
EXPORT Make_mname(SALT39.StrType s0) := MakeFT_mname(s0);
EXPORT InValid_mname(SALT39.StrType s) := InValidFT_mname(s);
EXPORT InValidMessage_mname(UNSIGNED1 wh) := InValidMessageFT_mname(wh);
 
EXPORT Make_lname(SALT39.StrType s0) := MakeFT_lname(s0);
EXPORT InValid_lname(SALT39.StrType s) := InValidFT_lname(s);
EXPORT InValidMessage_lname(UNSIGNED1 wh) := InValidMessageFT_lname(wh);
 
EXPORT Make_name_suffix(SALT39.StrType s0) := MakeFT_name_suffix(s0);
EXPORT InValid_name_suffix(SALT39.StrType s) := InValidFT_name_suffix(s);
EXPORT InValidMessage_name_suffix(UNSIGNED1 wh) := InValidMessageFT_name_suffix(wh);
 
EXPORT Make_prim_range(SALT39.StrType s0) := MakeFT_prim_range(s0);
EXPORT InValid_prim_range(SALT39.StrType s) := InValidFT_prim_range(s);
EXPORT InValidMessage_prim_range(UNSIGNED1 wh) := InValidMessageFT_prim_range(wh);
 
EXPORT Make_predir(SALT39.StrType s0) := MakeFT_predir(s0);
EXPORT InValid_predir(SALT39.StrType s) := InValidFT_predir(s);
EXPORT InValidMessage_predir(UNSIGNED1 wh) := InValidMessageFT_predir(wh);
 
EXPORT Make_prim_name(SALT39.StrType s0) := MakeFT_prim_name(s0);
EXPORT InValid_prim_name(SALT39.StrType s) := InValidFT_prim_name(s);
EXPORT InValidMessage_prim_name(UNSIGNED1 wh) := InValidMessageFT_prim_name(wh);
 
EXPORT Make_suffix(SALT39.StrType s0) := MakeFT_suffix(s0);
EXPORT InValid_suffix(SALT39.StrType s) := InValidFT_suffix(s);
EXPORT InValidMessage_suffix(UNSIGNED1 wh) := InValidMessageFT_suffix(wh);
 
EXPORT Make_postdir(SALT39.StrType s0) := MakeFT_postdir(s0);
EXPORT InValid_postdir(SALT39.StrType s) := InValidFT_postdir(s);
EXPORT InValidMessage_postdir(UNSIGNED1 wh) := InValidMessageFT_postdir(wh);
 
EXPORT Make_unit_desig(SALT39.StrType s0) := MakeFT_unit_desig(s0);
EXPORT InValid_unit_desig(SALT39.StrType s) := InValidFT_unit_desig(s);
EXPORT InValidMessage_unit_desig(UNSIGNED1 wh) := InValidMessageFT_unit_desig(wh);
 
EXPORT Make_sec_range(SALT39.StrType s0) := MakeFT_sec_range(s0);
EXPORT InValid_sec_range(SALT39.StrType s) := InValidFT_sec_range(s);
EXPORT InValidMessage_sec_range(UNSIGNED1 wh) := InValidMessageFT_sec_range(wh);
 
EXPORT Make_city_name(SALT39.StrType s0) := MakeFT_city_name(s0);
EXPORT InValid_city_name(SALT39.StrType s) := InValidFT_city_name(s);
EXPORT InValidMessage_city_name(UNSIGNED1 wh) := InValidMessageFT_city_name(wh);
 
EXPORT Make_st(SALT39.StrType s0) := MakeFT_st(s0);
EXPORT InValid_st(SALT39.StrType s) := InValidFT_st(s);
EXPORT InValidMessage_st(UNSIGNED1 wh) := InValidMessageFT_st(wh);
 
EXPORT Make_zip(SALT39.StrType s0) := MakeFT_zip(s0);
EXPORT InValid_zip(SALT39.StrType s) := InValidFT_zip(s);
EXPORT InValidMessage_zip(UNSIGNED1 wh) := InValidMessageFT_zip(wh);
 
EXPORT Make_zip4(SALT39.StrType s0) := MakeFT_zip4(s0);
EXPORT InValid_zip4(SALT39.StrType s) := InValidFT_zip4(s);
EXPORT InValidMessage_zip4(UNSIGNED1 wh) := InValidMessageFT_zip4(wh);
 
EXPORT Make_county(SALT39.StrType s0) := MakeFT_county(s0);
EXPORT InValid_county(SALT39.StrType s) := InValidFT_county(s);
EXPORT InValidMessage_county(UNSIGNED1 wh) := InValidMessageFT_county(wh);
 
EXPORT Make_geo_blk(SALT39.StrType s0) := MakeFT_geo_blk(s0);
EXPORT InValid_geo_blk(SALT39.StrType s) := InValidFT_geo_blk(s);
EXPORT InValidMessage_geo_blk(UNSIGNED1 wh) := InValidMessageFT_geo_blk(wh);
 
EXPORT Make_cbsa(SALT39.StrType s0) := MakeFT_cbsa(s0);
EXPORT InValid_cbsa(SALT39.StrType s) := InValidFT_cbsa(s);
EXPORT InValidMessage_cbsa(UNSIGNED1 wh) := InValidMessageFT_cbsa(wh);
 
EXPORT Make_tnt(SALT39.StrType s0) := MakeFT_tnt(s0);
EXPORT InValid_tnt(SALT39.StrType s) := InValidFT_tnt(s);
EXPORT InValidMessage_tnt(UNSIGNED1 wh) := InValidMessageFT_tnt(wh);
 
EXPORT Make_valid_ssn(SALT39.StrType s0) := MakeFT_valid_ssn(s0);
EXPORT InValid_valid_ssn(SALT39.StrType s) := InValidFT_valid_ssn(s);
EXPORT InValidMessage_valid_ssn(UNSIGNED1 wh) := InValidMessageFT_valid_ssn(wh);
 
EXPORT Make_jflag1(SALT39.StrType s0) := MakeFT_jflag1(s0);
EXPORT InValid_jflag1(SALT39.StrType s) := InValidFT_jflag1(s);
EXPORT InValidMessage_jflag1(UNSIGNED1 wh) := InValidMessageFT_jflag1(wh);
 
EXPORT Make_jflag2(SALT39.StrType s0) := MakeFT_jflag2(s0);
EXPORT InValid_jflag2(SALT39.StrType s) := InValidFT_jflag2(s);
EXPORT InValidMessage_jflag2(UNSIGNED1 wh) := InValidMessageFT_jflag2(wh);
 
EXPORT Make_jflag3(SALT39.StrType s0) := MakeFT_jflag3(s0);
EXPORT InValid_jflag3(SALT39.StrType s) := InValidFT_jflag3(s);
EXPORT InValidMessage_jflag3(UNSIGNED1 wh) := InValidMessageFT_jflag3(wh);
 
EXPORT Make_rawaid(SALT39.StrType s0) := MakeFT_rawaid(s0);
EXPORT InValid_rawaid(SALT39.StrType s) := InValidFT_rawaid(s);
EXPORT InValidMessage_rawaid(UNSIGNED1 wh) := InValidMessageFT_rawaid(wh);
 
EXPORT Make_dodgy_tracking(SALT39.StrType s0) := MakeFT_dodgy_tracking(s0);
EXPORT InValid_dodgy_tracking(SALT39.StrType s) := InValidFT_dodgy_tracking(s);
EXPORT InValidMessage_dodgy_tracking(UNSIGNED1 wh) := InValidMessageFT_dodgy_tracking(wh);
 
EXPORT Make_nid(SALT39.StrType s0) := MakeFT_nid(s0);
EXPORT InValid_nid(SALT39.StrType s) := InValidFT_nid(s);
EXPORT InValidMessage_nid(UNSIGNED1 wh) := InValidMessageFT_nid(wh);
 
EXPORT Make_address_ind(SALT39.StrType s0) := MakeFT_address_ind(s0);
EXPORT InValid_address_ind(SALT39.StrType s) := InValidFT_address_ind(s);
EXPORT InValidMessage_address_ind(UNSIGNED1 wh) := InValidMessageFT_address_ind(wh);
 
EXPORT Make_name_ind(SALT39.StrType s0) := MakeFT_name_ind(s0);
EXPORT InValid_name_ind(SALT39.StrType s) := InValidFT_name_ind(s);
EXPORT InValidMessage_name_ind(UNSIGNED1 wh) := InValidMessageFT_name_ind(wh);
 
EXPORT Make_persistent_record_id(SALT39.StrType s0) := MakeFT_persistent_record_id(s0);
EXPORT InValid_persistent_record_id(SALT39.StrType s) := InValidFT_persistent_record_id(s);
EXPORT InValidMessage_persistent_record_id(UNSIGNED1 wh) := InValidMessageFT_persistent_record_id(wh);
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT39,Scrubs_Headers_Monthly;
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
    BOOLEAN Diff_did;
    BOOLEAN Diff_rid;
    BOOLEAN Diff_pflag1;
    BOOLEAN Diff_pflag2;
    BOOLEAN Diff_pflag3;
    BOOLEAN Diff_src;
    BOOLEAN Diff_dt_first_seen;
    BOOLEAN Diff_dt_last_seen;
    BOOLEAN Diff_dt_vendor_last_reported;
    BOOLEAN Diff_dt_vendor_first_reported;
    BOOLEAN Diff_dt_nonglb_last_seen;
    BOOLEAN Diff_rec_type;
    BOOLEAN Diff_vendor_id;
    BOOLEAN Diff_phone;
    BOOLEAN Diff_ssn;
    BOOLEAN Diff_dob;
    BOOLEAN Diff_title;
    BOOLEAN Diff_fname;
    BOOLEAN Diff_mname;
    BOOLEAN Diff_lname;
    BOOLEAN Diff_name_suffix;
    BOOLEAN Diff_prim_range;
    BOOLEAN Diff_predir;
    BOOLEAN Diff_prim_name;
    BOOLEAN Diff_suffix;
    BOOLEAN Diff_postdir;
    BOOLEAN Diff_unit_desig;
    BOOLEAN Diff_sec_range;
    BOOLEAN Diff_city_name;
    BOOLEAN Diff_st;
    BOOLEAN Diff_zip;
    BOOLEAN Diff_zip4;
    BOOLEAN Diff_county;
    BOOLEAN Diff_geo_blk;
    BOOLEAN Diff_cbsa;
    BOOLEAN Diff_tnt;
    BOOLEAN Diff_valid_ssn;
    BOOLEAN Diff_jflag1;
    BOOLEAN Diff_jflag2;
    BOOLEAN Diff_jflag3;
    BOOLEAN Diff_rawaid;
    BOOLEAN Diff_dodgy_tracking;
    BOOLEAN Diff_nid;
    BOOLEAN Diff_address_ind;
    BOOLEAN Diff_name_ind;
    BOOLEAN Diff_persistent_record_id;
    UNSIGNED Num_Diffs;
    SALT39.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_did := le.did <> ri.did;
    SELF.Diff_rid := le.rid <> ri.rid;
    SELF.Diff_pflag1 := le.pflag1 <> ri.pflag1;
    SELF.Diff_pflag2 := le.pflag2 <> ri.pflag2;
    SELF.Diff_pflag3 := le.pflag3 <> ri.pflag3;
    SELF.Diff_src := le.src <> ri.src;
    SELF.Diff_dt_first_seen := le.dt_first_seen <> ri.dt_first_seen;
    SELF.Diff_dt_last_seen := le.dt_last_seen <> ri.dt_last_seen;
    SELF.Diff_dt_vendor_last_reported := le.dt_vendor_last_reported <> ri.dt_vendor_last_reported;
    SELF.Diff_dt_vendor_first_reported := le.dt_vendor_first_reported <> ri.dt_vendor_first_reported;
    SELF.Diff_dt_nonglb_last_seen := le.dt_nonglb_last_seen <> ri.dt_nonglb_last_seen;
    SELF.Diff_rec_type := le.rec_type <> ri.rec_type;
    SELF.Diff_vendor_id := le.vendor_id <> ri.vendor_id;
    SELF.Diff_phone := le.phone <> ri.phone;
    SELF.Diff_ssn := le.ssn <> ri.ssn;
    SELF.Diff_dob := le.dob <> ri.dob;
    SELF.Diff_title := le.title <> ri.title;
    SELF.Diff_fname := le.fname <> ri.fname;
    SELF.Diff_mname := le.mname <> ri.mname;
    SELF.Diff_lname := le.lname <> ri.lname;
    SELF.Diff_name_suffix := le.name_suffix <> ri.name_suffix;
    SELF.Diff_prim_range := le.prim_range <> ri.prim_range;
    SELF.Diff_predir := le.predir <> ri.predir;
    SELF.Diff_prim_name := le.prim_name <> ri.prim_name;
    SELF.Diff_suffix := le.suffix <> ri.suffix;
    SELF.Diff_postdir := le.postdir <> ri.postdir;
    SELF.Diff_unit_desig := le.unit_desig <> ri.unit_desig;
    SELF.Diff_sec_range := le.sec_range <> ri.sec_range;
    SELF.Diff_city_name := le.city_name <> ri.city_name;
    SELF.Diff_st := le.st <> ri.st;
    SELF.Diff_zip := le.zip <> ri.zip;
    SELF.Diff_zip4 := le.zip4 <> ri.zip4;
    SELF.Diff_county := le.county <> ri.county;
    SELF.Diff_geo_blk := le.geo_blk <> ri.geo_blk;
    SELF.Diff_cbsa := le.cbsa <> ri.cbsa;
    SELF.Diff_tnt := le.tnt <> ri.tnt;
    SELF.Diff_valid_ssn := le.valid_ssn <> ri.valid_ssn;
    SELF.Diff_jflag1 := le.jflag1 <> ri.jflag1;
    SELF.Diff_jflag2 := le.jflag2 <> ri.jflag2;
    SELF.Diff_jflag3 := le.jflag3 <> ri.jflag3;
    SELF.Diff_rawaid := le.rawaid <> ri.rawaid;
    SELF.Diff_dodgy_tracking := le.dodgy_tracking <> ri.dodgy_tracking;
    SELF.Diff_nid := le.nid <> ri.nid;
    SELF.Diff_address_ind := le.address_ind <> ri.address_ind;
    SELF.Diff_name_ind := le.name_ind <> ri.name_ind;
    SELF.Diff_persistent_record_id := le.persistent_record_id <> ri.persistent_record_id;
    SELF.Val := (SALT39.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_did,1,0)+ IF( SELF.Diff_rid,1,0)+ IF( SELF.Diff_pflag1,1,0)+ IF( SELF.Diff_pflag2,1,0)+ IF( SELF.Diff_pflag3,1,0)+ IF( SELF.Diff_src,1,0)+ IF( SELF.Diff_dt_first_seen,1,0)+ IF( SELF.Diff_dt_last_seen,1,0)+ IF( SELF.Diff_dt_vendor_last_reported,1,0)+ IF( SELF.Diff_dt_vendor_first_reported,1,0)+ IF( SELF.Diff_dt_nonglb_last_seen,1,0)+ IF( SELF.Diff_rec_type,1,0)+ IF( SELF.Diff_vendor_id,1,0)+ IF( SELF.Diff_phone,1,0)+ IF( SELF.Diff_ssn,1,0)+ IF( SELF.Diff_dob,1,0)+ IF( SELF.Diff_title,1,0)+ IF( SELF.Diff_fname,1,0)+ IF( SELF.Diff_mname,1,0)+ IF( SELF.Diff_lname,1,0)+ IF( SELF.Diff_name_suffix,1,0)+ IF( SELF.Diff_prim_range,1,0)+ IF( SELF.Diff_predir,1,0)+ IF( SELF.Diff_prim_name,1,0)+ IF( SELF.Diff_suffix,1,0)+ IF( SELF.Diff_postdir,1,0)+ IF( SELF.Diff_unit_desig,1,0)+ IF( SELF.Diff_sec_range,1,0)+ IF( SELF.Diff_city_name,1,0)+ IF( SELF.Diff_st,1,0)+ IF( SELF.Diff_zip,1,0)+ IF( SELF.Diff_zip4,1,0)+ IF( SELF.Diff_county,1,0)+ IF( SELF.Diff_geo_blk,1,0)+ IF( SELF.Diff_cbsa,1,0)+ IF( SELF.Diff_tnt,1,0)+ IF( SELF.Diff_valid_ssn,1,0)+ IF( SELF.Diff_jflag1,1,0)+ IF( SELF.Diff_jflag2,1,0)+ IF( SELF.Diff_jflag3,1,0)+ IF( SELF.Diff_rawaid,1,0)+ IF( SELF.Diff_dodgy_tracking,1,0)+ IF( SELF.Diff_nid,1,0)+ IF( SELF.Diff_address_ind,1,0)+ IF( SELF.Diff_name_ind,1,0)+ IF( SELF.Diff_persistent_record_id,1,0);
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
    Count_Diff_did := COUNT(GROUP,%Closest%.Diff_did);
    Count_Diff_rid := COUNT(GROUP,%Closest%.Diff_rid);
    Count_Diff_pflag1 := COUNT(GROUP,%Closest%.Diff_pflag1);
    Count_Diff_pflag2 := COUNT(GROUP,%Closest%.Diff_pflag2);
    Count_Diff_pflag3 := COUNT(GROUP,%Closest%.Diff_pflag3);
    Count_Diff_src := COUNT(GROUP,%Closest%.Diff_src);
    Count_Diff_dt_first_seen := COUNT(GROUP,%Closest%.Diff_dt_first_seen);
    Count_Diff_dt_last_seen := COUNT(GROUP,%Closest%.Diff_dt_last_seen);
    Count_Diff_dt_vendor_last_reported := COUNT(GROUP,%Closest%.Diff_dt_vendor_last_reported);
    Count_Diff_dt_vendor_first_reported := COUNT(GROUP,%Closest%.Diff_dt_vendor_first_reported);
    Count_Diff_dt_nonglb_last_seen := COUNT(GROUP,%Closest%.Diff_dt_nonglb_last_seen);
    Count_Diff_rec_type := COUNT(GROUP,%Closest%.Diff_rec_type);
    Count_Diff_vendor_id := COUNT(GROUP,%Closest%.Diff_vendor_id);
    Count_Diff_phone := COUNT(GROUP,%Closest%.Diff_phone);
    Count_Diff_ssn := COUNT(GROUP,%Closest%.Diff_ssn);
    Count_Diff_dob := COUNT(GROUP,%Closest%.Diff_dob);
    Count_Diff_title := COUNT(GROUP,%Closest%.Diff_title);
    Count_Diff_fname := COUNT(GROUP,%Closest%.Diff_fname);
    Count_Diff_mname := COUNT(GROUP,%Closest%.Diff_mname);
    Count_Diff_lname := COUNT(GROUP,%Closest%.Diff_lname);
    Count_Diff_name_suffix := COUNT(GROUP,%Closest%.Diff_name_suffix);
    Count_Diff_prim_range := COUNT(GROUP,%Closest%.Diff_prim_range);
    Count_Diff_predir := COUNT(GROUP,%Closest%.Diff_predir);
    Count_Diff_prim_name := COUNT(GROUP,%Closest%.Diff_prim_name);
    Count_Diff_suffix := COUNT(GROUP,%Closest%.Diff_suffix);
    Count_Diff_postdir := COUNT(GROUP,%Closest%.Diff_postdir);
    Count_Diff_unit_desig := COUNT(GROUP,%Closest%.Diff_unit_desig);
    Count_Diff_sec_range := COUNT(GROUP,%Closest%.Diff_sec_range);
    Count_Diff_city_name := COUNT(GROUP,%Closest%.Diff_city_name);
    Count_Diff_st := COUNT(GROUP,%Closest%.Diff_st);
    Count_Diff_zip := COUNT(GROUP,%Closest%.Diff_zip);
    Count_Diff_zip4 := COUNT(GROUP,%Closest%.Diff_zip4);
    Count_Diff_county := COUNT(GROUP,%Closest%.Diff_county);
    Count_Diff_geo_blk := COUNT(GROUP,%Closest%.Diff_geo_blk);
    Count_Diff_cbsa := COUNT(GROUP,%Closest%.Diff_cbsa);
    Count_Diff_tnt := COUNT(GROUP,%Closest%.Diff_tnt);
    Count_Diff_valid_ssn := COUNT(GROUP,%Closest%.Diff_valid_ssn);
    Count_Diff_jflag1 := COUNT(GROUP,%Closest%.Diff_jflag1);
    Count_Diff_jflag2 := COUNT(GROUP,%Closest%.Diff_jflag2);
    Count_Diff_jflag3 := COUNT(GROUP,%Closest%.Diff_jflag3);
    Count_Diff_rawaid := COUNT(GROUP,%Closest%.Diff_rawaid);
    Count_Diff_dodgy_tracking := COUNT(GROUP,%Closest%.Diff_dodgy_tracking);
    Count_Diff_nid := COUNT(GROUP,%Closest%.Diff_nid);
    Count_Diff_address_ind := COUNT(GROUP,%Closest%.Diff_address_ind);
    Count_Diff_name_ind := COUNT(GROUP,%Closest%.Diff_name_ind);
    Count_Diff_persistent_record_id := COUNT(GROUP,%Closest%.Diff_persistent_record_id);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
