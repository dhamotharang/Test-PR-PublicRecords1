IMPORT ut,SALT34;
EXPORT Fields := MODULE
 
// Processing for each FieldType
EXPORT SALT34.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'dt_first_seen','dt_last_seen','dt_vendor_first_reported','dt_vendor_last_reported','filetype','filedate','vendordocumentidentifier','transferdate','currentname_firstname','currentname_middlename','currentname_middleinitial','currentname_lastname','currentname_suffix','currentname_gender','currentname_dob_mm','currentname_dob_dd','currentname_dob_yyyy','currentname_deathindicator','ssnfull','ssnfirst5digit','ssnlast4digit','consumerupdatedate','telephonenumber','citedid','fileid','publication','currentaddress_address1','currentaddress_address2','currentaddress_city','currentaddress_state','currentaddress_zipcode','currentaddress_updateddate','housenumber','streettype','streetdirection','streetname','apartmentnumber','city','state','zipcode','zip4u','previousaddress_address1','previousaddress_address2','previousaddress_city','previousaddress_state','previousaddress_zipcode','previousaddress_updateddate','formername_firstname','formername_middlename','formername_middleinitial','formername_lastname','formername_suffix','aliasname_firstname','aliasname_middlename','aliasname_middleinitial','aliasname_lastname','aliasname_suffix','additionalname_firstname','additionalname_middlename','additionalname_middleinitial','additionalname_lastname','additionalname_suffix','aka1','aka2','aka3','recordtype','addressstandardization','filesincedate','compilationdate','birthdateind','orig_deceasedindicator','deceaseddate','addressseq','normaddress_address1','normaddress_address2','normaddress_city','normaddress_state','normaddress_zipcode','normaddress_updateddate','name','nametype','title','fname','mname','lname','name_suffix','name_score','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dbpc','chk_digit','rec_type','county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','transferdate_unformatted','birthdate_unformatted','dob_no_conflict','updatedate_unformatted','consumerupdatedate_unformatted','filesincedate_unformatted','compilationdate_unformatted','ssn_unformatted','ssn_no_conflict','telephone_unformatted','deceasedindicator','did','did_score_field','is_current');
EXPORT FieldTypeNum(SALT34.StrType fn) := CASE(fn,'dt_first_seen' => 1,'dt_last_seen' => 2,'dt_vendor_first_reported' => 3,'dt_vendor_last_reported' => 4,'filetype' => 5,'filedate' => 6,'vendordocumentidentifier' => 7,'transferdate' => 8,'currentname_firstname' => 9,'currentname_middlename' => 10,'currentname_middleinitial' => 11,'currentname_lastname' => 12,'currentname_suffix' => 13,'currentname_gender' => 14,'currentname_dob_mm' => 15,'currentname_dob_dd' => 16,'currentname_dob_yyyy' => 17,'currentname_deathindicator' => 18,'ssnfull' => 19,'ssnfirst5digit' => 20,'ssnlast4digit' => 21,'consumerupdatedate' => 22,'telephonenumber' => 23,'citedid' => 24,'fileid' => 25,'publication' => 26,'currentaddress_address1' => 27,'currentaddress_address2' => 28,'currentaddress_city' => 29,'currentaddress_state' => 30,'currentaddress_zipcode' => 31,'currentaddress_updateddate' => 32,'housenumber' => 33,'streettype' => 34,'streetdirection' => 35,'streetname' => 36,'apartmentnumber' => 37,'city' => 38,'state' => 39,'zipcode' => 40,'zip4u' => 41,'previousaddress_address1' => 42,'previousaddress_address2' => 43,'previousaddress_city' => 44,'previousaddress_state' => 45,'previousaddress_zipcode' => 46,'previousaddress_updateddate' => 47,'formername_firstname' => 48,'formername_middlename' => 49,'formername_middleinitial' => 50,'formername_lastname' => 51,'formername_suffix' => 52,'aliasname_firstname' => 53,'aliasname_middlename' => 54,'aliasname_middleinitial' => 55,'aliasname_lastname' => 56,'aliasname_suffix' => 57,'additionalname_firstname' => 58,'additionalname_middlename' => 59,'additionalname_middleinitial' => 60,'additionalname_lastname' => 61,'additionalname_suffix' => 62,'aka1' => 63,'aka2' => 64,'aka3' => 65,'recordtype' => 66,'addressstandardization' => 67,'filesincedate' => 68,'compilationdate' => 69,'birthdateind' => 70,'orig_deceasedindicator' => 71,'deceaseddate' => 72,'addressseq' => 73,'normaddress_address1' => 74,'normaddress_address2' => 75,'normaddress_city' => 76,'normaddress_state' => 77,'normaddress_zipcode' => 78,'normaddress_updateddate' => 79,'name' => 80,'nametype' => 81,'title' => 82,'fname' => 83,'mname' => 84,'lname' => 85,'name_suffix' => 86,'name_score' => 87,'prim_range' => 88,'predir' => 89,'prim_name' => 90,'addr_suffix' => 91,'postdir' => 92,'unit_desig' => 93,'sec_range' => 94,'p_city_name' => 95,'v_city_name' => 96,'st' => 97,'zip' => 98,'zip4' => 99,'cart' => 100,'cr_sort_sz' => 101,'lot' => 102,'lot_order' => 103,'dbpc' => 104,'chk_digit' => 105,'rec_type' => 106,'county' => 107,'geo_lat' => 108,'geo_long' => 109,'msa' => 110,'geo_blk' => 111,'geo_match' => 112,'err_stat' => 113,'transferdate_unformatted' => 114,'birthdate_unformatted' => 115,'dob_no_conflict' => 116,'updatedate_unformatted' => 117,'consumerupdatedate_unformatted' => 118,'filesincedate_unformatted' => 119,'compilationdate_unformatted' => 120,'ssn_unformatted' => 121,'ssn_no_conflict' => 122,'telephone_unformatted' => 123,'deceasedindicator' => 124,'did' => 125,'did_score_field' => 126,'is_current' => 127,0);
 
