IMPORT SALT311;
EXPORT Fields := MODULE

EXPORT NumFields := 72;

// Processing for each FieldType
EXPORT SALT311.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'seq_rec_id','did','did_score_field','current_rec_flag','current_experian_pin','date_first_seen','date_last_seen','date_vendor_first_reported','date_vendor_last_reported','encrypted_experian_pin','social_security_number','date_of_birth','telephone','gender','additional_name_count','previous_address_count','nametype','orig_consumer_create_date','orig_fname','orig_mname','orig_lname','orig_suffix','title','fname','mname','lname','name_suffix','name_score','addressseq','orig_address_create_date','orig_address_update_date','orig_prim_range','orig_predir','orig_prim_name','orig_addr_suffix','orig_postdir','orig_unit_desig','orig_sec_range','orig_city','orig_state','orig_zipcode','orig_zipcode4','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dbpc','chk_digit','rec_type','county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','delete_flag','delete_file_date','suppression_code','deceased_ind');
EXPORT FieldTypeNum(SALT311.StrType fn) := CASE(fn,'seq_rec_id' => 1,'did' => 2,'did_score_field' => 3,'current_rec_flag' => 4,'current_experian_pin' => 5,'date_first_seen' => 6,'date_last_seen' => 7,'date_vendor_first_reported' => 8,'date_vendor_last_reported' => 9,'encrypted_experian_pin' => 10,'social_security_number' => 11,'date_of_birth' => 12,'telephone' => 13,'gender' => 14,'additional_name_count' => 15,'previous_address_count' => 16,'nametype' => 17,'orig_consumer_create_date' => 18,'orig_fname' => 19,'orig_mname' => 20,'orig_lname' => 21,'orig_suffix' => 22,'title' => 23,'fname' => 24,'mname' => 25,'lname' => 26,'name_suffix' => 27,'name_score' => 28,'addressseq' => 29,'orig_address_create_date' => 30,'orig_address_update_date' => 31,'orig_prim_range' => 32,'orig_predir' => 33,'orig_prim_name' => 34,'orig_addr_suffix' => 35,'orig_postdir' => 36,'orig_unit_desig' => 37,'orig_sec_range' => 38,'orig_city' => 39,'orig_state' => 40,'orig_zipcode' => 41,'orig_zipcode4' => 42,'prim_range' => 43,'predir' => 44,'prim_name' => 45,'addr_suffix' => 46,'postdir' => 47,'unit_desig' => 48,'sec_range' => 49,'p_city_name' => 50,'v_city_name' => 51,'st' => 52,'zip' => 53,'zip4' => 54,'cart' => 55,'cr_sort_sz' => 56,'lot' => 57,'lot_order' => 58,'dbpc' => 59,'chk_digit' => 60,'rec_type' => 61,'county' => 62,'geo_lat' => 63,'geo_long' => 64,'msa' => 65,'geo_blk' => 66,'geo_match' => 67,'err_stat' => 68,'delete_flag' => 69,'delete_file_date' => 70,'suppression_code' => 71,'deceased_ind' => 72,0);

