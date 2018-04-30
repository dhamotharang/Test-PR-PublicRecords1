IMPORT SALT39;
EXPORT Fields := MODULE
 
EXPORT NumFields := 88;
 
// Processing for each FieldType
EXPORT SALT39.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'Invalid_Alpha','Invalid_Num','type','confidence','did1','did2','cohabit_score','cohabit_cnt','coapt_score','coapt_cnt','copobox_score','copobox_cnt','cossn_score','cossn_cnt','copolicy_score','copolicy_cnt','coclaim_score','coclaim_cnt','coproperty_score','coproperty_cnt','bcoproperty_score','bcoproperty_cnt','coforeclosure_score','coforeclosure_cnt','bcoforeclosure_score','bcoforeclosure_cnt','colien_score','colien_cnt','bcolien_score','bcolien_cnt','cobankruptcy_score','cobankruptcy_cnt','bcobankruptcy_score','bcobankruptcy_cnt','covehicle_score','covehicle_cnt','coexperian_score','coexperian_cnt','cotransunion_score','cotransunion_cnt','coenclarity_score','coenclarity_cnt','coecrash_score','coecrash_cnt','bcoecrash_score','bcoecrash_cnt','cowatercraft_score','cowatercraft_cnt','coaircraft_score','coaircraft_cnt','comarriagedivorce_score','comarriagedivorce_cnt','coucc_score','coucc_cnt','lname_score','phone_score','dl_nbr_score','total_cnt','total_score','cluster','generation','gender','lname_cnt','rel_dt_first_seen','rel_dt_last_seen','overlap_months','hdr_dt_first_seen','hdr_dt_last_seen','age_first_seen','isanylnamematch','isanyphonematch','isearlylnamematch','iscurrlnamematch','ismixedlnamematch','ssn1','ssn2','dob1','dob2','current_lname1','current_lname2','early_lname1','early_lname2','addr_ind1','addr_ind2','r2rdid','r2cnt','personal','business','other','title');
EXPORT FieldTypeNum(SALT39.StrType fn) := CASE(fn,'Invalid_Alpha' => 1,'Invalid_Num' => 2,'type' => 3,'confidence' => 4,'did1' => 5,'did2' => 6,'cohabit_score' => 7,'cohabit_cnt' => 8,'coapt_score' => 9,'coapt_cnt' => 10,'copobox_score' => 11,'copobox_cnt' => 12,'cossn_score' => 13,'cossn_cnt' => 14,'copolicy_score' => 15,'copolicy_cnt' => 16,'coclaim_score' => 17,'coclaim_cnt' => 18,'coproperty_score' => 19,'coproperty_cnt' => 20,'bcoproperty_score' => 21,'bcoproperty_cnt' => 22,'coforeclosure_score' => 23,'coforeclosure_cnt' => 24,'bcoforeclosure_score' => 25,'bcoforeclosure_cnt' => 26,'colien_score' => 27,'colien_cnt' => 28,'bcolien_score' => 29,'bcolien_cnt' => 30,'cobankruptcy_score' => 31,'cobankruptcy_cnt' => 32,'bcobankruptcy_score' => 33,'bcobankruptcy_cnt' => 34,'covehicle_score' => 35,'covehicle_cnt' => 36,'coexperian_score' => 37,'coexperian_cnt' => 38,'cotransunion_score' => 39,'cotransunion_cnt' => 40,'coenclarity_score' => 41,'coenclarity_cnt' => 42,'coecrash_score' => 43,'coecrash_cnt' => 44,'bcoecrash_score' => 45,'bcoecrash_cnt' => 46,'cowatercraft_score' => 47,'cowatercraft_cnt' => 48,'coaircraft_score' => 49,'coaircraft_cnt' => 50,'comarriagedivorce_score' => 51,'comarriagedivorce_cnt' => 52,'coucc_score' => 53,'coucc_cnt' => 54,'lname_score' => 55,'phone_score' => 56,'dl_nbr_score' => 57,'total_cnt' => 58,'total_score' => 59,'cluster' => 60,'generation' => 61,'gender' => 62,'lname_cnt' => 63,'rel_dt_first_seen' => 64,'rel_dt_last_seen' => 65,'overlap_months' => 66,'hdr_dt_first_seen' => 67,'hdr_dt_last_seen' => 68,'age_first_seen' => 69,'isanylnamematch' => 70,'isanyphonematch' => 71,'isearlylnamematch' => 72,'iscurrlnamematch' => 73,'ismixedlnamematch' => 74,'ssn1' => 75,'ssn2' => 76,'dob1' => 77,'dob2' => 78,'current_lname1' => 79,'current_lname2' => 80,'early_lname1' => 81,'early_lname2' => 82,'addr_ind1' => 83,'addr_ind2' => 84,'r2rdid' => 85,'r2cnt' => 86,'personal' => 87,'business' => 88,'other' => 89,'title' => 90,0);
 
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
 