EXPORT MakeFT_dt_first_seen(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT34.stringcleanspaces( SALT34.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_dt_first_seen(SALT34.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 8),~(SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_dt_first_seen(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotLeft,SALT34.HygieneErrors.NotInChars('0123456789 '),SALT34.HygieneErrors.NotLength('8'),SALT34.HygieneErrors.NotWords('1'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_dt_last_seen(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT34.stringcleanspaces( SALT34.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_dt_last_seen(SALT34.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 8),~(SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_dt_last_seen(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotLeft,SALT34.HygieneErrors.NotInChars('0123456789 '),SALT34.HygieneErrors.NotLength('8'),SALT34.HygieneErrors.NotWords('1'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_dt_vendor_first_reported(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT34.stringcleanspaces( SALT34.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_dt_vendor_first_reported(SALT34.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 8),~(SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_dt_vendor_first_reported(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotLeft,SALT34.HygieneErrors.NotInChars('0123456789 '),SALT34.HygieneErrors.NotLength('8'),SALT34.HygieneErrors.NotWords('1'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_dt_vendor_last_reported(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT34.stringcleanspaces( SALT34.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_dt_vendor_last_reported(SALT34.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 8),~(SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_dt_vendor_last_reported(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotLeft,SALT34.HygieneErrors.NotInChars('0123456789 '),SALT34.HygieneErrors.NotLength('8'),SALT34.HygieneErrors.NotWords('1'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_filetype(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,'FU '); // Only allow valid symbols
  s2 := SALT34.stringcleanspaces( SALT34.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_filetype(SALT34.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,'FU '))),~(LENGTH(TRIM(s)) = 1),~(SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_filetype(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotLeft,SALT34.HygieneErrors.NotInChars('FU '),SALT34.HygieneErrors.NotLength('1'),SALT34.HygieneErrors.NotWords('1'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_filedate(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT34.stringcleanspaces( SALT34.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_filedate(SALT34.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 8 OR LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 6),~(SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_filedate(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotLeft,SALT34.HygieneErrors.NotInChars('0123456789 '),SALT34.HygieneErrors.NotLength('8,0,6'),SALT34.HygieneErrors.NotWords('1'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_vendordocumentidentifier(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT34.stringcleanspaces( SALT34.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_vendordocumentidentifier(SALT34.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 12),~(SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_vendordocumentidentifier(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotLeft,SALT34.HygieneErrors.NotInChars('0123456789 '),SALT34.HygieneErrors.NotLength('12'),SALT34.HygieneErrors.NotWords('1'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_transferdate(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,'/0123456789 '); // Only allow valid symbols
  s2 := SALT34.stringcleanspaces( SALT34.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_transferdate(SALT34.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,'/0123456789 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 10),~(SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_transferdate(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotLeft,SALT34.HygieneErrors.NotInChars('/0123456789 '),SALT34.HygieneErrors.NotLength('0,10'),SALT34.HygieneErrors.NotWords('1'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_currentname_firstname(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWYZ '); // Only allow valid symbols
  s2 := SALT34.stringcleanspaces( SALT34.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_currentname_firstname(SALT34.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWYZ '))),~(LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 6 OR LENGTH(TRIM(s)) = 7 OR LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 8 OR LENGTH(TRIM(s)) = 3 OR LENGTH(TRIM(s)) = 9 OR LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 10 OR LENGTH(TRIM(s)) = 11 OR LENGTH(TRIM(s)) = 2),~(SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_currentname_firstname(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotLeft,SALT34.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWYZ '),SALT34.HygieneErrors.NotLength('5,6,7,4,8,3,9,1,10,11,2'),SALT34.HygieneErrors.NotWords('1'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_currentname_middlename(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWYZ '); // Only allow valid symbols
  s2 := SALT34.stringcleanspaces( SALT34.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_currentname_middlename(SALT34.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWYZ '))),~(LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 3 OR LENGTH(TRIM(s)) = 6 OR LENGTH(TRIM(s)) = 7 OR LENGTH(TRIM(s)) = 8 OR LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 9),~(SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_currentname_middlename(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotLeft,SALT34.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWYZ '),SALT34.HygieneErrors.NotLength('1,0,5,4,3,6,7,8,2,9'),SALT34.HygieneErrors.NotWords('1'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_currentname_middleinitial(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWYZ '); // Only allow valid symbols
  s2 := SALT34.stringcleanspaces( SALT34.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_currentname_middleinitial(SALT34.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWYZ '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 1),~(SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_currentname_middleinitial(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotLeft,SALT34.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWYZ '),SALT34.HygieneErrors.NotLength('0,1'),SALT34.HygieneErrors.NotWords('1'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_currentname_lastname(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT34.stringcleanspaces( SALT34.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_currentname_lastname(SALT34.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ '))),~(LENGTH(TRIM(s)) = 6 OR LENGTH(TRIM(s)) = 7 OR LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 8 OR LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 9 OR LENGTH(TRIM(s)) = 10 OR LENGTH(TRIM(s)) = 3 OR LENGTH(TRIM(s)) = 11 OR LENGTH(TRIM(s)) = 12 OR LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 13 OR LENGTH(TRIM(s)) = 14 OR LENGTH(TRIM(s)) = 15),~(SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 1 OR SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 2));
EXPORT InValidMessageFT_currentname_lastname(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotLeft,SALT34.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT34.HygieneErrors.NotLength('6,7,5,8,4,9,10,3,11,12,2,13,14,15'),SALT34.HygieneErrors.NotWords('1,2'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_currentname_suffix(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,'DIJRSV '); // Only allow valid symbols
  s2 := SALT34.stringcleanspaces( SALT34.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_currentname_suffix(SALT34.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,'DIJRSV '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 3),~(SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_currentname_suffix(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotInChars('DIJRSV '),SALT34.HygieneErrors.NotLength('0,2,3'),SALT34.HygieneErrors.NotWords('1'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_currentname_gender(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,' '); // Only allow valid symbols
  s2 := SALT34.stringcleanspaces( SALT34.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_currentname_gender(SALT34.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,' '))),~(LENGTH(TRIM(s)) = 0),~(SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_currentname_gender(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotLeft,SALT34.HygieneErrors.NotInChars(' '),SALT34.HygieneErrors.NotLength('0'),SALT34.HygieneErrors.NotWords('1'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_currentname_dob_mm(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT34.stringcleanspaces( SALT34.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_currentname_dob_mm(SALT34.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 1),~(SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_currentname_dob_mm(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotLeft,SALT34.HygieneErrors.NotInChars('0123456789 '),SALT34.HygieneErrors.NotLength('2,0,1'),SALT34.HygieneErrors.NotWords('1'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_currentname_dob_dd(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT34.stringcleanspaces( SALT34.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_currentname_dob_dd(SALT34.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 1),~(SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_currentname_dob_dd(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotLeft,SALT34.HygieneErrors.NotInChars('0123456789 '),SALT34.HygieneErrors.NotLength('2,0,1'),SALT34.HygieneErrors.NotWords('1'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_currentname_dob_yyyy(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT34.stringcleanspaces( SALT34.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_currentname_dob_yyyy(SALT34.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 0),~(SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_currentname_dob_yyyy(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotLeft,SALT34.HygieneErrors.NotInChars('0123456789 '),SALT34.HygieneErrors.NotLength('4,0'),SALT34.HygieneErrors.NotWords('1'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_currentname_deathindicator(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,'ACDESY '); // Only allow valid symbols
  s2 := SALT34.stringcleanspaces( SALT34.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_currentname_deathindicator(SALT34.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,'ACDESY '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 8),~(SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_currentname_deathindicator(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotLeft,SALT34.HygieneErrors.NotInChars('ACDESY '),SALT34.HygieneErrors.NotLength('0,1,8'),SALT34.HygieneErrors.NotWords('1'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_ssnfull(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT34.stringcleanspaces( SALT34.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_ssnfull(SALT34.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 9 OR LENGTH(TRIM(s)) = 0),~(SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_ssnfull(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotLeft,SALT34.HygieneErrors.NotInChars('0123456789 '),SALT34.HygieneErrors.NotLength('9,0'),SALT34.HygieneErrors.NotWords('1'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_ssnfirst5digit(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,'-0123456789 '); // Only allow valid symbols
  s2 := SALT34.stringcleanspaces( SALT34.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_ssnfirst5digit(SALT34.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,'-0123456789 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 6),~(SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_ssnfirst5digit(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotLeft,SALT34.HygieneErrors.NotInChars('-0123456789 '),SALT34.HygieneErrors.NotLength('0,6'),SALT34.HygieneErrors.NotWords('1'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_ssnlast4digit(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT34.stringcleanspaces( SALT34.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_ssnlast4digit(SALT34.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 4),~(SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_ssnlast4digit(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotLeft,SALT34.HygieneErrors.NotInChars('0123456789 '),SALT34.HygieneErrors.NotLength('0,4'),SALT34.HygieneErrors.NotWords('1'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_consumerupdatedate(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,' '); // Only allow valid symbols
  s2 := SALT34.stringcleanspaces( SALT34.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_consumerupdatedate(SALT34.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,' '))),~(LENGTH(TRIM(s)) = 0),~(SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_consumerupdatedate(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotLeft,SALT34.HygieneErrors.NotInChars(' '),SALT34.HygieneErrors.NotLength('0'),SALT34.HygieneErrors.NotWords('1'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_telephonenumber(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,'-0123456789 '); // Only allow valid symbols
  s2 := SALT34.stringcleanspaces( SALT34.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_telephonenumber(SALT34.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,'-0123456789 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 7 OR LENGTH(TRIM(s)) = 8),~(SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_telephonenumber(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotLeft,SALT34.HygieneErrors.NotInChars('-0123456789 '),SALT34.HygieneErrors.NotLength('0,7,8'),SALT34.HygieneErrors.NotWords('1'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_citedid(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,'-AKPRT '); // Only allow valid symbols
  s2 := SALT34.stringcleanspaces( SALT34.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_citedid(SALT34.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,'-AKPRT '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 6),~(SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_citedid(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotLeft,SALT34.HygieneErrors.NotInChars('-AKPRT '),SALT34.HygieneErrors.NotLength('0,6'),SALT34.HygieneErrors.NotWords('1'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_fileid(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,'-AKPRT '); // Only allow valid symbols
  s2 := SALT34.stringcleanspaces( SALT34.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_fileid(SALT34.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,'-AKPRT '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 6),~(SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_fileid(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotLeft,SALT34.HygieneErrors.NotInChars('-AKPRT '),SALT34.HygieneErrors.NotLength('0,6'),SALT34.HygieneErrors.NotWords('1'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_publication(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,' -ACEKLNOPRST '); // Only allow valid symbols
  s2 := SALT34.stringcleanspaces( SALT34.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_publication(SALT34.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,' -ACEKLNOPRST '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 23),~(SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 1 OR SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 4));
EXPORT InValidMessageFT_publication(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotLeft,SALT34.HygieneErrors.NotInChars(' -ACEKLNOPRST '),SALT34.HygieneErrors.NotLength('0,23'),SALT34.HygieneErrors.NotWords('1,4'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_currentaddress_address1(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,' .0123456789ABCDEFGHIJKLMNOPRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT34.stringcleanspaces( SALT34.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_currentaddress_address1(SALT34.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,' .0123456789ABCDEFGHIJKLMNOPRSTUVWXYZ '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 15 OR LENGTH(TRIM(s)) = 16 OR LENGTH(TRIM(s)) = 14 OR LENGTH(TRIM(s)) = 17 OR LENGTH(TRIM(s)) = 13 OR LENGTH(TRIM(s)) = 18 OR LENGTH(TRIM(s)) = 12 OR LENGTH(TRIM(s)) = 19 OR LENGTH(TRIM(s)) = 20 OR LENGTH(TRIM(s)) = 11 OR LENGTH(TRIM(s)) = 21 OR LENGTH(TRIM(s)) = 10 OR LENGTH(TRIM(s)) = 22 OR LENGTH(TRIM(s)) = 23 OR LENGTH(TRIM(s)) = 24 OR LENGTH(TRIM(s)) = 25 OR LENGTH(TRIM(s)) = 26 OR LENGTH(TRIM(s)) = 27 OR LENGTH(TRIM(s)) = 28 OR LENGTH(TRIM(s)) = 9 OR LENGTH(TRIM(s)) = 29 OR LENGTH(TRIM(s)) = 30 OR LENGTH(TRIM(s)) = 31 OR LENGTH(TRIM(s)) = 32),~(SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 1 OR SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 3 OR SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 4 OR SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 5 OR SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 6 OR SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 7));
EXPORT InValidMessageFT_currentaddress_address1(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotLeft,SALT34.HygieneErrors.NotInChars(' .0123456789ABCDEFGHIJKLMNOPRSTUVWXYZ '),SALT34.HygieneErrors.NotLength('0,15,16,14,17,13,18,12,19,20,11,21,10,22,23,24,25,26,27,28,9,29,30,31,32'),SALT34.HygieneErrors.NotWords('1,3,4,5,6,7'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_currentaddress_address2(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,' '); // Only allow valid symbols
  s2 := SALT34.stringcleanspaces( SALT34.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_currentaddress_address2(SALT34.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,' '))),~(LENGTH(TRIM(s)) = 0),~(SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_currentaddress_address2(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotLeft,SALT34.HygieneErrors.NotInChars(' '),SALT34.HygieneErrors.NotLength('0'),SALT34.HygieneErrors.NotWords('1'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_currentaddress_city(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,' ABCDEFGHIJKLMNOPQRSTUVWXY '); // Only allow valid symbols
  s2 := SALT34.stringcleanspaces( SALT34.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_currentaddress_city(SALT34.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,' ABCDEFGHIJKLMNOPQRSTUVWXY '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 7 OR LENGTH(TRIM(s)) = 8 OR LENGTH(TRIM(s)) = 9 OR LENGTH(TRIM(s)) = 10 OR LENGTH(TRIM(s)) = 6 OR LENGTH(TRIM(s)) = 11 OR LENGTH(TRIM(s)) = 12 OR LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 13 OR LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 14 OR LENGTH(TRIM(s)) = 16 OR LENGTH(TRIM(s)) = 15 OR LENGTH(TRIM(s)) = 17 OR LENGTH(TRIM(s)) = 18),~(SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 1 OR SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 2 OR SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 3));
EXPORT InValidMessageFT_currentaddress_city(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotLeft,SALT34.HygieneErrors.NotInChars(' ABCDEFGHIJKLMNOPQRSTUVWXY '),SALT34.HygieneErrors.NotLength('0,7,8,9,10,6,11,12,5,13,4,14,16,15,17,18'),SALT34.HygieneErrors.NotWords('1,2,3'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_currentaddress_state(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,'ACDEFGHIJKLMNOPRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT34.stringcleanspaces( SALT34.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_currentaddress_state(SALT34.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,'ACDEFGHIJKLMNOPRSTUVWXYZ '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 2),~(SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_currentaddress_state(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotLeft,SALT34.HygieneErrors.NotInChars('ACDEFGHIJKLMNOPRSTUVWXYZ '),SALT34.HygieneErrors.NotLength('0,2'),SALT34.HygieneErrors.NotWords('1'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_currentaddress_zipcode(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,'-0123456789 '); // Only allow valid symbols
  s2 := SALT34.stringcleanspaces( SALT34.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_currentaddress_zipcode(SALT34.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,'-0123456789 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 10 OR LENGTH(TRIM(s)) = 5),~(SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_currentaddress_zipcode(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotLeft,SALT34.HygieneErrors.NotInChars('-0123456789 '),SALT34.HygieneErrors.NotLength('0,10,5'),SALT34.HygieneErrors.NotWords('1'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_currentaddress_updateddate(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,'/0123456789 '); // Only allow valid symbols
  s2 := SALT34.stringcleanspaces( SALT34.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_currentaddress_updateddate(SALT34.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,'/0123456789 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 8 OR LENGTH(TRIM(s)) = 9 OR LENGTH(TRIM(s)) = 10),~(SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_currentaddress_updateddate(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotLeft,SALT34.HygieneErrors.NotInChars('/0123456789 '),SALT34.HygieneErrors.NotLength('0,8,9,10'),SALT34.HygieneErrors.NotWords('1'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_housenumber(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,' 0123456789W '); // Only allow valid symbols
  s2 := SALT34.stringcleanspaces( SALT34.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_housenumber(SALT34.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,' 0123456789W '))),~(LENGTH(TRIM(s)) = 6 OR LENGTH(TRIM(s)) = 0),~(SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_housenumber(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotInChars(' 0123456789W '),SALT34.HygieneErrors.NotLength('6,0'),SALT34.HygieneErrors.NotWords('1'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_streettype(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,'ABCDEGHIKLNOPQRSTUVWX '); // Only allow valid symbols
  s2 := SALT34.stringcleanspaces( SALT34.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_streettype(SALT34.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,'ABCDEGHIKLNOPQRSTUVWX '))),~(LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 0),~(SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_streettype(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotLeft,SALT34.HygieneErrors.NotInChars('ABCDEGHIKLNOPQRSTUVWX '),SALT34.HygieneErrors.NotLength('2,0'),SALT34.HygieneErrors.NotWords('1'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_streetdirection(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,'ENSW '); // Only allow valid symbols
  s2 := SALT34.stringcleanspaces( SALT34.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_streetdirection(SALT34.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,'ENSW '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 2),~(SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_streetdirection(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotLeft,SALT34.HygieneErrors.NotInChars('ENSW '),SALT34.HygieneErrors.NotLength('0,1,2'),SALT34.HygieneErrors.NotWords('1'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_streetname(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,' 0123456789ABCDEFGHIJKLMNOPRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT34.stringcleanspaces( SALT34.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_streetname(SALT34.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,' 0123456789ABCDEFGHIJKLMNOPRSTUVWXYZ '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 8 OR LENGTH(TRIM(s)) = 7 OR LENGTH(TRIM(s)) = 6 OR LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 9 OR LENGTH(TRIM(s)) = 10 OR LENGTH(TRIM(s)) = 11 OR LENGTH(TRIM(s)) = 12 OR LENGTH(TRIM(s)) = 3 OR LENGTH(TRIM(s)) = 13 OR LENGTH(TRIM(s)) = 14 OR LENGTH(TRIM(s)) = 15 OR LENGTH(TRIM(s)) = 16 OR LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 17 OR LENGTH(TRIM(s)) = 18 OR LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 19 OR LENGTH(TRIM(s)) = 21 OR LENGTH(TRIM(s)) = 20 OR LENGTH(TRIM(s)) = 27 OR LENGTH(TRIM(s)) = 22),~(SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 1 OR SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 2 OR SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 3 OR SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 4 OR SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 5 OR SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 6));
EXPORT InValidMessageFT_streetname(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotLeft,SALT34.HygieneErrors.NotInChars(' 0123456789ABCDEFGHIJKLMNOPRSTUVWXYZ '),SALT34.HygieneErrors.NotLength('0,8,7,6,4,5,9,10,11,12,3,13,14,15,16,1,17,18,2,19,21,20,27,22'),SALT34.HygieneErrors.NotWords('1,2,3,4,5,6'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_apartmentnumber(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,' -0123456789ABCDEFGHIJKLMNOPQRSTUW '); // Only allow valid symbols
  s2 := SALT34.stringcleanspaces( SALT34.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_apartmentnumber(SALT34.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,' -0123456789ABCDEFGHIJKLMNOPQRSTUW '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 3 OR LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 4),~(SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_apartmentnumber(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotInChars(' -0123456789ABCDEFGHIJKLMNOPQRSTUW '),SALT34.HygieneErrors.NotLength('0,5,3,1,2,4'),SALT34.HygieneErrors.NotWords('1'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_city(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,' ABCDEFGHIJKLMNOPQRSTUVWXY '); // Only allow valid symbols
  s2 := SALT34.stringcleanspaces( SALT34.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_city(SALT34.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,' ABCDEFGHIJKLMNOPQRSTUVWXY '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 7 OR LENGTH(TRIM(s)) = 8 OR LENGTH(TRIM(s)) = 9 OR LENGTH(TRIM(s)) = 6 OR LENGTH(TRIM(s)) = 10 OR LENGTH(TRIM(s)) = 11 OR LENGTH(TRIM(s)) = 12 OR LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 13 OR LENGTH(TRIM(s)) = 14 OR LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 16 OR LENGTH(TRIM(s)) = 15 OR LENGTH(TRIM(s)) = 17 OR LENGTH(TRIM(s)) = 18 OR LENGTH(TRIM(s)) = 3 OR LENGTH(TRIM(s)) = 19 OR LENGTH(TRIM(s)) = 20),~(SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 1 OR SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 2 OR SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 3));
EXPORT InValidMessageFT_city(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotLeft,SALT34.HygieneErrors.NotInChars(' ABCDEFGHIJKLMNOPQRSTUVWXY '),SALT34.HygieneErrors.NotLength('0,7,8,9,6,10,11,12,5,13,14,4,16,15,17,18,3,19,20'),SALT34.HygieneErrors.NotWords('1,2,3'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_state(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,'ACDEFGHIJKLMNOPRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT34.stringcleanspaces( SALT34.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_state(SALT34.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,'ACDEFGHIJKLMNOPRSTUVWXYZ '))),~(LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 0),~(SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_state(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotLeft,SALT34.HygieneErrors.NotInChars('ACDEFGHIJKLMNOPRSTUVWXYZ '),SALT34.HygieneErrors.NotLength('2,0'),SALT34.HygieneErrors.NotWords('1'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_zipcode(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT34.stringcleanspaces( SALT34.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_zipcode(SALT34.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 0),~(SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_zipcode(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotLeft,SALT34.HygieneErrors.NotInChars('0123456789 '),SALT34.HygieneErrors.NotLength('5,0'),SALT34.HygieneErrors.NotWords('1'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_zip4u(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT34.stringcleanspaces( SALT34.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_zip4u(SALT34.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 0),~(SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_zip4u(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotLeft,SALT34.HygieneErrors.NotInChars('0123456789 '),SALT34.HygieneErrors.NotLength('4,0'),SALT34.HygieneErrors.NotWords('1'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_previousaddress_address1(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,' .0123456789ABCDEFGHIJKLMNOPRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT34.stringcleanspaces( SALT34.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_previousaddress_address1(SALT34.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,' .0123456789ABCDEFGHIJKLMNOPRSTUVWXYZ '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 15 OR LENGTH(TRIM(s)) = 16 OR LENGTH(TRIM(s)) = 14 OR LENGTH(TRIM(s)) = 13 OR LENGTH(TRIM(s)) = 17 OR LENGTH(TRIM(s)) = 12 OR LENGTH(TRIM(s)) = 18 OR LENGTH(TRIM(s)) = 19 OR LENGTH(TRIM(s)) = 11 OR LENGTH(TRIM(s)) = 10 OR LENGTH(TRIM(s)) = 20 OR LENGTH(TRIM(s)) = 21 OR LENGTH(TRIM(s)) = 22 OR LENGTH(TRIM(s)) = 23 OR LENGTH(TRIM(s)) = 24 OR LENGTH(TRIM(s)) = 25 OR LENGTH(TRIM(s)) = 26 OR LENGTH(TRIM(s)) = 27 OR LENGTH(TRIM(s)) = 9 OR LENGTH(TRIM(s)) = 28 OR LENGTH(TRIM(s)) = 29 OR LENGTH(TRIM(s)) = 30 OR LENGTH(TRIM(s)) = 8 OR LENGTH(TRIM(s)) = 31 OR LENGTH(TRIM(s)) = 32),~(SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 1 OR SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 3 OR SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 4 OR SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 5 OR SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 6 OR SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 7 OR SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 2));
EXPORT InValidMessageFT_previousaddress_address1(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotLeft,SALT34.HygieneErrors.NotInChars(' .0123456789ABCDEFGHIJKLMNOPRSTUVWXYZ '),SALT34.HygieneErrors.NotLength('0,15,16,14,13,17,12,18,19,11,10,20,21,22,23,24,25,26,27,9,28,29,30,8,31,32'),SALT34.HygieneErrors.NotWords('1,3,4,5,6,7,2'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_previousaddress_address2(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,' '); // Only allow valid symbols
  s2 := SALT34.stringcleanspaces( SALT34.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_previousaddress_address2(SALT34.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,' '))),~(LENGTH(TRIM(s)) = 0),~(SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_previousaddress_address2(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotLeft,SALT34.HygieneErrors.NotInChars(' '),SALT34.HygieneErrors.NotLength('0'),SALT34.HygieneErrors.NotWords('1'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_previousaddress_city(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,' ABCDEFGHIJKLMNOPQRSTUVWXY '); // Only allow valid symbols
  s2 := SALT34.stringcleanspaces( SALT34.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_previousaddress_city(SALT34.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,' ABCDEFGHIJKLMNOPQRSTUVWXY '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 7 OR LENGTH(TRIM(s)) = 8 OR LENGTH(TRIM(s)) = 9 OR LENGTH(TRIM(s)) = 10 OR LENGTH(TRIM(s)) = 6 OR LENGTH(TRIM(s)) = 11 OR LENGTH(TRIM(s)) = 12 OR LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 13 OR LENGTH(TRIM(s)) = 14 OR LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 16 OR LENGTH(TRIM(s)) = 15 OR LENGTH(TRIM(s)) = 17 OR LENGTH(TRIM(s)) = 18),~(SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 1 OR SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 2 OR SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 3));
EXPORT InValidMessageFT_previousaddress_city(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotLeft,SALT34.HygieneErrors.NotInChars(' ABCDEFGHIJKLMNOPQRSTUVWXY '),SALT34.HygieneErrors.NotLength('0,7,8,9,10,6,11,12,5,13,14,4,16,15,17,18'),SALT34.HygieneErrors.NotWords('1,2,3'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_previousaddress_state(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,'ACDEFGHIJKLMNOPRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT34.stringcleanspaces( SALT34.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_previousaddress_state(SALT34.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,'ACDEFGHIJKLMNOPRSTUVWXYZ '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 2),~(SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_previousaddress_state(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotLeft,SALT34.HygieneErrors.NotInChars('ACDEFGHIJKLMNOPRSTUVWXYZ '),SALT34.HygieneErrors.NotLength('0,2'),SALT34.HygieneErrors.NotWords('1'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_previousaddress_zipcode(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,'-0123456789 '); // Only allow valid symbols
  s2 := SALT34.stringcleanspaces( SALT34.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_previousaddress_zipcode(SALT34.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,'-0123456789 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 10 OR LENGTH(TRIM(s)) = 5),~(SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_previousaddress_zipcode(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotLeft,SALT34.HygieneErrors.NotInChars('-0123456789 '),SALT34.HygieneErrors.NotLength('0,10,5'),SALT34.HygieneErrors.NotWords('1'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_previousaddress_updateddate(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,'/0123456789 '); // Only allow valid symbols
  s2 := SALT34.stringcleanspaces( SALT34.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_previousaddress_updateddate(SALT34.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,'/0123456789 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 8 OR LENGTH(TRIM(s)) = 9 OR LENGTH(TRIM(s)) = 10),~(SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_previousaddress_updateddate(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotLeft,SALT34.HygieneErrors.NotInChars('/0123456789 '),SALT34.HygieneErrors.NotLength('0,8,9,10'),SALT34.HygieneErrors.NotWords('1'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_formername_firstname(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,' '); // Only allow valid symbols
  s2 := SALT34.stringcleanspaces( SALT34.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_formername_firstname(SALT34.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,' '))),~(LENGTH(TRIM(s)) = 0),~(SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_formername_firstname(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotLeft,SALT34.HygieneErrors.NotInChars(' '),SALT34.HygieneErrors.NotLength('0'),SALT34.HygieneErrors.NotWords('1'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_formername_middlename(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,' '); // Only allow valid symbols
  s2 := SALT34.stringcleanspaces( SALT34.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_formername_middlename(SALT34.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,' '))),~(LENGTH(TRIM(s)) = 0),~(SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_formername_middlename(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotLeft,SALT34.HygieneErrors.NotInChars(' '),SALT34.HygieneErrors.NotLength('0'),SALT34.HygieneErrors.NotWords('1'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_formername_middleinitial(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,' '); // Only allow valid symbols
  s2 := SALT34.stringcleanspaces( SALT34.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_formername_middleinitial(SALT34.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,' '))),~(LENGTH(TRIM(s)) = 0),~(SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_formername_middleinitial(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotLeft,SALT34.HygieneErrors.NotInChars(' '),SALT34.HygieneErrors.NotLength('0'),SALT34.HygieneErrors.NotWords('1'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_formername_lastname(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,' '); // Only allow valid symbols
  s2 := SALT34.stringcleanspaces( SALT34.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_formername_lastname(SALT34.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,' '))),~(LENGTH(TRIM(s)) = 0),~(SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_formername_lastname(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotLeft,SALT34.HygieneErrors.NotInChars(' '),SALT34.HygieneErrors.NotLength('0'),SALT34.HygieneErrors.NotWords('1'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_formername_suffix(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,' '); // Only allow valid symbols
  s2 := SALT34.stringcleanspaces( SALT34.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_formername_suffix(SALT34.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,' '))),~(LENGTH(TRIM(s)) = 0),~(SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_formername_suffix(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotLeft,SALT34.HygieneErrors.NotInChars(' '),SALT34.HygieneErrors.NotLength('0'),SALT34.HygieneErrors.NotWords('1'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_aliasname_firstname(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWYZ '); // Only allow valid symbols
  s2 := SALT34.stringcleanspaces( SALT34.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_aliasname_firstname(SALT34.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWYZ '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 6 OR LENGTH(TRIM(s)) = 7 OR LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 8 OR LENGTH(TRIM(s)) = 3 OR LENGTH(TRIM(s)) = 9 OR LENGTH(TRIM(s)) = 10 OR LENGTH(TRIM(s)) = 2),~(SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_aliasname_firstname(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotLeft,SALT34.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWYZ '),SALT34.HygieneErrors.NotLength('0,5,6,7,4,1,8,3,9,10,2'),SALT34.HygieneErrors.NotWords('1'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_aliasname_middlename(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWYZ '); // Only allow valid symbols
  s2 := SALT34.stringcleanspaces( SALT34.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_aliasname_middlename(SALT34.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWYZ '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 6 OR LENGTH(TRIM(s)) = 3 OR LENGTH(TRIM(s)) = 7 OR LENGTH(TRIM(s)) = 8 OR LENGTH(TRIM(s)) = 2),~(SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_aliasname_middlename(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotLeft,SALT34.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWYZ '),SALT34.HygieneErrors.NotLength('0,1,5,4,6,3,7,8,2'),SALT34.HygieneErrors.NotWords('1'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_aliasname_middleinitial(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWYZ '); // Only allow valid symbols
  s2 := SALT34.stringcleanspaces( SALT34.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_aliasname_middleinitial(SALT34.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWYZ '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 1),~(SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_aliasname_middleinitial(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotLeft,SALT34.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWYZ '),SALT34.HygieneErrors.NotLength('0,1'),SALT34.HygieneErrors.NotWords('1'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_aliasname_lastname(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT34.stringcleanspaces( SALT34.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_aliasname_lastname(SALT34.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 6 OR LENGTH(TRIM(s)) = 7 OR LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 8 OR LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 9 OR LENGTH(TRIM(s)) = 10 OR LENGTH(TRIM(s)) = 3 OR LENGTH(TRIM(s)) = 11 OR LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 12),~(SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_aliasname_lastname(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotLeft,SALT34.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT34.HygieneErrors.NotLength('0,6,7,5,8,4,9,10,3,11,2,12'),SALT34.HygieneErrors.NotWords('1'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_aliasname_suffix(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,'DEIJRSV '); // Only allow valid symbols
  s2 := SALT34.stringcleanspaces( SALT34.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_aliasname_suffix(SALT34.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,'DEIJRSV '))),~(LENGTH(TRIM(s)) = 0),~(SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_aliasname_suffix(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotLeft,SALT34.HygieneErrors.NotInChars('DEIJRSV '),SALT34.HygieneErrors.NotLength('0'),SALT34.HygieneErrors.NotWords('1'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_additionalname_firstname(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,' '); // Only allow valid symbols
  s2 := SALT34.stringcleanspaces( SALT34.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_additionalname_firstname(SALT34.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,' '))),~(LENGTH(TRIM(s)) = 0),~(SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_additionalname_firstname(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotLeft,SALT34.HygieneErrors.NotInChars(' '),SALT34.HygieneErrors.NotLength('0'),SALT34.HygieneErrors.NotWords('1'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_additionalname_middlename(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,' '); // Only allow valid symbols
  s2 := SALT34.stringcleanspaces( SALT34.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_additionalname_middlename(SALT34.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,' '))),~(LENGTH(TRIM(s)) = 0),~(SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_additionalname_middlename(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotLeft,SALT34.HygieneErrors.NotInChars(' '),SALT34.HygieneErrors.NotLength('0'),SALT34.HygieneErrors.NotWords('1'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_additionalname_middleinitial(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,' '); // Only allow valid symbols
  s2 := SALT34.stringcleanspaces( SALT34.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_additionalname_middleinitial(SALT34.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,' '))),~(LENGTH(TRIM(s)) = 0),~(SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_additionalname_middleinitial(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotLeft,SALT34.HygieneErrors.NotInChars(' '),SALT34.HygieneErrors.NotLength('0'),SALT34.HygieneErrors.NotWords('1'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_additionalname_lastname(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,' '); // Only allow valid symbols
  s2 := SALT34.stringcleanspaces( SALT34.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_additionalname_lastname(SALT34.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,' '))),~(LENGTH(TRIM(s)) = 0),~(SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_additionalname_lastname(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotLeft,SALT34.HygieneErrors.NotInChars(' '),SALT34.HygieneErrors.NotLength('0'),SALT34.HygieneErrors.NotWords('1'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_additionalname_suffix(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,' '); // Only allow valid symbols
  s2 := SALT34.stringcleanspaces( SALT34.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_additionalname_suffix(SALT34.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,' '))),~(LENGTH(TRIM(s)) = 0),~(SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_additionalname_suffix(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotLeft,SALT34.HygieneErrors.NotInChars(' '),SALT34.HygieneErrors.NotLength('0'),SALT34.HygieneErrors.NotWords('1'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_aka1(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,' ,ABCDEFGHIJKLMNOPRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT34.stringcleanspaces( SALT34.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_aka1(SALT34.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,' ,ABCDEFGHIJKLMNOPRSTUVWXYZ '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 15 OR LENGTH(TRIM(s)) = 14 OR LENGTH(TRIM(s)) = 16 OR LENGTH(TRIM(s)) = 13 OR LENGTH(TRIM(s)) = 17 OR LENGTH(TRIM(s)) = 12 OR LENGTH(TRIM(s)) = 18 OR LENGTH(TRIM(s)) = 11 OR LENGTH(TRIM(s)) = 19 OR LENGTH(TRIM(s)) = 20 OR LENGTH(TRIM(s)) = 10 OR LENGTH(TRIM(s)) = 9 OR LENGTH(TRIM(s)) = 21 OR LENGTH(TRIM(s)) = 8 OR LENGTH(TRIM(s)) = 22 OR LENGTH(TRIM(s)) = 23 OR LENGTH(TRIM(s)) = 7 OR LENGTH(TRIM(s)) = 24 OR LENGTH(TRIM(s)) = 25 OR LENGTH(TRIM(s)) = 26 OR LENGTH(TRIM(s)) = 6 OR LENGTH(TRIM(s)) = 27),~(SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 1 OR SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 2 OR SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 3));
EXPORT InValidMessageFT_aka1(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotLeft,SALT34.HygieneErrors.NotInChars(' ,ABCDEFGHIJKLMNOPRSTUVWXYZ '),SALT34.HygieneErrors.NotLength('0,15,14,16,13,17,12,18,11,19,20,10,9,21,8,22,23,7,24,25,26,6,27'),SALT34.HygieneErrors.NotWords('1,2,3'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_aka2(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,' ,ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT34.stringcleanspaces( SALT34.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_aka2(SALT34.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,' ,ABCDEFGHIJKLMNOPQRSTUVWXYZ '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 15 OR LENGTH(TRIM(s)) = 14 OR LENGTH(TRIM(s)) = 16 OR LENGTH(TRIM(s)) = 13 OR LENGTH(TRIM(s)) = 17 OR LENGTH(TRIM(s)) = 12 OR LENGTH(TRIM(s)) = 18 OR LENGTH(TRIM(s)) = 11 OR LENGTH(TRIM(s)) = 10 OR LENGTH(TRIM(s)) = 19 OR LENGTH(TRIM(s)) = 9 OR LENGTH(TRIM(s)) = 20 OR LENGTH(TRIM(s)) = 8 OR LENGTH(TRIM(s)) = 21 OR LENGTH(TRIM(s)) = 22 OR LENGTH(TRIM(s)) = 7 OR LENGTH(TRIM(s)) = 23 OR LENGTH(TRIM(s)) = 24 OR LENGTH(TRIM(s)) = 25 OR LENGTH(TRIM(s)) = 26 OR LENGTH(TRIM(s)) = 6),~(SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 1 OR SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 2 OR SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 3));
EXPORT InValidMessageFT_aka2(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotLeft,SALT34.HygieneErrors.NotInChars(' ,ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT34.HygieneErrors.NotLength('0,15,14,16,13,17,12,18,11,10,19,9,20,8,21,22,7,23,24,25,26,6'),SALT34.HygieneErrors.NotWords('1,2,3'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_aka3(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,' ,ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT34.stringcleanspaces( SALT34.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_aka3(SALT34.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,' ,ABCDEFGHIJKLMNOPQRSTUVWXYZ '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 15 OR LENGTH(TRIM(s)) = 16 OR LENGTH(TRIM(s)) = 14 OR LENGTH(TRIM(s)) = 13 OR LENGTH(TRIM(s)) = 17 OR LENGTH(TRIM(s)) = 12 OR LENGTH(TRIM(s)) = 18 OR LENGTH(TRIM(s)) = 11 OR LENGTH(TRIM(s)) = 10 OR LENGTH(TRIM(s)) = 19 OR LENGTH(TRIM(s)) = 9 OR LENGTH(TRIM(s)) = 8 OR LENGTH(TRIM(s)) = 20 OR LENGTH(TRIM(s)) = 21 OR LENGTH(TRIM(s)) = 7 OR LENGTH(TRIM(s)) = 22 OR LENGTH(TRIM(s)) = 23 OR LENGTH(TRIM(s)) = 24 OR LENGTH(TRIM(s)) = 25 OR LENGTH(TRIM(s)) = 6),~(SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 1 OR SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 2 OR SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 3));
EXPORT InValidMessageFT_aka3(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotLeft,SALT34.HygieneErrors.NotInChars(' ,ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT34.HygieneErrors.NotLength('0,15,16,14,13,17,12,18,11,10,19,9,8,20,21,7,22,23,24,25,6'),SALT34.HygieneErrors.NotWords('1,2,3'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_recordtype(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,'12356789 '); // Only allow valid symbols
  s2 := SALT34.stringcleanspaces( SALT34.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_recordtype(SALT34.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,'12356789 '))),~(LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 0),~(SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_recordtype(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotLeft,SALT34.HygieneErrors.NotInChars('12356789 '),SALT34.HygieneErrors.NotLength('1,0'),SALT34.HygieneErrors.NotWords('1'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_addressstandardization(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,'NY '); // Only allow valid symbols
  s2 := SALT34.stringcleanspaces( SALT34.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_addressstandardization(SALT34.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,'NY '))),~(LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 0),~(SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_addressstandardization(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotLeft,SALT34.HygieneErrors.NotInChars('NY '),SALT34.HygieneErrors.NotLength('1,0'),SALT34.HygieneErrors.NotWords('1'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_filesincedate(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT34.stringcleanspaces( SALT34.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_filesincedate(SALT34.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 8 OR LENGTH(TRIM(s)) = 0),~(SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_filesincedate(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotLeft,SALT34.HygieneErrors.NotInChars('0123456789 '),SALT34.HygieneErrors.NotLength('8,0'),SALT34.HygieneErrors.NotWords('1'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_compilationdate(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT34.stringcleanspaces( SALT34.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_compilationdate(SALT34.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 8 OR LENGTH(TRIM(s)) = 0),~(SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_compilationdate(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotLeft,SALT34.HygieneErrors.NotInChars('0123456789 '),SALT34.HygieneErrors.NotLength('8,0'),SALT34.HygieneErrors.NotWords('1'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_birthdateind(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,'ENY '); // Only allow valid symbols
  s2 := SALT34.stringcleanspaces( SALT34.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_birthdateind(SALT34.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,'ENY '))),~(LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 0),~(SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_birthdateind(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotLeft,SALT34.HygieneErrors.NotInChars('ENY '),SALT34.HygieneErrors.NotLength('1,0'),SALT34.HygieneErrors.NotWords('1'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_orig_deceasedindicator(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,'Y '); // Only allow valid symbols
  s2 := SALT34.stringcleanspaces( SALT34.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_deceasedindicator(SALT34.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,'Y '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 1),~(SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_deceasedindicator(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotLeft,SALT34.HygieneErrors.NotInChars('Y '),SALT34.HygieneErrors.NotLength('0,1'),SALT34.HygieneErrors.NotWords('1'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_deceaseddate(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT34.stringcleanspaces( SALT34.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_deceaseddate(SALT34.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 8),~(SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_deceaseddate(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotLeft,SALT34.HygieneErrors.NotInChars('0123456789 '),SALT34.HygieneErrors.NotLength('0,8'),SALT34.HygieneErrors.NotWords('1'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_addressseq(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,'12345678 '); // Only allow valid symbols
  s2 := SALT34.stringcleanspaces( SALT34.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_addressseq(SALT34.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,'12345678 '))),~(LENGTH(TRIM(s)) = 1),~(SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_addressseq(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotLeft,SALT34.HygieneErrors.NotInChars('12345678 '),SALT34.HygieneErrors.NotLength('1'),SALT34.HygieneErrors.NotWords('1'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_normaddress_address1(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,' .0123456789ABCDEFGHIJKLMNOPRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT34.stringcleanspaces( SALT34.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_normaddress_address1(SALT34.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,' .0123456789ABCDEFGHIJKLMNOPRSTUVWXYZ '))),~(LENGTH(TRIM(s)) = 15 OR LENGTH(TRIM(s)) = 14 OR LENGTH(TRIM(s)) = 13 OR LENGTH(TRIM(s)) = 16 OR LENGTH(TRIM(s)) = 12 OR LENGTH(TRIM(s)) = 17 OR LENGTH(TRIM(s)) = 18 OR LENGTH(TRIM(s)) = 11 OR LENGTH(TRIM(s)) = 19 OR LENGTH(TRIM(s)) = 10 OR LENGTH(TRIM(s)) = 20 OR LENGTH(TRIM(s)) = 21 OR LENGTH(TRIM(s)) = 22 OR LENGTH(TRIM(s)) = 9 OR LENGTH(TRIM(s)) = 23 OR LENGTH(TRIM(s)) = 24 OR LENGTH(TRIM(s)) = 8 OR LENGTH(TRIM(s)) = 25 OR LENGTH(TRIM(s)) = 26 OR LENGTH(TRIM(s)) = 27 OR LENGTH(TRIM(s)) = 28 OR LENGTH(TRIM(s)) = 29 OR LENGTH(TRIM(s)) = 7 OR LENGTH(TRIM(s)) = 30 OR LENGTH(TRIM(s)) = 31 OR LENGTH(TRIM(s)) = 6 OR LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 32 OR LENGTH(TRIM(s)) = 33),~(SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 3 OR SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 4 OR SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 5 OR SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 6 OR SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 2 OR SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 7));
EXPORT InValidMessageFT_normaddress_address1(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotLeft,SALT34.HygieneErrors.NotInChars(' .0123456789ABCDEFGHIJKLMNOPRSTUVWXYZ '),SALT34.HygieneErrors.NotLength('15,14,13,16,12,17,18,11,19,10,20,21,22,9,23,24,8,25,26,27,28,29,7,30,31,6,4,5,32,33'),SALT34.HygieneErrors.NotWords('3,4,5,6,2,7'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_normaddress_address2(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,' #-0123456789ABCDEFGHIJKLMNOPRSTUW '); // Only allow valid symbols
  s2 := SALT34.stringcleanspaces( SALT34.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_normaddress_address2(SALT34.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,' #-0123456789ABCDEFGHIJKLMNOPRSTUW '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 6 OR LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 3 OR LENGTH(TRIM(s)) = 5),~(SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 1 OR SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 2));
EXPORT InValidMessageFT_normaddress_address2(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotLeft,SALT34.HygieneErrors.NotInChars(' #-0123456789ABCDEFGHIJKLMNOPRSTUW '),SALT34.HygieneErrors.NotLength('0,6,4,2,3,5'),SALT34.HygieneErrors.NotWords('1,2'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_normaddress_city(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,' ABCDEFGHIJKLMNOPQRSTUVWXY '); // Only allow valid symbols
  s2 := SALT34.stringcleanspaces( SALT34.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_normaddress_city(SALT34.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,' ABCDEFGHIJKLMNOPQRSTUVWXY '))),~(LENGTH(TRIM(s)) = 7 OR LENGTH(TRIM(s)) = 8 OR LENGTH(TRIM(s)) = 9 OR LENGTH(TRIM(s)) = 6 OR LENGTH(TRIM(s)) = 10 OR LENGTH(TRIM(s)) = 11 OR LENGTH(TRIM(s)) = 12 OR LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 13 OR LENGTH(TRIM(s)) = 14 OR LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 16 OR LENGTH(TRIM(s)) = 15 OR LENGTH(TRIM(s)) = 17 OR LENGTH(TRIM(s)) = 18 OR LENGTH(TRIM(s)) = 3 OR LENGTH(TRIM(s)) = 19 OR LENGTH(TRIM(s)) = 20 OR LENGTH(TRIM(s)) = 22),~(SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 1 OR SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 2 OR SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 3));
EXPORT InValidMessageFT_normaddress_city(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotLeft,SALT34.HygieneErrors.NotInChars(' ABCDEFGHIJKLMNOPQRSTUVWXY '),SALT34.HygieneErrors.NotLength('7,8,9,6,10,11,12,5,13,14,4,16,15,17,18,3,19,20,22'),SALT34.HygieneErrors.NotWords('1,2,3'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_normaddress_state(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,'ACDEFGHIJKLMNOPRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT34.stringcleanspaces( SALT34.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_normaddress_state(SALT34.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,'ACDEFGHIJKLMNOPRSTUVWXYZ '))),~(LENGTH(TRIM(s)) = 2),~(SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_normaddress_state(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotLeft,SALT34.HygieneErrors.NotInChars('ACDEFGHIJKLMNOPRSTUVWXYZ '),SALT34.HygieneErrors.NotLength('2'),SALT34.HygieneErrors.NotWords('1'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_normaddress_zipcode(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,'-0123456789 '); // Only allow valid symbols
  s2 := SALT34.stringcleanspaces( SALT34.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_normaddress_zipcode(SALT34.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,'-0123456789 '))),~(LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 10),~(SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_normaddress_zipcode(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotLeft,SALT34.HygieneErrors.NotInChars('-0123456789 '),SALT34.HygieneErrors.NotLength('5,10'),SALT34.HygieneErrors.NotWords('1'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_normaddress_updateddate(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,'/0123456789 '); // Only allow valid symbols
  s2 := SALT34.stringcleanspaces( SALT34.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_normaddress_updateddate(SALT34.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,'/0123456789 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 9 OR LENGTH(TRIM(s)) = 8 OR LENGTH(TRIM(s)) = 10),~(SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_normaddress_updateddate(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotLeft,SALT34.HygieneErrors.NotInChars('/0123456789 '),SALT34.HygieneErrors.NotLength('0,9,8,10'),SALT34.HygieneErrors.NotWords('1'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_name(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,' ,ABCDEFGHIJKLMNOPRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT34.stringcleanspaces( SALT34.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_name(SALT34.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,' ,ABCDEFGHIJKLMNOPRSTUVWXYZ '))),~(LENGTH(TRIM(s)) = 16 OR LENGTH(TRIM(s)) = 17 OR LENGTH(TRIM(s)) = 15 OR LENGTH(TRIM(s)) = 18 OR LENGTH(TRIM(s)) = 14 OR LENGTH(TRIM(s)) = 19 OR LENGTH(TRIM(s)) = 13 OR LENGTH(TRIM(s)) = 20 OR LENGTH(TRIM(s)) = 12 OR LENGTH(TRIM(s)) = 21 OR LENGTH(TRIM(s)) = 11 OR LENGTH(TRIM(s)) = 22 OR LENGTH(TRIM(s)) = 10 OR LENGTH(TRIM(s)) = 23 OR LENGTH(TRIM(s)) = 9 OR LENGTH(TRIM(s)) = 24 OR LENGTH(TRIM(s)) = 8 OR LENGTH(TRIM(s)) = 25 OR LENGTH(TRIM(s)) = 26 OR LENGTH(TRIM(s)) = 7 OR LENGTH(TRIM(s)) = 27 OR LENGTH(TRIM(s)) = 28 OR LENGTH(TRIM(s)) = 6),~(SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 4 OR SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 3 OR SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 1 OR SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 2 OR SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 5));
EXPORT InValidMessageFT_name(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotLeft,SALT34.HygieneErrors.NotInChars(' ,ABCDEFGHIJKLMNOPRSTUVWXYZ '),SALT34.HygieneErrors.NotLength('16,17,15,18,14,19,13,20,12,21,11,22,10,23,9,24,8,25,26,7,27,28,6'),SALT34.HygieneErrors.NotWords('4,3,1,2,5'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_nametype(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,'123AO '); // Only allow valid symbols
  s2 := SALT34.stringcleanspaces( SALT34.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_nametype(SALT34.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,'123AO '))),~(LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 2),~(SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_nametype(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotLeft,SALT34.HygieneErrors.NotInChars('123AO '),SALT34.HygieneErrors.NotLength('1,2'),SALT34.HygieneErrors.NotWords('1'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_title(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,'MRS '); // Only allow valid symbols
  s2 := SALT34.stringcleanspaces( SALT34.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_title(SALT34.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,'MRS '))),~(LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 0),~(SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_title(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotLeft,SALT34.HygieneErrors.NotInChars('MRS '),SALT34.HygieneErrors.NotLength('2,0'),SALT34.HygieneErrors.NotWords('1'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_fname(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWYZ '); // Only allow valid symbols
  s2 := SALT34.stringcleanspaces( SALT34.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_fname(SALT34.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWYZ '))),~(LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 6 OR LENGTH(TRIM(s)) = 7 OR LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 8 OR LENGTH(TRIM(s)) = 3 OR LENGTH(TRIM(s)) = 9 OR LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 10 OR LENGTH(TRIM(s)) = 11 OR LENGTH(TRIM(s)) = 2),~(SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_fname(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotLeft,SALT34.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWYZ '),SALT34.HygieneErrors.NotLength('5,6,7,4,1,8,3,9,0,10,11,2'),SALT34.HygieneErrors.NotWords('1'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_mname(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,' ABCDEFGHIJKLMNOPQRSTUVWYZ '); // Only allow valid symbols
  s2 := SALT34.stringcleanspaces( SALT34.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_mname(SALT34.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,' ABCDEFGHIJKLMNOPQRSTUVWYZ '))),~(LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 6 OR LENGTH(TRIM(s)) = 3 OR LENGTH(TRIM(s)) = 7 OR LENGTH(TRIM(s)) = 8 OR LENGTH(TRIM(s)) = 9 OR LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 10),~(SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 1 OR SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 2));
EXPORT InValidMessageFT_mname(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotLeft,SALT34.HygieneErrors.NotInChars(' ABCDEFGHIJKLMNOPQRSTUVWYZ '),SALT34.HygieneErrors.NotLength('1,0,5,4,6,3,7,8,9,2,10'),SALT34.HygieneErrors.NotWords('1,2'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_lname(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,' ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT34.stringcleanspaces( SALT34.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_lname(SALT34.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,' ABCDEFGHIJKLMNOPQRSTUVWXYZ '))),~(LENGTH(TRIM(s)) = 6 OR LENGTH(TRIM(s)) = 7 OR LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 8 OR LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 9 OR LENGTH(TRIM(s)) = 10 OR LENGTH(TRIM(s)) = 3 OR LENGTH(TRIM(s)) = 11 OR LENGTH(TRIM(s)) = 12 OR LENGTH(TRIM(s)) = 13 OR LENGTH(TRIM(s)) = 14 OR LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 15 OR LENGTH(TRIM(s)) = 16 OR LENGTH(TRIM(s)) = 17 OR LENGTH(TRIM(s)) = 18),~(SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 1 OR SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 2));
EXPORT InValidMessageFT_lname(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotLeft,SALT34.HygieneErrors.NotInChars(' ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT34.HygieneErrors.NotLength('6,7,5,8,4,9,10,3,11,12,13,14,2,15,16,17,18'),SALT34.HygieneErrors.NotWords('1,2'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_name_suffix(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,' ABCDEIJLMNOPRSTV '); // Only allow valid symbols
  s2 := SALT34.stringcleanspaces( SALT34.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_name_suffix(SALT34.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,' ABCDEIJLMNOPRSTV '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 3),~(SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_name_suffix(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotLeft,SALT34.HygieneErrors.NotInChars(' ABCDEIJLMNOPRSTV '),SALT34.HygieneErrors.NotLength('0,2,3'),SALT34.HygieneErrors.NotWords('1'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_name_score(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,'012346789 '); // Only allow valid symbols
  s2 := SALT34.stringcleanspaces( SALT34.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_name_score(SALT34.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,'012346789 '))),~(LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 3),~(SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_name_score(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotLeft,SALT34.HygieneErrors.NotInChars('012346789 '),SALT34.HygieneErrors.NotLength('2,3'),SALT34.HygieneErrors.NotWords('1'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_prim_range(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,'-0123456789A '); // Only allow valid symbols
  s2 := SALT34.stringcleanspaces( SALT34.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_prim_range(SALT34.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,'-0123456789A '))),~(LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 3 OR LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 6),~(SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_prim_range(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotLeft,SALT34.HygieneErrors.NotInChars('-0123456789A '),SALT34.HygieneErrors.NotLength('4,3,5,0,2,1,6'),SALT34.HygieneErrors.NotWords('1'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_predir(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,'ENSW '); // Only allow valid symbols
  s2 := SALT34.stringcleanspaces( SALT34.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_predir(SALT34.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,'ENSW '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 2),~(SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_predir(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotLeft,SALT34.HygieneErrors.NotInChars('ENSW '),SALT34.HygieneErrors.NotLength('0,1,2'),SALT34.HygieneErrors.NotWords('1'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_prim_name(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,' 0123456789ABCDEFGHIJKLMNOPRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT34.stringcleanspaces( SALT34.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_prim_name(SALT34.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,' 0123456789ABCDEFGHIJKLMNOPRSTUVWXYZ '))),~(LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 7 OR LENGTH(TRIM(s)) = 8 OR LENGTH(TRIM(s)) = 6 OR LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 9 OR LENGTH(TRIM(s)) = 10 OR LENGTH(TRIM(s)) = 11 OR LENGTH(TRIM(s)) = 3 OR LENGTH(TRIM(s)) = 12 OR LENGTH(TRIM(s)) = 13 OR LENGTH(TRIM(s)) = 14 OR LENGTH(TRIM(s)) = 15 OR LENGTH(TRIM(s)) = 16 OR LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 17 OR LENGTH(TRIM(s)) = 18 OR LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 19 OR LENGTH(TRIM(s)) = 21 OR LENGTH(TRIM(s)) = 20 OR LENGTH(TRIM(s)) = 22),~(SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 1 OR SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 2 OR SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 3 OR SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 4 OR SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 5));
EXPORT InValidMessageFT_prim_name(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotLeft,SALT34.HygieneErrors.NotInChars(' 0123456789ABCDEFGHIJKLMNOPRSTUVWXYZ '),SALT34.HygieneErrors.NotLength('4,7,8,6,5,9,10,11,3,12,13,14,15,16,1,17,18,2,19,21,20,22'),SALT34.HygieneErrors.NotWords('1,2,3,4,5'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_addr_suffix(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,'ABCDEGHIKLNOPQRSTVWXY '); // Only allow valid symbols
  s2 := SALT34.stringcleanspaces( SALT34.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_addr_suffix(SALT34.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,'ABCDEGHIKLNOPQRSTVWXY '))),~(LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 3 OR LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 4),~(SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_addr_suffix(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotLeft,SALT34.HygieneErrors.NotInChars('ABCDEGHIKLNOPQRSTVWXY '),SALT34.HygieneErrors.NotLength('2,3,0,4'),SALT34.HygieneErrors.NotWords('1'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_postdir(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,'ENSW '); // Only allow valid symbols
  s2 := SALT34.stringcleanspaces( SALT34.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_postdir(SALT34.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,'ENSW '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 1),~(SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_postdir(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotLeft,SALT34.HygieneErrors.NotInChars('ENSW '),SALT34.HygieneErrors.NotLength('0,2,1'),SALT34.HygieneErrors.NotWords('1'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_unit_desig(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,'#ABCEFILNOPRSTUX '); // Only allow valid symbols
  s2 := SALT34.stringcleanspaces( SALT34.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_unit_desig(SALT34.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,'#ABCEFILNOPRSTUX '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 3 OR LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 4),~(SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_unit_desig(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotLeft,SALT34.HygieneErrors.NotInChars('#ABCEFILNOPRSTUX '),SALT34.HygieneErrors.NotLength('0,3,1,4'),SALT34.HygieneErrors.NotWords('1'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_sec_range(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,' -0123456789ABCDEFGHIJKLMNOPQRSTUVW '); // Only allow valid symbols
  s2 := SALT34.stringcleanspaces( SALT34.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_sec_range(SALT34.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,' -0123456789ABCDEFGHIJKLMNOPQRSTUVW '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 3 OR LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 5),~(SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_sec_range(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotLeft,SALT34.HygieneErrors.NotInChars(' -0123456789ABCDEFGHIJKLMNOPQRSTUVW '),SALT34.HygieneErrors.NotLength('0,3,1,2,4,5'),SALT34.HygieneErrors.NotWords('1'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_p_city_name(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,' ABCDEFGHIJKLMNOPQRSTUVWXY '); // Only allow valid symbols
  s2 := SALT34.stringcleanspaces( SALT34.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_p_city_name(SALT34.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,' ABCDEFGHIJKLMNOPQRSTUVWXY '))),~(LENGTH(TRIM(s)) = 7 OR LENGTH(TRIM(s)) = 8 OR LENGTH(TRIM(s)) = 9 OR LENGTH(TRIM(s)) = 10 OR LENGTH(TRIM(s)) = 6 OR LENGTH(TRIM(s)) = 11 OR LENGTH(TRIM(s)) = 12 OR LENGTH(TRIM(s)) = 13 OR LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 14 OR LENGTH(TRIM(s)) = 16 OR LENGTH(TRIM(s)) = 15 OR LENGTH(TRIM(s)) = 3 OR LENGTH(TRIM(s)) = 17),~(SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 1 OR SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 2 OR SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 3));
EXPORT InValidMessageFT_p_city_name(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotLeft,SALT34.HygieneErrors.NotInChars(' ABCDEFGHIJKLMNOPQRSTUVWXY '),SALT34.HygieneErrors.NotLength('7,8,9,10,6,11,12,13,5,4,14,16,15,3,17'),SALT34.HygieneErrors.NotWords('1,2,3'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_v_city_name(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,' ABCDEFGHIJKLMNOPQRSTUVWXY '); // Only allow valid symbols
  s2 := SALT34.stringcleanspaces( SALT34.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_v_city_name(SALT34.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,' ABCDEFGHIJKLMNOPQRSTUVWXY '))),~(LENGTH(TRIM(s)) = 7 OR LENGTH(TRIM(s)) = 8 OR LENGTH(TRIM(s)) = 9 OR LENGTH(TRIM(s)) = 6 OR LENGTH(TRIM(s)) = 10 OR LENGTH(TRIM(s)) = 11 OR LENGTH(TRIM(s)) = 12 OR LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 13 OR LENGTH(TRIM(s)) = 14 OR LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 16 OR LENGTH(TRIM(s)) = 15 OR LENGTH(TRIM(s)) = 17 OR LENGTH(TRIM(s)) = 18 OR LENGTH(TRIM(s)) = 3 OR LENGTH(TRIM(s)) = 19 OR LENGTH(TRIM(s)) = 20 OR LENGTH(TRIM(s)) = 22),~(SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 1 OR SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 2 OR SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 3 OR SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 4));
EXPORT InValidMessageFT_v_city_name(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotLeft,SALT34.HygieneErrors.NotInChars(' ABCDEFGHIJKLMNOPQRSTUVWXY '),SALT34.HygieneErrors.NotLength('7,8,9,6,10,11,12,5,13,14,4,16,15,17,18,3,19,20,22'),SALT34.HygieneErrors.NotWords('1,2,3,4'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_st(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,'ACDEFGHIJKLMNOPRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT34.stringcleanspaces( SALT34.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_st(SALT34.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,'ACDEFGHIJKLMNOPRSTUVWXYZ '))),~(LENGTH(TRIM(s)) = 2),~(SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_st(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotLeft,SALT34.HygieneErrors.NotInChars('ACDEFGHIJKLMNOPRSTUVWXYZ '),SALT34.HygieneErrors.NotLength('2'),SALT34.HygieneErrors.NotWords('1'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_zip(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT34.stringcleanspaces( SALT34.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_zip(SALT34.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 5),~(SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_zip(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotLeft,SALT34.HygieneErrors.NotInChars('0123456789 '),SALT34.HygieneErrors.NotLength('5'),SALT34.HygieneErrors.NotWords('1'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_zip4(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT34.stringcleanspaces( SALT34.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_zip4(SALT34.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 0),~(SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_zip4(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotLeft,SALT34.HygieneErrors.NotInChars('0123456789 '),SALT34.HygieneErrors.NotLength('4,0'),SALT34.HygieneErrors.NotWords('1'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_cart(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,'0123456789BCHR '); // Only allow valid symbols
  s2 := SALT34.stringcleanspaces( SALT34.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_cart(SALT34.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,'0123456789BCHR '))),~(LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 0),~(SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_cart(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotLeft,SALT34.HygieneErrors.NotInChars('0123456789BCHR '),SALT34.HygieneErrors.NotLength('4,0'),SALT34.HygieneErrors.NotWords('1'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_cr_sort_sz(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,'ABCD '); // Only allow valid symbols
  s2 := SALT34.stringcleanspaces( SALT34.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_cr_sort_sz(SALT34.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,'ABCD '))),~(LENGTH(TRIM(s)) = 1),~(SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_cr_sort_sz(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotLeft,SALT34.HygieneErrors.NotInChars('ABCD '),SALT34.HygieneErrors.NotLength('1'),SALT34.HygieneErrors.NotWords('1'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_lot(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT34.stringcleanspaces( SALT34.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_lot(SALT34.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 0),~(SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_lot(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotLeft,SALT34.HygieneErrors.NotInChars('0123456789 '),SALT34.HygieneErrors.NotLength('4,0'),SALT34.HygieneErrors.NotWords('1'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_lot_order(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,'AD '); // Only allow valid symbols
  s2 := SALT34.stringcleanspaces( SALT34.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_lot_order(SALT34.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,'AD '))),~(LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 0),~(SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_lot_order(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotLeft,SALT34.HygieneErrors.NotInChars('AD '),SALT34.HygieneErrors.NotLength('1,0'),SALT34.HygieneErrors.NotWords('1'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_dbpc(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT34.stringcleanspaces( SALT34.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_dbpc(SALT34.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 0),~(SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_dbpc(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotLeft,SALT34.HygieneErrors.NotInChars('0123456789 '),SALT34.HygieneErrors.NotLength('2,0'),SALT34.HygieneErrors.NotWords('1'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_chk_digit(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT34.stringcleanspaces( SALT34.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_chk_digit(SALT34.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 1),~(SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_chk_digit(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotLeft,SALT34.HygieneErrors.NotInChars('0123456789 '),SALT34.HygieneErrors.NotLength('1'),SALT34.HygieneErrors.NotWords('1'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_rec_type(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,'DHPRSU '); // Only allow valid symbols
  s2 := SALT34.stringcleanspaces( SALT34.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_rec_type(SALT34.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,'DHPRSU '))),~(LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 2),~(SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_rec_type(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotLeft,SALT34.HygieneErrors.NotInChars('DHPRSU '),SALT34.HygieneErrors.NotLength('1,2'),SALT34.HygieneErrors.NotWords('1'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_county(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT34.stringcleanspaces( SALT34.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_county(SALT34.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 0),~(SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_county(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotLeft,SALT34.HygieneErrors.NotInChars('0123456789 '),SALT34.HygieneErrors.NotLength('5,0'),SALT34.HygieneErrors.NotWords('1'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_geo_lat(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,'.0123456789 '); // Only allow valid symbols
  s2 := SALT34.stringcleanspaces( SALT34.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_geo_lat(SALT34.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,'.0123456789 '))),~(LENGTH(TRIM(s)) = 9 OR LENGTH(TRIM(s)) = 0),~(SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_geo_lat(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotLeft,SALT34.HygieneErrors.NotInChars('.0123456789 '),SALT34.HygieneErrors.NotLength('9,0'),SALT34.HygieneErrors.NotWords('1'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_geo_long(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,'-.0123456789 '); // Only allow valid symbols
  s2 := SALT34.stringcleanspaces( SALT34.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_geo_long(SALT34.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,'-.0123456789 '))),~(LENGTH(TRIM(s)) = 10 OR LENGTH(TRIM(s)) = 11 OR LENGTH(TRIM(s)) = 0),~(SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_geo_long(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotLeft,SALT34.HygieneErrors.NotInChars('-.0123456789 '),SALT34.HygieneErrors.NotLength('10,11,0'),SALT34.HygieneErrors.NotWords('1'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_msa(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT34.stringcleanspaces( SALT34.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_msa(SALT34.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 4),~(SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_msa(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotLeft,SALT34.HygieneErrors.NotInChars('0123456789 '),SALT34.HygieneErrors.NotLength('0,4'),SALT34.HygieneErrors.NotWords('1'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_geo_blk(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT34.stringcleanspaces( SALT34.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_geo_blk(SALT34.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 7 OR LENGTH(TRIM(s)) = 0),~(SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_geo_blk(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotLeft,SALT34.HygieneErrors.NotInChars('0123456789 '),SALT34.HygieneErrors.NotLength('7,0'),SALT34.HygieneErrors.NotWords('1'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_geo_match(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,'0145 '); // Only allow valid symbols
  s2 := SALT34.stringcleanspaces( SALT34.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_geo_match(SALT34.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,'0145 '))),~(LENGTH(TRIM(s)) = 1),~(SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_geo_match(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotLeft,SALT34.HygieneErrors.NotInChars('0145 '),SALT34.HygieneErrors.NotLength('1'),SALT34.HygieneErrors.NotWords('1'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_err_stat(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,'0123456789ES '); // Only allow valid symbols
  s2 := SALT34.stringcleanspaces( SALT34.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_err_stat(SALT34.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,'0123456789ES '))),~(LENGTH(TRIM(s)) = 4),~(SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_err_stat(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotLeft,SALT34.HygieneErrors.NotInChars('0123456789ES '),SALT34.HygieneErrors.NotLength('4'),SALT34.HygieneErrors.NotWords('1'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_transferdate_unformatted(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT34.stringcleanspaces( SALT34.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_transferdate_unformatted(SALT34.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 8),~(SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_transferdate_unformatted(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotLeft,SALT34.HygieneErrors.NotInChars('0123456789 '),SALT34.HygieneErrors.NotLength('0,8'),SALT34.HygieneErrors.NotWords('1'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_birthdate_unformatted(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT34.stringcleanspaces( SALT34.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_birthdate_unformatted(SALT34.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 8 OR LENGTH(TRIM(s)) = 0),~(SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_birthdate_unformatted(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotLeft,SALT34.HygieneErrors.NotInChars('0123456789 '),SALT34.HygieneErrors.NotLength('8,0'),SALT34.HygieneErrors.NotWords('1'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_dob_no_conflict(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT34.stringcleanspaces( SALT34.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_dob_no_conflict(SALT34.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 8 OR LENGTH(TRIM(s)) = 0),~(SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_dob_no_conflict(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotLeft,SALT34.HygieneErrors.NotInChars('0123456789 '),SALT34.HygieneErrors.NotLength('8,0'),SALT34.HygieneErrors.NotWords('1'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_updatedate_unformatted(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT34.stringcleanspaces( SALT34.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_updatedate_unformatted(SALT34.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 8),~(SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_updatedate_unformatted(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotLeft,SALT34.HygieneErrors.NotInChars('0123456789 '),SALT34.HygieneErrors.NotLength('0,8'),SALT34.HygieneErrors.NotWords('1'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_consumerupdatedate_unformatted(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,' '); // Only allow valid symbols
  s2 := SALT34.stringcleanspaces( SALT34.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_consumerupdatedate_unformatted(SALT34.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,' '))),~(LENGTH(TRIM(s)) = 0),~(SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_consumerupdatedate_unformatted(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotLeft,SALT34.HygieneErrors.NotInChars(' '),SALT34.HygieneErrors.NotLength('0'),SALT34.HygieneErrors.NotWords('1'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_filesincedate_unformatted(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT34.stringcleanspaces( SALT34.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_filesincedate_unformatted(SALT34.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 8 OR LENGTH(TRIM(s)) = 0),~(SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_filesincedate_unformatted(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotLeft,SALT34.HygieneErrors.NotInChars('0123456789 '),SALT34.HygieneErrors.NotLength('8,0'),SALT34.HygieneErrors.NotWords('1'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_compilationdate_unformatted(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT34.stringcleanspaces( SALT34.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_compilationdate_unformatted(SALT34.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 8 OR LENGTH(TRIM(s)) = 0),~(SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_compilationdate_unformatted(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotLeft,SALT34.HygieneErrors.NotInChars('0123456789 '),SALT34.HygieneErrors.NotLength('8,0'),SALT34.HygieneErrors.NotWords('1'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_ssn_unformatted(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT34.stringcleanspaces( SALT34.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_ssn_unformatted(SALT34.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 9 OR LENGTH(TRIM(s)) = 0),~(SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_ssn_unformatted(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotLeft,SALT34.HygieneErrors.NotInChars('0123456789 '),SALT34.HygieneErrors.NotLength('9,0'),SALT34.HygieneErrors.NotWords('1'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_ssn_no_conflict(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT34.stringcleanspaces( SALT34.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_ssn_no_conflict(SALT34.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 9 OR LENGTH(TRIM(s)) = 0),~(SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_ssn_no_conflict(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotLeft,SALT34.HygieneErrors.NotInChars('0123456789 '),SALT34.HygieneErrors.NotLength('9,0'),SALT34.HygieneErrors.NotWords('1'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_telephone_unformatted(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT34.stringcleanspaces( SALT34.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_telephone_unformatted(SALT34.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 7),~(SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_telephone_unformatted(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotLeft,SALT34.HygieneErrors.NotInChars('0123456789 '),SALT34.HygieneErrors.NotLength('0,7'),SALT34.HygieneErrors.NotWords('1'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_deceasedindicator(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,'Y '); // Only allow valid symbols
  s2 := SALT34.stringcleanspaces( SALT34.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_deceasedindicator(SALT34.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,'Y '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 1),~(SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_deceasedindicator(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotLeft,SALT34.HygieneErrors.NotInChars('Y '),SALT34.HygieneErrors.NotLength('0,1'),SALT34.HygieneErrors.NotWords('1'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_did(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT34.stringcleanspaces( SALT34.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_did(SALT34.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 10 OR LENGTH(TRIM(s)) = 9 OR LENGTH(TRIM(s)) = 8 OR LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 12 OR LENGTH(TRIM(s)) = 11 OR LENGTH(TRIM(s)) = 7),~(SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_did(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotLeft,SALT34.HygieneErrors.NotInChars('0123456789 '),SALT34.HygieneErrors.NotLength('10,9,8,0,12,11,7'),SALT34.HygieneErrors.NotWords('1'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_did_score_field(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,'0145789 '); // Only allow valid symbols
  s2 := SALT34.stringcleanspaces( SALT34.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_did_score_field(SALT34.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,'0145789 '))),~(LENGTH(TRIM(s)) = 3 OR LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 2),~(SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_did_score_field(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotLeft,SALT34.HygieneErrors.NotInChars('0145789 '),SALT34.HygieneErrors.NotLength('3,0,2'),SALT34.HygieneErrors.NotWords('1'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_is_current(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,'1 '); // Only allow valid symbols
  s2 := SALT34.stringcleanspaces( SALT34.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_is_current(SALT34.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,'1 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 1),~(SALT34.WordCount(SALT34.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_is_current(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotLeft,SALT34.HygieneErrors.NotInChars('1 '),SALT34.HygieneErrors.NotLength('0,1'),SALT34.HygieneErrors.NotWords('1'),SALT34.HygieneErrors.Good);
 
EXPORT SALT34.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'dt_first_seen','dt_last_seen','dt_vendor_first_reported','dt_vendor_last_reported','filetype','filedate','vendordocumentidentifier','transferdate','currentname_firstname','currentname_middlename','currentname_middleinitial','currentname_lastname','currentname_suffix','currentname_gender','currentname_dob_mm','currentname_dob_dd','currentname_dob_yyyy','currentname_deathindicator','ssnfull','ssnfirst5digit','ssnlast4digit','consumerupdatedate','telephonenumber','citedid','fileid','publication','currentaddress_address1','currentaddress_address2','currentaddress_city','currentaddress_state','currentaddress_zipcode','currentaddress_updateddate','housenumber','streettype','streetdirection','streetname','apartmentnumber','city','state','zipcode','zip4u','previousaddress_address1','previousaddress_address2','previousaddress_city','previousaddress_state','previousaddress_zipcode','previousaddress_updateddate','formername_firstname','formername_middlename','formername_middleinitial','formername_lastname','formername_suffix','aliasname_firstname','aliasname_middlename','aliasname_middleinitial','aliasname_lastname','aliasname_suffix','additionalname_firstname','additionalname_middlename','additionalname_middleinitial','additionalname_lastname','additionalname_suffix','aka1','aka2','aka3','recordtype','addressstandardization','filesincedate','compilationdate','birthdateind','orig_deceasedindicator','deceaseddate','addressseq','normaddress_address1','normaddress_address2','normaddress_city','normaddress_state','normaddress_zipcode','normaddress_updateddate','name','nametype','title','fname','mname','lname','name_suffix','name_score','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dbpc','chk_digit','rec_type','county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','transferdate_unformatted','birthdate_unformatted','dob_no_conflict','updatedate_unformatted','consumerupdatedate_unformatted','filesincedate_unformatted','compilationdate_unformatted','ssn_unformatted','ssn_no_conflict','telephone_unformatted','deceasedindicator','did','did_score_field','is_current');
EXPORT FieldNum(SALT34.StrType fn) := CASE(fn,'dt_first_seen' => 0,'dt_last_seen' => 1,'dt_vendor_first_reported' => 2,'dt_vendor_last_reported' => 3,'filetype' => 4,'filedate' => 5,'vendordocumentidentifier' => 6,'transferdate' => 7,'currentname_firstname' => 8,'currentname_middlename' => 9,'currentname_middleinitial' => 10,'currentname_lastname' => 11,'currentname_suffix' => 12,'currentname_gender' => 13,'currentname_dob_mm' => 14,'currentname_dob_dd' => 15,'currentname_dob_yyyy' => 16,'currentname_deathindicator' => 17,'ssnfull' => 18,'ssnfirst5digit' => 19,'ssnlast4digit' => 20,'consumerupdatedate' => 21,'telephonenumber' => 22,'citedid' => 23,'fileid' => 24,'publication' => 25,'currentaddress_address1' => 26,'currentaddress_address2' => 27,'currentaddress_city' => 28,'currentaddress_state' => 29,'currentaddress_zipcode' => 30,'currentaddress_updateddate' => 31,'housenumber' => 32,'streettype' => 33,'streetdirection' => 34,'streetname' => 35,'apartmentnumber' => 36,'city' => 37,'state' => 38,'zipcode' => 39,'zip4u' => 40,'previousaddress_address1' => 41,'previousaddress_address2' => 42,'previousaddress_city' => 43,'previousaddress_state' => 44,'previousaddress_zipcode' => 45,'previousaddress_updateddate' => 46,'formername_firstname' => 47,'formername_middlename' => 48,'formername_middleinitial' => 49,'formername_lastname' => 50,'formername_suffix' => 51,'aliasname_firstname' => 52,'aliasname_middlename' => 53,'aliasname_middleinitial' => 54,'aliasname_lastname' => 55,'aliasname_suffix' => 56,'additionalname_firstname' => 57,'additionalname_middlename' => 58,'additionalname_middleinitial' => 59,'additionalname_lastname' => 60,'additionalname_suffix' => 61,'aka1' => 62,'aka2' => 63,'aka3' => 64,'recordtype' => 65,'addressstandardization' => 66,'filesincedate' => 67,'compilationdate' => 68,'birthdateind' => 69,'orig_deceasedindicator' => 70,'deceaseddate' => 71,'addressseq' => 72,'normaddress_address1' => 73,'normaddress_address2' => 74,'normaddress_city' => 75,'normaddress_state' => 76,'normaddress_zipcode' => 77,'normaddress_updateddate' => 78,'name' => 79,'nametype' => 80,'title' => 81,'fname' => 82,'mname' => 83,'lname' => 84,'name_suffix' => 85,'name_score' => 86,'prim_range' => 87,'predir' => 88,'prim_name' => 89,'addr_suffix' => 90,'postdir' => 91,'unit_desig' => 92,'sec_range' => 93,'p_city_name' => 94,'v_city_name' => 95,'st' => 96,'zip' => 97,'zip4' => 98,'cart' => 99,'cr_sort_sz' => 100,'lot' => 101,'lot_order' => 102,'dbpc' => 103,'chk_digit' => 104,'rec_type' => 105,'county' => 106,'geo_lat' => 107,'geo_long' => 108,'msa' => 109,'geo_blk' => 110,'geo_match' => 111,'err_stat' => 112,'transferdate_unformatted' => 113,'birthdate_unformatted' => 114,'dob_no_conflict' => 115,'updatedate_unformatted' => 116,'consumerupdatedate_unformatted' => 117,'filesincedate_unformatted' => 118,'compilationdate_unformatted' => 119,'ssn_unformatted' => 120,'ssn_no_conflict' => 121,'telephone_unformatted' => 122,'deceasedindicator' => 123,'did' => 124,'did_score_field' => 125,'is_current' => 126,0);
 
//Individual field level validation
 
EXPORT Make_dt_first_seen(SALT34.StrType s0) := MakeFT_dt_first_seen(s0);
EXPORT InValid_dt_first_seen(SALT34.StrType s) := InValidFT_dt_first_seen(s);
EXPORT InValidMessage_dt_first_seen(UNSIGNED1 wh) := InValidMessageFT_dt_first_seen(wh);
 
EXPORT Make_dt_last_seen(SALT34.StrType s0) := MakeFT_dt_last_seen(s0);
EXPORT InValid_dt_last_seen(SALT34.StrType s) := InValidFT_dt_last_seen(s);
EXPORT InValidMessage_dt_last_seen(UNSIGNED1 wh) := InValidMessageFT_dt_last_seen(wh);
 
EXPORT Make_dt_vendor_first_reported(SALT34.StrType s0) := MakeFT_dt_vendor_first_reported(s0);
EXPORT InValid_dt_vendor_first_reported(SALT34.StrType s) := InValidFT_dt_vendor_first_reported(s);
EXPORT InValidMessage_dt_vendor_first_reported(UNSIGNED1 wh) := InValidMessageFT_dt_vendor_first_reported(wh);
 
EXPORT Make_dt_vendor_last_reported(SALT34.StrType s0) := MakeFT_dt_vendor_last_reported(s0);
EXPORT InValid_dt_vendor_last_reported(SALT34.StrType s) := InValidFT_dt_vendor_last_reported(s);
EXPORT InValidMessage_dt_vendor_last_reported(UNSIGNED1 wh) := InValidMessageFT_dt_vendor_last_reported(wh);
 
EXPORT Make_filetype(SALT34.StrType s0) := MakeFT_filetype(s0);
EXPORT InValid_filetype(SALT34.StrType s) := InValidFT_filetype(s);
EXPORT InValidMessage_filetype(UNSIGNED1 wh) := InValidMessageFT_filetype(wh);
 
EXPORT Make_filedate(SALT34.StrType s0) := MakeFT_filedate(s0);
EXPORT InValid_filedate(SALT34.StrType s) := InValidFT_filedate(s);
EXPORT InValidMessage_filedate(UNSIGNED1 wh) := InValidMessageFT_filedate(wh);
 
EXPORT Make_vendordocumentidentifier(SALT34.StrType s0) := MakeFT_vendordocumentidentifier(s0);
EXPORT InValid_vendordocumentidentifier(SALT34.StrType s) := InValidFT_vendordocumentidentifier(s);
EXPORT InValidMessage_vendordocumentidentifier(UNSIGNED1 wh) := InValidMessageFT_vendordocumentidentifier(wh);
 
EXPORT Make_transferdate(SALT34.StrType s0) := MakeFT_transferdate(s0);
EXPORT InValid_transferdate(SALT34.StrType s) := InValidFT_transferdate(s);
EXPORT InValidMessage_transferdate(UNSIGNED1 wh) := InValidMessageFT_transferdate(wh);
 
EXPORT Make_currentname_firstname(SALT34.StrType s0) := MakeFT_currentname_firstname(s0);
EXPORT InValid_currentname_firstname(SALT34.StrType s) := InValidFT_currentname_firstname(s);
EXPORT InValidMessage_currentname_firstname(UNSIGNED1 wh) := InValidMessageFT_currentname_firstname(wh);
 
EXPORT Make_currentname_middlename(SALT34.StrType s0) := MakeFT_currentname_middlename(s0);
EXPORT InValid_currentname_middlename(SALT34.StrType s) := InValidFT_currentname_middlename(s);
EXPORT InValidMessage_currentname_middlename(UNSIGNED1 wh) := InValidMessageFT_currentname_middlename(wh);
 
EXPORT Make_currentname_middleinitial(SALT34.StrType s0) := MakeFT_currentname_middleinitial(s0);
EXPORT InValid_currentname_middleinitial(SALT34.StrType s) := InValidFT_currentname_middleinitial(s);
EXPORT InValidMessage_currentname_middleinitial(UNSIGNED1 wh) := InValidMessageFT_currentname_middleinitial(wh);
 
EXPORT Make_currentname_lastname(SALT34.StrType s0) := MakeFT_currentname_lastname(s0);
EXPORT InValid_currentname_lastname(SALT34.StrType s) := InValidFT_currentname_lastname(s);
EXPORT InValidMessage_currentname_lastname(UNSIGNED1 wh) := InValidMessageFT_currentname_lastname(wh);
 
EXPORT Make_currentname_suffix(SALT34.StrType s0) := MakeFT_currentname_suffix(s0);
EXPORT InValid_currentname_suffix(SALT34.StrType s) := InValidFT_currentname_suffix(s);
EXPORT InValidMessage_currentname_suffix(UNSIGNED1 wh) := InValidMessageFT_currentname_suffix(wh);
 
EXPORT Make_currentname_gender(SALT34.StrType s0) := MakeFT_currentname_gender(s0);
EXPORT InValid_currentname_gender(SALT34.StrType s) := InValidFT_currentname_gender(s);
EXPORT InValidMessage_currentname_gender(UNSIGNED1 wh) := InValidMessageFT_currentname_gender(wh);
 
EXPORT Make_currentname_dob_mm(SALT34.StrType s0) := MakeFT_currentname_dob_mm(s0);
EXPORT InValid_currentname_dob_mm(SALT34.StrType s) := InValidFT_currentname_dob_mm(s);
EXPORT InValidMessage_currentname_dob_mm(UNSIGNED1 wh) := InValidMessageFT_currentname_dob_mm(wh);
 
EXPORT Make_currentname_dob_dd(SALT34.StrType s0) := MakeFT_currentname_dob_dd(s0);
EXPORT InValid_currentname_dob_dd(SALT34.StrType s) := InValidFT_currentname_dob_dd(s);
EXPORT InValidMessage_currentname_dob_dd(UNSIGNED1 wh) := InValidMessageFT_currentname_dob_dd(wh);
 
EXPORT Make_currentname_dob_yyyy(SALT34.StrType s0) := MakeFT_currentname_dob_yyyy(s0);
EXPORT InValid_currentname_dob_yyyy(SALT34.StrType s) := InValidFT_currentname_dob_yyyy(s);
EXPORT InValidMessage_currentname_dob_yyyy(UNSIGNED1 wh) := InValidMessageFT_currentname_dob_yyyy(wh);
 
EXPORT Make_currentname_deathindicator(SALT34.StrType s0) := MakeFT_currentname_deathindicator(s0);
EXPORT InValid_currentname_deathindicator(SALT34.StrType s) := InValidFT_currentname_deathindicator(s);
EXPORT InValidMessage_currentname_deathindicator(UNSIGNED1 wh) := InValidMessageFT_currentname_deathindicator(wh);
 
EXPORT Make_ssnfull(SALT34.StrType s0) := MakeFT_ssnfull(s0);
EXPORT InValid_ssnfull(SALT34.StrType s) := InValidFT_ssnfull(s);
EXPORT InValidMessage_ssnfull(UNSIGNED1 wh) := InValidMessageFT_ssnfull(wh);
 
EXPORT Make_ssnfirst5digit(SALT34.StrType s0) := MakeFT_ssnfirst5digit(s0);
EXPORT InValid_ssnfirst5digit(SALT34.StrType s) := InValidFT_ssnfirst5digit(s);
EXPORT InValidMessage_ssnfirst5digit(UNSIGNED1 wh) := InValidMessageFT_ssnfirst5digit(wh);
 
EXPORT Make_ssnlast4digit(SALT34.StrType s0) := MakeFT_ssnlast4digit(s0);
EXPORT InValid_ssnlast4digit(SALT34.StrType s) := InValidFT_ssnlast4digit(s);
EXPORT InValidMessage_ssnlast4digit(UNSIGNED1 wh) := InValidMessageFT_ssnlast4digit(wh);
 
EXPORT Make_consumerupdatedate(SALT34.StrType s0) := MakeFT_consumerupdatedate(s0);
EXPORT InValid_consumerupdatedate(SALT34.StrType s) := InValidFT_consumerupdatedate(s);
EXPORT InValidMessage_consumerupdatedate(UNSIGNED1 wh) := InValidMessageFT_consumerupdatedate(wh);
 
EXPORT Make_telephonenumber(SALT34.StrType s0) := MakeFT_telephonenumber(s0);
EXPORT InValid_telephonenumber(SALT34.StrType s) := InValidFT_telephonenumber(s);
EXPORT InValidMessage_telephonenumber(UNSIGNED1 wh) := InValidMessageFT_telephonenumber(wh);
 
EXPORT Make_citedid(SALT34.StrType s0) := MakeFT_citedid(s0);
EXPORT InValid_citedid(SALT34.StrType s) := InValidFT_citedid(s);
EXPORT InValidMessage_citedid(UNSIGNED1 wh) := InValidMessageFT_citedid(wh);
 
EXPORT Make_fileid(SALT34.StrType s0) := MakeFT_fileid(s0);
EXPORT InValid_fileid(SALT34.StrType s) := InValidFT_fileid(s);
EXPORT InValidMessage_fileid(UNSIGNED1 wh) := InValidMessageFT_fileid(wh);
 
EXPORT Make_publication(SALT34.StrType s0) := MakeFT_publication(s0);
EXPORT InValid_publication(SALT34.StrType s) := InValidFT_publication(s);
EXPORT InValidMessage_publication(UNSIGNED1 wh) := InValidMessageFT_publication(wh);
 
EXPORT Make_currentaddress_address1(SALT34.StrType s0) := MakeFT_currentaddress_address1(s0);
EXPORT InValid_currentaddress_address1(SALT34.StrType s) := InValidFT_currentaddress_address1(s);
EXPORT InValidMessage_currentaddress_address1(UNSIGNED1 wh) := InValidMessageFT_currentaddress_address1(wh);
 
EXPORT Make_currentaddress_address2(SALT34.StrType s0) := MakeFT_currentaddress_address2(s0);
EXPORT InValid_currentaddress_address2(SALT34.StrType s) := InValidFT_currentaddress_address2(s);
EXPORT InValidMessage_currentaddress_address2(UNSIGNED1 wh) := InValidMessageFT_currentaddress_address2(wh);
 
EXPORT Make_currentaddress_city(SALT34.StrType s0) := MakeFT_currentaddress_city(s0);
EXPORT InValid_currentaddress_city(SALT34.StrType s) := InValidFT_currentaddress_city(s);
EXPORT InValidMessage_currentaddress_city(UNSIGNED1 wh) := InValidMessageFT_currentaddress_city(wh);
 
EXPORT Make_currentaddress_state(SALT34.StrType s0) := MakeFT_currentaddress_state(s0);
EXPORT InValid_currentaddress_state(SALT34.StrType s) := InValidFT_currentaddress_state(s);
EXPORT InValidMessage_currentaddress_state(UNSIGNED1 wh) := InValidMessageFT_currentaddress_state(wh);
 
EXPORT Make_currentaddress_zipcode(SALT34.StrType s0) := MakeFT_currentaddress_zipcode(s0);
EXPORT InValid_currentaddress_zipcode(SALT34.StrType s) := InValidFT_currentaddress_zipcode(s);
EXPORT InValidMessage_currentaddress_zipcode(UNSIGNED1 wh) := InValidMessageFT_currentaddress_zipcode(wh);
 
EXPORT Make_currentaddress_updateddate(SALT34.StrType s0) := MakeFT_currentaddress_updateddate(s0);
EXPORT InValid_currentaddress_updateddate(SALT34.StrType s) := InValidFT_currentaddress_updateddate(s);
EXPORT InValidMessage_currentaddress_updateddate(UNSIGNED1 wh) := InValidMessageFT_currentaddress_updateddate(wh);
 
EXPORT Make_housenumber(SALT34.StrType s0) := MakeFT_housenumber(s0);
EXPORT InValid_housenumber(SALT34.StrType s) := InValidFT_housenumber(s);
EXPORT InValidMessage_housenumber(UNSIGNED1 wh) := InValidMessageFT_housenumber(wh);
 
EXPORT Make_streettype(SALT34.StrType s0) := MakeFT_streettype(s0);
EXPORT InValid_streettype(SALT34.StrType s) := InValidFT_streettype(s);
EXPORT InValidMessage_streettype(UNSIGNED1 wh) := InValidMessageFT_streettype(wh);
 
EXPORT Make_streetdirection(SALT34.StrType s0) := MakeFT_streetdirection(s0);
EXPORT InValid_streetdirection(SALT34.StrType s) := InValidFT_streetdirection(s);
EXPORT InValidMessage_streetdirection(UNSIGNED1 wh) := InValidMessageFT_streetdirection(wh);
 
EXPORT Make_streetname(SALT34.StrType s0) := MakeFT_streetname(s0);
EXPORT InValid_streetname(SALT34.StrType s) := InValidFT_streetname(s);
EXPORT InValidMessage_streetname(UNSIGNED1 wh) := InValidMessageFT_streetname(wh);
 
EXPORT Make_apartmentnumber(SALT34.StrType s0) := MakeFT_apartmentnumber(s0);
EXPORT InValid_apartmentnumber(SALT34.StrType s) := InValidFT_apartmentnumber(s);
EXPORT InValidMessage_apartmentnumber(UNSIGNED1 wh) := InValidMessageFT_apartmentnumber(wh);
 
EXPORT Make_city(SALT34.StrType s0) := MakeFT_city(s0);
EXPORT InValid_city(SALT34.StrType s) := InValidFT_city(s);
EXPORT InValidMessage_city(UNSIGNED1 wh) := InValidMessageFT_city(wh);
 
EXPORT Make_state(SALT34.StrType s0) := MakeFT_state(s0);
EXPORT InValid_state(SALT34.StrType s) := InValidFT_state(s);
EXPORT InValidMessage_state(UNSIGNED1 wh) := InValidMessageFT_state(wh);
 
EXPORT Make_zipcode(SALT34.StrType s0) := MakeFT_zipcode(s0);
EXPORT InValid_zipcode(SALT34.StrType s) := InValidFT_zipcode(s);
EXPORT InValidMessage_zipcode(UNSIGNED1 wh) := InValidMessageFT_zipcode(wh);
 
EXPORT Make_zip4u(SALT34.StrType s0) := MakeFT_zip4u(s0);
EXPORT InValid_zip4u(SALT34.StrType s) := InValidFT_zip4u(s);
EXPORT InValidMessage_zip4u(UNSIGNED1 wh) := InValidMessageFT_zip4u(wh);
 
EXPORT Make_previousaddress_address1(SALT34.StrType s0) := MakeFT_previousaddress_address1(s0);
EXPORT InValid_previousaddress_address1(SALT34.StrType s) := InValidFT_previousaddress_address1(s);
EXPORT InValidMessage_previousaddress_address1(UNSIGNED1 wh) := InValidMessageFT_previousaddress_address1(wh);
 
EXPORT Make_previousaddress_address2(SALT34.StrType s0) := MakeFT_previousaddress_address2(s0);
EXPORT InValid_previousaddress_address2(SALT34.StrType s) := InValidFT_previousaddress_address2(s);
EXPORT InValidMessage_previousaddress_address2(UNSIGNED1 wh) := InValidMessageFT_previousaddress_address2(wh);
 
EXPORT Make_previousaddress_city(SALT34.StrType s0) := MakeFT_previousaddress_city(s0);
EXPORT InValid_previousaddress_city(SALT34.StrType s) := InValidFT_previousaddress_city(s);
EXPORT InValidMessage_previousaddress_city(UNSIGNED1 wh) := InValidMessageFT_previousaddress_city(wh);
 
EXPORT Make_previousaddress_state(SALT34.StrType s0) := MakeFT_previousaddress_state(s0);
EXPORT InValid_previousaddress_state(SALT34.StrType s) := InValidFT_previousaddress_state(s);
EXPORT InValidMessage_previousaddress_state(UNSIGNED1 wh) := InValidMessageFT_previousaddress_state(wh);
 
EXPORT Make_previousaddress_zipcode(SALT34.StrType s0) := MakeFT_previousaddress_zipcode(s0);
EXPORT InValid_previousaddress_zipcode(SALT34.StrType s) := InValidFT_previousaddress_zipcode(s);
EXPORT InValidMessage_previousaddress_zipcode(UNSIGNED1 wh) := InValidMessageFT_previousaddress_zipcode(wh);
 
EXPORT Make_previousaddress_updateddate(SALT34.StrType s0) := MakeFT_previousaddress_updateddate(s0);
EXPORT InValid_previousaddress_updateddate(SALT34.StrType s) := InValidFT_previousaddress_updateddate(s);
EXPORT InValidMessage_previousaddress_updateddate(UNSIGNED1 wh) := InValidMessageFT_previousaddress_updateddate(wh);
 
EXPORT Make_formername_firstname(SALT34.StrType s0) := MakeFT_formername_firstname(s0);
EXPORT InValid_formername_firstname(SALT34.StrType s) := InValidFT_formername_firstname(s);
EXPORT InValidMessage_formername_firstname(UNSIGNED1 wh) := InValidMessageFT_formername_firstname(wh);
 
EXPORT Make_formername_middlename(SALT34.StrType s0) := MakeFT_formername_middlename(s0);
EXPORT InValid_formername_middlename(SALT34.StrType s) := InValidFT_formername_middlename(s);
EXPORT InValidMessage_formername_middlename(UNSIGNED1 wh) := InValidMessageFT_formername_middlename(wh);
 
EXPORT Make_formername_middleinitial(SALT34.StrType s0) := MakeFT_formername_middleinitial(s0);
EXPORT InValid_formername_middleinitial(SALT34.StrType s) := InValidFT_formername_middleinitial(s);
EXPORT InValidMessage_formername_middleinitial(UNSIGNED1 wh) := InValidMessageFT_formername_middleinitial(wh);
 
EXPORT Make_formername_lastname(SALT34.StrType s0) := MakeFT_formername_lastname(s0);
EXPORT InValid_formername_lastname(SALT34.StrType s) := InValidFT_formername_lastname(s);
EXPORT InValidMessage_formername_lastname(UNSIGNED1 wh) := InValidMessageFT_formername_lastname(wh);
 
EXPORT Make_formername_suffix(SALT34.StrType s0) := MakeFT_formername_suffix(s0);
EXPORT InValid_formername_suffix(SALT34.StrType s) := InValidFT_formername_suffix(s);
EXPORT InValidMessage_formername_suffix(UNSIGNED1 wh) := InValidMessageFT_formername_suffix(wh);
 
EXPORT Make_aliasname_firstname(SALT34.StrType s0) := MakeFT_aliasname_firstname(s0);
EXPORT InValid_aliasname_firstname(SALT34.StrType s) := InValidFT_aliasname_firstname(s);
EXPORT InValidMessage_aliasname_firstname(UNSIGNED1 wh) := InValidMessageFT_aliasname_firstname(wh);
 
EXPORT Make_aliasname_middlename(SALT34.StrType s0) := MakeFT_aliasname_middlename(s0);
EXPORT InValid_aliasname_middlename(SALT34.StrType s) := InValidFT_aliasname_middlename(s);
EXPORT InValidMessage_aliasname_middlename(UNSIGNED1 wh) := InValidMessageFT_aliasname_middlename(wh);
 
EXPORT Make_aliasname_middleinitial(SALT34.StrType s0) := MakeFT_aliasname_middleinitial(s0);
EXPORT InValid_aliasname_middleinitial(SALT34.StrType s) := InValidFT_aliasname_middleinitial(s);
EXPORT InValidMessage_aliasname_middleinitial(UNSIGNED1 wh) := InValidMessageFT_aliasname_middleinitial(wh);
 
EXPORT Make_aliasname_lastname(SALT34.StrType s0) := MakeFT_aliasname_lastname(s0);
EXPORT InValid_aliasname_lastname(SALT34.StrType s) := InValidFT_aliasname_lastname(s);
EXPORT InValidMessage_aliasname_lastname(UNSIGNED1 wh) := InValidMessageFT_aliasname_lastname(wh);
 
EXPORT Make_aliasname_suffix(SALT34.StrType s0) := MakeFT_aliasname_suffix(s0);
EXPORT InValid_aliasname_suffix(SALT34.StrType s) := InValidFT_aliasname_suffix(s);
EXPORT InValidMessage_aliasname_suffix(UNSIGNED1 wh) := InValidMessageFT_aliasname_suffix(wh);
 
EXPORT Make_additionalname_firstname(SALT34.StrType s0) := MakeFT_additionalname_firstname(s0);
EXPORT InValid_additionalname_firstname(SALT34.StrType s) := InValidFT_additionalname_firstname(s);
EXPORT InValidMessage_additionalname_firstname(UNSIGNED1 wh) := InValidMessageFT_additionalname_firstname(wh);
 
EXPORT Make_additionalname_middlename(SALT34.StrType s0) := MakeFT_additionalname_middlename(s0);
EXPORT InValid_additionalname_middlename(SALT34.StrType s) := InValidFT_additionalname_middlename(s);
EXPORT InValidMessage_additionalname_middlename(UNSIGNED1 wh) := InValidMessageFT_additionalname_middlename(wh);
 
EXPORT Make_additionalname_middleinitial(SALT34.StrType s0) := MakeFT_additionalname_middleinitial(s0);
EXPORT InValid_additionalname_middleinitial(SALT34.StrType s) := InValidFT_additionalname_middleinitial(s);
EXPORT InValidMessage_additionalname_middleinitial(UNSIGNED1 wh) := InValidMessageFT_additionalname_middleinitial(wh);
 
EXPORT Make_additionalname_lastname(SALT34.StrType s0) := MakeFT_additionalname_lastname(s0);
EXPORT InValid_additionalname_lastname(SALT34.StrType s) := InValidFT_additionalname_lastname(s);
EXPORT InValidMessage_additionalname_lastname(UNSIGNED1 wh) := InValidMessageFT_additionalname_lastname(wh);
 
EXPORT Make_additionalname_suffix(SALT34.StrType s0) := MakeFT_additionalname_suffix(s0);
EXPORT InValid_additionalname_suffix(SALT34.StrType s) := InValidFT_additionalname_suffix(s);
EXPORT InValidMessage_additionalname_suffix(UNSIGNED1 wh) := InValidMessageFT_additionalname_suffix(wh);
 
EXPORT Make_aka1(SALT34.StrType s0) := MakeFT_aka1(s0);
EXPORT InValid_aka1(SALT34.StrType s) := InValidFT_aka1(s);
EXPORT InValidMessage_aka1(UNSIGNED1 wh) := InValidMessageFT_aka1(wh);
 
EXPORT Make_aka2(SALT34.StrType s0) := MakeFT_aka2(s0);
EXPORT InValid_aka2(SALT34.StrType s) := InValidFT_aka2(s);
EXPORT InValidMessage_aka2(UNSIGNED1 wh) := InValidMessageFT_aka2(wh);
 
EXPORT Make_aka3(SALT34.StrType s0) := MakeFT_aka3(s0);
EXPORT InValid_aka3(SALT34.StrType s) := InValidFT_aka3(s);
EXPORT InValidMessage_aka3(UNSIGNED1 wh) := InValidMessageFT_aka3(wh);
 
EXPORT Make_recordtype(SALT34.StrType s0) := MakeFT_recordtype(s0);
EXPORT InValid_recordtype(SALT34.StrType s) := InValidFT_recordtype(s);
EXPORT InValidMessage_recordtype(UNSIGNED1 wh) := InValidMessageFT_recordtype(wh);
 
EXPORT Make_addressstandardization(SALT34.StrType s0) := MakeFT_addressstandardization(s0);
EXPORT InValid_addressstandardization(SALT34.StrType s) := InValidFT_addressstandardization(s);
EXPORT InValidMessage_addressstandardization(UNSIGNED1 wh) := InValidMessageFT_addressstandardization(wh);
 
EXPORT Make_filesincedate(SALT34.StrType s0) := MakeFT_filesincedate(s0);
EXPORT InValid_filesincedate(SALT34.StrType s) := InValidFT_filesincedate(s);
EXPORT InValidMessage_filesincedate(UNSIGNED1 wh) := InValidMessageFT_filesincedate(wh);
 
EXPORT Make_compilationdate(SALT34.StrType s0) := MakeFT_compilationdate(s0);
EXPORT InValid_compilationdate(SALT34.StrType s) := InValidFT_compilationdate(s);
EXPORT InValidMessage_compilationdate(UNSIGNED1 wh) := InValidMessageFT_compilationdate(wh);
 
EXPORT Make_birthdateind(SALT34.StrType s0) := MakeFT_birthdateind(s0);
EXPORT InValid_birthdateind(SALT34.StrType s) := InValidFT_birthdateind(s);
EXPORT InValidMessage_birthdateind(UNSIGNED1 wh) := InValidMessageFT_birthdateind(wh);
 
EXPORT Make_orig_deceasedindicator(SALT34.StrType s0) := MakeFT_orig_deceasedindicator(s0);
EXPORT InValid_orig_deceasedindicator(SALT34.StrType s) := InValidFT_orig_deceasedindicator(s);
EXPORT InValidMessage_orig_deceasedindicator(UNSIGNED1 wh) := InValidMessageFT_orig_deceasedindicator(wh);
 
EXPORT Make_deceaseddate(SALT34.StrType s0) := MakeFT_deceaseddate(s0);
EXPORT InValid_deceaseddate(SALT34.StrType s) := InValidFT_deceaseddate(s);
EXPORT InValidMessage_deceaseddate(UNSIGNED1 wh) := InValidMessageFT_deceaseddate(wh);
 
EXPORT Make_addressseq(SALT34.StrType s0) := MakeFT_addressseq(s0);
EXPORT InValid_addressseq(SALT34.StrType s) := InValidFT_addressseq(s);
EXPORT InValidMessage_addressseq(UNSIGNED1 wh) := InValidMessageFT_addressseq(wh);
 
EXPORT Make_normaddress_address1(SALT34.StrType s0) := MakeFT_normaddress_address1(s0);
EXPORT InValid_normaddress_address1(SALT34.StrType s) := InValidFT_normaddress_address1(s);
EXPORT InValidMessage_normaddress_address1(UNSIGNED1 wh) := InValidMessageFT_normaddress_address1(wh);
 
EXPORT Make_normaddress_address2(SALT34.StrType s0) := MakeFT_normaddress_address2(s0);
EXPORT InValid_normaddress_address2(SALT34.StrType s) := InValidFT_normaddress_address2(s);
EXPORT InValidMessage_normaddress_address2(UNSIGNED1 wh) := InValidMessageFT_normaddress_address2(wh);
 
EXPORT Make_normaddress_city(SALT34.StrType s0) := MakeFT_normaddress_city(s0);
EXPORT InValid_normaddress_city(SALT34.StrType s) := InValidFT_normaddress_city(s);
EXPORT InValidMessage_normaddress_city(UNSIGNED1 wh) := InValidMessageFT_normaddress_city(wh);
 
EXPORT Make_normaddress_state(SALT34.StrType s0) := MakeFT_normaddress_state(s0);
EXPORT InValid_normaddress_state(SALT34.StrType s) := InValidFT_normaddress_state(s);
EXPORT InValidMessage_normaddress_state(UNSIGNED1 wh) := InValidMessageFT_normaddress_state(wh);
 
EXPORT Make_normaddress_zipcode(SALT34.StrType s0) := MakeFT_normaddress_zipcode(s0);
EXPORT InValid_normaddress_zipcode(SALT34.StrType s) := InValidFT_normaddress_zipcode(s);
EXPORT InValidMessage_normaddress_zipcode(UNSIGNED1 wh) := InValidMessageFT_normaddress_zipcode(wh);
 
EXPORT Make_normaddress_updateddate(SALT34.StrType s0) := MakeFT_normaddress_updateddate(s0);
EXPORT InValid_normaddress_updateddate(SALT34.StrType s) := InValidFT_normaddress_updateddate(s);
EXPORT InValidMessage_normaddress_updateddate(UNSIGNED1 wh) := InValidMessageFT_normaddress_updateddate(wh);
 
EXPORT Make_name(SALT34.StrType s0) := MakeFT_name(s0);
EXPORT InValid_name(SALT34.StrType s) := InValidFT_name(s);
EXPORT InValidMessage_name(UNSIGNED1 wh) := InValidMessageFT_name(wh);
 
EXPORT Make_nametype(SALT34.StrType s0) := MakeFT_nametype(s0);
EXPORT InValid_nametype(SALT34.StrType s) := InValidFT_nametype(s);
EXPORT InValidMessage_nametype(UNSIGNED1 wh) := InValidMessageFT_nametype(wh);
 
EXPORT Make_title(SALT34.StrType s0) := MakeFT_title(s0);
EXPORT InValid_title(SALT34.StrType s) := InValidFT_title(s);
EXPORT InValidMessage_title(UNSIGNED1 wh) := InValidMessageFT_title(wh);
 
EXPORT Make_fname(SALT34.StrType s0) := MakeFT_fname(s0);
EXPORT InValid_fname(SALT34.StrType s) := InValidFT_fname(s);
EXPORT InValidMessage_fname(UNSIGNED1 wh) := InValidMessageFT_fname(wh);
 
EXPORT Make_mname(SALT34.StrType s0) := MakeFT_mname(s0);
EXPORT InValid_mname(SALT34.StrType s) := InValidFT_mname(s);
EXPORT InValidMessage_mname(UNSIGNED1 wh) := InValidMessageFT_mname(wh);
 
EXPORT Make_lname(SALT34.StrType s0) := MakeFT_lname(s0);
EXPORT InValid_lname(SALT34.StrType s) := InValidFT_lname(s);
EXPORT InValidMessage_lname(UNSIGNED1 wh) := InValidMessageFT_lname(wh);
 
EXPORT Make_name_suffix(SALT34.StrType s0) := MakeFT_name_suffix(s0);
EXPORT InValid_name_suffix(SALT34.StrType s) := InValidFT_name_suffix(s);
EXPORT InValidMessage_name_suffix(UNSIGNED1 wh) := InValidMessageFT_name_suffix(wh);
 
EXPORT Make_name_score(SALT34.StrType s0) := MakeFT_name_score(s0);
EXPORT InValid_name_score(SALT34.StrType s) := InValidFT_name_score(s);
EXPORT InValidMessage_name_score(UNSIGNED1 wh) := InValidMessageFT_name_score(wh);
 
EXPORT Make_prim_range(SALT34.StrType s0) := MakeFT_prim_range(s0);
EXPORT InValid_prim_range(SALT34.StrType s) := InValidFT_prim_range(s);
EXPORT InValidMessage_prim_range(UNSIGNED1 wh) := InValidMessageFT_prim_range(wh);
 
EXPORT Make_predir(SALT34.StrType s0) := MakeFT_predir(s0);
EXPORT InValid_predir(SALT34.StrType s) := InValidFT_predir(s);
EXPORT InValidMessage_predir(UNSIGNED1 wh) := InValidMessageFT_predir(wh);
 
EXPORT Make_prim_name(SALT34.StrType s0) := MakeFT_prim_name(s0);
EXPORT InValid_prim_name(SALT34.StrType s) := InValidFT_prim_name(s);
EXPORT InValidMessage_prim_name(UNSIGNED1 wh) := InValidMessageFT_prim_name(wh);
 
EXPORT Make_addr_suffix(SALT34.StrType s0) := MakeFT_addr_suffix(s0);
EXPORT InValid_addr_suffix(SALT34.StrType s) := InValidFT_addr_suffix(s);
EXPORT InValidMessage_addr_suffix(UNSIGNED1 wh) := InValidMessageFT_addr_suffix(wh);
 
EXPORT Make_postdir(SALT34.StrType s0) := MakeFT_postdir(s0);
EXPORT InValid_postdir(SALT34.StrType s) := InValidFT_postdir(s);
EXPORT InValidMessage_postdir(UNSIGNED1 wh) := InValidMessageFT_postdir(wh);
 
EXPORT Make_unit_desig(SALT34.StrType s0) := MakeFT_unit_desig(s0);
EXPORT InValid_unit_desig(SALT34.StrType s) := InValidFT_unit_desig(s);
EXPORT InValidMessage_unit_desig(UNSIGNED1 wh) := InValidMessageFT_unit_desig(wh);
 
EXPORT Make_sec_range(SALT34.StrType s0) := MakeFT_sec_range(s0);
EXPORT InValid_sec_range(SALT34.StrType s) := InValidFT_sec_range(s);
EXPORT InValidMessage_sec_range(UNSIGNED1 wh) := InValidMessageFT_sec_range(wh);
 
EXPORT Make_p_city_name(SALT34.StrType s0) := MakeFT_p_city_name(s0);
EXPORT InValid_p_city_name(SALT34.StrType s) := InValidFT_p_city_name(s);
EXPORT InValidMessage_p_city_name(UNSIGNED1 wh) := InValidMessageFT_p_city_name(wh);
 
EXPORT Make_v_city_name(SALT34.StrType s0) := MakeFT_v_city_name(s0);
EXPORT InValid_v_city_name(SALT34.StrType s) := InValidFT_v_city_name(s);
EXPORT InValidMessage_v_city_name(UNSIGNED1 wh) := InValidMessageFT_v_city_name(wh);
 
EXPORT Make_st(SALT34.StrType s0) := MakeFT_st(s0);
EXPORT InValid_st(SALT34.StrType s) := InValidFT_st(s);
EXPORT InValidMessage_st(UNSIGNED1 wh) := InValidMessageFT_st(wh);
 
EXPORT Make_zip(SALT34.StrType s0) := MakeFT_zip(s0);
EXPORT InValid_zip(SALT34.StrType s) := InValidFT_zip(s);
EXPORT InValidMessage_zip(UNSIGNED1 wh) := InValidMessageFT_zip(wh);
 
EXPORT Make_zip4(SALT34.StrType s0) := MakeFT_zip4(s0);
EXPORT InValid_zip4(SALT34.StrType s) := InValidFT_zip4(s);
EXPORT InValidMessage_zip4(UNSIGNED1 wh) := InValidMessageFT_zip4(wh);
 
EXPORT Make_cart(SALT34.StrType s0) := MakeFT_cart(s0);
EXPORT InValid_cart(SALT34.StrType s) := InValidFT_cart(s);
EXPORT InValidMessage_cart(UNSIGNED1 wh) := InValidMessageFT_cart(wh);
 
EXPORT Make_cr_sort_sz(SALT34.StrType s0) := MakeFT_cr_sort_sz(s0);
EXPORT InValid_cr_sort_sz(SALT34.StrType s) := InValidFT_cr_sort_sz(s);
EXPORT InValidMessage_cr_sort_sz(UNSIGNED1 wh) := InValidMessageFT_cr_sort_sz(wh);
 
EXPORT Make_lot(SALT34.StrType s0) := MakeFT_lot(s0);
EXPORT InValid_lot(SALT34.StrType s) := InValidFT_lot(s);
EXPORT InValidMessage_lot(UNSIGNED1 wh) := InValidMessageFT_lot(wh);
 
EXPORT Make_lot_order(SALT34.StrType s0) := MakeFT_lot_order(s0);
EXPORT InValid_lot_order(SALT34.StrType s) := InValidFT_lot_order(s);
EXPORT InValidMessage_lot_order(UNSIGNED1 wh) := InValidMessageFT_lot_order(wh);
 
EXPORT Make_dbpc(SALT34.StrType s0) := MakeFT_dbpc(s0);
EXPORT InValid_dbpc(SALT34.StrType s) := InValidFT_dbpc(s);
EXPORT InValidMessage_dbpc(UNSIGNED1 wh) := InValidMessageFT_dbpc(wh);
 
EXPORT Make_chk_digit(SALT34.StrType s0) := MakeFT_chk_digit(s0);
EXPORT InValid_chk_digit(SALT34.StrType s) := InValidFT_chk_digit(s);
EXPORT InValidMessage_chk_digit(UNSIGNED1 wh) := InValidMessageFT_chk_digit(wh);
 
EXPORT Make_rec_type(SALT34.StrType s0) := MakeFT_rec_type(s0);
EXPORT InValid_rec_type(SALT34.StrType s) := InValidFT_rec_type(s);
EXPORT InValidMessage_rec_type(UNSIGNED1 wh) := InValidMessageFT_rec_type(wh);
 
EXPORT Make_county(SALT34.StrType s0) := MakeFT_county(s0);
EXPORT InValid_county(SALT34.StrType s) := InValidFT_county(s);
EXPORT InValidMessage_county(UNSIGNED1 wh) := InValidMessageFT_county(wh);
 
EXPORT Make_geo_lat(SALT34.StrType s0) := MakeFT_geo_lat(s0);
EXPORT InValid_geo_lat(SALT34.StrType s) := InValidFT_geo_lat(s);
EXPORT InValidMessage_geo_lat(UNSIGNED1 wh) := InValidMessageFT_geo_lat(wh);
 
EXPORT Make_geo_long(SALT34.StrType s0) := MakeFT_geo_long(s0);
EXPORT InValid_geo_long(SALT34.StrType s) := InValidFT_geo_long(s);
EXPORT InValidMessage_geo_long(UNSIGNED1 wh) := InValidMessageFT_geo_long(wh);
 
EXPORT Make_msa(SALT34.StrType s0) := MakeFT_msa(s0);
EXPORT InValid_msa(SALT34.StrType s) := InValidFT_msa(s);
EXPORT InValidMessage_msa(UNSIGNED1 wh) := InValidMessageFT_msa(wh);
 
EXPORT Make_geo_blk(SALT34.StrType s0) := MakeFT_geo_blk(s0);
EXPORT InValid_geo_blk(SALT34.StrType s) := InValidFT_geo_blk(s);
EXPORT InValidMessage_geo_blk(UNSIGNED1 wh) := InValidMessageFT_geo_blk(wh);
 
EXPORT Make_geo_match(SALT34.StrType s0) := MakeFT_geo_match(s0);
EXPORT InValid_geo_match(SALT34.StrType s) := InValidFT_geo_match(s);
EXPORT InValidMessage_geo_match(UNSIGNED1 wh) := InValidMessageFT_geo_match(wh);
 
EXPORT Make_err_stat(SALT34.StrType s0) := MakeFT_err_stat(s0);
EXPORT InValid_err_stat(SALT34.StrType s) := InValidFT_err_stat(s);
EXPORT InValidMessage_err_stat(UNSIGNED1 wh) := InValidMessageFT_err_stat(wh);
 
EXPORT Make_transferdate_unformatted(SALT34.StrType s0) := MakeFT_transferdate_unformatted(s0);
EXPORT InValid_transferdate_unformatted(SALT34.StrType s) := InValidFT_transferdate_unformatted(s);
EXPORT InValidMessage_transferdate_unformatted(UNSIGNED1 wh) := InValidMessageFT_transferdate_unformatted(wh);
 
EXPORT Make_birthdate_unformatted(SALT34.StrType s0) := MakeFT_birthdate_unformatted(s0);
EXPORT InValid_birthdate_unformatted(SALT34.StrType s) := InValidFT_birthdate_unformatted(s);
EXPORT InValidMessage_birthdate_unformatted(UNSIGNED1 wh) := InValidMessageFT_birthdate_unformatted(wh);
 
EXPORT Make_dob_no_conflict(SALT34.StrType s0) := MakeFT_dob_no_conflict(s0);
EXPORT InValid_dob_no_conflict(SALT34.StrType s) := InValidFT_dob_no_conflict(s);
EXPORT InValidMessage_dob_no_conflict(UNSIGNED1 wh) := InValidMessageFT_dob_no_conflict(wh);
 
EXPORT Make_updatedate_unformatted(SALT34.StrType s0) := MakeFT_updatedate_unformatted(s0);
EXPORT InValid_updatedate_unformatted(SALT34.StrType s) := InValidFT_updatedate_unformatted(s);
EXPORT InValidMessage_updatedate_unformatted(UNSIGNED1 wh) := InValidMessageFT_updatedate_unformatted(wh);
 
EXPORT Make_consumerupdatedate_unformatted(SALT34.StrType s0) := MakeFT_consumerupdatedate_unformatted(s0);
EXPORT InValid_consumerupdatedate_unformatted(SALT34.StrType s) := InValidFT_consumerupdatedate_unformatted(s);
EXPORT InValidMessage_consumerupdatedate_unformatted(UNSIGNED1 wh) := InValidMessageFT_consumerupdatedate_unformatted(wh);
 
EXPORT Make_filesincedate_unformatted(SALT34.StrType s0) := MakeFT_filesincedate_unformatted(s0);
EXPORT InValid_filesincedate_unformatted(SALT34.StrType s) := InValidFT_filesincedate_unformatted(s);
EXPORT InValidMessage_filesincedate_unformatted(UNSIGNED1 wh) := InValidMessageFT_filesincedate_unformatted(wh);
 
EXPORT Make_compilationdate_unformatted(SALT34.StrType s0) := MakeFT_compilationdate_unformatted(s0);
EXPORT InValid_compilationdate_unformatted(SALT34.StrType s) := InValidFT_compilationdate_unformatted(s);
EXPORT InValidMessage_compilationdate_unformatted(UNSIGNED1 wh) := InValidMessageFT_compilationdate_unformatted(wh);
 
EXPORT Make_ssn_unformatted(SALT34.StrType s0) := MakeFT_ssn_unformatted(s0);
EXPORT InValid_ssn_unformatted(SALT34.StrType s) := InValidFT_ssn_unformatted(s);
EXPORT InValidMessage_ssn_unformatted(UNSIGNED1 wh) := InValidMessageFT_ssn_unformatted(wh);
 
EXPORT Make_ssn_no_conflict(SALT34.StrType s0) := MakeFT_ssn_no_conflict(s0);
EXPORT InValid_ssn_no_conflict(SALT34.StrType s) := InValidFT_ssn_no_conflict(s);
EXPORT InValidMessage_ssn_no_conflict(UNSIGNED1 wh) := InValidMessageFT_ssn_no_conflict(wh);
 
EXPORT Make_telephone_unformatted(SALT34.StrType s0) := MakeFT_telephone_unformatted(s0);
EXPORT InValid_telephone_unformatted(SALT34.StrType s) := InValidFT_telephone_unformatted(s);
EXPORT InValidMessage_telephone_unformatted(UNSIGNED1 wh) := InValidMessageFT_telephone_unformatted(wh);
 
EXPORT Make_deceasedindicator(SALT34.StrType s0) := MakeFT_deceasedindicator(s0);
EXPORT InValid_deceasedindicator(SALT34.StrType s) := InValidFT_deceasedindicator(s);
EXPORT InValidMessage_deceasedindicator(UNSIGNED1 wh) := InValidMessageFT_deceasedindicator(wh);
 
EXPORT Make_did(SALT34.StrType s0) := MakeFT_did(s0);
EXPORT InValid_did(SALT34.StrType s) := InValidFT_did(s);
EXPORT InValidMessage_did(UNSIGNED1 wh) := InValidMessageFT_did(wh);
 
EXPORT Make_did_score_field(SALT34.StrType s0) := MakeFT_did_score_field(s0);
EXPORT InValid_did_score_field(SALT34.StrType s) := InValidFT_did_score_field(s);
EXPORT InValidMessage_did_score_field(UNSIGNED1 wh) := InValidMessageFT_did_score_field(wh);
 
EXPORT Make_is_current(SALT34.StrType s0) := MakeFT_is_current(s0);
EXPORT InValid_is_current(SALT34.StrType s) := InValidFT_is_current(s);
EXPORT InValidMessage_is_current(UNSIGNED1 wh) := InValidMessageFT_is_current(wh);
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT34,Scrubs_TUCS;
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
    BOOLEAN Diff_dt_first_seen;
    BOOLEAN Diff_dt_last_seen;
    BOOLEAN Diff_dt_vendor_first_reported;
    BOOLEAN Diff_dt_vendor_last_reported;
    BOOLEAN Diff_filetype;
    BOOLEAN Diff_filedate;
    BOOLEAN Diff_vendordocumentidentifier;
    BOOLEAN Diff_transferdate;
    BOOLEAN Diff_currentname_firstname;
    BOOLEAN Diff_currentname_middlename;
    BOOLEAN Diff_currentname_middleinitial;
    BOOLEAN Diff_currentname_lastname;
    BOOLEAN Diff_currentname_suffix;
    BOOLEAN Diff_currentname_gender;
    BOOLEAN Diff_currentname_dob_mm;
    BOOLEAN Diff_currentname_dob_dd;
    BOOLEAN Diff_currentname_dob_yyyy;
    BOOLEAN Diff_currentname_deathindicator;
    BOOLEAN Diff_ssnfull;
    BOOLEAN Diff_ssnfirst5digit;
    BOOLEAN Diff_ssnlast4digit;
    BOOLEAN Diff_consumerupdatedate;
    BOOLEAN Diff_telephonenumber;
    BOOLEAN Diff_citedid;
    BOOLEAN Diff_fileid;
    BOOLEAN Diff_publication;
    BOOLEAN Diff_currentaddress_address1;
    BOOLEAN Diff_currentaddress_address2;
    BOOLEAN Diff_currentaddress_city;
    BOOLEAN Diff_currentaddress_state;
    BOOLEAN Diff_currentaddress_zipcode;
    BOOLEAN Diff_currentaddress_updateddate;
    BOOLEAN Diff_housenumber;
    BOOLEAN Diff_streettype;
    BOOLEAN Diff_streetdirection;
    BOOLEAN Diff_streetname;
    BOOLEAN Diff_apartmentnumber;
    BOOLEAN Diff_city;
    BOOLEAN Diff_state;
    BOOLEAN Diff_zipcode;
    BOOLEAN Diff_zip4u;
    BOOLEAN Diff_previousaddress_address1;
    BOOLEAN Diff_previousaddress_address2;
    BOOLEAN Diff_previousaddress_city;
    BOOLEAN Diff_previousaddress_state;
    BOOLEAN Diff_previousaddress_zipcode;
    BOOLEAN Diff_previousaddress_updateddate;
    BOOLEAN Diff_formername_firstname;
    BOOLEAN Diff_formername_middlename;
    BOOLEAN Diff_formername_middleinitial;
    BOOLEAN Diff_formername_lastname;
    BOOLEAN Diff_formername_suffix;
    BOOLEAN Diff_aliasname_firstname;
    BOOLEAN Diff_aliasname_middlename;
    BOOLEAN Diff_aliasname_middleinitial;
    BOOLEAN Diff_aliasname_lastname;
    BOOLEAN Diff_aliasname_suffix;
    BOOLEAN Diff_additionalname_firstname;
    BOOLEAN Diff_additionalname_middlename;
    BOOLEAN Diff_additionalname_middleinitial;
    BOOLEAN Diff_additionalname_lastname;
    BOOLEAN Diff_additionalname_suffix;
    BOOLEAN Diff_aka1;
    BOOLEAN Diff_aka2;
    BOOLEAN Diff_aka3;
    BOOLEAN Diff_recordtype;
    BOOLEAN Diff_addressstandardization;
    BOOLEAN Diff_filesincedate;
    BOOLEAN Diff_compilationdate;
    BOOLEAN Diff_birthdateind;
    BOOLEAN Diff_orig_deceasedindicator;
    BOOLEAN Diff_deceaseddate;
    BOOLEAN Diff_addressseq;
    BOOLEAN Diff_normaddress_address1;
    BOOLEAN Diff_normaddress_address2;
    BOOLEAN Diff_normaddress_city;
    BOOLEAN Diff_normaddress_state;
    BOOLEAN Diff_normaddress_zipcode;
    BOOLEAN Diff_normaddress_updateddate;
    BOOLEAN Diff_name;
    BOOLEAN Diff_nametype;
    BOOLEAN Diff_title;
    BOOLEAN Diff_fname;
    BOOLEAN Diff_mname;
    BOOLEAN Diff_lname;
    BOOLEAN Diff_name_suffix;
    BOOLEAN Diff_name_score;
    BOOLEAN Diff_prim_range;
    BOOLEAN Diff_predir;
    BOOLEAN Diff_prim_name;
    BOOLEAN Diff_addr_suffix;
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
    BOOLEAN Diff_dbpc;
    BOOLEAN Diff_chk_digit;
    BOOLEAN Diff_rec_type;
    BOOLEAN Diff_county;
    BOOLEAN Diff_geo_lat;
    BOOLEAN Diff_geo_long;
    BOOLEAN Diff_msa;
    BOOLEAN Diff_geo_blk;
    BOOLEAN Diff_geo_match;
    BOOLEAN Diff_err_stat;
    BOOLEAN Diff_transferdate_unformatted;
    BOOLEAN Diff_birthdate_unformatted;
    BOOLEAN Diff_dob_no_conflict;
    BOOLEAN Diff_updatedate_unformatted;
    BOOLEAN Diff_consumerupdatedate_unformatted;
    BOOLEAN Diff_filesincedate_unformatted;
    BOOLEAN Diff_compilationdate_unformatted;
    BOOLEAN Diff_ssn_unformatted;
    BOOLEAN Diff_ssn_no_conflict;
    BOOLEAN Diff_telephone_unformatted;
    BOOLEAN Diff_deceasedindicator;
    BOOLEAN Diff_did;
    BOOLEAN Diff_did_score_field;
    BOOLEAN Diff_is_current;
    UNSIGNED Num_Diffs;
    SALT34.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_dt_first_seen := le.dt_first_seen <> ri.dt_first_seen;
    SELF.Diff_dt_last_seen := le.dt_last_seen <> ri.dt_last_seen;
    SELF.Diff_dt_vendor_first_reported := le.dt_vendor_first_reported <> ri.dt_vendor_first_reported;
    SELF.Diff_dt_vendor_last_reported := le.dt_vendor_last_reported <> ri.dt_vendor_last_reported;
    SELF.Diff_filetype := le.filetype <> ri.filetype;
    SELF.Diff_filedate := le.filedate <> ri.filedate;
    SELF.Diff_vendordocumentidentifier := le.vendordocumentidentifier <> ri.vendordocumentidentifier;
    SELF.Diff_transferdate := le.transferdate <> ri.transferdate;
    SELF.Diff_currentname_firstname := le.currentname_firstname <> ri.currentname_firstname;
    SELF.Diff_currentname_middlename := le.currentname_middlename <> ri.currentname_middlename;
    SELF.Diff_currentname_middleinitial := le.currentname_middleinitial <> ri.currentname_middleinitial;
    SELF.Diff_currentname_lastname := le.currentname_lastname <> ri.currentname_lastname;
    SELF.Diff_currentname_suffix := le.currentname_suffix <> ri.currentname_suffix;
    SELF.Diff_currentname_gender := le.currentname_gender <> ri.currentname_gender;
    SELF.Diff_currentname_dob_mm := le.currentname_dob_mm <> ri.currentname_dob_mm;
    SELF.Diff_currentname_dob_dd := le.currentname_dob_dd <> ri.currentname_dob_dd;
    SELF.Diff_currentname_dob_yyyy := le.currentname_dob_yyyy <> ri.currentname_dob_yyyy;
    SELF.Diff_currentname_deathindicator := le.currentname_deathindicator <> ri.currentname_deathindicator;
    SELF.Diff_ssnfull := le.ssnfull <> ri.ssnfull;
    SELF.Diff_ssnfirst5digit := le.ssnfirst5digit <> ri.ssnfirst5digit;
    SELF.Diff_ssnlast4digit := le.ssnlast4digit <> ri.ssnlast4digit;
    SELF.Diff_consumerupdatedate := le.consumerupdatedate <> ri.consumerupdatedate;
    SELF.Diff_telephonenumber := le.telephonenumber <> ri.telephonenumber;
    SELF.Diff_citedid := le.citedid <> ri.citedid;
    SELF.Diff_fileid := le.fileid <> ri.fileid;
    SELF.Diff_publication := le.publication <> ri.publication;
    SELF.Diff_currentaddress_address1 := le.currentaddress_address1 <> ri.currentaddress_address1;
    SELF.Diff_currentaddress_address2 := le.currentaddress_address2 <> ri.currentaddress_address2;
    SELF.Diff_currentaddress_city := le.currentaddress_city <> ri.currentaddress_city;
    SELF.Diff_currentaddress_state := le.currentaddress_state <> ri.currentaddress_state;
    SELF.Diff_currentaddress_zipcode := le.currentaddress_zipcode <> ri.currentaddress_zipcode;
    SELF.Diff_currentaddress_updateddate := le.currentaddress_updateddate <> ri.currentaddress_updateddate;
    SELF.Diff_housenumber := le.housenumber <> ri.housenumber;
    SELF.Diff_streettype := le.streettype <> ri.streettype;
    SELF.Diff_streetdirection := le.streetdirection <> ri.streetdirection;
    SELF.Diff_streetname := le.streetname <> ri.streetname;
    SELF.Diff_apartmentnumber := le.apartmentnumber <> ri.apartmentnumber;
    SELF.Diff_city := le.city <> ri.city;
    SELF.Diff_state := le.state <> ri.state;
    SELF.Diff_zipcode := le.zipcode <> ri.zipcode;
    SELF.Diff_zip4u := le.zip4u <> ri.zip4u;
    SELF.Diff_previousaddress_address1 := le.previousaddress_address1 <> ri.previousaddress_address1;
    SELF.Diff_previousaddress_address2 := le.previousaddress_address2 <> ri.previousaddress_address2;
    SELF.Diff_previousaddress_city := le.previousaddress_city <> ri.previousaddress_city;
    SELF.Diff_previousaddress_state := le.previousaddress_state <> ri.previousaddress_state;
    SELF.Diff_previousaddress_zipcode := le.previousaddress_zipcode <> ri.previousaddress_zipcode;
    SELF.Diff_previousaddress_updateddate := le.previousaddress_updateddate <> ri.previousaddress_updateddate;
    SELF.Diff_formername_firstname := le.formername_firstname <> ri.formername_firstname;
    SELF.Diff_formername_middlename := le.formername_middlename <> ri.formername_middlename;
    SELF.Diff_formername_middleinitial := le.formername_middleinitial <> ri.formername_middleinitial;
    SELF.Diff_formername_lastname := le.formername_lastname <> ri.formername_lastname;
    SELF.Diff_formername_suffix := le.formername_suffix <> ri.formername_suffix;
    SELF.Diff_aliasname_firstname := le.aliasname_firstname <> ri.aliasname_firstname;
    SELF.Diff_aliasname_middlename := le.aliasname_middlename <> ri.aliasname_middlename;
    SELF.Diff_aliasname_middleinitial := le.aliasname_middleinitial <> ri.aliasname_middleinitial;
    SELF.Diff_aliasname_lastname := le.aliasname_lastname <> ri.aliasname_lastname;
    SELF.Diff_aliasname_suffix := le.aliasname_suffix <> ri.aliasname_suffix;
    SELF.Diff_additionalname_firstname := le.additionalname_firstname <> ri.additionalname_firstname;
    SELF.Diff_additionalname_middlename := le.additionalname_middlename <> ri.additionalname_middlename;
    SELF.Diff_additionalname_middleinitial := le.additionalname_middleinitial <> ri.additionalname_middleinitial;
    SELF.Diff_additionalname_lastname := le.additionalname_lastname <> ri.additionalname_lastname;
    SELF.Diff_additionalname_suffix := le.additionalname_suffix <> ri.additionalname_suffix;
    SELF.Diff_aka1 := le.aka1 <> ri.aka1;
    SELF.Diff_aka2 := le.aka2 <> ri.aka2;
    SELF.Diff_aka3 := le.aka3 <> ri.aka3;
    SELF.Diff_recordtype := le.recordtype <> ri.recordtype;
    SELF.Diff_addressstandardization := le.addressstandardization <> ri.addressstandardization;
    SELF.Diff_filesincedate := le.filesincedate <> ri.filesincedate;
    SELF.Diff_compilationdate := le.compilationdate <> ri.compilationdate;
    SELF.Diff_birthdateind := le.birthdateind <> ri.birthdateind;
    SELF.Diff_orig_deceasedindicator := le.orig_deceasedindicator <> ri.orig_deceasedindicator;
    SELF.Diff_deceaseddate := le.deceaseddate <> ri.deceaseddate;
    SELF.Diff_addressseq := le.addressseq <> ri.addressseq;
    SELF.Diff_normaddress_address1 := le.normaddress_address1 <> ri.normaddress_address1;
    SELF.Diff_normaddress_address2 := le.normaddress_address2 <> ri.normaddress_address2;
    SELF.Diff_normaddress_city := le.normaddress_city <> ri.normaddress_city;
    SELF.Diff_normaddress_state := le.normaddress_state <> ri.normaddress_state;
    SELF.Diff_normaddress_zipcode := le.normaddress_zipcode <> ri.normaddress_zipcode;
    SELF.Diff_normaddress_updateddate := le.normaddress_updateddate <> ri.normaddress_updateddate;
    SELF.Diff_name := le.name <> ri.name;
    SELF.Diff_nametype := le.nametype <> ri.nametype;
    SELF.Diff_title := le.title <> ri.title;
    SELF.Diff_fname := le.fname <> ri.fname;
    SELF.Diff_mname := le.mname <> ri.mname;
    SELF.Diff_lname := le.lname <> ri.lname;
    SELF.Diff_name_suffix := le.name_suffix <> ri.name_suffix;
    SELF.Diff_name_score := le.name_score <> ri.name_score;
    SELF.Diff_prim_range := le.prim_range <> ri.prim_range;
    SELF.Diff_predir := le.predir <> ri.predir;
    SELF.Diff_prim_name := le.prim_name <> ri.prim_name;
    SELF.Diff_addr_suffix := le.addr_suffix <> ri.addr_suffix;
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
    SELF.Diff_dbpc := le.dbpc <> ri.dbpc;
    SELF.Diff_chk_digit := le.chk_digit <> ri.chk_digit;
    SELF.Diff_rec_type := le.rec_type <> ri.rec_type;
    SELF.Diff_county := le.county <> ri.county;
    SELF.Diff_geo_lat := le.geo_lat <> ri.geo_lat;
    SELF.Diff_geo_long := le.geo_long <> ri.geo_long;
    SELF.Diff_msa := le.msa <> ri.msa;
    SELF.Diff_geo_blk := le.geo_blk <> ri.geo_blk;
    SELF.Diff_geo_match := le.geo_match <> ri.geo_match;
    SELF.Diff_err_stat := le.err_stat <> ri.err_stat;
    SELF.Diff_transferdate_unformatted := le.transferdate_unformatted <> ri.transferdate_unformatted;
    SELF.Diff_birthdate_unformatted := le.birthdate_unformatted <> ri.birthdate_unformatted;
    SELF.Diff_dob_no_conflict := le.dob_no_conflict <> ri.dob_no_conflict;
    SELF.Diff_updatedate_unformatted := le.updatedate_unformatted <> ri.updatedate_unformatted;
    SELF.Diff_consumerupdatedate_unformatted := le.consumerupdatedate_unformatted <> ri.consumerupdatedate_unformatted;
    SELF.Diff_filesincedate_unformatted := le.filesincedate_unformatted <> ri.filesincedate_unformatted;
    SELF.Diff_compilationdate_unformatted := le.compilationdate_unformatted <> ri.compilationdate_unformatted;
    SELF.Diff_ssn_unformatted := le.ssn_unformatted <> ri.ssn_unformatted;
    SELF.Diff_ssn_no_conflict := le.ssn_no_conflict <> ri.ssn_no_conflict;
    SELF.Diff_telephone_unformatted := le.telephone_unformatted <> ri.telephone_unformatted;
    SELF.Diff_deceasedindicator := le.deceasedindicator <> ri.deceasedindicator;
    SELF.Diff_did := le.did <> ri.did;
    SELF.Diff_did_score_field := le.did_score_field <> ri.did_score_field;
    SELF.Diff_is_current := le.is_current <> ri.is_current;
    SELF.Val := (SALT34.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_dt_first_seen,1,0)+ IF( SELF.Diff_dt_last_seen,1,0)+ IF( SELF.Diff_dt_vendor_first_reported,1,0)+ IF( SELF.Diff_dt_vendor_last_reported,1,0)+ IF( SELF.Diff_filetype,1,0)+ IF( SELF.Diff_filedate,1,0)+ IF( SELF.Diff_vendordocumentidentifier,1,0)+ IF( SELF.Diff_transferdate,1,0)+ IF( SELF.Diff_currentname_firstname,1,0)+ IF( SELF.Diff_currentname_middlename,1,0)+ IF( SELF.Diff_currentname_middleinitial,1,0)+ IF( SELF.Diff_currentname_lastname,1,0)+ IF( SELF.Diff_currentname_suffix,1,0)+ IF( SELF.Diff_currentname_gender,1,0)+ IF( SELF.Diff_currentname_dob_mm,1,0)+ IF( SELF.Diff_currentname_dob_dd,1,0)+ IF( SELF.Diff_currentname_dob_yyyy,1,0)+ IF( SELF.Diff_currentname_deathindicator,1,0)+ IF( SELF.Diff_ssnfull,1,0)+ IF( SELF.Diff_ssnfirst5digit,1,0)+ IF( SELF.Diff_ssnlast4digit,1,0)+ IF( SELF.Diff_consumerupdatedate,1,0)+ IF( SELF.Diff_telephonenumber,1,0)+ IF( SELF.Diff_citedid,1,0)+ IF( SELF.Diff_fileid,1,0)+ IF( SELF.Diff_publication,1,0)+ IF( SELF.Diff_currentaddress_address1,1,0)+ IF( SELF.Diff_currentaddress_address2,1,0)+ IF( SELF.Diff_currentaddress_city,1,0)+ IF( SELF.Diff_currentaddress_state,1,0)+ IF( SELF.Diff_currentaddress_zipcode,1,0)+ IF( SELF.Diff_currentaddress_updateddate,1,0)+ IF( SELF.Diff_housenumber,1,0)+ IF( SELF.Diff_streettype,1,0)+ IF( SELF.Diff_streetdirection,1,0)+ IF( SELF.Diff_streetname,1,0)+ IF( SELF.Diff_apartmentnumber,1,0)+ IF( SELF.Diff_city,1,0)+ IF( SELF.Diff_state,1,0)+ IF( SELF.Diff_zipcode,1,0)+ IF( SELF.Diff_zip4u,1,0)+ IF( SELF.Diff_previousaddress_address1,1,0)+ IF( SELF.Diff_previousaddress_address2,1,0)+ IF( SELF.Diff_previousaddress_city,1,0)+ IF( SELF.Diff_previousaddress_state,1,0)+ IF( SELF.Diff_previousaddress_zipcode,1,0)+ IF( SELF.Diff_previousaddress_updateddate,1,0)+ IF( SELF.Diff_formername_firstname,1,0)+ IF( SELF.Diff_formername_middlename,1,0)+ IF( SELF.Diff_formername_middleinitial,1,0)+ IF( SELF.Diff_formername_lastname,1,0)+ IF( SELF.Diff_formername_suffix,1,0)+ IF( SELF.Diff_aliasname_firstname,1,0)+ IF( SELF.Diff_aliasname_middlename,1,0)+ IF( SELF.Diff_aliasname_middleinitial,1,0)+ IF( SELF.Diff_aliasname_lastname,1,0)+ IF( SELF.Diff_aliasname_suffix,1,0)+ IF( SELF.Diff_additionalname_firstname,1,0)+ IF( SELF.Diff_additionalname_middlename,1,0)+ IF( SELF.Diff_additionalname_middleinitial,1,0)+ IF( SELF.Diff_additionalname_lastname,1,0)+ IF( SELF.Diff_additionalname_suffix,1,0)+ IF( SELF.Diff_aka1,1,0)+ IF( SELF.Diff_aka2,1,0)+ IF( SELF.Diff_aka3,1,0)+ IF( SELF.Diff_recordtype,1,0)+ IF( SELF.Diff_addressstandardization,1,0)+ IF( SELF.Diff_filesincedate,1,0)+ IF( SELF.Diff_compilationdate,1,0)+ IF( SELF.Diff_birthdateind,1,0)+ IF( SELF.Diff_orig_deceasedindicator,1,0)+ IF( SELF.Diff_deceaseddate,1,0)+ IF( SELF.Diff_addressseq,1,0)+ IF( SELF.Diff_normaddress_address1,1,0)+ IF( SELF.Diff_normaddress_address2,1,0)+ IF( SELF.Diff_normaddress_city,1,0)+ IF( SELF.Diff_normaddress_state,1,0)+ IF( SELF.Diff_normaddress_zipcode,1,0)+ IF( SELF.Diff_normaddress_updateddate,1,0)+ IF( SELF.Diff_name,1,0)+ IF( SELF.Diff_nametype,1,0)+ IF( SELF.Diff_title,1,0)+ IF( SELF.Diff_fname,1,0)+ IF( SELF.Diff_mname,1,0)+ IF( SELF.Diff_lname,1,0)+ IF( SELF.Diff_name_suffix,1,0)+ IF( SELF.Diff_name_score,1,0)+ IF( SELF.Diff_prim_range,1,0)+ IF( SELF.Diff_predir,1,0)+ IF( SELF.Diff_prim_name,1,0)+ IF( SELF.Diff_addr_suffix,1,0)+ IF( SELF.Diff_postdir,1,0)+ IF( SELF.Diff_unit_desig,1,0)+ IF( SELF.Diff_sec_range,1,0)+ IF( SELF.Diff_p_city_name,1,0)+ IF( SELF.Diff_v_city_name,1,0)+ IF( SELF.Diff_st,1,0)+ IF( SELF.Diff_zip,1,0)+ IF( SELF.Diff_zip4,1,0)+ IF( SELF.Diff_cart,1,0)+ IF( SELF.Diff_cr_sort_sz,1,0)+ IF( SELF.Diff_lot,1,0)+ IF( SELF.Diff_lot_order,1,0)+ IF( SELF.Diff_dbpc,1,0)+ IF( SELF.Diff_chk_digit,1,0)+ IF( SELF.Diff_rec_type,1,0)+ IF( SELF.Diff_county,1,0)+ IF( SELF.Diff_geo_lat,1,0)+ IF( SELF.Diff_geo_long,1,0)+ IF( SELF.Diff_msa,1,0)+ IF( SELF.Diff_geo_blk,1,0)+ IF( SELF.Diff_geo_match,1,0)+ IF( SELF.Diff_err_stat,1,0)+ IF( SELF.Diff_transferdate_unformatted,1,0)+ IF( SELF.Diff_birthdate_unformatted,1,0)+ IF( SELF.Diff_dob_no_conflict,1,0)+ IF( SELF.Diff_updatedate_unformatted,1,0)+ IF( SELF.Diff_consumerupdatedate_unformatted,1,0)+ IF( SELF.Diff_filesincedate_unformatted,1,0)+ IF( SELF.Diff_compilationdate_unformatted,1,0)+ IF( SELF.Diff_ssn_unformatted,1,0)+ IF( SELF.Diff_ssn_no_conflict,1,0)+ IF( SELF.Diff_telephone_unformatted,1,0)+ IF( SELF.Diff_deceasedindicator,1,0)+ IF( SELF.Diff_did,1,0)+ IF( SELF.Diff_did_score_field,1,0)+ IF( SELF.Diff_is_current,1,0);
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
    Count_Diff_dt_first_seen := COUNT(GROUP,%Closest%.Diff_dt_first_seen);
    Count_Diff_dt_last_seen := COUNT(GROUP,%Closest%.Diff_dt_last_seen);
    Count_Diff_dt_vendor_first_reported := COUNT(GROUP,%Closest%.Diff_dt_vendor_first_reported);
    Count_Diff_dt_vendor_last_reported := COUNT(GROUP,%Closest%.Diff_dt_vendor_last_reported);
    Count_Diff_filetype := COUNT(GROUP,%Closest%.Diff_filetype);
    Count_Diff_filedate := COUNT(GROUP,%Closest%.Diff_filedate);
    Count_Diff_vendordocumentidentifier := COUNT(GROUP,%Closest%.Diff_vendordocumentidentifier);
    Count_Diff_transferdate := COUNT(GROUP,%Closest%.Diff_transferdate);
    Count_Diff_currentname_firstname := COUNT(GROUP,%Closest%.Diff_currentname_firstname);
    Count_Diff_currentname_middlename := COUNT(GROUP,%Closest%.Diff_currentname_middlename);
    Count_Diff_currentname_middleinitial := COUNT(GROUP,%Closest%.Diff_currentname_middleinitial);
    Count_Diff_currentname_lastname := COUNT(GROUP,%Closest%.Diff_currentname_lastname);
    Count_Diff_currentname_suffix := COUNT(GROUP,%Closest%.Diff_currentname_suffix);
    Count_Diff_currentname_gender := COUNT(GROUP,%Closest%.Diff_currentname_gender);
    Count_Diff_currentname_dob_mm := COUNT(GROUP,%Closest%.Diff_currentname_dob_mm);
    Count_Diff_currentname_dob_dd := COUNT(GROUP,%Closest%.Diff_currentname_dob_dd);
    Count_Diff_currentname_dob_yyyy := COUNT(GROUP,%Closest%.Diff_currentname_dob_yyyy);
    Count_Diff_currentname_deathindicator := COUNT(GROUP,%Closest%.Diff_currentname_deathindicator);
    Count_Diff_ssnfull := COUNT(GROUP,%Closest%.Diff_ssnfull);
    Count_Diff_ssnfirst5digit := COUNT(GROUP,%Closest%.Diff_ssnfirst5digit);
    Count_Diff_ssnlast4digit := COUNT(GROUP,%Closest%.Diff_ssnlast4digit);
    Count_Diff_consumerupdatedate := COUNT(GROUP,%Closest%.Diff_consumerupdatedate);
    Count_Diff_telephonenumber := COUNT(GROUP,%Closest%.Diff_telephonenumber);
    Count_Diff_citedid := COUNT(GROUP,%Closest%.Diff_citedid);
    Count_Diff_fileid := COUNT(GROUP,%Closest%.Diff_fileid);
    Count_Diff_publication := COUNT(GROUP,%Closest%.Diff_publication);
    Count_Diff_currentaddress_address1 := COUNT(GROUP,%Closest%.Diff_currentaddress_address1);
    Count_Diff_currentaddress_address2 := COUNT(GROUP,%Closest%.Diff_currentaddress_address2);
    Count_Diff_currentaddress_city := COUNT(GROUP,%Closest%.Diff_currentaddress_city);
    Count_Diff_currentaddress_state := COUNT(GROUP,%Closest%.Diff_currentaddress_state);
    Count_Diff_currentaddress_zipcode := COUNT(GROUP,%Closest%.Diff_currentaddress_zipcode);
    Count_Diff_currentaddress_updateddate := COUNT(GROUP,%Closest%.Diff_currentaddress_updateddate);
    Count_Diff_housenumber := COUNT(GROUP,%Closest%.Diff_housenumber);
    Count_Diff_streettype := COUNT(GROUP,%Closest%.Diff_streettype);
    Count_Diff_streetdirection := COUNT(GROUP,%Closest%.Diff_streetdirection);
    Count_Diff_streetname := COUNT(GROUP,%Closest%.Diff_streetname);
    Count_Diff_apartmentnumber := COUNT(GROUP,%Closest%.Diff_apartmentnumber);
    Count_Diff_city := COUNT(GROUP,%Closest%.Diff_city);
    Count_Diff_state := COUNT(GROUP,%Closest%.Diff_state);
    Count_Diff_zipcode := COUNT(GROUP,%Closest%.Diff_zipcode);
    Count_Diff_zip4u := COUNT(GROUP,%Closest%.Diff_zip4u);
    Count_Diff_previousaddress_address1 := COUNT(GROUP,%Closest%.Diff_previousaddress_address1);
    Count_Diff_previousaddress_address2 := COUNT(GROUP,%Closest%.Diff_previousaddress_address2);
    Count_Diff_previousaddress_city := COUNT(GROUP,%Closest%.Diff_previousaddress_city);
    Count_Diff_previousaddress_state := COUNT(GROUP,%Closest%.Diff_previousaddress_state);
    Count_Diff_previousaddress_zipcode := COUNT(GROUP,%Closest%.Diff_previousaddress_zipcode);
    Count_Diff_previousaddress_updateddate := COUNT(GROUP,%Closest%.Diff_previousaddress_updateddate);
    Count_Diff_formername_firstname := COUNT(GROUP,%Closest%.Diff_formername_firstname);
    Count_Diff_formername_middlename := COUNT(GROUP,%Closest%.Diff_formername_middlename);
    Count_Diff_formername_middleinitial := COUNT(GROUP,%Closest%.Diff_formername_middleinitial);
    Count_Diff_formername_lastname := COUNT(GROUP,%Closest%.Diff_formername_lastname);
    Count_Diff_formername_suffix := COUNT(GROUP,%Closest%.Diff_formername_suffix);
    Count_Diff_aliasname_firstname := COUNT(GROUP,%Closest%.Diff_aliasname_firstname);
    Count_Diff_aliasname_middlename := COUNT(GROUP,%Closest%.Diff_aliasname_middlename);
    Count_Diff_aliasname_middleinitial := COUNT(GROUP,%Closest%.Diff_aliasname_middleinitial);
    Count_Diff_aliasname_lastname := COUNT(GROUP,%Closest%.Diff_aliasname_lastname);
    Count_Diff_aliasname_suffix := COUNT(GROUP,%Closest%.Diff_aliasname_suffix);
    Count_Diff_additionalname_firstname := COUNT(GROUP,%Closest%.Diff_additionalname_firstname);
    Count_Diff_additionalname_middlename := COUNT(GROUP,%Closest%.Diff_additionalname_middlename);
    Count_Diff_additionalname_middleinitial := COUNT(GROUP,%Closest%.Diff_additionalname_middleinitial);
    Count_Diff_additionalname_lastname := COUNT(GROUP,%Closest%.Diff_additionalname_lastname);
    Count_Diff_additionalname_suffix := COUNT(GROUP,%Closest%.Diff_additionalname_suffix);
    Count_Diff_aka1 := COUNT(GROUP,%Closest%.Diff_aka1);
    Count_Diff_aka2 := COUNT(GROUP,%Closest%.Diff_aka2);
    Count_Diff_aka3 := COUNT(GROUP,%Closest%.Diff_aka3);
    Count_Diff_recordtype := COUNT(GROUP,%Closest%.Diff_recordtype);
    Count_Diff_addressstandardization := COUNT(GROUP,%Closest%.Diff_addressstandardization);
    Count_Diff_filesincedate := COUNT(GROUP,%Closest%.Diff_filesincedate);
    Count_Diff_compilationdate := COUNT(GROUP,%Closest%.Diff_compilationdate);
    Count_Diff_birthdateind := COUNT(GROUP,%Closest%.Diff_birthdateind);
    Count_Diff_orig_deceasedindicator := COUNT(GROUP,%Closest%.Diff_orig_deceasedindicator);
    Count_Diff_deceaseddate := COUNT(GROUP,%Closest%.Diff_deceaseddate);
    Count_Diff_addressseq := COUNT(GROUP,%Closest%.Diff_addressseq);
    Count_Diff_normaddress_address1 := COUNT(GROUP,%Closest%.Diff_normaddress_address1);
    Count_Diff_normaddress_address2 := COUNT(GROUP,%Closest%.Diff_normaddress_address2);
    Count_Diff_normaddress_city := COUNT(GROUP,%Closest%.Diff_normaddress_city);
    Count_Diff_normaddress_state := COUNT(GROUP,%Closest%.Diff_normaddress_state);
    Count_Diff_normaddress_zipcode := COUNT(GROUP,%Closest%.Diff_normaddress_zipcode);
    Count_Diff_normaddress_updateddate := COUNT(GROUP,%Closest%.Diff_normaddress_updateddate);
    Count_Diff_name := COUNT(GROUP,%Closest%.Diff_name);
    Count_Diff_nametype := COUNT(GROUP,%Closest%.Diff_nametype);
    Count_Diff_title := COUNT(GROUP,%Closest%.Diff_title);
    Count_Diff_fname := COUNT(GROUP,%Closest%.Diff_fname);
    Count_Diff_mname := COUNT(GROUP,%Closest%.Diff_mname);
    Count_Diff_lname := COUNT(GROUP,%Closest%.Diff_lname);
    Count_Diff_name_suffix := COUNT(GROUP,%Closest%.Diff_name_suffix);
    Count_Diff_name_score := COUNT(GROUP,%Closest%.Diff_name_score);
    Count_Diff_prim_range := COUNT(GROUP,%Closest%.Diff_prim_range);
    Count_Diff_predir := COUNT(GROUP,%Closest%.Diff_predir);
    Count_Diff_prim_name := COUNT(GROUP,%Closest%.Diff_prim_name);
    Count_Diff_addr_suffix := COUNT(GROUP,%Closest%.Diff_addr_suffix);
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
    Count_Diff_dbpc := COUNT(GROUP,%Closest%.Diff_dbpc);
    Count_Diff_chk_digit := COUNT(GROUP,%Closest%.Diff_chk_digit);
    Count_Diff_rec_type := COUNT(GROUP,%Closest%.Diff_rec_type);
    Count_Diff_county := COUNT(GROUP,%Closest%.Diff_county);
    Count_Diff_geo_lat := COUNT(GROUP,%Closest%.Diff_geo_lat);
    Count_Diff_geo_long := COUNT(GROUP,%Closest%.Diff_geo_long);
    Count_Diff_msa := COUNT(GROUP,%Closest%.Diff_msa);
    Count_Diff_geo_blk := COUNT(GROUP,%Closest%.Diff_geo_blk);
    Count_Diff_geo_match := COUNT(GROUP,%Closest%.Diff_geo_match);
    Count_Diff_err_stat := COUNT(GROUP,%Closest%.Diff_err_stat);
    Count_Diff_transferdate_unformatted := COUNT(GROUP,%Closest%.Diff_transferdate_unformatted);
    Count_Diff_birthdate_unformatted := COUNT(GROUP,%Closest%.Diff_birthdate_unformatted);
    Count_Diff_dob_no_conflict := COUNT(GROUP,%Closest%.Diff_dob_no_conflict);
    Count_Diff_updatedate_unformatted := COUNT(GROUP,%Closest%.Diff_updatedate_unformatted);
    Count_Diff_consumerupdatedate_unformatted := COUNT(GROUP,%Closest%.Diff_consumerupdatedate_unformatted);
    Count_Diff_filesincedate_unformatted := COUNT(GROUP,%Closest%.Diff_filesincedate_unformatted);
    Count_Diff_compilationdate_unformatted := COUNT(GROUP,%Closest%.Diff_compilationdate_unformatted);
    Count_Diff_ssn_unformatted := COUNT(GROUP,%Closest%.Diff_ssn_unformatted);
    Count_Diff_ssn_no_conflict := COUNT(GROUP,%Closest%.Diff_ssn_no_conflict);
    Count_Diff_telephone_unformatted := COUNT(GROUP,%Closest%.Diff_telephone_unformatted);
    Count_Diff_deceasedindicator := COUNT(GROUP,%Closest%.Diff_deceasedindicator);
    Count_Diff_did := COUNT(GROUP,%Closest%.Diff_did);
    Count_Diff_did_score_field := COUNT(GROUP,%Closest%.Diff_did_score_field);
    Count_Diff_is_current := COUNT(GROUP,%Closest%.Diff_is_current);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