EXPORT MakeFT_seq_rec_id(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_seq_rec_id(SALT311.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 9 OR LENGTH(TRIM(s)) = 8 OR LENGTH(TRIM(s)) = 7 OR LENGTH(TRIM(s)) = 6),~(SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_seq_rec_id(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLeft,SALT311.HygieneErrors.NotInChars('0123456789 '),SALT311.HygieneErrors.NotLength('9,8,7,6'),SALT311.HygieneErrors.NotWords('1'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_did(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_did(SALT311.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 10 OR LENGTH(TRIM(s)) = 9 OR LENGTH(TRIM(s)) = 12 OR LENGTH(TRIM(s)) = 11 OR LENGTH(TRIM(s)) = 8 OR LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 7),~(SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_did(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLeft,SALT311.HygieneErrors.NotInChars('0123456789 '),SALT311.HygieneErrors.NotLength('10,9,12,11,8,0,7'),SALT311.HygieneErrors.NotWords('1'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_did_score_field(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0189 '); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_did_score_field(SALT311.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0189 '))),~(LENGTH(TRIM(s)) = 3 OR LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 2),~(SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_did_score_field(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLeft,SALT311.HygieneErrors.NotInChars('0189 '),SALT311.HygieneErrors.NotLength('3,0,2'),SALT311.HygieneErrors.NotWords('1'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_current_rec_flag(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'1 '); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_current_rec_flag(SALT311.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'1 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 1),~(SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_current_rec_flag(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLeft,SALT311.HygieneErrors.NotInChars('1 '),SALT311.HygieneErrors.NotLength('0,1'),SALT311.HygieneErrors.NotWords('1'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_current_experian_pin(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'1 '); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_current_experian_pin(SALT311.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'1 '))),~(LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 0),~(SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_current_experian_pin(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLeft,SALT311.HygieneErrors.NotInChars('1 '),SALT311.HygieneErrors.NotLength('1,0'),SALT311.HygieneErrors.NotWords('1'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_date_first_seen(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_date_first_seen(SALT311.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 8 OR LENGTH(TRIM(s)) = 0),~(SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_date_first_seen(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLeft,SALT311.HygieneErrors.NotInChars('0123456789 '),SALT311.HygieneErrors.NotLength('8,0'),SALT311.HygieneErrors.NotWords('1'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_date_last_seen(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_date_last_seen(SALT311.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 8),~(SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_date_last_seen(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLeft,SALT311.HygieneErrors.NotInChars('0123456789 '),SALT311.HygieneErrors.NotLength('8'),SALT311.HygieneErrors.NotWords('1'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_date_vendor_first_reported(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_date_vendor_first_reported(SALT311.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 8),~(SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_date_vendor_first_reported(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLeft,SALT311.HygieneErrors.NotInChars('0123456789 '),SALT311.HygieneErrors.NotLength('8'),SALT311.HygieneErrors.NotWords('1'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_date_vendor_last_reported(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_date_vendor_last_reported(SALT311.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 8),~(SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_date_vendor_last_reported(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLeft,SALT311.HygieneErrors.NotInChars('0123456789 '),SALT311.HygieneErrors.NotLength('8'),SALT311.HygieneErrors.NotWords('1'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_encrypted_experian_pin(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_encrypted_experian_pin(SALT311.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ '))),~(LENGTH(TRIM(s)) = 15),~(SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_encrypted_experian_pin(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLeft,SALT311.HygieneErrors.NotInChars('0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT311.HygieneErrors.NotLength('15'),SALT311.HygieneErrors.NotWords('1'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_social_security_number(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_social_security_number(SALT311.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 9 OR LENGTH(TRIM(s)) = 0),~(SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_social_security_number(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLeft,SALT311.HygieneErrors.NotInChars('0123456789 '),SALT311.HygieneErrors.NotLength('9,0'),SALT311.HygieneErrors.NotWords('1'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_date_of_birth(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_date_of_birth(SALT311.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 8 OR LENGTH(TRIM(s)) = 0),~(SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_date_of_birth(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLeft,SALT311.HygieneErrors.NotInChars('0123456789 '),SALT311.HygieneErrors.NotLength('8,0'),SALT311.HygieneErrors.NotWords('1'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_telephone(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_telephone(SALT311.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 10),~(SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_telephone(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLeft,SALT311.HygieneErrors.NotInChars('0123456789 '),SALT311.HygieneErrors.NotLength('0,10'),SALT311.HygieneErrors.NotWords('1'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_gender(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ACFIMU '); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_gender(SALT311.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ACFIMU '))),~(LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 0),~(SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_gender(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLeft,SALT311.HygieneErrors.NotInChars('ACFIMU '),SALT311.HygieneErrors.NotLength('1,0'),SALT311.HygieneErrors.NotWords('1'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_additional_name_count(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123 '); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_additional_name_count(SALT311.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123 '))),~(LENGTH(TRIM(s)) = 2),~(SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_additional_name_count(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLeft,SALT311.HygieneErrors.NotInChars('0123 '),SALT311.HygieneErrors.NotLength('2'),SALT311.HygieneErrors.NotWords('1'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_previous_address_count(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'01234567 '); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_previous_address_count(SALT311.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'01234567 '))),~(LENGTH(TRIM(s)) = 2),~(SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_previous_address_count(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLeft,SALT311.HygieneErrors.NotInChars('01234567 '),SALT311.HygieneErrors.NotLength('2'),SALT311.HygieneErrors.NotWords('1'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_nametype(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'123COPS '); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_nametype(SALT311.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'123COPS '))),~(LENGTH(TRIM(s)) = 3 OR LENGTH(TRIM(s)) = 2),~(SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_nametype(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLeft,SALT311.HygieneErrors.NotInChars('123COPS '),SALT311.HygieneErrors.NotLength('3,2'),SALT311.HygieneErrors.NotWords('1'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_orig_consumer_create_date(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_consumer_create_date(SALT311.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 8 OR LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 0),~(SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_consumer_create_date(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLeft,SALT311.HygieneErrors.NotInChars('0123456789 '),SALT311.HygieneErrors.NotLength('8,1,0'),SALT311.HygieneErrors.NotWords('1'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_orig_fname(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWYZ '); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_fname(SALT311.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWYZ '))),~(LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 6 OR LENGTH(TRIM(s)) = 7 OR LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 8 OR LENGTH(TRIM(s)) = 9 OR LENGTH(TRIM(s)) = 3 OR LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 10 OR LENGTH(TRIM(s)) = 11 OR LENGTH(TRIM(s)) = 2),~(SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_fname(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLeft,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWYZ '),SALT311.HygieneErrors.NotLength('5,6,7,4,8,9,3,1,10,11,2'),SALT311.HygieneErrors.NotWords('1'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_orig_mname(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_mname(SALT311.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 6 OR LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 7 OR LENGTH(TRIM(s)) = 3 OR LENGTH(TRIM(s)) = 8 OR LENGTH(TRIM(s)) = 9 OR LENGTH(TRIM(s)) = 2),~(SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 0 OR SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_mname(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLeft,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT311.HygieneErrors.NotLength('0,1,5,6,4,7,3,8,9,2'),SALT311.HygieneErrors.NotWords('0,1'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_orig_lname(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_lname(SALT311.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ '))),~(LENGTH(TRIM(s)) = 6 OR LENGTH(TRIM(s)) = 7 OR LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 8 OR LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 9 OR LENGTH(TRIM(s)) = 10 OR LENGTH(TRIM(s)) = 3 OR LENGTH(TRIM(s)) = 11 OR LENGTH(TRIM(s)) = 12 OR LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 13 OR LENGTH(TRIM(s)) = 14 OR LENGTH(TRIM(s)) = 15),~(SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 1 OR SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 2));
EXPORT InValidMessageFT_orig_lname(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLeft,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT311.HygieneErrors.NotLength('6,7,5,8,4,9,10,3,11,12,2,13,14,15'),SALT311.HygieneErrors.NotWords('1,2'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_orig_suffix(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'234JS '); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_suffix(SALT311.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'234JS '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 1),~(SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_suffix(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLeft,SALT311.HygieneErrors.NotInChars('234JS '),SALT311.HygieneErrors.NotLength('0,1'),SALT311.HygieneErrors.NotWords('1'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_title(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'MRS '); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_title(SALT311.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'MRS '))),~(LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 0),~(SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 0 OR SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_title(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLeft,SALT311.HygieneErrors.NotInChars('MRS '),SALT311.HygieneErrors.NotLength('2,0'),SALT311.HygieneErrors.NotWords('0,1'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_fname(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_fname(SALT311.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ '))),~(LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 6 OR LENGTH(TRIM(s)) = 7 OR LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 8 OR LENGTH(TRIM(s)) = 9 OR LENGTH(TRIM(s)) = 3 OR LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 10 OR LENGTH(TRIM(s)) = 11 OR LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 0),~(SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_fname(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLeft,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT311.HygieneErrors.NotLength('5,6,7,4,8,9,3,1,10,11,2,0'),SALT311.HygieneErrors.NotWords('1'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_mname(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_mname(SALT311.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 6 OR LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 3 OR LENGTH(TRIM(s)) = 7 OR LENGTH(TRIM(s)) = 8 OR LENGTH(TRIM(s)) = 9 OR LENGTH(TRIM(s)) = 2),~(SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 0 OR SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_mname(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLeft,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT311.HygieneErrors.NotLength('0,1,5,6,4,3,7,8,9,2'),SALT311.HygieneErrors.NotWords('0,1'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_lname(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,' ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_lname(SALT311.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,' ABCDEFGHIJKLMNOPQRSTUVWXYZ '))),~(LENGTH(TRIM(s)) = 6 OR LENGTH(TRIM(s)) = 7 OR LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 8 OR LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 9 OR LENGTH(TRIM(s)) = 10 OR LENGTH(TRIM(s)) = 3 OR LENGTH(TRIM(s)) = 11 OR LENGTH(TRIM(s)) = 12 OR LENGTH(TRIM(s)) = 13 OR LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 14 OR LENGTH(TRIM(s)) = 15 OR LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 16 OR LENGTH(TRIM(s)) = 17 OR LENGTH(TRIM(s)) = 0),~(SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 1 OR SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 2));
EXPORT InValidMessageFT_lname(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLeft,SALT311.HygieneErrors.NotInChars(' ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT311.HygieneErrors.NotLength('6,7,5,8,4,9,10,3,11,12,13,2,14,15,1,16,17,0'),SALT311.HygieneErrors.NotWords('1,2'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_name_suffix(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,' ACDEGHIJLMNOPRSTUV '); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_name_suffix(SALT311.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,' ACDEGHIJLMNOPRSTUV '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 3),~(SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 0 OR SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_name_suffix(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLeft,SALT311.HygieneErrors.NotInChars(' ACDEGHIJLMNOPRSTUV '),SALT311.HygieneErrors.NotLength('0,2,3'),SALT311.HygieneErrors.NotWords('0,1'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_name_score(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'012789 '); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_name_score(SALT311.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'012789 '))),~(LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 3),~(SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_name_score(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLeft,SALT311.HygieneErrors.NotInChars('012789 '),SALT311.HygieneErrors.NotLength('2,3'),SALT311.HygieneErrors.NotWords('1'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_addressseq(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'12345678 '); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_addressseq(SALT311.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'12345678 '))),~(LENGTH(TRIM(s)) = 1),~(SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_addressseq(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLeft,SALT311.HygieneErrors.NotInChars('12345678 '),SALT311.HygieneErrors.NotLength('1'),SALT311.HygieneErrors.NotWords('1'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_orig_address_create_date(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_address_create_date(SALT311.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 8 OR LENGTH(TRIM(s)) = 5),~(SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_address_create_date(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLeft,SALT311.HygieneErrors.NotInChars('0123456789 '),SALT311.HygieneErrors.NotLength('8,5'),SALT311.HygieneErrors.NotWords('1'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_orig_address_update_date(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_address_update_date(SALT311.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 8),~(SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_address_update_date(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLeft,SALT311.HygieneErrors.NotInChars('0123456789 '),SALT311.HygieneErrors.NotLength('8'),SALT311.HygieneErrors.NotWords('1'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_orig_prim_range(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,' -/0123456789ABNW '); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_prim_range(SALT311.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,' -/0123456789ABNW '))),~(LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 3 OR LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 6 OR LENGTH(TRIM(s)) = 7 OR LENGTH(TRIM(s)) = 8),~(SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 1 OR SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 2));
EXPORT InValidMessageFT_orig_prim_range(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLeft,SALT311.HygieneErrors.NotInChars(' -/0123456789ABNW '),SALT311.HygieneErrors.NotLength('4,3,5,0,2,1,6,7,8'),SALT311.HygieneErrors.NotWords('1,2'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_orig_predir(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ENSW '); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_predir(SALT311.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ENSW '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 2),~(SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 0 OR SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_predir(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLeft,SALT311.HygieneErrors.NotInChars('ENSW '),SALT311.HygieneErrors.NotLength('0,1,2'),SALT311.HygieneErrors.NotWords('0,1'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_orig_prim_name(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,' 0123456789ABCDEFGHIJKLMNOPRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_prim_name(SALT311.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,' 0123456789ABCDEFGHIJKLMNOPRSTUVWXYZ '))),~(LENGTH(TRIM(s)) = 6 OR LENGTH(TRIM(s)) = 7 OR LENGTH(TRIM(s)) = 8 OR LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 10 OR LENGTH(TRIM(s)) = 9 OR LENGTH(TRIM(s)) = 11 OR LENGTH(TRIM(s)) = 12 OR LENGTH(TRIM(s)) = 3 OR LENGTH(TRIM(s)) = 13 OR LENGTH(TRIM(s)) = 14 OR LENGTH(TRIM(s)) = 15 OR LENGTH(TRIM(s)) = 16 OR LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 17 OR LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 18 OR LENGTH(TRIM(s)) = 19 OR LENGTH(TRIM(s)) = 20 OR LENGTH(TRIM(s)) = 21 OR LENGTH(TRIM(s)) = 22 OR LENGTH(TRIM(s)) = 23 OR LENGTH(TRIM(s)) = 24 OR LENGTH(TRIM(s)) = 25 OR LENGTH(TRIM(s)) = 26 OR LENGTH(TRIM(s)) = 27),~(SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 1 OR SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 2 OR SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 3 OR SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 4 OR SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 5 OR SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 6));
EXPORT InValidMessageFT_orig_prim_name(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLeft,SALT311.HygieneErrors.NotInChars(' 0123456789ABCDEFGHIJKLMNOPRSTUVWXYZ '),SALT311.HygieneErrors.NotLength('6,7,8,4,5,10,9,11,12,3,13,14,15,16,1,17,2,18,19,20,21,22,23,24,25,26,27'),SALT311.HygieneErrors.NotWords('1,2,3,4,5,6'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_orig_addr_suffix(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEGHIKLMNOPQRSTUVWXY '); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_addr_suffix(SALT311.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEGHIKLMNOPQRSTUVWXY '))),~(LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 3 OR LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 4),~(SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 0 OR SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_addr_suffix(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLeft,SALT311.HygieneErrors.NotInChars('ABCDEGHIKLMNOPQRSTUVWXY '),SALT311.HygieneErrors.NotLength('2,3,0,4'),SALT311.HygieneErrors.NotWords('0,1'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_orig_postdir(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ENSW '); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_postdir(SALT311.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ENSW '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 2),~(SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 0 OR SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_postdir(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLeft,SALT311.HygieneErrors.NotInChars('ENSW '),SALT311.HygieneErrors.NotLength('0,1,2'),SALT311.HygieneErrors.NotWords('0,1'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_orig_unit_desig(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'#ABCDEFGILMNOPRSTU '); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_unit_desig(SALT311.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'#ABCDEFGILMNOPRSTU '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 3 OR LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 2),~(SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 0 OR SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_unit_desig(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLeft,SALT311.HygieneErrors.NotInChars('#ABCDEFGILMNOPRSTU '),SALT311.HygieneErrors.NotLength('0,3,1,4,2'),SALT311.HygieneErrors.NotWords('0,1'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_orig_sec_range(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'-0123456789ABCDEFGHIJKLMNOPQRSTUVW '); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_sec_range(SALT311.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'-0123456789ABCDEFGHIJKLMNOPQRSTUVW '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 3 OR LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 6),~(SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 0 OR SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_sec_range(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLeft,SALT311.HygieneErrors.NotInChars('-0123456789ABCDEFGHIJKLMNOPQRSTUVW '),SALT311.HygieneErrors.NotLength('0,1,3,2,4,5,6'),SALT311.HygieneErrors.NotWords('0,1'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_orig_city(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,' ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_city(SALT311.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,' ABCDEFGHIJKLMNOPQRSTUVWXYZ '))),~(LENGTH(TRIM(s)) = 7 OR LENGTH(TRIM(s)) = 8 OR LENGTH(TRIM(s)) = 9 OR LENGTH(TRIM(s)) = 6 OR LENGTH(TRIM(s)) = 10 OR LENGTH(TRIM(s)) = 11 OR LENGTH(TRIM(s)) = 12 OR LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 13 OR LENGTH(TRIM(s)) = 14 OR LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 15 OR LENGTH(TRIM(s)) = 16 OR LENGTH(TRIM(s)) = 3 OR LENGTH(TRIM(s)) = 17 OR LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 18 OR LENGTH(TRIM(s)) = 19 OR LENGTH(TRIM(s)) = 20 OR LENGTH(TRIM(s)) = 22),~(SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 1 OR SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 2 OR SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 3));
EXPORT InValidMessageFT_orig_city(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLeft,SALT311.HygieneErrors.NotInChars(' ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT311.HygieneErrors.NotLength('7,8,9,6,10,11,12,5,13,14,4,15,16,3,17,0,18,19,20,22'),SALT311.HygieneErrors.NotWords('1,2,3'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_orig_state(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ACDEFGHIJKLMNOPRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_state(SALT311.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ACDEFGHIJKLMNOPRSTUVWXYZ '))),~(LENGTH(TRIM(s)) = 2),~(SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_state(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLeft,SALT311.HygieneErrors.NotInChars('ACDEFGHIJKLMNOPRSTUVWXYZ '),SALT311.HygieneErrors.NotLength('2'),SALT311.HygieneErrors.NotWords('1'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_orig_zipcode(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_zipcode(SALT311.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 5),~(SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_zipcode(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLeft,SALT311.HygieneErrors.NotInChars('0123456789 '),SALT311.HygieneErrors.NotLength('5'),SALT311.HygieneErrors.NotWords('1'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_orig_zipcode4(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_zipcode4(SALT311.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 0),~(SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 0 OR SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orig_zipcode4(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLeft,SALT311.HygieneErrors.NotInChars('0123456789 '),SALT311.HygieneErrors.NotLength('4,0'),SALT311.HygieneErrors.NotWords('0,1'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_prim_range(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,' -/0123456789ABNW '); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_prim_range(SALT311.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,' -/0123456789ABNW '))),~(LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 3 OR LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 6 OR LENGTH(TRIM(s)) = 7 OR LENGTH(TRIM(s)) = 8),~(SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 1 OR SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 2));
EXPORT InValidMessageFT_prim_range(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLeft,SALT311.HygieneErrors.NotInChars(' -/0123456789ABNW '),SALT311.HygieneErrors.NotLength('4,3,5,0,2,1,6,7,8'),SALT311.HygieneErrors.NotWords('1,2'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_predir(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ENSW '); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_predir(SALT311.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ENSW '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 2),~(SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 0 OR SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_predir(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLeft,SALT311.HygieneErrors.NotInChars('ENSW '),SALT311.HygieneErrors.NotLength('0,1,2'),SALT311.HygieneErrors.NotWords('0,1'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_prim_name(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,' 0123456789ABCDEFGHIJKLMNOPRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_prim_name(SALT311.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,' 0123456789ABCDEFGHIJKLMNOPRSTUVWXYZ '))),~(LENGTH(TRIM(s)) = 6 OR LENGTH(TRIM(s)) = 7 OR LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 8 OR LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 9 OR LENGTH(TRIM(s)) = 10 OR LENGTH(TRIM(s)) = 11 OR LENGTH(TRIM(s)) = 3 OR LENGTH(TRIM(s)) = 12 OR LENGTH(TRIM(s)) = 13 OR LENGTH(TRIM(s)) = 14 OR LENGTH(TRIM(s)) = 15 OR LENGTH(TRIM(s)) = 16 OR LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 17 OR LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 18 OR LENGTH(TRIM(s)) = 19 OR LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 20 OR LENGTH(TRIM(s)) = 21 OR LENGTH(TRIM(s)) = 22 OR LENGTH(TRIM(s)) = 23 OR LENGTH(TRIM(s)) = 24),~(SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 1 OR SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 2 OR SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 3 OR SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 4 OR SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 5));
EXPORT InValidMessageFT_prim_name(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLeft,SALT311.HygieneErrors.NotInChars(' 0123456789ABCDEFGHIJKLMNOPRSTUVWXYZ '),SALT311.HygieneErrors.NotLength('6,7,4,8,5,9,10,11,3,12,13,14,15,16,1,17,2,18,19,0,20,21,22,23,24'),SALT311.HygieneErrors.NotWords('1,2,3,4,5'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_addr_suffix(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEGHIKLMNOPQRSTUVWXY '); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_addr_suffix(SALT311.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEGHIKLMNOPQRSTUVWXY '))),~(LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 3 OR LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 4),~(SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 0 OR SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_addr_suffix(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLeft,SALT311.HygieneErrors.NotInChars('ABCDEGHIKLMNOPQRSTUVWXY '),SALT311.HygieneErrors.NotLength('2,3,0,4'),SALT311.HygieneErrors.NotWords('0,1'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_postdir(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ENSW '); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_postdir(SALT311.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ENSW '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 2),~(SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 0 OR SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_postdir(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLeft,SALT311.HygieneErrors.NotInChars('ENSW '),SALT311.HygieneErrors.NotLength('0,1,2'),SALT311.HygieneErrors.NotWords('0,1'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_unit_desig(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'#ABCDEFGILMNOPRSTUX '); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_unit_desig(SALT311.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'#ABCDEFGILMNOPRSTUX '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 3 OR LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 2),~(SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 0 OR SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_unit_desig(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLeft,SALT311.HygieneErrors.NotInChars('#ABCDEFGILMNOPRSTUX '),SALT311.HygieneErrors.NotLength('0,3,4,1,2'),SALT311.HygieneErrors.NotWords('0,1'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_sec_range(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'-0123456789ABCDEFGHIJKLMNOPQRSTUVW '); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_sec_range(SALT311.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'-0123456789ABCDEFGHIJKLMNOPQRSTUVW '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 3 OR LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 6),~(SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 0 OR SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_sec_range(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLeft,SALT311.HygieneErrors.NotInChars('-0123456789ABCDEFGHIJKLMNOPQRSTUVW '),SALT311.HygieneErrors.NotLength('0,3,1,2,4,5,6'),SALT311.HygieneErrors.NotWords('0,1'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_p_city_name(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,' ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_p_city_name(SALT311.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,' ABCDEFGHIJKLMNOPQRSTUVWXYZ '))),~(LENGTH(TRIM(s)) = 7 OR LENGTH(TRIM(s)) = 8 OR LENGTH(TRIM(s)) = 9 OR LENGTH(TRIM(s)) = 6 OR LENGTH(TRIM(s)) = 10 OR LENGTH(TRIM(s)) = 11 OR LENGTH(TRIM(s)) = 12 OR LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 13 OR LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 14 OR LENGTH(TRIM(s)) = 15 OR LENGTH(TRIM(s)) = 16 OR LENGTH(TRIM(s)) = 3 OR LENGTH(TRIM(s)) = 17 OR LENGTH(TRIM(s)) = 18 OR LENGTH(TRIM(s)) = 19 OR LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 20),~(SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 1 OR SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 2 OR SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 3));
EXPORT InValidMessageFT_p_city_name(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLeft,SALT311.HygieneErrors.NotInChars(' ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT311.HygieneErrors.NotLength('7,8,9,6,10,11,12,5,13,4,14,15,16,3,17,18,19,0,20'),SALT311.HygieneErrors.NotWords('1,2,3'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_v_city_name(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,' ABCDEFGHIJKLMNOPQRSTUVWXY '); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_v_city_name(SALT311.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,' ABCDEFGHIJKLMNOPQRSTUVWXY '))),~(LENGTH(TRIM(s)) = 7 OR LENGTH(TRIM(s)) = 8 OR LENGTH(TRIM(s)) = 9 OR LENGTH(TRIM(s)) = 6 OR LENGTH(TRIM(s)) = 10 OR LENGTH(TRIM(s)) = 11 OR LENGTH(TRIM(s)) = 12 OR LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 13 OR LENGTH(TRIM(s)) = 14 OR LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 16 OR LENGTH(TRIM(s)) = 15 OR LENGTH(TRIM(s)) = 3 OR LENGTH(TRIM(s)) = 17 OR LENGTH(TRIM(s)) = 18 OR LENGTH(TRIM(s)) = 19 OR LENGTH(TRIM(s)) = 20 OR LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 22),~(SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 1 OR SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 2 OR SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 3 OR SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 4));
EXPORT InValidMessageFT_v_city_name(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLeft,SALT311.HygieneErrors.NotInChars(' ABCDEFGHIJKLMNOPQRSTUVWXY '),SALT311.HygieneErrors.NotLength('7,8,9,6,10,11,12,5,13,14,4,16,15,3,17,18,19,20,0,22'),SALT311.HygieneErrors.NotWords('1,2,3,4'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_st(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ACDEFGHIJKLMNOPRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_st(SALT311.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ACDEFGHIJKLMNOPRSTUVWXYZ '))),~(LENGTH(TRIM(s)) = 2),~(SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_st(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLeft,SALT311.HygieneErrors.NotInChars('ACDEFGHIJKLMNOPRSTUVWXYZ '),SALT311.HygieneErrors.NotLength('2'),SALT311.HygieneErrors.NotWords('1'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_zip(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_zip(SALT311.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 5),~(SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_zip(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLeft,SALT311.HygieneErrors.NotInChars('0123456789 '),SALT311.HygieneErrors.NotLength('5'),SALT311.HygieneErrors.NotWords('1'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_zip4(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_zip4(SALT311.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 0),~(SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 0 OR SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_zip4(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLeft,SALT311.HygieneErrors.NotInChars('0123456789 '),SALT311.HygieneErrors.NotLength('4,0'),SALT311.HygieneErrors.NotWords('0,1'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_cart(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789BCHR '); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_cart(SALT311.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789BCHR '))),~(LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 0),~(SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_cart(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLeft,SALT311.HygieneErrors.NotInChars('0123456789BCHR '),SALT311.HygieneErrors.NotLength('4,0'),SALT311.HygieneErrors.NotWords('1'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_cr_sort_sz(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCD '); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_cr_sort_sz(SALT311.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCD '))),~(LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 0),~(SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_cr_sort_sz(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLeft,SALT311.HygieneErrors.NotInChars('ABCD '),SALT311.HygieneErrors.NotLength('1,0'),SALT311.HygieneErrors.NotWords('1'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_lot(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_lot(SALT311.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 0),~(SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_lot(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLeft,SALT311.HygieneErrors.NotInChars('0123456789 '),SALT311.HygieneErrors.NotLength('4,0'),SALT311.HygieneErrors.NotWords('1'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_lot_order(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'AD '); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_lot_order(SALT311.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'AD '))),~(LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 0),~(SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_lot_order(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLeft,SALT311.HygieneErrors.NotInChars('AD '),SALT311.HygieneErrors.NotLength('1,0'),SALT311.HygieneErrors.NotWords('1'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_dbpc(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_dbpc(SALT311.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 0),~(SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_dbpc(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLeft,SALT311.HygieneErrors.NotInChars('0123456789 '),SALT311.HygieneErrors.NotLength('2,0'),SALT311.HygieneErrors.NotWords('1'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_chk_digit(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_chk_digit(SALT311.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 0),~(SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_chk_digit(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLeft,SALT311.HygieneErrors.NotInChars('0123456789 '),SALT311.HygieneErrors.NotLength('1,0'),SALT311.HygieneErrors.NotWords('1'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_rec_type(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'DFGHMPRSU '); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_rec_type(SALT311.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'DFGHMPRSU '))),~(LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 2),~(SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_rec_type(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLeft,SALT311.HygieneErrors.NotInChars('DFGHMPRSU '),SALT311.HygieneErrors.NotLength('1,2'),SALT311.HygieneErrors.NotWords('1'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_county(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_county(SALT311.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 2),~(SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_county(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLeft,SALT311.HygieneErrors.NotInChars('0123456789 '),SALT311.HygieneErrors.NotLength('5,0,2'),SALT311.HygieneErrors.NotWords('1'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_geo_lat(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'.0123456789 '); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_geo_lat(SALT311.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'.0123456789 '))),~(LENGTH(TRIM(s)) = 9 OR LENGTH(TRIM(s)) = 0),~(SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_geo_lat(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLeft,SALT311.HygieneErrors.NotInChars('.0123456789 '),SALT311.HygieneErrors.NotLength('9,0'),SALT311.HygieneErrors.NotWords('1'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_geo_long(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'-.0123456789 '); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_geo_long(SALT311.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'-.0123456789 '))),~(LENGTH(TRIM(s)) = 10 OR LENGTH(TRIM(s)) = 11 OR LENGTH(TRIM(s)) = 0),~(SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_geo_long(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLeft,SALT311.HygieneErrors.NotInChars('-.0123456789 '),SALT311.HygieneErrors.NotLength('10,11,0'),SALT311.HygieneErrors.NotWords('1'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_msa(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_msa(SALT311.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 0),~(SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_msa(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLeft,SALT311.HygieneErrors.NotInChars('0123456789 '),SALT311.HygieneErrors.NotLength('4,0'),SALT311.HygieneErrors.NotWords('1'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_geo_blk(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_geo_blk(SALT311.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 7 OR LENGTH(TRIM(s)) = 0),~(SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_geo_blk(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLeft,SALT311.HygieneErrors.NotInChars('0123456789 '),SALT311.HygieneErrors.NotLength('7,0'),SALT311.HygieneErrors.NotWords('1'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_geo_match(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0145 '); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_geo_match(SALT311.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0145 '))),~(LENGTH(TRIM(s)) = 1),~(SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_geo_match(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLeft,SALT311.HygieneErrors.NotInChars('0145 '),SALT311.HygieneErrors.NotLength('1'),SALT311.HygieneErrors.NotWords('1'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_err_stat(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'01234589ABES '); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_err_stat(SALT311.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'01234589ABES '))),~(LENGTH(TRIM(s)) = 4),~(SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_err_stat(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLeft,SALT311.HygieneErrors.NotInChars('01234589ABES '),SALT311.HygieneErrors.NotLength('4'),SALT311.HygieneErrors.NotWords('1'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_delete_flag(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'1 '); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_delete_flag(SALT311.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'1 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 1),~(SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_delete_flag(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLeft,SALT311.HygieneErrors.NotInChars('1 '),SALT311.HygieneErrors.NotLength('0,1'),SALT311.HygieneErrors.NotWords('1'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_delete_file_date(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123567 '); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_delete_file_date(SALT311.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123567 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 7),~(SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_delete_file_date(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLeft,SALT311.HygieneErrors.NotInChars('0123567 '),SALT311.HygieneErrors.NotLength('0,7'),SALT311.HygieneErrors.NotWords('1'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_suppression_code(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0459 '); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_suppression_code(SALT311.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0459 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 2),~(SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_suppression_code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLeft,SALT311.HygieneErrors.NotInChars('0459 '),SALT311.HygieneErrors.NotLength('0,2'),SALT311.HygieneErrors.NotWords('1'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_deceased_ind(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'01 '); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_deceased_ind(SALT311.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'01 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 1),~(SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_deceased_ind(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLeft,SALT311.HygieneErrors.NotInChars('01 '),SALT311.HygieneErrors.NotLength('0,1'),SALT311.HygieneErrors.NotWords('1'),SALT311.HygieneErrors.Good);


EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'seq_rec_id','did','did_score_field','current_rec_flag','current_experian_pin','date_first_seen','date_last_seen','date_vendor_first_reported','date_vendor_last_reported','encrypted_experian_pin','social_security_number','date_of_birth','telephone','gender','additional_name_count','previous_address_count','nametype','orig_consumer_create_date','orig_fname','orig_mname','orig_lname','orig_suffix','title','fname','mname','lname','name_suffix','name_score','addressseq','orig_address_create_date','orig_address_update_date','orig_prim_range','orig_predir','orig_prim_name','orig_addr_suffix','orig_postdir','orig_unit_desig','orig_sec_range','orig_city','orig_state','orig_zipcode','orig_zipcode4','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dbpc','chk_digit','rec_type','county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','delete_flag','delete_file_date','suppression_code','deceased_ind');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'seq_rec_id','did','did_score_field','current_rec_flag','current_experian_pin','date_first_seen','date_last_seen','date_vendor_first_reported','date_vendor_last_reported','encrypted_experian_pin','social_security_number','date_of_birth','telephone','gender','additional_name_count','previous_address_count','nametype','orig_consumer_create_date','orig_fname','orig_mname','orig_lname','orig_suffix','title','fname','mname','lname','name_suffix','name_score','addressseq','orig_address_create_date','orig_address_update_date','orig_prim_range','orig_predir','orig_prim_name','orig_addr_suffix','orig_postdir','orig_unit_desig','orig_sec_range','orig_city','orig_state','orig_zipcode','orig_zipcode4','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dbpc','chk_digit','rec_type','county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','delete_flag','delete_file_date','suppression_code','deceased_ind');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'seq_rec_id' => 0,'did' => 1,'did_score_field' => 2,'current_rec_flag' => 3,'current_experian_pin' => 4,'date_first_seen' => 5,'date_last_seen' => 6,'date_vendor_first_reported' => 7,'date_vendor_last_reported' => 8,'encrypted_experian_pin' => 9,'social_security_number' => 10,'date_of_birth' => 11,'telephone' => 12,'gender' => 13,'additional_name_count' => 14,'previous_address_count' => 15,'nametype' => 16,'orig_consumer_create_date' => 17,'orig_fname' => 18,'orig_mname' => 19,'orig_lname' => 20,'orig_suffix' => 21,'title' => 22,'fname' => 23,'mname' => 24,'lname' => 25,'name_suffix' => 26,'name_score' => 27,'addressseq' => 28,'orig_address_create_date' => 29,'orig_address_update_date' => 30,'orig_prim_range' => 31,'orig_predir' => 32,'orig_prim_name' => 33,'orig_addr_suffix' => 34,'orig_postdir' => 35,'orig_unit_desig' => 36,'orig_sec_range' => 37,'orig_city' => 38,'orig_state' => 39,'orig_zipcode' => 40,'orig_zipcode4' => 41,'prim_range' => 42,'predir' => 43,'prim_name' => 44,'addr_suffix' => 45,'postdir' => 46,'unit_desig' => 47,'sec_range' => 48,'p_city_name' => 49,'v_city_name' => 50,'st' => 51,'zip' => 52,'zip4' => 53,'cart' => 54,'cr_sort_sz' => 55,'lot' => 56,'lot_order' => 57,'dbpc' => 58,'chk_digit' => 59,'rec_type' => 60,'county' => 61,'geo_lat' => 62,'geo_long' => 63,'msa' => 64,'geo_blk' => 65,'geo_match' => 66,'err_stat' => 67,'delete_flag' => 68,'delete_file_date' => 69,'suppression_code' => 70,'deceased_ind' => 71,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);

//Individual field level validation


EXPORT Make_seq_rec_id(SALT311.StrType s0) := MakeFT_seq_rec_id(s0);
EXPORT InValid_seq_rec_id(SALT311.StrType s) := InValidFT_seq_rec_id(s);
EXPORT InValidMessage_seq_rec_id(UNSIGNED1 wh) := InValidMessageFT_seq_rec_id(wh);


EXPORT Make_did(SALT311.StrType s0) := MakeFT_did(s0);
EXPORT InValid_did(SALT311.StrType s) := InValidFT_did(s);
EXPORT InValidMessage_did(UNSIGNED1 wh) := InValidMessageFT_did(wh);


EXPORT Make_did_score_field(SALT311.StrType s0) := MakeFT_did_score_field(s0);
EXPORT InValid_did_score_field(SALT311.StrType s) := InValidFT_did_score_field(s);
EXPORT InValidMessage_did_score_field(UNSIGNED1 wh) := InValidMessageFT_did_score_field(wh);


EXPORT Make_current_rec_flag(SALT311.StrType s0) := MakeFT_current_rec_flag(s0);
EXPORT InValid_current_rec_flag(SALT311.StrType s) := InValidFT_current_rec_flag(s);
EXPORT InValidMessage_current_rec_flag(UNSIGNED1 wh) := InValidMessageFT_current_rec_flag(wh);


EXPORT Make_current_experian_pin(SALT311.StrType s0) := MakeFT_current_experian_pin(s0);
EXPORT InValid_current_experian_pin(SALT311.StrType s) := InValidFT_current_experian_pin(s);
EXPORT InValidMessage_current_experian_pin(UNSIGNED1 wh) := InValidMessageFT_current_experian_pin(wh);


EXPORT Make_date_first_seen(SALT311.StrType s0) := MakeFT_date_first_seen(s0);
EXPORT InValid_date_first_seen(SALT311.StrType s) := InValidFT_date_first_seen(s);
EXPORT InValidMessage_date_first_seen(UNSIGNED1 wh) := InValidMessageFT_date_first_seen(wh);


EXPORT Make_date_last_seen(SALT311.StrType s0) := MakeFT_date_last_seen(s0);
EXPORT InValid_date_last_seen(SALT311.StrType s) := InValidFT_date_last_seen(s);
EXPORT InValidMessage_date_last_seen(UNSIGNED1 wh) := InValidMessageFT_date_last_seen(wh);


EXPORT Make_date_vendor_first_reported(SALT311.StrType s0) := MakeFT_date_vendor_first_reported(s0);
EXPORT InValid_date_vendor_first_reported(SALT311.StrType s) := InValidFT_date_vendor_first_reported(s);
EXPORT InValidMessage_date_vendor_first_reported(UNSIGNED1 wh) := InValidMessageFT_date_vendor_first_reported(wh);


EXPORT Make_date_vendor_last_reported(SALT311.StrType s0) := MakeFT_date_vendor_last_reported(s0);
EXPORT InValid_date_vendor_last_reported(SALT311.StrType s) := InValidFT_date_vendor_last_reported(s);
EXPORT InValidMessage_date_vendor_last_reported(UNSIGNED1 wh) := InValidMessageFT_date_vendor_last_reported(wh);


EXPORT Make_encrypted_experian_pin(SALT311.StrType s0) := MakeFT_encrypted_experian_pin(s0);
EXPORT InValid_encrypted_experian_pin(SALT311.StrType s) := InValidFT_encrypted_experian_pin(s);
EXPORT InValidMessage_encrypted_experian_pin(UNSIGNED1 wh) := InValidMessageFT_encrypted_experian_pin(wh);


EXPORT Make_social_security_number(SALT311.StrType s0) := MakeFT_social_security_number(s0);
EXPORT InValid_social_security_number(SALT311.StrType s) := InValidFT_social_security_number(s);
EXPORT InValidMessage_social_security_number(UNSIGNED1 wh) := InValidMessageFT_social_security_number(wh);


EXPORT Make_date_of_birth(SALT311.StrType s0) := MakeFT_date_of_birth(s0);
EXPORT InValid_date_of_birth(SALT311.StrType s) := InValidFT_date_of_birth(s);
EXPORT InValidMessage_date_of_birth(UNSIGNED1 wh) := InValidMessageFT_date_of_birth(wh);


EXPORT Make_telephone(SALT311.StrType s0) := MakeFT_telephone(s0);
EXPORT InValid_telephone(SALT311.StrType s) := InValidFT_telephone(s);
EXPORT InValidMessage_telephone(UNSIGNED1 wh) := InValidMessageFT_telephone(wh);


EXPORT Make_gender(SALT311.StrType s0) := MakeFT_gender(s0);
EXPORT InValid_gender(SALT311.StrType s) := InValidFT_gender(s);
EXPORT InValidMessage_gender(UNSIGNED1 wh) := InValidMessageFT_gender(wh);


EXPORT Make_additional_name_count(SALT311.StrType s0) := MakeFT_additional_name_count(s0);
EXPORT InValid_additional_name_count(SALT311.StrType s) := InValidFT_additional_name_count(s);
EXPORT InValidMessage_additional_name_count(UNSIGNED1 wh) := InValidMessageFT_additional_name_count(wh);


EXPORT Make_previous_address_count(SALT311.StrType s0) := MakeFT_previous_address_count(s0);
EXPORT InValid_previous_address_count(SALT311.StrType s) := InValidFT_previous_address_count(s);
EXPORT InValidMessage_previous_address_count(UNSIGNED1 wh) := InValidMessageFT_previous_address_count(wh);


EXPORT Make_nametype(SALT311.StrType s0) := MakeFT_nametype(s0);
EXPORT InValid_nametype(SALT311.StrType s) := InValidFT_nametype(s);
EXPORT InValidMessage_nametype(UNSIGNED1 wh) := InValidMessageFT_nametype(wh);


EXPORT Make_orig_consumer_create_date(SALT311.StrType s0) := MakeFT_orig_consumer_create_date(s0);
EXPORT InValid_orig_consumer_create_date(SALT311.StrType s) := InValidFT_orig_consumer_create_date(s);
EXPORT InValidMessage_orig_consumer_create_date(UNSIGNED1 wh) := InValidMessageFT_orig_consumer_create_date(wh);


EXPORT Make_orig_fname(SALT311.StrType s0) := MakeFT_orig_fname(s0);
EXPORT InValid_orig_fname(SALT311.StrType s) := InValidFT_orig_fname(s);
EXPORT InValidMessage_orig_fname(UNSIGNED1 wh) := InValidMessageFT_orig_fname(wh);


EXPORT Make_orig_mname(SALT311.StrType s0) := MakeFT_orig_mname(s0);
EXPORT InValid_orig_mname(SALT311.StrType s) := InValidFT_orig_mname(s);
EXPORT InValidMessage_orig_mname(UNSIGNED1 wh) := InValidMessageFT_orig_mname(wh);


EXPORT Make_orig_lname(SALT311.StrType s0) := MakeFT_orig_lname(s0);
EXPORT InValid_orig_lname(SALT311.StrType s) := InValidFT_orig_lname(s);
EXPORT InValidMessage_orig_lname(UNSIGNED1 wh) := InValidMessageFT_orig_lname(wh);


EXPORT Make_orig_suffix(SALT311.StrType s0) := MakeFT_orig_suffix(s0);
EXPORT InValid_orig_suffix(SALT311.StrType s) := InValidFT_orig_suffix(s);
EXPORT InValidMessage_orig_suffix(UNSIGNED1 wh) := InValidMessageFT_orig_suffix(wh);


EXPORT Make_title(SALT311.StrType s0) := MakeFT_title(s0);
EXPORT InValid_title(SALT311.StrType s) := InValidFT_title(s);
EXPORT InValidMessage_title(UNSIGNED1 wh) := InValidMessageFT_title(wh);


EXPORT Make_fname(SALT311.StrType s0) := MakeFT_fname(s0);
EXPORT InValid_fname(SALT311.StrType s) := InValidFT_fname(s);
EXPORT InValidMessage_fname(UNSIGNED1 wh) := InValidMessageFT_fname(wh);


EXPORT Make_mname(SALT311.StrType s0) := MakeFT_mname(s0);
EXPORT InValid_mname(SALT311.StrType s) := InValidFT_mname(s);
EXPORT InValidMessage_mname(UNSIGNED1 wh) := InValidMessageFT_mname(wh);


EXPORT Make_lname(SALT311.StrType s0) := MakeFT_lname(s0);
EXPORT InValid_lname(SALT311.StrType s) := InValidFT_lname(s);
EXPORT InValidMessage_lname(UNSIGNED1 wh) := InValidMessageFT_lname(wh);


EXPORT Make_name_suffix(SALT311.StrType s0) := MakeFT_name_suffix(s0);
EXPORT InValid_name_suffix(SALT311.StrType s) := InValidFT_name_suffix(s);
EXPORT InValidMessage_name_suffix(UNSIGNED1 wh) := InValidMessageFT_name_suffix(wh);


EXPORT Make_name_score(SALT311.StrType s0) := MakeFT_name_score(s0);
EXPORT InValid_name_score(SALT311.StrType s) := InValidFT_name_score(s);
EXPORT InValidMessage_name_score(UNSIGNED1 wh) := InValidMessageFT_name_score(wh);


EXPORT Make_addressseq(SALT311.StrType s0) := MakeFT_addressseq(s0);
EXPORT InValid_addressseq(SALT311.StrType s) := InValidFT_addressseq(s);
EXPORT InValidMessage_addressseq(UNSIGNED1 wh) := InValidMessageFT_addressseq(wh);


EXPORT Make_orig_address_create_date(SALT311.StrType s0) := MakeFT_orig_address_create_date(s0);
EXPORT InValid_orig_address_create_date(SALT311.StrType s) := InValidFT_orig_address_create_date(s);
EXPORT InValidMessage_orig_address_create_date(UNSIGNED1 wh) := InValidMessageFT_orig_address_create_date(wh);


EXPORT Make_orig_address_update_date(SALT311.StrType s0) := MakeFT_orig_address_update_date(s0);
EXPORT InValid_orig_address_update_date(SALT311.StrType s) := InValidFT_orig_address_update_date(s);
EXPORT InValidMessage_orig_address_update_date(UNSIGNED1 wh) := InValidMessageFT_orig_address_update_date(wh);


EXPORT Make_orig_prim_range(SALT311.StrType s0) := MakeFT_orig_prim_range(s0);
EXPORT InValid_orig_prim_range(SALT311.StrType s) := InValidFT_orig_prim_range(s);
EXPORT InValidMessage_orig_prim_range(UNSIGNED1 wh) := InValidMessageFT_orig_prim_range(wh);


EXPORT Make_orig_predir(SALT311.StrType s0) := MakeFT_orig_predir(s0);
EXPORT InValid_orig_predir(SALT311.StrType s) := InValidFT_orig_predir(s);
EXPORT InValidMessage_orig_predir(UNSIGNED1 wh) := InValidMessageFT_orig_predir(wh);


EXPORT Make_orig_prim_name(SALT311.StrType s0) := MakeFT_orig_prim_name(s0);
EXPORT InValid_orig_prim_name(SALT311.StrType s) := InValidFT_orig_prim_name(s);
EXPORT InValidMessage_orig_prim_name(UNSIGNED1 wh) := InValidMessageFT_orig_prim_name(wh);


EXPORT Make_orig_addr_suffix(SALT311.StrType s0) := MakeFT_orig_addr_suffix(s0);
EXPORT InValid_orig_addr_suffix(SALT311.StrType s) := InValidFT_orig_addr_suffix(s);
EXPORT InValidMessage_orig_addr_suffix(UNSIGNED1 wh) := InValidMessageFT_orig_addr_suffix(wh);


EXPORT Make_orig_postdir(SALT311.StrType s0) := MakeFT_orig_postdir(s0);
EXPORT InValid_orig_postdir(SALT311.StrType s) := InValidFT_orig_postdir(s);
EXPORT InValidMessage_orig_postdir(UNSIGNED1 wh) := InValidMessageFT_orig_postdir(wh);


EXPORT Make_orig_unit_desig(SALT311.StrType s0) := MakeFT_orig_unit_desig(s0);
EXPORT InValid_orig_unit_desig(SALT311.StrType s) := InValidFT_orig_unit_desig(s);
EXPORT InValidMessage_orig_unit_desig(UNSIGNED1 wh) := InValidMessageFT_orig_unit_desig(wh);


EXPORT Make_orig_sec_range(SALT311.StrType s0) := MakeFT_orig_sec_range(s0);
EXPORT InValid_orig_sec_range(SALT311.StrType s) := InValidFT_orig_sec_range(s);
EXPORT InValidMessage_orig_sec_range(UNSIGNED1 wh) := InValidMessageFT_orig_sec_range(wh);


EXPORT Make_orig_city(SALT311.StrType s0) := MakeFT_orig_city(s0);
EXPORT InValid_orig_city(SALT311.StrType s) := InValidFT_orig_city(s);
EXPORT InValidMessage_orig_city(UNSIGNED1 wh) := InValidMessageFT_orig_city(wh);


EXPORT Make_orig_state(SALT311.StrType s0) := MakeFT_orig_state(s0);
EXPORT InValid_orig_state(SALT311.StrType s) := InValidFT_orig_state(s);
EXPORT InValidMessage_orig_state(UNSIGNED1 wh) := InValidMessageFT_orig_state(wh);


EXPORT Make_orig_zipcode(SALT311.StrType s0) := MakeFT_orig_zipcode(s0);
EXPORT InValid_orig_zipcode(SALT311.StrType s) := InValidFT_orig_zipcode(s);
EXPORT InValidMessage_orig_zipcode(UNSIGNED1 wh) := InValidMessageFT_orig_zipcode(wh);


EXPORT Make_orig_zipcode4(SALT311.StrType s0) := MakeFT_orig_zipcode4(s0);
EXPORT InValid_orig_zipcode4(SALT311.StrType s) := InValidFT_orig_zipcode4(s);
EXPORT InValidMessage_orig_zipcode4(UNSIGNED1 wh) := InValidMessageFT_orig_zipcode4(wh);


EXPORT Make_prim_range(SALT311.StrType s0) := MakeFT_prim_range(s0);
EXPORT InValid_prim_range(SALT311.StrType s) := InValidFT_prim_range(s);
EXPORT InValidMessage_prim_range(UNSIGNED1 wh) := InValidMessageFT_prim_range(wh);


EXPORT Make_predir(SALT311.StrType s0) := MakeFT_predir(s0);
EXPORT InValid_predir(SALT311.StrType s) := InValidFT_predir(s);
EXPORT InValidMessage_predir(UNSIGNED1 wh) := InValidMessageFT_predir(wh);


EXPORT Make_prim_name(SALT311.StrType s0) := MakeFT_prim_name(s0);
EXPORT InValid_prim_name(SALT311.StrType s) := InValidFT_prim_name(s);
EXPORT InValidMessage_prim_name(UNSIGNED1 wh) := InValidMessageFT_prim_name(wh);


EXPORT Make_addr_suffix(SALT311.StrType s0) := MakeFT_addr_suffix(s0);
EXPORT InValid_addr_suffix(SALT311.StrType s) := InValidFT_addr_suffix(s);
EXPORT InValidMessage_addr_suffix(UNSIGNED1 wh) := InValidMessageFT_addr_suffix(wh);


EXPORT Make_postdir(SALT311.StrType s0) := MakeFT_postdir(s0);
EXPORT InValid_postdir(SALT311.StrType s) := InValidFT_postdir(s);
EXPORT InValidMessage_postdir(UNSIGNED1 wh) := InValidMessageFT_postdir(wh);


EXPORT Make_unit_desig(SALT311.StrType s0) := MakeFT_unit_desig(s0);
EXPORT InValid_unit_desig(SALT311.StrType s) := InValidFT_unit_desig(s);
EXPORT InValidMessage_unit_desig(UNSIGNED1 wh) := InValidMessageFT_unit_desig(wh);


EXPORT Make_sec_range(SALT311.StrType s0) := MakeFT_sec_range(s0);
EXPORT InValid_sec_range(SALT311.StrType s) := InValidFT_sec_range(s);
EXPORT InValidMessage_sec_range(UNSIGNED1 wh) := InValidMessageFT_sec_range(wh);


EXPORT Make_p_city_name(SALT311.StrType s0) := MakeFT_p_city_name(s0);
EXPORT InValid_p_city_name(SALT311.StrType s) := InValidFT_p_city_name(s);
EXPORT InValidMessage_p_city_name(UNSIGNED1 wh) := InValidMessageFT_p_city_name(wh);


EXPORT Make_v_city_name(SALT311.StrType s0) := MakeFT_v_city_name(s0);
EXPORT InValid_v_city_name(SALT311.StrType s) := InValidFT_v_city_name(s);
EXPORT InValidMessage_v_city_name(UNSIGNED1 wh) := InValidMessageFT_v_city_name(wh);


EXPORT Make_st(SALT311.StrType s0) := MakeFT_st(s0);
EXPORT InValid_st(SALT311.StrType s) := InValidFT_st(s);
EXPORT InValidMessage_st(UNSIGNED1 wh) := InValidMessageFT_st(wh);


EXPORT Make_zip(SALT311.StrType s0) := MakeFT_zip(s0);
EXPORT InValid_zip(SALT311.StrType s) := InValidFT_zip(s);
EXPORT InValidMessage_zip(UNSIGNED1 wh) := InValidMessageFT_zip(wh);


EXPORT Make_zip4(SALT311.StrType s0) := MakeFT_zip4(s0);
EXPORT InValid_zip4(SALT311.StrType s) := InValidFT_zip4(s);
EXPORT InValidMessage_zip4(UNSIGNED1 wh) := InValidMessageFT_zip4(wh);


EXPORT Make_cart(SALT311.StrType s0) := MakeFT_cart(s0);
EXPORT InValid_cart(SALT311.StrType s) := InValidFT_cart(s);
EXPORT InValidMessage_cart(UNSIGNED1 wh) := InValidMessageFT_cart(wh);


EXPORT Make_cr_sort_sz(SALT311.StrType s0) := MakeFT_cr_sort_sz(s0);
EXPORT InValid_cr_sort_sz(SALT311.StrType s) := InValidFT_cr_sort_sz(s);
EXPORT InValidMessage_cr_sort_sz(UNSIGNED1 wh) := InValidMessageFT_cr_sort_sz(wh);


EXPORT Make_lot(SALT311.StrType s0) := MakeFT_lot(s0);
EXPORT InValid_lot(SALT311.StrType s) := InValidFT_lot(s);
EXPORT InValidMessage_lot(UNSIGNED1 wh) := InValidMessageFT_lot(wh);


EXPORT Make_lot_order(SALT311.StrType s0) := MakeFT_lot_order(s0);
EXPORT InValid_lot_order(SALT311.StrType s) := InValidFT_lot_order(s);
EXPORT InValidMessage_lot_order(UNSIGNED1 wh) := InValidMessageFT_lot_order(wh);


EXPORT Make_dbpc(SALT311.StrType s0) := MakeFT_dbpc(s0);
EXPORT InValid_dbpc(SALT311.StrType s) := InValidFT_dbpc(s);
EXPORT InValidMessage_dbpc(UNSIGNED1 wh) := InValidMessageFT_dbpc(wh);


EXPORT Make_chk_digit(SALT311.StrType s0) := MakeFT_chk_digit(s0);
EXPORT InValid_chk_digit(SALT311.StrType s) := InValidFT_chk_digit(s);
EXPORT InValidMessage_chk_digit(UNSIGNED1 wh) := InValidMessageFT_chk_digit(wh);


EXPORT Make_rec_type(SALT311.StrType s0) := MakeFT_rec_type(s0);
EXPORT InValid_rec_type(SALT311.StrType s) := InValidFT_rec_type(s);
EXPORT InValidMessage_rec_type(UNSIGNED1 wh) := InValidMessageFT_rec_type(wh);


EXPORT Make_county(SALT311.StrType s0) := MakeFT_county(s0);
EXPORT InValid_county(SALT311.StrType s) := InValidFT_county(s);
EXPORT InValidMessage_county(UNSIGNED1 wh) := InValidMessageFT_county(wh);


EXPORT Make_geo_lat(SALT311.StrType s0) := MakeFT_geo_lat(s0);
EXPORT InValid_geo_lat(SALT311.StrType s) := InValidFT_geo_lat(s);
EXPORT InValidMessage_geo_lat(UNSIGNED1 wh) := InValidMessageFT_geo_lat(wh);


EXPORT Make_geo_long(SALT311.StrType s0) := MakeFT_geo_long(s0);
EXPORT InValid_geo_long(SALT311.StrType s) := InValidFT_geo_long(s);
EXPORT InValidMessage_geo_long(UNSIGNED1 wh) := InValidMessageFT_geo_long(wh);


EXPORT Make_msa(SALT311.StrType s0) := MakeFT_msa(s0);
EXPORT InValid_msa(SALT311.StrType s) := InValidFT_msa(s);
EXPORT InValidMessage_msa(UNSIGNED1 wh) := InValidMessageFT_msa(wh);


EXPORT Make_geo_blk(SALT311.StrType s0) := MakeFT_geo_blk(s0);
EXPORT InValid_geo_blk(SALT311.StrType s) := InValidFT_geo_blk(s);
EXPORT InValidMessage_geo_blk(UNSIGNED1 wh) := InValidMessageFT_geo_blk(wh);


EXPORT Make_geo_match(SALT311.StrType s0) := MakeFT_geo_match(s0);
EXPORT InValid_geo_match(SALT311.StrType s) := InValidFT_geo_match(s);
EXPORT InValidMessage_geo_match(UNSIGNED1 wh) := InValidMessageFT_geo_match(wh);


EXPORT Make_err_stat(SALT311.StrType s0) := MakeFT_err_stat(s0);
EXPORT InValid_err_stat(SALT311.StrType s) := InValidFT_err_stat(s);
EXPORT InValidMessage_err_stat(UNSIGNED1 wh) := InValidMessageFT_err_stat(wh);


EXPORT Make_delete_flag(SALT311.StrType s0) := MakeFT_delete_flag(s0);
EXPORT InValid_delete_flag(SALT311.StrType s) := InValidFT_delete_flag(s);
EXPORT InValidMessage_delete_flag(UNSIGNED1 wh) := InValidMessageFT_delete_flag(wh);


EXPORT Make_delete_file_date(SALT311.StrType s0) := MakeFT_delete_file_date(s0);
EXPORT InValid_delete_file_date(SALT311.StrType s) := InValidFT_delete_file_date(s);
EXPORT InValidMessage_delete_file_date(UNSIGNED1 wh) := InValidMessageFT_delete_file_date(wh);


EXPORT Make_suppression_code(SALT311.StrType s0) := MakeFT_suppression_code(s0);
EXPORT InValid_suppression_code(SALT311.StrType s) := InValidFT_suppression_code(s);
EXPORT InValidMessage_suppression_code(UNSIGNED1 wh) := InValidMessageFT_suppression_code(wh);


EXPORT Make_deceased_ind(SALT311.StrType s0) := MakeFT_deceased_ind(s0);
EXPORT InValid_deceased_ind(SALT311.StrType s) := InValidFT_deceased_ind(s);
EXPORT InValidMessage_deceased_ind(UNSIGNED1 wh) := InValidMessageFT_deceased_ind(wh);

// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT311,Scrubs_Experian_Monthly;
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
    BOOLEAN Diff_seq_rec_id;
    BOOLEAN Diff_did;
    BOOLEAN Diff_did_score_field;
    BOOLEAN Diff_current_rec_flag;
    BOOLEAN Diff_current_experian_pin;
    BOOLEAN Diff_date_first_seen;
    BOOLEAN Diff_date_last_seen;
    BOOLEAN Diff_date_vendor_first_reported;
    BOOLEAN Diff_date_vendor_last_reported;
    BOOLEAN Diff_encrypted_experian_pin;
    BOOLEAN Diff_social_security_number;
    BOOLEAN Diff_date_of_birth;
    BOOLEAN Diff_telephone;
    BOOLEAN Diff_gender;
    BOOLEAN Diff_additional_name_count;
    BOOLEAN Diff_previous_address_count;
    BOOLEAN Diff_nametype;
    BOOLEAN Diff_orig_consumer_create_date;
    BOOLEAN Diff_orig_fname;
    BOOLEAN Diff_orig_mname;
    BOOLEAN Diff_orig_lname;
    BOOLEAN Diff_orig_suffix;
    BOOLEAN Diff_title;
    BOOLEAN Diff_fname;
    BOOLEAN Diff_mname;
    BOOLEAN Diff_lname;
    BOOLEAN Diff_name_suffix;
    BOOLEAN Diff_name_score;
    BOOLEAN Diff_addressseq;
    BOOLEAN Diff_orig_address_create_date;
    BOOLEAN Diff_orig_address_update_date;
    BOOLEAN Diff_orig_prim_range;
    BOOLEAN Diff_orig_predir;
    BOOLEAN Diff_orig_prim_name;
    BOOLEAN Diff_orig_addr_suffix;
    BOOLEAN Diff_orig_postdir;
    BOOLEAN Diff_orig_unit_desig;
    BOOLEAN Diff_orig_sec_range;
    BOOLEAN Diff_orig_city;
    BOOLEAN Diff_orig_state;
    BOOLEAN Diff_orig_zipcode;
    BOOLEAN Diff_orig_zipcode4;
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
    BOOLEAN Diff_delete_flag;
    BOOLEAN Diff_delete_file_date;
    BOOLEAN Diff_suppression_code;
    BOOLEAN Diff_deceased_ind;
    UNSIGNED Num_Diffs;
    SALT311.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_seq_rec_id := le.seq_rec_id <> ri.seq_rec_id;
    SELF.Diff_did := le.did <> ri.did;
    SELF.Diff_did_score_field := le.did_score_field <> ri.did_score_field;
    SELF.Diff_current_rec_flag := le.current_rec_flag <> ri.current_rec_flag;
    SELF.Diff_current_experian_pin := le.current_experian_pin <> ri.current_experian_pin;
    SELF.Diff_date_first_seen := le.date_first_seen <> ri.date_first_seen;
    SELF.Diff_date_last_seen := le.date_last_seen <> ri.date_last_seen;
    SELF.Diff_date_vendor_first_reported := le.date_vendor_first_reported <> ri.date_vendor_first_reported;
    SELF.Diff_date_vendor_last_reported := le.date_vendor_last_reported <> ri.date_vendor_last_reported;
    SELF.Diff_encrypted_experian_pin := le.encrypted_experian_pin <> ri.encrypted_experian_pin;
    SELF.Diff_social_security_number := le.social_security_number <> ri.social_security_number;
    SELF.Diff_date_of_birth := le.date_of_birth <> ri.date_of_birth;
    SELF.Diff_telephone := le.telephone <> ri.telephone;
    SELF.Diff_gender := le.gender <> ri.gender;
    SELF.Diff_additional_name_count := le.additional_name_count <> ri.additional_name_count;
    SELF.Diff_previous_address_count := le.previous_address_count <> ri.previous_address_count;
    SELF.Diff_nametype := le.nametype <> ri.nametype;
    SELF.Diff_orig_consumer_create_date := le.orig_consumer_create_date <> ri.orig_consumer_create_date;
    SELF.Diff_orig_fname := le.orig_fname <> ri.orig_fname;
    SELF.Diff_orig_mname := le.orig_mname <> ri.orig_mname;
    SELF.Diff_orig_lname := le.orig_lname <> ri.orig_lname;
    SELF.Diff_orig_suffix := le.orig_suffix <> ri.orig_suffix;
    SELF.Diff_title := le.title <> ri.title;
    SELF.Diff_fname := le.fname <> ri.fname;
    SELF.Diff_mname := le.mname <> ri.mname;
    SELF.Diff_lname := le.lname <> ri.lname;
    SELF.Diff_name_suffix := le.name_suffix <> ri.name_suffix;
    SELF.Diff_name_score := le.name_score <> ri.name_score;
    SELF.Diff_addressseq := le.addressseq <> ri.addressseq;
    SELF.Diff_orig_address_create_date := le.orig_address_create_date <> ri.orig_address_create_date;
    SELF.Diff_orig_address_update_date := le.orig_address_update_date <> ri.orig_address_update_date;
    SELF.Diff_orig_prim_range := le.orig_prim_range <> ri.orig_prim_range;
    SELF.Diff_orig_predir := le.orig_predir <> ri.orig_predir;
    SELF.Diff_orig_prim_name := le.orig_prim_name <> ri.orig_prim_name;
    SELF.Diff_orig_addr_suffix := le.orig_addr_suffix <> ri.orig_addr_suffix;
    SELF.Diff_orig_postdir := le.orig_postdir <> ri.orig_postdir;
    SELF.Diff_orig_unit_desig := le.orig_unit_desig <> ri.orig_unit_desig;
    SELF.Diff_orig_sec_range := le.orig_sec_range <> ri.orig_sec_range;
    SELF.Diff_orig_city := le.orig_city <> ri.orig_city;
    SELF.Diff_orig_state := le.orig_state <> ri.orig_state;
    SELF.Diff_orig_zipcode := le.orig_zipcode <> ri.orig_zipcode;
    SELF.Diff_orig_zipcode4 := le.orig_zipcode4 <> ri.orig_zipcode4;
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
    SELF.Diff_delete_flag := le.delete_flag <> ri.delete_flag;
    SELF.Diff_delete_file_date := le.delete_file_date <> ri.delete_file_date;
    SELF.Diff_suppression_code := le.suppression_code <> ri.suppression_code;
    SELF.Diff_deceased_ind := le.deceased_ind <> ri.deceased_ind;
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_seq_rec_id,1,0)+ IF( SELF.Diff_did,1,0)+ IF( SELF.Diff_did_score_field,1,0)+ IF( SELF.Diff_current_rec_flag,1,0)+ IF( SELF.Diff_current_experian_pin,1,0)+ IF( SELF.Diff_date_first_seen,1,0)+ IF( SELF.Diff_date_last_seen,1,0)+ IF( SELF.Diff_date_vendor_first_reported,1,0)+ IF( SELF.Diff_date_vendor_last_reported,1,0)+ IF( SELF.Diff_encrypted_experian_pin,1,0)+ IF( SELF.Diff_social_security_number,1,0)+ IF( SELF.Diff_date_of_birth,1,0)+ IF( SELF.Diff_telephone,1,0)+ IF( SELF.Diff_gender,1,0)+ IF( SELF.Diff_additional_name_count,1,0)+ IF( SELF.Diff_previous_address_count,1,0)+ IF( SELF.Diff_nametype,1,0)+ IF( SELF.Diff_orig_consumer_create_date,1,0)+ IF( SELF.Diff_orig_fname,1,0)+ IF( SELF.Diff_orig_mname,1,0)+ IF( SELF.Diff_orig_lname,1,0)+ IF( SELF.Diff_orig_suffix,1,0)+ IF( SELF.Diff_title,1,0)+ IF( SELF.Diff_fname,1,0)+ IF( SELF.Diff_mname,1,0)+ IF( SELF.Diff_lname,1,0)+ IF( SELF.Diff_name_suffix,1,0)+ IF( SELF.Diff_name_score,1,0)+ IF( SELF.Diff_addressseq,1,0)+ IF( SELF.Diff_orig_address_create_date,1,0)+ IF( SELF.Diff_orig_address_update_date,1,0)+ IF( SELF.Diff_orig_prim_range,1,0)+ IF( SELF.Diff_orig_predir,1,0)+ IF( SELF.Diff_orig_prim_name,1,0)+ IF( SELF.Diff_orig_addr_suffix,1,0)+ IF( SELF.Diff_orig_postdir,1,0)+ IF( SELF.Diff_orig_unit_desig,1,0)+ IF( SELF.Diff_orig_sec_range,1,0)+ IF( SELF.Diff_orig_city,1,0)+ IF( SELF.Diff_orig_state,1,0)+ IF( SELF.Diff_orig_zipcode,1,0)+ IF( SELF.Diff_orig_zipcode4,1,0)+ IF( SELF.Diff_prim_range,1,0)+ IF( SELF.Diff_predir,1,0)+ IF( SELF.Diff_prim_name,1,0)+ IF( SELF.Diff_addr_suffix,1,0)+ IF( SELF.Diff_postdir,1,0)+ IF( SELF.Diff_unit_desig,1,0)+ IF( SELF.Diff_sec_range,1,0)+ IF( SELF.Diff_p_city_name,1,0)+ IF( SELF.Diff_v_city_name,1,0)+ IF( SELF.Diff_st,1,0)+ IF( SELF.Diff_zip,1,0)+ IF( SELF.Diff_zip4,1,0)+ IF( SELF.Diff_cart,1,0)+ IF( SELF.Diff_cr_sort_sz,1,0)+ IF( SELF.Diff_lot,1,0)+ IF( SELF.Diff_lot_order,1,0)+ IF( SELF.Diff_dbpc,1,0)+ IF( SELF.Diff_chk_digit,1,0)+ IF( SELF.Diff_rec_type,1,0)+ IF( SELF.Diff_county,1,0)+ IF( SELF.Diff_geo_lat,1,0)+ IF( SELF.Diff_geo_long,1,0)+ IF( SELF.Diff_msa,1,0)+ IF( SELF.Diff_geo_blk,1,0)+ IF( SELF.Diff_geo_match,1,0)+ IF( SELF.Diff_err_stat,1,0)+ IF( SELF.Diff_delete_flag,1,0)+ IF( SELF.Diff_delete_file_date,1,0)+ IF( SELF.Diff_suppression_code,1,0)+ IF( SELF.Diff_deceased_ind,1,0);
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
    Count_Diff_seq_rec_id := COUNT(GROUP,%Closest%.Diff_seq_rec_id);
    Count_Diff_did := COUNT(GROUP,%Closest%.Diff_did);
    Count_Diff_did_score_field := COUNT(GROUP,%Closest%.Diff_did_score_field);
    Count_Diff_current_rec_flag := COUNT(GROUP,%Closest%.Diff_current_rec_flag);
    Count_Diff_current_experian_pin := COUNT(GROUP,%Closest%.Diff_current_experian_pin);
    Count_Diff_date_first_seen := COUNT(GROUP,%Closest%.Diff_date_first_seen);
    Count_Diff_date_last_seen := COUNT(GROUP,%Closest%.Diff_date_last_seen);
    Count_Diff_date_vendor_first_reported := COUNT(GROUP,%Closest%.Diff_date_vendor_first_reported);
    Count_Diff_date_vendor_last_reported := COUNT(GROUP,%Closest%.Diff_date_vendor_last_reported);
    Count_Diff_encrypted_experian_pin := COUNT(GROUP,%Closest%.Diff_encrypted_experian_pin);
    Count_Diff_social_security_number := COUNT(GROUP,%Closest%.Diff_social_security_number);
    Count_Diff_date_of_birth := COUNT(GROUP,%Closest%.Diff_date_of_birth);
    Count_Diff_telephone := COUNT(GROUP,%Closest%.Diff_telephone);
    Count_Diff_gender := COUNT(GROUP,%Closest%.Diff_gender);
    Count_Diff_additional_name_count := COUNT(GROUP,%Closest%.Diff_additional_name_count);
    Count_Diff_previous_address_count := COUNT(GROUP,%Closest%.Diff_previous_address_count);
    Count_Diff_nametype := COUNT(GROUP,%Closest%.Diff_nametype);
    Count_Diff_orig_consumer_create_date := COUNT(GROUP,%Closest%.Diff_orig_consumer_create_date);
    Count_Diff_orig_fname := COUNT(GROUP,%Closest%.Diff_orig_fname);
    Count_Diff_orig_mname := COUNT(GROUP,%Closest%.Diff_orig_mname);
    Count_Diff_orig_lname := COUNT(GROUP,%Closest%.Diff_orig_lname);
    Count_Diff_orig_suffix := COUNT(GROUP,%Closest%.Diff_orig_suffix);
    Count_Diff_title := COUNT(GROUP,%Closest%.Diff_title);
    Count_Diff_fname := COUNT(GROUP,%Closest%.Diff_fname);
    Count_Diff_mname := COUNT(GROUP,%Closest%.Diff_mname);
    Count_Diff_lname := COUNT(GROUP,%Closest%.Diff_lname);
    Count_Diff_name_suffix := COUNT(GROUP,%Closest%.Diff_name_suffix);
    Count_Diff_name_score := COUNT(GROUP,%Closest%.Diff_name_score);
    Count_Diff_addressseq := COUNT(GROUP,%Closest%.Diff_addressseq);
    Count_Diff_orig_address_create_date := COUNT(GROUP,%Closest%.Diff_orig_address_create_date);
    Count_Diff_orig_address_update_date := COUNT(GROUP,%Closest%.Diff_orig_address_update_date);
    Count_Diff_orig_prim_range := COUNT(GROUP,%Closest%.Diff_orig_prim_range);
    Count_Diff_orig_predir := COUNT(GROUP,%Closest%.Diff_orig_predir);
    Count_Diff_orig_prim_name := COUNT(GROUP,%Closest%.Diff_orig_prim_name);
    Count_Diff_orig_addr_suffix := COUNT(GROUP,%Closest%.Diff_orig_addr_suffix);
    Count_Diff_orig_postdir := COUNT(GROUP,%Closest%.Diff_orig_postdir);
    Count_Diff_orig_unit_desig := COUNT(GROUP,%Closest%.Diff_orig_unit_desig);
    Count_Diff_orig_sec_range := COUNT(GROUP,%Closest%.Diff_orig_sec_range);
    Count_Diff_orig_city := COUNT(GROUP,%Closest%.Diff_orig_city);
    Count_Diff_orig_state := COUNT(GROUP,%Closest%.Diff_orig_state);
    Count_Diff_orig_zipcode := COUNT(GROUP,%Closest%.Diff_orig_zipcode);
    Count_Diff_orig_zipcode4 := COUNT(GROUP,%Closest%.Diff_orig_zipcode4);
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
    Count_Diff_delete_flag := COUNT(GROUP,%Closest%.Diff_delete_flag);
    Count_Diff_delete_file_date := COUNT(GROUP,%Closest%.Diff_delete_file_date);
    Count_Diff_suppression_code := COUNT(GROUP,%Closest%.Diff_suppression_code);
    Count_Diff_deceased_ind := COUNT(GROUP,%Closest%.Diff_deceased_ind);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