EXPORT MakeFT_type(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Only allow valid symbols
  RETURN  MakeFT_Invalid_Alpha(s1);
END;
EXPORT InValidFT_type(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'))));
EXPORT InValidMessageFT_type(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_confidence(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_Invalid_Alpha(s2);
END;
EXPORT InValidFT_confidence(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ '))),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_confidence(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT39.HygieneErrors.NotWords('1,0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_did1(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_Invalid_Num(s2);
END;
EXPORT InValidFT_did1(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789 '))),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_did1(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('0123456789 '),SALT39.HygieneErrors.NotWords('1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_did2(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_Invalid_Num(s2);
END;
EXPORT InValidFT_did2(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789 '))),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_did2(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('0123456789 '),SALT39.HygieneErrors.NotWords('1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_cohabit_score(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_Invalid_Num(s2);
END;
EXPORT InValidFT_cohabit_score(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789 '))),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_cohabit_score(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('0123456789 '),SALT39.HygieneErrors.NotWords('0,1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_cohabit_cnt(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_Invalid_Num(s2);
END;
EXPORT InValidFT_cohabit_cnt(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 1),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_cohabit_cnt(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('0123456789 '),SALT39.HygieneErrors.NotLength('0,1'),SALT39.HygieneErrors.NotWords('0,1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_coapt_score(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_Invalid_Num(s2);
END;
EXPORT InValidFT_coapt_score(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 3),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_coapt_score(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('0123456789 '),SALT39.HygieneErrors.NotLength('0,2,3'),SALT39.HygieneErrors.NotWords('0,1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_coapt_cnt(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_Invalid_Num(s2);
END;
EXPORT InValidFT_coapt_cnt(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 1),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_coapt_cnt(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('0123456789 '),SALT39.HygieneErrors.NotLength('0,1'),SALT39.HygieneErrors.NotWords('0,1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_copobox_score(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_Invalid_Num(s2);
END;
EXPORT InValidFT_copobox_score(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 2),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_copobox_score(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('0123456789 '),SALT39.HygieneErrors.NotLength('0,2'),SALT39.HygieneErrors.NotWords('0,1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_copobox_cnt(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_Invalid_Num(s2);
END;
EXPORT InValidFT_copobox_cnt(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 2),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_copobox_cnt(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('0123456789 '),SALT39.HygieneErrors.NotLength('0,1,2'),SALT39.HygieneErrors.NotWords('0,1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_cossn_score(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_Invalid_Num(s2);
END;
EXPORT InValidFT_cossn_score(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 2),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_cossn_score(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('0123456789 '),SALT39.HygieneErrors.NotLength('0,2'),SALT39.HygieneErrors.NotWords('0,1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_cossn_cnt(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_Invalid_Num(s2);
END;
EXPORT InValidFT_cossn_cnt(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 1),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_cossn_cnt(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('0123456789 '),SALT39.HygieneErrors.NotLength('0,1'),SALT39.HygieneErrors.NotWords('0,1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_copolicy_score(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_Invalid_Num(s2);
END;
EXPORT InValidFT_copolicy_score(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 3),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_copolicy_score(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('0123456789 '),SALT39.HygieneErrors.NotLength('0,2,3'),SALT39.HygieneErrors.NotWords('0,1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_copolicy_cnt(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_Invalid_Num(s2);
END;
EXPORT InValidFT_copolicy_cnt(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 2),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_copolicy_cnt(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('0123456789 '),SALT39.HygieneErrors.NotLength('0,1,2'),SALT39.HygieneErrors.NotWords('0,1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_coclaim_score(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_Invalid_Num(s2);
END;
EXPORT InValidFT_coclaim_score(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 3),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_coclaim_score(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('0123456789 '),SALT39.HygieneErrors.NotLength('0,2,3'),SALT39.HygieneErrors.NotWords('0,1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_coclaim_cnt(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_Invalid_Num(s2);
END;
EXPORT InValidFT_coclaim_cnt(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 1),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_coclaim_cnt(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('0123456789 '),SALT39.HygieneErrors.NotLength('0,1'),SALT39.HygieneErrors.NotWords('0,1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_coproperty_score(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_Invalid_Num(s2);
END;
EXPORT InValidFT_coproperty_score(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 3),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_coproperty_score(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('0123456789 '),SALT39.HygieneErrors.NotLength('0,2,3'),SALT39.HygieneErrors.NotWords('0,1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_coproperty_cnt(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_Invalid_Num(s2);
END;
EXPORT InValidFT_coproperty_cnt(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 1),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_coproperty_cnt(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('0123456789 '),SALT39.HygieneErrors.NotLength('0,1'),SALT39.HygieneErrors.NotWords('0,1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_bcoproperty_score(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_Invalid_Num(s2);
END;
EXPORT InValidFT_bcoproperty_score(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 2),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_bcoproperty_score(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('0123456789 '),SALT39.HygieneErrors.NotLength('0,2'),SALT39.HygieneErrors.NotWords('0,1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_bcoproperty_cnt(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_Invalid_Num(s2);
END;
EXPORT InValidFT_bcoproperty_cnt(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 1),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_bcoproperty_cnt(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('0123456789 '),SALT39.HygieneErrors.NotLength('0,1'),SALT39.HygieneErrors.NotWords('0,1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_coforeclosure_score(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_Invalid_Num(s2);
END;
EXPORT InValidFT_coforeclosure_score(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789 '))));
EXPORT InValidMessageFT_coforeclosure_score(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('0123456789 '),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_coforeclosure_cnt(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_Invalid_Num(s2);
END;
EXPORT InValidFT_coforeclosure_cnt(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789 '))));
EXPORT InValidMessageFT_coforeclosure_cnt(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('0123456789 '),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_bcoforeclosure_score(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_Invalid_Num(s2);
END;
EXPORT InValidFT_bcoforeclosure_score(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789 '))));
EXPORT InValidMessageFT_bcoforeclosure_score(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('0123456789 '),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_bcoforeclosure_cnt(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_Invalid_Num(s2);
END;
EXPORT InValidFT_bcoforeclosure_cnt(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789 '))));
EXPORT InValidMessageFT_bcoforeclosure_cnt(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('0123456789 '),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_colien_score(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_Invalid_Num(s2);
END;
EXPORT InValidFT_colien_score(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 2),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_colien_score(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('0123456789 '),SALT39.HygieneErrors.NotLength('0,2'),SALT39.HygieneErrors.NotWords('0,1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_colien_cnt(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_Invalid_Num(s2);
END;
EXPORT InValidFT_colien_cnt(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 1),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_colien_cnt(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('0123456789 '),SALT39.HygieneErrors.NotLength('0,1'),SALT39.HygieneErrors.NotWords('0,1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_bcolien_score(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_Invalid_Num(s2);
END;
EXPORT InValidFT_bcolien_score(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789 '))));
EXPORT InValidMessageFT_bcolien_score(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('0123456789 '),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_bcolien_cnt(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_Invalid_Num(s2);
END;
EXPORT InValidFT_bcolien_cnt(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789 '))));
EXPORT InValidMessageFT_bcolien_cnt(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('0123456789 '),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_cobankruptcy_score(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_Invalid_Num(s2);
END;
EXPORT InValidFT_cobankruptcy_score(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 2),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_cobankruptcy_score(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('0123456789 '),SALT39.HygieneErrors.NotLength('0,2'),SALT39.HygieneErrors.NotWords('0,1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_cobankruptcy_cnt(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_Invalid_Num(s2);
END;
EXPORT InValidFT_cobankruptcy_cnt(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 1),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_cobankruptcy_cnt(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('0123456789 '),SALT39.HygieneErrors.NotLength('0,1'),SALT39.HygieneErrors.NotWords('0,1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_bcobankruptcy_score(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_Invalid_Num(s2);
END;
EXPORT InValidFT_bcobankruptcy_score(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 2),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_bcobankruptcy_score(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('0123456789 '),SALT39.HygieneErrors.NotLength('0,2'),SALT39.HygieneErrors.NotWords('0,1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_bcobankruptcy_cnt(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_Invalid_Num(s2);
END;
EXPORT InValidFT_bcobankruptcy_cnt(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 1),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_bcobankruptcy_cnt(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('0123456789 '),SALT39.HygieneErrors.NotLength('0,1'),SALT39.HygieneErrors.NotWords('0,1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_covehicle_score(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_Invalid_Num(s2);
END;
EXPORT InValidFT_covehicle_score(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 3),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_covehicle_score(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('0123456789 '),SALT39.HygieneErrors.NotLength('0,2,3'),SALT39.HygieneErrors.NotWords('0,1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_covehicle_cnt(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_Invalid_Num(s2);
END;
EXPORT InValidFT_covehicle_cnt(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 2),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_covehicle_cnt(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('0123456789 '),SALT39.HygieneErrors.NotLength('0,1,2'),SALT39.HygieneErrors.NotWords('0,1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_coexperian_score(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_Invalid_Num(s2);
END;
EXPORT InValidFT_coexperian_score(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 2),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_coexperian_score(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('0123456789 '),SALT39.HygieneErrors.NotLength('0,2'),SALT39.HygieneErrors.NotWords('0,1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_coexperian_cnt(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_Invalid_Num(s2);
END;
EXPORT InValidFT_coexperian_cnt(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 1),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_coexperian_cnt(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('0123456789 '),SALT39.HygieneErrors.NotLength('0,1'),SALT39.HygieneErrors.NotWords('0,1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_cotransunion_score(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_Invalid_Num(s2);
END;
EXPORT InValidFT_cotransunion_score(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 2),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_cotransunion_score(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('0123456789 '),SALT39.HygieneErrors.NotLength('0,2'),SALT39.HygieneErrors.NotWords('0,1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_cotransunion_cnt(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_Invalid_Num(s2);
END;
EXPORT InValidFT_cotransunion_cnt(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 1),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_cotransunion_cnt(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('0123456789 '),SALT39.HygieneErrors.NotLength('0,1'),SALT39.HygieneErrors.NotWords('0,1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_coenclarity_score(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_Invalid_Num(s2);
END;
EXPORT InValidFT_coenclarity_score(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_coenclarity_score(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('0123456789 '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_coenclarity_cnt(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_Invalid_Num(s2);
END;
EXPORT InValidFT_coenclarity_cnt(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_coenclarity_cnt(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('0123456789 '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_coecrash_score(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_Invalid_Num(s2);
END;
EXPORT InValidFT_coecrash_score(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 2),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_coecrash_score(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('0123456789 '),SALT39.HygieneErrors.NotLength('0,2'),SALT39.HygieneErrors.NotWords('0,1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_coecrash_cnt(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_Invalid_Num(s2);
END;
EXPORT InValidFT_coecrash_cnt(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 1),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_coecrash_cnt(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('0123456789 '),SALT39.HygieneErrors.NotLength('0,1'),SALT39.HygieneErrors.NotWords('0,1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_bcoecrash_score(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_Invalid_Num(s2);
END;
EXPORT InValidFT_bcoecrash_score(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 2),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_bcoecrash_score(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('0123456789 '),SALT39.HygieneErrors.NotLength('0,2'),SALT39.HygieneErrors.NotWords('0,1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_bcoecrash_cnt(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_Invalid_Num(s2);
END;
EXPORT InValidFT_bcoecrash_cnt(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 1),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_bcoecrash_cnt(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('0123456789 '),SALT39.HygieneErrors.NotLength('0,1'),SALT39.HygieneErrors.NotWords('0,1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_cowatercraft_score(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_Invalid_Num(s2);
END;
EXPORT InValidFT_cowatercraft_score(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_cowatercraft_score(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('0123456789 '),SALT39.HygieneErrors.NotLength('0'),SALT39.HygieneErrors.NotWords('0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_cowatercraft_cnt(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_Invalid_Num(s2);
END;
EXPORT InValidFT_cowatercraft_cnt(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789 '))));
EXPORT InValidMessageFT_cowatercraft_cnt(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('0123456789 '),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_coaircraft_score(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_Invalid_Num(s2);
END;
EXPORT InValidFT_coaircraft_score(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789 '))));
EXPORT InValidMessageFT_coaircraft_score(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('0123456789 '),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_coaircraft_cnt(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_Invalid_Num(s2);
END;
EXPORT InValidFT_coaircraft_cnt(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789 '))));
EXPORT InValidMessageFT_coaircraft_cnt(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('0123456789 '),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_comarriagedivorce_score(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_Invalid_Num(s2);
END;
EXPORT InValidFT_comarriagedivorce_score(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789 '))));
EXPORT InValidMessageFT_comarriagedivorce_score(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('0123456789 '),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_comarriagedivorce_cnt(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_Invalid_Num(s2);
END;
EXPORT InValidFT_comarriagedivorce_cnt(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789 '))));
EXPORT InValidMessageFT_comarriagedivorce_cnt(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('0123456789 '),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_coucc_score(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_Invalid_Num(s2);
END;
EXPORT InValidFT_coucc_score(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 2),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_coucc_score(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('0123456789 '),SALT39.HygieneErrors.NotLength('0,2'),SALT39.HygieneErrors.NotWords('0,1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_coucc_cnt(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_Invalid_Num(s2);
END;
EXPORT InValidFT_coucc_cnt(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 1),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_coucc_cnt(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('0123456789 '),SALT39.HygieneErrors.NotLength('0,1'),SALT39.HygieneErrors.NotWords('0,1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_lname_score(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_Invalid_Num(s2);
END;
EXPORT InValidFT_lname_score(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 3),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_lname_score(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('0123456789 '),SALT39.HygieneErrors.NotLength('0,2,1,3'),SALT39.HygieneErrors.NotWords('0,1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_phone_score(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_Invalid_Num(s2);
END;
EXPORT InValidFT_phone_score(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 2),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_phone_score(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('0123456789 '),SALT39.HygieneErrors.NotLength('0,2'),SALT39.HygieneErrors.NotWords('0,1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_dl_nbr_score(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'-0123456789 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_dl_nbr_score(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'-0123456789 '))),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_dl_nbr_score(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('-0123456789 '),SALT39.HygieneErrors.NotWords('0,1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_total_cnt(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_Invalid_Num(s2);
END;
EXPORT InValidFT_total_cnt(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 2),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_total_cnt(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('0123456789 '),SALT39.HygieneErrors.NotLength('1,2'),SALT39.HygieneErrors.NotWords('1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_total_score(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_Invalid_Num(s2);
END;
EXPORT InValidFT_total_score(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 3 OR LENGTH(TRIM(s)) = 4),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_total_score(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('0123456789 '),SALT39.HygieneErrors.NotLength('2,3,4'),SALT39.HygieneErrors.NotWords('1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_cluster(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,' ABCDEFGHIJKLMNOPQRSTUVWXYZ_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_cluster(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,' ABCDEFGHIJKLMNOPQRSTUVWXYZ_ '))),~(LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 8 OR LENGTH(TRIM(s)) = 6 OR LENGTH(TRIM(s)) = 7),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_cluster(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars(' ABCDEFGHIJKLMNOPQRSTUVWXYZ_ '),SALT39.HygieneErrors.NotLength('4,8,6,7'),SALT39.HygieneErrors.NotWords('1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_generation(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,' OSY '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_generation(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,' OSY '))),~(LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_generation(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars(' OSY '),SALT39.HygieneErrors.NotLength('1,2,0'),SALT39.HygieneErrors.NotWords('1,0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_gender(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,' FM '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_gender(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,' FM '))),~(LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_gender(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars(' FM '),SALT39.HygieneErrors.NotLength('1,0'),SALT39.HygieneErrors.NotWords('1,0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_lname_cnt(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_Invalid_Num(s2);
END;
EXPORT InValidFT_lname_cnt(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 2),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_lname_cnt(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('0123456789 '),SALT39.HygieneErrors.NotLength('1,0,2'),SALT39.HygieneErrors.NotWords('1,0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_rel_dt_first_seen(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_Invalid_Num(s2);
END;
EXPORT InValidFT_rel_dt_first_seen(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 8),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_rel_dt_first_seen(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('0123456789 '),SALT39.HygieneErrors.NotLength('0,8'),SALT39.HygieneErrors.NotWords('0,1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_rel_dt_last_seen(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_Invalid_Num(s2);
END;
EXPORT InValidFT_rel_dt_last_seen(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 8),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_rel_dt_last_seen(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('0123456789 '),SALT39.HygieneErrors.NotLength('0,8'),SALT39.HygieneErrors.NotWords('0,1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_overlap_months(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_Invalid_Num(s2);
END;
EXPORT InValidFT_overlap_months(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789 '))),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_overlap_months(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('0123456789 '),SALT39.HygieneErrors.NotWords('0,1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_hdr_dt_first_seen(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_Invalid_Num(s2);
END;
EXPORT InValidFT_hdr_dt_first_seen(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 8),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_hdr_dt_first_seen(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('0123456789 '),SALT39.HygieneErrors.NotLength('8'),SALT39.HygieneErrors.NotWords('1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_hdr_dt_last_seen(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_Invalid_Num(s2);
END;
EXPORT InValidFT_hdr_dt_last_seen(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 8),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_hdr_dt_last_seen(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('0123456789 '),SALT39.HygieneErrors.NotLength('8'),SALT39.HygieneErrors.NotWords('1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_age_first_seen(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_Invalid_Num(s2);
END;
EXPORT InValidFT_age_first_seen(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 1),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_age_first_seen(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('0123456789 '),SALT39.HygieneErrors.NotLength('2,0,1'),SALT39.HygieneErrors.NotWords('1,0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_isanylnamematch(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,' 01 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_isanylnamematch(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,' 01 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 1),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_isanylnamematch(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars(' 01 '),SALT39.HygieneErrors.NotLength('0,1'),SALT39.HygieneErrors.NotWords('0,1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_isanyphonematch(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,' 01 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_isanyphonematch(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,' 01 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 1),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_isanyphonematch(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars(' 01 '),SALT39.HygieneErrors.NotLength('0,1'),SALT39.HygieneErrors.NotWords('0,1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_isearlylnamematch(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,' 01 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_isearlylnamematch(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,' 01 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 1),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_isearlylnamematch(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars(' 01 '),SALT39.HygieneErrors.NotLength('0,1'),SALT39.HygieneErrors.NotWords('0,1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_iscurrlnamematch(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,' 01 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_iscurrlnamematch(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,' 01 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 1),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_iscurrlnamematch(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars(' 01 '),SALT39.HygieneErrors.NotLength('0,1'),SALT39.HygieneErrors.NotWords('0,1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_ismixedlnamematch(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,' 01 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_ismixedlnamematch(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,' 01 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 1),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_ismixedlnamematch(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars(' 01 '),SALT39.HygieneErrors.NotLength('0,1'),SALT39.HygieneErrors.NotWords('0,1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_ssn1(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_Invalid_Num(s2);
END;
EXPORT InValidFT_ssn1(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 9 OR LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_ssn1(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('0123456789 '),SALT39.HygieneErrors.NotLength('9,0'),SALT39.HygieneErrors.NotWords('1,0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_ssn2(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_Invalid_Num(s2);
END;
EXPORT InValidFT_ssn2(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 9 OR LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_ssn2(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('0123456789 '),SALT39.HygieneErrors.NotLength('9,0'),SALT39.HygieneErrors.NotWords('1,0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_dob1(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_Invalid_Num(s2);
END;
EXPORT InValidFT_dob1(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 8 OR LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_dob1(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('0123456789 '),SALT39.HygieneErrors.NotLength('8,0'),SALT39.HygieneErrors.NotWords('1,0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_dob2(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_Invalid_Num(s2);
END;
EXPORT InValidFT_dob2(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 8 OR LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_dob2(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('0123456789 '),SALT39.HygieneErrors.NotLength('8,0'),SALT39.HygieneErrors.NotWords('1,0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_current_lname1(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'-ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_current_lname1(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'-ABCDEFGHIJKLMNOPQRSTUVWXYZ '))),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 2));
EXPORT InValidMessageFT_current_lname1(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('-ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT39.HygieneErrors.NotWords('1,2'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_current_lname2(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'-ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_current_lname2(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'-ABCDEFGHIJKLMNOPQRSTUVWXYZ '))),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 2));
EXPORT InValidMessageFT_current_lname2(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('-ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT39.HygieneErrors.NotWords('1,2'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_early_lname1(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_Invalid_Alpha(s2);
END;
EXPORT InValidFT_early_lname1(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ '))),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 2));
EXPORT InValidMessageFT_early_lname1(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT39.HygieneErrors.NotWords('1,2'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_early_lname2(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_Invalid_Alpha(s2);
END;
EXPORT InValidFT_early_lname2(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ '))),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 2));
EXPORT InValidMessageFT_early_lname2(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT39.HygieneErrors.NotWords('1,2'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_addr_ind1(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_Invalid_Num(s2);
END;
EXPORT InValidFT_addr_ind1(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789 '))),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_addr_ind1(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('0123456789 '),SALT39.HygieneErrors.NotWords('0,1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_addr_ind2(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_Invalid_Num(s2);
END;
EXPORT InValidFT_addr_ind2(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789 '))),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_addr_ind2(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('0123456789 '),SALT39.HygieneErrors.NotWords('0,1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_r2rdid(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_Invalid_Num(s2);
END;
EXPORT InValidFT_r2rdid(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789 '))),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_r2rdid(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('0123456789 '),SALT39.HygieneErrors.NotWords('0,1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_r2cnt(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_Invalid_Num(s2);
END;
EXPORT InValidFT_r2cnt(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789 '))),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_r2cnt(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('0123456789 '),SALT39.HygieneErrors.NotWords('0,1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_personal(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,' 01 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_personal(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,' 01 '))),~(LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 0),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_personal(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars(' 01 '),SALT39.HygieneErrors.NotLength('1,0'),SALT39.HygieneErrors.NotWords('1,0'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_business(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,' 01 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_business(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,' 01 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 1),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_business(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars(' 01 '),SALT39.HygieneErrors.NotLength('0,1'),SALT39.HygieneErrors.NotWords('0,1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_other(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,' 01 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_other(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,' 01 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 1),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 0 OR SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_other(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars(' 01 '),SALT39.HygieneErrors.NotLength('0,1'),SALT39.HygieneErrors.NotWords('0,1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_title(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_Invalid_Num(s2);
END;
EXPORT InValidFT_title(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 1),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_title(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('0123456789 '),SALT39.HygieneErrors.NotLength('2,1'),SALT39.HygieneErrors.NotWords('1'),SALT39.HygieneErrors.Good);
 
EXPORT SALT39.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'type','confidence','did1','did2','cohabit_score','cohabit_cnt','coapt_score','coapt_cnt','copobox_score','copobox_cnt','cossn_score','cossn_cnt','copolicy_score','copolicy_cnt','coclaim_score','coclaim_cnt','coproperty_score','coproperty_cnt','bcoproperty_score','bcoproperty_cnt','coforeclosure_score','coforeclosure_cnt','bcoforeclosure_score','bcoforeclosure_cnt','colien_score','colien_cnt','bcolien_score','bcolien_cnt','cobankruptcy_score','cobankruptcy_cnt','bcobankruptcy_score','bcobankruptcy_cnt','covehicle_score','covehicle_cnt','coexperian_score','coexperian_cnt','cotransunion_score','cotransunion_cnt','coenclarity_score','coenclarity_cnt','coecrash_score','coecrash_cnt','bcoecrash_score','bcoecrash_cnt','cowatercraft_score','cowatercraft_cnt','coaircraft_score','coaircraft_cnt','comarriagedivorce_score','comarriagedivorce_cnt','coucc_score','coucc_cnt','lname_score','phone_score','dl_nbr_score','total_cnt','total_score','cluster','generation','gender','lname_cnt','rel_dt_first_seen','rel_dt_last_seen','overlap_months','hdr_dt_first_seen','hdr_dt_last_seen','age_first_seen','isanylnamematch','isanyphonematch','isearlylnamematch','iscurrlnamematch','ismixedlnamematch','ssn1','ssn2','dob1','dob2','current_lname1','current_lname2','early_lname1','early_lname2','addr_ind1','addr_ind2','r2rdid','r2cnt','personal','business','other','title');
EXPORT SALT39.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'type','confidence','did1','did2','cohabit_score','cohabit_cnt','coapt_score','coapt_cnt','copobox_score','copobox_cnt','cossn_score','cossn_cnt','copolicy_score','copolicy_cnt','coclaim_score','coclaim_cnt','coproperty_score','coproperty_cnt','bcoproperty_score','bcoproperty_cnt','coforeclosure_score','coforeclosure_cnt','bcoforeclosure_score','bcoforeclosure_cnt','colien_score','colien_cnt','bcolien_score','bcolien_cnt','cobankruptcy_score','cobankruptcy_cnt','bcobankruptcy_score','bcobankruptcy_cnt','covehicle_score','covehicle_cnt','coexperian_score','coexperian_cnt','cotransunion_score','cotransunion_cnt','coenclarity_score','coenclarity_cnt','coecrash_score','coecrash_cnt','bcoecrash_score','bcoecrash_cnt','cowatercraft_score','cowatercraft_cnt','coaircraft_score','coaircraft_cnt','comarriagedivorce_score','comarriagedivorce_cnt','coucc_score','coucc_cnt','lname_score','phone_score','dl_nbr_score','total_cnt','total_score','cluster','generation','gender','lname_cnt','rel_dt_first_seen','rel_dt_last_seen','overlap_months','hdr_dt_first_seen','hdr_dt_last_seen','age_first_seen','isanylnamematch','isanyphonematch','isearlylnamematch','iscurrlnamematch','ismixedlnamematch','ssn1','ssn2','dob1','dob2','current_lname1','current_lname2','early_lname1','early_lname2','addr_ind1','addr_ind2','r2rdid','r2cnt','personal','business','other','title');
EXPORT FieldNum(SALT39.StrType fn) := CASE(fn,'type' => 0,'confidence' => 1,'did1' => 2,'did2' => 3,'cohabit_score' => 4,'cohabit_cnt' => 5,'coapt_score' => 6,'coapt_cnt' => 7,'copobox_score' => 8,'copobox_cnt' => 9,'cossn_score' => 10,'cossn_cnt' => 11,'copolicy_score' => 12,'copolicy_cnt' => 13,'coclaim_score' => 14,'coclaim_cnt' => 15,'coproperty_score' => 16,'coproperty_cnt' => 17,'bcoproperty_score' => 18,'bcoproperty_cnt' => 19,'coforeclosure_score' => 20,'coforeclosure_cnt' => 21,'bcoforeclosure_score' => 22,'bcoforeclosure_cnt' => 23,'colien_score' => 24,'colien_cnt' => 25,'bcolien_score' => 26,'bcolien_cnt' => 27,'cobankruptcy_score' => 28,'cobankruptcy_cnt' => 29,'bcobankruptcy_score' => 30,'bcobankruptcy_cnt' => 31,'covehicle_score' => 32,'covehicle_cnt' => 33,'coexperian_score' => 34,'coexperian_cnt' => 35,'cotransunion_score' => 36,'cotransunion_cnt' => 37,'coenclarity_score' => 38,'coenclarity_cnt' => 39,'coecrash_score' => 40,'coecrash_cnt' => 41,'bcoecrash_score' => 42,'bcoecrash_cnt' => 43,'cowatercraft_score' => 44,'cowatercraft_cnt' => 45,'coaircraft_score' => 46,'coaircraft_cnt' => 47,'comarriagedivorce_score' => 48,'comarriagedivorce_cnt' => 49,'coucc_score' => 50,'coucc_cnt' => 51,'lname_score' => 52,'phone_score' => 53,'dl_nbr_score' => 54,'total_cnt' => 55,'total_score' => 56,'cluster' => 57,'generation' => 58,'gender' => 59,'lname_cnt' => 60,'rel_dt_first_seen' => 61,'rel_dt_last_seen' => 62,'overlap_months' => 63,'hdr_dt_first_seen' => 64,'hdr_dt_last_seen' => 65,'age_first_seen' => 66,'isanylnamematch' => 67,'isanyphonematch' => 68,'isearlylnamematch' => 69,'iscurrlnamematch' => 70,'ismixedlnamematch' => 71,'ssn1' => 72,'ssn2' => 73,'dob1' => 74,'dob2' => 75,'current_lname1' => 76,'current_lname2' => 77,'early_lname1' => 78,'early_lname2' => 79,'addr_ind1' => 80,'addr_ind2' => 81,'r2rdid' => 82,'r2cnt' => 83,'personal' => 84,'business' => 85,'other' => 86,'title' => 87,0);
EXPORT SET OF SALT39.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['ALLOW'],['ALLOW','WORDS'],['ALLOW','WORDS'],['ALLOW','WORDS'],['ALLOW','WORDS'],['ALLOW','LENGTHS','WORDS'],['ALLOW','LENGTHS','WORDS'],['ALLOW','LENGTHS','WORDS'],['ALLOW','LENGTHS','WORDS'],['ALLOW','LENGTHS','WORDS'],['ALLOW','LENGTHS','WORDS'],['ALLOW','LENGTHS','WORDS'],['ALLOW','LENGTHS','WORDS'],['ALLOW','LENGTHS','WORDS'],['ALLOW','LENGTHS','WORDS'],['ALLOW','LENGTHS','WORDS'],['ALLOW','LENGTHS','WORDS'],['ALLOW','LENGTHS','WORDS'],['ALLOW','LENGTHS','WORDS'],['ALLOW','LENGTHS','WORDS'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW','LENGTHS','WORDS'],['ALLOW','LENGTHS','WORDS'],['ALLOW'],['ALLOW'],['ALLOW','LENGTHS','WORDS'],['ALLOW','LENGTHS','WORDS'],['ALLOW','LENGTHS','WORDS'],['ALLOW','LENGTHS','WORDS'],['ALLOW','LENGTHS','WORDS'],['ALLOW','LENGTHS','WORDS'],['ALLOW','LENGTHS','WORDS'],['ALLOW','LENGTHS','WORDS'],['ALLOW','LENGTHS','WORDS'],['ALLOW','LENGTHS','WORDS'],['ALLOW','LENGTHS','WORDS'],['ALLOW','LENGTHS','WORDS'],['ALLOW','LENGTHS','WORDS'],['ALLOW','LENGTHS','WORDS'],['ALLOW','LENGTHS','WORDS'],['ALLOW','LENGTHS','WORDS'],['ALLOW','LENGTHS','WORDS'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW','LENGTHS','WORDS'],['ALLOW','LENGTHS','WORDS'],['ALLOW','LENGTHS','WORDS'],['ALLOW','LENGTHS','WORDS'],['ALLOW','WORDS'],['ALLOW','LENGTHS','WORDS'],['ALLOW','LENGTHS','WORDS'],['ALLOW','LENGTHS','WORDS'],['ALLOW','LENGTHS','WORDS'],['ALLOW','LENGTHS','WORDS'],['ALLOW','LENGTHS','WORDS'],['ALLOW','LENGTHS','WORDS'],['ALLOW','LENGTHS','WORDS'],['ALLOW','WORDS'],['ALLOW','LENGTHS','WORDS'],['ALLOW','LENGTHS','WORDS'],['ALLOW','LENGTHS','WORDS'],['ALLOW','LENGTHS','WORDS'],['ALLOW','LENGTHS','WORDS'],['ALLOW','LENGTHS','WORDS'],['ALLOW','LENGTHS','WORDS'],['ALLOW','LENGTHS','WORDS'],['ALLOW','LENGTHS','WORDS'],['ALLOW','LENGTHS','WORDS'],['ALLOW','LENGTHS','WORDS'],['ALLOW','LENGTHS','WORDS'],['ALLOW','WORDS'],['ALLOW','WORDS'],['ALLOW','WORDS'],['ALLOW','WORDS'],['ALLOW','WORDS'],['ALLOW','WORDS'],['ALLOW','WORDS'],['ALLOW','WORDS'],['ALLOW','LENGTHS','WORDS'],['ALLOW','LENGTHS','WORDS'],['ALLOW','LENGTHS','WORDS'],['ALLOW','LENGTHS','WORDS'],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_type(SALT39.StrType s0) := MakeFT_type(s0);
EXPORT InValid_type(SALT39.StrType s) := InValidFT_type(s);
EXPORT InValidMessage_type(UNSIGNED1 wh) := InValidMessageFT_type(wh);
 
EXPORT Make_confidence(SALT39.StrType s0) := MakeFT_confidence(s0);
EXPORT InValid_confidence(SALT39.StrType s) := InValidFT_confidence(s);
EXPORT InValidMessage_confidence(UNSIGNED1 wh) := InValidMessageFT_confidence(wh);
 
EXPORT Make_did1(SALT39.StrType s0) := MakeFT_did1(s0);
EXPORT InValid_did1(SALT39.StrType s) := InValidFT_did1(s);
EXPORT InValidMessage_did1(UNSIGNED1 wh) := InValidMessageFT_did1(wh);
 
EXPORT Make_did2(SALT39.StrType s0) := MakeFT_did2(s0);
EXPORT InValid_did2(SALT39.StrType s) := InValidFT_did2(s);
EXPORT InValidMessage_did2(UNSIGNED1 wh) := InValidMessageFT_did2(wh);
 
EXPORT Make_cohabit_score(SALT39.StrType s0) := MakeFT_cohabit_score(s0);
EXPORT InValid_cohabit_score(SALT39.StrType s) := InValidFT_cohabit_score(s);
EXPORT InValidMessage_cohabit_score(UNSIGNED1 wh) := InValidMessageFT_cohabit_score(wh);
 
EXPORT Make_cohabit_cnt(SALT39.StrType s0) := MakeFT_cohabit_cnt(s0);
EXPORT InValid_cohabit_cnt(SALT39.StrType s) := InValidFT_cohabit_cnt(s);
EXPORT InValidMessage_cohabit_cnt(UNSIGNED1 wh) := InValidMessageFT_cohabit_cnt(wh);
 
EXPORT Make_coapt_score(SALT39.StrType s0) := MakeFT_coapt_score(s0);
EXPORT InValid_coapt_score(SALT39.StrType s) := InValidFT_coapt_score(s);
EXPORT InValidMessage_coapt_score(UNSIGNED1 wh) := InValidMessageFT_coapt_score(wh);
 
EXPORT Make_coapt_cnt(SALT39.StrType s0) := MakeFT_coapt_cnt(s0);
EXPORT InValid_coapt_cnt(SALT39.StrType s) := InValidFT_coapt_cnt(s);
EXPORT InValidMessage_coapt_cnt(UNSIGNED1 wh) := InValidMessageFT_coapt_cnt(wh);
 
EXPORT Make_copobox_score(SALT39.StrType s0) := MakeFT_copobox_score(s0);
EXPORT InValid_copobox_score(SALT39.StrType s) := InValidFT_copobox_score(s);
EXPORT InValidMessage_copobox_score(UNSIGNED1 wh) := InValidMessageFT_copobox_score(wh);
 
EXPORT Make_copobox_cnt(SALT39.StrType s0) := MakeFT_copobox_cnt(s0);
EXPORT InValid_copobox_cnt(SALT39.StrType s) := InValidFT_copobox_cnt(s);
EXPORT InValidMessage_copobox_cnt(UNSIGNED1 wh) := InValidMessageFT_copobox_cnt(wh);
 
EXPORT Make_cossn_score(SALT39.StrType s0) := MakeFT_cossn_score(s0);
EXPORT InValid_cossn_score(SALT39.StrType s) := InValidFT_cossn_score(s);
EXPORT InValidMessage_cossn_score(UNSIGNED1 wh) := InValidMessageFT_cossn_score(wh);
 
EXPORT Make_cossn_cnt(SALT39.StrType s0) := MakeFT_cossn_cnt(s0);
EXPORT InValid_cossn_cnt(SALT39.StrType s) := InValidFT_cossn_cnt(s);
EXPORT InValidMessage_cossn_cnt(UNSIGNED1 wh) := InValidMessageFT_cossn_cnt(wh);
 
EXPORT Make_copolicy_score(SALT39.StrType s0) := MakeFT_copolicy_score(s0);
EXPORT InValid_copolicy_score(SALT39.StrType s) := InValidFT_copolicy_score(s);
EXPORT InValidMessage_copolicy_score(UNSIGNED1 wh) := InValidMessageFT_copolicy_score(wh);
 
EXPORT Make_copolicy_cnt(SALT39.StrType s0) := MakeFT_copolicy_cnt(s0);
EXPORT InValid_copolicy_cnt(SALT39.StrType s) := InValidFT_copolicy_cnt(s);
EXPORT InValidMessage_copolicy_cnt(UNSIGNED1 wh) := InValidMessageFT_copolicy_cnt(wh);
 
EXPORT Make_coclaim_score(SALT39.StrType s0) := MakeFT_coclaim_score(s0);
EXPORT InValid_coclaim_score(SALT39.StrType s) := InValidFT_coclaim_score(s);
EXPORT InValidMessage_coclaim_score(UNSIGNED1 wh) := InValidMessageFT_coclaim_score(wh);
 
EXPORT Make_coclaim_cnt(SALT39.StrType s0) := MakeFT_coclaim_cnt(s0);
EXPORT InValid_coclaim_cnt(SALT39.StrType s) := InValidFT_coclaim_cnt(s);
EXPORT InValidMessage_coclaim_cnt(UNSIGNED1 wh) := InValidMessageFT_coclaim_cnt(wh);
 
EXPORT Make_coproperty_score(SALT39.StrType s0) := MakeFT_coproperty_score(s0);
EXPORT InValid_coproperty_score(SALT39.StrType s) := InValidFT_coproperty_score(s);
EXPORT InValidMessage_coproperty_score(UNSIGNED1 wh) := InValidMessageFT_coproperty_score(wh);
 
EXPORT Make_coproperty_cnt(SALT39.StrType s0) := MakeFT_coproperty_cnt(s0);
EXPORT InValid_coproperty_cnt(SALT39.StrType s) := InValidFT_coproperty_cnt(s);
EXPORT InValidMessage_coproperty_cnt(UNSIGNED1 wh) := InValidMessageFT_coproperty_cnt(wh);
 
EXPORT Make_bcoproperty_score(SALT39.StrType s0) := MakeFT_bcoproperty_score(s0);
EXPORT InValid_bcoproperty_score(SALT39.StrType s) := InValidFT_bcoproperty_score(s);
EXPORT InValidMessage_bcoproperty_score(UNSIGNED1 wh) := InValidMessageFT_bcoproperty_score(wh);
 
EXPORT Make_bcoproperty_cnt(SALT39.StrType s0) := MakeFT_bcoproperty_cnt(s0);
EXPORT InValid_bcoproperty_cnt(SALT39.StrType s) := InValidFT_bcoproperty_cnt(s);
EXPORT InValidMessage_bcoproperty_cnt(UNSIGNED1 wh) := InValidMessageFT_bcoproperty_cnt(wh);
 
EXPORT Make_coforeclosure_score(SALT39.StrType s0) := MakeFT_coforeclosure_score(s0);
EXPORT InValid_coforeclosure_score(SALT39.StrType s) := InValidFT_coforeclosure_score(s);
EXPORT InValidMessage_coforeclosure_score(UNSIGNED1 wh) := InValidMessageFT_coforeclosure_score(wh);
 
EXPORT Make_coforeclosure_cnt(SALT39.StrType s0) := MakeFT_coforeclosure_cnt(s0);
EXPORT InValid_coforeclosure_cnt(SALT39.StrType s) := InValidFT_coforeclosure_cnt(s);
EXPORT InValidMessage_coforeclosure_cnt(UNSIGNED1 wh) := InValidMessageFT_coforeclosure_cnt(wh);
 
EXPORT Make_bcoforeclosure_score(SALT39.StrType s0) := MakeFT_bcoforeclosure_score(s0);
EXPORT InValid_bcoforeclosure_score(SALT39.StrType s) := InValidFT_bcoforeclosure_score(s);
EXPORT InValidMessage_bcoforeclosure_score(UNSIGNED1 wh) := InValidMessageFT_bcoforeclosure_score(wh);
 
EXPORT Make_bcoforeclosure_cnt(SALT39.StrType s0) := MakeFT_bcoforeclosure_cnt(s0);
EXPORT InValid_bcoforeclosure_cnt(SALT39.StrType s) := InValidFT_bcoforeclosure_cnt(s);
EXPORT InValidMessage_bcoforeclosure_cnt(UNSIGNED1 wh) := InValidMessageFT_bcoforeclosure_cnt(wh);
 
EXPORT Make_colien_score(SALT39.StrType s0) := MakeFT_colien_score(s0);
EXPORT InValid_colien_score(SALT39.StrType s) := InValidFT_colien_score(s);
EXPORT InValidMessage_colien_score(UNSIGNED1 wh) := InValidMessageFT_colien_score(wh);
 
EXPORT Make_colien_cnt(SALT39.StrType s0) := MakeFT_colien_cnt(s0);
EXPORT InValid_colien_cnt(SALT39.StrType s) := InValidFT_colien_cnt(s);
EXPORT InValidMessage_colien_cnt(UNSIGNED1 wh) := InValidMessageFT_colien_cnt(wh);
 
EXPORT Make_bcolien_score(SALT39.StrType s0) := MakeFT_bcolien_score(s0);
EXPORT InValid_bcolien_score(SALT39.StrType s) := InValidFT_bcolien_score(s);
EXPORT InValidMessage_bcolien_score(UNSIGNED1 wh) := InValidMessageFT_bcolien_score(wh);
 
EXPORT Make_bcolien_cnt(SALT39.StrType s0) := MakeFT_bcolien_cnt(s0);
EXPORT InValid_bcolien_cnt(SALT39.StrType s) := InValidFT_bcolien_cnt(s);
EXPORT InValidMessage_bcolien_cnt(UNSIGNED1 wh) := InValidMessageFT_bcolien_cnt(wh);
 
EXPORT Make_cobankruptcy_score(SALT39.StrType s0) := MakeFT_cobankruptcy_score(s0);
EXPORT InValid_cobankruptcy_score(SALT39.StrType s) := InValidFT_cobankruptcy_score(s);
EXPORT InValidMessage_cobankruptcy_score(UNSIGNED1 wh) := InValidMessageFT_cobankruptcy_score(wh);
 
EXPORT Make_cobankruptcy_cnt(SALT39.StrType s0) := MakeFT_cobankruptcy_cnt(s0);
EXPORT InValid_cobankruptcy_cnt(SALT39.StrType s) := InValidFT_cobankruptcy_cnt(s);
EXPORT InValidMessage_cobankruptcy_cnt(UNSIGNED1 wh) := InValidMessageFT_cobankruptcy_cnt(wh);
 
EXPORT Make_bcobankruptcy_score(SALT39.StrType s0) := MakeFT_bcobankruptcy_score(s0);
EXPORT InValid_bcobankruptcy_score(SALT39.StrType s) := InValidFT_bcobankruptcy_score(s);
EXPORT InValidMessage_bcobankruptcy_score(UNSIGNED1 wh) := InValidMessageFT_bcobankruptcy_score(wh);
 
EXPORT Make_bcobankruptcy_cnt(SALT39.StrType s0) := MakeFT_bcobankruptcy_cnt(s0);
EXPORT InValid_bcobankruptcy_cnt(SALT39.StrType s) := InValidFT_bcobankruptcy_cnt(s);
EXPORT InValidMessage_bcobankruptcy_cnt(UNSIGNED1 wh) := InValidMessageFT_bcobankruptcy_cnt(wh);
 
EXPORT Make_covehicle_score(SALT39.StrType s0) := MakeFT_covehicle_score(s0);
EXPORT InValid_covehicle_score(SALT39.StrType s) := InValidFT_covehicle_score(s);
EXPORT InValidMessage_covehicle_score(UNSIGNED1 wh) := InValidMessageFT_covehicle_score(wh);
 
EXPORT Make_covehicle_cnt(SALT39.StrType s0) := MakeFT_covehicle_cnt(s0);
EXPORT InValid_covehicle_cnt(SALT39.StrType s) := InValidFT_covehicle_cnt(s);
EXPORT InValidMessage_covehicle_cnt(UNSIGNED1 wh) := InValidMessageFT_covehicle_cnt(wh);
 
EXPORT Make_coexperian_score(SALT39.StrType s0) := MakeFT_coexperian_score(s0);
EXPORT InValid_coexperian_score(SALT39.StrType s) := InValidFT_coexperian_score(s);
EXPORT InValidMessage_coexperian_score(UNSIGNED1 wh) := InValidMessageFT_coexperian_score(wh);
 
EXPORT Make_coexperian_cnt(SALT39.StrType s0) := MakeFT_coexperian_cnt(s0);
EXPORT InValid_coexperian_cnt(SALT39.StrType s) := InValidFT_coexperian_cnt(s);
EXPORT InValidMessage_coexperian_cnt(UNSIGNED1 wh) := InValidMessageFT_coexperian_cnt(wh);
 
EXPORT Make_cotransunion_score(SALT39.StrType s0) := MakeFT_cotransunion_score(s0);
EXPORT InValid_cotransunion_score(SALT39.StrType s) := InValidFT_cotransunion_score(s);
EXPORT InValidMessage_cotransunion_score(UNSIGNED1 wh) := InValidMessageFT_cotransunion_score(wh);
 
EXPORT Make_cotransunion_cnt(SALT39.StrType s0) := MakeFT_cotransunion_cnt(s0);
EXPORT InValid_cotransunion_cnt(SALT39.StrType s) := InValidFT_cotransunion_cnt(s);
EXPORT InValidMessage_cotransunion_cnt(UNSIGNED1 wh) := InValidMessageFT_cotransunion_cnt(wh);
 
EXPORT Make_coenclarity_score(SALT39.StrType s0) := MakeFT_coenclarity_score(s0);
EXPORT InValid_coenclarity_score(SALT39.StrType s) := InValidFT_coenclarity_score(s);
EXPORT InValidMessage_coenclarity_score(UNSIGNED1 wh) := InValidMessageFT_coenclarity_score(wh);
 
EXPORT Make_coenclarity_cnt(SALT39.StrType s0) := MakeFT_coenclarity_cnt(s0);
EXPORT InValid_coenclarity_cnt(SALT39.StrType s) := InValidFT_coenclarity_cnt(s);
EXPORT InValidMessage_coenclarity_cnt(UNSIGNED1 wh) := InValidMessageFT_coenclarity_cnt(wh);
 
EXPORT Make_coecrash_score(SALT39.StrType s0) := MakeFT_coecrash_score(s0);
EXPORT InValid_coecrash_score(SALT39.StrType s) := InValidFT_coecrash_score(s);
EXPORT InValidMessage_coecrash_score(UNSIGNED1 wh) := InValidMessageFT_coecrash_score(wh);
 
EXPORT Make_coecrash_cnt(SALT39.StrType s0) := MakeFT_coecrash_cnt(s0);
EXPORT InValid_coecrash_cnt(SALT39.StrType s) := InValidFT_coecrash_cnt(s);
EXPORT InValidMessage_coecrash_cnt(UNSIGNED1 wh) := InValidMessageFT_coecrash_cnt(wh);
 
EXPORT Make_bcoecrash_score(SALT39.StrType s0) := MakeFT_bcoecrash_score(s0);
EXPORT InValid_bcoecrash_score(SALT39.StrType s) := InValidFT_bcoecrash_score(s);
EXPORT InValidMessage_bcoecrash_score(UNSIGNED1 wh) := InValidMessageFT_bcoecrash_score(wh);
 
EXPORT Make_bcoecrash_cnt(SALT39.StrType s0) := MakeFT_bcoecrash_cnt(s0);
EXPORT InValid_bcoecrash_cnt(SALT39.StrType s) := InValidFT_bcoecrash_cnt(s);
EXPORT InValidMessage_bcoecrash_cnt(UNSIGNED1 wh) := InValidMessageFT_bcoecrash_cnt(wh);
 
EXPORT Make_cowatercraft_score(SALT39.StrType s0) := MakeFT_cowatercraft_score(s0);
EXPORT InValid_cowatercraft_score(SALT39.StrType s) := InValidFT_cowatercraft_score(s);
EXPORT InValidMessage_cowatercraft_score(UNSIGNED1 wh) := InValidMessageFT_cowatercraft_score(wh);
 
EXPORT Make_cowatercraft_cnt(SALT39.StrType s0) := MakeFT_cowatercraft_cnt(s0);
EXPORT InValid_cowatercraft_cnt(SALT39.StrType s) := InValidFT_cowatercraft_cnt(s);
EXPORT InValidMessage_cowatercraft_cnt(UNSIGNED1 wh) := InValidMessageFT_cowatercraft_cnt(wh);
 
EXPORT Make_coaircraft_score(SALT39.StrType s0) := MakeFT_coaircraft_score(s0);
EXPORT InValid_coaircraft_score(SALT39.StrType s) := InValidFT_coaircraft_score(s);
EXPORT InValidMessage_coaircraft_score(UNSIGNED1 wh) := InValidMessageFT_coaircraft_score(wh);
 
EXPORT Make_coaircraft_cnt(SALT39.StrType s0) := MakeFT_coaircraft_cnt(s0);
EXPORT InValid_coaircraft_cnt(SALT39.StrType s) := InValidFT_coaircraft_cnt(s);
EXPORT InValidMessage_coaircraft_cnt(UNSIGNED1 wh) := InValidMessageFT_coaircraft_cnt(wh);
 
EXPORT Make_comarriagedivorce_score(SALT39.StrType s0) := MakeFT_comarriagedivorce_score(s0);
EXPORT InValid_comarriagedivorce_score(SALT39.StrType s) := InValidFT_comarriagedivorce_score(s);
EXPORT InValidMessage_comarriagedivorce_score(UNSIGNED1 wh) := InValidMessageFT_comarriagedivorce_score(wh);
 
EXPORT Make_comarriagedivorce_cnt(SALT39.StrType s0) := MakeFT_comarriagedivorce_cnt(s0);
EXPORT InValid_comarriagedivorce_cnt(SALT39.StrType s) := InValidFT_comarriagedivorce_cnt(s);
EXPORT InValidMessage_comarriagedivorce_cnt(UNSIGNED1 wh) := InValidMessageFT_comarriagedivorce_cnt(wh);
 
EXPORT Make_coucc_score(SALT39.StrType s0) := MakeFT_coucc_score(s0);
EXPORT InValid_coucc_score(SALT39.StrType s) := InValidFT_coucc_score(s);
EXPORT InValidMessage_coucc_score(UNSIGNED1 wh) := InValidMessageFT_coucc_score(wh);
 
EXPORT Make_coucc_cnt(SALT39.StrType s0) := MakeFT_coucc_cnt(s0);
EXPORT InValid_coucc_cnt(SALT39.StrType s) := InValidFT_coucc_cnt(s);
EXPORT InValidMessage_coucc_cnt(UNSIGNED1 wh) := InValidMessageFT_coucc_cnt(wh);
 
EXPORT Make_lname_score(SALT39.StrType s0) := MakeFT_lname_score(s0);
EXPORT InValid_lname_score(SALT39.StrType s) := InValidFT_lname_score(s);
EXPORT InValidMessage_lname_score(UNSIGNED1 wh) := InValidMessageFT_lname_score(wh);
 
EXPORT Make_phone_score(SALT39.StrType s0) := MakeFT_phone_score(s0);
EXPORT InValid_phone_score(SALT39.StrType s) := InValidFT_phone_score(s);
EXPORT InValidMessage_phone_score(UNSIGNED1 wh) := InValidMessageFT_phone_score(wh);
 
EXPORT Make_dl_nbr_score(SALT39.StrType s0) := MakeFT_dl_nbr_score(s0);
EXPORT InValid_dl_nbr_score(SALT39.StrType s) := InValidFT_dl_nbr_score(s);
EXPORT InValidMessage_dl_nbr_score(UNSIGNED1 wh) := InValidMessageFT_dl_nbr_score(wh);
 
EXPORT Make_total_cnt(SALT39.StrType s0) := MakeFT_total_cnt(s0);
EXPORT InValid_total_cnt(SALT39.StrType s) := InValidFT_total_cnt(s);
EXPORT InValidMessage_total_cnt(UNSIGNED1 wh) := InValidMessageFT_total_cnt(wh);
 
EXPORT Make_total_score(SALT39.StrType s0) := MakeFT_total_score(s0);
EXPORT InValid_total_score(SALT39.StrType s) := InValidFT_total_score(s);
EXPORT InValidMessage_total_score(UNSIGNED1 wh) := InValidMessageFT_total_score(wh);
 
EXPORT Make_cluster(SALT39.StrType s0) := MakeFT_cluster(s0);
EXPORT InValid_cluster(SALT39.StrType s) := InValidFT_cluster(s);
EXPORT InValidMessage_cluster(UNSIGNED1 wh) := InValidMessageFT_cluster(wh);
 
EXPORT Make_generation(SALT39.StrType s0) := MakeFT_generation(s0);
EXPORT InValid_generation(SALT39.StrType s) := InValidFT_generation(s);
EXPORT InValidMessage_generation(UNSIGNED1 wh) := InValidMessageFT_generation(wh);
 
EXPORT Make_gender(SALT39.StrType s0) := MakeFT_gender(s0);
EXPORT InValid_gender(SALT39.StrType s) := InValidFT_gender(s);
EXPORT InValidMessage_gender(UNSIGNED1 wh) := InValidMessageFT_gender(wh);
 
EXPORT Make_lname_cnt(SALT39.StrType s0) := MakeFT_lname_cnt(s0);
EXPORT InValid_lname_cnt(SALT39.StrType s) := InValidFT_lname_cnt(s);
EXPORT InValidMessage_lname_cnt(UNSIGNED1 wh) := InValidMessageFT_lname_cnt(wh);
 
EXPORT Make_rel_dt_first_seen(SALT39.StrType s0) := MakeFT_rel_dt_first_seen(s0);
EXPORT InValid_rel_dt_first_seen(SALT39.StrType s) := InValidFT_rel_dt_first_seen(s);
EXPORT InValidMessage_rel_dt_first_seen(UNSIGNED1 wh) := InValidMessageFT_rel_dt_first_seen(wh);
 
EXPORT Make_rel_dt_last_seen(SALT39.StrType s0) := MakeFT_rel_dt_last_seen(s0);
EXPORT InValid_rel_dt_last_seen(SALT39.StrType s) := InValidFT_rel_dt_last_seen(s);
EXPORT InValidMessage_rel_dt_last_seen(UNSIGNED1 wh) := InValidMessageFT_rel_dt_last_seen(wh);
 
EXPORT Make_overlap_months(SALT39.StrType s0) := MakeFT_overlap_months(s0);
EXPORT InValid_overlap_months(SALT39.StrType s) := InValidFT_overlap_months(s);
EXPORT InValidMessage_overlap_months(UNSIGNED1 wh) := InValidMessageFT_overlap_months(wh);
 
EXPORT Make_hdr_dt_first_seen(SALT39.StrType s0) := MakeFT_hdr_dt_first_seen(s0);
EXPORT InValid_hdr_dt_first_seen(SALT39.StrType s) := InValidFT_hdr_dt_first_seen(s);
EXPORT InValidMessage_hdr_dt_first_seen(UNSIGNED1 wh) := InValidMessageFT_hdr_dt_first_seen(wh);
 
EXPORT Make_hdr_dt_last_seen(SALT39.StrType s0) := MakeFT_hdr_dt_last_seen(s0);
EXPORT InValid_hdr_dt_last_seen(SALT39.StrType s) := InValidFT_hdr_dt_last_seen(s);
EXPORT InValidMessage_hdr_dt_last_seen(UNSIGNED1 wh) := InValidMessageFT_hdr_dt_last_seen(wh);
 
EXPORT Make_age_first_seen(SALT39.StrType s0) := MakeFT_age_first_seen(s0);
EXPORT InValid_age_first_seen(SALT39.StrType s) := InValidFT_age_first_seen(s);
EXPORT InValidMessage_age_first_seen(UNSIGNED1 wh) := InValidMessageFT_age_first_seen(wh);
 
EXPORT Make_isanylnamematch(SALT39.StrType s0) := MakeFT_isanylnamematch(s0);
EXPORT InValid_isanylnamematch(SALT39.StrType s) := InValidFT_isanylnamematch(s);
EXPORT InValidMessage_isanylnamematch(UNSIGNED1 wh) := InValidMessageFT_isanylnamematch(wh);
 
EXPORT Make_isanyphonematch(SALT39.StrType s0) := MakeFT_isanyphonematch(s0);
EXPORT InValid_isanyphonematch(SALT39.StrType s) := InValidFT_isanyphonematch(s);
EXPORT InValidMessage_isanyphonematch(UNSIGNED1 wh) := InValidMessageFT_isanyphonematch(wh);
 
EXPORT Make_isearlylnamematch(SALT39.StrType s0) := MakeFT_isearlylnamematch(s0);
EXPORT InValid_isearlylnamematch(SALT39.StrType s) := InValidFT_isearlylnamematch(s);
EXPORT InValidMessage_isearlylnamematch(UNSIGNED1 wh) := InValidMessageFT_isearlylnamematch(wh);
 
EXPORT Make_iscurrlnamematch(SALT39.StrType s0) := MakeFT_iscurrlnamematch(s0);
EXPORT InValid_iscurrlnamematch(SALT39.StrType s) := InValidFT_iscurrlnamematch(s);
EXPORT InValidMessage_iscurrlnamematch(UNSIGNED1 wh) := InValidMessageFT_iscurrlnamematch(wh);
 
EXPORT Make_ismixedlnamematch(SALT39.StrType s0) := MakeFT_ismixedlnamematch(s0);
EXPORT InValid_ismixedlnamematch(SALT39.StrType s) := InValidFT_ismixedlnamematch(s);
EXPORT InValidMessage_ismixedlnamematch(UNSIGNED1 wh) := InValidMessageFT_ismixedlnamematch(wh);
 
EXPORT Make_ssn1(SALT39.StrType s0) := MakeFT_ssn1(s0);
EXPORT InValid_ssn1(SALT39.StrType s) := InValidFT_ssn1(s);
EXPORT InValidMessage_ssn1(UNSIGNED1 wh) := InValidMessageFT_ssn1(wh);
 
EXPORT Make_ssn2(SALT39.StrType s0) := MakeFT_ssn2(s0);
EXPORT InValid_ssn2(SALT39.StrType s) := InValidFT_ssn2(s);
EXPORT InValidMessage_ssn2(UNSIGNED1 wh) := InValidMessageFT_ssn2(wh);
 
EXPORT Make_dob1(SALT39.StrType s0) := MakeFT_dob1(s0);
EXPORT InValid_dob1(SALT39.StrType s) := InValidFT_dob1(s);
EXPORT InValidMessage_dob1(UNSIGNED1 wh) := InValidMessageFT_dob1(wh);
 
EXPORT Make_dob2(SALT39.StrType s0) := MakeFT_dob2(s0);
EXPORT InValid_dob2(SALT39.StrType s) := InValidFT_dob2(s);
EXPORT InValidMessage_dob2(UNSIGNED1 wh) := InValidMessageFT_dob2(wh);
 
EXPORT Make_current_lname1(SALT39.StrType s0) := MakeFT_current_lname1(s0);
EXPORT InValid_current_lname1(SALT39.StrType s) := InValidFT_current_lname1(s);
EXPORT InValidMessage_current_lname1(UNSIGNED1 wh) := InValidMessageFT_current_lname1(wh);
 
EXPORT Make_current_lname2(SALT39.StrType s0) := MakeFT_current_lname2(s0);
EXPORT InValid_current_lname2(SALT39.StrType s) := InValidFT_current_lname2(s);
EXPORT InValidMessage_current_lname2(UNSIGNED1 wh) := InValidMessageFT_current_lname2(wh);
 
EXPORT Make_early_lname1(SALT39.StrType s0) := MakeFT_early_lname1(s0);
EXPORT InValid_early_lname1(SALT39.StrType s) := InValidFT_early_lname1(s);
EXPORT InValidMessage_early_lname1(UNSIGNED1 wh) := InValidMessageFT_early_lname1(wh);
 
EXPORT Make_early_lname2(SALT39.StrType s0) := MakeFT_early_lname2(s0);
EXPORT InValid_early_lname2(SALT39.StrType s) := InValidFT_early_lname2(s);
EXPORT InValidMessage_early_lname2(UNSIGNED1 wh) := InValidMessageFT_early_lname2(wh);
 
EXPORT Make_addr_ind1(SALT39.StrType s0) := MakeFT_addr_ind1(s0);
EXPORT InValid_addr_ind1(SALT39.StrType s) := InValidFT_addr_ind1(s);
EXPORT InValidMessage_addr_ind1(UNSIGNED1 wh) := InValidMessageFT_addr_ind1(wh);
 
EXPORT Make_addr_ind2(SALT39.StrType s0) := MakeFT_addr_ind2(s0);
EXPORT InValid_addr_ind2(SALT39.StrType s) := InValidFT_addr_ind2(s);
EXPORT InValidMessage_addr_ind2(UNSIGNED1 wh) := InValidMessageFT_addr_ind2(wh);
 
EXPORT Make_r2rdid(SALT39.StrType s0) := MakeFT_r2rdid(s0);
EXPORT InValid_r2rdid(SALT39.StrType s) := InValidFT_r2rdid(s);
EXPORT InValidMessage_r2rdid(UNSIGNED1 wh) := InValidMessageFT_r2rdid(wh);
 
EXPORT Make_r2cnt(SALT39.StrType s0) := MakeFT_r2cnt(s0);
EXPORT InValid_r2cnt(SALT39.StrType s) := InValidFT_r2cnt(s);
EXPORT InValidMessage_r2cnt(UNSIGNED1 wh) := InValidMessageFT_r2cnt(wh);
 
EXPORT Make_personal(SALT39.StrType s0) := MakeFT_personal(s0);
EXPORT InValid_personal(SALT39.StrType s) := InValidFT_personal(s);
EXPORT InValidMessage_personal(UNSIGNED1 wh) := InValidMessageFT_personal(wh);
 
EXPORT Make_business(SALT39.StrType s0) := MakeFT_business(s0);
EXPORT InValid_business(SALT39.StrType s) := InValidFT_business(s);
EXPORT InValidMessage_business(UNSIGNED1 wh) := InValidMessageFT_business(wh);
 
EXPORT Make_other(SALT39.StrType s0) := MakeFT_other(s0);
EXPORT InValid_other(SALT39.StrType s) := InValidFT_other(s);
EXPORT InValidMessage_other(UNSIGNED1 wh) := InValidMessageFT_other(wh);
 
EXPORT Make_title(SALT39.StrType s0) := MakeFT_title(s0);
EXPORT InValid_title(SALT39.StrType s) := InValidFT_title(s);
EXPORT InValidMessage_title(UNSIGNED1 wh) := InValidMessageFT_title(wh);
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT39,Scrubs_FileRelative_Monthly;
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
    BOOLEAN Diff_type;
    BOOLEAN Diff_confidence;
    BOOLEAN Diff_did1;
    BOOLEAN Diff_did2;
    BOOLEAN Diff_cohabit_score;
    BOOLEAN Diff_cohabit_cnt;
    BOOLEAN Diff_coapt_score;
    BOOLEAN Diff_coapt_cnt;
    BOOLEAN Diff_copobox_score;
    BOOLEAN Diff_copobox_cnt;
    BOOLEAN Diff_cossn_score;
    BOOLEAN Diff_cossn_cnt;
    BOOLEAN Diff_copolicy_score;
    BOOLEAN Diff_copolicy_cnt;
    BOOLEAN Diff_coclaim_score;
    BOOLEAN Diff_coclaim_cnt;
    BOOLEAN Diff_coproperty_score;
    BOOLEAN Diff_coproperty_cnt;
    BOOLEAN Diff_bcoproperty_score;
    BOOLEAN Diff_bcoproperty_cnt;
    BOOLEAN Diff_coforeclosure_score;
    BOOLEAN Diff_coforeclosure_cnt;
    BOOLEAN Diff_bcoforeclosure_score;
    BOOLEAN Diff_bcoforeclosure_cnt;
    BOOLEAN Diff_colien_score;
    BOOLEAN Diff_colien_cnt;
    BOOLEAN Diff_bcolien_score;
    BOOLEAN Diff_bcolien_cnt;
    BOOLEAN Diff_cobankruptcy_score;
    BOOLEAN Diff_cobankruptcy_cnt;
    BOOLEAN Diff_bcobankruptcy_score;
    BOOLEAN Diff_bcobankruptcy_cnt;
    BOOLEAN Diff_covehicle_score;
    BOOLEAN Diff_covehicle_cnt;
    BOOLEAN Diff_coexperian_score;
    BOOLEAN Diff_coexperian_cnt;
    BOOLEAN Diff_cotransunion_score;
    BOOLEAN Diff_cotransunion_cnt;
    BOOLEAN Diff_coenclarity_score;
    BOOLEAN Diff_coenclarity_cnt;
    BOOLEAN Diff_coecrash_score;
    BOOLEAN Diff_coecrash_cnt;
    BOOLEAN Diff_bcoecrash_score;
    BOOLEAN Diff_bcoecrash_cnt;
    BOOLEAN Diff_cowatercraft_score;
    BOOLEAN Diff_cowatercraft_cnt;
    BOOLEAN Diff_coaircraft_score;
    BOOLEAN Diff_coaircraft_cnt;
    BOOLEAN Diff_comarriagedivorce_score;
    BOOLEAN Diff_comarriagedivorce_cnt;
    BOOLEAN Diff_coucc_score;
    BOOLEAN Diff_coucc_cnt;
    BOOLEAN Diff_lname_score;
    BOOLEAN Diff_phone_score;
    BOOLEAN Diff_dl_nbr_score;
    BOOLEAN Diff_total_cnt;
    BOOLEAN Diff_total_score;
    BOOLEAN Diff_cluster;
    BOOLEAN Diff_generation;
    BOOLEAN Diff_gender;
    BOOLEAN Diff_lname_cnt;
    BOOLEAN Diff_rel_dt_first_seen;
    BOOLEAN Diff_rel_dt_last_seen;
    BOOLEAN Diff_overlap_months;
    BOOLEAN Diff_hdr_dt_first_seen;
    BOOLEAN Diff_hdr_dt_last_seen;
    BOOLEAN Diff_age_first_seen;
    BOOLEAN Diff_isanylnamematch;
    BOOLEAN Diff_isanyphonematch;
    BOOLEAN Diff_isearlylnamematch;
    BOOLEAN Diff_iscurrlnamematch;
    BOOLEAN Diff_ismixedlnamematch;
    BOOLEAN Diff_ssn1;
    BOOLEAN Diff_ssn2;
    BOOLEAN Diff_dob1;
    BOOLEAN Diff_dob2;
    BOOLEAN Diff_current_lname1;
    BOOLEAN Diff_current_lname2;
    BOOLEAN Diff_early_lname1;
    BOOLEAN Diff_early_lname2;
    BOOLEAN Diff_addr_ind1;
    BOOLEAN Diff_addr_ind2;
    BOOLEAN Diff_r2rdid;
    BOOLEAN Diff_r2cnt;
    BOOLEAN Diff_personal;
    BOOLEAN Diff_business;
    BOOLEAN Diff_other;
    BOOLEAN Diff_title;
    UNSIGNED Num_Diffs;
    SALT39.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_type := le.type <> ri.type;
    SELF.Diff_confidence := le.confidence <> ri.confidence;
    SELF.Diff_did1 := le.did1 <> ri.did1;
    SELF.Diff_did2 := le.did2 <> ri.did2;
    SELF.Diff_cohabit_score := le.cohabit_score <> ri.cohabit_score;
    SELF.Diff_cohabit_cnt := le.cohabit_cnt <> ri.cohabit_cnt;
    SELF.Diff_coapt_score := le.coapt_score <> ri.coapt_score;
    SELF.Diff_coapt_cnt := le.coapt_cnt <> ri.coapt_cnt;
    SELF.Diff_copobox_score := le.copobox_score <> ri.copobox_score;
    SELF.Diff_copobox_cnt := le.copobox_cnt <> ri.copobox_cnt;
    SELF.Diff_cossn_score := le.cossn_score <> ri.cossn_score;
    SELF.Diff_cossn_cnt := le.cossn_cnt <> ri.cossn_cnt;
    SELF.Diff_copolicy_score := le.copolicy_score <> ri.copolicy_score;
    SELF.Diff_copolicy_cnt := le.copolicy_cnt <> ri.copolicy_cnt;
    SELF.Diff_coclaim_score := le.coclaim_score <> ri.coclaim_score;
    SELF.Diff_coclaim_cnt := le.coclaim_cnt <> ri.coclaim_cnt;
    SELF.Diff_coproperty_score := le.coproperty_score <> ri.coproperty_score;
    SELF.Diff_coproperty_cnt := le.coproperty_cnt <> ri.coproperty_cnt;
    SELF.Diff_bcoproperty_score := le.bcoproperty_score <> ri.bcoproperty_score;
    SELF.Diff_bcoproperty_cnt := le.bcoproperty_cnt <> ri.bcoproperty_cnt;
    SELF.Diff_coforeclosure_score := le.coforeclosure_score <> ri.coforeclosure_score;
    SELF.Diff_coforeclosure_cnt := le.coforeclosure_cnt <> ri.coforeclosure_cnt;
    SELF.Diff_bcoforeclosure_score := le.bcoforeclosure_score <> ri.bcoforeclosure_score;
    SELF.Diff_bcoforeclosure_cnt := le.bcoforeclosure_cnt <> ri.bcoforeclosure_cnt;
    SELF.Diff_colien_score := le.colien_score <> ri.colien_score;
    SELF.Diff_colien_cnt := le.colien_cnt <> ri.colien_cnt;
    SELF.Diff_bcolien_score := le.bcolien_score <> ri.bcolien_score;
    SELF.Diff_bcolien_cnt := le.bcolien_cnt <> ri.bcolien_cnt;
    SELF.Diff_cobankruptcy_score := le.cobankruptcy_score <> ri.cobankruptcy_score;
    SELF.Diff_cobankruptcy_cnt := le.cobankruptcy_cnt <> ri.cobankruptcy_cnt;
    SELF.Diff_bcobankruptcy_score := le.bcobankruptcy_score <> ri.bcobankruptcy_score;
    SELF.Diff_bcobankruptcy_cnt := le.bcobankruptcy_cnt <> ri.bcobankruptcy_cnt;
    SELF.Diff_covehicle_score := le.covehicle_score <> ri.covehicle_score;
    SELF.Diff_covehicle_cnt := le.covehicle_cnt <> ri.covehicle_cnt;
    SELF.Diff_coexperian_score := le.coexperian_score <> ri.coexperian_score;
    SELF.Diff_coexperian_cnt := le.coexperian_cnt <> ri.coexperian_cnt;
    SELF.Diff_cotransunion_score := le.cotransunion_score <> ri.cotransunion_score;
    SELF.Diff_cotransunion_cnt := le.cotransunion_cnt <> ri.cotransunion_cnt;
    SELF.Diff_coenclarity_score := le.coenclarity_score <> ri.coenclarity_score;
    SELF.Diff_coenclarity_cnt := le.coenclarity_cnt <> ri.coenclarity_cnt;
    SELF.Diff_coecrash_score := le.coecrash_score <> ri.coecrash_score;
    SELF.Diff_coecrash_cnt := le.coecrash_cnt <> ri.coecrash_cnt;
    SELF.Diff_bcoecrash_score := le.bcoecrash_score <> ri.bcoecrash_score;
    SELF.Diff_bcoecrash_cnt := le.bcoecrash_cnt <> ri.bcoecrash_cnt;
    SELF.Diff_cowatercraft_score := le.cowatercraft_score <> ri.cowatercraft_score;
    SELF.Diff_cowatercraft_cnt := le.cowatercraft_cnt <> ri.cowatercraft_cnt;
    SELF.Diff_coaircraft_score := le.coaircraft_score <> ri.coaircraft_score;
    SELF.Diff_coaircraft_cnt := le.coaircraft_cnt <> ri.coaircraft_cnt;
    SELF.Diff_comarriagedivorce_score := le.comarriagedivorce_score <> ri.comarriagedivorce_score;
    SELF.Diff_comarriagedivorce_cnt := le.comarriagedivorce_cnt <> ri.comarriagedivorce_cnt;
    SELF.Diff_coucc_score := le.coucc_score <> ri.coucc_score;
    SELF.Diff_coucc_cnt := le.coucc_cnt <> ri.coucc_cnt;
    SELF.Diff_lname_score := le.lname_score <> ri.lname_score;
    SELF.Diff_phone_score := le.phone_score <> ri.phone_score;
    SELF.Diff_dl_nbr_score := le.dl_nbr_score <> ri.dl_nbr_score;
    SELF.Diff_total_cnt := le.total_cnt <> ri.total_cnt;
    SELF.Diff_total_score := le.total_score <> ri.total_score;
    SELF.Diff_cluster := le.cluster <> ri.cluster;
    SELF.Diff_generation := le.generation <> ri.generation;
    SELF.Diff_gender := le.gender <> ri.gender;
    SELF.Diff_lname_cnt := le.lname_cnt <> ri.lname_cnt;
    SELF.Diff_rel_dt_first_seen := le.rel_dt_first_seen <> ri.rel_dt_first_seen;
    SELF.Diff_rel_dt_last_seen := le.rel_dt_last_seen <> ri.rel_dt_last_seen;
    SELF.Diff_overlap_months := le.overlap_months <> ri.overlap_months;
    SELF.Diff_hdr_dt_first_seen := le.hdr_dt_first_seen <> ri.hdr_dt_first_seen;
    SELF.Diff_hdr_dt_last_seen := le.hdr_dt_last_seen <> ri.hdr_dt_last_seen;
    SELF.Diff_age_first_seen := le.age_first_seen <> ri.age_first_seen;
    SELF.Diff_isanylnamematch := le.isanylnamematch <> ri.isanylnamematch;
    SELF.Diff_isanyphonematch := le.isanyphonematch <> ri.isanyphonematch;
    SELF.Diff_isearlylnamematch := le.isearlylnamematch <> ri.isearlylnamematch;
    SELF.Diff_iscurrlnamematch := le.iscurrlnamematch <> ri.iscurrlnamematch;
    SELF.Diff_ismixedlnamematch := le.ismixedlnamematch <> ri.ismixedlnamematch;
    SELF.Diff_ssn1 := le.ssn1 <> ri.ssn1;
    SELF.Diff_ssn2 := le.ssn2 <> ri.ssn2;
    SELF.Diff_dob1 := le.dob1 <> ri.dob1;
    SELF.Diff_dob2 := le.dob2 <> ri.dob2;
    SELF.Diff_current_lname1 := le.current_lname1 <> ri.current_lname1;
    SELF.Diff_current_lname2 := le.current_lname2 <> ri.current_lname2;
    SELF.Diff_early_lname1 := le.early_lname1 <> ri.early_lname1;
    SELF.Diff_early_lname2 := le.early_lname2 <> ri.early_lname2;
    SELF.Diff_addr_ind1 := le.addr_ind1 <> ri.addr_ind1;
    SELF.Diff_addr_ind2 := le.addr_ind2 <> ri.addr_ind2;
    SELF.Diff_r2rdid := le.r2rdid <> ri.r2rdid;
    SELF.Diff_r2cnt := le.r2cnt <> ri.r2cnt;
    SELF.Diff_personal := le.personal <> ri.personal;
    SELF.Diff_business := le.business <> ri.business;
    SELF.Diff_other := le.other <> ri.other;
    SELF.Diff_title := le.title <> ri.title;
    SELF.Val := (SALT39.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_type,1,0)+ IF( SELF.Diff_confidence,1,0)+ IF( SELF.Diff_did1,1,0)+ IF( SELF.Diff_did2,1,0)+ IF( SELF.Diff_cohabit_score,1,0)+ IF( SELF.Diff_cohabit_cnt,1,0)+ IF( SELF.Diff_coapt_score,1,0)+ IF( SELF.Diff_coapt_cnt,1,0)+ IF( SELF.Diff_copobox_score,1,0)+ IF( SELF.Diff_copobox_cnt,1,0)+ IF( SELF.Diff_cossn_score,1,0)+ IF( SELF.Diff_cossn_cnt,1,0)+ IF( SELF.Diff_copolicy_score,1,0)+ IF( SELF.Diff_copolicy_cnt,1,0)+ IF( SELF.Diff_coclaim_score,1,0)+ IF( SELF.Diff_coclaim_cnt,1,0)+ IF( SELF.Diff_coproperty_score,1,0)+ IF( SELF.Diff_coproperty_cnt,1,0)+ IF( SELF.Diff_bcoproperty_score,1,0)+ IF( SELF.Diff_bcoproperty_cnt,1,0)+ IF( SELF.Diff_coforeclosure_score,1,0)+ IF( SELF.Diff_coforeclosure_cnt,1,0)+ IF( SELF.Diff_bcoforeclosure_score,1,0)+ IF( SELF.Diff_bcoforeclosure_cnt,1,0)+ IF( SELF.Diff_colien_score,1,0)+ IF( SELF.Diff_colien_cnt,1,0)+ IF( SELF.Diff_bcolien_score,1,0)+ IF( SELF.Diff_bcolien_cnt,1,0)+ IF( SELF.Diff_cobankruptcy_score,1,0)+ IF( SELF.Diff_cobankruptcy_cnt,1,0)+ IF( SELF.Diff_bcobankruptcy_score,1,0)+ IF( SELF.Diff_bcobankruptcy_cnt,1,0)+ IF( SELF.Diff_covehicle_score,1,0)+ IF( SELF.Diff_covehicle_cnt,1,0)+ IF( SELF.Diff_coexperian_score,1,0)+ IF( SELF.Diff_coexperian_cnt,1,0)+ IF( SELF.Diff_cotransunion_score,1,0)+ IF( SELF.Diff_cotransunion_cnt,1,0)+ IF( SELF.Diff_coenclarity_score,1,0)+ IF( SELF.Diff_coenclarity_cnt,1,0)+ IF( SELF.Diff_coecrash_score,1,0)+ IF( SELF.Diff_coecrash_cnt,1,0)+ IF( SELF.Diff_bcoecrash_score,1,0)+ IF( SELF.Diff_bcoecrash_cnt,1,0)+ IF( SELF.Diff_cowatercraft_score,1,0)+ IF( SELF.Diff_cowatercraft_cnt,1,0)+ IF( SELF.Diff_coaircraft_score,1,0)+ IF( SELF.Diff_coaircraft_cnt,1,0)+ IF( SELF.Diff_comarriagedivorce_score,1,0)+ IF( SELF.Diff_comarriagedivorce_cnt,1,0)+ IF( SELF.Diff_coucc_score,1,0)+ IF( SELF.Diff_coucc_cnt,1,0)+ IF( SELF.Diff_lname_score,1,0)+ IF( SELF.Diff_phone_score,1,0)+ IF( SELF.Diff_dl_nbr_score,1,0)+ IF( SELF.Diff_total_cnt,1,0)+ IF( SELF.Diff_total_score,1,0)+ IF( SELF.Diff_cluster,1,0)+ IF( SELF.Diff_generation,1,0)+ IF( SELF.Diff_gender,1,0)+ IF( SELF.Diff_lname_cnt,1,0)+ IF( SELF.Diff_rel_dt_first_seen,1,0)+ IF( SELF.Diff_rel_dt_last_seen,1,0)+ IF( SELF.Diff_overlap_months,1,0)+ IF( SELF.Diff_hdr_dt_first_seen,1,0)+ IF( SELF.Diff_hdr_dt_last_seen,1,0)+ IF( SELF.Diff_age_first_seen,1,0)+ IF( SELF.Diff_isanylnamematch,1,0)+ IF( SELF.Diff_isanyphonematch,1,0)+ IF( SELF.Diff_isearlylnamematch,1,0)+ IF( SELF.Diff_iscurrlnamematch,1,0)+ IF( SELF.Diff_ismixedlnamematch,1,0)+ IF( SELF.Diff_ssn1,1,0)+ IF( SELF.Diff_ssn2,1,0)+ IF( SELF.Diff_dob1,1,0)+ IF( SELF.Diff_dob2,1,0)+ IF( SELF.Diff_current_lname1,1,0)+ IF( SELF.Diff_current_lname2,1,0)+ IF( SELF.Diff_early_lname1,1,0)+ IF( SELF.Diff_early_lname2,1,0)+ IF( SELF.Diff_addr_ind1,1,0)+ IF( SELF.Diff_addr_ind2,1,0)+ IF( SELF.Diff_r2rdid,1,0)+ IF( SELF.Diff_r2cnt,1,0)+ IF( SELF.Diff_personal,1,0)+ IF( SELF.Diff_business,1,0)+ IF( SELF.Diff_other,1,0)+ IF( SELF.Diff_title,1,0);
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
    Count_Diff_type := COUNT(GROUP,%Closest%.Diff_type);
    Count_Diff_confidence := COUNT(GROUP,%Closest%.Diff_confidence);
    Count_Diff_did1 := COUNT(GROUP,%Closest%.Diff_did1);
    Count_Diff_did2 := COUNT(GROUP,%Closest%.Diff_did2);
    Count_Diff_cohabit_score := COUNT(GROUP,%Closest%.Diff_cohabit_score);
    Count_Diff_cohabit_cnt := COUNT(GROUP,%Closest%.Diff_cohabit_cnt);
    Count_Diff_coapt_score := COUNT(GROUP,%Closest%.Diff_coapt_score);
    Count_Diff_coapt_cnt := COUNT(GROUP,%Closest%.Diff_coapt_cnt);
    Count_Diff_copobox_score := COUNT(GROUP,%Closest%.Diff_copobox_score);
    Count_Diff_copobox_cnt := COUNT(GROUP,%Closest%.Diff_copobox_cnt);
    Count_Diff_cossn_score := COUNT(GROUP,%Closest%.Diff_cossn_score);
    Count_Diff_cossn_cnt := COUNT(GROUP,%Closest%.Diff_cossn_cnt);
    Count_Diff_copolicy_score := COUNT(GROUP,%Closest%.Diff_copolicy_score);
    Count_Diff_copolicy_cnt := COUNT(GROUP,%Closest%.Diff_copolicy_cnt);
    Count_Diff_coclaim_score := COUNT(GROUP,%Closest%.Diff_coclaim_score);
    Count_Diff_coclaim_cnt := COUNT(GROUP,%Closest%.Diff_coclaim_cnt);
    Count_Diff_coproperty_score := COUNT(GROUP,%Closest%.Diff_coproperty_score);
    Count_Diff_coproperty_cnt := COUNT(GROUP,%Closest%.Diff_coproperty_cnt);
    Count_Diff_bcoproperty_score := COUNT(GROUP,%Closest%.Diff_bcoproperty_score);
    Count_Diff_bcoproperty_cnt := COUNT(GROUP,%Closest%.Diff_bcoproperty_cnt);
    Count_Diff_coforeclosure_score := COUNT(GROUP,%Closest%.Diff_coforeclosure_score);
    Count_Diff_coforeclosure_cnt := COUNT(GROUP,%Closest%.Diff_coforeclosure_cnt);
    Count_Diff_bcoforeclosure_score := COUNT(GROUP,%Closest%.Diff_bcoforeclosure_score);
    Count_Diff_bcoforeclosure_cnt := COUNT(GROUP,%Closest%.Diff_bcoforeclosure_cnt);
    Count_Diff_colien_score := COUNT(GROUP,%Closest%.Diff_colien_score);
    Count_Diff_colien_cnt := COUNT(GROUP,%Closest%.Diff_colien_cnt);
    Count_Diff_bcolien_score := COUNT(GROUP,%Closest%.Diff_bcolien_score);
    Count_Diff_bcolien_cnt := COUNT(GROUP,%Closest%.Diff_bcolien_cnt);
    Count_Diff_cobankruptcy_score := COUNT(GROUP,%Closest%.Diff_cobankruptcy_score);
    Count_Diff_cobankruptcy_cnt := COUNT(GROUP,%Closest%.Diff_cobankruptcy_cnt);
    Count_Diff_bcobankruptcy_score := COUNT(GROUP,%Closest%.Diff_bcobankruptcy_score);
    Count_Diff_bcobankruptcy_cnt := COUNT(GROUP,%Closest%.Diff_bcobankruptcy_cnt);
    Count_Diff_covehicle_score := COUNT(GROUP,%Closest%.Diff_covehicle_score);
    Count_Diff_covehicle_cnt := COUNT(GROUP,%Closest%.Diff_covehicle_cnt);
    Count_Diff_coexperian_score := COUNT(GROUP,%Closest%.Diff_coexperian_score);
    Count_Diff_coexperian_cnt := COUNT(GROUP,%Closest%.Diff_coexperian_cnt);
    Count_Diff_cotransunion_score := COUNT(GROUP,%Closest%.Diff_cotransunion_score);
    Count_Diff_cotransunion_cnt := COUNT(GROUP,%Closest%.Diff_cotransunion_cnt);
    Count_Diff_coenclarity_score := COUNT(GROUP,%Closest%.Diff_coenclarity_score);
    Count_Diff_coenclarity_cnt := COUNT(GROUP,%Closest%.Diff_coenclarity_cnt);
    Count_Diff_coecrash_score := COUNT(GROUP,%Closest%.Diff_coecrash_score);
    Count_Diff_coecrash_cnt := COUNT(GROUP,%Closest%.Diff_coecrash_cnt);
    Count_Diff_bcoecrash_score := COUNT(GROUP,%Closest%.Diff_bcoecrash_score);
    Count_Diff_bcoecrash_cnt := COUNT(GROUP,%Closest%.Diff_bcoecrash_cnt);
    Count_Diff_cowatercraft_score := COUNT(GROUP,%Closest%.Diff_cowatercraft_score);
    Count_Diff_cowatercraft_cnt := COUNT(GROUP,%Closest%.Diff_cowatercraft_cnt);
    Count_Diff_coaircraft_score := COUNT(GROUP,%Closest%.Diff_coaircraft_score);
    Count_Diff_coaircraft_cnt := COUNT(GROUP,%Closest%.Diff_coaircraft_cnt);
    Count_Diff_comarriagedivorce_score := COUNT(GROUP,%Closest%.Diff_comarriagedivorce_score);
    Count_Diff_comarriagedivorce_cnt := COUNT(GROUP,%Closest%.Diff_comarriagedivorce_cnt);
    Count_Diff_coucc_score := COUNT(GROUP,%Closest%.Diff_coucc_score);
    Count_Diff_coucc_cnt := COUNT(GROUP,%Closest%.Diff_coucc_cnt);
    Count_Diff_lname_score := COUNT(GROUP,%Closest%.Diff_lname_score);
    Count_Diff_phone_score := COUNT(GROUP,%Closest%.Diff_phone_score);
    Count_Diff_dl_nbr_score := COUNT(GROUP,%Closest%.Diff_dl_nbr_score);
    Count_Diff_total_cnt := COUNT(GROUP,%Closest%.Diff_total_cnt);
    Count_Diff_total_score := COUNT(GROUP,%Closest%.Diff_total_score);
    Count_Diff_cluster := COUNT(GROUP,%Closest%.Diff_cluster);
    Count_Diff_generation := COUNT(GROUP,%Closest%.Diff_generation);
    Count_Diff_gender := COUNT(GROUP,%Closest%.Diff_gender);
    Count_Diff_lname_cnt := COUNT(GROUP,%Closest%.Diff_lname_cnt);
    Count_Diff_rel_dt_first_seen := COUNT(GROUP,%Closest%.Diff_rel_dt_first_seen);
    Count_Diff_rel_dt_last_seen := COUNT(GROUP,%Closest%.Diff_rel_dt_last_seen);
    Count_Diff_overlap_months := COUNT(GROUP,%Closest%.Diff_overlap_months);
    Count_Diff_hdr_dt_first_seen := COUNT(GROUP,%Closest%.Diff_hdr_dt_first_seen);
    Count_Diff_hdr_dt_last_seen := COUNT(GROUP,%Closest%.Diff_hdr_dt_last_seen);
    Count_Diff_age_first_seen := COUNT(GROUP,%Closest%.Diff_age_first_seen);
    Count_Diff_isanylnamematch := COUNT(GROUP,%Closest%.Diff_isanylnamematch);
    Count_Diff_isanyphonematch := COUNT(GROUP,%Closest%.Diff_isanyphonematch);
    Count_Diff_isearlylnamematch := COUNT(GROUP,%Closest%.Diff_isearlylnamematch);
    Count_Diff_iscurrlnamematch := COUNT(GROUP,%Closest%.Diff_iscurrlnamematch);
    Count_Diff_ismixedlnamematch := COUNT(GROUP,%Closest%.Diff_ismixedlnamematch);
    Count_Diff_ssn1 := COUNT(GROUP,%Closest%.Diff_ssn1);
    Count_Diff_ssn2 := COUNT(GROUP,%Closest%.Diff_ssn2);
    Count_Diff_dob1 := COUNT(GROUP,%Closest%.Diff_dob1);
    Count_Diff_dob2 := COUNT(GROUP,%Closest%.Diff_dob2);
    Count_Diff_current_lname1 := COUNT(GROUP,%Closest%.Diff_current_lname1);
    Count_Diff_current_lname2 := COUNT(GROUP,%Closest%.Diff_current_lname2);
    Count_Diff_early_lname1 := COUNT(GROUP,%Closest%.Diff_early_lname1);
    Count_Diff_early_lname2 := COUNT(GROUP,%Closest%.Diff_early_lname2);
    Count_Diff_addr_ind1 := COUNT(GROUP,%Closest%.Diff_addr_ind1);
    Count_Diff_addr_ind2 := COUNT(GROUP,%Closest%.Diff_addr_ind2);
    Count_Diff_r2rdid := COUNT(GROUP,%Closest%.Diff_r2rdid);
    Count_Diff_r2cnt := COUNT(GROUP,%Closest%.Diff_r2cnt);
    Count_Diff_personal := COUNT(GROUP,%Closest%.Diff_personal);
    Count_Diff_business := COUNT(GROUP,%Closest%.Diff_business);
    Count_Diff_other := COUNT(GROUP,%Closest%.Diff_other);
    Count_Diff_title := COUNT(GROUP,%Closest%.Diff_title);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
